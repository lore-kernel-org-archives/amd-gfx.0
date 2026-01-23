Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E83D7789E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B707910E2D9;
	Fri, 23 Jan 2026 17:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JCNCm/Nx";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AFD510E2D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:49:19 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12336c0ae91so286480c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 09:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769190559; cv=none;
 d=google.com; s=arc-20240605;
 b=kDV6r9CIzOroeWMqvZb4byHssL9d510bESyWF5dxZvO6VORk6vs0zGUsYEsoHjBMGV
 rgvRQ2GPrKceQzpLo7xUrIaX+5ltpL3HM8398uwe57MBt34HqOHOWYwyJfDAqYK/xHr5
 iFji30Oo8Dr2Ml/X8vaU4zYvLTHRaT+jGKpw7KUCCVdDoFNE5srDTjkHwSiyDG+u8m/1
 orBYnPGm2WikjVDyoRkYYGi3K9w3Zc6ATgJL4eUCNjqpalj9OsPUTkbsZoleJ725TgCI
 XXQosyj5OZCEmLBgtiN8TLH/B2kCEDYggb3LHqB9U/QuocsNyPTjvQzss7Ti1K6PpfkR
 Xx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H4geAyuRV3L2A55ENiOqVPJISTgk75Uun8WE1iNkT/g=;
 fh=+mtZjOX+CSvYphNffs6X0jnG4ejOLYeKEyEq+Ms46hY=;
 b=L/cr4qzSgiPt5dcYZGNuKxSYXbZLn4hn7XDqTPprLVcZnVc/5+ZQenIfMw1SC3GUg8
 Z4HXTbcipYpj2SMifHf25ZCVNFjGFT5QJN1o04YSNiC3QCjh+z0YxZakMBmdkGFzhpMN
 Iz+l2mZ/NQQ1JVQ8uGqmMJAC90qCFdIrwWo/793WtrhyDlr+rhb7HV2DKeGgJGHDAfUr
 G7cOR7n2DbKFDFkP2IggqdbLVvsRar9414DJ8Kssr9qEbIwfou3CDP+O6gFhMnyj2+kE
 AltlZENta6HLgAdEE+AA8dOdjvPBSrqmQUE28V8ka8DHkUxotG128ukMNtmy73QySZYx
 kpDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769190559; x=1769795359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4geAyuRV3L2A55ENiOqVPJISTgk75Uun8WE1iNkT/g=;
 b=JCNCm/NxeU/18ixCwZEUtW4GGhouGz9t0sL9L9/S7VKLORvfOTcFj5bS7jyzoY5TlQ
 RGhqRMY8EuxmEYhravQYU8X+oc3dRAfA4KrNk6Mt3237CxppXzFS3hw6pEORXk4RbTDN
 NZq+SjcEcZzLbvTxpNB+p/O8AT8Jfo23g9ueKPmp6eNl6D5x9VIcD2bW61pgDBOK+rSj
 bOTzeCycCCWPBGQaH2CBz5NIXiD0qAIUyA6vFFFlLiXlfmNUEak0xK4apE/QSS2HfMgf
 h5t3S9/gF8zDRsubEJ+NwD/bel8MRbBHiIYjok8Vw3cX2YSENbolq8xCTALuJQatX7qf
 hmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769190559; x=1769795359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H4geAyuRV3L2A55ENiOqVPJISTgk75Uun8WE1iNkT/g=;
 b=PPGfFCPP5ShZxIvu/PmH6onpAUC2kAb8nSq0UmNec68wmgoRHadRAPCxTxHrok6laf
 J/d8nILFEBytPgwFsm7yiWN+5unIqftrvsvCs/Ezjd6ET4T2R8Pd1ffPBYGWJia1yUbW
 KVa565/NWzqap7t4OMqlX0L7fliYGMg/tk/R3i3HET2W6x4gz+bUi5hGA0eR/5187m0+
 c24ez/5nFZXoR1DgW5fMOZXF7kovCYtNg1GSRfk5mOIFqPzmG8ivFyofwvjApvJpX7en
 YHvhenP7Y0qgTgHv7xPvYjKZatRV7as/HcPUv7XzYoxXTVO7Zk1Xr2eqm3tO1EpjltX8
 xURg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw/JApqMO+jYKGK6KA/fTbnSWunqqFbqLLwaBtmr7HEOlDOScV5aYlr9WuZPIIikmeTQOLUcAv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHWRtw2+Wpm/BmCSW6pHesGW84FFJLeYsMl6/cXUMwJeS7OjOc
 ze4Eb+RRl1E1oFicpq7kFsMKr8yOCZ+jTxjgCe7sK8ius2UnoiDb4oUpWARbiIIVtOnugW+6JJH
 AggcZN4/nZhHT5uzqlq9VMU0YS09mxNA=
