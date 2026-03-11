Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F33FD0659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA3A10E185;
	Wed, 11 Mar 2026 08:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="md8MO4vW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFC810E185
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 08:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0qEnv3udlIA0r/cWU7WZxfdLTuy5GJpEXzmecHfGKhysAKXWVb1yf9ELbYtZKniuKoTXw8JJuN+6wQFCReVNfqPaIpNAX1htSOaHF1MboBhCxTA5PKMzQZElk7iYCms4T3o/A1FjZ99LzKDsXAYmbVQQBNcUUeztq1QvhYb1OUJBrhlIPWcGBbOdCV1y/TrWgpLc2rSiyAW2fLXt8JDCQwv2TMfglqMctJ2oFVkqvesLiC8OYgWKJTbw/tVQaeD2bqOF81RAN9OeiqHKFA8EOlRmGf9meQIcyRPBLXoE1S3Mj4zfFVd9eEBWpyz26eigeXnflucm16TKib7nSck/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUek6Dafpl2uq1pwvYvgK7fcg2kdJxvjN/ErjSHfLf0=;
 b=vSIXPfY6/LHY01tHczpTMKgnrHyfCVQ47ttGMoUYEmcjgLHQ5C/oES8dUueYBsVg+fapVMvs7mgovmTwR9BT6aNjV5e3/SCdXw3P36e5PVopxI/HGdbW1FCWLb4gHsZA7U63xHiy+3YNvfXmh68/zLzSeND5MJSCkAK/mEz+rlzg87R3FJ4tDBSPZ2xx7+XTZ4PfRF67/js12pfrIkg2YMXQdUDTkTvOOwsIxz2YXCtm8J821TmD00yCCUCbnjXPL3bGRIx6L6Pu9tUHbf3Bj2PHsKidP18/kN35zGokrdyn2dBGRyOt7kB5yrJ3aEWSXJeLmxziaDySEdNAf0vgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUek6Dafpl2uq1pwvYvgK7fcg2kdJxvjN/ErjSHfLf0=;
 b=md8MO4vWNTuuf7L2CNtybqxoRYHUtJEKoQ3l/+vIIaBNe/zEtWbNTUe0MI7+gV1zaWRFm+qq5+17oT/Fffo92fuOZCAFVxu+lbL8EXWQeM2mFqXeA9F21Da2/QpENLeEAT3Tk2UyLe9BWArhTLBJqPHBDzM/A6TfzNJpbEEcFoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 08:47:41 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 08:47:41 +0000
Content-Type: multipart/alternative;
 boundary="------------CLtZk40qO0MbcJUUvHy2JkcX"
