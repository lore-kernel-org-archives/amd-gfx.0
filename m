Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A40DC61CE8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 11:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B499D10E2BD;
	Fri,  6 Jun 2025 11:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tIU+jdP4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B80810E2BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 11:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqxgrfBg8T3Yai1i4eQgh0WP65/0BNOXG0BVIeEMMWC4T7AZVPXaHjJgy4D9ep/XiyuPIIq1IbypJRJI2vqgJJJGGr7oE0vfO0jHFU0otJDkAwzOUf9sFqamCEefeBdVaYijLnuuGZZiKCvsybqhp08lVOnkDzVQaRrTeAtkHiSCsKtMVPjf4Uu+UEcmP0KEDbHRpYTyZw07D6Z/O00r5cMt2dNK37Dw5+bIqYnZcDJVg375hpcevZQf26lN/4Zx67hIMsQpHmEJD4pC36+AcRZ/xYNEZ2UKVCe51lk3/eEQ0Ia28qurbpchg1vTEcozpsHniedDC9cAa8a0Le9eiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Om4XPe5H1slidEIvv6Ucgydj4SV3XQLUtKO11fD6s8=;
 b=eThRtUBQcSJUm7RkHDjJKvBeTZHKtUa/ITmfD4St2NIpf14DFfVsLVNx9cIu2hWVsQu04RjhFO0kTMmAw+gZcQ9Y3GnQr/R0BpUQa7OZh0LQyVlXdbZCU06WkRSjBcWwT/xOxCA+NOlf07DWsv4kZToWnOn35PnjqWi9ZuuDc97VAJ/1p6C6ya2cJQVdUi5y+Tc09cpYoePuxKHGm8+fQIgUXZIkOdiz010+jgcQKSRyfoK8tNsL5MM7uncdeZ5gIivL7cwA3CGYwDBxpA1KkSKnEmWhLAf4Z+zP0lS8UNpmE7BzSCyp8+Iy7taSKB3dRuAtSFLmWF9fQmvHimS3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Om4XPe5H1slidEIvv6Ucgydj4SV3XQLUtKO11fD6s8=;
 b=tIU+jdP4eDxZjdP2O2/H5bsYEqPZXZqYDEr8LP0r6de6Jm3YP/U72SKTME+KDZHA/tF1UjO+UO6Yp7jRw2LQWsmjhE78+7pNku/aKOFmm9CQSVF5lVcvZsxEU+7nlGsOar5KYx4Ud+HgVYaVJU5ZztCuMp6cG9O7vH2x2LH46EU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 11:39:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 6 Jun 2025
 11:39:44 +0000
