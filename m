Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58952C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 14:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C3E2146E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjRCDiDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C3E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF3E6E4E8;
	Wed, 18 Dec 2019 14:56:05 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4885A6E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 14:56:05 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id t2so2642092wrr.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n6z08uSeIIqXTca65d+sKrVT3vh7h+Fza87JIFV3NhU=;
 b=tjRCDiDAfnJJAyNmpGFhRyhjSLuHYsZD7hP/KnAmUZOIWyYTs22Gj/JpS5fnPoXqcG
 /AEDACWfTxqf8E9s2GF+4UT53L9CuePAlv7SoYSn1iu5Ed+4ON09OahV9tLF0KFjzjaV
 kSbo9t3fDMDfDgBs9ORyJnkGyngysWWT8Gmw1ulSRlVYqSXXBGLUjLjbXAkyI7ztHjvI
 j1+XOThPTLQ53xWRhZ1/vQ1qxJh0Z3QV6AngXs+M89ayiIJobttNFrA6i5Te85AIA7pC
 /YKOVhVFfABX9Gc5O2zKDIje8fs/2heen2CbrZfXcLQu+whPJV0YBvDGSo/q4TEToyxW
 oIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n6z08uSeIIqXTca65d+sKrVT3vh7h+Fza87JIFV3NhU=;
 b=L+taL7+XnOH9cB39KSJVGowd5nTiU0fyvJFu3jw/M4MBX2HzMG3ulPNsEJPbEDhYdJ
 1+oX7FP9Ut9PhQCQUwov66MDOxz1fjcJwkoY1pj8cwyzpB5TD2BWiHp2O+wE2ZoCbumc
 QTvE/ECI6J+ef5hCikqk3VaxK8Pn/ocsoS58i9Ig6LNnXosWNMQ+cUulCHDWkcahjONC
 yAT4SBGoA7MzxSCEKgfR9xYaMRLaANf7eqkdX1C3nfoovQz9S/3ZLW8NIpHK0G2GxKP5
 v8fQzpys3hmR4RqZ/NoWwEi/BjTuAHm7Z1RAhB3xc7ytY/9dMM5UAOuJuea8GBVDCP/a
 c/TA==
X-Gm-Message-State: APjAAAVZUi6ocb7DTMGqMFASinFOTPXBhb5YJlbMu6nQ716dDE2dcPUn
 BpRM3IaQ/lr17Vh2wy+YEO4GyKH62CDj6VRb2pmDd6zV
X-Google-Smtp-Source: APXvYqwK7kHPvDFbdIoGismhhK5mpULHTpOOQrn9CoedZFTeJ8hW6VxuRL4t9Xe10Sh93I93B4Bt3Y2OgH/Cuvsed7A=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr3464599wrq.206.1576680963873; 
 Wed, 18 Dec 2019 06:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20191218032457.28424-1-evan.quan@amd.com>
In-Reply-To: <20191218032457.28424-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Dec 2019 09:55:51 -0500
Message-ID: <CADnq5_PXP-TTS46rw6HcxPo8ZM_2djf9Ct12dyBQ9sMs7Cxv3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: no SMC firmware reloading for non-RAS baco
 reset
To: Evan Quan <evan.quan@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 17, 2019 at 10:25 PM Evan Quan <evan.quan@amd.com> wrote:
>
> For non-RAS baco reset, there is no need to reset the SMC. Thus
> the firmware reloading should be avoided.
>
> Change-Id: I73f6284541d0ca0e82761380a27e32484fb0061c
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c14f2ccd0677..9bf7e92394f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1439,7 +1439,8 @@ static int psp_np_fw_load(struct psp_context *psp)
>                         continue;
>
>                 if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
> -                   (psp_smu_reload_quirk(psp) || psp->autoload_supported))
> +                   ((adev->in_gpu_reset && psp_smu_reload_quirk(psp))
> +                     || psp->autoload_supported))

Will this cover the power saving case as well?  Do we need to check
adev->in_gpu_reset as well or can we drop that part?

Alex

>                         continue;
>
>                 if (amdgpu_sriov_vf(adev) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index c66ca8cc2ebd..ba761e9366e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -676,6 +676,19 @@ static bool psp_v11_0_compare_sram_data(struct psp_context *psp,
>         return true;
>  }
>
> +/*
> + * Check whether SMU is still alive. If that's true
> + * (e.g. for non-RAS baco reset), we need to skip SMC firmware reloading.
> + */
> +static bool psp_v11_0_smu_reload_quirk(struct psp_context *psp)
> +{
> +       struct amdgpu_device *adev = psp->adev;
> +       uint32_t reg;
> +
> +       reg = RREG32_PCIE(smnMP1_FIRMWARE_FLAGS | 0x03b00000);
> +       return (reg & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true : false;
> +}
> +
>  static int psp_v11_0_mode1_reset(struct psp_context *psp)
>  {
>         int ret;
> @@ -1070,6 +1083,7 @@ static const struct psp_funcs psp_v11_0_funcs = {
>         .ring_stop = psp_v11_0_ring_stop,
>         .ring_destroy = psp_v11_0_ring_destroy,
>         .compare_sram_data = psp_v11_0_compare_sram_data,
> +       .smu_reload_quirk = psp_v11_0_smu_reload_quirk,
>         .mode1_reset = psp_v11_0_mode1_reset,
>         .xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
>         .xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
> --
> 2.24.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
