Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253E0CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 08:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF03910E924;
	Tue, 16 Jun 2026 08:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RgvmP3s3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD7B10E952
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i67BEfTgNGsq09TkSKBErICVT7NkRUN0Tt+CsSdK90HHfog/cHQAoafvMEajpkhQ72BoDieFVjbCxjyCjFQPfk3LOKQaEB/Mp25R/Zg4OhD0vnCAHTJH9rKYC+AU8siSsrAVWROkhW6k6eNZO3BNxZ1w0zu3pfL2kVtPQu6bHyHzK8DxWduk7FfOve9ltuRRLjLlrn/afvAYS02fLlyW7Bw8jHvIxGGBApgMxwYfRk63yhkPMmKiz51Zm4fi7gouBf+GHD5chGDf3AIajUrgvXu/IK+RM+wbX8aB2s+yzqrbTaxEwmraOv5GG3jC5W8jTVzM+Oeg3bK4PaS9gE7J4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dtHXwRA3HpZ84oKInUpDBMq0tx5aHeRiccE37t3d4E=;
 b=WqPpxdDyxrRcZQGIh8iyiEZvfvCNGJgGy98ihcxtGnbcLhF7hM1z2dFnEjzF0B4Qw+NKj6JxN4TaVDWOMkpjFDgrgzZbBVKxvvY4+eGJCoVea6SWVqW3FkfBGPc06V9ohSDLmpbJC1Y45ozPxL1Jc9pBTh4l01/yaLxPBE5wzDMYsaV35s6xVSKltaWPwg/JgNrlBpVdr1Q+BSAayM0Kj/oM3DUDyvhoxuiK9IRMiIt9sSG5OqPCWgSJyyNKKj8FyI/C5A4OkRBG2KB/kS1zMpFOCoHRLtvpTTYdIEa1mI8KWtfudjgf7nHikieplFIcf1nCrJgC2EtoRRE21YvQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dtHXwRA3HpZ84oKInUpDBMq0tx5aHeRiccE37t3d4E=;
 b=RgvmP3s3th8119AuLT82qAcQQWwC9Vxq8tA4ibqI+GmihegpFB8ASHz3ERZDJqXG2WEIfy629cwXsp4a5sC9pdixLBNz+KeP5k5mbvKkbi8qiSp/H8ngCRgqa10zX4df9wMalkCmeQYaype+chpwoa5PzVF04aExy9kvd/ZMAsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 16 Jun
 2026 08:58:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 08:58:21 +0000
