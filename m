From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [DC] [CRTC:44:crtc-0] vblank wait timed out
Date: Tue, 14 Nov 2017 20:52:20 -0500
Message-ID: <85a4cd81-b891-d64f-be2c-40a42a2ab7e8@amd.com>
References: <b7843d0b-40fe-0288-bbc6-ca55b6d87a6c@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------816EA1816827EFA973844E47"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b7843d0b-40fe-0288-bbc6-ca55b6d87a6c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "sw.dl.display.sudo" <sw.dl.display.sudo-5C7GfCeVMHo@public.gmane.org>, dc_upstream-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--------------816EA1816827EFA973844E47
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Can you try this patch ? I noticed there is a new API to use to wait for 
flips instead of what we are using now.

Thanks,
Andrey

On 2017-11-14 01:06 PM, Michel Dänzer wrote:
> I sometimes get the attached dmesg splat when the GDM login screen times
> out and fades to black (presumably specifically when it finally sets
> DPMS off, which disables the vblank interrupt).
>
> I've seen this for the first time today, so it might have been
> introduced by one of the DC changes which landed in amd-staging-drm-next
> since yesterday. But since it doesn't happen every time, I can't be sure
> of that yet.
>
>


--------------816EA1816827EFA973844E47
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-display-Switch-to-drm_atomic_helper_wait_.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-display-Switch-to-drm_atomic_helper_wait_.pa";
 filename*1="tch"

>From 301759d8cb7a4ccfbe3a219d91bebbec9a256d11 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 14 Nov 2017 20:45:52 -0500
Subject: drm/amdgpu/display: Switch to drm_atomic_helper_wait_for_flip_done

This new helper function is advised to be used for drviers that
use the nonblocking commit tracking support instead of
drm_atomic_helper_wait_for_vblanks.

Signed-off-by: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 39e751d..088d154 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4255,7 +4255,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_commit_hw_done(state);
 
 	if (wait_for_vblank)
-		drm_atomic_helper_wait_for_vblanks(dev, state);
+		drm_atomic_helper_wait_for_flip_done(dev, state);
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
-- 
2.7.4


--------------816EA1816827EFA973844E47
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------816EA1816827EFA973844E47--
