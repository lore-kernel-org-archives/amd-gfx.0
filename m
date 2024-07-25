Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D90FC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 07:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDCC10E259;
	Thu, 25 Jul 2024 07:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="oyqvitX5";
	dkim-atps=neutral
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jul 2024 07:49:38 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AE910E259
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721893777; x=1722498577; i=friedrich.vock@gmx.de;
 bh=+j3/Bxk8LOCFxa0Ml+FNbEV5ioFZny8DmeulaR3kejI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oyqvitX5sph+d8XZFHcqZcMfm7FpD9CO1SiJMQOlvSvmcJc08wcM5IGXfbd9GTiF
 tL09/0osFQl+jKXEcc0bSWPRAvmndbOvXj4b8djWWoWvHodXuuBjTXlTOvbT0JVVr
 gsrHXqlQxMKGdFTnmRulxmPsTfum1XnBp4VO0sOKsbZB5ruDUJYktQiw4KkJDZFyP
 8E4AimkfZzxOurve6mBV/AXSRescY9vwcNzOvwWiJW2/JoSp7az6E4xFw64KA0wUp
 VJgkLZB5bLOz7JyhDrlIaArLX8SNhhDNjistoDuJKEZXWDa9nUu2X+ohfK4WmdDgy
 ZMdTkpkkfATMn1mM0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.114.245]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1sD5312qPj-00whvt; Thu, 25
 Jul 2024 09:44:28 +0200
