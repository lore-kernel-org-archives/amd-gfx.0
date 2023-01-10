Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189DDC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC18910E10C;
	Tue, 10 Jan 2023 15:11:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31DC10E10C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZIQNU2Ah6CKKmypt7TL7awzUN9yQwqlxuMNuaqFWM0XeReWGxtIJ2geSDSNXFD4kM2HMZZ9Yr+P6Mr+AG7b1EbhLABAi0RJJEoF6XWWhPWEwNgvO3TO2twesfNfGFwqa6NctThPp5aRDqWZSWWbNrQ133z3XwM3PWWQ9dUUVbySFq88u8Y9ehQwNAtBG40A60wXSnkPShTjNbfJAD1fxx2GPFkICmQ3tkqCoVTj46q5cc7diq29Z29EYZEoh++5gxrthF1DfThdxzDf0CO3Q1Rd6Ed8ulRbosD2bLJLWXd9x4U5J4Aq2KFA5SjiT+VTnDkw62qtytoQbI+UhTrIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUS9uytytS7wcbjRUhD7vIQPpBThu/2jvBV5XEnzO+I=;
 b=izRpYOEo7ufRJA9yTwRKcCONl/l4w7G4fatRl15ZnobEpvI19yWJghzofhT4kMgOWpqdXE5VBBaZFJk9R9pZO+SrVdnTRV4nU8bEIN7ZdUvrSVWdelJw5Q2inCxvpRel3KVR6tVZ2agZ+liYQJWmJy9rFrzaeZgdaagONC4t2aWQBjNxCHEr2wz4SmmF6dJpFxgbxpp/nXhUQ54CSVYb2lK4VVYFO3+R3NvAAInjF7x1raTzPTSnyUIOEhIqojZTTrqem8kmVlG0hk1YmEsRNw5ikD25rDkeUb9LsR0uvGO5HuR0scc6Tcy65xMlvuzB8lICMzokGmucIWNUutZ9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUS9uytytS7wcbjRUhD7vIQPpBThu/2jvBV5XEnzO+I=;
 b=mjB7sdNvjOUdctc0yFTW3nekGmhwxkft/QImGbu9UYFg/YBFsrF+HRYJWlGIwVQzCuCZTYfYYrGNhrOl1HTvUT4+f6ex/1a/YDU3sJNZ8GxuXzYtlnVzV51tLH394Wn7q1CmZCJgJjUPklX7UEBCaFPsL4Zd1ygI5ZY61T49zqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:11:28 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7c46:795:d6a3:69]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7c46:795:d6a3:69%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:11:28 +0000
