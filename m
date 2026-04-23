Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26416F99362
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EF010F03A;
	Thu, 23 Apr 2026 10:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AeMyiOuW";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F243810E334
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESN42REZ7PD1J3mGjxiGEoeHgtDsM0Fo76QWaSmMXkyvduqSEVqDCxBGbHpqMjzNZyfkDeHzmuaLz1RJhDglwF1rtNvhp3+HfbRDSN67A+K5CIxtTb/6hoIOF7D1UpdjmGhN2HN0vtczpck82N13dxp/K/XfQ532H4Uclz/teFfhSSDfnWErtgA1me6wXy65sMcgtDGRsVf3NkEpZJDivhm4n8hm2Sr6LD2f9rkLTXwdKoKFYxP0d2SUINGLNs75a9L5+5CMEUoUJ2OlwoufqLb/tyVxsZywteYdF+6n8HFDrjozKzveK816YsaDiiD7JsIF5UmPGbibHm47BYxXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4BLeUl0YUenc7GbdDnUprWorbODQ2cJu3WyjCXKMFI=;
 b=lEa2nryjy/CpvmFHiDWihSmSaSuie1nqceEiMhRpKUP9s78yMx2ZvvlNyvnvlYGD4NNUnocuRidm7WbIfaJZI80UkY6Z6QHVhUZWdvASetY3b7dcoVdtsay3rOfTmTEMUdGc8mQ8wTWR1I0QdE9P6yV4B1v46q44700ajaeYWICcBxAg1nEtS6O5UlhPfDsHxZFYwI2Zg06JXd06/38uynA6jjMvm0j9EdsmujywlILSsFdDFw9rjtnZ08efvHyreDSuXBgvAb5w/OazPVNGQ7KKdidtJ57CYSfnS5pW/PuqWJ7KajmM5Qj17rSju08JM37iMrLdhLcDf/r2JAtpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4BLeUl0YUenc7GbdDnUprWorbODQ2cJu3WyjCXKMFI=;
 b=AeMyiOuWZO4WT5kqQRLeWp+SklvgVfmp2UL6oofyV6K1zAHCZRN6bfcov1FkTd0NEqlZMEq0t206n7/JcleckqCeIqhLIvhbmoEDSNylmOXCjo1z5rytfF3wnC2dnasegMESPrQPDHeTePEfEJ14LpttKi0gVLTx6usBmm+hBBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:45:44 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Thu, 23 Apr 2026
 10:45:43 +0000
