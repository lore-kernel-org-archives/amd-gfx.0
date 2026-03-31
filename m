Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947D31061B39
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 11:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF5910E2B0;
	Tue, 31 Mar 2026 11:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHPlDDT6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52A210E2B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 11:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NACOgNc0m4GPMIYdGepXLziOpTV8DxPkP4+KW/1ZW1Fw2TskbWzK6QBFSpMFhxzOYN/axdBcuoxuWAGFZ+dQHbFy8EHrUXVtlDmrap5NXhmsG+fcVRcWyPz3m8Jg1k3DYB5qBWwdykcS0vgUJvJLlrapxItVC2LqUw2qACycM0yHtGjQIJWVh3028nA9pM86qtuJnwQRHA8sSkT8IrfKfV2421QpnAFGMbPGvxWkXT/WTIS/wLYIM3McW4Hnc9pObtWq6q0t7PtbuEIS4Cm6YX+OEiI/DnpqCNPGnQFWxvcOIvdPOzAh2fgqf/0S8iOYc0kUfJASCmOgc8yF4hBW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+IPq4R+ICFoWXeECBrA0PRFISwmzyDXY5BUaDwsSg8=;
 b=YNnLXg+H5TfMuGRRYutxe45JFgj4/4knEs7Qi9Xhv0Lsbd9QMbZtLr/cKgTI640N4qnAVrJDtTxfJGk2nOiMGak0f/TK2U7wW3hJ0/WLw4qoUoIuuoAfrTimyHBGhtoJUFaKioZq8k5B0nFfV3PdFrmB317N1LT5+Re+5QqCe7gVJn5I+jRHgTq9g1ux/41tMuPtdCCRWqKajr9kC9nsmca74XM90L6K0yP4X7Y9H/g/NasJa7hyA2uiXe3tDB4g09HwjbimoUOYSwO7HV5BxhXuNNk3PvEcLzbJkEGoz/vebkH+oy9UY65FTbtlcx1oT2MqdPyeFOJE5rieQoQVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+IPq4R+ICFoWXeECBrA0PRFISwmzyDXY5BUaDwsSg8=;
 b=fHPlDDT6PZWJWpOwF7x5mjnwsLmGTVwq//TRj53Mo9KgboT4kXJ3Ow1Bq9+RvvxR0H7qjxyNXG7n2b40hY572PY+pXmHfHmTbZ8OTvYZ2KUB2QJ0SoMZ9hZzxjK8P2RWcnjartiMiaST/wBI7Yfl8pUvVeE1+BS4mjYMNJ9E4qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Tue, 31 Mar
 2026 11:57:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:57:21 +0000
