Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5DAFD88F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A0610E30D;
	Wed, 11 Mar 2026 04:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="otzX3/Zs";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5D510E30D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3IYuEVlAizrh6K3tyhGrg/eUabJyur3WgqzBi1192VCwn645U0urFc9bSsRXpNxdmmhfMx8Qk622oa84XyliFtdlrqUaCsyoKacWXlLADjwHw1CWQtPXbkze0YTmduBGt+CRbvCG/8URVGQlRzmqi9xsfbmJiyuS0WEgeelLRG9EjsEx/SCh0v5hOrxgavOo9MF9F7E4kYcwJVwuM/kFiEB1vG0FvXbp1S01GTdD0uRedjzgiViQz2OWyFCN3j9ms5AbQ5nK3QOWASk9spEtFVC29YzEaDGgbC6LyEeEnsI4NC+44hKfIdFdDeRLwLLKrROX9k1Z24gc+yxsKzvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB4CsI1SYSQpuTlPsjVg5MfQ5jyIEQFChFv+qSE0Rxs=;
 b=a9wP4rr8uHfcmp0KUE/1AHIcwnNW7j2a8ZITROqigEEaUd2BV+Rz0903+vrziHMLDeDiCv9w0Z0xe73UeSUN97hCc9eUrKe3gqyFsfW6it4eW79fDqKpEdE+5vNQ9AR1aSGRhVM8m8Mne8/braJE14IXdkGpO/P7qAxLkeB2R4IQnfhpiODPDsG3X02RMu9TTdHx37x6G9jYt0aDy3Gxa6IrDzUhFeeEQdyTmR7Wv+/FXMUOHcU491ul3Mwen+TDDOsFm6d4QQdR8mnSVX5kV/GRmGnEfzRpiZQRsX6Nuq7/G3Sx50PpRggS22K/FPCB0xYgMDpDr0cJO++shzVdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB4CsI1SYSQpuTlPsjVg5MfQ5jyIEQFChFv+qSE0Rxs=;
 b=otzX3/Zs329vKYkO/bJ3codUMp6gyZgfA6EBwFq9TThZu9sTTE8uEECRodPVdjQOXC+9xRinjlHE6r6Hmd1x8dALeHJC8VKXb7jeRo7Mv5U+4CG1JW2hqxGYlOU2lZz9ia1oR5LQnACnTe5WCbvel+zHNTXwpIfPPcONvYaUO1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 04:52:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 04:52:31 +0000
Message-ID: <8738adb8-9c4a-45d3-b515-08c7cfbc5b29@amd.com>
Date: Wed, 11 Mar 2026 10:22:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: force fence completion for all rings
 before and after reset
