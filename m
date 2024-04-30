Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ABFC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 08:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CE210F34C;
	Tue, 30 Apr 2024 08:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HCanA/KQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A977310F34C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 08:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMBeeDzXS5EdRRLO1sVZ/02DpyCgLzO1bPlfn1BYzKm6tUrY9eNoiPF86Jcx7tuCICEBVnl5MLaZ1gToGK0jO0EMOmNqYllsO6lSf0ee/P2IACjTKGx4cmxVnmpAaPV+Iq/Bd99JxpqEE7ZIydRMN36FrdxSmZZQLQeRBCv0Dtg6HsADQ7fiTXydX6VcUToKaNCcdgGsObd4PgGhXLqWvwqNrlHCtGTc4evm+F8eH3skkr+JMvZ6IOhPemrDxHIizy8syzDXRPT6Q3qT85/951re8t/PFLcLrA2FwBhrkXMU4vjqL6Y3eiL43z3IpCSdRtzGRLt6P0jVOj5H7Qlyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOeIlYMd/V0VPIjmiQXLrOn11WtxBsxG5rbBWe2enZM=;
 b=m+FDUwMqn5+09gR32vfHM2/YfV7LE29fCG+7T77VENZbsgCZ+litXwsTrWW9854PLdbLlS+doOXFy9P9ZXS9QuZMbJO92Kqx5BhXp5f1JsgjonIG0QA+5T3KogXR4pwQuDNgDCdhpAZ87YF1WN+7l07/57wrUNiHQ5RXvrzTTTrHOHm4XaXp97CFFPLsoi1IV0Foyh48GZrwwI77DPwOhfkZO7zdZDtcEnl2keLGizXbM3oMYgb8bkKylKtmyTSdP0godVW/uGbW92gWrnTUYUwvPD1L5NgLKT5LjWX1AwedcbdJ/u/CFQMW8joBtlHlYE0IP5kEppAKSu8wHmg9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOeIlYMd/V0VPIjmiQXLrOn11WtxBsxG5rbBWe2enZM=;
 b=HCanA/KQWC0NCQfJ9PPaetZQPqT2KbYzvgDVeao73pE8tldFI3LDM1iIrwaxkm4y2L3vtDmdG5Hnkxi6Sxv88C2QvopBJH981EcwYNmb5ESktlllnH7RECx9B31WpnRTIK+wUGc/LEL5baLY3y4om1/TEuCqf2KXaJNZdu2k0Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 08:40:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 08:40:57 +0000
