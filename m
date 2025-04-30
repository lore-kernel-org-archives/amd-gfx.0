Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191FBC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 13:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DA010E2E6;
	Wed, 30 Apr 2025 13:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7GF+TDe";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B079110E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 13:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXJQ5Xyw07yhbsSvZQ+RmLpokNK62/QfBXHXEB7j1/wF95MJh89xtwjQzwSXYPvJgUmkKg+5VL9xn3QDTrBZ6ptw0x16lNUxVMWvUHwhi9JShp/NXuG15u+P2GniNZ60hcve08kfXqFIi5Ae3HpZIUdLmCl8YwNxkacC+DoZQXnEPQhtl4ojUkPXYuOS9cZHlCLKc0cEEGtFdNoFOWik+2LktupzP+6Zb4Fg94NWAZ1G9j8E5Oe5ybw7XHl4yj7KJLYIUrMQzwk6RHuuWCNE+yh8PaPcmXu0A/s1iMTFeRkNWWvARWNqxR18CjPoQes/ViEzOYcr5WpaOZdMklvdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6Rokjj6x6gt+GvepjPGewbq36h73oKRk3wqxQb1kBg=;
 b=gCC7HCiO7NQ+bLI8j8EZ3w9EYKIslgu9nI+qXztWrOPQGIhA8S2BwayKboUeIyvtLu1DfJ1Nqj/y9ITkjV+vdCxreSZQrZxTiD+79um9uOq4WJiId8JBVjMO/Hy9IFAmWYdd8kh0TAqY5P+l7gZZge092CWKTVa76odqmetYNGVH41P0054bT2oyniCODXqfKZzxqE1n/GCTEz8yYwQctX/FJoYvVQH3KE+e/aznjKfLoa7J+pUNZIT/wg75RsM4ZYP52CsmD/fXmAfPKSdM9ITMJbAkMiS4IBTIxpLiIumtoDi8UEEvH97U1hvM0Nq4KAh8ssrNYkfsAVOaOHCZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6Rokjj6x6gt+GvepjPGewbq36h73oKRk3wqxQb1kBg=;
 b=b7GF+TDebHtPrmkAOjZkhudoQ9y+xIk8ETuR36dFxrSyPlobSypRz4TVgFMUO6I8fT270QvusN5KOhUkRpn/svi9VlFub2KqO9KD65L1gG3C+ulbzFKslBhZ45fZU0Y+3dlStGKZEaGRwFSAotdn5tSm6fqB+klEm+mo13tInfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:00:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 13:00:04 +0000
