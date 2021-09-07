Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB362C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 12:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767C960F92
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 12:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 767C960F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDF089D99;
	Tue,  7 Sep 2021 12:37:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC8489D99
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 12:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta6y7fuV4yQO2Cd0PpgZETtNpfqgSWWsrsSWxgNxIZjOLulXtYqUMCzhZZaF/5CUR4Vnvb0rHWnOYYiwfa4wVbbKGJkVJDOMz/CQgKrrhVfBL7avZEiYtCtYyeHo8QhS5gT204ILSF/TrvhV75C5jza6EuMfjJ7JHa9iChrK8qHknfgcfvYHEqi5JhTBw5VYFhyG8WA96KiSWiFTw89D7oFLDOWgWMmpU3XOs5MHHutU0NXqSiZzFWhCCOSJTSLj5CJoiZ2q1yFjDJKl0pjtMx7imk9u2NF+3wr5HRmX5bo7Jl44+NtmENBncBuSGgSXPurHSn9QVKQR/pYpDsyovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Y0UwqMlCESC5QFzS5DO//Wbiq3RCG2TIYNRMEWyfmIo=;
 b=eYQ9rhcUL2ePj5lBsjOuXqVAzK2HZit/mFuU9h9uNVTAE9VD1XDnLvt6tvi7WlYzgjNxHJDc4TYlNggTz+54t+mccDEgzv/ZHy0NQ0IQsWsTwjmCqdCpGpgsiW6Emj/+RDfE2g0iJNFC97S2KgGmjP8fgGgimfZRMuWzMLELovSfWxVY8BdVxN40RpGWuXLcWHB960CglKuEBCOcttHAMcjk6UbbH20BacY/6vx9dxkOAum6frKvITGus0+d4zwCfseQQMmsD/sAhnZTxacjj2AyaTCp4ZCBYOLIGssdQJOooGi3N5U/h2VEJBf/DURh1ATgw7NTM+ErkxKzg1PaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0UwqMlCESC5QFzS5DO//Wbiq3RCG2TIYNRMEWyfmIo=;
 b=BXWuD5kGHuRSqrvHbpm4zYsHxpjf+I/EGLMbpESGZjreBgLx6uxv8ZzxdckmOoMg+k84iBNs7GldeSMlR0DcvzeMh6JSU70vOsaJzOv0QzpPbd+2+IRNS1bpoMPjns/sFRatgDV1yRYvlmmCaQ2cP38WBJ1X0c40l3J0zU1OiMc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 12:37:43 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 12:37:43 +0000