Message-ID: <ac6a8a10-fbee-445b-8031-8b5c42f02695@amd.com>
Date: Fri, 6 Jun 2025 13:39:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/29] drm/amdgpu: switch job hw_fence to amdgpu_fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-6-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250606064354.5858-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:23a::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 98643bbe-42f8-448d-204d-08dda4eed51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTNLSlBDYXg2aG1rTE13dDRRRUh4TzRzNktJTmUyclVlN2NPMXU3WVZWcUs1?=
 =?utf-8?B?V0FHTW5jM1d1b2ZSbm9hSnJCQkRmclRFRDJrYkJHR2tnWkYybGlRTXJtL3Ry?=
 =?utf-8?B?UUI0ekZXT2hNeHFsd1BYYmN6VEV5QkhRSHVOK2krQWQ0bTluZXVJdWY1OGtD?=
 =?utf-8?B?bmpWYStSRWhFU2VDbWxPL2U1VHo1VEdpQ3E0a0M2Qlh2SllVMTZOYmJaM0Ir?=
 =?utf-8?B?NUtzNXV6U0VPN1QyL2RPVXlObGx1RTkyTkY5emw2NmNHOXkwazJZWXE0WHVD?=
 =?utf-8?B?ZFBKN1pQckNlTmdQb3l6R2E5ejBBWHhQYzU4SG5US3pkRVRTTEs0bm5jOUxr?=
 =?utf-8?B?aURZT2YvelRlMlZwZW9jMHBUOUJEZUhIME95MFUyOW51NEVCbEw4ZnRSVkNk?=
 =?utf-8?B?MHJKTVFxRi9qV0lNODNlMHN3aHdkQVZzLzcxSnNGeDRZckJzL2dTZVNmSjFQ?=
 =?utf-8?B?Skx3V0ZucXF1REt4NEVhenBaL2dQc1lpZHpyZjhGQlVEYkxNdFVIZHVoRUp3?=
 =?utf-8?B?MkRTNnliZDQySlFIK2xjdWsyVDhYVUZSQmZNeVBjVyttdjFPQm5pVFp2UTNl?=
 =?utf-8?B?eTdFSVpWVlQ5UGtOUk1TZHhQdmJOR0VFRzhtTXZtaXM0M0pURUtvTit0T0do?=
 =?utf-8?B?Rk9SWVpMWHg5dk9oazdjTHZyZTYvbXRuWEthSmFwbW8vdVFBVjJNL0Zoekd0?=
 =?utf-8?B?OWV4SEhFSlJRazkyWUlJaFFWa2RUa2Y4S3VteHVJRFlCc3NQTngrakpQaU5p?=
 =?utf-8?B?R1BrY01zcng1ZitwbE9IRjF1NTBjUXVkbUgwa2dUQmJqSU14UkpQbHI2YUd2?=
 =?utf-8?B?bDUzK1VEazBUMjNRWkRubjVmd3lnNXVQZkp6MTdVaXRuUDRUczhqSjlhMG5T?=
 =?utf-8?B?L21MSDVLTjk5TzZVVXBCVWpobDJPU1F0eDZHdUZWRktTQ2YreDVmaE5WNmJT?=
 =?utf-8?B?T09yVy84cHlpNlBNbEFhN0RyU1FVTzViSW1FaUV0ZzJaR2p0TEY3NTFrY0hE?=
 =?utf-8?B?TG9YbEoyQ1F6WENPeUJ4U2pRZG5JMFMzZlVhZEcxTnprTGEvaDhGQkM1ZE1N?=
 =?utf-8?B?Slo2ZjBEc3JkTks4aHlJTGdVYTRYRThuV3VnVlZoM29UMXJZWUo0dEZXenU0?=
 =?utf-8?B?VHh1cDZidC91Rmk2b3JVM1kzdk1EV2lqRXYrOVBKRTNzY2NVM1ZDN2hVUHdS?=
 =?utf-8?B?V2tVbjl0NU93cVViU2NsWm1FMkJkcEszUDNSK1FrZ2s4dFZ1ZTJHaEFlY1BF?=
 =?utf-8?B?RjZwNzBvRHAwU0NoeVduRGpLSHlhcW5LL1JXd1VzbjFlSlozYmsyVzRvc1VM?=
 =?utf-8?B?WHp2VUlMNk9WamJNUkVRTUJVaVQ2NVJncm40MXY4d2UwWFJLTDRtTkp2dXYv?=
 =?utf-8?B?Zkp0Zkw0UG51MnM2SmlHaktsOWN5OUl4MlRUQmZ6dUR4K25FK2Y4NlMvUCtG?=
 =?utf-8?B?RmtJUFRteHV4Szl4YVMxblVTcVQ1R0prclNzakxGQzF2MnBocjJzZWdoa3Zo?=
 =?utf-8?B?cEVnZzM2UHlEa0FTRGwwVWpTRDdOZEdtc1ZlTmpMc09lT2ZDUTBSaTN3ZzJu?=
 =?utf-8?B?eWg0TXdjTVJxN2ZGM0V4M0F6a3EzY1hVUEsrQTIwR1VjUWNYVkVmdERtNUpB?=
 =?utf-8?B?bjhzRmZnVTR6RkZxMzVWVktzYWVuUnFRazZYeDZ5TDZpNUdSaWJmc2dPNDlB?=
 =?utf-8?B?TkgvT2xzSEZGUDhkRnlhSng3SGdYS3hHK0tSVjd4MERiL002ZklERXVjME9P?=
 =?utf-8?B?cktyM2crcWFESXJKYkhKVFd0U0RJNmJyWHN5T2o0WDJTWFQwdVU1YnFTYmxF?=
 =?utf-8?B?ZU1tem5PWURLTURsSjhVSFlmT0lZalQ5dFBPVmlVVGxESkVKOVRDS3VrUVZC?=
 =?utf-8?B?TVJXUnhucDZnV3JnS1U5QUJoak9TaXVGUk1COGtyOVUwZ0RzK1U0L1Rtanpi?=
 =?utf-8?Q?tRiz4GcWXsU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlGMm10VCtRQzczVW9xTk9vVnltekZyZ1NZUEJRMTREZDkybTdQR2ExZmVY?=
 =?utf-8?B?N1pOMkI2M3BIN3RoeHc5OW5Jd2l1RFlqZjhrL095a2VoeHM2czI3dE1teDZY?=
 =?utf-8?B?VFczZnJlVzd3V3RMTVlFK0p0SnBXN2NwTDNESmUwdmRHL21neWRmWXFXZ1FO?=
 =?utf-8?B?dHJ6Y0M5RHZkL252c1NpSzh4RFVZSS9TaHdFTU4xM2FpcXhlM2dJdm9mWmFP?=
 =?utf-8?B?aXFUSXdDMnJaN29uS2IvZE9XaEd0bG5LanUzQm12dldDNGNiMjhNekJEMkhF?=
 =?utf-8?B?WnQ5Y1V2RVd5RXFJQ0FGZkFXZXVEY093RHNJcGhKUXpscUpHWllwY2p6dU8w?=
 =?utf-8?B?aGg3YzkvUXExRUUxcy9KRCtWem1kMVdoTU9TZ2ptWDhMSStWZ2VYSTJiZzdm?=
 =?utf-8?B?NUI1ejd3aXlSNU9WVmsrTEMzNHhUeXZqMFl1cERrbHB3aWxjd08xL1pXcmd6?=
 =?utf-8?B?bWdGeHBWQUxSa1JoRnBUQ3ltd0t5SC94R051Q1FDbkF5dnZUQ3c1S285N1VS?=
 =?utf-8?B?YkExUzRPWmpYMlhCRU8wSGNGeUVDdUpnSXp0NGJqaEJSU0d5ZlZORlBLS1Qr?=
 =?utf-8?B?dWUyYktKalQ5STJxM2ZLK1o2TVNnTFh5QzBHVERHM0NBeVp1ZHV5TUZIWm9Y?=
 =?utf-8?B?cjJ0aGtMclhaWldtVVpzRkk3bDliOXNLNHlqbjBMMnVML0dtdU9XUVBObW1V?=
 =?utf-8?B?ZlJRaGpyMGFoODQvUG85bk12NmNtbXMwYWVXWnBaZFpCZlF3QUN2RUpPdjdv?=
 =?utf-8?B?emhPMTVrS09VRk9OWDlCcDFldkVIMmxIWEFMUEVUejZHUzBZdTdVRkFaaHFL?=
 =?utf-8?B?SnZ6NVYvKzZiK0pmbVZSbmgvMzBGTXhvTWlKMjlabjlkNVdiT2FuaEVpbXlW?=
 =?utf-8?B?ZEtzTEwvNFI4WGtBanJ4ejBqbXBpcG8xOEM1TkJ5S0pVMVdsMUpKTUt2ZC9B?=
 =?utf-8?B?d2x2cUliL3l3N0JtNjhoVks5b0ZaNzhmVWkxbHpsaVhpZWFVMnlCUmxlWHhJ?=
 =?utf-8?B?QU9NSWRpalZlbUVGNTQ0MWpSbkNJMmZJd21nT2x3ZzRUYzJVOHJIUFVKMUY2?=
 =?utf-8?B?UkpMMGZteXdtZVhZU0lJMW1TMjM1MmlNMENIc1Jyc0lLVC94OS81OFZGcXlR?=
 =?utf-8?B?NkZ5eTBZK0VnamtFU0xFRHVJUm9CbTdvREJTNGRnQ2hFWGFMRDU3V0JhWCtT?=
 =?utf-8?B?NGs2ZERhcEJSSmVuZG5IQWt0MEV4azlwYkNxWEdVNlEzWC9JTHFGQXBXOFNj?=
 =?utf-8?B?bFRIQTdUaEVMQUF4a0VpUHNCYjBuUWE3M2JNVkdMNS9xSE8rQ205UmR5RENW?=
 =?utf-8?B?SkF5Wlk5b1FtWGx3akdyYlVWKzV4MlBPRkZtbEFDQjArUk5BbmE5N2J0QXpj?=
 =?utf-8?B?NGFVUkdmODUyU080bUo2OCtNVS9YekhSRjdoVzhiakVXOGtGajhJdFQ3R3hJ?=
 =?utf-8?B?dThFQTRuc0VPQVgzYVZ4ckF3Um9rbVFEMjMxaFV4U2lnc1VyQ3hHYUQ2RmdR?=
 =?utf-8?B?L2R2a2g1YnNCQjFRNEVZTzdCUzVza2dMZGVFMDhpaDJqWUU1U1dqbE5CVHBv?=
 =?utf-8?B?SjBMeW4rdlg3bGc1ZUFDWU95Vk41ZFlQVzZQWGl0QThFM1lsK0J4cUJwbWtL?=
 =?utf-8?B?OXMwNitpWGF5Q1pNV0lkNTRJMFo5eUFxcUhVaTA4Z3lPR0Z1Mis2cjZxeXZK?=
 =?utf-8?B?TG5TTUNLWFYyM2t0dDJQbWg1NG5nS2tPdFNSRHpsVExReHBNMGl1R2xySnFj?=
 =?utf-8?B?OW1CUCtpMjVMOEN5a1J1SlJXY0JKU3JkUWVjQkNZa2UwQXNuSnlNVHRTZFBD?=
 =?utf-8?B?NUk1S1prdVQwSi9JaTVzN1kwMGFYLzdVQmgrUlN3UXgzYm1Ya2FMUk5Td01z?=
 =?utf-8?B?TkVMUUF2RlpHbURjOVIyVGNMczVHS2VhS3U5TUtWbW5CUEJtbW9jMHVwVjFX?=
 =?utf-8?B?MXBHUGxuZFljaXc5T3MzWXZRQnlxc1VyYmR0dFc1a3MyMzF5V3dnNllQWmR2?=
 =?utf-8?B?WUFac05kQW5oWFNTRDZ0N0FrVnJxcml6TE5aUjRldFcvY2FPOHo3bUlheXBx?=
 =?utf-8?B?aHh3NFp5K1c1dXJYdG9ldGlVcUlWenNZQnhIbFJhd2ZmSlZWQ2FPbGN0bys1?=
 =?utf-8?Q?rV6LBGPGdBWreI/H2iwegtuhv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98643bbe-42f8-448d-204d-08dda4eed51f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:39:44.2345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDa/pLRkcnSvyMAZpIZZUYENh8TZv7fNf6kHsb0Q/Md3cuOtH4JDuwjBvWLYxgCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

