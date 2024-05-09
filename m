Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA916C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 14:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B8810EB36;
	Thu,  9 May 2024 14:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GOId9HFT";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C4310EBD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 14:45:50 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so647847a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715265949; x=1715870749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1fPd1IIRAzqvSxwopNc9EuFLIF9ephyxeNFhe8aTj8=;
 b=GOId9HFTH+9VwSbgU+Cz9TTlvKdB5FXND2aSSG8VK52ndQSOzobO8Jhv3+jZiqE7Zz
 9ly68hV0G182okdDLy9GrjnlEXHayZJDEyayriOu8yuFu7fCHNa3KiAYJLApSB4qjiZ6
 FXMzVN0H3ZxCK2dzvjh4Bu30j78iuWUW6LZ/fVQKO3x6c5H28gCcAhx8rI2BrvqPYFHW
 4HbEx9ehWwnAF4yUlzkCDXhT2YRpsxSejqqG1CYIMW0CF+tkEWWpJMxfZnypeUp7Y9jG
 eyVpo4WtkB4Qlh3HxynsnwvruK5GvAuqt6SGlIkU9KvCusC9Uvbm7tnbaqZzdtlq4OGl
 tR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715265949; x=1715870749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1fPd1IIRAzqvSxwopNc9EuFLIF9ephyxeNFhe8aTj8=;
 b=qNyV9DgDf/BGEGikS2fBg/OOOecYRXxrNbhq6rdKe6ke5b02PY1WJ9TUZYCFCsWmgL
 3c3jjrgT5Ug5f2Uw4DmD/zfPsoMnCmeneHkZ93zDeyOvCRZmfQ8zP9zdcIxtVCLWrSuL
 OuHAMxqG5Yc95y2A3HClYah1QGLaFszbJg3KySX1Qt9+fhyaiFYzUZNUsMbqXoyYjVmw
 u8yRnXVKf+KBLoHN6xK4vudF9BdCLu8t8Fe0axekp+xQ8TAlcPLfmk2MozpbhdQa77It
 Qg0afnmCH0rUZGvEOaaMmCtXUpr+pOFmY62tZwrqpEOASWBtt4JEQnsEWItE72wQZBqp
 aCHw==
X-Gm-Message-State: AOJu0YzlBZUizwLVf3/y46hpi0+zBgIR1/qC4ukzsUbf7ydWJvEeuknX
 kXCnVZFsrT9eAILZgfhj/ZciLYd7d0JNQVzjjQCwiOONrIQDfxKk8cP5RoNpJTlSg+Z9nsxOm4x
 0ZRXBN2KUyVRIfJq1AkWfZgJ1oPu+Mw==
X-Google-Smtp-Source: AGHT+IEE/wtn4rjyNskYSXWLKzYLVKj++WBGmqlBpvMbwNxusZYad13jw14rpYwLzUBZz+9RRqLNnMSxRWbJHBCNINo=
X-Received: by 2002:a17:90a:c7c1:b0:2b2:9fea:4d04 with SMTP id
 98e67ed59e1d1-2b616ae2dd2mr5505917a91.44.1715265949465; Thu, 09 May 2024
 07:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240509014516.533962-1-shaoyun.liu@amd.com>
In-Reply-To: <20240509014516.533962-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 10:45:37 -0400
Message-ID: <CADnq5_MjQ-rmgXmo4T4Zav16JBFj1rzh2HNXU5q3CRuT8wwUfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable unmapped doorbell handling basic mode
 on mes 12
To: shaoyunl <shaoyun.liu@amd.com>
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

On Wed, May 8, 2024 at 9:52=E2=80=AFPM shaoyunl <shaoyun.liu@amd.com> wrote=
:
>
> This reverts commit 9606c08e178f953d22e50b05c64b4b1a48051f3e.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 14 ++++++++++++++
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h |  3 ++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 76db85157bf9..4f123d88aa3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -525,7 +525,14 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_=
mes *mes)
>         mes_set_hw_res_pkt.disable_mes_log =3D 1;
>         mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
> +
> +       /*
> +        * Keep oversubscribe timer for sdma . When we have unmapped door=
bell
> +        * handling support, other queue will not use the oversubscribe t=
imer.
> +        * handling  mode - 0: disabled; 1: basic version; 2: basic+ vers=
ion
> +        */
>         mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> +       mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 1;
>
>         mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 0;
>         mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D mes->event_l=
og_gpu_addr;
> @@ -972,6 +979,13 @@ static int mes_v12_0_mqd_init(struct amdgpu_ring *ri=
ng)
>         mqd->cp_hqd_iq_timer =3D regCP_HQD_IQ_TIMER_DEFAULT;
>         mqd->cp_hqd_quantum =3D regCP_HQD_QUANTUM_DEFAULT;
>
> +       /*
> +        * Set CP_HQD_GFX_CONTROL.DB_UPDATED_MSG_EN[15] to enable unmappe=
d
> +        * doorbell handling. This is a reserved CP internal register can
> +        * not be accesss by others
> +        */
> +       mqd->reserved_184 =3D BIT(15);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index e3211daa9c2e..ffd67c6ed9b3 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -239,7 +239,8 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t send_write_data : 1;
>                                 uint32_t os_tdr_timeout_override : 1;
>                                 uint32_t use_rs64mem_for_proc_gang_ctx : =
1;
> -                               uint32_t reserved : 17;
> +                               uint32_t unmapped_doorbell_handling: 2;
> +                               uint32_t reserved : 15;
>                         };
>                         uint32_t uint32_all;
>                 };
> --
> 2.34.1
>
