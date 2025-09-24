Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F30DCAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 21:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E7510E7FA;
	Wed, 24 Sep 2025 21:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rBdIrRpR";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A85210E7FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 21:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msT5zTrvtkeG7m8fmPoubRueB2tYW9AX1pNyRxtFTyIteN+GpZs0jTpLcOh0XqJlsB1KPg43EoR5FjwzHK7u0nIkbYrmk0fiT111SgxSG71ZJI/42DJoWY/24YQ1dylZV/LMA/jinOlZswK9eZSaIwxL3nnQ0StwJVURmGcPAes+vbY6COSAS8Skl3o8ybRBQRx6cbxbjajf1kFU2d8Fw2PJNdCE3FP3hkcHtPgtch6G5GaP+7BDAgBygfCLK67NPr0n0yG04y9t4VnPBaMae3ZIikF6n+XmKcxN9LTns/F2STtlNe/yr2IeEkmOGHjUSkrCLDfVQuNppd186TJP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lztC8voaqyJNjdwrrQ7kDN7kwnVVpq5HFmgQ1Ur5osw=;
 b=t5ClOX7YMaUL6T4PDBgc8RSgSpNP2E/FQczl+Ch4hMoDbwwTrTbWEe4NAAHV3tgufGZTrQlPCcKAVZbUllzgCEUtMhpolsiHbJnuROrofuND/yvv9ti2g+O9Tx8SJgU+8+PBX8qSpjEYqCxUojEvH7pKeOoYXvIqwjdEXWdSg7xDwKbhb3G0MXI+x/yKodYXhnzDHgzBsMAtCUQZtipf13WAY+Ka9JhYxVHFTBylMyHkfnQQ2Yfbqo/jImEGyeB5rlW5RkWOoqLRqt6hUtPMQKbAG5S33QHxlTkAb++hqqdjzStdUxK5uu9Gxj/gFQFn4qsmODIMuQfK40MmH0PNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lztC8voaqyJNjdwrrQ7kDN7kwnVVpq5HFmgQ1Ur5osw=;
 b=rBdIrRpRasIGj01YcAUB8oZThaIcQQ2Y5Xw16LMovL0qBTmTvft/RO5HjicoZ6/FrHD1HqXUCDNbUeALx4SPi48tM8A66M0BcrIYh8cUuP6fOUYWGjFq/Qh8kqHpj38+JhysB5r/Rze+eGGqK9AwSvyz++h2Rm4Po2hWhKs531A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 21:45:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 21:45:27 +0000
