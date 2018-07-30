From: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Subject: Re: [PATCH 6/6] drm/amdkfd: Enable Raven for KFD
Date: Mon, 30 Jul 2018 15:33:58 +0200
Message-ID: <a4f4f2e1-5f2f-2ca4-ce74-e3e76690c7bb@molgen.mpg.de>
References: <1531513068-3805-1-git-send-email-Felix.Kuehling@amd.com>
 <1531513068-3805-7-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1751426174=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531513068-3805-7-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a cryptographically signed message in MIME format.

--===============1751426174==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030002060903080607040503"

This is a cryptographically signed message in MIME format.

--------------ms030002060903080607040503
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Felix, dear Yong,


On 07/13/18 22:17, Felix K=C3=BChling wrote:
> From: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
>=20
> Add DID and kfd_device_info for Raven.
>=20
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_device.c
> index 572235c..1b04871 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -70,6 +70,21 @@ static const struct kfd_device_info carrizo_device_i=
nfo =3D {
>  	.needs_pci_atomics =3D false,
>  	.num_sdma_engines =3D 2,
>  };
> +
> +static const struct kfd_device_info raven_device_info =3D {
> +	.asic_family =3D CHIP_RAVEN,
> +	.max_pasid_bits =3D 16,
> +	.max_no_of_hqd  =3D 24,
> +	.doorbell_size  =3D 8,
> +	.ih_ring_entry_size =3D 8 * sizeof(uint32_t),
> +	.event_interrupt_class =3D &event_interrupt_class_v9,
> +	.num_of_watch_points =3D 4,
> +	.mqd_size_aligned =3D MQD_SIZE_ALIGNED,
> +	.supports_cwsr =3D true,
> +	.needs_iommu_device =3D true,
> +	.needs_pci_atomics =3D true,
> +	.num_sdma_engines =3D 1,
> +};
>  #endif
> =20
>  static const struct kfd_device_info hawaii_device_info =3D {
> @@ -259,6 +274,7 @@ static const struct kfd_deviceid supported_devices[=
] =3D {
>  	{ 0x9875, &carrizo_device_info },	/* Carrizo */
>  	{ 0x9876, &carrizo_device_info },	/* Carrizo */
>  	{ 0x9877, &carrizo_device_info },	/* Carrizo */
> +	{ 0x15DD, &raven_device_info },		/* Raven */
>  #endif
>  	{ 0x67A0, &hawaii_device_info },	/* Hawaii */
>  	{ 0x67A1, &hawaii_device_info },	/* Hawaii */


I built the branch *amdkfd-next* from [1], but on the MIS B350M MORTAR (M=
S-7A37)
with BIOS 1.G1 05/17/2018 it is not loaded.

```
$ uname -a
Linux tokeiihto 4.18.0-rc3-01368-gb5aa3f4aef72 #51 SMP Mon Jul 30 13:11:3=
6 UTC 2018 x86_64 GNU/Linux
$ grep HSA /boot/config-4.18.0-rc3-01368-gb5aa3f4aef72
CONFIG_HSA_AMD=3Dm
$ sudo dmesg | grep -i kfd
[   23.206628] calling  kfd_module_init+0x0/0x1000 [amdkfd] @ 365
[   23.209082] kfd kfd: Initialized module
[   23.209667] initcall kfd_module_init+0x0/0x1000 [amdkfd] returned 0 af=
ter 2960 usecs
[   23.212852] kfd kfd: DID 15dd is missing in supported_devices
[   23.212856] kfd kfd: kgd2kfd_probe failed
$ /sbin/modinfo amdkfd
filename:       /lib/modules/4.18.0-rc3-01368-gb5aa3f4aef72/kernel/driver=
s/gpu/drm/amd/amdkfd/amdkfd.ko
version:        0.7.2
license:        GPL and additional rights
description:    Standalone HSA driver for AMD's GPUs
author:         AMD Inc. and others
srcversion:     9AAD0B6E4510ACF8D20A888
depends:
retpoline:      Y=20
intree:         Y=20
name:           amdkfd
vermagic:       4.18.0-rc3-01368-gb5aa3f4aef72 SMP mod_unload=20
sig_id:         PKCS#7
[=E2=80=A6]
```

Any hints, what I am doing wrong?


Kind regards,

Paul


PS: Output of lspci:

```
$ lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15d0]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Device [1022:15d=
1]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15d3]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15db]
00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:15dc]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Contro=
ller [1022:790b] (rev 61)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bri=
dge [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15e8]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15e9]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ea]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15eb]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ec]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ed]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ee]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [10=
22:15ef]
15:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 300 Ser=
ies Chipset USB 3.1 xHCI Controller [1022:43bb] (rev 02)
15:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 300 Se=
ries Chipset SATA Controller [1022:43b7] (rev 02)
15:00.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [102=
2:43b2] (rev 02)
16:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
16:01.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
16:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series =
Chipset PCIe Port [1022:43b4] (rev 02)
18:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL81=
11/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)=

38:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] [100=
2:15dd] (rev c8)
38:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Devic=
e [1002:15de]
38:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:15df]
38:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device =
[1022:15e0]
38:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device =
[1022:15e1]
38:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Device [1=
022:15e3]
39:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SA=
TA Controller [AHCI mode] [1022:7901] (rev 61)
```


[1]: git://people.freedesktop.org/~gabbayo/linux.git


--------------ms030002060903080607040503
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODA3MzAxMzMzNThaMC8GCSqGSIb3DQEJBDEiBCBXhzO0UmjJZPvIn6un
0h+rLXHtvcQjHt0q2k4Ny8SMBDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBABQf
59ZO5s8/xf967s+feH1PP6/Lf5toQMiIPzSmj/SqQU+T4OFV4rwrMStwIXvUmw2q8a04iZWU
b4K+JpRvkwKvKP8y3JlCqsswrM5g6wnV9vTieUf2nSHxi7ZFDGWFzoNBf6nji+uGt7HsJMdN
xrRep8gJycVu6On67b+6c/O+S31c246jC1xQHX8RWgKhj4o4OAQfiDZqCVS+m8wYYrYtQIj5
/C69xapJirZ/+6tsXRcha26PI+Ik5n8oLdhrNYjql8tJpVKhMmNbx/gjXeI03uixuGz3x4Gk
D/RetlWU+Ln7G0TvKiol/m1N4kgfaJNfUMnX9JtnAHWsihlqM7wAAAAAAAA=
--------------ms030002060903080607040503--

--===============1751426174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1751426174==--
