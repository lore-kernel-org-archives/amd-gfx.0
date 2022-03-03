Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D01C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 19:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3240B10E160;
	Thu,  3 Mar 2022 19:56:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43D210E160
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 19:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO0XdIAgmeKIltmLWJmcqdEOQDiGLR0CVuE1OzPmr4SZHdY5PScB2Ru3h5/PAnLORB8tqkbVX8kCfhHf7RhuJISbo5bhq4vdXEA7xoU6I88Iod0tXi5J7u78OT2lPKmixwCgx8pkJcWuL7+Ftja9gBsk0yrDv1/nx209e1SU6MM2CPoz+dL/l31KHi+MQZAbsVVmjPmV1V6LF/ZouKbC30Ejbduk+0U9M1LJd8UTeTQysEQmzgrmskzrV0Bad6aQGb4dJrQduv/ObtflTxJ6YYo/W7KpoQHwh/PTzweeg0jezZ3iIAql5bwlnS9SUG+DAsgWrJWrzoKAMoh3bmiV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah2GVqAE+YYoKSUlH9rDodbf8rP9qtLW2b03Pjadt8Y=;
 b=R8SnnCAvd+Lm5yAaxPa1eFA2Y58uc4Ama04+DZDMwlBJ8Y5TLhatEuhtKzvItTZ2oXIxpVi5RQXvrF3vW/PZT8jK4oU96Onc/MqnZR9PTmxNffMkNQSzgGbDelEsTkY5ZFjUbQJ8rtM+DyNixXSL9kpmCsgbQUrp/WfDLHCCV+fM2JUv5QmDtj2CGKaM5TceADwComadR2kxpNbNYZzensoaTpWd8hiYo+nZF8mhP8akldjCOZXBnqM8crcyl1SmSeknjq+E0uSp9+5UiI/y1tU+qlfocFl53vUlo75XCgwc5C3svAen/2uvLToM6e9mMr8Iu2U+PtJuP5XOl/J0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah2GVqAE+YYoKSUlH9rDodbf8rP9qtLW2b03Pjadt8Y=;
 b=xOvQhbwvHc5nKGl26NlGgqfdzSlizD0C2TXzu/mN7dBsEl2TbLH4DjP0bTkVKxWXTKq7lF6MmNW5f9pm2GFQDiLnCMuuAlGqEwZaRolLjA+QNESSSR65RGnkLMmeFTUWmSwB5FXsDqPamzxK2vihKUQEm45BHHJ3Vqid7tuj87g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 3 Mar
 2022 19:56:40 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 19:56:40 +0000
