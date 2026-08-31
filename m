Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B98C61DE2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 11:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837F389D30;
	Mon, 31 Aug 2026 11:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4CFR6ikk";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A91F89D30
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 11:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4RB2k+vv7RNYoshaNrgjnihHqSGDMHMQ0rMv4Zr1OzSAXSW1GQH2LOQgdfqgMkOl6VuWK694BSD0FdK6quwpzzhqEK5BByBG2ihkhDb3NHe9TThQxO2gkHeAi3yQS+8Alit/HHciPKzP/nevMK5GlJWlUcm7L9lREv86p05rG5VzwOFFct3737+8ADHWAM4D934Nu+sHf1Sdlu0VteGzw9UuYVim+DIKlHVZgsCJoMCGtaPPCbRAJInELBTgkNmkCu+Gticd9igMDiCBzFmfiYSONI+6kDY0wjf5Rr3JRhQEECnH/+dcbhulIWdSGQPz+v9TXiX90uryM4VNh6URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nnh5EZdWydHNr0DEmeSkd2sH5VmNcDNwdQknSApTiW4=;
 b=i4wtEgvaCm1oPy6zbijUVLcAO6tc9Q3KXquBNrZP6DBqmmgDjsS0Zmj5xUbhVjLfrXanQU6126/oL6raY453mOGnka+PyOEvKZh2G2C0KRbkJ63n5jsTZ2doQyw+qnpxPt35Q805n+mWkGGoE+k5Dvfvok/lo9PO017DSTwplCLm4f1oe9+ZQVOMK2GOTXGqH0XPoVMXOQP878KPUYW50/jFukJKmbzuPMsbUfP2OBHLy9fQWKzdcTo5DCFAWwWIlYZKqm8nDiIwUg65JViCM9VVMsWQ9hWShU2Y6vgT8hqd/WSaHM9uxl6SCenANih7p9p/4ibJD/NRPq1lxS8Miw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnh5EZdWydHNr0DEmeSkd2sH5VmNcDNwdQknSApTiW4=;
 b=4CFR6ikkw+d1w3U3+jVmUBNcygj6GwFpNmKbDmXkwE+hy4GbSOtrflE1qAZBZxZg44LwW8AY75q2NwBb0I56Gb6s/2Pi4fOjcry4lJj2WQylAC0DgygqXrf40oQ2YKHfCPtsY0ey4pRsMBkdYvGsu0EnnWRf16z/yN6J2FWH+AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:05:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:05:38 +0000
Message-ID: <0e34543c-4802-4023-befa-480b5452d92b@amd.com>
Date: Mon, 31 Aug 2026 16:35:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Kevin Wang <kevin.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260831043507.523599-1-kevin.wang@amd.com>
 <6041b95a-ac8c-4410-97cb-8eca51d20d50@amd.com>