Message-ID: <76e915cc-fba7-4563-8acb-4c26058f58bb@amd.com>
Date: Tue, 30 Apr 2024 10:40:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
 <20240429064351.626929-4-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240429064351.626929-4-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: d621fb37-257e-45be-4a94-08dc68f1414f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wml5QklCY0NQRVNka0xSRkpPYWFlanlvemFWbi9aY3RJUVBzTkZjNUxENGth?=
 =?utf-8?B?eG1aRXNGL1BOaDJzS01uWWlMcmxhVTJHSWlBc2hvN0ZXVUE0M2IrR2F6dFhD?=
 =?utf-8?B?WmQzRVhCUmZhaHpHM2l1eGpoa3ppbHVtZTZPN0h0SG9UbTYreEg2bkgvdUo0?=
 =?utf-8?B?eWtIYTE4bDBZYTRiOEgzSjFQR0c5RlZvRklWWjdpK0ozU0U2Wk1EVXZUc0sy?=
 =?utf-8?B?NWszSVlZR0RUN09ZZU5pWGRDajUxQmpIMVE0V2J3eXhkM2h6OGZYZm0rWlRY?=
 =?utf-8?B?UHVkRkNrMkI3S25IQ0pxR2I5VTBENGpmeDJxUGRPUksvU3o5c2RoZU5ZKzF1?=
 =?utf-8?B?M0t3ZVJRaytNZTZnWmdwcm1VRFRwdEZydE5EdEc1WFVSZmVuZHN6eVhqNlI3?=
 =?utf-8?B?citsbU0vV2lLV0s1VHBRVkhQVWl6RS9Ucm5rZmFSOW1MMFpUUGdhaVd3YVQ4?=
 =?utf-8?B?K21GU21kaDJHYjVlOUlGVmlPa25NWUN3dExzM0h3bUJSY3cwVEpVc0c0YlVJ?=
 =?utf-8?B?NzY2dysxNnk4aE1tVXBlNklhNk5BTHBFaVVNQ0oyTVNyNE1hQW41NmFCTkNH?=
 =?utf-8?B?L1F2Z1dpWlFBVW5hNjcySTNaOFJMbmtmMHJUc085aThVUjhlMENzV2NJQmZw?=
 =?utf-8?B?YS9yUHN3b21IU1RDaG8xb3NUek4xakg3VFRVUm5MQnlYcngzSy93bFZFcm0w?=
 =?utf-8?B?VTd2YmR2aURvdmRvU1VJWUkrd2JuWXV5VWorMUN4NHVRVUNhaTVqQzdWVmdv?=
 =?utf-8?B?bHppTmJ2SFNVclhTK2d2RkJQNzhBMHRwek9mZXJLTkIvM0xLd3d6aVAwLzZS?=
 =?utf-8?B?eWlIZUhlaXZrN291cWdlQTNFdGxnL05hZnR2ckI1ZkxocTJleGN2dTlXS0F3?=
 =?utf-8?B?RkhHbjZWWHdJWnNFaVg3VHBwZHRVbGhaRTljdlBLMTV5SWlJSndDSWJpdXV3?=
 =?utf-8?B?dTdKZCtrMkZ6UHNVWkh3SkNkdVpXN1J1Y3NCVDRRU1lzenN5Skt2TG00U012?=
 =?utf-8?B?SDA1cURQcVgwbVFBcFZzYncrWThzc1ZFVGdUb1FwdklVU1BoV25WaHgwc2hn?=
 =?utf-8?B?dkR1T0lKK2dwak80MkZaOTQ4UWpFNHphTC8rL2ZUdm14ekV4aWJVeTMreWJG?=
 =?utf-8?B?QklwcUptZDl4VW5rT1ZNa1ZJeWdVZ2pmTm4zcG1RR29BR1RQWHI5bFd0ek9r?=
 =?utf-8?B?QWxWM1NvbExyVVRkVmp6eWZMamphOFVHYXFTZysvMXVSR2VMY2NlVk8zOWlD?=
 =?utf-8?B?cG5tdkFRMDJSN2dSS09kRklQU2VOcEdOVHduM08yMlBsNktJTnNobjJyOStq?=
 =?utf-8?B?cXlLektDYjMvNURFNzdtVFk2am1UajVqaUtHaVY2UDg4Ly9EUUVGU1NFSXNP?=
 =?utf-8?B?ZmVUNG5BTFRENGRUYit3dFdtYjZTdFUwWVpxZGpqNjQ5VnlscUQxZ0ZqUlhZ?=
 =?utf-8?B?SEFYWFlEbUh3bG9OeWV6Mmg1b3ZJTHM1elFOT1RpVFNlbllDMkxqRzhOTEVl?=
 =?utf-8?B?QmtRTDMrQ1VhcS9uUmRRZ3pFQUJRZldEY2M1UWJJNHhMTW5VOUhRQXFDN3Ru?=
 =?utf-8?B?Nlh5bEFqajlrSUt1Z2VqNlNMbEoyY2ppTjBOTkx2QndJQnFnT1VCbUEzZDRJ?=
 =?utf-8?B?L0RLNnBMc1l0cCtkTENzd1d2WFBJWmJkT1NKYUI0OTQ3eEdGMXoxVG01bm11?=
 =?utf-8?B?aUt2OFMrM015REdrVTlaQU1sN251RHZNS3ByRVQ5MXlUOXlsN3lPcDJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnovUXdRN0FFeG0ybXIrMjcxSFF4VUZ6QktuVmRuNStpdHZkd042Q0gzUk81?=
 =?utf-8?B?eG1GbExiZmxBMkdoZ2R6YStoWEdkODFaK0RwRXRFVVZzZUNCWXcyK3ZOWGFs?=
 =?utf-8?B?eEpTdWh6eUhhLy9qYjVpUUorWVlVLzlJbW9hdFdjWkx6dytPUXYxekUwcDRP?=
 =?utf-8?B?MFZUbW1mWTUxRXN3TXdlQ3lPZHRVKzdVMDc3WHNtSkNtMmttaEhQTVF1NXJQ?=
 =?utf-8?B?dm5hcmErRExYU2daRGM0UDQyZ1kxS2diQVd6b3JiY3krdjBJU29ORVVOUnZC?=
 =?utf-8?B?VU4yWmIxbXdIL1k0RWV2ZVRQeUdwUVpGUThidmczTGE4STRHS0FJbHFiUmRL?=
 =?utf-8?B?K01ZdzFVQkErZEVTSWFpWmVlY2pNR1FXOWU1S05venlBcld3a1pBTGREcXVa?=
 =?utf-8?B?ZlkwRWNEVWtKeUFCVWgxYVl2bU5yOUdQd2F2cVRqbHFQU0xjWUt6ZkZMNmlJ?=
 =?utf-8?B?OElOandFQWN3N3NGd0h5ZEVvYUJLNTZZa1N4eDZ3eHV2enBPdkJkMXlqMXdT?=
 =?utf-8?B?VjBXZlp4WURTV0UxWEZjM0tDYUZieEdadW02T0ZJUVVOYlBOSzhhRzIzWkhV?=
 =?utf-8?B?ZEM1VTdaQ1hBOGpUdEZTT20xT0tleXdybUFsUm9tY0h5SmMrcUY2RERXK21Q?=
 =?utf-8?B?dkY0V25ZTGxldmlPRUlUdGk3YWFEWVExT1J4RlVHb01XZ2hLcHN3NjV1eDlt?=
 =?utf-8?B?RUdFemR0NWpSd3Boc0hHOGhOakFYVFV5Y2pMT09uNHA1WjJIdVFlT3JKa0Zu?=
 =?utf-8?B?bnpXTWtxQk41REZaQlFtcG0wTFpqaFBZYUFSWm9RQlZvMDF5YlU0V2x0enBS?=
 =?utf-8?B?V3hROFIwUmc3aVBidjdxL0tieGRNWEp2U2UyWGRaYVEvclp4dDkwMExFdzVW?=
 =?utf-8?B?SkNtWWFMQkhNbUpiZ0V3MHhlQmVDSzBVeVhwQjRNeE5yNk1oejF3T3lBZVV4?=
 =?utf-8?B?RjV5Q29FWEdiYlN1cndBU1hYZ2ttalVEamN1OHdsTC92ZG1vazVVR3RHN1Jw?=
 =?utf-8?B?S2R2K253b1d4ZFdGUElzRE5LZXQrcGgvcU4xL0MxM3hUU0prNzdDNGdSTEpx?=
 =?utf-8?B?bnRZbEgyell3aEx6V1pWQjhDSXB2OFpWRWF4SWwrU3I1N2ZCY2dJM05zS01N?=
 =?utf-8?B?aERyeG00NnRjaWZkek1ERXFFaEI0OHV0YXpUQU9SelFOdXhOdzBEaGxYQWE2?=
 =?utf-8?B?V3YrS1pIdkhPMWppZzI2QnQ1WjFDUjllS1pOVnRJWU5YdG9zWXNQVnR4Um9l?=
 =?utf-8?B?ODFOcU9yM3BFSWJJRnhWSVFkeHdaREt2Y3VnOTdVRjNMaGo5bTJZQ1N5dkgx?=
 =?utf-8?B?UUNPUTl2KzNaZTAvVGMyc3NTZVVKYXEySmRKakt6RyttSnVhUXV3TG9uTUV4?=
 =?utf-8?B?SGp2S3lPNzl5ZlFERjVjR3U3NzErdmI3alNzOEVGN09CSG9Kbm4raWsvYmx6?=
 =?utf-8?B?Rk9RMzBzd25lK1Qxc0wzRUpyc1dET3lUMlZCc25sbkQwTmd0Ty9vNGFYY2hJ?=
 =?utf-8?B?Q0xlL3laNlErcjcwSDg4SHREb0Z0Mm1qZHRlWndkWGhhU1htb3Vjc3ZMUkVu?=
 =?utf-8?B?U29oSmhoSWNEd0Q5dGRCL3hLMU52cnlBeVpZaEtMT0tlNVV2eTFPSThJNlVD?=
 =?utf-8?B?V01MVmVUNnBUZC9XU3V5VmRyRkpzc0hKYTBPUVYvMVIrdjZQKzVwMk1ZZzN2?=
 =?utf-8?B?YXpBSmZ1TTROcUJvNnpxQUdyMldTUEtTaTZYYlZ5K0NmT1ZXNUx0amVTQm1R?=
 =?utf-8?B?c2lhTlF2S0JJRmx5L3VxeVltVWZCLzVVMDFSQU9BSnVra0E3RzdzQzNuV20y?=
 =?utf-8?B?NnF0MW9WV2NPdnVtVmFTdzJTbkNMK2Z0VVY2UnlXdFkxem1aUVNYYlpqak1U?=
 =?utf-8?B?MU8rUDllMUtUWVdKT1BvMlM5b2tncmpNNGJZSyt6QVd4ajR5R0ZOa0JaT05N?=
 =?utf-8?B?Y2gwQnRzdTUzcWpwRGthZzl2czR2Vm9haVhUcXZWK2p2Yk1BSnRNdUtwVnBS?=
 =?utf-8?B?bzNJY0tLc2dDQWhaYjFoV3NoemxSSEpvRDRjWGJCNVBlSHUwZGJDd2JldSty?=
 =?utf-8?B?TmZKc0hxS3BKMCtCdXZDMytvTzB3VEM5UTM0QS8weTRkY1R2TWZTcFRVSjhx?=
 =?utf-8?Q?i3aP3INjCBwP2Z4lcGmbmwSde?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d621fb37-257e-45be-4a94-08dc68f1414f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:40:57.4290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlwBIjUo/Kx2fx4O1Y5tsjiNm0LlIWA6xkgx9KPZ62fmFNNTgbw8jiWSyiwAroOY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
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