Message-ID: <c0997b76-e9ab-4c03-a2ec-16f39de2ee59@amd.com>
Date: Wed, 24 Sep 2025 17:45:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/18] amdkfd: record kfd process id into kfd
 process_info
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-15-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250923072608.252345-15-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: a5223fd4-896d-4473-bb69-08ddfbb3acd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGg1eUs0dWFSZHhML1VDZnBqOEJXbDZ2K3BSc3RQQ0RsZ2FZcGZhQ2NKeFA5?=
 =?utf-8?B?K25JSWU4ZGt0M1ZhWW5kTy8rYUJxbWlzcDNpVFkxNzUzQUcvMURPR1EySkpR?=
 =?utf-8?B?Uk54QzhRd0hkMHdXaE5DejhNbk4zODhJMkU0TDFsbThQYkVzaXVwUW1ObDNS?=
 =?utf-8?B?Q1JlT05YYW9LeklDMzlpcC9RdXNjK25wS1paaXFodWNOdmgwenRLdUVPakE5?=
 =?utf-8?B?V0pMWG1mVjRsMXlxei9sL24vY3g1bkJGUVVLWWZreE5MZVNydHhkR3RnY1BE?=
 =?utf-8?B?bTg2bktoL2pITzUzcDZOR3hnU2dDZTFocmxFMzFDd0ZQb2YwUmRUN0xFNnJ1?=
 =?utf-8?B?Zk94UUtqQ2t0MmFNZ1R5c0NCMUwrUit4eHZFdGx6R1Z4VWx6d0R4NWp2em5k?=
 =?utf-8?B?c2UxaUVvZTB0ck9BWWowNWY2STN4VGI1WmNiWVBGVkR5dEdUbDBsa0xzTklQ?=
 =?utf-8?B?S0I4SnI5WGVTL0h6QzhLbEJIKzVyR29tK3UrdGZVV2tvVWtobFl3dVh0WDBy?=
 =?utf-8?B?OGloQlZnMTRLMkhjVFEzdUMxT0d3SDJ1dmdDSkIxUXA1ZkduWVZURE1ML1U4?=
 =?utf-8?B?TEg2b1ZUMFRJQ3NabVo4NWo1cW5XVHlmQnJvZDdxRkJBN0xzTDJ4TjQrYmRt?=
 =?utf-8?B?aVI2L0Y2L0RPMWdvdmw3anlEV1k3VkdiTFJUallOQVhCSlQ4aWRtRFprU0xW?=
 =?utf-8?B?NjlBWXVsUVhYTWdsUlZFbU5ORzcxTCtUT1Mwc0NyOHZPcHUwZ0lLUmhtVVFt?=
 =?utf-8?B?U3d1ajUwZzhTZmVwMi9rbnJhTFdGbjdNWGQwZk1Ra2Nzc3c5emc0R3JhRVB6?=
 =?utf-8?B?ckd5dnRqcWFUZWxabkpIRjZ2Rk9PeVRxZTJLR0NuUndDWTBJMnpMR0F3V0sv?=
 =?utf-8?B?SWY2YzI4ekFHbEpLWUtIZzJuWjg4cnJSc1dITElmUmM3U3U3NUxQK1U4ZnlO?=
 =?utf-8?B?Vnk2V0JVYVd4eVBDN3ppRUNRZUZvS3lMZlE1UnM4UHp5TU9XaytKdUVpY1Ax?=
 =?utf-8?B?TVVEWER1a1h4Q1hjcm5wTE8zOUtVZEFibEhnWmxmSjVtWFJ3QmtuczVrY3o4?=
 =?utf-8?B?Z1ZvSXlWZjM2R0F5UEdGbmY1eUpRYTdGYXZwMXRJV3ZPaFFyNDBjN0ZZV3NE?=
 =?utf-8?B?V3puaG5lcWVRTTVoYS9ZTDJ6OU55NFA4UHV3eTVLb1ZnQmlHN09uWit6NTF4?=
 =?utf-8?B?c2xTSUtURG91YnZtTnlPWm1VWGV6ZXJpNU54aUM5a2VxVTdxaVBCRGtsallC?=
 =?utf-8?B?bFNSa1A3MEhzMkN1eWtZQmI5NjNUdEFXWWpCL0VTVW9mMjE5aEoyQ1lMUnk4?=
 =?utf-8?B?VU5BdStqMHhFNEVzR2F4aWZ0SlZXajhMeG9wZStRMm9jYWZxY0RTb0c2Q21G?=
 =?utf-8?B?alY5d2ExWEEwTHJSN2FlbHc3MXZjRGpHamJtQ3R6eDBLZFRNMG5oTkpva1g4?=
 =?utf-8?B?LzhYczA5d1lRaGMyamFvQVNaRkxtSDZDb2lWKzhBV0tyVzFUOWJpc3hSeThZ?=
 =?utf-8?B?TXZoZVdiNFJIRU9yTWFQQ0VvVStqdmxES0FHNEF2WWpGYTllUzU1d2tHUTRs?=
 =?utf-8?B?UkFPakNYK1UvWHlFN0I0RDNrYWtiTUo0a2RQalE3b0w5Y21rZVkyOWZjdWJV?=
 =?utf-8?B?US9SSFBpL2RtVjIxR0hGSm5JazVkbFJXc3ZXaS9jajJpSkJtQ3dRTzhMWlJu?=
 =?utf-8?B?TWVEVVM0VDdrSjVnMHJjWDZlSXR0ZndubCtMKzdvbTZyM3Bpb0pHdGZ5My9F?=
 =?utf-8?B?Q3hEM3lEVFR3YVQrZy9JMVEyUHRhVFJqT3QrbzRWd1k5ZmU3Mnh0NEhnQUpL?=
 =?utf-8?B?ZFNheisxdVV0TEJZRVZPaFFneFdXVkVjNWNzUzVuSHh6MmpMY3NjV2FyNnQ3?=
 =?utf-8?B?MlBQdzZPTWVPRThacmEyQnp3THlBTmRmaTFHS29hRGttZWFjRGRrRHlzMXh0?=
 =?utf-8?Q?EKRaSxV70iQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Z6eTJOY0MxYlV2cVNBa3lPZ3BZZkpidTN5TE5hMmR6Q2FJbWp4K2xWZ0F2?=
 =?utf-8?B?RDVQeHlLdmJXQ09xY2hscHVSdzlMY0UvQVUyYU9vQjBRMmRCWVd1cGMzRzA3?=
 =?utf-8?B?eWp1NkcwMFF5RC9yS0Z4MGVCbk5uLzdzbFI5TzZYT2d3cXdhNDZ6RHdWZU5m?=
 =?utf-8?B?QklwNlVoSkNNbTB2SktmOWxtUFZBaVMyMTNrTFQ3TisrTndKWGhGZnpxamZG?=
 =?utf-8?B?NTZiVVVVekFoM2FnQlJJTlUvL2t3U0xBT0xjTWdsVThjRFNkc3RSbnNJU0Nj?=
 =?utf-8?B?M1ZSN3hyTElWUXYwRVhvYnEybFJ0ejZxYmlMTndRMys4L1FaNFYwZ0l0SVRh?=
 =?utf-8?B?NkNMWEpIVHFqM1k3S2VFaVRIS0xMTzFQK05tVi90K1g0dDloRlJjV29JcEQz?=
 =?utf-8?B?Mm5ONkdoUlJZVytZaVBMRDMxRVlhWm9pV1pncys4WlFhZ1pFdDBkd3ZleHFi?=
 =?utf-8?B?MVp3WmxEczdPVldDRmdGcGZIL21QQkpqQ2hoeVZaRUxtK1FhUENKOE1xVWxY?=
 =?utf-8?B?Nkx4MTFaR3R3eG41enAyNnd2MHIrcHpLb3RTM0x0U0hNdUM5Qkk5enZWYVZV?=
 =?utf-8?B?U0UxR21vR2NoR2F3NTBPTWlBS2c4djJPNUdyTi9oenBSK1Z4bVhiNDVOTHUx?=
 =?utf-8?B?VUNSOHNQUGlLVnMyQ3h0dWtldFpreXVVV2RKSWcwMlhUM1FzTWZrcHYrbDcr?=
 =?utf-8?B?OHQ2Tll4M0dTZk9kczdXOWEyaWRGeThndzBENTBjdW15dkh1WW5xQk85U3A2?=
 =?utf-8?B?dDBCd2crYXR3R2dEek5YY0dsaVp5Rjdkb0xFVjNndFRDc0hldFlNbVJ1b3BF?=
 =?utf-8?B?bFZoWllFcTYybXpwT1hwYmVvOUpMd1NwNnVWN1JtVG5KMzY2bXNzUjFGenNB?=
 =?utf-8?B?TUxHUWpMcFkyWCs4WW04Y3JmdFY4SFgrbkJDMjQ5Z3o1WGQ1UzVBcGFPUEFT?=
 =?utf-8?B?Q0twNnFVaFk4anFiOVF1Z0NTQ3hzS3NtTmlONWgycEh5TGxsYWZUalZ0R3hX?=
 =?utf-8?B?alNtbXIwUDhseExPSEFTdHA4dEhRUWsrWWZWUTM5UVRsOFN4cmY2UEx0eU1U?=
 =?utf-8?B?Nk5xTE5lV0Jvb1lUamZmWTdobjBaWUlkSys1SmdJN1UwU3IwdkdBeUorbXFv?=
 =?utf-8?B?TnV2VmxvL2dQRVdUdDRiRUl3RVdyQm1BeWdsNE5IR3hIU285MStEdDNFWGFP?=
 =?utf-8?B?cG9qQ0pISkFJRnNnWHdDMVRKRjNGNW5uRHc3bXRPSHRoZkoyWmFjbkpoS2xP?=
 =?utf-8?B?MWxZTjJDclZzUHNiT2xsUDFjMHNmQ0VxOVp5bEdTVVExYmRIMVhvRGh3SEZq?=
 =?utf-8?B?Rlo5WHQ0T25EMzJUNzZZKzBhYWtBYlN4QWE0aTdIeENIV2c1TEZjS2xTL0t4?=
 =?utf-8?B?NnlJeGZNYkpYL1VTS3BKZ0RscHA4WlRTTXQxa0xBWURuSFl6dHVRcXYwVk9m?=
 =?utf-8?B?NHhGOFQ5dXcxV0tyL2FDTWMxRlFQek1RTlFVMU9wZ2NGa1N1cDNNNXJDNzln?=
 =?utf-8?B?bGFWVitNcFhjcjdveG93L2dvcDF4b0txcXZBL2NFcXRteFVwQkh2UHJsYnF3?=
 =?utf-8?B?Ynh6NEtkQkZoOXlrQVk3MFRxdjdGRlJsV2g5Z0diN0t1MEtObVJBUmd4SmV3?=
 =?utf-8?B?Vkxmc3pKU2lydDZNZ3k4QmdTWDFIZUlYbTY1RW1SeWcyZjRtMHZTdG5VaS8r?=
 =?utf-8?B?Y0cvU2t3K1BlbjFvdk02RDBvb0VxcUdDWGd2aGZaQmRDTi9CZk8vb2RUZmdW?=
 =?utf-8?B?MkhiT0QyRFNYdTdlbXZzN0V6c2ozREFZa2NhdzRNaEpWREJkZHBGaWVra2Vh?=
 =?utf-8?B?NURVRXRpYWhEQUdaQjFZdmoxais5YnBzR3lmVURrQnJCT0VuSWFMeThxaWtn?=
 =?utf-8?B?NGtpZUxsMXVLV2p4UmlIWStyTHdhSElTeDNobGJuQkE4SGlWU0xPNEpSeUUz?=
 =?utf-8?B?c0IxenpzcjZmSkQ3QkNMN25pL2ltalZjViswazdTamNyVG9QTEVqQ2ZlcmQw?=
 =?utf-8?B?NU5OUlRNQkhOVjNoTUgzK25zU09nTzBPMklBeEVnTzlsNHZ5T0s5TnZrcnB5?=
 =?utf-8?B?S1A4TFZCQ24rc2VXOWo1VUpaN3ExTDZIOGNVMnhTN0JXUElxQ3pEYlgwUHZo?=
 =?utf-8?Q?PLNHM48Nwvq7NSJdJc9bjKPzt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5223fd4-896d-4473-bb69-08ddfbb3acd1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 21:45:27.5367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDbkaOdlOVYLQwKynvGYvY0jfmcf8fGsiRwFQn//ZV2Tg//xRRl5VXp2ee86MIZypmjm32hD1CgekGpdGxGwHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746
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

