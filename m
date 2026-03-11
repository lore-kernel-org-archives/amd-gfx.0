Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F0FFD064D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 07:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692B210E36F;
	Wed, 11 Mar 2026 07:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x67DD0+J";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71EC10E36F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 07:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJzo6VyeOCCYBfrEI7VOhWqJQe7NiZ0rAayF/O04hnt/eTCdnU2IKRxUDtO5FSV1xmr1gG/g2ERqF5nhPDKp13z5g9T0OKK3uiIgbmPkItcq+tiwXnkiwspDFgWD6lZyj+zt5j+RhROuKrljYJfrGignF3YRylrxrGN4hXYPKk+cEwhyPR/0SVMR3jhvgLnYbCz8xocFBvGrtEdGYgrwQ6TkqUy+hTSrgkU9clT4h/FZHXeG/6JVAtB2+D3dZZA8bOmUhFQLEksuQ0GUuCB8XuCQE3Ff7H2OZ1GyeeiaogvXxsng0FYXbBp+wyeA+zCdvH6BH0PWVnbxV5EKDMqgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vjXF3B2gFyOuPQi3kR/6u+cAO1MzuyutMniIvmg1Xg=;
 b=egIlKr7hjr43QpuDnsI1rt+OmG90OeUM4bw0Q9BE9kd5paG23lD7Pulzk2PMq02MqpLlcvAVd3RYgAE4beAIzwb/K+XJp9x3vMFONrj/vx7Fg6rj1nNN1WDxUCqrOKpK640los+/Dm36oGYQTGZW7/tC4MGsHgHE86kJOHKMGowR5X94EnLQbJi+o3zR6ScJrXuyltIST8+ywpO5iQYe9dGWwGQbxec1IBqoiwkVrjTlyjPCc++DYzFwIpHc/z9xvhEdzNepRlvbXWepOo0K5vRJ/LzYM2J2VnHM9rHTRTRyNIN55mEYC0vTmGRnR4PmknpcbTgPBb0+oAvmtjtuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vjXF3B2gFyOuPQi3kR/6u+cAO1MzuyutMniIvmg1Xg=;
 b=x67DD0+JDNSk+9RSGrYtv1RKbQpZqgNRyrmXQCu44W/JSZ1yI1dRnGrIEn+L0GBZVvdxe0DeoVXqn/4w0mxVwRCnDUGG4KSxrNcuZnFvDUKYNt7zb/AuFo3DayVx5Bz3XBVYZdCsUC9sG7A8rCfjpxGmP+/8l1ph+kPWQrEUBms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 07:43:21 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 07:43:21 +0000
