Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE000C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 08:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091FB10F067;
	Fri, 22 Mar 2024 08:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RVLiCOFn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506FB10F067
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 08:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7r7opicvMxlug1u4SxlxYsd6Y2TdceCmsdMUDnud7mgoZSs0uHL+GoQkuD82R9lREQNdx9kro5h1h+a59ZHgBDTK4Ij4JAteksKDqkbstrJft+HRW2XeDnB3jg2X4STmU9jvZnadaJgjINbFvKui2tquUCU322uGjI0Swld/YItuQ/0gth1i0lQyNIxNTKugpmObyW96Ed0/opiuKCqYEE5ORYX2mG2tD5UufS8Jncuafw5CGrlQlPUMxolqS4ZNp9aFszB85SWgtWHKZ/13Nwy8Iw+SWekcoql6y6K/4F28YNg2YeptVcr0V3+X7rjy8xj7Uk/Vzj6cwWgq6ko/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpoKPCFRyo5MVC12A3tbIDGWXcaRT/T5DMqI2PgsTAQ=;
 b=EChesmWlZ99ZTeMkrdlcOgx1Xa+mkbT1HKrE91eQiRDPnDIz8jE3L9cQ5Nq7QItcMqXzZQwbWOqJuHVrhUJM/I/sCs9h1dn29Zra4ZsgiPPccmyR2FDo0C+Xjw5xIYZwhzgKhgcTQypfspPyvLexlKboXPJDeb2TvYLtr3M9744ubntz77jRHsBM+zWd4K+6JUN1tSNMqHT769PCbjfkg1w0SZycfixTEwkRtbGhTcv/2ukoKTeZClkLhT5nOQyvQgudjhXf/3jWTTsKOLiDUTBNlcfZn/1iQeeAQwWE5keoWjuwK7ER+2CpWJ+KlLzL27PkE2PT8qcN2g5yCI93FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpoKPCFRyo5MVC12A3tbIDGWXcaRT/T5DMqI2PgsTAQ=;
 b=RVLiCOFnyVdSEP683OKgUL3XABTYxziz0460shi5ZOpQsVEc4OM8U/F7iEEbJwO80lVLJzwcpm8RrQp3YdIPEvFSWjf8brrnvRxYTcpnWFx+RHFQhakENw11CR9ULlaJpbgE9uCvS5PQDKAkPI31oDvAFSQyxLOIAgvjyOH0Ino=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Fri, 22 Mar 2024 08:05:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 08:05:17 +0000
