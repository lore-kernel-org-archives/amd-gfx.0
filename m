Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9B2CD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B947C10FD7B;
	Fri, 29 May 2026 11:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bq3XoJ1Y";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44ECE10FD88
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr6D8aPFb68ZmgoD9pcZfOPEDWjMClNJxwS0AWe37Kc0ZA7Rrd1QdGbQSijxabe4fKokEdSIZcT0lhA0cCmSh7tmr+jKdcQis7tOS2d72SP9XpqcXfVOUNyrFR3WEDUGmV8CuOQMKYJWtyLh58a0xCTBPlt8Idt3brgo5e/BD+DAkjfYNEwBvcZh2zlwWxjkETIlab3+WEKbrOVyWs5W4OUB5Jv3yBLQ3YXcVMif1jY1ahm9/kEaqM/J9RIR9L5zFYpzD99ju1NEcmT1Xno5+LEkcfM/bE6sEWPiklOpQlWTQ95sFMDkVHw8NS4bP9LRUNj3D5jo3p/LgPnmTtX3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLeKqXOhP+V7xhkWwrdGa4oKu6p6e5bqhsQ5SGe296E=;
 b=jlGlajUw06cVFxptALE2kJDkRqqeaFVOjbWrWWe3O3RLdALca8asUjna3ZZ9dpeucSMMYWbXKbgS0oUtizepNU/czLUFAG0wFEUKy/gGAhqaVa5KdZcQ5imMq8aka63Wik95Frj8yWQLg2z6I34BO3Oh5/TLcVAOu1Ex19BNqNx3YbaYOmO3zpJyAJ6SwGERwLE2Ps4rUIebDoEg66L52KdsvOjiPox3iLa2IfA+A8BLwc9pcUbON8SiAERF29mXaTjGROEd8I1EYnVNuWNowlGVVeOi+fQI1EA9UgGUC3V1jFyAP7WVY3G4aBoDxH1unbXy2NgootVjZG08EhEeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLeKqXOhP+V7xhkWwrdGa4oKu6p6e5bqhsQ5SGe296E=;
 b=bq3XoJ1YiNKjESrr/Mq9MMhZQZicfxVSF5H8CM4CjUTUjQ7U2qcQNrdLt6BIIcdBL0U5gJ4EhWiJ8bPaMIJPyD5nDSCURg/1GK1kGIx0oacstGxhC8c6M78OxgwZTTcn9+V2/TqVl/rNYR33SwJfQy/Zhv0emQhZpdAC3L6fZHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 11:09:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 11:09:18 +0000
Message-ID: <3d9842cd-c105-4e0a-8532-c499e9dd5a65@amd.com>
Date: Fri, 29 May 2026 13:09:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Only set bo->moved when the BO was
 actually moved
