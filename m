Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1C2C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 15:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E3F10F703;
	Wed, 17 Apr 2024 15:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1daf1oi";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBB410F703
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 15:53:19 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2a3095907ffso3366007a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713369199; x=1713973999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO+7HnF3mNWqTwMJmoBylNTBN49ypo1mwlk3zU18BXE=;
 b=d1daf1oiANV0dr/QVjDelS5b8ijDePdAIpcIjfo+H0hfIrVshCNLCFg+wCknal7IeQ
 TF8nHgh2EtsTGzo49Mz/PlZB4vS4coL6IwL4/Fq7ixxxB4oLGaT69caX/NS4a6eVmdpX
 qrpRcTJKqkqgJu4ZMnOHLcp8wT4lAJPg7EvQ2M9E30Qh2W2qtBRzdYQCI7ez/zwDoBRU
 9DPWR+6O8LzSpJ1aODN4gTbDRzRpkGJgCMWuRvMGqGUGaNC4iLBfJjRqMgwZcAJGO573
 oVUgd/eIKRr57ni7edzRNUUcHPW1o/y6JhdQ8QIPIbnhw3GaOpMdSdQpxC/iconntNLM
 VaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713369199; x=1713973999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wO+7HnF3mNWqTwMJmoBylNTBN49ypo1mwlk3zU18BXE=;
 b=Y4H4ondGPn6l3vUb0LQbOSNEtra++ZTb3F7nP4/2SKDl2HhP/M0g8rKDKeI2Ps6mRn
 829M8e6l+TLyYoKtZ7dhjk8r7Lo5HHhMsFhgDh/GDL6c2SU1+IT50VO5bKMNuy4NFtPp
 +MAWSpcP2kiLVh8i3ZN0f6ELMCFrI2xuZRo4Ngf7q9IreblpM9pkOjoGVO30fRaV4+v3
 xNs7E5g1l82/9EISSyX5FmHCfX8vWiwGotQY8k2Vnga+diaC2mKLgbY4tG3g0WfA5r3P
 K4i1IOYPumtK+YuU1TQXChv4AARbmRaEVCAzeT74hmejRz186Hw3qDrwa1Ati3OqAfT4
 MXxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwVHHDNclieNwkPERgby7tbpf8lSfab0jJDA2gyl5WDKUA+mpUl1HxtfI2O1Rmbs6F240enKF6iihUvRXNrAZhqHmxJlUo6L1rQD/32Q==
X-Gm-Message-State: AOJu0YwXJZQdUr+h9mdy0zwM+ttWYx0lVZT5+LE6vbSdNf6I8yQ0U0WP
 a7iV3q81+h6/tzP9jMn3ktTDDuk/TfQL1x3xYTCmGhAakbMkfTj7hrTXF9Sv3x7PTmlTFUlLPtO
 j9iS+sqsB1TbkSHdaA7+7fJpYTPE=
X-Google-Smtp-Source: AGHT+IHe0QInENkcs/MS74JOEYybSJeNi0gjz0ptfIYQeA5HDFXbKhl61j4r3hbI46GL/AUzdkyLgB+Ea3HlvEu+wzE=
X-Received: by 2002:a17:90a:3ec3:b0:2a6:c503:95f2 with SMTP id
 k61-20020a17090a3ec300b002a6c50395f2mr13970626pjc.16.1713369198645; Wed, 17
 Apr 2024 08:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240417093809.168002-1-sunil.khatri@amd.com>
 <20240417093809.168002-6-sunil.khatri@amd.com>
In-Reply-To: <20240417093809.168002-6-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 11:53:07 -0400
Message-ID: <CADnq5_PnCm7h1ZfbpxJ==GHNBYPZriaQN-ftAwGrGTdrryB8BA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/amdgpu: add ip dump for each ip in devcoredump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, Apr 17, 2024 at 5:38=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add ip dump for each ip of the asic in the
> devcoredump for all the ips where a callback
> is registered for register dump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 64fe564b8036..c1cb62683695 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -262,6 +262,20 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>         drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fa=
ult_info->addr);
>         drm_printf(&p, "Protection fault status register: 0x%x\n\n", faul=
t_info->status);
>
> +       /* dump the ip state for each ip */
> +       drm_printf(&p, "IP Dump\n");
> +       for (int i =3D 0; i < coredump->adev->num_ip_blocks; i++) {
> +               if (coredump->adev->ip_blocks[i].version->funcs->print_ip=
_state) {
> +                       drm_printf(&p, "IP: %s\n",
> +                                  coredump->adev->ip_blocks[i]
> +                                          .version->funcs->name);
> +                       coredump->adev->ip_blocks[i]
> +                               .version->funcs->print_ip_state(
> +                                       (void *)coredump->adev, &p);
> +                       drm_printf(&p, "\n");
> +               }
> +       }
> +
>         /* Add ring buffer information */
>         drm_printf(&p, "Ring buffer information\n");
>         for (int i =3D 0; i < coredump->adev->num_rings; i++) {
> --
> 2.34.1
>
