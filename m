Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD97CA0ECA
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 11:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9097710E3EF;
	Tue, 12 Sep 2023 11:04:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1461810E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 11:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjxGUzsBBbeKIaWKhGJKODuL2nO+GgHsRA+VNMqXhRZBNwZWIEtYVkBl37peXhbmx5xiX1kzElm66QGkYIgLZKzpqaGA1KryncKVRyPjkx6MAJpgJ86ICc1+Ij3h7Xw3QY5j8Ak3ftHXZ97Gz3wBX+39YoaBRkF1BDR8oFByOn4YRbnmldTMSr9qleL4pCstOHMd1EVJbNY97BHzPuJ7LZdL+biqyVJBuqpjDzeaX3266O7jvSImD/XYFjlshsHLT7oJbrnnzKfogoTBZcFGhbsG6L3giMejSPtKqtn5PV0iT3kdwfOgMTt9arFpQbSR3WwIfefPcUsNXgre2wXcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpBTF+r0tFa2r+d0r/VtJ7BsYkVOEYmLARi0HkfvlQ0=;
 b=hQtv8N5BZvhsnHIK0/xw5o4lEmQfAHzwktccQlgMpo29lbFExgwksmobKJPBcXQbrOIM9nmDIyafGLdWBBX0XaXnhT7lr0QtXKFWjpw2aaoT/KDjsP0v3YlKnJJ/IcAi1lOYCrVSgP8VJnSx0Y8UqxJo9dfa0PF+Cz5DpYI/THnAHd0nVs+GntI0vdfTmlaNCJJtZKzw4iCl66pgUNzaIDwyPCy7UtFFZ8Njxe/GZjpVlnilJuSgvf6cn5N3i5N7e646erbsTzOGbY2Zy3AfbQhLRSuDYUPYtwhLuvZgOPCUoI/vfDMn9EL3ppmNP3MXTfBetkEKMjTC29VcyyrFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpBTF+r0tFa2r+d0r/VtJ7BsYkVOEYmLARi0HkfvlQ0=;
 b=FS8eCyYeOxu2xnQimASvyHEcqo5U+vshWKgKfW2iouzLEwHQmmGy+DIQUhZJ+0fwoYBgtFaGmZYb/A53tJzyYOERFzDeRyDotjPbUSWpyQn0KfJQ1ykFanTEFc9ptTaThfMBGbyM1YkMx+fxGiQ0eBHnj3HQn9mvsEzIwQp2O8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 11:04:14 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 11:04:14 +0000
Date: Tue, 12 Sep 2023 19:04:05 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add remap_hdp_registers callback for
 nbio 7.11
