Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DF606A32D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1clR9mf6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6286E10E522;
	Mon,  2 Nov 2026 04:44:00 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD3A10E522
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 04:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft9GW/flBUJKibo7ZJvGjTmcVs44F+vmoHBeLqJuam43+xHF89OCFMZcegEDMc6R3Fxkj0iy6sOtZaBqNWuQG008lswVclc9zclaHMKK5pwVHIXN9j741dMbXhtI/6FGWldeMy8rbZXJW+e1iVJlp0TQBHgL81y1e7fEuNlUDlWB9byOADnXeGNtNQDf13txBjRZK4MqlYs3G3JJMqfz2Ip35zNiS+40Nc+RZdt0fjiUDWzjniAA2p+o7Qcy3Z/ul3eYSINmBQO1P4NtgvaH9p94su29J64DqeQFYHJxKWcecupMGOgNfJXKRHaB8IU99JGNFPbGfIePhE8ambsbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhmwwct8kKSESTDGcJ65ocvrhBeyy3iyVt6AZHUYqKQ=;
 b=HfOwrbVSer3zRpf58OCRhVAInl/cXuJeetGYKjS34QoGrCbTWQjRNdxhMhAKCSkBmruEfjwu2/cPIZPTstjDgNBhpszrtLGkHSNeY2KtfckmHIuHWt6x7uE4aLsTgmN28XoxyIMr1G8fUYeaADVZlZIaQ/ZLtfXEExwxRCAukl6ITNhS70ndd/RJIVLVaHm3G/uepc4HIonbGBx3YqxWZOSypeEga4HZCCe4rJqBpeokfNR1tF2yeCxsOru4VQ+VedSjQBCcrP2r2DsD9aCECx+cWpCXTWw1iaG3sKjUhHV+jwfJ61qgi3SqQ727vYTEJdEjk45fpB3HroQfEmBhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhmwwct8kKSESTDGcJ65ocvrhBeyy3iyVt6AZHUYqKQ=;
 b=1clR9mf6Nn/3U1U8M40kbEvNDjrO/oLdfoBJKHkgwI2PLQCUVy5Ak9e/5+CgGTIMWiDIL4lmKHknyYnGkwPGNUZgXA+vmNczZHWRAVBRuAwaT1j2r8Kl9f94WsrY73Sob67vF+lZeTaIukCyDAvDVGv/1y9mfwyTTk8/yvS0Vcw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 04:43:51 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 04:43:51 +0000
