Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FD2C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 11:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0A510E4AB;
	Tue,  7 Jul 2026 11:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAE6WSKg";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB61510E498
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 11:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPXbHBRP24Ms8VbIKdtDf1mNKQ/8virinx0L3jcG7R2QOoJDOf1MwcRuUqrr1QKbe+6H0lfblps6NHZhw3C4DNQjRuStWnJ0XZgz0qUgNQ6xBpzPXNk00Csq0CSTNYMzQLRAtLMGw6jPIRnmzg9Cc4W3x3dhxIYs75HLejZu+PuOFEi7k/MkB7sELMOlxAZGbE+DqGVXdb3zb/fRcYBdMtaUWRnU2NhbAOMl4S3laTDl+4cFg+2HjJSmSMxM19nXN1UbmVuOxEYIfOo6rc6sjPQQ2J0fmWCVUM/d4lWXblDlslo2xtYl3vekQnBeJCLMDXp/CJ+ZjP0M8th+D1oz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8NQWwYdM578izTgDZz0a0e05Sv/iZiIFCULzJIL7Vg=;
 b=rdqj+Z7maI9W2FtH5gxrDeUez3sJndOPFoPLZxKFST9oXk1Xm6xaAY2NCq+ZBT/54sCEC4HY+ov/7RtfChuXhNtF4iPldJ3tnywbLlTEbYpnuWm+6ay/DuoJndRa/HlKz0hcTD66oas30xHFo1dUIQWYbzzpycCzeGo4V3b9i1tvZTO2xP2Q2NYb2oSCaY4q1yiUJlMeTF/U9zAPJRwfsCwN7Guu/6FoAXXlQ4FEwWXGM9Z3RcujNCK5fnh2vy2bMJVngUD7Hg6UDrSol77z1hPpWhlXV1pecrSdLevdtx7/K3oxLzxbyye0q+rw8nB6avsyfD1J+Y3qVUaPvaSHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8NQWwYdM578izTgDZz0a0e05Sv/iZiIFCULzJIL7Vg=;
 b=AAE6WSKgunAotecCmwD0VnC0uGlA49XuxCGem9dxyd5bRiW4NU2Q4a9kobzrig/Pw7w9zwL3LrXDRyILmII8TVwTzc7vvHcIePt7KFHL8quinRSMK4d8vPmNgD1Tb8R3oTfUd0mQFcDUWWUBqI5Dmd8oXSpqaR5sso/+QeezQiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 11:38:45 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:38:44 +0000
