Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4769C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 20:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C2E10E0FD;
	Tue, 18 Feb 2025 20:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwuZyzXP";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE96E10E0FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 20:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxHHpNideGDOHTOuUi8ZTmdSSVBiUTGr1E7jipHV3hMlHBzDd6qfKGx9ruD+5k6ZzEpbiSjaVvG2Ay+tMo2aPMleEv2RriypnnGAF+DJ7ml9Woj0eSBSwEb2jRS/RdsDFdadGUL/jpNA4Dm3USWVvky/eu6WOleG/aeshl9c8I8cuojAhEALNr7tAdB6QrSakPL9W1SbWTluxvbboYuymTZeDpfAZRIx7CuK9GYQ/JHkSXybtOYka/w5TBmU3uLG1WgF0GPGRtd2V2FHXBFhyLhzPE0lbMbF/r826apgmXxXFGjmd3QxpCB62liz4CldxqvGSHtpMvI4vtiMeOx4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ/GZxG+L/lKCE+mXZRsm33dQjoZQGHL1fpHjiAFvzY=;
 b=HtrYu/QHGUFmgVVqv6HqJKWRbzKwxNJuENJj5ZjwsfAwUJkBn3n6alsRtnGaFPnhhzdNghME63JCIVGLC+kFka+X60iJgwpUAwgSJTMJzt+DY/BJ2VU3wGGUD128ShqvH7P2r0IVO4panEsNOXsxi692ZTj/0OCEMKSqSFXsoBFPEK6uCxZq3M8ifgACFmToA24oIf/E37J0ma8adlUfZCZCdEVzY+9NZDvUCfi5gQjDutAzqNBXzjTj0G+uInl0BMQc4C9WbvA/E4SolFyki2vDgozgJRfW2RC+JorD23lhBTeswbxLt/3q6dz7PcYRExNuEIHGphESVAgZ1xM+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ/GZxG+L/lKCE+mXZRsm33dQjoZQGHL1fpHjiAFvzY=;
 b=rwuZyzXPtSSYz6xs/nIQE6EoVv5OIdREumLiEq71vWgs3CLruETzxv3RgqFFQ5RUFjBXuvutOaX1SBtxwEOW/kbrPuvO7MXyYMWH1su04b3L+8gt1U2FhELEbcU8dNDYbwpK7naF/oz450y4TLf3mbkhAQTmL6Nh17G2vHXDoFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 20:51:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 20:51:03 +0000
