Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DC9C021B1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 09:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A613810E78E;
	Wed, 19 Feb 2025 09:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="HTL5N18n";
	dkim-atps=neutral
X-Greylist: delayed 511 seconds by postgrey-1.36 at gabe;
 Tue, 18 Feb 2025 19:32:16 UTC
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2168610E74B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
 t=1739906624; bh=UsHprwUzcak6E7u9y4I+nNp4kEhZgiMyoeXQBNAwv7Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HTL5N18nVlbyzHK3PepxzC6EZ9mzrdnFrpq9K9fk5495h1AerJ7rLrz7A7j6r0y4v
 nPjB0/4JzCqDwRWkI35EgPAVpzq2yrdfbfUE663ykIdHkPOK4iVIvjGR38wEg4ZdE2
 2ErjIMpWEarg2PY76h2maKetyYLhV1jzyjYXLfzh/XAzQS+l2wXwkvN4UzcP3feMkq
 hB6UCzz2Q/moepRMaqke81ah6ncCaUJmmNLL++9DRxddZk42rfy6Z5j3/Ge1yWW/7q
 aJIgyRSoiZBRNCf68NRHvUnf95qvGBQiQEprExrsdcgZXNPGHxg6ctRrGfEOuPfWgQ
 WgCUV490HU0KwTbzRWhqrJF7nAqsZdi/bBm2Rr/qdSXiYkLlfx/ub3JEWvarx/C4Il
 fjycKbD1Wvh9tM1GFM62kvXi6+xCwnwO34/nRlAo/ZukqWbeF5Wctsdft0Xax5nSqL
 cyMpqGf1H0eO4qwBDc77mQWew4LIVpLz2D/aT38GdgkRQfu4lhRfNG9oOviSSuXP5k
 +AHfwWcSKcPewHLVakMHhu+fY0vwcUdsTHdvsSiOABNQvWAkYTLt46N6LPeBkrlUaV
 Q0VFFcGO1rqQ870u/KfJ89dZPI/lRVdS9fy5D8IjgHH14cyEbZaUr/NtDIKkHjMrQE
 RLKWvkNDtwDAc13Ix71SOeUs=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl
 [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
 by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 0CBFA160133;
 Tue, 18 Feb 2025 20:23:44 +0100 (CET)
Message-ID: <4677aab9-c95e-4903-8c3e-9b9ce15d50b7@ijzerbout.nl>
Date: Tue, 18 Feb 2025 20:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] drm/amdgpu: Generate cper records
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 Yang Wang <keivnyang.wang@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
 <1041cc7f576992060a96b02c9f3dd5b41bc7a3f9.1739519672.git.xiang.liu@amd.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <1041cc7f576992060a96b02c9f3dd5b41bc7a3f9.1739519672.git.xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 19 Feb 2025 09:11:03 +0000
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

Op 14-02-2025 om 09:07 schreef Xiang Liu:
> From: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Encode the error information in CPER format and commit
> to the cper ring
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Yang Wang <keivnyang.wang@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 32 +++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index ed1c20bd8114..c0da9096a7fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -384,6 +384,36 @@ static bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_smu_type
>   	return ret;
>   }
>   
> +static void aca_banks_generate_cper(struct amdgpu_device *adev,
> +				    enum aca_smu_type type,
> +				    struct aca_banks *banks,
> +				    int count)
> +{
> +	struct aca_bank_node *node;
> +	struct aca_bank *bank;
> +
> +	if (!adev || !banks || !count) {
> +		dev_warn(adev->dev, "fail to generate cper records\n");
The check for !adev is suspicious in combination with the 
dev_warn(adev->dev...
> +		return;
> +	}
> +
> +	/* UEs must be encoded into separate CPER entries */
> +	if (type == ACA_SMU_TYPE_UE) {
> +		list_for_each_entry(node, &banks->list, node) {
> +			bank = &node->bank;
> +			if (amdgpu_cper_generate_ue_record(adev, bank))
> +				dev_warn(adev->dev, "fail to generate ue cper records\n");
> +		}
> +	} else {
> +		/*
> +		 * SMU_TYPE_CE banks are combined into 1 CPER entries,
> +		 * they could be CEs or DEs or both
> +		 */
> +		if (amdgpu_cper_generate_ce_records(adev, banks, count))
> +			dev_warn(adev->dev, "fail to generate ce cper records\n");
> +	}
> +}
> +
>   static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
>   			    bank_handler_t handler, struct ras_query_context *qctx, void *data)
>   {
> @@ -421,6 +451,8 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
>   	if (ret)
>   		goto err_release_banks;
>   
> +	aca_banks_generate_cper(adev, type, &banks, count);
> +
>   err_release_banks:
>   	aca_banks_release(&banks);
>   

