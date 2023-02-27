Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8335C6FA8E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 03:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540C010E083;
	Mon, 27 Feb 2023 03:22:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81A110E083
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 03:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQa/owo8mG9CTNl+CGEMWxhGTrXxfL7+uZOA2O5Q9oIN7uWerbusxrRa3Kqj4D/4Jd3/QYFy3Cg8BN0rHML4x4sF/I4yqvVjDp4+PlsuqsOuqe7Ulu+P0TjV14jaT21vFsYRTrmGGWmWlBpmVpYb4SmFjb4NoQtBsP+9HuZWXjzkHAbCHRsXkvfHNY1vzF0nuHRdEtcU2b/b3q6jBYajXsJVUAUPLqFey1+J8pcIX4Kkqm4LHdJ9bql2Jlf1NBigDolsWZGdao8BPP//eslhuwmLVPhq+P4GrOLdScBKPG8xs1z4gWFdhI45sJ41vWNJGwn2xRLcurduyZnQHhr1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akM74lR9ABUkni+94OYJb0wLNIc0Q6mMsP3wANeKz9k=;
 b=cOe/D1/Xlsofgy1H9GLrs3KnmNSdMAJBV4mFzY3vMtemvsS8HO/P/LKPhBbpS3de0ctyACA6A9xwNN/tX2BO1ZkTBmglNX0Lm33qxZJdUAnZaqvLwN1kZTz2OcNGLZUEaAqBkesjTLzmGrTwTeexr5LgrHl33EJsmGRLFLTiuhx4oUAznhPEu4nIGMNihz1opHU6Yr0CvpgvWfU4I8j9BPq9BrNqsCIci/obp3TmpVZ4Q/Qpv+FgJNRt85fYyamvKWcrmnme3OgjgNblT49Dr/9iTByYTQnXrNgPYUxr762hSiQIZefWWFac954bAL9jOFKhPAZ4vrh3nJV6U+7/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akM74lR9ABUkni+94OYJb0wLNIc0Q6mMsP3wANeKz9k=;
 b=5WN16aTIzn7Fvttr8iZ6EIVM5q6FNLmcZnJIDq39X5c8z15sKTqtsa6Ce72z3jbWdWzuumyOOIcFlPcfZDnmJe84OYV0iSlgWAWguLYpwkZirZZsC58Vu2ic/uxAfJ/2rbGCO743txX3cCQgKhbDlNqZGDNUq5r7HRzmbCGHdL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 03:22:17 +0000
Received: from BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::1db9:c8c1:da8d:904]) by BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::1db9:c8c1:da8d:904%7]) with mapi id 15.20.6134.024; Mon, 27 Feb 2023
 03:22:17 +0000
