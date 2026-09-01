Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2112C624D3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 17:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384A810E36A;
	Tue,  1 Sep 2026 17:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MTc5XLM/";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6479C10E36A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 17:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/j5y9G2PpkYnI81de8nQBySRP8g/RPVR9APSBeoyW85l2+b4MGBY4WPN5K7tJ6D8h94vHo7da1cfsBzj/ZKzJJDhfi8/tI+sPECFsVvlb1qOyFelhcZgGRyJWGSetcIYKAFt5TtWEjkqxD55+4T5OQSN2oPXAylc3bYFxqUnqZGcIvOmTx+d/7UxAnph/VbkNAipChC6eMnF9ctXzTw4iFaxAuHOBd5hELhXVlrmYhf402y3W2LrfdlLUAs36F46LKow3PthxANe3YiKtcLZiH6Q4zZEubO7pr2uEAnZv+HlFsGY5hS0Z7tlwxy5jKfO5tsdYY0EzhSsRMU7pBybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1RjbFckiHumLvO1v+Pwp5EZtTGQhEbVUW9za23W+/Y=;
 b=skiXn/4Wos8vUBoaMgmIqe6+kFSNg3gXeqSdHzTmjVpvftW1TzPKFfz4cmK675T3YAZnZcxgBFAsG2T4GkDMoOgNvHzhS3TE880jv3ikG3DRiekLgOZ0WL6HFIID4opp47QF+8LICdwfcfYrQ8rgczbHlcf+7K6e+IemGtREJZ3cafzwIt/rjMVJha/ylGm+pPNS0525Xu72U2D5O8y646FnYqxNdXG169/d/rh3/a4voi2uSrnXXDzDYoNsKDZZ7lyDTBDJFiFwM/n4H/BCZUvpUfh35xkQTDYpe5WV7Y4gZ9V5VVE7Mt3CdS3qFAV4jBDj5K5ia+PDMrdMazPEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1RjbFckiHumLvO1v+Pwp5EZtTGQhEbVUW9za23W+/Y=;
 b=MTc5XLM/kUWnOZsctAM3iHhniCITtOvJ0C4xb6Kt1NEtAUDvhYf3Du/any8Sw9eAwTe3rrYVJ2RwuTJiy+q7hESmD7dS8z4Mc2Mp79d3qR8Lwi/rcAnSFjl3BjYnjEuVNdeXK1bZSIDk4zM5oVU60Yz+jBWxLX9ibvgHLDLGjs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ1PR12MB6171.namprd12.prod.outlook.com
 (2603:10b6:a03:45a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 17:55:54 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 17:55:54 +0000
Message-ID: <60796f91-cd7f-43da-a33f-4d5f2c9884d9@amd.com>
Date: Tue, 1 Sep 2026 13:55:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: skip migration when the fault window is
 already in VRAM
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, kent.russell@amd.com
References: <20260901165400.16262-1-William.Palacek@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260901165400.16262-1-William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::17) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f58bca-1ad8-42a6-5c49-08df085244cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +0MHE1Tn9HiplBAlZPr0KEc3H+ar/K/nAze3OdJSOEZH/F13/eHNzztzmmtgFzn7sbziSGvC8pDCcNTq+RBMBQkQ2fepQ4WxDwK9aSoFUh1NtHRK1OYgGFRqwM+r8gFiT5A1h//Ydbm3aZ3ZfHwndgp7R4EGO701hMA0GnLNscAx4Isy0UWpn0I1SVZ/Fbm4BWAQu5JY9cajfCyq/Gp2Pd/STqBzak/zFz4otYY2hnNnTUFkGeZv4i9RwobzndrA0YlnQJ7BNkgFkAeMX4KCNoolwlEuQrt8puVtVM9Z03L/CO6+sNg0jEh5ooSXuNOVo26IkqCSYC+CV/gDNQax7G4LjZBYU9SY4ZiRhNmfno6+dJHLVdDPMbOhscAbgoigNQKypIhhyHqwfZVO17CGDO4WvMj1xzilaHzBGEuVVL7cdWui+AqRxYDubOdqQkVwWA/xsna+qmIe/cQayxbGid6GYgzinBiuRJ94xzfKAiLT7D0hs5MO46U6xLcJmqvdl+Djx7Pn/IqbDmvoSEmz87IZxaQHfLLvZ0cxL54r513sstDkYhmUM+qTCxIRIlya6FxbbaUr25W+vf8f0tWGzyuR3pJfegdtFgmoze4bGVraR22PYMcT4qsav3DVhVU0LAPzEvh/xFc6cNCSev2KMR6RfBeYclc6lzJOX3yiO2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZIendmVVJRK0ZuTHRnWTFQOUNYUHFLdDFQeXM4SGR3NzBnRHYwY0FhNDNH?=
 =?utf-8?B?d20rRnpKTGdmei9DdWV0S0l1UGJ2MVJHR0s5QmoySDhHWm8vaDVaZDBOa0Fo?=
 =?utf-8?B?cytDZmFMcnJLUERvOWdrRmFWc3FabnhQaC8yOGRadlZzeXEySjZ5OFZ3VHFM?=
 =?utf-8?B?L25LcUJ3bDlyT3UwendTL1BKM0k1Z3p6VEhtdGFUREJ5QUExN041a054bWZW?=
 =?utf-8?B?L01VOVJMZ3gwV3lURmJuN0JnbFowb1hwY0xLcWN0OWtsWjFHd3VhcXNUSk55?=
 =?utf-8?B?TUowRTVDc0V5VUdKWnk0bEs2c011N3NDeTRiWE40cGJKTWpRM1BCYk1IV2Fi?=
 =?utf-8?B?aFYvVGcxK0ZvVVIzL0JnZUkxVnFKUmZZZXY3T0tGdG4yMXdaTnY2aHdFNFM4?=
 =?utf-8?B?Sm5ONUZNUU05M2FJQm1EUG51YUhZOUpUZk1aQkhzeTJvY1o2L2NaR1Nya3NS?=
 =?utf-8?B?enZ2K2Y5ZTNJMEt5ZEhLWUNZcG9qTjFGa0hSU0JsMDdJZnRSbmpCTnFBaC90?=
 =?utf-8?B?UFNmNVdObE1WQWx6Nld4V0Z2YythejhrOGRzVnpUeGFMTHpNdHB1NzRQaG1L?=
 =?utf-8?B?ajNnN0MzR2t0a1RucC85OXpOK0ZFRDlPV1hwYTg1VE5nZWkzVzh4Ri82ZDM2?=
 =?utf-8?B?RDJ0TDdpVGV4bGxjWFJQWmJqbVpEYStIQVMxQzRyY2NOektVMmF6bXRoVE84?=
 =?utf-8?B?TEI4U0ZWWm9xcWdxbFEvQ05YT0Rkd3hHMWg5Z0c4VWhlTW5lZDBpdGxnMUVR?=
 =?utf-8?B?UllQZEEzRGhlS1BPVHlZUGQ4MkQzWXZGU3Fmczl2enFMQ1FEMU13cEl6WUhk?=
 =?utf-8?B?dmdabFZQakgvRk5xbzlvNEVaSngzWjI4akM4WmNMSEhXekdhUlFwSVJCUFNZ?=
 =?utf-8?B?NWJXaDdDbmx6MXJRYUpZNmtEUG81MHhQcFcxQjdWRTAxZnNYbFdZVCtwQ3lB?=
 =?utf-8?B?NUg2VUZobHl2VXMyYmFDeVVvbmpXU2dVSGsvQzhicDFNRWZsMkVaT2Y3THhI?=
 =?utf-8?B?NUVQck1yK00rS0Z5K1BORG5ybjVKNXFkTHovSmtVOFNCNnUyeUsraHRrZjE0?=
 =?utf-8?B?cWQ3OFNYUDVJWUlpdVpiMVhhNEtNeFRsSHJ0WkV2cEluWkZIWWhrczJpUnNC?=
 =?utf-8?B?dm5xWXpFR3JHSFlrZld1Q2kzNWRyK2Jmc3R4dHl3cGoyQ1B1WGdXeGVFN1ZV?=
 =?utf-8?B?cm4zYVk5ZUkrcVBzVFltUGpvdENpaStwT2VOUFZ1bWVBRWRra0xOcmYwdldI?=
 =?utf-8?B?Qlk5UlpoOGxKMlBGZnZnRGd1b3JMSmpmdEtXZnozcXpXMm9VWjhiUjRhUGp5?=
 =?utf-8?B?anBkWkI3YWQ1SzV5QXlIU0Y1ajUvdDhhZ09DSDR2T2N1UUJxNFJPSysrSEtn?=
 =?utf-8?B?R0dZcVJxN05KNUNCZ080cU1QZTlUcGQ1WXhsbzVaRUtRMXlkcG9aM1VoclQ0?=
 =?utf-8?B?R2ErZGlFaXpLT0EwV1g1Z2lROFZJU21LQjh5ZXVkdGVTc3ZFcEwwTVBBb292?=
 =?utf-8?B?bnUxS2YwR2g1Z3pTUDJqaWg0cjZreTB3MkVXSWZ3ZGh2b05odUI4MkhPQStz?=
 =?utf-8?B?ZXJHNHB5YWRSMzhjcU4wcG5hOEhVRlhEQ0hrVTR5WTJTVUk1Ti9UZVFyMnZE?=
 =?utf-8?B?b1RFeDJCenZYb2ZMdkp2TldvM2xPeXJ4NmswaUlUZDdQN2EySURFbElSS1pH?=
 =?utf-8?B?VkFkNjRldmVEWXp5M2dCSHZ5dE1pUHo4bHZ3WHl0YmlQTVNRR09zUk8vVTFs?=
 =?utf-8?B?U2k5cHlqQWFNaGZQeTNxbk5HVDNCeHdDRjFLNmFaeHVsbjBqR0pHNHBPUlZP?=
 =?utf-8?B?cis4THc0aVNMQnlYNkxBeWNkYkk0dUtXWDRrYXVRWE82M1NGOEljeXFvVGxt?=
 =?utf-8?B?ZzEzWVZtcmdLeEFVS1ZGK1I1ckpzeFdpRGt4RUtvbjcvRllaY3ExSzg2UDN3?=
 =?utf-8?B?K1Jtazc3SEV4SEdBRE1xZG4rcWxCWGZlcXBMNVAxTkl2cHZXc2lYNmF2U3pI?=
 =?utf-8?B?VU9QRVZtQXBDSElpLzVnTXBoOWYzbldWQ0gydVN1Tnc3eklTSjNRUXE0WWNj?=
 =?utf-8?B?eEZmYU80L3NjUXJHeVVDQ1I1KzZ6NFZ2cy9oaUF2WG5PUjBJc0tHdFlaYkpQ?=
 =?utf-8?B?c0pVY2cyYzlxb2EzTGRVMkZ4QnFSejIrcC8xcmhLcDFEMnQwRjA3SGJpOGVk?=
 =?utf-8?B?VnVxREx0N1BtS2lOVkNyUjVoVDg4RkdHYkJ2WDNraDhKd1pQZll3ekdMemJ4?=
 =?utf-8?B?cjZaWlJVY2RkSDhQaUlLd3laVTlEM25NckVkOXQzVFp4OEZGMTByTkxUMzVx?=
 =?utf-8?B?WDhQQ2tScE9JY2xyMHBjUmY5d0R0M1RCWVhZd3QwUzYraUJqVzFUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f58bca-1ad8-42a6-5c49-08df085244cc
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 17:55:54.7170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+uk700cjhj82Pg6jTnav7eq5xkA8RIL9S2SlM7f1m06f9Svcl1xO+3waf9a9srzJVdAcsnQWPWrRNfLFcAPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
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


