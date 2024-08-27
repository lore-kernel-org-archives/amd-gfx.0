Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D6DC52D6F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 06:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756CA10E02A;
	Tue, 27 Aug 2024 06:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3tXiEWHt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA9010E02A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 06:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDGEcUGzPBL1G6ViUlj6PhoNU0mhFtyawB1CVmnmZd8qyM6ulGWzCue8JEHv9riva1T9uS4apy0g97BPo4i7hp2Bmx4CDmCqxgo3/z014DzDkWGUsNOAryzXvwW7j/i/hw7SSMOcFuatsv2gMpgrQ12ft7ZFLSEnXQtgaeYDiEixjB7z3eMmzJfUpa9DY7PgsMGG/Qvi/CyqP2M1iTxWbJOs+2l34EFQ08UQyEldqXmQh1bYhCftKatBXbc00JiAxuI3ZkCWofYvkuB69RZ9p8jL0GFEoZXaqwFtAbcV9vS2xB6RhCCXH+VHSqenjFiJ/4fTLh+arrHginrgbXiFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPqcOyrktXHWEMjecRi5QTYzsCBExLh2Id11ZJ7GCXQ=;
 b=wcqSedeUWEqllPn98N/1kVE/vfqEteRK07ZDZu+HjRjtSdYcpJbAhr0RHjHwg4frrTJAL2dbgfqxTJg2uM9KT8OktFJma/PCqvxgRs6wykalcpuMVAHMU1PmYXZFoDPnH19ePxyz6jpXvdBkmBKz07QlTueFe4rsPzMX4mVVJ7akqHRjgSl6Kj5S3Dny/A+Jb9PtsAE5RG5dxHgy9l/WSEpej5wmOKC62ioaQZRee76LVzhv/zEip422km4LD5HZV0mVJSTjgJ3RUViUqwijQ/X/Bcx3qJsUmrtAJ5ZZnPCQTSlz9P+zMHryQf7QKACMHxjtXhW5PoCeBB/qyr6eQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPqcOyrktXHWEMjecRi5QTYzsCBExLh2Id11ZJ7GCXQ=;
 b=3tXiEWHtlDnqx6PE5w5K+q6KCv0T/F05lAnQWH2TMl2YvTZeE8Cd/VRrJknOUP/DWSAaiIns9LoRnXOSjRGFEI+LVsvszS4MgtaOkm85iX9xQbueYniiYv8B+1G0avGsZnx8noG1bjy4ZEGiw8rlXPTr1oNIS9MAQKUVwiPowgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:07:36 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 06:07:36 +0000
