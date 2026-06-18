Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770A1CD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 11:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A4510F284;
	Thu, 18 Jun 2026 11:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oPzoSMts";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EFB10F284
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 11:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/IhvxmuVPILmtpjuSpfw5C0YkJTIwJLrZ9xG35iLg+tGep7RX+NWhVP5zKp72Pr53aqXjHbGjrbDi3p7l3s+THKHUP6XU/JhGcjKs2jRXQw9wghLgqSnKKsrQNhAp9nBElBdzKn/MkvxxP2C1NyktvQLOxOcR0Uuv2MoX/I0GlG4mEd8jF0N7s9H5an7N9/rjk1GztLlJDS07NkHwadq7D3i5SfoAitonuoKc8JQy/Wc95ZW/mM171gMmCevrX+aIXOj9trMHqqetZs48UjGxANgtOx7xieTTvxvywyUJnKgsDG7bkK+J6uF32KQTNVELsPlkMvH4IGDw6xKBLbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPEEX9Wy7L5pXgJ9oaHpMO9yWog1fbwbghRT0fFaKdw=;
 b=FlFMru4fwQQXSG/UNa6otwNhYNkC7oO6o6613aQ2uI6rMrSUBx2EqDCnXqOFmIGFVQGXAj5TOOBQ0h9h50oAbv5Azdp7zdSrK+giYAK/4BCOuoELJyUNpK/K/c6zGBkgQddRC2xh8OVfKvfcnMyEui04JuQ/z1ZN6Nv3dkaPdeQU11B17cw1+pT00qXFjF7SeJ3yfOgw9n6FaakmyM7Z93nszDEITinfWV2VRCNh2VQEcE8X5qt6OO6vxM51vvfYPW0Jx/4b6WFzmUxB3pqIiODlDYAr04RucaCQW6ZNs5+3PrvakT6aEFIgefJXbPgNeLDr4iLl0m1Sediv//dwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPEEX9Wy7L5pXgJ9oaHpMO9yWog1fbwbghRT0fFaKdw=;
 b=oPzoSMtsAKBnq94zbFvijZOeoWl+sHGwJrRkBbJfJkzWzKdcjy+LbMm3weytanMAt4F9iMpPR5w+SImG5WTO0LFjzU1IHZc/ujScjZUabTPdobpZYGNC3+rb5DtTlypUuptNYM4s3U8VfsTKSsel3OJxkflrxO1deu+pCGOpYg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 11:26:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 11:26:01 +0000
