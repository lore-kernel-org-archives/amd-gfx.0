Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E031C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 21:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D08D10E379;
	Fri, 21 Aug 2026 21:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hkoUK5n4";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B650F10E379
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 21:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4MMhMoJ88aXs2iDaWbXukTxdfko02Uhua1ezwmjf3ut5VJAx+pw1cLgXXLuSWIQNqqTDXnUHQ0e6YXwpHzpvVxk3/Amu8kUg++wJsn0GS2JvTXe5D0gPTNYQ1FNxmqHniLM5vgO5/GAMiIy6QejAk4Fo4hJ8RuB4QGHIVeCsxOft/JryBBaVHvMeNuUckNt1MBe+ve6DH7s6SkEAB7cPvcoGQ05bNh6ihZm8Xe6cwiMR98fRrAJgeYlf0Ar8L0Zc2W2VodW8q2rkDtoCnq8hj1QMv6z9wqupNknv+jR7NqMCXDCiHIQJXhGKp+FuCWcIe96QhaiP1oMFWmWUcZ83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBN0Pekw6/HrHlbZMgVGcicS54Y+1o9x9oS5K3GQcGE=;
 b=m5i0lhL949Fm1PxB/UwlYlxl20FWTFq4sGrc6kSjdcZKSHpMnUFsv6BPGFdg/8pvu0VU3QLJll1/57VHr8W6zjm6gC5Cbi5eFI4TEpus/SkATw58cIxBSyg7WqJSQZOHtCFeMKiVF4cyyrJ+CP+Rb0v54xeupqLjBu6LTrk27rsyccQsmQIAF5GKMMBBtgPGBaWiiLNDHieNwmXsm1g2Ckufkf1fLYTv3ANhwOs6dknB57BOJwi+Ev6JXznNldE/X7eBeN5H2q6w7Ysybn3k9pLTd1I4V1whBdGQ1PhqaxFcHnxaLeTRrtcqncnb6Ziog3NvcITi1GOsLgG0mGwdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBN0Pekw6/HrHlbZMgVGcicS54Y+1o9x9oS5K3GQcGE=;
 b=hkoUK5n4Q/PyuLZ5tB16ASzsbvjIv6kJFycpJOCUkhjyABDktayZpjzfskG/sJ/wXoP67n6qQEUeTEJuGP3R4AITP31uvmQt1YzOtsnf2HmEIlxOUPB0B9+xsGbGBf9uA34XDwopSbnySUH4zAD+fIf1X91fx1yaaQHXKgQrdb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 21:32:06 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Fri, 21 Aug 2026
 21:32:05 +0000
