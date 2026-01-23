Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E106D778AA
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 18:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C2310EB9F;
	Fri, 23 Jan 2026 18:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jIxez7JS";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39F610EB9F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 18:10:49 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1233ad1b4cdso263262c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:10:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769191849; cv=none;
 d=google.com; s=arc-20240605;
 b=ekEVwpOMbrGqbvksN9aXELNBYv7sNf87WgqboBuJUzUcdbdbWCOqi1SKDOXYxrOwIF
 2Ymb1HLDMHjmadTI8FPS9DGSiEIk/C5aZUCBFv1hQgbCE8lSN357eQDdzi7zgdYQt82Q
 2TKBzkSV7S5LN3TKH0GJZzmFHjvX7zmvPf8YeNe10GmFzKKe2L4bZ7DCYg7hYG5rP4Mj
 T8d0iT5NXKIfNJws1XSGItroplf6cyMQT/b2E1z2bNKcJW3Asl8Icg2H7P8S2E26nZIk
 hqCvO92J4gN7kMJmKKqk+odiIkzSGkkIzGiMtCeKtq7J5LARp4C6r+Vr/1bRnJCEHtob
 +LBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vaql0l49gV5B3V4JT/iqzY3yELhQQb2U1YohoLxMebQ=;
 fh=oqVBx5FTWq6Y6l6QqwBlQIYIP/+3S0CMoUuwD29Py7g=;
 b=gUQEB8kVlYTpCl+b/SDMAA4iMT0blI7yJQxMQX7uZg69X6TRAfF1UdgmK/WguH5/7K
 TW8fOdn7IVEhJmMfZF8DeA1eX0R55qJohBZqbDc4Ew9eGKDFq7XrDis9pco7ZyarcI7r
 EyxdsPZnX9gtv2e28JfLavP/K0Yfmr5HkUuzHul81Fv34cNLLyUTmIUwBzKBOtJu8bsa
 xkQU77BKf1qpIdPYxrwa3kB9N7G9kK2tpCk+mubGdz6wcQ1B2wCZdtC4lK50RFdOZal9
 xgbYygplSoketFbP/m2r3T2btP+7WuKm1aQJTP+fJD8jZzqlCOpZx0Fbh55pvquV29mF
 7Kpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769191849; x=1769796649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaql0l49gV5B3V4JT/iqzY3yELhQQb2U1YohoLxMebQ=;
 b=jIxez7JShwW+m51ZWjy5TRcEWARNHUtnBTvPiWJZf1XpCPuDWz0k6DQMrQNEPgxQ5I
 QNp0u//6+gOd3NW1sfw0JI/vCkXkmJVvN2sfNS1mLOM/B6N0hfwHvYWkrpWSZCdlARpr
 4SD0GA7QZS+oZ93r04U5mHVqi2vna3VWSHnlENd3WGYv+S7OlKD0G023KVoGc4UgSxnm
 5TiaJaTnSafctoYEXt+F1Yt6HCYIyCyw8/tsyPfAKXgfznWwD9XyOtNaITz46wtjVS48
 ZmGpGCSjFqkJ1gGImLbwQCGHn5dYHqUHU0nHdWxv37dP64mlmXQO22DvIpWrB6QreRR5
 yzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769191849; x=1769796649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vaql0l49gV5B3V4JT/iqzY3yELhQQb2U1YohoLxMebQ=;
 b=r56+mpRKgYqyK6YKKwyRLuYmlf84DeMxJSqAA0LtokRX7fqom/r3OS3dV3qs3iqR21
 RfbtA2B84kh58acAHdIlnpOPTH4W3yb9sROFCIiBzThGb4ENyI9cDgft3nZjP7qiC+Kg
 2dykH78EfR4Tc6f+xno0jik+ffq/E2hRDgTzk65jr0Xug2k6lljOpXa5xrd6vlGISFwm
 rL/KrFYbYvdqq23VkNd1IXqjzljr8/2Pc322pozCqd1fD4TJi3NQo8pibTfJKuCQ7kTC
 svRozjun+VXNcOXtQ2/CONlQx1yKDQT3jfEUFx6YJO9z3ucnjsUofgo2Z2tTX+dlW/R3
 2WWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLvxiTlNMFbB+9+q2OwTRm2dZ7QgY+GzYnm6suNcYfXM3yPFHYc57+kzKj3uRQ4GNKwBT1qlPI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdDdZnEpw9+JihPuCp0A2tcMtAkKmPY7UibDpm8HUs4vQyPGrT
 asW4x+AOkk8nYeG8j+fzLgSZsMnxZZfRkwqrGwA1DxGVBiYUFdYthEGFi/+1igzC9nId6C3p0Yq
 C6/9rKjaDkqrVntPwFeBeJPQXliLxmW8=
X-Gm-Gg: AZuq6aIJ7GMVqWKsj2X0siphhl5cn81ZK88+c0kvWkg1/e2plWokRuVmj8qI+9oSZLR
 otp65M/8kdNkBmJqJe9qsks5+cNZR+aha+NSKrqspy6z2mEGIwytgyqDoyTp+UCh+NABXEPp4ND
 e0ZGYuLCgISIaRxKYTC4P2NL07cJBxeo0Kmut1BqpUZY8AScfnOAdweIAOxj50JLyMBYimIb/BJ
 31SyivYu2lHtMdMXSgo0c70u3aGJ9Za2Km/doOrmjVJXeNUGhqG4hcSbcqzy5n8+uTrIulwcbve
 p+eOyhE=
