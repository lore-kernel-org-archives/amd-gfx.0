Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492CDC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4A614B113;
	Fri,  5 Aug 2022 18:00:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DB391E3A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSZt973q6Cg9VOZrybfmpbSYH1WmuXcxcRaQWmxfQv5GDYgF/Yvx3FtVPvO//opSXAOWRaxrANj79qrfDPBFt0n34W0GR34C7L/yPnPWwuKjVlKsFQWwSGaBnM5iVv5spMhqWEkeDp836PIMaU2/9u1aNny/ZHS7vgu+6VVYBBTeQzgSkCDVppJh3BtlLO0aSgbtGlCPEaqwKRO3H0yRMQnjCGdcLkh0ggD4mYRoGGFzuGzYP3xU7ZBIBK0QzpRd51dAHwzslRA+YQxeFbIfiLxv0nJY+SLwYTemqjAkzB6R3dMCBnLB/mZR9AW6+eh4TjjhpeU6/JhljOBBZ1kCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+1J2IbZC09xcIflMfbI15KYqxZ68ukHG8BdZ0hNBzE=;
 b=cdXIJvGJj3yFTUcM/5BzY/MT7NucKSqD1q+qhlEr5h36UJsSLrMS3muUcz7FofrzQG0KQEu7YAl2tUJM98SndAwkz9b6nuSBBPxeDj2CYjuxiLsk0vUdDJONpHHmJmRQkbqtKihVTxxVr++MF32f1ZcWfpdeCYjRq3aMgHTUXe6dmX7WAecxvPFCtKH6oU34pTRdR6WcNkRDaCWVt+i7M1SacFUu7kfDzjjTaLkBItUu4Yzx4oiu4Maw6SJ8B2Z9jJtnpb0XHZveLs0gabT19AtvaH0lIWft2Y+QgKzSq4gzfE5+lfmwdwqyXpo5f+AST7uTzjyXKw4UfH6NmJI5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+1J2IbZC09xcIflMfbI15KYqxZ68ukHG8BdZ0hNBzE=;
 b=ycQ2QLFYc7IPULsuaO8HeU3B40V4vnJfNllgWjcmR0TxWy7+6R3vXYLiE3O5WIf3pqnJTo8emr+xf3kCX4Y2/ZLPVxacMmO1Dax3zu6THAAf8WkwPxWp9H9YksWGw5yxRj6duwqqo8hmbD8VrK9sM5zk5+DZcnCcSsGMQapUBxE=
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by BN7PR12MB2707.namprd12.prod.outlook.com (2603:10b6:408:2f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:00:14 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::a1) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:11 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:06 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/32] drm/amd/display: Add documentation to some of the
 cursor struct
Date: Sat, 6 Aug 2022 01:58:09 +0800
Message-ID: <20220805175826.2992171-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 966a8e9e-8b12-4a99-64d6-08da770c58d3
X-MS-TrafficTypeDiagnostic: BN7PR12MB2707:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhkcLZVp/Q9Ip35nVKqhaYGzuXCX3RXxjvZ1WdFgaX/r2jzQ+ITavFuVlXVSbmeeoeSL3F9L3CP3GEf08pjx0N7ApGX2r5Q2sHVSSfGkjVoBv7VTYDFuIiyYHYKObP11/D5ek+6T33xyPLqGGmhw2oj1IcTH9M9OPyjV2IULfQFne/nEOjCeeXX8yJhhQq1Q6kBvEDrwAfm/7YJywxpwINuTVXAhhrtrjilcRn9tH0yoEjRYlGKF86gK+GE1dqhIWCP+KYPJiNZDRCs1PDbZQy4r3qghNkz8Klrtxt4YisZR+qvkbxDlAzDt68iLu5K9bS98uvDZtJ3cncsVrxjxiAmJYxk7afIMKxfKakyTFyaRFDjwra5664bUoEE/y0Q37aj0X1XhcYA30BssD/9OA6KtC46H7XBwqZTPNOQsij6JJyf0vHIr7fYYYw6q47c9UqxaTFe/FaCi0dO9muhbkMLbJQ6BP+1/qDg59AZfRl6EeHTg0EA3bLRJUXlHLLmRFSz9YCwqSwVpRti0tQWvHYoQeL+1ffvSdm7pftTS0inWiy/M3qx30OWjuErXOO+1Jb0Jtwv8TCfJYawFhNJOr6Zx/R1x92IbZI29WcJrfMQibZ2tUY/p+Hc90iStKUbN0xwZyBWPgs47eTdNG/rKh0faBiAe6oIdVVDFaUydDUKaceeXWEX8jM6HCa0zkpNBREYWMzcmYwd9PgeDGyz6qTZlXSTNquACx2HG572iXuCop8j6C227ysgZ+Jc0CkoACrwi+dCm7qkgqJl2+d2KXnZiM1Ll9auC6C5SVanIArNDMRmJzC6apvHwzhWjrgT4bo0IbuQP20tdDGX0uDvUrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(36756003)(26005)(478600001)(7696005)(82310400005)(5660300002)(40480700001)(2906002)(41300700001)(86362001)(54906003)(316002)(36860700001)(186003)(82740400003)(6916009)(81166007)(356005)(70206006)(70586007)(8936002)(4326008)(8676002)(426003)(1076003)(336012)(83380400001)(2616005)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:13.9283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 966a8e9e-8b12-4a99-64d6-08da770c58d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2707
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 62 +++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 584aaf6967fd..d158aa4985f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -417,19 +417,43 @@ enum dc_scan_direction {
 	SCAN_DIRECTION_VERTICAL = 2,    /* 90, 270 rotation */
 };
 
