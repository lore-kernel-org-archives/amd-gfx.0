Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80E31073CA4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8711710E624;
	Wed,  8 Apr 2026 12:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="afcLFGz4";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE5E10E624
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFa4dBk2Bt2mlavAVimqKkr1SRpi5M8XsMCs6GUG92R0l/zBAH2oat6skPmmG+kZCE56zU/AwlbepQBpyGMuEUF8oluipv0FJQpalwxmEG07AUjVgVDU4/hRc34BRAdabSngY1vrqkbbQ2piNU813+N799fY8/hfUoHTpMcBG6g8BSbpG8TT+/nUx6Oi2oRsjnqHgOM/C1Jay61DNGH3U7rWO+iif0PTT00AlNuU2PkW/7o21alexGoH6NfrdUr9S1uWHVhjTvChv7GD4moq5e0CeSbekUg+sLQX20aXSq+aeahbQqcFP6KQO0RIX+uJkMCpebDCoYJ6GvVQ76k4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNuhvueCNNxWXwZQpHFK+qDue8XGROHYugaiSA/+QIc=;
 b=xMMs2MWi1+ENXsZv7x/lgrq2a2tJJ784jWykmiU/bJQiEa5neDEUThlRQjqk3SnVDPccWXswtGhKdv8n+zwDlHkjtxMdYrbYj+WL67bUOCnjSqlMQy6sP+bIU1X4WtpSx0pjaL1xq7tRS9OsIwlDSZ4g8+fMytMr54SZv4bfypfIW/Fo8UY/DDpaunTryrBk9bedWqW/cp6qDY9koBSnyvBnuDYf+J7Z2t25wifPN0QErgRAx+ngu8l1ovoX0jdqTTdy80vcGRsFVZ+VVvLWwbQWkP+/c9L8dQqC7b5cUp0AEDKpDINo3X6kd4b1IOBO8ALw2JfDgmbW8glDvW5aNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNuhvueCNNxWXwZQpHFK+qDue8XGROHYugaiSA/+QIc=;
 b=afcLFGz4BH06fJeSMHY7IM4TU7YnsFrISdDj2vGpAbSqWIglhrb3ctpw11ChkS2ywsUvvn0OcMx54BkeZ4JiX8voN1ve2+o8VqMxSofmTeT4I8txzLeiw7wiCDjUW0odAC8nK+g8Ylzvf5vHrsfPEluSo5kLX2fLHGrV+JZI+kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:09:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 12:09:57 +0000
