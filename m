Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E40C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 09:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19E36EDEA;
	Wed,  1 Dec 2021 09:45:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEF16EC8F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 09:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEdAZrdY33C2lprLeMzMCK43dfWxkpSGx8q6L3x/Q3QrPoFVykY0aRNqQRI1sRXyCxEDFv8QvZ4reC2uqYip0F2pYQ2OSORERzWkBHUyB4Y643jJATNT5+E+6rOMrEBdavK2vCQ3WmI9JN8E96N+alvscFOtzzBzhDkO2estEXSHuN2jrlJHrf1RTqG4p4mofk56hgdaNELOCQF5BziS2uwX2DdOZiA5I/moY5LJkJMaoPE5U0f5tDbkURw/CSsPADBkPBhe7c4bEjGytDllZK4fZFK57gOFszmjzVl2a8OcwYUWoAtdHL4cGAPLn8VR0JigShqY2RREsoSBYnNoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoVcpfSaOagsYDcGcq9xkG4paZHK4CTBCdyh2++30TA=;
 b=XfFtSCYfcu0oJgHzJmSnyhNSY/cckILtlJK+pgtmgosxBMyRwrUVbVKrLhXvX4dWq1If6oc+KYiafcWZYskNK961bj0uwqZMzJKthPhjcrrESBRiUytV4fB+b0w8pkS8E0Ft0zw/MvLj6o6b0C4igpK//vYn7oCEjEYSGW4RA+7QJgmWY5EX6+C8/pRhOO45QCSEZnyGMRMnbNoyJPVltj3hqlohAK2o9qe4ajJ6d87bX6Vz98jKwC9fL568ft0R+4/bJiPF1uMZKHYGQ+Y3S4GKUVTRIyLju321CWI36ZEc9HhUxis0VRE00yjfyShG9wnqb6Mhx+nT7s0D4YR1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoVcpfSaOagsYDcGcq9xkG4paZHK4CTBCdyh2++30TA=;
 b=RVAfHV2K700iQlBxYUhBXIoT2i4aGCcSn5YPkexgBR6N0PzChJ+od4g7O2sTwQQ3baJZgOogruCqthrlpFdA4n52Vxq//exPzC5CrJAyuz5dEVloVa460YJJQnXQlndRcGqErzsOxK8JoqmC1KqLZCylYV0GXV8KlElxPhKfetI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 09:44:58 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 09:44:58 +0000
