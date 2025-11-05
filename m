Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBC6CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 14:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A4D10E074;
	Wed,  5 Nov 2025 14:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P1qBUi6h";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BEA10E750
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 14:03:34 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7a9fb70f7a9so612903b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 06:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762351414; x=1762956214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIRK8Qc8iFq1Ld8F5gRsjdh9HIur3LGW1Jvd3hjXies=;
 b=P1qBUi6hF7EUN4ujBHHf+cTmCzxwNpvm3h6+zMYlTRfr23Q7EQR6HndCPK1U38ZKxp
 bueFZ4P8n97fW6+flkoFMrNitGLWMT37Hli9nUwRADLpe45MTbm9ebxhWqIcXd0ZkDl0
 1KvOMVBvOR2v+jcFMmNOM8cx/MnD1BUYRlKUcurbfiu584LG1ap+D1naifjLlrG0oiK+
 nkK+ee6nVYtChJzkimAsA3NA3eBymtw+w4qxZkXSoTVy2MAxr90l1YgYKjs7yM1E7TDn
 yLfxOXoTq0PXJ4OZqDR0M1IcPySWx58oHA8jg6uLbhr9rmIWWYhP8xLTvOAtb8kZ6PBG
 An0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762351414; x=1762956214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIRK8Qc8iFq1Ld8F5gRsjdh9HIur3LGW1Jvd3hjXies=;
 b=h4OX3HiJ96TX6dY7SWS6mKRbi1L3NLkNZwIit47tI6s+9ygJrOZ1+DQRBDTAETb/tt
 QO78qXh7L45OQ1bnsRuH3Lh/tj7fxBnfvmYUWrnepcArjfOZkdJKF/EiM8ccR/+bg5u6
 7Tt+YFGk/Qfzh32BA6NIEqjhc7Fyq/BLYrnPk5D0kZY9DYoArwpL0WGHbBZ5lLGpIvRD
 Nj+2bLogOhDk1u7g1Yi8m7mbcK0gszUebSa9EZa5Ie30Oiof8rOoT7bF+oJ1BxewC6Ha
 GbYG8pEZm9kGR1C77hVcwmbBKS6A3JtSnqCI3WGr0mRAzrzo+V/g8VB5Zao8E3wbQBZl
 8BSQ==
X-Gm-Message-State: AOJu0YzPNN9HN1eWgYrHGj4Nlcsna4grExX/I9TH95a4s6hiZSPxM5Gw
 H1qwLutycivTBzo9h4ySPLq4SY4L4+ZH5kX05SHaXcaJk2FXemx/xhrx4imPw1AguR44yaEzHU2
 LIVxxZtfoNlYR+m9jRptwzDcEXKx+09U=
X-Gm-Gg: ASbGncvWATYwydlXjp7K/qEj0AuFHJQ1mga1H9LaTVIvZwStRJgxaaF0xsA+4QoJ9CM
 EGJKUuDb49+JFetBfpauz+u/y1Sviv927/R+lTpjoF8Us6HhNDjVXE1c1mAzOzP2Z2cOdHzZ23z
 Qzlo2sB1+JbNEp57ZzHOuaEG3mebO95de07RjRPycvMm5xBwI798zSHzJf5HC3afvNRq9a6xQjJ
 REnxH0iiYxfdFIOfkqD1axdugEdkjxW1/QhU2Ru2QxNf06IOHrXXuwpT1dGbsEc+55EuDc=
X-Google-Smtp-Source: AGHT+IF1pvTulnTN/SB2l8rmqJmF88pPbL1ptqcwjfg7lr8E8DYhg1oQwF7yN1qyd6esjP3Dnl8FTZQj9LEqma0z7Ps=
X-Received: by 2002:a05:6a20:6a0d:b0:244:aefe:71ef with SMTP id
 adf61e73a8af0-34f8620acbbmr2384170637.6.1762351414132; Wed, 05 Nov 2025
 06:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20251104163300.545619-1-shaoyun.liu@amd.com>
In-Reply-To: <20251104163300.545619-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Nov 2025 09:03:22 -0500
X-Gm-Features: AWmQ_blenWljwBBbfE-ZFDztTyi_wTTdbzfSOOKFISI8caqQnoIBKCEaT_stS1k
Message-ID: <CADnq5_O4=THKy-Z4=C+knk5utT024-iTUO_+18zCDgfZkcVE1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/include : Update MES v12 comments on RESET API
To: Shaoyun Liu <shaoyun.liu@amd.com>
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

On Tue, Nov 4, 2025 at 11:46=E2=80=AFAM Shaoyun Liu <shaoyun.liu@amd.com> w=
rote:
>
> Added comments for the layout of contents that addressed by doorbell_offs=
et_addr
> in RESET API
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index 2f12cba4eb66..39aee6b4aaa5 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -553,7 +553,26 @@ union MESAPI__RESET {
>                 /* valid only if reset_queue_only =3D true */
>                 uint32_t                        doorbell_offset;
>
> -               /* valid only if hang_detect_then_reset =3D true */
> +               /*
> +                * valid only if hang_detect_then_reset or hang_detect_on=
ly =3D true
> +                * doorbell_offset_addr will store the structure as follo=
ws
> +                * struct
> +                * {
> +                *      uint32_t db_offset[list_size];
> +                *      uint32_t hqd_id[list_size];
> +                * }
> +                * The hqd_id has following defines :
> +                * struct
> +                * {
> +                *      uint32 queue_type : 3;  Type of the queue
> +                *      uint32 pipe_index : 4;  pipe Index
> +                *      uint32 hqd_index  : 8;  This is queue_index withi=
n the pipe
> +                *      uint32 reserved   : 17;
> +                * };
> +                * The list_size is the total queue numbers that been man=
aged by mes.
> +                * It can be calculated from all hqd_masks(including gfX,=
 compute and sdma)
> +                * on set_hw_resource API
> +                */
>                 uint64_t                        doorbell_offset_addr;
>                 enum MES_QUEUE_TYPE             queue_type;
>
> --
> 2.34.1
>
