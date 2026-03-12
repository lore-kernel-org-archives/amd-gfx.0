Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27588103E301
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 10:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B621110E1D7;
	Thu, 12 Mar 2026 10:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SUuNIExU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0640510E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWYRU68LIL+JAeo0GH7eeBdDDgUaRpqeiEU2ldslKN20S+1MXxT0WFUBh43esFx7C22IKXBI3KW6M0Ys0qOAWRnpyIHCJWWu9gq9NnqBSNc1XsRkegBz5T48KBAYOpE9jiKbV9fQogktJMJNXhcnGGea/A4SCVRUAPAwzE+QZxCKPDK0DH031aI2OOKNyUPxvGBbzl7Ey5OK16X0V5T7aEQ2bRqVFyweCR91lLrYy75iy4rkr3Og0NsFma8Qh7ScpTAdZVoQfpUC8AD+RbDZRxukzVSAZIMbKS5qws1KGS9BHLLutnhVgdQDJgdhlRYgAdRb4IsYv+q/VoEJy1t4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QgpBk5jfz2h/5CTHfgVX+bNIMV9qIBP2bzzlcZ9BKQ=;
 b=BCyDBfGEegmBxoesYq38sXcAN5K5Y/HlotEKeJKDzNPG+gwIL2RsarrlVL62xE8uONRIcsLn7tsUaTzMCj+4gsKMDAG2E494lnUMlQcIWy/olBDG/F8p+4VM2OdANJE2xH3AFpUF7IKXV2DYxqfNUlYhMQqXugZQwJ4K5+0y8hc5P9SDxNDXbq2tazzMi72g/esnXEDUZ451CLXHoLOD0g5f80GuJiYXIIyHmBvFSNq44OF0FhIVwLiDxNWm4NZxg0Ua/7Kz/v1UATHt5oggykru+wekoxzmFbNwxW+gKvuIBeYxBolDolKcNHPMNudWJFD78zqN3FI3dvraiCiolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QgpBk5jfz2h/5CTHfgVX+bNIMV9qIBP2bzzlcZ9BKQ=;
 b=SUuNIExUfyX4l+ZjRAjkW4cnCxhgM5uBcLNQzR6Ewk6wKX5rV01GpN2/GORKp8smDROkKWnkknBJ3HetrAF3h1fuaXNyTVRAj6EyT0vZQkPoEidBHUWRMkik2Sa4v2zdmsPX33WfN52rA2qsYk5SxAbFkvC2DGgHID5+ytxBPF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Thu, 12 Mar
 2026 10:36:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 10:36:36 +0000
