Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA71075273
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B5D10E477;
	Thu, 19 Mar 2026 08:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cIW0bY8K";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568F010E477
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI7fJ0AIxD59AWx1RGb8WTGRklt2+qNzUAVS3U1x9Fer8EIKEVZLYPgwBCPBvZKa7+Y1LjG7djTpw7RRccGVaFgW50qtva07EMCKUDIU5Qx+wVIKldLGs36x8QWYv68/riBAiCqnS6htPAhy1PR6emt3AXhvbqxHrBhmVZOkdvcxsNeXZaogInXm8yulOmChn02zAhYZiSlJo+uab+Kc4bwYPUIpnVCfTH+hsZ8MXtb2tupGt4qxMb7/lV4mhRkBiw6MjWnjJjoSpO54F2lpKIJtE8zMu4z9RmI+szePU1AN84R5WgQ51LOxcTwWxlM7LbSDnGJZ6RhhZ2ok+6W11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8sT1U8U2eykQOvMJybDKoPoBPTwkOXCfEZOp847Pbw=;
 b=kypGmPeTCLDuncxJW3MspEdlCIrloL5olEjT7+aNNIky0T+U/uqc34sMB9aoN1EuFIWamsiZx05ezAMxssXFPtVqhCVXaR+JNVhsLtEhYjtdrBVZcI8ihzYzxBXEHaWrfNWFYMW82jRyUHNBHYmGx/+Ii4iHoZQvNvzXUwA2u9LkUcvsNO5MzH19hJOgrgReowLXxPtjFLoUzQp40wwVLaEtYy/d/CiipdBBvklk2U4yRBIZa6avZzEq3mRIS1WlmuvVKynrANMT4RqR+cokEQY0ZwzLD/rgiCrvokgltS0sI/uzAhY3IzlTGoMfppgbtuLo4VqgDyGDGGH8E9I8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8sT1U8U2eykQOvMJybDKoPoBPTwkOXCfEZOp847Pbw=;
 b=cIW0bY8KpvoFTgsKVa7OAtRnQDVawvmdeuhqSFLiY5BcujQ1nLfv0N6suzptsQmpBFGanY3LFRGxski2Q5OR6Txzs5hcS35bQn6y4yydK9NNHAMOieU47nsXeHOK+L71mtpvM5qy3lI0RCOOmgg2ibx570mUE4+aA8kduUd9suk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Thu, 19 Mar
 2026 08:46:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:46:07 +0000
