Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA3C1073CA4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C36210E62B;
	Wed,  8 Apr 2026 12:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TIE7TSfj";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B33A10E62B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcdVkxFziuqhSj4xGU6WxjVnvsFkRDdVjwxhz5RzNgMZL3VPT0KnLlSC2lkUQJ19JeTgOZbU3/8fXAXfc5kkEDM5AGifRQhhuu+uh5h7sBpmYtf1Qu+QpPt/aoM9TE5JjF+xUfGLSOIz45JPyhF+/eUzvDI2suYScjiHD2Q03x1vrS9F2tHUb6/Ob/HBiQmEy/FtUSIdWkqH0aUVNmnrRGfyXrgRyiqLlggb3IZEiP2ToYhrZvEunoQmIkMXeXOTq1SBIPj4RJJNxSQwBoXz9TFEqaGMvAvSGjI9W2hdb/J7kffA/Co9/iSTXj2xWbcqHPJi6dsYcDbQ+ArHoRPjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuugX4EEW/jBvnvoGH5+QD8g71sMc4oMkTlb6LP1WIE=;
 b=dJsFAv1wp6RKZU6N0EhN12wlP0d8Vy79iIdPkskpT6RKV1t+WEbOz3iVID20lVqllYqdFoO1ObmXzvqWgjPy+1OYWAibpJOg9YAjrhje2sQA7EDO2QzIFx74zIJxtEtLXcaprJhDSh+SOih5yndU+aKw6JNM478JKVErJyfMI3Z9SoFo3oNNnZQYFsX3rx91FWHpJsjtobQ9aK1KA1+uft3yJ9QdHe8P/R6jBO85TXcjufi4BLCuBwCtQRWpiRwVgBMxvgKfkyz7hlEmXBwKtuWLOS/UZwQRKdi4BcjraI6cnP9U0x4eSF4GmXEq4myUWpllI1VrP747OyJzD8UQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuugX4EEW/jBvnvoGH5+QD8g71sMc4oMkTlb6LP1WIE=;
 b=TIE7TSfjblfeCjfO1HatepoqLsyElyHiAjO/6H+HYpHFdNtGfkBO/lxaYsX9CPR77hiFQMjsEHtPl8ulZMvl8XqDpiOh2iZbPrR7RPH7ZNsg+Ywr+zhRXNxZ0kwUfjkUfQu7ADagxxhyQkQE/6Pt2ZfEnwQQfxHQmZS7yI2bR0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:13:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 12:13:24 +0000
