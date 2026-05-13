Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E654CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 13:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C9C10E34C;
	Wed, 13 May 2026 13:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LU9+M2dC";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E0410E34C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/ckhAr0oc1v5XQmnpGUaiKKhPo5xCmuDVe3hO7c6waH/JjO9pEXsM80X5+ozNEyouGpD8FOvHQe93a551t+7Kfw1/vyxEvSZ5mWu2Qwk8XON2VPXoTxBLb2YvZoVqpHjW8gCrq4kN/ohHcUDMPBtfKdvii/Q+6uV+zznKmVWcrPdlrfrtrdijFJxfI7Bh0BtY71AU+RoIYC8ppdI21+X7HjRXBIfenvIj+ZOJPqWuioNWIOD3msRuG2tE36sQokw//8EV4TMdAmWdsjfWFDwE63mm5uflsSAivpui97mD3/+uXqTNL++025eSWBkR3xvsy368IT+KlHeketqBOZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFnuxoCjVU4yveJH7Qjhcl2qYRdJhm2xAoQrnrvy4OQ=;
 b=xJTe7o4GiPXM5z0nRjxDjDk5k9xRcA7xAi487rlhx+3kjoQzdeK6BWA1Fpnyc0F3DXPlrBgglcqI4jc8gRlCwHpMucYZlqjGQFOX1U2OP1lszDCTDZpuNw3o6H2D88isWGAvy1erxt0LaNyD7pIzeQx1UIRAvsUgiEGyLxy+vxmF1DrcSWc4OauGhQZMgmhP1IZ0kXSUpc7uJZkmA8/VcVQXshp6+4Dnl3X/84L3fT/kbhSBMSKETupdSc/EXli1IH6QrAWAtsP96emkISNf9IZ1z3B6cUIXRuXXqkd+DFT9v65xEdvpabXUYOaSe15ZbB1xIRwTTP+5gqn1lfHXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFnuxoCjVU4yveJH7Qjhcl2qYRdJhm2xAoQrnrvy4OQ=;
 b=LU9+M2dCyB1IiB6OEsl98wpIwOzgSAcmKngDC/LuzayFku75tt/q/S59HRZmFvHJEBqiPlYfzRwKwvXQS7eyXoWXhkuulBa3fnSTUY6r/ZKJUTtjaBq41z4AEBTXO1qzEpJCF/gcZdkX8y4Y2OH5dIvOjovSTS70QwPgL1svLes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:59:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 13:59:06 +0000
