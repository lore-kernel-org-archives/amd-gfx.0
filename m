Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72659E9370C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 13:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE2010E406;
	Thu,  5 Oct 2023 13:50:05 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E30010E3ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 13:50:03 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1dd0526b5easo701290fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696513802; x=1697118602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFs9nuSO33/g0aHgEIr3HQKftYsdWjTX79hFu+4Qz3k=;
 b=C6I4MZgRcYJzGVijGv+dSzVQAS4xvSUlpS7MBioDsrYTH7hqGESP9CPp76tpbWWbIV
 /F0nWGreKiLQqzzd4Zz8TvxBVMdDAdMToX86uszmD+qY1cQ/oU5Topu2+6mOLVZHg+pH
 Vomb5BUOgZVBfxPtOz84Oj5v3qgMZViSVwWBtT59CMVsCmPFURcDXZNLftVMj2OqYVnx
 pmOzJWOzysIunbc6bWkDFjdJTACC+f0EP9+U7CUJHfQKegS7lT4HRWzNXcyL6k9xndy2
 tWetOKPUilY6Au16IrXJlyydXhzfss9d27Z92vjBHhgDWZKNeFWFNFSi6Lig1Kklx3XY
 dnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696513802; x=1697118602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFs9nuSO33/g0aHgEIr3HQKftYsdWjTX79hFu+4Qz3k=;
 b=aSCIa5t5JVJAsTw6LlE0PEp0pIizh9AP9u9a3Bf9OySRttt5ybGfhu+U+gnK0e1f9v
 mYwBuxl26U8vcHLe2ljRj6qgpiAIl5ssSx+uXNzfR0mGaJ11aBmlU7YZyGlPVLeoLVrH
 deQWYxys1+jb2MHICGZMd02d7iMmAggGWXFScvIwPsBNsSwNeQyDC3BvD7ch6OS3F+T8
 z9HT2/1d16D9HjXYLIcA8JIWCksD/BNzoixTwOQLtELavlRiHYJ/NP/3VE999asd1CIP
 eSfAH3+N1vhf7AmCXu9WfqAflGXnP49vX3bWKXoU5sEr/uJGAKyn9X/6bFDupKoEpi0a
 s7Cw==
X-Gm-Message-State: AOJu0Ywe7CqTaMlFbGnJhVqtMK9Qc97jgfUf8p0hvxZZuCA8/V3SiNqf
 9+NeWYpWwXHwYsv6DpD/hOofREw9rp+fOWbyjoZ2m0X0
X-Google-Smtp-Source: AGHT+IEylvHhxDU+oJIs2MreulTLpKYWwT3x2QyuYVAQq7n4NUE/RoarolITJ/dsGqwF68o7tSS3xtwSusA47miP76U=
X-Received: by 2002:a05:6870:e393:b0:1dd:4271:3a88 with SMTP id
 x19-20020a056870e39300b001dd42713a88mr5098541oad.58.1696513801883; Thu, 05
 Oct 2023 06:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231004202253.182540-1-mario.limonciello@amd.com>
 <20231004202253.182540-2-mario.limonciello@amd.com>
In-Reply-To: <20231004202253.182540-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Oct 2023 09:49:50 -0400
Message-ID: <CADnq5_Oya7mhohw2iTPe_EW5oDE5iMMBn=kVgSZk6HW69V-P+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: Fix UBSAN array-index-out-of-bounds for
 Radeon HD 5430
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Felix Held <felix.held@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 5, 2023 at 12:42=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> For pptable structs that use flexible array sizes, use flexible arrays.
>
> Suggested-by: Felix Held <felix.held@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2894
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/pptable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pp=
table.h
> index 4c2eec49dadc..94947229888b 100644
> --- a/drivers/gpu/drm/radeon/pptable.h
> +++ b/drivers/gpu/drm/radeon/pptable.h
> @@ -74,7 +74,7 @@ typedef struct _ATOM_PPLIB_THERMALCONTROLLER
>  typedef struct _ATOM_PPLIB_STATE
>  {
>      UCHAR ucNonClockStateIndex;
> -    UCHAR ucClockStateIndices[1]; // variable-sized
> +    UCHAR ucClockStateIndices[]; // variable-sized
>  } ATOM_PPLIB_STATE;
>
>
> --
> 2.34.1
>
