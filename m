Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD72D116E0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776CA10E9E9;
	Fri, 25 Oct 2024 02:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e/cmAwQW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC3A10E9E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz4fykP4n8JhaKHQ+NZenlFxKYhx8vdJlmDsAP6Rm05sPqYET0m9U+eXwXr+NOd2fdU6QdoO/FeSSqXCEXNNrmhgghIQjAvWTRVQkdlgTCVxP3zoQ+P8rJZ+BrcPdvzckWmuI0PYoSPBrXwTPRHB+QoJ6c/X7wP+Cng9BQ6f1TtCgjC2S9fRHli5WYqOLnKBEmzlgbUe5Avi90/XrPeWJWfR2fxNTl8s2ZNXF/3r8t2jWc9hyhHWa3PyqFvMKNduzOTFqZilRdSyC4Xur7wYydKZf1ncGrhp9Q83RBBTVEzPaOBb/d1ttGxAtsBwDay0WRa0AbIs2j280G0VShXtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObMPLPdlXUP94jStoG6M7iUL20xJeOLGxLVXAITL5HQ=;
 b=VCCrJTXGD0LZS0OgDkNxFa7W0eB5j6UNVhX0xYUEhIAoM0MY0BWAQthsIUTWufW1dsqJ2z8iCeGZZhNTBJnqfn54Zxz6JoJVNETWtnmxkB+MIEIaL5G8/zpXXxQc3Guqqa6t3M9SJvBUvE+WSZ6BAm9JAvEJDkxCqrU0HvZmPqubjdG9u7TK8FzNrhW2bF5+cqYFLZQD67Iutl4kGi06p3GJzI5SjJbRihPm9WLerBN0bVVgUw+sqPPJ5zoVZ2+0GvgG050hRmNG+MMzZdMuQazHmzPEUyshYMR397foFBYLimbaQ101IxAvF0zYmWIGSCMb/D6nUynPWeD7mZOiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObMPLPdlXUP94jStoG6M7iUL20xJeOLGxLVXAITL5HQ=;
 b=e/cmAwQWffAdoNIkvqhXWvcAVH/0nicR937zm6D7n2m8O4iLBqpHwKU2qa7QU7GlEcBZQ5c86MNGJVFflfiAynVjfTTcF6WqD4oa1LEzQFwQC788k4D+e9eEekN8WICmTD/BhNVwxwOE34Cp4qr7MbK+S5UHeCbj/SJrplfvg3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:53:54 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 02:53:53 +0000
