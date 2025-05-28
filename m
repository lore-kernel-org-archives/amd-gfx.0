Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF5C54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A9F10E559;
	Wed, 28 May 2025 02:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0NWotww";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CA910E539
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo7OsLqJYoswtZbPt2z2jRe8U7XvEtnwq5jPiS1Mu56pRKDfubB029GLbhpvIjLRBLxl2ZlqqsJfhbZiRWr3gWO3JZlLiemVXpzlg7uMmTyQRsLZJtYOaLXnmX+j/NLoo3thH/lP61CIjqKDhzWdDyMG8oDrUGs5KkAqYHuXD9Vs8gVCKa5rMnYTU/8mygrJbJl0mjfcCiilT3sOh2DjJcuKFgxE2i0IYAA6bAwK8VSnqqyyE8foFbHc7nFfEhknvY9YpPXT00rw5dHJQhMZiiQ8ZeSPleZWfWTR86HF+dLTUh9MU6O5dsm0ePV8BVBsBj2Y6ByWlc+zmWSf0WZKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN1LyDLg74rp2PF+qlcJEOwHyokcwNOdR3u0Oyg6hKE=;
 b=mPcTWDLY1BMJ+b8cl310AZ5DqMtvp0JQrZDB3mLY8raVIYKGe96uLlAqFgPXCbgJldGvtVnzmxcnCMJ+GzM0nXLubPKJkwYjIeHdcpgajYNIzRv+cbbr25j3T0caIYV6c3TABLtZUdq6CyNdxLOQNjrxM6kCC/teA9MuNwB0p/2JPnmHrQdsFRP1pcVeHWS7Axc5rzmthf1hUcoO5Oh6DenS4WP2oz8pYiuRL/XGxLa2Kkup3aDGTpN2SJYZO+fNQ9tRoKytfQwTuL6fBDQZWV91Wu2kMZa3JerrpPlkZedvqjLU5fUrfIm6jIWR3FxFobFpQ9FauudsWkj9Cydw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN1LyDLg74rp2PF+qlcJEOwHyokcwNOdR3u0Oyg6hKE=;
 b=d0NWotwwJFX61L/w993L0MK54iJTBk478aOJiG41nYp7h+K1jzQyahlWXtSZI6oIhhYMaymFettrc+uP6fn57qoojluESBv9Nr7PbxPev8pNBSlOt5Fbg1SLz/a2IDhfgYZc6PATgsK8FO2bGobrc9fJIKaUubgF1ivGFvJwjtg=
Received: from CH0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:610:e6::28)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:53:46 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::2e) by CH0PR03CA0293.outlook.office365.com
 (2603:10b6:610:e6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 02:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:44 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:40 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 16/24] drm/amd/display: [FW Promotion] Release 0.1.12.0
