Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C39BC0218B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 01:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217D810E246;
	Fri, 24 Jan 2025 01:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YgxRpF0m";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE7210E1C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 01:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxUHIp7hVpn8vlilJneQH+yjIfqJoy5NrSx9ISQFKBOnmniooTL3AsPNqhfrdHJFA4floME1Hs/qekyxuV3thf1QGYP+HKx4tPVKSE4fCrCj4tuNJaf7909NBZ29fjXDr/AgaEe0oSiMHBMHW7ZOJeAH8MmATBuYSmQ5zTYMmbcZlIu9GRimJlnN49OTx4uXaBF5G8Da6GKO+BOyqbgD1q5qy9jk72mq4YHwjBfs+tKcnlbxRUTcmw6CjzZPxn4K6wuV9dpFMqjeHHtuI3u4WIimAbrsIfnP40MnJCS9ZCvnuwYkvalBqOR/BngMFuToUwXXsYfDNFSci3xImd4MUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TCrXpuv7pvy9XKYxdngAxDXpOyM5RVgoizi5zD6mZo=;
 b=ksDVoNMx0wlCZ+PHXMO8O6PshPrhg6lw1FVVD1FMavdg3VQcHbtvkl/5FMYn70DiynzFlyEIIkaWrWJ5gPzzp3fMySaLpfYE0kr73vMLMTuyNle8aMKvV9dAnowPBqxlSWq6FhqCo+T8b03+11H49+6aUmj2Bq3fm4RJkLn1B69WlO5bGZtL38RNTiRcK3JAZAkR1HYyHy0zJFv0PV9UJ3OhcSkVcxi0LyXADNVpmmGeXdRhnwgD718K6/CaPsulPn4ynQXlHm4n88UBOPjRxC/deFF+CICO+B7eRRh+rjY/1TA3o+7zdP4RO10BAQE6MRXPaR3zYrdIqhZ3dW0n8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TCrXpuv7pvy9XKYxdngAxDXpOyM5RVgoizi5zD6mZo=;
 b=YgxRpF0mEoWV+mF/JRctRUHJr2PTaJBsN8XYla+PZYn0d1ADo1MlcZHnnNnRDHjwfW5nA++wcXVXluGOvtJU8lGhvN4JVGCHpEcIUB9Nnwy8mqj1FRjiDHt5e3LXJvP1P/usSfaJyPWJ1NueAie89FDWbVWmci04vunZvQ3azOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 01:21:49 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 01:21:49 +0000
Content-Type: multipart/alternative;
 boundary="------------djw0EU8lnAegYfv5OF3CNHpo"
