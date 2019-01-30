From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amd-staging-drm-next: Oops - BUG: unable to handle kernel NULL
 pointer dereference, bisected.
Date: Wed, 30 Jan 2019 15:17:23 +0100
Message-ID: <8249694.Z184oBNS0B@eclipse>
References: <1631249.cbNX0rPzdC@eclipse>
 <34e7e9b9-8d16-1055-cd08-68eac497743e@amd.com>
 <7a65412b-1b41-9e5b-f700-0a944a33cf49@amd.com>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0780537323=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7a65412b-1b41-9e5b-f700-0a944a33cf49-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0780537323==
Content-Type: multipart/signed; boundary="nextPart2983944.4k6F5eU5TB"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2983944.4k6F5eU5TB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dnia =C5=9Broda, 30 stycznia 2019 13:42:33 CET piszesz:
> Does the attached patch fix the issue?
>=20
> Christian.
>=20
> .....

Thanks for the rapid response, but unfortunately no.=20
System freezes and only mouse pointer is movable (cannot switch tty's, rebo=
ot=20
by pwr button, tree-finger-salute doesn't work also).

Here is a trace log after applying the patch. I'm attaching it because it=20
looks different:

<4>[   46.864336] ------------[ cut here ]------------
<2>[   46.864343] kernel BUG at drivers/gpu/drm/ttm/ttm_bo.c:196!
<4>[   46.864361] invalid opcode: 0000 [#1] PREEMPT SMP
<4>[   46.864369] CPU: 3 PID: 10966 Comm: plasmashel:cs0 Not tainted 5.0.0-
rc1+ #44
<4>[   46.864373] Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.1=
3)=20
08/04/2016
<4>[   46.864388] RIP: 0010:ttm_bo_ref_bug+0x0/0x8 [ttm]
<4>[   46.864393] Code: 00 00 08 00 75 0c 48 83 c7 0c 4c 39 cf 75 ab 31 c0 =
c3=20
b8 01 00 00 00 c3 66 90 f0 ff 8f a4 00 00 00 c3 0f 1f 84 00 00 00 00 00 <0f=
> 0b=20
66 0f 1f 44 00 00 53 48 8b 07 48 89 fb 48 8b 40 18 48 8b 40
<4>[   46.864397] RSP: 0018:ffffa86fc1263af8 EFLAGS: 00010247
<4>[   46.864403] RAX: ffff8c7b133a787c RBX: ffffa86fc1263c48 RCX: ffff8c7b=
0f7698f8
<4>[   46.864406] RDX: ffff8c7b133a78f8 RSI: ffff8c7b11aa2800 RDI: ffff8c7b=
133a787c
<4>[   46.864410] RBP: ffff8c7ac16d1b38 R08: ffff8c7b1348d0f8 R09: ffffa86f=
c12639b0
<4>[   46.864414] R10: ffffcfd6c84d07c0 R11: 0000000000000003 R12: ffffffff=
c0364c10
<4>[   46.864417] R13: ffffa86fc1263be0 R14: 0000000000000000 R15:=20
ffffa86fc1263c48
<4>[   46.864422] FS:  00007f3e34019700(0000) GS:ffff8c7b17b80000(0000) knl=
GS:
0000000000000000
<4>[   46.864426] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   46.864430] CR2: 00007fb1cb765000 CR3: 000000021333e000 CR4:=20
00000000000406e0
<4>[   46.864433] Call Trace:
<4>[   46.864446]  ttm_bo_del_from_lru+0xab/0xc8 [ttm]
<4>[   46.864456]  ttm_eu_reserve_buffers+0x140/0x2c8 [ttm]
<4>[   46.864557]  amdgpu_cs_ioctl+0x4ee/0x1b08 [amdgpu]
<4>[   46.864575]  ? __switch_to_asm+0x40/0x70
<4>[   46.864668]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
<4>[   46.864678]  drm_ioctl_kernel+0xa4/0xe8<4>[   46.864686] =20
drm_ioctl+0x1db/0x358
<4>[   46.864767]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
<4>[   46.864848]  amdgpu_drm_ioctl+0x44/0x78 [amdgpu]
<4>[   46.864859]  do_vfs_ioctl+0x9f/0x618
<4>[   46.864867]  ksys_ioctl+0x5b/0x88
<4>[   46.864874]  __x64_sys_ioctl+0x11/0x18
<4>[   46.864881]  do_syscall_64+0x50/0x168
<4>[   46.864888]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[   46.864895] RIP: 0033:0x7f3e4a939fa7
<4>[   46.864900] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 =
e8 8d=20
dc 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48> 3=
d=20
01 f0 ff ff 73 01 c3 48 8b 0d a9 ae 0c 00 f7 d8 64 89 01 48
<4>[   46.864904] RSP: 002b:00007f3e34018ab8 EFLAGS: 00000246 ORIG_RAX:=20
0000000000000010
<4>[   46.864909] RAX: ffffffffffffffda RBX: 00007f3e34018c58 RCX: 00007f3e=
4a939fa7
<4>[   46.864913] RDX: 00007f3e34018b40 RSI: 00000000c0186444 RDI:=20
0000000000000010
<4>[   46.864916] RBP: 00007f3e34018b40 R08: 00007f3e34018c80 R09:=20
00007f3e34018c58
<4>[   46.864920] R10: 00007f3e34018ca0 R11: 0000000000000246 R12:=20
00000000c0186444
<4>[   46.864923] R13: 0000000000000010 R14: 000055555e550d70 R15:=20
0000000000000003
<4>[   46.864929] Modules linked in: rfcomm nf_tables ebtable_nat ip_set=20
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables overlay squash=
fs=20
loop bnep ipv6 rtsx_usb_ms memstick rtsx_usb_sdmmc rtsx_usb ath3k btusb=20
btintel bluetooth ecdh_generic uvcvideo videobuf2_vmalloc videobuf2_memops=
=20
videobuf2_v4l2 videobuf2_common videodev media kvm_amd ath9k kvm ath9k_comm=
on=20
irqbypass ath9k_hw crc32_pclmul mac80211 sdhci_pci cqhci sdhci=20
ghash_clmulni_intel serio_raw mmc_core ath cfg80211 amdgpu mfd_core chash=20
gpu_sched xhci_pci ttm ehci_pci xhci_hcd ehci_hcd sp5100_tco
<4>[   46.864981] ---[ end trace 7bdf1a5927cdc874 ]---

