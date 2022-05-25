Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E52C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 12:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7812B10E027;
	Wed, 25 May 2022 12:33:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C82010E027
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 12:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWbYGBxpyojngL+qpK4r3HhaLTGsxYDG9+N/nL/UyxxcVHhHeJNGeoN8UvNEyLRgJGb+DIkppwzjRBYw2cA3IigWpgeFHZc1vMNmFMF3QiPMJNt8Of3cgV2xwk9gUQ/8Ox7AaBF9Nfv1y2F5wkz6QU3e+eGH9nclddgmShANVIDGYB9SsuoTbVg2mHe2iMdRIG8h+xhOJMznQgYHmmN3NiVfHeA5HaPXWUKNlgMVTtMjh1voIv3SvgxUUhrGX+V9JesGgTlvBXfdn6clProLsU6ryrsfk0GXToswgJjsqpB/kdqit3E3euc6GN1bjoXXJ6W4MoZghYgMfDjlMkgKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY3kmci8/1Cr5yEYGoVeSsnsAWXBWk2jQeIWnud/Wgo=;
 b=mAvtM1ATSkbAEAWtDEsJ91cnMVpeSdsLZaKFdGKyAFcrHZ/f9KaEs2d4MsN2vHVKAgdF8FGCaV/ATzxSDaBH05W1vl+Kw42Ui4pP1qBx2jJRVYIiLXXle9ebzz57V/DK4yJ4DAm1pxDOLYdCTLNPFLsiiqCdtkZx3/1+jNtn4WXxrqt+UioTmX1GA6w/U2/R4dOHswdnwD8wKBF3RJVgJWh/kg3gyoOhlhff5cZ3hBT1pcMy5bHeVW5JZXQBYHCbknRd66N9O27TlS60VtRB2iCM9yEgIDcfd+aMO79QiTeBjjwebI3err9XNJCKlHnrD7DDnpHxz/srw8Z68ROziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY3kmci8/1Cr5yEYGoVeSsnsAWXBWk2jQeIWnud/Wgo=;
 b=wt8av8DSRvCpAICpEx7o7zwCsd2Va80KL69kgLyqkg8e0MFmKOPv7+YBYts9A+9gLE17ptNwOKtrCLmRvhUQsN84UAhu1zEcmL8GCjSoX6xVdFt29GT2nTgQd53DUyBh1T0hbSCEppaVah1q9mVfQAUHSoDytR25r6Ho6e5cEUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 12:33:41 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 12:33:41 +0000