To: Natalie Vock <natalie.vock@gmx.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260528150047.78576-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260528150047.78576-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:208:52d::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dccd743-88aa-404a-c707-08debd72ba1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wYNcaMGfGvzToMkx7NBCQ0Rn+CL7PtZ6JWsZzfgOwKleMW++Ooar1rJ2dlIOQ9un9Ce6HQDpC0EskQnqft4RlZfVsiNkJuWzzapaLOZLMPfMvYL8xvgqP+Y48piJ7mmGmNNKEb77wa+3oUCLmtb19cTXG8rGBBXya1D0E+na+vYV0j4RbB1CUHXRDXYh5y9QkCXpGAHN2okbH4H+AFb+AIXrTFoMyUYLBn8tW8YyTgdcDMg9x84rJ7rMQpOr4FpCxU4rvSzTBoM/fudwL62K8tRzesFl1R2WSZGpTLk+cCKn3Uh4F1FAfe5XzBxlZh4wLOOKlxqE9dZhPkUUm3t6IfVfxZL7HB3AdIQTBa5LNQRuWGxqZ4mF1w6yXymV0W5XQmzkas2WkJp5W6qJv16coKAXo0bWnhRLuvMl1Kk0sd33KUcuytktvnoNmN+tHUSrDrFJDqcOOUflI0EA//uDA5pRKqmntFN1QHkiFVJqSkUnbtrFPxDEhm/a6FrxQcdMSjCQyOeIb/k5JEclw5+mkz+fAE400rlRJbe2BkjU1cP747jhrpseeIJIXnZyFwkrLZELYEM5E3n72fr+AwlF1EYO6ihEzMrTLRllpdQZtIZcMEq640noz5GbTK9HjaBEVeGxH4y/fVwg4n4k6J2tRtYYyrIGRcrFApRtgLQyF9NEiW9vXBS3yyeD2gQjcdWKxA3Q1YE4728Nhc+/GFbewQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QURaamhLS1NwL011WTVMQlYxWWxZcjF2WnhXK2VWV0l3YktLdzJIcitZTkZQ?=
 =?utf-8?B?Z01nNHplamdOeTB1UHFFRTNURGh3VUdoQ3k4ekJ6bSswazJDOExxbm4ramFj?=
 =?utf-8?B?bEVLckZkN0E0WUJ3RW5VR2J6V1cvTXc5N2ZwN1pQdGJ0TlN1SVdhVFlxMDc4?=
 =?utf-8?B?ZzJZZTNGcnJnYmd2ZTc4Z3NYTlJmYWNUaFYyZEE0bTJzVTVwVHNYWXpWSTNY?=
 =?utf-8?B?ckVxZzlUZHBOdVVpU1VJV0Z1OHpRQWVBWWxGeWxsZnRsQUxlcGZoSHRPNGNN?=
 =?utf-8?B?T0d2a2VFeW5hT3JVczkrTHVUejM3Z2hHcEdHUVdoMERCVW91dnZWTTlUNkxB?=
 =?utf-8?B?RXl5R1g1Y3NxRDlnNFZDcUJXa0pGREp1dzhINW9RbzZ6TlpBV0srdEh3b2F5?=
 =?utf-8?B?SlJDV0ptbVNGTStRdHdhcTY5UWMycVJ6bERaWUQ0bFJSR21pYTdLcTlhRnJX?=
 =?utf-8?B?dS85LzhnaFd6NnRyMjV6c3NtRmxEVUJBcFBPOHRYb0JzbnFWWVE0ajNMU2Jj?=
 =?utf-8?B?SVpWcVIvNHBRN3JBT3Bxd01JcmFPUXRYRllYYlVWcndQN1BkS0Q2ZkhCamFm?=
 =?utf-8?B?NTNQK2F6T1J3ajRVSlZrTUdDcUxUazI2NzVJVFpQekFFVy8vblQxMmdOdmRl?=
 =?utf-8?B?alBKVDVwODFHdTM0bHc2dW1EWmpRMVAwNEcwOEFVcWVNRFpENG1LL3FLMG5P?=
 =?utf-8?B?aUVWSVZBUEdlT1BTSjR3SmhIMkdrR2h6SXYxM3pIbmZyOWFneVRvdEtCNGtT?=
 =?utf-8?B?Ym1RWWVEZ0VWWExxbFlaWVFGM21DNWFQOWNsQXJoZGtTWnV1RkJzOGFreXRH?=
 =?utf-8?B?M2NtTFF1V1hoUVpYa2oyeXN0eFJqeUVFaXQ2WFZUaGRJQm5nQWJaOEFJN2My?=
 =?utf-8?B?QzBiaG55eGpoNDZ2S1FUa1lVa0UxdkhxSTJ1cnJHakhNenEwWHFpMU1Zbm8v?=
 =?utf-8?B?SFBSNTJTaTFoRm5JeHd5YldNSFJCTnZ1aS9rVjIzbjFzUkpndSt3RUFtVmFu?=
 =?utf-8?B?MHBIN09GVk9EaFRHV2NuRmc0ZCtwalZZcmNYZ3RVVUpWZk1mN2QvU1c2anVk?=
 =?utf-8?B?LzNFWmNBNzFnMVA2OG4zNmNjbmxKbjZlRDgrcWVZZGZnaUlGN29yOE8vWmdi?=
 =?utf-8?B?bTMvSjZTaUdOSWNVeHdmVGRXQm1ieGNKUmkzZUJqM2Q5S3lUWGV6bGx5WjI3?=
 =?utf-8?B?NTRhRmRDbFJEZkhtUk1iTHo0dHorUUJKaGlqYjV0YmpnS1dqSi9KTElSVFdv?=
 =?utf-8?B?M0dZKzFWK2p3cnFydmRjb3A2TEMvbTFESW5DVTduOXR2TW0wWUpjNWY1TVlW?=
 =?utf-8?B?RGJOQ0Nhck5UNXg5MU5RRzdBOGw4Y3BtOStlbGJWQTREYjY1Ym9oVS9PakND?=
 =?utf-8?B?L29haG56WFlRYkFTeU5jamZOK2R0alVDcjFIYVJreVdXWFRxR0t0a05DTFRI?=
 =?utf-8?B?Uml4MWlyOC9WMEVvcHY4bWdJeVIzS20vdjlqUXhmRjZieWMrMWZ6UDdIam5T?=
 =?utf-8?B?ZXp2NTB5THpGaDVnaE1Tek5Sbllxalh0SHhDL0diaVQxWmNWcFUzM0d3MEZ3?=
 =?utf-8?B?VmVMQTFyeHRyNjdFWFBnelB6STJJa0d4TENFZG9TK2p0NnNKYWgwSkNOSk9F?=
 =?utf-8?B?SXU3SHZVUzYzWFYzSFNvTVFpTlQvUXNaeWR2RU83VlJoV3VJeEFTMlMzdFhG?=
 =?utf-8?B?cE16V28xOHVVMUdvTkdMR0diczJGR0tDSzBxVWFCVmRHS2FjSVI0aWJoeTRo?=
 =?utf-8?B?bEwwMHBWaUdKMldPMlFhYXAySE9GTkJtOXV3ZTFxM0xZM2pnNWlMc2F1S2NE?=
 =?utf-8?B?cEMzZWlsTFd2c0Jqc3pNOGVObDFHWWxLWExuSlBMVHVsMU1BVTVkM2pFcGcy?=
 =?utf-8?B?bURya1Z4YXJJcDh1M3hvLzUzc1VUVHVuZ3FJWHU4bkRhK1VuSUJSdEJ0Ym1t?=
 =?utf-8?B?REw1TlhIVXZPN2dxTGF6M2JmVytIYThVazkvdjI0UHRkZFM5VEJVN2ZNTTZK?=
 =?utf-8?B?a0sxYlRWVW5mTHQvQ3k5VlJPMEcwZ1I0WHJVNTdwd204cFVpODljeENrejBL?=
 =?utf-8?B?VzhJVU1YSWc1UXo4aC9jS1dwZEhac3lsNVEzclV1QytwK3Z0MkRXN1grdktk?=
 =?utf-8?B?cGNKc1htc0VNT3BGejY1LzhNd3c3TmNaN3FVeWJtWFVCNkRGTG8wVDlsRnFr?=
 =?utf-8?B?bE1aVmwzQzhCMzAzNEwwc1NzcHF2QnE3SVhWNXpwcXBuOXAyc2hVcE9aRFFU?=
 =?utf-8?B?U3pjbjVCMHRrU2kydHJVM0hYL29scG83UGQ2aEJzeDZuczZ1aFZYZzM5akdw?=
 =?utf-8?Q?dvNzIjal38dIey3zYP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dccd743-88aa-404a-c707-08debd72ba1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 11:09:18.1600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZG2Hx69erGldP6Y+68XsHKPRO3+kWvlSPcRxlz7sCne5qPgamvBbLegNtVPcUwfv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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

