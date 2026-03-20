Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2105C1093188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 07:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CA110E00D;
	Fri, 20 Mar 2026 07:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aRzLEzhL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52EC10E00D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 07:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPKJCA/l6HYiKJRb535GIV5aOHB/dOtqYCqtKAfMbJn7LVP/1gAaSNnKnNoWgyE105C5GfO/AdXcKEZJTnbJHmdijLOdjFWMxodMEjed/ncBWiYPFmeNYxS9/LX8EL7KWqc/AkEUVNDD2yltNrsMgvluVI4tX05Y9XYiOCuYBj7A1R4rt5hVgEVZ+QegroqH14mSMiYFBfcNucIWyCEGKk1pcLfi7p1PTB3jlx7uyA0Wn59P8rjXuY5Vmf9/bgYL4DlSrpWPK1UaSiCIanojd52vYYem6juBDbjXA+/6O4et5tQ9sybPVpbMjf/d15LzvrhwPy4UB8ZIWlm7tuV+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kBRmwFW1mys+jJ95Iqactn20xXpTFpvX5N9xwMUS6c=;
 b=tl2duX6/ZZFkkuwxN3mqnX6fHD1eiTIdki+jiHk9xppQqmERdwk8ZNowKnNkJKQfyzgxgxMSzCSb1nhgFW8oh+uMJHuuKWCgov+wVBNOyPe2iJXWFkqggkd1PrdXrpBSh5j0EFrGh1RrQsNCwL1hrJ1TYImShxElVC/6ukn5ifNcE8wXvudbDHGqOLYwDmfDDETlj6tdWR1HLsoIT/M6E4xKR/mTX4cmhF3cMnuQIps/XK1xYONAdmqrKL8qO1LgRsKOeHg2RQ7N0iFM0zZ9rqnBdbXN0lg83HoHgmi1aGh4ghyOtf/Ybg4lvgW8tgQbn2cQeVzYE5RUMiwxn2SI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kBRmwFW1mys+jJ95Iqactn20xXpTFpvX5N9xwMUS6c=;
 b=aRzLEzhL+y5MyOXRT/0Us7vCJaXC3MBSECHXNpsudMuCHmFoAstunJcvQNIHfQ2fCD3+1qs0pqSePSirx7ehx+W7DeHcu4xMTOBEQ9iTPJV2YjScbUcfRxmzhWXLO/jT7rhQEkvMZlHjGC9GRFXwYv2ixIVXjTlJ3/nkEuYcxSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 07:56:46 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Fri, 20 Mar 2026
 07:56:46 +0000
