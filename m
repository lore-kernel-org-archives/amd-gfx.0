Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DA2C3DA7A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jan 2023 13:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B082A10E333;
	Mon,  2 Jan 2023 13:26:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994AC10E333
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jan 2023 13:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0QLgXjKCAn0wTwKlMLNs3Ub6l4CSVkkGV2UTG/3HkUCtakMXVkNFekIXgVR7DrEwPf6UIoz2NByZ63tjsXFfVx6skE3HLcsCd/JDHb7ggkk3dRic38dG+T5XhT7is5PTdXeWe3PNtzWIwMMeZGyg/jNu2jxZSLViN/xhQuU/ciZx2gvbs0oIJwaucipVE2YirfxQ6ggkt9YZY3RyjwI+1KylSsA3o6y9dM8vzMSWt5tJYaZ7S7CxrhpIom6VzAdfs0u3xYJ10K7nK51+r3r6BmDBKqLoM8naJYvWxXVzFigtdbDArJ4w4IoY98Q4Xe4SzEgJmduAQEXSYLQ4ecyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwDBvGjp/dOPSJpM0hMUOB94w3+LKD0msUvd5ApZN/k=;
 b=P3t4Yj+5HbwDIXr6eSJqw6HUMiLPQ8jYJsdQhsB3cXiefAq4pnkqWrQqmXJoAaUmxzrP96jQgzrFzPd04iI0q93H4YSHAkeVN0F7i+bvXsfo3eHn508EpydCRNcXcLv/VInnbBM6tOToopR1RDnbNJxqBjRGIAjXlj0qUTHaT5E0vmd+5938gFDihyS7r8p+mZZzwm4oYtISW6jNh1s7MSnfSWp395P068JnQm5DaR1gHP4UrpYR4HjKTUXvd24/fU66/1xLCVT9mF6fjxxhrFB/LCk7l7KLxqftHt9rjT/kwvgNKCfgzK3het17tohnhnwzgR4g+uYeHyFET3XQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwDBvGjp/dOPSJpM0hMUOB94w3+LKD0msUvd5ApZN/k=;
 b=FBlwHsHNobpCuAyd5BFaP+okQAe9NxxsGAzLe9jYlqQ4c+vvaw2kfDYM2tKx47mXyTkpgjssl76ZOe/po1NZkSTXGxYLLf9/C7zXMoiMHA+Lma0gbN7HvT4SaNjrdGHKydktNvt86JwqkZeu24wuYBg6wZEtXdk+4ra7XGOJ0TE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 13:26:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 13:26:16 +0000
