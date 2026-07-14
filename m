Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC1BC44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2310010E06F;
	Tue, 14 Jul 2026 09:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8kG4yu6";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7363C10E03A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkmSUf5mT5/rmn/T2X56Bj5OwS08Cev5zWy8/qMobXUCF0ccOilF8zRENNvMkdaaWQfOgC6hkPVbcYjq9Iidj8nBVyntYaIdkPOTCnoQ3icdLT8RPaJusVdDXC7XxCSeAISIRCl/k5XAeNjQ5+JQM68zNFGgc58dnFQudnC1RCidsZkIJOY6tQneuAdnVx0ci9YQDFNqeD0QPFHo7YCX3Num7a1BI+4Qp6p7gTfNYMpFc6qGux4Pve3D0pxUH/Jff1bYykTDsEookZUw41LfLpWG5+n6dn6gcd0q0lNxIkOTfftOEQGhI0GfKdBUhlnXlsfGpZxrr5beAa2UwwBmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEsk0daCkKEbh44w1xFRWXSDsgz/VHkcGnyyXgx2q70=;
 b=qosY2ejljLRYJ4w6DVNh2CUWsXmPOYZJaYNc/hq+aYx+t7zhTRYjdGiNNPZl03gtPpVCytJh5H7Z2g0wq19jb4wLW6RTsdb1CrS8Rh/UL5WPHBrDv2zfMms90E0sp3uVB87rQcRLdVluI36qJGuooRi4FCKvsf1rRaLVIpTqKT3E5N787GZT2EOxU8SKV6QLwVEDVRFj5tEKSru1JjhlMCKQXibZoWjT/kyfki4V859Ufn3ByGMuFtdG8kTdLNYrEtJAB5+TYJoREJRV/MIstSMFpOjfCK6Ofze9KSnwIjluILxSFVxFCdb9/+3XFckFDyCpmi6M9RcbhlZR14K+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEsk0daCkKEbh44w1xFRWXSDsgz/VHkcGnyyXgx2q70=;
 b=J8kG4yu6PHXgqTwy1J8oEiisxb2VRAVUfthhrc8T9ZHsgM6eI0vE+y8FuW6/JCCAu0OxM15GZpGOjsBQIWxUNpe4WYmXJ1U2xS2hAO3ZvMh7/Qh5M0m4mfodOsw3ceGQXQwfGpIq2kIIQiFPDLIOJhWtMImOSlO17jZHT939a8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 09:50:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:50:49 +0000
