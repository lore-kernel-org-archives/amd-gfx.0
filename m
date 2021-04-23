Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EDBC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 07:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329BC611CA
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 07:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329BC611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6F26E075;
	Fri, 23 Apr 2021 07:56:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72C46EB48
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 07:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LK+IB/Nq5z4y0Ba2PN30frRET6c8SbJ/DeLJE1qoZixqZ3WujsGrcUqc+bAhysL078OmSOCIEOSJ7A0mdXzW++8dCl1sYX88bFHajJjlQhpQLa5mNyhpB3m/RXFHZtc2kkV73vpd3niXQrFhS0qAy26qZ901uxD8erz4yCrXMc+b2vTa1gLhILPLjV8BFBqnY5EwMZN2t/la4MNmXr3fduCVg2Hx4tvkAadVqyHIN0XgYO9z8RwUBbuXLPLSycl3NFZJOuc9/ydj6s9FoIIZyQo3N7RML17CW8E/8qFvMQSmcAZ6fpaV3rPfgmKPOInEarbEbgosI9Bbwe8fkuP73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4etexshWXhdZVr3yHhvB5O/iigh2JuDtNLdKR1BQMVQ=;
 b=FChgQ/ClDrW9InEWXZl9oqV80ULi12yBp5R4Gi+9yzsNpSDFUntkRFBOUcRDm/fFlpMXojWMcuHIxjfg+LGCSSmj4CYSflVLo7lQkk3QWNDJDOMxhtEktwxkmXnKaVy0cm4DCh1kJ4aMCWDxe55k8IdJv6sMU9f+icRW2yhJOFNFoTBM2sNOhBpPrf6U/mHHHvzuev15SIgsarrr/N9LY2HxIyytYwlP9NipcgRUIkKvzwrvexJrhj5U+P12w2Wt/JffR9TXMyGbxQKJyao1/N6wI0FtFQx/+LsPrtT6KaEYB0rmD5ALFQx431yskEY+YzLkGtpZb2wV5FindY16gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4etexshWXhdZVr3yHhvB5O/iigh2JuDtNLdKR1BQMVQ=;
 b=G9BdD/qXQldbdFZbzl3FWnE3Jg0tPQWKBqRWEvKfXYO5MA1Uw0KCXWShfK9VzsQZ7uUshkuuyxcpqflt/aCkV7dDj1nJMVB0gFBgGFwtCzdS9jOrSpzVldTJ+YtZS1NvVUVlkwrfAL+MQPE0hFJTaczDSjtoT2Lcy00DuqOe55w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 07:55:59 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 07:55:58 +0000
Subject: Re: [PATCH 4/6] create shadow bo using amdgpu_bo_create_shadow()
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210422154003.4048-1-nirmoy.das@amd.com>
 <20210422154003.4048-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2322c48f-2084-77e7-1f05-3387455421e2@amd.com>
