Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C209CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 15:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8F110E502;
	Thu, 12 Oct 2023 15:19:20 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B0510E528
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 15:19:18 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1dcfb21f9d9so629564fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697123958; x=1697728758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5sDyfxt+hVprMKrnvkGa/2I5voYVTU9Ii9RB7m+C5s=;
 b=IRhnyf3D3pd63JVKL8zG2Di45+JOq8jc4o62Kjv3UD9ydGWtPflpytUhBEe55l5fg0
 zFhUWzm2RarK06k7Muvvs3UYxfhvdYuqgWyWXsFgQ7GNpC6OAZvMYKjSFq7sbK/L7qT9
 Lc7+CC0+P+aaweSYe3pop/PtbnjeW9lypXpgHF4Kl0MHYSMZPTZeqm4+xMTp8xZ/jL3C
 bw8IiOXBbtw+zQI4NLJvgWJk9C7bNSXQayRUQ3nnplP7rB+mu6JJ4jaY3ZNutMi/LqmM
 TDJp/AGbHFsZvAgo5d2BUOfLKnRadFeWprr+zczDq0BkyQKxLBunAjJ/wl1ASCl0KFPx
 kGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697123958; x=1697728758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5sDyfxt+hVprMKrnvkGa/2I5voYVTU9Ii9RB7m+C5s=;
 b=mAtxXogRmFvpPsFq/SpiYADrXQr9fqvXIcHHsGPlEDYdoQRzwLIxtp1JMhnW300Dog
 aTBTCIdNUu1wA13iLq7Gfbyg66Bwegz68jYEU32ddeGVKJv8u5adbWQNf1F6ET2vOG1F
 S46SULTh51pBLl9OojqqhbPy88RZbGlYbNY3PIY/+TMPC0Iq75ThLuVWZrT82qSDKRVW
 9S17U9CUXgGLlKExiMgoCS5k/RWALhwhfBYjrPMze5lRZN4ZC8K4ceV6XJeSnh9V2YBu
 df4hoqdkV245odyxOvWPIfwnf312Lh4TIqsFBbzCwmyeEBr9a7P64lnu3jS9xu+vGMlW
 P7uw==
X-Gm-Message-State: AOJu0YylqoT4C8t6hgzFfyPWKNxysArzTPPwoWc3Ew55NraQB07R7qBL
 Vk0NBUfvlFbIxcnYuJOdhWAu0GspV7oXQoq362IYJQvw
X-Google-Smtp-Source: AGHT+IFuXRpBuvD6fClAsUXCowNyZkNDOzrpVHiAOJUUZl4CQbPR+/0mNTz6V/uSeZfFHAuWdNl6c+o7x0ocBouo9xg=
X-Received: by 2002:a05:6870:1650:b0:1e1:e399:8261 with SMTP id
 c16-20020a056870165000b001e1e3998261mr29027180oae.11.1697123957605; Thu, 12
 Oct 2023 08:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231011072631.1901764-1-jesse.zhang@amd.com>
 <CADnq5_PUDDYMpajRmMqnqgaUh39SDFj6LDD_pxjwHNGr7jqPTw@mail.gmail.com>
 <DM4PR12MB51523C891778FFA624256806E3D3A@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51523C891778FFA624256806E3D3A@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Oct 2023 11:19:06 -0400
Message-ID: <CADnq5_Nu=u5fost+E4B4iRYT4jCBs4jMpgw9RDxNiD+gz830-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable GFXOFF and PG during compute for GFX9
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 11, 2023 at 9:49=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, October 11, 2023 10:20 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehli=
ng@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: disable GFXOFF and PG during compute for=
 GFX9
>
> On Wed, Oct 11, 2023 at 3:52=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com>=
 wrote:
> >
> > Temporary workaround to fix issues observed in some compute
> > applications when GFXOFF is enabled on GFX9.
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index d3805dbbbb6f..fef93d4edcbc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -683,12 +683,16 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device
> > *adev,
> >
> >  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool
> > idle)  {
> > +       enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE :
> > + AMD_PG_STATE_UNGATE;
> >         /* Temporary workaround to fix issues observed in some
> >          * compute applications when GFXOFF is enabled on GFX11.
> >          */
> >         if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D =
11) {
> >                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled=
");
> >                 amdgpu_gfx_off_ctrl(adev, idle);
> > +       } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0))=
 =3D=3D 9) &&
> > +               (adev->flags & AMD_IS_APU)) {
> > +
> > + adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version->funcs->set_powergati
> > + ng_state((void *)adev, state);
>
> Why not use amdgpu_gfx_off_ctrl(adev, idle); for consistency?
> [Zhang, Jesse(Jie)]  Hi Alex,
>           amdgpu_gfx_off_ctrl only disable gfxoff. It also need to disabl=
e gfx9's powergating to workaround.
>          So use the set_powergating_state to disable gfxoff and PG.

Thanks for clarifying.  Maybe add a comment to that effect.  With that fixe=
d:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
>         Jesse
> Alex
>
> >         }
> >         amdgpu_dpm_switch_power_profile(adev,
> >                                         PP_SMC_POWER_PROFILE_COMPUTE,
> > --
> > 2.25.1
> >