Message-ID: <23bf3388-a0bb-465a-8584-23aa0d33cb18@amd.com>
Date: Fri, 22 Mar 2024 13:35:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix truncation in gfx_v10_0_init_microcode
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240322065439.4154847-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240322065439.4154847-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 662dac55-8d5f-43a0-52a3-08dc4a46cfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wopt9/EOkuVMcmzjZbV8x1UBOsrS0a61723rUEhjQqpe9SJwESATu7pf8uDcm5F8U8F/aChphZu++I6gXeiTR7Ro7QajiLxsAwcQI0s4lIc3czcqMBihBLAvlOrhKE1fBNncrJVkNNRrG6fRdJQpJLnZTqhh5JP2nfroh5IxA33QYHh92TTabzKDPl3uQR/TcM9Qp9OY3z5zLU55/XhVNVoKmCOOC/11bvlHCqFF55EOh93lSiIrwyR6b62dppsWC7a87uO+ImFMCWB2+Ez2PpzD/GRBSNiQOsXVxv9E9cf+PBBQkf1HeRFIr5Zzup/iLaKaFtyQWLkPuC2N+E+tCltYCO0bP5pfuXfUYDwwCwr625spEg3g56K0jkaPRCd8h8ojgYwYq5JzzNePxbBucx60QsHA7lMAz3vCRh9AHE2zYZFArxL29g6wWETEn3Mug6cE7m5Rwvo3vIp8z4gjwOeYyPfjPblg5pi/dMWwH/6ke3lcDlovVC51ok38WMlwT6H7X37ihQ/C67g2K4S7sPkr2HPmRZhmCorSiQaHU75gj2SeoCb18H/A2T2YJRZwQXL9E/yYDU7gTfbAoWvY4TUDSpM1/FHqlUxiBQSpsLNW8/BaMsyd1IyilK05FDov7AehQUUCVTzPW8JS+U1bOFyB5DIpqLX38p4XlOX29Mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy80ZjJsWFo1V2JNT1UwNnZ5SmFRVmFnaCtRSVY2enZGQ0hYcDVLWGNldUQ5?=
 =?utf-8?B?cFJsVjNEUTNCNzBNQ25IbzFXR1NWWGs4UzJiakZzWEtCNU5qaHhuRlZHbW9E?=
 =?utf-8?B?NVg5d1R3dnlwNys3NXZBV3FTR3EwMTR3QW1ncWdzcEJTQnQ4Q1pkSUl1bmZ1?=
 =?utf-8?B?N21LUk50VSs3Zno5a2tVelpXM1VvNWFmK1RVTHk3VFcwbVNNWTVHOG1EZUZ6?=
 =?utf-8?B?MFJ4c1NsS1g2MG1xL2VTcGJqMXJFeHMxTTB1NC85WUNMTFY3b0UwTUVNdnRF?=
 =?utf-8?B?U3JtYUV2WGxTZTJBSFRsS2hERXZMZ043OTBWc09Ncm1ucUJGQTIrRVhMcm8r?=
 =?utf-8?B?bUFIVDdyVXJ6M0Vqdmcwd0lkVENhbytkS0xyaVhsUlRjbndwVXZIM2I0eDdP?=
 =?utf-8?B?TCtya0pDZmpxMzd4Z29VOHRGQUtSUEJMTGIxUnpkcHl1WmNRcGdMa0N6WXVO?=
 =?utf-8?B?UGRuR1loMHNzbGVtWWV5NCs2WkVYVk0vVCtOczRSTnp3LzI4QWxwa2o5R21V?=
 =?utf-8?B?QVRtNWhWUWlTRnhNbnZGc2NhU0hlRnJwUXo5ZnNSOWM5NkxGUDBYdUU2Zkxh?=
 =?utf-8?B?OUI3SytNVzVvUDl6ZCt0TGFPMzczVklvVFV4eXkvY01DTXBLdE1ScnQxczFp?=
 =?utf-8?B?MlNXVVhLdmc2MEpOK3hDcDZ2cGtHRVEzRzhIbjZrNG5seDNNelpmUWcyR2Nq?=
 =?utf-8?B?SHB0Y0VEY0l5emdzUVp1Wm1vaTVDcFNaSFpUY0xLVStlUEZiVzFtbCtNdTJr?=
 =?utf-8?B?ai84Q3hYRVM1OXAyRmt5UUpXWEkwa0JLVmh6eEwxbjhHUTlES3dIZ3dkZk1C?=
 =?utf-8?B?aVBsTWVIZmgzdlZBS1ZQeXpzNkNYeVlTMXFFcVhkeDcxcU80RDJyVlZZbGpB?=
 =?utf-8?B?bjFLbXJ1QVQxOVdJSER1Qmg4ZmNNWkFPd1l0ak54S25rMVVYTUIwdEI1K3Ft?=
 =?utf-8?B?RmRKdEp6K0svUGpoWjJ3akkybHdUczRVMUgvS1dnRXZsbkozRDJFdVpwaGNM?=
 =?utf-8?B?RVJnYmM1NDJLaGlJVG1xd0xnN2E1RTJxQ2tUNDVDN05kQnVocWpncUhZeWI2?=
 =?utf-8?B?VG02ekNZanh3WHRwcWlxQzNzMUJSUU5pQzU5aXAyTCtJaGdpZER4YzlORlk0?=
 =?utf-8?B?YjFPSnN6WWp6VFpvN0NhTXpxVUxCZTBIMGhpb3FJdVNZZGl5RytFNUhQSUI1?=
 =?utf-8?B?VVRDNEFzR1BZMEZYdGhiSHBoT21xVFRYVVJ6WDhyejR5M1BnM0oxcTNaMkxJ?=
 =?utf-8?B?MXc0aUNhdkhGemltbnpnd29kbkJ3bStObklqMVVVdTNuUVdFSGNzSi9ZSFN6?=
 =?utf-8?B?MCtSTjFqbVRtZjMvaDRXeVErcjA3UUZySHdnbklNYktkc0xwR055dUlaNFFm?=
 =?utf-8?B?UjNVck9YV0J3M1ZNY0NnbmlUK042dnNKaDFQWjBCN095SEduTWZwM2hBLzBE?=
 =?utf-8?B?d1hURGVLcTJ2UFZaK2hlU3Fpc3dMYm4zM2N5QnFLVGo0MDFJMW1VRWV3bnYx?=
 =?utf-8?B?LzlhVFVwU3FOcmZtQzBtcmtteHlhUHVMWUxsdUdWcGlFTFo5NzFscmVVN3Nx?=
 =?utf-8?B?RlkwTThHSjZKYkN3OVlLVEZRYTdSNUtrZWI1UGZ1empYRnZrK1FOcGw3YVhs?=
 =?utf-8?B?RUZ5MWgya0VjUFQySm5LbnU2cmV2QlEyeDNIUUtoUXJiWXZ1N1M3RHdwbWdS?=
 =?utf-8?B?dXNab1Qybk8wTnFzT0NPSTUyYkNGTXp4bGkyK2xWQ0pRNjA2OTN2T0dWYkIv?=
 =?utf-8?B?YjI3NHFaK3VFM09pdHprOU5QZHFlT01aKy91UDA1WkZhTjY5M2gzK1BsRWxh?=
 =?utf-8?B?N2VVY3BUNjF3Y2NyWXRtV2g4ZWp4b3V5bWFWc3R4dW1ZTmRLbTVPTlhzdFQ5?=
 =?utf-8?B?TU5QWVhSclZ5elcyMkxjc2x3TXdrSE9JNUdUOGx4TmZuRlNsNlZ1Y0dPTE5T?=
 =?utf-8?B?QmN5UWRnZXVXNVpnd3BHQXZMc2tKSTZuK2dOeVRoMmFVU2orc1VLeDEzd3B6?=
 =?utf-8?B?Wlh2NnFBOUZ0RU1jQzJjRDNKMmpDZlpYZEs0cnNtWGREOVp3YlU4UW53Z0o0?=
 =?utf-8?B?bmNCeWpMRG9idUkwNFdLSTg2aFFLQUFhZjdpd0htNnhRVUd1dUo1dVdtM0FE?=
 =?utf-8?Q?/DPx3J3JpDA0+ddtMuL2mu/KY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662dac55-8d5f-43a0-52a3-08dc4a46cfa0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:05:17.4982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUOZvejqs1eHa5Ya4yy2EDOcKVomNbZ2gi8QAURv8bkxXFau6OnbG3ua9F4HP7FH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021
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



