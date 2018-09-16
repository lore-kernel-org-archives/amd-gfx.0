From: "A. Wilcox" <awilfox-EG4NeYC890/CfDggNXIi3w@public.gmane.org>
Subject: [PATCH] amdgpu uses raw rlc_hdr values, causing kernel OOPS on big
 endian architectures
Date: Sun, 16 Sep 2018 17:52:38 -0500
Message-ID: <70b5ad70-2481-869f-960e-c480d23459d8@adelielinux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0999994751=="
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0999994751==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8JITuNFNIV3K5EU8No8NJK34VIZl5ai6X"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8JITuNFNIV3K5EU8No8NJK34VIZl5ai6X
Content-Type: multipart/mixed; boundary="mJeH7KS8lwB6oWcgecJ3UsKhHCDj4xmTG";
 protected-headers="v1"
From: "A. Wilcox" <awilfox-EG4NeYC890/CfDggNXIi3w@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <70b5ad70-2481-869f-960e-c480d23459d8-EG4NeYC890/CfDggNXIi3w@public.gmane.org>
Subject: [PATCH] amdgpu uses raw rlc_hdr values, causing kernel OOPS on big
 endian architectures

--mJeH7KS8lwB6oWcgecJ3UsKhHCDj4xmTG
Content-Type: multipart/mixed;
 boundary="------------0AB54790561A2309B246B896"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0AB54790561A2309B246B896
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

adev->gfx.rlc in gfx_v8_0_init_microcode has the values from rlc_hdr
already processed by le32_to_cpu.  Using the rlc_hdr values on
big-endian machines causes a kernel Oops due to writing well outside of
the array (0x24000000 instead of 0x24).  gfx_v9_0 had the same issue and
was fixed in the same manner (but was not tested locally; I do not have
a v9 card).

[    8.143396] Unable to handle kernel paging request for data at
address 0xc00800000615b000
[    8.143396] Faulting instruction address: 0xc008000005f063c8
[    8.143399] Oops: Kernel access of bad area, sig: 11 [#1]
[    8.143429] BE SMP NR_CPUS=3D256 NUMA PowerNV
[    8.143461] Modules linked in: binfmt_misc amdgpu(+) ast ttm
drm_kms_helper sysimgblt syscopyarea sysfillrect fb_sys_fops drm joydev
mac_hid tg3 ipmi_powernv ipmi_msghandler agpgart i2c_algo_bit shpchp
[    8.143615] CPU: 0 PID: 2402 Comm: kworker/0:3 Not tainted
4.14.48-mc8-easy #1
[    8.143679] Workqueue: events .work_for_cpu_fn
[    8.143728] task: c0000003e7fd8000 task.stack: c0000003e7fe0000
[    8.143783] NIP:  c008000005f063c8 LR: c008000005f06388 CTR:
c00000000027efd0
[    8.143869] REGS: c0000003e7fe3430 TRAP: 0300   Not tainted
(4.14.48-mc8-easy)
[    8.143950] MSR:  9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR:
28002444  XER: 20040000
[    8.144040] CFAR: c008000005f063d0 DAR: c00800000615b000 DSISR:
40000000 SOFTE: 1
[    8.144787] NIP [c008000005f063c8] .gfx_v8_0_sw_init+0x5a8/0x15b0
[amdgpu]
[    8.144911] LR [c008000005f06388] .gfx_v8_0_sw_init+0x568/0x15b0 [amdg=
pu]
[    8.144976] Call Trace:
[    8.145049] [c0000003e7fe36b0] [c008000005f06388]
=2Egfx_v8_0_sw_init+0x568/0x15b0 [amdgpu] (unreliable)
[    8.145194] [c0000003e7fe37c0] [c008000005e484c4]
=2Eamdgpu_device_init+0xf34/0x1750 [amdgpu]
[    8.145302] [c0000003e7fe38f0] [c008000005e4a94c]
=2Eamdgpu_driver_load_kms+0x9c/0x2a0 [amdgpu]
[    8.145420] [c0000003e7fe3980] [c008000004f4d200]
=2Edrm_dev_register+0x1c0/0x250 [drm]
[    8.145548] [c0000003e7fe3a30] [c008000005e416c4]
=2Eamdgpu_pci_probe+0x164/0x1a0 [amdgpu]
[    8.145601] [c0000003e7fe3ac0] [c000000000618ed0]
=2Elocal_pci_probe+0x60/0x130
[    8.145683] [c0000003e7fe3b60] [c0000000000e8780]
=2Ework_for_cpu_fn+0x30/0x50
[    8.145774] [c0000003e7fe3be0] [c0000000000ecea8]
=2Eprocess_one_work+0x2a8/0x550
[    8.145854] [c0000003e7fe3c80] [c0000000000ed430]
=2Eworker_thread+0x2e0/0x600
[    8.145924] [c0000003e7fe3d70] [c0000000000f5338] .kthread+0x158/0x1a0=

[    8.145973] [c0000003e7fe3e30] [c00000000000bd4c]
=2Eret_from_kernel_thread+0x58/0x8c
[    8.146054] Instruction dump:
[    8.146089] 38db004c 39200000 7d00342c 7d08da14 815b0048 554af0be
7f8a4840 409d004c 792a1764 e8ff46f0 39290001 79290020 <7cc8542c>
7cc7512e 4bffffd8 60000000
[    8.146252] ---[ end trace 8b0ede048bbb20ae ]---

--=20
A. Wilcox (awilfox)
Project Lead, Ad=C3=A9lie Linux
https://www.adelielinux.org

--------------0AB54790561A2309B246B896
Content-Type: text/plain; charset=UTF-8;
 name="0001-drm-amdgpu-use-processed-values-for-counting.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-use-processed-values-for-counting.patch"

RnJvbSBiOTIzMDNmYmVmZGIzNGQzYzU1YWUyMjNjYTliMDJlNjA2MjVhYWU1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiQS4gV2lsY294IiA8QVdpbGNveEBXaWxjb3gtVGVj
aC5jb20+CkRhdGU6IFN1biwgMSBKdWwgMjAxOCAyMjo0NDo1MiAtMDUwMApTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWRncHU6IHVzZSBwcm9jZXNzZWQgdmFsdWVzIGZvciBjb3VudGluZwoK
YWRldi0+Z2Z4LnJsYyBoYXMgdGhlIHZhbHVlcyBmcm9tIHJsY19oZHIgYWxyZWFkeSBwcm9j
ZXNzZWQgYnkKbGUzMl90b19jcHUuICBVc2luZyB0aGUgcmxjX2hkciB2YWx1ZXMgb24gYmln
LWVuZGlhbiBtYWNoaW5lcyBjYXVzZXMKYSBrZXJuZWwgT29wcyBkdWUgdG8gd3JpdGluZyB3
ZWxsIG91dHNpZGUgb2YgdGhlIGFycmF5ICgweDI0MDAwMDAwCmluc3RlYWQgb2YgMHgyNCku
CgpTaWduZWQtb2ZmLWJ5OiBBLiBXaWxjb3ggPEFXaWxjb3hAV2lsY294LVRlY2guY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgfCA0ICsrLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA0ICsrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCmluZGV4IDgxODg3NGIxM2M5OS4uMTEyZGZiZjdh
MWZjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKQEAgLTEwOTQs
MTQgKzEwOTQsMTQgQEAgc3RhdGljIGludCBnZnhfdjhfMF9pbml0X21pY3JvY29kZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogCXRtcCA9ICh1bnNpZ25lZCBpbnQgKikoKHVp
bnRwdHJfdClybGNfaGRyICsKIAkJCWxlMzJfdG9fY3B1KHJsY19oZHItPnJlZ19saXN0X2Zv
cm1hdF9hcnJheV9vZmZzZXRfYnl0ZXMpKTsKLQlmb3IgKGkgPSAwIDsgaSA8IChybGNfaGRy
LT5yZWdfbGlzdF9mb3JtYXRfc2l6ZV9ieXRlcyA+PiAyKTsgaSsrKQorCWZvciAoaSA9IDAg
OyBpIDwgKGFkZXYtPmdmeC5ybGMucmVnX2xpc3RfZm9ybWF0X3NpemVfYnl0ZXMgPj4gMik7
IGkrKykKIAkJYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9saXN0X2Zvcm1hdFtpXSA9CWxlMzJf
dG9fY3B1KHRtcFtpXSk7CiAKIAlhZGV2LT5nZngucmxjLnJlZ2lzdGVyX3Jlc3RvcmUgPSBh
ZGV2LT5nZngucmxjLnJlZ2lzdGVyX2xpc3RfZm9ybWF0ICsgaTsKIAogCXRtcCA9ICh1bnNp
Z25lZCBpbnQgKikoKHVpbnRwdHJfdClybGNfaGRyICsKIAkJCWxlMzJfdG9fY3B1KHJsY19o
ZHItPnJlZ19saXN0X2FycmF5X29mZnNldF9ieXRlcykpOwotCWZvciAoaSA9IDAgOyBpIDwg
KHJsY19oZHItPnJlZ19saXN0X3NpemVfYnl0ZXMgPj4gMik7IGkrKykKKwlmb3IgKGkgPSAw
IDsgaSA8IChhZGV2LT5nZngucmxjLnJlZ19saXN0X3NpemVfYnl0ZXMgPj4gMik7IGkrKykK
IAkJYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9yZXN0b3JlW2ldID0gbGUzMl90b19jcHUodG1w
W2ldKTsKIAogCWlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9QT0xBUklTMTAgJiYgYWRl
di0+YXNpY190eXBlIDw9IENISVBfUE9MQVJJUzEyKSB7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYwppbmRleCBhNjkxNTM0MzVlYTcuLmQ1ZTFmODBhZGJjOCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC01NzcsMTQgKzU3Nywx
NCBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2luaXRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCiAJdG1wID0gKHVuc2lnbmVkIGludCAqKSgodWludHB0cl90KXJs
Y19oZHIgKwogCQkJbGUzMl90b19jcHUocmxjX2hkci0+cmVnX2xpc3RfZm9ybWF0X2FycmF5
X29mZnNldF9ieXRlcykpOwotCWZvciAoaSA9IDAgOyBpIDwgKHJsY19oZHItPnJlZ19saXN0
X2Zvcm1hdF9zaXplX2J5dGVzID4+IDIpOyBpKyspCisJZm9yIChpID0gMCA7IGkgPCAoYWRl
di0+Z2Z4LnJsYy5yZWdfbGlzdF9mb3JtYXRfc2l6ZV9ieXRlcyA+PiAyKTsgaSsrKQogCQlh
ZGV2LT5nZngucmxjLnJlZ2lzdGVyX2xpc3RfZm9ybWF0W2ldID0JbGUzMl90b19jcHUodG1w
W2ldKTsKIAogCWFkZXYtPmdmeC5ybGMucmVnaXN0ZXJfcmVzdG9yZSA9IGFkZXYtPmdmeC5y
bGMucmVnaXN0ZXJfbGlzdF9mb3JtYXQgKyBpOwogCiAJdG1wID0gKHVuc2lnbmVkIGludCAq
KSgodWludHB0cl90KXJsY19oZHIgKwogCQkJbGUzMl90b19jcHUocmxjX2hkci0+cmVnX2xp
c3RfYXJyYXlfb2Zmc2V0X2J5dGVzKSk7Ci0JZm9yIChpID0gMCA7IGkgPCAocmxjX2hkci0+
cmVnX2xpc3Rfc2l6ZV9ieXRlcyA+PiAyKTsgaSsrKQorCWZvciAoaSA9IDAgOyBpIDwgKGFk
ZXYtPmdmeC5ybGMucmVnX2xpc3Rfc2l6ZV9ieXRlcyA+PiAyKTsgaSsrKQogCQlhZGV2LT5n
ZngucmxjLnJlZ2lzdGVyX3Jlc3RvcmVbaV0gPSBsZTMyX3RvX2NwdSh0bXBbaV0pOwogCiAJ
aWYgKGFkZXYtPmdmeC5ybGMuaXNfcmxjX3YyXzEpCi0tIAoyLjE3LjEKCg==
--------------0AB54790561A2309B246B896--

--mJeH7KS8lwB6oWcgecJ3UsKhHCDj4xmTG--

--8JITuNFNIV3K5EU8No8NJK34VIZl5ai6X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEjNyWOYPU1SaTSMHHyynLUZIrnRQFAlue3rcACgkQyynLUZIr
nRRFPw/+LkKk91VyDXH3KDS6M9Oe07xZ5Gp2oIjw6HGgvwnPDdO9ftdHW+6/wv3y
LkQ+SwasNt4enJL9BGo4UAQDARV+9f13vxCYNKZlHoU4BJIEPqQf6hf0p4CimTbD
BE6pyjd95RZ2hWrdWL+H3Q2LSWrkgGNBTUp+Zx2TiJuwhr/zgiDIepRCYzvLp3ZE
7kwu/q3IB/B9Np/14AzPcgjqrRWihwQRsPIktjdBtsLZuMktPFAW34ADfLpYSTrd
s8BpudxGykJMxiFqLyfQxX13kGux+iOf8M2pzhLHoMiissd99T401SpSmrSmYQNp
St5lvSjo6Vi+v6wqtfKx3P413Xp9oGe1Lr/soo3CegYzG8sAO29yA34bpzdQKAgu
z9522sQbrahE7E2GyyV9vcKQfkH9fToo2XeBlXzb52d3cODhReaQk6qVYplXp5+0
nVYONcorJDuP+/p0eI8tSzEIwqs+tGV0h09fH6leLnZqYKHETNZ7kgBgSeduSC+4
vDsVPMkGmR0caeEK310Hdb0TNXysd0wFImJFD0HweXEKDbiYOPsqn0jzF3GVlnH6
muAQiN4adaitZSxNih2Q4dmvvqytMF/wcm9I3+D42ONVhPpswg2foqdv3JjRBg77
MPyM4i6ZjAmiO0fA6PpvNnVczR0vrFCY0BFsCvsbG/cy4gOmGas=
=SmlH
-----END PGP SIGNATURE-----

--8JITuNFNIV3K5EU8No8NJK34VIZl5ai6X--

--===============0999994751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0999994751==--
