From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: Possible use_mm() mis-uses
Date: Wed, 22 Aug 2018 15:44:23 -0400
Message-ID: <e2f11cb5-33b0-b157-9703-95fe71a63c79@amd.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <744b92cb-133b-4c05-1416-06deb69e1e2c@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------13E8BEF41C2755C6DF2B00B9"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <744b92cb-133b-4c05-1416-06deb69e1e2c@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KVM list <kvm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, USB list <linux-usb@vger.kernel.org>, amd-gfx@lists.freedesktop.org, DRI <dri-devel@lists.freedesktop.org>, intel-gvt-dev@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--------------13E8BEF41C2755C6DF2B00B9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


On 2018-08-22 02:13 PM, Christian König wrote:
> Adding Felix because the KFD part of amdgpu is actually his
> responsibility.
>
> If I'm not completely mistaken the release callback of the
> mmu_notifier should take care of that for amdgpu.

You're right, but that's a bit fragile and convoluted. I'll fix KFD to
handle this more robustly. See the attached (untested) patch. And
obviously that opaque pointer didn't work as intended. It just gets
promoted to an mm_struct * without a warning from the compiler. Maybe I
should change that to a long to make abuse easier to spot.

Regards,
  Felix

>
> Regards,
> Christian.
>
> Am 22.08.2018 um 18:44 schrieb Linus Torvalds:
>> Guys and gals,
>>   this is a *very* random list of people on the recipients list, but we
>> had a subtle TLB shootdown issue in the VM, and that brought up some
>> issues when people then went through the code more carefully.
>>
>> I think we have a handle on the TLB shootdown bug itself. But when
>> people were discussing all the possible situations, one thing that
>> came up was "use_mm()" that takes a mm, and makes it temporarily the
>> mm for a kernel thread (until "unuse_mm()", duh).
>>
>> And it turns out that some of those uses are definitely wrong, some of
>> them are right, and some of them are suspect or at least so overly
>> complicated that it's hard for the VM people to know if they are ok.
>>
>> Basically, the rule for "use_mm()" is that the mm in question *has* to
>> have a valid page table associated with it over the whole use_mm() ->
>> unuse_mm() sequence. That may sound obvious, and I guess it actually
>> is so obvious that there isn't even a comment about it, but the actual
>> users are showing that it's sadly apparently not so obvious after all.
>>
>> There is one user that uses the "obviously correct" model: the vhost
>> driver does a "mmget()" and "mmput()" pair around its use of it,
>> thanks to vhost_dev_set_owner() doing a
>>
>>          dev->mm = get_task_mm(current);
>>
>> to look up the mm, and then the teardown case does a
>>
>>          if (dev->mm)
>>                  mmput(dev->mm);
>>          dev->mm = NULL;
>>
>> This is the *right* sequence. A gold star to the vhost people.
>>
>> Sadly, the vhost people are the only ones who seem to get things
>> unquestionably right. And some of those gold star people are also
>> apparently involved in the cases that didn't get things right.
>>
>> An example of something that *isn't* right, is the i915 kvm interface,
>> which does
>>
>>          use_mm(kvm->mm);
>>
>> on an mm that was initialized in virt/kvm/kvm_main.c using
>>
>>          mmgrab(current->mm);
>>          kvm->mm = current->mm;
>>
>> which is *not* right. Using "mmgrab()" does indeed guarantee the
>> lifetime of the 'struct mm_struct' itself, but it does *not* guarantee
>> the lifetime of the page tables. You need to use "mmget()" and
>> "mmput()", which get the reference to the actual process address
>> space!
>>
>> Now, it is *possible* that the kvm use is correct too, because kvm
>> does register a mmu_notifier chain, and in theory you can avoid the
>> proper refcounting by just making sure the mmu "release" notifier
>> kills any existing uses, but I don't really see kvm doing that. Kvm
>> does register a release notifier, but that just flushes the shadow
>> page tables, it doesn't kill any use_mm() use by some i915 use case.
>>
>> So while the vhost use looks right, the kvm/i915 use looks definitely
>> wrong.
>>
>> The other users of "use_mm()" and "unuse_mm()" are less
>> black-and-white right vs wrong..
>>
>> One of the complex ones is the amdgpu driver. It does a
>> "use_mm(mmptr)" deep deep in the guts of a macro that ends up being
>> used in fa few places, and it's very hard to tell if it's right.
>>
>> It looks almost certainly buggy (there is no mmget/mmput to get the
>> refcount), but there _is_ a "release" mmu_notifier function and that
>> one - unlike the kvm case - looks like it might actually be trying to
>> flush the existing pending users of that mm.
>>
>> But on the whole, I'm suspicious of the amdgpu use. It smells. Jann
>> Horn pointed out that even if it migth be ok due to the mmu_notifier,
>> the comments are garbage:
>>
>>>   Where "process" in the uniquely-named "struct queue" is a "struct
>>>   kfd_process"; that struct's definition has this comment in it:
>>>
>>>         /*
>>>          * Opaque pointer to mm_struct. We don't hold a reference to
>>>          * it so it should never be dereferenced from here. This is
>>>          * only used for looking up processes by their mm.
>>>          */
>>>         void *mm;
>>>
>>>   So I think either that comment is wrong, or their code is wrong?
>> so I'm chalking the amdgpu use up in the "broken" column.
>>
>> It's also actually quite hard to synchronze with some other kernel
>> worker thread correctly, so just on general principles, if you use
>> "use_mm()" it really really should be on something that you've
>> properly gotten a mm refcount on with mmget(). Really. Even if you try
>> to synchronize things.
>>
>> The two final cases are two uses in the USB gadget driver. Again, they
>> don't have the proper mmget/mmput, but they may br ok simply because
>> the uses are done for AIO, and the VM teardown is preceded by an AIO
>> teardown, so the proper serialization may come in from that.
>>
>> Anyway, sorry for the long email, and the big list of participants and
>> odd mailing lists, but I'd really like people to look at their
>> "use_mm()" cases, and ask themselves if they have done enough to
>> guarantee that the full mm exists. Again, "mmgrab()" is *not* enough
>> on its own. You need either "mmget()" or some lifetime guarantee.
>>
>> And if you do have those lifetime guarantees, it would be really nice
>> to get a good explanatory comment about said lifetime guarantees above
>> the "use_mm()" call. Ok?
>>
>> Note that the lifetime rules are very important, because obviously
>> use_mm() itself is never called in the context of the process that has
>> the mm. By definition, we're in a kernel thread and it uses somebody
>> elses mm. So it's important to show that that "somebody else" really
>> is serialized with the kernel thread somehow, and keeps the mm alive.
>> The easiest way by far to have that guarantee is to have that
>> "mmget/mmput" model.
>>
>> Please? Even if you're convinced your code is right, just a comment
>> about _why_ it's right, ok?
>>
>> And no, use_mm() cannot just do the mmget internally, only to have
>> unuse_mm() do the mmput().  That was our first reaction when looking
>> at this, but if the caller has screwed up the lifetime rules, it's not
>> actually clear that the mm is guaranteed to be around even when use_mm
>> is entered. So the onus of proper lifetime rules really is on the
>> caller, not on use_mm()/unuse_mm().
>>
>>               Linus
>