Message-ID: <9da5e092-a8da-4ce6-8776-258add4a9d22@amd.com>
Date: Wed, 11 Mar 2026 13:13:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/amdgpu: revert to old status lock handling v4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f66f90-9830-4f76-7014-08de7f41de86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 4ZvRS5Rrvc7gCLCHhgxr//xP+n+0Js6/mkJXvpkKuS82NrOcJKtdUtNLPyX9LUek/u2i2w7vIZ1e8CeAyWfK8ICEO8lVvIs1dlSbA3Y6WGKsdAzfpTYJxtdXI9K2mq9+OsHf1uWY4guL6eNyeHP/5BfFwaseGuI0Nv6UUkdeJEa/qAbifUPZTUlxH6ZB1EItkAnIQ63cZccDKvynsTWwYwwC2T6KZvY9exqT5L0O2jxP/LuwI86nP/2jQ3ncPwW3ysQVz3NX5gsTdBOSMFFrAfjSJvesD3T2foeSI/kMSqa3aOzQ2zqWT0LuMyVgsUrJvSHVoaROIM75UyMBvG/5UFDoDBc7P0r/tubU0fLYetWm8vRyjjHzY8MFQkLKX6a7R92dfQhgTjhVuiXaOes90Y0cQhJH9RzWLATNfzHOHTEVW/BgfnyLemn0+03KPp+bY8Ao0TvYWIlYLx7BO3PRKk8chHaYCyoeQ8MqRPSQTnZrBeO9VJoGH9UjqOVBbCfXZHsp1/5wWXV5uSimJ+tj4EJ4HeTH1/G9d7dsdGNeBdQAQzt1tHcdsfOwoqtKKGyoRAuoV3cAXYvOLxeNLshbdPinoj9TOj8f+5K6Fhx5gKFhi2PrBJ2MF4LjrVdrhdGnKQeD4M0R3tvon8smNMK4hndQjbTSvB4gT5VwKPlbTYA/f/mPN3USLzwo9vIAvdUd1HjiXOZNa558FE91N6XMA+34XOGZLFoizR2Qa0P4474=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0hEcUlIcXpKZ1BaU2pEcHoxTEpablcxNzE4WUJCRnhQQVlqYTlmKzB3ODE2?=
 =?utf-8?B?SmJ4N25JY2RrWER6dnhXT2FGejVRU2dnMEdVRTcxeDNJa3RRRlg0aTREdXda?=
 =?utf-8?B?aSt4Rmd1VzZvV3Foc0owSzVpUXJKdnJtYUlRYXpGbkVOdkZmUk9kQnF4eksy?=
 =?utf-8?B?cXcrdGd1SzM1UmROWWdrdFRQWG5NUUt6K2RPU2VTUjJuNXBtREZrNStxODB1?=
 =?utf-8?B?Y01nYmFKUFBMZ0F0YU9ac0w5NFBYNHVMUmtJaDdJRzk3ZzRZVGJOMGU3d2Yw?=
 =?utf-8?B?L3F2RTc5Y1k4RlhtbnozT3JFZklEK01UTTkvbng2cUpjSEl2T0p0dDdYOU1y?=
 =?utf-8?B?OUQxZjJoU0pVYmN3dTZmSlVKWXArdm1sRnBzRm1Ea3hURFh3S28vZzZKMTVi?=
 =?utf-8?B?ckRkc251eTNDM3FubHJNYUhRUkpYNzU5NERNaGdyQmtqL1IrWTdVWlNiMG9h?=
 =?utf-8?B?MXIxN09td01mTHlrczlxd3h3blJyMU1WL3N2LzlnMjRZY0JTWWpSSEwwYkxG?=
 =?utf-8?B?enBnVmd6MFZsalVoa2tiek4rZHlxSDJyNVZEeWhuM2wzeXhGU0huZ1NqUWJU?=
 =?utf-8?B?U3NKamdBQmVhUFFFeWpMam1GZFg4QlI0SzRYaGMvSG1iejJ2UVUrb3ZBbGIw?=
 =?utf-8?B?cTlwQnVMeEV1TURDY2FOSGNjYTJEaS9UNStqZy83ZlhwZSsyY2s3M0VibDlM?=
 =?utf-8?B?QXd0UHpzaXZPM0d6c0ZtSlYrM1krMXNrT3dBSE9HKysxdzZmZjNuamtXUmdB?=
 =?utf-8?B?cnp3VzViOVN4VjJtc1NBQWcvMnNhSjVtRjN6cnBFYmpTenY1TXpqbXhtT3E1?=
 =?utf-8?B?bW1MVlRqMjNHRVZtS0h6ekRuY1VWLzBUa2dSeEE4WVVYUEYyamRIQlJwY29L?=
 =?utf-8?B?OXpOZGE5NmsreFN6QWg0M1R2WlJSMkQweDZQK1RrZktUaGxZdUY1V1ZnaWpx?=
 =?utf-8?B?V28wblVweWxRN2xjV3hiN3RWTktDY3hZSHVCaFFwamp1K21WUnpxeFVyTlVz?=
 =?utf-8?B?eXQreTVobE94V1ZPUTJzQ1kzai93Vjg4WHZpSFhCQlV5aWRxYmJrL0dWRys2?=
 =?utf-8?B?YnZuUmMyV01iUWJjSGd5eTZGY2oxVVBRRmVkS0VXcW1UMFFZaGlXUElFSFc4?=
 =?utf-8?B?WGczV0NwK1k1QTZjbXBIVFd2UW5OWWpodjVHTmtSSCtWZVVvMDdEUFZ0ZEYx?=
 =?utf-8?B?QmM0MDI5OHR0NjVXRVAvdi9WQjRTSnZ2SmJJSTNRUlVSYUhHOHRkbys1ZVJ4?=
 =?utf-8?B?NmcxNmJqd2k2YkRqemZ2VUlSVDM1S2gvK0hyQk41RWZJM1NPSmtQVVV5Nytj?=
 =?utf-8?B?WHdGbEtmM0FQUExRdms3ZGYyQWtYQVVUSlRIVmhaWEtLaytjWFRnL1Q3S0Zn?=
 =?utf-8?B?RGY2ZFl4bHQ2QVVqQ3JkcG9Nd2txYTIyS0JaN2tSNnhyN3pxUUk0VlMzVVZE?=
 =?utf-8?B?dWhEc2pmeWN3dTdJUWorY2dITUJIb3RPZy9IZVBSUnZjNnY4U2tFcWMzbFpF?=
 =?utf-8?B?Szc1VkV5UnZyNTRkQkNHK0JmSDNxcXZGSTljOG5TSDF6TEZwL1RCUTBKVmlN?=
 =?utf-8?B?TGk2WWUzTzFhMTFpYys2cTlzRmhmaUZsb3Q2UE00a0xrSUZtQmNwbzVlb2tw?=
 =?utf-8?B?Nm10ZmJqMmczMjBLOHpmeUFYT3pycTRiRTNCNGx5aFl1cWJDRHJEcUllZTQ0?=
 =?utf-8?B?bXFHQTdqcHBxWFNpMndJd3g0QzBrdUMrdDEzbW5jODBYNCtZcEJ0dDRkQU5p?=
 =?utf-8?B?QmErNkhZS04xZWwwTzg5L0wySW9FTGxoU0xLT2l6dXVqTDhyZ295a0dhUENl?=
 =?utf-8?B?aWVDTEtJSXpqZU9uYzlRam9FUG4wM2lib3ZxYUdFbDdJVC8vb21WNmI5VzI3?=
 =?utf-8?B?MEs3VDBhM2pxeHdvTDJieFQySUV4TG1oU05DeGdpODJTSG10VnVENkJOdHRB?=
 =?utf-8?B?cnVaa2ZFN1dBR09RT0JnU2lyQ3o0Vlc1UnF3Y3ZzQis5bE94MWoySE1CNkVH?=
 =?utf-8?B?dC9WWng3ZTVSam5CZ1c4RjY5ci9KMllJSU9ZNVJIQWdKZDFIYmdHVDloZEdC?=
 =?utf-8?B?SlYvaFIxVk5NTUM1dURIL1NoVm9tak1iUG1QbVNNd08vR0VkRk1IcWdqV0Vk?=
 =?utf-8?B?d1NmM3N1WUpqaXJGUlRlZ29xM1RoRHZIaVkxN1F1dk91a0Y4THFNVFJUbUJk?=
 =?utf-8?B?bG5mT2RHMk8wV0V6SkxMcWJCc2w0c2M5RUdlZSt4TmUwNzhrd1NrT3A1N2lL?=
 =?utf-8?B?ZmFTSUJQNGpiUWpPS2hMNmFRUUIxMDVkdWxnQlRQQnhvd28zMi9wQmt4WlFq?=
 =?utf-8?B?Q0JzaHhVSDZwdVBTUEdJRklZQmY1cDV6TTVQVlI4ZjFyZUVSNk53QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f66f90-9830-4f76-7014-08de7f41de86
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 07:43:21.7598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAuNShkRibXVLFbXzGRQz8Q06UTk1qFMPAbanQRqlx4jg1Y0f0CCuOhApqsJS5D3cU4pV6Z78uc45s0RV72fuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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


