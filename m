Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC88BC43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A76A10EDFB;
	Tue,  7 Jul 2026 15:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BMAyHLmB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4937D10EDFB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk0mNQGsIFRTx3sA3Hj9vzlL2rKwmqNuzFj18FfmQy11OfEqIgzJvl4EiXgLRtrFRUPCkSpPTpb4EtSJmzaPkV+CnzlVrW79QeqYacjm/DsBzPItupYfCzZhQ2j4ypk+52nGeKeLZ6KYPYRMbjJDoH4JSbHZJ1Bv4paJByhtUDCN41PZUuM4HjRQ0+B6DoBwHBEROqBK5ODNo3C1TD6E5MaMdZ1k8Iq2JS+MMJnS68sHxYVTXa/HC4et4ifLeOxJty2mlyHWPvIyDumaHuZkYgxRhg6C/PWsvB0Jz7Bm6kBPw0+5ALjn3ZaLJVGtvQrLSCS3Gm4+lc4TqSDpMfAJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETnGBVDzmgXp7B9I0gKAxdPa9EEgFTwzSIM54YqAVTo=;
 b=B6JmOfsnwcOIis/BBL+EWr/nhHG7IDjrY76q90RxEwnoHw9xKvkMm8kQNnsFtRxTgvSB4hI2mTAQ1/RsL07PPeiiEw+RmEZ1/stupiFY2U2tq4DrKv/LbmebM8RlvacjwPAVo1JxGa6VOEEVCxxq+Q8ozrsjzfMxaHyJM9duHf7+T4v5IOeYGa5csV2d9f+IWHqH3wygIEhQJyK7nIaQdrbCXThuTsCvB+c/JjuepvZdgv71nd4t2X0Ogsh16Sota7SBXqVTt2J4g+71LLYDY4YpPcacs94YM2diFUFTp6IeqeDQAY9nBZioBEYz/b+jQduuP/MdczyCn1Dh39vtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETnGBVDzmgXp7B9I0gKAxdPa9EEgFTwzSIM54YqAVTo=;
 b=BMAyHLmB7uD5sKDgGynZpBZPkRAoNQY3o6WeQc9/2a6j/k189WfgcOZDpXsB1Fysmv5/F7D8OmS1RHgnaSl367gDYEB5hLQjw38W8WAdfO3bXivAALyROBQPPhgmyz5oih5DrsyO3Fwl9K7Fmy2noP6kFqB5W6dbAuTBjwXGISk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:33:57 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 15:33:57 +0000
