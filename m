Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27A8D59F41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 15:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A373210E2E6;
	Wed,  6 Nov 2024 15:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQdDAs0v";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDDB10E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 15:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYucSOGxWlRjKhT1EY5ciqe5kH+1M807xvAXPfyUfVCdQsML8Fa1IagKCZ9r78f8CqdqmCOzX1SCbVZqp2G9OSrZqSoEvAH93mEG4xyyQrPkb0UOBJFkO364Uf1xGb6bmY2RZHT08gTJ65M+yoaIaWrAcTJpMYZCJukhjBezm99nWAFrzsVYg86xlipDLCp2H5sbzWPV9FHyuQ+PUkI6RBu+o5c2hUhxcrvMIcbGSMLq28aENZGGgZF+uwMbKHtspIFZEwQEr/pWXMv6HEGv0bPpYMZDmZTH3Mbp5MiSxuYBlgSITWOyxGOBG6E39LEStLjTm4LE6bUmlAIs9J+qdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/5QrUBEuU9PXnzapo3wOq260wWtyl9Ktzj7GIPsIoM=;
 b=BKxEhNvkhsgBsjl+OuZnH/MmxQyXlfd46ojNM39CH25wMWKoUDuVvNl2Nbw3G5NMJAz2IE4FdnhJ7XZ4XoL1FMuTk0jUzEPXqOD+ZdMp92TiWVq6oXPm0Hr9zinSVmF2JRAFSwdmZRmHRp7cpp2IM3qw6xiz6PNnwe9TZ9cI3tpPiaagaphK4TUy9oNdU89zl3uVHZgVD8iWg0AJ9wvbQD3Nng/VJP5CbmfKO9dz7hwuYkM740W/f/4r/sFhNUPXvTgY0t/zEnirfILxRxqB9fNRjS9gnQQ6ksMhzxoYRh5GBT5ohSQTTkl0ZDQxp3LLxna8422R2AyTHyKGBDYjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/5QrUBEuU9PXnzapo3wOq260wWtyl9Ktzj7GIPsIoM=;
 b=DQdDAs0vXla73NhAKfTOPjFetFWxzjalmTZNZW2i18P53zw3PjpkbaWmWQwzURTRnVCdfMnrFzcpcAieaz8WYWqx7/zTOvGM9595c9hEN68vIzaEOJFkC3l33W3HML6xoUf1gHwmTGfx7ZRaGcQzeY8ZJvrIDoh2wALxBAQ6euM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 15:45:52 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 15:45:52 +0000
Content-Type: multipart/alternative;
 boundary="------------PYqHpVZpw0uISjUADlD1ml0g"
Message-ID: <905dfd0c-9926-416f-a9a8-9abac7e5e921@amd.com>
Date: Wed, 6 Nov 2024 10:45:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu/vcn: Fix kdoc entries for VCN clock/power
 gating functions
