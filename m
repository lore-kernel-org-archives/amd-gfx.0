Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8245DD609AF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 15:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D30D10E23F;
	Tue, 16 Dec 2025 15:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DT+aJcxU";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1101A10E23F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 15:29:16 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2a0abca9769so5688965ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 07:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765898955; x=1766503755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr3Gof58u9YJPfboarrtkfLOPQXqGnwnePKk7JXxizs=;
 b=DT+aJcxUBydhGXb5Pn9nb/lyNYvo6v/XuPiKSGPc9b72IarutgUfWLyJMM6aaTozIC
 kQCByEpUxIPIycTXxgtPO1DjU/tbmw0JlsoPHS4EPLfTjkDIiDW69GKcKrNCxzdKnacy
 FaEeoa4csNYdmth9VwRF/OvtLNl53Bk/twgM3KLHMxTFrK8yqL9UvDPozlVWrroC+8oD
 Vo9GMomRNRe/ylSogMsk1WWjyn+jBfWXdvihw+I6FozBqd43quAGCHtn9ELaSHZtlT38
 A51pAHRs1nbr4Ic13yIgV420eh+vPGvaBSWJqG8nBuCgM2OC64zO1+e5ZSxRD3JR5+cF
 gkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765898955; x=1766503755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zr3Gof58u9YJPfboarrtkfLOPQXqGnwnePKk7JXxizs=;
 b=mbpg7CoZZqro21ZaItrOZmcoWw7t9gjcM6q90IRr/D+J/e6/6oziPhMdnWHmUT4ibq
 zZZfRwT86UCUxticORau/tQu3/mQEwX1g3PNiGLimSE1C25RKNfTJgWAwXS3eoP6xLXw
 noH9aCKnSio+C1dDPHxua7R5UaJowKVcy14PmI86DAmhhKANYTyTmg0hqMHw4igPfhTv
 T1CQPoZrMy/fz939pZHlNe8qmTNmeRM/Ddo3xR6B+g2/trWZodMK4Sa+amCRIUCoEDfE
 hlTRyOOg+iZ4jj2R3NLO0C6m17K4tqpgtGPPi6nOLVRzIye+jgj8aBHhqm/JcTENj3Sm
 ubXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxvwCXuBxIpErbDmDCUFGkEYH1Mdk5zbJwnhj73M3jfL/8Tad3BNzzeUQl4ElCtl8vbyffRytY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxX4e0Cj93KI2z06q8xvRpX5A+4OI9oxMeD+t91MDRSAr3Sa8rX
 WyVcLb1eoSy2x+6Q4ZKl/zXQlp3ndpjQ2FI+SfP/IFev5CJ7d7XaIU4EGO2nfzvlMXF3EKkt+3t
 cAZaa/o5eRJA/xuxuShazdmgD8f1T5j4=
X-Gm-Gg: AY/fxX4nr637rNPi0kgsXz7Ca5SU27KFWhsVscA0XvU2QHRXNLOQkunmKlsTLT5cnd+
 CeVeOpULP/f0paZzjpakdSGSGVMpghAqjZphaSMs1kNz1pQWgOb8CpbenBKlL0tcidcEg804a15
 ayjSg6K4c8uLReS7fgvJNWm+otXrHc48REzncY6k19bwHDXg6loVMwM5g4O5EewydPFZQ4zir9R
 l0g8sjWY5MFMZpMpatADgylmTyLYlZuKlJ9309rquQk1IQ86jzuNbEJ0U9fQrBdvoUc6tty
X-Google-Smtp-Source: AGHT+IG9kcUP8Pi9U9VCe9+jqy+e35rih9Qd+GyQTJbDh/dChPu3EK/0GXGO9bipWaTXTvNU+Tefi0oHy/HN/K4UjYE=
X-Received: by 2002:a05:7301:2e32:b0:2ab:ca55:89bd with SMTP id
 5a478bee46e88-2ac30218330mr3818312eec.4.1765898955375; Tue, 16 Dec 2025
 07:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20251215115150.3581277-1-colin.i.king@gmail.com>
In-Reply-To: <20251215115150.3581277-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:29:02 -0500
X-Gm-Features: AQt7F2pxZJSCVbxZ9Qp5L5e3UwMyuAGBb-cNval3Rs_27mmLOu4PrjQHbXJDINc
Message-ID: <CADnq5_NRO5KqMq33yK4Bc04yC2wAPbhb0FvL+9D5T4PFDW6i_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix a couple of spelling mistakes
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Mon, Dec 15, 2025 at 12:51=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> There are a couple of spelling mistakes, one in a pr_warn message
> and one in a seq_printf message. Fix these.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c               | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 2f66ebb5b029..adffa44fff2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -830,7 +830,7 @@ int kfd_create_process_sysfs(struct kfd_process *proc=
ess)
>         int ret;
>
>         if (process->kobj) {
> -               pr_warn("kobject already exsists for the kfd_process\n");
> +               pr_warn("kobject already exists for the kfd_process\n");
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 5f8cda4733f9..d7d37f01f51c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1115,7 +1115,7 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data=
)
>                                 break;
>                         default:
>                                 seq_printf(m,
> -                               "  Qeueu node with bad user queue type %d=
 on device %x\n",
> +                               "  Queue node with bad user queue type %d=
 on device %x\n",
>                                            q->properties.type, q->device-=
>id);
>                                 continue;
>                         }
> --
> 2.51.0
>
