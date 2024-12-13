Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2349E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 10:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629C110EFB7;
	Fri, 13 Dec 2024 10:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i0204a0j";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E7410EFB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 10:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybI6y1m7UiESTylfE0HDbldJcIUb1edjO65om0Wcg215Jj5eshQ+tHijAgD/ojhFN9WJSvxK9U4/Ig9PkckBdlLBAHubNFLBVWiwJYoOmEqvelSLl1xWm27muPm5JN+YGy2xGMFfUSB7Qy65VrJEEUp7JWXE28TI0/A39MbVFC3VzvEk+6Xr+ukVHWTrHbeHmbtCeJNN8MYiE3oBvIWoEDLX38rj3SSdfJYTkXxjp5/MSg/dYKe2ubgoShZWXQvP3Fm7/XOyUTGMg97Uv2at25bPKw5j5oT6wzwYsYitsvqHh3WBi5qRdX+YlNe6nOX+SI6GFnYjE6QA7bd08ngrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjZFufNYQkTaipHua0q3r24vzsziTxkwHiHKDAfW/mg=;
 b=fwj9knQ3uKcbabcHbl4hO0yw4gMkXnlz4aPYY6XFcsfso3OCXNGRvVQcZyGwYGCKeC/kRJDLkcPxoD7zshMwFlVDfJf+ElmMrtZTINTAMfXlr7fAKQnyNKxQQMophY1bihVS7L3nSk+ROA6smCso9kVB2nIHjD8wsVwKQfIaqlIm8T6TmSWxLRHow/I+BZZE3+ustS/rDTSMsHQ9CGoXnNg5t2R4ZP1tcrH1m3GWCyh7OBv61X1mR9X6YaZjpCFmHNLWlFkW8tJhtAuXw5vFStXTIyliS2IJJOpfDDGOluVn/iNla4Lzr5OqhRkuzVz/korxZs/MQYq+OFciouimMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjZFufNYQkTaipHua0q3r24vzsziTxkwHiHKDAfW/mg=;
 b=i0204a0j8H/aZtdHZ2CIF61PIy8d0+787sdwQFCJRej46Xs2AR4NpbXDP2j35JIPqYPunDVUr7NPKr5+rlokR+dyZQVKM+HmEeIi86WfQwmqC7QEQLHF+Ap61Jzkt2Ez9ntylU1cEdsQO/E/k6z9sdG9L/zNK3TI3RdlQPHJOyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 10:43:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:43:06 +0000
