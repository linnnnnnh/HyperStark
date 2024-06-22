import { memo, SVGProps } from 'react';

const VectorIcon3 = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 776 537' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      fillRule='evenodd'
      clipRule='evenodd'
      d='M378.572 5.99848C434.36 -6.05358 497.943 0.0662415 546.994 24.2606C596.248 48.5551 608.435 98.8128 642.28 136.071C686.335 184.57 772.585 216.613 775.884 276.235C779.141 335.102 713.375 382.744 658.12 422.358C607.083 458.948 540.723 474.078 475.459 491.62C407.251 509.954 329.385 557.494 268.494 527.083C202.3 494.024 247.361 402.589 199.358 353.728C155.818 309.41 49.6476 322.266 17.9587 272.07C-13.2319 222.663 -3.81155 149.828 46.359 111.374C99.2163 70.8609 192.17 107.83 260.531 86.1462C309.684 70.5553 327.479 17.0364 378.572 5.99848Z'
      fill='#F2A55F'
      fillOpacity={0.5}
    />
  </svg>
);

const Memo = memo(VectorIcon3);
export { Memo as VectorIcon3 };