Message-ID: <26fd920f-9245-444f-a708-5820be232df7@amd.com>
Date: Fri, 24 Jan 2025 09:21:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: update and cleanup PM4 headers
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Saurabh Verma <saurabh.verma@amd.com>
References: <20250120194017.201218-1-alexander.deucher@amd.com>
From: "Xu, Feifei" <feifxu@amd.com>
In-Reply-To: <20250120194017.201218-1-alexander.deucher@amd.com>
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To CH2PR12MB4152.namprd12.prod.outlook.com
 (2603:10b6:610:a7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4152:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4c2a0f-5fb0-4814-0414-08dd3c157956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXg4QXFmakFDTGtFQk5LdnA1RGF5ZEJ5TDJTNVRLaXZuSlphOE9Xb2E3TGlk?=
 =?utf-8?B?N1ROcmtXa2FJRGlMMThxTzhqYlJLRG1oU2g0cDBtL2J4bUxlZkorQkcvNG1u?=
 =?utf-8?B?M1hnZGltSy9TYlN4T2FtczByNmtBZGZlWEhDRXFvTE0vSnVCOXBqQnczZko5?=
 =?utf-8?B?QWY2MGR2cnhqdUtSSmFLUGY5TjlxSDVySDZWdzdVV2hBZWk1a0FIQ3dJMkUz?=
 =?utf-8?B?ZStaNE11a3oxTk1XNWUwK1doYy9QcW9ibFdRWGtlSWtjUzZwZEIwRG9sd1hP?=
 =?utf-8?B?bzdHM2MzMTVGYXJMeTBFbkFQNG0vdTRaaWM1dFFscnFIbzFyVmVNaXFnYVQy?=
 =?utf-8?B?VEg0OVRYS3AzZHNGcUoyMDYwMU9yS2w5dnphTTcwRk92M2hiLzdOTHNUOUtr?=
 =?utf-8?B?d1hpUmFmMVlrOEpHd1NWZHR4OG0yVXpNOEdKOHFzMlZEUkpzSHkrcDFXNWhB?=
 =?utf-8?B?aGhaUzJBVGUyM0d0UWsxa0hxOXJyWDdYMTNYdEFIdVl0QSt0cXMxNlUvVG5r?=
 =?utf-8?B?clhPY0xUdjFFRHZvcmhxWXBrTHZjdXdRam9BdGpmbUpyQUJmeTVRQW1BYmJU?=
 =?utf-8?B?dzdrOHVmRmx6eEt5UmY1U2N0WFNaNG83R2FrK1V1U2NrbGl6UUdDcE1IeC9u?=
 =?utf-8?B?MEtuMnJOVm1kZ3k2SzBwcWJwelJGWWZrazJ1VUl4T0NBREhzTVJMMUJYNnJW?=
 =?utf-8?B?d21mdVJQWldFSlFtRkQycjVHQlhOQzkrZ1VoWFprbVZpSmJjRXdPTFNKVDl1?=
 =?utf-8?B?YmhBdGVrU0ZpQjNFdGhOd3I3TzNzNnpaWWk5NDNNcGUvOFdqSDNFUTZkaUhB?=
 =?utf-8?B?emhTR0dWUTQrcG42Y3Y1WHVqT1c0TkR4TXNSRVhPNFlJa052TE9zdnN2OTRn?=
 =?utf-8?B?RFByTjY1dGpsVW11NE1OamNrdnVQbHhDcnJLT2RteTVOWWVnVUFhWkxMM0Ns?=
 =?utf-8?B?bmFJSUJ6bkM4RmN3aG41WXdJSkJ4SGRmN215MnZGT0RQNzY5YUwvcC9zbjhL?=
 =?utf-8?B?NFBUaWV0cm5RYXI4QVVGUWw5Wnp0SHJrUjIxZGNnTjlRaDZqWDJXblM5NVZs?=
 =?utf-8?B?aGVMK1BaNzNhcFJiQXF1US9FL1dKcmIyL1FjV3I2YnI2ci9iazhIRVgvdmJ1?=
 =?utf-8?B?eDBCMWgrME9QKzZCTGl0WmVWcVpSTzR3VGVyZUU4YnBaaFFKaDN0NTdaQ2l2?=
 =?utf-8?B?MlFaazkzemdwVzBuQ29kWXBoMS8yb0EzQ3QxNnBrTGJTYmZYQlJCcEJnWnZ3?=
 =?utf-8?B?WmU2QTg1UWFGYVNPcmV5cWRicmtaUHRlNThyNGFHa1piSWJ0SmdCYWJiSldj?=
 =?utf-8?B?VWJBc1lUdHlONXMxUzRORkdpd3lrY0hLSkNOMWFjTFFBc05iTmFmS2dYdUxB?=
 =?utf-8?B?dm1hRE13MFp3eHN0cW9JbDZIcUx5bkFmamR0ZmVEanUxNnFzVm9qMEdLb04z?=
 =?utf-8?B?aWJWT2hHaUxPaEtTMzhqaFNpU2wzUndoWThhQXIveTdjSFhvSEVMaFY2czRj?=
 =?utf-8?B?RVE3MjJDZEJ2Tjh0aTlpeUtvL2NCeHQ3aEZPT2x5d09CVisvTThKbjJMVlBP?=
 =?utf-8?B?VVZRbGhuMzNFdTMrSUpVOSt2T3dtV1U2dlc0VURkWWR5R1FMQ1A1SHU5R0J6?=
 =?utf-8?B?NDNZSSt6SlliUUhxS1lDck5peVdDQWJqeGtyVWlkNzV0Qzl1V1RKa1J2R2FB?=
 =?utf-8?B?aEZWYXZNQ0F6MDY1SFB1NlBQcEVoYUJsU1pDMnFRRjRJMnZEYXkxZ295Wjh1?=
 =?utf-8?B?Mmh4VkJqYVM0NkpkU3VidEFxb1ArUzZ2dHN2VDlGWEppN21sZ3hkTlA0T0E0?=
 =?utf-8?B?MDB3SDd5U1ZqcGxvSVNCZVlVMWc5SklJNjZqQTI2bXdVUmlkVXJFYmwwTHhK?=
 =?utf-8?Q?6FpFgPeYBILOH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJsUVVOam53SGVXU0xVeU00VUNxRjBRaVIvUFRoRDI3RTEzVUZLVUY1bFNL?=
 =?utf-8?B?THE5Q2o1bC9tc2FSc0hmNDNJNWFGd3IrTW9wdTdrb2dlM2tCbzJRZ250MURy?=
 =?utf-8?B?MnB4MTRYM1g3RC96MGNVSUFKTGNmek1Kc016RGh3NmI1YnpKZ0x3QmF5YVMw?=
 =?utf-8?B?Lzg2SmNkZytqZnhLVS9lc3BOSHVpVXhOL1BjQzdsZTZ2VlJVcEtjNDdaMkF1?=
 =?utf-8?B?OEYxWUY4MkZYeVdZTmluaHM5dmV1SXM0R2RmTUVvUEU1UEt4akQ0V3lTV1hr?=
 =?utf-8?B?UFFwYWVYbC9MMkxJNXpOMGpIeU91T205RW8zQTVOcWhTdVJHbk9tQUtsQzNB?=
 =?utf-8?B?RUlHbk15TmI1dWVhYTdQc0JFd2xsM0tDcDk2MDZXS3U2QlppdUZaOGNidHQv?=
 =?utf-8?B?bzVlTkFBRFZtRVU5Zkl5bUJFTmxKc3pPTmdWUzJadG12bkNjNzdMZW82SXVK?=
 =?utf-8?B?TTcvSFFwNXNjT05kRmlIWlVCSjdlY1lJT3NPek81bFJGSUxLa0pVMGs0MU44?=
 =?utf-8?B?aWRpZ05qd3FZeGpoREFnMzRaVnB1SFo5NHhPUlRVamE5a3NRU1FSUkdjcmdt?=
 =?utf-8?B?L1hXSGFLYmlLSUx3UVlacnd3cDNLR0NYRXE2TGhGck1Mcm1Hckp6Y2lhWlhH?=
 =?utf-8?B?YmkvcUpsYURSeVZGY25WOTRkRC9xbXBiU252NVAvdzRJSi9TcXIxMkluZFFs?=
 =?utf-8?B?UG1iL21rZlRPWm8rcWgyTzFJT2ZLNFUxQ2c5Zk9FaUVKUlRzNmxNR3NuZU1y?=
 =?utf-8?B?cnRxNng4SE9nczMzTkpVemJnNU9TcmlENGFiZnVrd3djMmczTzYwb2R6R0VI?=
 =?utf-8?B?K1c1Z0tFUldKTmRlVFJjME9KSkRWcGkxYy9Gb21KMEtBWTlVNlFGM2ZNblZE?=
 =?utf-8?B?bmk5VmNzZWRvbHQvdUdiWVNLMWdXWHE1TnNHZC9IaWJTTFd4NWVFTHQxR0dG?=
 =?utf-8?B?UUJscmdaT3RUd1RVL3pSRXNZN2ZxTERmeG56VFRUNXA5dklyY0ZMU1V6cTZC?=
 =?utf-8?B?OFdjbThnQTVQRUlYamNXMkZ0eXpIeExPYTFBRnZyQzFSeE5lRWQxbXlsS2cz?=
 =?utf-8?B?SlErR2hYSUlhK1JWR210d0sxdkYyYUJlZ3JJT2xDdWlMbThIZnUzVE9mYmhT?=
 =?utf-8?B?WERmcGhydXRWWlYrQzZ4NWF4VTJiWk5WM1dLVjB0Mjg3QVpncTErUmJyNHVx?=
 =?utf-8?B?ek9xb0JSY2pTbyttK0dMUVFjNHhjR01aa05xNlhPTEhHcXplYlU0cytQTU5G?=
 =?utf-8?B?SitRb0Z2Z2EwdTVMQ29SQ0wxOFRpM2E3dHNxTDRuVTFOZXJDcXgvS0ZDRFNV?=
 =?utf-8?B?Y1Y1NmVXY2IwZU1hcStzcFlNVVFHWWZLTU9QeDd0MW1hNk5vOVFJT2pNdzlw?=
 =?utf-8?B?T2dzYThnbGVQRFJXNjVuMVNqdFFmb01aSGN3WEVBM09sRlhWZHpkcll2V3Ny?=
 =?utf-8?B?VjUzUUYwQ0RkSC9QZkN6TkJQVndXWHplcVppQVo1T056UFp2NFZhdEY1YlVP?=
 =?utf-8?B?WGIvMEYvZUorVWxHdjFpeTI1MnBVVzQyOUxBQ0FLTlhic09TSHRDemZBL29O?=
 =?utf-8?B?UVpUeTl2SnkzamZUTU53MFNGajlxbXFaTGRkZ2tUY1lpMTUzbjJaK0ZNWnJx?=
 =?utf-8?B?c0FOZTJPay9aUXRXeG1BbnpoU1k0QmdXNHVUaUExdWJFSTBUTHNrMjlna092?=
 =?utf-8?B?NitqdWp2alFJRzFVVDdrZUpzT3dYM3hjU2pLa0tMUnk1eW5HejBKSHF3Mk5o?=
 =?utf-8?B?Z0RaN2J1MDdoRWJBS2hzQXJOcGVkSmZYNWRibzNnSUYwNVEvUG92bDcvbU1E?=
 =?utf-8?B?UWxzYWpYZFVzcEgvQ3BRRHdWMFRpYmZGdy85S3c3RHpmYmxuYlBaMEVpeVVQ?=
 =?utf-8?B?TWJWV21zMUFxL3U2dlgzL3BJUFR5UVF0WjRDN1JzOFpXWVVqTk9kNU1wRVJ5?=
 =?utf-8?B?Sm9YaVNNeWxvR0JWenY2U25BWG1kUzZvUlAvR01NakRnaG5RN2lCWUFFS3Vn?=
 =?utf-8?B?NHhuakVIclhuNEJoakNNeER3VXZxWm5GNEE4SlRFVXp1bzNXc3pJZ2pXdWM2?=
 =?utf-8?B?YWMyNUVxa2p6SXY5RVNaUmluaVlGR0hXbW10eEVLa1ZHNWF4ZFpLdC9mZWgw?=
 =?utf-8?Q?CdmqSaoHaIcYqgr05GF5oZCAY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4c2a0f-5fb0-4814-0414-08dd3c157956
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 01:21:49.0017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwB4qd+/FSUQnQVkP31VOUvIE7l7pU57Rffw85dhXUwqpUJOs7Qicm6P+EK+xI+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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

--------------djw0EU8lnAegYfv5OF3CNHpo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

On 1/21/2025 3:40 AM, Alex Deucher wrote:
> Consolidate PM4 definitions.  Most of these were previously
> only defined in UMDs.  Add them here as well and sync with
> latest packets.  Also no need to include soc15d.h on gfx10+.
>
> Suggested-by: Saurabh Verma<saurabh.verma@amd.com>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   1 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |   1 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |   1 -
>   drivers/gpu/drm/amd/amdgpu/nvd.h       | 208 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/soc15d.h    | 139 +++++++++++++++++
>   5 files changed, 347 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 070b4d6bd9c59..63de78060d679 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -40,7 +40,6 @@
>   #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
>   
>   #include "soc15.h"
> -#include "soc15d.h"
>   #include "soc15_common.h"
>   #include "clearstate_gfx10.h"
>   #include "v10_structs.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 52c571b134fd0..89d17750af04d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -42,7 +42,6 @@
>   #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
>   
>   #include "soc15.h"
> -#include "soc15d.h"
>   #include "clearstate_gfx11.h"
>   #include "v11_structs.h"
>   #include "gfx_v11_0.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 2a71998800414..e425b87078d7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -40,7 +40,6 @@
>   #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
>   
>   #include "soc15.h"
> -#include "soc15d.h"
>   #include "clearstate_gfx12.h"
>   #include "v12_structs.h"
>   #include "gfx_v12_0.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
> index 631dafb922990..56f1bfac0b208 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> @@ -64,6 +64,24 @@
>   #define	PACKET3_INDIRECT_BUFFER_CNST_END		0x19
>   #define	PACKET3_ATOMIC_GDS				0x1D
>   #define	PACKET3_ATOMIC_MEM				0x1E
> +#define 	PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) & 0x7F) << 0)
> +#define 	PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define 	PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)))
> +#define 	PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)))
> +#define 	PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)))
> +#define 	PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)))
> +#define 	PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)))
> +#define 	PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)))
> +#define 	PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) & 0x1FFF) << 0)
> +#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC 0
> +#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
> +#define 	PACKET3_ATOMIC_MEM__COMMAND__WAIT_FOR_WRITE_CONFIRMATION 2
> +#define 	PACKET3_ATOMIC_MEM__COMMAND__SEND_AND_CONTINUE 3
> +#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__LRU 0
> +#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__STREAM 1
> +#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__NOA 2
> +#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__BYPASS 3
>   #define	PACKET3_OCCLUSION_QUERY				0x1F
>   #define	PACKET3_SET_PREDICATION				0x20
>   #define	PACKET3_REG_RMW					0x21
> @@ -105,6 +123,38 @@
>   		 * 1 - pfp
>   		 * 2 - ce
>   		 */
> +#define 	PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define 	PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) & 0x1) << 16)
> +#define 	PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
> +#define 	PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define 	PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
> +#define 	PACKET3_WRITE_DATA__MODE(x) ((((unsigned)(x)) & 0x1) << 21)
> +#define 	PACKET3_WRITE_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) << 22)
> +#define 	PACKET3_WRITE_DATA__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 24)
> +#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_LO(x) ((unsigned)(x))
> +#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
> +#define 	PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
> +#define 	PACKET3_WRITE_DATA__DST_SEL__TC_L2 2
> +#define 	PACKET3_WRITE_DATA__DST_SEL__GDS 3
> +#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY 5
> +#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE 6
> +#define 	PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS 0
> +#define 	PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS 1
> +#define 	PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION 0
> +#define 	PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION 1
> +#define 	PACKET3_WRITE_DATA__MODE__PF_VF_DISABLED 0
> +#define 	PACKET3_WRITE_DATA__MODE__PF_VF_ENABLED 1
> +#define 	PACKET3_WRITE_DATA__TEMPORAL__RT 0
> +#define 	PACKET3_WRITE_DATA__TEMPORAL__NT 1
> +#define 	PACKET3_WRITE_DATA__TEMPORAL__HT 2
> +#define 	PACKET3_WRITE_DATA__TEMPORAL__LU 3
> +#define 	PACKET3_WRITE_DATA__CACHE_POLICY__LRU 0
> +#define 	PACKET3_WRITE_DATA__CACHE_POLICY__STREAM 1
> +#define 	PACKET3_WRITE_DATA__CACHE_POLICY__NOA 2
> +#define 	PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS 3
>   #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
>   #define	PACKET3_MEM_SEMAPHORE				0x39
>   #              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
> @@ -135,6 +185,42 @@
>   		/* 0 - me
>   		 * 1 - pfp
>   		 */
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) & 0x7) << 0)
> +#define		PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) & 0x3) << 4)
> +#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) & 0x3) << 6)
> +#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) & 0x3) << 22)
> +#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) & 0x1) << 24)
> +#define		PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define		PACKET3_WAIT_REG_MEM__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsigned)(x)) & 0X3FFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) & 0X3FFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
> +#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
> +#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
> +#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) & 0x1) << 31)
> +#define 	PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS 0
> +#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE 1
> +#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE 2
> +#define 	PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE 3
> +#define 	PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE 4
> +#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE 5
> +#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE 6
> +#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE 0
> +#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE 1
> +#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM 0
> +#define 	PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG 1
> +#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE 3
> +#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__LRU 0
> +#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__STREAM 1
> +#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__NOA 2
> +#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__BYPASS 3
> +#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__RT 0
> +#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__NT 1
> +#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__HT 2
> +#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__LU 3
>   #define	PACKET3_INDIRECT_BUFFER				0x3F
>   #define		INDIRECT_BUFFER_VALID                   (1 << 23)
>   #define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) << 28)
> @@ -144,8 +230,94 @@
>   		 */
>   #define		INDIRECT_BUFFER_PRE_ENB(x)		((x) << 21)
>   #define		INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
> +#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
> +#define 	PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) & 0xFFFFF) << 0)
> +#define 	PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) & 0x1) << 20)
> +#define 	PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) & 0x1) << 21)
> +#define 	PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) & 0x1) << 23)
> +#define 	PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) & 0xF) << 24)
> +#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 28)
> +#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 28)
> +#define 	PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) & 0x1) << 31)
> +#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__RT 0
> +#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__NT 1
> +#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__HT 2
> +#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__LU 3
> +#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU 0
> +#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM 1
> +#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__NOA 2
> +#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__BYPASS 3
>   #define	PACKET3_COND_INDIRECT_BUFFER			0x3F
>   #define	PACKET3_COPY_DATA				0x40
> +#define 	PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) & 0xF) << 0)
> +#define 	PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 13)
> +#define 	PACKET3_COPY_DATA__SRC_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 13)
> +#define 	PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) & 0x1) << 16)
> +#define 	PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
> +#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) & 0x1) << 29)
> +#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define 	PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define 	PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
> +#define 	PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define 	PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
> +#define 	PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
> +#define 	PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
> +#define 	PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define 	PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define 	PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
> +#define 	PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define 	PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
> +#define 	PACKET3_COPY_DATA__MODE(x) ((((unsigned)(x)) & 0x1) << 21)
> +#define 	PACKET3_COPY_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) << 23)
> +#define 	PACKET3_COPY_DATA__DST_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_LO(x) ((unsigned)(x))
> +#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
> +#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_LO(x) ((unsigned)(x))
> +#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
> +#define 	PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER 0
> +#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2_OBSOLETE 1
> +#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2 2
> +#define 	PACKET3_COPY_DATA__SRC_SEL__GDS 3
> +#define 	PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS 4
> +#define 	PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA 5
> +#define 	PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA 6
> +#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0 7
> +#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1 8
> +#define 	PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT 9
> +#define 	PACKET3_COPY_DATA__SRC_SEL__SYSTEM_CLOCK_COUNT 10
> +#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
> +#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2 2
> +#define 	PACKET3_COPY_DATA__DST_SEL__GDS 3
> +#define 	PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS 4
> +#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2_OBSOLETE 5
> +#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC 6
> +#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__RT 0
> +#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__NT 1
> +#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__HT 2
> +#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__LU 3
> +#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU 0
> +#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
> +#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__NOA 2
> +#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__BYPASS 3
> +#define 	PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA 0
> +#define 	PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA 1
> +#define 	PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION 0
> +#define 	PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION 1
> +#define 	PACKET3_COPY_DATA__MODE__PF_VF_DISABLED 0
> +#define 	PACKET3_COPY_DATA__MODE__PF_VF_ENABLED 1
> +#define 	PACKET3_COPY_DATA__DST_TEMPORAL__RT 0
> +#define 	PACKET3_COPY_DATA__DST_TEMPORAL__NT 1
> +#define 	PACKET3_COPY_DATA__DST_TEMPORAL__HT 2
> +#define 	PACKET3_COPY_DATA__DST_TEMPORAL__LU 3
> +#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU 0
> +#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM 1
> +#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__NOA 2
> +#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__BYPASS 3
> +#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT 0
> +#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE 1
>   #define	PACKET3_CP_DMA					0x41
>   #define	PACKET3_PFP_SYNC_ME				0x42
>   #define	PACKET3_SURFACE_SYNC				0x43
> @@ -160,6 +332,23 @@
>   		 * 3 - SAMPLE_STREAMOUTSTAT*
>   		 * 4 - *S_PARTIAL_FLUSH
>   		 */
> +#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) & 0x3F) << 0)
> +#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define		PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) ((((unsigned)(x)) & 0x3) << 29)
> +#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) & 0x1) << 0)
> +#define 	PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
> +#define 	PACKET3_EVENT_WRITE__ADDRESS_HI(x) ((unsigned)(x))
> +#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
> +#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTAT 2
> +#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH 4
> +#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS 8
> +#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS1 9
> +#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS2 10
> +#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS3 11
> +#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__LEGACY_MODE 0
> +#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE1 1
> +#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__NEW_MODE 2
> +#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE3 3
>   #define	PACKET3_EVENT_WRITE_EOP				0x47
>   #define	PACKET3_EVENT_WRITE_EOS				0x48
>   #define	PACKET3_RELEASE_MEM				0x49
> @@ -304,6 +493,12 @@
>   		 * 2: REVERSE
>   		 */
>   #define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
> +#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
> +#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
> +#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
> +#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
> +#define 	PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x7FFFF) << 0)
>   #define	PACKET3_REWIND					0x59
>   #define	PACKET3_INTERRUPT				0x5A
>   #define	PACKET3_GEN_PDEPTE				0x5B
> @@ -330,11 +525,17 @@
>   #define	PACKET3_SET_SH_REG				0x76
>   #define		PACKET3_SET_SH_REG_START			0x00002c00
>   #define		PACKET3_SET_SH_REG_END				0x00003000
> +#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0x1F) << 23)
> +#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) << 28)
> +#define 	PACKET3_SET_SH_REG__INDEX__DEFAULT 0
> +#define 	PACKET3_SET_SH_REG__INDEX__INSERT_VMID 1
>   #define	PACKET3_SET_SH_REG_OFFSET			0x77
>   #define	PACKET3_SET_QUEUE_REG				0x78
>   #define	PACKET3_SET_UCONFIG_REG				0x79
>   #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
>   #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
> +#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
>   #define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
>   #define	PACKET3_FORWARD_HEADER				0x7C
>   #define	PACKET3_SCRATCH_RAM_WRITE			0x7D
> @@ -369,6 +570,7 @@
>   #              define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0)
>   #              define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4)
>   #              define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
> +#              define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) << 29)
>   #define	PACKET3_AQL_PACKET				0x99
>   #define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
>   #define	PACKET3_SET_SH_REG_INDEX			0x9B
> @@ -462,6 +664,12 @@
>   #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
>   #define	PACKET3_RUN_LIST				0xA5
>   #define	PACKET3_MAP_PROCESS_VM				0xA6
> +
> +#define PACKET3_RUN_CLEANER_SHADER                      0xD2
> +/* 1. header
> + * 2. RESERVED [31:0]
> + */
> +
>   /* GFX11 */
>   #define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
>   #              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index b9cbeb389edc1..a5000c171c02c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -93,11 +93,25 @@
>   #define	PACKET3_DISPATCH_INDIRECT			0x16
>   #define	PACKET3_ATOMIC_GDS				0x1D
>   #define	PACKET3_ATOMIC_MEM				0x1E
> +#define		PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) & 0x3F) << 0)
> +#define		PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define		PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define		PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)) << 0)
> +#define		PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)) << 0)
> +#define		PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)) << 0)
> +#define		PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)) << 0)
> +#define		PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)) << 0)
> +#define		PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)) << 0)
> +#define		PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) & 0x1FFF) << 0)
> +#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC	0
> +#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
>   #define	PACKET3_OCCLUSION_QUERY				0x1F
>   #define	PACKET3_SET_PREDICATION				0x20
>   #define	PACKET3_REG_RMW					0x21
>   #define	PACKET3_COND_EXEC				0x22
>   #define	PACKET3_PRED_EXEC				0x23
> +#define		PACKET3_PRED_EXEC__EXEC_COUNT(x)	((((unsigned)(x)) & 0x3FFF) << 0)
> +#define		PACKET3_PRED_EXEC__VIRTUAL_XCC_ID_SELECT(x)	((((unsigned)(x)) & 0xFF) << 24)
>   #define	PACKET3_DRAW_INDIRECT				0x24
>   #define	PACKET3_DRAW_INDEX_INDIRECT			0x25
>   #define	PACKET3_INDEX_BASE				0x26
> @@ -132,6 +146,28 @@
>   		 * 1 - pfp
>   		 * 2 - ce
>   		 */
> +#define		PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define		PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) & 0x1) << 16)
> +#define		PACKET3_WRITE_DATA__RESUME_VF_MI300(x) ((((unsigned)(x)) & 0x1) << 19)
> +#define		PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
> +#define		PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define		PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define		PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define		PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define		PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
> +#define		PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER	0
> +#define		PACKET3_WRITE_DATA__DST_SEL__TC_L2	2
> +#define		PACKET3_WRITE_DATA__DST_SEL__GDS	3
> +#define		PACKET3_WRITE_DATA__DST_SEL__MEMORY	5
> +#define		PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE	6
> +#define		PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS	0
> +#define		PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS	1
> +#define		PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION	0
> +#define		PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION	1
> +#define		PACKET3_WRITE_DATA__CACHE_POLICY__LRU	0
> +#define		PACKET3_WRITE_DATA__CACHE_POLICY__STREAM	1
> +#define		PACKET3_WRITE_DATA__CACHE_POLICY__NOA	2
> +#define		PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS	3
>   #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
>   #define	PACKET3_MEM_SEMAPHORE				0x39
>   #              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
> @@ -160,6 +196,33 @@
>   		/* 0 - me
>   		 * 1 - pfp
>   		 */
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) & 0x7) << 0)
> +#define		PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) & 0x3) << 4)
> +#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) & 0x3) << 6)
> +#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) & 0x3) << 22)
> +#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) & 0x1) << 24)
> +#define		PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
> +#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
> +#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
> +#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) & 0x1) << 31)
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS	0
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE	1
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE	2
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE	3
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE	4
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE	5
> +#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE	6
> +#define		PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE	0
> +#define		PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE	1
> +#define		PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM	0
> +#define		PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG	1
> +#define		PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE	3
>   #define	PACKET3_INDIRECT_BUFFER				0x3F
>   #define		INDIRECT_BUFFER_VALID                   (1 << 23)
>   #define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) << 28)
> @@ -169,7 +232,63 @@
>   		 */
>   #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) << 21)
>   #define     INDIRECT_BUFFER_PRE_RESUME(x)               ((x) << 30)
> +#define		PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define		PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
> +#define		PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) & 0xFFFFF) << 0)
> +#define		PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) & 0x1) << 20)
> +#define		PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) & 0x1) << 21)
> +#define		PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) & 0x1) << 23)
> +#define		PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) & 0xF) << 24)
> +#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 28)
> +#define		PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) & 0x1) << 31)
> +#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU	0
> +#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM	1
>   #define	PACKET3_COPY_DATA				0x40
> +#define		PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) & 0xF) << 0)
> +#define		PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 13)
> +#define		PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) & 0x1) << 16)
> +#define		PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
> +#define		PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
> +#define		PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) & 0x1) << 29)
> +#define		PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define		PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define		PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
> +#define		PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define		PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
> +#define		PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
> +#define		PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
> +#define		PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
> +#define		PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
> +#define		PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
> +#define		PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define		PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
> +#define		PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER	0
> +#define		PACKET3_COPY_DATA__SRC_SEL__MEMORY	1
> +#define		PACKET3_COPY_DATA__SRC_SEL__TC_L2	2
> +#define		PACKET3_COPY_DATA__SRC_SEL__GDS	3
> +#define		PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS	4
> +#define		PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA	5
> +#define		PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA	6
> +#define		PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0	7
> +#define		PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1	8
> +#define		PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT	9
> +#define		PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER	0
> +#define		PACKET3_COPY_DATA__DST_SEL__TC_L2	2
> +#define		PACKET3_COPY_DATA__DST_SEL__GDS	3
> +#define		PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS	4
> +#define		PACKET3_COPY_DATA__DST_SEL__MEMORY	5
> +#define		PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC	6
> +#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU	0
> +#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
> +#define		PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA	0
> +#define		PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA	1
> +#define		PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION	0
> +#define		PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION	1
> +#define		PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU	0
> +#define		PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM	1
> +#define		PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT	0
> +#define		PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE	1
>   #define	PACKET3_PFP_SYNC_ME				0x42
>   #define	PACKET3_COND_WRITE				0x45
>   #define	PACKET3_EVENT_WRITE				0x46
> @@ -181,6 +300,15 @@
>   		 * 3 - SAMPLE_STREAMOUTSTAT*
>   		 * 4 - *S_PARTIAL_FLUSH
>   		 */
> +#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) & 0x3F) << 0)
> +#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) & 0xF) << 8)
> +#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) & 0x1) << 31)
> +#define		PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) ((((unsigned)(x)) & 0x3) << 29)
> +#define		PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
> +#define		PACKET3_EVENT_WRITE__ADDRESS_HI(x) (((unsigned)(x)) << 0)
> +#define		PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER	0
> +#define		PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTATS	2
> +#define		PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH	4
>   #define	PACKET3_RELEASE_MEM				0x49
>   #define		EVENT_TYPE(x)                           ((x) << 0)
>   #define		EVENT_INDEX(x)                          ((x) << 8)
> @@ -286,6 +414,13 @@
>   #define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(x) ((x) << 29)
>   #define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_ENA(x) ((x) << 30)
>   #define	PACKET3_REWIND					0x59
> +#define		PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
> +#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
> +#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI_VG10(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
> +#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
> +#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
> +#define 	PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x7FF) << 0)
>   #define	PACKET3_LOAD_UCONFIG_REG			0x5E
>   #define	PACKET3_LOAD_SH_REG				0x5F
>   #define	PACKET3_LOAD_CONFIG_REG				0x60
> @@ -300,12 +435,16 @@
>   #define	PACKET3_SET_SH_REG				0x76
>   #define		PACKET3_SET_SH_REG_START			0x00002c00
>   #define		PACKET3_SET_SH_REG_END				0x00003000
> +#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
> +#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0x1F) << 23)
> +#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) << 28)
>   #define	PACKET3_SET_SH_REG_OFFSET			0x77
>   #define	PACKET3_SET_QUEUE_REG				0x78
>   #define	PACKET3_SET_UCONFIG_REG				0x79
>   #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
>   #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
>   #define		PACKET3_SET_UCONFIG_REG_INDEX_TYPE		(2 << 28)
> +#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
>   #define	PACKET3_SCRATCH_RAM_WRITE			0x7D
>   #define	PACKET3_SCRATCH_RAM_READ			0x7E
>   #define	PACKET3_LOAD_CONST_RAM				0x80
--------------djw0EU8lnAegYfv5OF3CNHpo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html data-lt-installed="true"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Reviewed-by: Feifei Xu <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 1/21/2025 3:40 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250120194017.201218-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Consolidate PM4 definitions.  Most of these were previously
only defined in UMDs.  Add them here as well and sync with
latest packets.  Also no need to include soc15d.h on gfx10+.

