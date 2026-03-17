Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E97EFD874C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 12:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A5110E064;
	Tue, 17 Mar 2026 12:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LpGV8VoV";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F099D10E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5XpElJSSRTGMyqLJMnPU81kxnOcMy80Yz862Yjbs7w0/ZC5Ul06OtM8OgTMQ6aFthWMb/r+mETwvwnGgw9/r8SdrlJxvBATOjNcbH5Mh/FLJSsLloaY4Hf8hiXBeagLfqU0EhrL3ZDd9om2h8oD2KeC0fvS8h3Kj2i0jS2J1nYgH84ccGzUGiL6mH1aAJQ+TYsH0xGYbERHrnj9NG6bY2VNdGND4VJH0hid68507kj6nF6Gev0HnuRFGQ3TiSwkCDawgn9YZP16SN77SptWeF/pknIkGEU4EZhDlthJz4DV+YNFaeHIOyTyHInGfGC0iJQLz639IMk4DYUv25AFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn/ouwxjhGN1ZNrkGI7Mnzd0pm341MUyWg4olR/cvYs=;
 b=IrCh5R7A0avKBKt90y2nVc01UK3sDMhF8bRvC/MW2ulZdg5EX7J5Ue75La/UtfA0ZVXvK3d2u6LvyC3Ekkp5IIVwndKN1ViSCo/0uMHEuCwLViHrF1PohuzwASMuKqZHLu0ghdbPAa+B/aCyB7/CZrJKYVR0S2PfSP9JsERBg9bQsR5Ln6ssGJc9H5aKcEX3/3oJBYof+7AbwzbAGy5WE7qxOCTGAXn/tHWiqiZuVndFGU1o4efXYJpXedTv+eB4v2j5z4by3FpMF7lTo2+tuBLfVcFwQd8UuvzFpW3H69DGB+AYCRMJShLrICouFTVoys2VNRFmfBt8cwnM/gvJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn/ouwxjhGN1ZNrkGI7Mnzd0pm341MUyWg4olR/cvYs=;
 b=LpGV8VoVbWYglEK9TXd6B2oMZozcYFjdd0WygjgycVk8ZqWs/AG5N5Dtzeimw+BYS8OPcBA7eOlfGtnHij2S9574C8vHx4iyA6z/ldwhkfqNuCOXRzMJK3T+DS6EXpIqxZZoc2ov4cwMkPeHVJgldOVjydbQfd6F/TTfziszEmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Tue, 17 Mar
 2026 12:03:27 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 12:03:27 +0000
Content-Type: multipart/alternative;
 boundary="------------0w6wmmi59n7SvFTFBwJRi6hg"
Message-ID: <5765859f-9b6f-4fe6-b999-b0957450f4ef@amd.com>
Date: Tue, 17 Mar 2026 17:33:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] drm/amdgpu: restructure VM state machine v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260317105501.21479-1-christian.koenig@amd.com>
 <20260317105501.21479-9-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260317105501.21479-9-christian.koenig@amd.com>
X-ClientProxiedBy: MA5PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8951c9-6f93-4b2f-8ac9-08de841d32a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0MdM/cQpZbzqZJcrkoF9NEvQm9egZ0UKW1GsWCfyW6/7aTeLfE9MQjCbpHIChzlJ39SHrtq3zOMpwSfYDmKxEKkeYfrSRck8sUIKUMaMip1//j3C1W2H9tl40bHgmOfZWS7W3+vwuZMhY8GVucifF3gJ2z4GMtvMnTaE2CDK6Yaumn+Auxj+HWPy6zwtTB6r3ak/l2EuagVRJ/bAokPOiijWnuJIdymnUP1uUtERC//N6HrQrscvucOSnqlvfQX+Gr3crnDZHAQPuh05kgqrZVlVmYHM7402nb3yYGGyeRBa3WYPwoKTlLca5ZK3S5BiB8LzVnH12E/C4JUoQDixYO3LuiDNrMWqw5q73GvGskdGYB7lhOGU81yrH60sIVzEgK94VeYmq45ps9M3NwYmnLtqfbIAwg7wSN422aomeN4EgzvPUvQ0dKNAMaSssm3Qj60Im4sOI8Yo8Gyky9MQUVpDwZDeoSnohg/THS30DH+E/2wHhpWCiwkM4QytccTt00u8ET4aGCQNhMxgX4vkrgbVsHl62tCDgYytAweVMnj+O2tTGKYftipgeXxM1tj2Mbs5kz6S+UseZd/Yciarh1xI6quHzO3E9/SExVLyRq9dU/jWJj9UIJA3ejTJBHyA2CpfF1slf4yF+4AM1I3UzNgH/cOt69ZRB+Uzl17SfnsOr8gOdkzw4OTMC/+/nBF8DBJQVSpwiu5LELIDo9quR2XYnaaGez5cc/Y4UJfxpGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVDWjAxcWRrOFgvYkNlejhURGpMWHZZenFkUWtvem9ZYVV2SnpNUFBrRTl1?=
 =?utf-8?B?WmtVdEg2S2pycExoOUNIUlh5ZTlSbzYrLzl2NEY0T1ZJeVNWV000ay94SHdy?=
 =?utf-8?B?eE9kNXRwekxETjZjSlcxOTZJNVlFNTBMakxLcGpLSFh2UHRmZmRGUnFqWUNt?=
 =?utf-8?B?ZkhqMDFTMDJnU0FwWHFvUjRCU0wzVkNMZ2pmczF5c0V4TFVVQjhpRDBZekRK?=
 =?utf-8?B?OVZna0hnS3hZbzE0cW5zay9FaExXQlFQVGxRVU01ZVlnNE05WE4vRlNBU1lm?=
 =?utf-8?B?WGNyckt4U3FqNDQyNkV6TXhDaStQTGpHcDZVb0w3SkNnUGdiNWJ2N0llOGJT?=
 =?utf-8?B?VFRRRGw4NEYxcWhuSzAvMUtpMVVWUlBmYWxvdnZmdm1XTlZsWDFkVGprNUhh?=
 =?utf-8?B?RDd2aHBJWlp3VzZTVkNjMXZDMVFibkVlc3JGSGZHSFR1OVBMNlZpM2h3R09i?=
 =?utf-8?B?aFV5RUVZVnJDZC96ZU5NRlNGb3ltNGZKMUJ4eUNXVzhyeGdMeHdYekhHbVhH?=
 =?utf-8?B?R2U4WHdaazM3TzQ4SjhZSHNzRW9Da0RTT2REa1RuczE2WnpjcGJjcm5LK2Nm?=
 =?utf-8?B?ais2eGY1aTIrTHBzTFZxYWx1b1dPS3ZtTEhXMHhKYlpIaXFWMVpxUkdsTHk5?=
 =?utf-8?B?RVV4VFprM0I2VndMZ0pIN1hXd1BuK2d1dk44d1FvTElwNVA2Q2JkS3pMclBE?=
 =?utf-8?B?UlVJajhkdFgyODFyVHNkblRkZmg0VFdPclRZc09FaVh6dzgyNHB1cVdWY3Vz?=
 =?utf-8?B?Y2VBcFJSbUZmUVRXcU0xajgwN1NWNkVKNTJReFlwdmErTllRK2JxMXhHd3Vs?=
 =?utf-8?B?QkUxRThvZDh6S1AzckdNbElYUkpLUjVjYWRGTy9ySVVudDY3cjVWeGNscndG?=
 =?utf-8?B?WnJJUnBPdkhDSGo0UVRCaFBkc0VwUlNYcjJLd29FbGVlOU5GKzhENFdCY2hX?=
 =?utf-8?B?eGdoUnZoQlBzWktPTnhLcExaV2VZeG1lV2Y0QTlwVHpEVnFKdWFMUjhpckdK?=
 =?utf-8?B?dC9qemNwZXNvNnMrYmxMRVNPK1E5MmFJelVWNVFmcG1kYThkc2JCajdPU1F5?=
 =?utf-8?B?MDUvNm1jMWNDQlF6bXNtSjFnSkpueVJ1RnVsQ3lRdnVTSFBVRXArRzh1dFZT?=
 =?utf-8?B?N3RxNk5JVXlrYWpVM2ZlODhnY2tqSGRKQ1RhNklaMnUxWThXYlgyNWFOazJn?=
 =?utf-8?B?eGNYbnBCaWU2NWR4dEwweTgzK3pYdktoN2dvWG15VlpGdXlCNTcxeVBSc1Ur?=
 =?utf-8?B?Q3dQSHdCZTdoTUQraEZuRjA3Z0svK3pNSzBLeEJwV0Y5ekNPSkVpNzNrL0cw?=
 =?utf-8?B?d09zVzQyc1UrMndPeVBpOTV0aVp5SEJKenlGaDIveFJ1bE5ia2l3bUlKNzEw?=
 =?utf-8?B?cTZFa1FrMi9Dd2pJUVpScjNmZDlrcDAzQXdvV251MG55dDV5eEI3ZkhVUTZi?=
 =?utf-8?B?U0JSVllEWEdIc0Y0c0hON3JaWjAzclhiOGlVcXRGYWhOUEV6WXpYamtOanRl?=
 =?utf-8?B?YjJrMVRSbzExR1orUWdIekUxdmhKb2U1bnVFbW5ZM0htT2xLMkw1bFRTZ1lI?=
 =?utf-8?B?YysxcUdzQ3pvV08xalFKdkxGWTR0SDUraUM0VTIwZjJiNmQwZ0VBYVNZWmhM?=
 =?utf-8?B?YUZPY3VKSXIxQU1Eekc2MytwSy9yMmJQM2NPeHErVnp5bVMwd3RIMlRucVlY?=
 =?utf-8?B?czBlV3R0dTVLV2JmUjJyN0lYZ0tVTlIyNWdIaE9ET3psSkRaRUtRWjNiajBp?=
 =?utf-8?B?UXF4UEtrcnR5YVV2aFJ3YmY2anJDNldvTGRHU0tOZzBidlpmaG5TRXdxRFNN?=
 =?utf-8?B?RnpNLzg4S3hiQ1dSSC82OHAyVjhJNHhodTBzMmhHV0xhdlo3TEl4L3BnRTRm?=
 =?utf-8?B?M0N3NnZoQWRZenU3NjBjQndRd3RDazg1TEZzd255NStOM2d5Y2lRTno3QnY5?=
 =?utf-8?B?OHBoL1RSQnBMd1RESk9rT2tZMTVjNExNdHBCMXBDSUl0RjZkUDg4MXA1b1dF?=
 =?utf-8?B?YW16WkpmZ3pxUHVpRS9JTzI1SWJNUEZRTkl1WUt6ZmpRTXVaY2lkQmVxaWVF?=
 =?utf-8?B?VE13dWt1L3ZjRHo3c3cwOXRTc0Vmait2SDRqbXJSeUF4N0dNSFlQN1UrNFR0?=
 =?utf-8?B?RUk5d2RqczFkT0lSc1RNZk1CZUduQzlzQ3hsVTJUZG5kWkZIM3V5RU5FaWNn?=
 =?utf-8?B?TFZoQ0l3L1RxRTdnQjk1TVN6ODE3T1dROTIvS0M1bUIvS2hwdjBweTVsV2pJ?=
 =?utf-8?B?MW1jUEg3S1hvajAvcnVVMVJXQkxpNW5ERDN5dTBNeEl1RXJkS3grWGtzTVRr?=
 =?utf-8?B?Q3FKVW0rSFRhTk9kekhBVjlBVTlmRkY0bHV3NHJ1anNFNzIrVWoxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8951c9-6f93-4b2f-8ac9-08de841d32a5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:03:27.5712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq3SjH7q53W1NWnAkmXP/F3AhLCSC9fuzjzNCqNRj38ugxvtkXRDHu1uJY6+huzVQdgjh9lRvmnkKMjB+Y/aWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

