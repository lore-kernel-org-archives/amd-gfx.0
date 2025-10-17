Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AA0CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 23:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF7E10E1CB;
	Fri, 17 Oct 2025 23:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5NmjOf+s";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13E310E1CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 23:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojUlgZoRFvT2r7XWfDp3yVrqHPPbokiw8dcYz5RAama1q9jlAfju+wMy0eMSAjQesZl4VlaTjkfpLJIwgQVWJ2+GlxyCiUcnoO6ovh/xJBOZxRurhB5xE7ZYAZK5emhUAxKej1+4vglWFRBZSM9EoHlDpOQiim6iQg3IEwMu+4vW/WQlco1FDrrp1gsiKE4cpPssDtsuyJPremE3HgFdZq1M4VvbQ9gWElQfPwjoMvNL4pyRT9/xaeci3FmsmvpGzjU6Zibs/9d3nNnKZhuBQTNf0Se5jqy4jE3H8DGxbeCAVu6Oj1bz1fKAx2G5clqU0vBYWL2QfcNYLY7YRdA96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/LJbTgyoIEL1TaI0kgOuoIK/Qp0RactkrZAdqAyMhs=;
 b=Tw3wIoFNA9Dug71Mcl9q1Mf5eIyVMWl5iLd1ogHueyx2HGIdzKIUnlQwdIvb9RBY60ESyb+4Ayhj+IJgmZB0ilG7gD8p8QLBlnGN4Psk/nlySmFAcAUMWyxrZqymKH5Fo8C1lFcayyBU67T7Op355/u9aT1udHRP6STeRqRgRTpBOm3VSfVHZ0v1n/ZQ8lZ+vdDY3EsJ+PRQgZ4xbcPDkCHV8zfbZNVNCTpZJL0aoHtAhvFYQ3fyY5v8T1Vau/PO6gWx76h5hoU1IehiSj+BLSC/Lj/UQm7FTbhLUQ4rJ5n65Z8e+bwhlrKnVccyhSlO4YunUIODbG7c6oFgtHScWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/LJbTgyoIEL1TaI0kgOuoIK/Qp0RactkrZAdqAyMhs=;
 b=5NmjOf+sGdxBtk7Cu0cX9uVuWYD0ffnQT+MoA7MztdP29U09aNcqFWw+yH8UOk5m46JedibA5tB3BuAVgTcr1cVPGvYoPzPP0KGU2c7KwSuypw+y5MbJSuiQZ4ARGZwSwA4LZidQoSIVJdx9TpH+Zj4Oq56kCdcYmSqOKY+PESs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 23:55:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 23:55:31 +0000
Content-Type: multipart/alternative;
 boundary="------------O01TTL2J5iBw1zjhuqV69hJ8"
Message-ID: <b545b31e-26ff-4b7a-be86-312d9aa96e97@amd.com>
Date: Fri, 17 Oct 2025 19:55:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 18/18] amdkfd: introduce new ioctl
 AMDKFD_IOC_CREATE_PROCESS
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
 <20251017084222.54721-19-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251017084222.54721-19-lingshan.zhu@amd.com>