Suggested-by: Saurabh Verma <a class="moz-txt-link-rfc2396E" href="mailto:saurabh.verma@amd.com">&lt;saurabh.verma@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |   1 -
 drivers/gpu/drm/amd/amdgpu/nvd.h       | 208 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15d.h    | 139 +++++++++++++++++
 5 files changed, 347 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 070b4d6bd9c59..63de78060d679 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -40,7 +40,6 @@
 #include &quot;ivsrcid/gfx/irqsrcs_gfx_10_1.h&quot;
 
 #include &quot;soc15.h&quot;
-#include &quot;soc15d.h&quot;
 #include &quot;soc15_common.h&quot;
 #include &quot;clearstate_gfx10.h&quot;
 #include &quot;v10_structs.h&quot;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 52c571b134fd0..89d17750af04d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -42,7 +42,6 @@
 #include &quot;ivsrcid/gfx/irqsrcs_gfx_11_0_0.h&quot;
 
 #include &quot;soc15.h&quot;
-#include &quot;soc15d.h&quot;
 #include &quot;clearstate_gfx11.h&quot;
 #include &quot;v11_structs.h&quot;
 #include &quot;gfx_v11_0.h&quot;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 2a71998800414..e425b87078d7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -40,7 +40,6 @@
 #include &quot;ivsrcid/gfx/irqsrcs_gfx_11_0_0.h&quot;
 
 #include &quot;soc15.h&quot;
