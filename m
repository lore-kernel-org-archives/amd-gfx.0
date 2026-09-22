Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9753C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 17:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC7D10EE15;
	Tue, 22 Sep 2026 17:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijp2kUDi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8412510EE17
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 17:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V90aoaj3yFyWZI6qWTG+A8Y5YFFQItXHWerW9BNsoDgCzdaM8hbPYZ0/wpYqfdUvmu67ahWqpWPv85Ki7kIB5CzhRALrs8pSr2PRpCvBqZzptU71ntfKfxshZn32YyYb2LOgwOkenMhGndtDf1c87fA4v+wiMpYYGQty5eFg2G3jjBFeU2SjGQKIsGrO09GaO6K+gaYHeHJ0xlvx2Pn2gcCfWwwKQTrUOEFk22l8LMy8Q63viVWqv+M9M6zuISUE6yyiisPZ7kFD8BHNulp3a5upJ7fkxYy1/0Hgq5b1w9jsU2UnzH2a/E/HQtuOuL5ulVaxnJnJ18nWivpgjGy7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCdSNkarTUqswwLS1jkosLNZ+bERC42EUnSHCngE9hs=;
 b=msJw+Qh5wx6gihiMYhXIs2DeQ5MfdQ+5OcgXAGKi7c8+FrRCBytZr5kCtv+jCq9QX9d0YlQbiCqGoUE8IpUbkQdj+QEuKotVxhqjnRYyn8XHpGORjGa3ezPS+o735G2vOi1ga7PZJakwAGY2owQBVCg69IxfP5ePAqUhSW4hiTug4EfdN7dZbJZbXGzezasF7kIS+3JTYwF4xWop9npI9+wAssMoNuzHDpSLH1nI7hZEI2wfszv99h1GsjOBRIB6AgVKYA/r3BBFWSF8Z0WZVekSoJi0fttwp3NNZ33HsykClFORuz+woyX0+fVzJSE1fBVDhSDkwW427KXzSMXpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCdSNkarTUqswwLS1jkosLNZ+bERC42EUnSHCngE9hs=;
 b=ijp2kUDiTCrYxO/vTgxbFQtQyhYuys/w8ue1heTdlDpzfGo0h1HemXNFyxbBwebT9PszuBd4hXJHRhqfbjdzWXda2DKXgWnnb98eCp7ZzJmDdMN3vU0/8bCzRZxPnscmZwhgt2LPjSPFX0XeDQFKDVCpwS2s8fjaB7W5GI3R2E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 17:31:04 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 17:31:04 +0000
Content-Type: multipart/alternative;
 boundary="------------Q5xy6rimZCdPOhFCCNZXlgMZ"