Subject: Re: [RFC PATCH v3] drm/amdgpu: alloc uvd msg from IB pool
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20210907122617.5303-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <da7895bf-f2d9-e35c-3f93-e4e48f364511@amd.com>
Date: Tue, 7 Sep 2021 14:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907122617.5303-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR01CA0073.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 7 Sep 2021 12:37:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e59a0242-c159-461f-b5a0-08d971fc48de
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157A9C84A1B860EAFE5E48883D39@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9kHu5xw+dlfc3CVCwJ/I2OQ/fAZsLWJ3wfxnT1RLFXkOcgbAD4/NBVCHfZ+35WkKYzMrclK7xhg7G4oIiNy6ZejvfDLxDof5CHBXNB4uizKczzC34Kr4LaoOWaWrafYrRBYZVd4S6GmiLv8CV41Elw23iMTAqF3CdziAWSIlM57nh5bbGy8Kfq81PhoZtz1UgOi/ZHw0A/Vkw9dF7OZ4Ud6YpIvZt8xUlyDQC3gGaGFgR0BJ2DTIiKzEDOk1hpSuEW3bROk0YtnwKrB8XBkG4ZbMQnPgSPwqdTVzgRWumtvpUQJQU+shgzts4kpmq1BBrM353DlNoXSpiRPgeTiYQYNhJVFTviUm8x+L0kFNiyFmEMIHKHkdpywLAlepD/mgemTHscZGcVztv0lB8qeYfbdD3Eo54OjaGQtwNzb2UF+OaPHjZ98gqDce9LIwo9BA+orpVZJLpt62Qw3YgqI5FqQRXFXB8Bx4HFfU2W09U//zrDQS3snEMa6AQHFa3BDKCzxVdAN7aEdJSGKYo3B4QbJZQiFI4nILswodJe0GI7US1mhuTEcL7WHdjdg+RUwfZsNZsaFTp/VkW9b1/JPqqmEFycgNwMN4MrRuoUBGomVItb2dAGndc77k8HsW0GIG29KgYKdOAn9gBjP6LzAxwICNtsz6/4tOn3URTM0RZYQC3QW8/MREs9+0+Fpm3vBrQ3enRR2wnOBZi8JwUCnRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(956004)(6486002)(38100700002)(31686004)(316002)(31696002)(2616005)(508600001)(6666004)(86362001)(8936002)(83380400001)(66476007)(66556008)(66946007)(2906002)(26005)(36756003)(4326008)(8676002)(16576012)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUR6T3FNSTgrN0Rra01JZTVCTDJCeUtac2xKQ2lQYmxwTUovalZUVVNQcTBQ?=
 =?utf-8?B?a0c5b3lTbUMwWjdra0NyWFR4dWZNVGszMWpjTkZqMVlwMmhMN0lnZTNnazdh?=
 =?utf-8?B?YmozdDJjTjlDM29BYkwrT1A4SU54T1NBS0dXeC9UMWJ3MjhLRVdyRHRjdkpj?=
 =?utf-8?B?K1ViZGEzUW5LVEsvc3MxVUV3UGlrYzRaWEJqSnh6ejZVWjdOV2N5QWxFekFn?=
 =?utf-8?B?SktnZEdUd0QyRjVVVHB6Uk5hTkphWEJkdW9seW0zbDR6U0pyWnM0b1lwN0Vv?=
 =?utf-8?B?bUI0TWNYNnlFOWZRTExWd0poNGVuUFg5a21BMkJlamNzSEJuV1lHcHlPT3lO?=
 =?utf-8?B?ak84UDZvU202U3JsZVFtZTFKL1JQekNBaHFNeklzaUFCU3ZKMG9DZXdRVUgz?=
 =?utf-8?B?OUpBd3ZhNnBxczJnZmdPa1VWYXZXWU1JT25Bc0pFUjQrcGg4NjNhWVdjQlZ6?=
 =?utf-8?B?SlM3dSthTkx3RUMvV2hiVUJtUzBwWkRZWVNXK2xRYTFBZ0RQNjlndDBGaTR1?=
 =?utf-8?B?RmJDZzhvTWI5QnRZUlQxTHEvR1BXWUtub0NLTVNTZmpETENzNmZ5a0YwUlJO?=
 =?utf-8?B?KzUxTjBZNVo3ZVRuc0UwN1d2SVlVdVRBNnV6eFAxb056Uktvd1lHOTNCdnJi?=
 =?utf-8?B?UFRIemhhdHIxb0FXQkZIVDlZYWFOdE5EQndjQllEYnYwQURncEYrK1FwMjVJ?=
 =?utf-8?B?QWZ6b0VaN2NaQ2x5RXFMbWUraWdZRSs2TU0wMmNrNG9VTkRmUUJrQXUvTjBM?=
 =?utf-8?B?V29aSUl3OGhZUXhYVlRrcmpXaHAyZ2RSNW8za1FKZmt1UFdwb3dTdHBWWFFU?=
 =?utf-8?B?UHFDb3czaGZORXVEWXd0c2tZcXlwQ3g5OVVORWFmZzc2em5iUHpXMm82SC9T?=
 =?utf-8?B?ay81TmZlVWtReDlZY0V4VjNJdW9NMGZrTnl5cHJyM3BkRmdiQ2dRTnlKejlr?=
 =?utf-8?B?OVdwdlRIQ3BXMTl3c0JyZzR6SWJtRjhoTVgyZnU0SjFlc2lsaUltQWxNazdK?=
 =?utf-8?B?S1pHRDdBa0xyMjNPRXc4UUpVSEV3dUQ5ZWJYUG1XNlVUUHRSVEEvSWxUTi9B?=
 =?utf-8?B?WjFqSHc4MmdVeG9QVjVUcWxWN1EwQ0hXNXNrY2NpKy9GRGRJTG4vZWhVRDVY?=
 =?utf-8?B?RHNzTXgrQ0J6SzhGc0NXd1NZMS9kZ28rcEhZZDRIamNnNnkzdUtRR0pZWmtQ?=
 =?utf-8?B?OW5qQkxYbDdTSmxXVGZzS0JSSmlHTSt1Q0NvYXlnVXRzZEtxYUdTS1NKMEdx?=
 =?utf-8?B?bmxhWERLYVlMd0tidlRhOVltM0dPOE85UmUvdC9wYktxdkxmODBJczVFcktN?=
 =?utf-8?B?N3ZsQjJxcXJpL2lyUWFHcXhiZGswTVVKTGVzV0VkNlhGLzkxY0JYNmNGNzRV?=
 =?utf-8?B?eVRQdkUxZkxYS1Y2T0R1T0N6amxqdDJnWmxvUm84ZGRRV2VBVDAxZXpZbmFL?=
 =?utf-8?B?YUxhWUt2a3ZadjVDMTgvd1ZyUyt1VXJkNUdKR0NCQ2xiMG9SQzFKaFNuc25v?=
 =?utf-8?B?UEpjQmhLc0hpMjBvM2tQZ0g2aWVEU2x5MFJ1UjBvQlZ2c1hmWElBQ1kwcU5E?=
 =?utf-8?B?QmZnUURuMm1XWGo0dnhTNnpsSmxqWkpkVWV6QlBFTWdRcmZlSEI3MlBzb1JD?=
 =?utf-8?B?WDFvd2ExZTdGd21hZmJnK2xGdmhIOGg3dHRpNHZrZXF1ZHRpK0U1UFBZaHdQ?=
 =?utf-8?B?MUIwWU5aQWZvUXQyb05KNzFwK3RrZkhad1dkMGk4N3VpZVd0Z040VEZRS3Br?=
 =?utf-8?Q?C2P2fyDFzTMVyy//UT9AksGNByrYtygVgd2bobI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59a0242-c159-461f-b5a0-08d971fc48de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 12:37:42.9421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZzT1y0HarHwiEP87Zqo/l/OS5MfUrp4dFVbFGC5BxH4Itke53sQBFjgrWavYHyE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