Message-ID: <43f6b308-520b-30e6-5367-98ade8202e80@amd.com>
Date: Mon, 2 Jan 2023 14:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221223193655.1972-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 771ac7c3-6fce-4e7c-61e7-08daecc4ed2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dE6zEpGxkCcxOTLUDsnX7CFa0XhW4eaVSqiSdGOrdJik72dOlNUphNjZ/wkp6aaGW6dDc0xPpLHBMyv1WZtmZXJ1CQz7090CRm5XhtBLMZTuBPumKc7Ocz881i8UU1uu3WeDYFg96A8I4HqAzpaRbrreRA+kspLECX3bDrvnghbpqBodAtpcZkvozGfdV+BUt4LKFQDowyqTwbMFNEZMhxYiSzrp02AnsulZCc1eAEHrotr/6pvUP0fBpZTD+bjCLVKTf76hkBB+dwXAaNBGC+TFwkVushHhuN75QOwoxb/rJasdjFRAI6AjgE9V/ymQpEYpFCtYPPGZnbLJl0h8L7dQ1MSLiaPxx9ZCAeayiLdaJLEb55Tsf0HRaHxLWQcc4yosALF4KmCicyfU1Wxkr8P7v7ojEqFKfEy0TnS5x0eX3mmJjPkYCcJSTCwlmX3uVWNONNHoyhjzlaheEyELpq6ym9zo/Nv/zXM5/1EE7ty3JQfiPz1+HNvkxwIdV3f0VhLCv8fF6THmqT0XHDUWtGGtpd8B65POghkOHWYv0tHnk9pkhLiHt2VKmfJlsVxSGc8c5mUTwIBv0zhdkahxCsCyeJFYSpKfDxTjaVPS/Vz60TE5u4oFMNbF6cySZkr5xaJ2BVf6ZwclI1ViGvOo3omQjRmumBeXhoOwk9bAjkG+ntD/bNc2Ki4+uplqvG2khaIcVgvUDlHsF/EPEhzd9AbUPGpfwP269a0Sji0V6uj8g+uzWV5bz3+tanF4+NA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(83380400001)(186003)(6512007)(2616005)(6666004)(6506007)(31696002)(86362001)(36756003)(38100700002)(41300700001)(8676002)(4326008)(2906002)(5660300002)(8936002)(6486002)(66556008)(31686004)(478600001)(66946007)(316002)(66476007)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1SSmFEYzJPZ2NLNUZlNDNXNkxvZFlpRTNXUTJBcmxFV1RXd3RLOU4rcGJt?=
 =?utf-8?B?ZmVoQ0ZpRFQ2a2tleXIyYkRLZWVTc0pYb1FxcmM5T2F3TC8yNGNoaTREWks5?=
 =?utf-8?B?RHdyTDFMMllrQU1La1pCWjRQcktCNHNidUsvUnA5NTZCTWYyNzhSZU9HZVdQ?=
 =?utf-8?B?NWdKUUduU3BHOVhoVmIvL1UzWHdJZEFtVWNrQktSUzlQUWY0eVNiUlo5b2Mz?=
 =?utf-8?B?bE9oT1p3elFWYTMzcFVSb0l1U0hZZHFwTFUwdXZwMngzZm8xQ3dFQVBJTkMw?=
 =?utf-8?B?MThnMkpSa1hXZlZBZkRleU1zUjJwTy9tNHM5YXlSM0FFeVJwOFVVYXFjdXBr?=
 =?utf-8?B?ak9WY0RXNlhBNnc5RlFTY0pkbHRjYXZJVm1hUXJtNEo4Qzd0RkpvSWxQcmt3?=
 =?utf-8?B?RUxub1lEamRwYU1ZdFFScWdNb1pOUnFwNDVGRWlhazFKQ3pHTmFyaE9kMTE3?=
 =?utf-8?B?ZDh2OE1Bd0lPOC9RQVVjWjlreUpZZlo2WWFJVzcyWmszY29Gdkp5ZUxKOXpX?=
 =?utf-8?B?WVFBUWowemk0VlpTWmlPM1U2Sk5BRWRmQm9iRlB5N0N4RFdwOFFjUlZtaHFS?=
 =?utf-8?B?MWEzWmdLL3VCVk1odHRGN1JZRzJxS0pua2ZDaFU1czZSR1RtRi9QemczMHVu?=
 =?utf-8?B?cHg0akJMSklpUEVrL2srMDRaU3dkVXlKSnpsSUdUMThOWXFMeWlYbXJ5emNF?=
 =?utf-8?B?RUYybm85UEtRT01TdFdTUDg0R0EyWWprdXVvM0JzemlxTEFoMmtrTStEZzdO?=
 =?utf-8?B?Y25COTRJZ2tJaTNnQ0taODl6YzZqYUNVNWpERjRDSUp2WG5KR21UVktoRHk0?=
 =?utf-8?B?NmlLb0kwNTQwYTRaK2Z4Y0tDYis5NENMMW40bU9NN21UcGFnL2JpempTS3Q3?=
 =?utf-8?B?WklURjFpbUVpVWJpb1d0aHl1aUh5RmJielUrMFkxT2xCZXNud0JsaWl4WWpD?=
 =?utf-8?B?SkpTbkUycXJreWNwYmdzSGJWTWt1MExoYlk3V3FNNFhLeVpVQWQwNEZ6Yzgx?=
 =?utf-8?B?Tkw0ZUp0djdPdGdXejE1bmg3QnNrSURIdlg4ZU5GU1Z5M250aks3UE10QVRl?=
 =?utf-8?B?STdDWjhudzMvdHUvbWpRTmZ1UXQvckk2T1hYVEphSExPaGlFZ1JhajAxeHBI?=
 =?utf-8?B?S3Q5RXF4dU1mb1N1MFJKYVdML1ZWd01Cck9na0dHODdNK0U0REptdEp2M2hT?=
 =?utf-8?B?QTFHb29pUDRGVk5idVNyL2dNSHV1VFNWYzMzL2pleHRrbUhESTNpRTEyS0Ns?=
 =?utf-8?B?bVArMWZHbzg1M0pnc1l5Ym5adDEwM0JwbG1yWUluQklwUllDS0JaZ2hCQkNK?=
 =?utf-8?B?VTNhWFpPZGZwR2x3YlZUZTM1M01EUWJXS3JkMHNKcU5rbmxjR28xd05vRHhj?=
 =?utf-8?B?c2JnQTlseDFXYWJ0bnJjYjhjamVySDl0d0FDWEFYSitCTWNINXVuZHRrZTJ4?=
 =?utf-8?B?Z1VaTG1wZFpxc1ErOUFDS0dKTjdOWjF3MzVHbUFETno2ZG1oNEwwOVQ0YXA2?=
 =?utf-8?B?UnNyWExPVFBwWlNIWWdUakdJMng2Q3dmenVJZHBxbUxiS25scHQreUhKa3hE?=
 =?utf-8?B?NUMxeEJCY0ZseUtLWTZ1ZDhqRjl6VlFKVi9nWXNtcjJaREFiOEZCZjZScFdU?=
 =?utf-8?B?amgyVnB0STd5UEFNUmVMd1NwT3RNTkEvdFlQbjF5K0hhQnNNdUpoanNCbTh3?=
 =?utf-8?B?RW5mVUE0R2ZRMnQzZ3lWT3FwWitQWFZFanRZV05NbGZISU95LzRqNTQ3OXJB?=
 =?utf-8?B?aGxWUkZhdXZwL0ZmRmNjSmE4ZTF5amJNaDA0dzE5N3YzeG1yQlRyNXY2RE9I?=
 =?utf-8?B?STd6ZXhMNThBRDNBdWdFMXdTbXMrbGtLeEFUK0ZsTjlNWVRsYnRZakF3RDI0?=
 =?utf-8?B?YjlzV3d0S3IvS3VFSUhQdFNiejFHcGxDalFwdWpRazhZZEhQQ2syYmZyZXFG?=
 =?utf-8?B?NktIc29IcU1yL1FjS1lwMis0azBsVE9tcTZ3Y3B6UUs1QU1mWGl1Y3NJRkVH?=
 =?utf-8?B?aVFxQnYyQTRkbjlwNGdBdXA1ZFJuY1dNRTFpL21VK0ZOb2k0d2VsQ0FKd2ly?=
 =?utf-8?B?dVc1OXJnMWdiNGdyUmcxWXgzTmpIU3haMm9tZnpDUC8xNFN4a0lMam5nNTNH?=
 =?utf-8?B?RzBTSElGZlFnbUtQS2w4VGtlKzFia1V4d1lsMWp2V1ozQS80VU9DclI4Vzgz?=
 =?utf-8?Q?EtHeGr1xytee06vCCY3/n8/zHxbjakFpKVvyk1E6ITca?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771ac7c3-6fce-4e7c-61e7-08daecc4ed2f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 13:26:16.4959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4+hoZ6WOgWmy0i9y8N30PISlYZw/3TEX+VBajx+at4PKk7swP9QX8H68heg0yGO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.12.22 um 20:36 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch intorduces new UAPI/IOCTL for usermode graphics