X-Gm-Gg: AZuq6aKchGuAOC+x33Hwa/IWculNKErDQx9PRsSNEbgvGEnXeoas4u6ojh0jFwidq5K
 IQ3EXxFvV6ygDwp8r/kv1Y1t4lKAvepJVIieQ0jpP2GwjwycxjkRzsT57gY0pw6a+jX3SuNsA9B
 BVQN8EUSYaif4YxWcneMKvIk0cj0nOiwz2XDf3aWN1/0zLflP/fbivugnFosu56BQUMrPWaT+kY
 x8erd0WmZk0fk8KdL7pIcCMzj1MjUQX366vzo22NcnSMWzTG62erZouaf75lYv0lrEJPq6T
X-Received: by 2002:a05:7022:e08:b0:123:308f:667b with SMTP id
 a92af1059eb24-1247dbb12bdmr1102484c88.2.1769190558509; Fri, 23 Jan 2026
 09:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <20260123000537.2450496-2-someguy@effective-light.com>
In-Reply-To: <20260123000537.2450496-2-someguy@effective-light.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 12:49:07 -0500
X-Gm-Features: AZwV_Qgz341wiZBc4dCsfNwGUWjzf2Qg8Y2SqPANEwcuh1YAs3llykUX0i1R1t8
Message-ID: <CADnq5_O8guOxzHyEUn_x6pjrPG2xm_OgJWTCzvhzDYa-POtnoQ@mail.gmail.com>
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

On Fri, Jan 23, 2026 at 3:37=E2=80=AFAM Hamza Mahfooz
<someguy@effective-light.com> wrote:
>
> We now have a means to respond to page flip timeouts. So, hook up
> support for the new page_flip_timeout() callback.
>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
> Hi,
>
> I have tested this on 7940HS system and it appears even a MODE2 reset
> will reset display firmware, so I don't think we need to force a full
> reset here.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c      |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h      |  1 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 28c4ad62f50e..bd63f0345984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -343,6 +343,8 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_contex=
t *rst_ctxt, char *buf,
>         case AMDGPU_RESET_SRC_USERQ:
>                 strscpy(buf, "user queue trigger", len);
>                 break;
> +       case AMDGPU_RESET_SRC_DISPLAY:
> +               strscpy(buf, "display hang", len);
>         default:
>                 strscpy(buf, "unknown", len);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.h
> index 07b4d37f1db6..53b577062b11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -44,6 +44,7 @@ enum AMDGPU_RESET_SRCS {
>         AMDGPU_RESET_SRC_HWS,
>         AMDGPU_RESET_SRC_USER,
>         AMDGPU_RESET_SRC_USERQ,
> +       AMDGPU_RESET_SRC_DISPLAY,
>  };
>
>  struct amdgpu_reset_context {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 697e232acebf..2233e5b3b6a2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -28,6 +28,7 @@
>
>  #include "dc.h"
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_dm_psr.h"
>  #include "amdgpu_dm_replay.h"
>  #include "amdgpu_dm_crtc.h"
> @@ -578,12 +579,29 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc =
*crtc,
>  }
>  #endif
>
> +static void amdgpu_dm_crtc_handle_timeout(struct drm_crtc *crtc)
> +{
> +       struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
> +       struct amdgpu_reset_context reset_context =3D {0};
> +
> +       if (amdgpu_device_should_recover_gpu(adev)) {
> +               memset(&reset_context, 0, sizeof(reset_context));
> +
> +               reset_context.method =3D AMD_RESET_METHOD_NONE;
> +               reset_context.reset_req_dev =3D adev;
> +               reset_context.src =3D AMDGPU_RESET_SRC_DISPLAY;
> +
> +               amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +       }

Rather than resetting the whole GPU here, does just suspending and
resuming DC help?  E.g., call dm_suspend() and dm_resume(), but force
the reset path (the amdgpu_in_reset() case) in those functions.  If
that works, that should help narrow down where the problem is.

Alex


> +}
> +
>  /* Implemented only the options currently available for the driver */
>  static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs =3D {
>         .reset =3D amdgpu_dm_crtc_reset_state,
>         .destroy =3D amdgpu_dm_crtc_destroy,
>         .set_config =3D drm_atomic_helper_set_config,
>         .page_flip =3D drm_atomic_helper_page_flip,
> +       .page_flip_timeout =3D amdgpu_dm_crtc_handle_timeout,
>         .atomic_duplicate_state =3D amdgpu_dm_crtc_duplicate_state,
>         .atomic_destroy_state =3D amdgpu_dm_crtc_destroy_state,
>         .set_crc_source =3D amdgpu_dm_crtc_set_crc_source,
> --
> 2.52.0
>