Message-ID: <ada7acdd-0bd1-44fe-9aee-e533236fd076@amd.com>
Date: Tue, 14 Jul 2026 11:50:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] drm/amdgpu: Signal QUEUE_RESET EVENTFD
 notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
 <20260714080220.3395155-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714080220.3395155-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 098c615d-a44d-4644-3d98-08dee18d6288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aAX0vwZsojj5okDa8GZNPvqBa0JmItodfiK5S4y28tpFvmvK/ruuQTKv+UuQJuzYAKpyMib67uO4tJQYccL1x1SIFXN+aWMlwU9n3N8S5QCPmYHFWJP+PirfBOMhwk+iEcPIKp39U1UJ88pA/pybswPRDNbZQkPfAl8QPprbeeOGg4c6ZiGd/2GYgwTb8+Hsujpr+MV/nT9c/PpqgT32rISV2xAMoDo607fn8pvhWS4vzZL5nMi5Ov7XqX3O0qVdv6QmcD4SLBJ7Ny2bTbI3dxrZy4O2sU1HEj3nkLTOInbNyqx6kmW4cErw5nrj459JtvX25PBPfo+t0hrFpkz17/sEaTWGqSnZjWzfx+fh5PODy6j4SstavbnSRu/AA3HPLrF3VtfTHu6U6ONWrIuj04Rg+jLuq0WypSXOdp8myNRC5AMZlNhu/omGSgp6fMprxhLN6LKsyADPuBnrRmxbPugqJ3HKrJG1zJarcmTrXmxyrOtU02Rh4pSTnNlNogZjcdGAQnrGgcq2P8jDxnUIHRZ6S7h8PUXIDZAyGPl/Wxfws7TUe5AYzTwam5j4dOXdlzib0yZSMbt2pkVbo8yqX8ym86CPL0/DKk6Ay5Il+9TRG9CMddsUdfgRFuJDmTjQvsQRWSJ+IeSfa+b56wgMqfc/+rCLeaC0fKwR8BuTW0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmcxZ1VSb2Fvb3c4T2R6cmJVdEhzeEZWa2FlYVFnRGdtODZWd1BVT2tvVDdJ?=
 =?utf-8?B?L0tidnhmekVFYUNpdTFveTV4MXN6Yy9aNUdjS1FoWFRYaWtObG8zdVhIWitU?=
 =?utf-8?B?V3VnUVVkcXhqbnc5NVc5VEhWSTNDRU9Ea3FGSkt4TFpMWG5DazJDVTU3Z3NC?=
 =?utf-8?B?Ymg1UUdDcmlsaW04Q0lmRmRqSGUxYnR2UGpHd01NRzdtQzR1SHRaSFpHcmQx?=
 =?utf-8?B?d1JFQ3hZYW5kcGRYWnZLdWIrVVNRa3FpUmtTU2RPZGJGMjNUYkorYXZVNi8v?=
 =?utf-8?B?YWRVWFRrejhlN1IwUVF6aGNaUWwvaThFV24xVmlVT2lSRlNScGpUTGVzeldo?=
 =?utf-8?B?R085VDVLQUVVQWZkMHkyNVVxdk9qeXdmOXlzeTV0cUFrMXV6R3RwNWR4dlpo?=
 =?utf-8?B?eHFYV1o3SExldzMrSG54TEQwQUlnZmFFcGZhZ2IrZVp3U2s0NXpSVzUvYk5X?=
 =?utf-8?B?T1dOenJlekw2SEc2cFI5cGcrU2hLaWRrc0xtcjhwUkNsNndCdEpWaUxBSGNl?=
 =?utf-8?B?VUtLdkNCR2xrNnVSWmR1SjUrdG1RZzNhLytKd3ZtZ2w3d2Z0Z0JGeXcxa2Zu?=
 =?utf-8?B?YXkvYmNhSS9vbDJIcVFZU0x2REIvM0wraVl4cDJ2dkVLQ2xOdzU2TVdNcXdS?=
 =?utf-8?B?aTFvN1FQcUxHL2JEajQxaVJ3TUZiRCtFZlRTRTlSSjFGYmFkcXkrTHV2TXd0?=
 =?utf-8?B?OXZXOW1ncXJabW02enRMb1lFRms1R2I4bzZXWW9ESUZRZU81T0ZyTnZYOWRM?=
 =?utf-8?B?bTZUNzJZWnNCSTYrODlWcmtmU3Vad2xnUjdXdVo1Sk5KdUNMbGNOVzY0c3NI?=
 =?utf-8?B?THdyMmRkNklVK2h0dU1xbTN6bnV5YVJPcUV6QzdmejhXUjdENEcxSG9HV2hl?=
 =?utf-8?B?SWRRbVZCMUhIUGJPaGdPeWF5VjVINFJJWlUvdWFMRm1RNUxhRjFwSzRlaUZH?=
 =?utf-8?B?Sjh2UmJtZDRZZDRtclYzS3BMckRrOERvREYvaVAzQlkxcEU5UWk4ejlnVy9i?=
 =?utf-8?B?SVpvMTRhWEJ6TDhrbHJqTDRtQzFrajJvTzFjdjBsV2xjSERhT3g5RS9Da0Ey?=
 =?utf-8?B?RVJZbmRBS0ZaTmtqdnB1Yy9vUmludzZOZm5KdDZCeHdNNHBqbThlb1FXdE14?=
 =?utf-8?B?ZUJORmttVUpOR051cjJoTG8xb3hKTndJaUdjeU5kYjdzSFBGbnFWZlJvTm5E?=
 =?utf-8?B?NFM2SVhGY3laUUg3cnpYZkc4RjFjQ2FNMmFwL2ljaVBWK1ZaU0V3VFBnT1dw?=
 =?utf-8?B?TzVXelBwakdKZ3FTdjI2cGo4WmFvd3lBU2NTZExNVkVVZU40ckFBNTJlbTFt?=
 =?utf-8?B?alVqYWNYRUVaRUI1bms5YzI4bUkzUWY5WTJ3c3lFOEhpZVhyK1lIemtXV0JL?=
 =?utf-8?B?VTJkK2owZ1NCZmtHQVpFMm9DR2Y0Q1ZUa3pFMTBvME1tdlRyMEZrbGY3SDNX?=
 =?utf-8?B?ZmZUL2w2RTA5L2lwUnFPMk1rdmV5ZWdldmZWcVpKV2lJa0gvN1dMc0E2M0ts?=
 =?utf-8?B?Q1Q3dXdkZ0FFS3VMcEw2WEZnNDNCV0hlQytHSy9NTFk5MndJQjdmQ3VJT2JT?=
 =?utf-8?B?eFlBbWNTK3VRK0JwN3pRVXo5SW4yY2I5ait5ZEcybHc3eFdsOW8xbityb3Fw?=
 =?utf-8?B?ZlR5SlFMdW5LcmFueEhTU2tMZEtqcjVXVkVDNHpWcHk1WVU4ZElmVDVrOGgw?=
 =?utf-8?B?OUpnOS95MjdNeTYvZTl6RjFWd3FWL3hFUlZ0N0Z4dnhlejh6YW5hVWpnVkds?=
 =?utf-8?B?NXBFRG5SWU0zdnNTSnExdXAvR3g1YmJGY3d2V25EbUp5SjBmNzlMQURocFJI?=
 =?utf-8?B?RlJxelVjUzRBelBTeHhtNVpWUW1jdHBxb1VhOFpjc3MyNmRaazRvQ0VEOGJL?=
 =?utf-8?B?UGlERTlXZXduNGc2eEZWaGZxbjUrYzhmVDhETDRCZ3dBZ0k4N0paS21JOGRI?=
 =?utf-8?B?VWVRaHFhKzJWeHI0UkQzclJaOEgraU91MEcvRmR4WjlxaStTcFNEcGVRQS9q?=
 =?utf-8?B?WC9oODVQdFZjUFRrV2JSQWt6MnQ0Z2tLb21MWjhwT3dtcW0wRFFCcXd2WDdn?=
 =?utf-8?B?TUtPNHRJN0ppUUZJNVpMc3d5VWdLVlN4S2U3djFtaDlValJCTHhncTJFTFNz?=
 =?utf-8?B?dnNEd3VKZUVFUnBIU21pTzdOVzZmdWllSDQ1U296OGlvQWltWDBrM3hiaS9K?=
 =?utf-8?B?eHF3VithcGlPQnlhcjhJL1U0QlVxZjBWSXpTa2N6VEJ4b0U5eStyYVVmaUhT?=
 =?utf-8?B?UlpWS3N3SExkUENmb091VE1jR2lKNVZ3WlI1amJaVWYrTDFLU1djbkhBcTJz?=
 =?utf-8?Q?mCFTYlpRdMilTOhZ/r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098c615d-a44d-4644-3d98-08dee18d6288
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:50:49.5333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfupY5tDyM4zWi7tbfWvEvdx6KJBD/WiPk02rGRKkqi8jQ6RgQ/3+2OcCla4g/ra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

