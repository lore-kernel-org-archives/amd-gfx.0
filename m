Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A88C3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 16:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D71910E255;
	Thu,  3 Apr 2025 16:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQw21rb7";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C157610E255
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 16:11:30 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2260202c2a1so1653715ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743696690; x=1744301490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZ/ySvOChJ8DuQKdQ0AlueMT4sCUgLBJOAJfnUFaq3A=;
 b=KQw21rb77nqtMF0Zd6f2hiC3KhsIdfvSa+yn04+hHmyfv9OS83YalMAERYqELtvafH
 B0Iv8Tuo0S8Z0k9KbmsBmCHtTPdFanr4edF310u05bMp21piRryjWJ8QNnQtBKw1XUiX
 quGNFR6hOIDscNOW0ic4nQ/I2FeT4AM6OweOWQk9pmxf088zlcmWn+c14sMizKIfjUi3
 I984UBRaxmszhUKMdU/i4To+4tp3LkLdh59JeELXhZYdvR8p26XDBPbd3vbHhANGr7Zo
 eQ3Q3G8pmBjfrVjQS4DDjsQXXjZ/KdJauuNtuH/EGHVQ8p4NIfakjbh5viTxl9BdLqss
 ccvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743696690; x=1744301490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZ/ySvOChJ8DuQKdQ0AlueMT4sCUgLBJOAJfnUFaq3A=;
 b=HRVs436cgmICUMtolZUIqPffpAPETBymid84a+ns1e9Jhzg5UK1CZBY0FR73D5s2sb
 UnM60uVMvhh5nd8LiqqMXMGhq+RoT6PLawt6ilrXfJEc6dPvBS+OFms4/kvzNYF4JNd8
 2eiLgUFB6dE/1XXfl1lq63aNtlfhmt5ILJWsDCfamBueL1gDeVafBO0a+gOMf4I/FvLt
 w1Y4ofTuX5Ej9YdXbFPWHwWwxbtpun31DWw4/KhCgLGlBXy08Y3k83aGsnq7xqi04EMs
 divVwdYHUqzpr6NReYnVXFtvlCOF/wdqxLinUzu3RSBz6RYge/D681Fg3R0LrMphEJow
 o1pg==
X-Gm-Message-State: AOJu0Yw0FF71X8W8SxZEuyLbflYlGxkHXdEnysb0WPTVew9ZPnZYy0zh
 RjJ+vrPCkbk1ZMAgXvLWu4ssxPdvAy+j2rti8FAzY8DTN4nUhCuw6W3YSfL3axYDhIUgClPOMmL
 5TvXC8SZQJu9Nc62XN7HljhZqsVrcmw==
X-Gm-Gg: ASbGnctMnf9amHewnjqfWsrlnBQRbx1wC7zrnTkgRRGSqt+zbxYMkOw9hDQDs7bVuW/
 Jvq8XfrKrYfwac3Xq7O5+kck4DrD/dWzk9pP2nDXCP4A4c6lyPLsfq3WQaQIrYNCVBW4D1TIktm
 7kJQn2U4dZI1fbbEg1cnWsvDL/uA==
X-Google-Smtp-Source: AGHT+IHfvJa4mmOraGql689TaG/0925b0de8DABdtwZrB1kAmBB2V3n4bfhXl67yF3XONZFF57EZpuEr0T1jvnL7Z9Y=
X-Received: by 2002:a17:903:41cd:b0:21f:519:6bc6 with SMTP id
 d9443c01a7336-2295eeec6aemr50564055ad.9.1743696690338; Thu, 03 Apr 2025
 09:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250403094355.1866897-1-jesse.zhang@amd.com>
 <20250403094355.1866897-2-jesse.zhang@amd.com>
In-Reply-To: <20250403094355.1866897-2-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Apr 2025 12:11:19 -0400
X-Gm-Features: AQ5f1Jo9TvIlMs54DCkTq8SzcO5FZZYdL1V0icE6oDDRSgse_N8JIPyovoaZml8
Message-ID: <CADnq5_POjQXnGokhv6JkmNXiptQKA_5xZc_DwVdhCpm_DwisJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Enable TMZ support for GC 11.0.0
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Tim.Huang@amd.com
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

On Thu, Apr 3, 2025 at 5:44=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> Add IP_VERSION(11, 0, 0) to the list of GPU generations that support TMZ.

Are you sure about that?  TMZ will only work with user queues on gfx11 dGPU=
s.

Alex

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 464625282872..1eb9242436ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -843,6 +843,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(9, 3, 0):
>         /* GC 10.3.7 */
>         case IP_VERSION(10, 3, 7):
> +       case IP_VERSION(11, 0, 0):
>         /* GC 11.0.1 */
>         case IP_VERSION(11, 0, 1):
>                 if (amdgpu_tmz =3D=3D 0) {
> --
> 2.25.1
>
