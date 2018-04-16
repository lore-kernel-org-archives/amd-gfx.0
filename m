From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Gamma problem after 4096 LUT entries change
Date: Mon, 16 Apr 2018 10:07:10 -0400
Message-ID: <7e45e177-ce05-746a-d91d-1917f3257de1@amd.com>
References: <235ddff0-f299-264b-1d6c-a97a6012e8dc@moshe.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------50C95F466E885816FA9A68C3"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <235ddff0-f299-264b-1d6c-a97a6012e8dc-A/3C56C7qwM@public.gmane.org>
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
To: =?UTF-8?Q?M=c3=b4she_van_der_Sterre?= <me-A/3C56C7qwM@public.gmane.org>, "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------50C95F466E885816FA9A68C3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-04-15 05:37 AM, Môshe van der Sterre wrote:
> Hello Leo Li,
> 
> The current mainline has a gamma regression for me, running wayland on a Ryzen 5 2400G (integrated gpu). Colors are much too dark after the following commit:
> 086247a4b2fb "drm/amd/display: Use 4096 lut entries"
> 
> From this commit alone I cannot deduce how to properly address the problem. Reverting restores the correct colors. Unfortunately, I have no other amdgpu hardware to test if this is specific to the integrated gpu or not.
> 
> I'll gladly test possible fixes or debug a little further if you can point me in the right direction.
> 

Can you give attached patch a spin. We'll probably merge it or a variant of it soon.

Harry

> Thanks,
> Môshe van der Sterre
> 
> 

--------------50C95F466E885816FA9A68C3
Content-Type: text/x-patch;
 name="0001-drm-amd-display-Don-t-program-bypass-on-linear-regam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amd-display-Don-t-program-bypass-on-linear-regam.pa";
 filename*1="tch"

>From 9adc614f258ba021aa70eeed92ecb0613406cf09 Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 12 Apr 2018 16:37:09 -0400
Subject: [PATCH] drm/amd/display: Don't program bypass on linear regamma LUT

Even though this is required for degamma since DCE HW only supports a
couple predefined LUTs we can just program the LUT directly.

This fixes dark screens which occurs when we program regamma to bypass
while degamma is using srgb LUT.

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ef5fad8c5aac..59e993ad1209 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -133,19 +133,15 @@ int amdgpu_dm_set_regamma_lut(struct dm_crtc_state *crtc)
 		/* By default, use the SRGB predefined curve.*/
 		stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
+
+		DRM_DEBUG_KMS("Using pre-defined regamma\n");
+
 		return 0;
 	}
 
 	lut = (struct drm_color_lut *)blob->data;
 	lut_size = blob->length / sizeof(struct drm_color_lut);
 
-	if (__is_lut_linear(lut, lut_size)) {
-		/* Set to bypass if lut is set to linear */
-		stream->out_transfer_func->type = TF_TYPE_BYPASS;
-		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
-		return 0;
-	}
-
 	gamma = dc_create_gamma();
 	if (!gamma)
 		return -ENOMEM;
@@ -161,6 +157,8 @@ int amdgpu_dm_set_regamma_lut(struct dm_crtc_state *crtc)
 		return -EINVAL;
 	}
 
+	DRM_DEBUG_KMS("Using regamma with %d entries\n", lut_size);
+
 	/* Convert drm_lut into dc_gamma */
 	__drm_lut_to_dc_gamma(lut, gamma, gamma->type == GAMMA_RGB_256);
 
-- 
2.17.0


--------------50C95F466E885816FA9A68C3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------50C95F466E885816FA9A68C3--
