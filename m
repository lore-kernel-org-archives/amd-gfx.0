Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C034EC636D3
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CC110E2E7;
	Sun, 12 Feb 2023 17:00:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157AE10E2ED
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGf8rwa+Ll6hi92+h967NVh0dMXs2EzPZNZ5IDep532OMKq19WFahNpbDiQJGgYwhfvMXFmEZtuj5pr3rwgWoKwcpi7unu/qzMZ/4bnzAfXzabFQjtLJWitL/2/eEML0jLHg5NrNZGqzfViivwgKh6WtuqHR7bADOZXAOnOa6QneAHg/LvyeFTGn6bt0/YyX1AtxCfZgl1riv+34DpazblaD0uXShUPCCEsJUXenEwlPCDanI/QtUP2dm5wEdYPOCAJA/lf8kdHDQNV46mAtQLkNlStRkKWMhuieDiWnybIsDEwWrYN9lkT1EZwPilDSmhsf8DfGmMbLYuysIuyBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c8wku1vZvNDjT+3evDfAe+C1NXH7NslhtF9k6LxCeQ=;
 b=Z0KqvwgqDY76lNlx3D0AtzyaMLXFQBcyvGLcxFAVaRSOH4q6U5a2TO3N1EqNiHP+Z/9RUZU5+BcsAlki/xLlNd+CskUmwtCqRJCvrsO/Fodkf7xiBxPVRuuzeF3nSe7sQ3uiQqncQyGHIxodABYe0o2C2dmzaV03rhQkSHBs7OzOTm6deFvU7JnztbxpanCy/OiETBNAOkDxf/1Ir2NPdWn+Ag4ezGZqByT1NRyGMluwSZ3Z/qNsKXpiVXi+Jho9MimX6S+wa0fOucAptEKsKRzku0MBPGnBlLctSGw3rwanwfAGmtUgHCNCz6KezckOez8zBQu5APzf/jHYUCJi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c8wku1vZvNDjT+3evDfAe+C1NXH7NslhtF9k6LxCeQ=;
 b=BiseFU9k/KnXSEIDLd3tLtM1CB7JYfXoL1Vcv6d6yJhdQby7Uo0a0oJVIGo5k/B+6JUYAw1aI6dhAEKO7eGrf9Bq/8JakN27NW4hnj959dcDypji+M1p2XYl/hJ4fRHGQEpmE6z/7lIAvjQy3p+xv3gW092MQtmJC2amefZ5txo=
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:45 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::63) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:41 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:40 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/22] drm/amd/display: add NULL pointer check
Date: Sun, 12 Feb 2023 11:59:44 -0500
Message-ID: <20230212165955.1993601-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a230646-c965-44f9-15ea-08db0d1aae9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnPrRST1SO+Tn/lE79/cKryPGaMInK0Cyt293S/Lj+Whv7l4PCWtgmrZZHx1RzFtsunlH0NguIehtI9/hAlQa/cRnri3bCSSD3E2pnbAWABS1fNTQnS9V76dd5GSQq1i0Vm8bj7aTdHWog9k5Cuw9yZbvbZX9tu2P1Hveu4Gkn0vky1X9Lxm8lf9i3eRRrbwZ1hCCSeMUBV/1PHxM6EjE6whrue1/WLCw4Z55cJYiX1B+fCT26XEaHPBGsFW6OupPB5U82AvuUzGKHu1aD4sSIRliFdrr7Gx3zxk2rHfNfI+lVdGF9dkcEzxoGjcY+96uYeLo4bVTacM+GB2WTSQKQFFQWAWqkDvhzVfHsTerjhnxn+wHkbK7oH9PHlBk+JR3qKLHStrLrYdCuw8oCjPLS6XlStgIc7jQkZSgurRXU10oe6jLaSb7cid9MRtU/WXOTTw+i+6QdK66iU7tcBZ2z9Y95CyIIHUDKW4RiTh9qS/B0STytrE2rCmLdFzPdMU6w7Qe0v8l80woXjDTLohikKyTX0Z2Vm3oSL5dqoTC14+wMJFyeRr1hgDUdZfqB1NmB0iC5FQxdZ4pwUVG67QJYjQ8hbqqt6krfyhiCpz8HoA1P/OPj2wWh0tikm3fRQ2+LCYHUZVKvtTG93sRJP3KwhrL+6tzhVL4+daPITEvTdUB+y1D+Rur6427vI0p185a0rG4bqiHXS2Jm3uOqxdAPAjdR0et4YAXIYAMHoorwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(41300700001)(8936002)(44832011)(47076005)(426003)(81166007)(36860700001)(82740400003)(82310400005)(86362001)(36756003)(40480700001)(356005)(40460700003)(2906002)(316002)(54906003)(1076003)(26005)(16526019)(186003)(4326008)(6916009)(336012)(478600001)(2616005)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:45.2051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a230646-c965-44f9-15ea-08db0d1aae9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Hansen Dsouza <hansen.dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[Why]
In virtual link use case, link->ddc could be NULL.

[How]
Add null pointer check to avoid undefined behavior.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index acc7e40e4383..a1a29c508394 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3223,12 +3223,16 @@ static void dcn10_config_stereo_parameters(
 			timing_3d_format == TIMING_3D_FORMAT_INBAND_FA ||
 			timing_3d_format == TIMING_3D_FORMAT_DP_HDMI_INBAND_FA ||
 			timing_3d_format == TIMING_3D_FORMAT_SIDEBAND_FA) {
-			enum display_dongle_type dongle = \
-					stream->link->ddc->dongle_type;
-			if (dongle == DISPLAY_DONGLE_DP_VGA_CONVERTER ||
-				dongle == DISPLAY_DONGLE_DP_DVI_CONVERTER ||
-				dongle == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
-				flags->DISABLE_STEREO_DP_SYNC = 1;
+
+			if (stream->link && stream->link->ddc) {
+				enum display_dongle_type dongle = \
+						stream->link->ddc->dongle_type;
+
+				if (dongle == DISPLAY_DONGLE_DP_VGA_CONVERTER ||
+					dongle == DISPLAY_DONGLE_DP_DVI_CONVERTER ||
+					dongle == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+					flags->DISABLE_STEREO_DP_SYNC = 1;
+			}
 		}
 		flags->RIGHT_EYE_POLARITY =\
 				stream->timing.flags.RIGHT_EYE_3D_POLARITY;
-- 
2.25.1

