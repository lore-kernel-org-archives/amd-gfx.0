Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FE9CD13D1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 08:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7149110E217;
	Mon, 18 Sep 2023 08:36:48 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C038F10E217
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 08:36:46 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso533112766b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695026205; x=1695631005; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyrtqtyxz0kf7KWLupU3SuH1pIV7/6n9Dt8wDprKLv0=;
 b=NAiV/4EgroyHCncj8a7OSdBwvxYUytni0pqWFjBAytB3UOjZFOEDsG1Naq2ZsbFhCI
 GnMN+Y6XQQt+ZOy2kloMss2dkXnxgncq0BA83/Khnf4VOHlz/lI7Cz7En+gp/3CE6PtJ
 y853GhKqxpKoCkx8PrQnkBM+WwO6KnGRIJavxbzrq+whCBxFwgDCF2xDsF8pD3s73Kum
 5kOgXDbSnjJTstGiiNqtOXnYunfgNyWWKJBnpwkVpm3qUiNP4yymUMo10dQHA7HmGc5F
 cradUVVqj/HvZ6xrzCIw4RRDXdBko136o9f6tVVbA/YeHsARLE21QRynzxe77g0aalAR
 TZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695026205; x=1695631005;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uyrtqtyxz0kf7KWLupU3SuH1pIV7/6n9Dt8wDprKLv0=;
 b=nGKmyzLij+PvdVzqCFKIMRSH2JoL7JkAYf4udhMm2X07v4a1t6CugDYJk1H3XM6ZWp
 rYNa9vUBrx9yfKiQ9/bsUrbLvya4lw8PYAEhu0XWSCQVAzaAraxLMgUjBqry2bu+5YTK
 HDD8aahhF7GUvbULgvJ4SCroMg5SbuZgL4pBBpnrDV3NLc+elPcPrinbk5yNXfsvLhwg
 iRC6mK67IxL9cCNHfmSxwfIlMPvMjG0AbscvZMlngooVeWjXYi9zhaFjFTnOQzviz1ER
 Aqt0tsRHoy4jRDlqnOTemh8C+tSPk6uZdjSoWzmQNzWDtn9YgvaAQy6Hla7BA/qkk5Ng
 r9XA==
X-Gm-Message-State: AOJu0Yzk17vSDH0spJZt2SHjGEt03q5p3YTBUSWVq1iNf42YB+7qRPHX
 ZzK3VqkVEjB2xJNMy+3Eyw8=
X-Google-Smtp-Source: AGHT+IHvoey1ZR1WUGvA9KSRh2zHccgskN3EGNUIEs8NxuqheFirAGozeoSaBtaI2kFPhvJUOk/QMg==
X-Received: by 2002:a17:906:5381:b0:9a1:e371:e238 with SMTP id
 g1-20020a170906538100b009a1e371e238mr6997733ejo.64.1695026204762; 
 Mon, 18 Sep 2023 01:36:44 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.99])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a170906710600b00992e14af9c3sm6185662ejj.143.2023.09.18.01.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 01:36:44 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------047m2Yn7buImfyUX4lz0hrXL"
Message-ID: <a8d5a6c1-f830-d652-3b58-7dfd8a16ab3e@gmail.com>
Date: Mon, 18 Sep 2023 10:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
 <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
 <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
 <e7913001-ff45-169d-7110-3f2bef86208a@amd.com>
 <ZQQbmfuivo/F+b9o@lang-desktop>
 <39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com>
 <1c4c51ad-a042-983a-ff66-cddfbb917c6f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <1c4c51ad-a042-983a-ff66-cddfbb917c6f@amd.com>
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
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------047m2Yn7buImfyUX4lz0hrXL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.09.23 um 16:49 schrieb Felix Kuehling:
> On 2023-09-15 6:19, Christian König wrote:
>> Am 15.09.23 um 10:53 schrieb Lang Yu:
>>> On 09/14/ , Felix Kuehling wrote:
>>>> On 2023-09-14 10:02, Christian König wrote:
>>> Do we still need to use legacy flush to emulate heavyweight flush
>>> if we don't use SVM? And can I push this now?
>>
>> Felix needs to decide that. From what I understand the KFD needs 
>> heavyweight flushes for secure SVM operation.
>
> Yes. We need to be able to guarantee to the kernel, that the GPU will 
> not access unmapped memory. There are two strategies in the driver to 
> do this:
>
>  1. Preempt GPU queues (which implies a heavy-weight TLB flush in the
>     scheduler firmware)
>  2. Invalidate page table entries and flush TLBs
>
> #1 happens during MMU notifiers with XNACK off. #2 happens in MMU 
> notifiers with XNACK on (not supported on GFX10.x) and when unified 
> memory us munmapped. It's that last part I'm worried about. When 
> memory is munmapped and given back to the OS, we need to be able to 
> guarantee that the GPU won't access it any more. The same is true when 
> GTT BOs and userptr BOs are freed. After unmapping them from the GPU 
> page tables, we need a heavy-weight flush. I believe the same should 
> apply to the graphics driver, but maybe that's implied through the CS 
> and fence mechanisms that keep memory allocated while the GPU is 
> accessing it.
>
> A legacy flush has a slim chance of not being sufficient because 
> memory accesses using old addresses can still be in flight in the GPU.
>
>
>>
>> If heavyweight flushes are buggy papering over that by using legacy 
>> flushes is only a mediocre workaround.
>
> I agree. I'd like to avoid half-baked workarounds that will cause more 
> headaches later on. I started an internal email thread with Tony to 
> understand the requirements for heavy-weight flushes on the affected 
> GPUs and find a better workaround.
>

