Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA05606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VE2NAn0l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE143112352;
	Thu, 29 Oct 2026 14:35:27 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011019.outbound.protection.outlook.com
 [40.93.194.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C06112352
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQc+KAwOi0W1VMx8Hm0wr15SGJPPegmpzpFCXAP8auJk5sVpzb1qcTHqhluTPr2L+z4UzPKIrHofR5hTKZBCsZkgiJMLbaoEsNl+xsBFbrHw+FLmLLBekObDMQ9J0259rancdcdXb1wUl6xtviRGCmrBwjys+AQjRLN3/6j75Y7akdyXhU13CLSTvxgDjab+syezLn4GEsNbq3QGwztS1sqCIrJMFfIO6A8K9Se3XUyBHnHXPlWIms4T6EOyGgxBBmhB31azNWQMDZU7kcmaFT3Je5ZDbIELDtZ2WNO2fZpw3BKHsUJpO5A1ytL1slks3rov3hcbBOWkXpwOBu37Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2tlFCAJ9oBJ4W5CZGvcBPDqGSCnK0Rvyx2HVtUOu20=;
 b=L5cw+VyjTAlv8W+gwiTUSq31Ee/0VTtdemG3GxSZKEN24bUHl1unWNQmZ7e711Tr0zH4RFwuxwgqh9BlpcEgvxnL4XCos6a7Q71Fu3p8zzX4Y7MxBjhMiO0U1PJr+LSNKQt/yh5swxU2H4WxizR9CnQqLouH5c1i0c5xAqoY2m/uJ3OiglMUfkT2DndCC6pMDemNF1RnT9/N0iJoSAzuX+j2tOoaMB0U6yveFftqd1p/tWopGKWQzU407lQmRz75CZ8F0a4Ks5IWbDD9sMD1pT7me8nH4HQe0sOD4VuqwMUly24J0Anhz0RxG3W/TEPpru+zkWfVdzD3naPkTwPSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2tlFCAJ9oBJ4W5CZGvcBPDqGSCnK0Rvyx2HVtUOu20=;
 b=VE2NAn0lRCYvfJ8ZAaN5En/40nmnh3tlpARijGpGwa+qptQkt7VHpo7igriUnWiPgfe1wqIa7jxeUpLVTE9FL6uVtuSqmO3QWFIfW+7mNRCya4urWD7TgXf3cj5oH0+eg4UrlLgqlCkUJBbT0Fgmm1alxAXUmT4vGQ6TCNSRimY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:35:19 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 14:35:18 +0000
Message-ID: <991bc3ef-7cfe-4237-a318-6cede8953ed1@amd.com>
Date: Thu, 29 Oct 2026 20:05:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add 13.0.12 & 13.0.15 to TOS reload check
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, Kevin.Wang@amd.com, Vojislav.Tomasevic@amd.com
References: <20261029124641.4154067-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261029124641.4154067-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0278.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b728286-abef-49dd-c9eb-08df35c9da73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|261009223027099003|10067099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sAn+WBwsa92tXRXPWkYVfr6FXOjCPN6xv62/UL1j26/+c8jVQlVAtrkdlOiTOFDwEL3EjWknSVhLZR/B9Cd2+dibYi7Zl7naxT7/DNVqKuguZ3HB6ba89wHVIgT/wHZC77eT5bMkdX6FDPO4k7IxNQoj6javV128iP4fIAh4OJfs98rvhG0wI6BrL6QRotrLkkswuWlQ4bKzG1xIuFhbFYIjf0v4vqxAl9A01JbwKJ1NHCjNrgeXiUN1iNgj451EdwAUX+D/zop0E5dnrBgCZJ39BNhiyMOXrS3E2ZAqQ77edQmkYc6OeO5syUag7CjkSIRuwxDN2AmcpGtenVlJxX0waGKYfQXNJKNqXnn02x+UGy4rwIH8gT4qw+tpN53JGVd0HivhXTBTiMm67AcLSSTfGSIPMz5HgngSQ78pa8ywTyVXQo1tHMzFEhubLSI7X83xa3hBCvlvLC9tGYRGUuLD5OQTriWZim7CcTAM84wX3y/CFgeHtrZydgD819m9BpayMMEa8Apg/FmTg7KxAws6OySI4kX2nOlbu1k0vh1Lm/Vs20tWYR1vcnfRyfL3G+pl7z+daLOTPlUZ7FkrSd0iSWWxP+0tiOblYx2UlvPaYik/+sel0343zBZhxwNx8oYp+zfU675fQ0vM9Ry/M7cIOq7ETMo96qETP3URi1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(261009223027099003)(10067099003)(261021121427099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVFRdXlQcDV1VDBrU1NFU0Rjbk9IaC9GcHpFYlM3UUIzdUVnakpBUmFub2Yy?=
 =?utf-8?B?cW4xamVrMlY2L0JCUy90OFNlemxkQmRMTWk2K2hZcVo5WHA5OGVQdHMyaHFs?=
 =?utf-8?B?TDNacHl6QW9FMDVMeWdFRXJyTG1TNVBScXdDSWRROHJlMkkyN0VWMjFsTi9R?=
 =?utf-8?B?NmtzaS9MRk9ya0lOU2lwSGlFREdUb1RNMlhqbmtSeE0xQ3o3TGhZTWR5azZT?=
 =?utf-8?B?WHRjbWJLK0lZZDY4bS9hREp2ZHI3YzhqcjgzWDhPc0NaaTF6cXRFZHVvZlBj?=
 =?utf-8?B?SWhNZTR0ZFY4U003alVRZkV4WENSNFNsK0hOTnBBdzNuOGtYc09QdGkrR0gz?=
 =?utf-8?B?NS9PejdJUzlwTjJEUHR2RnRyZWlpUnBJMW5SdzcvWk9CNkcxcXBUdTJSbU9q?=
 =?utf-8?B?bXVURWNMa3RxQk04dDF6SGYxWitIV1oxL3A0S3pSSXBIUFJrU29UMWgwdXF4?=
 =?utf-8?B?SGpYWVdtdzlDR1NSWm5zcERFdGI2K3FSQm0vSld3OGtqN2ROaTQ5UFlGZ2Vm?=
 =?utf-8?B?aDVZNjN1VTliUzRCSzVTSDFSRmtQeWw1TkRNRElSSkNBVWtvLy82R0E3R29S?=
 =?utf-8?B?N3RHK04ydDR3Z0p6NVNaNTRTSnlBOHpXWmxjRnJCc0xHWno2aHJYWmZwbmVi?=
 =?utf-8?B?TEtTZTh4TGI3UjFxVzRQaEU4QW1vYjU4eHF3TUpmWXl0dm15MXJ2UHczRTNW?=
 =?utf-8?B?WFR6Z3RpMUFDZlpDTllmOGtMSElQeWo5UTlvckZKSUttbnFXS1ltTlNrQkdQ?=
 =?utf-8?B?K2pwa1hwT0E2anVCdVR3TE96MTNqQkZ1RFdwWEFWOGlkWGVDWCtORnFic2FK?=
 =?utf-8?B?UGNwMnpmNjRGdjVjOXZMSUlIK2dOb0hFcFNoU1pxMlNuVDh4dXVwK2N4cmpE?=
 =?utf-8?B?WFF0Q2V3Y0MvcWYxVkxSQzdDUFJVVGJtQnpuUVFXbGhrTGdYaUFOWWVBOXp1?=
 =?utf-8?B?enZxcmZqZjZZZHBNUmVQSW0yajd5RnJxaE8zdjVYaWw1MHY5ZkxYaUNYUFpP?=
 =?utf-8?B?dVBkMDFaMlZYd0lOdlBKaEtuWEhUTzgrbGxQcnpPODltcCtIMEh2WFpKb1Nr?=
 =?utf-8?B?a1ZiZG9INkUwS3JuNWk3NmhCTkRMMTExMmhGb25USUllK1VrZU04bDcrbzRW?=
 =?utf-8?B?TUs3YjNFMjhWREgvTUY4YVhtaUp1WkhTRUhFWi85bWtjdHYxRVNkV3FzbzJH?=
 =?utf-8?B?YTlldWtmeEh4R21SUGFxbktKd1d1RmZMTjhWSEJ1UGRpV0hQc0VLaUw3SFhx?=
 =?utf-8?B?WTZvM05YMXBaQnc2RjNENERaYzF6YXkxM3BOamJtU1dZZ2Y2cW81R1Buc3hq?=
 =?utf-8?B?MGpPd2ZIYkN5bzFaNE9JaWc1T2RWUU8renZOSVp5N3J1S2VQcU1UNDZoeHJM?=
 =?utf-8?B?L2tYVXJwQ3o5VkZVOHBLS29CdDYxKytIQUdwWjBEblpDM3RzTkpxcXJ0cDlO?=
 =?utf-8?B?U203bjNtN2dqZk54cUk0dnVaTVdZTUwyMy9CcnIzdFZsZW1sbThtVTU5clFt?=
 =?utf-8?B?QTczNnRqVC9qcDNQN2p5Y3pGRGtmS3NMV3pXN2RDMEgyaFdWZEtWVkFpY0g4?=
 =?utf-8?B?M0dGak83dzd4dXJzS3pYSGpPdTB4STZtZlJGNkI0UG0wK3FEakVMamlKcFlK?=
 =?utf-8?B?ci8xT25vMVZGNytrdmJwOGlPeW9MYnd6RU80QUp0QjYvUXVwbVVUN2hiUGZW?=
 =?utf-8?B?U2hXNEM4ZXVpQjJkODRsWHFFQlRVRzJVZktqaDNSaWlnZjFYUVhRZVNyakJm?=
 =?utf-8?B?bldTS2lGT1JFelUrbzBaVnJUVlk0WEVnMFgvMDdyemYyaVp3V3Y5VHArcURU?=
 =?utf-8?B?L0RzQzZrOWgxRU1vVS9uS2NKai9wMlRkVVFJNEw2QjM5SG9yV3I0N1luSTF5?=
 =?utf-8?B?anhydVZHOHJwWVRDR1dDQXBSLzd5N3F5ZDR1ZklGWEtoaTY5dHV5QWdiN1Fy?=
 =?utf-8?B?SG9mclNkNFM2d0VxZXNnN0NiS3R1KzNaNWt4UnMwQmtIeklUNnUvRElrSW04?=
 =?utf-8?B?cHBlalU4eVBQRUV6Z3dTS1JUeDNYRzk2eGhpeCthbVJQRnl0ekFNanRUV1hN?=
 =?utf-8?B?MFJBWTJ6a3dTbFViZ2U5N0NRd0pzQUVKVFRValRZazJmbExIZ203eUV0Mm1m?=
 =?utf-8?B?V0VldjRsMkdybjl1T3hYbjlpYnJhVzdIZll4YkJTMWJqajJWWHVwalRjR3BL?=
 =?utf-8?B?Qjd1S2lnVTBwbmhiZTRja3NLMkNIUVdZaUw1MThaMUw3OWs3MWFTSk1LWDEw?=
 =?utf-8?B?aGQ5aGJOTWQxSVNrRlUyVXZydnpOaVRlNFE4dE1tTkVMZ251K21XNTgwcFVL?=
 =?utf-8?Q?Gy4b+2PZGW5QqWNx4/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b728286-abef-49dd-c9eb-08df35c9da73
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:35:18.3231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqaYoCfOPaWZabFM8fp4CIsqI67Z+3dFghn+pJNMMSLVuKZEj06FCeAwpo5g8u+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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



On 29-Oct-26 6:16 PM, Asad Kamal wrote:
> Add sos reload support when new sos is detected from already
> running sos for 13.0.12 & 13.0.15.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index f9a3fbfc0634..2169cbc21811 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -915,7 +915,9 @@ static bool psp_v13_0_is_reload_needed(struct psp_context *psp)
>   	switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
>   	case IP_VERSION(13, 0, 2):
>   	case IP_VERSION(13, 0, 6):
> +	case IP_VERSION(13, 0, 12):
>   	case IP_VERSION(13, 0, 14):
> +	case IP_VERSION(13, 0, 15):
>   		/* TOS version read from microcode header */
>   		ucode_ver = psp->sos.fw_version;
>   		/* Read TOS version from hardware */