Message-ID: <20cd6ab0-97de-41c3-8bb0-56f6ec47ae19@amd.com>
Date: Wed, 11 Mar 2026 14:17:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: restructure VM state machine
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-2-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-2-christian.koenig@amd.com>
X-ClientProxiedBy: MA5P287CA0179.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecf2839-cd33-4b3d-4358-08de7f4adae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|8096899003;
X-Microsoft-Antispam-Message-Info: OoFcv/0uHdjihODfPta9rfHgT6nlTtTmNKX/9qXm+/scryPD21hp2h7IJZv68FqSdaojgICoNEedL7KhFxhURmeul6eL5nAmst5B01d+XqfBiKwNHMq/GPIRSH4D/raEH1dmwXcCuCFncRvSiExC26wXLsmxOMDuTHNnG39pxyJ7x2a/x1Yt3HnwJeXQNnn/eAGEQf8VH1Afk8y0hhrRwN+/ecBei9TEv5Qp1e9eVSfnRSaDy00wxRErjiM2u0shwcmKkEMnJ2JjvxU79JvSv6BnBhsRQii2Co8aDeMeKt6X6f/hEGpu/C7xvegMlsQLv3G9rvl8G/t7KlJIkW/yFak7z2XNilswx3HtkApg6a5rUf3Sz6qPNCBgGGU6IJqB2PirAUCYpJ3CmSEjFD21LHyNtr0aStSiuumXgqCsUbIdoHJCWWt6y8pl/lE0mdVOj24a2UxCR6ELUqrAs9QCBoItJ31C4BQcSMl4GWdzQe7l14XkVDv0NUsFnc7PE57c/wGhDQn209WbmtP4BkpokcgITEfZr4vY4hqFBJRo7kO8vnOl5ESWBdHMx7AVtRL3sSfn2dYCaLUiXtjg8CSy45O0DSLASocmGHhrwAIBp4oY9W4qwfyHfeaLoAE0YI5V/vCNHnj/95JhbQPFOxcBqJ/9RZoxIkfqbBANLY5t1xFbKkysj6Yb/Qk+BaunwgZltsCjyUzsNgZhYXO4vqZkdNdyyk7kriWnq4ZfAKv2YS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5STjg1VHhwM0gzMkhYNEhpb0ZlaTZxUXZ1bThoSkFLbWVWUGM5R0ttTWtn?=
 =?utf-8?B?VnBRRzRoMGpNNXdPekNpK0NFT0JzQ3NZSzBpbmgwak5UK1p4eWwzcmFEU2or?=
 =?utf-8?B?cmZjVDUyR2h6a0RtdFN4Y3BjeC9Vb2VTT3cwREdkZjhUaStIUGI4eFIydXJi?=
 =?utf-8?B?OGV4M2hoQ1Byd25YOE4vMGFLRDQydnZyL2Z1VXhOQklDOWdORXppZ2hOQk15?=
 =?utf-8?B?UWRvR2VPcFRuSjBXampjdm84WFhEVzFHVllQODlDODFkYzYwSjE5V1MxeWNa?=
 =?utf-8?B?MXpiVlFaM281dG5iRFhqcFJZNWRlNjJXbUpKaDdLd0JXVFVTc3ExLzJNYmlK?=
 =?utf-8?B?ZWRtYXlmamJEVzd5UEZmMlZmRXpVNXhJc0l6U3J1eG1nNDJTYjI1M090Zmor?=
 =?utf-8?B?NDRwLzB1d0ZVOExHdlFNb2d1S2tOS00wNW93SGRFQnVsL1NERzI0OWw4LzlR?=
 =?utf-8?B?eWRBWEtIbENXSTNDMS9CR2piWFFyTlNYNFhXOENyVFVybENXTWNtRjg2VXZp?=
 =?utf-8?B?bVJPSnorem1mN05ndVdBVks5ZTFCSjJQWWZKbDhJSGdPOStCTDBjQnBNeVdp?=
 =?utf-8?B?a1d1bTJveG9Hazh2cHNNUXJiZnUyTGlESHVWWktkbnFKQVhsdFVDQnFWMlh1?=
 =?utf-8?B?MXNzZzljN1FyN3FTZ1FWdis2ZUZuTWdOazVlZ3M2NGQ1Sm5wMk1Zb1lZR2Z1?=
 =?utf-8?B?dUJOOW5waTFSMU5ieUlMaVBZeGdMR0JiM0FPUlNaVk5DRXJMMzdTUVg2TVZt?=
 =?utf-8?B?QitNZ0RkQ3hNcU1PUXZRdTQ2KzlGcDN6ZGs1MXlWK0VHcVlsQlVVeVprcG4y?=
 =?utf-8?B?bHBQVDF0amNZOWxMa1c3SUdtRVYyNTgzSUU3UWpJTEc1am83NW5nN2MxT2Fn?=
 =?utf-8?B?TWZIcXF4bEpIa1FGSnJhdzNCWkdPSDhOR3pwVGt1dGlvb3NGYnFJSE82YzRI?=
 =?utf-8?B?cGI5QXF5ZFF4T1RQSk9Rdlp2cE4zRlk5b3ZKakJjZGRIbzZPV05wZHloUWZ0?=
 =?utf-8?B?V2tCSkVwOThManBYU0I2L2tFUTZ5a3kzdWxCa1BpUmlySUFMbkphQStKYlBL?=
 =?utf-8?B?Rjhpc1pTeWM1UXYvOGMyRDV5WndhQTlSQzZhOGtNdStWMHVsTk1aOVJTcVNs?=
 =?utf-8?B?NGNFc1VteDRQTWtaMjNWbUZxNmhoRmRNdm0rU2lHZ1ZNbEtOdmxvaThDd0Ux?=
 =?utf-8?B?VXg5UGF4M0RkV1BWamZKM1F6T0VLellvL3h5UnRwcmNKNDVpcTZTaDNiV0cr?=
 =?utf-8?B?eFhWYk52RFk3bDU3b2VFMjkvbFI5aVdpR3VDVWNBbzhmN2RzV0pSY3NleW5i?=
 =?utf-8?B?RE1xZVV6Z1VSQjlpMTg0OUxGYXFzTTdVcmk0dEkvNWFwUGtKZTloODgxZDZ4?=
 =?utf-8?B?WWVuSURjc3p6dnMxcDQ0UStqbktVUWd3N3pWN0RFUG42RTBwWmFPbXBpMEU5?=
 =?utf-8?B?NStNR3pHWk9ObldTODBncXFjWkRnaGRGVzVsUGE1WlRJdUVtZWxXaFVUVTFD?=
 =?utf-8?B?U2l3enBCYlJnejkzL0RmTXNUb3BzZGk0VmsrMHRYQVZDaXFyYlZmR1d0S0R3?=
 =?utf-8?B?RFNLWXd5aTl1WEdHT0lwNzFEa1h0WUc1bXVTZTJ2Ymx6aWhpb0xJQU5BTk9x?=
 =?utf-8?B?Q1p5T3JLOVRxTjh6N3kxTWVqYmMrVFUxMmlGZFMyWHdGK2FRTW1mVzBQUnds?=
 =?utf-8?B?OFZIb0lONTRzSGpMVlhERlBkMmR6RnJtWFpTN2E1Yzc0VU5QQW1kcUxjM2l0?=
 =?utf-8?B?cnB0QXphMm4vd2R5N2lOa21uaGpyVDZBazhZRWJtdnUwK3c1SnczanQvdkU3?=
 =?utf-8?B?bUVDdUFNRjZMbVpTMHlPZE14aEV2M0NyUCt5YUczS0VhNGZoMmJBYmkyNXFz?=
 =?utf-8?B?eDRCYld5ZllpR28yVjQ2cEpzWm1IOTlVb0lzaTFzUUZ3ajZGOTdVZzNyc0tq?=
 =?utf-8?B?ZHo1YUNqTHFUdDJsWjJkdFdCaUM3aHNqWkVQQ3k0bzdqb0RVM3BqVTZ4ZlBH?=
 =?utf-8?B?WUk2Z05GbHZFRW1SaVZqS2FDUVpHdEMrbU9DaTBwUGZHMkE4OGlUNnVFNmo0?=
 =?utf-8?B?OHBzMmRrektIN2x4aWRhWmh4YS9HcWhtZGV0RmlpNEgwL1d6QnZaOTltR1Uz?=
 =?utf-8?B?c3BKd0xTNmFub0Z4OUdOUFhxU2w3RkE5ZTlxalJETnNTMVg1TUpveTBLY04y?=
 =?utf-8?B?MzdJSUo1QmZmaDZLUXFRK2pUbjZ4K0FZaHNGU1FVQnNrTVplYzV0TFdpUGZ1?=
 =?utf-8?B?eTFLNXB5b1RmaW5tbzkzcC9kdHJtU1g0Z1VTSThZT2pKbjBBYy82a0I0STVR?=
 =?utf-8?B?QlMrUlZoZEt4Y1Q2OTdOaUp2Ujc2bGRqUlZ0KzROTXpjTkU5NXA4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecf2839-cd33-4b3d-4358-08de7f4adae7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 08:47:41.4408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vr6VZdtYo3yPpOOAcl0DXEwczVwXO0MVQRyPAdbYU8FJ1nrNOKkTfcE0Yd0jTzwJ/a/ukZ35cGNu/eRNiZHNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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

