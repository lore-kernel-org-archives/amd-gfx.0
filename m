Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA080C54ED1
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 14:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F6110E11B;
	Tue, 27 May 2025 14:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBDoiHO9";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659D410E11B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 14:46:33 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-30eccc61fc0so607689a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748357193; x=1748961993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIgNZfK1QHg3oj2lgOD4mOt7fc3fizq8KBLpb/UzRRw=;
 b=IBDoiHO9tFsz7A+b7xgygPSSEl5IgG4k04b0r28pku6qzBLyZ75EAftyTsSa0MftBs
 Jy9Uziyp3aCji5rAbXNh2BUqDo87uVDZvOTKhAuE1L8WO4iQ18fvnqYVUudC4+znzzsD
 sLmIhbYaflZBJeEMKun+bou1RGB9trTqsyH3ziwWwqbX2/wK3AnKtTiaWTGUxNS/5+/r
 mIM4UuEl+ar4/761o5mWbKLbpyfRaS9YcCwf1UkfLlA5T3xudJxBNIeijTNnPvWwgNvJ
 LRBjULw4RqC1A0D+fMfK4qa/2aso3/el0zlQPSyG/6/g7dvHIzm8DmtG43Yhxgi/ZeN9
 yiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748357193; x=1748961993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIgNZfK1QHg3oj2lgOD4mOt7fc3fizq8KBLpb/UzRRw=;
 b=GAUmypgXTA4sgk6MFQMzh0ZDmnfSVZsoR7E5xp8i8dJ8VGEYWLyIVTwfDOJOPWNnzO
 +9aeKM3zY742AS5VlO7fyrP6VljYW1sdZLA2SL9qGFsnHLS5z+T1mHZT9CqBg9NvX6F0
 nzWyg/unOGjxUo/uluTF+43qmKADqS/XWJAozG/+AIJlhs1Cc/1rkbNXpFrHe7r+j060
 EZicyKhGxGtHcaT19Rhwz50C0+83FE8Hb8nXAJvMT63RLANVrZYDBcvIWBHKLW+COvLg
 MnOWB0g0iBGRZo8CU50PctFTuniRPk9/1NNQSxkSMOiHLJy7SH2zDx7O4vO+XIE1O/R+
 1gLg==
X-Gm-Message-State: AOJu0Yzn5Xgb0Eb3GctkaXMaS1gxpANbOKbEKx0YT+I5KnHFCa/XA+91
 XNiSeKu35jCKOKotRbiLrgsfTDyUjuiqX+A65ywHLBiLt9bWIC/uHgl0KeU09LwaiXmDL31CIKi
 tu4yOunajmkR5BHAjNtoaPLsfsS4F5lc=
X-Gm-Gg: ASbGncvFdq272ZSBzfe3KNGeDtkIOR9DRPv0QbcwUy9qPqztEyBjLQVk3Jnz1ndIUYr
 sOQjLdPe25SkkSZuTXn9jvTlrfTn9HxOvkNnepHze2f8VVdDVeK7sbWcLLf0v3SR48xGAswQ7rE
 MHhLMKsD820mNK1CDnh5kYKEmWTKB3mUY97A==
X-Google-Smtp-Source: AGHT+IGDwD0r/ECuhORz9BshlitpqnSwftZqr/tvR5CclVRNoursH53x8NuxMR66+VPEV3etKn/4rqof4jNQTKy+fWE=
X-Received: by 2002:a17:90b:3e8c:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-3111174d729mr7124086a91.5.1748357192728; Tue, 27 May 2025
 07:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250519195328.82276-1-alexander.deucher@amd.com>
In-Reply-To: <20250519195328.82276-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 May 2025 10:46:19 -0400
X-Gm-Features: AX0GCFsuLSOV6BWHccckVaxiGZqLnAgqgXMFjWLkmdT_PezC67wuPg2jzsPGtms
Message-ID: <CADnq5_NzP4gu7whc5mS04rHJyZsQrD-4=hQSLcM9NVZMj5eOCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/mes: add missing locking in helper
 functions
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

Ping on this series?

Alex

On Mon, May 19, 2025 at 4:04=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We need to take the MES lock.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index a4f2be39c237f..bf375687613a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -303,7 +303,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device =
*adev,
>         if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
>                 queue_input.use_kiq =3D true;
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input)=
;
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 DRM_ERROR("failed to map legacy queue\n");
>
> @@ -330,7 +332,9 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_devic=
e *adev,
>         if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
>                 queue_input.use_kiq =3D true;
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_inpu=
t);
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 DRM_ERROR("failed to unmap legacy queue\n");
>
> @@ -359,7 +363,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_devic=
e *adev,
>         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX)
>                 queue_input.legacy_gfx =3D true;
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 DRM_ERROR("failed to reset legacy queue\n");
>
> @@ -389,7 +395,9 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, =
uint32_t reg)
>                 goto error;
>         }
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
>         else
> @@ -417,7 +425,9 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
>                 goto error;
>         }
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 dev_err(adev->dev, "failed to write reg (0x%x)\n", reg);
>
> @@ -444,7 +454,9 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_devic=
e *adev,
>                 goto error;
>         }
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 dev_err(adev->dev, "failed to reg_write_reg_wait\n");
>
> @@ -469,7 +481,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, u=
int32_t reg,
>                 goto error;
>         }
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 dev_err(adev->dev, "failed to reg_write_reg_wait\n");
>
> @@ -700,7 +714,9 @@ static int amdgpu_mes_set_enforce_isolation(struct am=
dgpu_device *adev,
>                 goto error;
>         }
>
> +       amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 dev_err(adev->dev, "failed to change_config.\n");
>
> --
> 2.49.0
>
