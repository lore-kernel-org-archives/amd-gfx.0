Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABC7CFB442
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 05:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4F410E2FE;
	Mon,  7 Oct 2024 05:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3N41FT/r";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6FF10E2FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 05:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1XnANSsE7q0Di+K4xvd4HuydVK1Lbm+H3vLLmfHy/c9Dg12bZf8lqPgeQzk2NtGUtd7cMr/MpelNyB33o9YXI9R/+AB0BlkwRhU6yn0eNNYG8KYOEBn+ybJFFQNKaDpOh+RLMFL7enV1qDNpPrQ3y7nLTsNb8H0sE82FNPyVl2Ed8WL+Ji4SxJjsSMLRYZDchWZP/MYBw5WEgG6vXQc1VMyZ7MlZI/xRDBbU11gJbnDKSufZI++F/caeTFFX+XReSSF0qv5/Lo+flWSp/gDrLAaYiMpGrBIH9mwr+zze95fFUBDddxTq3kuaLl6RZveHb165ygPHHrrouIPecpz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkFSR6qlmNSJDBROkZ41XG17k28tLvy74cClMqj4CN8=;
 b=YcP9a8Ek/dN1SLqfopedF7ephSDihPCB9XV2RQAmqZ2nO56Ic7j6C6RV7AvJVooDgLNPPMggfWWASifCEdKwajzYVyosqgwHxQu9cf810P+LbAK1pudEELAtNFQXt3TuuRbAyP7uLON0y6N5q0l4i/kXpG7p4wyi9L3ot6t8BnBKspnQz6M81DbvInI6+BDBLaFPUKN/X62tcrsERFxE0B+KL+ii+XfPQkIpHm0SbHyEUJUbe0kCKeVnhTM9zcRqo2lUjL4csGNQEGBgWYysPnJuzVwHTPYGKw9CAEf6vUtvEt8J1sYS2PTsrjwV3DA5LR+tk86PzF9B29+lMuiQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkFSR6qlmNSJDBROkZ41XG17k28tLvy74cClMqj4CN8=;
 b=3N41FT/rMZHWy+NZ0heCfWdUvPG9iUpI6/SZfgi+WZorNduVJpiJp8S1op97VSdyfIx8Bu0xbmsqKd9YHULzIsU+bSUzBnUvehRw1ch82PqtCmRdl5yKfpU+05XyY2B+w3kedqIWqbb3idFFx23s+R5QbjMvCqT0gAbSln3uzrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Mon, 7 Oct
 2024 05:22:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 05:22:13 +0000
