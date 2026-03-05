Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BA2EEF303
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 05:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A6B10EB14;
	Thu,  5 Mar 2026 05:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wyaXXSs4";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE2510EB14
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 05:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEbgBFnwiQaBhF5LTh4bTOiYZVyuzCiFmQLyq6tepNUOnAT2c4vnv6l57mNIxSRZVG1WNpbxXO00Lh7aciHOQyubAZAKh2VoGY+thOZaToCf2Osy59HtHh9yuy1og/tM/12ziqP4pOMxvAMHOj9DdT9s4ddQlfDiIUqe+FPEcVwNUI5CBZ0Om4QA1Mxlgw0k0iprG/e1UDlB8w+b9z3VJxlFZwqgLeZLRu/ewOX2NSbFOlnf5f93kVQT0loDu43Y85A4AcHfJntpJpx7yAVVBdEveGRM6Ln1TDw0EEqteLuyrqiMHoId2G+46gC3onvfoG5PsKJPp1GYmQ988OFzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78ki3MVrW6rcMARFVMQhQvFf3xlrD5Qzk29XOy2fBkM=;
 b=vk7PZjFhJVtMWsH+LNwj9HrryFxZ4odxLkdhZSeQeOibZDw1CMnchEVSKC09fsCYK1BbxWYti1xw6Pjgf3Q77F8yrIxp9DfsbcnNnsf6IjRQphcjjNCqX/1BHiX2uwNduZpmOwBtqQzshH89DQuWfQX/5ca5UgUFGafJiCDCEJxhkd7ygYnfy4x4XMIyuOBaUh7+Y/j3XOhFzJbUKqJumo06F49YMB4eE0vqjp9p2QTqN9yJlEAmk6NXsWFMAt+qMvuT7RFCZVuH/MSgMx2NOc73FwMnCgmXP7Oe2DxdOnhO6gmDjVgib4NVvs4cQ4OULECiXjKDLpY2CzT3GEemkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78ki3MVrW6rcMARFVMQhQvFf3xlrD5Qzk29XOy2fBkM=;
 b=wyaXXSs4SEPgkAEjPoYxhMPPMJ8aeu2sqdVv1aG1eaHsMajBWVyxbxoMC4J5uSf4cy+ARZTO+JNP3Y/Squ7fy1m8hGc0QiFmmIsXdtY3CtGQglb+2x9g56XH2brs9A5ba9Yo/gfrcVrnaSpQUizJ9HSNLldFkpD5vLttnUKQl94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 05:46:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 05:46:46 +0000
Message-ID: <aab51a07-6b3b-46c4-b5a7-8e28ff12269e@amd.com>
Date: Thu, 5 Mar 2026 11:16:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: gfx 12.1 cleanups
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260304151302.62594-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260304151302.62594-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0078.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: afc5a170-5f7e-490a-980a-08de7a7a967c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: IKOOIOyizs7RgUeiYd1l54XkmiVYT1JvhR5nGB97r/ekP+8UrvRcncrWvUzOIcY2CWHhz6ITY8FaxPMyqIqExGO0fixJ5iLD1U+X50AXCsPTj2O2fVDsGDWiyUYKr3iBvmhLNLtcLYOBjuDPybRjws11GGvHrDvWTGgtz9L4f0IrcADrT3vuOR5WXzJLepUqkDaHuH8vqW1xoYjmErdRMJ+jUw68z70yU6CK02B8LynXYxIeg6yx7XeBsy3NEg05hf5Oqlt5MxH7Nr6ZXG8uyeI/CewXNTmqz1EZSDwgvDdMWNnogGoI1qw6pi4/56vCHZxcs16iUYMQ1KqQ6UOMOSlNXnWmdzaMfaH6ue4Cj/LobxdIIAlPPy06QG/YeWjPBadIC2+t80M6uJgEqstcw92vbKeVR7gxKgqlSu8U4x0mLZA34gGjdP2e2TBCt+bvcvVan/YlPuxo905Ytk/tNZYwUN5HiVDlgrcZfzbA2WVTXOnlFF/e3j4e8HxS+7pOoCG+gSPcRAFoAFeveb1IyV4APhCmCrxZ6rKgblQSL/CmtQaiimTUlDApImn7yw+SfR0Xcd9tVbzoET4rsfF44+EC5z6njXvZlsFMtKXPQKvGcwNAkq/lB9gh/WdRX1Tike5n6SbhoJKsjPPpieyvjbxgueCXEe+cmpvCfxuiS1ye8RR/e9UM9GoE5vIXAYlJiteCTr5XPnayrYqsXfARYBJRNjc6v6IfwnI1y6HrSZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhWUTUyVlhlMDdxVU9JcnBSaUh6d1M2TXdxUUJnNDhRRnl6SlhocGR5clNU?=
 =?utf-8?B?VjVqRHRBS2J1WkZpWWEzMFlHYjNBWnZyN3g2QlIzSEg4TlJaWXloU0ROWUlP?=
 =?utf-8?B?ZFYzejMzbER3a0ROVG9VSTdsT2kwTnBRd3ZsYUYwN05ia1pKR3FDYVAxZHlt?=
 =?utf-8?B?aXVtNEUyQyt0UzRGMjhoelJtUzUwcFdjeXBha0FieHl0VnQ1YkhMcUFuQ1FQ?=
 =?utf-8?B?Z0RySW16YWtqY042Z0RFaFlFQzlHRi9FQmJKYTVqTHRLWjk1a2FTM2hjamRE?=
 =?utf-8?B?ZGR6WXhSb2JJTTRuRDZNME1HYXg3MkR5U3krR0I4U2JlSmxyRkdYUzRKaGFw?=
 =?utf-8?B?UXVPMnB1elo2Rzh3QlZGODQzREs0b3E2ZXdFOHVNV1RHWDVoZmdoKytqU0pL?=
 =?utf-8?B?U3ppb2ZuV095ZmxvNis1dnJGNWx5K0ZKL0VCSHF4WXdqQmxQNXd5WGc1MUEy?=
 =?utf-8?B?VmlqNUY2cFJTMVJHSkttSmRnUEw0OG4vcHFTSytpUUFJZm5GNlF0NE5uY0xi?=
 =?utf-8?B?NFgxcXE2RnFQaUhTaithMVBaR0hYQnlHTkxsUTZ1LytMSHhISFl5WGpLdmFk?=
 =?utf-8?B?OEhYeDdTSlUyaGxKS1JqYVRReVoyNFh2d1pwd3hGNlYydGd0UUFLMVRDYngr?=
 =?utf-8?B?Ny9iSmxSejlTd1llU3RpQXBWT0FQYVhweTJWWCtYK0w4S25DRFZpN3JLL0R3?=
 =?utf-8?B?cU41ZE1YNVZsQnB1OU56NU02MmoyempzU1Q2bzRNczQ0YmhzS05uN29hQlVs?=
 =?utf-8?B?Vllic0VxUXp6ZnI2ZCtXL0krNFhTNHBhQTNyZFNLN3RkMkFpei9QM0t0djJZ?=
 =?utf-8?B?Zko1UGxiaWVkMDZlS1Bzd2N1ZklzZlpDL2IrRTBHR1dQajhLNEgrdkpWT1Uv?=
 =?utf-8?B?d1FCNjJpWEZFSDRUUVpCQitUTEtHTnVYb1BwVUFkZ2s5bG5kOFVxc25ibzJI?=
 =?utf-8?B?UDRxUWZzUjRpNVNNaEZCaTlNQSsyOWpETHdmZXhTNzB1SG9ZRGMyKzVwRGJo?=
 =?utf-8?B?eUVMYjJ5amtQdlR2Q3plU3M0TnAwdFBmTHNZajZFcGp1VEF6ZWx1TUFyeVRl?=
 =?utf-8?B?a2JqTlZRRDF4Qk82VUFaZ2tEamdhdU1wazEzNXFYaE90WDRxRmk5RThrMTVs?=
 =?utf-8?B?R0F0OG5kaFB0eFdyQUljU2kvbi9WUmFXMzdpTmYzclJiUmpSQnUyV0FkemQ1?=
 =?utf-8?B?bGNNcGsyRVZNL2RYVzlWQURVZkpXeGp4QU50YzIwMi82MXRzWnRnM1BVZnAv?=
 =?utf-8?B?WEpMQnpvaGJFRHNsMWRTbHNhSUcwMHVhdjhoM0RJRHkrMXJGdy9uQjhtM3Qr?=
 =?utf-8?B?bThOWFV0TzdFcThIT2RVWjNtWFV2eWNHdlorRWNBd3gwaUoxcitvZE50c1NT?=
 =?utf-8?B?QmpKYk1CT2dGUWtnd0F1Z25xdzlKUnlmdW50dXY2bkxrd09oZDVJbWtCTG42?=
 =?utf-8?B?bm9DMjQ2RGI2WHMydXNkQjBWV2hraE5CRWlWUXBHYWRpNm5CemRTV0dCU3lJ?=
 =?utf-8?B?b2d0QmhhQnV4dE1JUzluU1ZxbTBFQTdYYkdVcHFCT3lRaUo4aDJnRjRTWlln?=
 =?utf-8?B?TE44SGJEWHBtckl1a0JzU3luNGJIQmdFNzhlNitsc1BKU2dLYTdrdnR5VXJ2?=
 =?utf-8?B?M0psckJLY293SjR2M0FPa2ZwTVZaekRtZmQvRHVLa0lxWVQ0RUFPM0pDMjZi?=
 =?utf-8?B?SXBmbVp0c3JPdk15Y2hzNk5lRE1TMXMxUUF3bzJvZDFSSHlIeEtqRnBJTmJM?=
 =?utf-8?B?b3MxMFoyTHJmcU9CWTAxdHhQbnRzaGlERUd1Q2tMcDVMMWFHbXV6dWtMNE05?=
 =?utf-8?B?MUQwKzc4QmRnd2FiY04zUm1SYWJRODFGVE4rZEk4azk0YmE4NU1nTmEyZ3Nn?=
 =?utf-8?B?T09XQUFzUmZtTWdmY2IwVFRaRE5iMHN5VmtuQmVJT0Y1aXpFc1ZleEpmMGU5?=
 =?utf-8?B?KzFVMW9CQkdvSFEzSGdCbDltcDNSWXFkTWR2ZUpYSVVCRXp4Z0dza2RpbkNE?=
 =?utf-8?B?aGJZei9xRTh0aEFOWCtZTjQwODFPUHFlNTBwTG12aHZDdk5hYk00NDFXU3BC?=
 =?utf-8?B?SXA3Qms5endsMHh0VXRIc1JNNzNQMmUrV2tya01jVjZjVStqUVp0TE9jWitS?=
 =?utf-8?B?aHU0a3Vvb2wvWWo4V25xQ3VrYzhkV2lPVmNwa0tPWk9kKzVvL0tmN21pZmta?=
 =?utf-8?B?WHFLTTRJR1hsQndObisyTFgyM3JSZ05QQXlKbExzb1YzVkZsR0pCaXhJRTFr?=
 =?utf-8?B?aUhFNWc1ZXkyeGdIVEVVNTNQVHB5S0JWV2NNK3FuNE1QY01MbnpsL2ZqSUlk?=
 =?utf-8?B?NHFqZUlNUFRySWFjdU41dGNhWnYvM29sYzhndlNhbEx6TlZqbW1jdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc5a170-5f7e-490a-980a-08de7a7a967c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:46:46.3975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zinWr/41ksLFXXbdc5yWeBVH2BOcH/807F4OgKpif1uI78u/zwfNjL44u7nSNb5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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



