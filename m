Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE3CCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 13:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A935810E3CE;
	Tue, 28 Oct 2025 13:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FB6eBuAJ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6C610E3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 13:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqH8CNDSRYoopPDNH1ydcWAVhEFb1uDvAH22A43D8kcFuxsZJaVposgI8XncCNSLM0yJTHZi1Z/vm//6fbYNnrUjouxM48KCo6t1SAtTy2m5pDQ9dHhoDwDwpXrFF5lauZOJu+XSq1idj1r2iGgvKhELkd7Nsk+dR8lLFlb200HWFz2vWEily3xrAS3AzDISdzUDLjXz5u20c/hhqEaF9uZUbRrb0KVp2GtW09f/Dm5VDVIbQrvacfXEOjrTYl698dJXxb7zJ0qYj9w7bjnRM4dGbZV/KgtGkYtU/4oe5QvjAu1xGG7LLWbpWjhSaOyPYbxTfiXlu/XkLUlf/4bIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFSJWTPgQzJdizAK5LxKyVdkiJWxfmiDhKb4Ha3zS+s=;
 b=GttK3GB+K9m2BFB6lG1jFQjUp8LuK+vcPmXesGLBQVuv44OtnNpwDCfaZqo9DqGwZYjfWHqj1QlBLCobunX9dboWlcXxqZsyND6K1C0lj0NUxeTdA0dttZVil2teesxFECvIEzu5IkeARnhTy9ZIWHkRZskrFn+FKnT8N2uo8lZzmAAukY77e0NwfQ4cUB1s92GuoVJZ+vX7/AendKaTFgDRQdISuCFO+VIKdhChFXhlU3gT/Zfejf/LZtFAcgZPtswuGT8+lt2PtXAbgL6y6JUefDgj4CtO+xGTdj+108jfNQLjZiec8B5Qi+0qq+2U4IYnHJXSAuuKZJteftxmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFSJWTPgQzJdizAK5LxKyVdkiJWxfmiDhKb4Ha3zS+s=;
 b=FB6eBuAJSQd3ye0o4+kwkexgSmE+w00iwnd2gsV1cjj6VKmhuwiG02FkWBA6w5TxOBF1TUOlcxV07JEvMXKEhZgtCw8dUPZt5A0znfdowgiC/2g0iK4Q6XsfPbOmTW5AQbFFyDUvsBe/Bj3mVXsQQOkGvovUK1kuaGHzPohObVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 13:02:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 13:02:06 +0000
