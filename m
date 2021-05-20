Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9BFC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9BB60E0C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9BB60E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17236E837;
	Thu, 20 May 2021 03:47:02 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A216E837
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:47:00 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 v19-20020a0568301413b0290304f00e3d88so13689239otp.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S+fDBMfKpyUtfyrWAEy93S7dMLIXIvFhfPS52/YWoik=;
 b=jZ+nX3rs8qhS74q4Wacm952eZOc0ClPooVgZ8m6pef08yqU7A5d19pDADrmmwltAvU
 Gw0jBxzbH3EyKkdAiUVIsp868fvjNB0QUad/cKdsCw5m4ZjdPlDgdAd5/t1Bi9SUyayD
 yiYcVgB7gsmJSTYTg3tuiML8XJKYFqqw6B9x2KUpLFdy+roRu1O+IlM6VhjIERlB80z4
 i+CF3F3ciKXCc94RIikHPyVRQaGun4NY0x9fors8hdSRrFHoQOspLFhoa2wi2NAmDdYL
 U0ZZb8HPPjQ1u4d6U4THXNI+ghst0l7biISucXNfiq0Pm/BVSYqlbEj5Lbh+fs2QyHYI
 2SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S+fDBMfKpyUtfyrWAEy93S7dMLIXIvFhfPS52/YWoik=;
 b=K9Us9pbn1eVaz3SesDSOJtYaG+Y6BbJ9+nfpHl3yuGmthAWxuiV98e5riqpOxJQkJn
 dk1qLx2D2niRJI/cu7s5RO0nNM4MorxL/nzFtZRsJ/U8P6x6Z3wjLO0UR9cMbqH0fvnF
 0sEVns2szuRxvns+/WQR22v/1duhLVUVGC1kHCz3aCU8tXi0BEjUhXXGXbpH+kpNiz88
 CeMHAVHQL7IqcILCbhLPbT7J/jjXY6JeJtimE/TObskDsxQn8U76rJiCXpFMO72d/C0Y
 +YioJWrS2KhGt7/nDX+L7tpCTzvOhPwWagW9RaTcOGIytlyeRGszlhTHNBZHretaD8cY
 GTUQ==
X-Gm-Message-State: AOAM532msDuHEJ7D4zX+9j9Ae23ejwb4gdWC1utdykkT6vd1r+rbc5Cf
 7eNgaIPna1/124ac3PFLSco5bdJME0FAKjbhW+k=
X-Google-Smtp-Source: ABdhPJwXdzbXsWRtarwzEl9eM8fsYg2naEgVA01CW5yXLYtHUuZ6s5CtsQ4yBAecokeeSTmwwDQR71zgvFyG1Apx0vw=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr2296199otl.311.1621482420008; 
 Wed, 19 May 2021 20:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-9-PengJu.Zhou@amd.com>
In-Reply-To: <20210517143910.2125-9-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 May 2021 23:46:49 -0400
Message-ID: <CADnq5_OB+F3yeN9=nJjnvnAV6ePevL6Rz1NYhERJFUJ3s1sCJw@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
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

On Mon, May 17, 2021 at 10:39 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> use psp to program IH_RB_CNTL* if indirect access
> for ih enabled in SRIOV environment.
>
> Signed-off-by: Victor <Victor.Zhao@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
> index a9ad28fb55b3..b9c9c4d4606c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>         case CHIP_NAVI12:
>                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> +               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);

Is it safe to change the order like this on bare metal?  Please look
at what was done for vega and sienna cichlid.  Something like that is
probably a better bet.

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