--------------0w6wmmi59n7SvFTFBwJRi6hg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>


On 17-03-2026 04:24 pm, Christian König wrote:
> Instead of coming up with more sophisticated names for states a VM BO
> can be in, group them by the type of BO first and then by the state.
>
> So we end with BO type kernel, always_valid and individual and then states
> evicted, moved and idle.
>
> Not much functional change, except that evicted_user is moved back
> together with the other BOs again which makes the handling in
> amdgpu_vm_validate() a bit more complex.
>
> Also fixes a problem with user queues and amdgpu_vm_ready(). We didn't
> considered the VM ready when user BOs were not ideally placed, harmless
> performance impact for kernel queues but a complete show stopper for
> userqueues.
>
> v2: fix a few typos in comments, rename the BO types to make them more
>      descriptive, fix a couple of bugs found during testing
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 466 ++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  64 ++-
>   3 files changed, 251 insertions(+), 301 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c50a484d22e0..9b2dfeead299 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1041,12 +1041,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated,
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->always_valid.evicted)) {
> +		bo_va = list_first_entry(&vm->always_valid.evicted,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
> -		spin_unlock(&vm->invalidated_lock);
> +		spin_unlock(&vm->individual_lock);
>   
>   		bo = bo_va->base.bo;
>   		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -1058,14 +1058,14 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		/* This moves the bo_va to the done list */
> +		/* This moves the bo_va to the idle list */
>   		ret = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (ret)
>   			return ret;
>   
> -		spin_lock(&vm->invalidated_lock);
> +		spin_lock(&vm->individual_lock);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -1097,7 +1097,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   		if (unlikely(ret))
>   			goto unlock_all;
>   
> -		ret = amdgpu_vm_lock_done_list(vm, &exec, 1);
> +		ret = amdgpu_vm_lock_individual(vm, &exec, 1);
>   		drm_exec_retry_on_contention(&exec);
>   		if (unlikely(ret))
>   			goto unlock_all;
> @@ -1140,7 +1140,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	key = 0;
>   	/* Validate User Ptr BOs */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
>   		bo = bo_va->base.bo;
>   		if (!bo)
>   			continue;
> @@ -1190,10 +1190,10 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	/*
>   	 * We need to wait for all VM updates to finish before restarting the
> -	 * queues. Using the done list like that is now ok since everything is
> +	 * queues. Using the idle list like that is now ok since everything is
>   	 * locked in place.
>   	 */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status)
> +	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
>   		dma_fence_wait(bo_va->last_pt_update, false);
>   	dma_fence_wait(vm->last_update, false);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..1223d1e86afa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -138,143 +138,127 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   }
>   
> -/**
> - * amdgpu_vm_bo_evicted - vm_bo is evicted
> - *
> - * @vm_bo: vm_bo which is evicted
> - *
> - * State for PDs/PTs and per VM BOs which are not at the location they should
> - * be.
> +/* Initialize the amdgpu_vm_bo_status object */
> +static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
> +{
> +	INIT_LIST_HEAD(&lists->evicted);
> +	INIT_LIST_HEAD(&lists->moved);
> +	INIT_LIST_HEAD(&lists->idle);
> +}
> +
> +/*
> + * Make sure we have the lock to modify the vm_bo status and return the object
> + * with the status lists.
>    */
> -static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
> +static struct amdgpu_vm_bo_status *
> +amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	struct amdgpu_vm *vm = vm_bo->vm;
>   	struct amdgpu_bo *bo = vm_bo->bo;
>   
> -	vm_bo->moved = true;
> -	amdgpu_vm_assert_locked(vm);
> -	if (bo->tbo.type == ttm_bo_type_kernel)
> -		list_move(&vm_bo->vm_status, &vm->evicted);
> -	else
> -		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -}
> -/**
> - * amdgpu_vm_bo_moved - vm_bo is moved
> - *
> - * @vm_bo: vm_bo which is moved
> - *
> - * State for per VM BOs which are moved, but that change is not yet reflected
> - * in the page tables.
> - */
> -static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -}
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		/* No extra locking needed, protected by the root PD resv lock */
> +		amdgpu_vm_assert_locked(vm);
>   
> -/**
> - * amdgpu_vm_bo_idle - vm_bo is idle
> - *
> - * @vm_bo: vm_bo which is now idle
> - *
> - * State for PDs/PTs and per VM BOs which have gone through the state machine
> - * and are now idle.
> - */
> -static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	vm_bo->moved = false;
> +		if (bo->tbo.type == ttm_bo_type_kernel)
> +			return &vm->kernel;
> +
> +		return &vm->always_valid;
> +	}
> +
> +	spin_lock(&vm_bo->vm->individual_lock);
> +	return &vm->individual;
>   }
>   
> -/**
> - * amdgpu_vm_bo_invalidated - vm_bo is invalidated
> - *
> - * @vm_bo: vm_bo which is now invalidated
> - *
> - * State for normal BOs which are invalidated and that change not yet reflected
> - * in the PTs.
> - */
> -static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
> +/* Eventually unlock the status list lock again */
> +static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->invalidated_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->invalidated_lock);
> +	if (amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		amdgpu_vm_assert_locked(vm_bo->vm);
> +	else
> +		spin_unlock(&vm_bo->vm->individual_lock);
>   }
>   
>   /**
> - * amdgpu_vm_bo_evicted_user - vm_bo is evicted
> + * amdgpu_vm_bo_evicted - vm_bo is evicted
>    *
>    * @vm_bo: vm_bo which is evicted
>    *
> - * State for BOs used by user mode queues which are not at the location they
> - * should be.
> + * State for vm_bo objects meaning the underlying BO was evicted and need to
> + * move in place again.
>    */
> -static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> +	struct amdgpu_vm_bo_status *lists;
> +
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
>   	vm_bo->moved = true;
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> +	list_move(&vm_bo->vm_status, &lists->evicted);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
> -
>   /**
> - * amdgpu_vm_bo_relocated - vm_bo is reloacted
> + * amdgpu_vm_bo_moved - vm_bo is moved
>    *
> - * @vm_bo: vm_bo which is relocated
> + * @vm_bo: vm_bo which is moved
>    *
> - * State for PDs/PTs which needs to update their parent PD.
> - * For the root PD, just move to idle state.
> + * State for vm_bo objects meaning the underlying BO was moved but the new
> + * location not yet reflected in the page tables.
>    */
> -static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	if (vm_bo->bo->parent)
> -		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	else
> -		amdgpu_vm_bo_idle(vm_bo);
> +	struct amdgpu_vm_bo_status *lists;
> +	struct amdgpu_bo *bo = vm_bo->bo;
> +
> +	/*
> +	 * The root PD doesn't have a parent PDE and goes directly into the
> +	 * idle state.
> +	 */
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	if (bo && bo->tbo.type == ttm_bo_type_kernel && !bo->parent) {
> +		vm_bo->moved = false;
> +		list_move(&vm_bo->vm_status, &lists->idle);
> +	} else {
> +		vm_bo->moved = true;
> +		list_move(&vm_bo->vm_status, &lists->moved);
> +	}
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   
>   /**
> - * amdgpu_vm_bo_done - vm_bo is done
> + * amdgpu_vm_bo_idle - vm_bo is idle
>    *
> - * @vm_bo: vm_bo which is now done
> + * @vm_bo: vm_bo which is now idle
>    *
> - * State for normal BOs which are invalidated and that change has been updated
> - * in the PTs.
> + * State for vm_bo objects meaning we are done with the state machine and no
> + * further action is necessary.
>    */
> -static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> +	struct amdgpu_vm_bo_status *lists;
> +
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		vm_bo->moved = false;
> +	list_move(&vm_bo->vm_status, &lists->idle);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   
>   /**
>    * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
>    * @vm: the VM which state machine to reset
>    *
> - * Move all vm_bo object in the VM into a state where they will be updated
> - * again during validation.
> + * Move all vm_bo object in the VM into a state where their location will be
> + * updated in the page tables again.
>    */
>   static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   {
> -	struct amdgpu_vm_bo_base *vm_bo, *tmp;
> -
> -	spin_lock(&vm->invalidated_lock);
> -	list_splice_init(&vm->done, &vm->invalidated);
> -	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
> -		vm_bo->moved = true;
> -	spin_unlock(&vm->invalidated_lock);
> -
>   	amdgpu_vm_assert_locked(vm);
> -	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
> -		struct amdgpu_bo *bo = vm_bo->bo;
> +	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> +	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
>   
> -		vm_bo->moved = true;
> -		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -		else if (bo->parent)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	}
> +	spin_lock(&vm->individual_lock);
> +	list_splice_init(&vm->individual.idle, &vm->individual.moved);
> +	spin_unlock(&vm->individual_lock);
>   }
>   
>   /**
> @@ -402,8 +386,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = NULL;
>   	INIT_LIST_HEAD(&base->vm_status);
>   
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   	if (!bo)
>   		return;
> +
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> @@ -412,27 +398,22 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>   	spin_unlock(&vm->stats_lock);
>   
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		amdgpu_vm_bo_idle(base);
>   		return;
> -
> -	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +	}
>   
>   	ttm_bo_set_bulk_move(&bo->tbo, &vm->lru_bulk_move);
> -	if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
> -		amdgpu_vm_bo_relocated(base);
> -	else
> -		amdgpu_vm_bo_idle(base);
>   
> +	/*
> +	 * When a per VM isn't in the desired domain put it into the evicted
> +	 * state to make sure that it gets validated on the next best occasion.
> +	 */
>   	if (bo->preferred_domains &
>   	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
> -		return;
> -
> -	/*
> -	 * we checked all the prerequisites, but it looks like this per vm bo
> -	 * is currently evicted. add the bo to the evicted list to make sure it
> -	 * is validated on next vm use to avoid fault.
> -	 * */
> -	amdgpu_vm_bo_evicted(base);
> +		amdgpu_vm_bo_moved(base);
> +	else
> +		amdgpu_vm_bo_evicted(base);
>   }
>   
>   /**
> @@ -453,41 +434,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   }
>   
>   /**
> - * amdgpu_vm_lock_done_list - lock all BOs on the done list
> + * amdgpu_vm_lock_individual - lock all BOs on the individual idle list
>    * @vm: vm providing the BOs
>    * @exec: drm execution context
>    * @num_fences: number of extra fences to reserve
>    *
> - * Lock the BOs on the done list in the DRM execution context.
> + * Lock the BOs on the individual idle list in the DRM execution context.
>    */
> -int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
> -			     unsigned int num_fences)
> +int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			      unsigned int num_fences)
>   {
> -	struct list_head *prev = &vm->done;
> +	struct list_head *prev = &vm->individual.idle;
>   	struct amdgpu_bo_va *bo_va;
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
>   	/* We can only trust prev->next while holding the lock */
> -	spin_lock(&vm->invalidated_lock);
> -	while (!list_is_head(prev->next, &vm->done)) {
> +	spin_lock(&vm->individual_lock);
> +	while (!list_is_head(prev->next, &vm->individual.idle)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>   
>   		bo = bo_va->base.bo;
>   		if (bo) {
>   			amdgpu_bo_ref(bo);
> -			spin_unlock(&vm->invalidated_lock);
> +			spin_unlock(&vm->individual_lock);
>   
>   			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
>   			amdgpu_bo_unref(&bo);
>   			if (unlikely(ret))
>   				return ret;
>   
> -			spin_lock(&vm->invalidated_lock);
> +			spin_lock(&vm->individual_lock);
>   		}
>   		prev = prev->next;
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -584,9 +565,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>   	struct amdgpu_vm_bo_base *bo_base, *tmp;
> -	struct amdgpu_bo *bo;
>   	int r;
>   
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   	if (vm->generation != new_vm_generation) {
>   		vm->generation = new_vm_generation;
>   		amdgpu_vm_bo_reset_state_machine(vm);
> @@ -596,38 +577,59 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			return r;
>   	}
>   
> -	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
> -		bo = bo_base->bo;
> -
> -		r = validate(param, bo);
> +	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
> +		r = validate(param, bo_base->bo);
>   		if (r)
>   			return r;
>   
> -		if (bo->tbo.type != ttm_bo_type_kernel) {
> -			amdgpu_vm_bo_moved(bo_base);
> -		} else {
> -			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
> -			amdgpu_vm_bo_relocated(bo_base);
> -		}
> +		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   
> -	if (ticket) {
> -		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> -					 vm_status) {
> -			bo = bo_base->bo;
> -			dma_resv_assert_held(bo->tbo.base.resv);
> +	/*
> +	 * As soon as all page tables are in place we can start updating them
> +	 * again.
> +	 */
> +	amdgpu_vm_eviction_lock(vm);
> +	vm->evicting = false;
> +	amdgpu_vm_eviction_unlock(vm);
>   
> -			r = validate(param, bo);
> -			if (r)
> -				return r;
> +	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
> +				 vm_status) {
> +		r = validate(param, bo_base->bo);
> +		if (r)
> +			return r;
>   
> -			amdgpu_vm_bo_invalidated(bo_base);
> -		}
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	vm->evicting = false;
> -	amdgpu_vm_eviction_unlock(vm);
> +	if (!ticket)
> +		return 0;
> +
> +	spin_lock(&vm->individual_lock);
> +restart:
> +	list_for_each_entry(bo_base, &vm->individual.evicted, vm_status) {
> +		struct amdgpu_bo *bo = bo_base->bo;
> +
> +		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket)
> +			continue;
> +
> +		spin_unlock(&vm->individual_lock);
> +
> +		r = validate(param, bo);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vm_bo_moved(bo_base);
> +
> +		/* It's a bit inefficient to always jump back to the start, but
> +		 * we would need to re-structure the KFD for properly fixing
> +		 * that.
> +		 */
> +		spin_lock(&vm->individual_lock);
> +		goto restart;
> +	}
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -652,7 +654,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	ret &= list_empty(&vm->evicted);
> +	ret &= list_empty(&vm->kernel.evicted);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -952,7 +954,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	if (list_empty(&vm->relocated))
> +	if (list_empty(&vm->kernel.moved))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -968,7 +970,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -984,9 +986,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (flush_tlb_needed)
>   		atomic64_inc(&vm->tlb_seq);
>   
> -	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
> +	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
>   		amdgpu_vm_bo_idle(entry);
> -	}
>   
>   error:
>   	drm_dev_exit(idx);
> @@ -1357,7 +1358,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		else
>   			amdgpu_vm_bo_idle(&bo_va->base);
>   	} else {
> -		amdgpu_vm_bo_done(&bo_va->base);
> +		amdgpu_vm_bo_idle(&bo_va->base);
>   	}
>   
>   	list_splice_init(&bo_va->invalids, &bo_va->valids);
> @@ -1585,19 +1586,20 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	bool clear, unlock;
>   	int r;
>   
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> +	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
> +				 base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
>   			return r;
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
> -					 base.vm_status);
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->individual.moved)) {
> +		bo_va = list_first_entry(&vm->individual.moved,
> +					 typeof(*bo_va), base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->invalidated_lock);
> +		spin_unlock(&vm->individual_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1627,11 +1629,11 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>   		    (!bo_va->base.bo->tbo.resource ||
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
> -			amdgpu_vm_bo_evicted_user(&bo_va->base);
> +			amdgpu_vm_bo_evicted(&bo_va->base);
>   
> -		spin_lock(&vm->invalidated_lock);
> +		spin_lock(&vm->individual_lock);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -2174,9 +2176,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->individual_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2256,14 +2258,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>   
>   		if (bo_base->moved)
>   			continue;
> -		bo_base->moved = true;
> -
> -		if (bo->tbo.type == ttm_bo_type_kernel)
> -			amdgpu_vm_bo_relocated(bo_base);
> -		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
> -			amdgpu_vm_bo_moved(bo_base);
> -		else
> -			amdgpu_vm_bo_invalidated(bo_base);
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   }
>   
> @@ -2554,15 +2549,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->va = RB_ROOT_CACHED;
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		vm->reserved_vmid[i] = NULL;
> -	INIT_LIST_HEAD(&vm->evicted);
> -	INIT_LIST_HEAD(&vm->evicted_user);
> -	INIT_LIST_HEAD(&vm->relocated);
> -	INIT_LIST_HEAD(&vm->moved);
> -	INIT_LIST_HEAD(&vm->idle);
> -	spin_lock_init(&vm->invalidated_lock);
> -	INIT_LIST_HEAD(&vm->invalidated);
> +
> +	amdgpu_vm_bo_status_init(&vm->kernel);
> +	amdgpu_vm_bo_status_init(&vm->always_valid);
> +	spin_lock_init(&vm->individual_lock);
> +	amdgpu_vm_bo_status_init(&vm->individual);
>   	INIT_LIST_HEAD(&vm->freed);
> -	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
>   	spin_lock_init(&vm->stats_lock);
>   
> @@ -3005,100 +2997,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   }
>   
>   #if defined(CONFIG_DEBUG_FS)
> -/**
> - * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> - *
> - * @vm: Requested VM for printing BO info
> - * @m: debugfs file
> - *
> - * Print BO information in debugfs file for the VM
> - */
> -void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> -{
> -	struct amdgpu_bo_va *bo_va, *tmp;
> -	u64 total_idle = 0;
> -	u64 total_evicted = 0;
> -	u64 total_relocated = 0;
> -	u64 total_moved = 0;
> -	u64 total_invalidated = 0;
> -	u64 total_done = 0;
> -	unsigned int total_idle_objs = 0;
> -	unsigned int total_evicted_objs = 0;
> -	unsigned int total_relocated_objs = 0;
> -	unsigned int total_moved_objs = 0;
> -	unsigned int total_invalidated_objs = 0;
> -	unsigned int total_done_objs = 0;
> -	unsigned int id = 0;
>   
> -	amdgpu_vm_assert_locked(vm);
> +/* print the debug info for a specific set of status lists */
> +static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
> +					     struct amdgpu_vm_bo_status *lists)
> +{
> +	struct amdgpu_vm_bo_base *base;
> +	unsigned int id;
>   
> -	seq_puts(m, "\tIdle BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_idle_objs = id;
>   	id = 0;
> -
>   	seq_puts(m, "\tEvicted BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->evicted, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_evicted_objs = id;
> -	id = 0;
>   
> -	seq_puts(m, "\tRelocated BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	total_relocated_objs = id;
> -	id = 0;
>   
> +	id = 0;
>   	seq_puts(m, "\tMoved BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	total_moved_objs = id;
> -	id = 0;
>   
> -	seq_puts(m, "\tInvalidated BOs:\n");
> -	spin_lock(&vm->invalidated_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	id = 0;
> +	seq_puts(m, "\tIdle BOs:\n");
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> -	total_invalidated_objs = id;
> -	id = 0;
> +}
>   
> -	seq_puts(m, "\tDone BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_done_objs = id;
> -
> -	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> -		   total_idle_objs);
> -	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
> -		   total_evicted_objs);
> -	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
> -		   total_relocated_objs);
> -	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
> -		   total_moved_objs);
> -	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
> -		   total_invalidated_objs);
> -	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
> -		   total_done_objs);
> +/**
> + * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> + *
> + * @vm: Requested VM for printing BO info
> + * @m: debugfs file
> + *
> + * Print BO information in debugfs file for the VM
> + */
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> +{
> +	amdgpu_vm_assert_locked(vm);
> +
> +	seq_puts(m, "\tKernel PT/PDs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->kernel);
> +
> +	seq_puts(m, "\tPer VM BOs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->always_valid);
> +
> +	seq_puts(m, "\tIndividual BOs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual);
>   }
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ae9449d5b00c..9b4a4e5c24f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -216,6 +216,23 @@ struct amdgpu_vm_bo_base {
>   	bool				moved;
>   };
>   
> +/*
> + * The following status lists contain amdgpu_vm_bo_base objects for
> + * either PD/PTs, per VM BOs or BOs with individual resv object.
> + *
> + * The state transits are: evicted -> moved -> idle
> + */
> +struct amdgpu_vm_bo_status {
> +	/* BOs evicted which need to move into place again */
> +	struct list_head		evicted;
> +
> +	/* BOs which moved but new location hasn't been updated in the PDs/PTs */
> +	struct list_head		moved;
> +
> +	/* BOs done with the state machine and need no further action */
> +	struct list_head		idle;
> +};
> +
>   /* provided by hw blocks that can write ptes, e.g., sdma */
>   struct amdgpu_vm_pte_funcs {
>   	/* number of dw to reserve per operation */
> @@ -349,46 +366,25 @@ struct amdgpu_vm {
>   	spinlock_t		stats_lock;
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
> +	/* BO's belonging to PD/PT which are internal to the kernel. */
> +	struct amdgpu_vm_bo_status	kernel;
> +
>   	/*
> -	 * The following lists contain amdgpu_vm_bo_base objects for either
> -	 * PDs, PTs or per VM BOs. The state transits are:
> -	 *
> -	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> -	 *
> -	 * Lists are protected by the root PD dma_resv lock.
> +	 * BOs allocated by userspace where the dma_resv is shared with the
> +	 * root PD
>   	 */
> -
> -	/* Per-VM and PT BOs who needs a validation */
> -	struct list_head	evicted;
> -
> -	/* PT BOs which relocated and their parent need an update */
> -	struct list_head	relocated;
> -
> -	/* per VM BOs moved, but not yet updated in the PT */
> -	struct list_head	moved;
> -
> -	/* All BOs of this VM not currently in the state machine */
> -	struct list_head	idle;
> +	struct amdgpu_vm_bo_status	always_valid;
>   
>   	/*
>   	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
> -	 * have their own dma_resv object and not depend on the root PD. Their
> -	 * state transits are:
> -	 *
> -	 * evicted_user or invalidated -> done
> +	 * have their own dma_resv object and not depend on the root PD.
>   	 *
> -	 * Lists are protected by the invalidated_lock.
> +	 * Lists are protected by the individual_lock.
>   	 */
> -	spinlock_t		invalidated_lock;
> -
> -	/* BOs for user mode queues that need a validation */
> -	struct list_head	evicted_user;
> -
> -	/* regular invalidated BOs, but not yet updated in the PT */
> -	struct list_head	invalidated;
> +	spinlock_t			individual_lock;
>   
> -	/* BOs which are invalidated, has been updated in the PTs */
> -	struct list_head        done;
> +	/* Userspace BOs with individual resv object */
> +	struct amdgpu_vm_bo_status	individual;
>   
>   	/*
>   	 * This list contains amdgpu_bo_va_mapping objects which have been freed
> @@ -508,8 +504,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   		      unsigned int num_fences);
> -int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
> -			     unsigned int num_fences);
> +int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			      unsigned int num_fences);
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
--------------0w6wmmi59n7SvFTFBwJRi6hg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Reviewed-by:
      Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 17-03-2026 04:24 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260317105501.21479-9-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">Instead of coming up with more sophisticated names for states a VM BO
can be in, group them by the type of BO first and then by the state.

So we end with BO type kernel, always_valid and individual and then states
evicted, moved and idle.

Not much functional change, except that evicted_user is moved back
together with the other BOs again which makes the handling in
amdgpu_vm_validate() a bit more complex.

Also fixes a problem with user queues and amdgpu_vm_ready(). We didn't
considered the VM ready when user BOs were not ideally placed, harmless
performance impact for kernel queues but a complete show stopper for
userqueues.

v2: fix a few typos in comments, rename the BO types to make them more
    descriptive, fix a couple of bugs found during testing

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 466 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  64 ++-
 3 files changed, 251 insertions(+), 301 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c50a484d22e0..9b2dfeead299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1041,12 +1041,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	struct amdgpu_bo *bo;
 	int ret;
 
-	spin_lock(&amp;vm-&gt;invalidated_lock);
-	while (!list_empty(&amp;vm-&gt;invalidated)) {
-		bo_va = list_first_entry(&amp;vm-&gt;invalidated,
+	spin_lock(&amp;vm-&gt;individual_lock);
+	while (!list_empty(&amp;vm-&gt;always_valid.evicted)) {
+		bo_va = list_first_entry(&amp;vm-&gt;always_valid.evicted,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
-		spin_unlock(&amp;vm-&gt;invalidated_lock);
+		spin_unlock(&amp;vm-&gt;individual_lock);
 
 		bo = bo_va-&gt;base.bo;
 		ret = drm_exec_prepare_obj(exec, &amp;bo-&gt;tbo.base, 2);
@@ -1058,14 +1058,14 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 		if (ret)
 			return ret;
 
-		/* This moves the bo_va to the done list */
+		/* This moves the bo_va to the idle list */
 		ret = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (ret)
 			return ret;
 
-		spin_lock(&amp;vm-&gt;invalidated_lock);
+		spin_lock(&amp;vm-&gt;individual_lock);
 	}
-	spin_unlock(&amp;vm-&gt;invalidated_lock);
+	spin_unlock(&amp;vm-&gt;individual_lock);
 
 	return 0;
 }
@@ -1097,7 +1097,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 		if (unlikely(ret))
 			goto unlock_all;
 
-		ret = amdgpu_vm_lock_done_list(vm, &amp;exec, 1);
+		ret = amdgpu_vm_lock_individual(vm, &amp;exec, 1);
 		drm_exec_retry_on_contention(&amp;exec);
 		if (unlikely(ret))
 			goto unlock_all;
@@ -1140,7 +1140,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 	key = 0;
 	/* Validate User Ptr BOs */
-	list_for_each_entry(bo_va, &amp;vm-&gt;done, base.vm_status) {
+	list_for_each_entry(bo_va, &amp;vm-&gt;always_valid.idle, base.vm_status) {
 		bo = bo_va-&gt;base.bo;
 		if (!bo)
 			continue;
@@ -1190,10 +1190,10 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 	/*
 	 * We need to wait for all VM updates to finish before restarting the
-	 * queues. Using the done list like that is now ok since everything is
+	 * queues. Using the idle list like that is now ok since everything is
 	 * locked in place.
 	 */
-	list_for_each_entry(bo_va, &amp;vm-&gt;done, base.vm_status)
+	list_for_each_entry(bo_va, &amp;vm-&gt;always_valid.idle, base.vm_status)
 		dma_fence_wait(bo_va-&gt;last_pt_update, false);
 	dma_fence_wait(vm-&gt;last_update, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b89013a6aa0b..1223d1e86afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -138,143 +138,127 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
 	dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
 }
 
-/**
- * amdgpu_vm_bo_evicted - vm_bo is evicted
- *
- * @vm_bo: vm_bo which is evicted
- *
- * State for PDs/PTs and per VM BOs which are not at the location they should
- * be.
+/* Initialize the amdgpu_vm_bo_status object */
+static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
+{
+	INIT_LIST_HEAD(&amp;lists-&gt;evicted);
+	INIT_LIST_HEAD(&amp;lists-&gt;moved);
+	INIT_LIST_HEAD(&amp;lists-&gt;idle);
+}
+
+/*
+ * Make sure we have the lock to modify the vm_bo status and return the object
+ * with the status lists.
  */
-static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
+static struct amdgpu_vm_bo_status *
+amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
 {
 	struct amdgpu_vm *vm = vm_bo-&gt;vm;
 	struct amdgpu_bo *bo = vm_bo-&gt;bo;
 
-	vm_bo-&gt;moved = true;
-	amdgpu_vm_assert_locked(vm);
-	if (bo-&gt;tbo.type == ttm_bo_type_kernel)
-		list_move(&amp;vm_bo-&gt;vm_status, &amp;vm-&gt;evicted);
-	else
-		list_move_tail(&amp;vm_bo-&gt;vm_status, &amp;vm-&gt;evicted);
-}
-/**
- * amdgpu_vm_bo_moved - vm_bo is moved
- *
- * @vm_bo: vm_bo which is moved
- *
- * State for per VM BOs which are moved, but that change is not yet reflected
- * in the page tables.
- */
-static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
-{
-	amdgpu_vm_assert_locked(vm_bo-&gt;vm);
-	list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;moved);
-}
+	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
+		/* No extra locking needed, protected by the root PD resv lock */
+		amdgpu_vm_assert_locked(vm);
 
-/**
- * amdgpu_vm_bo_idle - vm_bo is idle
- *
- * @vm_bo: vm_bo which is now idle
- *
- * State for PDs/PTs and per VM BOs which have gone through the state machine
- * and are now idle.
- */
-static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
-{
-	amdgpu_vm_assert_locked(vm_bo-&gt;vm);
-	list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;idle);
-	vm_bo-&gt;moved = false;
+		if (bo-&gt;tbo.type == ttm_bo_type_kernel)
+			return &amp;vm-&gt;kernel;
+
+		return &amp;vm-&gt;always_valid;
+	}
+
+	spin_lock(&amp;vm_bo-&gt;vm-&gt;individual_lock);
+	return &amp;vm-&gt;individual;
 }
 
-/**
- * amdgpu_vm_bo_invalidated - vm_bo is invalidated
- *
- * @vm_bo: vm_bo which is now invalidated
- *
- * State for normal BOs which are invalidated and that change not yet reflected
- * in the PTs.
- */
-static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
+/* Eventually unlock the status list lock again */
+static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&amp;vm_bo-&gt;vm-&gt;invalidated_lock);
-	list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;invalidated);
-	spin_unlock(&amp;vm_bo-&gt;vm-&gt;invalidated_lock);
+	if (amdgpu_vm_is_bo_always_valid(vm_bo-&gt;vm, vm_bo-&gt;bo))
+		amdgpu_vm_assert_locked(vm_bo-&gt;vm);
+	else
+		spin_unlock(&amp;vm_bo-&gt;vm-&gt;individual_lock);
 }
 
 /**
- * amdgpu_vm_bo_evicted_user - vm_bo is evicted
+ * amdgpu_vm_bo_evicted - vm_bo is evicted
  *
  * @vm_bo: vm_bo which is evicted
  *
- * State for BOs used by user mode queues which are not at the location they
- * should be.
+ * State for vm_bo objects meaning the underlying BO was evicted and need to
+ * move in place again.
  */
