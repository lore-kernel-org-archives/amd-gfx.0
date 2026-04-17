Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20D0F436BF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 19:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4876810EA94;
	Fri, 17 Apr 2026 19:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a2FjQmG+";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B19310EA94
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 19:03:41 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c750eaf4cso15479c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 12:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776452620; cv=none;
 d=google.com; s=arc-20240605;
 b=Ww0R3egw7cG972FR789HA5MaUNhhV86gubRXUlE3X2+j/tXx5zBP7iHq9ICBwqC1oa
 mgEby9KKHCPSentb3btKs1sKEFjDMRl55PmHI1xUlGSRJRsbOc+VoGQ0TLWqdUTEwj/z
 m6v++GvGCiK6DeKWFk552I7qSxr+l+6iSLI9jyZrYsIZ/IYFplnvB0zq5E/G1xZWBzSa
 vOYxYRtqmdeUhcLS+hGHEioynRFcaWpxj9kZyr5KqoCxxncZtePvNBfFbgHuOcesztLl
 hoZaSSgt5/cKAZHFBBGRyMi6vALfxPfpNiPUmHb1K5svNXkAsA6e0r4MbWbjOyCJZZx4
 F3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=48PkQzawbX2U/I174xVMBOJ30/cxHhJ5sdphla9VdOs=;
 fh=v458ECaodq3QyzOL1RG0vslxIShLBcyzpAjnViqOYIg=;
 b=RG+zUCzuOJ9RitOkFBRpwN5AH2D5oE/44CoF+XjJB809jKTVkG9ODSs2uYB4F+lXqi
 vV08c1nx1EFqCu7HQv5pjiZ1TkuZkBljsnPwqQdN08NLyzYR2VEFGCOMDvrf53e5S6LW
 6vELpl0jjZpQAZMpjYAQNWLg1xBdhwO86SD9RE12lrURCnX53jMoYP0/cHZ5pTujemsw
 2noXUd8b1bbXuBDA0KHFUrfdzAI/n/SL8HgX8b3Tqd+Xsae7wb5HxNDQdUwiVTha9vkP
 8CrTxl5W14Nm3ueWLqeokLknCqhjQu+dXXyST2+kEaicaI6aQeSRWRdP+lgEeSM1uVNi
 MZfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776452620; x=1777057420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48PkQzawbX2U/I174xVMBOJ30/cxHhJ5sdphla9VdOs=;
 b=a2FjQmG+313QDv3QaCVwovV7fKLNyRmAdGHRVi1yxoo2N2OjJ+y3mOEFfX7Mb15Jvt
 KdPmPzIfUPd3ysRQiUjtw3Cl82kqFDhpFCMz7UCOSMOtpcxwEvtDkoU0/3vKOif3l97R
 oC9qh3D64urwrq0CSxGYppjd5TWwjC/EqZsYHHQCXHQd3At6txL/V5ST6ly2AuQ5SPsp
 FacZ7mvtjE3zsVmYQP6tRCF1f/vYz7amljrR/McWgxSGzcaaS3MciEHLcyWD2P0QgSv9
 34dk3cfmsO31UkysGj98tfM4AznGYOohNuCPGetymKtJk1UgJ0iiz+PBSpmL6R7By4Jp
 s/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776452620; x=1777057420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=48PkQzawbX2U/I174xVMBOJ30/cxHhJ5sdphla9VdOs=;
 b=qpt2IQUpMY2FYt/dZxZ5Qr+/SApOHY9KwnJywQDFd/HXo40MxdlD4FxF7iwBU20PUO
 WSNfFq+Jc8eFJIkMQz1S4r4GGaGAbfiWBvpFUcEfO5qJs1Fg4A65idF5G8Nrg28E3Yyw
 VDYCi2w3jg0Z9cQTIHsBVyK00V8VHBR5+LGfxAdjhhiZvyegXnfKfkkD6qPragGvVrpb
 txXPFWqlwNdgKQNeu8njREKmbVvWATvaBrQCjtYEPluQXuYjPJKgEvOWJckLRbUgDp5+
 CtQBkVgvdcwWQP30njoSGqZm/LSO5FLfYsNepKr2If0u4r4Euz7l6ivBisln5lAEitDS
 qmfA==
X-Gm-Message-State: AOJu0YymljNyjh98ZqbIoxz9B7Dn0eOLPkrNHbyaIX3bTmm08Ir9RWT9
 POF6+nQZNuE30oZd84dBv8wusiW7xgP+aItN9+Ay9OhQ/ANWCVG2hOTKLJffVZ7VXhxlkLY33nm
 yih24UC0HreKEaQa3fIfqhwUiGAvP8RYeFQ==
X-Gm-Gg: AeBDieu1AKn8FGhnIzzwUb0ahPSJLTw9Te8e+N/Ek++BUEPi3xqW/wYUVrirDgOIGC0
 2YNBmfrCpQmLU84wCQQm7kbhbQu64x7b+TTpXgdrhUXw65Y4rbk6y5jYLNX4LD+xqYHa1/oznHF
 5njEnr+C7QV3Ie05TNiVYXqqCNavRytthjndwyErq5BYIqaxln0J2Fxk0qjJGhC0TLIz8OVKvoy
 p9LDsKUMvHjh0vKp7K9fBFzU/LxjMmuOYslo5Cp9+0PatwaddWScTW9HBb/B2YQ4Bf36AD/H8gN
 jVgqprKuQpl9jE0KVLIfWBc16/6P8WOSx6sMEWtYQ6w+oTxFhIiEkQGf8dMzXFd4L6jcJCYXK1H
 yXK7f