On 6/6/25 08:43, Alex Deucher wrote:
> Use the amdgpu fence container so we can store additional
> data in the fence.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
>  6 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 8e626f50b362e..f81608330a3d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>  			continue;
>  		}
>  		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence) == fence)
> +		if (preempted && (&job->hw_fence.base) == fence)
>  			/* mark the job as preempted */
>  			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ea565651f7459..8298e95e4543e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6375,7 +6375,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	 *
>  	 * job->base holds a reference to parent fence
>  	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>  		job_signaled = true;
>  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>  		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf6..569e0e5373927 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -41,22 +41,6 @@
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
>  
> -/*
> - * Fences mark an event in the GPUs pipeline and are used
> - * for GPU/CPU synchronization.  When the fence is written,
> - * it is expected that all buffers associated with that fence
> - * are no longer in use by the associated ring on the GPU and
> - * that the relevant GPU caches have been flushed.
> - */
> -
> -struct amdgpu_fence {
> -	struct dma_fence base;
> -
> -	/* RB, DMA, etc. */
> -	struct amdgpu_ring		*ring;
> -	ktime_t				start_timestamp;
> -};
> -

Oh, that handling here is completely broken.

The MCBP muxer overwrites fields in the job because of this ^^.

I think that patch needs to be a bug fix we even backport.