Message-ID: <b50409f3-dbc1-4b5c-b610-eb904c23d8c3@amd.com>
Date: Mon, 2 Nov 2026 10:13:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdgpu: Bump REQ_GPU_INIT_DATA support to V3
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 amd-gfx@lists.freedesktop.org, Zhigang.Luo@amd.com, Gavin.Wan@amd.com
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
 <20261027125613.6549-8-victor.skvortsov@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261027125613.6549-8-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd8d0e9-c282-4dbd-5ceb-08df389be42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7GLNMeiwHEM3z5pTwLtKAZjYKsruaqQxLL6bK9flckD60Dp9TODnuHut2ElaVWFZpf8+YMMT5697d/BNMre97FUMdP5835l7jntNeLjSiPk1jrIM8Tm5oYWYpxbR9DWDzmPD90YdfJjxG9hzCQ4LC32PZ8qvauoiEWjVMmcSMA+voLj2sQ+9P1v2YAEbHe9cj6q/iaXa2WzMWMYSXBifYHuDJpCkjdSmFr2qtxTsw3hzK1arDO6bSJjTnQx4jnMXos5zfTdw1wzMpvIWRmmylnL8jCcaSg4F4ADguYAP9Rmog060o3efY79GtKH37CfTz1XZSYLuLaJRXdnzIAU7PoJ9UNXNUOHqTH0nUKFOjCUnB+bV+hXT5C3L4FBxtvOJDWehSU7XMFIdHsodzrNqIhHo+UO2yNdvJDCYYnDSTbuaBZpCoHTw/9HVzfJ3ly7eKY+4TOxbeY5heiXzYc7DtgXN8elCQkfgg3VfyUUfNDxsj2tJKn938tJ7MqF6dcPN+IsFD55EPVqWeK3iksaTko31n0wTbMkPmatpHg6BU6fEQQKlmsQKNQR6LAs3bQwZHdI9g75HTMuiiCVY5yazt7MFvdXHam3eYvmffKF/DpjJnZApioeb9MleFmdXLeYww67uKNhTSJ/sT1Or6kp7otoxW6c+zqM42l5+cz1U3cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25QT0gzZFd5TzFkU0VDUVpTOC9uQ0dnbURwQmVnNkRXdDlLaUNaRTd1eFdq?=
 =?utf-8?B?YnBudkgvNmwyd1V1akU5RHN1d2dodUFXU3JEYnlBdTNQb1dYWDRpVkdnWmk3?=
 =?utf-8?B?dEswUDJRR2tsQUMxOVRGdFM5OWJLYUhMS1MyMWx3QXAxR3ZQMkZ6MnlnbWpJ?=
 =?utf-8?B?REtqbFN3eDRIYzdlRnYvcjM0SmdrMnF2TlM4cGsvRVk2UU9xNk10S2h0NWpV?=
 =?utf-8?B?bGV1VmNhZWRUWlRsUXdUVW5TMGlaTEFQMEQ2K3RaYzJmYmh2MHB4ZjRzbjFo?=
 =?utf-8?B?TWJmVnNEd3RBbVV3bkpIemFRUCtHdGR0aCswbUF6VzNadENsZ1ZIUlVkU1g0?=
 =?utf-8?B?RXFDNmlSSmVmNnovNHhwMU80bERwUFZ6NFRrdUlUTkxvNFFmdjVIR1Yyd25G?=
 =?utf-8?B?VjlZRmNBRWU1WnEzcEhyczV3Q1FZSS9GeDczTlVjLzdhMEVUeHBuckF2Z2Nk?=
 =?utf-8?B?bUJjaC9jTUk1bWovNklIczBHRGxRUXBOOU9hR25MV0p0dXhNdnUwU1V5N3NR?=
 =?utf-8?B?dFJrbFlwSGdBcWxMRndxaGxydnRMcEN5aFlLRVViSUVnRmV1djZ0OHdWQTN3?=
 =?utf-8?B?V2pkaHRaMytvWU5Md2llTDBCdkRJajVCTEh2TVI5eWF0SENwbENnV0kyb1RD?=
 =?utf-8?B?TFJvdlhLcjI3SWxTZ0hYUWNsVlU5Vlk5ZDFTM200Z1RqcktlMzRKd1c1dmFI?=
 =?utf-8?B?cU5pUmdNeC9rUGNmOGdLbG9jdkZHaVFRclFDYUdxdWNGSzV4OFpGYVF5YVI4?=
 =?utf-8?B?V2pWd3FVS1E5bEtrQU1EanVSbkNhMTlwZXB1VDE1K2NsT3o2MkRwcmN5cHRa?=
 =?utf-8?B?cjlmdXdiUVhwVmpsaWlmenRnZEJnUENVbjhsd1VQVzkxSy9FWHpsMXhlMTc3?=
 =?utf-8?B?V1FENEJFbkE4ckh2QThYVnBzVkpPSVM4c1JUNnZpTG0zVmkxREZwTm9OVHEw?=
 =?utf-8?B?bllWVjJxNk5hVmh5d1ovZ3drN3RrRDRaTFFmeGlQR29PbGhMMEFjSzEvUXhJ?=
 =?utf-8?B?N2p5TmphV0czNHRKTml5TzJaQ2lTdEZxZmV0ZUQwZWhRUWNxdDM2TzNvenMz?=
 =?utf-8?B?UnhVM2dqMmtCZ3gyUEp3TzZTUHZFVURpZFMwTWVYa01wQm4xUWswR2lSZTht?=
 =?utf-8?B?YlR2MW8vN21FMVZjK1c0N3kxMkhFRU1sbm5PV3hrdXQ1M1RtbGsvVlAxZkUr?=
 =?utf-8?B?bnZxSmZQcXRrMG1qZGtVTTJGeUlwR3hPYmwzYkZDYlFqUkVzblpOL1psdVdU?=
 =?utf-8?B?SXpQcmNkendrWkF6Zm5sKytoM2J3TCs5ZVhzUTBNVEhnU3puMzh2THNGNVdW?=
 =?utf-8?B?OU9WOSttZitqTlRzUFB0TzJlS0Q3YUlxQk5ZMGx6OGFxangrK2xBRDdyc3NL?=
 =?utf-8?B?NVZJSVc0ek55SmV1Wk43K1ZNbGRiTGxxVlNIOVZYekgwY3RZM21KV3RETXc2?=
 =?utf-8?B?emYwWkVrZk9yNW9hRmZvUjVzMEs3S3dTbHlFRkw0ek9LN3A3T0dyMHp0RnZz?=
 =?utf-8?B?MFBybFF5SGlwVmNyajB1L2ZhMnZqN0NsN2FIYkNCUjdOYnQzbm9CWGRRNEhq?=
 =?utf-8?B?NUdGSGlCNlo3RG5uQ3NpMG5sNlA2NmJrTWJ6SElDSXl4aXNzdnhiU2I2T1ds?=
 =?utf-8?B?ekVPUVNNYUlTek5rQmtxeTgyL21ubCtzTnJpeWhSQldQNmR2OUkycEd6TjZP?=
 =?utf-8?B?THhxeHIrVlVUVWR2K3ZGM1dNN0dybGFwTElDZFBFZHJHRE93RFdaaWZXaHVL?=
 =?utf-8?B?QkppUDE0dEhCTjlXakcxRW5OS253bWhWbXNmcTFmYTExdGowZFRHZ3lTYXB6?=
 =?utf-8?B?QldwdStaZ1hQcWY5TmtNTlNEeHBDTTVHS2ErSkR5N3VVa2VTREkrbEhJdW0y?=
 =?utf-8?B?RGRwblF4Q001VURQbk5MYXgvSG1tRzFyQzM1YmFqVFZtQ3cwYlRGUVNqa1Uw?=
 =?utf-8?B?YTZYWUhvSmJlWDI3RzdxVi80RUpvOHR0UGQ2TGJ6WHdsdHBwVnhFc1JYYXNV?=
 =?utf-8?B?eHhLckNMVDhZTWQyNVVEelpFZEo3V1BSZThCdFp0elFvTTBHUVVJKzNTcVhO?=
 =?utf-8?B?ODhkcElCS1dUZUxlZGJvRkpOYXlsYml3UkxtMkh5L0ZrOVNXa1ZiTGNyNXBU?=
 =?utf-8?B?NGp0QXpnaksxOWZMbncrNndRZmZPNE9haXhUQVhDckxpWklpM0FKSzI3dDNL?=
 =?utf-8?B?N0pydE1zc3hPRHdTMzcrc3F3c3R1Z09YNmwrVENDK0VHcWd0RXlHNnJDT0Zs?=
 =?utf-8?B?Nml5NUpuU1kvOXpyVFYrTkwvOXh5aWY4VzNBNDhLeVkwZ3V2N2ltTXd3M05x?=
 =?utf-8?Q?a/kSEFXB35aPIiXg/g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd8d0e9-c282-4dbd-5ceb-08df389be42f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 04:43:51.0539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEt69IG26sx4CQEKaz68xnMfZXXu5N14gBNFDwNth15eHYzDUdJofS2twULJIuiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27-Oct-26 6:26 PM, Victor Skvortsov wrote:
> Guest REQ_GPU_INIT_DATA must report the highest CRIT_REGION version
> support. Indicate V3 is now supported.
> 
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 5ae18c2d71d2..f637a7032de6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -343,7 +343,7 @@ static int xgpu_nv_release_full_gpu_access(struct amdgpu_device *adev,
>   static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
>   {
>   	return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_INIT_DATA,
> -			0, GPU_CRIT_REGION_V2, 0);
> +			0, GPU_CRIT_REGION_V3, 0);
>   }
>   
>   static int xgpu_nv_request_init_xchg_region(struct amdgpu_device *adev)