Message-ID: <97824e02-f269-4ab8-aa05-369185e4cf11@amd.com>
Date: Fri, 20 Mar 2026 13:26:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: fix the userq destroy dead lock
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20260319082150.3324177-1-Prike.Liang@amd.com>
 <20260319082150.3324177-3-Prike.Liang@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260319082150.3324177-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0045.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dfcd2d-8e94-4bf2-676d-08de86563bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: EPIKqZw92u7QJvvqRNNQpiGflK5IXAeb2/9Nbd8W/e7q/Vm4rJM3tcNkNiHgm8wxyHkAC1dP8LrkppIHE/dYzhu3LxeyGLROS5IexGSy9YUn1RmL9K9kxLbhB8OXcL8th6UGhV118WMMn9aDCU49UJ/EMzX911+h0ZeyX1ukv7XdMo9/2WLaAnO8UiANMlNWZSxdOe/pTB0Uvd5GgNGfJDA4l8UPrmSoAJ8mEfa4JIiJCe9y0NHhf9S8Ym/yndx+1a3d4baAd2/8kbpn3bxC1Awe3zE7Iyy3LGUpaS5AuwmVz1MbT33UYvS/sakJVd2nJcIBl7tyCOt3RZrExjelruJtAKWS+y9tpzbM9n+49PnkamRFXtlOPZ36OcEusDjDpMCMoUmI7o1QwQxuFPAMUSpT3J4kxAHfI4bxTJilrrik7XSwB6qBjj/Uo2suuY/sT5GSt1YGVZ44Wf6HT0zuqiRiI4ko7/tgjAFQFOXKy3xJ8TDl9U00JQd1DFiffrnd3J+QGoMBfaz0R/m7jCXl+uDOSPac9a7sI7HKyE3EupZc1952gAHYw0LWebVuPJniCkq63qBc60dTRsD/Xlb/udZeYapVl4/j4m0aPBfTMBPu2O3IoQqZYV5SY711KwnoBVKcs2kthov+EXqCsgSxk4DZIan6n8GsRw4wj1C8NUQjCb3Gfp9P4MwIIOYC2ybXaTQKE+U9e/fS/oHWlGcAE690cfYDPrY4GOsb2goFoJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCsxM2ZDU2JMejkrU3hjZ0IyTHhaY2hyNGY1Q2hjY2l5eWtMcmZpekhTemhB?=
 =?utf-8?B?dm1qQldENjh1aUhORVJ5UHF1ekdqNGxsMXVpa0pDL1JmUUNFK3pQbXhOL3B0?=
 =?utf-8?B?cS80MUpEUFFhcjNiTERhUkozNGZxQUdBZ1g5cmZWYU5xWmJ1TmhQaWtWOUZI?=
 =?utf-8?B?NFJqV3UwMGNWSEx1ZHd2dXp6aXVXN3B2NklSSWZ4aGRDWllWbGJ5UE5HK284?=
 =?utf-8?B?dk5lZ2pWME1sNXhRNGtlZGgyMTk2djVGZXhyV2pHSk5LbmlmUG16NzBwcDlH?=
 =?utf-8?B?QmxzSjViUkJXVFpySXBtL3J5N2QyZlBlc213d1Vib2xNTXlqTTB0QVZkM0lZ?=
 =?utf-8?B?OUN4SlhvcDFmUXl6aUhtV0FFTldvbElQbDJSRmozMnllWFpTQUJrWmxVTk5V?=
 =?utf-8?B?b3dFOXo1Tk9GZlMraFM0UnRPVG1XME9WRVdVcXdzR0V6N3E1dVhSbEtwMkQ3?=
 =?utf-8?B?eTdKOXI4ajBxbWYwYXR0SmZWditudFVhcW1CT0pIcFNOeEp3MVR4V0sxZ3p3?=
 =?utf-8?B?VzN1QmdjMG1UZVFCMmlHUzJvemxSQWlZSG5qc0dMbFdSaDZxZkpBb2luQUZZ?=
 =?utf-8?B?UUwrQjk3aXBrWUJMZWhRMkdRQXFjTnFHaFAwSkZzVUR5V1ppb3pFSGNmZFdY?=
 =?utf-8?B?RURkemY3UEFsTGRSbUk0WGpBdjl3OWFCUTNyU203TUhiN3JSYzduRWRZTlhi?=
 =?utf-8?B?d2dKdENiTUsyMTVzMEovTFg1cFFkeGNGZVlkNzJnOHdGQ2NXLzBQaDRLeUli?=
 =?utf-8?B?dlRSV0tpR2x4Rld0dytzV0t6ZmVDSHRvaG91Z1ZNSzErdEVRMlN3Y242QUti?=
 =?utf-8?B?S0tscjFrdFY3aXZZdlhmdis2T0x6R3U4SHpRM0VGSDFCRi9VU0FXMUdzNmpQ?=
 =?utf-8?B?RzVhSGhGR1AyVnl0aXN6emJRcXNFdjhBdCs5djU2b0hKR3BVajVKdnZyRjB4?=
 =?utf-8?B?Yk04djVVNk1oYlBkNXUzMVBNVDVDQURpbUVqMm9DT3ZCaVVqTUhCYmNHNXNr?=
 =?utf-8?B?MzJNNU9rZ2J2Vm1JdVBEeTZVYTNycGFubVgvNUtFOUt5aG9YN2VyVE1rYUlU?=
 =?utf-8?B?QVI2bHIwekN0YlJNSENKdXRQSmtZUVU2NnBTMk5QOXJCMlUvejJ1N2ZyZDd1?=
 =?utf-8?B?VStwNTQxYVh0QVoxYkdZWFROQzh2dmloK2VsQWZnZTFwb1l6a3FXN2NDQjl0?=
 =?utf-8?B?VmZXWkw2eVNTSGYzTFI2czA2VCtkVmJ4d29tdyswLzFlQmFtQ2VHVkVUTEtL?=
 =?utf-8?B?U1JLT2tlUUVGYW1SQ0lscEoxV2V3NHUwMTVVVXNUalRGbWhFbTUzQTBZcG90?=
 =?utf-8?B?QndySW9DNGphL0I1ODRqQWFoV1orT0FHemU1RXRsRW04R3l5eThVZFJtdGw1?=
 =?utf-8?B?TXlBNUFkZy9FQUMvQmVNS3k3N0oraDEvMjBvbUVZTXNvdEI4TEJabmsxTTlL?=
 =?utf-8?B?cEVJWnIvUHp6Z2hFOWFmc0RlODFrYzdTZWZIdVo5SVpsU2ZGYzlzVzJ5UW50?=
 =?utf-8?B?SldHSjVlTTlSKzhtSk5NNnRSUFBCQlZaSmNDZHZadGlGRERuYmxGQjhBWms1?=
 =?utf-8?B?Q1FGdFowY2w1REt6LzF6anJOMENpaUF5OEtMQUdWMUdkN3c2VjJlcXVCSllN?=
 =?utf-8?B?SVJQM2UxdDk2ZXM5QnJicWo5ZjJzL0V2RDdpaVY0cW9YdE5HeC8rUVliMXh1?=
 =?utf-8?B?UDRoL3hneDU5MFIyM1AzWU1MVmd6VXNQdEg5VnE4c2s3b3FYVDkxRkkwNkRz?=
 =?utf-8?B?eWdPUHdJc1pxUXR5R3N1ek9sckxvUmdkWkxxWVlFRzcxNUoyQ0g2dEVCRmdU?=
 =?utf-8?B?OXFSdVFEVUpWc1NnK1lsQVA5RXFDQ21LRUNuaS80a2VtajBlQnR0cmhHeGdw?=
 =?utf-8?B?MGNYMjFkeUhjTzh0bDFQL2xTZHdXNFhlUEpjZ0FtV3RvOTFBc2N5ZXVxY3JJ?=
 =?utf-8?B?OC9ZK0xBc1F5dC9oZCtxbDhsTnFLQTByMWJWMThDK2xETm5kQzVwSDR6eUo3?=
 =?utf-8?B?TUJndEt0Zzl0UzVEbEZTR0ZSZko4cmJQTFY5Z0VPNkRDMGVSaFk5SEYxdU5B?=
 =?utf-8?B?YzQ4SnM0OW9zdnJYWE91bFg1dVpzODBDUUkxdThjSlJnSTdRazMxbVdzZWVw?=
 =?utf-8?B?V1NiV3A1citia0tKb3RQU0JJSXlhcVd5TEdQR2wzcm5BMUNZckJzK3JuQ3Zo?=
 =?utf-8?B?UDQ1Vks3QVdEYVI0RlJrY1RSd1ZJaEZZa2FpQlpObUpUMDJ0NklEV1dBQ2V0?=
 =?utf-8?B?Y1NDanFmNGpONTlKcjVLYmMxOFlHbWdnTWlpc05OK1RGZlZtZEZRY3NSYkhT?=
 =?utf-8?B?TWRNdHZSVUJKZGJJV3BOa3JuZ3BuN0xrSzBXaEZqN0VTdzlhVlpRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dfcd2d-8e94-4bf2-676d-08de86563bd8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 07:56:46.3953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3agWzGzYUXGiRoMR0ZO05vVZGDrnHt3gyrV8887uvV6dTp9/SWT9PALrNr/H66+gxKiVX3KtnKF8/50shfVwIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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