X-Received: by 2002:a05:7022:660d:b0:12c:33dd:f9fd with SMTP id
 a92af1059eb24-12c73f65b16mr784961c88.1.1776452620019; Fri, 17 Apr 2026
 12:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260417175430.47434-1-sunpeng.li@amd.com>
 <CADnq5_M+DfU0_PO7DW-q3hCJzCWDa2kngG5onds_5XJqQO--tA@mail.gmail.com>
 <e276ad4a-72d9-401e-a88e-8e8542b6f2bd@amd.com>
In-Reply-To: <e276ad4a-72d9-401e-a88e-8e8542b6f2bd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 15:03:24 -0400
X-Gm-Features: AQROBzB2fy412Q3yxre4sGbJjYtlcMqpSEXewmBW7FqkJVZ-TkoYIFPHwjWUklg
Message-ID: <CADnq5_OJVujGWDGuZB74_Qh87aYMpeJDaRSQtcZnOYNTWUTF1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Undo accidental fix revert in
 amdgpu_dm_ism.c
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com, superm1@kernel.org, 
 Ray.Wu@amd.com
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

On Fri, Apr 17, 2026 at 2:32=E2=80=AFPM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2026-04-17 14:18, Alex Deucher wrote:
> > On Fri, Apr 17, 2026 at 2:14=E2=80=AFPM <sunpeng.li@amd.com> wrote:
> >>
> >> From: Leo Li <sunpeng.li@amd.com>
> >>
> >> [Why]
> >>
> >> Pausing DPM power profiles during static screen caused a bunch of
> >> audio/performance/clock issues that were addressed in this fix:
> >> 1412482b7143 ("Revert "drm/amd/display: pause the workload setting in =
dm"")
> >>
> >> This logic in function amdgpu_dm_crtc_vblank_control_worker() was move=
d
> >> to amdgpu_dm_ism.c, but the fix was lost in the process.
> >
> > Do you think ISM will fix this so we can re-enable pausing the power pr=
ofile?
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> This regression was caught in our testing this week, so I don't think so.
>
> The ISM doesn't differ from the original vblank on/off logic much. Instea=
d of
> idle features relying on the drm vblank off timer + a dm-specific worker,=
 we
> moved it to a dm-specific delayed worker + hysteresis to prevent idle sta=
te
> thrashing.
>
> I guess the question is: what exactly is amdgpu_dpm_pause_power_profile()
> doing? Does it enter some low power-state? If so, what are the needed
> conditions for entry and exit?

All it does is set the power profile back to the default/bootup
profile.  If there were workloads running the profile may be set to
video, fullscreen3d, or compute.  My understanding is that the DC low
power stuff gets ignored if the profile is not in the bootup state
when DC enters it's low power mode.  To fix that, we called this
helper to force the profile back to default/bootup do DC low power
features will kick in.

Alex

>
> Thanks,
> Leo
>
> >
> >>
> >> [How]
> >>
> >> Reapply the fix to amdgpu_dm_ism.c
> >>
> >> Fixes: 0b572a6bf04a ("drm/amd/display: Add Idle state manager(ISM)")
> >> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 10 ----------
> >>  1 file changed, 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> >> index d2f47c69921d4..d03ea3bafd469 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> >> @@ -270,7 +270,6 @@ static void dm_ism_commit_idle_optimization_state(=
struct amdgpu_dm_ism *ism,
> >>         struct amdgpu_crtc *acrtc =3D ism_to_amdgpu_crtc(ism);
> >>         struct amdgpu_device *adev =3D drm_to_adev(acrtc->base.dev);
> >>         struct amdgpu_display_manager *dm =3D &adev->dm;
> >> -       int r;
> >>
> >>         trace_amdgpu_dm_ism_commit(dm->active_vblank_irq_count,
> >>                                    vblank_enabled,
> >> @@ -315,16 +314,7 @@ static void dm_ism_commit_idle_optimization_state=
(struct amdgpu_dm_ism *ism,
> >>          */
> >>         if (!vblank_enabled && dm->active_vblank_irq_count =3D=3D 0) {
> >>                 dc_post_update_surfaces_to_stream(dm->dc);
> >> -
> >> -               r =3D amdgpu_dpm_pause_power_profile(adev, true);
> >> -               if (r)
> >> -                       dev_warn(adev->dev, "failed to set default pow=
er profile mode\n");
> >> -
> >>                 dc_allow_idle_optimizations(dm->dc, true);
> >> -
> >> -               r =3D amdgpu_dpm_pause_power_profile(adev, false);
> >> -               if (r)
> >> -                       dev_warn(adev->dev, "failed to restore the pow=
er profile mode\n");
> >>         }
> >>  }
> >>
> >> --
> >> 2.53.0
> >>
>