Message-ID: <21231eea-2070-4991-842d-c580a3e696eb@amd.com>
Date: Thu, 12 Mar 2026 16:06:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amd/pm: Add common smu fw check function
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260312102735.609454-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260312102735.609454-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ed70e1-25ef-4ffb-3494-08de80233cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: f7e1K/nbJYYLhlxH9NU7ctWMgVw2Ri+vab0OmmqFSohS78otJltvToCOeTyZ+L50LpN9RxVfptOC/OkhUbSY0NH+cihgS1Bx2KBaU5tHj4AWYpFPOXI07IFMWIACuE22z7VNnjK5zGiA0Gd5IPtRsO1cYOA8HWZNqNGNFh52mpktWgBlGmODhnk/aKErwG4sNTt7qHqh6Y9NJOHMCkRCY9JX7mNDrV+S1H68kvQVeLUFoZHuFyL++Ct8QEWAovtzBDqHvUFnZjLQs/UqU18v5+QY2gfHGJSBVonDOciz6daF5AchXAcbNCA6DnRghV+anglOd6+b9FG6jSRsuzH2yOdRw5xqVT1sk51Jm7OYsb9B2SCYjJVEzpVee66a/vzvAnBk/7uQNyXFz+T0Y+4+x3JylAWe5qlRKhMh10MAwn5lxxbnU3Emuff+DF+THjETlMyB+DtG/1WYnFJ83PBi46nGgBSaBAI/b15EvAzan00dVx1Wbu85QcUSZGMPW7Nj70pe7oYV2yv+ZZUiQ7P5pRjhTUYJDUtjm9RZQlQkWFf6JDPU99vq4ql+EM0Hx+1HVSvqR0/38cYGPR30K8n5zvCAFN3GDVfSS5V5ZNiahQag9klJAVyy5iCkISfPHq1mVKemGWnJhuQLz0A8SAKLJT9qpjeWhfLuBPRorITFFQbxsPVH7oZ6vm4YZoLsyHV0O0R7xeedqHrnryFSKB4yaDAuRufoIhH3ZTQP6CeT7x0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdlWDA5alF4WW96UHJxOHh6VXFTZ21IMGRLNGkwSTZCNW50TWkvTkRBZ3BC?=
 =?utf-8?B?aTNOcWtpbmxFZElGZWNWZFd3TDhMM1pZdStiYk1YdlZLY1lENHdCazFSdU9C?=
 =?utf-8?B?OXE4MlMxbEF2V2FsMDFyelZCWGhDWkpLUmpyTHZpV09yMTdEVkVDRjZhSDVy?=
 =?utf-8?B?NTUzejk3U3k5ZEtobnRuNjA1Q3VZTU5zVkxOUXdSUmdlU09vODVzWUt1NzFt?=
 =?utf-8?B?dFRGd3cvRGlJd3N1bFVQTk1WM2d2bTRCN3RMY1FuVnQ5Y0hIMSthNHYrVHI3?=
 =?utf-8?B?ZUxIT1p5NGc0dWsvUzlLcHpOUWxQbW9XQ1lnTHd1L0VDdXN3djhMT1Mrd0ta?=
 =?utf-8?B?cEh2aDFTa0VkRGE0anBmN3pMdFoyZm5mbnZrVkc1TFpTWG0rY0hUcHhpTUlN?=
 =?utf-8?B?VEdCRFZERmhDZTVmQ0NPMUx3ZXA5eHpzMTNlS2dnS1JLMzkrV1JPUmRIc2xi?=
 =?utf-8?B?S0M3Y3dhbk8xSTZRWmtJM0U3T1N0d1EyN2p1U2RYaEVicmpEclpiSkhITmVD?=
 =?utf-8?B?Y3NicC92WFliWXltVEdJZStuZ2R0blhiTGFOdXN4SGxrUHB3aG91N0FrbGRp?=
 =?utf-8?B?WFlXV3ZlbHRyRTF1SjBvZ0tQRTZUeUVCbno5MWVLK0VDK0V5d3QrTVVaaVZT?=
 =?utf-8?B?ZWVUOWtqY21KODVVczVvVGIzbUUxN0Y2VE9XWnFVR3ZWYVQ1Y3BWczFaMGYy?=
 =?utf-8?B?NGhZV080M051d2xYNVlUbm9wVWdyRlBvbkhwVEhOVTJJQ2JnQWhYSnBGR0h5?=
 =?utf-8?B?bEc0L0RJTHAwY2NqMlllTi95c1pLUzBIREFLd2JLNVA2WU9PRzhsNFZPNWFw?=
 =?utf-8?B?c3dINS9pT3pRZGpXNmFuNkZxSG5KdElOYVRWTy8xc0MxQUVwNnBJQTdpK1JC?=
 =?utf-8?B?bldyb1BGSEYrbmg4RFk2RjJOZVZzWTl6eGtjVGxtKzVIZWxGeG5sOW5vUDNP?=
 =?utf-8?B?YUI4bkFQbXhoazBBaTZpSHJtT2E2K1VVVFN3VzArRXNOYnRnVlErcExaS0Iz?=
 =?utf-8?B?TWZCdU5aaUF3NXhEY0dkUm42bldNMzFsMVdVLzVwOUV2d1YwN3pFckFndlFp?=
 =?utf-8?B?aXB2bkNiUnJMeWMxZmkxY1ZSdmhSWEhhZk10U3JYN3l3T3E4cmhTK0E5dHFQ?=
 =?utf-8?B?dmtPU2phTGRFNjAzR0JYWE55a1NWZHBmajZOZElYN2NsZWF0VHRDKzZiN0Fn?=
 =?utf-8?B?Ump5WWhldU1UM1IyeEI1V0J2YWpVcnl6UExKVDFpdHByUTk4Zm5sOVZCSThT?=
 =?utf-8?B?eWJKZysrOHAvQ3RjaURha2pOWXE5bTRySmRicFpzUkhIOXIzWTNrSThUZFQ0?=
 =?utf-8?B?dWY5RDZIZU11dXF2VFBQWVFxRWROaGVRckxSY2piL2I0a2wyRGtYVkM3Q3Zj?=
 =?utf-8?B?bDg2TXFOYjFsMjhRaFFnanA1S1BqUDBGdGw1am9iYjFkcy8weFg5Tlh4aDc0?=
 =?utf-8?B?cTM1dGdxbTNKVzlMeXc4NkNKOXJ0Yml1d2pFVkdBUU01Yk5xM2hLSTZCT1Bm?=
 =?utf-8?B?cStQYjdBVmQ4Ky9PRW5ianhFbnh4Rm0rZWp0d09WbUpGVU43TmJSb2JES2dj?=
 =?utf-8?B?TkZRR00yODU5VmFHazZDRkZ2a2RacGpMZmNLdG9CTlBza3FnTkNCS3JheHBq?=
 =?utf-8?B?clFGWGRaUU9DcDdJQ0pyczc5RVpmQ21TU2RKaHV1NDVTa2dXbFN3a3FydE0w?=
 =?utf-8?B?OXJnUjg5eEovUElyRUt2aWZscmplRC8zVXp2em9jZjNHWmVMeXpFeTl5SjVj?=
 =?utf-8?B?TGQvaXlRT0dRY3RXUTlvUk9SNzdXVjJnRXYyVFFsbUFWUVNiT2RzRWg1bVBZ?=
 =?utf-8?B?VDVIY3NYdUFaREo3Z2FrdnJJZHJkV005dU8rRXpHU1FMaENKMllFZHUwYkNS?=
 =?utf-8?B?WlkzMjJDc3phaVA2SUMwVXRXSmUwam1tY1YrUEcvLzNSbGdLNkc5VTRYRVVG?=
 =?utf-8?B?bEQ5SEFRNGZFSzYycjExSGZUcGhVUExLcm45Y2J0Vi9QM1NldVBpT3NHdDNp?=
 =?utf-8?B?alYzUko2V1B3WmgwekMyaHYvRjVFcWo3QkxjSitvcSszM2Vyd2Mxa0o0RG43?=
 =?utf-8?B?S0dMVWRFcGVRajMzSWdkaHBrbXp3N2I5cG1Rak1tQ20zbmgwRlpZakJ4RXl6?=
 =?utf-8?B?VzJ2NjVyOVpJSjExVHRVREdBRXYyMFdFMHJEYy9UcU5YOVhkN3R5YmkrRXlq?=
 =?utf-8?B?dUZuMGVVN2VSU1hWMjlsYWZLT1dWUjJNa3JGNjJVcDZZWkpjUndpc3pHQjRF?=
 =?utf-8?B?Smd2ZWJHTEhXeHFVc205U1ZXUEVzaXJLQzZNd3k0QndZVFpUOWErLzQzYXZI?=
 =?utf-8?B?azQwWEdmd1ZmN2JxWFAwcTFESkFXb1Y0NjN3V202SWtLOVBGaDh0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ed70e1-25ef-4ffb-3494-08de80233cbb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:36:36.8864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIpCF9O0pMFpwHYO0jvKTyDGU+IrGOCdCsmXDxT3a38pE5YbCH+/FcBKlab8n8PG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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