Message-ID: <266cab79-8978-4c18-aee5-e576a9d3fd46@amd.com>
Date: Fri, 21 Aug 2026 16:32:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/userq: create the same workaround of
 oversubscription timer
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tishko.Araz@amd.com, Alexander.Deucher@amd.com
References: <20260819201443.282689-1-jinhuieric.huang@amd.com>
 <20260819201443.282689-3-jinhuieric.huang@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260819201443.282689-3-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:8:458::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb794d1-6d1a-4be7-8d4d-08deffcba515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: lBFgeEwM7QV9jEZdFvZ/WQzttFsOKKXwjW4lXMcJvoP+LNbhRvGjT5nW9XO6t/B6YrUxMfSLiKr08W0g+6SXvN8pnThPksKnQx5WUKZBJS/w0V9H6wDECBVOpoLbpEaRBnBcxEJA4Yf1kNC0wux1+c99aFHaD4RxMD4pvi/t7kjtCPads8XNuR0ZQY7Ue1E40Jp/fd/vGrNRIj3po3YzcNBv+sVXQTVeJr9NNQ+L2rwzJOBcozcCLwvXllo8rIbj+WSm3E9q4B0Pd/LP6s51GPv0vHgqXXfSBMBFyKi8MMTBTau/xAkANVIyZk8rM0eGY7ev9ihR+zLTnPxvvxEPfj86MowhOxjW7R5UnRZF74DP1TPXMP2CEyqQ2m+DLtlB+KFv+e83gLQjuqN99Z0zLZmnnlTTrFRNRzuUyW6KPhiZXDaLlYJSrrY+7LT9gw1KgCbr9AMBGnehlXRn85y4Pjj89hnGQ2x3+w1CgzHxGcwlOtbh96ski9Y5tEzqjExctfLnoj4x9eaqY/GiqWgrUT23gy/pkmApNlTejKquPQBpb/rJ1e0rjKBU4e+/iidSHCqAQ3d1yqBWMq1/4lWrXSGLb/VMwlZFcmkT08sy9VcmDNSn/gqOyoi7IBvq//sPNrpBOFIZqZQl31knzlXf0MJ6uRRfq4EdCghjIkQi9LM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1EQURJcENha2NSQk1NUmJ6dVd4QmxmaldhL09obkpsYXBLUEFUWkVhQ0lh?=
 =?utf-8?B?Q0l0OTRnSGtnOWhJcHlxUGo0NjU1NDIrWUNGWXJCa29wbFBxeEF5WHJDLzJH?=
 =?utf-8?B?RzVUYWRBN1NiWHp0K0k0TlAzYmtYZWlWcFB2cGFIekVDbXJoMnlwSTVSY3dB?=
 =?utf-8?B?UExPT09raXovZjZ5bUQwZ3hmeGlvWGNQKzU3L1dRSWJ3WEM3ZkJQS0QwWHZS?=
 =?utf-8?B?L1B3eXdjNHhvckt1bExaWFdWYkRqRlg3Y1Z0R0Y1c1Z1blFSaGJhY0dsY2NC?=
 =?utf-8?B?TUJtM3c3YmJYYVVFZUVhc0JMeWY0OXRvdDE4OVVYbW0zb2FyQjJJNFU4eEM5?=
 =?utf-8?B?VC83SXhsbC82L01maThtaEM1YmFCZVZPQU1MTUdXZC9BVEtoU3lkSTZpbi9Y?=
 =?utf-8?B?Sk9Mand5T2cvQVU3NnVDQXo3ODRqc2xXeW54VWVsL09QSFJBSEU2Z0REbHhu?=
 =?utf-8?B?dHdTMkREeEFLa2hKTmtpUW5UZXA4NTZFczZxekdsZzhScEM0T0dyUGg4aGFT?=
 =?utf-8?B?ek5KRVVHaTJhMlZSMFhndFhDNjVvYnFFUDkvNUQvazVrdjlUVTNvaFFLWmdp?=
 =?utf-8?B?ZGNMdHpzZkZwV2YwYW9zbGNjaE11V090RCswR2U5MUpUQXM2a3NFck5QZCs0?=
 =?utf-8?B?NzhQSlNsSmtBcXNqWml1R25pVVNwMEh4eElnalFDSDVMUU9tTmdiQjJMUWtZ?=
 =?utf-8?B?WWUreUdzVldrQjNtNUlMQXpPOVJ3TlJxMXRaOER5ZGJ4SklTWGN0eGk2aTY3?=
 =?utf-8?B?RGYwQlJIdWlqeldjU1REVVdOUUlOVmlvcXdyek9XZkllR1c4d0pvbHcxOHJN?=
 =?utf-8?B?ZyswM0I4cnIwTk91dzUvMCtPdWtRaEFyVGxrWWs3UEhIREM1L0ozTFkzbFBP?=
 =?utf-8?B?NGVKVGlDTEtFOThzbXlWZmpwS1IzN3hOZkZCazJ1VDFjbWtBOHluR2VBclow?=
 =?utf-8?B?aEE5RTJaOWdxdGRrY2hNY1J0bmphNWxwZFZoUzYvWUhoUVdqQ1h6NC9xSVVL?=
 =?utf-8?B?UG9xOTBYdllXV3BYelZxOXlxbWgyQk8wK0NyWmhya0J2d1cwZ2RYa2RwdE9T?=
 =?utf-8?B?M000eWRHUHZqTk9lRkdhd2ptNmRLUmkwTllNd20vd3l4Rm1KYmlaOTZvY2M1?=
 =?utf-8?B?OE9PNURieTFlRThIZXJ4RkZhYXlueE1BVHUvTWVKSnFtUDRxeHVxakpFd1dx?=
 =?utf-8?B?K21yV0lzNmlYbWhFNVNKbFplMTRONW9zeUN2NmNkTm9uNnVjcE1Mcm9vbkRM?=
 =?utf-8?B?NXJkUlJCNTRaVzRVbGNoa20wMUZ4b3A4R20zYlphUkUzMnpoWUJsN0h5bElH?=
 =?utf-8?B?Zk4xTDJrY1grLzJWNXBTTlpTSHVlNnU4aU9FUy9oRlFQbzhwZkM1OVVQS2dB?=
 =?utf-8?B?UlJzdVE1RmlYUVZiazJRdzI4YXgxN3pwc29rYUFSVHdZVHRrdlR4ZGROaEQ4?=
 =?utf-8?B?bCtNUy9JMjVralJ1SXhaOFVwR3AyeTAvOWFVK1RkbTVnNUxtWkE0NDdPSmNr?=
 =?utf-8?B?VUFCV2VOREtHZWNlczNqZlBnUktqSEplU2JxVTZoMnRhWUcwQ1BSaTh3QXNE?=
 =?utf-8?B?d2V0amc3RGtqOS9uSnpVOWUwLzlLYnNsRnAwdTNhTFZveStnK0NFdm5oWDJG?=
 =?utf-8?B?d3czZUJiTXRQbWNPNll6NjUwNEJuRFNHS1JxSGw3NGtCeFROK29pMVc2K3Vp?=
 =?utf-8?B?UDRGSlVjajQ2blJEN3lmY294RmFhakF4OVIwNXpsdkRNM2Q2dzI1N2dxVlFI?=
 =?utf-8?B?SCtKVVJQbDlqTk8vOVEyRTRxTjc2UDBBQmtZc0RUNGJXN3lxVWg3WkpLRXJV?=
 =?utf-8?B?bkF1R3MrUG9ORnBGK3hLQmk3N1UwQUVJTmpHWEJoT1JOSEQ5eUsrS2dnUFdL?=
 =?utf-8?B?VEh2Sm9POVVVWFFmSDZxNWpRdllEaU8veGY3aGdQS1FHcG01cVNHMDh3NXZj?=
 =?utf-8?B?SzU2V1p6dFZwOW1SWnNJYktvS0c0M1JGOFZia1pJbUJ1bFBiZW5yWVNDRXJw?=
 =?utf-8?B?RTI4UW1uWDRjQWcvMEJuaTdPa3lWcnV3Z3VEWWV5cnhHVXY2Nyt0SERTbkl1?=
 =?utf-8?B?TnFPT0VmaEF0M3FKQ0h0MUpnUUlqTmlONmhFVExHZHl1cnVLZUNsZnp6aU5z?=
 =?utf-8?B?K2tqSTQvaER0MHZMZUpkRS9UOTFlaDhIbTZYb0N3ZUd3aHNnaW1xMlN5cHBR?=
 =?utf-8?B?K0pIQ3I2RzVCdFR5cndBc3YrQW91cTBZSHJYY0M5ZXdsL00yUmd3RytTTnRO?=
 =?utf-8?B?MmNPam9HeFJ1cmtGc3lNRUhZTE1QT3FZT0JIemJ4VysrOElwUVB0SnRPQ0Iy?=
 =?utf-8?B?ZTBoNThBNk5jQVhvaGlza2V6VzVXWGI5cW9TQ2xNcXdaUTMzNlB4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb794d1-6d1a-4be7-8d4d-08deffcba515
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 21:32:04.8255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCQiUUH0//ZRo3x9rRy49kJ8kDGqImiOljPL7+WTuCvk6dB95C7jfbzwKdINqstCwoyGS5dYofl+Lvb/PmRttQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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