Message-ID: <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
Date: Mon, 7 Oct 2024 10:52:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241004184444.435356-12-boyuan.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: c155cf6a-0cc2-41f3-ecfb-08dce68ffff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDhCblM3OGhhR3E4NUw1NVV6bk9MUmRaaGh4eFF2NUJtYzZKaXpkOW56Q2w4?=
 =?utf-8?B?dWEwT29HbXNndE5ndFRPeGhDNDNhUDRwRFpmdW9USFdmZDJtbWxya0xyVytK?=
 =?utf-8?B?YS9pNUtQQm1FU0lUOFJGMmFod0JDeWNiVHd4NWRVYzF6SVUrSVkra1JJczlZ?=
 =?utf-8?B?RTA2T3FQd0xza2hIWmR1UmhzMHdGaGFTSXNtYy9wQy8zNmZyQU5BTGpWL2NT?=
 =?utf-8?B?LytaYWw0aWN6Q1dCUU8zZEFPR29wSW9tZVkxOWY3MnFNVGY1L21iR0pyYmI5?=
 =?utf-8?B?M0d0UHVDZHQvOCtJRCtwSG43cjhEMkhvUHR0N3dIUklYV3dzcWFtQ0puT0ZM?=
 =?utf-8?B?MEZDWnJGbkZMSlN5RFVpeXA5MHBKbVVac0g5MmM3a29CVWh4T05DSWFlRVUv?=
 =?utf-8?B?dm1xYjFaRWI4Mm5kc0lnRHRDbkZiTk9aQlFFbGtQRmw5NTB2NTVoVjNLR0tz?=
 =?utf-8?B?dFZBbXVZazRCZTQvU044RmJtRFlGbVJJbzRtZFZsSi84ZzFleWtWR3p4NXhZ?=
 =?utf-8?B?TFBabTlPaG5EWTZzN2drblIzaWpZeVlkaFBvSWFFZG1jRFpzMmpVWXU4b0dh?=
 =?utf-8?B?ZXovYlpNNjNnOHdBWSs1TXJIai84ODVmdmRreFBrQkc0eDQvU0ljQUdhb0pX?=
 =?utf-8?B?dTltZzdDVElpTnpOK200VUZidDFTbk4vUTRyV0ZOK3VxMWcwczBvVEZGZ2Z4?=
 =?utf-8?B?R0xsY2xvSHlsa0dCRUlqMElJRytaVnZtckFON0wxTHBnT1pCdnhmVG1HanM2?=
 =?utf-8?B?OW42eUVaSlptUFV1MFRwWDY4dHpjaDRRbVhvd0VZdEdQS0g3eU43WlRVVmFY?=
 =?utf-8?B?blpiRzUvK3Q4SklOU1k1Qkpvd21QQ2FKM2ZNeUlSOUY0QWZ4bEpWYmlQV0da?=
 =?utf-8?B?QUk5RGNpYTlQNCt2K011b1o4MFpZTDNwMnBwbXJyaysvYjRoUTBFOGtlZ3Qx?=
 =?utf-8?B?WkJHYU5wRm9JOFFuWlg3a1k4bHhBVEdZLzVuRTlqUUNHSGJOT1ZmZ0FUSkcy?=
 =?utf-8?B?cFk0b0JXVGRCQ3F6V3Z0OXJPNUtwTUxCZmhHQk5NMFNuOXpYWDVkcm1aWjdF?=
 =?utf-8?B?K1hXam5zZzdSYmpIMXN4WG16VWxDaEU5MGhONjRmbHpheWpUY0diZU9nRURX?=
 =?utf-8?B?RUtzV3hUc2lHeFczTUlodjF6MEthVlNBWVBJRG81NGdjQStYNjhLcm9ob2Zv?=
 =?utf-8?B?T1NDNmJST281V0RnNHhWeUEwUit3Zm02RXhYcjROdUplUDVKSlpMclNUWGJi?=
 =?utf-8?B?WFo0dXVPT3RjbExoeFJwWWpjQlpKblBqSmg5VkNXczd1UDMrSmpUQ04yTjFQ?=
 =?utf-8?B?YmdZbUk1eTl6Z1BGczFYKzN3ODlvc3E0dHh4UkZpRjgzT1Q0YjMzLzBvZGVY?=
 =?utf-8?B?VElFU0ZPalA2YWtNaExITnJNMGFXN08vSktCcnlUOU5ucmNERndPOUhnMmIv?=
 =?utf-8?B?bG5oTXV6SEdFSllhYXJSclhkeWxETTA5elE4emNOQWQ5WG5ROEF4VGVFeUxK?=
 =?utf-8?B?TDA2TFdQSnRONWo3eGwwODFML2JVMDNyQ1NFV2hEYXlaQUJkeWhQL0p2dWdx?=
 =?utf-8?B?T3kzeG1zcGtYWkRpNFhBeHB3b0xmR2xidDc0QnEyMmZGbXBVdmJBbzVBcXJ2?=
 =?utf-8?B?MzFWY2wrMTN3dWE0RHIvRDhWcVRPV0U4b3BzaTFHVTB4OVQvVW5Iemp0RnNo?=
 =?utf-8?B?MUxoK2FzcU1qU2V1TnhHY0xwejNVd01KMGw1SFJwR1U0T1dhbjZIRWhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3N3WTdjeDRwWGxhNFM3N0tKQ25tek5rQmxWNy9YOTJzU3F6MG1aTk5lNnZx?=
 =?utf-8?B?SzI5anRLelI2bFI2SUhUa1BodUdNS2tnNXkwK1VqZUpmeUlaV1h3aFRBZUNk?=
 =?utf-8?B?NTkzU1ZTTlBaQWdOSE1KZVdISUJhMXVkVXErNWJZOXY2cjdOVnZwdzlYR0tN?=
 =?utf-8?B?WXgySlpscXdTYmdPSC9peDRZcnY1akRmYjAzZFYwTXRIMTVDQnJsRjhTUW1j?=
 =?utf-8?B?RjhNTTM2ckVwRm1JbzdvTVJZQ0hOSjJjVkdNVUF1YWFlTFFsTCs1WHRrTENm?=
 =?utf-8?B?cStySHNlL3c5M2hRSW5iakowMTN3VDNQRFp6YkpHMWh0b1czdlJoeGw5QlZQ?=
 =?utf-8?B?T1dBeUMvMThsWUxFU1NOSTNTeDZpTE1leVpyOGdidWtVWldSMndlK0ttWmZT?=
 =?utf-8?B?UnFKQXBLbWJSWmJlK1Zmdk5QVkJjUlJURkliZkFWY0l4cmVsTzBZMXljKzJG?=
 =?utf-8?B?TklxRXNjUVZYb2gzZnlPSzNqWE5UdHBjOU1uRk82QTRhZVRXQWtmTzdJdjd4?=
 =?utf-8?B?NWp3VXlTN2QxdFplTnZZVzlXRGdFMklVbjE5NzVmbTVicitYNjNqYmp3Wm8w?=
 =?utf-8?B?aXJobEthaFlsdk1TaXBlSUp0Smh2d3I2ekl3d2FPS0FOb05xOXRmWFFsYnpL?=
 =?utf-8?B?MjY3azI5cmF2VXJTMVlvQSsvNXBVS2xSSCtBN2JVL1RUbW9LVWptb2ovd1NT?=
 =?utf-8?B?a2IwRHljdlk3K0wzWW01NXd0dlFzb2d3S0lTSzNRMmg0UDFVLzI0YTVQaEVD?=
 =?utf-8?B?TDFWR3BQWVhXSTc2YlJGQW1JcklWYlBJV0hSbFE2QmVzcWFpYUE1UnVBb0dF?=
 =?utf-8?B?SHlBd0FuZHlqbi9abTZiYytSWHpYaUlhNVNtd3ZsUGY5Tm51T1lpYlhycE92?=
 =?utf-8?B?WXJFSWVQeTFyVmxDRUYvcXZLbGJXQ0lYcDFjdFYzc25iUVF5bDc3UE8vdHhK?=
 =?utf-8?B?dnNIVDVLTmFyK1hSV1o4Rm9YZ3NrZ1Q1N2hJUkdkZjYvSTh5YmRSZ2l6Y1NX?=
 =?utf-8?B?NGFibDN1eThabk5Za0FCajBMalVxNDlEQjNQdGJzWkFNY2dLNDROK0kyUnZu?=
 =?utf-8?B?MXNqVkE4dktTUWN1a2pMVVFDZThER1dWWllOampYRmRYOXJBdHlqeENWa2Zl?=
 =?utf-8?B?a1p2LzVYVnMzcnFwRUlVN2NnNW82U3FZaHBEN0hDRVJxeThDM1FZT29rZ3pv?=
 =?utf-8?B?empXenpIcXlJTU0vYTM2cVRLS2FVWUhXdmo2N0xIQkw0WkpUUngzQjFYNWdB?=
 =?utf-8?B?Vzd2cWdaczZJZi9TbDNibWdwWGtaS2RmUDlzUGV3MWhaV1RERGIxZHZPa1RZ?=
 =?utf-8?B?V254VTN3VW9sVzFSSDJvVTZ5c0VmL0pwcVRDVDdUTUlpVm5SMmxEcWtoQTI5?=
 =?utf-8?B?MWdoL0JwVm4zOWZWelpwWHYzb21NNHJZNzFkNTVuemNHSTZabG9wYm91Kzll?=
 =?utf-8?B?ZVZKdkl4cmNxU2IrYkcwVGYrTnVJS0xZL01zazNYVU45ajJoalVyR0duTFdy?=
 =?utf-8?B?Nmt1cWkwQkJaaUJRTmpYWEoxL0cyTFd4eWtOWnpuOC9tV1FMazl3K2FKa3pD?=
 =?utf-8?B?MzhLM0dvWmg2N295Umtza2J1anVxbW15dTM3VzlTN1BtR1JtMzFFa3U1Tm9Q?=
 =?utf-8?B?c0F2V2pTYkRSV2dDWm5tdHhzd1ZPQUdVYi9reURQOXpqR3E0L2VrWVBuN3Jw?=
 =?utf-8?B?WE9JNmY4U3Qxc1lMRmZOblBad3A1UmlEcWtuQzNMVktlZFpFOEE0VjlMRG9U?=
 =?utf-8?B?VUdKMWF4NTZZMGVQd1R6YzYvcFJ5ZkZPMlgrekFjK3NsWnIyNGhkMWhRcHhH?=
 =?utf-8?B?WngrU0IwcTdIZTFVK2VlUllSMmxPZ2JGYUVCS0M5VHUvUWtFWWFETVFzbFVS?=
 =?utf-8?B?T3orZzBvSE0xWXZML0VmTUh1UzlNc0lwdkpWWDdYelpyQlNoMWgzT1FlV0dX?=
 =?utf-8?B?VEpRWjRhd2hFSDYwWXIwSmY5c1h0MzdoeENqeVYzUmtmUEJLKzV1TDZqNnpQ?=
 =?utf-8?B?R2tHZWtIKzhiR216My9zenlIMG5RcUl3TWVYV2hoY0NqTWFLUXk4Z1lXVzdH?=
 =?utf-8?B?TllXTjFiZks2bjh1RzFiVnFwTW4zVFVybDNKbmVqMmFNaVhwdzdsTHNmbGE5?=
 =?utf-8?Q?TcG9/cuWS4Vo1jjZDxO8W31bY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c155cf6a-0cc2-41f3-ecfb-08dce68ffff8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 05:22:13.2836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvQMLfMAHj1X2rR2AxoufTxQjd4Y9MbksbxQUO41jJgusUdRlA9lG5mJXXJW9sYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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