Message-ID: <bf4da5e4-6df7-4e3a-b4f9-857a91b94b84@amd.com>
Date: Thu, 24 Oct 2024 22:53:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] Separating vcn power management by instance
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com, alexander.deucher@amd.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
 <f8811d12-bb61-4a7c-9d85-2a5e7d98ccc0@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <f8811d12-bb61-4a7c-9d85-2a5e7d98ccc0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::26) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c27637-8f90-433d-1f0c-08dcf4a042f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFFNaE9YM2p1UTNWR0paZkU1Q25jYXlYOEJWM1J0dGg2YTFqQ2JEVWRmRFlI?=
 =?utf-8?B?SW13OXlJa3g5L0lsWW1TZlUrbGNXQmd6YWNhQjVLZFd2dXJFSnRFZHJReS9L?=
 =?utf-8?B?YVZOQWV5enJrNGtuNVgyRG5YNDVxYUZ3YnQ4bU9OMjY0L1lhaEw0QTdSTjhW?=
 =?utf-8?B?cVFSSFJPc3psS3l0aHBXalRrcVBNckZPTXkvcTlnc2lYVlV1YndhVmVuZEFC?=
 =?utf-8?B?ZE44bi9VU3hDMHY3QVVpaWlhTFdjeFBGOGJ0bWJkS2FJYWsrYVg4K3VpUUNG?=
 =?utf-8?B?a2QwWnhPUXREYmpjZm8xU1JOaDM1cHFIZEpHcjl4VFo2bUs2akZNaHZLM1Vs?=
 =?utf-8?B?dS9oWnhuWHI0RXlaejVBSEJPaVBpL1Y4c3UzUStIZE8wQ25UM0NqVzRoa1RC?=
 =?utf-8?B?dHQ3LytINkNRemlpK25teGpJTG9WKzEvaUdUM2tpQ3hNanJBclN4UzdOQ0Zw?=
 =?utf-8?B?dThBbUlIMWhLNXhzU0tpRW1ORFJtVEFMbEU4TGNXQ2ovdU5nYjNqMWppd3F1?=
 =?utf-8?B?U29IRUpnTjhYRE1uZ1E5YTk4bVBtMThmaEE4YzFsZkF0L2hsdENyMFZ1VUk4?=
 =?utf-8?B?NDRLOGhuaVRPeEU3aFpQa1N2ZTdwRnp1UTdwU3lDSUhRamZkbFdraEVMMUV5?=
 =?utf-8?B?VlNMbGJ5bzRPUnlZT1dTS0c3cVI0anZVWi8wT3RiekZXQjZoaUZ3TGtEbG1R?=
 =?utf-8?B?OERWdjc3cjc1UHo0TEJzbkdZTFhycURQSE9TLzdjc2NNelJhajBTU3FFd0hr?=
 =?utf-8?B?S29rZXZFUUJBTGVic3hZMEZKaWgyTDYyYUNEa0ZWOEtFUUcxNmlQclkzckQ1?=
 =?utf-8?B?OHZleHdHN0dIbW1wRkpabUtmdnZrUlM3RnVmckVsaWRtaW04cVR0OUlMWjNh?=
 =?utf-8?B?REZ4dkZpRFFBU1ZuRTFNZlZQbHBCcjgzdTMvdUxkM1pPcmk5aE8yTlhPS2Nl?=
 =?utf-8?B?MHh1MmhsYm91NXVJVDI3YkMzZGZDclRZbDRobGt0RHdyQ1RnU2ZWdk0vNHJq?=
 =?utf-8?B?akg0Wi9VZmJaTTJNWExBMWtiV2h1bzlFQTl0NURsQjRFeFR2NXRXVzFUUFZ5?=
 =?utf-8?B?ajBveVhpYlUvSk8vbHErcmk4bUNJcFF6YUcvc2RBdmpNdjJHNHlTL3VqSndX?=
 =?utf-8?B?UkFaak94UHlzK2I0d3YxTXp1dlB5YjJ3bzJYa2NmaFBobEtUSUJVbzNGSmQy?=
 =?utf-8?B?US9hRDNJemx1QW93Y1dEL3JNK2Q3VE92alUvck80SFkxdG5CYzVENHZ0ZGFj?=
 =?utf-8?B?aC9QbmhsOTBlSE1vUWs2djV3MCtDVFhLRkFuT2E5MUtLRnUwZ0FMbFRna0Zl?=
 =?utf-8?B?ZnRSYUZJbFJPZENVcCtESWd5b1VaRHBxQXpiY05JYTZDV2tkemtaSjhTNjVI?=
 =?utf-8?B?cldRR2NhMzAwN2doRGphSFU3Vmt1aUpqN3g0eUVrSUhWbm5hOTZySTZXSSto?=
 =?utf-8?B?cGVxaVJLZHF1OGVDc3dyQXI2WWltcnA1ekdBaEx4NStES2ZobVdjdnl5SkxM?=
 =?utf-8?B?dG50Q1BFSlkyRk9LcDVGcmoxekFONVhWZDMyK2hXSnV0OFJBdmtSZ2syU2tX?=
 =?utf-8?B?aU5HUk5rZ3QxZFNHaVpWY2ZnS1A4YTJhK1hiejNidzU4K0JuVkxlWXVDaURu?=
 =?utf-8?B?NmhsWlNxcURJRGhVa3hnTFdkS01vanZpdGlRcnpoWXVsWTIyY1RyZVlyL0FU?=
 =?utf-8?B?SldNNm5rZlRrTW5pc3lQZTZMN3Niandac2gwbjZKY3N0RER5L0FhTFdBRUVK?=
 =?utf-8?Q?8EYQ4J19PsIkhjin971elZ18NKShEFtaUlGPiJc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTNCU2tsRzgwNmRkeW8zVThoZmRiSm1oMUNOZ1RGOCt4enp6VmVTSnEySkho?=
 =?utf-8?B?dEt5S2VOaFNoblVZV1hleE12b2VKWXVSZC9UTnB1cVlaZDNNT1JTZUlEMnRl?=
 =?utf-8?B?WFNGRml1U0wzNCsyV25hNTJLcUdza2dXZW45REh6MEJzL0IwbkxaeWVSZU5X?=
 =?utf-8?B?cGxVT3c4aTM1YllCVEtzYTNjWEk5aEV2T0h4cnAyUW53emVTWlVqem81eCs5?=
 =?utf-8?B?UWoyQ2J6RkV5OGZHbWV4b09TSjZQVHFpWmYrbEU3K2lDNGZKME10eG5KU2ZD?=
 =?utf-8?B?MDJiMXMvYnZsc3RwcHZYNk5OTXVYdGtmOWdTV2NsU0ZmMEw5YmdhVmhGaTRj?=
 =?utf-8?B?NlpScGMwckFpN1IvRTdaOHlEcWxjeE1oVjFDTHRjVlZxU21tSHppUmY2RWhl?=
 =?utf-8?B?Y2RxODdQR0J2V0hwYldxZ1ZNYWVWN3V0cFJjV1VyU2o1bUJVM1R0TENPVTVx?=
 =?utf-8?B?MWt5ZUtoME1pQUNtdEFjR1Q3ckwxQW1EaFk0WDhDUW1CVHhBWkF5OVB0RWZa?=
 =?utf-8?B?QUkyVUloQzUwdUt5NXY0NWk4S0RpVzhpUFJ3enNvNXRmVnlSOC9mREUrWHh1?=
 =?utf-8?B?R05wY0dXL3B2bUE5eVkwMURaWmJUdGhRQk9oWG1ZNllkdS9tMUU1Tk5KaitD?=
 =?utf-8?B?SW4rNHVwQ0JKT2xvUjhZY05hcS9mOW8rWmtRcUNtSVJ3Q1hVcU9zWEpGSEZn?=
 =?utf-8?B?cXdCRW1oVkkyb0lZc005SHUzemZIejlJbFR5TzdDN2dTRVNtY2s2RzRrMmFD?=
 =?utf-8?B?aGVKQTdHK0pQUjd4Z1htSWduMFJtWlJVNUJqQzh4SmxPek9BOThDS3Y1M0Rl?=
 =?utf-8?B?UG1VeVpDUlNiTi9LcStkU1YxVTBnUWhrUHdGeTd0NjNLVHZMVzV0MGZlRjB0?=
 =?utf-8?B?UVFIY2JReXAwS2pPSTFXTUJYSjBCdXFqQmN4b3A3UU1lcTBlMStPM3gzZ2dU?=
 =?utf-8?B?WExMVEVNV1FodDd2TGt4WGtVeFkrckwySHp0RmhTY3JuaVp6T1dKYmlOcWhv?=
 =?utf-8?B?OUgrWUJPZ1ZFZnoxOStIcmpBTTgxYVk1SUJyWjloSHNRdUZLV1Z4NnpudXB4?=
 =?utf-8?B?ZlFuWW4xSlhzd0huUFI1N3RUQ2pTcVlOS3Y0eHJWZmpabGxaTUVGU1ZoVUUw?=
 =?utf-8?B?TnNWc3BUVVpQWTVBaTBCQytOZ1hBb2V0a2xqQnIybTNGRVh2UGppSVV5UFBX?=
 =?utf-8?B?bTdYL2IzUFJZWC9scWt5RlZBeUhIVmVhOTM0SjdQS2NzTWJaZ3Q3cWxlYzRh?=
 =?utf-8?B?YU9lYktEdTV4c3RiMTJOcVNHT2JOL0Qzc3VWQ0ZrZDJQTDVPWVl3clNhWEYw?=
 =?utf-8?B?NlNqdnRrbnpsM25hUlRsMWZaZjJsRGhPR1JQNTNOSVIvMFp6ZXFLa1hVN1Az?=
 =?utf-8?B?RStpREczQkEveGdaUm9tVDAyODF4SWJHOSthS1lVZmtTZklsaEhKY1JZRDJP?=
 =?utf-8?B?WVZPLzNSeFRJbG5vbW1haTFQZlk2ZWdQNlJ0U0lpTVdBc2JYZVhhVk9LSk0w?=
 =?utf-8?B?RTVVU3lPelgvTnJRazN0d2ROQWdYZTA4OU5uamJERnNpQ3BuQjk5OUVueEdw?=
 =?utf-8?B?V2xHcFVTMDgyTEpIVmxCeGpmbXo5c013TzdJTk5GTy8vVXlzb0ROVXAyc3lP?=
 =?utf-8?B?dWZPRXcvV29XYzBpUEhBWjZuZjhadUFUUG4rM2ZkSmx6NzdPb0o3aE1VSTlF?=
 =?utf-8?B?UlgrNDV0amMrWHBIRU4wc2hjazBIZWdZalJ1djRMT1prY0VMVHlmQlBBS2Jn?=
 =?utf-8?B?WGdJKzRvM1dHNGJFV2RFYWRnVVc5UGdzQUZPT0hvN21Ucm9HZ2RlZjY1VjBr?=
 =?utf-8?B?VXQ0Qy92cjFzSXFzZWlBQStBcVFTZ2RHVStUN3pqbFBMcmpjbUltbThuVHRG?=
 =?utf-8?B?N0ZuK3ZUeFBRNlViWjJERUk5ZWlqd0xzL092WEMvMzJwdmpXNytSYkFzL0VP?=
 =?utf-8?B?Qk5FRFgxWGhZQWlNK0M3bXAyZk5IUCtXLzAvR3R3MjVvM21lamhUdUF0Ynly?=
 =?utf-8?B?Nkc4d094L0FSbnMzRUg2OFRiMlhVQy9JbkJ4ZlpXdHlGblNTNlplMThtSWd1?=
 =?utf-8?B?TitmYmwya2JNZUEwcG1abVBjZGw5NkZQVWZsRnJFQkc5WUp4dzJ6RFVoV3pG?=
 =?utf-8?Q?vf46e4wg/+Cxysjfo0bDBv0BK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c27637-8f90-433d-1f0c-08dcf4a042f6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:53:53.7940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auxj1Nt9TN0yWI/pOn4k8vEpB8FdagDAUBzjlOenLbe3M5pkhSe5rFhTUa096Yq+nDyTywzPrg6oT0nXk8FSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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