Message-ID: <80455b61-1e63-8c76-36f5-977bb0a26e71@amd.com>
Date: Tue, 10 Jan 2023 10:11:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU
To: amd-gfx@lists.freedesktop.org
References: <20230105192825.138353-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20230105192825.138353-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:52::24) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: f6de6285-b180-4125-a6ab-08daf31cf27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPKMzRkL3Z13wgY9/yk+2eFPeBudt1epOTmwpTAqil6cTejAolSnOvBfY0xMm8W987tPTZ7oOLQJJyENxjLoxm6kzIdT8Ar22+Ki0bXx8EhjcAAFxPMD+ZCW9KYIZOYg0l/aqI44TfySh4d8nZlssLWCgbH7zx/loZNL+95tZlET2a4OlC5kJvd+VJYY4env0I4wbueizodyBn2rh9de2PoICRSntI7oWfeQW7ARAUIwuLXM8BuRcELYq6MKrv+dQd3Te6QOyi+A4ZcEUltkrSe13UrZxogdRzD/Pk/oj59bz6Ep5FtFCM4xzHzsAGiaMXn8zLaO5K5LuRDdlHHP/prxuLP0wfVyEyvHSu3zUM6aD6E19BzNnyC2GVVdB0hTIzM/MkBm8mPshgypyR4ovVXZ9TLlk4HzrlQWrxg9+8QEU5LX2YnjMX2HoO33idz06fB2fzq6mx/m/uQePR4DBn36aIgZsWAi1qINKkQ9AJyYUPgxK5N0bXLFQcf1A6WS4i7Flm2UUaoF8VS63D229xZfSFdJYXt3s4DaHEcboLZos2sBEWLaSkGy0Ut1bba+vIK49CS7VqJqFELaS5LK/fF59RW/Hxbl65kw2fkLDgISufTjFTg6t1VclbPrJziv0X8rcXAPXzyaLOC4/zZjBDoB2XIsTb8zYe06UMk/R4RpYnXEDHIXhEgm+c3RckWU3BHwcaliZ1kDa48Y9yPpPGWapf5w6Wv62mOt1JzRTFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(53546011)(2906002)(6506007)(6486002)(26005)(478600001)(186003)(6512007)(6666004)(31686004)(316002)(6916009)(4326008)(36756003)(8676002)(66476007)(66556008)(66946007)(2616005)(41300700001)(5660300002)(38100700002)(83380400001)(8936002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFpbnA2cnd5YlZSRXN1ZDNSRWVOcm4vMTg1ZGxwcnlHM21yZUt2VW9PQThD?=
 =?utf-8?B?VzBTTmk5eGZvb1VIZnltQ1gvTHE3TUQvZkJjWXUxelBPUjE3cnl3aXZmRmQv?=
 =?utf-8?B?Tnd2UDQzNmk0V3FkblpEZUEvem0xRWdJZ1FlMXZNUGxkZ2FyamprWXBGaGFu?=
 =?utf-8?B?Vm9PdnFXZTZEWHpycEQ1bzAweGpVWVJQWHY0RzArckJIYlIxUEVDdVMrckFh?=
 =?utf-8?B?N1FWOTlyQ0lrK2NQTGxkM3B2QUxvNnFna3pUcExXaFRveXNnY1FMak1zTGZx?=
 =?utf-8?B?YU42S3gyTmNpaEVERDBLOFJlYXVoWmRVeFNjNHI2QU5Yc2Z1RW4vZ0JGYzJV?=
 =?utf-8?B?ZGZ2cGRwUDNISnZ4WGtqYUlicGxHQlEwcm1yU2wvbldKc1Y3YWUwQW9rK0N6?=
 =?utf-8?B?cVUvRG9UY2pCOUxKcCtpdEJGUmZwem9FWk5abjB0cmtQVVZzbGFQSEs0cTFP?=
 =?utf-8?B?Um92dnB1QWkwdnZQbjFLZ3VnZ25JQi82Ynp0R1FzMTRic2JwUVpvdHFHZDFz?=
 =?utf-8?B?N0FCTmg5b2d5SlV2RnlDTXJmZTB3MnhYSTJrK29WdU5RYTl1V1FpSmZrTFZL?=
 =?utf-8?B?THBDNEZyVElrUU1NMllLcG5veTRuV1N6Yy9ZK1h5TkZwV210bisveWMyWkRz?=
 =?utf-8?B?eGg0R0pUUkdKNXhsaDRIcW9tVXI5Q3BsSVRWM2Mxb1FXTUxuK2RSY2ZjZ3VO?=
 =?utf-8?B?VzU1S2M3d2hDeExsRzhSc1dFSmJxZWdDcm5ZemtjUHpxSUdNUHl4REhWTzN2?=
 =?utf-8?B?NXYvRXp3aHFpaWJlYUJTREY0K2lDOXJodXgrWTR0M0lEci9BdmZPc2R6WTlF?=
 =?utf-8?B?SVplWkdWZGhDYzVQa2w0OHJYeGVpemF6cU5YVDZJRngrVHFaK2JlaUwycUQr?=
 =?utf-8?B?bGNYd0dyT0c0bmZ5ekZGRFZEY3lkOVNIQkxaS3BWeGVsSnY0OElZS0VHNkVX?=
 =?utf-8?B?S09NQVZqa3ZucDdXYjA2aE1GV2hicDY3YUlnZ2F6Q1lseTQ1YzE3OEwvSFBi?=
 =?utf-8?B?Ukc2VVMrdmZSWnFGZVNWQm8wdDk2ai9QMDRwRGR4VzM5aUZ2aTVWUUFrZ1FO?=
 =?utf-8?B?U28xZnYrV2kweUtqMkxJK3RUaWlabUdIaE1zSXZwZjF4M0l4UzFKV1RXNC9P?=
 =?utf-8?B?TWpJNWdOazR6bUdiWEZtOXh0L3d3MldKZWNKUHk2U0d5dUVvQmdHOWxnckJ3?=
 =?utf-8?B?QklER2gvSlpRYUl0ZmREam5OZ2FnMGYwNmJ5bUYzeGNyTFZTSDRvWUJHdW9p?=
 =?utf-8?B?dnU2Q3BCUytyWEs2ZTU2M3VSV1JVOWVKYU1CMzliNzF2TEowYUc3UzBTSEQ3?=
 =?utf-8?B?ZXV2d1l2Sy9YZENxbmZSeWFvQVhJVUl2MkxhaFFEbGtiUEIwWE90eHRSVFNV?=
 =?utf-8?B?d3lqZGl4OW9HRWRCbGpCNUZmSW9jN1Z3cXV1VGFhQXpMQzJtSk55YUo3Zk5T?=
 =?utf-8?B?T2M0UDdzYUNqVDNSYndUeVJOQnRJWEQvdGpKZjVsNktvVGlrbEgwelB6elkr?=
 =?utf-8?B?MTBUZC9aSmJJeW4yZzFGV3BMNERvRStnTWFZMWh3Rll2NE5yM0lwaDlRSzNw?=
 =?utf-8?B?OU9qakt5V2t1dExJUFdac3JJQ2lCTEk0WFpjVE84a0VIZEtBQ1BCY1BMOUNR?=
 =?utf-8?B?VFpCN0M1TWxFblFGd0tyai9tRk9sZHBSeXduODBUcTR0ejB5S3ZSa1VkMjZr?=
 =?utf-8?B?TnlmKzdHWDRYN2RsTG1lcW15M1NkTC9zQXlmeFYzV3J3bTkxSjhUZGdQUWFW?=
 =?utf-8?B?TTFVWHhFenp2WTNjdnYvdTFZdDlud1UvQ2V6U25wZEh0OUUzdEo3S2cxb2lK?=
 =?utf-8?B?MCtaUlpNZDRyZ1RUZG1KV25MYWQ0emFheFJ5RStjYTdvY2pDM1RHQUJ4ZHU4?=
 =?utf-8?B?dUo3VTc5RUJuYWo1c1A0aS9qbE52RkxJOVFTTWM1WUx4V2wwc2h0cTh4aW5x?=
 =?utf-8?B?ekhGVjBWc083QmtzRy9rVUhCbGpIekhCbWpMVUdCNUU0eldYWm9BSjAwTExq?=
 =?utf-8?B?azlBdThIeU5MU05UbWo4WXNqcHRPTnJmRDJyTzBFTnJvdHNSQSt1c0sra2Qv?=
 =?utf-8?B?ZXpEb3gwVHRDdTFXY3U5T3dBenBVdlAya1BoWlJEdVpZYllkVzdwNjhiTUJX?=
 =?utf-8?Q?9AY0D6oMT+G4TX4YC/5Gl7RAi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6de6285-b180-4125-a6ab-08daf31cf27c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:11:28.2047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJlNZKDCc6tYRzsIbMrfMTptDMG3egl9yLph2y/nmI/0HCi+s9O359fXJIr1rcY60jju3bK79oolnPQc/RZrUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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
Cc: Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping.

On 2023-01-05 14:28, Eric Huang wrote:
> The point bo->kfd_bo is NULL for queue's write pointer BO
> when creating queue on mGPU. To avoid using the pointer
> fixes the error.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 9885735f1a30..d4c29e9edf34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2179,7 +2179,7 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_b
>   	}
>   
>   	amdgpu_amdkfd_remove_eviction_fence(
> -		bo, bo->kfd_bo->process_info->eviction_fence);
> +		bo, bo->vm_bo->vm->process_info->eviction_fence);
>   
>   	amdgpu_bo_unreserve(bo);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6013f498ea1e..55c2dc48e567 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -231,7 +231,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>   
>   	if (q->wptr_bo) {
> -		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
> +		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
>   		queue_input.wptr_mc_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
>   	}
>   

