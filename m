Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504ADC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 16:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE2F10E092;
	Mon,  7 Mar 2022 16:46:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A946210E092
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 16:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1CptAtCOwCi+NE2pNgwChKC0ffYQWav48Eqg+ZKhtxULvqqYr3qp8oKOKzlYf6NyQmuTvvfJeQ1RAavdFUbkPYBA3pTFR3g3YRtFn2BJlLYcqSv2ndfwrX2Lu4eMP0KGf6ExPLtkEDMuOEmcPL4VgGz8GpmFgWFEZ/NlvaZZPjbBnfakMkhA5C1pJbUX111D61oIONa5z1E+dSz+Ox7Rh2UjZef8JtpS2lInLCidckh2/b7DTe1Q3GEOZyNI3TU8f6u5ekrm3LElU87C6OxFtw3hSZ3hzbCtSoEXiYvjzX+5RnmRbg+zzhgCWaiy3pQXyvNZIGCeyt7EU7Bo8s0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN/QCa7rWiCfV3xI0FM3ish6g2dOBhIgx6176HZXdGY=;
 b=UA3lZVaxH4IZ8Ha1M+MlB/0JB4s4kjuzk+kEUIn0T6ahIDE0L9QzDk+aydhQ8ES4KmTagnAgih7Ix1oRdTRhdPl5vQ2GJSwQPwMUvtSE29m7zpCdNM3Vw/ZMgrYbyF3tx5gNIxBY7Wid3Uh1ZbkmrbRYaMO4d7gDJ2A33jIjgQvF8UHmVsFdA6CV/WwzOndp03NF5kMLoirKM0M1XrbzQu71jlOP5sEAJOzoQMD43uHI/J7BeEnkTch59WVpfkFMHlx3IK5yETh/omKtfEzeXpeE/5Vb7fZnGUHAtfbmjsQFjeDgA9Mw6J6U43UL1bC/IzkMCe5TFjDLl68IeJfchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN/QCa7rWiCfV3xI0FM3ish6g2dOBhIgx6176HZXdGY=;
 b=UMgs5WbhWeb9nLgnmNvL7w5QRz+eYsccUMf46tRQeMKAIaYX5C3Kj6JpTpiUabrRghfc5r2FVlJdMOS7u7Bk1+ISk3TKKwhyMSPkUYakIu3a3bFB66GXSfrM7e1bNB8203d/nHKy/NY//q0WBlNpkg2IHGVR513rlDwwA6HlEOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 16:46:33 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:46:32 +0000
