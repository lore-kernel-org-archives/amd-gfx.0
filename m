Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09841C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C341A61037
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C341A61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69CE3899E8;
	Wed, 25 Aug 2021 12:52:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8594B899E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 12:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DscuA8Kbc0xwidEezGduJBFNp1IPN4K9xGOeAHINd4YkC3V9IWSrs+l1XZg4tbk8E7CRN6robaGyEvgMZfuFO18pG86o4/p2RMEnwdkphU8Fb6VGfcu7o9GTANIg0dLCaCdWfBVXfXrESqcshg91CsjcsXc92VVsxlEImIGzPZrurBuIYh+qy9AAx/ECAySV08yB7kE3kU48Sj26d3c+uTW/v+4xQJtLmBhcpYZHfjsnPf3o4ZwzeoMwbvCUVkFE8ITPh8WtrszynHh0F5btwqTC2/1leSJ7PKiW+oiUvdbQCdklxbFSe/t1lj/O6zZrZkWyZ+gk/30FTfgde1W1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPEkTl9NIcfaS6H4Lz6O5k2y72a8dN2v4rdeNNupQB0=;
 b=KmdAkD37C4SoGlsizvE138MvNsNnQBq6W93baQSPs3fH0/o5JTDXdt1BjNEAraxa50TIOXohW1v79gVW8HezilACeVJncqhceaaVHP9D8CAT2sb0YcRABK103S6lnrpXRgtWP3wKod8zh+srYTvzOkV5UgoI3cLga0aCKxUMRwvlXKuywsWIkBaCEWgRFWh90mqVdkMGxjSnJyUI6zPLq2VKc6AlMHLr9p5AkcrZ1pJc5y2lcVfWPFz48TVxFrGhcWx043qzqAd0tzofyE79lagtELDjWCyKwloxfoDOEMvLgFQWTbxwTaLVJv41q09wFy9F/CdMQWAHZ/2gjm0rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPEkTl9NIcfaS6H4Lz6O5k2y72a8dN2v4rdeNNupQB0=;
 b=jbZ+4Ybbppcl7aGswC5kbzoh0mt24+zPaNxriK8m5yuWeFXfuWCTIqeRBZTJNGzLzC0s4D6cE+haEymyVGvTQXBOb6U3td3Ie9nNoNhNiYfQoyz8nL7sCmgXNzFGMhj3yLuVZxM1pt3hqGkewdD/9SqS7h4HF90Bk5xNpgMMinM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 25 Aug
 2021 12:20:39 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Wed, 25 Aug 2021
 12:20:39 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework context priority handling
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, satyajit.sahu@amd.com
References: <20210825112203.3806-1-nirmoy.das@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <bd435c95-4d7d-5b0e-b1c7-81ed4d883ff9@amd.com>
Date: Wed, 25 Aug 2021 17:50:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210825112203.3806-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::17)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 12:20:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb56968-cb36-4812-5551-08d967c2bfe2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350018CD339BEB3048ADCBC97C69@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0YPKr10ktXRv8dsTNHanJ3QM6CHsOUBEIC7sEmy69MHyrEkj1quXDuebht4cURP/+tyc5rGLojIUKk+w43wBNf1S5Hkd3pq1XJmkD1DXIJAMI6neBFugXo3D4UsuTWjvwNtF2J6cpGqeXEI06aiU+b9D7jG7zu8T+LWrtQkGpFMYFXsqD6Yun5uqKqGrl9O4oUiSXUZzJE6UMV6GuTPsa7dRRan4osQOHPRlHDBioaMKuE6UX0NF5MEvMY0FkXk4SWaF69C4wwmR3idAS0ENBsFQHHOTnJ24TGxaal+mv8r3ERxWkoIFWBz5ZP+V4Mh7FQQqCwOLZskgygdzHTczNH+HkHlF+j7oOSbUWV4eT1ERizFABlx738ZVGTAiqJyvz8BO3rjmfXSZDskuqIcduJsjLTB4yQ7ylzl3+2Ow8eNEUOqrb9XeE7+AqjNIGbLIeV4Ki9m6TLZrED/PYZhT4/54ZPrWmbzpRtWCdokNMY/6l+fz+b1+nYGBJeOBO1ETt4rYgkp0bwu74aXEi/ihqoKR6rfFNMT8ZubcWO8Z+QbX1JtSBLpiGZdf53xzZ1MTnCesHj4WFOlFxyLl2YY0rZ2i3ZQAuvNrnZuHa5U71f808erF2cF3V50fO0jl+I3cxnWlg/NJrJFrwfCpan69hmrlIml2bn1IpHchzgiFuxeCRakkjtvNH7P9cYNFApEYCALZqRIb4g19rX/9bPou5DYqpvdtgJjBqgHj/Wn/HI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(186003)(8676002)(6486002)(8936002)(31696002)(53546011)(83380400001)(316002)(26005)(36756003)(16576012)(956004)(6666004)(66476007)(66556008)(66946007)(5660300002)(31686004)(478600001)(30864003)(86362001)(4326008)(38100700002)(2616005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUlvSlVhbUR6VERMdUt5clJUb3BJcWZ6QnFsd1BiWVc5ZmZtSUJHenNVSXNk?=
 =?utf-8?B?RGR6Z3lKTjBEWXpWWFladi9CSEo1RmVlaUhoeDRyTi9qNmkxZGMyWmxVMVpa?=
 =?utf-8?B?NGNOZGtlaGJYU3N5N2NWWFYxTm1KYlIxNEwyNHpWZGN1RHE1bnUwZVhCSkNM?=
 =?utf-8?B?b2FnVVBPR3NRSFF0azNOYmVQaDNGUnNJT1k2N0pYTHVDVVFBR0lyT1ZQQUpX?=
 =?utf-8?B?RHJhL2xhZTdZYk4wYWUyaXpIQWkvRWdRakdDNXZraGtKcnpuSHlCWTZ6L1Za?=
 =?utf-8?B?Q3N0cXdKS1ZCUThoMlg3WDJGWGU0dEoyTGwwdjczdGpVYWl0cWJBZkIyS24x?=
 =?utf-8?B?WDJJVnhDNS85ZDFJdFRYT09JUm5OcUFEOC9BakVGbmVOUnhYYkRqT3l2SnV6?=
 =?utf-8?B?aFlPQ1I4TlZjNjc4UHhURXUxWllYNWZxS3NtWE1uTFpCNVFFenBBNE95dVBN?=
 =?utf-8?B?ZzJqUFVrcFV1MVZsUHBYVklmOHBURFpvdGMxUVQyMFRLcVRkMGdxUGliVmhn?=
 =?utf-8?B?RytqM2tyM1ZnMVNSQnlSaDNSbFcvQStZeTdSYUlKWFhLYVMzaTNJSnRmZ0lq?=
 =?utf-8?B?YWpLVEJFVnAxL1AxajRvQnZZYWZSaVRyMGFiQ3lPclpjTG83UWJ0RGNMRnla?=
 =?utf-8?B?NWpDakN1cU1HWVFoWDVhcUFNL0lRUStEcG1IaU44NEN1MG01MjUxUzFLVjBw?=
 =?utf-8?B?bC9WQi9mLzVwRnFvK2tFR2hFekpESHNXQ215U29lZmo0ay9YWWVvUkFKQ1lV?=
 =?utf-8?B?cmh1VnJLd0g3Q0dmbEcveWVTNzJKNFdvWmdXWVZtU2VRQU1kNzJJQnRQYlR3?=
 =?utf-8?B?dUhOdzRUOUcwT3oyQUNIQ3djSUdoYjBDY25aN0xwOWdYT2NaaUJ1M1FLRGRk?=
 =?utf-8?B?eEhxZEQ0SEkxRHFrRWxqaEdsVUc1QWQvekpobVJFaEJ3dEt1cXJyQm16dkZt?=
 =?utf-8?B?SDRyUzhTUmh5SkIrNlBEeEl3dnFYeC91Z1Y0T1ZVUmJVWnFCYkRUQTRzalJv?=
 =?utf-8?B?TmNWck9zaDFYa21DUEIwUVFLN2ZRblR4dWhTN0JKR1hWd0FueGRwL2owSllj?=
 =?utf-8?B?bWt1eHRvMDVlLzlEbXhNQWpRWHZIQ2ltbForSGhLVDdhSTBldWUzNkZCOEF1?=
 =?utf-8?B?cktsOXB1Zk9pVjVzZjZJRkhFUWc3Q3Z6bzliT3hwUmlSZ1lLNytnS25vbXEv?=
 =?utf-8?B?VnkzUjJJUlRKZmgwMGxSUmpsZzFvR3o1QVg1RGJwNmE4Y3AzY1k5aDlQNnk3?=
 =?utf-8?B?RzhDbkgyd2xScWIyNnhMOUd1ekxSaVhxV3BCQ1gzblFUbnRFVk56RzdxQUhE?=
 =?utf-8?B?amZNUEFySjlQNVp1dHlINWZQUDNrTExsOGRBbVcvNkVaK3N5YXNHMnhmaW9V?=
 =?utf-8?B?bHRRY0w0K3BITjdtVlo2Tll2MWlDRVRVY3pxVHRCZ1ZYbU5pcFR2aU5pY3A0?=
 =?utf-8?B?dXdBeU9xYytMbDB2NU56M2g2ZkRqOW5IcUNEM1p2K2dHejZrdXhLckZFY21C?=
 =?utf-8?B?MEhNc1NURlpXb1ZKOUo4cnAvR2RDQ013a1BoaU8zdkErVnNPYTFONzdsNTRk?=
 =?utf-8?B?TXcrdVNqY1lCM3p3YlNFMHcwN1NqWmtjcmw3ZzlNNWRwbjhFd0g4SVdsbG56?=
 =?utf-8?B?SWo1R0poRHJ0Q2FoT0dUVVFiekNGOUs1ZEgrd0JYQjBjRC9pVDMvSTRGc2g3?=
 =?utf-8?B?VVZibU5FMGxVN3FJV2JMOGh2SXhlRnl5VDdMK3YrdFR4UW9rL0lzL1FpK3Ev?=
 =?utf-8?Q?HzuXLsm+ZA4hcEypXafQbYB5jt2//h7JrasslSt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb56968-cb36-4812-5551-08d967c2bfe2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 12:20:39.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgYxqNJLsSpDe/fA3xoH1nQVfCX9MtVy1lAHvDcjS1/WyUxYRaYvZp6hYf6MlGBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
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



On 8/25/2021 4:52 PM, Nirmoy Das wrote:
> To get a hardware queue priority for a context, we are currently
> mapping AMDGPU_CTX_PRIORITY_* to DRM_SCHED_PRIORITY_* and then
> to hardware queue priority, which is not the right way to do that
> as DRM_SCHED_PRIORITY_* is software scheduler's priority and it is
> independent from a hardware queue priority.
> 
> Use userspace provided context priority, AMDGPU_CTX_PRIORITY_* to
> map a context to proper hardware queue priority.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 127 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  44 ++------
>   3 files changed, 105 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index e7a010b7ca1f..c88c5c6c54a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -43,14 +43,61 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>   	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
>   };
>   
> +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
> +{
> +	switch (ctx_prio) {
> +	case AMDGPU_CTX_PRIORITY_UNSET:
> +	case AMDGPU_CTX_PRIORITY_VERY_LOW:
> +	case AMDGPU_CTX_PRIORITY_LOW:
> +	case AMDGPU_CTX_PRIORITY_NORMAL:
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static enum drm_sched_priority
> +amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
> +{
> +	switch (ctx_prio) {
> +	case AMDGPU_CTX_PRIORITY_UNSET:
> +		return DRM_SCHED_PRIORITY_UNSET;
> +
> +	case AMDGPU_CTX_PRIORITY_VERY_LOW:
> +		return DRM_SCHED_PRIORITY_MIN;
> +
> +	case AMDGPU_CTX_PRIORITY_LOW:
> +		return DRM_SCHED_PRIORITY_MIN;
> +
> +	case AMDGPU_CTX_PRIORITY_NORMAL:
> +		return DRM_SCHED_PRIORITY_NORMAL;
> +
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return DRM_SCHED_PRIORITY_HIGH;
> +
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return DRM_SCHED_PRIORITY_HIGH;
> +
> +	/* This should not happen as we sanitized userspace provided priority
> +	 * already, WARN if this happens.
> +	 */
> +	default:
> +		WARN(1, "Invalid context priority %d\n", ctx_prio);
> +		return DRM_SCHED_PRIORITY_NORMAL;
> +	}
> +
> +}
> +
>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
> -				      enum drm_sched_priority priority)
> +				      int32_t priority)
>   {
> -	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
> +	if (!amdgpu_ctx_priority_is_valid(priority))
>   		return -EINVAL;
>   
>   	/* NORMAL and below are accessible by everyone */
> -	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
> +	if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
>   		return 0;
>   
>   	if (capable(CAP_SYS_NICE))
> @@ -62,26 +109,35 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   	return -EACCES;
>   }
>   
> -static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
> +static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>   {
>   	switch (prio) {
> -	case DRM_SCHED_PRIORITY_HIGH:
> -	case DRM_SCHED_PRIORITY_KERNEL:
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>   		return AMDGPU_GFX_PIPE_PRIO_HIGH;
>   	default:
>   		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
>   	}
>   }
>   
> -static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
> -						 enum drm_sched_priority prio,
> -						 u32 hw_ip)
> +static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   {
> +	struct amdgpu_device *adev = ctx->adev;
> +	int32_t ctx_prio;
>   	unsigned int hw_prio;
>   
> -	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
> -			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
> -			AMDGPU_RING_PRIO_DEFAULT;
> +	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
> +			ctx->init_priority : ctx->override_priority;
> +
> +	switch (hw_ip) {
> +	case AMDGPU_HW_IP_COMPUTE:
> +		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
> +		break;
> +	default:
> +		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +		break;
> +	}
> +
>   	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>   	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> @@ -89,15 +145,17 @@ static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>   	return hw_prio;
>   }
>   
> +
>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
> -				   const u32 ring)
> +				  const u32 ring)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
>   	struct amdgpu_ctx_entity *entity;
>   	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>   	unsigned num_scheds = 0;
> +	int32_t ctx_prio;
>   	unsigned int hw_prio;
> -	enum drm_sched_priority priority;
> +	enum drm_sched_priority drm_prio;
>   	int r;
>   
>   	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
> @@ -105,10 +163,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	if (!entity)
>   		return  -ENOMEM;
>   
> +	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
> +			ctx->init_priority : ctx->override_priority;
>   	entity->sequence = 1;
> -	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> -				ctx->init_priority : ctx->override_priority;
> -	hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority, hw_ip);
> +	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
> +	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
>   
>   	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>   	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
> @@ -124,7 +183,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		num_scheds = 1;
>   	}
>   
> -	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
> +	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
>   				  &ctx->guilty);
>   	if (r)
>   		goto error_free_entity;
> @@ -139,7 +198,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   }
>   
>   static int amdgpu_ctx_init(struct amdgpu_device *adev,
> -			   enum drm_sched_priority priority,
> +			   int32_t priority,
>   			   struct drm_file *filp,
>   			   struct amdgpu_ctx *ctx)
>   {
> @@ -161,7 +220,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   	ctx->reset_counter_query = ctx->reset_counter;
>   	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>   	ctx->init_priority = priority;
> -	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> +	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
>   
>   	return 0;
>   }
> @@ -234,7 +293,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>   			    struct amdgpu_fpriv *fpriv,
>   			    struct drm_file *filp,
> -			    enum drm_sched_priority priority,
> +			    int32_t priority,
>   			    uint32_t *id)
>   {
>   	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> @@ -397,19 +456,19 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   {
>   	int r;
>   	uint32_t id;
> -	enum drm_sched_priority priority;
> +	int32_t priority;
>   
>   	union drm_amdgpu_ctx *args = data;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   
>   	id = args->in.ctx_id;
> -	r = amdgpu_to_sched_priority(args->in.priority, &priority);
> +	priority = args->in.priority;
>   
>   	/* For backwards compatibility reasons, we need to accept
>   	 * ioctls with garbage in the priority field */
> -	if (r == -EINVAL)
> -		priority = DRM_SCHED_PRIORITY_NORMAL;
> +	if (!amdgpu_ctx_priority_is_valid(priority))
> +		priority = AMDGPU_CTX_PRIORITY_NORMAL;
>   
>   	switch (args->in.op) {
>   	case AMDGPU_CTX_OP_ALLOC_CTX:
> @@ -515,9 +574,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   }
>   
>   static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
> -					    struct amdgpu_ctx_entity *aentity,
> -					    int hw_ip,
> -					    enum drm_sched_priority priority)
> +					   struct amdgpu_ctx_entity *aentity,
> +					   int hw_ip,
> +					   int32_t priority)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
>   	unsigned int hw_prio;
> @@ -525,12 +584,12 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>   	unsigned num_scheds;
>   
>   	/* set sw priority */
> -	drm_sched_entity_set_priority(&aentity->entity, priority);
> +	drm_sched_entity_set_priority(&aentity->entity,
> +				      amdgpu_ctx_to_drm_sched_prio(priority));
>   
>   	/* set hw priority */
>   	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
> -		hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority,
> -						      AMDGPU_HW_IP_COMPUTE);
> +		hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>   		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);

