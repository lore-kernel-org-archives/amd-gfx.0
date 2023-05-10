Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4195C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F42910E522;
	Wed, 10 May 2023 20:49:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81B910E523
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy+jMbcQpxdjeyHxeMf8d94opIfzTX7mPLxgBgIwy6nJpEdR8M7w4xiM0JASoQf8ARUQ3WWvwByk5JvBo0iFYBJ2YG6EcCQK9B4Bv6zIJrlmxOyARu2xQFcK4DoMmMBHKy44C0unYoOz9I+bWCA0QiUxWFi2RC+dqujQEjNYSuWfhDmycLKZ28MwjZIfoWfSowJ32+O6tXHrFRq3zRihfg+iD4Ll856vuP5cECk0JS9WHT5XlA/oLp4GRPoqOP9TlcC58uSCqbjqwmzfKvI2aije0+g1ZB9+BQ67gkXzD5Jc6CZcmEamD74wsqJ4+U/YyU6ACUKBf9tKtprlN3e8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um4GVFNd+9c+WeEcmtL/kjRG0WCyapSmHtvHM3fnOJA=;
 b=LcqdaMXOzogJuXhaQGBousVPoxFnzQMI+xh7gGbElCQQxXjANm1HcW58hnLbV5W9JauwXG7tul7jVvjWW5NmcT6Ibvdowbsvt05lS8iMmy7T6SLQp9yQGEHsBcH0L76mOsBsLAW9Rk3XWaKxJhA1qGe/fE4QboTx6wA11E7tYFftWUdx5kl8PESI7ZXM6QjeSGMdvHYWl4iyBf+x/p+vtHcR3vjlcrhGqUuObzEx0CP9jQTRXosyD846mZfnfh4wh+mcZGh/9GbSjteumjsWUiEvtL/1NtZeyUeGEvAAeYlgjxJCyzam/LaXHFnhjswZj/HDhfWJd8Q2wBHK+DmOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um4GVFNd+9c+WeEcmtL/kjRG0WCyapSmHtvHM3fnOJA=;
 b=sgLXmBptuzTjitsdJjGjVJuGUNSqryMME6nqNgCop4LrK3v6eWl+Yq6p0qxPdfysQ7dEX94M4x/L0JQSbxVPx1A3+RPC8nE1JMfmQ18Y0qU5SXhw9bW73gziOJ6W0s7W8WKP4Q/hBnNOAPkjYjraAcSJoWRrW+RLsxE4r3gehXc=
Received: from BN9PR03CA0744.namprd03.prod.outlook.com (2603:10b6:408:110::29)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 20:49:12 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::71) by BN9PR03CA0744.outlook.office365.com
 (2603:10b6:408:110::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 20:49:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:11 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amd/display: Convert connector signal id to string
Date: Wed, 10 May 2023 16:48:54 -0400
Message-ID: <20230510204900.949963-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4e6005-2c61-4e44-000f-08db51980228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwSFEmCDYWHiHo1Bmrrcfx+miMSTKR1uiLkht+VXdwyU48temU1vV7HgyKuXmL+5e5HfsfIxpW7LBoS5mpgn7Pa24lyu6H621F2fzBD1aLfYdj5GgdlRgQ68N6zRA9mtW9UqDtHhM808ttiJeg759g82B98WmdnJdy+hoZy2klZq/0dcr1lrof/M95tv3lGmzDKHT/L1Dhey6hj5AOGWHf18qZITTD0y3w0kOOsrr/hxZzhVAq3CsFAp43hFyJzgRdhQz7mVzqkW6j2y8clTqHxFXJi9/1zcawuPFBirqRezUj5ZxTPe5BHEjp8CQU+bxcw+bZ4xGkYK4oeJUrnIH+MRA3hiSs1PNMirZkh9FCkCIUDRKeLpXlGThEzxJtxhYhRkvNJT1LB+Lzh6IzfzXJziJH/8uNqpkWpo1UdDwWC+WR+DjIuTktErPh8ypUy8VB6CXGT2V0tJobfNPNo1gvfi20vcI7MIUJUJOr2ohAkTQIKI9Ts/Y7GIPcohfqax6uxBR1GXTRwE4AT+ms4zE66Qw72Ne7GcZ0hlhEkWZyK5yKP0nTnO7/r6Pgo6Huhqw336p3r/UA7atKDmHw7W0Ii83iSzpTQVIzygRgh+NYbrc2m9wOaoGSPcTVTIUThhnuHvnTrX+S4z+F+7+L9szaUkeRgb5jzAxFUmdGDxL50FfIY+GFTgoEcAG6Z9RFto4Lb8UG62DTN7J4hCTRl6RlAY7OjGxa8NeXtWhLH+iqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(8676002)(82740400003)(47076005)(54906003)(8936002)(41300700001)(83380400001)(316002)(5660300002)(70206006)(70586007)(336012)(6916009)(4326008)(426003)(81166007)(356005)(36860700001)(478600001)(40460700003)(2906002)(44832011)(2616005)(36756003)(40480700001)(6666004)(7696005)(26005)(1076003)(186003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:11.5643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4e6005-2c61-4e44-000f-08db51980228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
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
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com, Jerry Zuo <jerry.zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

To improve the readability of the of the log, this commit introduces a
function that converts the signal type id to a human-readable string.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../drm/amd/display/dc/link/link_factory.c    |  6 ++--
 .../drm/amd/display/include/signal_types.h    | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 1515c817f03b..ac1c3e2e7c1d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -563,11 +563,9 @@ static bool construct_phy(struct dc_link *link,
 		goto create_fail;
 	}
 
-	/* TODO: #DAL3 Implement id to str function.*/
-	LINK_INFO("Connector[%d] description:"
-		  "signal %d\n",
+	LINK_INFO("Connector[%d] description: signal: %s\n",
 		  init_params->connector_index,
-		  link->connector_signal);
+		  signal_type_to_string(link->connector_signal));
 
 	ddc_service_init_data.ctx = link->ctx;
 	ddc_service_init_data.id = link->link_id;
diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index 23a308c3eccb..325c5ba4c82a 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -44,6 +44,34 @@ enum signal_type {
 	SIGNAL_TYPE_VIRTUAL		= (1 << 9),	/* Virtual Display */
 };
 
+static inline const char *signal_type_to_string(const int type)
+{
+	switch (type) {
+	case SIGNAL_TYPE_NONE:
+		return "No signal";
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+		return "DVI: Single Link";
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+		return "DVI: Dual Link";
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		return "HDMI: TYPE A";
+	case SIGNAL_TYPE_LVDS:
+		return "LVDS";
+	case SIGNAL_TYPE_RGB:
+		return "RGB";
+	case SIGNAL_TYPE_DISPLAY_PORT:
+		return "Display Port";
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		return "Display Port: MST";
+	case SIGNAL_TYPE_EDP:
+		return "Embedded Display Port";
+	case SIGNAL_TYPE_VIRTUAL:
+		return "Virtual";
+	default:
+		return "Unknown";
+	}
+}
+
 /* help functions for signal types manipulation */
 static inline bool dc_is_hdmi_tmds_signal(enum signal_type signal)
 {
-- 
2.40.0

