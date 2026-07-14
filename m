Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42893C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C295310E09B;
	Tue, 14 Jul 2026 13:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I/Wk/2k4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E6C10E6B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPNEEcxHVveIjyG6Kwcj/lvbIeIWEqUJjowfcxzeOTAvGd3S5T8JtUAowRwoM64htOp0XcSwBsq29aXPzjfmblXmfef3Yuv0AuvF6pPC6kI9qq1me7vmB6fpuKrmFR4fE25V7oHrbvm3t7PSO2rh9BGJNl4OjETy9/06auEB2MxDccWoevF4k78LoduzwNriWqiRVZ2Wi0CIJ4r2CNUPoNhgi/9hQGfixS/pbrQOzbo25buU7Z2Tql9z86SyoLTnYuVlzNX8KmA3c4kl9uToq8RQt5x9JdiUec4pEAoLAamkBVLpQHdezQcUNu9XJBW+jGN8Bh49rcIHdQSldTDdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IhGDnVKYkDHOK0yfVcpO8tNFp8j3/jge2CfuYRAvRI=;
 b=R41YkY0B4SkNYQYHyrCK55UR2q7niri7sPbDYOrnv9t1AU8W6Ut8IsYW3mg8FCUI3jdIPnjUByUbaZcV3sNdQCKAV1Uc/XhRapWF38nmF0BOr+OKbixkRQy9qYVymD4iRmvHP3dLyJJw9H3FXaR6aghDP6hN3A4JXgYLWjrCpQdZy0qL29a/Ih+AMlqgPPQZcRO/0wuDR/Z6q0F7DaXj4RaZv0ktjp6mjfaPJ/TRAr20G4fX5kS8XuNcP6FO22vh0u3dilBM7xINc73Ay0n7M+MjClh2hFoqfPyE+JGXIeIhtomZamPOHZDl+oYiHKthoHNEy8Rw1rqQtDxiMl0+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IhGDnVKYkDHOK0yfVcpO8tNFp8j3/jge2CfuYRAvRI=;
 b=I/Wk/2k4/wHSfqQs0nA55KrXaj8LOu4Qjnv6COo8CNDBKv7USRvgS7PUXS9JjwCqMHn7JmhXS5CtaSsHTJOyS0v4F7pEvBMdm6zRFRKIwN01aNTXUSwhxUjp/6jwYfMt/TYPQNXYZQpp4U2pdWa11DptT2Z1LBjK3hcpnSNaGgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 13:05:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 13:05:38 +0000
