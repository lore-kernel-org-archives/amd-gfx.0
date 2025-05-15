Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2A6C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 08:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897A610E7C7;
	Thu, 15 May 2025 08:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TVlTfwL5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5156510E7C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 08:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR6SXb1HZq3KGRoTcQhLoMtJE8i9bIRVafTO/nqW7brjyqUmpJ310dpZGBxSfadY/jfHKsBwKh1v89P6/lhCjYkW8GSEaEmwbo7ba7/LHsCnvBF0b/mtxtHOitbctqSoTKz3Es4NDzE2B+30JcnZuoUnmQ3J3t6MG5T7+2Rljo0kPy/3GIyXWM7cT9o6YlxJ4W9DoeeMzLAVEVlWabLlf2Bf2YbjJo6jTSXJ/DUlubR4k0AqNbolqkP8y4OQBUYxmSrVe5CEE5xp1I78EUwUde34lZErcxqlgFwKO3wobr8BjNXgZYKCWhvSN+bThu65XiMRQE1YtsYj4oPGbdCLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajeWrZAPR0Z/Jsi/RU8+ll7EPpGeMb3wtl8d4LxIldc=;
 b=KdBu74a1O4sBNijjFxg3ppRUlBpiyVzTVKJ/zyMHYy76qbzxg0UmVD8wyF3GrfS0Jj2XkqF0epBSMzXo+l4gTRSdCHbGQKKKPviovJL4cA8SYLbfSJC7+VndbwIyPHM1WawOEo3l052s7KJf1tr65AG7A/QGQuUB/sdZpDyn6DXFiI2iDJwRRj2PyIALMwR+JykFMc2Phfrqhi1c4/lK90LdbjPxiX+jjW+aMSDit5L16tuU9bckVMa1eOQ7uObJxKM6c9tnWPAHm+lcvcd4VIWhUfdNlbR6Z0Av6Drx0NDSJPGz9FyK6/v6Cst/bJxtxojhXIYLgQ8SjqGCeDlxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajeWrZAPR0Z/Jsi/RU8+ll7EPpGeMb3wtl8d4LxIldc=;
 b=TVlTfwL59upLClbDGOueONbKKc+inwPF3Yr/n2xGw9ChbQuBuE7a4ScWSJ+/rHAwes2RP+Gkc7Ka0lhSEJeaZP1SNUUgxgKDeKeNlogbhCC7zAUA6nh4xU/fQOrug24jPd0EyU101q5gIiAsUu1h198Kylwi8bLDFY4JD8P6UhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 08:58:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 08:58:49 +0000
