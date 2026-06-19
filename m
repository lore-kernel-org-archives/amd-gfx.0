Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6BFCD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 18:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C012710E0F3;
	Fri, 19 Jun 2026 18:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dCNMhva9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1B810E0F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 18:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/R5uIQ3IYl6nnqAeDIgrMCV4G243UJy+AZZqyC6mnDlNzFDIhNf3i8s0mdRdQiSxkmoH2rYMAUOl5L7xtqTHenFmewwob8Cf40q1r073BIiGbA/j4iZy6V0n7iBPpbsDcBd94A0LRHo/0UqdRBV9vhziJ8WK4q55t5vPpOvMsFi4PrNmq60pAp/Eg/ZqnUUcR5KCrrD3wGl2SbSiRKtjrbRHipBD6XAhEeMihEFqWGWtwZhaoaj9Om27u7cuiyM9YId+DTqM7WmqDDTY4dvDGBgi+esOOr0yX1L6a/I4dpzVb7PhbynmqorygHQ7s7fmUUqDaGszDU55Z28Sf74AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krEuOXRy28L9Zw6RwncW/PC0aeqkOdnY4ZpTsotCw/Y=;
 b=fukTj4wiHD+Sb6Il32AyejIJ/Ujl7KPVIlg/9ENCTP19LbRT/wuNwSS6akUj4q7U0ypB44T7p+eH5oSwUJMQCaQipAX+pV64EzMyjTzh9M2vXtJvuuFT4SJ4lXsV5cwCltnsHTMP7Af7NHiAfwcDYknMNOF7cyWsf49B5tdMOnCh0NoXak59RbKdgypcy8E6l5OEJjRojLnzJ3Qo6RysbrhAwfFsxQtyCx/dbmhELUhEnnnwDIPFmM0DyAelo2h19XyjRSB4QFqd+V6f3lFljT5TP0wOr8z4/g1czL6mvZk3BpJfWzi0pQycDI5DHEiB3O54vKqZnpoUcKqbanke4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krEuOXRy28L9Zw6RwncW/PC0aeqkOdnY4ZpTsotCw/Y=;
 b=dCNMhva9Hr3niK/HLDGwi+b7cwogU62OGcd424q6OTJ/2tnPfb9Zj6AkuPqZ9OXkK+CR+ytkK0RrtwnWMEQHJwQSW2MfaJeOtHIKmbFH1XMQwUIiUwKg0be8O4fTF5RMyZQkUaIuqszhbhFrW1lnzT/TUCcvlJDQb1VD3stwaMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by IA1PR12MB6482.namprd12.prod.outlook.com
 (2603:10b6:208:3a9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 18:23:59 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::3c75:97d4:f574:9dd8]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::3c75:97d4:f574:9dd8%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 18:23:59 +0000