On 11-03-2026 12:43 am, Christian König wrote:
> It turned out that protecting the status of each bo_va with a
> spinlock was just hiding problems instead of solving them.
>
> Revert the whole approach, add a separate stats_lock and lockdep
> assertions that the correct reservation lock is held all over the place.
>
> This not only allows for better checks if a state transition is properly
> protected by a lock, but also switching back to using list macros to
> iterate over the state of lists protected by the dma_resv lock of the
> root PD.
>
> v2: re-add missing check
> v3: split into two patches
> v4: re-apply by fixing holding the VM lock at the right places.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 146 ++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>   4 files changed, 68 insertions(+), 105 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 50e1b342f22f..32541f1bde6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1040,12 +1040,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		bo = bo_va->base.bo;
>   		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -1062,9 +1062,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 01fef0e4f408..b89013a6aa0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -153,12 +153,10 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   
>   	vm_bo->moved = true;
>   	amdgpu_vm_assert_locked(vm);
> -	spin_lock(&vm_bo->vm->status_lock);
>   	if (bo->tbo.type == ttm_bo_type_kernel)
>   		list_move(&vm_bo->vm_status, &vm->evicted);
>   	else
>   		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   /**
>    * amdgpu_vm_bo_moved - vm_bo is moved
> @@ -171,9 +169,7 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -187,9 +183,7 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   	vm_bo->moved = false;
>   }
>   
> @@ -203,9 +197,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->status_lock);
> +	spin_lock(&vm_bo->vm->invalidated_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	spin_unlock(&vm_bo->vm->invalidated_lock);
>   }
>   
>   /**
> @@ -218,10 +212,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>   {
> +	amdgpu_vm_assert_locked(vm_bo->vm);
>   	vm_bo->moved = true;
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -235,13 +228,10 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>   static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	amdgpu_vm_assert_locked(vm_bo->vm);
> -	if (vm_bo->bo->parent) {
> -		spin_lock(&vm_bo->vm->status_lock);
> +	if (vm_bo->bo->parent)
>   		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -		spin_unlock(&vm_bo->vm->status_lock);
> -	} else {
> +	else
>   		amdgpu_vm_bo_idle(vm_bo);
> -	}
>   }
>   
>   /**
> @@ -255,9 +245,7 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -271,13 +259,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   {
>   	struct amdgpu_vm_bo_base *vm_bo, *tmp;
>   
> -	amdgpu_vm_assert_locked(vm);
> -
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	list_splice_init(&vm->done, &vm->invalidated);
>   	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>   		vm_bo->moved = true;
> +	spin_unlock(&vm->invalidated_lock);
>   
> +	amdgpu_vm_assert_locked(vm);
>   	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>   		struct amdgpu_bo *bo = vm_bo->bo;
>   
> @@ -287,14 +275,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   		else if (bo->parent)
>   			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>   	}
> -	spin_unlock(&vm->status_lock);
>   }
>   
>   /**
>    * amdgpu_vm_update_shared - helper to update shared memory stat
>    * @base: base structure for tracking BO usage in a VM
>    *
> - * Takes the vm status_lock and updates the shared memory stat. If the basic
> + * Takes the vm stats_lock and updates the shared memory stat. If the basic
>    * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
>    * as well.
>    */
> @@ -307,7 +294,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   	bool shared;
>   
>   	dma_resv_assert_held(bo->tbo.base.resv);
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	if (base->shared != shared) {
>   		base->shared = shared;
> @@ -319,7 +306,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   			vm->stats[bo_memtype].drm.private += size;
>   		}
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -344,11 +331,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
>    *        be bo->tbo.resource
>    * @sign: if we should add (+1) or subtract (-1) from the stat
>    *
> - * Caller need to have the vm status_lock held. Useful for when multiple update
> + * Caller need to have the vm stats_lock held. Useful for when multiple update
>    * need to happen at the same time.
>    */
>   static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
> -			    struct ttm_resource *res, int sign)
> +					  struct ttm_resource *res, int sign)
>   {
>   	struct amdgpu_vm *vm = base->vm;
>   	struct amdgpu_bo *bo = base->bo;
> @@ -372,7 +359,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>   		 */
>   		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>   			vm->stats[res_memtype].drm.purgeable += size;
> -		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
> +		if (!(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(res_memtype)))
>   			vm->stats[bo_memtype].evicted += size;
>   	}
>   }
> @@ -391,9 +379,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>   {
>   	struct amdgpu_vm *vm = base->vm;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	amdgpu_vm_update_stats_locked(base, res, sign);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -419,10 +407,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   
>   	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>   		return;
> @@ -481,25 +469,25 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>   	int ret;
>   
>   	/* We can only trust prev->next while holding the lock */
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_is_head(prev->next, &vm->done)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>   
>   		bo = bo_va->base.bo;
>   		if (bo) {
>   			amdgpu_bo_ref(bo);
> -			spin_unlock(&vm->status_lock);
> +			spin_unlock(&vm->invalidated_lock);
>   
>   			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
>   			amdgpu_bo_unref(&bo);
>   			if (unlikely(ret))
>   				return ret;
>   
> -			spin_lock(&vm->status_lock);
> +			spin_lock(&vm->invalidated_lock);
>   		}
>   		prev = prev->next;
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -595,7 +583,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       void *param)
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
> -	struct amdgpu_vm_bo_base *bo_base;
> +	struct amdgpu_vm_bo_base *bo_base, *tmp;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> @@ -608,13 +596,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			return r;
>   	}
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->evicted)) {
> -		bo_base = list_first_entry(&vm->evicted,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>   		bo = bo_base->bo;
>   
>   		r = validate(param, bo);
> @@ -627,26 +609,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>   			amdgpu_vm_bo_relocated(bo_base);
>   		}
> -		spin_lock(&vm->status_lock);
>   	}
> -	while (ticket && !list_empty(&vm->evicted_user)) {
> -		bo_base = list_first_entry(&vm->evicted_user,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
>   
> -		bo = bo_base->bo;
> -		dma_resv_assert_held(bo->tbo.base.resv);
> +	if (ticket) {
> +		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> +					 vm_status) {
> +			bo = bo_base->bo;
> +			dma_resv_assert_held(bo->tbo.base.resv);
>   
> -		r = validate(param, bo);
> -		if (r)
> -			return r;
> -
> -		amdgpu_vm_bo_invalidated(bo_base);
> +			r = validate(param, bo);
> +			if (r)
> +				return r;
>   
> -		spin_lock(&vm->status_lock);
> +			amdgpu_vm_bo_invalidated(bo_base);
> +		}
>   	}
> -	spin_unlock(&vm->status_lock);
>   
>   	amdgpu_vm_eviction_lock(vm);
>   	vm->evicting = false;
> @@ -675,9 +652,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	spin_lock(&vm->status_lock);
>   	ret &= list_empty(&vm->evicted);
> -	spin_unlock(&vm->status_lock);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -971,18 +946,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate)
>   {
>   	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_bo_base *entry, *tmp;
>   	bool flush_tlb_needed = false;
> -	LIST_HEAD(relocated);
>   	int r, idx;
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->relocated, &relocated);
> -	spin_unlock(&vm->status_lock);
> -
> -	if (list_empty(&relocated))
> +	if (list_empty(&vm->relocated))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -998,7 +968,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->relocated, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -1014,9 +984,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (flush_tlb_needed)
>   		atomic64_inc(&vm->tlb_seq);
>   
> -	while (!list_empty(&relocated)) {
> -		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
> -					 vm_status);
> +	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>   		amdgpu_vm_bo_idle(entry);
>   	}
>   
> @@ -1243,9 +1211,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -1612,29 +1580,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   			   struct amdgpu_vm *vm,
>   			   struct ww_acquire_ctx *ticket)
>   {
> -	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo_va *bo_va, *tmp;
>   	struct dma_resv *resv;
>   	bool clear, unlock;
>   	int r;
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->moved)) {
> -		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
> -					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
>   			return r;
> -		spin_lock(&vm->status_lock);
>   	}
>   
> +	spin_lock(&vm->invalidated_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>   					 base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->invalidated_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1666,9 +1629,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>   			amdgpu_vm_bo_evicted_user(&bo_va->base);
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->invalidated_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -2211,9 +2174,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->invalidated_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2321,10 +2284,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->stats_lock);
>   		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>   		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->stats_lock);
>   	}
>   
>   	amdgpu_vm_bo_invalidate(bo, evicted);
> @@ -2596,11 +2559,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	INIT_LIST_HEAD(&vm->relocated);
>   	INIT_LIST_HEAD(&vm->moved);
>   	INIT_LIST_HEAD(&vm->idle);
> +	spin_lock_init(&vm->invalidated_lock);
>   	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
> +	spin_lock_init(&vm->stats_lock);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
>   	if (r)
> @@ -3068,7 +3032,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	spin_lock(&vm->status_lock);
>   	seq_puts(m, "\tIdle BOs:\n");
>   	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>   		if (!bo_va->base.bo)
> @@ -3106,11 +3069,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   	id = 0;
>   
>   	seq_puts(m, "\tInvalidated BOs:\n");
> +	spin_lock(&vm->invalidated_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
>   		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
>   	}
> +	spin_unlock(&vm->invalidated_lock);
>   	total_invalidated_objs = id;
>   	id = 0;
>   
> @@ -3120,7 +3085,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   			continue;
>   		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>   	}
> -	spin_unlock(&vm->status_lock);
>   	total_done_objs = id;
>   
>   	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index dc4b0ec672ec..ae9449d5b00c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -205,11 +205,11 @@ struct amdgpu_vm_bo_base {
>   	/* protected by bo being reserved */
>   	struct amdgpu_vm_bo_base	*next;
>   
> -	/* protected by vm status_lock */
> +	/* protected by vm reservation and invalidated_lock */
>   	struct list_head		vm_status;
>   
>   	/* if the bo is counted as shared in mem stats
> -	 * protected by vm status_lock */
> +	 * protected by vm BO being reserved */
>   	bool				shared;
>   
>   	/* protected by the BO being reserved */
> @@ -345,10 +345,8 @@ struct amdgpu_vm {
>   	bool			evicting;
>   	unsigned int		saved_flags;
>   
> -	/* Lock to protect vm_bo add/del/move on all lists of vm */
> -	spinlock_t		status_lock;
> -
> -	/* Memory statistics for this vm, protected by status_lock */
> +	/* Memory statistics for this vm, protected by stats_lock */
> +	spinlock_t		stats_lock;
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
>   	/*
> @@ -356,6 +354,8 @@ struct amdgpu_vm {
>   	 * PDs, PTs or per VM BOs. The state transits are:
>   	 *
>   	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> +	 *
> +	 * Lists are protected by the root PD dma_resv lock.
>   	 */
>   
>   	/* Per-VM and PT BOs who needs a validation */
> @@ -376,7 +376,10 @@ struct amdgpu_vm {
>   	 * state transits are:
>   	 *
>   	 * evicted_user or invalidated -> done
> +	 *
> +	 * Lists are protected by the invalidated_lock.
>   	 */
> +	spinlock_t		invalidated_lock;
>   
>   	/* BOs for user mode queues that need a validation */
>   	struct list_head	evicted_user;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..7bdd664f0770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -544,9 +544,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	entry->bo->vm_bo = NULL;
>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>   
> -	spin_lock(&entry->vm->status_lock);
>   	list_del(&entry->vm_status);
> -	spin_unlock(&entry->vm->status_lock);
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> @@ -590,7 +588,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>   	struct amdgpu_vm_pt_cursor seek;
>   	struct amdgpu_vm_bo_base *entry;
>   
> -	spin_lock(&params->vm->status_lock);
>   	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
>   		if (entry && entry->bo)
>   			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
> @@ -598,7 +595,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>   
>   	/* enter start node now */
>   	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
> -	spin_unlock(&params->vm->status_lock);
>   }
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>   
>   /**
