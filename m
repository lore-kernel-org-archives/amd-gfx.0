Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D553C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 15:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8A810E513;
	Tue,  1 Sep 2026 15:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdioBnhd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C173010E16A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 15:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lwt3SphoQUylnbA6NNhdtDij/WcwE2Qt7l4Qdkor3ANQ59RutgyAwNKkq6HWhBhz9Kjrvnx33F2caIfCwC+0AMTlteI7cgdo4cfnb7rkB732EwJYso/k6O77Tz8KPlV6VsCNQqY5qQkPkK2JrqboDipHzn8bzgLJawl3URhYTXTiWbt/8j/uyn8i9/2Ekn4i7qV80cMz+zQ70O1GSWuG4t2Hw0tvRy4a4idYJJTvAUpgG57pHHxblRFex0vCIYNQ7dn363kGMBA1Awaq3vt/0Zz5P7MFtBp8T7ye0UPj5Xqh7M8UtmfBZToL4YoL6KHK1WdeuQ+ZU5Jhwf3QGhGUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqGHvzsSzX7xv+P28tdhGod2mMDDTzDDy8XmpjTU7aE=;
 b=HZfivnu0UD8yP0Vxn34koVW4OxSpKAiF8W+2cSFr5UbctLEaqokyi5hP9kHIN/n3o7RaVUzSC4GLJSopg2cz3UaLOxhKuEcYKFW8Ctca93ZDFemOEGcN1RS7YrNcQ+1a0ggW4zAGQXOJ/xC1VdR8jwJ8hMHYKpwMRPH5b0puXUL3oppZh8CEdAQFVd/J9W3kuyiBmPwKBDixrNt5lbwPSLz3vdHyRKzRZ1F5FjmkNnv69R+ht+y2QI5AFJTFwfhrxeRGAPZoqdYmCoWtsksCHAhU1PkDQo59ZHvk1Yn+JQb8pSpZ8qeyaBi6zVwfJ+IGckwV410SgA799Kx4lSn1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqGHvzsSzX7xv+P28tdhGod2mMDDTzDDy8XmpjTU7aE=;
 b=pdioBnhdiSvfZoowsPvo7EdnQfZE5pp3sejQnmI00utJ35+NCsypJR/8qK/KC3SBQKpLUzThgEenJGHpCLPHsrvzcI+XY5h65SKz4FP7zkEweIujNLdd3x4OjPrKgjV0W+rtGP+xv2V1wxeNTVtqCXIeYKJ8wjYmtAdFFv1rbQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH3PR12MB7692.namprd12.prod.outlook.com
 (2603:10b6:610:145::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:56:26 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:56:26 +0000
Content-Type: multipart/alternative;
 boundary="------------UoK80vzYEz3qdHE3f5w0iy0q"
Message-ID: <813dc7e9-d7f3-4d8d-a641-7873e4c9a32d@amd.com>
Date: Tue, 1 Sep 2026 11:56:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: skip migration when the fault window is
 already in VRAM
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, kent.russell@amd.com
References: <20260901124516.357959-1-William.Palacek@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260901124516.357959-1-William.Palacek@amd.com>
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 129fc019-aa51-4b98-b795-08df08419436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|8096899003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gqcnnUMCngo4MsSFl6eYT3VzOicWzN9EImPkpNkmZbbhU4d74dKoOsagQYV1XW2NtfVjDzLHf64GKQLkekBh2HCYN3VXqH+on4KltIP+KjWrzVz6eDgFt1sOFm78H8TXkYu3hd1anZ0V2fi1xrVu9IfQrMIAZi415Yb2lBQeNWU1RMKNU4htCUhwbz5gNRgiuzVGp6BLeUWi/gjNLBJsJ7pyFiASs/O0asp6i84i6zi1ky7nHoJWNysOIQXGUyidBV9zCIrMyQ0VUZaj3UYwEbdgAUjcW39O1Gp76MxEX6Lu0+wvd6Xa1+6VLytn9SaPu/xaYzyFzSBCIk3CeDyRVALLpcVfwEI8UkQKLUI/yOOG1UsiNMqDEALogRh5wIoAcFl6cKO+ZOAK0IU1CUg2pjYFTe1GGZ1ymRg6LEeZvFPMz5qvsI2CXBRqfuFBi/IRgyfhaY9Ne9fLihWNUm7Gon/3QqFM6Rj6qcvnLouWYYjxSNZYJosRbcMtPSH4OybuQNVsASOn1iA0RpDQ8OX8+C/+ippslb6YczIwgopDmNPAEZYkIhMtfVGyBbut/O+m6iOemIpw50j9sqwNIQify6wg2v9zDGHYtOBw4dKs7y9nUdz+u+U5zaicF/JSCG/EK1ZsxjdpWKEdt9a+yXpPNfYls88noiRyAQ+oPLYoLuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(8096899003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdNUFFaeFlZdGpXOW9YNlJiQWNMVmVybWRRbGZYNlhGZ0tIc2x6cy9vRDNw?=
 =?utf-8?B?MWc4cFViN3E0RHQzV2lsWXFMN0Q3ZGJrWnRrN2F5ZWJpZkYyTlE5aldUYnl5?=
 =?utf-8?B?Q01NOEZzYlZ4akpxRDY4TzdNcS9jeHYwTXdNeGtIMkd1SlNOY0NJSCt3TXMy?=
 =?utf-8?B?aDBKTytFeXJkMXZFQUlCMU5pMWIxOFowU2gwRWRiUjVyWVlER3ZTN2wzdzNz?=
 =?utf-8?B?QUFwcDhHWVRrOGtxa1dTYi9pcUJCKzE4YW1tVm52bWw0WXBwTGNKOHR6SjMz?=
 =?utf-8?B?WmZ2TlBJdjdCaDNSS3R2TWVzM05rTjhnVm1NVGNTWGt6T0VXOGF1SlB6SFkw?=
 =?utf-8?B?b0RMV2Y0bkFxelNFSkk4SFhzSC80RHo3VEUxdVVCbDJHd3R5WmZnai9RdW9m?=
 =?utf-8?B?RzE2cmQ3amZTSHdzOTIzS1V1a3c4TnJKeXZjV2c0NVJNS3JINHdsNmQ3dGVs?=
 =?utf-8?B?cGpvL055eE8wOUFza3hhTElRSEV2QXFsUFY3U2t4QjJiczJ3bkYwQ05PRDQx?=
 =?utf-8?B?Q3FTTHF4cEZyL2lCZWw5MG1pdGFEdm15dFU0cWNxN0RxWFJSUUVJREF0VDI5?=
 =?utf-8?B?UUMxOFlaSUJQVXQwaUtZeTRNMlh1Zm5vQ0krWlRGSGw2MXZsNW1XWnpVVlRp?=
 =?utf-8?B?eU5WbkNSQS9UanJ3U1VZUkFndFBxQjRoSkdyWDRpTFBsaGlUbTFiaGRZSTBo?=
 =?utf-8?B?Qkxwb0ZQUUtkSk1XWGp5SGxlRXkrOWhzb01YVTlheUNkb0ZzS3kxeTZ4dlNn?=
 =?utf-8?B?dHFJK2dLSE9JZjVNTFo5cEk5L2VBblRTcTlLdXkrTXBES1p3TTN5ZHZrdWN1?=
 =?utf-8?B?STZyYVpFWDc1alRWVWIwY2kzdHFzSk9tcmtOTHczZ3BNVVlEYVpBOUVnT05k?=
 =?utf-8?B?YnRWVDNwb29aZnhHTGpGZ0RpY2VzU0poanBFcnRXNUprTXhjREZwc3lPdGNW?=
 =?utf-8?B?eDA1b2daUThqTnliZDBKNlJDdktyenVZSUN0Yjd3TmppRlJDdXZTVTdWOFBl?=
 =?utf-8?B?eGsrK1FlSkE3a2phSmYreDJNcFYzaVNzUjVhemppUEhxa0FCNlBEK2svY3l0?=
 =?utf-8?B?OUgwR2Y3L3Z1QW0rK0NKQzljZXZ4MHFnZUhwbldBWFRjYlg1YlZ0aVVwcGFS?=
 =?utf-8?B?TFA3QWxnSVJxUWVzUU0vOE8xVFZlTlJidXYxQVBWVUZrTFZST0VtaFdjTEl1?=
 =?utf-8?B?dFc1ZXVVSFJXWlZ3R00ydXd1QWFKQ29oNlZuRmxDV0tmVWw1M0YvZDJMcmJ1?=
 =?utf-8?B?Y0FNemdXWXE5V1k0VlRjNU1QV0JkcFJteVM1R28zWVpyaTRNYUZVdUdBOXp5?=
 =?utf-8?B?L2Jxc3FnODgyUEhRcWFUaVFHTXVhUmhzTWhnYjVCNUZCSnlOSHllWkl1RCs4?=
 =?utf-8?B?YzVjOXN0TytmQ2IzTDgyRGRaWlZqcktsVXJveUZjbzhDdE5rNVBXZ2cxcmNT?=
 =?utf-8?B?Zlp2UDRGZnIrdElncFBnazBOSk90MlZMRnJVMmVUdjBwTmt4Y1JpR2ZwN1N1?=
 =?utf-8?B?bm53WCt6aVJOU1VacU1rUW40RjVoRS9GTC9FWXZxOXVpWVIzdk5mdFRmMk1G?=
 =?utf-8?B?N2tKZUVXSFVNOTh4QU02YnIzTEFRM3dvTVArLzNmSGRreHpNQzBaL1ZYbVlE?=
 =?utf-8?B?TEZEQVdrZUdNUjlWYWQ1N1lrajZXZTVGRllXcHRUSURpY2w4RWJCVGZoVFZI?=
 =?utf-8?B?SlhoM0lNZjZBNDNSTnVGVGdvd2dpTkdtSEgrSUFuMW5PbXBONmNxbGJ2WTFv?=
 =?utf-8?B?SmpRREFHYitpa2tGdUNFNXI4ZUhNT01FVmZxYkpyYVFWeHJwSGZlaTZPdUkw?=
 =?utf-8?B?bHhXRW4wbGc1bWZ4SWxqY251TldIcXZ2TmUzdGxhZkNBeTFRaGlNZHZPV0xs?=
 =?utf-8?B?TG4yZ3hWa0owTDFWbitQMnBqakNndURSRUNDSGhvYkRjNkhsZ25vZEx6REFn?=
 =?utf-8?B?WjhSWWR4R2xzYjZQQzErNE5JREtvN1NUWEZTc0ZiSFNTNVJLcDlQNm1HM0Vx?=
 =?utf-8?B?cGxyb2NFMlZDY0dNcGVYbzhubEpaQUVKSGQrcVMwMldiTVFkK01ITE5JZUZl?=
 =?utf-8?B?ZXRMWHA0NlpTR2JZeDhjamhvcGdVM045aTdSZGZId050UVdGYjdwcE9veWNx?=
 =?utf-8?B?VnZEeFM0enlBZThIbUN3Z0hoUGZMRnRiZUE2N3RVSDZsWkRVRTRDY29iRkM1?=
 =?utf-8?B?SW9pNUtPMGNpZm53WkVaWHZPQnpWRWhUNTlDNGxDdXFYUUlzLzh0aUlidmJw?=
 =?utf-8?B?NHVJTERhQVpsQ2xmOE1UOXpkZjFkekVxSHA4Ym8vWnpPV0c1RlRuMDJoa2Rj?=
 =?utf-8?B?citrME5mN29jSERVWGg3M0V0U0FlNFdTRldrSXliY1RGVTNkUDB3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129fc019-aa51-4b98-b795-08df08419436
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:56:26.4327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZrppMvFrMjckEOSGH37EcfjJra/DbGqfGDEl5RHDQaPAdH83tSXLhEf4KIC/CqzgP7+pfouqeSBpG+NMh8Tbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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

--------------UoK80vzYEz3qdHE3f5w0iy0q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-09-01 08:45, William Palacek wrote:
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
> With this applied the fault driven phase of that workload falls from 270
> to 348 s down to 45 to 48 s, and page_in at the end of that phase is 46.2
> to 48.0M pages against 44.1 to 45.7M unpatched, so the same or more data
> is moved. Unmaps per productive migration fall from about 35 to about 2.
> Retry fault counts do not fall in any arm, so this is not a refault loop;
> what changes is how often a fault escalates into a migration.
>
> The scan is bounded by the migration window, one granule on the fault
> path and the whole range on the prefetch path. That is the same order as
> the migrate_vma_setup() walk it avoids, and it returns at the first page
> that is not resident, so the worst case is one extra pass over a range
> that then migrates normally.
>
> Signed-off-by: William Palacek<William.Palacek@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 65 ++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index c3411dacdf55..40fc21d18587 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -384,6 +384,52 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	return r;
>   }
>   
> +/* Is every page of [start, end) already resident in the VRAM of @node?
> + *
> + * prange->actual_loc is a per-range scalar and is not sufficient on its own.
> + * Since commit a546a2768440 ("drm/amdkfd: Use partial migrations/mapping for
> + * GPU/CPU page faults in SVM") migration is per window, so a range can report
> + * actual_loc == best_loc while parts of it have been evicted back to system
> + * memory. On a gfx942 oversubscription workload 3.3% of migration attempts
> + * were on windows in exactly that state and did have pages to move, so the
> + * per-page test below is needed rather than the scalar alone.
> + *
> + * SVM_RANGE_VRAM_DOMAIN records "some device VRAM", not which device, which
> + * is why the actual_loc comparison is kept as well.
> + *
> + * Called with prange->migrate_mutex held.

I'm OK with a long explanation in the commit description. But for the 
code comment I'd prefer to keep it more concise:

Check if a range of addresses is already resident in VRAM to avoid 
unnecessary migrations that would trigger MMU notifiers causing the 
range to be unmapped and faulted again unnecessarily.


> + */
> +static bool
> +svm_range_window_resident(struct kfd_node *node, struct svm_range *prange,
> +			  u64 start, u64 end)
> +{
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	unsigned long i, offset, wpages;
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
> +	offset = (start >> PAGE_SHIFT) - prange->start;
> +	wpages = (end - start) >> PAGE_SHIFT;
> +	if (offset + wpages > prange->npages)
> +		return false;

I believe this case shouldn't happen in practice. If it did, then 
returning false here would be conservatively correct but may result in 
unnecessary migration attempts.

If you wanted to be really sure, you'd also need to protect against a 
negative offset (or integer underflow). I think a more robust approach 
would be to adjust the bounds properly to fit within prange:

	start = max(start >> PAGE_SHIFT, prange->start);
	end = min(end >> PAGE_SHIFT, prange->end);
	offset = start - prange->start;
	npages = end - start;


> +
> +	for (i = offset; i < offset + wpages; i++)
> +		if (!(addr[i] & SVM_RANGE_VRAM_DOMAIN))
> +			return false;
> +
> +	return true;
> +}
> +
>   static long
>   svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			struct vm_area_struct *vma, u64 start,
> @@ -401,6 +447,25 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	void *buf;
>   	int r = -ENOMEM;
>   
> +	/* Every page of this window is already in this node's VRAM, so
> +	 * migrate_vma_setup() below can collect nothing. It issues the
> +	 * MMU-notifier invalidate before discovering that, and with retry
> +	 * faults enabled that lands in svm_range_cpu_invalidate_pagetables(),
> +	 * which special cases only MMU_NOTIFY_UNMAP, so MMU_NOTIFY_MIGRATE is
> +	 * handled by its default arm, reaching svm_range_evict() and
> +	 * svm_range_unmap_from_gpus(). The attempt therefore tears this
> +	 * window's GPU mapping down and then finds nothing to move, so the
> +	 * next fault on it is escalated back into migration instead of being
> +	 * satisfied by mapping alone.
> +	 *
> +	 * On a gfx942 oversubscription workload such attempts were 96 to 97%
> +	 * of all to-VRAM migrations, and the driver unmapped a window roughly
> +	 * 35 times per migration that moved data, against about 2 with this
> +	 * guard.
> +	 */

Again, I'd prefer a shorter comment here:

Avoid unnecessary migrations and MMU notifiers if all the data is 
already resident in VRAM.

Regards,
   Felix


> +	if (svm_range_window_resident(node, prange, start, end))
> +		return 0;
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
--------------UoK80vzYEz3qdHE3f5w0iy0q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-01 08:45, William Palacek
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260901124516.357959-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">svm_migrate_vma_to_vram() is called for windows that are already fully
resident in the target GPU's VRAM. migrate_vma_setup() raises an MMU
notifier invalidate before it can discover there is nothing to collect,
and with retry faults enabled svm_range_cpu_invalidate_pagetables()
special cases only MMU_NOTIFY_UNMAP, so MMU_NOTIFY_MIGRATE is handled by
its default arm, reaching svm_range_evict() and then
svm_range_unmap_from_gpus().

The attempt therefore drops the window's GPU mapping and then returns
having migrated nothing, so the next fault on that window is escalated
into another migration instead of being satisfied by mapping alone.

Measured on MI300X (gfx942, SPX/NPS1, xnack+) under an HMM
oversubscription workload, 96 to 97% of to-VRAM migration attempts
collected zero pages, and the driver unmapped a window roughly 35 times
for every migration that moved data.

Test whether every page of the faulting window is already resident in
this node's VRAM and return early if it is. prange-&gt;actual_loc alone is
not sufficient: since commit a546a2768440 (&quot;drm/amdkfd: Use partial
migrations/mapping for GPU/CPU page faults in SVM&quot;) migration is per
window, so a range can report actual_loc == best_loc while part of it has
been evicted back to system memory. 3.3% of attempts were in exactly that
state and did have pages to move, so the per-page test is required rather
than the scalar alone. Instrumented over 100000 attempts on an earlier
run against a different driver build, the per-page test never skipped one
that had pages to move.

With this applied the fault driven phase of that workload falls from 270
to 348 s down to 45 to 48 s, and page_in at the end of that phase is 46.2
to 48.0M pages against 44.1 to 45.7M unpatched, so the same or more data
is moved. Unmaps per productive migration fall from about 35 to about 2.
Retry fault counts do not fall in any arm, so this is not a refault loop;
what changes is how often a fault escalates into a migration.

The scan is bounded by the migration window, one granule on the fault
path and the whole range on the prefetch path. That is the same order as
the migrate_vma_setup() walk it avoids, and it returns at the first page
that is not resident, so the worst case is one extra pass over a range
that then migrates normally.

Signed-off-by: William Palacek <a class="moz-txt-link-rfc2396E" href="mailto:William.Palacek@amd.com">&lt;William.Palacek@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index c3411dacdf55..40fc21d18587 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -384,6 +384,52 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	return r;
 }
 