Message-ID: <d73cccd0-6483-493d-baec-e6def1b3b35b@gmx.de>
Date: Thu, 25 Jul 2024 09:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Friedrich Vock <friedrich.vock@gmx.de>
Subject: Re: [PATCH 00/34] GC per queue reset
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
 <95387eeb-d81e-4a09-8475-820317605f49@gmx.de>
 <CADnq5_NaXHNz_AO9YJbe5X7qKP8h7CQqUVd5BwxDh4rbg2nBkw@mail.gmail.com>
 <DS7PR12MB6333400E4AC22FB5DFEE06DBF4AA2@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Language: en-US
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 xsDNBGPTxTYBDACuXf97Zpb1IttAOHjNRHW77R759ueDHfkZT/SkWjtlwa4rMPoVdJIte9ZY
 +5Ht5+MLdq+Pjd/cbvfqrS8Q+BBwONaVzjDP35lQdim5sJ/xBqm/sozQbGVLJ/szoYhGY+va
 my9lym47Z14xVGH1rhHcXLgZ0FHbughbxmwX77P/BvdI1YrjIk/0LJReph27Uko8WRa3zh6N
 vAxNk6YKsQj4UEO30idkjmpw6jIN2qU7SyqKmsI+XnB9RrUyisV/IUGGuQ4RN0Rjtqd8Nyhy
 2qQGr8tnbDWEQOcdSCvE/bnSrhaX/yrGzwKoJZ8pMyWbkkAycD72EamXH13PU7A3RTCrzNJa
 AKiCvSA9kti4MRkoIbE+wnv1sxM+8dkDmqEY1MsXLTJ4gAkCnmsdGYz80AQ2uyXD06D8x/jR
 RcwbRbsQM5LMSrXA0CDmNXbt5pst7isDbuoBu1zerqy2ba+rf6sxnSnCzQR6SuE0GB7NYV8A
 lrNVyQlMModwmrY2AO3rxxcAEQEAAc0mRnJpZWRyaWNoIFZvY2sgPGZyaWVkcmljaC52b2Nr
 QGdteC5kZT7CwQ4EEwEIADgWIQT3VIkd33wSl/TfALOvWjJVL7qFrgUCY9PFNgIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgAAKCRCvWjJVL7qFro7GC/9PfV0ICDbxBoILGLM6OXXwqgoC
 HkAsBEXE/5cS68TT++YXMHCetXpFfBIwTe8FlBcbhtylSYIUhFLmjiGfgoXy5S87l9osOp1G
 y3+RNbFoz4OJvqcXX5BqFK5KHh7iL/Q6BaZB9u3es0ifFt5YMwhDgcCbYaLUlTPbl+5m+/ie
 Eori0ASylvhz3EdB11sMqN9CmoKvBEVnkdiydDMuFvpEi08WB8ZC8qckiuwrLOIa4/JB54E2
 QyGw0KgBT4ApeMmkKurS3UOsrAwoKKP/0rgWsBFVnXrBIOEL+7/HGqSSDboLAjt1qE967yxM
 3Qzt1FUBU9db2biFW7O3TmXP31SyPwVYWfeETa4MT9A8EyjfWF66+sfPXREsBvqRTin3kEst
 IlbMdSNijCjKZz9XPCaKwx3hJaD5VEs3gPsKa9qXOQftfTqt+SI0nYBw3sdT2+wWJCeyZ3aE
 L0Us8uMILncTxVAhX2a8pUvGrbtuyW2qqEFId1OSfWlrLZEuv8+631fOwM0EY9PFNgEMAKx2
 G48lrQ1bLAWgjq3syyswS80e70M+/Fbxb2aBKRHw5XbpSPYr9FLE3MPdgvUtt+fiK2xA69bk
 i86sfSV2KNhRuiS2rb1h/jfmTlxfimBezHv6xnzVuHJNd87vL35lqd0D6B5zvnzzP9CjpXq/
 o7isfiA2FMSOI1OnrHEw9pbEd1B26cgS+mIGhDf/gBI6MtsPuN8xMUyybtpUSSVi3b4oRkge
 +vwwbMn+vwvhN39kjcISAT+jFWNupDybFIs8cYNWA7MkWJAIuqSjMydE0l1+c8eF7nnvzY2o
 2GGarFmxNO4CHuh3JoMFfY4wlKjmDlk+FJ5UfIFelVmOiVPLGrSL8ggcubnOS75VjDvDTQgY
 tjDvLuUmOj1vYSmPSE9PjDMhrpx1LcSOHyV+aX0NQeHP869A/YLjwQbOJBJVIN+XdsGlnwG5
 teXXxU9uwFDqYPAneHp4As5OKovOCIzNj6EB4MIZIpTGgYQBIN4xrwL0YsjvPm2i1RyBPTpf
 UKvjVQARAQABwsD2BBgBCAAgFiEE91SJHd98Epf03wCzr1oyVS+6ha4FAmPTxTYCGwwACgkQ
 r1oyVS+6ha4Hlgv/Z2q6pSxeCjK/g20vub8Gvg09jNYAle3FTaJD2Jd/MhUs6s9Y5StWtiDf
 hw27O8bhJan1W4hrngQceR2EcvKxejroVhu3UI2b9ElM5aphD2IolOWqfwPXeUetIgaMNqTl
 GJ9rGx+k8HCpchW4QVZfWn7yM+IymCwOYov+36vMMHd8gdQ0BxMiT2WLDzCWwDb+/PYMfOiq
 AoPBV5EQ2K3x85wl9N4OxiQdGWi9+/0KJyMPYoGlFqCdPdvvbpFe4XD6YOBr3HmVOFCWtLcW
 Bm+BCucpo93VhjNVqZ+cuN/tlS+Px8kl0qW9J3Q8fwWhgz69v5YdiOczQza/zQu3YrcYapBD
 kQXSmDju1Yd4jIGeZ8vf+dnmbX78mpj3nBmYLhIs5lszAH634uoWyJqMLs77WG1pkk0utvwh
 Zvq4r6fbLIuofLsboYKQxUJuX5uRSK4/hWXEETUTxxvkA/hiuhsdMbDWIZWFp8yuoZvR2itT
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <DS7PR12MB6333400E4AC22FB5DFEE06DBF4AA2@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mNAy53yVPuUPR3xP5boxHBkGxbwNrwFPAOh0GoLCthSv+1jrKuO
 lJggaJLIeE6qB8n8CF4lxZMrzfZhJxNhf7F0mjjkKheF5NtA36d4VUq0TYZmBbcItSuD8Zf
 dB87Fs1XE83pJkWffhZfzsG+t2aEDwNZhAEWUvajep8IVVdJulofgBl4p4bVk+ahxXN336n
 lVv92u6XLGGGJWPIPGFwQ==
