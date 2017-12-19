From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Simplify amdgpu_lockup_timeout usage.
Date: Tue, 19 Dec 2017 18:47:41 +0100
Message-ID: <f5351f8f-ad38-5517-ae87-e5d8efab1839@amd.com>
References: <1513194292-8416-1-git-send-email-andrey.grodzovsky@amd.com>
 <966ada12-9d57-b6bd-37a2-494f6dfa67cd@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------02AC34F577CB35312EABF182"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <966ada12-9d57-b6bd-37a2-494f6dfa67cd-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------02AC34F577CB35312EABF182
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, that is a known issue which came to front again because Andrey's 
patch is slightly buggy.

Please test and review the attached (only compile tested) fix for 
Andrey's patch.

Still working on finding the root cause, but so far didn't had time for 
that.

Regards,
Christian.

Am 19.12.2017 um 18:26 schrieb Michel Dänzer:
> On 2017-12-13 08:44 PM, Andrey Grodzovsky wrote:
>> With introduction of amdgpu_gpu_recovery we don't need any more
>> to rely on amdgpu_lockup_timeout == 0 for disabling GPU reset.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> Since this change landed, I'm once again unable to finish a piglit run
> on my development machine, see the attached dmesg output (happens pretty
> quickly, after ~5% of piglit tests have run). I realized that with
> lockup_timeout != 0, the
>
> 	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_SYSTEM);
>
> at the top of amdgpu_bo_gpu_offset has been triggering since the 4.15
> development cycle. See the bisection result below. Note that I'm not
> 100% sure this is the correct guilty commit, since it's probably been
> the most painful bisection I've ever done so far (14 skips, had to
> revert 4 commits causing other regressions). But I'm quite sure this
> regression happened in the
> 84d43463a2d09c28c9222fbb7d1082c078e2523a..3f3333f8a0e90ac26f84ed7b0aa344efce695c08
> range.
>
>
> 3f3333f8a0e90ac26f84ed7b0aa344efce695c08 is the first bad commit
> commit 3f3333f8a0e90ac26f84ed7b0aa344efce695c08
> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Date:   Thu Aug 3 14:02:13 2017 +0200
>
>      drm/amdgpu: track evicted page tables v2
>
>      Instead of validating all page tables when one was evicted,
>      track which one needs a validation.
>
>      v2: simplify amdgpu_vm_ready as well
>
>      Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>      Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org> (v1)
>      Reviewed-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
>
>


--------------02AC34F577CB35312EABF182
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-fix-test-for-shadow-page-tables.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-fix-test-for-shadow-page-tables.patch"

>From 769eb5d08910e16058902fada499d21655ccdba4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 19 Dec 2017 18:44:43 +0100
Subject: [PATCH] drm/amdgpu: fix test for shadow page tables
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

They don't work 100% correctly at the moment.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c87b7f902c9..9fac284315cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2833,7 +2833,11 @@ bool amdgpu_need_backup(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-	return amdgpu_gpu_recovery;
+	if (amdgpu_gpu_recovery == 0 ||
+	    (amdgpu_gpu_recovery == -1  && !amdgpu_sriov_vf(adev)))
+		return false;
+
+	return true;
 }
 
 static int amdgpu_recover_vram_from_shadow(struct amdgpu_device *adev,
-- 
2.11.0


--------------02AC34F577CB35312EABF182
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------02AC34F577CB35312EABF182--