Message-ID: <7bddfdd2-8a7d-4f56-99b7-a491113e3836@amd.com>
Date: Wed, 8 Apr 2026 14:13:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: move comment to definition for
 amdgpu_userq_ensure_ev_fence
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408094254.3535048-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408094254.3535048-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: c5656bcb-115f-40cf-23b0-08de95683afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: NOhrmSZLcE9kraV21A5+sC83wZuE8FXMSL22K9mlt5U9/0tKDBimSgjjeloHkDYBr8E3jKjVk7rVokKC30TyOlg4GscVrPwz66D49z1hXSRNr7T3LMNfnMnUUNd2B+zJKSapHmOkPKTRfejqiwpMGD8roB4zHXuwdNwjE6pU0+DSGZwgsurYli3fcRDKA+ZfFlGvsDCxbrQ4wTd4oc1kYDQW29EP29ev2mdBb19z78xJVrzRHEnvx1IdjwSlPRI+I1Au9txT0uiRLQQdk41GtXi1X7UMAenETVq0/NVFMPuEq9A3ePnQYasjmBkzdqxILClce/9w3MeKRLmrramcq4Ydp/A5iUGP96uJzLv/JWzsB/Cq8ay33Nd4nECBS7nl12miEulW4losnkq3NC3UiJQ0CrdjQew55TrWYXtR146VyCMyPQ+7BfXe8M938oH124qhzWP0XQZpErdDC20OZY2p5tsVwpS6fEWqJXty4CciYz+9MHRsbAD55GrPvvAiLwVebgtcBQstYtTjr0Q98sMF6LL1SLpk0DAUVHAZF6mOSkygxOHj/cUbHKKvWGNZ+W9GDQdJH9NbESfg792sIZ6n4oz5pD8X03F0LdksSylVXVfL+5CSzO4wxg0f09RaWcyvQuEdsTrOjH6b8oA1pa3pgeeNk2HjfQIwuHivjP/2rhZdSLg9QzZTfZVHe10NNTOuTb1BFKwuu3Bp01u/VUkbYMwbLKtTJFbM2253i38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdIUFp3Um1uazJxOU1hdEdqUGIyZlVMM3pJMkFGTlhiU2JpaG5wMDZBSGV1?=
 =?utf-8?B?eWdhdTJzT2hLSXhweWZFQ2ZKYTVWUERZaVZXRlAvL1dpOEszQzF6b3VleWZZ?=
 =?utf-8?B?MXhvZXVUQ3FzQ1Ntd0JQOXczV21lSjlLODJhajRyMWFnSTZBMWlHUFpvZ2FN?=
 =?utf-8?B?cUd4Tlk4UnBKdi9BT05WUnpXeER0WlZCalFEZmdaVTJFR2txY2JaZmdicTRu?=
 =?utf-8?B?WWoyOTlzbm1yTTBTZ3ZCMW40ZEwxalpHUWtWUkhSRG5CSktFaHhuY1lkODdz?=
 =?utf-8?B?b1hhUFNpRFlad1k5RnBMUVdKNnFsRDNlc3I4UERIbExWc1E4aVZSWWFvelNa?=
 =?utf-8?B?SzkwZWdmMlBCMFpKKzR5TTZNMU92VWMxZHlGOFUrSFI1ZVF1cXFlZXRCMUNy?=
 =?utf-8?B?TTNBck0wU25CWEliUm45MFBNaXlpNFdQaVllemV0cmhkTmU2ZW10ZHVMWUh4?=
 =?utf-8?B?eWdLajlWQUh0bjdmNmpLdnptQUw0YnBPQS9uSG9HQnhBRzd5WFNuNUpOYXNi?=
 =?utf-8?B?UG5sUHlNMVhMZ2JReWRHcy96RW56YUYyS3ZuMTRFRVZaa0lxUldoTGJ3RS9Q?=
 =?utf-8?B?TUFkRWRsU2VlbnROQitNUzZnSW9NejBYUVBxSy9oZk5kUDR4SWFlZjdJSGRz?=
 =?utf-8?B?akFiQS9ZV1dQbTR0M3FOemgwdGoyQXl4T0UyV1JMWHpBcVh2SmhYNXY3bnBS?=
 =?utf-8?B?aHpYNXBuTkIvNkw0aWdJUzArN3VxakFPNFpXRFN3NFpmZVNFOTlDS2NGTHRz?=
 =?utf-8?B?dWhTTk5SVG1Wbk5FaGdCVkJjaXNnNVhwdDJYeVMvSlN5K1NvcFl3RXpEaExL?=
 =?utf-8?B?dWplc1BvVGpmVXJYV20xMlh1MlVlZkprQ0NaTHc3aGxJUGUvbEJpNUpxcEdL?=
 =?utf-8?B?KzBzWDhoY053WlFDMnNvbjFrV3FEVTRtL1phUXZaYkpUWGFGOGR2cmllSWlD?=
 =?utf-8?B?eGtHamZmaDVzUUZHeVA2cGpKdnRXRFQxWEsvTDMwNTJQaVB6VnZELzB3Nzg5?=
 =?utf-8?B?eFc5MVd4dU8wZmpRbmgrTVZMT3k5TFRTZ2FLZ3hFd2FsemFkSFNybUpOWXB4?=
 =?utf-8?B?YzRJVzMxcUxFT0xQUUhBSmh4RVBzb0pTVytLY3NWWXJxWlpKNlBhM2FqRktX?=
 =?utf-8?B?YjJBaE4yV285dlEyWjVnMlhVTzFjbEdNMWxrVElLa0JTaEJWeXlIUnZUZy9X?=
 =?utf-8?B?SjlySnpEQ3FZQmpKOGNZZzFFN1F3dFZ3YnJUTWdDRDVIMTBYTCsyczBEWERM?=
 =?utf-8?B?UjIvS3VQelh2aUFjNTVTNElvM1dwZ09hS1NHNlFrMGwzVXZ1MkgvVWF3TlVL?=
 =?utf-8?B?bFJHWTBDTHBmU2F3TG5iSGd5SHJoclN0QmNrb3BpcU1CVFZSQVplSGhrNVFS?=
 =?utf-8?B?ekZRd2JHVXMzYzUwTnNGNmxBVFNTbU1MTnBQc2hwamNCOTZmWlRrWm9qTUZo?=
 =?utf-8?B?VkdQem5VWlBNRzk5Tjk2RWY4aTlJMVpiLzhYYTYzSEJvUkdHMWxMVlJkNk1Z?=
 =?utf-8?B?Wi9QZDJKc2txaGZNKzllelduYk04cm9hcEZPa3lFQlNWdEZHeVlzSXo4RFMr?=
 =?utf-8?B?bFptSmRweVdSRVZvanRScHI5VExVQ2lQTFo5RkJ0RFc1L3FDTHJTS01oNXJs?=
 =?utf-8?B?clcwSVgwWG5IcHN4WjFaaGJmOUREaUdzVjdlZFlIMTdFcDNHN1BoZXZReHVY?=
 =?utf-8?B?VEpNRlhYUG5odDlFTXVUYjRNdTdYRXVYSnBGUGJVbk4rTVh6RUJUKytSKzBt?=
 =?utf-8?B?b2syRGhJcVNlQzRibDJvcmFwU05xcEhyMHNvVm1JZkhnRi9oZlZ0RHpZVEND?=
 =?utf-8?B?T2tWSW03S1gxT0FlZzN2LzZFMnJxRUoxSjdEaVd1dlNzOUVHSlBlRkdOOWtB?=
 =?utf-8?B?NEsyRzR5T0hhUUdXYlA4aG5Ta09HSVVSUmxnNDAyL0RmK1FMQlRKSVJmakFV?=
 =?utf-8?B?N0JnUXg0VDlyRVkyUk1GSElzdDRxMXo1R0lyeGtMaTQyYk4zeGhEb3ZzUms4?=
 =?utf-8?B?c0RhenYrVVVmWU1ETzlNNUxtL2xsT2FhM0xFVndQaHh3eENjeHlIMlVxT21q?=
 =?utf-8?B?aTlJRktLYXVjS0FYa0lYT0dSK01kTlZRTGF0cVZaQkFBRU5IOWMvVk9rTmE2?=
 =?utf-8?B?cEUxaXBCOXhGYUx4TC9xVzJhMmN6aUZ3MXRpeTIrUnBOLzNiQTFsL05TakFj?=
 =?utf-8?B?QU5Gd0hEb3lsNDNoQmdYSS9rclVndGtZV0tBOUoyaWNnVDJoTVJ6cmV0dzBP?=
 =?utf-8?B?VndYNStEUGRRbGR2Unc2NVFCd0MyTUVPVXFVQ290S09zUmJzcW5OYUw3YXlZ?=
 =?utf-8?Q?LPRsT+F3ws+pTg/Voj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5656bcb-115f-40cf-23b0-08de95683afa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:13:23.5033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcfOaVjT0d97SLWCwyMav8Vw3+fbEdw+1nAyoWGMtt2JnDPONSDDbO/p6fTlCp/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684
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



On 4/8/26 11:42, Sunil Khatri wrote:
> Move the comment for the caller to the definition for
> amdgpu_userq_ensure_ev_fence.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ae973c611972..b921346faa99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -460,6 +460,13 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	up_read(&adev->reset_domain->sem);
>  }
>  
> +/*
> + * There could be a situation that we are creating a new queue while
> + * the other queues under this UQ_mgr are suspended. So if there is any
> + * resume work pending, wait for it to get done.

This is actually not necessary here.

> + *
> + * This will also make sure we have a valid eviction fence ready to be used.
> + */

That's the important part, maybe even extend that a bit:

/* This will make sure that we have a valid and not signaled eviction fence and user queues are ready to be used. */

Then using kerneldoc format would be even better then just a comment.

Thanks,
Christian.

>  void
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			     struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -786,13 +793,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto clean_mapping;
>  	}
>  
> -	/*
> -	 * There could be a situation that we are creating a new queue while
> -	 * the other queues under this UQ_mgr are suspended. So if there is any
> -	 * resume work pending, wait for it to get done.
> -	 *
> -	 * This will also make sure we have a valid eviction fence ready to be used.
> -	 */
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	r = uq_funcs->mqd_create(queue, &args->in);

