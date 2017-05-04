From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH libdrm 1/1] amdgpu: update marketing names
Date: Thu, 4 May 2017 17:04:42 +0200
Message-ID: <3b023313-63c3-7d67-359c-8cfe32e18cd7@dev.carbon-project.org>
References: <1493851169-6190-1-git-send-email-Samuel.Li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1343339689=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493851169-6190-1-git-send-email-Samuel.Li-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1343339689==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vW6K2NWuNDcTt87MF6dl9wb3D3T1iO8vh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vW6K2NWuNDcTt87MF6dl9wb3D3T1iO8vh
Content-Type: multipart/mixed; boundary="2MOcm6mSA3Nr7wG7SXKEqsV55090X1UmN";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Message-ID: <3b023313-63c3-7d67-359c-8cfe32e18cd7-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH libdrm 1/1] amdgpu: update marketing names
References: <1493851169-6190-1-git-send-email-Samuel.Li-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1493851169-6190-1-git-send-email-Samuel.Li-5C7GfCeVMHo@public.gmane.org>

--2MOcm6mSA3Nr7wG7SXKEqsV55090X1UmN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Samuel,
Samuel Li wrote on 04.05.2017 00:39:
> Change-Id: Ia0aff9dba5889f0c9006923236da1b2adc907f1a
> Signed-off-by: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
> ---
>  amdgpu/amdgpu_asic_id.h | 146 +++++++++++++++++++++++++++++-----------=
--------
>  1 file changed, 87 insertions(+), 59 deletions(-)
>=20
> diff --git a/amdgpu/amdgpu_asic_id.h b/amdgpu/amdgpu_asic_id.h
> index 3e7d736..6237193 100644
> --- a/amdgpu/amdgpu_asic_id.h
> +++ b/amdgpu/amdgpu_asic_id.h
> @@ -31,99 +31,124 @@ static struct amdgpu_asic_id_table_t {
>  	const char *marketing_name;
>  } const amdgpu_asic_id_table [] =3D {
>  	{0x6600,	0x0,	"AMD Radeon HD 8600/8700M"},
> -	{0x6600,	0x81,	"AMD Radeon R7 M370"},
> -	{0x6601,	0x0,	"AMD Radeon HD 8500M/8700M"},
> +	{0x6600,	0x81,	"AMD Radeon (TM) R7 M370"},
> +	{0x6601,	0x0,	"AMD Radeon (TM) HD 8500M/8700M"},

would it be possible to drop the "(TM)" additions? a) they are not consis=
tently
added and b) I do not see what value the "(TM)" would offer in recognisin=
g a
particular GPU.

The same applies to the instances below.

