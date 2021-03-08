Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C1C433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90F56527B
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F56527B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724106E878;
	Mon,  8 Mar 2021 20:24:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1EB6E878
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 20:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQz1OZMDnduOJHzsuSX1LkibCGt13VA86fhE/TeRNga9+eaSqDtlleM2tMHhtHj0KetuUYNoyFrdSqSy/kfmQGoDTx/2Ddn4yJQjNrhtljJsSD/YLPctrOvKdG9hIWg55Qk0hB+7A1mYpUOwYg4vXRGCIxI8dw8xfKrKxhKGZu4QZmNtAY0ZFnYZhhuthn57n5e8MurSc7JNJTTvQuvcRITHPKFCsGdRt9kT8ARGj6mDhk3kwodpqFe511jKZtroyjFiF7wnzFh7J8UnSR3Jvb0MlQmeuJ0hDbDz3RBJbStxOjGJkYhD2QaxtKwHuU9efSfQ5BXGJ8qZwzHuj4nzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR/WbSB0iB2cKUr4U4XgaWmmDgvwa2WellMNtEVxdbA=;
 b=B4y56lkzSxLQQ5oc5hcXf6rrwAWwyfHqzTwJn+gP3CuGzNYDVviu2LjtSe3juOATdpMbTgZuzHJknkxvDL5tcyZb9VFdJQlMjX/5yHk/G2ohPvRuK6k21Im890q7yXG6HzH4dmJFJyPcuK7y7joMcMj3aoAjBPkvyYd9pa3W8/xStnafjy1a80bO8DO0QWOImGyCKXrNx7gtsODKNU7RJls3ak1CkaHlIWoKVmNvDPTaFZPNLs0uqh+2YDh1Tv9g8HAtyJCSm65SxXAQxXx+TCMPRS/MF9dE9/i+PNKUwJaHnAHDQxhtc3gvZrzceL+LpOlJxz0LnFC4W1UYhrmfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR/WbSB0iB2cKUr4U4XgaWmmDgvwa2WellMNtEVxdbA=;
 b=1QT4ZvzNVONdfb7g1oJnHnvcvHdeBfBsZ8PX97h97FwA+PSjJVY+ejGjfdp1Hiis9jenmoaiYnYKYKqWTSxjiP7Hgp+sf8l4JBBzmJ8/WbuNtV0pSBzoVJVU0aP6gQrVhn+quSxRe5CfU6SKD0hbhQ4DjgrdkzIi6A/mEh/d3+c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Mon, 8 Mar
 2021 20:23:59 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 20:23:59 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: use amdgpu_bo_user bo for metadata and
 tiling flag
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
 <20210308153705.37414-5-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ec337f2e-8ca4-2dbb-8c4b-b354a98747d7@amd.com>
