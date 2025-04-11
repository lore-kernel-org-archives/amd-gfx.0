Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E7AC369AD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 13:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CEB10EBB8;
	Fri, 11 Apr 2025 13:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IgTa7Pi3";
	dkim-atps=neutral
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B6110EBB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 13:11:32 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-523f58d7322so135019e0c.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744377092; x=1744981892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yFZcekkT4QITUlaFu4tc5BNCNTiRTreP/SlOuiChDQ=;
 b=IgTa7Pi38LQXsQllnX+3KVfsrNYAHnyfCMO/qg67hG6a6NXeyTEScWiXZIkx4Yezw7
 N0MZllLukn/W/XGkdpETPlu8ZrP4q8tD7YGx6G5c9w1vO8Ml9BI8qfFfJcbfrRG4ikUb
 9j2pQazjJPvVw66OPq7XmaaFlVk09cnLLow8xbdSsUA9hG2eCJJZEK6xhV4LRirzutpp
 nnMtNcBRZrAwKmqCNTI4ZjindSPzmzGMDbhPXG2vekElmCB2s+ej4G8QVK48ihEpXqcP
 OQAatUTZwdmEbk1ypja8eU+chllVZNo2VuOCQGVPD1OrwTE36VlBr7w/Sklfe3CtKK87
 wxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744377092; x=1744981892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yFZcekkT4QITUlaFu4tc5BNCNTiRTreP/SlOuiChDQ=;
 b=WX9G/Fxpxz4iuM0U9n8abF8OaHmkPEZHDMwOlK+pP0aWWeojEOzK0SIuWI3+H+I9fc
 KdzHIDhzEPMstbg79e0k5LPRQrN3jiXJhAbkupBmDqkOMK5343Xhp4ZY9Z9DXa25lwLE
 +kimi95qApBEETjPYmT9nCpVs5gXWaMbvI0XWX0a4/GCF6QT8Zpu848DJgOO6M+fx7QM
 QkZUXKZmmAX+zuhpUn06HKgHpk+9AkCyEcE6+9G8YG7reS5sABqwoz8bXPDliss50Hzk
 TVHc5D8onVpwCcpGdJwz7im0E6Spe84p/P8sIjlWgYJMVbZvGFcX4+QKOzSjwARWLhLb
 9cpg==
X-Gm-Message-State: AOJu0YzpUAI63JsHi68UFCSbr+cs9Xviq9C0gVsdU7qYUZ9zQ4oboK1l
 BadEKu8Japig7hXLTJI92U6iZ9joDaCu2pu21QcZPQk6Lgvo1aV2Ws0LaUDamrsw2tjCcQw9L4c
 R55Sc1ZVaG9O3+OJOf84F6YcD+cM=
X-Gm-Gg: ASbGncuzcsyBSFIMkRM1OUM7jCXZtpeJ9sZfIoQZWVFmjnb9kznI7UWNWHPsKXXuWfH
 63SG7WwfJKAndTCZlYFIiY2JwDFGXmwiC4bEu7XT+6wanTAHdu3WLFKQXBYVG0/tJ7M5JpBkgDP
 8IBbfT+OsqiPcb4t5Ya84khA==
X-Google-Smtp-Source: AGHT+IF+WRaSejjL0kej0DMNPG2t1PHQcf6fclYVAcaXpSxtMDVkfiv11PBwhE96iC/n7JvKaOPaOqY2BqhBqETBkag=
X-Received: by 2002:a05:6122:8c6:b0:520:579d:893c with SMTP id
 71dfb90a1353d-527c348722bmr487191e0c.1.1744377091321; Fri, 11 Apr 2025
 06:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250411074222.1055228-1-Emily.Deng@amd.com>
In-Reply-To: <20250411074222.1055228-1-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 09:11:18 -0400
X-Gm-Features: ATxdqUGU-nbL5TbyM-lRRwhVWLU8yNAMzl1BbT_n8bgAZNIVkQE-b9YvQ9k1shM
Message-ID: <CADnq5_PHmcC_3NVuV=xCYv5VfaqDVufEz65yPK3_+Uh7mkV0jQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clear overflow for SRIOV
To: Emily Deng <Emily.Deng@amd.com>
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

On Fri, Apr 11, 2025 at 4:07=E2=80=AFAM Emily Deng <Emily.Deng@amd.com> wro=
te:
>
> For VF, it doesn't have the permission to clear overflow, clear the bit
> by reset.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
>  4 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ih.c
> index 901f8b12c672..1c8a40d579c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -227,13 +227,19 @@ int amdgpu_ih_process(struct amdgpu_device *adev, s=
truct amdgpu_ih_ring *ih)
>                 ih->rptr &=3D ih->ptr_mask;
>         }
>
> -       amdgpu_ih_set_rptr(adev, ih);
> +       if (!ih->overflow)
> +               amdgpu_ih_set_rptr(adev, ih);
> +
>         wake_up_all(&ih->wait_process);
>
>         /* make sure wptr hasn't changed while processing */
>         wptr =3D amdgpu_ih_get_wptr(adev, ih);
>         if (wptr !=3D ih->rptr)
> -               goto restart_ih;
> +               if (!ih->overflow)
> +                       goto restart_ih;
> +
> +       if (ih->overflow)
> +               amdgpu_amdkfd_gpu_reset(adev);

This won't work if KFD is not compiled in your kernel config.

Alex

>
>         return IRQ_HANDLED;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ih.h
> index 7d4395a5d8ac..ff76f02d3e96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
>         /* For waiting on IH processing at checkpoint. */
>         wait_queue_head_t wait_process;
>         uint64_t                processed_timestamp;
> +       bool overflow;
>  };
>
>  /* return true if time stamp t2 is after t1 with 48bit wrap around */
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_0.c
> index f8a485164437..8d3ae88b96a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *ade=
v)
>                         if (ret)
>                                 return ret;
>                 }
> +               ih[i]->overflow =3D false;
>         }
>
>         /* update doorbell range for ih ring 0 */
> @@ -446,7 +447,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *ad=
ev,
>         wptr =3D RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
>         if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>                 goto out;
> -       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       if (!amdgpu_sriov_vf(adev))
> +               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       else
> +               ih->overflow =3D true;
>
>         /* When a ring buffer overflow happen start parsing interrupt
>          * from the last not overwritten vector (wptr + 32). Hopefully
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index e9e3b2ed4b7b..2ad209406d17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *a=
dev)
>                         if (ret)
>                                 return ret;
>                 }
> +               ih[i]->overflow =3D false;
>         }
>
>         if (!amdgpu_sriov_vf(adev))
> @@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *=
adev,
>         if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>                 goto out;
>
> -       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       if (!amdgpu_sriov_vf(adev))
> +               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +       else
> +               ih->overflow =3D true;
>
>         /* When a ring buffer overflow happen start parsing interrupt
>          * from the last not overwritten vector (wptr + 32). Hopefully
> --
> 2.34.1
>
