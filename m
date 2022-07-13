Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C41C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 15:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5239B823;
	Wed, 13 Jul 2022 15:31:28 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3679B825
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 15:31:27 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id os14so20518139ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KWuVxmeX6Xm3MzIR8LI2acR8PdCF/cKKVlJCxOmpTb0=;
 b=Z3pWhFfoVdZlY0eCBk3jbJNxYaCpLzETzF1hLK+fA7JsV2I9O0ssDN0mxcpPOBxo5s
 nOVRzh9f51Z+8vvVuxBWgIQl/IwEnkXdf4LSGzPOoVFYzIE8CaOdKOghAQohkCG/Zbui
 ExBOW9dHNj8+50H7hMI7Vv5N716duNvUfs7L6Q/wefZEFTJn68u9wrH+WUn2QY1upkA2
 U+XhCLvT6FiweGDFMjUehzf/Z3AJKOlMo7HazDeHrqzmpgmCKVghn17YfuEPPOmaXK0k
 DZY8CDtCZSJcn3deEkLdGSh8rMzQbQ54TB27UuKgKYtN+cbTxKhWk7AUziOgFK2TiUg0
 bzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KWuVxmeX6Xm3MzIR8LI2acR8PdCF/cKKVlJCxOmpTb0=;
 b=03KJ5PsSBWzghRxuc5UZqYKrK+N3sGCWwwcz4Eki8pXpJ8GDQDdHFi7WNGAMl7h0qq
 Ffo4aGb9634+io7r5of0WEjQF9isnqLLAoH3iTVB+1g16K7oQQGh5nmq/nmut4IxALW4
 xWxVw6+nxBoSGHncKJ3mCK82sa1E+hqY+AXJKmSU8ay7Ja3Dt+QnDQoXTZJ74LJD9/wC
 dRhWtVBJ4bq7iAcEaNAs2qHU/xAX1OnZ28wrmoOcW5K9pc7zNnF2VszrMnMOS/znKZjZ
 vulD+a0g897UMB+x9HUjIEKOqbcue2uPpLoqpOaaieCD0x3/NBzyW6Bg2eld3UNHthmP
 OqVg==
X-Gm-Message-State: AJIora+wUHk7LWo4XZZG+AnzyAI9B0GXS2naFlQihbEwH4E862ZMJrUF
 8GhmX624+DNmai7272H/rrOdlyk3myry8yGqaz8=
X-Google-Smtp-Source: AGRyM1vDGPP1DTGA/9M0TQhrgjXj5uCOkzRZKZtK6b/K9pUlGdZTdMh0ayxDC3IhJu5lv/xO7NrGOv0YXtQJ/uWYmRs=
X-Received: by 2002:a17:907:2cf6:b0:72b:9d9b:2404 with SMTP id
 hz22-20020a1709072cf600b0072b9d9b2404mr3436865ejc.171.1657726286307; Wed, 13
 Jul 2022 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220713031704.2004-1-guchun.chen@amd.com>
In-Reply-To: <20220713031704.2004-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Jul 2022 11:31:14 -0400
Message-ID: <CADnq5_PzunYt9CBWF5Z4s2EERe2WBDmpREnfDD48KYNPkeS95g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
To: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 12, 2022 at 11:18 PM Guchun Chen <guchun.chen@amd.com> wrote:
>
> SMU is always alive, so it's fine to skip SMU FW reloading
> when runpm resumed from BACO, this can avoid some race issues
> when resuming SMU FW.
>
> v2: Exclude boco case if an ASIC supports both boco and baco
>
> Suggested-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e9411c28d88b..de59dc051340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2348,6 +2348,14 @@ static int psp_load_smu_fw(struct psp_context *psp)
>                         &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
>         struct amdgpu_ras *ras = psp->ras_context.ras;
>
> +       /* Skip SMU FW reloading in case of using BACO for runpm only,
> +        * as SMU is always alive.
> +        */
> +       if (adev->in_runpm &&
> +           !amdgpu_device_supports_boco(adev_to_drm(adev)) &&
> +           amdgpu_device_supports_baco(adev_to_drm(adev)))

I think this would be better as:
if (adev->in_runpm && (adev->pm.rpm_mode != AMDGPU_RUNPM_BOCO))
or something like that.

Alex

> +               return 0;
> +
>         if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> --
> 2.17.1
>