On 2026-09-01 12:54, William Palacek wrote:
> svm_migrate_vma_to_vram() is called for windows that are already fully
> resident in the target GPU's VRAM. migrate_vma_setup() raises an MMU
> notifier invalidate before it can discover there is nothing to collect,
> and with retry faults enabled svm_range_cpu_invalidate_pagetables()
> special cases only MMU_NOTIFY_UNMAP, so MMU_NOTIFY_MIGRATE is handled by
> its default arm, reaching svm_range_evict() and then
> svm_range_unmap_from_gpus().
>
> The attempt therefore drops the window's GPU mapping and then returns
> having migrated nothing, so the next fault on that window is escalated
> into another migration instead of being satisfied by mapping alone.
>
> Measured on MI300X (gfx942, SPX/NPS1, xnack+) under an HMM
> oversubscription workload, 96 to 97% of to-VRAM migration attempts
> collected zero pages, and the driver unmapped a window roughly 35 times
> for every migration that moved data.
>
> Test whether every page of the faulting window is already resident in
> this node's VRAM and return early if it is. prange->actual_loc alone is
> not sufficient: since commit a546a2768440 ("drm/amdkfd: Use partial
> migrations/mapping for GPU/CPU page faults in SVM") migration is per
> window, so a range can report actual_loc == best_loc while part of it has
> been evicted back to system memory. 3.3% of attempts were in exactly that
> state and did have pages to move, so the per-page test is required rather
> than the scalar alone. Instrumented over 100000 attempts on an earlier
> run against a different driver build, the per-page test never skipped one
> that had pages to move.
>
> The actual_loc comparison is kept alongside the per-page test because
> SVM_RANGE_VRAM_DOMAIN records only that a page is in some device's VRAM,
> not which device's.
>
> With this applied the fault driven phase of that workload falls from 270
> to 348 s down to 45 to 48 s, across 9 patched and 7 unpatched runs with
> no overlap at either oversubscription factor tested. page_in at the end
> of that phase does not fall with it: 44.5 to 48.3M pages patched against
> 44.1 to 49.7M unpatched at factor 1.10, and 46.2 to 48.0M against 44.1 to
> 45.7M at factor 1.02. Those ranges overlap at 1.10, so the claim is that
> no data is stranded, not that more moves. Unmaps per productive migration
> fall from about 35 to about 2. Retry fault counts do not fall in any arm,
> so this is not a refault loop; what changes is how often a fault
> escalates into a migration.
>
> The scan is bounded by the migration window, one granule on the fault
> path and the whole range on the prefetch path. That is the same order as
> the migrate_vma_setup() walk it avoids, and it returns at the first page
> that is not resident, so the worst case is one extra pass over a range
> that then migrates normally.
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 46 ++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index c3411dacdf55..e91d0115cbba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -384,6 +384,46 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	return r;
>   }
>   
> +/* Check if a range of addresses is already resident in VRAM to avoid
> + * unnecessary migrations that would trigger MMU notifiers causing the range
> + * to be unmapped and faulted again unnecessarily.
> + *
> + * Called with prange->migrate_mutex held.
> + */
> +static bool
> +svm_range_window_resident(struct kfd_node *node, struct svm_range *prange,
> +			  u64 start, u64 end)
> +{
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	unsigned long i, offset, npages;
> +	dma_addr_t *addr;
> +	uint32_t gpuid;
> +	int32_t gpuidx;
> +
> +	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx))
> +		return false;
> +	if (prange->actual_loc != gpuid)
> +		return false;
> +
> +	addr = prange->dma_addr[gpuidx];
> +	if (!addr)
> +		return false;
> +
> +	start = max(start >> PAGE_SHIFT, prange->start);
> +	end = min(end >> PAGE_SHIFT, prange->last + 1);
> +	if (end <= start)
> +		return false;

This should probably return true. If the window does not overlap with 
prange, then there is also nothing to migrate. With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +
> +	offset = start - prange->start;
> +	npages = end - start;
> +
> +	for (i = offset; i < offset + npages; i++)
> +		if (!(addr[i] & SVM_RANGE_VRAM_DOMAIN))
> +			return false;
> +
> +	return true;
> +}
> +
>   static long
>   svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			struct vm_area_struct *vma, u64 start,
> @@ -401,6 +441,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	void *buf;
>   	int r = -ENOMEM;
>   
> +	/* Avoid unnecessary migrations and MMU notifiers if all the data is
> +	 * already resident in VRAM.
> +	 */
> +	if (svm_range_window_resident(node, prange, start, end))
> +		return 0;
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