Message-ID: <73374d27-1fbe-4966-b829-c59ac0340dbc@amd.com>
Date: Wed, 8 Apr 2026 14:09:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu/userq: clean the VA mapping list for
 failed queue creation
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408093828.3532876-1-sunil.khatri@amd.com>
 <20260408093828.3532876-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408093828.3532876-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: ad99daac-f5e0-4be4-db49-08de9567c066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: /MfDVc0si7T549KYBqR+IG8t7SFQ65/fx3pHi6x+U1larSR0YmFVsF+tfcidvf7CtlSnU+bwf4z+4jdtcZqxe4Ai3PaxaOKEwGdu4zxtj9TfUFWE111Tw3KOENUYE27OrSMO5be4LMF7/+IytMMWy+4dNFi20M9LmbrKLzeFW5HGk8kQm92ChLabYK5bJdV7mbumzGI31YW3ir8TOFSGece/scktomzY/UWT1rgNKgLARp2C5umS0SGxkMHqmxnYC4HIAQd8i+IoLM/cYrstfS2++VaihG50kVmD8xZGey1mhj1zCIYBgOLuTjD0V4JHb+j/VXwXrn1beM5p4fwaE+gOm6X9YCn3C6RnPKoEI6ni1jFxtU2MeU8Y1xTJCP0WgwP6xpTFDVVN6z9HYLs35MsNBZc9sQZfRs6Eg87boW5R61QQswyLtttHhzLND3cr2aurQi5h5CeuGUJ2e1aPyOAwOaPJNjEeX7pk14gI53rkegMtx2DCxMwTK3+UZRmD9hoTsUjabxMdpU162U9hMW4kNiDdxspb1mmM4mwmDwyPc0OGEQ0ga6xp5+GIuUwF5z7bTVnjxP3yJWyQFmJimPk9a2KNafdSxBa2q6FboBWt1usp4jQIL72lH3AY9c4R/MarbgMbGCNFrQZp4fL074ySbowr6ZS3dxo91tpnUyh2hJjhAucfA26Zmt8HgS/AfvFkRYH70hBk9IHEwsL1VA0Vl4fUrXIoyZLAzWd9Nsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckd0VDAyT2VoMDhHeEw2OFU1ZC9vQ0pYcTByNVh5Vll3ZEdjZlVqcVdsV3ZL?=
 =?utf-8?B?dDZUMzZpV0M0YWk5THlYRlNaU2ZaLzZVeGdsTE83a3IxdUorUSswcVVTM0Vz?=
 =?utf-8?B?V2JnMEJCK25ieWJJeEt5ZERzVFVnS0hNdUZmSTRNL3ZoZURnRVdtdEtvaW4w?=
 =?utf-8?B?Q3N6VlpsY0lETkVmWUlGMi80VjBnRzRKSURRRlYvMjVrOVhXdFlUTk9UcVBp?=
 =?utf-8?B?MGZINlk0Mmxaaml3S21Eb2ZlaWRDWENUcEJ5b204RHhpeVdNTWVvSXdoREUz?=
 =?utf-8?B?dll1S2llNnpERUU5RTV4ejBVcjA3dkVCck9LOTJNYm9KdEFnbVZha05ORDJa?=
 =?utf-8?B?SFZtTFEyMWlNUGdhVWZoZVYrbE5NbmZRbHVBZFBMeXdSdE5ReWVhZE9HR0V5?=
 =?utf-8?B?c0s1NUNKUGRUL0YvRzFvNmh3Zm92Q3ZqdlVmNkhnUDdDMG5FSDlQbzhtdStr?=
 =?utf-8?B?SU45UkZLZkIyZ1duV0Q1eGpleFVZQjlrMlNaWWQxV0xmWTVxSjB5TmRiR1VE?=
 =?utf-8?B?NUpPVzFxY0RLRWtQZWhaaVdZelhFVURBQlUzOFFzS1hiRVh3T3RnWXBzSUJo?=
 =?utf-8?B?djhWSHpsYUdjOEFJSkllaXpIR1VwT05rVnpZSnh2SWFLQk44a2ZGeFd0dFNJ?=
 =?utf-8?B?bWxnd09qVXNCZ2lmQnVtS0EybGZ0Vzd1S2Zxei9yKzdYTGNCblhMM1c5Q2VP?=
 =?utf-8?B?RU1uSkxJcUJzSzhqcjh2eW5udnFRanpDb0pqQlVpNDdjRDBkY3MzMmh1QkdJ?=
 =?utf-8?B?Zm9BUkFxRUZSRUt5WHVlMDZPelNwTWNnOFA3MUU0aXQrYkZiKzA4eUxpS2xZ?=
 =?utf-8?B?V05mVGtnTHBsb1k4cU5pOU13WVdhbDQwSTYvV3JQRGszdnAxYnlvekNzQ0tB?=
 =?utf-8?B?SFU1RHFiVlNQVHJZQnN2a21Jc3VScUpJWFdTVVp0M3IwWmUrU2NueG5ldlhO?=
 =?utf-8?B?VlBqa09pQVZnVGV6WXl4K1VoSWlWVnFDcThUdkhYMzJpNC9TOXpKcmVPOGtr?=
 =?utf-8?B?dXNEMzAzeUNoaHkvOW9lYWJlenp1NThaQjhGbTJIL2phMDh2eWIwMlFMR2l3?=
 =?utf-8?B?YjM2bnJXL1hyUnJremhoU2xocWJDUWNIMEtlVE9vQjhmWGg4QTNYdTFpZHFW?=
 =?utf-8?B?eFVFODZwOEZGR3dOZk0xT2paZHpvZTZuNGcyazROTmp5YkRSMVBTWkFXOXhQ?=
 =?utf-8?B?ckxqV2I2SEV3c0FsK0REUGgyOUM2dTFhNW9vbEt0MkMvZE1LYXpySG5PSkpT?=
 =?utf-8?B?aTVQbTJlYU5tOUk1Vm1WQ25kUnV2MW9QU1QvWDdFL2lsdlBsTzgwaVV4cmxQ?=
 =?utf-8?B?b3F6eE5xSHA0bmpuVFpCS1JTTUVBbXFydGhDUCtGT2dMWHpGU044R25kYWNu?=
 =?utf-8?B?cTVOSDczMk01M0VJdkQzY0NMZFpXUTFHam9VTWFnbzkvS0d6dWhYcXo2MTNx?=
 =?utf-8?B?ZjNQb1BHMnh0RjJQb2xLWEpIR3E0dHowT2JYM2J2Uk9XWFJGUnRFWnFJWUcv?=
 =?utf-8?B?dlBYSEltWUdXTUk1Sjk3cStEWlRTYWRhZFBpOGphSXFVbWxxYUZSc1hnWUJR?=
 =?utf-8?B?VGhMNXltbWlidW01UXI4VmNkYjlGZUo5VzdDWUNMUFM3bmh6R3JnckhkT3pR?=
 =?utf-8?B?REZpUmRzdUxFZVEyWlB1cnBkNzArbmhneGtuYW55ays3SWZyZVZWbTFjV3dx?=
 =?utf-8?B?MzZHUEhtV3lReERVVjRmNkNhSkJXWENiazh2VnRSdWxMVU4rQng5VElXL2I3?=
 =?utf-8?B?OVNRZzNRV012S3BrL3EyOUhUanBHRitSQ2xHVGExK3dzMFJ6aVZGUjVTc0E0?=
 =?utf-8?B?SGlkYmJFZG1TUnNWQmNrdnA0MWZ2RmlRS1lZVGhrbmZMdFJJN1NDUjFtY09i?=
 =?utf-8?B?VnljcnFtSFh1Rkd4ZnBCY2VGKzBqd1FhTXI1ZkpLSlZtb295WFJHRUJJajF1?=
 =?utf-8?B?SXFTcGNQbE1wSHV6OVN3cm53MW9sNUFIRTJQS2V6c1NJalBYbmVPUEFQSUxK?=
 =?utf-8?B?SUNWYmxzTkplbDh2T2tEaVk1eVIzYVBSODRmeks1MGlNZHJjS01aRmtodE95?=
 =?utf-8?B?cmpmYjR1M3laMnRnbXQxTjRmdTVNZmtLUmVJNk5vTEtRTmhtT2xaK2d6SDZS?=
 =?utf-8?B?NW51NzFOU1E4enZCSVpjM3l2L2JGQ1dPUGE0ZEthREV0WHpTQlRsMFNYRmE5?=
 =?utf-8?B?N0Fsb0syc2pkVy9JRFNhVXdQYjdxUDVYd1cxZzJhazRBRFBIdVpiVFpGTHdU?=
 =?utf-8?B?dDhzRjBibjk5WC9SOUxGOFVwbHpZRldmeVF4UE9QRkJ3eStmNElCaHdFTWlJ?=
 =?utf-8?Q?KhTzblJ0vMR+a0babb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad99daac-f5e0-4be4-db49-08de9567c066
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:09:57.8823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20LBf+dFevBU9JQhSRZ85YmFb67bMJ5dpjwBt3sYIqkmVeZ2XGc+6Qt2Y+BjJfcN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

On 4/8/26 11:38, Sunil Khatri wrote:
> If the queue creation failed during mapping of the important VA's
> like queue_va, rptr_va and wptr_va. These needs to be cleaned
> as queue destroy will not be called for such queues as user never
> get call to creation failure.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c19d993fe8c3..ae973c611972 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -767,7 +767,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>  		r = -EINVAL;
> -		goto free_queue;
> +		goto clean_mapping;
>  	}
>  
>  	/* Convert relative doorbell offset into absolute doorbell index */
> @@ -775,7 +775,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (index == (uint64_t)-EINVAL) {
>  		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>  		r = -EINVAL;
> -		goto free_queue;
> +		goto clean_mapping;
>  	}
>  
>  	queue->doorbell_index = index;
> @@ -783,7 +783,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
> -		goto free_queue;
> +		goto clean_mapping;
>  	}
>  
>  	/*
> @@ -857,7 +857,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  clean_fence_driver:
>  	amdgpu_userq_fence_driver_free(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
> -free_queue:
> +clean_mapping:
> +	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	kfree(queue);
>  	return r;
>  }

