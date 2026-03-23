Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82FFF4613C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 15:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC3E10E49A;
	Mon, 23 Mar 2026 15:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rl2uSqoF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993E710E46F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 15:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLbzL+UZ+y3oECD9CF7aN3p7t4rn6M6JRwgnAwS51AOfloUmfo0VG7VnVhzdCKvD4AXSsCnAJbwsk2XGpfypRtbjSuq09LXAgwK7ER3N8C/1syJGKREGqPnxF+GIeQSkE+BnEQOmYf4Y4VIRWiNseOOQxOrR+1ubyXSuQPbYLTO6SnbxAROazR8vqK3PqlFKq4dboDVqb/8ROVQz2ofRGxhEWAVijNsLKkJp94s+5Q2UR1oQWFzLPbdywuiXWpfIigPhQOXYMe18K/LO3ZSrqgfWYB+gHoN1WWsDpsdwslA9JXTOHsSNlGU9NIxab8BZR6GR7/EzpbjWhvJ6JhQpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FNKkoVOJTJSDtk9YChNgFan8aDCDQlhEMLU1TWOIVo=;
 b=U9+E7FdCVPEnc/pXSBhi3TIRxWBDZjMadFKAcI58T36mmVjBkpIQ3nJe1ipaCoowPJ+wgzWmMvGkdpnACNT8Ko6MbLmM9S0zd6iSufBOm2roH8IvXUphWsZnPJpMjVQ3RCTInFCIZh2XEyhkkE7M0BVY+mHLOcP+i+2CxC90Cs4rIqNI3yi/KxB3EZYj6PI4Ap1BPZBqDwjyEZtR5LBIuGUztU8ValEiwBNeFT1ZYVk+e/pDuaNy8Rm0bZcMw/jd6EYDf8/5yGs7YdKI2l0A/zFYQl23+yHNmUNDutiDg+D2WEPR5Y8LK4ANszK2OYZbC8tuQ1yeznM55j/HWoUh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FNKkoVOJTJSDtk9YChNgFan8aDCDQlhEMLU1TWOIVo=;
 b=Rl2uSqoFuASKJSmnaHzV5vZjvMSClNzluBnne0IswogPhZBjLQaNMqHiBkgAQPK56Z2WyaCbo7NvcCTNwRiq/vVHRcuk49bdfRzHBnVb8kzvCFDUd6eTMqOB9KD45u443lG742h9cJojkngYaA6lHJNi4Q1Fc3rSoimoH4oPqy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 15:29:56 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 15:29:55 +0000