Message-ID: <7fe6058d-a772-44b8-bd0d-e63fc7ea9632@amd.com>
Date: Tue, 22 Sep 2026 13:31:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: don't widen the validate GPU set past one
 page owner
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20260915145833.601947-1-andrew.martin@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260915145833.601947-1-andrew.martin@amd.com>
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb5718c-847b-4dd1-27a5-08df18cf46e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|5023799004|56012099006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ij8g8C2jtiw+6bfcDU65i+V/hhp2qgwlN4jEVOi1PM7oy6puKveUI0EVhoi/oU/tlT7a0aVpyT5sKnHyV0GjhWmggeRNAitdBMwVmdcb+aMVJFvSqM9GZdE8LwVGY/mqfY8ydKhojiVA3/6qoE/lEQ+1gvPe6CVB9dbmaNGlYS7nrDnge5n4ccf5CORiOJkEZUU96pbNaXlKWh5+CYqWNM0lx4OA0RThI6N6FP16U4zSL5oYE6SKZEkQgf6pukhNrCG2dzvMw3q8qTkEtwftMnjzZDa8cLJrcY5TRgHcy1Ny1aAOPqOepcClhu5OttqBlgKtfbZCV+vDdvRiplG7GscEKELOj0uUQG0SWLYyrQ/a8w63/84o0E6syvT1d/LCPS7cprxRfBCIUKKjxKGy9V38+fbEoeH/9UQQgn08+Yv8As9YsNIk5djsX2jOpYSFZS9K9sTy5UqzM0BqEewEou5wuUPClRwFKrj6NE05kCrK1DNzOXqN6W2/lfIUjWXNuQ3wUn/rlLbBHHgUkSoTryG5ZfxbV+DYSqbSLoIBS/iaW0/4T6yMPfbtsifkGgX9BOyLK0bRL4F/AubU7XT102u2rZAIZ00yH1S8b4XYxdNtzJgTrYItydlBkRMK+q65/kk4pUiAyW0RHFWT25vVLqUmMKhLa4HXVsv+wDcl+Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2REbUNFUDUrU1Z6QmdCQ0lMM1dGQ3dXRkpYeDhRZm55SmxCOWlFa3N5bmxG?=
 =?utf-8?B?RFlkNFAvcVJhZUl1ZFA5M05URTZaRVNqM2FqL0t6Tjg4aVVseVRRS3dqeWlO?=
 =?utf-8?B?SVBESTdjYlZaUElYZ3Q0dFE4cFpkYWVhUTdJd2dsbklwTm5DUTRFTVBTYy9J?=
 =?utf-8?B?dVRuWHRCY1VoQmFEYmVuai9mVy9nK1daQzlXYTZuc0M3dWQvelpqRTI2MExh?=
 =?utf-8?B?d2JlZFNTc2RleS90OUFHSkhoTk5ZWGRhKzJiekNCU2RsSkw0eUJEL0YvdWJP?=
 =?utf-8?B?cWZmc0lhSEhVb0tka2hxdW9pNzJOOUc0YWNOODR2Y3QrNXdudXY4S2libmVr?=
 =?utf-8?B?MTFxQ1Bnd2lSQjRvZ0xOTE1CZzBIWTlpTlg1bHdJanl0THV0dGpnb1ZYK0Vp?=
 =?utf-8?B?M1BIOFFUK3o3YXZDeXlWVWVCOHQ1T2NqRkI0TE4xUHJwZkxwNkEzODhkYmpU?=
 =?utf-8?B?aGJZMlhVcXpRYk1zTkZOREUrSWNXSGFyVmovRmN1djl4a0pjczdDRnlqdjRB?=
 =?utf-8?B?TVZxQytEZnNPQ1hJM2xlblRvL0lTZlkyS01oVmU5WmNvTm1tRExSalpER2Ft?=
 =?utf-8?B?OXQ5N2lsUTcySHlPRWVWTjVXVFFRQ1Bsa3BJNU9TMTVXQ1BzSUJTUi9Famow?=
 =?utf-8?B?VnE2ZzFRMGR0ZkhQa1BNeHJScFNwaUhDRklrQzIzOVl4ZnBYcDRjSGJjNVU1?=
 =?utf-8?B?YUhSSnR5QjNoWTEyYjZXYWFEdmVCaWR3a3RTS2VxZTFGMDF5emIvSzIrTFpV?=
 =?utf-8?B?ZWlkdXkyUGpXNXNvdVk2aEttQWxXY01WbzdBaXhWNUxSMTJvanZQTWFFUXpu?=
 =?utf-8?B?UG1xMzVSZTFwbVZpTzVzNVhuWHFDaHZvZ0YvMFdZT2xrNHVXcUdrMkIwSkMr?=
 =?utf-8?B?TFNEZEdyMzNGaThMQkFtQUJsU2VzUTlIYlZwTE13eXdXN21GTkRCN0RlbTk2?=
 =?utf-8?B?b3JzNllsRHUrZ3QxdjhYaVNWMHA3dFMzeE1OYzljekdKbFpiNnpLcmF3UHNC?=
 =?utf-8?B?djdQc0cxS283N3dnLzhtYmNQVDE2bDhaM0g5RnlDYzV3ZjZZMm1zci9iRlgy?=
 =?utf-8?B?b3QyYk5weVJ6SkludEVaQXhjTDB3NDFaVGlLUnhFT1g1aDcxVTVVd214Mjlp?=
 =?utf-8?B?bzNrUFYvZmVUamFwSXhjOWlkWmNMTGViUlRycklGYzFhb3BudzZQQ1pROEZP?=
 =?utf-8?B?OUhHWEEvT2hhL05UUjRTN25xb1pYRmM4dzVLa1Z0UGhjZlY4cG1LNjM2L0M3?=
 =?utf-8?B?WGo1RHRiWkd6elpCUGhKSDZFdWVoOENJUkFxQ3N6SlBkTzVLdWRGSEFMaDN5?=
 =?utf-8?B?azgzQVlxR2pUeDZQYkMrSmtsblF0YmwwbllOM281SWVSeHJjQUtSOC9WcEpX?=
 =?utf-8?B?K0R1Q1pvVkVndkUzaVpLRDZ0TWxJYTdZY3RWOXJkUDU2eHdiNXQvQmFCc3E5?=
 =?utf-8?B?VWJ6cDdySEFzVEJFSGpqcWpPQUJmNEtUa09YT2NYLzR0TkR3Z2xpWTRrQlUz?=
 =?utf-8?B?bXI3OTNucHVEczlwZzJRVVhneTBBTGNoU0hCeEhISTZLM3NjMGtXN2tyUkdI?=
 =?utf-8?B?bU4rNWpZcUxoaXgzMjZ4Qks4VzZiaUdUNmVMZjZyT0dxdlFlS2xNdUlUWFI5?=
 =?utf-8?B?QkpUd0lvbm9DK2Z3SmJURHdMWVpXemd5cFFFV3NRaTcwYWJxdFBzZUhQVGUr?=
 =?utf-8?B?Y1doK1pEdlVmMWlwanNNU0VSc01RQmhEOTE2WHpObXpvajZ2UHZRd1Y3eVIx?=
 =?utf-8?B?NDFrY2wyc1lKRE9kN1FCb0tPaGlGang3WTZzRlpMN0dVMTJjM3BjaElWSVhJ?=
 =?utf-8?B?T1VtMTA0elhlL1BoOWZ0REQzTXh2L0RBU0t0K0dQaWlKQ0R5K3VlVmJRREhk?=
 =?utf-8?B?TG00UTFsWk5HekJNcXR0eXh2Rk5SbzNEOWRJMGZmNExwV2JmVlN3c3dQL09w?=
 =?utf-8?B?cmpUalJXbUVWelFKaTZPTDdESzUyQXcwc1JGTjhtRmJpQTNwZ2dnL0lIMjNE?=
 =?utf-8?B?UTNOZkZpWmR4bnBhMGp6aTBZWHhYNDZlVmdWYXcxOG1DQUhTV3l1SDIwYXk5?=
 =?utf-8?B?K1NacCtJQzJBMmxqT2tjeEI3Q0FhSVJEMUtlYUZtMHlRc00rRUU4UFNQMndn?=
 =?utf-8?B?SDg2WFlmcWhYVUZPdTM1dk5lbHlXZW1UajBOM25ES1BXM0FONEIreXN1Z2JM?=
 =?utf-8?B?SFk1dFc5Z3lkb25QcHdGRjZlbDRPNTAxdmFjTXl4eklDaHBRNXVTeGNxemVj?=
 =?utf-8?B?ZHdxUTZmc3FlWkxhNkRaSXZSQkNHVTlIUkZqVndmUCtxUVgwVWZ1QmhjbDVU?=
 =?utf-8?Q?nevtnRJzjAoavzQeY8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb5718c-847b-4dd1-27a5-08df18cf46e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 17:31:03.9274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTLMRSKZ5SFkK8OApMjakjlw9RB0KD9ZG8Uq0RmftBZshva8b/zbn5zmL2DpmTLi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
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