On 7/14/26 10:02, Srinivasan Shanmugam wrote:
> Signal QUEUE_RESET EVENTFD subscriptions when hung user queues are
> detected.
> 
> MES reports the doorbell indices of hung queues. Use the existing
> doorbell-to-queue mapping to resolve the affected queue without scanning
> all user queues.
> 
> Consolidate the queue state update, reset accounting, EVENTFD signaling,
> fence completion, and wedged event notification in a common helper. Use
> the helper for both the original guilty queue and additional affected
> queues.
> 
> EVENTFD remains notification-only.
> 
> v2: (per Christian)
>  - Use the doorbell xarray to look up affected queues instead of scanning
>    all queues.
>  - Move queue reset handling into amdgpu_userq.c.
>  - Consolidate queue state updates, EVENTFD signaling, and fence
>    completion in a single helper.
> 
> v3: Rebase only.
> 
> v4: (per Alex)
>  - Rebase on Alex's "drm/amdgpu/userq: properly account for resets".
>  - Preserve the reset counter update in the common hung queue helper.
>  - Use amdgpu_userq_handle_hung_queue() for both successful queue reset
>    paths.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 39 +++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 72 ++++++++++++++--------
>  3 files changed, 80 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index fb0d335875af..65b20d7a4b18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -135,6 +135,34 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>  	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>  }
>  
> +/**
> + * amdgpu_userq_handle_hung_queue - handle a successfully reset hung queue
> + * @adev: AMDGPU device
> + * @queue: affected user queue
> + *
> + * Mark the queue as hung, account for the reset, force-complete its
> + * fences, notify matching QUEUE_RESET EVENTFD subscribers, and send
> + * the DRM wedged event.
> + */
> +void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
> +				    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_eventfd_mgr *eventfd_mgr;
> +
> +	queue->state = AMDGPU_USERQ_STATE_HUNG;
> +	atomic_inc(&adev->gpu_reset_counter);
> +
> +	amdgpu_userq_fence_driver_force_completion(queue);
> +
> +	eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
> +	amdgpu_eventfd_signal(eventfd_mgr,
> +			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
> +			      queue);
> +
> +	drm_dev_wedged_event(adev_to_drm(adev),
> +			     DRM_WEDGE_RECOVERY_NONE, NULL);
> +}
> +
>  static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  {
>  	struct amdgpu_usermode_queue *queue =
> @@ -167,13 +195,10 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  							 queue, NULL, NULL);
>  		else
>  			r = userq_funcs->reset(queue);
> -		if (r) {
> +		if (r)
>  			gpu_reset = true;
> -		} else {
> -			atomic_inc(&adev->gpu_reset_counter);
> -			amdgpu_userq_fence_driver_force_completion(queue);
> -			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> -		}
> +		else
> +			amdgpu_userq_handle_hung_queue(adev, queue);
>  	} else {
>  		gpu_reset = true;
>  	}
> @@ -247,8 +272,6 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>  	xa_unlock_irqrestore(xa, flags);
>  }
>  
> -
> -
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  				   struct amdgpu_usermode_queue *queue,
>  				   u64 addr, u64 expected_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index b69621311b80..526e007e300e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -180,6 +180,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
>  int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
>  void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
>  void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
> +void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
> +				    struct amdgpu_usermode_queue *queue);
>  
>  /*
>   * CP packs the per-process doorbell_id of the queue in
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 3fad95199e0c..27adcea7b9a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_userq_internal.h"
>  #include "amdgpu_cwsr.h"
>  
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> @@ -238,34 +239,55 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
>  			  unsigned int queue,
>  			  unsigned int db)
>  {
> +	struct xarray *xa = &adev->userq_doorbell_xa;
>  	struct amdgpu_usermode_queue *uq;
>  	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
> -	unsigned long uq_id;
> -	int r;
> +	unsigned long flags;
> +	int r = 0;
>  
> -	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
> -		if (uq->queue_type == queue_type) {
> -			if (uq == guilty_uq)
> -				continue;
> -			if (uq->doorbell_index == db) {
> -				uq->state = AMDGPU_USERQ_STATE_HUNG;
> -				if (use_mmio)
> -					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
> -				else
> -					r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
> -				if (r)
> -					return r;
> -				r = mes_userq_unmap(uq);
> -				if (r)
> -					return r;
> -				atomic_inc(&adev->gpu_reset_counter);
> -				amdgpu_userq_fence_driver_force_completion(uq);
> -				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> -				break;
> -			}
> -		}
> -	}
> -	return 0;
> +	/*
> +	 * Resolve the doorbell directly to the affected queue instead of
> +	 * scanning all user queues.
> +	 */
> +	xa_lock_irqsave(xa, flags);
> +
> +	uq = xa_load(xa, db);
> +	if (uq)
> +		kref_get(&uq->refcount);
> +
> +	xa_unlock_irqrestore(xa, flags);
> +
> +	if (!uq)
> +		return 0;
> +
> +	/*
> +	 * The guilty queue is handled separately by the caller.
> +	 */
> +	if (uq == guilty_uq)
> +		goto out_put_queue;
> +
> +	if (uq->queue_type != queue_type)
> +		goto out_put_queue;
> +
> +	if (use_mmio)
> +		r = amdgpu_mes_reset_queue_mmio(adev, queue_type,
> +						0, 1, pipe, queue, 0);
> +	else
> +		r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
> +
> +	if (r)
> +		goto out_put_queue;
> +
> +	r = mes_userq_unmap(uq);
> +	if (r)
> +		goto out_put_queue;
> +
> +	amdgpu_userq_handle_hung_queue(adev, uq);
> +
> +out_put_queue:
> +	amdgpu_userq_put(uq);
> +
> +	return r;
>  }
>  
>  static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,

