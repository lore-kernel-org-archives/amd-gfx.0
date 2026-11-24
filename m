Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CD606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cbKN7IFg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8AE10F49A;
	Tue, 24 Nov 2026 12:18:50 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36C510F49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 12:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBW0xM2VxO/jktpb9A/NM3VnECCenqjYTBqbWMZw0Qo9fJh/6uDJa9bdZp4wiCaJgSPL5V25UxJgeL7i+TfYFDvt2u6WTCE6IDsezln6C5CesxZAmSNpr7a93qlH8qvxQuSDcLUD+OfhS1SWxA84IGL7P4zCg60AGpRVhD25lB2ABaYJPKRrNRTaALcDW9y1Uz6f2HKj+zxH5Q/7jggxt3Stk+U6vvxBB2NR8OSucDfn4614hF1fqLiJjk9T/X21W1eMUhG9W31HLTt/g9qz9C0X69DptKAaLsQH7uoN6RzsZOMBl430foGRoAhcm/qAtwq21jFN2+8aw4BpuU2ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd5DJDcKiZfwFK5+97hU6JhctucqaInIbaesZdBz99s=;
 b=XtiW6NlABRtSGFzvjS/QSTjOVkesPSZExO8kmf4RUK/M0mYq+NxTmOoF5DrfierRq3LOnQNitRej07emFgBi2S35xv9bBkBVioK45X9zOUyawZ0qqV5kP2W9etsPsTgtBWQmE3i26Lg6iP++yVgNq3HjLKIJM+NPUk9VJ5chQPLh+DkPjJi7WHfpvbrm+bzUVvFjoEdM75A29wBSuikqB+HDXfIz+QAjV9/GJibZj8BtUDUF9qsDCyAy0/6/5UMFZHx0lmdVBx3HXPcsjChZ8jj/2qxZ15bG6wYXEB0iRcVfU48qYXbc8ywAxguavePhkLsJf6YueHfbn3yb5TeOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd5DJDcKiZfwFK5+97hU6JhctucqaInIbaesZdBz99s=;
 b=cbKN7IFgNo4vJsxEUWOOKb0dntXRUYgYq7z7ZkK6ZS2t36IywlRH14ryZTptZJHU0ZmSE+90KsD9Qqtxo37GzYueYz6U1Ty6NCcqYP9s76x2u8aClxJwbSlnkkP7NPplnxuQzYMbaNjhX+B4FxBjpBJtJX0qvd2l+3+fBUPOkKs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 12:18:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:18:40 +0000