--------------Q5xy6rimZCdPOhFCCNZXlgMZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-09-15 10:58, Andrew Martin wrote:
> Commit 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to
> no-access") made svm_range_validate_and_map() OR bitmap_access into
> ctx->bitmap unconditionally for a range carrying
> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED.  Previously that only happened when
> ctx->bitmap was still empty:
>
> 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> 		if (prange->mapped_to_gpu ||
> 		    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> 			bitmap_copy(ctx->bitmap, prange->bitmap_access,
> 				    MAX_GPU_INSTANCE);
> 	}
>
> The block just above already sets the bit for prange->actual_loc when the
> range has been migrated to VRAM, so under the old code ctx->bitmap was
> left holding that single GPU and the OR was skipped.  Without the guard
> it now also picks up every other GPU with the ACCESS attribute.
>
> That matters because ctx->bitmap is not only the set of GPUs to map.  It
> also selects the HMM owner: owner is taken from the first set bit and
> reset to NULL as soon as two set bits disagree.  On a two GPU system with
> ACCESS on both, owner becomes NULL, and amdgpu_hmm_range_get_pages() then
> no longer recognises the process's own device-private pages.  HMM calls
> migrate_to_ram on each of them, svm_migrate_to_ram() sees
> p->svms.faulting_task == current and returns 0 without migrating, and
> hmm_range_fault() retries the same page forever.
>
> Which GPUs disagree depends on the interconnect.  SVM_ADEV_PGMAP_OWNER()
> is the XGMI hive when the device has one and the adev otherwise, so GPUs
> sharing a hive also share an owner and never trip this.  It takes two or
> more GPUs with ACCESS that are not in a common hive, which is why this
> only shows up on multi-GPU machines with no XGMI link between the cards.
>
> On a 2x Instinct MI350P (gfx950) this hangs
>
>    HSA_XNACK=1 hipblaslt-test \
>      --gtest_filter=aux_handle_test.set_sm_count_target_default_is_zero
>
> The application never completes and burns 100% of a CPU in the kernel.
> /proc/<pid>/stat shows utime frozen while stime climbs and minflt advances
> at roughly 12 million faults per second, reaching billions; majflt stays
> at 0 and the GPU sits at 0% busy.  perf on the stuck task is 24%
> svm_migrate_to_ram, 23% __handle_mm_fault, 5% do_swap_page.  The process
> cannot be killed and the machine has to be rebooted.
>
> Restore the bitmap_empty() guard.  The rest of that commit is kept: the
> bitmap_mapped tracking, bitmap_needs_unmap, mapping_done and the unmap of
> ranges set to no-access are all unaffected, and bitmap_mapped is still
> ORed in at the top of the branch, so a range already mapped on a GPU
> still has its mapping updated there.
>
> The instrumentation, the hardware testing and this changelog were done
> with the assistance of an AI coding agent; the resulting change has been
> reviewed by hand.
>
> Fixes: 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to no-access")
The fix tag is correct, suggest to change patch title and commit message

