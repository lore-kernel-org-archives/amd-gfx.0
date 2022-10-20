Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C2EC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 16:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBF210E442;
	Thu, 20 Oct 2022 16:02:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D7C10E4EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 16:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5iL8x1vbg60jfqfPBpR09GRfPWQbRhpeNaCjpHDjgr2smbumrsJfnjAdbRPLYip0FGASE5myMHkBVENIFCxU4tkeUiT8Y6Wsnx97fWmG9/f1gXY/SreLLzMCsDqVB4hOZhQm76mutLLIIaE/kycxpu7WKWqubzi12y5nfwP/uZtTRMBZoBFyvWrz/8o3rdl25k07iZWaOap1kVyPFLgqQCh6NAma5Q+yAET3zc/UUnAWtNEyWlz43vRV3mUGkLZdJtYSo8AH0Icob/FBhCtLximpOSMxDYRPE/HER8qTp6RcECJneYur7YDj/NSPlTEiNXSsC1ZnfWhcJMezb5GGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yW17vvVHkKA16QByGPYfFmQl6yVwrxeKS0HUF2wGzY=;
 b=SUm/n7XYFxcYVV2fzc8+O0IJL6Rhn0JTZa6EN3vT4w9PI//6Dt8l0m4ULsbZkA/43zNUTimvgYaao5V7wpCEshijasud/BEMbfxMwJ59N9vHeg9CDA/AvM277R2CIjPjQZ6Thk4fu30gcU829LqQ3behY1y3pkU7bWSJ1s5llopWS/3NnqVx1kLgc8hByo/+C5H2ixTKgAL0VLhnE8HcjbTSnWKjb9RTbEKE3xWGSsqOi5JplHwD/pN13+MfdEmmJ/p4fVqTBdxuBBp7ftHN3GTyAIuj04HNPwdgXKq6ehzBdQsPStQCKBgcjC9klMJgyMWll4I5Opn3KutcsSzFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yW17vvVHkKA16QByGPYfFmQl6yVwrxeKS0HUF2wGzY=;
 b=A/rI+t4TQJtbq9a641x/WKoqmtOh5kC+nU+s80T8UAMtWcZQ5HxaMbUQAkDdeABxghglSRkKWwDDol24fXmJILzjMYbiCo5xcRaAbS0NVDG540sP2AAkNB6MxtOjRi5rG91A8plXsh+fEdslhQfNQYh4Bw529zdfRqXIJpKC/PM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 16:02:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 16:02:49 +0000