Message-ID: <f662eee4-2ee3-4fd1-85d4-2f104937847d@amd.com>
Date: Wed, 30 Apr 2025 15:00:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Emily Deng <Emily.Deng@amd.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
 <20250430101638.649274-4-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430101638.649274-4-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0025267a-681c-4f69-b34c-08dd87e6ecd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1BHdVQ5d3gwMnpZNm5ndU1XMnppaXI0eWJBbUNGUTA4L1Iwdm9JYXpNcWhx?=
 =?utf-8?B?ZDgzV0lEekFKanY2UUxjSW9WMU8vaGZHUE5Qbi9EZ01zcUdQai9UNXYvMlE2?=
 =?utf-8?B?aGF3bzkwTTlrcGM3a1ArYmorMVFoeENodUhNaWhTNkhlWDY0Tnd2dndkVG9E?=
 =?utf-8?B?KzJZVHRqNHZOdHhjbkI2UVdyL2pBMk5RcW9IVnVrTU8zZmFhUnZKZ25ydlU0?=
 =?utf-8?B?YTcwMU9pWEk0dU50SDdRT0xzcGRtaTNmSG44eTVXTGdZUUJTaUJ4ekZXQW9y?=
 =?utf-8?B?M1dzTXNkMGZSOFMwaFJaangrMldFT2xyd2RIZlRhWXR5cnN5R2RPTmVFUkpJ?=
 =?utf-8?B?UWhwWkN6VWdUSFBibEg2bkNYcU11U2piQlZZenBrWUYra2RoU0hHbzdXR0JN?=
 =?utf-8?B?MkxvTWxTYUQrUzFlTGcvTGU5ZGJTVHJOdXhyUWJGOUFiWmJFWWpKOXNIWHVF?=
 =?utf-8?B?bFdRa3h2YjdudDB5NkV0aE5jcDJTMGlSNUtHNWRmaVBGSmNNNG1TTFkwb1JX?=
 =?utf-8?B?eHZzMEtaaFJEUWpsVTdWWmJTdHV4WnZQM1dmUTNLYWFNa0FUV3VlWGl4MGxC?=
 =?utf-8?B?aXVsU0FaR2o2UVRGbGJDQlFiZ3FINW5uQ3VwUm9pcTc1d0h1d0psVzc0MVUz?=
 =?utf-8?B?SThwQjBUT1g2djNBbjBpVFJ0elR3OTMycGZxR3R3eDcrb2o0VXZraFdaU1N5?=
 =?utf-8?B?K1NGdWhDVG5BWHNPQWpybGlZZDF2amR0OG5XTnZrQXgrczFDcWV4eUhsaUw1?=
 =?utf-8?B?YzVKd1NLOG14ZXpDbmtzVUpad1NsT2FPZm1CZWM4WWhIVGNEcVFjVG5jUFJ5?=
 =?utf-8?B?dnVsRFkzZUFHWWgrNElnanU1U0VuRHpRQ3U3cXI2dmVXZk45eXNsR2s2YklM?=
 =?utf-8?B?TGlvclltOFptUVl0VmtjUWRJUGxqQWduN0JNV1dJUEJnK0UrcXhHWFNRaWNV?=
 =?utf-8?B?eTB3TnMzaUJheDhOTHk0aTVibkNmd1ViZ056QzdMMmZDaWFPRjRwVFlqMnpJ?=
 =?utf-8?B?ZEZBQzRpUUNNT3V2ZFJaOUNIOUxOdVNHaGk1TjY0SlArWjhLakczZm9scEFT?=
 =?utf-8?B?V1ozRjJSdm1XakdnTHlsa01za0xiVkFoa0lqS3RxTHV4VStoeFRCV25CQ0kw?=
 =?utf-8?B?aGVGdENiQ2hVTUV6a2lQWmpVanNEcDlxb3hzaUdva3NkUG0xckR0dVNicUE1?=
 =?utf-8?B?Q0lUNzhLZHBLK1NnaTVYUWUrN20rcjRreUp0bjRWcnlCZUY5Qm9RMGJsZW1D?=
 =?utf-8?B?RHpTTkVCa1czVUx4eXJIdlRvcDN0VTh1ZERwQ0NPRVR4bUtEd2xCWDlOY2Yz?=
 =?utf-8?B?VGtUK3RFYkZkZGZnQU51ZXF1NW5HL2dwTkxIUG9aU3BKUFhRdmIrVHNTajho?=
 =?utf-8?B?TFhmc3VtSGQ4QXF1ZnRobFlhSHNDckNOcm5KcldGbG1CZzRDeVh2SzQyNU9l?=
 =?utf-8?B?R2s5QkdIclRXRU0rYUxzTlBmdEMyNlNUL1Q4bG50TmxuTUdSRWdXTlFNRitT?=
 =?utf-8?B?WVNBWmVaeENEZmlRVm9jclh3czk3OExESmZ4L05uU3puQ0ZXTkMyMGI2MWoy?=
 =?utf-8?B?dGRqb1FFR0xyL3UrK0xaQzlXb0p4bUJoclNQRkVNaFpRZUpVcm5tZ2JFYWFY?=
 =?utf-8?B?RjRHQUxFZXdXOVJCcC94c2JYb2g3L3kyNFFtSkJ6UVJhRXNvZXpRaDhuZCtC?=
 =?utf-8?B?OXc2SnVWU2hiMk1haENRK0EwV1BEdkpodGVEU1U1WnVXY0Y3TFlEV1NWVzF1?=
 =?utf-8?B?a05CbXIwVHRRcVBlSm8zalBkUCtLUzBUNG9XLzllejU2UHVmZUhrbm1xWnor?=
 =?utf-8?B?bFJSdkRlWWgyQnh3dTNLejFYQlhRaWZOUkFvMUVPM3VXYXlXSm95MVZFaHZJ?=
 =?utf-8?B?TFFrZUx6OERIaWk3NDd0QWFjcWxUQ2U5R0V0S0VGT0k4Y0lndDR2SVRCSVJk?=
 =?utf-8?Q?xiYRwNaMXN4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhaSVladjUyT0Mwc3NWdFVyU2RwODFNY3U1R1Baa0NHWk5rYlB2SVRGcVJC?=
 =?utf-8?B?a2ozL0pPUHpBU2FvZ2pUcGI3N0luNGYxY0s0RUlORmVhbHdRdk84bDJhUXMv?=
 =?utf-8?B?Tm5RQTlLZnFmUWZ2UGVJb1FpVUk1bUR0SjV6UnVzRnVFVVQxQ0lVOGlqOE1R?=
 =?utf-8?B?ek1aSHY3TUhvMnhocVpYbEFESndUbzB5THlZNElVSVdhQmpvMHQwL3JCQjRs?=
 =?utf-8?B?TkJFKy9iTmlNR3V0dERWZ1gveFFiUUpwcVdKelhlV3pzRHgxeWZjWmdUanlI?=
 =?utf-8?B?SlQwRFhMaytzd0RhVzFJN3h4ZkdCMGN5a2VZRG1TMldKckNxbGhCVVAzTndj?=
 =?utf-8?B?a1BQQTlaK2orbjBqa01lcWRrVWFiNHpNWUwvWEpQZktJOEw1WFRaRXdudFdG?=
 =?utf-8?B?bC9FbVdlbkhKczFTVzlIbHhHNW5jckNoeVV6ZEI5UlFMTVVoZDZiU0J5RDNC?=
 =?utf-8?B?MUc2aXBTeWx3VFZpUkhUVlM1WjJ0UnMrVXEweFZTcWcvTURLb2x0aXZwVVFX?=
 =?utf-8?B?NEVvemhvSE9BRVp6QlRPc2I5TmtoVWF3bU1EWHlUMHZqelEzWE8ra3FhbmhI?=
 =?utf-8?B?Q3FYbG0yOTdiLzZmeGJldEZDN0ovekt2ODR4TCtEYjlGdzg1QVYrQ3ViZEhG?=
 =?utf-8?B?MEk1VGozTi83b2w0TEJhYnRHaVZrWmQrTjBzZWJMZ2NOb0VoNVVGdjFVNEF3?=
 =?utf-8?B?d3VhSlNkdU1uVHlNWXNUdTRyT3pPeEhSMDV4aHpMazRmRUpBQ2sxUm5TaTZa?=
 =?utf-8?B?dU5JWUhWQXdGbkZQSWhZNFVQVmZRbmZkZzh6ODVoTEpqc2svNHIvUGxORmZp?=
 =?utf-8?B?UTg5Z3NsR2hIVVAwb1Z3ZG84dVozK2dIWWlIQlZPeE9SeE41M2FmL0pDQnhO?=
 =?utf-8?B?Q05IN2lkWTgwbWp4NHRndXJIcnZsVkI2cWFacGdtVVdLTU1PWmI4WGNHeThn?=
 =?utf-8?B?OTVVYjJtWStlZUhqdVgwdDNJaDByUkcrSk5rU0NIR25zQXRXWEFJM0l5aGhC?=
 =?utf-8?B?VnVYTVJWQ0RKM1Y1Z1o3aFZOY1ZJM1lWbVdvTi9XaG1sOVBLcjhCak9zZDU1?=
 =?utf-8?B?SkRlUVZ1UXlNOWdZZEt5b2tPU0lVVW5HMUN5SVYyQ0RNajF4TkNBUzk0cGQ3?=
 =?utf-8?B?YzZ3a1ZZeHB4N1FCSHpZOFJiZHNLWlpaZDIxT2lMMis5UzVNSXNrajh0c1hL?=
 =?utf-8?B?bUczUTA3WFNwQW9Sd2NLMnRhTm1mdDA1THFSRXVKeHFjTHZMckVSY1FXdzNo?=
 =?utf-8?B?dGVlQk5vRWNmWFRsMjE3S3hPYXB6QVNwYk1VZ2RZK1BKcEhpSHhyZWFiQ0U4?=
 =?utf-8?B?enl5MEllamVTV0plRVlFVmsrUDNFRzhBYXF3QmJlWkI2Q1d2YzNyWi9jNlhJ?=
 =?utf-8?B?MitXbzN0a2p5dDlqS2NYNElxa3VRc0ZUVzl2SzZxcEg4b0VyZHJFN2JmM21E?=
 =?utf-8?B?Y0t5VENIN2ZNRTFCNHZFd3drY3NPMGgwQ1lkcFY4TG4yakZvSExJekVmbWdL?=
 =?utf-8?B?ZXpKVmtuYzdoZGxRN2NpVmMxc1kxOWVSYnNxK3hHbkF3M3MvQk9KRThjcDlo?=
 =?utf-8?B?WTlHVHo3MGFkRHJzTXhPS0Z1RHkxSk1tVVZYTmNUd3hEZFNoaXU3bUw5bGFz?=
 =?utf-8?B?cHorK1RaRExmR1VuK2hyN2VNaXFvN0tKUEg2b1l0RnV6Si9KaTE1UHhsNDht?=
 =?utf-8?B?Q095ZTk3eWpUc1BUTlpPOWRiS2RkUlpkTjkreE5YRGYybzhSUjMzOHFqZUtr?=
 =?utf-8?B?TldLOTgxM3E5SjlXVndQb0IxajB5UmZnbk9iQ0VuaEcwYkxiL1htalZab3Fz?=
 =?utf-8?B?eFlLMktsb3RQTnhXMnZPbG14R0ZlUXlqdEZMejRvRlI0dW9WM1p5M01Lc0dS?=
 =?utf-8?B?aGZqeDYvR2NJR0Vsb0w0eFhueE5YVG5YRDl2QnpUem15NEdXOVdrVTNVa1Ar?=
 =?utf-8?B?UEREdENUNWlMZ3BMeUpTSWVucDdQKzFwVXhOMmxqbWhuY2Y1NWtqWEwrc3hl?=
 =?utf-8?B?cWlqb28vMEV1UW9lYUFPdXp2VW5zRS9Na3AwT1FlVDRDdlRkRXhPZnAva0hH?=
 =?utf-8?B?Z0psNHpyRDdQdTgvWW5qOGxCbUI5bk8rRDBwbWdIVkRIU1NiN2xOOFlJc2dE?=
 =?utf-8?Q?PpxFVZMoC3IXKMzPg3CSMgzRx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0025267a-681c-4f69-b34c-08dd87e6ecd5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:00:04.4903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqCYiWOMWP9BQD4ycH0TkGuSVfrf4RhZU9vBB1vYW9BdDx6Rx7bz99udQsnw4zX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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

