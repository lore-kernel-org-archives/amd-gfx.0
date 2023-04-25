Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F4AC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B342010E076;
	Tue, 25 Apr 2023 12:30:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6099E10E076
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxUhxXgZI1LJGktoLUHFgtRGdJtgxr+KQch2YpU2Us8LxcJr+2RBkZccdn7rmE1BTtRG3Y00MU+skNq6IoF0ujcEzGxHj3fTymdNseW3muEmkYVMZg4rUIlaTFdMv6kNa52xboXbIKF5HFWHvzGOrhD+kOKO7CXtnArf3n2QXnQ3sIj0tVLj08Iei3at8BZCiqPAxbKpvu8P7i+N5iAaLjPquX7OPRDnAyuxjIpHH269fygzV0Qvhbg6YmQ8Ayd/aC+FGM3tbpeHNOBbyAhVhGnTXzJKmfZSz+yilQ0z7/Lx8VAIjWWz9CMIqEk4IWUnPuZZ33FrxYhPzp+7Hywz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOJFzvwBC8yHRe1mt9KSGeyktxD7xhmBCVJa4K1yONA=;
 b=NP/OmC4M9w2g9ja2TnotjE/Pu/VKwqOaXh4LFAqfawrr5GKLKVKXw1YIxhFrXlwk62O6HSjucm1soHaKCWAOBH+WOwbj6wi0NrAxeLoCqfHs1I1Y8irpNUV0VADIj7BwIGVEv0duuOenAChnzSgTg+4vNKCFHVxsEyq8DGfIUz+Id+kyIHcQZFXLV9SdnBXi2gw1oeEio71dxue7CrnSAsQK0J0GxwCZApsqvBn2UeRxA4cb7KyY+r6oBCc3/7zp4+0YYf5ymMCJqwVYahlrgzIC4cex4sJRhVbwPrBDM++rK+3DR2l2k1lvv9uJG3/s58B98bqXT75+DNPovaFoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOJFzvwBC8yHRe1mt9KSGeyktxD7xhmBCVJa4K1yONA=;
 b=CKDN6NL7o3kwJQVrbU7eHE7OoOQ5SU9G8y+pj+8THihilDJ0PKFpOQe9WqRRneWvNu0QX37GOXXQ6rs4ge5y/jZjkoxOqmFpqajPgZq//W2N6HsOTczdxUQ2eSRwnU/1ncHZW6HLnTLytL7UhAKlixDt2Ue6QrPTixvxI+fucyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:30:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:30:16 +0000
