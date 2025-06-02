Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F2BC54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 11:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DDC10E4EF;
	Mon,  2 Jun 2025 11:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LfpiGPcy";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9057310E2FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 11:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdkzxaUor1/3R8P5ikh4j6uwKCYteTdGxMN1XbpfnqBLo2f0wn3ZUlsYIP3GLNGoL7nxZZ7u/0uWk26+SahooqC9moU3Xt1O/B+KjBZN41NC2yS+leaWBQrQeskmCbFQBj3KdNGrlh+xsKT9fF7kF0dd2Zx/8tGSHRoMr8IXAznWDj/L1pev2Cs/2R+SmKaRel9P0BhmOZxx03uXA+1uy87AnmLej2k7h+D8sZEH5hZDQPc/Tfi8SGLVFNlnju+Oh00689Ztxo9sM/KPVYWKMoEAMO37PcWMkmgnEGANFEsh7IJ7skGxhycXizVoA1AiWclyPhI/6nsQbTqSJ5F7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zngRashA9wbiB+x7g+JcNb98W4fdY0CxtdleQgk+1cU=;
 b=ptNLwZ7v+nddgmXTJEHaxbuH1TRlzggPW09to88leVNTl+BtWNMWcwJLG0OE/Efx3lqUnXrllWd3Z/IWr6DUE84OKxct6a6w/x4F+/vI7i45QuTDPAUruuDmYB0WFEkVnJ+u7oKw3C8EROhta03tpn8OeAqM7vY5FOaXawNCbFs4ytxv9wngLtuPtQX6SUS6jS0a9IwCIR4mrKN3/p3Fp4Hg/6n+P9/AQ/YpMAQyw2T6eAbGfWF0EXFIfh6kHMc5QBCSCjbcHL8jweFb4xfLWxc1bk1tCqmWDXng+kwS2VmQwrIwyIpV8ZsNaY7EEeJcu+Nv6FXcWSxUMOtPZc61pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zngRashA9wbiB+x7g+JcNb98W4fdY0CxtdleQgk+1cU=;
 b=LfpiGPcyztUCUUkfVCWxllu6EHBf86v6fm96YWwnyOLBd0xsG4m5qK13tK15WWWh6nKxVSIfFu05ShqM4qf1VYH48mn5T+mvJSA6w0IBKeUV/jex3Hed6LKh0by46cyZs0KA4ePdxeFmcE+iwKHHBMRp/agEEAA8cPtu+G4cFN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 2 Jun
 2025 11:08:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 11:08:09 +0000
