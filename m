Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3D5CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 12:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EACE10E782;
	Wed,  4 Sep 2024 12:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FoZuGcL4";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EDC10E781
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 12:11:02 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-714481eca0cso846796b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Sep 2024 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725451862; x=1726056662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNByYKwye3ae3TR3XF9SAU/7w6S/epnTfcR0xQuu1ko=;
 b=FoZuGcL4tSQyLT0ypLdBDxcM9scYsDPx2NotPi1sW0ifHJ/2XLdzzujs/1/sGsmPxv
 0xdsJTP/JzgdF6C1vWKFZtTN+VRZuu9/Z8bHvVP3dgK7+McFTUTIeL+mtfLWLbY+jMzO
 vCnPIuezPXkrgi82wKJQFwWniptxbH4wovIY0Y59a9CEZd0bz6u6dxnc4J4xrYhlGwVQ
 nZFcflUIn5he2I5RAqUpPYLhfuHTsddOUOkIIcl4g2dBNUnwpZDW2n7/r5aKnYX2nXZN
 ID9auPijS8LGDcAQ1OgwW3iaNimknypNBQYuBVQhSrp8TqfZKAbQHH8Gel7hr/2Bg/ur
 hV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725451862; x=1726056662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNByYKwye3ae3TR3XF9SAU/7w6S/epnTfcR0xQuu1ko=;
 b=WE6gmFr8bOJpIqrkzztCcnATQt+YRLxhkkiR9hRHT/rC/oEGuMmKnKlFHUasBgcQAF
 DW0DPnyLfO6Ri6VvaiGe8qVpZ0mAq4lhPNqOkQ3CpNZJPFzG998HuJQLppwRD9bdjRqq
 42u4a5qm+580wxMonX6ky2O+HMUfLIJtuh1OejxUos+jkvDGx4VGVN54bZjCdxECqm6+
 wtmtPdup67OXi3JKClr9JCUkLiSgRfD0LViilAVp+z+j1yG1ZuYhyVBx6VS+hFlSNlhB
 /WbjGgi39HBpKG0YlJA8IrAdX0FL9w7hTfZSRGbeiD2aOFQZrX6mrcSP0TXk4I1qXLUK
 yS8w==
X-Gm-Message-State: AOJu0Yw1Udi5NFLQ3ZnuflJa2XU+ITwV3ed0ZIugiNUq6CjAdfRC07Hs
 rMaL+Zy1AMtybHBVQRnlWJvq7PYEIz1Slwcz982AtSrWGNoB+HBIFvmBOJAP+hZy+71FhoR2qns
 zjlPs8l+1UyV01CHEV/UWxlFMe+zHPxCy6K6IuA==
X-Google-Smtp-Source: AGHT+IGuTL2Y8VZ5rp8Nj/rrCE4gStobJQIKjGRF6pV669u7OicooUrERdcEYWSs4b8+BxQ43wwayITs1sHARfq//0g=
X-Received: by 2002:a05:6a21:6d90:b0:1c4:d403:d531 with SMTP id
 adf61e73a8af0-1ccee5179c2mr9990142637.6.1725451861876; Wed, 04 Sep 2024
 05:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240904095226.991344-1-jesse.zhang@amd.com>
In-Reply-To: <20240904095226.991344-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Sep 2024 08:10:50 -0400
Message-ID: <CADnq5_OScRSEaVGB9mYvSPEtUFdCBqmWyDmaammnaN9iSOyybA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix queue reset issue by mmio
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Tim.Huang@amd.com,
 jiadong.zhu@amd.com
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

On Wed, Sep 4, 2024 at 6:03=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> Initialize the queue type before resetting the queue using mmio.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index f7d5d4f08a53..10b61ff63802 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -832,6 +832,7 @@ int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_devi=
ce *adev, int queue_type,
>         struct mes_reset_queue_input queue_input;
>         int r;
>
> +       queue_input.queue_type =3D queue_type;
>         queue_input.use_mmio =3D true;
>         queue_input.me_id =3D me_id;
>         queue_input.pipe_id =3D pipe_id;
> --
> 2.25.1
>
