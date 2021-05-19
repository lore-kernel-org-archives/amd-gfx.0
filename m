Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC280C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 13:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD9260FE7
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 13:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD9260FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC3E6EDA4;
	Wed, 19 May 2021 13:23:05 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A494B6EDA4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 13:23:03 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id i13so15325742edb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=RcUyFc4t5iAjZeX7fnA0bNPrdklqpUU/cbe7/EtFgak=;
 b=LZulXHdtzlu7PCWMX9q830kurIqN6y7yruyNKnkNa/PyskI3hPi/owWvPYkaIUzeQ3
 lTeCu+huz+2uaodRFL5BNTQ5rQNnFjDdyT1ahNmfk4T3sVl5W/rZA4T2/DewGJ4IDvL9
 nbm8yYYzkDxs6vGEseamW/ZPCCAv/PvK9IwTOCazAY4DCkzkWejDn2i5GI7kvPnqAG/E
 VeVn/RlvojThJI+Kb+rQ6JjVGQ1TkOOacZrNOuNxdRi1afty9yzAxM8hp21kxi/d0d4l
 27j1ohi1fsEgogkqbqdaGr+Q1ZFaLySVsEBeqDbvLfylde+aetnAz2hthNzVWybsu7NO
 aphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=RcUyFc4t5iAjZeX7fnA0bNPrdklqpUU/cbe7/EtFgak=;
 b=Z/UV3Me/RtZacZYELaPw2hYadJqq2hE8+8CgrhfguueeY2yorPlTwRn7IbM3A9QnWW
 ehgsbRw7SVo7l/FXR8lIwodNefHc/rl+EmnlpI2fAQTkSDTJ3gU+jJVsDcGHhyC6utVi
 TeWWkmj3wp5+Tk6m0PLckOKDlShCdzM9sL3yGBvR9Lo+73KdZzSWncLiEMHRl/tOuo2I
 itTueMeUkBzk31ED5Uu6NghJ192OJdSC7wN9Bfj4T86zPeW37PR7UPfH7Ux1iFDQoZQQ
 9J3ZbOz5A5V1TAE4Ne+y752feTWwuRF8WeQUHEH3CHLLYkN+jywBePn1cPC7fRkEAr5z
 STjQ==
X-Gm-Message-State: AOAM531mOB0SE3JSwcVg66WQolph9S73/QzspqhkKUxCKmyZHgbNKgvx
 nPZ6fcdj+fGBfsLngQRakSI=
X-Google-Smtp-Source: ABdhPJxyOpuxDmUThxNgA2WWe1SpD1X7NZFS+wZCXHwScCT+YtWp0MkSJZkE2pY3SHfz5QdfuhJ+1A==
X-Received: by 2002:a05:6402:2793:: with SMTP id
 b19mr8257697ede.191.1621430582252; 
 Wed, 19 May 2021 06:23:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a?
 ([2a02:908:1252:fb60:8e28:1d3:41f3:e15a])
 by smtp.gmail.com with ESMTPSA id gt12sm12431370ejb.60.2021.05.19.06.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 06:23:01 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "Nieto, David M"
 <David.Nieto@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "maraeo@gmail.com" <maraeo@gmail.com>
References: <20210517120804.27052-1-Jiawei.Gu@amd.com>
 <CH0PR12MB5156D238E265426E504B791BF82D9@CH0PR12MB5156.namprd12.prod.outlook.com>
 <51161d6d-a6be-90f0-262d-5215402e25dd@amd.com>
 <CH0PR12MB515644C1FF56458EFCA4B0FBF82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840E231B64B432D709A3B59F42C9@BYAPR12MB2840.namprd12.prod.outlook.com>
 <CH0PR12MB515657CAB5F1DF60A7E689C5F82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB284005A19E99B1D7AC43ABE5F42C9@BYAPR12MB2840.namprd12.prod.outlook.com>
 <CH0PR12MB515686179ED43BB5CF71AC4AF82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
 <MN2PR12MB4488EAC16AE52CD7160D53F5F72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a4e6d14a-56d6-a138-ef2c-7759822f577a@gmail.com>
Date: Wed, 19 May 2021 15:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4488EAC16AE52CD7160D53F5F72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: multipart/mixed; boundary="===============1522302160=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1522302160==
Content-Type: multipart/alternative;
 boundary="------------0350151105ADDECF62B10594"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0350151105ADDECF62B10594
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Good point.

If you want to double check the alignment you can use something like 
"pahole drivers/gpu/drm/amd/amdgpu/amdgpu.ko -C drm_amdgpu_info_vbios" 
after building the kernel module.

Regards,
Christian.