Message-ID: <df2fb46f-0180-4b2e-b29a-8c65fe0ddd68@amd.com>
Date: Mon, 2 Jun 2025 13:08:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] drm/amdgpu: validate userq activity status for GEM_VA
 unmap
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-9-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250530075505.882004-9-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:207:3d::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e309af3-2e2c-41e5-dd6f-08dda1c5c1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3BvQmdlWkxEZ0V5UlFRTkVIdUlOVnRTVm1wR2RFeU9najk0c05NOFI0MEpr?=
 =?utf-8?B?SzJGb3g0MEc1aExmb2tyeVdtL2Y3L2FZMkNwalh4Yy9jejluZWJYU0pLdzV1?=
 =?utf-8?B?ZW94eWNFYzZrdTdubXpqdldOeTN6NHJGZXJ0TjFLVVEvR2tic2V1VUpBVnZH?=
 =?utf-8?B?OWkwSEZ6MGJ3S0dTVVRhd1lUcW9MdkdqUDlwWUFmaUwwOWxpMkI0S0FaazdD?=
 =?utf-8?B?MjBKZllrcmNmV1hyMnJEL1RrZmlGejJPRjdpbGNNbS9uOGxvOHZvcVRPaUgw?=
 =?utf-8?B?cFJMajNqNkIvQ3ptT1hBeWVZVTZNb1NiV01nT0tmZlNBejdPRGprUi9yanNT?=
 =?utf-8?B?WHc2Z1FYNG9tdmpuN0doUFJDeENTMGhaaFU0UlVVZDN1NkJXc1JlWXg5L1JY?=
 =?utf-8?B?eWxzU0FybW5DaDFMWjNxVlhOZGlGTVI5N0ZXTnhiV3NBNEZ4RVpMaEhSK0N5?=
 =?utf-8?B?QUFsbjdRMGkvT2w2ZjdXNHMvSGtGRnVqUHdyd0JHKytsWCtINkpFVUI3ZEhM?=
 =?utf-8?B?ZHN0WUN4U3NadC82YjY0ZzRrczArKzNyWG1xNGZEWFdqU1hEMlg5VklQMzVP?=
 =?utf-8?B?LzB5aVdQUjVJNnBwT0p4cnk1emw5a09FVDhhREFyV3VnOG14b3VyZ21RbVB0?=
 =?utf-8?B?OElJTVBhcE9iVncvRTlJQmlzSGg5Wmlyd0dFV0VIeTdyVlBZNkcvdW5ndjlF?=
 =?utf-8?B?Z2VSbVlYNDdYcWxMRDNTNTU4MDdQSGY3TWMxU2F6V1dZZnNibDhLTCtQNldR?=
 =?utf-8?B?MGxCWUxpUUpZL1p0OTVzSXIrVGV5Y0VRcTliTkp6STdKMnRvdEtod05SQ2tC?=
 =?utf-8?B?SkhiV3h0aHk2SEZpWURWbmx6ZktmUERkR29zSTAvNWUvK0pUajN5cThKVE40?=
 =?utf-8?B?bUlydFhmLzY0WnplQ1I2OWltU2E2SHphNXhzWlZ6RURTYVVza25vdTdIdzZR?=
 =?utf-8?B?ZkFoQlZjVHMzVk03dTQrSncwZEthZTkzM3NVSzZqd2tmdHNkN2Q2RVB6ajI5?=
 =?utf-8?B?a2NoVFd1UmVPL3ZOR0NqSDJCT1R3T05tNFlLZEVJL2JmTlpET3BXQWdRbEVy?=
 =?utf-8?B?WWlXd3duMmwwQnFZWXFjbnRQQkJCSkNRV1haUndQYm5JL3p6Z05ZdEdubEVq?=
 =?utf-8?B?ZHRpa3BXY3VHQW8vTk9WTTF0UllKMEp1KzMwWGxoei9YMzFDMXorNnNqRFE0?=
 =?utf-8?B?VVdIVytaRldFMElkYkhOZG90Mm9EZFpUQi9MUHg3SHBxNVZJd3pWbUNvd1k4?=
 =?utf-8?B?RU45SWpHU0xBTk81QnJJSjE2TnM3TUgrNk9ISEhSVUx2T0ZyT2U2dWJrZUEw?=
 =?utf-8?B?MVBPMTFTdVZKVFJUSmFnTTlCNFo1eGtzVDVIY3NCSTZlVEJSYlhMT0kwQU5u?=
 =?utf-8?B?ZDZrS2xFb1pER3dCU0NWUmQ0OGpYUFpyNmhrRWpJUEdxUDcxcEdudzR1RXg0?=
 =?utf-8?B?QXE0cWhhODBZNVpjQmxaR2Vra1FodkJPcURUMjlOZlVjZ1JsTElIejlyUi9P?=
 =?utf-8?B?SmMyS29lUDRSdjZNYzBNdmlWeFppc2kzdnJ6d1lKNjFKazBUSmZlSnRCaUJN?=
 =?utf-8?B?M3NweW9sd0tkUW9pa0xzaCt6Z3dCZjNyY3BlMExGVWc0b2loQm5CaVlnbXo3?=
 =?utf-8?B?TS9OUUNXNDVzMnBucHhLYXBZOXRKcGZJbFVIbnVoUGY4TGIxWHVuajZHaFdi?=
 =?utf-8?B?M2t0bm5PZ2VKSnM2REFndGJYUG5OVkZqTnpxSWRSTHhWSjRmOVE5Zko5QmxG?=
 =?utf-8?B?NjhFZjJRNVIxMW84TWtFVVF5NG9EN2tQLzBRc3l5RWNtRmUxOVRCS1N6QWV0?=
 =?utf-8?B?cUxPd2Fpbksya25jYjVqcVZEbVFHMjNHYi81STNvL3Y2L0RCa3luSTQrZ1JU?=
 =?utf-8?B?TVJnSnl1eDdJY0xNQ2xRRTQ2Y2FCSWxZa0JsTlRoZ0ZLc3RuL3ZpT1FDK3I1?=
 =?utf-8?Q?UFkb50xV4Wg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG9URUw1b0h5MVB0RkNiY05kRlcxdVVGSkoyVTBEWUpzOHlaNWYyNWdJdHc5?=
 =?utf-8?B?R1lVY3Y0YmFNek5FTkM4SjZmZk0rV3R2eUlIQnRIdno2cUFMMVVReGxPM2FS?=
 =?utf-8?B?L0x3L2dXY2x5Tlpvcmh0VnB1WlF5c1ZnZjlYWFhMQSsrYU1TUzI5RjdhUGgz?=
 =?utf-8?B?aDVNYzBzZGJ2S09EYzFDVWNsUDg4VCtKbEE0WkM2U0pid0RtSzBpbVdLMzdY?=
 =?utf-8?B?bnhQZmo4OVkyRjBZRmdFTnVZaXdsTmVXS2w0WkxCOHhnS25NZ01Peldsa2lG?=
 =?utf-8?B?T3UxcUtwbWJ1MVpQNGdyUVl2UnRTRS9CT0c1K3h6aWhoTGhUZjdaKzF4Y21G?=
 =?utf-8?B?SFFSckhaQnB4ZlBzcWNhSXNVVkIxWkp1dXMzangzbnF5aVdPUDV5SlA0bWRk?=
 =?utf-8?B?Sm5KV0E5QnlWRHlDcGRDbFlodVg5dnp2VWpmcVNSSnBZcTkvaHV0U0hrbklX?=
 =?utf-8?B?THRaWVNqVFBma2YzNDM3T2Q4T0RwaXlYdzYyNGV4STZLNUNLSlhubXFGR2tX?=
 =?utf-8?B?U3NuTDFDYXYzbmpSMmdFazJwQjNaL1k5Vi9pN2Z3TGNCMjZCRkJQOHlHR2JC?=
 =?utf-8?B?ZHkrU1I1djQveDMzY1g3YWdnWi93MU1vYXVKUExsTkk1Tno5TEsreENlMUpC?=
 =?utf-8?B?WHJGb1J0SmVkZnhUemlubFhSNVBEZlFCUGNYTmxzL1YxT01vRkl1VmVqM3ZN?=
 =?utf-8?B?b05qMGs2cTArektUMGtZVXgxYzhXWW9pVWlXVE8yMDZaZFE1d0d6ZzA1aFdk?=
 =?utf-8?B?UFMyMlNSckMwSEFBV0NLUG9oYkpRSVVGWjFqVTJ4RzFic1VXcE5LR214YUR4?=
 =?utf-8?B?SHdKY0wzNGZuQjhmaE8xemRkb3BVQ0xacURBUVhKbEc0ZVpISVlxM01pWVFE?=
 =?utf-8?B?cEVySFNBYktSdFh1ZFppV2ZKZlpLYWZUZjdjUHVsbjBQSTAxVFpXR2ZURjhJ?=
 =?utf-8?B?Z05sVDkxTU9aMEpIbk5SenMyZldGaTk3VEhPZkZiU3pxbldSeXc1OEVzNHFP?=
 =?utf-8?B?Wjd4SHZjaXdoenE1a2czNmpVaXh3SXNPM1lYZWxQVWdHajNvNC8wTEw4Ni9t?=
 =?utf-8?B?UVZSbnlUZTJib2pQeFg4VGE4bkphZ0tHa2twRTdEZFpnWXVoUWFXVDdOLzYy?=
 =?utf-8?B?ekpYdDFNZkpZMmlsZS9Nd05xUE1DWDZzNDdhanYzZDlsVmJYcy9vWnUxR2h0?=
 =?utf-8?B?dmpaamhHc05RYXdKUDlSbWVKb3h6Z2doMjUwSWRUNmJ3aXYyeU8yK2o3VDlo?=
 =?utf-8?B?a2VvT2s0akRmcjJXcmd0SXJhK3VDNERiQlZBV2p3dXVYbTg5RUZDNjdjd3Za?=
 =?utf-8?B?SW13L3JPVlo4Ky9XZytoaldnSlg5N2w0alJCQUU1bmlTR2JGZDdsRlhtakVH?=
 =?utf-8?B?cEhweUk2NWxVbXNKTE4wTlZ6Tjk1c2lWK3ZXUFg2YTU0Y2JldUxBdm9sV20y?=
 =?utf-8?B?dHdQZExBVVpCcXJKUElGN1RodmZJQlRzR0g5RkZYMDVXY29SUldSVHBYTE90?=
 =?utf-8?B?aFZkTVlGeFRFeUlRZDEyL293dG5VRktoc2FHc2x5eUhZMjNaRHNBUFRiTHFv?=
 =?utf-8?B?dTBvWml6ZHhKbzRsMGwrNzdNdmlERHNhU29LZlZraVBsUHgvam5OM3NTNTQv?=
 =?utf-8?B?c0hYcXdmOEQ4WHorN3M2eXVGTlJ0dW5tY1dGekEydXBEZG1oNVB0VjFGajBT?=
 =?utf-8?B?MFlOZFRZbHpHa2NiWExPME4yNVFibzBqZW5Pb3JpN0xTc0tFbS96czVTeVNi?=
 =?utf-8?B?d3B1Z2g3TGJtWThaNVFNZS91Y3pVOUdENDlNYVhTdEh4SmppMS9NcmpnQ3R3?=
 =?utf-8?B?RWVGOW5WbGRucUh2ekhza09sUjh6OEtkNDUvZG9STVBxUG9MYnA1R0FyaXNu?=
 =?utf-8?B?Yi9GYjRZeitKc053M1M3aE5tYnJJemN4Rzd2RTJQdXM4REo4NzZaOGxDYWNk?=
 =?utf-8?B?QTNJb1JoUFd3MitwRHg1VGlEYXN1eHhpZ2NHcUV5bGVxODZRV2pOY0xsV3Mv?=
 =?utf-8?B?RzNDMWxaUkh3ODZXbjExclYzclUyQ3lORWNBOW5xVFREYXdVZGxmNG9sNVpn?=
 =?utf-8?B?b1Nab2crODFCdy83TWljVlFEWGxnNitsUXlwUDFsMHh5dWxSalBYeStPMnpl?=
 =?utf-8?Q?CoRQQ8+QHiCtgMTRTy5KnK5T5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e309af3-2e2c-41e5-dd6f-08dda1c5c1c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:08:09.1651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jG6r3Y2w/nG62QyAnXVO0AXlKB5wAmMRSJd6wqO/lAm9xvJ74iZAnNPGVWcMFG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