Message-ID: <3e51e435-7eb2-41ed-ae8f-ca48703586a2@amd.com>
Date: Thu, 19 Mar 2026 09:46:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: fix the userq destroy dead lock
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alexander.Deucher@amd.com
References: <20260319082150.3324177-1-Prike.Liang@amd.com>
 <20260319082150.3324177-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260319082150.3324177-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef90bce-f77f-4367-0c53-08de8593f698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: WXa1KX61g4QFqqOm48nXmG4OirEQq4uTM6YCPgikXt4gEWTjG0rWr/9WqFODyfo10MplgY6kzuOpYLUKgsU048VEaiAGIrVThRL8M2wO4smTRPVPBi880dRPkj5Xj4s1RfsgvH657/NzyY5ykuAuxEDUEROjmTF3B56M+f5nAn31UpWVKBlsEQCbrtmvQa8d40gOtGQLwtFnHzqkS28R8lfRiBfhRrbEb814MpbiU+CduOigesdL3B5LUSoVJodsSMJVRJHoxIZvTw4kpmHuoX8IUx2F+/ykVObSKOP4HpTBYnD4jfbGcjnxMd4L54nEG/Kl6i1Meyk92FNhONy34Dd1pWB5dr2KFzM8de7mtVVV0jki6nqHL610nCzsLaayUD3j2qM0MCubTXlNMUsE0lbo5Fq3Yq5QGNVzF+miC/COvxgVOy3HOjjxl5iSGyEKmM2QqoIVGg1Y0Fdxmwv+R/0+3umsFOXAHyprY/rYDXNxIp7gbMeU59UljnbsfFNqFV/XNLgK5F7Mu11bxfmU4ytPcBBZsUryWKXiM2GAj4Pyf76MrsG/dxBqOlzQoAk+Dv9KrH2jSvWIPf9X/VSSaPcqRaow6szrKPxaVUe4F7q3ZkKSDNV8f0hZsAIteYwW14BO2ci0DciUrM2jctSsGqqi4hTQ68sE9XgLTTyDDcTHS1lwJdQSpFMxec5tB50SKFiSINzaDzY0YqwWse7PsHh1Naww4pqvWyhTKDxd1ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em5CQ0tJcExxN1EyOExUbDNOUTBhYXZEaVlhSnZ5UUk2eXdXNXJvcndybTZw?=
 =?utf-8?B?TXR6Z1ZvNVNVZ0taaFJ6WmNON3ROTmFRMGNsQjMrbUlBVnBoZnZtYnluTmVh?=
 =?utf-8?B?M09JK0xNYWtIbmxEdnZURlY1UVJJbi8zMFU4UVNMWWVGUDJPVkdxVXJSRjVn?=
 =?utf-8?B?VUZBWmhwY0JuR0RGc3lhNmZHQ0ZyVEpXOHdhM1hYeVBTdE9KRTlRVlhwcE0y?=
 =?utf-8?B?Q0RYcVlGU1kvTDgyemdqNXV1MThsWmtEWXBwK0NrbDFuR25LeGc5YnBDdmRG?=
 =?utf-8?B?VVRocEJyY2FwZkpXVDBNdGRwM29YcGgxWDJ6b0d3NGxXb29aZ1NlZDVlZjFo?=
 =?utf-8?B?TjdqM09kZGRNemVlaWdmdXVNaitVMSs5SFQwQXNEOXBtYkQ1RkdYSG1TVk40?=
 =?utf-8?B?Q0dkTmtINTBBRkU0WWYrV3QyU2RJWjhER3BSNWZiWWcxOEREOCtnYWhDVHRL?=
 =?utf-8?B?anRzM21UajFDMzJTU3JLWHh4aEZ4ZGxrR3lobnZxUWxsYVljRCttLzJKSmlx?=
 =?utf-8?B?dWhtd25YbTVnNkFGRXVuVXluZjk0cWxnSUt1RmUrUm41TFpSNUN1ZkdQNXVL?=
 =?utf-8?B?eGFmV3pmL1ZZeXJwRHBaWEdkYmJaTSt1cHYwT2dRbERPeWQyRjdySlE0VmhT?=
 =?utf-8?B?Q0xudTkrNXhxenpCOHZ5SXhLalZtbWlnL2hYdXA4YVYwbWpSNmZjdldNdkcv?=
 =?utf-8?B?V3R1elZSRmJwTlduQktPTzR0bGdTQ21FdFVLUms5eHhvOHFQRVorVFRqUTlX?=
 =?utf-8?B?bHlhNjRMSG1waXhSS2svSjZWb21FdXJRS0d3S3lEVnFCV21jZXVyRnNpOExl?=
 =?utf-8?B?MjNvNG5pQzR3dDZTOEFxSmJIRSswaitHdk1JdmZzRlBKUWtDbFFsSks1THFR?=
 =?utf-8?B?ZGxuQWxVV2JsUGszM1RUaGlDcGJwOTNEMGFWQ1k0eU8wWW5panBjWGx1Wlpq?=
 =?utf-8?B?OFBOOS9INThtTG5ZRTNVUlRKdE85dVdSM1pmQ2FlcnRiKzZlcE1jTUxtWEJm?=
 =?utf-8?B?dWt5SGdlMCtXU09JcFN5c3Y4aUJ4TXpMdDRKWXc2QmJLTlVCSXFkakowanRl?=
 =?utf-8?B?V2NsSzBnZmJmc3NnQ1d0VUZkNHJkNHBjcnlBVitvdDQxb1h5QnJpZVEzK2ZO?=
 =?utf-8?B?WlY0dUY0R2k1Z1ZRWUk2RW5LNHhRdzVSVWFmWWxxNFc1bUN4bGtDZHdTb2ky?=
 =?utf-8?B?d3Q5VStXKzd6MVlldjRBY3FrSVJWSmFSYUZZOG5BUlUxS0tVRkRGZ0lLb0RI?=
 =?utf-8?B?bjdOVXo4OW1GaDd5MFNPLzVXMkdPb3FIQ3lPQmY3YkwzV3Mzc0VBTWM0N0g2?=
 =?utf-8?B?TzUwWU5RWGVOdFBQNlg2VnZPcUNLZkt3Lzlaa3J3WHpqTEdQVi9NQVJiQzN1?=
 =?utf-8?B?YjlBclRLdWs4eU5mRkp4dGxVQ1o5UWNWNWJuVnRGT1VhaXlXdjBRc0JtVGlq?=
 =?utf-8?B?Ty9EYnBPUlA4bGhQVmdIS2cwVTFWSGhGdVh5QTdndUxOcTRwMW11anFQSHQy?=
 =?utf-8?B?U1MxTWEzQVVxM05GVkZMYldLck1uYVpBUWFkVjdVK1NzUXpoV2Vvdm82d3dS?=
 =?utf-8?B?bndtWmpDSFFvRlhEYThsSHFBSWIzQUxYL2pHb0x6aTlwWXRDZ1lLOTM4VGN6?=
 =?utf-8?B?Z2NXSjFnaFhVN29OMmZOWE81UzYwRkQ5cnlPYmxtWTdOTVRtRHQ3SWJhaDh2?=
 =?utf-8?B?R2labkNtTjhOTzlQYmZMTlpsSS9vR2NhN0IzenkxYmo1R2kxaW43T0tzQTNr?=
 =?utf-8?B?MXQ4L3Ntb0YwNk8yTjhwMFZMcURkcnNTQThJOUg4S0lqRndndHpWTHpQY0I3?=
 =?utf-8?B?dVJjZ3czMFBpRGx6OFpUMmJRZGlLcVUxZmhVcHV6VFFWS2lzb21RcjBBVDF2?=
 =?utf-8?B?Y2FuVTRuWHdlMHRHRTUwMWZCeDZkNC9SVXdEL0tXNytZSldhWmZZYVkyYUNy?=
 =?utf-8?B?U3FBUkFBRnd2VmZsRGd5UlFPNzFjaWNneVQvNml0ZTZuUGZUT1VhbkdLUkN1?=
 =?utf-8?B?Y3hPTjl4SElVZUJ4elE1eGp2UDJ6YjI5QTFldVZKYjY4eW9vdlFaQjhRMVJR?=
 =?utf-8?B?MmUxUlZkYVRPOVNwNXBPR0Eyek5rZ1FSQy9rQ3dEN0JhT3pHM1YxMkRQcmlK?=
 =?utf-8?B?UlVXQ1hmTXAzYWZqWDZDbkZWRmxWVVJRS0p0aTlXZTkrMTdZQUlaejVwQ1lO?=
 =?utf-8?B?Z2NvNmxuR3RZaGZDYmJCcDJyZnNwc29adzlTb3NDUEQ4ZlpxN1dLc1lLRGRr?=
 =?utf-8?B?VkFpRVllRjBWdmR2Wmo5MzhLMVZiYXlRMS9PcEpCNXJUd1hhMHJFSkJIVDlx?=
 =?utf-8?Q?adfzIl72d0kY7UGwCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef90bce-f77f-4367-0c53-08de8593f698
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:46:07.8050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l0BxV+H3mmWB+0DydCeWwSSR5ZJ8CztZzxzhu3kf49uW6j5ny7+TwLiRRuYdmxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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