Thanks, then this patch should be put on hold until that stuff is 
cleared up.

Regards,
Christian.

> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Lang
>>>
>>>
>>>>> Am 14.09.23 um 15:59 schrieb Felix Kuehling:
>>>>>> On 2023-09-14 9:39, Christian König wrote:
>>>>>>> Is a single legacy flush sufficient to emulate an heavyweight
>>>>>>> flush as well?
>>>>>>>
>>>>>>> On previous generations we needed to issue at least two legacy
>>>>>>> flushes for this.
>>>>>> I assume you are referring to the Vega20 XGMI workaround. That is a
>>>>>> very different issue. Because PTEs would be cached in L2, we had to
>>>>>> always use a heavy-weight flush that would also flush the L2 cache
>>>>>> as well, and follow that with another legacy flush to deal with race
>>>>>> conditions where stale PTEs could be re-fetched from L2 before the
>>>>>> L2 flush was complete.
>>>>> No, we also have another (badly documented) workaround which issues a
>>>>> legacy flush before each heavy weight on some hw generations. See 
>>>>> the my
>>>>> TLB flush cleanup patches.
>>>>>
>>>>>> A heavy-weight flush guarantees that there are no more possible
>>>>>> memory accesses using the old PTEs. With physically addressed caches
>>>>>> on GFXv9 that includes a cache flush because the address translation
>>>>>> happened before putting data into the cache. I think the address
>>>>>> translation and cache architecture works differently on GFXv10. So
>>>>>> maybe the cache-flush is not required here.
>>>>>>
>>>>>> But even then a legacy flush probably allows for in-flight memory
>>>>>> accesses with old physical addresses to complete after the TLB
>>>>>> flush. So there is a small risk of memory corruption that was
>>>>>> assumed to not be accessed by the GPU any more. Or when using IOMMU
>>>>>> device isolation it would result in IOMMU faults if the DMA mappings
>>>>>> are invalidated slightly too early.
>>>>> Mhm, that's quite bad. Any idea how to avoid that?
>>>> A few ideas
>>>>
>>>>   * Add an arbitrary delay and hope that it is longer than the 
>>>> FIFOs in
>>>>     the HW
>>>>   * Execute an atomic operation to memory on some GPU engine that 
>>>> could
>>>>     act as a fence, maybe just a RELEASE_MEM on the CP to some 
>>>> writeback
>>>>     location would do the job
>>>>   * If needed, RELEASE_MEM could also perform a cache flush
>>>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Regards,
>>>>>>    Felix
>>>>>>
>>>>>>
>>>>>>> And please don't push before getting an rb from Felix as well.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>
>>>>>>> Am 14.09.23 um 11:23 schrieb Lang Yu:
>>>>>>>> cyan_skilfish has problems with other flush types.
>>>>>>>>
>>>>>>>> v2: fix incorrect ternary conditional operator usage.(Yifan)
>>>>>>>>
>>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>>> Cc: <stable@vger.kernel.org> # v5.15+
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>>> index d3da13f4c80e..c6d11047169a 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>>> @@ -236,7 +236,8 @@ static void
>>>>>>>> gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t
>>>>>>>> vmid,
>>>>>>>>    {
>>>>>>>>        bool use_semaphore =
>>>>>>>> gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>>>>>>>>        struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>>>>>>> -    u32 inv_req =
>>>>>>>> hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
>>>>>>>> +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
>>>>>>>> +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ?
>>>>>>>> flush_type : 0);
>>>>>>>>        u32 tmp;
>>>>>>>>        /* Use register 17 for GART */
>>>>>>>>        const unsigned int eng = 17;
>>>>>>>> @@ -331,6 +332,8 @@ static void
>>>>>>>> gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
>>>>>>>> vmid,
>>>>>>>>          int r;
>>>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>>>> ? flush_type : 0;
>>>>>>>> +
>>>>>>>>        /* flush hdp cache */
>>>>>>>>        adev->hdp.funcs->flush_hdp(adev, NULL);
>>>>>>>>    @@ -426,6 +429,8 @@ static int
>>>>>>>> gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>>>>>>        struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>>>>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>>>> ? flush_type : 0;
>>>>>>>> +
>>>>>>>>        if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>>>>>>> spin_lock(&adev->gfx.kiq[0].ring_lock);
>>>>>>>>            /* 2 dwords flush + 8 dwords fence */
>>

