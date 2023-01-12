Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B406C54EBE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 22:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2FE10E952;
	Thu, 12 Jan 2023 22:53:15 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACAE10E952
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 22:53:13 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-150b06cb1aeso20531514fac.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 14:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lxJo9o/6Bi2UXo85GBNijlDfF2UDG5e321ZCjOtPtaM=;
 b=FhY5VACAUtvACwQnY77F4Gk59QBwxbd4RWg7C218Jw8+0SXJfLIkaxfYEDvmVMuyXh
 DeFzRlLXvj/26Fvk92H693+fCMnjEVNChBbxz77MON0+0UmSISwS6h99OKmjjiNi7fp5
 c10Z4tDnCB3DawME/UdMFbkJQz/6HcRxnPERj9hwFNLhKqOFR7KxX6pZJRySxm59uRNF
 /WF87MHtUe8p2fUkYpMkvyVnvFyNXjW2nGUGCPmGBA+TwkZ0DP+Ckz9vFaCOs0++FeST
 Wcy6ED0z0Pr/fTMqEg36BibIR3h/qQu3XoS1Gjo+FPo+SJR/kz90XAQjHrSha+T9KZ4R
 uBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxJo9o/6Bi2UXo85GBNijlDfF2UDG5e321ZCjOtPtaM=;
 b=UCrsiBjBXQyDSvY/3Oc/yIUmxP4/WyPvjDcUaUalno5eBkQ7fvw+Z4cQpj+Dat6MnQ
 j4P6wFbowBTxWjTXOLniqP/W+y+TrVZXTkQyn28hvV6fXqykEbs6pZLHJQzO7/fqzdhC
 xSMXr66fNi8DXzt9CRe9P9dVqnnge8GAye4i3YjEi0ALtNy0iW5OXbNMl31oPUPMdRg3
 d4brJ+3Sz+Qcmd9Yo1lLSs4DLmKloda28dHfpCCmK8SGZ++c3Zzu7JcKcLTM3/dclxtG
 RCu3WGd6C7vvmWrjviUeB3U5osC7kdxzYcbjN2mBfk8hhuiMlJ3Rxuc8LfQqZYXbTHpS
 SwKg==
X-Gm-Message-State: AFqh2kqHzqWcrlFmYsAIFEz+RCh6YRVZboGIjzBCPObvMLveZENpuRT7
 ACc2OGTryOEJjnEeX2LV8+X0ls1ZLP+rCVonE8k=
X-Google-Smtp-Source: AMrXdXvtVn5kEpr9eZShInOgOCf58CbA+oVR2bsGZcDnpP2laqjA6EnRn+n6v/IvzWBYg8W43agNjsTwT2aFww5ncSA=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr6676749oaq.46.1673563992439; Thu, 12
 Jan 2023 14:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20230112223701.29477-1-mario.limonciello@amd.com>
In-Reply-To: <20230112223701.29477-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Jan 2023 17:53:01 -0500
Message-ID: <CADnq5_Os6ZN8LG_uR_N4rDpwGa1NR5RsRqPmHM0qtn0tWxk19Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix some dead code in
 `gfx_v9_0_init_cp_compute_microcode`
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: coverity-bot <keescook+coverity-bot@chromium.org>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 12, 2023 at 5:37 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some dead code was introdcued as part of utilizing the `amdgpu_ucode_*`
> helpers. Adjust the control flow to make sure that firmware is released
> in the appropriate error flows.
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1530548 ("Control flow issues")
> Fixes: ec787deb2ddf ("drm/amd: Use `amdgpu_ucode_*` helpers for GFX9")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e80685d1e6c6c..d4b0fa4b62a44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1345,7 +1345,7 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>
>         err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
>         if (err)
> -               return err;
> +               goto out;
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
>
> @@ -1355,13 +1355,14 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>                 else
>                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
>
> +               /* ignore failures to load */
>                 err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
>                 if (!err) {
>                         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
>                         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
>                 } else {
>                         err = 0;
> -                       adev->gfx.mec2_fw = NULL;
> +                       amdgpu_ucode_release(&adev->gfx.mec2_fw);
>                 }
>         } else {
>                 adev->gfx.mec2_fw_version = adev->gfx.mec_fw_version;
> @@ -1370,10 +1371,10 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>
>         gfx_v9_0_check_if_need_gfxoff(adev);
>         gfx_v9_0_check_fw_write_wait(adev);
> -       if (err) {
> +
> +out:
> +       if (err)
>                 amdgpu_ucode_release(&adev->gfx.mec_fw);
> -               amdgpu_ucode_release(&adev->gfx.mec2_fw);
> -       }
>         return err;
>  }
>
> --
> 2.34.1
>