Date: Wed, 28 May 2025 10:49:11 +0800
Message-ID: <20250528025204.79578-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad23889-b310-4119-74e7-08dd9d92dd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+DgSXXndQASefe/rmBTs7dLZrNktCPbI0R+lWJK/sXYuTjm6rLTFYiDUtbEl?=
 =?us-ascii?Q?YOwJ7+sEBF0WulQJHKWCYi/kd+MKpn6HusoxOIP/U8su4CYaJ5uAnrfsmZkc?=
 =?us-ascii?Q?P0NsTkszwqgvzrH/03J61Lrba13MhXwSIv3CeEulRGSwD/d8IhFzz3jj2yo7?=
 =?us-ascii?Q?Y3lwE17MkjBEpg5Ce8iCOShU9bo9cXg/ql5u2rEyWyNU6c9yoqJ144uZBI3q?=
 =?us-ascii?Q?R4NoFfplw4A45ziXqpoRHU3onWgg4QNvN1Wo0h8wdwfIs6xbqE4x8nHgTYml?=
 =?us-ascii?Q?qnL1g9gc7YjP1cz5pG+XgAZBNhWrHLjh7UDYF3mQAfa7NiLQG5EXCUTQoYXC?=
 =?us-ascii?Q?AcnF6gEuZATdvaETLZJiH70YTlaa4yuUojb5SP6EIrKFvpKXLFiCz+CxWQNO?=
 =?us-ascii?Q?Qka9LHIoHhk+6EibkNGQMA8yQPo0Z11FTSa1Qo/wN4lehUdlahH/rEqrWn4l?=
 =?us-ascii?Q?brdhs4ZUCsgYNwl7SjL+SnmIYwkRptETcjkdWd8vREKupoGtaknYd7P9epLh?=
 =?us-ascii?Q?GIHbdoafyE2QwnEkLg2k4r68itvyZW2qXYC/iTYQ3D3SiTqcWAqK1TIv8PSz?=
 =?us-ascii?Q?3v7hjh0DcwJX58G+NMoivd2HdIU4WBc16mabyTAMgz3tOcMLJ0RJNF99DtZs?=
 =?us-ascii?Q?zdneh13FNz9KU7pA7Bae7zn2O0YVw5bo7cDCcXSPNaykqKWX8/mMvmUzVjYQ?=
 =?us-ascii?Q?b0DbD5W5bDarvZNCrRH3p3iCn6nI2Ec1hMEB3QKnTISqyQnAaaVgVjHeWv8e?=
 =?us-ascii?Q?3Oa1S7tICAM15HL/E8ZQEU5dGPTO+tKIvsTKxuGrcL88r6pKBcKkqgk0sF0u?=
 =?us-ascii?Q?CdT6PcJlToD07qP1P1bPslcLP+4TkwW0SPB7xbjZNPI9QCgzWcKxw9PTbvai?=
 =?us-ascii?Q?xaF7iF9cr5RQJjfs+SBqBPdVAThrsAz5HBuqQ6jYKw3L6pJZw91w66DC5CgR?=
 =?us-ascii?Q?9nx1koJu0YMk2X6Eya8ZDByw+TwXJ++lToY3sHdzQcuBaBWJuMJtARi6QKQh?=
 =?us-ascii?Q?dJAYltdrCrffDGRP8eplhL6GvOU4iRr/3rYvu8gYEcdQO3VyO4IMdsIcAs4S?=
 =?us-ascii?Q?fK7IphKedTlazBx7QOQc/wznvahEMEUIvH5uN3Rwd31gS0XMoKv7jy67WETB?=
 =?us-ascii?Q?kGpQufhP0A5mPeHAsUsPnaVSn62SHAs5jnHR7aQEb3EujUExw5NRe0tY8534?=
 =?us-ascii?Q?9ITqx7g0WyiW6RaGeeNRV97Gk1IRVtDpCN0WQBqm02/3agIWfRPFPYAapQI5?=
 =?us-ascii?Q?HOU2QXdxbWtr5MLq2pfx43/zDlmW/SgeFynBSdi2E7aCQ7hUlmtkvr5LR1zz?=
 =?us-ascii?Q?34ci1yynCrTF0uhEVCt4jLxGdyVTpiKLUTHr2JWvV2F50cSMyNwSMeWWSHmP?=
 =?us-ascii?Q?BSyccZehV0LnzV1tGHy5/bT64sHq5YdGe+uQwFdTyMSgrTQGpM6RfZAf3zLs?=
 =?us-ascii?Q?hfECWbEadUwBvZLkJt4Ee56X5W+qxTH849DsAQnp0TuYeL50p8HmUiWCUYfp?=
 =?us-ascii?Q?1ttqFDWsbtKWJZ1fcM/oXZhDsDZmI0SXUsul?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:46.2958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad23889-b310-4119-74e7-08dd9d92dd81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

Add dmub command to support LSDMA

Acked-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 346d843b45bf..dc4a8b83e6c6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1516,6 +1516,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__FUSED_IO = 89,
 
+	/**
+	 * Command type used for all LSDMA commands.
+	 */
+	DMUB_CMD__LSDMA = 90,
+
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -1926,6 +1931,121 @@ struct dmub_rb_cmd_fams2_flip {
 	struct dmub_fams2_flip_info flip_info;
 };
 