Content-Language: en-US
In-Reply-To: <6041b95a-ac8c-4410-97cb-8eca51d20d50@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcd58cf-f890-4585-9546-08df074fca26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oN2Ql3UDr6o64we0tIaweVZAfriOD1gaOyNt4DsSM6zrYHHyi3izI4MbgjJBcKsYR4ZX3WuTl6zG+r6qVvQxndpdyXX3STbNKRvSzq2xHj2KabrWJt5OT3qetAJcbkLtu1RG9UMYlqQmQGlzxk/s+0r1izVf0CmNwS9g4vllpzQgmXaGqppvoZUqcUcs0on0L4HAIcra0sttnPVb/tNWOz1Oz/pIaGILfgaUbhtXDnmHWK66Mlj7wbheh26F7qAoMcxVilR8wYJ8+IYroQ3QMOTxKHRuDevlIKhPJgty88DiyvNbXdhvezs0qV7Bk50IxF6s40Wx0YBDJWSm91gHFgLrNpZ8zqiKqULZny4/ddCcLYB+0EDPgQ6yJJYsGLBAJdwcpi1GAZUTVoyals7BgrP5vYCkBwJAYf26FOddZTd8knDkFjZ5ajnEXne4YbXVIE8BzXxnDbbiyFeU+mdh/XVQflFtUy/R4fA7un4IirQkKHWoyVtpuQTMmQ0IRY4TVl3IOsH5j8sa2giaJC5sz88ZjestTrVg5ix5UdS/KvOyqgIXjuiOOHjo9Bo5B1EBGOKIos4E/B3VsnFGdCJ1M5rNsLK2w9upAX30Zrlqk10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVAzZ1RMMkswTGRJMXd5aVdqMC8wdThLNzBmM0Nla2F6U0M5NCt1ZGlRUmF5?=
 =?utf-8?B?cmZOeXFJczBjbXQ4YVFHQ1JZRHJYcmJveTZYREdGREs3Qk9tVzlxKzJzS2dp?=
 =?utf-8?B?d1l0emVuV1JIZ09yZFJXUHBsVlVzYzlQc3dTZ3ZDRTJrZWcySjNhdUxPazVy?=
 =?utf-8?B?TDFEalE5VUpsUTNzcGRBcUVjMTVoWnVUenJaODJJblI3enk1WXk3eit0eUFv?=
 =?utf-8?B?dnBOcCtrUGxNUnlpL0ZzYjlWK1VGd2EwZkFabjZLQUlwSXpOYUhrRXVaQWpB?=
 =?utf-8?B?QUFpejhrSjBIeVY2cURYSyt6S2hlMkRGNlNiRnM4dHREY0E0K3dzT1JBY2hQ?=
 =?utf-8?B?QjZFMU5hS2I0L284cmtPL20xajhTcnVFMHdCaVoyQ3BIbmR0MUFEVnZGajVT?=
 =?utf-8?B?c0NwQzRsa1N4b3lXWHV0UWtpV2dUVjBMWjhDRWh2TXhJakpCOTJtemlLVFRt?=
 =?utf-8?B?WmhMeHVWeVFNZEI2cVBYUjhMc0V1ZzlrMkhGZ3VXdEJXcUkzUDFPSlh5ZVJj?=
 =?utf-8?B?My8yVEgvWXl1OFIvZk5pbk5YWG9RdWtoV1cyRUpsemJiNGttOEhWa2owVWlj?=
 =?utf-8?B?RGV6Y2NEUWlKRnBmd1ZCZFN6RFZMWGtKQjAzRUtveTdvempHNTJsc0ppVlh3?=
 =?utf-8?B?Y25uQVJENkdad1FwRFNaZ3BvTWtZRVVoTWNRdnUyS3FjcUd5ZUd6RHBKWFE4?=
 =?utf-8?B?Q2c1K2RqbE1EeHdtQUk1SFhrR014VmV0NDZuWGdpMFI4RDdvRGVINDYxVXll?=
 =?utf-8?B?VWtmY1c3T3RaeHp0djNadEZMSFpoWTVsOTZXSDNFbE90YlFhRi9veVU0Tk5Z?=
 =?utf-8?B?dmkybTlOamsyMXVKQjg5RVVveGF0dlVLMEZPbTJXTnhTNC9Hd0UyNEdFdFBR?=
 =?utf-8?B?d3hUQ01zVnBMRCs0cDV0YWhsemsvUkhWYyt2eDVoelNWY3lJN2ZtRE9KRDQv?=
 =?utf-8?B?NUNQVmVhckxKSVYyUko1OHJnQ29JalAwbmtnbnloeXgyZ2lkRzBpbXp1bGFB?=
 =?utf-8?B?N2hhSUg5MDB0U1lDSC9lRE5laWlqNTFzWCtOemFNNHAySUxXZWlRUjBjTTdZ?=
 =?utf-8?B?ZVpaYWZ4Zmp2dVM5YktFRUVXSXdqQm1CNDcyaHFVS2VRMDBEbnUvSVRVdlpv?=
 =?utf-8?B?YTlzb2U5amhGalJVZHQ0eHNtQnF0RXlvaVpaaTdHVnF2YmdQQTltRXl6aHBJ?=
 =?utf-8?B?ZHoxYU5EaWh0QlpNMGlaTE1tTUJRRjN1TzRNblZqM21USURwb0xPak5CaTc5?=
 =?utf-8?B?bnRrS0tBdDlNVUdhaFdQVDlxQ1Bua2t3d3g4aFZibWRjQmd3WGtuY3VabFNV?=
 =?utf-8?B?L2RRS3V4bXh0Z3pvWVBjNGR1R0tZeUk4TzV3SkMvbHJtZjZDc1Z2UnY5TzlS?=
 =?utf-8?B?VGN5WFBkVGdiamVPd2NpSlpNeFBFZ2pLQXNkM3VQSmpRMmxRcmxuOFBvQnkx?=
 =?utf-8?B?VGtBa0VpZHI3SlBDZjh3VENCWTJEb3pJZUJBOUhDMit4S2VhZmZOZ0VJZGYv?=
 =?utf-8?B?eUMrQmxGNWJvbExqRFBXTjVtZmdPQzA5ODAvMlJpK2J4dGdXNlpKUFp4NW5o?=
 =?utf-8?B?RWkreUk0UFR4UU9ibERaTkxFYWVTZzIrYlh5Qjd0cDZMZ3FuTE9iZnFJQXFi?=
 =?utf-8?B?VDJyT01GMUt0VGNabFZJQlRRQ0RiYzNqSUFSZm1kZWU5L0t4Z05ITkt5a3Fv?=
 =?utf-8?B?eHRwZTQ0RzlKZEZsSmZITlRFSlBmMldKTGtBNjhhZVpyU0JvdSttWEluYVlZ?=
 =?utf-8?B?T3VDT091a3o1OUtLOXZnVGJua25IN3FuSHpBUmNoUzV2VVp5UC9OeW13SFZG?=
 =?utf-8?B?R21heEgzdXJwdzNhcEoxWUlPUEtqbVVleXlnVlBuMlBaTStIN1FydFFnOXJ1?=
 =?utf-8?B?OHpWNWVuejArK2pRVkF4c091OElpKzY3NitJMnNGbTV6OWY0Nk1OZjJLcWZO?=
 =?utf-8?B?WXF1TVlUZUkwdEp5akFuWXVOT0pUbXdTVzExcWl3NGk4cElRRnRDWmFUNjVh?=
 =?utf-8?B?S2Z5SVBlbU5MSW5lL212NWFiUEFmMDA4cXM3NmQyKzFMQkZNemNFeTN4MURL?=
 =?utf-8?B?LzJiSjVpNjNsSEdqVE5WWElmWUM3a05yaHdoaytnOFZwR2UwMGxVVlNCTXRG?=
 =?utf-8?B?STdWeXBka2QwMUljOXIzNkdISnRzSHJ0b1I1dCtpWm1vZFdLNHlmZlZlY0d0?=
 =?utf-8?B?YWhVbUJrRTh6UjVJS09ybGdTWC9yd2MvUXo2T1cxdFhwR3Btc2UyMjg4WUR2?=
 =?utf-8?B?enVDRUQ4OWU5YVpueUxTMHBtMjNMK3pINkRhT2cyYUpuZE03SFhvYy9CUjJa?=
 =?utf-8?Q?TJ6i9ZcFUnhF6aLyPJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcd58cf-f890-4585-9546-08df074fca26
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:05:38.6284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgwP5B3MLNU1Lw+/rc2gB1ZNDhOMz0B9EiTcEmcXZXHG8upARrlqe0uZl5LtSEK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721
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