Message-ID: <fdae117b-c871-4863-a662-3db8dd9a55ae@amd.com>
Date: Tue, 28 Oct 2025 14:01:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251020194631.102260-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:408:ee::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f0af4c-c65d-4d14-7072-08de16223218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3hXRHhBdUphb0pVNTRDT0lVRk5XaXIrWDVaQzUvNVZET0ZNRjVrNnJNYzNp?=
 =?utf-8?B?SWZEKzFFd1hYdGQ5YzVGd0ZLYkh4aW1JUm1qQnp1YmZtU09ieWsyYzlKcVZH?=
 =?utf-8?B?QTUxYVFOZmJMNndFQmdmV0I3RTdjQmpLaGR4Ykl3QnRnbVcwSXRVcW5tOE5w?=
 =?utf-8?B?RTdRSzM0c1RjbmdsLzY5d29NRGFYc204WXY3YmUyQlBwRWNnMzl5MTBEUGQ1?=
 =?utf-8?B?anM4ekp4NlFzaXpranErdW5ITmlDY2pHYVJvUnJnSUsyeGFNbFlkY1M5VjNm?=
 =?utf-8?B?RTNva0hLYW5kekszUGIzNG1ldkhWcjJ3Vmx6UVBYdmZKM1ptS3UvcVE2NmpU?=
 =?utf-8?B?UzBhS0FwWndNeDAvN2UrSGQ3L1oyRzVHRTNhVE9SN0QxTWNhS0VKNXljRW5E?=
 =?utf-8?B?NWROcW04L0dCZ052TDgxZWVjdHZ6MThhUzNZZEVCdWVCT0Zkd3A4R2VkTGJB?=
 =?utf-8?B?NEsrWDlNMXBrcWptczUwRkZQcE0zSktQVm1xZkp0M25nN2xjN0h2dEFSSE1K?=
 =?utf-8?B?TWpWQkdyOVNvZHM5Znl2YVRlN3NzYUlkclQybmVNYjUvSm0rdmN2WW9qSC9n?=
 =?utf-8?B?SU5PRjVLUnljb04rMUdUYlFhbE5EYlZYOWdEUU56RUMvZ01IaHRvdEYrQzE0?=
 =?utf-8?B?ZERsQ3lja3EyaWdlcldpY2pmTEZ2cUlnQ3ZHMy83djdONTZ3V0U3ckErTHZk?=
 =?utf-8?B?aVMwejRaRmxxbDNlWnpUcnd6aEdmRE9PNThNdGRMajFuUUxRK2F2bVFzZVBy?=
 =?utf-8?B?dGs3YUtpNnR1TEx6NmFyVWY1eVpzVUZtRU5uWUVLMGxlYlRqdG93L1lQL0Rs?=
 =?utf-8?B?d041QllwcWFQanhDZTEzVWdyUTFYWmRZQVYrVDFxS2pwYzdXMThtR01waVcz?=
 =?utf-8?B?ZWRhY093akFncXZuNVRMT21OUnU3ZEN0TWVQcWhwellwQmUrQ2Y3YzNXMi82?=
 =?utf-8?B?WkZhaEloU2ZKVzBRMDVhL1pneDVSOU5rTWI0OXl3K1M3VnFmUW1SNjhuYkZt?=
 =?utf-8?B?UFpkM20xa2luVVMzeit5amJLU2xSYUJVZDYrcGxzNjFCeWpnd0VZM05WZ0FH?=
 =?utf-8?B?RmF2RmRSYy96dTk3RkhGbHpZM1pxUzdwVzliN1JZSmtPeFZySXVoM3FwY3Mz?=
 =?utf-8?B?KzlJYytHUHpia0ROR3FIbUw0aE1sN1IrbmZJZnZSRjc0RUNTU1RPK01xK1Uz?=
 =?utf-8?B?clZyUVllRWJnZndFSWZCNXpwZ3pGUUVpSURxTkxGcUpqblNueklhVFJQKzlj?=
 =?utf-8?B?c3lWNGRCSndWdWliK2lSNFo5aE54M2lhM0dyNFJ4TE8xWkxRL3hyVjBaUUV4?=
 =?utf-8?B?YUp6VjdOUjRqcDZhY1JQQ243RUFiSkU0UEhtRWR6WEtabnN4NlpqcGFiSjds?=
 =?utf-8?B?RHBua2JTb1VOZmhuY0ROTXp1TlZtaUF2amloaDdiODRQaTRrbkd0QWVNSjJo?=
 =?utf-8?B?c1lZRldYeENHN0ZCOWdmcUwxMUN1TG5yZEZadFhnRC9wT2pqWjZiNjdtR01E?=
 =?utf-8?B?NW1hOEhxRDlxZUI0Q0IwTzZmMlZuL2pSS0llbVdFNVp5RTlYcW1GaHBZR1h4?=
 =?utf-8?B?YVpPT2Z4Znd4S2g2RDEwT1NMQ0NnejhoREVSVXVldVBHVFlqdGFNZVN6VnZh?=
 =?utf-8?B?K1NjVHRVVjVQYklWWFlxcTF6QlRSdHptSVJzTklzNXRoMWxibTEvOTRmeGx6?=
 =?utf-8?B?YS91Z2dzbkxOMUtQU3h4VUlyclhDUFdPZVVsbWxkT3E3QTZMczZwWWpoMUJK?=
 =?utf-8?B?V1B2TEsvb29FMGlWZU1aMXZDVDl3Sk9RMEliVUI2d1FyNU1UdDBLNFFYQWVn?=
 =?utf-8?B?dVNiVk9kT2M0WkxmWUp2dkxNNHNZZHI3RysyalZDLzIzdDFVYTRPcjQ4VXA2?=
 =?utf-8?B?eHVNRzloSktNcVdQWmxaR2dkSWF6blhxSE1Xa3VVU0lGT0R3cHZEL0ZJMkpt?=
 =?utf-8?Q?WawiSUTX5YYZEpn/TKdEdtAkYmmeGPh4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5VSkdrWjh4RWRFTjdnRXIxM213VW14MXQ1aitvdXpDMjdTVTVDbXZ1dUtR?=
 =?utf-8?B?Z2dLc3JKN2ZMamhhc1M5a2gyaXFFL2czWmcrMkVvN0t5QzJETlB4Z3BPV1A2?=
 =?utf-8?B?UlhTV3gvUWdoM3FtU2lPY0Z4OEdTTGF2MGEzcExNV2s5WDhXSUEvMldYblZG?=
 =?utf-8?B?OHgwek53ODJNamJUQ3hQT05BVzhPRVVZUHFmTWJLMmhsK3lXT2piajFUaUFk?=
 =?utf-8?B?SHE0UjNaN2Q5QnJpcVJxTGFEVmQwQWZnaEVXMlFtSGxOVHQ2Tnpnd3NPVnZG?=
 =?utf-8?B?QTY4SGg3cStXNkthRXJ6WkE3YUVwcjAveXJyZkpDL0FaYjMrMk9ZRnluZnd2?=
 =?utf-8?B?ckM1b3BFbGxpTEJaYjVRWlA4RXB1NzdQZndJMk8rQzdnVFlXalcrWDlmdzhx?=
 =?utf-8?B?VC9PZk1jdEFQSzlZVE54TGhPYmlOV0xZNHVmMTZpL3AvYWV5TGx5SUhxZUE4?=
 =?utf-8?B?OFFEMll3MzM4Rm5tT242UVk4VStORERlVE0vRm5yRi9Vb0lGQjdLWU1jQ1c0?=
 =?utf-8?B?Q1Rid0N1UFZjVGczOG56aTI5QUxpRFJYbWZENVJvR3FrMTFRVm40NStJUHJ3?=
 =?utf-8?B?RkJjODZ3NXU2Y2VqQkcxbDl5MnFqclBTZndydHVOWHQ3ZFV3M2lWci9pY0tM?=
 =?utf-8?B?OHV3OVhLSG1mYVdqWWtmTHE1ZHRmSXVCQ0l2d1RNdFUvOUsrYUpHZXZEUXdQ?=
 =?utf-8?B?UVQ0a2E2K1B5bjNodDNSZWZOUW11ODhtUzJMbHFCYWgxbkpWWWNhamNQd2dr?=
 =?utf-8?B?VXppUUlGZGFkMGpTUW9ZOWFEc29wQkNNU2MzNUd1L0pmbUs1UnB2S0FHVnlv?=
 =?utf-8?B?Q2xublF6eUNUTFVDVytFTlJzdmlGYXhaSWxJcEx1WXlBVFN1a01kSkVFVmk4?=
 =?utf-8?B?WTAzV3o5b1VXdzNKSzdhRktYMXBmaW42Z1MzYUErMzlDOVREK1dOSXFkN3Z1?=
 =?utf-8?B?UmRDR0YwRTcrRkpHbmVUOHNSK2QxVWxVQXdQQjBKYTdicUpMYXV1UmV3a29u?=
 =?utf-8?B?M0ZKZW10RzFoeWdUWUZhRXJyT3dDS043L2VZSDllS1pIay9HSlVvYWRtTU5V?=
 =?utf-8?B?M0dZVXQzM1RGSjZmbmJmNUhueEdteThoL3ZiSDNKS0ozOUMzNk1NeFJ0UVFi?=
 =?utf-8?B?eENpYUJIcGJkVE93ZHJVNEJCZ3RHT0liRTV2b20xS3lyakRiSTRXOGM2V1Z3?=
 =?utf-8?B?MEl0ZERTdjd2ckxkdkJaK1F4YXllbTBubXhMS0YvR1QyNGZaQWVXcFR0U0Nr?=
 =?utf-8?B?aEU4L0ZrQ1g4VkE4ZVhWTlFnSjFld1pqRk5EZ0hqSWJ5RVl2aVNQdXRmLzFO?=
 =?utf-8?B?WlZ5MWVoR0ttV2dzNnJpbEJGNFdFSjlxdWE1eGlFZG01Nm43NG1wNFNpckZ2?=
 =?utf-8?B?VkplVUZkaDVSWTF3UmtEcWlrR1ozbGNpUzV3c0hyMU5yMmNpQzNEU1U2TnV5?=
 =?utf-8?B?MTVHS3pjMzd3NmlCaWRUOWlrNWdlTGZtWWM5N3JrQU4wWXBsdDBwTGNxM243?=
 =?utf-8?B?M0dIOVRiR2pqRkZOWmMvejd0Rk1wWWJkMncvc0h1dmJmYldWYWdjRDF3ZlQ3?=
 =?utf-8?B?dlBMRGNHOFprdDY0eGlhSVBoTFBKSmhuZ1pXb2lkRHd1cUVyK0Vjak9EamhY?=
 =?utf-8?B?YlJHWlN4Rmd0N3RGM2srL3hndndrQ21zWHpCeEJueVlXUE1KYmRPdjMzV3FP?=
 =?utf-8?B?N3JPOHMvbE1wNC9xU2txdWJ0amp6UWtzNUxJKzF6RzNGLzNDeVp3V05DNk1z?=
 =?utf-8?B?Y3RVMlMyV3d4bGdCaDVCRGFFQ25ldUovdE5BVmVuM1ZYQ1lEcWR5NTJkV1hq?=
 =?utf-8?B?U2JGQ252VkJaYi9pTkpZdDF4SnJQeG1YRzhkRmwxMFBuUUhFek1VcGp2T3Vj?=
 =?utf-8?B?YWZSL1h2UnVJdmhybW9RbkJ3dUdFa3VSSFpBTjlzOXZQbDkvR0FIZEsvMWx3?=
 =?utf-8?B?UEc5VGhad3pCQVo1YnBqU1EzVXVrL0FMdlFFUU5LeE1EUytYZ0JHTTM0c2Fk?=
 =?utf-8?B?ZVFCN2RSQVJIUWR1d3VGd21EK2I3QVo1QSs1ZlhrTWRLRVYxUE5KNUtNRVF5?=
 =?utf-8?B?dVZHRHdBTkhycGtjVlI3MzZabjhydThBK3Z6N3B3Q2FvV2dMcGd1VnJtYVEw?=
 =?utf-8?Q?aCamaWuF/NgFaOlik8So76SV8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f0af4c-c65d-4d14-7072-08de16223218
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:02:06.1110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyziVlo9qHBcPqSL5HZailp3/pqR8wznBe61bPd5ddf+VuSewNFV9GJi364p1R7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345
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

