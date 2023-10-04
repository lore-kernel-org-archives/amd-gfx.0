Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B6FE7C4D0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 15:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE1210E389;
	Wed,  4 Oct 2023 15:18:34 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF1110E065
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 15:18:32 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ae35773a04so1431378b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696432711; x=1697037511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Z+ibC6ycOvyMBiDCNyFwo9z34qkp0A62KVBRnIde/Y=;
 b=QRkpYg8xygCEFURV1N66qAE1SaedQ6uijVH4DEuq5H/qzO4dfGfrD6uJRrX/4fGk/A
 DcRDzLqM3comdXLwFg1aoUdLY3hcuqv+43NxwoA2WPL0tJR5dfC+lL8SFaqNmfAmY+ES
 2vTcSU3HjTTUbHlGExt1MdDcfeBWbLOGZbZortkngMhNf6/IhbjC806uQAtvjnY0H16y
 0ghmwKDaUEumana35hPmNtMnOOKfAGoPVmuh+cWBt8sO5VAKSUVj9vb2/JOY+l5pwUFZ
 4h05frLcEsCv4T1XuFrys8lCvgImNyqfsB6STia5xKUWforCGrgbEI3jVdU7l3NNmxMa
 2Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696432711; x=1697037511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Z+ibC6ycOvyMBiDCNyFwo9z34qkp0A62KVBRnIde/Y=;
 b=YEpKnkn9wBgMsTfEGIg+DpQSoiu9+BSDl25DGhrmH9RLbwnXzqWRhDJz6E978bFiyn
 VavVQCV3Kk2S7ciOrvGlnLTtlbquQeskShrBAgCWOZkE7XS4etLZEl5hURGyLlIAZrtr
 C0dJ9uClbgd740BQhKHXNjF9kdU1DqTeADlFlE/n+2NcoIqwBlUpvvgC3bWMkqFGQHcv
 UR95VOxu1Ioblz2V8YKsLX/jA2PubkJcYX3qtfMYft2zDpcemJgDIP7hV2Pgh4D+QjJj
 9BmQ9lQZmfms0q6ea8vGcdiZM+tzIvwaHgkSgyk1rjQX7NSaFrk+0plyFf1Hnr3CIUtO
 Oa6g==
X-Gm-Message-State: AOJu0Yxu81xhHaJyh4Eu7j/cJu1KIIq8jXN0+2jLCDXwaXrLLyxhQXhN
 uSsX0PscogiLVTacr6D5m7b0sAXctnKF/0AGBNSYEX0b
X-Google-Smtp-Source: AGHT+IHPYYhvI8HENGUtAqjHvH2qsBg0kEaNKTsfJp79OEI8OLZfd4Mc/wkpmYejqEdheRgHazRBY12fLRCYASkj20Q=
X-Received: by 2002:a05:6870:1708:b0:1ba:caf2:acc3 with SMTP id
 h8-20020a056870170800b001bacaf2acc3mr3056392oae.5.1696432711304; Wed, 04 Oct
 2023 08:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231003190731.106594-1-alexander.deucher@amd.com>
 <CADnq5_OTfvO0piqPPnvMrJCq9YJmQ8pJrPZh_Fuz1MNNikv-6A@mail.gmail.com>
 <PH7PR12MB59970BA3BCDE01CC2B6CF41382CBA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CADnq5_NOBCg0bydQdN7mzV5CM95V55SSquEFLSzvWc1iM85zQA@mail.gmail.com>
In-Reply-To: <CADnq5_NOBCg0bydQdN7mzV5CM95V55SSquEFLSzvWc1iM85zQA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Oct 2023 11:18:20 -0400
Message-ID: <CADnq5_NHF6-AOuHYnY8Wcd0C5Bg_yQDBJj+=qc_pzmVzTkHH4w@mail.gmail.com>
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

On Wed, Oct 4, 2023 at 10:51=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Oct 4, 2023 at 10:46=E2=80=AFAM Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com> wrote:
> >
> > Hi Alex,
> >
> > why need to switch profile twice for smu 13.0.0 ? in idle state : set c=
ompute profile then set power save profile?
> > Afaik, Pmfw always uses the last set result to represent the current pr=
ofile.
> > But it shouldn't affect the results. Anyway.
>
> We want to be setting both workload bits (powersave and compute).  I
> guess this won't work as is?  I thought the code or'ed both bits.

Confirming this won't work as expected.  Will rework and resend.

Alex

>
> Alex
>
>
> >
> > Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> >
> > Best Regards,
> > Kevin
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex=
 Deucher
> > Sent: Wednesday, October 4, 2023 10:04 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when R=
OCm is active
> >
> > Ping?
> >
> > On Tue, Oct 3, 2023 at 6:47=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> > >
> > > When ROCm is active enable additional SMU 13.0.0 optimizations.
> > > This reuses the unused powersave profile on PMFW.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > index 38b5457baded..b6c0c42de725 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > @@ -714,6 +714,14 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgp=
u_device *adev, bool idle)
> > >         amdgpu_dpm_switch_power_profile(adev,
> > >                                         PP_SMC_POWER_PROFILE_COMPUTE,
> > >                                         !idle);
> > > +       /* Add optimizations for SMU13.0.0.  Reuse the power saving p=
rofile */
> > > +       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0, 0)) &&
> > > +           ((adev->pm.fw_version =3D=3D 0x004e6601) ||
> > > +            (adev->pm.fw_version >=3D 0x004e7300))) {
> > > +               amdgpu_dpm_switch_power_profile(adev,
> > > +                                               PP_SMC_POWER_PROFILE_=
POWERSAVING,
> > > +                                               !idle);
> > > +       }
> > >  }
> > >
> > >  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> > > --
> > > 2.41.0
> > >
