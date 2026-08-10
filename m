Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19AFC5AD4E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 05:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E9710E60A;
	Mon, 10 Aug 2026 05:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wHMPysjb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9EE10E169
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 05:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrPq72w1blKEiGIHUuR3d/sXbvk7FjPVb8ENKHbTyEHfantIhgjH4Qu3N7kHWJXJIwA40OgrthW2hqgf/kAIcwq6G2PRKSftJIbit9Lwu6F/PugOPI/uChU+xVO9msndQv5CmKDf8PkvCyb+KqJUPuZghwCsFwSHJD0ePycznR+SRygW2rjUIv+9WDoWQ6ycm8POAXiXx8jWXSz7t+UGubuQC5O4RyDn/P+EgIJzlDfQXcndf5GyZPv83VZq+ac1l4ADX334epBfY29mAz/6FZhUo/iyhd1XUeNRbRgkZst9eoO3MPLb9hTawwTLS+j/h6Toc/fxa9EZn8rSBhataA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWnwuFpj6y5rf+s/ttNn4ZSdCVeGeRCScxZ16+0NTy8=;
 b=SPPlOhj+KoLOfMt2AkKNohzDoOAaXHA3uGcSdAEGJd8ZaUAQ3UhvohYqe1U8QP1mGAMFPK7M+kwqxl8Fu/d35u0b6kECBN3MH0lIouKwmuXUqI5uVJnro5zsn+790y8EyQs8dkrRiuZPPpBAoyeYPfQO4ypkIEg8usAFv4UG0JHuRegOe8tpWO+Ca9p33mNz9KUJNUdMWp8eAaHWcfd87wTOYmRKnHjdvh/9ONgM0vdYmOf3eIgTeGctW0oQyI/cT1TMYdUGO+9i1oChYbPGrZ4hTtugp1jdylsqmSaqJM3mkeUi9Wogojw8ScTEWdkk8drlvEzWETznnsUGWPGXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWnwuFpj6y5rf+s/ttNn4ZSdCVeGeRCScxZ16+0NTy8=;
 b=wHMPysjbiOs51nY8vYri3+pKSXAxSXDdgKRwuz/hODyJYRNOS0FwiAM9pGI39fyde0DYukie2oq+nE6wsD+IZ0qqYqEbo2zRnv78X2QznMjC4MU7QgJb3dXpr3Xm8TIsLJg7RaaL5LuOB+AEh3A8/x4ZC1RciawTT682NBive78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:29:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 05:29:34 +0000
