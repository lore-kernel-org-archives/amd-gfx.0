Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CBEC83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 21:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B68310E2DB;
	Fri, 11 Jul 2025 21:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YhqMvpMO";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5355410E2DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 21:21:56 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-313336f8438so381516a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752268916; x=1752873716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riFSJk2LPfUMX5iTtCd2I9lCakapjSG53a35DB4KJy8=;
 b=YhqMvpMOUwyn0n9LGXsF2dJ8rNMehoQaHxj20qyhEocZXgDjRqvTUyvNtR/WkrQE0u
 S9cQAzwgEAfWA16XhqMryJBxM6eElI97D9X5AlTfYe594BFgHnWFXcQ/ZmjwLYv+mpvf
 SgAWuyCKRVduyW5m34zafViXNDIINBdtx/qZCsFbowa+ugj4KfxZzVqIncuVTL0iCgRv
 OpGLvfR7VCg73XPAqI+H/lT/YW0q4kqIx7jQ6P3HP2kOxCfR5sX3KvUvBLEDqGoPUN9V
 PsgAzu+fX7hSbqLFFxHfajlmmE33VThkew7uo+lXDstdB5TtFv2EaTjL6DwZ8XF+FmjS
 kwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752268916; x=1752873716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riFSJk2LPfUMX5iTtCd2I9lCakapjSG53a35DB4KJy8=;
 b=KvauCK19G1tYHf1Bur3EreRZ7k54BMKS9TJ2s+UVJl6zQA8vAU1w3tnBKDxT5R0GQ4
 jA6CcPXzLkEhvXCsDK3OasT6K6c7KQMbVyf/h98664cJCHl687DKtAsJeSHcnuxLgv8F
 aK4LNpviHnio95UEOUuMDFVBUgFoYW7Hm8PNl0dQn2SyC1vOzqXnHTVWp8MnG+qKqQEf
 XAoahSJFsXSYCcOJJl1Y+TltVOCXcngQlo8fejmczFbK5ksFmaY5Yt/4zXZZbsU81vNy
 Tbshol/GMTRRfUk4h/+NRYb9BNtu1YS7kzgR6v8AR+/QCef+qiz+2swrwb513a2fWtWA
 TE2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIreKPql13VDM4WjZ6uhQvPVOByoAKrjcwCEvEni8RfQ/9m+qEiGU7RNdOhOAlcNMpah3bs1sU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRoey51q6m0C8tU3tNwAaEZhtyjwEMzz8VED/3SkbwEUTm1vvr
 GIDr5WP5Xug/PGyiktuffOTT1Txo537L73IvjPW4x78N0SyZJlpzpyawIYDAAIvHTWgBrV8Rv61
 GzQRNnEuPVZr8nBWxHkgI7wNuVbKnb1bk1Q==
X-Gm-Gg: ASbGncv8ffJI57DQ2LvfpqSicxZsXt+Xsp+doNvVWeg6npOG02IPeLF0pRCz0UNc4A7
 NrRJEYGlEqtd1Xhm1LdEbzgkjqXcEakA1XLxgtVtFmoFrpxfoJc/mI1nxdfDRmY+paq/t67owjg
 ueQAGzThqlotHpXWVodocVySowUgnOzcIr4QJjIc7m+ZpaXyXLPi3lLmm0hpEDcDYNzHkKLfDJh
 Ki8FSnKoCTsZIF5PLk=
X-Google-Smtp-Source: AGHT+IHt/HBiYVuXto+BdRIeGoKjWqxG0hDvbTNIeBQOn/KsVvBo147KKsCq8blb2ii/CVKgoeOzobbfGBzwBBI2umA=
X-Received: by 2002:a17:90b:1f91:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-31c4f540cc2mr2594711a91.6.1752268915705; Fri, 11 Jul 2025
 14:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250627143342.23856-1-alexander.deucher@amd.com>
 <20250627143342.23856-5-alexander.deucher@amd.com>
 <MW6PR12MB889876E593C85C19140D5581FB4BA@MW6PR12MB8898.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB889876E593C85C19140D5581FB4BA@MW6PR12MB8898.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jul 2025 17:21:44 -0400
X-Gm-Features: Ac12FXyyhmhjrQFqBdyeYSelgi0mmovV-HLUKp7PaejfWvU9zxyvrAL9bgj-wvM
Message-ID: <CADnq5_MqwSMNYR=fPs+Z-2KqA-OusB4ann2aiZHw-P_zrn7HiQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/amdgpu: add support for cyan skillfish gpu_info
To: "Yu, Lang" <Lang.Yu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Fri, Jul 11, 2025 at 6:38=E2=80=AFAM Yu, Lang <Lang.Yu@amd.com> wrote:
>
> [Public]
>
> >-----Original Message-----
> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex =
Deucher
> >Sent: Friday, June 27, 2025 10:34 PM
> >To: amd-gfx@lists.freedesktop.org
> >Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >Subject: [PATCH 5/6] drm/amdgpu: add support for cyan skillfish gpu_info
> >
> >Some SOCs which are part of the cyan skillfish family rely on an explici=
t firmware for
> >IP discovery.  Add support for the gpu_info firmware.
> >
> >Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >index d1b122090b3d8..758e51505b3c7 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >@@ -95,6 +95,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
> > MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
> > MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
> > MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> >+MODULE_FIRMWARE("amdgpu/cyan_skillfish1_gpu_info.bin");
> >
> > #define AMDGPU_RESUME_MS              2000
> > #define AMDGPU_MAX_RETRY_LIMIT                2
> >@@ -2603,6 +2604,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct
> >amdgpu_device *adev)
> >       case CHIP_NAVI12:
> >               chip_name =3D "navi12";
> >               break;
> >+      case CHIP_CYAN_SKILLFISH:
> >+              chip_name =3D "cyan_skillfish1";
> >+              break;
> >       }
>
> It would be better to name it "cyan_skillfish" which follows the name con=
vention.
> E.g., raven/raven2, phoenix/phoenix2, cyan_skillfish/cyan_skillfish2.

Will fix that up.

>
> Do you need to parse its name in amdgpu_ucode_legacy_naming()?

Not at the moment, but we will need it once we add support for the
individual firmwares.

Alex

>
> Regards,
> Lang
>
> >
> >       err =3D amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
> >--
> >2.50.0
>