On 3/19/26 09:21, Prike Liang wrote:
> In the userq destroy routine, the queue refcount
> should be 0 and the queue already removed from the
> manager list, so it must not be touched. Attempting
> to lock the userq mutex here would deadlock, as it
> is already held by the eviction suspend work like as
> following.

If I'm not completely mistaken Sunil already took a look into this.

@Sunil if you haven't seen that before please take a look at this patch.

Regards,
Christian.

> 
> [  107.881652] ============================================
> [  107.881866] WARNING: possible recursive locking detected
> [  107.882081] 6.19.0-custom #16 Tainted: G     U     OE
> [  107.882305] --------------------------------------------
> [  107.882518] kworker/15:1/158 is trying to acquire lock:
> [  107.882728] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_userq_kref_destroy+0x57/0x540 [amdgpu]
> [  107.883462]
>                but task is already holding lock:
> [  107.883701] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_eviction_fence_suspend_worker+0x31/0xc0 [amdgpu]
> [  107.884485]
>                other info that might help us debug this:
> [  107.884751]  Possible unsafe locking scenario:
> 
> [  107.884993]        CPU0
> [  107.885100]        ----
> [  107.885207]   lock(&userq_mgr->userq_mutex);
> [  107.885385]   lock(&userq_mgr->userq_mutex);
> [  107.885561]
>                 *** DEADLOCK ***
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 50 +++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index bb5d572f5a3c..c7a9306a1c01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -148,6 +148,52 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>  	return r;
>  }
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
>  static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  {
>  	struct amdgpu_usermode_queue *queue = container_of(work,
> @@ -627,7 +673,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	/* Cancel any pending hang detection work and cleanup */
>  	cancel_delayed_work_sync(&queue->hang_detect_work);
>  
> -	mutex_lock(&uq_mgr->userq_mutex);
>  	queue->hang_detect_fence = NULL;
>  	amdgpu_userq_wait_for_last_fence(queue);
>  
> @@ -649,7 +694,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  #if defined(CONFIG_DEBUG_FS)
>  	debugfs_remove_recursive(queue->debugfs_queue);
>  #endif
> -	amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +	amdgpu_userq_perq_detect_and_reset_queues(uq_mgr, queue);
>  	r = amdgpu_userq_unmap_helper(queue);
>  	/*TODO: It requires a reset for userq hw unmap error*/
>  	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
> @@ -657,7 +702,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
>  	amdgpu_userq_cleanup(queue);
> -	mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  