On 19-03-2026 01:51 pm, Prike Liang wrote:
> In the userq destroy routine, the queue refcount
> should be 0 and the queue already removed from the
> manager list, so it must not be touched. Attempting
> to lock the userq mutex here would deadlock, as it
> is already held by the eviction suspend work like as
> following.
>
> [  107.881652] ============================================
> [  107.881866] WARNING: possible recursive locking detected
> [  107.882081] 6.19.0-custom #16 Tainted: G     U     OE
> [  107.882305] --------------------------------------------
> [  107.882518] kworker/15:1/158 is trying to acquire lock:
> [  107.882728] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_userq_kref_destroy+0x57/0x540 [amdgpu]
> [  107.883462]
>                 but task is already holding lock:
> [  107.883701] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_eviction_fence_suspend_worker+0x31/0xc0 [amdgpu]
> [  107.884485]
>                 other info that might help us debug this:
> [  107.884751]  Possible unsafe locking scenario:
>
> [  107.884993]        CPU0
> [  107.885100]        ----
> [  107.885207]   lock(&userq_mgr->userq_mutex);
> [  107.885385]   lock(&userq_mgr->userq_mutex);
> [  107.885561]
>                  *** DEADLOCK ***
>
> [  107.885798]  May be due to missing lock nesting notation
>
> [  107.886069] 4 locks held by kworker/15:1/158:
> [  107.886247]  #0: ffff8f2840057558 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x455/0x650
> [  107.886630]  #1: ffffd32f01a4fe18 ((work_completion)(&evf_mgr->suspend_work)){+.+.}-{0:0}, at: process_one_work+0x1f3/0x650
> [  107.887075]  #2: ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_eviction_fence_suspend_worker+0x31/0xc0 [amdgpu]
> [  107.887799]  #3: ffffffffb8d3f700 (dma_fence_map){++++}-{0:0}, at: amdgpu_eviction_fence_suspend_worker+0x36/0xc0 [amdgpu]
> [  107.888457]
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 50 +++++++++++++++++++++--
>   1 file changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index bb5d572f5a3c..c7a9306a1c01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -148,6 +148,52 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>   	return r;
>   }
>   
> +static int
> +amdgpu_userq_perq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr,
> +			struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	bool gpu_reset = false;
> +	int r = 0;
> +
> +	/* Warning if current process mutex is not held */
> +	if (refcount_read(&queue->refcount.refcount))
> +		WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
> +
> +	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +		dev_err(adev->dev, "userq reset disabled by debug mask\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * If GPU recovery feature is disabled system-wide,
> +	 * skip all reset detection logic
> +	 */
> +	if (!amdgpu_gpu_recovery)
> +		return 0;
> +
> +	/*
> +	 * Iterate through all queue types to detect and reset problematic queues
> +	 * Process each queue type in the defined order
> +	 */
> +	int ring_type = queue->queue_type;
> +	const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[ring_type];
> +
> +	if (!amdgpu_userq_is_reset_type_supported(adev, ring_type, AMDGPU_RESET_TYPE_PER_QUEUE))
> +			return r;
> +
> +	if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
> +	    funcs && funcs->detect_and_reset) {
> +		r = funcs->detect_and_reset(adev, ring_type);
> +		if (r)
> +			gpu_reset = true;
> +	}
> +
> +	if (gpu_reset)
> +		amdgpu_userq_gpu_reset(adev);
> +
> +	return r;
> +}
>   static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   {
>   	struct amdgpu_usermode_queue *queue = container_of(work,
> @@ -627,7 +673,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	/* Cancel any pending hang detection work and cleanup */
>   	cancel_delayed_work_sync(&queue->hang_detect_work);
>   
> -	mutex_lock(&uq_mgr->userq_mutex);

Cant release locks here and we still need locks while updating hang_detect_fence and all other functions that follow.

>   	queue->hang_detect_fence = NULL;
>   	amdgpu_userq_wait_for_last_fence(queue);
>   
> @@ -649,7 +694,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   #if defined(CONFIG_DEBUG_FS)
>   	debugfs_remove_recursive(queue->debugfs_queue);
>   #endif
> -	amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +	amdgpu_userq_perq_detect_and_reset_queues(uq_mgr, queue);
Possibility of the deadlock seems correct and there are some other 
places too that i found out. But we cant leave the locks here like this. 
We still need lock to clean up and rest of the function.I am looking 
into it and share a fix where we dont have to release locks and probably 
a better way

Regards
Sunil khatri

>   	r = amdgpu_userq_unmap_helper(queue);
>   	/*TODO: It requires a reset for userq hw unmap error*/
>   	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
> @@ -657,7 +702,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   		queue->state = AMDGPU_USERQ_STATE_HUNG;
>   	}
>   	amdgpu_userq_cleanup(queue);
> -	mutex_unlock(&uq_mgr->userq_mutex);
>   
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
