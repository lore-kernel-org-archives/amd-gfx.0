Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA506CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 20:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A34B10E3D0;
	Tue,  6 Oct 2026 20:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FYC3vhv7";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5EC10E3D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 20:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKAVoSjEsyUBtzzKRG0Jf1uRQXFFq2yMQT62uvkSbSpSZeSmKJ2aqGSLsN51lYKVF1CIrJ/1y6NPOZDF4LQJQqTMmXGRfVxbmUkm76V/hOcUlz0x0k1NMON0M1kRV+R8WZJC3x2F/9BiJwdRZLzGZC171wcRCa8wQtWPcn3ELZ4keSrVtv6IxbX74FhlY12Frt0ZXkhyEB2cI9J11UCQPMBvdkP3y3sUelhdt7h1RaBcpJCqw1kQFTbMHoJEldW5sCfdjd/Xvt31eWcyDdLkbXJ1sc6n7aNwRi7RkOMMbij6TYhUn6/4d2j7G/FtcMf3nJ9QAdZJaI8y60jgsue9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2yO9ZhSsi682tmd/fdpYbc6wIYLjkyQAVe7VmZp9Ms=;
 b=F/DPUVEKxdCQj66Gws/nxlgVl8hYOLzGPNQOuXHD9Yu9GmY/bDNwwKt4L0t7ODuPsX2zWsepVnC/QstwwvE70DCAQYA/r2f3cm36n6MCdLrkI5Z21LhMz/AP5Rqxv6tKlMr6qn2H6dQeWEfXaAfLjOfd9KpAiCjpjNzywAFdqu/cMunECKwQ7KFpNCXs6/Po8e9VkxGwYHRY4uAbvIXWLTFjVS+e45jcqYWRb1x3YYugyq6ei9OTF7qPISnxVez3VkexNdAwJkKsKZ52l7HYZeEZh9tNxXXEf2Qe75F3Auby5eaNKyejL0KwD58qnFrSBfJN7kDcGFymFioY9hr2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2yO9ZhSsi682tmd/fdpYbc6wIYLjkyQAVe7VmZp9Ms=;
 b=FYC3vhv7cdEaIgd/PDEggF8Z4K1PVwwKdZdwIZ10iJ2ZDRsyma0vKFKAuLa77Q0WUpuHMXmb6XmWmYtT8vDnWKxGcHOXYcBr49xrC/IKXeDmwtSp5JdvGb9EilXvrt3m2I2D5EgU9bgzo2ohOL+kLNUV4RmaURswph2qpZ52xp4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CYYPR12MB8653.namprd12.prod.outlook.com
 (2603:10b6:930:c5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 20:00:05 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 20:00:05 +0000
Message-ID: <c4f3a215-531a-440e-a0e2-c3fbcbd4408c@amd.com>
Date: Tue, 6 Oct 2026 16:00:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Restrict CU and memory entries to
 resource nodes
To: Dhruv B <dhruv.b@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <cover.1791289746.git.dhruv.b@linux.ibm.com>
 <c1a0b1c06c7616c225bf1eb22fad4ca4d73eeddf.1791289746.git.dhruv.b@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <c1a0b1c06c7616c225bf1eb22fad4ca4d73eeddf.1791289746.git.dhruv.b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::25) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 977e3459-10f0-42d1-eb78-08df23e46a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: WTzSwQfsy2MpRrvRk937vrA45r3UaEvR1hppLb9GMc0MpEgZEseM+pPhOaGnyf3P2MXsmNlqAvdI1CmfODH/klIXfz4w33QpuyNX/IuCLDptQv+8PAEW4fJ5iOwSD1gqMKr+06FBRNaGbGZmcJb8uSMKV9E99vV1vicOsDqA8w0YbjMp/W5zcjtB8bZtRxxcQteVejH2Evt56jWrVpYBeuO6/ZAvquibXr6un0ewik9xCWNFt+MI9+Cu7ffQWO6xbAiC8i4aHe4IcG7lZDB/iy2MIxyWlRVXOx+jjfFf2gVL0v1Y0aezZZZ5Y0fnGT4YTE4g64CHl5Qtjw/aJ5ujfrCaeiYqIm61jmh/gAamY72KjTbua2IizyVVnRl32Q5FiRFWZ4eSErm8RrKnMHCrq7colMfuNP70S/AgVVsvGFZXOLNwBQnF8GkGZEHp0IAWOXaP2Lwiz56ppg7bmm0dIsWDrWnZ0emtYHnbpB+wMIWUEaVOdzSV+rJO3cP2XEo8iBC3Y7k0VKswqgCbpTojIgepOv+tJG1nDB1h6QFE5VjQDX/XJ4GyDUJje5yF1tKqnSqr+sPrZIoLFHeoFBQOc3m7eG4Q3MKwaNHeTjfNE2WEP6R15mEZXw6is67SLnCxNI8b+shIybcAGAk+XdoxLEQJK0S4DUUteeahTz3RqG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXpRSzg4MWZhYjZvS0o1b1B4WHJhTFZla2tVYnN5QWNVTmMwMy9XcDdXUHpO?=
 =?utf-8?B?V0dOdDFJT0k4MkJrbG9rM29UM0tVV3JJZkExM3FUcEQ3NGpYQ2tEVlVjemxU?=
 =?utf-8?B?RlkvTTIrWENjMDdpalJ0djA0MmM4azVhd0QxRElJdlgzb0laUTZFK0RDbDNU?=
 =?utf-8?B?Vm1pN0JXWHZkT0NwWU1MNURISE1MbnhzWWkrUkl0Smd1L1kvZFNQWHcvbm5U?=
 =?utf-8?B?UExoQk9Hdk5VRVhxZjJWVHg0aGdwYnRBYVFFaTFvcndLWVRpQjJJRWdKUmVp?=
 =?utf-8?B?ZldML2Q0OHZ1NE03RFg1eXNrdTlPQ0NlZ3hrbzI4QVdDNkhseWxMc1BhRkhk?=
 =?utf-8?B?WHZ2MlJmcnR2SFpGT09UMWIvTzZtenRSaFlweXdXamtZM0puNVloQmkvQmhv?=
 =?utf-8?B?SlZ3dER3M0VJeVprMjZDQmdYdlAzV2ErUUxGL3JjMStsdVNlVVhIUHpqRDd6?=
 =?utf-8?B?eXpWNmFNMGxWZ202RHdQaVIyQ1NiMXFuQ2s1RzkxS2xhR2FmREZQSEp6RDNh?=
 =?utf-8?B?T1BGN3BjZm5VYmhPbFR2NWU2QUl1bjVlNnJvc0NFclFkVzc0ekNPN2lqa2Vi?=
 =?utf-8?B?K1VaZzVMcHNSZ3ltQUNqNlFBN3hSUE9aeVJ1R2t0eGUvY1orZXlaK0lZTnBq?=
 =?utf-8?B?V3dMdndEWkFhL1NuclN3RGtTcTVNRk5VbVQvUzVraTJRVWFMS3QrR3doNHpC?=
 =?utf-8?B?blFhY3NtamFPckxseTA3YzdsZ2o1bU03Q2krUkppaGFZNGlpemFGbWFtTUZt?=
 =?utf-8?B?dW8wc2hzNzVKdjlXb3ZlYUVBVitRZEVKenFaRzRzaWhQN0dOYUg2SURzOTlY?=
 =?utf-8?B?TlhHeWFxNFU0WUdnak93alJHQ3VnUHlGVXNIRHdsc1d3VU94eHVxSkptLzN2?=
 =?utf-8?B?T0tWazNKQnF1TVZiT3pXOWNGV0ZwdnlqVnRnbElMdVhiTmFQbE5oU0UrUmp1?=
 =?utf-8?B?QWlTKzU0QWtjOG5uRThVTXYvQjBreENram5oYWRKeGVqcFRzWk1VQi9XRGxq?=
 =?utf-8?B?b29ialZsdGRZKzlGamVNeTFhU0lNOHdHVGlFVmNOaERMYWVISC91bnBPQjlF?=
 =?utf-8?B?dnlTcDd3YkFaQkd4a0RwaGthVmFhUmpuc1pWQ09uUUkxYldjbWc1dys4MlhT?=
 =?utf-8?B?RGpLQ2loWUlteHU5Qnpya3RQMmRzWUg1ajAxdTdZWWtYYmdkVnFtMitsQ1U2?=
 =?utf-8?B?UjBld1dEdXp6T1VWUkxra2l1cUxsbHZ1RDRpQmhQT0Z3MXBRVGpEaCtabHlj?=
 =?utf-8?B?QUd4alBWU0xmeHNBUEtDWkMzY0hZZDI1ZHlsa05SZnVMVWVtVk5UeFBCdEgy?=
 =?utf-8?B?Qk5OWDZNVzVQc1A0NTIzMVVRc3ZXTVZUVmF3MXRtcGowT0JwY3RJWjRvdFFB?=
 =?utf-8?B?Tk8yblNuR2VVUVNTN0JCVzdhOE9QVmhwU1l5RnZnNSsyUVlWeDd0VjZGTkNI?=
 =?utf-8?B?VXhlQmsrOGV4T3k1cU96NFYrMEwvYW5nT1hSOS82OWtmd0pvblErT054TEhh?=
 =?utf-8?B?Smd0YTROeU8xM1Y3bWsrQU4zb0RsYTgrdXRmN0NTR3V4NU12cDNGcEx0OG4w?=
 =?utf-8?B?ay9qNS9FeXNndHNIZE83RXJaY3lEYnZDQmpidlVkTS82MEkraTB3NHBGQnRQ?=
 =?utf-8?B?SWMwMUxWNmhTNzlrOUZ3cjVCaGh1T3MwSlRDWGpCSzZmZExZN29oTEtvTXNV?=
 =?utf-8?B?WUh2RkpRWExDam5MV1huUXpSSm10MTJKOVgwRjJUVS9uRm9MQWVCUUFYdXN2?=
 =?utf-8?B?UlNVZ2NuOEFLNlBvcXAyTmxjY2lFWkNTNlE2cEVyS1VIUGFiMDRnY3JwWlRM?=
 =?utf-8?B?WFFERXgxUlFvSVJUaXRzYWx5djhhQzRQQmtaUG4xamJSMmxkWFQ1NFZrQXlW?=
 =?utf-8?B?SDIzR1pHYkpEcWR1OGR5SVVyTjY3VnFZSzdMY2NxMlpLMWRMeFcydG85UXhY?=
 =?utf-8?B?REFNaVJOMlAwcXFWSlJWSDNaMDJPUVFjY2d3bldQeDh3eFREbHRndGxpQUxM?=
 =?utf-8?B?aHJoVG84K1RQTjd2Z0VRMTl6UEJQdjhMY3BnVnJjWmVYd0ZxZVRhN2RTVUdF?=
 =?utf-8?B?RkRySk81TG1CQmFMUGlGSFNmSU1hNmNYRWZ3YXNEUG01S1BidHFTWVFsVDFU?=
 =?utf-8?B?TTNMZit6UGhSNDhTREFjdjZBYkJNeDBVVmZCTjdNWkk2eEcxTjlnQzJweTk0?=
 =?utf-8?B?Wmt1Mk9kNFIzWTRyL0pqYlVZNk9FYng3T2lyVU81cFdFZmYzYkdYZXU4ajBR?=
 =?utf-8?B?WmxSaDYwTzd1ZmZrNFkyZFlmUTVjNEhQRG54aWpxS0RGTWx0ZUxobHNSWmxI?=
 =?utf-8?B?ZjRESzBieTZYb0FSMS9LVm95RCtiUk54Y1NIbzVac1BzYkpsREFpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977e3459-10f0-42d1-eb78-08df23e46a3d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 20:00:05.3023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzAErqZN9Gc4iUyKiCKpOH7z941A0/2/VjGZ8iiO0ukw91GgmVNG01MATgaJCtbn8+LwrK2fQKdwHgk0mHt25Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
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


