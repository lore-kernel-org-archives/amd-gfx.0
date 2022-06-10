Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E245C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 23:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131E111AB5A;
	Fri, 10 Jun 2022 23:06:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D22C11AB4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 23:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSdL8ifRHz43liGHMBdCBrApTincw2KeXNn+W9o7MMs7StGQKLhwX/9/IgBqDHTTop4QXvvoDAXL467vUxKTYZIrdegrh4s6FQh64lM6lkO6QChjtWUqonwVxb16pl5yVp9TolGbJSf2bZDhgeYja1/ZS1EBnONfR+wJZBHAbzDy2SbFSctcfoAFuBUwRoYg+5hijU+Sk8vg1X5n+RdBYvsKptBux6XDxVKSGtM+106vJuVPhQgNwz3RIGi4RH89a8ha0Gjc84TCTCWQk3qtrosGjTpt55fUM4O4zvewcPU78zOZ1RMuIiGKMQkICIdmng2lqFOy4bXhfDlokMt4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFYbNmEO0CUAX6qLasvXjlufN7+OWxdKGqlG+0lB/ho=;
 b=bYbY1oFj/aKxZzqg8kTXAU1P3fwX8eDzWAApqusWFaTyDHlxmmg74prvID0/7Aax7fjfUBnqintZV5jnk+NaqNo8A4QFoVb9Od7fjhN9vIgvqUlKj9yBcWNgOpD9CMjD18MZ9Jp4+A9LB8RWHnxVs+yHmuBZaw36u06DG0VFTUBwI1QuteOenIgZR6VQhQiH9ysYTr/kLqJ6hQ6RvH8NMJr20RHdC5XDvldGIMK2PtgKbdAFmzaPX99+3oNMmCajWJiEP9FKsecex9Bc23+aoC4/mh1RpdpH6+FYJxmVvPdw/BUALYPhx3271IsajFsOlSTwpS/QWNnJv+Wy1JzH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFYbNmEO0CUAX6qLasvXjlufN7+OWxdKGqlG+0lB/ho=;
 b=hJroF4WojKeklgIjC+Iyj4ZCUC6bfM93fV81ZnFfRyGPgXMrGTEwLZ3Xp3LjJ+mkmpkULV+KugV0+5gR6IH4ZSpVukJ7cpSUnzt86gdKg5ofZhAsArLSQyxaTOuoZCOpDtKd6GrO7cyLvmAXOJ2MHjA4cVMOEcWf8ep+9b6OvIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 23:06:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 23:06:10 +0000