-#include &quot;soc15d.h&quot;
 #include &quot;clearstate_gfx12.h&quot;
 #include &quot;v12_structs.h&quot;
 #include &quot;gfx_v12_0.h&quot;
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 631dafb922990..56f1bfac0b208 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -64,6 +64,24 @@
 #define	PACKET3_INDIRECT_BUFFER_CNST_END		0x19
 #define	PACKET3_ATOMIC_GDS				0x1D
 #define	PACKET3_ATOMIC_MEM				0x1E
+#define 	PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) &amp; 0x7F) &lt;&lt; 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define 	PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) &amp; 0x1FFF) &lt;&lt; 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC 0
+#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
+#define 	PACKET3_ATOMIC_MEM__COMMAND__WAIT_FOR_WRITE_CONFIRMATION 2
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SEND_AND_CONTINUE 3
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__LRU 0
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__STREAM 1
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__NOA 2
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__BYPASS 3
 #define	PACKET3_OCCLUSION_QUERY				0x1F
 #define	PACKET3_SET_PREDICATION				0x20
 #define	PACKET3_REG_RMW					0x21
@@ -105,6 +123,38 @@
 		 * 1 - pfp
 		 * 2 - ce
 		 */
+#define 	PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define 	PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 16)
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 20)
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define 	PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__MODE(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 21)
+#define 	PACKET3_WRITE_DATA__AID_ID(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 22)
+#define 	PACKET3_WRITE_DATA__TEMPORAL(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 24)
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_LO(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_HI(x) ((((unsigned)(x)) &amp; 0xFF) &lt;&lt; 0)
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_WRITE_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_WRITE_DATA__DST_SEL__GDS 3
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY 5
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE 6
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS 0
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS 1
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION 0
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION 1
+#define 	PACKET3_WRITE_DATA__MODE__PF_VF_DISABLED 0
+#define 	PACKET3_WRITE_DATA__MODE__PF_VF_ENABLED 1
+#define 	PACKET3_WRITE_DATA__TEMPORAL__RT 0
+#define 	PACKET3_WRITE_DATA__TEMPORAL__NT 1
+#define 	PACKET3_WRITE_DATA__TEMPORAL__HT 2
+#define 	PACKET3_WRITE_DATA__TEMPORAL__LU 3
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__LRU 0
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__STREAM 1
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__NOA 2
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS 3
 #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
 #define	PACKET3_MEM_SEMAPHORE				0x39
 #              define PACKET3_SEM_USE_MAILBOX       (0x1 &lt;&lt; 16)
@@ -135,6 +185,42 @@
 		/* 0 - me
 		 * 1 - pfp
 		 */
+#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) &amp; 0x7) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 4)
+#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 6)
+#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 22)
+#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 24)
+#define		PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define		PACKET3_WAIT_REG_MEM__TEMPORAL(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsigned)(x)) &amp; 0X3FFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) &amp; 0X3FFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 31)
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS 0
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE 1
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE 2
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE 3
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE 4
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE 5
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE 6
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE 0
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE 1
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM 0
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG 1
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE 3
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__LRU 0
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__STREAM 1
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__NOA 2
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__BYPASS 3
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__RT 0
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__NT 1
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__HT 2
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__LU 3
 #define	PACKET3_INDIRECT_BUFFER				0x3F
 #define		INDIRECT_BUFFER_VALID                   (1 &lt;&lt; 23)
 #define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) &lt;&lt; 28)
@@ -144,8 +230,94 @@
 		 */
 #define		INDIRECT_BUFFER_PRE_ENB(x)		((x) &lt;&lt; 21)
 #define		INDIRECT_BUFFER_PRE_RESUME(x)           ((x) &lt;&lt; 30)
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
+#define 	PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) &amp; 0xFFFFF) &lt;&lt; 0)
+#define 	PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 20)
+#define 	PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 21)
+#define 	PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 23)
+#define 	PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 24)
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 28)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 28)
+#define 	PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 31)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__RT 0
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__NT 1
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__HT 2
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__LU 3
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU 0
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM 1
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__NOA 2
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__BYPASS 3
 #define	PACKET3_COND_INDIRECT_BUFFER			0x3F
 #define	PACKET3_COPY_DATA				0x40