drm/amdkfd: Fix always mapped range mapping to all ACCESS GPUs

     CWSR ranges use the always mapped flag and only need a mapping on the
     GPU running the queue. However, svm_range_validate_and_map now updates
     the mapping on every GPU with the ACCESS attribute, which is all
     supported GPUs when XNACK is on. After the range is prefetched to VRAM,
     those GPUs may span different XGMI hives, so the page owner mismatches
     and is set to NULL. hmm_range_fault then tries to migrate the VRAM
     and is set to NULL. hmm_range_fault then tries to migrate the VRAM
     pages back to system memory, but svm_migrate_to_ram skips it because
     migrating pages back to system memory is not allowed while the GPU
     mapping is being updated, so the CPU page fault is never resolved.

     Only map to the ACCESS GPUs if the range is not mapped to any GPU and
     is not in VRAM.

> Signed-off-by: Andrew Martin<andrew.martin@amd.com>
> Assisted-by: Claude:claude-opus-5
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c521ec07bf3c..75e25f075da3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1758,9 +1758,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   		/*
>   		 * If prange with always mapped flag, update mapping on GPUs with
> -		 * ACCESS attribute
> +		 * ACCESS attribute.  Only widen the set when nothing else has
> +		 * selected a GPU: ctx->bitmap also picks the owner passed to
> +		 * amdgpu_hmm_range_get_pages() below, and spanning GPUs with
> +		 * different page owners forces that owner to NULL, which makes
> +		 * HMM fault on the process's own migrated pages.
>   		 */
> -		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> +		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE) &&
> +		    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>   			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
>   				  MAX_GPU_INSTANCE);
         /*
          * If prange with always mapped flag is not mapped or migrated
          * yet, update mapping on GPUs with ACCESS attribute. Don't add
          * them otherwise, ACCESS GPUs may be on different XGMI hives,
          * that would force hmm_range_fault to migrate VRAM back to ram.
          */
         if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE) &&
             prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
             bitmap_copy(ctx->bitmap, prange->bitmap_access,
                     MAX_GPU_INSTANCE);

