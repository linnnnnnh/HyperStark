import { memo, SVGProps } from 'react';

const VectorIcon4 = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 31 33' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      d='M30.9117 3.00422L26.2336 31.008C25.8806 32.9844 24.9602 33.4763 23.6523 32.5452L16.5244 25.8781L13.0851 30.0769C12.7045 30.56 12.3861 30.9641 11.6526 30.9641L12.1647 21.7495L25.3755 6.59692C25.9498 5.9469 25.2509 5.58675 24.4827 6.23677L8.15094 19.29L1.11995 16.4966C-0.409425 15.8905 -0.437107 14.5553 1.43828 13.6242L28.9394 0.175735C30.2127 -0.430369 31.3269 0.535883 30.9117 3.00422V3.00422Z'
      fill='url(#paint0_linear_180_121)'
    />
    <defs>
      <linearGradient id='paint0_linear_180_121' x1={0} y1={16.5} x2={31} y2={16.5} gradientUnits='userSpaceOnUse'>
        <stop stopColor='#F2A55F' />
        <stop offset={1} stopColor='#914F13' />
      </linearGradient>
    </defs>
  </svg>
);

const Memo = memo(VectorIcon4);
export { Memo as VectorIcon4 };
