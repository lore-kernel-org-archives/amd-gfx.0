Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C9D6CFA6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 22:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC4D10E15B;
	Thu, 22 Jan 2026 22:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rrVeGRKb";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2F310E15B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 22:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNWQHobr/N+D78IrCebwyRNaCPw4iiDkph25YTbKT7PWII404nWumR8FEe7+G2Npq33vcoF1vCjQRGKyhqjS4YGyK4Y/MK6aPOcIksByGNsoXdY56a8d/p1IoA+bfkMf8qAh7KfiA/gHbLAAe1/I6WMqEPnmDPwBmjHlvlHlIHOv3wR6YclT+C1qe2DSgKRgVEETKVuip3UbR0HR+RSIIVxfOYl0ABbrlGtfGapQWvc9OYDvc9xBAxHZyUFB21Pnk+FEB2wYMyu4/QnspacvPOpTIFvtEa1V4yV1N6RqYKFH/iygnqSF0oR7AMUfKRDbslaJZ3LpuR56s7Mxo21u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ0BjYARveNFz4ZwRgmv46qOwChno41vakYblwESyQs=;
 b=UuAlN5DnCJiLkgH/YiyiKzaeCec1z8Ba097xk047Ysyg/h/UViXM5e5VIWXgoIdn/xgwzNtmYzhahC5l56q+X3Z7uPHPFSVvci+KhfVLWapFOZe/vTXX4sBfJIrkOtGtfNcw1yg3wB536maMisxBURyxZ7uTq3jnJp8b4+SK5K0PHEJY1k764hqX4al0HP8BzFtIYfooLIL2xS1nniX3yx9O/TzKgRQ39KxCtww2V4i/uY5zyQKDpCovggHqIB/pJcXhuF2R7sX84SCcxzx2oWt7WcS4KmxcG1WJQKCSZAcLbiYWfImRncToC2p3TspLzSAJ0OgQeQGiMCGjpbe4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ0BjYARveNFz4ZwRgmv46qOwChno41vakYblwESyQs=;
 b=rrVeGRKbimnLWwfRXI261nbjDSyxcKlI6xW++FegvJKva3973M7kfpebZLR/kk3OaCDHmXoBAjW6OZkFW/bGpoOTQgXJBxuPd7PazGz107RYvK9A8OijYCTo1UVUirPX9LIyG376Zz78txdvGZFwrIT3XwXLviaxY5Jxoc8qF3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 22:47:41 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 22:47:41 +0000
Content-Type: multipart/alternative;
 boundary="------------WNfJ25F04mXoaupbmwvnZssf"
Message-ID: <51036f47-5495-4379-9655-c277c0734016@amd.com>
Date: Thu, 22 Jan 2026 17:47:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org,
 "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
 <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
 <4882409.vXUDI8C0e8@timur-hyperion>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <4882409.vXUDI8C0e8@timur-hyperion>