+#define 	PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 0)
+#define 	PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 13)
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 13)
+#define 	PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 16)
+#define 	PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 20)
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 29)
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define 	PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define 	PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x1FFFFFFF) &lt;&lt; 3)
+#define 	PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define 	PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define 	PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define 	PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x1FFFFFFF) &lt;&lt; 3)
+#define 	PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define 	PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__MODE(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 21)
+#define 	PACKET3_COPY_DATA__AID_ID(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 23)
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_HI(x) ((((unsigned)(x)) &amp; 0xFF) &lt;&lt; 0)
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_HI(x) ((((unsigned)(x)) &amp; 0xFF) &lt;&lt; 0)
+#define 	PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2_OBSOLETE 1
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS 3
+#define 	PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA 5
+#define 	PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA 6
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0 7
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1 8
+#define 	PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT 9
+#define 	PACKET3_COPY_DATA__SRC_SEL__SYSTEM_CLOCK_COUNT 10
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__DST_SEL__GDS 3
+#define 	PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2_OBSOLETE 5
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC 6
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU 0
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__NOA 2
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__BYPASS 3
+#define 	PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA 0
+#define 	PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA 1
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION 0
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION 1
+#define 	PACKET3_COPY_DATA__MODE__PF_VF_DISABLED 0
+#define 	PACKET3_COPY_DATA__MODE__PF_VF_ENABLED 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU 0
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM 1
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__NOA 2
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__BYPASS 3
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT 0
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE 1
 #define	PACKET3_CP_DMA					0x41
 #define	PACKET3_PFP_SYNC_ME				0x42
 #define	PACKET3_SURFACE_SYNC				0x43
