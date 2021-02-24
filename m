Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC99C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9154364F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9154364F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8A96EB79;
	Wed, 24 Feb 2021 22:21:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2266EB79
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPAaIRAUcGqlFtK9xmDLHiiXaa7R9Djitl2xLjrP7T+Fg4I5dfVsRiSEHg8bepTF3eCJYj+sMeDJ6uT97yfaqyLOqpYUcrmQ5ydpRCS6jKFfXAdrGO9CImBMPUKSzYglpAYitoIWwQwlQ0BVjxIxv46WVS3TyC41oMAL4OD9NvKJB/b03GhA7IdrQ2zs0a4kLu2nePcVVkgizJ7R4ye4Hb+WSdknA7MPj97Y+ZOLYh5n7Nta8HmSDNnNn9+2KxjRhkJqI4OwsgCxEZvpjkQZAdAOKpl4j6Jca1ma1KtTeOZlyCfeGplE8Z1jUcoaPB74TVnvG864pQj5NmeDxHvM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZdWwnPp+yfDP7+7CwE6LOj5uctkyHXu4mBW1PJs824=;
 b=nsWznwWhj61aPD4jfWaSTaf6FCvYAbjQTUB+Y2vIkAhc/cgtO3U2S+idfxLKDGO7GN/rtMCgd2I3Emvb2agSBVeWlQBfeMGSi54j6l9iYMKZRvjDmnyADyY7CVmjg5/atMcu/F6z9rgggeR1DD+imVw75K7Q3eXurJrdMvQ5XdZunxRJQ2WMfWspUoXS1EP+x3XwfKYKEdUiGYpYVhYv6JFabdTMYfYRzt+km7z+iikYN7KKUWB1aZEE8b3xpf5U16CVp54KwHTTz9W5lpGGH5332lZiGAGDHWf9DS5G2IUzDRIFLn6+RL8y544ROK9bOHtfsXBcKsKQLq/0/dSFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZdWwnPp+yfDP7+7CwE6LOj5uctkyHXu4mBW1PJs824=;
 b=nZPR2oLalUS1vo327pM3Q5K0WgBistHuCgwxarkiXyzjBAq6vjKX2EP+My4i/0Esl2zdOC/y14kF89a5Pl2XbukfcHWwc9T78SxhGafp2rY31UNYWTxV3AxelN+GN7zhgC3BbqhydZxVPB4LhA9NLT4sj1ElWTeGWnCe+5qdUq4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 114/159] drm/amdgpu: Enable CP idle interrupts
