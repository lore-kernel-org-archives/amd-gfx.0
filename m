Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B8FC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 13:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD3F206A4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 13:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD3F206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3386C6E202;
	Tue, 12 Jan 2021 13:18:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DF16E202
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 13:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVgZaazxGMC3psK33hS6AOtRXzGI+fGjVOTzjpaYY0/ldvp9QqWrDBrjH8/wuRoiVmkPgWnPzN0cKucYHOfYL3xUx26MsO0ODU4oq+wQ7k3o6s2vpg5geKM4DcBhWDDbRmQyobfMecAgG024eOmVp5CEBKQxsI8re/2WVCoAN6vtxdPzJbhKnbBbinaqruBex/Qdan6Nj5F5fpii8vd3KLnEBRAzqagFVOdedXLeLnQc1Zb8FLjhfbC6VP6u7J9HHt4W5CZp1BKGCpHv5UzmGCI+DA/cN7BPdPrM9UsX407dg/lcHaitQfjd4HYECxY5ti5/SIbJCQ9HFlbMHr8EdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg+a6TSaTsnLtLWM5RnafFQX0FTylPOKawIgQZKBZxo=;
 b=T+k9WQpAf81hYyDThoAPZN1MS1CwT8JrhzmrnjPYMhjRyKHi9f5B5O9ZSfVlceMAw90KJq8xd304hHWFdK37saIIu3X8S2+BIs9pr3VEDRuKcf/HubF6lckFgj0TqlbkPI/7hWIrjUpXWN8l247m9NG7OlsXN/xZ7fykB6bbBq8P1gPvifLq9I5O+J46jzEnM3UZvykiwZhBiAmPvLredwnAK4mpP5S7hGnENKr1LYjyPkBhbo6eC/GOG7l/cNYMTyEsO53PwezcTpTSo/0LGQb8HxqANga4qGXIUiPZ3wPNa6itpZihi4yidXN26u7e3+u7d+xIe/B/zZnLdmDWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg+a6TSaTsnLtLWM5RnafFQX0FTylPOKawIgQZKBZxo=;
 b=yIBfw/lr38HiCXusYn7X96tcVpET/OM43AK+60Q1zIqKk9gmUkxNHLIIIZDPUm/wOtHxGS/+BUFcg9qR6IPLdxSrR0GcwS+nxbiChU/Dlhb9mfSx2Uz3HxL3QLU8kN3wjErM6evRioNqgASmWI2sExNqoblNxOrTguNHA4yl64Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0173.namprd12.prod.outlook.com (2603:10b6:301:56::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 13:18:13 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 13:18:13 +0000
Date: Tue, 12 Jan 2021 21:18:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: fix one superfluous error for renoir
Message-ID: <20210112131804.GB122980@hr-amd>
References: <20210112113530.28540-1-Xiaojian.Du@amd.com>
 <20210112113530.28540-2-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210112113530.28540-2-Xiaojian.Du@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK0PR03CA0109.apcprd03.prod.outlook.com (2603:1096:203:b0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Tue, 12 Jan 2021 13:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd3790f6-4120-47de-e48f-08d8b6fc83b9
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0173DCBA483E3F990D616C23ECAA0@MWHPR1201MB0173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRsuLxnp+O+H9Ny+I3UOHBbbeHOwXxM37DSoIe8bgMBQXp9AUiXbczJrDLOjefOocQYu2k9DN+uQk7kBK4CjMqMWTMnUMZqqyDdZGhyhKGvGCeCf5V87I3+UWjkW8TeWDrQMC/xgp00tTCnjtx3O6TxWxw61O4Dw8IKyR8p5Lle9GfpK6j2t/FVz2FWJOiko6cjNtAs2OGFTpjtdS5dGcVF8cXTRhrEjabQbW+sgZZnuPGbflxQUlHR6QV+yVmcTQRicTb/LwyhRlQ9rDa44xuTN6++Eoqs2VArCmcQx0bQY8nhVt6x+tQzLoYVsU7AcIr6FqPK3fPVA7XfZTyh2w2r4fXifbLS7lwtSMYulIsLEbcKbNYvgiv04f1JPTU1gkQy/NXo9tHiPh4xCn5le/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(86362001)(8936002)(2906002)(8676002)(6666004)(33656002)(478600001)(66946007)(9686003)(316002)(16526019)(26005)(66556008)(66476007)(956004)(55016002)(33716001)(5660300002)(1076003)(54906003)(6862004)(52116002)(6496006)(6636002)(186003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fnT/bJZ+C35CI4+DqSdjECW2cpEaSy2V7CGP4U3iTDUuqg1Q5Ilg1fRgB7aI?=
 =?us-ascii?Q?G+lrQDycz4iFC7BctN0u/GczxHwQwsguvy7FOKQrWw0M3Ts91xrc8o4ux9RB?=
 =?us-ascii?Q?X/A4f8+TNiVuQaW01nT1DowOH943AfVHGTvzJ73ugQHO0UxdCYy3v7c8TYRJ?=
 =?us-ascii?Q?4pvMc2RQFGys/q4EJcSYXQTTv7bd0BQNejPFyvHaRIkm/eNwczePiCs+0C3V?=
 =?us-ascii?Q?+tZznz1bhO01z5/YnW/7jSp9x+fg9PgNHP2s0eTmvoHMhWXYYIfvoq+yLBmH?=
 =?us-ascii?Q?LI01sfxiRi4gxdZWnztY2nZa2HlpYy/AbqACJWoA7bbs0FXUe2bc62djndZv?=
 =?us-ascii?Q?fj13TU4N++MRY0AS0VQpAQSuNJMg1tgpwe/0tHx2y5fxtXLn8bxGrWWf3BBU?=
 =?us-ascii?Q?9aamqNPsSm1IOuQuwgm0x2ZVCpeGChYm9cDER2ZGGlNXWZJzsSWzbnvndFhC?=
 =?us-ascii?Q?Dx+cTrveYU1ww8NTjaCH0PyvAQdF3WgYqbwNOQkmK7hRsumyuSJDFSxIRqoi?=
 =?us-ascii?Q?U+4C9WzDvM1V9xdCY6/vosCxgVpMR0LMbxEVnn6gsUdqz99HQnX7Rg78N6rA?=
 =?us-ascii?Q?9K55cEVYJOBX/pH34A3EJflbaHsJxzurcr3+GePhkseM4FqkeM1KcR5VNAsb?=
 =?us-ascii?Q?7enWDWEPY4PkUyI3c4ZElcoRR65rPN7kJgtOk2KGlcjyUpKDs9B44Chx1Q9z?=
 =?us-ascii?Q?W5rVH/4r02AEFj1jFtY9CosvSh12t6VR7ESD4j77NFynOk5xshrffPx/973K?=
 =?us-ascii?Q?4S13XxWl0pTGyUWrXylqlM/OFZGcbIas38ju+QWdhWGDI2p96adqDZ/4nDFo?=
 =?us-ascii?Q?PZrmmw4KkbGks67Yeha3QeTaK5sq4pbgpxP6VGK2MuSl3IJFgtMJaw3x08cj?=
 =?us-ascii?Q?dpdeiwPvIH8+KeoppIm2LG9W0E9EavQ4vLqv3o2uj/+C/03GtMRZ+ra9BvMu?=
 =?us-ascii?Q?+Kv+jk1BF5y3FE05wO+h/xg2k7BWP2unOSwo3cUIKKRAnm8fJimutuO9sDbJ?=
 =?us-ascii?Q?7UfO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 13:18:12.9247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3790f6-4120-47de-e48f-08d8b6fc83b9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouIh9iZWhYkN6nT5bB0ogG2OQ1PImP145SsMnHJGZKklWdZmQrlSdlvSE0r0WaqYg0OhRYpI2l65GhDrU//A0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0173
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 12, 2021 at 07:35:30PM +0800, Du, Xiaojian wrote:
> From: Xiaojian Du <xiaojian.du@amd.com>
> 
> From: Xiaojian Du <Xiaojian.Du@amd.com>
> 
> This patch is to fix one superfluous error for renoir.
> Renoir supports 5 kinds of power profile mode:
> "FULL SCREEN 3D", "VIDEO", "VR", "COMPUTE" and "CUSTOM".
> After loading amdgpu driver, the driver will set "BOOTUP_DEFAULT"
> mode to APU, and it will get one superfluouserror error,
> which is saying "Unsupported power profile mode 0 on RENOIR",
> but it will not make any other harmful events, so fix this error.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 1f6a774278b1..f33f5141cbe1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -835,6 +835,10 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  		return -EINVAL;
>  	}
>  
> +	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> +			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> +		return 0;
> +
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