UI-OutboundReport: notjunk:1;M01:P0:dOEgZu/OFYk=;DGHB8s5xGq7lm3vqb9aXpCSsGlo
 R58t+hK9Zj5WA/GKVP4tpwXW5v2PTIMk8uiZh06RwFimGEkXEi7BaEhjgMl7RD5Nzr5I7MO7k
 mPsYRUp4oqKu2Eyq0uiO+6+0xCeQ5lo4fuqjs0e20q4Ym2u5fYViKoLnPtGE4CGUWb4KYGQHD
 Dltr31fInL9USNP6QcQq+VsxfYV/OUQB99OAuNziohTZqwQ5eBd7VrqFVd1Qhg3b6lxQwaW+A
 d374nXoervfgooehl5VaKyO7cD+ktoANZMwSlPGR0gI2WVPw3EXyd4ACoPFidnl3/dnk7GznK
 MOz1jTSBwpxbAsuq6UAQzMwP/F/aYLLQzOLHbZJLTuyXkBhoBsbl2saxjMAPjnlVlVVRk8qX6
 R0i8O8Hate3NG8yxwDebrX7yZwbpEH5Fec/ngdyL3jXCHA4HL6jLQ+H2Mrkbv4w0yF2yghS6N
 fAivPsO/+ZaC1IbyhWAlvcD3iR1+OOiAGP7w19ijMLJsInDafS02O/kiTIjOzZ8mDsnW7+Dr3
 +gJa+EcAv92RlWp1fVrEo652bBItkuIY0Px//E26O8vEpDKM83uZXogYQGycNGh3/RxlMFT49
 ik0M3zR7+gIq9k/P6vKzviivgYI7EGxp1iorlYhjay8M46/d4IlDKS1D105OLJ2qYTlO2Cod9
 P+xuV/u8zHO2IUl7c3S6kbcUn/+Ktb5HuN0pj7x7ql8ul0VU+Ywp57awIPT2PE9f7WXjkmelq
 kWA379FWyOLTRuRJ66NgL9wuf/0QtsccE+TqEEnAX9Yg3VNdymAI5pnnD+jcIvg4CrAWaJoS2
 W8LGlBvZtSjHTTAlkfrapkzO6dwXubzKRQksV6JURthwc=
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 24.07.24 11:20, Zhu, Jiadong wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>> Deucher
>> Sent: Friday, July 19, 2024 9:40 PM
>> To: Friedrich Vock <friedrich.vock@gmx.de>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 00/34] GC per queue reset
>>
>> On Thu, Jul 18, 2024 at 1:00=E2=80=AFPM Friedrich Vock <friedrich.vock@=
gmx.de>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 18.07.24 16:06, Alex Deucher wrote:
>>>> This adds preliminary support for GC per queue reset.  In this case,
>>>> only the jobs currently in the queue are lost.  If this fails, we
>>>> fall back to a full adapter reset.
>>>
>>> First of all, thank you so much for working on this! It's great to
>>> finally see progress in making GPU resets better.
>>>
>>> I've just taken this patchset (together with your other
>>> patchsets[1][2][3]) for a quick spin on my
>>> Navi21 with the GPU reset tests[4] I had written a while ago - the
>>> current patchset sadly seems to have some regressions WRT recovery
>> there.
>>>
>>> I ran the tests under my Plasma Wayland session once - this triggered
>>> a list double-add in drm_sched_stop (calltrace follows):
>>
>> I think this should fix the double add:
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 7107c4d3a3b6..555d3b671bdb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -88,6 +88,8 @@ static enum drm_gpu_sched_stat
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>                                  drm_sched_start(&ring->sched, true);
>>                          goto exit;
>>                  }
>> +               if (amdgpu_ring_sched_ready(ring))
>> +                       drm_sched_start(&ring->sched, true);
>>          }
>>
>>          if (amdgpu_device_should_recover_gpu(ring->adev)) {
>>
>>
>>>
>>> ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434
>>> arch/x86/kernel/dumpstack.c:447) ? do_trap
>>> (arch/x86/kernel/traps.c:113 arch/x86/kernel/traps.c:154) ?
>>> __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) ?
>>> do_error_trap (./arch/x86/include/asm/traps.h:58
>>> arch/x86/kernel/traps.c:175) ? __list_add_valid_or_report
>>> (lib/list_debug.c:35 (discriminator 1)) ? exc_invalid_op
>>> (arch/x86/kernel/traps.c:266) ? __list_add_valid_or_report
>>> (lib/list_debug.c:35 (discriminator 1)) ? asm_exc_invalid_op
>>> (./arch/x86/include/asm/idtentry.h:568)
>>> ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) ?
>>> __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
>>> drm_sched_stop (./include/linux/list.h:151 ./include/linux/list.h:169
>>> drivers/gpu/drm/scheduler/sched_main.c:617)
>>> amdgpu_device_gpu_recover
>>> (drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5808)
>>> amdgpu_job_timedout
>> (drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:103)
>>> drm_sched_job_timedout (drivers/gpu/drm/scheduler/sched_main.c:569)
>>> process_one_work (kernel/workqueue.c:2633) worker_thread
>>> (kernel/workqueue.c:2700 (discriminator 2) kernel/workqueue.c:2787
>>> (discriminator 2)) ? __pfx_worker_thread (kernel/workqueue.c:2733)
>>> kthread (kernel/kthread.c:388) ? __pfx_kthread (kernel/kthread.c:341)
>>> ret_from_fork (arch/x86/kernel/process.c:147) ? __pfx_kthread
>>> (kernel/kthread.c:341) ret_from_fork_asm
>>> (arch/x86/entry/entry_64.S:251)
>>>
>>> When running the tests without a desktop environment active, the
>>> double-add disappeared, but the GPU reset still didn't go well - the
>>> TTY remained frozen and the kernel log contained a few messages like:
>>>
>>> [drm] *ERROR* [CRTC:90:crtc-0] flip_done timed out
>
> Hi Friedrich, we cannot reproduce the flip_done timed out on dgpu.
> could you have a check if the hangtest runs on integrated gpu or the dgp=
u. If it runs on igpu, could you have a try to disable igpu in bios to see=
 if it works. Thanks.