Date: Wed, 24 Feb 2021 17:18:14 -0500
Message-Id: <20210224221859.3068810-107-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdc12f08-9d64-4f7f-dcdb-08d8d9126bbc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046C48C4DBA9D316D817D54F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BAtY6YwOl4weDiSydzCv8mTl8anEg/fDgJcJeqXihVPSo21v+r4Hchm0yMRdjoDHTB3PtfPevJ4q13aaZNW2T6l+PBLjdPk3sCdOZXgOu7vulCGspfYlLH1qvqsjb1ScuH1AHMiYCc2iyVnwXzSTUGbuD6nszdhUn1bO9c495OQKrHq4hiiXI0p8773ihul1EqAbT2KpRcW9u9Xhk83jLQERhlkT2XzYaYUNfIDEnXH2bEtD9ZBm4nMEl2bDz46NXUgRr7yMMiI3UcAB6YyihQP6JfrH2se1Rxy1sk1EJfzTdle5RCYMgQ8wkP7SIySkifVpwCWtxHi3X/ktDSryxy8JUERHd2ViEcrGiHgRrAP+OlSVeSW2RQYvqc+x2oRUjjzsH7fHNL9O8dzX/s8hrmVHGKidpwkTbMBPMfEzzaxDamDJ6lAOywD9mBsagD2oWgXL/mHYBWv+n6AhDfjjDOA6HZ8RTIoAY1JO4L1TUmC3Vn30K1YhJq/66iMOF/HoO0tVhUMvWWvRGAOLAF3HD2QtKtVxQyDBlxyp5YhSvh7c3hILMTNTxr/jPb4xvTBGEpG24JX/H8b2OZ8mvguHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VNKD+E+lBKA/sgJfyHJ7jEZpHtEC6sV8jdp0taTRyIES1yom1P+3HZkJO541?=
 =?us-ascii?Q?hF/en951XI/xT4rRw/nWE+aRbxtx6AyHeGUv0qpzFu4p8XElfo8Pgm8+LYr0?=
 =?us-ascii?Q?wXXTDapheRo7eqm9SGw9Q/20giQbs/uH9gh1k5HO4BhlqPibiWA8xEpsekd4?=
 =?us-ascii?Q?Rc14e9rncB/lLFZcLSuINrpfY15SavBdVMcBgArtssidXrD4I+8E8D28vNhC?=
 =?us-ascii?Q?6/PQqJmSHDN14RGLYRO/egM58sV555uq6BNNFpPLeUUcN1YcOxohiUpPU4dN?=
 =?us-ascii?Q?iFYMtzVhsQysKEm5abx/487X1syvyPlmCOp2z7oC/GSq80sogKwitAbEdJUL?=
 =?us-ascii?Q?oc0zlwCmC2H63yJ3uRrlfmEMSiPOrutuFgpNSxwKJC2Oc537RbiLiquCOln5?=
 =?us-ascii?Q?Cw4b2zyD8cm3qINkW3MNcHFA+UA9gpyvtTuumplBOyis8KNGx5pn/LD+Dga5?=
 =?us-ascii?Q?tJMpi5DrgmaOZ72TqyHjs4jevsbYA6ksj8QWKpZbGKlMHtcAiwy9phiEw6t/?=
 =?us-ascii?Q?ad+ckngSv1G6Y3W3Nsr2YEz2HtitUrcGsX+CArsTZOneBEttbC7Escuqpk/Q?=
 =?us-ascii?Q?XDNekjjuSGpdKxAjsJ+chkCLTay63Qrv/YLVPEviEIpTrqYuoh6Urz96ekoL?=
 =?us-ascii?Q?mPsmhYUCEcG5YfS8lPlGNQC7DVvM+m8YZ6dsqqYmWF4wgL4mEL+ypTYtV+Dj?=
 =?us-ascii?Q?Ve0wxd3t6+CAYUMDphHDNOecEK7UCrsL88MRt/Xg77bhECbuPbyIY2TvB00y?=
 =?us-ascii?Q?ZDCmbU12jmLBjzvNTS/Z/5ikjOOOHlPHCvsCBvP6anM9PEvGAFbB2m6tuUO8?=
 =?us-ascii?Q?il/wNPRxZzgFayNPjSfWFCmOk20rjpAtKGacnLoYabP6yKCk62kNIPaDTkQm?=
 =?us-ascii?Q?kKFAkOxPgEjvchspkAc0nda0Grtn3HWpBvEZ0yY+AavXEDcZZhEos0LMIcgF?=
 =?us-ascii?Q?9EigOexFiCtvAOuJP5zNx2kInNiP/mpJUcQQhBYySXMwl1q35NgfC+dV7RcV?=
 =?us-ascii?Q?1BhA0aLobAGLsklyVhVNuizAX1gWJNJzM8ZrhBsBQrnKFxxobqfGNRxO0+Km?=
 =?us-ascii?Q?oeLoieoM/DEpaGDJUQ926jbhbAYy+BaSOIhj8SPFA94NlZhszfywRowh57SZ?=
 =?us-ascii?Q?LXN/fM/IysjHoM6f7Ns5l5DRZ8/1ywE+q2+cPr1t2xKX1ZgR+shBVQ9YXW2M?=
 =?us-ascii?Q?7yOsmDrtN4l+uj+RIQtY6wjFmYEnGFoRpQ3Re9dD4ZmkSTP/oL//az95zqe9?=
 =?us-ascii?Q?eJ7xyPmyQeCK0tyW0WQv9fUzLPVp+44Ud4uzof18JnXBrn1CTl98Qu+E0Z5N?=
 =?us-ascii?Q?rW5LKDoiUxn16bAohs3zoBlP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc12f08-9d64-4f7f-dcdb-08d8d9126bbc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:41.5861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkfcgJO9zjUPTS+vHi1jq+8WCJYpYJAZsQev8QnRIF9AqHPEQjfpFI405lsO8n18bz9qSUWGKduXiEn2JdLLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

v1: The interrupts need to be enabled to move to DS clocks.
v2: Don't enable GFX IDLE interrupts if there are no GFX rings.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d30e60fdf596..95e97f564f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2666,17 +2666,15 @@ static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	/* don't toggle interrupts that are only applicable
-	 * to me0 pipe0 on AISCs that have me0 removed */
-	if (!adev->gfx.num_gfx_rings)
-		return;
+	/* These interrupts should be enabled to drive DS clock */
 
 	tmp= RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
+	if(adev->gfx.num_gfx_rings)
+		tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
 
 	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