> queue. The userspace app will fill this structure and request
> the graphics driver to add a graphics work queue for it. The
> output of this UAPI is a queue id.
>
> This UAPI maps the queue into GPU, so the graphics app can start
> submitting work to the queue as soon as the call returns.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 0d93ec132ebb..a3d0dd6f62c5 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>   #define DRM_AMDGPU_VM			0x13
>   #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
>   #define DRM_AMDGPU_SCHED		0x15
> +#define DRM_AMDGPU_USERQ		0x16
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>   #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>   
>   /**
>    * DOC: memory domains
> @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
>   	union drm_amdgpu_ctx_out out;
>   };
>   
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE	1
> +#define AMDGPU_USERQ_OP_FREE	2
> +
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)
> +#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
> +
> +struct drm_amdgpu_userq_mqd {
> +	/** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> +	__u32	flags;
> +	/** IP type: AMDGPU_HW_IP_* */
> +	__u32	ip_type;
> +	/** GEM object handle */
> +	__u32   doorbell_handle;
> +	/** Doorbell offset in dwords */
> +	__u32   doorbell_offset;
> +	/** GPU virtual address of the queue */
> +	__u64   queue_va;
> +	/** Size of the queue in bytes */
> +	__u64   queue_size;
> +	/** GPU virtual address of the rptr */
> +	__u64   rptr_va;
> +	/** GPU virtual address of the wptr */
> +	__u64   wptr_va;

We should probably note somewhere that those are inputs to the queue and 
need to be allocated by userspace somewhere.

> +};
> +
> +struct drm_amdgpu_userq_in {
> +	/** AMDGPU_USERQ_OP_* */
> +	__u32	op;
> +	/** Flags */
> +	__u32	flags;

> +	/** Context handle to associate the queue with */
> +	__u32	ctx_id;

Uff, this is just blunt nonsense. Queues are not related to ctx objects 
in any way possible.

> +	__u32	pad;
> +	/** Queue descriptor */
> +	struct drm_amdgpu_userq_mqd mqd;
> +};
> +
> +struct drm_amdgpu_userq_out {
> +	/** Queue handle */
> +	__u32	q_id;
> +	/** Flags */
> +	__u32	flags;
> +};
> +
> +union drm_amdgpu_userq {
> +	struct drm_amdgpu_userq_in in;
> +	struct drm_amdgpu_userq_out out;
> +};
> +
>   /* vm ioctl */
>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2