To: amd-gfx@lists.freedesktop.org
References: <20241106020918.4086736-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241106020918.4086736-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: YQBPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::34) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 2166764e-314b-43b9-b59a-08dcfe7a1807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkNIR3RKMFJCUzUvKzFZMFBPMENncU9HckQ3dkFaMWtraG9sTnFyQlduNWRO?=
 =?utf-8?B?VmQ0UVgyejhZSXpXTFpQeXRYZ0E2dnhCSkthb0t0YVZqOTJPVHZOaTRiak42?=
 =?utf-8?B?cExmVHYwUnZSTkY3ZkFodTRsdmNUbEFWcWJHbXc1N0pTVEFrVG54WkVpKzhQ?=
 =?utf-8?B?Nkc4b3hCZExRRVpMSE9CeTZzeXVnVzV5SENvVjUwS0tYSlNXbjhwVGszdlVz?=
 =?utf-8?B?MklJQzYyWHoxUWpLNVJvSU0xcDBQMnBBYW5mSC9NM2tpM2xLOHRZTnBxcVc0?=
 =?utf-8?B?WG4vWW5EeWU1ZWFQdE5UT091T1R1KzRxRmdVK0k5WlV2bWYxb3gvdHRSMU5I?=
 =?utf-8?B?MEp4V3lZQjNhZ0dOVmxTR3RvbjI0aVpyT09wbDZXTHNGV3Z3WTBLVkdwcnlH?=
 =?utf-8?B?N0Q4dUMxamVLL3dZYnE2SDFOOHIrYzVlU20xbW9PVy9CQklFSjFob3BvQ3Iy?=
 =?utf-8?B?YzNlMlUydkpHaUtSelU2UTkyazI3elhUMVpOWndxOWRISDBhMldIeGlSK21C?=
 =?utf-8?B?MkhBcWhMUG1oMUZGNkc0M3BMMTBIbjR3RHNDQlVwMkNQTnhSRlJxdTQvaXhh?=
 =?utf-8?B?TG82dUx0NDVwalY4Mi9XaTc2a0xicFp4N283OExXaGgybEVSQ0RBckIwL0Vn?=
 =?utf-8?B?R2lIL2pPNUV2dHBRTjV0R2pHVFY3ZkptUXh6QUhNTUdtUDg5R080Z3Z4b1Js?=
 =?utf-8?B?TGN1aXl2d0V5Y0QwOUFpQnpUT1hkdytGUnhwNmFIRFRrQUIwUUllQ2VBYmp4?=
 =?utf-8?B?L1p5KzdXbTJnR1lTcnhPOEVTTzRiU2QxdnQyUmx2eDdwVDVaNnF3NHRoMlFt?=
 =?utf-8?B?am9yOElVRlQ1Vmk0SUVhQlljZGxjUmRHN1pScFBkNEtCSFY1WmFjYXBCUFJM?=
 =?utf-8?B?VE5xQnBNUlBlendHOTh3VFRmS08wYzlMZG9TR3V6ZGtUTGdYVWZXQnZJTnh4?=
 =?utf-8?B?SitKRVY1bDVIbGlrT1hIaHV4STVTcm16Z2F2OUxNNUFSQWpKdUlpbnRaMWVS?=
 =?utf-8?B?UjUxbzNONkR2OEZPOEk4dHdXd2crVEdVcTUyYmg5ME9TU3VVS1FnbGd0ZCtk?=
 =?utf-8?B?N1k1ZDVQbXpFcyt5c3VSS0ZVRTFNeTRFYW5YbXAvMlZGeWl3clZvK2RENUVH?=
 =?utf-8?B?VXBZKzZFMDMxNm9tK0Z1UDhFZncvaFd2b3J6cE1jR1ZWTUMzaTZvVnlycnpT?=
 =?utf-8?B?R2RTTDRXZmJMazdSSTBSVTkxL2JkbC9SLzF4QVg3eE55dk1XVnNReTFuRklq?=
 =?utf-8?B?c0wvWEhrYzUxK28yN3l2V2N1ZWRZMHBaVEE1b2QvN0toZkFnTitlMU5Jbm81?=
 =?utf-8?B?SVIyL1dxVHg0cGhxTjNtQnN0bFBzRG1lWmFoejZZa0N4V1pvN2FtQmRRSXlO?=
 =?utf-8?B?cE1WN2dDVlg3THN3NlpDaHZoaHNOckxER0NZb3c5TVA5czI2NFFTTDBSQnJZ?=
 =?utf-8?B?Q2JHaU9vdWVlVGtHVlhzVEUvaHh2dkYxWG5hREhQcU1QcmpvbDNMVHI3clFI?=
 =?utf-8?B?aGNzbmdkQUs1amJtQkhoM1QvYlZxQVFvSEVTNmRMM2xLQ0tITVRqT3lTSkJI?=
 =?utf-8?B?OVlCdS96QmFmdnNSL3M3UFJ4N3FuUVA2KzM5RU5reUYwYW5vRjdZOEV4dnRI?=
 =?utf-8?B?WGlSSUxraGJaYXk0YkV3R1JHTnBST2ZUTnpwYTJSTWNCTHdwREdBUlBvaURx?=
 =?utf-8?B?QkJyWE81M05uek9VZnhGc2ZacUxxbGI3a3dGTzJPVEpsZVUzK3Z1WHhzeXA5?=
 =?utf-8?Q?YDhuIFHngRuMY0rb+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VktMNUNrS0NKUTRualpuUTlZUFN1bTc1bEtHbzdCbTNQVDc4VTRHb3lXUmZG?=
 =?utf-8?B?QzdOeTZ0ME9nOCtOSGlIVGIwSU1TWFZWRW9rUGgwV2FyTGRkRkdqNDB1ZWR6?=
 =?utf-8?B?YkxYa21QUnlDU29wbklnOVFxVmV1T1BqcXUxMlRaWG1CL3ZoQ2ZTMXY0UmdL?=
 =?utf-8?B?TzJ3NDVKakJwakkwNjljcHZPSExUU00vRXVwcmt4VmROTTRtMHdqMVl1VFpT?=
 =?utf-8?B?MWFPY0ZkejBBRm5vUkdtMGhSVDFyenBwbE1GdXV2YmhrRUZnbFFjd1IxUlJH?=
 =?utf-8?B?NFlnUnVmMnc0ZkRucmJvN2NDWlBnTURSS3pzWnFiUHE0VjE2MzVEdlpzNXNW?=
 =?utf-8?B?cmhnbnFaclFXMEM3LzdWN1prdXpudlo4SkFZcm9hRlR1ZVZjZjZvR3RRdWNC?=
 =?utf-8?B?SHlzV2dyRWhiUkg0Mk5XU3hLU2YzSUxkbVdUS3U1TjA0VmNWcDh2bmVobVlq?=
 =?utf-8?B?TXBWaDZwM0o5ZXc3ZlI5SUltOWpYaE9RYklicU5oQkw0YkpUeUxQUXJ4a1VC?=
 =?utf-8?B?SGMzS1ZOazBIL0YrUk9rZ2luSVVHMGNvZWFsUDUyOEIyMWVYWTh6TVFYS0M0?=
 =?utf-8?B?NU5OOGN3THgzaVROcGJXRm1Vc2lENy9ka2JGTGpuWUJ5MmVTbDh2SjJoaytP?=
 =?utf-8?B?amIwci9ESGU4VWFuWXZQZ3VDajNhVVBmbFlTVUpWT3RUOW8wUHZjT3g1U0dm?=
 =?utf-8?B?clN2aXo3MFRCVEcrdURza04yZ0doZ282K1E1NUthUEtaTEMyZ1d6Q3R6VUtG?=
 =?utf-8?B?cWpYcE1QTWd2K1FFMzhXVE0xV3FSWHZ1UWVzYkwvS2J4aUxLbmJSS21PUm1w?=
 =?utf-8?B?a3JiVzRJWEI2eEFLT2VpRjJtOXpXdmEzQlI0N3liZVZVMWdiK0pEYjJQUWlh?=
 =?utf-8?B?bVlQeE5EdGhUa1pKeHV1Mk9iWGovL1g2cmdTNzRwb3pNQjdRZy9XZ2FQS0Jl?=
 =?utf-8?B?cWJWWDEwbmZCNEZsZ3JoNG1DanhFbzZYS2dRY2NhNEN5a1FtWmJRVVBaSUpY?=
 =?utf-8?B?QTcwL1BpZ0w5cTRWMVhvaHdGcG5mWXdpOFplaU5qNjR6Tk56TDIwd0JSM0d3?=
 =?utf-8?B?TWl6Z0NPcndXeGdvNGNOdDltWmt5ZVFnWERqOXdtc3JqTFNsL2JsSytCcEtD?=
 =?utf-8?B?dnVyajFJVDdONENDVTltSnNQV3F0eHkrWGl6UEZpQmY4eVZ0VnU2UTZFYXJ0?=
 =?utf-8?B?R3F6eTVxOUJQdkJOV1R2UUlQM1R4R2Z1aEtHMjFLY285REUrRGlaTG0yVGpW?=
 =?utf-8?B?TDBWY285bmFLYmRqd2gzSG1tUHJhdVFlTEhWdWRHc2dVUStKWjlQK2o4U2xx?=
 =?utf-8?B?MlIrMEViUFAvbVV1RnRiQk5lcHYyMXlZMEFnTWtUSTk4RHNRUjB6SGtuNStI?=
 =?utf-8?B?eGVORE92NE1YVFhqTTNIdEUvdUVDZit2bXk2aDRhS3k5c0tPYy9MTUZycGJo?=
 =?utf-8?B?Qkt1b3Bzd2hhbGdvMUU1bXJwTzZxdU1lenpGcXY5MWI4TzZ2RXIwWTFzaTYx?=
 =?utf-8?B?ZUtIVno4cXd4S0N1UjNaMGZNNmpLM1NrV0M3eElDYU1xa2J3d2JNT3AyRjM2?=
 =?utf-8?B?bXlhZXkyRjJXVmE0RHBnOEttcUpRbS9hQUZsZE9TMytraFBXWTdnRDVhN0xy?=
 =?utf-8?B?WUljK3B3cjNYL01saVhBSWFsKzltMFM2d3p6WFlWVnQ4NW9rYXoreGlJNFZp?=
 =?utf-8?B?R0NUZjd5U3d1elZkUlY0S1NYVGxqQVh2MmNjTzNwNWV4aEVMdGp0UjJ4bDk2?=
 =?utf-8?B?bjF3ZVBjNzRFWVNnS0IwbDh0blVwSndDOVBCcVlMUnpleXlJOEVhaEJxc0xF?=
 =?utf-8?B?ZEI0WnNUam5mUjJTVlNSTVlaOE1qNmtJb01yWHRwa1pNM0xZRzZyd082MTZ1?=
 =?utf-8?B?clZpVlplMlh2cXFDdHE0eVlISTE3VUF4T0NoMlB1QzV3Tmt6WnpCT21OdHpG?=
 =?utf-8?B?K1VXenFhZVViNnhiUnVLNDdIeUN2YkNBcjJhWm5sZUZYRUtiMThkdE42OFJO?=
 =?utf-8?B?UnRwY1pzazdzcWxJOVpnUFBEekpOZmpLdjg4dWtRU0orQ3FPejhvd1JycW96?=
 =?utf-8?B?TnhhRWhPYk5kdUkvT2tsVU82RWJ2WUJBbUt0VzUvUWRWcUI2elhjcE9GaWFC?=
 =?utf-8?Q?wD5dlhyG19pQOQOAJsl8KyGBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2166764e-314b-43b9-b59a-08dcfe7a1807
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:45:52.3780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyN2/M6BdAblaT+ughdwL6jcJPsol16AqcVk3paaFJ1yA/cp9EZJ4NWRYFkD/xvLHhKlwFzs5Zwogk8Grt/vDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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