+/**
+ * struct dc_cursor_position: Hardware cursor data.
+ *
+ * This struct keeps the action information related to the cursor that will be
+ * sent and received from our DC core.
+ */
 struct dc_cursor_position {
+	/**
+	 * @x: It represents the top left abscissa coordinate of the cursor.
+	 */
 	uint32_t x;
+
+	/**
+	 * @y: It is the top ordinate of the cursor coordinate.
+	 */
 	uint32_t y;
 
+	/**
+	 * @x_hotspot: Define the abscissa point where mouse click happens.
+	 */
 	uint32_t x_hotspot;
+
+	/**
+	 * @y_hotspot: Define the ordinate point where mouse click happens.
+	 */
 	uint32_t y_hotspot;
 
-	/*
-	 * This parameter indicates whether HW cursor should be enabled
+	/**
+	 * @enable: This parameter indicates whether hardware cursor should be
+	 * enabled.
 	 */
 	bool enable;
 
-	/* Translate cursor x/y by the source rectangle for each plane. */
+	/**
+	 * @translate_by_source: Translate cursor x/y by the source rectangle
+	 * for each plane.
+	 */
 	bool translate_by_source;
 };
 
@@ -494,7 +518,9 @@ struct dc_gamma {
 /* Used by both ipp amd opp functions*/
 /* TODO: to be consolidated with enum color_space */
 
-/*
+/**
+ * enum dc_cursor_color_format - DC cursor programming mode
+ *
  * This enum is for programming CURSOR_MODE register field. What this register
  * should be programmed to depends on OS requested cursor shape flags and what
  * we stored in the cursor surface.
@@ -530,17 +556,39 @@ union dc_cursor_attribute_flags {
 };
 
 struct dc_cursor_attributes {
+	/**
+	 * @address: This field represents the framebuffer address associated
+	 * with the cursor. It is important to highlight that this address is
+	 * divided into a high and low parts.
+	 */
 	PHYSICAL_ADDRESS_LOC address;
+
+	/**
+	 * @pitch: Cursor line stride.
+	 */
 	uint32_t pitch;
 
-	/* Width and height should correspond to cursor surface width x heigh */
+	/**
+	 * @width: Width should correspond to cursor surface width.
+	 */
 	uint32_t width;
+	/**
+	 * @heigh: Height should correspond to cursor surface heigh.
+	 */
 	uint32_t height;
 
+	/**
+	 * @color_format: DC cursor programming mode.
+	 */
 	enum dc_cursor_color_format color_format;
-	uint32_t sdr_white_level; // for boosting (SDR) cursor in HDR mode
+	/**
+	 * @sdr_white_level: Boosting (SDR) cursor in HDR mode.
+	 */
+	uint32_t sdr_white_level;
 
-	/* In case we support HW Cursor rotation in the future */
+	/**
+	 * @rotation_angle: In case we support HW Cursor rotation in the future
+	 */
 	enum dc_rotation_angle rotation_angle;
 
 	union dc_cursor_attribute_flags attribute_flags;
-- 
2.25.1

