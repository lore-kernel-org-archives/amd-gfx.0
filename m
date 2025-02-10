Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB40C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 15:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF17310E596;
	Mon, 10 Feb 2025 15:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cjRX4Dk2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71A210E596
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 15:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6O45uJFiqPoT1IhyTrlLm11N3sT4TbedZQpEqkSpWN9geRUNZDdIzctvq68bJIxZwQ9c6361Hh8l41dA2g/RWPK6eAR/J/+440OtjsGJ8SAKHmLVjM1f9rbUiDW6ZqWgeFXlrUoSp3iTvpRN2XLEnSxm+QJ42SYwYlhhl81TNbggUQtoBprkQ4dlbci5S5u30e9pVd7OUbavv8BAinrmKPWOGh86RdjgrbDKwTzyp8hqVnLF16G5AfwB9bc9D814nbO7aG5pPRIdlEwe+JLUBQKRcqPhX/8UtEpHzKRFEPGS5jq44ui4kNOo6bz61rt/ExpEkSamKDO2E3icKgcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+XLzT1kfsslysJ/Kegx+Q8PkjDYGOS58UQYELbeS1A=;
 b=w2L+ooLW2Z0snJXTaGp71J8vC3ZjNFh39ZWC/nzYCBb4rBWBexTqQUezYR8WLXRoScXoQGYufzN1R/GL8f42Nup5daUb7s1SpBpU1BQpn8FAHCqDKbDVEmb4NBIOLzw9ktx8biyOnC09LgkgMWiJSRt0Fh+bY27NH81P8K3qaf+OJ8+lgKRrCOa2BgPVIupDt/jersfVNAaE2jRhkVVMFB/UfVcRNf+VMX8teACqab2zsn7o9aAF/iPXWDyOQRbYZagdFMiCz7CG9IefXKSlNc1XF7FhfH4/WrtfzpzUeHg0tnKBrR04a9Hr13McXtTrxkw2k1Kq3v9D9GCbIcwfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+XLzT1kfsslysJ/Kegx+Q8PkjDYGOS58UQYELbeS1A=;
 b=cjRX4Dk22FsGgQYxnr3TN5Srg/51cumlkDwNthlQWC08ottVTEKaSHAAJ8IsAUweG2pHWcVI+YhEsefbFCXp81worM1l0DDsjEgO1iQ1PeDkSHvG6hdOixHiiKHYKchLcz/aTrMuEDvLyKHPou6aUx+H4FFRndmLxbTx9jFNQ6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 15:24:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 15:24:29 +0000