On 2024-10-22 02:25, Christian König wrote:
> Patches #1-#5, #7, #8, #32 are Acked-by: Christian König 
> <christian.koenig@amd.com>


Added Acked-by, and ready to be submitted.


>
> Patches #9 - #19, #27 are Reviewed-by: Christian König 
> <christian.koenig@amd.com>


Added Reviewed-by, and ready to be submitted.


>
> Patch #6 the drm/amdgpu prefix is missing from the subject line, apart 
> from that the patch is Reviewed-by: Christian König 
> <christian.koenig@amd.com>


Fixed in new patch-set just submitted (patch 06/29), and added Reviewed-by.


>
> For patches #20-#26 I'm not sure if those won't break the driver in 
> between. Alex what do you think?


Need Alex's input.


>
> Patches #28 and #29 look good to me as well, but I leave the review to 
> Sunil he wrote that code and should know it best.


Patches #28 and #29 has been dropped in the new patch set based on 
discussion with Sunil, will be submitted later on once his work is done.


>
> Patch #30:
>
> +    int ret = 0;
>
> ...
> +    ret = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE,
>
>
> That will get you a warning for an unneeded local variable 
> initialization from the automated checkers.
>
> The init was only necessary because we previously had the loop over 
> all instances here.


Fixed in new patch-set just submitted (patch 28/29)


