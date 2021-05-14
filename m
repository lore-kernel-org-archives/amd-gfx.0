Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04CBC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 19:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887836117A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 19:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887836117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDAF6F449;
	Fri, 14 May 2021 19:55:04 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D5A6F448
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 19:55:02 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 u19-20020a0568302493b02902d61b0d29adso240478ots.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2InvrPdx1wKBSXzTia2N7jDJbTAJrJvqrFZYtZzSwLk=;
 b=fV+e/6/0FmRoAJz75pla+gv7HJWu8d8l2tAIYt5MZSDvRBwi4LVKY/88Wi3R+xtd2N
 8BX3ZMzRHqhNpxbbeVNUVIl97RVKUm9Nr+w12YRkaRsqKzfBMDw91/NS24unW1lIixGM
 uBRdK367X4WerY3QyAJPqtlle7zXsUzmADNi89/3w1Of+sscZ6I8UvGbGceBHmm9wmY4
 vUxEBjaYwf2yEYXQ1GNPPiqJLktCkF9GhFxVAuqomYhdo30Zc6FnOcFf5NzcsDFdp8UP
 5eGDISoymwh6fS6YScPbrJum6cB5YdtRWSF2xtpTpFhsiS2n8kvTVI3mhGRcS/XtEkNv
 YKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2InvrPdx1wKBSXzTia2N7jDJbTAJrJvqrFZYtZzSwLk=;
 b=b8O0riLT/IhYCoiLnX65CTo95RHtcnZ20pRyg7TQp7mxYKz9UH2ftZ3WSiRcJBG7Hz
 EyKMpt+a8j5c2/z2zNBwsrnWpDzAOxdI26x6/zjw0KfaMdL0LYBeul2Qucy9T/q+ybcu
 6fipQfQYNV/YmYSqvFralWu6RgUKYtQY9kSBwJXR00o0/qWg0N/zIjGyfL1T68MC1Vck
 SXX+jAe2INMR0VJ7FBemCMuFOydtvOtWFb4tX7XDqvs7dh6cqtm4MdqnnHP3UjYZXruY
 VkH6cGgBiMdWdOVbcKc3OdFXOUTDRmy3UBS3XF5F83SONyb14lz/0uN/HShJOrSoXzuH
 /8Tw==
X-Gm-Message-State: AOAM532j7ynslN+F73+rWzAqSS1y9WUl9xGnIzz0ksWSpM+fsWtIGgp1
 onGYE5/7Sdwa9KTKxxvCW2bYaEtS/IqqwgdOCMU=
X-Google-Smtp-Source: ABdhPJylokOYw9SrF3UFU/9QoF2z+S+rf/VlRCKIfrG4bznm5CJF5tvQmwRJpobHbFZfEmaaOi0tLYgGA0tpLzIMF8U=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr10458250otl.311.1621022101924; 
 Fri, 14 May 2021 12:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
 <20210514072706.4264-12-PengJu.Zhou@amd.com>
In-Reply-To: <20210514072706.4264-12-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 15:54:51 -0400
Message-ID: <CADnq5_PhCWejqyrDXROdWsOpMtjzX0yfnAzNoKp=rzWA=gOo7w@mail.gmail.com>
Subject: Re: [PATCH v4 12/16] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
Cc: Victor <Victor.Zhao@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 3:27 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> use psp to program IH_RB_CNTL* if indirect access
> for ih enabled in SRIOV environment.
>
> Signed-off-by: Victor <Victor.Zhao@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

This seems unrelated to the other patches in this group.


> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/nv.c        |  2 +-
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index f4e4040bbd25..2e69cf8db072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -151,7 +151,14 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
>         /* enable_intr field is only valid in ring0 */
>         if (ih == &adev->irq.ih)
>                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
> -       WREG32(ih_regs->ih_rb_cntl, tmp);
> +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> +                       return -ETIMEDOUT;
> +               }
> +       } else {
> +               WREG32(ih_regs->ih_rb_cntl, tmp);
> +       }
>
>         if (enable) {
>                 ih->enabled = true;
> @@ -261,7 +268,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
>                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
>                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
>         }
> -       WREG32(ih_regs->ih_rb_cntl, tmp);
> +
> +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> +                       return -ETIMEDOUT;
> +               }
> +       } else {
> +               WREG32(ih_regs->ih_rb_cntl, tmp);
> +       }
>
>         if (ih == &adev->irq.ih) {
>                 /* set the ih ring 0 writeback address whether it's enabled or not */
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index f2f0caf560f9..f0ba64ceb67d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -737,8 +737,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>         case CHIP_NAVI12:
>                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> +               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);

Can you verify that this doesn't break anything on bare metal?  IIRC,
we had issues with this on vega parts and had to make the logic
different between bare metal and SR-IOV.

Alex

>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