>  	{0x6604,	0x0,	"AMD Radeon R7 M265 Series"},
> -	{0x6604,	0x81,	"AMD Radeon R7 M350"},
> +	{0x6604,	0x81,	"AMD Radeon (TM) R7 M350"},
>  	{0x6605,	0x0,	"AMD Radeon R7 M260 Series"},
> -	{0x6605,	0x81,	"AMD Radeon R7 M340"},
> +	{0x6605,	0x81,	"AMD Radeon (TM) R7 M340"},
>  	{0x6606,	0x0,	"AMD Radeon HD 8790M"},
> -	{0x6607,	0x0,	"AMD Radeon HD8530M"},
> +	{0x6607,	0x0,	"AMD Radeon (TM) HD8530M"},
>  	{0x6608,	0x0,	"AMD FirePro W2100"},
>  	{0x6610,	0x0,	"AMD Radeon HD 8600 Series"},
> -	{0x6610,	0x81,	"AMD Radeon R7 350"},
> -	{0x6610,	0x83,	"AMD Radeon R5 340"},
> +	{0x6610,	0x81,	"AMD Radeon (TM) R7 350"},
> +	{0x6610,	0x83,	"AMD Radeon (TM) R5 340"},
>  	{0x6611,	0x0,	"AMD Radeon HD 8500 Series"},
>  	{0x6613,	0x0,	"AMD Radeon HD 8500 series"},
>  	{0x6617,	0xC7,	"AMD Radeon R7 240 Series"},
>  	{0x6640,	0x0,	"AMD Radeon HD 8950"},
> -	{0x6640,	0x80,	"AMD Radeon R9 M380"},
> +	{0x6640,	0x80,	"AMD Radeon (TM) R9 M380"},
>  	{0x6646,	0x0,	"AMD Radeon R9 M280X"},
> -	{0x6646,	0x80,	"AMD Radeon R9 M470X"},
> +	{0x6646,	0x80,	"AMD Radeon (TM) R9 M470X"},
>  	{0x6647,	0x0,	"AMD Radeon R9 M270X"},
> -	{0x6647,	0x80,	"AMD Radeon R9 M380"},
> +	{0x6647,	0x80,	"AMD Radeon (TM) R9 M380"},
>  	{0x6649,	0x0,	"AMD FirePro W5100"},
>  	{0x6658,	0x0,	"AMD Radeon R7 200 Series"},
>  	{0x665C,	0x0,	"AMD Radeon HD 7700 Series"},
>  	{0x665D,	0x0,	"AMD Radeon R7 200 Series"},
> -	{0x665F,	0x81,	"AMD Radeon R7 300 Series"},
> +	{0x665F,	0x81,	"AMD Radeon (TM) R7 300 Series"},
>  	{0x6660,	0x0,	"AMD Radeon HD 8600M Series"},
> -	{0x6660,	0x81,	"AMD Radeon R5 M335"},
> -	{0x6660,	0x83,	"AMD Radeon R5 M330"},
> +	{0x6660,	0x81,	"AMD Radeon (TM) R5 M335"},
> +	{0x6660,	0x83,	"AMD Radeon (TM) R5 M430"},
>  	{0x6663,	0x0,	"AMD Radeon HD 8500M Series"},
> -	{0x6663,	0x83,	"AMD Radeon R5 M320"},
> +	{0x6663,	0x83,	"AMD Radeon (TM) R5 M320"},
>  	{0x6664,	0x0,	"AMD Radeon R5 M200 Series"},
>  	{0x6665,	0x0,	"AMD Radeon R5 M200 Series"},
> -	{0x6665,	0x83,	"AMD Radeon R5 M320"},
> +	{0x6665,	0x83,	"AMD Radeon (TM) R5 M320"},
> +	{0x6665,	0xC3,	"AMD Radeon (TM) R5 M430"},
>  	{0x6667,	0x0,	"AMD Radeon R5 M200 Series"},
> -	{0x666F,	0x0,	"AMD Radeon HD 8500M"},
> +	{0x666F,	0x0,	"AMD Radeon (TM) R5 M420"},
>  	{0x6780,	0x0,	"ATI FirePro V (FireGL V) Graphics Adapter"},
>  	{0x678A,	0x0,	"ATI FirePro V (FireGL V) Graphics Adapter"},
>  	{0x6798,	0x0,	"AMD Radeon HD 7900 Series"},
>  	{0x679A,	0x0,	"AMD Radeon HD 7900 Series"},
>  	{0x679B,	0x0,	"AMD Radeon HD 7900 Series"},
>  	{0x679E,	0x0,	"AMD Radeon HD 7800 Series"},
> -	{0x67A0,	0x0,	"HAWAII XTGL (67A0)"},
> -	{0x67A1,	0x0,	"HAWAII GL40 (67A1)"},
> +	{0x67A0,	0x0,	"AMD Radeon FirePro W9100"},
> +	{0x67A1,	0x0,	"AMD Radeon FirePro W8100"},
>  	{0x67B0,	0x0,	"AMD Radeon R9 200 Series"},
> -	{0x67B0,	0x80,	"AMD Radeon R9 390 Series"},
> +	{0x67B0,	0x80,	"AMD Radeon (TM) R9 390 Series"},
>  	{0x67B1,	0x0,	"AMD Radeon R9 200 Series"},
> -	{0x67B1,	0x80,	"AMD Radeon R9 390 Series"},
> +	{0x67B1,	0x80,	"AMD Radeon (TM) R9 390 Series"},
>  	{0x67B9,	0x0,	"AMD Radeon R9 200 Series"},
> -	{0x67DF,	0xC4,	"AMD Radeon RX 480 Graphics"},
> -	{0x67DF,	0xC5,	"AMD Radeon RX 470 Graphics"},
> -	{0x67DF,	0xC7,	"AMD Radeon RX 480 Graphics"},
> -	{0x67DF,	0xCF,	"AMD Radeon RX 470 Graphics"},
> -	{0x67C4,	0x00,	"AMD Radeon Pro WX 7100 Graphics"},
> -	{0x67C7,	0x00,	"AMD Radeon Pro WX 5100 Graphics"},
> -	{0x67C0,	0x00,	"AMD Radeon Pro WX 7100 Graphics"},
> -	{0x67E0,	0x00,	"AMD Radeon Pro WX Series Graphics"},
> -	{0x67E3,	0x00,	"AMD Radeon Pro WX 4100 Graphics"},
> -	{0x67E8,	0x00,	"AMD Radeon Pro WX Series Graphics"},
> -	{0x67E8,	0x01,	"AMD Radeon Pro WX Series Graphics"},
> -	{0x67E8,	0x80,	"AMD Radeon E9260 Graphics"},
> -	{0x67EB,	0x00,	"AMD Radeon Pro WX Series Graphics"},
> -	{0x67EF,	0xC0,	"AMD Radeon RX Graphics"},
> -	{0x67EF,	0xC1,	"AMD Radeon RX 460 Graphics"},
> -	{0x67EF,	0xC5,	"AMD Radeon RX 460 Graphics"},
> -	{0x67EF,	0xC7,	"AMD Radeon RX Graphics"},
> -	{0x67EF,	0xCF,	"AMD Radeon RX 460 Graphics"},
> -	{0x67EF,	0xEF,	"AMD Radeon RX Graphics"},
> -	{0x67FF,	0xC0,	"AMD Radeon RX Graphics"},
> -	{0x67FF,	0xC1,	"AMD Radeon RX Graphics"},
> +	{0x67DF,	0x5,	"AMD Radeon (TM) RX 470"},
> +	{0x67DF,	0xC1,	"Radeon RX 580 Series"},
> +	{0x67DF,	0xC2,	"Radeon RX 570 Series"},
> +	{0x67DF,	0xC3,	"Radeon RX 580 Series"},
> +	{0x67DF,	0xC4,	"AMD Radeon (TM) RX 480 Graphics"},
> +	{0x67DF,	0xC5,	"AMD Radeon (TM) RX 470 Graphics"},
> +	{0x67DF,	0xC6,	"Radeon RX 570 Series"},
> +	{0x67DF,	0xC7,	"AMD Radeon (TM) RX 480 Graphics"},
> +	{0x67DF,	0xCF,	"AMD Radeon (TM) RX 470 Graphics"},
> +	{0x67DF,	0xE3,	"Radeon RX Series"},
> +	{0x67DF,	0xE7,	"Radeon RX 580 Series"},
> +	{0x67DF,	0xEF,	"Radeon RX 570 Series"},
> +	{0x67C2,	0x0,	"67C2:00"},

