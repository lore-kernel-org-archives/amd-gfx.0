Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A40BCD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 14:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88E610EFFA;
	Wed, 17 Jun 2026 14:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OufI4x3o";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3483410EFDF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 14:39:55 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304f9bc869aso650816eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 07:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707194; cv=none;
 d=google.com; s=arc-20240605;
 b=Ba4OAS3biErvF/Az9/J7S9OIm4rWmoSVhAdseOjRhyr/5n4q18ER+qfgIFMPOOPrGl
 igM+Vq4p3US9Vs7Gnag2y2teE62IppEiZ860sp9McADQy+36VsGJCov3JvS5r0znVXzq
 jGBGD1f6w1EZ1dsgMr5ri/76b2NyGVmb06Oz144rkdE8Rv/FcNo41cxiPwhVWTnccyXV
 m4EEXMHbgwPY3i5Z5RiDGC0xS1306EqeJ1N6PKlwJUXrZoZoYz5vwH96u990y8dqIrjy
 41KSH6w9mf7uVa+T0a+q6Y+tvdKPXkUbDAvFfU4Z9YiqjFXRNlB5FeIcRx7+bPM22zK2
 dlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H+dC1Ehi3qgIqIz5guL69Mk1/vs8Hz96N955RLbsg+I=;
 fh=AQMfZ5MqvW2+mn1ew9/jeZcRc1OyYV1VRLlUCXMxOCw=;
 b=cS1foHhTPQBOSUlTlxDf2iPwbJqUvXU1d61LYuTyb5GLESh3g4I+o2rMjpzttbnDE+
 C28qL74Ja+Qb5geuGW1naCjbBJt8nxnD8Eno42Wat7VEPlG61xmag6rgJSa48XpL+XQk
 +jKUQwzEQeNn8+LnxFNr//x6CglNQOQwIDl0lfJGPZohnPlXsAxC8AkHgKIf0iSweMhh
 raNQ1tGT0XrwowrIwW/Gm1s4u6447azbFwr0qPWdh/FKxf5nfUe2pCaHIMaDZJDuMov8
 ZzVsA+OJZKYAQsuOrLPgJH/bBXtqZkZefcnyPWwfZdTmGLG1+O9LvZD0kJ9LSPy3Dhw3
 onIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781707194; x=1782311994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+dC1Ehi3qgIqIz5guL69Mk1/vs8Hz96N955RLbsg+I=;
 b=OufI4x3ogDh2D1nCdYoPcJnC8urZoC0WQ7KJyobmEGIDFsU/f0adXIo03Q3CL783tZ
 Kst10F/V9c0dD7jvyR/kNOnkiUGolIozxcjjULf6IffOC+riFrnTOPDNAKQtEMpV2zoF
 6tpU8k9vCfvEmlKGwdTr+By9Wq6uxQGKH085Mga9YV1kagHUCA+/7wE9dnO7hqbpKwDE
 pGrszkd+Ve0e/YIIxwQjp/1+sV1M6CeXxNOAtWpBf3K3g5rS5VYjiHAoUQyzmkNbox+z
 tx4FQqzJd2a7bkhTmbTKdVDiizU8roEdl4F64QJWwGYxrn3B5HvFMbWA4izEHWUGkl1H
 C0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707194; x=1782311994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H+dC1Ehi3qgIqIz5guL69Mk1/vs8Hz96N955RLbsg+I=;
 b=jKA3rvY9AJn6VTfsgVrxznI5a/sFMrrXom4K/kzLbhgzWwapYlRcTAxhWOHw4WlzX5
 yEicR+lVyOYIHCoBSPvFLnRbowPnWEs5I4B4+seyuGhXUgduPMwTy6UOb3nqXBh8NRDJ
 Ak+T1BXsa62lGidyh6up9PGWYQ8FitmcGwFL5HvvrSBJQpEFdNFvw28QDZdccJwzJWvQ
 RV2xr8RLzXXgi1Qwsac+deSvAggyDPq6BkFcmXuCR8BzKM1q0JP29ZQpyMdlx6jUtchx
 0WjDtTRabAOZOKLwSVf4ommQt4TYteEXr2PP04vOFF3C/4iOm++LRmvqzIZ1EU/5LBGZ
 oHaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Xc85UBXsTlYo6eThLyq3zdhXRYwT7UEGREn1WCDL6NWswjH2oCHA+lOrTehvkZM6HmCVdPM+s@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZQtJpr/a7pYkkg5MwM0i/1vn4lF6O7EVn18ekJM2fxh814iaX
 s45IzhNRUW/Rzt9CoveklzWVDke14bMoVQFsfP1wpTwwcp9mOix4fcSXC3mMOoQpSw5JOBTjWpi
 KjyhRF81p9r9vK33tGVvtzWMFUZrPzAE=
