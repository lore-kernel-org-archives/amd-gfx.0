Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B37DD68BE4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE93110E43F;
	Thu, 18 Dec 2025 13:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qeing0UR";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D651010EDB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 10:33:59 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-34c565c3673so762726a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766054039; x=1766658839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuK9WwWvBqgInm1BIzIhXwkI3depHkjpZcUB/hLhtwY=;
 b=Qeing0URiVC4785YBI4h9x/rFUgVkidmKK/aur8JaU7SxGnF/4homnHgF/rZnuQ0fe
 3re7rABhLnw5VJPwCOuzs12ueaYE6TDPEbo4nOGihT0V4rkiK7kPV1lrr88S4BwlpfFL
 EpRmsw5kObneSIChyWY1cJ8redUiPqvbGti3oknREMnrVAf41YhwpmwwQSvcZ6pvhI+0
 AWqG4nYtRKL58r81T87fgSexmtCcHaliCgFmBqFMs07rZtV4/UMZbbWuL65hc3CPn9l1
 BB5jGjo4gJXmhspK9eOzhIzOw5Y7yw1xObyjJxM0gjorsimtYFD0o50DcAzB9mHf7t5d
 ogug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766054039; x=1766658839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PuK9WwWvBqgInm1BIzIhXwkI3depHkjpZcUB/hLhtwY=;
 b=k38WS4xl9Hg9Bhb9+ehFU4vl2fkl/yy1sHdU+EPyfdAHJ13iPUTOnoZTGrtvmRFVPc
 S4FmDeyejwpAIMQW+5dLaRxSTIZFHXyLIdGXgRTk6EMccRSd7hP59ChnJKeGOZfmuh8T
 JiPSrM03ahgDIQEE4R4Idy0o+EIFw6/w7KcGW1thxmmqQAkUFLc3ANkUTdxdC3k1a7Qg
 CXXqJg70x7HEgxmkFTS+n4JngSZlmn8JsKvfWE9aHhYsxHk0NHyLwFC04ldY2RxFnf2V
 9B4r6gwswA+U/dvXENpsE0baRy1eIFvHXEccTDAWOjaFXduxCV/dsfzeQaIBTUrJJzlm
 1YtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGjJW6Kny90NUB9wSEGIuoNYNe2Axz8JZJiuCKJa1xXqIup/2VkjRrG/Km1KlGAvH+rZ3xVv3G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ+nwT1g3/x/GceUJMzwpg7YyghCcfvsQYA6m39LHInbNfV/I8
 ePERCpSQ22e4ERBta7rzWRvUXz2DdvNo+SImv75vwItbBS0co4t4n1t+1zc2z7nkT88W2dr90/M
 oGFly2a4yOVosaEOyB7MYfymbQq1anhg=
X-Gm-Gg: AY/fxX4FnAtJ6dsZ5kJLMwXnjg9eTH1DOknCcTwwFHbAyd41m9BfnMLohkOOElBvoA5
 rqgJspYaZ2yNbdZ2F0DR2TqKbDVisKzvORnJ7c0w/uNV9fBfdPiuHlCuwFoa7oxXWlb7kM5ugKR
 xk1A6EA3RwUV8Wgt3zxubETBt9aWQMKa8upxP/wTDdywTbk1fOlePjmYkzDXoCVESmpIAUzw5PX
 dQ4JhMYT6VoFRP20IR6r+NJEcsjCdEDSLI2mtgbINP9xWcmCAdQO+GVf1368ReV9ux83tMQ
X-Google-Smtp-Source: AGHT+IEM7YjAFoRUbtqDUuyhIshesOes+5EPz1w0oXJV4R4bDCVtwKzj2iHfvGmbDL/MSeIMtVL5zrTipFvP5HtZm98=
X-Received: by 2002:a17:90b:1348:b0:34c:ab9b:837c with SMTP id
 98e67ed59e1d1-34e7151d99bmr2324293a91.0.1766054039265; Thu, 18 Dec 2025
 02:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20251218063512.4572-1-suryasaimadhu369@gmail.com>
 <2ef1292d-22e8-4ec0-8316-00ae482b54a8@amd.com>