Message-ID: <ZQBFpc6SHa5cPiRF@lang-desktop>
References: <20230911214659.1074052-1-alexander.deucher@amd.com>
 <20230911214659.1074052-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911214659.1074052-2-alexander.deucher@amd.com>
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e655fcb-7ce2-436d-b7a1-08dbb37fff9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bUE72Xv2ILtFHjv1oHh7KO1FawZiPz8gpDiX2IC4T5cvSCPPuTfevWqr/x8mhpHUYIrkGCM3aaDY9C/qht0mK27km6UxCdDVknnfPnOeuSX405icQJuIF2cIufqLOlsre8Vu+a8g9uCbe2JzQbss/93d8JGT4Vu02/mrqry6MRcVIGUCI0rXmygqJTGS0CV6oSDV8WndnSvnPHiVnRzxi0/zVvEx3MgpIZXToIdIEHKAP20uu2f5xfNQIpVWBCekJJd4014NkOEl21wqVJyF3O511/qbsuajE6QraWQcdJwcfSXd9Y75/DtsEi5rvOtzZ8Ub9JAgfJAU0kK+OM1U7fEgYaq+lQTIItQRq8FhlIKA9zP1ZYdKpR4UednvGQd/Y7YwhgyKI63ItUzBr6XSjkBD37aNCeM5RS3J7F6eejFkr5HMvBMMhNqj33j5tJHOU5pehjJRorq6D4ttoidbqrXIbZpRqndIEleS0ajmyHIUmYDK+TShssrgVAEZ26m5eotIA5xjxzAS6j5fBQ0fqPO+RAMAPusVzsDIF0I75uKO/IqYh9Tzg3kX92AZfhF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(33716001)(66556008)(66476007)(2906002)(38100700002)(86362001)(5660300002)(6862004)(478600001)(8676002)(4326008)(41300700001)(8936002)(26005)(9686003)(6512007)(6636002)(6486002)(6506007)(316002)(6666004)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TK2aM6FYODA/5XAOL6uNODod/o+CqckwmpyB+ScrLBMK7TcuJPX4NUK9DUlr?=
 =?us-ascii?Q?qoXEk9cY5kueuwD/zujT2CxbWceLrYJJUyIOVPZJC2PgVZTCOWZHY7MDOlPb?=
 =?us-ascii?Q?Kzbb626oWHetj1JlC8kRIJT5wxuFF7Jz4IGMjnxqy1LK8DaW6Q7b5oEmzTE9?=
 =?us-ascii?Q?ifYvV09axI2o/GXtlhFzWiasQuV3aI3nfnNFHLp0u23ggUFbCZPP1FYxVwMi?=
 =?us-ascii?Q?Q6zwyV8Ur4AENOD3Uww6VmEJErDH3mf7gugFTdzoD2aWHgFpsonzwUxf8t+q?=
 =?us-ascii?Q?HBk+Z459N7FNiulE8Et4lSnFYa5yqk90iHXaI9ek5OfyBEzeItH9VE7eC1PJ?=
 =?us-ascii?Q?LnwQHwxp2v/POz5GcTiqigS/teL8QH7Gt7u60dNh+haAkyh7hCoAxzaAKbMy?=
 =?us-ascii?Q?3F4cYALCTdmshDzxq7vYKr08KMojM/iSUiY3jd+gG6D+tqmlRkdhjD5usCil?=
 =?us-ascii?Q?TPStQYAXYTBfKtfhS++b1gfVplPGcBwgJytowj1XwNxy/glMQRfU2ZKqQIcB?=
 =?us-ascii?Q?Fab2sw3D4DcituyHKRT92DbjnNZVikxObTdR9qRGJWnLSa/Z8e2P+hiT/RHo?=
 =?us-ascii?Q?vf2xdveWxo0ZrdDYYeEz8n3u0viIfbAiWcW22PsDfalclc67eUTAgvg69yOr?=
 =?us-ascii?Q?8TmtpaUMlrINCO46xtDugcQAY/+Hkc9usPLUakNyHkHaZ9qMC+otMZq0f4Z1?=
 =?us-ascii?Q?tT6BJczIJ0+Edmp19gxXhO6G5U/m3LxZ/MdoDQYKGS+qkgCQQtBiSNvk4aLj?=
 =?us-ascii?Q?daTTJRXNukKc/UvHmAT8s+5Bdnl7oWyws3FsW7LdOpqx4fxoc0p/E3y2BxE4?=
 =?us-ascii?Q?K+U3GTDtWITjirx9fW4IAdp/BBt78pSlUU36oOW2FoE4+2xy2kHoNeJJHRmM?=
 =?us-ascii?Q?C9+J33cxCmHuO4e5P1XB8H2VQywWGGIuLdR3zSTBDLc96DumIFCdY54x3zjf?=
 =?us-ascii?Q?KmB/aaV8WmMk0wVnvDBaQUtqoJjjyUzsa7AGfrrCdxTNY/EdNteaoOxXVeLC?=
 =?us-ascii?Q?BZ38pe7yUlRnAUGK6ZP/K/wXR/XwHe4mBwhL1O/CIjWmzpj6ODG1r/bCQU+d?=
 =?us-ascii?Q?PEHiWOgtww/nRjq6gHn7EG3Zu1be0Jfa4TNc5NH7ZdVHjGNB6Qtn1yOL4fQK?=
 =?us-ascii?Q?Lw/zNGVitf47a6igir8D8zB6ls9TGPoDcuZ6HEXBt7JiTWmDExmbAhuLIeTw?=
 =?us-ascii?Q?uO2c9aYMytDOkbLuwT0f+ZUEaO0nASlUMkwctUZmRWy+CS1Ja1hTsLWqjTQX?=
 =?us-ascii?Q?fmI14PSW2VsfrQjTCDoTJ7MgKYEHFSjdxHcI+Tc/er2wo3KNNy38TxbWEPby?=
 =?us-ascii?Q?Uqgvil3C1SsRpUpausHslqC/ooBpGCXtShPbmloIexziOcjpgn3PVIbtymHW?=
 =?us-ascii?Q?BWHZkkxPHtc8Qx0/68YVtcah5MW+9zMxm7i+DGGXtXLkVNZPPEsuBBawxN1a?=
 =?us-ascii?Q?3KYPUf3CfXlyLsdgLLnpPw6ZI8N3iAC5vbMaQVVKfHRG+qGxmIvMy5MKBol7?=
 =?us-ascii?Q?jXQ2gCvlilWnjmHM/BCEaOw0H3T+iBGMiWPCdAffGGcmNkVaO+PdhmuJIJ33?=
 =?us-ascii?Q?1TJM+ljtgH5X4VoaRwGQt3tLvfM4WgxBRVM3JAtH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e655fcb-7ce2-436d-b7a1-08dbb37fff9d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 11:04:13.9208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgqnLmBRGvxwYqOgmQ7rKDO25q6BES7l5ScemdYyyKvZd15P6rfWZyIUYUOfMJsyYAIKm2ofDO49aV8pSipl7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/11/ , Alex Deucher wrote:
> Implement support for remapping the HDP aperture registers for
> NBIO 7.11.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The series is.

Reviewed-by: Lang Yu <lang.yu@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> index bcf5fb420fda..6873eead1e19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> @@ -28,6 +28,14 @@
>  #include "nbio/nbio_7_11_0_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
>  
> +static void nbio_v7_11_remap_hdp_registers(struct amdgpu_device *adev)
> +{
> +	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> +		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> +	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
> +		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> +}
> +
>  static u32 nbio_v7_11_get_rev_id(struct amdgpu_device *adev)
>  {
>  	u32 tmp;
> @@ -284,4 +292,5 @@ const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
>  	.ih_doorbell_range = nbio_v7_11_ih_doorbell_range,
>  	.ih_control = nbio_v7_11_ih_control,
>  	.init_registers = nbio_v7_11_init_registers,
> +	.remap_hdp_registers = nbio_v7_11_remap_hdp_registers,
>  };
> -- 
> 2.41.0
> 
