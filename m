Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D97BC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E367B10EC20;
	Fri, 11 Apr 2025 16:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vE1a7nXI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A4C10EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6REZLmw68soa8MpislIQ0OPt0K5K09VAQYBZOWXATsI/N2QOTWCBcRj9+8UjlITVEczQYxMSrhNNqqNuX62lolqt6bN7wshEHa6FtV1oXvxahCWbN53FrKQNc3J3qS92Eg5k0R/6SIKXpQNVKbWkQz9vSCWqzexLiurnjwwr291YdZ7RWjr1Ci79aarL0wuF/HdYaWKvht9t2IwE/CYOGjM59V9zrUOPv2YJbyS4wGx7Cd1vwiFDRAY/TddfCXggS1rty4h5MAgoZfaltYDxfdrdVYZsRWuqasfmv86dehFD0yQ3f5Ix+kWJSrrZwxKNMPN0fLf/30iBNsTEDdARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNaQe5X2t7uKlLptEEqYBmo47UkaJ0Fty10rgdAcYp4=;
 b=fNgZvPFp5xdw64fHPfSuhKhAdnyeK2csetGwV3fUXt5TycKCKta+hmtEBYWA14pp6C76d9vtv3A9fKrLhe3KFwxMF+RUxqeN+JOivsIwMPu6wG6HmslE/VP9vbikw9Zz5AYQQbRIi3xaFxAH/7D3tzdu3oH6MHnRJUDMic3x0XThQQxARgRbJJBPrCzu5TI4iOwd9lx57EP4paK/YFHJVNo2IRMKCPy5WdbYQXj13sqPP8MTfe7WkR0bWwnNEj3jXKjeBnqcT61ZD28SqAJ143fEPWLhPpAom/JQ0B1Qa8C4OrKZDZ1TLp63Y1kIURn8mRzFKdpYkxJBTFEoIZNupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNaQe5X2t7uKlLptEEqYBmo47UkaJ0Fty10rgdAcYp4=;
 b=vE1a7nXIwE0vT2yho5Um7I9AnU1yHdlmvaKqHx7KyXKdjSmyDdd/CpEixhIJkXeIX2SgiXoLw3SS+aV7CQT07mtTmKSV/HYOJvqmTstRkSqT1ls2tWfpGh8E4CWhEa39OtVpIqeDnIKEo3iuoetzWz1goG0185ZQoWAhmyvraDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 16:33:37 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:33:37 +0000