Message-ID: <80a0cdbc-8509-a090-fcab-7bc19b0b7047@amd.com>
Date: Fri, 10 Jun 2022 19:06:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220610171316.2668611-1-Graham.Sider@amd.com>
 <20220610171316.2668611-2-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220610171316.2668611-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9872c4f-c55a-4eed-f593-08da4b35cf2e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB309984DDC3264CE8AF75687192A69@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDkX/sfdfyroMWJ96aAmznAgQdYgh/VIeCVJXUVms8iBrvLC2OthpvLPKwxM247ZD5QUlhHgeA1Cm2MNeSDA5StkXXDMyA+a2Cs2IC3KQWtjXNjYzZz5BbKUi/J551r1KAVwXvuO+j6LoaJg7b+FIkCcwBV1LiJQDS1ulMdLjzr7pkA8mROIt20ew69zz8HudV9dEXg7Un0Dd6Ebdbx7P/IT/YJDFy/k4f2wItO09nZNxyaiYvkh/ftj7kdohyENIC1T0T/ij0uMOsv2ri+HMw8cmehIBv5zoGFo5QoaCiwHpoR+13Ba2dFWhduARFKjzIem4eIMbJHG+finFVWuoOvNbOOJTUpY/F/NM5khmqjMyziVm7Mz9D6zZftPKOrnSzUygz6HY7uj7vPKQbSmJ4UrHD28ONZ9gopx3GP/2Jtmts/UJdxTCAhQkih73gvUY847F+hyAvLpNMiIjubDhZCG1YcJv3gkcuEUqYZnu3aJFf97pHekVHRJ4ZbCvWUhwEphplusOp9aUg8R9sqX8AnchrqSMD7De5eSMhTjfqwFWm0Z8ztluir/CpM+QcrkpgKcr/u7PSKhxsS+c5++c92O/j8EefCOhD1oEQHr5YUjgOoEvEhxkSybTvZMw2THyQUoBFQSkwEOIBGaWo4reqk1P3+uVTYupYJrN9tIxaM1CqFb9dUXn7p9dFxYQJ0w76ClgHcw868eSa8O7soeaipx/WqVoAWXTgPixXM4HE1nVeMnuvx5R5RwpinQEuCy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(31686004)(83380400001)(36756003)(38100700002)(86362001)(66556008)(66476007)(8676002)(4326008)(316002)(31696002)(66946007)(186003)(508600001)(30864003)(2906002)(26005)(6512007)(5660300002)(8936002)(2616005)(6506007)(6486002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znd0dGMzazBkd0w0ZVlhV0RIZDVqREtwbGpsQkZ6TmY2UTZqKzNnemZZdHdR?=
 =?utf-8?B?MUNFcjNwL3U3UmRkSG1TUHFNZTZPeGtndGV5dU95MCtVWVZSUlk3RFA3UDVz?=
 =?utf-8?B?ai9Qb09uT040VW55UzFHeTdheVcvWExuTDRvNG5jNkpSZUpiV09oQk9kNkdl?=
 =?utf-8?B?bUVMRHZjUGNvUDVRQkV5Q3ZlSS9xRnNJcUs3Qk5VTVVBb2gxTWladUlBb0lr?=
 =?utf-8?B?b3VhRFAzNEl2ekZ0Yyt2RVA0SHR3VTVURDdqc1hMNElOSSt4TlVYZThUaDkz?=
 =?utf-8?B?bWJnOG9KOFNLUmdSdDRtY2dBTWUrOTFFQjVSS2VTRWcxUEVGdGw2dXZXajN0?=
 =?utf-8?B?SWVKWnRBQVJNMmgzbDA0VkZrYTRKWGEzOGNVb0s0V3BHUEo4UDBMOW40N294?=
 =?utf-8?B?NEg1aXBTSXRXL3E5a0MzZzlVQTFSeURYeTJUSWZWVm52YVBLTzFFUCtuZlls?=
 =?utf-8?B?S1FlUFZyMmEzZVRnWVlHK21TV1dpNzJxWG52Q09aNjBWRldBUTdKVnc5ZFN4?=
 =?utf-8?B?SE4zeDhJZUhpSEhVS0ZsS0hCT3NEeWxQckg0bU5Hc0o4ZE92SGJseks0VWJy?=
 =?utf-8?B?anRrNHk4YkN6dEwrelZGZ0llTTJFUW9EUmVXdW1kVDB1MlV6K0xhRlNrT2Mx?=
 =?utf-8?B?Vk1Ma1pkckxkekRieUM4Yk8zZ2U5L2NYNXdPcHhuOGpRYzFXTWMwdmk4Ty9v?=
 =?utf-8?B?QmpRWDljOVp2VFFDV2pkakh5VlVua2w0RmtyMmtIOG5YL3FrN1pYeDBqdTh5?=
 =?utf-8?B?N3JLTzJVNjN1OENVOENpdktwSTU2T01QUzhlQjFDbnNEU0JhRU1mQlVvbndL?=
 =?utf-8?B?c0FNL1lLaFF0SW0xOVB0SzcyQUpEUnlwRC9jRkRocEJyOFUwaFJyNHNtNDI3?=
 =?utf-8?B?KzV4YU93K2cydWVwNzhmbU5RUFlrWENVbjRBOWpqSGw1OENwNVFJUXZBUXNW?=
 =?utf-8?B?ZEdNSGtpbXM2dzhNSXBEeUMySHdlRnBmRzNuM2lCbkZjaVpZZjZBUUtrak9q?=
 =?utf-8?B?Z2FSWEVkMEFpNzBiU0EzOXhRRytML0tweTJsYnhxMkVvZWNQY29wQkJzSjlv?=
 =?utf-8?B?U2p4RG9SU25wb3AyUFVLZ1MzcUpERHJkUnVwZGVNVHA1K3l2M0NtZVZtYmxK?=
 =?utf-8?B?NXBrZ1B2dSsvUXB0L1pidU1pUkhJYXVVc05na0IwbmtLYVc0d29pVDZkUC84?=
 =?utf-8?B?WC9xVGc4R2VDMStFMlo4aUhMaklETkxqK1BLbEpyMFV4TjZ6SE5paEgvdkNT?=
 =?utf-8?B?Um42dEZGeENUbVZaWHRGNk4xcEQ3Z0JpLzBiQU9EQ3ZpZUVqZHFuY21MMjBF?=
 =?utf-8?B?NTJRbDg4cGJMNjJBWUYweDJadUZtdXZGdGE5SzdJcE1ZNDBFdnlVWU02ZUFa?=
 =?utf-8?B?d0hKd2ZhUVRrWVBtK2ZYelhQdjNLc0owMlgyZVBpSWp6L2E1MGVmenZFTDhH?=
 =?utf-8?B?YUZDZ1VkVjRNOFJHQjBmdGw5Q0c4eWFDa0w3akFSVXVXaktpN3lZY3NEcDBE?=
 =?utf-8?B?NVNTM2NBUFBhREhYbk1WQ05XZ3dvYzhxWXkreng1cUlWMVE0VlJoek5GLy8z?=
 =?utf-8?B?b0t3WVhtb1hJZmlrRy92azN0NGF6SXZwaTFrMGQ3bDBrSWNsczZrbDc1bXR5?=
 =?utf-8?B?bWtudUtBeEdhWUx1ayt6MFJ4YmJsN1JCbnQzS0htYTQ4Y2lPM3p4bWNESjBl?=
 =?utf-8?B?UkZoOExJYksxNUduRU14YU1lMG1ZdUpzTVJHL0FjWWhoZ1FoY2JFMitSdlhm?=
 =?utf-8?B?OTBOc3I1MWticmRQamlXV1BPRVVXaWhMN3hLYUFjZ3lrM2N0d0tjeitMcS9p?=
 =?utf-8?B?YXZZanI2S0R5alpXVEE3aE1FdC8vYmxBMjg5cTVhZkNidGo4Ry8xd3Q5cHpx?=
 =?utf-8?B?dE94dnRXODBNclMzMWs5UHZVY1J2NXJJOTRmdHNna0MyeUJsUmE1TzVhd3Fz?=
 =?utf-8?B?KzhKZGJPak1ndnRyRFFRdk4wL2JkbkZGME1ZOEFnK05HM1V6dzFJOE5jM1BT?=
 =?utf-8?B?WXk2MXNhY1U3UGo3YThkTVphNGo3UlV0anhaNUhXdnI3TWRZNTdhRWVyd2lX?=
 =?utf-8?B?RENpZkVrdjE4VkN6OTFyemtEZG1RemtCQzBpZ2RsZzhtVnVPaFd6b3labmto?=
 =?utf-8?B?dURFS2xld2JxOFpFblUwUStMRmxYZGxCRDhkZXRLanB1NmtCREJJK0FaNTB3?=
 =?utf-8?B?d1c1aGJLWm81UEpNRnhYOVdPWUdrL2E5T09hNHVRQndoU3NMb05RRHhxdzJJ?=
 =?utf-8?B?ekhMWGtvbmJybitXcFhWVFlwOVppSnZrRFJtb2NwNSt1dEpBK29ZaUhsR1ZM?=
 =?utf-8?B?KzdFaGVscWVaQUZwcjYzOU9RMmR4a0twbEE5OWl2ZzViNklFK1cvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9872c4f-c55a-4eed-f593-08da4b35cf2e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 23:06:10.8751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae4TnjtJW4yU/Cm2at277p7fXBWnzeBEjmS9lVsJQNizISu7Ha03AaIY6EPk9mX3TO9M9Q/PUxslNxpb1bLsOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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
Cc: Mukul.Joshi@amd.com, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-10 um 13:13 schrieb Graham Sider:
> Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
> GART for usermode queues in order to support oversubscription. In the
> case that work is submitted to an unmapped queue, MES must have a GART
> wptr address to determine whether the queue should be mapped.
>
> This change is accompanied with changes in MES and is applicable for
> MES_VERSION >= 3.
>
> v2: Update MES_VERSION check from 2 to 3.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45 ++++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 19 +++++---
>   7 files changed, 110 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 429b16ba10bf..dba26d1e3be9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -301,6 +301,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   		struct kgd_mem *mem, void **kptr, uint64_t *size);
>   void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
>   		struct kgd_mem *mem);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index efab923056f4..2d452655eb04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2030,6 +2030,45 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>   	return ret;
>   }
>   
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)

