Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EA4D37496
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 20:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF38A10E281;
	Fri,  5 Dec 2025 20:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LOp6J/Bf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B299E10E281
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 20:00:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DCBE760010;
 Fri,  5 Dec 2025 20:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A81BC4CEF1;
 Fri,  5 Dec 2025 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764964804;
 bh=eEJmg1qZN7rgedVbaCteREf8W1YVBrdm/nmSoXpv24s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LOp6J/BfItJjPv0vvqFf0Mx7Ex18G1/73btIOHe4dAn1nnOAQtoxS75B+l6ol4Rhu
 dAqI+JuTuJZoB/158WaBBdb313C1fVZlXu7vqxHUNz3Xl3p1NY0em9UTA/dDnST8Ng
 4y8gIYAXwCALFLB1OLfXDDtUEC8XGQGImjGmimhaCTiugHAukZub/9z4oD26+hyWxs
 w9t3GfTctMlwPCI31y6ax/iNHGPJe2syPC4lpeuom1rPWeWiqbd8YFWHcmU3ks8Vgm
 GbBo8nA1TClRSe5EgmJis1/o3BEPigiLDQazitdV1eFZOM4ybfKQLyWjlPKM6widPx
 dzDOQI7kvZzTw==
Message-ID: <b131aaf7-d747-45bb-b5a7-77c9db77a050@kernel.org>
Date: Fri, 5 Dec 2025 14:00:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: bump minimum vgpr size for gfx1151
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent.Russell@amd.com
References: <20251205195730.1266877-1-jonathan.kim@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251205195730.1266877-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/5/25 1:57 PM, Jonathan Kim wrote:
> GFX1151 has 1.5x the number of available physical VGPRs per SIMD.
> Bump total memory availability for acquire checks on queue creation.
> 

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index f1e7583650c4..80c4fa2b0975 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -409,6 +409,7 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
>   		vgpr_size = 0x80000;
>   	else if (gfxv == 110000 ||		/* GFX_VERSION_PLUM_BONITO */
>   		 gfxv == 110001 ||		/* GFX_VERSION_WHEAT_NAS */
> +		 gfxv == 110501 ||		/* GFX_VERSION_GFX1151 */
>   		 gfxv == 120000 ||		/* GFX_VERSION_GFX1200 */
>   		 gfxv == 120001)		/* GFX_VERSION_GFX1201 */
>   		vgpr_size = 0x60000;

