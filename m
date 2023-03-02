Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7057C7EE37
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 22:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46ED10E2AA;
	Thu,  2 Mar 2023 22:33:45 +0000 (UTC)
X-Greylist: delayed 340 seconds by postgrey-1.36 at gabe;
 Thu, 02 Mar 2023 20:22:32 UTC
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDBD10E555
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 20:22:32 +0000 (UTC)
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id 66AE57A8007D; Thu,  2 Mar 2023 21:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1677788209;
 bh=64um2xzui5mAEr7iXOfSS5DWDtn5zN1YUEmJtlLMZFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SagLp58lw2qdYGTFxFoD9t8/cECaOC5aTNOISDjU53tzx9eTW4LGEeXFagT1maSFB
 K/wcvOovHE6S16pFFRQ9w0TaiW2T1bGAK/Sqz5RI4Z10f+U2yxlYOwVE4KbSA+fBcE
 iVyAJgdeQOYcUYt1LT829u+ZI7mdWmMdG8g1Y+X4Fj5xxTX2pFU2F+E86NQl+to2c9
 mPcXSauSO+NXcm4eVOuxIKcC5/9Br4bVPl7uHmGrZXMDqFh1h/67grK/rQaHhoKkkQ
 xxhC7JxymBrG5jNyMpxtmmsNyF8a+xAVX7l8w7UOz70Quagpyf0A4QD85v6yRf4Gbm
 keaEfqMqF5dcTFYe+olCOd8HNC9KMJqbtpMcbIZjPetae5UXIyF5EtNytjzilRXFqg
 BBsp8h0rz63nDKgHdUo0dY0Ko4ZBVsfX7TEMu+m1yauSPgjhKyG2Z/dM1kayfaF9fa
 gBTeCrSSOUSYS//Qycvdw91FXkQXJpMHrsPjEOj0ThvYtjoIBUyAmgLROwkm4vJMCu
 wEtNj8W3HUjmL5zeBxlklCTD7Nu1lO8ZXSd+zXkF+VRsFLsdC61Hh8EXTc9w9JrJC1
 ywTT2rKR0l6TNpb3e773zK1bN3w5IO2DKp5giaH7fhLOT+zAfpc4BKfYKPZgXCixwH
 JQTYl2KpdRW/ARJlw8IS0jeU=
Date: Thu, 2 Mar 2023 21:16:49 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.3.0
Message-ID: <ZAEEMQTI2L2UHOIa@glanzmann.de>
References: <20230302172731.721-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302172731.721-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Thu, 02 Mar 2023 22:33:44 +0000
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
Cc: amd-gfx@lists.freedesktop.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Mario,

* Mario Limonciello <mario.limonciello@amd.com> [2023-03-02 18:27]:
> The same strapping initialization issue that happened on NBIO 7.5.1
> appears to be happening on NBIO 7.3.0.
> Apply the same fix to 7.3.0 as well.

> Note: This workaround relies upon the integrated GPU being enabled
> in BIOS. If the integrated GPU is disabled in BIOS a different
> workaround will be required.

> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
> Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Tested-by: Thomas Glanzmann <thomas@glanzmann.de>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> index 4b0d563c6522c..4ef1fa4603c8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> @@ -382,11 +382,6 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>  		if (def != data)
>  			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);
>  		break;
> -	case IP_VERSION(7, 5, 1):
> -		data = RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
> -		data &= ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
> -		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
> -		fallthrough;
>  	default:
>  		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
>  		data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
> @@ -399,6 +394,15 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
>  		break;
>  	}

My tree did not have the above hunk, so I only applied the second hunk.

I replugged by mouse keyboard several times and I have no longer any
issues.

Find output of dmesg; lsusb; lspci; dmidecode; lscpu here:

https://tg.st/u/498cb495b307353870e4dbba901a9c7aa58b89d918f54fc73f014f9a4778cc2a.txt

> +	switch (adev->ip_versions[NBIO_HWIP][0]) {
> +	case IP_VERSION(7, 3, 0):
> +	case IP_VERSION(7, 5, 1):
> +		data = RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
> +		data &= ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
> +		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
> +		break;
> +	}
> +
>  	if (amdgpu_sriov_vf(adev))
>  		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>  			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;

Thank you for the workaround.

Cheers,
        Thomas
