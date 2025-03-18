Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E45C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B934310E485;
	Tue, 18 Mar 2025 13:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z4J4jHhh";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2DA10E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:12:06 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-22409402574so12133955ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303522; x=1742908322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etHhf7wv2rIrm0C17+/cA5MO96kyMOIWaHzeDVbPzCM=;
 b=Z4J4jHhh45JoxWaTDZjan9/hTs5W7Ey+m6EpyxDbGec1fy2FPAvMnNHUU6WEzX3IEM
 2Fw0rLUzttO6QCaYYr2Ac2Y/1StkINa4QD/ooN850C6dnAXpNXIiyTVcUPm8/zFyiBoz
 cQ+pEIYRgte7tcHDfBC6yp1A/SKkqNxeHxHioGnr2Jio0sPHiHEj8bbehoBRcDux4b0f
 +4nrfKQ1Cp75tLBlQgrkuqD8qiOclm0oALyMNK+esf1mDNDNvqY+N9gOZQ02slff76Wc
 0/KAAO+86733XGWwswyjAaD03jImd6JGYRA1tDpKqVrx9KyRzLx9AUGbigtwtOdPtR2y
 oWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303522; x=1742908322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etHhf7wv2rIrm0C17+/cA5MO96kyMOIWaHzeDVbPzCM=;
 b=EyXZ9NKit2t0aQojF3mUVrtOCySwAryNzdVpcjVEZXWZzLWF8kWIqcCJOHG2tW8Rhp
 0eXwevE56JMeMjr6yFJBOx7Pgs5xRA4hJXH6KIpPFNofrCByfOdWRaqyRbHt0q85QwBs
 wd4COLAtYG5Xiw1qc15y28aEG0eAB0DLlbNdt56taEgUspVS1k5UwMoIxAVSupRqBTsY
 Vfz+UDjFbADoRWAZgxsR8d6yV4X9Xkk4sw+czBij7LFwKc2oINo5YyL5ghNdy2LBelR7
 Ew/9ZaUN0AtN4yH63g/uywxwmcQbbvqEzRMIySCb61mpxrwUDDGrAtR7krAo2I2oWjnq
 RrzQ==
X-Gm-Message-State: AOJu0Yw/GVYYBMVY0SFMb9dyYkCthdgBXABFyfxj9NV1XvmU7j9R/ZIe
 IG21JgrWEg8DQZOl7vEnj9vjof8/oVCQxMJdx9Dp5jZERbpaaDRQ2x0F0HpV7FfNETEMzGbLCe/
 98DiYTgrmx7wkWN0MB+m8UvifoQw=
X-Gm-Gg: ASbGncuBBFDZXaS8+ivRy3q7KfQpxxc8U53QjMJdTFocblX74TPtRrKoebtX1OFsuJ6
 32wz1KSVQr3mzEaitHT6eDoHMlAf1jJADnwbuOi/Jim3MquZsTA3B3fcAaS0WCSCuAEoLROCvQh
 KlbXAp/oZsw9DTIdASxkhsfwxSYg==
X-Google-Smtp-Source: AGHT+IHlmPAxD1atNxxjH6eTuJBFoxsi5MBrougZrpW+abCSa96tbHQ/ARrQSdxYNrmd8xtyG7PWIjD+Ea7itWhfFzI=
X-Received: by 2002:a17:902:f68c:b0:220:cddb:5918 with SMTP id
 d9443c01a7336-225e0afb3aemr72989645ad.9.1742303522096; Tue, 18 Mar 2025
 06:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250317144734.810595-1-alexander.deucher@amd.com>
In-Reply-To: <20250317144734.810595-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 09:11:50 -0400
X-Gm-Features: AQ5f1JpH7Wj9h7me_11b0lp2Hyzky-SDHyrVZUsxabrZacsoJS7lImS1vv_C_hE
Message-ID: <CADnq5_Mpn9UKgoP-x9FE7=kyAzTR2oC96mO7Df7kRDr1V1zaXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: adjust workload profile handling
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Mon, Mar 17, 2025 at 10:57=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> No need to make the workload profile setup dependent
> on the results of cancelling the delayed work thread.
> We have all of the necessary checking in place for the
> workload profile reference counting, so separate the
> two.  As it is now, we can theoretically end up with
> the call from begin_use happening while the worker
> thread is executing which would result in the profile
> not getting set for that submission.  It should not
> affect the reference counting.
>
> v2: bail early if the the profile is already active (Lijo)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 ++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 28 ++++++++++++++++---------
>  2 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 6b410e601bb65..1991dd3d1056a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -460,18 +460,26 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
>
>         atomic_inc(&vcn_inst->total_submission_cnt);
>
> -       if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
> -               mutex_lock(&adev->vcn.workload_profile_mutex);
> -               if (!adev->vcn.workload_profile_active) {
> -                       r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
> -                                                           true);
> -                       if (r)
> -                               dev_warn(adev->dev, "(%d) failed to switc=
h to video power profile mode\n", r);
> -                       adev->vcn.workload_profile_active =3D true;
> -               }
> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +       cancel_delayed_work_sync(&vcn_inst->idle_work);
> +
> +       /* We can safely return early here because we've cancelled the
> +        * the delayed work so there is no one else to set it to false
> +        * and we don't care if someone else sets it to true.
> +        */
> +       if (adev->vcn.workload_profile_active)
> +               goto pg_lock;
> +
> +       mutex_lock(&adev->vcn.workload_profile_mutex);
> +       if (!adev->vcn.workload_profile_active) {
> +               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> +                                                   true);
> +               if (r)
> +                       dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
> +               adev->vcn.workload_profile_active =3D true;
>         }
> +       mutex_unlock(&adev->vcn.workload_profile_mutex);
>
> +pg_lock:
>         mutex_lock(&vcn_inst->vcn_pg_lock);
>         vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index b4b8091980ad5..d716510b8dd68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -169,18 +169,26 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_r=
ing *ring)
>
>         atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
>
> -       if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
> -               mutex_lock(&adev->vcn.workload_profile_mutex);
> -               if (!adev->vcn.workload_profile_active) {
> -                       r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
> -                                                           true);
> -                       if (r)
> -                               dev_warn(adev->dev, "(%d) failed to switc=
h to video power profile mode\n", r);
> -                       adev->vcn.workload_profile_active =3D true;
> -               }
> -               mutex_unlock(&adev->vcn.workload_profile_mutex);
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +
> +       /* We can safely return early here because we've cancelled the
> +        * the delayed work so there is no one else to set it to false
> +        * and we don't care if someone else sets it to true.
> +        */
> +       if (adev->vcn.workload_profile_active)
> +               goto pg_lock;
> +
> +       mutex_lock(&adev->vcn.workload_profile_mutex);
> +       if (!adev->vcn.workload_profile_active) {
> +               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> +                                                   true);
> +               if (r)
> +                       dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
> +               adev->vcn.workload_profile_active =3D true;
>         }
> +       mutex_unlock(&adev->vcn.workload_profile_mutex);
>
> +pg_lock:
>         mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
>         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VC=
N,
>                                                AMD_PG_STATE_UNGATE);
> --
> 2.48.1
>