X-ClientProxiedBy: YQBPR0101CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 90bf6342-6d49-4ee4-750c-08de0dd8a7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFVFcmQxYVdCWjI4T1UraEhza0dzL2lsdVpmZHBMVCtCNHc5MUNpcXBBa3k0?=
 =?utf-8?B?eDZFR29NOUZoMFNJUmR4Yy9TN2xhTWorSDlsME9zYnQ1YmJqRzFXZzgzWnVu?=
 =?utf-8?B?eHdGVTNESE5wWGdnZ0VwU01GdGFiU3lqRzlGUFlqWEhkc1QvSnJkeGNCYkVq?=
 =?utf-8?B?OVZrd1BpeUFXd1l1QTJaQjRhcGtaMUx3ekpsWjF6NnZOWVlWY2F5d1htQy8z?=
 =?utf-8?B?dFVMYm9ObE1wZmdkaGc2TkV4S1lWTzNRWTQxbENHK1JISHU3SkVseS9TcHdi?=
 =?utf-8?B?S2FFQ0pLVWJjL056aXcwc1E3Skx2cG41VDlZdzIxZkV4U1NBV3d4Wmt1YTVu?=
 =?utf-8?B?UlcvRXI0d2g0QkpudWRSSC85UVEyMnVabTY4TkxnYkVxUlV2ZER3NzhJT2ZN?=
 =?utf-8?B?WTdxcTdlTE1mek8wc0pEK1A1M2dwVkxWR2xta0Q5dzBScGFxRHo2VWVUYTJx?=
 =?utf-8?B?cXhPSEhOR2RnbmR2d2RORmFURXBXVm43bXhGeTllL0pVV1JrR21aRzJ4eDlY?=
 =?utf-8?B?ZEFjOEFTbmZRWWJoT0hHV2tmN2ZWaURHak5MNkJ3UVVCTEJHUlZ0MVNXYStS?=
 =?utf-8?B?VkR1Q3pwUE9XRHVFU3JYQjV6d0VheTJyM0ZTSUgrOFVlZ0xreWhCVjFidVdu?=
 =?utf-8?B?OEFkVkFYVkFmTkR3dVUxSFhzY21kalJ6NTFpOEVUZW1LdVh6OWs3K2ZiMmho?=
 =?utf-8?B?ckh0VE1wbGZOUldEUU5VOFhRc2dhbjFIR2U4cDBiNVdPYzZwL0Uxei91SlNF?=
 =?utf-8?B?aExUSm9kRVdXMnZuTGM2bGxYTDV2S0V1eVpvQkR6bk5NNGt0bXdiZ0lDN3Nl?=
 =?utf-8?B?Sk9xbjYzMmRWT0RmQ3VPdG5yZ3JidWdabUJWMkpIT3pNYmkwU3dsV1Rsa3ND?=
 =?utf-8?B?a0NOT25iSVZIUkJpenF3MnYxYkxHUGtwd29KYldVNzh0UmxKTW5mbXlmdS9C?=
 =?utf-8?B?WXJNaWtIV1VaWk9Temh5b3QwRTBSaXNOSTV5dVZ0SXAvL0hhZFVtcC9mZE1W?=
 =?utf-8?B?V0dBOEFJbTVQc3BVeVdrYldPek4zQnZWdkZvWStPdnZvd0piM1ZGbmJhWE1o?=
 =?utf-8?B?d2FyRUxsdDcyaGp3amZkc25BZ0VlZG9ybHV0KzUyYTNvQmNYQ3phTDN5OHFs?=
 =?utf-8?B?d3d5eGdSajY4bnRZQW9ZL3pCalZWU0lPU0owVnlvSFBMUWRrRVRnMmxMSGZm?=
 =?utf-8?B?cUxXNEhpRzNRUGNuODRTd2VWUFJaVUpqYjRDNUorcmpjTC9ndE85TGlYWjg2?=
 =?utf-8?B?Mks5c3FuOEJsY21RQjJQc2NRbEN3Snpkc2ZiNmRxQkNJa1hEU1V0NVd5cFRM?=
 =?utf-8?B?Y3dQeE4zc2ZyRjQ0NjhlaHJEaWw5bFUrdXp5bTVOQVU4YStEYkhMdlBKNE5w?=
 =?utf-8?B?NlUvbWNaZ2d2dDF4enlhZUlXbGNFS3BVMXBhZWhBQzZoOUpZQkZpTHRBbjZh?=
 =?utf-8?B?SEdkdUtvMHlOdzRERXhlSTQwR3VSMksyUk5oL0F5ZEhTZnZBcnNSQkFOZzk4?=
 =?utf-8?B?ZnkvZHNXbjdXUHh6Y2RNZUhBVXZ3WFY5V3BjN0greXdrWGJ0YTY3VE9rNUpS?=
 =?utf-8?B?ajdycEpJT3NrQVY1L3lvakRrbDhoVzc3N3VXSWdMU0czTTVqbENHRTh6NitG?=
 =?utf-8?B?dmljdVJjbUl2S1loMWxCbWZRdVd3Ny9sdjFYeSt6cXRxVWEwZU9qcjQxb0lU?=
 =?utf-8?B?bzBUNG51ekUvRldZc09nQ1p3T1RpQ1V1eko4UFdpa2tRME9oM1VIbmUwaTR2?=
 =?utf-8?B?c3lIbHFlYk5mdC9wZWpSTm1IMGtDd2tqckFvVWZCWjJaa3B1WjkvbDJHb05i?=
 =?utf-8?B?OEFxck1NWkhUNk9uaWRlWUxLdnZNOEM2Um9uRTJpK2U0V1dVeXhVcXFaTWt1?=
 =?utf-8?B?VzZxRzYveFpFYkJYTDBUaG1JejF1Ly9XVk9hREthSXhvSlNqMlYyOXZ5b0lJ?=
 =?utf-8?Q?eA08dOg0B01QD6g0zQ+trrp9zLELTMUm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5vbERiMGYwaU0vclNYc0Q3bUtQTTlTY2VIbzhhYTY0bTNVcmUrc2xxSThy?=
 =?utf-8?B?enJIdnFoeDl4cGFoNTdlZGtYb2VsVXROZWZKamQ5U0cwNTN3K051ZzRFTmRQ?=
 =?utf-8?B?eXp6cStWd3ptTmFBYjRRaTdqR29OZ2J0aEN2MWNydmlySlY1bm44QmI0QU5Q?=
 =?utf-8?B?dVR2MXJ1K3RvODJqczV0QVZxQ3cvRzZmWjR1NWprNWdHZUpyOSt5QzNsTCtk?=
 =?utf-8?B?c04wVENkL2xudGlSOXhZRmNERnlnY3AvZlAxN3BXVUNKeXZRbEdKSEs0dS9s?=
 =?utf-8?B?ZkRibHhMZUpFaVIvZjdIQmYwU2VxSUlUL0srQ2xtekl5SGhZcG0zb1VpdXEw?=
 =?utf-8?B?anZCRFJoUERReTJuWWlmSWhnYTA3UGhsaFNnN2hXdkxCTG10Z1JBREZHK0R3?=
 =?utf-8?B?VS9SMWJVc25GTllJQzFPQjREdlpHbkVEaDVMejFsVEZDdnl2S2p3T1dPVS9u?=
 =?utf-8?B?UlRkSU5WR1VoNFNlRkg3S1JoSGtQclh5MnNXM09BVFZNYkNHT1MyS0Y2N2d2?=
 =?utf-8?B?RUpNZ0JJYnN5b011SFUyMXJ3aktWQ0IyMXR5aytQNTlkd1NKVmUrMzVlT0FK?=
 =?utf-8?B?RzVwYUxGVm1zd1JKaml0TUFSaU1QTmc3bmdkSjYvSXNXT0owTjI3eVBMMHBs?=
 =?utf-8?B?YVZsUlRqODdBYllyQUlZNlNhN09nVUxTRnhDRVBHOEFUb1hHcVNIR2hTODBl?=
 =?utf-8?B?b0JYMGJ4aXlFV3BTdWpaNUFURDFFNkJCWXlSclJrQThRdTkwa2cvU3JzQytO?=
 =?utf-8?B?WjhSVnZWc2d2N09kQ0QzSGRUUk9URVdzNWo0UGdmV054RlU2dXhjdWZZbEJG?=
 =?utf-8?B?YU5oajdnUzRIWUN1MmdpZGZXV0RVNzRJN2diUkZUbVJQYmtoRi81Tno3b2U1?=
 =?utf-8?B?NUQ2ci9tNnVVZjd6VWFEbEZMNitKMzdHeDBUNUNaMXFCTVNOSGRRV0ZXNEVi?=
 =?utf-8?B?Z2xjSlk3MlVrT3lwWkV6KzA4Wko5MWxVeDcwM0JBWk9PSExnekgzenZaTk9v?=
 =?utf-8?B?WlNqOE5MR09NNnBLKzc0TThENTZDQzNUVHo5T0RFeXlUclVXaVk5NGp3UndL?=
 =?utf-8?B?WkMzV3NqZkF4YXpQOUpUSVVmbDR4NVhnZzR5TXM1SWMrSGNIVllDTk4vWWFr?=
 =?utf-8?B?WkcrM2NjMkJSRFhPTE9nY1hoaXpBb2N1eXZBRjBzaGllM1gza0RjWC91Yk9v?=
 =?utf-8?B?dEpicXlMVGY2bnM1bW1YenJ5R3FpakhmdFQxSmErZlNpNGJaS0NxTXM5SEt0?=
 =?utf-8?B?b1FZVTZGekIrOW9pOElPek43eEE3VGVFdlBiN1BweWZCN0RIMExFd3lJckxz?=
 =?utf-8?B?N0F5My9BZU5rbXBaMW40V2pIRVhzSjZranczd2U2VTY4bG1nRnR5VFBwSnRF?=
 =?utf-8?B?cXNEZSt2K1NCbFQ0MVZMSE4vZmg5V3ZhV0QyNHFhNVYzQVRQY2kyTXI3eGlT?=
 =?utf-8?B?aXRBSkVhOFBhR1A4OExmWnNqTVEzTUR3M1ZvdmhGMVl2elRZZ0lwWWkzUUcw?=
 =?utf-8?B?NkxGU25GTnVaZWE0bEhCeklIZWptTU5abi80Ym5wa2FzMGxZMG51Y0UvcUND?=
 =?utf-8?B?ZmxBOFd3R2Vtcm9vcWVnVG51R0h3b25iSS83Sm1pL1puWFUzZ1FKcm1haklS?=
 =?utf-8?B?cjQ2cEo3aEkxWThJOWxHMTBBZVlaSU9SazE2b09IY1F0YlJIM3VQNC9qTUZK?=
 =?utf-8?B?NVhFdTNFOFlFRG14YTJWTFRhd0t1RTYrTVRZUXdWSnM2Qm9zQWxYMjVFcENO?=
 =?utf-8?B?YTFlcFlubXBZSE5ZdE9VUU45dTdTaVlxNXdVam8vUmpLODR3SGFCa3I5R1VP?=
 =?utf-8?B?QnY4djJDWE1vcUdqN0gwVDkvUHlrY0FXK2x5WG04cjU5KzdTK3I1YldWZ3dx?=
 =?utf-8?B?SlY0Mk9XUTgrSlRHcGtNeDl0c3JDQ2J3Wi91bWFPa01SUE1RdnBQcmFwZWtY?=
 =?utf-8?B?ZXBMRW9ISjM2VUlqTENTWTAzM0RlY01IM05sYnRmR3NqaVEwNzdQWWlSMWdM?=
 =?utf-8?B?TEUrbUlVQTFMV016d3NnZjczRE1zeHBHSFdJZ2tIRC9OamQrZ0lmV3dSRmdo?=
 =?utf-8?B?RWRWaTRyUlpqdGdtWml4TGduYW1La3JoL0k0YmhQdGVnWXZzRktzckpoeFpU?=
 =?utf-8?Q?jUisP18bg+v4VEpvL9QKOr0I7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bf6342-6d49-4ee4-750c-08de0dd8a7c1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 23:55:31.3213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCK0+r425y1jIh0JqyNmuLPucUejT41siuoWyrXKXRSHc1fIBsAcXDCXjcLXA7U2D9zgBfEiAMSFuhRJYlybkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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

