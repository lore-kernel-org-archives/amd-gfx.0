Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41DBC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 12:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A88410E75B;
	Wed, 30 Apr 2025 12:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UlblGnIu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D548410E75B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 12:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD5BFxbrkxah3oEMLdKNZAxJPqcyE0cgLIVhqQc2pIscZ95zX/TTlnCXcvQfSDlxAgiifHJ+g3PCQTPybNmbrnVCKJYaIOuer4ctMchByQAkBhl41zJjpZTp3a0IZAjcxibV65du3pnSSh1T1cva1d3rSpN/5Pil4noSNMkWaneHYRvO+mdDqNe0+VnbTHy81HmTepU3AiyutCdWKxF2F25+AWzwXkxp2Ww5s0FKM5ysWesCuQYJaArEkZ7Rx6b5YEk+J8KQg29dwdoDd4hOkapKRjK6PgC+Bv7/AgLTw26NqGC90NK8JgcEu6yZONFHQVteICYvJoXwkB8/VxiQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+VWmj9lXC9HG/hMOoHupEkx2LXn4YbDBcQE8B4i8JM=;
 b=fYpvnPQbM7d/0xC/wjHEzZmO0y4NXJHQJV81FwikhYEat84uWszWpEH3i178Grg5dqNrrIYygiXoYeZ695bHvgVtMzRxssGreg4NIoK3mpANV66e0lsJD7fZqGqqtk6PfmDp20wqC+nwjxRUhlqzu+Gl7/MkDVnD7fBhjoqdubaIuhny2NkAwXgozLdCA9/UmMDdY/nO4iBqU/a81a9YEJXJuTRR25W9zKQ9BhD2T+AsNYMsZBTTWmQpcui0TyAfLf7EkNUMlYHB3XtAP4uBzlG5SAJKF3JorxcEnu2cxq90y5QCRtA5CR6i7IO07G8P4mv8Tks1ivxtyAqGXIsFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+VWmj9lXC9HG/hMOoHupEkx2LXn4YbDBcQE8B4i8JM=;
 b=UlblGnIui83quk1CZRvLhyZLBUTO6whid8dPw335rgMESjZP5ZiYsFkg4YbH7SyuV6KW+AbwpmHJO6AA+gwKrJC9A9h0vuqivxKroOYPZqtb67v9lK+X3UW4tFMSFdai0/DH1ocbfiH65+jTA6cRnlKa0OtnaiHUkbZSHKC0S2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 12:01:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 12:01:51 +0000
Message-ID: <62a987a4-d865-4b64-8cb2-a664e7969233@amd.com>
Date: Wed, 30 Apr 2025 14:01:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-4-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430024054.4093239-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 834fe640-3062-4ca3-9857-08dd87deca82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0pZUnFrVSs4c1ZzS2t2alM3amlDSHQvOGdDMnRteUtNTGdJem9vMjE3akJw?=
 =?utf-8?B?a2FKa2t1Q1FZYWk1d3NrdVVLYnkxYy9QRnEvMlFlRUoyeHdhM3o4OEZhRzkw?=
 =?utf-8?B?S09uVnplVDVKSEI3VTF6UEg1M3MyalJ1TVc1WjllbVJFZURXem5KY1VSMVNE?=
 =?utf-8?B?dWVkRVVGZGl2SjR6T2hXU0hjcXdrNGkvQVBETjNWRHpncDNGMjJvMVBCc3g1?=
 =?utf-8?B?Nm9Pb1lVdHd0Rnl4eDRZc2dCQ3paZ0RFWGJIcUYzOGZHUUZqenhyclR2R3pT?=
 =?utf-8?B?ei9vYm9QUmd5VFRoUmtrMDI4Rm9BdGFMLzdENGFLN2hKc093UzZGTGpRZElv?=
 =?utf-8?B?Mmd1cWRrQ3pSY3F5OUJmeUZ6K0ZUckJqTWNXQ2pNcyt1WjVHNjVqRVJZWTR6?=
 =?utf-8?B?R0c0aGtNeXU3NHVYcmFtamlaYitBSlZIVm9rVzhMcEU4VmViUm4rQy9XNkZK?=
 =?utf-8?B?WkNCQVFvVzVsZWEzRCtJQmQ4WkdLQ2NJaEpZN0JrN3N4aGdRRitxMXpoVSsz?=
 =?utf-8?B?YjBLUmUyYVVDc1lpVTdIKzFRd0hpdUdIOU9kSlhJaVJjSG5TZHJ1UFN0QStO?=
 =?utf-8?B?Z0V1aDdyOVhHNXVOMTVHRytBSkZFbHBWMEpiVGVmTE1jWTBRcUIrMW5qS2ZI?=
 =?utf-8?B?RmNoT01VZDJ6c2ZFZWVXWGxxcFBxaEEyRzBURXlQQjgzVTRpV2tRRUErS3FL?=
 =?utf-8?B?NTNJRUplTkZvOVpiKy93ZzRDOGRKYlhzNVl5Ri9lK0o4N1JTbHFMRWlmUW1T?=
 =?utf-8?B?VE9pMEh2Q1NxMThjdjJLL2thU3dWaitjK2xta1B2dnVnMDViYXI5Mmp1bEJF?=
 =?utf-8?B?dE9lcVoyZHZyTWY3OGIyUFkxM1JSeGZxcmM0bzAvUnFkM3g4QkJWUXhjVy9q?=
 =?utf-8?B?N3YyM0xwOGxDV3VreWZqVFpBRklIaWhndnhPT3ovcUpzL3VKTDVkYTdBTU1y?=
 =?utf-8?B?NTZCdmxmVGlQRVVnSXZOdDRWTnd3eWVSRmtpRGlFOGYrbFZJZ3MyQ24zakNI?=
 =?utf-8?B?UUhOQ3BYRStTMHg0cHFxVHBQNGkrcWRuWlphN3k3czN0TDJIRVFNZkx5Yk1R?=
 =?utf-8?B?UXdUNzNwYk9SeWt3S25TUHlDbDA3VXhYeExQYy9pMVh0NGdLTzVMRE9DSHZm?=
 =?utf-8?B?dnJFcjI3N3RNamx2TUZiUXZTTFNaYWpIQms3UndnUlppNEUySkRISG04clQ3?=
 =?utf-8?B?bCtrZHc4N0FwVUVpRmR4YWVWRHBxbHVIMTNXRmUrVnFZVUVFWk55M0hjUlRB?=
 =?utf-8?B?RnlOTy9TOVBKVnRFSlNiUHZmSXJZaFcvTldkUlo5bDJzcGZkSE5iMmlDWWFN?=
 =?utf-8?B?RjB3aGZMZmNIeStMWmhJOW1Bd3JSb1gyUTUrNE9XVkx6M0ZWdmVBenVYcmhy?=
 =?utf-8?B?Mndkaitxc1ZpQm1pZWJpL3JHRWVCUHVjQ1FyRnJocDlZZ1duSThUTmtHZzN5?=
 =?utf-8?B?Ylp1b080OEVlbm1mZTQ2YkFzNE9QcWdJVHp0UEFBcWJFTXQrWVdiRXpRbk5r?=
 =?utf-8?B?bGpTT1h0NHN5d3Zqek42dm5xVG5lTEVkSzVUS2NSVVhQSWdrcGM3QVNKeHN1?=
 =?utf-8?B?eDZJZ0d3UU0yeVI3L0ZXNjE1QWNMS3B5c2J1TEtDSE41a0hheURlN3JYMk5W?=
 =?utf-8?B?MHprYWNNamZBNU9GeUJQSnJXbGFGRjIxc0RJbkl3M1duN1BQdFZTVmxUMHdl?=
 =?utf-8?B?YjVYSmtrMHNVQWpYa3YrcVF0MDAwT3FkN1NITHB2KzUzeVJyRGJSWXFDcnlq?=
 =?utf-8?B?V1UzSkhNQ3JERzd5VzNUcG1nQ1pFdDRTQklJbitwNlNMVFlNSkRhc1ByNlQ2?=
 =?utf-8?B?YmtRU3V1MmgxQWlxZk5ZZTZsRWU2di9CQjM4QmlhUno1L3dzMk9hRUJDZ2lE?=
 =?utf-8?B?L0lkNjBUbHJoam8zanVDYUhQZ0ZsVkhMVkJkeDVDbk1DRi9YQkNkRytkNzJC?=
 =?utf-8?Q?kCipcjw4W20=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TSs2eU9mSGExMWRnWUEwaktDRVpFb2NCQ2JQdlp4UmdKTVFZMlV4Q3c1WHhp?=
 =?utf-8?B?QktOSGhOZ0FnbXFxeElRd0ZkVG1WdXFUZzJCOVhqaW0ya0pBdVF2ZEhFWXBE?=
 =?utf-8?B?M3NweHp3U1lSNHp1c2xPZ0VmT013VXZKQndlc3M2enQwa0graVZiL09tdFlF?=
 =?utf-8?B?ejJKdlJxZDJPcHJjczA1QWVmWVRxRFNjZlJqNEJhbDRMb0NXc0N5ZXFadi93?=
 =?utf-8?B?b1F6dmFxWDljWFlnVTdsQlo5UkIwd0pwV1liaFVDRkYvTkgvS1Z4UjhtZE1u?=
 =?utf-8?B?Z0xxTlpIUkZZa0NLWlZtMXNDWGUzTkgvSUs4V2NyV0VpUU55blpHNyt1Qnlm?=
 =?utf-8?B?aUNxS3VXUkJrWHIyVXlaWkdXaXVGbE0zTXVRaGZsekhqeXNZajl4ZnR3L0lp?=
 =?utf-8?B?THJKNXNaTHF3dDBtWTZkaGtsMHRVZ0pUdlZaMnNqUUQreklIOERBRkZzNlRu?=
 =?utf-8?B?bitnMzZBc1FBaVU4dUpUK0t6aTRFMnVtNjQvSWV2MHhpczZYdEdWdnlRQnRn?=
 =?utf-8?B?R0d2YWFFck1naC9QUTRnZkdpbGdSVC9mM2xGbUxCcGFYRTY3SGd4REF2a1Zw?=
 =?utf-8?B?UlBMc0tpOUtMZ0JqZFkyaVdEUU5zQUlJalZvbjFUVXBDdHdmankvR0d0OFBJ?=
 =?utf-8?B?RzAwVDVlVC9heEh5UHgyNmF0bkc5K0dUZS9UVmlla3NFcDRlQTBCOGhBaGNP?=
 =?utf-8?B?Z1VqVHFncE5LQ3FJVGh2YzljRXhZMUNzcUhjb3ZTdDg3NVFXRXlEMHVKZ0VH?=
 =?utf-8?B?bDJhanEzWHZMQU91MVBrODNINlVMLzYwNTdUcHoyWWZtdDQ1ZnZDOHEvMkNQ?=
 =?utf-8?B?ZmxOeFRBRmRrQS9NenFpQ2NiS3VFbldkaWlmdnJGZURzWHY4cFlIcGJsd2FI?=
 =?utf-8?B?QldrQzFLOFNrK2g1SUZvcm9scjJzdUx3cmwrT1lGZXd4cG02M3doMnJNLzVk?=
 =?utf-8?B?aGlSdlBYTWs3UURNTEY0eFZZeHlxOUhZRlhpN1VJd3pSa1pOUzhsSU1NNy9W?=
 =?utf-8?B?bkEvR2Z3SmFuYys5cUZoSDBFZE5NTnNSQ3pjZ01IMlVEYWZrcEgyNXNPL1Zv?=
 =?utf-8?B?bTFLRUZ3TkdSTVZHN1ZSSnlZNXRUeUZpTWNNSjVtMk9ZNGg2MVowTmhwRUp3?=
 =?utf-8?B?YjZlQnVPdVlRa2I1Ui96UjVEU1BvaVEvUUltSFcwY2R5M3R6d2dRZ0VOUVNT?=
 =?utf-8?B?OCtWbDcxL05scTZGVGY4ZU94QndRN3gyWTBLQmJST1oyZmlaQm8wR0RMK3BY?=
 =?utf-8?B?VjJNWnRBWllsSmpoYnJGcHFZZURFajlqRHJmeHA1Qi8vaDkwTHdDekZiZ040?=
 =?utf-8?B?aG94eGpGOXpDZ29iVkhrbUlxNGRWMk5nTGVydThDcGgza2o1WHY3bEpxYlNa?=
 =?utf-8?B?NmE2NmV2c0RIS2hyd0UvU3AzNEFZbWFYRUx1d1ZlWEpsU3hYR1RRZ3VYVXAv?=
 =?utf-8?B?dmxXd2VPQnBLZW1FTWtLSXpzVjlWVXVCWmpPajFpTURuaXM3VEZoSWhHNWo2?=
 =?utf-8?B?QjhEUThXejFYWmtMVlBZcEU2WFYxdG9SZjdFNno1Nm10WU93azUxcVBWSFhE?=
 =?utf-8?B?S0ZyT2Z1eUpwUkhDTXFPR3lPWGpsaHcyVkVUOWJKSldpR0QySWlpS0haSElY?=
 =?utf-8?B?azQxT0FlRS94bnJBakpmOTVmRGxmN2d4NXJQZVUvczcxZjIyb1ZkN09HRVow?=
 =?utf-8?B?Zm1nc1pWTEFMMVhNOUIxOVBFSDJZMFBWNlRSSnNDMXdRMlM5RGlWeVpnWUYv?=
 =?utf-8?B?L1dEUmNQWkhINUFhdnk1M09uUFdOeWRkQXBlSFVaN0N1UzlVL1lDbGtDNzlH?=
 =?utf-8?B?Wkhkeml6enBKUlBWQzd4NW04NVB1YmZpdW5sdDdFNzBIeGsvNDZvdEFKVzl5?=
 =?utf-8?B?V01mQS9HMmxycFNScXZuRUZuZ3VpWkJhY0lTNzZmMUhIME5KNlNVT0JmM1d2?=
 =?utf-8?B?cDZvVXZKdmZCS01Cd3YzY1lMK0U0Nm9vNlVjNTh4N0lnUkxXMmoxL0JLaG5N?=
 =?utf-8?B?anM3WWptZ1VVK0VEb0FrZDU2OFBsbE8yajZHMXZnTnpHT2xWR3hBbWFWMjhG?=
 =?utf-8?B?dHlORjlvcEhtYUhWTHYxYThYZ3Z1ZDl4b0ZVZm9LcGhETlowYkFTNmUyNG9F?=
 =?utf-8?Q?r5uHpZnOA+gHaNuoALDnHJ04L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834fe640-3062-4ca3-9857-08dd87deca82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 12:01:50.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzXLTj/wMDp6l0jfhqx3RHxA7Kcck7MFa5lvMn+pWGihaa/E5RNLKcStGCVK2k7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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



On 4/30/25 04:40, Prike Liang wrote:
> Before the user queue BOs resume workqueue is scheduled;
> there's no valid eviction fence to attach the gem obj.
> For this case, it doesn't need to attach/detach the eviction
> fence. Also, it needs to unlock the bo first before returning
> from the eviction fence attached error.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 22 +++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  3 ++-
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 7a5f02ef45a7..242bfb91c4f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -196,16 +196,22 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	if (!resv)
>  		return 0;
>  
> +	/* Validate the eviction fence first */
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	ev_fence = evf_mgr->ev_fence;
> +	if (!ev_fence ||
> +			dma_fence_is_signaled(&evf_mgr->ev_fence->base)) {
> +		spin_unlock(&evf_mgr->ev_fence_lock);
> +		return 0;
> +	}
> +
>  	ret = dma_resv_reserve_fences(resv, 1);
>  	if (ret) {
>  		DRM_DEBUG_DRIVER("Failed to resv fence space\n");
>  		return ret;
>  	}
>  
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	ev_fence = evf_mgr->ev_fence;
> -	if (ev_fence)
> -		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
> +	dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);

Once more: Absolutely clear NAK to that! You are breaking the logic here.


>  	spin_unlock(&evf_mgr->ev_fence_lock);
>  
>  	return 0;
> @@ -216,6 +222,14 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  {
>  	struct dma_fence *stub = dma_fence_get_stub();
>  
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	if (!evf_mgr->ev_fence ||
> +			dma_fence_is_signaled(&evf_mgr->ev_fence->base)) {
> +		spin_unlock(&evf_mgr->ev_fence_lock);
> +		return;
> +	}
> +	spin_unlock(&evf_mgr->ev_fence_lock);
> +
That is unnecessary as far as I can see.

>  	dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
>  				stub, DMA_RESV_USAGE_BOOKKEEP);
>  	dma_fence_put(stub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f03fc3cf4d50..86779dc817b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -294,10 +294,11 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  	else
>  		++bo_va->ref_count;
>  
> -	/* attach gfx eviction fence */
> +	/* attach gfx the validated eviction fence */
>  	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>  	if (r) {
>  		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> +		amdgpu_bo_unreserve(abo);
Adding this here looks like the only valid fix in the patch.

Regards,
Christian.

>  		return r;
>  	}
>  