@@ -160,6 +332,23 @@
 		 * 3 - SAMPLE_STREAMOUTSTAT*
 		 * 4 - *S_PARTIAL_FLUSH
 		 */
+#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) &amp; 0x3F) &lt;&lt; 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define		PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 29)
+#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 0)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) &amp; 0x1FFFFFFF) &lt;&lt; 3)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_HI(x) ((unsigned)(x))
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTAT 2
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH 4
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS 8
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS1 9
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS2 10
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS3 11
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__LEGACY_MODE 0
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE1 1
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__NEW_MODE 2
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE3 3
 #define	PACKET3_EVENT_WRITE_EOP				0x47
 #define	PACKET3_EVENT_WRITE_EOS				0x48
 #define	PACKET3_RELEASE_MEM				0x49
@@ -304,6 +493,12 @@
 		 * 2: REVERSE
 		 */
 #define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 &lt;&lt; 18)
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) &amp; 0xFF) &lt;&lt; 0)
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) &amp; 0xFFFFFF) &lt;&lt; 0)
+#define 	PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) &amp; 0x7FFFF) &lt;&lt; 0)
 #define	PACKET3_REWIND					0x59
 #define	PACKET3_INTERRUPT				0x5A
 #define	PACKET3_GEN_PDEPTE				0x5B
