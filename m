Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCA7C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 23:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7058A11271D;
	Mon,  4 Mar 2024 23:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0FUd8Fx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B8C11271D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 23:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irTx7y4Z+JHeTC4bq+luHB9enzWbHJNdZ74a/tZEBNbb25rAAxdUzqeHmZuwc/v0pw0ify+SRYfhcqNjqWrbLLgEv+oL7ZQdKhjC2uoBr/rlwJSKGCzFiTUr8dayAp0Ll51WHjiIQHNItQPloWTlGMAg2mwn+oY0/bDEmkY+PUI1QuH8ewrekYwiceK7lTOQzFucHo6ah4RobARh/4vz9L6jTvq3gJwcSNEqi2Mu+Uc3rdaK5z2rbcG1a2EiOonOOFc1P1KOivkPuBG+q6XnIZhVeZJgKWCbr2dzLFZ6SziFvHF3vlARwZfydGn5B/1Ugm5/c3kJFGRu9lf+EYrJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxNMkGhacwvOhEiiEinCq1xMptrjZbc6JsqYh9YOZN0=;
 b=ggyPxX9bt+UjslMfwqgTgBfHfQuyZaHM6EmwtaSQPGLufQD8U3vqjGTmdLhZYY49QD27TEbBVaJWKE9t2yYQgE0l+OPO+OHNpEm+xcKJnfFkk8lMv1PeHFQK2/K2LMxvWbdzuwuzsB+BLGb5ovrUc1m89mmfyF3qSZff6BQJed+x80uujeB0cz5kJfdYDGWx0F8Iv9217lIMOSOeHg92Wm+j7ZRVD+aqKf9uOVxCfhZbjnIzibS0JWr01no4mMbbeESKN4lSr4tPmkoDr0uGvjAJnwmkW5ObOf50PWktJbGyN0oQrjvNHLMnU7Y/qihVJOqZKMJ0Ng7KQ4Ofwmkwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxNMkGhacwvOhEiiEinCq1xMptrjZbc6JsqYh9YOZN0=;
 b=I0FUd8Fx7FFQ64YV0K9LT9+Wq58iGxmhsStPLP9aTy2B9qy1lsnKkBX9gTfFwugfu85HMt33ZVhLRlYgIxN58+xl339U6eZ8zTpv50aCT7LVFv5vRrWo+zjQR5CT3USXXT2syC8antLVWgDMSdNvSbp3w4ft8CxaPSfE+qUbR0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 23:46:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 23:46:59 +0000
Message-ID: <5958ccab-35a1-4802-be50-77e9a7d80c10@amd.com>
Date: Mon, 4 Mar 2024 18:46:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: sdma support for sriov cpx mode
Content-Language: en-US
To: Samir Dhume <samir.dhume@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, gavin.wan@amd.com, leo.liu@amd.com,
 Alexander.Deucher@amd.com
