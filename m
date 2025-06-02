Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E1C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 11:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1768310E155;
	Mon,  2 Jun 2025 11:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5b9mWX6C";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29A910E155
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 11:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIQ0Z4Pebrp36uy2z/7Jel+dcXskIshEnBcdzCqv7paTK9zRE7S0q744KVRai6iuQV5+O0gO6WEMVnJFb2gbJJY+bCPnBWSh7FZMvEkzTPqNG4d1zeMdEqrBB7OwYNvMQz5rSx+zgW9ONkzyB7vBzBnBXwCm1qsWs9/j4B5fktqH2YvdgkskB/ImjxDgqvronxyqW3rXjsCilGsZzSDKMMQfHUlnv3Q956pvpliBXFTb/3eHkA7peHcXdnQ9E2ZEPha3kr2JYZjxIeym4r+98IjKfic1DPcT5hiRm/JIscorZcUN8kJO21iPR2oOIfho8mreZXRV4O0z53nyS95qQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGtAEnNkCzT3r3UeNWvYdF1lKPg3gswEZF1tUdJcowM=;
 b=woNzGx4y7JSp4K5yqBzDmSnTWKgblNmM0baHz1q+CcZNs5dppwFoXbYMS8tx6jRczPCranWx1qaVcLVDWyPR9e+Lk3ZTP9Zpy1gMUVP9WfIDCOjGd/O5IdNkmcjwNPPfziX3+BEmafvs3z9bp+GLr917O5bSFBQHivrfCaF4K2UD6ToPH8T2sQxVhB/Mm//x4pn5C/sy1PLxoU9j0uFCSCWTmgBHwYiDi59x4/zKoOSq+MwaYhaw4KWp4EiOlRjVOKWdgzwlP91zkutaqsv31G66CkVK9KXgpLnAVhZemwL7FRUl7kMtG9/XgVpnQcVim2GlanYjoYiBXwHZgzN2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGtAEnNkCzT3r3UeNWvYdF1lKPg3gswEZF1tUdJcowM=;
 b=5b9mWX6CNF93IWrYTWnQGiMq8gV9Na+qNutfXTE97xYqvHY98irSgKOv6WjUIhYcjj1zOfaSAqlUSDDYLAhw5gGti78iuwgPg8Kp7Lzp1opTRQtKUsZybZVzLxqR3JIo8CeoLcgegt9PPHX/yfmhPaA0zd6qHtllim5xzC7cnow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 2 Jun
 2025 11:05:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 11:05:16 +0000