Am 07.09.21 um 14:26 schrieb xinhui pan:
> There is one dedicated IB pool for IB test. So lets use it for uvd msg
> too.
>
> For some older HW, use one reserved BO at specific range.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 173 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   2 +
>   2 files changed, 112 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d451c359606a..b741ab7b2468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -299,8 +299,35 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   	}
>   
>   	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
> -	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
> +	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>   		adev->uvd.address_64_bit = true;
> +	} else {
> +		struct amdgpu_bo *bo = NULL;
> +
> +		r = amdgpu_bo_create_reserved(adev, PAGE_SIZE, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_VRAM,
> +				&bo, NULL, &adev->uvd.ib_bo_cpu_addr);
> +		if (r)
> +			return r;
> +		amdgpu_bo_kunmap(bo);
> +		amdgpu_bo_unpin(bo);
> +		r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
> +				0, 256 << 20);
> +		if (r) {
> +			amdgpu_bo_unreserve(bo);
> +			amdgpu_bo_unref(&bo);
> +			return r;
> +		}
> +		r = amdgpu_bo_kmap(bo, &adev->uvd.ib_bo_cpu_addr);
> +		if (r) {
> +			amdgpu_bo_unpin(bo);
> +			amdgpu_bo_unreserve(bo);
> +			amdgpu_bo_unref(&bo);
> +			return r;
> +		}
> +		adev->uvd.ib_bo = bo;
> +		amdgpu_bo_unreserve(bo);

Can we have the same handling for both cases please? E.g. always 
allocate a single BO in SW init and place it appropriately.

And I think we need some kind of lock to prevent concurrent use of the BO.

Christian.

