Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F8AC9EC75
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 11:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AEB10E37D;
	Mon, 12 Jan 2026 11:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2c7naQZy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C790D10E37D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 11:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCJsKJzonL34VyEg6xtHT7yt34T4rLLlyaKTvfrY+RAtDiQbMPnQ7ZRn+WBD/2qzLOi68UNzHE+zf+rCGldWpqIKtmmIyiTAWMNwqqwxfghGiYfleSdR1FYE9dmcBLkoCo4v7EycPZ8Dbg6zSW5iS6vE1XFyyysf8qsGSSuBehIDZl2cVeZN07AuTuNRRtfpBg+/MDjm4bqiwypJoZvyQVVUTueFyIixNoI6o1N7LK6PwzazkmkPRI8VGI1E0ySQZzvlQxjS3+ZljUMWlt6uz94OKncy5GRFtcT7NTZCzuacFSuB8JGGbsDerI/v3kYDPirk775GKAom1ou5F42atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsXcO30q7ayW2RMreGdU9Jk7uVGbRijm27yaI8tJk8U=;
 b=nMqsoILQdLeCF5dfaXvhhtmqG7jL9EFJqQpe1D7cDgZvcCmmPJ9FhjzUQ8FfgXqdkdk6x0HYT6mxnlwdwFxzNHLIUKeI4VOe+rCmJlKWCW6nvjYZXWOiK9orsGrUM8D3ln1PKL2DCAWQkGZHNH1YZ2cfJArk7++UvU0RhPEpZSKt7Zbg0dIYY0IyRYTrpP3xriNWK0Rd/Glpb9N62gVD8l0NevGwasYlIcgNKBsnqFCYP8TEJuF9nJNxvcfZsbFyT6p6lms5ww1jGVI/7NmPVFO2PgtyFLJZTgnSUGJAn8KJwIPLEO31TKhCVFlfFb3aP0BN4Yx0f+lh5HXagvr+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsXcO30q7ayW2RMreGdU9Jk7uVGbRijm27yaI8tJk8U=;
 b=2c7naQZyZyhrTq21zcwPRvVlJMuMu93PUbOi8tCaBs5XpXPCjrdpHde8UOwB5P7hXDHTyyQdL/GRtpwp+xXNgWsr4RTBpE3AuGn5MIOi+XlZhoJ2Cc9a9Ae/6dx2udbv8MvEWoXrUBzKQpGIf4OIHv49FhVdIErN3bdl/GwtrJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:23:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:23:36 +0000