Am 19.05.21 um 15:09 schrieb Deucher, Alexander:
>
> [Public]
>
>
> The structure is not 64 bit aligned.  I think you want something like:
>
> > +struct drm_amdgpu_info_vbios {
> > +     __u8 name[64];
> > +     __u8 vbios_pn[64];
> > +     __u32 version;
> > +     __u32 pad;
> > +     __u8 vbios_ver_str[32];
> > +     __u8 date[32];
> > +};
> ------------------------------------------------------------------------
> *From:* Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> *Sent:* Tuesday, May 18, 2021 1:58 AM
> *To:* Nieto, David M <David.Nieto@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>; maraeo@gmail.com <maraeo@gmail.com>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* Deng, Emily <Emily.Deng@amd.com>
> *Subject:* RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> [Public]
>
>
> Hi all,
>
> Then the struct looks like:
>
> > +struct drm_amdgpu_info_vbios {
> > +     __u8 name[64];
> > +     __u8 vbios_pn[64];
> > +     __u32 version;
> > +     __u8 vbios_ver_str[32];
> > +     __u8 date[32];
> > +};
>
> Sample output:
>
> vbios name : NAVI12 A0 XT D30501 8GB EVAL 1150e/334m HYN/SAM
> vbios pn : 113-D3050100-104
> vbios version : 285409288
> vbios ver_str : 017.003.000.008.016956
> vbios date : 2021/05/03 23:32
>
> Please help double confirm that we’re all fine with it and there’s no 
> need to add & remove anything.
>
> Best regards,
>
> Jiawei
>
> *From:* Nieto, David M <David.Nieto@amd.com>
> *Sent:* Tuesday, May 18, 2021 12:40 PM
> *To:* Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org; 
> maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* Deng, Emily <Emily.Deng@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> [Public]
>
> Yes, let's remove that too,
>
> Thanks,
>
> David
>
> ------------------------------------------------------------------------
>
> *From:*Gu, JiaWei (Will) <JiaWei.Gu@amd.com <mailto:JiaWei.Gu@amd.com>>
> *Sent:* Monday, May 17, 2021 8:07 PM
> *To:* Nieto, David M <David.Nieto@amd.com 
> <mailto:David.Nieto@amd.com>>; Koenig, Christian 
> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>; maraeo@gmail.com 
> <mailto:maraeo@gmail.com> <maraeo@gmail.com 
> <mailto:maraeo@gmail.com>>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> *Cc:* Deng, Emily <Emily.Deng@amd.com <mailto:Emily.Deng@amd.com>>
> *Subject:* RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> [AMD Official Use Only - Internal Distribution Only]
>
> OK let’s remove serial.
>
> dbdf comes from this:
>
> vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
>
> I think we can remove dbdf as well.
>
> Best regards,
>
> Jiawei
>
> *From:* Nieto, David M <David.Nieto@amd.com <mailto:David.Nieto@amd.com>>
> *Sent:* Tuesday, May 18, 2021 10:45 AM
> *To:* Gu, JiaWei (Will) <JiaWei.Gu@amd.com 
> <mailto:JiaWei.Gu@amd.com>>; Koenig, Christian 
> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>; 
> maraeo@gmail.com <mailto:maraeo@gmail.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> *Cc:* Deng, Emily <Emily.Deng@amd.com <mailto:Emily.Deng@amd.com>>
> *Subject:* Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> [AMD Official Use Only - Internal Distribution Only]
>
> The serial number is ASIC information, not VBIOS information, and it 
> is still available as a sysfs node... I don't think we should put it 
> there.
>
> Not sure what dbdf stands for.
>
> ------------------------------------------------------------------------
>
> *From:*Gu, JiaWei (Will) <JiaWei.Gu@amd.com <mailto:JiaWei.Gu@amd.com>>
> *Sent:* Monday, May 17, 2021 7:11 PM
> *To:* Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>; Nieto, David M 
> <David.Nieto@amd.com <mailto:David.Nieto@amd.com>>; maraeo@gmail.com 
> <mailto:maraeo@gmail.com> <maraeo@gmail.com 
> <mailto:maraeo@gmail.com>>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> *Cc:* Deng, Emily <Emily.Deng@amd.com <mailto:Emily.Deng@amd.com>>
> *Subject:* RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> [AMD Official Use Only - Internal Distribution Only]
>
> So I guess the dbdf is also needed to be removed?
> And how about serial?
>
> > +struct drm_amdgpu_info_vbios {
> > +     __u8 name[64];
> > +     __u32 dbdf; // do we need this?
> > +     __u8 vbios_pn[64];
> > +     __u32 version;
> > +     __u8 vbios_ver_str[32];
> > +     __u8 date[32];
> > +     __u64 serial; // do we need this?
> > +};
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>
> Sent: Monday, May 17, 2021 8:26 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com <mailto:JiaWei.Gu@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>; 
> Nieto, David M <David.Nieto@amd.com <mailto:David.Nieto@amd.com>>; 
> maraeo@gmail.com <mailto:maraeo@gmail.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> Cc: Deng, Emily <Emily.Deng@amd.com <mailto:Emily.Deng@amd.com>>
> Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> I'm not very familiar with the technical background why we have the 
> fields here once more.
>
> But of hand we should at least remove everything which is also 
> available from the PCI information.
>
> E.g. dev_id, rev_id, sub_dev_id, sub_ved_id.
>
> Regards,
> Christian.
>
> Am 17.05.21 um 14:17 schrieb Gu, JiaWei (Will):
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Hi all,
> >
> > Thanks Christian's suggestion.
> > I reverted the previous patches and squash them into this single one.
> >
> > As this patch shows, the current uapi change looks like this:
> >
> > +struct drm_amdgpu_info_vbios {
> > +     __u8 name[64];
> > +     __u32 dbdf;
> > +     __u8 vbios_pn[64];
> > +     __u32 version;
> > +     __u8 vbios_ver_str[32];
> > +     __u8 date[32];
> > +     __u64 serial;
> > +     __u32 dev_id;
> > +     __u32 rev_id;
> > +     __u32 sub_dev_id;
> > +     __u32 sub_ved_id;
> > +};
> >
> > As we know there's some redundant info in this struct.
> > Please feel free to give any comments or suggestion about what it 
> should & shouldn't include.
> >
> > Best regards,
> > Jiawei
> >
> > -----Original Message-----
> > From: Jiawei Gu <Jiawei.Gu@amd.com <mailto:Jiawei.Gu@amd.com>>
> > Sent: Monday, May 17, 2021 8:08 PM
> > To: amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>; Koenig, Christian
> > <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; Nieto, 
> David M <David.Nieto@amd.com <mailto:David.Nieto@amd.com>>;
> > maraeo@gmail.com <mailto:maraeo@gmail.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> > Cc: Deng, Emily <Emily.Deng@amd.com <mailto:Emily.Deng@amd.com>>; 
> Gu, JiaWei (Will)
> > <JiaWei.Gu@amd.com <mailto:JiaWei.Gu@amd.com>>
> > Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
> >
> > Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
> >
> > Provides a way for the user application to get the VBIOS information 
> without having to parse the binary.
> > It is useful for the user to be able to display in a simple way the 
> VBIOS version in their system if they happen to encounter an issue.
> >
> > V2:
> > Use numeric serial.
> > Parse and expose vbios version string.
> >
> > Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com <mailto:Jiawei.Gu@amd.com>>
> > Acked-by: Christian König <christian.koenig@amd.com 
> <mailto:christian.koenig@amd.com>>
> > ---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  21 +++
> > drivers/gpu/drm/amd/amdgpu/atom.c          | 174 +++++++++++++++++++++
> > drivers/gpu/drm/amd/amdgpu/atom.h |  12 ++
> > drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
> > include/uapi/drm/amdgpu_drm.h |  16 ++
> >   5 files changed, 228 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 8d12e474745a..30e4fed3de22 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -861,6 +861,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
> void *data, struct drm_file *filp)
> >                                            min((size_t)size, 
> (size_t)(bios_size - bios_offset)))
> > ? -EFAULT : 0;
> >                }
> > +             case AMDGPU_INFO_VBIOS_INFO: {
> > +                     struct drm_amdgpu_info_vbios vbios_info = {};
> > +                     struct atom_context *atom_context;
> > +
> > +                     atom_context = adev->mode_info.atom_context;
> > + memcpy(vbios_info.name, atom_context->name, 
> sizeof(atom_context->name));
> > +                     vbios_info.dbdf = 
> PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
> > + memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, 
> sizeof(atom_context->vbios_pn));
> > + vbios_info.version = atom_context->version;
> > + memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
> > + sizeof(atom_context->vbios_ver_str));
> > + memcpy(vbios_info.date, atom_context->date, 
> sizeof(atom_context->date));
> > +                     vbios_info.serial = adev->unique_id;
> > +                     vbios_info.dev_id = adev->pdev->device;
> > +                     vbios_info.rev_id = adev->pdev->revision;
> > + vbios_info.sub_dev_id = atom_context->sub_dev_id;
> > + vbios_info.sub_ved_id = atom_context->sub_ved_id;
> > +
> > +                     return copy_to_user(out, &vbios_info,
> > + min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
> > +             }
> >                default:
> > DRM_DEBUG_KMS("Invalid request %d\n",
> > info->vbios_info.type);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
> > b/drivers/gpu/drm/amd/amdgpu/atom.c
> > index 3dcb8b32f48b..542b2c2414e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> > @@ -31,6 +31,7 @@
> >
> >   #define ATOM_DEBUG
> >
> > +#include "atomfirmware.h"
> >   #include "atom.h"
> >   #include "atom-names.h"
> >   #include "atom-bits.h"
> > @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct 
> atom_context *ctx, int base)
> >        }
> >   }
> >
> > +static void atom_get_vbios_name(struct atom_context *ctx) {
> > +     unsigned char *p_rom;
> > +     unsigned char str_num;
> > +     unsigned short off_to_vbios_str;
> > +     unsigned char *c_ptr;
> > +     int name_size;
> > +     int i;
> > +
> > +     const char *na = "--N/A--";
> > +     char *back;
> > +
> > +     p_rom = ctx->bios;
> > +
> > +     str_num = *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
> > +     if (str_num != 0) {
> > +             off_to_vbios_str =
> > +                     *(unsigned short *)(p_rom + 
> OFFSET_TO_GET_ATOMBIOS_STRING_START);
> > +
> > +             c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
> > +     } else {
> > +             /* do not know where to find name */
> > +             memcpy(ctx->name, na, 7);
> > +             ctx->name[7] = 0;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * skip the atombios strings, usually 4
> > +      * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
> > +      */
> > +     for (i = 0; i < str_num; i++) {
> > +             while (*c_ptr != 0)
> > +                     c_ptr++;
> > +             c_ptr++;
> > +     }
> > +
> > +     /* skip the following 2 chars: 0x0D 0x0A */
> > +     c_ptr += 2;
> > +
> > +     name_size = strnlen(c_ptr, STRLEN_LONG - 1);
> > +     memcpy(ctx->name, c_ptr, name_size);
> > +     back = ctx->name + name_size;
> > +     while ((*--back) == ' ')
> > +             ;
> > +     *(back + 1) = '\0';
> > +}
> > +
> > +static void atom_get_vbios_date(struct atom_context *ctx) {
> > +     unsigned char *p_rom;
> > +     unsigned char *date_in_rom;
> > +
> > +     p_rom = ctx->bios;
> > +
> > +     date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
> > +
> > +     ctx->date[0] = '2';
> > +     ctx->date[1] = '0';
> > +     ctx->date[2] = date_in_rom[6];
> > +     ctx->date[3] = date_in_rom[7];
> > +     ctx->date[4] = '/';
> > +     ctx->date[5] = date_in_rom[0];
> > +     ctx->date[6] = date_in_rom[1];
> > +     ctx->date[7] = '/';
> > +     ctx->date[8] = date_in_rom[3];
> > +     ctx->date[9] = date_in_rom[4];
> > +     ctx->date[10] = ' ';
> > +     ctx->date[11] = date_in_rom[9];
> > +     ctx->date[12] = date_in_rom[10];
> > +     ctx->date[13] = date_in_rom[11];
> > +     ctx->date[14] = date_in_rom[12];
> > +     ctx->date[15] = date_in_rom[13];
> > +     ctx->date[16] = '\0';
> > +}
> > +
> > +static unsigned char *atom_find_str_in_rom(struct atom_context 
> *ctx, char *str, int start,
> > +                                        int end, int maxlen)
> > +{
> > +     unsigned long str_off;
> > +     unsigned char *p_rom;
> > +     unsigned short str_len;
> > +
> > +     str_off = 0;
> > +     str_len = strnlen(str, maxlen);
> > +     p_rom = ctx->bios;
> > +
> > +     for (; start <= end; ++start) {
> > +             for (str_off = 0; str_off < str_len; ++str_off) {
> > +                     if (str[str_off] != *(p_rom + start + str_off))
> > +                             break;
> > +             }
> > +
> > +             if (str_off == str_len || str[str_off] == 0)
> > +                     return p_rom + start;
> > +     }
> > +     return NULL;
> > +}
> > +
> > +static void atom_get_vbios_pn(struct atom_context *ctx) {
> > +     unsigned char *p_rom;
> > +     unsigned short off_to_vbios_str;
> > +     unsigned char *vbios_str;
> > +     int count;
> > +
> > +     off_to_vbios_str = 0;
> > +     p_rom = ctx->bios;
> > +
> > +     if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) != 0) {
> > +             off_to_vbios_str =
> > +                     *(unsigned short *)(p_rom + 
> OFFSET_TO_GET_ATOMBIOS_STRING_START);
> > +
> > +             vbios_str = (unsigned char *)(p_rom + off_to_vbios_str);
> > +     } else {
> > +             vbios_str = p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
> > +     }
> > +
> > +     if (*vbios_str == 0) {
> > +             vbios_str = atom_find_str_in_rom(ctx, 
> BIOS_ATOM_PREFIX, 3, 1024, 64);
> > +             if (vbios_str == NULL)
> > +                     vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
> > +     }
> > +     if (vbios_str != NULL && *vbios_str == 0)
> > +             vbios_str++;
> > +
> > +     if (vbios_str != NULL) {
> > +             count = 0;
> > +             while ((count < BIOS_STRING_LENGTH) && 
> vbios_str[count] >= ' ' &&
> > +                    vbios_str[count] <= 'z') {
> > + ctx->vbios_pn[count] = vbios_str[count];
> > +                     count++;
> > +             }
> > +
> > +             ctx->vbios_pn[count] = 0;
> > +     }
> > +}
> > +
> > +static void atom_get_vbios_version(struct atom_context *ctx) {
> > +     unsigned char *vbios_ver;
> > +
> > +     /* find anchor ATOMBIOSBK-AMD */
> > +     vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 
> 1024, 64);
> > +     if (vbios_ver != NULL) {
> > +             /* skip ATOMBIOSBK-AMD VER */
> > +             vbios_ver += 18;
> > + memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> > +     } else {
> > +             ctx->vbios_ver_str[0] = '\0';
> > +     }
> > +}
> > +
> >   struct atom_context *amdgpu_atom_parse(struct card_info *card, 
> void *bios)  {
> >        int base;
> >        struct atom_context *ctx =
> >            kzalloc(sizeof(struct atom_context), GFP_KERNEL);
> >        char *str;
> > +     struct _ATOM_ROM_HEADER *atom_rom_header;
> > +     struct _ATOM_MASTER_DATA_TABLE *master_table;
> > +     struct _ATOM_FIRMWARE_INFO *atom_fw_info;
> >        u16 idx;
> >
> >        if (!ctx)
> > @@ -1353,6 +1510,23 @@ struct atom_context *amdgpu_atom_parse(struct 
> card_info *card, void *bios)
> > strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
> >        }
> >
> > +     atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
> > +     ctx->sub_dev_id = atom_rom_header->usSubsystemVendorID;
> > +     ctx->sub_ved_id = atom_rom_header->usSubsystemID;
> > +     if (atom_rom_header->usMasterDataTableOffset != 0) {
> > +             master_table = (struct _ATOM_MASTER_DATA_TABLE *)
> > + CSTR(atom_rom_header->usMasterDataTableOffset);
> > +             if (master_table->ListOfDataTables.FirmwareInfo != 0) {
> > +                     atom_fw_info = (struct _ATOM_FIRMWARE_INFO *)
> > + CSTR(master_table->ListOfDataTables.FirmwareInfo);
> > +                     ctx->version = atom_fw_info->ulFirmwareRevision;
> > +             }
> > +     }
> > +
> > +     atom_get_vbios_name(ctx);
> > +     atom_get_vbios_pn(ctx);
> > +     atom_get_vbios_date(ctx);
> > +     atom_get_vbios_version(ctx);
> >
> >        return ctx;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h
> > b/drivers/gpu/drm/amd/amdgpu/atom.h
> > index d279759cab47..6463ce6e756d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> > @@ -112,6 +112,10 @@ struct drm_device;
> >   #define ATOM_IO_SYSIO               2
> >   #define ATOM_IO_IIO         0x80
> >
> > +#define STRLEN_NORMAL 32
> > +#define STRLEN_LONG          64
> > +#define STRLEN_VERYLONG 254
> > +
> >   struct card_info {
> >        struct drm_device *dev;
> >        void (* reg_write)(struct card_info *, uint32_t, uint32_t);   
> /* filled by driver */
> > @@ -140,6 +144,14 @@ struct atom_context {
> >        uint32_t *scratch;
> >        int scratch_size_bytes;
> >        char vbios_version[20];
> > +
> > +     uint8_t name[STRLEN_LONG];
> > +     uint8_t vbios_pn[STRLEN_LONG];
> > +     uint32_t version;
> > +     uint8_t vbios_ver_str[STRLEN_NORMAL];
> > +     uint8_t date[STRLEN_NORMAL];
> > +     uint32_t sub_dev_id;
> > +     uint32_t sub_ved_id;
> >   };
> >
> >   extern int amdgpu_atom_debug;
> > diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
> > b/drivers/gpu/drm/amd/include/atomfirmware.h
> > index 275468e4be60..28deecc2f990 100644
> > --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> > +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> > @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
> >     DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
> >   };
> >
> > +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> > +#define BIOS_VERSION_PREFIX "ATOMBIOSBK-AMD"
> > +#define BIOS_STRING_LENGTH 43
> >
> >   /*
> >   enum atom_string_def{
> > @@ -215,6 +218,8 @@ enum atombios_image_offset{
> > MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the 
> terminator 0x0!*/
> > OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
> > OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
> > + OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
> > + OFFSET_TO_VBIOS_DATE                       = 0x50,
> >   };
> >
> >
> > /*********************************************************************
> > ******* diff --git a/include/uapi/drm/amdgpu_drm.h
> > b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..e0f98ca9a755
> > 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
> >        #define AMDGPU_INFO_VBIOS_SIZE          0x1
> >        /* Subquery id: Query vbios image */
> >        #define AMDGPU_INFO_VBIOS_IMAGE         0x2
> > +     /* Subquery id: Query vbios info */
> > +     #define AMDGPU_INFO_VBIOS_INFO          0x3
> >   /* Query UVD handles */
> >   #define AMDGPU_INFO_NUM_HANDLES 0x1C
> >   /* Query sensor related information */ @@ -949,6 +951,20 @@ struct
> > drm_amdgpu_info_firmware {
> >        __u32 feature;
> >   };
> >
> > +struct drm_amdgpu_info_vbios {
> > +     __u8 name[64];
> > +     __u32 dbdf;
> > +     __u8 vbios_pn[64];
> > +     __u32 version;
> > +     __u8 vbios_ver_str[32];
> > +     __u8 date[32];
> > +     __u64 serial;
> > +     __u32 dev_id;
> > +     __u32 rev_id;
> > +     __u32 sub_dev_id;
> > +     __u32 sub_ved_id;
> > +};
> > +
> >   #define AMDGPU_VRAM_TYPE_UNKNOWN 0
> >   #define AMDGPU_VRAM_TYPE_GDDR1 1
> >   #define AMDGPU_VRAM_TYPE_DDR2  2
> > --
> > 2.17.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------0350151105ADDECF62B10594
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Good point.<br>
    <br>
    If you want to double check the alignment you can use something like
    "pahole drivers/gpu/drm/amd/amdgpu/amdgpu.ko -C
    drm_amdgpu_info_vbios" after building the kernel module.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 19.05.21 um 15:09 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB4488EAC16AE52CD7160D53F5F72B9@MN2PR12MB4488.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;"
        align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          The structure is not 64 bit aligned.  I think you want
          something like:</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          &gt; +struct drm_amdgpu_info_vbios {<br>
          &gt; +     __u8 name[64];<br>
          &gt; +     __u8 vbios_pn[64];<br>
          &gt; +     __u32 version;</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          &gt; +     __u32 pad;<br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          &gt; +     __u8 vbios_ver_str[32];<br>
          &gt; +     __u8 date[32];<br>
          &gt; +};<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b> Gu,
            JiaWei (Will) <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, May 18, 2021 1:58 AM<br>
            <b>To:</b> Nieto, David M <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a>;
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:maraeo@gmail.com">maraeo@gmail.com</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Cc:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
            <b>Subject:</b> RE: [PATCH] drm/amdgpu: Add vbios info ioctl
            interface</font>
          <div> </div>
        </div>
        <style>@font-face
	{font-family:"Cambria Math"}@font-face
	{font-family:DengXian}@font-face
	{font-family:Calibri}@font-face
	{}@font-face
	{font-family:"Segoe UI"}p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}p.x_xmsonormal, li.x_xmsonormal, div.x_xmsonormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}p.x_xmsipheader4d111418, li.x_xmsipheader4d111418, div.x_xmsipheader4d111418
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}span.x_EmailStyle25
	{font-family:"Calibri",sans-serif;
	color:windowtext}.x_MsoChpDefault
	{font-size:10.0pt}div.x_WordSection1
	{}</style>
        <div link="#0563C1" vlink="purple" style="word-wrap:break-word"
          lang="EN-US">
          <p style="font-family:Arial; font-size:10pt; color:#008000;
            margin:15pt" align="Left">
            [Public]<br>
          </p>
          <br>
          <div>
            <div class="x_WordSection1">
              <p class="x_MsoNormal">Hi all,</p>
              <p class="x_MsoNormal"> </p>
              <p class="x_MsoNormal">Then the struct looks like:</p>
              <p class="x_MsoNormal"> </p>
              <p class="x_MsoNormal">&gt; +struct drm_amdgpu_info_vbios
                {<br>
                &gt; +     __u8 name[64];<br>
                &gt; +     __u8 vbios_pn[64];<br>
                &gt; +     __u32 version;<br>
                &gt; +     __u8 vbios_ver_str[32];<br>
                &gt; +     __u8 date[32];<br>
                &gt; +};</p>
              <p class="x_MsoNormal"> </p>
              <p class="x_MsoNormal">Sample output:</p>
              <p class="x_MsoNormal"> </p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:&quot;Segoe UI&quot;,sans-serif">vbios
                  name : NAVI12 A0 XT D30501 8GB EVAL 1150e/334m HYN/SAM<br>
                  vbios pn : 113-D3050100-104<br>
                  vbios version : 285409288<br>
                  vbios ver_str : 017.003.000.008.016956<br>
                  vbios date : 2021/05/03 23:32<br>
                  <br>
                </span></p>
              <p class="x_MsoNormal">Please help double confirm that
                we’re all fine with it and there’s no need to add &amp;
                remove anything.</p>
              <p class="x_MsoNormal"> </p>
              <p class="x_MsoNormal">Best regards,</p>
              <p class="x_MsoNormal">Jiawei</p>
              <p class="x_MsoNormal"> </p>
              <div>
                <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                  padding:3.0pt 0in 0in 0in">
                  <p class="x_MsoNormal"><b>From:</b> Nieto, David M
                    <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a> <br>
                    <b>Sent:</b> Tuesday, May 18, 2021 12:40 PM<br>
                    <b>To:</b> Gu, JiaWei (Will)
                    <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a>; Koenig, Christian
                    <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:maraeo@gmail.com">maraeo@gmail.com</a>;
                    Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                    <b>Cc:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add vbios
                    info ioctl interface</p>
                </div>
              </div>
              <p class="x_MsoNormal"> </p>
              <p style="margin:15.0pt"><span style="font-size:10.0pt;
                  font-family:&quot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
              <p class="x_MsoNormal"> </p>
              <div>
                <div>
                  <p class="x_MsoNormal" style="background:white"><span
                      style="font-size:12.0pt; color:black">Yes, let's
                      remove that too,</span></p>
                </div>
                <div>
                  <p class="x_MsoNormal" style="background:white"><span
                      style="font-size:12.0pt; color:black"> </span></p>
                </div>
                <div>
                  <p class="x_MsoNormal" style="background:white"><span
                      style="font-size:12.0pt; color:black">Thanks,</span></p>
                </div>
                <div>
                  <p class="x_MsoNormal" style="background:white"><span
                      style="font-size:12.0pt; color:black"> </span></p>
                </div>
                <div>
                  <p class="x_MsoNormal" style="background:white"><span
                      style="font-size:12.0pt; color:black">David</span></p>
                </div>
                <div class="x_MsoNormal" style="text-align:center"
                  align="center">
                  <hr width="98%" size="2" align="center">
                </div>
                <div id="x_divRplyFwdMsg">
                  <p class="x_MsoNormal"><b><span style="color:black">From:</span></b><span
                      style="color:black"> Gu, JiaWei (Will) &lt;<a
                        href="mailto:JiaWei.Gu@amd.com"
                        moz-do-not-send="true">JiaWei.Gu@amd.com</a>&gt;<br>
                      <b>Sent:</b> Monday, May 17, 2021 8:07 PM<br>
                      <b>To:</b> Nieto, David M &lt;<a
                        href="mailto:David.Nieto@amd.com"
                        moz-do-not-send="true">David.Nieto@amd.com</a>&gt;;
                      Koenig, Christian &lt;<a
                        href="mailto:Christian.Koenig@amd.com"
                        moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                      <a href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                      &lt;<a href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                      <a href="mailto:maraeo@gmail.com"
                        moz-do-not-send="true">maraeo@gmail.com</a> &lt;<a
                        href="mailto:maraeo@gmail.com"
                        moz-do-not-send="true">maraeo@gmail.com</a>&gt;;
                      Deucher, Alexander &lt;<a
                        href="mailto:Alexander.Deucher@amd.com"
                        moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                      <b>Cc:</b> Deng, Emily &lt;<a
                        href="mailto:Emily.Deng@amd.com"
                        moz-do-not-send="true">Emily.Deng@amd.com</a>&gt;<br>
                      <b>Subject:</b> RE: [PATCH] drm/amdgpu: Add vbios
                      info ioctl interface</span> </p>
                  <div>
                    <p class="x_MsoNormal"> </p>
                  </div>
                </div>
                <div>
                  <div>
                    <p class="x_xmsipheader4d111418" style="margin:0in"><span
                        style="font-family:&quot;Arial&quot;,sans-serif;
                        color:#0078D7">[AMD Official Use Only - Internal
                        Distribution Only]</span></p>
                    <p class="x_xmsonormal"> </p>
                    <p class="x_xmsonormal">OK let’s remove serial.</p>
                    <p class="x_xmsonormal"> </p>
                    <p class="x_xmsonormal">dbdf comes from this: </p>
                    <p class="x_xmsonormal">vbios_info.dbdf =
                      PCI_DEVID(adev-&gt;pdev-&gt;bus-&gt;number,
                      adev-&gt;pdev-&gt;devfn);</p>
                    <p class="x_xmsonormal"> </p>
                    <p class="x_xmsonormal">I think we can remove dbdf
                      as well.</p>
                    <p class="x_xmsonormal"> </p>
                    <p class="x_xmsonormal">Best regards,</p>
                    <p class="x_xmsonormal">Jiawei</p>
                    <p class="x_xmsonormal"> </p>
                    <div>
                      <div style="border:none; border-top:solid #E1E1E1
                        1.0pt; padding:3.0pt 0in 0in 0in">
                        <p class="x_xmsonormal"><b>From:</b> Nieto,
                          David M &lt;<a
                            href="mailto:David.Nieto@amd.com"
                            moz-do-not-send="true">David.Nieto@amd.com</a>&gt;
                          <br>
                          <b>Sent:</b> Tuesday, May 18, 2021 10:45 AM<br>
                          <b>To:</b> Gu, JiaWei (Will) &lt;<a
                            href="mailto:JiaWei.Gu@amd.com"
                            moz-do-not-send="true">JiaWei.Gu@amd.com</a>&gt;;
                          Koenig, Christian &lt;<a
                            href="mailto:Christian.Koenig@amd.com"
                            moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                          <a href="mailto:amd-gfx@lists.freedesktop.org"
                            moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                          <a href="mailto:maraeo@gmail.com"
                            moz-do-not-send="true">maraeo@gmail.com</a>;
                          Deucher, Alexander &lt;<a
                            href="mailto:Alexander.Deucher@amd.com"
                            moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                          <b>Cc:</b> Deng, Emily &lt;<a
                            href="mailto:Emily.Deng@amd.com"
                            moz-do-not-send="true">Emily.Deng@amd.com</a>&gt;<br>
                          <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add
                          vbios info ioctl interface</p>
                      </div>
                    </div>
                    <p class="x_xmsonormal"> </p>
                    <p style="margin:5.0pt"><span
                        style="font-family:&quot;Arial&quot;,sans-serif;
                        color:#0078D7">[AMD Official Use Only - Internal
                        Distribution Only]</span></p>
                    <p class="x_xmsonormal"> </p>
                    <div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            style="font-size:12.0pt; color:black">The
                            serial number is ASIC information, not VBIOS
                            information, and it is still available as a
                            sysfs node... I don't think we should put it
                            there.</span></p>
                      </div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            style="font-size:12.0pt; color:black"> </span></p>
                      </div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            style="font-size:12.0pt; color:black">Not
                            sure what dbdf stands for.</span></p>
                      </div>
                      <div class="x_MsoNormal" style="text-align:center"
                        align="center">
                        <hr width="98%" size="2" align="center">
                      </div>
                      <div id="x_x_divRplyFwdMsg">
                        <p class="x_xmsonormal"><b><span
                              style="color:black">From:</span></b><span
                            style="color:black"> Gu, JiaWei (Will) &lt;<a
                              href="mailto:JiaWei.Gu@amd.com"
                              moz-do-not-send="true">JiaWei.Gu@amd.com</a>&gt;<br>
                            <b>Sent:</b> Monday, May 17, 2021 7:11 PM<br>
                            <b>To:</b> Koenig, Christian &lt;<a
                              href="mailto:Christian.Koenig@amd.com"
                              moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                            <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                            &lt;<a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                            Nieto, David M &lt;<a
                              href="mailto:David.Nieto@amd.com"
                              moz-do-not-send="true">David.Nieto@amd.com</a>&gt;;
                            <a href="mailto:maraeo@gmail.com"
                              moz-do-not-send="true">maraeo@gmail.com</a>
                            &lt;<a href="mailto:maraeo@gmail.com"
                              moz-do-not-send="true">maraeo@gmail.com</a>&gt;;
                            Deucher, Alexander &lt;<a
                              href="mailto:Alexander.Deucher@amd.com"
                              moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                            <b>Cc:</b> Deng, Emily &lt;<a
                              href="mailto:Emily.Deng@amd.com"
                              moz-do-not-send="true">Emily.Deng@amd.com</a>&gt;<br>
                            <b>Subject:</b> RE: [PATCH] drm/amdgpu: Add
                            vbios info ioctl interface</span> </p>
                        <div>
                          <p class="x_xmsonormal"> </p>
                        </div>
                      </div>
                      <div>
                        <div>
                          <p class="x_xmsonormal">[AMD Official Use Only
                            - Internal Distribution Only]<br>
                            <br>
                            So I guess the dbdf is also needed to be
                            removed?<br>
                            And how about serial?<br>
                            <br>
                            &gt; +struct drm_amdgpu_info_vbios {<br>
                            &gt; +     __u8 name[64];<br>
                            &gt; +     __u32 dbdf; // do we need this?<br>
                            &gt; +     __u8 vbios_pn[64];<br>
                            &gt; +     __u32 version;<br>
                            &gt; +     __u8 vbios_ver_str[32];<br>
                            &gt; +     __u8 date[32];<br>
                            &gt; +     __u64 serial; // do we need this?<br>
                            &gt; +};<br>
                            <br>
                            Best regards,<br>
                            Jiawei<br>
                            <br>
                            -----Original Message-----<br>
                            From: Koenig, Christian &lt;<a
                              href="mailto:Christian.Koenig@amd.com"
                              moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                            <br>
                            Sent: Monday, May 17, 2021 8:26 PM<br>
                            To: Gu, JiaWei (Will) &lt;<a
                              href="mailto:JiaWei.Gu@amd.com"
                              moz-do-not-send="true">JiaWei.Gu@amd.com</a>&gt;;
                            <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                            Nieto, David M &lt;<a
                              href="mailto:David.Nieto@amd.com"
                              moz-do-not-send="true">David.Nieto@amd.com</a>&gt;;
                            <a href="mailto:maraeo@gmail.com"
                              moz-do-not-send="true">maraeo@gmail.com</a>;
                            Deucher, Alexander &lt;<a
                              href="mailto:Alexander.Deucher@amd.com"
                              moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                            Cc: Deng, Emily &lt;<a
                              href="mailto:Emily.Deng@amd.com"
                              moz-do-not-send="true">Emily.Deng@amd.com</a>&gt;<br>
                            Subject: Re: [PATCH] drm/amdgpu: Add vbios
                            info ioctl interface<br>
                            <br>
                            I'm not very familiar with the technical
                            background why we have the fields here once
                            more.<br>
                            <br>
                            But of hand we should at least remove
                            everything which is also available from the
                            PCI information.<br>
                            <br>
                            E.g. dev_id, rev_id, sub_dev_id, sub_ved_id.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            Am 17.05.21 um 14:17 schrieb Gu, JiaWei
                            (Will):<br>
                            &gt; [AMD Official Use Only - Internal
                            Distribution Only]<br>
                            &gt;<br>
                            &gt; Hi all,<br>
                            &gt;<br>
                            &gt; Thanks Christian's suggestion.<br>
                            &gt; I reverted the previous patches and
                            squash them into this single one.<br>
                            &gt;<br>
                            &gt; As this patch shows, the current uapi
                            change looks like this:<br>
                            &gt;<br>
                            &gt; +struct drm_amdgpu_info_vbios {<br>
                            &gt; +     __u8 name[64];<br>
                            &gt; +     __u32 dbdf;<br>
                            &gt; +     __u8 vbios_pn[64];<br>
                            &gt; +     __u32 version;<br>
                            &gt; +     __u8 vbios_ver_str[32];<br>
                            &gt; +     __u8 date[32];<br>
                            &gt; +     __u64 serial;<br>
                            &gt; +     __u32 dev_id;<br>
                            &gt; +     __u32 rev_id;<br>
                            &gt; +     __u32 sub_dev_id;<br>
                            &gt; +     __u32 sub_ved_id;<br>
                            &gt; +};<br>
                            &gt;<br>
                            &gt; As we know there's some redundant info
                            in this struct.<br>
                            &gt; Please feel free to give any comments
                            or suggestion about what it should &amp;
                            shouldn't include.<br>
                            &gt;<br>
                            &gt; Best regards,<br>
                            &gt; Jiawei<br>
                            &gt;<br>
                            &gt; -----Original Message-----<br>
                            &gt; From: Jiawei Gu &lt;<a
                              href="mailto:Jiawei.Gu@amd.com"
                              moz-do-not-send="true">Jiawei.Gu@amd.com</a>&gt;<br>
                            &gt; Sent: Monday, May 17, 2021 8:08 PM<br>
                            &gt; To: <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                            Koenig, Christian
                            <br>
                            &gt; &lt;<a
                              href="mailto:Christian.Koenig@amd.com"
                              moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                            Nieto, David M &lt;<a
                              href="mailto:David.Nieto@amd.com"
                              moz-do-not-send="true">David.Nieto@amd.com</a>&gt;;
                            <br>
                            &gt; <a href="mailto:maraeo@gmail.com"
                              moz-do-not-send="true">maraeo@gmail.com</a>;
                            Deucher, Alexander &lt;<a
                              href="mailto:Alexander.Deucher@amd.com"
                              moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                            &gt; Cc: Deng, Emily &lt;<a
                              href="mailto:Emily.Deng@amd.com"
                              moz-do-not-send="true">Emily.Deng@amd.com</a>&gt;;
                            Gu, JiaWei (Will)
                            <br>
                            &gt; &lt;<a href="mailto:JiaWei.Gu@amd.com"
                              moz-do-not-send="true">JiaWei.Gu@amd.com</a>&gt;<br>
                            &gt; Subject: [PATCH] drm/amdgpu: Add vbios
                            info ioctl interface<br>
                            &gt;<br>
                            &gt; Add AMDGPU_INFO_VBIOS_INFO subquery id
                            for detailed vbios info.<br>
                            &gt;<br>
                            &gt; Provides a way for the user application
                            to get the VBIOS information without having
                            to parse the binary.<br>
                            &gt; It is useful for the user to be able to
                            display in a simple way the VBIOS version in
                            their system if they happen to encounter an
                            issue.<br>
                            &gt;<br>
                            &gt; V2:<br>
                            &gt; Use numeric serial.<br>
                            &gt; Parse and expose vbios version string.<br>
                            &gt;<br>
                            &gt; Signed-off-by: Jiawei Gu &lt;<a
                              href="mailto:Jiawei.Gu@amd.com"
                              moz-do-not-send="true">Jiawei.Gu@amd.com</a>&gt;<br>
                            &gt; Acked-by: Christian König &lt;<a
                              href="mailto:christian.koenig@amd.com"
                              moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                            &gt; ---<br>
                            &gt;  
                            drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   
                            |  21 +++<br>
                            &gt;  
                            drivers/gpu/drm/amd/amdgpu/atom.c          |
                            174 +++++++++++++++++++++<br>
                            &gt;  
                            drivers/gpu/drm/amd/amdgpu/atom.h         
                            |  12 ++<br>
                            &gt;  
                            drivers/gpu/drm/amd/include/atomfirmware.h
                            |   5 +<br>
                            &gt;  
                            include/uapi/drm/amdgpu_drm.h             
                            |  16 ++<br>
                            &gt;   5 files changed, 228 insertions(+)<br>
                            &gt;<br>
                            &gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c <br>
                            &gt;
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
                            &gt; index 8d12e474745a..30e4fed3de22 100644<br>
                            &gt; ---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
                            &gt; +++
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
                            &gt; @@ -861,6 +861,27 @@ int
                            amdgpu_info_ioctl(struct drm_device *dev,
                            void *data, struct drm_file *filp)<br>