On 10/5/2024 12:14 AM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
> 
> For vcn 2_5, add ip_block for each vcn instance during discovery stage.
> 
> And only powering on/off one of the vcn instance using the
> instance value stored in ip_block, instead of powering on/off all
> vcn instances. Modify the existing functions to use the instance value
> in ip_block, and remove the original for loop for all vcn instances.
> 
> v2: rename "i"/"j" to "inst" for instance value.
> 
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++---------
>  2 files changed, 280 insertions(+), 289 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 9f9a1867da72..de1053cc2a2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2278,6 +2278,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>  
>  static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>  {
> +	int i;
>  	if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>  		switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>  		case IP_VERSION(7, 0, 0):
> @@ -2321,7 +2322,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>  		case IP_VERSION(2, 0, 3):
>  			break;
>  		case IP_VERSION(2, 5, 0):
> -			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
> +			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +				amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);


This introduces a totally confusing design now. At a higher level an IP
block type manages multiple instances and their power states. Now there
is a mix where no definition can be attributed to an IP block. Or, if
this were to be done uniformly for other IPs, then for some SOCs there
could be 16 SDMA blocks, 8 GFX blocks and so forth.

What is the reason to do this way? Can't VCN IP block maintain the state
of multiple instances within itself?

Thanks,
Lijo