Message-ID: <bbeaea25-500e-4105-9134-862b003352c7@amd.com>
Date: Thu, 15 May 2025 10:58:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix eviction fence worker race during fd close
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250515070751.497828-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250515070751.497828-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0378.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 343cfba9-29f9-4e81-d2ea-08dd938eb554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU1pR1FtZlBxWElsSzFNMGR4UHlJRnVEUFhuSVlCeTk2dFYwWTB5UlVmck5O?=
 =?utf-8?B?aVN4dXorMTZjMTlEY3VLOUVIVGZLQzNzeUM4bDhRYVpFYlpKcmovY0o3aDV1?=
 =?utf-8?B?MHl4WHBDa0xOVmhKRnRRNVBtUjhNVzBnb3A3VThMR05ZMkppTXlEalJZRHIy?=
 =?utf-8?B?NUFiSm8xZWt1eWlLVHhtYmJEYTZUSlVRNEZqWnYyNEpibEh2M3dUcHBFWkQ3?=
 =?utf-8?B?WWp1Yy9Dc2V0anhMNFZmMkc5L1dzM28xc3JBR0RVWEhPdlRBVC8zZFZ0a2xy?=
 =?utf-8?B?Uzk5aWdXOGtFRXBoRlU4U2pRR0dwKzFMNUhQQU5xUDMzbkVCYlNQOHcvaS9h?=
 =?utf-8?B?TzBMQTJNbUhldzhrOXNNekFNdmZ0dXdHNXoyNEdVUHFISmFYNXI2NkN0THB5?=
 =?utf-8?B?QVpiM2dwV1h4bzVTZ3NpTTlZN1RFeWVRd3hZSVk0WEFGQ2pJeXM2U1NrZ2Qy?=
 =?utf-8?B?cU0vNStQa2tVeE5uRVIzdWxqSUZKMGJzQmxYSGsvWjQ2WW1HK0NDQnV3am9D?=
 =?utf-8?B?U0J5SytTVStDK3hQZlVFRTgxQU1vb3Z3Ky9ZWFFqRkpQckVlckVyVXJrT0pZ?=
 =?utf-8?B?L3pjMWpicXFrMUc5a0p2YUtJN0t1VEhpS2tSUytEVjJDNzFBM2NTMTFoTGZz?=
 =?utf-8?B?Yy9aYkk4bWNuaTV1eWFYcDZoVEVXcGNzQmhBNnpFbWJHVytZbXlMQ0VMaGZo?=
 =?utf-8?B?Z2xQL2RBUHBvNzN2YXRETTk3cTBsMUVvTWhtSCtkQmI0WTlMTktESTBwMGZp?=
 =?utf-8?B?K0FaWGNoTWgvTFI2aXh4YnV0SjVsNzAwaGJoVElwRlF5UHV4YzVZaVZmVEJK?=
 =?utf-8?B?YWRCcVhpbHNQT2FXU3ZGUVpvSE4xVWF4S0RJQlN4ZEZoV3BvZUtoTUhQTGda?=
 =?utf-8?B?ekZHdzFXOWZvRUVUYlR4ZjcxZjY2OFpNdjhseG9TM2M1S2J6clk0OUVGQk1t?=
 =?utf-8?B?ejRZRyt3Z3dqczRhRlZNL2IwR0lqRE50YXJwM3hBdkVzdmkzb2c5RC9zK20w?=
 =?utf-8?B?NUNtV2dyMEwySGRrMW9wcDlNZFM0L1FGU3B3Nm9WZ2grcCtTZW9KaFN0eXlK?=
 =?utf-8?B?WVc2TExjaW82UDlXdlI4dU4xSVF5emcwZWxNeW4zMVM2MzFXLytpTlVDSkNn?=
 =?utf-8?B?c0I1aTVjaTlhODd3YmxWZFRpbStkYkxDaDhuZSt1dEsyTkxIVXFLMk91alk2?=
 =?utf-8?B?c0d6Uk9HV2lmckZ3K1hIZksvREFyRTg3YnB3Z09CMlFLZDh6bjB6L25rY293?=
 =?utf-8?B?Wjc2WjAwaVFDUGZ5Tkg0VVRVTlpLZnQvbzlUT0NsMEczaVlxNGxsTE5UY1RP?=
 =?utf-8?B?dXVMYWVZV016WHBFWEI3QUorQUh1NGdFUkduM2l2VmFIQzZNSVlUQlQyaHZl?=
 =?utf-8?B?S09kdllqWjJZc1Y1SHdnOHlERitJSG4xalg2UXNVNTQvbE5RSDVqYktGdmNw?=
 =?utf-8?B?NUM2T01rcklSODgycmRaM3BRcjNXbVdsSENRbW1NcHZIRjNneFFUQndtV0lu?=
 =?utf-8?B?bFRoY2g2dFBMRjB2dy8wL2haa2lDSHorUGR2R2ZwYTFSc0hYV05WK1ZObFNY?=
 =?utf-8?B?Rmh4cFo3Y1pZWWd4YWh2VmY5ZC9NTEZFbVRaYStYWnZjTlF6dU1lOEovRTlu?=
 =?utf-8?B?Nlg2cWxaMjhTVWc3R0pIdXIvdDJOMkw4VVlwbnQ3RElhc0loQlJ4K3hVeXhQ?=
 =?utf-8?B?TmEycnpINVNNbXVmdWhZWmF6ZDBhQnlSd2Z0c3RqYnlqUDZ5VVRMbU9FczUw?=
 =?utf-8?B?Nlo4c2gzUHZsVk0xNU02T0E4M2V0WHZOamswd09VZ295THFYcHk3bHorWTJa?=
 =?utf-8?B?VEIvVUZBcERxbW5weVhJRExSVXZyYUNFdmsxQWxqbXlhdzRRMitBVUYwNDZt?=
 =?utf-8?B?MEsxSUo0UU5vV1JkWVJrTzRneHczSGVranFPVmNlNDMwOEszVHhHbm5sRmk4?=
 =?utf-8?Q?/ztdPP21UpU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFKc0NNQitvZUxMRGxtV1pmUHRUWmtEZE5mZU5ZY1FNL1dmbitKb0Mrc3h6?=
 =?utf-8?B?WkJFaGVwMzVONlN2MzVLR09yL0dYMEoyRWUrTkRzNmtDTEFaNHJpMm5wSDBP?=
 =?utf-8?B?Q2grYVZDdEFuK2E0UHBMTFhmV1RDSjc2ZUoyTzY3Zm1LNUJ5K2lOb1czMmRt?=
 =?utf-8?B?NU1OMWdTSi9Ld1lYeEp6czNvREZNeWFNUzF5enY3OU91cHRIWjRlSUd3UUFN?=
 =?utf-8?B?VEd6NVlRRENRVlIyWEp6NzI0ZE1FVDBzaG1NenNHUFNiNVhsbTFOa2Rna0pZ?=
 =?utf-8?B?MmZVNzJhbE4reW4vaEZzYURBdE14QmZlQytZS2dGQ3BuUzBaSGFKQVpBTTFu?=
 =?utf-8?B?dnM0T3BQdDNSMWhPemJXNS9RNTlaWFBVcG1ZaEl1QlFGeURpUm56TGk4cEo4?=
 =?utf-8?B?bjVaV0ZWbERGcmlxNDFKNCtWSTArbS9XVFl4S0E0cndiQ3lpZlJDbVN2NmZH?=
 =?utf-8?B?c2NxMVZ5TDVJWkVYcnR1M0hVV0Z2WjJFdFpIS1JoTzlkZlBqZjFFV3BHckhK?=
 =?utf-8?B?cm1PcVoxanFCQ3dzblo2VGlwRUQvZzdaZXU3Q1MySGZuZXh0blNGdFNwaHJ5?=
 =?utf-8?B?WElScFA3Y1V3bUVVMVNFcFowTUNHRUR1bWtMeUdjOG5jQ2Ewc1piU1JNMkRm?=
 =?utf-8?B?QzZZaHozdjBNbktnZjJGUXRGUEF0dVhZSkczRkRSUGNxVlhLWFI3aVhPRml6?=
 =?utf-8?B?SEtOU08xM25tRGFTM29HSnFtV1ZEbG1jNGtBSEFyUEpmTG1EbkQ0NnUyTUpE?=
 =?utf-8?B?eHJ4bnlUOTNjNHFvcTVVNGdjR2RBYjJCa0JXbmV5aTBZT3AwQVhjZzZpbFVI?=
 =?utf-8?B?aXYrZ29lczUzMlFaaWl6N2NlVXcwdHNJQVM4Z0NSUTMvRFNTcEFTYkJxWmJB?=
 =?utf-8?B?Y3lhYWkxV1VNRHBTZDIxZmR1QW5NMllFZ0s5d2NySnhsWnVDd3J3Vm4vc0R6?=
 =?utf-8?B?LzB5NndoV1NKcHRQU0E1eXlCOXYxRlJrMVhTWmdpYTB4QzVINjBSNWFqUzl0?=
 =?utf-8?B?dU1mZlYxVWhRdDlRL2RIOStTdWwrckVEd01XSHdmTGdGME1XK2dvaHhZSjhO?=
 =?utf-8?B?SUl3VjhnNzYrdVI0SmJvMXI3cTN1U1I0MitadVc3Qnh6YkRla09QWEFwcmxh?=
 =?utf-8?B?UHRaWHlWbkpNR28wYXBxZEdTNmt3SENqc3JhOXRRQUpGNjk5U3Z5L3k1Vjg5?=
 =?utf-8?B?eTA3Z0xyeGlJSG02S1Z6bktHTjEwbnpkRlVaQ001b3dVNHB5Q1Z0VndXNyth?=
 =?utf-8?B?dFlrM3oyK2xHRk9vTVkxL1J5bC9VWU52eVIyZkhzdkg3YjhUNGk5SmREczdU?=
 =?utf-8?B?MjZrdWdpcXZjd29aRzdUejB0b1N5aWFvenR1Y24zQWtOTGhGOGdEdFVFRmlP?=
 =?utf-8?B?TXQ1WUhnekVtdTU3NC9laGxIbVdGeStaT0ZBSVRiYWVjSDhzQi9vbDJpanFw?=
 =?utf-8?B?N1BMMXdXYW5uRmI5cVhvZnVzT2haWWpFUEo4RVlSaGlJVU9weDUwYnc3eEJF?=
 =?utf-8?B?M3Z4ZVB5cEpqUUE2WGJ2eWRGKzk1WkswczU5THZ3cDhMcm02Y1NhS1p5UTMz?=
 =?utf-8?B?Y1VtaXM1VHVCNXhhMHd6aWdONWxqRmFDSDJBNWcxVmtSL0dmSGpXc1liaUhj?=
 =?utf-8?B?T1QrMDhiNk8yK1BwUXlyRnd6YkU2cWNaK3lvZGNyaUpLUFRTcW16UytGWVgy?=
 =?utf-8?B?YWNEdkFqVDNtejUxaGtReWFBVXR5NVJhdjZXYU8rRFY4M2pXQjA5MDJMaVJV?=
 =?utf-8?B?U2pFcGhYOS9FV3JWOWNqU1NSQS8xSTRyZWlzazVRVk05bDRhSXFjcXoyMjcz?=
 =?utf-8?B?cUdETitxVWFrVG93enFoWkdOZWpQVjQrbjZMWXVJU3VQc281Ly9FOVZzYnh5?=
 =?utf-8?B?OU1RUER5QkMxNHVPS0EyV09hQ2d6YVdqQ0UzK1RhSm5XVHhyKzhoNnp0ekY3?=
 =?utf-8?B?TVVjTE9XcW5UZWFVNWVFbC9sNkhsU2ltWlNBS09xWXU3eDlrRTNmNk9PbVRs?=
 =?utf-8?B?bE9URGtPQ0xRaWFwejRFMVZoS3pQK2Mycmc5Rng3S0tIRGZKOTZDOFlwRUpa?=
 =?utf-8?B?Z3MwbnliUm53MFBLcnVBa1pKNXNMeE9odlNGRFRNN1ZUTkkvc2wrZk90YVNZ?=
 =?utf-8?Q?d4/4GBCvHo8YMTNhHGTfTrdh7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343cfba9-29f9-4e81-d2ea-08dd938eb554
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:58:49.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pqr7MoxjkzUea/eAGh9mdQLRL4DIs0qXkPVLAUeXjRW9mcIArLRBlrQ4MY1YfJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562
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

