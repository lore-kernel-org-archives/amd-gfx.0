Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A87C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 08:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068DB10E1D4;
	Thu,  8 May 2025 08:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBdQ5Fkd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4970810E1D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 08:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhBeCRFwOtxTU+1jspug5ywPhRsiVFLXOd18SyyxurMbKLWLtyHlilbjRq9gUPN+krQoccM+JmfV2ysrmQGb4Y+FtGCyBzW+JFeVIIvS9lFU0jUElX0rs2dpEUW4InAv9+TB/I+iEEABLEQks6H/d09GDiWStOaTm0VfE8isi7DBDMKWvnoKkTEa8ZDAqUALlVQqiTrRO+X8sCzAe2FUa/j2mc+m7a77+u1DJiOrPoZXnAD+Zgdkn2/74B27mIFJRwgCx+NCyw+nTaY3vgXGJ77UOX/4Zp4PAlm1lVgfZwWFQFobastmmJphaY+2qhzoewLm6H65PfGiG1v3buEw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYPwEB8L48r4fSOtg9vJpuDtc8pxEmYfO1jO438pggE=;
 b=nwwoXFJC71IXSEKg/M5CV5IUT+nOndOsuHNm2SzLW31A6lqpvqkzt+PWd0AlAW/KtqPjPzaq+S3ioZuKCF1IMmMG+oav49VbN9tBvbNWmWgDdEpLficVKIBrOZabDL9qjUrrP3Xu7TUUUatbHLKDjnoJVTBGSIvtIUBLuJF2Vw2ymxaqlAYSfqwxF7jnXOBgbm90Mba8S4vXq7/PbmVHMw5TciHlx2Hpt55lvfE9k7vmCp7E87rCqZ9h4rXIGSFK8ItvKpvRAYXn//Yw2iL3rQM1WEe3K3sKEXSOkYoGDUfWwSBDVQCkNrVgwlbwXd5aOd1RaWLy+CfOd+G1rUT+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYPwEB8L48r4fSOtg9vJpuDtc8pxEmYfO1jO438pggE=;
 b=CBdQ5FkdtOf4oMB3TpMK5wUqNxNQbITOCR66icBKsOuYoADdf+G80GdRzvxhNO20a0mWpQH8nHWPJnpouQ6wWUTDGbgMTiA3l3C8YNX/p/CmWyf5xjjpeM+FT4PYduPIYV2lsbq4YecVdQZk4TxNaxyv6Ps3Bg2xzmRnnr6z0PE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 08:12:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 08:12:30 +0000
