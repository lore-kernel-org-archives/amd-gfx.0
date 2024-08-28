Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2974C7114C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 21:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7CB10E5F7;
	Wed, 28 Aug 2024 21:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3jxxBI93";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B450910E5F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 21:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpeWVjkgm0NUNbCY1LfR+HehwKNE+1JIpiIN11OPzlRgQv9O1WU/p/6UkGh1bfdY3bHOZSL/s86WIg3nwtRW2N6XgreDqZWk5P/udpdsFtOfngMpaYdx/yIwDE1Gu121JaxNS5t7YGmRots6J3SEO9KctPHK6cdlk7ZQQeUVUm5dQ9x4WCTjhthb+dxGBp5h44rXwkbHbZvbNtAWbELMUU5BSXQmSVF7M+d2kQG7UcZ6AKgUyfjGFlWbmbduP7X4kBYSZLLoAZrnhx+hu3T3/2bNIR+LUG7ujxH3Dh/V3zQ55EmCECINDHfns16sOP3ympCeZTg/U0ZA76buvy7kQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrMjWPT38PxsqcRDV0OtL294pZGVvTCpquvwAeMPapk=;
 b=LlKWJuS34oKrDDwwtZ/f7ETeQLAyssSLxA2MyD28olDCUogpy03Eb5dQbhZl5pjJ+nOAUQRS54XvV+Y5J9YaF1rUNztLUv/tRqqMIupJDOwvJuuEsvj7eUfHJaMPJA2MSKg3mdjGGZt+h9/w+HHqD2no8Y+T6KUMqM9h4Sf5zMVi45ub3XZXh+n9y8WvdPan0wtlvev6wqF2d2wVuIcAnkONkCzq0wMIYAMrqWQz1SMNRltc6fM1JJWNB20hyXVrNTNp5eGuo/bfq/MODy+bN5OWX24qYaP2pyUa0Zgb59h8uUZnN9tleq3ziwoIeZP0esSa03yILwl23SPmF2RCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrMjWPT38PxsqcRDV0OtL294pZGVvTCpquvwAeMPapk=;
 b=3jxxBI93O2RSMaoHgUBxThdyU8hGfMBKXVbzy1DgjhFFG2Js87qz1ns+oFSi0HNa2CFc0OW5AGVBWjrvd9rtJXD3RDY+S1sfq8ZzhPBu0zjscY90IOIUb1zQ7z4h/JiOjYdAXCrUEEa94RAjyHsN2hMlo3oiBzQbgaFT42G//bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 21:37:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 21:37:45 +0000
