Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409E5CA5FD4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 18:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F6710E519;
	Fri,  2 Oct 2026 18:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YWfWPvhW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C6210E519
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 18:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ar58ojaNXSTYmOX2OV8hxdrrfOvMnGbKgWGBVrHSazPbutEwnCrA7ZLvR+8WLQym0zO4cOESVmgsaahulcWsfmrrF76i+O2rnurGK660/Or3EWbzGtNRUSwVkgPNr5H06ggmD7ggOWGZrPxX0kNX5ke03Uq2oLIiqpv1ctSjfmKBtDMywVr4E8FE20Fr3oP/X+GO7MTpgYNLbK50t1045Wk6q9ZFvQPEmVXe5JrV3qPehU8lRpm7QLSid/fAVb0n5g7SFf/eBOt2beYUMlfFyVYnLbmssuTooSYRasRtmmUas0KCZddxir+w6BuWQ6JqEbEpEo6owIU9++Ya07aCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izI3ZQEr1aG8ZbFc4yUJitGhppiNDTpgDnzXXNw47Qw=;
 b=YDiPL80DfkxUCmhvf1E6lHm+jOprUejsa9w542Q2M/ku4DuGImfs4zqrY9mRvIA30EMwnNWCb6PheQxRw99n0intaUJQt6QlH+CvgabfvpI/jYTGsGzWrwoBWENbKsAO4zWT4ohOfWfCNN/v6aX23S/zjhRX1sEB3dinmTjOAX0VsraoWMRCpLU8dF4CFR6YV6BXXQkZ5uYmSNpV2rEFp2ZeeQoSjf6aj/4/nbxLtyRLunIKYvovRHqVdJYmB/pE0NVU/5gePVjEchCZJrvcj+L5CElsweSxC/3bd1q/sThMAhnSfaOTyo5JtxGT35x6dhaGJNwY1Vm+z/1Neeqwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izI3ZQEr1aG8ZbFc4yUJitGhppiNDTpgDnzXXNw47Qw=;
 b=YWfWPvhWNZjRw6ZQo0tECftfhyKChGpHsy0H9kg73hvSFMleU82HMrwL0AgBRJqpALTKz6VCVhiG5sAjA7bbibuZL3qrc6p93qX4vb8RAZFjNxHZ1UKzzeVAGv8CDX6ho63s4CmOd8n3NgTO/gXzD50v0LPRewmYgi4QirUXF64=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH8PR12MB7255.namprd12.prod.outlook.com
 (2603:10b6:510:224::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 2 Oct
 2026 18:11:41 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 18:11:41 +0000
Message-ID: <92c65dca-d5fc-40c2-9fb4-bfc07f6f2e25@amd.com>
Date: Fri, 2 Oct 2026 14:11:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: align SDMA doorbell base for shader
 doorbell writes
To: Saleel Kudchadker <Saleel.Kudchadker@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261002173445.1744755-1-Saleel.Kudchadker@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261002173445.1744755-1-Saleel.Kudchadker@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: f162da61-84f1-4e5c-faa3-08df20b09be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kPRR/WO7QbDzWcwNhbGrNCCnJeKl1wSbnhTKptnoRvBTVNqg4si7+8+5lYgySVcX/8XeSYdvWVRXynTiWDw/j985a0Xm9Coosf6CCA7hh9wL2UrzzvaXlp9b2zMGMEqgxYfD7oqMRm3J7drXjVdqtrIMLBjaVPIb2u50GPTiM3UNFy5XhQy1XlQg5S5YFXCw/LNK5CEmZmSqYJ+IxnIv+u9Sh89r94RYZW4Ggrw//4f4/+NOLvBQP+RdBfGRM4oiaRv8XiEprOd+xivFHXHFFrOFKUhwKMGrreDoBhs7g2H8h6EJu4PQy8H+aki4vpVvIhgSRP6Q9UZtNUnUmqjSIqYOorurCF4pdb9bntMTxYM13jrUM5PJfO2gEN7D825aa8RMa3kgUEQx2nnwojkHic6xYyJEOFGOMr+6tcSAWVU7y24sWik4eDEDNTvooS2M8fzuzQ7TgFp7KdO6z3EZIssJ1QH1/J2D7MGXUalHDqN92Zcl/O+4Ds294ervG1fQoPUzSYXjabu2atkegIhOwiuroiDQxzDhZJ6YivPG7JqgBmCvDK5ioWul1KTx5n3KwYjkXeuY/WJBHagy0EOH2P2wSZsmS7/UUSXfePNQU6xYyR+S1w7xiEoRxtM+96hUishZ81HklH/9p1Tqe+L9//LpPpIzIo5CkcVuqE315kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdZVk1lZUtsTlR0TGxlYVNkOVpyMDlkQThlMHplQUh2VUowOXlkVkFjVkU2?=
 =?utf-8?B?dmNRaSs1SXI0VmpvOXlWZUFIZ0xCemFmcG1LbEhMdmJIazRJK1FJZ2hETXlm?=
 =?utf-8?B?OWx6NUlzQjdEOXZzbGhpampFUEtnNkZEWW9WbEFzeW1MOVh1QUdjeVZxM29N?=
 =?utf-8?B?U2ZQTzZjOVpkdW9PTHNoMEFLT3ZDbUJkeXhLb2VpRjNiVkphVHZFNFQ0UzR6?=
 =?utf-8?B?OVQrTldiaUlVS0s5VXVLRENNN0szOFlJMTgvOHE4WTRXMXBjSnptZTNEcS9l?=
 =?utf-8?B?S245NjZUczJoOTBxY3YxdWhjY1R5SUtUenpXbHFNTVVuUjNNb1lwOSszRDdP?=
 =?utf-8?B?TnVFcnpNaGRDckt4NENWdGMyek5maExWS2NuUGRwMUxIYkZJdlUyM005OXQr?=
 =?utf-8?B?R05ETjJubWU0VVZkVFY4VFBZVi9VYVhydGc0cjljQUV5Z1R4N1o4aFBHSm9h?=
 =?utf-8?B?YStZRkJzZXFzQXFtdUY0QWlDUi8xeis3MjU4S1ZHNmVwTXVLTDluZExTTHZH?=
 =?utf-8?B?WDRsU25vTVJpbGtRYmdmWHJOUXNtQmVjTmxQaGpCUlJpcEFDMmhpUHZTZFF0?=
 =?utf-8?B?U1c0bDcyM1M0M0dHbG9UR1VYSjlOUCt2T0kvV1F3WDdzOUZPQUwwT3lkbzI5?=
 =?utf-8?B?MDBrbDN1cEYwVGhuSDB5b3N0QUVqcnFpWDhsbUNWc1gxQ2U3VmhidFlRNUxH?=
 =?utf-8?B?SFlpU3ZwN2JIOTQ3cFhQOUpHL3ErL2F0ZGFyaEQ4U0w4eE1SeERkZ0pibmNR?=
 =?utf-8?B?d3E0V0UybjdQT00rVUdnTUs2Zy93NzJodUJTZ1NyU0ZiYlZ3Q3JlUThEby9O?=
 =?utf-8?B?UThnbHdLTm1IQkFHWWJCRHhHS0FTT2ZBYnZoSVVKNGVBclRtdm1kb1NQUEdB?=
 =?utf-8?B?a3Myeit1OTM1NE40ZEFSSFh2ODhERDhTamtZYktKUUNkVlpGNDZCVzBrMHVs?=
 =?utf-8?B?MmdWaUhpTXBvNDJYWGdTZXZhaGMzaWxDSVZuNXBpNlpOWUZ1NnpuU0RXMHU3?=
 =?utf-8?B?NFYycEI1ZnZRUU15TW9jYmFwb1JKQ1laVllVcm9lb01xeURRVVNtTWVMaTZ2?=
 =?utf-8?B?V3lCeG5FQ2lEQXpweXd1VmlHVHNYajJYczNMZ2ZlSmFaZW5rME1KMGVZb3hJ?=
 =?utf-8?B?cllRZitkbXV1akgvcXBKVzc1SlZHVWROZCtqaDM1L0FvSEJUc0hhNHJUYUpM?=
 =?utf-8?B?TlZRSmt0ZkQyb3UrRTBNSk9tTUVKazVDQ3ovRkg3SCtQZHkxZy9NSUtrd2N5?=
 =?utf-8?B?MGVxai9kT01NVzFHYVBJRGh3SzVweGY5MlViL29DUXJPbVFGTm5TVVJVOXhD?=
 =?utf-8?B?WEEwWVpNY2JTMWd2SDFiMDdkWjZhN05LQlczRzBuY05BRFprcUwwY2FRS2lB?=
 =?utf-8?B?NXpXRGZkd2hpU1ZleXdpZ3R3dDVzMVlqYkdPaUk2T3dqRmRBbkZqaWFQZmkz?=
 =?utf-8?B?WThGUnJlSzZiR2dKMzJUeTd4L0doMXZoeGNodVRtZWM0TGdGc3VncmVsdzRH?=
 =?utf-8?B?cE9Vc0QrRTRyV0ppMWVQL2srWjVtQ3hXZWlMOW1TRVdTNFVQNVdSTDdiNVhN?=
 =?utf-8?B?UjZrYkEzQXkyVnNmcnowTXpWb3BVTU9IYlNTRHpKa01vbW1tbHVsc253d0Jw?=
 =?utf-8?B?bDRhVXJzVThCbmF2aFArOTVadjUxcVQ1QVhrNWFxaEFVMFVwSXovUVhKeWtK?=
 =?utf-8?B?dGRtOE52Qyt2dzZ1M1RKNGhzWmhGUi8yMG5NK21zU3ZkRDJ0aVY5eHVGVFVH?=
 =?utf-8?B?Mkd4TEdRbUxmT3dyYUczZGR5R3UzY09uWXZCc2dwbFBTd3pOdWozOXdXcE5n?=
 =?utf-8?B?S3YyOUNvWFgvZFlKNlZ2WmdJQ2VTcVBJb3pXSHVsUTZ2ZGtPc29nZ251SThu?=
 =?utf-8?B?ekFyZjZuUjkySW9IT25VcnNsOEFyUUVFcjZGeHRRK2FBT1A0N0EzZzdocHUv?=
 =?utf-8?B?UW1kWTExMkJtUXJSRmVqV1VTb2t2NEU4cGFkd2NVRk13ODdMeVNTckdMbEVN?=
 =?utf-8?B?UGhLRG5MMjQzMld2aEFwMVBPakZtMUpPTnhhYnZDSWZWZjJmZ2RZcG1LMG1S?=
 =?utf-8?B?TnR3MklqTThWR2NRcDBJdXN0UUxTTUo1TUVHNVdLZENhaFFVbzRqQlB6bits?=
 =?utf-8?B?Q3N6S2EydVNzNHduQUlQMmhiU3FuTWxneE80Mi9kUkN2L0szQnNpa3B6RkZP?=
 =?utf-8?B?ZXdjNzl5RFpvQWRGM3pJVDJxNDBTd2ptdTgxcExjdFgxQnJyZStjb3VQWDVx?=
 =?utf-8?B?WUpSTWRSWXM1SFgxbnlGdmdFLzlxU2xKZllBZ05RQndtdmY0eXF0VEpDMnJn?=
 =?utf-8?B?dkZDcGRYWGlvYlBoR0VGVDQ1LzdQQXV2Ry8ycC9ld051d0VXTEJTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f162da61-84f1-4e5c-faa3-08df20b09be4
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 18:11:41.3149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFptl8418tieFsxtIa32ub3BAhj81RD8Wve4jJj/QyZerR3JKvMjJ0ePlGdTa+xAqtLTrau5rkxzJqq2fkvW1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
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

On 2026-10-02 13:34, Saleel Kudchadker wrote:
> On GC 9.4.3, 9.4.4 and 9.5.0, doorbell writes issued from shaders are
> routed to an SDMA engine at 32-byte (4 doorbell index) granularity.
> SDMA engine doorbell ranges are 10 indices apart, so the range of every
> odd engine starts 2 indices into a 4-index block that begins in the
> previous engine's range. A shader ringing the doorbell of a queue on an
> odd engine therefore rings the previous engine instead. The intended
> queue never sees the doorbell, so its work stalls and the application
> hangs.
>
> Align the per-engine doorbell base up to a 4-index boundary on these
> ASICs. Each engine only uses 4 of its 10 indices, so the aligned base
> plus the queue offset stays within the engine's range. Even engines are
> already aligned, so only the doorbell IDs of odd-engine queues change.
>
> Only doorbells rung by the device itself are routed this way. Doorbell
> writes from the host, including the kernel's own SDMA rings, are not
> affected.
>
> The doorbell ID of an SDMA queue is saved in CRIU checkpoints and
> checked again on restore. A checkpoint taken before this change that
> contains an SDMA queue on an odd engine will fail to restore with
> -EINVAL. This is intentional: the restored process still holds the old
> doorbell address, so accepting the stale ID would bring back the same
> stall.
>
> Tested on MI300X with a shader-rung SDMA doorbell test: queues on odd
> engines hung before this change and complete with it.
>
> v2: use u32 instead of uint32_t for the new locals (checkpatch)
> v3: name the routing granularity, use dev->node_id, document the
>      layout invariants, describe impact
> v4: express the granularity in doorbell indices, drop unrelated
>      cleanups, explain the CRIU restore behavior, add test note
>
> Fixes: 6df442a03d1a ("drm/amdgpu: add new doorbell assignment table for aqua_vanjaram")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saleel Kudchadker <Saleel.Kudchadker@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I see you added Cc: stable, but it's not actually on the Cc list of the 
email.

Regards,
   Felix


> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 32 +++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++++
>   2 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6d12f9dc7f04..5e57576fba21 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -599,12 +599,32 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   		 * we need the physical sdma engine id in order to get the
>   		 * correct doorbell offset.
>   		 */
> -		uint32_t valid_id = idx_offset[qpd->dqm->dev->node_id *
> -					       get_num_all_sdma_engines(qpd->dqm) +
> -					       q->properties.sdma_engine_id]
> -						+ (q->properties.sdma_queue_id & 1)
> -						* KFD_QUEUE_DOORBELL_MIRROR_OFFSET
> -						+ (q->properties.sdma_queue_id >> 1);
> +		u32 engine_base = idx_offset[dev->node_id *
> +					     get_num_all_sdma_engines(qpd->dqm) +
> +					     q->properties.sdma_engine_id];
> +		u32 valid_id;
> +
> +		/*
> +		 * With the aqua_vanjaram doorbell layout, a shader doorbell
> +		 * write whose 32-byte block starts in the previous engine's
> +		 * range rings that engine instead. Engine ranges are 10
> +		 * indices apart (sdma_doorbell_range = 20 dwords, halved for
> +		 * 8-byte doorbells, in aqua_vanjaram_doorbell_index_init()),
> +		 * which puts odd engines 2 indices into a shared block.
> +		 * Aligning costs at most 2 indices, and 8 queues per engine use
> +		 * only 4 of the 10, so the aligned base stays in range. The
> +		 * 512-index mirror offset keeps the alignment.
> +		 */
> +		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
> +		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
> +		    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0))
> +			engine_base = ALIGN(engine_base,
> +					    KFD_SDMA_SHADER_DOORBELL_GRANULARITY);
> +
> +		valid_id = engine_base +
> +			   (q->properties.sdma_queue_id & 1) *
> +			   KFD_QUEUE_DOORBELL_MIRROR_OFFSET +
> +			   (q->properties.sdma_queue_id >> 1);
>   
>   		if (restore_id && *restore_id != valid_id)
>   			return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2847a5ec5ede..b9a31489b1c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -133,6 +133,13 @@
>    */
>   #define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
>   
> +/*
> + * On GC 9.4.3, 9.4.4 and 9.5.0, doorbell writes issued from shaders are
> + * routed to an SDMA engine at 32-byte granularity, i.e. 4 indices with the
> + * 8-byte SDMA doorbells used on SOC15.
> + */
> +#define KFD_SDMA_SHADER_DOORBELL_GRANULARITY 4
> +
>   /**
>    * enum kfd_ioctl_flags - KFD ioctl flags
>    * Various flags that can be set in &amdkfd_ioctl_desc.flags to control how
