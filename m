Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D950FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C59810EB40;
	Tue, 28 Apr 2026 12:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qCHuG7/e";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B90C10EB40
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 12:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLO/TsLpgfVgR13sn77UBYU+jYcIedlDQb4RzfWth+rAwcGwxkBi4RIg7UnJTCbU1C43EafTTfpxsu5lb+eksREyxGmnO/WZtsMC8ZUr+6ylK2NA7Jlbw5Pw3RPQOVd55z3ws8yIaUaRqu2iSOcsuLp4wuuG35Ca6tHeJfGFOrHKFls2On+QNiJw0LvqxQ+aN/Oy4V5EX0+oYp/7Zq3qbwKTw+7j4RxvkMPOrZ/RSEngTc9DvXN6rxbEPfaKLgV6HpZZ2hzVwjPHp3ZtAZBWnkvGrg4jkarSp/emDoxn0mK62CI7IAytd6+tMRrmCEK81Hg9w2Ya+Mz4ozazetSCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxo13LXhYICtSe/NyVMvQSoEgngHPiXwtrDkReOfzcc=;
 b=UskST6yD2l79zd/wNw1UpRxyFvIPrXUbhUSf61oyjy3eKOhcWmZ0Vr40l6qXIYZ5JVAxkGZuYXlA+YLU8avrXtq48sRK6jXepfBRkDF/chYFnPIrA4c5kpcQDaIUDqYldIdFBOa+TpkSeWurVHASlMqp7b6xnYcEHm54pVs/CfYPz/R/Ac/UKuy/Ax/3H9SYTWNQqxdViPSjWmjPD9d8gFZRBgJ8iOxgiQDEnsn+Nj2+1fgqtav5SqTVAl11li/ljregXnp8iTKJyd0NCpx/s0sskHADIZL5VU4CCVvn4Amkya/Hrdg2gQ6iSFu3MbfH0acm2Pe7/os71iAZPP3GZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxo13LXhYICtSe/NyVMvQSoEgngHPiXwtrDkReOfzcc=;
 b=qCHuG7/eKCgYySFBYX3pVTbcpIrFgLHftfXRvEdrCBnKrPwALOBB4BlxupxDyg0bbF5qzlMRLVJWLVVkgKXNHbyrTZ2QlVwn70mVfBPTpQzmsL5OlvoEcDqoS36rqEWY0dbOJOpxjKg6jRnXDfAZftktU8wsyhs38YBkUUUk6nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LVXPR12MB999197.namprd12.prod.outlook.com (2603:10b6:408:3dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 12:21:08 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 12:21:08 +0000
Message-ID: <a7695139-e95a-4584-9b7c-89fa712facb6@amd.com>
Date: Tue, 28 Apr 2026 17:50:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdgpu: restructure VM state machine v2
To: christian.koenig@amd.com, alexander.deucher@amd.com, Prike.Liang@amd.com, 
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-8-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260427182723.1715-8-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|LVXPR12MB999197:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b8c13b-0556-4454-d345-08dea520a04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XFRoGm3pueG6nBP0Waqdx08WfheJkEd58ERKSRK1ppe/stnGq1s/jWTnat2niMtLqmP/nLzItN3dwVKrISidRmkiQpNBJ1Dlvbr40HMy9NhZJSejo0iIVEvEgKHxoNYzzm2MyUR8qf4lyfwbCPxczGUdApx0KUJl/MKtN4rKREjFxRwN+47KO9wUQs0BFptHkwZnYq6sZyfo30MC0g/XLTp15OJPuQL+skr9CMYtBVYcvjtwHK8nv5x7P1HywYDa+/9QH7UIoymTqpYb+rwhptYX94EaN8MiXQ2lMkBzRpJSvGZbJ4l/ejZinBifdlEeNWKxmuW6t1Hi31tIocZNw6fq6gt2VNHBbsr/ASJ7EY77yFEiAX2f2lTFWe8Q0FXIrU8n3n4hGI6yuWHEjQanijgmgxRFdE1RyYeKS9qD77k44LCLuVXANzK48buRkSTYQWAAKXkAEY5tHmM954WyumoecyPTQGLvj7Cr428lQXKdJNcj1RlExybfic3GCvNkScroU+lqGtwt64QcMJuanEH1xDGHAmW5Io4kayrbUtdJZAaaOiDIX+CdbbA1bJ8duw6UK+XPajlJo2toWnC+RRbmWSIwxAphX7b3kKknLx0Tb37cCAgDdEVXCjRtkus5p/zXNnXBxC9hK5O+cqr4jYPDDPPvYq+c4E2xeGUymEcGpkCwo8xVOmqnErPJQiQ8YmxQv0D5ySiOMnF4bp3VZ7oxRvE8yt5a5/zoP+dndv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18096099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW1YM2RnMzlsQW8xMlg1cWlCYVBibytmZVJaelRxcVFoWGVIRVhzNlczUm44?=
 =?utf-8?B?ZnBuZDQwNDdCd2hHbml5aG16VTY2ajZZaEVRUE5OZGE2K2JmUHU4T214M242?=
 =?utf-8?B?V1c4N3pzVzJaSzg1dllLREE0OEQrWUZuVG9lQlJkMm9kL3ExYjdyV2lQWDVm?=
 =?utf-8?B?R256QjdRQ0o2YmNlY1RWeWRsMzREMG9SS21vZU56SkwvTGtkekRISlhMK1dn?=
 =?utf-8?B?bGk0L3k1VmxFNWVuNTVDRmE4U2dGYkYyYURqbXYzRDU4aUZIZng1UnBSNmpu?=
 =?utf-8?B?YVNCQm5UZ0ovNTlYVVpXMjNxc0tFUjJ5bWdCdjZDcVlVUE03akdJVHg4ekQv?=
 =?utf-8?B?V2ZFaHBZNGNMN0Y1NUozbXc4ZGxwc0xKSnY4UUhMaGFLY0VhMmdFTEVpL0dT?=
 =?utf-8?B?cFVaVkdkcklTOGZ5c3hoVWkrSkRoaU9PY0JXSGYyTndSeHArZFJmazhNcVZE?=
 =?utf-8?B?TktSYjk4TE1RSUZSWEhQSlNLdXkxUEkyaFdwS0ZVbEZHM0wxc0NBUVRTbUFQ?=
 =?utf-8?B?bDFEeGw1Q3RNbkg4bmpRYkZNODBPUHNoNXlKWW9YSmlYRk5meW5DazRxeXpw?=
 =?utf-8?B?aVZ1dFQ3c2xTazFHNlo0VTdQM2NYREpqMkIvVlk2RnJhcURuc2ZUYW00QmZm?=
 =?utf-8?B?VURIb0VlejJEaE5UYldGZHd0TWlLUFpLaHB4VmlrUzZlQ1V1NWJLKzlHMVBx?=
 =?utf-8?B?bUdSeW5HeTU1Y1krNFVVQy93OUNFVDFQR3FwbEdyQ2w1TlptRmtKOXZiMzA1?=
 =?utf-8?B?SVVJUW93TjBKNk1vQ093NzVURklQeHk2bGk2TnZ2WDFLb3gwZU9OZ3dXdS9M?=
 =?utf-8?B?R2w2RVhDY3YvbVgzcnFDVGMxS0tURStuRzNzNGw5cFEzODdmb2JoTGRKRkZy?=
 =?utf-8?B?Q1NoNi9OZkpDTDZpZmN6TlUzbmxQTW11MXJ5NkNPZzVKdkJORXl1alFlVnhI?=
 =?utf-8?B?ZzB5Vnd5YVhYWTFCZC9uS1haMjUvK2FBYkkzL2xZRW1mL1djajN2TkNsOEJK?=
 =?utf-8?B?aG5uTVo2ckZMV3l5L2FXOG9BbUNVMnVUWEFVOEFCdlhGWmhBODdiU2REMkR2?=
 =?utf-8?B?M3NUSkh2TDlkdzBnMmdxUXVKTUFLNVlrNmxzVlp1amkwWTlFNi9QL3ZQcnox?=
 =?utf-8?B?K1NhRzdRS0ZlUkd0ZStWbkpDMVN3clRySk9pNUVQdy9WZmIrWDFxRjB4TUhs?=
 =?utf-8?B?MHNhcWo4emhjMnQ0SjNoQVUrVmdxT2F4TS9uMHhtbUQvQkViVDRUaldIT0VK?=
 =?utf-8?B?WXcvTm5WZGNvelpzWTlWbFVKaXZvL2J5V2FsMThZUndGNGF5cW0zVUgyU2l3?=
 =?utf-8?B?aWxzU0lNQWJJeDlYZkpWbDRTL2ovTE9lanE1Qi9OVGF3TmJtdGNMRHNQR2FE?=
 =?utf-8?B?Rythb0szNHkrNm94TmhOSWZETGE3TGN3YkhEWWdrckhZWEtmL1oxUGRNTUhD?=
 =?utf-8?B?VXpKK05NOFdBZVhuSjR2S2FTTTRzODlDOXZhMUFyN00zTmt6aG5vUzNENGdZ?=
 =?utf-8?B?cDJxbjdnd0dKRStKYjk0K3hjdmZuUGEydk5OUlFoTXpMMUxoV3FmQ3dxS0ZC?=
 =?utf-8?B?T3NkT2Y2QlpBd0JhRHQ1V2oyY1FrRUZEVGtKRGNGRGtYR3prMDY3ZWxkUU9M?=
 =?utf-8?B?emNmMnhTbkRoVHhXcFV5ZXJLeXdiRzBqNzhWbEZLMGtBaG9yWW5DcUx0Y0Fp?=
 =?utf-8?B?MWYxdmYycjc3c2tQazRsYTZKWmxDS2NUSTRsV2luaEdNbE40TTF4ZTNKUEUz?=
 =?utf-8?B?QUV0YXlyeHNKMVdCS29XMWdyRG9mQkRWUEZpekk5clNVdjBYbjJjV3E1QjJM?=
 =?utf-8?B?dTBMVmNCSEJ3U1RTSzR3L2ZuRFBvRnJqUjROTjI3QXJodGNMWDBWbVBpakJY?=
 =?utf-8?B?c0lwdi8yZ3JRdVE4S2NvdVZHOVM4b0VDUDBDbUMxYmJCVmw5bzdJWlhRYmMz?=
 =?utf-8?B?NWRSSjR4cVRUcm9ZcEJwbTJSS2YwZmFqNHRHUGMxVHQ0QTRhYnA4QS8rcHA2?=
 =?utf-8?B?Q2tkaWJnRTZOWjJjdnJSb0FRajFTaXN1Yk8rajBXM1RPRzVWbDlNdEZveWxx?=
 =?utf-8?B?QUxrVzZ6SFFxbnZscE1mN0k4a3JtK0FjUWJmbXhCdzBieEY4NlpNeVYzcU1S?=
 =?utf-8?B?cGFXazlPdlFhNEVJMklLNVVFSEoyVGdPSWVPQm5jenQxdUhkUnNjSUgwTnpZ?=
 =?utf-8?B?NzZxM1pRNW1iMTFhR2QreWwvYmtGZUtCb0I4V1ZncmEveW9CSUNEMi9EK0U4?=
 =?utf-8?B?dkMxdW9GWW5XQ2JYZmFYdkt4eVljMURyU2t0VVJTZ01WcGV2b3RJYVVhanZ4?=
 =?utf-8?B?QVdSZWpjME9QZlVyTDRpem01OWpTUktiQ1RjaVFMdUtpdHJMWVh4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b8c13b-0556-4454-d345-08dea520a04f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:21:08.4465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3C53HQl4Gjgtj+WscZs1UT0AZDkUC3CDJKL0MP/nUwmAT5Sw/SmmQ6XMCAmeRoE5K9/NS6M7MrHNDtpso3teA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999197
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


On 27-04-2026 11:57 pm, Christian König wrote:
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
> v3: squashed together with revert to old status lock handling, looks
>      like the first patch still had some bug which this one here should fix.
>      Fix a missing lock around debugfs printing.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  65 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 534 +++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  69 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>   4 files changed, 298 insertions(+), 374 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 28e0695b53e7..07e30acbdc3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -805,41 +805,50 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	if (r)
>   		goto clean_mqd;
>   
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	/* Make sure a concurrent close operation doesn't kill our userq */
> +	kref_get(&queue->refcount);
> +	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> +		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
> +		     GFP_KERNEL);
> +	if (r) {
> +		/*
> +		 * This drops the extra and last reference which should take
> +		 * care of all cleanup.
> +		 */
> +		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue);
cleaning up here sounds more clean to be that do an extra put. We need 
to make sure that after put the destroy clean up is doing same or some 
extra clean up is needed here.
> +		return r;
> +	}
>   
>   	/* don't map the queue if scheduling is halted */
> +	/* TODO: That is racy! */
>   	if (!adev->userq_halt_for_enforce_isolation ||
>   	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
>   	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
> +
> +		/* TODO: We could skip mapping if ev fence is signaled */
> +		amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr,
> +					     &fpriv->evf_mgr);

