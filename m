Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7493D33994
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 15:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5B210E4E9;
	Mon, 28 Oct 2024 15:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nSL8etVn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E6710E4E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 15:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW2w8LcN4pZrrTSbVFhQVjLvgUX3GWLl8l8OjRmXIGmyamWaioJevfMCnk5295QnuQSP+zZ577B4RYWmZRENNA3mF2v+AFZ1e4iCmB/+GmaiJKBR3FHvnIKBso+yhhoxCOYihxN9E2aNrp0AUru1Mg18cpsHBonV2Mjjoc2U8hMF8X0AWU76AKW9WpSuCQAeffD7ZSUvv994k7vYUev2JznIngJjr2+e6NX4oXeMtjjj6cQFMjtjBGwbPcOcJPJ58728u2Qthgt77OMxp7f38AXSXwdlgEmXJBLUst5FVuOL6DGHpVGtS2RWpqkg4jeC2NYcMMusYmW8NfehgLJIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=for0bDfQwWaxHl+lJS213GAEoY5oHLdFphNL08enSGk=;
 b=P394zGXgWCmkAyL0H50ZZK/7aMU4Zg0M0VwIM3LHJiKrxhsl+7k4XecyWw1lecwOZI8V5B8PRTVaQUaoEdGcKKf7OYpbbpTna6iowHfQRZt+5x3EWyD70qwyAvPHjf5XQUUc+iTNgdBFoYzh+38913/NddpbrQy7PYmdACCtS2TbQQFwKZhTks4by4WyYSrZSsVI0WugqdhmLmGuIYD4+rLnbEH41lvyG/n1lqNGWyGhkJOjR/NRFh+vxPqf+l77lMY5GYfip8D8x29EK5QTej9XAVcdGS4l2Ib1Fp3ngVvvyf7H+DWg3vuPrujX5KlbLQ64yLnV6E+Ayii0atV8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=for0bDfQwWaxHl+lJS213GAEoY5oHLdFphNL08enSGk=;
 b=nSL8etVnwIctZYKvpGWd1LsAXjn0StRnt8kKRvXw/77z/5zlOQ7VSeOYrItZkSNhDgqfCG2nj8H9diNvKrsU6JymSQ0T/hOOhOYOvA9hkovQ6Yz3SKE/WgHy43YfK5rkaJOGfA3236qozmv22ckjuOEeNYG0vNUv2d2ZTlKmbJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 15:12:15 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:12:14 +0000
