Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FB8C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 07:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E856610E597;
	Fri,  3 Jul 2026 07:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9Rga3h5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FE410E597
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 07:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/Fc/cu/SyQutVpzWHt//GUM+jVGqcU73EXMZk1M9fvhLv7dUKZ9T01Q0y15PZgZYY7cM5hQ3hdhJ5pG0ipTAXXWFr4/5A3bVeArs5V0t0zLMBQsTNlp/HRUYX3EipQR7Tf4JKAKcb46BrF4jcx7v1Od3ltp7pndFt5v4DOtOk0t2R1QRN/edbLsE7YagM4kqJsLMOiZdoJEqK3yqv0OhAKPenjwIeoSeFfMV0MIMM0M/jVAIGUuSvXyKoa/czgJn9UlMa7TGL+BzJobXCRl9l9HrpEsXrF+CaEHmj8cWv6xndzoODNCJEPdOizQ1Q5h4mX9XfN3xOocy7nLp7+2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2eLZWbcBd7vWtVJRBFhpqYS3goYcORHL1aTeL6uW48=;
 b=w2b+3xqZ6KmRojxGSNW2bZVFPfvqvz5tHlFRCICZ2ptQttk8YYEMY/LMU/XuSGKfvHnR6WkT2EsoDVsGyABUh4emesspetPdu0MGUdlRhxQZorxLWJ56vhF7YU5uAhrvODx+OzsPB46Y4kQzLH5rtqXpOksgmM0FAH0fPQ4j50TEX8U5XIGyaUHvKKDTKoWvOGbfYgILbeldTuIe3ORvE/9NMZ/AirFbUuagbm1O44WMUBtEqrdbmTgqEJiJw1wkFaHDjpMVDCuyIaapL1pT+wYQw0DVE7fpApCCH+4xYyKR5R/JKfZQfJF0sgY2nn4x1vXGuyYyXO+47uTuHTm5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2eLZWbcBd7vWtVJRBFhpqYS3goYcORHL1aTeL6uW48=;
 b=B9Rga3h57PG2zLoZgfzhavtgK1unOfvF8/MH4s3eH70lSmGdXuMP8vs8T5IN+BTNt88R1NcJgZ0ntPeO0TQtfFA2Tx68KXdW+v8eAAcZ82n4CYDRvempB+AeI2zWvKiHTvhlcl+yMe+uLdE5Ysrst1vLjgM2rbhasgp263LkMyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 07:38:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 07:38:25 +0000
