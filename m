Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F07C3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 07:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B7510E2E6;
	Mon, 12 May 2025 07:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tef3ZrhJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4142A10E2E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 07:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4cZTc5S73X2ZWRUey+rBtlMdkFcWgaMwXuT0+BJSZXLmOxfrATCn0Zh0isPC8B4/GJHQw6cPhD2+uHIr/S4YnOQGcGpJfSnzE9F+Fxzoj1qMIFMK5K0W2y7G/DbA2Kj8kcHX3WNww7fBPftJqOzJrSwdymFEd6BsbiBq7g7oazHuA2N3y3Oxx1rlOC9oRzKBEjQNQD+MPgsoRfs3OybCUfAoMrgfFD7Xps6takSqqIw36O97VAvozzFHWJ78dk+lBESe/FWt0BLaq+GJiWE2RwgDdJbRAwVtlKCMolNsIrpav0jWh/QxpcJJwROonhwqvYNBcxm81Kq5j22H2If/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxjVdLzLxehXWipC8CVhXrw9DTEVv/rk2n/q21JUZFk=;
 b=yhFf+pzr6tZadzMxG4gBCKrRaH7z1493V0psC9lZJjxzoF5c334NjHCGnsTEhN+3J5oaeLw/S3iqOQpGOqbXyS1WoWK+wKrkVhv6b4omr284y2hdAutQBr32ppjnBVYCdwEr6U+CAKkujqYfj1fdM/txw8WWhopi+R6Kdwd3AQ+ziEkliNYiueETGaHYkxv9Ncw0lE0DzNtU6grqbSwBGsZwdAHsJ8RuoT/um50xnzO0MOGk1flDGmmecBZQB10YZxBGtbGu2EldVnjtPxqtUWTPQ8eO+S+OaosBwB00WBk7qxTWF8zSresBnGJV9DIDnQuUSUy6W+YEYG7yqLLI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxjVdLzLxehXWipC8CVhXrw9DTEVv/rk2n/q21JUZFk=;
 b=Tef3ZrhJcF72q40ucrwnNl3uNvbWkd4d7CadWcm1VF+NIgNY8MHZRz6Hi7+nIidefIuO2dIkjxWQ1umz/TfLhAedz42sKP8F+9OS23POTEAEJ+tWCCHwS2EA8jFAqBFxRfsFX2rmCFOIPBPOILnJ2hlXdPwNTcO80trKU83Q5VA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 07:11:33 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 07:11:33 +0000