--------------O01TTL2J5iBw1zjhuqV69hJ8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-17 04:42, Zhu Lingshan wrote:
> This commit implemetns a new ioctl AMDKFD_IOC_CREATE_PROCESS
> that creates a new secondary kfd_progress on the FD.
>
> To keep backward compatibility, userspace programs need to invoke
> this ioctl explicitly on a FD to create a secondary
> kfd_process which replacing its primary kfd_process.
>
> This commit bumps ioctl minor version.
>
> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
>   include/uapi/linux/kfd_ioctl.h           |  8 +++--
>   4 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 7c02e8473622..8fe58526bc3a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3140,6 +3140,44 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	return r;
>   }
>   
> +/* userspace programs need to invoke this ioctl explicitly on a FD to
> + * create a secondary kfd_process which replacing its primary kfd_process
> + */
> +static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	struct kfd_process *process;
> +	int ret;
> +
> +	if (!filep->private_data || !p)
> +		return -EINVAL;
> +
> +	if (p != filep->private_data)
> +		return -EINVAL;
> +
> +	/* Each FD owns only one kfd_process */
> +	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
> +		return -EINVAL;
> +
> +	mutex_lock(&kfd_processes_mutex);
> +	process = create_process(current, false);
> +	mutex_unlock(&kfd_processes_mutex);

There could be race conditions between multiple threads calling this 
ioctl on the same primary fd concurrently. We could use the 
kfd_processes_mutex to protect against this. You'd need to do some of 
the above checks and the assignment to filep->private_data under the 
lock to be safe, to allow only one thread to successfully create the 
secondary context. I think this would work:

	/* Atomically create the secondary context and assign it to filep->private_data */
	mutex_lock(&kfd_processes_mutex);
	if (p != filep->private_data) {
		/* Another thread already created a secondary context */
		mutex_unlock(&kfd_processes_mutex);
		return -EINVAL;
	}
	secondary = create_process(current, false);
	if (!IS_ERR(process))
		filep->private_data = secondary;
	mutex_unlock(&kfd_processes_mutex);

	if (IS_ERR(secondary))
		return PTR_ERR(secondary);

	/* Release the process reference that was held by filep->private_data */
	kfd_unref_process(p);

	...

Regards,
   Felix


> +
> +	if (IS_ERR(process))
> +		return PTR_ERR(process);
> +
> +	/* Each open() increases kref of the primary kfd_process,
> +	 * so we need to reduce it here before we create a new secondary process replacing it
> +	 */
> +	kfd_unref_process(p);
> +
> +	filep->private_data = process;
> +	ret = kfd_create_process_sysfs(process);
> +	if (ret)
> +		pr_warn("Failed to create sysfs entry for the kfd_process");
> +
> +	return 0;
> +}
> +
>   #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>   	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
>   			    .cmd_drv = 0, .name = #ioctl}
> @@ -3258,6 +3296,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
>   			kfd_ioctl_set_debug_trap, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
> +			kfd_ioctl_create_process, 0),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 4237c859050d..578f9f217e16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1055,6 +1055,7 @@ struct amdkfd_ioctl_desc {
>   };
>   bool kfd_dev_is_large_bar(struct kfd_node *dev);
>   
> +struct kfd_process *create_process(const struct task_struct *thread, bool primary);
>   int kfd_process_create_wq(void);
>   void kfd_process_destroy_wq(void);
>   void kfd_cleanup_processes(void);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 629a706e2a13..bbb72a77bed5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -68,7 +68,6 @@ static struct workqueue_struct *kfd_restore_wq;
>   static struct kfd_process *find_process(const struct task_struct *thread,
>   					bool ref);
>   static void kfd_process_ref_release(struct kref *ref);
> -static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
>   
>   static void evict_process_worker(struct work_struct *work);
>   static void restore_process_worker(struct work_struct *work);
> @@ -1578,7 +1577,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>    * On return the kfd_process is fully operational and will be freed when the
>    * mm is released
>    */
> -static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
> +struct kfd_process *create_process(const struct task_struct *thread, bool primary)
>   {
>   	struct kfd_process *process;
>   	struct mmu_notifier *mn;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 5d1727a6d040..84aa24c02715 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -44,9 +44,10 @@
>    * - 1.16 - Add contiguous VRAM allocation flag
>    * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>    * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
> + * - 1.19 - Add a new ioctl to craete secondary kfd processes
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 18
> +#define KFD_IOCTL_MINOR_VERSION 19
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
> @@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
>   #define AMDKFD_IOC_DBG_TRAP			\
>   		AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>   
> +#define AMDKFD_IOC_CREATE_PROCESS		\
> +		AMDKFD_IO(0x27)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x27
> +#define AMDKFD_COMMAND_END		0x28
>   
>   #endif
--------------O01TTL2J5iBw1zjhuqV69hJ8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-10-17 04:42, Zhu Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251017084222.54721-19-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">This commit implemetns a new ioctl AMDKFD_IOC_CREATE_PROCESS
that creates a new secondary kfd_progress on the FD.

To keep backward compatibility, userspace programs need to invoke
this ioctl explicitly on a FD to create a secondary
kfd_process which replacing its primary kfd_process.

This commit bumps ioctl minor version.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
 include/uapi/linux/kfd_ioctl.h           |  8 +++--
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7c02e8473622..8fe58526bc3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3140,6 +3140,44 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	return r;
 }
 
