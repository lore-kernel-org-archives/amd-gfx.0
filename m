From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Date: Thu, 14 Nov 2019 17:14:20 -0500
Message-ID: <e267429b-9c80-a9e7-7ffd-75ec439ed759@amd.com>
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
 <70c2c1cc-40b8-30da-7aee-f59fbc4d0d42@amd.com>
 <DM6PR12MB2971859C1BF16EE7E65B35B18F7B0@DM6PR12MB2971.namprd12.prod.outlook.com>
 <d6f9c508-3c23-c797-1cbc-7502dc4c0b13@amd.com>
 <DM6PR12MB29714AB9AD16FA3ABD7D62C28F7B0@DM6PR12MB2971.namprd12.prod.outlook.com>
 <dcc1124b-5e19-b018-7449-659a8b7d74ea@amd.com>
 <DM6PR12MB29710DFE90F22F5903499AFE8F7B0@DM6PR12MB2971.namprd12.prod.outlook.com>
 <91f4a0c4-23e3-a399-5cb1-fb01da922784@amd.com>
 <MWHPR12MB1453817C6F05A57FD431E159EA770@MWHPR12MB1453.namprd12.prod.outlook.com>
 <MN2PR12MB29750EDB35E27DF9CD63152C8F770@MN2PR12MB2975.namprd12.prod.outlook.com>
 <2f035f22-4057-dd9e-27ef-0f5612113e29@amd.com>
 <9269d447-ed32-81f7-ab43-cb16139096e2@amd.com>
 <33ffe2f1-32b6-a238-3752-cee67cd9e141@gmail.com>
 <40bb3114-d996-10af-3140-51a4f7c212d6@amd.com>
 <0858ea1b-d205-006d-a6ec-24b78b33e45b@amd.com>
 <c784ef0a-2cd7-d4b1-0581-356d8c401102@amd.com>
 <088fb2bc-b401-17cc-4d7c-001705ee1eb9@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C51FE0116A9075E0A86FF8EC"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <088fb2bc-b401-17cc-4d7c-001705ee1eb9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------C51FE0116A9075E0A86FF8EC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Attached.

Emily - can you give it a try ?

Andrey

