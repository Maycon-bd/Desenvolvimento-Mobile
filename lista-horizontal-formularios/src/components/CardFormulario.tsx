import React, { useState } from 'react';

const CardFormulario: React.FC = () => {
    const [nomeCompleto, setNomeCompleto] = useState('');
    const [dataNascimento, setDataNascimento] = useState('');
    const [sexo, setSexo] = useState('Homem');

    const handleNomeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setNomeCompleto(e.target.value);
    };

    const handleDataChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setDataNascimento(e.target.value);
    };

    const handleSexoChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
        setSexo(e.target.value);
    };

    return (
        <div className="card-formulario">
            <input
                type="text"
                placeholder="Nome Completo"
                value={nomeCompleto}
                onChange={handleNomeChange}
            />
            <input
                type="date"
                value={dataNascimento}
                onChange={handleDataChange}
            />
            <select value={sexo} onChange={handleSexoChange}>
                <option value="Homem">Homem</option>
                <option value="Mulher">Mulher</option>
            </select>
        </div>
    );
};

export default CardFormulario;