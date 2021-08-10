Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6EC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 12:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA4860E78
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 12:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAA4860E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD3689F71;
	Tue, 10 Aug 2021 12:04:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFEB89F61
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 12:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnAW62aFJ6B+iXSZE8AFEVW08rX2imI/SbupIXdHbEuGuzkcVbqr0vBCkiSO4PYxMjR62M2pz7lqmAp6qMfPTxHPk1isKJ5kX4bYgzedBad65dxaPnbTidfH8RSJCKYVsbv03kuBmzUbG0NZEVD5FZnEtsS24wLWkpQ2+fPLIqIPoMFLVDNf2RrYSxSvsMrY8lZX/MHASpWWNlhKQ+0IbNEMCJpr8VsnpwVNNrHbTaGiDCyDJhXL7fC06xsVJe6tYvYAjepfLWTNs0orY7J4eF2txOUrtizgGkSzPxcTCjxh3cCzUz88iLO+hEdgvCZ+Qx8nL+zunWFAcx9NaCLzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuVToNiVvZfAgI5eJDTs8mwMQenXxxxwZq4oEnckb8Q=;
 b=BzT0M+iuZfWz/qw+hzXNR7DDnQGZk6GxjyQqPHYjEs3gDdcBrB1MhcaZE1HB2IaEBE9K9cggFiNJi5/sJ0NNxWcsXooIbnzZv9NNMUTMuIg6qmliAGRAqUjg0OkTl15NipoZMYYT9wOYYEOk4vRGaaFG/OjDUiwc3q7BSyqqr76ZK7pQRenEAXdzOoKDRkWZYTOhScB0YFk0ye05rGex57J+rM6CzzE2/SsqorbqfdHz/a/gNvHv63UGNswYxEJNy1yHpayTc/ldzhPgVBhx1uGISGItzpevzzWPcMPzo0VWYj4An5Ve/7XDqlk9UeJ6BwVBtjmSKxM1nJEQ7INnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuVToNiVvZfAgI5eJDTs8mwMQenXxxxwZq4oEnckb8Q=;
 b=5daPJM0LGuMf6tymb+7F+ZnDxiK7CQSRqop14FQMw/1hPe7OOnEOmcgvS/n851TVaP3isWTgUW7kMq1INlj5nU/3VKAu6jnYWtU7VJecKcG8+VTcQSdt9syFbTD061n0weAP2d11W4vA8na62AzYbrfAkZFd0Z/p60r4uFRLkl4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 12:04:26 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 12:04:25 +0000