> +	}
>   
>   	switch (adev->asic_type) {
>   	case CHIP_TONGA:
> @@ -342,6 +369,8 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>   			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>   	}
> +	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL,
> +			(void **)&adev->uvd.ib_bo_cpu_addr);
>   	release_firmware(adev->uvd.fw);
>   
>   	return 0;
> @@ -1066,7 +1095,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
>   	return 0;
>   }
>   
> -static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
> +static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, uint64_t addr,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> @@ -1074,29 +1103,15 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	uint32_t data[4];
> -	uint64_t addr;
>   	long r;
>   	int i;
>   	unsigned offset_idx = 0;
>   	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>   
> -	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unpin(bo);
> -
> -	if (!ring->adev->uvd.address_64_bit) {
> -		struct ttm_operation_ctx ctx = { true, false };
> -
> -		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> -		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (r)
> -			goto err;
> -	}
> -
>   	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>   				     AMDGPU_IB_POOL_DELAYED, &job);
>   	if (r)
> -		goto err;
> +		return r;
>   
>   	if (adev->asic_type >= CHIP_VEGA10) {
>   		offset_idx = 1 + ring->me;
> @@ -1110,7 +1125,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
>   	ib->ptr[0] = data[0];
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = data[1];
> @@ -1123,33 +1137,13 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	}
>   	ib->length_dw = 16;
>   
> -	if (direct) {
> -		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
> -					  msecs_to_jiffies(10));
> -		if (r == 0)
> -			r = -ETIMEDOUT;
> -		if (r < 0)
> -			goto err_free;
> -
> +	if (direct)
>   		r = amdgpu_job_submit_direct(job, ring, &f);
> -		if (r)
> -			goto err_free;
> -	} else {
> -		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> -		if (r)
> -			goto err_free;
> -
> +	else
>   		r = amdgpu_job_submit(job, &adev->uvd.entity,
> -				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
> -		if (r)
> -			goto err_free;
> -	}
> -
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +				AMDGPU_FENCE_OWNER_UNDEFINED, &f);
> +	if (r)
> +		goto err_free;
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -1159,10 +1153,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   
>   err_free:
>   	amdgpu_job_free(job);
> -
> -err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   
> @@ -1173,16 +1163,31 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			      struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;
> +	struct dma_fence *f = NULL;
> +	struct amdgpu_ib ib;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> -	if (r)
> -		return r;
> -
> +	if (bo) {
> +		r = amdgpu_bo_reserve(bo, true);
> +		if (r)
> +			return r;
> +		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
> +				msecs_to_jiffies(10));
> +		if (r == 0)
> +			r = -ETIMEDOUT;
> +		if (r < 0)
> +			goto err;
> +		ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
> +		msg = adev->uvd.ib_bo_cpu_addr;
> +	} else {
> +		memset(&msg, 0, sizeof(msg));
> +		r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +				AMDGPU_IB_POOL_DIRECT,
> +				&ib);
> +		msg = ib.ptr;
> +	}
>   	/* stitch together an UVD create msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000000);
> @@ -1198,23 +1203,52 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 11; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, true, fence);
> +	r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
> +	if (r)
> +		goto err;
> +	if (bo)
> +		amdgpu_bo_fence(bo, f, false);
> +	else
> +		amdgpu_ib_free(adev, &ib, f);
> +	if (fence)
> +		*fence = dma_fence_get(f);
> +	dma_fence_put(f);
> +err:
> +	if (bo)
> +		amdgpu_bo_unreserve(bo);
> +	return r;
>   }
>   
>   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;
> +	struct dma_fence *f = NULL;
> +	struct amdgpu_ib ib;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> -	if (r)
> -		return r;
> -
> +	if (bo) {
> +		r = amdgpu_bo_reserve(bo, true);
> +		if (r)
> +			return r;
> +		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
> +				msecs_to_jiffies(10));
> +		if (r == 0)
> +			r = -ETIMEDOUT;
> +		if (r < 0)
> +			goto err;
> +		ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
> +		msg = adev->uvd.ib_bo_cpu_addr;
> +	} else {
> +		memset(&msg, 0, sizeof(msg));
> +		r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +				direct ?
> +				AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
> +				&ib);
> +		msg = ib.ptr;
> +	}
>   	/* stitch together an UVD destroy msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000002);
> @@ -1223,7 +1257,20 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 4; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +	r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
> +	if (r)
> +		goto err;
> +	if (bo)
> +		amdgpu_bo_fence(bo, f, false);
> +	else
> +		amdgpu_ib_free(adev, &ib, f);
> +	if (fence)
> +		*fence = dma_fence_get(f);
> +	dma_fence_put(f);
> +err:
> +	if (bo)
> +		amdgpu_bo_unreserve(bo);
> +	return r;
>   }
>   
>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> index edbb8194ee81..3ff49daf558c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> @@ -68,6 +68,8 @@ struct amdgpu_uvd {
>   	/* store image width to adjust nb memory state */
>   	unsigned		decode_image_width;
>   	uint32_t                keyselect;
> +	struct amdgpu_bo	*ib_bo;
> +	void			*ib_bo_cpu_addr;
>   };
>   
>   int amdgpu_uvd_sw_init(struct amdgpu_device *adev);