Message-ID: <456757c7-3e05-494b-9a51-09796757e649@amd.com>
Date: Wed, 13 May 2026 15:59:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/userq: Add syncobj_points to signal ioctl
To: David Rosca <david.rosca@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260513104710.9705-2-david.rosca@amd.com>
 <20260513104710.9705-4-david.rosca@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260513104710.9705-4-david.rosca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ced946e-5782-4519-86ee-08deb0f7cbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AnpWAhmnTnHHWT7XAZ7dtLqagnxtqeczt2wwwGkJiMYfzz7uLcM//SoOVe1l6rLfnSw4v0iTys5fBySm7fzSslL1rI+wPCEqSmbVIzwgnAxuf43VD3Wc/riIN3TmUwI70TLKAFu5qEtAukLmGfhMjjh/WLNgGpHYQar97mO9cen2RJVcyDn7k+8ZQKMHCsZJS8TKMM5t5ORRFqh6QdbYo+ih41yVjtzpVPBl3SWqUKWNaIUwgwz5mrOPg7qJiXyBInpDwiczpslyxqB1IGLklL7UixShfuPLlZ/CGJsrCmXVvwQknOgVCHCY23QeceOGQoUsNniux3hzgWuhvvo/lg7/5ehzXB3M3p4AyItkKhPkuNwgeg+5gHeSQWJx6qOon+8ptrf+skr7g9S8N/F50Fujx55sRiDS69HI3PsttGMpb/po6i+ExP23fXGGkINTmFOlKHl3Ef2jDNZGCsl6DN9ZHlANKPEd9IR7gOspKoAbVUvXsKMyBMkH3fTTR89HZVtRV4p0FCY5L3BU+uMLe9NpaY+WWSgiuxmxNj686kRpqFIgOf/zIz/faDdaaNrU+np9NtqKcb4x8zmi6J7UfJ0U/aT1IWcGjU48v0ZjEbvTAhF1GmqbwzhMbyrFCPB751wrScWowZ7oqr6G6m35tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWRnOGorU0VyZk00VmFUZkYwWW9sdWNxNDBnc2tHYzBWNE9XekJsNHRXS1FV?=
 =?utf-8?B?OGhBblNBOEJqUGNPU1N4eDlRWjk4OWdtSlRQRDRlbU9iWTRJSURhQkxxVDRi?=
 =?utf-8?B?dmhLRGU0WG1XNFNoZGYzU0Q0WjZzdjQzY0xCVkJibURJM1ZBMFZyN1laZ0Mw?=
 =?utf-8?B?WmtlRmpyZzdGWnV0VWJHZlpEdUFXYTgwUkhhZU1qZ3N2Qks5cU5weHJsUEth?=
 =?utf-8?B?SUlSbmVNZC93NjZYc3ZGemJiMFV0cDliY1FGeTREeVB2TXIvdXVuNk5GRmw4?=
 =?utf-8?B?R0k5VkRVdDlsQ2JUaVUrY1NxbU5qb1FTVk1vMll5NFNDM3B6RTBnNjU2MkFj?=
 =?utf-8?B?TEdtb1U0U0NQUEptV3g0Z2dHTmdyc1V1RGtmb0k3TDh4U3JYdCsrU3VjZzc2?=
 =?utf-8?B?TklFRU03bUZnVDJObTYvMVJKU2lKS0tWNlF4dnQ3eE9NcGZQa0VXNjR5RU9K?=
 =?utf-8?B?cVZ3V09US2FzcTdVOVZXVUI2eVNwYlRoTGticDRUUHVaNWNmMnFTd3hlWjQx?=
 =?utf-8?B?dmNPTnhuVnJ5bjkrUnRRQzdDaUJ2TUNQbnNJZXc2MmRrR3lSY3l2bkRLcytX?=
 =?utf-8?B?VzZReUpFS1lpbVh1UlRJQng4OFhxU0tJTmlERFRwQ1ptSzdVcW5kYm1qUkNV?=
 =?utf-8?B?M3pCODNiSlU4NXVwamNRNm40N01BQjE1WVpHZnFFSVljNWJGTjROY1h4bTA1?=
 =?utf-8?B?YmVjS212dENmSHRNUWIvbUN1azdvY1YxUktaK2pESnZTclBaRGRDWDRXZUVI?=
 =?utf-8?B?VnAwc21oeTNNdkh6b0F5N1VOLzNkcmcyUWJmczVPVWppZERucDM5MThvRnZS?=
 =?utf-8?B?QlplVTUrV2RSbEY3OGpJYWt2MTJTVEZsQzNVMkdCeStiZHFJWDl5ZVF0dnZQ?=
 =?utf-8?B?RkRVM2xnb0RzK0FMS0RNWDFoUGRYRi8wMHc1TFFncXkvM0p3NEFvTG0zRWhv?=
 =?utf-8?B?ZU9UK093cm1ZZUVuQ0p0aDdBQ3IzWHNkdE5DR3BCRUVGY1RUTUFOSkQxUWhn?=
 =?utf-8?B?Q3dtMnorOCtvWVdIWXg1eHdKR3QxN0M3TWR6Rzl4MitoNDRrOXRkUUpPVlZq?=
 =?utf-8?B?ak04MmhJS3FicFBIdi9RVlVqZHBSS0dYNFl5WjcxcDNEaDJiMXRuMFpOblVw?=
 =?utf-8?B?NmV0S0g1K3pQekpWUGxvSDJpamxCYmVOUE03aUovV2s0ZThza3NzUXBrRThH?=
 =?utf-8?B?UlFxb0tadlRyd3lPbm9IN0xoK2xyQk96aXlIZThKRHJaUkNndHVObkRqVktJ?=
 =?utf-8?B?MGtNRVVyS2tKS3krNG9pMDF6UHVGL1VCcyt1UDVZRkN0RjVHMXJSMGhiOTB6?=
 =?utf-8?B?WnNRSXV4LzJZWkQwUHdrYk5sVVY5eS9zU3pWZHVyc2JRYjc1ejM5czMvS0M3?=
 =?utf-8?B?aDU3ME02Mjk4RnJCcGJqc0Jrc01HdWpqV1FaU0l2K00wZGhDdDJFYUpSUXZt?=
 =?utf-8?B?eUdMWWNUT0w1eWlPYzZUWFpnanNNREVabWltRzZ0YVBUY2tRN2ViRmVNSlZt?=
 =?utf-8?B?clBrMkdpSTZjS3ZoOFhXaU92R1dYOXJWUlM5VkQ1K05kVUhJczVtVDJMNTdD?=
 =?utf-8?B?K1pkQUNiMGtleEJKNDFhaWtkc3JkK3JZeUpDOHNRblRiY0M1emk1N20yQTZY?=
 =?utf-8?B?dUo5TjhUanF3NmV2U3RIK2NFcER5d3pzT09NQXZkR1VtYVJOc3FkOTJlVlB5?=
 =?utf-8?B?TG9tTElKZGNpV0dMcVBrZWI2Vk4yLzRrOG8zcXBWUjgySGFDZEdIQmRCckNk?=
 =?utf-8?B?Vm1MeFhuMkRlVnQwaHU1cldnY1BkTkdkeW0vL2lXQTUxZ0hCMHU3eVdhM0xU?=
 =?utf-8?B?MS9kQW9NV0lKOFhoSnUxSC9UYWFDMTZpVTh3YmZVZnVUSjhmTERtQUwxU2xo?=
 =?utf-8?B?eXNVOXBmcDZwZDhFa1h4TExJOVZ6czV1ZG8wL1ZZOVFidCtyd1FJVnp2QVlC?=
 =?utf-8?B?NVh2WlUvK1c0VjhzUXVrUjVFM211QUJFaGwxbmlaaTBzQ3lkYmpPTXJZcHYr?=
 =?utf-8?B?VkpyblA0S3BLSmo1REF6VnpFR3lSK3lvTld5V0pDcUFaMEZSeG5CaWhUbkR6?=
 =?utf-8?B?UFlSNzlRUnM2ZjQyV0JjaTgrR052YWY1ak1ZTmNKV2IzNnVEU1FjL21VRkRB?=
 =?utf-8?B?UlBSNXJ5WFlxNTd1dUhPUXhkZnd0UXdLcDF1bW9hNjk1RGd1dzVyZ25YK1ZR?=
 =?utf-8?B?dUlTbDRKMndUa1NMcDYzT0V2WHhxZWZXak9WZ1QzelNmQjMvUFNHUndEQW1z?=
 =?utf-8?B?bE5vU0I0M2JPbmZyMFVNL0t4aUdPS1BQcURkYTdGdUdsczZzVDdJUkZ2SkZh?=
 =?utf-8?Q?iTJdVbgGNz0qI5iSIk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ced946e-5782-4519-86ee-08deb0f7cbc5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:59:05.9592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blZXelDj6YCGm+izSywPEc+rHUDnCaxqSaJoUIMzZ3des+//pVGjvfpCk2I4c1OT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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



