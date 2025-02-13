Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E264CC0219D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 08:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8255410E0B6;
	Thu, 13 Feb 2025 08:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3BRdGnMj";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DFCC10E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 08:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQbdHYAhOGgBwEPcRl8edSr3mmVSQECpstVI1JXwXwP/dm7LwiO+g4u9s1d2U8DUw/jQ3spieQnRyMsFA6KQFV8fzvCNz0SyVFl5sZbysMX5iZw6jV8rdyDZz6heEbMd0CkGCrR82jjp9WHXHAn8nFYYv/rAHnD/WvyfEq4QWjalbHpnrgvjiyBtniuJftlHoWlKQmp/rtq3+lTJFFBcSw6ggGYB2gr1wAgbo8WSRNTo+cM58reVIwJNsdgbaUQDnWk8Op76Rm0t/6gu4kQLGH9/VDZUoxslWig0UOmKxBIgqBgulApqdcbvRhXPEb4U4P9g+0K46pMBFISUGICByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIfc2LnKqrZmForcBSGwfbrRetV6frrrpSkUTBavfxg=;
 b=us6IF/+tgCpPu1Seqnquq+Vxvkzwwofu1XZhf3+Isks3/LB4fu4QN4Hu7Qiu1kC1/ggAuC6sCMxQgmjxGoWqefUt13FxcIcIT7KXpkNH2BQeqPUeWsplagiIQyV5VltUopq5M+Yfe1PddnXiZ8Y8XNkL2cw68SRG7wQ6nYMC3l/f9bx58ojQB14VBug4Li1bW8WeRor762kQGuZfz1iapKhzdrsen+Np1BnsebHX3VmoA921F4snsGESeROJWEnOEVRLNcRBXu2hWbX50UxJ9RLCt3PDxvSdr6+/Gc3aeuLO90Q2uNs7sFhnJsVOH7D2+atjxt/1gdm5ZCN7aHDiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIfc2LnKqrZmForcBSGwfbrRetV6frrrpSkUTBavfxg=;
 b=3BRdGnMjEDu+C9CGhG4EydyW8cQWHLsZnl4QsQ4ND9+KLbIF5gatfrbP0Ta18inGvl8yIkYTm2Uc1NgjdPa3w7mM2+vL0dZd7roVyYSwq2TP/xW45OucjoEljcN3sCtRsulzOgFE2yDASDtKkZEZbfpzD82npdQfTKx6queb94Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Thu, 13 Feb 2025 08:05:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 08:05:51 +0000
