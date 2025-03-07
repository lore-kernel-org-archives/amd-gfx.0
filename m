Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EE6C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 14:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E05810E188;
	Fri,  7 Mar 2025 14:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HoY/0cuX";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5AA10E188
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 14:48:17 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so365412a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741358895; x=1741963695; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c18X160Exd4toTpoO5QoMvEBvvz1kt7ahXnnIdi7WdY=;
 b=HoY/0cuX8FZRWscuMkRJLCYWg9EwrX0JgoEHpYM23D/H+lkk87yqKB1kCAjTd06hFf
 JYCpHPcnO0S1hepll35k9INakiAYAKv7oTSo/rBOYXduVF/ZeygT0PbYj5lpPGjcx209
 AkiAS7Cq/zAxT32qDfwoyfVvmkfcxtj0kaQRWTiWVT1AOowf/ANywcait9UMFJs4SuYx
 iDPaD9iW7B5OWdsgPpfQ6VNqtf0k6rt9arqJTQTkLs6lkeAUe5aq8VXa84Sq22evnOP0
 ZCCDYhDH1XqSox+LTIYEn/kUwa/i/AeydbVXoeF5tGDgtOCU3gLi3eGK6FzoZR6Ntyjb
 skOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741358895; x=1741963695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c18X160Exd4toTpoO5QoMvEBvvz1kt7ahXnnIdi7WdY=;
 b=tnO+s5sERIEIwaC0DbJYiT8I78EVjTa7epUjEwnmQ/K/wRk8tm/UXJdwc1uf+bvtjk
 dbLlLEKVl9L/OhifHj7KJKanyBiedwXGywDdegaTTVcmjciemfPkcX6s35DvDFXUn1QL
 zFYPEg4CFYDI4NlJB6LA/+y3/fC+l0MF+6b6ZENUhIs2Oviy7WgubUtqxggsR374iaPp
 Hi9xqgfAqEQx0JWfzVO9cb7NWJ+m2Fxa/elIeLQkC8MtixTAJv5SBVsLSlEZyOBiE9K3
 /xkwR5z1IewY6aQZdS1JRVfy9weOarjk9VLWvthszt3P4SDhoEcPOLnaPHk99ooSpBGj
 rKmw==
X-Gm-Message-State: AOJu0YzTqlhvL5A+zHODX0dMqfKLX7OVstj4tA3zo0P14r2uxmtfjxpg
 vuVqytyUx9PBi5br4+80eyjMS2FruKHUVDzFuKWGinyGVHYTGYgcSolNQNp0DT8SA8lovg+pnt2
 +U5TbhkOnVHCnK0fiLYm3X6qe5iR7yepo
X-Gm-Gg: ASbGncvbsqHkCpM6n6AvnbVYbI9GFYo7cbDuCQ48fXFiIw21aWKIVBOLRUiWdMkFJDg
 zW6vGTyza+ovpOAbghFmJUyVd9mXwJZrL7pWZU8dbP3GnWxmtsAKWyygdpU/g+yKMtsMkuDH++z
 c20c5GXw7kbCIGqJhS1e/Qxtc33Q==
X-Google-Smtp-Source: AGHT+IGHrZR1VecY6M1P1xPAPoVPFNkdJKuzIdMLaPEUzn7zgxNHi8QS00CZQpDurix+4RL7CkrCD9aKq7x1P71bdL8=
X-Received: by 2002:a17:90b:350d:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-2ff7cf13ae5mr2161599a91.3.1741358894780; Fri, 07 Mar 2025
 06:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20250307034457.595790-1-kenneth.feng@amd.com>
In-Reply-To: <20250307034457.595790-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Mar 2025 09:48:03 -0500
X-Gm-Features: AQ5f1Jrf4J4eUyypH9oQLYJhWdmO4GO__Gj_0zkrzM4QZLv7P8gf5xgsCr9WA_g
Message-ID: <CADnq5_OH7iumFq2MJ_LjpAwYzf34G60dUh_rug6HWBrkq=8Xxg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: reset the workload type when using MALL
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com, 
 alexander.deucher@amd.com
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

On Thu, Mar 6, 2025 at 10:45=E2=80=AFPM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> Reset the workload type when using MALL.
> When there is no activity on the screen, dal requestes dmcub
> to use MALL. However, gfx ring is not empty at the same time.
> Currrently the workload type is set to 3D fullscreen when gfx
> ring has jobs. No activity on the screen and the gfx ring empty
> state can not be synchronized to each other. By removing the
> 3D fullscreen workload when there is no activity on screen, the
> event can be passed down to dmcub->pmfw, since pmfw only allows
> MALL when the workload type setting is bootup default, then MALL
> can be really used. And this does not impact the thread to detect
> the ring jobs and can set back to the 3D fullscreen later.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 36a830a7440f..154936166896 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -244,6 +244,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(stru=
ct work_struct *work)
>         struct vblank_control_work *vblank_work =3D
>                 container_of(work, struct vblank_control_work, work);
>         struct amdgpu_display_manager *dm =3D vblank_work->dm;
> +       int r;
> +       struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
>
>         mutex_lock(&dm->dc_lock);
>
> @@ -271,8 +273,14 @@ static void amdgpu_dm_crtc_vblank_control_worker(str=
uct work_struct *work)
>                         vblank_work->acrtc->dm_irq_params.allow_sr_entry)=
;
>         }
>
> -       if (dm->active_vblank_irq_count =3D=3D 0)
> +       if (dm->active_vblank_irq_count =3D=3D 0) {
> +               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_FULLSCREEN3D, false);

To keep this balanced, you should get a reference when we disable the
optimizations.  Also if ROCm applications are running, the compute
profile will be active so that should be decremented too or if VCN
jobs are running the video profile may be active as well.  On the
other hand, if users have apps running when the display is off, maybe
they don't want the idle optimizations in the first place.
Alternatively, we could have a suspend/resume workload profile
function that sets a flag in sw_smu which sets the default workload
profile and skips all updates to the workload profile while that flag
is set.  The swsmu will still track the ref counts and then when we
resume the workload profile handling, we can restore all of the
workloads profiles based on the ref counts.

Alex


> +               if (r)
> +            dev_warn(adev->dev, "(%d) failed to disable fullscreen 3D  p=
ower profile mode\n",
> +                                        r);
> +
>                 dc_allow_idle_optimizations(dm->dc, true);
> +       }
>
>         mutex_unlock(&dm->dc_lock);
>
> --
> 2.34.1
>