Message-ID: <c9e988f7-b61e-4d90-bcd6-72b826f3a598@amd.com>
Date: Wed, 28 Aug 2024 17:37:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missed queue reset on queue destroy
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, Alexander.Deucher@amd.com
References: <20240822151755.4167439-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240822151755.4167439-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 1594bfbd-b70d-4d03-48cd-08dcc7a9a780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3BHN1FpV2llR091THVGbUxUcWxTVnRvUDBFcWZoT2crQWhQV3pRckYrQ0hY?=
 =?utf-8?B?eHljSGpYTnVyVERPcWVleTVFMVdVc0ZNK3JYcE5rV2xSeHA4UkphdGF2VlZ6?=
 =?utf-8?B?dlF6UlhIZXdzTFl3YlQyOUMvK0QyaHdnZDc0QmtvMmdRL085djV2REFoaVBZ?=
 =?utf-8?B?K1BVaHl2TWlkUXl1Q1NXM0pPZDQ3bTNsUUhHR05Rd3hmWVZtdnpOam9nUHFC?=
 =?utf-8?B?cTY5VWNTa3ZVOGtEQ0pVUjI2cnNKdVZYbnlDL2ZOSk1rVFdaTFZscEg4Z2kz?=
 =?utf-8?B?LytDUWU4K1ZoQ24zbENmQklXM25jV05SM0lNOU1UMVNLdlN0V04xYVdmTEpz?=
 =?utf-8?B?clcwUm1EM1MzOFpKSVZ5SFdLWHBOalB1OUQyK3pTZ0VwbnhWbXYwNlRHcUhp?=
 =?utf-8?B?N21SNGlhOUJwQzNNYlpEd1JJUk5jeUFEMW1udCs4S1lTQTNsZ2cxM1dXQ1k1?=
 =?utf-8?B?c2NqZTZkVE41N2F5OUN3OGJFNEsyaitjOGpRZHVDVHA4UklPa3lFQ2RMSW1J?=
 =?utf-8?B?clhueUlRQk9sVjdpZmNOcWUzR3ZnK2FnWU8ybkhIZjhxUTNRQkJYdm9PSU1Q?=
 =?utf-8?B?OWJudEZTekdoT0dFMUo5anhubzROZGYvTkR0ZDhqWWtYeExENGRGSllxRnh6?=
 =?utf-8?B?c0M0ZjZHR3Y2KzMwUWh3U3BCNFZxZTdqdEFPNU1TTDJEKzhiN0NYa2YyT2Ft?=
 =?utf-8?B?c2FZVnF6REFhdi94TkwrcUhteUtrR0tHMFJRYjJiZS91cmZkb1YzUUg4VW53?=
 =?utf-8?B?OVl1WWtYTWNVeEZCODJCRTYwL05SMzhxM0dLb2tEMTdFSlRocU0xQnE5Nk5B?=
 =?utf-8?B?NnVKamxmT2dSVGdlcExCMTk2bEplemhsZ1hGSlk1REU0YkNCcjZSYUI1R08z?=
 =?utf-8?B?QXpQZzBtN3hTcTVTTkFnT1FNdGNxbzhYWHNxVFpVL1R2ZXJPU0JsV3pya0hS?=
 =?utf-8?B?bHh5VmRWREwva05KYUJYaFR4aWpBMFhYMVBEQ2VKWWFpVEMzNkxJQXVTbkNi?=
 =?utf-8?B?N1Z0ZTRrKzRlRUtvZUpzMEg4T0lNanhQRVFLMTBiRDZYMENyMGMzU0huekc3?=
 =?utf-8?B?OWtIQ3lkMzJXbjNja1YvRFJyWVFHQmhONXpKc0MrM2ZDRTNzbHhDS09yMVJ4?=
 =?utf-8?B?MFBIRmNRYjZOb1JMU2RIaGZmaXJNVE5RWWlQWGc4cFlVVnZucDE5Q05ybU8w?=
 =?utf-8?B?NXpCRDBHc1podk0vUzlXNnVOWUt1KzhnUzVGZW1zZm95b0VVMzRyeldYMi9X?=
 =?utf-8?B?ZGxKRjFPcE4zeEJWUGhESEw5emdOUlpMQThHWnJOWnh4MUxLNTNWbG1uMkJ4?=
 =?utf-8?B?SFU3aS9VZGJtVVhyaVhJNmxWcDdtcVRjVTdrdlN1SXpTaFJOVXhadzRSQnlk?=
 =?utf-8?B?a0hraW9Od3BySFNKTzl1SDN0SmJQZW1ZejBkK3NZdUJJcm14eTdzem9aYlRt?=
 =?utf-8?B?WTMrSC81c0N0SFRIOVZJYU9qSnczcFY0NFlmQjNhRkUvT2xUeXhORDhRSFIz?=
 =?utf-8?B?Q3ZvS3lFdHJ0RnBibWE0YUx3aFIrak9pbXZ5UVZHekEwMjh1SnVmd0hHUExY?=
 =?utf-8?B?TURyMUZPcis3bUVJWGtLaHMrK2taeEFTcVFNNmJNbDBWWmJlUEl5d0VqTWFz?=
 =?utf-8?B?NWxPdmxEZWoydE5yUXhQbXM1Ni9XVDFLK1BlV0JjL1A2cDljOUQxSVpUWjlk?=
 =?utf-8?B?ZTdoeEtBNE9IQ3RaenF6b3hRUm9YQnFJbzMrVW9UMVdoVFZJUWt0ZWIwQ3Bs?=
 =?utf-8?B?L0lhdHRoTzNPQ2VrUWV6bCtrcjY0dWt1MmZ2ZFBOdzRjZ1BFTXdjTEFEcmF1?=
 =?utf-8?B?N1RRb1hEYURwaXl0T01NQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnl5ODByYitjeEtYRzl5T1VRT0doZDhVSUNXL2VUdlVnSTF3S1NHdU8xWlc2?=
 =?utf-8?B?ZTFGK3NQZGN2MU91YnNncnE4QmU4T0xYcGJtOGlHeWVsRlZnWnI3U1lpMXRE?=
 =?utf-8?B?M0JkbEt0T2NvL0cvZ20xNS9aT2VKditPRk5IUFF1UmRQNi9OUlI4c05FbzB4?=
 =?utf-8?B?Ym95SnBGZm5iR1ZONWlFZWYyNFFnV2lwQXllTzdCRGdxY0JaYjV0NVJUdE1u?=
 =?utf-8?B?SVVlOUxHeUZKUXJ3dFhRaGdnVk85ci9Va3JUYjdVSk9tZmhoQ2lncDlmeHR0?=
 =?utf-8?B?OU8rMHlkcFhaMEo0YVpjd3B3RUcza05rMjduaWZFbXFsOTk3QTVaWG5HSlR1?=
 =?utf-8?B?Z0ZsSTI4d1N2M0cvbzFPWjFuM2R3YnhxWkk4V0FLWW9PQWdLNDFqZS8wT05L?=
 =?utf-8?B?L3ExYjUzc2VTVEl6NzhXZDJyS0x0VkF1R3RvZjNnQlc0cTRBYXZHT2FRelNT?=
 =?utf-8?B?RXJwNDkrZnFadzBqaFRaRi9NZURzUG96TGxVbGpTd2JPRVdENEZjQm5rNytU?=
 =?utf-8?B?NkJONkJVR2l0Mzd3ZzNZTUlCcDJIWGdFMkgvRkU0djRwd1h2VWUxaHFUZi9v?=
 =?utf-8?B?M1pMcVBRRTZ0b2Zhb3VDSTd2S2E4WjRHSTZZTVcxWHFtQlpBYUZZSWtQVDZh?=
 =?utf-8?B?R29DNzA2eXZxYzBXTHhCMmNraHROM210QlNhNFZUdWxtK2NWSW9qS2QrWWlX?=
 =?utf-8?B?QlFVS253NXMwbVVHT3VmZW8vazVPOUNyUys5WXM0WnlTQ0ZOS2hlS2hWUUhN?=
 =?utf-8?B?ZTFoejF2ZVU5QndEeStiaUdRT01JeGpGc2hqbXlMOVNhdVVjYTBhcUxsKzBP?=
 =?utf-8?B?UXlwY2xQNm1MVUdSM1BTaFVmWE5jL0llczVwbXNTamlVMHdUTE1oUkVHSTFx?=
 =?utf-8?B?TThXRDBDZ09Ea3phMkdpQmhJNjJXVE5HUWN3dnpaQlF0K2lkVnFFNDhpUXln?=
 =?utf-8?B?eVdjSWFEazE0QVVQSG45eUJiblFZQWtjVzZrRmpKVnZUYjA1OU8weVc1Z0l4?=
 =?utf-8?B?VmdDaWhDMVh6Y09aYllDdE82ZzZyWUZjT05DYnZNWUYveFFuNjR5R1ptSlgw?=
 =?utf-8?B?VitKR2hkOTI1a3hMMDFuRVhaTWRVcDNsSUVYUklxdkZ3ZUFHTG9SMmtrZzdN?=
 =?utf-8?B?NnhUTEdSSm55V2tLWWs4R0N0ZVlodUFqT3N5M3duanlIdlNUL1RMZnZUc29p?=
 =?utf-8?B?OVlHQnR5MUs1SEZ3ZVJvWEtyQTluVktMSzQxeDQ2dk5BYzVhSUFqUVlZRHo0?=
 =?utf-8?B?TDM0S3h6R3grK2Vma2ZvTFJ6Ymg4enFtUk5ib0IvaVYvVHkybEtxbHEwUXNQ?=
 =?utf-8?B?b1UyckxkamlZbWVvMTVjV0NPTkN5S3RTWDBGb1BPS2hLZE1TT0RNTk5SVlpW?=
 =?utf-8?B?TFN1WVMyaytqV1ZsMkFOL2w3YXRReGhhaTlMRzljVjVXeUtENE9UdmU1TFMv?=
 =?utf-8?B?RjU3RWNvZDI5eGNaWUxhbDNrMnk0TGJKWmJoY2duM3ZmeGQvalNocnRDdzJu?=
 =?utf-8?B?TFVvbXE0SnBjQnlVMko0VTNvc0haREJkWXdnZTlBdTFXSmZXUnk1WnZDcXlp?=
 =?utf-8?B?dXdFZXZKbENHdENGNXlteUxKTThIQlduOC9PbjBNcnNLZnA4djZ4T0Q2S0tU?=
 =?utf-8?B?MzBnY2NBUDNwZTB3QW1VazJIZDNVNktNcGwrVEhuanV2bmVwQk15bHNaTmhZ?=
 =?utf-8?B?clBRcWlTOXQ3eStGaFlwTmhuMy8zdWVXa20vSzhWTzYxeGhWY1ZDQkNmN1Mw?=
 =?utf-8?B?SlpmUlRlYlpEL3lZRWgrQ1hqOGN2U01wQWpmdEppVDNiOFIrNmpzUmwrQW1U?=
 =?utf-8?B?OURxNUIzc09USW0yMHJxNWJtZ0VsMFZtZC80MUkzb2t4eElBeW5jUFVJNFVN?=
 =?utf-8?B?VU1oZWsrUjhWcjFSRlE1K2VIRFlzUTFGbnpYNEU5cUM3bFVEMjI1VzZ1cmtT?=
 =?utf-8?B?TmJvUWdVSVJYS1pRdTJteUw5S2dXVTVlSWkyR0FOcUNOSUFBMkZoY1lLeVQz?=
 =?utf-8?B?UlVzcFlzRnZvNEh1VjdwTDJ4WmdVcUViamtYQlQrcDIyYisreEFRWjB4eWlm?=
 =?utf-8?B?RG9ia285MUM2NHFRc08rSmxZU1hKU2FhSUpOV0ljakIyckRFS0VPTDBrVllz?=
 =?utf-8?Q?FJnyOxvT+/K33HiNo3cYtCKzh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1594bfbd-b70d-4d03-48cd-08dcc7a9a780
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:37:45.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT40xvw+GPFb96GPrg0D/C03skza7g8tp2FO5at7UFXTD5yreuE5wt1WsIgOJz7AAm502LGWdjhD+/82nsb0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
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


