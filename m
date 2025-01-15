Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ABBC02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 14:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A7710E6CE;
	Wed, 15 Jan 2025 14:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXCZLYI6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3780B10E6CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 14:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4PW/4vcDohIuVMHtVxTCjeCQXcwMiR6I8hLHsTPuJKLooqSWcCgl15TPxXPBrJV32cBO0nEuoIrxPLA6b4S7J2BZbV8Z1FzJf0QFAn7fviNZ1FKrRnHA8rXr6Cytlhmbt/ppmLRezLQ4PK7RDG+vRJxSUKFbbPTgEaXrF4lPHXhLHYDfi6JeGj50B4r6jPVDNYc2GaprKIqTr9Jke0RGrzgJwJyiAJ7ZfdzaUpaj6/Ca1TnAacelPAEVxV9tdV7NJBPwG3z5EfGGmyrLrtEWg6+4MddWhlp7GZQldO9B7oko1GxgvloUP7X8lxIvWrHqG6ALQom5EP6Rnab+cFOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmOMb0yWHlkCR6f6j12Yn28xdDt+m2LGjZDO1oD93eM=;
 b=ZWWcznYQTr73dWNboD7BbyE5eMq2Bt+ohYHj6spza9WHsGf5jluViNpUI8EpxLDV45fdjnND02XcCRRZLOCJcp3voJY0EA1BNu+qQyP+2AZPwf/PRr4Rp2svJo0dsm6zPRbiyNJbrzPT7l8H11a67X1VdhezK8gbCxkwRiRJYD55Vm33B7tfofEm22SeVEOIW7HxiKRhzL7C5brrWmWNOB3vcWyC7Cnonfnuk83syPzJ9cGu+AIkDTRWGEwcm7vbTVZ9+K3aNIecCf7xKi+G960bAEfUMhcF6HkqeMcHFutFmTCezM5lGFZ/EeZ13bRDTZtvTzHU+YVvYB0aa7a+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmOMb0yWHlkCR6f6j12Yn28xdDt+m2LGjZDO1oD93eM=;
 b=mXCZLYI6Aaa1ocRwWrIOnwQwlVVrFLOPbyJr6ZvHQ9yVhaiK2X1wPAv6jBVt97uTeTYjaT6i0rJC3WXu2GYbKsuV1m1WNP7wBq0qt5eETcY3kuBfYfATnPvjCEF5pGl14BsgeFcLcELzQNfDcLvbuX1bLdsOOKClTXW0Db2Xthw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:04:24 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 14:04:24 +0000
