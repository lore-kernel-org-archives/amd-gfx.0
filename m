Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DBFC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 09:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA3810E945;
	Thu,  3 Apr 2025 09:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KrpL8hfh";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930B510E945
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 09:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiEtrK1Y296XqC3jkLZIh4NBSWW3mLxVX7BuHfBVIrhD5WI42xRtNqv7/SJD2lgpOCaHFSOqCrPhJqbHwj8M/qztPl9FW3ymiG2oSB89u8/V8CHxaDWeNzbDtpTImuseruHebJAEG8g++pFVIx2jv5yu9UAVroP1vavvScIO/fISM1RR4gM4NywI/GMcbQC+XZxep4UbB4sXMuwYYu5eBtO76FrfiGUAAAfvBsD7d8lBdxQQSDur6tt7AgcCygbMaAWV6VpJjRhHrQ6/q4GffyrIRundr5CF5zRqXqxeI1LJF7oysesxp19GwVUar95deezVqEfvG3uk4afXPRzvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxpHNPM1h5WHE3bKFtalzR/jMNcu/d4P6cC88oVhimQ=;
 b=Fgnz5xRb0/oWTSKPV9pFciTU1b6pYcfa9u2n/LK6u6KC4E1ge7BzZDZSYVDP+LT0I3kEEzm8JjgilpKAjlyazcD/IX0445sZJA/i24il8MUJELgmc9kenVCilsVvHE1sB2xMqpV0Tow/tlaIRItz/IuG2nu6RWP9CxO3+ciADmhJMO3E0TnH9UE2ygcs3P7ZL/iuaw7JtK7HKC7qvWu7gvmjOxkuJFWkY1K8FqMefKQpDWhMgzre+BlfWqMx27DFiq7EhDXSrbdK55MgmieLLKH53QN+3lb6FaLaX4KMgQwMZ0PZFyyrV5ucKLu2jCOUL5U8WXfzWcOXAKctaaUtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxpHNPM1h5WHE3bKFtalzR/jMNcu/d4P6cC88oVhimQ=;
 b=KrpL8hfhIDSxX/A9b6wgBc9Mlhs68d5L4Ud3Jj/E/meahZ2vGaC5d2+8IEYn+xAKSrUzVBIMDd7ivSnB7Nro1IXJDo8ymibl0sMIgKgLBJYkT24YzN0p/cynHz+j31vRVRYtJj0PTplEbsQP9bnB7ZT+aw7V8T5JkisQs7wuUL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 09:03:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 09:03:05 +0000