Message-ID: <d5f6892d-ddab-4e63-b022-199bef4c3c69@amd.com>
Date: Mon, 10 Feb 2025 20:54:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 Jonathan Kim <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250210073145.2681082-1-jesse.zhang@amd.com>
 <20250210073145.2681082-3-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250210073145.2681082-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 223bc23d-e122-4d6d-a566-08dd49e702ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0NIUlVtTys0QXpFaE9hMjNUKzg5SVdKOU5Pbm40NmUxS1FwKzN1MlFybTNm?=
 =?utf-8?B?TzlvZjdqQlJQY29uRnEwS2lHWkhaeDgyT3pCK3RwMXk4OTJqaVZoTHRxeU9n?=
 =?utf-8?B?WVBDaUFUWkVyeExTeGJMVFRBU2Q5dHdKcDNacWlLQkJKUFJMUE5icUNERHo3?=
 =?utf-8?B?SE52c3ZZSlpKV1hLNHJIUGRVMW4xb0dNNTZQcW5nU1ZoS2pETStjdTl2Ull1?=
 =?utf-8?B?OWJ5V1ZwaDI2QnlSOVJwaFltZ2YwWTgyZTJYanA2NFRvdDZCTDhkT2dzMDY2?=
 =?utf-8?B?T0ErbzhRR04wSWNna0NWa1RBTVl6cTNtOURjMnRJQjRxYytxNithMGlPTGc5?=
 =?utf-8?B?RXIzTVNhUTczU013cUhRWGlXSUVSTzFUNUlxQno0TElFSkJ3ZmRsRUtDOUhs?=
 =?utf-8?B?VUIxWHczM0hVSlMyZU0xUmZkeXExM2c1K2dTMHREYlByd2RrcDBEL2xsbWY1?=
 =?utf-8?B?RGpjR1BGRHJtY1YrejBxTDM4Ni91S2R0b05EaDg4Q2VseVM0RHR0YU1qYldV?=
 =?utf-8?B?VHJJTmxUMENMdWFKWVRrYVRITnJoT2tYZ0MxSFl3NS9VNW8rd29GS1plZ2xO?=
 =?utf-8?B?ZkFGd3NvZjlzcno0SWxPWlUzckRsYXltYnpobFltK21FZEI5TGJzaHkvcmhj?=
 =?utf-8?B?SjZaeVpzcFZjLzIzREpDQndxeXFlN3NuSVFuNnNSTlZLNi92WEtsaDh1RUtM?=
 =?utf-8?B?dVNwUFpqMm1UYkZUV2dmK1RMN0d6aWJEbUlXV3UweG4yQ3l0MjgzdlM4ZStD?=
 =?utf-8?B?NkZOSXBkWmEyaVJuWFpyQy9XOHQyWDNSeDV1alo4T0pHSk9JNzQ1UVZnaWRQ?=
 =?utf-8?B?dnpKT21aYlE4YmhBTmVySGRiMXVQMXBjY0JRZnZHTDVCL041TEZ1Nk9rdjlx?=
 =?utf-8?B?a0xQbXVCVDhLR3g2b0tRUWl4YnI5Kzd1QlI5L2l2aTAwMHN6dmtRZU1xb3JK?=
 =?utf-8?B?bHFCcG5qN2JiNzJabzVNZGtRd0dUUk1uWmdPQlVyM3ZZQUdFKzVlUEk0SnRh?=
 =?utf-8?B?MDVLNit1cTJZemZacU5PVVcySEtoOSt4Q0t0L3k0R0VNdDk2NERhRHZmTkw2?=
 =?utf-8?B?Qml4M0NkSmZQc3k5dnI5MVh1R29PQndHKytJYkF2SEhjZVlJVzlBamhNb3hV?=
 =?utf-8?B?MFF1Y3lzZUpJTStKMnhMQVh3M0ZLWTZjczBpRkFTL1hKc01CYU9rWDN2cW9a?=
 =?utf-8?B?N0RVWlFUdVM2SUk3WldveFJzNm9nTXE2UXhvT2xQa1pVTmZLUzQrM0xOVmlD?=
 =?utf-8?B?N1UvbzRNeWdqUXdubGxnUXc5OU5hTjVSVVZrdysvYjhtRjYxNGtGeGZGazJs?=
 =?utf-8?B?c1NCMHBzWHpwVW5GMytRWXdqWCtxT0RkdVdueU9jR01hdWhhcUV1cDA4dXRP?=
 =?utf-8?B?cXVzMllLNklGeXpvT2NpR29jTU1hZUlzNS9oRzBQZzZ4SnF4TVVLRmZjWS9P?=
 =?utf-8?B?dDhxRW5NcmpkOFZFTjhFYituSXVJMDlGa2l4YVFOd0RCUWJzNWpzem9kTVdD?=
 =?utf-8?B?YkJ1TFZsdDJocGhZZWQ4NXBHa3ZuaDlldk81cFQzNGE1SjQ2akx1M2g5VUk1?=
 =?utf-8?B?U3h6c3BtQmZiWitRUHlGUUhsT2tCMFQxSVRXTVNXcnQzS0pmZGF4K1Z4eTFL?=
 =?utf-8?B?bFNReFNrOWszc0E4OEJCRlhpN2k0dTJVZ3c1WjhRT2FCdjVoWFhraVMyR0dZ?=
 =?utf-8?B?RE4yQk5uWkZyTUQ0dnJERmNnRTQ2SE14dXdCNEE2eUozcmxSRkVISXhKMVVu?=
 =?utf-8?B?VHIvOGJ4L0xVZC9sTzQya05kaVVUV0tvWlhCKzJSUlpXeWFISlE0ZVBKbFR2?=
 =?utf-8?B?eklTR2JjVkE4QzdiUGhiYTFzVmRzOU9qUE9rSitjM09YN0djS1VUV3BWclht?=
 =?utf-8?Q?nqfBgf4aWPF2j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVPbjY4NTdBUS9ILzZ0RTZlVSs1TmFKOS9jQnpxYlgxUmp6dlJ3Y3A4OXpJ?=
 =?utf-8?B?Mi9ub3U5WVZRSUxvdGw3TkRIN0EyVUdsR2ZuRDR1NFRvaDFINmNReHQzeE1Q?=
 =?utf-8?B?Qk9ORThlMEt6QU93UGxGS1I3bTBKa012MVJQOXF3TnViWllyd1QwVlhGeDFR?=
 =?utf-8?B?N0I3VGFMRk5RWndYTWpoQStSVTBJcmxqRHF0dmt2LzlQandOY01UT2dNVStp?=
 =?utf-8?B?Z2tVeDNCaXFHQlRFTUd4Q25FblpzVTkzczg0M2lEUkVyWTRab2VyK1E3MUNZ?=
 =?utf-8?B?VlR2aWNyS3ZJM3lFMWk4dlRpVlhRemdkVVpnelZETTV1R2RsZDYxQkdVcXlJ?=
 =?utf-8?B?NXQ5cEI0VXFJU2h5bDdrZGQ2OWRlcXlMOWxJa1VKN0dLcUsya29DZCtNMGFQ?=
 =?utf-8?B?aEIyM2NIM2Njb3lBaUkraXZSSDRHT2lGdnB5T3E2dlJQTWF1UHpoWkZ5RnVn?=
 =?utf-8?B?QlZCYktFQ0JIb25qbWlhVDFEQmxTNFdWc2VmNmoxNDVDSU1mUWNrV3AyNU9E?=
 =?utf-8?B?MkRrdWFqUXNrRGdQWkdaeTJCcjE0WHVndW5rbjh1MHRZdUZBamxFZE1yei92?=
 =?utf-8?B?LzB0WjRqNzZlVWJ6MGFCV2pobE85N2YzdWFCbE1CYk4zZEdkd3Q3aEoxbitU?=
 =?utf-8?B?ZW1nZnc3cWdnQXgxUFF1QTh4QndBTGJlWTVNODQ0UDFlKzcxL0lSYlowYU1u?=
 =?utf-8?B?NWcxL3hta0xEaDZkd2NBNnBaa1RWbzJMb2pGeXpuNGdXN1crNHJSeVhTeS9n?=
 =?utf-8?B?L29QQnVhRFJtZ2c2eHVGMDV2RUJKTTAraDNFV2VjVDFmN0lXcHc2aHJQRHNB?=
 =?utf-8?B?UjNPSmZzdXlwVUxkZ3lxOFhEUDNvbXF2U2dxYWp3aUoraDZVSExWdmllTlAr?=
 =?utf-8?B?YUNRZjdqd1lYbjhFSlZEOG9VMkFRdjhDTmcrMkZtL1duT1BJN2g1MWlwSGgw?=
 =?utf-8?B?bWdCRG1TSzJMUm1hL0FVdmRPS1hXMFh4dENzRDR2dVZKaWd5UVAzNkl1SSt1?=
 =?utf-8?B?VzhWd043aGVyMmVGaC80ZVM2MmJvNU1GQUVmR01CRytTOUJqcy9WM1pjTEpi?=
 =?utf-8?B?Ykg4OUVzN3pwY2lZVHRLZDlCK1IxNGFqd1dEc3lwZnAraGgvQUxzYjJBdTVv?=
 =?utf-8?B?b1RaZ1V4TE9rVU1oVHZCTDlkbVREN2lneGcyWmNCYkhSZ0NvNUFkVFFBTHJ0?=
 =?utf-8?B?cXBHRWh5czhCR1hBd09JeC9xSlBaeG5DSmJnMXFOWkNKdzA0UFQ4blhrSEJO?=
 =?utf-8?B?QkZLMjdQTEtjUWFlbDhVbDZsZVhpZFdhaEdxamlwVExRTEt0ZnEvOTlwQjNG?=
 =?utf-8?B?NDdORnpieDlyZHMzWmlGdGhKcUZxTHk4Q1pucnJ1ZFdpZ01sNFlqZXdQK0lx?=
 =?utf-8?B?aUUyKzJkQ0xacjBGdjdnbGZsckJUczhMY2w1a2lMMXh2OW91bEpvSVhRNzlN?=
 =?utf-8?B?SVMzeGJ4Vk5lOE03bGhKbFFtZlI1M2dKL0JPZnRLYTd6eFk2YTNpUzMxWkxw?=
 =?utf-8?B?YXBaM24yaDNUTUhCUHY3Q1JNTUY2NjZHbFNVV1BVd0sxemRxNm5BS3dZRm1F?=
 =?utf-8?B?MWVnYk96cWYzL0UveWVDRFNOamJxR2grd08zcWpyN01qbXZDZG5JdHJsWjJa?=
 =?utf-8?B?Q3hxR2xPRWpFYUdSTXRHSU9HdzREaktWdGpKMFlmdTNXMHA4V0lOcnUrTXlC?=
 =?utf-8?B?WE1xbFZNYUkycnVrdHQrTXE1dDJZU1ZpTG5JYkhPbnBmSzJiODN0ZmxsUWxZ?=
 =?utf-8?B?L0xaTzQ3UlMwWFJyRXVTSlduL1dSZjhUbHBqZHhnOGlTdC9FM01SM1JOS1hH?=
 =?utf-8?B?Mzcxd0pRYzBsSTRGbUh0NEc5YzJBWkxsenAyY0pDbWtnNHlRUG9leDEyREpO?=
 =?utf-8?B?L0ZZWFlUOWlhTUcwdi9zOHBnamI5OElkaHRIRVFydytoYkRENkE5bUpUam96?=
 =?utf-8?B?TS8xMWhrZEdWZGdlSzhkTFJpKzVUREVidERiMWt6OW15MnloZ2F5RUFBYTNN?=
 =?utf-8?B?R3REbjhmQnVzV3plVlE2Z0p5T0tVdXpFdHlRdWEwMXRvelVlQ3hBeDFMTDEv?=
 =?utf-8?B?ZmhvV1FrZGthSDRXRFJ3dGRVYjFoWTBrN0s1SUJuU3VNL0xhd3hheFhEand2?=
 =?utf-8?Q?4WlDiElIL/p0tLH1g6yekSkbe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223bc23d-e122-4d6d-a566-08dd49e702ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:24:29.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6rcoLnzCBUcKENtL/WsSGqqO4nuP67eqFGm8pSdfALFQ/d8Ole6xyGVeRw83rKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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