Message-ID: <5ee98b93-22a4-4268-9b9d-4fcc64bc2ff5@amd.com>
Date: Thu, 18 Jun 2026 13:25:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] drm/amdgpu: Clean up defunct soft reset from ASIC
 reset code path
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>,
 Martin Roukala <martin.roukala@mupuf.org>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
 <20260617191428.1784083-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617191428.1784083-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 523b0ca2-540a-4513-7d5e-08decd2c606d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|11063799006|56012099006|18002099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 3MK2goCjpDyOJxqPTvqOpmTrWE++YLSZkiyOA5eZh4FYsdDeJ1xLgGKxAsVzFa4nvzGDswQqx1AnFJCAAh5JkTVK07CFk3F3sL0ZJ/gwtBjN/SMxRQu+mPrzp7aaKS9zQPQCjJokEv42KaxLpnhqHSq9dH2hezbVpJrIA5SICNKgN7SfZauQ+cZ7a8vHxyhE1kIeuQzFYEBxOtTRun0GJ8y23jd34XXzYsYvcf7kYjZbqrr7LjDp05U9w6RjSkdhVuZ/oHvcOcr6bakLU4QwZx4juVtk0CqyuDgBaN2iJuW9HpVWxRS8JbQgS9/Y63Dzcc02IShSNz9ogzIk3JVEQl2ba6NixMymti8nr/TWeMkYFwDRj0ha6fw9IqiHx2H6tubBH24+uNNAn5EkY16MdK+nvt5JsVqWiOsGDe47iLyUWXSwM/8thT3xt5BIrmlCxQXTOn8euJR5A9MaYV3XygdRe2UXu5yUfjSJxxNB3/qkDfmxsvKQ8bhFBvu7kb5GJGLuJvybjU6o0Xe4WKGrnsSSywQvmXx615PSTNV4QZ73QfyKXYSJyTpT/4gOkXM5vX8zwp8NJyyuCW4MoKpQx1cVZCEd4XZjSBH2NKBwFz0oOYATAxngRFio1KafLOCA2rwCaDQ/KUaSZy6z/7vQGrUywYWq7U7Ozbsuz+aNbzobca7YIMmisc7QhsLMQwBX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNGL28ramcrMTVRc3lJWWhLNTNwN0Uxakl2NFFLN1pTNElEZVNmczJUSVlH?=
 =?utf-8?B?aUc2a1g4MDRGY04rdHMxVERTTFdUc0tKa0VRVzRrNWIra1pWQlN5dXJ1aVM2?=
 =?utf-8?B?dy9tZGNhY2xjeDU5eTRheUhrcktVZU14TC9WQkVmU1BDNnhUT3dMK0doRHdo?=
 =?utf-8?B?c0g5OFpsVFFsRTdPc3l1b1hmT1NkNU50azgwKzRFQlZBb2NEdS8wYSs0N05j?=
 =?utf-8?B?Z2F6Y0pldm0vM2RDYTcra0hxcCt1NE4yRDZ0S0ptWWJVMEV0Mmd4NlRmaEEz?=
 =?utf-8?B?UGhqTWwyZkFHMEEvaU1rdXBQeXZla25VVjlucVdOMzk4ZEhWSkFQbi81TUF4?=
 =?utf-8?B?SkMwUTA5a0kzZS85UlhLRFF0ZWRNekMycGN4MXN4WXV4TS80R0tUcWNPTGIy?=
 =?utf-8?B?aWhVZ3dXVTQ1M0hpTVgzL3oxd3Bha05QbHlGWHkrczE2aHl0VnJEbkpMd0Z0?=
 =?utf-8?B?dEdrTHZyTWFmTVBrOWJYa1R5VWk1M2N4NFNnUE1Bd3I1Mkh3bFVQcHRubVNU?=
 =?utf-8?B?YUxkQWRFUkdhU0VxWEVOUUd5ZzAraEw3SkVhUllXYVFDZDgrMDZmTldXWHpt?=
 =?utf-8?B?bGNsNm5EVXowODE4TjBJRnc0YUN2cG81ZUtOTDJFT0o2ckxYWXF3bm8xOUVT?=
 =?utf-8?B?eUU1TDh2Vjd1ZENSTm1HZXhnT25tYTVpNmZITmpVYW51QkF2cnRBdU9CeDBt?=
 =?utf-8?B?Q1plV1FYY3ltaTFPR0I4NHJJd2JjTiswNjdpN1RVRTdSNGVrb1hLdVM4bk1x?=
 =?utf-8?B?bW1FTHAwSnNOU1BVYUlRUklGM2pFcUZkaWl6d1pZd3dUcnBvYWsvNWt0WnZF?=
 =?utf-8?B?cmN4T0grQkpvRmNvZlI1K3I5dDNoVTRVcTJDd2ltMGhnM3lIbGgzTC82eDNS?=
 =?utf-8?B?N0xEdmFnS0JqSkhCRTRpYjZNalBWd2J6UXZDTkRHQjZjTXVCMUV0bVNSUlFW?=
 =?utf-8?B?K1ZvVDNDaEJqUzYyczVhTUxzODZma1pRYmRvZy9RTmlVK0ttZnRJV25xNlk3?=
 =?utf-8?B?cXhFM29BSlFjODd1ZkhxYy9UVzhUaUx3a1B4R2grZWVEZzZmcXVUOWFxdVpB?=
 =?utf-8?B?bDFMdXBsN3g0R2VseWRwd2Z5RlR2dTI4VnkxZkJSWnVTS2VsRGlzZGxNbnJ6?=
 =?utf-8?B?YlRHak1Xci9LTkFWUmlnQW0yZHMzb1ZiZE1FcWdyVUtzdmc3bGRUZytSblM1?=
 =?utf-8?B?d1VQcU50b2RucjRxMEN6ZFBCdkkwYVNwbTUwRDlvQko5ZVBqV2g4OWV3aGhE?=
 =?utf-8?B?NzhrMkhtTWkwV2JNNm80V045bUdzZ0JzVktMMzk3YkFQUjFXR1dxZytMb05s?=
 =?utf-8?B?Wk9rTXpVWDJsaGY0ak45TlJWKzExb2hqbWVkeC93aFBDQitNazFNY2xjYzVG?=
 =?utf-8?B?cUVYdnhtbzZuRDVoblRGdHNvaE1rQVFGYmFOR3dsK1UyNU1zRTlSckJXME9h?=
 =?utf-8?B?WTZoa2VWQkYzUEZiUEcwQ3Y3bUl5V04yazlMSFZWVGJ5aUxzN29lK1dPMDFw?=
 =?utf-8?B?eWgyYmpzMTdVcTJsU0JtbEpUdUxYZW4rLzhFT1hydXVKbklQY09QZFpoTkN2?=
 =?utf-8?B?cDJwR3AzNEFsRERvd3p1UGVvMjVoNHdGckJPMWE5N2JUUVdPYUcvalJlNkgv?=
 =?utf-8?B?UjBXV3ZTY3ZRcm0wZGpramY0OCt4U0JMc284RGFjVWpleTY0TjZwSm1ia2ky?=
 =?utf-8?B?NjVWU1FQZURXZnFPQU1HRWd3Zkc3VWlQeENJZHJFZXE4d3hnQXgxa2ZyUUN0?=
 =?utf-8?B?U3RNbWErV2pBekdoT0FGT3VDdVZVWjJFeE14eEFGK0JVT0JCSnVVTFNYRVU1?=
 =?utf-8?B?TEZPaXNFS0M3VHYxTFBDT2ZFeFFUeGtpRXJ0U0lpVU1OVEd0UWFSZzF6OWd3?=
 =?utf-8?B?R2JiSVJ2YmlOai9qNlVoN04vbHM5WHlTK1ZudmZ3Qmlibys0NXM0VW91VnZi?=
 =?utf-8?B?YjVZeGZnTzEySW1OVVRkYUZXUzdxeDNCNlRNQ2NnUlVMY1ZKYVZmeG8rTXpv?=
 =?utf-8?B?T0gwTlM3V3pXNjhQdURrYklaRnRZeStRcnRZN3graHJEUkFUWlB4WWE3bW82?=
 =?utf-8?B?Q0hjeTJTYlNTcERzQTBQWnVwQmMwQUNFcjFUYUM1S3VSMDRwaDJ1cjRjczM2?=
 =?utf-8?B?N3lUamlMTzJVQ2h2WFNBKzRad1NBUzFBNXcxZzI5RHBQNWJMZVJFUTN3OVBk?=
 =?utf-8?B?blZrN1Arb0hYdWU1USt4cU5tVm9kRWVKd3dmNDBjQjBNcXBOQ21vcW9zZ2ow?=
 =?utf-8?B?bDRMNlVnRXlUSkdWU21lZ3R0bGJLcVFYVUE3VDhhNitZZm1CMEx4cnNXbW16?=
 =?utf-8?Q?Xj2paZGfzbnWVyTc8E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523b0ca2-540a-4513-7d5e-08decd2c606d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 11:26:01.5289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DngTYWkGwwpD2f0fqxxukYEYeBMpH+JBkiYGwpAd4v534oFsFh2BDvRBQhzQjf3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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