+struct dmub_cmd_lsdma_data {
+	union {
+		struct lsdma_init_data {
+			union dmub_addr gpu_addr_base;
+			uint32_t ring_size;
+		} init_data;
+		struct lsdma_tiled_copy_data {
+			uint32_t src_addr_lo;
+			uint32_t src_addr_hi;
+			uint32_t dst_addr_lo;
+			uint32_t dst_addr_hi;
+
+			uint32_t src_x            : 16;
+			uint32_t src_y            : 16;
+
+			uint32_t src_width        : 16;
+			uint32_t src_height       : 16;
+
+			uint32_t dst_x            : 16;
+			uint32_t dst_y            : 16;
+
+			uint32_t dst_width        : 16;
+			uint32_t dst_height       : 16;
+
+			uint32_t rect_x           : 16;
+			uint32_t rect_y           : 16;
+
+			uint32_t src_swizzle_mode : 5;
+			uint32_t src_mip_max      : 5;
+			uint32_t src_mip_id       : 5;
+			uint32_t dst_mip_max      : 5;
+			uint32_t dst_swizzle_mode : 5;
+			uint32_t dst_mip_id       : 5;
+			uint32_t tmz              : 1;
+			uint32_t dcc              : 1;
+
+			uint32_t data_format      : 6;
+			uint32_t padding1         : 4;
+			uint32_t dst_element_size : 3;
+			uint32_t num_type         : 3;
+			uint32_t src_element_size : 3;
+			uint32_t write_compress   : 2;
+			uint32_t cache_policy_dst : 2;
+			uint32_t cache_policy_src : 2;
+			uint32_t read_compress    : 2;
+			uint32_t src_dim          : 2;
+			uint32_t dst_dim          : 2;
+			uint32_t max_uncom        : 1;
+
+			uint32_t max_com          : 2;
+			uint32_t padding          : 30;
+		} tiled_copy_data;
+		struct lsdma_linear_copy_data {
+			uint32_t count            : 30;
+			uint32_t cache_policy_dst : 2;
+
+			uint32_t tmz              : 1;
+			uint32_t cache_policy_src : 2;
+			uint32_t padding          : 29;
+
+			uint32_t src_lo;
+			uint32_t src_hi;
+			uint32_t dst_lo;
+			uint32_t dst_hi;
+		} linear_copy_data;
+		struct lsdma_reg_write_data {
+			uint32_t reg_addr;
+			uint32_t reg_data;
+		} reg_write_data;
+		struct lsdma_pio_copy_data {
+			union {
+				struct {
+					uint32_t byte_count      : 26;
+					uint32_t src_loc         : 1;
+					uint32_t dst_loc         : 1;
+					uint32_t src_addr_inc    : 1;
+					uint32_t dst_addr_inc    : 1;
+					uint32_t overlap_disable : 1;
+					uint32_t constant_fill   : 1;
+				} fields;
+				uint32_t raw;
+			} packet;
+			uint32_t src_lo;
+			uint32_t src_hi;
+			uint32_t dst_lo;
+			uint32_t dst_hi;
+		} pio_copy_data;
+		struct lsdma_pio_constfill_data {
+			union {
+				struct {
+					uint32_t byte_count      : 26;
+					uint32_t src_loc         : 1;
+					uint32_t dst_loc         : 1;
+					uint32_t src_addr_inc    : 1;
+					uint32_t dst_addr_inc    : 1;
+					uint32_t overlap_disable : 1;
+					uint32_t constant_fill   : 1;
+				} fields;
+				uint32_t raw;
+			} packet;
+			uint32_t dst_lo;
+			uint32_t dst_hi;
+			uint32_t data;
+		} pio_constfill_data;
+
+		uint32_t all[14];
+	} u;
+
+};
+
+struct dmub_rb_cmd_lsdma {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_lsdma_data lsdma_data;
+};
+
 struct dmub_optc_state_v2 {
 	uint32_t v_total_min;
 	uint32_t v_total_max;
@@ -4453,6 +4573,37 @@ enum dmub_cmd_abm_type {
 	DMUB_CMD__ABM_GET_HISTOGRAM_DATA = 11,
 };
 
+/**
+ * LSDMA command sub-types.
+ */
+enum dmub_cmd_lsdma_type {
+	/**
+	 * Initialize parameters for LSDMA.
+	 * Ring buffer is mapped to the ring buffer
+	 */
+	DMUB_CMD__LSDMA_INIT_CONFIG	= 0,
+	/**
+	 * LSDMA copies data from source to destination linearly
+	 */
+	DMUB_CMD__LSDMA_LINEAR_COPY = 1,
+	/**
+	 * Send the tiled-to-tiled copy command
+	 */
+	DMUB_CMD__LSDMA_TILED_TO_TILED_COPY = 2,
+	/**
+	 * Send the poll reg write command
+	 */
+	DMUB_CMD__LSDMA_POLL_REG_WRITE = 3,
+	/**
+	 * Send the pio copy command
+	 */
+	DMUB_CMD__LSDMA_PIO_COPY = 4,
+	/**
+	 * Send the pio constfill command
+	 */
+	DMUB_CMD__LSDMA_PIO_CONSTFILL = 5,
+};
+
 struct abm_ace_curve {
 	/**
 	 * @offsets: ACE curve offsets.
@@ -5973,6 +6124,11 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_fams2_flip fams2_flip;
 
 	struct dmub_rb_cmd_fused_io fused_io;
+
+	/**
+	 * Definition of a DMUB_CMD__LSDMA command.
+	 */
+	struct dmub_rb_cmd_lsdma lsdma;
 };
 
 /**
-- 
2.43.0