Regards,
Philip
>   	} else {

--------------Q5xy6rimZCdPOhFCCNZXlgMZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-09-15 10:58, Andrew Martin
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260915145833.601947-1-andrew.martin@amd.com">
      <pre wrap="" class="moz-quote-pre">Commit 6b2969831f7e (&quot;drm/amdkfd: Unmap svm range from GPU set to
no-access&quot;) made svm_range_validate_and_map() OR bitmap_access into
ctx-&gt;bitmap unconditionally for a range carrying
KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED.  Previously that only happened when
ctx-&gt;bitmap was still empty:

	if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
		if (prange-&gt;mapped_to_gpu ||
		    prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
			bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_access,
				    MAX_GPU_INSTANCE);
	}

The block just above already sets the bit for prange-&gt;actual_loc when the
range has been migrated to VRAM, so under the old code ctx-&gt;bitmap was
left holding that single GPU and the OR was skipped.  Without the guard
it now also picks up every other GPU with the ACCESS attribute.

That matters because ctx-&gt;bitmap is not only the set of GPUs to map.  It
also selects the HMM owner: owner is taken from the first set bit and
reset to NULL as soon as two set bits disagree.  On a two GPU system with
ACCESS on both, owner becomes NULL, and amdgpu_hmm_range_get_pages() then
no longer recognises the process's own device-private pages.  HMM calls
migrate_to_ram on each of them, svm_migrate_to_ram() sees
p-&gt;svms.faulting_task == current and returns 0 without migrating, and
hmm_range_fault() retries the same page forever.

Which GPUs disagree depends on the interconnect.  SVM_ADEV_PGMAP_OWNER()
is the XGMI hive when the device has one and the adev otherwise, so GPUs
sharing a hive also share an owner and never trip this.  It takes two or
more GPUs with ACCESS that are not in a common hive, which is why this
only shows up on multi-GPU machines with no XGMI link between the cards.

On a 2x Instinct MI350P (gfx950) this hangs

  HSA_XNACK=1 hipblaslt-test \
    --gtest_filter=aux_handle_test.set_sm_count_target_default_is_zero

The application never completes and burns 100% of a CPU in the kernel.
/proc/&lt;pid&gt;/stat shows utime frozen while stime climbs and minflt advances
at roughly 12 million faults per second, reaching billions; majflt stays
at 0 and the GPU sits at 0% busy.  perf on the stuck task is 24%
svm_migrate_to_ram, 23% __handle_mm_fault, 5% do_swap_page.  The process
cannot be killed and the machine has to be rebooted.