Message-ID: <6513b774-2d75-4819-b76c-20c6447705f2@amd.com>
Date: Tue, 7 Jul 2026 17:08:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu/gfx10: disallow gfxoff around GPU reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260706200600.15071-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260706200600.15071-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: b50c3264-6aca-4724-b167-08dedc1c4cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7Tj9Jhj50FiuI+4E8zdQLGha5mnuVIPZ938HqoRR5Jf886KK3eGKYUL1cKTedAOqatE8O2i5xXzlDlM67k/1h8IEPgH97A9SDeXOs800zKbcMmDqU96jOAelxvHoxC1kzFLo2BDLEaQ8Sd7Q/gKHbpTnKpjSsgJWzve7zK/DocE2P2rCawD6zBVWfCacXwFh192K9YkDl3foHq2vXghCP6rHkuBQ6UNscxCFzW9Cq5sQEvBaiQP+n+DYrUHJYBZgjbm9kcbdI2dNdPfouMAs+h1XW37jokBuQNiSEnurfrA3oAhOG9JXds6Q9ei6W1Rk9+hN52rBiRD6nXzvYU8lManbthkTd/FZE03ujkVV13a3goLw6n4scNPHFMKF/AvoSCqc03LBK2aGsPyYI7UxUaN3GhG5K/YRQtYPoxLoVFWuAXzN6dfygz4aoViAR+gutNcN1xO4rKsQkeyTw6WMowz5Uk/RrqwJp2snYRwMzi1iXmzqvfccjGVuPOwD4FaWAnHXzYA2fY1vnEUijHyB1dNZX3e/G/ooeug50F/gF6ewZIVan5tgCSXNz8wkvZGFiSKpCDufli8YfsXXydISXHokP72zixCZ6HMG8hN3C1rC1mc37+qHjg5xVxgF9Hg3rXoHOram2bSBsAEPi6EfMmJI9a91/GXAwPUJEDNiuYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEYzY0d5bnNVVnVPYmRCWWJQS21LZCtjRGpyQmxuYzhGeUJZR0VhNDB5MnRp?=
 =?utf-8?B?NjBMQVRQWW43dkk0LzlCTUUrVFptQkNhM0w1SjUralJMVXlHaXBVb29IaGtM?=
 =?utf-8?B?SjVkVEFyUnFYdk16M0xZdk4ydWRaYUZvYkRBRVJ4RjZXdmdkVkRGMmxFdlRK?=
 =?utf-8?B?K3ZLZGl0Zk5mM0ppVDI0OCs3bkV6OFlFbzl6SU1SVW1KczVXZFlNcHY1eDY4?=
 =?utf-8?B?dzBNRHllZmo1WWNUNjd5aS90aWVEVVNjVmpoZlJwRkIvWG0zcnl2VVpXbHpR?=
 =?utf-8?B?Mzg2QjFLMVpPakczbTh1R0w4K3FUaGdKdVY0cmJRK0tWMHB0cW5sWmhWUmdS?=
 =?utf-8?B?TDFCN2tXUlV0VGgyM2huU2cxNHljSG5sRU9teUZacWhvVms2UUNIZkthOEZr?=
 =?utf-8?B?VjllZTJVZWYxczdVZ2VxYng3VURkQW01bm94Nk5ZdjFWR3R6VGtzYTVwMk5k?=
 =?utf-8?B?ekNZWmdObkFxNmZOcXFXRlN3UkphcTBSMUdBSXNkdzdqalpkM29OYWVCZFFy?=
 =?utf-8?B?enIzUnk2ejVlWUN2YVd3ZHhVZ1FiYmh5d2dLbE5FMlIrakpBN2pyTUQyenVO?=
 =?utf-8?B?dHRqTzNLWTUvay9Sa0JKVnBoTm93Q2JmMFp5SFczdjd2YUF1eXlyODNvbmo1?=
 =?utf-8?B?QlhjMzBCNjFoMjZ2REptTnQvT29HOHVCSStKQkhkNVArT3pGNEp2b0NaRG5w?=
 =?utf-8?B?OVJTWWVIN2R1NFpQNnBBK2R0WlZmL1p5V2QrenovSk51dEc0ZncvSHRyUlVa?=
 =?utf-8?B?QlZjWS9RUVM3Z0xrOEhwZXNLN3hlNUd5VnorZnU4UUQ2V2NOVWpwRy9RalEx?=
 =?utf-8?B?ZmZsak9NN2k5akpsaDdQYWlUbEhmVVhRamZPSUVEK1Z1WitkSDR0Nnh2RzlF?=
 =?utf-8?B?SWRaQXMwWXYzczVld3RiZzlReEJOWGdzRlFId1IyTFZMZVNnMXlIRkw2anBl?=
 =?utf-8?B?cjR1SE9ZOUhwSzNlOGpnck1qb054blFlQUdGaVVUTjl3TzJvcVhrSWFwcW1Q?=
 =?utf-8?B?S0w0bXVOYTduKzRrOGdpTzIxMktwMXlJZVY2eW5SekRST1kwVk0zNWtydDJx?=
 =?utf-8?B?Ny9tcTQyRXlCeUFkaFE2Z3hDdWtuS3NhS25Ua0JDYW9EYVFqcG9sSzJDWExq?=
 =?utf-8?B?WkVpdlJnWHF6b0szSW1uVjJHT0tNSDA1a3ZRbGZ1Z2t3UER4QzQrMkhsenFn?=
 =?utf-8?B?cFl3VmNZWXBiZzQ0RTFVb0JzSWc0UHM1OVJPYlFrdmxWaDU3NDFueHpkMkV6?=
 =?utf-8?B?R0l3SFM1ME1GVXRjdytxUHZpc2E0OTRVelN3SnJxdlRUNlBQNldtNDB3clJ3?=
 =?utf-8?B?NnhhSk5sMjBYN0VyZlRCZXUvYXlEVndmSjhMKzdLN1E1UmZ0b2tadG8vVVZs?=
 =?utf-8?B?K09MQWJJaUcxcmI2amVyeFhpM25FQVExMFZ3NXorTHpmQkhyYzBFcHhHV2lC?=
 =?utf-8?B?N2NUMFBJK0tzVmtIT2xmVlNycmtQRmlueldmakZkdkFIb1JyblFrZndLZmxE?=
 =?utf-8?B?V05KRUllVTh3c21WV2doUFNoNmZMb0dkamdkZ3dTVzZVc21CbEFRUWc0d3hU?=
 =?utf-8?B?bmlCUjlqS3VSQ3RQRmVlajdUeU5XQmdXRGtDVXpWUmF5N29oQi9CSElYT1ZL?=
 =?utf-8?B?S1Vla3lCTmpXd21JM0thRTF2S3RPRzFKa3NiVDhybDJvSHFER3VqYUcwUFV3?=
 =?utf-8?B?RXhmV1lJcDBLQURxUk52NmdYbmJVYjFSamFKRG1KU3o1REdNSTdHOTNON2FO?=
 =?utf-8?B?WWV6T3FkS1NlS1JIaGluL1pZM0gzeGZ4TzZmd0ZWMURkWnlLVVdpTW9pSnVH?=
 =?utf-8?B?ZFBRRVBURktCdVA4Rm53bFljTlJ3elFvcEFIRjhORitndEowY1hEdHlRWW52?=
 =?utf-8?B?SnBEQldSNThHZVNlbUJUZjRIQzZiV3dQVUYvYVM0c3MxZnVVNDZDSldZSUtp?=
 =?utf-8?B?QXZnNDViUmRtRGg5bHNXTjJSK0FzbVhvVHRjSmpmOU9KS2Q4T0J3UjVrNm9O?=
 =?utf-8?B?NStQdTd6eFZsRFlVU1NWUmNZZ0ppQVJ1Vzg5VFNaTXgxamRBYWowMG0yTHUr?=
 =?utf-8?B?NnE1Z0dmL3VuV3VnQlJRTjdlZXRYM0VDbUFyUko0YWJDWGErcHJ6Q042ekg3?=
 =?utf-8?B?OVBwT1liTkpZN2J1RUtDYnIxN2lnZi9LREJsVkZCVTh4NjJLZm5ONXVHTExy?=
 =?utf-8?B?ck55YnVZVEpOclJjUnRiNG5JQll2UEI1eDJheU5RTExlSm5yWWd2dyt0N2I3?=
 =?utf-8?B?KzlDNDRGTHN4WTRmQzdjSDJFMkxwbW83aERMSGo0em5hdGJMTm91U0Eyd0F1?=
 =?utf-8?B?clJGS0MxekYxaEhqcUIzYUhUMVNMVyt1RjZlS1ZZU3dXREhLQnJBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50c3264-6aca-4724-b167-08dedc1c4cfc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:38:44.3938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vSzu5wgOS0E6SalsImYe/OdMXb6V2VzxASDZL2KmVLrHYEvKKa6I7FPVM4kwT31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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



