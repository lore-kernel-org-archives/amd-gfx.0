Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D924ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 17:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9300210E4F2;
	Fri, 16 Sep 2022 17:45:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202C010E4F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 17:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjY+/9jvta4xXEBetzAz8ZLCWtxEdWwKC7j4k6DSxhk1JRiZC4ZO9LgPVlrFVs8gk4HhNAgcs3FkDbp1G8T8vb6EmZQufzj5ct+P5hUv0DM+UY3C0eIpj4LpklhhJ106lxgqy6T9U3Rtie/GYa5rnT6D8lx8lU5UG0j8ASZ8RLN3iFDiYmjC/AhxgV7cquSDaLd+GaegHL4U7WEe6WtZzA9fvuEnD5J0F9Dbac0jdt3nDqHj8N2QqA+zNCRzqsekdzdxEhj5MN/AU8wWUSTHTIbuaBs91PS2Jahm5FFnMkjfsmI8bDPpuz8wf62FBFZiVZUBmc1XuvWfg/MYpQiNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a+g/HDhy82t1E6VrEHHmDEzUCnue0YzDxGyETv/JTM=;
 b=L19eGSF78nKH+9XuynKyPlKgpBsPCLf84FNuJppVmVUVDbl05rHpSfsgFwyDksFbEltuczaQABkqdyk0FYlbp6G9raRjDA4U7DHTisqknD3wtnSUd+19r+QYTKRCQa/PO45GMr3BVy0n1DbxsivINRFmEyezLqHQWdCgzTX8tz+ZCHZgK6am8s11LDZFwEwHmyQXinaHPaAXUopfBZD2UpHuhOclSqbg9NIKBy6KAcn/hL1veBLecrMKfg/GKD5kVWBsDDIda2FYB3MXEU0Oiy6BluTzKXoAgSWN/nKQaG3Ay1IGZ9dDZSDyG74ljrexNBaY3548uNcCcAmqzeWDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a+g/HDhy82t1E6VrEHHmDEzUCnue0YzDxGyETv/JTM=;
 b=sxNGSe6mtwIKmAlzT+2naz1Uaz6h+XGYdJhk23QLxGoQbAwUgzbqp743hjBvsYb7vmJ+p6WSHxKUv4S4OCkEPaJXfhXA5wV9SuHCl58fURIdjq/QrbH4gmvLxyZu8CYTJw8kue7Skqc/c6BFFx6y3XEsa+TBI3QrdRwHQbeyyPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Fri, 16 Sep
 2022 17:45:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 17:45:24 +0000