On 5/13/26 12:47, David Rosca wrote:
> Userspace patches:
> 
> * radeonsi NV_timeline_semaphore
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37335
> 
> * RADV user queues
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808
> 
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 47 +++++++++++++++----
>  include/uapi/drm/amdgpu_drm.h                 |  5 ++
>  2 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c0d68863fa17..66c5fbba83f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -460,9 +460,10 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  
>  	struct drm_gem_object **gobj_write, **gobj_read;
>  	u32 *syncobj_handles, num_syncobj_handles;
> +	u64 *syncobj_points = NULL;
>  	struct amdgpu_usermode_queue *queue;
>  	struct amdgpu_userq_fence *fence;
> -	struct drm_syncobj **syncobj;
> +	struct amdgpu_cs_post_dep *syncobj;

We should probably rename the structure since this is no longer part of the kernel queue CS IOCTL.

Apart from that looks good to me.

Regards,
Christian.

>  	struct drm_exec exec;
>  	void __user *ptr;
>  	int r, i, entry;
> @@ -482,19 +483,38 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	if (IS_ERR(syncobj_handles))
>  		return PTR_ERR(syncobj_handles);
>  
> +	if (args->syncobj_points) {
> +		ptr = u64_to_user_ptr(args->syncobj_points);
> +		syncobj_points = memdup_array_user(ptr, num_syncobj_handles,
> +					    sizeof(u64));
> +		if (IS_ERR(syncobj_points)) {
> +			r = PTR_ERR(syncobj_points);
> +			goto free_syncobj_handles;
> +		}
> +	}
> +
>  	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>  				GFP_KERNEL);
>  	if (!syncobj) {
>  		r = -ENOMEM;
> -		goto free_syncobj_handles;
> +		goto free_syncobj_points;
>  	}
>  
>  	for (entry = 0; entry < num_syncobj_handles; entry++) {
> -		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
> -		if (!syncobj[entry]) {
> +		syncobj[entry].chain = NULL;
> +		syncobj[entry].syncobj = drm_syncobj_find(filp, syncobj_handles[entry]);
> +		if (!syncobj[entry].syncobj) {
>  			r = -ENOENT;
>  			goto free_syncobj;
>  		}
> +		if (syncobj_points && syncobj_points[entry]) {
> +			syncobj[entry].point = syncobj_points[entry];
> +			syncobj[entry].chain = dma_fence_chain_alloc();
> +			if (!syncobj[entry].chain) {
> +				r = -ENOMEM;
> +				goto free_syncobj;
> +			}
> +		}
>  	}
>  
>  	ptr = u64_to_user_ptr(args->bo_read_handles);
> @@ -561,8 +581,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>  				   DMA_RESV_USAGE_WRITE);
>  
> -	for (i = 0; i < num_syncobj_handles; i++)
> -		drm_syncobj_replace_fence(syncobj[i], &fence->base);
> +	for (i = 0; i < num_syncobj_handles; i++) {
> +		if (syncobj[i].chain) {
> +			drm_syncobj_add_point(syncobj[i].syncobj, syncobj[i].chain,
> +					   &fence->base, syncobj[i].point);
> +			syncobj[i].chain = NULL;
> +		} else {
> +			drm_syncobj_replace_fence(syncobj[i].syncobj, &fence->base);
> +		}
> +	}
>  
>  exec_fini:
>  	/* drop the reference acquired in fence creation function */
> @@ -580,9 +607,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		drm_gem_object_put(gobj_read[i]);
>  	kvfree(gobj_read);
>  free_syncobj:
> -	while (entry-- > 0)
> -		drm_syncobj_put(syncobj[entry]);
> +	while (entry-- > 0) {
> +		drm_syncobj_put(syncobj[entry].syncobj);
> +		dma_fence_chain_free(syncobj[entry].chain);
> +	}
>  	kfree(syncobj);
> +free_syncobj_points:
> +	kfree(syncobj_points);
>  free_syncobj_handles:
>  	kfree(syncobj_handles);
>  
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..ad643b41982c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -502,6 +502,11 @@ struct drm_amdgpu_userq_signal {
>  	 * @bo_write_handles.
>  	 */
>  	__u32	num_bo_write_handles;
> +	/**
> +	 * @syncobj_points: The list of syncobj points submitted by the user queue job
> +	 * for the corresponding @syncobj_handles.
> +	 */
> +	__u64	syncobj_points;
>  };
>  
>  struct drm_amdgpu_userq_fence_info {