On 4/30/25 12:16, Samuel Zhang wrote:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
> 
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 42 ++++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 16 ++++++---
>  4 files changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ef6eaddc2ccb..3b3f9843ef7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -38,6 +38,8 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> +static const u64 four_gb = 0x100000000ULL;
> +
>  /**
>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>   *
> @@ -250,15 +252,26 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  {
>  	u64 hive_vram_start = 0;
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
> -	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
> -	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> +
> +	if (adev->gmc.xgmi.connected_to_cpu) {
> +		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
> +		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> +		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
> +				mc->mc_vram_size >> 20, mc->vram_start,
> +				mc->vram_end, mc->real_vram_size >> 20);
> +	} else {
> +		/* reset vram_start to 0 to switch the returned GPU address of
> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
> +		 */
> +		mc->vram_start = 0;

You need to setup mc->vram_end here as well.

> +		hive_vram_end = ALIGN(hive_vram_end + 1, four_gb) - 1;

Don't touch hive_vram_end here. When this isn't 4GiB aligned we have a problem with node_segment_size.

> +	}
> +
>  	mc->gart_start = hive_vram_end + 1;
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	mc->fb_start = hive_vram_start;
>  	mc->fb_end = hive_vram_end;
> -	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
> -			mc->mc_vram_size >> 20, mc->vram_start,
> -			mc->vram_end, mc->real_vram_size >> 20);

