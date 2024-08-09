Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F1DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 23:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8E810EA38;
	Fri,  9 Aug 2024 23:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W5MxB+F1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7818A10EA38
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 23:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh30K/fzFhCtbUQppeUhivpWL8HA4pDhDzov0AsVcFEowRDPg7UcAA/ppZkSSSjLiNpnlzsh3oc7bVB7ZYts5ylz7sIwviFFSAEOQSV/5996aSZB0Ns7T+ylm8tkgIOmL/cwcdKRxOaP/LEPmSI/FpYPPXJdHVitJCyUR3RKd8LFwPD1/yQ7d+1r5KvlEO/3RlaGjb84ShiDHZq99ZuFKiUOEqg3KjFnmybvtm2Seo+wl5qDj/2Yv7ZALPDfngJoZh6ruEmN9Y/MPPqwcrTYscB8vCmj7ogd1Utmn7CYGn3J6R+k7/Obh+zuB/Hpuv4KeJyokWRnWxBrDHYVT50q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2d8EFRwa8743moFc0lbx1f6YLI2/d1wQPx0B+4Jptw=;
 b=TaRVHBR9Z7GJyPqp4z3xM5+tpnnvU/aomwySycE2TlgjuBeMxnH4uhOU433wLutv1TbArVBN02zt8q5GTFJEI/pLCd2kYMVH1pIjz71yJD7AqrvKXVlesrtGGbd3QgJj4qPdv6dBcd49rplGz1r4NiU404VGg21IBkWQ42xy66vNEcFSNYrnGlkLL9KywGIDZGyy7VkxMiLSjlap7tWekx/wEKHYeTgEA+oJJYS5SyaSnW23rUZ1jPK0fbiFrTcZUJqwUhEiXiixswsyU7/2XDMBEjslZmzh3hUQuI7n/Op5b+zf/4EnBF39RXtdZHLNd48MjSFiLTj8KiyFRAWPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2d8EFRwa8743moFc0lbx1f6YLI2/d1wQPx0B+4Jptw=;
 b=W5MxB+F1mvK0vXPwk1KDd520oTBcYDHuC/PastoxvfkdNqc/kQLnvTEHY6MuA4pioJIr64nr1PGzICFA0QjNf3B2nRkdNDb5OTFIRh5ooRHWZLEarYPo11JPqrLJGSn2hbXr2PQpV8GXg6fB9rH2dkjfmI9ia0SUzzY0XShYkKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 23:49:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 23:49:02 +0000