Message-ID: <4bb97e2d-b654-42fe-b680-03989960c2e0@amd.com>
Date: Tue, 31 Mar 2026 13:57:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/sdma_v6.0: enable WPTR polling for UMQ
 SDMA MQD
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260331095346.1331511-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331095346.1331511-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0358.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4efaae-04a1-4ff3-8a61-08de8f1caa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: I5I/4+NefGgamTjE1kZV+VA+KdTDe2HG5hG14e716DMmTh76lMImYEsxmGKXL+k0m50km5PgM2lYmZe/ldhsOJUVzGWFCvGIbKYFK1IMsRiaYbyrfw42FAilHNdtltF1iPfEeOUkXxlIQm1C7q3NlE6SM7n9O5wzxdPiaK6pfVWHWx6ynk3MVPB2NOx2lUca4AaFvFqmTwOOceHpElgnhIXnRBPwRHyQ00fyQLXTkImUtfNH5IzugUYfysrBfVg+k0qmOh5yGBzuW5BWpp1Uh3tBgt56I90AtbYSYsJguMHEBQ+ajwg/12VDew+MZsSJ6883kUkYzHy/YyJmrKF+OMyYdAZFp32M6R6iuX8vFSF889b7LJ51FxZ8VDbknYYOX69V3iiubBLBjvzzJbHee0iuvjcIq6otD70od4XPccwXcPRnOd7R8LM9R1eugZ1nxAwrtoK8j88wFgQDMNAH6HYb//AonGZlImN/joK3HmS1Zc/tBzpyrnHI30qEp/B3prgliJJNIHhs73XBcZnmTSJ4T7NWXe5BEhoYqqh4eUuuWLdR1MPWai7PM24MLQ6ZOJuxo/5DreA8aNJ/kLjvs76gP1aCvS3oYIgzJft3lY5B9el4dARFZ7sF8HVIZdXn10/R1vynxqhSP39Od4iC/3GeF1V4CTAEdS5GWI0XFZP7jPjAByJCek8HrpkP63nUsoEe/K1PyLCx4uwQdOeaEFUZZPVKkets+O0iBJWA4b8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDh4OFhCdU5Hc25Uc0YyQ1FYTmZ2Rmg3NVNsS2ZVTkVPNjR3R3pOdlF6bUV1?=
 =?utf-8?B?QmMwSk55UVlacmVvdkNob2VUaG1ZckFRN3NsbHpoUWR5S0h5d1RRS2J0SVpP?=
 =?utf-8?B?cGU2V2JNVndkOVR2ZzJLT1pNZzJXSzhKTGRTT0s1MmN1dTdDQllaejlEcTN1?=
 =?utf-8?B?b3BIdWxhTHNWSnVIZkoycGh6aWhxOUZVQ3doNmtVTjBGcTZVQTVzMmFQOWlw?=
 =?utf-8?B?T0k1ekpvWlVLUXBscGRVTkpGQ1EzSzVyaGtEUVJRVFVEUG5zaDVFNmJhK0lz?=
 =?utf-8?B?eFJFenJ5ZUNUVUlLK2l4Q2gvRmRReVpIKzJZYlpzZlkvMlVSODRlbHBEcW05?=
 =?utf-8?B?UVFWUTY1cHpOOEtWZHozdmtnNVpkQWdybkpHOWMvdmpSVWViaC81V1hpbUhk?=
 =?utf-8?B?SEtVeGdhTWJ1ZjNQMWhUVHg4WjhlQnJITTMxeGxHQlN3dFo1Z0lPaW1mSDJY?=
 =?utf-8?B?N1J3OVZkU3Axdy92UVRtdDZ4eFpaWGEyd2srclNrSVZqQjJTSzc2UHZ0VEtE?=
 =?utf-8?B?SisycEJTd1FobHYyMjhubGpUSnJPdXVwemZ5Qmg5WTdJb1Bwd2tiN1lIQ2ds?=
 =?utf-8?B?NCtGeHVHdXdCNVhiTnVJMFkwZncrdFdKbWRSenNoMUExWlQ5MHBIM3dkcHdZ?=
 =?utf-8?B?N0JnMEw3UWd6R0o2a1loOGFwc2RoMzMxOXpXMm14b0phVnB0aHZQaWhRWmFk?=
 =?utf-8?B?aXhrM283OWkxZUc4Zmp6TEJtanRsL2xLc09TMG1kQ1g5c2lqUTFRdDFtSmli?=
 =?utf-8?B?MjZyUGQ2T3JGSTZVeEh4a2RYM2RJdDJrRkxGVklWQXVWd2x0cWU2THN0L0pr?=
 =?utf-8?B?UlBieFI2TFlEWFlUak1QcHU4MlVFb0E0K01tT2ZJWUd0ai9XMEs4cElJR1pm?=
 =?utf-8?B?dW5kRndQbE5YUG4rREswYkJhNDZQNXA1aTMva1hyemNGU1M4T2RjaGZDWS9v?=
 =?utf-8?B?eHpmOE84M1pOMmdERE9uZ05lMUhPa3VvdWlxVWV1eE1ZdjBZSmNMWnJaSkcz?=
 =?utf-8?B?RXVsTEdMRDIwQ1h6MmRrRmJpZmQzeTFPY1B1ZmEwbXgvOFZVSk9FQXFXbHlO?=
 =?utf-8?B?ak00RG9tVFRUbkcvTmpLdmtFQkdvZ2NyTW5mNDhMUVVMM3ZlZGVrQWxZem80?=
 =?utf-8?B?REhFbi9VNlN0eW5UMXhpdzQ1bTROWDFYMElVMzJzczJGbGpPUHFkYVEwSE5k?=
 =?utf-8?B?bUYxTklrdVFaOVplUmVYcVFJZ1Z6RWlvYVlPOVVnWmVIUEVQNTA1ZVZ1WXdv?=
 =?utf-8?B?YmFnQmJaRjYvQks0dzFKazFMZ25WS3B0NjRBZzJCVzVIaWMrN3VHa2E2Q1k5?=
 =?utf-8?B?WGRkbUpIZWlPM1FGWmJObFNCcFhycjlyMUNqS0p5WStMM1hiSzgxL1VWTkdI?=
 =?utf-8?B?cFFLRDY1Y2VacitkSTRLeHZ2SnFrVGhremtITFNKOTlBRGpyc1VHRUxlUzJO?=
 =?utf-8?B?RS85ZTVPVWVUOHo3Z2pSTlNXWnFuSXBnbjlFV2MxVGlIQmlyZDNzcFFwNzE0?=
 =?utf-8?B?Q1hiQ2Y1V2pKVlpqWTdJYStWQXEwakY2MWpqTVVoSFBwdDNPS1NIMzl2YjBJ?=
 =?utf-8?B?RUI1djRJODNROUMwVE9nSFNYTjdLY2krK3ZsYzZYMXlaYllsUjRLRzBOVWRS?=
 =?utf-8?B?bmVpb1dOdHYrT0hJd1lvN3lPSGpRdmF0SmRtaDdHejFaZkVaSElwTUN1UCt6?=
 =?utf-8?B?K3g0TnlxSHdYRURzV1RMa20rUnFUNWZvV3gzUXErTFdJM29HQ3oyQVpOdHBX?=
 =?utf-8?B?TVBDc1N2NWNzNzRGblUvNXAwRnIwTWJud3UydktxK0hwMlh1RTB0NnJianha?=
 =?utf-8?B?RWp5MTVmTkU4YUNSajRUakZNeXlkUms3WVM0YXY0VzNIS1VsMlRicTg4Ukt5?=
 =?utf-8?B?SVgwTEZPMXBaTDRFZDdnVWQyTlJ2VEZ1dmFUOEQ1SGI2RHlFT3QrU2hxQmxz?=
 =?utf-8?B?TTkvcHEwYkoyOE1EcnVPeVFia3JrT0kva3hSeE5CaTJrL2p3bE1YblRtaEky?=
 =?utf-8?B?K2g0VFo4Wlo1Mm9nRkZqbEJVNEpRa085R0YyYU0yTTlXdXlncFl0LzhZa2JO?=
 =?utf-8?B?U1MwejE4K3d3c2lwSEIvMzc0MnJvY09KRm9HSHV5RkpoaFRLTkxObjdlR1dm?=
 =?utf-8?B?Z0Q2MjVOa2FGQ1p6Q0xKSmx0OHk1emg2Q0UzUVQyd1NvN0h1VU40UFlmckpE?=
 =?utf-8?B?NjFjd3dnTTZUdFpkdGhkeGZsdFpDcjVKMGZZcG1Nb3dEMEovODN0MlNxQjFQ?=
 =?utf-8?B?MTB3Ym9TWW9ZN1hxUDMwMjFENUh5VmUrVmNkeExXK3VLbGROMUNoaVpoYk5j?=
 =?utf-8?Q?Z4l9CYCCUDyccvmfoH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4efaae-04a1-4ff3-8a61-08de8f1caa1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:57:21.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVIDIjUu7OL6dZi66Yi22NSgaBqm1IOPI5VU0MwvFp9MMeKT+Ote7j8lsZRjjPUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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



On 3/31/26 11:53, Jesse Zhang wrote:
> UMQ SDMA queues can stall when only F32/MCU WPTR polling is enabled in the MQD RB control configuration.
> Enable WPTR_POLL_ENABLE in sdma_v6_0 init so hardware can reliably observe WB write pointer updates
> while keeping the existing doorbell path enabled.
> 
> This fixes UMQ SDMA submissions timing out on subsequent packets where wptr/rptr no longer advance.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index b005672f2f96..622518483c6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -863,6 +863,7 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
>  		order_base_2(prop->queue_size / 4) << SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
>  		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
>  		4 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
> +		1 << SDMA0_QUEUE0_RB_CNTL__WPTR_POLL_ENABLE__SHIFT |

This enabled WPTR polling for the kernel queue which is clearly not correct.

My educated guess is that this only works around the problem because it keeps the SDMA awake.

Regards,
Christian.

>  		1 << SDMA0_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT;
>  
>  	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);