Message-ID: <e92f2184-73bc-eb3c-d903-5a46c5c34ac0@amd.com>
Date: Thu, 20 Oct 2022 12:02:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property
 asic
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221020091515.2758445-1-Prike.Liang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221020091515.2758445-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c8274b-231a-4207-1dd5-08dab2b488e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWNOz93sKbRXOni1zF1R3PWGaYFa4qh6WK/eNOwC10HkbCN9N6SjDhpnnHxrt5FYq+h3xSUNP4ZzzZM4QieJUuty3Kj3Oy/TJ6ULGyf5b1sODFr1JIDTBZ+HyMydTXJ1vuNlnK0xlngudVKhD6YiCwRjbsgCU35d8fZC/Y+gIQ7Nt4fYe1V3vmZp/V0sEYn+cQNKp5dH3gmd4uQd6QRoRI02wkMyFD97Fq7EokwETf6++KB6hgDj6DxfaJyfsrVez6JHJ/iMamDChL8VTlPrdldcCWF45iR6S/s4yjfk5SVX0a3bF1K34tCPqch3oH570ktBNuZINVEYnzWyDqZR/kvWSracSum7y6LZIzJ59INWGQo7RVqGAS2pCbWuN/UMBGLiyyzesdfDf3gPYow35CVeHIDhXheor2u+vVWmB5vvM7RntHbMQcmyssKv20ASeZAaMHc6Dx//yA17M/UN9xc0GbCsZbTaSnMiHjUkxM3IV9Rpkl470MCaNigVRPvg36bMOKM+5o/pQuS1ZKKag5AJYPMgVScpTEVJJ/jUh0teiHtBsxd3HbyIBtPhchqbBWPlnTaLDu7ifPi+yoi2MMOxiOFMn3jBenzCAwSnRb/1OzELpVnLYxa2M1kJkyitakTCKC3rarbOBgBmB3OcdyXzARfENXBtRmMN1LHburCWhV9BOrtkXbli+ySrLSGZud3aT+JT1/8V3YhK3GbbmfxTazjk9pxEnuEp6v8D4yVppK8A7YSzTNz0kKn2k0HfLChP2DQy8lQDLYpKoha4T87x2CkvUuE3t8j2+LJ5fvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(83380400001)(478600001)(31686004)(6486002)(316002)(41300700001)(36756003)(5660300002)(38100700002)(186003)(26005)(6512007)(66476007)(8676002)(66946007)(4326008)(2906002)(86362001)(66556008)(31696002)(4001150100001)(44832011)(2616005)(8936002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9kcFhOamZ0YmszWDdnSWdLdUZ0VWQxVmdLSnpkQklQaHhrNmRaSFNzSkx3?=
 =?utf-8?B?cEk2am00c2F6T0c1aTR1V0NEaSsxRysreURSYWpaMXkvM1cybDRybXJPZnA2?=
 =?utf-8?B?ektydm05RElKaU8vcGkreFdhLzZLQWlQR1I1aWs4dXVNZllFVVE4ZFNHblZJ?=
 =?utf-8?B?MWUrYUgrNFpVeFBIV1Y2QjVDeHdvaUFNSFRVTkJlcmNoQU1nWSs4RHU1WU91?=
 =?utf-8?B?MUM1ZnM4Vm82R1hkV3VRbElSRHRjOW8wSEgxTTFxVGM0emZUS1J1dWZrR1Vy?=
 =?utf-8?B?S0V1cTNEN2V6WmhTNFJGQm9YSFc2clFXU1kvZ2RmblZwdkVHZ0IxdFU1eVBq?=
 =?utf-8?B?OE15ZXcyeGJ6Ym5jNVZOVzl2QzFBalk5VVBMMlhvc1hFT0tTdUhiZVdBSHZE?=
 =?utf-8?B?SU55MzZldWhyQ2FQRVFTWkRYTWVINkRNUnRVY09mclJoTFBVcytXSDFWWHc2?=
 =?utf-8?B?NHNEckllb0Z4ZEJWVWs5VThXZTVpQlZXN2VwWHZnTWRweklmYWJFdjVreGFm?=
 =?utf-8?B?eXFyck5qbGlxQWt6NVJsenB3bWRlTHVzd2twQWhQRU5LcGYxNzk1bDV2U2dM?=
 =?utf-8?B?RXNzTmwxd00wTmptcEpDN2V4K3dYdVVwb0dORW85U0hwd0l1OUFiUkx0QkJ3?=
 =?utf-8?B?WWgwRUlPWmRUdGNSKzNvWWsxK0NqdWRRSFo1Y3JKMTZjdGl4WjlMV2UvYVRY?=
 =?utf-8?B?MVB5L1dHcUdDb0NQYzlwbERiN09ob2pvVjJqN3hISTF6L0VHSThESTEzaDFp?=
 =?utf-8?B?OGV2OFoyS2ZvRHpYNTZlVXUvM1R5RVZpM1RwMlJiMjBMbzFRZmhHZ2k2eHRC?=
 =?utf-8?B?SUswb1lNRndpaXpOaEFieGVxODZDamxOTWlySzFsUCtnM0F6d0diV21uSFBS?=
 =?utf-8?B?aVNJNTdMU25XWjgxWmhRRGhYcVMyR3RvWFVDQXdIaDVoV3F1NXhUeVJTUmRW?=
 =?utf-8?B?Mm5vbWkzVTBwdnoyUGg2TTN4N0xMZGR1SUdralRxUmk3b2FsbjdsWklCdnNq?=
 =?utf-8?B?Y29RbzF6bkY1aVh0bHpDdVFCMWdqUVZhOE5tRDRqSUZBSHNXeHdlakZvMmxu?=
 =?utf-8?B?amdPSjYzMDZLaEd6ZHQvY1R6L0RaVFZmc1FFSHhFNndhenlFVStyeWx3ZlZQ?=
 =?utf-8?B?NlhkVng3Q0JqMmgwSGRoR2VJUHI1eEJXQ2xUVWYvTHRuMHA0Q1JrY0tmMTVZ?=
 =?utf-8?B?Yk9BK0FoSTBMTmxrN3BZV3JIZWZvbEVpeS9Oalo5cnA1V2w3enIyM1BZTHFG?=
 =?utf-8?B?ZEZSa3ExNzNBc2gwWWNjc2xFcnZzMHFOdXlZZ2ZBVE9OSHdNVlo5TFc3REVa?=
 =?utf-8?B?MFVVL3hDQnZrcTVDOVJadlBYanRiVG1LdFlOT29GQWl2UmlLVG56dXUwaTQ1?=
 =?utf-8?B?dUZZN1J6K2tVcktSM1I3NEp6WkRKdFZjNTVTT3J6UWNTeTB3OFdDdmUxL3hX?=
 =?utf-8?B?cHl2bVVuVzFqcndQM1Y1RGUzMXZZenl2aFlqUzA4VlkrUW44L3BZVXlDR3FI?=
 =?utf-8?B?ZjVCeWtTejY3ejNaanVVRjgzSzZqZFRWNmg2Z08zU1ltK2lPSkpaY3h5T2pI?=
 =?utf-8?B?d0lKTEt2L21zVzZMb1NidGFxZlJ1VElMQjFVZDN4aWo3V0ZEWmtveE5uaVFB?=
 =?utf-8?B?Qm5HL3crNnhteVRHL21lc3dUN0VvMUt1YktwQ1FKOEVBRVdpdkR4byttb1RI?=
 =?utf-8?B?blJJeGp0RldzZi9KSlpxc0tQekNvYTErUnRKSi92VXFtdi9LamlQcVFDem02?=
 =?utf-8?B?bWRRNEg2T2hwcDlyMkxTYWF1VEdjZWFZT2FCaFl0Qk9rTjJSNEFyRlNqSWRY?=
 =?utf-8?B?c01JZnljcXdxRG5qa2FQRTg5R1UrZWRWcGd2aW9NRXh3ak14eWJpRDdnTFBI?=
 =?utf-8?B?Y3F1Z0FldzRHOVYzdnFyMVZIa2p1R1B1Tmk1SXk0bjlPdGVrQW1GaVF2Ty9x?=
 =?utf-8?B?MzgrUGlsVStGZm1oZkhxeXd6MFVxLy9TVU05ZytoR3RhemxFUG5zbVFmdFJR?=
 =?utf-8?B?Z3pvK0FoUE9CbVlQUERtaXJwOUF5a01FOWRvVDVFbDZhc0hVenZwQy9WZEVN?=
 =?utf-8?B?WXhFSVBKWitvWmJybkpNUjVEMzQxRkNjeGRDMkdkZ2dZb0JLdkUva2hRODM1?=
 =?utf-8?Q?4/fqrPQwU4UzSAz4y+Chk9sqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c8274b-231a-4207-1dd5-08dab2b488e3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 16:02:48.8039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAbkKwhdNg4QnPjJiBJ6ttcV4n/esamWgdrv2vJLnseud74oIy/3ys8PPxSAmQk8ELCsCiLFgjQi920CaVpiNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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
