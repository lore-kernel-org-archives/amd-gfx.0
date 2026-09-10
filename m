Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC70C79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 09:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E0110F39B;
	Thu, 10 Sep 2026 09:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/21LA4f";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4561B10F39B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 09:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swsY/iZ90tBS5UR0r/OJ5CPA47YSfKT1VjsJT4bqeDMZdcd8cF6cntC0IIStHs5dKYBnNXFksNZDAx+VKbnGLvxriNz1BUsumZ066Oc4qArjV5MH/pgvwbG1n676C636xefdzxW/VItys0nRjQkwnryJrifWfx89M/voN7P3joLYUEfPDdis3IikTX9N2IR8rVMBnEqFsSF/l1+myqMtgg0hgdN+qfvmtxp0AE8QWbyPL37wHp1Eo2AxKkwXUsH8X2Uv+/wH/c66Nowxp3jG6OZFGuK1YI+lVrRBiCLCh4xeb7Cfihr3BOmb+RhhetUqo1AlIb8U5eyN9TWDu3YNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pLLLgn+8ewgGE2bYe22vf5FlMAk3Lq9HNLfbyDaPDI=;
 b=ax6QLrIngbVdWQy3xi8qnm1O0hXoDyHOwkoMRSWKdy/Opk8F+O1JTWWanmKdOlo/Szy00zyt/XXOx9atxniweBaf+cDiiBoasIAgTLdOCrPahJRo2KOttjZkx+ftXqga5RnlqXCycnO9mYaErNZdiW0yyJdnEgqZt7Ar4Dpp4mZiyZZsPSrybdKKRujUzLFGbWvWY1ZLVfyMT9TTz/6zfdkI0MYyJv/AaaUAd2jdJZrNYHXF/+2yX2cEQUsJoRf2dON+nB8QKKyFRsuOQVe6D9VgVNbkTZSkpsHEds+nPLUFqEv01wpSCUE/RR5pJqFWIVAnPwTHj47ULY0ooCXVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pLLLgn+8ewgGE2bYe22vf5FlMAk3Lq9HNLfbyDaPDI=;
 b=A/21LA4fnTF8EIvHHXaYxQl+itoh01bHc81gSbfnBDGw0LNl/OVl87q+Y3NCm9ayEKeGGNiGLYqT6A2TbksIctUNLgRaC2yeicU5CZN7/J4YFJOSLp8qFXyQ+Izk+TBk1OYGNHoPC5iyR8ebkThVIPodxLaJ4ZypZ0EjXDvHdPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 09:01:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 09:01:44 +0000