On 6/17/26 21:14, Timur Kristóf wrote:
> Soft reset means resetting IP blocks individually using
> a hardware interconnect (SRBM or GRBM) without assistance
> from firmware.
> 
> Soft reset is a useful tool for implementing GPU recovery,
> eg. it is already successfully used for SDMA queue resets.
> It should be used by a GPU recovery method instead of
> being called directly from the ASIC reset code path.
> 
> Currently, this is only used on Carrizo and Stoney,
> but doesn't work well and fails on those chips.
> A subsequent commit will add a working GFX8 recovery
> implementation after the cleanups.
> 
> Note that this commit only cleans up the ASIC reset path,
> which also unblocks more opportunities for cleanup for
> the various IP blocks. Those will be done in subsequent commits.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

amdgpu_device_pre_asic_reset() looks like it could be cleaned up even more, but this is clearly a step in the right direction.

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 173 +--------------------
>  drivers/gpu/drm/amd/amdgpu/cik.c           |   7 -
>  drivers/gpu/drm/amd/amdgpu/nv.c            |   6 -
>  drivers/gpu/drm/amd/amdgpu/si.c            |   7 -
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |   9 --
>  drivers/gpu/drm/amd/amdgpu/soc21.c         |  12 --
>  drivers/gpu/drm/amd/amdgpu/soc24.c         |  11 --
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  10 --
>  drivers/gpu/drm/amd/amdgpu/vi.c            |  22 ---
>  10 files changed, 2 insertions(+), 258 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cb4fa9c111eb..7c5ca9e44d54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -586,8 +586,6 @@ struct amdgpu_asic_funcs {
>  	/* invalidate hdp read cache */
>  	void (*invalidate_hdp)(struct amdgpu_device *adev,
>  			       struct amdgpu_ring *ring);
> -	/* check if the asic needs a full reset of if soft reset will work */
> -	bool (*need_full_reset)(struct amdgpu_device *adev);
>  	/* initialize doorbell layout for specific asic*/
>  	void (*init_doorbell_index)(struct amdgpu_device *adev);
>  	/* PCIe bandwidth usage */
> @@ -1355,7 +1353,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
>  #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
>  #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
> -#define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
>  #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
>  #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
>  #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71a6b18ccf23..df7e0f2b3ccc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4685,161 +4685,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> -/**
> - * amdgpu_device_ip_check_soft_reset - did soft reset succeed
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * The list of all the hardware IPs that make up the asic is walked and
> - * the check_soft_reset callbacks are run.  check_soft_reset determines
> - * if the asic is still hung or not.
> - * Returns true if any of the IPs are still in a hung state, false if not.
> - */
> -static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
> -{
> -	int i;
> -	bool asic_hang = false;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return true;
> -
> -	if (amdgpu_asic_need_full_reset(adev))
> -		return true;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
> -			adev->ip_blocks[i].status.hang =
> -				adev->ip_blocks[i].version->funcs->check_soft_reset(
> -					&adev->ip_blocks[i]);
> -		if (adev->ip_blocks[i].status.hang) {
> -			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
> -			asic_hang = true;
> -		}
> -	}
> -	return asic_hang;
> -}
> -
> -/**
> - * amdgpu_device_ip_pre_soft_reset - prepare for soft reset
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * The list of all the hardware IPs that make up the asic is walked and the
> - * pre_soft_reset callbacks are run if the block is hung.  pre_soft_reset
> - * handles any IP specific hardware or software state changes that are
> - * necessary for a soft reset to succeed.
> - * Returns 0 on success, negative error code on failure.
> - */
> -static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
> -{
> -	int i, r = 0;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].status.hang &&
> -		    adev->ip_blocks[i].version->funcs->pre_soft_reset) {
> -			r = adev->ip_blocks[i].version->funcs->pre_soft_reset(&adev->ip_blocks[i]);
> -			if (r)
> -				return r;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * amdgpu_device_ip_need_full_reset - check if a full asic reset is needed
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Some hardware IPs cannot be soft reset.  If they are hung, a full gpu
> - * reset is necessary to recover.
> - * Returns true if a full asic reset is required, false if not.
> - */
> -static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
> -{
> -	int i;
> -
> -	if (amdgpu_asic_need_full_reset(adev))
> -		return true;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) ||
> -		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) ||
> -		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_ACP) ||
> -		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) ||
> -		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
> -			if (adev->ip_blocks[i].status.hang) {
> -				dev_info(adev->dev, "Some block need full reset!\n");
> -				return true;
> -			}
> -		}
> -	}
> -	return false;
> -}
> -
> -/**
> - * amdgpu_device_ip_soft_reset - do a soft reset
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * The list of all the hardware IPs that make up the asic is walked and the
> - * soft_reset callbacks are run if the block is hung.  soft_reset handles any
> - * IP specific hardware or software state changes that are necessary to soft
> - * reset the IP.
> - * Returns 0 on success, negative error code on failure.
> - */
> -static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
> -{
> -	int i, r = 0;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].status.hang &&
> -		    adev->ip_blocks[i].version->funcs->soft_reset) {
> -			r = adev->ip_blocks[i].version->funcs->soft_reset(&adev->ip_blocks[i]);
> -			if (r)
> -				return r;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * amdgpu_device_ip_post_soft_reset - clean up from soft reset
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * The list of all the hardware IPs that make up the asic is walked and the
> - * post_soft_reset callbacks are run if the asic was hung.  post_soft_reset
> - * handles any IP specific hardware or software state changes that are
> - * necessary after the IP has been soft reset.
> - * Returns 0 on success, negative error code on failure.
> - */
> -static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
> -{
> -	int i, r = 0;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].status.hang &&
> -		    adev->ip_blocks[i].version->funcs->post_soft_reset)
> -			r = adev->ip_blocks[i].version->funcs->post_soft_reset(&adev->ip_blocks[i]);
> -		if (r)
> -			return r;
> -	}
> -
> -	return 0;
> -}
> -
>  /**
>   * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
>   *
> @@ -5134,20 +4979,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  
>  	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
>  	if (!amdgpu_sriov_vf(adev)) {
> -
> -		if (!need_full_reset)
> -			need_full_reset = amdgpu_device_ip_need_full_reset(adev);
> -
> -		if (!need_full_reset && amdgpu_gpu_recovery &&
> -		    amdgpu_device_ip_check_soft_reset(adev)) {
> -			amdgpu_device_ip_pre_soft_reset(adev);
> -			r = amdgpu_device_ip_soft_reset(adev);
> -			amdgpu_device_ip_post_soft_reset(adev);
> -			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
> -				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
> -				need_full_reset = true;
> -			}
> -		}
> +		need_full_reset = true;
>  
>  		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>  			dev_info(tmp_adev->dev, "Dumping IP State\n");
> @@ -5600,8 +5432,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  		drm_client_dev_suspend(adev_to_drm(tmp_adev));
>  
>  		/* disable ras on ALL IPs */
> -		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev) &&
> -		    amdgpu_device_ip_need_full_reset(tmp_adev))
> +		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
>  			amdgpu_ras_suspend(tmp_adev);
>  
>  		amdgpu_userq_pre_reset(tmp_adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 29954c7d61b0..77e120a72815 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1876,12 +1876,6 @@ static void cik_invalidate_hdp(struct amdgpu_device *adev,
>  	}
>  }
>  
> -static bool cik_need_full_reset(struct amdgpu_device *adev)
> -{
> -	/* change this when we support soft reset */
> -	return true;
> -}
> -
>  static void cik_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
>  			       uint64_t *count1)
>  {
> @@ -1971,7 +1965,6 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
>  	.get_config_memsize = &cik_get_config_memsize,
>  	.flush_hdp = &cik_flush_hdp,
>  	.invalidate_hdp = &cik_invalidate_hdp,
> -	.need_full_reset = &cik_need_full_reset,
>  	.init_doorbell_index = &legacy_doorbell_index_init,
>  	.get_pcie_usage = &cik_get_pcie_usage,
>  	.need_reset_on_init = &cik_need_reset_on_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 72edf5326b05..77557ee3ca16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -507,11 +507,6 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
>  	adev->virt.ops = &xgpu_nv_virt_ops;
>  }
>  
> -static bool nv_need_full_reset(struct amdgpu_device *adev)
> -{
> -	return true;
> -}
> -
>  static bool nv_need_reset_on_init(struct amdgpu_device *adev)
>  {
>  	u32 sol_reg;
> @@ -595,7 +590,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs = {
>  	.set_vce_clocks = &nv_set_vce_clocks,
>  	.get_config_memsize = &nv_get_config_memsize,
>  	.init_doorbell_index = &nv_init_doorbell_index,
> -	.need_full_reset = &nv_need_full_reset,
>  	.need_reset_on_init = &nv_need_reset_on_init,
>  	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
>  	.supports_baco = &amdgpu_dpm_is_baco_supported,
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index c26cb3e8bff6..b104469c38ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1509,12 +1509,6 @@ static void si_invalidate_hdp(struct amdgpu_device *adev,
>  	}
>  }
>  
> -static bool si_need_full_reset(struct amdgpu_device *adev)
> -{
> -	/* change this when we support soft reset */
> -	return true;
> -}
> -
>  static bool si_need_reset_on_init(struct amdgpu_device *adev)
>  {
>  	return false;
> @@ -2019,7 +2013,6 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
>  	.get_config_memsize = &si_get_config_memsize,
>  	.flush_hdp = &si_flush_hdp,
>  	.invalidate_hdp = &si_invalidate_hdp,
> -	.need_full_reset = &si_need_full_reset,
>  	.get_pcie_usage = &si_get_pcie_usage,
>  	.need_reset_on_init = &si_need_reset_on_init,
>  	.get_pcie_replay_count = &si_get_pcie_replay_count,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 87b398dd0769..ed3fd58b78d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -721,12 +721,6 @@ void soc15_set_virt_ops(struct amdgpu_device *adev)
>  	soc15_reg_base_init(adev);
>  }
>  
> -static bool soc15_need_full_reset(struct amdgpu_device *adev)
> -{
> -	/* change this when we implement soft reset */
> -	return true;
> -}
> -
>  static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
>  				 uint64_t *count1)
>  {
> @@ -878,7 +872,6 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
>  	.set_uvd_clocks = &soc15_set_uvd_clocks,
>  	.set_vce_clocks = &soc15_set_vce_clocks,
>  	.get_config_memsize = &soc15_get_config_memsize,
> -	.need_full_reset = &soc15_need_full_reset,
>  	.init_doorbell_index = &vega10_doorbell_index_init,
>  	.get_pcie_usage = &soc15_get_pcie_usage,
>  	.need_reset_on_init = &soc15_need_reset_on_init,
> @@ -899,7 +892,6 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
>  	.set_uvd_clocks = &soc15_set_uvd_clocks,
>  	.set_vce_clocks = &soc15_set_vce_clocks,
>  	.get_config_memsize = &soc15_get_config_memsize,
> -	.need_full_reset = &soc15_need_full_reset,
>  	.init_doorbell_index = &vega20_doorbell_index_init,
>  	.get_pcie_usage = &vega20_get_pcie_usage,
>  	.need_reset_on_init = &soc15_need_reset_on_init,
> @@ -920,7 +912,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
>  	.set_uvd_clocks = &soc15_set_uvd_clocks,
>  	.set_vce_clocks = &soc15_set_vce_clocks,
>  	.get_config_memsize = &soc15_get_config_memsize,
> -	.need_full_reset = &soc15_need_full_reset,
>  	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
>  	.need_reset_on_init = &soc15_need_reset_on_init,
>  	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 93c002e511c7..6af81c27b986 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -461,17 +461,6 @@ const struct amdgpu_ip_block_version soc21_common_ip_block = {
>  	.funcs = &soc21_common_ip_funcs,
>  };
>  
> -static bool soc21_need_full_reset(struct amdgpu_device *adev)
> -{
> -	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -	case IP_VERSION(11, 0, 0):
> -	case IP_VERSION(11, 0, 2):
> -	case IP_VERSION(11, 0, 3):
> -	default:
> -		return true;
> -	}
> -}
> -
>  static bool soc21_need_reset_on_init(struct amdgpu_device *adev)
>  {
>  	u32 sol_reg;
> @@ -550,7 +539,6 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs = {
>  	.set_vce_clocks = &soc21_set_vce_clocks,
>  	.get_config_memsize = &soc21_get_config_memsize,
>  	.init_doorbell_index = &soc21_init_doorbell_index,
> -	.need_full_reset = &soc21_need_full_reset,
>  	.need_reset_on_init = &soc21_need_reset_on_init,
>  	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
>  	.supports_baco = &amdgpu_dpm_is_baco_supported,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 265db9331d0b..620970de6eb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -238,16 +238,6 @@ const struct amdgpu_ip_block_version soc24_common_ip_block = {
>  	.funcs = &soc24_common_ip_funcs,
>  };
>  
> -static bool soc24_need_full_reset(struct amdgpu_device *adev)
> -{
> -	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -	case IP_VERSION(12, 0, 0):
> -	case IP_VERSION(12, 0, 1):
> -	default:
> -		return true;
> -	}
> -}
> -
>  static bool soc24_need_reset_on_init(struct amdgpu_device *adev)
>  {
>  	u32 sol_reg;
> @@ -330,7 +320,6 @@ static const struct amdgpu_asic_funcs soc24_asic_funcs = {
>  	.get_xclk = &soc24_get_xclk,
>  	.get_config_memsize = &soc24_get_config_memsize,
>  	.init_doorbell_index = &soc24_init_doorbell_index,
> -	.need_full_reset = &soc24_need_full_reset,
>  	.need_reset_on_init = &soc24_need_reset_on_init,
>  	.get_pcie_replay_count = &soc24_get_pcie_replay_count,
>  	.supports_baco = &amdgpu_dpm_is_baco_supported,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index 5f05c8e68297..4d93f28145d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -223,15 +223,6 @@ static int soc_v1_0_read_register(struct amdgpu_device *adev,
>  	return -EINVAL;
>  }
>  
> -static bool soc_v1_0_need_full_reset(struct amdgpu_device *adev)
> -{
> -	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -	case IP_VERSION(12, 1, 0):
> -	default:
> -		return true;
> -	}
> -}
> -
>  static bool soc_v1_0_need_reset_on_init(struct amdgpu_device *adev)
>  {
>  
> @@ -271,7 +262,6 @@ static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
>  	.read_register = &soc_v1_0_read_register,
>  	.get_config_memsize = &soc_v1_0_get_config_memsize,
>  	.get_xclk = &soc_v1_0_get_xclk,
> -	.need_full_reset = &soc_v1_0_need_full_reset,
>  	.init_doorbell_index = &soc_v1_0_doorbell_index_init,
>  	.need_reset_on_init = &soc_v1_0_need_reset_on_init,
>  	.encode_ext_smn_addressing = &soc_v1_0_encode_ext_smn_addressing,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index a256320b92f3..5715b6b596af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1328,27 +1328,6 @@ static void vi_invalidate_hdp(struct amdgpu_device *adev,
>  	}
>  }
>  
> -static bool vi_need_full_reset(struct amdgpu_device *adev)
> -{
> -	switch (adev->asic_type) {
> -	case CHIP_CARRIZO:
> -	case CHIP_STONEY:
> -		/* CZ has hang issues with full reset at the moment */
> -		return false;
> -	case CHIP_FIJI:
> -	case CHIP_TONGA:
> -		/* XXX: soft reset should work on fiji and tonga */
> -		return true;
> -	case CHIP_POLARIS10:
> -	case CHIP_POLARIS11:
> -	case CHIP_POLARIS12:
> -	case CHIP_TOPAZ:
> -	default:
> -		/* change this when we support soft reset */
> -		return true;
> -	}
> -}
> -
>  static void vi_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
>  			      uint64_t *count1)
>  {
> @@ -1437,7 +1416,6 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
>  	.get_config_memsize = &vi_get_config_memsize,
>  	.flush_hdp = &vi_flush_hdp,
>  	.invalidate_hdp = &vi_invalidate_hdp,
> -	.need_full_reset = &vi_need_full_reset,
>  	.init_doorbell_index = &legacy_doorbell_index_init,
>  	.get_pcie_usage = &vi_get_pcie_usage,
>  	.need_reset_on_init = &vi_need_reset_on_init,