Message-ID: <9a74a1b3-3f8f-4caa-b0ce-a94dd34d4a7d@amd.com>
Date: Fri, 3 Jul 2026 09:38:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/amdgpu: Allow PASID allocator to store fpriv
 owner
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
 <20260703061833.3163913-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260703061833.3163913-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7adb7a-b74f-4f9a-39f8-08ded8d61130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: li65Y9HBMsHiVPBTYE0wZXn9Yt02QuAgtM5KBazYFgA8ZcHq5bfpqXxuABzB3qp8hjPYxPPVAWMi4zpyPGzxnsx4cIut6b1rQhPfGgjj2ufbuZuAq2/OqPdS+KD0H/KFn1qwMlxZfd4hegf0HZR0U4xNL0G9R8dukdMILFYnZdm3IGBGZjj0JHqLOwwTWx0BtZMUBADgZEH3/gbN5b0yUq7S5WGbZuBjVX/hgx12VlUyOwp0GggW4C3vf0E6TzfRomP0B1DCem6AGiMdTVV3FB2oB+5kYHaCvxBiq7ITRCkBLO9jj3vbIZCtQqWjdF1LKe444qOQRmW3Hj+UqhxzaJsOu9eJVTN6jOdqkPii8DWjYkqSLxGO0fj7YFBc1lNeTInLTMOCWtc0vqUtuRw7aPEd4S7cfdSsDKHJbp+u9fosA3sZ1oSEZ+CQWR9Xk8nfg6I3XzIcVACQHxrul5L2JZruc4qWQ6g5iMieX7bUo2DsDNib5nvCqKzrtCpSsRLthGgxX9TC3zg226SiUXLTdWYARHjgL2cXdxQXBGigBpqiWudAvUI11KG+X3wgdM1+9oObUpsNzQ9BWm3SieLXNWOo3VNbKYLjc3X+SDV7k744L5reJ+C5SxGUkzvDEsx8niFX/1GwFAdXhtBlWYgNluITnLF7wBWyryk2wsicp44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BsWDJ2VDYzOGJnTWRqN2d5enZVbnpseGNzeUE5bmFZcktOZzQybVQvN2RZ?=
 =?utf-8?B?ditWbmM3dDJaOG0yTVJOeCtBS2JFdG5lbkpFQWRtRDdNaS96Q21rRjg5Ymt4?=
 =?utf-8?B?aWxSbXVJVmNvK2k4YmhQTng1YWVsZzBXTUZpUUppK3R5di8xT0Nrc1RSanBH?=
 =?utf-8?B?d3J6Z29iTUI4L2FlMkJEN1lQR09tZG5BOENzOEtTYll1amtEK0swZkp2cnJD?=
 =?utf-8?B?ODNFQzRSK0hObUlzOVdVMFM2OXhpWS83clN2akJ5U3ltZUNkSGZlV1pxY3JZ?=
 =?utf-8?B?Z0lmVEpuamVJK0F1aHRiZ1lFcXd6bWZLaDVQaWVkOXZSUTltRXJDQlJEdmNJ?=
 =?utf-8?B?N2xxTHlybGxrcjRaV2p5VkJ0RCtnbDVuLzVENXp5WWxkZlc4d0NLN0FCZHkv?=
 =?utf-8?B?S1JvbVArOWZITFJsVmw3YkEzMlRQSTE3NVpXT3B5NElTakpuWmZhdUhOamoz?=
 =?utf-8?B?QXlucjMwTzRGVjhCOGU5L1FVZjJUaFpwYXRPUU9kWmUxdnYycnVOdlJ4cTNy?=
 =?utf-8?B?eWkycGJUTEsyOWZJNVBPR2NMd3BUSjJaVHY0dzVOVVVKbW1oTFpMdW10UThp?=
 =?utf-8?B?aEYyMDlwd09SemNIeVl4aEhpUUkrclNYS3dFWGoxQlByR2VhZHJYZDVFOVd5?=
 =?utf-8?B?ZTZOSW00Z3Zsazgzdy9OdzNlTjJmeGNjTlJYdThTNnlNSmk3VFRyU1RSOUE1?=
 =?utf-8?B?VWpxVVlqOWJMaURFTDdTUS9POGtROWw2ZnZqbHdHVXgxUi9Vb3QvRlYyY040?=
 =?utf-8?B?YmRTY3BYYnZVMXppZnpHbzh5LzFtaVVJUVk2Z0dnTXJPUDVhZHJwbDZ3WmYv?=
 =?utf-8?B?VG82VFgxSm1NWmRtZEtjM1VnZEhNd0thK3NlWitYT2VVVW5yeHhHdHV1U2tj?=
 =?utf-8?B?c0JQUlZZWC91bXRuNHd1Vnp6cXRrOFVqZkNCZVA0UGJMdThCNi9Za2V0WW1i?=
 =?utf-8?B?TDNHS3dQeTVJSXdsRm1RckpldXptRWFKdEpCZ2ZQcVpUNHR1aXVmSWJHN0Vn?=
 =?utf-8?B?RjRWR2ZINzJNT0tmMEF2cWhDaW56RnlzTlpQMkE0RE42bzB0bSswMDh6K05O?=
 =?utf-8?B?Z1NVdXVNM1RTU1pFNjN6UUt2QVlwQ3JEUlM0ZTY5NEFhUmwzaWJobDhxRURS?=
 =?utf-8?B?MTJSLzJUUlVyb2tFRXlKRnlLeVNVY09IbFdMSUk5ZGllVkxHUnNXUG81TjU0?=
 =?utf-8?B?eHJMcjdSRDJycWRQV1pQc2tVV21kSndnOVRtcy9teXhUa2Y1aWNKN0xRd2Nt?=
 =?utf-8?B?MzVSSmRVZWQ3dWhKZldXVld0Z0RmLzVHSVlIcGkveGswNnNrVWxZYmV5TlUr?=
 =?utf-8?B?eWJlNkwrSWF1bEF6ZFJXVlZsVG5lbEhnRDZsY3FOWmRCSGQwU0s2bU9xWDl6?=
 =?utf-8?B?bkc0dUEwbStEVFFkLzhGUzU2T2xHelcwNDZ5TVgxQmpoRTQySDlDc2ZSUTF2?=
 =?utf-8?B?MzhsODlFUW55MEdiNDNKSEFxT1loRWcvbXkzbXJNeHJadSs0TWlWN1VXSjBS?=
 =?utf-8?B?YzRVcDdlaUQ3MkFYVElWQzQzQWdHYmcrbmRzNnVpUnVraU9jRFpxczVmbzYv?=
 =?utf-8?B?aUlUWkdYYTYrNDd6STNjWEZnZ3E4VkJmM2s0Zi9hSjBkcnYwNjJiRFY0UUdH?=
 =?utf-8?B?OTFLNXhKZTJmUG80aEo2bGFvTk1DMS9zYU42SXFmYW1UY0hnUWtGVGVEcjhH?=
 =?utf-8?B?U3dwZGVSQlhOSzhwdHpMTzZXOFkwMlpsZG1uU0ZZcjQvK3NoN1hHKzFveXFO?=
 =?utf-8?B?dDF2bkx1K3VoYkozcElGT25pQi8wWEF6NTVCRms2TWJhN2QvLzJpOFROckZL?=
 =?utf-8?B?bHp4SjBGN2JadnBTejB0cWE3R3I0WEN5T1JFb0Fpc3JOUUU4NjMzVHViMzNF?=
 =?utf-8?B?MHpOK2R0T3cyVXhxa2tCbVB1d0dlc1B5NTJFYXNEUmlwNk5lbkx3bGZ3Nm9F?=
 =?utf-8?B?VmVwSWNrRkI3NEV2UkErYWs2Yk1LNURGNVkzVVBEck9oM09jRVQ4eVhqSlFh?=
 =?utf-8?B?TXJOT3p1b2lOZ1dUa0RRWGlRanR2MUtIMmx0KzExQkZVR1JqVVJFWWJRS2Q1?=
 =?utf-8?B?aTltWk1ySkN0anJVVlFRVGd5SHAwcHkvMzdwR3FLUThpcmoxRFArNUo5YTJt?=
 =?utf-8?B?TVFQTlJRYnRieTQ5T1EwcXpMNWkyVU1abkJWdEw4NjJ2WnhoekNXVWVudmVB?=
 =?utf-8?B?dnNSU0s2TDM2UFR4UkpHbGJadHJvY1hEZUxoOHhKQVM4aWcrM2syOE4yTC8r?=
 =?utf-8?B?cjFmMnU0bHNyaUprU3ZEa3g3UURvRS9iZG5PTjJ4eUNQaWRmbVlERmRXbERv?=
 =?utf-8?Q?sQwu4h8Oj8+GsH+zfB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7adb7a-b74f-4f9a-39f8-08ded8d61130
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:38:25.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNoLJ2PifkgMJYQKXCaaXAQF0pxEbO6hToDfYIiv6kBEp/oe0wmDdtGm4IEY/DwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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