+/* userspace programs need to invoke this ioctl explicitly on a FD to
+ * create a secondary kfd_process which replacing its primary kfd_process
+ */
+static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, void *data)
+{
+	struct kfd_process *process;
+	int ret;
+
+	if (!filep-&gt;private_data || !p)
+		return -EINVAL;
+
+	if (p != filep-&gt;private_data)
+		return -EINVAL;
+
+	/* Each FD owns only one kfd_process */
+	if (p-&gt;context_id != KFD_CONTEXT_ID_PRIMARY)
+		return -EINVAL;
+
+	mutex_lock(&amp;kfd_processes_mutex);
+	process = create_process(current, false);
+	mutex_unlock(&amp;kfd_processes_mutex);</pre>
    </blockquote>
    <p>There could be race conditions between multiple threads calling
      this ioctl on the same primary fd concurrently. We could use the
      kfd_processes_mutex to protect against this. You'd need to do some
      of the above checks and the assignment to filep-&gt;private_data
      under the lock to be safe, to allow only one thread to
      successfully create the secondary context. I think this would
      work:</p>
    <pre>	/* Atomically create the secondary context and assign it to filep-&gt;private_data */
	mutex_lock(&amp;kfd_processes_mutex);
	if (p != filep-&gt;private_data) {
		/* Another thread already created a secondary context */
		mutex_unlock(&amp;kfd_processes_mutex);
		return -EINVAL;
	}
	secondary = create_process(current, false);
	if (!IS_ERR(process))
		filep-&gt;private_data = secondary;
	mutex_unlock(&amp;kfd_processes_mutex);

	if (IS_ERR(secondary))
		return PTR_ERR(secondary);

	/* Release the process reference that was held by filep-&gt;private_data */
	kfd_unref_process(p);

	...

</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20251017084222.54721-19-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+	if (IS_ERR(process))
+		return PTR_ERR(process);
+
+	/* Each open() increases kref of the primary kfd_process,
+	 * so we need to reduce it here before we create a new secondary process replacing it
+	 */
+	kfd_unref_process(p);
+
+	filep-&gt;private_data = process;
+	ret = kfd_create_process_sysfs(process);
+	if (ret)
+		pr_warn(&quot;Failed to create sysfs entry for the kfd_process&quot;);
+
+	return 0;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -3258,6 +3296,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
+			kfd_ioctl_create_process, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4237c859050d..578f9f217e16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1055,6 +1055,7 @@ struct amdkfd_ioctl_desc {
 };
 bool kfd_dev_is_large_bar(struct kfd_node *dev);
 
+struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 629a706e2a13..bbb72a77bed5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -68,7 +68,6 @@ static struct workqueue_struct *kfd_restore_wq;
 static struct kfd_process *find_process(const struct task_struct *thread,
 					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
-static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
@@ -1578,7 +1577,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
  */
-static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
+struct kfd_process *create_process(const struct task_struct *thread, bool primary)
 {
 	struct kfd_process *process;
 	struct mmu_notifier *mn;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 5d1727a6d040..84aa24c02715 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -44,9 +44,10 @@
  * - 1.16 - Add contiguous VRAM allocation flag
  * - 1.17 - Add SDMA queue creation with target SDMA engine ID
  * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
+ * - 1.19 - Add a new ioctl to craete secondary kfd processes
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 18
+#define KFD_IOCTL_MINOR_VERSION 19
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
 #define AMDKFD_IOC_DBG_TRAP			\
 		AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
 
+#define AMDKFD_IOC_CREATE_PROCESS		\
+		AMDKFD_IO(0x27)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x27
+#define AMDKFD_COMMAND_END		0x28
 
 #endif
</pre>
    </blockquote>
  </body>
</html>

--------------O01TTL2J5iBw1zjhuqV69hJ8--
