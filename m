Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6293AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69D910EE8C;
	Fri, 18 Feb 2022 15:04:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2ACA10EE8C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnB9kVxQa/zvMakhCOhgvvu8VcpHT+tI0AsfiNJPkvu7sYEYCnQ/XN2imDKxmQJDQqd4ImUnAB0ZvPx24HqquxMnDgjKqL1puMhm4R9VpXPjwiQRgsyfTpmMdXLMnkPk1thUnx2SdXh+sTuv2bOoWufSDRoD4J1KgRFxp6f5b4GoYd6CSzinqcrCeJ+QAbh7KBkVf7HbrSbO7ndE9UKc8nEiCqYlMbf6uLGt4oGbczWK8tlfGip8ey+nhbW9FfL3YBmepe62hP5/u6Tmw/VGPgs+IQulci9/WvbJQophsRBCgXSVvDhDeUtyjk5O7MnOLE1ALkpDUq4xlRYM9kPjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLV4SNtY3thSSyovDu7hleR8+yoNpsuCgiR15+LXXN4=;
 b=bo38N1GqDbau9N4hdExTClmKjyo2kSE+p0rEoe+BtRLTulh7NztBTlXXaSmDI/5KvxYpdY01PRDQF+xZTOVs4xB3pyrOcx+nf7z1YYuheTLyARv1F/U6K+HhGIJ38+SHt13I6rmkbzRYD9gzyHerjHdavDEU/KwxAVdCoBNrRSg7JcrKasHS7NZafwxwq/Y95vmub+/nKkBCt2Ety3oKjD0bycJmmmc/AJPPIrzxe3k6O9C9iA3KU+jZ4lt2yz0WAA8xMTzmeu6SI4UV3+oo+voYnKVEYhhIw46QICA4ePKhxOcRV2Cm/TdcADhNvoWWqaluQ5jH9jxasRso1rSU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLV4SNtY3thSSyovDu7hleR8+yoNpsuCgiR15+LXXN4=;
 b=huVyMXi36817X2eJiApz8HCLVaYQn+UgqvEG89npag0L/Q3mRNPM1u1NqqqooDsg8IPAQ7aA7gt4xOj0UOacPm2G4ByrJALs9aT0SXoO4FUpgnuF2PDxmyYbfF1LKXbCXo6lY91ONXqTqi2hxFFvWr7tYvvhM4rEdUc+6RS1ywU=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Fri, 18 Feb 2022 15:04:07 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::bb) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:06 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:00 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: OVT Update on InfoFrame and Mode
 Management
Date: Fri, 18 Feb 2022 23:03:18 +0800
Message-ID: <20220218150329.7976-2-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c584f0f5-7e2d-45a2-e1af-08d9f2efe8be
X-MS-TrafficTypeDiagnostic: CH2PR12MB4150:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41504B9FAA2AFDFD83B27EC897379@CH2PR12MB4150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bMfIxoeJ3noV0SKsZBrpugdYvenGXRp7ImhgA7+CG1/K4Xo5ziCltAr3BAZIbO5Dl/jUFT74ENvlP9/XogC6PqnqILeBTUBCtMz1ve/qKG5m3wjoX2UkqJoXRFHkc/XzTgL+3vfJ4eN8EHi2YGGGi7DnL6hLUppaZlhWTvf/0IQT+3/kDBAkk9jhGVDRKL938+oJGtXstDBSWYSLXbzwiQvhLIfsjCFLE8V5mFOPiHbKMnzxzizGCHcvlU+xUnvA8i36pnoGEcX8vx09QTDLrsACgy88X+wVRA//FQU9wMroxWuvTJFNqztu4fAzssoJ5oKLHQVEyORATVyvUW+8Kx32ipf8TJMrHgti+6SFa0uaSskhTyFTEwSjbZDpWd4kOa75KuaIZYXJDvYmCR0n7dXmFJSLAeX6nZ1l46Qg1f4J8NwrUkxXIL95cGTpcWD32ZJKAZFjsWTn3i8H/yve582SfkCcuuulaN3gPTkOwtcTUdFDodKBkgr96FVvAfbBG2B5mZGOXuYfHJYP3jESCpx+VnFyZUcib3Y52oPK8yVUWB3qnZo09G+WGtIqkouV6JfA73GUXRBQrFnh4mYDEPoPxwdwjZMQpY83hxh3LZMF2ZXQeiY9uuquMMorCMl+C31z/HMM/qrrGlFyd8cJ4JK08v8hmkYDbSSOs6I3XexCEujO5e+eBZcgExpHbmLpsOvuJfU3L9XuGG3rY/hTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(7696005)(44832011)(40460700003)(186003)(2906002)(15650500001)(36860700001)(83380400001)(336012)(26005)(70206006)(1076003)(82310400004)(47076005)(508600001)(426003)(86362001)(70586007)(36756003)(4326008)(6916009)(8936002)(54906003)(5660300002)(356005)(6666004)(16526019)(81166007)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:06.4627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c584f0f5-7e2d-45a2-e1af-08d9f2efe8be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Integrate OVT timing from DM to DC logic to update info frame
and mode management to report the resolution to the OS.

[How]
Reflect RID and Frame Rate to AVI InfoFrame Version 5.
Define new Timing Standard for OVT timing.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c    | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h            |  2 ++
 drivers/gpu/drm/amd/display/include/set_mode_types.h |  8 ++++++--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a2a25d444574..8ee41f00f050 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2443,6 +2443,8 @@ static void set_avi_info_frame(
 	union hdmi_info_packet hdmi_info;
 	union display_content_support support = {0};
 	unsigned int vic = pipe_ctx->stream->timing.vic;
+	unsigned int rid = pipe_ctx->stream->timing.rid;
+	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
 	enum dc_timing_3d_format format;
 
 	memset(&hdmi_info, 0, sizeof(union hdmi_info_packet));
@@ -2633,6 +2635,15 @@ static void set_avi_info_frame(
 		hdmi_info.bits.header.length = 14;
 	}
 
+	if (rid != 0 && fr_ind != 0) {
+		hdmi_info.bits.header.version = 5;
+		hdmi_info.bits.header.length = 15;
+
+		hdmi_info.bits.FR0_FR3 = fr_ind & 0xF;
+		hdmi_info.bits.FR4 = (fr_ind >> 4) & 0x1;
+		hdmi_info.bits.RID0_RID5 = rid;
+	}
+
 	/* pixel repetition
 	 * PR0 - PR3 start from 0 whereas pHwPathMode->mode.timing.flags.pixel
 	 * repetition start from 1 */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index c964f598755a..46f66527dc21 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -766,6 +766,8 @@ struct dc_crtc_timing {
 
 	uint32_t vic;
 	uint32_t hdmi_vic;
+	uint32_t rid;
+	uint32_t fr_index;
 	enum dc_timing_3d_format timing_3d_format;
 	enum dc_color_depth display_color_depth;
 	enum dc_pixel_encoding pixel_encoding;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 48859d5fc172..30f5f7e73186 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -276,6 +276,8 @@ enum dc_timing_source {
 	TIMING_SOURCE_EDID_CEA_SVD,
 	TIMING_SOURCE_EDID_CVT_3BYTE,
 	TIMING_SOURCE_EDID_4BYTE,
+	TIMING_SOURCE_EDID_CEA_DISPLAYID_VTDB,
+	TIMING_SOURCE_EDID_CEA_RID,
 	TIMING_SOURCE_VBIOS,
 	TIMING_SOURCE_CV,
 	TIMING_SOURCE_TV,
diff --git a/drivers/gpu/drm/amd/display/include/set_mode_types.h b/drivers/gpu/drm/amd/display/include/set_mode_types.h
index 845fea8a387f..75f2c79492c0 100644
--- a/drivers/gpu/drm/amd/display/include/set_mode_types.h
+++ b/drivers/gpu/drm/amd/display/include/set_mode_types.h
@@ -84,10 +84,14 @@ union hdmi_info_packet {
 		uint16_t bar_left;
 		uint16_t bar_right;
 
-		uint8_t F140_F143:4;
+		uint8_t FR0_FR3:4;
 		uint8_t ACE0_ACE3:4;
 
-		uint8_t reserved[13];
+		uint8_t RID0_RID5:6;
+		uint8_t FR4:1;
+		uint8_t F157:1;
+
+		uint8_t reserved[12];
 	} bits;
 
 	struct info_packet_raw_data packet_raw_data;
-- 
2.25.1

