Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23185C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4695012A900;
	Thu, 30 Jun 2022 19:14:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD1812A914
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXveTjRUqBySLNdnifUtNKuXW4LaemCtNlaFo7ZOBjmFkMLHkbjSQGPqjxy7qlla0xLOjCrbxQXA0vv8tKFry75gAqW8lt/f58eM3bdIQ8wwRSz0y1C8toCBeYpAjCvOgMLGSaC8tjg5dyBVtkTu3rPjxAunDRIKhHJPVjXyGffuLKAEiwPsCpThzEozYTs1rmzXHve2dOCgAKbqlVXq6vK/GQlXthadOrqr6b8ca05RvogpBZfMBiad5LwoiMXt9MTVjh+7M84yXoxV7TxyzGKh9LYruuVclxlSBgomiolRx31clFfa2nkJpeUzILbPuN12KcJu/SZ/H+qwW6CCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddzgsnm7gm6Z18QYJipU2tFpdAvs/x9XONmEerYIAM8=;
 b=YgOYsFh6nDnOySv0CliHB/Cla7sEhHtSCijILG9Blxo+u0CMBvviSP3Hd9MqbbQ0FmIQCwjKhdnS2bC6rdFBCYUThW7OqWh0w+Xl8OnJw6mZE/wMOukypfPSUAxE9yGNeHL5v5CmhzfalPGPHwWY+jBeYCxuFMc3i2xgCTE2wBe6VJmpXIsdurp2knmCKin31S15sSt4PNswSF9K9mxcYNj3eaRSjRkeBRxws5RcRuSYq94quJdnG+VCRb6sEjIODaS/WwnWPzgrsMlPnnqSmzdL25qechcdiZlRbheZDnZ43t63UmisYce+bsVYY4p8y5ytjOyR8dTao9f6xdy8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddzgsnm7gm6Z18QYJipU2tFpdAvs/x9XONmEerYIAM8=;
 b=mZCttCruV5DbCg1ejLABHUS6z1bQGBHeHuZwSNVNroTwtC6duoAE/1agh2xJ0lvskx+W3vd8LGejmYWz2TnjMgMcY4+X4pp7ETJgAqId0DzabFR1RLKMvR+M2gTpbZy+O6Kddwf+qBkgcIH3hwVnI4NJhntXyrmi/xtIFUmVgPU=
Received: from BN6PR19CA0085.namprd19.prod.outlook.com (2603:10b6:404:133::23)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:26 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::1c) by BN6PR19CA0085.outlook.office365.com
 (2603:10b6:404:133::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:25 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:24 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/40] drm/amd/display: OVT Update on InfoFrame and Mode
 Management
Date: Thu, 30 Jun 2022 15:13:18 -0400
Message-ID: <20220630191322.909650-37-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c799f42-723d-463d-63e8-08da5accbf7c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mB8/XMVB7tUpnhDJG5uDzv4dr30jCst2NSWFST/Gh9NF/FOTxlBNjk0r2EGA9Yhc35vV+L6bcK3CxlCviMHDJf7PQyWz06awIUsbe17w8K0bqQYYg2eiQB3zotcCNojva2qBBoRgARc+W9dyONwK0sLoAguB1mRt9Arx3qRi94UgifOs89yQn3CYRp97+6XbRyV/IpE/8U764PyQ9AN7DRE1p0Ytde0JzA5lhHNWbpWWeA4YvbPVFGXNFgXBzuoDbEzLdeKYGHJ5AMaA1ukr/WVrK4MwFdv8AEr5KyvNI9Mf1QppEKLqNh1VE8XVktpZJekXi96ImAsf7waZMjIX7I/6ZdQp5u1Wyf9CyMYXgYz1bZwzaKwX6+UmW0bYcw6dzC2qAR68fBU6JHqEZ8vAg08g+xKLgr8WvEdU0tO/1M0pcOmGULreDov3HY30Up+QYHAnL6nZovSs1kK9UnbsW0PXseI2CKGRwtX1LWQhhUN2Zamh1WsLx3n3h90WFD3G1fHQRF83dShOr/B5vz0gybxOETMKKSKuIoVDpU0ZgEZVjwUkiPK2i/odtCUIUD6xdVRFKgGueJkCw0qXeuoW3Ph5SdYPTsi21Wn+qZP9l2QpTxDP73Tw8ihzyHCjokpwPA7AYK/N+RjQQmrFkE8sn5hiP2tElUR8hy1ebAznwbuUsBSn0MAcClnhwZ4e4K0ls0JE94IA3WMi2npdN7MIiQWuEUHKey2QAWNv/I/3ApJVcxmmTlLyng4WYUbM7JtLzwrtRXG4NB/oqBfssXWehr0wjGu194Jfpf0VIuKQr4KdnHds/6fJENlf32e/t6DTRATePdMC9iVJy2fUVCpGVnWMsPPOCG0fio114IEozF0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(40460700003)(81166007)(83380400001)(6666004)(40480700001)(186003)(82740400003)(356005)(478600001)(86362001)(15650500001)(1076003)(41300700001)(2616005)(2906002)(16526019)(426003)(47076005)(8936002)(5660300002)(336012)(8676002)(4326008)(36756003)(70206006)(70586007)(6916009)(82310400005)(26005)(7696005)(316002)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:25.7993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c799f42-723d-463d-63e8-08da5accbf7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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
 Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
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
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c    | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h            |  2 ++
 drivers/gpu/drm/amd/display/include/set_mode_types.h |  8 ++++++--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 85cbea4dbf72..2aa42c710488 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2514,6 +2514,8 @@ static void set_avi_info_frame(
 	union hdmi_info_packet hdmi_info;
 	union display_content_support support = {0};
 	unsigned int vic = pipe_ctx->stream->timing.vic;
+	unsigned int rid = pipe_ctx->stream->timing.rid;
+	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
 	enum dc_timing_3d_format format;
 
 	memset(&hdmi_info, 0, sizeof(union hdmi_info_packet));
@@ -2706,6 +2708,15 @@ static void set_avi_info_frame(
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
index d75416dc9fae..584aaf6967fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -784,6 +784,8 @@ struct dc_crtc_timing {
 
 	uint32_t vic;
 	uint32_t hdmi_vic;
+	uint32_t rid;
+	uint32_t fr_index;
 	enum dc_timing_3d_format timing_3d_format;
 	enum dc_color_depth display_color_depth;
 	enum dc_pixel_encoding pixel_encoding;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 084074a23031..7e595310a4b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -280,6 +280,8 @@ enum dc_timing_source {
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

