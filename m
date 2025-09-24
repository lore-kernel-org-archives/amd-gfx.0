Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12245CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A571310E7B5;
	Wed, 24 Sep 2025 18:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ee4NAhKg";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5436F10E7B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOk2cnt6TooqxNBS1UxpOxYeNYChoVc+t7ulW0qSIxV+gre8hOm/SXekcq5GzzeFEBIItLQj0qXUrEG6m19AT+SoLG7XIKH4RW2m1Jg5/ga9jAvL2qg6IOvhJ30g4WpiA/eJAP5eCtTB/GU9omVb17HWrs9BmWzPbJKxjqweUtL4ka8dVO7fh9JWa5fVSLtWuWG+4t4uhWmKYEE/OFw3wE0EWfqI8oFvf9hqaOCezOAAN8Jry+8uq4svu3jI+16KRjvDeu20Dle1GCfrHOLg6HGZmb3aC2qilPGXEhoP//TeUYgqVgntmii49WXE22imXqxIYiywizAm3WKMEzT8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5wWA2pkuuGucUZTZVkImbPPnMDPLfeZKXacgQGpmXQ=;
 b=UWhNrrqR03HSuF98q1d7qKCmNBr1tpxJU3ZR70nHdnxoe/hGSU1nn37qneTUimMMJifWv/dZwqRuNpvmMHTjzIJS6cXMIGMxV0tentziAU0XYYvUQ/0KObKgQinnBhkNzir+p5dlT8khtjI7Ermhy0TBa0+VoW2iNipVcJPnkv//Ta3XY5yiPXGNHdkxQuzCiwQlzGdsL7y5usKzlxo6BSbMMFoiwksD5fYz1crK2VQ6pKpE2DnmwKspiXX6TElIK2XyCg1mwOpgMckVgcLSjuu8maEIrk+w7aNYMk1YkF3Dusc0MOcuzoDi5UyILoQAH1kGoq3ZKo0ko0tKq24BXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5wWA2pkuuGucUZTZVkImbPPnMDPLfeZKXacgQGpmXQ=;
 b=Ee4NAhKg7rCb6pwjYhM6V2VANwodAvBjyT7LDaCbXk4UYyFa1vlOqNo/JskYeiQeaW+nc9XGkeWK4oZ1E26uyBtkYBtHLoIikS/fk2V/jYgG7/6FeYMK3+K1T0/00fYwNOn3ZRSOU3ucMtvaPkw7zm2bgJYWzQQOjJvZnowhzZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:24:55 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9137.012; Wed, 24 Sep 2025
 18:24:55 +0000