On 2025-09-23 03:26, Zhu Lingshan wrote:
> This commit records the id of the owner
> kfd_process into a kfd process_info when
> create it.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index aa88bad7416b..d867984a68da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -146,6 +146,8 @@ struct amdkfd_process_info {
>   	/* MMU-notifier related fields */
>   	struct mutex notifier_lock;
>   	uint32_t evicted_bos;
> +	/* kfd process id */
> +	u16 process_id;

The name "process_id" is a bit misleading. I would prefer something like 
"context_id" or "secondary_id" to make it cleare that this identifies 
secondary contexts and has nothing to do with the PID. Maybe use the 
same name in struct kfd_process as well for clarity.

Regards,
   Felix


>   	struct delayed_work restore_userptr_work;
>   	struct pid *pid;
>   	bool block_mmu_notifications;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b16cce7c22c3..723d34921c12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1382,8 +1382,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   		       struct dma_fence **ef)
>   {
>   	struct amdkfd_process_info *info = NULL;
> +	struct kfd_process *process = NULL;
>   	int ret;
>   
> +	process = container_of(process_info, struct kfd_process, kgd_process_info);
>   	if (!*process_info) {
>   		info = kzalloc(sizeof(*info), GFP_KERNEL);
>   		if (!info)
> @@ -1410,6 +1412,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   		INIT_DELAYED_WORK(&info->restore_userptr_work,
>   				  amdgpu_amdkfd_restore_userptr_worker);
>   
> +		info->process_id = process->id;
> +
>   		*process_info = info;
>   	}
>   
