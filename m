Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E84C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 12:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEC510F359;
	Wed, 27 Apr 2022 12:21:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E060610F359
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 12:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJA+S62RYpYR3TNlFh9kuEcbesrHvNoxjwqgzouFh4A+x3HYr9XPIC49iAAem3KCXkZfrQPzOxfC98x2sWO3ki2H4glLQ8Tcx6aiRkUdQFqFfM8DJdxXalfi3jhmi6v7YCQeIl8ZC673J2Rh99qqlxugUvGbfCuFKKlsn+yiDeihkMIpEtob3gtdgUtRffNjVX3G4Z1gpnTb8xobHfHzJZXuj9hyuOjqhHepsevPmu7RxraYuOKLxLYj8zIgksDZmRY1M+XX7borIMteUo7adNA+22EHsMiQTsajOe47fSkDC16kVZoKpqm0opzSbOxJqKpLcCICAIhWXzCGtJOPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynLS3+Nmg0+JwDY5t/KKk42l/5kCLgrpJFyVXm/v6Zk=;
 b=BaQWiEA6FAGMvYVlA1iXflm/jxQWnoGgY7nx7ctYG1zGnIhhEpP4bS3ni0r3KfBPIv6+LtugoncEVqFJcvJ13YHL3+jnzWmlS+6XjkfhRGTzb6+jothya59WmKq5mXAStlxa09uOyxoBSKGiQ4dFV/+oHMyDI0LOfFWX+ctwlI2maLWLJYdjo/1ksrL9qaopPblDD0BUVqfFEIhD27TB8dsyTVmJF0TNZw2yo5/zzlPbF3gbt+ulyrdPlyh/qJy712l6x8jxoeGPQJvkw2A4s2J6o0WhEUdfukmbP4HZvBXlP9yI5gctY963kGr5PJ32MupakVaY/br5glYLzTaldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynLS3+Nmg0+JwDY5t/KKk42l/5kCLgrpJFyVXm/v6Zk=;
 b=AEyEFcSlxjIxgwDVro+1V6IKeN630Dti7nvYt9iFAhwe49wDVOTLuYsxefS3ytL0JvI3kPjeqRYM8N2hcZmT0ONrjfdvNJrMIPoTxp4zgMKwaAmiu087sQc+oFRBXiU4THOjMebJzCJjzHtrKkRMiBggE9JMucWheb1ZW7V+ZpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 12:21:05 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 12:21:05 +0000
Message-ID: <b4368e77-b566-d187-f2f5-2df3ba87b22f@amd.com>
Date: Wed, 27 Apr 2022 14:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Ensure the DMA engine is deactivated during
 set ups