Are you sure that is a marketing name?!? Depending on whether this is a s=
hipped
part or not I would either drop this line or prefer to see the actual mar=
keting
name inserted here.

The same applies to the instances below.

Cheers,
Kai

> +	{0x67C2,	0x01,	"AMD Radeon (TM) Pro V7350x2"},
> +	{0x67C2,	0x02,	"AMD Radeon (TM) Pro V7300X"},
> +	{0x67C4,	0x00,	"AMD Radeon (TM) Pro WX 7100 Graphics"},
> +	{0x67C7,	0x00,	"AMD Radeon (TM) Pro WX 5100 Graphics"},
> +	{0x67C0,	0x00,	"AMD Radeon (TM) Pro WX 7100 Graphics"},
> +	{0x67D0,	0x0,	"67D0:00"},
> +	{0x67D0,	0x01,	"AMD Radeon (TM) Pro V7350x2"},
> +	{0x67D0,	0x02,	"AMD Radeon (TM) Pro V7300X"},
> +	{0x67E0,	0x00,	"AMD Radeon (TM) Pro WX Series"},
> +	{0x67E3,	0x00,	"AMD Radeon (TM) Pro WX 4100"},
> +	{0x67E8,	0x00,	"AMD Radeon (TM) Pro WX Series"},
> +	{0x67E8,	0x01,	"AMD Radeon (TM) Pro WX Series"},
> +	{0x67E8,	0x80,	"AMD Radeon (TM) E9260 Graphics"},
> +	{0x67EB,	0x00,	"AMD Radeon (TM) Pro V5300X"},
> +	{0x67EF,	0xC0,	"AMD Radeon (TM) RX Graphics"},
> +	{0x67EF,	0xC1,	"AMD Radeon (TM) RX 460 Graphics"},
> +	{0x67EF,	0xC3,	"Radeon RX Series"},
> +	{0x67EF,	0xC5,	"AMD Radeon (TM) RX 460 Graphics"},
> +	{0x67EF,	0xC7,	"AMD Radeon (TM) RX Graphics"},
> +	{0x67EF,	0xCF,	"AMD Radeon (TM) RX 460 Graphics"},
> +	{0x67EF,	0xE0,	"67EF:E0"},
> +	{0x67EF,	0xE1,	"Radeon RX Series"},
> +	{0x67EF,	0xE3,	"Radeon RX Series"},
> +	{0x67EF,	0xE5,	"67EF:E5"},
> +	{0x67EF,	0xE7,	"Radeon RX Series"},
> +	{0x67EF,	0xEF,	"AMD Radeon (TM) RX Graphics"},
> +	{0x67EF,	0xFF,	"Radeon RX Series"},
> +	{0x67FF,	0xC0,	"AMD Radeon (TM) RX Graphics"},
> +	{0x67FF,	0xC1,	"AMD Radeon (TM) RX Graphics"},
> +	{0x67FF,	0xCF,	"67FF:CF"},
> +	{0x67FF,	0xEF,	"67FF:EF"},
> +	{0x67FF,	0xFF,	"Radeon RX 550 Series"},
>  	{0x6800,	0x0,	"AMD Radeon HD 7970M"},
>  	{0x6801,	0x0,	"AMD Radeon(TM) HD8970M"},
>  	{0x6808,	0x0,	"ATI FirePro V(FireGL V) Graphics Adapter"},
>  	{0x6809,	0x0,	"ATI FirePro V(FireGL V) Graphics Adapter"},
>  	{0x6810,	0x0,	"AMD Radeon(TM) HD 8800 Series"},
> -	{0x6810,	0x81,	"AMD Radeon R7 370 Series"},
> +	{0x6810,	0x81,	"AMD Radeon (TM) R7 370 Series"},
>  	{0x6811,	0x0,	"AMD Radeon(TM) HD8800 Series"},
> -	{0x6811,	0x81,	"AMD Radeon R7 300 Series"},
> +	{0x6811,	0x81,	"AMD Radeon (TM) R7 300 Series"},
>  	{0x6818,	0x0,	"AMD Radeon HD 7800 Series"},
>  	{0x6819,	0x0,	"AMD Radeon HD 7800 Series"},
>  	{0x6820,	0x0,	"AMD Radeon HD 8800M Series"},
> -	{0x6820,	0x81,	"AMD Radeon R9 M375"},
> -	{0x6820,	0x83,	"AMD Radeon R9 M375X"},
> +	{0x6820,	0x81,	"AMD Radeon (TM) R9 M375"},
> +	{0x6820,	0x83,	"AMD Radeon (TM) R9 M375X"},
>  	{0x6821,	0x0,	"AMD Radeon HD 8800M Series"},
> -	{0x6821,	0x87,	"AMD Radeon R7 M380"},
> -	{0x6821,	0x83,	"AMD Radeon R9 M370X"},
> +	{0x6821,	0x87,	"AMD Radeon (TM) R7 M380"},
> +	{0x6821,	0x83,	"AMD Radeon R9 (TM) M370X"},
>  	{0x6822,	0x0,	"AMD Radeon E8860"},
>  	{0x6823,	0x0,	"AMD Radeon HD 8800M Series"},
>  	{0x6825,	0x0,	"AMD Radeon HD 7800M Series"},
>  	{0x6827,	0x0,	"AMD Radeon HD 7800M Series"},
>  	{0x6828,	0x0,	"ATI FirePro V(FireGL V) Graphics Adapter"},
>  	{0x682B,	0x0,	"AMD Radeon HD 8800M Series"},
> -	{0x682B,	0x87,	"AMD Radeon R9 M360"},
> +	{0x682B,	0x87,	"AMD Radeon (TM) R7 M465X"},
>  	{0x682C,	0x0,	"AMD FirePro W4100"},
>  	{0x682D,	0x0,	"AMD Radeon HD 7700M Series"},
>  	{0x682F,	0x0,	"AMD Radeon HD 7700M Series"},
> @@ -132,25 +157,28 @@ static struct amdgpu_asic_id_table_t {
>  	{0x683D,	0x0,	"AMD Radeon HD 7700 Series"},
>  	{0x683F,	0x0,	"AMD Radeon HD 7700 Series"},
>  	{0x6900,	0x0,	"AMD Radeon R7 M260"},
> -	{0x6900,	0x81,	"AMD Radeon R7 M360"},
> -	{0x6900,	0x83,	"AMD Radeon R7 M340"},
> +	{0x6900,	0x81,	"AMD Radeon (TM) R7 M360"},
> +	{0x6900,	0x83,	"AMD Radeon (TM) R7 M440"},
> +	{0x6900,	0xC1,	"AMD Radeon (TM) R7 M465"},
> +	{0x6900,	0xC3,	"AMD Radeon (TM) R7 M445"},
>  	{0x6901,	0x0,	"AMD Radeon R5 M255"},
>  	{0x6907,	0x0,	"AMD Radeon R5 M255"},
> -	{0x6907,	0x87,	"AMD Radeon R5 M315"},
> -	{0x6920,	0x0,	"AMD Radeon R9 M395X"},
> -	{0x6920,	0x1,	"AMD Radeon R9 M390X"},
> -	{0x6921,	0x0,	"AMD Radeon R9 M295X"},
> +	{0x6907,	0x87,	"AMD Radeon (TM) R5 M315"},
> +	{0x6920,	0x0,	"AMD RADEON R9 M395X"},
> +	{0x6920,	0x1,	"AMD RADEON R9 M390X"},
> +	{0x6921,	0x0,	"AMD Radeon R9 M485X"},
>  	{0x6929,	0x0,	"AMD FirePro S7150"},
>  	{0x692B,	0x0,	"AMD FirePro W7100"},
>  	{0x6938,	0x0,	"AMD Radeon R9 200 Series"},
>  	{0x6938,	0xF0,	"AMD Radeon R9 200 Series"},
> -	{0x6938,	0xF1,	"AMD Radeon R9 380 Series"},
> +	{0x6938,	0xF1,	"AMD Radeon (TM) R9 380 Series"},
>  	{0x6939,	0xF0,	"AMD Radeon R9 200 Series"},
>  	{0x6939,	0x0,	"AMD Radeon R9 200 Series"},
> -	{0x6939,	0xF1,	"AMD Radeon R9 380 Series"},
> -	{0x7300,	0xC8,	"AMD Radeon R9 Fury Series"},
> -	{0x7300,	0xCB,	"AMD Radeon R9 Fury Series"},
> -	{0x7300,	0xCA,	"AMD Radeon R9 Fury Series"},
> +	{0x6939,	0xF1,	"AMD Radeon (TM) R9 380 Series"},
> +	{0x7300,	0xC8,	"AMD Radeon (TM) R9 Fury Series"},
> +	{0x7300,	0xC9,	"Radeon (TM) Pro Duo"},
> +	{0x7300,	0xCB,	"AMD Radeon (TM) R9 Fury Series"},
> +	{0x7300,	0xCA,	"AMD Radeon (TM) R9 Fury Series"},
>  	{0x9874,	0xC4,	"AMD Radeon R7 Graphics"},
>  	{0x9874,	0xC5,	"AMD Radeon R6 Graphics"},
>  	{0x9874,	0xC6,	"AMD Radeon R6 Graphics"},


--2MOcm6mSA3Nr7wG7SXKEqsV55090X1UmN--

--vW6K2NWuNDcTt87MF6dl9wb3D3T1iO8vh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlkLQxQACgkQownXbOHe
WdIGIAv9HVtwXJdCe7Iu7KUQGyM7jKImfL6fBYBCB5eIaVBDKCoDm8+pbp2bI760
X3EazNoGYO/KAZ6lyVyLUFCXCx+Gqnok8XaDo687CIRJj81F8Oi37lWcI/oxFQCv
t5ACVH+lRO0ozTvEwxS3Ta01SRAdHoSUZSLtZB0HFOrkLCCAQXD3ewb0ZqcXYQZF
DSNmhkNWFcuQN6rPntZB9YQ7lRiG+dLNCPBu+cjygDWf7a2R86o79cUWSwcQ41BA
w/4geNsKin9gDiPT4o2c4vjk8lgmerOn7xavIWn5yh7pIlYuBOPM6MaS9pvjgG+0
FXz0vDhT7iXF9Ch/Jr0z3RD9ktdFNl1j6Pxxp5cqIm5Iy6ni/IInCkpxDXkz5b7J
bCNRSt88ZuxHbSa5ON3fS3l2trdcftj3iR6JSUncv8cFXWcLW3y0/McQ7NmPo+4s
3XPdhizqmZiBMrkVI9zWxHaeNhujmbULOvUI3PkpeKouJ6aY7ADj7n0iLWT1DncR
iEEJUDqL
=xQIs
-----END PGP SIGNATURE-----

--vW6K2NWuNDcTt87MF6dl9wb3D3T1iO8vh--

--===============1343339689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1343339689==--
