Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FA7C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAFA10E3E8;
	Wed, 17 Jul 2024 20:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t/BDmQ4h";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBB810E407
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9zQwiKB8yRAHHaDCMqFLKz3tqVge5T9mpVd1uXMNQq9GayOs7XvFhPEHLHpX8M4M58Is+RPIhm43qv4X6gi8eCigpkCb7qZdFI3T2u6w8u4Q4kQuY26HHdAeVajszpqonWjxuCfCAnZSs0TvBvGMSolFQXH130MwiRwGbWfxPU4RL+JXnC47E+SJywuOl2toNvKJSCZzEJ2rbu8QAO+CSbs86YYQPWIpdrBfTysoQI/tpnJZ24fZOiyhbjjw8K2D2K6Oy+MPLG8SlHJHhSSZVnwR0nROMNrTMfXh5l5Cm5KFs4FGikbhLbcNaNqsSB+qHPy7YSRyV3o/rRqrVe5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IrjS6api8BVgubof3m2nxcceexJ6RcZKFpH5k5rmAw=;
 b=SapujDnFu1NtiHTMw/cYY4QPNSAPHmTccPNGyN1DdlqKiRBGhdaKtFoAjgDnb79PDlQwVMCWoBqs3suZCdE0VHqBrvezrYxQfQDqneNv8TkYfvJBApxt/wCa+O362gln/FoLCvFolu/xAmw/EMIuF43K9FBvfmtqj9jOe5izMcIOABeGi4dhhFQjQc1N3GLHcueYRuYPG/gWHUq0C0LS7uUGSohvhKZpEUElAMXxIHB8WSvaP5UGI9Ju5OmFMOB3Fnl7qSeRm6eb+8hk1DiDZ2JCK1rkfcgzuJqH9OzShNaVapAxXNEcH3ahAcbFl9bvO2Firjms3NUiIQHtaXnVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IrjS6api8BVgubof3m2nxcceexJ6RcZKFpH5k5rmAw=;
 b=t/BDmQ4hfSCxP1vI++I0Uq79zlw6zXey6XFMkBrY3M3+V46GfnJFenENKafHIiwHaVoZ44wIlyoQvdd7iLbnbb25D2z+im8ZnU7o54p7jmDYtM1mEh8LPKaEZE91RgVXCyfjYOO6c/5NQBjaO/JQ6t9VUbZwAsWh2ssjk/74+bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:17:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:17:00 +0000