-static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo-&gt;vm);
+	struct amdgpu_vm_bo_status *lists;
+
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
 	vm_bo-&gt;moved = true;
-	list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;evicted_user);
+	list_move(&amp;vm_bo-&gt;vm_status, &amp;lists-&gt;evicted);
+	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
-
 /**
- * amdgpu_vm_bo_relocated - vm_bo is reloacted
+ * amdgpu_vm_bo_moved - vm_bo is moved
  *
- * @vm_bo: vm_bo which is relocated
+ * @vm_bo: vm_bo which is moved
  *
- * State for PDs/PTs which needs to update their parent PD.
- * For the root PD, just move to idle state.
+ * State for vm_bo objects meaning the underlying BO was moved but the new
+ * location not yet reflected in the page tables.
  */
-static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo-&gt;vm);
-	if (vm_bo-&gt;bo-&gt;parent)
-		list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;relocated);
-	else
-		amdgpu_vm_bo_idle(vm_bo);
+	struct amdgpu_vm_bo_status *lists;
+	struct amdgpu_bo *bo = vm_bo-&gt;bo;
+
+	/*
+	 * The root PD doesn't have a parent PDE and goes directly into the
+	 * idle state.
+	 */
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
+	if (bo &amp;&amp; bo-&gt;tbo.type == ttm_bo_type_kernel &amp;&amp; !bo-&gt;parent) {
+		vm_bo-&gt;moved = false;
+		list_move(&amp;vm_bo-&gt;vm_status, &amp;lists-&gt;idle);
+	} else {
+		vm_bo-&gt;moved = true;
+		list_move(&amp;vm_bo-&gt;vm_status, &amp;lists-&gt;moved);
+	}
+	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
 
 /**
- * amdgpu_vm_bo_done - vm_bo is done
+ * amdgpu_vm_bo_idle - vm_bo is idle
  *
- * @vm_bo: vm_bo which is now done
+ * @vm_bo: vm_bo which is now idle
  *
- * State for normal BOs which are invalidated and that change has been updated
- * in the PTs.
+ * State for vm_bo objects meaning we are done with the state machine and no
+ * further action is necessary.
  */
