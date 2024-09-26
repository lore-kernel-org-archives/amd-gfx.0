Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46097CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 11:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE4E10E173;
	Thu, 26 Sep 2024 11:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="haFyMT1C";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093CE10E173
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 11:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zcp2uglDS9ixmgnKSB1pSEqu50XnYmCFj7jmgPu+mMOL1dqDR+07vj9nsBGbbpsE4m/zLvbUjPCL8dacN6m1Z9wRvk7RbwEP2iYGVvE7ueAFvAcTN2zIBDQYGjc1gN2a98oBkR75KYu4hNk/dZTqcdfZJOp4DL9vI5XggX9P3fYAEPbGwfjfTenoI6ZJan/KzzDXIkcPO5xwsHeQXba9PeX2LKyJIlOoO0kWWtOcgzw2TkSECKJgphp9r9bwSnVYxXUS0lOgAJ57SwZd8Mn+8beFDDjd/QGueGRygm1G6Bwo7Sj5iXwLzR71DtvJ968LOmKyMj6RB8CtF9NxE4W5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siiSoKDtaP2tT8iP0LVOfZEw2kupFpb0v9xK6EdW7B0=;
 b=GXjOMwWKnpyK031P7obluclZXybUP8bDc2sEr3gQAEnH7DL+mDhGvfTchqCO4RykoUmu+IfL/Nzaj8OFD8rTFjMpJIdMvme4VvBwnqGe0SmRG5O8rPEKGAjkr/dye5eOcKLrnt3t6CcXW7E2pqeQckuYHD7xR1ozoy+Wb5vjBRsfpH5UsDvSN2tp4ySXWKywlq5LsjlrVif5RVzS+KgTcVSXWstZ9bN2M57FgF5m7NUAGu0muNrK/fuPKE31tGUuXB7xFT9bWBF7W8JHuHoNW7RdoyCWxHenqKweIZJludvrfdBA4BQTwv/hJn1GOBUgHKegKeEjwWaWb3T2PCAKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siiSoKDtaP2tT8iP0LVOfZEw2kupFpb0v9xK6EdW7B0=;
 b=haFyMT1C2FwLeQoPE6OXCZAEiM1473DZRiHkQq/2WUUFBQTanNeLnIz1RJT29BGGJt+BOBHL1xKaDr6+D4XQJyPcTV1BT+HN1hGTqL8Fh1sr2tP0gYzcZMrwgy2EPi8LAgtgZF9OngnX/0XZiMBxj0UTS8bHVMjhvtP1C31fGr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 11:06:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 11:06:17 +0000