Message-ID: <281811ae-0a52-434e-902a-fbf4c2b12a01@amd.com>
Date: Tue, 24 Nov 2026 13:18:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: switch vm->tlb_seq to dma_fence_chain handling
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261121195027.2588-1-christian.koenig@amd.com>
 <DS7PR12MB576839A67BFEE1DABB1B59C29B442@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB576839A67BFEE1DABB1B59C29B442@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ca4a81-6fa1-48eb-4023-08df4a2512bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|6133799003|18002099003|261009221227099003|261009223027099003|3023799007|4143699003|261022105027099003|261022075727099003|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: BcPjf+AwirC8dQV/mG7Z/doJEOCLBdhDW3Z28025bzN+ewWxJCoPJ2xQ0jzd2lLASGb4tq5DWGZugHXM8+LQ3faHqHEGv7Q49lR7z8NDEswryu/oRMv25L8yM39gkEsQHLIvtvtM5iJJ07cmRQPvlgxKKPudJZTBAhO6cv1CoGr004MXscwZcJ/z3gcGZdDNygo1y4k3Wbehs3lmIJu6srhGvaQ42rGOkYpja0ylWPlGzYeZUkJY8gv4Sv2GiCBYV7NMYhz77QbTLSpkLJXY/SWm/Ilf3KQkjWP20VSwQvluMSRSH9tGWmiYHSaavFv6GgcEUrz4NE1DtWxUyphy1RB45AC9LXPWFpDiKKHKbNSZu3qvUCDYS7VUeMpExG1XiTDcK1nCtp8qfyG3v2E/V4nf7e2omdrJxREb5LFI8V0wpc4pXaZFwCPb31tem1MinlKlopl0u4EHGNQPnPSxKF+52BgdrPds8qiOnD9Q8TV3g35rF2ZtfWtUwb6PHQ2ZoF+DO66vMlW36jwCrDy1GhM7OztO94xAmdjCScvyMTVEefNOdmXuK37YuHTNGyS98mELBCyA1VdAc5DAYXJ0+XWdId4TpneKuF+Sb2KvS+iFk4dOHV3WQrCV9iwNoESF7vrhA9Y1O9F8QbDeB0CAkhmlYs3/+kiT7TiGUe8b/Cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(6133799003)(18002099003)(261009221227099003)(261009223027099003)(3023799007)(4143699003)(261022105027099003)(261022075727099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktTVW1vYjErallXVXNSbzIyVW5oY045MVlHemMzOFNPSkYxaGhsWVB2UHJo?=
 =?utf-8?B?VHBqRG5ycGF1UzBSc0JKU25UMy8xdC9BbjZFZ1FSQjZxTUtITzBaalBwR1RB?=
 =?utf-8?B?N2dIMUNRY2ZsWWl6cmVrUXpSNmRtTkg4TnNramp4UGFJRjdBOHFZSG1jT01L?=
 =?utf-8?B?OXFZOTkzUlBUbDVkOFhYc0RDeVMvRCtFdWJjUnFCLzFSeVhhR2FmQjc0NlUz?=
 =?utf-8?B?eUJBdEg0QkZ1WXFIQjNJb29qR3ZGSUJrYmcrbHBJZVpEL1loZXBseTJLb0Fl?=
 =?utf-8?B?S0c4UlhPa0NkQXcyeG9adlFhanVwbjVTNFQ2Y2UzaTI4dzRjeDBuc0xZTlZM?=
 =?utf-8?B?aDRqYTUrT2JYaXd2WDJRd2FxWlpnQmpLZVNob2FBOWpvK0RBRlN4ckRyZCtF?=
 =?utf-8?B?MkhMOXJLQytmRTNHalFHRFZpZ0QyWlYvTk5YNmFMNkZuSllsMk02TzhoSEpF?=
 =?utf-8?B?T1duaXVYaXVhMFlTOW5wQVBCVHFQMWNTRzVpbkxuTnFZYWVJdktlYnI1RUlI?=
 =?utf-8?B?MVpTWVNSbWdQOHdPWmUzRHpraWVKazY1TGJnUGtyYWpNdkRJcnBMWEZ6K1BF?=
 =?utf-8?B?TzgrYkowWlVFZ2QzWGRSMXBsS0k1bWVnMENQMHBJSXlvUjlLWGljejNiT2hV?=
 =?utf-8?B?WW5ndndISU9IbkR0MmFkNmhrcXM4cE9vZ2Rna2tHdU9yT1UwY0ExeitCaDd4?=
 =?utf-8?B?a2ZOS2NsdnVEbXlGVVU5RkV1M1JvQ0FmVGRMM3hQWHpzYmUxSkJPdWo0dmV3?=
 =?utf-8?B?Mmk5V0xPcGd1STExQzBLdzlrMTMvaWphbktlcTRsV2dQQzhlM0IweEZSQ3Vz?=
 =?utf-8?B?YlA3YnBkMFVlYmhpcVdueEtDNm9iU2ttSFhRQjF1YWRwTTBaUWdrRllOL0NZ?=
 =?utf-8?B?NGc5eEtKUzE5eGdHSFh5ejNsTzd6U2FsMnFxQzljbi9kTHBJZUYxTkxPOGE0?=
 =?utf-8?B?YzhxMEJJOHhOZ3lCQkFYb0Z3SEJDcVE0dXI1UzBmd3RIbVRCMkFjK0NXZWNJ?=
 =?utf-8?B?bFNPd0ZqTnh5S1JlZnpDcExCeTFQYWVsZnFFWVh6SHFZS1YzSVZ3ZXBNYnl5?=
 =?utf-8?B?bGF4am92TGpURHUyZTRxeS9NV0hOQ2thRlZndkZzeXVwc1R0bGRZUEdGZEFH?=
 =?utf-8?B?YzdZd3RnVnBQeEtvWXdCNzdqd3dMd084UjBweGhlaFFBTkJ2aDYyZzZZUDJm?=
 =?utf-8?B?R1VmNGFoOVRHM1h6d1RrS0JONytVditXeCsxUHFSbU00bVJxRDRxZzk0MmR6?=
 =?utf-8?B?MnBtNEVjR29EaDl0bVk4WEUzdStDRnFUeXlEZzJYb1p5N1VWWU0wWmtnYzNT?=
 =?utf-8?B?LzNvNC9sTEF1cTVTcTFGd3JSdG4vRWtDZHQ0QXhkUnpSb0xndkZHMmhRSWhT?=
 =?utf-8?B?bW01MmhBeUpmYytlMTB0UU9WdG4zNGpNeWxDOU5xYmxDcDFERFIwOHBmOFF5?=
 =?utf-8?B?cmxkZEtwNDVYQTRRSE5xU2VkOFd4Z3VjSkRqa2lmRnBNU1R2NEZTcEZLUjRJ?=
 =?utf-8?B?aFc2UnVDODhqVlduMFBldDJha3lXaE51OGI5TzVmbkZmWDhvVEo3djhNcWx2?=
 =?utf-8?B?bHl5TkRKREZvN09BN3htck1qaTgwVVJjZENBRGFBU3oxUmtXTmQ0L25XekFC?=
 =?utf-8?B?YVdiN0JFQVFpZWtlYVJqc0p0ZXJTWE4vclhnMGdYZ0RNamlhd3J0U1JyQjQ2?=
 =?utf-8?B?WlBoZzNWMUpjU1JqSjl2VGxjQVluNmtPL091eXY5VWZPanRCU1JxckVRTHhL?=
 =?utf-8?B?TTZhNmNmOW1ucHNpdzBGOEN5QkFneXU5cDF2N3ZkYXNGSU1xR2NBMkFwMC9r?=
 =?utf-8?B?WEpFSHFVMzdoeHVHdXJyanU2aVZqMCttQVBPS1Q2VnVUOXBNYXNSTnVxOXdK?=
 =?utf-8?B?d0ozb0pGV3JFR2FVNnUzSUFHNUZNeGhJR1VHSnkxVTU2R01TSXNTZmFKYVhm?=
 =?utf-8?B?V2VHc3ltcWRpNzZwNndKMGxNYVdmei9rcVdhTnhEd3Z1QWlrcHNDVk9zcFV4?=
 =?utf-8?B?ZDJVTmdtc2YwK3E0V0prb1Fzd3p0MGEwQ0FGcy9kaEdZWldCamJzZHZWMGx0?=
 =?utf-8?B?cFBuNE9UV3dNUzJ5Rnk1TDMrdkFRZTVzYXpnYjJvalpSRDJSY1YwbjNrdk9L?=
 =?utf-8?B?eW9JNHUyWmFjcjhOL1czZW9jMTltZ09oUzFoYUsrSjFHeE1ZM1dhRHA5bUFT?=
 =?utf-8?B?NUs1azFWV2J6QVpWd09lMkxYZUs0ck9xRnlYR3duSVUxbkwwS2FwWHhiU1B4?=
 =?utf-8?B?SnBrd1dVUjZmWndRTWg4WXEwTTA3bU9LeDZBVW1Ub1VvNU1ORHc1V1kyQlJO?=
 =?utf-8?Q?wa+nYx9MFAZnKhKsk9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca4a81-6fa1-48eb-4023-08df4a2512bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:18:40.1318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PD1E2mTCtfOW3paIxCBtA5Yo9vQ/zhZR+YUiBli47sPNN2V16KZpfHteNh1qmHmB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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

On 11/24/26 05:46, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Christian.
> 
> 
> amdgpu_vm_tlb_seq() in this patch can never report that the newest update
> has finished:
> 
>> +     dma_fence_chain_for_each(f, last_seq_flush)
>> +             tlb_seq = to_dma_fence_chain(f)->prev_seqno;
> 
> The loop only ever returns prev_seqno of a node, never the seqno of the
> node itself. So when all nodes except the head have signaled, the result
> is "head->seqno - 1", no matter whether the head has signaled or not.

Good point.

> 
> The sequence is therefore the same before and after the newest update
> finishes. A VMID which was flushed while that update was still pending
> already has flushed_updates equal to this value, so the job which waits
> for the update skips the flush and runs with stale TLB entries.
> 
> 
> I sent you an email with the subject "drm/amdgpu: track finished page table updates with a fence chain".
> The patch was verified overnight. Could you help review it?

Yeah that doesn't work either. There is no guarantee that the sequence numbers in the chain are contigious because of garbage collection.

That's why we have the prev_seqno approach in the first place.

I will fix the code to break on the first signaled one and send that patch out again.

Regards,
Christian.

> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Sunday, November 22, 2026 3:50 AM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; timur.kristof@gmail.com
> Cc: amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: switch vm->tlb_seq to dma_fence_chain handling
> 
> The vm->tlb_seq handling for per VMID based TLB invalidation was always rather fragile and relied on grabbing the dma_fence spinlock to make sure that callbacks executed in the right order.
> 
> Alan now pointed out that even this doesn't work correctly because different PTDE/PTE updates might use different locks and their signaling is not necessarily in the same order and on the same GPU.
> 
> Ditch the whole approach, instead use a dma_fence_chain to track all PDE/PTE updates and just iterate over them to get the last completed one when asked.
> Also make sure that PDE updates use the same path as PTE updates for consistency.
> 
> This not only fixes rare GPU page faults in the kernel queues but also potentially issues with the user queues should a PDE update make a TLB invalidation necessary.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reported-by: Li, Chong(Alan) <Chong.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 167 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  32 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   3 -
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  |   2 +-
>  5 files changed, 88 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 080d62246f5f1..5f223801abb89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -27,6 +27,7 @@
>   */
> 
>  #include <linux/dma-fence-array.h>
> +#include <linux/dma-fence-chain.h>
>  #include <linux/interval_tree_generic.h>  #include <linux/idr.h>  #include <linux/dma-buf.h> @@ -114,21 +115,6 @@ struct amdgpu_prt_cb {
>         struct dma_fence_cb cb;
>  };
> 
> -/**
> - * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
> - */
> -struct amdgpu_vm_tlb_seq_struct {
> -       /**
> -        * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
> -        */
> -       struct amdgpu_vm *vm;
> -
> -       /**
> -        * @cb: callback
> -        */
> -       struct dma_fence_cb cb;
> -};
> -
>  /**
>   * amdgpu_vm_assert_locked - check if VM is correctly locked
>   * @vm: the VM which schould be tested
> @@ -1022,6 +1008,65 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
>         return result;
>  }
> 
> +/**
> + * amdgpu_vm_tlb_seq - return tlb flush sequence number
> + * @vm: the amdgpu_vm structure to query
> + *
> + * Returns the tlb flush sequence number which indicates that the VM
> +TLBs needs
> + * to be invalidated whenever the sequence number change.
> + */
> +uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm) {
> +       struct dma_fence *last_seq_flush, *f;
> +       u64 tlb_seq = 0;
> +
> +       rcu_read_lock();
> +       last_seq_flush = dma_fence_get_rcu_safe(&vm->last_seq_flush);
> +       rcu_read_unlock();
> +
> +       dma_fence_chain_for_each(f, last_seq_flush)
> +               tlb_seq = to_dma_fence_chain(f)->prev_seqno;
> +       dma_fence_put(last_seq_flush);
> +       return tlb_seq;
> +}
> +
> +/**
> + * amdgpu_vm_tlb_flush - prepare TLB flush
> + *
> + * @params: parameters for update
> + * @chain: dma_fence_chain for the signaling callback
> + * @fence: input fence to sync TLB flush with
> + *
> + * Increments the tlb sequence to make sure that future CS execute a VM flush.
> + */
> +static void
> +amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
> +                   struct dma_fence_chain *chain,
> +                   struct dma_fence *fence)
> +{
> +       struct amdgpu_vm *vm = params->vm;
> +       struct dma_fence *prev;
> +
> +       ++vm->tlb_seq;
> +       prev = rcu_dereference_protected(vm->last_seq_flush,
> +                                        lockdep_is_held(&vm->eviction_lock));
> +       dma_fence_chain_init(chain, prev, dma_fence_get(fence), vm->tlb_seq);
> +       rcu_assign_pointer(vm->last_seq_flush, &chain->base);
> +
> +       /* Prepare a TLB flush fence to be attached to PTs */
> +       /* The check for need_tlb_fence should be dropped once we
> +        * sort out the issues with KIQ/MES TLB invalidation timeouts.
> +        */
> +       if (!params->unlocked && vm->need_tlb_fence) {
> +               amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
> +                                          &vm->last_tlb_inv);
> +
> +               /* Makes sure no PD/PT is freed before the flush */
> +               dma_resv_add_fence(vm->root.bo->tbo.base.resv,
> +                                  vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
> +       }
> +}
> +
>  /**
>   * amdgpu_vm_update_pdes - make sure that all directories are valid
>   *
> @@ -1039,6 +1084,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,  {
>         struct amdgpu_vm_update_params params;
>         struct amdgpu_vm_bo_base *entry, *tmp;
> +       struct dma_fence_chain *chain;
>         bool flush_tlb_needed = false;
>         int r, idx;
> 
> @@ -1050,11 +1096,21 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                 return -ENODEV;
> 
> +       chain = dma_fence_chain_alloc();
> +       if (!chain) {
> +               r = -ENOMEM;
> +               goto error_dev_exit;
> +       }
> +
>         memset(&params, 0, sizeof(params));
>         params.adev = adev;
>         params.vm = vm;
>         params.immediate = immediate;
> 
> +       r = amdgpu_vm_begin_critical(&params);
> +       if (r)
> +               goto error;
> +
>         r = vm->update_funcs->prepare(&params, NULL,
>                                       AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
>         if (r)
> @@ -1074,73 +1130,22 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>                 goto error;
> 
>         if (flush_tlb_needed)
> -               atomic64_inc(&vm->tlb_seq);
> +               amdgpu_vm_tlb_flush(&params, chain, vm->last_update);
> +       else
> +               dma_fence_chain_free(chain);
> 
>         list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
>                                  vm_status)
>                 amdgpu_vm_bo_idle(entry);
> 
>  error:
> +       amdgpu_vm_end_critical(&params);
> +
> +error_dev_exit:
>         drm_dev_exit(idx);
>         return r;
>  }
> 
> -/**
> - * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
> - * @fence: unused
> - * @cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM flush.
> - */
> -static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
> -                                struct dma_fence_cb *cb)
> -{
> -       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> -
> -       tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
> -       atomic64_inc(&tlb_cb->vm->tlb_seq);
> -       kfree(tlb_cb);
> -}
> -
> -/**
> - * amdgpu_vm_tlb_flush - prepare TLB flush
> - *
> - * @params: parameters for update
> - * @fence: input fence to sync TLB flush with
> - * @tlb_cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM flush.
> - */
> -static void
> -amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
> -                   struct dma_fence *fence,
> -                   struct amdgpu_vm_tlb_seq_struct *tlb_cb)
> -{
> -       struct amdgpu_vm *vm = params->vm;
> -
> -       tlb_cb->vm = vm;
> -       if (fence && !dma_fence_add_callback(fence, &tlb_cb->cb,
> -                                            amdgpu_vm_tlb_seq_cb)) {
> -               dma_fence_put(vm->last_seq_flush);
> -               vm->last_seq_flush = dma_fence_get(fence);
> -       } else {
> -               amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -       }
> -
> -       /* Prepare a TLB flush fence to be attached to PTs */
> -       /* The check for need_tlb_fence should be dropped once we
> -        * sort out the issues with KIQ/MES TLB invalidation timeouts.
> -        */
> -       if (!params->unlocked && vm->need_tlb_fence) {
> -               amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
> -                                          &vm->last_tlb_inv);
> -
> -               /* Makes sure no PD/PT is freed before the flush */
> -               dma_resv_add_fence(vm->root.bo->tbo.base.resv,
> -                                  vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
> -       }
> -}
> -
>  /**
>   * amdgpu_vm_update_range - update a range in the vm page table
>   *
> @@ -1173,16 +1178,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                            struct ttm_resource *res, dma_addr_t *pages_addr,
>                            struct dma_fence **fence)
>  {
> -       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>         struct amdgpu_vm_update_params params;
>         struct amdgpu_res_cursor cursor;
> +       struct dma_fence_chain *chain;
>         int r, idx;
> 
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                 return -ENODEV;
> 
> -       tlb_cb = kmalloc_obj(*tlb_cb);
> -       if (!tlb_cb) {
> +       chain = dma_fence_chain_alloc();
> +       if (!chain) {
>                 drm_dev_exit(idx);
>                 return -ENOMEM;
>         }
> @@ -1286,14 +1291,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                 goto error_free;
> 
>         if (params.needs_flush) {
> -               amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
> -               tlb_cb = NULL;
> +               amdgpu_vm_tlb_flush(&params, chain, *fence);
> +               chain = NULL;
>         }
> 
>         amdgpu_vm_pt_free_list(adev, &params);
> 
>  error_free:
> -       kfree(tlb_cb);
> +       dma_fence_chain_free(chain);
>         amdgpu_vm_end_critical(&params);
>         drm_dev_exit(idx);
>         return r;
> @@ -2679,7 +2684,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> 
>         vm->last_update = dma_fence_get_stub();
>         vm->last_unlocked = dma_fence_get_stub();
> -       vm->last_seq_flush = dma_fence_get_stub();
>         vm->last_tlb_inv = dma_fence_get_stub();
>         vm->generation = amdgpu_vm_generation(adev, NULL);
> 
> @@ -2857,7 +2861,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>         struct amdgpu_bo_va_mapping *mapping, *tmp;
>         bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>         struct amdgpu_bo *root;
> -       unsigned long flags;
>         int i;
> 
>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm); @@ -2870,10 +2873,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>                                       false, MAX_SCHEDULE_TIMEOUT);
>         dma_fence_wait(vm->last_unlocked, false);
>         dma_fence_put(vm->last_unlocked);
> -       dma_fence_wait(vm->last_seq_flush, false);
> -       /* Make sure that all fence callbacks have completed */
> -       dma_fence_lock_irqsave(vm->last_seq_flush, flags);
> -       dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
>         dma_fence_put(vm->last_seq_flush);
>         dma_fence_put(vm->last_tlb_inv);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f6285a9d9e989..452409e95a5ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -329,8 +329,8 @@ struct amdgpu_vm {
>         struct drm_sched_entity delayed;
> 
>         /* Last TLB seq/fence */
> -       atomic64_t              tlb_seq;
> -       struct dma_fence        *last_seq_flush;
> +       u64                     tlb_seq;
> +       struct dma_fence __rcu  *last_seq_flush;
>         atomic64_t              kfd_last_flushed_seq;
>         uint64_t                tlb_fence_context;
>         struct dma_fence        *last_tlb_inv;
> @@ -545,38 +545,12 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> 
>  bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> 
> -/**
> - * amdgpu_vm_tlb_seq - return tlb flush sequence number
> - * @vm: the amdgpu_vm structure to query
> - *
> - * Returns the tlb flush sequence number which indicates that the VM TLBs needs
> - * to be invalidated whenever the sequence number change.
> - */
> -static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm) -{
> -       unsigned long flags;
> -       spinlock_t *lock;
> -
> -       /*
> -        * Workaround to stop racing between the fence signaling and handling
> -        * the cb. The lock is static after initially setting it up, just make
> -        * sure that the dma_fence structure isn't freed up.
> -        */
> -       rcu_read_lock();
> -       lock = dma_fence_spinlock(vm->last_seq_flush);
> -       rcu_read_unlock();
> -
> -       spin_lock_irqsave(lock, flags);
> -       spin_unlock_irqrestore(lock, flags);
> -
> -       return atomic64_read(&vm->tlb_seq);
> -}
> -
>  void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>                                   unsigned int pasid,
>                                   uint64_t addr,
>                                   uint32_t status,
>                                   unsigned int vmhub);
> +uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm);
>  void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>                                 struct amdgpu_vm *vm,
>                                 struct dma_fence *dep,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index d03b9bbe20c7c..17a579dbf7b90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -122,8 +122,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,  {
>         struct amdgpu_device *adev = p->adev;
> 
> -       if (p->needs_flush)
> -               atomic64_inc(&p->vm->tlb_seq);
> +       *fence = dma_fence_get_stub();
> 
>         mb();
>         /* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index d3a5e8487419e..26af3d54895b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -117,9 +117,6 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>         WARN_ON(ib->length_dw == 0);
>         amdgpu_ring_pad_ib(ring, ib);
> 
> -       if (p->needs_flush)
> -               atomic64_inc(&p->vm->tlb_seq);
> -
>         WARN_ON(ib->length_dw > p->num_dw_left);
>         f = amdgpu_job_submit(p->job);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index 180e02de73e9b..06e0fe3ee18a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -112,7 +112,7 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>         spin_lock_init(&f->lock);
> 
>         dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> -                        vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
> +                        vm->tlb_fence_context, vm->tlb_seq);
> 
>         /* TODO: We probably need a separate wq here */
>         dma_fence_get(&f->base);
> --
> 2.43.0
> 

