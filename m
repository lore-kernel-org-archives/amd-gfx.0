From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: BISECTED- amd-staging-drm-next,
 xorg-server segfault A6-6310 APU - R4 Mullins.
Date: Thu, 10 Jan 2019 10:44:06 +0100
Message-ID: <3677766.FRf3LM2rx8@eclipse>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0939560179=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: michel.daenzer-5C7GfCeVMHo@public.gmane.org, yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org

--===============0939560179==
Content-Type: multipart/signed; boundary="nextPart10123473.dCbvLYajVx"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart10123473.dCbvLYajVx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi,
after yesterday's fetch of amd-staging-drm-next tree from agd5f git repo my=
=20
xorg server is segfaulting when starting up.

I am using gentoo ~amd64, xorg-server 1.20.3, xf86-video-amdgpu-18.1.0.=20
Machine is an old Lenovo g50-45 netbook with A6-6310 APU - R4 Mullins.

=2D excerpt from Xorg.log:

"[    21.878] (II) AMDGPU(0): Setting screen physical size to 700 x 270
[    21.880] (EE)=20
[    21.880] (EE) Backtrace:
[    21.880] (EE) 0: /usr/bin/X (xorg_backtrace+0x4d) [0x559df051f0bd]
[    21.880] (EE) 1: /usr/bin/X (0x559df0376000+0x1acc89) [0x559df0522c89]
[    21.880] (EE) 2: /lib64/libpthread.so.0 (0x7f6f2edad000+0x14560)=20
[0x7f6f2edc1560]
[    21.880] (EE) 3: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so=20
(0x7f6f2f32b000+0x14fce) [0x7f6f2f33ffce]
[    21.880] (EE) 4: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so=20
(0x7f6f2f32b000+0xd1c4) [0x7f6f2f3381c4]
[    21.880] (EE) 5: /usr/bin/X (0x559df0376000+0xdf024) [0x559df0455024]
[    21.881] (EE) 6: /usr/bin/X (InitRootWindow+0x11) [0x559df03f8761]
[    21.881] (EE) 7: /usr/bin/X (0x559df0376000+0x5b574) [0x559df03d1574]
[    21.881] (EE) 8: /lib64/libc.so.6 (__libc_start_main+0xee)=20
[0x7f6f2ec054ce]
[    21.881] (EE) 9: /usr/bin/X (_start+0x2a) [0x559df03bb00a]
[    21.881] (EE)=20
[    21.881] (EE) Segmentation fault at address 0x4
[    21.881] (EE)=20
=46atal server error:
[    21.881] (EE) Caught signal 11 (Segmentation fault). Server aborting
[    21.881] (EE)=20
[    21.881] (EE)=20
Please consult the The X.Org Foundation support=20
	 at http://wiki.x.org
 for help.=20
[    21.881] (EE) Please also check the log file at "/var/log/Xorg.0.log" f=
or=20
additional information.
[    21.881] (EE)=20
[    21.881] (II) AIGLX: Suspending AIGLX clients for VT switch
[    21.957] (EE) Server terminated with error (1). Closing log file."


I am not sure if I didn't mess up anything, but git bisect gives the result=
s:

git bisect log
git bisect start
# good: [d9c54d61df327dc93374b718d7941a09e02e32e1] drm/amdgpu: Add new Vega=
M=20
pci id
git bisect good d9c54d61df327dc93374b718d7941a09e02e32e1
# bad: [d2d07f246b126b23d02af0603b83866a3c3e2483] drm/amdgpu/si: add missin=
g=20
header to fix compilation
git bisect bad d2d07f246b126b23d02af0603b83866a3c3e2483
# good: [abc0add47f449a02f8b784d43f4578723fbd6ac9] drm/amdgpu: Add message=
=20
print when unable to get valid hive
git bisect good abc0add47f449a02f8b784d43f4578723fbd6ac9
# bad: [0b0ff923cb4279ee12913dd2b597146538b76a8b] drm/amdgpu: set=20
WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang
git bisect bad 0b0ff923cb4279ee12913dd2b597146538b76a8b
# good: [320a0512c8e42fde01be5c47f33fef07d264c6d4] drm/amd/powerplay: creat=
e=20
pp_od_clk_voltage device file under OD support
git bisect good 320a0512c8e42fde01be5c47f33fef07d264c6d4
# bad: [79c6b898011958fba7722528d567b64e1cdc8dbe] drm/amdgpu: validate user=
=20
pitch alignment
git bisect bad 79c6b898011958fba7722528d567b64e1cdc8dbe
# good: [069d809a94db281efcb6a55f1c0e4a088af0a4cb] drm/amd/powerplay: drop =
the=20
unnecessary uclk hard min setting
git bisect good 069d809a94db281efcb6a55f1c0e4a088af0a4cb
# first bad commit: [79c6b898011958fba7722528d567b64e1cdc8dbe] drm/amdgpu:=
=20
validate user pitch alignment


79c6b898011958fba7722528d567b64e1cdc8dbe is the first bad commit
commit 79c6b898011958fba7722528d567b64e1cdc8dbe
Author: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Date:   Mon Jan 7 15:51:14 2019 -0700

    drm/amdgpu: validate user pitch alignment
   =20
    Userspace may request pitch alignment that is not supported by GPU.
    Some requests 32, but GPU ignores it and uses default 64 when cpp is
    4. If GEM object is allocated based on the smaller alignment, GPU
    DMA will go out of bound.
   =20
    Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.2+
    Reviewed-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

:040000 040000 5338964e9975e461ceedb27f6342c2896f54607a=20
ed2f04fc9b665b27b1905fd60b7d2a3933d1fdcc M      drivers

Any help is appreciated.

Thanks,
Przemek.

--nextPart10123473.dCbvLYajVx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlw3E+YACgkQPMstj1ls
VJNX1BAAgymWsLmfmBPI+W+rIOprfQvslHZQlGNGrB6YUVPv0AvNalHljf34UUD9
P/l2S7AwKXXXz9tLFXxu9EdcPh8+zByV8TLbHLqQeXLeqvQdUpyYbZ3CFgYRnxBo
HieaDMgr+ho2ZrSK12MMO4Jvj9deMfrePICPs2yMRJz8zFS0xbJ63ujNhHZo6FEt
uOqWFCqrwKtk6Veed3L6Kj2WYA9H2Qf1gpHSXN4/6OaqL6qD+rIgrSoJLmVWRWvj
Mlotr0ZC2NP6K4+xTidf/aIiHpdw4CNm1euP8Nf7WH6YLG4eVrIG8K3J+LXRtIh2
ntY0g8dHpvXNIyEJ9OnQ2IOLIy8BxC4eYtCDPRpP9r5hObs5Pu4JGsDOTV7Z/SM6
IvxELS1sNzchwFGjgdr8PqJq9AI0xNQfxw90RQYoMWYSIvhJpdcRyN752AuSjVyQ
PI2vpVET4ThRAqdiCZirdj08cvgX3//lS8BCTlEhLEwnsB6QqoY7PyyWWz3kagnG
uD6HKvwnhfRBV0LogQrr0HC7IHvUdwGJCJqeDFfAkHMgH2xEqspX8N8Lm3VybnL/
P91sE4mRhscD6PG9LDDve94I0GB0kQ7In5EhtbBLhN/iPpIMMnJVvRoT4eNPtCak
/XR8+2FNOgbi3mahjWh1oM2xaKJsJX0M3TfUnpmCj0vS1MZGiOQ=
=ib48
-----END PGP SIGNATURE-----

--nextPart10123473.dCbvLYajVx--




--===============0939560179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0939560179==--