Subject: Re: [PATCH] drm/amdgpu: handle VCN instances when harvesting (v2)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: James Zhu <James.Zhu@amd.com>
References: <20210810030313.997451-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <7630c832-caea-b78d-8e3f-a945a8a5afa9@amd.com>
Date: Tue, 10 Aug 2021 17:34:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210810030313.997451-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0116.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::32)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR01CA0116.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 12:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43133df-df61-444e-7512-08d95bf6ff5c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52879102A26FE6041C2AB0A897F79@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy0FxjDZmxMpKevtPmmudxDtRkuaSLZ2+ZqJlTkW6FphR3dQ14Wov5f9ecCdwXdatiHLr0ljFhXZy1UD7H0vAVH30XizNG8kvEj406A+DFs/4VesKTNyoFt/B23EPg95xdk7eRAzCbd+oZzISu2oO23ww+oCzagH7FJxRkiW/xJ7rlal9zeKI3dygBPXAUdmqP6vs92p0kkQeUyNuuqI4XEWWYI52oH8SwHYPqbub/Sk5ry7bOmVngLM6uud+aEeowc9/nmrjsXDPSC+isKvhcIjPmctN1pTcUCG25zgw1RE4crv4rEZGOeWrar1XPwfB0xqP1FejVWczzzWfHXtICXO8Bt6k0ID3YDvq9hyD6mt5yofFXUMSbnXece35/UdcIymEibXxNO9OMeFc0rotLa0DF6ALoJkGFj1ZNLFMdSqtEv1D+WzMlzgbqybG8vddT8yETqZeQFq6qZk6QTcx3ZbSUAL0OSEKt4P7fkEeZBbX3Ej7oH7U/JTrpytnsKClFuVZjRvfgDZkyTjBzFAooSczNM7vqX2ftpq5rROPUBTqXxUiMmaxqKZ8uOVWBL/OVflYZk1U0nYeYJOS61TFYRxww7dmEyFWkqbz95OJ8q2kM9ObhcjXGq3wfpHlArA0CbbbpPudL1Bdk2UusZLQra/OZ08j9ggtlhqEObL4c1UwxfCT/O8Zp/tuzh9LHANL7J3H2GBIroAcQLapEbrwoOJYZTXByII1UIwohX7Dmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(2906002)(31696002)(8936002)(53546011)(4326008)(38100700002)(86362001)(5660300002)(6666004)(26005)(186003)(83380400001)(66556008)(66476007)(36756003)(316002)(16576012)(966005)(66946007)(6486002)(31686004)(956004)(2616005)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2ZONk5kVE9sQjhlTHFPeXVacnYrUDJZbk4rTnREVzdhYlBNTmhOR1hZRTg3?=
 =?utf-8?B?bFhzQUtwYnJBK2VUZWxkMFE3RndjZzBNTmVKaXlVYWZ2Q09LRkhvaDY1NUlC?=
 =?utf-8?B?RkhJVHBCRVYzeHA5cThaOHRPamhNMjJUZ0lLTUhZMXIzdTNjWWpoN3ZEek1q?=
 =?utf-8?B?L2d1Z3dDSUhzZUwyUmMvRkt0OHgzd21wb1VEZ1F6RnNyNlpjeGZQWVFWdlB2?=
 =?utf-8?B?c3JyeFFIUlRJeGxrUkpzZktWY2hWdS82VjMray90Y0VhNy9pVS91bTkvZjJ0?=
 =?utf-8?B?QkdVU2RFbVA0c0lpUys0Q29FNE5ZdEY5M3IyUzhOUVU0WXFxR29IdkI0WFRx?=
 =?utf-8?B?ZklBZzB0c2ZHdVhiMnd4bnAvR050V05CL2V3cjBSbXlrUnc5d1A0eDg4aWlt?=
 =?utf-8?B?NG4yK1A5VndKNmxNRURIQ2U3bHRmTUdXOUIzVFZLMzE5VEdLbWs0UjFJQWdX?=
 =?utf-8?B?RFJMU2dlL2pXVitBYjFYUDYranBSU3RRYUZJKzZFLzdqb2hzalZPeVJ5RW8w?=
 =?utf-8?B?WDNuQUozbTFyNXBVdEF5QktzOC9pMGJJQVJCUjIrR3lEcXFyVTV3NW4rYUkv?=
 =?utf-8?B?U3F1ekhPMjVreXJ0Wm5PSHJiRlN5M0lYTzRYNnlOeEJmaUxHMTJaS21lNkxa?=
 =?utf-8?B?T1FTU3luZnF3emFZNFVlOGcwRHFwRUdKaHFueVk2UVZoVG5HbFZCK3Z4Z1Er?=
 =?utf-8?B?VEJlTkl0TG1NbGxWQ1g5cUpramhSSXF3ZU9uOEEyU1JBU01oTTNGTzl6VXpS?=
 =?utf-8?B?UllObVorUDVGT2IybFhHQURGbzd1ei84ZEJJUVFrb0YydWFtTGJUSUYyRXln?=
 =?utf-8?B?V1RFRFVOb05lWlV2MVFCKzNIN2ZwM1JZM1pMVlB2dDczM3lIZTdIUjRYZnBJ?=
 =?utf-8?B?K3JmblhsL25JN3VpTjcxYzA3WjdrcVgzL3VMUmJGYXB3YnFSRkNaL3BUVVZE?=
 =?utf-8?B?VkZYSUxoWjJHbTR4NWtadGNkUHFqNis0T3dMSzZDVk5JZnNOT2thWGlEU3N0?=
 =?utf-8?B?aEFzcSs5ZjVrOXdseXlkWS9jdGdoZ08vYkxHZFY2YStLYlhwYjJiYXQ0bTlN?=
 =?utf-8?B?azZickV6K0pLa3FVL1dmdnI5eTgyWUVtWTNQS3lJQ0hzN2RGdWdXeGFvcmxP?=
 =?utf-8?B?WlNpWVA1eDZOeWNQTmYxczVrd3JOYXdiKzlmcEgwa213M001ajZlN2djeEEv?=
 =?utf-8?B?d3pDT2M4NU9pQnBMK1dKUUl1S2FEei81NnhITTZVbllnZEZybDA0c2ZIdnRz?=
 =?utf-8?B?MVIrdjRzYitVQlFlU1NwNHVFazFqemNZSGNvbzdzQnV5M25ZdldDRjk2ZHI4?=
 =?utf-8?B?MGVZQVFBMzNBQnRVeUJpTXpoVWthSWh1VzBSS2VReEU5dWZ4ZUlNbWVLcmx4?=
 =?utf-8?B?b0pnczJnVTdiVGNoU0NFM1VsdENGNEVhY1czbFJleGRDd0lld2tyTzQxaFBE?=
 =?utf-8?B?STdBZmEzbGp5ZU5KeDFxM0lSUmZHTFgvNFU1Y3dVbldNNE9Gc2tlWGJkYTJ6?=
 =?utf-8?B?OTNjTVF3TTVPcjNwNUNYR2FSRWxSWTY4UUs2cDA1UGpOTWpJcWR0WlN5TjBC?=
 =?utf-8?B?VkpQb0FwOEYrbVlhOVJVL2pmbkdyamVXWWpBcnVaVXNFU2RidGN2ZG5tY3Y1?=
 =?utf-8?B?c2dxWW51aXErTHdLSnRHd21RYlR6Y0gvT21nZ0w5aEVXQmZpdzNpNE1yTEox?=
 =?utf-8?B?b21STXB6VjMwQmJmWEhlbWZBYW5icnh1b0lMQ2IxYWwvV3FOZHU1NXlMSlR2?=
 =?utf-8?Q?ARZaiF0HAFC4cU+CZ3af4Gdd3uXt1aTAmtQu/EV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43133df-df61-444e-7512-08d95bf6ff5c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 12:04:25.7472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5HICae9wI1YZl1KjBM6l43xyU2P/RTY7j7rronMYCeJZsms4k6y3/ONjzKLveIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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



