Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810BC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 04:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9675A11272E;
	Mon, 22 Apr 2024 04:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YzsMe8Q4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F64B11272D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 04:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWX+ju9tJSvOI0zVNZhkShKiWI5377IN29SOTbQLYV4vRdOqXiPwfEMZuSd+4OU01rAXQeguMxtvBvryHWTFvC3rEmKo1tmOp7Sy8Wge3CZsDdoEVHm6e5zMd7y45iBBfvLjYJjlp+8770Ck3yHsCGVElXh5MbJOMtDOL8tyAGsMShW//ain2N+jS9j8rtsNsDiZRINkK4Q8LRBlzW0G1QBKoFue5y6Yl6vqfr5gKCObTUixGYWSJBcRX4HcL9Z6N7W92XSR/BQDrDua7E6hfw1Lb6rSCuHyPqE8NVqok7X9jMs+x+0NwJiTSnEYiLIFvODP0ZVYD77cYMn88xc/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd8dJuwiPn4bGsgdgHYUqukotQlCPxnnunOPviopYdg=;
 b=kDMAmaLqL4EOJKOOc7L2u9fZ6jwBs6Tox1PR+I6aQ1JzQZbvrBLt2g8F9OhqQSPB45veubG7fvLWv+PTsalbU03EwNDRe2H4sIaRxHa1Ub9RNnl9kyBVto51lRjTldaswPf7WL6XYLT8MslIwHK+CU2oNdn1gQPMEChL7oMJmFEQfmnzuwhPLMDu5oaRFCRy6nwEdhTSOi6NG1liNELzqfFSQg/YJhgUjUojQyFvn1iczcW7YqtD1oY6isCBORL8BQ3mOfUFi6AqJHLW0HTi7EQpHLIz4OOzKNcYi3rYz6MXhr1LSVUctzvPp38jsWuoudy7oP/UxLHaMmOPCBiJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd8dJuwiPn4bGsgdgHYUqukotQlCPxnnunOPviopYdg=;
 b=YzsMe8Q42594vr+OJpoJR+zsHqTCz6kZaudebhzbIscR7K6pRHWRlP2aJfrXT6NgMUguqF1LlRUE1aCD1raGRCWkYttwzfxp+54J70hd62D0X4WNI1U1DlG6mHndijxs0PbHFm8A2at+qArrjZTvVt2lDyyoHwlIqL9xK6WjU80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 04:32:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 04:32:06 +0000
