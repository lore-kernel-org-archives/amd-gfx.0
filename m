Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C8606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qnVk69/J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDF310E19B;
	Mon, 19 Oct 2026 18:24:14 +0000 (UTC)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE20610E19B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 18:24:07 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1397a4855beso179615c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 11:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792434247; cv=none;
 d=google.com; s=arc-20260327;
 b=Fn4fFznPut/hDFI8ZB8vuRAiQ4cjx51U+TX9+f5lpCIGDkjkKivRBhhjbcvuOje4s6
 G+V9Gu75O+QVeExiiz3U4y/S4KzA6h51COh2uxYUts2qQxw/gqCSGTTbcyq+Faht+BVu
 R8LXF+D28glJ8EVQ76mzBC9MaPzBpXVVpnavkmg6yrLl+NtdNCnxRvVd/FNyYwwLsLka
 fd+gzc8Xe6srDXnZKLgPlpedDLcF/LKOQCOpTC/I24YYs4ZlN3fXB2FrpMW74JRUvOAm
 T/TkhsaAHkdqMKvXc4bUsgAST6ayANMuID9tDO6WLc8qCPeK7dUyi+KFDF62aKtTvx8u
 gkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dMdUSZk4TeLrt8OdPlxc/aCbKFnw+6+LOGrhzfBPcxA=;
 fh=hqqD5xus0V6n0/FR7kux//pRSesT4DAn56LhluHUaso=;
 b=mbbBH3z+E/FJf1uGSrb9+WRkfLDmpvCv8KO2ehohz2G5j+dKKRunl0LRMjURZCYMan
 CX1Kt4jyX2zRMz0HpC6H9jS0c23wDUfNwQvO6FIpcN7bNV1hhzmEsgD1sL8QExsei4p3
 MX8Z2Yzyf2G5hlho9nh41U+m9RcjPHx9y8jtAIwjRbYJgeatGjByJWVOMBocMAVvX3uJ
 nT19CTp/AYvHZ/7HucANM2K01PJbqZV7aAcF6SUCkRRy/94ORelp/prTuyeNxPEUIueO
 KihvUWI8qwOk9R/agnbxccXikCpGyzDhNzvFwDtrWUF6OvXZA0pzYuRRvNBpzPtfs7EE
 8Y1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792434247; x=1793039047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dMdUSZk4TeLrt8OdPlxc/aCbKFnw+6+LOGrhzfBPcxA=;
 b=qnVk69/JAvPQOyGSiQ2DN/ccVU++VvBfG9AuRPNxyz5H1czobZ3BMAjOK5zwfULhWC
 bfkCw7cnjD6P5qggYeECviAxPInPaV9EZKiCYKHmBee/MGDRYVNyjrnyAFRer93xhcoT
 utTuj+p+mnoNjxasQBONVKHZT/CohU1PMhs9W831ov9zryTptuCv6w9I7XGzNyT6rRD/
 Irvbn0/bgMkTop9OH6g8Slx9fh8j2FxEHwgbwnIDTFwn2cFO5lpIG6uqEM3opi1P+rzR
 v2u2yh5nMljcl6Wklhq/WzJyVAv3wvfUehSm1uEk9O/0WS/Rwofp7Qh1+UgZBdiFlPZM
 /Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434247; x=1793039047;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dMdUSZk4TeLrt8OdPlxc/aCbKFnw+6+LOGrhzfBPcxA=;
 b=ERiYDwnF5kUSvNDcvfrGSweqJkXxaJV1DsmLpFrhOn8tVA5duzxpv4l4G8aPWSX4Oj
 c662xSq7h5GoouLWDxl6VEvGyqxBSAVr+2b0BtpY9qzwNu908RGabJRfACf2I4HrMpZa
 0YWMBhAIGytvxYrI1QfuyYg31bzqV1PNOXM8eeAv3n+yZ+old0V9HxnbmD/enDSzI2Jb
 63xf7a5bq+laY/JS41WL1WNGAIBwoNBdvw/pl/G9fbYu0mVIaNgUusd4/Qrm/DGerU4I
 c0QTHBtqSiHnUu3nGUGJMU4lcGYayHnGCtFZdWjhAUrhE86BxsfqoLTI7v+xfTHIldnf
 sD9Q==
X-Gm-Message-State: AFq9FYKhdoUhcZD2k9oRRH4hUA+/LHWDrmUpBlzbzTOx16mz03S63DyN
 r6g9EK1Yo/3fVCf+12M3Kp/dFrDKUi5H8i1LoTOKQXKPRGfpmqYLK6GcMY+fZfBuKu3u7u5tu4f
 lhrtNMQdNC1NcWIKXyKepemtj5UIbyEc=
X-Gm-Gg: AYBFou379KtuN+XuEZ1VZBueFgqpsHPurjams57qzFTb+FE6WgLUE3isWRUi+WaeQhs
 dlUEAnEoDzhjHUkYb2MrvZjP9IezSc0Y9dVSD59gsXAgoiq3YOiTuhpI6AP+iWAjujmGrEP1cnk
 +6HvU1yAI9BTtmfPAr5oAFdzA4Jtjwe532gKPWPfg4wK/I/WOTvo8O9FJd3izpnc56i8Kajki/Q
 fB9toeDCAQHi1Id73rqWd09+EwpgwiaPRXVLLMkcV+OZcrhcKu+p58mL27FtSaajlUBmoT8YhQS
 Zo9MJmvEybbrKaMqbIjQbdCD9rAKtGYRVg3No/fuCeL93V6wQkXwsU6Yctu9RoypTH6RNKua/w+
 rHPwy/lm3jd6byXDK0fUL9KAw6ePtl4h7xZylkrxyd1k=
