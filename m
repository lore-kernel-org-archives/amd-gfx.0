Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16CEC30653
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 20:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A4510E0A9;
	Wed, 26 Jun 2024 20:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HbjPN+OX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42C510E0A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 20:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnWJvbHJV20c2c4EPi41D7vwyv1Y8DvuHPa/HpgfbtoMvAVKPGnjF3UccbWBGzHyYSJDMOk5H4EbPf19LPkRxQ/r2MBBoB+++UHn2rckX8GiMOOKSi05wuO//ykG78+fo2fKY1OkL/5FVkwa/nu2Xq8/OmdWD0FFxamkj91jN3lNRBScPmXxW7PnWfNUFr3YR3QS61brwpp/SmAKdFt1gu5bUjmEs13GB4WGu8J2h2E8SeVa+75Qi+etjWMvZkisNS75VMiq+nS5tgCs+x4QX2zv0hYENoyVg21fgMvJlXCES+LmXV4jI/9kS2Ib2W8N6anwVwsWZ6lHVVZSq2ED5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPSZP6xlg3Rq38YLnTd0yFH2bKKosbSrB/8nwa9mQHU=;
 b=JLDYT5fo2zEEZmZl5PvtU7pLV8+pV+TZO7ZcpjpoepHOp4qcFx5xRkUI6I2m4kZcg/bIsdyAIZ4xVPztx4kNTSNJh9K3RWYY04K21dEhR/73LxVEV0owjbUVPHW23tOMBqPWXpuab/xTIepwQ3Wcl38/nlCpz4iBoYTjQagV3DKNQ1VvuGbTgty840FvIGlRQmyFP99Z0ZW3hGYVCsO6UqY1vY0dGv681WXiaxtUdDRVUYnI3DrLHZQHNM41FYrUtzFo1m/GYIpWSoD/JJsU1DJjO2vPsYkAX9SxL+QFXbQAcfc03V1DL3QC5iQ/FAndvbChmfHtgKQebHAl8uJn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPSZP6xlg3Rq38YLnTd0yFH2bKKosbSrB/8nwa9mQHU=;
 b=HbjPN+OXl2Qw5Hy20N4ku30GekJ7w3jwBv/yV0OzcFPjh5MYqhjOdz6DJYHcmyzC/i9XEOy9k/L1v7vJ7UZRNhSJ3BjuEH43ZqU77xaj5Ccb9u1cj4Xx9x/X2AOP/PEldv+o+KEko96Z1ffTCoyQVzli3QhGWD8UuTOIqFHPOQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 20:20:23 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 20:20:23 +0000
