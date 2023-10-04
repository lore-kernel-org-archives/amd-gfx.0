Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1C1E7C4CB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 14:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C605510E139;
	Wed,  4 Oct 2023 14:51:57 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE1C810E139
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 14:51:56 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1dd830ed844so1464036fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696431116; x=1697035916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyEnogkH/rWyePUV58iuqDlQirdvg6LcTpK43RDGdTs=;
 b=ejpNSd7NxPBeuBX8e8YY7G98BSEpa3oQgsZdAuX4SFmJRAo23v71JF+2jiXsmCQD6c
 pOh6wWonInOGKoG2P8jBjhGHpLl4YwWDKJJRfs7y6JygA+UVkpoundZVgDWH1oxQL535
 yDgD8rG3cTOtYTYeyQmGta+DbXYhMPfhcRVqVzH5qnZTbQg4MddQIfr9q4YZqyrPvRwb
 q/zPW5x1sMHCu8cRzAETfqdVe/eGiwTTCyY5Iv7UKhj2mUFq062+QyJJ6Mj8KVezkKZH
 3y6tzAKD9E3oUJrNytStA9rtCBqHiywiFwdvcVmvM/IF9Ofoweu1FQVxjfzs5JkTmBss
 fY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431116; x=1697035916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyEnogkH/rWyePUV58iuqDlQirdvg6LcTpK43RDGdTs=;
 b=NVYHyhIS96fIM/WHev87iXmR69uvdkeG81UdrWLLKBOpLp9AYsN68vy0rg/z/DqsV/
 bF6x6OUqy0A9UasPCYX1kAGTvmmf8jcmh6JbHsZFCzgexsE8CQdiNrqRS/yel5crvYt2
 9lLr42LbbYAsi8JmIFHBWYhzxaDe+ZihAopA08I1+gsW6GVmesxBTpIYKRk1+PfmwP8j
 ljRfp25WvdT+GJcPRqD7gBpuKvJWWlF9Qh0pab1+TWDlmjr02OuvCM3FAehPhMQZnHYj
 /5IoO8JxhpoiyTOZ3Gr9LtpJmefrtPGd6gTWOM1GoJVsZsjeJ0eZc9n7kH77Yx+MBZ/o
 KJng==
X-Gm-Message-State: AOJu0YxYdfvtUMVCC2H1T7rPHyWt+AP3AkJXph/0cPUtKwhofyTf77FP
 WHNVWKCo/CKLBPT/uZwAiebydOfLrM2/uFm1P+cPcp08
X-Google-Smtp-Source: AGHT+IFYjLNgHpg1QstQNAuJ9z67RZjLDUfmXR/NplaWCPfekdW1B+rN83ekHPoI+49zna1yjWd4NHccWRGSPAz/AEA=
X-Received: by 2002:a05:6870:1615:b0:1dd:67b7:2ce6 with SMTP id
 b21-20020a056870161500b001dd67b72ce6mr2814845oae.58.1696431115919; Wed, 04
 Oct 2023 07:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231003190731.106594-1-alexander.deucher@amd.com>
 <CADnq5_OTfvO0piqPPnvMrJCq9YJmQ8pJrPZh_Fuz1MNNikv-6A@mail.gmail.com>
 <PH7PR12MB59970BA3BCDE01CC2B6CF41382CBA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59970BA3BCDE01CC2B6CF41382CBA@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Oct 2023 10:51:44 -0400
Message-ID: <CADnq5_NOBCg0bydQdN7mzV5CM95V55SSquEFLSzvWc1iM85zQA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 4, 2023 at 10:46=E2=80=AFAM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> Hi Alex,
>
> why need to switch profile twice for smu 13.0.0 ? in idle state : set com=
pute profile then set power save profile?
> Afaik, Pmfw always uses the last set result to represent the current prof=
ile.
> But it shouldn't affect the results. Anyway.

We want to be setting both workload bits (powersave and compute).  I
guess this won't work as is?  I thought the code or'ed both bits.

Alex


>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Wednesday, October 4, 2023 10:04 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROC=
m is active
>
> Ping?
>
> On Tue, Oct 3, 2023 at 6:47=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
> >
> > When ROCm is active enable additional SMU 13.0.0 optimizations.
> > This reuses the unused powersave profile on PMFW.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.c
> > index 38b5457baded..b6c0c42de725 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -714,6 +714,14 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_=
device *adev, bool idle)
> >         amdgpu_dpm_switch_power_profile(adev,
> >                                         PP_SMC_POWER_PROFILE_COMPUTE,
> >                                         !idle);
> > +       /* Add optimizations for SMU13.0.0.  Reuse the power saving pro=
file */
> > +       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 0)) &&
> > +           ((adev->pm.fw_version =3D=3D 0x004e6601) ||
> > +            (adev->pm.fw_version >=3D 0x004e7300))) {
> > +               amdgpu_dpm_switch_power_profile(adev,
> > +                                               PP_SMC_POWER_PROFILE_PO=
WERSAVING,
> > +                                               !idle);
> > +       }
> >  }
> >
> >  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> > --
> > 2.41.0
> >
