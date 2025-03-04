Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48443C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 05:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E4A10E2FC;
	Tue,  4 Mar 2025 05:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svyyWNKa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92FA10E0BF
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 05:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfLk+lrS76gwTLSBQh3MMWVZJE/1OJgSxW5u3GQ3lZhKH5qnzinhxfXBrJ8OMHl/JVq+C3AufsHaI+XhY7seG75DsBLRIF/u17shQO61U2gZKo3d0kbTDBDw0MtGQ6Opjrwfdp79do+nXwlgh+ci2yynsrX6raUYkG31J1iKSGtwnCSGvPCdPhUTkbbckmDIchHq614YsMipx4zqPqjxiuBtZ6HQ/NFDFXcCCpZdS9H4XqVxAyUNJEDHy4hHiMyQHGTR4DmLGek38QJdN6cF+j338ldpqnHkMRsUQ/bq0BgXjuYsK8f2aloCJaz5pLR/g874vdCS/FWA67T/Ej3ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN9/hmV2RDGP/kgErzfPcEjiDouXfjiw1GE/PiQBMrM=;
 b=Hq7Ix0v7rH98byP9R2g5RI15qfYapWdkn6rlsr1Mwb4OZ4dzfxc1mZ31Vxebu1QwzMBG3MoO23vwoBS1MP95qgulY6fK3oNxFEq4kX+haEyxPQ0u+p7X3wOBRhsSQ8a9mS7nokCfcPajvTNSpqMzXhP5tGyz2ujfZGiEqHq5fTKv2vVmLwDYT1cVknxrSpWb5jZA4prF05Ojbn1rN+AuMxSNykdwt8ZvlsSFfG0Q4p27i5nZ80oxG0U8UpuuACVuNe/MXPQ3Kx2RrY08TNXNaAe63j8P26ON8MNr0CzGS9X0IXYA4ZzepdzKeWnmctcyMAOQPx+LQZ0SdLQUmIVuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN9/hmV2RDGP/kgErzfPcEjiDouXfjiw1GE/PiQBMrM=;
 b=svyyWNKa0Co7kZfJSa4fOJSgJGuVfKBVBdLI6DvLCRas25gsC+u9qu6LPpc2ILTUjSo7i4k0lAb0oaYQcWESIorhH7/FrLnmcJJaD9t0BrH/7f1ikFv2a5dDp2NDvZVMNaa3Itu48+C+dZhiev0tyfXpqqBnr6ED7KSu7d7WKpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 05:21:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:21:32 +0000
