Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32969F33A84
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 15:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F0610EC18;
	Thu,  5 Mar 2026 15:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QIjD0xec";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1AAE10EC18
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 15:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbIqTsc8bE3o+ZlE/g7ve31EEXTVzRodha9pw38iCJpYNUfg5HSUTeL8zveu5u6RGdmN4bsF6Mfp3F65TKeiFCl8+xje19PkOw5nQKOXbzyhImaXtBpMoHptvXgo/jemCErBWsNXKeOXCXn6s4E3JlHywKgMczEYWzlbHbiJAw9HtYxyQyYPFdQJ34LNw8UOphipEkOMs06t9gDan0DZtJRn3PgwbhxW9Pq4B2mh20QSarCKQmt++Fv2ep3LdTnkfAUVnuqWmwrsfVvJM1iIFPOZp5xAQEuUbMETDuOP4ndSRHp56RB1YlqyMjkpFlQzXHyh6KdBbATIu22Y1K7Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtBGahtBdCwaKom9kXQc4ojCN96/Ss9GCIn9Z5Oh9+E=;
 b=pbcWHhf8RPlCqViiQIVYA2aYPu0QKnjeO8ha2PZBZAh7UxMpb5J06USpoX/Y24n3hLEk/+QFgDdZb9lkde7gfAL1ZxMXCfP4sz7j2rIoe6yPienxVJX4o3NHcOHS//ZG4CkyQXwNS16WRw8IsXYyFP3zmJy5tTQa2g0nn3gzufvnyhtXz+MEM4Lzk8k2HnEL2463i78feojP2s3g9MBXGxodgbR56eQxkvfSIrV8QgjDkOtu5p1fTIDnMCO03RKjTzdSVFiX+Hcrdw+NUEL4IQbtsiYR0x0v920K+Ef2SkTYghrCuhoxsaqmCKvdETwrwd73fMmXTndEWPC6c2QpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtBGahtBdCwaKom9kXQc4ojCN96/Ss9GCIn9Z5Oh9+E=;
 b=QIjD0xec8dDn+DbKYFABo3l+83sCLp2QdHKPfrPj6fos2futZp/Svj+HMqjRfv9KAVqiAfoF9mqScldmUAhiTLAFnhMcmbj9yPtvHA+9+/T2dHjE66ZCSeZkFO1JjXIntPyUCbjwOq3APNXtCUiHg/xEDi1cPh3QOiTLbuOH/QY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:07:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 15:07:37 +0000
