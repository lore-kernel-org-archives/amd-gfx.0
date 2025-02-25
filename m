Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F06EC021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 19:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E618610E7B0;
	Tue, 25 Feb 2025 19:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ut4Bg+zg";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DE010E7B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 19:25:18 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2fc383a11cdso1500000a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 11:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740511517; x=1741116317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lW0Xlv11qQf2BeqC57sxJYuS6e9OOJv4XLnCmYnHWmA=;
 b=Ut4Bg+zgPR+Dpc4iFeGzu7VJpGajXUmfXRbtBoHgPqX+ZmRKIDii4vPGZQwngh1Kof
 VkrEVKxQ3Gofb4Md+EL34WmIREmXAvwiohT3nSkX0l7NrjsAFo0OI4OhyUaRVpET/7ao
 PixQ7upifTyypdcW2xKhKjhdhyQ9GF6Wr4WzumLrADTd3kPcaddhiCNoe56Rp2uqN1B4
 0zz4WTjK5e047xBwVWVgo05ahgRnjzd1c56FHBnN/dlXJ5S4GPVvhkNzNZLykMPflbfM
 5QDHKEOiyo+zJHCBRvkhxWtCh3X3AOJbyAYhZO3/GLssyUgNQeqnzWx3CfeOQoXDDutm
 OGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740511517; x=1741116317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lW0Xlv11qQf2BeqC57sxJYuS6e9OOJv4XLnCmYnHWmA=;
 b=ms9zGjZqq0pTQTik8T+gUni+F0sZ3C/MPunkfscGCDijCXd5qxTpesyeKJYGHOKzRr
 0rQ9RJmRyn7tSdYUJkB8/qg2zaCmIHRQZkUyIs4qSFvAQ1z0suavQynPeMRtLRqjoXHS
 tlGzmuRjU/cJjK8Z/0yXLJEg1WRWolz3epBgIiZSMHTNq/a8Scky4UQ3APlqAxJlM9/p
 XsqDS4N2hGL/x09SPQRBQvq2SKCSEjVVKrAwjhTSJVHgHZXoK8HZpremFYkKoucxTgZT
 Kb4VRAUIxyg1HQDPRbpT58cOgXe0Pw2JaBVAq01mWGkoA7AGGQ0SHSu5Du6MKUWBp5dN
 28tQ==
X-Gm-Message-State: AOJu0Yy9pgqc6T7If0qSKzUUWBZJwAEyQrlRYfk/v20TPqUEkF2glMwg
 6ttT8HoHQsozAo8gdfZE78Ux4Ys9GMKzBsJFZNjNnkKd1M3epG0NMAyE54fNXjESOt/irJwFtsq
 zHQNl1/E5ssfvNlfjc1nzI4lCeMA=
X-Gm-Gg: ASbGncuEoD6lXrIvruwYi9HsPC3vtxJAs/713A0Nv14SQqjqlKPrNPXtZVgzYsNGDm2
 wh4xjfHGB52WaNi/shkDs8r2AxFfnOUG9TIYVT/3cFrnYnRncNJnG0JL9aavOa28uxUXeyRslT2
 XPdw4/WiU=
X-Google-Smtp-Source: AGHT+IFp07c33GYOYmYHKyrt/hH+4ZIgfffQYIfZga6vS038xM0hYWSyy03TvPxilLtIFVCUp5VU7u9D1l7rvwuo4cs=
X-Received: by 2002:a17:90b:1d84:b0:2fc:3262:9465 with SMTP id
 98e67ed59e1d1-2fce7b4f5dcmr12506152a91.5.1740511516855; Tue, 25 Feb 2025
 11:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20250225091003.890770-1-jeffbai@aosc.io>
In-Reply-To: <20250225091003.890770-1-jeffbai@aosc.io>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2025 14:25:05 -0500
X-Gm-Features: AWEUYZlmx5OU2PqU3qDlSpC5TCu0PonEe_n_KnZ5f1ZEO2ccPXptJrhzM-V6hSw
Message-ID: <CADnq5_OndySoU7HTzQ=sGoKAru5pQenp79uvVCwH46be4imz2w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove undeliverable entries in RADEON and
 AMDGPU DRM DRIVERS
To: Mingcong Bai <jeffbai@aosc.io>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Kexy Biscuit <kexybiscuit@aosc.io>
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

On Tue, Feb 25, 2025 at 4:10=E2=80=AFAM Mingcong Bai <jeffbai@aosc.io> wrot=
e:
>
> While running:
>
> ./scripts/get_maintainer.pl \
>     drivers/gpu/drm/amd/display/amdgpu_dm \
>     --no-rolestats'
>
> For a list of Cc's, I got two undeliverable address errors from
> postmaster@amd.com:
>
>   Xinhui Pan <Xinhui.Pan@amd.com>
>   Hamza Mahfooz <hamza.mahfooz@amd.com>
>
> I tried to contact Alex Deucher and Christian K=C3=B6nig back in early
> Februrary, but received no reply.
>
> To avoid warning emails from the future, remove Xinhui Pan from
> MAINTAINERS and add Hamza Mahfooz to .get_maintainer.ignore.
>
> Suggested-by: Kexy Biscuit <kexybiscuit@aosc.io>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>

These and a few others have already been fixed up.  Thanks!

Alex

> ---
>  .get_maintainer.ignore | 1 +
>  MAINTAINERS            | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> index b458815f1d1bf..3343330fb11df 100644
> --- a/.get_maintainer.ignore
> +++ b/.get_maintainer.ignore
> @@ -4,3 +4,4 @@ Christoph Hellwig <hch@lst.de>
>  Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>  Marc Gonzalez <marc.w.gonzalez@free.fr>
>  Ralf Baechle <ralf@linux-mips.org>
> +Hamza Mahfooz <hamza.mahfooz@amd.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff26fa94895d..d6ea828345fdb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19657,7 +19657,6 @@ F:      drivers/net/wireless/quantenna
>  RADEON and AMDGPU DRM DRIVERS
>  M:     Alex Deucher <alexander.deucher@amd.com>
>  M:     Christian K=C3=B6nig <christian.koenig@amd.com>
> -M:     Xinhui Pan <Xinhui.Pan@amd.com>
>  L:     amd-gfx@lists.freedesktop.org
>  S:     Supported
>  B:     https://gitlab.freedesktop.org/drm/amd/-/issues
> --
> 2.48.1
>
