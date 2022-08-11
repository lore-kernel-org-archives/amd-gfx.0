Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E5DC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3334B3AB3;
	Thu, 11 Aug 2022 15:07:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFA7B3A90
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 15:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5V7ZkSkny6exzUMZWR4Fk/Z/VauGrocvQxkxEEDCzE9/67s28eSwZg9Srg8a3/V50P4fyfy0uZ/9ASuP2gCAAA0L+D3XnbiwjTIcgbwrHfUUKwwYmJ8EQEGyNBOooxCbaqePioRrDiSX9j46igKigjCArevBpHxBh5KuRhysOUkdZGs98MOHoWWpWsMEN1DmxhAZ/9OgnXrjHsbN3Aul46IOZXU6OSsq/JLsqTcn5fM4YNJPt8uY6CF/QXxmGEUVogbVKR3XjqFo26dG6leU4nghEMp/g3p5TgcMfEiQqkn4mnjbZS+G7l7YHmTB/ub/3nROC+aZRn3/dEw2WTusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MbAqFjRnhVnDW1UB3xK5iFhov++wLyHH74aNbI+xEY=;
 b=ToJOXxuyf2bh6zt6+6pNqR6sSnareViR0T8820vQoxtztomlAxXClClQARxYwzHbrP9LaKsxmUxScfznMLqEz/HrEsS1XvfX9cWpUkBocowH+KJOtIqTtTik9gIlPtvRutdfDtfx95oAOYE90Q0afYHcVwDqWp2nYGIk34yR9Jl1iIa9eWDlESgbeQSSJcDjVfV2Squny35x3KQP15Xwom4iw83GouF4t00aLJBbARzOq8M08/jwCwf9s+Wey4E5mqwlODPfwDeJo9w0cdmhtZLyQhbARlxD6KByhYdGLJnDbo1vbnpdr0fMeeMTpC+XZLotCYlUi9nlOiSDlwhByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MbAqFjRnhVnDW1UB3xK5iFhov++wLyHH74aNbI+xEY=;
 b=1I7xlTP2RXyRJYR3FhVnu/pczxku2cZUUSWQR3pDBW7YM3dBMZRZeDFbe+UibdFsdcRSp4WWmrR3L3uumnI/cTF4LuZ18zxPJEMg4b0kX8cPOlZEBd85UrOdA7Ad7Jz2PWKZ1lGalMuBSzNdsrD2JSwpvd7T9g8yPxE8n1URoas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN6PR12MB4766.namprd12.prod.outlook.com (2603:10b6:805:e2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 15:06:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.025; Thu, 11 Aug 2022
 15:06:44 +0000
Message-ID: <ea6576bc-7458-df61-1054-59d518722a62@amd.com>
Date: Thu, 11 Aug 2022 11:06:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Try to schedule bottom half on same core
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20220810234109.935228-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220810234109.935228-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91320801-039c-49f6-7b47-08da7bab1ae4
X-MS-TrafficTypeDiagnostic: SN6PR12MB4766:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9MG2xECWSrCGYxtj5wn/1BBoVCEYdqqgqgQCJWpKoYjmOmdSOZrT6ugrEN30Vnf+2j3dBfTh5iPzvBIzHn3CnesyDVJ9f7KDVFpdAwb3bmOA+6nfzou9qdHoBEjNwXl+OGOA0ynS92s31D8AZbL9oMBZUuzXyjfa3GVU6Xq/67L9eS3jTBzCHOP1JfpuJYf3CpPLas5K0icuHQKCX5X3u0K5/Cze6fuPIWpsaL7Fs929dWZ7rM2HnzTgZbHhPgGgGfgZ11erYQ0PJO/5X0Fy/yS67OqG5X02xsb5LeUXAdvfJ3xl6bER83K/kMCZNDfxfee9DzxLIhU2O5T7lDMRpeuSpPVuvD8hiWx2tHkI279iBbppJVA7DutzA1HHHjAyxjmys4lspbyXqZCXx3hrI30+XFPj1E3GT0EWfw7YmnhG+b+Re/sLr2dZoeHJiAvorvyyU4qsZKwisgNIuawkiT0WvOffEcd6L8IPNpU0UF4uzip+lkXredtV2F8isAMw3Rci1p5OniYyiU7Gxtvww7p9/1loI1B0L8n910b/ALeHd/Rl84wCnIrCt3LgXQpppRUjuqySJLt5neXylpUWKne2WZ4sNevvRJM/x0th62Gb0OnJQNtCeO9LD37jL2jdd+vXmc4B1n0n1dbv+8fXcoY7KocnKJ68CS7obM8S7vE7VRmNllRuJptSyp3/sC1cXAmjWEYBGsVIAWdb3IY5aL/BFSVEUVibIuIX8+BWQrwrVu6EM0IPOQ2fjF7+DaVIKKkvdke2nKtuQOvPllAeyTX8OyrrMwzWtCYMO1TJB319hBWQBlcXLTNKCRAVvZoZfrRDOjnsZuOPkCAHo2yWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(36756003)(6506007)(6916009)(316002)(6512007)(83380400001)(31686004)(2616005)(186003)(41300700001)(26005)(478600001)(2906002)(86362001)(4326008)(6486002)(31696002)(44832011)(5660300002)(8936002)(66946007)(66556008)(8676002)(38100700002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjl0RTFBVkZIbWRJYTU2ZzJkd29hMThzamZKY0FvVmtIY253QU9vRHJEMVlv?=
 =?utf-8?B?SXRwV3ZpU1E5ekpOSng5WG5ybUJRSU9MU3hOcWVidHAzem8yZkZPZTdCRXE2?=
 =?utf-8?B?SmJ1S3hMeUU2bzJNRHh5R1dtUTZKRXV0c0Q3U1gxOHVONlF6VW03eW90a1FO?=
 =?utf-8?B?cXVhbmYyL2hTR3RKd0EvOVB2clk0Z2ZpcmZTb2tOU0dMNlNKOUlQUEozL1p0?=
 =?utf-8?B?ai9PamFwRHBnVG85cCtLWTRsZDVmZFhvZUdkdU1sYWVxTFlPVFdGcUtYdUU5?=
 =?utf-8?B?S2pYMWgwT05rRUtzZjFJUHBmOU4xbHNSL1pMVGNmWUhhdGl3TzVXQ25CSlpj?=
 =?utf-8?B?NGtaVllPSGxBc1Z0VngvVTQzUFRkRHljWDVYN3ZJdmVtNXYrWTlwTHZjV0FH?=
 =?utf-8?B?Z2E0aGl4MjRJU21wc0hUSXBncWNBSlJCblJQbFlOWFVneUg3cVJtVGVCSitk?=
 =?utf-8?B?dk1lbTNVVWZ5eWFDR2V0eXJOV1htYWdwb3JweVgvOUVjbzA4dXoxTzBXRE9p?=
 =?utf-8?B?SmNaR1l5WDkxcFBNRGJiOSt2MzA5bnA1clVYd21BYll6VURvVU1hamxYNDFZ?=
 =?utf-8?B?RzV5M01MaWUzNExFQTNqUC9hSmVOalRtajZKZmxDb2RsRUlDY0lkSXk0aUlr?=
 =?utf-8?B?c2xocW9MZm1TZmlHeUExWERnTzA0Zmc1Y1RrbzMxaUhuakgwdVBiSXhRSFpW?=
 =?utf-8?B?Y3Z4b21Ud2psNW1keEJsUThPcHRkUFlzZ2xvVzFUTERnakRqQVNqeVg3dTJu?=
 =?utf-8?B?SmI1MXY1VzJDWHVyQkJIQVlMV2ZLSE1JT0pSVldzN0VHUHJZVE1pcFFZV1gr?=
 =?utf-8?B?OXhZUzBMRnRXSlNPVlJ2QkQ4Rk9iQkRud2wwVnhFQ25FQkdZdjJUTnpiMU1N?=
 =?utf-8?B?cis4RjJ6OG5HQnBDZmNaK3NSclR3RFIrVi80QnFYRTI2Si9oM0VTeVpUOTR1?=
 =?utf-8?B?eXdpcG5UTU9mN0p5V1FkZm9Gb1EzYmV0WWhhU0RkclBZbEJOR0krSzNyYTM0?=
 =?utf-8?B?cnBLMVJrQWVUL0R4RFVTNlpUdXIxN2RKVEVoVkhTMUhjeFF5ZCtYaUVtakVD?=
 =?utf-8?B?SXlHcU1sRHhFY3U2bENjQldwdmJlNGlGSWlVNkZKRGxKR0VSSXdvdVdzaGFD?=
 =?utf-8?B?SXg4UmdtN3A4TWI1OFNodWthNStPUEJrVjhicUhqT2wyNGFpSXAxTnpJVXRX?=
 =?utf-8?B?dWViME5Zbm5MZUZ1dDU5d1BKMHRCeGRQOURWTlpLZjN3bkhWWjJjMUtrOTVa?=
 =?utf-8?B?dk5LMFd2OEM2QzNVVmkvM0RRYitzSW44WXhaQy95Z1FUVUkxMnpmVE82L0pI?=
 =?utf-8?B?VUdtMDQzTlhyV2EvNHdTell6TkFicGpwVHM2Z0hjMU4wZUY0dFE0aVViWWh0?=
 =?utf-8?B?TFRkV3VJRjNETVJqNG9MaDNHNnlUVDJrOW95WEdmVnNaTWQyVDc1V2F3QzFG?=
 =?utf-8?B?K2JtcUZiaHZidEU4N2taT3RqVlFHRWpablF4RmoxWi9QSzdUdUF5d3FjUFpn?=
 =?utf-8?B?TUZKK3c1bnR0QXNJNnVxMG5ab1YzTkNwaVgwRWRtaUdKTnFzWXVHTThCVCtS?=
 =?utf-8?B?VHh5Um11K3h4YU1ISWxWSVlSeHBVZmRQNnlRWXFUbHpib211UGZJNTMwNHdr?=
 =?utf-8?B?YWRXa3BiY2JvQ3p4YjFHZUNFL1RFZ0loL3hZMCsyYkZhUzREaWl4YlUyeUI5?=
 =?utf-8?B?VWpzaCtHQjdDRFdhMTdheGxmSWtSbGUwckhxY0FNZnVlMFNIbGxzL3RLWFhL?=
 =?utf-8?B?OG5hbW9QRWFxdkNyQ3oxL21HSlhycHVFdUt2QWRIQU1QQzU1T1hRU1pUWUdR?=
 =?utf-8?B?azkxcVFiQjZZeSsxeDRMdVNVdXBBalpEY2lPN2o0cVVLcy93cEEzQjRXVklB?=
 =?utf-8?B?cHJLVVpmaThGK05HZU5uUFA4Yms5RkthSmVjZUtxSkh1VGs1a2IwRmlaWkQy?=
 =?utf-8?B?aE1IWlFUL0Mzb3NhRldYQzUwNEVzOC8zR2R1RlZVTHRVMFNLd3RzU0xsanow?=
 =?utf-8?B?MGc0Y2JVR3htVWZUalB6T2o0alBwU1RjTkFCQndlcU1NYjRzaEhvMDNXRUEz?=
 =?utf-8?B?K1VtL3ErZlV2NHpOS3lwdmpGQjF1TmZiYm1odUE5bjc5ZVFBS1kraTArRHBj?=
 =?utf-8?Q?oVilWj7BXv6J8uNxEmgWZvbS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91320801-039c-49f6-7b47-08da7bab1ae4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:06:44.8726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQlBWsutn9UnNX3P2hPE98kidoQ+x6S6rvPF+VBd9qTyJjlJBSNfWfl2OnxGoCUZLgyG41Hcvf1d5QsFmERNNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4766
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
Cc: nicholas.curtis@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-08-10 um 19:41 schrieb Felix Kuehling:
> On systems that support SMT (hyperthreading) schedule the bottom half of
> the KFD interrupt handler on the same core. This makes it possible to
> reserve a core for interrupt handling and have the bottom half run on
> that same core.
>
> On systems without SMT, pick another core in the same NUMA node, as
> before.
>
> Use for_each_cpu_wrap instead of open-coding it.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index f5853835f03a..5b12ae69a301 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -24,6 +24,7 @@
>   #include <linux/bsearch.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> +#include <linux/topology.h>
>   #include "kfd_priv.h"
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_pm4_headers_vi.h"
> @@ -801,13 +802,24 @@ static inline void kfd_queue_work(struct workqueue_struct *wq,
>   				  struct work_struct *work)
>   {
>   	int cpu, new_cpu;
> +	const struct cpumask *mask = NULL;
>   
>   	cpu = new_cpu = smp_processor_id();
> -	do {
> -		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
> -		if (cpu_to_node(new_cpu) == numa_node_id())
> +
> +#if defined(CONFIG_SCHED_SMT)
> +	/* CPU threads in the same core */
> +	mask = cpu_smt_mask(cpu);
> +#endif
> +	if (!mask || cpumask_weight(mask) <= 1) {

There is a stray { here, left over from when I removed some 
instrumentation and switched branches. I'll fix that before submitting.

Regards,
   Felix


> +		/* CPU threads in the same NUMA node */
> +		mask = cpu_cpu_mask(cpu);
> +	/* Pick the next online CPU thread in the same core or NUMA node */
> +	for_each_cpu_wrap(cpu, mask, cpu+1) {
> +		if (cpu != new_cpu && cpu_online(cpu)) {
> +			new_cpu = cpu;
>   			break;
> -	} while (cpu != new_cpu);
> +		}
> +	}
>   
>   	queue_work_on(new_cpu, wq, work);
>   }