In-Reply-To: <2ef1292d-22e8-4ec0-8316-00ae482b54a8@amd.com>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 18 Dec 2025 16:03:48 +0530
X-Gm-Features: AQt7F2p8z17w0Wc9RfyHY_6TYGwVEB_wSFo20On1Zp9IBq4X0hEXAfQvl5BvpNA
Message-ID: <CAB0uMAfwMURUEtN2qJQKCDxDFPnHz3DwAKUGDwKSr_nhLPDhPg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dm: Convert IRQ logging to drm_* helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 siqueira@igalia.com, mario.limonciello@amd.com, wayne.lin@amd.com, 
 roman.li@amd.com, timur.kristof@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:38:39 +0000
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

Hi Christian,



Thanks for the review.



You're right =E2=80=94 that change is unrelated to the logging conversion.
I'll drop it and resend the patch as v4.


On Thu, 18 Dec 2025 at 15:49, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
>
>
> On 12/18/25 07:35, suryasaimadhu wrote:
> > Replace DRM_ERROR(), DRM_WARN(), and DRM_INFO() usage in
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c with the
> > corresponding drm_err(), drm_warn(), and drm_info() helpers.
> >
> > The drm_* logging helpers take a struct drm_device * as their first
> > argument, allowing the DRM core to prefix log messages with the
> > specific device name and instance. This is required to correctly
> > differentiate log messages when multiple AMD GPUs are present.
> >
> > This aligns amdgpu_dm with the DRM TODO item to convert legacy DRM
> > logging macros to the device-scoped drm_* helpers while keeping
> > debug logging unchanged.
> >
> > v2:
> > - Keep validation helpers DRM-agnostic
> > - Move drm_* logging to AMDGPU DM callers
> > - Use adev_to_drm() for drm_* logging
> >
> > Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> >
> > diff --git a/Makefile b/Makefile
> > index 2f545ec1690f..e404e4767944 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1,8 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  VERSION =3D 6
> > -PATCHLEVEL =3D 18
> > +PATCHLEVEL =3D 19
> >  SUBLEVEL =3D 0
> > -EXTRAVERSION =3D
> > +EXTRAVERSION =3D -rc1
> >  NAME =3D Baby Opossum Posse
> >
> >  # *DOCUMENTATION*
>
> That here clearly doesn't belong into the patch.
>
> Apart from that looks ok to me.
>
> Regards,
> Christian.
>
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > index 0a2a3f233a0e..60bf1b8d886a 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > @@ -242,35 +242,29 @@ validate_irq_registration_params(struct dc_interr=
upt_params *int_params,
> >                                void (*ih)(void *))
> >  {
> >       if (NULL =3D=3D int_params || NULL =3D=3D ih) {
> > -             DRM_ERROR("DM_IRQ: invalid input!\n");
> >               return false;
> >       }
> >
> >       if (int_params->int_context >=3D INTERRUPT_CONTEXT_NUMBER) {
> > -             DRM_ERROR("DM_IRQ: invalid context: %d!\n",
> > -                             int_params->int_context);
> >               return false;
> >       }
> >
> >       if (!DAL_VALID_IRQ_SRC_NUM(int_params->irq_source)) {
> > -             DRM_ERROR("DM_IRQ: invalid irq_source: %d!\n",
> > -                             int_params->irq_source);
> >               return false;
> >       }
> >
> >       return true;
> >  }
> >
> > -static bool validate_irq_unregistration_params(enum dc_irq_source irq_=
source,
> > -                                            irq_handler_idx handler_id=
x)
> > +static bool validate_irq_unregistration_params(
> > +     enum dc_irq_source irq_source,
> > +     irq_handler_idx handler_idx)
> >  {
> >       if (handler_idx =3D=3D DAL_INVALID_IRQ_HANDLER_IDX) {
> > -             DRM_ERROR("DM_IRQ: invalid handler_idx=3D=3DNULL!\n");
> >               return false;
> >       }
> >
> >       if (!DAL_VALID_IRQ_SRC_NUM(irq_source)) {
> > -             DRM_ERROR("DM_IRQ: invalid irq_source:%d!\n", irq_source)=
;
> >               return false;
> >       }
> >
> > @@ -305,17 +299,19 @@ void *amdgpu_dm_irq_register_interrupt(struct amd=
gpu_device *adev,
> >                                      void (*ih)(void *),
> >                                      void *handler_args)
> >  {
> > +     struct drm_device *dev =3D adev_to_drm(adev);
> >       struct list_head *hnd_list;
> >       struct amdgpu_dm_irq_handler_data *handler_data;
> >       unsigned long irq_table_flags;
> >       enum dc_irq_source irq_source;
> >
> >       if (false =3D=3D validate_irq_registration_params(int_params, ih)=
)
> > +             drm_err(dev, "DM_IRQ: invalid registration parameters\n")=
;
> >               return DAL_INVALID_IRQ_HANDLER_IDX;
> >
> >       handler_data =3D kzalloc(sizeof(*handler_data), GFP_KERNEL);
> >       if (!handler_data) {
> > -             DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
> > +             drm_err(dev, "DM_IRQ: failed to allocate irq handler!\n")=
;
> >               return DAL_INVALID_IRQ_HANDLER_IDX;
> >       }
> >
> > @@ -371,11 +367,13 @@ void amdgpu_dm_irq_unregister_interrupt(struct am=
dgpu_device *adev,
> >                                       enum dc_irq_source irq_source,
> >                                       void *ih)
> >  {
> > +     struct drm_device *dev =3D adev_to_drm(adev);
> >       struct list_head *handler_list;
> >       struct dc_interrupt_params int_params;
> >       int i;
> >
> >       if (false =3D=3D validate_irq_unregistration_params(irq_source, i=
h))
> > +             drm_err(dev, "DM_IRQ: invalid unregistration parameters\n=
");
> >               return;
> >
> >       memset(&int_params, 0, sizeof(int_params));
> > @@ -396,7 +394,7 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdg=
pu_device *adev,
> >               /* If we got here, it means we searched all irq contexts
> >                * for this irq source, but the handler was not found.
> >                */
> > -             DRM_ERROR(
> > +             drm_err(dev,
> >               "DM_IRQ: failed to find irq handler:%p for irq_source:%d!=
\n",
> >                       ih, irq_source);
> >       }
> > @@ -596,7 +594,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdg=
pu_device *adev,
> >               /*allocate a new amdgpu_dm_irq_handler_data*/
> >               handler_data_add =3D kzalloc(sizeof(*handler_data), GFP_A=
TOMIC);
> >               if (!handler_data_add) {
> > -                     DRM_ERROR("DM_IRQ: failed to allocate irq handler=
!\n");
> > +                     drm_err(adev_to_drm(adev), "DM_IRQ: failed to all=
ocate irq handler!\n");
> >                       return;
> >               }
> >
> > @@ -611,11 +609,11 @@ static void amdgpu_dm_irq_schedule_work(struct am=
dgpu_device *adev,
> >               INIT_WORK(&handler_data_add->work, dm_irq_work_func);
> >
> >               if (queue_work(system_highpri_wq, &handler_data_add->work=
))
> > -                     DRM_DEBUG("Queued work for handling interrupt fro=
m "
> > +                     drm_dbg(adev_to_drm(adev), "Queued work for handl=
ing interrupt from "
> >                                 "display for IRQ source %d\n",
> >                                 irq_source);
> >               else
> > -                     DRM_ERROR("Failed to queue work for handling inte=
rrupt "
> > +                     drm_err(adev_to_drm(adev), "Failed to queue work =
for handling interrupt "
> >                                 "from display for IRQ source %d\n",
> >                                 irq_source);
> >       }
> > @@ -720,7 +718,7 @@ static inline int dm_irq_state(struct amdgpu_device=
 *adev,
> >       struct amdgpu_crtc *acrtc =3D adev->mode_info.crtcs[crtc_id];
> >
> >       if (!acrtc) {
> > -             DRM_ERROR(
> > +             drm_err(adev_to_drm(adev),
> >                       "%s: crtc is NULL at id :%d\n",
> >                       func,
> >                       crtc_id);
>