X-ClientProxiedBy: YQBPR0101CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c05013-ec1c-4d94-8201-08de5a083fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEkybEdYd25ZQy9hNi85Y1pLQWlkd1ZFdFlrRVZDVEpMZkw3c1hSK014RzJ1?=
 =?utf-8?B?bUV4TFM3UWFhbDgydkhHdTZTeDhzVXVEU3hZbVMwREZWVmpTTCtYUDNqeWFQ?=
 =?utf-8?B?ZGNJZzZmZmtZOWVwTE1kWkRqdENRT2c1QzByREtWQXJmeExwUm5kWlpWSVAv?=
 =?utf-8?B?YzhxSHRWT2ZNSGVPTVRxeHlGeStRWS9kaUFRTHJFaUY2Y0RuSkV3VlZjaFhK?=
 =?utf-8?B?Q0ZvS3FZRlJGM2dMeGJlNGFxV1hWcnRVc3dDRXZsbTM0Um1rK2xEeDUxTTFw?=
 =?utf-8?B?dDY4amFZajdhMXZPbTJSVDVHUlZNbU5WMWk4S3QwWiticVl0TThjUHR2VUFn?=
 =?utf-8?B?WnNkOUR2N3pKUE9sOGIybWNGZWFBNjVtU2RyMm52TnNJSHJXOEYwc3Y3eWdZ?=
 =?utf-8?B?NkZYUno1Q3BmNmhrZHgxSE4yOVJzRjF3ME1KZGVleitPZXQyNytXakF3c2pO?=
 =?utf-8?B?ZE9KNEZrQkE4ZmdmTlRGV3E2RDdzMFlaWXJnaXVqU2ZRY3N0UTlqbnhXcHZE?=
 =?utf-8?B?UEIwYnBjRlYwSjNrcmo2Mk40dWdXYzRxZmZrM3pONHowcEZGYXVkMmV5V3R5?=
 =?utf-8?B?SnA4bzVYdUVDZ1ZGazhUb2RJaDd5UXdsZFZSeHJOTFNTa3VwaFMreGhnc0lU?=
 =?utf-8?B?QXAzU1ZscmtFcmczRmRjR0pnS3FjMWN4N0s1ZFpvWTYvMXhOUVpDMXlwdzNK?=
 =?utf-8?B?M3dUMmlQMDY0dmYvSmhzYTJjSXNMcFhxOEFtOWk2RHNJRGNJTU1MdHM4WG9F?=
 =?utf-8?B?UnZmdnEwQmhHRmhpVkJTOGlvbHBPQWVDVEgzZ3BqM2pEL3lTam0zVVFvazFW?=
 =?utf-8?B?YmdUaDJBY2phRFpybDIya3hCN0ordGNKVDVhamgvbFZuaHgxYTIyZDFyczJP?=
 =?utf-8?B?SXNzNFc5UkhnbytOVkNYTmFRZk9zUEtGYSs0L3o2M2tkL2hmN3VTSUw4aklV?=
 =?utf-8?B?d3R4aHpHODY1WWkvbEllK2YvT2c2RkhFUHlCVzNHZGJMNm9OWjRZUGczSUtt?=
 =?utf-8?B?aDV1TGpLQkRUeWZUMHNRWGNkc29hZWlNem5FYnFLSkNFV1BHajVvSDMyYlZa?=
 =?utf-8?B?WEtkZXpjVkpNR2U3akVISmtUMHBRWHFqQUlXRWpZY3VKcEh0ci9mbzNFYnVC?=
 =?utf-8?B?aHdPSzFjbjR2Zm9oSjZaMkFYSlAwNlNobEswN1U0cmxEWXo3WHBTVTZBZG11?=
 =?utf-8?B?VjAyZU5keDZaTS96WEFWS0RLSzdvbEtxbFRzMGkzVlJnOGhXb3ROZnhFN21Q?=
 =?utf-8?B?cFlkcHRkakZYU21uUW5wWDkveXdBTkJUN0JxWk5SWFB0NHQxTDBhVzRwZHNm?=
 =?utf-8?B?NHNGQjdPK3p4elpBc2ZwdTQ0QUFWMkJsYTF3c1VvZ2JkQnR2WEFFM1Z4b2tr?=
 =?utf-8?B?OVI3MjVYcEtXbllpY2RLUVB6TnF0SFA3WW9Za0R2TDlzSGo1bmZHaWN1NDZk?=
 =?utf-8?B?TTM4VGF1d29Dc1BOaWtkRG9kMVpHSmVpUjJYVkpCbGtpcjJwVW5pZENVQTBL?=
 =?utf-8?B?b0JLRU5uN0RuV0dvbEZYL2xBRDFETW5YSldSN0M2b1lMRDNNZmNWYnh1cFVl?=
 =?utf-8?B?WEhwRDg5WG94ZGN6MVh4VjFvekllb0Y0Zk5sblJsMW5QK3hnYlRIeVd6KzFR?=
 =?utf-8?B?UUlIblRFSUJHN0NZeVF4QUQ1Y2hOd1JBclJBV0tvRzZlZmZUbmFlMDBnTEVB?=
 =?utf-8?B?cXFUcWwwVkpTelFzTzI3OTZXdXNRYklUd0JJd2V4TzB2QW94S0t6TEQ3bWlV?=
 =?utf-8?B?aXlXdGtJN0hnU3JXV3lDRzRZKzA4VEhFa1RvcThPaXVGMTV3azRnMFJtMkI0?=
 =?utf-8?B?eDVMNFVLK3RSU1h5aXl2MFo1WXVwTm5adWVSbzdaQXFia0xhY1RMcHU1SHJI?=
 =?utf-8?B?NVVFYk5JSDBqVWZxbXBUL3R3U2JWNytPWnpsYjJzbmEzNVRwekNCTXJ0YThP?=
 =?utf-8?B?K3ZNK25yV3ExMmJKRmJiVDg0YmZ4TlBDNmc1TUU1Z2Qyc3d5SjRmbEZhcXFo?=
 =?utf-8?B?TEJHYlQ0WlNmK0RwK1hCbGFMT0RFdTdlMTFKNm8wN3pOeXBlY0I0Z2FVdE44?=
 =?utf-8?B?Q290bkJyWlArN3YvZDVtV01MTTRHZXYzTThkTjRBeTJyMHRSajFyVlluZkRL?=
 =?utf-8?Q?G7Fc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXhlbFprekYrbGlLTHJZcUFmYmFmNDhaVUx4MC9sVWZYR2ZybTZ0WjB2aU9t?=
 =?utf-8?B?VE94VmEvdjlBMlhTS01LYzdOMVpZNmZWb3pTckdpV2hlTkNNeW90NXltSndx?=
 =?utf-8?B?a3dCQzZpWk5GNmhjSUc1MnpVM0xJbXVTSWphUW1ULy9BK2RpRytBQU9kWVIw?=
 =?utf-8?B?Rmo3ZjB2WmtVL0krTDlxNENEVytkeXpFSjFTMUJXc0JTSUoyQ2pDQlc1cDJS?=
 =?utf-8?B?N3RFWm1xUFlHS1U2QlBVZEwyRzB5cXlDdjErN0R6ZXd1dVpSb3pDaTdIckVU?=
 =?utf-8?B?TjVSb2szTXArTC9rRXpTQUhDaHRBNERxMXVIRkRQbnNaYTQyc3hZWGY4UHpZ?=
 =?utf-8?B?UlAxSTZUL2pEMHFZYUtMWnlKd3ZPYnNMQ09lc3AyRWRqVjc1SWhLRmpEbU9y?=
 =?utf-8?B?bzlrYjRDSFFpcmZySGVVZEw5TXl3SUp0M2NwQzZaTjRncXlDOEpsZXd5eDRa?=
 =?utf-8?B?ZXVOb0lpUEt0eHVQQ1lxNnhqREtrSzdtaGFXNFo4OWRvSis2L0xmNUZmNk1C?=
 =?utf-8?B?ZUl6THVGNkltcVJQY2c0S245eWRvaXZSc05ta1haRWE4UldXdWdsZkxySVRT?=
 =?utf-8?B?WmkrbVJsVGwwbHgxS3F1Y05lR0dEcWRXL213R2tVaDR3U2FDcEtmbTNkUm9l?=
 =?utf-8?B?R1RRc0d2cmI0RHcyWHZEQncwbGNLRktFb05aZTVYQ1BuOXR3OCtBUms2MkJK?=
 =?utf-8?B?b3hWNlhFZlJNOGFRY0xjSzEwc1lYbXNnZmRXYUxVOU5YeXZjMHNLRnYzbHBj?=
 =?utf-8?B?bGM0b2VZaEhYOVNPRXVCb0k4b3RvQ3EyallpRTdwUUpZdHV4MU5Ya1JweUJa?=
 =?utf-8?B?TmhHTlZTaE8zU00xUlRlWUdUUUpvcGpRcnFheDczQ3IwLzV5bndRRko1MjlZ?=
 =?utf-8?B?WlVSMncyL2h0ZXV1QVEvV1ZxUkdEdWhranFTeVpnSEhpU3RJVnY4ODU0ZDQv?=
 =?utf-8?B?bjNKRDU2ZmtZTXI3aW1ZM2pwVDNiSzBSekZvS0pQY2Nxc2Y3NDVvREdIaWpX?=
 =?utf-8?B?UVMvWGV4MUxrR3diblRLNnlZemZ5UVJjMnd5Mk53M3BMbmYrei85RzB4VjRi?=
 =?utf-8?B?YTZuRUVUeTErN1JzY2Q5Zm5GWXFxaEFMMVl6WktoRlBCcFYrRkJFNEY3Smx3?=
 =?utf-8?B?WTRsQ1UzbEx6VGE2QjU3V1M4b3ZqV01Ld016SEVaZld0K2JxcjVtQ1gyT1lq?=
 =?utf-8?B?dUo5SUliWFp2djMwY2ZsaUtsSnZVOFpPa3RuM2JLcnBYd3hUbTRSZU9nVmVQ?=
 =?utf-8?B?bEoyMzZ6YloyZmdpNHM0Zisxd2I1eHAzRC9BQlFzdUp3dUN4bFBFU0FnV1Bh?=
 =?utf-8?B?cTVnV0cxVVBlTmhlTDg5WUM3cUl0cVYwcGI3SDRzSmJQSWkvTTJ4K2Z6SEZV?=
 =?utf-8?B?M3VodjFGRW10OHhHTUxPQVJweTRyeTRMc3hIK0hGZjV4MHZLSWxYeEdKMnZT?=
 =?utf-8?B?SmNtY201end6eDM2dC9qS2VMRExkMnJqM0NaSTE2bitucXNWY3YzZTJMamEw?=
 =?utf-8?B?QitPL09QQlArcERyRDdlQ2tHVmxoV0lKbisxYkZXWWloV2dvSjdxUXlPQ1pU?=
 =?utf-8?B?MU5Fbjg1cHkxSlh0MXRtVkJkZVdCZDViN3NTTmI4RG54S3A5Mi8zVmtsRGlH?=
 =?utf-8?B?Zzl0QitaakNSQWdLcjg3N25HS1NoQUZxbUVvYkMwaUpyRnlFUGNlVHRXVldS?=
 =?utf-8?B?eUNnNTUzUEphUzlRRlVWcmlqQUVlOGlrVWR5eEhvV2ZBbTg3aHRaQXRRZDdr?=
 =?utf-8?B?N2xGRlZzbVVUQThXUTI2UytsTGt0YlVYOFpuSk9XUnpBVytJd1F2cDRRM3VN?=
 =?utf-8?B?dmoxZEpPdkUzNXNqUFMvbFQ4Z0k0NVA2dGxZZTJCS3lDY2I4c0c0Ump1NDlN?=
 =?utf-8?B?cnV3bVd1NWxlamlwVmFSQWNTQWZFYWx2OFV5N01vTlpEWGJnMXpBbTA1VHFt?=
 =?utf-8?B?MTlpY0QwQmVzZGEzNUlxeE5LV1lpMnJWSWpJQjNVKzB0aFBQWnUrYis2d3ZF?=
 =?utf-8?B?MWhWZWtOTnJkbyt0SmtsbDVVdWI5N0xDVFpycERYTW1CTS9HV2NkUVJDT3lh?=
 =?utf-8?B?QkRLMHlJNmhPMmpqQ01hWCtWNFFRTTFmTW85VERvemJ1bTRiYnBZRVdaM0NK?=
 =?utf-8?B?VWl2Ykh5NEE1SmpRUDQyR3RTcnZCR2RIUnJiL3cyZ013aFdZcW9YK3JwaW4z?=
 =?utf-8?B?ZVlQV0dGWjI4cXZxUittb3QweVc5VGZQVHNFRGk1V1hzQlBONVZoeGMydnpN?=
 =?utf-8?B?bUlPMkhwYXdmZUE4UXAyNVJHR0s5UytNNk41bFI0Q2QreXlqYWNXNDV6M1Ja?=
 =?utf-8?Q?HLAAqa7JYCjsU3yWNK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c05013-ec1c-4d94-8201-08de5a083fc2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 22:47:41.1064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8xbHWmYHJ7yP2jpCijDlJluQa0w24+B7kjUOJvkBQIsmLAVH7OLcjYs0bFXGlB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580
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

