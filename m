From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] [V2]drm/amdgpu: disable dpm before turn off clock when
 vce idle.
Date: Wed, 26 Oct 2016 10:46:14 +0000
Message-ID: <CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0CY4PR12MB1687namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--_002_CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/ci_dpm.c
index 54a7019..8f6e7a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
@@ -4258,13 +4258,12 @@ static int ci_update_vce_dpm(struct amdgpu_device *=
adev,
=20
 			ret =3D ci_enable_vce_dpm(adev, true);
 		} else {
+			ret =3D ci_enable_vce_dpm(adev, false);
+			if (ret)
+				return ret;
 			/* turn the clocks off when not encoding */
 			ret =3D amdgpu_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							    AMD_CG_STATE_GATE);
-			if (ret)
-				return ret;
-
-			ret =3D ci_enable_vce_dpm(adev, false);
 		}
 	}
 	return ret;
--=20
1.9.1

--_002_CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0CY4PR12MB1687namp_
Content-Type: application/octet-stream;
	name="0005-drm-amdgpu-disable-dpm-before-turn-off-clock-when-vc.patch"
Content-Description: 0005-drm-amdgpu-disable-dpm-before-turn-off-clock-when-vc.patch
Content-Disposition: attachment;
	filename="0005-drm-amdgpu-disable-dpm-before-turn-off-clock-when-vc.patch";
	size=1034; creation-date="Wed, 26 Oct 2016 10:45:53 GMT";
	modification-date="Wed, 26 Oct 2016 10:32:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzNzc4ZDNkNjA0ODc4MzM5M2EwZDhjOTNiYmE1NWFjODRlN2E2ZGE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IFdlZCwg
MjYgT2N0IDIwMTYgMTc6MDU6MzAgKzA4MDAKU3ViamVjdDogW1BBVENIIDUvNl0gZHJtL2FtZGdw
dTogZGlzYWJsZSBkcG0gYmVmb3JlIHR1cm4gb2ZmIGNsb2NrIHdoZW4gdmNlCiBpZGxlLgoKU2ln
bmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2NpX2RwbS5jIHwgNyArKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMK
aW5kZXggNTRhNzAxOS4uOGY2ZTdhMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvY2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMK
QEAgLTQyNTgsMTMgKzQyNTgsMTIgQEAgc3RhdGljIGludCBjaV91cGRhdGVfdmNlX2RwbShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAogCQkJcmV0ID0gY2lfZW5hYmxlX3ZjZV9kcG0oYWRl
diwgdHJ1ZSk7CiAJCX0gZWxzZSB7CisJCQlyZXQgPSBjaV9lbmFibGVfdmNlX2RwbShhZGV2LCBm
YWxzZSk7CisJCQlpZiAocmV0KQorCQkJCXJldHVybiByZXQ7CiAJCQkvKiB0dXJuIHRoZSBjbG9j
a3Mgb2ZmIHdoZW4gbm90IGVuY29kaW5nICovCiAJCQlyZXQgPSBhbWRncHVfc2V0X2Nsb2NrZ2F0
aW5nX3N0YXRlKGFkZXYsIEFNRF9JUF9CTE9DS19UWVBFX1ZDRSwKIAkJCQkJCQkgICAgQU1EX0NH
X1NUQVRFX0dBVEUpOwotCQkJaWYgKHJldCkKLQkJCQlyZXR1cm4gcmV0OwotCi0JCQlyZXQgPSBj
aV9lbmFibGVfdmNlX2RwbShhZGV2LCBmYWxzZSk7CiAJCX0KIAl9CiAJcmV0dXJuIHJldDsKLS0g
CjEuOS4xCgo=

--_002_CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0CY4PR12MB1687namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_002_CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0CY4PR12MB1687namp_--