On 7/3/26 08:18, Srinivasan Shanmugam wrote:
> AMDGPU already has a global PASID xarray used by the PASID allocator.
> 
> Allow amdgpu_pasid_alloc() to optionally store the owning DRM
> file-private object directly.
> 
> Initial callers pass NULL and keep the current dummy allocation marker
> behavior. A later patch in this series passes the DRM file-private
> object for DRM PASIDs.
> 
> This prepares for using:
> 
> 	PASID -> fpriv -> VM
> 
> instead of:
> 
> 	PASID -> VM
> 
> Also clear any stored owner from amdgpu_pasid_free_delayed() before
> waiting for fences, so PASID lookups cannot observe a stale fpriv while
> the PASID number itself is still pending delayed release.
> 
> v4: (per Christian)
> - Add fpriv as an optional parameter to amdgpu_pasid_alloc().
> - Drop separate amdgpu_pasid_set_fpriv()/clear_fpriv() helpers.
> - Clear PASID owner from amdgpu_pasid_free_delayed().
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 82 +++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  |  2 +-
>  4 files changed, 85 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 684f40fce73f..669d0fff8cbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -52,6 +52,7 @@ struct amdgpu_pasid_cb {
>  /**
>   * amdgpu_pasid_alloc - Allocate a PASID
>   * @bits: Maximum width of the PASID in bits, must be at least 1
> + * @fpriv: optional DRM file-private owner
>   *
>   * Uses kernel's IDR cyclic allocator (same as PID allocation).
>   * Allocates sequentially with automatic wrap-around.
> @@ -60,17 +61,19 @@ struct amdgpu_pasid_cb {
>   * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
>   * memory allocation failure.
>   */
> -int amdgpu_pasid_alloc(unsigned int bits)
> +int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv)
>  {
>  	u32 pasid;
>  	int r;
> +	void *entry;
>  
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> -			    XA_LIMIT(1, (1U << bits) - 1),
> -			    &amdgpu_pasid_xa_next, GFP_KERNEL);
> +	entry = fpriv ? fpriv : xa_mk_value(0);

That's problematic I think. The xa_mk_value(0) value is not NULL and needs to be filtered out when somebody looks the fpriv up using the array.

But xa_insert() can handle NULL entries, but I'm not sure if xa_alloc_cyclic_irq() can do that as well.

