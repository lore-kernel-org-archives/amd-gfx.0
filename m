Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C39C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 15:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780C810E2A3;
	Tue, 20 Aug 2024 15:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m57iniZU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA8110E277
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 15:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbNi7LUABD0qejmodCByt+v0Wz0PenRz77ccm4zfUUIfwmftsg/OTxTnhkdIhhtATKOZ8FpH0Gb0ZcEH3UDVxhKBJ6BXsCJ0Gva+n6xRk5w95g/pZVoPRL1jjAHOJfEUUPm0bFRmqP0462dEDGqABEvz2Mu3KQk9kx0oGBIkti+Plt5pxqRu9QXUNMeKUwGFRlyRfVa7znmmv54WiTOgFr5Y38I7wyx0eL50ptLBIzyZOSjk1RcX7Ze+nDSAeIfMYI1+15QdWQ1CqzdegDtCOSbOHFqceuU53R10KjgQMIFHomQMrXApAennb/7dpiFEduKndTknBBIZJKOlhRXbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvxUaxj4hjR5HBHEDb4EfBbxWuXsoP2f62FNsiawHvA=;
 b=cfzCJI73hEeMELOU9jDrERHxTqdn/EA5n5Z7ugq9X5tDNLFsGGrfJdDmviu9nk8PZsRYewosRJFKd5jdRIDWcZ2ivJoe4rfxS5R9+KXz3aHTLL0kZw2QyasZnU/tVZKqIawpPNr8D8+wGHAJk0v3jizGbYQRTvUTHDH4xuquw58JdRBPI580o5k2tHymr1vWD+nAEX72eC5hYzVIr6cR8YNvPx7ba8TYDWEi471ogmk81p+bw/KqTO5GjetnYhyLmL+EvmyDp4cGUuyKcoJcb6JyK/yV4kZYz35PeWkIDP1N80B/7M2YhqsCeRE362dQIQjgbgtL1oiGoQ1IAMrNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvxUaxj4hjR5HBHEDb4EfBbxWuXsoP2f62FNsiawHvA=;
 b=m57iniZUkZ9GPGOeBi6FfoDZXYoVxozPcWivhsjOYvj/9ngKOQF34xeDu+z8+Dy9X/CmYKrDBzd3QkXBoKtvWSB0u6kLSjxVmRJdhHVG8X82LWKtjwXNbsJKu8KlOidTkxRU+nw1Q5ZtAo/lc59GW6DXUa+S/BMM0k4yFwSeKxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 15:31:30 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 15:31:30 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
To: "Huang, Trigger" <Trigger.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
 <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
 <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <cc16efe1-5de5-20bb-8556-143a121de6d0@amd.com>