Message-ID: <03788e07-8f4a-43ca-b455-d852546f0988@amd.com>
Date: Mon, 12 Jan 2026 16:53:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix issue of missing '*' on pp_dpm_xxx nodes
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20260112101247.2654442-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260112101247.2654442-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: e108e683-51b9-4ecc-cd0f-08de51cd070b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T25lcUgycTd0RWwwY0xtVnBNZmpnQ0hoRmZjNHE4UEVDV2FxZGhIZGRFaHFF?=
 =?utf-8?B?VXpYenJOUTZSelhBZlRKTFpZbFN0NlNuejZYNVlzNjVidDhSOHJvSElzUjR1?=
 =?utf-8?B?NGdlTUFWR3UzN0M3d1NQMU13UVRYdmQ2YkY0T05KVG0xR2Q3R09ZYmNwSURB?=
 =?utf-8?B?dGc0Mk1IOHlNWjM3YU9LLzF0c3dGWk55VXNyWklISllRK1JTYVhjaEIxRExn?=
 =?utf-8?B?TlJRcTNsMndWdEI0ZXNIWndiNktNeFBSR3o5VWpmL0dGdU5wR0M0d0VRM1Vq?=
 =?utf-8?B?R296bW41bHRwbW9GUlBqMU45cW1Zc1g2Vy9TbFExSzJmME4wRzFYbENLNjlR?=
 =?utf-8?B?dmNFVDVCUDhRdFVkdWxFWUdtZXNKZjNpOUlWakgzTWlJT3BGdnJWOUFOS3Q4?=
 =?utf-8?B?SzRyamtMK1IvUHdzbFVoNnpOeERVRHgwRmFtT2N1N1dVVFoxaTJQZXRQdk02?=
 =?utf-8?B?OXV0RVhBeU9uN2Z0WVUyd3VDWGNJOVh2QmFobzZ5RGRLR1dwWk56bXNha2lJ?=
 =?utf-8?B?VU5SZ0xHWGdpWCt1Vkc0TjNmWnU5YnN3TzNyZ0I1aVdmaUZrbW1oK01QVUVw?=
 =?utf-8?B?RHQyZkpPdE1DSC92N2NPM1I4WllEczFURWRKOWVRZE9lVm95QWdoMXM5WTBQ?=
 =?utf-8?B?bXFDVytUOWNHUVRDeXRFMWJPNzk0cWhSbHQ1ZncrU01KMnh4cnl6dzFGbjZx?=
 =?utf-8?B?UUJQSFNVRkptRkdCMmFhY2JYNkpySTJIU2JDWnZmVkhma3BOSkU4Y09sRmtI?=
 =?utf-8?B?ZlYwNks2MGR3VlZvaDZCbUtHZEovY3h0d3ZQTUFLM0phcmpVekhTbkRCVEpj?=
 =?utf-8?B?QThuQVg5UE9oQ2UvZ2ZxdFh4WFpZTlMwWCszMnZUM0MzZnNoTFFHbWsxbTkz?=
 =?utf-8?B?T1VLZmt3TFE1bnhuNVBXOTQvQXN3MHFqelgzRUwzZ1MvQU9YUStkaVZWQlNV?=
 =?utf-8?B?YVlVRjNnZkFNTmFNWW1CVWxLZHJwWHRtbGdabHAvN053L0dMWC9HT21CWTJn?=
 =?utf-8?B?VU5VQVE1cm5oK0VZUUp1cG12SlhTMlFsVjQ1N1RHYjNjZHBDdE9kdmVidFQ1?=
 =?utf-8?B?cHJQK05BNEZNaS9tK0ZBdUNJcWxKdlVSdWFKdkEzU1d4WGVYQThqRnlJaVFs?=
 =?utf-8?B?SjQ2V3ZZeDR5UHNCeGNUdGpGcVNac2YxSmlNNW9LZEpMRmIzVEJXUTN4UHNp?=
 =?utf-8?B?RXJCQll3VzBCWWwzUFMwSWVGeGNmWllWMmFaM1h4RXdQcHBHNTkvMU1vKzJq?=
 =?utf-8?B?MHRZZGdrYTY3M09PSGtMT2RSR1VWemFrZHVjM2tFRkphb1BoSndRamdDNU9N?=
 =?utf-8?B?SGFXU0dYT0hMakZ1SklzOG9HWXFVc1RHVURhR0ZaYVMyaERHQ3liTFV3Y255?=
 =?utf-8?B?MWZrT0lBZG5na3pBMkZJblhBUUEraUNGOE9vbVdReVMzb29laU1tUW5adUdY?=
 =?utf-8?B?NHI5ZDROT0xVdE02Q2VzbXJHN0U1czJSR3RUTTN0d2xickh4RC9mQkgvdGNO?=
 =?utf-8?B?eUFUYWVQQ3JGVXdWeFMyVUxlSVpWMFFTTG5IRDFQL3hlTUs1MzZra1hXVThJ?=
 =?utf-8?B?a3dtRjM3anVqTHlSYWppWTNDV25TQk83L3BBc0dEeDF6cWtsRmJXQlAvb2wz?=
 =?utf-8?B?YnJqWVUvc01sblREeGVWR2RmZXZIZWJMYzNXLysvQlpqYXZpdkFVcEZsOFhX?=
 =?utf-8?B?bkQrenlIcWJYSUtXc29JckJiQnpVTU9CanJ0akdCTVZueVI1bmppR0loQ29W?=
 =?utf-8?B?QnFJMW5YYTFRZ0FwalVzVkh0a0x1VkI0cGhSSUkrZEd6VlhzUjhmemo2b3dB?=
 =?utf-8?B?R0pWdWcxK2dUd1ZLa2pHSG0vd0tiZzNSbk9ISUlLWDFXTEQrY1k1SjZ0OVZS?=
 =?utf-8?B?ODBoazUxdkRyZ2g3YmVBc2N0SUVVTnhSL0xCUWpqWHpaK0dTbkorUjRHaFFa?=
 =?utf-8?Q?QyFEQqo4tZ3pEuroM8f1LP6bCS9cmnKl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm5pMGhNbkMxMDRnMlh5R1A5ajRYZlBMdVBnbG5zWmxXV0ExNDZiT3JNY09m?=
 =?utf-8?B?cE9HVW9vVnQzTzVLeEZ5cG5qMFVXckRtOHFQK2hSTUVUdXdUZ2JsUDJMS1FE?=
 =?utf-8?B?anh3UUs5Mll6N1JNM2twM1JRenpVemtXeEFucGI2U1dpQ0hIcFcxUFpGYnBQ?=
 =?utf-8?B?OEhFMnNPMU1NY1JYN2FFemwzV3VlYklqM2V0Z1owWTI5Q1hKdHhmL0pqd2g4?=
 =?utf-8?B?YWRwRitlUS9PbkNXZWU4VERRK1hWOVdvTGVWK0pTVlFQL3NFMGY3SFkrMzR4?=
 =?utf-8?B?NitZSEdnbDVnSXdHaGk4YzdoTmdrQ2lwWGxOVG1INndwN081Z0twYVVPWGFJ?=
 =?utf-8?B?ckI0aVpKVGl0R2REMHVrQktKWVlqZ1VDK1V1SWhuVHNZV2g5QkFQRW51TXpq?=
 =?utf-8?B?OHZOTkJYem9JRGNQaWNHMS9UMEFGUVRZV0NiZGVIT2s2WmZVOU9Ia3NCbmlC?=
 =?utf-8?B?MVJhREQyRmhkbmZuS1U1WXBRVHFCbkRpM2tXbHc0V0FDS0NRUFJhN1gxUTBI?=
 =?utf-8?B?YkR5RlJ5YmxDcm4ydXBVV3AvUWlHZFZHejBTbVphZ1ppWDRlY01tb1pOMjNx?=
 =?utf-8?B?U0lsVzlBVVFwdXlRVWhPaGlDZ3VQTGd4dnhueEhUSDlwRDNjRGtIV1VFTnFM?=
 =?utf-8?B?V3o5QWN3aU04emdJWlJTS3pTSm52b1k0SGErUE94dERUWkh0YWRZeTQvS0Rw?=
 =?utf-8?B?RXJpUXYwYWFaVXdZOUFTWmduY3ErVzlLSWNlcVo1UUdUYlhYZ1RJTnA3UmRZ?=
 =?utf-8?B?N2tnQ0lJNXNtQnpmS0t0c0ExT09GbjA2K2h6UkJ5ZndjSk9jTE03Y3R1OEtK?=
 =?utf-8?B?bndJN1hzV2RYbk1nT0Irek03UFFERXg2OEhMVWZSOFF3cG1qNTVtSGNHTDNn?=
 =?utf-8?B?WFpvb25teEcrbWU0ckh4cXQwZ3JYWDA2K0h0b291YlFFWEF6bytPTWNad1By?=
 =?utf-8?B?aFFyZytLYzFHcHZUV3BiNXJUYk9KT2ROOUQ3WXVoL3dLajYzTU9oT3l1ZVFF?=
 =?utf-8?B?Q1FqQWNEWFNDV0cwK096bDc3RDd3c0dHZVA3UEpXbWQxaHhaeU5RZGkyYXNN?=
 =?utf-8?B?UmNtc2dGRVRxbzNoSENNd0YrV1Rmejk1WHJWN3N1UmhINm1IZ043TjQ3cWI5?=
 =?utf-8?B?RUpwNkNxdWIrNkYwbmp2dHY5ZnVJY29Pb3IxVHBKbkh3RWFXZFB2MkhZd2VG?=
 =?utf-8?B?L2UyVy9SQUpRWDZ4b250akt5cjFGaTgvUmpwTThmajBCVUxma3lwcjEwK0dk?=
 =?utf-8?B?N1BSOVJDTmZlcEpBQjYzWEQzQXlsQUVxdkFWZXJpSGJkVktWUjBMQkJDSXVH?=
 =?utf-8?B?OTE3eDNnTnJINFVkbVVicjBnK09tSjhGTFdvV1RJVnh5QThiVkZleE5MMXF6?=
 =?utf-8?B?UTJ2cWRWNVkwUk56N1NDQUdJL2JJb2E2dDdyeUIyL3FpeitJRFF2NzVsbm1Y?=
 =?utf-8?B?bXViL1V0bjQ3cEg1emNKWUFMSkN6TVdqaVBJRU1wcytMamZkVFdSZUZyU0M5?=
 =?utf-8?B?VVRCKzBHZjNlMm16b2dKbmhEbUdsWGYrdmE5Tm84c24veURhRE9sSyt4ZGVX?=
 =?utf-8?B?eXk4bnN1QU0yYkpLSWZlSWlhVjRCcWNqVE9zYzdnSFZtVmZOcGZId2QrRUtu?=
 =?utf-8?B?c2xwcjJjMVJWWDcxS0dGdTBES0UxeHJHODlBN2Q5Tk1ySUJoWm1KWXZPS0hs?=
 =?utf-8?B?ZDZ1WnA4Qzg2TTBWVWVwcDNKS0xZZFE4YUxZUStMekVLM3V3TWtMZmlJWGQ5?=
 =?utf-8?B?MmdxUWR1WE8ycGlmNllwak8rcDU2R0wzRWE2THJQOVgwdG9aVFJwbEtSOGZy?=
 =?utf-8?B?R3g2OC9leW1QRmxlOTBFWnIzVkxralNOYVJJcVJreW1RRVcxM0lzTXltazlk?=
 =?utf-8?B?dlE1RGpPZHpQeGxkdHpYalNYUkczdTFVWU56Ujd0elFIZm55Wm80STlKcVdQ?=
 =?utf-8?B?UkNPZ0xoR1lJUGpTWWQ1YTM2aHlLQldxT0xaODlmblAvNXd1Z0FSWlhJQmpK?=
 =?utf-8?B?M1c3NzEvNFM5RU16RDVoQnNQUnBGWjBTOGpKYWFBbUU5T21lZG9nVGVZS2pJ?=
 =?utf-8?B?eG8wTk1xQ09QeFZXRGZ5VTB3a3lHUWNRQUpkUnlWV2h2alc0eE1vZUsvZ2Fw?=
 =?utf-8?B?ZHErSHpTRlRjQ2crQS91bFhYMTdBdzRXbmFvbXVsdldWNjBDYjE2M2JuaWVa?=
 =?utf-8?B?Yk40TGp6U0piRk5KVzIxV2pOT0xJZFBnTFlFdUpkb3ZPcnlpNFBqeDY1dlRT?=
 =?utf-8?B?RzJIYk45eExrNFdBZ3huMXFmdnhCYTVqU1M2Zm41YVdPaERlNUt4dVIxWGJN?=
 =?utf-8?Q?w3IMi/OZhEAQKT6hwF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e108e683-51b9-4ecc-cd0f-08de51cd070b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:23:36.5462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5BOScIR6neMEU2gzV3xN0c9A9UlVhWTKslf/fLDGNVF4ftTnCgCSgzcll885ZFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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



