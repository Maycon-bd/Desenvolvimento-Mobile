import React from 'react';
import CardFormulario from './CardFormulario';
import './ListaHorizontal.css'; // Importando um arquivo CSS para estilização

const ListaHorizontal: React.FC = () => {
    const [currentIndex, setCurrentIndex] = React.useState(0);
    const cardsData = [
        { id: 1, nome: '', dataNascimento: '', sexo: '' },
        { id: 2, nome: '', dataNascimento: '', sexo: '' },
        { id: 3, nome: '', dataNascimento: '', sexo: '' },
    ];

    const handleNext = () => {
        setCurrentIndex((prevIndex) => (prevIndex + 1) % cardsData.length);
    };

    const handlePrev = () => {
        setCurrentIndex((prevIndex) => (prevIndex - 1 + cardsData.length) % cardsData.length);
    };

    return (
        <div className="lista-horizontal">
            <button onClick={handlePrev}>&lt;</button>
            <div className="card-container">
                {cardsData.map((card, index) => (
                    index === currentIndex && (
                        <CardFormulario key={card.id} />
                    )
                ))}
            </div>
            <button onClick={handleNext}>&gt;</button>
        </div>
    );
};

export default ListaHorizontal;