--------------CLtZk40qO0MbcJUUvHy2JkcX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11-03-2026 12:43 am, Christian König wrote:
> Instead of comming up with more sophisticated names for states a VM BO
> can be in group them by the type of BO first and then by the state.
>
> So we end with BO type kernel, shared_resv and individual_resv and then
> states evicted, moved and idle.
>
> Not much functional change, except that evicted_user is moved back
> together with the other BOs again which makes the handling in
> amdgpu_vm_validate() a bit more complex. Also fixes a problem with user
> queues and amdgpu_vm_ready().
Some typos in commit message.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 397 +++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  55 ++-
>   3 files changed, 197 insertions(+), 265 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 32541f1bde6d..65783f9584c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1041,8 +1041,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   	int ret;
>   
>   	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated,
> +	while (!list_empty(&vm->individual_resv.evicted)) {
> +		bo_va = list_first_entry(&vm->individual_resv.evicted,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
>   		spin_unlock(&vm->invalidated_lock);
> @@ -1057,7 +1057,7 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		/* This moves the bo_va to the done list */
> +		/* This moves the bo_va to the idle list */
>   		ret = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (ret)
>   			return ret;
> @@ -1139,7 +1139,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	key = 0;
>   	/* Validate User Ptr BOs */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +	list_for_each_entry(bo_va, &vm->individual_resv.idle, base.vm_status) {
>   		bo = bo_va->base.bo;
>   		if (!bo)
>   			continue;
> @@ -1192,7 +1192,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   	 * queues. Using the done list like that is now ok since everything is
>   	 * locked in place.
>   	 */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status)
> +	list_for_each_entry(bo_va, &vm->individual_resv.idle, base.vm_status)
>   		dma_fence_wait(bo_va->last_pt_update, false);
>   	dma_fence_wait(vm->last_update, false);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..3ce17fe1a3b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -138,143 +138,115 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
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
> +		return &vm->shared_resv;
> +	}
> +
> +	spin_lock(&vm_bo->vm->invalidated_lock);
> +	return &vm->individual_resv;
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
> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		spin_unlock(&vm_bo->vm->invalidated_lock);
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
>   	vm_bo->moved = true;
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
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
> +
> +	vm_bo->moved = true;
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	list_move(&vm_bo->vm_status, &lists->moved);
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
> +	amdgpu_vm_assert_locked(vm);
> +	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> +	list_splice_init(&vm->shared_resv.idle, &vm->shared_resv.moved);
>   
>   	spin_lock(&vm->invalidated_lock);
> -	list_splice_init(&vm->done, &vm->invalidated);
> -	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
> -		vm_bo->moved = true;
> +	list_splice_init(&vm->individual_resv.idle, &vm->individual_resv.moved);
>   	spin_unlock(&vm->invalidated_lock);
> -
> -	amdgpu_vm_assert_locked(vm);
> -	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
> -		struct amdgpu_bo *bo = vm_bo->bo;
> -
> -		vm_bo->moved = true;
> -		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -		else if (bo->parent)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	}
>   }
>   
>   /**
> @@ -412,14 +384,16 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>   	spin_unlock(&vm->stats_lock);
>   
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		amdgpu_vm_bo_idle(base);
>   		return;
> +	}
>   
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   
>   	ttm_bo_set_bulk_move(&bo->tbo, &vm->lru_bulk_move);
>   	if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
> -		amdgpu_vm_bo_relocated(base);
> +		amdgpu_vm_bo_moved(base);
>   	else
>   		amdgpu_vm_bo_idle(base);
>   
> @@ -453,24 +427,24 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   }
>   
>   /**
> - * amdgpu_vm_lock_done_list - lock all BOs on the done list
> + * amdgpu_vm_lock_done_list - lock all BOs on the individual idle list
>    * @vm: vm providing the BOs
>    * @exec: drm execution context
>    * @num_fences: number of extra fences to reserve
>    *
> - * Lock the BOs on the done list in the DRM execution context.
> + * Lock the BOs on the individual idle list in the DRM execution context.
>    */
>   int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>   			     unsigned int num_fences)
>   {
> -	struct list_head *prev = &vm->done;
> +	struct list_head *prev = &vm->individual_resv.idle;
>   	struct amdgpu_bo_va *bo_va;
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
>   	/* We can only trust prev->next while holding the lock */
>   	spin_lock(&vm->invalidated_lock);
> -	while (!list_is_head(prev->next, &vm->done)) {
> +	while (!list_is_head(prev->next, &vm->individual_resv.idle)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>   
>   		bo = bo_va->base.bo;
> @@ -584,7 +558,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>   	struct amdgpu_vm_bo_base *bo_base, *tmp;
> -	struct amdgpu_bo *bo;
>   	int r;
>   
>   	if (vm->generation != new_vm_generation) {
> @@ -596,38 +569,52 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> +	amdgpu_vm_eviction_lock(vm);
> +	vm->evicting = false;
> +	amdgpu_vm_eviction_unlock(vm);
>   
> -			r = validate(param, bo);
> -			if (r)
> -				return r;
> +	list_for_each_entry_safe(bo_base, tmp, &vm->shared_resv.evicted,
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
> +	spin_lock(&vm->invalidated_lock);
> +	list_for_each_entry(bo_base, &vm->individual_resv.evicted, vm_status) {
> +		struct amdgpu_bo *bo = bo_base->bo;
> +
> +		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket)
> +			continue;
> +
> +		spin_unlock(&vm->invalidated_lock);
> +
> +		r = validate(param, bo);
> +		if (r)
> +			return r;
> +
> +		/* need to grab the invalidated lock to trust prev here */
> +		spin_lock(&vm->invalidated_lock);
> +		tmp = list_entry(bo_base->vm_status.prev, typeof(*tmp),
> +				 vm_status);
> +		list_move(&bo_base->vm_status, &vm->individual_resv.moved);
> +		bo_base = tmp;
> +	}
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -652,7 +639,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	ret &= list_empty(&vm->evicted);
> +	ret &= list_empty(&vm->kernel.evicted);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -952,7 +939,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	if (list_empty(&vm->relocated))
> +	if (list_empty(&vm->kernel.moved))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -968,7 +955,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -984,9 +971,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
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
> @@ -1357,7 +1343,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		else
>   			amdgpu_vm_bo_idle(&bo_va->base);
>   	} else {
> -		amdgpu_vm_bo_done(&bo_va->base);
> +		amdgpu_vm_bo_idle(&bo_va->base);
>   	}
>   
>   	list_splice_init(&bo_va->invalids, &bo_va->valids);
> @@ -1585,7 +1571,8 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	bool clear, unlock;
>   	int r;
>   
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> +	list_for_each_entry_safe(bo_va, tmp, &vm->shared_resv.moved,
> +				 base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
> @@ -1593,9 +1580,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	}
>   
>   	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
> -					 base.vm_status);
> +	while (!list_empty(&vm->individual_resv.moved)) {
> +		bo_va = list_first_entry(&vm->individual_resv.moved,
> +					 typeof(*bo_va), base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
>   		spin_unlock(&vm->invalidated_lock);
>   
> @@ -1627,7 +1614,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>   		    (!bo_va->base.bo->tbo.resource ||
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
> -			amdgpu_vm_bo_evicted_user(&bo_va->base);
> +			amdgpu_vm_bo_evicted(&bo_va->base);
>   
>   		spin_lock(&vm->invalidated_lock);
>   	}
> @@ -2256,14 +2243,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
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
> @@ -2554,15 +2534,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->va = RB_ROOT_CACHED;
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		vm->reserved_vmid[i] = NULL;
> -	INIT_LIST_HEAD(&vm->evicted);
> -	INIT_LIST_HEAD(&vm->evicted_user);
> -	INIT_LIST_HEAD(&vm->relocated);
> -	INIT_LIST_HEAD(&vm->moved);
> -	INIT_LIST_HEAD(&vm->idle);
> +
> +	amdgpu_vm_bo_status_init(&vm->kernel);
> +	amdgpu_vm_bo_status_init(&vm->shared_resv);
>   	spin_lock_init(&vm->invalidated_lock);
> -	INIT_LIST_HEAD(&vm->invalidated);
> +	amdgpu_vm_bo_status_init(&vm->individual_resv);
Nothing function but we could move the above function along with other 
groups together just for better code readability.
>   	INIT_LIST_HEAD(&vm->freed);
> -	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
>   	spin_lock_init(&vm->stats_lock);
>   
> @@ -3005,100 +2982,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->shared_resv);
> +
> +	seq_puts(m, "\tIndividual BOs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual_resv);
>   }
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ae9449d5b00c..aa1180bf3caa 100644
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
> @@ -349,46 +366,22 @@ struct amdgpu_vm {
>   	spinlock_t		stats_lock;
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
> -	/*
> -	 * The following lists contain amdgpu_vm_bo_base objects for either
> -	 * PDs, PTs or per VM BOs. The state transits are:
> -	 *
> -	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> -	 *
> -	 * Lists are protected by the root PD dma_resv lock.
> -	 */
> -
> -	/* Per-VM and PT BOs who needs a validation */
> -	struct list_head	evicted;
> -
> -	/* PT BOs which relocated and their parent need an update */
> -	struct list_head	relocated;
> +	/* kernel PD/Pts, resv is shared with the root PD */
> +	struct amdgpu_vm_bo_status	kernel;
>   
> -	/* per VM BOs moved, but not yet updated in the PT */
> -	struct list_head	moved;
> -
> -	/* All BOs of this VM not currently in the state machine */
> -	struct list_head	idle;
> +	/* userspace BOs where the resv object is shared with the root PD */
> +	struct amdgpu_vm_bo_status	shared_resv;
>   
>   	/*
>   	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
> -	 * have their own dma_resv object and not depend on the root PD. Their
> -	 * state transits are:
> -	 *
> -	 * evicted_user or invalidated -> done
> +	 * have their own dma_resv object and not depend on the root PD.

We might want to move the explanation before the individual_resv list 
for clarity. Grouping idea seems great and seems to simply the things to 
good extent. But just for better explanation and more clarity for others 
and documentation purposes if we want can add more details:

kernel:       BO's belonging to PD/PT and other BOs which are internal to the kernel.

shared_resv      BO's belonging to per process but still allocated by 
the driver/kernel for each process, for name can we says per_process

individual_resv : BO's whose memory is allocated by user for completely 
user managed buffers per process (User ptrs), alternate name : 
user_private or something.

Apart from the nitpicks, the change looks great and simplify things.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards Sunil Khatri

>   	 *
>   	 * Lists are protected by the invalidated_lock.
>   	 */
>   	spinlock_t		invalidated_lock;
>   
> -	/* BOs for user mode queues that need a validation */
> -	struct list_head	evicted_user;
> -
> -	/* regular invalidated BOs, but not yet updated in the PT */
> -	struct list_head	invalidated;
> -
> -	/* BOs which are invalidated, has been updated in the PTs */
> -	struct list_head        done;
> +	/* Userspace BOs with individual resv object */
> +	struct amdgpu_vm_bo_status	individual_resv;
>   
>   	/*
>   	 * This list contains amdgpu_bo_va_mapping objects which have been freed
--------------CLtZk40qO0MbcJUUvHy2JkcX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11-03-2026 12:43 am, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260310191327.2279-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">Instead of comming up with more sophisticated names for states a VM BO
can be in group them by the type of BO first and then by the state.

So we end with BO type kernel, shared_resv and individual_resv and then
states evicted, moved and idle.

Not much functional change, except that evicted_user is moved back
together with the other BOs again which makes the handling in
amdgpu_vm_validate() a bit more complex. Also fixes a problem with user
queues and amdgpu_vm_ready().</pre>
    </blockquote>
    Some typos in commit message.
    <blockquote type="cite" cite="mid:20260310191327.2279-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 397 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  55 ++-
 3 files changed, 197 insertions(+), 265 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 32541f1bde6d..65783f9584c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1041,8 +1041,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	int ret;
 
 	spin_lock(&amp;vm-&gt;invalidated_lock);
-	while (!list_empty(&amp;vm-&gt;invalidated)) {
-		bo_va = list_first_entry(&amp;vm-&gt;invalidated,
+	while (!list_empty(&amp;vm-&gt;individual_resv.evicted)) {
+		bo_va = list_first_entry(&amp;vm-&gt;individual_resv.evicted,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
 		spin_unlock(&amp;vm-&gt;invalidated_lock);
@@ -1057,7 +1057,7 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 		if (ret)
 			return ret;
 
-		/* This moves the bo_va to the done list */
+		/* This moves the bo_va to the idle list */
 		ret = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (ret)
 			return ret;
@@ -1139,7 +1139,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 	key = 0;
 	/* Validate User Ptr BOs */
-	list_for_each_entry(bo_va, &amp;vm-&gt;done, base.vm_status) {
+	list_for_each_entry(bo_va, &amp;vm-&gt;individual_resv.idle, base.vm_status) {
 		bo = bo_va-&gt;base.bo;
 		if (!bo)
 			continue;
@@ -1192,7 +1192,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	 * queues. Using the done list like that is now ok since everything is
 	 * locked in place.
 	 */
-	list_for_each_entry(bo_va, &amp;vm-&gt;done, base.vm_status)
+	list_for_each_entry(bo_va, &amp;vm-&gt;individual_resv.idle, base.vm_status)
 		dma_fence_wait(bo_va-&gt;last_pt_update, false);
 	dma_fence_wait(vm-&gt;last_update, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b89013a6aa0b..3ce17fe1a3b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -138,143 +138,115 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
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
+		return &amp;vm-&gt;shared_resv;
+	}
+
+	spin_lock(&amp;vm_bo-&gt;vm-&gt;invalidated_lock);
+	return &amp;vm-&gt;individual_resv;
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
+	if (!amdgpu_vm_is_bo_always_valid(vm_bo-&gt;vm, vm_bo-&gt;bo))
+		spin_unlock(&amp;vm_bo-&gt;vm-&gt;invalidated_lock);
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
 	vm_bo-&gt;moved = true;
-	list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;evicted_user);
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
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
+
+	vm_bo-&gt;moved = true;
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
+	list_move(&amp;vm_bo-&gt;vm_status, &amp;lists-&gt;moved);
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
+	amdgpu_vm_assert_locked(vm);
+	list_splice_init(&amp;vm-&gt;kernel.idle, &amp;vm-&gt;kernel.moved);
+	list_splice_init(&amp;vm-&gt;shared_resv.idle, &amp;vm-&gt;shared_resv.moved);
 
 	spin_lock(&amp;vm-&gt;invalidated_lock);
-	list_splice_init(&amp;vm-&gt;done, &amp;vm-&gt;invalidated);
-	list_for_each_entry(vm_bo, &amp;vm-&gt;invalidated, vm_status)
-		vm_bo-&gt;moved = true;
+	list_splice_init(&amp;vm-&gt;individual_resv.idle, &amp;vm-&gt;individual_resv.moved);
 	spin_unlock(&amp;vm-&gt;invalidated_lock);
-
-	amdgpu_vm_assert_locked(vm);
-	list_for_each_entry_safe(vm_bo, tmp, &amp;vm-&gt;idle, vm_status) {
-		struct amdgpu_bo *bo = vm_bo-&gt;bo;
-
-		vm_bo-&gt;moved = true;
-		if (!bo || bo-&gt;tbo.type != ttm_bo_type_kernel)
-			list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;moved);
-		else if (bo-&gt;parent)
-			list_move(&amp;vm_bo-&gt;vm_status, &amp;vm_bo-&gt;vm-&gt;relocated);
-	}
 }
 
 /**
@@ -412,14 +384,16 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	amdgpu_vm_update_stats_locked(base, bo-&gt;tbo.resource, +1);
 	spin_unlock(&amp;vm-&gt;stats_lock);
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
+		amdgpu_vm_bo_idle(base);
 		return;
+	}
 
 	dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
 
 	ttm_bo_set_bulk_move(&amp;bo-&gt;tbo, &amp;vm-&gt;lru_bulk_move);
 	if (bo-&gt;tbo.type == ttm_bo_type_kernel &amp;&amp; bo-&gt;parent)
-		amdgpu_vm_bo_relocated(base);
+		amdgpu_vm_bo_moved(base);
 	else
 		amdgpu_vm_bo_idle(base);
 
@@ -453,24 +427,24 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 }
 
 /**
- * amdgpu_vm_lock_done_list - lock all BOs on the done list
+ * amdgpu_vm_lock_done_list - lock all BOs on the individual idle list
  * @vm: vm providing the BOs
  * @exec: drm execution context
  * @num_fences: number of extra fences to reserve
  *
- * Lock the BOs on the done list in the DRM execution context.
+ * Lock the BOs on the individual idle list in the DRM execution context.
  */
 int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 			     unsigned int num_fences)
 {
-	struct list_head *prev = &amp;vm-&gt;done;
+	struct list_head *prev = &amp;vm-&gt;individual_resv.idle;
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo *bo;
 	int ret;
 
 	/* We can only trust prev-&gt;next while holding the lock */
 	spin_lock(&amp;vm-&gt;invalidated_lock);
-	while (!list_is_head(prev-&gt;next, &amp;vm-&gt;done)) {
+	while (!list_is_head(prev-&gt;next, &amp;vm-&gt;individual_resv.idle)) {
 		bo_va = list_entry(prev-&gt;next, typeof(*bo_va), base.vm_status);
 
 		bo = bo_va-&gt;base.bo;
@@ -584,7 +558,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
 	struct amdgpu_vm_bo_base *bo_base, *tmp;
-	struct amdgpu_bo *bo;
 	int r;
 
 	if (vm-&gt;generation != new_vm_generation) {
@@ -596,38 +569,52 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+	amdgpu_vm_eviction_lock(vm);
+	vm-&gt;evicting = false;
+	amdgpu_vm_eviction_unlock(vm);
 
-			r = validate(param, bo);
-			if (r)
-				return r;
+	list_for_each_entry_safe(bo_base, tmp, &amp;vm-&gt;shared_resv.evicted,
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
+	spin_lock(&amp;vm-&gt;invalidated_lock);
+	list_for_each_entry(bo_base, &amp;vm-&gt;individual_resv.evicted, vm_status) {
+		struct amdgpu_bo *bo = bo_base-&gt;bo;
+
+		if (dma_resv_locking_ctx(bo-&gt;tbo.base.resv) != ticket)
+			continue;
+
+		spin_unlock(&amp;vm-&gt;invalidated_lock);
+
+		r = validate(param, bo);
+		if (r)
+			return r;
+
+		/* need to grab the invalidated lock to trust prev here */
+		spin_lock(&amp;vm-&gt;invalidated_lock);
+		tmp = list_entry(bo_base-&gt;vm_status.prev, typeof(*tmp),
+				 vm_status);
+		list_move(&amp;bo_base-&gt;vm_status, &amp;vm-&gt;individual_resv.moved);
+		bo_base = tmp;
+	}
+	spin_unlock(&amp;vm-&gt;invalidated_lock);
 
 	return 0;
 }
@@ -652,7 +639,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm-&gt;evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	ret &amp;= list_empty(&amp;vm-&gt;evicted);
+	ret &amp;= list_empty(&amp;vm-&gt;kernel.evicted);
 
 	spin_lock(&amp;vm-&gt;immediate.lock);
 	ret &amp;= !vm-&gt;immediate.stopped;
@@ -952,7 +939,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 
 	amdgpu_vm_assert_locked(vm);
 
-	if (list_empty(&amp;vm-&gt;relocated))
+	if (list_empty(&amp;vm-&gt;kernel.moved))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &amp;idx))
@@ -968,7 +955,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &amp;vm-&gt;relocated, vm_status) {
+	list_for_each_entry(entry, &amp;vm-&gt;kernel.moved, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry-&gt;moved;
 
@@ -984,9 +971,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&amp;vm-&gt;tlb_seq);
 
-	list_for_each_entry_safe(entry, tmp, &amp;vm-&gt;relocated, vm_status) {
+	list_for_each_entry_safe(entry, tmp, &amp;vm-&gt;kernel.moved, vm_status)
 		amdgpu_vm_bo_idle(entry);
-	}
 
 error:
 	drm_dev_exit(idx);
@@ -1357,7 +1343,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		else
 			amdgpu_vm_bo_idle(&amp;bo_va-&gt;base);
 	} else {
-		amdgpu_vm_bo_done(&amp;bo_va-&gt;base);
+		amdgpu_vm_bo_idle(&amp;bo_va-&gt;base);
 	}
 
 	list_splice_init(&amp;bo_va-&gt;invalids, &amp;bo_va-&gt;valids);
@@ -1585,7 +1571,8 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	bool clear, unlock;
 	int r;
 
-	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;moved, base.vm_status) {
+	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;shared_resv.moved,
+				 base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
@@ -1593,9 +1580,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	}
 
 	spin_lock(&amp;vm-&gt;invalidated_lock);
-	while (!list_empty(&amp;vm-&gt;invalidated)) {
-		bo_va = list_first_entry(&amp;vm-&gt;invalidated, struct amdgpu_bo_va,
-					 base.vm_status);
+	while (!list_empty(&amp;vm-&gt;individual_resv.moved)) {
+		bo_va = list_first_entry(&amp;vm-&gt;individual_resv.moved,
+					 typeof(*bo_va), base.vm_status);
 		resv = bo_va-&gt;base.bo-&gt;tbo.base.resv;
 		spin_unlock(&amp;vm-&gt;invalidated_lock);
 
@@ -1627,7 +1614,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		    drm_gem_is_imported(&amp;bo_va-&gt;base.bo-&gt;tbo.base) &amp;&amp;
 		    (!bo_va-&gt;base.bo-&gt;tbo.resource ||
 		     bo_va-&gt;base.bo-&gt;tbo.resource-&gt;mem_type == TTM_PL_SYSTEM))
-			amdgpu_vm_bo_evicted_user(&amp;bo_va-&gt;base);
+			amdgpu_vm_bo_evicted(&amp;bo_va-&gt;base);
 
 		spin_lock(&amp;vm-&gt;invalidated_lock);
 	}
@@ -2256,14 +2243,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 
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
 
@@ -2554,15 +2534,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm-&gt;va = RB_ROOT_CACHED;
 	for (i = 0; i &lt; AMDGPU_MAX_VMHUBS; i++)
 		vm-&gt;reserved_vmid[i] = NULL;
-	INIT_LIST_HEAD(&amp;vm-&gt;evicted);
-	INIT_LIST_HEAD(&amp;vm-&gt;evicted_user);
-	INIT_LIST_HEAD(&amp;vm-&gt;relocated);
-	INIT_LIST_HEAD(&amp;vm-&gt;moved);
-	INIT_LIST_HEAD(&amp;vm-&gt;idle);
+
+	amdgpu_vm_bo_status_init(&amp;vm-&gt;kernel);
+	amdgpu_vm_bo_status_init(&amp;vm-&gt;shared_resv);
 	spin_lock_init(&amp;vm-&gt;invalidated_lock);
-	INIT_LIST_HEAD(&amp;vm-&gt;invalidated);
+	amdgpu_vm_bo_status_init(&amp;vm-&gt;individual_resv);</pre>
    </blockquote>
    Nothing function but we could move the above function along with
    other groups together just for better code readability.
    <blockquote type="cite" cite="mid:20260310191327.2279-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	INIT_LIST_HEAD(&amp;vm-&gt;freed);
-	INIT_LIST_HEAD(&amp;vm-&gt;done);
 	INIT_KFIFO(vm-&gt;faults);
 	spin_lock_init(&amp;vm-&gt;stats_lock);
 
@@ -3005,100 +2982,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
+	amdgpu_debugfs_vm_bo_status_info(m, &amp;vm-&gt;shared_resv);
+
+	seq_puts(m, &quot;\tIndividual BOs:\n&quot;);
+	amdgpu_debugfs_vm_bo_status_info(m, &amp;vm-&gt;individual_resv);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ae9449d5b00c..aa1180bf3caa 100644
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
@@ -349,46 +366,22 @@ struct amdgpu_vm {
 	spinlock_t		stats_lock;
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
-	/*
-	 * The following lists contain amdgpu_vm_bo_base objects for either
-	 * PDs, PTs or per VM BOs. The state transits are:
-	 *
-	 * evicted -&gt; relocated (PDs, PTs) or moved (per VM BOs) -&gt; idle
-	 *
-	 * Lists are protected by the root PD dma_resv lock.
-	 */
-
-	/* Per-VM and PT BOs who needs a validation */
-	struct list_head	evicted;
-
-	/* PT BOs which relocated and their parent need an update */
-	struct list_head	relocated;
+	/* kernel PD/Pts, resv is shared with the root PD */
+	struct amdgpu_vm_bo_status	kernel;
 
-	/* per VM BOs moved, but not yet updated in the PT */
-	struct list_head	moved;
-
-	/* All BOs of this VM not currently in the state machine */
-	struct list_head	idle;
+	/* userspace BOs where the resv object is shared with the root PD */
+	struct amdgpu_vm_bo_status	shared_resv;
 
 	/*
 	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
-	 * have their own dma_resv object and not depend on the root PD. Their
-	 * state transits are:
-	 *
-	 * evicted_user or invalidated -&gt; done
+	 * have their own dma_resv object and not depend on the root PD.</pre>
    </blockquote>
    <p>We might want to move the explanation before the&nbsp;<span style="white-space: pre-wrap">individual_resv list for clarity. 

Grouping idea seems great and seems to simply the things to good extent. But just for better explanation and more clarity for others and documentation purposes if we want
can add more details:
</span></p>
    <pre wrap="" class="moz-quote-pre">kernel:       BO's belonging to PD/PT and other BOs which are internal to the kernel.</pre>
    shared_resv&nbsp; &nbsp; &nbsp; BO's belonging to per process but still allocated
    by the driver/kernel for each process, for name can we says
    per_process<br>
    <br>
    individual_resv : BO's whose memory is allocated by user for
    completely user managed buffers per process (User ptrs), alternate
    name : user_private or something.<br>
    <br>
    Apart from the nitpicks, the change looks great and simplify things.<br>
    <br>
    Reviewed-by:
    Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
    <p><span style="white-space: pre-wrap">Regards
Sunil Khatri</span></p>
    <blockquote type="cite" cite="mid:20260310191327.2279-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	 *
 	 * Lists are protected by the invalidated_lock.
 	 */
 	spinlock_t		invalidated_lock;
 
-	/* BOs for user mode queues that need a validation */
-	struct list_head	evicted_user;
-
-	/* regular invalidated BOs, but not yet updated in the PT */
-	struct list_head	invalidated;
-
-	/* BOs which are invalidated, has been updated in the PTs */
-	struct list_head        done;
+	/* Userspace BOs with individual resv object */
+	struct amdgpu_vm_bo_status	individual_resv;
 
 	/*
 	 * This list contains amdgpu_bo_va_mapping objects which have been freed
</pre>
    </blockquote>
  </body>
</html>

--------------CLtZk40qO0MbcJUUvHy2JkcX--