I think this function should take a reference count on the bo to ensure 
the pinned BO is not freed prematurely (even if broken user mode frees 
the BO before destroying the queue). Add a comment that the correct way 
to release the reference and unpin/unmap the BO is to call 
amdgpu_amdkfd_free_gtt_mem. See another comment below about moving the 
amdgpu_bo_ref here.


> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, true);
> +	if (ret) {
> +		pr_err("Failed to reserve bo. ret %d\n", ret);
> +		goto err_reserve_bo_failed;
> +	}
> +
> +	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	if (ret) {
> +		pr_err("Failed to pin bo. ret %d\n", ret);
> +		goto err_pin_bo_failed;
> +	}
> +
> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	if (ret) {
> +		pr_err("Failed to bind bo to GART. ret %d\n", ret);
> +		goto err_map_bo_gart_failed;
> +	}
> +
> +	amdgpu_amdkfd_remove_eviction_fence(
> +		bo, bo->kfd_bo->process_info->eviction_fence);
> +	list_del_init(&bo->kfd_bo->validate_list.head);

Please see Lang, Yu's patch "drm/amdkfd: add pinned BOs to kfd_bo_list". 
We realized that pinned BOs still need to be on the validate list. So 
please remove the list_del_init here.


> +
> +	amdgpu_bo_unreserve(bo);
> +
> +	return 0;
> +
> +err_map_bo_gart_failed:
> +	amdgpu_bo_unpin(bo);
> +err_pin_bo_failed:
> +	amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +
> +	return ret;
> +}
> +
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   		struct kgd_mem *mem, void **kptr, uint64_t *size)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index e9766e165c38..58d5ebed1b32 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -290,6 +290,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	struct queue_properties q_properties;
>   	uint32_t doorbell_offset_in_process = 0;
>   
> +	struct amdgpu_bo_va_mapping *wptr_mapping;
> +	struct interval_tree_node *wptr_node;
> +	struct amdgpu_vm *wptr_vm;