Message-ID: <a519390a-13bc-4147-888c-8b91c0c9fcae@amd.com>
Date: Mon, 10 Aug 2026 10:59:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Remove unused functions in smu_v15_0
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Asad Kamal <asad.kamal@amd.com>
References: <20260810044220.3821511-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260810044220.3821511-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 697927eb-63e7-4e68-be1e-08def6a05c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PWVROl90ppnZ2ib+dGYChRARR9rw7/QcsTaXtGg7VIRzFJnQsB/8ApHljh6/tZ5hLw7TdD6IdndFn3Q6yVfOalgVdYw3gWrdsLMJRAYQtsl5QWzWTxTHjfGiwwGHO8j2FlDGdt5zSUtUsr3OI44sN60Qa75Ua4SPuZiNmFI4emtXZyvBjalN52iIt2mvkMmyj206WpBID+3vZhGcKofmYsEt/BeCOz3VO/cApFEgWsJT9uSWP8Zrn5AY9oE18F3RUgkCavFwO7H5mHGiWF4c97lCjl1t7BUisRw2NOS++afmFOg+upQAukfTOhDugIolDclx+Tj5+XEvDjj+tSFJqWfjo0tlKfgjNnarN9dzd48dWho2MTEGRVpCL8etr5AgW0HBJyypBwTR1+DUPmw19Wfz1N7OIyS2JkBGvmQBsWv5MpppTAKKWIF5MF1IaKgRWr141+p9awUnEh3frefZ1VjvFPu75adeFRmvHWb5fEULQX0wF1GxQ3raJkwfvgvzNv9oxWSTa2c91w1uqrrxYXtmojHBW4nRgyueg1dKwo4jYRQcRIsK2pIrP+jpDe9osNpkp8JYdo8cEGC1sNdjTIoj7KvYhPp932JaYfwibP+G76pi1j86joC95OuQpdSHHiYdi1VOJ0apOxk/qur6cfpbd7wOXXIXC+298g4z8zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZ6bGoyM3RUVUxMazBkVzNqd1dERXN2eDA5Nm16anY5NkpNQUsrbVFIZkgr?=
 =?utf-8?B?ZmpDUTJxOVl5TU9qMnZGR0V3TDJwT2NHRVhpZ3hTMkg0WE9ESTVLMDBJUzhI?=
 =?utf-8?B?ZForOVdyL1dIYVJyNkNNeHNKWGtpS0E1MWo5eGJ0LzBmWmlzTGRUR3JlclV2?=
 =?utf-8?B?QWhTVWVFWlJsY0pXa2pFYnFxa0kvZjVtQnpFTmZJamNZY3BkZUdvSmJQR0ZB?=
 =?utf-8?B?eHlVc2swWkF3RzBMenl4bHF4UDlReXNyWDdBOGZqTUlxR0U1Slg0MksrTWI5?=
 =?utf-8?B?TjVxNlhheEV2NmZtTUczeWZDdlVmM1NiNHhBYVlKN0VlQmNxTE1RNWdCMWRP?=
 =?utf-8?B?MUZoNUgxVTVNb1NXSzNJaHJqT2xRWXVtamYvVHlScHBKdWJOMTVWUnRmNzB4?=
 =?utf-8?B?WmY4cWdRaThiTTgreG9rdzBRT2hxUEhJZDg2Q3VXR2hJOW9NMURvRERPeDY1?=
 =?utf-8?B?MlZ6Y1dlNHZPNDdQc0hBRlA4NWRObXR6WmVGUk1KZVd2OVhvMks2Sm11emdF?=
 =?utf-8?B?cUN6elArL1U1QmxmNzZwRXNWVW5nQktUMUtiUnFOT1hMTm9lQlJjaTBMc21w?=
 =?utf-8?B?dmIvOWsvbTJFeXBmWnVpMmM4NjkzK0RUMWRBT1RIZXUxVEo5d1pWZWZsZFE5?=
 =?utf-8?B?ck1ydEdiZUxkN2ltSUsyUUZxbU9RWHkzU1M5ZFU2T0J2c0I0cVNYc2JzTGdh?=
 =?utf-8?B?QU9VSUtWZm5zWDBuaFFqeDQ3UTFPNWxKZVg4UjQ5RThLeWRwUzk4NnpTT212?=
 =?utf-8?B?YnBINGtGbFk0bkhCd0J1R3IrNjB1eFQ1UEh0ZjdMNnhkUHIzRG5INDJ2elVB?=
 =?utf-8?B?UEFvSEFQOTJrVW9wdmg3WmxTYTIwblFrMW9ydUdPT1dDWVorQXpxOGd3cDNr?=
 =?utf-8?B?MFFIeXY0amh3eWFacUF1aVdWV0RwLzdHeG84MXYrc2UxQThhdzZNWDQrVlJE?=
 =?utf-8?B?NnkxaDJzZk5tT0hkZDF1SVowTFhmVmQ5bGVzb0lvMDIxR2dNbU9ZcWtFYzVO?=
 =?utf-8?B?bWZwbmlXc01iWnIwSHUrVzFrU2YrTnBqNXFtZHlQMVZuNGdnRkRyaHFJL3J6?=
 =?utf-8?B?SFI5YlRBTjlUYzE3ay9nMGh2akVSNHlzTDN3Slg0L1hpSk41VFF6UnFsWTY5?=
 =?utf-8?B?MThUUmFXYUp3cHZtQUFHaW9YQmhyVWZ0VFRjY1U2RjdYNHZxWUdYd3pwS05G?=
 =?utf-8?B?eXpVZlZRQTBrcjVwbkJxWEZyZUhCbDAwU3E0NU9aOHl4cFlCWnEvczhFN1N3?=
 =?utf-8?B?bVJ1Q3RFSkZlUTNrUHFUanNtclBMbGtnZ0VZNnBSSGF6QmVOZTg3L0pGM0Zq?=
 =?utf-8?B?cjU2cE4xVzMxamFtMTJjdlJ1aXpCc2MwTVFzRzRFWmpYYVpBMEFVdmtVTnIr?=
 =?utf-8?B?S3c4SE1CeHA0MlN5VDQ5M21VMGQ5cU5Db2hmb0dSd001d1pjYzdpRllGdHNZ?=
 =?utf-8?B?TlRjSEZZOFI0MWp0WXNFV3BsS2VoY1ZnZ3V0V2EzTVhwQllLWUtmZVdHUDhq?=
 =?utf-8?B?Z0E4UlVoODc3MU50WGNMbFIzenRJaFF0K05vSFc3VDZscElETGtNUk5Zbnc2?=
 =?utf-8?B?clFNM3oyaDczdlJDYjBZeXQ0bnBTMERoV0tLYndGbFh0OWg4Q2F1SGNWamdk?=
 =?utf-8?B?Uk5mRXY4RUcwMmlxdDY2SUluWFNEOHN2VmpNU0kyVnVtYnptV3JEQmJKaVg5?=
 =?utf-8?B?TG1OUlVRTzUxREx1OCs0b0tQMFN1eEVXV05wbHNSVHhJZHdFS3B4NHU3QkUy?=
 =?utf-8?B?VXVGZHh5RllCZnhTejhFaGV0dHMzdkVHcDdKdnk3VWVkdCtreVg3TjRiUE85?=
 =?utf-8?B?YTNPbTYzV3h3SkxCanR5RWlVdkpMU01ZZXFZSnA1Y1JFWFFJcTVhNkd6MW9L?=
 =?utf-8?B?TklpaVJxaTk5ZitZUXVkNWpkNHdtTnFITEt3WjJCbEQxS09oOHBTVCtMWXNU?=
 =?utf-8?B?bEg3emI5aStFMHZ5ckZUODBBMEQxVSt4TURWR2hFK0tYeWVsQklSVmNzam5Q?=
 =?utf-8?B?KzFxbzMyRHZwVFVBeUcwbmZ1OVBnV081NlJxM0RaUmIvNmI2Y01NTzVjOGxE?=
 =?utf-8?B?cExPM1NWV0R3RmR3MS93RmdteEpzSmpmR3JudEY2MkFBTi85Vzh1Ty9nVU4r?=
 =?utf-8?B?VzlFaHdkNVBlVVBYNWZXZ2dhSjFEaHdyVkpnbWhieVdxL3h3TnExRlZOa3Qv?=
 =?utf-8?B?bkVHZUFIQktUTmhQMTFuVG11alo3Rk9sTDVJbUkyL3dnSE1jaDZGc0dpbDdH?=
 =?utf-8?B?c3pxbTk4cjM3Q0hzWUFkZVhyRVFselViL2dVNjY1YUgvTFRLdE1xZWRRMzhT?=
 =?utf-8?Q?WXGt/+QizIV1JOhW8y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697927eb-63e7-4e68-be1e-08def6a05c92
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 05:29:34.2750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YnLwyEmYcJ8NGKRiNn/i1QAEZcbAVBOSRjj4bZXNgxoq8ZEr1oU380+fl21uv7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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