Message-ID: <426541c4-770a-425e-872a-f69802e2d1ea@amd.com>
Date: Tue, 4 Mar 2025 00:21:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165839.8433-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250131165839.8433-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a91c1b-bcfd-414d-c12b-08dd5adc6d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnQ1MXJCYVBCVzZrc2NGdTFNb2xrOG5yUUllSDBtS0k2eGx1a2g5eHRMQ3Vx?=
 =?utf-8?B?V2p0SERidlMxV0JFS1VxSXBtaVlzc2wrKzJDeU9DMzFTRFJoeHNCYjUzUm9a?=
 =?utf-8?B?RmpJaCtRcVR5TklsVXVmQWJzT1Q0MC8ycms3UnlsTHZRWklrejJ3T1JHSWtL?=
 =?utf-8?B?QnduK1B6eXdDc3Y3dVhjNytPLy95V1NjVjU1STFYSXhZMmtOMkZXNHlIMDUw?=
 =?utf-8?B?TDJnRHl4QUFRRmlJMDh3RnlOUVBMKzVNajBoTDhoZGdtRG5MZ25saVZzY0x0?=
 =?utf-8?B?QjZUK3RickY3ZWNDeTllNkd4YUtMK1VBV3AxUWFMeHM1eW5hUUduV1FFcHk5?=
 =?utf-8?B?WW5pMWQ1WnNwUWhJWmJidFFLeE5jTnAzOG9mR3krWFJHUjFkRWlMQ1FJdS9W?=
 =?utf-8?B?eTJlazExcXNvTGVRL3U1OG0xdlNkdXgwZ0JnaDhFTVM4UExmbmFyYU95OTFT?=
 =?utf-8?B?VkM1ZkFyVW5icE94OXlBQWRsR0hMbUlPQ3dJTVYwck80bkc3aG9taEJtRlQv?=
 =?utf-8?B?NzZOOXdnS2x6bHdMNEE4bkhGdURJTXFUdVUxamptS2Y3ZEQxaW96UkE3UStG?=
 =?utf-8?B?QTZLN09EbUVsbHQ2azM2NFlRZ2lXa2JINFJwZmpoM21LNUI2TVh2Sng1Z2Js?=
 =?utf-8?B?aStLZ282N1lFekU1a2NXdkZNeEtUM1ZnbHFkV2VhZEpZN2t1Z3JBMUdaNHZi?=
 =?utf-8?B?YmpKdHI5UXlJTnNaRU05K1R4L2l6Z3Q5Y21hSTBNU1FnZEdDRG10alZTUTZ3?=
 =?utf-8?B?TVUvZUtja01US1h6YVMvRlY0blhza0M1OHJxREh1cUhYUVRuclVTZHp4K2J1?=
 =?utf-8?B?T3VUaC9sL0tQa0d5TWVlY3pmcWRObU1vS0xUQTdXY0JiMzQ1L0ROSnNrTUlh?=
 =?utf-8?B?Mm96UU80SStjczJPeW5YYmVKdzE4REg4TWxwSzFEUFpNYVBrQWVMZHpLZG9y?=
 =?utf-8?B?TlZFMmgvZWpITnV2T2lFdXByc1NLYjFuVkNuWGZRd0NwcGxxTmdlTFM0Z2pF?=
 =?utf-8?B?SndOZTQ3THFPUnB6d05rZGx0cmNCZ2h3S3FSdWQvQytNZ2Q1TWFzblJoT0xq?=
 =?utf-8?B?c0ltaDlMZDVYLzRhb1lHejZuczdoYW1PeVNJMzIvQ24wZ1MyK3cybk1zaU4y?=
 =?utf-8?B?dE5qZGJ1Rzl1WGxCOUh5MHNiSTU5Q3ZUZEUzVGVoREh0NGVYNmVSenJaT3NV?=
 =?utf-8?B?RWRjSGFoYzk4T2RjZ1d0VVFBNWhSL1QzVFZ0dVNKM0NFdnZKazgyaDhDT2U3?=
 =?utf-8?B?Uk5UNmVGckVMU0RlWjNTTTFwM1lWZW9SYk5qK2ZPaExMa1Y1ci9OZENVOWxX?=
 =?utf-8?B?Tys3dm5xOTJDa1hGOFkrS0JrZFYxR1E4ZHdjdGdKc2ZoeGV5bk5oSDVZTTBO?=
 =?utf-8?B?OFJlbm1mVVR5TlA5dnFxVlpXR0FPc2dvcXNvMFFZOGVrTFIvZW1JWHN5T0Zw?=
 =?utf-8?B?REdId21wNGhEczVuZHpNbEpSTEdlczhXUUFqUTlKRWUvRVhOZDlabXpEbEY2?=
 =?utf-8?B?cTMybUxZNnpnVGhQbE0wTXkwQlN0NG1kZjNITFFZbTBLbGVkNUF3ZVRCb21N?=
 =?utf-8?B?bGtmSTJxQjFaRSt1MFdITk1VVjBwdk9VYnd4STZrcC8rajJtOWt0NzdPanl6?=
 =?utf-8?B?N2hwTjlUUm5vb0RCQXl2R0V5NUtuN1dsbzN5WjJmdHE2cFJoREcwWEpsNi9r?=
 =?utf-8?B?alh5TUF2dUdWUzlyVjlrSGtRaUVCUVNpWEZ5QzVBMEpXYVhHM2p3d294UWJo?=
 =?utf-8?B?Vk9leGhaRUo1emYzRTk4TWtIdk0za09nc3VWVjZzZmEzWCtGQUgwVnBXQU9q?=
 =?utf-8?B?Z2UyMXo0bksvOWs3elB3UE1hTkM5Qit3Ry9wanNXTUJoVWhpY1UzbndydTAv?=
 =?utf-8?Q?SUL7lxyXFEGAD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjArUFJpYlBjWllIWjBGZVptd2kzb0V5cytQNm9HK0JqdnpkRTRnY2t5MXR4?=
 =?utf-8?B?Qk96MFE5aWtqQ2o4bGJyTXc5VEFqcStJV0JvSTB3WTdReVJ4d0FMT2hvblhk?=
 =?utf-8?B?ZEF1cDl5L1R2SFBCUDloazNDeHc2aVMxZU1sOTVMK05nOVFhVTNMYmt0Q0lr?=
 =?utf-8?B?Z3Rrc0pHSWJ0RS9Id1ZYTGdtZDFRUzgwVzF1TTlaNkd3OE84bEZpbFBldFF1?=
 =?utf-8?B?VWU5WTJJVENIa0dNSmhzeUpjZG9ObktHdU9pUndUY2N4QUVIVmNUSlFpUjln?=
 =?utf-8?B?RG1WOVhXT21Wa1RmdWNUcFBXcnpBT0ZKZG8yOEhoZGtWcFlySmJscFlONzMz?=
 =?utf-8?B?UncreUEvK2xzQ3ZTcjBCTWVJUUVObkZzeWJWWTFnY1l6eHdBcUhqKy9kQnlX?=
 =?utf-8?B?VGU3STJrUW1BYVhSdlJ5dFcrcENmSC9qMjJyNHF5dmpEcGJCUEZBWEkrNzV6?=
 =?utf-8?B?R29nVDdlMDR0ajdZb0MxUDVaQmVRTzBxWTEyZzB5YUNEMDdSc3NFZVJxbTEx?=
 =?utf-8?B?RnJsbUxETkpYTXQ1Y1VVbjJ3RVh5NmZCYUdrRGM2amkweTNoeWIzSHNCWDZa?=
 =?utf-8?B?V0RSajRSeUZUMUF4KzNFMkdoNGVsNUlqNmc5VUw2VTNaVDJqU1lsRmVJTExQ?=
 =?utf-8?B?elFVV1kvTkx4aXNjMmdwbjVZUUVNeXZkZUlKazU5Zm9SMm4rU2c1d3lwUVpG?=
 =?utf-8?B?a0lIMzZRSy9mU2Vnb0NpL2RhZVZBVkZUdHJXN0hSa3paOVlGME9HSnYvR3JU?=
 =?utf-8?B?TFIyaGVnOEFlcFhuSUdFRG1STXdROWdjK0FDbHVmOGxQTWpPQWM0d2JnK3E5?=
 =?utf-8?B?M2lxSk9QSVFoNk1ZUkNMNDB4eVVEZXFLWHRVQVFxVm1jSENoOWR0andxSThm?=
 =?utf-8?B?V0IvOUlpS09hbEVIUTZiYUVBaTJRS0RWOHNNM0tEMGZDQjNCU0d5dnVBRThD?=
 =?utf-8?B?TnZia2xjTU5iRDNVd3Q0QmhJZ284cW9QNlVDeExJNFJrM0NkcDNvTnF4eWpV?=
 =?utf-8?B?aFV6OWNjNXdHSnFYSkMwYUtpZUtURE1CTFRhcW5Wcndkc0xwMVpZTUxQK0Fm?=
 =?utf-8?B?ejlBUU8zemNsSHdEWHpJQ1ZzQVV3M3lSM3ByVnBZSFJzbnRwNHFDLytQV2Zo?=
 =?utf-8?B?NnBPSDNDbVgvbGdiM01xaUZnMFRza1JkUnNLeVpaUXJqOXplT2tMeFAvTUxl?=
 =?utf-8?B?RE40NTdUb0VXWTZSYjI5WSsxOFZvYnlIeXBzNG5OY1VBZ1JtTWxrc0VGOXlr?=
 =?utf-8?B?ZGNmSm1mTjZBOFJOc0tsMy85UXYxYVpZdkNuNW9CcnI1T3hKRVY4QldpQ2gx?=
 =?utf-8?B?Vi9VdFBVbzhXKzJ1WTIyK2pZWm0rV1BPaHRGeWVOeG00RTRsTXdkR0Rralp5?=
 =?utf-8?B?OGJVMjlqYzRodHZReVJBZ0RRWDJGaTR6SVdTOUJSQUJxNVRtM0FxYTB4Q2cv?=
 =?utf-8?B?YlI4UXFDTFpubnNlVUxNd3AybWRpN000dkRCcG5oMmVoV3dvVTM2WkZ4SWN5?=
 =?utf-8?B?MmxDR2Q1M3lFZitqQzJCMTJ0bkdHdDRzMFJjMjlZeCtkN2M2UW1PazBnZmFB?=
 =?utf-8?B?bE1jdG9hVVRjME5jaGdkVzRwQlg5dVkxbzdZTlVNMzdTL0VwR05OWHBiVmc0?=
 =?utf-8?B?ZmU3VmNvb2V6elZTdVdWdWwrdG51R256blZ4QzZMRHQ1ZklFaHplanlmWmg2?=
 =?utf-8?B?dWJLRXB5ems4VHF4SmRtOHR4K1FVUnEzcGhqeERUQ2RwQmQ1VmFrQ0JHVThD?=
 =?utf-8?B?ZVJXSU9wM3FmSVZmSllUZ1M3UG5JZ3RsV2h2Q2p3ZEtmR3RlTkduNjdUMUZu?=
 =?utf-8?B?ZlQxN1VhUlBkMnFyVjg2TFRVVEhHQ2VxR3FZQVk5TE9jR2Zyb3RlM2pPVGtQ?=
 =?utf-8?B?YWF6Qm9wZEFlSHdoL1FKNVg3Y2ZRS2ExQlpsL1FMT3I1TTNIS0w5MUNHYXMz?=
 =?utf-8?B?NVJZTEV0R2FwaEhRTmdSaWF2SWZsWE9GQjI2R21INUZRRnY2OXE3YzAvOHRo?=
 =?utf-8?B?aGxyR2ZnQ2d4QU9kL2Ztejc0UVVJb0NSTEJpQ0cxL1Fsb3VNd1FhbTIrcFZs?=
 =?utf-8?B?RGtVcWFwUENaQW90c2tDaXVIaDA3K1M4dXBtb1lDRjBZajdaZkV0eFBKWmlN?=
 =?utf-8?Q?omljyE4sZkWxlgAMLs702wJZr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a91c1b-bcfd-414d-c12b-08dd5adc6d0c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:21:32.6739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+1oUsKKNGNqTlxT1GFeEfB/dJOuKuP6SE4+eSj4a6OMfiphcsb6HvCPP0aA2D4Rrk9X5aqyygUfUqMQaanc6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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


