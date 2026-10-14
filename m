Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375D0CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 10:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA52510FCDB;
	Wed, 14 Oct 2026 10:58:30 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D12B10FCDB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 10:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eL0SNtDl9e1BOJSTiwU3WV9uWN0FrqFrcj0XZUwPjEaXvgjidUSyigvN6cieAi85gTKawf96OSO8oEwg9E4haiuNugYc1msgPQFDo1k/+fVfeMamokeYm/EK0M2OhbfN6L/dW3uT7WTPmM+uz2qoS/mNNyTW/b3i4+guSA99qf9/oTT9kPSs8qaQ4b5XW6iHY31XVOKlo0vWZuaokBsi59hxylVRAE+5icY2KLXRaphnixbDCsHrIyyJ6jki0W/aPg4S3geASI+HJNIMu//xNS7Z+8grVc8mqzYgUUcrf0goKvdNLdV8Nrf617eZVEOAtWeMPZVKxiFcikp5ZEuaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/fqYzFP5Z2f1QXeQPXkOcCuHOYatp9sNAm1EkKPCBI=;
 b=hfzs9rrSFLZlG7rLNTKJCF+3QdEuZ0l9Eh/cDLaoq6eGKucwBoRolbV9dW9Zu97w1WWR+XNTKdCKOAhbZKgQNf5/lQSPI9w8nnXXYjDA2Bd4uGuhh/9Bb4VWPaBvqbZU5N+AvHkOM6kD8bX29kZPIrb0ixIJq0Hx3ww4EDg+JkAyw82G4n12qjJ0cgaHgLu2I5asD85OXlCx/qoebVIa95h7+vc1wJOj143SfwRBewtJuwFIlfuMOM70X9s4VMOI6JRY9z+N+Skce6WUc4Tc4mQvhJYPEVGeVWkG3HdquVax8zY3o9kLhu7ckzo28cEhaD8tT4f3DsPsTC3EEzDezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/fqYzFP5Z2f1QXeQPXkOcCuHOYatp9sNAm1EkKPCBI=;
 b=B7vQ5tuN0s/EM3k7ld5hruZRZ3qTJdlXI4PWeMjJaJLm/9ilHMCcIYn/hP9Wh1G5uWcNnYKTC2DAxF14jRzxN9XELbNkTxjLwy56FNG2fFZ9tIIi5ESU1YH+N+LRMj4z5X75UtTtHP/N4clotDLXh1EHN+RIRhLs4sA4VSATJEk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 14 Oct
 2026 10:58:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 10:58:20 +0000