Message-ID: <dc4e0629-4f49-4cde-94d2-778fbf93ae4f@amd.com>
Date: Wed, 26 Jun 2024 16:20:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] drm/amdgpu: rewrite
 convert_tiling_flags_to_modifier_gfx12
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
 <20240626183135.8606-13-marek.olsak@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240626183135.8606-13-marek.olsak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::30) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 950a5de3-ecc2-4fe9-dad1-08dc961d6876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVpieHE1eFcycDBOc0dha21HOGIxd2ppZFhuOUo1U3JnMjJYVnkyenBNejNF?=
 =?utf-8?B?cUV4bkc0Z2MwRlFCQ2Y2R0ZsRDZmWHpuc1o5ZCtxd2EyYXdyNzRtNjZEQTUr?=
 =?utf-8?B?aTloSXFWaXpPZzBvUWVZcitOM2RaTkJ5TWpoOVdvVWJoZElpQW5LV2NEeFI1?=
 =?utf-8?B?WUdnU21tSmgwM0EvVDJMM0d5M1c0YUFUcEpmTEhYTnRQTnQ3c0REU2hpTnBQ?=
 =?utf-8?B?bzJ5TGRERkJrbjRkNVJLbmdvOTZjeHhOYkFTRythWmFSMStTaWlTV3JBRTZO?=
 =?utf-8?B?cStvZUd5MDRPK2w3SWMwdjFZOFJQL2dIdG1KZzdFR0RGQkV1Q1piOFpYcHhX?=
 =?utf-8?B?YldNb21DeWV2WjdkSDZQZFdqVVJseTZpYTNCMTFEb0VmV2c5ejVwdzRRY2xP?=
 =?utf-8?B?UE5sL245NlFmcklVdHpDOWRibVMwVGExVUZ6dFJGeDdzandBMm5xSFVSTlRF?=
 =?utf-8?B?SGRiYUpiVS9pd29VU2N4bEtma3JOSTJsSEZsU0ZhYWNRUlN0VEYrM01SMXZy?=
 =?utf-8?B?V0VTaEZJNDRqWjc3UFUwMGFxczZZK29oNjNLSGFQam1MQ2FTcHNLbmVqdjBE?=
 =?utf-8?B?TWZXTTFlL2hvc0J0N2ZtbWVJSlA2VkJzcEJSSVd1eE81YUt5V3pJMjFFd1Jo?=
 =?utf-8?B?TlVjbDVNSFlGM01UdGUvVGlSNFpiWXFEd1Z6c1llc3B6NjlUbkl5WG5McXB0?=
 =?utf-8?B?eWw1Z21XYTZrdHNtVGhseTdxa3E1U09WR2pqMEV4OU5FekMwRUN0SzEyOVNV?=
 =?utf-8?B?RzViZk1hclVLRHVhdEtHNEZ1RjlVcWJ5OEo2ZC8rTWQwRThHdktCVVR5OGJm?=
 =?utf-8?B?MUhVbDBnd0JRcVZqOHJneUxjWDI5ZFp4ZytYTkpicTZtT0RZTUxvL3BERFBR?=
 =?utf-8?B?MzYwUnNXQ0JxZHhnUVI0OGRuamdOT1p2ci9RdFJBUFk0d2NFYUk4MHVRMG96?=
 =?utf-8?B?N3ZKWjZqM29RcmlGK0FuZDZxSUVaM0lIZ0RueUQ5Y0NpMmxXUWdVd3JoVzNY?=
 =?utf-8?B?OGdYM0pqOFV3YVhHQzI2Vi84WE45S1lsWnNLcExMUDQwNGhWQ3dFclYxcWtU?=
 =?utf-8?B?cWphQWZzblEzQTV6Vk1NNFhsL3RPQVpsTCt4S2E4QkRqWWpQQi9YQWRaaURD?=
 =?utf-8?B?QlVhRHllSXBaeWVQV2t3QXNhZ29hMlp0eHVvQ3lYYUtGZ2lFWmxhUHZpaEsy?=
 =?utf-8?B?b1NpRXVIUENRZXZicm9rKzN3WUk1dmo1ZmpFOTc2a3RTUE14RDdDSy9tWXR2?=
 =?utf-8?B?Rk43ajJSbGFEYW5aZE82dFUyd3RsdHBGbW5MRTNEVDNXL3o0RWdnZFdBMHh1?=
 =?utf-8?B?U0VRWjFMVlF5WVpQZ2lmT0h2VFNsVE44a01XV1ZjVWVBTTMzVG9iK0t3SGdL?=
 =?utf-8?B?dm1QZWlleUhTRkJsZ044UnRldFc3ZE9JajNhMnhUd0RteXFlSVo3Q3BLUURD?=
 =?utf-8?B?dVJZclJlTmlRakpVVzJSWW1aN2NSL052V1AraE1hOUdMbTBWU1RWZy9kNFFa?=
 =?utf-8?B?cThtVjhtMmcvc1lMT0Qxb0ZQMWVEUktDbm1FcU9xSlJnaE9oMHNQdHNEV21V?=
 =?utf-8?B?ekcveVFaZ2pINnVqbXhISGlwMUpETWVPT04xMER6bGwrVGkveEllOTIzN1dS?=
 =?utf-8?B?Nzg5aitSdXVGekY4RXVrc0k1T25qS3d2UjhsYTFab3RBOWdwNUUvNGxlRVpr?=
 =?utf-8?B?YTZQUmhiOE9OMHhiS3BVSU1kdEpJS3g2cU51UVNEckhxZUpGd1VaK2VPUTVC?=
 =?utf-8?B?dTFlZzlEVFpVd21Ta21zL3paT2ZxMSszVFdWUlhLK3libG5zUVdNWlpiZm5x?=
 =?utf-8?B?YmF0MEE5RHgxbldIc2J2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(376012)(366014)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9OUUFkeXNxcVdqWTZsSE13RlhJeU5BVE51aCs4NGZGNTlQNjY0TElnUVdO?=
 =?utf-8?B?aGhqeXN3QjVRY2VDT01mR3YxTlhXbkJDMWI4eVFZbXErY1AyWlppUEd2cFdz?=
 =?utf-8?B?cXczd2FhajkzOXk2WTErV3RlWVVFZ0svZzJPOStlMUszTFE5TGU1dmwvNURJ?=
 =?utf-8?B?Rnp6RWNzL1IxcWxmY0tjM1BLWGtxUnZGOWd6VmtScGVhLy9VYVJOUWM2QnEy?=
 =?utf-8?B?WWhQcm1ycXRmQzJqVHBpbWNzWS8xUi8ydDNPM3o1dy9QcWhqLzRNbGYveEFP?=
 =?utf-8?B?dVM1dVYrQ1EzNHpWdUkvL3NCcXpnUDlHaXdnNnFzN2RWZ056UVZNWlBpUXVM?=
 =?utf-8?B?ZnQ3clJMYUVEbXVpK2ViY29STUx6QU1tVktWTnVjcGt4ZDFqQVBLNks4TTVr?=
 =?utf-8?B?UnNHMHVuSVhkY1ovMGl5Y3Bicm1ja1plUHlVQXlabVFnUUlGd0ZPZjVyeFJU?=
 =?utf-8?B?TElxU1hJZnFJZzNvZUFGZXZ3cTZKZnhwT0hrNkIrZWp0TDJSYUx1RDJROEFo?=
 =?utf-8?B?VlVIWlRGdndFTFpQSTBtbUo4Tmc4Ym4vUlZ2QlBqMFJsanJ0UlhXN0FuTTY1?=
 =?utf-8?B?cHJ0QXdiSjlQZGd4R2pmSjdTZ254anBmazJTMW8zYXdQa1FQVEJBMEZSYVZx?=
 =?utf-8?B?ME9vb2U0MTkweTV6dG51d0FMZTNKa0N3ZXF4dWFLQzB3bEVwTDNnV2E4L2sz?=
 =?utf-8?B?NEVGWkVKTDd5Qmc2b0F3NHE5M25ad1VOQ2Yvc3pONnVaa2l2MkZUb2pEK0RD?=
 =?utf-8?B?ZHhsZXJZbkJOT05LK1Z2RTdpdHhQSGpWTG1Gc1lqUEcxY3I2UkZEVGpZWWtm?=
 =?utf-8?B?eHFyVXdBTURoaWJvUVBBUXZ5elVRZXdkQjJsZ1Q2K2JnYjBGZWxMU0svZkpS?=
 =?utf-8?B?K0diK3dKT3lJcnhDa2prNGgrL1BXVFdQRXM0SDdUcCtXVkp3WEVuRlNoK1p2?=
 =?utf-8?B?aDVVUlVCSzR4TTVmc3hlWmZPV3RxcjlZclBBZ0dzK0hub1N4Z0lhbzZGSHo2?=
 =?utf-8?B?VE5mVTJGRWxNc1FxRWV1Sm90VjhBWUlvRHdsVHJZTDUxTlRBc1l5bno2SUov?=
 =?utf-8?B?SC9HR1dSRFJvM01WdlV3SHh6OGFXelJ4bDVVNk9nc3o1aXh0V3BVNFdpWkFn?=
 =?utf-8?B?bmFFa1Rsa25EVnc0TkNlUndvVTY3ZWZLcEtFY1BweXNLYU5ZbmdkQm1nNFRz?=
 =?utf-8?B?VEd3YXE5STFKZmlORlNuNENFOTBjY3YyVU5LdCtQbm91ZjhaUmQwUlVaa0NV?=
 =?utf-8?B?cVhmSzJOOVNyM0Rnb3Z3SGpsUjRPcDFNaXBJMjlYZ3UwVnlTVFFGcm9VSHA3?=
 =?utf-8?B?YlBXQmRVeEtwY0JxZnhXNU1jbUN6M2dZZHM4MWtnU2FEK0hjQjREUVQzS2dC?=
 =?utf-8?B?ZFRKL25OenRhZ2ZvT2JQM0lIMEF2Y3lLYWwwRFN6Q3RPV2JzRlRJSE9BQ0hS?=
 =?utf-8?B?YTRtaTFWU0EzMzJpYmRwa1JyVkZoQnFUaVpOZU5sR0dwamJWazJYVGRxaUI4?=
 =?utf-8?B?SEhHQVl1UURVNW9PL0hCaTBjS1grRFdwRWN0V2t3SExGNFZybXAyVkFYTHhU?=
 =?utf-8?B?RS9JekJsLzNuZkVkYmhSOWoveWJVN2ZOcEUzQmVqUUNTZFR6dkJlVDVwa3Rw?=
 =?utf-8?B?REZxbEpjSWd2alQwV2FYUmJBbUU2NTVrM2syNEgwVysvSXcxckRPWXBrak5y?=
 =?utf-8?B?aGw1ZnNtOEdnV1VKS1JnTHZZdjlpWHFsNU1peDYvVWQ4YkZ6V0l5eStZanph?=
 =?utf-8?B?Wkd2WUJLckdXdnJ5cFRSaFM4eHE0QUJJUlY2d0s2eC9FMG9BKzlTaEJWNjky?=
 =?utf-8?B?dTF1eHBGUVJRNDRYc0xqZTBVcG91Z0lXUFoyNFVjQUM0QXVuNGMxQTVQZHgy?=
 =?utf-8?B?MjFLbzRmUXJRcGRwN2F4VHBzZGIzejRmWDZyZElua1M0R08rYjcrVm9XQ2VJ?=
 =?utf-8?B?N0VCazJWUlVyUmdVZnJmOUJDcCtYSWZDanB5anhoRWhHdzhWRFhIK2t2MGh4?=
 =?utf-8?B?TldvMXc0dVhrTHFWK3dHVVIyaTlxRDJMTDNmZzBtbGJaMmNzUXJRWU1qeEhZ?=
 =?utf-8?B?a3FUbE9oNG94S3RKTWlacFFDdzJnUEJtdytxY0k4NHhpNnlTREs4MzJ1cTYy?=
 =?utf-8?Q?ga/CiN1Np5SgnyYeWsWfTw2eH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950a5de3-ecc2-4fe9-dad1-08dc961d6876
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:20:23.1897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea7zEkqQ8FtO27B45zAOtuV2XFfved34TZo8ObOxsTWbH2ujjoeK7g06AXzlN1Vy1bifrlMX3NkfbMAvkp7B6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 6/26/24 2:31 PM, Marek Olšák wrote:
> There were multiple bugs, like checking SWIZZLE_MODE before checking
> GFX12_SWIZZLE_MODE, which has undefined behavior.
> 
> The function had no effect before (it always returned -EINVAL).
> 
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 45 +++++++++------------
>   1 file changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index ec0299c5918e..092ec11258cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -724,32 +724,25 @@ extract_render_dcc_offset(struct amdgpu_device *adev,
>   
>   static int convert_tiling_flags_to_modifier_gfx12(struct amdgpu_framebuffer *afb)
>   {
> -	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
> -	const struct drm_format_info *format_info;
>   	u64 modifier = 0;
> -	int tile = 0;
> -	int swizzle = 0;
> +	int swizzle_mode = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE);
>   
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
> -		tile = AMD_FMT_MOD_TILE_VER_GFX12;
> -		swizzle =  AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE);
> +	if (!swizzle_mode) {
> +		modifier = DRM_FORMAT_MOD_LINEAR;
> +	} else {
> +		int max_comp_block =
> +			AMDGPU_TILING_GET(afb->tiling_flags, GFX12_DCC_MAX_COMPRESSED_BLOCK);
> +
> +		modifier =
> +			AMD_FMT_MOD |
> +			AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
> +			AMD_FMT_MOD_SET(TILE, swizzle_mode) |
> +			AMD_FMT_MOD_SET(DCC, afb->gfx12_dcc) |
> +			AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_comp_block);
>   	}
>   
> -	modifier =
> -		AMD_FMT_MOD |
> -		AMD_FMT_MOD_SET(TILE, swizzle) |
> -		AMD_FMT_MOD_SET(TILE_VERSION,  tile) |
> -		AMD_FMT_MOD_SET(DCC, 0) |
> -		AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 0);
> -
> -	format_info = amdgpu_lookup_format_info(afb->base.format->format,
> -						modifier);
> -	if (!format_info)
> -		return -EINVAL;
> -
>   	afb->base.modifier = modifier;
>   	afb->base.flags |= DRM_MODE_FB_MODIFIERS;
> -
>   	return 0;
>   }
>   
> @@ -777,12 +770,6 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
>   		int pipes = ilog2(num_pipes);
>   		uint32_t dcc_offset = AMDGPU_TILING_GET(afb->tiling_flags, DCC_OFFSET_256B);
>   
> -
> -		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
> -			convert_tiling_flags_to_modifier_gfx12(afb);
> -			return 0;
> -		}
> -
>   		switch (swizzle >> 2) {
>   		case 0: /* 256B */
>   			block_size_bits = 8;
> @@ -1281,7 +1268,11 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
>   
>   	if (!dev->mode_config.fb_modifiers_not_supported &&
>   	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
> -		ret = convert_tiling_flags_to_modifier(rfb);
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0))
> +			ret = convert_tiling_flags_to_modifier_gfx12(rfb);
> +		else
> +			ret = convert_tiling_flags_to_modifier(rfb);
> +
>   		if (ret) {
>   			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
>   				    rfb->tiling_flags);

-- 
--

Thanks & Regards,
Aurabindo Pillai
