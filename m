Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31167D3399B
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 16:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFA210E052;
	Mon, 28 Oct 2024 16:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HG50IirY";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D928210E36D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 16:30:01 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-7eb0448693eso349266a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730133001; x=1730737801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2hQmy036gGPkUwYxWG/Bn9998k1xQFM1SWCY2RvBqY=;
 b=HG50IirY0jXcD/FX/EZ/fXRuQIB+b7hWnw70o+VR4uM3QTXKcmQeoWgA2gZWawZeJ3
 Uyh8nD5GWyoui4ySJgm2u/u0OPkFhwkM6QBLiTUeAMt+mhFOcDMOFvXP6H8Pg/3Rs3D5
 oXvTo/NWptMEMtv3glfQBIBSAksDBmeTapojgm4+sVQtDjrdYXUydkHwPSSY2Z6nkzSy
 4RoTaeLgMQuNZVev+lD2Jb1oD/rX4Fa7u1BbAKPBQ3yyOxskBNVK5XogEf/hUYuCiPQV
 uAjMQZdq5xdRsx296IchkPclO+ZUnq/yyDflY9GZL8JBXjpsY9ntReg6U0x26CSISRdA
 lucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730133001; x=1730737801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2hQmy036gGPkUwYxWG/Bn9998k1xQFM1SWCY2RvBqY=;
 b=GxT+C8N1vMI9yjEo5j95tBkZIxWGOk7vtPmRwnsv6gAYKqNK62QNCpp0ZyeeYOVXyu
 4KAK8+KmG8GHbYfIZtuk+i5H44tlm7O0n3njunHmhhTRgzIjfdcUhccUKiUUJIMjspOb
 hHmj9gna+LgOo2Uayt/RWR+7HA+b7tsiqrHSAFVNCWtvTZoGrJMjZcd7P40qzF+CzRI0
 W7KQ90Z3fOZfaTen4Nf6QEKeFsth3dZVje+jq2Gd2zgsK+FkJYCRptQTXSqXuMiUznGp
 8BySEaDVi2NHazM8JU9NEL9jmiSTwqD2CjCoZn4xV4L/aPKNqXiLowgXBZijybsA1O05
 vBCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbRSe5gIo1iAbmvpaaOBh1WFXz9fQAyFn+bbQcfIaA3SwPmxbGL+yreIAPYzD48mTk27qJKwEC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmEApr+J/3DNGULQ8hqAqch+QB1c6+IiEpj+BZGSpBBzqvAAP3
 f/GUkKI56+2O6qJkd9/w0RFjumZusfxFM7K+XxHy2MDwS79losfSZ5T7QDe7Qjx4lUuyNVLru8r
 /HTF8i1+YIWlEGZAWratv63a44NM=
X-Google-Smtp-Source: AGHT+IGFrXG/pfldKG5uUGUrmjKOkNqQfWRZ6o6iPZWwILJZB0Cwy2rbpuBz/ReeDnR1MHTzCOaP2uG7CKbc1OoTqNA=
X-Received: by 2002:a05:6a20:72a3:b0:1cf:4dc7:e4fc with SMTP id
 adf61e73a8af0-1d9a83af621mr6035949637.2.1730133001152; Mon, 28 Oct 2024
 09:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241015181541.2457526-1-alexander.deucher@amd.com>
 <CADnq5_NHmJpZLbbrEsN75gkLOctFtS6nyNBHfgM-0=EpdyKFcA@mail.gmail.com>
 <CADnq5_MAExjgh8xYzfjSPxFUYV-17Tukh6DgH41ba9t6Pe8EoA@mail.gmail.com>
 <e0a3cc5c-d7b3-4bcc-b136-2f68513ccb7c@amd.com>
In-Reply-To: <e0a3cc5c-d7b3-4bcc-b136-2f68513ccb7c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 12:29:48 -0400
Message-ID: <CADnq5_PrsO9+LBb7gzSdtVmMZHX255C8qkooUSfJiKh6NR8C2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add ring reset messages
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Oct 28, 2024 at 11:41=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 10/28/2024 8:11 PM, Alex Deucher wrote:
> > Ping?
> >
> > On Fri, Oct 18, 2024 at 11:47=E2=80=AFAM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
> >>
> >> Ping?
> >>
> >> On Tue, Oct 15, 2024 at 2:28=E2=80=AFPM Alex Deucher <alexander.deuche=
r@amd.com> wrote:
> >>>
> >>> Add messages to make it clear when a per ring reset
> >>> happens.  This is helpful for debugging and aligns with
> >>> other reset methods.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_job.c
> >>> index 102742f1faa2..2d60552a13ac 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> @@ -137,6 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedou=
t(struct drm_sched_job *s_job)
> >>>         /* attempt a per ring reset */
> >>>         if (amdgpu_gpu_recovery &&
> >>>             ring->funcs->reset) {
> >>> +               dev_err(adev->dev, "Starting %s ring reset\n", s_job-=
>sched->name);
>
> Is dev_err intentional or dev_info is good enough? Also, suggest to add
> ring name to fail/pass messages.

I was being consistent with the other messages from this function.
They are all dev_err.  Will add the ring name.

Thanks,

Alex

>
> Thanks,
> Lijo
>
> >>>                 /* stop the scheduler, but don't mess with the
> >>>                  * bad job yet because if ring reset fails
> >>>                  * we'll fall back to full GPU reset.
> >>> @@ -150,8 +151,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedo=
ut(struct drm_sched_job *s_job)
> >>>                         amdgpu_fence_driver_force_completion(ring);
> >>>                         if (amdgpu_ring_sched_ready(ring))
> >>>                                 drm_sched_start(&ring->sched);
> >>> +                       dev_err(adev->dev, "Ring reset success\n");>>=
>                         goto exit;
> >>>                 }
> >>> +               dev_err(adev->dev, "Ring reset failure\n");
> >>>         }
> >>>
> >>>         if (amdgpu_device_should_recover_gpu(ring->adev)) {
> >>> --
> >>> 2.46.2
> >>>