Message-ID: <b40ff22e-2d09-4644-a4d3-a9cffcdaec6d@amd.com>
Date: Tue, 14 Jul 2026 15:05:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714081023.3395485-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:335::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: e60a05e0-b00d-4617-4862-08dee1a89962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IBigd0Zg3tGpOucWRzt9BV7ASiS/j1010er3pEBuAaD3EUQ536x+HMxi1MN/wG58M/qcClrRoro+zxNVrNxC5Sux/cK1N/Z3tqQ00GmqR+vqyfp47Zgo2s17wWvGKjhAqpbUxAfXqhC0qd7Ok0RrEMArb7K6rakJOdAa+omD/hybRwoQ2X1CwLCVE20Wz6iMMu7C7g1NaKJ4LQvoa+efYvmlAQ5aSAn7X6GbdDQoeECsOGndpdwXK+70Fy1N1DSCmBF1LAP2svffwHPjC3UOraWT6eEJhOtg4qxa1+u4KLhv6OnvpWc1wglNYOiKzMw2Yin7OfBnVViPt0Sl0kFhNLHKiXZ0UcgzEsc2IOfmTJIl2Hq0dh9ATjf8wFnrQqmePiHE3+ymZBUtQ8daZ0HxzyNY0Sm0ZQvZRAXb0OE5nywph5COd/RlWW2WJpjZOcdyzii9U7KnZuT8zux0LCsXiozj+Bff9RkThrOMZhuBT2/BpxPcQLlOkINb+a3s9oQoS2y3oDzW188tnSRw0TKwfZVbWW0tE7tjg3Vksc2MvCxAb84xNkaEarcUTPzEL7Yn3/egfW9zou9owpscy/CDSb4W8DObSrP/lZUGh/c1KLq0kL/HIXlQjytp54uhuH6MXTKheQEYeQgvMn3ZE2wnfyK/8YQzgQj6xicy+GJbydE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzlPL0EwVzZWajBLOEZNZ1ZUSnRva09obS9jaXl1TjYzZ0V3WW5zSS9mYUpJ?=
 =?utf-8?B?WFFIUVY1OTFvOXlncURCZnNOcElRQzVLV0NvYUVvQ0k4NjJGQVVZeGk2dkpL?=
 =?utf-8?B?QTdRcWlLN1M0ek5TTDU1TXBQWnRpV0h6TkVsZEhCVDVXcXlUenV1SFZkVUEv?=
 =?utf-8?B?Smt4aXY0aERyZjFUVEV6cUNLWUJ1RHE2bmFvZC9aUlNxNGxKa29sZmd5MWJU?=
 =?utf-8?B?dzc5NWtnanR2VDVNNU03OStjSW1NQUF6TkJsNEZKMGRSZVZ3NmI3M2RHWG41?=
 =?utf-8?B?VEczNjNpZys4aHFyZ0wyQU1jdjVDeEZRRTB4Q1EvUWhZN1l1aVFFdWtPSlU1?=
 =?utf-8?B?UkJ2S3NFNCtTMzhpVVRNN1dwSk4vZ3ZyN2pNVUlUTjM4MEJEdTJiMTF3aWF4?=
 =?utf-8?B?dDY4SGhNeUNPR01LU2o2b3N1TWY5cXpGZENCRXBieE1QQzdIZVY0WGt1UUE1?=
 =?utf-8?B?Q2t6ZjhyZ3UxUlFpajVGNTdFdGF1TXRiY2xmK3c3cHhpQlJZb25xZWMyb0Zj?=
 =?utf-8?B?c1N6NFdYMzJUcTlRL3RiMEd2S2Y5RTNyckozUGpiWVBLcHpwQ1NQMktVUVhK?=
 =?utf-8?B?SEZwbndPRDl2ODFnTzFqNi9DalB6UGRDM3QxRUlGRzhUTHliNEM0SzhwNGh0?=
 =?utf-8?B?dDBXRjhSNkllK2Mya1ZISG9hVVduTmprSmd2Unp4Nk5CVStiRXBsTjAwVVVn?=
 =?utf-8?B?Q3dvbnI5WExOd202Ky9qTnQvR2RMMnppeEIvbnJ1THV3c0kzWkdUVFNaVzZs?=
 =?utf-8?B?OUJHS0w1RFZOSVY5U1dhR2hGdkRlQlZ5NTdZcldlYUVEZG1FQUFMZ1dMcWg3?=
 =?utf-8?B?VG5oR2VUSVVZSFYvODYwZlB6Vzl6RmVEbTJreGN4SnlHZkNPZUFYNHdsRnRG?=
 =?utf-8?B?dnJXajMydm80M0FIMXdqV0VCa053TW9ycGp5blljNHlMb3hNTDRCZ1RrQVo5?=
 =?utf-8?B?TjJmR2EyYnBjRTcvTS84eXJFSUxTdFNNMzJJQ2dpVW05NXpsbzdNOTgxWEJD?=
 =?utf-8?B?bnBvSDRVdTB5QzhJbVU0M0pXVkZQUFNEaEdNaTl1VGJRcHR1M2JBMXBNRzRZ?=
 =?utf-8?B?NUg2UzhtbmdHUXBMR1VTc0hHMnFJZXllenprbi9PTWlNcWJjZVk4bWZLLzdM?=
 =?utf-8?B?NVVjMUVaNlViV0gyaXJOTjliT1V5RXNmcFJVY1FCMjZSNmFRMzdBS3JORXpB?=
 =?utf-8?B?NFhQUW1OeVMyby9sZGxhVTRiVldkVm45ejFDeS95d1p0UldlZ1ZYZHNJRlA3?=
 =?utf-8?B?dUJTZnRuUS93YnkxTlY4WXZOdWdJajFOKytQL3NkSyt4U3NPZlpIcjdsdTVj?=
 =?utf-8?B?NTVrQ25IQjVkUVNNYWVXWXpNajZkcW0rTHZhVS8xaEErdzFDU05ZVGZkOU55?=
 =?utf-8?B?emJsUTNva0ZxZDRZdFZaZ3RMVm45ZnZyaGFIbDhzbnJ1ZDVQeXM3d1RJUmFk?=
 =?utf-8?B?amlnUlhaK2NhS0hqRWwyU3kxaXhydVFSV3UxbzYveTNmaWZpbEVaYUwyYWtM?=
 =?utf-8?B?ZDdoNXVuQUZmQmxON3NWUGR6dHFBNnZOdWEvVWF1di9RRU1GeU5wS2lncm5C?=
 =?utf-8?B?NTlQOWlSVnluRUxpb2JkVDRLMThtOHNKVllmdmVHc29KcGVqOWN6cC9FMmpz?=
 =?utf-8?B?SHMwdHVMMy9Fc0txUlBScTc1NVZTZmpsNExTZWgrZmw4L1pFNTBBK1VuYUZJ?=
 =?utf-8?B?OVZ3ZVF4cDNEK2tzSGg1MjNreU1zdld5ZGlzN3Z1WFJrSG9jTHNZWk9Cem9J?=
 =?utf-8?B?K3VPUUJWR0lmNFZlWU5qM3BNeCtCSEp6b2ttNkNFSTM3TEtsZTEvN2hIRWho?=
 =?utf-8?B?UUhWeFRrSEdlYXhqdktiYWtiZy91cjU1U0kvRW9TNndmQVZnK1BBSUZaZm96?=
 =?utf-8?B?MGdpSmNna3VFWnUrclplN3RiK3BUK3U5Qm5DZ25yaGs3QnV2RVplZ0dTczk2?=
 =?utf-8?B?Qml5R0xjKzh3SU1uUzNZWCtpTTBQaW5EV2tFbmRubFBVZkdmUmJMZVExZ2Zl?=
 =?utf-8?B?cEJQYnE4L1NQaEFwRXZ0WjlqRXNBM3F0Yzl0SmEzbStCUzJUU2hQMEVpMWhE?=
 =?utf-8?B?T2tIM0FEQkJHWXdWbi9tZDJQeW1ycXZWUnBod0FUalZycG91YnVvSXBlRTVZ?=
 =?utf-8?B?MGNIWUdPUndsMDEwU1RmMUo5TFNqeWxnQ1Vmc0N2MlE0VytTWjdoVnVkUWFy?=
 =?utf-8?B?RVY1dHFrSG53cUpkOFpuQkZraEovNzVvc2Z5bW1ONzFMOXdzemp2WnRjY2gz?=
 =?utf-8?B?VmxHVWJlRmpscTlRWWpKREZLdi9VVHR6US9IQjBaWkZ5ekFNdWMvcE4vQ0pK?=
 =?utf-8?Q?9bwjRMLV3ggdL8dTFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60a05e0-b00d-4617-4862-08dee1a89962
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:05:38.0047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg9tUbWftLChTQtbSqsOtTXkww3D4qptOPrtCGObDzoe4zn+CBPstvWenbMjNXFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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

