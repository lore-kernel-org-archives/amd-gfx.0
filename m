Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACC1C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 09:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B243C10E1C9;
	Thu,  3 Nov 2022 09:07:49 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16F610E1C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 09:07:46 +0000 (UTC)
Received: from [192.168.1.137] ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202211031004514850; Thu, 03 Nov 2022 10:04:51 +0100
Message-ID: <04361686-5bdd-8ca8-2ecd-c5dfdaa1a41b@daenzer.net>
Date: Thu, 3 Nov 2022 10:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
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
Content-Language: de-CH-frami, en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
In-Reply-To: <DS7PR12MB63332B114E5E3B45F91178AFF4389@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F18.636384DD.0065,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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

On 2022-11-03 03:58, Zhu, Jiadong wrote:
> [AMD Official Use Only - General]
> 
>> The bad news is that this series still makes some things very slow. The most extreme examples so far are glxgears (runs at ~400 fps now, ~7000 fps before, i.e. almost 20x slowdown) and hexchat (scrolling one page now takes ~1 second, I can see it drawing line by line; before it was almost instantaneous). I suspect this series makes the overhead of running a single GPU job much bigger. On the bright side, I'm not noticing any significant intermittent freezes anymore.
> 
> Hi Michel,
> 
> Thanks for the trying.
> Is there high priority jobs running while executing glxgears?

Yes, mutter is submitting high priority jobs. However, I don't think that can explain the problem by itself:

mutter only draws once per display refresh cycle. Let's assume mutter's GPU work takes ~6-7ms (conservative example, should be less than that usually). That leaves ~10ms per display refresh cycle (at 60 Hz refresh rate) where GPU work from glxgears & Xwayland can run without getting preempted. Since glxgears runs at ~7000 fps without this series, it should be able to draw at least ~70 frames in 10ms[0], which corresponds to over 4000 fps. Yet it manages only 1/10 of that.

[0] Worst case consideration, ignoring the fact that without this series, glxgears runs at ~7000 fps while mutter sustains 60 fps.


> I am running glxgears while submitting high priority ibs using amdgpu_test, the fps ranges from 6000~8000.

It's getting clear that artificial tests such as amdgpu_test don't suffice for evaluating the real-world impact of this kind of change.


> Continuous preemption and resubmission may cause the slow fps. Could you have a check about how fast the trailing fence seqNo expands. On my side, the increment of Last signaled trailing fence is < 10 in a second.

I had to go back to a kernel without this series, as it was just unusable. As this is my main machine, I don't know when I'll get a chance to check this.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