Please keep that print here 

> +
>  	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>  			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
>  }
> @@ -277,7 +290,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  			      enum amdgpu_gart_placement gart_placement)
>  {
> -	const uint64_t four_gb = 0x100000000ULL;
>  	u64 size_af, size_bf;
>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
> @@ -678,8 +690,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  				     &job);
>  	if (r)
>  		goto error_alloc;
> -
> -	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
> +	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?: adev->gart.bo);


Move that change into a separate patch.

>  	job->vm_needs_flush = true;
>  	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>  	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> @@ -1057,6 +1068,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	u64 vram_addr = adev->vm_manager.vram_base_offset -
>  		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>  	u64 vram_end = vram_addr + vram_size;
> +	u64 vram_last = vram_end, vram_pa;
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>  	int idx;
>  
> @@ -1069,11 +1081,21 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	if (!adev->gmc.xgmi.connected_to_cpu) {
> +		/* always start from current device so that the GART address can keep
> +		 * consistent when hibernate-resume with different GPUs.
> +		 */
> +		vram_addr = adev->vm_manager.vram_base_offset;
> +		vram_end = vram_addr + vram_size;
> +	}
> +
>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> -	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
> -		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
> +	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size) {
> +		vram_pa = (vram_addr >= vram_last) ? (vram_addr - vram_size) : vram_addr;
> +		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_pa, flags);
> +	}

