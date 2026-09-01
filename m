Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BA2C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 21:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A6B10EAE6;
	Tue,  1 Sep 2026 21:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xv2jTt/9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876B010EAE6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 21:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJCca+lfFB9r17a8waLqrJZ+a8qgM77vlEVSARn3Z1C3f34eRJqAaGf/4DxRPuTrDOJexIVnBJ/cpKclHqr73V+fJMRmmS805NGrxfmHfxyEwL0kuuUNeot/hVpemnFadWP/JM0vO89uzjwI653eIQpU3cd02zws6aqf36NVGKuDDW1xt0eeEvSgjiTGKQ3sBz+hUo6J4vHdh95++rL6atEQnochXBGvRdVla7701f8SGC/ZeUe792+Ru++phLqxCRFns1d69ortWDjtsjpT0i745oWk2LidSIeYeE3Rjmigii6XGbrReCShTzKtt4RClC9gnFB7WVxA9Dfjr3DIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UOxEKROtH159qqXnp1ZHgdpM/v2zWxZx1SO8cuz1Tk=;
 b=sG/t0xIzPqrS5NyLk7NNOjL4P4jIWwULUbWkE2dGU4/vE/Ma4YZ7GRaEL7jvbR3p+B78QoKJuCCqICJ3PRWqvWE+iXMoKBxFN+JUhFT3uML5WWOgooqmTh2LYDxHzSssUoVlZVibqrIxnjGyX/6+0AJ9+0CcoKRARyal1zGJoCKfavSs9U9aud/U2CZNEEJ35QRiqhKsfc+Nskv7TPAi+cyIVh1PjhP/IjKHVSmFV7SgWJhDNLzRIAlEAPuUqZJdD3Co5CkwsuHqRljZOHt2bmlVmtFSn5kFq9df8arLrxQ7eotExMYUV/IofY0F3beNi4TIsl75JNCQhKSOkeQjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UOxEKROtH159qqXnp1ZHgdpM/v2zWxZx1SO8cuz1Tk=;
 b=xv2jTt/9yup8imdK3ajXXOXQv2ciRYR15PPFXsJwRFiJ3y51quQXrdfBF9Yu5Png89XkXWR60rTBUaZt1LRgDZqFTXTpTNOGoqK+HpSnMLvEXRo4ZuKi8U+6ChQyHsFjwj74wLPi3fF7OO3h06lAnVhYdImUJmhTdAPNWq3GD74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:04:29 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%4]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 21:04:29 +0000
Message-ID: <6ba4f403-9001-47fa-b25f-3f4a81ae3077@amd.com>
Date: Tue, 1 Sep 2026 16:04:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race
To: Gang Ba <gaba@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>,
 "Ba, Gang" <Gang.Ba@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260831205059.1803721-1-Gang.Ba@amd.com>
 <BL1PR12MB5898416E809BE5392EA63D9A85A82@BL1PR12MB5898.namprd12.prod.outlook.com>
 <037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com>
 <9a353fc4-6947-4a5b-bb37-ee6e17529ede@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <9a353fc4-6947-4a5b-bb37-ee6e17529ede@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:806:121::30) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 97549668-5442-45ca-1668-08df086c9cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Hd+UWwyXb3TCupwTKABMNtfoyiuQwQZiEfDneRtRgThiH2q0fX4U92tE7/Mwt3s5okJleVaGqJSMp2OiwGjken0hTHqIrPISv+GSlG9i766raV9o3WVf8JZf78s3nuqYywAhESRml1wHGK6hZPbYkl13iJjS8RpHVft6Pgg3RG4so16pP0qXjaPViybEFjYlLHIUQBasu9h1ImPTipTJ+1EIzTjGlWF3h6wlc08nmbNJ5J+i5R47QSHWinsxsAj4qrXzp9yfncjqfuZ8cWz6fcDtC5EARah7WoEpd8vTFRWeedJaHqkeWUyA1KuHhFBwgrjqycHr0muMLYK9397rCYCd1rzSmuDbfF/c2Hhji53udG9eWPh4sZW1sojWkobXbnXoRj9RIHUeWK+JlQo03J/bOHrxoCccyhlfEq75v4PyT18P1Zq1pGLR0UWYYXOfg5BuOy/nwLK7xZSxO/XhayZdHHanN6jjk6CrFIYrDGYxzDlDqBH5hNi4/uYD2IvMgCzhMQ/WFc1062ZRykexrKbK5gi1IdSIXQdkqJOl4GnXy7gjZkLeld9gUOj2kXAC4v6zqqf16MOTIKCi6D4FkU4065Pmgi3UlbsaeDMqB+0VYn6db1o1awL/AtyvgwV/BFNeajUBIPLv29r7rfmSOukndXEmIOUhJCOs9K4fir4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlJd2pjY2F6cHp2T214NDNUZ3ZlREM0ekM5M2NoRmhORmtnY3hDUkxXdjJZ?=
 =?utf-8?B?ZjlOS25JSk5oVjF4UTcvNFZ1Z1hzRDRYa0F0RUlwNXRvOFZVN0l3WHZIdzlL?=
 =?utf-8?B?bys2RENLaFQzbVI5cEJES2xSZDM3OEMzQmtGVTEvenRyVDEwTnpnTXZqUmFI?=
 =?utf-8?B?SWcrQlFyam1HUjhZcnZDSy81QitYU2ZaQXZWUXd4Ky9DTis5QjA2dTY2N055?=
 =?utf-8?B?TmtIN281ZDVhcXVJWittUjBKU3g2dmR1T281bWFDWW1scEFudVdHQVlnT2dz?=
 =?utf-8?B?VHVlTllkSW9jUFBzS1FJeU1hRzVmQzBBUlJZVXZHK0lTQzlBVGp6UFZvVmIy?=
 =?utf-8?B?ZVNERVBYMWU4em0wTk1GQkxUYU5UcFdHSm8xSVZGL0YvbXE2UXNHazkxUTdV?=
 =?utf-8?B?NnlPNGx3VW1GNjdOYkN0NVFKTFlkM3lITVdsSkRZbzBscENCT3kxTlFNcnhr?=
 =?utf-8?B?SFozYU9YWWkwMEQrWlFTNGcrUmpKblZnN3JqbFVocFgzZFFEK24vZkd1NllO?=
 =?utf-8?B?SGpERTdOY2ZSMmc2aWVGd3dSWjJHQlpDSjRMRzd5TThTRUVEa3ZZNU5KR0My?=
 =?utf-8?B?UkN3VmJDL3hHN2lsUUozY1grekJSZWFZZzJYZ2szL1M5alFjdU5VZmRodHFP?=
 =?utf-8?B?cGxNMTIyZXpBSHpPMGJWcDJKVkJtRlR2OWovMUV4U0NKOU9jckNkeGQyZnQw?=
 =?utf-8?B?Y24wVmpTeVVQMGRzaWxLejlUTTZuT0xiMC8rNTdDRnhzTjdoaVZteEV0ODlj?=
 =?utf-8?B?dkVCSHVqcWlrUUZoelVEUWltcGdTbjQ2aldNaXFTdThtOE9xaDVvNzBjekl1?=
 =?utf-8?B?OFNTaU90RFRGSHA4OElNYWQ0b1BjTzV4blBUbWNueUFrL2lYazN5aGtwTzAy?=
 =?utf-8?B?b2diYnpDY1J1em5ZaFJ2RkxBdGlrU0hSS1p0WnRyMFpqVktKYW1pTTZHY3d4?=
 =?utf-8?B?M3hQU2Q4dHNHbnF3bXo1clVMSU9POFJOejZKbzVGYkJqN2lHVEVFSXFRN0hs?=
 =?utf-8?B?eVorbmlUS1FhVU5lRUFvTVdpd2FRRVNCVmtXQ056c2dVa2p1Wk0xdTZGV2E5?=
 =?utf-8?B?TFBVU1JXOTlVTU41NEs0ZnBaQ2ZVSEIvZUJJSm1FWnBtc0I3dXNTdWxkRGl1?=
 =?utf-8?B?ai9VcUx4Zis2dmJiWGh6MllTNTIvM2xHUG5XdnBIWnZoTERQWTRheW4ybDZi?=
 =?utf-8?B?WTVPTEpiTkc5WE5KQk1BTFk4RlAzdFM0eHJId05YdHI2dDU5WElaK0FVZVVS?=
 =?utf-8?B?Q2NUOFZMQ0s3bHM1bmRZVCsyam91QXF5R2RieS8zMzlPdllyMndDTlpiL0ZV?=
 =?utf-8?B?WXFTN29iWG8rR2J1a0RRTFZFL2JlQ0d3aVpyeW5MckZLeU9QcWUzU0hISzJK?=
 =?utf-8?B?TjFyTXZrbFkzRE9nZUNOREZqNThpdGxtUDFqUnIwQXRpU3FWa0dBeGkzaUNm?=
 =?utf-8?B?WUFwMERmRFhXcUJ0czJXYVl6ZFo5aVR3b2IyWWZja1pTa29LQ2QyQmxQcEZs?=
 =?utf-8?B?VGN6L3RaMVdOYnoxUmRiMW45QVZwQm1VakJRWGc2WVpOZ1JzUlM4TmQ3MHl5?=
 =?utf-8?B?enB0anp4d1ZDcWdRS21zeGQ0OHZNL3E0eU9ScWkrUCtTQm53d2VNOTBWenVs?=
 =?utf-8?B?QzJRMlhLZERiYnlyMkhKMkEwUGdtVTRhVmhlRTh4Y3FlOFVRbnlrWjhJUmZn?=
 =?utf-8?B?Vng2eDJ3T1dreHMvWHUwOHpXRHB5eWZ2dTc2aGVleHZURGRPZE45ZHkwRm9Y?=
 =?utf-8?B?aEJKRnJQbU85c0RwL1JGWGhsbTFGemp4Wkg5ZjNGRU8vcEkwNXMzN1BOUldD?=
 =?utf-8?B?WnNmYk4rRmhnNW9Wbk1tOTgxWnRHYmQvMTR0dGkzSU9qN0graEwyMnp5Q2JQ?=
 =?utf-8?B?UzM5TUJlcm8zUXE1TURiOHJmQUhWamU1eTNTV3M1bVpIWkFJS3l0UjlLQUo5?=
 =?utf-8?B?bS9BdWUrU1U5bS84Q0hIbmVyRWl2d05OcTZadVIzVGIzdDNWQmsvTmhLVmhY?=
 =?utf-8?B?T3lRK3llanM4eDFHdzRBRjdxTFZhcnJ1d3VXRUpMMExLRnU3NmJoeVhoSnVV?=
 =?utf-8?B?RjBURnI1UklXdWg1b1FwdHVEdWVwZzZoNzVZZitCSEd2UTZFQjZxMnhkSFNE?=
 =?utf-8?B?amVKVks5ODE2QWlPRnAwc2c5OFk0ajhKeENUdmcrR0gwUml6Sjd4N3NQNEpG?=
 =?utf-8?B?dE8rdzNmd2ZpNUwzQzg0ZjJHSUl4eXppM2lBN2JXd1pOQTI0VktDdm1odG8w?=
 =?utf-8?B?YjlMTER1di81Mitsb2NWZ1VkS2Y0WGNQOUJhNUpZdXlqRHJXbGs2S3hOK1Ax?=
 =?utf-8?B?MWFNRmZPd3BsRVBZdlhPakhlci9MOE9FQW1WN0hZcDB5RzdxazJzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97549668-5442-45ca-1668-08df086c9cc4
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:04:29.3779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8LQvvUbJRsILaeLqA7PursQ5zsIsGOcT994nPtgrP9Fpfcc0DMSXeEd1hYmRS7r0OLJZoJWTXelxHCI5jc5Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
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

On 9/1/2026 15:17, Gang Ba wrote:

>> I'm not sure that we want to do this. Once a process faults there is 
>> no recovery path for its queues. If we restore them then other waves 
>> may cause further faults, leading us back here.
>>
>> Similarly, if the workqueue contains pipelined fault interrupts we 
>> don't want to do this multiple times. Perhaps check pdd->qpd.evicted 
>> before evicting queues and only run the workaround if (evicted == 0).

> The eviction and restoration functions feature built-in concurrency 
> protection. If an eviction process is already underway, the function 
> automatically bypasses the operation.
> 
> The function utilizes the "evicted" value (which can be updated to 
> |pdd->qpd.evicted <= 1|) to prevent multiple concurrent executions of 
> the cleaner function.

I don't think this addresses my comment above. We do not want to restore 
the process after evicting it. The sequence I'd propose is:

- On the first fault within a process only (discarding all subsequent 
faults):
- Evict queues, if not already evicted
- Run cleaner
- Leave queues evicted
