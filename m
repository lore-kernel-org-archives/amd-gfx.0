Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89383606A335
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T7yxyr83
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7DC112245;
	Thu,  5 Nov 2026 14:02:54 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CB410E225
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 14:02:47 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-14f0e9c6543so45366c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 06:02:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793887367; cv=none;
 d=google.com; s=arc-20260327;
 b=apqvRyAUUFHmVn2YxWE7Y4Ja4P5cJi2BavjRWlelAUPiaC4pU8cH1BvDNvfG1+VFu8
 RaN4xMZIR2lw1Ia6kw3uCWX6MU9opmgAGQ/AlpdGro86j48+KmW4uOtMePw0UpaPpQXX
 MqcLPfjPBBUxS5i+v1poWm7JTUAGaf5/CdaK1qqicMQPtgL1gJuWc6uF+bmYZbqKgl/n
 hwMiXP3DJTnj3YadPpPAWKMIZUQVCVAGlzTdOfefC4rrYb2uoEADZj1JA6Z/AkFV4Puc
 OVo9rVoFjJ/sZ4y2l3pYEp8cjung+ku9xiN3wLLyi6IelsUuVu3jl/Mw5farFGE3rO6q
 bzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tY7X6qB5+mZOjYoVWKK4ofbtLlpzKnBryAOf27qI9a0=;
 fh=p3tVJ6N7CszmvsbyEDlMfBSCruClNp9EPLhBS8kP4xU=;
 b=k3p8fjM5AP72OAVEMZ622CJ80aPOU+/xBF19c0+RNAFQeCBjUrAow+KA+9Uq/glUWk
 vZvviSjlL32h52JFiY0+xEa/bBTq3JYN1B0fc+lgkrpvqzunezQqPvszRZtmysGKvSHt
 IsJO8RCmiAZpJqnLsbfwCRvMjkR+0qT6tfIcbdLO1fIwu1gOBN+zaESHxchYwFjqFz0s
 kZPgqIBOCQXdOE1v+TXO3OBoGRbn0tD/uzydA5sOEhJRLmf6+CQvCQotQ9zpUQ0qoNUE
 rh4fkJoLY1L4S1+lLbHkAjhCORNgEp9VLWkZdk9vPMOG6ghNGYAwq3nCA9XLa79GTohE
 OCfA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887367; x=1794492167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tY7X6qB5+mZOjYoVWKK4ofbtLlpzKnBryAOf27qI9a0=;
 b=T7yxyr831pcqC/9uY10aElDcrnuF9tZySjB9lUok4SDzdjm4eNE/varfrfkqS2EiN+
 Eb9kEc1/MPlKacGqLEDUu4YbWucH4vb6/7tTm/2bVCyHKiugahZcVNCLG0CdZ3VLbPu4
 3ldpwk27Hn0KgTaY6Hl18J6E23QbfFaoGTU6M0PNK/rgm9To54cs4yKO7vOPrp7O/9LC
 d44TlKVMGlglK86Zmv2YZkK9A2eqbnAFVpzl6GoAv/0JbDj9yW79z4b0PURmqvHeRL3b
 +C44ZlV5qYuYoRSzVdPUM4kUjUEUsvquXzXfa2vYL6ufkHPNaLTO1BQxDto6prWXkL98
 s68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887367; x=1794492167;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tY7X6qB5+mZOjYoVWKK4ofbtLlpzKnBryAOf27qI9a0=;
 b=hjKlq7FmcW66P5k1QQtbY94CIhCC2opFngOq0+hDcwEqL/QO6qSCyCzAEp0tUfnrdV
 iZdfs3gpY+4QfvT+q6B4O1SmpLQ5GcfICpDIpiZBHrYwNWLLloIkDP8MPiqVqvMgJUiD
 mzn6kbNIHVJ8dpqUpLy9afRqtTS2jT1YN3Cis+h05LBpOP6PNZVaeegHS/gD/91Mt3pF
 8DfiRVLtH0ZshgjXb/4xi74A550W2dxbdNla8f2dkXXEZErGR7PaNsabEwlYbUwmHCeo
 shKAqkOIae6+tJNkDqcJ0Tj5rxmTL3AcdjiApkSskgg0uFEZxWGmKPRfhUCyPpilk0ty
 iAfA==
X-Gm-Message-State: APuU4Z+tqVkDRKdQnlp12H2xbe6mGqCwghXA1UOgnX/2mF1TQhIl2VtJ
 oND2hr2vJZt9hm/IF/E1C3GQ0IdpbbQ/SvwxMGEyNeCJEZ9MRUTapZ3D88YU9dLR91iy0Tma/UA
 4lva1/bmnUEzlANA/BHyvwt2EMHTHcPU=