Message-ID: <11e0fb31-65e9-42d9-9721-6969dd6dfed4@amd.com>
Date: Fri, 19 Jun 2026 14:23:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: drop struct kfd_signal_page wrapper
To: Yongqiang Sun <Yongqiang.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260619175236.2649795-1-Yongqiang.Sun@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260619175236.2649795-1-Yongqiang.Sun@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0446.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::7) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9828dd-6ae0-46d6-7915-08dece2fee8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LJmeTfHMMDrT2vNSIwlhb70wYG3XYE81OtoTOtXu+2GXGFpHeF4wipUrl+G5phE1liG+MskqcfhhSHj6QI/EdDm9imnROlYjxECTcEBkBxEF+/jgJDtuzUwvtwf0h0EkmY50GLZ1ZMxQcpW6LNC3h54cJboEknXXSxS7KJjX1/K0f13NgLG6hNigca+P/0767BeI74ihYFSmWPl4etjoOnlENg9qMJdb+5X09y6z4yycoW5XWsNpRhY5aFoBqcJ84ychDMiaHILIJf9Ak6/PU0xRZBZ9Cvx012sL5OLacWIuVwJyaQwSFdL6euNRJDvVMBzj2I+Ss+jRltyjGP9nc8pIQNSIwZLxrbOPOQF2XDmdUiggWXK0LwvmGkjgylfIBAyTkphttjwkggBYI0dkcHFnIqsMRKZoaKRKqw130ZheUBIzdiQGz5l3f/EvPR9mmmnXItjfr5JUKjWeumgVFPpNskY0qQovK66ayqbAIz3+QRV2pdddwd8LcwUgJbVfHE0W5qF9Ki6ZzOR+4nyxTWUrswUJx4T3eM4iGmv9lCqg9+OkjpGUQERv3Gq10EgVG+4hbe5rI/y10wKFGmLwYddZLYQYtE6pD9nK52HKZ1UW42zorbjW/eqGZ+fFxaFeqXuxwbcmN7jkVaWyhTpUMBzW2eIEV5IvTIEzBgou0GM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2JRRkIrdXdHYkFNZC81RHlCdG95NG81MGlZTVVGVzRROExPc0w1ZUlmWjU1?=
 =?utf-8?B?ZHcrVU9EWVN6bkpuSmpCYW1BclhlUHVpY1UwM0VDMzh6dThFUU1mT2FscmVn?=
 =?utf-8?B?MHZzQTN6RkdBMjhnMGJiV1VKcjJvclZqcmpRQTBUdmhoOVlPYjAvQi9TVUUz?=
 =?utf-8?B?eFV0WlY3d3pXdU5ZZis1c0J1bHR0YVZFblZhVm90Y3VackpxcXB0eHFtaXNG?=
 =?utf-8?B?NVNRZmlIYTNNa3pTaFRVNVdlcGxwV2lFVFRDRDIwRXhyZ1JTRStZWENHcG0v?=
 =?utf-8?B?bDhYdkZOZEludXgxNW1zQnNod3Z2cG1vRmZtVnlVYlFwMVdFRjMzaG5wcWlV?=
 =?utf-8?B?YTZGSzRTSmRLbUdzR1ZmcHlvVUpydjMrcnNmdkR5L1NSdlNoSUFpc2JVaEMv?=
 =?utf-8?B?VldSWE5XQk1jeDNNdjUra3U4WDJNVmFuTFRpYzY1S2dWaTVVQWJsb29ibzg4?=
 =?utf-8?B?YUZRdVhjaWlOc1BzdnczbkxqcW56WEdYRlNtdnZ5aDlIZkhuTHVxdFNMcWY1?=
 =?utf-8?B?TE9RNG5HckFjZFVtMGZKRXQyY0ZhTlRoQndKL3FpNm9ORk5LRjUrcVE2dys1?=
 =?utf-8?B?b3JCTXc5VHVPVUFlb2ljQVZJK3hGV3R3VWorTk5KWW1hK3dmQmN1ZitSMDBr?=
 =?utf-8?B?eFlrcUNCQ1NDa0Y1SlRnaTYySTN3SGpnUDQ3VXdDamRjQlIyWlhPMjNocno5?=
 =?utf-8?B?TzQ4LzVaRG1WMDN5dFBEZjhoc2E5MkdISE13ekVUNzlRQkNhN3lJV1JSQTE0?=
 =?utf-8?B?bHJsRVZtbmNkWXV0M2dmdlFUSkVMRDYwNS8waTNyKzI3cnMzRWZmbzBJTzdS?=
 =?utf-8?B?Znh4SzdjT2NDUGZZakMrcTkxSm5JTUtDL1pTM0E4NEFwMlAyejRwT2NnWWdv?=
 =?utf-8?B?NmNVUU10Y1pBZzNFV25Hek1ybWN5M2Rmbk5CSzNCU1doUlBpTDRMelFQM09i?=
 =?utf-8?B?UTFRMWY1ZVpHdGlvUFVyTGxlNEU4c1dPd0ZUWW0razdON2VkSGdOWlExYTU0?=
 =?utf-8?B?aFdDd0h6bWJyS1hKRWRCNWJLaG16K3RxSTRlRVR5cm1UQ3lVUCtnazY1VVZQ?=
 =?utf-8?B?K1hReDJmMTIxSjUzWVRLdk5wcjV6TmIvSHJoQjI5bWpibHZ1NFUzQUJFTDBO?=
 =?utf-8?B?Wm9mTW9uL3V3V2o5SllreUs3S2E0V2E2dmlObEVrQW94UU1URkIvN1FqNkxF?=
 =?utf-8?B?QmdjMGkyMzdKb1lDMDZjd1VPNXZKdHZPUm01eElDZDYvS1hCSjhJNjN5SUlj?=
 =?utf-8?B?R2pCNTF4M3ZNZktuVWZlOWs5b2s0M0g1RTJGSFFmQnJxUGxIYmY4bS8wUlBH?=
 =?utf-8?B?TExYdVUwYjJWdHRCbmIrRFNQSXZ4Y24ySGw1Z09WOUc3dmYvOVVDSDl2RlU2?=
 =?utf-8?B?dmFWcDJETUMxOUFoYlVZdFVaTmx2RXVlbVJ6WmE0eUN6cytwQThhM0duejJy?=
 =?utf-8?B?L21LNnMvR3BZMTB3UDduOTBqc2RsUXdVejVRZk1HTVlLRGVOWkpnUlJsTlB2?=
 =?utf-8?B?ME1VSTFjZ25SU2g2WEt6YytKOWkrL0J6bE1JaCttVUpFRVhjRjU3R3pmK2NB?=
 =?utf-8?B?WW5adkIzS1lFT2JidlFnbmtXamhhU3gxUzN3QUV4UTlLcWNPRHdLVkorUG5i?=
 =?utf-8?B?QWEwSzJlZE9sOE5jZDNrK29vNzROK1lBSkNPYk5Ic0J2ekRXOWpEMitNWWsr?=
 =?utf-8?B?ckt1NVdFWUtHWU8yYmEvSzdhbndzNlBDQVVGQ3ZDbEx5VUJHOWY2RUVjTXNq?=
 =?utf-8?B?UjBWUklyTjFsUFBrTmFZcjBHcU5UTjhSSjA5aEQrTGRVUUw5Ui9QKzN4WjZO?=
 =?utf-8?B?QUpqZThZRE9kM1dNNUdWa2g0YmZreTdTS09NcHJlekdUbnBKOGg4WFNXdlBv?=
 =?utf-8?B?UHVjMXVxNjJnczNudmtxQmdqNWJFSTVkdCtFV2EwOEJoRVVoU2t3STJTY1BB?=
 =?utf-8?B?K3pEUjNFek5VdTVjMWFPa05lWldFbFZ5L2gzL1ZVbGk2d3VvZ2tMRXh1eWFB?=
 =?utf-8?B?R2hBcnhjZjk5L25rRUlXMllWOVlGU3ZYQWc4WjdJcVJLNlpmQVl5UnhJYzBT?=
 =?utf-8?B?bzVmbFN6dXpSa1h2VTRWN2M3ZnFMR2VSTXh3T2hpOE92TVRZNTVSOExWZjBV?=
 =?utf-8?B?UGk0ODBSZXZxV3UvUnZQZzg2VTl3YXRlbUFSODJmMGdlQjJPK3hZbGp2ZDAy?=
 =?utf-8?B?YWRpUEFsaTYzSXFWbkpZeHQvY1NBeUVqUDZ0eGlqdVVrUklNQU85WldRYTgx?=
 =?utf-8?B?SHVRZHBCNW5udWdvb2dxTVNBWW9HU29BNklmYnFXL1drR0Z6bWlTUVBicEs1?=
 =?utf-8?B?dktMeEdNTnh3QXFpbXBnZDlkZjdxa2FWaHlranBDRWQvZVhDN1ZZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9828dd-6ae0-46d6-7915-08dece2fee8c
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 18:23:59.6793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw65bTstwa5drnLetbZog4d48h9cYZkdT8KIysVvM1E7LN1vDSAwtMLIj3KbW/NzFaC3JN4z38DTDfajFTYXyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

