Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECCF10E583;
	Fri,  6 May 2022 15:43:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93F010E583
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI9gy1tqMJIk8KBO33tposD5RSxD4azTYSv5U+ZAD+0JwyR16aRoCNe4whEWz77eNbwRaE1ooQoT/Upy93OBBY0oD8BFDlNwtBT7jU/1fg36K4ClHY89l4eVR/ld22bdTvTkqvHbQv//S6yNv5RBvni6446DhrExsNDAW40Z86sIl4EFPk32VDO4WKzQKXs00kekzBUd8kjKm3QmfEEvZTfFuftx0N/4JfjX8MNIWF8gccIjdybcBn43USVSWXO3RjbfgtEi43PeEMej0z3xEr1f7k+VqwEvyX881Vs46dgiPJsl1vk1LlkXJwWWe03KEiuLVUECuV/9J87eZFZSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/49O7X1yAJGcLGgeFOBRQMa/imRWn4JETWCE7zAPDJg=;
 b=OiY6r1SlwOX4gZ+P1EA4Bk2IFekgqmJHdjOhxXN6BHTjuUYBlCBkwKo9K4Y5+JxIhhYKB5iMqQW6gKx79Sz6nKERLxsOJgzyCqM8CxAnkkTO6hRcakPL9CYLLxgPVzzEjMR8gQRfVhhHE8smTMBQNBSTg9k5NuTp9GrxQRZLh01GQGlTXRld7Q8+9y3zLQaey5uw/rrm3BsjuuXa3FWgV5PHLetc2TTAyXV5FeB+S+673+nxrQV7QQaywc1FBYpu1E+IoQTiOmMnphJM0kpo711uQnuzRA5RI0ntLKIPuo7neVzEtKk7ZT90Bmh2CDeoAbfQoF4JJZZpqlz9wbfK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/49O7X1yAJGcLGgeFOBRQMa/imRWn4JETWCE7zAPDJg=;
 b=kyy2OMSWaeolKtMwoYMBDW9LbZpSEMKahBmsPrLmvV2OKjH2R8Kdyh/IhiM4IJT3JgSIHXG5NysGdjRUmWDvbbaAbFo1yyH4LFmzYNniN+0lNEnxBPkVHyyaZlWGRDMAdUACS24rVCF0pxk0lrINuvTcBgOQTod6qcudjbH62+c=
Received: from MW4PR03CA0190.namprd03.prod.outlook.com (2603:10b6:303:b8::15)
 by CY4PR12MB1688.namprd12.prod.outlook.com (2603:10b6:910:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 15:43:01 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::c5) by MW4PR03CA0190.outlook.office365.com
 (2603:10b6:303:b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 15:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:01 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:42:55 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/15] drm/amd/display: move definition of dc_flip_addrs struct
Date: Fri, 6 May 2022 23:42:02 +0800
Message-ID: <20220506154214.3438665-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d580e6af-e28b-41b9-b3d6-08da2f771a30
X-MS-TrafficTypeDiagnostic: CY4PR12MB1688:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16880A326BD39A975B50E84FFFC59@CY4PR12MB1688.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AR8s2/3G383X+jwuAe5wXUXLSsUiYD1pPkkD+z2ISQb++fV/8jxjnHlBPoSagLlamWiFYAG+L9MfgnkZZ8OHlJucaR6u/L3Wr0JrNxFa04n8Q8gY0EQHoy45LwmLLvGtIF3stgRIkTTvCJSCvZAPGK8sskwsHNS+UPCmWSs+qY/nRtKxHCwI9/XH7qYsSgTe1r/Vd08VQ+kLgZwMGpdtfKljvinMfesy5iC/EjrE9XYuTtRU3V1W8cGLzfwZTjSSMgFVCMWub5Kcb6WRseTA0W0ImxweO5UrFBrv9h8/PY35cOsKi67gyCRIrL2CFqKZa/sg0rUqTfNNLhCmSnGj6QNK27G2uyMf4o7eVKf7wY7h3L1C5KoQ8DVjFlE2ydgzZ15GHV+krwzkK2w/JhkwPspkncwwB9ELUUDoUSD3VWtcqD7ZNPVzGoG4miSWaqia76zZap5OnKbEzFdU4DermpwrC4COyg3IePRXo/H1EdyrVZnXZLFBiosb8T7qh2kmV/LGiZlY8k6AbXwxzPoE2pYnNndx3J1dYDGv7JtZuv34B07/3WGo5Rz85bqSfar7Ek8qQ6rUrZfb+9HkO6+cAHeCgTuqy0T4767nHdjwpp6WBrvsUMpD72JszGKJXfgiYUH4/wNiKyuyrDrh96MknZ/HJmLiSYSLWMu2Yv/w4Pk0WI6pUo+K5g1VBOdZvxPAiHgt9N9T0IvtFMXmTIk1qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(5660300002)(82310400005)(40460700003)(81166007)(44832011)(86362001)(2616005)(8936002)(186003)(47076005)(426003)(336012)(508600001)(356005)(16526019)(7696005)(36756003)(26005)(316002)(6916009)(54906003)(70206006)(8676002)(2906002)(70586007)(4326008)(6666004)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:01.1484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d580e6af-e28b-41b9-b3d6-08da2f771a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1688
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Move definition of dc_flip_addrs struct from dc.h to dc_hw_types.h to
prevent build errors

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h          | 12 ------------
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 942bfb8fd851..e37d9c19f089 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1129,18 +1129,6 @@ struct dc_transfer_func *dc_create_transfer_func(void);
 struct dc_3dlut *dc_create_3dlut_func(void);
 void dc_3dlut_func_release(struct dc_3dlut *lut);
 void dc_3dlut_func_retain(struct dc_3dlut *lut);
-/*
- * This structure holds a surface address.  There could be multiple addresses
- * in cases such as Stereo 3D, Planar YUV, etc.  Other per-flip attributes such
- * as frame durations and DCC format can also be set.
- */
-struct dc_flip_addrs {
-	struct dc_plane_address address;
-	unsigned int flip_timestamp_in_us;
-	bool flip_immediate;
-	/* TODO: add flip duration for FreeSync */
-	bool triplebuffer_flips;
-};
 
 void dc_post_update_surfaces_to_stream(
 		struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 0c754cb0459e..aa7e3a07191d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -236,6 +236,22 @@ enum pixel_format {
 	PIXEL_FORMAT_UNKNOWN
 };
 
+/*
+ * This structure holds a surface address.  There could be multiple addresses
+ * in cases such as Stereo 3D, Planar YUV, etc.  Other per-flip attributes such
+ * as frame durations and DCC format can also be set.
+ */
+#define DC_MAX_DIRTY_RECTS 3
+struct dc_flip_addrs {
+	struct dc_plane_address address;
+	unsigned int flip_timestamp_in_us;
+	bool flip_immediate;
+	/* TODO: add flip duration for FreeSync */
+	bool triplebuffer_flips;
+	unsigned int dirty_rect_count;
+	struct rect dirty_rects[DC_MAX_DIRTY_RECTS];
+};
+
 enum tile_split_values {
 	DC_DISPLAY_MICRO_TILING = 0x0,
 	DC_THIN_MICRO_TILING = 0x1,
-- 
2.35.1

