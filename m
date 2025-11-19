Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15431CF2597
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 08:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE8D10E5A0;
	Wed, 19 Nov 2025 08:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="dcYE4HrS";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="CaYUJvsK";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0057110E5A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1763539671;
 bh=c9Br7pzaORGD08ep2Tk+MWr
 dgaH1H2ViaE4gQ7MErZk=; b=dcYE4HrST3VooFCCafbjLxkUL7WFw/3go+eJyO/XNXkEKKi/5N
 qfryyNX6t+B0e8T8yXOSazdcJWiA99rdSduwrfWwta8sLlMWU5kZd0X1L/oNBioQIHWV1YVBS37
 a7/+/Q4peTJtMZ9ZWnYIKC1U7BN7t8K4ergFUNpa9n3US1LXEOv8jmsQUOefVmShuyvEaq4VnSb
 1lRIc9rH3aRyNCzxdkyX8D3aml5C+22E9dWdDRPCHTaVI+OAKPD3b9iJl8pbllMbQW0qD/BY+3m
 U+KghGVWLOScHPRlIVY7BRwFS4bdE0hYCHbDs6XphqwJObYem0bLTs4ZZFINiIC28hw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1763539671; bh=c9Br7pzaORGD08ep2Tk+MWr
 dgaH1H2ViaE4gQ7MErZk=; b=CaYUJvsKkT81IsXMkawB07AiAbRADIGxiNB7BKIEsMu9Sf52cy
 ZYVhtvn4PtOciSshYKqt89PHmkEmkoiObKBg==;
Message-ID: <264534d7-86cc-4964-8225-07a32e2373cd@damsy.net>
Date: Wed, 19 Nov 2025 09:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc11: add amdgpu_vm_handle_fault()
 handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251118220637.3594610-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20251118220637.3594610-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Le 18/11/2025 à 23:06, Alex Deucher a écrit :
> We need to call amdgpu_vm_handle_fault() on page fault
> on all gfx9 and newer parts to properly update the
> page tables, not just for recoverable page faults.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7bc389d9f5c48..25cdcb850416c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -103,12 +103,39 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   	uint32_t vmhub_index = entry->client_id == SOC21_IH_CLIENTID_VMC ?
>   			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
> +	bool retry_fault = !!(entry->src_data[1] & 0x80);
> +	bool write_fault = !!(entry->src_data[1] & 0x20);
>   	uint32_t status = 0;
>   	u64 addr;
>   
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
> +	if (retry_fault) {
> +		/* Returning 1 here also prevents sending the IV to the KFD */
> +
> +		/* Process it onyl if it's the first fault for this address */

typo: onyl -> only (same for patch 2/3)

Pierre-Eric



> +		if (entry->ih != &adev->irq.ih_soft &&
> +		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> +					     entry->timestamp))
> +			return 1;
> +
> +		/* Delegate it to a different ring if the hardware hasn't
> +		 * already done it.
> +		 */
> +		if (entry->ih == &adev->irq.ih) {
> +			amdgpu_irq_delegate(adev, entry, 8);
> +			return 1;
> +		}
> +
> +		/* Try to handle the recoverable page faults by filling page
> +		 * tables
> +		 */
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
> +					   entry->timestamp, write_fault))
> +			return 1;
> +	}
> +
>   	if (!amdgpu_sriov_vf(adev)) {
>   		/*
>   		 * Issue a dummy read to wait for the status register to