Message-ID: <478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com>
Date: Wed, 17 Jul 2024 16:16:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdkfd: Refactor queue wptr_bo GART mapping
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-4-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240715123502.7013-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaad3a8-2a0f-4511-a994-08dca69d6a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk5aeHRMcko1eWl0WkNIcUZ1czNqRTErbTIzSG9ld1Z4K2NwVGVVYjB1WEho?=
 =?utf-8?B?T25zM01Xb3YxUTE0Ulh3Y1hTYy9Ba29lMEY4WmVHcUxEZGlORnNRbXA4TGZo?=
 =?utf-8?B?d1FPOTZTREtiNjAyRFg1elRPMjFLL1lEbTNxN2FrMlhVb2RzSE9qUWpJVzVi?=
 =?utf-8?B?V0cvQzl6YkJRc3hLSVRrMW5SRTdNTHh3aDNlSTg0Q1QrWHhDdlE3MmFmS3lr?=
 =?utf-8?B?UkJwcG44RngwMXNCV3hmSWpNZWN0OVdKVlF4YXkzRVpsU0hGaitqamZheWZv?=
 =?utf-8?B?MXF5SmN1MmswTHhIVG1QcnhUaWl2SWw5NWFjRzhMU0dzYU41SmZ2VkI5ZU1J?=
 =?utf-8?B?VXN2S0hQMFp4aHh4emREZTZHYituMWFWRktjRmlIQlFOaDN2NjBoa2dtZnlB?=
 =?utf-8?B?VlQ2Ym16TkFWSTcwS2E0Vy9xSis3MWNoOXVMK2czVjk1T0JyNmFKZGROc1FJ?=
 =?utf-8?B?QVZNN3VGKzU2WG9tNGUvSlJ6aytnZWVWSzhQcGRkMUEvSEo3QmovbUtUQTBo?=
 =?utf-8?B?QitMek44dHNaSWNmOVp6SFdXOVRmSGdVVWtRVFhkVDgveWJxcnA5UTJwUzYw?=
 =?utf-8?B?RnZ6Z2ViRGlOa2lmOW10eVZla0ZQd0pQSnJ1ejBUZlovQlNIM1R0empPZWJL?=
 =?utf-8?B?c1RKSExCblBkM1lvcXEyRlRqb0lBQmlZb1F3N3pTSjN1N0l6NGZjekNqbmtu?=
 =?utf-8?B?aEdxSmx0dks0YUl0NGRwbmtzSVZWUUFyRGlvL1djTUVHMmdWcjFKNjlPb0VB?=
 =?utf-8?B?VjBNTEJGZTM5cFBPMXBkV1RBY1V6UVZFTzNrZmRiSEpIQVd4VWZzMVVKd0dl?=
 =?utf-8?B?MnVKTE40UzdpR3ByckpNU1NsMEJqZGxVZ0hpREhJVWwvQjRoWVNZKzhWbXlJ?=
 =?utf-8?B?TnllS2NjZXJPMEtucWdxYVRHOHNueHhid3c3K3QzQ1loM20vcGt0Zk1COE16?=
 =?utf-8?B?TE9EUnFBc29VZEY5UVNMSlVmMWxGaFprQ0hFYmtLRlRHQjJ2NDlHTzhoM3JC?=
 =?utf-8?B?UlRIR01SUHdiVmNja21tTlVaMnBLcTZCWEdkTy9zOTlJRU9jZUxJcnE5MVhU?=
 =?utf-8?B?N2dtU0RKaWNxYVo1aDR4MERNcWtPKzI2QjdodXE2QWhoTGo3Wk9ERlp1WSsy?=
 =?utf-8?B?c1MzVVc4anE5Y2hQcUtUUEdqR2RLUCtDWVpEakY4QjUxS0M2NTZFZ1YwMElV?=
 =?utf-8?B?ZXRnYklDNG9MUy8rdWl4Nk1SdDRCbEFnNEVwSlBxWjA2QS9ZWmR6ek4wbWpW?=
 =?utf-8?B?bzgycVBTaVVjL2hTZDhsQVQ5TUdyUmdsUWJmQWpkUzI2dktwc00vRm9lQ25F?=
 =?utf-8?B?OG9HSkNvbjhDMi95QjYrOGR4bjc2ZDRuTXRQQ1dIZWwzUlM5eS9GQWRSUXQ5?=
 =?utf-8?B?VW12UFJOQXdTQ3Jvcy96S3JMTkpybWtFMk9MbDZJNC9FaHJUMnpaOVNhWnlu?=
 =?utf-8?B?YjR1RzJrTjZxYUpFRERFRVJwS01nQkNnTWtoOFFldDA0Q1NOTmdYYmFyRWVS?=
 =?utf-8?B?dlQrS3hWTFFsanh6TW9HcEVETmFNWWNuZzl2WlZ2K3JKdUUybG5sMVFmbHds?=
 =?utf-8?B?OXhHWnE0UEtpUms2cTZCM0Z5K0tCditHMUc3VGpabURxUFZiZkd0Q0w5akY1?=
 =?utf-8?B?c0NXOEsxVnBJN3JNQ1graS9rNVk3cHNoYk5ZTmhDTUlidzZMaU1Walc2UWlW?=
 =?utf-8?B?b2N5MFpsQyt1M2F2a0ZxNTQ5dTA5TDJqSFM2YnJoWnZUK2hFZlNWM09CMEVU?=
 =?utf-8?B?Q2lRVE1NKy9VRjNEeU1rbEV0S21KakNhWmh4a1JJZnNzMWJUTUhkMUdWL2U0?=
 =?utf-8?B?UWE4MkxURGJRaXc5QWVJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVCRVhFR2RQZE5YZklCVWV6TG1tS1dHVy9hUUVISjFrdzVBdzBIQUp6U1hK?=
 =?utf-8?B?V2daU0RWNmxBdjdJZStUeUNRQlU1VFpzQkNwRXdncmVBV0EvcWg0UlkwZnJK?=
 =?utf-8?B?M05lbmZWY3ZJRmxwMi9iZjgyZklhOTFZeUIxSU91bFVqU0xQRk9LRjJuNU0z?=
 =?utf-8?B?OHpmNHRBRE1aVzcxSTQvSEpYeVpsQzFZQkNoa2dINzdtaG92ZW5BdnIrNGQv?=
 =?utf-8?B?NHE3U2RiWnk3d3E0MWJFalVlSGVYMkJhREVuNThmaldmNThTdVZzYjdYYThW?=
 =?utf-8?B?b0lCUzBLUkVzTFpiTVhPV2lqMlBWbFBYMnV2NWIySDdJVGFPSWZLTVp5WGN4?=
 =?utf-8?B?MExwT2FuRXk5L3FmNEtUeVR3RElmNXhkeFl2a2Fxd3EvcHBrYXFhZjRTK2d5?=
 =?utf-8?B?QkpuK3NIRVFOMXI5ZHV6UDU1M0dPdTV4NlJSQzJHN2ZCdjNUZFV1SFVDOFZx?=
 =?utf-8?B?SWZMRWlGakcrQXJrdVltUStqQ1U1VzZqWnVuTWdabms3TS9JblpiL2oyRU1u?=
 =?utf-8?B?OTNOemFnaytrY2RQWmJyUWRoeXZ5V1ZJdXkydDNrYmkxUjB0aFNMcDdYak1G?=
 =?utf-8?B?QUNPdEw3ejJSb09HRHFRRmJHMW50UUJkdUhwOFo5emJrc3VIdnJYaG5VNmE5?=
 =?utf-8?B?MmRFbEFaejNDWVJOajEwVWJjZytpOFBKQzVQNk5KN0lKbTZ3c0swM1R3LzU0?=
 =?utf-8?B?SUFzcmowSytjUGgxdHFYTXlKWkl0MWRjZUtubXhpRDhBcGZyY1NMRjdaUEVM?=
 =?utf-8?B?Q3pJSWZjR3VDdnJWcE85LzAySWRxYy9aN1VKOTR1S1p2R2FFUVBSdTdmL2lB?=
 =?utf-8?B?eUNxMTNULysydlZUa2k2WFV2N1I5amNaQk1hdnVPZmRoajJxSmpFT2dna2Mv?=
 =?utf-8?B?am45V20xRjFleEczYVNkZ3pHODRtenU1eGF1TGtXTnR1MnFoa3NWeWtwdXI2?=
 =?utf-8?B?NjBRbUdaWkYvRmppWnRLblRsR0ljQ29vYkVPRnB1RE5PTCtFR3RTT25FWnpO?=
 =?utf-8?B?RDhMaXh3eTlacjZzZXRmb2lvWkR3cjFvSDNOdStnYkRxZGJYMFVKenoyMVV5?=
 =?utf-8?B?RjNzUzN4V1Q2NWZZSjBuL3dVQzJYZ2tOODVOSjhWak9YUzdNSnBUdFJnd044?=
 =?utf-8?B?NklPUTkwNGYyTERnbTlTaDB6R2xyR04yV09oaEo0QlJSTzFOdmh3em1JTGJy?=
 =?utf-8?B?MHhjelN4K3FpRUJhckV6Z2FqeFM0TkJFNnRIZWE2WHlZWGNJS0xmSWlTNVJ4?=
 =?utf-8?B?QVpDcDJSZDI0anNwNndvd2ZYQTZhMjBNaDhOZmRZU01wZC9XdW83TW9wMmh4?=
 =?utf-8?B?WmV2QjdxYUpGWjZhZHpKMXRLTkJBaDBodXlNZUhNbXEvQ3puUW5mUDY4b0RB?=
 =?utf-8?B?d2F4T3FkY3UvUTgxS1RDcDlOYitLeVJuZ2pMYVNBZXlhUUlJaXMvNDZ2THF0?=
 =?utf-8?B?M0xZRmxjSUNMb1IxWXBTelNsNzN0amIzSXc4RVNvTUVPTER1bWs3WG1NK05W?=
 =?utf-8?B?STh0RGg2OUNvNFN5Zzh1WkNmS1BKYVhkdGpKbmpLcmtjQ2d1MEkvSGFCNjNR?=
 =?utf-8?B?bjdGYjlBV0t0clY4eDNqTnNWcHlkcC9qSUZyb0tOK295aUVRQmNBYncrUGd4?=
 =?utf-8?B?MVBISml6My9JbXY2RGZhY0s2R0JaelcyTHpWQ3h2RTMya1RhOEc4Z21PTllR?=
 =?utf-8?B?TFlTSTl3YUF4VjYyb2dHYkdiNlJKcUJnUUdkdVVpdGhhc2xPMVkzMGs0Wklt?=
 =?utf-8?B?NE80MDVJdm5ZWmkxQ2IrcW1wdzR4aWRoTm1FclhoSlFZWCs2TDlOSFJiUzZo?=
 =?utf-8?B?alBvaDVadk1zeU8vR2ZTRHIrUGxXOWxsYjk4dlZEWnRMUGNZbDgrUlJ1M2p6?=
 =?utf-8?B?U2dGaFBZUHB1REJtY1pVUTN4Y0VheHg4WDQ5TFA1MWwxQ2xwYjE5NWl1WnJG?=
 =?utf-8?B?TUFiY01iS0tCNlNzd0R6Q0kza0wrY0orZW5XczN2U2djT3YrcytDQVlITEh3?=
 =?utf-8?B?WHZma0d0M3Nwc1NmNDdrMXd6VXFRbEs5T2pMMUlYVC9oNE4vbXhhOW1yOUhr?=
 =?utf-8?B?WnNRUGRXNEVnTWFYbWV4NjJObGpWTVpzTUhJVTIwSDJoOFJjdkJWT2xJdC9y?=
 =?utf-8?Q?yRLTJ8/jf7J4g1jU2HYwCDizo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaad3a8-2a0f-4511-a994-08dca69d6a7a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:17:00.8514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTXXA+wlfV6ozmMhnPkDDFK9m+sX/9Ly1AuB+ckUX+iGau13t3/nt2V1LX1aWK7LaEXEebCvubEbCwHnSJ8ozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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