Message-ID: <815cb8d5-0808-4322-9d15-0c6b402e64bf@amd.com>
Date: Thu, 26 Sep 2024 16:36:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix vbios fetching for SR-IOV
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240925182011.1194698-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240925182011.1194698-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 057ec005-9566-4df8-71a5-08dcde1b3e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVZIaWJCU2hTOVcwQ3l0QlpKK1V1MHBiWkxlYUdTdldqalp5UkdWakdYci9n?=
 =?utf-8?B?T0M5Q1JYVEhDN1FkWjhjK3F6cmpIcEtQc0J4TTNGdmxFZzNveCt2R0ZwaGRs?=
 =?utf-8?B?b3kxQkxiNXFmV2tPc29BRmdLc3VxWFA1R0R0QkZ4MmpVTlhtblZMaU14eXhm?=
 =?utf-8?B?VkY3a2FqdVcrMXBQNFRhYytvVVpaaHV0N090NUNzVkYrY01WQlA3R2l2SjR6?=
 =?utf-8?B?bGthUVIxMG9WQjhrd3R6aThMakNrQjNnVGhocDBRZk5ON1U5TWhTbThjY0ls?=
 =?utf-8?B?U2UzR1JKSHpRTmdjOFYvaFJ2ZjBoaTlGYmhMTlZ5TnFBZHgxbW8wcnhWNzln?=
 =?utf-8?B?ZzVSSndOSVVkaHdXd2RGR1d0Y1hPQUNtS0RaR0hjNVZSbXBpcFZmNFdtSTBo?=
 =?utf-8?B?YUZSNXFrOWRZMGM5L0JjN0FSV1plejFXWlZKeCs5dnFrbUdRRjlVeFV0c2ZU?=
 =?utf-8?B?b0FTTXZMQWpselNvelJRQmdCbExnMjdJd3ZYRDR0QlJZNTEwTUVIVDhHUG02?=
 =?utf-8?B?cTdlMUQwR1RCV1JKOC93MEhlMk1FNisvcmZBQXFGdnN5emVrZXY2elhnQnNH?=
 =?utf-8?B?VFlPOTc1U1JVYnhmYkJ5b3ZGNFFpOGVnSnBBNlhuQWtha0FoWlRDRzFNV2U0?=
 =?utf-8?B?VHJEY08zWkJqVTBEQXZWbkdhMGhMMjBWMktWYkJwaHh4eERudDhHLy9zMFdD?=
 =?utf-8?B?Y1I1M1RGVXdzNDJmYWNxRnh2cFlvN1ZTd1IvRGU2bWx4alJ2QXo4elMzT2Va?=
 =?utf-8?B?aG0zZmRudXE5SnArQWVrK1pmOTVpTEtRc010VlM1bXdRQkNVQmd5NkJ1Q0hj?=
 =?utf-8?B?dHBIYU5YUDd2aVdOMVhTelkwaEp4c2tnVHErNUJLcDZ0U2o1SS9ZOUdTa2dm?=
 =?utf-8?B?cEFQMHdyWGN0WkM4SVZ3ckwrWVNUdFR0RWVIWTNab1RwZS9Zdjc5d0RmZ3pu?=
 =?utf-8?B?S3RwYXNBb0R0UXNpUHEvbVhuN2t4bmE3b0p6NVI4N2taTEJZbVhkOVIzU09r?=
 =?utf-8?B?TEpsSWIzNUxHVEsxcm1Td3FaVFJuMEN1dDY0QTBWemE5Yk4rMzFYT1Z0QS82?=
 =?utf-8?B?VkhTNUFOL1d3Rmt3Qi9nMWl5ektsdWZWRjNKVEJydUg0OWVLN3l4cjNzckVj?=
 =?utf-8?B?VXhra1ZENU9lTWFPOEtYTHIrMlJBV3I1OG4zakRxc2pwbUhwY1lrZmN3ZUZE?=
 =?utf-8?B?QTRlTko0TThveXZGTFBNcTZpREx4dkFWWTNLWS9Hd0pEN1lnYkhNZ1d2ZDhr?=
 =?utf-8?B?dUdJMTZQMzgzYlE2MTMxNG9KYTQ2WElKUGs3WFFmQ2d1MUExZEV1dk9SVFE3?=
 =?utf-8?B?MXdteHNLcS92SWJuS0RkelhNNE1hcGVvYWtvOFgzYXJtbTlpMUo3bFl4Y1ZN?=
 =?utf-8?B?RHVkdUlZOFNDSFVBZXA1bzhBLzdoUUFZNFNyRWRhcXltUHJUeUduRWx2ODFu?=
 =?utf-8?B?cTk3U1VsblhTQXUxbmtJMnV6KzBGbFdaVldvb0hHanJEaW56M0RSRCs2WHBU?=
 =?utf-8?B?bDlPZmxxVGlSQ0hCbTk0am1la3N6U0Y0eVBpSzJXVi9RaFdhTC8yakNXMGt0?=
 =?utf-8?B?RXNvdXVwTVhUTStHWVRqOXpFN2RybjNmNndXSEd2c3pJcmU1MUhNVEhXVlJJ?=
 =?utf-8?B?bnJuS2pJYzYwZFZ0ZFJIeWJ5eFJyN3I0NHpvd0xmWldZblBMbU10aTV4WGZB?=
 =?utf-8?B?ZkI4M1lMRUZPNURXQmt1V1grTHFOM2ZZc0xVamtJS290anpUaXYvYVlUbGlm?=
 =?utf-8?B?MnlIZDMyZVY3b2k5dEFkZlBVekpISXlFVnk0VGI5djFjVEhhSDVYNVF3SzVO?=
 =?utf-8?B?aTdITCtmdmo4ZWptWTBuZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG80NzFnbnc3TERFaHhVRXBFQ040N0x3UmJaRnpVNWoyMG9ZeU8yMHJsV0lH?=
 =?utf-8?B?L0Q2ZFFBSnFJTDRmUWNaeSthejJpR2FTRTgrNktCd2oxUkRIWDVsTmtHNVBB?=
 =?utf-8?B?RE5HRVZ0bzgrNWh0MWJqWFVwbjVCT01nSzBMOHlnV3dWMWI0aWZyZ2RPTG5K?=
 =?utf-8?B?ZkthVmMyT2pEWHRsQWplSkRVNWU0eTU1eUh1YnpsWFoxdy81TVRJMGMzcksv?=
 =?utf-8?B?eXdsWUVyczZHcnM5T1hBeEpMNFJtNEdmODNwWkZyTFdKa21ER1d2NFV0M3dQ?=
 =?utf-8?B?OU5iWnZ0L05HZlBZSVRmckNvczBWcW9idGpYQjlLWGo4bHRUa2ZXcVhwcFVl?=
 =?utf-8?B?SmZwZ0lUZ2xkL2JNYU1QODh5c3NRYkFTVHBtTGs2M2tSRU82VmtVdWZpOVRh?=
 =?utf-8?B?dnRDV1JuaUk5NnN4VjU5akVyVm9CRW5pcFNpTGZKOSsvajNYYVBZWEVmWXRY?=
 =?utf-8?B?SjZxNlJRUGwvYnRxKzIraTdpeGJqNG1scE1rcXVhc3lPWmFlc25xN3BUREJ3?=
 =?utf-8?B?anRCRTdobUo1RlZzMmVoNG0ydWpPam56YklhRUl6L292MHJxR3hMVHBhNmRh?=
 =?utf-8?B?dW9GYUJRWTUvM0p2QldsbC8xZWdCck1KY2F6YjN3UnpINlpsSEtxVUZhMVpK?=
 =?utf-8?B?MXN0S2VjdjloeVE0aGFyWEFpWTBaazVJdkdUbTdjREIxMkNmNUNhaFJITmJD?=
 =?utf-8?B?V05ESzdVbWRKYmZsRWhoNTFmc1pmalZFb0s1WElUQ1JySHZtM1lkRXVoU01q?=
 =?utf-8?B?b05rTCtrRlkxVVFJSXZMYTAxVmpJUXI1c2F0bUQ4VXhwMS82MWJSUzdxdEl2?=
 =?utf-8?B?eXFITURKNTQ4WDU0VmdWOGFpdVJ5MitLaHdjTFZGRC9qQ0dhQWVGN25yNWI0?=
 =?utf-8?B?VzUweUtTRFlTLzRnVGc4MktmVHNrL3hMS1FqZitiRG9PSCsyMG96aDA2V1Jq?=
 =?utf-8?B?T3FaeWlSOEtiRkExcmdqcHN4ZTlnSDNBMGx4NFRKcTBYeWhTQ3RiQnk2cVRx?=
 =?utf-8?B?NS80L1hJUFczZHk5NUp5VXFZUFphSHMxUDNFbWszb3JpY3JESjZ4UUVQby9Y?=
 =?utf-8?B?MzdPZk5RbXV5MjlJWlNXQkh6M1YwTGJmMzZFZUp1WnRUSzJVRzk3VEx1VE41?=
 =?utf-8?B?dGJBOStRK2daT1YvdEozcHAzbTRPVytiSnU2dWxaK09GSWNrTTBaTGFaajdF?=
 =?utf-8?B?QmhvMkQ3WDFSZnprcE5Tekh0bUJSVkl4dE5YRW0vaW5yODBWVFNVNmJzMXNX?=
 =?utf-8?B?d3NhVEtYSUVkYmFGK1NkeVZGcFZWc0NsZVI4Q1l2NEFTa1hhb1JFSXV2UUts?=
 =?utf-8?B?c1BoSGRoMklza0w1eVh0RzdZU0NQZDNtQzNtelFSY3dzb1paSTZxdzRHeWwr?=
 =?utf-8?B?VmswRG16NjJVMGpmdHNwRVBheHZKK0YrdkhBMkQwanhxV2F6UlBTN3hud2pV?=
 =?utf-8?B?akNoSHo5b3Z2cVZwelVONGxuNklnd25uMkdJOExoNW1qMW12L2RITDhxZzIx?=
 =?utf-8?B?b1FZcG45dkpyTy8vVXl5clg2bjJDQkF6dmRoNXo3dmRGOWs4Z3YwMlZPTmhG?=
 =?utf-8?B?ZUF5OW1FWmhkOFJxWVo3aVMybW1UWk5NRi8yLzkzaHBNQTVyQXRnNFJpWitC?=
 =?utf-8?B?ZzNpVlpQc2NHdlZzNDFmU1lEVHpMV0w0MEhXTzExS2FCak9Gb3NOL1Bsditq?=
 =?utf-8?B?MmpJdjBnWlVaRXBvK2NBb2huNXoxVE4yYlVsQW9zSThNc2JhMnJUNHZJa3VI?=
 =?utf-8?B?cGhPTDFCNzFwc1JHdS9ZSktnQ29jcjE4a1ZwRTRNUmFkQ0NoTjNLekhiTWE0?=
 =?utf-8?B?blVQY0ZEbUo5K0xiR1NNSG8rdU5sdC9yMW1oY1dLUi9PcndCZmw0OVk2bWhy?=
 =?utf-8?B?VzN2eVhvZkgxRGc3QWgvSDFIbm9WM1YyK29TTGsyTEhnVWVlaUc4aU5wNGtX?=
 =?utf-8?B?UEo4UUdBNFBtd3JzOUZHZ053YU9rbWNCQUVVUGdLN1h1KzBhUjMzelcxd3VB?=
 =?utf-8?B?S2NOWEpTSkRPTGJrUmwrQU5wcmsxWFpWb0VpdGIweVlrUUp6dFRSVTdBenE3?=
 =?utf-8?B?dEZVMUEwTUZUc3NUSys5OUFTaUdxenBvcFFCc1p5aXZzbytCUzBwdjcvZzcr?=
 =?utf-8?Q?YSjTxUCwsM0dNNcu7JQtavXRY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057ec005-9566-4df8-71a5-08dcde1b3e3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 11:06:17.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1MJ4r4HG5wlV2SuPFZZ/JtkAFT35K9KmYWTWjfWVg/jsdi/0Gbm6nCLaOJmVBeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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