Message-ID: <28c8fae1-0cd7-2b7c-35ae-520633ce874e@amd.com>
Date: Tue, 25 Apr 2023 14:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 05/10] drm/amdgpu: create context space for usermode
 queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-6-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e21099-169f-4f66-05f8-08db4588d32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltlS7cupnYI2TlRa6P1gSfWaLviov3rwwctHmGv+LFyLuBKGfVG6zv8DY7wMo3R1qVp/SHLbODoDNV7TeepliPzRpWYfAC0nu6JIcQ/ZlvaB4uqKelUBx4DCp1OpuXW1cTO6p2Q+Gq/CIeasIS09w4wpzFMeqvTlIzoHf6peXiUBgGPRALSh+6VXhcW7MbjKy9MbW+0wkgFWvaDrXJGOzSD4ijmPOJfTBCTf0qtZcBPrQCta8vxPjDXpwBoK+mpFbuBGlQEVAqx62G9DMJgoLcUKr+gTghmG3AlwBqSRb0Fuq2n+9PJpFtueHIFo1jHaS0LUdgdAC99hVzzHd+ZUfc8y9XLHj+MX8/SO7jXuPrz191i6f7xiZni4ChCMvlheudY8mAmedKw84sYHJBgA+vbOwI4lhiHutiaVSoGe00QBytyLodFpG9rzngR+1QHDMIem+z07J7ApwvwMQYkN+ZLWlhPMiZ6lKHb7md/gUgTScKNrFFhubT4LBRu8jq2xn1qeOBj5/pUN3HYQ8l6gPP5eODNKUh+meCm+26+LuRBl3sBg7qwySaOdksNQY5rLuNTr+xHWN7K9xkbUsTn92+1a/hMKstIucMDFw74GbrhKnn69dIP/XJTxldWE1iqFulSD1VyYnc6Ycu5qnZQNkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(36756003)(478600001)(4326008)(316002)(66476007)(66556008)(66946007)(41300700001)(2906002)(8936002)(8676002)(5660300002)(38100700002)(2616005)(31686004)(6512007)(6506007)(86362001)(186003)(31696002)(6666004)(83380400001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3V2cE9saTRKcFg4eDVkdi9ENjRFdzRTZUluQjU2dnZhRlVOd2Q4RTVZYnRm?=
 =?utf-8?B?QU4xU1FkSWIxQk1zSVVVb1hNSXFuQ3cwend5VndkUEcxZmtXWHlSdStXQTkv?=
 =?utf-8?B?cHYzc3M2dnR2VUhIZmh3NVFPb2dtejZ2cWJSaXVIVkVPTXh1c3hTaEJVUlNz?=
 =?utf-8?B?elVIU1IvbE5YNUl3WkhZaDRCdTVxRnBjSWxPZUR3TGNlemRTVjlRb1E0Q3BC?=
 =?utf-8?B?UzNBVjRyTGw1MTVkaGQrZXcwcitYUnU4QXNZUzBhWVRKUTg1bkw5OVU1bE45?=
 =?utf-8?B?QnV5VG43c0JxZVdtcnczYlN4WmZiSVJldTdmc0Z0MkozaXRRSU0xTnBYOUNa?=
 =?utf-8?B?TXMrcTcrSEg3UDJYSkNJOFpmdm9PZVczQm4vMnB0UGNza21ObGVNVGNFMGJS?=
 =?utf-8?B?endpMEhCd0pRR1lGeVhYMXJ3L0FnVkdrcW1QUG9wRWpZeHhVMlBXZEVxZzJX?=
 =?utf-8?B?T0EwYkZaYTRwMUdxYWF4NllIU0w4cWZpbXVad2hyc2JPNHU1MFFjMHVOanlS?=
 =?utf-8?B?dTBEbmNvUU1XOUZFVmY3TW1xSkZnQkV1aTVCQmtsNVNWcHoxcU44QjAyUUtG?=
 =?utf-8?B?L1Jza0xYQlI0VVFIMS9XODB2M24zMzYwWnlKNW9nWmlPRFlvK0M2S2FFcmZk?=
 =?utf-8?B?QVFMUTVHZWJId0J0OUllZlBCamdWZ1g4bDFUNVRZemdpWDdBU2E4ZzZtRmdQ?=
 =?utf-8?B?TFEvcGFZMUdyWWpLQ0tENi91a1Njb2hERUViRWNtaGhOT3lwbVZUU1BJdk5T?=
 =?utf-8?B?WlZKajJGeG1UT1NhMVNIZ0tqdzZOZU1EWmtnaHo3alZUOHFkVDEvREk0WXJu?=
 =?utf-8?B?bUZhcUlTK3RkSGxPSkdtcUZ5TmU3akRGVFBZZHZxMjBqOG9helpOM29VSU4w?=
 =?utf-8?B?Mk12M1lsMHRYOVBLUVpOeWJPRU9teWZVdG1UOGtmWlJkV1VzVGxSV1hUbG4v?=
 =?utf-8?B?OU5Ga0lwOHZYR1dHM3Q4b2ZnZFJnSGVzSWcyN2lmV213dXROOWcrTTNqTUh1?=
 =?utf-8?B?RFEwSU4zU3JOT3IxMXJRbXVpODg2cU5yQzFEUlh5aDVURkM5dlpLMjk1T1BQ?=
 =?utf-8?B?QnVpNG9lUXViZ2tvVStJZ1RhU05MK2VvR0xFMkJic01JMDQreXl6UzY4cVdo?=
 =?utf-8?B?TmNvR04zQkVWeTVqTFdscExPTFdqVkRUT1o2bXdjUXU0YzI4KzJFS2xFR3Mw?=
 =?utf-8?B?UTNoaml3cGd2bXdCOUpVVFVtV0JhaGFoQWJpWEVMMGIyYWpzV1huZXlpbzJJ?=
 =?utf-8?B?dWo5czFuY1ViRmtCRlJtUjRLQ0JPbzdaN2YwWWNXVzYxanNkN1ZtK05ZRytq?=
 =?utf-8?B?Z0JlTVB0R3l1MFZncDhueFdPLzlMSElZK1NRQnJGNVBPWXJ3TUliMzRJdEhM?=
 =?utf-8?B?TlQ3elJra3kyZDNpdGRVMWRhcGJtbVFHeXRXMWJDbExFOGZNeEM5d2RRdE4w?=
 =?utf-8?B?R1pIeTRrTXIzUGcycUpzT3dIdXpkaFUwL3dDaTBBNEtIY3ZMemtyUEFJODMx?=
 =?utf-8?B?UC9GVXRWQ2lUSnVEWUZETlNoR3plMGRmZC9KQnc4NDQyc1p2NW9tdHJIODVy?=
 =?utf-8?B?VTE4a0NmWVpBZUJxZWVGU3JWOUlvRlUyL1hwY3d2dU8wTnR1M0xMdE4xRyty?=
 =?utf-8?B?ank5aHFFVzlNNStRT2laeGNrODBReTZVOVRVVkFwMUxJeXJHR1k4Y2t4Z09l?=
 =?utf-8?B?ai94WVUxVWJDcXdyaEpHUWphVXpKTENGMVJyeFFPYjc1QnNIN01PZWQ0QXpD?=
 =?utf-8?B?R0J4aURsYWtzMkF1cVFvTkVMaG1iVFd0UjI0a1EyNm0ybTBjVCsvZjdpUGRN?=
 =?utf-8?B?MHcvbmJIY0NMaE9JNTcwSDRTdUZ0NjNMTWRLVEF4L2d0bVJDMnIrclhrYVVN?=
 =?utf-8?B?cXdnVmtBSWdNUDZ1ckYybnNBb0JaUVo2cWVJMXhtVlZ1WUhyZGZhNDd4WlU5?=
 =?utf-8?B?ZFdzUzVhT1hSVk1rSjZnT0tkLzZHOXdaRWlzWDBjSnRHYUVDZnhFYXMybnZL?=
 =?utf-8?B?d1pFNlZUZk5UTmZGNkZwckNqeWxaeG84a096ZUMyL0VZbGM4cVZPeU1CelhC?=
 =?utf-8?B?Y0dTbW0xcWszbjgrTFBIMkN0dG9xZnBRV0ZnYktaMFkwaVkySmF4UDBZeFNz?=
 =?utf-8?B?aXBRYjF1MWdqN0dHdlNhTWNuaGk0VmkwWXRmNWtrRFRNTDZjMWZibnZxWWNa?=
 =?utf-8?Q?xdeZcwEmx/GwE36cFu/GvL5Gy2Kl+MINTyIjWP/yuyl4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e21099-169f-4f66-05f8-08db4588d32b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:30:16.5627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6CDEU/ogmN3tDgSlDvrMdc02wFgjX09r3KKh6zBiQ6gqKCOo+QZruldTJmQhfl8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> The FW expects us to allocate at least one page as context
> space to process gang, process, GDS and FW  related work.
> This patch creates a joint object for the same, and calculates
> GPU space offsets for each of these spaces.
>
> V1: Addressed review comments on RFC patch:
>      Alex: Make this function IP specific
>
> V2: Addressed review comments from Christian
>      - Allocate only one object for total FW space, and calculate
>        offsets for each of these objects.
>
> V3: Integration with doorbell manager
> V4: Review comments:
>      - Remove shadow from FW space list from cover letter (Alex)
>      - Alignment of macro (Luben)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 ++++++++++++++++++-
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  6 ++
>   2 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 9f7b14966ac8..f6b33faea86f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -53,6 +53,11 @@
>   #define GFX11_NUM_GFX_RINGS		1
>   #define GFX11_MEC_HPD_SIZE	2048
>   
> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
> +#define AMDGPU_USERQ_GDS_CTX_SZ    PAGE_SIZE
> +
>   #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
>   #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
>   
> @@ -6406,6 +6411,44 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
>   
> +static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +					  struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
> +	int r, size;
> +
> +	/*
> +	 * The FW expects at least one page space allocated for
> +	 * process ctx, gang ctx, gds ctx, fw ctx each.
> +	 */
> +	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
> +	       AMDGPU_USERQ_GANG_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
> +	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &ctx->obj,
> +				    &ctx->gpu_addr,
> +				    &ctx->cpu_ptr);