--------------WNfJ25F04mXoaupbmwvnZssf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-01-22 10:00, Timur Kristóf wrote:
> On Thursday, January 22, 2026 6:07:27 AM Central European Standard Time Lazar,
> Lijo wrote:
>> On 21-Jan-26 11:54 PM, Alex Deucher wrote:
>>> From: Jon Doron<jond@wiz.io>
>>>
>>> On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
>>> ih2 interrupt ring buffers are not initialized. This is by design, as
>>> these secondary IH rings are only available on discrete GPUs. See
>>> vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
>>> AMD_IS_APU is set.
>>>
>>> However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
>>> get the timestamp of the last interrupt entry. When retry faults are
>>> enabled on APUs (noretry=0), this function is called from the SVM page
>>> fault recovery path, resulting in a NULL pointer dereference when
>>> amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
>>>
>>> The crash manifests as:
>>>     BUG: kernel NULL pointer dereference, address: 0000000000000004
>>>     RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
>>>     
>>>     Call Trace:
>>>      amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
>>>      svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
>>>      amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
>>>      gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
>>>      amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
>>>      amdgpu_ih_process+0x84/0x100 [amdgpu]
>>>
>>> This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
>>> IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
>>> noretry=1 to noretry=0, enabling retry fault handling and thus
>>> exercising the buggy code path.
>>>
>>> Fix this by adding a check for ih1.ring_size before attempting to use
>>> it. Also restore the soft_ih support from commit dd299441654f
>>> ("drm/amdgpu:
>>> Rework retry fault removal").  This is needed if the hardware doesn't
>>> support secondary HW IH rings.
>>>
>>> v2: additional updates (Alex)
>>>
>>> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3814
>>> Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
>>> Cc:stable@vger.kernel.org
>>> Signed-off-by: Jon Doron<jond@wiz.io>
>>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>> 8e65fec9f534e..243d75917458a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
>>> amdgpu_device *adev, uint64_t addr,>
>>>    	if (adev->irq.retry_cam_enabled)
>>>    	
>>>    		return;
>>>
>>> +	else if (adev->irq.ih1.ring_size)
>>> +		ih = &adev->irq.ih1;
>>> +	else if (adev->irq.ih_soft.enabled)
>>> +		ih = &adev->irq.ih_soft;
>> Faults are delegated to soft ring when retry_cam is enabled -
>> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drive
>> rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541
> Hi,
>
> As far as I know the retry CAM is not available on APUs.
> Please correct me if I'm wrong.
Yes, that is correct, only on ASICs without CAM (the retry page fault hw 
filter), we use sw retry fault filter to
drop duplicate faults, from the dedicated retry fault ring IH1 or 
delegate from IH ring to ih_soft ring.
Without IH1 ring, the retry fault on IH ring may cause ring overflow and 
drop other important interrupts,
we should not enable XNACK on it. With that said, the fix looks good to me.

Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>
> Thanks,
> Timur
>
>> That matches with the original logic in d299441654f ("drm/amdgpu: Rework
>> retry fault removal").
>>
>> To match exactly with the logic in above commit, I think it should use
>> soft ring only when retry cam is enabled. Presently, it's returning
>> without doing anything.
>>
>> Thanks,
>> Lijo
>>
>>> +	else
>>> +		return;
>>>
>>> -	ih = &adev->irq.ih1;
>>>
>>>    	/* Get the WPTR of the last entry in IH ring */
>>>    	last_wptr = amdgpu_ih_get_wptr(adev, ih);
>>>    	/* Order wptr with ring data. */
>
>
>

--------------WNfJ25F04mXoaupbmwvnZssf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-01-22 10:00, Timur Kristóf
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4882409.vXUDI8C0e8@timur-hyperion">
      <pre class="moz-quote-pre" wrap="">On Thursday, January 22, 2026 6:07:27 AM Central European Standard Time Lazar, 
Lijo wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 21-Jan-26 11:54 PM, Alex Deucher wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">From: Jon Doron <a class="moz-txt-link-rfc2396E" href="mailto:jond@wiz.io">&lt;jond@wiz.io&gt;</a>

On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
ih2 interrupt ring buffers are not initialized. This is by design, as
these secondary IH rings are only available on discrete GPUs. See
vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
AMD_IS_APU is set.

However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
get the timestamp of the last interrupt entry. When retry faults are
enabled on APUs (noretry=0), this function is called from the SVM page
fault recovery path, resulting in a NULL pointer dereference when
amdgpu_ih_decode_iv_ts_helper() attempts to access ih-&gt;ring[].

The crash manifests as:
   BUG: kernel NULL pointer dereference, address: 0000000000000004
   RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
   
   Call Trace:
    amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
    svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
    amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
    gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
    amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
    amdgpu_ih_process+0x84/0x100 [amdgpu]

This issue was exposed by commit 1446226d32a4 (&quot;drm/amdgpu: Remove GC HW
IP 9.3.0 from noretry=1&quot;) which changed the default for Renoir APU from
noretry=1 to noretry=0, enabling retry fault handling and thus
exercising the buggy code path.

Fix this by adding a check for ih1.ring_size before attempting to use
it. Also restore the soft_ih support from commit dd299441654f
(&quot;drm/amdgpu:
Rework retry fault removal&quot;).  This is needed if the hardware doesn't
support secondary HW IH rings.

v2: additional updates (Alex)

Closes: <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/3814">https://gitlab.freedesktop.org/drm/amd/-/issues/3814</a>
Fixes: dd299441654f (&quot;drm/amdgpu: Rework retry fault removal&quot;)
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Signed-off-by: Jon Doron <a class="moz-txt-link-rfc2396E" href="mailto:jond@wiz.io">&lt;jond@wiz.io&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---

  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
8e65fec9f534e..243d75917458a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
amdgpu_device *adev, uint64_t addr,&gt; 
  	if (adev-&gt;irq.retry_cam_enabled)
  	
  		return;

+	else if (adev-&gt;irq.ih1.ring_size)
+		ih = &amp;adev-&gt;irq.ih1;
+	else if (adev-&gt;irq.ih_soft.enabled)
+		ih = &amp;adev-&gt;irq.ih_soft;
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Faults are delegated to soft ring when retry_cam is enabled -
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drive">https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drive</a>
rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hi,

As far as I know the retry CAM is not available on APUs.
Please correct me if I'm wrong.</pre>
    </blockquote>
    Yes, that is correct, only on ASICs without CAM (the retry page
    fault hw filter), we use sw retry fault filter to<br>
    drop duplicate faults, from the dedicated retry fault ring IH1 or
    delegate from IH ring to ih_soft ring.<br>
    Without IH1 ring, the retry fault on IH ring may cause ring overflow
    and drop other important interrupts,<br>
    we should not enable XNACK on it. With that said, the fix looks good
    to me.<br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:4882409.vXUDI8C0e8@timur-hyperion">
      <pre class="moz-quote-pre" wrap="">

Thanks,
Timur

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
That matches with the original logic in d299441654f (&quot;drm/amdgpu: Rework
retry fault removal&quot;).

To match exactly with the logic in above commit, I think it should use
soft ring only when retry cam is enabled. Presently, it's returning
without doing anything.

Thanks,
Lijo

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+	else
+		return;

-	ih = &amp;adev-&gt;irq.ih1;

  	/* Get the WPTR of the last entry in IH ring */
  	last_wptr = amdgpu_ih_get_wptr(adev, ih);
  	/* Order wptr with ring data. */
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">



</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------WNfJ25F04mXoaupbmwvnZssf--