Message-ID: <cc217826-180b-491d-aa49-0dff073b8f99@amd.com>
Date: Thu, 3 Apr 2025 11:03:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the comment to avoid warning
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250403072910.555319-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250403072910.555319-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d21594f-d804-41c2-151d-08dd728e584a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmlpL1V6YzlEamZ3b3IzdFdMVGdiMWduRXZQdTljYzcvbmlFc2NMaWhDNmlF?=
 =?utf-8?B?NGZRWjljVTRsbU55SXVlL3JLVm9UL2d2TTlIZU9vcmpNMmZOa05qZ0dTdFJJ?=
 =?utf-8?B?clFKTW41T04za0hteVpsd25FMmo2emZnMlNZWENIZ3JtQVhQbDFwTmhZRHo3?=
 =?utf-8?B?ckFySTl5T1B5cVViY3hOWUg2YUNuQU1RY0QyWUJQQXFnU2JBVWsycjVqc2l4?=
 =?utf-8?B?TjhYSFE3ZjhSY3VMRGJMYXhja2JkanZVSHJmZlJBdGNQeDNmTWVFSFhwVmUv?=
 =?utf-8?B?TWFmdVdGMVhMS0ZlWEtua3IvRlIwZHY1QzFxVHZvMjcyc243QnhtMTg5TUFD?=
 =?utf-8?B?QVdseFoxRDZ4NUtNdit0VVk3dTZOZUg5dkRFOHByNi9VaHBBREVnSlNFM1dS?=
 =?utf-8?B?Z2o1eTBjTTRMeDFDcVhxbVVnQkoxUThsbEJmNWJCVlNiR01Pc2JoR3JpaXdt?=
 =?utf-8?B?NHZpaHI1Y0hhNjZydWw2d2tZMkZtMHQxT3pldWx3Y0lXU3FzTWVaQmFzY3k1?=
 =?utf-8?B?UU5Rd3FYakhSMk84NEF1VjNFYVlhaWhaSjF5N0Rwb0l4Z0ZMaWdlZW1lOHhT?=
 =?utf-8?B?bkY0UitIR0VZRVdNMzZkSlRHNzRjYk8wUDlza1IrLzhpS3g4enZPQ21MRHNM?=
 =?utf-8?B?azRZSU1PVTJIcy9oZlM2L3VKUWhzUndOZnhoSzVicWpVTWJCeC85ejZNc09s?=
 =?utf-8?B?TTBYcU1yVjZqMFc5QkdUaWs5ZHp3a3oycmdONjJjTjMyeDVoSnRmQzVpdXhn?=
 =?utf-8?B?QXNvSnV3U01pd3kwNkhpb0RadnNYdnpKMHRkVjBBLzZlMkZzWlpUSkd6K2Fz?=
 =?utf-8?B?bUliTU9JVkZvdDNTTmx2RWVjZ05pODlpM20xSkQyeE9wTHBFQUU5VkFCaElT?=
 =?utf-8?B?WDlmaG5KTURPb0srdmhha2NFTHcxWVZUNWVEb1FyMmw0eTV0WkZzci9CSk9t?=
 =?utf-8?B?bW1GM3JHSk1Hd1BRRWZCbW5Rc1NvaDdMNjE4aUk0Wk5ydHNOamxzZTl4bnhS?=
 =?utf-8?B?NHdLL0lqZy9WeEFWQUU4WGZPRzZCUEhIdEIxWk1tdHVzbFUzeFoza0JBRFA3?=
 =?utf-8?B?UTVPQWJYZ3A5NGFIdDNsblQ1TCs1R2NvTEtsNDNUSlFzOTRnY0l2SG9VMTZl?=
 =?utf-8?B?VStsZE54RU5LUzVvRlBreG1QYmZ1UlUyQjdIdi9kMVZRZ2F6clY5NytIZ3pp?=
 =?utf-8?B?KzIyOU1rSnA3YjF3Ti9nZDEzWFVVazdaZlFCTnpCUzhuM2lPTUE0UlBtLzRR?=
 =?utf-8?B?SjQydXpFMDUwc0swbXluRkFZUHJQRjZWK1dSM1Z5T3BOVElraEtKZ2FaK2Y1?=
 =?utf-8?B?ekZmanhheGFaeTMwMGJUZ0hvdDJ6eXlDU3ROVFJabFZ1Z3B0eWJ0UDVUZStm?=
 =?utf-8?B?bzExWDRHVmVXa0YwUTFFZ3VYQU5jSUtYTDRHK0d0TmlJZXphWkU2TXNENzBw?=
 =?utf-8?B?NnZlS0RKNWxGdVhadC95WEtuOUVoVVp0ZEhaMXM3Z3g5TnYwbHVFS1FMVmJH?=
 =?utf-8?B?NDdkMkU1OGcrcytNY0h1ODRlTjc4L21maGFQckVkTGdWN3lMUk1INGlMcTE1?=
 =?utf-8?B?Z0d1SEtHOE9tWXNVNFNmVmRHTkFpaU1BTEhFeUlKcjJ5bThSZnFRaSt6bC9X?=
 =?utf-8?B?WUdQMC92NERoWDhGeUtYWFF6T3ZXaE1LS2dxNWJnY05lRk5qc2JtSGFHZTNU?=
 =?utf-8?B?QlIvYWs3QmEvekI1T2YxSFJEMkpqWHlmV3ByL0ZtaFdyRmU2YWUwaFRhbEx5?=
 =?utf-8?B?ZUwyMHRhTnFYYXBUb2VpTnJpUlFEa1J6K0RFU2FmWDV4ajNJaHh4d3pjc3JO?=
 =?utf-8?B?R1p0dXBpK21FYkt2T1prR2FKZlFtcU1vVEw0OHpVVGc3K29kaUpkbll1S2RO?=
 =?utf-8?Q?oqBDy8GbvZopw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHQ4b2dONnJ0dUhtcXUxZmFFUzQwTGttUTlObnF0T0ZBc1ZLNWJYRk5wTjhX?=
 =?utf-8?B?QXUvaWlZbU5CNEJCdDhlUmQzR05DZTJlSVYraW9ocnFZYVpmN2g4NDJRMEg4?=
 =?utf-8?B?Rjc4aGJFak51SUNDU0poL29USEw0N2I4allqZXZhTkdXcUdWLy9JK1ZQaXlu?=
 =?utf-8?B?MGdWaGFXWGVkZ3hQdXI2SCtFUk1jaHUvTUNkdGVaeTN1YUxNK0lLM2JvQ3hp?=
 =?utf-8?B?dzlIV3AycnB4Vmdlb0xqYVBtSkRXWXk3UzNwaGVqOU1SajBsMmJTYmlXZVll?=
 =?utf-8?B?QTFWMFVSVEpTYkpoK2Y0cC90MGVyUlJ6MlBWZExIc0tkOWhQWHVxOVlKS0cz?=
 =?utf-8?B?N1JpMXhEWFIrajcwck9CK1p4Vk9VZDhKeEhDelRCbmQ2Um5WWjJwb0RQVm9l?=
 =?utf-8?B?SG1xUVVXdkFQT2hSYllFQ3JIQ1haR3MvQVo5RlhzTkdtTEtMV2xKNjE4SGNI?=
 =?utf-8?B?K1hpR3pnYlc3UFBDNThZOVE2YjdrOFpsSHpINXc2NEw2M0JaZmxwTldQNkt3?=
 =?utf-8?B?VldZbDlFVkN1WnhDREozM0lrdGNzZmVKaUVhUlcyRTBneld1dmRnSHQzdk8w?=
 =?utf-8?B?djhpOGdCcnNVWFozcnRWNGRPc1FaY2lFd2U5UklkcFN4VE1FWnk4VWRFSUln?=
 =?utf-8?B?OUdmVW4rS3dlQ0w2cTFac01xYXVIWlFvZ2pnTDRuRnJ0MnNWUEU5UTVqT1dH?=
 =?utf-8?B?ckRvbzdNd0YvcnhzTDRSMDlDd1huN1pWNG1uNEtnMEZIdUtYVlFHajVWZGtW?=
 =?utf-8?B?RXVzU01SZ28rRm9Wa1l3NTNRMXBKOThDWGdrUjN6OGVUcUw5YVZueStYTTRE?=
 =?utf-8?B?UlQwWElyWFd3Kzd5UmJxSkE3TU1BQjgrZXlaN0Jpd3c4M0N3YVNnajFZSlBs?=
 =?utf-8?B?NFlkdlUyOUg1M2t2KzRsK0llQmMvcDR1NGMyOFRDWVJ1YVkzRHVnVEw0TG1Q?=
 =?utf-8?B?bGowd051Z203U3JSQWVmL2Q5RzhMNFZIN2NlN0xveG5HRW1hUVdZTTNBL3pu?=
 =?utf-8?B?Z0tKdmdaaTViL09kQzhUL1RBS2wvZWZLTEdZbkFOUm1VMlFzYWtnSk5QMW1V?=
 =?utf-8?B?cjJZcFU4ZFBCM0FvTWJmeVVYWTVnUnp0QkluY0dMZmJadi94Z3VUNEhsUFV4?=
 =?utf-8?B?aHlZRUQ5Vjhkckc1VEI0b0VlUTQ5Umt5S3dVYWFVVE1RUGMwYUs5ekhCMHVr?=
 =?utf-8?B?c1JRZmtNajUvM1pSMytZTEo5RUhqZzFtNmhaalVjUGJQbHptQnZaUnJpK2d5?=
 =?utf-8?B?NW1HT3hTbnVQY3dmU1c5Z2JxVzVSWW13TTMrZDZuK0J3ajBWcGJlTWdJUm1q?=
 =?utf-8?B?K1lnOFBsam1Ta1pFY3FHMXhwQnBaaGw5cVI3M1Q4c1I3OUtaVkJteVlwZUpV?=
 =?utf-8?B?Wmd0ZSt5YzZuUXNyQld3b2srR3JlREFRY2V2V3UvRUpnRU95ZlhFRDMxVlRH?=
 =?utf-8?B?bEtxUDh0QVp1aFJ4VFE3d25CVjBhaDZBMFVScmkvNWJWK1RLR0FOS2RoWWNE?=
 =?utf-8?B?dXE0Ymt6R21pQ2FBRnliRm5yWkN4T3FocVAzV2RUMVltTmc3U0N5aVdpN0lz?=
 =?utf-8?B?UG52djNMeXhKWnJsUXJmajlWTE9hTGt5Mzl5bHpLaVVSdi9PTXU4QWE5bWps?=
 =?utf-8?B?R2FpUFhkZktreGpldTBDR2xHMmt1UFlUNzZ0NFBuQVZEVWlsbThkTEJWalcr?=
 =?utf-8?B?d2o2YnJXQjlFbVBGU0wzOExVejVGSXgzYTYrQVpyVjhmM29HNjBiYkdkUXov?=
 =?utf-8?B?STFiVnpvakh0MHYrR01QS3J3Y1ZQNC9uQmVwc1hqSDNZbDVncVhRTHBaTmw5?=
 =?utf-8?B?dGlONkVBZXlOaDdQcWxTOC9VTWJMWi9FUWhLNXY4VjFsRnJ2K0tYcFdDUGdw?=
 =?utf-8?B?TzUybHY2dEMxS3ZxWVM3U3pPdjlabEdLMTBBZ1J5WENaYUdiQm5qblZsWXJa?=
 =?utf-8?B?L1VhSE9vTlRJR3VFVnZleGdaNFlQYXlHR28xek8xditCbTltajk2ZVlhZFpH?=
 =?utf-8?B?YkIxbTJ3K1M5cTRGbFJWK2lXZHVCQTJNdC9ObTZOMmtBSGJTdDB2Qk5KNlNO?=
 =?utf-8?B?d0oySC9xMytVb3BUM0F4T2cxVk9ub0t6MHNEaVFQTE94V2RGdVAxSW8reHZF?=
 =?utf-8?Q?/pdJkjeTt45vTVLHACHemtb74?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d21594f-d804-41c2-151d-08dd728e584a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 09:03:05.1307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTzizsUBfo+YhKtahV+qMkugXLk1/kx2vPKAFkPc33EHaODGyDkqSs2RCuqZHl6i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
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

Am 03.04.25 um 09:29 schrieb Sunil Khatri:
> Fix the below comment warning
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:541:
> warning: Function parameter or struct member 'adev'
> not described in 'amdgpu_sdma_register_on_reset_callbacks'
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 0a9893fee828..c3c6f03190c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -531,6 +531,7 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
>  
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
> + * @adev: Pointer to the AMDGPU device
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
>   *
>   * This function allows KFD and AMDGPU to register their own callbacks for handling