Message-ID: <3d3e1c74-6f81-4e04-bfa4-39fcb89e45fe@amd.com>
Date: Mon, 22 Apr 2024 10:01:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update CGCG settings for GFXIP 9.4.3
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, alexander.deucher@amd.com
References: <20240422011203.2140619-1-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240422011203.2140619-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 488953fd-36ab-4afa-b2fa-08dc62852a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2VLNEdzUlVYSjU0UWg1b2s0dE1lVk9Tc2dBQW1oQjBabWlLeXJHd2xlQmdL?=
 =?utf-8?B?aEZvMktueHBjRWZGMllsa2VSUXkrTGsrZGZacVc5TllLT0RiU2ZLQjBSWmlr?=
 =?utf-8?B?MW1YUk5VVk9MV1orbGgvNW5tMEMyR005VnM1TFB3bjRaeGF1ODdqNmw4ckQ4?=
 =?utf-8?B?TkxBZk5OUGFPVzFKRklKWjVsREYrdXFycy9TTGdBUGtidzUzNWxpSXV3aDR6?=
 =?utf-8?B?YkNhRXVNNHhhbzNETy9HUGgyY2RQS0lUckJ6ZW0zejJaRW1zZEFURlg1WlE4?=
 =?utf-8?B?Qk5hSXJoNTU3OWluZWMxZDJEZDYzMXpCMVNhYWdqOGdPVVlrUHA4Q0NaTzhz?=
 =?utf-8?B?cy9JdEdDMlpubzFHVkJlOGNOZzA2UElLUXFTQW5ob2kvUlNFbXFtUTA0SzEr?=
 =?utf-8?B?UWh0UENabmY1MEVtWjAwemRZcFBrNFNNWHNxdGI3ZDZyZERQNm9ZQ1hxeW41?=
 =?utf-8?B?NVRkenh3VDBSeEd6SUhCMDFSOUJkQ3hzVFNTZWc5cXV1Y3AyMzFNVGN3YUJ4?=
 =?utf-8?B?enFqRDhCY1lqd3BkdXg5d2l4aE1KWmhxeUk2NUpyMFR2eEhhaXAwM2lzN3BV?=
 =?utf-8?B?TjVuL2hKUkFBK3VEMEgwOEdkSTc1T2RKbGVSc1JsVXJOdXBCOS8xUGJlZTR5?=
 =?utf-8?B?T2NuSllLSlUrVTR3RjJZaTlIbUp3WWlQcUcyZGtOMTNZeDlOL3VpZmptSVdl?=
 =?utf-8?B?c3NvWXZGR0R0MGZwM2VSbHJJSFdySTlaTmZ3Y0JVYnpQNWkxWUVMSUd6ZTZj?=
 =?utf-8?B?aEJhaks1Mk9adndSMUlvczkyaVlZR3lOZ3VmVldzYllJcUdGUnMxL3Z1RVo1?=
 =?utf-8?B?dElLaEg5TGE4QU5PV2t5dStCMVRDRkM1MHVrUmVvYU5TMS9kWWJQSDNIcUdP?=
 =?utf-8?B?SDZWMFZlQnJoeVAzK0VMSE9HbmEyTmRRZVJDU21Cd1RJb2NuNnM1NFZmY3Yv?=
 =?utf-8?B?VGNsM1NhTU9yeFJUU1I0M3dpZUx4cUk3bEE5TzJxQmtYSTJ0SGxiUFdjeTFa?=
 =?utf-8?B?Y0krZGg1WVBHWldXdXJ0a1hrQ3Vac0pHem1TVUpOWjJMd0NRTjljemlqc09X?=
 =?utf-8?B?MkxWbG1uQ2VjT3Fsc2VhUkpzODdxT3U2NkF5MWVNYWFTbXZWc255OFRQZTdy?=
 =?utf-8?B?RFh2Ly82d2dCNTQ2RlZsYU01UVNxRGdabU15YUN3THpvRDlrMVRBNjI3Qmlx?=
 =?utf-8?B?NWFxbU1kc1ljR2s1TElyakZ3RlZvd3hXV0hQVTdnMllSdEVPN2pibGo4dkMw?=
 =?utf-8?B?NXFnUUVGNnNUL2t3dVpvVUcxbHBmQ1h6WTV4V3p5c0dlck1RZjJyQ1N1cExK?=
 =?utf-8?B?MmdndlZDVkpvWVB1NCtjdmRvYzNUOTMrM3hJcHVidHRpY3NVNEVCcHI0TGpo?=
 =?utf-8?B?RTFDSUNwN2dMRm1iOUJUWHJ2ZHIrR1hHWG9pZmZkTUF4RVY0TmdMTFdkbWht?=
 =?utf-8?B?Mjd3T2J4ckg2dzI0OW54MGpvbmxmTVl2NjVsWW56aWEvWUptN2tqRkRKZzhi?=
 =?utf-8?B?TlZlM2hZRzJsZ1FnT3RmcS9uNnpUeWNtaERCZUx5Y3NRQlZSK1NqRWg3VnFN?=
 =?utf-8?B?UjNWQkQzUDRaOGNsMnRFc2ViQmt6aDdBaFBYa3BFNkdERE0wVHViYU41ZTgy?=
 =?utf-8?B?VlVpQmowN01uKzJxN2VNcmNiU0pkTWhGbzUxR0pUTVpkN2xLOHAvYmw2U2lB?=
 =?utf-8?B?TUxwRTZFdjZSOFEva1ZsL0JZMWhMSmhudDBXZnJsck1WdUhMeVFTMTNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNwOFlHcWc2RXJGc3Z2cnRKcnVBMm5QM1c2VWM4L0sxOWtSMUowd3gzMURD?=
 =?utf-8?B?ZlN0clFvb1lXZ1dBd1dWQ1M3QlFKYytRRlppMzRuN1YyeVdQZzZ2WTgzZENR?=
 =?utf-8?B?T1RVeldDWTIzMXppdzc4TWZtenpzWTJuNUExODFVOHp2cEtSMHhlRmxsZHNP?=
 =?utf-8?B?SWlFdEpGYk0yKzdMeDI0ekc2bUp3dHp4SkVGeldDVTA1Q2hzbFFlV0RHTkQr?=
 =?utf-8?B?Q2ttdVUxMWNQQVBIek9sUk5XMlZIN202RGpnRlVEOU5GUnU4NVNWQUEvWmI4?=
 =?utf-8?B?VFM4SlZTdC9HeS9OWFhISkhHU3Nja0lqT0RIdldJRUQyWVJqdi92UENPQk5Z?=
 =?utf-8?B?Z3l0alJjVWhJQjVFL0JvQVMrQlRDUnQzcEpCNlZLYkY1QU43d0JsVGVKci9m?=
 =?utf-8?B?Q3hBWmtwd3l6ako4d0lCR3ZYL0tIV2NpN01Gak5zNk5yK2RSVzJZTExvWWFx?=
 =?utf-8?B?bWZpb0g1QngrUUpHUEkrbUlQNSs0cHpDcW0rS2N4LzFvWDV0UnVyRitOVWRP?=
 =?utf-8?B?cW52T0tDb2dkWWovSGhLYi9zLys1NHJ6bzJYN2N4Vi95ZFU5N0lsUkx4VXhx?=
 =?utf-8?B?N0NFUDNFQVVKSlFnaHZsbGNrZlQvTFRLOGJKWTV0Q0YyTkZJUGdCNTdLUjM3?=
 =?utf-8?B?MFVtZElob3dXN1VUNDlZL0NlMVdmbTZocWdoNFRlc3NXdzdGUnZlUHBkWHR1?=
 =?utf-8?B?UG9wNFZVTFJpS0JNdFRTb2owZTh6b3R0RlZNcFlMMlNmVjRsYzFJNDJibHRQ?=
 =?utf-8?B?U0ljaW5NTXVLRjVCMmMyaHVmSmVaSU9yUTF4VUdmTnp1Wi9vakZIVE1JTy9T?=
 =?utf-8?B?UGwvM2MwUDdIeGxVZm9XcHVVUEFYY0E5dERESUVJaHhKS2tYUFJaY2FqY2Jj?=
 =?utf-8?B?R1JYeHRRN1dtMGRoajBUTzllOHdPelJNMFdMZXNtWXVsdmF3NXRzdUVaT3JB?=
 =?utf-8?B?Mk5oQUoyd0l0VGhmL0hjM2JTS1ltUjdWd2R0NFpjRzg4akgybmllR1FabUc3?=
 =?utf-8?B?T3dxR0cwYkdpelJXMWMwMDJyTXdGcktMU0ZFME1odlJMRlJMTXBHTmNJZ2Ra?=
 =?utf-8?B?VU5SUTVOc0xHQWt1WVM0ekR5bHZWRUdjdFNsTHF4U1hxdzZEbDVhcDVZcTBZ?=
 =?utf-8?B?c3VBaS9GVjlrVEVYdU5pcU94emY0c1ZHT2JDN1lsWTdFS3htZjcrem0rT0hZ?=
 =?utf-8?B?anUvTlVjM0pVczVuTHp2VG92T2tWc2h6V0p6WUowRGJ0TU9XQkpxOFhTd21o?=
 =?utf-8?B?bktJRVprbEp1eUZ0aGZCdWxDUElyVlI4eS9mbTkrb1Z4ZXRMMXpPR0Jqc3M3?=
 =?utf-8?B?S1BtRkNFWUZwZGxRRlpuNGJpa1llTUh0eEtYc0w3SFEra3daMXViNHJkdzZh?=
 =?utf-8?B?a0tIcDVGZmppU0xDUks4dTExb21vcC9DMEdqR3JXTW41QkkvRGp2ZHRmRTJ1?=
 =?utf-8?B?YXNDQ3RtKzhkYVhCb1FDYzlOK0xHYjIwcXFyR0RVNTQ5U0NNWThJazYxMlA2?=
 =?utf-8?B?MWw2NEV2VFJhSHJNdXBVMUJRdmZML01WZlBEYTZPT3ZHaUhwbkhUb1dBMFFr?=
 =?utf-8?B?MVdROVV2UTR5YTg1UEU1NWhxUjYyL0FrRnB5MFU3RkNuaDU5QjJwWjdlUW0r?=
 =?utf-8?B?RitkVEZjTEc0ZzBPUzQ2RC9UTEQ2azlUandtVE92Q2oxNlM1YUIxd01JdEJ5?=
 =?utf-8?B?VFBvaXBBNzZBaElpdTZ5ektyaFh1bDVZenZKWThLdk1scnNYNTd3WGEwTis3?=
 =?utf-8?B?Vy9HaGpQVEZGSUZ0NjRxUzBWdUpPZ0ZPMlVsN2FrclZ6TythTXhNcU91SzIx?=
 =?utf-8?B?YWxNWlBIdFp6Sk95d2VaVDJ4eWVXVGpuT3Y1ako3MTBPZ0ZiL0RQREh2L2dS?=
 =?utf-8?B?OGJLZEZ0clJaMGJ1Wm9EckF1cHVUa01PRkFTK3BDa2pFYkxkUlNESHNNd2Fu?=
 =?utf-8?B?YUFxbjFmaWFKQzFzaDJLQUFlTnJ5NDdYTDg4MEx6WGtGc0ZiOElwaGdQT0Qx?=
 =?utf-8?B?WlBwc3g5dHZienRVV01GNGtJQUZVM3lQVzlXTmVZSncvNGpCYkJud0JyVWtG?=
 =?utf-8?B?U2gxT0hjVzlDMnVEdEpNUGxzN0ZUNEpacXAvY2ZnQVJOaEZLTTJJRkJVSlBH?=
 =?utf-8?Q?Sy7rfavM3qUn6mLR8DopUYOqm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488953fd-36ab-4afa-b2fa-08dc62852a4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 04:32:06.3184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDR6v23X7hj8Ewle7fqTZt5bC7rAMp9VvJsz8LUucWtHNA3fuSwfQWc2hncBIjy5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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



On 4/22/2024 6:42 AM, Rajneesh Bhardwaj wrote:
> Tune coarse grain clock gating idle threshold and rlc idle timeout to
> achieve better kernel launch latency.
> 
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 835004187a58..813528fb4f2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2404,10 +2404,10 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
>  		if (def != data)
>  			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
>  
> -		/* enable cgcg FSM(0x0000363F) */
> +		/* CGCG Hysteresis: 400us */
>  		def = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL);
>  
> -		data = (0x36
> +		data = (0x2710
>  			<< RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
>  		       RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
> @@ -2416,10 +2416,10 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
>  		if (def != data)
>  			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL, data);
>  
> -		/* set IDLE_POLL_COUNT(0x00900100) */
> +		/* set IDLE_POLL_COUNT(0x33450100)*/
>  		def = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_WPTR_POLL_CNTL);
>  		data = (0x0100 << CP_RB_WPTR_POLL_CNTL__POLL_FREQUENCY__SHIFT) |
> -			(0x0090 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
> +			(0x3345 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
>  		if (def != data)
>  			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_WPTR_POLL_CNTL, data);
>  	} else {