On 7/14/26 10:10, Srinivasan Shanmugam wrote:
> The queue reset path already resolves the affected queue directly from
> the doorbell and funnels successful reset handling through
> amdgpu_userq_handle_hung_queue(). Reuse that common handling point to
> create the corresponding WAIT_EVENT record.
> 
> Keeping the notification in the common helper ensures that queue state
> is updated before userspace is notified and that both EVENTFD and
> WAIT_EVENT observe the same reset. It also avoids duplicating the
> doorbell lookup or adding a queue scan in the MES reset path.
> 
> No MES or GFX interrupt changes are needed.
> 
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 28f9d3fe0e80..9e1d03eb31d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -166,6 +166,7 @@ void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
>  			            struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_eventfd_mgr *eventfd_mgr;
> +	struct amdgpu_wait_event_mgr *wait_event_mgr;
>  
>  	queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	atomic_inc(&adev->gpu_reset_counter);
> @@ -176,6 +177,11 @@ void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
>  	amdgpu_eventfd_signal(eventfd_mgr,
>  			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
>  			      queue);
> +
> +	wait_event_mgr = amdgpu_userq_wait_event_mgr(queue->userq_mgr);
> +	amdgpu_wait_event_add(wait_event_mgr,
> +			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
> +			      queue);

How are we making sure here that this wait_event_mgr doesn't go out of scope?

Regards,
Christian.

>  
>  	drm_dev_wedged_event(adev_to_drm(adev),
>  			     DRM_WEDGE_RECOVERY_NONE, NULL);

