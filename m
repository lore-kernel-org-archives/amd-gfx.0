Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA4C36014
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 10:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701EB10E55E;
	Tue,  1 Apr 2025 10:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBjBac2x";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8925310E032
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 10:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzrusQiM3n2lEF74b2t1iSeAjm4/iTweZj0lKyOjeUxKiHG/9zYd4c+52OxX9QHnJuWGHnxknomGADlvjkmO0KzDzp+pGCydEUhct6UsB6O/eFgzaN3si6BL+jMUedE7xIddcTfRa6Hyh4fayAsKXxbFQzTAiiNPKakhwbuSC/Z4rEdhfsrvI4xUOfIMOXspl3Hu0+PnIJYMQTMOJi3FVV25U6UeISLnO+y7Rj4M2q0r0BXQBwdrUYqPFOshZotT6ag2aN5toDBBkyzANALFaiie0LMYa7pIVQTAIGs5N96+JaMjOAXFPHFGjC31PspVz+Ga/kTkHWxUqY8AF6RCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaYB3ZY5mtD45FolkiMz5Pu8/hKobuZpUKyx+fw+BoY=;
 b=G0w/a4PePy4dh2ua9ELlR5i1Nm0w7/NwPBMNbOJpzgb/XxtIhOXWfGn0MYuxyO7tuD0LdKPAwUsFQ//kMYbaKw0g8n4FnZlr9Np6KGPPrLSNdyt+IlvO4/NBvp97Mn8DgjHs/2n6QSlqh2GYlPcPEj5tPydKDWsV+Sop/orBtgNN/gTLeGcwlCUbsafoWCDicxCv/e3oxzmSfGlSL8w94izXucaMu25tFfWusiXbIFufRFTQUy5C2YPBEnnjgaBEqSI2YWIv+o8uK9DRe33DFuC4Ih42aTPlGZf0edi53xZ1Og4uVGHC0+lTvoYAWsCizZ5RRKFuVye0irfjgnC3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaYB3ZY5mtD45FolkiMz5Pu8/hKobuZpUKyx+fw+BoY=;
 b=ZBjBac2xlS80fTLtdJ5xP5ZvrLIdvt9nR3p/b8VRS8BZ2w3TN63sIIaoCHzMslRQUHVpgtzmOBs0uWxlk+H7/Rsx/r9PHT7wvLs01N35sLcbdlfcwO/wfseUST2F4b2BUvl1RVOO39ttiF5lKzyoSaNnB5g82JjG8+d4NSTCaOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 10:32:21 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 10:32:21 +0000