Message-ID: <5348d3b3-a9eb-24cf-b6cc-33e433bacb7c@amd.com>
Date: Tue, 18 Feb 2025 15:51:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix Circular Locking Dependency in
 'svm_range_cpu_invalidate_pagetables'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Alex Sierra <alex.sierra@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250218160130.810595-1-srinivasan.shanmugam@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250218160130.810595-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b42a82-2123-4262-3c63-08dd505df56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0grRTZ2S0dob2dXbFI2RW4vK3JvMjJ6TTEzLzFqQ0lqVWlEckhmcmVaN0JH?=
 =?utf-8?B?RXN6bUdvYzBmMFhrTTF6Z0RWd2p1ZVpkWExBbTVYTVY5RmJEdGw3UEwvcy96?=
 =?utf-8?B?TDllYXRjYzRVYWhqTVV5ZGo2STFOQVZyK0RSYlozandpSzFaZkhXZnlMN1BD?=
 =?utf-8?B?L3U2L1F2L2g3Rm10L3VyZUpablcyNzY4dDRCWm9oQ3ZxampWdXZXZmdoUjVZ?=
 =?utf-8?B?Q0NDV2NWczRKYUJneVpPQ2U3VDY2dzMyeFBCQkFNRWpCVjdPYWE5MUVIS2Z1?=
 =?utf-8?B?T0JoajVqRmpuVGFsZjJrQmVJT2JLbVJ6TTJ2Nm0yMjREYW1iMk9NYUlFUFNq?=
 =?utf-8?B?ajUzREQ2cEtrNzh1Qld1Rm1ld2E5YlAwWHFJdElqeWFOak5jb0h0ME40Rk16?=
 =?utf-8?B?clR0NUVjWWs2amF6a0xrRG9WNjR1ZnVYRWhrcWlkcGRpUUI1WkUwdmErbjZu?=
 =?utf-8?B?MXdwSmd5eTdCT09tY3ZyWmUyZmxYc3VCVHJXL2NsRWNxNFAwbGxWa3BFWnZR?=
 =?utf-8?B?SU5zbG1vS3lXMmUyem51U2dvS3dTUUZpQU1UaUxXWGhBNGVkeGwvZ0ZrWjlX?=
 =?utf-8?B?RnhkRUNEVXZXMGpFZjBzdlJLWitNaEN6d05nM1RmVm56cWNzNHlFVWo2WG1u?=
 =?utf-8?B?MEZKOVVUN0E3ZVdOZWx1VDBVREU4OVFoTXp4dkI1VytKdW51MDJ0YVVNc0dC?=
 =?utf-8?B?a1JOSm5pVitLbGFBWURqY0ZTRllyOUoyV3A5dzBRTGE2ZThNamhqZ2FkbzNp?=
 =?utf-8?B?OFZVUEJyVmkyMExlYkdDaW5uM0g4TlIzUGk0VEgzYkNyWEJDaEpJc2hpWml3?=
 =?utf-8?B?cWhkZWNpcktZMVRpZ05lMExnK25uamJVQlhpakdxWGs1MldkUU9BUnRnekdY?=
 =?utf-8?B?WHdGRCtEd0FVUTRURlVLcTJ5WDJ2MXJkM2JnRkl1L1B6Y0pzS0FaS0NmeW5s?=
 =?utf-8?B?UzF4ZkZ2L2QyNnhycHVOU2VnTnFvM2JDUVV3ZDhwZ0VnR2ZjUEJQNndpMjhz?=
 =?utf-8?B?L0E0V0dQUktGMFNDcGdheHdVT1FsNGtYSU9vZU9OZG5qdWxQMUpxemgrUEdH?=
 =?utf-8?B?WUM0R1FCb2pDd0grcys1V3lZcjBsUGZoT1NEOC9VaU5DUUR2T21PS20xWEpC?=
 =?utf-8?B?Nlh0NFlwZkE5SFg4VUpkaUZxR2xFeFBKTXlzQ09lSzB1ZUlTVWtpSjVOVERx?=
 =?utf-8?B?dGRmUzRQTHhxd2lTMXlzcHh3R290SnpITS9JeEtFN0w4V1ovU0hkSlRIN0tI?=
 =?utf-8?B?Q2NTN1YzdElsTlRiNklkSVJLdVNDdWNrTWpsUGJsajBydlY4OHJDemtUb2RY?=
 =?utf-8?B?cE5zS1RoNlRUQktLdDBjTlE1WFh1RWtCVTIzUXFTeFVKRC9rME4xVzZlK0dN?=
 =?utf-8?B?SGlGWGZtbUoza1hOQ0ZOTUVmd09icW5yTlcyaHlYcVlKZHc2Nkp0c0hjYlB6?=
 =?utf-8?B?K0pQamNSdjJoNUsyK3cvYnQyL1lWUmhEYURJWnBmUDlLQmFNSisyL1IyY2Vx?=
 =?utf-8?B?SFUvV3h6WXFIZnhvQlV5WXZvYm5BZHBIckNWVktzRTJaY0R4U242eFZMb1pz?=
 =?utf-8?B?alFWZDdyME9rRXNOL3g3bDFERW9XUXA0YVJCQ25Kc3EwSkFxVkdLTXN1Q1h0?=
 =?utf-8?B?bVA2MjU5THFaYnhTN3B5V3VzMXU1SUJqQzhOL09HYjhzQWIvZzFDMExpMzNT?=
 =?utf-8?B?VXdkaFhwczN3eEZCd1B1dDJRVGZwbWdoOWdMZWpTdUlGZTJVZ2x1dVlMcTBP?=
 =?utf-8?B?TFIvKzc4RE9oQVRBK1JYNVlXaldtekRSQ3pvODI4MzdhMWlNbUgwU0RxQTNr?=
 =?utf-8?B?cjlaVnlxNnRFdnVzSjdZMXhndDI4Y0pyekhGOWQvY0pnN1FBYXkzYXZUbUth?=
 =?utf-8?Q?s8WwHLR2+8PLi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFE4QTNEVU40am9xeHN0VHFsdEhwYVNUSkRpQUVIclF3SCtIa2xaMmhONXM3?=
 =?utf-8?B?SEl6clBQZnlXQTFDcVJWaWc2UitDbWFTdm9wOXhwN1lMdThLT3NEWWNXVEJZ?=
 =?utf-8?B?eEpBaHc4d1M5YmFXM3phQjJhY05DdHFuZy9nNGNQaHhyblV2UHlWb1VQZzRj?=
 =?utf-8?B?RzQ3YmZwN2xyelk2c3o0TzU0cmJYMVBKa0JLMlE3aFAyV3JpQ0I3SEs2NWQ3?=
 =?utf-8?B?TThWQlh0NC95Mmg4aENDWllJUCtBZ2dOOGxmeGdxQkQxcjhIMThBWkt3MW90?=
 =?utf-8?B?Tm5Vak1MdHlZTGcrN3c5VWNVTEFnSlZ2aTJseHZ4Rm5KTy90V29HU0VPNzds?=
 =?utf-8?B?bEd1dkVMZkhOZTRSM280ZnlaZjM3SDBUdTJJRDZScHhGdE14Z1JOd09mUWJn?=
 =?utf-8?B?WHF3L2xjRm5iQ2F1ME1uOXpMZjJxcUpkVnFveG1rbnVMZ1A5RjlSRzMvN0xw?=
 =?utf-8?B?MVNmNE9CZDB4a1EvbmZRdmpyK28vTFJ1ZG9tQ2NjeG1KQ3VKVVRrbzFkMGhR?=
 =?utf-8?B?aDR3d0trcTBjTUJyRVRhMVRNdis4OTI4UkZQUFVVblUzZy9WUU1FcnN2WU5v?=
 =?utf-8?B?UHMwNDN6bmRWaTFMeFJqZzhBRFJDOU5CUzFBYU5FVmVETFYwWGp2aXRScmR1?=
 =?utf-8?B?T2JpM3JCekZ1Kzl0ZVQyck9Pa09SOXVUZDJBRlNmUlBzd20rY1hWelZMVHlO?=
 =?utf-8?B?OUd2cWFXeFR1Y2hBMWdRbTRvSDM2bXBoaHdXc1k1enhKa29McUszOVlmVVpN?=
 =?utf-8?B?VTh2TnRweHBIalJOb0ZNaFd0ZVhzN3NqNExoTS9CczNVMzZIVC93M1hZN042?=
 =?utf-8?B?UG9tQ2pacForWjhPNXpjMmNmazI3UE9HTWtKVUhtQXc0SEkzVCtLcWtHd1Iw?=
 =?utf-8?B?VzVwY0tHek9EZWJaUmphK0dHYWJoMEE3dFcxRFN4anE4cWNQditJcFFrbnR2?=
 =?utf-8?B?L1p6ZDdQZ1Z5bTBpUGpIWExuNmplR2FPQXZlZkk5YkVDbXk1UHFPcGNPdU96?=
 =?utf-8?B?SXZySFZ4U3RtTW1iV0QwejFYcG1lTlZ6RnR0NlJrN2pxdXFCSWo0NVNpdDE0?=
 =?utf-8?B?eXpKTmhHVGZ3aXJVS3dSNVBJeE5nY2tDelRleThFTWM4dGhVUllrdUJVQ2E4?=
 =?utf-8?B?VGtsU2Q2OGxhWnVxMmZSVFN1Smd2TGlQS0I1UUxuVk5PbEdnZmVDcnJyOXM2?=
 =?utf-8?B?ZkltbEpMSlQ5Ym5oWEg2dHQyYy8yakxiSWc5WkJKVmF6dHJSQXljRUZUOHFZ?=
 =?utf-8?B?Y1N6SVpBS2FWcDNCUGo4WjRPQ0tGVnpnMzRnZWVKcjh4UEFFNzNOZG9DYWpJ?=
 =?utf-8?B?WHJ6Nm44bit6ZmdRUElPMVpqajdSWUwxY3JWUE04T2lJSjdiVlNTeDVIbnEw?=
 =?utf-8?B?WnRHV3RPQjZrUnVEZFJMR3Jwbi96TW5LQzhwenRZdlh0Rzc0OE83MThYOXVm?=
 =?utf-8?B?NTJVVVNLYklYNEk4UG9sNm9jNHJHMVVQdGhFNmpycStjd0l6WjRpYXhUVmhH?=
 =?utf-8?B?Tm9lSEg1TmE0M3FGVS9jMTlvU2RwMk1xWEdaTVRYUzc3QnV0eTVvRHRnWjFv?=
 =?utf-8?B?dCtGTFJJK2xrbjdHMDU1S0hmc1ROY3ZEanhPanVOWThhQncxZWhwZVVQTzFr?=
 =?utf-8?B?T0gvWVV1ZjV3N2crZzUycW0yRVl4eUhxSk5ycWtuT3dqK2x4bi9nVW1Jb1c1?=
 =?utf-8?B?NThhWGZOV0g5WjQ0Z1BYbzFZWkxyRU5zbWtWRmlTL3h5clNxWjlINnZXY0Rx?=
 =?utf-8?B?RXRML2pacXJwVUsxZjdsSklLUDhuK1JZNnZIeVFreVJ3RVk4d2tJVTdyUm9n?=
 =?utf-8?B?QitUd0h1bVBhSTc0R3pOQ3daaGg5S3ZZWTFmeHd5MHpmeFRCeS9xUUdHazVw?=
 =?utf-8?B?NFZ3U2dSWGRlT2R4ZGQ3SVZjV3hGd2ZHUXYwcko5NTBRWHFSZGlOY1pTU2dZ?=
 =?utf-8?B?cGlkV3RoQlFnUWJaZjYzT2Q3ZWJmclBGM0dHUTVETDR0NmJMeVB5OEU5aWU4?=
 =?utf-8?B?ckwyMS9VeFBZbzd0eTJwU2R0eG9laWNDOHk3K21uSE9HT0Y4dGF4L2R2bjRW?=
 =?utf-8?B?RjRPZDkxMklMZjhtcjlqVUlNeG5zb1QrQWFUUk5OYkFLaDJoY0t1ZjhxREFa?=
 =?utf-8?Q?bdsg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b42a82-2123-4262-3c63-08dd505df56c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 20:51:03.7746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx/Un5ftagLnU9bwysAGAq2KNBONPXjW9Fc8rzgnhzm/uruVuQXeJfbpnbt/VzpR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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