> +	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, entry,
> +				XA_LIMIT(1, (1U << bits) - 1),
> +				&amdgpu_pasid_xa_next, GFP_KERNEL);
>  	if (r < 0)
>  		return r;
>  
> @@ -78,6 +81,75 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	return pasid;
>  }
>  
> +/**
> + * amdgpu_pasid_clear_owner - Remove the owner associated with a PASID
> + * @pasid: PASID whose owner should be cleared
> + *
> + * Restore a PASID entry back to the allocation marker while keeping the
> + * PASID itself allocated.
> + *
> + * This is used by the delayed PASID free path so that future PASID
> + * lookups cannot resolve a stale DRM file-private object while the PASID
> + * is still waiting for outstanding fences before being released.
> + */
> +static void amdgpu_pasid_clear_owner(u32 pasid)
> +{
> +	unsigned long flags;
> +	void *entry;
> +
> +	if (!pasid)
> +		return;
> +
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);

> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +	if (entry && !xa_is_value(entry))

I think you should just skip this test and use xa_store to overwrite the fpriv value.

Alternative xa_cmpxchg() could be used to replace the value.

> +		__xa_store(&amdgpu_pasid_xa, pasid, xa_mk_value(0),
> +			   GFP_ATOMIC);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +}
> +
> +/**
> + * amdgpu_pasid_lock - acquire the global PASID xarray lock
> + * @flags: storage for interrupt state
> + *
> + * Acquire the global PASID xarray lock with interrupts disabled.
> + * The saved interrupt state must be passed to
> + * amdgpu_pasid_unlock().
> + */
> +void amdgpu_pasid_lock(unsigned long *flags)
> +{
> +	xa_lock_irqsave(&amdgpu_pasid_xa, *flags);
> +}
> +
> +/**
> + * amdgpu_pasid_unlock - release the global PASID xarray lock
> + * @flags: interrupt state returned by amdgpu_pasid_lock()
> + *
> + * Release the global PASID xarray lock and restore the previous
> + * interrupt state.
> + */
> +void amdgpu_pasid_unlock(unsigned long flags)
> +{
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +}
> +
> +/**
> + * amdgpu_pasid_get_fpriv_locked - get fpriv from PASID
> + * @pasid: PASID to resolve
> + *
> + * Caller must hold the PASID XA lock.
> + */
> +struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid)
> +{
> +	void *entry;
> +
> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +	if (!entry || xa_is_value(entry))
> +		return NULL;
> +
> +	return entry;
> +}
> +
>  /**
>   * amdgpu_pasid_free - Free a PASID
>   * @pasid: PASID to free
> @@ -121,6 +193,8 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  	struct dma_fence *fence;
>  	int r;
>  
> +	amdgpu_pasid_clear_owner(pasid);
> +
>  	r = dma_resv_get_singleton(resv, DMA_RESV_USAGE_BOOKKEEP, &fence);
>  	if (r)
>  		goto fallback;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index a57919478d3b..c2be6f81d680 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -38,6 +38,7 @@ struct amdgpu_vm;
>  struct amdgpu_ring;
>  struct amdgpu_sync;
>  struct amdgpu_job;
> +struct amdgpu_fpriv;
>  
>  struct amdgpu_vmid {
>  	struct list_head	list;
> @@ -70,8 +71,11 @@ struct amdgpu_vmid_mgr {
>  	bool			reserved_vmid;
>  };
>  
> -int amdgpu_pasid_alloc(unsigned int bits);
> +int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
>  void amdgpu_pasid_free(u32 pasid);
> +void amdgpu_pasid_lock(unsigned long *flags);
> +void amdgpu_pasid_unlock(unsigned long flags);
> +struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid);
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  			       u32 pasid);
>  void amdgpu_pasid_mgr_cleanup(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cacdc99b3ad6..4610d6889e9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1487,7 +1487,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		goto out_suspend;
>  	}
>  
> -	pasid = amdgpu_pasid_alloc(16);
> +	pasid = amdgpu_pasid_alloc(16, NULL);
>  	if (pasid < 0) {
>  		dev_warn(adev->dev, "No more PASIDs available!");
>  		pasid = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index f7d5879c6e44..65b824144a2f 100644

> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -2293,7 +2293,7 @@ static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
>  	u64 meta_gpu_addr, ctx_gpu_addr;
>  	int size, i, r, pasid;
>  
> -	pasid = amdgpu_pasid_alloc(16);
> +	pasid = amdgpu_pasid_alloc(16, NULL);
>  	if (pasid < 0)
>  		pasid = 0;
>  

Please prepare a patch to completely remove the self test for MES v12. We have already removed the self test for other MES versions because the IGT tests now take care of that.

Regards,
Christian.
