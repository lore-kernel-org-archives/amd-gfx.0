Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CF9C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 14:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A8710E256;
	Fri, 24 May 2024 14:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJerGZZx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB5D10E256
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 14:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqyJw8CgGImdbyMH+V9Nz6FTyWQ/pHUMHc+frDUD8GGz3H7NqDDSmeN7KggYQlJnTRDNsd5pkvLmvzGVauDBeqDxKu4Y0Qp62Z9b1z9cy53yoi7Xzq5mt30QgMEtxdZ+cW1aDYbYe/V9UnATHo/CG1AoLLJkb5ixhwSG9OJ5ctRUhiwFJZeAPWFgSRsm6cdFOfMhtAa6u4UGyqMWf2meddi15BfFnug5roevtHwSa7+9jpaF18j2tKf5N3hIThVa8SV51KMQ7aRdmESlMDM/2JifoPQptEiW9r4bE0r7lfzlxzS25Ce8LOwlFjHmNDPFpgB9G15dRvMCjwbEl9X93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2EVtp/TR/MbftnuxPanBGKEbH5mpDtF9G8ILQziBEI=;
 b=ALZBxrdgEm3SbnYSKODJMEEzNs4eAE//d8bkpCw3M3Ex5wpD2KokHogxcQlyeMcyEWvcxOAq4YhmGx8mTAXfTluvea9wPj1G6vPOroP12DSUQUmVvGFngm3OUbPYhEczGXZaYPXbX4dgGZY4K5Eu3H6VrePUOrWymaeZbT+8ztqpfOAgHIqQbwWFgOLcoOnl8Uub7JMVtYjV4OT8sgRF4gEwBEK09nTHad7DanhQQ/IY+11LjLPDr8xQ2u/ZyX39wMFV3hNQjP82+Co1voOXYfGanVNqrmU2sekATWDVZc524GVHomR/3lAXTOuJR9LuMfUDVRvCPDXbLrjqZGOYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2EVtp/TR/MbftnuxPanBGKEbH5mpDtF9G8ILQziBEI=;
 b=mJerGZZxaXNsyZBKHSPF4zQHVhWIOnZEYfagdFs6CSQZ8/lVbpCnaGqpPovy/DeWyJZebuG1w0BTGB0QRR4WDUcx4IKF3LNkfDdQAGL0dyXethubEIcUFxv02kZW9sFREPQhCrDFGwswz8H9Ga9J40zcoVSmKNT/EhKxl76IY3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 14:25:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.037; Fri, 24 May 2024
 14:25:46 +0000
