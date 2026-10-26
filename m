Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9D606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eh788i/m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1758D10EDCA;
	Mon, 26 Oct 2026 10:44:42 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0709110EDCA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 10:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU4sLNoJdULwxMSE5umS32atIALL5gNv/hxYrg+5YLGUQgr5hcKYKQUOamS32aKcOsX0NUOYhl2M63DvpuL0rU1+rCLDjWEzPJFlB57CN3YTksMap4EhXR904NfyFonEUYYLln0nW4gqt3MvKFsYT6w6q0iq+D7/blZqGbR+RyIID6tc9U+GBzEaP/2rk894Wygv6BOsMgP9eX32rKnR/S3Xqmi0sUCB/XFpJADHssEjjUUxy/5eBqbvAEwvey9QQmzaUtyids+3EMEvjjuvkZ19HsSjVc6BYMuOYhBNIze2f54jAeEkodZy9tIQTTj+P1j8GjxeFaEaXB3NHR0/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stlmMNF10OQbRFJjiMgdmrc0cvuVvqlywVMf/nXtX/k=;
 b=NhaShV80Tth+ZB6lUgyJIQb3wFishypC0n29AkO4k6Ji4bEaXVPeQxMuIE6OvXALiTG9EuaHFmMUvaysNA7jKdT1b9BmXpnxbkaduNw6sFq0MyGmiEXaK2owPqLKXkt9+kwwrPu6K+kthAiG20HZvziy4XAtTTtVPJNFggzk9BzeUOrLQ2HM9kAw1hSILpR4U/NM/85P37H0PdnalInWAPisV/s4SGkPvMnRpY+zCkmPCwW8fPn1GxsNxEFJQcFA5kgbgL/ldJEhrKr0CELMNytPWXINR/1jvfkR0VY98t22lF4qLze8YEYP/xG38NsK1qevaHXrvCJ6jfi67xEHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stlmMNF10OQbRFJjiMgdmrc0cvuVvqlywVMf/nXtX/k=;
 b=eh788i/mpBXy9CU1QkY/o5RnumEzOBOCrwPpCo8kVs+Nkp+4BYGC4RGrrRVzwBtTOvoQnQk/q1PDymMJmaVVVqZSw86U1fT556W5abAQVvZ4JmRaOgQM7KGpMLlIBgmJ7RmdRnKJSvSDkCSeBroV0hnXN0ZW1bN29sPjXjM6JRE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 10:44:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:44:32 +0000
