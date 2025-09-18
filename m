Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A05CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 21:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791F910E1E0;
	Thu, 18 Sep 2025 21:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hvJXBqq2";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AB410E1E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 21:52:29 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2680ee37b21so2434765ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758232349; x=1758837149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mho0m3HkDA9hCqZXTOUm7uasRHSm+R/ny/5MIRzRDU8=;
 b=hvJXBqq2E9suaoi7rUG8BUwo/55KituVZrdv5AD/s5FoWq3s9OTay1nluUWFzHJeuO
 j/BcdzwOhkqJX4Pcadioh3AwNDL8OQHtLmVGzFu5YHb3CDaAGGK6pX91y48Qqg3e5RA/
 +FTC9bJxXxrZQn/qUitvgcam6oXkq1WOsqs0mKLNq7tcyQVTjMZgTLGdr8hrH886vhZD
 GXGck6+x+aK2rfkSqSDcre8I9XaD2YfI80ASFk/tDFvnqAOloSsYFzqV/KH3AnMdfI1B
 F0UtnI6Gnhgyfxagl8j/By0dluH58LePVemtaLYUoSDpqyeAH/ud4mReI7iom3P0DXe1
 Z0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758232349; x=1758837149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mho0m3HkDA9hCqZXTOUm7uasRHSm+R/ny/5MIRzRDU8=;
 b=rNNZL/vOTkrg9AFxBLLrOYjb08qJDayp7uy+s2wDHyrkdcGjIosWilUovqE3lP3jxa
 fuRz7gS8B5mLLml5LGBz64Fiydb0IG8IaDvwiCM/RJXG9bFfLsKMgJBfO7Kq786GLjON
 D6rC6rosXMh3zWIhKneqRcJrXXWKkHGXFitvtxugTYYuqtqUvpE3arCm06MWJJHELcey
 QX87TT1oFmTRCMT7lqUe7q0CtUG62MQ3veU5JnStfnBUvPfkcMTFJ+N2Yq+aj55NkRg8
 xgE6FUY7QCIBGTqN4zrM4dzI5HpuvKgM7qEnelD+4DVH/336SJQNrVpP73J9f59Syk5n
 HDxw==
X-Gm-Message-State: AOJu0YyQusSeqzi0La+Swvr8qhf+PE9UFPrkHxX4nOpmnO0zPreGdc4E
 47HPXgaxmFBtjo117FBqM42wc52dBaW4KtKSWl3yijrg+hSE0PIo6u1KH1jIKBcrDRtknt4mgy/
 VFcWC/2lgrCOIjvJ4KKagBeXWDKk94b8=
X-Gm-Gg: ASbGncvmLpIFQdopB9nvuP0B1PoHvvxDFHNQY774ntagCaZhVn6ZYp0I8uLA+UMncvK
 6Qt7FDXbOz6MFB/GKWWgbIKMJ9HY6z8E4nP2Hc/gycKyzt9vBy+55xNy2PJHovZtsg2QDPji3rw
 ykppPdRB8RO0QafOX1IO5DIHurbhjZIXBfgFC4NNWswMRthYh1lGQNK6deyA7wzvR09PKeMeFZX
 Ql93qpAtNMyYlOjqfiyKMXdHA==
X-Google-Smtp-Source: AGHT+IF4e7pVWJudPCRHhnw/Zr9Yt6OH+Am5LuFLYe/bS5HLyT8SSznBOSet4Md+Z4FbI+CiWFgGGweo5tQqoGKHO0Y=
X-Received: by 2002:a17:902:ecd2:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-269ba563fffmr7846045ad.11.1758232349112; Thu, 18 Sep 2025
 14:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250918184150.394532-1-mario.limonciello@amd.com>
 <CADnq5_M13ADiuoKKdgEyi=1MVbLJ9qCJKTHUPd+F+aLXUzwtDQ@mail.gmail.com>
 <c6ed9443-1465-489e-8c8d-d3c06604d97a@amd.com>
In-Reply-To: <c6ed9443-1465-489e-8c8d-d3c06604d97a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 17:52:17 -0400
X-Gm-Features: AS18NWAZQIerDDky9y4eTO28cEpenHiVN49mkkGXGUyauBbqxfJON-pvWiBf7Vc
Message-ID: <CADnq5_OvxeRL0F5qGDEVo5U6UrF3fJ5YXD6rwZ_ESWQ126Yx3g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Enable MES lr_compute_wa by default
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
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

On Thu, Sep 18, 2025 at 5:35=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 9/18/2025 2:05 PM, Alex Deucher wrote:
> > On Thu, Sep 18, 2025 at 2:59=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> The MES set resources packet has an optional bit 'lr_compute_wa'
> >> which can be used for preventing MES hangs on long compute jobs.
> >>
> >> Set this bit by default.
> >>
> >> Co-developed-by: Yifan Zhang <yifan1.zhang@amd.com>
> >> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Presumably this bit will be ignored on old firmwares?  If not, we'll
> > need a firmware version check.  Assuming this works correctly on old
> > firmwares,
>
> I'm assuming it does get ignored, but maybe Yifan can confirm it.

Might be good to add a FW version check anyway just in case and also
so that it's more obvious when the user has a new enough firmware to
contain the fix.

Alex

>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Alex
> >
> >> ---
> >> v2:
> >>   * drop module parameter
> >>   * add more description to commit text
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
> >>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 1 +
> >>   drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
> >>   drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
> >>   4 files changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/mes_v11_0.c
> >> index 3b91ea601add..540b514312b1 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> >> @@ -713,6 +713,8 @@ static int mes_v11_0_set_hw_resources(struct amdgp=
u_mes *mes)
> >>          mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
> >>          mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
> >>          mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> >> +       mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> >> +
> >>          if (amdgpu_mes_log_enable) {
> >>                  mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1=
;
> >>                  mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/mes_v12_0.c
> >> index 998893dff08e..01266eef65cb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> >> @@ -769,6 +769,7 @@ static int mes_v12_0_set_hw_resources(struct amdgp=
u_mes *mes, int pipe)
> >>          mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
> >>          mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
> >>          mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
> >> +       mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> >>
> >>          /*
> >>           * Keep oversubscribe timer for sdma . When we have unmapped =
doorbell
> >> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/g=
pu/drm/amd/include/mes_v11_api_def.h
> >> index 15680c3f4970..ab1cfc92dbeb 100644
> >> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> >> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> >> @@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
> >>                                  uint32_t enable_mes_sch_stb_log : 1;
> >>                                  uint32_t limit_single_process : 1;
> >>                                  uint32_t is_strix_tmz_wa_enabled  :1;
> >> -                               uint32_t reserved : 13;
> >> +                               uint32_t enable_lr_compute_wa : 1;
> >> +                               uint32_t reserved : 12;
> >>                          };
> >>                          uint32_t        uint32_t_all;
> >>                  };
> >> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/g=
pu/drm/amd/include/mes_v12_api_def.h
> >> index c04bd351b250..69611c7e30e3 100644
> >> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> >> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> >> @@ -287,7 +287,8 @@ union MESAPI_SET_HW_RESOURCES {
> >>                                  uint32_t limit_single_process : 1;
> >>                                  uint32_t unmapped_doorbell_handling: =
2;
> >>                                  uint32_t enable_mes_fence_int: 1;
> >> -                               uint32_t reserved : 10;
> >> +                               uint32_t enable_lr_compute_wa : 1;
> >> +                               uint32_t reserved : 9;
> >>                          };
> >>                          uint32_t uint32_all;
> >>                  };
> >> --
> >> 2.49.0
> >>
>