Message-ID: <1aca1130-082e-40df-83fd-eb00fa3ac206@amd.com>
Date: Thu, 8 May 2025 13:42:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
 <20250508050926.228674-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250508050926.228674-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ee3e7e-601a-4b0f-f398-08dd8e0813fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWhXa05sa0t3a0xkWUVjMjhlbGw2OU1JcmxGYWZNc1Btb0N4bWFDWm8rTUhS?=
 =?utf-8?B?QTE2OEowdU5WMGkrQ2RKY3BJalFCN1dYaTVOMWI3TER2aEpQUEwvRHJDK25n?=
 =?utf-8?B?MktJdVp1b3hWR2UwajNrSjBvUTRLczVmRlBHcERBN1NuTllteWlTa1dQMzVR?=
 =?utf-8?B?Q0NnWHZSbWpmYXA5VDlpZUY2RjJCQW5mS2VJRFBVNllHVkpCUDZsNWdFcVhn?=
 =?utf-8?B?aHNockoyOXFjaHYxa3Z4bGJLcElqenFveEQvdlg1blpRZkR0eWJqaTJ4WXlM?=
 =?utf-8?B?RHN5NytCZDI0SWVsMXRhU3ljNTVEdFE2WTF4UWxnNlArYjNRVVJFRUZPZ3hu?=
 =?utf-8?B?d0pqYVpmRU1kQkxvWE5JVkxxSlR5dG84Rllza0g0VzlmUUJveW9NaDUvV05k?=
 =?utf-8?B?OVR5b21XdjBOekVGblNXUGFNK29YQVVTeWsyRTcvMUVydU5hZDhaL1IwSU9a?=
 =?utf-8?B?cUNXRjRFaXYxOFdubExvbTlpRi83bXA5SnlmV2ZHckVoNWpyVjlTYXNtVTd2?=
 =?utf-8?B?NjlKdVFVcGk3Q3FTSW1ZMndzaWg1RmNDTlg1dEpoU0RKZGkzdTZGeWJLb3VC?=
 =?utf-8?B?bEhMQ0ZUS0x5cndvVXI0L01COXNlS2FrNmhOWmdvQUk2VHZmc2tUMFRPVktS?=
 =?utf-8?B?aUtMRS9wVE1uWTRXMlVBUjBhNy9JYjNrTEhHN2lkMDQvVjU1bTVUZXZ6M1VB?=
 =?utf-8?B?cnZrNmNEVEd4U0JMQTVFclBMYVhtSldaTDBVRmRlUENoWGZLTzBNNW5FaVJ4?=
 =?utf-8?B?K01xTktUL0oyd0F2ZzhrUy9xWGV1YXltZkhEWTFLcTRTTDVFU0ZMN09rcFFE?=
 =?utf-8?B?NkdBQXpraGpteXFGYmo1RTAzNHpVZVhWQVZIU0ZJd1d4SEFMUXJDQUVXR3B2?=
 =?utf-8?B?Q0lsbXRnM2IzODFqYXhUVmZUamh0cnVBekpGNFlRMU14dDVNZzkrVW15dUdK?=
 =?utf-8?B?OEViWm1LdDF2Q0lDRW1ZY044MHBsNHU5c1dLUnNiM2FaMTRCMVE3ZjJwOTFx?=
 =?utf-8?B?bnNWakRFQ2p5eE5pRHRKbUVyaGZPaG5Lb0JUSmloK3ZSYTdmQlU2cTFWVnBy?=
 =?utf-8?B?eFRTQUEyWm5KWDMzOTJQT3crWmNTYjc1MEVJc2VrTVpiMFhLdDBiU0ZkcWx4?=
 =?utf-8?B?YWtISlB2Vk8wR05IN29NYmpLcWVnbDFJNlFxd0VEMnltRXVOSUNTQTF5Wngy?=
 =?utf-8?B?cE5JRmhFSHhwakZOVWwwdVdOVlVNakl2ZUF2SWNOVzJEOFcyRjRyV243K2hJ?=
 =?utf-8?B?TWZ5R25rV3QvNGRqaSttclVJOEVHQStCZmdtdXNMaWFpa1R0VFVPd0dmK1NT?=
 =?utf-8?B?R0RXcWZJRk1vRWczQnlndmZ6bW9YcWNHby9SaWkzNjdtM2NRVXkxTVBvb1M2?=
 =?utf-8?B?Y20yaDV4KzIzM2p2THdPSHZVRmVDSHZYSzJjbVl2d0NxTFBmNy9HVE9PTEoy?=
 =?utf-8?B?UWc1NG84VmE5NkQ0azhlZWYrU2lLdjBqWi85dUI3aVVBTVM0WjhCckxRL2JZ?=
 =?utf-8?B?MUJCZTk3Nm1JdzNPaEo3SFVtS1VtUWdhNmd6eDJ4WG5CMVZrdHEyME5sTEpF?=
 =?utf-8?B?SXV3UjFkcVozYnczbjNlVWN4VTlEREsrV0xVdGRQV3hyNmZhS1FWT28rczkw?=
 =?utf-8?B?cmR4NmZoY3dXTDY4eHNER2hUWFc4VGZEU3hxaUVpOHpuQklMWndwOE5tb2F6?=
 =?utf-8?B?RXQxQmlSNjNYTkZwblpiNzVOQjFOMndNdGF0eUFTWmRZNkhPZkliTkVGSHVm?=
 =?utf-8?B?Ykc1MUhNcE9GSVdQVTFKOG1rbU5wQVdFQnliNE9ZK3ZUVUR3N2RmR2JFa3dm?=
 =?utf-8?B?NHcvakp5OHRTRDlPb21XTkIwc1JBMlkwOUVYd3VZc0JTV1hIMmlXZ0lZSjRt?=
 =?utf-8?B?eEk0RFVqSlNHTnhlY003aHMrWktVRlM2K3lCVUFsczVueDl4YVpUVkpWY0hN?=
 =?utf-8?Q?3EJXtgoZb9Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlVeURzRmZhdUpHODFtcjJRUld6bndzazNCaUpoSGpwU1RmcXNoZjFhT20v?=
 =?utf-8?B?QysvczFoVnp1eHdwR0dwWEdXS2pTVklyR3FoTk5rYXVpOU1iMzBKbE9hb2x4?=
 =?utf-8?B?OVYvWWJubTZyVStleHdLc3pkSWNtWmNqNnBma2tqT3VPNHpHSkpZQ1doK2lv?=
 =?utf-8?B?ak1Wdkd1LzZuclVRQzlKckRYRW9ZcTRNcFRJTkVPQ1pHZTJNMUFNcXNwNnlY?=
 =?utf-8?B?bE9GNnoxR2prczNFd3NYZk5LY0szUWFyM2hmM1FSNmxJVnliSUdUdzE1VVEw?=
 =?utf-8?B?QzFNVjRhazJnNXRkRU1TTGMxMnVYcS92ODNZdk1mbFA3d05Bb0MxNDZWR0VS?=
 =?utf-8?B?REhsamp0UC9uUmREcUZ2MDFjNjk0S0t6bFN2dVorbHZvV2tjSVMwSkFnRFJz?=
 =?utf-8?B?YWkyMkIxaGZMMDkwV01RUUsxZExROE9WcG9vMVcvdFdzVEJIYytKUlVKY0VK?=
 =?utf-8?B?OEVNNTFqdkh6RTFvSlJETkRVdzdqLzN3M0ZjY2VhRUlXM0NZUGgzT0NlNTNP?=
 =?utf-8?B?NEJjRTZVbTdnLzdJeXRtYmFDaGI1MGRLVVhhdkJ0dkV4cXJTZWNRK1NSU1Mv?=
 =?utf-8?B?QkU5K0d1dVcxSVRUZGhZK3F6SjE2YW9ic0tFdHpBcW5nbi9VeFBwenpZN1hm?=
 =?utf-8?B?bkNGVGh1Um5yMDZzM2k5T2ZGNzJ3RjZWWmRBdHg2QkZZZFNvV01tSjYvZms1?=
 =?utf-8?B?WktXaEl6b2hpSHpLZGdUVVpOKzNKdlpOVHJ6ak83enl2TDlsWmlkN3JxbGhz?=
 =?utf-8?B?R0oxVFRrdXoxK1RJUmpMRFRvSzEwVGxXZ1FIKzJLS3pyMkxWVTFiWDN4ZnI2?=
 =?utf-8?B?Q1QvdGpoaThQcWpmVmRycWRqbndmNklOaytDZXlCREF5ZXczb1JzUks0SXFH?=
 =?utf-8?B?dnBLUW83OFp2WE1HRkMrenBnN3JYVk55eUNEN0R1TDNhVS95MVpadGd3Z1Jo?=
 =?utf-8?B?eU9xdlZEMnB4UC9URFozMVVGaDBGRE5weTNnTVpiYVV2TThJWCs1SE9XeXVv?=
 =?utf-8?B?aGdWdmNub1cvQ1Fza0hnUWdhNzJ5bTNkSzJ0anlodTVsN2RwVzJzeC9aZzZn?=
 =?utf-8?B?VVhQNE1zZWFxSG1sTXlURDJIYnlKSGxlT1ppb0h6b3NTejZxSy94VlpSa1A0?=
 =?utf-8?B?blp4UzYya0xkaHFTaVNYQlJwd2NJOUZWMS9VSWM0NXpwbHVpdXpaemNrNWZm?=
 =?utf-8?B?MjVjbWNkZ1k3OThaZmp3Vmo0Q1l1OWJMUjdSQVZLaXU2SmtNRGZhTW9uclN5?=
 =?utf-8?B?dDZzbVJNRzFVUGc5VTVvb204ZGFsUVQ0bEpSa1NqblJiU0dZTEVKczkxRjdT?=
 =?utf-8?B?UGJ1cXVnbkdrSGZsOUlubEIxbC9JcHY5bnpGQXFYYjJEM2t5Wi83VGljZlp1?=
 =?utf-8?B?dTExQ3FvWXBPcU1zMzJCNzdXaDVXY2VIVUVUOHgxOGsxaGhTeHg4VmZrTnoy?=
 =?utf-8?B?YUl2WmZmSEgwR2VCUmVrUmR4a3RESHlsSXBGNmFyVXpmNFNnOWZLZFpyNkVl?=
 =?utf-8?B?R3VmRDJTL1NOWERXZGFsbm5KRzVsdHZMUmRxc1BRV29YM3JYV3JDOGN3VTJV?=
 =?utf-8?B?dVhtUXJlaGw4eGptZHpscTBCeXJFa0pXWDQ2WHhkVnlXL0hsNStqNUFXL3FY?=
 =?utf-8?B?R1BnbDROTm9uUGRpRTdXOTJIQnJVMitwSXVQRGZiamh3SlE2b1RaSUVhQlRE?=
 =?utf-8?B?a1VsMXZNS3ZHUGYrNmJRTjRiSDIrRVhWeW9nYjVIRE1uSll3YThjeFFLenNv?=
 =?utf-8?B?ME84YmtBMEQ3a1lNZ0toczEyYVBqeWk5YzhOMXNzK1BaTGRJbEVMR0lNdGJ2?=
 =?utf-8?B?SDNMNnRueGJXTE1QZktYdU0vVU50UGVJM1JwVmdKTVJCVEJ3RDNkKzZLZkVl?=
 =?utf-8?B?My9SRVNJWjZrM2ZFL01ZL0dBRkhHcjBSekpWU0RIQUllQnlzS1VHL0w1L0dZ?=
 =?utf-8?B?eDR4YTRLNUN6aitsQ1Z3bm0yTFFhODJ3VTJwbURuM20vMDJyU0Q3MWdoWUp5?=
 =?utf-8?B?Ky9VU0VYM0Jhd0lsdnpjYmxRYitFWlBhTEd6UWg1eHJpSDA5YlptajYwcUwr?=
 =?utf-8?B?RjRFRkVMOWhXbU5VWkt1UldXRE4rZ0dFSmc5WTdTampxNVpaNGQ1ZlZDeU1p?=
 =?utf-8?Q?xQcjX3FjpwAerqZq2cPHW0PxX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ee3e7e-601a-4b0f-f398-08dd8e0813fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 08:12:30.6193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4FAye+goqmzcfyD+gpeiUW3JJJLJkJFCvMbsygmHNzYnqAPqkbiN3xA8PaXTdrz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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