Message-ID: <7a95710e-e761-4650-bd4d-f6e0282ecfae@amd.com>
Date: Tue, 1 Apr 2025 16:02:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered
 cleaner shaders
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250331130152.2342-1-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250331130152.2342-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::21) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: c94fbea0-3abb-460a-5a55-08dd71087be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2FnczE0M09wdHBIZUpPUWVScWl4MFpRNm1Ia081K0pKVVpBcElLeWRLS0tk?=
 =?utf-8?B?cXpXVW95b2w3Qm5LNzE0N3RWZjJZUGJseURqYjVTcmluZzdTZlc1dHF3WWNZ?=
 =?utf-8?B?d1VIMXpsaWdwVlZKcU50bjJVMFFaYlNRMm9YNlczUE96a3dEMlNxWGY5OWxT?=
 =?utf-8?B?ZFBrNHd6M05vVVdNeHB3RXhKRWhnZ2w0NzdydkowYWdPZWdrWGFRaTFPaGNy?=
 =?utf-8?B?ZlhhZE1nWFlwY1VmdjQ5d0pHa05YRWROd2VBRCtnWjkyTThSSG81L1BMR3dX?=
 =?utf-8?B?blJiYXpKb3BwVW8yWGdGNEU1Q2ZJQ3NUYWprcHBZU2s0T0NseWNCazI4a0VQ?=
 =?utf-8?B?bEU0VmpjT0FzUW1rUlhKL1dMT0ZPeEJvUVdreW1yQTF0QTd6TnBncFAwY1ZE?=
 =?utf-8?B?N3U0UjFSemdzNXhzdUNpQ0dTbEY3OWZ5djRUYXlSSTdQNHZHQStiekRuZzY3?=
 =?utf-8?B?dVI4UHIvZVk0QUlJN1JhcTNZMmF2UkF3WGlTUnI3cXYwOHBzNk56enhuNzN1?=
 =?utf-8?B?akhyUit1bTdnaFA2VldxMmtLZ2c5bFREY0lZaTRieHVJVXVNRjRlbS91cTFa?=
 =?utf-8?B?N3pubWxqVGlOYWdoem5CNzRwN0daSzc2SmxmdUVzSTJEbFBBczZoZHp4dlZm?=
 =?utf-8?B?d1ZNdUYydFNTazFoWkc5bEM1Mms1R0NLWFZiMW9EWUNXc2RLOVpDZGRGc2hN?=
 =?utf-8?B?RnVBUXVTVEloT1BmSjJSRFM3enB6Rm0xaVFnbVM4NWkxb3lhblJFZHVveDY5?=
 =?utf-8?B?SUdTZ3VDR2ZJNUdJeFBoWVd3M2xONVNQeWxuYmM4TnJ4RWZ2OTAzeXU0bVlJ?=
 =?utf-8?B?QTk2T21ZUnlnV2g3aGtOTWZQQi96VXlQSEpUcy9XM2tZWHdlcjk5dWtnbFVZ?=
 =?utf-8?B?SWN6ZmZ5Mk5XdmRoMUs2cFZmbUlZS2JtTXVobk0zSGxTY3VXSGFuR1RQNTRT?=
 =?utf-8?B?elNLSVFNNlRUZ1A1VzlUVStXa29obmpMUG53d0VCUmhrUGhRREM2bEpEdy9P?=
 =?utf-8?B?bzJLMlhtQXltMHlBdmFnWkhlaUxFNWhQNzBBQ2owSHFwMWhwTmdOODQ5cXZp?=
 =?utf-8?B?YmE1STJkM3FYWFQxRStYV01FWFl1VFlObmJ6MERMWkhoR3VlNzBFcUJhaTU2?=
 =?utf-8?B?aUYzM3dZaUpmc1JtRlVlWTZsSkVsT3J5UEJBb3ducW1KWmphTDdjM1FsM21k?=
 =?utf-8?B?UUNkV0ZlSFFrcWdXaXR3a3lJRHJIME1mai9wMUZvVTgvcTUydUhiYUplOWN5?=
 =?utf-8?B?Tm1xOHF1SjdWLzZpaWZXSzlEZVV2VjlLY0daVEdaNmxhVkJRNDBDS1VJdDdr?=
 =?utf-8?B?b0dmRE5mVS8yMDJ1c0F4NE0yWGlCcS94dzZiQXd3dFJaMy9PS3VsK2JkbjVa?=
 =?utf-8?B?b015MGxEcllOOGJOVmh5RzM4Qm9vcTIycXdXWG4vVXZtdUFubWNkUnpMZ21T?=
 =?utf-8?B?bUVqWjEwTDRXUWRzU0NHVFBmQkFEcmg2ZC9HN2gxYkI5cG5kRDVOakdldzF2?=
 =?utf-8?B?N21VMW5qL0pTRlAvVlpYaklTeTJXMzg0bEtFMVhvNjFWWFdVK1pVQXFpa2tp?=
 =?utf-8?B?WUhONlBWOUh3am5sOGgycWcweGlXNGxJc01YVTdQWlp3ZTd2elZTVlJ1WGdo?=
 =?utf-8?B?bm9Pc3BBci9XcUVLek9oWC9tVWthTkFtL0tTb0FMZjFlR0dZT1Q5QWpadHds?=
 =?utf-8?B?aHJ3ZE1NWkM3a1BKU0VDdmdEQlZQcHliWlpnQlo1R0lPZEI0ZG1NQTFUR0Vp?=
 =?utf-8?B?WGVYK0RKMTJyWHhKRVhmcFRibnMrb1VKMjlDTFBqWmM4aUxVR010alhUeEVJ?=
 =?utf-8?B?N0l5bG9vUGdaZE95dzloOSsvSHduWUdJd2F6TVRRR0FPK0dVa2UwTGRsYlFF?=
 =?utf-8?Q?i+LFNUN3Htyji?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGMydkxIbHJJN1JKUjI4RWRRZ1ZMV0gvZkkwNkdLNkx0M0NmbDZlQUhLRUlQ?=
 =?utf-8?B?WTFoRnNEMERrTlV6MnlxMnRnS28rQXlkZ2ozSHQxY0phdFRxc3BGcy82dld2?=
 =?utf-8?B?R0VYY1pUZTN0YlYxMUIzajRRR1k0cHVwOElvNm5GWCtOdndQVUYzNE1sSURz?=
 =?utf-8?B?UWtFYUZwcTVLUUVNdkNpTEl0enpMeVdNcDlFZXZyM0NqdytYNGttUXZDVHla?=
 =?utf-8?B?UE1hQWJwaHVyVzViSkFhQm5UTmV4Y1FSK2ZCU1RLTEUwU2JUME40SjVPOFVP?=
 =?utf-8?B?aWVQZC9VUnZ2ZlJrdmk0a0Z0RVdCT25LckhBNVJRWjU2MnJ4NnRGMlIvbmNJ?=
 =?utf-8?B?ZXpRUVpyV3ZGcDNkd0dlQ0tWYkdxS2JjTk9tekJGTnpmR1A4dStpZFhpSTRs?=
 =?utf-8?B?WndjaVhsQzhaT1huMHJQR0FNeTRLTUtWdy9TcXhDQTRKMkM1TEpGbEJORklL?=
 =?utf-8?B?SXVyWHFJbjBSWDdNMyszaEVTTm9aUG5mNEFwTG0xUmRoMDNZOXdQeUNYWTJD?=
 =?utf-8?B?UjVjRFN1S0g1SDNXdWQ0YS9BY3E4d2VHNXNxbnNPeWlPQW1rc1R3dWFCTmJo?=
 =?utf-8?B?WUIyRmVwQU9UVEhmcmY3Wmt4RDgyNzZuTk1WS2hyMHBNWlk4RmlpSU5ITDBF?=
 =?utf-8?B?dUMyTFlSaEVibGlMMmNuRVpwbXdUMFAwUVlVbmV2U1ZoSGFIei9vcVZ3Q1ls?=
 =?utf-8?B?WkU0aUtFNkdoMjZMbXJwOVRIbzlCamNmNFVqbUk0bEdZSndqWXpjcURXZXpM?=
 =?utf-8?B?NEVqdENWUVA3NkU4YmdGYnYzVmFsME5jU3dhVDFKLytSTm9VMnF6YThSaW9x?=
 =?utf-8?B?dUkxejNxdlc5cnJvWE1kakNZcWdoVE5RODV1VVZlK05MY0c3RVU2THdxTEhY?=
 =?utf-8?B?NDVYYjlhVVBaWE9DYU0wYWNoaXdBVm9NVVNJcHRhc0JhNmlPZFRhR09QR2I5?=
 =?utf-8?B?YXVlTGkrRHVteStxU0ErS3JqVGRXZFZZMmlSUGtCRXg4SnRaNVNuUWdPaVp6?=
 =?utf-8?B?Q3Q4czBKQ3R2djh6a0cwRVZOWjZ3TTdHTFpReThheUpXelY1eW80bktXMnNX?=
 =?utf-8?B?ZVJFeHRyTXRUNEprbUhRZG5XbDdhVWpvOFV4QW5mYWRNYUltRU5kYUx6bW8z?=
 =?utf-8?B?SDB6WUVXRzhBWlRjeElpUXdCVWZZRU5QUVJ4UkM0OXFwdXZKQXhwR3hPNHAw?=
 =?utf-8?B?MGE4cEpiMHMvNGZodjkyMk9FRnpsL256c1dEY1RQSFl6eXc5RU1vMEluT1ox?=
 =?utf-8?B?bitCQ3N2MXBLU04xSFlibHRncFRjZ0FCN1NUbDVWNkZPd0c5UVB6TGUwaTB1?=
 =?utf-8?B?SWFWNjRxb1pDSXRDYzZKMi8yNlpwYmJ1WlF6OG1UTXUzTDViVVUzS05qV1hK?=
 =?utf-8?B?cHhJaHp4c0h6TDhqeHN4OE1DQm9yMVNRYjc3SklaRjhVZmlMelhkZnlQa2VP?=
 =?utf-8?B?c0FUM1NVZG5ERWdiYkJ6dmxWdUJ3QjlNeCtQNDdYYndqdXRTQ1lMdXZOTUtz?=
 =?utf-8?B?cGZNN1RkUG5TWkppeSsxeVF4U2JTd2FOVmdKS0psejVXNnBDcUp2ZVlvK2Vn?=
 =?utf-8?B?ZmF6RVNqMlBNOVJicVZRRVl3V1E0L25aQTNtVHFIR28ydS9JTnVHaG9uNDgx?=
 =?utf-8?B?WXl1cUQ5SWVoaGE0SW9lblJYOVd2MmlleUVSKytCMTJiU1RnSnlCWVN4NVha?=
 =?utf-8?B?K1ZSZEVJUEdhZVBJTE1kMlJEVXZqWDR4dXA1TkRzMDExbHlHOEx6cUV3dHFB?=
 =?utf-8?B?R09vbXBoWWU0YklHNEVGZStMOGNtN3lzOTJNbDRJbnhaQUdPRFhRMDkwdTNl?=
 =?utf-8?B?ZlpEamNkS1RNS2NvWWdMMy9GYmFOaGNoa044cFBBVGE5citNdjV2clRlWUJV?=
 =?utf-8?B?M3F5cDdMbmwxTmVzZWRsZDE3STVVZytTTkYrQjdTSkM3azhIVnJ0M3J0eS80?=
 =?utf-8?B?Y04vYldQMWkvY2JsK1ZpSEc1TklHY3lYekdXWmVhN2VkZGJVc2pZcEJxNkx3?=
 =?utf-8?B?Y0ZnSWE3dW13akVPRDlJcEdIYnZocTRoL042VzdOd0xEM3l0Z3ZFQmVFRHNq?=
 =?utf-8?B?RWZ0Z3Y1elg1NVhpam9aTUk3UVZHaFJtcmJXRnZ3UE1NN0M5KzEvT0ZkZXVG?=
 =?utf-8?Q?4RnyT42t+jUw8oIA7cz7kkBc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94fbea0-3abb-460a-5a55-08dd71087be5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 10:32:21.2534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkSm/beO4xzwQM+3hSG4exvgmv+A4eOX8blW0nwssGcUN3iFE7b+Fw1YWrOWgO979kZrTxDiI2/FOJszf4nuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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


On 3/31/2025 6:31 PM, Christian König wrote:
> Otherwise triggering sysfs multiple times without other submissions in
> between only runs the shader once.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f64675b2ab75..9d81eeef61e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1439,6 +1439,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   	struct drm_gpu_scheduler *sched = &ring->sched;
>   	struct drm_sched_entity entity;
> +	static atomic_t counter;
>   	struct dma_fence *f;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> @@ -1452,9 +1453,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   		goto err;
>   	}
>   
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
> -				     64, 0,
> -				     &job);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &entity,
> +				     (void *)(long)atomic_inc_return(&counter),
> +				     64, 0, &job);

Hi Christian,

Should we need to  implement guards or checks to ensure that the counter 
does not excessively increment or reach an undesirable state. or 
resetting of the counter may be necessary?

Best regards,
Srini

>   	if (r)
>   		goto err;
>   
