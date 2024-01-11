Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8EEC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 16:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A9510E6CD;
	Thu, 11 Jan 2024 16:19:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0327D10E6CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 16:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjqlSr5oBSsXHarP90vsDMmdQuYAe1OqG0ybBhdD9dwcV45i4ysCuqkajNnPirlpym9qFOGIyKXHZvmiGAOdBl0dka7DAkaPaJMmRw+ggAWThk4Te8mxvu0/Ewo6KM6ZQrgcNL9KG2a/1ILAEL1/o/0bmCtcwQCx6/lQWAmSXFdREEra1YQD3/7aeaglyF5oYk8carLEbkthcpkTzbI/a4zDiKQmgFTOO0xpDk3lS/bjtj3bbjiFG6cMZy3GylQQPJ22FhSjBTFOGw8+cgJa5OspY3Hnzpd6tNrt8t665L1Q96tjyzdTp4MNKBtuaK0Aw4W6ky90JqCImfjxJBJfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX0iUUp7NvCDbTDImssptE1p9sTJMWDGIyLQNMmhOpo=;
 b=i85HLLvdEUxpDB765vjI6SXTRwhPf+hNCZIbotj7jJOHYymL+CZvGCbf0FKYtw7bnmoIFL6WyZ8g1iy6Yr4gIr4tL3Ut84IiCTGzJH2KcmIf0QAqKpk9OJa3gwZDuGi5LFpPluJC4WDkh55bzgYNPR/vPgjeN6bspAeaBeASJRAU44JZ0Bsa2Bm23/DgrfZQDuVkPp6RA7vBr68sFZAtVbHfEZq/Nr8ER0cSUQpFVTYxfkcHJiiBVlnU2iVQ+N7JATm4g9Tth4zlJZvD9e42YNek+4ALkPYrOHL+G8rFywvqIhCflNGg69durV9DYQ9aYlYRzkZ+CkuSizXC3L/+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX0iUUp7NvCDbTDImssptE1p9sTJMWDGIyLQNMmhOpo=;
 b=HJiDWCAW2p+MdjYyebRBaLnhNvj7Y5opVEqzXwC9BnKKzcKLMe81edgTqULY3Q6HLsznnTMoWn3ldfO93Drl7ElmCBe4Bc6QQv051sJDO3aKTPxfv4tCriRowuKjp+wrlCOgW4KTCOxEZG0Nc19iVRt6SkTYxz4iWBQbX6Dv1qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 16:19:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 16:19:25 +0000
Message-ID: <d111de60-8bc9-4fd8-aca7-6c539362d9d9@amd.com>
Date: Thu, 11 Jan 2024 11:19:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: reserve the BO before validating it
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org,
 David Francis <David.Francis@amd.com>