It's good practice to minimize the scope of local variables. The above 
three variables are only used inside the "if" below. So they should be 
declared there.


> +	struct amdgpu_bo *wptr_bo = NULL;
> +
>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>   
>   	pr_debug("Creating queue ioctl\n");
> @@ -316,12 +321,44 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> +	/* Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
> +	 * GART for usermode queues in order to support oversubscription. In the
> +	 * case that work is submitted to an unmapped queue, MES must have a GART
> +	 * wptr address to determine whether the queue should be mapped.
> +	 */
> +	if (dev->shared_resources.enable_mes && (dev->adev->mes.sched_version & 0xff) >= 3) {
> +		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
> +		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +		if (err)
> +			goto err_wptr_bo_reserve;
> +
> +		wptr_node = interval_tree_iter_first(&wptr_vm->va,
> +				args->write_pointer_address >> PAGE_SHIFT,
> +				args->write_pointer_address >> PAGE_SHIFT);
> +		if (!wptr_node) {
> +			pr_err("Failed to lookup wptr bo\n");
> +			err = -EINVAL;
> +			goto err_wptr_bo_lookup;
> +		}
> +
> +		wptr_mapping = container_of((struct rb_node *)wptr_node, struct amdgpu_bo_va_mapping, rb);
> +		wptr_bo = wptr_mapping->bo_va->base.bo;
> +
> +		amdgpu_bo_unreserve(wptr_vm->root.bo);

You could move this to just after the interval_tree_iter_first call, 
even before it checks for errors. That way you don't need to deal with 
the unreserve conditionally on the error handling code path. And you can 
probably just use one error label err_wptr_map_gart that handles all 3 
failure cases.


> +
> +		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
> +		if (err) {
> +			pr_err("Failed to map wptr bo to GART\n");
> +			goto err_wptr_bo_gart_map;
> +		}
> +	}
> +
>   	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL, NULL,
> -			&doorbell_offset_in_process);
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
> +			NULL, NULL, NULL, &doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;