On 5/28/26 17:00, Natalie Vock wrote:
> The "moved" VM state is a bit unfortunately named, because BOs can end
> up in this state without being physically moved. While we need to
> invalidate every mapping when BOs are physically moved, in some other
> cases like PRT binds/unbinds there is no need to refresh mappings except
> those affected by the bind.
> 
> Full invalidation of all BO mappings manifested as severe regressions in
> PRT bind performance, which this patch fixes. The offending patch is
> 53f0235c0284 ("drm/amdgpu: restructure VM state machine v4") in the
> amd-staging-drm-next tree, although it has not yet propagated anywhere
> else.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index beaf0aef6f474..05064a9c9f9f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -232,7 +232,6 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  		vm_bo->moved = false;
>  		list_move(&vm_bo->vm_status, &lists->idle);
>  	} else {
> -		vm_bo->moved = true;
>  		list_move(&vm_bo->vm_status, &lists->moved);
>  	}
>  	amdgpu_vm_bo_unlock_lists(vm_bo);
> @@ -2280,6 +2279,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>  
>  		if (bo_base->moved)
>  			continue;
> +		bo_base->moved = true;

Please add that before all the amdgpu_vm_bo_moved() calls in amdgpu_vm_validate() as well.

Apart from that looks good to me,
Christian.

>  		amdgpu_vm_bo_moved(bo_base);
>  	}
>  }