Message-ID: <9ff0386e-95bf-f421-83b9-ab295968b4fb@amd.com>
Date: Wed, 25 May 2022 18:03:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH Review v3 1/2] drm/amdgpu/pm: support mca_ceumc_addr in
 ecctable
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, tao.zhou1@amd.com, evan.quan@amd.com
References: <20220525061047.26529-1-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220525061047.26529-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af12ab38-1330-4303-ec68-08da3e4acced
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5296483E30BAE8E2551D147997D69@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUvcKQuF7qhEjAE6O2Mo7IFxoYd4ircOq22nWeyHlfMERjip9Tyx3gopX6TNfk2Wnlx0CB5LBuHEypviWlxF5obyHHZWxlbdtihDS0OHNz1vAqWhl2IMzlhJKmZQYZ9XH7wXLxirT1poQUZSHiXPiwNSSo21y3U0mA/y3SOitpa+Xrog/yvpZcLIcFyw40MVcx+KzFLaurSAr1tN41Eq5QtKnuD+d569jICmGLVvAnyZmK4IL3RyyB+O4ndX5Y0QVt7Chm3XCYDqK720rkadIdw8C7a55NR2bJEyTvgCJ0DJIWqn7qctK78iF/RhVltE27GAWgrcUDIDugwOD5D2fSoZLzMXnCr/Hl1FZHGh4BcICw4/XdRZ5IACZHg/vf/aTS38GNghiw+FxpZa1cNTDbv+k/5ECJPe5zNw53efpik2ZRk3tib13Gzky2fQ/zMKThNAaFsxlxP0UMgHVpj9a4khif9j/xbx/KcMsfq6UBUOvJp0z+ptLvVzGntGmnukBZMXKR2vYSvjY2+wHnJjcGTcbyvKQJPc7Blv1rQN/QeeAwalMmvJW1nfcPlHP1ozXFX6rTOsuF7NpIDDqCjcQeAWHOj5no61UkveUPt3SrFYN6eMzjl/ky1ghuQgUaXbGMThZVUaejRL+v32G3rILwWdUUvQX/dVMGeL3SKIM4K5iQnzupmaErSpftAsZWVDFlOD4aaLox2g124p6JmIDqj+Zgy+JEzb4mdMOmJa+jk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(8676002)(6636002)(5660300002)(8936002)(66556008)(31696002)(316002)(6666004)(508600001)(66476007)(66946007)(86362001)(6512007)(6486002)(26005)(6506007)(186003)(53546011)(31686004)(2616005)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE42T0tNMWZZcVQwcU9tTTVJTXZEcE9uWitWQ3h1V1c3RzlMSmdjOUNTWWpu?=
 =?utf-8?B?RlJtSGpoVkNzSDhNMnhJWklMa2pmekwraFNJMGJxZ3lGbCtNQW81VElKK256?=
 =?utf-8?B?T0taOXlxMncwUHk5WUFlcEpJeVJib29mTGFZVi95TU9IZ3RaQ09mL1ViRkNN?=
 =?utf-8?B?RzU2cEZYWXBRSWtPeUdhbk1WdFBFbjkyR3Nya3I0N2lBNi83c29vV3NNTHBI?=
 =?utf-8?B?b0YzOEkyQTRnSFRCd1AzdDJWb1F2U2w4SlZLNGVQQi9IZmwyUkp6ZUxUTk12?=
 =?utf-8?B?NDl2SEhlY2piVEtIT3FucEkxejR2OEZVRzdCL2k5RUFmUXBnRGNscWxKUWR1?=
 =?utf-8?B?dzA3ZVYyWUdqV0kzNkxKRExtQ1VOMUtQcFNKQWtPRU9iYXZqb2FNc3ZDYk5U?=
 =?utf-8?B?US9MS0Q3RWxGeHRNaU9NT3ZtRmVYcENHTXVJZG5UN3ZSbHVldVB2VUE3VXh1?=
 =?utf-8?B?Q01kd0FhbUxJTEV0dXQwd2Y2TUR6TkloNGlSdnlUanVWNWFtUHlXVEdqVG5G?=
 =?utf-8?B?bGFwTU9IMHlnNVV5SmJKMnl1bENORFAvSzI4d0lURXlEYU85eTNCdHA3WFhv?=
 =?utf-8?B?VnN2OTZvYWlYSlptSG1tNmlOQk9UckpWYnpPbHZNRncwMzhQSmdRS3BYS3hu?=
 =?utf-8?B?YUlHckhVQVJnZHVTSklUY1M3S3FNNVArYlBRSG42UEpRMURsVVhGY1dDYysw?=
 =?utf-8?B?L1l1M1ZwWkxwa3M1djhVbWxvcld6S3FvK1FHV0l0ckgrdmZoUThCd0pXZFFs?=
 =?utf-8?B?ZE1tV1BScXhrU3pWazVsc0FER0o2WmdyR2dzUkxDRmVZRVRMeU90VWgyM1cw?=
 =?utf-8?B?dFQwNlorK3lZM3BucWFVbkNXVlJVUUFPdEpDMHk4WVhOMStlQi9ROVJLdVN6?=
 =?utf-8?B?OHJsVmYvZjUxL1lSeW8zSm12ZFJSeGxhekJSUnpCbTAva0xxTGlCR0VNVTRF?=
 =?utf-8?B?eURRMk1oSTcxVGpuaE5qVm1XTFNGY3lDODBYZ3Mzald4V2VRZGVyZVNUNHhj?=
 =?utf-8?B?Skt0Zk1ZSmNZSWNmOW5ZcWxzdGFOQnVjL3Fma0NjWVhRSG9KYmQyMnpEenh4?=
 =?utf-8?B?cVV5eU9NbVFZRUxjUy8xU212NTV2ZktQTzM4QTR0MEExZThmNXI4bjBkaTJq?=
 =?utf-8?B?eElZdzBXU0JFU01sbnI2ZGdScjJHbDY0TFdLenBmWVJ5R2Y4b0hjREg0dms5?=
 =?utf-8?B?YitLZUJ2N0VORGVZaE5xeEh5Mkg4OUxNZlI4SE5QRlZ2cmxjV0F6ZGhwUys4?=
 =?utf-8?B?ajkrZXUrblJ4NjlrdFZEOHRHejdmczRjVG9RY0wrWmtoMHQxTmRzQUhYVkxu?=
 =?utf-8?B?azQrR0t3emRwQy8xTkhxcUVLN2h3Wm9QNDNsbWdPc1pjSHpSZzFzeXdKNEJt?=
 =?utf-8?B?aU1TNk9PSU5IbEt3bjkwU1JKTUJyWGdtVnRsM2ExS01SMUN2T2pNK051V1M1?=
 =?utf-8?B?Nm00bDJtK09ETk5kRlFCajZjYzBsOXhqSTdvalp2bjdBbnlKcFo2NU9lZzlN?=
 =?utf-8?B?VXZVMjlrL2pSSlZxOWdFT1Q0aUtYR0htSFdGQ1UyV1ZpZ1hyb1Z4N1gxQith?=
 =?utf-8?B?WkNDK0wxK3ZrMnFwNzQ3d1FmL3IwelI0Wko4U1J4cWtaWitKTXRjc1VmL05t?=
 =?utf-8?B?OXlWZjZ6TWJUV09XN25MaCtCN3hLTW96YlJRMUtHT0JmUE9oZXJ0cDJNaDJW?=
 =?utf-8?B?WDl4aDFGM2JiQlY4TEFrUGcyWllCT3l2VFN6SWJwSE02dGoxdnQrZ3NkYTEx?=
 =?utf-8?B?eEhJd1Y4a0dWTHdEWkJneDVPTmV3ZW9HZ2lXUTdZNHBKSW9OZlFFaTJOcXpo?=
 =?utf-8?B?L1lqbkxhbFZDclYvMUtSRGlSeHdRQ0VxRGsySmNKRmNxeFNRZjEyOU1YeDds?=
 =?utf-8?B?dVFDNjY1dVFPRXBhOWNJL1VKSWhDanN2U05BakNGbUdaOWtpV0NDRzg4NGd6?=
 =?utf-8?B?Rnl5ak5ZRVpLbHNxemRzam5HdmF4V1hudVEySlpYZlR6V1ZzTEhCeDMvNHlU?=
 =?utf-8?B?TGs4cXRrN0JoQXd2TkZaa1NzWWZWamlxUVhTd0EyUExGZEdaamw1K0VCSTBJ?=
 =?utf-8?B?eWVlVXdoZmU2ZURldXBJN2tJU2lPUCtRVjlteE15blFhYnJMMVQxaGRZdjFW?=
 =?utf-8?B?QW5FOVgrZks1a2FjY05WL1RtL0NJNFhHZzl6UTQrZ3Jla0NPUkdYNUdCWGhV?=
 =?utf-8?B?bG50TEd4US9hUG5QeTl2U3NwZHlJa05VNkRscUhsOFJXbWpQaUlLSjdKWEhN?=
 =?utf-8?B?T0RiWFR1M2Ivc2FQNlppMmRIMEhrQzVEanJqTjUxaDVielN3b3A4RXdxWEdR?=
 =?utf-8?B?ZGxkMEZ0dzVGNVB1NjJlNzZIT0w5eXBGSTdZR2R6SmFyRFhuUUwvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af12ab38-1330-4303-ec68-08da3e4acced
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:33:41.6899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJYyMK3Q5CwFEtiAaWY1bSQzNUZx6zuq0hAICEgbpNc8lULC1UnlWJOS9YlPbc1D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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