-static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo-&gt;vm);
-	list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;done);
+	struct amdgpu_vm_bo_status *lists;
+
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
+	if (!amdgpu_vm_is_bo_always_valid(vm_bo-&gt;vm, vm_bo-&gt;bo))
+		vm_bo-&gt;moved = false;
+	list_move(&amp;vm_bo-&gt;vm_status, &amp;lists-&gt;idle);
+	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
 
 /**
  * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
  * @vm: the VM which state machine to reset
  *
- * Move all vm_bo object in the VM into a state where they will be updated
- * again during validation.
+ * Move all vm_bo object in the VM into a state where their location will be
+ * updated in the page tables again.
  */
 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
-	struct amdgpu_vm_bo_base *vm_bo, *tmp;
-
-	spin_lock(&amp;vm-&gt;invalidated_lock);
-	list_splice_init(&amp;vm-&gt;done, &amp;vm-&gt;invalidated);
-	list_for_each_entry(vm_bo, &amp;vm-&gt;invalidated, vm_status)
-		vm_bo-&gt;moved = true;
-	spin_unlock(&amp;vm-&gt;invalidated_lock);
-
 	amdgpu_vm_assert_locked(vm);
-	list_for_each_entry_safe(vm_bo, tmp, &amp;vm-&gt;idle, vm_status) {
-		struct amdgpu_bo *bo = vm_bo-&gt;bo;
+	list_splice_init(&amp;vm-&gt;kernel.idle, &amp;vm-&gt;kernel.moved);
+	list_splice_init(&amp;vm-&gt;always_valid.idle, &amp;vm-&gt;always_valid.moved);
 
-		vm_bo-&gt;moved = true;
-		if (!bo || bo-&gt;tbo.type != ttm_bo_type_kernel)
-			list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;moved);
-		else if (bo-&gt;parent)
-			list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;relocated);
-	}
+	spin_lock(&amp;vm-&gt;individual_lock);
+	list_splice_init(&amp;vm-&gt;individual.idle, &amp;vm-&gt;individual.moved);
+	spin_unlock(&amp;vm-&gt;individual_lock);
 }
 
 /**
@@ -402,8 +386,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base-&gt;next = NULL;
 	INIT_LIST_HEAD(&amp;base-&gt;vm_status);
 
+	dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
 	if (!bo)
 		return;
+
 	base-&gt;next = bo-&gt;vm_bo;
 	bo-&gt;vm_bo = base;
 
@@ -412,27 +398,22 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	amdgpu_vm_update_stats_locked(base, bo-&gt;tbo.resource, +1);
 	spin_unlock(&amp;vm-&gt;stats_lock);
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
+		amdgpu_vm_bo_idle(base);
 		return;
-
-	dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
+	}
 
 	ttm_bo_set_bulk_move(&amp;bo-&gt;tbo, &amp;vm-&gt;lru_bulk_move);
-	if (bo-&gt;tbo.type == ttm_bo_type_kernel &amp;&amp; bo-&gt;parent)
-		amdgpu_vm_bo_relocated(base);
-	else
-		amdgpu_vm_bo_idle(base);
 
+	/*
+	 * When a per VM isn't in the desired domain put it into the evicted
+	 * state to make sure that it gets validated on the next best occasion.
+	 */
 	if (bo-&gt;preferred_domains &amp;
 	    amdgpu_mem_type_to_domain(bo-&gt;tbo.resource-&gt;mem_type))