Thanks,
Przemek.




--nextPart2983944.4k6F5eU5TB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlxRsfMACgkQPMstj1ls
VJOuMA/9HW6ppXVRmuXefHl/3iyPgfVBpWKHmAUvd7b74l6XUY1T4eOIsLa4LvTZ
+a3aBGFDa4h2A8xjU+fQW21sf3b10C3Uf4L9eVFx6gSxnmENzkFqiwkAd+LTWg+x
oAoaqH1vK7lPtcZnx04f0UWaZcPJ2O6eLwngr8aooYIXCy0ad7VTFoMhnGu02dag
OJ7lOoGbXkInMULlfDf/B2W0f8dKcWfAGVz46beLqUOaB3SMUmruswlCxO6zCRq6
E7fCmeLrSMC/W/EsWjNd/GUx+NIdVe0y3mhuaP3HW0yp0mU45HAANDuAVKfMTWxD
yfX4IvhfUzLfZeTB3fAL3fhqMzCd2kHevxxTrvYU2YRTOe3k1cUOZLuVGenZA4vG
7UZV8u803uuWVEkxzwO53Fzh7YzIzvh7Y4FbAyP5OFa/YwsHJIFn19Q1lkd6gcRT
p1q2smBPXI+vQNRaI1O9N+HGjOsdWHOqDn5IBAKoiJ9D+JLFhzEKrh5gPYBWzvek
8auxjJV7bNcSnt3XJpOJM6Qd7ZwEWVkS+xln6z9I8ideLwerPra3Xtx9UEZIDTBz
utx5pIKscdIQcVg49/fb2sivc7t2Bpiv0MSo2gOI+6gYYIRs0cy7UvwCbGO1sfLo
/KK9QcK03OFIsydprNXcW31xFjL0ECsr55UCEYpoggANryfLjIA=
=hkxf
-----END PGP SIGNATURE-----

--nextPart2983944.4k6F5eU5TB--




--===============0780537323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0780537323==--