Message-ID: <ba16b7a2-130b-433c-a305-fa756bead449@amd.com>
Date: Mon, 2 Jun 2025 13:05:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250530075505.882004-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 33be7495-255a-4d28-5902-08dda1c55a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0lWc1RmVnJGcU5zWUZ4cHdVV2g3bVhCSHpiNTFURWhBamVlRGpNVlYwcXMz?=
 =?utf-8?B?aHFseW9wbFVsY3J2Sjdad3FrcW5uMFdLZitZRlBMbkUwaWEwYk1TcWdsWTVV?=
 =?utf-8?B?TEE3ZHJKYVdoTUZRaFFDRjVYSlVFREh5c0ZBdkhEeGtqb3ZiRmxjcXp5R2hC?=
 =?utf-8?B?bkpPYUhBeW9GT28xVk84WmdZNlRUKytNckhDczN6UXVYazBqZDdrY2Rxaisw?=
 =?utf-8?B?blljRWdPbW9Ta1U5cW5ncnhTWEpuYTRyUENmUm5RK1ZsTDFQdVgzaS96Ukt1?=
 =?utf-8?B?anErMXQ1TkRMZzRxdTRMNWFJdmpLODBxY3BZc3ZkSG5PM2ZwUHVBc05JbmpF?=
 =?utf-8?B?K0FVL1FBR1Nab3oydHdpK0JoNThza3ZCYTB0N3ZWMnU5NTNEQzJ0UUJJNC9K?=
 =?utf-8?B?VUg4SUgwbXkvZk40T3FhaDhmcUd2aWJnSVNYZTZvTmhHbFdOTDY5aFRCaVNO?=
 =?utf-8?B?NU0wV2hVb01ydHZ3NWlJbXA3bGhpOXcxalJralEzdUF3NGg2bnI2YkV5STdK?=
 =?utf-8?B?Vi9RZmJxYy9aaTZhT3N4dnlpTkVlcGdOS3dtUFJPSEFyYy9XS2EzSTBJV2Nq?=
 =?utf-8?B?VzQ2QXF5djdHS3FWQ3pNUGhhK0luMUp2ZCtKUHZkYStFWVFrc0NBRmVjMEla?=
 =?utf-8?B?TWlNekRLT2l4WW5HQ1J0dlJRVk5KOTRiamRPZ3J3RDB1N1NQNW1rKzREd3Bz?=
 =?utf-8?B?Yy9TWFlBbmZRaGw1bVREbUpyck5LVXdVNFI3RVNrdkNpNWJQbHdubU5uY0xX?=
 =?utf-8?B?eVhydVpwUTNtbGYvS2dMQlNxcnAzcnAyMDlEMFQ3OHh6TXY5QXYrZ1FiZU0v?=
 =?utf-8?B?WENiaGFORE53SG1oMlVtR3BDMDdHK3VoNUZpNW5kdEFRdnhXbVhzT2VTUUUw?=
 =?utf-8?B?bkZHc1FMQmlBUC9PcWRDSnJrSzNqWWVQV3dxWjdkVDRwQ1UwS0p6Y1pHQzFw?=
 =?utf-8?B?d3E4ZDFTbHl1VzlKcFV1QlNRUUhqeUdpV0ROWFYwblJPSzlHVXdOQjJtb3BW?=
 =?utf-8?B?dEVPdExhNlgxcE9mMzUwd3NUM0s0ZUtuQnpXMnYvbFIzNjdpQnM5SGVTNVAw?=
 =?utf-8?B?ZzdHcmcrbWF0VXdUYUZ6ck11eHFWQVRoa0R0dnRuT2JvQy9vWVowRWV4Zy90?=
 =?utf-8?B?SGl0SVpEVUg3MTJnL3hqS0tYTHIySUhabTl4ZEhrSHlCN1JJVTg3WEFUd1Vj?=
 =?utf-8?B?RWpqN0xUS0gySTBhMHlrY1crWjZqbmt0bnFIM3NRdUx4L2tGSlNqZjdKaVEv?=
 =?utf-8?B?aDNuNkZGc1BTWDRTbUxKN2t4cklrZjg0YUEzNU1wNDRDVExLMmsvbjZzemtU?=
 =?utf-8?B?c1dBR3VuMTJHQWVwVmhLb0dXTk9KcHRPSlVEQnQrK0lYUVN1OVhNZnE0SEVD?=
 =?utf-8?B?K2xQaCtLdkZxREt3Vk05bEVoLy84azBhd1Z0aGxyOWVDaFl2YkdZQjUyMzVi?=
 =?utf-8?B?SEtaQlA1ZU8rWFYwVU1EQjRRWWZhZ0x6ZkxnUWhXZHFWYTc3R05DS1ZjSVRT?=
 =?utf-8?B?UkFlb2VEcmlTN0F2TU5SMVMrc1dYRXRuTTVEY2JScFJEZ21RUXJGejduUDJU?=
 =?utf-8?B?dlRnZHJyNTFyM1JSVTJTaGdPWjh1Nnlxck5SMXZBbXRPS1F5b2svMk5JZ0tS?=
 =?utf-8?B?MXVmNE5XMmtCZ3FiMXhXQmk1TlRVbVZiMkZVYUY1cjVnSWpVMjAxbkVzNUZj?=
 =?utf-8?B?YzNCS2VIcFY3QlRERUd5MjZQSlpuREVEK3FWWjRiNnBCWGFSWWVDaCs3QzN6?=
 =?utf-8?B?TWRiVmRiTktGdUlmbDJueVVwdk4xU0xsNW02VGExWUdEcnFjcVpSZXpUUHBu?=
 =?utf-8?B?c1Y5aTBkbG90VWJWMGlYdWtyWHRvL1lnVmN6YlRrdnpSalhVSVNLdEU3VmtD?=
 =?utf-8?B?Q2o1NGJ0RTQ4SGtvMnRiOU10N0h6WDJOYXlQNlVQU0R3WGlLeXAvZy8wcXJl?=
 =?utf-8?Q?I3tXxRaaznw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1F0cDBqYTJkWUJkWWxsUW5VUjc4YzRHM0RmMklMc3ZYaU1LTnRkdGRRQzNL?=
 =?utf-8?B?THg0WnBwOVgwZC82WTNTUjJySDhVRkdIeXdxMG5zSzV6aWV1K3B1MnBQcVZR?=
 =?utf-8?B?NSsrWnpPMUtLQmNiMm9SRVJwWkNQK3Y3TTZJUVREc0pyR1hzaHMwTUJaNG05?=
 =?utf-8?B?ZVZBVGtWZWhpd1RBSlZvbUppWFh1am9Eb3FxZHRzWUpMcTNsSWI0cG9TN2or?=
 =?utf-8?B?VVdIWmxHL3J4OTBHdXJRMHg2STkzNE1rZmhUVmwrU2RKYzg5dlk0Y3pWMXAx?=
 =?utf-8?B?N3Z6UytXaEJSSWx5dFg3WEZGQ010VUJQUzl3d1p1S1p5Ui8wTlhkdEVWVFlr?=
 =?utf-8?B?c0t1M1J2U1UwdHpJd2ZIa0diMXZHcWJCWHhqQkNUejQwVUk5T3VPY1NQNFA2?=
 =?utf-8?B?azJ5V0d6Z2J2bzlwZWlkYmt4aFJaRFl3bTBDc2xDSXlCWjBWN0srRlhmVEFY?=
 =?utf-8?B?QTdYNjV1cXJaU3loZW5HMTQxdC9vcWxvaHNVakFhQ1kxNjJXbWJxTHZ6SFVl?=
 =?utf-8?B?eXFZN3VMQ3hNV0JzZm4xMTIzZWNBbWwxWUsyNFU2QU5RUnR0SUlheUdiZTFR?=
 =?utf-8?B?Y0NReFV3TEk1WmhIYzc3bnVZZ2ZRaEdMazZoMENQM0gvdkNhd0ZaKzZENHQv?=
 =?utf-8?B?Tjg0Q0Jzd3J6QjNFOUtIVzZ6U1AxNTRsRG43b0IzVnN0Y3B4NS9HRzBtV0Fo?=
 =?utf-8?B?WWQyTXJzRU9ITVBtdkFacWtHZ1lzWDNhVS9QZVpQdDl3dGZKMkQ0Qk9XbW5p?=
 =?utf-8?B?QWo1YlRxUmVVMTVaYVZqSXVzWVBBdzI5Z0NnbElvUi82OUpKNk9XcThTbFF6?=
 =?utf-8?B?cGVWam4vcG1IcE9xcW14K2JSSU9QVDdmeUp5QmlqMlJDL2dmMWJ2emJSWHUy?=
 =?utf-8?B?bHlLakF6WFlNeXJHSWNGODFHckt2NkJOUC91M2xwWFAyUmZGL0RMdFVDQ2cz?=
 =?utf-8?B?YkVjVXM5WmFsYkhaN2llRU9DSHFyQmwvSitwbVVPNm5mVXRjTHJZZzdOS3cw?=
 =?utf-8?B?cy9CZzd4SVVncG1yNU8vYUwyVXJNWGlEY3JXYkE2UUFiOXd2MVJHeFphOWJN?=
 =?utf-8?B?NXhOMDJyZCsrQnhkcGdGckt5ZFdGYWtYaC91aFhqWkRoWmRTMDJsek1WVU5K?=
 =?utf-8?B?eWFQWGpHU1ZlVFliQWVzTTNtNjNDYzFxQjE4cVNqeEVzbHh0MTVVRkhnekVW?=
 =?utf-8?B?UFhOdTZRWnhFaTdtSzVSbWN0ekdhVzA3ZkN6b25WS1BNYTBsSEFFbXEzc0Jv?=
 =?utf-8?B?cDBiMHF0V3lqZW02UUlTOVViQkIxSWVyTU53Qmc1bkxQaFY3aHB6N0MrQTZy?=
 =?utf-8?B?WldoZDBPdHc3dGpneUdUMDdLc3dzYmJ2TjBTY2FyQWZNczRKUytTNDRNS1dk?=
 =?utf-8?B?YU1lRmlkK29pUWZSRCtMVlhDSnpHY2dtTTJtZ3d4RVVSemNzWm1zYWdydmlF?=
 =?utf-8?B?eGRoWUhSWVRocm1qKy9nWVpjQnRITVd3UjBrWkk4Q0ZYbVVXTTdqTUJHZ3JE?=
 =?utf-8?B?ZFEybVZ6UmIwUXVPcitlb1EwSWNZYm5ud05iQ0pIYnJqMTN3dG1EUjc4UzYx?=
 =?utf-8?B?V0JKekZScUduY1ZKb1NIVUd1M3g1TUxYbDZJdU91TThEa1FCYVV1WHc1L2Fk?=
 =?utf-8?B?bFp4bElUeFpKUnJlNUsrVzVjMU9LcVZiRmtVRzUwRUYzL29Wa1VqaFExZ2RG?=
 =?utf-8?B?NEhUQjBaeFpqQjdSaFlqSnVYQVgwOXMxRGh2MkdJZklzUlJNRy93aGQ0Qkt4?=
 =?utf-8?B?Y2xxUXJVUGFHR1JaZ2VuMUVkSVlqbFZWSFFvNFF6cmx0L21OSFhndEpXeW9v?=
 =?utf-8?B?ZVBOOERNSlY3ejdxdHVBbUJmcVl0cTBMaDUxc2tTWGpMbzhBaGpQMWIrVCtw?=
 =?utf-8?B?M0JoWGFaaDBHakZJMVNYYmt1REVNaUVGLy95cWdhaFU2T09GaitsRlBXS2Js?=
 =?utf-8?B?bHNHVDlGdzY5dUloWXU5OEEzeWJkckpVeHhLMDJzYTBrMDFjVmVTbjlscDFU?=
 =?utf-8?B?T2JmbjdiQ3hwU25TV1AvMGV2OWhLcFlCcERjR3M5d010UDNnTnY1NTJJK3V3?=
 =?utf-8?B?K1hNemlncDkxTjNha3A0cjlnUGZ4YnZBc0ZEZEZ6cThZUnQ3OEoveExwelFB?=
 =?utf-8?Q?JchYiw69rHfrgAQMQE4xWvjzm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33be7495-255a-4d28-5902-08dda1c55a9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:05:15.9537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KH4dWMzbDa8mPua0yxMwlfWUCQ/yJ8K6GGPafy/XPM3ozxCKd0IbcweEN8Efesy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