To: Chenglei Xie <Chenglei.Xie@amd.com>
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com
References: <36bdc19b-87c3-4ed2-ab60-b1f97cb9c0a7@amd.com>
 <20260310204113.2282056-1-Chenglei.Xie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260310204113.2282056-1-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::23) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaf8cff-8b88-4fcb-1f36-08de7f2a00b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: n/1z2QjsjrNqK2KM0IRPUU3lEo+rxZP8JIh0C/AKNVowlaB/HghmcTrt5UaMyUJYXWsXAbmtIz+gfrZIgz/7v8nRwllwLDu8gSjPCmqgTOoq6IspGUvviOtqeNORIoXgMywJgY3SrLpG98uIxSCJ/IqLBOfSFqgOSLJOsUfRBnGBvE2eRsIWNADwGU6gU0SGhz4JMiU8tDLrqZk8pTVG+XF4X/7dNudqJjeAZKzGIKVFZU/+oV7y4Hi3WF7f4vZKqlntNCLCH2xbgu8lmFTdnfgW/zIB9tbbE2pRG37ckAISB6j39S0IktUiVc2FN882CpC5XXt9l5Ma/xHF2Vodl3XV0l6EaQBrJ2B/jhGVFDLEbeb2wXltA0w/HKjqbAVUbXPD39JeyBPQXSSCMC9vi74QBrHwMIv6fF2UK87xTl6+SEhZ6zqMASGy5cc3kz9CkcFK52qBcB+ddPd9FCHw/E7Z0Q33iAtqJ93iAksEe/kjbSBFIySVWc/dcNVuSsYAZLqpvd5jHzn9t6We7+E4UCjW9WXFbQyfGfkcpv4dgODAnTfEgYKbuNJVs/6DOj4AqxHCO0/9ICJRyoF/OLsRYFFwhWyDftNmRdjeY3ivNEnJDqaqxn0SJsClmN9XrjzH7JLqcJMDudVB2smcZuRZQWr1V33jG4tH/w7kdzWGkyhHwHtBVQzBt9lBcthQbWu6fuZQTK/HNhqeFHU7Zipx0aYDrvIdb3/qkeMxfclaQfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTJ0TEFta0FLMlNjajd4QW12RFJuTlRDVTlWTWhzMkozbHFBVWZsb3JYUDJq?=
 =?utf-8?B?OTVOY2c2S1cvRWFnNTZiUDRPYXFYcDJvS01ZK3lrZkt3OXlmbjRLVTJITStJ?=
 =?utf-8?B?NzRIOGJrNCtMR3lDZ0ZkbmZJMFVFU29DZHdvV3c0QkxUdHpadWhJTWpkRUdl?=
 =?utf-8?B?TE9QbEE0U1dSYjI1dEVoWUdxVGcxK2xkWmVlNTh4cm16cmEreXorT0RodmQw?=
 =?utf-8?B?RjdYMndZbnNaUWFjY0ZPMHRIYm1rN2F6TFcrSnpQVzZxR1FPRnJNamFYNVRY?=
 =?utf-8?B?dGtEQkJWTjh6dGI0WGoveGRzL09MeGVEZ3FWYUlXWWtZTzEydVNsNGlyelhI?=
 =?utf-8?B?ak9YVzlpdDZmdVJudUs5YmUzMTRxMWV4V0JhbFZpTmYxZUlndmhuY2xlWjcr?=
 =?utf-8?B?TzlQaUVJcmpkaGtWQnpqdkx5NkpZNnVXbThraVhjV2o3ZmM1MDk2akd2SUhy?=
 =?utf-8?B?RHQ3R3NoWUcrWENBU0VQMU1obEY0d0J3T2JJYTF5UUMzcG5JNHVucFMvRlRQ?=
 =?utf-8?B?Y2krMWxKUWZNb1BHUHlUcG83MTZmR1plOVhOOEgwNDZidFRZY2dNYVNpTkw4?=
 =?utf-8?B?V0FqR0U1eXlGc3pvZFM1b3ZDOUdZbXFJekduL2NJVzdkRXZvRXYyTWU3SHpu?=
 =?utf-8?B?d1YvbHJZSklKc2c4SVNjWlYyUkIxQnlBMTlzd2FRdXdGS3BiVkdoOXBpY3U0?=
 =?utf-8?B?b0hCQlJjcmJ0RjlaYXQ2bUtZY3BsUmJCeWU3SmY1emdVTjA5SHJLWmhhWXEw?=
 =?utf-8?B?UmkvdW1la2w2cStOT3pDOTFUQnhUSjhWVFJGd0NoRno5TFQxb2tRTC9Qb0w2?=
 =?utf-8?B?THI2ZTlYN2dzVjFsQ2VjRVh0N2JMdVhya1JtcEFzalo2Mk51YkN6MitDaVE4?=
 =?utf-8?B?YThmN3Z1RXNiRERSYzRBV1hqbElEcGJTQmpONkpwUUUyU3R6ZllVcUs1YkF1?=
 =?utf-8?B?U0RFZDRRbms0U2xndStEYWVYQUMxRjIvam50eGM3NVVGaExxVDRQMDNCUllv?=
 =?utf-8?B?YzVPcHVtT2s3UE1DQXpJUkJvWGh4YXMwSWJwREVRTnVncVRPRzYvdnpBaWxB?=
 =?utf-8?B?VmdpY1p0Z2VkS2hyQ2JscE1va2ZmWDFYQUJhRTVkaFNFcnFXYmhtTVcvT3BL?=
 =?utf-8?B?NVlFMkJDQU10TWFKN3RYeEVQY29CWGU1VTB0dmI2NjFpUU1kVmxQMG5lZ1JT?=
 =?utf-8?B?TzgrcVlxT1ZURlB4NDhDVlBoWDRrODZQUS9zQXd2eWl3Rk1kS2k4NWNxd1pW?=
 =?utf-8?B?QU9rdHRNazlNYXpGWnZSdkRxYUMyVExVa1UyMmVCWm1IOHBER0FVZEpneVkx?=
 =?utf-8?B?bUptUkVGNU4yTGQ0Vkh3blJldW9kcFVRVkw0UTlYYTRZTExhK2UzMzFQczlE?=
 =?utf-8?B?S04wVXgyeUpKTTQ3alZvajFZYm96N3BwakVPT3dhd0t0aE5jTmQwS25yVVRI?=
 =?utf-8?B?Qk5waG5vdGZoN2VmNEtjd1pIa2phbjJ4c2tVMkJaNC9USzgwamZ5YjdUM25Z?=
 =?utf-8?B?bjZPTTZTM0pQWU9nd1BoM3owbU9hdjF6VmJEUnZlVFJjNHBycktrN2d2eVJT?=
 =?utf-8?B?Smh6WmYxL2YzSUJGcmRtbUdBWUs0UHkwMkFiM0lxbkVqMHVZOVUzUFBHVkN0?=
 =?utf-8?B?MzNueWhFQTBYeXpZOUFramJhOUJqMEMzS3Q0M0VlWDJFUlZLWFVURTFSSEk3?=
 =?utf-8?B?MUk5Z2RYWGhSQ3dsRG5Sc2Zxc3FDZmMwdERDazFUcjFISVloRXhxZy9FeitL?=
 =?utf-8?B?WEF2M2dMd1gybGZSaE93ZXdwSEU1OEwyWWNSbS9tblhkdkFNWTZEdXA2dEJI?=
 =?utf-8?B?djdFbzUwQTJWTkRyZmpCbnBPdVZCUDJQUGc1bXNLME5iSmFvRzFFU2JUTldJ?=
 =?utf-8?B?T0d4T2dTSVJFYXhnem0waGl3R29GOVE1dmMzU0RDdUdJN055M2didC95aDU5?=
 =?utf-8?B?L2FDWjdGZ1JmQVdidVZSZDRuSFNYQUhaNEU1ZzRld1RQcXFZdUNBR0UrMXhN?=
 =?utf-8?B?ZTdWMFhBYzh2a3N0SVJvdUNFZ29RaWVQb0tyZmNaSTI3UEVDVjlCVjlGZnVn?=
 =?utf-8?B?bFhJYkorRCtBWk5hWTU5Mnp6L1VQajV0NHR0Mm1aM21LUmJrVjN0VElWaUM5?=
 =?utf-8?B?b0JCZzRIdHp2eVVST3FIby9wbjdKYy8wNkVkMEZaVU05OXVQNTRsdGwySi9m?=
 =?utf-8?B?RkJqcWp0c0ZYV3NXY0Y3WDgvT1J3UTFiSU8vZFl5UlhyMzlDSnpSTFZ2TWZB?=
 =?utf-8?B?TVNTdjZIU09ocmxrOWliaEEzcTBOTnlKRitibkVZZkFjUVZEM25hZGdRRVhX?=
 =?utf-8?B?a0RwcUVJQWlQWjJXU3ZlVXZneVM1Q2dERC9ya1Q3anFxcE5LbHljdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf8cff-8b88-4fcb-1f36-08de7f2a00b8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:52:31.3743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKf9R6JCLSZZMHZUMYPs3yPDBHNzDPvz+ZUv6qymGCb9V/+VAHg/B3i+Xgueuah5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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