On 11/14/19 3:12 AM, Christian König wrote:
>> What about instead of peeking at the job to actually remove it from 
>> ring_mirror_list right there,
> Also an interesting idea. We would need to protect the mirror list 
> with a lock again, but that should be the lesser evil.
>
> Maybe prototype that and see if it works or not.
>
> Regards,
> Christian.
>
> Am 13.11.19 um 17:00 schrieb Andrey Grodzovsky:
>>
>>
>> On 11/13/19 9:20 AM, Christian König wrote:
>>> Another more fundamental question: Could we get rid of the timeout 
>>> job at all?
>>
>>
>> There are other stuff there besides picking the first unfinished job 
>> which is common for all the drivers - such as freeing guilty signaled 
>> job and rearming the timeout work timer.
>>
>>
>>>
>>> I mean we used to give this as parameter to the scheduler callback 
>>> because we had the timeout worker in the job, but that is no longer 
>>> the case.
>>>
>>> E.g. in drm_sched_job_timedout() we do the following:
>>>>         job = list_first_entry_or_null(&sched->ring_mirror_list,
>>>>                                        struct drm_sched_job, node);
>>>
>>> Why don't we just remove that here and only get the first job after 
>>> we have stopped the scheduler?
>>
>>
>> Should be ok since we have the extra check for __kthread_should_park 
>> in drm_sched_cleanup_jobs which will protect us in this case from a 
>> wakeup of sched thread and execution of in drm_sched_cleanup_jobs 
>> after we already parked it. The problem here is we need the 
>> drm_sched_job to access the private data for each client driver (see 
>> amdgpu_job_timedout for example). What about instead of peeking at 
>> the job to actually remove it from ring_mirror_list right there, go 
>> ahead with it through the reset routine, if it's signaled in the 
>> meanwhile that great - release it, otherwise put it back into 
>> ring_mirror_list in drm_sched_resubmit_jobs.
>>
>> Andrey
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 13.11.19 um 15:12 schrieb Andrey Grodzovsky:
>>>>
>>>> This why I asked for a trace with timer enabled, but since there is 
>>>> a finite number of places we touch the timer Emily can just put 
>>>> prints there. Also, I wonder if this temp fix helps her with the 
>>>> issue or not.
>>>>
>>>> Andrey
>>>>
>>>> On 11/13/19 2:36 AM, Christian König wrote:
>>>>> The question is where do we rearm the timer for this problem to 
>>>>> occur?
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> Am 12.11.19 um 20:21 schrieb Andrey Grodzovsky:
>>>>>>
>>>>>> I was able to reproduce the crash by using the attached 
>>>>>> simulate_crash.patch - waiting on guilty job to signal in reset 
>>>>>> work and artificially rearming the timeout timer just before the 
>>>>>> check for !cancel_delayed_work(&sched->work_tdr)  in 
>>>>>> drm_sched_cleanup_jobs - crash log attached in crash.log. This I 
>>>>>> think confirms my theory i described earlier in this thread.
>>>>>>
>>>>>> basic_fix.patch handles this by testing whether another timer 
>>>>>> already armed ob this scheduler or is there a timeout work in 
>>>>>> execution right now (see documentation for work_busy) - 
>>>>>> obviously  this is not a full solution as this will not protect 
>>>>>> from races if for example there is immediate work scheduling such 
>>>>>> as in drm_sched_fault -  so we probably need to account for this 
>>>>>> by making drm_sched_cleanup_jobs (at least in the part where it 
>>>>>> iterates ring mirror list and frees jobs) and GPU reset really 
>>>>>> mutually exclusive and not like now.
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>> On 11/11/19 4:11 PM, Christian König wrote:
>>>>>>> Hi Emily,
>>>>>>>
>>>>>>> you need to print which scheduler instance is freeing the jobs 
>>>>>>> and which one is triggering the reset. The TID and PID is 
>>>>>>> completely meaningless here since we are called from different 
>>>>>>> worker threads and the TID/PID can change on each call.
>>>>>>>
>>>>>>> Apart from that I will look into this a bit deeper when I have 
>>>>>>> time.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>> Am 12.11.19 um 07:02 schrieb Deng, Emily:
>>>>>>>> Hi Christian,
>>>>>>>>     I add the follow print in function drm_sched_cleanup_jobs. 
>>>>>>>> From the log it shows that only use cancel_delayed_work could 
>>>>>>>> not avoid to free job when the sched is in reset. But don’t 
>>>>>>>> know exactly where it is wrong about the driver. Do you have 
>>>>>>>> any suggestion about this?
>>>>>>>> + printk("Emily:drm_sched_cleanup_jobs:begin,tid:%lu, 
>>>>>>>> pid:%lu\n", current->tgid, current->pid);
>>>>>>>>         /*
>>>>>>>>          * Don't destroy jobs while the timeout worker is 
>>>>>>>> running  OR thread
>>>>>>>>          * is being parked and hence assumed to not touch 
>>>>>>>> ring_mirror_list
>>>>>>>>          */
>>>>>>>>          if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>>>>>>>> !cancel_delayed_work(&sched->work_tdr)))
>>>>>>>>                 return;
>>>>>>>> + printk("Emily:drm_sched_cleanup_jobs,tid:%lu, pid:%lu\n", 
>>>>>>>> current->tgid, current->pid);
>>>>>>>> Best wishes
>>>>>>>> Emily Deng
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11380.695091] Emily:drm_sched_cleanup_jobs:begin,tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11380.695104] Emily:drm_sched_cleanup_jobs:begin,tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11380.695105] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11380.695107] Emily:drm_sched_cleanup_jobs:begin,tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11380.695107] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.222954] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring 
>>>>>>>> sdma0 timeout, signaled seq=78585, emitted seq=78587
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.224275] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* 
>>>>>>>> Process information: process pid 0 thread pid 0, 
>>>>>>>> s_job:00000000fe75ab36,tid=15603, pid=15603
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225413] amdgpu 0000:00:08.0: GPU reset begin!
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225417] Emily:drm_sched_cleanup_jobs:begin,tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225425] Emily:drm_sched_cleanup_jobs:begin,tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225425] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225428] Emily:amdgpu_job_free_cb,Process information: 
>>>>>>>> process  pid 0 thread  pid 0, s_job:00000000fe75ab36, tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225429] Emily:drm_sched_cleanup_jobs:begin,tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225430] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225473] Emily:drm_sched_cleanup_jobs:begin,tid:2253, 
>>>>>>>> pid:2253
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225486] Emily:drm_sched_cleanup_jobs:begin,tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225489] Emily:drm_sched_cleanup_jobs,tid:2262, pid:2262
>>>>>>>> Nov 12 12:58:20 ubuntu-drop-August-2018-rc2-gpu0-vf02 kernel: 
>>>>>>>> [11381.225494] Emily:amdgpu_job_free_cb,Process information: 
>>>>>>>> process  pid 0 thread  pid 0, s_job:00000000f086ec84, tid:2262, 
>>>>>>>> pid:2262
>>>>>>>> >-----Original Message-----
>>>>>>>> >From: Grodzovsky, Andrey <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >Sent: Tuesday, November 12, 2019 11:28 AM
>>>>>>>> >To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Deng, Emily
>>>>>>>> ><Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue 
>>>>>>>> for tdr
>>>>>>>> >
>>>>>>>> >Thinking more about this claim - we assume here that if 
>>>>>>>> cancel_delayed_work
>>>>>>>> >returned true it guarantees that timeout work is not running 
>>>>>>>> but, it merely
>>>>>>>> >means there was a pending timeout work which was removed from the
>>>>>>>> >workqueue before it's timer elapsed and so it didn't have a 
>>>>>>>> chance to be
>>>>>>>> >dequeued and executed, it doesn't cover already executing 
>>>>>>>> work. So there is a
>>>>>>>> >possibility where while timeout work started executing another 
>>>>>>>> timeout work
>>>>>>>> >already got enqueued (maybe through earlier cleanup jobs or 
>>>>>>>> through
>>>>>>>> >drm_sched_fault) and if at this point another 
>>>>>>>> drm_sched_cleanup_jobs runs
>>>>>>>> >cancel_delayed_work(&sched->work_tdr) will return true even 
>>>>>>>> while there is a
>>>>>>>> >timeout job in progress.
>>>>>>>> >Unfortunately we cannot change cancel_delayed_work to
>>>>>>>> >cancel_delayed_work_sync to flush the timeout work as timeout 
>>>>>>>> work itself
>>>>>>>> >waits for schedule thread  to be parked again when calling 
>>>>>>>> park_thread.
>>>>>>>> >
>>>>>>>> >Andrey
>>>>>>>> >
>>>>>>>> >________________________________________
>>>>>>>> >From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on 
>>>>>>>> behalf of
>>>>>>>> >Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >Sent: 08 November 2019 05:35:18
>>>>>>>> >To: Deng, Emily; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue 
>>>>>>>> for tdr
>>>>>>>> >
>>>>>>>> >Hi Emily,
>>>>>>>> >
>>>>>>>> >exactly that can't happen. See here:
>>>>>>>> >
>>>>>>>> >>         /* Don't destroy jobs while the timeout worker is 
>>>>>>>> running */
>>>>>>>> >>         if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>>>>>>>> >> !cancel_delayed_work(&sched->work_tdr))
>>>>>>>> >>                 return NULL;
>>>>>>>> >
>>>>>>>> >We never free jobs while the timeout working is running to 
>>>>>>>> prevent exactly
>>>>>>>> >that issue.
>>>>>>>> >
>>>>>>>> >Regards,
>>>>>>>> >Christian.
>>>>>>>> >
>>>>>>>> >Am 08.11.19 um 11:32 schrieb Deng, Emily:
>>>>>>>> >> Hi Christian,
>>>>>>>> >>       The drm_sched_job_timedout-> amdgpu_job_timedout call
>>>>>>>> >amdgpu_device_gpu_recover. I mean the main scheduler free the 
>>>>>>>> jobs while
>>>>>>>> >in amdgpu_device_gpu_recover, and before calling drm_sched_stop.
>>>>>>>> >>
>>>>>>>> >> Best wishes
>>>>>>>> >> Emily Deng
>>>>>>>> >>
>>>>>>>> >>
>>>>>>>> >>
>>>>>>>> >>> -----Original Message-----
>>>>>>>> >>> From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >>> Sent: Friday, November 8, 2019 6:26 PM
>>>>>>>> >>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; 
>>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue 
>>>>>>>> for tdr
>>>>>>>> >>>
>>>>>>>> >>> Hi Emily,
>>>>>>>> >>>
>>>>>>>> >>> well who is calling amdgpu_device_gpu_recover() in this case?
>>>>>>>> >>>
>>>>>>>> >>> When it's not the scheduler we shouldn't have a guilty job 
>>>>>>>> in the first place.
>>>>>>>> >>>
>>>>>>>> >>> Regards,
>>>>>>>> >>> Christian.
>>>>>>>> >>>
>>>>>>>> >>> Am 08.11.19 um 11:22 schrieb Deng, Emily:
>>>>>>>> >>>> Hi Chrisitan,
>>>>>>>> >>>>        No, I am with the new branch and also has the 
>>>>>>>> patch. Even it
>>>>>>>> >>>> are freed by
>>>>>>>> >>> main scheduler, how we could avoid main scheduler to free 
>>>>>>>> jobs while
>>>>>>>> >>> enter to function amdgpu_device_gpu_recover?
>>>>>>>> >>>> Best wishes
>>>>>>>> >>>> Emily Deng
>>>>>>>> >>>>
>>>>>>>> >>>>
>>>>>>>> >>>>
>>>>>>>> >>>>> -----Original Message-----
>>>>>>>> >>>>> From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >>>>> Sent: Friday, November 8, 2019 6:15 PM
>>>>>>>> >>>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-
>>>>>>>> >gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer 
>>>>>>>> issue for tdr
>>>>>>>> >>>>>
>>>>>>>> >>>>> Hi Emily,
>>>>>>>> >>>>>
>>>>>>>> >>>>> in this case you are on an old code branch.
>>>>>>>> >>>>>
>>>>>>>> >>>>> Jobs are freed now by the main scheduler thread and only 
>>>>>>>> if no
>>>>>>>> >>>>> timeout handler is running.
>>>>>>>> >>>>>
>>>>>>>> >>>>> See this patch here:
>>>>>>>> >>>>>> commit 5918045c4ed492fb5813f980dcf89a90fefd0a4e
>>>>>>>> >>>>>> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >>>>>> Date:   Thu Apr 18 11:00:21 2019 -0400
>>>>>>>> >>>>>>
>>>>>>>> >>>>>>       drm/scheduler: rework job destruction
>>>>>>>> >>>>> Regards,
>>>>>>>> >>>>> Christian.
>>>>>>>> >>>>>
>>>>>>>> >>>>> Am 08.11.19 um 11:11 schrieb Deng, Emily:
>>>>>>>> >>>>>> Hi Christian,
>>>>>>>> >>>>>>         Please refer to follow log, when it enter to
>>>>>>>> >>>>>> amdgpu_device_gpu_recover
>>>>>>>> >>>>> function, the bad job 000000005086879e is freeing in 
>>>>>>>> function
>>>>>>>> >>>>> amdgpu_job_free_cb  at the same time, because of the 
>>>>>>>> hardware fence
>>>>>>>> >>> signal.
>>>>>>>> >>>>> But amdgpu_device_gpu_recover goes faster, at this case, the
>>>>>>>> >>>>> s_fence is already freed, but job is not freed in time. 
>>>>>>>> Then this issue
>>>>>>>> >occurs.
>>>>>>>> >>>>>> [  449.792189] [drm:amdgpu_job_timedout [amdgpu]] 
>>>>>>>> *ERROR* ring
>>>>>>>> >>> sdma0
>>>>>>>> >>>>>> timeout, signaled seq=2481, emitted seq=2483 [  449.793202]
>>>>>>>> >>>>>> [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process 
>>>>>>>> information:
>>>>>>>> >>>>> process  pid 0 thread pid 0, s_job:000000005086879e [  
>>>>>>>> 449.794163]
>>>>>>>> >>>>> amdgpu
>>>>>>>> >>>>> 0000:00:08.0: GPU reset begin!
>>>>>>>> >>>>>> [  449.794175] Emily:amdgpu_job_free_cb,Process 
>>>>>>>> information:
>>>>>>>> >>>>>> process pid 0 thread  pid 0, s_job:000000005086879e [ 
>>>>>>>> 449.794221]
>>>>>>>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  
>>>>>>>> pid 0
>>>>>>>> >>>>>> thread pid 0, s_job:0000000066eb74ab [  449.794222]
>>>>>>>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  
>>>>>>>> pid 0
>>>>>>>> >>>>>> thread pid 0, s_job:00000000d4438ad9 [  449.794255]
>>>>>>>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  
>>>>>>>> pid 0
>>>>>>>> >>>>>> thread pid 0, s_job:00000000b6d69c65 [  449.794257]
>>>>>>>> >>>>>> Emily:amdgpu_job_free_cb,Process information: process  
>>>>>>>> pid 0
>>>>>>>> >>>>>> thread pid 0,
>>>>>>>> >>>>> s_job:00000000ea85e922 [ 449.794287]
>>>>>>>> >>>>> Emily:amdgpu_job_free_cb,Process
>>>>>>>> >>>>> information: process pid 0 thread  pid 0, 
>>>>>>>> s_job:00000000ed3a5ac6 [
>>>>>>>> >>>>> 449.794366] BUG: unable to handle kernel NULL pointer 
>>>>>>>> dereference
>>>>>>>> >>>>> at
>>>>>>>> >>>>> 00000000000000c0 [ 449.800818] PGD 0 P4D 0 [  449.801040] 
>>>>>>>> Oops:
>>>>>>>> >>>>> 0000 [#1] SMP PTI
>>>>>>>> >>>>>> [  449.801338] CPU: 3 PID: 55 Comm: kworker/3:1 Tainted: 
>>>>>>>> G OE
>>>>>>>> >>>>> 4.18.0-15-generic #16~18.04.1-Ubuntu
>>>>>>>> >>>>>> [  449.802157] Hardware name: QEMU Standard PC (i440FX + 
>>>>>>>> PIIX,
>>>>>>>> >>>>>> 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014 [  449.802944]
>>>>>>>> >>>>>> Workqueue: events drm_sched_job_timedout [amd_sched] [
>>>>>>>> >>>>>> 449.803488]
>>>>>>>> >>> RIP:
>>>>>>>> >>>>> 0010:amdgpu_device_gpu_recover+0x1da/0xb60 [amdgpu]
>>>>>>>> >>>>>> [  449.804020] Code: dd ff ff 49 39 c5 48 89 55 a8 0f 85 
>>>>>>>> 56 ff ff
>>>>>>>> >>>>>> ff
>>>>>>>> >>>>>> 45 85 e4 0f
>>>>>>>> >>>>> 85 a1 00 00 00 48 8b 45 b0 48 85 c0 0f 84 60 01 00 00 48 
>>>>>>>> 8b 40 10
>>>>>>>> >>>>> <48> 8b
>>>>>>>> >>> 98
>>>>>>>> >>>>> c0 00         00 00 48 85 db 0f 84 4c 01 00 00 48 8b 43 
>>>>>>>> 48 a8 01
>>>>>>>> >>>>>> [  449.805593] RSP: 0018:ffffb4c7c08f7d68 EFLAGS: 
>>>>>>>> 00010286 [
>>>>>>>> >>>>>> 449.806032] RAX: 0000000000000000 RBX: 0000000000000000 
>>>>>>>> RCX:
>>>>>>>> >>>>>> 0000000000000000 [ 449.806625] RDX: ffffb4c7c08f5ac0 RSI:
>>>>>>>> >>>>>> 0000000fffffffe0 RDI: 0000000000000246 [  449.807224] RBP:
>>>>>>>> >>>>>> ffffb4c7c08f7de0 R08: 00000068b9d54000 R09: 
>>>>>>>> 0000000000000000 [
>>>>>>>> >>>>>> 449.807818] R10: 0000000000000000 R11: 0000000000000148 
>>>>>>>> R12:
>>>>>>>> >>>>>> 0000000000000000 [ 449.808411] R13: ffffb4c7c08f7da0 R14:
>>>>>>>> >>>>>> ffff8d82b8525d40 R15: ffff8d82b8525d40 [  449.809004] FS:
>>>>>>>> >>>>>> 0000000000000000(0000) GS:ffff8d82bfd80000(0000)
>>>>>>>> >>>>>> knlGS:0000000000000000 [ 449.809674] CS:  0010 DS: 0000 
>>>>>>>> ES: 0000
>>>>>>>> >CR0:
>>>>>>>> >>>>>> 0000000080050033 [ 449.810153] CR2: 00000000000000c0 CR3:
>>>>>>>> >>>>>> 000000003cc0a001 CR4: 00000000003606e0 [  449.810747] DR0:
>>>>>>>> >>>>> 0000000000000000 DR1: 0000000000000000 DR2: 
>>>>>>>> 0000000000000000 [
>>>>>>>> >>>>> 449.811344] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>>>>>> >>>>> 0000000000000400 [ 449.811937] Call Trace:
>>>>>>>> >>>>>> [  449.812206] amdgpu_job_timedout+0x114/0x140 [amdgpu] [
>>>>>>>> >>>>>> 449.812635] drm_sched_job_timedout+0x44/0x90 [amd_sched] [
>>>>>>>> >>>>>> 449.813139]  ? amdgpu_cgs_destroy_device+0x10/0x10 
>>>>>>>> [amdgpu] [
>>>>>>>> >>>>>> 449.813609]  ? drm_sched_job_timedout+0x44/0x90 
>>>>>>>> [amd_sched] [
>>>>>>>> >>>>>> 449.814077] process_one_work+0x1fd/0x3f0 [  449.814417]
>>>>>>>> >>>>>> worker_thread+0x34/0x410 [ 449.814728] 
>>>>>>>> kthread+0x121/0x140 [
>>>>>>>> >>>>>> 449.815004]  ? process_one_work+0x3f0/0x3f0 [  
>>>>>>>> 449.815374]  ?
>>>>>>>> >>>>>> kthread_create_worker_on_cpu+0x70/0x70
>>>>>>>> >>>>>> [  449.815799] ret_from_fork+0x35/0x40
>>>>>>>> >>>>>>
>>>>>>>> >>>>>>> -----Original Message-----
>>>>>>>> >>>>>>> From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >>>>>>> Sent: Friday, November 8, 2019 5:43 PM
>>>>>>>> >>>>>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-
>>>>>>>> >>> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >>>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer 
>>>>>>>> issue for
>>>>>>>> >>>>>>> tdr
>>>>>>>> >>>>>>>
>>>>>>>> >>>>>>> Am 08.11.19 um 10:39 schrieb Deng, Emily:
>>>>>>>> >>>>>>>> Sorry, please take your time.
>>>>>>>> >>>>>>> Have you seen my other response a bit below?
>>>>>>>> >>>>>>>
>>>>>>>> >>>>>>> I can't follow how it would be possible for 
>>>>>>>> job->s_fence to be
>>>>>>>> >>>>>>> NULL without the job also being freed.
>>>>>>>> >>>>>>>
>>>>>>>> >>>>>>> So it looks like this patch is just papering over some 
>>>>>>>> bigger issues.
>>>>>>>> >>>>>>>
>>>>>>>> >>>>>>> Regards,
>>>>>>>> >>>>>>> Christian.
>>>>>>>> >>>>>>>
>>>>>>>> >>>>>>>> Best wishes
>>>>>>>> >>>>>>>> Emily Deng
>>>>>>>> >>>>>>>>
>>>>>>>> >>>>>>>>
>>>>>>>> >>>>>>>>
>>>>>>>> >>>>>>>>> -----Original Message-----
>>>>>>>> >>>>>>>>> From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >>>>>>>>> Sent: Friday, November 8, 2019 5:08 PM
>>>>>>>> >>>>>>>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-
>>>>>>>> >>>>> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer 
>>>>>>>> issue for
>>>>>>>> >>>>>>>>> tdr
>>>>>>>> >>>>>>>>>
>>>>>>>> >>>>>>>>> Am 08.11.19 um 09:52 schrieb Deng, Emily:
>>>>>>>> >>>>>>>>>> Ping.....
>>>>>>>> >>>>>>>>> You need to give me at least enough time to wake up :)
>>>>>>>> >>>>>>>>>
>>>>>>>> >>>>>>>>>> Best wishes
>>>>>>>> >>>>>>>>>> Emily Deng
>>>>>>>> >>>>>>>>>>
>>>>>>>> >>>>>>>>>>
>>>>>>>> >>>>>>>>>>
>>>>>>>> >>>>>>>>>>> -----Original Message-----
>>>>>>>> >>>>>>>>>>> From: amd-gfx 
>>>>>>>> <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On
>>>>>>>> >>> Behalf
>>>>>>>> >>>>>>>>>>> Of Deng, Emily
>>>>>>>> >>>>>>>>>>> Sent: Friday, November 8, 2019 10:56 AM
>>>>>>>> >>>>>>>>>>> To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; amd-
>>>>>>>> >>>>>>>>>>> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >>>>>>>>>>> Subject: RE: [PATCH] drm/amdgpu: Fix the null 
>>>>>>>> pointer issue
>>>>>>>> >>>>>>>>>>> for tdr
>>>>>>>> >>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>> -----Original Message-----
>>>>>>>> >>>>>>>>>>>> From: Christian König 
>>>>>>>> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>>>> >>>>>>>>>>>> Sent: Thursday, November 7, 2019 7:28 PM
>>>>>>>> >>>>>>>>>>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>;
>>>>>>>> >>>>>>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >>>>>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the null 
>>>>>>>> pointer issue
>>>>>>>> >>>>>>>>>>>> for tdr
>>>>>>>> >>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>> Am 07.11.19 um 11:25 schrieb Emily Deng:
>>>>>>>> >>>>>>>>>>>>> When the job is already signaled, the s_fence is 
>>>>>>>> freed.
>>>>>>>> >>>>>>>>>>>>> Then it will has null pointer in 
>>>>>>>> amdgpu_device_gpu_recover.
>>>>>>>> >>>>>>>>>>>> NAK, the s_fence is only set to NULL when the job 
>>>>>>>> is destroyed.
>>>>>>>> >>>>>>>>>>>> See drm_sched_job_cleanup().
>>>>>>>> >>>>>>>>>>> I know it is set to NULL in drm_sched_job_cleanup. 
>>>>>>>> But in one
>>>>>>>> >>>>>>>>>>> case, when it enter into the 
>>>>>>>> amdgpu_device_gpu_recover, it
>>>>>>>> >>>>>>>>>>> already in drm_sched_job_cleanup, and at this time, 
>>>>>>>> it will
>>>>>>>> >>>>>>>>>>> go to free
>>>>>>>> >>>>> job.
>>>>>>>> >>>>>>>>>>> But the amdgpu_device_gpu_recover sometimes is 
>>>>>>>> faster. At
>>>>>>>> >>>>>>>>>>> that time, job is not freed, but s_fence is already 
>>>>>>>> NULL.
>>>>>>>> >>>>>>>>> No, that case can't happen. See here:
>>>>>>>> >>>>>>>>>
>>>>>>>> >>>>>>>>>> drm_sched_job_cleanup(s_job);
>>>>>>>> >>>>>>>>>>
>>>>>>>> >>>>>>>>>> amdgpu_ring_priority_put(ring, s_job->s_priority);
>>>>>>>> >>>>>>>>>> dma_fence_put(job->fence);
>>>>>>>> >>>>>>>>>> amdgpu_sync_free(&job->sync);
>>>>>>>> >>>>>>>>>> amdgpu_sync_free(&job->sched_sync);
>>>>>>>> >>>>>>>>>> kfree(job);
>>>>>>>> >>>>>>>>> The job itself is freed up directly after freeing the 
>>>>>>>> reference
>>>>>>>> >>>>>>>>> to the
>>>>>>>> >>>>> s_fence.
>>>>>>>> >>>>>>>>> So you are just papering over a much bigger problem 
>>>>>>>> here. This
>>>>>>>> >>>>>>>>> patch is a clear NAK.
>>>>>>>> >>>>>>>>>
>>>>>>>> >>>>>>>>> Regards,
>>>>>>>> >>>>>>>>> Christian.
>>>>>>>> >>>>>>>>>
>>>>>>>> >>>>>>>>>>>> When you see a job without an s_fence then that 
>>>>>>>> means the
>>>>>>>> >>>>>>>>>>>> problem is somewhere else.
>>>>>>>> >>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>> Regards,
>>>>>>>> >>>>>>>>>>>> Christian.
>>>>>>>> >>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>>>>>>> >>>>>>>>>>>>> ---
>>>>>>>> >>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>>>>>>> >>>>>>>>>>>>> drivers/gpu/drm/scheduler/sched_main.c     | 11 
>>>>>>>> ++++++---
>>>>>>>> >--
>>>>>>>> >>>>>>>>>>>>>       2 files changed, 7 insertions(+), 6 
>>>>>>>> deletions(-)
>>>>>>>> >>>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>>> diff --git 
>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> >>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> >>>>>>>>>>>>> index e6ce949..5a8f08e 100644
>>>>>>>> >>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> >>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> >>>>>>>>>>>>> @@ -4075,7 +4075,7 @@ int
>>>>>>>> >>> amdgpu_device_gpu_recover(struct
>>>>>>>> >>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>> >>>>>>>>>>>>>            *
>>>>>>>> >>>>>>>>>>>>>            * job->base holds a reference to 
>>>>>>>> parent fence
>>>>>>>> >>>>>>>>>>>>>            */
>>>>>>>> >>>>>>>>>>>>> -  if (job && job->base.s_fence->parent &&
>>>>>>>> >>>>>>>>>>>>> +  if (job && job->base.s_fence &&
>>>>>>>> >>>>>>>>>>>>> + job->base.s_fence->parent
>>>>>>>> >>>>>>> &&
>>>>>>>> >>>>>>>>>>>>> dma_fence_is_signaled(job->base.s_fence->parent))
>>>>>>>> >>>>>>>>>>>>> job_signaled = true;
>>>>>>>> >>>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>>>>>>>> >>>>>>>>>>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>>>>>> >>>>>>>>>>>>> index 31809ca..56cc10e 100644
>>>>>>>> >>>>>>>>>>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>>>>>> >>>>>>>>>>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>>>>>> >>>>>>>>>>>>> @@ -334,8 +334,8 @@ void
>>>>>>>> >drm_sched_increase_karma(struct
>>>>>>>> >>>>>>>>>>>> drm_sched_job
>>>>>>>> >>>>>>>>>>>>> *bad)
>>>>>>>> >>>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>>> spin_lock(&rq->lock);
>>>>>>>> >>>>>>>>>>>>> list_for_each_entry_safe(entity,
>>>>>>>> >>>>>>>>>>>>> tmp,
>>>>>>>> >>> &rq-
>>>>>>>> >>>>>>>> entities,
>>>>>>>> >>>>>>>>>>>> list) {
>>>>>>>> >>>>>>>>>>>>> -                          if 
>>>>>>>> (bad->s_fence->scheduled.context
>>>>>>>> >>>>>>> ==
>>>>>>>> >>>>>>>>>>>>> - entity->fence_context) {
>>>>>>>> >>>>>>>>>>>>> +                          if (bad->s_fence &&
>>>>>>>> >>>>>>>>>>>>> + (bad->s_fence-
>>>>>>>> >>>>>>>>>>>>> scheduled.context ==
>>>>>>>> >>>>>>>>>>>>> + entity->fence_context)) {
>>>>>>>> >>>>>>>>>>>>> if
>>>>>>>> >>>>>>>>>>>>> (atomic_read(&bad-
>>>>>>>> >>>>>>>> karma) >
>>>>>>>> >>>>>>>>>>>>> bad->sched-
>>>>>>>> >>>> hang_limit)
>>>>>>>> >>>>>>>>>>>>> if
>>>>>>>> >>>>>>>>>>>>> (entity-
>>>>>>>> >>>> guilty) @@ -376,7 +376,7 @@ void
>>>>>>>> >>>>>>>>>>>>> drm_sched_stop(struct
>>>>>>>> >>>>>>> drm_gpu_scheduler
>>>>>>>> >>>>>>>>>>>> *sched, struct drm_sched_job *bad)
>>>>>>>> >>>>>>>>>>>>>            * This iteration is thread safe as 
>>>>>>>> sched thread
>>>>>>>> >>>>>>>>>>>>> is
>>>>>>>> >>> stopped.
>>>>>>>> >>>>>>>>>>>>>            */
>>>>>>>> >>>>>>>>>>>>> list_for_each_entry_safe_reverse(s_job, tmp,
>>>>>>>> >>>>>>>>>>>>> &sched- ring_mirror_list, node) {
>>>>>>>> >>>>>>>>>>>>> -          if (s_job->s_fence->parent &&
>>>>>>>> >>>>>>>>>>>>> +          if (s_job->s_fence && 
>>>>>>>> s_job->s_fence->parent &&
>>>>>>>> >>>>>>>>>>>>> dma_fence_remove_callback(s_job-
>>>>>>>> >>>> s_fence-
>>>>>>>> >>>>>>>> parent,
>>>>>>>> >>>>>>>>>>>>> &s_job->cb)) {
>>>>>>>> >>>>>>>>>>>>> atomic_dec(&sched->hw_rq_count);
>>>>>>>> >>> @@ -
>>>>>>>> >>>>>>> 395,7
>>>>>>>> >>>>>>>>>>> +395,8 @@ void
>>>>>>>> >>>>>>>>>>>>> drm_sched_stop(struct drm_gpu_scheduler
>>>>>>>> >>>>>>>>>>>> *sched, struct drm_sched_job *bad)
>>>>>>>> >>>>>>>>>>>>> *
>>>>>>>> >>>>>>>>>>>>> * Job is still alive so fence
>>>>>>>> >>>>>>>>>>>>> refcount at
>>>>>>>> >>> least 1
>>>>>>>> >>>>>>>>>>>>> */
>>>>>>>> >>>>>>>>>>>>> - dma_fence_wait(&s_job->s_fence->finished,
>>>>>>>> >>>>>>> false);
>>>>>>>> >>>>>>>>>>>>> +                  if (s_job->s_fence)
>>>>>>>> >>>>>>>>>>>>> + dma_fence_wait(&s_job->s_fence-
>>>>>>>> >>>>>>>> finished,
>>>>>>>> >>>>>>>>>>>> false);
>>>>>>>> >>>>>>>>>>>>> /*
>>>>>>>> >>>>>>>>>>>>> * We must keep bad job alive
>>>>>>>> >>>>>>>>>>>>> for later
>>>>>>>> >>> use
>>>>>>>> >>>>>>> during @@
>>>>>>>> >>>>>>>>>>>> -438,7
>>>>>>>> >>>>>>>>>>>>> +439,7 @@ void drm_sched_start(struct 
>>>>>>>> drm_gpu_scheduler
>>>>>>>> >>>>> *sched,
>>>>>>>> >>>>>>>>>>>>> +bool
>>>>>>>> >>>>>>>>>>>> full_recovery)
>>>>>>>> >>>>>>>>>>>>>            * GPU recovers can't run in parallel.
>>>>>>>> >>>>>>>>>>>>>            */
>>>>>>>> >>>>>>>>>>>>> list_for_each_entry_safe(s_job, tmp,
>>>>>>>> >>>>>>>>>>>>> &sched->ring_mirror_list,
>>>>>>>> >>>>>>>>>>>>> node)
>>>>>>>> >>>>>>>>>>>> {
>>>>>>>> >>>>>>>>>>>>> -          struct dma_fence *fence = 
>>>>>>>> s_job->s_fence->parent;
>>>>>>>> >>>>>>>>>>>>> +          struct dma_fence *fence = 
>>>>>>>> s_job->s_fence ?
>>>>>>>> >>>>>>>>>>>>> + s_job-
>>>>>>>> >>>>>>>> s_fence-
>>>>>>>> >>>>>>>>>>>>> parent :
>>>>>>>> >>>>>>>>>>>>> +NULL;
>>>>>>>> >>>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>>>> atomic_inc(&sched->hw_rq_count);
>>>>>>>> >>>>>>>>>>>>>
>>>>>>>> >>>>>>>>>>> _______________________________________________
>>>>>>>> >>>>>>>>>>> amd-gfx mailing list
>>>>>>>> >>>>>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >>>>>>>>>>> 
>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx 
>>>>>>>> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>>>>>>> >
>>>>>>>> >_______________________________________________
>>>>>>>> >amd-gfx mailing list
>>>>>>>> >amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>>> >https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> amd-gfx mailing list
>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------C51FE0116A9075E0A86FF8EC
Content-Type: text/x-patch;
 name="0001-drm-scheduler-Avoid-accessing-freed-bad-job.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-scheduler-Avoid-accessing-freed-bad-job.patch"

>From 8471644911cc7e300b08874ebb482d4e8c599904 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 14 Nov 2019 16:04:49 -0500
Subject: drm/scheduler: Avoid accessing freed bad job.

Problem:
Due to a race between drm_sched_cleanup_jobs in sched thread and
drm_sched_job_timedout in timeout work there is a possiblity that
bad job was already freed while still being accessed from the
timeout thread.

Fix:
Instead of just peeking at the bad job in the mirror list
remove it from the list under lock and then put it back later when
we are garanteed no race with main sched thread is possible which
is after the thread is parked.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 80ddbdf..c2a6108 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -287,10 +287,24 @@ static void drm_sched_job_timedout(struct work_struct *work)
 	unsigned long flags;
 
 	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
+
+	/*
+	 * Protects against concurrent deletion in drm_sched_cleanup_jobs that
+	 * is already in progress.
+	 */
+	spin_lock_irqsave(&sched->job_list_lock, flags);
 	job = list_first_entry_or_null(&sched->ring_mirror_list,
 				       struct drm_sched_job, node);
 
 	if (job) {
+		/*
+		 * Remove the bad job so it cannot be freed by already in progress
+		 * drm_sched_cleanup_jobs. It will be reinsrted back after sched->thread
+		 * is parked at which point it's safe.
+		 */
+		list_del_init(&job->node);
+		spin_unlock_irqrestore(&sched->job_list_lock, flags);
+
 		job->sched->ops->timedout_job(job);
 
 		/*
@@ -302,6 +316,8 @@ static void drm_sched_job_timedout(struct work_struct *work)
 			sched->free_guilty = false;
 		}
 	}
+	else
+		spin_unlock_irqrestore(&sched->job_list_lock, flags);
 
 	spin_lock_irqsave(&sched->job_list_lock, flags);
 	drm_sched_start_timeout(sched);
@@ -373,6 +389,19 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 	kthread_park(sched->thread);
 
 	/*
+	 * Reinsert back the bad job here - now it's safe as drm_sched_cleanup_jobs
+	 * cannot race against us and release the bad job at this point - we parked
+	 * (waited for) any in progress (earlier) cleanups and any later ones will
+	 * bail out due to sched->thread being parked.
+	 */
+	if (bad && bad->sched == sched)
+		/*
+		 * Add at the head of the queue to reflect it was the earliest
+		 * job extracted.
+		 */
+		list_add(&bad->node, &sched->ring_mirror_list);
+
+	/*
 	 * Iterate the job list from later to  earlier one and either deactive
 	 * their HW callbacks or remove them from mirror list if they already
 	 * signaled.
@@ -657,7 +686,7 @@ static void drm_sched_cleanup_jobs(struct drm_gpu_scheduler *sched)
 		return;
 
 
-	while (!list_empty(&sched->ring_mirror_list)) {
+	while (!list_empty_careful(&sched->ring_mirror_list)) {
 		struct drm_sched_job *job;
 
 		job = list_first_entry(&sched->ring_mirror_list,
-- 
2.7.4


--------------C51FE0116A9075E0A86FF8EC
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------C51FE0116A9075E0A86FF8EC--
