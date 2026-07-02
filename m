Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E79C43327
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47C310E498;
	Thu,  2 Jul 2026 10:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oBNVwUYV";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D5810E498
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6INyYI36NhQQV0QiHmt7efGzD7X+l+6/1HAoRtiMFYYuOutg+B3MtPjdLVvEKATydOtqvVv8mzcsQauqxP1cyzrwOI+x15xo96fWGe/c91wOExSnYSscS8JuJKQoSXPXI8tLPOnfMeN07DZxmf5R7rgV6dXFqjAwDyAt0nm+IMZlMbfLhH4fJHyNiLFQfQbtdNeI1IGPVdLvbc30jeB8dIPDg5SDZ8JTFwwQUMdWMkwzAn2xgK5oQSQFiH5OQC3l06yAP+Iuf1kR2KrEp7xAWbrEKEVkQIaokp1uJBq3WR+U+46QOCZwYrfHKzb8zwB+eJvjYRK03naHCZyrzaEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=074A6d5FUaFSMy3kbCRJEwaomlASquTW2JFlMqtwW2E=;
 b=ILiblzEiA1K+NGeXtWJcTw3SWZConHRAC5gMwozdBtQtPuS1hEhpyTafeekEvJiN1cC3XCKqsO+0HWk6urdx8/J+UcNB81/RJ1gwQ7OYONjo9q6Ea94pS4OIRildvF8L/Hz2gbxW4tGwDPSEbfcNgfztS6ukOLBI+Gu4j7tmzgb4u8HFQoJ9l6gv79RKJ2IgFc2A7WSovcn8whyPuQbO3ZgLTMa4k9ViSKLhSkMtFtxWUIsdcWhbEYY7cm3ZBpgddU1owO5sThAyYBImkRXkpLIcOmHczD+fNaJ2EE37+F9EO9UqFsik+b9pWsLMS/a9DpSJR/TLFkLTuFQI9swmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=074A6d5FUaFSMy3kbCRJEwaomlASquTW2JFlMqtwW2E=;
 b=oBNVwUYVlThFwjIQntS4IhAtl+3wSZuBziyYeFtHvC346mxAdVH+6YDWyk5C7EWO4jwjCDwXyt+by7S61x4DnyWqeSrU3qcxNt7Qiijb+zyq0I8zc2JOzTXGHbkEVOejdry+lWufENwUOdg1WVC1RuW3j6/eWOUAyMatQh8eFho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:52:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:52:42 +0000
Message-ID: <5a6ad86d-64dc-480d-bb08-230e61534b79@amd.com>
Date: Thu, 2 Jul 2026 12:52:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amdgpu: Add PASID fpriv ownership helpers
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
 <20260702084021.3140071-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260702084021.3140071-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a16426-3091-4188-85b0-08ded8280a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Q+DW7YYTYpG04ERJwM5iKCcGwU3hWPQtkeTrcbIg9VY9MnMLnOqTabknd9I4BLCv3af5ANL710YVPrHYXPYb7cPV5v8AlgLTePd2t1m2opCZ3CeO8ar2avl4ziT7eYNMARYQYI4uCa6p4AsG2idCnJdoHdqaAKV1i/NCpCPISe1XEtsVi/BIweH0EyJI1Krt/su8ex0y6MyaD/MvtnX62zrTn6sPeXiVvJc/eybOx150pmnqRkbfFjlAXfez33+NRmd3WmzIj25aBqZU9d0jPy0NY4rWYt+NtIedVpAy/uv7H3MHp3tJrvbtzsuFjBbsT/NOrU08Ey5C+TSbxYiftLdoOL34YJ0HhKvc+2j1cy0bwZBcAmK3QJADNBYATYUpYotoBNw8M9GYux0ZvXMdJhYhhZzUtbM9+wUyP3so3MaSOdEHtqv4igFE6hbm+qrMYUF9YOQicsBPmBuoKWKuOTjUFW+W03+ITrviIcAKXKEEyX0VxfDg4DCXDU7MVd2hoenDc2c5DmJMDvTwAPh1sz+G46Lim4psnTU01YsmFJVygo2H2osxbbpAvc1Zr1m8hgsWGj74FZJnKXOCSD9IjApyEHhxf48ZjUpvszxHXSMrPmbt+H7cHYWY6DOqV8ikulTUH8s1OwndD+yfByht/CzRgqqaOeZjKcJkbUFp1Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGg1QlRnemVUYzZuVUtCb05QUnBOLy9pSFBpR0tiRDJQSXdvenhmU09yb05P?=
 =?utf-8?B?VFFBYnA0YlRZSGxXUVVtRUxRZW1xVXVhODZWN3RySDlLSkZJY1lZTEd4SkRD?=
 =?utf-8?B?SzZUVzViVUpXZ0FCeUhzUTVLNmNDMmg2Z2VwRGp4Y3hDVXRLK3ovQzBsMWV5?=
 =?utf-8?B?bVhtUUdDV3duUmIyMkhYaHJIQjFLeEtCNVBqQlcrR1g2aDlnNUxsWG9JUjFY?=
 =?utf-8?B?UDdxOFN5R3dWMFVEb1N5YU1SbFpLcWVqcEk5cnp5cERpYm1hNE1xVlJXSWFT?=
 =?utf-8?B?bHZGcjdrR3U1WU9EVTY4b1pnSlNrTm0vMzVra2J4cWhIeDhxM2VMNHRYNnQy?=
 =?utf-8?B?b3BIVnh4UGI4UFc4UFB4YlR6N3VEbDh3a0tQNzl0WWJEaUJnL1kvZms2ZkRU?=
 =?utf-8?B?UWllNy92OVB1UHFReGVHM3Y0M2pvSG53ZzlRMmoxMFllM3lKeUhReVl2Zk84?=
 =?utf-8?B?LzBMeloybGVjcVFiemkyNVIrUE1jMzRiam5MZjV5bUlEMUp6d1BqdVA5Tjg1?=
 =?utf-8?B?aGR4dXpPdWJQN25JWEdSelhQNHhLSThOc0pvR3oxYUQrREoyT090K0lWcmlp?=
 =?utf-8?B?SG1nQTd6L2ltdkNTNlgzVUpzaVZQdDFYZEErbHRMNE55NllCUnplMUtIMk5L?=
 =?utf-8?B?SC9CZXpJU2RLRjN4ZWxtc1RoelliQ0xUNGpEUlFVYnpyMzdibUNpbk5aR3B0?=
 =?utf-8?B?aDJTbmNxVVpQbGJiSHY2d1NFaEhTSkNuc3VhNnh1TVZ3OFVOdThuQVlKQkNp?=
 =?utf-8?B?andhNDI1bFp2cWd4ZlN0Z3R6bkF3aDhsSUJNN3NzUllTdXlZcjlSL0hESGtl?=
 =?utf-8?B?UUp2b0JGalptZFZoKzBQYzFkSFdhTFpwRVlaYnYrSzJYNGVHT0ZmMndNKzdj?=
 =?utf-8?B?UGhsNWxZRWt2U2xTa1BCbmpSNFdjazhVYUhnNmFwaUoyR29BQUN6SU01Z3Ju?=
 =?utf-8?B?OWh2M3BpT1VVN3RzU3lVdDVQV0lVSWh4aGI2M05CUVg1bDBEd0hSVmJLU0Y1?=
 =?utf-8?B?c0wzdzdTQk8zd0lPTkEzR1VJNXRPQU5HeTZ5VmloMEdvVTdKWWUzSlQvRWhx?=
 =?utf-8?B?UU9DZ2pkclZkbXhXTUMxU0tMS3hKUTF4ODB0OVJQWGhMNXc3MmxtVnVFYmFR?=
 =?utf-8?B?ZkxZbkI2ZVZ2S3NIbEpLaTh3eTVCRFhleTYxRnNFNVhJc3lsc0w5ZkdHYUR6?=
 =?utf-8?B?TUVhQi94aHJVbUNJUXl4Ty9USG1PTm5qRFQ4bjE3eklJMS8vUVB1UENXTGlE?=
 =?utf-8?B?QS9mU0l2RStEdlU5V2prL0xna0xRcWpOeFZYV0ZlV3NGdGg4bFZKZ0xjWnJB?=
 =?utf-8?B?SXhPaGtZb0gwenpzUFoydnJiN3l6QXN4cFkwRG1PUWk0QTdFYkd1aVhjS3NV?=
 =?utf-8?B?ZGRSQTlkcTQzQTNDZ2VlMXJldFQxNHhBY3UrOUZvZjJ2OTZGVk1YK3FzbTQz?=
 =?utf-8?B?cXcrK0oxU0VYcWg2L2RCMHZmZmF5bHdrN05OSjVvRStFT2l0cXBBNjhFaHNQ?=
 =?utf-8?B?aTJMb3JyOWhOSjdrTjRLNFVoajlENWxZTVR6bmUxREJRTHV2aFFwNkxia2Ju?=
 =?utf-8?B?RzZ4OUhMRzkwR0x6eURRKy8reitqUjR0aHczejRYZmYzREM1RUo1SVp4Z3Nq?=
 =?utf-8?B?RUNoZ2d2QkFJbHZzNkp4Ky90dlRjZERObkNUcWVIT3lud3ViangvQ1FGdmVw?=
 =?utf-8?B?czZrQm5SMWh6WnpsQmpPUE5UeWduUzEzUytXbFV3MDdUZUJsTmwyQUNCbDJ0?=
 =?utf-8?B?UjBHaWRJWitIVHBkNkNYVndsc2VDQ3UxQ0VleENId1pWaXNWSnUyaEd4dnBI?=
 =?utf-8?B?SHcwZGhMYTdacXlmWVZhQlZIcHV5QWlZYmp1eDNLTGMvelBQa0VxVEF1ZTdZ?=
 =?utf-8?B?cG81MzdjSHpHK2FIZEVFenF5SFhhVnRRSUdsTWwwZFMyU3RvcXlYV2dvMWc0?=
 =?utf-8?B?eTkxQThRZWszN2ppN2RGT1ZFQURlcXhwYThFWE9UMUd0eUt6MWJYbWM3YzFw?=
 =?utf-8?B?L2xzdjV4Ky9JTDYrb3pxWnI3eGdqWWsxZzRnZmVhYVhZcjJxZCtpRXFDWlFE?=
 =?utf-8?B?cVJGS2dqTDlNVjZuak1kM3I3VThuNVFOaWVMYkdVbE92dlU2VlR2OVFIQXly?=
 =?utf-8?B?Vi9iZkhZNzA1R1ZQdHhjWW1pNnV3aGlra1dGSXFuY2xWWGpZaGVHeEszMXhU?=
 =?utf-8?B?QVVEbGROTmY5b3RaZnY2b3VlUVlZNzR5K1FRcWI5bmJjMml6MVpLTnZkc0Rp?=
 =?utf-8?B?STBRTm0yVllIYmxlVU5STlRuTW1jYzhqWDd0NXBaZ2xhdzV1N2lZMEpwbko4?=
 =?utf-8?Q?t9pBeiTy7YSunwdg6i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a16426-3091-4188-85b0-08ded8280a85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:52:42.2666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DBwrDOeJCDTvfBDw/mkRnaDiElsfU2n1ggEqLXQBXM+8x5KRuBBZ8Dl7MhoiKsW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

On 7/2/26 10:40, Srinivasan Shanmugam wrote:
> AMDGPU already has a global PASID xarray used by the PASID allocator.
> 
> Currently allocated PASIDs store a dummy value in that xarray.
> 
> Add helper functions so DRM-owned PASIDs can store and retrieve their
> owning DRM file-private object.
> 
> This prepares for using:
> 
> 	PASID -> fpriv -> vm
> 
> instead of the separate per-device:
> 
> 	PASID -> vm
> 
> mapping.
> 
> v3: (per Christian)
> - Document that PASID allocation is intentionally kept separate
>   from fpriv registration because fpriv is not fully initialized
>   when the PASID is allocated.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 126 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  13 +++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 684f40fce73f..5333937f0d04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -78,6 +78,132 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	return pasid;
>  }
>  
> +/**
> + * amdgpu_pasid_set_fpriv - register the DRM owner of a PASID
> + * @pasid: PASID allocated for the DRM client
> + * @fpriv: owning DRM file-private object
> + *
> + * PASID allocation is intentionally kept separate from owner
> + * registration because the DRM file-private object is not fully
> + * initialized when the PASID is allocated.
> + *
> + * This helper replaces the temporary allocation marker with the
> + * initialized DRM owner.

Taking a closer look at I think we should rather re-structure the fprif init code to allocate the pasid later.

> + */
> +int amdgpu_pasid_set_fpriv(u32 pasid,
> +			   struct amdgpu_fpriv *fpriv)
> +{
> +	unsigned long flags;
> +	void *entry;
> +	int r = 0;
> +
> +	if (!pasid || !fpriv)
> +		return -EINVAL;
> +
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +
> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +
> +	if (!entry) {
> +		r = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	if (!xa_is_value(entry)) {
> +		r = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	entry = __xa_store(&amdgpu_pasid_xa, pasid,
> +			   fpriv, GFP_ATOMIC);
> +	r = xa_err(entry);
> +
> +unlock:
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +
> +	return r;
> +}
> +
> +/**
> + * amdgpu_pasid_clear_fpriv - unregister PASID ownership
> + * @pasid: PASID whose owner is being removed
> + * @fpriv: DRM file-private object owning the PASID
> + *
> + * Restore the PASID entry back to the allocation marker before the
> + * DRM file-private object is destroyed.

That should clearly be merged into amdgpu_pasid_free()/amdgpu_pasid_free_delayed() instead.

Regards,
Christian.

> + */
> +void amdgpu_pasid_clear_fpriv(u32 pasid,
> +			      struct amdgpu_fpriv *fpriv)
> +{
> +	unsigned long flags;
> +	void *entry;
> +
> +	if (!pasid || !fpriv)
> +		return;
> +
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +
> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +
> +	if (entry == fpriv)
> +		__xa_store(&amdgpu_pasid_xa,
> +			   pasid,
> +			   xa_mk_value(0),
> +			   GFP_ATOMIC);
> +
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
> + *
> + * The returned pointer is only protected by the PASID XA lock.
> + * Callers must not continue using it after dropping the lock
> + * unless additional lifetime protection exists.
> + *
> + * This intentionally does not add kref/RCU lifetime handling.
> + */
> +	struct amdgpu_fpriv *
> +amdgpu_pasid_get_fpriv_locked(u32 pasid)
> +{
> +	void *entry;
> +
> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +
> +	if (!entry || xa_is_value(entry))
> +		return NULL;
> +
> +	return entry;
> +}
> +
>  /**
>   * amdgpu_pasid_free - Free a PASID
>   * @pasid: PASID to free
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index a57919478d3b..220a0ba0cfb6 100644
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
> @@ -92,4 +93,16 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>  
> +int amdgpu_pasid_set_fpriv(u32 pasid,
> +			   struct amdgpu_fpriv *fpriv);
> +
> +void amdgpu_pasid_clear_fpriv(u32 pasid,
> +			      struct amdgpu_fpriv *fpriv);
> +
> +void amdgpu_pasid_lock(unsigned long *flags);
> +void amdgpu_pasid_unlock(unsigned long flags);
> +
> +struct amdgpu_fpriv *
> +amdgpu_pasid_get_fpriv_locked(u32 pasid);
> +
>  #endif