On 8/19/26 15:14, Eric Huang wrote:
> removing MES oversubscription timer will affect both amdgpu/amdkfd, so
> add the similar timer for amdgpu userq as well.
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 70 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  7 +++
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 10 +++-
>   3 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 421d937c1188..b2c64ec8e0af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -101,6 +101,8 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
>   	return (total_hqd_mask & ~reserved_hqd_mask);
>   }
>   
> +static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work);
> +
>   int amdgpu_mes_init(struct amdgpu_device *adev)
>   {
>   	int i, r, num_pipes, num_queues = 0;
> @@ -123,6 +125,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   		spin_lock_init(&adev->mes.ring_lock[i]);
>   
>   	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> +	atomic_set(&adev->mes.userq_hw_queue_count, 0);
> +	INIT_DELAYED_WORK(&adev->mes.userq_notify_unmap_work,
> +			  amdgpu_mes_userq_notify_unmap_work_handler);
>   	total_vmid_mask = (u32)((1UL << 16) - 1);
>   	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>   
> @@ -288,6 +293,8 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>   	int i;
>   	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
>   
> +	cancel_delayed_work_sync(&adev->mes.userq_notify_unmap_work);
> +
>   	kfree(adev->gfx.mec.mes_hung_db_array);
>   
>   	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
> @@ -1163,6 +1170,69 @@ int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> +/* Interval for notifying MES of work on unmapped queues during oversubscription */
> +#define AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS 50
> +
> +static unsigned int amdgpu_mes_userq_hw_queue_num(struct amdgpu_device *adev)
> +{
> +	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
> +	unsigned int n = bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
> +	int i;
> +
> +	for (i = 0; i < num_xcc; i++)
> +		n += bitmap_weight(adev->gfx.mec_bitmap[i].queue_bitmap,
> +				    AMDGPU_MAX_COMPUTE_QUEUES);
> +
> +	return n;
> +}
> +
> +static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
> +{
> +	struct amdgpu_mes *mes = container_of(work, struct amdgpu_mes,
> +					       userq_notify_unmap_work.work);
> +	struct amdgpu_device *adev = mes->adev;
> +
> +	amdgpu_mes_notify_unmap_queue(adev);
> +
> +	/* Re-arm if still oversubscribed */
> +	if (atomic_read(&mes->userq_hw_queue_count) >
> +	    amdgpu_mes_userq_hw_queue_num(adev))
> +		queue_delayed_work(system_wq, &mes->userq_notify_unmap_work,
> +				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
> +}
> +
> +/*
> + * Called after a GFX11 usermode queue is successfully mapped to MES.
> + * Starts the periodic unmap-notify timer if this pushed the device into
> + * HW queue oversubscription.
> + */
> +void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
> +{
> +	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
> +	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
> +		return;
> +
> +	if (atomic_inc_return(&adev->mes.userq_hw_queue_count) >
> +	    amdgpu_mes_userq_hw_queue_num(adev))
> +		queue_delayed_work(system_wq, &adev->mes.userq_notify_unmap_work,
> +				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
> +}
> +
> +/*
> + * Called after a GFX11 usermode queue is unmapped from MES. Stops the
> + * periodic unmap-notify timer once oversubscription clears.
> + */
> +void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev)
> +{
> +	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
> +	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
> +		return;
> +
> +	if (atomic_dec_return(&adev->mes.userq_hw_queue_count) <=
> +	    amdgpu_mes_userq_hw_queue_num(adev))
> +		cancel_delayed_work(&adev->mes.userq_notify_unmap_work);
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 0291ae14a1e7..5160b227943b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -29,6 +29,7 @@
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_doorbell.h"
>   #include <linux/sched/mm.h>
> +#include <linux/workqueue.h>
>   
>   #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
>   #define AMDGPU_MES_MAX_GFX_PIPES            2
> @@ -90,6 +91,10 @@ struct amdgpu_mes {
>   	uint32_t                        total_max_queue;
>   	uint32_t                        max_doorbell_slices;
>   
> +	/* GFX11 usermode queue oversubscription notify timer */
> +	atomic_t                        userq_hw_queue_count;
> +	struct delayed_work             userq_notify_unmap_work;
> +
>   	uint64_t                        default_process_quantum;
>   	uint64_t                        default_gang_quantum;
>   
> @@ -646,5 +651,7 @@ void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
>   				    uint32_t index);
>   
>   int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev);
> +void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev);
> +void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev);
>   
>   #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index fae709f134bb..5a10af16e0c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -171,6 +171,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>   		return r;
>   	}
>   
> +	amdgpu_mes_userq_queue_mapped(adev);
> +
>   	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
>   	return 0;
>   }
> @@ -195,9 +197,13 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>   	amdgpu_mes_unlock(&adev->mes);
>   	if (mes->use_rs64mem)
>   		amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
> -	if (r)
> +	if (r) {
>   		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> -	return r;
> +		return r;
> +	}
> +
> +	amdgpu_mes_userq_queue_unmapped(adev);
> +	return 0;
>   }
>   
>   int mes_userq_reset(struct amdgpu_usermode_queue *queue)