>  			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
>  			break;
>  		case IP_VERSION(2, 6, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index d00df51bc400..1f8738ae360a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>  static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_ring *ring;
> -	int i, j, r;
> +	int i, r;
>  	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>  	uint32_t *ptr;
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>  
> -	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> -		/* VCN DEC TRAP */
> -		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> -				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[j].irq);
> -		if (r)
> -			return r;
> -
> -		/* VCN ENC TRAP */
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> -			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> -				i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
> -			if (r)
> -				return r;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		goto sw_init;
> +	/* VCN DEC TRAP */
> +	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
> +	if (r)
> +		return r;
>  
> -		/* VCN POISON TRAP */
> -		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> -			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
> +	/* VCN ENC TRAP */
> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +			i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
>  		if (r)
>  			return r;
>  	}
>  
> +	/* VCN POISON TRAP */
> +	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +		VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
> +	if (r)
> +		return r;
> +sw_init:
>  	r = amdgpu_vcn_sw_init(adev);
>  	if (r)
>  		return r;
> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
> -		volatile struct amdgpu_fw_shared *fw_shared;
> +	volatile struct amdgpu_fw_shared *fw_shared;
>  
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> -		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> -		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> -
> -		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> -		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
> -		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> -		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
> -		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> -		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
> -		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> -		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
> -		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> -		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
> -
> -		ring = &adev->vcn.inst[j].ring_dec;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		goto done;
> +	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> +	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> +	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> +	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> +	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> +	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> +
> +	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> +	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
> +	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> +	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
> +	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> +	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
> +	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> +	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
> +	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> +	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
> +
> +	ring = &adev->vcn.inst[inst].ring_dec;
> +	ring->use_doorbell = true;
> +
> +	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +			(amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
> +
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
> +		ring->vm_hub = AMDGPU_MMHUB1(0);
> +	else
> +		ring->vm_hub = AMDGPU_MMHUB0(0);
> +
> +	sprintf(ring->name, "vcn_dec_%d", inst);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
> +				 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
> +	if (r)
> +		return r;
> +
> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
> +
> +		ring = &adev->vcn.inst[inst].ring_enc[i];
>  		ring->use_doorbell = true;
>  
>  		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
> +				(amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i + 8*inst));
>  
> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> +			IP_VERSION(2, 5, 0))
>  			ring->vm_hub = AMDGPU_MMHUB1(0);
>  		else
>  			ring->vm_hub = AMDGPU_MMHUB0(0);
>  
> -		sprintf(ring->name, "vcn_dec_%d", j);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
> -				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
> +		sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
> +		r = amdgpu_ring_init(adev, ring, 512,
> +					 &adev->vcn.inst[inst].irq, 0,
> +					 hw_prio, NULL);
>  		if (r)
>  			return r;
> -
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> -			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
> -
> -			ring = &adev->vcn.inst[j].ring_enc[i];
> -			ring->use_doorbell = true;
> -
> -			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
> -
> -			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> -			    IP_VERSION(2, 5, 0))
> -				ring->vm_hub = AMDGPU_MMHUB1(0);
> -			else
> -				ring->vm_hub = AMDGPU_MMHUB0(0);
> -
> -			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
> -			r = amdgpu_ring_init(adev, ring, 512,
> -					     &adev->vcn.inst[j].irq, 0,
> -					     hw_prio, NULL);
> -			if (r)
> -				return r;
> -		}
> -
> -		fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
> -
> -		if (amdgpu_vcnfw_log)
> -			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>  	}
>  
> +	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
> +
> +	if (amdgpu_vcnfw_log)
> +		amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +done:
>  	if (amdgpu_sriov_vf(adev)) {
>  		r = amdgpu_virt_alloc_mm_table(adev);
>  		if (r)
> @@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  	return 0;
>  }
>  
> -static int vcn_v2_5_start(struct amdgpu_device *adev)
> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
>  {
>  	struct amdgpu_ring *ring;
>  	uint32_t rb_bufsz, tmp;
> -	int i, j, k, r;
> +	int j, k, r;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, inst);
>  
> -		/* disable register anti-hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return 0;
>  
> -		/* set uvd status busy */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		r = vcn_v2_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
> +		return r;
>  	}
>  
> +	/* disable register anti-hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
> +		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +
> +	/* set uvd status busy */
> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
> +
>  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>  		return 0;
>  
>  	/*SW clock gating */
>  	vcn_v2_5_disable_clock_gating(adev);
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* setup mmUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> -		tmp &= ~0xff;
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		/* setup mmUVD_MPC_CNTL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> -
> -		/* setup UVD_MPC_SET_MUXA0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> -			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUXB0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> -			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -		/* setup mmUVD_MPC_SET_MUX */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> -			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -	}
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return 0;
> +
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> +		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
> +		~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +	/* setup mmUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
> +	tmp &= ~0xff;
> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
> +		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> +		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	/* setup mmUVD_MPC_CNTL */
> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
> +
> +	/* setup UVD_MPC_SET_MUXA0 */
> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
> +		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUXB0 */
> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
> +		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +	/* setup mmUVD_MPC_SET_MUX */
> +	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
> +		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>  
>  	vcn_v2_5_mc_resume(adev);
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> +	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return 0;
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
> +		adev->gfx.config.gb_addr_config);
> +	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
> +		adev->gfx.config.gb_addr_config);
>  
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
> +		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>  
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
> +		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>  
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> +		~UVD_VCPU_CNTL__BLK_RST_MASK);
>  
> -		for (k = 0; k < 10; ++k) {
> -			uint32_t status;
> -
> -			for (j = 0; j < 100; ++j) {
> -				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				if (amdgpu_emu_mode == 1)
> -					msleep(500);
> -				else
> -					mdelay(10);
> -			}
> -			r = 0;
> +	for (k = 0; k < 10; ++k) {
> +		uint32_t status;
> +
> +		for (j = 0; j < 100; ++j) {
> +			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
>  			if (status & 2)
>  				break;
> +			if (amdgpu_emu_mode == 1)
> +				msleep(500);
> +			else
> +				mdelay(10);
> +		}
> +		r = 0;
> +		if (status & 2)
> +			break;
>  
> -			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__BLK_RST_MASK,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> +		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> +			UVD_VCPU_CNTL__BLK_RST_MASK,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		mdelay(10);
> +		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
>  
> -			mdelay(10);
> -			r = -1;
> -		}
> +		mdelay(10);
> +		r = -1;
> +	}
>  
> -		if (r) {
> -			DRM_ERROR("VCN decode not responding, giving up!!!\n");
> -			return r;
> -		}
> +	if (r) {
> +		DRM_ERROR("VCN decode not responding, giving up!!!\n");
> +		return r;
> +	}
>  
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> -			UVD_MASTINT_EN__VCPU_EN_MASK,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
> +		UVD_MASTINT_EN__VCPU_EN_MASK,
> +		~UVD_MASTINT_EN__VCPU_EN_MASK);
>  
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
> +		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>  
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>  
> -		ring = &adev->vcn.inst[i].ring_dec;
> -		/* force RBC into idle state */
> -		rb_bufsz = order_base_2(ring->ring_size);
> -		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
> +	ring = &adev->vcn.inst[inst].ring_dec;
> +	/* force RBC into idle state */
> +	rb_bufsz = order_base_2(ring->ring_size);
> +	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>  
> -		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> -		/* program the RB_BASE for ring buffer */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> -			lower_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> -			upper_32_bits(ring->gpu_addr));
> +	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> +	/* program the RB_BASE for ring buffer */
> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> +		lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> +		upper_32_bits(ring->gpu_addr));
>  
> -		/* Initialize the ring buffer's read and write pointers */
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
> +	/* Initialize the ring buffer's read and write pointers */
> +	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
>  
> -		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> -				lower_32_bits(ring->wptr));
> -		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
> +	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
> +	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
> +			lower_32_bits(ring->wptr));
> +	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>  
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> -
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> -		ring = &adev->vcn.inst[i].ring_enc[1];
> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
> -	}
> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> +	ring = &adev->vcn.inst[inst].ring_enc[0];
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> +
> +	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> +	ring = &adev->vcn.inst[inst].ring_enc[1];
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>  
>  	return 0;
>  }
> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>  	return 0;
>  }
>  
> -static int vcn_v2_5_stop(struct amdgpu_device *adev)
> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
>  {
>  	uint32_t tmp;
> -	int i, r = 0;
> +	int r = 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v2_5_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		goto done;
>  
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		r = vcn_v2_5_stop_dpg_mode(adev, inst);
> +		goto done;
> +	}
>  
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>  
> -		/* block LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>  
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	/* block LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
>  
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>  
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
> +		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>  
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> +		UVD_VCPU_CNTL__BLK_RST_MASK,
> +		~UVD_VCPU_CNTL__BLK_RST_MASK);
>  
> -		/* clear status */
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> +		~(UVD_VCPU_CNTL__CLK_EN_MASK));
>  
> -		vcn_v2_5_enable_clock_gating(adev);
> +	/* clear status */
> +	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>  
> -		/* enable register anti-hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> -			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> -	}
> +	vcn_v2_5_enable_clock_gating(adev);
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	/* enable register anti-hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
> +		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> +		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +done:
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, inst);
>  
>  	return 0;
>  }
> @@ -1838,9 +1827,9 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  		return 0;
>  
>  	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_5_stop(adev);
> +		ret = vcn_v2_5_stop(adev, inst);
>  	else
> -		ret = vcn_v2_5_start(adev);
> +		ret = vcn_v2_5_start(adev, inst);
>  
>  	if (!ret)
>  		adev->vcn.cur_state[inst] = state;
