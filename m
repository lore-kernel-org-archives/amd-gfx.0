Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEE6CCD199
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 21:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B22D10EA99;
	Thu, 16 Oct 2025 21:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mGiXgKe9";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81D310EA99
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 21:30:01 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-79cf7fd45afso133051b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760650201; x=1761255001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftN3tNEizEmnbmENIJ8if3i2VFIMnVDUwoUNZIEOpSQ=;
 b=mGiXgKe9H3e970d8G6mAwiVa2yhSvwg3VkGp2dlm01blbC5VFRi+rUr0/T6MPY+Avv
 czG9S8uf64HFDRAzqe3swAb90LyVrjd9dGUSmSPywyElQl4zcEAsNEHzhN+1KJz0Yv/Z
 NC7M2JV6LwOBfT5OPTu7Cw7u6Fmv/Dqip3LFHHXNNBozf+14SYJbVjjdjNb/rsP2QDsC
 +13Q2ofAuIU9Tz8nunxXj1g02A1BLVqBoM4bxRqDl9VyyyOXZedZuzf1JmsZrji1vUz/
 xp5LmN2whkIXdev0pnsY0JsICY1QX8ll+Zb8wLAOmJwuem3/zRBS/a59DoCMjPqL7FNb
 32hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760650201; x=1761255001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftN3tNEizEmnbmENIJ8if3i2VFIMnVDUwoUNZIEOpSQ=;
 b=f0YMVF00EV7jJnXivMkpleFD/4m3rpMro+Lv6OGXupdhCvd1KGqJ24puI0JCXolGhz
 hyubLt8lhJ2LA5W+55xRVk9Rovj6MIlHQF1a1I1AQg5r35ahmCA0GFMlZHu2j7lLZ/Ss
 4MRnS+5bzoNw1idMQYBSUxbsWeN6qyznTmSkUzQsWeZXf8GJy8Mr7XEU44JmEJKIeJKj
 6c3IR2Ujc4vhQKKyehOQBpL12X3Djyy4F/AviYuJy7b0IEltiMFHlNGqPPGyKEZHrqCP
 a6xRzgmmswBlf/Coq5HXFm2loZ6dK+niU5k1wLnG5zmvl9Djd4rIt8V720lAEp5jRrWy
 /WfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW9F4sbep/rEXYTFG/a4/+h8cRvuAsUnGqpZcp//MG6BUfZNx3dBm8fH0BCWiOX0sJuivmuott@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzErb6iY10vqeKKI7fvXAOMy9pG1sI+aqaz6pkw96VeU9GwQWoX
 ijpp0L3UpqQVIbtXtPLljJqTNDMjbcisoeUE63I47Nhv2h2x6t9TkEYnxFZOR2SpIFLU/4NTOu3
 s2hpV/lR3lSciA+84MYRsmdkQhWK5lKk=
X-Gm-Gg: ASbGncvG13JENaX48tenSp4Cyrsy4Ll+3UuM3rpuMY9jhrRLME7RqrHWadVLj12rocI
 JCoZRZrItfKw27L88L+wcCpxPvt9c+AAWsSe/hObCGUGPzrxxMnztmd/jN/SDiAzx+DZ3JEdj3y
 DHA8wJpU+TqXg6V5zJSehHVlve4WsrnN303MAO4LV97plz0bsmwjq5oJM6f9Pzrs5Qu1Wo+RafV
 8yPAOhmFumB5+riSa8yvaRe1u3MZTgRaO4/HGqUAded3nGI3LoYX46Mokv7FwJzemVj1KcarMqz
 lfPe3w==
X-Google-Smtp-Source: AGHT+IEJi+u8v/4xBFhxnD4pUPTa1qHDdtUCHgOkW7LB+eLI2y/pgqwDCpxEqthRzm1ezNUH1JqpoB65KIR4oib9sAI=
X-Received: by 2002:a17:902:e743:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-290cb27ec63mr8586115ad.6.1760650201089; Thu, 16 Oct 2025
 14:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251016210018.901389-1-siqueira@igalia.com>
In-Reply-To: <20251016210018.901389-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 17:29:48 -0400
X-Gm-Features: AS18NWAtKWjHINpKeRafH1QlyqEP7KO0YXzC994GlqeT_av6UDW_aGWAOXAzBrY
Message-ID: <CADnq5_M7xTVfmVf4SaU7sQH4e4qp4M5Ds_g7fvjgr1Sr0v+PKw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Thu, Oct 16, 2025 at 5:00=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> set of errors happens and the system gets unstable:
>
> [..]
>  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
>  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test=
 failed on gfx_0.0.0 (-110).
>  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> [..]
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comman=
d: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comman=
d: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> [..]
>
> When the driver initializes the GPU, the PSP validates all the firmware
> loaded, and after that, it is not possible to load any other firmware
> unless the device is reset. What is happening in the load/unload
> situation is that PSP halts the GC engine because it suspects that
> something is amiss. To address this issue, this commit ensures that the
> GPU is reset (mode 2 reset) in the unload sequence.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0d5585bc3b04..78009b93855b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3613,7 +3613,7 @@ static void amdgpu_device_smu_fini_early(struct amd=
gpu_device *adev)
>
>  static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>  {
> -       int i, r;
> +       int i, r, current_reset_method;
>
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
>                 if (!adev->ip_blocks[i].version->funcs->early_fini)
> @@ -3649,6 +3649,17 @@ static int amdgpu_device_ip_fini_early(struct amdg=
pu_device *adev)
>                                 "failed to release exclusive mode on fini=
\n");
>         }
>
> +       /* Reset the device before entirely removing it to avoid load iss=
ues
> +        * caused by firmware validation.
> +        */
> +       current_reset_method =3D amdgpu_reset_method;
> +       amdgpu_reset_method =3D AMD_RESET_METHOD_MODE2;

This would only be needed if the user has overridden the reset method
via a kernel module parameter.  If they've done that they get to keep
the pieces.  MODE2 reset is only used on certain chips so this won't
work generally. Better to just drop this.  amdgpu_asic_reset() will
automatically default to the right reset method for the chip.
Alternative is to set AMD_RESET_METHOD_NONE which is the automatic
setting.

Alex

> +       r =3D amdgpu_asic_reset(adev);
> +       if (r)
> +               dev_err(adev->dev, "asic reset on %s failed\n", __func__)=
;
> +
> +       amdgpu_reset_method =3D current_reset_method;
> +
>         return 0;
>  }
>
> --
> 2.51.0
>