Message-ID: <6c3bbecf-c873-4002-b94b-4a30df8f32b7@amd.com>
Date: Wed, 14 Oct 2026 12:58:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: check every VMA of an ANONONLY userptr
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20261014091653.2932409-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261014091653.2932409-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 108027ad-b072-4bd1-6502-08df29e20ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MEqF9WWEvfDQyoisV0R2HUvjmtt6dnbDJsBi93OUXbuEzuP84yEyuDPegIAufQLSwGA/MBpCvYtwGL9ZFlEOoS1k0BpVmZCIb+Q/l26xYvZZ92pfQus9XU6ep17IlaLw0vQP63a6xogmHLok5Csat56veUIxTp+7cn1GJICHMMkveieWd5yLQrjVMedBI7lm/ZgyueOvrQ4qkzm0qzu4K6/PBKYfokn6GnCEBAQQsKAleB8OMfiKQowr8hW3i3nGR2MwH3NkRlid+op+2iP0Kh0KZcwtL3fGl/SL6J2obai0daI7X5KwXVoin3KMoBIjNpZMcFXVdP9hjiJhrXlJErPhwv9kEaqS9kTANFZtG7L8kgBzPI7ECmGpHKu6w4C19PRtjsIok8Q9PMVVb5hpa7eZkKfGKkFXvuITaqbdJYBHDVOKrXLkFdBliBlDb/7S9ksjrCP3L0VqGwwXOOgwQGPJHAslL506tLe9TI4B4UBMaUjaRY6dnzqWrcZjR6kPthQ9j2NzoaQ+u3XCUif8PVrTMZvJJponfvUPoTIYP0liWPoxA3d323pkwcEjR6hR46vILs87j4w+LqvyTj/lPn5ey6aQDS7j/HxhqdsWc+DaGQpYQMLD1gORVyEGhBlgOpqsH7WA9wsT1th554yVmy4FzdiadgtuiuNXhu83GdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1prcGlSeW1ubEkyem9TUVc1WVZEdUlRcDZyRStoSGczaTFwNTNLb3F6Vy8r?=
 =?utf-8?B?akx6dkxSZFVvNG9BMXBXcldaaytnd0x3ZUhHQTJUMS9XeGwvOCtHSnNKUmZQ?=
 =?utf-8?B?NW04K3RzQm1scWNramZ1KzBZRmlEVnBFY25VaStoVERVSFl0UWxwcGlDUVZi?=
 =?utf-8?B?ckRtc0tyeWpYR3NoOVNwOGpwV1RZbzU2bTM3c3dlU2RsYmRMQ0VqelFDVE1l?=
 =?utf-8?B?RnhWaEYrVEVpYzRqdnRsVWpld0lDWERuaGxDNzhtdHhnalduSWE1RXFQa05n?=
 =?utf-8?B?b29Lb21TZkU1dXVRS0kvS3RiMEo4MVpnVzVQbkNCQ3d1Mk5odDJVVTIyamJm?=
 =?utf-8?B?Ym5aclc4TGs0VkVDTGVQN21aVEhHUTJBTFdKU3lLaXNlSDJUTnVuRkJMWFRU?=
 =?utf-8?B?aXZsL2xBcXhEZGJMdEpNdXlKeWNzTmZ5NU9BK2oreFlPK21vUE9hNm9CeDIv?=
 =?utf-8?B?QTlRbkNHUXVQQVBLMW45QVY1QlRsN2QyazFBNmFjN2hNUlRxV0o2cWZhVWNH?=
 =?utf-8?B?aFdUT1FnSHM1Nml2d2NIR2dpWmx4bGhwc0FqY2dmam14bVlYWER6RHFVakxY?=
 =?utf-8?B?RGlLbUZiWTZEQUYzcEVyOTBlQXN2a1VGQng5Y2hzc1ZLb0hreUdqUVNWYWlW?=
 =?utf-8?B?eUdjWU1UeXFWYThsNXN2TGFoTjA4MGlSbTFORmNpeVhPaXpld09FdmtqaVJl?=
 =?utf-8?B?OFNvNENpMGcyMDc5V3RkK0xUSDI3RmRySUUrZnM3dmUrZ1NuRlJjZ0xJanR6?=
 =?utf-8?B?T1JXMVUvTnRxdDQxUmdjODFQeU5oYTZVMnFoWnBVSG5ocldOejJwSk4vbnk1?=
 =?utf-8?B?N0JsWmtVb3dNY1hHVTA2U05NOUphdVhYa1VaY09KZVo1dWNTVzBrcDVBdGln?=
 =?utf-8?B?aEs3QU1qQS96VUVPYWp6S1RKTUJBcXNDOWZnZjVaYmFBaU42eGQzM0tHWWJ4?=
 =?utf-8?B?NThhVHhXcGFlZUdLbW1hM1BlL0o4aVJTd0RjVHR2eGFuTDBlb3ZPbUphenhl?=
 =?utf-8?B?ZFZDWmo3N29tbGNuZmFzdHFGVXFCOXNia3djR21Ud0tjWERMOHZUc1NKRFJL?=
 =?utf-8?B?YytLYTVTQ2MwMEQyRnMrcFFrUE5GUGV0Y0NDdWo0SS9yQ3M0WkRBdXdOUm90?=
 =?utf-8?B?NWxUcXFYK2ZjWFAwZTBiWElydUtkN2poOVlLcEw3Uk9LUzFaKzhkOFptOGVJ?=
 =?utf-8?B?ZFovdWpBRVc2VStNcW1ZSlJ0alNoSUhMdEtBVmVDaXpMZkNxbW82Rno3aUt0?=
 =?utf-8?B?ZThZSDBjQ25zVzZkSnNIWStWdGUvaGZySmgrQ0YyeXdJWlpybGQ2L1Y2TnY4?=
 =?utf-8?B?ZFBWRG9zQjdLbWhuNTdKOFBKT2c4cUtzM3pnL2RQeVgxSDFNZHFkNzZkRGVi?=
 =?utf-8?B?Q2lncjE1UngzSG8xWEVyOC9sdHFTaitJMThkbEpvb3VVbHB3Nk5KL0l1TTJU?=
 =?utf-8?B?enc4VUp3QS9QeWJya2ZkRXArV3lSVHYrWVJiRnBCbDY3QUFKMzlqTXNMQjNY?=
 =?utf-8?B?Mk1RL2dVRWhDY2VHY054RS9VMS95cExhbFc2UnJHSi9sYklTeW92SlowSWVC?=
 =?utf-8?B?cHorZ2x5UUdaRlR0SnNqSXljdTZLOTZrVnFBKzVxTnQ5TlVrZEI1ZENQOURt?=
 =?utf-8?B?KzJIR1lSMnFoa0hLeVNFdmtYMHJJMytqZmFSaHhZMlRWTnBrRmlDWFpWam51?=
 =?utf-8?B?c2dma2FVK2xrbTU4Vll3ZWRDalZQUEpaWFdLRlBlRitPUGI4MFVlUDF6dkJX?=
 =?utf-8?B?MU1KTW9rYWlSREc5YW53a1E2MGdRS0pnbzh0RlpwVjYxMjU5TllROE5lL1Bm?=
 =?utf-8?B?MXg5VmlVSWl2K0U3WXVqYUxqdDIrdGtQYUEzb2xDM2toZ3Z5V2piN21EVER6?=
 =?utf-8?B?cDZvaEFNcUtseHFKbjZEMlNQVzNNem50R1hFbHh4emh4aGMwQ05GbG52TTdW?=
 =?utf-8?B?M29udWFFMXVFNUI0a3NxdGx6S0Q3dllYMVprc3lSU2EvekM2M085UlBNSEpo?=
 =?utf-8?B?MTcyMW5OVW1lYkVIa2ZIR0hTRVh1cTQyV3FmVnBWcVp3YWpVeG85djBlZlcx?=
 =?utf-8?B?NHBpT0dSVTkxczdKNk8zWXF1MnQvSkk3UVBWdGZtV0E4RWswNVFoZGdZWnVL?=
 =?utf-8?B?bW9yTmd0ZmJ3TER0ckgvMENUNFdzTHgrQ2oyMjFEVW9NSDJvS3k5cXIxcHBT?=
 =?utf-8?B?dkVSa2RGTWd0MXQvNjg0Qnp3U3huVFl0YmJTemZvRDJHd0pUR2tJVzhsck1B?=
 =?utf-8?B?bkJoMStYdHZlVGVHREU3b2JxaUQ0OERMVlArS3RBaG5ySlpLVHlUdTJnNDVx?=
 =?utf-8?Q?xzc1P56MYtZwHvzBI1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108027ad-b072-4bd1-6502-08df29e20ee9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:58:20.1285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFnHlg3uooE6kVeStBisJzSV6pTJoEBPXCxwOSwi2cuAHGSh/mOe87uzUWyN/oRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

