From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] libdrm: clean up non list code path for vamgr
Date: Mon, 19 Feb 2018 02:25:09 -0500
Message-ID: <dcb5a4b1-f959-107b-d4af-18758fbf74cd@amd.com>
References: <20180112054554.19585-1-david1.zhou@amd.com>
 <20180112054554.19585-2-david1.zhou@amd.com>
 <e3722edc-8ca4-4730-d649-2b5a959b92c1@daenzer.net>
 <4a2036e5-820f-d62a-a773-2da1f575e1bc@amd.com>
 <c6b30b81-8b6f-3b5a-5654-e8075939143e@amd.com>
 <c7eaf026-f0f5-fab3-4bab-c11b39701e6a@daenzer.net>
 <881720e0-3225-dd36-23f7-146b9bfb919d@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------770F5E41F38EDBE9AF30EE0F"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <881720e0-3225-dd36-23f7-146b9bfb919d-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hui.Deng-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--------------770F5E41F38EDBE9AF30EE0F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Found time to do some debugging and found error in assigning   of 
initial VA hole size, attached patch makes this issue go away, otherwise 
amdgpu_vamgr_find_va would always fail.

Thanks,

Andrey


On 02/18/2018 03:41 AM, Andrey Grodzovsky wrote:
> Hi David, I have an issue on Vega 10 where sudo xinit fails with
>
> [  5801.227] Failed to allocate front buffer memory
> [  5801.227] (EE) AMDGPU(0): amdgpu_setup_kernel_mem failed
> [  5801.227] (EE)
> Fatal server error:
> [  5801.227] (EE) AddScreen/ScreenInit failed for driver 0
> [  5801.227] (EE)
> [  5801.227] (EE)
>
> Also  in MESA code 
> si_create_context->si_common_context_init->pipe_buffer_create returns 
> NULL.
>
> Ellsmire works fine, on Vega 10 reverting this patch makes it work.
>
> I am during my test system upgrade right now with some more issues 
> after this one, so I can spend time on debugging this once my system 
> is in good shape, unless you have an answer to this problem right away.
>
> Thanks,
>
> Andrey
>
>
> On 02/09/2018 03:58 AM, Michel Dänzer wrote:
>> On 2018-02-09 07:01 AM, Chunming Zhou wrote:
>>> On 2018年02月08日 17:13, Chunming Zhou wrote:
>>>> On 2018年02月08日 17:01, Michel Dänzer wrote:
>>>>> this change completely broke radeonsi due to memory management errors
>>>>> (see valgrind output for glxgears below), so I had to revert it.
>>>> ok, I will look into what happens. Sorry for broken.
>>> The patch lost a "goto out" in free_va when applying patch from hybrid
>>> to opensource.
>>> The attached fixes that, I tested successfully in my local side.
>>>   please review or test, if no problem, I will submit it again.
>> Please add:
>>
>> v2: Add missing "goto out"
>> Tested-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>
>> to the commit log before pushing.
>>
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------770F5E41F38EDBE9AF30EE0F
Content-Type: text/x-patch;
 name="0001-amdgpu-Fix-mistake-in-initial-hole-size-calculation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-amdgpu-Fix-mistake-in-initial-hole-size-calculation.pat";
 filename*1="ch"

>From 020b68cf0f5a3c5a1ea4dc48df6a895904da28b6 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 19 Feb 2018 02:18:36 -0500
Subject: amdgpu: Fix mistake in initial hole size calculation.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 amdgpu/amdgpu_vamgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu_vamgr.c b/amdgpu/amdgpu_vamgr.c
index 722067f..5840042 100644
--- a/amdgpu/amdgpu_vamgr.c
+++ b/amdgpu/amdgpu_vamgr.c
@@ -57,7 +57,7 @@ drm_private void amdgpu_vamgr_init(struct amdgpu_bo_va_mgr *mgr, uint64_t start,
 	pthread_mutex_init(&mgr->bo_va_mutex, NULL);
 	pthread_mutex_lock(&mgr->bo_va_mutex);
 	n = calloc(1, sizeof(struct amdgpu_bo_va_hole));
-	n->size = mgr->va_max;
+	n->size = mgr->va_max - start;
 	n->offset = start;
 	list_add(&n->list, &mgr->va_holes);
 	pthread_mutex_unlock(&mgr->bo_va_mutex);
@@ -80,6 +80,7 @@ amdgpu_vamgr_find_va(struct amdgpu_bo_va_mgr *mgr, uint64_t size,
 	struct amdgpu_bo_va_hole *hole, *n;
 	uint64_t offset = 0, waste = 0;
 
+
 	alignment = MAX2(alignment, mgr->va_alignment);
 	size = ALIGN(size, mgr->va_alignment);
 
-- 
2.7.4


--------------770F5E41F38EDBE9AF30EE0F
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------770F5E41F38EDBE9AF30EE0F--