Message-ID: <42e624f7-5190-49b4-95c4-dc22a6ba1ab8@amd.com>
Date: Thu, 5 Mar 2026 20:37:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu/mmhub2.0: add bounds checking for cid
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260304222732.2403409-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 1136b4bd-ba66-450e-8823-08de7ac8f007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: vzgt/MjSCNm345e2pqeRTt8sXr7dusutp0cJuMzXFK5McNsmUmhJk+ONRSrlSzOB61GayGzkQ7dU4XyYjVrTSVjOcdY9trd8q8G4BTuO+VJYw5l2EZ8rbHNcLuuh6PscXSUXGrCw1W4mt4lTDyobFRCsfkBSAwMjg8cLbsvqx6iEPI6NrmY/9SnQLfuiTQ/6j/UazYgVqFleoMsvUWJWpu7O0bZzvdKtq6Pf+gsJ+uvlrLK/6L3nefY32M6xyqfmP7ux1nsmLzq3EW8Guv389QQpUNu9HY6IbQyaqfiBbrau+YZ6iy+LLQdtP99hS5IxcpSFJqxw5KmwcIKVK2BHguK9tmg3iOR+bN8t+CYhAROZPXbeNS5nqj04Qou7EhUPUY8dW38TC/H5JVdtbkLcO9SMduOTD6v6EHPUHzvIFZN4cIew/InJfIL5apyaJziasishOF0t3o6okcpo7pHE1y6VVIYTOLnGlsbqduG65ZWwp6nhax+RZ5oJ7i78V4ufWnH9FoLHBTSTSqAbdV06SkA3H7xn/Ju+hG5vImzi6ADykcdIP9X606hJY4Yu5zOj/mSDbh2HoopzikefzfRcL8LknKEcd3nsN4M21Ooa7d/yK7d8KE4SmGJNvSm0LVGLEyBwvmLUtGmxYIjUL4X2lgrApOC5aliHGgULibND6uMTezrl9beb3022dQu3xgeg1PMgEuP7XIEqYFEjVlZDPtgq/hqWtrMwA6Oi0VxwwgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHg1SDNaT1djUFZDZWl4R3hybGpqT25DSkR4cE5JTHFBWVczdGM3Sm9zSy9F?=
 =?utf-8?B?M1d3d0gzV2pjUXZXRG5wTHV4d1pQRkx6M1NTSkhWUXpFRG5jL0RoK2xLSDBv?=
 =?utf-8?B?R0s3UTBRRUU0aEJIcVZYNEJRRWpzT213VjVzcDRoQVFleThET3puZzJLMHlR?=
 =?utf-8?B?c2RZMmlVdHJPUW51dERPQ3hOcmZXREd5dlVCbDAyV05mUktpNjVZTTBDMG9Q?=
 =?utf-8?B?amZPRXFRMHJnblZ6ZmgxY1BXMEpJbE5IS1RvU2w5RG05SmE0SEYvVG55Tk9B?=
 =?utf-8?B?WXlBVGEyTDR1dlM3N29MMmpkdFVlalZnS3YwNXp5WDh0LzRnSlRvUFdxRVh3?=
 =?utf-8?B?TkpqaFNuRktsUlRHM1BuZUt0MGF0QSs4S1Aya01oMDlENkFtSDN2ZjlPL2Rs?=
 =?utf-8?B?UGhnanBNM0NDS2JBQjBhcXlzQUlwelNEU2MweTlpNDVnam05c0Njd3lqcktL?=
 =?utf-8?B?MVI4OERpMU9LNnBLb08xZFEweTRYT2FPMi9xQmdrUGg4SndjT1AzdUM5Y3Fu?=
 =?utf-8?B?NktCZ05kZENpeVZ4VG1BL0tkeTFmWnhGMmRTbzBHWDVGMS9jWmMybVRJUC8z?=
 =?utf-8?B?RVZzdXdQa1hvZEVDa3haeUJ2andVRWFvaUxjUW9HeU44ZEUrWkR6Qys5OHBX?=
 =?utf-8?B?NWI3cTB6QWxIdGErQVIxRXFWSFNQYjBvRmUzOG9zdW5BNVFoaGhaOG9oQlVk?=
 =?utf-8?B?MVMzampsU1dRWVA2L2VuS2FRZllxMGNWWWJHR2U0WWJaRFEya01vNXBCbkFW?=
 =?utf-8?B?TTJQb3I5WnpKNjFZMGxGYkx2NUJSSUJ1c2psSVIzQ0dWcVA5RGVwVGg3cnRE?=
 =?utf-8?B?c3FIUU4rRVlPbjE3TDVJZEdHU3lZckd0bWtNUUFrWm1XamZEVDZPeDNhaHRk?=
 =?utf-8?B?eTdOVGZDQU03SWpVNE85NmtveXI2UHFPd3ArdngrSm5BSkw5RE1iblZwaWxP?=
 =?utf-8?B?bkdnaHF4OXNwOU44Sno1T0F0bnJiWnhHb2t2OXhlemRzUE40Yi8xME5OZ0JF?=
 =?utf-8?B?eGM2QXVySGpreDl4MUJMa1VyZUJYRUovaTk5OFdHWXpqZW50a0FiZ0RSMzlJ?=
 =?utf-8?B?ZVBrb2V6UzNtVjJvZkhaTEJUdDVSZHlXczRpMGdLWENpUEFENFdsdkJ1cU5O?=
 =?utf-8?B?ZmozYmJBaDRMT3ZEQ3YyMzdwNys3UCtLVEt3MlNoK0JNOVdmMnpvRW9nd2FY?=
 =?utf-8?B?alBKK3l2K1pHUlFlc21rSWtKL3RyOWlBeEhPalZXN3Uza0o2RUhNbHJDUU9q?=
 =?utf-8?B?cTJjcUh1YWhhWGFmQmRSUXlVbVdnYnQrdEJBNHBMeTJtN2l6OXRrNWJ4STZy?=
 =?utf-8?B?YUZ0WFpaallyZHk2bEZZUGlKeXZERmVTMXQ4NlFKNVFOU0RLdng3T0F5TG9j?=
 =?utf-8?B?MjZuVDRNcnFHUFNUK3VxK3V2TEN0RVRpcEsvK3g5SEdoNUp6ck1NakFmNzRH?=
 =?utf-8?B?dkpaa0tjQnRGWml4Mm45ZzVRT0tSb2hpWnlnUytTR0YxYlhJdFVwLy8yYmsw?=
 =?utf-8?B?SHM4V1dJakNQYi80dnNHRXdtMFRQQnJXNGVRU2xMcjdORzNsVE1OeFREbGlW?=
 =?utf-8?B?Z3B6V0Q5T05MNnJJYi9UZDdYVjU4VUtSWG80NFR5c05uTUs1QkxXZ0JxL1c4?=
 =?utf-8?B?MFYrUW15UlRSZjNHSlorVlVtdUNMeXliSFFaV0x1SFJodUZ6WHFSeHArQk0r?=
 =?utf-8?B?djdWdmxNc3lNa25ERnltTzVHS1NHTmRiaXJUSEhERnBNQUNxQXpaZmpCQUJI?=
 =?utf-8?B?cmlXalIyZjZ3LzliR0J3elNRNHY3elNQbXpoNEw1ekxWWjVDTWJhaWdNSVNq?=
 =?utf-8?B?c3Jwd3RWcUl6dWJscXlYT0Via3luWHVjYVJUbThsZmpmNndTbU1SYTllcHov?=
 =?utf-8?B?S0NoaDF2YjZxeXAxS25tNC9WRnJDeW9BQ0EyRW5ib21uaTF3blQyQkJXWTd5?=
 =?utf-8?B?OC9yZTJJSnhtSFJvWGg1cDd3SzNGN1REQSt4ZklRUXNrRVNKZ0lNMGc2N3VJ?=
 =?utf-8?B?VFcvS1FXd0JSa0VTU3J0c01CUDFBZzVHR21yZTBTM3lMV3ZXNEtqV1FSZXJt?=
 =?utf-8?B?WTkzREdteThKczR2TklTc1hPL05Gbk1Rekp1NG5GVlFFSk1FVGJhbVExam0r?=
 =?utf-8?B?akRjdWlaRUtPY1p0VFpnNWEvY3BScFJHYjcydmhFbGk2Y3FRMXA0VCtheS9I?=
 =?utf-8?B?cnB4d2xxMVB4WGFjMGJLYUZ4RGQ3Mm9ub3ZQMHY3bEdMUWxkVTBGWFRSWjYw?=
 =?utf-8?B?U0VLbllxQllWeXNnK0p5VjZUNEVLNk16YzhJaSthcU9xazg2Z0VtN2tQRTRl?=
 =?utf-8?Q?2CXJGL51Bm8RHFHT9h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1136b4bd-ba66-450e-8823-08de7ac8f007
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:07:37.5127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7S4OgaspbXr07mR7QJkxXp5ZFGiKP7sLIc2TkdNhpVZr1eAYAqBGGgLGGU70zbOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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



On 05-Mar-26 3:57 AM, Alex Deucher wrote:
> The value should never exceed the array size as those
> are the only values the hardware is expected to return,
> but add checks anyway.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index a0cc8e218ca1e..534cb4c544dc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -154,14 +154,17 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>   	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
>   	case IP_VERSION(2, 0, 0):
>   	case IP_VERSION(2, 0, 2):
> -		mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
> +		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_navi1x) ?

Does this introduce speculation and requirement to use array_index_nospec?

Thanks,
Lijo

> +			mmhub_client_ids_navi1x[cid][rw] : NULL;
>   		break;
>   	case IP_VERSION(2, 1, 0):
>   	case IP_VERSION(2, 1, 1):
> -		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
> +		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_sienna_cichlid) ?
> +			mmhub_client_ids_sienna_cichlid[cid][rw] : NULL;
>   		break;
>   	case IP_VERSION(2, 1, 2):
> -		mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
> +		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_beige_goby) ?
> +			mmhub_client_ids_beige_goby[cid][rw] : NULL;
>   		break;
>   	default:
>   		mmhub_cid = NULL;