@@ -330,11 +525,17 @@
 #define	PACKET3_SET_SH_REG				0x76
 #define		PACKET3_SET_SH_REG_START			0x00002c00
 #define		PACKET3_SET_SH_REG_END				0x00003000
+#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) &amp; 0x1F) &lt;&lt; 23)
+#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 28)
+#define 	PACKET3_SET_SH_REG__INDEX__DEFAULT 0
+#define 	PACKET3_SET_SH_REG__INDEX__INSERT_VMID 1
 #define	PACKET3_SET_SH_REG_OFFSET			0x77
 #define	PACKET3_SET_QUEUE_REG				0x78
 #define	PACKET3_SET_UCONFIG_REG				0x79
 #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
 #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
+#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
 #define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
 #define	PACKET3_FORWARD_HEADER				0x7C
 #define	PACKET3_SCRATCH_RAM_WRITE			0x7D
@@ -369,6 +570,7 @@
 #              define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) &lt;&lt; 0)
 #              define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) &lt;&lt; 4)
 #              define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) &lt;&lt; 5)
+#              define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) &lt;&lt; 29)
 #define	PACKET3_AQL_PACKET				0x99
 #define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
 #define	PACKET3_SET_SH_REG_INDEX			0x9B
@@ -462,6 +664,12 @@
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) &lt;&lt; 25)
 #define	PACKET3_RUN_LIST				0xA5
 #define	PACKET3_MAP_PROCESS_VM				0xA6
+
+#define PACKET3_RUN_CLEANER_SHADER                      0xD2
+/* 1. header
+ * 2. RESERVED [31:0]
+ */
+
 /* GFX11 */
 #define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
 #              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) &lt;&lt; 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index b9cbeb389edc1..a5000c171c02c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -93,11 +93,25 @@
 #define	PACKET3_DISPATCH_INDIRECT			0x16
 #define	PACKET3_ATOMIC_GDS				0x1D
 #define	PACKET3_ATOMIC_MEM				0x1E
+#define		PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) &amp; 0x3F) &lt;&lt; 0)
+#define		PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define		PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define		PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)) &lt;&lt; 0)
+#define		PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)) &lt;&lt; 0)
+#define		PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)) &lt;&lt; 0)
+#define		PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)) &lt;&lt; 0)
+#define		PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)) &lt;&lt; 0)
+#define		PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)) &lt;&lt; 0)
+#define		PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) &amp; 0x1FFF) &lt;&lt; 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC	0
+#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
 #define	PACKET3_OCCLUSION_QUERY				0x1F
 #define	PACKET3_SET_PREDICATION				0x20
 #define	PACKET3_REG_RMW					0x21
 #define	PACKET3_COND_EXEC				0x22
 #define	PACKET3_PRED_EXEC				0x23
+#define		PACKET3_PRED_EXEC__EXEC_COUNT(x)	((((unsigned)(x)) &amp; 0x3FFF) &lt;&lt; 0)
+#define		PACKET3_PRED_EXEC__VIRTUAL_XCC_ID_SELECT(x)	((((unsigned)(x)) &amp; 0xFF) &lt;&lt; 24)
 #define	PACKET3_DRAW_INDIRECT				0x24
 #define	PACKET3_DRAW_INDEX_INDIRECT			0x25
 #define	PACKET3_INDEX_BASE				0x26