Message-ID: <01435a2b-e4f6-4265-a355-e970fad8fa29@amd.com>
Date: Mon, 12 May 2025 12:41:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
 <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
 <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
 <fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com>
 <cb73b496-1008-4338-83f4-a1ddcb81be46@amd.com>
 <74e83de0-1a1e-458a-b110-f6458db129c2@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <74e83de0-1a1e-458a-b110-f6458db129c2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::22) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0710e394-e1be-4481-d743-08dd91243973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHplbStpaDk0dTdwZ0ZtVWNZODJXcUZ3anBIbkZTeE5tKzdrVUh5YkV3UURV?=
 =?utf-8?B?U0R3UGY0YmlPU011a0hrUkNBTHBWYVM1c3gxblJRakZZWGorVmpRR1g4Qmow?=
 =?utf-8?B?SWxncGFDTFZVVjU3OElEUFUxa3JBc01NbmZRQXFwZmExV3g0NkdiUjBmNjB4?=
 =?utf-8?B?WW0yNjlIODRzbGJQNnErZWM1bEpxTS9iY3JZSG9FSUxDd3l3WkpnZ2tWTStB?=
 =?utf-8?B?MlRwOCtvRjVtMU5RVjNndnJITkpJL1FsS3B0aVlqT0lGZW0ycmZ5R3kraER5?=
 =?utf-8?B?bjkwNVhvOENKbkZTUER5dWN5aHBjWml0dFNja216N3k2cUZpUndHby9RZ3Ji?=
 =?utf-8?B?a3gxZ3BYcUpBVkRuM0RCc1dMdHVGVFJZT010SmtIUS9jNmNZZmhCWkpTWmxk?=
 =?utf-8?B?RDlVSzk5Rll4QnBBZFE5UHJ4dFkxNnh2WlhCVmhhM2FlZHdLWDlsLy9wbVBI?=
 =?utf-8?B?UXdIc2U4ekN0TVN1V2thNEFkRlR5OW1TMzVZL1Y1OGZNV3drYWNJZkQ1aEl6?=
 =?utf-8?B?YW5KMnh2b3N1clQvRHFEUzZnM2hRa2lONE1jSlBnL1RnN0ZnTVJ4RHlQYVhu?=
 =?utf-8?B?UXZDc3FZSVprSmhwelFhR2dRR0FERDgzSnpQaWJrV0RocmEwczBmVnZmYkNB?=
 =?utf-8?B?Qk9HdC9uWHFSMXJZYy80RUgwUjUxR0VKVUhIMzlObXdSWnJuTjdnS3QvLzBx?=
 =?utf-8?B?N0NxM24wbzQzdnBURkI0ZXJQclBzdUNNRlFVdjh4blFmNm9Fb2VWaTUrNkJh?=
 =?utf-8?B?RWtCc2xIYVVKSWR2NDlnVkRVRVpEMWtzbjVXVU1aMzZ5RlRnUmtTZzVLNG5s?=
 =?utf-8?B?VUs5Wk1sZVhoYjVzZk4zN0RlaldLbTdpZWQwSTlsd3Y3S2Q1NEpXMTRnaUZv?=
 =?utf-8?B?RlEvcHlNNEUxbWJtTEEzUFJrc3FTNlFwNmV1V0FLblhRMVpudmNFSFF6RVNU?=
 =?utf-8?B?dlZuVllBOWlHajBDZUkrTjJCK2pOK2xwZkNVK0FmS1lXc3pRVG9McTRYdUVS?=
 =?utf-8?B?OHRKeGxpamhxZEFVRm5la1NacGZ4TjJncjhtcXFMT2lJME45Rkk0NlU0eG5R?=
 =?utf-8?B?MkJuZ1haOTFVTnlLbSsrdkpkdHZGaDNOSHY0OEZXOXY3WTJlWkxuRHZqbTEv?=
 =?utf-8?B?Ukx4dXdONEFhM1lwa01uY0R5RUM4azc4T3lJRmxObEFMMWNYSXU0TGhhNkJ6?=
 =?utf-8?B?ZjFXR1BNSTRMKzV0Y0xMTThUTTlYUkJ4RFpLZGFaMTFnSXNVU2pkaTNmOFMr?=
 =?utf-8?B?OFhtMDZ5SGphTndmR2xwcXp5YVFrMEphR3E0NTJ5MWRoM2trQWc2cEVzUkpi?=
 =?utf-8?B?MGM0UnFYcFFFRnpFNVlaWmI0ZnozSkFpZUJNT0NZOVEvS0JId0tFNGxxdWVN?=
 =?utf-8?B?VFZHYUdRc2d1NlJUeTk3TnRIa2ozLzh3U2l2b25XTUpWWHJmSE9NbDVxOVBx?=
 =?utf-8?B?YTF1WmdLbFovakFFKzljVjk0Skd1eUV1V3UwMEhMNnExb1NGTTFYN09ZZVVV?=
 =?utf-8?B?SUszYWcwM1lWL0MzeTBkamh4S0p2WFBaZ3NqK2tlTnM5aUYxd0tDT0lRYith?=
 =?utf-8?B?US9vTXNSZTZjdUVUOUZhWDVvSWc1dW5BU2ZmVjhzWVBVY2tIL0pOMmM3R3lx?=
 =?utf-8?B?bkxaNmFjbDBvK2pwL1pqNXUzKzBuWVlkRWl0dHBHZktSd1dYRTlGN09GekN0?=
 =?utf-8?B?WmR4dHMxazZDSWloWXJnMUJLeEE2b2U2V1lzZlZ3L01oTGE4Zi81UnNIWVNJ?=
 =?utf-8?B?UkJaUXlMSUkvUFJRdkhmRzN5cVlxeHlwaG4xVUxhUGJheldwMThEU3ROQjRQ?=
 =?utf-8?Q?H0KNdgYR8FfSOCTsS2VjYmNN2A2DNzPRyhvuI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnAvK3BlVFNseFZjN2VtVzhtNU0ra3Y5QTNIRHZCdXBRUk5PTG5TUFhIU1NO?=
 =?utf-8?B?Si9tVkdnd0tudjFHOCtGZndhSnhkYjJTUzh6S0ViU0paTFBld01rS0xYNnJI?=
 =?utf-8?B?VHJXSElhRGJSaUlnZ244WFYzcWtuLzM1ZmxPSnVscnUzRDhkTUZZMmQyQ29Q?=
 =?utf-8?B?L0x6eU8vb20yOHpvSzA0cDJ4R2pGekwrWUFSRUtBZ0cwMkVDbmNtUGNhWHFF?=
 =?utf-8?B?MDgvenVWZ1pFTGJHamdiaWRFNFI1V0pDcHRMWFU2SXp3S2FZZ1BKU0lKMmor?=
 =?utf-8?B?ZkhaU2NPNTEybmxLSnphTjg2bnZwc1oybmh4aEd4bDdnTHAwQnp1dlR0end2?=
 =?utf-8?B?RkdXTlJpM0N6SktkUTFIRkgyWnhDSTFJdEFzUkdJNG02YTNlaDRob2U5WDhT?=
 =?utf-8?B?b3BmYXZET0c0OXhxYmZiR0ZnS3UvSjdBelZRTFpGSjZEQXpJUlR6cWk4T1FR?=
 =?utf-8?B?ZHl3RkROTFBjVS9aUlVna1lLdWNNcUlvcWlSL1RMTUJrbk1yZWZSNDEreUox?=
 =?utf-8?B?ZktzdXJ3YXRINTYrcnpsTStFT3Jqbnd4YlZ5Ryt6c0NpclZTSXRjVzRucTNx?=
 =?utf-8?B?N29sWm9saUNJcXVVS2F5US81TGZuaU9YdUNYTTdIZkN5TXRsTk1SK0FjRzRm?=
 =?utf-8?B?NVZhdVliT1ZmdzRkY2N4cWtmakJNejcvUmcwTmY2U00yRnVWUWZyWE92ODdU?=
 =?utf-8?B?bkJKV3pzTXcwbjhGL3J6cU00WUorMWplVE1OWnkxb3hYSGQxaXM0cUlOcm04?=
 =?utf-8?B?RE42SWRiTGZhL004WGd3N28xTHp3UDJRcXZwYXl6bHlOcU1WcHdreXB2V09S?=
 =?utf-8?B?Uk9mTlcvOXNnN2ZnOXEyNHlGRW5tTENmYkVqeTl5RGt4clZ2ajB1YjRMVGNn?=
 =?utf-8?B?OVdhUTMxei9ENm56enpyKzczaWhLSzFwNEJZUG4zbC9BNHZ2NzhwWHk4T1dX?=
 =?utf-8?B?b3IyTy9EUkxsRm9yb3BJOGxZanRvVVhzVjNFbW42UUJBYldKNkVKZHpUYnVB?=
 =?utf-8?B?bi9sYUpmd0d0K2EzWEpYYVBBNTdlanRDc0NZMVcrQW9ua0srbFR6OHp5STZM?=
 =?utf-8?B?RFhkOExFaFc1WitIcVZURyt2ekpVSFR5eGxnNGkycnRFUVpyY0RpNXRxZ1FG?=
 =?utf-8?B?TDZOZWp2NjM4NmdvT0hWZTBqWGwzVk9sci9KbFFXaENzU09sYmN5ek4zOXhK?=
 =?utf-8?B?SEhtQUlLRkRCYTNsYURIbTRtdWJ5cWlMcUw2ZDB6OWthYWhuRExRSXZKc2M2?=
 =?utf-8?B?STBXclVyUW5QK1AzRjE2OUZNbnJpSW04NkNWM2VZR3ltZUxIRFI3K25sZUsv?=
 =?utf-8?B?TFN3enB5Qld0U1RDRFVXZFZvZDVja0xQcVdwdWxGUGEvaTFSWXVPQkpJcExu?=
 =?utf-8?B?R0xrRUlMa2IxdEUybXBpQmVXSWVLRG5wVmNUYkZKTGEvOW00ODhjMHR2azFQ?=
 =?utf-8?B?bjBEaVZLOXFhYWVqLzFZOFc0N1Z4bEVTUDkzUzU5bmhZd0E5VzBXMmlONnN2?=
 =?utf-8?B?QkVGTVRsZXFYbUtiandLNUUvK0w3K2JTRGFMTzNiYmNQdmpkSmptM25jYlFG?=
 =?utf-8?B?T2ZIcUhSeWlTVURVQWRZVlN5ZmdZWDZORWoyZCs5OEhYaWp6cXA4NG5lc3gx?=
 =?utf-8?B?YWVNdnBScGlQTnNzVkhUdDN4OWVwK1J6bXIvT0NtUjRFelF3S2ptWjFnTjBl?=
 =?utf-8?B?M1dCaFpKVTEzWGdkRzdxN2p5N3YxM09lemFHbVEwRG40TUlTeGhETlhzdHU4?=
 =?utf-8?B?TFBmY01jZGI3MkdGemwrUHJaTGE0UGtxVllORWxCNExEbXdzYXVjVU1TdDRs?=
 =?utf-8?B?MGhZaTZBVHlGOUVWRlJ4RCtxOGI4Q2ZlWUF4QUJWUXpTcllpQXdhVXAxckpZ?=
 =?utf-8?B?NERDMTJDbnh3MW1TNUhTQkMwRDR1RW1ma09wa2FIRXRaTmM1MGptVHJXNERz?=
 =?utf-8?B?SlNaRUQ1UWtBNFU2SFpmVzhpVGpCTUhjUk1wMkR5MStRazVnZDlYdzNTZTg2?=
 =?utf-8?B?Wm42NS9ZQUZqOXZZVW9RVE8zVk1zY3pHeTJVUFNtQXJPV3NDNXkzVjZuTTNY?=
 =?utf-8?B?NEtIbWwxRG5CTmMwMjZ5Z3IyYnB6eE94dU5jOHhPZURaWWc0TDNGVHVVNkJJ?=
 =?utf-8?Q?SeY5aOk7f6hBtN9hX0aC1acfL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0710e394-e1be-4481-d743-08dd91243973
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 07:11:33.0747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaQmbgGB/eL7249tQLBtsHTNyyeAK7DEUB2UCCO2JoanrvaVCYzaBbO5CdjMK2YhMi0ExM3XtgUD9GZa0VBFfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229
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