+/* Is every page of [start, end) already resident in the VRAM of @node?
+ *
+ * prange-&gt;actual_loc is a per-range scalar and is not sufficient on its own.
+ * Since commit a546a2768440 (&quot;drm/amdkfd: Use partial migrations/mapping for
+ * GPU/CPU page faults in SVM&quot;) migration is per window, so a range can report
+ * actual_loc == best_loc while parts of it have been evicted back to system
+ * memory. On a gfx942 oversubscription workload 3.3% of migration attempts
+ * were on windows in exactly that state and did have pages to move, so the
+ * per-page test below is needed rather than the scalar alone.
+ *
+ * SVM_RANGE_VRAM_DOMAIN records &quot;some device VRAM&quot;, not which device, which
+ * is why the actual_loc comparison is kept as well.
+ *
+ * Called with prange-&gt;migrate_mutex held.</pre>
    </blockquote>
    <p>I'm OK with a long explanation in the commit description. But for
      the code comment I'd prefer to keep it more concise:</p>
    <p>Check if a range of addresses is already resident in VRAM to
      avoid unnecessary migrations that would trigger MMU notifiers
      causing the range to be unmapped and faulted again unnecessarily.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260901124516.357959-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">
+ */
+static bool
+svm_range_window_resident(struct kfd_node *node, struct svm_range *prange,
+			  u64 start, u64 end)
+{
+	struct kfd_process *p = container_of(prange-&gt;svms, struct kfd_process, svms);
+	unsigned long i, offset, wpages;
+	dma_addr_t *addr;
+	uint32_t gpuid;
+	int32_t gpuidx;
+
+	if (kfd_process_gpuid_from_node(p, node, &amp;gpuid, &amp;gpuidx))
+		return false;
+	if (prange-&gt;actual_loc != gpuid)
+		return false;
+
+	addr = prange-&gt;dma_addr[gpuidx];
+	if (!addr)
+		return false;
+
+	offset = (start &gt;&gt; PAGE_SHIFT) - prange-&gt;start;
+	wpages = (end - start) &gt;&gt; PAGE_SHIFT;
+	if (offset + wpages &gt; prange-&gt;npages)
+		return false;</pre>
    </blockquote>
    <p>I believe this case shouldn't happen in practice. If it did, then
      returning false here would be conservatively correct but may
      result in unnecessary migration attempts.</p>
    <p>If you wanted to be really sure, you'd also need to protect
      against a negative offset (or integer underflow). I think a more
      robust approach would be to adjust the bounds properly to fit
      within prange:</p>
    <pre>	start = max(start &gt;&gt; PAGE_SHIFT, prange-&gt;start);
	end = min(end &gt;&gt; PAGE_SHIFT, prange-&gt;end);
	offset = start - prange-&gt;start;
	npages = end - start;</pre>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260901124516.357959-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+	for (i = offset; i &lt; offset + wpages; i++)
+		if (!(addr[i] &amp; SVM_RANGE_VRAM_DOMAIN))
+			return false;
+
+	return true;
+}
+
 static long
 svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 			struct vm_area_struct *vma, u64 start,