&gt;                                            min((size_t)size,
                            (size_t)(bios_size - bios_offset)))<br>
                            &gt;                                       
                            ? -EFAULT : 0;<br>
                            &gt;                }<br>
                            &gt; +             case
                            AMDGPU_INFO_VBIOS_INFO: {<br>
                            &gt; +                     struct
                            drm_amdgpu_info_vbios vbios_info = {};<br>
                            &gt; +                     struct
                            atom_context *atom_context;<br>
                            &gt; +<br>
                            &gt; +                     atom_context =
                            adev-&gt;mode_info.atom_context;<br>
                            &gt; +                    
                            memcpy(vbios_info.name,
                            atom_context-&gt;name,
                            sizeof(atom_context-&gt;name));<br>
                            &gt; +                     vbios_info.dbdf =
                            PCI_DEVID(adev-&gt;pdev-&gt;bus-&gt;number,
                            adev-&gt;pdev-&gt;devfn);<br>
                            &gt; +                    
                            memcpy(vbios_info.vbios_pn,
                            atom_context-&gt;vbios_pn,
                            sizeof(atom_context-&gt;vbios_pn));<br>
                            &gt; +                    
                            vbios_info.version =
                            atom_context-&gt;version;<br>
                            &gt; +                    
                            memcpy(vbios_info.vbios_ver_str,
                            atom_context-&gt;vbios_ver_str,<br>
                            &gt;
                            +                                            
                            sizeof(atom_context-&gt;vbios_ver_str));<br>
                            &gt; +                    
                            memcpy(vbios_info.date,
                            atom_context-&gt;date,
                            sizeof(atom_context-&gt;date));<br>
                            &gt; +                     vbios_info.serial
                            = adev-&gt;unique_id;<br>
                            &gt; +                     vbios_info.dev_id
                            = adev-&gt;pdev-&gt;device;<br>
                            &gt; +                     vbios_info.rev_id
                            = adev-&gt;pdev-&gt;revision;<br>
                            &gt; +                    
                            vbios_info.sub_dev_id =
                            atom_context-&gt;sub_dev_id;<br>
                            &gt; +                    
                            vbios_info.sub_ved_id =
                            atom_context-&gt;sub_ved_id;<br>
                            &gt; +<br>
                            &gt; +                     return
                            copy_to_user(out, &amp;vbios_info,<br>
                            &gt;
                            +                                            
                            min((size_t)size, sizeof(vbios_info))) ?
                            -EFAULT : 0;<br>
                            &gt; +             }<br>
                            &gt;                default:<br>
                            &gt;                       
                            DRM_DEBUG_KMS("Invalid request %d\n",<br>
                            &gt;                                       
                            info-&gt;vbios_info.type);<br>
                            &gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/atom.c <br>
                            &gt; b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
                            &gt; index 3dcb8b32f48b..542b2c2414e4 100644<br>
                            &gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
                            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
                            &gt; @@ -31,6 +31,7 @@<br>
                            &gt;   <br>
                            &gt;   #define ATOM_DEBUG<br>
                            &gt;   <br>
                            &gt; +#include "atomfirmware.h"<br>
                            &gt;   #include "atom.h"<br>
                            &gt;   #include "atom-names.h"<br>
                            &gt;   #include "atom-bits.h"<br>
                            &gt; @@ -1299,12 +1300,168 @@ static void
                            atom_index_iio(struct atom_context *ctx, int
                            base)<br>
                            &gt;        }<br>
                            &gt;   }<br>
                            &gt;   <br>
                            &gt; +static void atom_get_vbios_name(struct
                            atom_context *ctx) {<br>
                            &gt; +     unsigned char *p_rom;<br>
                            &gt; +     unsigned char str_num;<br>
                            &gt; +     unsigned short off_to_vbios_str;<br>
                            &gt; +     unsigned char *c_ptr;<br>
                            &gt; +     int name_size;<br>
                            &gt; +     int i;<br>
                            &gt; +<br>
                            &gt; +     const char *na = "--N/A--";<br>
                            &gt; +     char *back;<br>
                            &gt; +<br>
                            &gt; +     p_rom = ctx-&gt;bios;<br>
                            &gt; +<br>
                            &gt; +     str_num = *(p_rom +
                            OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);<br>
                            &gt; +     if (str_num != 0) {<br>
                            &gt; +             off_to_vbios_str =<br>
                            &gt; +                     *(unsigned short
                            *)(p_rom +
                            OFFSET_TO_GET_ATOMBIOS_STRING_START);<br>
                            &gt; +<br>
                            &gt; +             c_ptr = (unsigned char
                            *)(p_rom + off_to_vbios_str);<br>
                            &gt; +     } else {<br>
                            &gt; +             /* do not know where to
                            find name */<br>
                            &gt; +             memcpy(ctx-&gt;name, na,
                            7);<br>
                            &gt; +             ctx-&gt;name[7] = 0;<br>
                            &gt; +             return;<br>
                            &gt; +     }<br>
                            &gt; +<br>
                            &gt; +     /*<br>
                            &gt; +      * skip the atombios strings,
                            usually 4<br>
                            &gt; +      * 1st is P/N, 2nd is ASIC, 3rd
                            is PCI type, 4th is Memory type<br>
                            &gt; +      */<br>
                            &gt; +     for (i = 0; i &lt; str_num; i++)
                            {<br>
                            &gt; +             while (*c_ptr != 0)<br>
                            &gt; +                     c_ptr++;<br>
                            &gt; +             c_ptr++;<br>
                            &gt; +     }<br>
                            &gt; +<br>
                            &gt; +     /* skip the following 2 chars:
                            0x0D 0x0A */<br>
                            &gt; +     c_ptr += 2;<br>
                            &gt; +<br>
                            &gt; +     name_size = strnlen(c_ptr,
                            STRLEN_LONG - 1);<br>
                            &gt; +     memcpy(ctx-&gt;name, c_ptr,
                            name_size);<br>
                            &gt; +     back = ctx-&gt;name + name_size;<br>
                            &gt; +     while ((*--back) == ' ')<br>
                            &gt; +             ;<br>
                            &gt; +     *(back + 1) = '\0';<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt; +static void atom_get_vbios_date(struct
                            atom_context *ctx) {<br>
                            &gt; +     unsigned char *p_rom;<br>
                            &gt; +     unsigned char *date_in_rom;<br>
                            &gt; +<br>
                            &gt; +     p_rom = ctx-&gt;bios;<br>
                            &gt; +<br>
                            &gt; +     date_in_rom = p_rom +
                            OFFSET_TO_VBIOS_DATE;<br>
                            &gt; +<br>
                            &gt; +     ctx-&gt;date[0] = '2';<br>
                            &gt; +     ctx-&gt;date[1] = '0';<br>
                            &gt; +     ctx-&gt;date[2] = date_in_rom[6];<br>
                            &gt; +     ctx-&gt;date[3] = date_in_rom[7];<br>
                            &gt; +     ctx-&gt;date[4] = '/';<br>
                            &gt; +     ctx-&gt;date[5] = date_in_rom[0];<br>
                            &gt; +     ctx-&gt;date[6] = date_in_rom[1];<br>
                            &gt; +     ctx-&gt;date[7] = '/';<br>
                            &gt; +     ctx-&gt;date[8] = date_in_rom[3];<br>
                            &gt; +     ctx-&gt;date[9] = date_in_rom[4];<br>
                            &gt; +     ctx-&gt;date[10] = ' ';<br>
                            &gt; +     ctx-&gt;date[11] =
                            date_in_rom[9];<br>
                            &gt; +     ctx-&gt;date[12] =
                            date_in_rom[10];<br>
                            &gt; +     ctx-&gt;date[13] =
                            date_in_rom[11];<br>
                            &gt; +     ctx-&gt;date[14] =
                            date_in_rom[12];<br>
                            &gt; +     ctx-&gt;date[15] =
                            date_in_rom[13];<br>
                            &gt; +     ctx-&gt;date[16] = '\0';<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt; +static unsigned char
                            *atom_find_str_in_rom(struct atom_context
                            *ctx, char *str, int start,<br>
                            &gt;
                            +                                        int
                            end, int maxlen)<br>
                            &gt; +{<br>
                            &gt; +     unsigned long str_off;<br>
                            &gt; +     unsigned char *p_rom;<br>
                            &gt; +     unsigned short str_len;<br>
                            &gt; +<br>
                            &gt; +     str_off = 0;<br>
                            &gt; +     str_len = strnlen(str, maxlen);<br>
                            &gt; +     p_rom = ctx-&gt;bios;<br>
                            &gt; +<br>
                            &gt; +     for (; start &lt;= end; ++start)
                            {<br>
                            &gt; +             for (str_off = 0; str_off
                            &lt; str_len; ++str_off) {<br>
                            &gt; +                     if (str[str_off]
                            != *(p_rom + start + str_off))<br>
                            &gt; +                             break;<br>
                            &gt; +             }<br>
                            &gt; +<br>
                            &gt; +             if (str_off == str_len ||
                            str[str_off] == 0)<br>
                            &gt; +                     return p_rom +
                            start;<br>
                            &gt; +     }<br>
                            &gt; +     return NULL;<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt; +static void atom_get_vbios_pn(struct
                            atom_context *ctx) {<br>
                            &gt; +     unsigned char *p_rom;<br>
                            &gt; +     unsigned short off_to_vbios_str;<br>
                            &gt; +     unsigned char *vbios_str;<br>
                            &gt; +     int count;<br>
                            &gt; +<br>
                            &gt; +     off_to_vbios_str = 0;<br>
                            &gt; +     p_rom = ctx-&gt;bios;<br>
                            &gt; +<br>
                            &gt; +     if (*(p_rom +
                            OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) !=
                            0) {<br>
                            &gt; +             off_to_vbios_str =<br>
                            &gt; +                     *(unsigned short
                            *)(p_rom +
                            OFFSET_TO_GET_ATOMBIOS_STRING_START);<br>
                            &gt; +<br>
                            &gt; +             vbios_str = (unsigned
                            char *)(p_rom + off_to_vbios_str);<br>
                            &gt; +     } else {<br>
                            &gt; +             vbios_str = p_rom +
                            OFFSET_TO_VBIOS_PART_NUMBER;<br>
                            &gt; +     }<br>
                            &gt; +<br>
                            &gt; +     if (*vbios_str == 0) {<br>
                            &gt; +             vbios_str =
                            atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX,
                            3, 1024, 64);<br>
                            &gt; +             if (vbios_str == NULL)<br>
                            &gt; +                     vbios_str +=
                            sizeof(BIOS_ATOM_PREFIX) - 1;<br>
                            &gt; +     }<br>
                            &gt; +     if (vbios_str != NULL &amp;&amp;
                            *vbios_str == 0)<br>
                            &gt; +             vbios_str++;<br>
                            &gt; +<br>
                            &gt; +     if (vbios_str != NULL) {<br>
                            &gt; +             count = 0;<br>
                            &gt; +             while ((count &lt;
                            BIOS_STRING_LENGTH) &amp;&amp;
                            vbios_str[count] &gt;= ' ' &amp;&amp;<br>
                            &gt; +                    vbios_str[count]
                            &lt;= 'z') {<br>
                            &gt; +                    
                            ctx-&gt;vbios_pn[count] = vbios_str[count];<br>
                            &gt; +                     count++;<br>
                            &gt; +             }<br>
                            &gt; +<br>
                            &gt; +             ctx-&gt;vbios_pn[count] =
                            0;<br>
                            &gt; +     }<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt; +static void
                            atom_get_vbios_version(struct atom_context
                            *ctx) {<br>
                            &gt; +     unsigned char *vbios_ver;<br>
                            &gt; +<br>
                            &gt; +     /* find anchor ATOMBIOSBK-AMD */<br>
                            &gt; +     vbios_ver =
                            atom_find_str_in_rom(ctx,
                            BIOS_VERSION_PREFIX, 3, 1024, 64);<br>
                            &gt; +     if (vbios_ver != NULL) {<br>
                            &gt; +             /* skip ATOMBIOSBK-AMD
                            VER */<br>
                            &gt; +             vbios_ver += 18;<br>
                            &gt; +            
                            memcpy(ctx-&gt;vbios_ver_str, vbios_ver,
                            STRLEN_NORMAL);<br>
                            &gt; +     } else {<br>
                            &gt; +             ctx-&gt;vbios_ver_str[0]
                            = '\0';<br>
                            &gt; +     }<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt;   struct atom_context
                            *amdgpu_atom_parse(struct card_info *card,
                            void *bios)  {<br>
                            &gt;        int base;<br>
                            &gt;        struct atom_context *ctx =<br>
                            &gt;            kzalloc(sizeof(struct
                            atom_context), GFP_KERNEL);<br>
                            &gt;        char *str;<br>
                            &gt; +     struct _ATOM_ROM_HEADER
                            *atom_rom_header;<br>
                            &gt; +     struct _ATOM_MASTER_DATA_TABLE
                            *master_table;<br>
                            &gt; +     struct _ATOM_FIRMWARE_INFO
                            *atom_fw_info;<br>
                            &gt;        u16 idx;<br>
                            &gt;   <br>
                            &gt;        if (!ctx)<br>
                            &gt; @@ -1353,6 +1510,23 @@ struct
                            atom_context *amdgpu_atom_parse(struct
                            card_info *card, void *bios)<br>
                            &gt;               
                            strlcpy(ctx-&gt;vbios_version, str,
                            sizeof(ctx-&gt;vbios_version));<br>
                            &gt;        }<br>
                            &gt;   <br>
                            &gt; +     atom_rom_header = (struct
                            _ATOM_ROM_HEADER *)CSTR(base);<br>
                            &gt; +     ctx-&gt;sub_dev_id =
                            atom_rom_header-&gt;usSubsystemVendorID;<br>
                            &gt; +     ctx-&gt;sub_ved_id =
                            atom_rom_header-&gt;usSubsystemID;<br>
                            &gt; +     if
                            (atom_rom_header-&gt;usMasterDataTableOffset
                            != 0) {<br>
                            &gt; +             master_table = (struct
                            _ATOM_MASTER_DATA_TABLE *)<br>
                            &gt; +                            
                            CSTR(atom_rom_header-&gt;usMasterDataTableOffset);<br>
                            &gt; +             if
                            (master_table-&gt;ListOfDataTables.FirmwareInfo
                            != 0) {<br>
                            &gt; +                     atom_fw_info =
                            (struct _ATOM_FIRMWARE_INFO *)<br>
                            &gt; +                                    
                            CSTR(master_table-&gt;ListOfDataTables.FirmwareInfo);<br>
                            &gt; +                     ctx-&gt;version =
                            atom_fw_info-&gt;ulFirmwareRevision;<br>
                            &gt; +             }<br>
                            &gt; +     }<br>
                            &gt; +<br>
                            &gt; +     atom_get_vbios_name(ctx);<br>
                            &gt; +     atom_get_vbios_pn(ctx);<br>
                            &gt; +     atom_get_vbios_date(ctx);<br>
                            &gt; +     atom_get_vbios_version(ctx);<br>
                            &gt;   <br>
                            &gt;        return ctx;<br>
                            &gt;   }<br>
                            &gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/atom.h <br>
                            &gt; b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
                            &gt; index d279759cab47..6463ce6e756d 100644<br>
                            &gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.h<br>
                            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
                            &gt; @@ -112,6 +112,10 @@ struct drm_device;<br>
                            &gt;   #define ATOM_IO_SYSIO               2<br>
                            &gt;   #define ATOM_IO_IIO         0x80<br>
                            &gt;   <br>
                            &gt; +#define STRLEN_NORMAL               
                            32<br>
                            &gt; +#define STRLEN_LONG          64<br>
                            &gt; +#define STRLEN_VERYLONG             
                            254<br>
                            &gt; +<br>
                            &gt;   struct card_info {<br>
                            &gt;        struct drm_device *dev;<br>
                            &gt;        void (* reg_write)(struct
                            card_info *, uint32_t, uint32_t);   /* 
                            filled by driver */<br>
                            &gt; @@ -140,6 +144,14 @@ struct
                            atom_context {<br>
                            &gt;        uint32_t *scratch;<br>
                            &gt;        int scratch_size_bytes;<br>
                            &gt;        char vbios_version[20];<br>
                            &gt; +<br>
                            &gt; +     uint8_t name[STRLEN_LONG];<br>
                            &gt; +     uint8_t vbios_pn[STRLEN_LONG];<br>
                            &gt; +     uint32_t version;<br>
                            &gt; +     uint8_t
                            vbios_ver_str[STRLEN_NORMAL];<br>
                            &gt; +     uint8_t date[STRLEN_NORMAL];<br>
                            &gt; +     uint32_t sub_dev_id;<br>
                            &gt; +     uint32_t sub_ved_id;<br>
                            &gt;   };<br>
                            &gt;   <br>
                            &gt;   extern int amdgpu_atom_debug;<br>
                            &gt; diff --git
                            a/drivers/gpu/drm/amd/include/atomfirmware.h
                            <br>
                            &gt;
                            b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
                            &gt; index 275468e4be60..28deecc2f990 100644<br>
                            &gt; ---
                            a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
                            &gt; +++
                            b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
                            &gt; @@ -197,6 +197,9 @@ enum
                            atom_dp_vs_preemph_def{<br>
                            &gt;     DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,<br>
                            &gt;   };<br>
                            &gt;   <br>
                            &gt; +#define BIOS_ATOM_PREFIX   "ATOMBIOS"<br>
                            &gt; +#define BIOS_VERSION_PREFIX 
                            "ATOMBIOSBK-AMD"<br>
                            &gt; +#define BIOS_STRING_LENGTH 43<br>
                            &gt;   <br>
                            &gt;   /*<br>
                            &gt;   enum atom_string_def{<br>
                            &gt; @@ -215,6 +218,8 @@ enum
                            atombios_image_offset{<br>
                            &gt;    
                            MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =
                            20,  /*including the terminator 0x0!*/<br>
                            &gt;    
                            OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =
                            0x2f,<br>
                            &gt;    
                            OFFSET_TO_GET_ATOMBIOS_STRING_START        =
                            0x6e,<br>
                            &gt; + 
                            OFFSET_TO_VBIOS_PART_NUMBER                =
                            0x80,<br>
                            &gt; + 
                            OFFSET_TO_VBIOS_DATE                       =
                            0x50,<br>
                            &gt;   };<br>
                            &gt;   <br>
                            &gt;   <br>
                            &gt;
                            /*********************************************************************<br>
                            &gt; ******* diff --git
                            a/include/uapi/drm/amdgpu_drm.h <br>
                            &gt; b/include/uapi/drm/amdgpu_drm.h index
                            9169df7fadee..e0f98ca9a755 <br>
                            &gt; 100644<br>
                            &gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
                            &gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
                            &gt; @@ -756,6 +756,8 @@ struct
                            drm_amdgpu_cs_chunk_data {<br>
                            &gt;        #define
                            AMDGPU_INFO_VBIOS_SIZE          0x1<br>
                            &gt;        /* Subquery id: Query vbios
                            image */<br>
                            &gt;        #define
                            AMDGPU_INFO_VBIOS_IMAGE         0x2<br>
                            &gt; +     /* Subquery id: Query vbios info
                            */<br>
                            &gt; +     #define
                            AMDGPU_INFO_VBIOS_INFO          0x3<br>
                            &gt;   /* Query UVD handles */<br>
                            &gt;   #define
                            AMDGPU_INFO_NUM_HANDLES                    
                            0x1C<br>
                            &gt;   /* Query sensor related information
                            */ @@ -949,6 +951,20 @@ struct <br>
                            &gt; drm_amdgpu_info_firmware {<br>
                            &gt;        __u32 feature;<br>
                            &gt;   };<br>
                            &gt;   <br>
                            &gt; +struct drm_amdgpu_info_vbios {<br>
                            &gt; +     __u8 name[64];<br>
                            &gt; +     __u32 dbdf;<br>
                            &gt; +     __u8 vbios_pn[64];<br>
                            &gt; +     __u32 version;<br>
                            &gt; +     __u8 vbios_ver_str[32];<br>
                            &gt; +     __u8 date[32];<br>
                            &gt; +     __u64 serial;<br>
                            &gt; +     __u32 dev_id;<br>
                            &gt; +     __u32 rev_id;<br>
                            &gt; +     __u32 sub_dev_id;<br>
                            &gt; +     __u32 sub_ved_id;<br>
                            &gt; +};<br>
                            &gt; +<br>
                            &gt;   #define AMDGPU_VRAM_TYPE_UNKNOWN 0<br>
                            &gt;   #define AMDGPU_VRAM_TYPE_GDDR1 1<br>
                            &gt;   #define AMDGPU_VRAM_TYPE_DDR2  2<br>
                            &gt; --<br>
                            &gt; 2.17.1</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0350151105ADDECF62B10594--

--===============1522302160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1522302160==--