Message-ID: <b5f0fbd2-f599-8f4b-dd12-8f18734d52d8@amd.com>
Date: Mon, 7 Mar 2022 22:16:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <20220307162631.2496286-2-contactshashanksharma@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::30) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07cccfca-6945-4eb6-21b1-08da005a08a8
X-MS-TrafficTypeDiagnostic: BY5PR12MB3827:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB382736D7543973DB89ED2AF0F8089@BY5PR12MB3827.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXt4T3tN8b2rK7EMEAhmZrV0Ft91wLJQEK39ylpsl/Ho9DVI07dgmB1lEUlPc6arNZFRUPBxny5UCLxQKyfI0i4WrreulvlSlpe9ve54EeuUJGoEDryZJERpDXCIOpA5PWNhm01Li859Cqy4AkdGmppAQ6TuM24JDULg0CFHJAfSLi3UJs2f7Jww1pkDWaBfIt6xGtQX+03T7f0jVbPgAqPgkzFfPDI0hSMu5YdUBB0d0GoOmZixik7N7+A82U0OdZlaM/1XFR4FpqwRriDViMxLFx9vpxylRqvMCPYvNC5Jl1ydyKsnByYOzNA6MJFLettMuFikAHbckM2QjaCfEetPlZYUOKjwF/+lxwS4gWTqAlMrfSWjInXaoc46eLRX/rGQFCFDVc1tVAbtvEu7NJFr9Qm9VqPHSL7laIDfRJu5OsPHAn2aIPMpQ7/dhZACA0C4aJxmCTBm0fpp+OY2KdTiC4Pur0PiqyFmVn3oA46/CUieI/2/A+SWAaokV1L3jLRvxRKcKNKCgHpzuA4gZuQaK14yVfR7PGZORluwaYaoyvGV9iPpr7ZbR3zzvycFSS5y+dQ9ixHqltfAdpOD5Yp2xentpTiiHwWP9Z05ITxQiH+Wbk7wNNl2KMB/WrP9LOi643mLfUvoLRJD/MkeJcG6a9C6/z+AGM5X145Gt/tCnV/J/lrJT8wSZ9aFi67ZnesQRoX/I1G5P3hoMg3/CDNxwH9+RhjNuPLy7XjvOZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(31686004)(508600001)(5660300002)(186003)(26005)(66476007)(66946007)(2616005)(66556008)(36756003)(53546011)(31696002)(54906003)(6486002)(316002)(4326008)(38100700002)(8936002)(6666004)(6506007)(6512007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVXelFORkE0M21UZ1FyZjBhcVczSWlIWWdNaWtqeDIvRm1QVGxLelAvZVJi?=
 =?utf-8?B?Y0dDeko0WVQ5cTN2SFBHSmNVQXFxUkJIM0J2ejk4S0wrYVRxSjRxRmxzMi9Z?=
 =?utf-8?B?TnBmUUc0N2pSYTkxMU9sYVN6cjl2S3lpUmZoZlVXUy83K01iekNmNXJxOWFZ?=
 =?utf-8?B?T1Ywc3l0d0FkKzBzL0Q1QTRIUWtQdzlqNHpJRW9TSm0zN0xDaVREa3MyMmR2?=
 =?utf-8?B?L3ZCT3IxSnhQV1l2K2EyRzZ2b3o5U0ZsOEEzQXJjUWNQSW5sN01tWEc0RFhr?=
 =?utf-8?B?eU9zdlJBZjlkVUU0T1BKSnAycGdtYzY0Wnc1SW9mOXh0b1VZbEgwaHZmTDRM?=
 =?utf-8?B?NUFiazhJSGhGUXllcWgvMWJ4YUQxbkpmZ2EwbXBKenhidlpxVk5WcU1mSXVR?=
 =?utf-8?B?cTdkTUw5ZHFxYmtzSk1IRVNRdHRwdythR01GRlRqckU0RUY3TTRpcHB0U0Yy?=
 =?utf-8?B?OUUvUE1obFU2a2pwYVhxL1lGNTFOeURDVE1Ga25HdEU3RkpWaEE4aGRESEwv?=
 =?utf-8?B?WHlTVkJndmlhZzNGOFlOQzR2b0o0Z1J2MGdzU2FPdVJyQUVoU2h1UzRPME51?=
 =?utf-8?B?V1lHOXovVDQxTHNPTjY2YlVsK2dtUmY3NHZ2RGdsTUJ1ZW9DMmdraWNxQ2VT?=
 =?utf-8?B?ekh2U2lkME9aWWQwZTdkdjJrNnJPdXZtc21CeVFYK3JiS09LRzJROHJsM25j?=
 =?utf-8?B?WlAzYmFpcmZQNXhVU3hJZE94bWtpcENuclU1RXBWUFR1bmJKdFR2UnBqbFpV?=
 =?utf-8?B?MCtibW1VVUFJd004b2RGeXVWYzJNZURObTI5OGlIMzF1T3JaaWQ2bzkrWUFS?=
 =?utf-8?B?MFJ3NGpjK1FuendlSXMzdTlFR2NkWEZ1SlB4K2lSSVFodFdiM0NGbHV1Z0VU?=
 =?utf-8?B?bkcrSkkxWDZqUmNDR3VpR1RoczVHMGpzYkV0THFUR2lLNTlkaUFmYUFONGE3?=
 =?utf-8?B?UDA1TXRBcUtMNUREMElKK1YycVBrNFdQODMrMmJ2NDNGV3E3L0RrMm9WbXJo?=
 =?utf-8?B?Q2djZFcrM2o0ZUdxeGFwVFNBTXVwME9vYU1FaC9ZdW5mcGxoM0RZRlRoRmhP?=
 =?utf-8?B?eFF2NGhFNDliRTQrUDkwNkMrTG1XMzhuZDFBZkw1VzZ4VmZMYy9LT0R4MFlz?=
 =?utf-8?B?a2VDZHROL2tOZXhqSkVkOCt3ckJKYWtOSFEyMmcrVmt2RVNndGh2VXMxN20z?=
 =?utf-8?B?MGdhdEFsQTZtRVFUb3kzaTRMMUZkWVJNQXd4NEtWN0wwUmljWGdjWDdPREpI?=
 =?utf-8?B?VEVhK0h3c3I1TjZWdjlDKzRQMnRQRHJOZVFPZlpNTC9IVmRQc0NrandPQlE1?=
 =?utf-8?B?dmRneXJYd2VOcnZ3aG04ZkQwVzFpUHkzd0dnS1N2TEdYSnV1ZHZnU25Qb21H?=
 =?utf-8?B?aXdnUTdHazV0QzQxY3FLNE0vemRxVTA4OU1uRmU5UjJGM3JIMWk4LzhiN1N5?=
 =?utf-8?B?NCtnMVJIelc5ZXVkdXVIekhUMVhiTllIUHBkeWVybFg1SFc0bm0vTXI3Wm9F?=
 =?utf-8?B?MmtabnZ3a09abE82WTVYaE1BNVVuWFkyL3pwbFJUMm0rblV5WWdNd1RjUHBK?=
 =?utf-8?B?dWJDMGNMUGgxWEVUdHk0eTZ1aEZIVnN6OG8vUVF5SU96dmsrb3NJN01kM3p1?=
 =?utf-8?B?MXFVdFBlWngvUlBIUlRTUFo1TFJFNFpERkJHb3FYZlJpckYvcmhhdmFNek01?=
 =?utf-8?B?emlOSVlzVFVLL01UVFh4Z1l1RG1YbDZ3RnRYVHFWRlJoV3NudEhacHNzR2lV?=
 =?utf-8?B?dTVPai9tcnFkb2x5SmlXcU5EeENaNC9ra2w1RUN1blVGQ2lxbEFtdXpPUlFz?=
 =?utf-8?B?c21VdXJxbWVXcXNoamhDZ2FrbVBFMGdIKzZUK0FvUTFCcHF1ZWNicXhXTFFj?=
 =?utf-8?B?amVWNUZpdDBUZ2w3NmxqM08yMDgzNTdacktoU1h1R2tXZU0zVGNDVVV5T1pD?=
 =?utf-8?B?YUZoalAvbFVLb3FpQWFMTHBJa05rNER0Q2Y1UEc0d24xbDJJZ3BRZHZoSyt0?=
 =?utf-8?B?TktteWRsN3lrenF0YVVHY1JVLzl4L3liKzBGVkwxU2hYM3c4QWJPWGRZWm8x?=
 =?utf-8?B?K2tNaHBBWDNUN1ZxRWdWR0d3VUNNQmh6aW5zcWMwTU1rTHZBd3g3SGxLSC9x?=
 =?utf-8?B?S1Rud3lVOHdFRWxlWkRUZzNZWUxOT3lhcEludGtxTFhJTndkeTUyWWhmQmhJ?=
 =?utf-8?Q?TG5pxlGDPqHucoW4c1RZFp8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cccfca-6945-4eb6-21b1-08da005a08a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:46:32.3795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I9Rzcz8LIvIAGqfGz7cH7ixY54wGLz3WZ/1/aRDZqoxuMV9Tn3iurIVay40AHXCc3BVNh2ZLgzNCuANp5qMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3827
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/7/2022 9:56 PM, Shashank Sharma wrote:
> From: Shashank Sharma <shashank.sharma@amd.com>
>
> This patch adds a work function, which will get scheduled
> in event of a GPU reset, and will send a uevent to user with
> some reset context infomration, like a PID and some flags.
>
> The userspace can do some recovery and post-processing work
> based on this event.
>
> V2:
> - Changed the name of the work to gpu_reset_event_work
>    (Christian)
> - Added a structure to accommodate some additional information
>    (like a PID and some flags)
>
> Cc: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d8b854fcbffa..7df219fe363f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -813,6 +813,11 @@ struct amd_powerplay {
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   #define AMDGPU_PRODUCT_NAME_LEN 64
> +struct amdgpu_reset_event_ctx {
> +	uint64_t pid;
> +	uint32_t flags;
> +};
> +
>   struct amdgpu_device {
>   	struct device			*dev;
>   	struct pci_dev			*pdev;
> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>   
>   	int asic_reset_res;
>   	struct work_struct		xgmi_reset_work;
> +	struct work_struct		gpu_reset_event_work;
>   	struct list_head		reset_list;
>   
>   	long				gfx_timeout;
> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>   	pci_channel_state_t		pci_channel_state;
>   
>   	struct amdgpu_reset_control     *reset_cntl;
> +	struct amdgpu_reset_event_ctx   reset_event_ctx;
>   	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>   
>   	bool				ram_is_direct_mapped;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ed077de426d9..c43d099da06d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -73,6 +73,7 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <drm/drm_drv.h>
> +#include <drm/drm_sysfs.h>
>   
>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>   	return amdgpu_device_asic_has_dc_support(adev->asic_type);
>   }
>   
> +static void amdgpu_device_reset_event_func(struct work_struct *__work)
> +{
> +	struct amdgpu_device *adev = container_of(__work, struct amdgpu_device,
> +						  gpu_reset_event_work);

I am trying same thing but adev context is lost.

schedule_work() in amdgpu_do_asic_reset after getting/reading vram_lost 
= amdgpu_device_check_vram_lost(tmp_adev);

Regards,

S.Amarnath

> +	struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
> +
> +	/*
> +	 * A GPU reset has happened, indicate the userspace and pass the
> +	 * following information:
> +	 *	- pid of the process involved,
> +	 *	- if the VRAM is valid or not,
> +	 *	- indicate that userspace may want to collect the ftrace event
> +	 * data from the trace event.
> +	 */
> +	drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, event_ctx->flags);
> +}
> +
>   static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>   {
>   	struct amdgpu_device *adev =
> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   			  amdgpu_device_delay_enable_gfx_off);
>   
>   	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +	INIT_WORK(&adev->gpu_reset_event_work, amdgpu_device_reset_event_func);
>   
>   	adev->gfx.gfx_off_req_count = 1;
>   	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