Message-ID: <f1856ade-76e8-4bf2-9dd0-0a98bce21859@amd.com>
Date: Thu, 13 Feb 2025 13:35:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
 <20250213025408.2402828-2-sathishkumar.sundararaju@amd.com>
 <a7f7fcda-ae6a-4506-a7a2-4e3eea5316e4@amd.com>
 <4c2483df-ae3a-4380-a01a-de11edb36e09@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <4c2483df-ae3a-4380-a01a-de11edb36e09@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 699f6407-292d-4485-c099-08dd4c053b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2xJMER5aXh5NFl0SE9md0w3cHdZanpuemJwS0RaYUgxUHYxUTdWQWloalpT?=
 =?utf-8?B?Sy9URTFnYWFyT0VyckNkMVd5SjZLNFZVQlR2SUxaNjZBR25kbmswSS9QK2lV?=
 =?utf-8?B?cG9NQ0NZaHJRYW1tUlk1OHNkWkVaRHBnZE5hSW4rc2I5clIrVkZDam5CUVB0?=
 =?utf-8?B?c3IzQS9lSDQyQm1NSGVrcmtFTlBmSld4QmZlZkJLS0l2WGpsdVA4RDhsTzc0?=
 =?utf-8?B?aTB1WXJkVWFMakNCRjNUOGYraEVyVHZ4WjJRWVpZZlBJcXZnS0RGUS9aQUdl?=
 =?utf-8?B?c0VmbjRrR3FBZldLNjNkTEFxZXpCS1hRR3hSVE5XZW5WVzlXT0xlbklvbmtt?=
 =?utf-8?B?cW9MYXQrZDFWbjRNVDd6OVVDSFF5MFJ0Mjd1ZlBoY0dqZlpOVE1rOUV1ZU1D?=
 =?utf-8?B?YWhNa01yZ0VCZGlMc1J4M0IwenNnMkxsc3BjdUtFVmFMb3JzYlJoRDg0L3g2?=
 =?utf-8?B?RnhKMXJFUkIwLzM4b2JVc0ovNXdqUmxZTEl5WkVoYWhuNCtkdXp1Kyt2ZlhG?=
 =?utf-8?B?Vks3UUpaWVFRbDZOdklsa2NjMXRZUUxQcjFXeWVYVWQxYm05dzNWTHVrVm8x?=
 =?utf-8?B?OXpQbG5iZnlKaUFYTHlyUjN4bjBVbGFoVjhlTy9icUY5RFFiSDVZajFXeDJo?=
 =?utf-8?B?Skt3RGtKK3ZEdVFjTGtBWndvV0RqVElocEdoY2EvVi9YRkEvbHVSMHVRVndZ?=
 =?utf-8?B?Y0JyMllKZzVpNTkxVHlWUHZnbkR3cUR3NzFmL0t2ekw0dWtkcEFpMVluaUY2?=
 =?utf-8?B?dVR0MWg0aWpvb2pmVzhIdVM1TzhFMjhXYUREVFowcTJPQ0tUWHNkNjVnRDdr?=
 =?utf-8?B?WnhML3Q0RjRPbFBobVVmSEpqSHp5SVYvU2w2S2xkVi9QV01IbWlpeHB6aGhm?=
 =?utf-8?B?Z0xyQno2dU9sdnZGeHpUYWhoeXBpNlFpWkY2WUhSeGtuc1FCSkFFTzJrR1da?=
 =?utf-8?B?SG1ldVN6bThyd3VVRmxBVm5kQ1Q0K2hzR3JGWERzQlVuRzBGenVXOFMrMldw?=
 =?utf-8?B?NldPUXZsQWVBcENVMVB5RGtJVXpXcEJxWkFKVEh3ODZ6OUwyVTU0TWFhbkxU?=
 =?utf-8?B?cVIxemhKTlF1UzRROGl0a1Nlbi9xVGdqUTQydU4zWmZPcmFZYjlJNVZmdzRk?=
 =?utf-8?B?WWthN2huZ3ZMbGg3N1ZMVWpzbEFmQ05kTlA1Y0l4SENLUGhPSHY2QVpZdWVJ?=
 =?utf-8?B?NW4rVDBDVERJTmRrMnhua3VEL2hKZmc3c1NmSHU2c3RrQUVGbnIrOGF5OHJX?=
 =?utf-8?B?Ly9NRjRtWTFYWmF2K1NiZXpxZ1pXdXFrVS9Ja0RJclZDeHBIdVU3L2xLQ29I?=
 =?utf-8?B?L252RnBadXpCbWlYMStwa21YMENLZTk2N3hONk0yRlgxcEQzaE8wWjU2dS8w?=
 =?utf-8?B?bC9CZlkvZDBRanpCTldEM3dROHhuME84QUYxSG1OdkJHbS9XYlNCbXk0TVlE?=
 =?utf-8?B?cnhHdFZVeUlOTEFHRk5PbVBJd1R5VHpQc1IzU1NjMytsaXFIRVNmR0ZLZWp0?=
 =?utf-8?B?eWlyd1oxRXNYZk9jOVhwelF0TDB4bUlYUld4NUs1ajVuWDRWRnp1dzYvNHBv?=
 =?utf-8?B?UUtLZ09YakdnSUREcEVFT3JudlVJdkErRUxDTSs0WkpTbFBtNDFUZGxzNlVE?=
 =?utf-8?B?S3RtRnlxRHlzRkhpelo5QW5uK3RLZm1kRGo3a1VPYnYvU2I2S1grTFZwaERQ?=
 =?utf-8?B?U1M1dmgycWtKb0s4ajRWVE13bk10UUM5Z3RVKzRyQzRxVEFQRC92WWZ0b1Vo?=
 =?utf-8?B?cDl2elVGK1BhM3V2Ni9YbGtZZVRBeVllZytzbmJaWkU5cmEzcnQ5Rit3dmFF?=
 =?utf-8?B?V0Q5ZW11WTFsNjdRMGJHcXNTS1J2OXdNUGtpeUlZWU04ZHlwOVRiVk0vSUcz?=
 =?utf-8?Q?ygkWB3hOTejC0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZPZjlZUTlTYjJDSHpRSTZHbTVVdjB0TzRmVGRVdlVQZ1lPdVcyMFJnQ1Av?=
 =?utf-8?B?V3lmY01tbU1JeitnOGlJRjA5UjF1cFVodkZuRVgyNXZsNFRST3ZsQ0pES3px?=
 =?utf-8?B?NUFQeC81WGNTUUpRUFJxcjJhdGJvTGxsekJlRVA3SEhPVU83YUV1TWR3dE9z?=
 =?utf-8?B?cTNCbTRiajBhOHE3YytveVNBRkl1RmZ4aDZQVVE1UTBkYVhKUy9OeVJXVXhW?=
 =?utf-8?B?R3Z3MFFsUXd6MzlOaHAyUGtURnRySkF5SUtQRWQ0V3Yyd2ZmQ3JhTFVyZWtm?=
 =?utf-8?B?akVFWHlZbXFTTzlUNU5rak16SWFTTTVCZlJ6aHBaTlFSVFc1bkJPWi9kdVFY?=
 =?utf-8?B?UWJZKzB6STR5T0Y3NE5RVDJwUy9vZG10RzZFWFliNUFpdS90d2FXeCs4Znhm?=
 =?utf-8?B?OFRWZG1GeVJCVmZzYjZOcVRlU0tlMkVjT1NYQ2NacXNTaUJxb28rMG9FMzJw?=
 =?utf-8?B?UnJvQmF2QkpQZTdVbEkxYjNycE94TFBCemwza1BvSHYwR0dXb3VweVovMG5a?=
 =?utf-8?B?Z1o4WEhHeWFtTHFURFRFeVIrSy9LSy9xUVYvZkEwMGdBWFY4eWx6aGJ3ZnZj?=
 =?utf-8?B?bHpLT3RUaGMwRHlUT01NRlhPNHoxSlVTcUk1UDNzTXp1U1U3cGpHRGZkM3Np?=
 =?utf-8?B?TG11VlphZ2xnc0luYmRlVlJWTDBBZG82Tmt2ZHd1bHdmOXFKcHJuNm1HYUVh?=
 =?utf-8?B?dEhMVjZyb1BnUUVwU0dYWkVBdzRvTjVTYkxqNkhiWXVIeHM5NlRWdm52OWxh?=
 =?utf-8?B?ak9UVE9XUzdXbE9HY0piWGZjbFBEeDYwQUFEaEtRVVNFZE13SzNIU1oyQ1Ry?=
 =?utf-8?B?UjhWb0hCSXg2Y3N3Ly9acUFmUjVrd2dQMi9WdzAxbDRSTlpJT0VueVY4M0xS?=
 =?utf-8?B?TWxGLzlld1daS2p4b1VDWlBlWHdJaWRXWWpZcUJVS1RCWGhrdm40L29Ndkp1?=
 =?utf-8?B?NjA4TmVRd05zYkpFM2kvcjAwNUp4cTdzbjNxUVRERVN2b0JhRERqdTNmazk4?=
 =?utf-8?B?bVcvYWtNNkNmS2g0cWJFSit3bVdlQk5aVHRVbWZINTEwNHJhWm9qdGdKMHdU?=
 =?utf-8?B?d3BGSFA4Z1VvN0ZUQzFGYU94clVxZjJubXVzSTE1alprcXE5dWNNVFdKVjJ2?=
 =?utf-8?B?bXJSQmdxNXNMNUpNZGlJRzFPbzlxQk5GSVpJeUk1NmRsUk8rZzQyQURJZ1hi?=
 =?utf-8?B?K0lUZUxad0JQWGsrLzN5WU54TzRwS1NIc3hYSFV2UU9KaUNYcG91ZzhxU2tw?=
 =?utf-8?B?WXI2MUVVWmN2RUNJZ3ZJOWd1akdISGxjYVpkRUtwNzZYUkY3UE9uWkdlSUpw?=
 =?utf-8?B?WkFLTGJFRldDVER5bDNKNHUyWmlab2hFTVFuZEJ4SC8rbzdxR3laY3NQYlNv?=
 =?utf-8?B?Yjduenp2eTZEa2JiaG9uc3JjV1p0RHBTN0pUbkZRcU9TVXFoZDVvYjJCUFRa?=
 =?utf-8?B?dmRFbXNOS3FEaVBNbFdVZ243MkFVaUltQUd3d2ZJelBqaTcyYjRDMUQvN3hW?=
 =?utf-8?B?YnJaTnJOdjNIRnVtbkplRUNHb2hEeEErT0xmUUlyejFsZnFiczYzK0gvUWl0?=
 =?utf-8?B?ek4rNmJJbUFjbmNMR240Nkd0UXFpTUNETkl0RzhkTVgrQllsTVdXWThRM2I3?=
 =?utf-8?B?TmNJUXo1T3liSE5XZDEydU1PV0xrZDN2OWl2VmdiWXEyTEw2V0hIMTN5d3hG?=
 =?utf-8?B?ODMzNVFyVzFkODhDa1pOOGFId3RLNjlrTnJIbWRPd093OG0ycTZsZVNDMEhO?=
 =?utf-8?B?b0FCRjFIME9pZzBvZStCelRlV01yZ0krSjRpVnhySVJzaHNJTVBwTXdvaHk0?=
 =?utf-8?B?NTVaYnF2ZWVEaFVlRUhPVlRvZFFVM095RXJLYW5XYkhHaGM4TTJPOFBFYkk5?=
 =?utf-8?B?RGRMNCthT1FGMU5nYmx5SGJmZkFYTCs1YjN2NHJVS3BPZDZ0NTU1UWJpcElJ?=
 =?utf-8?B?Z1Q2amM5NFJRRDBTbTd0WVdKak5JV3R1VXpvNUNXak5RVWZMdmkySnFmM1Fr?=
 =?utf-8?B?UCs3YzFreXMrcmJUTlhKeFh5SktUQ0xxcXNCdk5NdGp5Q0ZQblFSKzhnV0Qw?=
 =?utf-8?B?UjJIQVpZdEI4cmJRbkJUcURUYTVkYXhSWWtiai9ISjdUeG5KdVRxdXptQ0Yv?=
 =?utf-8?Q?RxpgHwTVwnM9ML/W+LaVF3MCo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699f6407-292d-4485-c099-08dd4c053b2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:05:51.1920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tpuzy96sZXPxfh6YKyhRa/V8Yl5ZZY1ykNw0ZX6hbjfMnTo7yUj/fgi8TJciPb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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



