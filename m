From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Kernel crash/Null pointer dereference on vblank
Date: Thu, 23 Nov 2017 10:17:51 -0500
Message-ID: <eb1a453e-0705-ede7-bedd-dbc8668cd71d@amd.com>
References: <1228839336.50367.1511334398694@mailxchange.de>
 <20171122150721.GA3192@probook> <20171122223125.GA28038@probook>
 <58b24f03-b71b-4208-4cb7-4706ba947dea@amd.com>
 <20171123083135.GA3320@probook>
 <56b938ac-4597-a354-0f4a-0c2625b10c5a@amd.com>
 <20171123122711.GA3445@probook>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------9CD9E23FFCFCCD858A511A3E"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171123122711.GA3445@probook>
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
To: Johannes Hirte <johannes.hirte-rSzmJuYucINa7YElYzY8/Q@public.gmane.org>, Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Martin Babutzka <martin.babutzka-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

This is a multi-part message in MIME format.
--------------9CD9E23FFCFCCD858A511A3E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Johannes,

The s3 resume issue looks to be a problem with amdgpu/display. Could you 
give the attached patch a try?

Thanks,
Leo

On 2017-11-23 07:27 AM, Johannes Hirte wrote:
> On 2017 Nov 23, Chunming Zhou wrote:
>> See the attached email, they fixed same issue, each of them is ok to fix
>> your issue, your calltrace is  same as the second.
>>
>> We should already push the first patch in early time, could you check if
>> the first patch is in your branch?
>>
> 
> This patch (series) is not upstream yet. Just tested it, but this doesn't fix the
> use-after-free on S3 resume with dc enabled.
> 

--------------9CD9E23FFCFCCD858A511A3E
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-display-Do-not-put-drm_atomic_state-on-re.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-display-Do-not-put-drm_atomic_state-on-re.pa";
 filename*1="tch"

>From 8656ef112d53f8c08f6571dd0d093f03d2e6cc30 Mon Sep 17 00:00:00 2001
From: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 16 Nov 2017 15:17:27 -0500
Subject: [PATCH] drm/amdgpu/display: Do not put drm_atomic_state on resume

drm_atomic_helper_resume now puts it for us. See relevant patch here:
https://lists.freedesktop.org/archives/dri-devel/2017-October/154268.html

Change-Id: Ief246492f721a1cf281d48e9d1a7029e5cefc2da
Signed-off-by: Leo (Sunpeng) Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5731167..951ea77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -688,7 +688,6 @@ int amdgpu_dm_display_resume(struct amdgpu_device *adev)
 
 	ret = drm_atomic_helper_resume(ddev, adev->dm.cached_state);
 
-	drm_atomic_state_put(adev->dm.cached_state);
 	adev->dm.cached_state = NULL;
 
 	amdgpu_dm_irq_resume_late(adev);
-- 
2.7.4


--------------9CD9E23FFCFCCD858A511A3E
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------9CD9E23FFCFCCD858A511A3E--