Regards,
CFhristian.

>  static struct kmem_cache *amdgpu_fence_slab;
>  
>  int amdgpu_fence_slab_init(void)
> @@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>  		if (am_fence == NULL)
>  			return -ENOMEM;
> -		fence = &am_fence->base;
> -		am_fence->ring = ring;
>  	} else {
>  		/* take use of job-embedded fence */
> -		fence = &job->hw_fence;
> +		am_fence = &job->hw_fence;
>  	}
> +	fence = &am_fence->base;
> +	am_fence->ring = ring;
>  
>  	seq = ++ring->fence_drv.sync_seq;
>  	if (job && job->job_run_counter) {
> @@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>  			 * it right here or we won't be able to track them in fence_drv
>  			 * and they will remain unsignaled during sa_bo free.
>  			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence);
> +			job = container_of(old, struct amdgpu_job, hw_fence.base);
>  			if (!job->base.s_fence && !dma_fence_is_signaled(old))
>  				dma_fence_signal(old);
>  			RCU_INIT_POINTER(*ptr, NULL);
> @@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>  
>  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>  {
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>  
>  	return (const char *)to_amdgpu_ring(job->base.sched)->name;
>  }
> @@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   */
>  static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>  {
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>  
>  	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>  		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> @@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rcu)
>  	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>  
>  	/* free job if fence has a parent job */
> -	kfree(container_of(f, struct amdgpu_job, hw_fence));
> +	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index acb21fc8b3ce5..ddb9d3269357c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  	/* Check if any fences where initialized */
>  	if (job->base.s_fence && job->base.s_fence->finished.ops)
>  		f = &job->base.s_fence->finished;
> -	else if (job->hw_fence.ops)
> -		f = &job->hw_fence;
> +	else if (job->hw_fence.base.ops)
> +		f = &job->hw_fence.base;
>  	else
>  		f = NULL;
>  
> @@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  	amdgpu_sync_free(&job->explicit_sync);
>  
>  	/* only put the hw fence if has embedded fence */
> -	if (!job->hw_fence.ops)
> +	if (!job->hw_fence.base.ops)
>  		kfree(job);
>  	else
> -		dma_fence_put(&job->hw_fence);
> +		dma_fence_put(&job->hw_fence.base);
>  }
>  
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> -	if (!job->hw_fence.ops)
> +	if (!job->hw_fence.base.ops)
>  		kfree(job);
>  	else
> -		dma_fence_put(&job->hw_fence);
> +		dma_fence_put(&job->hw_fence.base);
>  }
>  
>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index f2c049129661f..931fed8892cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,7 @@ struct amdgpu_job {
>  	struct drm_sched_job    base;
>  	struct amdgpu_vm	*vm;
>  	struct amdgpu_sync	explicit_sync;
> -	struct dma_fence	hw_fence;
> +	struct amdgpu_fence	hw_fence;
>  	struct dma_fence	*gang_submit;
>  	uint32_t		preamble_status;
>  	uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b95b471107692..e1f25218943a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
>  	struct dma_fence		**fences;
>  };
>  
> +/*
> + * Fences mark an event in the GPUs pipeline and are used
> + * for GPU/CPU synchronization.  When the fence is written,
> + * it is expected that all buffers associated with that fence
> + * are no longer in use by the associated ring on the GPU and
> + * that the relevant GPU caches have been flushed.
> + */
> +
> +struct amdgpu_fence {
> +	struct dma_fence base;
> +
> +	/* RB, DMA, etc. */
> +	struct amdgpu_ring		*ring;
> +	ktime_t				start_timestamp;
> +};
> +
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);