On 04-Mar-26 8:43 PM, Alex Deucher wrote:
> Remove some remnants from when the code was forked
> from gfx 12.0.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

One minor comment below for consideration.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 557d15b90ad27..a0ec38f35c449 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -3630,12 +3630,6 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
>   			return -EINVAL;
>   
>   		switch (me_id) {
> -		case 0:
> -			if (pipe_id == 0)
> -				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> -			else
> -				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
> -			break;
>   		case 1:
>   		case 2:
>   			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> @@ -3652,6 +3646,8 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
>   					amdgpu_fence_process(ring);
>   			}
>   			break;
> +		default:


Adding a dev_dbg may be helpful though it's not expected to take this 
path with disable_kq.

Thanks,
Lijo

> +			break;
>   		}
>   	}
>   
> @@ -3720,14 +3716,6 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
>   		return;
>   
>   	switch (me_id) {
> -	case 0:
> -		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -			ring = &adev->gfx.gfx_ring[i];
> -			/* we only enabled 1 gfx queue per pipe for now */
> -			if (ring->me == me_id && ring->pipe == pipe_id)
> -				drm_sched_fault(&ring->sched);
> -		}
> -		break;
>   	case 1:
>   	case 2:
>   		for (i = 0; i < adev->gfx.num_compute_rings; i++) {