Message-ID: <902566f0-3c06-4b5d-925d-4957955f9cf6@amd.com>
Date: Thu, 10 Sep 2026 11:01:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: reserve eviction-fence slot at WPTR caller
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, Prike Liang <prike.liang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260910004701.94511-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260910004701.94511-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:208:237::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 547970ef-dd5a-4435-a137-08df0f1a22ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XrcC1rVQg3UdUYDtA1xO8J8v1R66WxKFO51TheZVef/a7n0XrXVF+QZzIVCd0AIzC76gKF+BrJGMjSLSKOqme7hd2PW3hO1h71ot/QRjD/gol0GoF/Ek0tOyBeFs3PobfAp7b0R/qIMRUfAHaZInrWD4nS6osqsXvjvkUrO/plteEVi+dnMCd+LD4cxvHpEY4neWQRJ0qKzgL8bhuJfmyT79e52BfNg1QlOwpIeuMHLdkkE/R3JhoJn/fcLOExUOhbX2jBJT34rElempBbREvIwnA760qKEf0lAd4+O+ky1rcbmr4nV8FZxEmh7itGK00Ku1bGjrDyOUa+QWXNW+NIT6IxdX5WNVoOk4Kry+uBI38SUTnSYKTzegZh5wnFqkxZVUMKpqrAJi+pY7v4vW+EqyUwLji3xD30nmGKR19wk0zNejYyvAr7V53QAX6jXwhcKFJyLM3ZAKwwEOfRWfmns5U1QrVsy0jY6TzY8VeIWW0+bwzgQYgX3mpIStzvhVgvHlHKtpqekRqEVR49TCQwLeY8tewmKfvjMpTfuvXMt7qAzTk3dkzewJIE36PMQWmXUEcRn7uEeITbAJkjd+M6TGczS/f4n6vz+ax7odvplTJG1Vw3TpYJjCA7w7f5BFcj0HJu4/xRNIgqIpzyq+bk/DNiFhFyW5rLOsCvfyddg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1R2SkV3ckFRSHNzNmV6amhqbnJMbkZJTXNDWWVYUnFkQytsbWs5Y3JVM1cv?=
 =?utf-8?B?RHg0allVZlhRSWpCUXloaTBEN0N4Q1JTWHFSZ3FZakFSQ2Q4alNHLzN0ZnFv?=
 =?utf-8?B?NWFHWUwyUEZ4cjgzSTNOWG5RSGFCZDgzdVVxWDJNMHhwbTRIVmUzOXpzb2Za?=
 =?utf-8?B?OFNWQWMxS0dzMWYrUjlXd2xyZjdlQWpQNEY2ZEdEWjZ4Ymp5S0RnMnlWSXpV?=
 =?utf-8?B?Y0M4UlpadHJqWm5IQUY4dE5xTnI3czUyUDVIT1NlcGZEZXRLckpCL1l6OExR?=
 =?utf-8?B?RDRTekR0cjhEeERHeUdLYW1PWWc3MzdNSnpNdEtSYys0alA1dWxyZlhEOHly?=
 =?utf-8?B?TnBKdjVDekZXbWI1dE1zWTBjbnkxUDQ2T09JQmVNWFg4ZUpscUtBZThuNksx?=
 =?utf-8?B?OVY1QnlkWmJITlI0UjV6emplOThXSFZ4Nkx1WStTRTFxb290WE1iTkUvcnJT?=
 =?utf-8?B?clQ5YnZGc0VpQk1ZeXVPWCs3cDRZeTVLYmxEeDhFMC9TRWtWVElVd3NxN2h0?=
 =?utf-8?B?RUxjTXIrVldRdkVPQUUya0FXM0JHUEt1VmoxUG5ueVg3V2FWS3RaeVRpQ1ZB?=
 =?utf-8?B?UDllcld2RWlVZFZZSnVmUmliYjNMOXJPMFlEVUJFMVdneFlBcWNTYm9jRWRC?=
 =?utf-8?B?M1UrUk44MmQ3MGZVNmY3WndyQ1lzMzU5QXMzRjNXZkxGSUJ2aXdleHRmeEdT?=
 =?utf-8?B?QmxTRkFxSjByVklKbmZIWDJrK3B4RlV5bklNQjNkeVZiK2VVcW5td1NkUDhF?=
 =?utf-8?B?UXlmRGpnWjJkSkMxbzcxazQ4VnJuUHdIRVBCVDdvd24vVURDR3BvY3RvRnJI?=
 =?utf-8?B?TUw4UHFuY29nK29wb05KR1F2RSsrL0R4QXlWUS9uWFJLWXdrV2dRT3FSTEhl?=
 =?utf-8?B?eEkwdHNzMC9RSUN0R0FOWnp1YkZ3QndrSGFvK3h1RUpBUDZZMnVYbGVPVEVH?=
 =?utf-8?B?S2VsTGF4ZEVTWWNuQ3BpK05zWUxVRzFmSEpQMFR5UmFidWpBWHlXWVhURmxP?=
 =?utf-8?B?MXpYNUxST1BHR2YxS24ycnJlOEptbkFLRlM4aUtTRDJLT0h1VFFoZjU2Z211?=
 =?utf-8?B?YXgwNU9SbmhiZFdMdmtIZ3lUUnlCMnZBbEF5YzY5V2w3N1lzNFNYMkFiVHNp?=
 =?utf-8?B?bFJkdmtMQmVRM05vYUhsanZPZHhWU1ZnRmJPQi9WeFpQWWNJWGd2dko2QWVR?=
 =?utf-8?B?ZTRxb1Frc3ArYlJSTUdmazk5US81VlZrZFpmZG1heGp3TXBWMmpGcmRvVTlL?=
 =?utf-8?B?cjVXdHNUcVBsKzlNbnhobW5mL05CVjMwb3krdXE1L0RJVk9NWDl4bjJ2VDFl?=
 =?utf-8?B?anhpQWNhM01KMHFiMldtMU9qUWhPdHJvSU5PblRWTGlUSk5UaTJaQTlHVHBD?=
 =?utf-8?B?THM0dXRqU1BIQm4yQk41VXhrSEE1TWVCYTBwR3N6OXRBeTBvb0xFM1ptWVdm?=
 =?utf-8?B?M1lOVENVRm1pWHpyMmFwZWNxVWpQOFRFODlaeEsyVTBKL2N4YjIzZWtpZncv?=
 =?utf-8?B?c3l6dHFIdjhvYUZDRzVpaU1Vb0JrZUdiWkszdzNSQWNtUTlJa0ZUTXdPcmVs?=
 =?utf-8?B?b01aYVJKaEJTNXd2OVAveXdaKzlOSFlvelg4VTg0djlKdDlxNGZ1UzE5VHd4?=
 =?utf-8?B?S0Z2WU0wU2tMUVZ1elBVQVRPZXRQZzNYNlRoYTNWNVpsZmhrQzcyR1d6cjBv?=
 =?utf-8?B?WUxWbWFwY2xXcXhDVWwrOUMxUWdSZlFScWNLeGRRaGNkUG4rY0VwTVlsLzFo?=
 =?utf-8?B?MXprM25HL2VWbHZ1M2l1WWlMUEF2c2t0MGtFcTdCdEwwVVV2WHJrVVdCWU9r?=
 =?utf-8?B?UTRhZGJ4YVUvTncyeGIxSk90VDEyUGtIOXlucTZzNTBRZlBacVVwQk1scFVQ?=
 =?utf-8?B?ZTN5ODRqK2JSUDU1MWF1ZEduYnhSMFhmUlR4RVV2bC9sLys4YlRxb3pVbGVE?=
 =?utf-8?B?bE9PZVR3NFc3U29zdnBqaUduZGxwQjk2MVBQTVUyQnpwQXVjZjBIRk5ITGcr?=
 =?utf-8?B?U1hyOTQ1ZFZnUDJ1R3JnMzFpSEVQbFE4aXdtYkZGTzJkL1A2UGxnell4VnVN?=
 =?utf-8?B?TFpjTTV3Mk9HTGNqcklOdXZFbWx0c2FEMTZ2aHNCWUx5bDArVnZ2L28yYkhm?=
 =?utf-8?B?VXhGdzlRZHpFVUtkbm5JditBcnUwYlp6QTJhLzVFS0NnMlJvSzd4SEhTTUsw?=
 =?utf-8?B?S05Id014Z1FMSjFBNHc1ZVdrTmpRc1R2NGRpVXJjVk5Cc0RlenZjcE0zU1lM?=
 =?utf-8?B?Mm9FL2g3S2x0eVpJRitPRmJ0engzdnlXOGpZbXdsdjBVU1RRei9jcERyWnUy?=
 =?utf-8?Q?AhKJZpmmcUNj5TOFO/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547970ef-dd5a-4435-a137-08df0f1a22ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 09:01:44.1324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMI6Jb0AqI6cRtggTMn0CCsNz907SN1pWkXphG/SDjoI5DDYfqCJrU9HphPd5BY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

