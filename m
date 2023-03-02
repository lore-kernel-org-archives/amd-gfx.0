Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEFCC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 17:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967E510E14D;
	Thu,  2 Mar 2023 17:38:54 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC3F10E14D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 17:38:52 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-17638494edbso175461fac.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Mar 2023 09:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1677778732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dPJNPrl+JGFvRrUPliIvuT8oDr1GYP0gmogQcqrDqXk=;
 b=MHpVuM53usV507FsBa3xVKKcMOeC0f/jPspJV/U99QB+MjeN7OD13KY1u5aEZXrQMF
 QkFxMXfWtXDwyrhc+ykOB8gMjQNBTs8QDgX85Axpbok38YLRkKQrD40751CE4t4YExJb
 PBlb/dWMJ8hsSz/9CPBfUuRWULsL5eGINGi/xRwNtJiZYyrcSwzh5zJlMauPsoUx2UAv
 hHJVPTvnsQk7P7M+r1TPcUdMyIEBg69x6XFvx1lpPoY1ka3eMHlqoRbSjcOjQRneLBbO
 Ld6LT7Gm5IOaICOhVSGFWOEvPekEJnm3JN5TFMlulT8CK3YsBTPlNdVzqnXAuMN/sqq1
 yVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677778732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dPJNPrl+JGFvRrUPliIvuT8oDr1GYP0gmogQcqrDqXk=;
 b=7lSnqF0lfQ11eP3fxfH1/HZ1wMfzgh0oRfRu7sLmoYBvrBVYXcXDyzDqWuEIRzQ/DY
 Zctn53/Z/YHNOg1lDZokMWSX5EHd+7we19TdgE/uqfbbQKJFQeVWr862Uiinsev1h2DM
 7BMU02qZdeVoselX0FqZkFtSZz71UOk0PmcF9RAQiqKV8LEfeNrHfrt2osfGU4VBTXZ1
 8fnSbDE6dbgqWys59Nnlz+J9irMGI/2r3dLK++czL0WSP0hlJgHD9kSPz9c1kLcrng6l
 7Sivsk0EECks4GhGqWW3rPEGiwAx6E1sHykRBOCfvstFNSXnPAp3iUdspGHxU5oUh9qf
 u35A==
X-Gm-Message-State: AO0yUKWFY1zS+seDSIWQCIlwV5rozeil01B+b9OjpRrKyDJp3rJlixLh
 X0Pv8NgOrttuGJO5JZBWHplY+Hv3Dy9VpUMTxo3mdEq1
X-Google-Smtp-Source: AK7set8Rq4WXDR2/lG8qLHV5+O022bmTXZBsxhfwed2gNte/wDc8daDz4x89LPsKHfvowD4Ioj2bfoUb4nqSNGF16Xs=
X-Received: by 2002:a05:6870:b7b2:b0:16e:2f74:e5c1 with SMTP id
 ed50-20020a056870b7b200b0016e2f74e5c1mr2606309oab.8.1677778731812; Thu, 02
 Mar 2023 09:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20230302172731.721-1-mario.limonciello@amd.com>
In-Reply-To: <20230302172731.721-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Mar 2023 12:38:40 -0500
Message-ID: <CADnq5_OxyERXZ01rcGRWomsZkcQ_WmBqBf1EjS5kduo9b4PQOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.3.0
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
Cc: Thomas Glanzmann <thomas@glanzmann.de>, amd-gfx@lists.freedesktop.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 2, 2023 at 12:28 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The same strapping initialization issue that happened on NBIO 7.5.1
> appears to be happening on NBIO 7.3.0.
> Apply the same fix to 7.3.0 as well.
>
> Note: This workaround relies upon the integrated GPU being enabled
> in BIOS. If the integrated GPU is disabled in BIOS a different
> workaround will be required.
>
> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
> Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> index 4b0d563c6522c..4ef1fa4603c8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> @@ -382,11 +382,6 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>                 if (def != data)
>                         WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);
>                 break;
> -       case IP_VERSION(7, 5, 1):
> -               data = RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
> -               data &= ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
> -               WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
> -               fallthrough;
>         default:
>                 def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
>                 data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
> @@ -399,6 +394,15 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>                 break;
>         }
>
> +       switch (adev->ip_versions[NBIO_HWIP][0]) {
> +       case IP_VERSION(7, 3, 0):
> +       case IP_VERSION(7, 5, 1):
> +               data = RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
> +               data &= ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
> +               WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
> +               break;
> +       }
> +
>         if (amdgpu_sriov_vf(adev))
>                 adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>                         regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> --
> 2.25.1
>