-		return;
-
-	/*
-	 * we checked all the prerequisites, but it looks like this per vm bo
-	 * is currently evicted. add the bo to the evicted list to make sure it
-	 * is validated on next vm use to avoid fault.
-	 * */
-	amdgpu_vm_bo_evicted(base);
+		amdgpu_vm_bo_moved(base);
+	else
+		amdgpu_vm_bo_evicted(base);
 }
 
 /**
@@ -453,41 +434,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 }
 
 /**
- * amdgpu_vm_lock_done_list - lock all BOs on the done list
+ * amdgpu_vm_lock_individual - lock all BOs on the individual idle list
  * @vm: vm providing the BOs
  * @exec: drm execution context
  * @num_fences: number of extra fences to reserve
  *
- * Lock the BOs on the done list in the DRM execution context.
+ * Lock the BOs on the individual idle list in the DRM execution context.
  */
-int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
-			     unsigned int num_fences)
+int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
+			      unsigned int num_fences)
 {
-	struct list_head *prev = &amp;vm-&gt;done;
+	struct list_head *prev = &amp;vm-&gt;individual.idle;
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo *bo;
 	int ret;
 
 	/* We can only trust prev-&gt;next while holding the lock */
-	spin_lock(&amp;vm-&gt;invalidated_lock);
-	while (!list_is_head(prev-&gt;next, &amp;vm-&gt;done)) {
+	spin_lock(&amp;vm-&gt;individual_lock);
+	while (!list_is_head(prev-&gt;next, &amp;vm-&gt;individual.idle)) {
 		bo_va = list_entry(prev-&gt;next, typeof(*bo_va), base.vm_status);
 
 		bo = bo_va-&gt;base.bo;
 		if (bo) {
 			amdgpu_bo_ref(bo);
-			spin_unlock(&amp;vm-&gt;invalidated_lock);
+			spin_unlock(&amp;vm-&gt;individual_lock);
 
 			ret = drm_exec_prepare_obj(exec, &amp;bo-&gt;tbo.base, 1);
 			amdgpu_bo_unref(&amp;bo);
 			if (unlikely(ret))
 				return ret;
 
-			spin_lock(&amp;vm-&gt;invalidated_lock);
+			spin_lock(&amp;vm-&gt;individual_lock);
 		}
 		prev = prev-&gt;next;
 	}
-	spin_unlock(&amp;vm-&gt;invalidated_lock);
+	spin_unlock(&amp;vm-&gt;individual_lock);
 
 	return 0;
 }
@@ -584,9 +565,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
 	struct amdgpu_vm_bo_base *bo_base, *tmp;
-	struct amdgpu_bo *bo;
 	int r;
 
+	dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
 	if (vm-&gt;generation != new_vm_generation) {
 		vm-&gt;generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
@@ -596,38 +577,59 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			return r;
 	}
 
-	list_for_each_entry_safe(bo_base, tmp, &amp;vm-&gt;evicted, vm_status) {
-		bo = bo_base-&gt;bo;
-
-		r = validate(param, bo);
+	list_for_each_entry_safe(bo_base, tmp, &amp;vm-&gt;kernel.evicted, vm_status) {
+		r = validate(param, bo_base-&gt;bo);
 		if (r)
 			return r;
 
-		if (bo-&gt;tbo.type != ttm_bo_type_kernel) {
-			amdgpu_vm_bo_moved(bo_base);
-		} else {
-			vm-&gt;update_funcs-&gt;map_table(to_amdgpu_bo_vm(bo));
-			amdgpu_vm_bo_relocated(bo_base);
-		}
+		vm-&gt;update_funcs-&gt;map_table(to_amdgpu_bo_vm(bo_base-&gt;bo));
+		amdgpu_vm_bo_moved(bo_base);
 	}
 
-	if (ticket) {
-		list_for_each_entry_safe(bo_base, tmp, &amp;vm-&gt;evicted_user,
-					 vm_status) {
-			bo = bo_base-&gt;bo;
-			dma_resv_assert_held(bo-&gt;tbo.base.resv);
+	/*
+	 * As soon as all page tables are in place we can start updating them
+	 * again.
+	 */
+	amdgpu_vm_eviction_lock(vm);
+	vm-&gt;evicting = false;
+	amdgpu_vm_eviction_unlock(vm);
 
-			r = validate(param, bo);
-			if (r)
-				return r;
+	list_for_each_entry_safe(bo_base, tmp, &amp;vm-&gt;always_valid.evicted,
+				 vm_status) {
+		r = validate(param, bo_base-&gt;bo);
+		if (r)
+			return r;
 
-			amdgpu_vm_bo_invalidated(bo_base);
-		}
+		amdgpu_vm_bo_moved(bo_base);
 	}
 
-	amdgpu_vm_eviction_lock(vm);
-	vm-&gt;evicting = false;
-	amdgpu_vm_eviction_unlock(vm);
+	if (!ticket)
+		return 0;
+
+	spin_lock(&amp;vm-&gt;individual_lock);
+restart:
+	list_for_each_entry(bo_base, &amp;vm-&gt;individual.evicted, vm_status) {
+		struct amdgpu_bo *bo = bo_base-&gt;bo;
+
+		if (dma_resv_locking_ctx(bo-&gt;tbo.base.resv) != ticket)
+			continue;
+
+		spin_unlock(&amp;vm-&gt;individual_lock);
+
+		r = validate(param, bo);
+		if (r)
+			return r;
+
+		amdgpu_vm_bo_moved(bo_base);
+
+		/* It's a bit inefficient to always jump back to the start, but
+		 * we would need to re-structure the KFD for properly fixing
+		 * that.
+		 */
+		spin_lock(&amp;vm-&gt;individual_lock);
+		goto restart;
+	}
+	spin_unlock(&amp;vm-&gt;individual_lock);
 
 	return 0;
 }
@@ -652,7 +654,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm-&gt;evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	ret &amp;= list_empty(&amp;vm-&gt;evicted);
+	ret &amp;= list_empty(&amp;vm-&gt;kernel.evicted);
 
 	spin_lock(&amp;vm-&gt;immediate.lock);
 	ret &amp;= !vm-&gt;immediate.stopped;
@@ -952,7 +954,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 
 	amdgpu_vm_assert_locked(vm);
 
-	if (list_empty(&amp;vm-&gt;relocated))
+	if (list_empty(&amp;vm-&gt;kernel.moved))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &amp;idx))
@@ -968,7 +970,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &amp;vm-&gt;relocated, vm_status) {
+	list_for_each_entry(entry, &amp;vm-&gt;kernel.moved, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry-&gt;moved;
 
@@ -984,9 +986,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&amp;vm-&gt;tlb_seq);
 
-	list_for_each_entry_safe(entry, tmp, &amp;vm-&gt;relocated, vm_status) {
+	list_for_each_entry_safe(entry, tmp, &amp;vm-&gt;kernel.moved, vm_status)
 		amdgpu_vm_bo_idle(entry);
-	}
 
 error:
 	drm_dev_exit(idx);
@@ -1357,7 +1358,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		else
 			amdgpu_vm_bo_idle(&amp;bo_va-&gt;base);
 	} else {
-		amdgpu_vm_bo_done(&amp;bo_va-&gt;base);
+		amdgpu_vm_bo_idle(&amp;bo_va-&gt;base);
 	}
 
 	list_splice_init(&amp;bo_va-&gt;invalids, &amp;bo_va-&gt;valids);