On 10-Aug-26 10:12 AM, Srinivasan Shanmugam wrote:
> smu_v15_0_load_microcode() and smu_v15_0_set_single_dpm_table() are not
> called anywhere; the latter is a carry-over from a previous version. The
> static helpers smu_v15_0_get_dpm_freq_by_index(),
> smu_v15_0_get_dpm_level_count() and smu_v15_0_get_fine_grained_status()
> were only called from smu_v15_0_set_single_dpm_table(), so remove those
> as well. Remove all functions along with their declarations from the
> header.
> 
> Fixes: c7fc0f372374 ("drm/amd: Enable SMU 15_0_0 support")
> Fixes: f7bee962d92a ("drm/amd/pm: Update dpm table structs for smu_v15_0")

Not a bug fix, they are just unused functions; so this doesn't sound 
accurate.

> Reported-by: Dan Carpenter <error27@gmail.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Asad Kamal <asad.kamal@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   6 -
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 166 ------------------
>   2 files changed, 172 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index ec96dc775485..0c97bee2c4bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -113,8 +113,6 @@ int smu_v15_0_init_microcode(struct smu_context *smu);
>   
>   void smu_v15_0_fini_microcode(struct smu_context *smu);
>   
> -int smu_v15_0_load_microcode(struct smu_context *smu);
> -
>   int smu_v15_0_init_smc_tables(struct smu_context *smu);
>   
>   int smu_v15_0_fini_smc_tables(struct smu_context *smu);
> @@ -183,10 +181,6 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
>   int smu_v15_0_set_power_source(struct smu_context *smu,
>   			       enum smu_power_src_type power_src);
>   
> -int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
> -				   enum smu_clk_type clk_type,
> -				   struct smu_dpm_table *single_dpm_table);
> -
>   int smu_v15_0_gfx_ulv_control(struct smu_context *smu,
>   			      bool enablement);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 29f444aea73a..2269703869f9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -106,44 +106,6 @@ void smu_v15_0_fini_microcode(struct smu_context *smu)
>   	adev->pm.fw_version = 0;
>   }
>   
> -int smu_v15_0_load_microcode(struct smu_context *smu)
> -{
> -	struct amdgpu_device *adev = smu->adev;
> -	const uint32_t *src;
> -	const struct smc_firmware_header_v1_0 *hdr;
> -	uint32_t addr_start = MP1_SRAM;
> -	uint32_t i;
> -	uint32_t smc_fw_size;
> -	uint32_t mp1_fw_flags = 0;
> -
> -	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
> -	src = (const uint32_t *)(adev->pm.fw->data +
> -				 le32_to_cpu(hdr->header.ucode_array_offset_bytes));
> -	smc_fw_size = hdr->header.ucode_size_bytes;
> -
> -	for (i = 1; i < smc_fw_size/4 - 1; i++) {
> -		WREG32_PCIE(addr_start, src[i]);
> -		addr_start += 4;
> -	}
> -
> -
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (smu->is_apu)
> -			mp1_fw_flags = RREG32_PCIE(MP1_Public |
> -						   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
> -
> -		if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
> -		    MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i == adev->usec_timeout)
> -		return -ETIME;
> -
> -	return 0;
> -}
> -
>   int smu_v15_0_init_pptable_microcode(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> @@ -1161,134 +1123,6 @@ int smu_v15_0_set_power_source(struct smu_context *smu,
>   					       NULL);
>   }
>   
> -static int smu_v15_0_get_dpm_freq_by_index(struct smu_context *smu,
> -					   enum smu_clk_type clk_type,
> -					   uint16_t level,
> -					   uint32_t *value)
> -{
> -	int ret = 0, clk_id = 0;
> -	uint32_t param;
> -
> -	if (!value)
> -		return -EINVAL;
> -
> -	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
> -		return 0;
> -
> -	clk_id = smu_cmn_to_asic_specific_index(smu,
> -						CMN2ASIC_MAPPING_CLK,
> -						clk_type);
> -	if (clk_id < 0)
> -		return clk_id;
> -
> -	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
> -
> -	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					      SMU_MSG_GetDpmFreqByIndex,
> -					      param,
> -					      value);
> -	if (ret)
> -		return ret;
> -
> -	*value = *value & 0x7fffffff;
> -
> -	return ret;
> -}
> -
> -static int smu_v15_0_get_dpm_level_count(struct smu_context *smu,
> -					 enum smu_clk_type clk_type,
> -					 uint32_t *value)
> -{
> -	int ret;
> -
> -	ret = smu_v15_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
> -
> -	return ret;
> -}
> -
> -static int smu_v15_0_get_fine_grained_status(struct smu_context *smu,
> -					     enum smu_clk_type clk_type,
> -					     bool *is_fine_grained_dpm)
> -{
> -	int ret = 0, clk_id = 0;
> -	uint32_t param;
> -	uint32_t value;
> -
> -	if (!is_fine_grained_dpm)
> -		return -EINVAL;
> -
> -	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
> -		return 0;
> -
> -	clk_id = smu_cmn_to_asic_specific_index(smu,
> -						CMN2ASIC_MAPPING_CLK,
> -						clk_type);
> -	if (clk_id < 0)
> -		return clk_id;
> -
> -	param = (uint32_t)(((clk_id & 0xffff) << 16) | 0xff);
> -
> -	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					      SMU_MSG_GetDpmFreqByIndex,
> -					      param,
> -					      &value);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * BIT31:  1 - Fine grained DPM, 0 - Dicrete DPM
> -	 * now, we un-support it
> -	 */
> -	*is_fine_grained_dpm = value & 0x80000000;
> -
> -	return 0;
> -}
> -
> -int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
> -				   enum smu_clk_type clk_type,
> -				   struct smu_dpm_table *single_dpm_table)
> -{
> -	int ret = 0;
> -	uint32_t clk = 0;
> -	bool is_fine_grained = false;
> -	int i;
> -
> -	ret = smu_v15_0_get_dpm_level_count(smu,
> -					    clk_type,
> -					    &single_dpm_table->count);
> -	if (ret) {
> -		dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
> -		return ret;
> -	}
> -
> -	ret = smu_v15_0_get_fine_grained_status(smu,
> -						clk_type,
> -						&is_fine_grained);
> -	if (ret) {
> -		dev_err(smu->adev->dev, "[%s] failed to get fine grained status!\n", __func__);
> -		return ret;
> -	}
> -
> -	if (is_fine_grained)
> -		single_dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
> -
> -	for (i = 0; i < single_dpm_table->count; i++) {
> -		ret = smu_v15_0_get_dpm_freq_by_index(smu,
> -						      clk_type,
> -						      i,
> -						      &clk);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
> -			return ret;
> -		}
> -
> -		single_dpm_table->dpm_levels[i].value = clk;
> -		single_dpm_table->dpm_levels[i].enabled = true;
> -	}
> -
> -	return 0;
> -}
> -
>   int smu_v15_0_set_vcn_enable(struct smu_context *smu,
>   			      bool enable,
>   			      int inst)