>
> Patch #31:
>
> int inst = ip_block->instance;
> int ret = 1;
>
> if (adev->vcn.harvest_config & (1 << inst))
>     return ret;
>
> ret &= (RREG32_SOC15(VCN, inst, mmUVD_STATUS) == UVD_STATUS__IDLE);
>
> return ret;
>
> That code looks really strange now, maybe drop the local variable ret.


Patch #31 has been dropped in the new patch set based on discussion with 
Sunil, will be submitted later on once his work is done.


>
> Regards,
> Christian
>
> Am 17.10.24 um 15:20 schrieb boyuan.zhang@amd.com:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Previously, all vcn instance will be powered on/off at the same time
>> even only one of the instance requests power status change. This 
>> patch set
>> enables vcn to ONLY power on/off the instance that requires power status
>> change. Other vcn instances will remain the original power status.
>>
>> v4:
>> code polishing and minor fixes.
>>
>> v3:
>> move all of the per instance variables from struct amdgpu_vcn to
>> struct amdgpu_vcn_inst. (patch 10 - 11)
>>
>> update amdgpu_device_ip_set_powergating_state() to take the instance 
>> as a
>> new parameter, remove the duplicated function in v2. (patch 19)
>>
>> update all amdgpu_vcn_* helpers to handle vcn instance. All functions
>> are now only handle the given vcn instance. (patch 20 - 26)
>>
>> update all vcn ip callback functions to handle vcn instance. All 
>> functions
>> are now only handle the given vcn instance. (patch 27 - 32)
>>
>>
>> v2:
>> complete re-work for all PM changes as suggested-by Christian König and
>> Alex Deucher. Adding instance to all existing functions, instead of 
>> create
>> new functions. Remove all duplicated PM functions in previous patch set.
>> Use a new logic to track instance for ip_block with same type as
>> suggested by Alex. Also, fix wrong ip block index and remove 
>> redundant logic
>> suggested by Christian. Finally rebase all patches based on Sunil's 
>> ip block
>> changes.
>>
>> Patch 1-6 are SMU changes to only power ON/OFF given VCN instance.
>>
>> Patch 7-8 pass ip_block instead of adev pointer for 
>> set_powergating_state,
>> set_clockgating_state, and is_idle
>>
>> Patch 9 is to track VCN instance in VCN ip_block.
>>
>> Patch 10 move all of the per instance variables from struct 
>> amdgpu_vcn to
>> struct amdgpu_vcn_inst.
>>
>> Patch 11  VCN change to separate gating status for each VCN instance.
>>
>> Patch 12-17 are to handle ip callback functions separately for each
>> VCN instance, so that only the given instance will be powered on/off.
>>
>> Patch 18 is VCN change to handle idle work separately for each VCN 
>> instance.
>>
>> Patch 19 is to set powergating state by VCN instance in amdgpu_vcn.
>>
>> Patch 20-26 update all amdgpu_vcn_* helpers to handle vcn instance. 
>> All functions
>> are now only handle the given vcn instance.
>>
>> Patch 27-32 update all vcn ip callback functions to handle vcn 
>> instance. All functions
>> are now only handle the given vcn instance.
>>
>> Boyuan Zhang (32):
>>    drm/amd/pm: add inst to dpm_set_vcn_enable
>>    drm/amd/pm: power up or down vcn by instance
>>    drm/amd/pm: add inst to smu_dpm_set_vcn_enable
>>    drm/amd/pm: add inst to set_powergating_by_smu
>>    drm/amd/pm: add inst to dpm_set_powergating_by_smu
>>    add inst to amdgpu_dpm_enable_vcn
>>    drm/amdgpu: pass ip_block in set_powergating_state
>>    drm/amdgpu: pass ip_block in set_clockgating_state
>>    drm/amdgpu: track instances of the same IP block
>>    drm/amdgpu: move per inst variables to amdgpu_vcn_inst
>>    drm/amdgpu/vcn: separate gating state by instance
>>    drm/amdgpu: power vcn 2_5 by instance
>>    drm/amdgpu: power vcn 3_0 by instance
>>    drm/amdgpu: power vcn 4_0 by instance
>>    drm/amdgpu: power vcn 4_0_3 by instance
>>    drm/amdgpu: power vcn 4_0_5 by instance
>>    drm/amdgpu: power vcn 5_0_0 by instance
>>    drm/amdgpu/vcn: separate idle work by instance
>>    drm/amdgpu: set powergating state by vcn instance
>>    drm/amdgpu: early_init for each vcn instance
>>    drm/amdgpu: sw_init for each vcn instance
>>    drm/amdgpu: sw_fini for each vcn instance
>>    drm/amdgpu: hw_init for each vcn instance
>>    drm/amdgpu: suspend for each vcn instance
>>    drm/amdgpu: resume for each vcn instance
>>    drm/amdgpu: setup_ucode for each vcn instance
>>    drm/amdgpu: set funcs for each vcn instance
>>    drm/amdgpu: print_ip_state for each vcn instance
>>    drm/amdgpu: dump_ip_state for each vcn instance
>>    drm/amdgpu: wait_for_idle for each vcn instance
>>    drm/amdgpu: is_idle for each vcn instance
>>    drm/amdgpu: set_powergating for each vcn instance
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   22 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |    5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   41 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   24 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |    4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  338 +++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   24 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   14 +-
>>   drivers/gpu/drm/amd/amdgpu/cik.c              |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   16 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   12 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   12 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   14 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   12 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   16 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   14 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   12 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   20 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   20 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   20 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   20 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   18 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   20 +-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   20 +-
>>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |    2 +-
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/nv.c               |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   16 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   14 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/si.c               |    6 +-
>>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   14 +-
>>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/soc15.c            |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/soc21.c            |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/soc24.c            |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   10 +-
>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   14 +-
>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   23 +-
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   25 +-
>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    4 +-
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   16 +-
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   20 +-
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   12 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  140 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  124 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1154 ++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  909 +++++++------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  801 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  727 +++++------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  782 ++++++-----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  690 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |    8 +-
>>   drivers/gpu/drm/amd/amdgpu/vi.c               |    8 +-
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
>>   drivers/gpu/drm/amd/include/amd_shared.h      |    6 +-
>>   .../gpu/drm/amd/include/kgd_pp_interface.h    |    4 +-
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   55 +-
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    3 +-
>>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   18 +-
>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |    6 +-
>>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   10 +-
>>   .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
>>   .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
>>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
>>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   65 +-
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    4 +-
>>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    3 +-
>>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |    3 +-
>>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |    4 +-
>>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    4 +-
>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   24 +-
>>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |    4 +-
>>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |    4 +-
>>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   19 +-
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |    4 +-
>>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |    4 +-
>>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   38 +-
>>   112 files changed, 3442 insertions(+), 3433 deletions(-)
>>
>