Date: Fri, 23 Apr 2021 09:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422154003.4048-4-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:509f:9ae8:ad1c:20a4]
X-ClientProxiedBy: AM0PR02CA0131.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:509f:9ae8:ad1c:20a4]
 (2a02:908:1252:fb60:509f:9ae8:ad1c:20a4) by
 AM0PR02CA0131.eurprd02.prod.outlook.com (2603:10a6:20b:28c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 07:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe45ba7-a1b0-4479-f5f5-08d9062d3b16
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB390123BDC333D8EEDAD7CB1183459@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Az5fjMHoY3n8Z5cE3XhxDJhlroMNxRa3xRvgldUqMiNqyUwE01Vi+IQhMcTURSGp1AEmxhHOvE3Yy2xrdRVWb5ebVYS9dchcRbZzu4XIMN6RuxCGe1ci/a5hf5Gu4BcQGnoqbiirNaR3pVANc/cTWZP1degj31k8qOhuKdzu7oJTVOnelCrs+r/tvjJp3ho8WsSfozUIrQlxLzc4m2BKzF+NM1qb3CbKw3NnYzM5xuuVrCREVPbSNxIR8qF4/9yN4a/IFMCywDJrQGPOwGuPWlAu4wEk9f0Zv9tBe+yZE1UFnkkki/Ew+6v9RLmqGZhNNBotvlYIkStXGNCRKzsrgSe345jSL5Ng0XWOeJT7DdplyRCeqnYNFYk9qB5nTdZ5AhX5fexyJX6kmV/SHixKryDozX9SRPF0PAdRrgRK1kObcUvQREzkmryGcDGf7sPLNUOoDQFPOUrzMLwCtzWUTcicCcUzRwD6yUJI8o4Jimg0EoOW/FsnWZ497YsYoQaWwyKeGNoWGIuctQQMAjmMbc2Xmv7vgZOrGRgURSh1QSTcBKpTR0jVvxPFb8m24LEpOjvpepn7vWFld8Ht77SXO60lAvye0/jAzMRP8SODnpWsvApJN6VYdOr8XrgUXivAs8ZFeb4bj9nkC2YpcW+soXjE6B2egIuhssGZb/WAnBv/oF+Xk8BzwEnhbia31hcd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(38100700002)(2616005)(66556008)(31696002)(5660300002)(6666004)(316002)(86362001)(6486002)(66946007)(66476007)(478600001)(31686004)(6636002)(8676002)(36756003)(83380400001)(4326008)(8936002)(6862004)(2906002)(37006003)(16526019)(52116002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWdEWXFMV2pjRFBiK0k3NFdidm54cnpvQ2wyOEFZMW1lTjNRY3Y2N3BMTFNa?=
 =?utf-8?B?SGNSUlVnWXU5b1FQZ3VBVDNzTGYybmdCdDdDbjh5YkVYSW5qZFFTaUNqMDlz?=
 =?utf-8?B?Y0ZCK05EMVp2aFZudzRuV1J3K3QrckZoUUVjTDYrRVpYVTRtVHdwZjBTY0d1?=
 =?utf-8?B?TVhWaTg4eFJlTU9HSjVFUlpuVHFrcVlIcFRwSTBCZHVjMU9UcUw3dHd4eUJM?=
 =?utf-8?B?aXNjZlgwUXZxTVJjUmlVODNRdG92dGtWYlF2elVINXFGdytsTU41NEpKMW8v?=
 =?utf-8?B?S2RpSDJCT3FONEZQWmljY0pvZWZKZ2FuU2ZPZHYwc1ZmQUxvR01MWDRkL2Ey?=
 =?utf-8?B?QlBEeGpyS1dKcXJFaTMvaHlvazgzV21JQSs2UW9ZM0hVcEpFaDNtaXQvSlFR?=
 =?utf-8?B?WDRMelk4YVJoYU5mancxck9QKytIaVQ0T2NmTUw5ZnordEVxN0JQUjlYT2Ex?=
 =?utf-8?B?eE9CdWNiM3hjZlZRTWxWYXRRZWFVQzh5K1hwS3ExWi9nUUJrZEFtTTlHeGti?=
 =?utf-8?B?bWhxVjlVTVRDc1owS1ZFVGRVZmJtZEVCOHVMUkdEdVhKQkRaYno2S0dLd2M4?=
 =?utf-8?B?djVOZjk5NVZxb0FvVUxVUkU0NEl6Q0dTUUxFZGxWai9Zd3M3WlprZ2pVTmJW?=
 =?utf-8?B?c1VEYXZwWHdGa0o5Z2dtZWxlWVJyMlBaYUJwTk0xcFM0OHhnTVVZTys0TC9u?=
 =?utf-8?B?bVhnTG9QT2czVUNZQzhtSVVyZm9Mb3Y0K2Q4b0VDS21PSVN4a3lqcDd0b2F1?=
 =?utf-8?B?eDJmM3hSaHlnU1pwN0dCeGZkam5JSy8yYnRoQUhuTjlTdDBybkVYSml1NU9s?=
 =?utf-8?B?U1BFK2k3NmlqUmNWMXlzbS8wK3FuR1FnY203TmtUcHA2QzRxYTFIN1R4a0pU?=
 =?utf-8?B?YndhQUJWaGQ0QXNoSnZKNFlhNWJ1UUY3U2RmMG9yQVcya252RTdxNGd3eHVK?=
 =?utf-8?B?M3dmRENKOUUxc1JPRi9sMTc1emdYNjBLSHIvWis5NDU5WXF0OFlLcXp3RXoz?=
 =?utf-8?B?MzJSajBNaWU1WkhMY1o3a2Jxc2ErdmMwVGk5WHc4c0hMeVFSd3Y2QTNVQWhx?=
 =?utf-8?B?QVFPZ0d3R3gwZElXWVU0U1ZJUmk4RWhWQ3NXSUlRaDdSTXA2L25WYUQvTm43?=
 =?utf-8?B?K2paZDdMZ2NPTVZ6V000SlljNjk3SDJWWXMzN2NxdnUzUFJHWGVYUk9mdzRi?=
 =?utf-8?B?WERnSlQxbXhCYWRWNEtkWUp4ZjN1T1pNSktMc3piZGxtMHJwd1llYVhGUFdp?=
 =?utf-8?B?aVE4Q251S3pldjhhSU5UZ2ZvQ0NoOFkrTi9vOXJiR1h0Unp0bVA0K2hPWm1D?=
 =?utf-8?B?Znd6QjRvNmRuRXp4N0NJYitMODV0K29yN2dJNFdOSnhlT0JOWGZwWTFBWWZq?=
 =?utf-8?B?VW16RmtMeUJLS1VVenN2YkJkenJGWTFNM3Q2bkFlbTlHZExxSlh6cnVhWEJl?=
 =?utf-8?B?WEUxWjlXcGQzeWRPNjlqdG1XOHc4anBIc1lQT3ZHVERrSWVKVXR1YU5zcEdx?=
 =?utf-8?B?MnExODltMkZnZHpBY29BSjh3QkVrU3ArY1YvazJuMk81Q3lNS0hhVkRockJ3?=
 =?utf-8?B?TzhaZ1hDdXZqTHdCekVTMW5nclI3SzhOWFY2bng5YUZLWTZpOXVWQVp4bnF6?=
 =?utf-8?B?cmcwT3ppTkY1N2hYd3ZSR0hlQXMzNjBYeUVTcEI0cUxrSVhaRTFHZVBUMzEz?=
 =?utf-8?B?Lys5MFRNRVVLOUN6OEFyNm90UVJmVEFadlFCU0ErSnpSaWh2UlBZTXBTRk5s?=
 =?utf-8?B?Yy9UMlkzTEsrSXZkNGx1UVlEb000eW5KRjM4a0ZSZDZYUzZ5Z082cXFLSkdJ?=
 =?utf-8?B?My9sTnRjeFV4TjV6NkxVZnpMWXRGUjFPZmpLWXlwSGYrcFg4UksxZ09QR3I4?=
 =?utf-8?Q?SfSI2BUmEHWcu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe45ba7-a1b0-4479-f5f5-08d9062d3b16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 07:55:58.8299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlvEph/7BoUUAPJcTVpBaocogAdw4P480ZJNXqlgSvpJnggWXbArNprAjlwPN/L/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.04.21 um 17:40 schrieb Nirmoy Das:
> Shadow BOs are only needed for vm code so call amdgpu_bo_create_shadow()
> directly instead of depending on amdgpu_bo_create().
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 70 +++++++++++++++++---------
>   1 file changed, 47 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 577148a4ffaa..bb5506ff80dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -850,35 +850,63 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   }
>   
>   /**
> - * amdgpu_vm_bo_param - fill in parameters for PD/PT allocation
> + * amdgpu_vm_pt_create - create bo for PD/PT
>    *
>    * @adev: amdgpu_device pointer
>    * @vm: requesting vm
>    * @level: the page table level
>    * @immediate: use a immediate update
> - * @bp: resulting BO allocation parameters
> + * @bo: pointer to the buffer object pointer
>    */
> -static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
> +			       struct amdgpu_vm *vm,
>   			       int level, bool immediate,
> -			       struct amdgpu_bo_param *bp)
> +			       struct amdgpu_bo **bo)
>   {
> -	memset(bp, 0, sizeof(*bp));
> +	struct amdgpu_bo_param bp;

> +	bool create_shadow = false;

As far as I can see this variable is only set and never used.

Please clean that up, apart from that looks good to me.

Christian.

> +	int r;
>   
> -	bp->size = amdgpu_vm_bo_size(adev, level);
> -	bp->byte_align = AMDGPU_GPU_PAGE_SIZE;
> -	bp->domain = AMDGPU_GEM_DOMAIN_VRAM;
> -	bp->domain = amdgpu_bo_get_preferred_pin_domain(adev, bp->domain);
> -	bp->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +	memset(&bp, 0, sizeof(bp));
> +
> +	bp.size = amdgpu_vm_bo_size(adev, level);
> +	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
> +	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> +	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
> +	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>   		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -	bp->bo_ptr_size = sizeof(struct amdgpu_bo);
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>   	if (vm->use_cpu_for_update)
> -		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>   	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
> -		bp->flags |= AMDGPU_GEM_CREATE_SHADOW;
> -	bp->type = ttm_bo_type_kernel;
> -	bp->no_wait_gpu = immediate;
> +		create_shadow = true;
> +
> +	bp.type = ttm_bo_type_kernel;
> +	bp.no_wait_gpu = immediate;
>   	if (vm->root.base.bo)
> -		bp->resv = vm->root.base.bo->tbo.base.resv;
> +		bp.resv = vm->root.base.bo->tbo.base.resv;
> +
> +	r = amdgpu_bo_create(adev, &bp, bo);
> +	if (r)
> +		return r;
> +
> +	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
> +		return 0;
> +
> +	if (!bp.resv)
> +		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
> +				      NULL));
> +	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
> +
> +	if (!bp.resv)
> +		dma_resv_unlock((*bo)->tbo.base.resv);
> +
> +	if (r) {
> +		amdgpu_bo_unref(bo);
> +		return r;
> +	}
> +
> +	return 0;
>   }
>   
>   /**
> @@ -901,7 +929,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   			       bool immediate)
>   {
>   	struct amdgpu_vm_pt *entry = cursor->entry;
> -	struct amdgpu_bo_param bp;
>   	struct amdgpu_bo *pt;
>   	int r;
>   
> @@ -919,9 +946,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	if (entry->base.bo)
>   		return 0;
>   
> -	amdgpu_vm_bo_param(adev, vm, cursor->level, immediate, &bp);
> -
> -	r = amdgpu_bo_create(adev, &bp, &pt);
> +	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
>   	if (r)
>   		return r;
>   
> @@ -2784,7 +2809,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    */
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   {
> -	struct amdgpu_bo_param bp;
>   	struct amdgpu_bo *root;
>   	int r, i;
>   
> @@ -2835,8 +2859,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;
>   
> -	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
> -	r = amdgpu_bo_create(adev, &bp, &root);
> +	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
> +				false, &root);
>   	if (r)
>   		goto error_free_delayed;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