Message-ID: <49aa9c3d-6e49-49a7-ec0a-d4d0ea988a86@amd.com>
Date: Fri, 16 Sep 2022 19:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] drm/amdgpu: Rename vm invalidate lock to status_lock
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220916150510.31321-1-Philip.Yang@amd.com>
 <20220916150510.31321-2-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220916150510.31321-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5841b0-b492-42c9-52d7-08da980b3be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwAOifF6QVR7SW2QETiQgebZAbkAQ5N210IkjY4CftmL331f6LR+5RHtpjqfb3XjgrWwh85ZzCJo5DkLOXq5lA7cNGXFyg4UR4lxeU/gwOEp7V81sNDdfhi8TVGUMll66Znj3D49TqRaHVl+3TauaAJIOj8dXbMNrQgJQXKJDP1LdWaNmVAazq8//n9/FR0b7133w43g2u65oqIk06yBKnJAZ68gvp47J38U23U4DosPA3qn0I5JPjAOmQQbDMLo+lqsWLVwB5RnlCYA+gm2YXd/rnLDFg6z9L6WXWSWr8eAowwfTcbSe9tNvX1BQh46g3v/Lzgy9hrEO4pBp0F47f5VHUxVgbaURQtGyE5duVJeG/9M6tfoGrPmGOUZ5mWPVMpzWQmhZOf/zkgML3FMBf6llP/2yeAwO9EFrvtSkJ3gW/40HCT3+nTirPfAmTDVImUL3eYTOO3Qx7T2NIvt5wNeefvJ1+Grgq6gv9AZYxo6DXtA7lKcJ04l9Z+56B6bl2ZXOTPtLZv7y2JHVJvoO0qcsOdHhiCZKgFVutGpitUY6mR1+ncV5zXIUj6AiCdtWVab6y/sdBR37Cq2huzOJeMcBRL8yG4RNo3yiYEOHJVq7XsR1pSBAmKYcG1ZvrCdoF9A0LZLMII8dIP4oarxeFw9wwZP16HMka1+i5WjH2y7z1Yj/n82QI4sM+tl5Ldb+tkXjYizYJFmje0rPIYAQ3RhTRiSq2+QtAynFJeSpXIof7Xdno7lg+oRlbjlTYtX8MSjJVQuO8Dr/5r97v6x3O3Nk53/Wn3qtHQ7W23sbmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(38100700002)(86362001)(31696002)(31686004)(36756003)(83380400001)(66574015)(6512007)(2906002)(186003)(478600001)(41300700001)(6486002)(6506007)(2616005)(6666004)(66556008)(316002)(66946007)(8676002)(5660300002)(8936002)(4326008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3RzTW9zK0dtMUNZbE80aGExclNSTjNzWE55RWF1dEJiR3pmcG9abEVqdVBE?=
 =?utf-8?B?NUUvYVhqRlRnclA3aUVHSkRqWCt3dE5GTGNsbkRncytZeDlIMTRUTUJKcXpt?=
 =?utf-8?B?c2hJSWdGalJ2SStNUmRNT3ZJZVVuY2g1ZDRiOENaOUxreWhpckdxUUxsaUcy?=
 =?utf-8?B?RnduSzdJbzJnK1FzVThrZE82U0xYOVc4bDErVG9tWnNLVUcwbE1MUFJkOTBi?=
 =?utf-8?B?SWhzSzZ0czJCclBXckhQRXNmbnc1d0xGdC9xcHBzd3JSQklRYXVvZDJXRTJm?=
 =?utf-8?B?Wktkd0o3Q1hmUDRaU3AvWkZFdWVtMkxBckRHMXkzeW1HY080VGRGQ2FFcEhj?=
 =?utf-8?B?Wjgya0pMTzhqd2gwZmNIQ3FtR05HK1ZuMWEyaHBMTE91RTBac3MrNzR5R2xB?=
 =?utf-8?B?YzJITXl2d2kwWTl3cXdiTG1FNnk1WEhaMXltaW9uQzhYU3I0bmluTTQ3dGZs?=
 =?utf-8?B?NVlVL3N0ZklmQURTckVRYVBOaHZMNEVhNW9qTjJ2Z05JbGFlVzkxQ1I4eExN?=
 =?utf-8?B?dW53UWZxSlE3K3lRRnJuOXIvdytkYUxnNEI5Uk9CQ0Y3MVFBZmZHd0RHeVho?=
 =?utf-8?B?c01EM0piZkM4QkpiMW9pKzZtYStzRHIzK0NHbXZGUU1kMHZsZkFjb2ZoRzM1?=
 =?utf-8?B?SFdwTDhlUk9mUWZvOUZuelU1Vy9QdmVLSjZyYVFFMW5oSFNkN0NPaE4vSEMv?=
 =?utf-8?B?WjBseEhqWnlPaHNTckNwKzVqdGE0d0YwdVFVVlJZU0JrVnIxYkdQMkUwc3hJ?=
 =?utf-8?B?SGtBVXY5aVJsb3RSYW5JTmtjdTRXMldMOE9ZY1NGWFRwamhRSlRteENtZ1Fo?=
 =?utf-8?B?TWZwSTZLd3YxY1BkMFdpZ2YxTnI3dFJLeVNHM2QwQng2LzhPbFhnTGduNGxV?=
 =?utf-8?B?amdTaXVQZXphMDZLelVLVkR5VFI4YnhBQ3NNUEdMZzZZbVhlajFjbFhYK29P?=
 =?utf-8?B?eUtRVmNMUXl1V29iLzYyQXExYlVYY3hGVTB2RWhZOHFtd0Y2THBURFdpajcw?=
 =?utf-8?B?dFo1S0RUVzI1ZENHbDdvVUpUdUUrSlYvMnEzTU5aNGFKSy9TU3prZ2xVSE53?=
 =?utf-8?B?NFlPMWl1TkZqRXR4QjRhN0tLWCtEQUxqSkRrZXJHa2h0WVBFZ1BRQUp6Ymd0?=
 =?utf-8?B?WjFIc0MzM014Q1BnNi96M2FTUmMwYzVHSEtkWjhBcHV3SVBNUVRscmZhU2t4?=
 =?utf-8?B?NFV3SmJ1QXBqcmZrYjN4YTlyTnJjOEZocVprbFNxdFBmQjQxakVBZ0tyd0Fz?=
 =?utf-8?B?aENVY1Z0SW9PMVowK2Q3dTJlT2xTWXl5Y09nMlZxRUR6OFhOR2I3Q1dWYTFv?=
 =?utf-8?B?TW5zSTMxMzVZcWNPWGpIV0pVSS82UHB6M0d2Y2puTmIrdU1pZFNXbUREdXZL?=
 =?utf-8?B?dEt1U2psVG9QZll0cHNRQjU3VmYzNWZ6RFRJSG5xSktMWk9wWFExKzhLakMv?=
 =?utf-8?B?R1pEQ25NR1RoRUxZU0k3TDNTSTJsaWhwYjFpdUNOcXQ4ZnhlR0R4Y3BrSWpl?=
 =?utf-8?B?dEg1VTV5bWd6ZTEzRmlYVWhjSlRFVXJHcnBCVGo4R1dHNmNTSWRPUE1BTXJy?=
 =?utf-8?B?ZlIyOWFyMEZLUUx3V0twT2UwajNrQjZkL3hjeldpQ0RER3IvUmlzQ1ZVeDJY?=
 =?utf-8?B?S1RHdlc1bktUMzJSeWYxOG9aUzdNV3FJTTNXcjI5TC9Ea0Jkbm1pYUJPVDJ2?=
 =?utf-8?B?c1ErejR2V2h6UlY5UUJhRXM3cDN1NFkrYmJaWW96QUdkVGxLNWw3blJPRHUv?=
 =?utf-8?B?SzFGbkVGYWtlTzY2VFEvTkgreVBvMTI4dTJ2SEpkdlhHbEh1Wk9QdXJNMS9x?=
 =?utf-8?B?dlU2QkVaR1VJRTQ5SWVPNHBCVU5Rc1h0RFdFcU9QQ25xWDVsWWJwU3dObEVV?=
 =?utf-8?B?TCtDSXN5VVZxZE00bEFSSjVmSHdSdjR1bWRobjdhcUh0cENnUlhjZEs5OTN4?=
 =?utf-8?B?RFRpNWxMbEVPZW5jYjVEbk9tOGxCNzB1ZHdwczQxNDF1WlJRTWdDSTJvSkNu?=
 =?utf-8?B?cGJIdFVRYXBUNmQzZEFXcDJaM2RvZ0xRc2kyL2RZbkxNaXJHY0xVNk14SjZZ?=
 =?utf-8?B?SG9IdXRLMENoZzlRNUcwem1xZUdWNzhIa3RacmdlUTdZajNyR1hJanpvTnVm?=
 =?utf-8?B?MXhkQTJYQnl5dVFDaFJMM3RJa3FXK1pJRWlwYmVOcVdkbmxqL3h2cmhtV2dN?=
 =?utf-8?Q?KbPL2pXZU4ymH2PC958oqjZfRbRsX7jWRv+SYCFGSjGd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5841b0-b492-42c9-52d7-08da980b3be2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 17:45:24.6065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq5dKABhNxivYaTjW9l/+BTUmDFxBrolemuINOTjJk83iELscpImYeVKTZOM65X9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 16.09.22 um 17:05 schrieb Philip Yang:
> The vm status_lock will be used to protect all vm status lists.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 30 +++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 +++-
>   2 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 690fd4f639f1..596f1ea8babc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -225,9 +225,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->invalidated_lock);
> +	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->invalidated_lock);
> +	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -256,9 +256,9 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->invalidated_lock);
> +	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->invalidated_lock);
> +	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -936,7 +936,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
>   				gtt_mem, cpu_mem);
>   	}
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
> @@ -949,7 +949,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
>   				gtt_mem, cpu_mem);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   }
>   /**
>    * amdgpu_vm_bo_update - update all BO mappings in the vm page table
> @@ -1290,12 +1290,12 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   			return r;
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>   					 base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->invalidated_lock);
> +		spin_unlock(&vm->status_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!amdgpu_vm_debug && dma_resv_trylock(resv))
> @@ -1310,9 +1310,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   
>   		if (!clear)
>   			dma_resv_unlock(resv);
> -		spin_lock(&vm->invalidated_lock);
> +		spin_lock(&vm->status_lock);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   
>   	return 0;
>   }
> @@ -1763,9 +1763,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2019,7 +2019,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	INIT_LIST_HEAD(&vm->moved);
>   	INIT_LIST_HEAD(&vm->idle);
>   	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->invalidated_lock);
> +	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
>   
> @@ -2584,7 +2584,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   	id = 0;
>   
>   	seq_puts(m, "\tInvalidated BOs:\n");
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
> @@ -2599,7 +2599,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   			continue;
>   		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   	total_done_objs = id;
>   
>   	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..98895c8fef6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -268,7 +268,9 @@ struct amdgpu_vm {
>   
>   	/* regular invalidated BOs, but not yet updated in the PT */
>   	struct list_head	invalidated;
> -	spinlock_t		invalidated_lock;
> +
> +	/* Lock to protect vm_bo add/del/move on all lists of vm */
> +	spinlock_t		status_lock;

Maybe move that field before all the list_head members. Otherwise 
somebody could think that the invalidated list is not protected.

Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

>   
>   	/* BO mappings freed, but not yet updated in the PT */
>   	struct list_head	freed;

