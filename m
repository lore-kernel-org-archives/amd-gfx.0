Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C1FCA5534
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 09:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5CE10E493;
	Wed, 13 Sep 2023 09:55:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DFB10E493
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 09:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTPjqMfLdWpQ2jlmLONn1MWQ0NXQCbgGtO+f+BCFSCeZZNyvEbDbugKhwsXb99j9y9W8RSUhD28LdMOa2l+cH4u+1x3tSJYBJ62iHKdRZdAU0ADm2RV/CbwXkmRgcM1y6KlNgIQymq53hNDgf7gLowbVVobqf7mDPxEz9zpvsspHNd44s/vQ3NuC3kIyihOhy0ZH+IFX4HrIHYNOyrSGmA0xvFFNRKoACrh+ez+fvoDs7GOlQ7REbzwQzBD0iGeRsKI1J8xiRhfpYvP5+Hx1NIK0pCfxU3xm/IchAM9O15afvmHIzezpjEJ4gLi1Sv3OAgo3QN+VVlnJwdAXVJXPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dlrug5dNfrME4JJyL2cbgVe+QwHxApn5Cvl0ROMht+Y=;
 b=ZJK9oF4YSL/YwObFcPG1zThe2fzCjFmrj0dWZowXKBi1oB8iR6Y7bSiPRCxw5XoC79c9KI0hyCdBSgZt57zkDaA9uAngF5mPangOjkLpA//358KJWojz+4h15I67/LdUc8njN3IidfQDn+qqvBMb3/wTXYlnmaW/iwWbOcdLrC7LDe+l2oFIHgNQloe2GG/gsb6Mp0Aq/jWITmXdADcfKIIrmeUIkKZdL2hr+IPOOZgr9H3QMB2EhN6kIXRE0CWGxhXTFCA7E/CoTeTdS4if7mF0C4o3zQzg4p0nf+M26y3xovkBWdu5PXFGkHCwAp4xaty+FtrKMI9eW9iKeBWLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlrug5dNfrME4JJyL2cbgVe+QwHxApn5Cvl0ROMht+Y=;
 b=lK3vu1FXRHn+AdmFSJRGv4l4M+oxsIrMmfz8Puv5qTib2jKgLs0Gj9064zSLYBmpktgikFoDDXgtP7jOhgQDaazbUjLCg+o5KAAcEfUIRTq7J72epY/DiCrxvHfFkBUvVwoco7aEIJnBLT3GdvvDErHl2FsMtJPysbl9ceMo/q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.40; Wed, 13 Sep
 2023 09:55:07 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 09:55:07 +0000
