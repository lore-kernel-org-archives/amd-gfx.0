Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5711CD4F52
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1574210EB87;
	Tue, 19 May 2026 08:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wvMeCmue";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4126C10E3C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOvNGA9yqfaZz4412IxyH7SHajqsyBEsRNqQiOGNtCpkFh8a8tSEQyl2m3d8WhnPbz+l7GLfZI63HPoh4zKY0MzGxV0bY1DewKgIdurFCz1710AOVMYzcs6+Pf9I4HaCIcwSSWqGiXLF7x6coDlVu03ztchR1dZxBpbHMo4ZafQcY9D1Koy8lPd9laDbO72OuskNvxQ7jnMZMt555AvSos2looIelH3+mUHT+qMTO/iv8PW4lvj7p6bPHMsMJ1VBaKh7v5yRZEqVZTXiZuBO2JqCpGLJqDAOud+T8QGmZUcU+hq42lc8ySIMtCxz2Vn2yDW6AzRdmxSKk+DQCWqbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtWqBn3TB6OVig4lf6djKPDhJoxxFzrPYjW+9BkwGqQ=;
 b=MC+0CnQVTGwzUU+mMw9wSbV90kQm1xg7/qKIsPdKNo66T0jBCOhk8IdpDBtdmU7Vt/fh0dfESlPvB6A+PSpAQI81ic7dwJ8pefucXdSWPWx+9NIGHtGU0dxqdPGtx2epCgeHG2inICT6Thi/V96O3fY4JcilnvfTsOKDX+5dYD3RzP2AA23Oq8Jj6jpTB9Zdw3sud1Ffnt+pSISwyUC5BakmfctZEOrVelpRgTPXQaNT06jcMcCeBbUPodwQOP4QpwUZLa3X9LEDZjBVzcs59Ez041miKL4gR3uv9aDkc3Rw4lxIvva0E6ihV56D6IBk0259z2492WJEmjrVuntaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtWqBn3TB6OVig4lf6djKPDhJoxxFzrPYjW+9BkwGqQ=;
 b=wvMeCmuebe3HQ9GxHg761+69JEcD4Uw+JtDaSaSYounbUgfTAC1TV8xE5dvZnRPKFVfh2dKsikmKuwOwWerZ1q7kzGNLcnUgi0EVhw6g9+5TEQw1JidpiGDBoiiKaQns1h4+2axAkoQJXeCExnNmJ2TAmXdmG0SKcrMou83W8e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 08:54:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 08:54:14 +0000