@@ -132,6 +146,28 @@
 		 * 1 - pfp
 		 * 2 - ce
 		 */
+#define		PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define		PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 16)
+#define		PACKET3_WRITE_DATA__RESUME_VF_MI300(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 19)
+#define		PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 20)
+#define		PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define		PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define		PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define		PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define		PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER	0
+#define		PACKET3_WRITE_DATA__DST_SEL__TC_L2	2
+#define		PACKET3_WRITE_DATA__DST_SEL__GDS	3
+#define		PACKET3_WRITE_DATA__DST_SEL__MEMORY	5
+#define		PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE	6
+#define		PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS	0
+#define		PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS	1
+#define		PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION	0
+#define		PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION	1
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__LRU	0
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__STREAM	1
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__NOA	2
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS	3
 #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
 #define	PACKET3_MEM_SEMAPHORE				0x39
 #              define PACKET3_SEM_USE_MAILBOX       (0x1 &lt;&lt; 16)
@@ -160,6 +196,33 @@
 		/* 0 - me
 		 * 1 - pfp
 		 */
+#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) &amp; 0x7) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 4)
+#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 6)
+#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 22)
+#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 24)
+#define		PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 31)
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS	0
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE	1
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE	2
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE	3
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE	4
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE	5
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE	6
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE	0
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE	1
+#define		PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM	0
+#define		PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG	1
+#define		PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE	3
 #define	PACKET3_INDIRECT_BUFFER				0x3F
 #define		INDIRECT_BUFFER_VALID                   (1 &lt;&lt; 23)
 #define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) &lt;&lt; 28)
@@ -169,7 +232,63 @@
 		 */
 #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) &lt;&lt; 21)
 #define     INDIRECT_BUFFER_PRE_RESUME(x)               ((x) &lt;&lt; 30)
+#define		PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define		PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
+#define		PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) &amp; 0xFFFFF) &lt;&lt; 0)
+#define		PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 20)
+#define		PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 21)
+#define		PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 23)
+#define		PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 24)
+#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 28)
+#define		PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 31)
+#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU	0
+#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM	1
 #define	PACKET3_COPY_DATA				0x40
+#define		PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 0)
+#define		PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 13)
+#define		PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 16)
+#define		PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 20)
+#define		PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 25)
+#define		PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 29)
+#define		PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define		PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define		PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x1FFFFFFF) &lt;&lt; 3)
+#define		PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define		PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) &amp; 0x3FFFF) &lt;&lt; 0)
+#define		PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x3FFFFFFF) &lt;&lt; 2)
+#define		PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) &amp; 0x1FFFFFFF) &lt;&lt; 3)
+#define		PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define		PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER	0
+#define		PACKET3_COPY_DATA__SRC_SEL__MEMORY	1
+#define		PACKET3_COPY_DATA__SRC_SEL__TC_L2	2
+#define		PACKET3_COPY_DATA__SRC_SEL__GDS	3
+#define		PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS	4
+#define		PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA	5
+#define		PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA	6
+#define		PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0	7
+#define		PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1	8
+#define		PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT	9
+#define		PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER	0
+#define		PACKET3_COPY_DATA__DST_SEL__TC_L2	2
+#define		PACKET3_COPY_DATA__DST_SEL__GDS	3
+#define		PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS	4
+#define		PACKET3_COPY_DATA__DST_SEL__MEMORY	5
+#define		PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC	6
+#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU	0
+#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
+#define		PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA	0
+#define		PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA	1
+#define		PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION	0
+#define		PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION	1
+#define		PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU	0
+#define		PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM	1
+#define		PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT	0
+#define		PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE	1
 #define	PACKET3_PFP_SYNC_ME				0x42
 #define	PACKET3_COND_WRITE				0x45
 #define	PACKET3_EVENT_WRITE				0x46
@@ -181,6 +300,15 @@
 		 * 3 - SAMPLE_STREAMOUTSTAT*
 		 * 4 - *S_PARTIAL_FLUSH
 		 */
+#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) &amp; 0x3F) &lt;&lt; 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 8)
+#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) &amp; 0x1) &lt;&lt; 31)
+#define		PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) ((((unsigned)(x)) &amp; 0x3) &lt;&lt; 29)
+#define		PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) &amp; 0x1FFFFFFF) &lt;&lt; 3)
+#define		PACKET3_EVENT_WRITE__ADDRESS_HI(x) (((unsigned)(x)) &lt;&lt; 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER	0
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTATS	2
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH	4
 #define	PACKET3_RELEASE_MEM				0x49
 #define		EVENT_TYPE(x)                           ((x) &lt;&lt; 0)
 #define		EVENT_INDEX(x)                          ((x) &lt;&lt; 8)
@@ -286,6 +414,13 @@
 #define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(x) ((x) &lt;&lt; 29)
 #define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_ENA(x) ((x) &lt;&lt; 30)
 #define	PACKET3_REWIND					0x59
+#define		PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) &amp; 0xFF) &lt;&lt; 0)
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI_VG10(x) ((((unsigned)(x)) &amp; 0xFFFFFF) &lt;&lt; 0)
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) &amp; 0xFFFFFF) &lt;&lt; 0)
+#define 	PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) &amp; 0x7FF) &lt;&lt; 0)
 #define	PACKET3_LOAD_UCONFIG_REG			0x5E
 #define	PACKET3_LOAD_SH_REG				0x5F
 #define	PACKET3_LOAD_CONFIG_REG				0x60
@@ -300,12 +435,16 @@
 #define	PACKET3_SET_SH_REG				0x76
 #define		PACKET3_SET_SH_REG_START			0x00002c00
 #define		PACKET3_SET_SH_REG_END				0x00003000
+#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
+#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) &amp; 0x1F) &lt;&lt; 23)
+#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) &amp; 0xF) &lt;&lt; 28)
 #define	PACKET3_SET_SH_REG_OFFSET			0x77
 #define	PACKET3_SET_QUEUE_REG				0x78
 #define	PACKET3_SET_UCONFIG_REG				0x79
 #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
 #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
 #define		PACKET3_SET_UCONFIG_REG_INDEX_TYPE		(2 &lt;&lt; 28)
+#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) &amp; 0xFFFF) &lt;&lt; 0)
 #define	PACKET3_SCRATCH_RAM_WRITE			0x7D
 #define	PACKET3_SCRATCH_RAM_READ			0x7E
 #define	PACKET3_LOAD_CONST_RAM				0x80
</pre>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------djw0EU8lnAegYfv5OF3CNHpo--