On 5/30/25 09:54, Prike Liang wrote:
> The userq buffer should complete its attached work before
> being destroyed.

That doesn't make sense at all. We should wait for the requested signal fences, but apart from that it is the responsibility for userspace to make sure that queues are only destroyed after they are idle.

If the kernel does this it should *never* wait for anything ongoing, it should only forcefully unmap the queue and destroy it.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8eea0e1e1b6a..f45585bd5872 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -217,6 +217,8 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>  				 struct amdgpu_userq_obj *userq_obj)
>  {
> +	amdgpu_bo_sync_wait(userq_obj->obj, AMDGPU_FENCE_OWNER_UNDEFINED,
> +			false);
>  	amdgpu_bo_kunmap(userq_obj->obj);
>  	amdgpu_bo_unref(&userq_obj->obj);
>  }
> @@ -317,7 +319,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		amdgpu_bo_unpin(queue->db_obj.obj);
>  		amdgpu_bo_unreserve(queue->db_obj.obj);
>  	}
> -	amdgpu_bo_unref(&queue->db_obj.obj);
>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
>  		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap the queue for destroying.\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1457fb49a794..b46e67b179fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -336,6 +336,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>  		      struct amdgpu_usermode_queue *queue)
>  {
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	if (queue->db_obj.obj->tbo.pin_count)
> +		amdgpu_bo_unpin(queue->db_obj.obj);
> +	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>  	kfree(queue->userq_prop);
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }

