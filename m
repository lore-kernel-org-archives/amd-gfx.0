Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B58C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 15:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F10011211A;
	Tue, 30 Apr 2024 15:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sl3hdVPU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BC411211A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 15:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WawciZs7TNCQvT4C9OBeHM5DYwNmPOMJhadWUdWaDGO4XZ0MLR4Xq1jlSWm16tYagSQbQ8tObPIidJExgXVlQBw2m/gxvLTM7t5jO2D1aQxhlB8pcOaAdWdmF/CkaE7otKh8jJCKeSpof2oCKr9en6meAyTqyM7JfISr5GBCdqYQVzZeNy8xukTwcVJJHEZyaa+9tbXKdwHvWwQeZVBAAZnlDReVjmDXt8IiDGh1U1xpysFFAhsgfbCXeskL/KzBVEQNraFlRmxvv4J4Sz2GAtTGmK7Yc4e1kFYz4iIDhkaaxTNdyK78iPwT1a7Rp/BN8kTyTIXGA5KZtboF9qqkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgrvloCG24XRr7R3RBuJ4XHjQQa4SjhC5lSyteG8ZT4=;
 b=N7L93sd7Jejn9DaiAYShikutcIy3Jc9th5vb3OqDDbaoAWzHOYj8t0FKpA323EKwoMoGGvoU9ujEqFWumYYHrUzsfdFV80So9GSefQPbyrYpiJwB66R0OUOTJ2AfAlFs43tKD/2plmNmtaU/DgNlr8HWKBdp1PZbEbZNGVmD2i7m6JQATjNz1t2HycoEsj+3oEFc3n0oPoSPnJmkGHfD00auae9tp3HNCBlvuG2pbGBJXUR/uVZbK9ohPmXARhG1lrsEqSdIwvbksjkBSrjPnSe0tXK0kIbs54n/26moJ8DlC7iwPYuuNSQcBbiyXHprEFUXTVTUBmsIyfj/t2PhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgrvloCG24XRr7R3RBuJ4XHjQQa4SjhC5lSyteG8ZT4=;
 b=Sl3hdVPUJLdXmYn41UF6yxaldjo++3VCxgLvj/JUu0WEHlEMPUlq5IUNlgv8MbHr4XAox2s7CJN4TZOfIy1yFlCxkzq2cv7c6w9g+h6Z3E3B6llo6yEGXbY9tkY0JbgPzxNo55E9sgDU2frKIkBH1JWqxkYR6W9b8QmiDBuXXIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 15:37:53 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 15:37:53 +0000
