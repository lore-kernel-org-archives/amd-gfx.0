Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E1C43211
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 14:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA5A206F9
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 14:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA5A206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85EB16EB6C;
	Thu,  3 Dec 2020 14:11:54 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FA76EB6C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 14:11:54 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id k3so1807583otp.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Dec 2020 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FxtRDZW8dHHY+Zve+0XAbI+6FwxaCpuEJJ+cE26Tvwc=;
 b=pvbw6H4CRQdkZbLUsw4AivM0DX6IQ0xMLN63PYlyl3/lzMIf0l7LJ9kW4ZLnV5JTQP
 Dz3OEVrXuRz8G9uRmKDqp0q7qFibFApmiyxtTYUyv7t30xGs60mQNPsfQLlfFHJY4Vi2
 o9beXQFZbaVoemKtEIBQL0me6S4gmmPYHHbvF5z5oEJlB0utAt3s1GpxAX3c8W7NRx6y
 zmwqVX5XHzyQAROtivQbcVMfc6fGiGJ2fJw2Ov/LKjHCGAm6cmYrCCkm4/WH3D26L3Qh
 ouVd8yxYrjWyMA8bCGblSiTidYrTSAUS8s00/Suwx5sJl/JBpFwSGcSJGF1K6oF3g5FA
 MCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FxtRDZW8dHHY+Zve+0XAbI+6FwxaCpuEJJ+cE26Tvwc=;
 b=p+/hFO5FzjLoHV8LyzM0UrvluXJ6L4k55sNUYkhYop3ne2Mor66oFZ+wt9h3bcrdRh
 yqw2yZaHN/+ryxsF/dryGXA3VP7Yi57zSa+93ldPrlqAec2WH6ieQ+ETFXFvM37AmAdQ
 cQcIPIl7KUAzNTV50CHEMAZSLUXl2+3aXcLTuKhigy9n3LQGsfdpOTx7AXdb8kH/ZilB
 DKWda1uleTc7qMvJHCJfFzxaxR/F+NniLx9Qa8bXv9cqfYr1bNHfXUC2JO/xVdhju2bF
 au3MOByaRvu8rvxezNMd/PVFlI7K2NDeHkJ3eDzdab397B/G4CV8D9QySKhr7ZkVlCFC
 4htw==
X-Gm-Message-State: AOAM532s//qbyjZYWwionqRSaBIIk+aqxAZUbDmhsTv8oDm9E0vyObRk
 QbHj2Jr4N+ki2cOCzHrgvj//AkraHW6ITyUtLdEoax67
X-Google-Smtp-Source: ABdhPJyq8D5x5uxlEm8/LJpltKzClZ73x6PlYqhbtb8tC/b2H1MBzZlslBaNhQB73Y1IGIB3emrYp+xZr9BkaSrfqNI=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr2230676otf.132.1607004713426; 
 Thu, 03 Dec 2020 06:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20201203062304.3421-1-sonny.jiang@amd.com>
In-Reply-To: <20201203062304.3421-1-sonny.jiang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Dec 2020 09:11:42 -0500
Message-ID: <CADnq5_N3Y=vUU_kjaHyHGDSKkmQcEFxnS0finE6GL7uViXR=7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: VCN 3.0 multiple queue ring reset
To: Sonny Jiang <sonny.jiang@amd.com>
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

On Thu, Dec 3, 2020 at 1:23 AM Sonny Jiang <sonny.jiang@amd.com> wrote:
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>

Please provide a patch description.  What is this and what does it do?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 4f718ee803d0..3eaabcfca94a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1080,6 +1080,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>
>  static int vcn_v3_0_start(struct amdgpu_device *adev)
>  {
> +       volatile struct amdgpu_fw_shared *fw_shared;
>         struct amdgpu_ring *ring;
>         uint32_t rb_bufsz, tmp;
>         int i, j, k, r;
> @@ -1222,6 +1223,9 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>                 tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>                 WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>
> +               fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> +               fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> +
>                 /* programm the RB_BASE for ring buffer */
>                 WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                         lower_32_bits(ring->gpu_addr));
> @@ -1234,19 +1238,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>                 ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>                 WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>                         lower_32_bits(ring->wptr));
> +               fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
> +
> +               fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>                 ring = &adev->vcn.inst[i].ring_enc[0];
>                 WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>                 WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>                 WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>                 WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>                 WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> +               fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>
> +               fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>                 ring = &adev->vcn.inst[i].ring_enc[1];
>                 WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>                 WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>                 WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>                 WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>                 WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +               fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>         }
>
>         return 0;
> @@ -1595,6 +1605,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
>  static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>                    int inst_idx, struct dpg_pause_state *new_state)
>  {
> +       volatile struct amdgpu_fw_shared *fw_shared;
>         struct amdgpu_ring *ring;
>         uint32_t reg_data = 0;
>         int ret_code;
> @@ -1626,6 +1637,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>                                         ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
>
>                                 /* Restore */
> +                               fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
> +                               fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>                                 ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>                                 ring->wptr = 0;
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
> @@ -1633,7 +1646,9 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +                               fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>
> +                               fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>                                 ring = &adev->vcn.inst[inst_idx].ring_enc[1];
>                                 ring->wptr = 0;
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> @@ -1641,6 +1656,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +                               fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>
>                                 /* Unstall DPG */
>                                 WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
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
