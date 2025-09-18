Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B90CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 19:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79CF10E1B4;
	Thu, 18 Sep 2025 19:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ju1Kmick";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC59310E1B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 19:59:46 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2697051902fso2586105ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758225586; x=1758830386; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/JnR6CHVRkdjeD3ESyyKxM2slrC6HX/Vrm2TCe2k10=;
 b=Ju1KmickMFOh57ZljZ72ncb2MKfO3v2Ze/XJbqwfEppUnSZo+I5J4e76wOo71K3bM9
 A93sJkmyHOs4la1CVR6/U15NIgzCTT9//NVLChRhFHR745ORemRx3BZD+yorozUpQdE5
 ZTitil5Ri5svS2GP6pFhH9dDGk6gailP1d13/7iIw4BUWdYv5S8f8v4HsZis/0aT84PD
 GapWh7MvDdfhIvaVhTxMD6V03lUyQyQhL20UQ6VnAwGX/yc67duzKeRF43cUOcN0sd7g
 1DF+aK3jURBreZxDcq795mDBPn5EshBxDX03DJwd1mqpUbHMjNwf7DJyIMT0ounzqB0h
 f1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758225586; x=1758830386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/JnR6CHVRkdjeD3ESyyKxM2slrC6HX/Vrm2TCe2k10=;
 b=xGjZknv6MVL1sYxRKJfyxpXg4prxY+zPq0saMQ2d702hpkj1ST8i/KqXadWxSjhH4f
 70F2wszIxAuqfnrTuGNh3EPws/0nMJTW5HZzyH/d8bkIDXWMibTefg3CBsTzLvlLt1RA
 u2IWixhfYYmay2WlKfBOsNI7qjlPIPW9/GAY3jtLrdGLrRgVSZG47AopnTcrVABnwW49
 iA0nmxDC6ZfdDExXEDQJOiZiCR4lJ3mHQJLgfCNnui8EjJNthF9dVYj7E9dEd4jCoEaz
 AZbhK3X9nrQh3otmSly8RHAcK3XJCreQb0FIxx9V9/+xhzQQu7dt4qiphOjppCtCEB8r
 Q6sQ==
X-Gm-Message-State: AOJu0Yyuw2wGgWr1zPmf8BkBJeIJYYfoEoUAxe3/+02cnT5g/z8ksQDO
 R13i7mXZfFcxfPd0m+a7+EOQPX5igxaM53nwWnDCD5nTjEUz9/1y+ZyqU3c+GuANlxhpmgAOG25
 PREgCgjfKxKXEsrwbQbcBeLTD08fkT3nP8Q==
X-Gm-Gg: ASbGnctNHaM1uHgWFoyHMtidfYwj0WYWO2a5OR4oLag4CKbbMHLuJYKNE1PxCEXvZmY
 0Rx9fATUdIki81TvuvJf4lUY66twORjPTQRdAhBD32wiJrws5o7xyDmQBEvtfojyCs8GwV+fJcy
 DwBObxm4Bzcv9gZKqm7bXqa2zL3swHCS0l7Cre3gdFNIqMQqD3W60zgJ8fFIm307BSqnnKjlium
 rzYkYvSUob8nXnzrDbwqMKSUg==
X-Google-Smtp-Source: AGHT+IE5/MWhEJPD9d4qmVPGvMjt2ZQ3wRGfspxFqHyGIL5+umP/IhTyGvzlS1iYSb0Lb/R9lP3sfUHahYPu4LBymcw=
X-Received: by 2002:a17:902:c407:b0:269:8407:499a with SMTP id
 d9443c01a7336-269ba4094a8mr6409405ad.1.1758225586332; Thu, 18 Sep 2025
 12:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 15:59:35 -0400
X-Gm-Features: AS18NWDDtX59aOn6Cyzwr0rfNyevH-7BI31u-gS0jiPOScrwLx59B-r3d0LJ3go
Message-ID: <CADnq5_NAyA5wiqUrN-PVsY2fLS1+1XkkAqyspp86-DSH3jzQyQ@mail.gmail.com>
Subject: Re: [PATCH 01/21] drm/amd/ras: Add unified ras core folder
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Candice.Li@amd.com, Stanley.Yang@amd.com
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

On Wed, Sep 17, 2025 at 9:39=E2=80=AFPM YiPeng Chai <YiPeng.Chai@amd.com> w=
rote:
>
> Add unified ras core folder.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/Makefile | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/ras/rascore/Makefile

Same comment here.  If this eventually gets populated, just squash the
patches together.

Alex

>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/a=
md/ras/rascore/Makefile
> new file mode 100644
> index 000000000000..e69de29bb2d1
> --
> 2.34.1
>