--------------13E8BEF41C2755C6DF2B00B9
Content-Type: text/x-patch;
 name="0001-drm-amdkfd-Fix-incorrect-use-of-process-mm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amdkfd-Fix-incorrect-use-of-process-mm.patch"

>From 05cdd85427c8ce6a05435df3ac2307cf362c1aec Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling@amd.com>
Date: Wed, 22 Aug 2018 15:28:44 -0400
Subject: [PATCH 1/1] drm/amdkfd: Fix incorrect use of process->mm

This mm_struct pointer should never be dereferenced. If running in
a user thread, just use current->mm. If running in a kernel worker
use get_task_mm to get a safe reference to the mm_struct.

Change-Id: Id42976075adce45007c10481c6a8f29df67e54a9
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 37 +++++++++++++++++-----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 405db4f..692ce2d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -383,8 +383,8 @@ static int create_compute_queue_nocpsch(struct device_queue_manager *dqm,
 					struct queue *q,
 					struct qcm_process_device *qpd)
 {
-	int retval;
 	struct mqd_manager *mqd_mgr;
+	int retval;
 
 	mqd_mgr = dqm->ops.get_mqd_manager(dqm, KFD_MQD_TYPE_COMPUTE);
 	if (!mqd_mgr)
@@ -412,8 +412,12 @@ static int create_compute_queue_nocpsch(struct device_queue_manager *dqm,
 	if (!q->properties.is_active)
 		return 0;
 
-	retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe, q->queue,
-			&q->properties, q->process->mm);
+	if (WARN(q->process->mm != current->mm,
+		 "should only run in user thread"))
+		retval = -EFAULT;
+	else
+		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe, q->queue,
+					   &q->properties, current->mm);
 	if (retval)
 		goto out_uninit_mqd;
 
@@ -570,9 +574,15 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
 		retval = map_queues_cpsch(dqm);
 	else if (q->properties.is_active &&
 		 (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-		  q->properties.type == KFD_QUEUE_TYPE_SDMA))
-		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe, q->queue,
-				       &q->properties, q->process->mm);
+		  q->properties.type == KFD_QUEUE_TYPE_SDMA)) {
+		if (WARN(q->process->mm != current->mm,
+			 "should only run in user thread"))
+			retval = -EFAULT;
+		else
+			retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd,
+						   q->pipe, q->queue,
+						   &q->properties, current->mm);
+	}
 
 out_unlock:
 	dqm_unlock(dqm);
@@ -678,6 +688,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 					  struct qcm_process_device *qpd)
 {
+	struct mm_struct *mm = NULL;
 	struct queue *q;
 	struct mqd_manager *mqd_mgr;
 	struct kfd_process_device *pdd;
@@ -711,6 +722,15 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		kfd_flush_tlb(pdd);
 	}
 
+	/* Take a safe reference to the mm_struct, which may otherwise
+	 * disappear even while the kfd_process is still referenced.
+	 */
+	mm = get_task_mm(pdd->process->lead_thread);
+	if (!mm) {
+		retval = -EFAULT;
+		goto out;
+	}
+
 	/* activate all active queues on the qpd */
 	list_for_each_entry(q, &qpd->queues_list, list) {
 		if (!q->properties.is_evicted)
@@ -725,14 +745,15 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		q->properties.is_evicted = false;
 		q->properties.is_active = true;
 		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
-				       q->queue, &q->properties,
-				       q->process->mm);
+				       q->queue, &q->properties, mm);
 		if (retval)
 			goto out;
 		dqm->queue_count++;
 	}
 	qpd->evicted = 0;
 out:
+	if (mm)
+		mmput(mm);
 	dqm_unlock(dqm);
 	return retval;
 }
-- 
2.7.4


--------------13E8BEF41C2755C6DF2B00B9
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--------------13E8BEF41C2755C6DF2B00B9--