--------------047m2Yn7buImfyUX4lz0hrXL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 15.09.23 um 16:49 schrieb Felix Kuehling:<br>
    <blockquote type="cite"
      cite="mid:1c4c51ad-a042-983a-ff66-cddfbb917c6f@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div class="moz-cite-prefix">On 2023-09-15 6:19, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com">Am
        15.09.23 um 10:53 schrieb Lang Yu: <br>
        <blockquote type="cite">On 09/14/ , Felix Kuehling wrote: <br>
          <blockquote type="cite">On 2023-09-14 10:02, Christian König
            wrote: <br>
          </blockquote>
          Do we still need to use legacy flush to emulate heavyweight
          flush <br>
          if we don't use SVM? And can I push this now? <br>
        </blockquote>
        <br>
        Felix needs to decide that. From what I understand the KFD needs
        heavyweight flushes for secure SVM operation. <br>
      </blockquote>
      <p>Yes. We need to be able to guarantee to the kernel, that the
        GPU will not access unmapped memory. There are two strategies in
        the driver to do this:</p>
      <ol>
        <li>Preempt GPU queues (which implies a heavy-weight TLB flush
          in the scheduler firmware)</li>
        <li>Invalidate page table entries and flush TLBs<br>
        </li>
      </ol>
      <p>#1 happens during MMU notifiers with XNACK off. #2 happens in
        MMU notifiers with XNACK on (not supported on GFX10.x) and when
        unified memory us munmapped. It's that last part I'm worried
        about. When memory is munmapped and given back to the OS, we
        need to be able to guarantee that the GPU won't access it any
        more. The same is true when GTT BOs and userptr BOs are freed.
        After unmapping them from the GPU page tables, we need a
        heavy-weight flush. I believe the same should apply to the
        graphics driver, but maybe that's implied through the CS and
        fence mechanisms that keep memory allocated while the GPU is
        accessing it.<br>
      </p>
      <p>A legacy flush has a slim chance of not being sufficient
        because memory accesses using old addresses can still be in
        flight in the GPU.<br>
      </p>
      <br>
      <blockquote type="cite"
        cite="mid:39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com"> <br>
        If heavyweight flushes are buggy papering over that by using
        legacy flushes is only a mediocre workaround. <br>
      </blockquote>
      <p>I agree. I'd like to avoid half-baked workarounds that will
        cause more headaches later on. I started an internal email
        thread with Tony to understand the requirements for heavy-weight
        flushes on the affected GPUs and find a better workaround.</p>
    </blockquote>
    <br>
    Thanks, then this patch should be put on hold until that stuff is
    cleared up.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:1c4c51ad-a042-983a-ff66-cddfbb917c6f@amd.com">
      <p>Regards,<br>
          Felix<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com"> <br>
        Regards, <br>
        Christian. <br>
        <br>
        <blockquote type="cite"> <br>
          Regards, <br>
          Lang <br>
          <br>
          <br>
          <blockquote type="cite">
            <blockquote type="cite">Am 14.09.23 um 15:59 schrieb Felix
              Kuehling: <br>
              <blockquote type="cite">On 2023-09-14 9:39, Christian
                König wrote: <br>
                <blockquote type="cite">Is a single legacy flush
                  sufficient to emulate an heavyweight <br>
                  flush as well? <br>
                  <br>
                  On previous generations we needed to issue at least
                  two legacy <br>
                  flushes for this. <br>
                </blockquote>
                I assume you are referring to the Vega20 XGMI
                workaround. That is a <br>
                very different issue. Because PTEs would be cached in
                L2, we had to <br>
                always use a heavy-weight flush that would also flush
                the L2 cache <br>
                as well, and follow that with another legacy flush to
                deal with race <br>
                conditions where stale PTEs could be re-fetched from L2
                before the <br>
                L2 flush was complete. <br>
              </blockquote>
              No, we also have another (badly documented) workaround
              which issues a <br>
              legacy flush before each heavy weight on some hw
              generations. See the my <br>
              TLB flush cleanup patches. <br>
              <br>
              <blockquote type="cite">A heavy-weight flush guarantees
                that there are no more possible <br>
                memory accesses using the old PTEs. With physically
                addressed caches <br>
                on GFXv9 that includes a cache flush because the address
                translation <br>
                happened before putting data into the cache. I think the
                address <br>
                translation and cache architecture works differently on
                GFXv10. So <br>
                maybe the cache-flush is not required here. <br>
                <br>
                But even then a legacy flush probably allows for
                in-flight memory <br>
                accesses with old physical addresses to complete after
                the TLB <br>
                flush. So there is a small risk of memory corruption
                that was <br>
                assumed to not be accessed by the GPU any more. Or when
                using IOMMU <br>
                device isolation it would result in IOMMU faults if the
                DMA mappings <br>
                are invalidated slightly too early. <br>
              </blockquote>
              Mhm, that's quite bad. Any idea how to avoid that? <br>
            </blockquote>
            A few ideas <br>
            <br>
              * Add an arbitrary delay and hope that it is longer than
            the FIFOs in <br>
                the HW <br>
              * Execute an atomic operation to memory on some GPU engine
            that could <br>
                act as a fence, maybe just a RELEASE_MEM on the CP to
            some writeback <br>
                location would do the job <br>
              * If needed, RELEASE_MEM could also perform a cache flush
            <br>
            <br>
            Regards, <br>
               Felix <br>
            <br>
            <br>
            <blockquote type="cite">Regards, <br>
              Christian. <br>
              <br>
              <blockquote type="cite">Regards, <br>
                   Felix <br>
                <br>
                <br>
                <blockquote type="cite">And please don't push before
                  getting an rb from Felix as well. <br>
                  <br>
                  Regards, <br>
                  Christian. <br>
                  <br>
                  <br>
                  Am 14.09.23 um 11:23 schrieb Lang Yu: <br>
                  <blockquote type="cite">cyan_skilfish has problems
                    with other flush types. <br>
                    <br>
                    v2: fix incorrect ternary conditional operator
                    usage.(Yifan) <br>
                    <br>
                    Signed-off-by: Lang Yu <a
                      class="moz-txt-link-rfc2396E"
                      href="mailto:Lang.Yu@amd.com"
                      moz-do-not-send="true">&lt;Lang.Yu@amd.com&gt;</a>
                    <br>
                    Cc: <a class="moz-txt-link-rfc2396E"
                      href="mailto:stable@vger.kernel.org"
                      moz-do-not-send="true">&lt;stable@vger.kernel.org&gt;</a>
                    # v5.15+ <br>
                    --- <br>
                       drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7
                    ++++++- <br>
                       1 file changed, 6 insertions(+), 1 deletion(-) <br>
                    <br>
                    diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                    <br>
                    b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c <br>
                    index d3da13f4c80e..c6d11047169a 100644 <br>
                    --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c <br>
                    +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c <br>
                    @@ -236,7 +236,8 @@ static void <br>
                    gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev,
                    uint32_t <br>
                    vmid, <br>
                       { <br>
                           bool use_semaphore = <br>
                    gmc_v10_0_use_invalidate_semaphore(adev, vmhub); <br>
                           struct amdgpu_vmhub *hub =
                    &amp;adev-&gt;vmhub[vmhub]; <br>
                    -    u32 inv_req = <br>
                    hub-&gt;vmhub_funcs-&gt;get_invalidate_req(vmid,
                    flush_type); <br>
                    +    u32 inv_req =
                    hub-&gt;vmhub_funcs-&gt;get_invalidate_req(vmid, <br>
                    +              (adev-&gt;asic_type !=
                    CHIP_CYAN_SKILLFISH) ? <br>
                    flush_type : 0); <br>
                           u32 tmp; <br>
                           /* Use register 17 for GART */ <br>
                           const unsigned int eng = 17; <br>
                    @@ -331,6 +332,8 @@ static void <br>
                    gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev,
                    uint32_t <br>
                    vmid, <br>
                             int r; <br>
                       +    flush_type = (adev-&gt;asic_type !=
                    CHIP_CYAN_SKILLFISH) <br>
                    ? flush_type : 0; <br>
                    + <br>
                           /* flush hdp cache */ <br>
                           adev-&gt;hdp.funcs-&gt;flush_hdp(adev, NULL);
                    <br>
                       @@ -426,6 +429,8 @@ static int <br>
                    gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device
                    *adev, <br>
                           struct amdgpu_ring *ring =
                    &amp;adev-&gt;gfx.kiq[0].ring; <br>
                           struct amdgpu_kiq *kiq =
                    &amp;adev-&gt;gfx.kiq[0]; <br>
                       +    flush_type = (adev-&gt;asic_type !=
                    CHIP_CYAN_SKILLFISH) <br>
                    ? flush_type : 0; <br>
                    + <br>
                           if (amdgpu_emu_mode == 0 &amp;&amp;
                    ring-&gt;sched.ready) { <br>
                              
                    spin_lock(&amp;adev-&gt;gfx.kiq[0].ring_lock); <br>
                               /* 2 dwords flush + 8 dwords fence */ <br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------047m2Yn7buImfyUX4lz0hrXL--
