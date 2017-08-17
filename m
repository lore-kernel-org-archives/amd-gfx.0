From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: bug running amd-staging-4.12
Date: Thu, 17 Aug 2017 12:26:59 +0200
Message-ID: <613c1faa-612c-6409-9f59-c8584b303e3a@vodafone.de>
References: <CAPM=9tyGk7b5whTDz7yFsitcbjCHy_ojjmxgDswotVCXz0WZtw@mail.gmail.com>
 <0fb7e310-99c0-a887-0681-846b6fff38d6@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2BEFD815D30BA9607FA94887"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0fb7e310-99c0-a887-0681-846b6fff38d6-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------2BEFD815D30BA9607FA94887
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thinking more about it, can you try the attached patch?

Thanks,
Christian.

Am 17.08.2017 um 11:27 schrieb Christian König:
> Not the slightest idea, but you are not the first one complaining 
> about problems.
>
> How do you trigger that?
>
> Christian.
>
> Am 17.08.2017 um 03:16 schrieb Dave Airlie:
>> I'm seeing this go past a fair bit.
>>
>> Dave.
>>
>> [ 3640.825412] BUG: sleeping function called from invalid context at
>> /home/airlied/devel/kernel/linux-2.6/kernel/locking/mutex.c:979
>> [ 3640.825415] in_atomic(): 1, irqs_disabled(): 0, pid: 2733, name: 
>> deqp-vk
>> [ 3640.825416] INFO: lockdep is turned off.
>> [ 3640.825419] CPU: 5 PID: 2733 Comm: deqp-vk Tainted: G W
>>   4.12.0+ #225
>> [ 3640.825420] Hardware name: To be filled by O.E.M. To be filled by
>> O.E.M./M5A97 R2.0, BIOS 2603 06/26/2015
>> [ 3640.825422] Call Trace:
>> [ 3640.825428]  dump_stack+0x68/0x92
>> [ 3640.825430]  ___might_sleep+0x1e9/0x1fc
>> [ 3640.825433]  __might_sleep+0x68/0x6f
>> [ 3640.825435]  ww_mutex_lock+0x20/0x4e
>> [ 3640.825443]  ttm_bo_unref+0x252/0x43f [ttm]
>> [ 3640.825507]  amdgpu_bo_unref+0x22/0x34 [amdgpu]
>> [ 3640.825543]  amdgpu_vm_free_levels+0x26/0x59 [amdgpu]
>> [ 3640.825578]  amdgpu_vm_free_levels+0x57/0x59 [amdgpu]
>> [ 3640.825614]  amdgpu_vm_fini+0x1c6/0x212 [amdgpu]
>> [ 3640.825650]  ? amdgpu_vm_bo_rmv+0x21b/0x280 [amdgpu]
>> [ 3640.825684]  amdgpu_driver_postclose_kms+0x157/0x1d9 [amdgpu]
>> [ 3640.825701]  drm_release+0x28e/0x30f [drm]
>> [ 3640.825704]  __fput+0x100/0x1bb
>> [ 3640.825706]  ____fput+0x9/0xb
>> [ 3640.825708]  task_work_run+0x72/0x9b
>> [ 3640.825711]  do_exit+0x4f3/0xab1
>> [ 3640.825713]  ? lock_acquire+0x125/0x1b9
>> [ 3640.825716]  do_group_exit+0x45/0xb0
>> [ 3640.825718]  get_signal+0x6e1/0x77f
>> [ 3640.825722]  do_signal+0x23/0x546
>> [ 3640.825724]  ? __send_signal+0x2df/0x70c
>> [ 3640.825727]  ? trace_hardirqs_on+0xd/0xf
>> [ 3640.825729]  ? force_sig_info+0xc0/0xcf
>> [ 3640.825732]  exit_to_usermode_loop+0x39/0x7b
>> [ 3640.825734]  prepare_exit_to_usermode+0x3c/0x51
>> [ 3640.825736]  retint_user+0x8/0x1d
>> [ 3640.825738] RIP: 0033:0x7f8885f25f8f
>> [ 3640.825739] RSP: 002b:00007fffffffce90 EFLAGS: 00000206
>> [ 3640.825742] RAX: 0000000002244400 RBX: 00007fffffffd140 RCX: 
>> 00000000024e9950
>> [ 3640.825743] RDX: 00000000024e9800 RSI: 00000000024e9950 RDI: 
>> 0000000002244400
>> [ 3640.825744] RBP: 00007fffffffcf20 R08: 0000000000000001 R09: 
>> 0000000002244400
>> [ 3640.825745] R10: 00000000024e9940 R11: 0000000000000100 R12: 
>> 0000000000000000
>> [ 3640.825746] R13: 0000000002244400 R14: 0000000000000009 R15: 
>> 0000000000000001
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------2BEFD815D30BA9607FA94887
Content-Type: text/x-patch;
 name="0001-drm-ttm-use-reservation_object_trylock-in-ttm_bo_ind.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-drm-ttm-use-reservation_object_trylock-in-ttm_bo_ind.pa";
 filename*1="tch"

>From ee634f22b5adb9ae670be20ff721b37da2e932b7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 17 Aug 2017 12:23:51 +0200
Subject: [PATCH] drm/ttm: use reservation_object_trylock in
 ttm_bo_individualize_resv
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes a false positive from might_sleep(). The reservation object is freshly
initialized, so nobody else can hold the mutex but the function is
called from atomic context.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 58e7fce..573ce1e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -403,7 +403,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 		return 0;
 
 	reservation_object_init(&bo->ttm_resv);
-	BUG_ON(reservation_object_lock(&bo->ttm_resv, NULL));
+	BUG_ON(reservation_object_trylock(&bo->ttm_resv));
 
 	r = reservation_object_copy_fences(&bo->ttm_resv, bo->resv);
 	if (r) {
-- 
2.7.4


--------------2BEFD815D30BA9607FA94887
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------2BEFD815D30BA9607FA94887--
