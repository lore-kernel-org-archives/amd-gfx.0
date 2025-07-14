Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6AFC83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 02:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9E710E1D1;
	Mon, 14 Jul 2025 02:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BClIA/Hr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A16810E1D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 02:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DarBnseIAvPAC7FSm5rmrLVtKfuoA4zb5sTJTuu0QqcOo8NcbQhDpJDccLNjI1cZyFP/GZpy0JEHyn78CS7ZmjP3saO/Vzvw6Q9xUWEQHGTsqOAOHAoNSbjrC0BBNsNo0i96Mety6tGCUnYJMnZPDDVko0tRHMZl68ZNWRLXSIpxMF2qEao6bey/M8GbJLcPSTNfcIRWtECami9dIqQPGGdsYIfW17zwBn5tTrw0w0mgOklkvSyHQgZGzzYdAkM7e40+pyl3IODoLN27YOEGreHoYwfd74xwHJWwTZdyi5HgDpE1u5lzQvm6h1XR/V6mK3iWDT8uA2IYt3NuzoGGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lslABebL1qLLC9Jl64Xck5Gqv1NQZgQiKBeQBvbWNk0=;
 b=SSSepto6ivRyvehMpaOkEPgs+UF+iWEqaSPtSbcNxg+zVOVXkq4vc7yElVluKEf3GfFrCBrbr3U0Uhe6PXQe+sHuj+DYOnT9OtVoI7zQXi1knu57CDFO922HmCA5LodpphZINuk/ZMwVn5f4W2DQ/6xvNgoAcPW92BMsbtrh94heTI9zVyf+EVd5NMGX6uQJTP8cpEj12qhpdl4GMnNL1LcCRVjbserDwP5s0wJSBJ+co4EN5vHybPk7hi4GoxNdnbf85O4PKfFw0GqE9iRyJe/spzPc/VFBuPhwhQkS/h1p3nOEPYo9UtvFacbs6EfT8p/8ammBUQjcpOmjNrcQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lslABebL1qLLC9Jl64Xck5Gqv1NQZgQiKBeQBvbWNk0=;
 b=BClIA/Hr4E5hCH+ZZwMrXqkVrd1wQfOvwneWbzSs7ssOz3IGHsQHq9M8ZWUOrl9iMzsQL3j5Ad76blSVBw9vQyN0ovKiiHcdyQ6pvLRV3vOj/sEaiyMyoCkVH0AZssG+JFltpkJaXtPieD4E33Nm4UPvtFjS+nWKqKathSpf7oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 02:59:03 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 02:59:03 +0000