Date: Mon, 8 Mar 2021 21:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308153705.37414-5-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a01:c23:6c03:dc00:772e:c5dc:d360:4620]
X-ClientProxiedBy: AM3PR05CA0108.eurprd05.prod.outlook.com
 (2603:10a6:207:1::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a01:c23:6c03:dc00:772e:c5dc:d360:4620]
 (2a01:c23:6c03:dc00:772e:c5dc:d360:4620) by
 AM3PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:207:1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 20:23:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39601358-e2f1-48f3-f80a-08d8e2701b00
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB372542F6065FADB0485AF2FD83939@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPT7BA8J91zMcuTpXPdOe7HT3TiFJNbIC2RLzNpM7On3LJaahnjTa9PrFSVK3fd3ggk6DNY8oREk2Fd5T+L2KwATSV67EhO1XCBNxCvq6pK5qclEw5HLT5iUvnk0KPh6NuDU+zMvPZ71Ivl/aC0oxXRv8AmYmpMNI/jjVUPW963YMvE8KiAYvbMLQZGwrVV3BIIURMlm5iXyPmRI6jmhwSnjml0BUzzJoFggF5XNz1uL0R3Lps/d+3cpsbyuuFGRL56V1aZtwG4BsxtjuQ8sgtRY5jo66KQu/d5InZnQWa/M3SEmcV85qwEKnbQcFfHyddP54N8Uxjn5Mc9FTy023NyT0VscgxT3ajSnAZR6VFBVn+clxaTwl0eYGgWXmlkPD4CWYbkeSDYYzVc4alVzgcXXAPXeYr8hkiff2s9roaVkBFyml//kB3CZm5p9WJHw3Z0ZKnVLFJDi7h6K5RDR0YFJW0lJ8jnhxK7PEJX6j+WF9VMKc46zZtunP0QKUFdYI+GdTxjuOhx4Vi3NNkL9qlLKkwZpLjpSztbrWL1tGEbiCe1yM+jCSGJXL8QUnklvyVuW55rM5W2urlqDwurFKBN4rseVjjpdFvr7tPvs4Dw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(16526019)(6666004)(186003)(66946007)(66556008)(66476007)(2616005)(31686004)(6862004)(8676002)(83380400001)(6486002)(2906002)(4326008)(6636002)(52116002)(37006003)(316002)(8936002)(86362001)(31696002)(5660300002)(478600001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFVnRE9hR2dReXdBdHZpMW13RVFNK3BMeXpkNVFYY242UGlscXdjSzJzQWM3?=
 =?utf-8?B?aEZibnNhNWFuTDZKaHFROTBueE1xT3c4d0FCRUJRamhiSU1aQ1ZqMGt4d2pF?=
 =?utf-8?B?K3ZiRTNldGpYQm5MZXhkSURVOHdUUGtPYTJ4WDB4ZW1YMlhhWUp0VXZUUFA5?=
 =?utf-8?B?aE03K2RhcUk3dlFvUDQrUHlRalpPTDZwRVk4SzZBdUR6MkFtV3NNbERqNURX?=
 =?utf-8?B?Z0FOSEtrU2VWaHVDSVMwUTVlSDRuUExKMU0zQVk5NXBLUDVFT05JMVY1cjBW?=
 =?utf-8?B?OXlhUkorNlJaZWRJQm8vM1MwaFdJalgyTk9vVnR6S1VMWndXZnkyQlJQZGRy?=
 =?utf-8?B?YUdrM21rL2xWcm5HQU16bC8yWHAySldqSEoyMG52YTBpZXZGeDlad2RDSW90?=
 =?utf-8?B?bU1jOXlpZTZ1VWZTTTlmWGRvZWJxQzBROHVIelEvcXljcnVOOWY1UCtLQW1Q?=
 =?utf-8?B?Smxma2ZjbGVGeGRQRDY3aXdTUzZlRGpZd3FlMXdWMlVsZEpjNHVzS2JrVTBl?=
 =?utf-8?B?MjNLOG5GQXFyMVRXZjBoalZmUzlkWWFOR1dCV3lvejk0a0lxVTBCZ2NkYzhu?=
 =?utf-8?B?UEVZdmJrQ0NiUHRJTTFmdjRwWmhuM2U5ejJLeHRQWEovRFR0ek1XcFBmSGw4?=
 =?utf-8?B?Z0FxV01rMzNIaGwwejZOMURjR3FIL0hZSjNacDlHak1TNmU5WTNJTkZVRG1j?=
 =?utf-8?B?VzRzUDE2ajlaYklSbXF5b3p3dk15cmpkNkJTdDdyZGR4MUtINHlqWUdiS2Rx?=
 =?utf-8?B?NjNBa2dRZFBpN295YzZJNTQycjVoRHFCTFZ6cXVIOVd1S0JDZW14WHE1NGpY?=
 =?utf-8?B?QkcyTEg4OUxRbjNnRVd4alFZalJSMkNJb0MxSUl3SE13eWR2MERBWi9wTnVl?=
 =?utf-8?B?TVF5UjZSRTE5S0xNUkFKcVN3T0dWblJaQllYYUNZZkhBWWxQV2VicDJSVEFM?=
 =?utf-8?B?RFJwaWJ2cDVFeVNYUFc4cUhqU0ROMzFhR2NaYStkOUVCMk1zS2xUWkk0b0N1?=
 =?utf-8?B?bWxjdURVQlY0RnJQRG11eVdhK3ZxV2FveWhtcXFtRDhwakJjeGZUcWZHSVJv?=
 =?utf-8?B?bUtUb0ZmbExlanZNcE1yOWxBMjlGeVVKOW92RWJFY3kvR21CM3FOU3dGa3Qx?=
 =?utf-8?B?NGdmbDVuZGhNaFVyTkQ2ck9RcGMxZFpFYmdIR3RYWVBuKzNNdmxaSS9vYmhD?=
 =?utf-8?B?MUJrRXM3SnhQQzE5KzJiMERCQW91dVF0eEFoODVTcjZRcnZsME81djY3eW1N?=
 =?utf-8?B?eXVwbDMyNS9KRklJU3VLUVFWL1loeUNzR2ZITXp3UmlweVZIK3dxaDRhcGlV?=
 =?utf-8?B?R0FhYWp6OTdtRVhEbENET0RhY1dFeTNySlpQQVpJOVN3ZjQzK2toWm1CcUdQ?=
 =?utf-8?B?b0dFcHV2cXdwYkswVndEcXRBOGV4M2dEVHMzeFZUT21CMnRyU2s1VjlXRzZ3?=
 =?utf-8?B?dkp4dWQ3c1dZQ3hNUC9ZTVMzazNlVktDQTlMbFB4RjYzdVlWZUJzdCtnT3g0?=
 =?utf-8?B?TysraUZ0WGtZOWRqY0VjRUltVEF3T1hJcGhrNUFPK0pnNENXVitwNEtUQnB0?=
 =?utf-8?B?Z0hSU2NsTm1JeG1HQUZMdzNDSlNBK2RIbHV0dG12Vmhka3lZdUJ4V2g2NDE4?=
 =?utf-8?B?OWdzcFZJc05hdm9oY0hMU1g4eVRkNDBObVFvSlM5SVRaM3F1UTR1MXAxR0wz?=
 =?utf-8?B?RzJmRXo1Sll3U3k1VkVHaHZvVHU0UjhrVks0WDk1M0piN1BQMmNJamlOT3Yv?=
 =?utf-8?B?c2hEU2J1UTlPVlNJdUNhUFhHazRhV2IyeGhFaU1Qb2lLRHZINzVkOWdYa25U?=
 =?utf-8?B?WEtNR0JnN21DK0w3cEErK2ZwcWxybnZGSmpHZ05ZRWFLd3BSYkJFVXRwOGkr?=
 =?utf-8?Q?Nhns3X7tuN8MB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39601358-e2f1-48f3-f80a-08d8e2701b00
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 20:23:59.3116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6vHTBumMVRLsbROmLPGKaCNQwsN25vckeFIfpf7TAI1D2/tKT2XIYw1tM1X0yPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
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