X-Received: by 2002:a05:7023:a5b:10b0:147:d430:7322 with SMTP id
 a92af1059eb24-1850fb0317cmr18858697c88.1.1792434246902; Mon, 19 Oct 2026
 11:24:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019175807.970192-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20261019175807.970192-1-Yongqiang.Sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 14:23:55 -0400
X-Gm-Features: AclHuK9nRON4AiT4qs0XxKFb-VwFl-jr2DNIj8q9RbeqbN825b2O3uAt7mnIobA
Message-ID: <CADnq5_Ox1ef+f7fGiO7bBsyvNm4AYvPDD=qQL7rWM6AySXwNkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Enable SDMA IB processing
To: Yongqiang Sun <Yongqiang.Sun@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Mukul.Joshi@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 2:06=E2=80=AFPM Yongqiang Sun <Yongqiang.Sun@amd.co=
m> wrote:
>
> SDMA MQDs leave IB_ENABLE clear,
> causing INDIRECT packets to be ignored.
>
> Set IB_ENABLE while retaining SWITCH_INSIDE_IB.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |  7 +++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  7 +++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 11 ++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 11 ++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  8 +++++---
>  5 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 4f8a8a1a6186..25f5a2cf02ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -396,6 +396,13 @@ static void update_mqd_sdma(struct mqd_manager *mm, =
void *mqd,
>         m->sdma_queue_id =3D q->sdma_queue_id;
>         m->sdmax_rlcx_dummy_reg =3D SDMA_RLC_DUMMY_DEFAULT;
>
> +       /* Enable IB execution; allow context switch inside an IB so one
> +        * queue cannot starve the engine.
> +        */
> +       m->sdmax_rlcx_ib_cntl |=3D
> +               SDMA0_RLC0_IB_CNTL__IB_ENABLE_MASK |
> +               SDMA0_RLC0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +
>         q->is_active =3D QUEUE_IS_ACTIVE(*q);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index bf015dc5b868..a1eecdf63b0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -478,6 +478,13 @@ static void update_mqd_sdma(struct mqd_manager *mm, =
void *mqd,
>         m->sdma_queue_id =3D q->sdma_queue_id;
>         m->sdmax_rlcx_dummy_reg =3D SDMA_RLC_DUMMY_DEFAULT;
>
> +       /* Enable IB execution; allow context switch inside an IB so one
> +        * queue cannot starve the engine.
> +        */
> +       m->sdmax_rlcx_ib_cntl |=3D
> +               SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +               SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
> +
>         q->is_active =3D QUEUE_IS_ACTIVE(*q);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 6ea09b031caf..e0574fa325c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -353,11 +353,12 @@ static void update_mqd_sdma(struct mqd_manager *mm,=
 void *mqd,
>
>         m->sdmax_rlcx_dummy_reg =3D SDMA_RLC_DUMMY_DEFAULT;
>
> -       /* Allow context switch so we don't cross-process starve with a m=
assive
> -       * command buffer of long-running SDMA commands
> -       * sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
> -       */
> -       m->sdmax_rlcx_ib_cntl |=3D SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB=
_MASK;
> +       /* Enable IB execution; allow context switch inside an IB so one
> +        * queue cannot starve the engine.
> +        */
> +       m->sdmax_rlcx_ib_cntl |=3D
> +               SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +               SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
>
>         q->is_active =3D QUEUE_IS_ACTIVE(*q);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 2bbf5e63f615..04e1575dfe76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -457,11 +457,12 @@ static void update_mqd_sdma(struct mqd_manager *mm,=
 void *mqd,
>
>         m->sdmax_queuen_dummy_reg1 =3D 1;
>
> -       /* Allow context switch so we don't cross-process starve with a m=
assive
> -       * command buffer of long-running SDMA commands
> -       * sdmax_queuen_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
> -       */
> -       m->sdmax_queuen_ib_cntl |=3D SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_IN=
SIDE_IB_MASK;
> +       /* Enable IB execution; allow context switch inside an IB so one
> +        * queue cannot starve the engine.
> +        */
> +       m->sdmax_queuen_ib_cntl |=3D
> +               SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
> +               SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
>
>         q->is_active =3D QUEUE_IS_ACTIVE(*q);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 6e6bc1ec0b64..80df86f7c4d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -569,10 +569,12 @@ static void update_mqd_sdma(struct mqd_manager *mm,=
 void *mqd,
>         m->sdma_engine_id =3D q->sdma_engine_id;
>         m->sdma_queue_id =3D q->sdma_queue_id;
>         m->sdmax_rlcx_dummy_reg =3D SDMA_RLC_DUMMY_DEFAULT;
> -       /* Allow context switch so we don't cross-process starve with a m=
assive
> -        * command buffer of long-running SDMA commands
> +       /* Enable IB execution; allow context switch inside an IB so one
> +        * queue cannot starve the engine.
>          */
> -       m->sdmax_rlcx_ib_cntl |=3D SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MA=
SK;
> +       m->sdmax_rlcx_ib_cntl |=3D
> +               SDMA0_GFX_IB_CNTL__IB_ENABLE_MASK |
> +               SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
>
>         q->is_active =3D QUEUE_IS_ACTIVE(*q);
>  }
> --
> 2.43.0
>