Message-ID: <3cd5634b-e715-4e92-8e21-26758f790458@amd.com>
Date: Thu, 23 Apr 2026 16:15:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/amdgpu: revert to old status lock handling v4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-9-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-9-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab0cba5-b729-481a-e9bc-08dea1257820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 2JbphYNF5C6pPCC4IqOBm/XEaGHSCNaB4TNWdXRMWoC9xceK/LjQVNHCOLnr32Q5T3EbnNUd5+uGkToN38DSelz/lOuO9S9RO98xvvSYLBUZknkDfNL+m4AM0/zVCs4GIiYwG+97GvdnKxqPRCDOlO4fCGT1ZeJDI2t3nps1vlzPVewCrZ/GPAyMkc6PALzjYacRNDZ4zF4K8RJzU2fHtXK51WMz4PPhT7c2mnPtaKxIooduKnUYkn2uj4y6V79lTun7D1Jz6WeE74IhUZ8CAvCWyV1DjaM2/iy1kFwQBOfTOFABnU+KQVJCQtEpotQaJSsWnPjgDTjRdT+QUgRS7UaEKoByE39i+fg4y39nrME879C3GCAS5YqDyXTDef0l7fCR/zBsfRJSw79K5S32ftQuMsmdGXZ/Kq0FSZiHh6PqL3LMnaJrCboKbkp2B8gNMOH7UMm4k/1qTVFS5w2h0Oer/PkC9H2stISkiw8jBejcrhbtjdjp/1Z0zo6F0o43QseG37zbqzzq2yzndKiT3bZ3OvbGYIiVIvPRb6N16Bs2ymWtIO2YSrRb68SwjaqtfDV+j1KuOV6eovQi8sjk/78kdB9gE5nGvfR6Ry9Mvhv9y66pKM7ilcYBXP+xC4dZbtc6M7rcYk3YE/3C5eICaJaJtGoWXDYk93vIzoWfUvU2SpaE4B4hNSCMqpuN7TRTNeb7fS3637ItErlJCAX3kLet8aFWryNe+uTalmWkRyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZBWHl2MTY1bktMMlF4di9vb1oyaDJIeFpobERHZFVHYjI1cUwyNzlhbHRD?=
 =?utf-8?B?WlNENnduVVF3Z1pjVVVLOUlzSDFVTEw2VG1pcW1TdEc0VFIwZThxMFJ6US9y?=
 =?utf-8?B?SVpwREdwcllCME5qeXJoMGw3TW9tNUZhRmJHMnVITHhIOFZkcWc1WW12RnpP?=
 =?utf-8?B?YjhKZVZUbzFQQ1VTb250NXQ1RFhkNnROd1VscS9qYVNoWTBDQnBpR29hYUg0?=
 =?utf-8?B?YkZjQlIzSkNLUWRvVmE4WmtWcE44NG5vRHJBWUZGUVg1dFM0bjNsT0RYb1V4?=
 =?utf-8?B?SlpxVENRdi9MSC90dUtDK3BHaFpkbkhhSXBMMkNBMGVKTlFteVMyS0xqNlNX?=
 =?utf-8?B?eC9ORGRLeFRYUXRUNyt4OCtuVW5FMEI1MXVTMzJnVWoyNldjOEdPd29vYXdn?=
 =?utf-8?B?NlE0cStraTlhS05vb3VrVHpwbUxEcWcxSyt6S2x4ays4OVBhNkZSbVdoN2lt?=
 =?utf-8?B?Vkc0RFloYXdQRUFyZWxpQVVaMmx3WjM5SUE5UElVNVphRE1LMnk5WDJaTEVG?=
 =?utf-8?B?ZkRyNFl0amEvMUlmZng2VEdhNXY1MVpidjZ1UVZKMGEzcHNIVjNCS2dKeEJL?=
 =?utf-8?B?c1AzYStnalFESG94cVQrRm1vdGJ1cGdMNUcybWJHZmxJcjVHbGpveG50a3Rp?=
 =?utf-8?B?Y2xWZHkyUm1wcVhZeHRUajFLazEraG1wV2orWlF3em5weUt5dnR0YzNnajNJ?=
 =?utf-8?B?dXNkOWZpa0Y4Z1pRTUlQLzdGNklsTlJnODZSM0tSNEFUU2thZVM0dWlrL3Z1?=
 =?utf-8?B?OEhRWUlCdFRMRWZKdzB4ekFzS2tmTnNodk50S3BPSnlQMFhWSVJXWEpTajFv?=
 =?utf-8?B?M1FIbERTTzZJamczNjAwamdWNEZyTHZQM0IwMnNzMUYvdHhFSmh4MkkzcmU3?=
 =?utf-8?B?Q1FkdDEyTkhGUEZkVDZ2clNkL0xZV3FvYVdudGdhTm1STnlrZzc2dktXUEFU?=
 =?utf-8?B?bGM1UEUzVkhxcjNmZEx6dENkaTN3c0ZpZE80RVlVMXdoME9VdVFLOWQ3djhZ?=
 =?utf-8?B?bGhYalRod0ZQbEFmOUhzb0RUY1BGUHJVSEFSQ09wMXB4Q0Q0R09FRFRubHFl?=
 =?utf-8?B?cGs0dlRLL1JZMSttSkRFNzRWN3k1RkNIcUNFdi92eFFBNWRiN09McXI1TTJn?=
 =?utf-8?B?S2lZZ0l1cEw5ME5rZnRJSXRObGdqTUNUNEs2Mlhwa0grSTd1eHpWbXZhVzU1?=
 =?utf-8?B?WEp5TjF6bVVxb2JxQ3dlZG8ycTZaYk9IZEQ3VDN3TTh0bnhpZGxJQzZwT2pF?=
 =?utf-8?B?MHpWTi9PWFp6U2p2Q1dkUEVRVDFDT3Nad1B3bWhYTmo0TVhqYUIybGdzd0RG?=
 =?utf-8?B?VmN0eTNpMWRzZzZBdWs3WlRrVmNoa082akVqV2JkZ2JEM3ZycXZncjB6ODJC?=
 =?utf-8?B?WnA3eTNBRU9YbThDQTVnMm05SFJndGhNaEhBbERJN1ZURVNFVGcxUVZRL002?=
 =?utf-8?B?RC9hb2cxaVp5ejV0cWxocnQxR2srSlozMjh5V3ZzcUhrOXVHWXdxdThaY1Ux?=
 =?utf-8?B?c0lVOHFqU3laRTJ0WS82RnpxRWdQZzFwOXY0YkN1OE9nbVB2dVBIUElub2hB?=
 =?utf-8?B?OHRBU2ErYUpsNEZoalpYc3VDcG1uQTBSL1lDU3g5OUVIaFZXTkNLcm9yVmtB?=
 =?utf-8?B?MFEveDhSc0lnd3VDN1FuWWg2VE1Yd0NUSlBIYVNIcnJ0R2dHVDZLdEoyTjd4?=
 =?utf-8?B?Mmdnb25RLzVYWmxWL0pHZExnMUxVTjZ5NG41YUljOGhwcVprN3lQYVI2Q01h?=
 =?utf-8?B?TVFLRkJkN0VMZzhwODV5WUNBTEJ3alA4TU1Dd00xbzVRUnRIelE3SXBUL25C?=
 =?utf-8?B?b1NjM3lOL1V5blNBZ2dJY2tJUEw2dVdRMkZBeFJ3TXRHY0tnNTNVcDRXQjJl?=
 =?utf-8?B?UDlCdkpTOHBOblh6SkFwUWJJZ2xIemRSeWpuU21TRDNKK3I4YXJVU211OHhQ?=
 =?utf-8?B?alZSb01kdXhvakh4WHd5L0tWWFVRZDcrYVpTQWozR09teW85VUhkRnVBVWs3?=
 =?utf-8?B?TXN0N1BYbU5OeWdPMDY0M05FMWU2ekFKMkFwTVpwSlFtQWl6MGdYQU83bjFz?=
 =?utf-8?B?SHVqNUR3bTNZOG1NTE9CUU0zUVVlSWdRUnBUNHdncUhSRnY4cmJ2UStsQ1Vm?=
 =?utf-8?B?RVhLLzBuQ292eDhXZHcwTkFrR1YwbThpZTc5SklqTVBDT1daVzlKY1FvRjFQ?=
 =?utf-8?B?R2R3T0JkSkxLeGNCMDJTRURhVURxYXJuaUN4YnJVTTJtaWl4akZMam9uSUxS?=
 =?utf-8?B?d1lhbFRWTDVxVkhFN1MxSnZIVFlENU12R0R2NVBQeW1Bb2JaWEVsQWhHcUpT?=
 =?utf-8?B?aWhTQzNpUWdjb0Y4TTF0YWZJR0F5Y2NvK0wvc21pWFhLNVJVL3FKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab0cba5-b729-481a-e9bc-08dea1257820
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:45:43.8350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg6ATChK6p6/gVYcmH4fohSVk3cxrOo/ZevXYJzPhTtCTawcioQG097+2sPOOiduBr3lwyWp3CfRoo+vqNHBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