Message-ID: <67393c4d-b08f-4e73-aaea-1cb129ce1515@amd.com>
Date: Mon, 23 Mar 2026 20:59:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add support to query vram info from firmware
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com
References: <20260323080525.1877204-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323080525.1877204-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0ed61c-6cda-48d6-2b20-08de88f10915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 4MQW52z8C+UK3iVKMyihUIclrQLlvC2xhBRGpUy5gdVrlJOKo3DODGxt1pbB7BZbw1VHoNa3Vep9m3aV/HH6KW30BwgFoe3jk4BN+HvJc/2e6U2ChlbDteimfcfkOs0W506t6GXmI4AvCydzp+sBxUbeDLQGuNiVow2E24sjw7X0PiipBBKpD3xXZ+fM618rropGGM+oneoiXiSBWgvbMFnhgI+YHzV7ktitZbepR3xxUVxaER01WsxYkIKbn6cZfPmI0Q1ECEdVo/QuBK0ZwPCsE0seuy9HR2bm4NYOcj36hd09s4h3ClhHTfFPJLg+CAV/KVBLUbaN/h2MbGY1wtYRpmACvqlLsyzjS+7GurwGBxDhX1OcgQ6zff+Dc0tmd8MlCBlFRx+Fn6vUKCcyoPcZ0/hMItNbdqj+fWVfsxfEs1+6fp8Va72aXMBc4ZdEfP0u3S2olCBgBq/sThE563xLD1adjdpyG+y+hLXqAL8i3bYCUVyS3bT3pfjWvOsF+ko6jvMRub19dexCFKga+u/eBGbZQZY9d7fcCrwGF0oXVXApZ+dMtIzEfvC+0pE5psY1a7GuJ7AyOBEiULrEpw6BE8/ICmHPkrX/t/ZrJ+WHnmDznNZr8N8wVcQSgQWUfttzYVdwEIrGju3SsC1ApD0Q2+7jEidgR3+9OAHSoaQesyAzTu7Hr8lO2JbdHQKAI+F0oGe0NmXSUSRKZzOlpoh2BKrUIbMqXWJvmlKuPJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUFDVS9mYnRvN1pMR2dsdC9VQi9kQXZLMWZyWmQzbVZ1eTJJRTZLUGlkaVhL?=
 =?utf-8?B?VWMvK2R4RkRpYmRBM2dqSlJsSHJLeVlYN0dnaG5aQytRa3U0UGZPeTZtd3p2?=
 =?utf-8?B?ZFVQV0hHSGlwcGl5eW0zTFRGWUM4RlY2UDVUTUFBOE9oVmdwUjJNM3pZWjlk?=
 =?utf-8?B?bitzOXNTQmxDaGNlZjUwLzVtWkFHTmR5NFhELy93NEg4Z01IT1RDWEVrQ2JM?=
 =?utf-8?B?Y29wcDdsc2YvSXM5YUg4RFQ5aFZJakdLbUJ0WldPY1M3UGtwakEzQ1h2NjJh?=
 =?utf-8?B?V0NlOHBRNFJVdnZFQ1lkMjJvaGw1YjFkVHFZRGVQRUtaMTBBQVZvdWlCdFdU?=
 =?utf-8?B?ZHNlVDhMZHUzRWJQM2lzYUpEV3UwNW10R2pNL2M5VXoyWFkrTmYwdjk5djU4?=
 =?utf-8?B?aE1wRDJmOVdzTjBGaUhuYUgwbk5EVXhTNEUyWGZyRk4yZ3JkeENPdERpWmd3?=
 =?utf-8?B?SDJxbHdBY1JqN2FIZGJldUgxZnFubVYycVlITTlXSXFKc25tN1ZLN0licTlw?=
 =?utf-8?B?N3RZSUVodTR0NVI5VFR2ejlBNUVST2xIYzdvRFUvVUtWbi9FaUNaZ1dsK09n?=
 =?utf-8?B?Wk9Wb2d6bTBYRll0Ym5xa01KSk1RdUZ4S1FCT0VFUkFQNTdtMkl6cXgrOW5u?=
 =?utf-8?B?L01KL2NLZ3hxRlM5M2J2VEsySTRacWl4dmRaMGFJRUJ2OUdVaWVpbFFpcG80?=
 =?utf-8?B?Vlo1dVV1OGE5U3Rzd3M2UCtuc3RuMUhHT2E1RW9DMEVvbUp2T3FCVU1xbCsv?=
 =?utf-8?B?dk1WK3lqWVJpY0pubDUwdWR5UHlxa3BxNExkK3hxV1d6VHpjQ2JwQmdYM2dU?=
 =?utf-8?B?QmVRTjV4aGVNNXNmOGtlMWFRRFpKbkxEYkJPMG5SSmtWdmppbEZtQlNIZTFk?=
 =?utf-8?B?SFAyR05GRDROK0MyOTJvajVOZXhxTXZGeG56TDkxYkJmb29ZMW0waHhGUmNq?=
 =?utf-8?B?S0V6MG82UTFEd2pVVWdGRFJJR2t5T1FZQTFGMkw3UFNtTElPNHMzeFVpN01T?=
 =?utf-8?B?WVJsTW9NV0Y3RjZOc1FnU200dkJZOExBMmdiYTMrWUY0Q2tTUmdueVFBOHZN?=
 =?utf-8?B?VFlxbHhmWXphaXZvdG9HbXFQK2YyS0RNZm9uV2VYOGpWRWV1WXYvVklEYkNE?=
 =?utf-8?B?amk5UVA4TkVYK3hCMUoyNC85WklkQ2ZKS2l0Y1RqTWszdll4ZUlUVTNUTmhE?=
 =?utf-8?B?V3diWG1RWWtvYm1FOVpEMXFNVkQ3ZU9LeG5yeXpxWktzWmd1UzdJdzIyUm9C?=
 =?utf-8?B?bDV5V1l0S1cvWXNLd2lyRm1HOXM1bFM1OFJXVXZEdUJPYkVsUEJxQ1FWZkk3?=
 =?utf-8?B?S2N5Y1dwd2tlcmo0WUcxSGNIazY1VTB5MGN0cTArcjZ2WHFMOVN5QTVmMS9V?=
 =?utf-8?B?djVLU3JqZW40R214L29hY2E0UEFLNUZUYUIxNmYybGQ5VWV3TUpISFVja3hm?=
 =?utf-8?B?Y2svdDZqYWJuQ0hWcHJ0bGtHSGJDdTQ1K2xwSDVRQzBXcGVIZjV0WXBhVzRm?=
 =?utf-8?B?dG45SjliVC8yTHA5V0hyRDNKdHFMRFJZTFJ0L3dETWZUbjFCaTkvYWd5NnV0?=
 =?utf-8?B?MkVwOWZxRVY2dTRNODRqRzZuZ2F0eWQ5emlSNE9ld0JQYlo1cStYWjBZdzc3?=
 =?utf-8?B?NmtOVUFtV0c4R29HSUkvaWNlZDFhcW5NNzd1dmdlaU1LbUhGZisxUFZ1cml0?=
 =?utf-8?B?VWpKalNBMUVDUGNJeFZPUHkvZE1zYng5S2l0eUZkM0diVzFHbVZrbHlVd3Bl?=
 =?utf-8?B?SWNyMzkyOXVCbjBIbGhjMzBJM1FrdFF4K2NJVWhHb0Y0SkkrNDhxc0NvTXhs?=
 =?utf-8?B?ZTdmMERSQ3Q5MjB5MG9OSHlkNVc5YnU2MHMwTVh4WTFwSXZTVG5Ga0xQcVg2?=
 =?utf-8?B?RHpqRVdmRExUL0VIZGZodkU1VFhIRXpIM09saFhZN2JXUS9vd2NrRzhISDJC?=
 =?utf-8?B?dDhmVFdwbCtvM09RbU1YZFZCRFAra2xjZ0NucUttaEtkL0Zkcm4rZFB6dmNZ?=
 =?utf-8?B?eHFxUXN4TU0veTMzUTB5K0pUT09tT2NHbE9Sc05sVVo1WTBvQllSeHl3Z2dU?=
 =?utf-8?B?aXQ0akpRTnFEbXJqbEVMWWZCMDREMXdoYjk2ZWF5REVyTU1QZk54OFhrSC9t?=
 =?utf-8?B?ak96K1lBK3hDYkNnMEwrWVJEMnJtWWloM0pvallEbEpZemtNelJ1Ung4dGJ1?=
 =?utf-8?B?ekI2Y3A4czg4MzZoQlgrYXlTWWlZMzhaMmdsNklxUHh0OXo2ZGxWa002UTU0?=
 =?utf-8?B?Zlh0b1RJTzFHWm9NYUlUUFpuYmFWcTF2NDVrVk02akJIUi9MZ3ZkN2drUlpl?=
 =?utf-8?B?cDVTYlp6MGdmd3FWSWRxbXZZdHZ3NnJZQTNpcHhsT0d6Z2pjZGVBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0ed61c-6cda-48d6-2b20-08de88f10915
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:29:55.5908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqMGghitGMKqkyAbtDVKo6JXYCzgjw45m5RbeGX93tKyigxNIVierljpKqVRz1Sg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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