Sorry, I see that this patch still doesn't propagate errors returned 
from kfd_queue_releasre_buffers correctly. And the later patches in the 
series don't seem to fix it either. See inline.

On 2024-07-15 08:34, Philip Yang wrote:
> Add helper function kfd_queue_acquire_buffers to get queue wptr_bo
> reference from queue write_ptr if it is mapped to the KFD node with
> expected size.
>
> Move wptr_bo to structure queue_properties from struct queue as queue is
> allocated after queue buffers are validated, then we can remove wptr_bo
> parameter from pqm_create_queue.
>
> Because amdgpu_bo_unref clear the pointer, queue_properties wptr_bo is
> used to acquire and release wptr_bo for validation, add wptr_bo_gart to
> queue_propertes, to hold wptr_bo reference for GART mapping and
> umapping.
>
> Move MES wptr_bo GART mapping to init_user_queue, the same location with
> queue ctx_bo GART mapping.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 56 +++---------------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 14 +++--
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 45 +++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 57 +++++++++++++++++++
>   7 files changed, 116 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 6e591280774b..4ed49265c764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -322,7 +322,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>   					     void **kptr, uint64_t *size);
>   void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>   
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence __rcu **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 199e387d35f4..0ab37e7aec26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2226,11 +2226,12 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>   /**
>    * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
>    * @bo: Buffer object to be mapped
> + * @bo_gart: Return bo reference
>    *
>    * Before return, bo reference count is incremented. To release the reference and unpin/
>    * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
>    */
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
>   {
>   	int ret;
>   
> @@ -2257,7 +2258,7 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>   
>   	amdgpu_bo_unreserve(bo);
>   
> -	bo = amdgpu_bo_ref(bo);
> +	*bo_gart = amdgpu_bo_ref(bo);
>   
>   	return 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 823f245dc7d0..202f24ee4bd7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -247,8 +247,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   	q_properties->priority = args->queue_priority;
>   	q_properties->queue_address = args->ring_base_address;
>   	q_properties->queue_size = args->ring_size;
> -	q_properties->read_ptr = (uint32_t *) args->read_pointer_address;
> -	q_properties->write_ptr = (uint32_t *) args->write_pointer_address;
> +	q_properties->read_ptr = (void __user *)args->read_pointer_address;
> +	q_properties->write_ptr = (void __user *)args->write_pointer_address;
>   	q_properties->eop_ring_buffer_address = args->eop_buffer_address;
>   	q_properties->eop_ring_buffer_size = args->eop_buffer_size;
>   	q_properties->ctx_save_restore_area_address =
> @@ -306,7 +306,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	struct kfd_process_device *pdd;
>   	struct queue_properties q_properties;
>   	uint32_t doorbell_offset_in_process = 0;
> -	struct amdgpu_bo *wptr_bo = NULL;
>   
>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>   
> @@ -342,53 +341,17 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		}
>   	}
>   
> -	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
> -	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
> -	 */
> -	if (dev->kfd->shared_resources.enable_mes &&
> -			((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
> -			>> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
> -		struct amdgpu_bo_va_mapping *wptr_mapping;
> -		struct amdgpu_vm *wptr_vm;
> -
> -		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
> -		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> -		if (err)
> -			goto err_wptr_map_gart;
> -
> -		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
> -				wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
> -		amdgpu_bo_unreserve(wptr_vm->root.bo);
> -		if (!wptr_mapping) {
> -			pr_err("Failed to lookup wptr bo\n");
> -			err = -EINVAL;
> -			goto err_wptr_map_gart;
> -		}
> -
> -		wptr_bo = wptr_mapping->bo_va->base.bo;
> -		if (wptr_bo->tbo.base.size > PAGE_SIZE) {
> -			pr_err("Requested GART mapping for wptr bo larger than one page\n");
> -			err = -EINVAL;
> -			goto err_wptr_map_gart;
> -		}
> -		if (dev->adev != amdgpu_ttm_adev(wptr_bo->tbo.bdev)) {
> -			pr_err("Queue memory allocated to wrong device\n");
> -			err = -EINVAL;
> -			goto err_wptr_map_gart;
> -		}
> -
> -		err = amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
> -		if (err) {
> -			pr_err("Failed to map wptr bo to GART\n");
> -			goto err_wptr_map_gart;
> -		}
> +	err = kfd_queue_acquire_buffers(pdd, &q_properties);
> +	if (err) {
> +		pr_debug("failed to acquire user queue buffers\n");
> +		goto err_acquire_queue_buf;
>   	}
>   
>   	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
>   			NULL, NULL, NULL, &doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;
> @@ -422,9 +385,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	return 0;
>   
>   err_create_queue:
> -	if (wptr_bo)
> -		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
> -err_wptr_map_gart:
> +	kfd_queue_release_buffers(pdd, &q_properties);

You're ignoring the return value here. In this patch, the function 
always returns 0, but in later patches it can return -ERESTARTSYS and 
you never fix up the error handling here. This patch should lay the 
groundwork for proper error handling.


> +err_acquire_queue_buf:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 420444eb8e98..fdc76c24b2e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -208,10 +208,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.mqd_addr = q->gart_mqd_addr;
>   	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>   
> -	if (q->wptr_bo) {
> -		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
> -		queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) + wptr_addr_off;
> -	}
> +	wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
> +	queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->properties.wptr_bo) + wptr_addr_off;
>   
>   	queue_input.is_kfd_process = 1;
>   	queue_input.is_aql_queue = (q->properties.format == KFD_QUEUE_FORMAT_AQL);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2b3ec92981e8..c98ff548313c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -494,8 +494,8 @@ struct queue_properties {
>   	uint64_t  queue_size;
>   	uint32_t priority;
>   	uint32_t queue_percent;
> -	uint32_t *read_ptr;
> -	uint32_t *write_ptr;
> +	void __user *read_ptr;
> +	void __user *write_ptr;
>   	void __iomem *doorbell_ptr;
>   	uint32_t doorbell_off;
>   	bool is_interop;
> @@ -522,6 +522,9 @@ struct queue_properties {
>   	uint64_t tba_addr;
>   	uint64_t tma_addr;
>   	uint64_t exception_status;
> +
> +	struct amdgpu_bo *wptr_bo_gart;
> +	struct amdgpu_bo *wptr_bo;
>   };
>   
>   #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
> @@ -603,8 +606,6 @@ struct queue {
>   	void *gang_ctx_bo;
>   	uint64_t gang_ctx_gpu_addr;
>   	void *gang_ctx_cpu_ptr;
> -
> -	struct amdgpu_bo *wptr_bo;
>   };
>   
>   enum KFD_MQD_TYPE {
> @@ -1284,6 +1285,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties);
>   void uninit_queue(struct queue *q);
>   void print_queue_properties(struct queue_properties *q);
>   void print_queue(struct queue *q);
> +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
> +			 u64 expected_size);
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
> +int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>   
>   struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   		struct kfd_node *dev);
> @@ -1320,7 +1325,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> -			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 36f0460cbffe..8552400d6d47 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -205,18 +205,21 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
>   
>   	if (dev->kfd->shared_resources.enable_mes) {
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
> -		if (pqn->q->wptr_bo)
> -			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->properties.wptr_bo_gart);
>   	}
>   }
>   
>   void pqm_uninit(struct process_queue_manager *pqm)
>   {
>   	struct process_queue_node *pqn, *next;
> +	struct kfd_process_device *pdd;
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
> -		if (pqn->q)
> +		if (pqn->q) {
> +			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
> +			kfd_queue_release_buffers(pdd, &pqn->q->properties);
You're ignoring the return value here. In this patch, the function 
always returns 0, but in later patches it can return -ERESTARTSYS and 
you never fix up the error handling here. This patch should lay the 
groundwork for proper error handling.

Regards,
   Felix


>   			pqm_clean_queue_resource(pqm, pqn);
> +		}
>   
>   		kfd_procfs_del_queue(pqn->q);
>   		uninit_queue(pqn->q);
> @@ -231,8 +234,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   static int init_user_queue(struct process_queue_manager *pqm,
>   				struct kfd_node *dev, struct queue **q,
>   				struct queue_properties *q_properties,
> -				struct file *f, struct amdgpu_bo *wptr_bo,
> -				unsigned int qid)
> +				struct file *f, unsigned int qid)
>   {
>   	int retval;
>   
> @@ -263,12 +265,32 @@ static int init_user_queue(struct process_queue_manager *pqm,
>   			goto cleanup;
>   		}
>   		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
> -		(*q)->wptr_bo = wptr_bo;
> +
> +		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
> +		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
> +		 */
> +		if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
> +		    >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
> +			if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
> +				pr_err("Queue memory allocated to wrong device\n");
> +				retval = -EINVAL;
> +				goto free_gang_ctx_bo;
> +			}
> +
> +			retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
> +								  &(*q)->properties.wptr_bo_gart);
> +			if (retval) {
> +				pr_err("Failed to map wptr bo to GART\n");
> +				goto free_gang_ctx_bo;
> +			}
> +		}
>   	}
>   
>   	pr_debug("PQM After init queue");
>   	return 0;
>   
> +free_gang_ctx_bo:
> +	amdgpu_amdkfd_free_gtt_mem(dev->adev, (*q)->gang_ctx_bo);
>   cleanup:
>   	uninit_queue(*q);
>   	*q = NULL;
> @@ -280,7 +302,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> -			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> @@ -351,7 +372,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		 * allocate_sdma_queue() in create_queue() has the
>   		 * corresponding check logic.
>   		 */
> -		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -372,7 +393,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			goto err_create_queue;
>   		}
>   
> -		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -490,6 +511,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   	}
>   
>   	if (pqn->q) {
> +		retval = kfd_queue_release_buffers(pdd, &pqn->q->properties);
> +		if (retval)
> +			goto err_destroy_queue;
> +
>   		kfd_procfs_del_queue(pqn->q);
>   		dqm = pqn->q->device->dqm;
>   		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
> @@ -971,7 +996,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   
>   	print_queue_properties(&qp);
>   
> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
> +	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
>   				NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 0f6992b1895c..b4529ec298a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -82,3 +82,60 @@ void uninit_queue(struct queue *q)
>   {
>   	kfree(q);
>   }
> +
> +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
> +			 u64 expected_size)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	u64 user_addr;
> +	u64 size;
> +
> +	user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
> +	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	if (!mapping)
> +		goto out_err;
> +
> +	if (user_addr != mapping->start || user_addr + size - 1 != mapping->last) {
> +		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
> +			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
> +			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
> +		goto out_err;
> +	}
> +
> +	*pbo = amdgpu_bo_ref(mapping->bo_va->base.bo);
> +	return 0;
> +
> +out_err:
> +	*pbo = NULL;
> +	return -EINVAL;
> +}
> +
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
> +{
> +	struct amdgpu_vm *vm;
> +	int err;
> +
> +	vm = drm_priv_to_vm(pdd->drm_priv);
> +	err = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (err)
> +		return err;
> +
> +	err = kfd_queue_buffer_get(vm, properties->write_ptr, &properties->wptr_bo, PAGE_SIZE);
> +	if (err)
> +		goto out_unreserve;
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return 0;
> +
> +out_unreserve:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return err;
> +}
> +
> +int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
> +{
> +	amdgpu_bo_unref(&properties->wptr_bo);
> +	return 0;
> +}