Message-ID: <415184e1-1dc8-41e8-a6eb-abb5259d3d53@amd.com>
Date: Tue, 30 Apr 2024 11:37:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Disable panel replay by default for now
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Tom Chung <chiahsuan.chung@amd.com>
References: <20240430151241.14046-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240430151241.14046-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 456a692b-5a93-4c8a-4548-08dc692b8020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnZwMzc0K0VVYTNsNDM5R3FJTnNaK20vWTNLbWpFakJ0MzUwOEIybk1udWZU?=
 =?utf-8?B?R21DMFBSK1loTENzUGFKZ3lld3VyMVFlQ3pEb3QyWURHMkFET2tZRkRLdTlH?=
 =?utf-8?B?dzZlVm50VjJ2VS84M1ZXRGZhdWlNRmhKL0RxL2E5RWl3MDJFNlErWHlKQXJD?=
 =?utf-8?B?VFg0ei90aUREcVRoOStuM2ZFU0xZUzJqdjh4RXo1MDJSZGxtR3ZyWThKamt4?=
 =?utf-8?B?aFpqTG9laVlmbU9QdHdZNVJXWHRDa2xHQUtZK0hYNDdaNlZKdFVTR1phNDlm?=
 =?utf-8?B?d3lBS01DY3pQMjBIU2NoeGxRTXFEdVNCSGF4K2l5U0xwbm44d2lKa0JXcDhQ?=
 =?utf-8?B?L3g4VGY2WFJESGcrZEQ4OXZUNGhQa09CMFFmUnI2UFR2NHlOdFdGcnpHYzdB?=
 =?utf-8?B?L2Q0NWZxL1VvekdiYlBlcFJxUzR6azFDM29md0JtL3VIZ25ZL05sWWFnek9V?=
 =?utf-8?B?YU9wTWx3Yk90MkVrZHdwY1JBdXRubVhaUmFLdzV2RXJ0VDlhNmxncWFaN01O?=
 =?utf-8?B?OEVITkFGaExZaU5HeTZCNVN4c3ZMMGFibmtXdmZ6bC9ERUMxK0xESDFVSElz?=
 =?utf-8?B?d0diWlU2N0J3M3RHall2Si83aXZVb21rQXcrWHZEY0djcnhpMjJHMjVLc3Iv?=
 =?utf-8?B?MzlqZWNHWTJSQjRaNTNoZW1VL2VZZ1U3NGpZSnlseWwrbW80L2FPeHAzZUxy?=
 =?utf-8?B?dFZxUVJlN2k0MFgzNkxQeW5SeXU2SWpEenhCR3ppWk14RFJubTN6RU9Pekpp?=
 =?utf-8?B?a2JIRS9yZ2IxYXcyNXNJWW4yeXpRRlJrTTNKMnQwK1hPR205S0N3djlZRHhs?=
 =?utf-8?B?VHFZRnptb2xseTAvR1dWenN4QnF0dWVEUkZkVUphY3FuaUQ4b0kyVWxNWWlD?=
 =?utf-8?B?MmNDampITElLRTNNZWNBSng5azlqbGZKSHI3bXlhWkdEQjBmU1Rhb2phV2FC?=
 =?utf-8?B?R0IyTXpTTGIxcHlFbVhna1ZoeXVnNlVUTyttOHdLOERCd1R4TFM3TFp0aTNk?=
 =?utf-8?B?V2l5WmxjbFJDVHhOd3pUZjk3b3pCM0dsU1F4QlEzZkhFYUl3Wmd0UHNWTmJ0?=
 =?utf-8?B?WlZka3NzR2lVRU0rZUo2MnFzbGNyZXNWWWEwVHl6aXVwNmxqQU5IZkNPdHRP?=
 =?utf-8?B?NDQ3dkZ0ZmVHZUwxZERVcUFEZVA1ZjN1ZHA0eEZQWUU5eE5JMlJtSUlEajFs?=
 =?utf-8?B?MjRGbmRSdmJ6K2o1TE4wVjcxa25zNFhKRTkvZVpRTmYxdkJkV1ZPTlYrZjd3?=
 =?utf-8?B?aXltbXBtZGlaSkFsZDZURGFQM1hkWU5DczBDYnJyVXFBMm5rbTgvcG5ZUndx?=
 =?utf-8?B?ODhSd0ZpdEJRalFvYSs3UU9lWnJTdlhaUHlTZlhtckUzQmtZWHlvQ3VoQXpN?=
 =?utf-8?B?Q1F0S2JiT21kRWJHTmowaWdjZnZnRElXbUVHU25IdTJKclpYNktQSElweWVh?=
 =?utf-8?B?eFp6WEhQbjJPTHEyVElENStyd0JLLzk4Y3RUT3hIVWt1TFYwTzZDQlJod2ZJ?=
 =?utf-8?B?aHBzYWllTzhIMDg0dDBlVEtqdDlOOHJGU3R4a0VvaXh0c0p1eStCc3hoR2ZO?=
 =?utf-8?B?MW5MWnFYTnRnWlFtUWpyZTNQNit1OG9pQXNtUnU1bHh4cGZuSFpUMGtpMzRU?=
 =?utf-8?Q?hpxMNk01RGkkKo6f1Nph0ajbwPiSbzhqB8at/c5tMEuE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZnekN6M0NTekp4WEZPUHlGNXh4LzhnQnhqL0xkL25xbWJtZVFEMm03MGRP?=
 =?utf-8?B?VDZnMEtxK1pLT29kemdWTnpqOFBHQkV4NCszdlRQR2Z6UEo4TVRVeVJTQzR4?=
 =?utf-8?B?RTJKNHlzWU1ZdGJvd2QwSk1FalNuY3NnMVNzcUk3Q29BRjJRRzJMQVczTVpJ?=
 =?utf-8?B?eUJMUnBwWFp6TS9tS2NlWWpUbmlyM1I1VTVNQi9KUFNOY2x6Ukt3Nm9DeXM3?=
 =?utf-8?B?UkZNZ2dscHNTUHF4eDhpU0ZLSlVnOW5Ca1FnSjhnVW1pUTluUVFERU9xNmlq?=
 =?utf-8?B?K3hPbzJlRy9xZW5IaFVJazJuV2xoc0VWbWJVdENsemtpWnhQV2tUcnpOblhw?=
 =?utf-8?B?cFg2UC8yL1ZxSklqSWUwWVRpaHQvai82VU1DazA3S0VxUUtBcHBSZkh6MGY2?=
 =?utf-8?B?VTVUSlJ3Wm50U1FQU0NuZ2hEZEV2aUFqNDFmejlyZis3MHdoVlF1MFRUMGJi?=
 =?utf-8?B?ZlduUk8xaEk5Yk9UYXFDMXBiMHFGTURTSnlxMWlXMFNPaEhnUGpUM1JralFa?=
 =?utf-8?B?V2s5UlNMZXo4RXdheU5WMkoyd1JiMG1LTGVBc0lVZ3pMbUE3N2s0ZG1pTStp?=
 =?utf-8?B?c0xYQWxYSmhBMTJjMkduS0M5U05aSUFDS2F0ak9BclBTUHQrQ083bTdzSXJI?=
 =?utf-8?B?R1FyeTZxU2NvQzBIRi9mbWs0dE9tZmliRldnbG5PNGM4aTdpRjZ6MmIyRnRq?=
 =?utf-8?B?c1FKTGxzeWNZZE1CTEpqTFp3VU5xT0xMOWpsTlhuRDJObkNBWUczalhYRldi?=
 =?utf-8?B?QkdxWmFmNXhLYklHbjlnNFlVM1NuN1RHdkZVSGFicnFwSXRWUmNMRStxem1F?=
 =?utf-8?B?K2JyYjJEZVRwQjFvTUxXb1UydXFicDRFQVdDLy9hZkg2czhRQk9pTDRiRDFo?=
 =?utf-8?B?OFZjYTlzMlBtQXVVek5JZjlZRU9DNmFpU0F2eFI1eVE2b2NzS3BOek55R0tl?=
 =?utf-8?B?QU9iWGxuMWcxZWNnZTJyWUhRMDd2SFBqVzNpRFNCWkFxc1VlUU84SkFQUHdh?=
 =?utf-8?B?ektoeDJtK0V4OHhHNlcxUjFkTHZ0RlZjaTlwV3ZhMXczNGs4OXhHYnhlVkNJ?=
 =?utf-8?B?SWxPSlRlVVRZc0FXazJ6RU9sN1VPRENsWXhRdVpXQkFRakFQY3pTQXVUdTB2?=
 =?utf-8?B?elZma3ZaRkZYcnIxd2IrNmhvaW5ROG5lWnlIMTI4TFZhOXhjVmJnbnZjQ2o5?=
 =?utf-8?B?cWZZQTBxYkxVRFRWYnFEL3htNy9LODhpQUFZRUZlQ3NNTWJ6ODNuUFErU0lv?=
 =?utf-8?B?d3N4NGR3Zjh6NUFKM3h5K0xleWxsMm9pTE1BSGovT2hha1c3Sk4vZzlQR2NY?=
 =?utf-8?B?dkVKcElzU2pDdmJPc0V5dHhTYjZqRUlhM0NXTHB1VGIyV1h3RmhITFVJUnNw?=
 =?utf-8?B?MTlZQm5QVW9XTXRJRElQdXQxeEhZSGpkRlk2aDY2L3J1eEt0R1NyZmVqb2Y0?=
 =?utf-8?B?Rjd0b3laRjkyZEc4aGpuRDZaODNvVSt4MCtscktzSWdhK1pHejh3aXVuTXFO?=
 =?utf-8?B?Q2xnTmZWMG13MVQvRG5TbWw4eEgrL296NUJJQStDRzc1dXZuQzc0ME1JUEhl?=
 =?utf-8?B?a2o2R3hHbmIrTFB5anVqeC84R1hndERMOGtYWmtPR1lWUWNCRzFPQzk2WE82?=
 =?utf-8?B?dmFIUDYzdkt2Tm84UU9yWjh1bmRsdGN4YjVLZmNrZ254M28yUklvMDVPWGZs?=
 =?utf-8?B?UjFDVTZSc0Vzbk42anlzdnNqTDArOTh4YmYxQ2F2cHZBS3JuV2RQOXdXVVRq?=
 =?utf-8?B?MFovVFgxRGkzdGo5UmtzMGtRNGxnM0JzTDEwR1NSb0pKdWl4bzBZSG1mdklp?=
 =?utf-8?B?Rk1vN25rUXRmcHB3bFVzbEoxSFlNV25xL3V6bDRNT1FVSWU2dU9rWUFpN0FE?=
 =?utf-8?B?TVRKVWJKbktmSWV1MVFVeGtIVHdXUThoSGRNbktpSkJQaElDNlliKytQdDVu?=
 =?utf-8?B?ZU5DbDJqZ3h5SmxrRTBtQUtodWovYVhpUTFldjl2V011dUtZMFppN1cyQWZj?=
 =?utf-8?B?TjFPemZjcHQ4c3YrZUtkdHV5Rm1qVzJVR2RrKzBpRFo1L01vaVFQT0crYzcw?=
 =?utf-8?B?WXdvNWsrV2ZmbjJsd1dma2FmWnhEb1YwcDVQNjlUUWc3SUtIMm5kTGVZMnBN?=
 =?utf-8?Q?g25wmScrEiaILEfR14zh3+qtv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456a692b-5a93-4c8a-4548-08dc692b8020
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:37:53.5358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpy1Hk3U7T6RxOuE0H2ln6Tnn3PQ7RYErQrHTUnRxH4hygO4EWWQxr5KBgaR1+aGZ0+NkCNTFiQ1WviTLvNcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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



