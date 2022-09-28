Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1502EC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 15:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5276210E9C7;
	Wed, 28 Sep 2022 15:07:19 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A6810E9C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 15:07:16 +0000 (UTC)
Received: from thor ([85.2.99.24])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202209281707116743; Wed, 28 Sep 2022 17:07:11 +0200
Received: from [127.0.0.1] by thor with esmtp (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1odYeT-0002UN-27;
 Wed, 28 Sep 2022 17:07:09 +0200
Message-ID: <fb107b1a-b4ba-bb65-8e66-abbd6129b4cf@daenzer.net>
Date: Wed, 28 Sep 2022 17:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: de-CH-frami, en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20220923131630.1260501-1-jiadong.zhu@amd.com>
 <20220923131630.1260501-4-jiadong.zhu@amd.com>
 <3d88b423-1d14-2954-e3ce-0c50887cf621@gmail.com>
 <DS7PR12MB633336F275D92829CA93BF2CF4559@DS7PR12MB6333.namprd12.prod.outlook.com>
 <fad25aa5-3f0a-0135-e580-1c96bfc37120@amd.com>
 <6a8623f8-941f-4fa4-b0e4-0beb9b4715b3@daenzer.net>
 <4c9c09b3-abbd-1dff-33f6-e9478e8a137c@amd.com>
 <DS7PR12MB633351087443795FA98B47F6F4549@DS7PR12MB6333.namprd12.prod.outlook.com>
 <d1967e64-8561-163a-fe93-be3e0b827f50@daenzer.net>
 <849a8d68-c752-ace3-3823-26ff247896c8@gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 4/4] drm/amdgpu: MCBP based on DRM scheduler (v6)
In-Reply-To: <849a8d68-c752-ace3-3823-26ff247896c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F25.63346320.005D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-28 16:46, Christian König wrote:
> Am 28.09.22 um 15:52 schrieb Michel Dänzer:
>> On 2022-09-28 03:01, Zhu, Jiadong wrote:>
>>> Please make sure umd is calling the libdrm function to create context with different priories,
>>> amdgpu_cs_ctx_create2(device_handle, AMDGPU_CTX_PRIORITY_HIGH, &context_handle).
>> Yes, I double-checked that, and that it returns success.
>>
>>
>>> Here is the behavior we could see:
>>> 1. After modprobe amdgpu, two software rings named gfx_high/gfx_low(in previous patch named gfx_sw) is visible in UMR. We could check the wptr/ptr to see if it is being used.
>>> 2. MCBP happens while the two different priority ibs are submitted at the same time. We could check fence info as below:
>>> Last signaled trailing fence++  when the mcbp triggers by kmd. Last preempted may not increase as the mcbp is not triggered from CP.
>>>
>>> --- ring 0 (gfx) ---
>>> Last signaled fence          0x00000001
>>> Last emitted                 0x00000001
>>> Last signaled trailing fence 0x0022eb84
>>> Last emitted                 0x0022eb84
>>> Last preempted               0x00000000
>>> Last reset                   0x00000000
>> I've now tested on this Picasso (GFX9) laptop as well. The "Last signaled trailing fence" line is changing here (seems to always match the "Last emitted" line).
>>
>> However, mutter's frame rate still cannot exceed that of GPU-limited clients. BTW, you can test with a GNOME Wayland session, even without my MR referenced below. Preemption will just be less effective without that MR. mutter has used a high priority context when possible for a long time.
>>
>> I'm also seeing intermittent freezes, where not even the mouse cursor moves for up to around one second, e.g. when interacting with the GNOME top bar. I'm not sure yet if these are related to this patch series, but I never noticed it before. I wonder if the freezes might occur when GPU preemption is attempted.
> 
> Keep in mind that this doesn't have the same fine granularity as the separate hw ring buffer found on gfx10.
> 
> With MCBP we can only preempt on draw command boundary, while the separate hw ring solution can preempt as soon as a CU is available.

Right, but so far I haven't noticed any positive effect. That and the intermittent freezes indicate the MCBP based preemption isn't actually working as intended yet.


>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>
>>>> This work is solely for gfx9 (e.g. Vega) and older.
>>>>
>>>> Navi has a completely separate high priority gfx queue we can use for this.
>> Right, but 4c7631800e6b ("drm/amd/amdgpu: add pipe1 hardware support") was for Sienna Cichlid only, and turned out to be unstable, so it had to reverted.
>>
>> It would be nice to make the SW ring solution take effect by default whenever there is no separate high priority HW gfx queue available (and any other requirements are met).
> 
> I don't think that this will be a good idea. The hw ring buffer or even hw scheduler have much nicer properties and we should focus on getting that working when available.

Of course, the HW features should have priority. I mean as a fallback when the HW features effectively aren't available (which is currently always the case with amdgpu, even when the GPU has the HW features).


>>> Am 27.09.22 um 19:49 schrieb Michel Dänzer:
>>>> On 2022-09-27 08:06, Christian König wrote:
>>>>> Hey Michel,
>>>>>
>>>>> JIadong is working on exposing high/low priority gfx queues for gfx9 and older hw generations by using mid command buffer preemption.
>>>> Yeah, I've been keeping an eye on these patches. I'm looking forward to this working.
>>>>
>>>>
>>>>> I know that you have been working on Gnome Mutter to make use from userspace for this. Do you have time to run some tests with that?
>>>> I just tested the v8 series (first without amdgpu.mcbp=1 on the kernel command line, then with it, since I wasn't sure if it's needed) with https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.gnome.org%2FGNOME%2Fmutter%2F-%2Fmerge_requests%2F1880&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cc6345d9230004549ba4d08daa0b0abcd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637998977913548768%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=P1Qo2AwDmfmPrxJe2SxTFsVjdJ9vjabK8s84ZVz%2Beh8%3D&amp;reserved=0 on Navi 14.
>>>>
>>>> Unfortunately, I'm not seeing any change in behaviour. Even though mutter uses a high priority context via the EGL_IMG_context_priority extension, it's unable to reach a higher frame rate than a GPU-limited client[0]. The "Last preempted" line of /sys/kernel/debug/dri/0/amdgpu_fence_info remains at 0x00000000.
>>>>
>>>> Did I miss a step?
>>>>
>>>>
>>>> [0] I used the GpuTest pixmark piano & plot3d benchmarks. With an Intel iGPU, mutter can achieve a higher frame rate than plot3d, though not than pixmark piano (presumably due to limited GPU preemption granularity).
>>
> 

-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