On 5/15/25 09:06, Jesse.Zhang wrote:
> The current cleanup order during file descriptor close can lead to
> a race condition where the eviction fence worker attempts to access
> a destroyed mutex from the user queue manager:
> 
> [  517.294055] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [  517.294060] WARNING: CPU: 8 PID: 2030 at kernel/locking/mutex.c:564
> [  517.294094] Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
> 
> The issue occurs because:
> 1. We destroy the user queue manager (including its mutex) first
> 2. Then try to destroy eviction fences which may have pending work
> 3. The eviction fence worker may try to access the already-destroyed mutex
> 
> Fix this by reordering the cleanup to:
> 1. First mark the fd as closing and destroy eviction fences,
>    which flushes any pending work
> 2. Then safely destroy the user queue manager after we're certain
>    no more fence work will be executed
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ddd08ce8885..4db92e0a60da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2913,8 +2913,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  
>  	if (fpriv) {
>  		fpriv->evf_mgr.fd_closing = true;
> -		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  	}
>  
>  	return drm_release(inode, filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 9fbb04aee97b..1fec3713fbf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1504,8 +1504,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  

>  	if (!fpriv->evf_mgr.fd_closing) {
>  		fpriv->evf_mgr.fd_closing = true;
> -		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  	}

That we have duplicated the code in both amdgpu_drm_release() and amdgpu_driver_postclose_kms() is a bug.

The copy in amdgpu_driver_postclose_kms() needs to be removed.

Apart from that looks good to me,
Christian.

>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>  	amdgpu_vm_fini(adev, &fpriv->vm);