On 9/10/26 02:45, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Root cause analysis showed that the previous workaround was fixing the
> symptom in the wrong layer.
> 
> Problem:
>   kernel BUG at drivers/dma-buf/dma-resv.c:319!
>   BUG_ON(fobj->num_fences >= fobj->max_fences)
>   Workqueue: events amdgpu_userq_restore_worker
> 
> - amdgpu_evf_mgr_attach_fence() had been temporarily taught to reserve/add
>   fence bookkeeping internally as a workaround.
> - This hid the real contract violation and made reservation policy implicit
>   inside a helper.
> 
> Review clarification:
> - The helper-side dma_resv_add_fence-related workaround was only an intended
>   proposal sent for review discussion, not the final direction.
> - Final fix keeps fence-slot reservation explicit in callers and leaves the
>   helper free of policy decisions.
> 
> Findings from investigation:
> - drm_exec_prepare_obj() both locks and reserves fence slots.
> - drm_exec_lock_obj() only locks and does not reserve slots.
> - Existing attach_fence callers in the GEM/userq restore flows already reserve
>   TTM_NUM_MOVE_FENCES + 1 before adding the bookkeeping eviction fence.
> - The WPTR mapping path in mes_userq_create_wptr_mapping() used
>   drm_exec_lock_obj() and then called amdgpu_evf_mgr_attach_fence(), so this
>   specific path could add a fence without pre-reserved space.
> 
> Fix:
> - Switch the WPTR mapping path to drm_exec_prepare_obj(...,
>   TTM_NUM_MOVE_FENCES + 1), restoring the caller-side reservation contract.
> - Remove the helper-side reservation workaround from
>   amdgpu_evf_mgr_attach_fence().
> 
> Why this is the right layer:
> - Reservation policy stays explicit at call sites that define how many fences
>   may be added in that execution context.
> - The helper only performs validate + add_fence when called with a properly
>   prepared reservation object, matching the existing drm_exec model.
> 
> Fixes: 91a358fe99d86 (drm/amdgpu: dont pin wptr bo instead use eviction fence)
> 
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Prike Liang <prike.liang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: Ibb2ec1f210a8c6e5d2a48ed9b8ec77c6dabddb7e

Reviewed-by: Christian König <christian.koenig@amd.com>

Could be that Prike is right and patch #2 is already fixed, but if it isn't feel free to add my rb to that one as well.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 68beccee9fc0..fe49aa4dc5ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -60,7 +60,8 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  		}
>  
>  		obj = wptr_mapping->bo_va->base.bo;
> -		ret = drm_exec_lock_obj(&exec, &obj->tbo.base);
> +		ret = drm_exec_prepare_obj(&exec, &obj->tbo.base,
> +					   TTM_NUM_MOVE_FENCES + 1);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto fail_lock;