Message-ID: <9dcd8afe-5c96-4ef7-ba5d-8b1d4c47b66a@amd.com>
Date: Fri, 9 Aug 2024 19:49:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
To: amd-gfx@lists.freedesktop.org, Samuel Zhang <guoqing.zhang@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20240807083624.1729349-1-guoqing.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240807083624.1729349-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: e9403fa7-fe93-49df-cc89-08dcb8cdd8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWRJdzNxY1lFK3dPczJhbkszL01VcUlVOUFNdmUxeFN5WURGRlM5NW13THdW?=
 =?utf-8?B?U2RpamhmQjJSVzY2cEd0d2tWRis5N1NUS0Y5UTMyNTBHLys3L2FkdEtUaE1C?=
 =?utf-8?B?aThLSXE3RkJkQVRKUnJzWnVUOVlnbDVWWVhlQU1nZnZBbFQwZkUwYW54NUpx?=
 =?utf-8?B?S0MzeDdveTRrNUlraFduVFdaN0grZjZyNFIyUjdVSkhmWGlrdjZ6Q0FoM1lP?=
 =?utf-8?B?b1lxS2lESUZBS0ZjOE9vZ3JYUklDQjI0Ty9yQ1N0WUV5S3FQSmc0b0ZyT09H?=
 =?utf-8?B?R0RrV0xtUlZRQmM2Z0xheURDN2dWTXRNdmpkS1JKL1d5VmNYR1gweXlNbnBp?=
 =?utf-8?B?dTVqOGZjWW0vdUJ1cHdtbjBudTMrTFAvS3h5QzRDWnprNG9pcnU5cG11SE5H?=
 =?utf-8?B?UGY4aFdQRys1MlZManVzQS92U0RPUFFaMi9MdXNZKyt3UVFUSWZiSGVWaytG?=
 =?utf-8?B?aE4rTEdYMDZiTUVVKzlRREZBYXBTcWJmQUcyVElKMmVyRWVpNVcyenE2L2hK?=
 =?utf-8?B?ZEE3NStnMmlLdVErb0E1T0N3YklaUE85QkVtUEU3OEpFWHFnRFAvZUJjbUlu?=
 =?utf-8?B?bE5jb3ltUGpkckJmbmpBNGVWbzY5L2QzOFZJWWUvd0VUa3QxbjJlc0g2WTRU?=
 =?utf-8?B?c3VlbUZzbXNuVDF6cFRyb0VPU2x1UkNLa1VndC9pUWk5NWRqem5iZy8wZWkx?=
 =?utf-8?B?N3RLRVNUbE9PUXpXTnVieGd0RVN5Q1dodnU3NmZNM2V4aEJjY2xtM1dqN25m?=
 =?utf-8?B?dHozbFRjNHd4OHo1UStTK2ptbEhJM1NKbDdvT2kvS2hkM1NlcFlGN05PTXg0?=
 =?utf-8?B?NHEzRXhmZHlYdHRqdTF3YjNoazNsSVRPUzY3b0V5YWtXMEZLcU9ZRktuK013?=
 =?utf-8?B?YjBhWkhQbnNsVDh2SjhXU29tU2E0KzFNMFZudkJWSXF2VUMxcUZod0VnWnZN?=
 =?utf-8?B?Zmx1OUluSUwxQmtuaVd1NTBXZExTRnlPakEvRjBtdEJvVWhYVm1JY1B1Uk9D?=
 =?utf-8?B?N1FoN05OVnY3OXRKaDYzWWJGaUR1andla29td2FjZWh1SGNXNzhIdXF4UEJl?=
 =?utf-8?B?a0lFQWFnS1BYK2JaMEtFSDRpMGJ1ZkJzRlZ6bWNFRFBCQk9zTWFoNVNDSWtt?=
 =?utf-8?B?SE41Q0EzL2pLc3FvVGdoWU5LTzBsNWMvdS9iUkNzRndnKzhOVUJOT0VRdG1R?=
 =?utf-8?B?Tk1EU0Y5c0FsTEpPSVZaTkhKNWY4WHBPYmpadzRDZi9lTnBUK20xb1pyR3Vj?=
 =?utf-8?B?V0FlbnBRd2FoaGNLZ0s5d0phZVVWVERMTUhZeitMV0hCRlE3bTl6RGU2WDd2?=
 =?utf-8?B?UUVHdkZZU0d2UTMyV3VYdndKTzBiT2R1MEsxbC8waTRlb3pTcTJnNG1EVk40?=
 =?utf-8?B?VmxXTUpZTHNLQXBXQ2J2OTZ3L3N5anQvcjhLeHplV01ETVJLSThxZ0NZLzdy?=
 =?utf-8?B?Q1Y0Q1Bva1lwcGpySHdBNFZFazB5bnBXa3RXN2hRcWlxYnMyUlFwVjl4eWN6?=
 =?utf-8?B?NUFkbHlWdmpvODlxK2dlTkcrVFRnWC9iNkxUTTJLdUFoWGVGV3hTWTBjVWxO?=
 =?utf-8?B?QlJ5SC91R2JnQjN6M0EwcXpzVjM5NXVLTWFQTVlHTWJESDlJM0VBajFEanRm?=
 =?utf-8?B?alE0SHlocS9SYjdhMFp6aEhuanpydzR1dVRrbG5ONFpkNDJPSGtMeEc5akFx?=
 =?utf-8?B?TVV2RjRwS3kxZkJhK0xBYzcwbEplbHhab2xERmJBUmJSRkVpQmRlcDFsdEQy?=
 =?utf-8?B?VUtQQ3FwVm9BNWtucTlKNXp6SWJVclhJVFRFQVBheXAwYWo3SnJDRFRrKy81?=
 =?utf-8?B?U3VMNmh4RlhSRHhhN0ZTUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1d5VkplWGZhbHNpdXR0NFZ0djErbkppN1BkRHcrNDVyUHFFTGZuSVFMSG1D?=
 =?utf-8?B?RkpvajJ2OTA2VnVsZkZKRmswSm5RRVJKN1YyUGk3NXdrV2VTM2swdGJzSklC?=
 =?utf-8?B?OVgzd3hvR3lvbDZHQ2cxcXVYMmZYanlibksrOWRhNVNMLzh5QXFFa0t3dVRC?=
 =?utf-8?B?aTZnSE1BcURGbVN6RzZIKzBDUkpqSExjTzUwZEJodnZheGNRQWVUVnJ5MGNI?=
 =?utf-8?B?bmNlTVM0TFFYWFFKZGVkZ1VuLzVxSGYzZWRwT25NV2ZoYXhwOTZYZVdpLzJp?=
 =?utf-8?B?SURUOG5scVMyYW5ITVB3QXQvZS9yZU8vVm9zMEx1N0NyR1lsWjZUK0R0alkw?=
 =?utf-8?B?dzFmelNnVUJ2MllzU3U2TVpNWFp6cXhxUE1UK2JuS1VSNWNFRlN1VkhiOEYr?=
 =?utf-8?B?dWlQNjFBOGpqT0FCQ0dhWEswK3dwNDF1M045cXhuRkk3SExSMENEOTQ2OStG?=
 =?utf-8?B?cW0vRy92VHZUVncwUDRDZU1PbnZHNjF2TUpZQ21oYzBXa3ZYR3A2Z05TOTJV?=
 =?utf-8?B?Zjd6WGNUZ3VZSENYNlhrcGg3K0RDWkxYakNzYWJZZ3NoMnFFOXZHczArUWRh?=
 =?utf-8?B?YjZiWEIzM0JRTENiYjRDckRaNThNeU53K2o1UVBZSVJzRHV4RDlvcC9GaFVI?=
 =?utf-8?B?Zk1rT2I4ZlhzNmhtYkpudmxoOHZaMkoxRnB3WXVnUEFBUVFBelQwUmhES1BZ?=
 =?utf-8?B?NFlWQ3F1ckNCdFJ0ZFA3QWJwRzNpc1V5R2pCTENiS2hZaGNxV1FSSVU2VnQz?=
 =?utf-8?B?WG5jaUh1TWhuZ0Y3V3hNb0FQRkVXQW1NVS96TGRCZkRsSm5qSThxRVJad3Rx?=
 =?utf-8?B?QjY4djg3N2RKZmFwRTF2V2Z2eUs4VEwra2ZSNExRZ0g5ams2K0U3KzRzYnhO?=
 =?utf-8?B?RDlKaFR2dStkWklNT2xoMTlQM0J4V0FrZmdCMnkwcm9PNEZ4OWlGOTJvMnB5?=
 =?utf-8?B?MnRLbE5kY2l1eGlXYXdHNXY4U0dOUFZDejhyN3N2eGhPWEpLT3g4RUNDK2xm?=
 =?utf-8?B?bFlVeExoV3cxUjFsRFhIbEVFcjUvRUVDNEdBNmxCVU90aURkV0tpRi8rdHo4?=
 =?utf-8?B?QjNrOGgveHRsUDRnM3EwVTVac2REWHZuY1RNbk5JblFYRjY0S0FNMktFV005?=
 =?utf-8?B?N3hLZXlaRkovZmt0ems4THZMYXBvVis2d1owWmtLcUp0TDZNU0dDUk9ST1JF?=
 =?utf-8?B?ZTR6THJyMVZCRkNoN0YvY0tpcDVRYnFWSXdRbGNUYzZrYjVtZWJGNjROWHFu?=
 =?utf-8?B?bGQ1VzFXeDlKU2NHS2N6T216Z3pWR0xEN1hjY1RNZnZDWGFwNXB0ay9RbzdD?=
 =?utf-8?B?THZSTW4rTUtYQm1CcGczaUgrUHFFaFgrSzc0L1F0cHlBSlpENUxWbDAydkIz?=
 =?utf-8?B?bUpVaE5yeEJEekh0Nmk2YnRrWktpU1h2OC9TUGNOc3h4VENGblFpTTlXZlZU?=
 =?utf-8?B?NW1MVmd5eVR3bElNN0Z0b29Mazd3K0FBQnJaWE9TeWFrSytoNDRQZjN4OFpF?=
 =?utf-8?B?elV5eXdaaFFMWWJ5ckJMclJIL1pmV3k5NnpvanZFeGJ3dE5qeXFLRTVibWgy?=
 =?utf-8?B?MnlINHhvL2dMY2NKejJLcTY0cU5obHlhVm85TUZySWczSk8zdVV6U0dKV1Rt?=
 =?utf-8?B?cExiYU0vQ05jRWdrWFNOdU8wc1RIVmc5UHV2WlF6UndNenk0TUdZT0Q0bU5D?=
 =?utf-8?B?aEpTL2kwUGU2WThxVmVzaTZ1TWpQVERCUWJOa0U2dE5YMkFBcEV6MEFtY1E2?=
 =?utf-8?B?bFdDRFlCenlHSmluVE0wd2hRODRndnZJVm4rUVo1L0xlVFIyd1hndEJySmhI?=
 =?utf-8?B?MnMvRjBIampyRFFOak51OUQrUTBlRlFUeGFhSkoydE1zQW9qMmw5R2RmdFBW?=
 =?utf-8?B?bjRnSXJlL2RvVUl4eVZqRWtkSUQ5cW0yUTBCNkdqREM3cFNHMmVZSTZXMTJo?=
 =?utf-8?B?TUFNY3lGZ2g1ak1pS0E2Y1JLRDRJeFNseWpJTGV6ZzdZUmxIQ0dieTFBajd5?=
 =?utf-8?B?VHdmZFZzL2dYUXVvWlZmTExVajRBYWFVcjVUaUtxZ0lvUWptaGN1ZkJjNUJD?=
 =?utf-8?B?aTlmTEdGaUd1MDZTQUNvbG9NVXpmSGtoSWNkc3puMkhCRitxZll5dWFaaDJ6?=
 =?utf-8?Q?XOAGU9n0LqJQ2tPA4JR1JTMCe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9403fa7-fe93-49df-cc89-08dcb8cdd8ec
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 23:49:02.8109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6TeFJ/MWNDNLAdhY3iyXGOfy2b+eAVQ6SqjVzv1XNo0uzk2PW26+ePoWDxb1c/rMBYcfJxGVa249pk0BHHsFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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