Message-ID: <ac3a4e54-3b67-4dd2-8f78-47cd663ed729@amd.com>
Date: Mon, 28 Oct 2024 20:42:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Use dynamic allocation for CU occupancy
 array in 'kfd_get_cu_occupancy()'
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
 <20241025024328.3657725-1-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20241025024328.3657725-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::24) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: add756ed-258b-4db2-5a64-08dcf762e72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGk5b0pyckY0WEJyeXpsL3gzdGlGTzFGVGpIb3BhaVc1SytsS1BDbzB1M3FV?=
 =?utf-8?B?TjZjdkpCL1BuMVdoclA2TXM0TjVnT3RGRWxEeFIzVXhoTzVhL1laYUtmUVpR?=
 =?utf-8?B?QklQZmFwQ1BCdGtUYjg2L21lTmlMbDd3QWtxVVdmTFE2dDJpYXplT2RwdlZm?=
 =?utf-8?B?OWZRYVRidVV6SkE5MTNobUhFRTlONDFwUy9sMXdSd3E3MVp4bDFXN1R2aVVS?=
 =?utf-8?B?a0g5eC9RTzV4dUt3dDdMZ3RUdC9MZi8vSXlxcEdmMlZBNldZWUhvTjAzK2V6?=
 =?utf-8?B?SUNEdEtrWkN1T2RzR0xpWlJORWx2UFowU2YwbFVXdGVGMUQ4RlNKeTlHWmJN?=
 =?utf-8?B?TnlLd1A4SWtOK1ZpV2Q2RVVSekJpZHdWQmlzRmRYNDJWOFZBSC9yTlpwYnZN?=
 =?utf-8?B?TEFoUUx6eDFuRWhCdDdtWWZEVlJkMlZPTVZCUzh6ay8rRUEyRERNOTBpY08w?=
 =?utf-8?B?VGs0aUMvVFNDVklPSW5ZUHAzTENHS2Z2VXB6ZUJwSEhNNUlTYm1zQXJBaG1a?=
 =?utf-8?B?Y3A4NGRrc2hTRGNnZEp3ZDk2TzRwaGY4Q1l0M2YrY3FGMmtXSFBpSXpxYmsy?=
 =?utf-8?B?Q2xCT3RUN1FVT2poUVZXVzlFancrN2M3T1dkckdxWWtUNnBTYm1DYUFybTU5?=
 =?utf-8?B?MTFocXZxUEI0QThSbHdVN0lQa2FWOFk2NFB5MU15Q0x2aE50bVdua2Rsa05h?=
 =?utf-8?B?Q01GQ2pXN3R5azVXNWJtUUoxV3NHQWlxbjBvbzFnQ0w0QnFWSEI0cFFueWZq?=
 =?utf-8?B?R0R1ZDBJR01wc2wzRCt1ZjZkMlQ4NStIcHNYZk1qZURJdGNiTVZCNXR3TzFB?=
 =?utf-8?B?NDF0TWpXTDJBL0VvQnd1MzlQQk5MR1VUSStYNS9jc1B4NUxabXloUEVZYmEv?=
 =?utf-8?B?SmNaYWIzL1Z5SkhKY3FGVnpjZmxLVUh4aWdQSVNRdXp5Z2IzbXNqaGZpY1dD?=
 =?utf-8?B?anV4bnAzZytCZXYvb2t2MHlMUXc5SzM5cFJWVWNxT1hBK2p4WCtleGZQMjFI?=
 =?utf-8?B?dlJxVXlqR3pKMkU4Q2xEUU0zVStwem5pbUNNQk9rTlc1cG5OZWwvM3hTT3h5?=
 =?utf-8?B?WVk0blY2YUZ4Nk4zU1NpbXQ4cEZJMXdWS2VRUDZUZU9IVStCTVcxR3VyY2s5?=
 =?utf-8?B?ZUZnaGlyaVE4eWhiVDZIUnRHOHZzY08xV1VrQzZnak41ZVMyakJ4c01lYUFu?=
 =?utf-8?B?OVQxeE5HbitGeHk1amM0RHN0cmpsUmhMQjNCejhGOXZ1NHlRT3EzcjZ1UDlI?=
 =?utf-8?B?V1FONjdON3NRaENSaTJZYVBZODFrUWpmK3MrRmRscUc3UXl5MWdRYU52RkpI?=
 =?utf-8?B?MHRDZWdnaGtDTmJQaGJWRnNVQTJQeDQ4bUY2VGFscnRzQkpjUVNTWm5oVDlT?=
 =?utf-8?B?S1NYejFoTm8zSDRZNHFzcWdtV0I1YStKRS8yWFp0ZWNDUzRUam9JZlhOSnlS?=
 =?utf-8?B?bnp0dCtUYU5TR0JBaitqS0xhQ056Skd0amtnbFdFcXpPeFhYMko5dFpIQmFY?=
 =?utf-8?B?ZkxmR0JqYzZRMGpLVTVrZ2Y3ZWx2M0dIWGtvRFRBT0szUzdMSlRRalZKUGxN?=
 =?utf-8?B?VVcyTnIrNmlZbTZsYitETHlkck5WTlhZNG1VVkVuc1ZvQmNMNCt2c0drSW5E?=
 =?utf-8?B?NzdZQTBvMjRISDRSYVFTSGhvMm5laURRSm1kdlU0NUVZN1JuZEV4VkxTMis0?=
 =?utf-8?B?UEQzQ0NiTlJ0MnJwckFFbVBPcGNYV2R4N1J5dUZicGt0U2E5MGswWHF6S3JC?=
 =?utf-8?Q?Isxd1HCNfL1rcQ+RTbpfCDWDfo5RlOh1QJ8oGdn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEg3Z3RKYmVaVkJBeU1IYUJXYW5LSzM3OEE4WWlZRlBlc3QxSld6SnVYVStz?=
 =?utf-8?B?N0o2elVCVnVvekd5UnRLZ0swcVNaV0E5QzlETGx6UXlnZkNsUHkybXpaMjRN?=
 =?utf-8?B?NWpPdHNiVU9YbDZQTjFTZ0JYTUNJd2p5cXp0WW9YSExNSUthTmVVU25hanBJ?=
 =?utf-8?B?R29xUE5MZUxxbGI3WURQcTdNaTJvN09NTzhUWnlaOSt0ZzRBT1BHWXRNcXZx?=
 =?utf-8?B?T3NrclAvY3hvSDEwazM5S2VNUjk2YU1GMEVXckNVKzlpL1hxVElCa0JieDJv?=
 =?utf-8?B?L0RoelZVWjJRQW94NGpRTzZjOGRMVHVkQVpsQ3BNMUMraEQxZ2J3cXgrUEda?=
 =?utf-8?B?L3JNdFJseFZscmJsY2dFd1dHM3c1SFlOTzhZN2l0R0FMaThEOVVqVHMwb1Nv?=
 =?utf-8?B?OXk3MTRyU2kyS2hTaERhaHY5eGJxQUNiTzJFYkxocGxZYkw1VG1jS0I4MGdU?=
 =?utf-8?B?KytMZlEwNkRITjZ3REtLZDJ3NS9VdjVqUUN3OXllR0V0V2Rob2hFaDV3cXgy?=
 =?utf-8?B?NHExZHhwa3lBaWNnQU5jaVRSdXo1dzEwbnQvQUxweU5SNW1sLy90VGJVT2la?=
 =?utf-8?B?WmdjejFvRzJZbmFVd01Lcm11UUkzNkFNTStsVE9kL082RnhZK2lkUkZtMk44?=
 =?utf-8?B?NHQ5YVFqNUZwcTl1K2g4c0V0VXRWZTJLOHBwZEZTekVJMnJFbjhUUloxSWcv?=
 =?utf-8?B?alFMMnJ1c0N2WmZ4R25ablRzcFlOUUladE1qVk1aSmttRDFrd01mR2Q5eDh6?=
 =?utf-8?B?TllIY2IvZFQzaFBZMk1iSlNUOXh3QTVML3JHY1BReWZuWnlGSEZIb1BrVnpo?=
 =?utf-8?B?SEt6SFBOdkhrU080VGdQZkxPd0VhMDE2OElxcDQxNkU5V0RQNS9FaHdxaGpw?=
 =?utf-8?B?NWYwL1JCL0lOamZmRGNTZ1YwMGhTbEE4YXRqTHRRRkk2UlN5NFBzWDB3enRB?=
 =?utf-8?B?OXVSSUJyNUFVNHJHK3M4cG9jSnBGYXo4ZXhaMk5XUVptSlRKS205R0ViZ2RV?=
 =?utf-8?B?d3FoRkRPU1VXaitLMEVuSWlKNzgvVXMvQ3F3MGdWNjV4UTJyd1oxQ3Nyb3hz?=
 =?utf-8?B?czk2SnYyZWVuWkhNRWoySUJYdUtKeXFZYmJmMXExMGdoTGxNaFRNeHR6SHQx?=
 =?utf-8?B?YUd2VUMwSmVDajdaQVVlUnEyRm5hN0dJQ25yYlJpNWM1bXhESENQNndUTitx?=
 =?utf-8?B?WmNsYnM5clNmUzJ2WVplUU9aV2o0UUNEeEtYc1haUGVKQ0RaREtHWjd4VC9H?=
 =?utf-8?B?R29CUWszci9ZZHEzQVoyQ21xTHZPRTBTMDRtQlIrTGZZajVvdGJGQ1dCaENP?=
 =?utf-8?B?Y05XbkFoQWlJdVF2YU1ubHdjZG1DVzhsb0pXNWNHODkvc2g2TUQrb29RSi9U?=
 =?utf-8?B?OUt5Ny9yUlIzbXQ5VTBhWnRSaUplbm5weEN2c25TR2ZmVG5Ra3AzY0xpbkFX?=
 =?utf-8?B?a2h2WVl5VE1rRGdnTjBwWS80UUJJU0xTcGM1Ym16bjhpYzdabUtHci82azdX?=
 =?utf-8?B?aWpFVzM5azdmcEtsdXUyOXhOeDd6QU5tMVUzRkhkZjVrQ3d5Q0I0UXhmV0ht?=
 =?utf-8?B?ZUxHMXAxTDlUQ0MzS2RMbHRvODlrTVhKdTNoV0J6UmFaMy9TQXA3OE1nRFhM?=
 =?utf-8?B?dmV6aXN4dEczaDM2SmlvczV0TEc1VHFHZnVGeTJubmgyZ3ZOZ28rOTR4MUVS?=
 =?utf-8?B?b1JBZFUzM254TzhHb1hBQWtaTzAxM1R1TjNWcVB2T2s5eUE3TmMyMEdtZGRR?=
 =?utf-8?B?bVJrUHZQazRtakJnSnRLK0ljU3ZxWHJJSktLam9GT0J4ZEthaTA1SEdMOSs4?=
 =?utf-8?B?WGpSMzNjTFA2WVdtM29zOExHOGl1akRiT20zSnIxdU8zUUZJNDB0NDNUTE01?=
 =?utf-8?B?K0hObVhsZTRzR0RUL283TVhZcW1KWk4yZ3dIdmRUaTkzUXoxMnM2OWtIQjJu?=
 =?utf-8?B?cVl4YU8rRjJacklyZGMxTHQweTNBRjI0R1hFc0tUOTVJSGZqRi80S3hyUDZn?=
 =?utf-8?B?cUY1TmtIMXpDVkQ4SjhzOHlycUhXS3cvNUNBMEU5MXppekc4eStZR3RKaVo0?=
 =?utf-8?B?M1ZIRkRKbzdRb0RLS2ludzlCOGlrc2p1T3ZBUDc4MjNkMWNQeDFtYU5nd3Z2?=
 =?utf-8?Q?SRcf2zvkXmRSQmCkxk/K2Cwox?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add756ed-258b-4db2-5a64-08dcf762e72d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:12:14.1609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umtOuEqj9UtlcjfkP1tbpNVCAdQgSXnYVxlm2Va+J9IH+DDXtfdk4oOxjlQczZD/B8q4nlnJIDtMCH6rlvnDcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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

