Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD813C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 15:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5766910E70D;
	Tue, 25 Feb 2025 15:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAZd9KaY";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284FD10E70D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 15:10:21 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2fc95e20e72so1524118a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 07:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740496221; x=1741101021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2Go0IdV6QW1Ce+v2HJ6x0iNDkR70FRKFeAv3O/K2DU=;
 b=LAZd9KaYJ1yZ1uQwVZa86ABJqJtjD3fcLQ9txKKXTQarH6vyACRhmH6vbi0ZOm9V+D
 +Rw9Ytu1YNj7CDuQw85+ODvAlOboUpzrOQJLECVMK8B6VwPj741eU0f+FWWi7p7PYOzd
 RKAZAI9raBb6w/IVtzdtPepNvnwLo9uKv4rrTStfLFE9r5JmgPUKP5PovUK/Vv8GO2db
 WE3WT/miyPJrSfkweMWDKzd5p6pnzpbIT8q0lM4cJOkiJ8TpudgLbp3ujV0/IiAtO0SN
 h8GCXQoqGImeOlGNAeDgbIMa7xaF6OU1vzGS4Nxr5tCr2uvOzC5A37zd2hWRTavJJh55
 8MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740496221; x=1741101021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2Go0IdV6QW1Ce+v2HJ6x0iNDkR70FRKFeAv3O/K2DU=;
 b=VCDUjVZsZs7rrVB4ZC5IzHilMq5nHe0TAxPpYeaYpww/1PV+hYGnwd74x2LAZUPw4C
 Y0GT0J1KBAMcEmtrTzTI1YKBTsW5kKcA7fEq+bMwgJinq2KPOYmVyLTyHsjSebCOf2E0
 LxmtTgEDJ7kJz9JBLQ4b1Dv8+GROx4bQSVEGHmPIVuOxUo7U1jwRKIJivdNlYr6FPcUg
 F+QpyQyv+xZCB/HITMVF+t0HGheNNQC8oz9Etsh/5G7OKLOExGF4wSlVNoYFrtm3MLGp
 HE3YwREHmPGUCB2B++VcAMwQWOSIpJy5a2KYdusUANgY72hIE+XdC2eXBeSQKR9uJ2do
 8FOw==
X-Gm-Message-State: AOJu0YxotEKlqu0YVRdM8lsuH5NLifzd6IH6D+KJPY11sMYYlsut4JZC
 XKSLxShuErueyv5aQ8keEpL+NGgPT3d8ZTmOJQRsaJIkXoG8H6e5etn2yrt18huDA9AtGDYSp9F
 F3sluhlvpRHpdCvK+S8ojWH4XjPRsqg==
X-Gm-Gg: ASbGncsRzoGwa1yT4sokcLbJvc409kYdMBk79Lgu8bUm60nIVRoi5C/BtokcgZDSQeF
 sZ2apilNfV4wTL8EbJCDuqH7CdjtOc2d52gRjbNCG0NfxJHGhzXCRTFJ16StvfggCOSJUilPSDE
 J33/oqUPw=
X-Google-Smtp-Source: AGHT+IGM3Bj/6n39Egx+xmE4OzV/hatNsKD14rAWWcG0V21XBeZT16uORi/TyE76VcHWJy6DBFkT3rXL89s6SIXXcbU=
X-Received: by 2002:a17:90b:3b4a:b0:2ee:ab27:f28b with SMTP id
 98e67ed59e1d1-2fce7b23dbbmr10564612a91.7.1740496220605; Tue, 25 Feb 2025
 07:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20250221144933.3440420-1-alexander.deucher@amd.com>
 <20250221144933.3440420-2-alexander.deucher@amd.com>
In-Reply-To: <20250221144933.3440420-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2025 10:10:08 -0500
X-Gm-Features: AWEUYZmK2Dcv9pRhA7gxktlqP8LFfsoKRdzIbj_Qzwy-HU3apAZmzByHIv0D-sM
Message-ID: <CADnq5_OXuxHMXfFaex3MD8WF8kx-yGDZ9eGR6u3VjHBTmDO9vA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes11: drop
 amdgpu_mes_suspend()/amdgpu_mes_resume() calls
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

On Fri, Feb 21, 2025 at 9:59=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> They are noops on GFX11 for most firmware versions. KFD already
> handles its own queues and they should already be unmapped at this
> point so even if this runs, it's not doing anything.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index e8aa28184bdd0..a569d09a1a748 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1685,24 +1685,12 @@ static int mes_v11_0_hw_fini(struct amdgpu_ip_blo=
ck *ip_block)
>
>  static int mes_v11_0_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
> -
> -       r =3D amdgpu_mes_suspend(ip_block->adev);
> -       if (r)
> -               return r;
> -
>         return mes_v11_0_hw_fini(ip_block);
>  }
>
>  static int mes_v11_0_resume(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
> -
> -       r =3D mes_v11_0_hw_init(ip_block);
> -       if (r)
> -               return r;
> -
> -       return amdgpu_mes_resume(ip_block->adev);
> +       return mes_v11_0_hw_init(ip_block);
>  }
>
>  static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
> --
> 2.48.1
>
