Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D8C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB2761458
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB2761458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689126EB2F;
	Fri, 23 Apr 2021 02:40:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655726EB2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMfvAJ1NXaPYxyqSQ+DSb0CzCTeMPfWNX4sEz3OhusCr9eTBbFpGzXa4g8OaUWaXTvR6mtz7UeP8hipdf0kaPNfs2/tDIFa/m13lSjJRa7CgOciqPRZYSRsraRhPgWTdWzw+TjgqFltrTK/X88B2b7VbM7sq4mxabd8seo1WieOt2CUyw2bFqkUhIuNjzgq3SkDT5Xj1UbT0OZamAwPrrRrj7bRiAxX0C6pFND53twTjjCr0516UV9KQiK3XGNqlQjhKZmc19WJ+lGQlu/UFi1UW12CX1Ywh+IrEqw/EIj4heGd+QciHuFyGC/QfhTZ1I7VQF8HOc7Z0UErfiJxR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD50lFz2Upk6SXseG8pRwBEjZXKa9O9zG6P4sx238xE=;
 b=Zu/18X/iSU+OL+KKvojhWOsUXrhyFbIjgkJeNSr43V2KpCYZK4u0H8p7p5dPjAUQTH2831I3l42LGXfo+mXsVcXpjALRxRpTZ94lHzBwnWcGwC8+o04GHsv1tR1N4+37NYOsOgvMRFocTzUnaQr1Nt/KfZ2dKMPTBeq1390JkC+Ni1F9lSmwkTpv61eOe8VvNqSJwtCLWJro0fz9skXRZGBa1n43YZVTiSbtgytJjhmYPOHpHIJOExiYl7DLrhWhhC5teRd+p/2QezC1KbXV8fZ+bBMthwpIaAY2sDC/dOx35QYkvCtWIjYOZ8BTOgWXhyZbTTZ+ajKdu2TPZYwHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD50lFz2Upk6SXseG8pRwBEjZXKa9O9zG6P4sx238xE=;
 b=100uqhEtnQv7hOQ11ftuGLlOcHpHfSu/+n/wRxH27QRq8fjw2v0VOYVS/HbClLgSjIKBRpiu7CxWR2NEfsrdIlZW6G37kt50WlbBEL4QXt/YbJ3FjTgrjcmYlmw2az8tVXzkf/7lv51DbWK+B+HJJV8s/x13Wl2WMhQ/VCnMvV0=
Received: from MWHPR14CA0003.namprd14.prod.outlook.com (2603:10b6:300:ae::13)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 23 Apr
 2021 02:40:52 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::9) by MWHPR14CA0003.outlook.office365.com
 (2603:10b6:300:ae::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:50 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.0.63
Date: Fri, 23 Apr 2021 10:37:13 +0800
Message-ID: <20210423023714.22044-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2609773-235d-419c-6b3b-08d9060135c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-Microsoft-Antispam-PRVS: <DM5PR12MB46784BAF2E54E87CD2F1C4B6FC459@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baBtqPz/qmQoA4RFNiG5+BMdjl+0Te+tsEmk+xitnfITEC6BsVYyfgrNWsA5RxtbcZ5dbq1uMSbEkRKgNuZkYBN7RWx9XR+XH5DeYW+qHCkOvLBtootnHXiKxIfJQDwgFkoS2yrh+payFtlW6tm2CVh2d6Lg/s7QCeIvO9/XKJg1xLP6enx0+vXJjmGvdDwK/Jf1MYigwDFGDDYmbVjK4y0AM+p+dXfESOjoPh0zBtmUG4eJwbFDRSTZszcVl5kSStga9QFbCemEMSrB7fTEM9m2MeNcnIz9gd3Pa2ccolbUPgUZ3NO7m5IqQcQN556jZth3Mcy6QjiUwtRuVGdLXySVnw3u+ETOHj/ABeZY/Sc75Yt20W8IzRChq2nh4cNR5DrzpX0OzK4Rh0l+BwRlrzmtRExM7dvjRLzt7xKoVC4kNNyLrM7HgM5oGBZNSKnqE7oj0d2AP8nqGhzkopRRHBdk5JJc/HgaQ3U9JFfYUX00Fb+X3PtX83f0vwfGS2YvyvYNBnLYesMbB0K4IH8jIaSRrHTnYcG9R/PCA2kfv+thd+dM8SwkvqnNdFCtbSDRXLiSEse/Pby9M2LSSN4bZJjaHVV8bJazLzkWwLX9ZMzauo6n5MHPODt024O1lqvmonU+EjFe/4ekn8VRnO0/0VKJhgGPL6T6gp1hKqq9gAF340AbmX0Oy4yryzUdTFxf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(7696005)(8676002)(70586007)(36756003)(336012)(478600001)(82310400003)(316002)(83380400001)(36860700001)(6916009)(4326008)(70206006)(86362001)(82740400003)(186003)(54906003)(356005)(2906002)(1076003)(81166007)(2616005)(5660300002)(47076005)(6666004)(426003)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:51.4855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2609773-235d-419c-6b3b-08d9060135c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 82c6e8a8a7c9..95fab1d3d7af 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x23db9b126
+#define DMUB_FW_VERSION_GIT_HASH 0x41548deb6
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 62
+#define DMUB_FW_VERSION_REVISION 63
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -117,6 +117,8 @@
 /* Maximum number of planes on any ASIC. */
 #define DMUB_MAX_PLANES 6
 
+#define DMUB_MAX_SUBVP_STREAMS 2
+
 /* Trace buffer offset for entry */
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
@@ -328,7 +330,8 @@ union dmub_fw_boot_options {
 		uint32_t skip_phy_access : 1; /**< 1 if PHY access should be skipped */
 		uint32_t disable_clk_gate: 1; /**< 1 if clock gating should be disabled */
 		uint32_t skip_phy_init_panel_sequence: 1; /**< 1 to skip panel init seq */
-		uint32_t reserved : 26; /**< reserved */
+		uint32_t reserved_unreleased: 1; /**< reserved for an unreleased feature */
+		uint32_t reserved : 25; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