Message-ID: <10685107-8aa0-470a-916b-749c929c4237@amd.com>
Date: Mon, 26 Oct 2026 11:44:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu/uvd: don't allocate or lock BOs in the
 direct IB test
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261023083422.3049246-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ce7578-fc18-4abe-2cd3-08df334e1e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0ALyTGnBUXwBJB/mlm0W/RdUxxvJH9F/oUiMlDEGOLCiNR2fzcwmvu2LjK2lGO+gKE+J515DtlGZOVhXCwi+8LGmoVEN5L+8XgTiM2QsU7IzYSt0UNpDjTNzYcrdSe7QY6Bk+OE/7gYnPyOk5sDkPD+Br0bBNQQ0CknbOo48MHvGOIzKgbXiLSlhyw1VJ+boBb+5HS6U5NqyW0Yg324glU3kFJFWBPEthU8ICgm9Lm1l0Dtt1TQIon6XgOvPkrVR4WUmm64yeZjNJuvbumH4DMAEZyb1sjJs1wxuJftYn66CXNYRdC7TVFBgQX9KGfdCaX9nSy7cmamWjBV0M2wpi3vgbjHoBZQyfyAQWtXlqdQoO00KSnQM/ng5JE8ypAP79s7OGYDK0jy4BL6+3ZFMNPaNZG/oTOPHIX+n7RFqLc/VRXX4WboIaqd8WR8D012K8n8H1gD83bVEGx2IHm8LxwxWLKxONlfYpN6BpDHjPN4jBV5b8s2f+faGvzO7Wxc9Ozj/kvOSuy1O5hN36jdlEBf7vLO65UmyGgOFvKVaMK3OtHAhJF5vuNfTfct/d2pN17pO3MLmaZ9KF7qszyWbjiQb75Te+6mcnShLrwHhyrC+5UYnf8Am4BK+h2etqyA5LhKerz20xUWBFpN9i7WsYNNLliJtxYn94AnpH8SyaUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VWTzhOVHJVVWFFMHhpMVdMbWpiMElNOGJSUis2cGFMNXY2b1Q3WWg2YjhK?=
 =?utf-8?B?eVBtTGJmWGI3NjJlMXhiUDE0SGJBa3RqeW5odlQzT2hVMlJPdjZjSVgwRi9X?=
 =?utf-8?B?cVlpeTFxVG1HdytMcUVqcVVqUWhNOW9LTmhNM3VzaGRpVFNuMU41UzFmclBt?=
 =?utf-8?B?UjFENTViNUl3SlJ3M0E3UnZWZHNva2h2a24wbGt5VWJodFNFaFVpRWhodG41?=
 =?utf-8?B?NkZQWVd2SWdGNEZHRFkreVlKaDl0KzZoYVJoU3p0d3Fsc05KMXpreDdzT1BU?=
 =?utf-8?B?cmI1VUhPZVJxeEtFajhqS2ZYL1cwTDRJT0luclVUM2d3cFl6b1ExRGQvbkxQ?=
 =?utf-8?B?YTZZMU1nM29hSzNLRlRsS0ZMZE5CWllUWmZlSHpySDRDRTRnbnZvUVRaNzVh?=
 =?utf-8?B?RGg2Q0MrUXlZUW9LRlNMUWVNMGpaZnl0TDhtWEMrTCtXczM0QXJHVWhNYklJ?=
 =?utf-8?B?Mm5Pa2RPVnJiVDRScTlsRENWK0kybWdWOTMvMjNKcjRWUThDY01hMzFGeE1w?=
 =?utf-8?B?bndNMVJYa0Z4YktkcnRMT3BjOGtDN01CYnJ3cDV2OTdXejZlNEpuTnJ2Z0JC?=
 =?utf-8?B?LzJTWHMwSE5oWlNYK1ppc0hpSnJqV1VPbUJFM0ZxRzNsZFJMTjZyN2RCdENB?=
 =?utf-8?B?TFhvMlNQK1NabzBFTkc3amZUVjFhSURxL2NZc3JQQTZDRXpmMW9oZEZNQTVS?=
 =?utf-8?B?RFEwUEJXeGFQMWhiRVROK2xkWDBOVjFxdEN4b1lLYmZkS1NzOStuN1ErbWhn?=
 =?utf-8?B?S0lFZDc5Mm82RVVJV25HZjJ2NkpsMlNYeFBXb1hNWlhDbnZlR3FRL0w1VkY2?=
 =?utf-8?B?N2EwdlhRNENOL3BJT3Q5ZHpmYnFPNVl3SWlsNmJYcG5Rb0JFU0FpeEhIOFRR?=
 =?utf-8?B?ZE9EV3hpbXlXNDB3QmFNblNPTGdIMGpxdVIvNEVsYmdyU3hqV3RwTVJId0tx?=
 =?utf-8?B?Vk1ZSXgyMDQ1YVdGQVJHd0VBUVRtZE8rYW8vaDRFcGtuY1dqVndibEt1RXVy?=
 =?utf-8?B?d3hQN05nSkY2Y2M1bUVGVHQ1QjMwdHdWNkF5ODg0aTRRKzNlbEtqZjl1QWxH?=
 =?utf-8?B?Z3I2K0hBKyswSGEzQkhzdUYxcUVmTG1kWnVoTHhBWGU2TUxoaVV4ODYxc0Js?=
 =?utf-8?B?aEtkUFR4RVlOWklTRUlVREhLTG10am5ZMUNNMHhJcXRxNlhYRDY2dXJ6V2tH?=
 =?utf-8?B?UXlqTVloaUpEaitkWE9ncmRpY2ZjSk9rTDhBZU9xb0RoWFFvdWlLdG0rYmNW?=
 =?utf-8?B?Q2dReWY0VFpzcGpLT2o2MFZFVmEvODlkL1NKanhQUjFVM2trbk9EdFQyMVJL?=
 =?utf-8?B?RTZic3kwUGxtWG9ZcEhVdWNTR0EzSVlvWkUvajNCUklWUnprUmdMcmNiZ3h3?=
 =?utf-8?B?ekFNWCtKTnV2RjNScStrSTJ5bW9Na2RENWs1MUdJbDFpaWwrd2o0M1dsRi9x?=
 =?utf-8?B?VHRGdHRrVGloWmZqMXNnTGhySmRwNFNxUWhpTFZUb0ZmL3ZxSHowQkpaYyt5?=
 =?utf-8?B?MnIxM0ZycE5pbVpsRzNWSWVHM1pIeHlHNzQwUTFkVVdXY3Y2V1ZBVWRNdC9R?=
 =?utf-8?B?TUVMNlBxdElSUVVmK2lqL3AreUV5c2x0MzcyL0FHakdhK3hzdUJVTE9ybkFS?=
 =?utf-8?B?QmJPZUlTZG1JWUhERDh6L0NHT0tDWkxtaFBHazNobmlaTHlHOTZSdWNOTG54?=
 =?utf-8?B?d2ZxclJSQmZpR0k1WHExUGdwYmRwWGlUYkdPMFl0Q2pzU1pUNGJSUlMzeEtN?=
 =?utf-8?B?NWNkVWR3QVZPc0MvMDMrMzJtaHdZN0ZwRlpiZWozUlB4NHQ3N0UrVjVEdk5H?=
 =?utf-8?B?WERwUXFjRzkrYmpFRTI3WG9pYlgxWTE5TnpLU2pmMEZORWQ3YitVQ1BiOUxh?=
 =?utf-8?B?eGQrcFhoYmpmUEZtd2JuYmZnRmJBWGpCbjNyeVJKYVUzRWRnWlZsN1VmckFp?=
 =?utf-8?B?NFJzSUdqQnhZb1pSQ0gxcmdyRUF3cGxRZTR1K2JXVFB5dUhFOGZaQThROEJH?=
 =?utf-8?B?OXVzL0Q5dktLWXNERTFmTTZyZWJJTmF0VTZ6cDFKdi95bWJ6MzdOK0h0RHV2?=
 =?utf-8?B?QzNJVXg3eDRmRFgva0VpRUdZL2hTaVlLVDRPdjM1OWIwV0JPNXBBb3M1WkRm?=
 =?utf-8?B?Q3F5V1ZoVGFSUUVCTTA2dVBvSXpiVm9WYjhKcnBPQ0Niek92ZHZDZFJhd3JI?=
 =?utf-8?B?Rk9XOHpDb1F6Q0h2clc1U2pxdEU3R01zTEs2dWhDdkNhMTBtdkxyWnJFMXVz?=
 =?utf-8?B?U0s0M0NUeGpHbEVXeDFUT0tLU2ovVVdNSG42QVo4UHlkVkdUQU1CN3JJN3Y4?=
 =?utf-8?Q?VaACVfEDRz4i1y10zK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ce7578-fc18-4abe-2cd3-08df334e1e41
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:44:31.9685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2FjD9BbrhxkDWDF77ps0FmPej/7963koFbSqk+ZqHUU5Dd9/lgvEL9wVETZNmQF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 10:34, Prike Liang wrote:
> The IB tests run inside GPU recovery, which must not allocate memory with
> reclaim, take BO reservation locks or depend on eviction. The direct IB
> pool and the job allocation use GFP_ATOMIC for this reason.
> 
> amdgpu_uvd_send_msg() still passes the UVD scheduler entity for direct
> submissions, so drm_sched_job_init() allocates a scheduler fence with
> GFP_KERNEL that the direct submission never uses. It also reserves the
> message BO and adds the fence to it, which takes the reservation lock,
> can allocate a fence slot with GFP_KERNEL and falls back to a blocking
> dma_fence_wait().
> 
> Only pass the entity for scheduled submissions. The direct message BO is
> only used by the IB test, which waits for each fence itself, so only fence
> the BO for scheduled submissions.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index ecd7caa95d4b..bc15fed6fb9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1114,7 +1114,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  	uint64_t addr;
>  	int i, r;
>  
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
> +	r = amdgpu_job_alloc_with_ib(ring->adev,
> +				     direct ? NULL : &adev->uvd.entity,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     64, direct ? AMDGPU_IB_POOL_DIRECT :
>  				     AMDGPU_IB_POOL_DELAYED,
> @@ -1159,11 +1160,11 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  			goto err_free;
>  
>  		f = amdgpu_job_submit(job);
> -	}
>  
> -	amdgpu_bo_reserve(bo, true);
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> +		amdgpu_bo_reserve(bo, true);
> +		amdgpu_bo_fence(bo, f, false);
> +		amdgpu_bo_unreserve(bo);
> +	}
>  
>  	if (fence)
>  		*fence = dma_fence_get(f);