On 2/10/2025 1:01 PM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This commit introduces a caller parameter to the amdgpu_sdma_reset_instance function to differentiate
> between reset requests originating from the KGD and KFD.
> This change ensures proper synchronization between KGD and KFD during SDMA resets.
> 
> If the caller is KFD, the function now acquires and releases the scheduler lock (ring->sched.job_list_lock)
> to protect the SDMA queue during the reset.
> 
> These changes prevent race conditions and ensure safe SDMA reset operations
> when initiated by KFD, improving system stability and reliability.
> 
> V2: replace the ring_lock with the existed the scheduler
>     locks for the queues (ring->sched) on the sdma engine.(Alex)
> 
> v3: call drm_sched_wqueue_stop() rather than job_list_lock.
>     If a GPU ring reset was already initiated for one ring at amdgpu_job_timedout,
>     skip resetting that ring and call drm_sched_wqueue_stop()
>     for the other rings (Alex)
> 
>    replace  the common lock (sdma_reset_lock) with DQM lock to
>    to resolve reset races between the two driver sections during KFD eviction.(Jon)
> 
>    Rename the caller to Reset_src and
>    Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to AMDGPU_RESET_SRC_SDMA_HWS/RING (Jon)
> v4: restart the wqueue if the reset was successful,
>     or fall back to a full adapter reset. (Alex)
> 
>    move definition of reset source to enumeration AMDGPU_RESET_SRCS, and
>    check reset src in amdgpu_sdma_reset_instance (Jon)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 54 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  |  6 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 ++--
>  4 files changed, 56 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 4d9b9701139b..5b86e12ff9fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
>  	AMDGPU_RESET_SRC_MES,
>  	AMDGPU_RESET_SRC_HWS,
>  	AMDGPU_RESET_SRC_USER,
> +	AMDGPU_RESET_SRC_SDMA_RING,
> +	AMDGPU_RESET_SRC_SDMA_HWS,