Cc: Alexander.Deucher@amd.com, Yifan1.Zhang@amd.com, ray.huang@amd.com,
 aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-10-20 um 05:15 schrieb Prike Liang:
> This dummy cache info will enable kfd base function support.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 55 +++++++++++++++++++++++++--
>   1 file changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index cd5f8b219bf9..960046e43b7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -795,6 +795,54 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>   	},
>   };
>   
> +static struct kfd_gpu_cache_info dummy_cache_info[] = {
> +	{
> +		/* TCP L1 Cache per CU */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 1,
> +	},
> +	{
> +		/* Scalar L1 Instruction Cache per SQC */
> +		.cache_size = 32,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_INST_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* Scalar L1 Data Cache per SQC */
> +		.cache_size = 16,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 2,
> +	},
> +	{
> +		/* GL1 Data Cache per SA */
> +		.cache_size = 128,
> +		.cache_level = 1,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 6,
> +	},
> +	{
> +		/* L2 Data Cache per GPU (Total Tex Cache) */
> +		.cache_size = 2048,
> +		.cache_level = 2,
> +		.flags = (CRAT_CACHE_FLAGS_ENABLED |
> +				CRAT_CACHE_FLAGS_DATA_CACHE |
> +				CRAT_CACHE_FLAGS_SIMD_CACHE),
> +		.num_cu_shared = 6,
> +	},
> +};
> +
>   static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
>   		struct crat_subtype_computeunit *cu)
>   {
> @@ -1514,8 +1562,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>   			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
>   			break;
>   		case IP_VERSION(10, 3, 3):
> -		case IP_VERSION(10, 3, 6): /* TODO: Double check these on production silicon */
> -		case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
>   			pcache_info = yellow_carp_cache_info;
>   			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
>   			break;
> @@ -1528,7 +1574,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>   				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
>   			break;
>   		default:
> -			return -EINVAL;
> +			pcache_info = dummy_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(dummy_cache_info);
> +			pr_warn("dummy cache info is used temporarily and real cache info need update later.\n");
> +			break;

Could we make this return an error if the amdgpu.exp_hw_support module 
parameter is not set?

Regards,
   Felix


>   		}
>   	}
>   
