Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB74BCDE006
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 13:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947AF10EB67;
	Thu, 26 Sep 2024 13:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B2U4RKj3";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F1410EB4F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 13:45:54 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-501114e94e4so22014e0c.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727358353; x=1727963153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9e2JNMpHo0Q2sKZ113MoKSL5FDakWhXfyM0khiz5pPo=;
 b=B2U4RKj35V2HFXUHlhZYVgRwfZP2v4fJFs8yEheDFSQ+vysdPU1mRabZYGXBvuXjWP
 3SdKBl5ACrwjUiitbfrEZ/qEJWqD1au53tEq3uCHLHR+81VlvyJ/Fsf3Mjzl0BhqwfQX
 ZcyeF66R9XReDh6lSQN2I73aelviAsWRJ1sJgENtuOxIPGOSBpqQcNJtoOPe282/oDJ6
 sCe2EcSBnKBC/7QWjipXH3+71UmoXSXgLvtCqcjrJRDVm1+svpPrsNWWvFCMemjO4AIY
 x+R1/8Dc7XS8JwwRxUiq7oZaeGm28C0lAYsmaUiLzjn2bMa/YWe6irBGfkh9nzUM7cjH
 Qa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727358353; x=1727963153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9e2JNMpHo0Q2sKZ113MoKSL5FDakWhXfyM0khiz5pPo=;
 b=di+PgIiVM7K4zMKmkXNOSA29tW/dwELFdPZ0H3LzIgBruOe7zBOSjVO8rzhP9f46RC
 9FlgtmN9bry8/Kxi/xe3J64U7JemJQORk4oaU3c1tjoT2d+ffVeQf4G+b/IspT5HcO66
 igN/uI9NPQtbTPhw++h1+d2/ywKCW1CRZdUXOa5SSLIAz2veAUp1yygIwAAfeKiFA3ye
 hnJyPCZqGpOu7W8oTHR29R10E4eTPBU1Y4cJNSBST4UAKpKUaHMelbT+3jieN2Jq+ORn
 CHYCbJOVL8GQCYoxNG99podrs1w+hgxUl+vVHUPcZQDyFEtdUskdEzYzuCml4pHyHCAw
 wUkg==
X-Gm-Message-State: AOJu0YxSVZqvB8kW7z6OJvlVzljsL6/mR1CkU7t9+RxigYSD+GIWQw19
 GgTe8EWMLO96/xoNebqA2CvJfZlAGvFbHr+vcyAqFEzRlOegNgWL1+eRwZyheoY8tew0mdkj+iL
 rl5uZEFhlcUOSTSY/Y7JdSBQ8k4qRJQ==
X-Google-Smtp-Source: AGHT+IHvFcYrzKTAbS5uDbwnSBJs13yZjNastSyH03n04QpONGbju3g2JJ5rTS37nW87FybfXodqiByA189Bsmq0+o0=
X-Received: by 2002:ac5:ccae:0:b0:500:ffbf:e11 with SMTP id
 71dfb90a1353d-505c20747e6mr1951278e0c.2.1727358352990; Thu, 26 Sep 2024
 06:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240906180345.2557849-1-alexander.deucher@amd.com>
In-Reply-To: <20240906180345.2557849-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Sep 2024 09:45:39 -0400
Message-ID: <CADnq5_PT=6Y_+Bbo7gGMgnd0TLq0B9NfvGTuP=PHP7_xUrAT-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bump driver version for cleared VRAM
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

Ping?

On Fri, Sep 6, 2024 at 2:04=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Driver now clears VRAM on allocation.  Bump the
> driver version so mesa knows when it will get
> cleared vram by default.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index d90473aec942..fad556be840b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -117,9 +117,10 @@
>   * - 3.56.0 - Update IB start address and size alignment for decode and =
encode
>   * - 3.57.0 - Compute tunneling on GFX10+
>   * - 3.58.0 - Add GFX12 DCC support
> + * - 3.59.0 - Cleared VRAM
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       58
> +#define KMS_DRIVER_MINOR       59
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> --
> 2.46.0
>
