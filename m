Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF3AC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00025208C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjiOdmt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00025208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4546E02A;
	Mon,  2 Mar 2020 21:31:02 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E766E02A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:31:01 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f15so689939wml.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 13:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9iPoN/xPXu3M+jg3nBdEsiKjATBEwYbgH8uZqlJmVPs=;
 b=LjiOdmt3VdfxAPYUlWWK0K+6Syr6dLAUDIUWXx/zjhUng3wn9iGkygOHT3C9kG210d
 hdFmLQXo6Z/ZtLD4i6leUUOJFst9BrT5u1ib9ICrE4Crke/aqaUjPsgxZ5yBARQihrs/
 ICl2gZxD91j7xJspesiN/WmLIHOEwCJAHipTs26Fhcsjv0g5izgrR961qlptwhKlR3op
 ziH6h1dUwgmnI8Ectjis4yvcijofD0TgLLs5S/l+6IKIHhi6q4CPVOtPxXyPSx5msal2
 TghVawA+7+9KMiJjmxHq+s/bIZMcSjESZnjobhaNSGlpE2gGpzip6HAg2k3IcDxckcsI
 H3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9iPoN/xPXu3M+jg3nBdEsiKjATBEwYbgH8uZqlJmVPs=;
 b=k/HyqlYVI3WMcRCEzSlGkQ8zrQwpzJAjRKEXlT8zq29Nr15//8f8MvzkSvbJ0dYm0r
 3sldDw5xW6EOHawrwnDklApirChKwMRD1x8EuaF/ezacmI7Vb/5oZu5f4qZpPPQ5LeMN
 Xu6+/FhjGIitaB9Bw8clh4P1KKRXiG2t62zXGLbG0ceqtStUicuYDahgv5PXn3KoDtbW
 Ma0cBSn1Z03oAkpHzE2kT6wJcIGGnBpqkYb0XxNRpxN47fh9XwAD+ejS1GAmGz0buSKE
 Twg5d1/R5DfAu8uKKmlkvQN26tuFv5C/q33dVopoKnOk/xmKi1JEtcip76VdiZH/FdLS
 MbfA==
X-Gm-Message-State: ANhLgQ1d566KR/WK+A49jsaJ6NMJmkXX+AF7T+dUijN3IKmjhZ37PXjU
 lKZe4S8sq7yGdx+LigT7W+hFNBn2bSQqJmF/YKQ=
X-Google-Smtp-Source: ADFU+vtOPy4ybAGeBPQOyZ5k4VFSSn89UBFqiGTXPzSXBfB1TKe1DYJY7LTqnLtAjst9rdX9kcJTDUCpOHq0lQW7BsI=
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr362175wmm.79.1583184659784; 
 Mon, 02 Mar 2020 13:30:59 -0800 (PST)
MIME-Version: 1.0
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2020 16:30:48 -0500
Message-ID: <CADnq5_MajmWzO4ec+_yeUa+mkMbyJWQuGagwXaU+FpQAPtrmkg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Abramov,
 Slava" <Slava.Abramov@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 2, 2020 at 2:24 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Add the programming sequence.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 8ab3bf3..621b99c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>  /* memory training timeout define */
>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US  3000000
>
> +/* USBC PD FW version retrieval command */
> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
> +

This probably belongs in psp_gfx_if.h.

>  static int psp_v11_0_init_microcode(struct psp_context *psp)
>  {
>         struct amdgpu_device *adev = psp->adev;
> @@ -1109,6 +1112,77 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>                 WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>  }
>
> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
> +{
> +       struct amdgpu_device *adev = psp->adev;
> +       uint32_t reg_status;
> +       int ret;
> +
> +       /* Write lower 32-bit address of the PD Controller FW */
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
> +       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +                            0x80000000, 0x80000000, false);
> +       if (ret)
> +               return ret;
> +
> +        // Fireup interrupt so PSP can pick up the lower address

C style comments please.

> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
> +       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +                            0x80000000, 0x80000000, false);
> +       if (ret)
> +               return ret;
> +
> +       reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> +
> +       if ((reg_status & 0xFFFF) != 0) {
> +               DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
> +                               reg_status & 0xFFFF);
> +               return -EIO;
> +       }
> +
> +       /* Write upper 32-bit address of the PD Controller FW */
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
> +
> +
> +       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +                            0x80000000, 0x80000000, false);
> +       if (ret)
> +               return ret;
> +
> +        // Fireup interrupt so PSP can pick up the upper address

C style comments.

> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
> +
> +       /* FW load takes long time */
> +       while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +                                            0x80000000, 0x80000000, false))
> +               msleep(1000);
> +

Are we actually waiting for the full loading here or just the ack of
the command?

> +       reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> +
> +       if ((reg_status & 0xFFFF) != 0) {
> +               DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
> +                               reg_status & 0xFFFF);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
> +{
> +       struct amdgpu_device *adev = psp->adev;
> +
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
> +
> +       while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
> +                                    0x80000000, 0x80000000, false))
> +               msleep(1);
> +
> +       *fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
> +
> +       return 0;
> +}

I think we need locking for mmMP0_SMN_C2PMSG_35/mmMP0_SMN_C2PMSG_36
since they are the mailbox registers for communicating with the PSP.
Maybe just a generic psp lock since I don't think we need fine grained
locking for psp.

Alex

> +
>  static const struct psp_funcs psp_v11_0_funcs = {
>         .init_microcode = psp_v11_0_init_microcode,
>         .bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
> @@ -1133,6 +1207,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
>         .mem_training = psp_v11_0_memory_training,
>         .ring_get_wptr = psp_v11_0_ring_get_wptr,
>         .ring_set_wptr = psp_v11_0_ring_set_wptr,
> +       .load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
> +       .read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
>  };
>
>  void psp_v11_0_set_psp_funcs(struct psp_context *psp)
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
