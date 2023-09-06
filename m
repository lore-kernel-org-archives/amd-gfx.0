Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B30EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EAA10E625;
	Wed,  6 Sep 2023 12:49:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2789110E625
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNNnozM8J9NZYozN7dVnAoMFlVAAmp/CdMHwjLx9gasA+TdessrUblF31s/JLpNMjc82tGHI4dAYN1xv9RsdA+vvl4gyOVApvBwRVmSi7mq1KghEg9mSEkJClPLYbjaqEawlm7v2/J0BNy7h2bVw10c0/CPa2H0BW1mWTHBjgAQga1eA27ZAi6HmAeMWC0y3eCta1meC4AAXTXR2PxSbPv/McU0H6K1+2XoMED5mefyUD/hl0uDayv0pGsNJRXLpTTTnfwc2cP0Rb0TAmPZ6qKl7Qe61qsAdgqFwOs7qEgzadjDC10RrObKXgGSReqqNNZHO8HsQTTU26O5FR1+Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az4Kn+CQ7+6612yoQ9vjVWX8d03/fgqvsfuB7mp4K2g=;
 b=POKAQQCSOxOBMmTxmO1Bimgo4WOfxipz/Xz8Y3p9Pq4e7UG5X/vpOskqUFuPqKIY6XNeDatsZ7tJ1/vTsMMo7eSDt2fpLGfg3hHaCk18f9QmKAbv/suR/D+RPaHC1Dc8ezD7tZLN2duzPfn1P7HC+P0Nu0X4QmF9sL5+wm9Ikt+ppqbypnsqg/ote7kHPTawfrkVtxto6RM33lTWnY35naCQeabwTAlyWXDkLJtDJzCTvgOUet3xRT+0qIeFKN/s3CdixPYOx7qIajeHTRzSW+SBnc113ETNCJZAwNmUeLkoMMvft5gnbLSLrzg+pMcBXSaicMmsjmAGyDVjisB9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az4Kn+CQ7+6612yoQ9vjVWX8d03/fgqvsfuB7mp4K2g=;
 b=mO/5tFmNwP2HJjAem8dt1hrqnmkklYRJ479A34cORSa1T/tx1IgbywexOXjljnSm8O/FMP84yvYvUSfW+bIYas13OuX1mxpxSAPEnrtnVldKHWqnyMZUiyaUBE1bemZ1aTah+ifw3dlsHWyKZkhSBxS7ylhurimwrztJfEv8tcA=
Received: from CYZPR10CA0011.namprd10.prod.outlook.com (2603:10b6:930:8a::7)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:35 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::84) by CYZPR10CA0011.outlook.office365.com
 (2603:10b6:930:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:34 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:30 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/28] drm/amd/display: do not block ODM + OPM on one side of
 the screen
Date: Wed, 6 Sep 2023 20:28:13 +0800
Message-ID: <20230906124915.586250-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: c847447e-aa5f-467b-9024-08dbaed7b90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrYmwk30U+6K7roWAFvHl7a20go25TljsHFCYN/wTfJ1Sl0Nlfr6JHSJ5ACRwPCodc5/6SBVWhxuvaqNZOsn6n1ycdjBGcxHp0zLDweo4OZ5KVfXPvwVeC3A38jl8pZf8Oe2NsglFAF08DeFBehW14ZeMVgfxTAc0SDimiT0BvEwkWoRFw8bbXcrSEdu9sZEroSRH3tp4z4NPKNryrrgWSbBBk7dRGUmusTPvBWkiQJPf8VvKqhn2hJPjaN+q9Vtf8V0aN/Gv2oW4YYKHxMu4I/f+kmM5mg/klUuqqmnNJOx6gR3jt30vgn8NVNKbH2SADk+hZ5ugNnykzNwVpssgHYBGZypfn2L0OmuGVEvU/1Inbl52AyhXagWb2Noo9SjW8KnQeEbBzL+SHfAFqtrP4/mbyB4QO3WUYnpp5WsilqDP/96UR0sOXF1bbQ3x4QZZQSjzJIeE+HKOFKTLHfuMzdTy/VNe/acmuI4DfTYxb6dqeL5RsiBFEvX883Vv3y7Pisviiv80D9m0BVN9y7EGmiWm5IB+ZAMwyL1IIxh1IRK2E2we/c+FepsFMhmaT7hp3RT6Int5dwjVKF+SHhFL7oDHKFbLlAuS8cmOsdjHs2coRNdxj/QOCerQEF23LwfEajwU4XjiQxutgz5qVwjsnVns0Nw6ZOzJ0pJUYExI1u0rAJ17Ol2EBFJx2IkVTSkt/O5E1mu7ThyaD1ByP0yl72UJXRXbzfEPsC6mPmH7xOcdk1ENY7jcqrOjbmGm18GVCPnyUbsj1P3YDP0xlWz6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(7696005)(83380400001)(478600001)(336012)(26005)(426003)(2616005)(1076003)(16526019)(2906002)(41300700001)(44832011)(6916009)(54906003)(8676002)(316002)(70206006)(70586007)(8936002)(4326008)(5660300002)(40460700003)(40480700001)(82740400003)(47076005)(36860700001)(86362001)(36756003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:34.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c847447e-aa5f-467b-9024-08dbaed7b90c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
build scaling param is overriding validation policy regarding small viewport
support. Even if ODM + windowed MPO is not supported. The decision has
to be made at the time of validation. When building scaling params, we might
be building an initial dc state as an input to DML validation. The initial state
is not supposed to be always valid and we rely on DML to modify the initial
dc state and determine the final validation result. This check is pre judging
validation result when building the initial dc state.

This causes an issue where we are transitioning from desktop only ODM
combine 2:1 to ODM bypass with 2 planes. In this case we are building
an initial state with with ODM 2:1 combine + 2 planes. This is indeed not
supported but DML is about to modify the state so it no longer uses ODM
combine. Before it reaches DML, dc resource already fails validation because
it checks that the initial state is not supported by our policy. This overrides
the ODM decision to validate this state with ODM combine disabled. Therefore
causes an unexpected validation failure when the secondary plane is added
on one side of the screen.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c929003825f4..494efbede0b2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1371,13 +1371,6 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	calculate_viewport_size(pipe_ctx);
 
-	if (!pipe_ctx->stream->ctx->dc->config.enable_windowed_mpo_odm) {
-		/* Stopgap for validation of ODM + MPO on one side of screen case */
-		if (pipe_ctx->plane_res.scl_data.viewport.height < 1 ||
-				pipe_ctx->plane_res.scl_data.viewport.width < 1)
-			return false;
-	}
-
 	/*
 	 * LB calculations depend on vp size, h/v_active and scaling ratios
 	 * Setting line buffer pixel depth to 24bpp yields banding
-- 
2.42.0

