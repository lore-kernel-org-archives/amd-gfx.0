Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DE5C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 14:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979DC600D4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 14:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979DC600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4CA6E3D3;
	Wed, 14 Jul 2021 14:56:57 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98526E3D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 14:56:55 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so2764001otl.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=42TY+sGggMIss8xJiby+mz9LlItAReMfNDF65nlobPc=;
 b=K3Ipa041p0TokUhbHEXx+budCwr2SyC+6Rnj9/FRQqn0g6mZozUTTx4rRikUKYq5Gf
 vz6XwZy1/Ugzs1oDM/BlDC2N8chwGWVk9BJtkNN1VgEmpqoBbLma5LVd/yo7QLsVW94W
 R5KG3g1L0/kho70NDUlwid3d5C3rX7T0hCeeMohemkH3Dw4CUOobc0Ib3q9pyY80OIF4
 MMzz5GGqrVO5RYjgHyJTpGEWzF0oGSxkLxpK0mduxnKmsz5uR32Uurc49WLs3wZoDjFK
 zoynr3kvS3NyXvcGP7qOk9izYSnq9h1sjPtJNOOSqg7fc7UA3rrNBE8Td30rl1+JW29d
 S5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=42TY+sGggMIss8xJiby+mz9LlItAReMfNDF65nlobPc=;
 b=ejPcFWdQNXyqikpdLg4x3CCG6ISqNksCL8SysZjaChBwetkq6+Gsj9etnQkmlcYLBE
 qTkLn+uX3/eKPkqaq6+ciyKao/Xi0H6pbR4zESAJFMqn0BIP4XzLZEODNyGnOu34bXHt
 Pn3VJO8uIzRG+nxnLuTxsz4lpNuxyZC0gIpeyRGRe2oqbKYD5Wye1ik+brIhyNj2ZCBw
 Veb6dozsJeRdBZPL3wTDiTqRjwwNZ9Mkcns/B/N+slwkeIc815NRnSL1X07EgoN2cgDa
 5AQdKLutlmhgWOmwbtKEyC2qbVb7UYeZNPFuw6OJ+r3VnZeBJwrq9yR4h4EH2liGmo6S
 WgRQ==
X-Gm-Message-State: AOAM5302XyyF/A5eElMgbX0RafSoVuErXHeMoZLije5INg262j31dZn5
 bbpsUdISEszt9XcdE3TXIgLFH8KGR+ONA2I5dE4=
X-Google-Smtp-Source: ABdhPJxVlJcu1Z92McBOAa67D459AFv58GcYmT52MT1C1YQ5b/MO0H5Tc8jQsL14aAsVJA/oJiBl3vSh1+Y9JH/ziG4=
X-Received: by 2002:a9d:2482:: with SMTP id z2mr5848667ota.132.1626274615322; 
 Wed, 14 Jul 2021 07:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210713152956.280078-1-andrey.grodzovsky@amd.com>
 <20210713152956.280078-2-andrey.grodzovsky@amd.com>
In-Reply-To: <20210713152956.280078-2-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jul 2021 10:56:44 -0400
Message-ID: <CADnq5_PEP_gQGCntbo3w42S=gJjGiWq2G5d0N+hY_ay3RCfmHg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Switch to LBF for USPC PD FW in psp v11
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mugunthanvenkatachari.Nagarajan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 13, 2021 at 11:30 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Update callback signature and update  implementation.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

I think the order of patches 1 and 2 should be flipped or maybe they
should be squashed together to avoid breaking the interface in the
interim. Other than that, looks pretty good to me.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 41 ++++++++-----------------
>  2 files changed, 16 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index e5dcc6713861..200d19139e73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -106,7 +106,7 @@ struct psp_funcs
>         int (*mem_training)(struct psp_context *psp, uint32_t ops);
>         uint32_t (*ring_get_wptr)(struct psp_context *psp);
>         void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
> -       int (*load_usbc_pd_fw)(struct psp_context *psp, dma_addr_t dma_addr);
> +       int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>         int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>  };
>
> @@ -414,9 +414,9 @@ struct amdgpu_psp_funcs {
>  #define psp_ring_get_wptr(psp) (psp)->funcs->ring_get_wptr((psp))
>  #define psp_ring_set_wptr(psp, value) (psp)->funcs->ring_set_wptr((psp), (value))
>
> -#define psp_load_usbc_pd_fw(psp, dma_addr) \
> +#define psp_load_usbc_pd_fw(psp, fw_pri_mc_addr) \
>         ((psp)->funcs->load_usbc_pd_fw ? \
> -       (psp)->funcs->load_usbc_pd_fw((psp), (dma_addr)) : -EINVAL)
> +       (psp)->funcs->load_usbc_pd_fw((psp), (fw_pri_mc_addr)) : -EINVAL)
>
>  #define psp_read_usbc_pd_fw(psp, fw_ver) \
>         ((psp)->funcs->read_usbc_pd_fw ? \
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 3e6218799a0c..21b8b6d48d8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -79,6 +79,9 @@ MODULE_FIRMWARE("amdgpu/beige_goby_ta.bin");
>  /* For large FW files the time to complete can be very long */
>  #define USBC_PD_POLLING_LIMIT_S 240
>
> +/* Read USB-PD from LFB */
> +#define GFX_CMD_USB_PD_USE_LFB 0x480
> +
>  static int psp_v11_0_init_microcode(struct psp_context *psp)
>  {
>         struct amdgpu_device *adev = psp->adev;
> @@ -753,44 +756,26 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>                 WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>  }
>
> -static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc_addr)
>  {
>         struct amdgpu_device *adev = psp->adev;
>         uint32_t reg_status;
>         int ret, i = 0;
>
> -       /* Write lower 32-bit address of the PD Controller FW */
> -       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
> -       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> -                            0x80000000, 0x80000000, false);
> -       if (ret)
> -               return ret;
> -
> -       /* Fireup interrupt so PSP can pick up the lower address */
> -       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
> -       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> -                            0x80000000, 0x80000000, false);
> -       if (ret)
> -               return ret;
> -
> -       reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> -
> -       if ((reg_status & 0xFFFF) != 0) {
> -               DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
> -                               reg_status & 0xFFFF);
> -               return -EIO;
> -       }
> -
> -       /* Write upper 32-bit address of the PD Controller FW */
> -       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
> +       /*
> +        * LFB address which is aligned to 1MB address and has to be
> +        * right-shifted by 20 so that LFB address can be passed on a 32-bit C2P
> +        * register
> +        */
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
>
>         ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>                              0x80000000, 0x80000000, false);
>         if (ret)
>                 return ret;
>
> -       /* Fireup interrupt so PSP can pick up the upper address */
> -       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
> +       /* Fireup interrupt so PSP can pick up the address */
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB << 16));
>
>         /* FW load takes very long time */
>         do {
> @@ -806,7 +791,7 @@ static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_add
>  done:
>
>         if ((reg_status & 0xFFFF) != 0) {
> -               DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = x%04x\n",
> +               DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = 0x%04x\n",
>                                 reg_status & 0xFFFF);
>                 return -EIO;
>         }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
