Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BCAC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB90611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB90611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314B36ED8E;
	Thu, 10 Jun 2021 16:29:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3986ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7sWkYTM50V6nhtErO+NhwQ4rv5sc8Z3YhEfGL4ezQax7fV7L240eOTF32p/saaPznFIyE5oSsOIFrcSpAIr61ODQ0w9ILvChHr4Tg9tbGLHEho8gzsjPj4UhyuJEQPBhi+BFbRzvKyVGmXCWuuOSbOIp4CUvUeBJBvEN5i87fNzcbSlwz7AOospVwWQktN4s39Rivf8+3nP0khaSGnp1FkUeJo8sx4HX4H21SXPNVby2eFxAkulYLnhvg62kaSwlyUd1h8l3G49+6xStJsWYz9y6Ctae6ncI3tZQxvvcSEX9RTpu20LaDznmzN0ovA10zZLqnkDKYGDgZSYMWiLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFtLyaBc2nujE+S75WJhEvBQQlaRzzrl8nneL/KFWhI=;
 b=gT7ZkFYo/VojvKs7vLfYJjQS2uox0oxGGtf6vr4/zDj2baq0Ve034+Qk4Hb9DoRjf85pkjzn105zIxo5Rs9HaUISJ5WKXiJPVmMMH2m8klTNGugDwbbj3uKl61+gjye82s+Q3VrasW/Y33S53kyj9iz2oLD9/UDJjInrkZSA/fCGFOLGPRI1WXoQZTp+BACQqmsMzQWWP45oy2yl3QGrTu+M4jU/EzaZlv1rA8L8xAG7JHTswDxWe8G2Ih4JKDBDfjzTW2vU1UCb/SvB7PQvSveO+/5JRLgKQb/wK5/FyGmqY2jXGAhUTSrFav3IUl3C0WZ7prMZ90cxxjSaYZ3CqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFtLyaBc2nujE+S75WJhEvBQQlaRzzrl8nneL/KFWhI=;
 b=FSXN8ZxfuNMpkCKf9AiT6XnGVUCocn7pUFSGBQKkibipXo0zMf0uz5AVMhYYoqwWOpR0rSSSKPRVGdI43mWav4gop1EOFVaBLs50HFAh57vpsPqQqChq54VUjRxhC1XOy6GCnVr1QGdCfMH5NZVdtmPlmA5jrnGRYlmBjk/p3ro=
Received: from CO1PR15CA0088.namprd15.prod.outlook.com (2603:10b6:101:20::32)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:13 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::67) by CO1PR15CA0088.outlook.office365.com
 (2603:10b6:101:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:09 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:08 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/24] drm/amd/display: add config option for eDP hotplug
 detection
Date: Thu, 10 Jun 2021 12:28:17 -0400
Message-ID: <20210610162838.287723-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 774475b7-66dd-4d35-90c0-08d92c2ce229
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912F82BF787320F42899A7EEB359@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkkQbM0BO3gG2h0fX6xkNqEVdkpsR7dyPbfzEJsSqe6Kq1DHrvxT3/9+AIdw78aGrg8r4OaT2RMQex/sxhaR5aF018LF3zZAMphDge/E6iIjTDY8IJ1HWAIqYShoQ8ad4K+yGMFTffFEEdIuMAT/UVbqM68eivM9toLuO90VeWxP4GWgJq8Cqysz3oIsTCpwTym3GifEWL2QskaHnWZFXcJtyDGqFro5WLJ8+MvzxCmZPy3UtcOem3/6+qYPt6B8++hjKHOFBG+/ViQNBrKJLBk8wNygoZLG1qtgZZo5683YIrMxBT2NT9YOsdk64RC/garEQMr3whmJGWRNJjk92iZhqInJSC6Xiy3X9CmwRXNcAklvncttoqxUukJq1l/scAiLPVM5QjbT+KFdaKvpSQ+apy403g46ipOG+XWKHKXfUh7LIr8v6j/i7LtWujbBU4al67tUYDUfdWCOPaJFbCLoyfrtZHWYRUzClf3jOsgUCnjF767tY/KwyP6yx1avdX7yXL9WsDiDFrmxG3cMRc0nTUsTEzP83cm+OnVPjHQp76xhFCuJipu1nuTUDCm/Db6HOIhNx6TszwdEMg/ELVxAZZ/ywJtjbVYMU/6v6NK/thpkmXJde/JPNBaFEaSBGjVzc2teq4x11XUMEwiCJ0PEyVfKq3MuMlv21HwCiKYLSqA4rPKb35QhTVE5g07J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39850400004)(136003)(346002)(36840700001)(46966006)(356005)(478600001)(8676002)(6916009)(86362001)(2616005)(6666004)(8936002)(54906003)(82740400003)(426003)(4326008)(36860700001)(83380400001)(36756003)(316002)(81166007)(2906002)(26005)(82310400003)(47076005)(186003)(336012)(1076003)(70586007)(70206006)(5660300002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:13.2614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 774475b7-66dd-4d35-90c0-08d92c2ce229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com,
 Yi-Ling Chen <Yi-Ling.Chen2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>

[Why]
Some custom platforms use eDP hotplug events to notify panel
capability changes that should be reported

[How]
Add a DC config option that unblocks eDP hotplug events

Signed-off-by: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 ++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 0f91280883a6..33e83c033284 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -904,9 +904,10 @@ static bool dc_link_detect_helper(struct dc_link *link,
 	if (dc_is_virtual_signal(link->connector_signal))
 		return false;
 
-	if ((link->connector_signal == SIGNAL_TYPE_LVDS ||
-	     link->connector_signal == SIGNAL_TYPE_EDP) &&
-	    link->local_sink) {
+	if (((link->connector_signal == SIGNAL_TYPE_LVDS ||
+		link->connector_signal == SIGNAL_TYPE_EDP) &&
+		(!link->dc->config.allow_edp_hotplug_detection)) &&
+		link->local_sink) {
 		// need to re-write OUI and brightness in resume case
 		if (link->connector_signal == SIGNAL_TYPE_EDP) {
 			dpcd_set_source_specific_data(link);
@@ -1501,7 +1502,8 @@ static bool dc_link_construct(struct dc_link *link,
 		link->connector_signal = SIGNAL_TYPE_EDP;
 
 		if (link->hpd_gpio) {
-			link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+			if (!link->dc->config.allow_edp_hotplug_detection)
+				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 			link->irq_source_hpd_rx =
 					dal_irq_get_rx_source(link->hpd_gpio);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a70697898025..6470eee8e212 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -303,6 +303,7 @@ struct dc_config {
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
 	bool enable_4to1MPC;
+	bool allow_edp_hotplug_detection;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool clamp_min_dcfclk;
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
