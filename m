Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E655FC28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 14:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C6310E462;
	Thu, 25 Aug 2022 14:53:37 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BCC10E462
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 14:53:31 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id u15so31374474ejt.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=8AXonh9KaME/8+cohE7GLlC8hSbeJftEd+C26i8AbiY=;
 b=qNRXoodlNra7BJJ0zl26W6o37RwseIVI8B3oqEoZv7vWrd3JutpuBAg/n3RO0WH8Dr
 DRdXvCCHYlONyXA4yiHt6iZbhiZYCtGSG61M1VT/T04/EOWu+s5/uqWXpQY0oar+RDlt
 4qKtb/hE1ynVCfioTckhzKZdDCgdaeqcXNVl+nf6GAh2+Yven07REJPHy+xJJptWrTB7
 a4YcyBJ+wCZWIN0HASAuagPJso3gPDsoI/8EiPM+GpROOEZrAzaHOUhxU/YsKJw7Pfzk
 DN0fl2lEJL2tJi9zEHNcBjEbQDpQY1uKf1HDZHbtoIJlWFHxg3MghkoZ3M2VaCV2JeYc
 fNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=8AXonh9KaME/8+cohE7GLlC8hSbeJftEd+C26i8AbiY=;
 b=wr0SdE1ruDYbEwgs8v8eWGuiMZL4VsKfjIuyNZtWTZDES1um2g6HKwy5UEwTcyP+xH
 QV/vittjqPQaMLUbP3sK+/wfDMwgKQnKYQ4jKUNiILXoPn58kW/HgmgfLBu+RPoJSqD7
 QIDhw0Djoy+OlBLn+pd6PQgL4SdbG5sURxB6dzfOOXQ8zx61xd8n6XDuz/7x765PB0RS
 31rwf7pJQ0s4eXlvrsIoq2RCTiKUL+bh3BH8TeWLwITMzoahKOmHt4+0C46Yel2TvLiQ
 3wgLfXVY+U91CFsZvmKKVQ75HXuMFpe8Jd604Z7/Daykqyde74ZypgbOuD7OWrnqXBej
 /peg==
X-Gm-Message-State: ACgBeo3mcC4sFsSSwEayuzQdKLZbaIWfvPm9uRXvhXMSfO/HvyMQPMef
 xp7a12xGAUgCJsCD6/q4y20=
X-Google-Smtp-Source: AA6agR4q07lK1Cb1S15cimMvgfXtRukp+LgTQofY8jNcaZcfF0TkDfh4R2R4WTfwscklIQ0ynSosxA==
X-Received: by 2002:a17:906:8cb0:b0:731:5149:a983 with SMTP id
 qr48-20020a1709068cb000b007315149a983mr2707117ejc.549.1661439210302; 
 Thu, 25 Aug 2022 07:53:30 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:eaf:2d60:f77:5ed9?
 ([2a02:908:1256:79a0:eaf:2d60:f77:5ed9])
 by smtp.gmail.com with ESMTPSA id
 qw9-20020a170906fca900b007306a4bc9b4sm2562025ejb.38.2022.08.25.07.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 07:53:29 -0700 (PDT)
Message-ID: <3bddf65e-b14e-4da2-afe9-cf4dba7d9646@gmail.com>
Date: Thu, 25 Aug 2022 16:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
 <CADnq5_McOZzSd+FmtKuLxjTpUD5X=_WrhwDyf_at-E6228T+RA@mail.gmail.com>
 <c552044e-f804-4853-9d61-2bb1338587f0@amd.com>
 <CADnq5_PK0LtCa8_1rvO6PF_vHQcfa_-+V77sBmZUc6Ym0xgWPw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PK0LtCa8_1rvO6PF_vHQcfa_-+V77sBmZUc6Ym0xgWPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org, tseewald@gmail.com,
 helgaas@kernel.org, Alexander.Deucher@amd.com, sr@denx.de,
 Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 25.08.22 um 16:26 schrieb Alex Deucher:
> On Thu, Aug 25, 2022 at 10:22 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>> On 8/25/2022 7:37 PM, Alex Deucher wrote:
>>> On Thu, Aug 25, 2022 at 4:58 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>>> HDP flush is used early in the init sequence as part of memory controller
>>>> block initialization. Hence remapping of HDP registers needed for flush
>>>> needs to happen earlier.
>>>>
>>>> This also fixes the AER error reported as Unsupported Request during
>>>> driver load.
>>>>
>>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=05%7C01%7Clijo.lazar%40amd.com%7Caeec5a5e8ec7402e546708da86a31e41%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637970332414985963%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=EQuUjHTaVPSKZdCUhL6iI4EJ56UMhKTLl86uVpSL8AU%3D&amp;reserved=0
>>>>
>>>> Reported-by: Tom Seewald <tseewald@gmail.com>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/nv.c            | 6 ------
>>>>    drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 ------
>>>>    drivers/gpu/drm/amd/amdgpu/soc21.c         | 6 ------
>>>>    4 files changed, 9 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index ce7d117efdb5..53d753e94a71 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -2376,6 +2376,15 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>                                   DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
>>>>                                   goto init_failed;
>>>>                           }
>>>> +
>>>> +                       /* remap HDP registers to a hole in mmio space,
>>>> +                        * for the purpose of expose those registers
>>>> +                        * to process space. This is needed for any early HDP
>>>> +                        * flush operation during gmc initialization.
>>>> +                        */
>>>> +                       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>>>> +                               adev->nbio.funcs->remap_hdp_registers(adev);
>>>> +
>>> We probably also need this in ip_resume() as well to handle the
>>> suspend and resume case.  Thinking about this more, maybe it's easier
>>> to just track whether the remap has happened yet and use the old or
>>> new offset based on that.
>> If we can use the default offset without a remap, does it make sense to
>> remap? What about calling the same in ip_resume?
> The remap is necessary so that userspace drivers can access this to
> flush the HDP registers when they need to since normally it's in a
> non-accessible region of the MMIO space.  I'm fine with updating it in
> ip_resume as well.

Correct me if I'm wrong but I think remap means it is available at an 
additional location, the privileged region still works as well.

So Lijo suggestion is to use the privileged area in the kernel instead 
of the remapped one.

Right?

Christian.

>
> Alex
>
>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>
>>>>                           r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
>>>>                           if (r) {
>>>>                                   DRM_ERROR("hw_init %d failed %d\n", i, r);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> index b3fba8dea63c..3ac7fef74277 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -1032,12 +1032,6 @@ static int nv_common_hw_init(void *handle)
>>>>           nv_program_aspm(adev);
>>>>           /* setup nbio registers */
>>>>           adev->nbio.funcs->init_registers(adev);
>>>> -       /* remap HDP registers to a hole in mmio space,
>>>> -        * for the purpose of expose those registers
>>>> -        * to process space
>>>> -        */
>>>> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>>>> -               adev->nbio.funcs->remap_hdp_registers(adev);
>>>>           /* enable the doorbell aperture */
>>>>           nv_enable_doorbell_aperture(adev, true);
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> index fde6154f2009..a0481e37d7cf 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> @@ -1240,12 +1240,6 @@ static int soc15_common_hw_init(void *handle)
>>>>           soc15_program_aspm(adev);
>>>>           /* setup nbio registers */
>>>>           adev->nbio.funcs->init_registers(adev);
>>>> -       /* remap HDP registers to a hole in mmio space,
>>>> -        * for the purpose of expose those registers
>>>> -        * to process space
>>>> -        */
>>>> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>>>> -               adev->nbio.funcs->remap_hdp_registers(adev);
>>>>
>>>>           /* enable the doorbell aperture */
>>>>           soc15_enable_doorbell_aperture(adev, true);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>> index 55284b24f113..16b447055102 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>> @@ -660,12 +660,6 @@ static int soc21_common_hw_init(void *handle)
>>>>           soc21_program_aspm(adev);
>>>>           /* setup nbio registers */
>>>>           adev->nbio.funcs->init_registers(adev);
>>>> -       /* remap HDP registers to a hole in mmio space,
>>>> -        * for the purpose of expose those registers
>>>> -        * to process space
>>>> -        */
>>>> -       if (adev->nbio.funcs->remap_hdp_registers)
>>>> -               adev->nbio.funcs->remap_hdp_registers(adev);
>>>>           /* enable the doorbell aperture */
>>>>           soc21_enable_doorbell_aperture(adev, true);
>>>>
>>>> --
>>>> 2.25.1
>>>>

