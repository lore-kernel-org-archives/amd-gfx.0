Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47900CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E162010EB67;
	Thu, 11 Sep 2025 15:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hiU6Op/x";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FEB10EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 15:33:43 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b47173bdb03so50692a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757604823; x=1758209623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmkVbaIH8lq1949T5cYloSIAw0bfgkvJWSIRJOBlfoc=;
 b=hiU6Op/xX3xDqWlfAmjhcN3wblBKeQGtAQkfi9mMxlZByMXUyIErgDU0oxLqHVTEes
 Phubbu8eBIzjlEpJfa4gcae1XHbgC0ph85IHXIfbEAbdnx7ec8qKKfx8vnMt+1yksrot
 IPursKgCytfPfuZcFcPO7ojIzpiuVoeFixC8n5EECR/DRhjFe42OHawxzNOHFYtE8qba
 3AUfX5Hc+sk2ka7MgiFKMElUFVH9FchzBEg0+HThunav6PKyYzljnr6dqxh9WJI2hLIu
 akFXOrok7uS11VnbpqcVn9ZjShSDKxqy6lXViqS8uDoyO7Qz8dnbVyzwcYFLcg5AAzvB
 uuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757604823; x=1758209623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmkVbaIH8lq1949T5cYloSIAw0bfgkvJWSIRJOBlfoc=;
 b=tW5J2vaq6yo3Yqmh0zMSEKt0d5S7xdgUmsKcxI0sfywGZ4eHWN0l5k6JXIMl25DYHE
 qVFgUBzaR9ZZBtyH9KRjFK9xS80Kbao83Ng9Kiol4etBnPvv56u0mRyIykRq9xylVNiK
 OHK4bXoqtic7PipbrGvvMMOrV0JEhJ2IOvBTZZ4+rmD38q2j+FyfASL6GUsMVtHtX/RW
 PJhjFEs++6vuFeQ+DpvYlcQNhznHSzWOmNc7kEKpCQqy472pbLwax47beXoFt3FsqvWJ
 AT3l4GfoGksGlXrpx17GD8ueyCnHB8VyszbPFrGs/FTUGQ+q4OvynHw3yizbokLCPvQM
 5yow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSRtEBOyfOhx8x42pKwiyYhPQRYpVZD0Plbkv59LFjvpYG+kE9NQ3xW5ujtDma68ON9S870VMe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxveap+X8h6jXJNLkIMPX0vbmSmjCvJTOYg3+yiLF2VdEIBifZR
 Z4iohovpccSJd/4d5syVkTBFpofA1Ub8YtMIzjsP205cNwXDlWhhCR9fq6z8BPvlqLIEy3RY596
 Yk0PnjfYjG8uCZd3SiZ26SdVfDeYdD/o=
X-Gm-Gg: ASbGncu65l02owJXkayFI5ZK+qw4eQ3lFAaGltPNrREB9y94IScsTIFwVK2s5OdB33W
 DI8g/GqsC16QujuzcY6mGsKSxCkboyTG6Y5ULp+7BcoGUdc/j0DDNkS0VlIwLfECRo+omcsRpee
 SGwUIlMSmF5AUiPqvYuUIiiuw373GsyDZanPFJLtF8IcsCBFY8F/1JhrpH8/aIX/WzTlftAppgr
 UaQvRMH9z+8pzZ4EQ==
X-Google-Smtp-Source: AGHT+IE6hczOO0u9I43/n8P1J5hIW2zXcpk5ssp9QCeqgk1pCALasP7z4UWn8jsLA+dtBWR2iPtWC+T6Tl3cYZ7WMUA=
X-Received: by 2002:a17:903:41c5:b0:25b:f108:b227 with SMTP id
 d9443c01a7336-25bf108b55amr19808365ad.9.1757604823217; Thu, 11 Sep 2025
 08:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250911145934.825708-1-srinivasan.shanmugam@amd.com>
 <20250911150239.825769-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250911150239.825769-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 11:33:31 -0400
X-Gm-Features: Ac12FXx2_lp3Eh9mJWWDGjfq6v759Y4XzCUhfX2K1vY7DL5wyWmBEnHU2iFIf5Y
Message-ID: <CADnq5_P4HfHHpU+mfg7LOb5Rd_y_yHaNU8MhSmjntfdAx0OzRw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gfx11: Add Cleaner Shader Support for
 GFX11.0.1/11.0.4 GPUs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Wasee Alam <wasee.alam@amd.com>, Mario Sopena-Novales <mario.novales@amd.com>
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

On Thu, Sep 11, 2025 at 11:09=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Enable the cleaner shader for additional GFX11.5.2/11.5.3 series GPUs to
> ensure data isolation among GPU tasks. The cleaner shader is tasked with
> clearing the Local Data Store (LDS), Vector General Purpose Registers
> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps avoid
> data leakage and guarantees the accuracy of computational results.
>
> This update extends cleaner shader support to GFX11.0.1/11.0.4 GPUs,
> previously available for GFX11.0.3. It enhances security by clearing GPU
> memory between processes and maintains a consistent GPU state across KGD
> and KFD workloads.
>
> Cc: Wasee Alam <wasee.alam@amd.com>
> Cc: Mario Sopena-Novales <mario.novales@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: updated MES FW version
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 86b3fcab5772..66c47c466532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1653,6 +1653,21 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         }
>                 }
>                 break;
> +       case IP_VERSION(11, 0, 1):
> +       case IP_VERSION(11, 0, 4):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_11_0_3_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_11_0_3_clean=
er_shader_hex);
> +               if (adev->gfx.pfp_fw_version >=3D 102 &&
> +                   adev->gfx.mec_fw_version >=3D 66 &&
> +                   adev->mes.fw_version[0] >=3D 128) {
> +                       adev->gfx.enable_cleaner_shader =3D true;
> +                       r =3D amdgpu_gfx_cleaner_shader_sw_init(adev, ade=
v->gfx.cleaner_shader_size);
> +                       if (r) {
> +                               adev->gfx.enable_cleaner_shader =3D false=
;
> +                               dev_err(adev->dev, "Failed to initialize =
cleaner shader\n");
> +                       }
> +               }
> +               break;
>         case IP_VERSION(11, 5, 0):
>         case IP_VERSION(11, 5, 1):
>                 adev->gfx.cleaner_shader_ptr =3D gfx_11_0_3_cleaner_shade=
r_hex;
> --
> 2.34.1
>
