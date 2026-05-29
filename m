Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97DACD6E50
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 15:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4DA1120E8;
	Fri, 29 May 2026 15:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WucIm9/z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096851120E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qg+56FG9pSMZoC4eFqij3Q9wt1NS7h6O3RipZH4ajZD9SJQaCKm4yoLTbH8x+EVDfMX89xZaGZjJ0r9QT8W6chPbfFs15ChavKiyJdUBUXeXkZsy6xPWgsA3IuIlumEYQOSx/59ZQ5v2AGiyuGYTxONcCf+74Y1T67aEs1cirpXPBsU0s3VO3ps6aE+cooeWkoT3jeudofD4C33tptTqV8JX2rLgAjWfh1B7wX6nRhXFTa5jfQ1ZjgZcU8z9nabvB7nS555FQgQZXZM5UgauQ5yhtElxnfCfcDkH3jMY/DupUiAwmDTz8RjdY+ZYRy3gaaeGiI2s5fJN0ZpLUgdxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUnHzc26MYXsGel4YSmiPO4Hzc3PaktsTwlD+ziL0gQ=;
 b=MqZ6J9gguILSHp1oR3WL6EP5aMkATxVxL6mUYaVQgXr2UjDhpsSYzDkjclLWcWmYgoqilABNderT1z0J25CLBiUrWbeggtfMpSGoNz2aNRhsTD+7XNHozj4ibjE9dYZlryCdSF49DeWetC0wdQRugT2wSW/CbcfdxVH+vDSwM464nxPwMad3GjuCxJU4RszQPgWW9yrmUhwFO64EMSZEaS1Ti95rYBCvtBpXBql4i67fApy5ZH+CNyb7haQKZhWKnnMkxnPJ3L85XYskYwP08Plav02ZACxsLyr3zIVd1wIi8cZCYka49fyw/8d9w1PjVjq+Tbm3Y3K5txQoTxbihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUnHzc26MYXsGel4YSmiPO4Hzc3PaktsTwlD+ziL0gQ=;
 b=WucIm9/zoMoU4+SvwGXzOUlLr9sTDgHeZG0157zudAx/3YOPiH6I3t1c970Cc8451wW3kJBfh2fYXT7JDPa7jTrHQUvyaf4rcvXhmskimlBW0d0hpFEfhBk4S609Z8IzsPEwsrUNXn1CX0TNweNnUorH1ksxzmg/vscf3gbBpJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Fri, 29 May 2026 15:27:10 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 15:27:09 +0000
Message-ID: <2965a42a-777e-4042-a048-c12a8118fd0b@amd.com>
Date: Fri, 29 May 2026 11:27:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable execute permission fault reporting on
 GFX 10.1.x
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260529014508.115012-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260529014508.115012-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::10) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ff206d-a841-4686-6120-08debd96bfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aI9nSFOl4I5T9pp9NV5bgbGBWotxIVofQtty8IdQsO0TdVeZPl5KSuVKX38sd5u9u3n8hk1HWN5oQTPisNgGDk6dcWNtFQ0GJFBcHKYWukN2AskEg8VzmocZIxPtZ1st6ZGRVNczeZcgWHAryLMHnRWbVHssqMbMPnGcw3yebV4eadg7hGiLbhEaiGsJrMLryadn7/mfn1v5Ug2PW7Lhg6Gb2hMsW9KXezVpKsShXoMt4/bzGvpZMkjRE87FFN3C/atD1NLK3kpHold2ZifEeA2YxLxFAPnwuOylqVEkjP0C+0LzXxv+uwAr5kC5vcAu8UNGq+MS+obfCqsZ+aM0pb/ezwQoVlWoq3+kjSfUc7jhZOPL0YSfTtMNk66nfBoe2S0LZmr1e4L05QZsLj/aQIN3TihalZVJii6oAYooZvRufgdyV3Vkgp+mhs+TMqXonI7nrT6DvNFjIbqsegrjMrTHenAt2v+z7JIVThBbBzN1ndrnxfoX67WlQYkGPTHZryJ4r9TvPA+0PIKpLK4eFqW6l8MRMFfQZfZV1Pt00V4bjedeJyff+wuqVx/Wx6RcCP81AxgGNUQgpfjDpTtSjE8dk+uNmdNjqLxMv8CM33MoiehxPd2mRwKAVyEHobayZanDgSotL2sXo3Vnr+0a4ibngbYt6VyP3mx83he/7f9+U3XwFxaaRQZ3atWVXsxZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MldHNGRJL2ZsLzQzanhZZm1DTHpYSG5VRFBMSS8xK1RYT2M5c3lydjBhUCtU?=
 =?utf-8?B?a2cyT1N4ZXhuMVNYWkxPcVlabHV5dmF6MFF4TXpsaHhnNUtRK1pMSnBObFRF?=
 =?utf-8?B?TUpwZEpacTA2UzRzYkFtVnVSNjM3L1dsL0p5b1p2bmpuUjc5djZ6bTUrNXBi?=
 =?utf-8?B?OG5PdUo0QzB6TG9pN3YwVUZ1TTk4U0Y2ZUtoNTA2aDBEaG9ZWW1tbW1nKzNj?=
 =?utf-8?B?NlV6cXEvekNHVGlwMTdEbXZMNkdQU29HaGtNeTlYNnNMcXM2bjJMT3F0M0py?=
 =?utf-8?B?MCt6WE5zMUY1QWRPVHQ5TmRSZzd6WFUyK0E5aElSTHgxUzdTYzg5d1pqbGFT?=
 =?utf-8?B?STF4WWdFd3JlTjkyN0pmRjlnZ1M3dVppYTFSbUJJTG10NW1xNStkZHlVYkJF?=
 =?utf-8?B?NmFIb0hWRWhjUTRGTWFvejRITVRLS0tDam4ySEtiNmxUZXB6c0lZRDBHbGRp?=
 =?utf-8?B?SlZSZStTNXBjcTJEWFU3TXJsMTJiZ0JKdjZWMytSWkxqZE04d0hFZmFZR1Fs?=
 =?utf-8?B?MVZ3dHdtdkJkNFdMSXRobDdHYTZMczlwTk41RUd3MUJ4TWo5L0RCbkdabElO?=
 =?utf-8?B?TXpIYUR3S3d4MGFNdXRtd09KNTBLOTJqSG1TVi9ZTFo5ZXJjWjVIT1NucGxz?=
 =?utf-8?B?d1Z1QlRhcmVqUlhoaWowS3FvU0haS3dNSTI3RCs4eUxqQ3grbkc4dzJEUmJn?=
 =?utf-8?B?NHdyOS90SW5NcHJSUTN6eC92M2kxOUxzN0swcFk0UXNSYmpSYy9aSTdXd0tR?=
 =?utf-8?B?MGJma05XRDBjVDk1OStPZnFoRytRME84M2JZa0YvN3RPaHFMK1lQT21vWTdU?=
 =?utf-8?B?NGZYL2RsYitOVE5KUUdMVm9Zb2lnSUd5Y2pxYmlGVW9PdWgzZzdodUVWcWtE?=
 =?utf-8?B?MkptZENObDA3WVpLMWc3MTBNTGNSUTVqSkdKeUlUSFo3SXo3ZFNPVGp2L3BL?=
 =?utf-8?B?RURrQzdhNnlYUm0yNVVSQzc4Y3JHMWgvQ2V1VmRJYkt2TXMzRndiNTJDRVVU?=
 =?utf-8?B?Mlp3SStDWnU0Y1dPb2xmWnJBNlRsdnlHZldGRmZxb0VnMVViYW56R2pFYUNo?=
 =?utf-8?B?V1JHSVlVU0FwdE9ncERWR0FhNUVTOWFtbE1ORkdDazNrRjVYbVpVUU12bVhR?=
 =?utf-8?B?dytyb1R5WjVFMzI1elFzTlZCRnRkRDcxTVIzNzU3U0FIU0lod0RsODJqckQz?=
 =?utf-8?B?NHFNM2lrdGxvc1hRdzdyeFdZOFA4V0JTMEVLTktXd3o5c2FSUjM4a2pMZFpG?=
 =?utf-8?B?d3FLTnRXOEgwK1pPSENMQk12QVRBakN5akN0TEEvTWhpdWEzNnUzNitBSlpQ?=
 =?utf-8?B?T0pzMkRDRzkrSkdvL1ZMWmVwUVVVcnZMZlZTdTE5ZnVEcWtVNnJlRDE3WFUr?=
 =?utf-8?B?V3hGbDRXNXhNVzhWdUZvU0hyQkhrc3dhQ3d3dnc5VWEzN1luT0xxekg4VlF3?=
 =?utf-8?B?eisraVdYcUp2V3kvRGpYeUhkbEtIcEdMTmZVUDhyNHc0R0htb2NrMXRmeUZw?=
 =?utf-8?B?MVlhVk90dlpvRlRlUGEyN0VWcUNFQzVWZHQ5ZHlQOUw1elNMZ0dEbWRkemFx?=
 =?utf-8?B?S3p1RlZkRmNFNldYLzdTZHFuVURtbjNiTTNNazlzSnpEZXk0dytuYVJGT1Bv?=
 =?utf-8?B?aUh5ZHJ4aTB1TWZFeUxBcjl6cWJkZFUvbTRxcEJicFNpN0ZRaGpkQWJDeUdv?=
 =?utf-8?B?R1hQL1BaNmpRc2JNWTZzOENEejJLWncrY21rS1NOc0QrTkxnYWwyZXVqNXZG?=
 =?utf-8?B?Q29TUlZZYklHc0g0a09zTm1JQ2IwSUxEVWIzYXRRb25qY1J5NFNGMmN4b21k?=
 =?utf-8?B?Vk5FSlI5RkhBNFEwSGhhdTJCTHVDeThKUlZrYUZRTEw2UWovMml6SExzR1Zm?=
 =?utf-8?B?YURxKzVJcHhlR3dUcFhpRWY0RnFzZTlLS3BqeEErRFU4YUFsRXg2VjRTS25q?=
 =?utf-8?B?SFNnZlB4dWJQMnFZL1hrang2Ylc1ZDZoTWo1Rmc2Z05xS2FHYVRKSHZWUU5W?=
 =?utf-8?B?QllsUFhzbi9mUUZMcnRkWFIrNHlYeW4yVmVsSHN2RHNEV1hWdS80VnNOSkV3?=
 =?utf-8?B?M2o5em50U1MrV0F2ZFFjNG9iNU1ZWVZkOFpQNko3eG1ubWFSdi9lT2F2RkJ0?=
 =?utf-8?B?dXcvbjFXd01PWkM2NkxKVENZd0pFSzlLWERRdWNsbFNZWWdQam0wVkp1SDZn?=
 =?utf-8?B?eEdpZHNodWtuNFZDRFpQWGN4a2hhazZyRHpoZEJlbTlUeElNOWFuTUlCN2dF?=
 =?utf-8?B?SDJzSTJkWnNtcHVTR0JTRmhSQWkwMlM5bmJZMmE0NmFkck1HY0FoRmdkQmg5?=
 =?utf-8?B?VVFKNUFtS1dHaXlaVVUzTFFQRzVDNE56TWxKK3E2MzVYNWxydWpNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ff206d-a841-4686-6120-08debd96bfcd
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:27:09.6163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XifG/LDfU9IxNw1u/01b60I42PBHyRznlULTZQiWZRVuGbYEkd1BwSAlWrshdhSrWA9ljLK6feP+FloLJBnesA==
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