Restore the bitmap_empty() guard.  The rest of that commit is kept: the
bitmap_mapped tracking, bitmap_needs_unmap, mapping_done and the unmap of
ranges set to no-access are all unaffected, and bitmap_mapped is still
ORed in at the top of the branch, so a range already mapped on a GPU
still has its mapping updated there.

The instrumentation, the hardware testing and this changelog were done
with the assistance of an AI coding agent; the resulting change has been
reviewed by hand.

Fixes: 6b2969831f7e (&quot;drm/amdkfd: Unmap svm range from GPU set to no-access&quot;)</pre>
    </blockquote>
    The fix tag is correct, suggest to change patch title and commit
    message<br>
    <br>
    drm/amdkfd: Fix always mapped range mapping to all ACCESS GPUs<br>
    &nbsp; &nbsp;<br>
    &nbsp; &nbsp; CWSR ranges use the always mapped flag and only need a mapping
    on the<br>
    &nbsp; &nbsp; GPU running the queue. However, svm_range_validate_and_map now
    updates<br>
    &nbsp; &nbsp; the mapping on every GPU with the ACCESS attribute, which is all<br>
    &nbsp; &nbsp; supported GPUs when XNACK is on. After the range is prefetched
    to VRAM,<br>
    &nbsp; &nbsp; those GPUs may span different XGMI hives, so the page owner
    mismatches<br>
    &nbsp; &nbsp; and is set to NULL. hmm_range_fault then tries to migrate the
    VRAM<br>
    &nbsp; &nbsp; and is set to NULL. hmm_range_fault then tries to migrate the
    VRAM<br>
    &nbsp; &nbsp; pages back to system memory, but svm_migrate_to_ram skips it
    because<br>
    &nbsp; &nbsp; migrating pages back to system memory is not allowed while the
    GPU<br>
    &nbsp; &nbsp; mapping is being updated, so the CPU page fault is never
    resolved.<br>
    &nbsp; &nbsp;&nbsp;<br>
    &nbsp; &nbsp; Only map to the ACCESS GPUs if the range is not mapped to any
    GPU and<br>
    &nbsp; &nbsp; is not in VRAM.<br>
    <br>
    <blockquote type="cite" cite="mid:20260915145833.601947-1-andrew.martin@amd.com">
      <pre wrap="" class="moz-quote-pre">
Signed-off-by: Andrew Martin <a class="moz-txt-link-rfc2396E" href="mailto:andrew.martin@amd.com">&lt;andrew.martin@amd.com&gt;</a>
Assisted-by: Claude:claude-opus-5
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c521ec07bf3c..75e25f075da3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1758,9 +1758,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		/*
 		 * If prange with always mapped flag, update mapping on GPUs with
-		 * ACCESS attribute
+		 * ACCESS attribute.  Only widen the set when nothing else has
+		 * selected a GPU: ctx-&gt;bitmap also picks the owner passed to
+		 * amdgpu_hmm_range_get_pages() below, and spanning GPUs with
+		 * different page owners forces that owner to NULL, which makes
+		 * HMM fault on the process's own migrated pages.
 		 */
-		if (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+		if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE) &amp;&amp;
+		    prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
 			bitmap_or(ctx-&gt;bitmap, ctx-&gt;bitmap, prange-&gt;bitmap_access,
 				  MAX_GPU_INSTANCE);</pre>
    </blockquote>
    &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* If prange with always mapped flag is not mapped or
    migrated<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* yet, update mapping on GPUs with ACCESS attribute. Don't
    add<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* them otherwise, ACCESS GPUs may be on different XGMI
    hives,<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* that would force hmm_range_fault to migrate VRAM back to
    ram.<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
    &nbsp; &nbsp; &nbsp; &nbsp; if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)
    &amp;&amp;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; prange-&gt;flags &amp;
    KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_access,<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; MAX_GPU_INSTANCE);<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20260915145833.601947-1-andrew.martin@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	} else {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------Q5xy6rimZCdPOhFCCNZXlgMZ--
