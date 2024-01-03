Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D2DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E14010E15D;
	Wed,  3 Jan 2024 14:26:45 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760C810E15D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:26:44 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2044d093b3fso6850572fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292003; x=1704896803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yS0Tiu9O6BHbhBr7UL/rMuBSIZA1H/GdwjxPEwb8h2s=;
 b=QVpWz5G6Aifc9/EsFOmYbgyrJN+WxJC1LAAQk/BJPi3pwmtkjc/TeKnEGUyCdxLdrH
 aqxayK0M8z0Pqvam1KmcqXq+mhAi+TvbiulYQhAArmFTRiv3FEdizhUUgq87cyeTioPB
 WuND4jsaTS3lY+eZ2VU6lhZu/baEXBneRmshlGqGUAH3ZJcb3aTjgCCbPgA207im1rXG
 Fq6eJ45msb5rrNNE4bDp5lhUxCLzZ8x/mewNe+kMbHVwYU2sVLIHdfOpOWi1WWwK/UHs
 kR9wcS0500mvDockbzOCtSfd//tB+KaHXvpRa9MWq6x47TleggN6lOj19CcxaDy7zSA8
 ty6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292003; x=1704896803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yS0Tiu9O6BHbhBr7UL/rMuBSIZA1H/GdwjxPEwb8h2s=;
 b=M2hjYv4nYyFvayWNoYCz43hrWUO70ERzVCDuRZ58H2m1GUt6w1izMJbPGY8pX0gi38
 3pWcyLK+vZT+ExJAWCXenAQTz8M/vJq1B7sl+wQT+sOMDF1a4nUQMsLg68FriYiyok2L
 HwWPAFFL4Ng8R+Y4QtMrKfmlwVhHpkZ92dMq3Mz0Lvjge6FAiaIooS7iWxg9ResH0flf
 dnSIeMiC6Ppuh7pq98eXuYzLXr54uVjwIWVMdtS+cWGcCitnyd6zDy5lXlLWBwuPhQeo
 AkHjvwv3nNTCt0JD5YjkJ8h2bOtj5o77EkqrolRbz4iN3YtVexwVBj/+2VRqIW/h4gd1
 JarA==
X-Gm-Message-State: AOJu0Yx0tRxStKzvbIIW0HB+eFGJUxYA5ViCal9qxFV/cS2JKiU6DeVw
 OnpytuFl61RW677x2THgCoF5M3rNW2uGLzLbdfYC3thP
X-Google-Smtp-Source: AGHT+IG2QcNU+8BPq6e0EC34kXUZchQ4jZoOgo4DBTWXr+IJwwkGoDENsu9uynK1suIg3T/OigKGWamJFDD5RjTzdNU=
X-Received: by 2002:a05:6871:d209:b0:203:d603:db8a with SMTP id
 pk9-20020a056871d20900b00203d603db8amr23313628oac.7.1704292003652; Wed, 03
 Jan 2024 06:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228221513.2069-1-marcelomspessoto@gmail.com>
In-Reply-To: <20231228221513.2069-1-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:26:32 -0500
Message-ID: <CADnq5_MuWGDF7LpQd8NvxsbV_35U2E9qLXZ25bwRbtK4VGRTng@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Removing duplicate copyright text
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Dec 28, 2023 at 5:35=E2=80=AFPM Marcelo Mendes Spessoto Junior
<marcelomspessoto@gmail.com> wrote:
>
> mod_freesync header file has duplicated copyright boilerplate. Drop the
> duplicate.
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
> v2:
>    fix the structure of the patch
>
>  .../amd/display/modules/inc/mod_freesync.h    | 28 -------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/dri=
vers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index afe1f6cce..cc3dc9b58 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -1,31 +1,3 @@
> -/*
> - * Copyright 2016 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -
> -
>  /*
>   * Copyright 2016 Advanced Micro Devices, Inc.
>   *
> --
> 2.39.2
>