Message-ID: <a556e413-0313-44b6-9952-b736c7211978@amd.com>
Date: Fri, 11 Apr 2025 22:03:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix no_user_submission check for SDMA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411125047.2660769-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411125047.2660769-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a92ddb-9048-4495-e7be-08dd79169c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YktPdGZCUXRCU0JtV25WZzVENysrREYvSDQvUGkyR0pqSURhNzJGSjRreGdB?=
 =?utf-8?B?eFVQMlMyRDloeVlVOVQ2MUdQQVM1bkZINGhFRmJwWFBNbTdHQjk4eEVjczM2?=
 =?utf-8?B?eWFNNnV3MUhMTFVvMDZJWElYR29zZmg4eVBvTWcyRngxRUpaamwrRHVhNC9K?=
 =?utf-8?B?bzB6dlUrYitoWkVsNEhoVFVFcllvL3UzcnRCNHpUMjRqSnNPSTNTZHozS2FL?=
 =?utf-8?B?akcvUW1vT0NIRktyeGNoNWFEMExKY21wNitvbktKLy9TdkIvd0IzVm5DcFJn?=
 =?utf-8?B?bnpXTlFSVk0zaTc1cDJ2REVQWVo5Wms2cHYxaVgvRW1WQkwyNHFKTWdVV1ht?=
 =?utf-8?B?V3hOQzlsUWhrbzFnYkxNTHFweE1Ua1M5Ym9XMjArbmhsd1ZYenZtbnBZS1Bk?=
 =?utf-8?B?M2UvdXh2eWdDMDhUTWNsNUtVUXl4eWRuTi9HeHdyUXpPMFQ3Y2JyYjlHcDNK?=
 =?utf-8?B?THR1aEo3UVVoRStidCs0Smo2OXVnRUhjSG1jWWlvSTRFMEROVm81Sm51TlVM?=
 =?utf-8?B?U3NxT2R3L2FmNFBLdGhuZDFHUHI5ZEtBWFZ2SzVBVy9PV1hRdkZidFovUlhw?=
 =?utf-8?B?RW9lL0xyTUFPT3Z5MU1vQ1Evekt1c083VXQ4ZGsyajRRSXZYeUpJRTRkSjl6?=
 =?utf-8?B?Nm9zSm44dGV6T0xabVRWN2NCZVh4MTAyNHRsei9WR0tsZ2ttL1JFWGVGRitK?=
 =?utf-8?B?SHJSTUwvZUV1UVByMzh4ZHMreVprWGRBY0IvVjR1V3pCSWdQKzFhV3hqOWda?=
 =?utf-8?B?dTR2YTk2MEVHWUlkVTZEckJCOTA4YWtZUTZ3a09VY2NzcjQ0SHptVUhxb1l0?=
 =?utf-8?B?TWZYeTlhUG5OSWdGMDNqU3U5ZTZVYkp3OHMvMWhxMU9GOXZvUHlTVytRaGp1?=
 =?utf-8?B?dHdjdjZISVNWRFZEMi8wVTRxN1pncnlVRWpHT052NFpGbWc2Y0JmanMvTksv?=
 =?utf-8?B?bW1BWVNOZ0NMY1E2TDJGZHNjTkN3aVBTb25vOTRSai9MdHRLZHI2RUxDZjRj?=
 =?utf-8?B?TWY4UGd4cmFORU1hcXM4ZWVnSkUwbkljMEo5OVVZRjV4TzI1V3ZPaVEyemtQ?=
 =?utf-8?B?T3lEblpTYVUxVzJkT1hyaGs5S2RuWG9YcXNBbnQ0QkcrdjE0bC9VUnM2ZTdL?=
 =?utf-8?B?blJPQzlWOS94U1hMM3A2aVRPUTJjdnd3U0M1bDh2MEE2Nmg4MWxMUVVUOHUw?=
 =?utf-8?B?VUNLNTJFWlVLMTl1M29lYWdsckVqT1UzQlRFOEpGNkZQcWNESDVMcXZqM0tW?=
 =?utf-8?B?MzRvQ3QxeE5SMFR4Qys3bG9pN3Y0WGRBRHFDWlBvVG01bjFmYzhpbWF0SWVW?=
 =?utf-8?B?bS94cEZneHlVUHVLNzR1Y1B4QTlpWDQydGJxQndNN1dVVVhqWGFWNjU4b21s?=
 =?utf-8?B?VGxMSWh4Vm5Gd01vYTlxWFk0MEE2Z2tzTXpVN1JDTXp6WVdpeVA4bFhNSTdv?=
 =?utf-8?B?Vy9yc0lseW12SnFWYzFtU085Qkc4aFZxanpLQTFwSjRnQTdFNGwxWTRFSHRW?=
 =?utf-8?B?QndmK1ppZ0c5Z240TDR4dXpHdWxZR2ZMMWNqSGpMN3F4b0QzaVladG1xVk03?=
 =?utf-8?B?UmNyMjIvNlZIU3p4eVpicGZOTFMxOGNsZzZzbmFpaGtHbzc1dEFaY1JRUzU1?=
 =?utf-8?B?NGErZ25SRVFoYmNLcCtBYlFocVVwWWE3blZvL1BmZERVZHhmV3dTb0hXYVpP?=
 =?utf-8?B?bTRlcE9CUjIxMnA5eE1UY0ZFNkpua3lXaXEvTXEwZDU1dHZqdVZFNTJ0RWg3?=
 =?utf-8?B?S3plMC9oaXN3aHR4TVpwMWlaQmRVdEZHdlFtVEtkWW5LVDhtbjltTUZ6WGZs?=
 =?utf-8?B?QVpTb3Z4VFFMMGQrVUFxVm5qbnpmUFhzSi9HYTVkSjZKU1oxcFlJYnQ4SGZJ?=
 =?utf-8?B?aG4yK2NlS3Zrb0c3VjJQNmM0VmtXRzl5Y1o5am5haXk4Z203aS9LUkJmbGtU?=
 =?utf-8?Q?CN3DQqbA/Cw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JQK3JiNlVNdFVLUVlQV0dDQnNVbElsTHNuenNXdW5FMFU5S0ViUWxJcHZa?=
 =?utf-8?B?OXpJM1h3RU5LNkI4Q3pvdEMxclJ2N1ZibU5ISDJka2RZU1dKVFZMUExOOEpM?=
 =?utf-8?B?MTNVVVV2L28wQWVpNGEyMHFkbC9OcGhDQ3crenJvSllNeDJwSFRMNVNReFFF?=
 =?utf-8?B?Q2EyY2F6UVVMZlRMakhzK1pmN2d0bmZpOVU5SFFkWVZEdndTelN5Ynh0UDNP?=
 =?utf-8?B?ZU9MM1J6Qkc0WTJmMU9zSjgvQWdybXF6LzJ5NDdYV1dQUU9VWE9ydWVKQ2xV?=
 =?utf-8?B?cnlQK2puQzdZWEVCYTdCOWxuL01Ia0Q3ZEJQd2dGcHh2VlpqWFNuZ2krck95?=
 =?utf-8?B?N3diZ1JUTyt3WWhHekQralJtWFlQMDhPMVZHNzF1cnpJQTY0V3RzYXhqTTIv?=
 =?utf-8?B?RzI5cU9LOTF0Qktxam1RUnUrSlJVS2lkWHRTb21qdlRwZ2VRMTkyT1JPa290?=
 =?utf-8?B?ZnpheWZ1OVlqNldlaXpKL2JBbHhOamFKVlpsSTdKdmpHMk45Q1BqRXpSUDR1?=
 =?utf-8?B?NHplRi9DUy9DaXZVbFpaV1htaVpJQi9EUEZvMFUzdEM2L2ZMYlpad0s1cS9r?=
 =?utf-8?B?S1N0c3FYMVlXcVA2N1FVZUVQZSsrTHhpbTZzR3NLV3dsSmN3aXlnUHpVZHpV?=
 =?utf-8?B?OXdQZUVyZEpvQktCVGRvbG1MVGVrN1dGQTVxSkJBeVFSa1ovcHo5UWVvSU85?=
 =?utf-8?B?QkxPMTlVdmFLRHdIbmJHM3hoUnF2VjFPdG5veHJKcTdLeFRZbGV2dDNLTFB2?=
 =?utf-8?B?dUcrMGIxeDdLd05RWVdCZTJMbk1OVlVzM3BlSXc2N1V0MUhlRzRhVFA3UWg2?=
 =?utf-8?B?SmlqdTcxRzlETlJKU3ZEUkRlbjE2MlNvcDNLalM5ZzhMUnVoaTdXcnUvd2lT?=
 =?utf-8?B?S0xCTXhZNU8vSzIvNzhQRmduNVB3TEZTSEdMd1NTNHhxenY3WksxVUJYZUo4?=
 =?utf-8?B?SEVHa0szSXhPT0VkUUdNVkQ3SDdoWmNsQXNxUHVYY254Q0VGdm5JTHdYY3BL?=
 =?utf-8?B?dXBQU0V2bE9WNk54UEM0YzltVEFwNFFDTHdrZGduNi84U21neVhrUUFrcXh0?=
 =?utf-8?B?N21FSU80NjF0aExTRjJHb3JKTm5iMGsrc2dDaDAyRHZpZEVYcjdVYVB0T1Mv?=
 =?utf-8?B?c0JuZ2dRU0VNN0JjWTJhWVUvT2FRSHRXSjJmbDJXTFRrYzZnQ3NPZDAvMHdF?=
 =?utf-8?B?c0RmZGtTYXVuNTlIeGFWTSs5ZGRwZTRBV3c3SEJlemRFeTVXSnpFUTlCQjdT?=
 =?utf-8?B?L0g2dmVVdlZKbjd1NEpxMG9oaXRWcEpVL1poYVVsVFRicmtkZUp6dS9ENExB?=
 =?utf-8?B?bHFFbEFVNDJhdUQ3VS9yOTEzNE5TcWhCY3M0c0xrcnpudkpVL3JNNzI2ZHJX?=
 =?utf-8?B?LzVDcG8xWnBCVVZIOTVKei9xSHpKTHNvOU5oVjQ0bTVWb1RLNHR1SzJkQ0dr?=
 =?utf-8?B?bHQwU1luVnZyV2h1ZXdLdkRiQkFBSnNUYkgrTjBRUFRCSjFDcWw0dnIwcWpT?=
 =?utf-8?B?Tk5RRTRvcU54YThyZFdDTTEzTkJHMTRBVk5pdFhEWVkrNVB1OTJOdUdtdGZt?=
 =?utf-8?B?b0lBZUsyNVNIZnZ6WGRMZWNjZWhaaDNHSlZJamttY0I0Z2lMRGYyaFpaeWtj?=
 =?utf-8?B?YWVHaEh1ekZjQkwyemNWTi9lL0xlU3VtdGpMZE84NXhvT3dGM2VVNkxKMmhl?=
 =?utf-8?B?T0JZdjBFNGJsMUV0eHdwSVB3OGd5RkdEUHo3d215VXNoUW0rRWUxMElkRXN6?=
 =?utf-8?B?YjhoRUp2UG5pT2tUb3FXM3VWRXJiYnB2SEgvUVUvSzVrT25yajIrcUpOTU5Q?=
 =?utf-8?B?c3RVck1jdlBMVEh0MUxhU2tiYUpMcG45MzJhYU82MU5GNDZ0dGowZUZBUTRU?=
 =?utf-8?B?djNiU0xpN0FwblFWVDlqVG1BMG1qamxOdkJjTHNjNkIwME5MRnJOc2lGalQr?=
 =?utf-8?B?N3RVWnVTbmRLZmR3bHREdTRVRE9NTVM4QnE3N01ROG1LOHFvTTFQWkdqUjQy?=
 =?utf-8?B?ekZlTU1ZYkRLUWRrNDIyNlBsQzg1MmYvQ3A0cnpUNVVKdjVQaWlUNFBtM0cx?=
 =?utf-8?B?TnpNY3cxSzVZeURlS1l1SkdZc21KSWpBS1hsUHdYWHJ6QTZjYnhwenN5UHhW?=
 =?utf-8?Q?05hyVNy6EUTw5YDdEmu5xiGrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a92ddb-9048-4495-e7be-08dd79169c28
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:33:37.5415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AM76LuFxIVUe1p+rYdu7cSdlJtHOETDb3LSY2xPFTm++6Z1dt3zwdyWUrZhkNH0YOr3BpICOictzpBA7jBHCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 6:20 PM, Alex Deucher wrote:
> Copy paste typo.  Use the flag from the sdma structure.
>
> Fixes: 4310acd4464b ("drm/amdgpu: add ring flag for no user submissions")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0ba3ef1e4a068..6a42dea775b10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		type = AMD_IP_BLOCK_TYPE_SDMA;
>   		for (i = 0; i < adev->sdma.num_instances; i++)
>   			if (adev->sdma.instance[i].ring.sched.ready &&
> -			    !adev->gfx.gfx_ring[i].no_user_submission)
> +			    !adev->sdma.instance[i].ring.no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
