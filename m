Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCDEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 09:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3522F60FBF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 09:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3522F60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE8289C97;
	Mon, 13 Sep 2021 09:03:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0FD89C97
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 09:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSi41dt+Q+VA6/ei4B4Y+N82tqycF/e4kansarEHwc2+e42ud2fg86hKaxgYck75esYq7qEEiJXfo/E9DkSO25oxgcFWDvo514F3DzWZjl+CrQJh6ZjA8876qC5O8nr+OrStIpc9lfLkllgLZLn9fH0y2Pjc8v71x0WUKOVMWUuFg0bV8ZRCJMdFCEOeeeH6sRchO+QvID4tKFxo32sF87H+konm0QPfytfYpf1nLLQlgUCmWdeCZYW7VTT7AWqMT1bkEkOv7dP9fmdzRQvoeLlt8+m0A7amv0fVAlLSn9bVh32TI16bJrysA4NImBpDvZbhkLZKmViFz7pDvymv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mXpjqs/LdtZFcHWIGuPzKJnhnTFMnqA943JcqWN5/jE=;
 b=Mozz1jSytQT2DDhOq+aCZPLe2f4uiLD6lo+3mFnYNHSf+D5MHnaHx3lVZA3eRUxf3Dwthll3/4YNh1VV0zzwBdeY/9x0lKdDzPsAQS02PbIzk1+Zh0Er+jarBs5r5ao7t0WlCpP0DMVMOOJHz3XPCUYAzhsKrQMbY48+gjOhIwwFtARIhj7O/QoHw1sZT7F/7fpLoyD34CVZbJNIMy2YUUFfXZquo05AacuQ4yBhehEXvrudnULnaPfBXWLsanu9YXmBxOYtuLh8gcxzaluo1p1lTXYmw9+jESCee5y+56xuepS05xVhOViUwzuikcbdlT8L9tcHaluVT0KO8DeFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXpjqs/LdtZFcHWIGuPzKJnhnTFMnqA943JcqWN5/jE=;
 b=ifNIAh+DS2nfJeO4b5wAQ4miyNPcCwIUu/v27n2Q57netHF3nl+zQEXd/mzKV0nc2gBn0oLrspyB/uFiz09TUM5WvcwjuHyRMCTsrtcLgBfx0QkjRPGadYlNl0c+K/nB2GBkPBrAcBkIHB2sQ2h1dW5bWSTF8WvYlQ3O/4WcSzA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3985.namprd12.prod.outlook.com (2603:10b6:a03:196::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 09:03:53 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::1d09:e72:91fd:ef05]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::1d09:e72:91fd:ef05%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 09:03:53 +0000
Subject: Re: [PATCH v4 2/3] drm/amdgpu: VCE avoid memory allocation during IB
 test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, James.Zhu@amd.com
References: <20210913084253.241955-1-xinhui.pan@amd.com>
 <20210913084253.241955-2-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b75f2a81-e922-1a24-7d32-900b6607b0bd@amd.com>