Ping?

On 10/25/2024 8:13 AM, Srinivasan Shanmugam wrote:
> The `kfd_get_cu_occupancy` function previously declared a large
> `cu_occupancy` array as a local variable, which could lead to stack
> overflows due to excessive stack usage. This commit replaces the static
> array allocation with dynamic memory allocation using `kcalloc`,
> thereby reducing the stack size.
>
> This change avoids the risk of stack overflows in kernel space,  in
> scenarios where `AMDGPU_MAX_QUEUES` is large. The  allocated memory is
> freed using `kfree` before the function returns  to prevent memory
> leaks.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c: In function ‘kfd_get_cu_occupancy’:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:322:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>    322 | }
>        | ^
>
> Fixes: 6fc91266b798 ("drm/amdkfd: Update logic for CU occupancy calculations")
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v4:
>   - Allocation is moved just before it's needed (Mukul)
>
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d4aa843aacfd..6bab6fc6a35d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -271,11 +271,9 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   	struct kfd_process *proc = NULL;
>   	struct kfd_process_device *pdd = NULL;
>   	int i;
> -	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
> +	struct kfd_cu_occupancy *cu_occupancy;
>   	u32 queue_format;
>   
> -	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
> -
>   	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
>   	dev = pdd->dev;
>   	if (dev->kfd2kgd->get_cu_occupancy == NULL)
> @@ -293,6 +291,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   	wave_cnt = 0;
>   	max_waves_per_cu = 0;
>   
> +	cu_occupancy = kcalloc(AMDGPU_MAX_QUEUES, sizeof(*cu_occupancy), GFP_KERNEL);
> +	if (!cu_occupancy)
> +		return -ENOMEM;
> +
>   	/*
>   	 * For GFX 9.4.3, fetch the CU occupancy from the first XCC in the partition.
>   	 * For AQL queues, because of cooperative dispatch we multiply the wave count
> @@ -318,6 +320,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   
>   	/* Translate wave count to number of compute units */
>   	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
> +	kfree(cu_occupancy);
>   	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
>   }
>   