Message-ID: <ff564617-e261-466f-a686-81e96725b4d7@amd.com>
Date: Wed, 24 Sep 2025 14:24:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
 <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
 <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: b65b7eae-b005-4173-512a-08ddfb97a8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnNNZWNJWmdxMEhjTms2Z2tVQW5ybWl2Smx1MnhKc0ROdnhBVGhkaWtPVFhq?=
 =?utf-8?B?Q2tpWmdQOUozbmNudjV3ZHNkSnZNbmdzZXZSWmZxS21rakZJZnVFRDQ1dW8r?=
 =?utf-8?B?SXEzU3ZtbENIQnZxK1drTnBkM0FRSVMzRnRIdmFDSnFaS2dPMzJvOHhNM2ls?=
 =?utf-8?B?T1FCWng3Mjc0SmtMckYwWFRwVkNpRW14S0VWaFZYcUFrZkVTNlM0Y1ZLeEIz?=
 =?utf-8?B?eDJZZkFsY0FwRjJzWWlPN2FxSkR2d00xZzBSeVZHRXhkbld3cVFFUlBDejkv?=
 =?utf-8?B?cE1kYWh4TmlJdFlycHJxK2VnTE0rZ0xwZitjR3FLam5palFtbnhOclEvZjFn?=
 =?utf-8?B?OWtSMWhRRCtUUEZFMnJPZ0xPM1BROGc5OHh1YTc5N2w0MEM0NFZQb2V3K2Jq?=
 =?utf-8?B?bkYrcnVTVjRvNTd5bGtJTnlXV1hPU0tZa2Rta1pnbFVXZXBqekR3ckZxekRV?=
 =?utf-8?B?MjlpdklEY0NWdkVtZHEweW1sbi9lYlRtMkMva1hxbmVSclJ6cDBONzdKMDJh?=
 =?utf-8?B?eGZ2NmNKODdTbFhTN21vdGNWVzhXbXhmVkRFSWdNRGx6dDExQzJqcnhkQmFB?=
 =?utf-8?B?RHFmaWMzbit4OTgrVTlSRmxsZjhzNXZJQzJoVXBaOTU5RUhyRGZDT3NMTzFj?=
 =?utf-8?B?LzM0b0k3SUtGMzFKTkh6N094blIyQ01jSHJOSGFVdmVVQkY3bm9IeThmL1NR?=
 =?utf-8?B?TlVCam5vaEQ5YXdDTEg0UFVEd2VSMzZhUmhtc2w0bU1HRmhKQ054V1JyTk4v?=
 =?utf-8?B?M1ZVZlZxdzVUQkszSWpQQ0Q0RldNTUloTkZMRHRmSjJ4dHErYm45ZDB5NEUw?=
 =?utf-8?B?ME43Y3VhM0ZyL09lMTVXTVVUVzVadjVoQXN0d0Rmem9CWFRsN25oSjFvY0Qr?=
 =?utf-8?B?eXR2VVpjeWN0ZVdzYW52YlExVVYweUV5cjUzZ0taaWRmL1Nib2s3d1NhLzNY?=
 =?utf-8?B?RWlSZGlOeUEvcTV1Nkw4NzN2YUNDYjR0YmtPc1JqS2VkVkRNaGJHTXdKNStX?=
 =?utf-8?B?MXFLc3dhay8rUmJ1bzNWNEcrZ1NVSmdIWVU4enZHUkt4U0g1dzRwSGdXQm1p?=
 =?utf-8?B?UnBOUHBtek9sQVdSUGNteFdsQ3UzYStIeTBmM2dRUlA5YkZiWGJ5SGYrclpI?=
 =?utf-8?B?NUtiYUhGZlNYcWpZMUZtN3JyUHEvcmtLNGlWcFNVUzBxaGlPUG5lemlScHFU?=
 =?utf-8?B?SHEvclRoekVkaW9IYjFGRFd5VHZkY25GZmc3YXhIOWpHeUdnTEJGaTVXK1dx?=
 =?utf-8?B?L05FUlRrNjl6cnprK0JoMFpmRU9FOUtYOXUwU2l5d1lYVU1nYlpwSVQ1ZzBQ?=
 =?utf-8?B?YUQwQ1ZvSUxGUzdKdWh1b2lzaVl5QzhWZzBTSWlVbThUL0JrelcvL0pVU1Jh?=
 =?utf-8?B?eHBzbnNOZkpEQjJFZmZaNUQwNjEvS2N6VlJqeGdwQmRnaVJRMzF2bk9jbWNO?=
 =?utf-8?B?dnRZYjJZclBoRm9tNVpnMmloZkEwZHZDSC9wUGVFVmIrTEppcXE0UlA0ZU5W?=
 =?utf-8?B?NFJHTzB2NzlMWlloWHVjdmxQZnJQVTlTVGNlNUx4QU5hSHRpU3FRNERpN2tt?=
 =?utf-8?B?dGUxZXpML0tTbUhYV1dSVFdIWDN2clV3OEpyZ2M1aUVVWW5zVS9VR0xucXEy?=
 =?utf-8?B?L1pMNldrRGdhNGg4cVc3VW43UmtIbzExVytlRy9UbmFxbTBXdUtRK3FwcWpj?=
 =?utf-8?B?SmlVQ010K0NzRkR3clYzSlAyUVl3L1p1ZExPelV0WnU5cXhSZDhUclFjM05r?=
 =?utf-8?B?cVhsckxCRXhRUGk5bEJUbTZmYXptNk0vYitMSTdNb3BBYTQ5eUd1QWlkNGFE?=
 =?utf-8?Q?lKZwgMKMTNn6NjGstihXjPb6uhbdJir71IENM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0RqQUljemloVVgrVWMrS1B1Y0kzR1ZtOGJJZVNnVW1sODQ4cllRZndHV011?=
 =?utf-8?B?NlJLaGhPUUMvZnY4d21oaHdtd2VYbFNEWVVoWTJhbGlOZVRyd2ZZWmtzd2Z0?=
 =?utf-8?B?V1ZJK0V1cGxNOWFQMUlqaS9mR1lEWkdIanNpRFNWc2hMbkYzZm1WZTVxYXhp?=
 =?utf-8?B?bjZJSW5MWlA5dWtFc2FVNnM3Qlp4TGRsbGpnSlFuZHJaSkJiR2IrdlM2MG9E?=
 =?utf-8?B?MW9LdEhRM1VMcUwvbElYaFFQaW50ZGJNK2xPRWlsZVNZMDE4cnlMYU9XVmc3?=
 =?utf-8?B?dXZVRmhRc2dFei9UbmtEeHV5L2dTN29uRlZTaUl0WHFGbCtwb1J4a3hSeVRY?=
 =?utf-8?B?ZGV6WVRQY0g4ejNEdkJpeGZqZ0tRYkVYaFdadnlWTk5WT251MnlpT1NoY3Bo?=
 =?utf-8?B?UFl0SXN6UWNwa1NTUSs1RHRjNEJIVUk4T29PQ2pyb0pxb291b0hwbnRhRWFZ?=
 =?utf-8?B?Vzdaa2xZWGtBTTllM2d6NUh0YXduS2c3TmR5REZtRnNrMThSb0Q3cGtiTmVT?=
 =?utf-8?B?UTh1bkRsREFucXhvRHYrUHRSTEN2eHBEQy83UUNRVis3QVJwWHlhVll3U3hM?=
 =?utf-8?B?TFBlSmcyRFJGc2hGVXBtSHozZlc1VkxoQkIyNUVXakdHOHhxSWJiSzJZdERr?=
 =?utf-8?B?MVNPQmc3UXlDNnBrckkzYTBGcWh2Y1Z4WS9QVFNpU2RnWXVyNUhTeGdFN1dn?=
 =?utf-8?B?MU53T01BOE9LeWd0L0tKWnpSTmNNTGo1VkdSSFRlWWgwQ2dydHpWVjl0VDYw?=
 =?utf-8?B?Um5Md2lTN0FJbTE4L2tDNkRIUUJxYzdhUklDd21UZFc4cS9tdGVkVFRRYUlU?=
 =?utf-8?B?WndtbzJ4RjlYRUlrQSs1M3IrVW9WQzRZbC9Fb05Xb1dxY1hpb1ViM25oRFI5?=
 =?utf-8?B?cWtRVFBPMUZlbVpMbkdJaE5UYi94WG1zWGFYZGUxUVhkSndlK3I0Wi9kZTQy?=
 =?utf-8?B?VW5yY0d4d1hObkZkc2ovTzVsSWpRaFZRSjF0Yk9QdnRibE9Ha0lPVVRGNnlW?=
 =?utf-8?B?T090cWM2VXFTTjBFUTZ0MzNxMFZCc1ZVL0ZQc3B4UmJ5bTVpTnl0NURvMm4v?=
 =?utf-8?B?b3Y1ZEZJQkYwUEZwbzZwWVkwUUZNVzRzVW5oa3ZSMHRuOTljanp5QkUzOGly?=
 =?utf-8?B?bFRNa1hhMGJyMm5zbjhIamlGUlp3aFJMNGZSaXdNUkRCbVkzUmprcFNncU8w?=
 =?utf-8?B?ZjgxVGxkaTRWeUtnUUNnbGoxYVpFN2Y1WEdZZm1PbWRzVGxtV1lBMEIxS3R2?=
 =?utf-8?B?b29YMGFONmJVbTdKZFdINUprNGVzYmF2WWxGeDdpeXZnekt4a0FWeUNqZ0Nz?=
 =?utf-8?B?Mkc1OHdLQlM3UmR6bE9nejFwUXdMSWp6UmdBYnl3RUdMeTZFM21ZWmpkNG50?=
 =?utf-8?B?a0pxeld1WEZsdEg3bCtHU1RBQjArOUZIemFwa2JHakEybkVCSm1zTG1sZVZ0?=
 =?utf-8?B?R1BMMjJuOVdRV1cyMHA4T2t0K3ZkbWYrdmpFQ05NTjRpUEkyT3EwSzI4RVN1?=
 =?utf-8?B?R3RRSnVTWWJjcDNpZ21tNldCZHNuS1gxUW1yRWpKOFd3VUVOcmFQRUxHYVhZ?=
 =?utf-8?B?VGJwRjhvbjFCRHlPd3FXV0w1NGptTTRHS1RxZ290T3JtNktEb1NzRVEwanpS?=
 =?utf-8?B?Lzc4bEZzb3BzMldDeXZvWmFwalppZGYwK3lFRHp5cGNFNkFlODVJNzdJSkNx?=
 =?utf-8?B?ZmttNlRkQmU3ZHFxbzg4OXEwTDdyT1MvRzlzK3NXcGU3NGZrRjdiWDBYTzd4?=
 =?utf-8?B?NDJCbnRQdndYOFRNZ3R5bFhDdi84UFZJZzVuaWx0M25aTjBaamlUS3hCTXBz?=
 =?utf-8?B?MFdlejFTMmlIZXdVNzNBeW56aTNxQS9DQ3MzRkc1a3c5M21BUHN3UUtwa2Er?=
 =?utf-8?B?bW92c0VkUWlGNG9kMVl3ZVVPcVVtN0dwYTgrVjAzZUdDMEtKcXBtZTBNaVBM?=
 =?utf-8?B?eEg3SXFuNjJQUVBaREtTelQvKzFkaUpDbmVtQmpLeEt6dUR2K3dNbFVtSS84?=
 =?utf-8?B?Q0dTTTJTcTVYeEowSk5YZksyNUN5bk9Tc2FKRTNVWWZkeUZpcE5YVW5Qa1ow?=
 =?utf-8?B?dmJSSjU3VFRhMFlmcG02emoyWDB3OTltTW1YN0FOSU5BaHQ5ZzExOG10Z3Zw?=
 =?utf-8?Q?CgiLcrJp568SVU6pZDyhwBKDV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65b7eae-b005-4173-512a-08ddfb97a8fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:24:55.2283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyQV55EPaQaeuy+s42C0X2R6f6Wbk0OTANY8xHTVVbKKWGnI1Ibv7M1KqbcjlbMTfvuM7USbRNb0IimAhrzc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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



On 2025-09-24 13:48, Mario Limonciello wrote:
> On 9/24/25 12:33 PM, Timur Kristóf wrote:
>>
>>
>> On 9/24/25 19:21, Mario Limonciello wrote:
>>>
>>> On 9/24/25 12:13 PM, Timur Kristóf wrote:
>>>>
>>>>
>>>> On 9/24/25 18:16, Mario Limonciello wrote:
>>>>> As part of enablement for SI and CIK in DC Timur pointed out some
>>>>> differences in behavior for common mode handling for DC vs non DC
>>>>> code paths. This series lines up the behavior between the two
>>>>> implementations.
>>>>>
>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>
>>>> Thank you Mario, this series makes good sense to me.
>>>> My only worry is this: is it possible that removing the common modes from connectors like DP, HDMI, etc. will regress somebody's setup?
>>>
>>> Possibly.  We're not going to know until we try.  I generally prefer not to add common modes (hence why I tried to drop them before until we hit the Xorg bug report).
>>>
>>> If someone complains about this then I see two other directions we can go.
>>
>> Sounds good.
>>
>> Considering the non-DC code already didn't add those common modes, I think it's reasonable to assume that we would have already heard about it if somebody had issues with it.
>>
>>>
>>> 1) to make both DC and non-DC paths apply common modes to eDP,LVDS, DP, HDMI.  Make them not apply common modes to VGA and DVI
>>>
>>> 2) Enabling common modes /across the board/ but anything not in the EDID gets the GPU scalar turned on.

I was surprised the previous approach failed, which seems
to indicate GPU scaling isn't already happening. I wonder
why. I think this would make a better default behavior
instead of relying on monitor scalers to deal with
non-advertised modes.

Harry

>>
>> I guess we'll see if any of those are necessary. For now, I'd propose to just consider adding the common modes if there are 0 modes probed. But I'm also OK with leaving that for later if you feel it isn't necessary.
>>
> 
> Yeah if something comes up and we need to weight it out we have this thread to refer back to for our ideas on what to do.
> 
>> A slightly related question, would you be OK with changing the link detection code to return dc_connection_none when DDC cannot read an EDID header on digital signals, similar to how the non-DC code does it?
>>
> 
> I personally think lining up all these nuances that are different between the two is a good idea.e e
> 
> But for that specific question that's probably more of a Harry/Alex Hung question.
> 
>>>>
>>>> Two possible cases come to mind:
>>>> 1. When we are unable to read the EDID for some reason
>>>> 2. When the EDID is buggy and/or doesn't contain any modes
>>>> Are these issues real or am I overthinking it?
>>>>
>>>> Thanks & best regards,
>>>> Timur
>>>
>>> Failing to read EDID has happened in the past, but I think with the deferred aux message handling that should be cleared up now.
>>
>> I was actually curious about that. I saw that issue while I was working on something else. How is it deferred now? Can you point me to the series that fixed it?
>>
> 
> There's more patches than this one, but I believe this was the 💰 patch.
> 
> https://lore.kernel.org/amd-gfx/20250428135514.20775-27-ray.wu@amd.com/
> 
> 