On 31-Aug-26 4:25 PM, Lazar, Lijo wrote:
> 
> 
> On 31-Aug-26 10:05 AM, Kevin Wang wrote:
>> [Some people who received this message don't often get email from 
>> kevin.wang@amd.com. Learn why this is important at https://aka.ms/ 
>> LearnAboutSenderIdentification ]
>>
>> The pp_od_clk_voltage interface exposes a staged OverDrive workflow:
>> users edit clock, voltage, and power settings, then write "c" to
>> commit them to the SMU.
>>
>> However, PP_OD_RESTORE_DEFAULT_TABLE does not follow this workflow on
>> every SMU version. Some backends restore their cached settings and wait
>> for "c", while others upload the reset table or send frequency-limit
>> commands directly from "r". As a result, the same userspace sequence
>> has different hardware effects across ASICs.
>>
>> For example:
>>
>> - SMU 14.0.0 and SMU 13.0.5 stage reset limits until "c".
>> - SMU 14.0.2 and SMU 13.0.6 apply reset values immediately.
>> - Navi10 stages the boot OD table, while Vega20 reads the current SMU
>>    table instead of restoring the saved defaults.
>>
>> This series makes "r" restore default values only in driver-side
>> staging state. "c" remains the sole operation that uploads an OD table
>> or sends frequency-limit commands to PMFW.
>>
>> This gives pp_od_clk_voltage one consistent transaction model:
>>
>>    edit/reset -> staged driver state -> commit
> 
> Reset should be reset to defaults and shouldn't require extra commit. 
> This breaks existing userspace for SMU 13.0.6.
> 

I see that this breaks existing userspace for almost all of it. SMU 
13.0.2 also resets to the default clocks immediately, while others use a 
fallthrough logic to commit the changes immediately.applied.

This behavior needs to be kept as it is.

Thanks,
Lijo


> Thanks,
> Lijo
> 
>>                                                                                                                                                                                                                                                  It also permits userspace to reset a staged configuration, adjust one
>> or more settings, and submit the final configuration with one commit,
>> without temporarily applying an intermediate default configuration.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5690
>>
>> Kevin Wang (7):
>>    drm/amd/pm: stage od reset for smu 11.0.7
>>    drm/amd/pm: stage od reset for smu 13.0.2
>>    drm/amd/pm: stage od reset for smu 13.0.0/13.0.7
>>    drm/amd/pm: stage od reset for smu 13.0.6
>>    drm/amd/pm: stage od reset for smu 14.0.2
>>    drm/amd/pm: stage od reset for smu 15.0.8
>>    drm/amd/pm: stage od reset for smu vega20
>>
>>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 75 ++++++++++++++--
>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
>>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +---
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 85 ++++++++++---------
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
>>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 +-
>>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 50 ++++++-----
>>   8 files changed, 145 insertions(+), 88 deletions(-)
>>
>> -- 
>> 2.55.0
>>
> 