Am 29.04.24 um 08:43 schrieb Arunpravin Paneer Selvam:
> This patch introduces new IOCTL for userqueue secure semaphore.
>
> The signal IOCTL called from userspace application creates a drm
> syncobj and array of bo GEM handles and passed in as parameter to
> the driver to install the fence into it.
>
> The wait IOCTL gets an array of drm syncobjs, finds the fences
> attached to the drm syncobjs and obtain the array of
> memory_address/fence_value combintion which are returned to
> userspace.
>
> v2: (Christian)
>      - Install fence into GEM BO object.
>      - Lock all BO's using the dma resv subsystem
>      - Reorder the sequence in signal IOCTL function.
>      - Get write pointer from the shadow wptr
>      - use userq_fence to fetch the va/value in wait IOCTL.
>
> v3: (Christian)
>      - Use drm_exec helper for the proper BO drm reserve and avoid BO
>        lock/unlock issues.
>      - fence/fence driver reference count logic for signal/wait IOCTLs.
>
> v4: (Christian)
>      - Fixed the drm_exec calling sequence
>      - use dma_resv_for_each_fence_unlock if BO's are not locked
>      - Modified the fence_info array storing logic.
>
> v5: (Christian)
>      - Keep fence_drv until wait queue execution.
>      - Add dma_fence_wait for other fences.
>      - Lock BO's using drm_exec as the number of fences in them could
>        change.
>      - Install signaled fences as well into BO/Syncobj.
>      - Move Syncobj fence installation code after the drm_exec_prepare_array.
>      - Directly add dma_resv_usage_rw(args->bo_flags....
>      - remove unnecessary dma_fence_put.
>
> v6: (Christian)
>      - Add xarray stuff to store the fence_drv
>      - Implement a function to iterate over the xarray and drop
>        the fence_drv references.
>      - Add drm_exec_until_all_locked() wrapper
>      - Add a check that if we haven't exceeded the user allocated num_fences
>        before adding dma_fence to the fences array.
>
> v7: (Christian)
>      - Use memdup_user() for kmalloc_array + copy_from_user
>      - Move the fence_drv references from the xarray into the newly created fence
>        and drop the fence_drv references when we signal this fence.
>      - Move this locking of BOs before the "if (!wait_info->num_fences)",
>        this way you need this code block only once.
>      - Merge the error handling code and the cleanup + return 0 code.
>      - Initializing the xa should probably be done in the userq code.
>      - Remove the userq back pointer stored in fence_drv.
>      - Pass xarray as parameter in amdgpu_userq_walk_and_drop_fence_drv()
>
> v8: (Christian)
>      - Move fence_drv references must come before adding the fence to the list.
>      - Use xa_lock_irqsave_nested for nested spinlock operations.
>      - userq_mgr should be per fpriv and not one per device.
>      - Restructure the interrupt process code for the early exit of the loop.
>      - The reference acquired in the syncobj fence replace code needs to be
>        kept around.
>      - Modify the dma_fence acquire placement in wait IOCTL.
>      - Move USERQ_BO_WRITE flag to UAPI header file.
>      - drop the fence drv reference after telling the hw to stop accessing it.
>      - Add multi sync object support to userq signal IOCTL.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 454 +++++++++++++++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  29 +-
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>   5 files changed, 484 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 844f7b5f90db..5892a4c1a92e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2918,6 +2918,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index f7baea2c67ab..6fb75cc1d20c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -25,6 +25,7 @@
>   #include <linux/kref.h>
>   #include <linux/slab.h>
>   
> +#include <drm/drm_exec.h>
>   #include <drm/drm_syncobj.h>
>   
>   #include "amdgpu.h"
> @@ -102,8 +103,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>   {
> +	struct amdgpu_userq_fence_driver *stored_fence_drv;
>   	struct amdgpu_userq_fence *userq_fence, *tmp;
> +	unsigned long index, flags;
>   	struct dma_fence *fence;
> +	struct xarray *xa;
>   	u64 rptr;
>   
>   	if (!fence_drv)
> @@ -114,15 +118,25 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   	spin_lock(&fence_drv->fence_list_lock);
>   	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
>   		fence = &userq_fence->base;
> +		xa = &userq_fence->fence_drv_xa;
>   
> -		if (rptr >= fence->seqno) {
> -			dma_fence_signal(fence);
> -			list_del(&userq_fence->link);
> -
> -			dma_fence_put(fence);
> -		} else {
> +		if (rptr < fence->seqno)
>   			break;
> +
> +		dma_fence_signal(fence);
> +		/*
> +		 * Walk over the fence_drv xarray and drop the old wait ioctl
> +		 * fence_drv references.
> +		 */
> +		xa_lock_irqsave_nested(xa, flags, SINGLE_DEPTH_NESTING);
> +		xa_for_each(xa, index, stored_fence_drv) {
> +			__xa_erase(xa, index);
> +			amdgpu_userq_fence_driver_put(stored_fence_drv);
>   		}
> +		xa_unlock_irqrestore(xa, flags);
> +
> +		list_del(&userq_fence->link);
> +		dma_fence_put(fence);
>   	}
>   	spin_unlock(&fence_drv->fence_list_lock);
>   }
> @@ -132,8 +146,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>   					 struct amdgpu_userq_fence_driver,
>   					 refcount);
> +	struct amdgpu_userq_fence_driver *xa_fence_drv;
>   	struct amdgpu_device *adev = fence_drv->adev;
>   	struct amdgpu_userq_fence *fence, *tmp;
> +	struct xarray *xa = &adev->userq_xa;
> +	unsigned long index;
>   	struct dma_fence *f;
>   
>   	spin_lock(&fence_drv->fence_list_lock);
> @@ -150,6 +167,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	}
>   	spin_unlock(&fence_drv->fence_list_lock);
>   
> +	xa_lock(xa);
> +	xa_for_each(xa, index, xa_fence_drv)
> +		if (xa_fence_drv == fence_drv)
> +			__xa_erase(xa, index);
> +	xa_unlock(xa);
> +
>   	/* Free seq64 memory */
>   	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
>   	kfree(fence_drv);
> @@ -188,9 +211,37 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>   		       fence_drv->context, seq);
>   
> +	xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_LOCK_IRQ);
> +
>   	amdgpu_userq_fence_driver_get(fence_drv);
>   	dma_fence_get(fence);
>   
> +	if (!xa_empty(&userq->uq_fence_drv_xa)) {
> +		struct amdgpu_userq_fence_driver *stored_fence_drv;
> +		unsigned long flags, index;
> +
> +		/*
> +		 * Move fence_drv references of old signal IOCTL calls to the
> +		 * newly created userq fence xarray.
> +		 */
> +		xa_lock(&userq->uq_fence_drv_xa);
> +		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
> +			/* Skip if the queues are different */
> +			if (stored_fence_drv != fence_drv)
> +				continue;

Hui? That looks inverted to me.

We need to store all the references to other fences drivers and *not* 
ourself.

But this should probably be checked before adding the fence driver to 
the XA instead.

> +
> +			xa_lock_irqsave_nested(&userq_fence->fence_drv_xa, flags,
> +					       SINGLE_DEPTH_NESTING);
> +			__xa_store(&userq_fence->fence_drv_xa, index,
> +				   stored_fence_drv, GFP_KERNEL);

That won't work like this. The problem is that __xa_store() can only 
drop it's own lock, but that one is nested with the one in uq_fence_drv_xa.

So you need to iterate over uq_fence_drv_xa without holding a lock or 
come up with some other idea to store the fence driver references, e.g. 
a kvmalloced() array for example.

Since the we don't want to modify userq_fence->fence_drv_xa any more 
that should work out fine.

Apart from that the patch looks like it should work.

Regards,
Christian.


> +			xa_unlock_irqrestore(&userq_fence->fence_drv_xa, flags);
> +
> +			/* Erase fence_drv reference entry from userq xarray */
> +			__xa_erase(&userq->uq_fence_drv_xa, index);
> +		}
> +		xa_unlock(&userq->uq_fence_drv_xa);
> +	}
> +
>   	spin_lock(&fence_drv->fence_list_lock);
>   	/* Check if hardware has already processed the job */
>   	if (!dma_fence_is_signaled(fence))
> @@ -240,6 +291,8 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>   
>   	/* Release the fence driver reference */
>   	amdgpu_userq_fence_driver_put(fence_drv);
> +
> +	xa_destroy(&userq_fence->fence_drv_xa);
>   	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>   }
>   
> @@ -255,3 +308,392 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.signaled = amdgpu_userq_fence_signaled,
>   	.release = amdgpu_userq_fence_release,
>   };
> +
> +/**
> + * amdgpu_userq_fence_read_wptr - Read the userq wptr value
> + *
> + * @filp: drm file private data structure
> + * @queue: user mode queue structure pointer
> + * @wptr: write pointer value
> + *
> + * Read the wptr value from userq's MQD. The userq signal IOCTL
> + * creates a dma_fence for the shared buffers that expects the
> + * RPTR value written to seq64 memory >= WPTR.
> + *
> + * Returns wptr value on success, error on failure.
> + */
> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
> +					struct amdgpu_usermode_queue *queue,
> +					u64 *wptr)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo *bo;
> +	u64 addr, *ptr;
> +	int r;
> +
> +	addr = queue->userq_prop->wptr_gpu_addr;
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
> +	if (!mapping)
> +		return -EINVAL;
> +
> +	bo = mapping->bo_va->base.bo;
> +	r = amdgpu_bo_reserve(bo, true);
> +	if (r) {
> +		DRM_ERROR("Failed to reserve userqueue wptr bo");
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_kmap(bo, (void **)&ptr);
> +	if (r) {
> +		DRM_ERROR("Failed mapping the userqueue wptr bo");
> +		goto map_error;
> +	}
> +
> +	*wptr = le64_to_cpu(*ptr);
> +
> +	amdgpu_bo_kunmap(bo);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return 0;
> +
> +map_error:
> +	amdgpu_bo_unreserve(bo);
> +	return r;
> +}
> +
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_signal *args = data;
> +	struct amdgpu_usermode_queue *queue;
> +	struct drm_gem_object **gobj = NULL;
> +	struct drm_syncobj **syncobj = NULL;
> +	u32 *syncobj_handles, num_syncobj_handles;
> +	u32 *bo_handles, num_bo_handles;
> +	struct dma_fence *fence;
> +	struct drm_exec exec;
> +	int r, i, entry;
> +	u64 wptr;
> +
> +	/* Array of syncobj handles */
> +	num_syncobj_handles = args->num_syncobj_handles;
> +	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
> +				      sizeof(u32) * num_syncobj_handles);
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);
> +
> +	/* Array of syncobj object handles */
> +	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
> +	if (!syncobj) {
> +		r = -ENOMEM;
> +		goto free_syncobj_handles;
> +	}
> +
> +	for (entry = 0; entry < num_syncobj_handles; entry++) {
> +		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
> +		if (!syncobj[entry]) {
> +			r = -ENOENT;
> +			goto free_syncobj_handles;
> +		}
> +	}
> +
> +	/* Array of bo handles */
> +	num_bo_handles = args->num_bo_handles;
> +	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
> +				 sizeof(u32) * num_bo_handles);
> +	if (IS_ERR(bo_handles))
> +		goto free_syncobj_handles;
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto free_bo_handles;
> +	}
> +
> +	for (entry = 0; entry < num_bo_handles; entry++) {
> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
> +		if (!gobj[entry]) {
> +			r = -ENOENT;
> +			goto put_gobj;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto exec_fini;
> +	}
> +
> +	/*Retrieve the user queue */
> +	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
> +	if (!queue) {
> +		r = -ENOENT;
> +		goto exec_fini;
> +	}
> +
> +	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
> +	if (r)
> +		goto exec_fini;
> +
> +	/* Create a new fence */
> +	r = amdgpu_userq_fence_create(queue, wptr, &fence);
> +	if (r)
> +		goto exec_fini;
> +
> +	for (i = 0; i < num_bo_handles; i++)
> +		dma_resv_add_fence(gobj[i]->resv, fence,
> +				   dma_resv_usage_rw(args->bo_flags &
> +				   AMDGPU_USERQ_BO_WRITE));
> +
> +	/* Add the created fence to syncobj/BO's */
> +	for (i = 0; i < num_syncobj_handles; i++)
> +		drm_syncobj_replace_fence(syncobj[i], fence);
> +
> +	/* drop the reference acquired in fence creation function */
> +	dma_fence_put(fence);
> +
> +exec_fini:
> +	drm_exec_fini(&exec);
> +put_gobj:
> +	while (entry-- > 0)
> +		drm_gem_object_put(gobj[entry]);
> +	kfree(gobj);
> +free_bo_handles:
> +	kfree(bo_handles);
> +free_syncobj_handles:
> +	while (i-- > 0)
> +		drm_syncobj_put(syncobj[i]);
> +	kfree(syncobj_handles);
> +
> +	return r;
> +}
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct amdgpu_usermode_queue *waitq;
> +	u32 *syncobj_handles, *bo_handles;
> +	struct dma_fence **fences = NULL;
> +	u32 num_syncobj, num_bo_handles;
> +	struct drm_gem_object **gobj;
> +	struct drm_exec exec;
> +	int r, i, entry, cnt;
> +	u64 num_fences = 0;
> +
> +	num_bo_handles = wait_info->num_bo_handles;
> +	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
> +				 sizeof(u32) * num_bo_handles);
> +	if (IS_ERR(bo_handles))
> +		return PTR_ERR(bo_handles);
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
> +				      sizeof(u32) * num_syncobj);
> +	if (IS_ERR(syncobj_handles)) {
> +		r = PTR_ERR(syncobj_handles);
> +		goto free_bo_handles;
> +	}
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto free_syncobj_handles;
> +	}
> +
> +	for (entry = 0; entry < num_bo_handles; entry++) {
> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
> +		if (!gobj[entry]) {
> +			r = -ENOENT;
> +			goto put_gobj;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r) {
> +			drm_exec_fini(&exec);
> +			goto put_gobj;
> +		}
> +	}
> +
> +	if (!wait_info->num_fences) {
> +		/* Count syncobj's fence */
> +		for (i = 0; i < num_syncobj; i++) {
> +			struct dma_fence *fence;
> +
> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> +						   0, 0, &fence);
> +			dma_fence_put(fence);
> +
> +			if (r || !fence)
> +				continue;
> +
> +			num_fences++;
> +		}
> +
> +		/* Count GEM objects fence */
> +		for (i = 0; i < num_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
> +						AMDGPU_USERQ_BO_WRITE), fence)
> +				num_fences++;
> +		}
> +
> +		/*
> +		 * Passing num_fences = 0 means that userspace doesn't want to
> +		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> +		 * userq_fence_info and return the actual number of fences on
> +		 * args->num_fences.
> +		 */
> +		wait_info->num_fences = num_fences;
> +	} else {
> +		/* Array of fence info */
> +		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
> +		if (!fence_info) {
> +			r = -ENOMEM;
> +			goto exec_fini;
> +		}
> +
> +		/* Array of fences */
> +		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
> +		if (!fences) {
> +			r = -ENOMEM;
> +			goto free_fence_info;
> +		}
> +
> +		/* Retrieve GEM objects fence */
> +		for (i = 0; i < num_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
> +						AMDGPU_USERQ_BO_WRITE), fence) {
> +				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +					r = -EINVAL;
> +					goto free_fences;
> +				}
> +
> +				fences[num_fences++] = fence;
> +				dma_fence_get(fence);
> +			}
> +		}
> +
> +		/* Retrieve syncobj's fence */
> +		for (i = 0; i < num_syncobj; i++) {
> +			struct dma_fence *fence;
> +
> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> +						   0, 0, &fence);
> +			if (r || !fence)
> +				continue;
> +
> +			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +				r = -EINVAL;
> +				goto free_fences;
> +			}
> +
> +			fences[num_fences++] = fence;
> +		}
> +
> +		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
> +		if (!waitq)
> +			goto free_fences;
> +
> +		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
> +			struct amdgpu_userq_fence_driver *fence_drv;
> +			struct amdgpu_userq_fence *userq_fence;
> +			u32 index;
> +
> +			userq_fence = to_amdgpu_userq_fence(fences[i]);
> +			if (!userq_fence) {
> +				/*
> +				 * Just waiting on other driver fences should
> +				 * be good for now
> +				 */
> +				dma_fence_wait(fences[i], false);
> +				dma_fence_put(fences[i]);
> +
> +				continue;
> +			}
> +
> +			fence_drv = userq_fence->fence_drv;
> +			/*
> +			 * We need to make sure the user queue release their reference
> +			 * to the fence drivers at some point before queue destruction.
> +			 * Otherwise, we would gather those references until we don't
> +			 * have any more space left and crash.
> +			 */
> +			r = xa_alloc(&waitq->uq_fence_drv_xa, &index,
> +				     fence_drv, xa_limit_32b, GFP_KERNEL);
> +			if (r)
> +				goto free_fences;
> +
> +			amdgpu_userq_fence_driver_get(fence_drv);
> +
> +			/* Store drm syncobj's gpu va address and value */
> +			fence_info[cnt].va = fence_drv->gpu_addr;
> +			fence_info[cnt].value = fences[i]->seqno;
> +
> +			dma_fence_put(fences[i]);
> +			/* Increment the actual userq fence count */
> +			cnt++;
> +		}
> +
> +		wait_info->num_fences = cnt;
> +		/* Copy userq fence info to user space */
> +		if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
> +				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> +			r = -EFAULT;
> +			goto free_fences;
> +		}
> +
> +		kfree(fences);
> +		kfree(fence_info);
> +	}
> +
> +	drm_exec_fini(&exec);
> +	for (i = 0; i < num_bo_handles; i++)
> +		drm_gem_object_put(gobj[i]);
> +
> +	kfree(syncobj_handles);
> +	kfree(bo_handles);
> +
> +	return 0;
> +
> +free_fences:
> +	kfree(fences);
> +free_fence_info:
> +	kfree(fence_info);
> +exec_fini:
> +	drm_exec_fini(&exec);
> +put_gobj:
> +	while (entry-- > 0)
> +		drm_gem_object_put(gobj[entry]);
> +	kfree(gobj);
> +free_syncobj_handles:
> +	kfree(syncobj_handles);
> +free_bo_handles:
> +	kfree(bo_handles);
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index c3e04cdbb9e7..1b75900fc782 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -37,6 +37,7 @@ struct amdgpu_userq_fence {
>   	 */
>   	spinlock_t lock;
>   	struct list_head link;
> +	struct xarray fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   };
>   
> @@ -65,5 +66,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 73d225aa3e1e..404c39073661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -28,6 +28,32 @@
>   #include "amdgpu_userqueue.h"
>   #include "amdgpu_userq_fence.h"
>   
> +static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	unsigned long index;
> +
> +	if (xa_empty(xa))
> +		return;
> +
> +	xa_lock(xa);
> +	xa_for_each(xa, index, fence_drv) {
> +		__xa_erase(xa, index);
> +		amdgpu_userq_fence_driver_put(fence_drv);
> +	}
> +
> +	xa_unlock(xa);
> +}
> +
> +static void
> +amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
> +{
> +	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
> +	xa_destroy(&userq->uq_fence_drv_xa);
> +	/* Drop the fence_drv reference held by user queue */
> +	amdgpu_userq_fence_driver_put(userq->fence_drv);
> +}
> +
>   static void
>   amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   			 struct amdgpu_usermode_queue *queue,
> @@ -37,7 +63,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>   
>   	uq_funcs->mqd_destroy(uq_mgr, queue);
> -	amdgpu_userq_fence_driver_put(queue->fence_drv);
> +	amdgpu_userq_fence_driver_free(queue);
>   	idr_remove(&uq_mgr->userq_idr, queue_id);
>   	kfree(queue);
>   }
> @@ -405,6 +431,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   	queue->doorbell_index = index;
>   
> +	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to alloc fence driver\n");
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index d3738f645adc..27e1617b234f 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -48,6 +48,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_userq_obj	db_obj;
>   	struct amdgpu_userq_obj fw_obj;
>   	struct amdgpu_userq_obj wptr_obj;
> +	struct xarray		uq_fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   };
>   