Message-ID: <69dcb4d8-1199-45f7-88dc-c77efb248542@amd.com>
Date: Tue, 19 May 2026 10:54:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: Use placements of 256M GART segments for
 SI/CIK
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <20260519082204.60811-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519082204.60811-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:207:3c::45) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d836852-be55-4c9a-6a98-08deb5843405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: Lv+ssCm7LFkbJLTixWRBS2a/lGhJNrtNMXGUgRCMmezmeKgjLjKOoUFj8GmLuGLZv9aAzMrhOez3uVLdHIqrezO8SAKvsqghuTEdem7Di26RZ/Z9bMnPATSGiar8JYz3Iaoqvb41zisMdAdYou7VBbFbKfpI8sXx+MvVfWnHQjkPs1SCjaejSwVa062zTR4mVOCGeef5pKFet2Gnf1PoF+Af0juVtJ8gocD0H7Jf4FNuByTqlS1Y4Agl6NJB4/daEEYAFcvZ+moZfB9QnFPMgSGoOJOvz9fwqn/lxK6N9eybgnSA7jWBb6MYVm8FDXmMO9uUDihDjmQWxeb1Zjlv7CfT72DIjr7j58UNUsmaDl2dsDsVN0J5jNC7syXZDULNJqcugy8VirgPwfb3cpkf166GlAkD4HBHxEzK3jLmO1JE821bQOHSbR3s/0dt8GxbYrrp6pcbXZeQPmq3WStnjeujq9LZS21rCO415MZkqFw/+pwxqWPimlePtwQId+BQHweHgQBl++cSn/d0ltwayIiEWNy7VBji7TzOOzbdftOQqh5RWYGHLtEUokEviU5P4fLBDWLVdfMbIKuAj99cJONEJRf4W7I9xe6mFiDss0+SdM/ffiBEfJJgMcRqYZFahw931HFbzYZ+0zv/CqvGqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFpVT3ZZUHZ6ZUFHemhuNjlXSlZuU3dRNDdTOTgza0ttZzJJV3hvcFFYeGZB?=
 =?utf-8?B?S2JlUTA2MldaOWZ1eldXNWpPR0JlVWUyM3NvMXlHUmZwQ0x4OFNJQ0hvNFo3?=
 =?utf-8?B?bXo2Sk1LdUJqeXc0cEFoWExUc2xUS3lFditUOXpLTVJIRHo2ZDRGU05reW5E?=
 =?utf-8?B?YlJQL2ptdEwyZDR2bFMvQzNhc2JVRVdFQ0VEMWNMWnh2VFIydUQzWGwralRU?=
 =?utf-8?B?OC92SUtvc29kY3Z1L05YN3hyWHJiTE9IVGQ2eERyaUFqR1BOL3U2a09TK3BX?=
 =?utf-8?B?Z3ZUU01mNzBpQ2x5M0lrOWpvUHA1RXBvTHRBYUtNV3lNcjV6Y1pUWTVnekZn?=
 =?utf-8?B?NzlZZGdCZllRUjVlSVc5ak9wOFFRa2xoSVlScEdzZmJzU0g0MFYwaG5HK003?=
 =?utf-8?B?VEhLR001ZkkvK0RzcWtFY1VyWW9BM2p3V2h5TnBvb2JmdU53dDZkcnRJd2Z0?=
 =?utf-8?B?VWNXNy84UG5ZOWxyYmE3QUlGTk9ZdU81SnVzK1ZtMUpNaWtrV2ltNlh3ZnRD?=
 =?utf-8?B?dTV5RStVUW4reS9SRFZVZUEvVW5oUFFNUUMzK3hGTk84QUFyN2wrUTRHY1NC?=
 =?utf-8?B?Sitya2IzZUJ5enl4MDdCVTVGUE5ZRzNvOS85OCtUQ0JjZ3VNSkYzcGJLOGNH?=
 =?utf-8?B?UlBheElkSUNaZGV3SFZONUo4MkdacCthd3pmYmwrQmcvM3VvRE53TEdKdzNq?=
 =?utf-8?B?ZEJSQlVxdDJuUXJ0MWM4azVna1VSS3JkVzVsRnpDTFpxZmY0KzhFWVBpN0xK?=
 =?utf-8?B?TTZ1MlJydTlJYzZ4UXRVb2lnV2w4ZjYrdE0vcDlLZjNrOWkwd3JxUmprSFZo?=
 =?utf-8?B?STlieWRCeTVDaWdHUGpsQ1cyYXpSQytYRG1ZcWhxL2JhcnNKNGkwV1kyZm1F?=
 =?utf-8?B?dmh1WUpVblc2eTJiNEJYUDVsUEJ6QzIyQUpTdVM1RTdJMjgyZW92SHo0cjIx?=
 =?utf-8?B?YkprTWd4L21rcm4vbkNaOVUzVTRWWTcxWHJ6NW5pOUJzZXN5U0dYcUlEeDhu?=
 =?utf-8?B?T2paMEFRWnVKSytOeENLUXNxSVI3UmNmcGpiNTdYMGxqNlV6bHFIa3VFTnNy?=
 =?utf-8?B?Nlp1dXlQVVBZekVXSDBoVWZ4RUc2clN1U2JWeE8vY05rZThkbVJZMmtIZ0lH?=
 =?utf-8?B?NUhJOVQ5T05jYXNoUkRqYVl0QncxQTdvc3gvSXYrQStLSDJvMm5vMmFPdTlU?=
 =?utf-8?B?NVVaWmRRcllqQ3prcmVjQjRnTTYyL2U1M1FJelNwOXk4TmNscnhUUWFyR3hw?=
 =?utf-8?B?TkMzRnRXa1RLZFpoanZoWFZQOGFOTVR4bVRBUi9BMms0Yk51RWpqYkFBZ2tP?=
 =?utf-8?B?d2JCV2dlV2FrN1R3VmZLQXhqaXd2T1FBMnBhQWhnek1KeGg2cHZybTArdDJk?=
 =?utf-8?B?bUU0aVlVWUg4aUlENndhdk1DN1JJNDhDSzhGVW5KSjlreU56MjJ1THdQZkdD?=
 =?utf-8?B?M3BEN2U1ZVJWMGJKbEdacmxWSDJpNWNVQklaK0xjRG56WDY2K0JZbmYrUk92?=
 =?utf-8?B?Wlo0cG5aYjJIQjRndGQ5dzNiUndRemEyU2FWTUNWQWIxQ2Z2bmVrTE9URXY4?=
 =?utf-8?B?Vk91K0tWRmRaYzBWbFVlV3d1M2dxejFrNGgvYzVWRjRBZTZiL3BVbUpxcTdk?=
 =?utf-8?B?eTFmbDNscjd1RTl2UGFqM1dLZjVUVEJZN1E0WDczZjRiTTFPQllrYWZnM2VO?=
 =?utf-8?B?aDRNaEVUd2l6bHVUWWpQalRzbm80QUQ4S21sUENtRjNvY3E0WS9PRGdMczQ3?=
 =?utf-8?B?T0xWTzdSQ3pCWEwxbEtYdkxNbUNjRlRvM24wNHY5d1pyUmxoYXFKa2ZSOTZG?=
 =?utf-8?B?Q0JJUWJhTU03ZmhsUC9nL1R2TXlScy85V2xZMzVLOWJLYzhWcktlK1EvRzc0?=
 =?utf-8?B?cXFsdjZnVEhkejM1bkVmamphRDNuSWVJbTA1YnlQVGVVcEUwS050eFU2dkhC?=
 =?utf-8?B?SlZYS21YUkhDeHhXa3VKYm1uUXZFa0dROFdQaFpkVHVzcTNSRGphYXM0ZVdT?=
 =?utf-8?B?eEs1d2hnWFdMU1pkMDhEeXJKMlU0ZWFHQkZvalExKysrMzVkMGd4aUhoQVFG?=
 =?utf-8?B?dG1sTlplVDVyTzFyWEJ6OEkrZy9Ielc2TWV0bVc1bWxtL0YzS2NzTWhocjE2?=
 =?utf-8?B?T3hpSWN3VlIxMEs1dEVTV2ErajlvaW5WY2lzelJGUm9nemFMSS9SOHhFRGs5?=
 =?utf-8?B?OWVXdWo4eWZWRndxMjg2ZDFVT2ZPb2VGNUJjTUJuNGRZYVd4ekZXVVZrSzYz?=
 =?utf-8?B?VlBsYmlKbG9Jb2ZRbUd2dGFOQmp5dDBBbDdxc2Q1SXg4WEp4RGdsSk1aelh5?=
 =?utf-8?Q?l1sFzqJGGjmwBIiYvm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d836852-be55-4c9a-6a98-08deb5843405
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:54:14.8623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce/VXiWPy+Qnr4lobcdo5lLVWhxJQe32NWUZoc8gIne7hlEi8TKkfm4li1DWMjp9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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



On 5/19/26 10:22, Timur Kristóf wrote:
> UVD 4.x and older require that BOs don't cross 256M segments.
> We need to respect that in amdgpu_ttm_alloc_gart().
> We can't move the BOs later because GTT->GTT moves are
> not implemented. We also can't force all BOs to VRAM
> because that becomes very problematic in low VRAM scenarios.
> 
> This fixes UVD CS BOs crossing 256M segments
> when they are placed in the GART.

Clear NAK for that approach.

This is the general TTM interface function and shouldn't have any HW generation dependent code in it.

Regards,
Christian.

> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4799
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 56 ++++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++
>  2 files changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6c6ab4dd6ea9..a106c7e77e26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -959,6 +959,40 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>  	return 0;
>  }
>  
> +/**
> + * amdgpu_ttm_fill_gart_256M_placements() - Fill placements array with 256M GART segments
> + *
> + * @bo: TTM buffer objects whose placements should be filled
> + * @placements: Pointer to an array of placements
> + * @max_placements: Size of the placements array
> + *
> + * Fill the specified placements array with 256M GART segments,
> + * starting from the highest address in order to reduce the
> + * contention of the lowest segment.
> + *
> + * Returns the number of placements filled.
> + */
> +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
> +					 struct ttm_place *placements,
> +					 u32 max_placements)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	u32 i;
> +
> +	/* Fill the placements array with 256M segments, starting from highest. */
> +	for (i = 0; i < max_placements; ++i) {
> +		if (i * SZ_256M >= adev->gmc.gart_size)
> +			break;
> +
> +		placements[i].lpfn = (adev->gmc.gart_size - i * SZ_256M) >> PAGE_SHIFT;
> +		placements[i].fpfn = ALIGN_DOWN(placements[i].lpfn - 1, SZ_256M >> PAGE_SHIFT);
> +		placements[i].mem_type = TTM_PL_TT;
> +		placements[i].flags = bo->resource->placement;
> +	}
> +
> +	return i;
> +}
> +
>  /*
>   * amdgpu_ttm_alloc_gart - Make sure buffer object is accessible either
>   * through AGP or GART aperture.
> @@ -973,7 +1007,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  	struct ttm_operation_ctx ctx = { false, false };
>  	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(bo->ttm);
>  	struct ttm_placement placement;
> -	struct ttm_place placements;
> +	struct ttm_place placements[AMDGPU_BO_MAX_PLACEMENTS];
>  	struct ttm_resource *tmp;
>  	uint64_t addr, flags;
>  	int r;
> @@ -987,11 +1021,21 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  
>  	/* allocate GART space */
>  	placement.num_placement = 1;
> -	placement.placement = &placements;
> -	placements.fpfn = 0;
> -	placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
> -	placements.mem_type = TTM_PL_TT;
> -	placements.flags = bo->resource->placement;
> +	placement.placement = &placements[0];
> +	placements[0].fpfn = 0;
> +	placements[0].lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
> +	placements[0].mem_type = TTM_PL_TT;
> +	placements[0].flags = bo->resource->placement;
> +
> +	/*
> +	 * UVD 4.x and older require that BOs don't cross 256M segments.
> +	 * We need to respect that here. We can't move the BO later
> +	 * because GTT->GTT moves are not implemented.
> +	 */
> +	if (bo->base.size < SZ_256M && adev->family <= AMDGPU_FAMILY_KV)
> +		placement.num_placement =
> +			amdgpu_ttm_fill_gart_256M_placements(bo, placements,
> +							     ARRAY_SIZE(placements));
>  
>  	r = ttm_bo_mem_space(bo, &placement, &tmp, &ctx);
>  	if (unlikely(r))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2d72fa217274..e9de628c8d2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -202,6 +202,9 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  			    u64 k_job_id);
>  struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct amdgpu_device *adev);
>  
> +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
> +					 struct ttm_place *placements,
> +					 u32 max_placements);
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);

