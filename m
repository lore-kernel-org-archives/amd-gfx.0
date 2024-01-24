Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F1EC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDD410F64E;
	Wed, 24 Jan 2024 07:02:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED5210F64D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsWyQg/HYuMXV0YO47ad7xCJVJys12AfuqZouTIb4tN9DTipx9ioXLgYJUwKjzPCxoh7aXDUNzvt4FOUL9A+9ag7qAfGEA6mY+5DW1fXms9C4hwT45EimYpC7BYvKmrDbTzqf0hiA3pmyu6Q3qEiTCyOdDuJI7KU1AA/nzhkuCZoGVpcKUtbcDPrGr9UZjrbXc28UHBpl+5K4pKGKHc32W1uEYtNYTNV1tPIwv8oB07ziMzsJBHtxOsqMJm3WmCveVNxNb7MwfiMJqeD4abzYvQ3R+WQxSdrNj2WzdOcWeBBg4S85+qfKF0H2xvfVHyAYZmbYNaEaesqjq0QTsJEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5S+4vtxErySudlml74YO8i+MUZgy48tntnvZxboemk=;
 b=NfyeNH5Yn4RhPpBydubsrTZR8OXZeTqpsZXG8DNCi2jDsNsZhb82NCI2rBTZ5q9byXAZyGw2ROh/yho+QxAiv2K1+UV5L5j8TgA/X9anfSUwrgP3Unqzrer/+GTukGWA6FaM56x1sD41EKtGRwYY0Pv0L1jbJFp1INM4UMYOJEaCRLJgGZizzmGTU/tgRK0/zzVcI80H+FmOZYN6fRX9kR+4S3B/kpIqt6wXzVE0hQCKlMOjQS9LQeBgOTzDeDl26MueFKqFP2oWsAaE9IypoxXQv84hNjdAUMpLbtjYLZ8X18jnq54pXqwJviwmJRPHZZ9yyVxkeXonHvD4TXZrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5S+4vtxErySudlml74YO8i+MUZgy48tntnvZxboemk=;
 b=uU9ExSRi8D3MwlGmWU/5u+3l1c9WG+dYGXM4hwXYrJKB5eGZ5F71JhrAod9jFKM8DSu0JIIfqBuJMs0rjRDdEO5+zGDHDIJ0J904lmU/eD9TCni8m9ZchXChAt4dETyLzgm4vbJVGg/q0iD6no7q3YPLOvWvi0oQkCXeeFXJ1zU=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 07:02:39 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::73) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:37 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:35 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/22] drm/amd/display: fix USB-C flag update after enc10
 feature init
Date: Wed, 24 Jan 2024 15:01:46 +0800
Message-ID: <20240124070159.1900622-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fea1ba4-ccf1-4048-88d6-08dc1caa73e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJ7C8G2SdLcwcBCxOERFAy1CDeehTVxNsH9rgkp+e7NDYupqgieagaMpYMAZpYxxuD94f4+rdb73twlxjBt/DjckQKJaM+U9/l0waQCeNWq6QcYRjTx1wx4PK6t8KwzH/6JYybPLbHswZyfSDFEU2UsoSxTuOnY7bZAOgoFB/SkTgCDyJKoj4FGaTkJ9XlWHqfRhe4yvOQZKAYZmdNl4Y8BE7E3/4q7V8aTzaWLs/5uScfNF5kcHps/Xhe+A8qPoPmkBEUMS6cMGYytps3tiSdACCcCEl2YFwMFGOJuorsvifqGiNc1QCoAIjgDZGtGLkBXLKq2p+YppZIVzYPVQqEJ9gyvqxpP7hBxqvnqEp2f7PlGDfbdRJrncV/8mwwb+giznX6SoAM4HN5bXKM4aBErWtVYUZunvUnhEAlOl/GWGTGAc8Eetvf27oDWWl598NRYqHqUjch0os+z3o4H2KenESGtFmH59X+wucLqL/8WN78e7jmGppzlZkgW54DV36cWPTNHz27APMHbtcDFO0yvpdlm0rDTUhpQnSao9zm9uZrhyt0a+Tzw/IRy9mJZnFQFI5RW6U9kKnDlotv7YCe1ty23OpHg10sGgASP3YlRLn6ODif+ctukBU7IXietO2AdqBvl9ErCOc5k3OLv7HJZZPLDpP4Tas1ueNhR2S43Z2AvirHDzAfc2lwdD9jbydgO3ADDyNeQN0KDPABBFqy8W8cpGLWCnzB53BRw7M1yaXFWdQJfnv72sXGwQzAHmC035sZLQHOOCl7drNGERCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(1076003)(6916009)(316002)(54906003)(7696005)(2616005)(70586007)(40480700001)(70206006)(40460700003)(5660300002)(336012)(426003)(478600001)(26005)(8676002)(6666004)(36860700001)(83380400001)(4326008)(8936002)(36756003)(2906002)(41300700001)(86362001)(81166007)(356005)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:39.2867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fea1ba4-ccf1-4048-88d6-08dc1caa73e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
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
Cc: Charlene Liu <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
BIOS's integration info table not following the original order
which is phy instance is ext_displaypath's array index.

[how]
Move them to follow the original order.

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index 501388014855..d761b0df2878 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -203,12 +203,12 @@ void dcn32_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
 	enc10->base.features = *enc_features;
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.transmitter = init_data->transmitter;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index da94e5309fba..81e349d5835b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -184,8 +184,6 @@ void dcn35_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
@@ -240,6 +238,8 @@ void dcn35_link_encoder_construct(
 	}
 
 	enc10->base.features.flags.bits.HDMI_6GB_EN = 1;
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	if (bp_funcs->get_connector_speed_cap_info)
 		result = bp_funcs->get_connector_speed_cap_info(enc10->base.ctx->dc_bios,
-- 
2.34.1