Not sure if anything changes in this version if not its already reviewed.

regards
Sunil Khatri

On 21-04-2026 06:25 pm, Christian König wrote:
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
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 146 ++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>   4 files changed, 68 insertions(+), 105 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ad6dac17dd21..7fc733ba962e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1048,12 +1048,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
> @@ -1070,9 +1070,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
> index 63156289ae7f..e2a21a66b28f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -167,12 +167,10 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
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
> @@ -185,9 +183,7 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -201,9 +197,7 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   	vm_bo->moved = false;
>   }
>   
> @@ -217,9 +211,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
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
> @@ -232,10 +226,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
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
> @@ -249,13 +242,10 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
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
> @@ -269,9 +259,7 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -285,13 +273,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
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
> @@ -301,14 +289,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
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
> @@ -321,7 +308,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   	bool shared;
>   
>   	dma_resv_assert_held(bo->tbo.base.resv);
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	if (base->shared != shared) {
>   		base->shared = shared;
> @@ -333,7 +320,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   			vm->stats[bo_memtype].drm.private += size;
>   		}
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -358,11 +345,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
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
> @@ -386,7 +373,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>   		 */
>   		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>   			vm->stats[res_memtype].drm.purgeable += size;
> -		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
> +		if (!(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(res_memtype)))
>   			vm->stats[bo_memtype].evicted += size;
>   	}
>   }
> @@ -405,9 +393,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
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
> @@ -433,10 +421,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
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
> @@ -495,25 +483,25 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
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
> @@ -609,7 +597,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       void *param)
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
> -	struct amdgpu_vm_bo_base *bo_base;
> +	struct amdgpu_vm_bo_base *bo_base, *tmp;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> @@ -622,13 +610,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> @@ -641,26 +623,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> @@ -689,9 +666,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	spin_lock(&vm->status_lock);
>   	ret &= list_empty(&vm->evicted);
> -	spin_unlock(&vm->status_lock);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -985,18 +960,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
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
> @@ -1012,7 +982,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->relocated, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -1028,9 +998,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
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
> @@ -1260,9 +1228,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> @@ -1629,29 +1597,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
> @@ -1683,9 +1646,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
> @@ -2223,9 +2186,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
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
> @@ -2333,10 +2296,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
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
> @@ -2608,11 +2571,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> @@ -3105,7 +3069,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	spin_lock(&vm->status_lock);
>   	seq_puts(m, "\tIdle BOs:\n");
>   	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>   		if (!bo_va->base.bo)
> @@ -3143,11 +3106,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
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
> @@ -3157,7 +3122,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   			continue;
>   		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>   	}
> -	spin_unlock(&vm->status_lock);
>   	total_done_objs = id;
>   
>   	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f33ea7f8509b..b5216bc1292f 100644
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
>   
>   /**