@@ -401,6 +447,25 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	/* Every page of this window is already in this node's VRAM, so
+	 * migrate_vma_setup() below can collect nothing. It issues the
+	 * MMU-notifier invalidate before discovering that, and with retry
+	 * faults enabled that lands in svm_range_cpu_invalidate_pagetables(),
+	 * which special cases only MMU_NOTIFY_UNMAP, so MMU_NOTIFY_MIGRATE is
+	 * handled by its default arm, reaching svm_range_evict() and
+	 * svm_range_unmap_from_gpus(). The attempt therefore tears this
+	 * window's GPU mapping down and then finds nothing to move, so the
+	 * next fault on it is escalated back into migration instead of being
+	 * satisfied by mapping alone.
+	 *
+	 * On a gfx942 oversubscription workload such attempts were 96 to 97%
+	 * of all to-VRAM migrations, and the driver unmapped a window roughly
+	 * 35 times per migration that moved data, against about 2 with this
+	 * guard.
+	 */</pre>
    </blockquote>
    <p>Again, I'd prefer a shorter comment here:</p>
    <p>Avoid unnecessary migrations and MMU notifiers if all the data is
      already resident in VRAM.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260901124516.357959-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	if (svm_range_window_resident(node, prange, start, end))
+		return 0;
+
 	memset(&amp;migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
</pre>
    </blockquote>
  </body>
</html>

--------------UoK80vzYEz3qdHE3f5w0iy0q--