Message-ID: <134805d3-d3f7-4c81-9be7-98d057078b9c@amd.com>
Date: Wed, 15 Jan 2025 19:34:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 V2] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset
 firmware version checks
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com, jiadong.zhu@amd.com
References: <20250115094821.3736827-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250115094821.3736827-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B3.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::5) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdc7b1e-a831-4d1e-b544-08dd356d83af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXZBOS9BdUxVRS9CL1F3TkVmUkxBWVg4aHMyK1JsczlvaWgydUhvYTJtYlRa?=
 =?utf-8?B?YmR3N3QrM3lKakdjR2xjeWFkWWJ1SVFXR3FCRFBqbnFibkdMZHExN01rMXVI?=
 =?utf-8?B?by91N2hrd3R4d0lDZDhUUVduQjBYblpCV1VuSzluT1pTTzh3M05qSFg2RWdU?=
 =?utf-8?B?cEc5VWYvWjZpMzE4RzlhRk9mcXhsRU9BVzlUNThEMS9NV3ZScitCdVdQblpD?=
 =?utf-8?B?c1ZqN0RhbzNIakdJSEtHTDZpaVBTNGtvT3NYdWhub1JSZjVGZUwwSFArczNx?=
 =?utf-8?B?aGNFWlpROHd0N3UwVmEyNUgwQmRydmVPQzZKbXNrMnlFaXlHWTJGRHQxR0hm?=
 =?utf-8?B?a21ka2Y4SlU5NjltUFRRTFdRcVBPNzA3LzF6dnBGVVpWWDhmaFNwcnFhb2pE?=
 =?utf-8?B?SVJwUlVyZ3hmRVYxWXNaSlFyeW9LaDVrOWhSNCtXR2NFL0VCWVJuaXp1bnd3?=
 =?utf-8?B?bGxmWnpIdVpOa2RJemJBNFpiQkNzRGN1NkRWNTF5SEtoNm1yMEdUaVUzUzlk?=
 =?utf-8?B?Rk9JWTZPdWdYY085RTY4d1ZRN0I0NEZUUWp4WnFxL1grUGtDV2hVbzkzNXB5?=
 =?utf-8?B?QytwVEV6aDZpZ2RHTExNTlRWMzZzZGpsY3ozNStnQmpDaFU3eTV0V2VHWXFL?=
 =?utf-8?B?dDVBcXk3dmVnUGF0c3NKQlYxeUxtWXVTcUtSbGx3ZUc4RzJkWC9qTElvVHd3?=
 =?utf-8?B?SkpaOXZtRVF6eHkxV1pTYU5EdDdmZmpDclU0QTAvNUJjZGhZM0tKSll1NG9r?=
 =?utf-8?B?M3VxRUVIaW5ybW4xV3FsdlN3aUNzdU51R05mTi9MV1g1N3E2R0VNNEFtUlpr?=
 =?utf-8?B?T0srVzVjNWdUMGFRa2V1OGVudVdYTVVkUmc3NGNoaGpUd3JiZjZBWUFpd29z?=
 =?utf-8?B?d21iODFrNDJIZ2VPdUlsWm9hZGFFb0dsL1oxNmcvQ3J0OG5vbnRnMGtzZzFv?=
 =?utf-8?B?MzRJeDRITWhNNitKWHpZTmNRNzRqVjhpVDByYWhSOUFreXhLNHpGaEpkS2J6?=
 =?utf-8?B?eHU0ZTc3ZGprYWNibFFiT293aUowOFF0c3FEd004Z0htZGlsT1Y0enN2TFlG?=
 =?utf-8?B?S3JSS3BNbVRza0l6SjZGay9pUWU3RkhWY3d1MlRJVks2aEVQTWtuQXh2T1JF?=
 =?utf-8?B?aVIvZkZiWHhadlc4ZDU4eFY5czV3aUg4ZW9PYThUejM3NDFVemxOQlpGN1ND?=
 =?utf-8?B?b2R3VDl6dmZKdDhRRXpCSlduMVhaZEw4U1IrSktkZlBWSzlpWkVQZnVqc3gy?=
 =?utf-8?B?WmpsTG8vMlVQWlR5TjJkNFZYdkhPK3VkSmlvcTNxUDRPSDNCWnJiS0ZuVWFp?=
 =?utf-8?B?TzQrZk5hdXpNWUxqM21ja01DU1BwNEVrVXgrbnlNSjdhNFBNL1BGRlFjT2JN?=
 =?utf-8?B?M05tSWh2ck5PL21tY1VwakZYQ2dmL2JMWTVTOWR3RkZvV1VIdjJpN1NlYXVT?=
 =?utf-8?B?Tko5bGl3Wm81MkVGQ2p0UmVxQmZtcC9ZdzUzcUlqRDVmTlJIUkp1Tks5Y2k3?=
 =?utf-8?B?d2lsMWVmMzg5NmF1Wjhad2tUenZld2N3M3RpOWpCNEpSc3dPWDFpRUhnTGh5?=
 =?utf-8?B?SUtrZVAvcUVsT2k5SHdzeHZwMEZUSHpwc0VXZ25rbGxUcS9VcHF3NS9DR1hp?=
 =?utf-8?B?cTZHYzNRa0JIV2RIRjJ6YVJtQWFhQnlzZWNKeW5TMWpzaWFKM2JGU2lmQk1H?=
 =?utf-8?B?M1RyTEdHdWhxSVNJWnM3SlY2dDhPOEdYTzQ5SmZYN0ZoQTh5emFnVkhOd0hj?=
 =?utf-8?B?TExDNndjdFZEZlpQZitIaUNVL2l1VzZ6dEw3cWhiK1cwQVVkV0lJWW5KS3Z5?=
 =?utf-8?B?RlZPY3l2dlBpbDNiRGcyanpWMTY4S1E2bFA2NWhQOVBUOGZWeW0xbU1NZzBo?=
 =?utf-8?Q?3l4hjUFOIk5f+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZmSVRXNzB4N1g2VGRieVpOTHQ1T2ozQTRTNmhmeHkxWXBES2svOWkzMzBv?=
 =?utf-8?B?aU5YZkptSnYxNkk5UkY1MldjMzhaUitzUlZ3NHZhN0pKUXowNERjbHhnQ0Ji?=
 =?utf-8?B?TXA5NmRHRGpkcnRObGc2RmR5UWtiTVFTUlE1bkZCbUtuckR1V3UrUEdpNGZE?=
 =?utf-8?B?dXdFSHVDY1I4ZUVPaEZTMVNLZy9rRDBxTDRtWVM4bnBmS2JkYTZmRDlUODBl?=
 =?utf-8?B?VmY4Qlk0a2lXeXltWXd5Mk9lbDNDOHBlazlVb1RzZTdLS2dHZUw4dGZ4bzNW?=
 =?utf-8?B?NElYM2E0ZGJLaVViNEJxN0pJVEJ4WHBXUXg4YUFvNWVqTUQ2S0tJNVE1OG4z?=
 =?utf-8?B?Yyt1b1g4VE5pMFFqOFJZQmJwQm00c1NHWi9LZWJTVkc0NmQ3T0ZGdjViV1VW?=
 =?utf-8?B?VS9ZbGhjL1RmREFwaHRiak41MFkxcmNySkRjZFlqMndzR25GU3M2RFF5THo5?=
 =?utf-8?B?YXBhVUszM3lLWjZVV01aayt3dWZCeXhTcERsTElQVThzdlpmelVMdGxRUFQ4?=
 =?utf-8?B?Y2xPR3JuYVQyV1VIRFo0UE04UEZ6YllCcCtuOEZZems1bXhURmVKdmp1cmlL?=
 =?utf-8?B?dmpkUFY1YW5URXRyY3ZMQ1Btci9JbFBsd3JPZXJ4RzNXWHMrRVpya1ZzbmZt?=
 =?utf-8?B?RDA4bjNSbHg1RS9RazBBZUFWcWdjRVdpSzEySllzSFlIUThUWWsxODdEbE15?=
 =?utf-8?B?SlY1Zkc5QjgrLzY0em5wbkFLZEpnNXprVmFLTy9RcndxOGhxWkVOdnIzUFlt?=
 =?utf-8?B?RVZRQzNXWmhSbi91b0ZKK3lNenJWcVhpUWlqNFozVEg2OHdXenlXVGpmUHBL?=
 =?utf-8?B?WEpHRmlIL0I1Z3pyNE1lZW5rV3g5M3dsbDdhd0lITXpUcVkwc1VoMTlhbkVt?=
 =?utf-8?B?TDdOM2Z6cHV1WkEzbGgwNW5kQ2dVMVg5RW9WSHk4WjN6NFl0cmhmbE16ZG9B?=
 =?utf-8?B?RWIrZHBuSVBZcjlrWnpHd3dhTWkwYWszZFhLZmpXcXhPV1BXeDNRV24zWGo2?=
 =?utf-8?B?K2x3M2hHcXFrZko4Z0pyYlVJMGR4NmppeEg5N0h4a3ZvQTBNbmthdDFzVGpU?=
 =?utf-8?B?dklRRkRMOE9WUUcwbGMyYUVPMzlkU3RiaFN5ZHRWb21FZE9IVFZkMjFPN2gw?=
 =?utf-8?B?OUN5bHVCcjF2bVdmVWRUVWdaOE5ieDB5ZnZzcGRkdmdNdW5ncEo0NCtsYk1O?=
 =?utf-8?B?SSs3Qk4rdTdMejkvMTkwNk1jU2E5YkZVS2JKSTJqbmZBME91RnovQll0ODlF?=
 =?utf-8?B?QzBQYkpsa0Rrajcrem80WG9YZGQ0MVJSWlZmQ1dPQzAvL3BKa3FIbHZhT1lC?=
 =?utf-8?B?RGdjYWUrMUl5dDdQWEVEalUxOVgxNFlFRkRlNE1aMEE3UXd5Z05NS1ZJS1ZY?=
 =?utf-8?B?aUQrWXhxTE4zR0tYdVYrbHVYcHpTUDdSOHJURXZOclk1NXBPVHQ2ZzQrSVlh?=
 =?utf-8?B?cnMvUkFoMUdEZi9MUmM3T2RLdWtZczNUZHdsQTdURUdQYi9OZ3JVT0EwRGVp?=
 =?utf-8?B?eGhXNW1nYXQwNjhBZlRpOFlVQm5lQWN5WVMvcWF1Q0NvcitPZ3R5NVpXL2Ft?=
 =?utf-8?B?d1UwVTZwSUhaMTB6YVlwVG45eGRkYjJmaHNxVnhRTDBNWW52Vk9lK3ZHclNx?=
 =?utf-8?B?ZDBuN3k1eGl4Uko0S0RHTXBxK091clpFUHliNmtETWN5ajBETEsrdVdZOHRo?=
 =?utf-8?B?L3A1S0FFV3o5ZmVmRGdJWFgxSW9jcVY4NFVZd1ZZQ0sxYWJ2WlRKRHRZZUNq?=
 =?utf-8?B?Z2JvVlk0cWYxclNZdnJNVmlrcEs4Q2JQQzZMdnhFWG51QjN1cDN4MFA4NTVU?=
 =?utf-8?B?T0ZYVUpOd0h3MTdKWXQzYmgyQXN5NnRBYzczSWRUOFg0MTFNdm5xcTlOUFFo?=
 =?utf-8?B?K3U4SmxYRTM0ZEdIYmRZVUJaOFRIZDBkY3NCYVBqK3JNUGtUKzcxcm5GTXZx?=
 =?utf-8?B?VG84dUR6eGtOMzZ2NUg0cjJJSXhYWTlEcXhUMFVGZkpmV1gzSkFPUFJVaVd5?=
 =?utf-8?B?UXVtdjlwbSsvcFZ4R1V2dWdWRCtWc2JyNzVPSklOZzJVc1lvVjZkZStaQ1d3?=
 =?utf-8?B?ZnJ4cHNBTDAwSzlQNmpzSVRMQncrZXdCWVozbEx2ZWluakpPczBPZEppSnJq?=
 =?utf-8?Q?E64nqNOI0YySAn+e0N0qpf+xX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdc7b1e-a831-4d1e-b544-08dd356d83af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:04:24.3625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiWngEqF6cGDLZ3GxvEUY308nrQ28aVx7asoXfM508+ggJK0Y1rZPsCcw0LzS04w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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