On 2025-01-31 11:58, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When register a vm range at svm the added vm range may be split into multiple
> subranges and/or existing pranges got spitted. The new pranges need validated
> and mapped. This patch changes error handling for pranges that fail updating:

It may help if you clearly state the problem you're trying to solve to justify the changes in error handling. See more comments inline.


>
> 1: free prange resources and remove it from svms if its updating fails as it
> will not be used.
> 2: return -EAGAIN when all pranges at update_list need redo valid/map,
> otherwise return no -EAGAIN error to user space to indicate failure. That
> removes unnecessary retries.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e32e19196f6b..455cb98bf16a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>  
>  out_unlock_range:
>  		mutex_unlock(&prange->migrate_mutex);
> -		if (r)
> -			ret = r;
> +		/* this prange cannot be migraed, valid or map */
> +		if (r) {
> +			/* free this prange resources, remove it from svms */
> +			svm_range_unlink(prange);
> +			svm_range_remove_notifier(prange);
> +			svm_range_free(prange, false);

Freeing the prange removes SVM mappings from the process. This will break the subsequent execution of the application. In case you were going to return -EAGAIN that's definitely wrong because the application would expect the SVM range to work after a successful retry.

I'm not sure the resource waste is a valid argument in case of a fatal error. I would expect the application to terminate anyways in this case, which would result in freeing the resources. Do you see a scenario where an application wants to continue running after this function returned a fatal error?


> +
> +			/* ret got update when any r != -EAGAIN;
> +			 * return -EAGAIN when all pranges at update_list
> +			 * need redo valid/map */
> +			if (r != -EAGAIN || !ret)
> +				ret = r;

This is a good point. But the explanation is a bit misleading: "all pranges ... need redo" is not really true. There may also be ranges that were validated successfully. I think the point you're trying to make is this: Don't return -EAGAIN if there was any previous fatal error found.

I could potentially see a different optimization. If you encounter a fatal error, you can skip the rest of the ranges and return the error immediately.


> +		}
>  	}
>  
>  	list_for_each_entry(prange, &remap_list, update_list) {
> @@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>  		if (r)
>  			pr_debug("failed %d on remap svm range\n", r);
>  		mutex_unlock(&prange->migrate_mutex);
> -		if (r)
> -			ret = r;
> +
> +		if (r) {
> +			/* remove this prange */
> +			svm_range_unlink(prange);
> +			svm_range_remove_notifier(prange);
> +			svm_range_free(prange, false);

Same as above.

Regards,
  Felix


> +
> +			if (r != -EAGAIN || !ret)
> +				ret = r;
> +		}
>  	}
>  
>  	dynamic_svm_range_dump(svms);
