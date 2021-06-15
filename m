Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1521EC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 06:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E1961413
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 06:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E1961413
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7541D89E0D;
	Tue, 15 Jun 2021 06:55:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE30389E0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 06:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnatdlFGaAeFeTnNufjjRaYUsRBOzyy/w/BI51BObaNkfT5bVKEKy6kwk4fH43HV8En/aVWBWKDlEepdNGB8cl4oWx9RQA6Vt4iBMko9Qo313HhyIDg7+KELOEGj+vOPb8CuAy6PVdpdxQ6YhyxTTnAo+J7u+xxtekBR3lAqXyBym49dqK47T97nOROOhffhg8UF4JplBUnBKJbC/slm1vJ4lta/OILqFPHtA0jM4d8xmVizKZJ3RvIMvypsK/vS7S8qv9Juo1ZHx/x/LdogavXyjRbLou5OM/MKg63zdgfzwLCPi79QJtHxRX3Xb3dk9mbgg8lNTSWqnrk5DBszdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oRlQ/CqtdGK4nTD5OSmvo5Gwz/IMX8lLLOQfajupHY=;
 b=XqTiRQ0tNyCJN4c4y7ll5E87J2LvP1RJszZCY+Gpbp1Nih8WWzVORL4rSW9o8+0J05OpXZ/uYrDjs7eLPdI+B5jQxIc7j1dOFb4zEkO4uWniM13okCLZm2lx4xwFsvDrMzcBNB60b7z8keVNykAINl1DLZR2tQw69qc09BOR0s8cdptmlGHTmXJpA0rDcpAdnUa/OqTuPwIw1RLZzumcohH+UmgD4uhRYCxacJHoGn4ev++liRaXP7d4lOeSd1ZqARtI8B+lyhutG145ZKtFvM6Rxal2RP8ihoTvqDUE0TqucSCt/AACEz8M2ZTKvCtE5ypG81D4A1/RIeiGU0advA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oRlQ/CqtdGK4nTD5OSmvo5Gwz/IMX8lLLOQfajupHY=;
 b=gE3eFouNFwWw3bbcS8lPEPS1PbdvEJvsnASEdTb91HKKvh8mhPSIgeJXcMnExu+Ot8c5d+85xZ75FQAboM5aqM3/CnevBPksPRmz6a6epyXVPwK/XbG6UdpdIg5tYPr58L96qhibvtFIl4K2FAo3Ltlwgz7T50i+lGquBPDzlQs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2516.namprd12.prod.outlook.com (2603:10b6:207:4e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 06:55:35 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 06:55:35 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: move shadow_list to amdgpu_bo_vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210614192653.18239-1-nirmoy.das@amd.com>
 <20210614192653.18239-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <20877972-3d8e-6419-bddd-6c6e78830083@amd.com>
Date: Tue, 15 Jun 2021 08:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210614192653.18239-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:f438:4e93:3853:400c]
X-ClientProxiedBy: PR1PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::40) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f438:4e93:3853:400c]
 (2a02:908:1252:fb60:f438:4e93:3853:400c) by
 PR1PR01CA0027.eurprd01.prod.exchangelabs.com (2603:10a6:102::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 15 Jun 2021 06:55:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 233cd2d3-3b6d-49e0-95bd-08d92fca931b
X-MS-TrafficTypeDiagnostic: BL0PR12MB2516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2516EE2691519A2031C3119683309@BL0PR12MB2516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJUMiKTW8BrqCmji1PBV9VgrKK2R5rJHoUJJcm7C7IWlHDghvBVvFqFI0OhLk7KfTCatKDvmjMOnl6CRHlCMMEnko5TlOOI0Vx2Lw3qM6w0139DEYu7GoesQCha/+Ih2K8FYnspcOT8u5rgE0AyHu3MO33yOfm7SJeSQRMpBf39ZnTkxYTPbhHtTFB+ducd+TEcrW5LGyCpHwDItIb8STJV/h08h6tsNIZjzbZ6zItPp8tLfLy/k8gyGJo1lIhlrpEDd/eoqKGH5FwIeeAd01JVgHdEgkEmI9VmAIRgRTzX/YUqnoznNwZ6VYStsx5lYRrCzC60Uz4tWwFtYl4mdE9KKJNa8DyFgeMD+kWnxOO/YThj0uvzS+tqGdTu2QCL79RnB/V30u/MiRUt7R6WW8u55mc93EQEfTDqY6OLnC6ziT/KA928MthGLOcWtzkHWr28IDN8A2rNp8FPKq+COVOO43ejoRFLEpjFs1ieD6VLnEdss/bFaXhZmEy8tOpr2kZTvgAeGd6TuFnO5/K/wrnToE4iVmjlRNQ9veDBg+CN+kKzsa3rS8lTJa74iy6hHuYLxuflnR8Ws4d3v2+80v0c34d589ng5vaxYe2y/OdaAVxjhCdQ2dBNzlMOPirdummpkGki1vriM+l8XcQkb9l7P69moqx0pavSC58QqJxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(86362001)(36756003)(66556008)(8936002)(316002)(8676002)(83380400001)(478600001)(66946007)(31686004)(66476007)(6666004)(2906002)(6486002)(186003)(5660300002)(16526019)(2616005)(31696002)(38100700002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BqMzBQSmpMcGk1RXcreUgwakkwWFFRUkpIdmQwaE5WcitHUGZsamJFT2lE?=
 =?utf-8?B?MnhJb2gyYTNBK2lEM0JNbHZHMG95eitwNHUzTWhPSmZNSTBSOCtJUjUzTEVF?=
 =?utf-8?B?L0FpOGl3UzR1TXJ4bmNaQUZwSjFvNHAzQUVJeURodXB3cGF2ZnNSVFJlZ3du?=
 =?utf-8?B?dVdlRGZYVVVTdXc4OG1nVXkxRER3WHluWHNZR3Q1Mjd2bDRidUl2L0FPYXdW?=
 =?utf-8?B?dEdYZ012eVZidmJSTzNjeVVZeS9pUWgzQjNieWZwOC9ZVDlEeHVMQzBxWlhq?=
 =?utf-8?B?NE5vT1BGZDN2dTVVcTg3dWhLOVNQdi96NTAwaEFRbHAvRVAzdDUrY2twR1JH?=
 =?utf-8?B?b1ZpbmJ0Qlp0TW9BUUdXcVdLbHk3d3lneXZGRUdnM0JmSHdXRmF3M0owOHlB?=
 =?utf-8?B?dnk2NTh6akEzUGprbnFJOUY1ZUR0TnhzOFNUMTBpVnhCUEpWL2tIbkZBZVVF?=
 =?utf-8?B?VEtTaWZNajhNdE5YVHVmUGNWVXRjUWVFR0RtWTVtMytpNWF2bUV3VXBJTHJK?=
 =?utf-8?B?cHBVdExtZVRBVTZsa3M2Ulg5V0RCOW9uMDRPUG1mbWV6VzNnbjhFa0ZjU0lN?=
 =?utf-8?B?VEtFWUhYWWNRRU0zd3hiU2tEaElaUFdaMVJFK2U0VWZLdHZhWnZTUGNRRjY3?=
 =?utf-8?B?cU4rYnZacUlwTzRnSmNEYVAzek84VmJVbmVud3d2cER4RGJxaEFVdU5abEZs?=
 =?utf-8?B?S3hZaTU3OURBUmpxcTBlWlA3QkxFenc5UUd6ODE5THBaOGhkenE0RGdZM0Rn?=
 =?utf-8?B?Y3RrcW45ODIrQU1ONHl0SEpUd3pEZzUydVFmS3d4Tmw5aC9Da0NXRnRUV2lR?=
 =?utf-8?B?SlNnVnQ4cXFBQTQremliK3gvQXdOdDVVdFlXc0t6bmZLZDd0MlFETkdMaW55?=
 =?utf-8?B?L1FiS3ArV0kwOVh2NHVvZm8xRGNtdC90UlYyUDhlRGRrcnVLbm1YZk1QV3l2?=
 =?utf-8?B?OWNHbDdQeFhtU2NpWUprWTJnZ0lFdzIzYnc1RWhoMXFyM2FUK1J0dHRPYTNt?=
 =?utf-8?B?R1FDSWZuK2JsTjdtNlZTVlBzMkZXUFRZWUlqVDhRcHdWNFp2SE1DbEJoZVR6?=
 =?utf-8?B?L3RUSU1Wb2o1Z2dSZUhyTzE0ZFRjVVlHcy9LNTRTSUpzT1hEeG5UVXdqZzNO?=
 =?utf-8?B?SWs1WDRMZ0p6VWJnQStxckFzcjRtcXdCY0VOK3dPcWxveGV6VkZQSVpRelhR?=
 =?utf-8?B?Z29zUHpHTlVWdEh0QnRZbTNXeDRVSnBSaTRhRGV4eE1CK3lob3FYWmMzM25q?=
 =?utf-8?B?ODNpNENhL01Lcyt4WHZLZ0lIbXRkTnBFa1RjTEdsQVBhVml6OFY4QVhyc2dy?=
 =?utf-8?B?TG1KMENOWFZNYmhYNGFzS09QZkFzdDg4bnZUVDF5WXA0VEtSVXdZb1h6eUY3?=
 =?utf-8?B?NGJNczE1MDR3MmUyWWxoWTJIdXc3N0hUKytqUEZzdVduWlZIUGF4cWpuOWpU?=
 =?utf-8?B?WjMrMDZlaXB0eHR5aE9BQ1JXVGMrVFJVYml0cTJCVEZrVHY5STZtOVNobHBk?=
 =?utf-8?B?VHRpeTgzQ3dYelR2N29MUWtTMXNtUU1NdlRJeThCRjJUWjF3OFNrMmRXNUIx?=
 =?utf-8?B?eXZwRVN3a3BkcktNaktnOHIxWFlJSHhuWEZETzZFZDBtOGllSmwwT1JhRDFM?=
 =?utf-8?B?Vms0U3B5N0czZUpqT2hzTStUcVExb1FabUU3QitZSXpTajFtYTAzOVAwcFB6?=
 =?utf-8?B?cHJNa29uK2F2a0NZRXI3VmpvT1JlenhmOXJuWms0MExLNU1qWVQrR2JvTFAv?=
 =?utf-8?B?bTM5RE4yVzdXK1dzTmxpSm1pNW95dnBtRWtXTWxhWWFhU1JRczQrZGdlZlBB?=
 =?utf-8?B?SWNsalhHazlmdHMzRkkwQUIyWG8yLzFRK1NUanJEVDJxcVBBVjhnWTROVDRm?=
 =?utf-8?Q?4jxWw9R3+t7Ye?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233cd2d3-3b6d-49e0-95bd-08d92fca931b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 06:55:34.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShEX5rtBX5A+a3O8YWYUwkwzMvoqIisVbSD084wfLfN13PU6ZLxT1neEiR9DD64g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2516
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.06.21 um 21:26 schrieb Nirmoy Das:
> Move shadow_list to struct amdgpu_bo_vm as shadow BOs
> are part of PT/PD BOs.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  2 +-
>   4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f2636f411a25..3f51b142fc83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4063,6 +4063,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>   {
>   	struct dma_fence *fence = NULL, *next = NULL;
>   	struct amdgpu_bo *shadow;
> +	struct amdgpu_bo_vm *vmbo;
>   	long r = 1, tmo;
>   
>   	if (amdgpu_sriov_runtime(adev))
> @@ -4072,8 +4073,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>   
>   	dev_info(adev->dev, "recover vram bo from shadow start\n");
>   	mutex_lock(&adev->shadow_list_lock);
> -	list_for_each_entry(shadow, &adev->shadow_list, shadow_list) {
> -
> +	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
> +		shadow = &vmbo->bo;
>   		/* No need to recover an evicted BO */
>   		if (shadow->tbo.mem.mem_type != TTM_PL_TT ||
>   		    shadow->tbo.mem.start == AMDGPU_BO_INVALID_OFFSET ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index f4f57a73d095..9f1e6bd8601b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -111,12 +111,13 @@ static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +	struct amdgpu_bo_vm *vmbo = to_amdgpu_bo_vm(bo);
>   
>   	amdgpu_bo_destroy_base(tbo);
>   	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
> -	if (!list_empty(&bo->shadow_list)) {
> +	if (!list_empty(&vmbo->shadow_list)) {
>   		mutex_lock(&adev->shadow_list_lock);
> -		list_del_init(&bo->shadow_list);
> +		list_del_init(&vmbo->shadow_list);
>   		mutex_unlock(&adev->shadow_list_lock);
>   	}
>   
> @@ -592,7 +593,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (bo == NULL)
>   		return -ENOMEM;
>   	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
> -	INIT_LIST_HEAD(&bo->shadow_list);
>   	bo->vm_bo = NULL;
>   	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
>   		bp->domain;
> @@ -722,6 +722,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>   		return r;
>   
>   	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
> +	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
>   	return r;
>   }
>   
> @@ -766,12 +767,12 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
>    *
>    * Insert a BO to the shadow list.
>    */
> -void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo)
> +void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(vmbo->bo.tbo.bdev);
>   
>   	mutex_lock(&adev->shadow_list_lock);
> -	list_add_tail(&bo->shadow_list, &adev->shadow_list);
> +	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
>   	mutex_unlock(&adev->shadow_list_lock);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index a8c702634e1b..18cb2f28e4de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -109,9 +109,6 @@ struct amdgpu_bo {
>   #ifdef CONFIG_MMU_NOTIFIER
>   	struct mmu_interval_notifier	notifier;
>   #endif
> -
> -	struct list_head		shadow_list;
> -
>   	struct kgd_mem                  *kfd_bo;
>   };
>   
> @@ -127,6 +124,7 @@ struct amdgpu_bo_user {
>   struct amdgpu_bo_vm {
>   	struct amdgpu_bo		bo;
>   	struct amdgpu_bo		*shadow;
> +	struct list_head		shadow_list;

We would actually need an amdgpu_bo_shadow for this, but not in this 
patch probably.

Christian.

>   	struct amdgpu_vm_bo_base        entries[];
>   };
>   
> @@ -333,7 +331,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>   int amdgpu_bo_validate(struct amdgpu_bo *bo);
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
>   				uint64_t *gtt_mem, uint64_t *cpu_mem);
> -void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo);
> +void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
>   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   			     struct dma_fence **fence);
>   uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 4c4c56581780..812c225538a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -936,7 +936,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	}
>   
>   	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
> -	amdgpu_bo_add_to_shadow_list((*vmbo)->shadow);
> +	amdgpu_bo_add_to_shadow_list((*vmbo));
>   
>   	return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
