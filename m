Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC6CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 02:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C5F2245C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 02:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C5F2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374136E045;
	Wed, 20 Jan 2021 02:06:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4458C6E045
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 02:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3UzK+fpT+Nz3Kzph3a53TICvERaSThOrbbUYnxpflWajGy3niAaScu1iyh1rYtpOcT7u5+rFaTWoaVbd0H6RKhBgA4RcD41gFXwZUrloiRs4LXqJm2jeyeGhWdPLAyLOJHDdL0L3ZBh6hTxCVUxvY84ymjiutZ+zO3f5fijtNTlGoCHFEUw/ek5sXITV7YCwhOQrP8+gTqYOaH4NLZ+8AMnJpBmtOSGMJYLHLnIcrgtlx6S/EGtoxsxW3NpuZ+ab7+mNmYfPy1AlVa+X0nPqnivtMPCjXihtpysMNQnKWlBGfd4+240cm7oNfG43QO7pWQMBRHQNuVTazk3GgMEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fi7lgeKsrqtARYZXILnb6zfaqfB6mSyeUYnqr5isew=;
 b=cby5JI2goGEbrHjmKTRtUAmwg8wHWOKNMk3tHLjsL+FHjnufEVkyCQxghvIE+IVijmqKHVvxr7WuZ6WHSNFkrvaD03C6XeJZIy6h693yskaGD2il9Wt1WQ81dKKCh9XNmXvF70sMcfRF1h8mj5dWCnDHyMdfB8KIr5QIulnsTU2luZZFEkGZYYmzf0fUGPzhDEZKfMgJDowWfK4qznvFkecLSQMHHyPl9XFFy1g40mR/mkmwSxwqIn9VBVwQnmXw1XQvKeP6sLbOcn3AGk6sJszJB9firxnMrBGrGoBcLnllDhbFBpObflmc1YFVuTmSj+yGGPKCMBtNOh0HZOP1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fi7lgeKsrqtARYZXILnb6zfaqfB6mSyeUYnqr5isew=;
 b=35yoswM3Cg3zrnPXe4kigbJImfo4i/bpG5A0s4wXHHX8M2w8llM+QiyXw884APmH4npOTN9PX8zwpK8xi77PYhXF+erNF7o9G36nMRATnYnxMA+G/gh1nWs3JADHkvPKgp5V+5sm2ginb+k25zBqiYqfWLeQBbYYYaojY6NI5/4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 02:06:29 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 02:06:29 +0000