Wasn't this stuff provided by userspace now?

Christian.

> +	if (r) {
> +		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
> +		return r;
> +	}
> +
> +	queue->proc_ctx_gpu_addr = ctx->gpu_addr;
> +	queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
> +	queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW_CTX_SZ;
> +	return 0;
> +}
> +
> +static void gfx_v11_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +					    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
> +
> +	amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
> +}
> +
>   static int
>   gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>   {
> @@ -6426,10 +6469,16 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>   	}
>   
>   	memset(mqd->cpu_ptr, 0, size);
> +	r = gfx_v11_userq_create_ctx_space(uq_mgr, queue);
> +	if (r) {
> +		DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
> +		goto free_mqd;
> +	}
> +
>   	r = amdgpu_bo_reserve(mqd->obj, false);
>   	if (unlikely(r != 0)) {
>   		DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> -		goto free_mqd;
> +		goto free_ctx;
>   	}
>   
>   	queue->userq_prop.use_doorbell = true;
> @@ -6438,12 +6487,15 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>   	amdgpu_bo_unreserve(mqd->obj);
>   	if (r) {
>   		DRM_ERROR("Failed to init MQD for queue\n");
> -		goto free_mqd;
> +		goto free_ctx;
>   	}
>   
>   	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>   	return 0;
>   
> +free_ctx:
> +	gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
> +
>   free_mqd:
>   	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>   	return r;
> @@ -6454,6 +6506,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>   {
>   	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>   
> +	gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>   	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index e7da27918bd2..11e8ad649f6e 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -38,11 +38,17 @@ struct amdgpu_usermode_queue {
>   	int			queue_id;
>   	int			queue_type;
>   	uint64_t		doorbell_handle;
> +	uint64_t		proc_ctx_gpu_addr;
> +	uint64_t		gang_ctx_gpu_addr;
> +	uint64_t		gds_ctx_gpu_addr;
> +	uint64_t		fw_ctx_gpu_addr;
> +	uint64_t		shadow_ctx_gpu_addr;
>   	uint64_t		flags;
>   	struct amdgpu_mqd_prop	userq_prop;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_userq_ctx_space mqd;
> +	struct amdgpu_userq_ctx_space fw_space;
>   };
>   
>   struct amdgpu_userq_funcs {