On 07-Jul-26 1:35 AM, Alex Deucher wrote:
> If gfx is hung, we shouldn't need this since gfx won't be
> powered down, but we could potentially have a case where
> a queue can be preempted, but due logic errors in the commands,
> the fence never signals.  GFX could potentially go into
> the off state.  Protect against that.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 +++++++++++++++++---------
>   1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index f03cbf358cd7b..516a621d11faa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9528,6 +9528,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>   		return -ENOMEM;
>   	}
>   
> +	amdgpu_gfx_off_ctrl(adev, false);

Can this be moved to helper begin/end logic - check against 
sdma/compute/gfx rings? It doesn't harm to include sdma even for SOCs 
where it's outside of GFX domain.

Thanks,
Lijo


>   	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
>   		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
>   	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
> @@ -9547,28 +9548,33 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>   	r = amdgpu_ring_test_ring(kiq_ring);
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   	if (r)
> -		return r;
> +		goto fail;
>   
>   	r = gfx_v10_0_kgq_init_queue(ring, true);
>   	if (r) {
>   		DRM_ERROR("fail to init kgq\n");
> -		return r;
> +		goto fail;
>   	}
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
>   
>   	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
>   		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto fail;
>   	}
>   	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>   	amdgpu_ring_commit(kiq_ring);
>   	r = amdgpu_ring_test_ring(kiq_ring);
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   	if (r)
> -		return r;
> +		goto fail;
>   
> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +
> +fail:
> +	amdgpu_gfx_off_ctrl(adev, true);
> +	return r;
>   }
>   
>   static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -9593,13 +9599,14 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>   		return -ENOMEM;
>   	}
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
>   	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
>   				   0, 0);
>   	amdgpu_ring_commit(kiq_ring);
>   	r = amdgpu_ring_test_ring(kiq_ring);
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   	if (r)
> -		return r;
> +		goto fail;
>   
>   	/* make sure dequeue is complete*/
>   	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> @@ -9617,28 +9624,33 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>   	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>   	if (r) {
>   		dev_err(adev->dev, "fail to wait on hqd deactivate\n");
> -		return r;
> +		goto fail;
>   	}
>   
>   	r = gfx_v10_0_kcq_init_queue(ring, true);
>   	if (r) {
>   		dev_err(adev->dev, "fail to init kcq\n");
> -		return r;
> +		goto fail;
>   	}
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
>   	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
>   		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto fail;
>   	}
>   	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>   	amdgpu_ring_commit(kiq_ring);
>   	r = amdgpu_ring_test_ring(kiq_ring);
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   	if (r)
> -		return r;
> +		goto fail;
> +
> +	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
>   
> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +fail:
> +	amdgpu_gfx_off_ctrl(adev, true);
> +	return r;
>   }
>   
>   static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)