On 2024-08-07 04:36, Samuel Zhang wrote:
> Ptrace access VRAM bo will first try sdma access in
> amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio
> access.
>
> Since ptrace only access 8 bytes at a time and
> amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,
> it returns fail.
> On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write
> is blocked for security reasons.
>
> The fix is just change len check in amdgpu_ttm_access_memory_sdma() so
> that len in (0, PAGE_SIZE] are allowed. This will not fix the ptrace
> test case on SRIOV, but also improve the access performance when the
> access length is < PAGE_SIZE.
> len > PAGE_SIZE case support is not needed as larger size will be break
> into chunks of PAGE_SIZE len max in mem_rw().

I'm not convinced that using SDMA for small accesses is the best 
solution for all cases. For example, on large-BAR GPUs we should fall 
back to access through the FB BAR before we use indirect register 
access. That may still perform better than SDMA especially for very 
small accesses like 4-bytes typical for ptrace accesses. Maybe this 
needs an SRIOV-VF-specific condition if MMIO register access is not an 
option there.

@Jonathan Kim, can you chime in as well?

Thanks,
   Felix


>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5daa05e23ddf..a6e90eada367 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	unsigned int num_dw;
>   	int r, idx;
>   
> -	if (len != PAGE_SIZE)
> +	if (len > PAGE_SIZE)
>   		return -EINVAL;
>   
>   	if (!adev->mman.sdma_access_ptr)
> @@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   		swap(src_addr, dst_addr);
>   
>   	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> -				PAGE_SIZE, 0);
> +				len, 0);
>   
>   	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>   	WARN_ON(job->ibs[0].length_dw > num_dw);