On 2024-08-22 11:17, Jonathan Kim wrote:
> If a queue is being destroyed but causes a HWS hang on removal, the KFD
> may issue an unnecessary gpu reset if the destroyed queue can be fixed
> by a queue reset.
>
> This is because the queue has been removed from the KFD's queue list
> prior to the preemption action on destroy so the reset call will fail to
> match the HQD PQ reset information against the KFD's queue record to do
> the actual reset.
>
> To fix this, deactivate the queue prior to preemption since it's being
> destroyed anyways and remove the queue from the KFD's queue list after
> preemption.
>
> v2: early deactivate queue and delete queue from list later as-per
> description instead of destroy queue referencing hack.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 577d121cc6d1..6d5a632b95eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2407,10 +2407,10 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   		pdd->sdma_past_activity_counter += sdma_val;
>   	}
>   
> -	list_del(&q->list);
>   	qpd->queue_count--;

You may need to move the queue_count update as well to keep things 
consistent. Please make sure this passes KFD queue tests on GPUs with 
HWS and MES.

Other than that, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   	if (q->properties.is_active) {
>   		decrement_queue_count(dqm, qpd, q);
> +		q->properties.is_active = false;
>   		if (!dqm->dev->kfd->shared_resources.enable_mes) {
>   			retval = execute_queues_cpsch(dqm,
>   						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> @@ -2421,6 +2421,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   			retval = remove_queue_mes(dqm, q, qpd);
>   		}
>   	}
> +	list_del(&q->list);
>   
>   	/*
>   	 * Unconditionally decrement this counter, regardless of the queue's