I agree with setting noretry=1 for any GFX10.x.

I don't really understand why execute faults need special handling with 
noretry=0. If a recoverable fault turns out to be non-recoverable, it 
should be turned into a no-retry fault, which should result in a page 
fault message in the kernel log. Is this not happening for execute 
faults? Why?

Or is the problem you're trying to fix, that you lose information about 
the nature of the fault? I.e. when we replace the PTE with a 
no-retry-fault encoding, do we lose information that the original PTE 
was specifically lacking EXEC permission?

Your extra logging changes are also specific to GFX10. Does this mean 
the problem is GFX10-specific? If it's not GFX10-specific, and extra 
logging is really justified, I would expect it to happen for all GFX 
generations (that support some form or retry faults).

Regards,
   Felix


On 2026-05-28 21:44, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Problem
> =======
> On GFX 10.1.x (Navi10, Navi12, Navi14), execute permission faults are
> completely invisible. When a GPU buffer is mapped without VM_PAGE_EXECUTABLE
> and the CP attempts to fetch shader instructions from it, the hardware
> enters an infinite retry loop with zero diagnostic output:
>
>    - No interrupt is generated
>    - No dmesg message appears
>    - The CP silently stalls until the scheduler timeout fires (~10s)
>    - The only symptom is unexplained GPU job timeouts
>
> This was discovered using the IGT amd_close_race stress test when
> VM_PAGE_EXECUTABLE was intentionally removed from IB buffer mappings.
> The GPU would hang for ~8 seconds per job with no fault information,
> making it impossible to diagnose the root cause from kernel logs alone.
>
> Root Cause
> ==========
> GFX 10.1.x defaults to RETRY_PERMISSION_OR_INVALID_PAGE_FAULT=1
> (noretry=0). With retry enabled, UTCL1 handles permission faults
> locally: it keeps re-requesting the translation from UTCL2 in a
> tight loop, hoping the PTE permissions will change. Since they never
> do for a genuine execute permission violation, this loops forever.
>
> Crucially, UTCL1 never propagates the fault to the interrupt handler
> (IH) ring -- the L2 protection fault interrupt is never generated.
> The gmc_v10_0_process_interrupt() handler is simply never called.
>
> GFX 10.3+ already defaults to noretry=1 (set in amdgpu_gmc_noretry_set),
> which makes ALL permission faults generate immediate L2 protection fault
> interrupts. GFX 10.1.x was the only remaining generation where this
> problem existed.
>
> Fix
> ===
> 1. Extend the noretry default to include GFX 10.1.x by changing the
>     threshold from IP_VERSION(10, 3, 0) to IP_VERSION(10, 1, 0) in
>     amdgpu_gmc_noretry_set(). This aligns Navi10/12/14 behavior with
>     all newer GPU generations.
>
> 2. Add explicit execute permission fault logging in
>     gmc_v10_0_process_interrupt() so that when an execute fault
>     arrives (whether via retry or non-retry path), it is clearly
>     identified as an execute permission violation rather than a
>     generic page fault.
>
> 3. Add execute permission fault detection in the KFD interrupt
>     handler (kfd_int_process_v10.c) to extract and log the EXE bit
>     from the IH ring entry source data.
>
> With noretry=1, the fault path becomes:
>    CP fetch -> UTCL1 miss -> UTCL2 lookup -> PTE found but no X bit ->
>    L2 protection fault interrupt -> IH ring -> gmc_v10_0_process_interrupt()
>
> The L2_PROTECTION_FAULT_STATUS register then shows PERMISSION_FAULTS=0x8
> (execute bit), and the handler prints the faulting address, process name,
> VMID, and PASID.
>
> Test Results (Navi10, IP_VERSION 10.1.10)
> =========================================
> With amd_close_race test (VM_PAGE_EXECUTABLE intentionally removed):
>
> Before fix:
>    - Zero fault messages in dmesg
>    - CP stalls for ~8s per job, scheduler timeout kills process
>    - No way to identify execute permission as the cause
>
> After fix:
>    amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:64 vmid:4 pasid:592)
>    amdgpu 0000:03:00.0:  Process amd_close_race pid 13380 thread amd_close_race:13384
>    amdgpu 0000:03:00.0:   in page at address 0x0000000040001000 from client 0x1b (UTCL2)
>    amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_STATUS:0x00700881
>    amdgpu 0000:03:00.0:      PERMISSION_FAULTS: 0x8
>    amdgpu 0000:03:00.0:      MAPPING_ERROR: 0x0
>    amdgpu 0000:03:00.0:      RW: 0x0
>
>    - 200 fault interrupts correctly fired during stress test (20 rounds)
>    - PERMISSION_FAULTS: 0x8 = execute permission violation
>    - Full process identification available
>    - No regressions with normal (properly-mapped) GPU workloads
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 23 +++++++++++++++++--
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  |  9 ++++++++
>   3 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 13bec8461cde..a9bb01c6cb58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1014,7 +1014,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>   				gc_ver == IP_VERSION(9, 4, 3) ||
>   				gc_ver == IP_VERSION(9, 4, 4) ||
>   				gc_ver == IP_VERSION(9, 5, 0) ||
> -				gc_ver >= IP_VERSION(10, 3, 0));
> +				gc_ver >= IP_VERSION(10, 1, 0));
>   
>   	/* For GFX12.1 B0, set xnack (retry) on as default */
>   	if (gc_ver == IP_VERSION(12, 1, 0) && (adev->rev_id & 0xf) == 0x1)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 8523833a74fb..554f514e59f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -102,6 +102,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   {
>   	uint32_t vmhub_index = entry->client_id == SOC15_IH_CLIENTID_VMC ?
>   			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
> +	bool exe_fault = !!(entry->src_data[1] &
> +			    AMDGPU_GMC9_FAULT_SOURCE_DATA_EXE);
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>   	bool retry_fault = !!(entry->src_data[1] &
>   			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
> @@ -117,9 +119,26 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	if (retry_fault) {
>   		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
>   							write_fault);
> -		/* Returning 1 here also prevents sending the IV to the KFD */
> -		if (ret == 1)
> +		/*
> +		 * For execute permission faults, always fall through to
> +		 * print the fault info. This makes missing VM_PAGE_EXECUTABLE
> +		 * mappings visible in dmesg instead of silently stalling
> +		 * the CP in an infinite retry loop.
> +		 */
> +		if (ret == 1 && exe_fault) {
> +			dev_err_ratelimited(adev->dev,
> +				"[%s] execute permission retry fault "
> +				"(src_id:%u ring:%u vmid:%u pasid:%u "
> +				"addr:0x%016llx flags:0x%02x)\n",
> +				entry->vmid_src ? "mmhub" : "gfxhub",
> +				entry->src_id, entry->ring_id,
> +				entry->vmid, entry->pasid, addr,
> +				(unsigned int)(entry->src_data[1] & 0xff));
> +			/* Fall through to print L2 protection fault status */
> +		} else if (ret == 1) {
> +			/* Returning 1 prevents sending the IV to the KFD */
>   			return 1;
> +		}
>   	}
>   
>   	if (!amdgpu_sriov_vf(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index 19406ab92c5b..800592bc908c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -360,6 +360,15 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
>   		info.prot_valid = ring_id & 0x08;
>   		info.prot_read  = ring_id & 0x10;
>   		info.prot_write = ring_id & 0x20;
> +		info.prot_exec  = ih_ring_entry[5] & 0x10;
> +
> +		if (info.prot_exec)
> +			dev_info_ratelimited(dev->adev->dev,
> +				"KFD: execute permission fault "
> +				"(vmid:%u pasid:%u addr:0x%llx src_data1:0x%x)\n",
> +				vmid, pasid,
> +				(uint64_t)info.page_addr << PAGE_SHIFT,
> +				le32_to_cpu(ih_ring_entry[5]));
>   
>   		memset(&exception_data, 0, sizeof(exception_data));
>   		exception_data.gpu_id = dev->id;