X-Gm-Gg: Acq92OGt8sBuUhM2cnCJXv29v3LtCe3EGCZZQa3z4Eq8oJrBIs91F+RGc962HyYRGxK
 wjVtXAusjmgID3hWOTWh8AoWQ5CVRdLo1M0vkhAKlskeshydzv9dOx4ZD/JwuYayCHU6m4kD5qk
 9Nuh3h76S8pybjSLxrrN76WxuHDTAIJ9tvuDBYVcXKXJARZpUvx/p3areRrqDrkDoEiamf51vpU
 khAzTBRJQVnOhHLRJdOLRbDwo6LaqKdMkfcyvrcWeUnkZKV8UWYyiKjaZuntnAUGNnu5QrIvoSF
 YF1rtHxDqHc7O+cOrHQvUU22L7zHlpj9sVQBczqqGMUy0FNnLd4L/gx8cYc=
X-Received: by 2002:a05:7022:622:b0:137:ec1a:f405 with SMTP id
 a92af1059eb24-1398f56699bmr778964c88.0.1781707194261; Wed, 17 Jun 2026
 07:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260617062415.19898-1-jakob@linke.cx>
In-Reply-To: <20260617062415.19898-1-jakob@linke.cx>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2026 10:39:42 -0400
X-Gm-Features: AVVi8CeQey_avyCfLu9CoekmKwKkOtyI7rDns3sTfvSTRzhpVqyMectcpzvhhsE
Message-ID: <CADnq5_Mmf50-psbJH5NzPYu_VboOf=MKFK7oCiGo6bKg=p0EpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc24: reset dGPU if suspend got aborted
To: Jakob Linke <jakob@linke.cx>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 17, 2026 at 3:54=E2=80=AFAM Jakob Linke <jakob@linke.cx> wrote:
>
> For SOC24 ASICs (RDNA4 / Navi 4x dGPUs) re-enabling PM features fails if =
an
> S3 suspend got aborted, the same issue already handled for SOC21 and SOC1=
5:
>
>   commit df3c7dc5c58b ("drm/amdgpu: Reset dGPU if suspend got aborted")
>   commit 38e8ca3e4b6d ("amdgpu/soc15: enable asic reset for dGPU in case =
of suspend abort")
>
> The aborted resume fails with:
>
>   amdgpu: SMU: No response msg_reg: 6 resp_reg: 0
>   amdgpu: Failed to enable requested dpm features!
>   amdgpu: resume of IP block <smu> failed -62
>
> Apply the same workaround for soc24: detect the aborted-suspend state at
> resume via the sign-of-life register and reset the device before re-init.
>
> This is a workaround till a proper solution is finalized.
>
> Fixes: 98b912c50e44 ("drm/amdgpu: Add soc24 common ip block (v2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jakob Linke <jakob@linke.cx>
> ---
> Tested on Navi 44 (RX 9060 XT): recovers the deep->s2idle fallback and pu=
re
> s2idle resumes that otherwise fail with "resume of IP block <smu> failed =
-62".
> It did not recover every case: one resume still failed under sustained ra=
pid
> s2idle cycling, so like the SOC21/SOC15 versions this is a mitigation, no=
t a
> complete fix. Single suspends in normal use recover.
>
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index ecb6c3fcfbd1..a970d8a76302 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -521,8 +521,36 @@ static int soc24_common_suspend(struct amdgpu_ip_blo=
ck *ip_block)
>         return soc24_common_hw_fini(ip_block);
>  }
>
> +static bool soc24_need_reset_on_resume(struct amdgpu_device *adev)
> +{
> +       u32 sol_reg1, sol_reg2;
> +
> +       /* Will reset for the following suspend abort cases.
> +        * 1) Only reset dGPU side.
> +        * 2) S3 suspend got aborted and TOS is active.
> +        *    As for dGPU suspend abort cases the SOL value
> +        *    will be kept as zero at this resume point.
> +        */
> +       if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
> +               sol_reg1 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81)=
;
> +               msleep(100);
> +               sol_reg2 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81)=
;
> +
> +               return (sol_reg1 !=3D sol_reg2);
> +       }
> +
> +       return false;
> +}
> +
>  static int soc24_common_resume(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (soc24_need_reset_on_resume(adev)) {
> +               dev_info(adev->dev, "S3 suspend aborted, resetting...");
> +               soc24_asic_reset(adev);
> +       }
> +
>         return soc24_common_hw_init(ip_block);
>  }
>
> --
> 2.54.0
>
