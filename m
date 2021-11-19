Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4784C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 21:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E726E1CE;
	Fri, 19 Nov 2021 21:30:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42456E1BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 21:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+ycXcy/WLH3fdtep/8HKnfPibCm1AOsDWpsRSD5Q33REC28asmVs17gwxOIJaLW6eI1+wZMrB0oBzzp8FY/JFYviD+D/+epwJdGxVwZI+zWLJgwZp558knhalL48bPyPRrHKsZ5noEjSvjhweOLMQzbrAEzwYc6zt4blFTpWnww3aDc/jcAInBI81x4fI+uKh5NMFP0q4j3D+rWWpqBunKIXJLP3s9/QJ8k6eUbNL+UJff6FvlfOon0OcLzjaFGQo7VmUiT4/PYma+sgZ2S77N7zaBMvjLzwW/E5LjeBQ1lQEVw+aReKl8m7xI0Ak8dShejMdXLaqCIkUWjsJHImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QqI5LaqF1Y5ARuk9QX7EBI/OmKc1aotnaNXWEK81dA=;
 b=Z/7gJrkv0Uf7qMNlUSHfNfaJvZT2Er83hFbC5dq55pP9Z0yypp+P9qND1Rh76r0k8yGiJqnlYASxeRjB5cKxJUAco6xl7396S2FfF8YWSkfBRE4wNW2fTaMhXH31xnQPKBwL6OXGLVjw9XUZLgi5DsMLys4tT0GZV/i0t9QJ6eDJwG1ib6YralyH9gxTs7lY4fBnGKniDjvTm035Kni9dcNZwvQa6vaGcTs3QOOrF65p7KecEVtrGbZxB/gCQaomVYC3/WEzruFI/sds08Tvc9TdEXrbhOEPBER7/QC9Z3790KAspWiVBLaavqYu5Cbp3is34Mk6hZcc/iGwCtdvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QqI5LaqF1Y5ARuk9QX7EBI/OmKc1aotnaNXWEK81dA=;
 b=YLDDddr5p/fIuwAIUlb1dtzmeXHyYi+S8HSaTxzga5NpeF/7J0EFjgN2vTrA1PGliliTdvC0MdN9g0LtsUD4wq8yuOE9tqN0TNaocS4U4zHBbg9gLsKCOkm006I47ljRtugkVjeXvR5Mp5xmcqVh3JM+TIP+QTJMouTVwgJm9pY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 21:30:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 21:30:22 +0000
Subject: Re: [PATCH v2 3/4] drm/amdkfd: move to dynamic device_info creation
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
 <20211119195258.2173551-3-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <415de547-ff92-fe1e-2d8b-d505cffb2713@amd.com>