Date: Wed, 20 Jan 2021 10:06:19 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3
Message-ID: <20210120020619.GA610615@hr-amd>
References: <20210120015732.3986339-1-aaron.liu@amd.com>
Content-Disposition: inline
In-Reply-To: <20210120015732.3986339-1-aaron.liu@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR02CA0167.apcprd02.prod.outlook.com (2603:1096:201:1f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Wed, 20 Jan 2021 02:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8d32f92-2e6e-4f50-f1b1-08d8bce7ff8c
X-MS-TrafficTypeDiagnostic: MW3PR12MB4521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4521C4D3E6B199678F6911CAECA20@MW3PR12MB4521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piucxYZ2yPZgsb4ADAXnCxeIdVkdJt2u72QaD61q/PZrm/coe4gu/mew7H+BoUdRmE/G0jo6oFOYTuefk2i6HIUOmAphwC2xIlFgdf0fuOSf9vdGesdcSVpRwZeewgNnBEUlr4Bcsf3+L34iPmiZaq8wBZw3FyxbSnzQ/8N81f4GDL2c5CewiwiL8RYz7i2HYZVxTVOtlJxX445603IW8YPEFb21oLs8+b3mQIg53gm4FPEMDwMYWmndnCCXiMJi5v2agI/8KEP5D+BOmX+hPeQbm1ilVb5L6GYESZJCcVnGfMPtcI/juWU09aZOL3kcBqicOYEKa5X2d5o4sEgpf0YMuI+lCgIgww4yBIp4/grQrQ81Wh/87azCaEZ1vTXC31iUZJJFGal4GI0fiYgpnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(83380400001)(186003)(316002)(5660300002)(52116002)(26005)(16526019)(9686003)(956004)(66556008)(478600001)(86362001)(2906002)(6496006)(66946007)(33716001)(6666004)(4326008)(8676002)(6862004)(54906003)(66476007)(6636002)(33656002)(55016002)(15650500001)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WGgr3YOqfVghPozXMQZoQkdXuxkPpWzq0c/guzu+tMPwCLflT2cPghfZNiA0?=
 =?us-ascii?Q?8zYI0QJ2/mPD1M2cYUqe9HESLjxEqrrFbqOsOv/+Py7y+h4mWCCizpBmTHVi?=
 =?us-ascii?Q?+x3ledBXBZnRqBOjVkt5lf8rrxlvIX+jSjT2L1jc4F/7XQHEln6B7i4uy0mB?=
 =?us-ascii?Q?UQ3XYJA34Tfne7Ip8MQ/fh5r7YKcx+ix/T8mcPdBpZklk1TBMaHixUdr8DLn?=
 =?us-ascii?Q?VENW6pO6F8ogJW/5PXHtw8JD8yS30B/AIyrTqfax/NQ92a07h1C/xbWPVB3u?=
 =?us-ascii?Q?Zg6nlTZFMdPrW9GjU774NtzZ4tnkszMhHRWT2t6QxIjLL5pmFLRYtZMPPQeR?=
 =?us-ascii?Q?yNfjwewTwOs0j34XIq1rICwHuXb2ezxISy3t6vWIRB/IWKsmrPyhTiq9BZgC?=
 =?us-ascii?Q?gt8OOmRgtQ+TW7yNsZueWsbFUqwEcrWFu8sTkhlJPN4+4R6oIq+oT2ab7krV?=
 =?us-ascii?Q?CfDZ56DV/LCDBsPDN01cKIauscE5+TnQ6HvjJ1XogYWgv7CMgFB1AUn2XNFF?=
 =?us-ascii?Q?3sT2gE70zPiK8T85JC2fPJdFoko7YFNpmMzuyosS54JNWuyRHv3XeKN7EXCk?=
 =?us-ascii?Q?AHzOyRAa/PzFYwUyMlB9AyaW/B5ulJaG/UH9FhnMARPln4odkg868npqsa4g?=
 =?us-ascii?Q?CCTc4195KoTix2wDAnxSI1CKf63LGSlQrX+8mikQ1/Mj6NwSsWdYWHWWPn7W?=
 =?us-ascii?Q?RRoF3l0Id97cDGnjxq/vBBOaUB/bWAOmSSM0d3HIoIo8DJslvegYNhikjDFB?=
 =?us-ascii?Q?7dNgeWpIK9RXHSeof/2YUFrvascGE1kCWtCyUyDWiHsfy2L8AdK0DukHIHZz?=
 =?us-ascii?Q?ekG5wFpUTXFKUQ95vJjnALrAJo5E2wki9Z/HZElFhWReEurOisbBE2fnYSuw?=
 =?us-ascii?Q?ZEikt7uozU2VBsHHHUHWIzt43bMyIk6/ip/IpsFnSLQexPDc2hyTQ2w5gRwj?=
 =?us-ascii?Q?EylWoz+UwuiOZtQ1oxUPO2A2Gxa9nW8gqxbOrmze0VmFT0Wfi5fVeeq9JVyq?=
 =?us-ascii?Q?5aQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d32f92-2e6e-4f50-f1b1-08d8bce7ff8c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 02:06:28.9446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/uB2PuNYttagIKEdTw2qDX4Fu7zDoUf6KgUGn08mMF+uy0x0WiKG+7dCHcuFw/mYhKgEKKQ20ywPgCsyB6gfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 20, 2021 at 09:57:32AM +0800, Liu, Aaron wrote:
> Starting from vangogh, the ATCL2 and DAGB0 registers relative
> to mgcg/ls has changed.
> 
> For MGCG:
> Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.
> 
> For MGLS:
> Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.
> Add DAGB0_(WR/RD)_CGTT_CLK_CTRL registers.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Could you double verify it on vangogh as well?

After that, patch is

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 84 ++++++++++++++++++-------
>  1 file changed, 61 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index 92f02883daa3..8f2edba5bc9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -492,12 +492,11 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
>  {
>  	uint32_t def, data, def1, data1;
>  
> -	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> +	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL);
>  	def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
>  
>  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
> -		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
> -
> +		data &= ~MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
>  		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
>  		           DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
>  		           DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> @@ -506,8 +505,7 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
>  		           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
>  
>  	} else {
> -		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
> -
> +		data |= MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
>  		data1 |= (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
>  			  DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
>  			  DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> @@ -517,7 +515,7 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
>  	}
>  
>  	if (def != data)
> -		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
> +		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL, data);
>  	if (def1 != data1)
>  		WREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2, data1);
>  }
> @@ -526,17 +524,44 @@ static void
>  mmhub_v2_3_update_medium_grain_light_sleep(struct amdgpu_device *adev,
>  					   bool enable)
>  {
> -	uint32_t def, data;
> -
> -	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> -
> -	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
> -		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
> -	else
> -		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
> +	uint32_t def, data, def1, data1, def2, data2;
> +
> +	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL);
> +	def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL);
> +	def2 = data2 = RREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL);
> +
> +	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)) {
> +		data &= ~MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
> +		data1 &= !(DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> +		data2 &= !(DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> +	} else {
> +		data |= MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
> +		data1 |= (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> +			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> +		data2 |= (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> +			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> +	}
>  
>  	if (def != data)
> -		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
> +		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL, data);
> +	if (def1 != data1)
> +		WREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL, data1);
> +	if (def2 != data2)
> +		WREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL, data2);
>  }
>  
>  static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
> @@ -555,26 +580,39 @@ static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
>  
>  static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>  {
> -	int data, data1;
> +	int data, data1, data2, data3;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		*flags = 0;
>  
> -	data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> -	data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> +	data = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> +	data1  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL);
> +	data2 = RREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL);
> +	data3 = RREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL);
>  
>  	/* AMD_CG_SUPPORT_MC_MGCG */
> -	if ((data & MM_ATC_L2_MISC_CG__ENABLE_MASK) &&
> -	    !(data1 & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> +	if (!(data & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
>  		       DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
>  		       DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
>  		       DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
>  		       DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
> -		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK)))
> -		*flags |= AMD_CG_SUPPORT_MC_MGCG;
> +		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK))
> +		&& !(data1 & MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK)) {
> +			*flags |= AMD_CG_SUPPORT_MC_MGCG;
> +	}
>  
>  	/* AMD_CG_SUPPORT_MC_LS */
> -	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
> +	if (!(data1 & MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK)
> +		&& !(data2 & (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> +				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> +				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> +				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> +				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK))
> +		&& !(data3 & (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> +				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> +				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> +				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> +				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK)))
>  		*flags |= AMD_CG_SUPPORT_MC_LS;
>  }
>  
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