On 2026-10-06 08:51, Dhruv B wrote:
> In heterogeneous or non-uniform NUMA systems, a NUMA node may be
> CPU-less, memory-less, or both CPU-less and memory-less.
>
> Previously, kfd_create_vcrat_image_cpu() assumed that every online NUMA
> node contained both compute units and memory, attempting to create both
> CU and memory CRAT entries unconditionally for every online node.
>
> Add explicit guards to:
> 1. Only create Compute Unit CRAT entries if the NUMA node has valid
>     CPU cores (kfd_numa_node_to_apic_id() != -1).
> 2. Only create Memory CRAT entries if the NUMA node actually contains
>     memory (node_state(numa_node_id, N_MEMORY)).
>
> This avoids emitting invalid or empty CRAT subtype entries for CPU-less,
> memory-less, or both CPU-less and memory-less NUMA nodes in virtual CRAT
> generation.

@David Yat Sin, I think we currently support CPU-less and memory-less 
NUMA domains already. I know we have CPU-less NUMA domains on MI300A in 
NPS4/TPX mode. And I remember we've fixed bugs on NUMA CPU systems with 
only one DIMM populated, which would result in a memory-less NUMA domain.

Therefore, I'm not sure whether this patch is really needed and I'd be 
concerned about introducing a regression. Is ROCr able to handle the 
changes being proposed here? David, could you take a look at this and 
maybe even test it, or find someone who could help test it on the system 
configurations I described?

