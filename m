Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E42CF6D5F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 17:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D31F10E770;
	Wed,  2 Oct 2024 17:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EnyHNX7p";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1058B10E774
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 17:11:04 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-20b2093f1cbso7948255ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727889063; x=1728493863; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfQdifI5S9eZuZ6xEBYYy4VOzERlOnuel8OKiK8WMHo=;
 b=EnyHNX7p7+S4B9cszhUJv68wzVVtViccViXBgK8YVFBqVhyczGdfKkczOny4qn4DM0
 Sm+MyNy3OewLbOMAQr1i17THFJLcXmWPx5OGqbImn/iWMXPWP6wv7gbgvC7Kfw1LXNch
 sLV9P6JPOpWzlqWWW1RRWHGp3zzWakExW/z4Lv/BqkrY0vnb37kEHFBlAR3WLsG+DMkb
 H22Hd7VvASNrlbnIBXN4vmer8l2BPghYZbinOwQGxkzQvw9IXZ+0O15Xa3y0leXYB2Fa
 EbibuiV6sTLs13pwypmLEhlysF7DvsvptWKvdMErig/DJ6d9ChWncMfWK5ChpL8sZF2+
 FwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727889063; x=1728493863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfQdifI5S9eZuZ6xEBYYy4VOzERlOnuel8OKiK8WMHo=;
 b=onvFhItRad//KvaELVM6fHKnd3kVDa8zEFpi0sBCb+a7Xpp582zkDZRKl+AEdn3oeS
 BR9lCM5z29I3iqusIkpagmdx74iQxgLcscyQOn3i3PwhVq15xqaYMcdYpqSBNQ3+PcZp
 gb6lQdKDwGFU/aPkqLUNvFgjZqA9FYfmSV6F977BrsCYUDxZqz7hSLTl7rKGNzBaVQei
 b2Q2PaEzguU/yKk99p8TnGbghrCIz7xmWKRRnrQTlpLzJP0i8GBqcBN1DfPzvcByWMry
 DxiOxn7IlYdktJ1scdlFE/VJ8qi2eMAbwqEtb4rOrcfBXhwMoVrq4P6LtsYCpgduv5yd
 v5TQ==
X-Gm-Message-State: AOJu0Yw+WmFLrUVJHNFmhLlSnUdCIqOwaV9pui8iaYNEOfhARQxe+kfR
 4ETVa6dm7M56dKzEfhMdU9Y2wmesF9qfvDQbWNytn1vAWVUGFcWNlZ4dJlPCGn1saEOUgs+z+qT
 L+76KkOds5dKcOLbT8VHOSKh4j8E=
X-Google-Smtp-Source: AGHT+IGdF6Jm7cxBDhGFHv3voMGMteUK5QIHRyT77y3wXEP89oYFmFe56MekGy5uoscv6pFJ2eBskR6VP/a2uuKzaMQ=
X-Received: by 2002:a17:902:f2d3:b0:207:d98:52ea with SMTP id
 d9443c01a7336-20bc5a41c42mr21922695ad.12.1727889063509; Wed, 02 Oct 2024
 10:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-2-boyuan.zhang@amd.com>
In-Reply-To: <20241002043627.102414-2-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 13:10:51 -0400
Message-ID: <CADnq5_NSVeP8Bn9-wPK1yu--buic7=nekWJTE9HOYGKsjfyxNg@mail.gmail.com>
Subject: Re: [PATCH 01/18] drm/amd/pm: add new vcn enable function pointer
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Wed, Oct 2, 2024 at 12:38=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> The new function dpm_set_vcn_enable_instance() will be used to enable
> or disable vcn engine dynamic power for the given vcn instance.
>
> The original function dpm_set_vcn_enable() will still be used to enable
> or disable vcn engine dynamic power for all vcn instances as before.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 727da0c37e06..f88241cdf9b9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -737,10 +737,16 @@ struct pptable_funcs {
>
>         /**
>          * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> -        *                      management.
> +        *                      management for all instance.
>          */
>         int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);

Wouldn't it be cleaner to just add an instance parameter to the
existing function?

Alex


>
> +       /**
> +       * @dpm_set_vcn_enable_instance: Enable/disable VCN engine dynamic=
 power
> +       *                      management for given instance.
> +       */
> +       int (*dpm_set_vcn_enable_instance)(struct smu_context *smu, bool =
enable, int inst);
> +
>         /**
>          * @dpm_set_jpeg_enable: Enable/disable JPEG engine dynamic power
>          *                       management.
> --
> 2.34.1
>