On 1/15/2025 3:18 PM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma`
> to support multiple SMU programs with different firmware version thresholds.
> 
> V2: return -EOPNOTSUPP for unspported pmfw
> 
> Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 650aa9d0548a..f68282238303 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2745,12 +2745,23 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>  {
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
> -
> -	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
> -	if ((adev->flags & AMD_IS_APU) ||
> -	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
> -	    smu->smc_fw_version < 0x00557900)
> -		return 0;
> +	uint32_t smu_program;
> +
> +	smu_program = (smu->smc_fw_version >> 24) & 0xff;
> +	/* the message is only valid on SMU 13.0.6 with these pmfw and above */
> +	if (amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
> +		((smu_program == 0) && (smu->smc_fw_version < 0x00557900)) ||
> +		((smu_program == 4) && (smu->smc_fw_version < 0x4557000)) ||
> +		((smu_program == 5) && (smu->smc_fw_version < 0x5551200)) ||

Missed to check this last time -

Note that this won't work as this FW version is not used with IP version
13.0.6.

It will return always return unsupported for program 5 because of this
check - amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6)

Thanks,
Lijo

> +		((smu_program == 7) && (smu->smc_fw_version < 0x7550700))) {
> +		dev_err(smu->adev->dev,
> +		"ResetSDMA not supported: SMU program %u requires PMFW >= 0x%x\n"
> +		"Current PMFW version: 0x%x\n",smu_program,
> +		smu_program == 0 ? 0x00557900 : smu_program == 4 ? 0x4557000 :
> +		smu_program == 5 ? 0x5551200 : smu_program == 7 ? 0x7550700 : 0,
> +		smu->smc_fw_version);
> +		return -EOPNOTSUPP;
> +	}
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					      SMU_MSG_ResetSDMA, inst_mask, NULL);

