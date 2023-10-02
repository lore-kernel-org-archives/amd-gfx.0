Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA031E74919
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 20:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FC310E236;
	Mon,  2 Oct 2023 20:19:41 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABA110E236
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 20:19:38 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c4a25f6390so74086a34.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696277978; x=1696882778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPBj8E98Bc2cUj3eUnngS3hbAlGp0HqfOSLCEryGxtI=;
 b=CZqYjydbnOfWiFaUaBqu8w0mvNz7zCdlVsf+Yl8gCgTMSPO76uJZhEEwer9SGHSnM0
 wHbEFTJS4HkiYPL9D9BIb+P8OS967cmpphH3zfk7ctBYECo7rXv8dmRP1+wLXYN7SWiT
 IwF9WldgVJ7IF8vQZJwdm4SEeC07hm0UBX+bzVDiJwANpO24Lttydv3dag22iL4OqaUr
 Kd08tQ+guwHqZEFaCnRLyBqdMn9OcFxkQIXCFH/65v6D/9pOxd2P2RxucwwAuBnvL9iA
 ZGgDCoTJeVKTyBnMhFrKWTU0lLlbHppHmDbMnJdJfIpRd1CpLCJ6CUi166GhxyBG+foI
 2zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696277978; x=1696882778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPBj8E98Bc2cUj3eUnngS3hbAlGp0HqfOSLCEryGxtI=;
 b=BWF/1XaNkIjZs44G8cuF+cSwu3T6HM3+X9AhJICJzDY/oXtG4YKU3y03UTfMz8aUHn
 MZkNqjAgjdRu7S2rIx0ACBAGQnpfNZP5Ns3dGQwLd/1hP+pnlBMfehPsiP8IITCJHa0S
 SDeBMPWKAUfraxnSObC3WV8KwuZZigZSeM7dFlX6seI2+ZGMT1IY3cD2c2fjO1nCYfcM
 anq9Tyi5LN5Ynx9n1AvJiHyHMyVqqnuaOCwvLmX8yweVPZKk830NK7qvFBef1gxASTcp
 n7DgR8JcwmD+c9H1zdYESzCo4ZWeLpQfWqd2yGdK3TMf67YEy4SE77MxrGKRBMvSXShz
 THrA==
X-Gm-Message-State: AOJu0Yz+Ev/JwnoNznWoAhGQGzqv2fqqV4tWDWe3pjsjsCk4FvRhLYHY
 QHi/orlJab0IBu935Ge5qbY/dzHZZS1k4HQHRfU1EP3Z
X-Google-Smtp-Source: AGHT+IEYvZR3pO7r8KCFWQ2GbCs87fmeULBvRrbVKlODfBI/M75YeFYO27Kh437m288ps98a5BboS406cf+qqSOGIII=
X-Received: by 2002:a05:6870:4412:b0:1ad:5317:1f7d with SMTP id
 u18-20020a056870441200b001ad53171f7dmr14581182oah.39.1696277977824; Mon, 02
 Oct 2023 13:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231002184919.77753-2-alexander.deucher@amd.com>
 <89fd99c4-04fe-4c5f-84c8-6f0eb00eb13c@amd.com>
In-Reply-To: <89fd99c4-04fe-4c5f-84c8-6f0eb00eb13c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Oct 2023 16:19:26 -0400
Message-ID: <CADnq5_M2A3URqkNv6ACXzcYF3GT5BVFABwWdX2+cHhsgJehMFw@mail.gmail.com>
Subject: Re: [2/3] drm/amdgpu: fall back to INPUT power for AVG power via INFO
 IOCTL
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 2, 2023 at 3:46=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/2/2023 13:49, Alex Deucher wrote:
> > For backwards compatibility with userspace.
> >
> > Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_PO=
WER`")
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2897
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 081bd28e2443..ce71f853931a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1077,7 +1077,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >                       if (amdgpu_dpm_read_sensor(adev,
> >                                                  AMDGPU_PP_SENSOR_GPU_A=
VG_POWER,
> >                                                  (void *)&ui32, &ui32_s=
ize)) {
> > -                             return -EINVAL;
>
> In order to encourage userspace software to move to the new dedicated
> IOCTL, what do you think about having a dev_warn_once() here?

I'm not opposed, but I think it will probably just lead to more bug
reports.  We need to type up the mesa side anyway before we can push
patch 3.

Alex

>
> > +                             /* fall back to input power for backwards=
 compat */
> > +                             if (amdgpu_dpm_read_sensor(adev,
> > +                                                        AMDGPU_PP_SENS=
OR_GPU_INPUT_POWER,
> > +                                                        (void *)&ui32,=
 &ui32_size)) {
> > +                                     return -EINVAL;
> > +                             }
> >                       }
> >                       ui32 >>=3D 8;
> >                       break;
>