Message-ID: <a692c5e2-6555-ca93-89fb-290385c66976@amd.com>
Date: Thu, 3 Mar 2022 14:56:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/10] drm/amdgpu: header cleanup
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-3-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220303082308.38217-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::12) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a8075f6-354e-40c5-762f-08d9fd4feefa
X-MS-TrafficTypeDiagnostic: MW2PR12MB2442:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2442B6076DE03551CC094DC5EA049@MW2PR12MB2442.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klbIhhraCL5+0911f5vbK4esicTsb4RQUvYt7x4MbLpr6Q1xqbyuBbp7Yi5ONsUX4uGUa7oCMppb3brv5umihc7pMml+djMufww0W8VLNHh0CuXRusFMkpZZa937kHNm+bsSeKlOR9zh5vGXH2bjk4T1RfoIO6yxP3jxwCkNkkaUIeetSLQh4dEN0/zWWxUtX0jhj60f7oBIz9XJsIZibzXH1NkW/mlBIv0qzWwUt8mJLfOFdd2po8Xf6iqjSOIsKG5fi+B6dzcnZeu9Xo3Zec9IFUhJ2MkOFbudXlZ0hDTzoWu/TlvRIx2QzmuvVgNqD8jwFf1yrlIfCcfPGeRXB2DYQ9upUyoZSrp1ZgAI2Hcvs8Dc8bmce6hGCSIZ2mBjpJbZG5QhzyydrvoeznIZaPPckOYIGtgwg2A7ClrTcJPU8l3LQ8F5u46lS6dHbF0ZqmZCrkul0dVLr52VWZg0Y9azzCY9ImKDfffdIPu/56G5mPS44MtbASSUp7i+lG7iloULJdCfANs2OyfUO5g0a3rdoFFcwBuJSRudzXhhh/G6RpGh7XkUR8NGhN4+/27mgiFrBES+pE1fIZ4+7adSNwJQ5dGML2SsftVQfE/xNRjuGqsrP3Oa0BzvuWPPPp7lhiPlakx9w0f8tjfFkvC3RpujCT3BDek/77QoViBROupgLoLOfPS7+cnrG2YGS7mR0WE0oCohDkBF69OHg8hS/9d4H0+MLCWnUk3j+1SK5yNZVkPlfEFEHY2TyBcg5KmG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(4326008)(83380400001)(6486002)(31686004)(66476007)(66556008)(66946007)(31696002)(86362001)(8676002)(36756003)(53546011)(6506007)(8936002)(6636002)(44832011)(38100700002)(6512007)(316002)(5660300002)(66574015)(186003)(2906002)(30864003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRRN1phTmdPVGtZSXhySzJMVXlFTlI5QkhEM1orVzNLSWlmbGZXa09SeEJD?=
 =?utf-8?B?c3NBa0xUNWNmL29EcnNCYmdTMWFva1lzL3I2TlJNdVFxWGgybmZwUE9vOVVC?=
 =?utf-8?B?Y3ZYeW1HZ2thSExRNnlWc0w4Y1ZXckdBS0dkRzdsNlJWU2gxUGQvakNjZEx0?=
 =?utf-8?B?cTFINXpmQUhOdUwxOFB5Ylk4d1BlYWVuZzA0S21aeXIxVmR3Z29nK1Q0K1FE?=
 =?utf-8?B?Y1FqMjdVVmN5UGdyL1NzVml5bkJDd0JMOWJGWER3UWk4a25QREFTYVQ0UU1Y?=
 =?utf-8?B?RVVjMTJ4TkFvUFYxL3Y3TW5EUTRreUN2V3hnaUtvanJGS1dCZndlV2xxMndu?=
 =?utf-8?B?SjN6S3k4R2hWRFVBOHZiVllmWXV3U0lRdFgxVHlwbUFDb0xwWGZ1MW9vSUVu?=
 =?utf-8?B?WjliTENaczMzUG9GNVgrWEVOc3czbVVXY0NWVUpJWjNqM25xNXVYSS9ySHha?=
 =?utf-8?B?TWpSZnVJa1kybEVySC9UQmVsOXlWazMwc243cWdkVHJGQ3FaRkVQT2NmU3Mx?=
 =?utf-8?B?TFlLVDQ2cjA2OXlpRU54amtvbGNIZ09yRHFPQ2xwM1J1UHE3YzN5SU9KOHN0?=
 =?utf-8?B?bUJ3NXRhRnZvZWpWRzJUWkNRNkd2NG82TWs2OSs3TnVHaUlHaElLWEh1SGZz?=
 =?utf-8?B?aUZjZDlSZExhbzVMOTFrUDFlY3Z2VFA3QVYrR040U2Ercy9kWUJnb3RtbmtY?=
 =?utf-8?B?ZjFpdDR4dWZVcUh1ZjFJSGJTRjVnL1YzZEZ2eU9yVlpyQ2I0MklwUDhrWXd6?=
 =?utf-8?B?blhtMXo2d0l3K0RyYUh0a2pHUFZPblhybnB2TGpFUzdVR0hKVFVIZmpDdmdl?=
 =?utf-8?B?WExwNmozZElCWGg5ek94eWRvcVpTaTZqTUZEUkh5RHpjankyM2QwNk5mY2tJ?=
 =?utf-8?B?cVBEYkdmMDVHck1NQzQxSjJZbDMrajFxMkI1ZHR6TWRBMk95dFh3Uk5SVEE1?=
 =?utf-8?B?UFpPbzQ0eUtxQkducGQvaFR6bTREQVhIdVp6c3VKQVpTTkF4Wk8zWko0VElB?=
 =?utf-8?B?Q205T3BVLzg2VUF3WHJVeDJ2YmhPbUM2MjlUZmNiUmE5eFJ4SENaSkFreUxF?=
 =?utf-8?B?WHMxWlVIa0R6dklzdXh4bms3cko5QTAxc1UwVFk4TWFGbVZNbmlFMWN1R2Rw?=
 =?utf-8?B?M3FUYzRMZlMzU1F0YlkwOHh5enpXb2tFVDZVT1hXd0Fsb3haVEEvMDlGMlJN?=
 =?utf-8?B?RXBaNHBtam0wbWVKUEg1dG9DOHZGRVREZElTRTZCbWswSTJzeEVkQ3F1SWVY?=
 =?utf-8?B?MFdQWmVJbWQ4bmZoc2NmYU16MzZzRmpsZXBJTXRKbmpnLzF3MVR2Y3laVCtv?=
 =?utf-8?B?eDlxZUF5ZHFLUlVaUTYra3YrVjlkYmJyaklMSGwveUdZRzhSQlBCbmxqRzU2?=
 =?utf-8?B?SEhsQVJ0cEo5RDh1VlE4NUxJMmdGeHFldml6SERUa3RmclBuTG9YWUZaVnJ4?=
 =?utf-8?B?RGhHS0xDMm5nSlk4VFFoWTM3VmJBRlU1V3NiQjZjMjVSZmNkQnprQU5DNEZ2?=
 =?utf-8?B?K3cvbXVRL2hDQlZLK0FrdDliTEFHQzMwYnRrSldBWnJ3Lzg3ajQxNVF0d1Jq?=
 =?utf-8?B?NFpqSUM2V1VtK3YzcmlNMEFkWjRudElJV2Q4NzlpS0ZsQmhFOU9qMU44OVZl?=
 =?utf-8?B?dXhEZ2l2RmZ4dDdWdW9VK2lkMS85UnUvRkVqZi8zQnNTTUdsekpmUkFXOHpl?=
 =?utf-8?B?d0JobUk5TTBLWTR2eXdGM1Zjc012aVBUbGNPQ0w0SGxLbmNXeE4vK2N3eFpJ?=
 =?utf-8?B?cnYxa1Q1Mi9yOVpmNDRWTnlOSVBFcFFlZWEzR3FKVTVLSlQ2TlRrYUVNQkNx?=
 =?utf-8?B?TGE1QTdsMHdJRXVCaWtNbXNGdG1mQmJkWmw4ZDhXWkJyaVJuMlowNHNNOERO?=
 =?utf-8?B?bnd3aHFJQUx1ZUNIRXVpOTM1Qm5nd3BDNUtVVWl0dHlaTnlpOXJ0SXJ5bW9q?=
 =?utf-8?B?VEVIZU1QWG1vQmg0YTNSK1I0OXNjRzhoZGRzbnJvMXBUK0tGdWtEeFREazhE?=
 =?utf-8?B?Y1A1OCtRUmF5RnZ2L29qb0toby9LWnFpR1lxSDNxTm81RDAxZTBKZUdkRm0v?=
 =?utf-8?B?S0NSWUptVFFFaVhqVlUzSTlUSkZjakVOZ0hvU05TaE4rZFpTNHdQbmlybktK?=
 =?utf-8?B?QnpMWDdxMzhaejdscERwa2dOeC9XeG5iS2NjSTk2VXhENEdYN213V0RaTHFv?=
 =?utf-8?B?QWFQaWVCQzZrQmMyQlJOSFhNeVhHMUpFN1JTc0NIUURRK3BDMlhyaTdrQjhm?=
 =?utf-8?Q?cCFtKdVevXGri87HUSd+SbV9RUYulH22lg0SWuYe6o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8075f6-354e-40c5-762f-08d9fd4feefa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 19:56:40.4833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kudA/I+GB2nCm6XXoYeGUQMcSPwZJCD41N9g+pM6kBGE9Ldvj923npyf1zaJj+41LOn+6sjiDsuxLyfdZGWJxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-03-03 03:23, Christian König wrote:
> No function change, just move a bunch of definitions from amdgpu.h into
> separate header files.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 95 -------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h        | 93 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      | 35 ++++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_trace_points.c  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  1 +
>   10 files changed, 132 insertions(+), 100 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b89406b01694..7f447ed7a67f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -60,7 +60,6 @@
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drm_ioctl.h>
> -#include <drm/gpu_scheduler.h>
>   
>   #include <kgd_kfd_interface.h>
>   #include "dm_pp_interface.h"
> @@ -276,9 +275,6 @@ extern int amdgpu_num_kcq;
>   #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
>   
>   struct amdgpu_device;
> -struct amdgpu_ib;
> -struct amdgpu_cs_parser;
> -struct amdgpu_job;
>   struct amdgpu_irq_src;
>   struct amdgpu_fpriv;
>   struct amdgpu_bo_va_mapping;
> @@ -465,20 +461,6 @@ struct amdgpu_flip_work {
>   };
>   
>   
> -/*
> - * CP & rings.
> - */
> -
> -struct amdgpu_ib {
> -	struct amdgpu_sa_bo		*sa_bo;
> -	uint32_t			length_dw;
> -	uint64_t			gpu_addr;
> -	uint32_t			*ptr;
> -	uint32_t			flags;
> -};
> -
> -extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> -
>   /*
>    * file private structure
>    */
> @@ -494,79 +476,6 @@ struct amdgpu_fpriv {
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>   
> -int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		  unsigned size,
> -		  enum amdgpu_ib_pool_type pool,
> -		  struct amdgpu_ib *ib);
> -void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
> -		    struct dma_fence *f);
> -int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> -		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
> -		       struct dma_fence **f);
> -int amdgpu_ib_pool_init(struct amdgpu_device *adev);
> -void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> -int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> -
> -/*
> - * CS.
> - */
> -struct amdgpu_cs_chunk {
> -	uint32_t		chunk_id;
> -	uint32_t		length_dw;
> -	void			*kdata;
> -};
> -
> -struct amdgpu_cs_post_dep {
> -	struct drm_syncobj *syncobj;
> -	struct dma_fence_chain *chain;
> -	u64 point;
> -};
> -
> -struct amdgpu_cs_parser {
> -	struct amdgpu_device	*adev;
> -	struct drm_file		*filp;
> -	struct amdgpu_ctx	*ctx;
> -
> -	/* chunks */
> -	unsigned		nchunks;
> -	struct amdgpu_cs_chunk	*chunks;
> -
> -	/* scheduler job object */
> -	struct amdgpu_job	*job;
> -	struct drm_sched_entity	*entity;
> -
> -	/* buffer objects */
> -	struct ww_acquire_ctx		ticket;
> -	struct amdgpu_bo_list		*bo_list;
> -	struct amdgpu_mn		*mn;
> -	struct amdgpu_bo_list_entry	vm_pd;
> -	struct list_head		validated;
> -	struct dma_fence		*fence;
> -	uint64_t			bytes_moved_threshold;
> -	uint64_t			bytes_moved_vis_threshold;
> -	uint64_t			bytes_moved;
> -	uint64_t			bytes_moved_vis;
> -
> -	/* user fence */
> -	struct amdgpu_bo_list_entry	uf_entry;
> -
> -	unsigned			num_post_deps;
> -	struct amdgpu_cs_post_dep	*post_deps;
> -};
> -
> -static inline u32 amdgpu_get_ib_value(struct amdgpu_cs_parser *p,
> -				      uint32_t ib_idx, int idx)
> -{
> -	return p->job->ibs[ib_idx].ptr[idx];
> -}
> -
> -static inline void amdgpu_set_ib_value(struct amdgpu_cs_parser *p,
> -				       uint32_t ib_idx, int idx,
> -				       uint32_t value)
> -{
> -	p->job->ibs[ib_idx].ptr[idx] = value;
> -}
> -
>   /*
>    * Writeback
>    */
> @@ -1425,10 +1334,6 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
>   						 enum amdgpu_ss ss_state) { return 0; }
>   #endif
>   
> -int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
> -			   uint64_t addr, struct amdgpu_bo **bo,
> -			   struct amdgpu_bo_va_mapping **mapping);
> -
>   #if defined(CONFIG_DRM_AMD_DC)
>   int amdgpu_dm_display_resume(struct amdgpu_device *adev );
>   #else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index aff77a466f59..6b6a9d925994 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -32,6 +32,7 @@
>   
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_syncobj.h>
> +#include "amdgpu_cs.h"
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_gmc.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> new file mode 100644
> index 000000000000..92d07816743e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -0,0 +1,93 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __AMDGPU_CS_H__
> +#define __AMDGPU_CS_H__
> +
> +#include "amdgpu_job.h"
> +#include "amdgpu_bo_list.h"
> +#include "amdgpu_ring.h"
> +
> +struct amdgpu_bo_va_mapping;
> +
> +struct amdgpu_cs_chunk {
> +	uint32_t		chunk_id;
> +	uint32_t		length_dw;
> +	void			*kdata;
> +};
> +
> +struct amdgpu_cs_post_dep {
> +	struct drm_syncobj *syncobj;
> +	struct dma_fence_chain *chain;
> +	u64 point;
> +};
> +
> +struct amdgpu_cs_parser {
> +	struct amdgpu_device	*adev;
> +	struct drm_file		*filp;
> +	struct amdgpu_ctx	*ctx;
> +
> +	/* chunks */
> +	unsigned		nchunks;
> +	struct amdgpu_cs_chunk	*chunks;
> +
> +	/* scheduler job object */
> +	struct amdgpu_job	*job;
> +	struct drm_sched_entity	*entity;
> +
> +	/* buffer objects */
> +	struct ww_acquire_ctx		ticket;
> +	struct amdgpu_bo_list		*bo_list;
> +	struct amdgpu_mn		*mn;
> +	struct amdgpu_bo_list_entry	vm_pd;
> +	struct list_head		validated;
> +	struct dma_fence		*fence;
> +	uint64_t			bytes_moved_threshold;
> +	uint64_t			bytes_moved_vis_threshold;
> +	uint64_t			bytes_moved;
> +	uint64_t			bytes_moved_vis;
> +
> +	/* user fence */
> +	struct amdgpu_bo_list_entry	uf_entry;
> +
> +	unsigned			num_post_deps;
> +	struct amdgpu_cs_post_dep	*post_deps;
> +};
> +
> +static inline u32 amdgpu_get_ib_value(struct amdgpu_cs_parser *p,
> +				      uint32_t ib_idx, int idx)
> +{
> +	return p->job->ibs[ib_idx].ptr[idx];
> +}
> +
> +static inline void amdgpu_set_ib_value(struct amdgpu_cs_parser *p,
> +				       uint32_t ib_idx, int idx,
> +				       uint32_t value)
> +{
> +	p->job->ibs[ib_idx].ptr[idx] = value;
> +}
> +
> +int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
> +			   uint64_t addr, struct amdgpu_bo **bo,
> +			   struct amdgpu_bo_va_mapping **mapping);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 9e65730193b8..6d704772ff42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -23,6 +23,9 @@
>   #ifndef __AMDGPU_JOB_H__
>   #define __AMDGPU_JOB_H__
>   
> +#include <drm/gpu_scheduler.h>
> +#include "amdgpu_sync.h"
> +
>   /* bit set means command submit involves a preamble IB */
>   #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
>   /* bit set means preamble IB is first presented in belonging context */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 48365da213dc..05e789fc7a9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -28,6 +28,13 @@
>   #include <drm/gpu_scheduler.h>
>   #include <drm/drm_print.h>
>   
> +struct amdgpu_device;
> +struct amdgpu_ring;
> +struct amdgpu_ib;
> +struct amdgpu_cs_parser;
> +struct amdgpu_job;
> +struct amdgpu_vm;
> +
>   /* max number of rings */
>   #define AMDGPU_MAX_RINGS		28
>   #define AMDGPU_MAX_HWIP_RINGS		8
> @@ -82,11 +89,13 @@ enum amdgpu_ib_pool_type {
>   	AMDGPU_IB_POOL_MAX
>   };
>   
> -struct amdgpu_device;
> -struct amdgpu_ring;
> -struct amdgpu_ib;
> -struct amdgpu_cs_parser;
> -struct amdgpu_job;
> +struct amdgpu_ib {
> +	struct amdgpu_sa_bo		*sa_bo;
> +	uint32_t			length_dw;
> +	uint64_t			gpu_addr;
> +	uint32_t			*ptr;
> +	uint32_t			flags;
> +};
>   
>   struct amdgpu_sched {
>   	u32				num_scheds;
> @@ -111,6 +120,8 @@ struct amdgpu_fence_driver {
>   	struct dma_fence		**fences;
>   };
>   
> +extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> +
>   void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>   
> @@ -352,4 +363,18 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>   
>   void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   			      struct amdgpu_ring *ring);
> +
> +int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		  unsigned size,
> +		  enum amdgpu_ib_pool_type pool,
> +		  struct amdgpu_ib *ib);
> +void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
> +		    struct dma_fence *f);
> +int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> +		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
> +		       struct dma_fence **f);
> +int amdgpu_ib_pool_init(struct amdgpu_device *adev);
> +void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> +int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
> index 57c6c39ba064..b96d885f6e33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include <drm/amdgpu_drm.h>
> +#include "amdgpu_cs.h"
>   #include "amdgpu.h"
>   
>   #define CREATE_TRACE_POINTS
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 9e102080dad9..4927c10bdc80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -37,6 +37,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
>   #include "amdgpu_uvd.h"
> +#include "amdgpu_cs.h"
>   #include "cikd.h"
>   #include "uvd/uvd_4_2_d.h"
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 344f711ad144..6179230b6c6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -34,6 +34,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
>   #include "amdgpu_vce.h"
> +#include "amdgpu_cs.h"
>   #include "cikd.h"
>   
>   /* 1 second timeout */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index b483f03b4591..7afa660e341c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -25,6 +25,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_uvd.h"
> +#include "amdgpu_cs.h"
>   #include "soc15.h"
>   #include "soc15d.h"
>   #include "soc15_common.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index da11ceba0698..2bb75fdb9571 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -25,6 +25,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_vcn.h"
>   #include "amdgpu_pm.h"
> +#include "amdgpu_cs.h"
>   #include "soc15.h"
>   #include "soc15d.h"
>   #include "vcn_v2_0.h"