Message-ID: <205b3f8f-8381-4c7a-80b0-e13e56165c6b@amd.com>
Date: Tue, 16 Jun 2026 10:58:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612055226.2879270-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: fba02a69-98b5-4d60-798b-08decb856ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8AV4elg4o2epFB1tROsqesQCKHs74IDO8ZMO5v+OmRnBayD7CS0IcDRrtF6UDyQT9aPgXKefKeqyqoPmVj/iAhZF7CP53qmc/xhmZzCkSB4g9ayTjAZVsd5+fw8dDr24xjHsMAcrHaqpWTCtM576uhYyWdOqU7ITJx3acd2Sl73YSjQwSXZCfBnYYxKptP6+cGDdqoL++z4fD12WVgMU+cd/FijSBsr2YKOOTg9NOEZdc5kKdkJy0qKE0mzL1DiKdzymerP2ZxUTh7kVD8Ad27LV35R3T/1bTD/EIMtp9/BDhHY2j75a93Rqk+Z5HXCqqSxQBrBs+VIeWxUEAvRi8q8qwpEGirxHOuV8T+PzXIbbHsRdnxO2jM9v/hMT1Cw22K6fGdp0mp7PNplY1i+2/LTb35P5Vq4sFBd3WfODi8TC7+ROIWgDFkRg2dsJvRyAg1u6Fb3rGjvZl/Dz6pIIIz9CObsSKJ67B6qH12MVqhwnSlDP0hriNiMhClILT0oOYN7PWdRKkPi7mcH5kXM89R1XGXNv3f0iDlaU2hswiKfEuzzdYwDSGAhp+9d09zwo8pHYGpAQdnWEet2CJ7Eh6RgGFwl8P8q2l76pD/AezEmxY1NMJ7vit9IkUhhVzvKlsuEHwfvr04VfneEYA2evbTkNKgGTS2ehKMe32UMlzDBnJW3mOkDX1EKjB9nWJJZJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBERTd3QXM2U0NibkRMeThPa3lvYVEwK3M1c05Mem9LandURlU5R0gyTUww?=
 =?utf-8?B?a1hiYndqVkE1dGZ2aStxVldSeVFCVUFXWVYwb1dWZ0pybmtjZnU3ZytNZU1h?=
 =?utf-8?B?TlBPUDhaRUZzOHZqYkR4dXRsOHRBNDlUZzc5ZGRpL1YzREYvQm5oSEpiS1lK?=
 =?utf-8?B?Y2hwT09ycU5hMDl3OHFNei9TSHVxOFBVRkprYVhvSzk2bUVpclI4QUk5MlRP?=
 =?utf-8?B?NlczZ21JNjhUQU95VXAxODN3ZFFCcnN6NmRSUVBUc1FOZnE5dk92aEROSCtr?=
 =?utf-8?B?SThHNmFmeWw3Y1ZSU0dtYXM5a3ZyY2phbFl1STRQeVRCUDdWaUFuTlhhOXk0?=
 =?utf-8?B?dXhFWThZcHlmNHJQRnVNUmR1eHhNVXplTTJmUzlzNUp4VW9xVC9Cdi92QTJK?=
 =?utf-8?B?QjZqN0dIQnJnWXJEQVVVdmxyTDRvVGFpWWc3U0VrY3UzYytKS1pnT0hEbGty?=
 =?utf-8?B?RCtzOFJ2ZWNVQzQraVorTUdqNmZNeERHYTcwTHdCUDFqbXJrOWxYa1lISkRq?=
 =?utf-8?B?N3d0Ky9pUnFPbTNGaVQ4eDRyY25mR2hkckk5OTlaZ2tzRFZhbVAvSGRYZzhX?=
 =?utf-8?B?SkNrQWNjWE55cVdOc0xiOFdaSHc4Rk02cUFhdDEreGd3U2ZlVEJlek1jODhJ?=
 =?utf-8?B?OHlvcXpVMVFsRWd0bU1GWnRjOUV6dDZ2L2JlMXhjYkhzQTlNalZNYUp4WXRJ?=
 =?utf-8?B?YUl2Y2Z2cjBUTFhMYzQ0aUd5MlRHanJKZm05TElBblBoZG1KRzFYemRkcEt3?=
 =?utf-8?B?TFhMbjNxeXBxNVNUQzlzQmI2Zi82TnZ4K095MEl6RmNWR3lRZ1FhZGZmbmNS?=
 =?utf-8?B?dmZ2L0RsU1RkS1VPVEhxMTVYZUxheFNsUE15Z1Vsamt6bEtKRWZxdThYOXBL?=
 =?utf-8?B?RG8xM0o2bHFXbE8wbEt1QzVZM1FjUktIT3Q2L1BUUXFSdTZBZlFrekluUjJ4?=
 =?utf-8?B?YXNlazVRdFBnYTlTZFBwcDBDNjhZK0Z0TlNlNXBIalFFQTc3bStiSXZLTWJx?=
 =?utf-8?B?RU5oUmFtczRHRitGTE9mYVgyRXU4REhCYzdsOTlMNGFlNGsxRmorN2JYTnda?=
 =?utf-8?B?elBXYjI5V1VHNGN4S2ZJbWtmem1oQll4RVAzUmlJc0Z3ZjdjdVFDVThkZ2pX?=
 =?utf-8?B?OVpURG1WRjFoWDkwejdBQTROSythcUlsdy9lZDVjcFZKbHlYaG15UCszWGhp?=
 =?utf-8?B?Z0srT2NaN3JKUnNOQkJ5NGVwTEhGTU9UZU1lUkZzdFFmMjhEYlJ0cktHNWFD?=
 =?utf-8?B?My9WUnl1dzIxWEk2c0o1MTRjU2RSdEJZOFcwMGNLL2xBSmFsOXZUamt6WnNm?=
 =?utf-8?B?QzE0aTZiQUZtSnAvZktrRjBJL1d5RHJ5dmpNU2I5L0FyWHBwamN0R1BuTFN3?=
 =?utf-8?B?ekYyVVozcWN3NXlKeHVrUFFPQWU5Mm5ndmNUSTRDQ1p6eDB4dUFNdHlKd1JJ?=
 =?utf-8?B?L3ZrSmpYSVZzeURWeGdac2hibkVtaGtsZUd4L09yWjRRckFvL2VjdkJKQ2R2?=
 =?utf-8?B?YTlkbEFnZ0pyT1Fia1o5bTRlUXVaWFNEZ294bjE2MHJsbUF4SHlaRWFrend5?=
 =?utf-8?B?WnpQUytGSUlzTVl4UFlMMHZJcHdHSXRpZkZEZEg1ZGczQ0FuaW9kcWRkb3ZQ?=
 =?utf-8?B?LytlN1p4WnlSWnZPRFNveU82M1k2eFlTaitkRjhkZWc2N1JyVDVobEMzYUt2?=
 =?utf-8?B?Z3N2S1pWZTBpMGJwSE9DWC9FQVBMR1MvdWsrYkIyYzN2NldJb0t3a3BDRGh1?=
 =?utf-8?B?d21sTE9UY2U0MldmODZpWExHeHcxNDc0UnkyaVNNNHhRTmVSY3l0Uzg5RXBT?=
 =?utf-8?B?em5pcDhPVFpIcko4N3p1cWt6dHdqMm9FK0tpVy9kemtzOS9OSGFBRzBvakxq?=
 =?utf-8?B?ZFgyS2V0allDRlhlZTB5NUVtQ1hVZElkbVlnSEZTYzRVbHZGMHBrZDdjVENT?=
 =?utf-8?B?UXpTVU5lWXBCU3NVajdrVzZ3dVVsMlgrTnhaeUV0Ujg5YXozaklTWFpBLytr?=
 =?utf-8?B?d0NTVEUzQlZ3c3VYS0psRDZOd2J2U1p4THVtb2k0UjdxZDJtNFJhMFBZeVF6?=
 =?utf-8?B?L3JUMkluZXM1bVhidGxHY3pxNEIwUlFMQmF6Vlg2dUJ6THE4bnFtV2FDdnU1?=
 =?utf-8?B?d3g4RkRxT3NJZm16MW9sczNsUkJRVEQ1NWYraDlMQWkwdnZPQU5reElYVkF3?=
 =?utf-8?B?MHRwZW9FMjl1SzI5VFh6aEtseHM0em9zWFRDVXdLRWxvaXZaZHRJVUZ3c1li?=
 =?utf-8?B?MEg2QXR4TEZzVDBUZzVScGNoYTJXR0xjYi9FTE4xTE5ETVlWZUdRN3JISEx5?=
 =?utf-8?Q?l0urBe0AFp6fTCcCYr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba02a69-98b5-4d60-798b-08decb856ab8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:58:21.7203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDZXxJkRW4eDMiN2WJtMUHeq8qIQfBrg61bAlsT4bB3gb5KHT4ijUMTDZ6/su7xe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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