Hi,

I double-checked with the iGPU disabled in BIOS and can still reproduce.
In case it matters, note that I had a typo in my original message: I'm
testing on Navi22, not 21 - sorry about that.

Also, it seems like the issue also occurs on normal
amd-staging-drm-next without the per-queue reset patches, so this
actually an earlier, unrelated regression.

I'll try bisecting later and will open a separate GitLab issue for this.

Regards,
Friedrich

>
> Thanks,
> Jiadong
>
>> I don't think the display hardware is hung, I think it's a fence signal=
ling issue
>> after the reset.  We are investigating some limitations we are seeing i=
n the
>> handling of fences.
>>
>>>
>>> which I guess means at least the display subsystem is hung.
>>>
>>> Hope this info is enough to repro/investigate.
>>
>> Thanks for testing!
>>
>> Alex
>>
>>>
>>> Thanks,
>>> Friedrich
>>>
>>> [1]
>>> https://lore.kernel.org/amd-gfx/20240717203740.14059-1-alexander.deuch
>>> er@amd.com/T/#t [2]
>>> https://lore.kernel.org/amd-gfx/20240717203847.14600-1-alexander.deuch
>>> er@amd.com/T/#t [3]
>>> https://lore.kernel.org/amd-gfx/230ee72e-4f7f-4894-a789-
>> 2e1e5788344f@a
>>> md.com/T/#t [4] https://gitlab.steamos.cloud/holo/HangTestSuite
>>>
>>>
>>>>
>>>> Alex Deucher (19):
>>>>     drm/amdgpu/mes: add API for legacy queue reset
>>>>     drm/amdgpu/mes11: add API for legacy queue reset
>>>>     drm/amdgpu/mes12: add API for legacy queue reset
>>>>     drm/amdgpu/mes: add API for user queue reset
>>>>     drm/amdgpu/mes11: add API for user queue reset
>>>>     drm/amdgpu/mes12: add API for user queue reset
>>>>     drm/amdgpu: add new ring reset callback
>>>>     drm/amdgpu: add per ring reset support (v2)
>>>>     drm/amdgpu/gfx11: add ring reset callbacks
>>>>     drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
>>>>     drm/amdgpu/gfx10: add ring reset callbacks
>>>>     drm/amdgpu/gfx10: rework reset sequence
>>>>     drm/amdgpu/gfx9: add ring reset callback
>>>>     drm/amdgpu/gfx9.4.3: add ring reset callback
>>>>     drm/amdgpu/gfx12: add ring reset callbacks
>>>>     drm/amdgpu/gfx12: fallback to driver reset compute queue directly
>>>>     drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
>>>>     drm/amdgpu/gfx11: add a mutex for the gfx semaphore
>>>>     drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
>>>>
>>>> Jiadong Zhu (13):
>>>>     drm/amdgpu/gfx11: wait for reset done before remap
>>>>     drm/amdgpu/gfx10: remap queue after reset successfully
>>>>     drm/amdgpu/gfx10: wait for reset done before remap
>>>>     drm/amdgpu/gfx9: remap queue after reset successfully
>>>>     drm/amdgpu/gfx9: wait for reset done before remap
>>>>     drm/amdgpu/gfx9.4.3: remap queue after reset successfully
>>>>     drm/amdgpu/gfx_9.4.3: wait for reset done before remap
>>>>     drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for
>> reset_hw_queue
>>>>     drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
>>>>     drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
>>>>     drm/amdgpu/mes: modify mes api for mmio queue reset
>>>>     drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
>>>>     drm/amdgpu/mes11: implement mmio queue reset for gfx11
>>>>
>>>> Prike Liang (2):
>>>>     drm/amdgpu: increase the reset counter for the queue reset
>>>>     drm/amdgpu/gfx11: fallback to driver reset compute queue directly
>>>> (v2)
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  18 +++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 158
>> ++++++++++++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 117 +++++++++++++--
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  95 ++++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 126 +++++++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 125
>> +++++++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 132
>> +++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++++
>>>>    14 files changed, 930 insertions(+), 32 deletions(-)
>>>>
>>>
>>>
>>>

