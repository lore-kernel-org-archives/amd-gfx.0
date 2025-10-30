Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E34CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1962810E9E2;
	Thu, 30 Oct 2025 15:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brZhRpBv";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8145110E9E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:18:47 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-294e5852bf6so1817955ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761837527; x=1762442327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXB7YpKyWOhpVRL/ODJ5VHzsg9J5IOo6AFV7BhbWSzM=;
 b=brZhRpBvD2gdfPDUmOtwUCEAoI3FQxyV9tR4WQSe997nEVZmiDfTsu8g9JsPjidJvY
 LOA5YGgtwI1ZYUb95ar5zW7T01WOI/ltL3KeI6ERlKwfTGqnkpSqRWLveJYlI5f0JUS5
 Ei98GdIpdbN/tIGWDkzpi/fnQd0COzfnhgpq950XNICiFkHgu0SGQDoavNnrBM6VzyCC
 ipe6wIaLX5Deo0jRBODnt3WcEIxPEQWSTdrc/REFNpD3H0Ozp6DQTAiGwaDI/XbC/5Yl
 KcJi1j7xEAQBQKgPA/+G3bHBt30iuGyi9LF4m5nA7hrmd0d5RtZ6kZR1C/YR/doIOhp0
 dzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761837527; x=1762442327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXB7YpKyWOhpVRL/ODJ5VHzsg9J5IOo6AFV7BhbWSzM=;
 b=LnX/pyA0Gvr8IrCYS4M1wl+M+8xJ5/cmfN4wP5MjPX5oqSpFbaJcVDhy5WnTZTgQOj
 x4Dv2YvhNtSHCe42t1gAUKj78tTFQFgfGgA0NV3wG6iOXvBxd3oGMrdVcGxpXyab0TEw
 3lAwA6OVahNA7FTSptSlMKxZdKSd6yLgAC00Ilj6eu4te9wRNh+GWa8YDvnGmhrkYJ3U
 M+nqcFzQJrl5ckjXeUWdVklBZd1G2aI0BkQEYuot9Elx43d+sTr0eHX0CcILDr90YVTR
 N5exo2wnzMPeJ4/ip2P7MIO8dP8yVe3+NmqAjR5d1gFtMm/v4rClEtUbe1a7NjaQL6NK
 yDOQ==
X-Gm-Message-State: AOJu0YyLKezMbnfm+n8Qcsw7/5iwCCVpkmqOsqXa0HuIMn9bHWJ/3F/J
 wQFEFlIydGTrGWElwO1vJtvI5B1tj3R3ugfHzuaCJ5uNvMqjqJfAU/so/nHCKDJ61rG9j4/MC5D
 1qJ/a6qpFsqHhZ/4hrigmJGg38vHx++o=
X-Gm-Gg: ASbGncv4cQTzbY+YfyR9Pv95WiJPU9/DfN+ZphZ5QJbKUruysMdXaj+9qOWDGIht4Fv
 97dvJFnvCE13HRyHX4upIzBRqSHe6vqWNz2eHDK8vlF/VbtSeGMidLdmZeoAPyAOyUYkKglsHlG
 MbGo2szO1dAYlrYVBZfyP23BZOgERnVCvjEw9uuby3NYsKtSR9Z6uubTSTdfIQLCKmxZ4kLXPo7
 9APF1TIlPR8rNozYjdg6znyqWozrtWQq3Nv3Kn5HQeY6bPB9o1P0aYrzOso
X-Google-Smtp-Source: AGHT+IF6Bg1I7c0dDJlCHcURXkf22HBEadeMbP++TjCWK+cU5Z73FHbN2cQWnUx4TQTL3kdnMqo9kF7zshZJJF05tLc=
X-Received: by 2002:a17:902:c651:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2951a491ecamr419705ad.6.1761837526727; Thu, 30 Oct 2025
 08:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251026042942.549389-1-superm1@kernel.org>
 <20251026042942.549389-3-superm1@kernel.org>
 <CADnq5_NuD-h26B8tjPAKmWPE=48u6iFgYibi3uR9XXZuY=B5EA@mail.gmail.com>
 <fbf9fa5c-1c60-423c-a06b-b5e8525590ab@kernel.org>
In-Reply-To: <fbf9fa5c-1c60-423c-a06b-b5e8525590ab@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 11:18:34 -0400
X-Gm-Features: AWmQ_blIPknOyCjFJ0s1GlzlfcFgasuYicf9BVfZr4KfSK8Z9XmNOICw2O93XFs
Message-ID: <CADnq5_Of+btg8pGcdOx1DDVv8uoeYq7myRZ5ycf0cK3hzTVNSg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] drm/amd: Add an unwind for failures in
 amdgpu_device_ip_suspend_phase1()
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 30, 2025 at 11:16=E2=80=AFAM Mario Limonciello (AMD) (kernel.or=
g)
<superm1@kernel.org> wrote:
>
>
>
> On 10/30/2025 10:14 AM, Alex Deucher wrote:
> > Patches 2-4 are:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Thanks!
>
> How about patch 1?  Patch 4 builds on it, so if that doesn't go in there
> is another unwind step needed.

Oh, yeah, feel free to add my RB on that one as well, I guess it's not
quite the same as the one I sent out originally.

Alex

>
> >
> > On Sun, Oct 26, 2025 at 12:36=E2=80=AFAM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> If any hardware IPs involved with the first phase of suspend fail, unw=
ind
> >> all steps to restore back to original state.
> >>
> >> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 ++++++++++++++++--
> >>   1 file changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index f6850b86e96f..b9ea91b2c92f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -178,6 +178,7 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =
=3D {
> >>                  BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE=
_IH) |
> >>                  BIT(AMD_IP_BLOCK_TYPE_PSP)
> >>   };
> >> +static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)=
;
> >>
> >>   static void amdgpu_device_load_switch_state(struct amdgpu_device *ad=
ev);
> >>
> >> @@ -3784,7 +3785,7 @@ static void amdgpu_device_delay_enable_gfx_off(s=
truct work_struct *work)
> >>    */
> >>   static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *ade=
v)
> >>   {
> >> -       int i, r;
> >> +       int i, r, rec;
> >>
> >>          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >>          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >> @@ -3807,10 +3808,23 @@ static int amdgpu_device_ip_suspend_phase1(str=
uct amdgpu_device *adev)
> >>
> >>                  r =3D amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
> >>                  if (r)
> >> -                       return r;
> >> +                       goto unwind;
> >>          }
> >>
> >>          return 0;
> >> +unwind:
> >> +       rec =3D amdgpu_device_ip_resume_phase3(adev);
> >> +       if (rec)
> >> +               dev_err(adev->dev,
> >> +                       "amdgpu_device_ip_resume_phase3 failed during =
unwind: %d\n",
> >> +                       rec);
> >> +
> >> +       amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW);
> >> +
> >> +       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> >> +       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> >> +
> >> +       return r;
> >>   }
> >>
> >>   /**
> >> --
> >> 2.51.1
> >>
>
