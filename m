From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: dmesg warning during init
Date: Mon, 16 Jul 2018 18:35:18 +0200
Message-ID: <bc26fc6d-d0ce-8c17-7fbf-83ea3fc1abb3@daenzer.net>
References: <4202bddf-090d-dd45-6b0a-aeb3a2534f3c@amd.com>
 <2b60a98b-f4a5-9dab-24be-ead1da757dcd@daenzer.net>
 <aff64c92-6611-041f-319b-fd444f67a239@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------BE3CB5379E600B12521AD640"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <aff64c92-6611-041f-319b-fd444f67a239-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------BE3CB5379E600B12521AD640
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-07-16 05:55 PM, Tom St Denis wrote:
> I have the same now and get the attached dmesg.

Still all question marks. :( Anyway, looks like it's probably from
ttm_bo_delayed_delete, but that still doesn't tell us where the BO is
really freed from.


Can you try the attached patch and see if the warning message triggers?
If yes, what error does it report?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------BE3CB5379E600B12521AD640
Content-Type: text/x-patch;
 name="amdgpu_bo_free_kernel-warn.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="amdgpu_bo_free_kernel-warn.diff"

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
index b12526ce1a9d..89669544ffa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -361,16 +361,21 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *a=
dev,
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr)
 {
+	int r;
+
 	if (*bo =3D=3D NULL)
 		return;
=20
-	if (likely(amdgpu_bo_reserve(*bo, true) =3D=3D 0)) {
+	r =3D amdgpu_bo_reserve(*bo, true);
+	if (likely(r =3D=3D 0)) {
 		if (cpu_addr)
 			amdgpu_bo_kunmap(*bo);
=20
 		amdgpu_bo_unpin(*bo);
 		amdgpu_bo_unreserve(*bo);
-	}
+	} else
+		DRM_WARN_ONCE("amdgpu_bo_reserve returned %d, can't unpin kernel BO\n"=
, r);
+
 	amdgpu_bo_unref(bo);
=20
 	if (gpu_addr)

--------------BE3CB5379E600B12521AD640
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------BE3CB5379E600B12521AD640--
