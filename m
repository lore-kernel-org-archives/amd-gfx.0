Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92469C83029
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 14:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A1D10E231;
	Mon, 30 Jun 2025 14:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y8Q4iBC4";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D269410E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 14:26:05 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-31306794b30so560969a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751293565; x=1751898365; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRxYpul+LUJLaVzLU+5/dJUPlmelMIXwyM9npPqIARk=;
 b=Y8Q4iBC4dCSJrJhknHSC7QeANKgCU4p9VKpWl8nL9ldJKiC7KQL4pQwPr21Owd6EDP
 XrgALadAsK7XkWa8T3W0lNBXcsSbreoptlFdI8eTfVzU6ZHOz/T0Zw//r2GOQwoA29XN
 uhDeaTbwCp+AwpdSvxsjsHieUcRbG5SHAC3yOz3MHHFo+jd0OxIK65UfRacSLuLB4pab
 TIRELYvkqzBrfRDTMTzYmEJpwkcIlp+oZzKDCc7GodbP5GqXZc54B3A69cfWAebkqjM7
 L5cLwHyDbCPmiiZA2HCPLZGomShGJ6KFfYy6cURPdTCMfcfroS1pYAtMStCCK1ZBEFDV
 HFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751293565; x=1751898365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRxYpul+LUJLaVzLU+5/dJUPlmelMIXwyM9npPqIARk=;
 b=fUtwT6WyN9KZKS74cvmWYAa3M27FrhgcPwDMSJolHXVNrto3CZfLGSJIoi/oXyLKK3
 J9KNFb11AQSKriccJtBSayUVncDZzvVj3tbyQVxdnrSkGcL4rZ9IrbwD6nHZohZVKTjD
 e8hVOIqYgVq6bTgSto8YXr4bmHjfv6vAr0ZfUrcwO/OnMPzcbDQvgyXZeqCrgaST4YMS
 ssuJfwhkzISPyWMD0qcmL2I2C+3TQL56ybjvX+46LUAotf2xN2w3GdQiBqpGpF0jCgxB
 Tq90wYUT8jOTSQTzVnlORfI0rLsmI0rjyiyaaH0ZGcmb39msCM9f2FgjXg9G9sl1S9Rx
 +dXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMOwUfPojSs6N6W+AvPX6ABZPzCkzt8HPPsL2LhkKKtSYS4LNN5qP2qId+0kOAMcgY4/XPdhw8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXuGujfqwS9Z1SeNcaTEH16QgYqylUFDpIL192dyLgx95T8Z3h
 R1EjocNIicv0/XCyIPeujkmhhIqmAp4QqkiTgZmBagtb68M1KPdwIPAk/n3LHPpBPFaYhjMn4RM
 LoKEJscdyaG8GafdFc9j7nAb2M16gPo4=
X-Gm-Gg: ASbGncsQ0j5K1ghysZe4tsqdQPbRvEpKYg8sL/x8bGydn74cSbMAJaTNXYU75qNz815
 ADto7st1mltYURBwKgcRvg8/6TPFl9XZdY9gmQqq8GL1+hbmL6mHC6C7hRk4XZXbLMc/5ibwqVi
 r1RKnfC9XWp3Cvlyq7cuyUkOY6S0ZkB8HII+uyC/d3Sdo/
X-Google-Smtp-Source: AGHT+IH0iSgYGPC1HHQ8WWzT16uYaBy/1joGF8VQqAdRo/QFeVfWzwOhWWhcj4zpTj42oOYit0dYsnVT0xWDRxAhRDc=
X-Received: by 2002:a17:90b:582e:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-318ede30aa8mr5128036a91.2.1751293565308; Mon, 30 Jun 2025
 07:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_MRRO=YPv4OfzYeiZUgjqi35yKLG7+fOVmqaVXn5FZHTw@mail.gmail.com>
 <20250628185442.11819-1-patrick9876@free.fr>
In-Reply-To: <20250628185442.11819-1-patrick9876@free.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Jun 2025 10:25:54 -0400
X-Gm-Features: Ac12FXyxzOWjCqta9TPtQCy93S9wNBZ_Z2p0_B419BdHJXRYF0W5S2z-vRt1XvY
Message-ID: <CADnq5_PdQpzDs1PtoN_fewmuhe00-EzRTn-7PNrRysz83LqrVw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: bump version to 2.51.0
To: Alex Deucher <alexdeucher@gmail.com>
Cc: patrick9876@free.fr, amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Sat, Jun 28, 2025 at 2:55=E2=80=AFPM Patrick Lerda <patrick9876@free.fr>=
 wrote:
>
> The version 2.51.0 adds OpenGL 4.6 compatibility to
> evergreen and cayman.
>
> Signed-off-by: Patrick Lerda <patrick9876@free.fr>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index 267f082bc430..88e821d67af7 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -110,9 +110,10 @@
>   *   2.48.0 - TA_CS_BC_BASE_ADDR allowed on SI
>   *   2.49.0 - DRM_RADEON_GEM_INFO ioctl returns correct vram_size/visibl=
e values
>   *   2.50.0 - Allows unaligned shader loads on CIK. (needed by OpenGL)
> + *   2.51.0 - Add evergreen/cayman OpenGL 4.6 compatibility
>   */
>  #define KMS_DRIVER_MAJOR       2
> -#define KMS_DRIVER_MINOR       50
> +#define KMS_DRIVER_MINOR       51
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int radeon_no_wb;
> --
> 2.50.0
>
