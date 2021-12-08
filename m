Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1532C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1489A6E10F;
	Wed,  8 Dec 2021 19:37:28 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD166E10F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:37:26 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 v15-20020a9d604f000000b0056cdb373b82so3804556otj.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/5THg/NcugaIBR+DGrR61d3G7yLVurjyF7eHuS1jyb4=;
 b=F+//PdC7Ck6dS1ETrp21CS+2gmF9Ap1n+8cKzPEb4d4NmuvpcIpdIlRuGYTHOOTWha
 DhEOeLVj4hsvDONAqQR3sCVlcsi+JCAABNDVRJm0sHGGXfLw6yezTcx4IhdgIewWUgQ4
 6FiL1HLsu/mPMbWEaI2NuoyonntfvFTtT40hriUqKQF68+xQstUVhH7Zyss8GwzPdDn5
 rzS+XxEj+rib9t2d083wIspeCLskqaFnJxcRNatnCpmX4oKUmbMvrIi81uY6oDj8XYb3
 vvAHJHntXOxyTcfUP/OObG8jt3riMc39iv+rjEHQ1eQTqyYYxpei1s7Gc+d2bum4nlkX
 FXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/5THg/NcugaIBR+DGrR61d3G7yLVurjyF7eHuS1jyb4=;
 b=N65+JjxORJoYvsdxylw9C5tRRoOUvcE1ewywv2PlKnFjGPEy5mvbTxXasecJM2NGu8
 gT3LOVYa3oWtTksBhTbelTD+xPmcJtScfIRm+FqmEMMJEPAv2BfLMokmjOKm+F3Iy+my
 M4ElzBNV5FHG1Jfb/lrhGtORWH9HmH/E3UILyL41uaq9i6hoEuXq5bSYG0y3P88i/8E6
 xhB1QCZZ+MHNo46uC2CVS/P7+Qs3D4FP4apXUm03xfMzj+BomOn2/wvg6H8KjbRzyZb2
 8Ee4StP4kEgF+xr81Ep23moJUXMVD+STHIAMt8Cx6pryEbdN43RzdEKViErkhXcGu0Ml
 hCHA==
X-Gm-Message-State: AOAM5305mylhuzAOQ5E+W5gi2edx0bGRyC0VquzUfb9iyPoNmwsPtYG/
 aihKS+Q2OrJ2VlhSLSOsW5w2Rv/Jz/+ofQ3S8QE=
X-Google-Smtp-Source: ABdhPJxrQvpPs9I7awdAL7TK9gsYyF59Ajnn/Srr+P+Sf/aYdt0jTiKn5BA9IwYcdSMnadqG+T51Se31u2eemILUaMc=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr1411945ota.200.1638992245936; 
 Wed, 08 Dec 2021 11:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-2-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-2-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:37:15 -0500
Message-ID: <CADnq5_P+yvpSBVt1WeMSR8qXTN5eUTD1HQ6EDy8G-ZVSppdXPw@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/amd: Mark IP_BASE definition as __maybe_unused
To: isabbasso@riseup.net
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 7, 2021 at 10:17 PM Isabella Basso <isabbasso@riseup.net> wrote:
>
> Silences 166 compile-time warnings like:
>
>  warning: 'UVD0_BASE' defined but not used [-Wunused-const-variable=]
>  129 | static const struct IP_BASE UVD0_BASE ={ { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
>      |                             ^~~~~~~~~
>  warning: 'UMC0_BASE' defined but not used [-Wunused-const-variable=]
>  123 | static const struct IP_BASE UMC0_BASE ={ { { { 0x00014000, 0, 0, 0, 0 } },
>      |                             ^~~~~~~~~
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>

Applied.  Thanks.

Alex

> ---
>  drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h | 10 +++++-----
>  drivers/gpu/drm/amd/include/yellow_carp_offset.h       |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
> index 9cb5f3631c60..ce79e5de8ce3 100644
> --- a/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
> @@ -25,15 +25,15 @@
>  #define MAX_SEGMENT                                        5
>
>
> -struct IP_BASE_INSTANCE
> +struct IP_BASE_INSTANCE
>  {
>      unsigned int segment[MAX_SEGMENT];
> -};
> -
> -struct IP_BASE
> +} __maybe_unused;
> +
> +struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C00, 0, 0, 0, 0 } },
> diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> index 76b9eb3f441d..28a56b56bcaf 100644
> --- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> +++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> @@ -9,12 +9,12 @@
>  struct IP_BASE_INSTANCE
>  {
>      unsigned int segment[MAX_SEGMENT];
> -};
> +} __maybe_unused;
>
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
> --
> 2.34.1
>
