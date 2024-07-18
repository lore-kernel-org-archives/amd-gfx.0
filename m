Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE54C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 05:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B3F10E0C7;
	Thu, 18 Jul 2024 05:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2z9RdLry";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC5110E52B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 05:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtDGRcibqjPg8bbqP+EQp4WTnzId1qhuT4J9B4yYbAFerMyRRVqkuRm2jdLR0SeEvaJ6UYVMf9+oTkSIXwFNrkyc7Nbq2ac0PCp9CfyLRU1WvG/An5guY24P/oSCI+31GXMYrB2x48GTs65r11KkLfHH+tXLluBAfcxWknrooLf5MvNY6+LyM4SM5X3+Ysk1kIBkVGZMYtMKpuH1iSEj1L1yDOUMDnbCecQTY7WbXO9RmghToRzo+P1lU6Djn2iP2T9bmbSqEVkVF/iMNtNtJCTDf+MkDV3T9TkFvuoU5snZ1z2GT0sFTjGrK/Ut8nNAZJsNcoTJJUJhtuRt5PPygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sIlivHuQbTauOgoyEN1MOSU9YS60Dho3Buh/jTdAoc=;
 b=lxhJ64G7ImQHwNV14yfGNVsnJW6xzJNl9AgHXt+JHInVpUbhx/nPemBZsoKUImv5gWCso1qNm/p6dWQdV7jvVexyqJZwReUpbB+yhKCg/XTXXYJnodwHkipnZSLWJuB5O/QY0eE+4qp+9naMJapE2FiqV1T4K/er777mS8TqBH2/7gpzqRH7N+M1B4rGGkTSmT029wq2Lh/5+GR4rPNOz++iZnvO+fkelnykgAE2z4Y1f5Uka7JT7uDc6FNtXpGoq1DvzaiEhI2Uc18EDBcKmw5Kn5imzehUEBogL+G5LLC2Gof0aiVG0ZkTAhgpoTR0cfbCBh+UrZtGZSo8ZAc24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sIlivHuQbTauOgoyEN1MOSU9YS60Dho3Buh/jTdAoc=;
 b=2z9RdLry2vZzrQoBFgxoc3SuLrdZPXJljDvD4clH9/ceqSCgdSikXlUONiff0juVDisApwzKA0xPZF22Px4PinOAqAo9ZZq0y6mGQxNGDWvv8KwSLUuNQLsW+76Kvif/Ru4xtH1aaQuONR5CMbv5jiq1b6P41JsuMEVjzhXIayE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 05:25:29 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::eb6c:c1fc:66f2:1ca]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::eb6c:c1fc:66f2:1ca%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 05:25:29 +0000
Message-ID: <337411cf-1d45-4bfa-bf23-b4709c318570@amd.com>
Date: Thu, 18 Jul 2024 00:25:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20240626150633.157464-1-xiaogang.chen@amd.com>
 <0aea26d5-7850-44c8-b072-5d50a9d4c272@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <0aea26d5-7850-44c8-b072-5d50a9d4c272@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::6) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 0951a3a4-e4b6-40de-1dc5-08dca6ea095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWhISmFxeW00U3pBYmlQYmFqaG9Na3hWb0NZdktPRU9ySXloNkdIa0ZMK3pj?=
 =?utf-8?B?YWJUeWFOekZnS3R5T3lPbWRNYXhzRVhzLzJoRE84d0JSTE9Id1EvTThCaFBY?=
 =?utf-8?B?ZEV2OVJET1RmV1UweFpIa3NaTURCTDlpTmpxemplVFRFYURjK29ZaitOSG43?=
 =?utf-8?B?YWFrYzZpZEl0QjVYVVdyWmZjRGlRbnp4WHlPMllmczVMRlkzOGFpa2E3ZW44?=
 =?utf-8?B?Q1Jsek8wak1ZazNIWWtzMVM3Mm5EbzhCb2FldVRyMzhoRnNBWWpiWFdibE9i?=
 =?utf-8?B?bXRZTDI0N0J6d0hIbm5uUEY3VmNxK2NVM0ZBZWpxQ2xQcTgyRXdXRkZRSHNl?=
 =?utf-8?B?WGs0Wk1wWEwwTmZyUHNaNFZEMG1HdmxMbTRzQWtqdlpCQXFNU0F2a2xKN1B3?=
 =?utf-8?B?SUVNN3dOQmM0Z2NlbVFsVmJiQTQ2TzZtaFVnVHpuSzMyTk9MekZuNFNJZmZw?=
 =?utf-8?B?L0Z0NnF6dmd5c2Fzc2NGMG01bk04Y0NTUVY1ZFphMTd1dXFTMDVtV3Y1SVJo?=
 =?utf-8?B?Q0Y3RjdPd0FRTDJ6bG90UFdldzNzYzBhZ01NT2szNnZFSFI2b0J4Qm1Qc3B0?=
 =?utf-8?B?eEtSTHE5ZHc5T0lHTzMycDk4VG5FbHppSFl3QmtGbm1ueFdMNVNrTGxEUHBR?=
 =?utf-8?B?bUErNFpRbmZ2SE1zYTFmbnRvV3NHWGJCalhSV2NoQUZNNHRybjVOMGhhTExm?=
 =?utf-8?B?cHJZeUFkWXlKam9Pd2FMUHRld2Y0c2lTTXFhcUYyR3pKcXlVdm1VTDduc1Ex?=
 =?utf-8?B?U1Yydml1VFFZb0MrYVp6bExQNmlac2hQK3VUTVdCSzF5UlBoRVFPbDF0S0V4?=
 =?utf-8?B?U1dWVlRRWEJ6dHZXQWU2QjNGRzFDYXRVZUQ0UGVLMG5OM3hKRU1GL2ptQm9o?=
 =?utf-8?B?UThTa2N6bXE0V053RHBpVy8wN2M5VjZvTk1XbnIwWWxWdjRvWSt4NVJ0U09w?=
 =?utf-8?B?dkpiUnlNMGtNQ3dzNFBVN1pLQk4xRkVOU2l1SjA5WEpmeVhxQkRVMDMxbnBw?=
 =?utf-8?B?Ykh2Ym5ZVWtBR0RWblFxeEg2SkxQNU1vS0drRFM3MW4ya1lmcjhNeWZGNDF5?=
 =?utf-8?B?Uk1JRTkwZFVBRmFUZXlhZjhwQmZrd1VoVTBHZEJYblRXcGt0N25TcjdoR1Az?=
 =?utf-8?B?N0FEYXVlNmVKOXRNSEJZU2NVY1crYi9kWjJQYUN5WDNGc3BzeXFYbUduc1hW?=
 =?utf-8?B?M0Z1UzRtYWdaSGh0cmIwckxCRmJxcU55RlBWdnZYYjQreXNYcm83NnN1S0VJ?=
 =?utf-8?B?Mi9sQklvaDdzQ2tyTjVkVXN6dFhJdnBIUURkY21mL2hvNk1ORlZqS2V2SEE5?=
 =?utf-8?B?S1Z0UTlxbUdVWHhSRWw1c0xDUFNDSFNwcS9RU3YxQW01K2FDV2FVMXQyRE9S?=
 =?utf-8?B?UWpoZzllRkxuVnVHYkY5S2p4RE0wNk1iSjJhdkZXWnhJSzNlSGxqYUdMWlB4?=
 =?utf-8?B?aDBvbVpXV1BhSmdHaE8wSDROazdZaitMK01Fa1pHaWFOc0Fhb0UwZkNZOUta?=
 =?utf-8?B?TzlhZGFTVVNHazB0blNFU08wVy9JLzdxaVozaDRKSFBTcG9jQnFzd1ZDMnVL?=
 =?utf-8?B?N3cvbXp3YlB4WGI2Yk1oOHVpdjk5Z0ZvbkpDKzhLVG9JZnIwMkJtUGZSMWM0?=
 =?utf-8?B?RjJPdnRFaVpVcVU2MFJtY0UvVlJPSHRXNnljM09WSndHRnJkOVJETlJNRWN0?=
 =?utf-8?B?MnJtbUF2Mk1IbnJzWUNKbU5na09LWitFNUY0RlZjci9ZRXo4QzFGMFlCNFRk?=
 =?utf-8?B?Y0tZcFBPQS8wQnVXSWJsclBOekJJTUVJeUh6QzNIbWRFaWZtaE56eWErUEdH?=
 =?utf-8?B?OGhOSkRDVzIrUTZvMW5KZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9kSFZjQXRwWkcrVXRmc2FmbFVwL0NhTmFmWWNLRVVYVktVMnJ4WDZ1Mm5u?=
 =?utf-8?B?bnd2TUVCeDZsNDM3Um9KVHM4WmFrK2J6Z0c3NTV4Z2JzK3ZybVJOc29VMnNI?=
 =?utf-8?B?aU1xZDlBY3hxc2I2WldGTWU2REFhaHVockFwOTJtdUFQVFVTYUx4dXV2M3Fi?=
 =?utf-8?B?NGRSM2VlVGZud0EwRFpJOTB0dWY3NzVJVWZvS1FtVlRDTkkyNy9KUEJFTXgv?=
 =?utf-8?B?ZWIzMmxybkdlZTRpQzNNR25IaWFzL3pycHFJcWV4MmJ0ZXNPQTJLdUVPaVRr?=
 =?utf-8?B?U01HV01DUkY4WWt1aXA4YWJITXBtc0xzNVpvMXFjMWVXT25kQ1ZucnhZZTJU?=
 =?utf-8?B?QWpEMk5DbVlhdThXN3duR3FyRyt1akYrSWhNR3hqSWRjRlZmYmZsaEc0Nnpy?=
 =?utf-8?B?WXhHZTZ2ZjdGQTZkV0owTkFJUTVOVXNjUFBnVVgzaVJwNHRSc2JKek5UclF5?=
 =?utf-8?B?LzJlK3Y0Tk8yMFdYdGVGWTNJVmRzcjdLbDhlVTgybXFWMGx1eWdGZERnU2I1?=
 =?utf-8?B?Q0VCS3ZHSHo2N3M5b3pwVEtvSFBITG9qMTN0Nm1FbGxUTGhZVEU5enRtNzNn?=
 =?utf-8?B?dmx3aGZTNHMrSWQ4cnNXR0wrWnRUa1czSEo3WURFY0xsVkJjSml3Wmp6S1kz?=
 =?utf-8?B?MmJLaDVIcUkvVVorckpST0xKMDdEWWhYN0FEVjFhSXRWSEdmSDJlVUdJYjZH?=
 =?utf-8?B?NXJ4Y2YzWFEyRElqNXFXclFSSStnWS83dFpvSEIzOHJNSFRZanVJVU9xbWho?=
 =?utf-8?B?SmtKdk5LMGxFVVcvOU5JcEowQWRqa3JVYVBQYmd2T09sSUN1dzhnTnVTZEhK?=
 =?utf-8?B?M3dsSXQ4Y3d2Q0lSRFBsa0RmaG5zMjlxWW1hYnhnalo4WFJUUndaY2dqYXhl?=
 =?utf-8?B?VVh0eFdFVnZJc2FnVCs5eHAweStQcTZYZllTVDdTbkdqZDFSMU9lK1B1TUZN?=
 =?utf-8?B?SUxYbWpFbnV0UTZKR0hmNWpHQUxYT1YvbUllNHdsbGtVOUg2NjV2bFlXbm9E?=
 =?utf-8?B?ZDBUWSsvRS91OTJJWWFzSUF6eXVYd2VsbnVnZlJpN3YxM3Q3eG1ybUlHdUk4?=
 =?utf-8?B?cEx5Y0pieGtORTgyVjZOdnZyaEpWV1Q2UEtDK2lMdC84L2xhN3JwaXVNLzhk?=
 =?utf-8?B?TTdGNFJOajcwUjJwNHdEZm0rczdRM3kvck53TkJ2K05ubUY3ZjZBRnFNZjdn?=
 =?utf-8?B?YWhlbGhQbmw2Z2FkaTRDQkp0TGNVTjdIL2hRck5nbnFRcC9rQ3NiZGNiMTBp?=
 =?utf-8?B?UURmUXI0RkYyR3kzaDJlK3RYVFB1T2pqQzJISXdMWEkvUmRXdXdnOElUV1BX?=
 =?utf-8?B?ZHN5TjJnSk5NVzY4ank5OXZ3c0ZtTkZZd2RzM0RqL0xzQVBWQ2NKeUc0RnVz?=
 =?utf-8?B?cFdyNVNCSkRmQWIxZ0Z3enhJekVxeFRxZXZ1WlI1dlQzdjZMNFlBK2xqTnFH?=
 =?utf-8?B?K01hbTlka2RWNkx4NUVabllqTWhCU2hUMk5UUU0vbGN3SVI5QnY1TElta2Rm?=
 =?utf-8?B?aVByRHlMMURvb3dlWVcvc25EUmFFem9iQ09QNXJtUDA1UExvUHlzTVpldmF5?=
 =?utf-8?B?UlV5aHJiKzk2c1ZpSmoxNEh0NkRKbGRXK1JiRHhYaUVHNjFQd2ZHTVJYUDZu?=
 =?utf-8?B?U3RpdW15S2UxaDB0RVEwaHV3Y3dMdTAxRXYrcEdhTnhKUXRaNFlRK1hWTTA1?=
 =?utf-8?B?MkMrditXOWZSR2ZyandWQkhtUGhVRThLTC9ycWlJdUlkV09adlV1UnVMNHpj?=
 =?utf-8?B?bUtwS1dHQm9Rb3Z1NDl6T1hJN3Vqb1BpNGhKUnhxM0loVmJCcEVmQ1Z3TzVU?=
 =?utf-8?B?WmFrV2VIQkhmSGo2VUxPR3hKRWx1U3VBeHltMWZVMDVCQ1NTNmsyaTFDOFg1?=
 =?utf-8?B?RC9yOUZGbEdVcjdSWi9tejFPMGFWMmZuSkFtdUZ3UFJHRjNndnZUejhEUGd4?=
 =?utf-8?B?OWNUMW5CajcwSGkzVUFST3BOenJQM2dCbjFsMFVzMmY3S1ZJV0l6ZzlkSHEx?=
 =?utf-8?B?amIxSXp0azdIUnYyeExaNS91SWNiUXFvaDJCOUhxQk9mQlFlb05scTEyaUtL?=
 =?utf-8?B?Qit3TUZwa2Z5NW9tekp6WXJQMzFtOWp4UzBwTWdGS0did0FLdFZUSU16Q0NY?=
 =?utf-8?Q?wimw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0951a3a4-e4b6-40de-1dc5-08dca6ea095b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 05:25:29.1477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9Y7jFIppT7JEcJgJlXVDQGB4AYR+cAN0LbpI8SOvA2giOKYkGE8ao2oqRik5x3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150
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


On 7/17/2024 6:02 PM, Felix Kuehling wrote:
>
> On 2024-06-26 11:06, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> When user adds new vm range that has overlapping with existing svm 
>> pranges
>> current kfd creats a cloned pragne and split it, then replaces 
>> original prange
>> by it. That destroy original prange locks and the cloned prange locks 
>> do not
>> inherit original prange lock contexts. This may cause issue if code 
>> still need
>> use these locks. In general we should keep using original prange, 
>> update its
>> internal data that got changed during split, then free the cloned 
>> prange.
>
> While splitting/updating ranges, the svms->lock needs to be held. You 
> cannot have concurrent threads accessing ranges while we're updating 
> the range list. If that is a possibility, you have a race condition 
> anyway. You also can't split, shrink or otherwise modify a range while 
> someone else is accessing that range. So keeping the same locking 
> context is a non-issue.
>
We do hold svms->lock when call svm_range_add. The patch does not mean 
to fix race condition. It keeps original svm range context when we need 
split/update it. The current implementation "duplicate" a new one, then 
destroy original svm range.

>>
>> This patch change vm range overlaping handling that does not remove 
>> existing
>> pranges, instead updates it for split and keeps its locks alive.
>
> It sounds like you're trying to fix a problem here. Is this an actual 
> or a hypothetical problem?
>
It is not a problem in reality so far. It uses a way that not destroy 
original svm range when split/update it. So keep its locks(prange->lock, 
prange->migrate_mutex) context. The so called "clone svm range" create 
new locks that are not related to original locks. I think that is not 
reasonable.

>
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 112 ++++++++++++++++++++-------
>>   1 file changed, 82 insertions(+), 30 deletions(-)
>
> Just looking at the number of added and removed lines, this doesn't 
> look like a simplification. I really question the justification for 
> this change. If it makes the code more complicated or less robust, 
> without a good reason, then it's not a good change.
>
As above it does not make code simpler or more complicated. It 
split/update svm range directly on prange data, not destroy original 
prange, then generate a new one.

>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 407636a68814..a66b8c96ee14 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1967,7 +1967,8 @@ svm_range_evict(struct svm_range *prange, 
>> struct mm_struct *mm,
>>       return r;
>>   }
>>   -static struct svm_range *svm_range_clone(struct svm_range *old)
>> +/* create a prange that has same range/size/addr etc info as old */
>> +static struct svm_range *svm_range_duplicate(struct svm_range *old)
>
> This seems like an unnecessary name change. "clone" and "duplicate" 
> mean the same thing. But "clone" is shorter.
>
'clone" should mean identical to existing one. Here we use some items 
from existing svm_range to build new one, the new one is not totally 
same as existing one, such as the prange->lock is not same between old 
and new svm range.

>>   {
>>       struct svm_range *new;
>>   @@ -1999,6 +2000,25 @@ static struct svm_range 
>> *svm_range_clone(struct svm_range *old)
>>       return new;
>>   }
>>   +/* copy range/size/addr info from src to dst prange */
>> +static void svm_range_copy(struct svm_range *dst, struct svm_range 
>> *src)
>> +{
>> +    dst->npages = src->npages;
>> +    dst->start = src->start;
>> +    dst->last = src->last;
>> +
>> +    dst->vram_pages = src->vram_pages;
>> +    dst->offset = src->offset;
>> +
>> +    for (int i = 0; i < MAX_GPU_INSTANCE; i++) {
>> +        if (!src->dma_addr[i])
>> +            continue;
>> +
>> +         memcpy(dst->dma_addr[i], src->dma_addr[i],
>> +                src->npages * sizeof(*src->dma_addr[i]));
>
> This does not reallocate/resize the dma_addr arrays. Reallocating 
> these arrays can't be done here, because this function is not allowed 
> to fail. That's one reason to use the clone instead of modifying the 
> existing range.

ok, maybe I can swap dma_addr between dst and src svm range here, then 
original dma_addr array got freed when free src svm range.

This patch purpose is to not destroy existing svm range when 
split/update it since svm_range_add has no mean to remove any existing 
svm range, even part of it. svm_range_add split or update existing svm 
ranges.  Maybe we need decide if this idea is valid at first?

Regards

Xiaogang


>
> Regards,
>   Felix
>
>
>> +    }
>> +}
>> +
>>   void svm_range_set_max_pages(struct amdgpu_device *adev)
>>   {
>>       uint64_t max_pages;
>> @@ -2057,20 +2077,19 @@ svm_range_split_new(struct svm_range_list 
>> *svms, uint64_t start, uint64_t last,
>>    * @attrs: array of attributes
>>    * @update_list: output, the ranges need validate and update GPU 
>> mapping
>>    * @insert_list: output, the ranges need insert to svms
>> - * @remove_list: output, the ranges are replaced and need remove 
>> from svms
>>    * @remap_list: output, remap unaligned svm ranges
>>    *
>>    * Check if the virtual address range has overlap with any existing 
>> ranges,
>>    * split partly overlapping ranges and add new ranges in the gaps. 
>> All changes
>>    * should be applied to the range_list and interval tree 
>> transactionally. If
>>    * any range split or allocation fails, the entire update fails. 
>> Therefore any
>> - * existing overlapping svm_ranges are cloned and the original 
>> svm_ranges left
>> + * existing overlapping svm_ranges are duplicated and the original 
>> svm_ranges left
>>    * unchanged.
>>    *
>> - * If the transaction succeeds, the caller can update and insert 
>> clones and
>> - * new ranges, then free the originals.
>> + * If the transaction succeeds, the caller can update and insert 
>> split ranges and
>> + * new ranges.
>>    *
>> - * Otherwise the caller can free the clones and new ranges, while 
>> the old
>> + * Otherwise the caller can free the duplicated and new ranges, 
>> while the old
>>    * svm_ranges remain unchanged.
>>    *
>>    * Context: Process context, caller must hold svms->lock
>> @@ -2082,7 +2101,7 @@ static int
>>   svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>             uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>>             struct list_head *update_list, struct list_head 
>> *insert_list,
>> -          struct list_head *remove_list, struct list_head *remap_list)
>> +          struct list_head *remap_list)
>>   {
>>       unsigned long last = start + size - 1UL;
>>       struct svm_range_list *svms = &p->svms;
>> @@ -2090,13 +2109,14 @@ svm_range_add(struct kfd_process *p, uint64_t 
>> start, uint64_t size,
>>       struct svm_range *prange;
>>       struct svm_range *tmp;
>>       struct list_head new_list;
>> +    struct list_head modify_list;
>>       int r = 0;
>>         pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>>         INIT_LIST_HEAD(update_list);
>>       INIT_LIST_HEAD(insert_list);
>> -    INIT_LIST_HEAD(remove_list);
>> +    INIT_LIST_HEAD(&modify_list);
>>       INIT_LIST_HEAD(&new_list);
>>       INIT_LIST_HEAD(remap_list);
>>   @@ -2117,35 +2137,41 @@ svm_range_add(struct kfd_process *p, 
>> uint64_t start, uint64_t size,
>>               /* nothing to do */
>>           } else if (node->start < start || node->last > last) {
>>               /* node intersects the update range and its attributes
>> -             * will change. Clone and split it, apply updates only
>> +             * will change. duplicate and split it, apply updates only
>>                * to the overlapping part
>>                */
>> -            struct svm_range *old = prange;
>> +            /* prange_dup is a temperal prange that holds size and 
>> addr info
>> +             * updates of pragne after split
>> +             */
>> +            struct svm_range *prange_dup;
>>   -            prange = svm_range_clone(old);
>> -            if (!prange) {
>> +            prange_dup = svm_range_duplicate(prange);
>> +            if (!prange_dup) {
>>                   r = -ENOMEM;
>>                   goto out;
>>               }
>>   -            list_add(&old->update_list, remove_list);
>> -            list_add(&prange->list, insert_list);
>> -            list_add(&prange->update_list, update_list);
>> -
>> +            /* split prange_dup */
>>               if (node->start < start) {
>>                   pr_debug("change old range start\n");
>> -                r = svm_range_split_head(prange, start,
>> +                r = svm_range_split_head(prange_dup, start,
>>                                insert_list, remap_list);
>>                   if (r)
>>                       goto out;
>>               }
>>               if (node->last > last) {
>>                   pr_debug("change old range last\n");
>> -                r = svm_range_split_tail(prange, last,
>> +                r = svm_range_split_tail(prange_dup, last,
>>                                insert_list, remap_list);
>>                   if (r)
>>                       goto out;
>>               }
>> +
>> +            /* split success, insert_list has new head/tail pranges */
>> +            /* move prange from svm list to modify list */
>> +            list_move_tail(&prange->list, &modify_list);
>> +            /* put prange_dup at pragne->update_list */
>> +            list_add(&prange_dup->list, &prange->update_list);
>>           } else {
>>               /* The node is contained within start..last,
>>                * just update it
>> @@ -2178,8 +2204,38 @@ svm_range_add(struct kfd_process *p, uint64_t 
>> start, uint64_t size,
>>               svm_range_free(prange, false);
>>           list_for_each_entry_safe(prange, tmp, &new_list, list)
>>               svm_range_free(prange, true);
>> +
>> +        list_for_each_entry_safe(prange, tmp, &modify_list, list) {
>> +            struct svm_range *prange_dup;
>> +
>> +            /* free pragne_dup that is associated with prange on 
>> modify_list */
>> +            prange_dup = list_first_entry(&prange->update_list, 
>> struct svm_range, list);
>> +            if (prange_dup)
>> +                svm_range_free(prange_dup, false);
>> +
>> +            INIT_LIST_HEAD(&prange->update_list);
>> +            /* put prange back to svm list */
>> +            list_move_tail(&prange->list, &svms->list);
>> +        }
>>       } else {
>>           list_splice(&new_list, insert_list);
>> +
>> +        list_for_each_entry_safe(prange, tmp, &modify_list, list) {
>> +            struct svm_range *prange_dup;
>> +
>> +            prange_dup = list_first_entry(&prange->update_list, 
>> struct svm_range, list);
>> +            if (prange_dup) {
>> +                /* update prange from prange_dup */
>> +                svm_range_copy(prange, prange_dup);
>> +                /* release temporal pragne_dup */
>> +                svm_range_free(prange_dup, false);
>> +            }
>> +            INIT_LIST_HEAD(&prange->update_list);
>> +
>> +            /* move prange from modify_list to insert_list and 
>> update_list*/
>> +            list_move_tail(&prange->list, insert_list);
>> +            list_add(&prange->update_list, update_list);
>> +        }
>>       }
>>         return r;
>> @@ -3533,7 +3589,6 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>       struct amdkfd_process_info *process_info = p->kgd_process_info;
>>       struct list_head update_list;
>>       struct list_head insert_list;
>> -    struct list_head remove_list;
>>       struct list_head remap_list;
>>       struct svm_range_list *svms;
>>       struct svm_range *prange;
>> @@ -3566,7 +3621,7 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>         /* Add new range and split existing ranges as needed */
>>       r = svm_range_add(p, start, size, nattr, attrs, &update_list,
>> -              &insert_list, &remove_list, &remap_list);
>> +              &insert_list, &remap_list);
>>       if (r) {
>>           mutex_unlock(&svms->lock);
>>           mmap_write_unlock(mm);
>> @@ -3574,21 +3629,18 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>       }
>>       /* Apply changes as a transaction */
>>       list_for_each_entry_safe(prange, next, &insert_list, list) {
>> -        svm_range_add_to_svms(prange);
>> -        svm_range_add_notifier_locked(mm, prange);
>> +        /* prange can be new or existing range, put it at svms->list */
>> +        list_move_tail(&prange->list, &prange->svms->list);
>> +        /* update prange at interval trees: svms->objects and
>> +         * mm interval notifier tree
>> +         */
>> +        svm_range_update_notifier_and_interval_tree(mm, prange);
>> +
>>       }
>>       list_for_each_entry(prange, &update_list, update_list) {
>>           svm_range_apply_attrs(p, prange, nattr, attrs, 
>> &update_mapping);
>>           /* TODO: unmap ranges from GPU that lost access */
>>       }
>> -    list_for_each_entry_safe(prange, next, &remove_list, update_list) {
>> -        pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>> -             prange->svms, prange, prange->start,
>> -             prange->last);
>> -        svm_range_unlink(prange);
>> -        svm_range_remove_notifier(prange);
>> -        svm_range_free(prange, false);
>> -    }
>>         mmap_write_downgrade(mm);
>>       /* Trigger migrations and revalidate and map to GPUs as needed. If
