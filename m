Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A20CAC5A7
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 13:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589B910E154;
	Thu, 25 Sep 2025 13:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IL+Z3TZ/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0097010E154
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 13:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEoRYWYELQ5aaN/NtEBYwqfnA5SWlRAvObqulu3W+ACK/JzKljlsrrD/uAHOCYZfFto9C4pkDk8b4uHRIWCFk3wtBHKCjosMqoaYNWfc5S0x/SzqLuCTMtOthGnecvlsAJjT6cyqxpYhcGCEzjc3SlWJq/6dpG7fIACg3t44qhdecNWt7LJF2XZKoVAYiPXCMpZBMh/3J8hL1ugc514WhQuyMM0s1jW2qZmsDi6abHGVgBIdpr8xuHsfx+BOuiU6qWcnZFDW7E0q9+hMpzpaPAZnEUWKX4L2sP9lxnmIGYThYVLICs1otR3fhiaZUj+/Fq7i7serw5bKcMm7PVt3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEV+15U6D0U4GDG0xwuP5eZ7pD8brw7YcLrczvLuR8E=;
 b=DBmwEzhaSWHnTSfNftbjsn70XYuy+NpMCYQgDAAobRu/iDCAGS840YhInk6YGhg+b06U7aU+dbVuPegjezbdOnsAkFr53aTF+H0FhC5fFS1g9rtiy2PnclcT0K2rIDn6NeLYlFuQPTGL/00Hc4Pq2xUI819QbHMiCDFAWB1bdQitXBqy700NUPLxSNMj0Y+dslKUdGCYI8/WH1ladAhwbr68dmulrXG7YFdKaNZhDYBlvJMYNS8MDfVHRufSWhpOlNgU5UNnrVV/hDYJNqGeOLTT7RTSjHihe+Ls68w12ZEdURGGvUNxZW5MQoLnOYANp1jFmE1RacQiKgAXjnX+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEV+15U6D0U4GDG0xwuP5eZ7pD8brw7YcLrczvLuR8E=;
 b=IL+Z3TZ/IRTkAkBbS6R50yT6FT9QQA1E+3/yOyqElMrqiCKDw7nE1fVUAOPpx/o4JVA/cJ7IPJwwWtbU/yvP4gn21xP36kHo5IqHWASd9WTBg9s+IcZcu1K+gOliQVmFdpC7zobJKFswgS//2CI3gL7oVsV6s9JxyQ6EjJj5rk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0010.namprd12.prod.outlook.com (2603:10b6:8:87::8) by
 SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Thu, 25 Sep 2025 13:26:12 +0000