Hui? That doesn't seem to make any sense.

>  
>  	/* The n+1'th PDE0 entry points to a huge
>  	 * PTB who has more than 512 entries each
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 291d96168a57..778c7506bb2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -308,6 +308,7 @@ struct amdgpu_gmc {
>  	struct amdgpu_bo		*pdb0_bo;
>  	/* CPU kmapped address of pdb0*/
>  	void				*ptr_pdb0;
> +	bool enable_pdb0;
>  
>  	/* MALL size */
>  	u64 mall_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..5ebb92ac9fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3c950c75dea1..42c38848763b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1682,6 +1682,11 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>  		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>  	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>  
> +	adev->gmc.enable_pdb0 = adev->gmc.xgmi.connected_to_cpu;
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +	    adev->gmc.enable_pdb0 = amdgpu_sriov_vf(adev);
>  	return 0;
>  }
>  
> @@ -1730,7 +1735,10 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> -		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
> +		if (adev->gmc.enable_pdb0)
> +			amdgpu_gmc_sysvm_location(adev, mc);
> +		else
> +			amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);

That is nonsense. You need to adjust the if above and not here.

The amdgpu_gmc_vram_location() function should never be called when PDB0 is in use.

Regards,
Christian.

>  		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
>  			amdgpu_gmc_agp_location(adev, mc);
>  	}
> @@ -1841,7 +1849,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (adev->gmc.enable_pdb0) {
>  		adev->gmc.vmid0_page_table_depth = 1;
>  		adev->gmc.vmid0_page_table_block_size = 12;
>  	} else {
> @@ -1867,7 +1875,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (adev->gmc.enable_pdb0)
>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2372,7 +2380,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (adev->gmc.enable_pdb0)
>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {

