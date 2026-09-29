Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8B9C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 05:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4799E10E74D;
	Tue, 29 Sep 2026 05:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hC37hYW5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136D310E74D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 05:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+Gpk1CU/TnRu8c+tWQ4HPnkdpMVd7gNZsUADM08cJI0oDx9vLfXsUMeKtyFW7icf/FEV3QnHcHH+LqH9ddnrp7QbdsqNRblA+vYWkdAq2kaSF4ucewTidSTSxpcqmKxaSyRtYsD1NwkhCel11itwmKhsixZwggAQ5c0yXhp614ZvO9Ldc67giGAKpwKRJ61ivDoi00PdbnDMEaJteP12I5MRVARJu5HMLLR2oCH5Z6q75VOvGGTPucAzpS1t9TcDCHSAqiVCbDMet3U/L7xR2zFwhRO4dZj4rExXeb8nk3mS+U4bFI672Tmdsu1MvXQUOI6sYjz2SGxuf/a4OiALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLBo9tPbKVscnt4PDKCfsY917uGEuhmrb5QFXlJxmQA=;
 b=ya6WY4tTDjEpPiOFUADgcR3NecoYqdQArnEPhC+SFqkksDf3tdG6TD72ygOs/Q14SrTh2V1qDh1N+yXC9NoSl44cE9fIQ0xetS1JTsy6rNRDDFe3kNC1rwn9nZPWnRgO+iQ6ly88ZzsgI9QnG5hWUP77GithD0c9rTO7b31Zusgmm5bFIVXh8OJLqGYsQZydix3auSwZiAA2QoxgJGFdF0bmNOTZ5lwdIBD6qZ+aIiQZeCDfVrLQ+WY7zCM78COWbck3F6X/k1quSPGAyQJZLBvuXrLy/WlvSj74xvR6TWoCNbpvnCDefpxDtAOGKXkW427qCnQEvGCTaw+LXg5uNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLBo9tPbKVscnt4PDKCfsY917uGEuhmrb5QFXlJxmQA=;
 b=hC37hYW5We/VW4s3FYwd7KMwvddyuaVH3/KqCYOPkVj4sLj8BxVoikCFfjdfP7wTRVYZVTRE9cdLQ7LNdDPvLtf9OK3d0ros70HpFDRwCa7onc0+Zb4v8G41sauLDceff29vK7ZXomhNdaojxU/2fjk16zS5dw8G/7xTELM3n3E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH6PR12MB345224.namprd12.prod.outlook.com (2603:10b6:510:3da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 05:35:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 05:35:23 +0000
Message-ID: <3ee41db3-c971-4954-91ba-a00b235d3115@amd.com>
Date: Tue, 29 Sep 2026 11:05:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip PF-only programming on the VF
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
References: <20260924070129.2150408-1-YuBiao.Wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260924070129.2150408-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH6PR12MB345224:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b55cf9b-8edd-4edc-902e-08df1deb74ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HEeDM3YNbOgWSSHDzDpaiRSL//jZuTU4VaAe9GlBPaAFycBHTqmJWFgIjAAsKQWiqscfVkAs+BmtgPwuWT3vcmYEj9qf96FLIcwy43kzuGQLQ7ISry5A4xy3WIePo4/kg84F0DGWxbIvF0svLPON9SiNEo3ueq4YpDlK0wQyl8b7RUp5F7c8U/s+mtSc/xnH1tpyOM986KlpoufIc9UFyjTJEVMfDYWSrNqGh/QPGPrH1LV63wQ8bNcHl/V+LvYMEYXVhHGNwFva/zgteec/nfLeze/K5K6t/0IYXdVuqK7s5JVMcth5/xWcT5TQEsl53Uk8YosEZ53OQBfRtwt9EHV0Shi5JPqgrNY5hFvBX5laaVzwTcT+S+FEeFBNhguuyeAHC4fA767WmOQ8+Q1VWPwGSSD73q1+29ghNUGrzYOreYH0+oi8t6+WZQdF5Yku7W0jrhUKcjuZKVLMoGDvxS75j7DcpQkuqYpXULE5B13MvbKgNBJrX1x2+u9EOA0/I8eakVLoZJX+sUuPeYG40RpsBQ36uFMMfB5mvxLLDK+ZUeQDwsgt9V65FyHpzmZE43SEcG0qfXwy7z+F7zBtFUeYW9M/MgWJMmadGTOgB7ve0/EjxpnVo7r1vNWc5gx2aERRRfjnDEjR5ldLQwNFvTVraA0R52S3lznJWe+aMvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZFY2xaNmE4MlE2YW1yTUZrSE5xM0RYNnF1aDdtT2J2eHlZejRoTWZTNkhp?=
 =?utf-8?B?cGZhRzczUUtmeWd1Zm95Rm9OWmZvZlBUQjNvcTM5Vm9KVUY5dFJUUDkydWxJ?=
 =?utf-8?B?Mk5vbW1XZ0tncWQ0U1VUQURCVkxiUjJpU1J1MXhWTEt3SW9JaGVzZXdKK1h2?=
 =?utf-8?B?eTFwMWQ3ZjN1Y1M4cVNZNGpYck8zZDd5eHNjUFpxYm1yR21RRnNaN2xla0hQ?=
 =?utf-8?B?cmdxbGxuZHhkd09zaUFNN3NnVW93aTlSdE81ZS9LZFBzNmNNQkl2S2ZZMEJK?=
 =?utf-8?B?eWRVVHN0MUNtV0l2eDFtTkgxQ1dndXQ1YzhWT2xKTzZ0RTQ4T1lvQ3lvK3pa?=
 =?utf-8?B?S3EvYkxGb2U1Z3RQb0lBb0xCZGpwRzBBM0NaNVdZSkFsSjFQa0RKMUN5TmhM?=
 =?utf-8?B?bGhscUp3aXZVNDBLWDl4NnVZSTFaTUJlbThtY052YUZwR0M5S09lcTZqTXpt?=
 =?utf-8?B?TXBCaXRjZGYwb21WUW9QaWprWnY1cFJ0bytHT2t6eE5VeXpKSnBkdmFMUklk?=
 =?utf-8?B?S0RTWHh6ODNzVzU2NVhUaWM2SGJxWkhtYk9VakhHaWlCUWZMSEVycnhBOHlD?=
 =?utf-8?B?b2dqNEFkRDQ4eVU0WGdxVnNEdEpIMnNYVThSTTBscWUzcVNQMDNWWGJ2Mmln?=
 =?utf-8?B?WUlJajc4L2lXSFIzNkUrb2dUdGQ4dHdmOFNjay91UzhHc2REWmtKYlBoNVlq?=
 =?utf-8?B?TWI1TXZPekcreXNaeWRCRUdHVFJDejZldXNzZUl0RTU3bFdGZEdpcUZYdysw?=
 =?utf-8?B?MWtaeVBLUTNCalNOd2NxYjd1TGpUYTAwKzltU25OYTRFVnNCNU5nU3hxNGVI?=
 =?utf-8?B?Vzh3bDZzRVVLU2RXRnFCTTRvQStlcEZId0d1MC81Mk44OXZUTHBoQmVBSWRs?=
 =?utf-8?B?M3gwb1VCY3VhU2VIRHBISFlWQWNrQUVRR09ra3FhZUJuMVVldU0zWjRaQ3JM?=
 =?utf-8?B?emtZc0lLQnVEb0djQXl3UW9ZWE9LSWJtbTdsL050aVkzNXpQd2JUdHFJVzdZ?=
 =?utf-8?B?MjV0bG9VZkxLY0xBeWU2M3Jyd204eis2b2FuRnJjMURxZUxGOGJ5bnJkS2JF?=
 =?utf-8?B?WGwrRmk3MTg1SmtlRE9ZVEpyWDgwNHpxSERuR1FmbDY2TUFxOWxMbUpvZ2ll?=
 =?utf-8?B?ZzNUVDVSZk9kVWtrZjkzTlVMc21FS1NxTllpR29zRlYyMGsxbGdWZzM3UlA4?=
 =?utf-8?B?NE50MXVYV3JrZDVLaGd5YnpyRWtySk1MYXJjVjU0c2lIb0NSeUwvRmxnSmNU?=
 =?utf-8?B?WDlHSnRwY2NLd2xxZ2dSYUo0QzZ0SU1YMTRWQU9GRlZUQzcyZ1AyLzBTdVNL?=
 =?utf-8?B?ZEpZd1ptOTdCbHJ5RjNmcEdDUWpSTnBzd2Z1TTBJeitTUnBPVkEvcDc2QVBQ?=
 =?utf-8?B?dmdFcGNlcFZuRVp2OWlwUTBsc00zTW5qc2xkV1BqMHAxQ1YzaDM0OUh0VWFE?=
 =?utf-8?B?WnZZNFRvQTluYklVdVJJSnRJeFppZEg2R0R0UWJ6a2ZoZHBaa3psZ3lXWmha?=
 =?utf-8?B?TmYxcFFvNGhxQktjeWlHNGtNVVZMUURqL2g5QnJKNCtCY3hZS3dZd1djRmFq?=
 =?utf-8?B?OEFoVFFoN1ExanBDbEhFY2Z3amo5aWtyVmtnMXZGRCtBMUFZYk5xL0t5QWpZ?=
 =?utf-8?B?Qnp0R1J3WFhHK1d3OGl1VjN0bU4yQnordTFuQy9jV2JyUG5vTmkwVDdSa3hK?=
 =?utf-8?B?VE5YYU5udWRTRW5pdW4rK3hRWlVBL0VOMkZweWZuQk1PZzNaTjhIS1YzYWFj?=
 =?utf-8?B?Wit0MFlnVXJPT3krUEdOR0VPWjJWUjVXK2pJam05RUlnWllRMm1nM3dFTzh0?=
 =?utf-8?B?Z0NRUFZiK2F3VWlIdU1GVHIzYzFtdDZOVEhLT3llRTk2L2dqZnVXMnNpdGV0?=
 =?utf-8?B?Uy96KzlpR0M5MTRmUHp5L0JBRVY4ZHZoWXV1NXpXR3lmN3l2azVDdzltLzA4?=
 =?utf-8?B?Wk9SY0szWGJNS2pUVzMyYXEwbWVpc2RBQkh6SjdtdjF0SVpORVFUUmkwQ3FE?=
 =?utf-8?B?ZHlKRDRidFNjbUFHbkk4ZTJCOEN2S0VuUFJGeHdLL01Qd1J5R3VCY1lTcGVN?=
 =?utf-8?B?L2d3citwWEJKaDJQR0tncHgvTk5XbGFPWDd1eGR4NmNvSHYxUHdwRGYrNjlN?=
 =?utf-8?B?VWpydS9oTUUrdGhleTh1WXBWS1hveGxoblpGRmlRNEhiQ05yeHlLMzBwbzA4?=
 =?utf-8?B?RHFLTEJ1cHJHbWo1aEFsaDhXaENEdCsrMDFzNnJwU1F4dVpDSDdHUlNUNGdI?=
 =?utf-8?B?SUZFc1FZZHZqdjRrZTVybytYWUFzMktRTENMcWxFWWp2TGpKZFF1NENicHAr?=
 =?utf-8?Q?TPYU0TONNasOtW94fa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b55cf9b-8edd-4edc-902e-08df1deb74ea
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 05:35:22.9648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PajPy5yAUGFzI5OFpke5NkgwuGCNY58x7qGgAC/UTJvL5MlAsaIP1NhKAmPMTJux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB345224
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



On 24-Sep-26 12:31 PM, YuBiao Wang wrote:
> Golden register init, the SDMA RB command switch setup, the GFXHUB
> L2 protection fault controls and the guest-side FB_LOCATION programming
> all touch registers a VF does not own, so leave them to the PF.
> 
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 24 +++--------------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c    |  3 ++-
>   3 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index db541939555b..4f6eac30b235 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -2665,7 +2665,8 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	gfx_v12_1_init_golden_registers(adev);
> +	if (!amdgpu_sriov_vf(adev))
> +		gfx_v12_1_init_golden_registers(adev);
>   
>   	gfx_v12_1_constants_init(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index 7fa451b373fc..b13967a1c8fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -482,27 +482,6 @@ static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
>   static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
>   					uint32_t xcc_mask)
>   {
> -	uint32_t i;
> -
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* GCMC_VM_FB_LOCATION_BASE/TOP are VF copy registers
> -		 * VBIO post does not program them at boot up phase
> -		 * Need driver to program them from guest side */
> -		for_each_inst(i, xcc_mask) {
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_BASE_LO32,
> -				     lower_32_bits(adev->gmc.vram_start >> 24));
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_BASE_HI32,
> -				     upper_32_bits(adev->gmc.vram_start >> 24));
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_TOP_LO32,
> -				     lower_32_bits(adev->gmc.vram_end >> 24));
> -			WREG32_SOC15(GC, GET_INST(GC, i),
> -				     regGCMC_VM_FB_LOCATION_TOP_HI32,
> -				     upper_32_bits(adev->gmc.vram_end >> 24));

These have VF copies, and likely needs programming as in 
gfxhub_v12_1_xcc_init_system_aperture_regs. Could you check?

Thanks,
Lijo

> -		}
> -	}
>   	/* GART Enable. */
>   	gfxhub_v12_1_xcc_init_gart_aperture_regs(adev, xcc_mask);
>   	gfxhub_v12_1_xcc_init_system_aperture_regs(adev, xcc_mask);
> @@ -576,6 +555,9 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
>   	u32 tmp;
>   	int i;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	for_each_inst(i, xcc_mask) {
>   		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
>   				   regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index 321c67e01443..d1e09acc684a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1397,7 +1397,8 @@ static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
>   
> -	sdma_v7_1_rb_cmd_switch(adev, inst_mask);
> +	if (!amdgpu_sriov_vf(adev))
> +		sdma_v7_1_rb_cmd_switch(adev, inst_mask);
>   
>   	r = sdma_v7_1_inst_start(adev, inst_mask);
>   	if (r)

