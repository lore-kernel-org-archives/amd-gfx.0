Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BE606D82E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BpMICIty
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3722610F5F9;
	Tue,  3 Nov 2026 14:31:48 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FC310F5F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEa9ltDivAWUPIGilW7JABEhEhcXuVd6idLTYgR+hzPiizqTgWRzjpLbe12a4HmuzN8SBgvAsQZ5mdnRbmy+bVnYKjBfDd8pOo0AKGPASRz13sOqTecqzwi50k9ILyf0g9a91D1sF2IIfZA5PJqcjF6EocmFnfR9zLBg7dTaWcXiUnTegXys+7aVZOQ0+S4f1SlNH4iWt+HMa5+3yH2a2hJWQzLAeGmbd7R918fuANaOJZr+UtVV+wxa6m2W4JvQXRsRsKneU8fFijoLg2HVFH0M56A3/AFIdDPtLtVnJpO9xWuRrrNSp1yNxcZg+wj8hfnsAKu8D2kJCFcK2yIYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBSrvr2PixpWCaEA6RufBXiG6zyhDyegS/mIlQrRCaE=;
 b=Btkowbx0PeHjSVGjY9I1oOxrN4ovaDk2LT4G2Q85UW31Kh+e/sZqm/8sE/7pjqbd4q/+A4N3swMEnqHDlWcC9GRKJPKEhTz5WIVFbM1X5xU8y8fIsPdZ3CATBGF1XmqBt9wkb0QUwnddnVcF2N37tXb+wthkgZ9wplFYtXmpeo6pkWcq+RvGh/Mmg7NM0zSQAt9Fofm2okAXlgGXg48nW5KEbBqgYVaMXTfNaHT3H8atoIAyAJfxrItusC8OW2h1eyY46GlP5AYBu1xEKLY0Wyrg/ldta7pC2nOkK41OzzEwPYV27y/l1Pj3J5/NhPmZAufRJs/sFvSpndN3u4CCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBSrvr2PixpWCaEA6RufBXiG6zyhDyegS/mIlQrRCaE=;
 b=BpMICItyv03HMLhqUrG5YAWwIoj74ME0vA6a1pf99uG3tkPObpHGj4ukrt9LcAPsB6Co87wSK28mOUs9mS2mUk6e8+tCX2vyZxbS+UN5MN8laYK6I6sLjwncw3WcnWpVE9vKelLsnN3N/sI1xhR0ZbGYqfBByTQv3fXaGLagvZM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:31:38 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 14:31:38 +0000