On 12-Mar-26 3:57 PM, Asad Kamal wrote:
> Add common smu firmware version check function
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 33 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  1 +
>   2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 326c86b920a2..432ff30dbbd5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1035,6 +1035,39 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
>   	return ret;
>   }
>   
> +int smu_cmn_check_fw_version(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	uint32_t if_version = 0xff, smu_version = 0xff;
> +	uint8_t smu_program, smu_major, smu_minor, smu_debug;
> +	int ret;
> +
> +	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
> +	if (ret)
> +		return ret;
> +
> +	smu_program = (smu_version >> 24) & 0xff;
> +	smu_major = (smu_version >> 16) & 0xff;
> +	smu_minor = (smu_version >> 8) & 0xff;
> +	smu_debug = (smu_version >> 0) & 0xff;
> +	adev->pm.fw_version = smu_version;
> +
> +	if (adev->pm.fw)
> +		dev_dbg(adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
> +			smu_program, smu_version, smu_major, smu_minor, smu_debug);
> +

Since version is printed once during load, this may be removed as well. 
That aside series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	dev_info_once(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> +		      "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
> +		      smu->smc_driver_if_version, if_version,
> +		      smu_program, smu_version, smu_major, smu_minor, smu_debug);
> +
> +	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
> +	    if_version != smu->smc_driver_if_version)
> +		dev_info(adev->dev, "SMU driver if version not matched\n");
> +
> +	return 0;
> +}
> +
>   int smu_cmn_update_table(struct smu_context *smu,
>   			 enum smu_table_id table_index,
>   			 int argument,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index b7bfddc65fb2..e4d282d8bcae 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -207,6 +207,7 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
>   
>   int smu_cmn_dpm_pcie_gen_idx(int gen);
>   int smu_cmn_dpm_pcie_width_idx(int width);
> +int smu_cmn_check_fw_version(struct smu_context *smu);
>   
>   /*SMU gpu metrics */
>   