On 5/30/25 09:55, Prike Liang wrote:
> The userq VA unmap requires validating queue status before unamapping
> it, if user tries to unmap an active userq by GEM VA IOCTL then the
> driver should report an error for this illegal usage.

NAK, it is perfectly valid to unmap an active queue.

We just need to make sure that we waited for the queued up fences to signal.

Regards,
Christian.

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e43a61f64755..e2275280554d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -234,7 +234,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	return r;
>  }
>  
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>  				 struct amdgpu_usermode_queue *queue)
>  {
> @@ -243,10 +243,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>  
>  	if (f && !dma_fence_is_signaled(f)) {
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
> -		if (ret <= 0)
> +		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> +			return -ETIMEDOUT;
> +		}
>  	}
> +
> +	return 0;
>  }
>  
>  static void
> @@ -464,7 +468,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		mutex_unlock(&uq_mgr->userq_mutex);
>  		return -EINVAL;
>  	}
> -	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +
> +	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
> +		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +
>  	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	if (!r) {
>  		amdgpu_bo_unpin(queue->db_obj.obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 5e075e8f0ca3..168fc3835aaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1930,6 +1930,11 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  	struct amdgpu_vm *vm = bo_va->base.vm;
>  	bool valid = true;
>  
> +	if (amdgpu_userq_gem_va_unmap_wait(vm)) {
> +		dev_warn(adev->dev, "shouldn't unmap the VA for an active userq\n");
> +		return -EINVAL;
> +	}
> +
>  	saddr /= AMDGPU_GPU_PAGE_SIZE;
>  
>  	list_for_each_entry(mapping, &bo_va->valids, list) {