Date: Mon, 13 Sep 2021 11:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913084253.241955-2-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM8P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 09:03:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c5b2d0-e864-4f8e-a206-08d976956890
X-MS-TrafficTypeDiagnostic: BY5PR12MB3985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB398540C680FFCC66F689B45683D99@BY5PR12MB3985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5UJABN3aQAcyblDuqfobyrG7651WtGftCmfEbmeNTXJ7pH9lWdmy30jqQT+JntUdampdzwQkqcC7BF5x9/4uW6ZCM1xD+G0WHefQLLjxl86OY2TMIfE5VG0M9hugy7XCK73Rd68OUk2WmLQeQn88Havdh1ncmeBDi9/sSpCpTrVgfWsI5c6bCZphqFiJ3u6gppc9+RN0gQAtkeSp7hIxGjlataHAeeeP9asaKRFi/4AoB1bMK6i5eyrQZ7M82GgxYch7TXx0WZW5a+5cQKa2GOWbtXWf21gSsP55o+o9LVUpfqa8Wp5pr8FAzh1pvXurdU+prhnJbUVhiP8bMKPXLiMcddCvJBWSZONSosUUBBvo4vAka6UVN7hXcFBu/l7xyV5qP7Fl0o3NXcDGWqv+/cRwHBkQIkXK11O7mMEw+7t2muPceRzRM5O7xHGge9S55wRvo7ty/5tKdNhspUilZA+ahMguIsHmPbA25kxc8mJiROXzw8Gf9nu5sZtia2bVzFLA6KUkSxC/mosMyvHchYEXBijgDKpNvTV09JfhUd9lMhNLblcngLl5lG7FHnV3pr2tuXVeaccT9qGBVzxDv/QHCH0YGhXPIfHlht2a5FfIlmTmtSqYv2fo6AMpmi2Vpj81zd4VFTomnFTP4zwT3E3ZPNuFc+mM7nzXaaPAGPTQkPYWV4BOdZBp4WkHeT40xyDgQBJnPbOvTEgngBJlTJKNCACuhswQpDoQhZfmbBPpEJW+eIFwRC8h/7QTSlQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(86362001)(8936002)(6486002)(508600001)(8676002)(186003)(2906002)(66946007)(2616005)(16576012)(38100700002)(26005)(36756003)(956004)(6666004)(66574015)(5660300002)(66556008)(31696002)(31686004)(66476007)(316002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1CZFl1aHdYcjdNc1F2MlpndzRpMWNoZVkxTE5OMGwyZmg2QWFHRnhWUTh3?=
 =?utf-8?B?dU5vM2ZXYnJDeWZPVWYxbms4bnhGTkh6RWo1aTZzdkFSbjVFTENPVStBT0Fx?=
 =?utf-8?B?OHFXRjN0T0g5eWtPVFVXcmxXWjJKanc3V3pyYjE2dS9yakRKZUFUVjZhKzBN?=
 =?utf-8?B?SDVndndHR05lc0wzRjBtM2tIYzRNZTlXenNSWkp3N1BMcGVYOUpNaGdRT3pZ?=
 =?utf-8?B?WXpORzhRYmNxNG9CWElZd0dacko4aDZxc1JJWGs4elc1SS9DaThtLzNta1Bt?=
 =?utf-8?B?enZuVWlKMEtHL0JpMlo0VzhZT2pqWHloVmYwTlZwM24yUDIwT2dUNjNRck8v?=
 =?utf-8?B?Mnpadk53LzRwUHVGcHZHOFBVN2lsUlY3L3NVRzBPbXY5WHQwd1daZnlrTldS?=
 =?utf-8?B?ZXJwQjUxTjM5VUZmZXlLYVJuNjAvY2dnZ2hGVFNrbUpVdVl6ZjZrMFZMNkxT?=
 =?utf-8?B?c3FmQitHN0VSYmcrU1dBSFJjQTIzdk1KRGhvSWV1UVJLd3cyOUlTdDMzK0NT?=
 =?utf-8?B?UjNCY09vN0RJR04velpUb1Uwb0NqbVRjN0NiVWlaRTNHbG14cXhUUHBTdjVp?=
 =?utf-8?B?ekMrdkxoVlNhelptclJwd2Y4UmU4OG80V1RBU1ppeVRhRjVTdUZsdjRlK2hs?=
 =?utf-8?B?eVV5TU93bkpTckdlWXpkZHNONG9LbW03T3BRMXI3K0tPZzcveHNEWVZEOTY1?=
 =?utf-8?B?a1dyMzl2QlJSTnczRXhzVVdpMHkvMlRDenBUYUVodTc4cXB6aXY4SklkQUFC?=
 =?utf-8?B?ejd1RUI2d2hpa0RJZ3BicXRJMVc4TjNEeWE4eWExTDV5V3EydzNaNys3bnVl?=
 =?utf-8?B?TmZrcFpmWlFnSVgzcmpKWHBqUUtwemxuc3pCcERzY0lPc0doMzJqTU4zSEJz?=
 =?utf-8?B?cEJOTEk2ZEJUNC9sb01TRmZCZk9iKzNEU1ZSejBpajBmV01RdkhETTZUdEZy?=
 =?utf-8?B?TDgxbFpPVER4RVZrWVVkWU9hbWdmd2REeldnOFZwbENWdjVqNVdXbXlwbHc3?=
 =?utf-8?B?TE9TaEFOS2RSZ081YkVFTEFvazNZNERIZGtEOGZOUWdNU0VPb3RZeFhhU3FS?=
 =?utf-8?B?eXpDYUZGOC9PaXkwQlVXK0JFQ2VtUlM5SVRaWlRUY1VwL1AzOUszY2U3NWxz?=
 =?utf-8?B?TVUyanZuVEV4TlJWZmdRYWxNbk9heFlaVTRIOWdWVlFadEFFM2pIVUhyRTdM?=
 =?utf-8?B?OU1YZ1dXdUh5RnZwUmZkNmk5aTRsZzFTNCt1MTFiRDRWaVBaZmVOVlFPT1Uw?=
 =?utf-8?B?QmFpNUNsSkp3RCtmVGVpR2sxajlzN1hoNStwZjlGNFZxYi9MQVhnZjg1SVBM?=
 =?utf-8?B?c3gzL1M1TFZoL1l4WHg2MnhUOUpiL2pTRFljdk5DaFFDMnRtQlJDdFhuOWVl?=
 =?utf-8?B?dWhKb0ZxTE9DankrY1dxNVdpZnVhdTExeEF6cjN1NnlVSkJhWGlnZVc3aXdL?=
 =?utf-8?B?YUhzU3lQSDVxM3dpZ3R2NGhqYWM2TXQ2N1hJVWpXWm91NUR0eVB4QkJsRmtJ?=
 =?utf-8?B?TWxDYkd1ZzYvKzJwV0VtUUJ0eEVsNHVpdWlyNkhSMzFmL3MrTnhWQU1pb1BF?=
 =?utf-8?B?M2NFa2JyRnFjWDM0MVJsTm1xcjgrUlA3VXUvUjFQa1pzcWJ2S2d2T3B0cUFT?=
 =?utf-8?B?RmE1R1JwOHFYa09NYzN1TVBVaG4rSmRERlAyWk14V3VtZXhEYlNJTHN5eUhx?=
 =?utf-8?B?VzNkMm1mOG85T0gyTTk5QlpENWVWUHVMS1ltWVJpU3lOZTBoN0dDQ2gzKzIr?=
 =?utf-8?Q?CWmIfpyGFywz/UuGrpVmF1p5Ns7BmEtGqABav5y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c5b2d0-e864-4f8e-a206-08d976956890
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 09:03:52.9677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYw4UEmftChmzytlZksON0DRj4+mftl0VPggRELanAF+kj+n31Hu26lZl0p70AEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3985
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

Am 13.09.21 um 10:42 schrieb xinhui pan:
> alloc extra msg from direct IB pool.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

It would be cleaner if Leo could confirm that 256 byte alignment would 
work as well.

But either way Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
> change from v1:
> msg is allocated separately.
> msg is aligned to gpu page boundary
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 27 ++++++++++++-------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index e9fdf49d69e8..caa4d3420e00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
>   
>   static void amdgpu_vce_idle_work_handler(struct work_struct *work);
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
>   				     struct dma_fence **fence);
>   static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   				      bool direct, struct dma_fence **fence);
> @@ -441,12 +440,12 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>    * Open up a stream for HW test
>    */
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
>   				     struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 1024;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> +	struct amdgpu_ib ib_msg;
>   	struct dma_fence *f = NULL;
>   	uint64_t addr;
>   	int i, r;
> @@ -456,9 +455,17 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	if (r)
>   		return r;
>   
> -	ib = &job->ibs[0];
> +	memset(&ib_msg, 0, sizeof(ib_msg));
> +	/* only one gpu page is needed, alloc +1 page to make addr aligned. */
> +	r = amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +			  AMDGPU_IB_POOL_DIRECT,
> +			  &ib_msg);
> +	if (r)
> +		goto err;
>   
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	ib = &job->ibs[0];
> +	/* let addr point to page boundary */
> +	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
>   
>   	/* stitch together an VCE create msg */
>   	ib->length_dw = 0;
> @@ -498,6 +505,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   		ib->ptr[i] = 0x0;
>   
>   	r = amdgpu_job_submit_direct(job, ring, &f);
> +	amdgpu_ib_free(ring->adev, &ib_msg, f);
>   	if (r)
>   		goto err;
>   
> @@ -1134,20 +1142,13 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>   int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
>   	long r;
>   
>   	/* skip vce ring1/2 ib test for now, since it's not reliable */
>   	if (ring != &ring->adev->vce.ring[0])
>   		return 0;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> -	if (r)
> -		return r;
> -
> -	r = amdgpu_vce_get_create_msg(ring, 1, bo, NULL);
> +	r = amdgpu_vce_get_create_msg(ring, 1, NULL);
>   	if (r)
>   		goto error;
>   
> @@ -1163,8 +1164,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
>   

