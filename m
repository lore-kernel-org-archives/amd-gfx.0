Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C369C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E49D611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E49D611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A946E8B3;
	Wed, 14 Apr 2021 06:34:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8495D6E8B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 06:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4CYLwvtbROF8nPHkQX1IoFW+0lqo3exdwd6ZU2zTkO6URJCmtkU2cTP71nREQtSg+w78Dhc7mPxF1rjSvSEcOYaMcFCypoeCjdQ8ZN3rVmJsS/bk95XXeQrkD+LU9Coqn5TrrxG9fn/DxxTp6MidZc9NVmnChOBKqCOtaYKdGlmezaVBQZLm2sBTmkbPgwU6hl9peaXsvSktc5Y+TPd7/o8fHqiQ2+ZF8FgWsgkJDtHfhYFaJikbH5hrXLTdmm2ZnZatyf0S70D6DTeOY9ux7ZI2OjkCnnG9bLh7kxKLQ0okw06oAZwzr9EGH+nH1QaBkQf0I5owy1+T0X5tBdQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NvshQQ28KL4LHISvGNWK1o8zoQM/Dti846rphSiBc8=;
 b=X8qffsIvHacqpRuvzkmGcKGJ1YNE2iP18FL9GjSIDbHHUEqXFVNkZYUK5gFc6u1DOhkfudCISMRiWU9wVMSqi1M+JaQJa44jzuvx4R/pBUs8LtW9r9f8H1ZlmjOkz8QX/Y5UsOONJDT/MrlKoqXWuoJre0zSJ4iFn6gO/7dMDVOjI5Y6SDe8h7wGu0i1H7M8ZGEq9GnmJt41VJbsaXR2vH1tYwFgzekh5wDn7qbSSf8PqXnYanEFky79pTQhr24HGN3pApXEv+E9O2mx21RspgZCgMgyFJPg7i17ji40zGTX4AKUR6DBiHxx1hSbUy9WtKodAG6BKs4oMXcG1lOwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NvshQQ28KL4LHISvGNWK1o8zoQM/Dti846rphSiBc8=;
 b=mOKVO8fM3fXyiWcvQDc9dl9qL91E2d/txoAXs/AhF4zHhJ/yKV0AAETC1qPK+9myYGb23nd10ZbTV29sYqPBeZV/EJHmF1KjyvGG/nPGnx7Nu4SNYONGb9cojTihkJIzLc+9vacwCwEMgL2YEPP+ehXcku8wQIg2YAf0/mlxAtQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB2494.namprd12.prod.outlook.com (2603:10b6:300:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 06:34:55 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 06:34:55 +0000
Date: Wed, 14 Apr 2021 14:34:36 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amd/pm: remove the "set" function of pp_dpm_mclk for
 vangogh
Message-ID: <20210414063436.GB873493@hr-amd>
References: <20210414062010.3251391-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210414062010.3251391-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0178.apcprd02.prod.outlook.com (2603:1096:201:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 06:34:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d08d2e3c-680e-46ce-9f3d-08d8ff0f6a91
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2494914AA3044E6A3E4B0549EC4E9@MWHPR1201MB2494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0JAjWbj2TSlmKtFJbddb1ybpDaZ3097JLmk76ISS6EBT53ckr9/XrQrpmirlsgVXm5UzdXQWqaxYg87R2uP09j5WwpUAha9EWSUueeLzQJh1a/j5I3OcWFaJ87rVp4m2may6PhRH3ns4p6S09agZGCFynWaO6+IP/gdXH8gl4gWtk8ck6r9YwDleH3o45Htz6JeArBJXyz7ytq6nUOgRbh/Y2kkuwQAHv8XOFYy8lDdR089GLMA8X4DQvwNKHM9/Arv91haDND7EB5AbftQcm4F7yZzYfLhxmzSDVKAk1cdzS99ZAln+BYbTTo97zdvLqJOJUByaaISoyZY+hlzIInBHRn7e7D+E4nZMzQfms4+B93D4Rtx8NbWCy13OD3XiqWMtkKVBfS2p2FjcdfbU0PY+7BfzaXYff0jPWAVkQ4OijP8xRPY1llVSexRrMvY3+d30hSUoGwp8fxUHZcz5Ve+vqwQOFgYeKCUCGo5mxo6YItGPktBQZjwVKOIn/2NM6c4+/Rlcw9srshIvkJrAHYT7qNYiGuSWmKMBhNLTBw9HEmoSoqUiFeWAQIW8PyUu/VsfOG05AVSm2LWNeOEuHPOLthsoEbOCZsITPa81uTePtl3DrLPcf8blK3IECk0BXk3/zJdLI1TMaGV9kPpRGfERay66pKhv7HeVJLf9uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(9686003)(6636002)(26005)(2906002)(54906003)(6862004)(6496006)(33656002)(316002)(66556008)(38350700002)(5660300002)(16526019)(956004)(66476007)(86362001)(8676002)(8936002)(478600001)(55016002)(186003)(66946007)(52116002)(33716001)(4326008)(83380400001)(38100700002)(1076003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fYCuoo1RyQRE2WW6mtGvBOpuZHlGulCvLwq0zLFkcPX0vw56/3a730cgKIW2?=
 =?us-ascii?Q?HuxXxlC063AgViqyON7nVSw/qblf3e86/ur3Umvb7L9KQgZpc+KHdaWMhhXN?=
 =?us-ascii?Q?F8SzTSjy4wB37UVRTxnqN/Sxmn31HIc4lPNm7A7iQwQ3/oqNfO6FK+YsgLbo?=
 =?us-ascii?Q?Nvlrgfjy1R/V03cCMgsurJncJOP0sAuQ10wXaUziVAYcSZtNP5ZM1nKu7rmY?=
 =?us-ascii?Q?UpjoiHsVaV1lztXBZ1mDTCmCpiFcTUUHWC0SON1c3BIuHORXpanuVKsdn8FN?=
 =?us-ascii?Q?PNxF8yIepsI4BmY9FDe5X/pj1QL0pATak0Oy0giu4xes2ImGMt4oEuODesYB?=
 =?us-ascii?Q?1owiPCSWrqGoH9U8TulJqnubeqcQnOgtRCnDfm6dlVKTf7nXF+9B0zYavXdC?=
 =?us-ascii?Q?drNwCFiJXJQdn5lBKYPntVUc68AMIf0X7N5fP0Qlt9viNAr17P6Cl2D4zP6z?=
 =?us-ascii?Q?mxk4+5yYtGqijU4buXn7hxgm0Gppj7Cis1AIgoWHN19hJhTfyxK1OJZ9SqoN?=
 =?us-ascii?Q?yZguU2xkDJeihyaEVxFtcRgFe27nPfjyt2kC0TUDn1527mxmXBf71mJalMX6?=
 =?us-ascii?Q?382oAySST+J/+/SQw5PTjUpQrBGNq66jh9oCKfwIN+EgM5GtE6eRw5/PLHRP?=
 =?us-ascii?Q?ecOnfuPzzebPSWQ9pSSnDBNCDeI7UPah9viGvURTq9VtMxdHXgocFRpvq18Y?=
 =?us-ascii?Q?nxUmLM/YngOWmUwlC9rydvqzBGJk6D/OYi6HxgKdDsmepJ85/tzu63c2JnSi?=
 =?us-ascii?Q?mjvdnGczTGhDDxomS+QGCDbYhddpXgjvv0AljbolzOE8S65tVXLO7F0+B0DT?=
 =?us-ascii?Q?TGbTmizsLgqhpUlsOVkufXfVEvAQuvb4dKHUZUHLuBbf328hIodG0Ter9QFp?=
 =?us-ascii?Q?OMbdzO/wy0VfIlEw9QlfcLhHJvldk3IhKABBPxrAjCtF8KRBgbzkpJFuXHck?=
 =?us-ascii?Q?CeGiJhogmz7XImDOID8+/MmEsekHjr8/5648NkrvF1/XCnE02A6k4PS6WTYK?=
 =?us-ascii?Q?vHEDVD6WdfrDqANj8fV2LP3WM7dPbFEgmM9wfrObKWP68qpWIsLD9jJG5KGA?=
 =?us-ascii?Q?M/rI5dhC59YhdNbtjWtEmXwE4EWzoGeHPjdnkcev3AL2qItGhjS2hea7QSgq?=
 =?us-ascii?Q?XUFVMY14u8a9NcN6uWNUmEz2yhn1KgWov6z+D7yC/aOHld6luazHgBjHicR8?=
 =?us-ascii?Q?45JhD6XyOFrsS7FgiyqzvqfwZT22EutKls6a2dIL8bvT3XJxuUDcYjqVByQK?=
 =?us-ascii?Q?4SkFvaEEL4tB7g5XE86VzcKlIC6n1joR+E4IMjDWHTvzp3gfQHoA3Zal6nyj?=
 =?us-ascii?Q?GaNXXKd8sNLVlZS9aJXYsjwc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08d2e3c-680e-46ce-9f3d-08d8ff0f6a91
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 06:34:55.1755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VHDzv/gy6MHnJlta/31IDR/lXM2aGLX8oMz03jE6lXc/6EvESGwBloeKFyxeZqu/o2boPqYk+qe+S5jeVqVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2494
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 14, 2021 at 02:20:10PM +0800, Du, Xiaojian wrote:
> This patch is to remove the "set" function of pp_dpm_mclk for vangogh.
> For vangogh, mclk bonds with fclk, they will lock each other
> on the same perfomance level. But according to the smu message from pmfw,
> only fclk is allowed to set value manually, so remove the unnecessary
> code of "set" function for mclk.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 61ff9a663b21..35904315c1f9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1092,7 +1092,6 @@ static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
>  			return ret;
>  		break;
>  	case SMU_FCLK:
> -	case SMU_MCLK:
>  		ret = smu_cmn_send_smc_msg_with_param(smu,
>  							SMU_MSG_SetHardMinFclkByFreq,
>  							min, NULL);
> @@ -1180,7 +1179,6 @@ static int vangogh_force_clk_levels(struct smu_context *smu,
>  		if (ret)
>  			return ret;
>  		break;
> -	case SMU_MCLK:
>  	case SMU_FCLK:
>  		ret = vangogh_get_dpm_clk_limited(smu,
>  							clk_type, soft_min_level, &min_freq);
> @@ -1267,7 +1265,6 @@ static int vangogh_force_dpm_limit_value(struct smu_context *smu, bool highest)
>  		SMU_SOCCLK,
>  		SMU_VCLK,
>  		SMU_DCLK,
> -		SMU_MCLK,
>  		SMU_FCLK,
>  	};
>  
> @@ -1296,7 +1293,6 @@ static int vangogh_unforce_dpm_levels(struct smu_context *smu)
>  		enum smu_clk_type clk_type;
>  		uint32_t	feature;
>  	} clk_feature_map[] = {
> -		{SMU_MCLK,   SMU_FEATURE_DPM_FCLK_BIT},
>  		{SMU_FCLK, SMU_FEATURE_DPM_FCLK_BIT},
>  		{SMU_SOCCLK, SMU_FEATURE_DPM_SOCCLK_BIT},
>  		{SMU_VCLK, SMU_FEATURE_VCN_DPM_BIT},
> @@ -1428,7 +1424,6 @@ static int vangogh_set_performance_level(struct smu_context *smu,
>  		if (ret)
>  			return ret;
>  
> -		vangogh_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
>  		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
>  		vangogh_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
>  		vangogh_force_clk_levels(smu, SMU_VCLK, 1 << vclk_mask);
> @@ -1468,7 +1463,6 @@ static int vangogh_set_performance_level(struct smu_context *smu,
>  		if (ret)
>  			return ret;
>  
> -		vangogh_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
>  		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