On 2/13/2025 1:07 PM, Sundararaju, Sathishkumar wrote:
> 
> On 2/13/2025 12:16 PM, Lazar, Lijo wrote:
>>
>> On 2/13/2025 8:24 AM, Sathishkumar S wrote:
>>> Add helper functions to handle per-instance and per-core
>>> initialization and deinitialization in JPEG4_0_3.
>>>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> Acked-by: Christian König <christian.koenig@amd.com>
>>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
>>>   1 file changed, 98 insertions(+), 92 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/
>>> drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index 2a97302a22d3..e355febd9b82 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -525,6 +525,75 @@ static void
>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>       WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>>>   }
>>>   +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int
>>> inst)
>>> +{
>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>> +
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> +             1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> +    SOC15_WAIT_ON_RREG(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>> +
>>> +    /* disable anti hang mechanism */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> regUVD_JPEG_POWER_STATUS),
>>> +         0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> +
>>> +    /* JPEG disable CGC */
>>> +    jpeg_v4_0_3_disable_clock_gating(adev, inst);
>>> +
>>> +    /* MJPEG global tiling registers */
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>> +             adev->gfx.config.gb_addr_config);
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>> +             adev->gfx.config.gb_addr_config);
>>> +
>>> +    /* enable JMI channel */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> +}
>>> +
>>> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +    int jpeg_inst = GET_INST(JPEG, ring->me);
>>> +    int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
>>> +
>>> +    /* enable System Interrupt for JRBC */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
>>> +         JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
>>> +         ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
>>> +
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>> +                reg_offset, 0);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> +                reg_offset,
>>> +                (0x00000001L | 0x00000002L));
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>> +                reg_offset, lower_32_bits(ring->gpu_addr));
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>> +                reg_offset, upper_32_bits(ring->gpu_addr));
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>> +                reg_offset, 0);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> +                reg_offset, 0);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> +                reg_offset, 0x00000002L);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>> +                reg_offset, ring->ring_size / 4);
>>> +    ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> +                     reg_offset);
>>> +}
>>> +
>>>   /**
>>>    * jpeg_v4_0_3_start - start JPEG block
>>>    *
>>> @@ -535,84 +604,42 @@ static void
>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>   static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_ring *ring;
>>> -    int i, j, jpeg_inst;
>>> +    int i, j;
>>>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>> -        jpeg_inst = GET_INST(JPEG, i);
>>> -
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> -                 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> -        SOC15_WAIT_ON_RREG(
>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_ON
>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>> -
>>> -        /* disable anti hang mechanism */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> -                      regUVD_JPEG_POWER_STATUS),
>>> -             0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> -
>>> -        /* JPEG disable CGC */
>>> -        jpeg_v4_0_3_disable_clock_gating(adev, i);
>>> -
>>> -        /* MJPEG global tiling registers */
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>> -                 adev->gfx.config.gb_addr_config);
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>> -                 adev->gfx.config.gb_addr_config);
>>> -
>>> -        /* enable JMI channel */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> -
>>> +        jpeg_v4_0_3_start_inst(adev, i);
>>>           for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> It's better to move this inside the instance function. Instance takes
>> care of all cores within the instance.
> The separation in the helper functions was done to decouple core
> specific configs away from instance
> specific configs to have the degree of freedom to control them
> independently without meddling with
> each other, so having them done separately kind of helps to align better
> with that choice.
> 