On 5/12/2025 12:39 PM, Christian König wrote:
>
> On 5/11/25 22:37, Paneer Selvam, Arunpravin wrote:
>>
>> On 5/12/2025 2:03 AM, Paneer Selvam, Arunpravin wrote:
>>>
>>> On 5/3/2025 5:53 PM, Paneer Selvam, Arunpravin wrote:
>>>>
>>>> On 5/2/2025 9:02 PM, John Olender wrote:
>>>>> On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
>>>>>> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>>>>>>> + Christian
>>>>>>>
>>>>>>> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com>
>>>>>>> wrote:
>>>>>>>> The drm_mm allocator tolerated being passed end > mm->size, but the
>>>>>>>> drm_buddy allocator does not.
>>>>>>>>
>>>>>>>> Restore the pre-buddy-allocator behavior of allowing such placements.
>>>>>>>>
>>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>>>>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>>>>>> This looks correct to me.
>>>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> I was thinking that we should return an error when lpfn > man->size.
>>>>>>
>>>>>> Regards,
>>>>>> Arun.
>>>>> This patch restores the previous behavior in the spirit of "Do not crash
>>>>> the kernel".  The existing uvd placements are pretty clear in their
>>>>> intent and were accepted until the switch to drm_buddy.  I think it's
>>>>> fair to consider their style as expected.
>>>>>
>>>>> With that in mind, I'm not sure amdgpu_vram_mgr is the place this change
>>>>> really belongs.  That is, I think it's worth asking:
>>>>>
>>>>> 1) Why does drm_mm accept end > mm->size without complaint?
>>>>> 2) Why doesn't drm_buddy do the same?
>>>> I remember that during the development of DRM buddy , we had a discussion with Intel folks and decided to
>>>> return an error in DRM buddy when end > mm->size. This was done to ensure that, at the driver level,  lpfn
>>>> has the correct value.
>>>>
>>>> I will modify this at drm_buddy to match with drm_mm and send the patch.
>>> After giving it some thought, I think it is more effective to implement this tolerance at the VRAM manager level
>>> and allow the DRM buddy manager to perform a strict validation, as this is necessary for other graphics drivers
>>> (e.g., i915).
>> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Ok in that case please pick this patch up and make sure that it land in amd-staging-drm-next Arun.
>
> Alex most likely won't follow the discussion till the end.
Sure Christian, I will merge this patch into amd-staging-drm-next.

Thanks,
Arun.
>
> Thanks,
> Christian.
>
>>> Regards,
>>> Arun.
>>>> Regards,
>>>> Arun.
>>>>> Thanks,
>>>>> John
>>>>>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/
>>>>>>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>> index 2d7f82e98df9..abdc52b0895a 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>>>> ttm_resource_manager *man,
>>>>>>>>            int r;
>>>>>>>>
>>>>>>>>            lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>>>>>>> -       if (!lpfn)
>>>>>>>> +       if (!lpfn || lpfn > man->size)
>>>>>>>>                    lpfn = man->size;
>>>>>>>>
>>>>>>>>            fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>>>>>>> -- 
>>>>>>>> 2.47.2
>>>>>>>>