Date: Wed, 1 Dec 2021 17:44:34 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
Message-ID: <YadEAtHibk5Qxo4o@amd.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201092458.3348858-1-lang.yu@amd.com>
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from amd.com (165.204.134.251) by
 SG2PR03CA0095.apcprd03.prod.outlook.com (2603:1096:4:7c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.9 via Frontend Transport; Wed, 1 Dec 2021 09:44:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c624acc7-f1d1-46fe-ae64-08d9b4af3c9e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:
X-Microsoft-Antispam-PRVS: <BYAPR12MB35278B144B8CE97D1D6BF45BEC689@BYAPR12MB3527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9URzvcdK1RP8MO6TMVLl6hF/CDO5DtLCv36Qo8qQaRXD2/l5W1jTPtT3wSNAQnl00DlmRr93SOuQi4n73WTkIZfB5W8wWVh9RroE132XaSIC3Hw6PQdwk/QsubT2BBX9tEQngdLD5rb4bzgulpxlYMuWglltl5iczN8AY1OPuZJzGszwKgkPOVE0dCe8u2VmZpjZXVPhDiu4FCxZqVsCrbeYtNdr05jOmmPJn4UTV4wKzgaU8Y3vUduDO6iLiZiHU8S/yAe4oKRoR4w7x+bpGdJFNG7C8lQB2/0TngqzID7I110PlrWSSS6HHr7otMPgLS14GT65stdzrqyIJXzBWpA9sx8E/TXeSZ2lJ6YOrWVpcCSIGhiC+iGB3uwiBxMSZ+lEi3sYIkBv3k7fQvXSPrigyQm+9XnkQfHjvLLzimyRblsVaHEpYbR+Rm7yfPZsVwMnA+hKBICR8AUrRMbsy3RNqGgdtiul9IMpZbn/dS/w2KPNNNMI6WPFBcRju4ehRZwMvEHzLW8oY9ilOISYgqboRG4bnQnVFPDuUEy54FdhW6+LI0XKy3LyT8ghk7KcEHtDT3d0wBxfqupXYCZ+68tC+SnEld8u0pEEQhK7rz1wktTOzY7ZsylZMn3sRWR4TyvvGlNd086fNopdyBVUng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4918.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6862004)(37006003)(86362001)(7696005)(2616005)(6636002)(4326008)(956004)(55016003)(6666004)(26005)(66476007)(66556008)(186003)(8936002)(5660300002)(316002)(508600001)(38100700002)(2906002)(8676002)(54906003)(83380400001)(8886007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0OckT2GZxRkW5h5+Vq5Umqa7/SNN/tRbF2N33EBVFxwQUlRy8fK4/jAA8b8?=
 =?us-ascii?Q?PBk4fnbvgnSpomaM4YD/+PVCJLk7Uiz4x65OpqIaBzBflVqvUO+PrJ0lWJqB?=
 =?us-ascii?Q?djNo+RfxrVEF/63t0fFB/2z+F7bb+6g/A4MlGeOXNXc1LiyZXe0CUpwIaivp?=
 =?us-ascii?Q?9Ldetdul7TjyXEbedlTx4zwqhoh+EO/b1L0cLb5aCQG/sUqdyAwA6b12rVhq?=
 =?us-ascii?Q?VMYLnnf2//7hWjsQ0h8zvE1lD9jOhWIlAEMei5Ev11NqDeaU5eaPjZOWAPMt?=
 =?us-ascii?Q?JkvLbmUNEGmZIL7XQuYYjdCNfpBAT/rjLeTDElA3rzSf/chbcEQgHWtG4mFG?=
 =?us-ascii?Q?nGyZLB9hUb3SLYRRGJ1DyNRc/bvgLywleWUsTmkUGwsO9IXQ5SizvolRQ08i?=
 =?us-ascii?Q?VxpkFslglSO+XgoRvdXqqg/sF1YMdjUhNJY2X1qOGxxUoDSAlR3SA24iva5v?=
 =?us-ascii?Q?JYFENPJgXo4rhMedUhl4N8OfStDCe64ZSo0cRC3FF2Lir525YWXUo9nUiF4n?=
 =?us-ascii?Q?3En81E9N+eJSsbOi1N+EEFUXh0PUG7RsbhP2vh6HJbkMOCpqdvo+5nUYPzue?=
 =?us-ascii?Q?vc8QDKRRJDJoGBzZQaUkBpe5zx7Gq1IBjRQ4z5KOxY4oyKB93DDnz0WInKDP?=
 =?us-ascii?Q?/lXUwUxbZVHM3tCmgAQlEyamcFjTQPW7s92R8z+gYHC1kA5a/AZCkIs/h6Z+?=
 =?us-ascii?Q?esmjaA2xLfTpLnNSpzaHqAoAbbdNz++yVemJRwDhpqgjOTHVAEARdoAKaScc?=
 =?us-ascii?Q?fNXbjysxhujaCvouZwd4wMSNvS6bfJolaTJyHzJcZOIGyI1cmHiA4RSsePsG?=
 =?us-ascii?Q?kc64eECQB5BnqkG63rLHmyffPXbKgLrM3D2s9jg4IbS4awytsG+yVNwJlVFE?=
 =?us-ascii?Q?dHfXKL+mD8H8Qfl1JeQXlTLtlD/mmy5IMSHqTH2dFltbxx2GsPq4CnjEHHAn?=
 =?us-ascii?Q?/KqADRJ0aLB1/z6K4jcF3nRkbuyDbUSll1s9hgzrahFNjCoq8RpyvYh+HqF9?=
 =?us-ascii?Q?tGIwIHmTwMcrCXJZz4TAjvOTjoM9jhflJiYW1WRO/glrNB3HJzUzGyLQ59Bf?=
 =?us-ascii?Q?sANQPaqRIM8yiUIzp45Qo2jlsHxuZAjQOPeoNL3t3cRXFfco23OyKUuEq2sA?=
 =?us-ascii?Q?9MFAUc2wdD9s4c5nBPyUhU2IaJkZQyEAaHFbCO/fyUei/CETzXsQphN2JHdh?=
 =?us-ascii?Q?R4mv2u04Gf9u8JljT2t/ftW+taDLgfoCby1rvxi2Lv41bfBcDzsL/e5+onny?=
 =?us-ascii?Q?VEMBg/JUMjnGcUs90c9PEPmvzcgHsP/OZ4wtIF4mMFxFw8TxZu2/km7ovWxY?=
 =?us-ascii?Q?5G0SC79AEB8lgFr6GpdMi7t1ji38bojhxNgLVAWpmnYaSd4XH0iMCC5jet28?=
 =?us-ascii?Q?yEV6KGEKX/ky/dBC+il1z5CgyHriQaRKfryN6sFYBq+LwJylv3ZVwHoVrjKR?=
 =?us-ascii?Q?EogBR/NFe/9vh1PMtcQBixFVROVe0Th+rBmTmtnjZkZWbJq+Dq6zMdK7+fAu?=
 =?us-ascii?Q?BNzp96cLYUD5CjGEPJ+FnKrvD0az4AW0bSyvVI5lRKK94p+Z5+MLpqrOKNmo?=
 =?us-ascii?Q?d7zP1jgCmSeN1HLtGFw0Bn6NB0x3SHJaSQ+LlnClON2xFXyuJItJPIXLsc3a?=
 =?us-ascii?Q?Te/anXJoZeFeVirIB930pzk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c624acc7-f1d1-46fe-ae64-08d9b4af3c9e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 09:44:58.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNmyuxQ/+jnkTUeKjVoCNB63eWJepQKESGfJlkYLUOoYjyedIaG0Cboewl2jVE9UjFNl6vMCNPKxyOLGxAwa3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 01, 2021 at 05:24:58PM +0800, Yu, Lang wrote:
> To maintain system error state when SMU errors occurred,
> which will aid in debugging SMU firmware issues, add SMU
> debug option support.
> 
> It can be enabled or disabled via amdgpu_smu_debug
> debugfs file. When enabled, it makes SMU errors fatal.
> It is disabled by default.
> 
> == Command Guide ==
> 
> 1, enable SMU debug option
> 
>  # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> 2, disable SMU debug option
> 
>  # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> v3:
>  - Use debugfs_create_bool().(Christian)
>  - Put variable into smu_context struct.
>  - Don't resend command when timeout.
> 
> v2:
>  - Resend command when timeout.(Lijo)
>  - Use debugfs file instead of module parameter.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
>  4 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..86cd888c7822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  	if (!debugfs_initialized())
>  		return 0;
>  
> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> +				  &adev->smu.smu_debug_mode);
> +
>  	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>  				  &fops_ib_preempt);
>  	if (IS_ERR(ent)) {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..50dbf5594a9d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -569,6 +569,11 @@ struct smu_context
>  	struct smu_user_dpm_profile user_dpm_profile;
>  
>  	struct stb_context stb_context;
> +	/*
> +	 * When enabled, it makes SMU errors fatal.
> +	 * (0 = disabled (default), 1 = enabled)
> +	 */
> +	bool smu_debug_mode;
>  };
>  
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6e781cee8bb6..d3797a2d6451 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
>  out:
>  	mutex_unlock(&smu->message_lock);
>  
> +	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..9be005eb4241 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -349,15 +349,21 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>  		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>  		goto Out;
>  	}
> +
>  	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>  	reg = __smu_cmn_poll_stat(smu);
>  	res = __smu_cmn_reg2errno(smu, reg);
> -	if (res != 0)
> +	if (res != 0) {
>  		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +		goto Out;
> +	}
>  	if (read_arg)
>  		smu_cmn_read_arg(smu, read_arg);
>  Out:
>  	mutex_unlock(&smu->message_lock);
> +
> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);
> +

Do we need to add BUG_ON on smu_cmn_send_msg_without_waiting() as well?

Thanks,
Ray

>  	return res;
>  }
>  
> -- 
> 2.25.1
> 