Content-Language: en-US
To: ricetons@gmail.com, amd-gfx@lists.freedesktop.org
References: <20220427120947.29053-1-ricetons@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220427120947.29053-1-ricetons@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e5184da-99b1-4e9c-446f-08da28486675
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40411EFD7FF09F15139D725583FA9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUszuD0DAEwt0NIOSasJpwT1xiFVrvQcC7i3XDxc8SxVp4TfwpmiRO3gAXF0le1l0ToylOJRA3MzSEBnc8Wr4otvNVWNv8FZ3knJ9hlTVGq6dR9iA4y6ZFXvTQWShQiFdUDYAuP9Ro8fjKA79jXgVmVGigPEo+G+0iOP/JcetkXbmqQKVnDpGo6v4GXlLuRMEpXhHXXpYicdJcUX7RQOWbjPh03TIIIJwAPmKugYOid3yMnfLzgNyIjKrF4QyFL9I0WOKgCs8cWKrIpu9R8zSh9tc2mkDF6g1t9ddlKtnWotmLhX6vr5qibk4s+4CIBoKdy5tRSxciNMX3ZJSdGB85YWVDHODzK971Zh4b68ngU4SLEcK9eFDuWVurzPx6r6QZjbRcAuQb6awtvkRuZpMfEltU70WvH7cxRh1BAUabP8szHSbBH2cR/oKVmhJMQiUY6V6tx/XQXiDzxCqt9+DOthYpXkTCXMrfVlhRgOaPpnUP90S0sHrHZofgo3vZ3UPIBPjjZCO8iPJSb3Ou++el8qZ625035zf2bSZlc9BbIgypPDdxNFyT4nlr6G3eHATt1RmYGDxwy8JRw3CojC++m8c1drs8wf8DwV8sI3G74FWotbyg8scxP04PqyLR9a7aAO5sOpGgUgAxUH2l8RisqSQyzfsZLINXd+xHpdDPhssn96loKe8r3CKLVNBAT9l6gDcZUsfTvrf92dmYmBLQntJXTETGEzTRkkct52KGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(186003)(8676002)(66476007)(31686004)(36756003)(6506007)(66556008)(8936002)(316002)(26005)(66946007)(6512007)(5660300002)(6666004)(2616005)(6486002)(508600001)(86362001)(38100700002)(31696002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lZM29USnlGcDMxRitJOXhyQWt5N2VQUVliM21QdVlCeXBYaFJ4bStNU1JI?=
 =?utf-8?B?SyttcXpvMXB3MENndHlRZ2ZQYTRmWWZmRTlmcTJjN0xnYjkxZm4zaTAwdGZL?=
 =?utf-8?B?ZU9lVVhROWJ3NU9mczlsSSttRW9TM2doWDdFamtBRkRBSUg3NXFCZ3pRbVVL?=
 =?utf-8?B?azI5d0xXRlFzZlN6dTdhUHBSWDQvYmdFdVMxVTRDSldSRVBlMThHNEhRQVN0?=
 =?utf-8?B?NFo4REgwNWd5RU05ZXhBeWhoaTgzL1NUazlpQ25rd0pXWGwxR0FETTRscjZm?=
 =?utf-8?B?dndLYW8zLzRFT3dyM3haRDV6NE5DR0ordkJ2N3VnanpCVDRkZGcvNW45WUVR?=
 =?utf-8?B?MndEQmF4VmtOQ1ZBVUszNVBONDFkYjMwV0VaKytnL2wrcWtDcUk5MGpaRFVD?=
 =?utf-8?B?V2F3K3VQaTJzMWFzMWhxQ2xkL1VDbnN5L1ZjUU5Fb2lWY2MvbGpiUCtYeFQ3?=
 =?utf-8?B?VVJiYmc0OERPQTUzc0YzNnd1LzkyME9sdi9Zb0lCUGZvL3VHaDVob3VtaENu?=
 =?utf-8?B?cFhJMHhva0dtM3dWbFRZMEM1clo4K1BvLzIxZlFHK0RuaVhkM3JoS1RueEph?=
 =?utf-8?B?NmIrRGc1cm1FdHdLZG15MW9qaGs3OVU3Y2piVkFLb0k3RVViWmpGSXFmUkNi?=
 =?utf-8?B?L1dYVEdqWVdyNjJNNWUrZ1lRcUllSyszSzdXWWVMZS9Wa25lWHhiL2gzQjFq?=
 =?utf-8?B?aEk5UHpKZEhCcitjOHQ2c1J1c2VvVzRmTndibG5vWE5RTURScXJ5eURhV1Az?=
 =?utf-8?B?RnZVamowUXA0eE5GWVVVbFluYTNFSXI0NVYzbytEeldZazY5MGQ4eXNkSklx?=
 =?utf-8?B?aVRCUDA1REsreFJKbEtGbHZTOE0zeWtVOVd6TDJXdldqRnhaLzFLSFFPRDlv?=
 =?utf-8?B?Ti9UQWdyL1lMbFRsVGozaGtBS3B4V1FmWURWMzdwTlJRa2NQRTIyTjZLRVlX?=
 =?utf-8?B?ZzIxUkFsb21UQnUrZUQwMmdCQ2xXVU1GbmhyVXdnTUpLT2RpaEpTZlhYZStl?=
 =?utf-8?B?NXJNSmVzZC9Mb0xtWFVETHE0TG4ybmVnLzdYb0VGS3VBblVuM3BUaVVuanRJ?=
 =?utf-8?B?cC9YV1FtY2FuUmFHSEZFdTd2ZndOWFU2alEyeElEaEdsSGNUQ015cG80c3oy?=
 =?utf-8?B?TFB4Qmw3cnBWZWJQSjgyT1oza3cyVnVQQkM3NXlpUjJsby9lMFJVMmhUWmtu?=
 =?utf-8?B?eHJmdjNmQ3lSU3Z2V1dTbWJBUGVXR0JuVEZhb3JoeHEwek9JLzNSbjBoT2JS?=
 =?utf-8?B?N2lrY1ljVTRRL0JTbjRlWGJsVG5JWHQ2WGVsRHJ3dCtPemtheVVpb0g5OEFQ?=
 =?utf-8?B?VmhPdERFSE1QOFRtUHB2R0RnZ3RiLy9OREtsRDh2NHRWaTVZRWdPTHd2RnRu?=
 =?utf-8?B?QWJpUTFOTVdtbUVMS0tSOEVuNFlyUXZDN2w1UDQ5Tmt5MzVqaU9lKzVSSnc4?=
 =?utf-8?B?SkRpU2JZaDYrUVptTSsxQUVTSy9Ea0pKb0MwRnQ1dE5mK2dROE9STUFrMFJY?=
 =?utf-8?B?MDhjUkJhbDJsM3FkdTFhRG9MMkxhOUNrdzZTWkY3bmkyL0RhclNJMmdQYWt6?=
 =?utf-8?B?THc1T0pVd1UwSzVGYm5UYzhYZHVUQTUvS0JwNGh1eC9LdEYyaVZLellyVitE?=
 =?utf-8?B?eWJZcE1pZnVGRlgxbzhhTS9lajd0cjcvQUxkRW5lQnN5blVNbjBoa3F1eC90?=
 =?utf-8?B?QWhVdmpmSkJkUVBSVW1PamRhYTNpVnpwY0Q1T1ludWxRdUQxeGpYR3pnNlpB?=
 =?utf-8?B?emE5YndmSm84VWlZdmxRYndEK1EwOUdtcU1hZ21aL2h4NFhubTYwa2d1NFBo?=
 =?utf-8?B?OTlFS1g3RE13Q3dZNHdiZWZCUkJaTWZCNUNPSUVLMkZhRy9oN05zVDczYmlE?=
 =?utf-8?B?bjZmU016MlNEc0xkbTF6RTR5ZEhlU2hPQTRzK1VzQ1IvQkFvZnZVamdrMU1q?=
 =?utf-8?B?c2YvcjZPZXN6dGhSY0M0ZW5WL3hzTXA0Rk1SU2dvL2czaEV1VllYN1NHS0hM?=
 =?utf-8?B?b0tmNE0zUkFFNWdOQXBJOVdaVENzcFljMU9jbjhOMzJHSStYOVFaS1ludk9R?=
 =?utf-8?B?c0dLWUxuMnJFclNvQmU2aWY2VG0wRjcvOGVSZGwydktNM3BSZ1MzbXZGVzBR?=
 =?utf-8?B?QkRVTVJ0T004SzljWi9INE81cm9YMUdIcVMzVGdmRjJOSWxicXVDMHF1U1hW?=
 =?utf-8?B?ZDJhb2hCaTV4MkduejRXMWRUSk9Vd0dKZjd5K25SQkY2Y3A0V04vZnBsWHpE?=
 =?utf-8?B?aDFKTHNaTlIrdlJYclpkOStQam9yaWZwVlo0aGFmWVhGSWhjVTdzWjlkZzBy?=
 =?utf-8?B?eEFDVGtWWjU4S2tkQTFrQ0JwZDMwSlpWUEprL3lxN0FRQlo3RFdtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5184da-99b1-4e9c-446f-08da28486675
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 12:21:05.3688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXYfgHKtoHRLO/gDmV2dzIgJQRZqgJ2KM7svp1rQNmBtNplyRWfwfni9R0jF54/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

Looks good of hand, but please run your patch through the checkpatch.pl 
script found in the linux kernel source.

I haven't double checked, but of hand a few lines look a bit long.

Christian.

Am 27.04.22 um 14:09 schrieb ricetons@gmail.com:
> From: Haohui Mai <ricetons@gmail.com>
>
> The patch fully deactivates the DMA engine before setting up the ring
> buffer to avoid potential data races and crashes.
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 88 +++++++++++++-------------
>   1 file changed, 45 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 013d2dec81d0..61d58e515fe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>   	}
>   }
>   
> -
>   /**
>    * sdma_v5_2_gfx_stop - stop the gfx async dma engines
>    *
> @@ -505,17 +504,18 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines context switch for an instance
>    *
>    * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs context switch.
> + * @i: the index of the SDMA instance
>    *
> - * Halt or unhalt the async dma engines context switch.
> + * Unhalt the async dma engines context switch.
>    */
> -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int i)
>   {
>   	u32 f32_cntl, phase_quantum = 0;
> -	int i;
> +
> +	BUG_ON(i >= adev->sdma.num_instances);
>   
>   	if (amdgpu_sdma_phase_quantum) {
>   		unsigned value = amdgpu_sdma_phase_quantum;
> @@ -539,26 +539,44 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>   		phase_quantum =
>   			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
>   			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> +
> +		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> +		       phase_quantum);
> +		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> +		       phase_quantum);
> +		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> +		       phase_quantum);
>   	}
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (enable && amdgpu_sdma_phase_quantum) {
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> -			       phase_quantum);
> -		}
> +	if (!amdgpu_sriov_vf(adev)) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 1);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> +	}
> +}
>   
> -		if (!amdgpu_sriov_vf(adev)) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> -		}
> +/**
> + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Halt the async dma engines context switch.
> + */
> +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> +{
> +	u32 f32_cntl;
> +	int i;
> +	if (amdgpu_sriov_vf(adev)) {
> +		return;
>   	}
>   
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 0);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> +	}
>   }
>   
>   /**
> @@ -571,21 +589,10 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>    */
>   static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>   {
> -	u32 f32_cntl;
> -	int i;
> -
>   	if (!enable) {
>   		sdma_v5_2_gfx_stop(adev);
>   		sdma_v5_2_rlc_stop(adev);
>   	}
> -
> -	if (!amdgpu_sriov_vf(adev)) {
> -		for (i = 0; i < adev->sdma.num_instances; i++) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> -		}
> -	}
>   }
>   
>   /**
> @@ -594,6 +601,8 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>    * @adev: amdgpu_device pointer
>    *
>    * Set up the gfx DMA ring buffers and enable them.
> + * It assumes that the dma engine is stopped for each instance. The function enables the engine and preemptions sequentially for each instance.
> + *
>    * Returns 0 for success, error for failure.
>    */
>   static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> @@ -737,10 +746,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>   
>   		ring->sched.ready = true;
>   
> -		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> -			sdma_v5_2_ctx_switch_enable(adev, true);
> -			sdma_v5_2_enable(adev, true);
> -		}
> +		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
>   
>   		r = amdgpu_ring_test_ring(ring);
>   		if (r) {
> @@ -856,7 +862,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>   	int r = 0;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		sdma_v5_2_ctx_switch_enable(adev, false);
> +		sdma_v5_2_ctx_switch_disable_all(adev);
>   		sdma_v5_2_enable(adev, false);
>   
>   		/* set RB registers */
> @@ -881,12 +887,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>   		amdgpu_gfx_off_ctrl(adev, false);
>   
>   	sdma_v5_2_soft_reset(adev);
> -	/* unhalt the MEs */
> -	sdma_v5_2_enable(adev, true);
> -	/* enable sdma ring preemption */
> -	sdma_v5_2_ctx_switch_enable(adev, true);
>   
> -	/* start the gfx rings and rlc compute queues */
> +	/* Soft reset supposes to disable the dma engine and preemption. Now start the gfx rings and rlc compute queues */
>   	r = sdma_v5_2_gfx_resume(adev);
>   	if (adev->in_s0ix)
>   		amdgpu_gfx_off_ctrl(adev, true);
> @@ -1340,7 +1342,7 @@ static int sdma_v5_2_hw_fini(void *handle)
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	sdma_v5_2_ctx_switch_enable(adev, false);
> +	sdma_v5_2_ctx_switch_disable_all(adev);
>   	sdma_v5_2_enable(adev, false);
>   
>   	return 0;

