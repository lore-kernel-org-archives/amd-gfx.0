Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E93ACA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 13:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01F510E8D5;
	Thu,  8 Oct 2026 13:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJaEw+PZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DBF10E853
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 13:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp5TwoWwChg0AR3wfkdomltI36ins+gaquaBJYjamVsPulzM+8E7HhavA3723P+FWl+uFUSsJc9XiE+CiC4L9IWI47+Nv5Ki8GLflSvN+qALX0nv4JPFp+C/GF7QneZ84ip8b5403O9GD7DLAJUBRaI2FN1kmIdNIEH1bA3CxWiD5heVQR3QZuAR4patKLQheNS7tv1+9MyoUczR88O6r2YbqkeY17si7+DPzbnE4xqHA6mGvrnDNzF9+9z/MyOISnhaFZRvg4FCUs6NOexg2DWKw6lDeZG/NK+O13Vv/XlXZ994hRcmqnEaMaCR8n8RSshuVE0Trl800VvZBZHE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRZ4nfluaNZe1hUsORgri2r4qncEo7WU7QgWWKebKv8=;
 b=TAI+yUfDbiH+UsmLO8v6fYYBhhRIEy3J80j7emJ2iO0V4JOz8oisXKyOCVYC8PLQRjo2OX/1NYnHTBgqybqUbIR/4quoojpXs6yKEeyS7/bRjDV58G8BEhxU2XiCcaJF49MnULUbwENpP/CqBn57SZUrog4dPHhO7rq2OPSnftknS2mmTdw+wM4DzIyiG7v4cs48yFQEoU13X3KAK6OI/A8hYJV5FO/M3HkYbA3WQaJtNEI1fLw5a3rQeTRKlqduHOkCS7hm89xSA7kUFzPx1tGi0aVModeR3bM2X+nOnZMYlMxDezY37zzJ0+cIS7rf4zVlO6s8fO7sZFT/uSilKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRZ4nfluaNZe1hUsORgri2r4qncEo7WU7QgWWKebKv8=;
 b=MJaEw+PZLKnZ0D2uCKxoow4rbZFRkqWrlLwc0lIvZT9+TznEWLAfk6/RHLqip7BvrAtUcFFfLHKKjksilO+5yiYiBd6jm2qAFW9lPMcKedz4NldqGgK7vx1hm4Yyl+Tbbl6XHH7kJhQitLEtSCi/G9HLli6sCWoD14J66XKbh2w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by MW3PR12MB4425.namprd12.prod.outlook.com
 (2603:10b6:303:5e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:53:46 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 13:53:45 +0000
Message-ID: <99db9e10-eeb9-4d13-986e-3262f7fb037b@amd.com>
Date: Thu, 8 Oct 2026 09:53:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: let amdgpu_vmid_mgr_set_vmid_mask set
 up both hubs at once
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261008065234.2945047-1-sunil.khatri@amd.com>
 <20261008065234.2945047-2-sunil.khatri@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20261008065234.2945047-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::28) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ef1736-31d4-4c49-a670-08df2543922f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7/W2c7nAKTQzvafIBUxJcL1l3/+xDqH0woXsNje5Anz/WXygMnRxCLyqotfJThfYNbh2KYa+bHtX4i45bI7o5d/ty1+c/zeluQQdBTJYbZ4Mq6Szgg0xMnFbYzjV+1SCtvz4qeWWXtDonneAiHqWn+E/srYbgl6t3h5K/jx7/vG6JFp2VmGf+VWhnjSL7dDrAJ1DgAIULlgJxh+x2opjeNGKxUGassgXdQKXRRc6Js5vEkkYa4Ch02W+P+U7j8uVE7TgJyFgogh7UPIAGYoNqQXfGXSC+i7fyHvoCvNCvU7NgiG4LWxyRjlpDHFkr0M4Td9yvjZVB2zy5LFQ9vO7VxvzYpo+Dmv/KUXowzJZXJCPAelb8WovzYtTluwI89L7WLrVeHt1sXgisQqDTso3dkrq4h84E2gK3Y+zv9442RlyQv4KDDxz+aZTaxHwCDOMais/kRrwqui/tmOsGvACKaohRSuiwhWqPi5qRWDA2WwDaivw8lJSMthVHi7trw7Pw4xGd5ln/6H4DBF6201w+8p59/sXGPxEXkfFhrtW1E0VwaQ3+2ujfhqs9CL8mwzd+PE0K1FsFBH6igPxoJEzZtMCvE//vD3dVZMJqIQbBk9TR70fsE+dPRyHCazaU04sFVmnYw42lOSeZUNZDz9yqOBzb3lpv6SlEW44MGDsNz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBNU3R6R0ZVZi9oWnA0Y0VrSC81eGJOS21mb2pOaTVmOFJrdTliNUNKWDVz?=
 =?utf-8?B?U1ZtUGVML0JJSWl5dTFoKzkzaU1NdnEzNGZZcHNOU1pSUXpoaHdrelJ4TkYx?=
 =?utf-8?B?UVJod25pSDRWdHpDemlKTDZ2azZOUWtYcHNBTHRRVlE1VUZ0aG5LSWh6dG9N?=
 =?utf-8?B?ZGdBZU01OTd0dmh5cXBRNXgrQWxCNFR6TnBWa0Y4RWI3MWtoU29FSFNrL3Zk?=
 =?utf-8?B?UWpHQWNkUFpmZmxkcWhwM1l5ZEJyWnMrcG5FVUdUZU91dU9lNGVBdTBGVFkx?=
 =?utf-8?B?SmpuL0UvV0xhLzhzK1pVeXc0WXpoSXFkMmN5N1BickpGR3VDaDQxVENPUzZo?=
 =?utf-8?B?aWc3NXkvcVZjUVNLQkFwOTRsM1NpRlExMGpkdEo4ZEtISlgrbDlBeDFRcGxZ?=
 =?utf-8?B?MlViOFhjeE5HZVVoQ0tNUlFMUzBGUlVnWDJ5UWVCVVpuakUxdjV6S0tjalRE?=
 =?utf-8?B?aFlDd1dxTGYzUDFSa3pYdHFuNEU3TVpZMnpLbzB5SThuUTJucnhLcDlxN0hG?=
 =?utf-8?B?YlVtL2hUY0NmRUdSUFhIOTQrelJSeVhTL244YmpWZHhJb01ZMk8xNGIxNkt1?=
 =?utf-8?B?NGlZZUhZQmZoRVpKdEMyb2g2NDd1VFFkRDdraDh6SjRwMG5QeEZmbldqZlF6?=
 =?utf-8?B?UGl3bTRMdlBTWGtzQVpsRm5mZnRSODIvWXdEbXR0QXVKU3hyZUJNUjQwQ2J1?=
 =?utf-8?B?d3V5WXFkTlF1cXY5bEwwUW0xa0RYWU13VFY2d2pYckFHVDdKYWZBczRNbHNC?=
 =?utf-8?B?TE14eTJDSlhDMTBaNFRQRDRSUzlURU0yQm1wakVWMGUzQjJYU3Yva2lQVVd3?=
 =?utf-8?B?c0V1dERwRHdIREZNY3c1L3JFcjV4R3h2N0RNRWNUSXFoQ1cyZXhyNmdDeVVl?=
 =?utf-8?B?OXV5SVF2QkI2SG12cFNzR0JweDVWenByTDcrd3ZiOXkya0NmSnNWTU5HRDJU?=
 =?utf-8?B?UHMveUZzTDF5NUk4cHdrb0k2ZkJhcDhJVTJQb1I1bC9ZTm8rTk9CTkxqV0VE?=
 =?utf-8?B?SEF2Y2VSamF6TklIOGc1QUhRYWV6bXliZ2xCbTl3RkZpSS9HNWttSkdQTVF5?=
 =?utf-8?B?OHJvR3lIL0xvM2ZpbWJ6YXFpYTZqS0phQ3lMTEF6bkZ4RkRaeHpnZkFlWlU4?=
 =?utf-8?B?bFVaUHAwMlZ2cEtaTzdNNitSSFFVVFEzN1lwSy8yUzRFMG1jbWRPWkVraWcz?=
 =?utf-8?B?eGRPbXYzQTk0eW11cDZKYURaUmRQZHorelhNMEIxOStzeXFKQnZaQTBFaVpE?=
 =?utf-8?B?d2hxZGhMenM3N1BYMzgzeG5oSnRuSWNzb21sS3Vxdk9KcDNFa0JhZC8yT0My?=
 =?utf-8?B?TjU4SjBCSVZKdGwrRkNaSWlRendzVm02MGZQaGduaE5jM0pORzlFRFo0UWZt?=
 =?utf-8?B?UG1hWndSVVZzRHh4TkhlU212R3dSWHp3MTFFTkFzUnkyc2FFMUs4dlUzV25o?=
 =?utf-8?B?OEQwTHI0ZTNibGZVdWtHWUNhcmswWjJIMlIvQzNKK2ZiOE1SQzN1dFo3V1pj?=
 =?utf-8?B?bU1vUUN0cFo4QzU0WFVvcmE5WEVubTZZaDBwblVvVkhOTmc1eFpaR1d0bWIy?=
 =?utf-8?B?U0JSTXZIMjV1NnUxSjRwMERUV2E0c0R4UmJsaXNrNVNnQzZzU0lzeE1qbEov?=
 =?utf-8?B?SjFjSlpUbFZnMjJMdUdSR3RHZzQ0QTBrWjBnSEdjZ1RyVnRjYUoxbll0b1dk?=
 =?utf-8?B?OTkrQ2JweVV0ZVlEVXJYMEFvellRSkkwa1FqR2RWMENoQmIwTnNTeVNZdW4v?=
 =?utf-8?B?Q0J0MGFUd3MxbHZRZTEwL3pIa08wc0lqbWFZTEtyTk5VcWkxY3YzU2RKT2hM?=
 =?utf-8?B?Y2xEaERaZzhuV3Q3M1grcnQ0dUxIWnVlckxIeGZJOFhkaUdyODREczdlSDY4?=
 =?utf-8?B?cjIyVnhuQVJWWWp0K1ZYcHl4T0JlK0ZUb3pwajB1MUFldjQyZVJWU3h3OHpp?=
 =?utf-8?B?aWxyeUFXdGRvR0x0ZjFMS0cxb0tqWGJmL1RMODQ5Sk4yU3IvMytJVmhRM0M2?=
 =?utf-8?B?c0hsOHlkRVREcmxZSWIrVktIUjQvSGxWRUhSRmVCbWZMWXFHcjNDeEJ6V3or?=
 =?utf-8?B?S0ovYkZydnJ3Ylplck9MckVzSmZlNnRhUTRLL2FBQVRhcjNNS1h1REVDUVJX?=
 =?utf-8?B?aGgvY0dJWUcyb1pTVEx2T2MwMVozc0RMdE1lNGlYeHdVbWN2YlJMS0QzOUxF?=
 =?utf-8?B?eFRtYmt0Z0g0emprK0d5NU91V0ZBZ0tVcnpsalJ4NlBacElRUmNyNlJDOThX?=
 =?utf-8?B?YzJSWU0zdUswZTdmbkhNN0FFdm8xZWJvdUdqeE40MDl6YlNyaUxOZ1B0Z25Q?=
 =?utf-8?B?NWlYcVowcHFNbW1KaWpLR1JwVlBtcXJwWFZVZXBEVGFMNEFyNEhqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ef1736-31d4-4c49-a670-08df2543922f
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:53:45.6456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfkACfYYJfK8EMLeoESYG2y/YWwCCvxsqdTQSVLhIxKoebcfOQ/CRamrK/cnu6n+NJFvhB9jIWVHerVkXnJbZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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