On 2025-02-18 11:01, Srinivasan Shanmugam wrote:
> This commit addresses a circular locking dependency in the
> svm_range_cpu_invalidate_pagetables function. The function previously
> held a lock while determining whether to perform an unmap or eviction
> operation, which could lead to deadlocks.
>
> To resolve this issue, a flag named `needs_unmap_or_evict` has been
> introduced to indicate if an unmap or eviction operation is required.
> The function now unlocks the `prange` lock before performing the
> necessary operations, ensuring that the critical section is minimized
> and preventing circular dependencies.
>
> Fixes the below:
>
> [  223.418794] ======================================================
> [  223.418820] WARNING: possible circular locking dependency detected
> [  223.418845] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
> [  223.418869] ------------------------------------------------------
> [  223.418889] kfdtest/3939 is trying to acquire lock:
> [  223.418906] ffff8957552eae38 (&dqm->lock_hidden){+.+.}-{3:3}, at: evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.419302]
>                 but task is already holding lock:
> [  223.419303] ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
> [  223.419447] Console: switching to colour dummy device 80x25
> [  223.419477] [IGT] amd_basic: executing
> [  223.419599]
>                 which lock already depends on the new lock.
>
> [  223.419611]
>                 the existing dependency chain (in reverse order) is:
> [  223.419621]
>                 -> #2 (&prange->lock){+.+.}-{3:3}:
> [  223.419636]        __mutex_lock+0x85/0xe20
> [  223.419647]        mutex_lock_nested+0x1b/0x30
> [  223.419656]        svm_range_validate_and_map+0x2f1/0x15b0 [amdgpu]
> [  223.419954]        svm_range_set_attr+0xe8c/0x1710 [amdgpu]
> [  223.420236]        svm_ioctl+0x46/0x50 [amdgpu]
> [  223.420503]        kfd_ioctl_svm+0x50/0x90 [amdgpu]
> [  223.420763]        kfd_ioctl+0x409/0x6d0 [amdgpu]
> [  223.421024]        __x64_sys_ioctl+0x95/0xd0
> [  223.421036]        x64_sys_call+0x1205/0x20d0
> [  223.421047]        do_syscall_64+0x87/0x140
> [  223.421056]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  223.421068]
>                 -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
> [  223.421084]        __ww_mutex_lock.constprop.0+0xab/0x1560
> [  223.421095]        ww_mutex_lock+0x2b/0x90
> [  223.421103]        amdgpu_amdkfd_alloc_gtt_mem+0xcc/0x2b0 [amdgpu]
> [  223.421361]        add_queue_mes+0x3bc/0x440 [amdgpu]
> [  223.421623]        unhalt_cpsch+0x1ae/0x240 [amdgpu]
> [  223.421888]        kgd2kfd_start_sched+0x5e/0xd0 [amdgpu]
> [  223.422148]        amdgpu_amdkfd_start_sched+0x3d/0x50 [amdgpu]
> [  223.422414]        amdgpu_gfx_enforce_isolation_handler+0x132/0x270 [amdgpu]
> [  223.422662]        process_one_work+0x21e/0x680
> [  223.422673]        worker_thread+0x190/0x330
> [  223.422682]        kthread+0xe7/0x120
> [  223.422690]        ret_from_fork+0x3c/0x60
> [  223.422699]        ret_from_fork_asm+0x1a/0x30
> [  223.422708]