@@ -1585,19 +1586,20 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	bool clear, unlock;
 	int r;
 
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;moved, base.vm_status) {
+	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;always_valid.moved,
+				 base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 	}
 
-	spin_lock(&amp;vm-&gt;invalidated_lock);
-	while (!list_empty(&amp;vm-&gt;invalidated)) {
-		bo_va = list_first_entry(&amp;vm-&gt;invalidated, struct amdgpu_bo_va,
-					 base.vm_status);
+	spin_lock(&amp;vm-&gt;individual_lock);
+	while (!list_empty(&amp;vm-&gt;individual.moved)) {
+		bo_va = list_first_entry(&amp;vm-&gt;individual.moved,
+					 typeof(*bo_va), base.vm_status);
 		resv = bo_va-&gt;base.bo-&gt;tbo.base.resv;
-		spin_unlock(&amp;vm-&gt;invalidated_lock);
+		spin_unlock(&amp;vm-&gt;individual_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
 		if (!adev-&gt;debug_vm &amp;&amp; dma_resv_trylock(resv)) {
@@ -1627,11 +1629,11 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		    drm_gem_is_imported(&amp;bo_va-&gt;base.bo-&gt;tbo.base) &amp;&amp;
 		    (!bo_va-&gt;base.bo-&gt;tbo.resource ||
 		     bo_va-&gt;base.bo-&gt;tbo.resource-&gt;mem_type == TTM_PL_SYSTEM))
-			amdgpu_vm_bo_evicted_user(&amp;bo_va-&gt;base);
+			amdgpu_vm_bo_evicted(&amp;bo_va-&gt;base);
 
-		spin_lock(&amp;vm-&gt;invalidated_lock);
+		spin_lock(&amp;vm-&gt;individual_lock);
 	}
-	spin_unlock(&amp;vm-&gt;invalidated_lock);
+	spin_unlock(&amp;vm-&gt;individual_lock);
 
 	return 0;
 }
@@ -2174,9 +2176,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&amp;vm-&gt;invalidated_lock);
+	spin_lock(&amp;vm-&gt;individual_lock);
 	list_del(&amp;bo_va-&gt;base.vm_status);
