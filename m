Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77AD60FC2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B77AD60FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7261373740;
	Wed,  3 Nov 2021 15:36:04 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D8773740
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 15:36:04 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id q124so4275347oig.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Nov 2021 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jDToyKhlPt8jwvMTXKmUvNEHW5L24thwzvxhT+GYvgw=;
 b=LG0LA3j4Qg7B+Fw8OuqM4KBZPf5w+0SjHJRAMSbqXO6YLyUimkh8nclxFV3hwex4+K
 NcXwr0Sawm7RiA62M3Mxiq1t5EfZWPieUrZINAtDeJr9oW8ibitXRQXaDHfl8v/0fsBK
 WrMJTWYEkgta4fKmOAppXJE5j/5GQQuDKxYriFx/i+XnEvYzXzVZ9K84Vejd72uBDLLy
 VspwD6oUsMbWJbFwYybbv3At68QMP4AkCfTKU5Hrrye3DVLGq5/oum+OedMNGGWUtu1P
 t+s5di1EvocMSaJameWaNIg41aS9wKCe3YbZSGw+jKfqVEEUClDm1DuHqlXmPH6h2Op8
 mnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jDToyKhlPt8jwvMTXKmUvNEHW5L24thwzvxhT+GYvgw=;
 b=CbsbuuXWZVtROqh18y7S8sHdzWtUujXcniQMYK8faZ0jYbLJCVKXzojO95/+Hx8G+7
 cEsi0U1Hiuqajkz1sgf5NI2HyyP+aCwlFsIbS4C8XwpaCxG8HJCDMHF8TrAkGvDMTlpC
 t44AYUyuiTu3LNian52u/yaB87ozZ6Dzw2mN46H/51i89HdF1kONBLp+5l4Y1Rb6TRou
 0NaVF5YI3Nt11UA1ppl6xYjlJvY55wRb27ILXPUZlBN7zN5olu2Trml5kH23l64B/Qwy
 hYWL52jAzFLca6nk8kinBa4lZ654IzR6lt4YEMg7AlmDusSPDrBVmLs9EIiYrVx4qMOR
 Kamw==
X-Gm-Message-State: AOAM530D9ZFhXh4AnRu/Yrwacm6j5SKYW1An7xtY4BvDZK+OETEhDghK
 ARM7acK2yq4Alt/wa1lCRE11H6kHJoy9Jsm8MdM=
X-Google-Smtp-Source: ABdhPJwgJEtLBRVkZPdaU+uqYb7bnL4/1hixXkJqnBE8BtC7cGtNcJv1eHA83F9wbmvRsXipHQm9GV/6+6HLchVwBy8=
X-Received: by 2002:a05:6808:23cb:: with SMTP id
 bq11mr11446466oib.123.1635953763197; 
 Wed, 03 Nov 2021 08:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211103013350.6015-1-James.Zhu@amd.com>
 <CADnq5_OurPZjmq2SbRZzw4MWRO2uFT7H=+F75czmwgG0MgGAiQ@mail.gmail.com>
 <BN6PR12MB1874ED9C570180113DB71F42E48C9@BN6PR12MB1874.namprd12.prod.outlook.com>
 <CADnq5_MScsyQWiiDsFLwObyrT1ViGL5dFP8K5+3U7TuNHo_cYQ@mail.gmail.com>
In-Reply-To: <CADnq5_MScsyQWiiDsFLwObyrT1ViGL5dFP8K5+3U7TuNHo_cYQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Nov 2021 11:35:52 -0400
Message-ID: <CADnq5_OffC1XyUOzFvWMe9MFkjL6o+Du5xvyef3xUALS2LmyEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove duplicated kfd_resume_iommu
To: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, James Zhu <jzhums@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Ken Moffat <zarniwhoop@ntlworld.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 3, 2021 at 10:50 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
>
>
> On Wed, Nov 3, 2021 at 10:34 AM Zhu, James <James.Zhu@amd.com> wrote:
>>
>> [AMD Official Use Only]
>>
>>
>> Hi Alex,
>>
>> Finally figured out the root cause for this broken,
>>
>> Linux 5.14.15  + afd1818 can fix the issue.

I think this applies to 5.15 as well.  Only drm-next (5.16) needs this patc=
h.

Alex

>
>
> I'll do that for stable.
>
>>
>> Linux 5.15rc7 re-apply "init iommu after amdkfd device init" and "move i=
ommu_resume before ip init/resume" which overwrote afd1818 caused the issue=
 again.
>>
>> 714d9e4 drm/amdgpu: init iommu after amdkfd device init
>>
>> f02abeb drm/amdgpu: move iommu_resume before ip init/resume
>>
>> afd1818 drm/amdkfd: fix boot failure when iommu is disabled in Picasso.
>>
>> 286826d drm/amdgpu: init iommu after amdkfd device init
>>
>> 9cec53c drm/amdgpu: move iommu_resume before ip init/resume
>>
>>
>>
>> So, do we just discard this patch, and revert 714d9e4 and  f02abeb?
>
>
> I'll do that for 5.15+
>
> Thanks for sorting this out.
>
> Alex
>
>>
>>
>> Thanks & Best Regards!
>>
>>
>> James Zhu
>>
>> ________________________________
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Tuesday, November 2, 2021 10:01 PM
>> To: Zhu, James <James.Zhu@amd.com>
>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; James Zhu <j=
zhums@gmail.com>; Ken Moffat <zarniwhoop@ntlworld.com>
>> Subject: Re: [PATCH] drm/amdgpu: remove duplicated kfd_resume_iommu
>>
>> On Tue, Nov 2, 2021 at 9:34 PM James Zhu <James.Zhu@amd.com> wrote:
>> >
>> > Remove duplicated kfd_resume_iommu which already runs
>> > in mdgpu_amdkfd_device_init.
>> >
>> > Signed-off-by: James Zhu <James.Zhu@amd.com>
>>
>> Once you get confirmation, please add:
>> Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214859&amp;data=3D04%7C01%7CJame=
s.Zhu%40amd.com%7C8662c25150e94d9d664708d99e6deb2b%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637715017208277821%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
a6WyuNGhOU5OT3J8GQtXSQ3O5r942D2p%2BbruFUncT0E%3D&amp;reserved=3D0
>> Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1770&amp;data=3D04%7C01%=
7CJames.Zhu%40amd.com%7C8662c25150e94d9d664708d99e6deb2b%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637715017208287813%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd=
ata=3DE1MFXdprEaldLux2AoXNEeDWL5E85WFv8CrfZODTa%2F4%3D&amp;reserved=3D0
>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>> >  1 file changed, 4 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
>> > index e56bc925afcf..f77823ce7ae8 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > @@ -2398,10 +2398,6 @@ static int amdgpu_device_ip_init(struct amdgpu_=
device *adev)
>> >         if (!adev->gmc.xgmi.pending_reset)
>> >                 amdgpu_amdkfd_device_init(adev);
>> >
>> > -       r =3D amdgpu_amdkfd_resume_iommu(adev);
>> > -       if (r)
>> > -               goto init_failed;
>> > -
>> >         amdgpu_fru_get_product_info(adev);
>> >
>> >  init_failed:
>> > --
>> > 2.25.1
>> >