On 5/8/2025 10:39 AM, Samuel Zhang wrote:
> For virtual machine with vGPUs in SRIOV single device mode and XGMI
> is enabled, XGMI physical node ids may change when waking up from
> hiberation with different vGPU devices. So update XGMI info on resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..843a3b0a9a07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		r = adev->gfxhub.funcs->get_xgmi_info(adev);
>  		if (r)
>  			return r;
> +		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>  	}
>  
>  	/* enable PCIE atomic ops */
> @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
> +{
> +	int r;
> +
> +	/* Get xgmi info again for sriov to detect device changes */
> +	if (amdgpu_sriov_vf(adev) &&
> +	    !(adev->flags & AMD_IS_APU) &&
> +	    adev->gmc.xgmi.supported &&
> +	    !adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +		if (r)
> +			return r;
> +
> +		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +			adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +	}
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  		if (r)
>  			return r;
> +		r = amdgpu_device_update_xgmi_info(adev);
> +		if (r)
> +			return r;
>  	}
>  
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 32dabba4062f..1387901576f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -89,6 +89,7 @@ struct amdgpu_xgmi {
>  	u64 node_segment_size;
>  	/* physical node (0-3) */
>  	unsigned physical_node_id;
> +	unsigned prev_physical_node_id;
>  	/* number of nodes (0-4) */
>  	unsigned num_physical_nodes;
>  	/* gpu list in the same hive */
> @@ -101,6 +102,9 @@ struct amdgpu_xgmi {
>  	uint8_t max_width;
>  };
>  
> +#define amdgpu_xmgi_is_node_changed(adev) \

Typo - xgmi

> +	(adev->gmc.xgmi.prev_physical_node_id != adev->gmc.xgmi.physical_node_id)

Since prev_physical_node_id is updated only for VF, the check should be
there here as well.

Otherwise, you may have something like below in
amdgpu_device_update_xgmi_info()

amdgpu_xgmi.node_changed = false;
if (check_condition) {
	prev_node = adev->gmc.xgmi.physical_node_id;
	adev->gfxhub.funcs->get_xgmi_info(adev)
	amdgpu_xgmi.node_changed = (prev_node != adev->gmc.xgmi.physical_node_id);
}

To make it clearer -

Would still prefer to wrap under amdgpu_virt_migration_xyz() to make it
clear that this is done for node migration.

Ex:

bool amdgpu_virt_migration_detected()
{
	return amdgpu_xgmi.node_changed; // And any other combination checks
which could up in future.
}

The check needs to be done for any further changes down the series like

if (amdgpu_virt_migration_detected())
	psp_update_gpu_addresses();

Thanks,
Lijo

> +
>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
>  void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
>  int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..7c0ca2721eb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	if (amdgpu_xmgi_is_node_changed(adev)) {
> +		adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +		adev->vm_manager.vram_base_offset +=
> +			adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	}
> +
>  	/* If a reset is done for NPS mode switch, read the memory range
>  	 * information again.
>  	 */