Message-ID: <71c2b705-8f43-4588-af24-01d5e36538fc@amd.com>
Date: Tue, 3 Nov 2026 20:01:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu/buddy: find range-biased blocks in the free trees
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, kent.russell@amd.com
References: <cover.1793108566.git.William.Palacek@amd.com>
 <528396fd339c6d7130c896533a621a20f709bd4e.1793108566.git.William.Palacek@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <528396fd339c6d7130c896533a621a20f709bd4e.1793108566.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0130.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::10) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b5eaf0-c459-4a4a-be7f-08df39b72b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|11063799006|56012099006|22082099003|261102123227099003|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3PMuuEknhhXwvY8yadb8eK4BCIvxq5xw0LPLzSehkGkkK9mJC/5Nsp0z0/TWIBansmhap+EGz0vK5VOxGHErRF7P03CW4dBjC2xwjDZw1cyrvC6mjflQ0qd5SYZ56fjjVXYQ1xloorqXqQJYUhwty2KGjhn1PnE//L8n/FZZm8dW3zLG3DCkoYRgquIMWKoGjPYbZA25ZWxaIqYXWITqHuNib2PhQYRuDKMrUJffkcWItdcdxhaAgaXh9GZK58rTNhShMtNRlYGY5HEVnNpj6KkNNVzND748Ens4ltQD75aJbkvDQZbjwtuZ0lg3Tp8+lxxPEhm3M9RvI+v+r4UgoT4lFMqgF0mm3rwJ+KRuTjD1wvg/rFFxRlGY+X2RYS47khidgyBP+VgXT29tCgAwVneW4KGYnv/eWO9WSjUG1exDlcjmiwvFm8fNxyHq1FEez+usDBgcJJYR8YMMjomN5gWTOm/DVtERc5AOrqSHrSkpPBwV3sZAbE9XBKU2FucMttR62TzR7uyRhY1B103QLzBDf7FqPQ+c157nSg8Oe1toEPFOd6wd5YfsIgG92+cqr3uIxc8vZwG4ueNowS6/jK71XaE0xfkyReYsZfxFeHt/HR/u3RqHT93Cw6aNL8Y6Wf3osahwBSoM3BFs0czYGaGC3Zol0ZoGeDNXHyfSrfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(11063799006)(56012099006)(22082099003)(261102123227099003)(6133799003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRuejhTMHo4OXJyTGcxMWZWb25lUm9rZDJFZEsramVrYUgrK2pqanR2OHk4?=
 =?utf-8?B?blpyaTBHMlBQSzdLL0t0dk00UVNISkFEVy92TUFobVNES1R4MXhQeDBaamJD?=
 =?utf-8?B?bVBkZ3RnUTU5OCtOdUVaOXFRbXRWOENOTGkvY0JmYXVGWHBtVDZIQ1R5WTFh?=
 =?utf-8?B?emRBVmpJT1JUTkVpRDRCUHNGNGdiZkhFaXZKUjlKeVIxdTlScXM0dWtVWHRx?=
 =?utf-8?B?b3QvQ2ovNTI0ZTNudFU5MHg2MW1VdXB0TGdDYU1JK3A4bDZmWGY4VGMzeTVl?=
 =?utf-8?B?NWFJVjNuQU1Sa0tGTVc5Z1VDM3hFMU1HRG1VS0t2U0lqU0xwQ1VJTlRpVWJl?=
 =?utf-8?B?TEJ6cmo3TDlKZnc2OFFMQUhnVlFDOEY4Q0xIbjNFZHA5WWh5Zlhsc3dlWTdS?=
 =?utf-8?B?MXh6ZjJCYStXZkJGM2ZrK2U2aDQ2UmFicVlGZWJXQ0pwTTZqOE1rdDRMbjdI?=
 =?utf-8?B?ZUEwNlRwL0NsaXRXQk9reEFjTzZtdzFOQ2U5cnMwVTdyRmJ6S2JtMEhkUVY5?=
 =?utf-8?B?bEhiWVlLLzdiRkw2NTdrSjhIak1VNG8yUncyVGJ6M3h1Y0NyZnFDZVB2TnR1?=
 =?utf-8?B?WGp1UzNxUWZFU1lSRGhQQjkxQXV4QkdOOFBScEdCWTBWekJjYzJ0ajlFT3Fz?=
 =?utf-8?B?RHBWOXFGRDcrNC9lZGtOT3R1UGUzRm43TWo1aE5LWXdMYkdIQUoxeGxhd244?=
 =?utf-8?B?aHBBL0lYWjRUaE5xVW90WDQ2MzJrQTZ5SVlUaDVJVXp5YWZIUEhnV0t2SFBz?=
 =?utf-8?B?NTE5anZtZ0o4bWxtUWJma3l3cDJmSE4xVlZsYW43Q1NZK3NiSzAxWnUvengz?=
 =?utf-8?B?K1pCZGwxZ0p1TnJDd3VWbXdvOGIzcThpSzFXQktld0RnWk5KSlpjQ3ZWcmc3?=
 =?utf-8?B?MU5zMEJKNklKazZ0b0FTYURNM1p2L2oxelZmN1Y5TmI1M2h2dnYxdFQ4ZmM5?=
 =?utf-8?B?cXkzWGY1cHYxREhlV0pWdktwcjRMb0JTdDdtRUh2WG43c2E5S2pJWm9rNE8r?=
 =?utf-8?B?S0ZyVmdzWm5QNDVQWnBnTGNkTG5Yb3BCR2ZodGxnMUhuN1JjVGx1NlFaL3Rh?=
 =?utf-8?B?NHhEdjN5eEV0ZE9QR3crWEpwT3F2TUlZWHV2aDE1SHBPRXNMNysvY1I1L0gr?=
 =?utf-8?B?WHYwTEdFby9ud1EreFAwR3FRelFtb0w5YnZuc3RtUFR1M0txaU1Ja1pDTGVz?=
 =?utf-8?B?U2Zzb2FsOTA1ZXFKUnFGVkFpK2E2N2hmOURYRHJBNmZRUGt1QkppYm13dzlW?=
 =?utf-8?B?QXZWYjVhbk8xVFJQY3RrQmpvSk9hOEppK0RneXpmRkt4YlJZWjBNY1I5eHdD?=
 =?utf-8?B?UVNrQTdlZ1NFb1V4ckt5VnY3akhnd2NXVks3UnEwUUVNZzdrR1Zqb3E3cnlU?=
 =?utf-8?B?QndDY3RHUlplKy83enBlckZVNy85UCs3QXpxcURnN2o2eWd2SmJheHNUNWpr?=
 =?utf-8?B?Tm84WHdOWDFDTzVTc0Ftb2tTZ3J0QXJaSUduR0s4YTRhcTh4TktjQUFleTZv?=
 =?utf-8?B?R1F6ZHRVQUNFVElsVldBaVdNUzM1ZjliVE1zeCtJOGttTlVyMUYzc1dUa1pG?=
 =?utf-8?B?aWQ3eng1QTF2a1YyVTZLdkQ5eGwwUXlmRm0vM0w2a3Z2UkllMThoNldpUXFq?=
 =?utf-8?B?eXhiVlVQVmtmWVA5VE5KTlV0YXJoMlVmNlY2WWRxUXA2QmJCSGJmTDFZMnVa?=
 =?utf-8?B?RHFXWkNsTms0UGphRDlJTEZiT0FQR0o3alZXS1dPMURlN3hEYlA5Mk9aa3ZO?=
 =?utf-8?B?NHlyclh6ZnhPSVk5VlpGakF1RVFUQzlSQjcyWXMxQkdUb2VUenlOQzZWMTFl?=
 =?utf-8?B?QjB6UVdWOExQYlRpNFpuajBxdkdJNi9ONExIcjdKQUNwNXVGM0V2RWx0OUY1?=
 =?utf-8?B?TVg2dE4vY3ZqTWR2a1pyWTR6dENxUy81VFVYMm0xSnZLc0lRQU93SVFSRURr?=
 =?utf-8?B?NUVGeDg1bmNqZkxpQzhtYnErOFpCVzcrV1ZLNmpSNE5yYkFDMnZrTFVFTU52?=
 =?utf-8?B?alZxM2s4L01Rd21aRDBENHhjdlU0b1ZPSDBXVVVnd0N1QjdYYUw5NTk1WldN?=
 =?utf-8?B?WENyRVlCbVdFK2RXQlNXdkRqR0Zqam5HUWtHdDdCeUZRUGpKMGxzVVhSQm1j?=
 =?utf-8?B?aDZXUVVKbmNxZmNnR1BSc2dUT3QwZi96dlBCT0R4N095T3FjYW52TkZwVVlo?=
 =?utf-8?B?bklzM053RE9GM0RsY3VtaVBqbU43cGk4aENzZFZpcnVWeXN4elc5NWtzVjJi?=
 =?utf-8?B?M2lEY0JZM3ZaUmlCMVBNYmhYUXBtckdaTUtXbGNMcjl0c2dBblI5cVJ4YkRU?=
 =?utf-8?B?eHZzMy9JTHhldUxmR3E1K1lQYk1tQ05ZNjlKZGY2Tm5kbXFQSEdzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b5eaf0-c459-4a4a-be7f-08df39b72b86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:31:38.5118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2UdWh8IxG5SXpCW0llV3TQxe48kn6Ug9bQafPu5vxA0y0tmUSvMuyo7anpoInu4zureuyiI6gNNMsH6tOVlpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 7:49 PM, William Palacek wrote:
> __gpu_buddy_alloc_range_bias() walks the block tree from the roots and
> visits every split block overlapping [start, end) until it finds a
> suitable free block, so a range-restricted allocation costs time linear
> in the number of live allocations in the range.
>
> amdgpu pays this on every VRAM allocation when memory is partitioned
> (NPS2/NPS4): each BO, including the page-table BOs created when memory
> is mapped, is restricted to its partition's range, and KFD requests
> cleared VRAM. On MI300X in CPX/NPS4 the compute partitions that share a
> memory partition also share the VRAM manager lock, so the walk is
> serialised across processes. hipMalloc latency grows linearly with the
> number of live allocations, and vLLM piecewise graph capture slows down
> with every captured graph.
>
> The free trees are already sorted by offset. For each order from the
> requested one up, look up the lowest free block at or above start,
> preferred tree first. If it lies wholly inside the range, run the
> existing walk restricted to that block's extent: it only visits the
> block's ancestors and keeps the existing split and error handling. The
> full-range walk remains for space that is only available in blocks
> straddling the range edges.
>
> Behaviour notes:
> - the smallest order is tried first, lowest offset within an order;
> - a free block of the other clear state inside the range is preferred
>    over an edge-straddling block of the requested state, as the existing
>    fallback pass already accepts either state;
> - when no free block lies wholly inside the range (range nearly full),
>    the linear walk still runs.
>
> Filling 1 GiB of a 4 GiB manager with 64 KiB range-biased allocations
> that request cleared memory takes about 1 s and 268M block visits
> before, 2 ms and 410K visits after.
> On MI300X CPX/NPS4, 8000 live 2 MiB hipMalloc allocations: median
> latency of the last 800 over the first 800 is 6.2x before, 1.04x after.
> vLLM piecewise graph capture of a 70B model with tensor parallelism 64:
> 57 s for the second graph rising to 113 s for the 17th before, a flat
> 5-6 s per graph after.
This targets the old dual-tree layout. We will need an upstream-first 
version on the new drm-next design (single free_tree  +  
subtree_block_state ), then backport that to 10.3.
Please send the upstream version to the drm and Intel mailing lists and 
Cc Matthew Auld from Intel as well.
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>   drivers/gpu/buddy.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index a5553fcec28c..3a1fbafe42dc 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -120,6 +120,12 @@ rbtree_last_free_block(struct rb_root *root)
>   	return rbtree_get_free_block(rb_last(root));
>   }
>   
> +/* rb_find_first() with this returns the lowest free block at or above *start. */
> +static int rbtree_offset_below_cmp(const void *start, const struct rb_node *node)
> +{
> +	return gpu_buddy_block_offset(rbtree_get_free_block(node)) < *(const u64 *)start;
> +}
> +
>   static bool rbtree_is_empty(struct rb_root *root)
>   {
>   	return RB_EMPTY_ROOT(root);
> @@ -846,9 +852,39 @@ __gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
>   			     unsigned int order,
>   			     unsigned long flags)
>   {
> +	enum gpu_buddy_free_tree tree = (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
> +		GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
>   	struct gpu_buddy_block *block;
>   	bool fallback = false;
> +	u64 bstart, bend;
> +	unsigned int i;
> +	int pass;
> +
> +	/*
> +	 * Walking [start, end) visits every split block in it, linear in the
> +	 * live allocations. Instead take the lowest free block wholly inside
> +	 * the range from the offset-sorted free trees, preferred tree first;
> +	 * the walk restricted to that block only visits its ancestors.
> +	 */
> +	for (pass = 0; pass < GPU_BUDDY_MAX_FREE_TREES; pass++) {
> +		for (i = order; i <= mm->max_order; i++) {
> +			block = rbtree_get_free_block(rb_find_first(&start,
> +								    &mm->free_trees[tree][i],
> +								    rbtree_offset_below_cmp));
The fast path always picks the lowest-offset block and ignores 
GPU_BUDDY_TOPDOWN_ALLOCATION , while the existing walk returns the 
right-most block.
So range + topdown would silently flip placement to bottom-most. Since 
that flag combo comes from the client requests, could the fast path 
search from the high end when TOPDOWN is set?

Regards,
Arun.
> +			if (!block)
> +				continue;
> +
> +			bstart = gpu_buddy_block_offset(block);
> +			bend = bstart + gpu_buddy_block_size(mm, block);
> +			if (bend <= end)
> +				return __alloc_range_bias(mm, bstart, bend, order,
> +							  flags, true);
> +		}
> +		tree = (tree == GPU_BUDDY_CLEAR_TREE) ?
> +			GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
> +	}
>   
> +	/* Only space in blocks straddling the range edges is left. */
>   	block = __alloc_range_bias(mm, start, end, order,
>   				   flags, fallback);
>   	if (IS_ERR(block))