On 2026-06-19 13:52, Yongqiang Sun wrote:
> struct kfd_signal_page now only wraps a single uint64_t *kernel_address
> pointer. Drop the wrapper struct (and the page_slots() helper) and store
> the signal page pointer directly in kfd_process::signal_page.
>
> Since the signal page is the GTT BO mapping provided by user mode and is
> not owned by the events code, no separate allocation/free is needed for
> it, so shutdown_signal_page() goes away as well.
>
> No functional change intended.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 48 ++++---------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.h |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  9 ++++-
>   3 files changed, 14 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 85e4ad10d619..3ffe9a52f3e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -46,22 +46,6 @@ struct kfd_event_waiter {
>   	bool event_age_enabled;  /* set to true when last_event_age is non-zero */
>   };
>   
> -/*
> - * Each signal event needs a 64-bit signal slot where the signaler will write
> - * a 1 before sending an interrupt. (This is needed because some interrupts
> - * do not contain enough spare data bits to identify an event.)
> - * We get whole pages and map them to the process VA.
> - * Individual signal events use their event_id as slot index.
> - */
> -struct kfd_signal_page {
> -	uint64_t *kernel_address;
> -};
> -
> -static uint64_t *page_slots(struct kfd_signal_page *page)
> -{
> -	return page->kernel_address;
> -}
> -
>   static int allocate_event_notification_slot(struct kfd_process *p,
>   					    struct kfd_event *ev,
>   					    const int *restore_id)
> @@ -93,7 +77,7 @@ static int allocate_event_notification_slot(struct kfd_process *p,
>   		return id;
>   
>   	ev->event_id = id;
> -	page_slots(p->signal_page)[id] = UNSIGNALED_EVENT_SLOT;
> +	p->signal_page[id] = UNSIGNALED_EVENT_SLOT;
>   
>   	return 0;
>   }
> @@ -139,7 +123,7 @@ static struct kfd_event *lookup_signaled_event_by_partial_id(
>   	 */
>   	if (bits > 31 || (1U << bits) >= KFD_SIGNAL_EVENT_LIMIT) {
>   		if (signal_mailbox_updated &&
> -		    page_slots(p->signal_page)[id] == UNSIGNALED_EVENT_SLOT)
> +		    p->signal_page[id] == UNSIGNALED_EVENT_SLOT)
>   			return NULL;
>   
>   		return idr_find(&p->event_idr, id);
> @@ -149,7 +133,7 @@ static struct kfd_event *lookup_signaled_event_by_partial_id(
>   	 * and find the first one that has signaled.
>   	 */
>   	for (ev = NULL; id < KFD_SIGNAL_EVENT_LIMIT && !ev; id += 1U << bits) {
> -		if (page_slots(p->signal_page)[id] == UNSIGNALED_EVENT_SLOT)
> +		if (p->signal_page[id] == UNSIGNALED_EVENT_SLOT)
>   			continue;
>   
>   		ev = idr_find(&p->event_idr, id);
> @@ -261,21 +245,9 @@ static void destroy_events(struct kfd_process *p)
>   	mutex_destroy(&p->event_mutex);
>   }
>   
> -/*
> - * We assume that the process is being destroyed and there is no need to
> - * unmap the pages or keep bookkeeping data in order.
> - */
> -static void shutdown_signal_page(struct kfd_process *p)
> -{
> -	struct kfd_signal_page *page = p->signal_page;
> -
> -	kfree(page);
> -}
> -
>   void kfd_event_free_process(struct kfd_process *p)
>   {
>   	destroy_events(p);
> -	shutdown_signal_page(p);
>   }
>   
>   static bool event_can_be_gpu_signaled(const struct kfd_event *ev)
> @@ -292,8 +264,6 @@ static bool event_can_be_cpu_signaled(const struct kfd_event *ev)
>   static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
>   		       uint64_t size, uint64_t user_handle)
>   {
> -	struct kfd_signal_page *page;
> -
>   	if (p->signal_page)
>   		return -EBUSY;
>   
> @@ -303,17 +273,11 @@ static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
>   		return -EINVAL;
>   	}
>   
> -	page = kzalloc(sizeof(*page), GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> -
>   	/* Initialize all events to unsignaled */
>   	memset(kernel_address, (uint8_t) UNSIGNALED_EVENT_SLOT,
>   	       KFD_SIGNAL_EVENT_LIMIT * 8);
>   
> -	page->kernel_address = kernel_address;
> -
> -	p->signal_page = page;
> +	p->signal_page = kernel_address;
>   	p->signal_mapped_size = size;
>   	p->signal_handle = user_handle;
>   	return 0;
> @@ -680,7 +644,7 @@ int kfd_reset_event(struct kfd_process *p, uint32_t event_id)
>   
>   static void acknowledge_signal(struct kfd_process *p, struct kfd_event *ev)
>   {
> -	WRITE_ONCE(page_slots(p->signal_page)[ev->event_id], UNSIGNALED_EVENT_SLOT);
> +	WRITE_ONCE(p->signal_page[ev->event_id], UNSIGNALED_EVENT_SLOT);
>   }
>   
>   static void set_event_from_interrupt(struct kfd_process *p,
> @@ -723,7 +687,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>   		 * in the interrupt payload was invalid and do an
>   		 * exhaustive search of signaled events.
>   		 */
> -		uint64_t *slots = page_slots(p->signal_page);
> +		uint64_t *slots = p->signal_page;
>   		uint32_t id;
>   
>   		if (valid_id_bits)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> index 88e3797bfc42..827a2c7d7721 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> @@ -49,7 +49,6 @@
>   #define UNSIGNALED_EVENT_SLOT ((uint64_t)-1)
>   
>   struct kfd_event_waiter;
> -struct signal_page;
>   
>   struct kfd_event {
>   	u32 event_id;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f00c522fba74..ad4897f094a2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -952,7 +952,14 @@ struct kfd_process {
>   	struct idr event_idr;
>   	/* Event page */
>   	u64 signal_handle;
> -	struct kfd_signal_page *signal_page;
> +	/*
> +	 * Each signal event needs a 64-bit signal slot where the signaler will
> +	 * write a 1 before sending an interrupt. (This is needed because some
> +	 * interrupts do not contain enough spare data bits to identify an
> +	 * event.) The signal page is allocated in user mode and mapped to the
> +	 * kernel; individual signal events use their event_id as slot index.
> +	 */
> +	uint64_t *signal_page;
>   	size_t signal_mapped_size;
>   	size_t signal_event_count;
>   	bool signal_event_limit_reached;