Ok. Probably this is the reason it's only dealing with instance rather
than amdgpu_ring. Please ignore my comments about the ring args in patch 2.

Thanks,
Lijo

>  };
>  
>  struct amdgpu_reset_context {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 19c8be7d72e2..8864a9d7455b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -25,6 +25,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>  
>  #define AMDGPU_CSA_SDMA_SIZE 64
>  /* SDMA CSA reside in the 3rd page of CSA */
> @@ -484,6 +485,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>   * amdgpu_sdma_reset_instance - Reset a specific SDMA instance
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
> + * @src: The source of reset function (KGD or KFD)
>   *
>   * This function performs the following steps:
>   * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
> @@ -492,20 +494,42 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>   *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
> -int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id)
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id, int src)
>  {
>  	struct sdma_on_reset_funcs *funcs;
> -	int ret;
> +	int ret = 0;
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
> +	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> +	struct amdgpu_ring *page_ring = &sdma_instance->page;
> +	bool gfx_sched_stopped = false, page_sched_stopped = false;
> +
> +	/* Check if the reset source is valid for SDMA ring reset */
> +	if (src != AMDGPU_RESET_SRC_SDMA_RING && src != AMDGPU_RESET_SRC_HWS)
> +		return -EINVAL;
> +
> +	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
> +	* This ensures that no new tasks are submitted to the queues while
> +	* the reset is in progress.
> +	*/
> +	if (!amdgpu_ring_sched_ready(gfx_ring)) {
> +		drm_sched_wqueue_stop(&gfx_ring->sched);
> +		gfx_sched_stopped = true;;
> +	}
> +
> +	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
> +		drm_sched_wqueue_stop(&page_ring->sched);
> +		page_sched_stopped = true;
> +	}
>  
>  	/* Invoke all registered pre_reset callbacks */
>  	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>  		if (funcs->pre_reset) {
> -			ret = funcs->pre_reset(adev, instance_id);
> +			ret = funcs->pre_reset(adev, instance_id, src);
>  			if (ret) {
>  				dev_err(adev->dev,
>  				"beforeReset callback failed for instance %u: %d\n",
>  					instance_id, ret);
> -				return ret;
> +				goto exit;
>  			}
>  		}
>  	}
> @@ -514,21 +538,35 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id)
>  	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>  	if (ret) {
>  		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
> -		return ret;
> +		goto exit;
>  	}
>  
>  	/* Invoke all registered post_reset callbacks */
>  	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>  		if (funcs->post_reset) {
> -			ret = funcs->post_reset(adev, instance_id);
> +			ret = funcs->post_reset(adev, instance_id, src);
>  			if (ret) {
>  				dev_err(adev->dev,
>  				"afterReset callback failed for instance %u: %d\n",
>  					instance_id, ret);
> -				return ret;
> +				goto exit;
>  			}
>  		}
>  	}
>  
> -	return 0;
> +exit:
> +	/* Restart the scheduler's work queue for the GFX and page rings
> +	 * if they were stopped by this function. This allows new tasks
> +	 * to be submitted to the queues after the reset is complete.
> +	 */
> +	if (ret) {
> +		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
> +			drm_sched_wqueue_start(&gfx_ring->sched);
> +		}
> +		if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring)) {
> +			drm_sched_wqueue_start(&page_ring->sched);
> +		}
> +	}
> +
> +       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index fbb8b04ef2cb..df5c9f7a4374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {
>  };
>  
>  struct sdma_on_reset_funcs {
> -	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> -	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> +	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id, int src);
> +	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id, int src);
>  	/* Linked list node to store this structure in a list; */
>  	struct list_head list;
>  };
> @@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {
>  };
>  
>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
> -int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id);
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id, int src);
>  
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 3e60456b0db0..c297b4a13680 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_reset.h"
>  
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +
>  	return r;
>  }
>  
> @@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = GET_INST(SDMA0, ring->me);
> -	return amdgpu_sdma_reset_instance(adev, id);
> +	return amdgpu_sdma_reset_instance(adev, id, AMDGPU_RESET_SRC_SDMA_RING);
>  }
>  
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
>  {
>  	u32 inst_mask;
>  	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
> @@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
>  	return 0;
>  }
>  
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
>  {
>  	int i;
>  	u32 inst_mask;