Date: Tue, 20 Aug 2024 21:01:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: db47a950-34a2-4e70-6aef-08dcc12d2a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjgyOW1XTTQ2WU5FWHZtSUhqZkx5ZWk0QXRxWmZnajZYZUJuMjV4MVVub0sz?=
 =?utf-8?B?YVlqMmtiQzFKSHlaYWRjSXN2bitOTmo4NUtDV1hWMW9ISXc1UWw3SzFYK01E?=
 =?utf-8?B?VlFoT2E0czMzQmVrN3dIMmZFSTZyaDJtNzlYRzNzMzZSeGlicHlobkZmd21P?=
 =?utf-8?B?Vm1SSDdoaTFORVphRUQ3SWFFLzF3OWpZbDM1ZlB4Y1Q3YWt6UUtYd0ZEK2R6?=
 =?utf-8?B?ckIrQm5weXdZMDJjYWpzUVhhL1RGZkoxb3BCWmxZM005czlmYTBQUS9XWlBZ?=
 =?utf-8?B?RnZhSGMraWJsSzZtNEJ5cWZCWTUyaWY2MGtJaFdYdVMrb3IwdG96NkorUXVv?=
 =?utf-8?B?SW44Nnk4TWphL3o2clpRVjBmVkIrZGpFQkZZcXNmWEYvSllRY1JzZ3IrRTRR?=
 =?utf-8?B?TEdkU3NkRjdyUEdMMmZpeXMrWFBtVDN1UFBXOXJCWU4vMnphTkcrNVhSQUZN?=
 =?utf-8?B?NCtwWjVDVGpJaWxUaWhpVjhNSHp6ZDE5TnN2WVdCaURuVGpDbVpsc2R6emg2?=
 =?utf-8?B?T2d5UnlpTDd3THNIZlVkblNRNzJVeWVVTDBQNzBWMFI3SytMTVArRVNoeDJO?=
 =?utf-8?B?WUliYytkS2lkRVRvc3lYOXFKdlJEbFphcjMrTGxsUFhhaUtaZnk2RkVxTzEr?=
 =?utf-8?B?VzYxejdJZytsR3FGbTA0Sm91bGhoUzZWdkFtNzJMOEZCamhwMi9EZWk1KzFk?=
 =?utf-8?B?em9ON1R5RUY0QVY1ZlJiOWJ4OVRuSkJTVzJBdzdjQ3oyaThNcVFtRzRMeEpm?=
 =?utf-8?B?ZlpCYmZFRWVLR3pwMlJhSmRPN1RyY2VnSkpDZnErU3F1UWFGUWVvZTFFSjVR?=
 =?utf-8?B?a2pZUStPOTJNTkdhZmlmZ0tlSjcrNG0rWGUyUmhJSU1PaFRBbW1HYXR6ZjlP?=
 =?utf-8?B?cy9oZGVySkxVcVNpKzZhRUV0YnRLLzdVTGhIWnNzazdqSWwrMWI2bWthQmoy?=
 =?utf-8?B?YjJEbGU5YWUwRmF6QzdMS2RxZDl1NER5eUxsR3lyaEhkWXBPemhuOGFGWThN?=
 =?utf-8?B?STQ0QUxncVczUDl4NnpleGhBK01lZUFXVm1SMEJDVklLYkkzcWt0blJ5U2Jl?=
 =?utf-8?B?Ti9FQU54aWxqMGU3QjZtdm5SSERqWlNtRDhrOEZRL2ZFbzkwbGZWdWRIRVJt?=
 =?utf-8?B?VzUwWTkybDJSVWIzc091U0JNcTAzc3JOTlkrL2VJd09WYmp0V1FFdlgvSHVE?=
 =?utf-8?B?NjM5VTIzd0RXSk1HN0w2bHZjaTE4eTBCUFBYZVNaV3NyRDkzcC92SHIvaUhD?=
 =?utf-8?B?K1JQeFB4eEFNL1J2cTR1S0psbFhSaVIvVFdlb3pMU3ZCSFozL2UyTk9TNUVO?=
 =?utf-8?B?VVNUTUdmRTZ1K2crNWRJZ01zUFJna0ZveFc4NnU2L1NKT3JDV0JQSFh0RWIz?=
 =?utf-8?B?eCtDZnFpdDB4cGdiTFAzUkFNdW45OCtycWJBL1d2T3pSZVVyRENEcHJhS2Fh?=
 =?utf-8?B?VmZtQWRmU3VWbmdpcjVlWXh1cjc2alRmdlpNWEFtS0NXblZwVkxRbUl0c1Bq?=
 =?utf-8?B?aHVjcmR6S3duWld2NDNXc3l2ZU1YYzdURk1MeTBrNWI1eUJlK2pZOWcrelo0?=
 =?utf-8?B?V1YyNGFJMjc4enNyZVhJYzlzZmR5OURmRjlVQStkTVlBdGdQMm9uTGVQdlFH?=
 =?utf-8?B?b1FoUEs3VWYvZlRCeFNnM0U0d1NkeWRoRndjZkNkaUh1ZThLdk9pZWZhZWxr?=
 =?utf-8?B?WTVUMjQ1MGNvZmk1QXZRakcySmVJbWtYbDBHWjVBV1Jpa3paL3FjSW44SUZW?=
 =?utf-8?B?aEljejRyZHBRcXNJL3lPV3dwRk80d2g5NTh1UHkvemVsZEE2SnlpTEdld1p2?=
 =?utf-8?B?RDVsaFRkbmk3NGdMS3Nudz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZlb3RVb2JCZ3JVU0lMN0VFaUd3Mk00K0w5eU94K2IraDUyZFd1WDlpalBp?=
 =?utf-8?B?aW9YOGhpMk1neHNIQ1Q4N1A3VkFyTXBYVzA0MWJYRGFnRTMwTERPaGhxTmhl?=
 =?utf-8?B?eDJYY2tsOHh5dXdWVEZIVGx6ZDlZcHl1eXlFWFJwSEIxNXNxYUkvMHRrNjBZ?=
 =?utf-8?B?OW1qbEh3cDY3anNad2lidDl5T1kwN2FCWGVrRkpkNGtSbzBIRU1CM2prQ3Fq?=
 =?utf-8?B?WEM3RmJ5SEpUYUkrZi9BeGlGa0gxWlVQVjZYaUNUdHVXUkhqWkRibU5wN0ow?=
 =?utf-8?B?ajVnSTV5c1NqZVlrMHBLYS82S0t0YjVTL2EzZWh5eitnSHJQZTZUUzFrSnZi?=
 =?utf-8?B?eVNNZkVUTFY3YkpnenR1ck5qSmR6NGVUMkIySjQ4TlplWG9PY2ZIV0h6OUtn?=
 =?utf-8?B?dk9ZTGlpUGFEbkVsMTNPTnlNSDRXWjV6UzFVUzNBZHl5V0piUTU3T3dyMFg3?=
 =?utf-8?B?UFVFTjJiaHdTdS9zRnpHK2xpczFCWUhoZFFGeStnSm40T0xOQ3ZFRVRZVWNI?=
 =?utf-8?B?N2k2SEVZT3U5YTVCS0xGMERzYjVpMUdjNGx1a1ZxdUdrVWsyYkN6b0ljbTkx?=
 =?utf-8?B?a2J1WEFVdmtZKzhaQkFwTk82STZaUFR3TWY0OU0wRHAxRkxpc1U1UWxQcXRR?=
 =?utf-8?B?Qzlra1VSNVUwenJQM3JjRDRqVlZwUkRkZVAvN0hCVFRNcjRjdG1wVHA4NEtk?=
 =?utf-8?B?L1Qzb0ltME16b283U245TUxjOHlKRE5HSnd0ZFlKTmhDdTlyWU1EdFZaUFd1?=
 =?utf-8?B?THljYkFsYU90aHdCUUR4Y2NJTURrQXZrL3ozQW9yY3UvbFVaYXFZU3REb3dl?=
 =?utf-8?B?L1ZFb09LR1pZQ0huWGd6NWxLbVgyU1FnK3M3a292ckY4RkJxSy9abXJoUi9S?=
 =?utf-8?B?UTkzUmp2Z0R3bnhwUHpUc2RXd0dsT2N0dHM5TWphb1NqTjNpclczeVdJNm0w?=
 =?utf-8?B?Z2lJZnZzM0RNMXRPMGtVSll4N2xhWlU3RHhjbTVVVGlrcXR1TmtnVmM1NWFv?=
 =?utf-8?B?NVgzdnhpWWx3QXkvN01zK0tUeHJCckszT3F5VlB5bWNvOTV0V3NldlIzN3p2?=
 =?utf-8?B?QWpNd0RjT1NMMkZaQVVhNW1NRDJzbXRDQzJCeWlDY29XMzYzbDlXM25WRnlN?=
 =?utf-8?B?WU9vSlFYVUZZOTlzVWxDTld2NDNRSDZGVkJ3WDhyL0hBM2prOUF6TFQvWUxC?=
 =?utf-8?B?aUVSL3lHWXhUeWRpc0hNUS83Q3JQVnl5Nll4WEZrbVVNTTFjUndRejhmTUdJ?=
 =?utf-8?B?dUhaUHFUSUxOYzFRbFV5bUw0TitZMGYyTHBSNzFUMzN4RlB6ZHZmNXRYK2FV?=
 =?utf-8?B?SUZWUnozSWlXbU5uWUV4SnZFYmY3UTJwSW1JOUxXTUhmZWRTWGlWWEN2QUsv?=
 =?utf-8?B?THg2clpraWtwOW13cFptSWFnOGVnSTVUZjFNYVB3cjkyNFNRNy9OVUg1ZSsv?=
 =?utf-8?B?SmszWmRxQjBBS25NMWtzWlZCeVFMQi9HRUZHc1Q2NlBiR0hHaldjbTRYdjVz?=
 =?utf-8?B?dFhFTFcwdXVsREx3Z3pPMmhvazJ1WDhiZllyUnhqZjVrbk84UFQ2dGkvbXht?=
 =?utf-8?B?L29sbE1TZVNTbDNtQnFnZEI1VTJHVnlNQ2hWa1o4VTN0WnJKOUgvNHdzS00w?=
 =?utf-8?B?UmdBODVPRnM0aUtKYS9yWkFkTkFIVmFibzFBQ1pNcmV6WWRoeXhQaklETHZa?=
 =?utf-8?B?NFlmQXZRdndWTE9qTGRCUGx0UDVmNkNtOENmOTJubTAvVmVMc3Q0bnhCcXc3?=
 =?utf-8?B?T01UVWs3a25jTFcyc0pSbzZ6Qjc3YXRDRVFYTnRoakwvZS8rb29MTzZmUWVu?=
 =?utf-8?B?THMwZzI5NjNGRmw0djdZOGR0UXBQOHlTdWFhaVF0c3YvbndwdkVTeVREdGx1?=
 =?utf-8?B?Z0RMbDd0OUN4RXRRWDhja2dwak4wdFhlUnVWbzJWMlNUOUpqN3VtRHJtdFhF?=
 =?utf-8?B?bENNTDFycFRNSzNUYnRCWGkyMjhSY1JSKzNYdGVtdGNDNTFITlBWTXppakdQ?=
 =?utf-8?B?dGRVYU1EcVBzKzdtNTJtK2hOa3MwTmorQXJ5OXhaZnpTdURzVVRaL0FnZ3Zo?=
 =?utf-8?B?SG5rd3d6dGc3YW1IOEpUcy9mc0ViYzBjVVVDVmQwUERJeHhHVG5yN0p2c0NQ?=
 =?utf-8?Q?nUvaXQ3BANfr6pJMTHEug2YP7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db47a950-34a2-4e70-6aef-08dcc12d2a05
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:31:30.5541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNQlFDTlsYHjN7Wu/AQH5N9tH8a6Dh7laqJ2s4kPLoo7NhQ8iUlIhSTjPmeudLhvruKczwieJvv29mvP/l3iuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
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