I really dont understand this part? Earlier the condition was different 
and so the combination of them...

Regards
Sunil Khatri

>   		r = amdgpu_userq_map_helper(queue);
>   		if (r) {
>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>   			mutex_unlock(&uq_mgr->userq_mutex);
> -			goto clean_doorbell;
> +			/* Prevent racing with close */
> +			if (xa_erase(&uq_mgr->userq_xa, qid) == queue)
> +				amdgpu_userq_put(queue);
> +			amdgpu_userq_put(queue);
> +			return r;
>   		}
> +		mutex_unlock(&uq_mgr->userq_mutex);
>   	}
>   
>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> -
> -	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> -		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
> -		     GFP_KERNEL);
> -	if (r) {
> -		/*
> -		 * This drops the last reference which should take care of
> -		 * all cleanup.
> -		 */
> -		amdgpu_userq_put(queue);
> -		return r;
> -	}
>   
>   	amdgpu_debugfs_userq_init(filp, queue, qid);
> +	amdgpu_userq_put(queue);
>   	args->out.queue_id = qid;
>   	return 0;
>   
> -clean_doorbell:
> -	xa_erase_irq(&adev->userq_doorbell_xa, index);
>   clean_mqd:
>   	uq_funcs->mqd_destroy(queue);
>   clean_mapping:
> @@ -1035,12 +1044,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated,
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->always_valid.evicted)) {
> +		bo_va = list_first_entry(&vm->always_valid.evicted,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->individual_lock);
>   
>   		bo = bo_va->base.bo;
>   		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -1052,14 +1061,14 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		/* This moves the bo_va to the done list */
> +		/* This moves the bo_va to the idle list */
>   		ret = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (ret)
>   			return ret;
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->individual_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -1091,7 +1100,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   		if (unlikely(ret))
>   			goto unlock_all;
>   
> -		ret = amdgpu_vm_lock_done_list(vm, &exec, 1);
> +		ret = amdgpu_vm_lock_individual(vm, &exec, 1);
>   		drm_exec_retry_on_contention(&exec);
>   		if (unlikely(ret))
>   			goto unlock_all;
> @@ -1134,7 +1143,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	key = 0;
>   	/* Validate User Ptr BOs */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
>   		bo = bo_va->base.bo;
>   		if (!bo)
>   			continue;
> @@ -1184,10 +1193,10 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
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
> index 6b58b0ecfa06..9f71a146f1f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -138,6 +138,47 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   }
>   
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
> + */
> +static struct amdgpu_vm_bo_status *
> +amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
> +{
> +	struct amdgpu_vm *vm = vm_bo->vm;
> +	struct amdgpu_bo *bo = vm_bo->bo;
> +
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		/* No extra locking needed, protected by the root PD resv lock */
> +		amdgpu_vm_assert_locked(vm);
> +
> +		if (bo->tbo.type == ttm_bo_type_kernel)
> +			return &vm->kernel;
> +
> +		return &vm->always_valid;
> +	}
> +
> +	spin_lock(&vm_bo->vm->individual_lock);
> +	return &vm->individual;
> +}
> +
> +/* Eventually unlock the status list lock again */
> +static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
> +{
> +	if (amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		amdgpu_vm_assert_locked(vm_bo->vm);
> +	else
> +		spin_unlock(&vm_bo->vm->individual_lock);
> +}
> +
>   /**
>    * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>    *
> @@ -157,37 +198,44 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo)
>    *
>    * @vm_bo: vm_bo which is evicted
>    *
> - * State for PDs/PTs and per VM BOs which are not at the location they should
> - * be.
> + * State for vm_bo objects meaning the underlying BO was evicted and need to
> + * move in place again.
>    */
>   static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	struct amdgpu_vm *vm = vm_bo->vm;
> -	struct amdgpu_bo *bo = vm_bo->bo;
> +	struct amdgpu_vm_bo_status *lists;
>   
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
>   	vm_bo->moved = true;
> -	amdgpu_vm_assert_locked(vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	if (bo->tbo.type == ttm_bo_type_kernel)
> -		list_move(&vm_bo->vm_status, &vm->evicted);
> -	else
> -		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	list_move(&vm_bo->vm_status, &lists->evicted);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   /**
>    * amdgpu_vm_bo_moved - vm_bo is moved
>    *
>    * @vm_bo: vm_bo which is moved
>    *
> - * State for per VM BOs which are moved, but that change is not yet reflected
> - * in the page tables.
> + * State for vm_bo objects meaning the underlying BO was moved but the new
> + * location not yet reflected in the page tables.
>    */
>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -	spin_unlock(&vm_bo->vm->status_lock);
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
> @@ -195,120 +243,43 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>    *
>    * @vm_bo: vm_bo which is now idle
>    *
> - * State for PDs/PTs and per VM BOs which have gone through the state machine
> - * and are now idle.
> + * State for vm_bo objects meaning we are done with the state machine and no
> + * further action is necessary.
>    */
>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	spin_unlock(&vm_bo->vm->status_lock);
> -	vm_bo->moved = false;
> -}
> +	struct amdgpu_vm_bo_status *lists;
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
> -{
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->status_lock);
> -}
> -
> -/**
> - * amdgpu_vm_bo_evicted_user - vm_bo is evicted
> - *
> - * @vm_bo: vm_bo which is evicted
> - *
> - * State for BOs used by user mode queues which are not at the location they
> - * should be.
> - */
> -static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	vm_bo->moved = true;
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -	spin_unlock(&vm_bo->vm->status_lock);
> -}
> -
> -/**
> - * amdgpu_vm_bo_relocated - vm_bo is reloacted
> - *
> - * @vm_bo: vm_bo which is relocated
> - *
> - * State for PDs/PTs which needs to update their parent PD.
> - * For the root PD, just move to idle state.
> - */
> -static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	if (vm_bo->bo->parent) {
> -		spin_lock(&vm_bo->vm->status_lock);
> -		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -		spin_unlock(&vm_bo->vm->status_lock);
> -	} else {
> -		amdgpu_vm_bo_idle(vm_bo);
> -	}
> -}
> -
> -/**
> - * amdgpu_vm_bo_done - vm_bo is done
> - *
> - * @vm_bo: vm_bo which is now done
> - *
> - * State for normal BOs which are invalidated and that change has been updated
> - * in the PTs.
> - */
> -static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->status_lock);
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
>   	amdgpu_vm_assert_locked(vm);
> +	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> +	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
>   
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->done, &vm->invalidated);
> -	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
> -		vm_bo->moved = true;
> -
> -	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
> -		struct amdgpu_bo *bo = vm_bo->bo;
> -
> -		vm_bo->moved = true;
> -		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -		else if (bo->parent)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	}
> -	spin_unlock(&vm->status_lock);
> +	spin_lock(&vm->individual_lock);
> +	list_splice_init(&vm->individual.idle, &vm->individual.moved);
> +	spin_unlock(&vm->individual_lock);
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
> @@ -321,7 +292,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   	bool shared;
>   
>   	dma_resv_assert_held(bo->tbo.base.resv);
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	if (base->shared != shared) {
>   		base->shared = shared;
> @@ -333,7 +304,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>   			vm->stats[bo_memtype].drm.private += size;
>   		}
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>   }
>   
>   /**
> @@ -358,11 +329,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
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
> @@ -386,7 +357,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>   		 */
>   		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>   			vm->stats[res_memtype].drm.purgeable += size;
> -		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
> +		if (!(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(res_memtype)))
>   			vm->stats[bo_memtype].evicted += size;
>   	}
>   }
> @@ -405,9 +377,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
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
> @@ -428,37 +400,34 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
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
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>   	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
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
> @@ -479,41 +448,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
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
> -	spin_lock(&vm->status_lock);
> -	while (!list_is_head(prev->next, &vm->done)) {
> +	spin_lock(&vm->individual_lock);
> +	while (!list_is_head(prev->next, &vm->individual.idle)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>   
>   		bo = bo_va->base.bo;
>   		if (bo) {
>   			amdgpu_bo_ref(bo);
> -			spin_unlock(&vm->status_lock);
> +			spin_unlock(&vm->individual_lock);
>   
>   			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
>   			amdgpu_bo_unref(&bo);
>   			if (unlikely(ret))
>   				return ret;
>   
> -			spin_lock(&vm->status_lock);
> +			spin_lock(&vm->individual_lock);
>   		}
>   		prev = prev->next;
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -609,10 +578,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       void *param)
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
> -	struct amdgpu_vm_bo_base *bo_base;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_vm_bo_base *bo_base, *tmp;
>   	int r;
>   
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   	if (vm->generation != new_vm_generation) {
>   		vm->generation = new_vm_generation;
>   		amdgpu_vm_bo_reset_state_machine(vm);
> @@ -622,49 +591,59 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			return r;
>   	}
>   
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->evicted)) {
> -		bo_base = list_first_entry(&vm->evicted,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
> +	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
> +		r = validate(param, bo_base->bo);
> +		if (r)
> +			return r;
>   
> -		bo = bo_base->bo;
> +		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> +		amdgpu_vm_bo_moved(bo_base);
> +	}
>   
> -		r = validate(param, bo);
> +	/*
> +	 * As soon as all page tables are in place we can start updating them
> +	 * again.
> +	 */
> +	amdgpu_vm_eviction_lock(vm);
> +	vm->evicting = false;
> +	amdgpu_vm_eviction_unlock(vm);
> +
> +	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
> +				 vm_status) {
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
> -		spin_lock(&vm->status_lock);
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
> -	while (ticket && !list_empty(&vm->evicted_user)) {
> -		bo_base = list_first_entry(&vm->evicted_user,
> -					   struct amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
>   
> -		bo = bo_base->bo;
> -		dma_resv_assert_held(bo->tbo.base.resv);
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
>   
>   		r = validate(param, bo);
>   		if (r)
>   			return r;
>   
> -		amdgpu_vm_bo_invalidated(bo_base);
> +		amdgpu_vm_bo_moved(bo_base);
>   
> -		spin_lock(&vm->status_lock);
> +		/* It's a bit inefficient to always jump back to the start, but
> +		 * we would need to re-structure the KFD for properly fixing
> +		 * that.
> +		 */
> +		spin_lock(&vm->individual_lock);
> +		goto restart;
>   	}
> -	spin_unlock(&vm->status_lock);
> -
> -	amdgpu_vm_eviction_lock(vm);
> -	vm->evicting = false;
> -	amdgpu_vm_eviction_unlock(vm);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -689,9 +668,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	spin_lock(&vm->status_lock);
> -	ret &= list_empty(&vm->evicted);
> -	spin_unlock(&vm->status_lock);
> +	ret &= list_empty(&vm->kernel.evicted);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -985,18 +962,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
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
> +	if (list_empty(&vm->kernel.moved))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1012,7 +984,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -1028,11 +1000,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (flush_tlb_needed)
>   		atomic64_inc(&vm->tlb_seq);
>   
> -	while (!list_empty(&relocated)) {
> -		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
> -					 vm_status);
> +	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
>   		amdgpu_vm_bo_idle(entry);
> -	}
>   
>   error:
>   	drm_dev_exit(idx);
> @@ -1260,9 +1229,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> @@ -1406,7 +1375,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		else
>   			amdgpu_vm_bo_idle(&bo_va->base);
>   	} else {
> -		amdgpu_vm_bo_done(&bo_va->base);
> +		amdgpu_vm_bo_idle(&bo_va->base);
>   	}
>   
>   	list_splice_init(&bo_va->invalids, &bo_va->valids);
> @@ -1629,29 +1598,25 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
> +	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
> +				 base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
>   			return r;
> -		spin_lock(&vm->status_lock);
>   	}
>   
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
> -					 base.vm_status);
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->individual.moved)) {
> +		bo_va = list_first_entry(&vm->individual.moved,
> +					 typeof(*bo_va), base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->individual_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1681,11 +1646,11 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>   		    (!bo_va->base.bo->tbo.resource ||
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
> -			amdgpu_vm_bo_evicted_user(&bo_va->base);
> +			amdgpu_vm_bo_evicted(&bo_va->base);
>   
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->individual_lock);
>   	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -2223,9 +2188,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->individual_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2305,14 +2270,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
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
> @@ -2333,10 +2291,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
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
> @@ -2603,16 +2561,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->va = RB_ROOT_CACHED;
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		vm->reserved_vmid[i] = NULL;
> -	INIT_LIST_HEAD(&vm->evicted);
> -	INIT_LIST_HEAD(&vm->evicted_user);
> -	INIT_LIST_HEAD(&vm->relocated);
> -	INIT_LIST_HEAD(&vm->moved);
> -	INIT_LIST_HEAD(&vm->idle);
> -	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->status_lock);
> +
> +	amdgpu_vm_bo_status_init(&vm->kernel);
> +	amdgpu_vm_bo_status_init(&vm->always_valid);
> +	spin_lock_init(&vm->individual_lock);
> +	amdgpu_vm_bo_status_init(&vm->individual);
>   	INIT_LIST_HEAD(&vm->freed);
> -	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
> +	spin_lock_init(&vm->stats_lock);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
>   	if (r)
> @@ -3089,100 +3045,64 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
> -	spin_lock(&vm->status_lock);
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
> -	spin_unlock(&vm->status_lock);
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
> +	spin_lock(&vm->individual_lock);
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual);
> +	spin_unlock(&vm->individual_lock);
>   }
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f33ea7f8509b..cc96a3e6252f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -205,17 +205,34 @@ struct amdgpu_vm_bo_base {
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
> @@ -345,47 +362,29 @@ struct amdgpu_vm {
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
> +	/* BO's belonging to PD/PT which are internal to the kernel. */
> +	struct amdgpu_vm_bo_status	kernel;
> +
>   	/*
> -	 * The following lists contain amdgpu_vm_bo_base objects for either
> -	 * PDs, PTs or per VM BOs. The state transits are:
> -	 *
> -	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
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
> +	 * have their own dma_resv object and not depend on the root PD.
>   	 *
> -	 * evicted_user or invalidated -> done
> +	 * Lists are protected by the individual_lock.
>   	 */
> +	spinlock_t			individual_lock;
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
> +	struct amdgpu_vm_bo_status	individual;
>   
>   	/*
>   	 * This list contains amdgpu_bo_va_mapping objects which have been freed
> @@ -507,8 +506,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a930f1522f96..ff334f4dcc90 100644
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