--------------PYqHpVZpw0uISjUADlD1ml0g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>

On 2024-11-05 21:09, Srinivasan Shanmugam wrote:
> This commit corrects the descriptors for the
> vcn_v4_0/v4_0_3/v4_0_5/v5_0_0 _set_clockgating_state and
> vcn_v4_0/v4_0_3/v4_0_5/v5_0_0 _set_powergating_state functions in the
> amdgpu driver.
>
> The parameter descriptors in the comments were mismatched with the
> actual function parameters. The non-existent 'handle' parameter has been
> replaced with the correct 'ip_block' parameter in the comments to
> accurately reflect the function signatures and to resolving the below
> with gcc W=1:
>
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1232: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_set_clockgating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1232: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_set_clockgating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1263: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_set_powergating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1263: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_set_powergating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2012: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_set_clockgating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2012: warning: Excess function parameter 'handle' description in 'vcn_v4_0_set_clockgating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2043: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_set_powergating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2043: warning: Excess function parameter 'handle' description in 'vcn_v4_0_set_powergating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1505: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_5_set_clockgating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1505: warning: Excess function parameter 'handle' description in 'vcn_v4_0_5_set_clockgating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1536: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_5_set_powergating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1536: warning: Excess function parameter 'handle' description in 'vcn_v4_0_5_set_powergating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1629: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_3_set_powergating_state'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1629: warning: Excess function parameter 'handle' description in 'vcn_v4_0_3_set_powergating_state'
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 87c8f1c084a5..385596df47aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -2002,7 +2002,7 @@ static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_set_clockgating_state - set VCN block clockgating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -2033,7 +2033,7 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   /**
>    * vcn_v4_0_set_powergating_state - set VCN block powergating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 7b0f350d5fca..ac0e76cbaa2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1591,7 +1591,7 @@ static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   
>   /* vcn_v4_0_3_set_clockgating_state - set VCN block clockgating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -1619,7 +1619,7 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   /**
>    * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 9c5257f370f2..98d0ee299c74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1495,7 +1495,7 @@ static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_set_clockgating_state - set VCN block clockgating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -1526,7 +1526,7 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   /**
>    * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 4ecf0aea156f..9cd4d70058ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1222,7 +1222,7 @@ static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_set_clockgating_state - set VCN block clockgating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -1253,7 +1253,7 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   /**
>    * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
>    *
> - * @handle: amdgpu_device pointer
> + * @ip_block: amdgpu_ip_block pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
--------------PYqHpVZpw0uISjUADlD1ml0g
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="3" face="Times New Roman"><span style="font-size:12pt;"><font size="2"><span style="font-size:11pt;"><span data-markjs="true" class="markwv0w52iao" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span>:
              Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></span></font></p>
    <div class="moz-cite-prefix">On 2024-11-05 21:09, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241106020918.4086736-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This commit corrects the descriptors for the
vcn_v4_0/v4_0_3/v4_0_5/v5_0_0 _set_clockgating_state and
vcn_v4_0/v4_0_3/v4_0_5/v5_0_0 _set_powergating_state functions in the
amdgpu driver.

The parameter descriptors in the comments were mismatched with the
actual function parameters. The non-existent 'handle' parameter has been
replaced with the correct 'ip_block' parameter in the comments to
accurately reflect the function signatures and to resolving the below
with gcc W=1:

drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1232: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1232: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1263: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1263: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2012: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2012: warning: Excess function parameter 'handle' description in 'vcn_v4_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2043: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2043: warning: Excess function parameter 'handle' description in 'vcn_v4_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1505: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_5_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1505: warning: Excess function parameter 'handle' description in 'vcn_v4_0_5_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1536: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_5_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1536: warning: Excess function parameter 'handle' description in 'vcn_v4_0_5_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1629: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_3_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1629: warning: Excess function parameter 'handle' description in 'vcn_v4_0_3_set_powergating_state'

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 87c8f1c084a5..385596df47aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2002,7 +2002,7 @@ static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -2033,7 +2033,7 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v4_0_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7b0f350d5fca..ac0e76cbaa2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1591,7 +1591,7 @@ static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 /* vcn_v4_0_3_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -1619,7 +1619,7 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9c5257f370f2..98d0ee299c74 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1495,7 +1495,7 @@ static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_5_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -1526,7 +1526,7 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 4ecf0aea156f..9cd4d70058ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1222,7 +1222,7 @@ static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v5_0_0_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -1253,7 +1253,7 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
</pre>
    </blockquote>
  </body>
</html>

--------------PYqHpVZpw0uISjUADlD1ml0g--
