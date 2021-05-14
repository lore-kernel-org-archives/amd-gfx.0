Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B9DC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C76F61182
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C76F61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017496E19B;
	Fri, 14 May 2021 04:26:44 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3106E19B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:26:43 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id b25so22181823oic.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 21:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z+JT/XTXb6m69jsamaujgnAb4nQWyOgwFb0whNa456U=;
 b=POdGJ4afyeC5CPUjZ25Pp/PhW54NfrlxrL1fDRnn2JkZ84JR+LecuXNMWRoduTklIR
 eXj4zTSzvY9XTAUJUjrqqn9qwLBjabDY2QqLFCcqI2oN0v61SEqSTgiH7QB3d9LNmoTo
 yFXAHRtiXeJF9RrVKJMoWWuEfOR36BD8PQhePQc+57HKj26ACbqNI3enZ9ylQSX6o5/1
 2zXK79j11eMhGKcBnYZ7loVeuhU3ip9AmCNeItBzg7VX0i78ElpWOJNA3j5omwwdTzJr
 omphD0rypPjhdJkyilApZlxl+zNMY7XH28d7o/y3YHXqq2A8OdFI6W04A+PbxrWJXvyt
 FJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z+JT/XTXb6m69jsamaujgnAb4nQWyOgwFb0whNa456U=;
 b=FQ25sqdmroFpRdkfQ6MFG08sMVLwtJqKL62NzsITNclSxr/dRTmDjINGtfKWAn/7uS
 tvIthTlI7rWgfRVSYBZqr2cc7KtNt8qwo1lAZiGfRO775Q5bhU2vCUMzMwrn6lYbQ088
 g2tKuS8AtRqhCnip9f6uxagf7Fe1oxvSL+ov92SDyZE91DaPzsfMb+TcZ+56k3dGnygw
 e/8P/7INtvyahLGjN/m/PIy1XYqCSFa0CCL+3tOUJhbN3Vsfx7zZMFEDYkhPqSNtt8Io
 AgNiprIIpboN7XFYS4serjolHyGAhiXCADDp+yuDs++6rsYaBMpGfd7aUeNyJ20NgixK
 QSyQ==
X-Gm-Message-State: AOAM5331cNrTCXve0RKlc4Ggz/mabFwF7yoeX1f5R30X5bFxG4s3UzGf
 OQUtPKlx8bT/w3Hv0IVHhuLMtdH4ymZJTJhZIpg=
X-Google-Smtp-Source: ABdhPJwT24VkWt0/Q2eMB5+yM+/lpXmjCxtCOj6KEK/s1NCTglnLju5slU27IKaefEsw38gpkelYu92sC1KH5kc64Ro=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr32786604oii.123.1620966402802; 
 Thu, 13 May 2021 21:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210513064051.12930-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51566C4310A9E3644BCAA9E0F8519@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB515669BD1D8D0402206D641BF8509@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CADnq5_M6C7dNsWxNzJXeRWbMF10sT5BVcq-3S5bGvavM96pFcA@mail.gmail.com>
 <CH0PR12MB515632660C14957DC10353A4F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB515632660C14957DC10353A4F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 00:26:31 -0400
Message-ID: <CADnq5_MVZmgn=J87bv4zSfHsMK5HSE-20cEPwpjc7PUSR_s9yQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 13, 2021 at 11:47 PM Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
>
> unique_id is fetched from FUSE_DATA on hypervisor.
>
> Under my experiment, both multi-VF & single VF can still read FUSE_DATA to get it.
> But per David's info, guest shouldn't be able to read it (though it can currently)...
>
> So I guess in design, the unique_id should be only fetched from hypervisor in SRIOV case, and guest should always get it from host.

thanks.  so does the patch also need something like this?

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 32dadeee9514..9243e5de5bb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -686,7 +686,8 @@ static int smu_late_init(void *handle)
                return ret;
        }

-       smu_get_unique_id(smu);
+       if (!amdgpu_sriov_vf(adev))
+               smu_get_unique_id(smu);

        smu_get_fan_parameters(smu);

otherwise we fetch it twice.

Alex

>
> Hi David,
>
> Please feel free to correct my statement / provide more background.
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, May 14, 2021 11:33 AM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
>
> unique_id is normally fetched from the SMU on bare metal.  I guess in the SR-IOV case, this would come from the hypervisor since the SMU is not normally handled in the VF.  That makes sense for multi-VF, but what about single VF?  Are you sure the ordering is correct such that the SMU value won't overwrite this?  Maybe that's ok because they would be the same in that case?
>
> Alex
>
>
> On Thu, May 13, 2021 at 10:39 PM Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > pinging
> >
> > -----Original Message-----
> > From: Gu, JiaWei (Will)
> > Sent: Thursday, May 13, 2021 7:01 PM
> > To: Jiawei Gu <Jiawei.Gu@amd.com>; amd-gfx@lists.freedesktop.org;
> > Nieto, David M <David.Nieto@amd.com>
> > Cc: Deng, Emily <Emily.Deng@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from
> > PF2VF msg
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Add David.
> >
> > -----Original Message-----
> > From: Jiawei Gu <Jiawei.Gu@amd.com>
> > Sent: Thursday, May 13, 2021 2:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will)
> > <JiaWei.Gu@amd.com>
> > Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF
> > msg
> >
> > Initialize unique_id from PF2VF under virtualization.
> >
> > Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index a57842689d42..96e269cbe326 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
> >                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
> >                 adev->virt.reg_access =
> >                         ((struct amd_sriov_msg_pf2vf_info
> > *)pf2vf_info)->reg_access_flags.all;
> > +               adev->unique_id =
> > +                       ((struct amd_sriov_msg_pf2vf_info
> > + *)pf2vf_info)->uuid;
> >
> >                 break;
> >         default:
> > --
> > 2.17.1
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJi
> > aWei.Gu%40amd.com%7C8c5b87447e364531b89008d916890f54%7C3dd8961fe4884e6
> > 08e11a82d994e183d%7C0%7C0%7C637565600188355261%7CUnknown%7CTWFpbGZsb3d
> > 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> > 1000&amp;sdata=Go8nw1HMA5I4wLJv2jk9hpSm2%2F0BR9nRzwwdAlJfttc%3D&amp;re
> > served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