On 5/25/2022 11:40 AM, Stanley.Yang wrote:
> SMU add a new variable mca_ceumc_addr to record
> umc correctable error address in EccInfo table,
> driver side add EccInfo_V2_t to support this feature
> 
> Changed from V1:
> 	remove ecc_table_v2 and unnecessary table id, define union struct include
> 	EccInfo_t and EccInfo_V2_t.
> 
> Changed from V2:
> 	sync patch verion
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
>   .../inc/pmfw_if/smu13_driver_if_aldebaran.h   | 16 +++++-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 53 ++++++++++++++-----
>   3 files changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index b9a6fac2b8b2..28e603243b67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -328,6 +328,7 @@ struct ecc_info_per_ch {
>   	uint16_t ce_count_hi_chip;
>   	uint64_t mca_umc_status;
>   	uint64_t mca_umc_addr;
> +	uint64_t mca_ceumc_addr;
>   };
>   
>   struct umc_ecc_info {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> index 0f67c56c2863..6f92038470ec 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> @@ -519,7 +519,21 @@ typedef struct {
>   } EccInfo_t;
>   
>   typedef struct {
> -	EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
> +	uint64_t mca_umc_status;
> +	uint64_t mca_umc_addr;
> +	uint64_t mca_ceumc_addr;
> +
> +	uint16_t ce_count_lo_chip;
> +	uint16_t ce_count_hi_chip;
> +
> +	uint32_t eccPadding;
> +} EccInfo_V2_t;
> +
> +typedef struct {
> +	union {
> +		EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
> +		EccInfo_V2_t EccInfo_V2[ALDEBARAN_UMC_CHANNEL_NUM];
> +	};
>   } EccInfoTable_t;
>   
>   // These defines are used with the following messages:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 38af648cb857..9cdfeea58085 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -82,6 +82,12 @@
>    */
>   #define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
>   
> +/*
> + * SMU support mca_ceumc_addr in ECCTABLE since version 68.55.0,
> + * use this to check mca_ceumc_addr record whether support
> + */
> +#define SUPPORT_ECCTABLE_V2_SMU_VERSION 0x00443700
> +
>   /*
>    * SMU support BAD CHENNEL info MSG since version 68.51.00,
>    * use this to check ECCTALE feature whether support
> @@ -1802,7 +1808,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v1_3);
>   }
>   
> -static int aldebaran_check_ecc_table_support(struct smu_context *smu)
> +static int aldebaran_check_ecc_table_support(struct smu_context *smu,
> +		int *ecctable_version)
>   {
>   	uint32_t if_version = 0xff, smu_version = 0xff;
>   	int ret = 0;
> @@ -1815,6 +1822,11 @@ static int aldebaran_check_ecc_table_support(struct smu_context *smu)
>   
>   	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
>   		ret = -EOPNOTSUPP;
> +	else if (smu_version >= SUPPORT_ECCTABLE_SMU_VERSION &&
> +			smu_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
> +		*ecctable_version = 1;
> +	else
> +		*ecctable_version = 2;
>   
>   	return ret;
>   }
> @@ -1826,9 +1838,10 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>   	EccInfoTable_t *ecc_table = NULL;
>   	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
>   	int i, ret = 0;
> +	int table_version = 0;
>   	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
>   
> -	ret = aldebaran_check_ecc_table_support(smu);
> +	ret = aldebaran_check_ecc_table_support(smu, &table_version);
>   	if (ret)
>   		return ret;
>   
> @@ -1844,16 +1857,32 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>   
>   	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
>   
> -	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> -		ecc_info_per_channel = &(eccinfo->ecc[i]);
> -		ecc_info_per_channel->ce_count_lo_chip =
> -			ecc_table->EccInfo[i].ce_count_lo_chip;
> -		ecc_info_per_channel->ce_count_hi_chip =
> -			ecc_table->EccInfo[i].ce_count_hi_chip;
> -		ecc_info_per_channel->mca_umc_status =
> -			ecc_table->EccInfo[i].mca_umc_status;
> -		ecc_info_per_channel->mca_umc_addr =
> -			ecc_table->EccInfo[i].mca_umc_addr;
> +	if (table_version == 1) {
> +		for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> +			ecc_info_per_channel = &(eccinfo->ecc[i]);
> +			ecc_info_per_channel->ce_count_lo_chip =
> +				ecc_table->EccInfo[i].ce_count_lo_chip;
> +			ecc_info_per_channel->ce_count_hi_chip =
> +				ecc_table->EccInfo[i].ce_count_hi_chip;
> +			ecc_info_per_channel->mca_umc_status =
> +				ecc_table->EccInfo[i].mca_umc_status;
> +			ecc_info_per_channel->mca_umc_addr =
> +				ecc_table->EccInfo[i].mca_umc_addr;
> +		}
> +	} else if (table_version == 2) {
> +		for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> +			ecc_info_per_channel = &(eccinfo->ecc[i]);
> +			ecc_info_per_channel->ce_count_lo_chip =
> +				ecc_table->EccInfo_V2[i].ce_count_lo_chip;
> +			ecc_info_per_channel->ce_count_hi_chip =
> +				ecc_table->EccInfo_V2[i].ce_count_hi_chip;
> +			ecc_info_per_channel->mca_umc_status =
> +				ecc_table->EccInfo_V2[i].mca_umc_status;
> +			ecc_info_per_channel->mca_umc_addr =
> +				ecc_table->EccInfo_V2[i].mca_umc_addr;
> +			ecc_info_per_channel->mca_ceumc_addr =
> +				ecc_table->EccInfo_V2[i].mca_ceumc_addr;
> +		}
>   	}
>   
>   	return ret;
> 