Am 08.03.21 um 16:37 schrieb Nirmoy Das:
> Tiling flag and metadata are only needed for BOs created by
> amdgpu_gem_object_create(), so we can remove those from the
> base class.
>
> CC: felix.kuehling@amd.com
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 59 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 --
>   3 files changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 00ac5c272f47..04a19cdc08c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -496,8 +496,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>   		*dma_buf_kgd = (struct kgd_dev *)adev;
>   	if (bo_size)
>   		*bo_size = amdgpu_bo_size(bo);
> -	if (metadata_size)
> -		*metadata_size = bo->metadata_size;
>   	if (metadata_buffer)
>   		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
>   					   metadata_size, &metadata_flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index abfeb8304894..c105ba96dd58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -77,6 +77,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +	struct amdgpu_bo_user *ubo;
>
>   	if (bo->tbo.pin_count > 0)
>   		amdgpu_bo_subtract_pin_size(bo);
> @@ -94,7 +95,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   	}
>   	amdgpu_bo_unref(&bo->parent);
>
> -	kfree(bo->metadata);
> +	if (bo->tbo.type == ttm_bo_type_device) {
> +		ubo = container_of((bo), struct amdgpu_bo_user, bo);

You could use your new casting macro here.

> +		kfree(ubo->metadata);
> +	}
> +
>   	kfree(bo);
>   }
>
> @@ -1161,12 +1166,15 @@ int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
>   int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_bo_user *ubo;
>
> +	BUG_ON(bo->tbo.type != ttm_bo_type_device);
>   	if (adev->family <= AMDGPU_FAMILY_CZ &&
>   	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
>   		return -EINVAL;
>
> -	bo->tiling_flags = tiling_flags;
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
> +	ubo->tiling_flags = tiling_flags;
>   	return 0;
>   }
>
> @@ -1180,10 +1188,14 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
>    */
>   void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>   {
> +	struct amdgpu_bo_user *ubo;
> +
> +	BUG_ON(bo->tbo.type != ttm_bo_type_device);
>   	dma_resv_assert_held(bo->tbo.base.resv);
> +	ubo = amdgpu_bo_to_amdgpu_bo_user(bo);
>
>   	if (tiling_flags)
> -		*tiling_flags = bo->tiling_flags;
> +		*tiling_flags = ubo->tiling_flags;
>   }
>
>   /**
> @@ -1202,13 +1214,20 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>   int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
>   			    uint32_t metadata_size, uint64_t flags)
>   {
> +	struct amdgpu_bo_user *ubo;
>   	void *buffer;
>
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not set metadata for a non-amdgpu_bo_user type BO\n");
> +		return -EINVAL;
> +	}

Either BUG_ON or DRM_ERROR, but keep that consistent please.

Christian.

> +
> +	ubo = amdgpu_bo_to_amdgpu_bo_user(bo);
>   	if (!metadata_size) {
> -		if (bo->metadata_size) {
> -			kfree(bo->metadata);
> -			bo->metadata = NULL;
> -			bo->metadata_size = 0;
> +		if (ubo->metadata_size) {
> +			kfree(ubo->metadata);
> +			ubo->metadata = NULL;
> +			ubo->metadata_size = 0;
>   		}
>   		return 0;
>   	}
> @@ -1220,10 +1239,10 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
>   	if (buffer == NULL)
>   		return -ENOMEM;
>
> -	kfree(bo->metadata);
> -	bo->metadata_flags = flags;
> -	bo->metadata = buffer;
> -	bo->metadata_size = metadata_size;
> +	kfree(ubo->metadata);
> +	ubo->metadata_flags = flags;
> +	ubo->metadata = buffer;
> +	ubo->metadata_size = metadata_size;
>
>   	return 0;
>   }
> @@ -1247,21 +1266,29 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>   			   size_t buffer_size, uint32_t *metadata_size,
>   			   uint64_t *flags)
>   {
> +	struct amdgpu_bo_user *ubo;
> +
>   	if (!buffer && !metadata_size)
>   		return -EINVAL;
>
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not get metadata for a non-amdgpu_bo_user type BO\n");
> +		return -EINVAL;
> +	}
> +
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
>   	if (buffer) {
> -		if (buffer_size < bo->metadata_size)
> +		if (buffer_size < ubo->metadata_size)
>   			return -EINVAL;
>
> -		if (bo->metadata_size)
> -			memcpy(buffer, bo->metadata, bo->metadata_size);
> +		if (ubo->metadata_size)
> +			memcpy(buffer, ubo->metadata, ubo->metadata_size);
>   	}
>
>   	if (metadata_size)
> -		*metadata_size = bo->metadata_size;
> +		*metadata_size = ubo->metadata_size;
>   	if (flags)
> -		*flags = bo->metadata_flags;
> +		*flags = ubo->metadata_flags;
>
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index fd30221266c8..a733b6323c0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -92,10 +92,6 @@ struct amdgpu_bo {
>   	struct ttm_buffer_object	tbo;
>   	struct ttm_bo_kmap_obj		kmap;
>   	u64				flags;
> -	u64				tiling_flags;
> -	u64				metadata_flags;
> -	void				*metadata;
> -	u32				metadata_size;
>   	unsigned			prime_shared_count;
>   	/* per VM structure for page tables and with virtual addresses */
>   	struct amdgpu_vm_bo_base	*vm_bo;
> --
> 2.30.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
