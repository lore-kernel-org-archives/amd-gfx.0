Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D218C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D304210E40D;
	Wed, 22 Feb 2023 06:42:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA3F10E40D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlk7GBMOkdoxm09QCBpIZyYWZvMtvwYRzYVOR5Zl3ut0hSC+TDbZWapLgncLCI6cKn3Oxz6cpH5NXLLjlwze9tpvKyLz35G8yxv8HtsFeAd1QWHAEAVgfmvUmwEmShRKF2T/Ed327HhH7KJ6iBGbEiAwhC2nY98X20Op3dBc+WQCieyMln17+DOuOsvIvsGMrpdmDMjv3y+PsWVMOXlySp/SIVoNynbTsUiQIIZWxajLP31u/POGzp09nYa0B9ytr85gLk//NEVIEWebloOnB0g6pLqdhQVDL08v99yYtHV7FoUvIElrwuNNpJZnb9FLnsxBmsN8jcAUqdVJpx6fXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYNbXng7CFfdBNdAhLBCXwLyOy1+wF95xWCJNyTfvXA=;
 b=JGSSzwq7fi2tTBG0+QTp4/ERcio91PrLEoNo4dbG78ecNqn14TNQQ2Gy1iwAiNxIV4XvDghFf6tNCeEmmftQV2FNWKdEqvcMlsl1UWTRjTlLqZThjmlHDtsVhQL5ymZlZw0spSmShY6H0++bp3uwNXQblgJ/skIpP8pLjkFa8yfZd+/Sr+Tgr5+QeDio91wIZUf8TEfABzuTJeHJptClxVFysbDgjx6U0+BksSS8yM2A+Zue+F8M6kkUN4AeeXfpfrnomUJMYXHu6kIqk9UlIN9Ono8yGGIU3O5kEDeuM3K5eA67apNlhiOeGl28OSZDe/9h0dLmQ8bk741wszl9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYNbXng7CFfdBNdAhLBCXwLyOy1+wF95xWCJNyTfvXA=;
 b=d2cJvtD+kYUtCyLSaOXVQJM2oT6o+4/EEwtkiQ/ZDS2EcnogWxRD10dhvsqzHWK0X9abky07WxT5cHUP0l+Ri/gXYpltXqX6rcu8fcKTFoUB91JH4wk7JYCRyKq+BDs+G9xofn0Hz3oEaMdirTXjfUXSEfMIFC82tJxuHlWVajQ=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 06:42:47 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::71) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 06:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:42:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:42:40 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/20] drm/amd/display: Update BW ALLOCATION Function
 declaration
Date: Wed, 22 Feb 2023 01:40:35 -0500
Message-ID: <20230222064041.2824-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d096b08-bc25-496e-97f3-08db14a0029a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlAx0//xMTGql4AsCBhwyO7mohdoYxLASnurXbASPVrGh9QyKDRmhuQk4ljSwc7Nq22r5W1HSf+eDwgG77B/KaBRZpFfxy0MoH/eSI6XEIh0Gx9Dy93Xep/BOEe2Npwmgcyk+C5sQD7sUFnNMiq0r+MEodQSYmALEQC/WtZ5PXZpNJxFY6ZScMM7tt5CaTC9+nAzDAet4FXDOk5Fug4Qag5u5AJsKJa03kBtEgxEwh836q6jl1Y2jzgsVl0jmO9Mnq03yDcvAPJl4yF5aXeVrTwNCUUuddjeQNaJ92k5TzJzwxAMlKBEFXtsgpWpmjcMlFBRV1I03S7TgC5Gf89CdGVn1NPunZC0CPqxi9lX7tGxJModu5ek//AENp9CVt3pX59bojc/kxuU8J7VhuMtXVU2q96NyHzfDHPt+S+aDfFb5a2r9nlIQbJdF5bYi6Z0xRN64xgmhO1a4A8itMMWuPeXsCCwFoYFSHAbxIRLo/zUiEZLCGO7map+OzwqPCfCNX/jtOTSg96hgDiF8+HHmwuipfn5GHQLLK2Nll8BG1K77iZcgh0tDqTf5hxCIVJm23o4phCsRiZomEnzJq+F29AJztOCoP7mZ5sPeD6Fo4J21oPBFCw3akFeFQjHB99FDs1Wc1qcL1OrfTELTJlJ8NQkLP6B8TFOC0rrbcyCumvXXZmmykTSSVWLK/ryQ1Vr4F2kZAPNXZZmNn3LGBpvPFfqzh+E/JMwnR7pJP8pOyw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(316002)(41300700001)(16526019)(186003)(26005)(40480700001)(36860700001)(47076005)(426003)(44832011)(336012)(8936002)(2616005)(356005)(5660300002)(54906003)(1076003)(478600001)(4326008)(6916009)(8676002)(40460700003)(70206006)(70586007)(82310400005)(36756003)(83380400001)(6666004)(15650500001)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:42:47.3284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d096b08-bc25-496e-97f3-08db14a0029a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY & HOW]
Update the declaration to give a better idea of what the
function does.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h                    | 6 +++---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index bfe0f6877d9e..80e18c770cda 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -549,8 +549,8 @@ void dc_link_edp_panel_backlight_power_on(struct dc_link *link,
 void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
 
 /*
- * CB function for when the status of the Req above is complete. We will
- * find out the result of allocating on CM and update structs accordingly
+ * Handle function for when the status of the Request above is complete.
+ * We will find out the result of allocating on CM and update structs.
  *
  * @link: pointer to the dc_link struct instance
  * @bw: Allocated or Estimated BW depending on the result
@@ -558,7 +558,7 @@ void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
  *
  * return: none
  */
-void dc_link_get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t result);
+void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result);
 
 /*
  * Handle the USB4 BW Allocation related functionality here:
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 9d3df69fc340..72ff0ae44d01 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -300,7 +300,7 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 out:
 	return ret;
 }
-void dc_link_get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t result)
+void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
 	if (!get_bw_alloc_proceed_flag((link)))
 		return;
-- 
2.34.1