Not related to this patch, but this kind of logic may break some day. 
There is a HWIP specific priority and there is another RING_PRIO which 
is unmapped to HWIP priority Ex: when a new priority is added for VCN 
which is higher than any of the existing priorities.

Thanks,
Lijo

>   		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>   		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> @@ -540,14 +599,14 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>   }
>   
>   void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
> -				  enum drm_sched_priority priority)
> +				  int32_t priority)
>   {
> -	enum drm_sched_priority ctx_prio;
> +	int32_t ctx_prio;
>   	unsigned i, j;
>   
>   	ctx->override_priority = priority;
>   
> -	ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>   			ctx->init_priority : ctx->override_priority;
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>   		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 14db16bc3322..a44b8b8ed39c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -47,8 +47,8 @@ struct amdgpu_ctx {
>   	spinlock_t			ring_lock;
>   	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>   	bool				preamble_presented;
> -	enum drm_sched_priority		init_priority;
> -	enum drm_sched_priority		override_priority;
> +	int32_t				init_priority;
> +	int32_t				override_priority;
>   	struct mutex			lock;
>   	atomic_t			guilty;
>   	unsigned long			ras_counter_ce;
> @@ -75,8 +75,8 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   				       struct drm_sched_entity *entity,
>   				       uint64_t seq);
> -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
> -				  enum drm_sched_priority priority);
> +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
> +void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t ctx_prio);
>   
>   int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   		     struct drm_file *filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index b7d861ed5284..e9b45089a28a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -32,37 +32,9 @@
>   #include "amdgpu_sched.h"
>   #include "amdgpu_vm.h"
>   
> -int amdgpu_to_sched_priority(int amdgpu_priority,
> -			     enum drm_sched_priority *prio)
> -{
> -	switch (amdgpu_priority) {
> -	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> -		*prio = DRM_SCHED_PRIORITY_HIGH;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_HIGH:
> -		*prio = DRM_SCHED_PRIORITY_HIGH;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_NORMAL:
> -		*prio = DRM_SCHED_PRIORITY_NORMAL;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_LOW:
> -	case AMDGPU_CTX_PRIORITY_VERY_LOW:
> -		*prio = DRM_SCHED_PRIORITY_MIN;
> -		break;
> -	case AMDGPU_CTX_PRIORITY_UNSET:
> -		*prio = DRM_SCHED_PRIORITY_UNSET;
> -		break;
> -	default:
> -		WARN(1, "Invalid context priority %d\n", amdgpu_priority);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>   static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>   						  int fd,
> -						  enum drm_sched_priority priority)
> +						  int32_t priority)
>   {
>   	struct fd f = fdget(fd);
>   	struct amdgpu_fpriv *fpriv;
> @@ -89,7 +61,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>   static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
>   						  int fd,
>   						  unsigned ctx_id,
> -						  enum drm_sched_priority priority)
> +						  int32_t priority)
>   {
>   	struct fd f = fdget(fd);
>   	struct amdgpu_fpriv *fpriv;
> @@ -124,7 +96,6 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>   {
>   	union drm_amdgpu_sched *args = data;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> -	enum drm_sched_priority priority;
>   	int r;
>   
>   	/* First check the op, then the op's argument.
> @@ -138,21 +109,22 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>   		return -EINVAL;
>   	}
>   
> -	r = amdgpu_to_sched_priority(args->in.priority, &priority);
> -	if (r)
> -		return r;
> +	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
> +		WARN(1, "Invalid context priority %d\n", args->in.priority);
> +		return -EINVAL;
> +	}
>   
>   	switch (args->in.op) {
>   	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>   		r = amdgpu_sched_process_priority_override(adev,
>   							   args->in.fd,
> -							   priority);
> +							   args->in.priority);
>   		break;
>   	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>   		r = amdgpu_sched_context_priority_override(adev,
>   							   args->in.fd,
>   							   args->in.ctx_id,
> -							   priority);
> +							   args->in.priority);
>   		break;
>   	default:
>   		/* Impossible.
> 