Message-ID: <6f623daa-6d93-f868-efd9-611635717c26@amd.com>
Date: Sun, 26 Feb 2023 21:22:12 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] drm/amdgpu: Synchronize after mapping into a compute
 VM
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230224233647.847647-1-Felix.Kuehling@amd.com>
 <20230224233647.847647-2-Felix.Kuehling@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20230224233647.847647-2-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:610:b0::34) To BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:69::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a3799a-6d02-4704-a6ea-08db1871d3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gv/y1sUjwo5qWwP9+tw+HCQdLjuB34TPzfcwrUmLoOpM8U9kGSEpb0eU6LGsKWSKMHQyyijb7iiioDb93M+ehcB+qd8d/eoJJ7meThebXhroOjG5OOuUv47F35wVxafEHjygVxA8dGE92lGO8trd/xWwdzwSulvpMk2UXm3YqLvz99R3mhfTGChd38o7ouGM8bOx/21n4akSkmzKx43aaNdsNrgQr4mVlf6rtnq+OCyzagOe43F7wGt/0iyVBnVGolwjrnxE0BmJ6ynHxEhCCXdtn7R02f8YBnVChaThVbq8wpW5WVnz/7rPbW4nOG6wQ1fcszAcWJu03fUH7yfsVSoOIVmPqW0Sm2OsycTDtLmVBd9+eGN0OUArMDZ/yCCDlUNkHZz5Kqj0LLhk+RwfY+pMMuGBQDmMqT24eXano7bGnP9qWJ7NhwHHl5ljDf2Un+TEywjuAIIciDZd8jhU7HUdwHdYSaGXzC4QoyeDJyBU4YoazgrXg/zvAx8HOBI+2RyeAq/+9wvjOHbE7I8jMx6LZW0kJOTG4lneJ09l3jbS/gGO88+wr+HAyLpQd+zy3nOMjmSt+bm3sMSf2MJKUT7VudOkxkNhXDhIFcsomo3fW0NKMa3lARZ/fQhZUUGPC7KaJ/Wc9jJMXInB3Z+J8DdLXqAkuLx5mIWvd7fmD1cRBAeMHVvakXjVpFXOwQKP6av1d6gsRTFt/NLfWK4n5kArXWaf4lieOttZEV5wXvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(6512007)(38100700002)(41300700001)(66946007)(8676002)(66556008)(8936002)(2906002)(4326008)(5660300002)(478600001)(53546011)(2616005)(6506007)(6666004)(66476007)(186003)(26005)(316002)(83380400001)(36756003)(31696002)(86362001)(31686004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akw3N0NuRlcyVFY0SkhoU3JvQ0RGS2szUGUzUUpaRDFDelQxQy9adVEvNWVa?=
 =?utf-8?B?YklIMDdkWFdLWk9kN2kvOFVJcEV2bXg1bGIybEMzaWVyZE5mQVE0N3B2Qm96?=
 =?utf-8?B?QXdYL0xHSGU2R3M1RFlSVkJOOVI4M2hPVmFkR3k0R0ZqTlpZS1FhaTNpRjlZ?=
 =?utf-8?B?MFZBa1dQU3lhd0RlUEZGemx6TjdEcFFMenJvcTc2a01IZk1NZGZoNkpTK0JE?=
 =?utf-8?B?VVkwWkltaWttK0g1YUYzbzNOK1FYWWZpNjUxRU1ydnVFQmVhNlFKZmVwL214?=
 =?utf-8?B?ekoyQmdKOWhYYlh4Ti8xb3pPSzlIaFNzSndreHRicnJKTHM1UXZ0a2Jobkx0?=
 =?utf-8?B?NFJ3RjVuWEhBK2FPMlZ5MzZFZ1RJMUZNL2diWWt3RjFWNDR2SE5yQUVIWnN0?=
 =?utf-8?B?OGN2bkt3MVZjbUdQNVg5eDF0eUVTd2x6ZmlBTWl5N1ZUaGtSWklMUUpjVjE1?=
 =?utf-8?B?Uk9HUHJkM2hhd1p3WU1nZjc5T08xVlBzOElCUGdrYWw4bkQ5clRJN1BsZzJy?=
 =?utf-8?B?Nk1TM2twNmx4Wml6djB4SG41QnpGbFlKcjZPQU82YmkxajJ1ajl2QXRPb1cx?=
 =?utf-8?B?b21FWkY3UE15VHIzMjZnWmY4KzZNN3FBMjZxdmxrT2VwWG9TeFZScUJNL2FP?=
 =?utf-8?B?TnovT0FjVUJNT2hoNkxaNG9sZTFYbmtEUU1pQWs3blpHV2p0TXJZdkEySVQ0?=
 =?utf-8?B?MnhtaVVIZGx6TVJOSVRjaFlYSjRqQkp2dGV0ZGFJUkRwZEMwdzhoWk5TZXFm?=
 =?utf-8?B?aThpM0V0eld6bktLbTU3NnMrd3doRFptajVScm9PN1NYbzRrczVET1VQQmJn?=
 =?utf-8?B?dS9uSExMK3JEWjNUQWNtbTUyYklKWFdKc0IvN3crWXBhSTdLSzdQeHMyc2hu?=
 =?utf-8?B?OFVBb2RVK1ppdVBCbUdZd2FRb0diY2tqSmthdHc3YTRwMzFTcVdyVm1qQ1Y1?=
 =?utf-8?B?Mk1SUk4xTlZGTDN3MjFaZmtpb1hkbzNBWWs4MTBaaVlpU2xLSVdnMEFIRjF6?=
 =?utf-8?B?NUczMEhQS05LRWFKeVp4czRyRExhV2xGMzRQYzRzVUdnZWVpR0F0c2h2cGdJ?=
 =?utf-8?B?UytuVXN4Tlg4M2V1eDl6N0tadkNnVVdsaUlLbFlJbDZCeDZmVTR1MlkvenN5?=
 =?utf-8?B?R0puKy9NeWdSYU9MV05ybllFMUh1d0pmbHJIb25qRGIvOHBQVHRoT2RuTHpF?=
 =?utf-8?B?NjA2UVdYOTdGOGVUUzBuemloZTZwNzZZdVhzcmJWb2JhaVNWbVNGaHFOZ1RO?=
 =?utf-8?B?OVFMN2UzVVBSSzFOcUxsdXg0elVnRU01SnFkeXNzU25IdHNnNEkwanFrWVVQ?=
 =?utf-8?B?YnpaTEY0TnJ6KzJPVHZpYVhzUGxITUh5UG9DNzRaNkJBN3lJLzVQTHBFeTBG?=
 =?utf-8?B?NDBaaHpBQ0RQMW9Lekg4YndET1lUMnJpYWYyRmF0c0U3bTJsMER5aXM4VGtI?=
 =?utf-8?B?MGQ2Y1dreVZvUUhrL1pYMzk5aDBCUkdrbkxoTWZhSkVJRlU0ektXTnZVeThE?=
 =?utf-8?B?cXRlbThGYnZ0K1JRMThlT1NGUVRpZ2w5b2ZyMjRSVDlLTjlnanlxSzJ0Mjhk?=
 =?utf-8?B?QldFZDI3RWNCZ24rRVpTZTNJdHNhRWVBcVk0MWRTN0grRStJaEsvMDZjTGVw?=
 =?utf-8?B?TTRTeDhmZUxVM1FGZXdHY3dpcEtBV2JlMDd2endNenoyeW5iUTcxa3NDUnBy?=
 =?utf-8?B?T3FJeTZiQVYwVXM5dkxOcm5UT3l6aWFsTzFweEdreUpBQ3J0WkZjZzUzUG1O?=
 =?utf-8?B?RWhRZStwVE82QVFEajNuMERUa3g4M3NXaWo3YjRjNjdGSWcwRjdrcmtOeDZZ?=
 =?utf-8?B?c2hmdXBlTyszQ2R0WExGUmF3bEh5Q0IxZUZaSktlbHA5dm14ellQLzJWdWV1?=
 =?utf-8?B?aXZMZld0TVJEd3FEN25DbnRNMGVVWTl3R2hIeUhBckFNQnN6V3dLblVBZ3Iw?=
 =?utf-8?B?T2I3QnhyOUFLR1lqUnNxWXp2bEtuMHp1WEJiVUtMazB0SHBnMlJUQmRHNlEw?=
 =?utf-8?B?Qk55c3ZSN0FHMjRVbnNIVmFtaUxpanliQytXSkhIb2tVVG41S2ZUVDFxK3lh?=
 =?utf-8?B?dFo3VmNPV1R3dGkvd3hGRTdOMnJxWXRhZlJ4QmNkdWJVN2xIeEJ0UWYzWDR1?=
 =?utf-8?Q?m9ag=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a3799a-6d02-4704-a6ea-08db1871d3c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 03:22:16.8233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3s36DBSanWw1A5UYBushMib4Grfcg2xUGP2AXaOxCwUhNpe2djPjOlUleqXvGcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/24/2023 5:36 PM, Felix Kuehling wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Compute VMs use user mode queues for command submission. They cannot use
> a CS ioctl to synchronize with pending PTE updates and flush TLBs. Do
> this synchronization in amdgpu_gem_va_ioctl for compute VMs.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6936cd63df42..7de5057c40ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -601,7 +601,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>   static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>                                      struct amdgpu_vm *vm,
>                                      struct amdgpu_bo_va *bo_va,
> -                                   uint32_t operation)
> +                                   uint32_t operation, uint32_t flags)
>   {
>          int r;
>
> @@ -620,6 +620,18 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>          }
>
>          r = amdgpu_vm_update_pdes(adev, vm, false);
> +       if (r)
> +               goto error;
> +
> +       if (vm->is_compute_context) {
> +               if (bo_va->last_pt_update)
> +                       r = dma_fence_wait(bo_va->last_pt_update, true);
> +               if (!r && vm->last_update)
> +                       r = dma_fence_wait(vm->last_update, true);
> +               if (!r)
> +                       r = amdgpu_amdkfd_flush_tlb(adev, vm,
> +                           TLB_FLUSH_LEGACY);

When kfd flush its vm tlb it uses TLB_FLUSH_LEGACY after map and 
TLB_FLUSH_HEAVYWEIGHT after unmap. Here use amdgpu_gen_va_ioctl to 
map/unmap buffer in kfd vm. Should we keep consistent with kfd:

use TLB_FLUSH_LEGACY if args->operation is AMDGPU_VA_OP_MAP, uses 
TLB_FLUSH_HEAVYWEIGHT if args->operation is AMDGPU_VA_OP_UNMAP?

> +       }
>
>   error:
>          if (r && r != -ERESTARTSYS)
> @@ -789,7 +801,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>          }
>          if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu_vm_debug)
>                  amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -                                       args->operation);
> +                                       args->operation, args->flags);
>
>   error_backoff:
>          ttm_eu_backoff_reservation(&ticket, &list);
> --
> 2.34.1
>