On 23-Mar-26 1:35 PM, Gangliang Xie wrote:
> add support to query vram info from firmware
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 13 ++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 50 +++++++++++--------
>   2 files changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 7f4751e5caaf..504b5f0a74ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   		case IP_VERSION(12, 0, 0):
>   		case IP_VERSION(12, 0, 1):
> +		case IP_VERSION(9, 5, 0):
> +		case IP_VERSION(9, 4, 4):
> +		case IP_VERSION(9, 4, 3):
>   			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
>   			break;
>   		default:
> @@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   			case IP_VERSION(12, 0, 0):
>   			case IP_VERSION(12, 0, 1):
> +			case IP_VERSION(9, 5, 0):
> +			case IP_VERSION(9, 4, 4):
> +			case IP_VERSION(9, 4, 3):
>   				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
>   
>   				if (frev == 4) {
> @@ -488,8 +494,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   							*vram_vendor = mem_vendor;
>   						if (vram_type)
>   							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						if (vram_width)
> +						if (vram_width) {
>   							*vram_width = mem_channel_number * (1 << mem_channel_width);
> +							if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
> +							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))

Suggest to move this logic inside gmc_v9_0.c after fetching vram info 
from firwmare. Then within gmc_v9, you may wrap the check with 
amdgpu_is_multi_aid(adev).