Message-ID: <412eda12-94b0-4aa6-ab78-9e3b5a6a0a39@amd.com>
Date: Fri, 24 May 2024 16:25:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
 <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
 <SA1PR12MB8599A25B022AE47DFD501021EDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <5e4b57b0-441c-4207-96c6-63d54ee62f29@amd.com>
 <SA1PR12MB8599A254DFF05857C8F59669EDF52@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599A254DFF05857C8F59669EDF52@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b54ca8-3bd7-457d-e1c9-08dc7bfd669d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWRNMTFrc0VJaDlHanpxYkdvUlJXU3E2bzVzSjZhWjY5MURmQUxDWmtsczdU?=
 =?utf-8?B?ZXRFRkFOVkc2dm1LT1ZaSjBHOHE5YlpMTjg1ekE3bkFuY1pZNU5kUWhqSDR6?=
 =?utf-8?B?ZDd2QWN2ekN2SmdxdUJHNURPbHo0TUFMOXF3RDJMQ0JadCtWY214ZXVMQXBR?=
 =?utf-8?B?NmMzdlU4T3hQRGE5dklJcDhTS0VON0dheWhXeFNERW9wRTVGYWl5dGFJbGFU?=
 =?utf-8?B?Y1oveVl6ZDJxczhRYTZ5OFh2ZStvbTVDOGpITlgrbS9LUGlMYS9MSGR6cy9a?=
 =?utf-8?B?Q1VGWVBMT0E0M2lOQ2FuaWFMYUF5cElVNHNxbGcvRHJ3TlR4Zk5jU2k5MXQw?=
 =?utf-8?B?Rkc4SHl6dnlBc2V3UDBuekM2bXZKSTkzb2dybmJJY05rSkQ3cUxkNW9FZVlB?=
 =?utf-8?B?YjNsbk52c3c0VEhVYlI0akRzR2ExaDBEdnlxZ09sVHdMdXNsYzhyeVk2RTVx?=
 =?utf-8?B?dmFwY2VSOTZhYVVXdGdKSGR0Z21GV293dS9YM3doN0NPMHhvMVBHekdzNkFj?=
 =?utf-8?B?cVNWVzRZdSt6S05MVTlBR0d1bEpyME1wMlhnb1JnaHBac2doUWtweFBYVTFF?=
 =?utf-8?B?dWZWWkRUeUMyVFM0aDR5RmNkYVF5bFhZNStEaEZUNDk5elgxRS9CN1pXWGlK?=
 =?utf-8?B?WkNoK29hUk05Ykd5K0dpTStwWWRRcHdGU3dlTXdzL0FvaU84c1hwa2NhVGcv?=
 =?utf-8?B?ZHhVSVY5bktRWnpvdEY2WmJGb0V6cnlYeFYrOERUcHVJT3FMQlNOVWZldzlV?=
 =?utf-8?B?d0tkV1pqckV6SHRsRS9rb1B6SWRZMzRQV2lxRG9CeFJzN1dPRXd1S1NlVTFH?=
 =?utf-8?B?SGtXTVVmZVhxSXl0c1VLSE5JdHpocDIxVWtHRDlCOEtJb1RMN1VjL3pKcG0x?=
 =?utf-8?B?Sis3dWJOUU5lZ0tSNVd4ZVRKMjRGMEtDV1hsdHJ3T0tLUko2Y0FBOWFtTVBD?=
 =?utf-8?B?akFuRUpjbThNMUhMYjFjT3ZDNWhyc3dVWEZrbkFhWWZwSndrc1RyNW9VeHFk?=
 =?utf-8?B?a2NBa1F4KzB6T3MrbFdGdExjRVF6cEhKbTl4b0p6OExpYU8yalZSUEFJOVRS?=
 =?utf-8?B?eE13OXRrUjNZUnE2c3NGTmVZa05KWFR3V3RrSE4xbE5ka2krMS9IM1hLb2hS?=
 =?utf-8?B?RnduV2JpbDlIL2gra3dHNThEWjZnTHppZys1bTdvY09SSzZ6WTZhNXFEWXVF?=
 =?utf-8?B?eW9GUTUzdmE3ekIvN3lwY3krZmVsQUUrdndYYVcxV3NleHczekorancvQndN?=
 =?utf-8?B?MWNsUHQ2NENxVTNDQStybHozcUN1ZEpoeXlCdk10bVUrbUNZY0d5cmQxb2Nj?=
 =?utf-8?B?VDQ1NzdoSGloYnJiU3JhSmM0eFlLYmpZcVNGS0Nmb2FpRkZuYTEvQW1TNXZn?=
 =?utf-8?B?Vkx3U2dmWHB1UmNSVm1sUkdMcm95SGdqNUNNVUM4VnRuMm1Yd1Qvbm5hV3V0?=
 =?utf-8?B?L0pNdVUxQTlMR3BOYy85d0puc0EySU9DVDNCSC9SZzBOcTBMMC9vU2hSVlJN?=
 =?utf-8?B?NzM4bzZBYU5yYkFNaWYyM2EwTkNBbmRjNkdvRmM1TWdVMzZRTkZkZVNRQmxV?=
 =?utf-8?B?cE5tQTZGem51OUt2anlBWXBiQzVZRC8rQWpvV1VOR0ZISm1ZTTFIRGtoNEVp?=
 =?utf-8?B?WkNQQ3FaQVZNbnd2bzRWWFVUZkNNUXRKcTA0bFp3V2xXZ2lYajdidFk1bExa?=
 =?utf-8?B?OXUvR1doUFRSODVIL1c1eU9wODI1TFh4bFNoZ2Ywd0R1S2xUSGlPQTFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZaK2lKZmV6STdhUWNmOFc1N2JsZC9ZM3p6TWQxTzZPRnl1QWpnNVVIRzNi?=
 =?utf-8?B?czNuNjZ6MWF4VnhzUCtHYTZMUkxOQmxpWUZKYkxYTk4yUFI1TFFmSi9NbUlB?=
 =?utf-8?B?R1NaZDJiT3RRY1N5U1huRmRVUnNTK0pVRFlZQmw1Q0RlSXdwOU94Vnh6TnVM?=
 =?utf-8?B?cURvNWhDZGtTc3VSbXd6dUVtMFJrMUFieThwY0JwU3BFUUFIdTRickpXUTdz?=
 =?utf-8?B?YUdpNkhWYkZxSThJTitDVkZUV2pJZEoyU3FzOHR6WnpOQVZRWjY0N3F4TzZ0?=
 =?utf-8?B?S2ZQdTNwdElpWE13UWd3L2x2R2xXdUdqWm9tb3BpRnpoWUZUUFloanRlUytC?=
 =?utf-8?B?V1lZMFRKSUszK0pwamtxOG84ZFI3QkFQNFEwMDJxNGdYcVBWbXUwM0FXUHhB?=
 =?utf-8?B?cVYzaW96MWhtdkxSeTBRSGIyaHFRdHEyQnc1MlNrYTdQeGdVcnU1QmNXU3Mw?=
 =?utf-8?B?dmQ3ZCtUTk9MUnpDTUVmelZjSU92c2Jsay9VRlRIaG5LTE9lcVVHclBpVlpE?=
 =?utf-8?B?a093SWFDU1E5VzN2OGRhb2IyYWlFbUdyK05lUFAvN3JranFOTGZPclhWV2sr?=
 =?utf-8?B?N0Zsc05rRTRKVVZHcmliN1JwcXRpOXB2QndZMGJqQ1kvNG5VMStzUStuQlZK?=
 =?utf-8?B?ZXdYVEJGYU9GYlRzc0pyWVZJSmZRaHl2aWxvT0E4V1poYlY4a0gwUElhbTNU?=
 =?utf-8?B?dHBOSmY3V010VGswcFZqK3pZMm1UdUtTRzJMSHduUDRyMWJCc0hLMlVqbEhF?=
 =?utf-8?B?YmFOblpPV3dxTXV0VjZsQmlMakVDaE1tL1FyZ2wvQnpRakZzQTNGR2FtT3gv?=
 =?utf-8?B?dmJkL0RQWElVQThHRlRtSXJLVUNxL3NyVWdqeFhhUDNReHBYRVVkSFMyb1JS?=
 =?utf-8?B?dGI5RjRxU1cxOEx3NjY0VG9TOVcyMG1tNzIvNHFzWk5hWG1Nd3FzaHNuWnlK?=
 =?utf-8?B?Q3hueHRTMXB1Ti82QWIzYmZSZ2JQOFNpZXlSUUQ3MXJFVUp3aEk2eU5abmMv?=
 =?utf-8?B?Y3BqVVYreUIzMC9pZlZTcEFITDNQanR5QkxMcE1NZjI5WXR4R0Rmd1dZOWhE?=
 =?utf-8?B?UUhkTWZmU25NWWhvWDZQQUlQL21oZUJPNlNyYjFhVld0YUdPV2FDTmhya2Jk?=
 =?utf-8?B?dms5Q1l2Vi9iOVFtQnZSUjJhN25rcEJYS2VlVmRMeG5ya2pCUGNrWURDaU9s?=
 =?utf-8?B?a3BSMXNlemxXamg1RGJmUTRvVzZOQUMyOEppR2VucGYyVkpkU2tja1F3T1Bt?=
 =?utf-8?B?RlE3M3NEQ1dvakY2Y01PL002dzA0S1pJdVZ2dVllSFNSSFlrMy9rdU0rMEZ1?=
 =?utf-8?B?ZjVTbWJWUEhtVzBWalgvSUZkeFYzL1REa3NmR0hzbUlFYlRYMHlZUnNGRVIx?=
 =?utf-8?B?dWNrMmpXNlhRNGs3SEVYTXU0SmI2a0hQUXJjSUFkYUpOUU1FaGZsQk9naU9I?=
 =?utf-8?B?VDhITVRQaUU2NlhseFJIU0s3R0M5ZzMrd1pVS0NKZmwzVHl4TDZoRFQ4dFl6?=
 =?utf-8?B?RW5GY0NrWktjOTkzbHIram1mVW80OFk1K1g5c0JHL3UvQytmdnZZOXRGWlNl?=
 =?utf-8?B?WFRBVDJiSThGaDA1WkFiTlYwdERNVnB3bk1kTUZzV0hqNEpCa3lQUFk3VlRG?=
 =?utf-8?B?WnYyYlkwM0ZBNU1CSHIzTmxiVTRtc2lYOXM0WU1ZK1VqZTk3aXRGdDBqV0Z5?=
 =?utf-8?B?MWtyL2lpeUhabkVIcXJUU3lmWFpiT1h3VWdCemUydlFWTDJrN29ZcllObXRm?=
 =?utf-8?B?UkNDNExhdmRmMlhHaFplK3h3S0ZKazJkQmluWVk0aEd1czI2dWF3ejYzZXVL?=
 =?utf-8?B?cnFtd1U0V2pVbnNhcXovRjR5SXBFM0laaEhEN3kwOUg2R0VkZWkrMXFBWlJW?=
 =?utf-8?B?c3M2UWcwOVI3dThzcStueXJ3OUJnd2V1YlI4VW1TcE9lUTZsR0o5K3FCckR2?=
 =?utf-8?B?cnE0QUdrMGVTV0pXQUsrV3IzUzk3L0tWQitzNHp0QWQzdkFZRHBFVFArc3Iz?=
 =?utf-8?B?T29yZW9TMUd3MTFLUk5zdzBsbWlrQjhlUzE2NFJmd3oxOXF6OXUwS1RhdkxL?=
 =?utf-8?B?QjMrQk1kOUhKeWZMaWFESWluODdZSFVjZ3Q5bVFGMjJ1YTFFNVhsTTBlZVpx?=
 =?utf-8?Q?7HYQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b54ca8-3bd7-457d-e1c9-08dc7bfd669d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 14:25:46.0999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NayyiVW2XzhfL5muig9G8VrXEUqTLE+pBeCCZXHtJwgoH1Swp7mwxrw3suksaiC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
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

Am 24.05.24 um 15:35 schrieb Li, Yunxiang (Teddy):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> If that is true you could in theory lower the locked area of the existing lock, but adding a new one is strict no-go from my side.
> I'll try this, right now I see two places where this would be problematic because they are trying to suspend either gfx or kfd scheduler and later resume it, which would race with the same in reset. It is exactly this two functions I'm trying to avoid putting in the scope of the second lock, because they are common to both in and outside reset.

I don't think that avoiding the suspending and resuming the schedulers 
is worth moving the locks.

That is something so rarely done that it shouldn't matter.

Christian.

>
> Teddy

