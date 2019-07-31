From: "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>
Subject: RE: AMDPU breaks suspend after kernel 5.0
Date: Wed, 31 Jul 2019 10:21:57 +0000
Message-ID: <DM6PR12MB38662B2D1D1484202A22C85CEFDF0@DM6PR12MB3866.namprd12.prod.outlook.com>
References: <1857879.T0pfAYGBzp@acer>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_DM6PR12MB38662B2D1D1484202A22C85CEFDF0DM6PR12MB3866namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1857879.T0pfAYGBzp@acer>
Content-Language: en-US
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
To: Paul Gover <pmw.gover-/E1597aS9LT10XsdtD+oqA@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_002_DM6PR12MB38662B2D1D1484202A22C85CEFDF0DM6PR12MB3866namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Gover,

Sorry for responds late, can you help to give a try to add the patch attach=
ed and share me the related result and logs?=20
Besides, do you have tried to revert this commit to see whether it's good?
Thanks.

Regards,
Likun

-----Original Message-----
From: Paul Gover <pmw.gover-/E1597aS9LT10XsdtD+oqA@public.gmane.org>=20
Sent: Tuesday, July 30, 2019 9:34 PM
To: Gao, Likun <Likun.Gao-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: AMDPU breaks suspend after kernel 5.0

Hi Likun,

Sorry if you don't want emails like this.  I added info. to
https://bugs.freedesktop.org/show_bug.cgi?id=3D110258
but people on Gentoo forums said email would be better.

Git bisect lead me to you:
---------------
106c7d6148e5aadd394e6701f7e498df49b869d1 is the first bad commit commit 106=
c7d6148e5aadd394e6701f7e498df49b869d1
Author: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>
Date:   Thu Nov 8 20:19:54 2018 +0800

    drm/amdgpu: abstract the function of enter/exit safe mode for RLC
   =20
    Abstract the function of amdgpu_gfx_rlc_enter/exit_safe_mode and some p=
art of rlc_init to improve the reusability of RLC.
   =20
    Signed-off-by: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>
    Acked-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

:040000 040000 8f3b365496f3bbd380a62032f20642ace51c8fef=20
e14ec968011019e3f601df3f15682bb9ae0bafc6 M      drivers
---------------------
Symptoms are when resuming after pm-suspend, the screen is blank or corrupt=
, the keyboard dead, and syslog shows
--------------------
kernel: [   81.096666] [drm:amdgpu_job_timedout] *ERROR* ring gfx timeout,=
=20
signaled seq=3D51, emitted seq=3D52
kernel: [   81.096671] [drm] IP block:gfx_v8_0 is hung!
kernel: [   81.096734] [drm] GPU recovery disabled.
---------------------
or similar.  The problem occurs with all kernels since 5.0 up to and includ=
ing 5.3-rc2.  My laptop is:

HP 15-bw0xx
cpu:AMD A9-9420 RADEON R5, 5 COMPUTE CORES 2C+3G with integrated graphics:
Stoney [Radeon R2/R3/R4/R5 Graphics] [1002:98E4]

There are several similar reports on the web, most or all for Stoney hardwa=
re, but that might be a coincidence as laptop users are more concerned abou=
t suspend, and there are a lot of laptops with similar integrated graphics =
motherboards.

I'm running Gentoo with a custom kernel, the most relevant bits of the conf=
ig CONFIG_DRM_AMDGPU=3Dy # CONFIG_DRM_AMDGPU_SI is not set # CONFIG_DRM_AMD=
GPU_CIK is not set # CONFIG_DRM_AMDGPU_USERPTR is not set

If you tell me how, I'm willing to try to collect traces etc.

Paul Gover



--_002_DM6PR12MB38662B2D1D1484202A22C85CEFDF0DM6PR12MB3866namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-debug-for-gfx-v8-Stoney-pm-suspend.patch"
Content-Description: 0001-drm-amdgpu-debug-for-gfx-v8-Stoney-pm-suspend.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-debug-for-gfx-v8-Stoney-pm-suspend.patch";
	size=1492; creation-date="Wed, 31 Jul 2019 08:55:54 GMT";
	modification-date="Wed, 31 Jul 2019 08:55:54 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNmFkNjMzNzY3YjQxNzhmZWYyMDQwNzExNDE3ZTcxZTkzZjQxMmI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29tPgpEYXRlOiBX
ZWQsIDMxIEp1bCAyMDE5IDEzOjUyOjA3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogZGVidWcgZm9yIGdmeCB2OCBTdG9uZXkgcG0tc3VzcGVuZAoKU2lnbmVkLW9mZi1ieTogTGlr
dW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmxjLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9ybGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ybGMuYwpp
bmRleCBjODc5M2U2Li41OTgxZmY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmxjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JsYy5jCkBAIC0zNiw2ICszNiw4IEBACiAgKi8KIHZvaWQgYW1kZ3B1X2dmeF9ybGNfZW50ZXJf
c2FmZV9tb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogeworCXByaW50aygiZ2Z4djgg
c2FmZSBtb2RlIHN0YXRlIGlzICVkIHRvIGVudGVyXG4iLAorCSAgICAgICBhZGV2LT5nZngucmxj
LmluX3NhZmVfbW9kZSk7CiAJaWYgKGFkZXYtPmdmeC5ybGMuaW5fc2FmZV9tb2RlKQogCQlyZXR1
cm47CiAKQEAgLTYwLDYgKzYyLDggQEAgdm9pZCBhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21v
ZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKi8KIHZvaWQgYW1kZ3B1X2dmeF9ybGNf
ZXhpdF9zYWZlX21vZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CisJcHJpbnRrKCJn
Znh2OCBzYWZlIG1vZGUgc3RhdGUgaXMgJWQgdG8gZXhpdFxuIiwKKwkgICAgICAgYWRldi0+Z2Z4
LnJsYy5pbl9zYWZlX21vZGUpOwogCWlmICghKGFkZXYtPmdmeC5ybGMuaW5fc2FmZV9tb2RlKSkK
IAkJcmV0dXJuOwogCkBAIC0xNDUsNyArMTQ5LDcgQEAgaW50IGFtZGdwdV9nZnhfcmxjX2luaXRf
Y3NiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWRzdF9wdHIgPSBhZGV2LT5nZngucmxj
LmNzX3B0cjsKIAlhZGV2LT5nZngucmxjLmZ1bmNzLT5nZXRfY3NiX2J1ZmZlcihhZGV2LCBkc3Rf
cHRyKTsKIAlhbWRncHVfYm9fa3VubWFwKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsK
LQlhbWRncHVfYm9fdW5waW4oYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmopOworCS8vYW1k
Z3B1X2JvX3VucGluKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKIAlhbWRncHVfYm9f
dW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKIAogCXJldHVybiAwOwot
LSAKMi43LjQKCg==

--_002_DM6PR12MB38662B2D1D1484202A22C85CEFDF0DM6PR12MB3866namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--_002_DM6PR12MB38662B2D1D1484202A22C85CEFDF0DM6PR12MB3866namp_--