On 10/8/2026 2:52 AM, Sunil Khatri wrote:
> Set the kernel- and user-queue VMID pools for both hubs in one call
> instead of two calls plus a separate amdgpu_vmid_uq_mask_init() step,
> so a hub's full VMID layout lives in one place.
>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Series is:

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 46 +++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  6 +---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  5 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  5 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  5 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  5 +--
>  9 files changed, 36 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d2414b4656805..60c52042ff540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -630,8 +630,27 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>  	}
>  }
>  
> +/**
> + * amdgpu_vmid_mgr_set_vmid_mask - set the kernel- and user-queue VMID
> + * pools for both hubs
> + *
> + * @adev: amdgpu device structure
> + * @gfx_vmid_mask: kernel-queue round-robin VMID mask for GFXHUB
> + * @mmhub_vmid_mask: kernel-queue round-robin VMID mask for MMHUB
> + *
> + * Sets both hubs' kernel-queue round-robin pools. The KFD/MES
> + * user-queue pool is set alongside them: on GFXHUB it is whatever
> + * @gfx_vmid_mask leaves behind, since every generation's GFXHUB kq/uq
> + * split is a clean partition of the full VMID range; on MMHUB it is the
> + * fixed VMIDs 8-15, since MMHUB's kq and uq pools are allowed to overlap
> + * and are not generally complementary. A VMID dedicated to a single
> + * fixed purpose on MMHUB (npa_vmid) is excluded from both MMHUB pools;
> + * it is the caller's responsibility to have already set npa_vmid, and to
> + * exclude it from @mmhub_vmid_mask as well.
> + */
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long vmid_mask, bool for_mmhub)
> +				   unsigned long gfx_vmid_mask,
> +				   unsigned long mmhub_vmid_mask)
>  {
>  	unsigned int i;
>  
> @@ -640,26 +659,17 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>  		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
>  
> -		if (is_mmhub == for_mmhub)
> -			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
> -				    &vmid_mask, AMDGPU_NUM_VMID);
> +		bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
> +			    is_mmhub ? &mmhub_vmid_mask : &gfx_vmid_mask,
> +			    AMDGPU_NUM_VMID);
>  	}
> -}
>  
> -/**
> - * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
> - * first_userq_vmid, shared by KFD and MES user queues.
> - */
> -static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
> -{
>  	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		((1U << AMDGPU_NUM_VMID) - 1) &
> -		~((1U << adev->vm_manager.first_userq_vmid) - 1);
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +
>  	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +	if (adev->vm_manager.npa_vmid)
> +		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
>  }
>  
>  /**
> @@ -673,8 +683,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>  {
>  	unsigned i, j;
>  
> -	amdgpu_vmid_uq_mask_init(adev);
> -
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
>  		struct amdgpu_kq_vmid_mgr *id_mgr =
>  			&adev->vm_manager.id_mgr[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 21d6a41d1738a..353986452fb54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -119,6 +119,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long vmid_mask, bool for_mmhub);
> +				   unsigned long gfx_vmid_mask,
> +				   unsigned long mmhub_vmid_mask);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 259aca57a3ec0..369881267ebb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -872,8 +872,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index daec00725b969..afdf3153976b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -858,8 +858,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index f3e9759833b77..31cfe1a874bc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -1007,16 +1007,12 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (adev->gfx.disable_kq)
>  		adev->vm_manager.first_userq_vmid = 1;
>  
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      false);
> +				      mmhub_vmid_mask);
>  
>  	amdgpu_vm_manager_init(adev);
>  
> -	if (adev->vm_manager.npa_vmid)
> -		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
> -
>  	r = amdgpu_gmc_ras_sw_init(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 2fb3b0687ab70..0f868323029f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -827,10 +827,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      true);
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 1208822b6ef8d..69acfd0408f41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1009,10 +1009,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      true);
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index b21dc8fc6a9a1..14a05f653d453 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1124,10 +1124,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      true);
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f9d2e82c34793..8723199b6e4dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2041,10 +2041,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
> -				      true);
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
>  	amdgpu_vm_manager_init(adev);
>  
>  	gmc_v9_0_save_registers(adev);