On 11-Mar-26 2:11 AM, Chenglei Xie wrote:
> After GPU reset, the hardware queue is cleared and all pending fences
> are lost, but the fence writeback memory stays stale. If the driver
> keeps submitting to the KIQ ring during reset (e.g. HDP flush),
> sync_seq advances while writeback does not, so amdgpu_fence_emit_polling()
> waits for lost fences and hits -ETIMEDOUT, blocking further KIQ use.
> 
> Also, current logic on amdgpu_device_pre_asic_reset() skips force completion on
> rings without GPU scheduler(e.g KIQ)
> 
> v3: Use ring->fence_drv.initialized instead of amdgpu_ring_sched_ready()
> so that every ring with a fence driver(including KIQ) gets force_completion
> before reset in amdgpu_device_pre_asic_reset(), and after reinit in amdgpu_device_reset_sriov().
> That syncs writeback with sync_seq and avoids the timeout.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e1e9c824598f..2a8ff85ddb771 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4985,7 +4985,7 @@ static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
>   static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   				     struct amdgpu_reset_context *reset_context)
>   {
> -	int r;
> +	int i, r;
>   	struct amdgpu_hive_info *hive = NULL;
>   
>   	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
> @@ -5022,6 +5022,16 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> +	/* After reset and reinitialization, force completion on all rings to discard any lost fences sent during reset. */
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || !ring->fence_drv.initialized)
> +			continue;
> +
> +		amdgpu_fence_driver_force_completion(ring);
> +	}

As mentioned in the other comment, this should be done before reset. You 
need to trace why any submission request could happen afterwards when 
actual device reset is ongoing.

Also, you may wrap this around amdgpu_virt_* such that only kiq ring 
fences are forced to completion. The others should be covered with 
pre-reset.

> +
>   	hive = amdgpu_get_xgmi_hive(adev);
>   	/* Update PSP FW topology after reset */
>   	if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
> @@ -5238,14 +5248,13 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   
>   	amdgpu_fence_driver_isr_toggle(adev, true);
>   
> -	/* block all schedulers and reset given job's ring */
> +	/* Force completion on all rings with fence driver so pending fences are signalled and writeback is synced before reset. */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
>   
> -		if (!amdgpu_ring_sched_ready(ring))
> +		if (!ring || !ring->fence_drv.initialized)
>   			continue;

Not expecting any change in this sequence.

Thanks,
Lijo

>   
> -		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
>   

