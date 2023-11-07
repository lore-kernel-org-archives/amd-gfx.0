Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FDEC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 16:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF32E10E029;
	Tue,  7 Nov 2023 16:46:35 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B773810E029
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 16:46:33 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SPvHp13t3z9sqs;
 Tue,  7 Nov 2023 17:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1699375590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxdoJ4c3a2OHv/hdoxmB51kAnBxs7RW+qrX8vQhzNSY=;
 b=PL5wndRAQVJKGC1seHM8fqox9HQSo3Q3mHNnrmeJRTts4ycSiFg3wvwE/q2y1cjsAYA36S
 b35wNXwiAhwzkYsXCtl+FYZmx6em4ddfrJueRH0kISrlhQ3+MuhGskkfDKZ9v9eoy9k4/J
 C8cczW9m3FPQ2YPAg5NkSvdAx/C8qqKKV5IDFivqktisxvN8E1Vl1R2Zw3OLkKD45MkdAu
 lH5w0JagNqaINfCIsIRNwY+wMkQJga3c6moyD6fQ7GoGNIBbw4mg2AS9GiZ4RcVAhtuctf
 iaw9i7oElcF38zeKqICAm5x1EJxhMb/SQv2NKEtCMLonDk9tKe+BJ7mpsHWGyw==
Message-ID: <693780d8-ea44-efa1-dbbd-00864f993e76@mailbox.org>
Date: Tue, 7 Nov 2023 17:46:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20231025171928.3318505-1-alexander.deucher@amd.com>
 <96db9e3d-4636-4da4-b4d1-ca3f5fd8d887@gmail.com>
 <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>
 <04db543c-7aec-4550-878f-a9753142130e@gmail.com>
 <a8a0eb47-3aca-4c87-b5f7-dc54e5667944@gmail.com>
 <CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=JLSgPnXBQ@mail.gmail.com>
 <CADnq5_MBgNQPzZmvBagzUdi94X=rr-h=aaE334RzVozgOHU64g@mail.gmail.com>
 <bfb3d504-61c9-43e8-b3b3-2d8193e54d81@gmail.com>
 <CADnq5_OB0OvtqJf5nue-XsTZxOcnfN0Sy6pyryW_GF_Y+S6eYg@mail.gmail.com>
 <CADnq5_OkTuEJ+i+MpfZprSjkGcG99OVSndwyZYWiYEDMEvatgw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CADnq5_OkTuEJ+i+MpfZprSjkGcG99OVSndwyZYWiYEDMEvatgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8cdad4d6122c372ce32
X-MBO-RS-META: a1feriyj47dwgctp7hauekaier8igzzn
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Leo Liu <leo.liu@amd.com>,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <ltuikov89@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/7/23 15:47, Alex Deucher wrote:
> On Tue, Nov 7, 2023 at 9:19 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Tue, Nov 7, 2023 at 5:52 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 03.11.23 um 23:10 schrieb Alex Deucher:
>>>> On Fri, Nov 3, 2023 at 4:17 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>> On Thu, Oct 26, 2023 at 4:17 PM Luben Tuikov <ltuikov89@gmail.com> wrote:
>>>>>> Pushed to drm-misc-next.
>>>>> BTW, I'm seeing the following on older GPUs with VCE and UVD even with
>>>>> this patch:
>>>>> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init:
>>>>> entity has no rq!
>>>>> [   11.886028] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
>>>>> [amdgpu]] *ERROR* IB test failed on uvd (-2).
>>>>> [   11.889927] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init:
>>>>> entity has no rq!
>>>>> [   11.889930] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
>>>>> [amdgpu]] *ERROR* IB test failed on vce0 (-2).
>>>>> [   11.890172] [drm:process_one_work] *ERROR* ib ring test failed (-2).
>>>>> Seems to be specific to UVD and VCE, I don't see anything similar with
>>>>> VCN, but the flows for both are pretty similar.  Not sure why we are
>>>>> not seeing it for VCN.  Just a heads up if you have any ideas.  Will
>>>>> take a closer look next week.
>>>> + Leo
>>>>
>>>> I found the problem.  We set up scheduling entities for UVD and VCE
>>>> specifically and not for any other engines.  I don't remember why
>>>> offhand.  I'm guessing maybe to deal with the session limits on UVD
>>>> and VCE?  If so I'm not sure of a clean way to fix this.
>>>
>>> I haven't looked through all my mails yet so could be that Leo has
>>> already answered this.
>>>
>>> The UVD/VCE entities are used for the older chips where applications
>>> have to use create/destroy messages to the firmware.
>>>
>>> If an application exits without cleaning up their handles the kernel
>>> sends the appropriate destroy messages itself. For an example see
>>> amdgpu_uvd_free_handles().
>>>
>>> We used to initialize those entities with separate calls after the
>>> scheduler had been brought up, see amdgpu_uvd_entity_init() for an example.
>>>
>>> But this was somehow messed up and we now do the call to
>>> amdgpu_uvd_entity_init() at the end of *_sw_init() instead of _late_init().
>>>
>>> I suggest to just come up with a function which can be used for the
>>> late_init() callback of the UVD/VCE blocks.
>>
>> I guess the issue is that we only need to initialize the entity once
>> so sw_init makes sense.  All of the other functions get called at
>> resume time, etc.  I think we could probably put it into
>> amdgpu_device_init_schedulers() somehow.
> 
> I think something like this might do the trick.

This does indeed fix the IB test failures for me with Bonaire.


There are still

[drm] Fence fallback timer expired on ring sdma0

messages, that might be a separate regression though.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