On 12-Jan-26 3:42 PM, Yang Wang wrote:
> refine the code to fix '*' missing on pp_dpm_xxx series node.
> 
> e.g.: missing '*' on navi10 pp_dpm_sclk
> $ cat /sys/class/drm/card0/device/pp_dpm_sclk
> 0: 300Mhz
> 1: 1930Mhz (the symbol of '*' is missing)
> 
> Fixes: d259c895d622 ("drm/amd/pm: Add a helper to show dpm table")

This fix doesn't look related. Could you also add the sample values 
under which the existing logic fails?

Thanks,
Lijo

> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 31 +++++++++++++-------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index e0a508653b6a..60fc730bf81d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1210,11 +1210,11 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   				 struct smu_dpm_table *dpm_table,
>   				 uint32_t cur_clk, char *buf, int *offset)
>   {
> -	uint32_t min_clk, level_index, count;
> -	uint32_t freq_values[3] = { 0 };
> +	uint32_t min_clk, max_clk, level_index, count;
> +	uint32_t freq_values[3];
> +	int size, lvl, i;
>   	bool is_fine_grained;
>   	bool is_deep_sleep;
> -	int size, lvl, i;
>   	bool freq_match;
>   
>   	if (!dpm_table || !buf)
> @@ -1225,6 +1225,7 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   	count = dpm_table->count;
>   	is_fine_grained = dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED;
>   	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
> +	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
>   
>   	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
>   	is_deep_sleep = cur_clk < min_clk / 2;
> @@ -1245,22 +1246,22 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   					      freq_match ? "*" : "");
>   		}
>   	} else {
> +		count = 2;
>   		freq_values[0] = min_clk;
> -		freq_values[2] = SMU_DPM_TABLE_MAX(dpm_table);
> -		freq_values[1] = cur_clk;
> +		freq_values[1] = max_clk;
>   
> -		lvl = -1;
>   		if (!is_deep_sleep) {
> -			lvl = 1;
> -			if (smu_cmn_freqs_match(cur_clk, freq_values[0]))
> +			if (smu_cmn_freqs_match(cur_clk, min_clk)) {
>   				lvl = 0;
> -			else if (smu_cmn_freqs_match(cur_clk, freq_values[2]))
> -				lvl = 2;
> -		}
> -		count = 3;
> -		if (lvl != 1) {
> -			count = 2;
> -			freq_values[1] = freq_values[2];
> +			} else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
> +				lvl = 1;
> +			} else {
> +				/* NOTE: use index '1' to show current clock value */
> +				lvl = 1;
> +				count = 3;
> +				freq_values[1] = cur_clk;
> +				freq_values[2] = max_clk;
> +			}
>   		}
>   
>   		for (i = 0; i < count; i++) {

