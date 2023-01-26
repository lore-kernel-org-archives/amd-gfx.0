Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2A6C27C76
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D5DA10E8C8;
	Thu, 26 Jan 2023 00:36:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFAD10E8C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnOLW2oacvIop6+faZvFRdw5mVCR/6dlx56RFVmGwjtRM0Wf1mCvCDH9tCALohDmL4BkXrU7xrTD1lhHpJN4fzyec4qgjsULKBZzddO4JIY/p/N8AbJCMNbYuSQA8Wkj+Q+IQpZ8ac4rRqaKsUZrOW3oS+MwNzMZngw5p26cNfD8A8jheJoD+Ea5bPZ3JU5tnUQ7eHtu1D9BDzkGcTLLl86cASTDkjyuuLdQPL4lqT2iq3sK3ZIqPdaOR8uJkrgXtrM/1vMpKw7UP/Oqqb5qd3TwqMZkP6w5bGGFzkdg14g4mgmBgJSxz3rfj4wFTHIpwN4hDguTXJmCDb8WQCC1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mat5ovgzeUhB8jzbp6y0gNovQTHbZ/mjapZwUqaK9GE=;
 b=FO4X3MNYzvRrPfFZuXbO09y8vwVx5s6VQDMpqH28BezYZdcL39qrFf+Pual5Jem00+RaC38ToIi+5PtapKNeuy93+nogsQZdNr5/YD6XH8hEpOj8wO3RXVAfouCCTtDStEFQwJEC+sirB/+z9zS9LKsT/qmGy6EEjQWqF5joX+7AnyS8QKB+qyi5uz2JmD5qT4swboMItKzPXAZMd/z2IzuX/Zk4Ax88Mqeeqt3XAT5PxwaHKFOhZXQX3AqDPt8oPgoR5FnJjp4Dmd5VHAoIrncuPF/V0ytqxKQf5PhZQjbJg0DlXPxBmcGzdLSDhpgvKXTjA4ijvSNY2UTZgvuw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mat5ovgzeUhB8jzbp6y0gNovQTHbZ/mjapZwUqaK9GE=;
 b=hJFh4Rcd8d2Y+gdQoXV4Ymwz6LzAtsQUg7XCzksEUo9+MnY1kCWUQVBAe3V4jMw2qNBoyOSwFfe1LIDmkYIlIzO5/iy+9KI5TxIONKcBw1a/LVPyX/BKtTmF8Bum61pd1E+h1AvFjJyQayckvAqk5+tyGfcryowc3iZb/rQfZFo=
Received: from BN8PR15CA0032.namprd15.prod.outlook.com (2603:10b6:408:c0::45)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 00:36:13 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::45) by BN8PR15CA0032.outlook.office365.com
 (2603:10b6:408:c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Thu, 26 Jan 2023 00:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Thu, 26 Jan 2023 00:36:12 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:36:10 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Add Function delaration in dc_link
Date: Wed, 25 Jan 2023 17:32:26 -0700
Message-ID: <20230126003230.4178466-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|BL1PR12MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: fed5858f-73b9-42e9-675d-08daff355353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKCQSicGRN/BGQp6MGmvy4Guahte+1yYMDkRa1ssSE1mKIecZ6KOL4UePYWL5t/oHjqWMl5ss+CoxIcfiO0uQzYZqjvInFZAzjJkxtJ35qgiUUqohayvogDHxvbuagmQ6Dwui9+dw+kxuhl0pToYwqa25a/V4AgRg5G8uPbvlczWKgD4fAb6/roJaXbDM9OnfhJZjPHCyIGwmJa809YI4ns6f6s/13H0tA5tJ273dYG2PMq42LntbNu5H28BJQXtbPWY26PT+/Ri0kparE50SlvHbkjKQjfd0ij593FMnw/c9lN5mmV4MHBDkgtjgp/JfxReHlcMFUYj1LALo9fercW8oxbm9nzC+N8P6kWzOa/KQBUXTHPclG+YLSPFk/OAIhx71nBY3aPmcboKyoluQ3UvywQtx/XBql5zjTEIPqhitF86JHyN0RuFlWCXL/FKXf0UHE9pTF3tNouf/900UylfyumDniX//0GpCpPpFs0zaSaQsmo4qwIWryP/ktVdg2ry8xO3Dg28f0PI3n3Y7GhWLzEclHsFe8ivU77Qq5CZ5CMBteee1KbMWTfRJAAKWA6OrBMi0AeN/AUkX1zZ0P3sAPlt+KRF6ZZ17c5g1qxKBJA1gPAea5ruLK1IqsV1XFczBsqX1d8eIUjlcOXCLwCNah9YaZmQ+qFntFFLze+zbP7u4It4cEulHhYIfiMPdZocT9RJHqNvlM2lEn28ZKzXyWqUq0dnF9vW/5M+Ln8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(6916009)(41300700001)(8936002)(44832011)(5660300002)(36756003)(2906002)(82310400005)(40460700003)(40480700001)(8676002)(54906003)(478600001)(4326008)(7696005)(70586007)(70206006)(36860700001)(47076005)(81166007)(356005)(86362001)(82740400003)(336012)(83380400001)(2616005)(316002)(426003)(186003)(26005)(16526019)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:36:12.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed5858f-73b9-42e9-675d-08daff355353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
Housekeeping cleaning and adding declaration for
function to be called from DM layer

[HOW]
Adding public functions to dc_link.h

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 27 +++++++++++++++++++
 .../dc/link/protocols/link_dp_dpia_bw.h       | 24 -----------------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 1927eacbfa71..85b57848f5cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -627,4 +627,31 @@ struct fixed31_32 calculate_sst_avg_time_slots_per_mtp(
 void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable);
 void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
 
+/*
+ *  USB4 DPIA BW ALLOCATION PUBLIC FUNCTIONS
+ */
+/*
+ * Send a request from DP-Tx requesting to allocate BW remotely after
+ * allocating it locally. This will get processed by CM and a CB function
+ * will be called.
+ *
+ * @link: pointer to the dc_link struct instance
+ * @req_bw: The requested bw in Kbyte to allocated
+ *
+ * return: none
+ */
+void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
+
+/*
+ * CB function for when the status of the Req above is complete. We will
+ * find out the result of allocating on CM and update structs accordingly
+ *
+ * @link: pointer to the dc_link struct instance
+ * @bw: Allocated or Estimated BW depending on the result
+ * @result: Response type
+ *
+ * return: none
+ */
+void dc_link_get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t result);
+
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 58eb7b581093..832a6dd2c5fa 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -44,30 +44,6 @@ enum bw_type {
  */
 bool set_dptx_usb4_bw_alloc_support(struct dc_link *link);
 
-/*
- * Send a request from DP-Tx requesting to allocate BW remotely after
- * allocating it locally. This will get processed by CM and a CB function
- * will be called.
- *
- * @link: pointer to the dc_link struct instance
- * @req_bw: The requested bw in Kbyte to allocated
- *
- * return: none
- */
-void set_usb4_req_bw_req(struct dc_link *link, int req_bw);
-
-/*
- * CB function for when the status of the Req above is complete. We will
- * find out the result of allocating on CM and update structs accordingly
- *
- * @link: pointer to the dc_link struct instance
- * @bw: Allocated or Estimated BW depending on the result
- * @result: Response type
- *
- * return: none
- */
-void get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t result);
-
 /*
  * Return the response_ready flag from dc_link struct
  *
-- 
2.39.1