The error handling for this and all later failures should gart-unmap the 
wptr_bo again.


>   
> @@ -353,7 +390,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_NEW), p, dev, queue_id, false, NULL, 0);
>   	return 0;
>   
> +err_wptr_bo_lookup:
> +	amdgpu_bo_unreserve(wptr_vm->root.bo);
>   err_create_queue:
> +err_wptr_bo_gart_map:
> +err_wptr_bo_reserve:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b39d89c52887..d8de2fbdfc7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -208,6 +208,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct mes_add_queue_input queue_input;
>   	int r, queue_type;
> +	uint64_t wptr_addr_off;
>   
>   	if (dqm->is_hws_hang)
>   		return -EIO;
> @@ -227,7 +228,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>   	queue_input.doorbell_offset = q->properties.doorbell_off;
>   	queue_input.mqd_addr = q->gart_mqd_addr;
> -	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
> +	if (q->wptr_bo) {
> +		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
> +		queue_input.wptr_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
> +	} else
> +		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
>   	queue_input.paging = false;
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index f1654b4da856..35e74bdd81da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
>   	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
>   	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
>   	m->sdmax_rlcx_doorbell_offset =
>   		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a5d3963537d7..dcddee0d6f06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -639,6 +639,8 @@ struct queue {
>   	void *gang_ctx_bo;
>   	uint64_t gang_ctx_gpu_addr;
>   	void *gang_ctx_cpu_ptr;
> +
> +	struct amdgpu_bo *wptr_bo;
>   };
>   
>   enum KFD_MQD_TYPE {
> @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index f99e09dc43ea..ede1462a55c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   static int init_user_queue(struct process_queue_manager *pqm,
>   				struct kfd_dev *dev, struct queue **q,
>   				struct queue_properties *q_properties,
> -				struct file *f, unsigned int qid)
> +				struct file *f, struct amdgpu_bo *wptr_bo,
> +				unsigned int qid)
>   {
>   	int retval;
>   
> @@ -221,6 +222,9 @@ static int init_user_queue(struct process_queue_manager *pqm,
>   			goto cleanup;
>   		}
>   		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
> +
> +		if (wptr_bo)
> +			(*q)->wptr_bo = amdgpu_bo_ref(wptr_bo);

I think it would be clearer if you took that reference in 
amdgpu_amdkfd_map_gtt_bo_to_gart. That way it would be a simple 
assignment here with no "if". And all the BO reference handling would be 
more neatly contained in amdgpu_amdkfd code.

Regards,
   Felix


>   	}
>   
>   	pr_debug("PQM After init queue");
> @@ -237,6 +241,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> @@ -299,7 +304,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		 * allocate_sdma_queue() in create_queue() has the
>   		 * corresponding check logic.
>   		 */
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -320,7 +325,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			goto err_create_queue;
>   		}
>   
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -457,9 +462,13 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   			pdd->qpd.num_gws = 0;
>   		}
>   
> -		if (dev->shared_resources.enable_mes)
> +		if (dev->shared_resources.enable_mes) {
>   			amdgpu_amdkfd_free_gtt_mem(dev->adev,
>   						   pqn->q->gang_ctx_bo);
> +			if (pqn->q->wptr_bo)
> +				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> +
> +		}
>   		uninit_queue(pqn->q);
>   	}
>   
> @@ -900,7 +909,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   
>   	print_queue_properties(&qp);
>   
> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
> +	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
>   				NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);