On 2024-04-30 11:12, Mario Limonciello wrote:
> Panel replay was enabled by default in commit 5950efe25ee0
> ("drm/amd/display: Enable Panel Replay for static screen use case"), but
> it isn't working properly at least on some BOE and AUO panels.  Instead
> of being static the screen is solid black when active.  As it's a new
> feature that was just introduced that regressed VRR disable it for now
> so that problem can be properly root caused.
> 
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3344
> Fixes: 5950efe25ee0 ("drm/amd/display: Enable Panel Replay for static screen use case")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8245cc63712f..b5e5cbbe5e49 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4581,15 +4581,18 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  	/* Determine whether to enable Replay support by default. */
>  	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
>  		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> -		case IP_VERSION(3, 1, 4):
> -		case IP_VERSION(3, 1, 5):
> -		case IP_VERSION(3, 1, 6):
> -		case IP_VERSION(3, 2, 0):
> -		case IP_VERSION(3, 2, 1):
> -		case IP_VERSION(3, 5, 0):
> -		case IP_VERSION(3, 5, 1):
> -			replay_feature_enabled = true;
> -			break;
> +/*
> + * Disabled by default due to https://gitlab.freedesktop.org/drm/amd/-/issues/3344
> + *		case IP_VERSION(3, 1, 4):
> + *		case IP_VERSION(3, 1, 5):
> + *		case IP_VERSION(3, 1, 6):
> + *		case IP_VERSION(3, 2, 0):
> + *		case IP_VERSION(3, 2, 1):
> + *		case IP_VERSION(3, 5, 0):
> + *		case IP_VERSION(3, 5, 1):
> + *			replay_feature_enabled = true;
> + *			break;
> + */
>  		default:
>  			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
>  			break;