Message-ID: <b6778f7e-5b40-409e-a37e-f8bd4e21e1bb@amd.com>
Date: Tue, 27 Aug 2024 11:37:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: return early in preempt_ib()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240815170030.2582607-1-alexander.deucher@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240815170030.2582607-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: f19fcd13-2e5b-4801-86d5-08dcc65e8c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGdXeFVuSGJMRmh1V1Y1TXZGZkFrRnlBSTYrN1FFWHlSSzlCMFJrM3puRzQz?=
 =?utf-8?B?YUV6Y1JlanRkS0ZMLzZjMWorL3RsMll0MkdZWFQrMmtxWWQvdDVpNE9uYUVl?=
 =?utf-8?B?a0tEUU1pOFp5T05kS2tnRCtkN1AxdWFUTWZyN3c3ODFkenR3WnlwVFNoMGNK?=
 =?utf-8?B?WS9OMTMwaFNrNlJPVi9CeDRqdmtkbUs5NlZWTHBlN1BOS0JiUHo5NHJ0Y0ZJ?=
 =?utf-8?B?VzgwNWh4OEVFVFJ1RFUyZld5djV0TUQ4SWpxYmF1NmFYdURKdU51WGVHWS9Z?=
 =?utf-8?B?WTNRdkxoUVlaR24reUE2OG5TczNoQlRMSFgyVEdEV0ZYQzNQUXArQk9tZy8w?=
 =?utf-8?B?S2JhdnZyT1FVWFY5TXZHWUFqbkZ0NWdYSnUrbVJ2U3JXbHdOcElxQVZGbDhZ?=
 =?utf-8?B?OUg3R0RXVksrRnIwZWtodjNLMkhaditRellCZmpONGJzdUIyQzBCb1ZYbFBQ?=
 =?utf-8?B?WlY0M3JSOHY1TmtDUUE1dlFub0E3Tk1DdEdRTWRBT3Y4OSs3YnhieHViVitK?=
 =?utf-8?B?d1dVSmlGbjYyK2dSM1BtTndodVJlWnRXc1JYZ2FYdjFaNHd6bUc5dkhNbnpV?=
 =?utf-8?B?NmtuVWlSRml0dmJoTXJsUDQ1YW9zZmZTUE9Id2FQTzYrMEw1anZBVlVRYUZs?=
 =?utf-8?B?OUltV3lYZHBvbGJsTU5Ed3dqNkhDb0h3aTQ1bWJEK1VrTVlsaTZLVFA4dEhR?=
 =?utf-8?B?UDB4TWtYbFp1Szl3bUFmRy9wVkVnS2JEZHY1R1BjVFIwM2xxM2RxeWhKV0Z5?=
 =?utf-8?B?TlVzNzJHcGt2R0ZoTHpvdjREeWFlNVY1QnZhNGRXYW5tbGk0OS9QUWZlejkx?=
 =?utf-8?B?a1FNNkw3S2ZWY0lSMFR0QXp4aVNLR0pXczRRd25FMEpZcy9wWUVKZDJtWmRw?=
 =?utf-8?B?eHRMLzlWVk1qcFBWaDVhTjRNbnZvUWU5WDNaQld1RHdNQnBhK090RzVucExX?=
 =?utf-8?B?eDJQdkNFNDQyR2E5K2VHSkdDdVZYTGFXUGh6cG00R1FzSFpwKzdyelZWL0xU?=
 =?utf-8?B?L1gzT3lXaUJoZkNGZXZLajVqbVNyVzN4ajlGZFJGZkdTTWNMaXM0VFRNSUVm?=
 =?utf-8?B?UDlMVUVTL2dpZW1jbVVKMWZyRkN0V2ZDUHgrWXpYNDZ3MmtjelpvcE9UM1Yz?=
 =?utf-8?B?MXlFQVZxK0xHbzBMV0Jnb3ZudWpVZk1oMUQrMXJ6bm5tSm5lbjJ2SUFNaVNQ?=
 =?utf-8?B?aTdYUmJQMFMwaVpEMkYycnZscUwza1NxdWdSQ1RMRE81L1ZuZUZCaVhiSmc0?=
 =?utf-8?B?bFZXLzdUeXdQc2lkK1AvbXhXd1cwaDYzdE04N3Jyakg0RnRWaklsTG5WVVda?=
 =?utf-8?B?NGJjdzlvOEt2RDc5aTc5TzlKMVBoeGY2Qy83L1R6clgyUnExMGNyWW5iallP?=
 =?utf-8?B?Ly9rbkJrSUQ2OGFoeW9ZWDRHTlpxRUZDL2lyYUlvbW9RTlF6MHZOSmJjZFF1?=
 =?utf-8?B?aTNDNWZQaEM1Y2VUQTd2UmkrS0FLNnlMZm5mak5tQ1grMm82Y0dyOU0zODBE?=
 =?utf-8?B?Ync5VzlTVWlxWkx0dmNSSjV5bDZEWk9wRGZlcU93VzdYRTR0N2ZVNlFQbzZ5?=
 =?utf-8?B?Z2p4T0lVMTlyUEJ3SHlwL2d2WGdHL2FpV2dXOVQ4R1MyVjFqOGtYTWZ6RzYw?=
 =?utf-8?B?SEpZYVBKcndNR09pWjlsbUtPNzdTTUs0QnF1OEZyNXpna2gyeFVMRlNZYjIr?=
 =?utf-8?B?dkNKT3RXQ1F2RElFazZtNDJTbUN3YzIzb1dXbjZvaWwzNjJ1RUE5Sk94NzI4?=
 =?utf-8?B?UGs3eXFHY0RxaXZPMnVWbXB3MDBUbmtxZ0hSQ1RBc1Q4STJoQ3hUWktzdVBt?=
 =?utf-8?B?c001bVAvNDdNRjI2anJndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BhU3c1U3J5NjFuTUd6TTJrVVpmT2pkRkswczJWcHAveXkyOWJISjVzWEVm?=
 =?utf-8?B?NUQwN21naFdsMTlLOHdUU3lXOWQxSEUxMmFLVmxaRnpXcmI2TjRTZXBxcHBL?=
 =?utf-8?B?aDYzNVVwTjdJU01wTnpXMjhxTmhqdE1IMGNwWml6aWJYYWJVVnBqZmYwQjN3?=
 =?utf-8?B?UDBacGhrSll5UGxJL295OUQ0L2tUaDZZRzYxMHNTNjQrcjNtZklZWjh1V203?=
 =?utf-8?B?TnExQ3RLSXdOdWQ1bWsxcVg1VS9lekVvRW50RWkvSDJaa2Jtbzdza0JWV3pE?=
 =?utf-8?B?WWphNlNmOEd6RFphbGh6dldVeHFBKzBuVG5ZQUVwZ29wSUtxK3lXcXNsc0NQ?=
 =?utf-8?B?N2FrZmNFL2tPbTh2YXdKS3J1NWFCR2o2bGQxcENxTEJRbSt0eE9rcWovQlNm?=
 =?utf-8?B?Y01YdHJtN3hnSXhzZGlyQUJtaGtUUmt6bGh2VlFabzBUTVFPUG0wMTcrelpJ?=
 =?utf-8?B?MWdsd3d1a3BhZVpkWlhVR3VDUmZjcWdDclBYMThJN3lRY3ZXclFwcFpiV0d5?=
 =?utf-8?B?UkttaFpZNTkwVDRsTE5uVXU3WmdUemFHZE4yQjdZbE1oeTZEQmlYSWR5aUxU?=
 =?utf-8?B?UWpPMnVoU0xieVJrS1pwbHlqMHk0RHJCenRwYnlEL294elJsYUlBMFVuam9K?=
 =?utf-8?B?SHJuNnp5TVZYd0Z4ODZCcWQ0TmtrWEtQS3k5cGN0Y29hRE43aVE3bnAvNjlP?=
 =?utf-8?B?R29pc25nRlNRT3FyTzN3L044NmZ2b3dKUXRoTUdIVFptWkdUY2M5VEFjL2xu?=
 =?utf-8?B?eklwblpwUERCM1pOUzlwM1kzSnAvN2pnZWRWaU5tQjNYcGx2OU9TVUdGSTBI?=
 =?utf-8?B?VFFRVHRwN2xNUWNRSXc5T1dvSnYydy9zc0JVeGdFWGRYY2JBK3E4STV2SGJw?=
 =?utf-8?B?bFhQSzdNYVpVUk91SGsvcE1ITFNodytvMkVBUE1QTWpmYnBaRjdOZ1Z5UEhr?=
 =?utf-8?B?WXpmVUF6WHQ1cjBDak42Y3RKNlAvWmNzKzM3L0hpK3NKRndwVnMvNjNFWU9W?=
 =?utf-8?B?VmRoais3NWV4U1RKUlBDeDYvNjBvd3Z1SGJndEFoV1ByMFc1dmR4S2p1MWtC?=
 =?utf-8?B?OHdEOW1EdTFxc1loMmZLdi9GTjFoVkxtZXZmaFRCVnA1RnUzM0ZxQ0JqMmQ4?=
 =?utf-8?B?UlkzcTNCNDFpZ2QxVTErU2hHNEhrcmIrdW9UOFdaTUU2eWMrQ1ZMZDFtZm0v?=
 =?utf-8?B?c2VHTGc1QW9OLy92UFBLOExldndBSXdMSHNYYTJEb29qdTZjV1JVL0RTZW1F?=
 =?utf-8?B?UGxKWEFXRFBTUER5aWk5S1BHTGpGOFY3Tm1QNHo4bWx1SGs2a0VIeFZ0Tmk4?=
 =?utf-8?B?ZjQvNXh4WDN2VmRYRkpuQkY3YVZ2RTRqcnNPSHM5RFlqMDlzZG1NWVQyaDBL?=
 =?utf-8?B?RnJIdTUyVkhocnYvb2pCN05pOHgvR1MwWEIwVUtzZTlaMnFvWFJ2QWFiT1F4?=
 =?utf-8?B?SW95cDAwNlRwelRMc2VGU0gzbDMweW5zZzAra2J0S0lSaVRaWmQ0MlFiU0Vq?=
 =?utf-8?B?aUhlcUQvTUkxWlRnQnIvVUpTZUVzMzlHS3ZHcThZS2RBSnordDRFN2VNcUpW?=
 =?utf-8?B?SFAwMVh3TTdTbU02MllmWHNnSkJMTXRDYVMwUGgyZVpTS3dxclozak9Hb1kw?=
 =?utf-8?B?L1RYNE9ta1NTOEdsMUtjcGhkdHBPQ2oyT3Y1dmRxRDdKNllXOFhzVXZJeHJF?=
 =?utf-8?B?RUZYczRMN0Y0aHhqRWNnZldKVlJFSXUwRzBHZnJBT1RXS0ZkU2hiSE5zY0lF?=
 =?utf-8?B?K0tudWQwUkpxRVBDWmJ3SkxqZXB1Z0Q5Mnp4K21nL2VBOC9na2xOV0ZLMlpp?=
 =?utf-8?B?NmhPZFQ3WGNaSkh0RFg5VG5qNWNmN3VSVkVCZjBsSVk2MFBzOFg0eUpQKzZW?=
 =?utf-8?B?Zko0UFhqTWgvbmhBVm5jeVJDdGx6dmhDTlFsZyt1eU9mTENmSWZIbDR5aW9w?=
 =?utf-8?B?ZmVzUEJaQnhuUFdzNld6ajNBVjdLUmwzdm1GSlBsZ1Frc3dCckZYbnhOdVg2?=
 =?utf-8?B?Z05kVURjejZtUi9Iays3NUVNSXBIekh2bjhmZGRZQ2F6Q2ZXYlRuWVNuaXQ0?=
 =?utf-8?B?NFlrajZpeHFJVi9XY3R5VEpMbGpieXNEc0gxM0pYSnE0dU1pVGR3a2RqcS80?=
 =?utf-8?Q?ZDbHzqsYH0YhR+nCD6k+mYHXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19fcd13-2e5b-4801-86d5-08dcc65e8c20
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:07:36.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgV5vjRgdH66QbvL5Q9oPrFmHDOTOgxYluP3REVh6jhvumSMKcpCLKChXExSJPyIf5/nPNQXErPI30gkg4Nkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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


On 8/15/2024 10:30 PM, Alex Deucher wrote:
> When MES is enabled KIQ is not available.  Return an error
> when someone uses the debugfs preempt test interface in
> that case.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5685aee479df..5704ad25a49d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5924,6 +5924,9 @@ static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
>   	struct amdgpu_ring *kiq_ring = &kiq->ring;
>   	unsigned long flags;
>   
> +	if (adev->enable_mes)
> +		return -EINVAL;
> +
>   	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>   		return -EINVAL;
>   

With MES feature enabled, based on allowing multiple command streams to 
be executed concurrently on the GPU Vs KIQ that is used to send commands 
to the GPU in a sequential manner, having both of them active at the 
same time could lead to conflicts.

Therefore, when the MES is enabled, the KIQ becomes unavailable.

With this understanding, this series is:

Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