References: <20240304151931.802397-1-samir.dhume@amd.com>
 <20240304151931.802397-2-samir.dhume@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240304151931.802397-2-samir.dhume@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea102cc-1043-43d7-dd98-08dc3ca56200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TctGjvdsEZik3dAh5OCimLMQ5al1oAS5WoT6xKqQLPlo5N6iW+rvt3vpi8ZQCPvaa7S4l0tzTcnp+FDX199VqwFjJ7xhEi1kB3Vme8HxQOb8bsHsLZwDb3C1mL901t242zQhsXt4KEYeA9z00BlsdpT3g3xPcszreRetUntRzeyHkSdYSA/H7RpdJ2NzDA5O2VVUm10He+f3FlXBDVQ8iqAzwbrlV9VH/7Dg8ILDus8Ido4OBM9oJ+avlgY8ont1Mww87D1dDpYSQfFlidO6fC+6gmooI84jwrgxwpNDPhvcLCFVQ9eV6kF6eMOIZEOdr7dsKmVo8k4cUTDHXvJqqki0i4l4vfTi4DZSzjtfPQop6zFddIoD1gJPcOmW2HXaXAhB2fs70B5erqDsvzQzP1llSVZUYm9g1gnHpn7KHE8htnJopqGaMAW+4Gudj2IXx2cokYFKAETo7VJSRHHp1qpLmCwCdn/NmLVG1pU1Z7FbE5/ppMqkQafbYJrGdZo/Y6DaPy6P6t9Ryx+L+4+B2dz24I6VemalGPQZT+ACY+AFqqNNd6Yb1nTehhCF1D/hE+XpZUU+FA3V+hB607nFG7vcUW6ffB9PeIXhxqoVRJfeFl0gp9m1fnffrzESvHl1W315BNSvMDD1ysFFCoWph7BgN/hXPYyml5UP8zEyg58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEdCeTU2dHdYR0Z4YUlnUkI0Y3ZDVXdkLzFGenhmSHc4dnlWZkxoTWFLNVh2?=
 =?utf-8?B?cXlpSVZ4VVZLR1g3dlEzdjIxNUFGTzQwMzJnNjVHWGlubVk2MmhvTDZHaUJ0?=
 =?utf-8?B?NjQwRjFwZTh4RXNzQktHbnF0eGx4Q3dhY3RxVExJb0pzM081L1NXemtIYWFn?=
 =?utf-8?B?T2p1K2Qrbm9NRWlFUHh3VzJaK3BsQkxva1VOaU9tcWtPZXJ5WjVTZzdSOFpS?=
 =?utf-8?B?M096dWNqdFZUblFwSFBJbmVwSUtvL0o3dHZXSjgwdG5DOHhKTDNtblljR0tK?=
 =?utf-8?B?UTQ0YUR1UVVmaUM2M0VwaVJmQ2lpZTdnVW9LYkdScjhERCs5ZFRvMFJmVzJY?=
 =?utf-8?B?WHhCaXZSMG1pSFR3RFBseXc2OFBoQkNzOU05V2FqSE1rSzhaYjM1WnVwNEx0?=
 =?utf-8?B?RkNFMkVUU3prYjM4a25uU3NGUVhuWFNEcEZLL3c3UzFxRWpqQTArTGxNZTMr?=
 =?utf-8?B?MXhmeUtjU1h4M0lZMy9La3BMSm1Qd1pLMEkyNWVSbzc4cG05Y2pieTlZUXBn?=
 =?utf-8?B?eXZvT3FGWjRzdlV1Zm94cWprNEtZWVlPYldXaEM1VEFpd1h4SnVzSHFjdmNs?=
 =?utf-8?B?N3c5VTVpTmRCR1pCcWtJUnFzQ2w1ZG9oTUVmN0UwelpkeGo5aGhHbHpYcURT?=
 =?utf-8?B?VHo2WkJEM3oyWG90blpmREpIOXVieGQ4Q01PYm4rREhPMXV6YksrbmltTDli?=
 =?utf-8?B?dUpZVTNHVDl0K3ZnRGNWZlVxcm5aM0h5dTNDRHVWbXFJbThEczdNWlVscWRM?=
 =?utf-8?B?OS9zYmNlOWVCcVpaeVkyZEZUWktYWGNPbmVvUk1tenhUWmlQR3lvMEpTUytT?=
 =?utf-8?B?ZTJSb1NiN1JnTTFDZkZtWTFpdXFXWHh3ZXVHY1V2dmRMc3QxSjlWdURDZFFj?=
 =?utf-8?B?RnF3YU1oSXA4aDdCb1o4U2FSRGgyZVRXb3MxYU5uZTFXUEtvVFRwU24waVdF?=
 =?utf-8?B?TVdqRy91b04wb3dsWlptYVVTTG16SjN6SUtSME5Bd0VVMFIzM0N3bUVTU3dG?=
 =?utf-8?B?Qy8rbzErRmI5dEQraU1xeVg0RXpQdWYvNnVDbGF4SmgwY2s3bU9xU0tORUhO?=
 =?utf-8?B?dXd4c3lQRlc5VDk5ZS9sMHNkdjE3WnRLelZpbWRwOGxVMnlkNTAzSzdpeE1t?=
 =?utf-8?B?SjN3cm1qL3U2Tzl4STk4VG5FakVlclNRd2E1WXEweE9NcHJmUlF4eUg4c0Zv?=
 =?utf-8?B?ZjM5cWRsNm9EQnBxN24yNmlUaUhSVWdqK2VBcU5TMUYzYXFCYVg1THNlcXVR?=
 =?utf-8?B?UU9pWVJuUmZsdHQrSUlwSHRzQm5VNHlMd0FBQS9PS1ZSZG9aOU5jQnc0djdt?=
 =?utf-8?B?Z3VKeitmeS9mUTFnSnF1d3EzOCtydUd2NzBBVkZqczhsTWlFZllxQlE0Z1ZJ?=
 =?utf-8?B?ZUZSTDZxUDVOMWptL3JjWjJLZlFXdDFveEpTVWlmVzM5OXFUWTJjYkZhSklQ?=
 =?utf-8?B?VGt2WXRrbEIzdWtQRmh6T29Pa0w4WVRjYWVlY2dBdTl2dFlMZjFHV1FWajg3?=
 =?utf-8?B?STM0WWtqRE9wS1UxY2QyVzM1UEVhb0I3YXlHWTg1eGRFVmh1UEQvdHdvdEt5?=
 =?utf-8?B?QnZLY2YrSHZlUUFjL0ZIWHlGQ0d0VHdLL2MyUUs4VVBueGdTSXUyQkhYZlM1?=
 =?utf-8?B?a2ozdHljTVBIYXJNZkw1SHJNS3ppcHIydHJncVNUaThtdUQ5V3c3MjYwMXV0?=
 =?utf-8?B?YmR6ZlhtVm1CdmV1UEFYRml1dGg3eDY2bWt6Z3Q4dWtpTmw5ZGNnZGlKS1pP?=
 =?utf-8?B?MXFBMDEwdW1OTG01WWFaeXo2cWFSdFlkQkM0d3Y5ZkFQUkVHb1djcE1wOG0x?=
 =?utf-8?B?ejJvN0lOd1JXZGVMaEJzQnAzQ1ZjVGQ1VGFqbmhoa25vYTJvMjIvUUFJT1Fy?=
 =?utf-8?B?cCtmZmJUWXQwc0ZHOUN4aVRPamFGVXhGV01hME1mazN4R2o3NnJGeE15TTMx?=
 =?utf-8?B?MGpmNy9MZGI3TmlKLytsVzJ5Wng2MXdTNHpBY2ZiUVJCTE9Wd2hYV3ZEbEtD?=
 =?utf-8?B?SWVjNFNhK2dCY0hQT1JjUlNzakgvUmgxaUpYTU1wcDBnbldxSnVCWFlWM01a?=
 =?utf-8?B?bjFGdW0waThXMnhsVUxCbGxySllRTWpxMjI2dUJXZ1FFcWVaTjRDMS9TVkFJ?=
 =?utf-8?Q?830KX67oIPEXXU+DdVyCBiUp9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea102cc-1043-43d7-dd98-08dc3ca56200
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:46:59.2822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me7U9NbRgpoeVe8iY5zX8JQbykNauvxD5NIiyAeHip8lkFjthRbmPrN5KtWBw5hfS3s6ShUCjLFoAghuaPZLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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


