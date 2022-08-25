Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C81C64990
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278B410E064;
	Thu, 25 Aug 2022 13:32:53 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0347E10E0E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:32:48 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-f2a4c51c45so24877584fac.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=iuERGFdEcnzdiAaCDoY9iJg1p0/EarvK43dEX0Xw1aA=;
 b=nTn57TjckiwVpjH8afMceHRmrKxkjuP8fapho/Va1579xRk8hemXASY/Ht5P9T/RTw
 PRUN2HLlu2U111+fm8+P0Ri3DiXnLUx5s8Ag3w2NUpO1cNaGY3XzEX5KRpO3UTuW+tDe
 FoA3h23CdlhIDJvkIA7hkbnQ7hZSlN8f9WJi8rsxp/g6Xv3gfTlsvvRCFd7TyHHNCBP8
 MTVhIgJliEI6qG0N94tyz9ah8BnxeXawAg2YvkOupEGRLyYtagBzj4oCV07SqXWPWHT3
 B8cDb7v1J/DnfMdrGqz8YGm0np4FBZdVWoWek489LmDrtHMjfekKCTPSJTYNCqY5HNKB
 I0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=iuERGFdEcnzdiAaCDoY9iJg1p0/EarvK43dEX0Xw1aA=;
 b=AxVraVFo4fw+oVd7cbevxYBmx9s3dK7eVFR/gejROuOXEfT/rJEliE2Y8zvwYr3+Fj
 hL+HdvJXUQ0oZm4tK6/raGHs7i2VpK/13SmtzeeWmNKwBxf/KiRVPYAUxEijcV8BbkCU
 7VMYGAIXc71DDg9YqLMla4FkMITmKl9NU3UQo6k3+wCgSzkJ3XDD2aifiaosqNN2AYl6
 7SxE+6EDqwxbprDti5enh/ts3ZKXuRcTLUwUO/vQ6pgE82KlyjXYQRmvkwTNgdUjlT+Q
 ULNw5xyFXldhEG1h+45IfCciR95FcjJWSF3gCxtSZbTef70nVC8wUj306xYJaWb0mpre
 lykw==
X-Gm-Message-State: ACgBeo3JOGID0uhZ1Emz9IS2XIYLIakXM37wAAuOtb3SIkACre8mhTs5
 eG7RUjd/A1UDIQVhnspbZE3nAqBv7qP8KtSq6wk=
X-Google-Smtp-Source: AA6agR52m/F8J6fuZv0dugpoD1Ca+NNjuw01XzbC1uWGgVZJyAq9s6VQOUvmY/GVA2gpiP+PCOXL9zAvVr6rbKuqFQY=
X-Received: by 2002:a05:6870:9a06:b0:11e:3d19:2614 with SMTP id
 fo6-20020a0568709a0600b0011e3d192614mr599723oab.96.1661434368261; Thu, 25 Aug
 2022 06:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220822155217.911506-1-mukul.joshi@amd.com>
In-Reply-To: <20220822155217.911506-1-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Aug 2022 09:32:37 -0400
Message-ID: <CADnq5_OGYxgEVOahp9wAvoVmhHDazhZwERK2s+x-gc43114URg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
To: Mukul Joshi <mukul.joshi@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 22, 2022 at 11:53 AM Mukul Joshi <mukul.joshi@amd.com> wrote:
>
> When translate_further is enabled, page table depth needs to
> be updated. This was missing on Arcturus MMHUB init. This was
> causing address translations to fail for SDMA user-mode queues.
>

Do other mmhub implementations need a similar fix?  It looks like some
of them are missing similar changes.

Alex

> Fixes: 2abf2573b1c69 ("drm/amdgpu: Enable translate_further to extend UTCL2 reach"
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 6e0145b2b408..445cb06b9d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -295,9 +295,17 @@ static void mmhub_v9_4_disable_identity_aperture(struct amdgpu_device *adev,
>  static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
> +       unsigned int num_level, block_size;
>         uint32_t tmp;
>         int i;
>
> +       num_level = adev->vm_manager.num_level;
> +       block_size = adev->vm_manager.block_size;
> +       if (adev->gmc.translate_further)
> +               num_level -= 1;
> +       else
> +               block_size -= 9;
> +
>         for (i = 0; i <= 14; i++) {
>                 tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
>                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
> @@ -305,7 +313,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>                                     ENABLE_CONTEXT, 1);
>                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>                                     PAGE_TABLE_DEPTH,
> -                                   adev->vm_manager.num_level);
> +                                   num_level);
>                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>                                     RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> @@ -323,7 +331,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>                                     EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>                                     PAGE_TABLE_BLOCK_SIZE,
> -                                   adev->vm_manager.block_size - 9);
> +                                   block_size);
>                 /* Send no-retry XNACK on fault to suppress VM fault storm. */
>                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>                                     RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> --
> 2.35.1
>