On 8/20/2024 1:00 PM, Huang, Trigger wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Monday, August 19, 2024 6:31 PM
>> To: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job
>> tmo
>>
>>
>> On 8/19/2024 3:23 PM, Trigger.Huang@amd.com wrote:
>>> From: Trigger Huang <Trigger.Huang@amd.com>
>>>
>>> Do the coredump immediately after a job timeout to get a closer
>>> representation of GPU's error status.
>>>
>>> V2: This will skip printing vram_lost as the GPU reset is not happened
>>> yet (Alex)
>>>
>>> V3: Unconditionally call the core dump as we care about all the reset
>>> functions(soft-recovery and queue reset and full adapter reset, Alex)
>>>
>>> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62
>> +++++++++++++++++++++++++
>>>    1 file changed, 62 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index c6a1783fc9ef..ebbb1434073e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -30,6 +30,61 @@
>>>    #include "amdgpu.h"
>>>    #include "amdgpu_trace.h"
>>>    #include "amdgpu_reset.h"
>>> +#include "amdgpu_dev_coredump.h"
>>> +#include "amdgpu_xgmi.h"
>>> +
>>> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
>>> +                               struct amdgpu_job *job)
>>> +{
>>> +   int i;
>>> +
>>> +   dev_info(adev->dev, "Dumping IP State\n");
>>> +   for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +           if (adev->ip_blocks[i].version->funcs->dump_ip_state)
>>> +                   adev->ip_blocks[i].version->funcs
>>> +                           ->dump_ip_state((void *)adev);
>>> +           dev_info(adev->dev, "Dumping IP State Completed\n");
>>> +   }
>>> +
>>> +   amdgpu_coredump(adev, true, false, job); }
>>> +
>>> +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
>>> +                            struct amdgpu_job *job)
>>> +{
>>> +   struct list_head device_list, *device_list_handle =  NULL;
>>> +   struct amdgpu_device *tmp_adev = NULL;
>>> +   struct amdgpu_hive_info *hive = NULL;
>>> +
>>> +   if (!amdgpu_sriov_vf(adev))
>>> +           hive = amdgpu_get_xgmi_hive(adev);
>>> +   if (hive)
>>> +           mutex_lock(&hive->hive_lock);
>>> +   /*
>>> +    * Reuse the logic in amdgpu_device_gpu_recover() to build list of
>>> +    * devices for code dump
>>> +    */
>>> +   INIT_LIST_HEAD(&device_list);
>>> +   if (!amdgpu_sriov_vf(adev) && (adev-
>>> gmc.xgmi.num_physical_nodes > 1) && hive) {
>>> +           list_for_each_entry(tmp_adev, &hive->device_list,
>> gmc.xgmi.head)
>>> +                   list_add_tail(&tmp_adev->reset_list, &device_list);
>>> +           if (!list_is_first(&adev->reset_list, &device_list))
>>> +                   list_rotate_to_front(&adev->reset_list, &device_list);
>>> +           device_list_handle = &device_list;
>>> +   } else {
>>> +           list_add_tail(&adev->reset_list, &device_list);
>>> +           device_list_handle = &device_list;
>>> +   }
>>> +
>>> +   /* Do the coredump for each device */
>>> +   list_for_each_entry(tmp_adev, device_list_handle, reset_list)
>>> +           amdgpu_job_do_core_dump(tmp_adev, job);
>>> +
>>> +   if (hive) {
>>> +           mutex_unlock(&hive->hive_lock);
>>> +           amdgpu_put_xgmi_hive(hive);
>>> +   }
>>> +}
>>>
>>>    static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
>> drm_sched_job *s_job)
>>>    {
>>> @@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>              return DRM_GPU_SCHED_STAT_ENODEV;
>>>      }
>>>
>>> +   amdgpu_job_core_dump(adev, job);
>> The philosophy is hang and recovery is to let the HW and software try to
>> recover. Here we try to do a soft recovery first and i think we should wait for
>> seft recovery and if fails then we do dump and thats exactly we are doing here.
> Hi Sunil ,
> thanks for the suggestion, and that's reasonable. But my concern is that after soft recovery happened, the GPU's status may change(take gfx 9 for example, it will try to kill the current hang wave)
>   Actually, in most cases, a real shader hang cannot be resolved through soft recovery, and at that moment, we need to get a very close dump/snapshot/representation of GPU's current error status.
> Just like the scandump, when we trying to do a scandump for a shader hang, we will disable gpu_recovery, and no soft recovery/per-queue reset/HW reset will happen before the scandump, right?
> On most products, there are no scandump interfaces, so core dump is even more important for debugging GPU hang issue.
>
> Regards,
> Trigger
>
>> Also we need to make sure that the tasks which are already in queue are put
>> on hold and the their sync points are signalled before we dump.
>> check once what all steps are taken before we dump in the current
>> implementation.
> Do you mean sometimes like:
>          drm_sched_wqueue_stop(&ring->sched);
>          amdgpu_fence_driver_force_completion(ring); // Since there is no GPU reset happened, is it reasonable to call it here?
>          amdgpu_job_core_dump(adev, job);
Before hard reset we do all those things. But i guess we may not need 
that in case we capturing before soft reset itself but you need to test 
it, to see the dump values are true or not.
Also apart from hardware state we dump a lot of other information like 
ring buffers and in case jobs are still submitting we might be not able 
to get the right data as the ring might be in use and being 
consumed/filled up that time and that's why scheduler stop helps. But in 
case soft reset is successful we do not want to do that.

So here is what i think but Alex please suggest if it make sense.
If recovery is disabled : Capture ip dump before soft reset. (Give close 
register state but ring buffer need to be seen as it is in use as 
scheduler is running)
if recovery is enabled : capture ip dump (Current implementation make 
sure to disable drm sched and fence time out)

function ptr print ip state could be called to capture dump when its 
needed in both above cases. Right now print is called when dump is 
actually dumped which is when data file which is generated in 
devcoredump is read.

Regards
Sunil Khatri


> Regards,
> Trigger
>
>> Regards
>>
>> Sunil khatri
>>
>>>      adev->job_hang = true;
>>>
>>> @@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>              reset_context.src = AMDGPU_RESET_SRC_JOB;
>>>              clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>>>
>>> +           /*
>>> +            * To avoid an unnecessary extra coredump, as we have
>> already
>>> +            * got the very close representation of GPU's error status
>>> +            */
>>> +           set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>>> +
>>>              r = amdgpu_device_gpu_recover(ring->adev, job,
>> &reset_context);
>>>              if (r)
>>>                      dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