This hold dqm_lock, then allocate pdd->proc_ctx_bo and map to GPU, it is 
illegal usage.

Not sure but seems pdd->proc_ctx_bo/proc_ctx_gpu_addr is only needed by 
debug mode path, as kfd_dbg_set_mes_debug_mode also allocate 
proc_ctx_bo, the proc_ctx_bo allocation should remove from 
add_queue_mes, and move the allocation into 
kfd_create_process_device_data if this is also needed for non debug_mode 
path.

>                 -> #0 (&dqm->lock_hidden){+.+.}-{3:3}:
> [  223.422723]        __lock_acquire+0x16f4/0x2810
> [  223.422734]        lock_acquire+0xd1/0x300
> [  223.422742]        __mutex_lock+0x85/0xe20
> [  223.422751]        mutex_lock_nested+0x1b/0x30
> [  223.422760]        evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.423025]        kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
> [  223.423285]        kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
> [  223.423540]        svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
> [  223.423807]        __mmu_notifier_invalidate_range_start+0x1f5/0x250
> [  223.423819]        copy_page_range+0x1e94/0x1ea0
> [  223.423829]        copy_process+0x172f/0x2ad0
> [  223.423839]        kernel_clone+0x9c/0x3f0
> [  223.423847]        __do_sys_clone+0x66/0x90
> [  223.423856]        __x64_sys_clone+0x25/0x30
> [  223.423864]        x64_sys_call+0x1d7c/0x20d0
> [  223.423872]        do_syscall_64+0x87/0x140
> [  223.423880]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  223.423891]
>                 other info that might help us debug this:
>
> [  223.423903] Chain exists of:
>                   &dqm->lock_hidden --> reservation_ww_class_mutex --> &prange->lock
>
> [  223.423926]  Possible unsafe locking scenario:
>
> [  223.423935]        CPU0                    CPU1
> [  223.423942]        ----                    ----
> [  223.423949]   lock(&prange->lock);
> [  223.423958]                                lock(reservation_ww_class_mutex);
> [  223.423970]                                lock(&prange->lock);
> [  223.423981]   lock(&dqm->lock_hidden);
> [  223.423990]
>                  *** DEADLOCK ***
>
> [  223.423999] 5 locks held by kfdtest/3939:
> [  223.424006]  #0: ffffffffb82b4fc0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1387/0x2ad0
> [  223.424026]  #1: ffff89575eda81b0 (&mm->mmap_lock){++++}-{3:3}, at: copy_process+0x13a8/0x2ad0
> [  223.424046]  #2: ffff89575edaf3b0 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_process+0x13e4/0x2ad0
> [  223.424066]  #3: ffffffffb82e76e0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: copy_page_range+0x1cea/0x1ea0
> [  223.424088]  #4: ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
> [  223.424365]
>                 stack backtrace:
> [  223.424374] CPU: 0 UID: 0 PID: 3939 Comm: kfdtest Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
> [  223.424392] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  223.424401] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PRO WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
> [  223.424416] Call Trace:
> [  223.424423]  <TASK>
> [  223.424430]  dump_stack_lvl+0x9b/0xf0
> [  223.424441]  dump_stack+0x10/0x20
> [  223.424449]  print_circular_bug+0x275/0x350
> [  223.424460]  check_noncircular+0x157/0x170
> [  223.424469]  ? __bfs+0xfd/0x2c0
> [  223.424481]  __lock_acquire+0x16f4/0x2810
> [  223.424490]  ? srso_return_thunk+0x5/0x5f
> [  223.424505]  lock_acquire+0xd1/0x300
> [  223.424514]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.424783]  __mutex_lock+0x85/0xe20
> [  223.424792]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.425058]  ? srso_return_thunk+0x5/0x5f
> [  223.425067]  ? mark_held_locks+0x54/0x90
> [  223.425076]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.425339]  ? srso_return_thunk+0x5/0x5f
> [  223.425350]  mutex_lock_nested+0x1b/0x30
> [  223.425358]  ? mutex_lock_nested+0x1b/0x30
> [  223.425367]  evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.425631]  kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
> [  223.425893]  kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
> [  223.426156]  svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
> [  223.426423]  ? srso_return_thunk+0x5/0x5f
> [  223.426436]  __mmu_notifier_invalidate_range_start+0x1f5/0x250
> [  223.426450]  copy_page_range+0x1e94/0x1ea0
> [  223.426461]  ? srso_return_thunk+0x5/0x5f
> [  223.426474]  ? srso_return_thunk+0x5/0x5f
> [  223.426484]  ? lock_acquire+0xd1/0x300
> [  223.426494]  ? copy_process+0x1718/0x2ad0
> [  223.426502]  ? srso_return_thunk+0x5/0x5f
> [  223.426510]  ? sched_clock_noinstr+0x9/0x10
> [  223.426519]  ? local_clock_noinstr+0xe/0xc0
> [  223.426528]  ? copy_process+0x1718/0x2ad0
> [  223.426537]  ? srso_return_thunk+0x5/0x5f
> [  223.426550]  copy_process+0x172f/0x2ad0
> [  223.426569]  kernel_clone+0x9c/0x3f0
> [  223.426577]  ? __schedule+0x4c9/0x1b00
> [  223.426586]  ? srso_return_thunk+0x5/0x5f
> [  223.426594]  ? sched_clock_noinstr+0x9/0x10
> [  223.426602]  ? srso_return_thunk+0x5/0x5f
> [  223.426610]  ? local_clock_noinstr+0xe/0xc0
> [  223.426619]  ? schedule+0x107/0x1a0
> [  223.426629]  __do_sys_clone+0x66/0x90
> [  223.426643]  __x64_sys_clone+0x25/0x30
> [  223.426652]  x64_sys_call+0x1d7c/0x20d0
> [  223.426661]  do_syscall_64+0x87/0x140
> [  223.426671]  ? srso_return_thunk+0x5/0x5f
> [  223.426679]  ? common_nsleep+0x44/0x50
> [  223.426690]  ? srso_return_thunk+0x5/0x5f
> [  223.426698]  ? trace_hardirqs_off+0x52/0xd0
> [  223.426709]  ? srso_return_thunk+0x5/0x5f
> [  223.426717]  ? syscall_exit_to_user_mode+0xcc/0x200
> [  223.426727]  ? srso_return_thunk+0x5/0x5f
> [  223.426736]  ? do_syscall_64+0x93/0x140
> [  223.426748]  ? srso_return_thunk+0x5/0x5f
> [  223.426756]  ? up_write+0x1c/0x1e0
> [  223.426765]  ? srso_return_thunk+0x5/0x5f
> [  223.426775]  ? srso_return_thunk+0x5/0x5f
> [  223.426783]  ? trace_hardirqs_off+0x52/0xd0
> [  223.426792]  ? srso_return_thunk+0x5/0x5f
> [  223.426800]  ? syscall_exit_to_user_mode+0xcc/0x200
> [  223.426810]  ? srso_return_thunk+0x5/0x5f
> [  223.426818]  ? do_syscall_64+0x93/0x140
> [  223.426826]  ? syscall_exit_to_user_mode+0xcc/0x200
> [  223.426836]  ? srso_return_thunk+0x5/0x5f
> [  223.426844]  ? do_syscall_64+0x93/0x140
> [  223.426853]  ? srso_return_thunk+0x5/0x5f
> [  223.426861]  ? irqentry_exit+0x6b/0x90
> [  223.426869]  ? srso_return_thunk+0x5/0x5f
> [  223.426877]  ? exc_page_fault+0xa7/0x2c0
> [  223.426888]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  223.426898] RIP: 0033:0x7f46758eab57
> [  223.426906] Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
> [  223.426930] RSP: 002b:00007fff5c3e5188 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [  223.426943] RAX: ffffffffffffffda RBX: 00007f4675f8c040 RCX: 00007f46758eab57
> [  223.426954] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [  223.426965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  223.426975] R10: 00007f4675e81a50 R11: 0000000000000246 R12: 0000000000000001
> [  223.426986] R13: 00007fff5c3e5470 R14: 00007fff5c3e53e0 R15: 00007fff5c3e5410
> [  223.427004]  </TASK>
>
> Fixes: 4683cfecadeb ("drm/amdkfd: deregister svm range")
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Alex Sierra <alex.sierra@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index db3034b00dac..a076269cce7f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2574,6 +2574,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   	struct svm_range *prange;
>   	unsigned long start;
>   	unsigned long last;
> +	bool needs_unmap_or_evict = false;
>   
>   	if (range->event == MMU_NOTIFY_RELEASE)
>   		return true;
> @@ -2597,14 +2598,21 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   
>   	switch (range->event) {
>   	case MMU_NOTIFY_UNMAP:
> -		svm_range_unmap_from_cpu(mni->mm, prange, start, last);
> +		needs_unmap_or_evict = true;
>   		break;
>   	default:
> -		svm_range_evict(prange, mni->mm, start, last, range->event);
> +		needs_unmap_or_evict = true;
>   		break;
>   	}
> -
>   	svm_range_unlock(prange);
> +
> +	if (needs_unmap_or_evict) {
> +		if (range->event == MMU_NOTIFY_UNMAP)
> +			svm_range_unmap_from_cpu(mni->mm, prange, start, last);

This is incorrect, we should hold prange lock to split prange.

Regards,

Philip

> +		else
> +			svm_range_evict(prange, mni->mm, start, last, range->event);
> +	}
> +
>   	mmput(mni->mm);
>   
>   	return true;