Date: Fri, 19 Nov 2021 16:30:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119195258.2173551-3-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR0102CA0044.prod.exchangelabs.com
 (2603:10b6:208:25::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 21:30:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1742a6f-ff5c-40a0-73e6-08d9aba3caf5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5145E46C36DFFFC519BA14AE929C9@BN9PR12MB5145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDZRrT6jMIUWLsKcuXrgo1Q4cC7tNBUcMaCA9q6qfkb/45O8gEnauhQE0p6nKABCxWgThUr79TXZENAOaQEIoZFxR0T2LY02biLRnQOgaawUtrrRHxPV0AnEHjSdwhvR0EUiNofiSIAaCKLv+Gyu+wsiclYmbk6zTjk3VPA28TtioctIvuhHvmTuTtlUmbM8p5DmGhXRs1p4UF8BgnCFjLhYPihergMkHYtP1YQxWTnu+emvUx5AmfVN5Ja1Xs+TBhmNK0fiCjvt7AbrY21xWUpx/HplPqfdl7ml+V3cpoBIdxb6UWHpDU0c/bd37hDQxCkOb2WZCAePCN6yzK3GvxAXkfxU/YmC1LlMFe79I2kAA5yuOj+J8BtjGj41A1qjSqrJIOZ+3ceFNNgMIznidDyWIZ5k4YPtPJFfhE6a2GE2th8qjL9eb08O1+K67m57mKUrn9s3wrE7CtHaX+EoGmA96PNaSXZmqgkOu4niA24lSuRPFybAgiOhZ+jbCHuVC5GOHoVtwqbw85NAWicMnbox/icD9Z56ByNfOlbctC9EgTa1IgcQNLq3YnqmQdSsEMEYdLRr9YXFLflwklFt4dm+Vx5gqEDdLVbr2LAeEvjlU+Avl8kAfwzKUpEPNK4oFbg5N8aVz8/xHxE9FdAzBuiJpmk8QJM69XyMX+5wXvPDUpAQcYRDzmm5jr96Fab8srwd+rzCQMm4ENCFpDQdCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(6486002)(86362001)(508600001)(5660300002)(66556008)(66946007)(2616005)(66476007)(4326008)(36916002)(186003)(956004)(83380400001)(4001150100001)(31696002)(38100700002)(31686004)(16576012)(2906002)(53546011)(8936002)(8676002)(36756003)(316002)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXh5RUY3RHQwVWxXYXUwbmtpODJUWGsrbllxU003TEh3V1dSZzl2VTFLNDFO?=
 =?utf-8?B?QlNOUEF3N09oYllPTUVDMys2MTJ1UnR3T0gvbXFDclljem5RanpOVTBReWZx?=
 =?utf-8?B?d1U5TDBWbWNJVkEwWTliQ0xaOWtvNDBDTEpxbklkRXpHUm5PUDd3bGhIVm84?=
 =?utf-8?B?Qm11NGJvTjFyUkUwVCtYRC9KUzNwSWdBbm9nTmhBbU80eURDc0lVRUhWNVgw?=
 =?utf-8?B?ZGhOWHprN2s0VmhGUE1SRThUUW1ibFVTeUZJaE05dVl5d3g4MGVDRkgxNlEz?=
 =?utf-8?B?elF6N3lpNndWNVZZV0dPVS9VUnF6QktLWXUyZUZuSjBEeEFmbjNDc2JnZ254?=
 =?utf-8?B?ZHVpNnhJaVNMTUxFcTJaSTFCNGMvd29LTHFTalRpNS9FbldqT2YxcmxNUEE3?=
 =?utf-8?B?REYrOHdaS1F3akdMdU9oaWthT0J1MGQ4OThHeENkbGdiZkUycFJRZThMQkdm?=
 =?utf-8?B?UjEra0Vndlo5ei8vaEVlMlNWMTJkR1JuRXUvbXNpZkg1dkdhQWNoUnJlVnpo?=
 =?utf-8?B?Ym83Z0dLZ1hsSThyRkFsUXVTYmJXTVpSS3RieExvbWpDMlNFK1B3R0pXZU9Z?=
 =?utf-8?B?eUxqRTlPeW00YzdVSmNITkhZTUJwVGhUU3JsRVZWdHMxYjhnb0VWcml1MGJx?=
 =?utf-8?B?bGJUalR0MTdhS1FpU3AwUDJMc2tLNnR2Rzd2SHpKaWlGQVo2bTZBY0tjbTMv?=
 =?utf-8?B?VG9uQkRyK1hjTVBzVFJ4a3BPQlNSSWVWUEYvSzEweFFRb3J2VzBwbis0SnVS?=
 =?utf-8?B?VUUzSUp0WTZpeC9CdzdGR21hRlVTcVZsV2w1RWlKLytKNnJQWW5sYThaS0xK?=
 =?utf-8?B?eDB4VEQzNUpRN3poNXZHOVRpZWFCWkM0Q0VhNHdud3dlNVd3d1hWcEVWYjB3?=
 =?utf-8?B?bnE4aEtTeTNZTGZzeG56ZXRwcEVYUC8vc1pDdmZwNklBUy9RYjc0dk1oclV2?=
 =?utf-8?B?SWNRRzlKUDlTZWhMUFVYY1NPQ2dYcVpZTGVlSTJtWUtMdDIzUXoveVRGSDJR?=
 =?utf-8?B?cXdwTjE3UjZVYWh5cHE5Tlc3c21XS0NuSFFvcHNFUkNvVCtmanhHTVEzeXlB?=
 =?utf-8?B?MFk5a2Y1ajlGU2V2bVZxeVo1bDcyeVpJRGVpaVpLUkx6UnRKYTNkSTJka2J2?=
 =?utf-8?B?T3FPRU1hQ08vM3FrWXdINzBSUUV4WTJweHdqMTIvWHNPWnpSTlBVRXIxTTZL?=
 =?utf-8?B?OGlncGpWQ1JkQ1FVaGNRSUxoeHpCQXRDRmI0aUVXMkM2Y2xDMWlsWDdjUUZp?=
 =?utf-8?B?b2xwUlNocVY4TEVHQ08zdjZkYjU4Yi95L2lLTHB0SWRvUDRNZmIwbmdzTjNY?=
 =?utf-8?B?VkpyemZuZFJ0bDdlQVo0T0tJaWRaaThLWFFza3pTc1lPejB2VEt3ZDhKM0hn?=
 =?utf-8?B?NzZnd0xyL01RTGNyLzBjYlhWczlHVU81TjhiajhtRDRTbTYwOW1NNExiOFVL?=
 =?utf-8?B?WjZoMGMzZWtUUWtDUStHUWtNK05FK0U0cGs5MWtuSFcrcGxWdDhQQmxGaFA0?=
 =?utf-8?B?V0V4SEtYWU5wYlFLL0RFVXM1UG1VK1JzN1JTZTJOU2JnUlJVM21DYW9tOFJl?=
 =?utf-8?B?Rk5xdGdFbGRweVE2WUg1eWdqWFhPTnlCdGo5OS9mai9UZVlzTlg0d054SjBt?=
 =?utf-8?B?YjNERWJBa2dCeWYzbEd6VUNoZGxhbm1nT1ZuS2tWbzRUU3ZSVG9ka0duL1dF?=
 =?utf-8?B?WlZtZkE0NEl1bU5EaWFUWWp5dFRhektHMjlSK2wxVlEwUkZKdWZNY3dab2VN?=
 =?utf-8?B?ZU9Hc3N0NFp2VW1OQXFScWNuTFF0dTVrMFZRaW15RWtUM293VmNBcUZkOUh3?=
 =?utf-8?B?QWlmYUhTVG9IWU5MbzNoNS83K3d2MDlEWHlRT3RyYVhFYmRYMkNXVS9uM1Ey?=
 =?utf-8?B?N1ZsZ1AvdzJKZWhDVEwxdk1nOUt6djZRT1FqZmU5MlR0ekU1b0FkeXNSY2J6?=
 =?utf-8?B?QlFBMkx5WVk3SG1zZXpJdnVDS1N4WVdCNjJmR0RqcXYrMVFwOVVNQXdvZjdY?=
 =?utf-8?B?dkZTZjRISmgvemFYRk84MGJ2aVU5VDNiRjkvQWdVOTFYazFDRmJQSmZ3Uzht?=
 =?utf-8?B?dUZJaUVNWkJsdk5KSC9SRkhieVUvMDdTUElLdnhYbkpscmxiQmxLWkMwb1Zw?=
 =?utf-8?B?eHAyT3l2OW5FWlUxUTk1bldMb08yUjhxVVBvQnhLQjFGVWFuRG1raWl3MXYx?=
 =?utf-8?Q?MQhLx4OP5uNJH02JFsaf7gk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1742a6f-ff5c-40a0-73e6-08d9aba3caf5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 21:30:22.3778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aykQTkeCcFVG1doY6cF03Bzr623OHEemdD2p53Bupjkqv3XMMNtS8gR5VBYnXBW1MKqeV4MvEaejJQ6f5XeJQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-19 2:52 p.m., Graham Sider wrote:
> Change unsupported asic condition to only probe f2g, move device_info
> initialization post-switch and map to heap.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 183 ++++++++++--------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |   2 +-
>   2 files changed, 79 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 676cb9c3166c..7ddea653b3d9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -574,191 +574,151 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
>   
>   struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   {
> -	struct kfd_dev *kfd;
> -	const struct kfd_device_info *device_info;
> -	const struct kfd2kgd_calls *f2g;
> +	struct kfd_dev *kfd = NULL;
> +	struct kfd_device_info *device_info = NULL;
> +	const struct kfd2kgd_calls *f2g = NULL;
>   	struct pci_dev *pdev = adev->pdev;
> +	uint32_t gfx_target_version = 0;
>   
>   	switch (adev->asic_type) {
>   #ifdef KFD_SUPPORT_IOMMU_V2
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   	case CHIP_KAVERI:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &kaveri_device_info;
> -		f2g = &gfx_v7_kfd2kgd;
> +		gfx_target_version = 70000;
> +		if (!vf)
> +			f2g = &gfx_v7_kfd2kgd;
>   		break;
>   #endif
>   	case CHIP_CARRIZO:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &carrizo_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80001;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>   		break;
>   #endif
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   	case CHIP_HAWAII:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &hawaii_device_info;
> -		f2g = &gfx_v7_kfd2kgd;
> +		gfx_target_version = 70001;
> +		if (!vf)
> +			f2g = &gfx_v7_kfd2kgd;
>   		break;
>   #endif
>   	case CHIP_TONGA:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &tonga_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80002;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>   		break;
>   	case CHIP_FIJI:
> -		if (vf)
> -			device_info = &fiji_vf_device_info;
> -		else
> -			device_info = &fiji_device_info;
> +		gfx_target_version = 80003;
>   		f2g = &gfx_v8_kfd2kgd;
>   		break;
>   	case CHIP_POLARIS10:
> -		if (vf)
> -			device_info = &polaris10_vf_device_info;
> -		else
> -			device_info = &polaris10_device_info;
> +		gfx_target_version = 80003;
>   		f2g = &gfx_v8_kfd2kgd;
>   		break;
>   	case CHIP_POLARIS11:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &polaris11_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80003;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>   		break;
>   	case CHIP_POLARIS12:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &polaris12_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80003;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>   		break;
>   	case CHIP_VEGAM:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &vegam_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80003;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>   		break;
>   	default:
>   		switch (adev->ip_versions[GC_HWIP][0]) {
>   		case IP_VERSION(9, 0, 1):
> -			if (vf)
> -				device_info = &vega10_vf_device_info;
> -			else
> -				device_info = &vega10_device_info;
> +			gfx_target_version = 90000;
>   			f2g = &gfx_v9_kfd2kgd;
>   			break;
>   #ifdef KFD_SUPPORT_IOMMU_V2
>   		case IP_VERSION(9, 1, 0):
>   		case IP_VERSION(9, 2, 2):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &raven_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90002;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>   			break;
>   #endif
>   		case IP_VERSION(9, 2, 1):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &vega12_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90004;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>   			break;
>   		case IP_VERSION(9, 3, 0):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &renoir_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90012;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>   			break;
>   		case IP_VERSION(9, 4, 0):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &vega20_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90006;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>   			break;
>   		case IP_VERSION(9, 4, 1):
> -			device_info = &arcturus_device_info;
> +			gfx_target_version = 90008;
>   			f2g = &arcturus_kfd2kgd;
>   			break;
>   		case IP_VERSION(9, 4, 2):
> -			device_info = &aldebaran_device_info;
> +			gfx_target_version = 90010;
>   			f2g = &aldebaran_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 1, 10):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &navi10_device_info;
> -			f2g = &gfx_v10_kfd2kgd;
> +			gfx_target_version = 100100;
> +			if (!vf)
> +				f2g = &gfx_v10_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 1, 2):
> -			device_info = &navi12_device_info;
> +			gfx_target_version = 100101;
>   			f2g = &gfx_v10_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 1, 1):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &navi14_device_info;
> -			f2g = &gfx_v10_kfd2kgd;
> +			gfx_target_version = 100102;
> +			if (!vf)
> +				f2g = &gfx_v10_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 1, 3):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &cyan_skillfish_device_info;
> -			f2g = &gfx_v10_kfd2kgd;
> +			gfx_target_version = 100103;
> +			if (!vf)
> +				f2g = &gfx_v10_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 3, 0):
> -			device_info = &sienna_cichlid_device_info;
> +			gfx_target_version = 100300;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 3, 2):
> -			device_info = &navy_flounder_device_info;
> +			gfx_target_version = 100301;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 3, 1):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &vangogh_device_info;
> -			f2g = &gfx_v10_3_kfd2kgd;
> +			gfx_target_version = 100303;
> +			if (!vf)
> +				f2g = &gfx_v10_3_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 3, 4):
> -			device_info = &dimgrey_cavefish_device_info;
> +			gfx_target_version = 100302;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 3, 5):
> -			device_info = &beige_goby_device_info;
> +			gfx_target_version = 100304;
>   			f2g = &gfx_v10_3_kfd2kgd;
>   			break;
>   		case IP_VERSION(10, 3, 3):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &yellow_carp_device_info;
> -			f2g = &gfx_v10_3_kfd2kgd;
> +			gfx_target_version = 100305;
> +			if (!vf)
> +				f2g = &gfx_v10_3_kfd2kgd;
>   			break;
>   		default:
> -			return NULL;
> +			break;
>   		}
>   		break;
>   	}
>   
> -	if (!device_info || !f2g) {
> +	if (!f2g) {
>   		if (adev->ip_versions[GC_HWIP][0])
>   			dev_err(kfd_device, "GC IP %06x %s not supported in kfd\n",
>   				adev->ip_versions[GC_HWIP][0], vf ? "VF" : "");
> @@ -773,7 +733,14 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   		return NULL;
>   
>   	kfd->adev = adev;
> +
> +	device_info = kzalloc(sizeof(*device_info), GFP_KERNEL);

Just thinking out loud, no need to change this: Maybe device_info 
doesn't need to be dynamically allocated. It could just be a member of 
struct kfd_dev. Except that it would result in a bunch of cosmetic 
changes s/device_info->/device_info./g.


> +	if (!device_info)
> +		return NULL;
> +
> +	kfd_device_info_init(kfd, device_info, vf, gfx_target_version);
>   	kfd->device_info = device_info;
> +
>   	kfd->pdev = pdev;
>   	kfd->init_complete = false;
>   	kfd->kfd2kgd = f2g;
> @@ -1039,7 +1006,13 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   			amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
>   	}
>   
> -	kfree(kfd);
> +	if (kfd->device_info)
> +		kfree(kfd->device_info);

NULL-checks are unnecessary before kfree.


> +	kfd->device_info = NULL;

This is unnecessary because you're about to free kfd anyway.


> +
> +	if (kfd)
> +		kfree(kfd);

Same as above.

Regards,
   Felix


> +	kfd = NULL;
>   }
>   
>   int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 3e11febee7c6..1f11e8271f2e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -232,7 +232,7 @@ struct kfd_vmid_info {
>   struct kfd_dev {
>   	struct amdgpu_device *adev;
>   
> -	const struct kfd_device_info *device_info;
> +	struct kfd_device_info *device_info;
>   	struct pci_dev *pdev;
>   	struct drm_device *ddev;
>   
