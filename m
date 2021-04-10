Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4516CC433ED
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BCF61029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BCF61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A276E0E7;
	Sat, 10 Apr 2021 02:04:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CE66E0E7
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTmmigDDcNukrCYb1wshGW68+yuyvijIZA62JBMiB9z4+ArlN6XMiHHV/59/HkEP7u/YOK7PK75EwE0ELo+/twWiv1YX5rkAeVWaTmp+LO0sdLkakkWdF7OOQ7bgco/1GxoA2d4bGqdB9980LEuYaKh9Fvj4yUSrmBxdEzrYOkDifAypVjCHx3Bv88cxTEqVqQqHy1nNJ0iUa/2IoZO+6ZDw9Br8zTRvUUvkbpjuiNF3kXH3RgDg9NsOmLPLh5rSzLH/LrTEXh7jDKjUVCX24YKUZDVXTHMSE8YYLCu0oFsS3fsIDUOcs9t044t8DhZvzsLDpprQ8cUWkWdk4o9XWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyjx4uGN+aBoS2BSvoCnC5KKeWa3xLryASV+UYLU5bM=;
 b=C2v99Ipu06DImSV/GNd0HxPEBoaskMicCRQDDiWVlDGJngwYcPY/PFKS6zxk2WilzaoQcSRGxmuLjW9m9GWByy+SP1HDoOa/boMXbYI2c4n7b44oKEswGsZmOCDYBBdDqwRbT3XjrVtBblleOyomZ1sRi4eBaqizNeWzAroVCTZ5tEejJhbWbToNLPsE9INL31sW30QrRCzBdjdwrDiJ9jwGcIMlQNaEttXQVrGQtVXIituY7bbbZAhneGLz4ManAxfJnSqIj9dDdZqnpxce/tRREBWqdqLMVm/cMEtqI1qwVjuLXO5/cStaLNAif5d/WbbFyjaeALl0d7ZE41x+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyjx4uGN+aBoS2BSvoCnC5KKeWa3xLryASV+UYLU5bM=;
 b=tYp3cwAp6DuP/rML6eiGecAA5XkwU+hqxqxGPXa/2Qf71D+GzijVz1I5V9BBg+ZN/a40cI5zWNWdR2lsIqJNlO1HQRh/waSZzQ9FxidngUkDTUee+LgCcK31R3k6iwUIL+WOhBuMiu/Kf/Md+pLbmUd1bB0SQhkPra2B37UK/Io=
Received: from DM5PR2001CA0002.namprd20.prod.outlook.com (2603:10b6:4:16::12)
 by DM6PR12MB3706.namprd12.prod.outlook.com (2603:10b6:5:1cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Sat, 10 Apr
 2021 02:04:34 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::cc) by DM5PR2001CA0002.outlook.office365.com
 (2603:10b6:4:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:32 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:32 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Add debug flag to enable eDP ILR by
 default
Date: Fri, 9 Apr 2021 22:03:46 -0400
Message-ID: <20210410020401.1100228-2-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c2acb90-2d38-4978-1dca-08d8fbc4fc49
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3706DCFB498393A7BF7043F8F5729@DM6PR12MB3706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdB6nN8ItylVuMT5dVO3yxjgt3flGV2L6T67wHxV7W1UbZ3L217YsfJb0u2ciq7++6Z3qTuQDYiBUqSXaIBqm5IaJQdCIkz1IBZP4VeMbNUTPtic0iWoTja2pmiHyCJ343khs+aL3zXVNfdYbdgmPbI3rdrtLeKwECJuG8qy75R4UUfP3ipBqxb3aY7XbFba1Ht+xo/uFQhu6eru+yZJRklddwETxV+nN1Wp4iWm6K3kQLqipBK3NlEJvXiV1Q60Yd1ESa2Ac7yKZ1ugpB4ZwnNRPuxL9TaTmIpLCLe3nRQzL8ddcDZekpfJRkFZBJcOSf1cFhOtFHC/NAP37l7J5DhBUh76VQS4VT/k3Rh18TPOITCQrh7aC7xmyY2DSyElhGujwu6Fm8V5AlHyQdaKKGRimJ4N3QT6dhEnG7X59GDIGNComyYnUa+3FqoZ67wvFq9nwfpu5pNBxGzindHB3yWC/DHt5m5IEg4yOQ8ZaFvyg31s+Useb0zoImbySj+nlpKgSp3s8/rqIXw6gfOQGblnHBfE1Knt9ZSObReUQDtHtaAQQyHE8bdOslzgnQfdCk69qN70O879dteFOdZzuh4ORqRTgUaTUqTcSxpBvXsFyeCw33LOOLp083trkRXuh++1EONcHsgtv4BoWVL2s0HdtbqDrzIARIULwXxbYMibhiroiDC4Hjv1mNZnoVX/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(26005)(82310400003)(47076005)(36756003)(86362001)(356005)(8676002)(478600001)(336012)(4326008)(70586007)(70206006)(8936002)(186003)(2616005)(1076003)(54906003)(426003)(7696005)(83380400001)(6916009)(36860700001)(6666004)(316002)(5660300002)(81166007)(2906002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:33.6677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2acb90-2d38-4978-1dca-08d8fbc4fc49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[Why & How]
Allow per-asic enablement of ILR feature with debug flag

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7d2e433c2275..5aa16114a676 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3892,7 +3892,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	memset(supported_link_rates, 0, sizeof(supported_link_rates));
 
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_14 &&
-			(link->dc->config.optimize_edp_link_rate ||
+			(link->dc->debug.optimize_edp_link_rate ||
 			link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)) {
 		// Read DPCD 00010h - 0001Fh 16 bytes at one shot
 		core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8108b82bac60..f9fe03cb2536 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -293,7 +293,6 @@ struct dc_config {
 	bool gpu_vm_support;
 	bool disable_disp_pll_sharing;
 	bool fbc_support;
-	bool optimize_edp_link_rate;
 	bool disable_fractional_pwm;
 	bool allow_seamless_boot_optimization;
 	bool power_down_display_on_boot;
@@ -541,6 +540,7 @@ struct dc_debug_options {
 
 	/* Enable dmub aux for legacy ddc */
 	bool enable_dmub_aux_for_legacy_ddc;
+	bool optimize_edp_link_rate; /* eDP ILR */
 };
 
 struct dc_debug_data {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