Date: Wed, 13 Sep 2023 17:54:57 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add VPE IP discovery info to HW IP info query
Message-ID: <ZQGG8cTDuExnD/Q5@lang-desktop>
References: <20230912212843.2807760-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912212843.2807760-1-alexander.deucher@amd.com>
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: b96f4d9b-0dcc-406c-848b-08dbb43f8278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jszQu/Cm+o9JtKeyprf/1bJxrndWApd0nzi7kV1nE5MKxjQST6WujIq1LUWb7jW8Q8sBqHLcK7pl6b8pjXRlxDlBZK2me+05OfmJ8Rvcm0V67FSS7JtZfmNN9iQTSbQfVnKsofHPPhk8YUPFMsJbWz/4w896ple110trPFOBzrbUqVo5rRB4muia5C8JqdE2PPyLB9YveubD/B9NMNVHdEVgM7+zhi+r8BU3JqWxXEzAC7xijK9GJyQYg1V5cCGzytBNZnh19ekHgP8P+ATNfi+SvFez1LjTEicZB7kNPvyaEBKAT131Qu5+gxvF0PMo7dNicvt2p/kmzk2LrGbBsm4U8EdBegaoN+zDtcxMQ/TT+gsRSmKiVkrZS6+BeG4EqfBQpuq9plG3I5YaJhOkAcw5eb/sGP7sQXD+vB4Zl4BTImfilABRCumYptzA83yjtdzgPIUNQKrBJSpk1/Vyyxu0CZTXdTuC+jdM7VGsiIeF9pd42E7JP022X9sOZ6tEBfOUnH0n+VUsTVDS1eE3xJSIxbOnK6RYx0lNGY/0fgLItqWJLL3wEzu1kXtlWUe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(39860400002)(346002)(396003)(376002)(366004)(136003)(1800799009)(451199024)(186009)(2906002)(4744005)(33716001)(86362001)(38100700002)(26005)(4326008)(6862004)(8676002)(8936002)(6666004)(6506007)(6486002)(41300700001)(66946007)(66556008)(66476007)(9686003)(6512007)(316002)(6636002)(83380400001)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5nY0RnbB1Ae7J/zvyzURqR/UsxyrvjtDOkldXD/8UPaC4ZUHjzXHJxLRbUce?=
 =?us-ascii?Q?Fhkjikg5cI2X4B1IN/c2sbgPD8b8kHtQiaR4X2U2MnckbF6GnNypCN6KDGjc?=
 =?us-ascii?Q?EVVeX/ax1uPlFYRFE02vDuxJhvfl80pIWnqIa5iXO0U2Sz9X43PSa/JpDTDj?=
 =?us-ascii?Q?Q3swPWkQJiho2o8GPSSyUjZ+2MlbZvl5CbPKO/+I4gMfTk5KswuaZ+Fwck8i?=
 =?us-ascii?Q?SzDM9hdcyfDQuWiCwENncNeYLxZ0THFiRiUDCTkwxbg0QNIYGF9cG89Aanq+?=
 =?us-ascii?Q?Iq3daGeUZdw9PBvqTpkMjSLRw9/U80IlXHcSfx5GWPaCZK2Qt/cI+95S+wKt?=
 =?us-ascii?Q?rENgn0CpbMbtor0Db0/nIxt7TFgDVCk+7pNNa/9KKUX6YzyEzH1Oc6Z0LtMZ?=
 =?us-ascii?Q?KFvEcHwkl81RaWpFA7O2CTCfFBZIDE2urNyc3zOiyJsNEZu9VGYPgJ7nZrSs?=
 =?us-ascii?Q?nLHAXR3v17eukJt/kFOUF0cQeOazzB72L3RdIRN3GPOXqfGY36KfdstzBsfD?=
 =?us-ascii?Q?Uo0ue7f8MC6HeQ3Xsl1p5pDbvlXe2OV+Vn5CK8ZylB6G8TkNNy8wrcBBSy8i?=
 =?us-ascii?Q?aOJG60F5ARcM9/YzIbNspqAUCUII6k6vGssT+nIBELmyQVoGmkk7KtdZWPhl?=
 =?us-ascii?Q?uechfYjkPvEVPdAYGHi9LWmJ1Vr+iqyINqTQkJd3y5dpdfXjPYvsJ/fqdtuG?=
 =?us-ascii?Q?0x43UOPo/5ZITrhInKjtiOu3C3+DpHFTeBeClCD689m6GBpN3GGV8klbWz2r?=
 =?us-ascii?Q?fyEyzYT81RN2S5MZN2+8QDka3MbBFdfXRWn8atgIHJLNDwfckkK01WNDjhpg?=
 =?us-ascii?Q?Y4g9LBocO7grKGHX4t+f8GDnj+fCvYn7keDhAOXeRfWJPSMNY1xXCgOlMHOc?=
 =?us-ascii?Q?FXO5bes/3T0/uEQRIRh68pKrq23G/WlqsPhJ7y4BODGnQ5kqauC46GqgfBkg?=
 =?us-ascii?Q?pLZxbDYXLMdfY+FsLTGHZozyc8K7uAOJAXYPHTEkwbFtuIJdvPmNcjs3wb/O?=
 =?us-ascii?Q?J4XJgNbHjaV8bOs1ywSZMsTmMsu53CfCQf3N7GQh6BG/sM5aVsiAwO6JHQr+?=
 =?us-ascii?Q?vcmNb4u6uhHxFooCFWpudiyJSsAY7RibNBvsAdBfeuR0ClCGHg7/R+HqzaiW?=
 =?us-ascii?Q?A7QD1eCA1nG0VGhi9HxPgeKAPVgVU51N0ZY6z5kJb+NMnl4HSsjZHjjscJau?=
 =?us-ascii?Q?wdkAOWcsUeT9OVSa/B6Z8BTq+ojC8RoSDBV0MC75aFVVi1w3cIdUB7r7MqGu?=
 =?us-ascii?Q?BrhONFTKhkwUrXwfDhcUdBcTJPWOxLO2TIKw5QSRDm+BUtZ4Lt4OXu1i9E1r?=
 =?us-ascii?Q?spM442BmwpYD+CeleaIRAXB6ho18UWz3wSEpXvYieOZGHAeeS2gM5aJRxnl1?=
 =?us-ascii?Q?ZWWhur0mgg4t0KZmBkIyJH3CjaFIcDwPPtA0uVIF8u7mXfrrtu4dmz4jyzaA?=
 =?us-ascii?Q?nvdddttIpKktbA3NYCJD+gpzIITwyttu8TkPqgjR/lNvF56l6YTB6oipIPeU?=
 =?us-ascii?Q?nR8y5ZqpRB3OJ0zNm2Mzo7bmJ/RwUEUYrJyxTJspqjP9z+3GhHPE+LRDoz5Y?=
 =?us-ascii?Q?6pxcS+DvEpYVc5Gh6kWsnSNuComnSOr9kPT3BpG8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f4d9b-0dcc-406c-848b-08dbb43f8278
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:55:06.9265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPgU5JbOQTJu+agogRFtpQiDNHQzU0jyUbxN6JbG3fRn0cgM5M3Yk7BiB093pOasrE+J1Yr/rB+9ortoNmnMxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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

On 09/12/ , Alex Deucher wrote:
> Add missing IP discovery info.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lang Yu <lang.yu@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a74ea53899f6..512eb3d8eaf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -514,6 +514,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  		case AMD_IP_BLOCK_TYPE_VCE:
>  			result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
>  			break;
> +		case AMD_IP_BLOCK_TYPE_VPE:
> +			result->ip_discovery_version = adev->ip_versions[VPE_HWIP][0];
> +			break;
>  		default:
>  			result->ip_discovery_version = 0;
>  			break;
> -- 
> 2.41.0
> 
