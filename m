Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26194C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930B810FCA5;
	Wed, 31 Jan 2024 20:14:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E60D10FC6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo6uy0vTSGxqkFhigTqv5JhJDQZl4aL5Q/2HhDadvx38UtukG7A1r8sjuFgRSGRRSsVECu+wlXQLhjP2krYQvXjChFFC0wa0ERmDfqMcjzUy9OGVrDf3b46oeYnfKgaqG5lOHDc7mn9JxMxhQ/wAaXGhN6p5SwO9GRetNaUnxChcnVC5x++b6uzC+mrOuNdOZZK1NuBPPOrPIiuyPhgXRjcxbiqJ4ChgEGmjtGBHV7v4MV3gFblq/8IWqcbqvBwV9ot33a5poyo8yX5e3IPv8BIO/4X2g0uZlPY8z3Y7oz2VwGjcW0lfL/S1RodgOKzyrhiohqdkqEYzQQBhPfW0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02XO3H1h4LH3071ZohweU7FQ9rMoVWF83QP/UkF7MkQ=;
 b=Gr4NCTpUqw3IGK9yWvO10qut+7FUC4t1V1Yh+dbyF49N015ILKKGQM/znawfwwJZDU/ighm4UBlpAUnWOcrcUH4vgITyw1uoKZEL8jS5aCcb+B7StA7gYEbWAuZYIKpFJgjNiOpPnWKmZGZ9mVXiWp2Dc1xqTPw0UyqRjdRFTr/2XsQv/MmszQBCOavKUPeYPlw1FQngWlFaeniZlysTLJUcZUc8EI7pWxa5O3Y191m1UMrgr692D+4RvbGPfLS1cD/i3PMMw4Gq6gie/zcBpcbkUHQ08ATsKz/74XfUWHpSIF9/DDq642jrerB34gqgijnCtnlb2R0xFWfRUYzgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02XO3H1h4LH3071ZohweU7FQ9rMoVWF83QP/UkF7MkQ=;
 b=v3K7ggo2DiNY+Yl1/CwgK9p4ZAlLtDWhtk9ehaIn3s6lVZ47UM/MTteC8AlcmCiYLaLn3X3KbYNHszahUBxl9LQMHeLWYG5wrY5DqJmjxxngfOKS5TQHTIlMug36JMfJv+/OBSDLgP0K1vfA3tb0Pkb3AX7SSYZ+ZO61j/dtYxE=
Received: from SN7PR18CA0024.namprd18.prod.outlook.com (2603:10b6:806:f3::33)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:14:49 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::26) by SN7PR18CA0024.outlook.office365.com
 (2603:10b6:806:f3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:21 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amd/display: Add debug option to force 1-tap chroma
 subsampling
Date: Wed, 31 Jan 2024 15:11:15 -0500
Message-ID: <20240131201220.19106-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c2565a-b70b-43a1-c9da-08dc2299464f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXCwoZ6OuaUs5eQPn8MMjp/PaJopTleL0hQv5YfNNtqngh4oLvzZrX3oK7kEjnxmA/bqm2N5tK6TX/Wc3FBlgYJHK9hEPbhVEb9iyOOmV6eFEj+zoo4fbODdrfzF00pbQNT1YMalWa395rMpfwyjjbZ6qyv8gqiZtIjb0EjsJ73RLAkmHCKtIkGQ+8cHlKBNe7ShQmr/vJgX15EKUnYORuJAvVXJBsNp9LyPE5swWCipIlUxyNCirmTuN/cJ3j1hhR3GRtL1lLjjipV/L2avQ4ucOk6QjzUkMXPia8hyw1wEVEOm8ErriOp2UFCk9jh6eIKJqT5WsL7VlB0OH57E1mJIkKrhgBLhNLGtZPXwz4S4o2tDtL90NPXNiqPuhslYqC5FojrIqh5TfHkjdZY/mRareSPJjipmjEufPWeOozcPdWegB3ZNH7solEp92lyichikiu1MRb1OxaiMH4xdDdO+fJ4WSa8WEZ9Agcr/SwPuSfkFPXepsHstoA+GXxu2Z+uElEd/z8AdKSRonpd1dRH5K9w7Z7My9NYA67jsEEceZ4goKFoKdQ4tndE1oDrpJb7Yv98cW0P9PElmCgzPDSLr/O65YAqlAcPOhrYifaSG/1tCoolZ62Rk423RgOc33Iu5psx4VRNJ9UbYNkg5ICY68PfUfoDPFXXTWV8V2zrRD1VSGf/SpCKTtsxE5mCWkl5myoXIikx06hvlzlfaNEjNtsg7cprG//DCzBzNQ+W9MIev0Zb9gUfmEpHbSGp29ebxhQyZjQKVOTtdtAVA4HErm+qnlESJ+SEWMMC3sfzEavH+G8UewMk6KvetNylV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(16526019)(83380400001)(41300700001)(26005)(336012)(47076005)(1076003)(426003)(70206006)(2616005)(36860700001)(82740400003)(6666004)(4326008)(5660300002)(8936002)(8676002)(44832011)(2906002)(478600001)(316002)(356005)(54906003)(70586007)(6916009)(81166007)(86362001)(36756003)(40460700003)(40480700001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:48.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c2565a-b70b-43a1-c9da-08dc2299464f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Default driver behaviour is 3-tap subsampling, so we should keep
it the same for test patterns as well. However, it is also useful
to force 1-tap subsampling for testing purposes.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 10a5f53a56db..2dec2507e971 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -991,6 +991,7 @@ struct dc_debug_options {
 	bool disable_timeout;
 	bool disable_extblankadj;
 	unsigned int static_screen_wait_frames;
+	bool force_chroma_subsampling_1tap;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
index 0dec57679269..48a40dcc7050 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include "core_types.h"
 #include "dm_services.h"
 #include "dcn10_opp.h"
 #include "reg_helper.h"
@@ -160,6 +161,9 @@ static void opp1_set_pixel_encoding(
 	struct dcn10_opp *oppn10,
 	const struct clamping_and_pixel_encoding_params *params)
 {
+	bool force_chroma_subsampling_1tap =
+			oppn10->base.ctx->dc->debug.force_chroma_subsampling_1tap;
+
 	switch (params->pixel_encoding)	{
 
 	case PIXEL_ENCODING_RGB:
@@ -178,6 +182,9 @@ static void opp1_set_pixel_encoding(
 	default:
 		break;
 	}
+
+	if (force_chroma_subsampling_1tap)
+		REG_UPDATE(FMT_CONTROL,	FMT_SUBSAMPLING_MODE, 0);
 }
 
 /**
-- 
2.43.0