On 10/14/26 11:14, Jesse Zhang wrote:
> For AMDGPU_GEM_USERPTR_ANONONLY, amdgpu_ttm_tt_get_user_pages() only
> checks the VMA at the start of the range for a backing file, and
> amdgpu_hmm_range_get_pages() then faults in the whole range, across any
> other VMAs. The check used to reject ranges ending beyond the first VMA
> (vma->vm_end < end), which got lost when the code moved to HMM.
> 
> An ANONONLY userptr over one page of file-backed memory is
> rejected with -EPERM, but one over an anonymous page followed by the
> same file-backed page is accepted.

I think we should just reject the mapping when it crosses multiple VMAs.

That approach is not really supported in practice.

Regards,
Christian.

> 
> Check every VMA in the range. The second userptr is now rejected too.
> Fixes: 6826cb3b92a3 ("drm/amdgpu: support userptr cross VMAs case with HMM")
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2103f8d6165d..d113618543a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -783,10 +783,17 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  		r = -EFAULT;
>  		goto out_unlock;
>  	}
> -	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
> -		vma->vm_file)) {
> -		r = -EPERM;
> -		goto out_unlock;
> +	if (gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) {
> +		unsigned long end = start + ttm->num_pages * PAGE_SIZE;
> +		VMA_ITERATOR(vmi, mm, start);
> +
> +		/* the range may cover more than the VMA at its start */
> +		for_each_vma_range(vmi, vma, end) {
> +			if (unlikely(vma->vm_file)) {
> +				r = -EPERM;
> +				goto out_unlock;
> +			}
> +		}
>  	}
>  
>  	readonly = amdgpu_ttm_tt_is_readonly(ttm);