References: <20240111072221.90774-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240111072221.90774-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d6261d-d5c8-4971-6f23-08dc12c1143b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88Pg8VMJbioLNIAeVQjc3XfuRCGPTWNipu3vFKnjJ1RZip22HdqiHfGubfWKhUy1FXThN85x1HPRKoO3IwPlXwYY8HW6aLyneTSwkpKzse0p4/jacwqXFczlfG0AiIev5AgsnIwMmAVQm2YUizVkoiPCaico9x+1jljNijyvb2g1kDVhGh7uzaR9Q5PRZUi+/mDjLlikiGXIjJfVoCUJ5Hjz232smu006U7H802UxHKLZCketWX1t5XKf+SX0OK6iuoacmtNG4lByWQqdaEUy8HqjcrDYJBxd5g35XGBcTxaO4F04VHL6gdy6TguVbwg7/Siji7uvM+ks34nsCKfvboV//HvxsFBOJHNIBIkNxNHOG9jU5ChFd7P58kKtmVKpWZfqm5hfDg9qFh6glT2sL1fYflzrR6MYyr+NmuWxMSnjawBRjsmeTZ17QX4kmW1XqlNBnxm/uCTOjTlXRg+5wBFEbsf/gORWR2U2SgoL/SlhHQFTRgenWnM4FVXgc1kU3rUrWHiC16I7li+EfTiJugE8aFxRKQKPEd+ZB+fk5QshvPZSGz2+n+7cBdm6XgnQ2FZheroHGv1/nf5nSS4goAjE1RKse0+dQKrE16tWi/4ZFENpprIE4LHVYNzX70DGd0Z3pi03qLrP3DIWAkWHIhfryb+5UPWBe9BqwihIDT266AQ6jJKBxhU7QQHQDgA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(110136005)(5660300002)(2906002)(36756003)(31696002)(86362001)(41300700001)(36916002)(38100700002)(316002)(66556008)(66476007)(66946007)(6486002)(2616005)(53546011)(6636002)(966005)(478600001)(8936002)(6506007)(6512007)(4326008)(44832011)(8676002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXNYbXRVLy8vWFROVXJaMDZhSjRrVG03UjEybHpyRHI1VGhqZUszNEg0c3hE?=
 =?utf-8?B?ZXBqWjVIekZGODZ0TVdUVUF0TGsyaDYxRisrTXN6SXlDVEJyektjM250TG16?=
 =?utf-8?B?cFc4RjJzMkw3anV5V0tsRUhDNmx5UklWQk04TXJTMHlaemtUbXBWc20yRjRZ?=
 =?utf-8?B?ZWYzblZLcjQzUi9vNjZUa1JJZWNrL2RFb1Y3bmtuWi9iNk5JRzFJM0FuTS9B?=
 =?utf-8?B?dXNqVW80bDZzcUpqWUZVWGdjT3VYWXRFbDUrdWVHRjBGMHlqVkZabjBVWHFF?=
 =?utf-8?B?ZVhPbkdSRkp5enl6d3RCUisxMmI3bFo5QXdrWStmZTZjaXlDdUxKLzE5d1Ew?=
 =?utf-8?B?K2VKell2WkVnNlQyOXlqT3Z1V0F3aXhrTzJuTW5USmppVXA0dG91c3oyYkM4?=
 =?utf-8?B?RG9qQlM3a3lKeEg4ZzhMdHJuYVBHWHIwN1VVajg2ZytQbi9MYUQybUdHbUx5?=
 =?utf-8?B?SDNoelIyRzJPbHViRlBSdEVjZUhiZWRPV1FTTW1NME04OC9PUklhbExhS2l6?=
 =?utf-8?B?cVN0V3Y4QlR0UG5HZ05JV3lHWVFNNmh1dGFuMjRXSVZvbU1adjlRd3htY1Uz?=
 =?utf-8?B?cmV2RW9mRGRuZ1cySkYxTEpGbUFESFdwMm85dUdIVVJYLytpWnhSeG9yOXI3?=
 =?utf-8?B?T0pRQ1h1YU5VT1FPbTh1ZnloaHdMODRqbWR0TnhCUVdkUWdjVHhsZmRURjZH?=
 =?utf-8?B?Z3puenhzcUJUNmpqVTQ5UCtqNDBtQkcrT0c1eFpYMUZVeUYrMG4xSnZkd0xY?=
 =?utf-8?B?KzVNTmJlQk9MSjA4cmRzYjduR055ZDZCRDY5ZEE1OWJKRUZnbTZ2RW12VlhM?=
 =?utf-8?B?MlE5ellJT0V1RmpHdmxjTWtqY010b3lSS3BXelBFSGY3MFFKTUVta1hNZm1k?=
 =?utf-8?B?RkVFMWZPdUxIOGdOMUsxUHFhN2FkbUVMdE1CSmdmd0tXUWlxZm5mUlNnNVZS?=
 =?utf-8?B?SmlhM0dZdWNXNHBTNFVVVkUxRklVNlJ4VXF5V2FVQUU4K2JIR3JGLzhUUWFn?=
 =?utf-8?B?czJJRzhWWjFXRkZRMFhtUVRhQ2tFUmUzdStkeWZsZGYrd1JyNSs1VjVFS1VK?=
 =?utf-8?B?SEpDVWxNZ3BnYjNlWmUrUkNoYUUwb1hQN3BQK0ZCUUxHWFZZeFY1bVBGM0lr?=
 =?utf-8?B?UGlkdWgvTWo5cFlhdWdCWVdtdDQrMWU0MU1NdnlOa2V2ZThtWUlJVjZDM2Yr?=
 =?utf-8?B?SzZkbDNkd2J4WnNaSmZjakVXMmdPOXp4cnhVSTRxL3NMR3RHenh5N01hbE5N?=
 =?utf-8?B?QTJSa0RWek82R0FrSUlBMGI2TWw0ZkJleTJnMVFsSXY1MHFrWFFZa3FjdUY0?=
 =?utf-8?B?Sk4waGFDL3M2enFLUTZwU0ZXRTVieU83ajRhYzYwQ2VnQUVtbXplUU81dU9x?=
 =?utf-8?B?ckNCTy9aVmdpSGNhenU1N0M3L3lLSlpUblRzWlpJbGpCNFBsYVhwSlRIWE1r?=
 =?utf-8?B?NisxRHl5MmtoQnlnMzd0aWRRQklxdEJ2REh1WHNpSFN1bmF4SnI0OENTMFZT?=
 =?utf-8?B?dGREdVJwd21wVG5Cd2ZKSG9HQXJQZkx2QjFZVUJzcWQ5Ym5HeUlEcTZHRzVU?=
 =?utf-8?B?RGR0T0pFb2x5L2xlaEQ1b1RqM2tXTVpXRjUyaGhxSU1HZERQQlpBeElObGdt?=
 =?utf-8?B?cndaZTFUUHVpa3dYMnhzQUV6RWJOazJPQWpwMEFscVRSRDFDUkxiQWI4OXRk?=
 =?utf-8?B?WkhjamJOM2UzL2tqZy9Gci8xcjh5VnFSeUxSc3YrQmN0V1pJRGtxZ3o4Umkr?=
 =?utf-8?B?bFY3STJKZmtkVmg0RjRMbWhmOE1aMWJINXNQYTFNUWJjenliRzlFNUtJQzNm?=
 =?utf-8?B?V1JCLzE4aTNQVGJsdXJadU1mREdGYi8xUXlUQXc0dld2MUVPTWdCWXZNTEdQ?=
 =?utf-8?B?ZUF4VXM2Q0dBK0l2dE1LNllOalJsUGVOWXdRT0FqN3FUQTdoWnJ1QlZQUWNr?=
 =?utf-8?B?Ykk2bldJcmpkcGxudDE1bWRDNVQxNllFZ2owdHFDaGRZK1JXdEcyNHhHcnRt?=
 =?utf-8?B?clR2d2lzVTBPTDZlOWNldnV3QktNb3pxc2FIS3JYeTcyeGM4ZGlWcUk4RzJF?=
 =?utf-8?B?elg5SG1tTnFUL0hWcGNrbFJ0VnErdnZYeG1sSjBpWjV0TjRXVXBUNTkzNk51?=
 =?utf-8?Q?nUhupbH0RQ1yT17mnPi6FMsiY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d6261d-d5c8-4971-6f23-08dc12c1143b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:19:25.8629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs1+SPGe5BAJPPC4EUSR/n40rZm1oUAifmP34WFmeZCZtLgDzqp05Yag6I5n7VHm8rD3esClW5dmuOpfJB+MOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-11 02:22, Lang Yu wrote:
> Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")
>
> [   41.708711] WARNING: CPU: 0 PID: 1463 at drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.708989] Call Trace:
> [   41.708992]  <TASK>
> [   41.708996]  ? show_regs+0x6c/0x80
> [   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.709008]  ? __warn+0x93/0x190
> [   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.709024]  ? report_bug+0x1f9/0x210
> [   41.709035]  ? handle_bug+0x46/0x80
> [   41.709041]  ? exc_invalid_op+0x1d/0x80
> [   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
> [   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
> [   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
> [   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
> [   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
> [   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80 [amdgpu]
> [   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
> [   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
> [   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10 [amdgpu]
> [   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
> [   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
> [   41.709959]  __x64_sys_ioctl+0x9c/0xd0
> [   41.709967]  do_syscall_64+0x3f/0x90
> [   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 48697b789342..f5542a4ab8ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2095,8 +2095,13 @@ void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
>   	mutex_lock(&mem->lock);
>   
>   	list_for_each_entry(entry, &mem->attachments, list) {
> -		if (entry->bo_va->base.vm == vm)
> +		if (entry->bo_va->base.vm != vm)
> +			continue;
> +
> +		if (!WARN_ON(amdgpu_bo_reserve(entry->bo_va->base.bo, true))) {
>   			kfd_mem_dmaunmap_attachment(mem, entry);
> +			amdgpu_bo_unreserve(entry->bo_va->base.bo);
> +		}

I'm pretty sure someone else worked on a fix for this before. This is 
not a good solution. We need to handle failed reservations (due to 
ERESTARTSYS) and make sure that the unmap ioctl can be restarted 
correctly in that case.

See 
https://lore.kernel.org/amd-gfx/530aac57-5561-4d1d-879a-93b108e5c8c2@gmail.com/

David, do you have any update on this work?

Regards,
   Felix


>   	}
>   
>   	mutex_unlock(&mem->lock);