Message-ID: <4730132e-8bd0-44c3-b639-3fb9e7f3c86f@amd.com>
Date: Tue, 7 Jul 2026 21:03:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: disallow gfxoff around gfx/compute/sdma
 KQ reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
 <20260707143420.2104857-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260707143420.2104857-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: f3772955-6483-45b1-82ff-08dedc3d288c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: aMI/UhAxIUBjLJ+/I4YNtR6f/cLHEBWbiNvsaSahYGYEtVZ90Mza7qXkmIwhI5lVaStoFahzGvd4SUW82QiRl868IEufPJ8tuWQhah4GDAlre/C4hj7pngB53eXJ+f4yqEDa3G+dwYFRqgS80QLLEWRG0x8Y9UJYrY3J6REYtwjEz5SYk9MMO//oLRO54B024sA61Cv8Eg7C4J/2gSWYQDcDvYooZa4v+17wfxHfX84oROETV9SRkDnM0B592U3s6TNvyc3WUxB5EYGZNyNDDT6TzFfpECqfrypOSQAzdEC7a0TjZrDKVvd7ZfplfpQJmNq5/eezh23eR68rDQxCKItH2pDyUOXdPHH7LtMGJgkrOPjyirixrC14UWp3haX/L+9Pj3aLryjAuNVTsqAUr902C51JzFaYJCi5/xa7rH0GEJgknoMVygr/rhI+DJEW9TQPpS1/CBmmX/DO9R0FS2juYwE4beJz6+bcdgGOqH9Eb27n1FqX9qpte7qzM+pDWUcOXcZqc2obdY+itZTCeycmOGaUtvFJR3y6pK/ABTs4poiIlIr3a3XyL9uu2ppSTiiHqIJa31bIN8g8eO2oGG4HVS2rcWVJCX8rCvWpnAWn+BAWT5AvD7x01w5OYl0YJltBK2EglQrm1oLcjiMmR+uHMH2eSrqyDHhKHDCA3BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJjdExZL1FqMFJFWnJMTlJIenRrTjVIYWg1NE5WcSt6S2hpNWNJKzFmK0Jh?=
 =?utf-8?B?QWdoN3VYc2kvVS9GTk5FS25sYnMxd3BKRjFYRDd5em1GQWFtaUxrVTJGZjQw?=
 =?utf-8?B?VzZDSUU5K2Y2TVlOM2k4cFlTVFp0Z1UrdzdEVnJiSTgzRHRzNFNiKzFRRVJC?=
 =?utf-8?B?bUE5MU1LOUd2aitiMFA3YVJHRFlPbFNxUk5XR21HMVc1cjdQZGx6SXJmNTEz?=
 =?utf-8?B?RGpYU0J2ZHI5Z1lMZ1lJU1ZhS3B4TUhpbk9wY3RZdEVkT2JTQTVwN1dDVG14?=
 =?utf-8?B?Z1EzNTNRYlR1QmduVkVhV3huNXZBQ3F0ZE8rUHRFZlVJbm5jd0dhNFRsL2hG?=
 =?utf-8?B?dkI3bWNJOERjejhNRTdvNzZYcWtCd0xneVNGRjFodmlpTVVRRFBNNGFscSty?=
 =?utf-8?B?UmtScXNueTVQWWI2SHFoVlRoWmM2MDFNWkJLbTlxTWdydkN3UkdWL0pDL3Ar?=
 =?utf-8?B?OWdnMDdNbUV2YVJzTVJZRkNpS1JQSnRGaEdkWU9TOEYwRUZUM0F5d0pheDZG?=
 =?utf-8?B?cjJpUDNkSXBuTjN2QmFBOUNLKy9wNEtrYVB5S3ljQWpGdXEvM0hCcGxRMllE?=
 =?utf-8?B?OVorejZtaWhhcUNBU1lxSk80VENTUXFtbVptRHFQSUlpbGgxRlhqWWZNY1hJ?=
 =?utf-8?B?Z3AzN0Fka1NMN3NUZlRGQmJ1dlRNaCtSWUxkV3F1WUFBRnJaSWJLYlR5eUJw?=
 =?utf-8?B?SlQ3dVFvVnhxRFFZTlJrSnJaTFVZYStFR2dBeERyd1ZSajRrUHFUNWNQdlFa?=
 =?utf-8?B?WVN2THlqb2xKYnFwL0VIeVdRMTdLNUtZYjM5SmxQdno2RmRIUjh2Ymd6MmZX?=
 =?utf-8?B?WTRwY0d4RldQOVBoVnNPTjZhaVhpRnZMQytjdXkzS1ZkUmUvbkxUd2pxK2Rx?=
 =?utf-8?B?VkNicEJCOHhGVWlpYklOVWRoRndOMlFWS0NabGZSclhZeTZJRmMxbko3NGto?=
 =?utf-8?B?cERUM05iOUxVS1BlNU1Ib2JGRERjYTUvclpwSTRtS2ZsUW9DTllYbUx6U1Y4?=
 =?utf-8?B?U3pJTXFVQVhIZER3VnFSSDVDT3FPMHJpMk1qTEwrVitEYlpRR1hhbU54MXgv?=
 =?utf-8?B?ZW9ncjRmUUR6L2hUMnlEWFRhQm1DUUhXaFM1RVJYZjNhK0lLSWE1UlpKSG5a?=
 =?utf-8?B?TnFVNXJ3TU1CYUpneU1yVWFMZXNKSUVqb1IrWlJkN3BBK3FDWlJQZ1NTaXZi?=
 =?utf-8?B?NGJDZExnNVhoSys5YVlLRVhVQXZBeWhaUzA5WVFNa1dMa0FYakVLQXVMbFpB?=
 =?utf-8?B?SmRKR2dFeHRUamFrYVFkVDJXaTlybm4vVTJDcjkzZHpUNVZiSjkvakhKNU9Y?=
 =?utf-8?B?bVpkK0o0UGFZeERMdVdyQXppK3h2NExtOGJJQWJpODc0d2YvdmJ2R2RCMVo2?=
 =?utf-8?B?STlNMlRZd2h2VEJuUDVxZkFtZTRmYlEwMktkVEs1MmFJb0UyYnVveWIvK0dO?=
 =?utf-8?B?djhXNEZqTmhWZGpQcFNqaFo0bDJQNi9pdmszbjFub0RFRldQRmF3WWdtVmht?=
 =?utf-8?B?TlRtb2tWSmlRMVZuNGVEaGpPelpqSTNUR1Y2ak9zSmVIYmJyRDlmaWZTZ1dh?=
 =?utf-8?B?UUluTGduaW9LUUFVTXMzQ0tFanRtWkZJbDRXR0JKcFNEVVlIdGVEYVViY0Q2?=
 =?utf-8?B?cmhDaHdKWEtldU1NT0VkUlhBZlc3aTdkTWdzMmFxemtJYVFDVFlUTWh0VGpt?=
 =?utf-8?B?UFNSNEoyMmd1em5McEt2NEJqWndqaWVlcWx2aXpzb1RKbEg3YmxRRzFEOE9I?=
 =?utf-8?B?bVEvK2ppSCs0cDQwQndyQ25GMmxDQ2VEOEpmbExOb0YzU3AramlJazRqVThv?=
 =?utf-8?B?bHEwUGRRWFE0VnVURlFGaXJXRWJRNEVLS1BCYStVMnRTc0tGT1grMzBIMW9U?=
 =?utf-8?B?cnVUVmxVVlVmcGIxSnJQWlpTMGx4Qm56VlM4ckJ6TUVDY281SEk4UjJpVkk1?=
 =?utf-8?B?Q1NkTDVmWFdzOXdwc0RwRzNmVFg5bjNreFVWSUVwKzdOZStaRFRBOXVUMm9a?=
 =?utf-8?B?SG8zOE5DNC9rd1BGREE3eWtiK2x1d1ROMUJJeFlza2FIZXJSZHBWT2xZL2JS?=
 =?utf-8?B?ZkYxZzFWVWU5aUI1emhOUGRveU50TSt2bTR5Y0dFaW41VlV1RTZ0d2VBdUJo?=
 =?utf-8?B?VXpTdHdRS3JMc2NBVkhjU2tsQUNnQ2t1bXlhOUZXcFlLZjJPTzQzeTlsdTVB?=
 =?utf-8?B?RUxQT05nZVphUU10NDBzUHdEUXdreUVNc3RNbEFqeS9zbnRmSTByeFlDN3lV?=
 =?utf-8?B?UzRER2pMNWg0V3RILzFlK2tkdFZhZkYyZGUrRlp1SDFjcS9yWVZ3cGozdHJ5?=
 =?utf-8?B?alp6ZlpMMC9tRlNaS0d4V2FhNGdxUTQ1dkNTeGlPcTI5STMyZnZodz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3772955-6483-45b1-82ff-08dedc3d288c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:33:57.1879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Q5NG76Lmvc+nj6XNc2C1Wl+o0lLG/LMXQ9C8EzLv/djWl9AuP/wiE9X3ptud9Ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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



On 07-Jul-26 8:04 PM, Alex Deucher wrote:
> If the engine is hung, we shouldn't need this since it won't be
> powered down, but we could potentially have a case where
> a queue can be preempted, but due to logic errors in the commands,
> the fence never signals.  The engine could potentially go into
> the off state.  Protect against that.

On a second thought, is this a real case? If engine already goes to off 
state, wouldn't everything be reset by default once it comes back?

Thanks,
Lijo

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index b5c2d1d4d8839..c8a1aa88a9de0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -137,7 +137,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   			s_job->sched->name);
>   		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
>   		drm_sched_wqueue_stop(&ring->sched);
> +		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_SDMA)
> +			amdgpu_gfx_off_ctrl(adev, false);
>   		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
> +		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_SDMA)
> +			amdgpu_gfx_off_ctrl(adev, true);
>   		if (!r) {
>   			/* Start the scheduler again */
>   			drm_sched_wqueue_start(&ring->sched);

