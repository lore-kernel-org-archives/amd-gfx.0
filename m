Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCB0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 18:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFC610E399;
	Wed,  9 Mar 2022 18:12:44 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105BB10E399
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 18:12:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A4C45B8214B;
 Wed,  9 Mar 2022 18:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BD9C340E8;
 Wed,  9 Mar 2022 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646849561;
 bh=4PTqqLuT0A0jBlDFjGkPjyWFJzJnwzxshFyQXDhoDBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fIk5Te7dML0Wj2jKZVgNYlmwgUp8VcNS6xDWZbos7pfvcqJ5Ssr8gmgxZYZihu03K
 GEAwRTCShkMJHXBplX7tkFF60zBx7zNqb/KO2od2ijDB9FYtZ4qRNYF2FkwiVOpB9G
 8FRbSL/mOzgJ8lV8J4HaVA2Ew0WGnaUPRs2mYWAzqgL7uURyeI0Hiena2rPt9hEsTo
 wDpZwyN1Y5jJqt+rgZlWZPs0XM4PoXMsxNm42KJCrRfzPS+A12Pk6VigPCJXaqDEDO
 UQQMyxeyCxhX1Mo1EnP10kBzRDGUQfnV2CK9u70kiF21WKRk9GyujDoeDp03eOi6Ja
 CO1J6YSp+YWhQ==
Date: Wed, 9 Mar 2022 11:12:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yifan Zhang <yifan1.zhang@amd.com>
Subject: Re: [PATCH v2] drm/amkfd: bail out early if no
 get_atc_vmid_pasid_mapping_info
Message-ID: <YijuEmuuPZYdBt0I@dev-arch.thelio-3990X>
References: <20220309022242.2625842-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309022242.2625842-1-yifan1.zhang@amd.com>
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 09, 2022 at 10:22:42AM +0800, Yifan Zhang wrote:
> it makes no sense to continue with an undefined vmid.
> 
> Fixes: d21bcfc01eb1 (drm/amdkfd: judge get_atc_vmid_pasid_mapping_info before call)
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>

Thank you for the quick fix!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 77364afdc606..acf4f7975850 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -500,21 +500,24 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process
>  
>  	pr_debug("Killing all process wavefronts\n");
>  
> +	if (!dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
> +		pr_err("no vmid pasid mapping supported \n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
>  	 * ATC_VMID15_PASID_MAPPING
>  	 * to check which VMID the current process is mapped to.
>  	 */
>  
> -	if (dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
> -		for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
> -			status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
> -					(dev->adev, vmid, &queried_pasid);
> +	for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
> +		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
> +				(dev->adev, vmid, &queried_pasid);
>  
> -			if (status && queried_pasid == p->pasid) {
> -				pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
> -						vmid, p->pasid);
> -				break;
> -			}
> +		if (status && queried_pasid == p->pasid) {
> +			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
> +					vmid, p->pasid);
> +			break;
>  		}
>  	}
>  
> -- 
> 2.25.1
> 