On 10/20/25 21:38, Rodrigo Siqueira wrote:
> Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 5ec5c3ff22bb..29de8dbe2917 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -75,8 +75,16 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
>   * @ring: amdgpu_ring structure holding ring information
>   * @ndw: number of dwords to allocate in the ring buffer
>   *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * Returns 0 on success, error on failure.
> + * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When

I would ditch the "it works on all ASICs". That's something we did for radeon because we didn't had the seperation between backend (ASIC dependent) and frontend (ASIC independent code).

You could maybe write "applicable" or "used on all ASICs".

> + * inspecting the code, you may encounter places where this function is invoked
> + * like this: amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are integer
> + * numbers. The idea of using each integer addition instead of the final result
> + * is to explicitly indicate each block of operation that will be inserted into
> + * the ring.

That still sounds like overkill to me.

Maybe instead write something like "The number of dwords should be the sum of all commands written to the ring".

Regards,
Christian.


> + *
> + * Returns:
> + * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
> + * maximum dword allowed for one submission.
>   */
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  {
> @@ -122,7 +130,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
>  		ring->funcs->begin_use(ring);
>  }
>  
> -/** amdgpu_ring_insert_nop - insert NOP packets
> +/**
> + * amdgpu_ring_insert_nop - insert NOP packets
>   *
>   * @ring: amdgpu_ring structure holding ring information
>   * @count: the number of NOP packets to insert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 87b962df5460..e83589619a92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
>  #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>  #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>  #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +
> +/* Ensure the execution in case of preemption or reset */
>  #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>  
>  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)

