Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233FBFA3740
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 11:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5D510E1AA;
	Mon, 31 Oct 2022 11:58:39 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC2110E1AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 11:58:33 +0000 (UTC)
Received: from thor ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202210311258290539; Mon, 31 Oct 2022 12:58:29 +0100
Received: from [127.0.0.1] by thor with esmtp (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1opTQx-000ejr-2W;
 Mon, 31 Oct 2022 12:58:27 +0100
Message-ID: <0c573590-b05d-34a3-fdcb-f624d53fc594@daenzer.net>
Date: Mon, 31 Oct 2022 12:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: de-CH-frami, en-CA
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <4046cec7-88a1-d91d-9553-678d5165d308@daenzer.net>
 <a4e05017-ac7d-9872-dfad-257be85d1572@amd.com>
 <DS7PR12MB6333440FFC7D991888A2D4A3F4379@DS7PR12MB6333.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
In-Reply-To: <DS7PR12MB6333440FFC7D991888A2D4A3F4379@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F21.635FB866.004F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Grodzovsky, Andrey" <agrodzov@amdcloud.onmicrosoft.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-31 09:10, Zhu, Jiadong wrote:
> [AMD Official Use Only - General]
> 
> Hi Michel,
> 
> Sorry for the late response. It is more likely the null pointer is raised from function amdgpu_ring_preempt_ib as preempt_ib is not assigned.

That makes sense, since amdgpu_mcbp_trigger_preempt passes mux->real_ring to amdgpu_ring_preempt_ib, and the real ring doesn't have the preempt_ib hook set, does it?


> Btw, Which branch of kmd are you cherry-pick? Maybe my code base is too old.
> I tried using wayland on ubuntu 20.04 and not reproduced the crash.

The Mesa radeonsi driver in Ubuntu 20.04 didn't support the EGL_IMG_context_priority extension yet. Does eglinfo list that extension as supported by the EGL Device platform on your system?


> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, October 20, 2022 10:59 PM
> To: Michel Dänzer <michel@daenzer.net>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>
> Subject: Re: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
> 
> Am 20.10.22 um 16:49 schrieb Michel Dänzer:
>> On 2022-10-18 11:08, jiadong.zhu@amd.com wrote:
>>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>>
>>> The software ring is created to support priority context while there
>>> is only one hardware queue for gfx.
>>>
>>> Every software ring has its fence driver and could be used as an
>>> ordinary ring for the GPU scheduler.
>>> Multiple software rings are bound to a real ring with the ring muxer.
>>> The packages committed on the software ring are copied to the real ring.
>>>
>>> v2: Use array to store software ring entry.
>>> v3: Remove unnecessary prints.
>>> v4: Remove amdgpu_ring_sw_init/fini functions, using gtt for sw ring
>>> buffer for later dma copy optimization.
>>> v5: Allocate ring entry dynamically in the muxer.
>>> v6: Update comments for the ring muxer.
>>> v7: Modify for function naming.
>>> v8: Combine software ring functions into amdgpu_ring_mux.c
>> I tested patches 1-4 of this series (since Christian clearly nacked patch 5). I hit the oops below.
> 
> As long as you don't try to reset the GPU you can also test patch 5.
> It's just that we can't upstream the stuff like this or that would break immediately.
> 
> Regards,
> Christian.
> 
>>
>> amdgpu_sw_ring_ib_begin+0x70/0x80 is in amdgpu_mcbp_trigger_preempt according to scripts/faddr2line, specifically line 376:
>>
>>       spin_unlock(&mux->lock);
>>
>> though I'm not sure why that would crash.
>>
>>
>> Are you not able to reproduce this with a GNOME Wayland session?
>>
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> #PF: supervisor instruction fetch in kernel mode
>> #PF: error_code(0x0010) - not-present page PGD 0 P4D 0
>> Oops: 0010 [#1] PREEMPT SMP NOPTI
>> CPU: 7 PID: 281 Comm: gfx_high Tainted: G            E      6.0.2+ #1
>> Hardware name: LENOVO 20NF0000GE/20NF0000GE, BIOS R11ET36W (1.16 )
>> 03/30/2020
>> RIP: 0010:0x0
>> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
>> RSP: 0018:ffffbd594073bdc8 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffff993c4a620000 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff993c4a62a350
>> RBP: ffff993c4a62d530 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000114
>> R13: ffff993c4a620000 R14: 0000000000000000 R15: ffff993c4a62d128
>> FS:  0000000000000000(0000) GS:ffff993ef0bc0000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffffffffffd6 CR3: 00000001959fc000 CR4: 00000000003506e0 Call
>> Trace:
>>   <TASK>
>>   amdgpu_sw_ring_ib_begin+0x70/0x80 [amdgpu]
>>   amdgpu_ib_schedule+0x15f/0x5d0 [amdgpu]
>>   amdgpu_job_run+0x102/0x1c0 [amdgpu]
>>   drm_sched_main+0x19a/0x440 [gpu_sched]
>>   ? dequeue_task_stop+0x70/0x70
>>   ? drm_sched_resubmit_jobs+0x10/0x10 [gpu_sched]
>>   kthread+0xe9/0x110
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x22/0x30
>>   </TASK>
>> [...]
>> note: gfx_high[281] exited with preempt_count 1 [...]
>> [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_low timeout,
>> signaled seq=14864, emitted seq=14865 [drm:amdgpu_job_timedout
>> [amdgpu]] *ERROR* Process information: process firefox.dpkg-di pid 3540 thread firefox:cs0 pid 4666 amdgpu 0000:05:00.0: amdgpu: GPU reset begin!
>>
>>
> 

-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

