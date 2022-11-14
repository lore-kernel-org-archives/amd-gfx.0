Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCA1C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 17:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132AD10E057;
	Mon, 14 Nov 2022 17:15:29 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1E110E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 17:15:21 +0000 (UTC)
Received: from [192.168.1.137] ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202211141815178850; Mon, 14 Nov 2022 18:15:17 +0100
Message-ID: <ddf6786a-7bdc-c8fa-e432-7e20498bb26d@daenzer.net>
Date: Mon, 14 Nov 2022 18:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
 <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
 <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
 <92da389f-3c26-6fe1-0525-d38730b6924a@daenzer.net>
 <8b3240e6-c460-5dbd-eede-29ff4825e642@daenzer.net>
 <DS7PR12MB63332B114E5E3B45F91178AFF4389@DS7PR12MB6333.namprd12.prod.outlook.com>
 <04361686-5bdd-8ca8-2ecd-c5dfdaa1a41b@daenzer.net>
 <DS7PR12MB63331E4430DC731D92B0A7CAF43F9@DS7PR12MB6333.namprd12.prod.outlook.com>
 <fb72d05b-dc74-fa84-51cf-3c3911aa46fc@daenzer.net>
Content-Language: de-CH-frami, en-CA
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
In-Reply-To: <fb72d05b-dc74-fa84-51cf-3c3911aa46fc@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1C.637277A7.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-10 18:00, Michel Dänzer wrote:
> On 2022-11-08 09:01, Zhu, Jiadong wrote:
>>
>> I reproduced the glxgears 400fps scenario locally. The issue is caused by the patch5 "drm/amdgpu: Improve the software rings priority scheduler" which slows down the low priority scheduler thread if high priority ib is under executing. I'll drop this patch as we cannot identify gpu bound according to the unsignaled fence, etc.
> 
> Okay, I'm testing with patches 1-4 only now.
> 
> So far I haven't noticed any negative effects, no slowdowns or intermittent freezes.

I'm afraid I may have run into another issue. I just hit a GPU hang, see the
journalctl excerpt below.

(I tried rebooting the machine via SSH after this, but it never seemed to
complete, so I had to hard-power-off the machine by holding the power
button for a few seconds)

I can't be sure that the GPU hang is directly related to this series,
but it seems plausible, and I hadn't hit a GPU hang in months if not
over a year before. If this series results in potentially hitting a
GPU hang every few days, it definitely doesn't provide enough benefit
to justify that.


Nov 14 17:21:22 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_high timeout, signaled seq=1166051, emitted seq=1166052
Nov 14 17:21:22 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process gnome-shell pid 2828 thread gnome-shel:cs0 pid 2860
Nov 14 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset begin!
Nov 14 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: free PSP TMR buffer
Nov 14 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: MODE2 reset
Nov 14 17:21:22 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset succeeded, trying to resume
Nov 14 17:21:22 thor kernel: [drm] PCIE GART of 1024M enabled.
Nov 14 17:21:22 thor kernel: [drm] PTB located at 0x000000F400A00000
Nov 14 17:21:22 thor kernel: [drm] VRAM is lost due to GPU reset!
Nov 14 17:21:22 thor kernel: [drm] PSP is resuming...
Nov 14 17:21:22 thor kernel: [drm] reserve 0x400000 from 0xf431c00000 for PSP TMR
Nov 14 17:21:23 thor kernel: amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta ucode is not available
Nov 14 17:21:23 thor kernel: amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta ucode is not available
Nov 14 17:21:23 thor gnome-shell[3639]: amdgpu: The CS has been rejected (-125), but the context isn't robust.
Nov 14 17:21:23 thor gnome-shell[3639]: amdgpu: The process will be terminated.
Nov 14 17:21:23 thor kernel: [drm] kiq ring mec 2 pipe 1 q 0
Nov 14 17:21:23 thor kernel: amdgpu 0000:05:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_2.1.0 test failed (-110)
Nov 14 17:21:23 thor kernel: [drm:amdgpu_gfx_enable_kcq.cold [amdgpu]] *ERROR* KCQ enable failed
Nov 14 17:21:23 thor kernel: [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v9_0> failed -110
Nov 14 17:21:23 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset(2) failed
Nov 14 17:21:23 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset end with ret = -110
Nov 14 17:21:23 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* GPU Recovery Failed: -110
[...]
Nov 14 17:21:33 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_high timeout, signaled seq=1166052, emitted seq=1166052
Nov 14 17:21:33 thor kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process gnome-shell pid 2828 thread gnome-shel:cs0 pid 2860
Nov 14 17:21:33 thor kernel: amdgpu 0000:05:00.0: amdgpu: GPU reset begin!


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