X-Received: by 2002:a05:7300:cacd:b0:2b0:2e6:5363 with SMTP id
 5a478bee46e88-2b7399655a8mr953398eec.1.1769191849082; Fri, 23 Jan 2026
 10:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <20260123000537.2450496-2-someguy@effective-light.com>
 <CADnq5_O8guOxzHyEUn_x6pjrPG2xm_OgJWTCzvhzDYa-POtnoQ@mail.gmail.com>
In-Reply-To: <CADnq5_O8guOxzHyEUn_x6pjrPG2xm_OgJWTCzvhzDYa-POtnoQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 13:10:37 -0500
X-Gm-Features: AZwV_QgQRN19iCQrWPjdU_Avp2WR-crzHPu89EmRHBYdFvjLqKX-xaKce67lmH0
Message-ID: <CADnq5_O2nvAEPm654aD1g5EQDfHOpE82N1wLVtCBxveWyiHB1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: implement page_flip_timeout() support
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sunil Khatri <sunil.khatri@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ce Sun <cesun102@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Jan 23, 2026 at 12:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Fri, Jan 23, 2026 at 3:37=E2=80=AFAM Hamza Mahfooz
> <someguy@effective-light.com> wrote:
> >
> > We now have a means to respond to page flip timeouts. So, hook up
> > support for the new page_flip_timeout() callback.
> >
> > Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> > ---
> > Hi,
> >
> > I have tested this on 7940HS system and it appears even a MODE2 reset
> > will reset display firmware, so I don't think we need to force a full
> > reset here.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c      |  2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h      |  1 +
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 18 ++++++++++++++++++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_reset.c
> > index 28c4ad62f50e..bd63f0345984 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> > @@ -343,6 +343,8 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_cont=
ext *rst_ctxt, char *buf,
> >         case AMDGPU_RESET_SRC_USERQ:
> >                 strscpy(buf, "user queue trigger", len);
> >                 break;
> > +       case AMDGPU_RESET_SRC_DISPLAY:
> > +               strscpy(buf, "display hang", len);
> >         default:
> >                 strscpy(buf, "unknown", len);
> >         }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_reset.h
> > index 07b4d37f1db6..53b577062b11 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > @@ -44,6 +44,7 @@ enum AMDGPU_RESET_SRCS {
> >         AMDGPU_RESET_SRC_HWS,
> >         AMDGPU_RESET_SRC_USER,
> >         AMDGPU_RESET_SRC_USERQ,
> > +       AMDGPU_RESET_SRC_DISPLAY,
> >  };
> >
> >  struct amdgpu_reset_context {
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 697e232acebf..2233e5b3b6a2 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -28,6 +28,7 @@
> >
> >  #include "dc.h"
> >  #include "amdgpu.h"
> > +#include "amdgpu_reset.h"
> >  #include "amdgpu_dm_psr.h"
> >  #include "amdgpu_dm_replay.h"
> >  #include "amdgpu_dm_crtc.h"
> > @@ -578,12 +579,29 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crt=
c *crtc,
> >  }
> >  #endif
> >
> > +static void amdgpu_dm_crtc_handle_timeout(struct drm_crtc *crtc)
> > +{
> > +       struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
> > +       struct amdgpu_reset_context reset_context =3D {0};
> > +
> > +       if (amdgpu_device_should_recover_gpu(adev)) {
> > +               memset(&reset_context, 0, sizeof(reset_context));
> > +
> > +               reset_context.method =3D AMD_RESET_METHOD_NONE;
> > +               reset_context.reset_req_dev =3D adev;
> > +               reset_context.src =3D AMDGPU_RESET_SRC_DISPLAY;
> > +
> > +               amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> > +       }
>
> Rather than resetting the whole GPU here, does just suspending and
> resuming DC help?  E.g., call dm_suspend() and dm_resume(), but force
> the reset path (the amdgpu_in_reset() case) in those functions.  If
> that works, that should help narrow down where the problem is.

Actually does just calling drm_crtc_send_vblank_event() for all of the
relevant crtcs at this point help?

Alex

>
> Alex
>
>
> > +}
> > +
> >  /* Implemented only the options currently available for the driver */
> >  static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs =3D {
> >         .reset =3D amdgpu_dm_crtc_reset_state,
> >         .destroy =3D amdgpu_dm_crtc_destroy,
> >         .set_config =3D drm_atomic_helper_set_config,
> >         .page_flip =3D drm_atomic_helper_page_flip,
> > +       .page_flip_timeout =3D amdgpu_dm_crtc_handle_timeout,
> >         .atomic_duplicate_state =3D amdgpu_dm_crtc_duplicate_state,
> >         .atomic_destroy_state =3D amdgpu_dm_crtc_destroy_state,
> >         .set_crc_source =3D amdgpu_dm_crtc_set_crc_source,
> > --
> > 2.52.0
> >