On 6/12/26 07:52, Srinivasan Shanmugam wrote:
> Signal QUEUE_RESET EVENTFD subscriptions when hung user queues are
> detected.
> 
> The queue reset path already identifies the affected user queues. Use
> those queue objects to wake up the matching EVENTFD subscribers.
> 
> EVENTFD remains notification-only.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e9189f07c6dc..ee8dbd70e1c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -238,7 +238,16 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  			if (queue->queue_type == queue_type) {
>  				for (i = 0; i < hung_db_num; i++) {
>  					if (queue->doorbell_index == db_array[i]) {

That code is extremely questionable to begin with.

My suggestion is to clean that up first and add a function in amdgpu_userq.c which gets the doorbell index and does the necessary handling.

E.g. actually lock the doorbell XA, lookup the queue and then do the right handling.

Regards,
Christian.


> +						struct amdgpu_eventfd_mgr *eventfd_mgr;
> +
>  						queue->state = AMDGPU_USERQ_STATE_HUNG;
> +
> +						eventfd_mgr =
> +							amdgpu_userq_eventfd_mgr(queue->userq_mgr);
> +						amdgpu_eventfd_signal(eventfd_mgr,
> +								      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
> +								      queue);
> +
>  						found_hung_queue = true;
>  						atomic_inc(&adev->gpu_reset_counter);
>  						amdgpu_userq_fence_driver_force_completion(queue);