Message-ID: <470654bb-b150-b7d2-f1d7-dec21e66fae2@amd.com>
Date: Mon, 14 Jul 2025 08:28:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/33] drm/amdgpu/jpeg2: add additional ring reset error
 checking
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-3-alexander.deucher@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250711224024.410506-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::16) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a166839-cbab-429a-d580-08ddc28263a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnZUYnQ5ZHdsM1dpenJJTUtrNTBvS3RidlNKUHNvMjRNa2p3N0EzYkF3ZUxZ?=
 =?utf-8?B?amFkVDk3ajdydDcwaGtlR2dBVUIwUUVkQ25NNHdnNlhqM0tUdW9WT0dnZmhX?=
 =?utf-8?B?RFIwTjk1T20zcmlMTVVzWkdmaHZWYlZGRzR6M0MwWjE2VTRjRjRtT3lZT000?=
 =?utf-8?B?SUpsMEpORmxMb3VGV0dUWlkreHJRYS9kZmlQKzFCOU9HRm00L2g0SEljK1RM?=
 =?utf-8?B?UXpGZCtnSmh2Y0ZacVVvZitxQUkrT05xVGM3ejRoSWdReFlraGoxcU5wYU9V?=
 =?utf-8?B?U3dYaDdEVzZpNytmNjFSSStJRXYxSkF2dUJlbnRrSDdRQmkwQlNFanl0eWp3?=
 =?utf-8?B?SFlQMXRpK1RqK2hpTTBLRFA2dklRdVBkYUVyTTBKR2VFWTY2WmNTcUpuRDE2?=
 =?utf-8?B?enpGZFlkcjRsbWZUT2NQdlMrZ2x1dVdybzBIYUc4bHNRelBwMkJKSk1uT0dk?=
 =?utf-8?B?c0p5dktWKzRmRWE5aVA4Znh1L3l4cXNvYjdMb1FQV0VNYUV6Nm1yM1dhZjNF?=
 =?utf-8?B?V2N6Wlc5clFsb2ZLdVNTUmhuN3o2N2RSQ0I4Y0NST0h0U05xaXprVHJWVmx4?=
 =?utf-8?B?akxZVTRMZElsQkk0NDhDQUVVUzlNY1FjYVk5ZVdEeHl4SnRDR1l4Sk9iRDV0?=
 =?utf-8?B?d1FDM3RBdGZ5dmFyWTRKaFRXbDNCbkhzbFBDMUNMbDh1b1NYekVsMU5jK0RT?=
 =?utf-8?B?LzYvU21rSm4wSUZ6T0xjNlRVOVlTbTZMeVhqcHJreWpPY1YySlVvY3Q5MnUw?=
 =?utf-8?B?VjZTd202T3B1VmRrM3c2MXV5OXJINXphdXY1dlBwbkx2MjF5NWZQc1YrWStz?=
 =?utf-8?B?MXo4NnFoTk4zU1h0VzVnbFMxTWNhNytmVzl6R3Y5NVBQTG1CNmd3Q0paOUtJ?=
 =?utf-8?B?dWRYTXorckwyaXF3Wk5kYzBHL212V2VCbkJSd2w1Qjh3Z3h4dlRGYXBnZmI5?=
 =?utf-8?B?YjR2M0pJOHpNQXhDZ3ZRWDJJTkU2TjBaUGl4WEd6V1N5dTRnbGJ0WHBJQ0hy?=
 =?utf-8?B?VmlGWlpXM1RlU1Rwb0p1cWtYVWlZaXkzclkvdi94UkhlNGRCNG9yWm5KQjdG?=
 =?utf-8?B?Q3ZVL1dyaGl5NUd0OVhjdWxtZnpnenEwNm5CcVB4S0tlRTZWay9Ub2pMZXNL?=
 =?utf-8?B?cEI4eExFSnRDYmQ4Z1ZZY2xLV0tNUXZSSjF1TEVYUlExWlVoZ2tWMFJZS3RH?=
 =?utf-8?B?eDJQVzB6a1ByTkEwaTc1Q0NScnkrTlRpYmRUb1B0eWQrREc4S1E2T1JYbnhM?=
 =?utf-8?B?emNkZXhWMHhOcGdrbDJWU0tndFpCVWZvZUZKaHVpMlpGaFlhNUVjR01ya2RW?=
 =?utf-8?B?TGtBZTdFQ1RZWVc3OE1xdG1JMzkwQlVadnB2VjNXM2Q1VHZVTzdTR2xhNXhW?=
 =?utf-8?B?L2NKakhYUkdNNGhRZGc1NnF4eU9SYnp1c0dINkZnQTl6Sm12RWVPN0VtNlpw?=
 =?utf-8?B?VEtEUW9XTG9ZaTVETzFsbTd0VW1nNDErVWxtNEZYckQvWldMZ1REeFdKeWZt?=
 =?utf-8?B?ZzROajF6UjZTOXU2N2xMeXJRWm9xa29RL1o0MWZORUplVVc1NHdoOFRYN01P?=
 =?utf-8?B?WVFNRHdVUWtvMnNFeVJGWkRsdHR4dG1zM3cwb2JUYmVwRzdsRDRWcVJkMVlG?=
 =?utf-8?B?T2lrYksyU2RqYXhleHAraFE4Q2FOenVrQ295c1ZqWit3eUc0ZnVENi9Scmsx?=
 =?utf-8?B?dElrcGZQb2F0MjArT1ZZcDl6cnBobTNpZlQ4WUlrL0xpRkl6YzJ2YkZhZ3Fo?=
 =?utf-8?B?bDhVKzFlK2haRVhuOVdpVGk0NzdmeW1nM2RrODJiYlBxUHFiUWhEcDBpdmQr?=
 =?utf-8?B?VC9XeU5UQ3ZYYkovUHVMM3RMb2ROT2hBbnBQdFZaUTQzb1FSemlVM2dkSzZz?=
 =?utf-8?B?QlpnM3RTbGlHOGU0YlNiemxMdHRESVIvcnhzcndiaXZPUU1SRy9CakRvWnpD?=
 =?utf-8?Q?gFcAUiBuYsA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3R5UUJFN2FRQ2g5SFVJQkpvcnBCMEljMDQzU0xXczh4SFZzYXJZNmxJWW1F?=
 =?utf-8?B?QTFRN3UzQk51bDZrZWh1ZWVGV0ZqYUR6TUcyUWdWUUZxQktyd2doTDVMWHpQ?=
 =?utf-8?B?algwVEFqaXN2ZGIrekRnSXFlc0NrWndoeUJvSmdneFpDZ2JCYkFOaHdaMlNq?=
 =?utf-8?B?Y2t3Z3hOTzQ3Nzk5WmNmU05hRlVCWHc3Ri9uZTN1MVVmdE5qb0QzbEU0RlNq?=
 =?utf-8?B?eC9ydllWa0N1OU1SbUk4bFNQdUpsdTBCckNYY21XOVkvTVgrSXVWeFFlVkxp?=
 =?utf-8?B?YUJoV0d3Zk5qNk96YVI4MTMyZldaaDdrWlAwOHRtNlF4N0lxTVJORmEzV0Mx?=
 =?utf-8?B?STI2YWFYRjhFWDZLVTY1aDgwdWRjM1VCMTFrWmlOMTNYOGpOWmpDL2oxK0l3?=
 =?utf-8?B?YTI3dndpUEp5MENuVEQxNmRSOTBKSmhuKzZ5aXd1OWxISFZhUFFpV1BFMk9l?=
 =?utf-8?B?VEI2NGZkQytyeExyUU93RjNKY1JFRmExaWM0L3V0dG5zeHhseUVMS1hjaXBY?=
 =?utf-8?B?aVRXeUVzQ1hpK3FFYXF5dGFaNk5xUytzSEtyNFcrK0h4RjBJbVhaWXFOS0Rn?=
 =?utf-8?B?bW9FTitmTWsrVzIvRk5wNXozWFJXeHdaVnkyQ0RrOHo3V3N5UGFwS2xBTzdY?=
 =?utf-8?B?RzJXdFBRVmdrSmF3K1JVcEpJWWNnSUk4cnFMUHRURmNyRDd6R3Q3elA2bDdQ?=
 =?utf-8?B?cThOQmhLZ0NYUS9GSTEyT1dDSkRXazhzclJTcDdqTzA5a2d6QWp3MUtMNkh3?=
 =?utf-8?B?Q3ZiRWpxRjI5Vy9WdHh0SWZJM1VTaC9zY3lNam1FZlg5eU8rbE9SM244WVZB?=
 =?utf-8?B?RWRFSjhTcGI4SFhJM1RVQzh4V2RiVjJHdU5DZDM3b0dwM2kwUkVrcm9zTmFJ?=
 =?utf-8?B?QWpkK2NETEtBQ1Ftb2tpVk1LcGdwTWtYcXdORmlLSS9EUlZsNHhCN3pZaG8v?=
 =?utf-8?B?NEFjMW5RRkR4bXZ5QkVITkRtMFM0U0psUUtWRHNwbHJxNnV5S3hXK1FEY1RN?=
 =?utf-8?B?WmpJQy9ld3hidVE0K2FhZWpuNkUyVVdRckd5VlJ0R205d01LYkxuMEhIVXZL?=
 =?utf-8?B?Ky8vUWlWNDdnRzFVQnJrU2h2T0RXdnVvc1Y0TzdaZlpIaG5yTi9VeWFFMFhY?=
 =?utf-8?B?SE5zcGZhQWxubVA4ZEZTV1BKZ2hVR29kQmhUN29pK2p6YXBBVU00ank5VzRQ?=
 =?utf-8?B?TlFQSFVSeGxYL2d3QlB0NzBPQ2pydnpINXpxaFJVVDA2SWlWMmdnSFViNktQ?=
 =?utf-8?B?ejlnWWdpZFFmSENCWUxTdzZYWjNMZTRJRlQxdEFxUVZFU2Z0L1l4eVEzcGRT?=
 =?utf-8?B?bm1VaGJTbXNMVGh4TFBnUjI5eW91Mml6OVZHRXc2eW5mMmtYM1lVcThNcXRo?=
 =?utf-8?B?eDNPZ29DNERwRG5FSEVoemFveFpNNmRtRjM5cGNCL1NmbzMrckJSRmF2Wk1l?=
 =?utf-8?B?c3MwZ0pRd2pCT09OZDZDd21LZUF3U1R5dWU3M3IvSDJ4SkxFd29sWTNIMDNI?=
 =?utf-8?B?em9CL1RNUDhrR0xyNGo1TmdTc3VIT3E4RUQ4QmFlcjJGcnFNK2NRd2FSRnc5?=
 =?utf-8?B?SGRTSWtlaklycWdnZHNWVTlvS1Y1dDEwSHFsYkFjRVZSK0ZTWG9TaEdCWlYx?=
 =?utf-8?B?eWlMUThUMys5dUdzR3hvTjdHUHV0VHFYQ0FyZlIvYzVhM3Q1N01tYkxleUxF?=
 =?utf-8?B?NURReGNtSHk0cWU4OWhNU0hBSHFwU2tnYm04TTRWVEd3d1d4WGsrZHgyL0o0?=
 =?utf-8?B?WlJoVkdXWTFWeFNMcFgzMURJa0ROOGp4VURKOXZ3UG5aNGlobU90cUc2cFho?=
 =?utf-8?B?UG0vYm1jMUtsUHlISGxxdDhtT25QK1pTSS8xNGZmckZHZ0dJNzNGcW90eTYv?=
 =?utf-8?B?S2ZaUkFqWFdLamE2L0ZudkhBSDRtajdZOGRab3ljL1R2VFpsa1FscC9CSDB2?=
 =?utf-8?B?bTB1S28vU0traEw4Y2l1dWVLZlZTTmZVbHE0YkE4K3p4akQ2dk53V004WE5B?=
 =?utf-8?B?K1pzN2k2MW4wUUVtNk1yMFF1L2l5Vkx1MERzNGVNNENROEE4a3c5ei96SEtV?=
 =?utf-8?B?anN6V3E5RHBTN0xEY2l0NXZFTVVwSDhXTzlSUFNtVXR1ZWNXRDRXaVBEbk5G?=
 =?utf-8?Q?1T4He9phDXHgd+TpOnsZJxRMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a166839-cbab-429a-d580-08ddc28263a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 02:59:03.3485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ko7vhX8t6bsSVGBtOD2Z9IOWOmHrqQrHYlks+GmW34uJeviECI87H2gurQfbo1jsYFb+EtJpBkEOPb44+RHAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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



This patch is :-
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>


On 7/12/2025 4:09 AM, Alex Deucher wrote:
> Start and stop can fail, so add checks.
>
> Fixes: 500c04d2a708 ("drm/amdgpu: Add ring reset callback for JPEG2_0_0")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 781a5a8a83614..5ba1c5ad9a5e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -771,8 +771,12 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>   	int r;
>   
>   	drm_sched_wqueue_stop(&ring->sched);
> -	jpeg_v2_0_stop(ring->adev);
> -	jpeg_v2_0_start(ring->adev);
> +	r = jpeg_v2_0_stop(ring->adev);
> +	if (r)
> +		return r;
> +	r = jpeg_v2_0_start(ring->adev);
> +	if (r)
> +		return r;
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
>   		return r;