Functionally, is an instance considered started even if its cores are
not initialized?

Thanks,
Lijo

> Regards,
> Sathish
>>
>> Thanks,
>> Lijo
>>
>>> -            int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
>>> -
>>>               ring = &adev->jpeg.inst[i].ring_dec[j];
>>> -
>>> -            /* enable System Interrupt for JRBC */
>>> -            WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> -                          regJPEG_SYS_INT_EN),
>>> -                 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
>>> -                 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
>>> -
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>> -                        reg_offset, 0);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> -                        reg_offset,
>>> -                        (0x00000001L | 0x00000002L));
>>> -            WREG32_SOC15_OFFSET(
>>> -                JPEG, jpeg_inst,
>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>> -                reg_offset, lower_32_bits(ring->gpu_addr));
>>> -            WREG32_SOC15_OFFSET(
>>> -                JPEG, jpeg_inst,
>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>> -                reg_offset, upper_32_bits(ring->gpu_addr));
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>> -                        reg_offset, 0);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> -                        reg_offset, 0);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> -                        reg_offset, 0x00000002L);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>> -                        reg_offset, ring->ring_size / 4);
>>> -            ring->wptr = RREG32_SOC15_OFFSET(
>>> -                JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> -                reg_offset);
>>> +            jpeg_v4_0_3_start_jrbc(ring);
>>>           }
>>>       }
>>>         return 0;
>>>   }
>>>   +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int
>>> inst)
>>> +{
>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>> +    /* reset JMI */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>> +         UVD_JMI_CNTL__SOFT_RESET_MASK,
>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> +
>>> +    jpeg_v4_0_3_enable_clock_gating(adev, inst);
>>> +
>>> +    /* enable anti hang mechanism */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> regUVD_JPEG_POWER_STATUS),
>>> +         UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>> +         ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> +
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> +             2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> +    SOC15_WAIT_ON_RREG
>>> +        (JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_OFF <<
>>> UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>> +}
>>> +
>>>   /**
>>>    * jpeg_v4_0_3_stop - stop JPEG block
>>>    *
>>> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct
>>> amdgpu_device *adev)
>>>    */
>>>   static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>>>   {
>>> -    int i, jpeg_inst;
>>> +    int i;
>>>   -    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>> -        jpeg_inst = GET_INST(JPEG, i);
>>> -        /* reset JMI */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>> -             UVD_JMI_CNTL__SOFT_RESET_MASK,
>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> -
>>> -        jpeg_v4_0_3_enable_clock_gating(adev, i);
>>> -
>>> -        /* enable anti hang mechanism */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> -                      regUVD_JPEG_POWER_STATUS),
>>> -             UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>> -             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> -
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> -                 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> -        SOC15_WAIT_ON_RREG(
>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_OFF
>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>> -    }
>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
>>> +        jpeg_v4_0_3_stop_inst(adev, i);
>>>         return 0;
>>>   }
> 