Message-ID: <7699531d-31eb-4716-bcde-3b0c41707ee4@amd.com>
Date: Fri, 13 Dec 2024 11:43:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/amdgpu: Fix out-of-bounds issue in user fence
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-4-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241212142533.2164946-4-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f79b398-1779-470b-b4b5-08dd1b62ed8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0NiajBkVUJGWWxQS0FwSzdzcU1MM0Ixc00xRzBrZzBoekwxbnRsU1hFdnU3?=
 =?utf-8?B?S25TbEVyaVlvVW5saDdYc0cwVzRIbFNLc3hRaWkwRU14eDNUY0Y5R2UzWndu?=
 =?utf-8?B?M3pHdUQwR3dDL2xNTFZqWGxaaG5DL1FzZW9jS0l3M3VwT0I3bHU3WnV4WFNO?=
 =?utf-8?B?cWl5NFpGaGhPRklxMGNqTUZYUXR6bGRBLzd1RGlJcEdpVzBNSXhrcU1yWFlD?=
 =?utf-8?B?ZmJHMXBWMUJHUjhmc0VmZkNUSTcxYjYvR3YvcXpCSEZDckczVy85a05Nbjg0?=
 =?utf-8?B?UGpuZ2hjM2tHK1ZLU1UzbVl1aGxtSEgvOGtKTlFRNGprTWFCYlhMS01VaVNt?=
 =?utf-8?B?bEpUZXQ1b0JKVnN2dTFYbGRmZitlQkVDaXc0bXkrVEpNZUNCdmpoTFF2dmNW?=
 =?utf-8?B?N24zZzQybWlVY1BSKzJFNEZyU3RnZGlqMjE3ZFFQeXc3UFljV0ZWWFNaWE9u?=
 =?utf-8?B?OUt2WE5wclJOQkh6VGRMcHA4LzcxNmJHMnFlYVN6ejI4bHJIbE1JaU9xT3hV?=
 =?utf-8?B?N1lhUE4yUGlIQXVSSTg3QTRSVjczVkVMYWRnN1JiWklNeGhmNkVYRHdlZFYr?=
 =?utf-8?B?bjE3VFc0c3pJdEM2b3JrRUVFbWZGN1dtaVFuUjluQ1dUakpGWVRQelNTaHI1?=
 =?utf-8?B?RytrMHBndFdWR2cyR0REOXZGc1phTmV3TFBHVEFjU2JZeDVlMkUwNlNWanZq?=
 =?utf-8?B?eTkyblpDNEEralJtUWtFZGtOYm45UG04Z1JLODI5bml1S1F1YVo5NEprNTVt?=
 =?utf-8?B?UFlKMnBKbnFNVEFOVkNuNnc5SjZaSWw3Qnh1Q2ltRFhSWW9ReTZiVllsWllY?=
 =?utf-8?B?Tk01cU1UNVdpMTlsOGIvOTN4NnRMWUVZUVFtc2lsVW5mNHNqenltZXJ5aCtO?=
 =?utf-8?B?WVVFcHArbktSSWFZMXVrMzFvTGdWZ2c0UEVrK3ZHY1hzcnJqM1NHNktJbWpQ?=
 =?utf-8?B?bXR6TGhKUTR3MHpZUFowN2k4aTBuTmhYQVUvaCtCRzh6c0VjUis3TFJUWGZr?=
 =?utf-8?B?aGd1czZPRTRHY1RiOHY0YXhXcFBvaGZkWGdNR3dMbDk3L1d6NFl5aTNJVnA1?=
 =?utf-8?B?VHlvVlplNG44M2hCM01yU3lONXh3Z1ZjRGh2cEt3TUE2UWZudzhOdmJrMkd0?=
 =?utf-8?B?TXg3QWYvM2c0S3VsTFhwMHgwdDZEalcrWHlLVVFqVStDbnV5cmQrMy9CMEJa?=
 =?utf-8?B?M2NBY3lXNm9MRnRCdzBIRFdxbS92dVFjYTJqVGluUTJhbVdaQmJEbmFxc1Mw?=
 =?utf-8?B?N2dhZjRMS2l0R0FSOGVOdFV0cEV0U2NBLzdxS3A5aCthTklVZ2k3UzZWWDRS?=
 =?utf-8?B?akdmQVRrTVphZDJndEY5blNFNWJxQ29hREhiSmU3ZFZBa0w5RlI3cGJsVzVR?=
 =?utf-8?B?ZFN5OGoxTVU1NXF6TkFFQVRhYUx2eUhuQ2xJT05XUWxONGpGQ3ZJTTE0TkZ6?=
 =?utf-8?B?T3I3eW43ME1TZHE5NEUza21lc0F3T01PbE9XTkxBOVVRWEN5UGJHZlBkeFhZ?=
 =?utf-8?B?ZElwYnBDM0RZQk14SkVEcFlEU0c3cWtQTGsyaDJLNE5DK0lKRDdiTi9scWdq?=
 =?utf-8?B?OTg0K055OVVMRGQ3bDNWZlBuTjhsM1RNa0hsWEx5WVVWQ2k2NlNlSWRMbUxx?=
 =?utf-8?B?ZWV6UEJoUXZHa2xmdGFIbTk5Tmdnampwa1JxaFhvQnArVE16b2IwK2V4R2hp?=
 =?utf-8?B?dCswaHBhblJvK0FERkh6L3M4YXpYQXNvMGVnWW44c1FZVVBmS2JEcTRPYStQ?=
 =?utf-8?B?VzhYSEFNaUdWRUxFRDVFenczUXRidkhGekJ6ZU5PREtDRVJXbTVYd3BsTncr?=
 =?utf-8?B?WnFMVlovUlJJM1NLLzBVT2NEaUpVdHlvbVVBbi9zejVHRWppSGxZQ3lxNHZP?=
 =?utf-8?Q?IvejemWkBGGmD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNCN0h6dEw3QmtkY1hGQjNUeDZjZVFxa2kzeGIyZDZRZitpQjk2VndkU0tF?=
 =?utf-8?B?eEw2NnlsQ0dLdmkyekloWnhMdFpicEp3Q1JHL1hGajV6cXA0Uy91RjNwOEZZ?=
 =?utf-8?B?SFdkSlZMZjdOT3dxT09yUnJ6Snl0ODhZa2dvVHIzWCt0YlV5UGZMai8yNnE2?=
 =?utf-8?B?WGtJdkxGVk5aTkUzWU1uRVY4dm9EVVZJam5rS3lYNWZsK1lidnF1czl3SXQx?=
 =?utf-8?B?UWZta3hQK3JPNTJqYXJidzBrYVZOVVVtTkFvWEFrc3ZCbkhUK3M3N3hiNzlv?=
 =?utf-8?B?cC9rNGhYbG1DRUFXeHUzL2JmSTZsR0VOOExhUm5VeGgzTCtmbWVNQTh0YUNi?=
 =?utf-8?B?NS8vVkFhL3UzVXYzVzRPMzNGUGZMT2h1SGNxejBMOU5rQTFPUHpZRVhRRTRE?=
 =?utf-8?B?djlkejZnL3AwVXY5SjVpUWtjM2tRQmZGZnZPZW92MWpsSk5hZTk0cHdHNXBh?=
 =?utf-8?B?TkJlaVpNckxDM1lZdjYyaGxIVDBiSXFCUjhhUStSTWJUU0U2MUlsdzNNem81?=
 =?utf-8?B?ektsWm9hVU5jVkV2bTZqU0FzOU1oSktpOGFRRWN5bDNBMHB5VU1yNGtpejQv?=
 =?utf-8?B?YjFwMy9wWFdndHh2SVpXcy81NC9wdUZ6d2xZaHVSQnFORVlWNGk0dC9LbHRS?=
 =?utf-8?B?SWlkcFk4b3hvc2ZOMlE2M1hHZDY5RWo4NU9aSk5FRmZlQVM4N0U5SFFzayt4?=
 =?utf-8?B?ZDl1TjlxRFZMb1QyWUN5bHpDOCsyRmpuRWhZWDk0bjJ6aXJKZnRCNGJ1OTFt?=
 =?utf-8?B?ZW9MbE95S0pLK0Q4RzZEV21XelVid2xmeTg0N05CREJQaXhhNzk2a1llci9D?=
 =?utf-8?B?enFFZkN2ai9RQWtpRjRhYjlqSzNpWGdHekpGZ2JQZVlHQlFSQ0xka3RsRzdD?=
 =?utf-8?B?TTJKL01UQ0hObW9pSDNxYm9qRG5ra2g4N1l0aktrcVVYNUlCV0VFTnIyYzFh?=
 =?utf-8?B?L2s1SjdZYUFORWkrWmtQeTNxSUNLTTl0SHhGM202YzhpN205eUlGMHBrdVNi?=
 =?utf-8?B?V1RsbldSeFErS3M3cTlKT2s4dzY1VGM4ZzJKYlZ4akMxZGZMc09UR29ub2ZD?=
 =?utf-8?B?bmdDRTEyTnNscHpGNThGejB2eVBwNEVEWVZtSklpYVF6b0Y4aEhjNXV0UkZa?=
 =?utf-8?B?UXhES2NuTUh2M2QrWDV3cHh3SWx5TUFDTzIrMmZLUjE2L2tBdDlUMGVaTjV1?=
 =?utf-8?B?bHdmd3F0TkhDRmkyUlJUYzA3a3FNZjVhY1A2VUNGQjBwNjFjUUNOY3lBZmh3?=
 =?utf-8?B?Y2xsK3g1bnNOdTN3WFpMNUtDekVYeTAvcFBPZVoySkFDSU0xYW5qMnYzS1hv?=
 =?utf-8?B?eURsRXFaZ2xtL2FLeTV5RklFZWJ0VDZhSUNHUk5OOWlvemV3bFViMEhGRHpm?=
 =?utf-8?B?VUVhbWd6U3Y3RGdSWTc2YXU2VnVLRUNHRU1JV3hxQjdYZkIycVZFWGtBVG9O?=
 =?utf-8?B?cHBjOEFHdzVGMiswTEc3a2Z2VDVhNkR3WldRdFhQNmhJWSsyc1NTSVFNRWZj?=
 =?utf-8?B?ZmRrNnQrbkpSMTAzNjBzZGR1UDc3RytveVJZVHFIeVEvNnlsYVNuTkZRTGJY?=
 =?utf-8?B?ZXhwVHpUOWE3TjU0VXF2SkxBM210dU5ZNXRDUnJGTjF4TW82ZE9OckVYUHBJ?=
 =?utf-8?B?OStsSE1FMUJjcFRyVUpyc1VLZnVVS1h6b1RFNndQdS8rbGwzOUJhV2hNU3Jr?=
 =?utf-8?B?QXBtOHg4Y2llak1wOWxndHlVMTlPTXRJZFJGa08yZUExVDk2MnlPWSsrZHE4?=
 =?utf-8?B?K2g0ZG5oelB4dmt4R25xR3M1aERtNWUzSjU5ME5jeGZEcGM4Z3FWUHloaW1K?=
 =?utf-8?B?NHMwZnc1cmxTL09KbGRDdzdYc205bGVsc00vRHJKOEF4eUluUmQ1S3pCd2g5?=
 =?utf-8?B?UDNVa1FFemVaYXhjZVpRYzFXS04rNjZ2Sm5jL3hBVHoyRXV6MXcwK0xmdFNa?=
 =?utf-8?B?VEM0T1N6QmZQblI1Ym9tOS81UHh2VWtHSHAxcGhYbnlITmpieUhibklyZWVt?=
 =?utf-8?B?Uk5jLzB6aHRHSmlPRXRsRFRBcW15Q3Qwbms1djFOVFhMTFhlMzRtUGJ4RXZz?=
 =?utf-8?B?ZVMwWHR3dFl3b285ZmlxRFJOUWZaWTRXV0RFUm5SRkk1V1FPbTR6VHFwWll2?=
 =?utf-8?Q?vV8lMRIHGi0oFvjXvlTMbnYhZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f79b398-1779-470b-b4b5-08dd1b62ed8a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:43:06.3893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4fwg/WD03Y5I0PdxLGpYaduboD6PRJ/luf325l2KnZt/vpFCjuR8cpfNbLt5Piv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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

Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
> Fix out-of-bounds issue in userq fence create when
> accessing the userq xa structure. Added a lock to
> protect the race condition.
>
> BUG: KASAN: slab-out-of-bounds in amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000006] Call Trace:
> [  +0.000005]  <TASK>
> [  +0.000005]  dump_stack_lvl+0x6c/0x90
> [  +0.000011]  print_report+0xc4/0x5e0
> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000405]  kasan_report+0xdf/0x120
> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  +0.000043]  ? __kasan_check_read+0x11/0x20
> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
> [  +0.000007]  ? __kasan_check_write+0x14/0x20
> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
> [  +0.000009]  x64_sys_call+0x1205/0x20d0
> [  +0.000007]  do_syscall_64+0x4d/0x120
> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3a88f754a395..49dc78c2f0d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -229,6 +229,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   		unsigned long index, count = 0;
>   		int i = 0;
>   
> +		xa_lock(&userq->fence_drv_xa);

Don't you allocate the userq->fence_drv_xa after counting the number of 
objects?

If yes then you need to drop the lock again for that.

>   		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>   			count++;
>   
> @@ -240,12 +241,13 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   		if (userq_fence->fence_drv_array) {
>   			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
>   				userq_fence->fence_drv_array[i] = stored_fence_drv;
> -				xa_erase(&userq->fence_drv_xa, index);
> +				__xa_erase(&userq->fence_drv_xa, index);

It's *much* more efficient to release all entries at once by calling 
xa_destroy() after the loop I think.

Regards,
Christian.

>   				i++;
>   			}
>   		}
>   
>   		userq_fence->fence_drv_array_count = i;
> +		xa_unlock(&userq->fence_drv_xa);
>   	} else {
>   		userq_fence->fence_drv_array = NULL;
>   		userq_fence->fence_drv_array_count = 0;