On 9/25/2024 11:50 PM, Alex Deucher wrote:
> SR-IOV fetches the vbios from VRAM in some cases.
> Re-enable the VRAM path for dGPUs and rename the function
> to make it clear that it is not IGP specific.
> 
> Fixes: 042658d17a54 ("drm/amdgpu: clean up vbios fetching code")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 46bf623919d7c..45affc02548c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -87,8 +87,9 @@ static bool check_atom_bios(uint8_t *bios, size_t size)
>   * part of the system bios.  On boot, the system bios puts a
>   * copy of the igp rom at the start of vram if a discrete card is
>   * present.
> + * For SR-IOV, the vbios image is also put in VRAM in the VF.
>   */
> -static bool igp_read_bios_from_vram(struct amdgpu_device *adev)
> +static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>  {
>  	uint8_t __iomem *bios;
>  	resource_size_t vram_base;
> @@ -414,7 +415,7 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
>  		goto success;
>  	}
>  
> -	if (igp_read_bios_from_vram(adev)) {
> +	if (amdgpu_read_bios_from_vram(adev)) {
>  		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
>  		goto success;
>  	}
> @@ -448,6 +449,12 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
>  		goto success;
>  	}
>  
> +	/* this is required for SR-IOV */
> +	if (amdgpu_read_bios_from_vram(adev)) {

If this is only expected for VFs, then it's better to add
amdgpu_sriov_vf(adev) check for this call.

Thanks,
Lijo

> +		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
> +		goto success;
> +	}
> +
>  	if (amdgpu_read_platform_bios(adev)) {
>  		dev_info(adev->dev, "Fetched VBIOS from platform\n");
>  		goto success;