@Dhruv B, how much testing have you done on this patch series. Given 
that the bug in patch 2 slipped through in v1, I'm worried that it's not 
very thorough.

That said, the patch series looks good to me now, in theory.

Regards,
   Felix


>
> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40 +++++++++++++++------------
>   1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 7dad8f30ff2a..329931b0edc6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1944,28 +1944,32 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   		}
>   
>   		/* Fill in Subtype: Compute Unit */
> -		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
> -			crat_table->num_domains,
> -			(struct crat_subtype_computeunit *)sub_type_hdr);
> -		if (ret < 0)
> -			return ret;
> -		crat_table->length += sub_type_hdr->length;
> -		crat_table->total_entries++;
> +		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
> +			ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
> +						  crat_table->num_domains,
> +						  (struct crat_subtype_computeunit *)sub_type_hdr);
> +			if (ret < 0)
> +				return ret;
> +			crat_table->length += sub_type_hdr->length;
> +			crat_table->total_entries++;
>   
> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> -			sub_type_hdr->length);
> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> +				sub_type_hdr->length);
> +		}
>   
>   		/* Fill in Subtype: Memory */
> -		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
> -			crat_table->num_domains,
> -			(struct crat_subtype_memory *)sub_type_hdr);
> -		if (ret < 0)
> -			return ret;
> -		crat_table->length += sub_type_hdr->length;
> -		crat_table->total_entries++;
> +		if (node_state(numa_node_id, N_MEMORY)) {
> +			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
> +							crat_table->num_domains,
> +							(struct crat_subtype_memory *)sub_type_hdr);
> +			if (ret < 0)
> +				return ret;
> +			crat_table->length += sub_type_hdr->length;
> +			crat_table->total_entries++;
>   
> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> -			sub_type_hdr->length);
> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> +				sub_type_hdr->length);
> +		}
>   
>   		/* Fill in Subtype: IO Link */
>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