On 3/22/2024 12:24 PM, Srinivasan Shanmugam wrote:
> The total size of the fw_name buffer is 8 (for "amdgpu/") + 30 (for
> ucode_prefix) + 5 (for "_pfp") + 5 (for "_wks") + 5 (for ".bin") = 53
> characters.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c: In function ‘gfx_v10_0_early_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3982:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
>  3982 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
>       |                                                          ^~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3982:9: note: ‘snprintf’ output between 16 and 49 bytes into a destination of size 40
>  3982 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3988:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
>  3988 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", ucode_prefix, wks);
>       |                                                         ^~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3988:9: note: ‘snprintf’ output between 15 and 48 bytes into a destination of size 40
>  3988 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", ucode_prefix, wks);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3994:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
>  3994 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
>       |                                                         ^~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3994:9: note: ‘snprintf’ output between 15 and 48 bytes into a destination of size 40
>  3994 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4001:62: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>  4001 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
>       |                                                              ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4001:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>  4001 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4017:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
>  4017 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
>       |                                                          ^~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4017:9: note: ‘snprintf’ output between 16 and 49 bytes into a destination of size 40
>  4017 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4024:54: warning: ‘_mec2’ directive output may be truncated writing 5 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>  4024 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
>       |                                                      ^~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4024:9: note: ‘snprintf’ output between 17 and 50 bytes into a destination of size 40
>  4024 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index f90905ef32c7..d524f1a353ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3964,7 +3964,7 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
>  
>  static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  {
> -	char fw_name[40];
> +	char fw_name[53];
>  	char ucode_prefix[30];
>  	const char *wks = "";
>  	int err;