-	spin_unlock(&amp;vm-&gt;invalidated_lock);
+	spin_unlock(&amp;vm-&gt;individual_lock);
 
 	list_for_each_entry_safe(mapping, next, &amp;bo_va-&gt;valids, list) {
 		list_del(&amp;mapping-&gt;list);
@@ -2256,14 +2258,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 
 		if (bo_base-&gt;moved)
 			continue;
-		bo_base-&gt;moved = true;
-
-		if (bo-&gt;tbo.type == ttm_bo_type_kernel)
-			amdgpu_vm_bo_relocated(bo_base);
-		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
-			amdgpu_vm_bo_moved(bo_base);
-		else
-			amdgpu_vm_bo_invalidated(bo_base);
+		amdgpu_vm_bo_moved(bo_base);
 	}
 }
 
@@ -2554,15 +2549,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm-&gt;va = RB_ROOT_CACHED;
 	for (i = 0; i &lt; AMDGPU_MAX_VMHUBS; i++)
 		vm-&gt;reserved_vmid[i] = NULL;
-	INIT_LIST_HEAD(&amp;vm-&gt;evicted);
-	INIT_LIST_HEAD(&amp;vm-&gt;evicted_user);
-	INIT_LIST_HEAD(&amp;vm-&gt;relocated);
-	INIT_LIST_HEAD(&amp;vm-&gt;moved);
-	INIT_LIST_HEAD(&amp;vm-&gt;idle);
-	spin_lock_init(&amp;vm-&gt;invalidated_lock);
-	INIT_LIST_HEAD(&amp;vm-&gt;invalidated);
+
+	amdgpu_vm_bo_status_init(&amp;vm-&gt;kernel);
+	amdgpu_vm_bo_status_init(&amp;vm-&gt;always_valid);
+	spin_lock_init(&amp;vm-&gt;individual_lock);
+	amdgpu_vm_bo_status_init(&amp;vm-&gt;individual);
 	INIT_LIST_HEAD(&amp;vm-&gt;freed);
-	INIT_LIST_HEAD(&amp;vm-&gt;done);
 	INIT_KFIFO(vm-&gt;faults);
 	spin_lock_init(&amp;vm-&gt;stats_lock);
 
@@ -3005,100 +2997,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 }
 
 #if defined(CONFIG_DEBUG_FS)
