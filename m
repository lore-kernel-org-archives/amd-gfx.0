Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71610CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 21:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123FD10E00A;
	Mon, 18 Aug 2025 21:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2HhGkC6";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6658B10E00A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 21:16:43 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-24457f4ff1aso4479245ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755551803; x=1756156603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICTWtpDWBIOdfX18NWMjoyrYm0UY7iPTB/okMRiPOyM=;
 b=Y2HhGkC6cSmp0OEqTpWvZN1jYzvwFXl1dCK18H/2guHgTuv/QPp41VgXo8sI5qDSpx
 29sn89nWOU2xPgTuIGeIjWsKexWJMX6tXJm2FfLJRsBAylEcQrHE1RQL08VHa0jvlBEm
 X8uEwt10xjhsgSQWVcAGCtmpl50dJXTyttPTNDkKSzEmbg2VxV0qHJc2gMNlvgLLT8Gg
 +WIBqVfRs4B8n5LtYwTR2gSB9KDFdshG9cOqc68854xrvlYLQO2BE+/9jZOiZ3osi2Ye
 /lZitTQWX3HpARDHYnXzC7ZcZDyOwE6/cxUjgxUS5XWD5B8yFgOKpSCftaOO0PvCnivW
 4FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755551803; x=1756156603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICTWtpDWBIOdfX18NWMjoyrYm0UY7iPTB/okMRiPOyM=;
 b=iOylAAmHLih4OamnvE+pTk7ctwTNvTRdRz1MN+l6y0cy21LA+qUfL912PkX7A7dPWq
 5kSOfV9RkuxsBKGXEL6foZWxvaQGHhg1NyNZVRZnFAPwbLKP8v5VCa36JzybDMjkCfHe
 zGNBY6SQ8fxTYCdfIOM5i7hVvMqhty2IXXXdsfhA7cb8DoTmYjqoqYFI1TgtKFBhPCWu
 racKlKn8RlK9uWeSPARKsdyg9i3qd4jKDsOzqLThTsvm1FEXk11DFbpn3RKSrEToINBA
 3DdlI+Htimk3gIm6dTZ3gKac3L4UEV1Us+rBtypUBdg+TgDljcEHlo8bLDdi33zqtpbA
 uu7A==
X-Gm-Message-State: AOJu0Yw/U+nZbXKah6yvSi3TwxC0CgnyOYJPPUbVaC8QNu1oaTyIRsfi
 TQO1AOXZvYX3zRhCSzZiHXQYaOeYLquf4//FQQI3u/Mk4rZMQ7jooH6/e4E0c+YRaDuSj5XnBxF
 1FfVV+YKaoLuZl/FXSgx9vEvosmKM7ynMSU2x
X-Gm-Gg: ASbGnct4roJLkIuZi+9tvnHt5qmyZvXSjGuzwwbGodsAsBbJFXfTTqg0hDOnIF4kja+
 rJua1MXO8PfA+rCrS+CX792XuQNuoFTb5OSKleLZnNA/uxpyLmQ7OX5A8eQ15JkwpMI/U6KV2yh
 mIyS04wGrMCbPRDMK5huQLxvOcCzAuwx8b5rXgejYMCdyrN7LSdT9x+xgX4ei25MkQCR7h/lhi6
 odHgs695R6mFQPSMg==
X-Google-Smtp-Source: AGHT+IFQlVSdHE+Zp2mtWPQCJE5ae+kRcNF7HrknuOgQx6D/42Z95ObPmNxM1QensE16QYZ9hhziTxx9GunnouXCrYA=
X-Received: by 2002:a17:902:c409:b0:240:52d7:e8a4 with SMTP id
 d9443c01a7336-245e0485efamr714295ad.7.1755551802810; Mon, 18 Aug 2025
 14:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250813232532.2661638-1-alex.hung@amd.com>
 <20250813232532.2661638-8-alex.hung@amd.com>
In-Reply-To: <20250813232532.2661638-8-alex.hung@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 17:16:31 -0400
X-Gm-Features: Ac12FXzaZmIQBfOEnZFv--MByaafijKy7lNSBuU5wYmK-C5nWS5hGdfT9BxCk1g
Message-ID: <CADnq5_NhgCORJE6YqiWfS8qX2FK6b9y8dHjHf1quXrUP_MrFMw@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amd/display: Attach privacy screen to DRM
 connector
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, Aug 13, 2025 at 7:33=E2=80=AFPM Alex Hung <alex.hung@amd.com> wrote=
:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> [WHY]
> If a system has a privacy screen advertised by a driver it should
> be included in the DRM connector for the eDP panel.
>
> [HOW]
> Detect statically declared privacy screens when creating eDP connector
> and attach privacy screen DRM properties.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e8cfae2bd2ae..176f420effd9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -80,6 +80,7 @@
>  #include <linux/component.h>
>  #include <linux/sort.h>
>
> +#include <drm/drm_privacy_screen_consumer.h>
>  #include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/display/drm_hdmi_helper.h>
>  #include <drm/drm_atomic.h>
> @@ -7846,6 +7847,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connec=
tor *conn,
>         if (!crtc)
>                 return 0;
>
> +       if (new_con_state->privacy_screen_sw_state !=3D old_con_state->pr=
ivacy_screen_sw_state) {
> +               new_crtc_state =3D drm_atomic_get_crtc_state(state, crtc)=
;
> +               if (IS_ERR(new_crtc_state))
> +                       return PTR_ERR(new_crtc_state);
> +
> +               new_crtc_state->mode_changed =3D true;
> +       }
> +
>         if (new_con_state->colorspace !=3D old_con_state->colorspace) {
>                 new_crtc_state =3D drm_atomic_get_crtc_state(state, crtc)=
;
>                 if (IS_ERR(new_crtc_state))
> @@ -8541,6 +8550,18 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>                 if (adev->dm.hdcp_workqueue)
>                         drm_connector_attach_content_protection_property(=
&aconnector->base, true);
>         }
> +
> +       if (connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {

Do the privacy screens exist on any old laptops with LVDS?  If so, we
should add DRM_MODE_CONNECTOR_LVDS here as well.

Alex

> +               struct drm_privacy_screen *privacy_screen;
> +
> +               privacy_screen =3D drm_privacy_screen_get(adev_to_drm(ade=
v)->dev, NULL);
> +               if (!IS_ERR(privacy_screen)) {
> +                       drm_connector_attach_privacy_screen_provider(&aco=
nnector->base,
> +                                                                    priv=
acy_screen);
> +               } else if (PTR_ERR(privacy_screen) !=3D -ENODEV) {
> +                       drm_warn(adev_to_drm(adev), "Error getting privac=
y-screen\n");
> +               }
> +       }
>  }
>
>  static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
> @@ -10265,7 +10286,7 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)
>         unsigned long flags;
>         bool wait_for_vblank =3D true;
>         struct drm_connector *connector;
> -       struct drm_connector_state *old_con_state, *new_con_state;
> +       struct drm_connector_state *old_con_state =3D NULL, *new_con_stat=
e =3D NULL;
>         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>         int crtc_disable_count =3D 0;
>
> @@ -10383,6 +10404,8 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)
>                                             &stream_update);
>                 mutex_unlock(&dm->dc_lock);
>                 kfree(dummy_updates);
> +
> +               drm_connector_update_privacy_screen(new_con_state);
>         }
>
>         /**
> --
> 2.43.0
>