Received: from DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e]) by DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:26:12 +0000
Message-ID: <6a99b66a-6d1b-4fdd-b1f0-c37cc036d889@amd.com>
Date: Thu, 25 Sep 2025 08:26:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] DC: Reject too high pixel clocks on DCE6-10
To: amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
References: <20250924113836.57013-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250924113836.57013-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To DS7SPRMB0010.namprd12.prod.outlook.com
 (2603:10b6:8:87::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0010:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: d0518261-5bab-42f6-7525-08ddfc371893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFNBU0N5Mk9yZHp4TEUxV2xSOVhLcG10M3hlQ1B4eVE2MU1hS3pRYmY0VnVy?=
 =?utf-8?B?L0Z6VXYvdENRMmRPS2NiZHkxeHFZWG52NDVuT2NYaWpJNTZzQnkvd2Z1TE1Z?=
 =?utf-8?B?R1duQkVxRWdWUDVXejA5eW9FRGhpenQxN0ppckVNYnJucGZ6bkNtajA3VTJo?=
 =?utf-8?B?THUwY21LT1N0MUxoY0p6REQ4YnpJWU5qdFJBbDBNYUJaaEFlS3gyYjg2Z0Ry?=
 =?utf-8?B?VUY2ekx2NkJUY1NTeGVHNHlnSWtEQ0xTVmY3UnZuQlk5UjNlS1dmSlNxMEJw?=
 =?utf-8?B?cTd0S2hRRFd5S2xRT1JUS3BGQVl5Y1ZWbllaUGQxaGRzMVg0cDBNenlyYktt?=
 =?utf-8?B?ckRVNzhlazNMWHBsMnlKOXBnNUNWRWNXdzFzdm9UMWx2eDlJa0dYMytLeFhH?=
 =?utf-8?B?dzZNWUUxbk9tMkdndmp1ejBrQzVBZHgwV241QmRTQnZ6SFo5UVd6Z1d5QThu?=
 =?utf-8?B?OGdjaTFSTnUvOVVqY2w1b01JbkFvMXRBZXA5YVhoQzRkZWRFVFluQ1VOYS93?=
 =?utf-8?B?dXZYQXMzalpFdXNhQzZwOGwzRE9VOEJPQUtuUkJML1BCV0RqV1FhVzdZUnZM?=
 =?utf-8?B?UkcvcS9YcmQ4NkdEUnQ3cGF1WS9hblBkVk5JUURKbzRQbUM2MDBCdXU4Q3li?=
 =?utf-8?B?aDVWSUZSWkZrb2c4WG1OcEx4bDE1ZXVCOWozQnJHNVRNcTc4UWhuZWMxVjM1?=
 =?utf-8?B?aVdxMWxCdXlhdGNMSkN3VlNZRUFQN25zeE0vd205OXBlWGlGZjFobU9ISy9I?=
 =?utf-8?B?aGtrNWhHbytvcG5uRkhDUUVhUm51OXRESjYyU1V5T0w3aHZPN08rOEVGNmJl?=
 =?utf-8?B?ZkF3a0tNUHYwalRuaWdBOEluK1RQN3NnaTZ4SmRZQVRseVRZSGtWWUg0cWFx?=
 =?utf-8?B?ZTJqUWxpOUpiREZacnlTTmxQTlI5SmY4aWg0blVWVG00azVlSW9GY1doMFgr?=
 =?utf-8?B?ejE4eThlMFQvbDRBQ3E5UkozazB1ZkRBUjhTQVVUcU84R25VUUYyRUh1OUtB?=
 =?utf-8?B?RDd5ckUyQ2daL1NXTTNtT1NpdDVvMjdkdmRWZUJaT1VDL2JQM3k0Z1VMbzZw?=
 =?utf-8?B?WVYvYksra2l2NUkzVnJNSFFoR1NnSVpmN3BnSjBzM2tuY1ovYnMxT0M1b1l6?=
 =?utf-8?B?YnZGeFhORjJ2bWVnNmFobjhBNEVrYWJtN205Nk45eVd2VFFjOTI3Qm1sbTNT?=
 =?utf-8?B?dFQ2bzlYUEJaY2xTY1FEam83ZWp6RmlkSjVzRGZ3OFRkeHhDQTVSWi9FYVo4?=
 =?utf-8?B?WlRCV1ZWVEtyNFBLcWIxc2ttZThwcS9CWmRVYytkQUZiTE1oQWlreFRqbTJE?=
 =?utf-8?B?U2NFUEhYenorczZaMHA4Rm9CWC81WWFySUVKSGFlWEFYUnNPQkl3MDV4WEc3?=
 =?utf-8?B?TmNNL2hKVldWUXk2ZFh0cmw2cXJNaVNmS2Q4TGl2NU8xajl4TndGR3VvUWc4?=
 =?utf-8?B?WTJRODlweGRlYzgyYXh2eUR4cmJxRlRmRXNJZ3czZ1g4TGVzUmEwcm9RZmc3?=
 =?utf-8?B?aG92SzVMM1dScTdqRXVSNzFYL1lKY1h0MGpLU3RuL3BURVMvdjg4L2ErZWgw?=
 =?utf-8?B?Z3JsaWFVQVJzQnVyRk9ZdjJubFVjT25Qak1XUURobG9JUWZYY2I5akhEZW5j?=
 =?utf-8?B?Z2dJaThMRldCbHpYMW16R0tUcm55RGxydEFOUjk3MzBxU21TZWtQUWpwdlRS?=
 =?utf-8?B?Uy9qZEhscW9aTGduQ2YzNWNGb2JQQ2tsbExUVDZ6TlNhWHM3N3lSYlhVQVQv?=
 =?utf-8?B?TVNyaG9NZWI1QVRtNmJiM1A3VTNiSVJvV0kyOGF3T25DbU1RdmF0TjZNYzBn?=
 =?utf-8?B?eU44Sjk4cEEwV29UZUZROXFMZ0oyNHQyV3ZKS3FEVVFHU2J5bnV3ZGdpUS8r?=
 =?utf-8?B?T0E2bUdYMGh1M0JCd1RtdkdzQW03bXEremxBSkZ6SFA1Q2s2V1Z1TWNYZ3h5?=
 =?utf-8?Q?R+NTe6pdnpY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7SPRMB0010.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxLL2szUjdPR1BXVm4xcXVGNFZvV0xnTFdqSUg3a2dhQkxORGIxbEZtdHlj?=
 =?utf-8?B?OG5hUEJMRUZqMk5IQTZ1SEhDSXdVaFJoalNhSWNQVWFvN1VrcURPbEhYeGRj?=
 =?utf-8?B?Wkw0WTNaSXlqL2lHTUkxbFhNbXQzeFRDeFdUamg2OUtZOEtLaDRWR28zMkhu?=
 =?utf-8?B?Q0wzdndPTFRPdmxCTkw4SXR2citPaGtJdTAraUVZNXhkM25RaWdodUFvSXVP?=
 =?utf-8?B?UTRHNWZIQndJeVd3aFZycjFmMFJpWUJTcWcxdFlJbWlUOGpjZ011SmpNZ01y?=
 =?utf-8?B?YkVIS1d3NUFUcmpnZGY1Z0EzUENHb29YOGo2eWdURGR6NjVhaXM1emEyTnEw?=
 =?utf-8?B?VnQ1RTBSN1YxeEdWTTZGOUZVK1NLbzlJOGdiNS80WGtkR0szTXZJSkpRUHZE?=
 =?utf-8?B?NmxpQVFwTEhtZ2JXdmg5RlhnUkxLYVpMTHVua01WTmtHWFFRM1dXS3NNN0Qx?=
 =?utf-8?B?ZEdJZ2dNRzVITGdiL2E3Q2JPY2lmMTN5WWhJRDZCNWFDYjcwNmEvdkYwdHBY?=
 =?utf-8?B?RjZYM1ljR3VpWmpTRTJZbWFhOUcxcjZJa2RSeGlNWU53UVpobTFXMDZXUWxv?=
 =?utf-8?B?Qi9jbHJXNHpJaHlZaGt4bGpyV2RlR3RlczFhTStXMEY4aFEzcG5nNk4yRnkv?=
 =?utf-8?B?cDlyaEd0bjU0ZWJRMjYyc0FTazlwdEQ0MTRpaGZyY25xN21OU2VpRXZRZGJi?=
 =?utf-8?B?QTFXNjI4QWdpTlpRaUxoV0p4V2Z1ZWsvNWN6RlVCQlh6cGlWRzRWRUMwSnpl?=
 =?utf-8?B?KzV6UEtONDFCd0JHMWE4VmVFR0Z1Z2hIRWdvcFFHK2xLaFFxeU5aVmh4dWtK?=
 =?utf-8?B?M3dXSUszOU44UnRiUk1JWVQyZHVrWWhwS0xFeVk5aHpuMUZESUJLNnZGZ25H?=
 =?utf-8?B?cEp5WnVqMS9LckFNYjBzcjVERS9aSzZaQThtUEY0MnhMcE10M1JDeE1ZdnND?=
 =?utf-8?B?U01taHFTQmNvVXZuZGtmMHFFMS9SRExia0xWSk5aL3dTZ1hpMUoxWXZ2UVl4?=
 =?utf-8?B?TmY3emEyRjdZZ00yRnRWOWp3VjgxNEV4SkdQVmJlVnpEK3FmQ2J0cWpPb3Ry?=
 =?utf-8?B?b3VaQ1BkTThta0gwRHFoWld3RGh6ckFvZlRDcG0va1piWUxOMzdPaEdOaGho?=
 =?utf-8?B?Ni82d1pBdVZCcTFFdzhMV2toUUh5eXpObkpjY1hMNHE5dFBTdmVmdFZtMm5y?=
 =?utf-8?B?dG9VbHE2dnl1TzhUQis3MmJKUGwwREJpOFRaL0N5Ym5uT2ZwVEtXRldKaWQ5?=
 =?utf-8?B?WkZ6Q1VmRUo5WXJpZk5HY1RBTG1jV3NQWitBeWNtRDAwZ3FycGtZZW8xM3hB?=
 =?utf-8?B?c1E1RmVtZ2hTRzR5cVdaalQ1d0xzVE9VbHVsZFN6RXRjMFc1cFNFcUtEd0ph?=
 =?utf-8?B?dEZTOWRCTndGY2Z3ZmdkTWcyeEpEWDNTV2lmWFBGRkRubWdKQ1VROVkyWngr?=
 =?utf-8?B?T3kwQ2laQ2c1TXBVRmJwT2pGN3JRcHo5NHVyYTRuTVJpWmQyVjQyLy9FVERB?=
 =?utf-8?B?RkhBbFB1TTBTSUVMTE5ROE11bzlSNFBGbWpSSXN1ZUZKYkMzR0lwNlI5ZS9k?=
 =?utf-8?B?QVJLbHlBdXRRUEpwRDRBeFg3cG9JZE13RU05S3VjTU1HRW16U3lqUmN1S01C?=
 =?utf-8?B?R0EzdWZhelR6U0NwQ2JYcFJaSk1vaWZFZmZleGx5aW5QYzRKbTZnSVlXL01p?=
 =?utf-8?B?dlFJa1k4RXBEME1GS0dkdllaMk9ESkQwemoweEg3ZERJL2hDVnYxWTVqakFS?=
 =?utf-8?B?b0x2TDc1Q29GdWUvTkFwcFNHRWMwY25nSDRBZVQ0MEdacjQxSmNnMUNGR01j?=
 =?utf-8?B?c1Nsd3NhVXpvWjRzNmNQOXptL2RPaFQvV0YveEZQZWdMK1duZjVSY21wR29u?=
 =?utf-8?B?UUx2dE56MEFybHUrNUt3MUs3ZmhjakdMMEJ2bHJObVhsenBTVnVKS2hWdHlx?=
 =?utf-8?B?TSt3empEOFkyMEs1Kyt6eFVtT01MT2w1TVRvUXBHbzdjS1EwYUpHOTBzQjlr?=
 =?utf-8?B?M0V1RVliY0FFa2lFK2NnVzdZcmc3cWlxL3A0R3pYWE1IVTV5TkxOdXRGNWY2?=
 =?utf-8?B?TmE0akVEM21iN01QZUtONzRZcGxVVEw4WTA0Z1pwYnlwTFozd3VEeEN5d3Zz?=
 =?utf-8?Q?D9Z/fGjJRVZaLDOcB+xrMiGP1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0518261-5bab-42f6-7525-08ddfc371893
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:26:12.3634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dfr+BahjsxVCYgr/YgCKDVCtMbVnyKkXumKV1qFULwcYbMv0ETUBzC5dx/e9cBMTTkUowPTUrs/c/bVbT8ytBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

On 9/24/2025 6:38 AM, Timur Kristóf wrote:
> Reject modes with a pixel clock higher than the maximum display
> clock. These were never supported, but we haven't noticed the
> issue until the YCbCr 422 fallback was recently added.
> 
> For example, the DP 1.2 standard technically supports
> 4K 120Hz YCbCr 422 6 bpc, but in practice the pixel clock is
> too high on these old GPUs.
> 
> Additionally, there are two small code cleanup patches to avoid
> excessive code duplication.
> 
> Timur Kristóf (3):
>    drm/amd/display: Reject modes with too high pixel clock on DCE6-10
>    drm/amd/display: Share dce100_validate_bandwidth with DCE6-8
>    drm/amd/display: Share dce100_validate_global with DCE6-8
> 
>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  3 +
>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  |  5 ++
>   .../dc/resource/dce100/dce100_resource.c      | 25 +++++--
>   .../dc/resource/dce100/dce100_resource.h      |  9 +++
>   .../dc/resource/dce60/dce60_resource.c        | 69 +------------------
>   .../dc/resource/dce80/dce80_resource.c        | 60 +---------------
>   6 files changed, 44 insertions(+), 127 deletions(-)
> 

I've applied this internally and it will run through CI and come to 
amd-staging-drm-next soon, thanks!