On 2024-03-04 10:19, Samir Dhume wrote:
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>

Please add a meaningful commit description to all the patches in the 
series. See one more comment below.


> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 34 +++++++++++++++++++-----
>   1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fec5a3d1c4bc..f666ececbe7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -82,17 +82,37 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
>   	}
>   }
>   
> -static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
> +static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev, unsigned client_id)
>   {
> +
> +	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> +	bool sriov_cpx_odd = false;
> +	int mode;
> +
> +	if (amdgpu_sriov_vf(adev)) {
> +		mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);

This queries an MMIO register for the current mode. Is that really 
necessary to do in the interrupt handler? Could we use the partition 
mode stored in xcp_mgr->mode instead?

Regards,
   Felix


> +
> +		if (mode == AMDGPU_CPX_PARTITION_MODE) {
> +			if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
> +				sriov_cpx_odd = true;
> +		}
> +	}
> +
>   	switch (client_id) {
>   	case SOC15_IH_CLIENTID_SDMA0:
>   		return 0;
>   	case SOC15_IH_CLIENTID_SDMA1:
>   		return 1;
>   	case SOC15_IH_CLIENTID_SDMA2:
> -		return 2;
> +		if (sriov_cpx_odd)
> +			return 0;
> +		else
> +			return 2;
>   	case SOC15_IH_CLIENTID_SDMA3:
> -		return 3;
> +		if (sriov_cpx_odd)
> +			return 1;
> +		else
> +			return 3;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1541,7 +1561,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
>   	uint32_t instance, i;
>   
>   	DRM_DEBUG("IH: SDMA trap\n");
> -	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
> +	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>   
>   	/* Client id gives the SDMA instance in AID. To know the exact SDMA
>   	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
> @@ -1584,7 +1604,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
>   	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
>   		goto out;
>   
> -	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
> +	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>   	if (instance < 0)
>   		goto out;
>   
> @@ -1603,7 +1623,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
>   
>   	DRM_ERROR("Illegal instruction in SDMA command stream\n");
>   
> -	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
> +	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>   	if (instance < 0)
>   		return 0;
>   
> @@ -1647,7 +1667,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   	struct amdgpu_task_info task_info;
>   	u64 addr;
>   
> -	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
> +	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>   	if (instance < 0 || instance >= adev->sdma.num_instances) {
>   		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
>   		return -EINVAL;