X-Gm-Gg: AYBFou0zeRhdvjFhTQJixkwIA46GWQtESvha6I/ZjRxIq5CCkKhAJnLGTE6WFBhZ792
 sG2A9X6lRFm9F31yU3jEMwXFmrZs9SKvYZ5j8LTLFzLWwe0lTyWZjV0b1MURxJUXCdJk0RpaSfC
 U+Y5kbA3iUYlhjdwHETmhAM5eigJbKlsAV5OVJjsIOTEbWjiOgPU+T8ll2BRDync7bjnRetJg6v
 8hCZk+8KpkIcfrhNtkErFrLSVz/tUIw3iexJslNtnxDZVBrCUzW0SyrDV/PjoQ4+7glCHtjBJUz
 HuQ6m8vBahxRg3NGtuYwd6ZOb1MILAaHyS5diuvXHQDs2T4OKrWTrDK/FPMGClRabMsvPjHNofH
 m4AWz5ZWvLh22aBBS9OJET2Fl+yExlikMaqt63rI605bSPkwsGRZpeWf2vkhaBfBvTSlPqEE16z
 TV3O48mW34H2gci1M7MlmohaMuZvJIftEzarmmno5AEYd8
X-Received: by 2002:a05:701b:2710:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1ac58e573b8mr40803031c88.1.1793887366966; Thu, 05 Nov 2026
 06:02:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105091632.954712-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261105091632.954712-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Nov 2026 09:02:34 -0500
X-Gm-Features: AclHuK9dh4QCAG6IJF7LR5UekMnAjj3YTWEEpoMVFpym9KQ8PQX2BJsp9r08ERE
Message-ID: <CADnq5_NWhQ8iNrT8MduJOtqv_-94VHkbq6-bhHfqEngSOL5rWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: release the IMU firmware with the other GFX
 microcode
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:41=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> The IMU firmware of GFX11 and GFX12 is only released when loading the
> microcode fails. Every unload or unbind of such a device leaks it. On
> navi31, binding and unbinding the device leaves:
>
>   unreferenced object 0xffff88810dd6cd80 (size 32):
>     comm "modprobe", pid 2891, jiffies 4294943088
>     backtrace:
>       _request_firmware+0x207/0xad0
>       request_firmware+0x3b/0x60
>       amdgpu_ucode_request+0x150/0x330 [amdgpu]
>       amdgpu_device_init+0x2d70/0xa650 [amdgpu]
>       amdgpu_driver_load_kms+0x1e/0x140 [amdgpu]
>
> a struct firmware of 132352 bytes, the size of gc_11_0_0_imu.bin.
> Release it in the free_microcode() functions; with that it's gone.
>
> Fixes: 289bcffb9d76 ("drm/amdgpu: support imu for gfx11")
> Fixes: 32d163768989 ("drm/amd/amdgpu: imu fw loading support")
> Fixes: a0f8297068cf ("drm/amdgpu: add imu support for gc 12_1")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 430b8f3743b2..d96c941fc9ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -695,6 +695,7 @@ static void gfx_v11_0_free_microcode(struct amdgpu_de=
vice *adev)
>         amdgpu_ucode_release(&adev->gfx.me_fw);
>         amdgpu_ucode_release(&adev->gfx.rlc_fw);
>         amdgpu_ucode_release(&adev->gfx.mec_fw);
> +       amdgpu_ucode_release(&adev->gfx.imu_fw);
>
>         kfree(adev->gfx.rlc.register_list_format);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index cb15dad0e57b..ed10dba2b743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -570,6 +570,7 @@ static void gfx_v12_0_free_microcode(struct amdgpu_de=
vice *adev)
>         amdgpu_ucode_release(&adev->gfx.me_fw);
>         amdgpu_ucode_release(&adev->gfx.rlc_fw);
>         amdgpu_ucode_release(&adev->gfx.mec_fw);
> +       amdgpu_ucode_release(&adev->gfx.imu_fw);
>
>         kfree(adev->gfx.rlc.register_list_format);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index fde1bad5450f..b7e89f5902a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -350,6 +350,7 @@ static void gfx_v12_1_free_microcode(struct amdgpu_de=
vice *adev)
>  {
>         amdgpu_ucode_release(&adev->gfx.rlc_fw);
>         amdgpu_ucode_release(&adev->gfx.mec_fw);
> +       amdgpu_ucode_release(&adev->gfx.imu_fw);
>
>         kfree(adev->gfx.rlc.register_list_format);
>  }
> --
> 2.50.1
>