> +								*vram_width *= 4;
> +						}
>   						break;
>   					default:
>   						return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 1ca0202cfdea..e6bb04dd0830 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
>   		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
>   }
>   
> -static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
> +static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
>   {
>   	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
> +	int dev_var = adev->pdev->device & 0xF;
>   	u32 vram_info;
>   
> -	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> -	adev->gmc.vram_width = 128 * 64;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +	if (adev->gmc.is_app_apu) {
>   		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;

This is just AMDGPU_VRAM_TYPE_HBM.

> +		adev->gmc.vram_width = 128 * 64;
> +	} else if (adev->flags & AMD_IS_APU) {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
> +		adev->gmc.vram_width = 64 * 64;
> +	} else {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> +		adev->gmc.vram_width = 128 * 64;
>   
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
> -		adev->rev_id == 0x3)
> -		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
> +		    adev->rev_id == 0x3)
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +		    (dev_var == 0x5))
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;

For an easier lookup, may be wrap these inside a small inline function -
	if (gmc_v9_0_is_hbm3e(adev))
		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
	else
		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>   
> -	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> -		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
> -		adev->gmc.vram_vendor = vram_info & 0xF;
> +		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> +			vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
> +			adev->gmc.vram_vendor = vram_info & 0xF;

This is specific to multi-aid SOCs. You may add that check here.

Thanks,
Lijo

> +		}
>   	}
>   }
>   
> @@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	spin_lock_init(&adev->gmc.invalidate_lock);
>   
> -	if (amdgpu_is_multi_aid(adev)) {
> -		gmc_v9_4_3_init_vram_info(adev);
> -	} else if (!adev->bios) {
> -		if (adev->flags & AMD_IS_APU) {
> -			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
> -			adev->gmc.vram_width = 64 * 64;
> -		} else {
> -			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> -			adev->gmc.vram_width = 128 * 64;
> -		}
> +	if (!adev->bios) {
> +		gmc_v9_0_init_vram_info(adev);
>   	} else {
>   		r = amdgpu_atomfirmware_get_vram_info(adev,
> -			&vram_width, &vram_type, &vram_vendor);
> +				&vram_width, &vram_type, &vram_vendor);
>   		if (amdgpu_sriov_vf(adev))
>   			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
>   			 * and DF related registers is not readable, seems hardcord is the
> @@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		adev->gmc.vram_type = vram_type;
>   		adev->gmc.vram_vendor = vram_vendor;
>   	}
> +
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(9, 1, 0):
>   	case IP_VERSION(9, 2, 2):

