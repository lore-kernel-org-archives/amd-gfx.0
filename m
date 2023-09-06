Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531A1EB8FC0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C764610E637;
	Wed,  6 Sep 2023 12:51:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F6110E637
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfN+ksGgoxjjs6edVKbfcO/7q6WFACvtkG+GMoUKhy7j7hwtVdvjrdcmwdCKxpkGxM8s+mXxbfWPpq/nICYU2GCbRzrXn51sLWk7nPMCtLHJ5jFBMVrS+/0QNMUeXyhoErm6XwygOpWXTy4qbi/+28iZghnce9WhRDQ5v5LWg7hghYRUre8ond9hb+oQBAVPiUudy4tbc5p0VPQewmkalT5hbxvm6yeoPbgY4s86eZy7RJ2i4XYbEk3ZYyjYmkWwrw9F3NhfWuiIsY2sgLpXCkgYRl3is5M2OfVILE48uwd7v9PDxI5LVrMJ/dYVWIlnJET+Hc3k4d0DY7MsNWuiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TfeDOpkxRSOcwqXXMlNKgKVM5PABUXXkOB4lp5+L04=;
 b=KfpkPRCdnfK1zrJPVx9QbrjYOHHXWFzMxDt8naqZw6f6UaSIV0TWg1YRke7bcnXvqqM5dJNsourAymyeECJCJ0UWADa5W/jWjXyaInkiVEXUGkge2u0lKa7VhZwciBfTi1uWDYvhbupKQM7PUxVAIFADpairCOJRxSia+e1VaOcowgk7Z0supUsTG5yMNgXj1fAV2+2HYqWDufwx5FQ21W3HDl3NQ3+VMNAQxCXqiznrORuN2oh9f/lLEbFLE1IIL3jVod7MN/NHbDjr9R06L6Y3KTUrGm2rtpVXzsfLj0QrSHtxxJnNE/DbygYPrRnFVXJQJJ8YpGQbru7YcVXVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TfeDOpkxRSOcwqXXMlNKgKVM5PABUXXkOB4lp5+L04=;
 b=0LqjN1ZWHFghO45LEcrn+ql6KPMagT0/FBynrzSv/Ai6ktC1vZotPOQOIqThETdPdJIFr0G7d4Ec1zJElqrFfUvtji+ACCy5sV0K8XXZ2FVJSDEyaXW5DZtVU1NV+57Gly1gIBni+0jmVFyBDTKb8IlcxzJbMsmsEhRAnqnEi+w=
Received: from BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:21 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::66) by BL1PR13CA0270.outlook.office365.com
 (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:21 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:50:33 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/28] drm/amd/display: add dp dto programming function to dccg
Date: Wed, 6 Sep 2023 20:28:22 +0800
Message-ID: <20230906124915.586250-18-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM8PR12MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaf3f55-9d34-4f2f-67c3-08dbaed7f88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYnEyOxcbP9hsGN1xqrGKjEyE2/W65gd7aoXOIbMgNsJV8nI8nRa/ajJEEgXPmrwRkVr+B1DZ2MdNF45CsCYWeZ+g9Jb3zy2NaW2iLlomo4WPnhipojiWZezdgwqoOFlqg6AqSoh32C0o6+35d3bUQ13RnOAzDqRSKz4norjH6aXhdE7bDYH+ckJsXIIpj+pjW+Bj94qS3tH58LkoCgCHf23/dgoix9EwIWH0Q89uZHt9giQTlmf5YkcpSDw1Pjj4EkInmo5QbJoTBreVDHw2P7Bg96Qd9Q7Mp0hNf/+DfplEo4zLYS5TPV+8X1PgUDEg9e2owQocQ+4bJlJf4L2Sioqcu6GnaX8bLnuZ9nKyoAzM97L/ACeAIUVzvi41ArJ1vs1host/bO5G4yOhuSuA1crUnLzNlbP9A4LiqSxC4zdrOrRJTwL+tu1k+PW30TnRz2mbS533MTYIXNX27RnIUoW+bs5oJVqbGjPoR80H8g3Tp7KH6HbvOhByd3KMsxCG2Lc9mwPHlp6xfyamDI0AwuFgTSr/I5xGNrbi4KORuHlvlH0gQiYs4CcyjOh1LVvqiKqdrvM6fmTwa6WvNbNLF52e63x10lTQxwXiIVmykiiVxQcoEyekD99RPiYUooC057P4xlX9BO22A4Ixk7dPlfzPwtiNdvP3D0N43JV3u6HzoCYo1jHR3sXpfMlKDZbOqdjrerqVwMgeWKu2UmxFqwzJqxV5U9wXLK/XJPFrzDuMI5lV+QPH6CaqzN5+nBs0t5eUyWlB1Ah/Ypkm8Pwdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(1076003)(336012)(426003)(8676002)(44832011)(8936002)(4326008)(2616005)(16526019)(41300700001)(26005)(5660300002)(36860700001)(47076005)(83380400001)(2906002)(6666004)(478600001)(6916009)(316002)(7696005)(70586007)(36756003)(86362001)(70206006)(82740400003)(356005)(54906003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:21.3585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaf3f55-9d34-4f2f-67c3-08dbaed7f88c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Add support for programming dp dto via dccg.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index ed8936405dfa..75cf4ab8ae3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -34,6 +34,7 @@
 
 #include "dce_clock_source.h"
 #include "clk_mgr.h"
+#include "dccg.h"
 
 #include "reg_helper.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 3e2f0f64c98c..65bb7cd05385 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -56,6 +56,13 @@ enum dentist_dispclk_change_mode {
 	DISPCLK_CHANGE_MODE_RAMPING,
 };
 
+struct dp_dto_params {
+	int otg_inst;
+	enum signal_type signal;
+	long long pixclk_hz;
+	long long refclk_hz;
+};
+
 enum pixel_rate_div {
    PIXEL_RATE_DIV_BY_1 = 0,
    PIXEL_RATE_DIV_BY_2 = 1,
@@ -182,6 +189,9 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			uint32_t stream_enc_inst,
 			uint32_t link_enc_inst);
+	void (*set_dp_dto)(
+			struct dccg *dccg,
+			const struct dp_dto_params *params);
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.42.0