On 8/10/2021 8:33 AM, Alex Deucher wrote:
> There may be multiple instances and only one is harvested.
> 
> v2: fix typo in commit message
> 
> Fixes: 83a0b8639185 ("drm/amdgpu: add judgement when add ip blocks (v2)")
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1673
> Reviewed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 43e7b61d1c5c..ada7bc19118a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -299,6 +299,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				  ip->major, ip->minor,
>   				  ip->revision);
>   
> +			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
> +				adev->vcn.num_vcn_inst++;
> +
>   			for (k = 0; k < num_base_address; k++) {
>   				/*
>   				 * convert the endianness of base addresses in place,
> @@ -385,7 +388,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>   {
>   	struct binary_header *bhdr;
>   	struct harvest_table *harvest_info;
> -	int i;
> +	int i, vcn_harvest_count = 0;
>   
>   	bhdr = (struct binary_header *)adev->mman.discovery_bin;
>   	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
> @@ -397,8 +400,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>   
>   		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
>   		case VCN_HWID:
> -			adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
> -			adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
> +			vcn_harvest_count++;
>   			break;
>   		case DMU_HWID:
>   			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
> @@ -407,6 +409,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>   			break;
>   		}
>   	}
> +	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
> +		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
> +		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
> +	}

If there is only one out of two harvested, I think we should add 
something like
	adev->vcn.num_vcn_inst -= vcn_harvest_count;

at the end to reflect the actual number of VCN instances available.

Thanks,
Lijo

>   }
>   
>   int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
> 
