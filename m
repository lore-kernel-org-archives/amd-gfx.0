Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C50C2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 16:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE2910ED4C;
	Fri, 12 Jul 2024 16:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lF9+P/wK";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E2D10ED4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 16:29:49 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a77d9217e6fso300524866b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720801787; x=1721406587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vArtvHyhZApsnh1Io1Dyp5IVvjG/9Cs3qGvLc3cCNIQ=;
 b=lF9+P/wKaME4FXmlItDWdN8c3s0hzfRG1hfhx04k3PBxVvpppn3/zsccP2V1xUnH8m
 NKQXI3nlqyFiCwwBlH+nkhqEs5cCkErnsKdkPMg912dWlk/y53yXkubL8IGfxHsK8DIv
 CbdHy2MJ/gpBfpHMh7R4cXEtK1lTBKQdv513yuR3Xa9Iu/voKAiYhnQAJWIcsyytXkim
 LsGyvUMOWezxUufc42lcCNdycGjacoNX8H5nc/oDRMixGY+UvmReJ2YqV9d6htfGS9SJ
 fpiShqA6Svxkj2qEvlDb6jR/HKyT+0H7SLmR+RF7W0xkFzTGqIzftO+3vbcJN/iQC6gc
 Q5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801787; x=1721406587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vArtvHyhZApsnh1Io1Dyp5IVvjG/9Cs3qGvLc3cCNIQ=;
 b=Qt7NMrbkJTc44g8Tzb8H1c+SB7oJmQ+cCxkPagybNDgYlXflAvUi9TWTrURyG0WeNe
 aAi75R5UkW3StvfpZjd69cMH5JGAvitiv/zPlhANiK3tNMQToFXa4nYEagswIJ5otrGS
 qup9GAuPuthDz28m1XO3BVifzqYSAEns6ioTcn+FFETviv/oQcnlVSo0f68hEBRQTq+U
 n0xuy/GCDgK3PtMCuIiiANOIsVWVupg+FJoi4BAI0DImyf7ykL7rFSmV2KF3lc/DieBH
 hDTgKOxgKXil8aazM1eO0Rc+cdpbbKiDjS+mQhbfDNNfCoblnTLJTrbXL+HskyHafgK3
 fNqw==
X-Gm-Message-State: AOJu0YxRGfRxY3OoiElpGGvnQgWIt6prZFPAfZ2F7E1yMyfk2mnFCZ7U
 LANoECFhLxSUxeVAQJiiJoESgjp1kdYaxThysVEvz7tM3ZwXbmfFI+07oRACneWjoqeHHEBirHG
 nhbhg3tsQ845YpcMIcf38hFy7aHY=
X-Google-Smtp-Source: AGHT+IFCWVn+mAQCtUGdBBmosIA0hz1nEiJTbXw59yU+2IzpGhADpxjbhxwgHPHLj0JQKQ8TXwd9wgRIc1/ZzuHyz8s=
X-Received: by 2002:a17:907:9711:b0:a77:e55a:9e7a with SMTP id
 a640c23a62f3a-a780b68a54emr1026905466b.11.1720801787159; Fri, 12 Jul 2024
 09:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240711140603.2860632-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240711140603.2860632-1-aurabindo.pillai@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 12 Jul 2024 12:29:10 -0400
Message-ID: <CAAxE2A7X8bCqogqUtST1TPTpnSUw=NbADonAH+KMij5ejK3a2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Bump KMS_DRIVER_MINOR version
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 marek.olsak@amd.com
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

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Thu, Jul 11, 2024 at 11:05=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> Increase the KMS minor version to indicate GFX12 DCC support since this
> contains a major change in how DCC is managed across IPs like GFX, DCN
> etc. This will be used mainly by userspace like Mesa to figure out
> DCC support on GFX12 hardware.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 802debd8d9f0..af44cbc90d2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -117,9 +117,10 @@
>   * - 3.56.0 - Update IB start address and size alignment for decode and =
encode
>   * - 3.57.0 - Compute tunneling on GFX10+
>   * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & A=
MDGPU_IDS_FLAGS_MODE_PT
> + * - 3.59.0 - Add GFX12 DCC support
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       58
> +#define KMS_DRIVER_MINOR       59
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> --
> 2.45.2
>