-/**
- * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
- *
- * @vm: Requested VM for printing BO info
- * @m: debugfs file
- *
- * Print BO information in debugfs file for the VM
- */
-void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
-{
-	struct amdgpu_bo_va *bo_va, *tmp;
-	u64 total_idle = 0;
-	u64 total_evicted = 0;
-	u64 total_relocated = 0;
-	u64 total_moved = 0;
-	u64 total_invalidated = 0;
-	u64 total_done = 0;
-	unsigned int total_idle_objs = 0;
-	unsigned int total_evicted_objs = 0;
-	unsigned int total_relocated_objs = 0;
-	unsigned int total_moved_objs = 0;
-	unsigned int total_invalidated_objs = 0;
-	unsigned int total_done_objs = 0;
-	unsigned int id = 0;
 
-	amdgpu_vm_assert_locked(vm);
+/* print the debug info for a specific set of status lists */
+static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
+					     struct amdgpu_vm_bo_status *lists)
+{
+	struct amdgpu_vm_bo_base *base;
+	unsigned int id;
 
-	seq_puts(m, &quot;\tIdle BOs:\n&quot;);
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;idle, base.vm_status) {
-		if (!bo_va-&gt;base.bo)
-			continue;
-		total_idle += amdgpu_bo_print_info(id++, bo_va-&gt;base.bo, m);
-	}
-	total_idle_objs = id;
 	id = 0;
-
 	seq_puts(m, &quot;\tEvicted BOs:\n&quot;);
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;evicted, base.vm_status) {
-		if (!bo_va-&gt;base.bo)
+	list_for_each_entry(base, &amp;lists-&gt;evicted, vm_status) {
+		if (!base-&gt;bo)
 			continue;
-		total_evicted += amdgpu_bo_print_info(id++, bo_va-&gt;base.bo, m);
-	}
-	total_evicted_objs = id;
-	id = 0;
 
-	seq_puts(m, &quot;\tRelocated BOs:\n&quot;);
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;relocated, base.vm_status) {
-		if (!bo_va-&gt;base.bo)
-			continue;
-		total_relocated += amdgpu_bo_print_info(id++, bo_va-&gt;base.bo, m);
+		amdgpu_bo_print_info(id++, base-&gt;bo, m);
 	}
-	total_relocated_objs = id;
-	id = 0;
 
+	id = 0;
 	seq_puts(m, &quot;\tMoved BOs:\n&quot;);
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;moved, base.vm_status) {
-		if (!bo_va-&gt;base.bo)
+	list_for_each_entry(base, &amp;lists-&gt;moved, vm_status) {
+		if (!base-&gt;bo)
 			continue;
-		total_moved += amdgpu_bo_print_info(id++, bo_va-&gt;base.bo, m);
+
+		amdgpu_bo_print_info(id++, base-&gt;bo, m);
 	}
-	total_moved_objs = id;
-	id = 0;
 
-	seq_puts(m, &quot;\tInvalidated BOs:\n&quot;);
-	spin_lock(&amp;vm-&gt;invalidated_lock);
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;invalidated, base.vm_status) {
-		if (!bo_va-&gt;base.bo)
+	id = 0;
+	seq_puts(m, &quot;\tIdle BOs:\n&quot;);
+	list_for_each_entry(base, &amp;lists-&gt;moved, vm_status) {
+		if (!base-&gt;bo)
 			continue;
-		total_invalidated += amdgpu_bo_print_info(id++,	bo_va-&gt;base.bo, m);
+
+		amdgpu_bo_print_info(id++, base-&gt;bo, m);
 	}
-	spin_unlock(&amp;vm-&gt;invalidated_lock);
-	total_invalidated_objs = id;
-	id = 0;
+}
 
-	seq_puts(m, &quot;\tDone BOs:\n&quot;);
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;done, base.vm_status) {
-		if (!bo_va-&gt;base.bo)
-			continue;
-		total_done += amdgpu_bo_print_info(id++, bo_va-&gt;base.bo, m);
-	}
-	total_done_objs = id;
-
-	seq_printf(m, &quot;\tTotal idle size:        %12lld\tobjs:\t%d\n&quot;, total_idle,
-		   total_idle_objs);
-	seq_printf(m, &quot;\tTotal evicted size:     %12lld\tobjs:\t%d\n&quot;, total_evicted,
-		   total_evicted_objs);
-	seq_printf(m, &quot;\tTotal relocated size:   %12lld\tobjs:\t%d\n&quot;, total_relocated,
-		   total_relocated_objs);
-	seq_printf(m, &quot;\tTotal moved size:       %12lld\tobjs:\t%d\n&quot;, total_moved,
-		   total_moved_objs);
-	seq_printf(m, &quot;\tTotal invalidated size: %12lld\tobjs:\t%d\n&quot;, total_invalidated,
-		   total_invalidated_objs);
-	seq_printf(m, &quot;\tTotal done size:        %12lld\tobjs:\t%d\n&quot;, total_done,
-		   total_done_objs);
+/**
+ * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
+ *
+ * @vm: Requested VM for printing BO info
+ * @m: debugfs file
+ *
+ * Print BO information in debugfs file for the VM
+ */
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
+{
+	amdgpu_vm_assert_locked(vm);
+
+	seq_puts(m, &quot;\tKernel PT/PDs:\n&quot;);
+	amdgpu_debugfs_vm_bo_status_info(m, &amp;vm-&gt;kernel);
+
+	seq_puts(m, &quot;\tPer VM BOs:\n&quot;);
+	amdgpu_debugfs_vm_bo_status_info(m, &amp;vm-&gt;always_valid);
+
+	seq_puts(m, &quot;\tIndividual BOs:\n&quot;);
+	amdgpu_debugfs_vm_bo_status_info(m, &amp;vm-&gt;individual);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ae9449d5b00c..9b4a4e5c24f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -216,6 +216,23 @@ struct amdgpu_vm_bo_base {
 	bool				moved;
 };
 
+/*
+ * The following status lists contain amdgpu_vm_bo_base objects for
+ * either PD/PTs, per VM BOs or BOs with individual resv object.
+ *
+ * The state transits are: evicted -&gt; moved -&gt; idle
+ */
+struct amdgpu_vm_bo_status {
+	/* BOs evicted which need to move into place again */
+	struct list_head		evicted;
+
+	/* BOs which moved but new location hasn't been updated in the PDs/PTs */
+	struct list_head		moved;
+
+	/* BOs done with the state machine and need no further action */
+	struct list_head		idle;
+};
+
 /* provided by hw blocks that can write ptes, e.g., sdma */
 struct amdgpu_vm_pte_funcs {
 	/* number of dw to reserve per operation */
@@ -349,46 +366,25 @@ struct amdgpu_vm {
 	spinlock_t		stats_lock;
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
+	/* BO's belonging to PD/PT which are internal to the kernel. */
+	struct amdgpu_vm_bo_status	kernel;
+
 	/*
-	 * The following lists contain amdgpu_vm_bo_base objects for either
-	 * PDs, PTs or per VM BOs. The state transits are:
-	 *
-	 * evicted -&gt; relocated (PDs, PTs) or moved (per VM BOs) -&gt; idle
-	 *
-	 * Lists are protected by the root PD dma_resv lock.
+	 * BOs allocated by userspace where the dma_resv is shared with the
+	 * root PD
 	 */
-
-	/* Per-VM and PT BOs who needs a validation */
-	struct list_head	evicted;
-
-	/* PT BOs which relocated and their parent need an update */
-	struct list_head	relocated;
-
-	/* per VM BOs moved, but not yet updated in the PT */
-	struct list_head	moved;
-
-	/* All BOs of this VM not currently in the state machine */
-	struct list_head	idle;
+	struct amdgpu_vm_bo_status	always_valid;
 
 	/*
 	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
-	 * have their own dma_resv object and not depend on the root PD. Their
-	 * state transits are:
-	 *
-	 * evicted_user or invalidated -&gt; done
+	 * have their own dma_resv object and not depend on the root PD.
 	 *
-	 * Lists are protected by the invalidated_lock.
+	 * Lists are protected by the individual_lock.
 	 */
-	spinlock_t		invalidated_lock;
-
-	/* BOs for user mode queues that need a validation */
-	struct list_head	evicted_user;
-
-	/* regular invalidated BOs, but not yet updated in the PT */
-	struct list_head	invalidated;
+	spinlock_t			individual_lock;
 
-	/* BOs which are invalidated, has been updated in the PTs */
-	struct list_head        done;
+	/* Userspace BOs with individual resv object */
+	struct amdgpu_vm_bo_status	individual;
 
 	/*
 	 * This list contains amdgpu_bo_va_mapping objects which have been freed
@@ -508,8 +504,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
-int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
-			     unsigned int num_fences);
+int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
+			      unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
</pre>
    </blockquote>
  </body>
</html>

--------------0w6wmmi59n7SvFTFBwJRi6hg--
