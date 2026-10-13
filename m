Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C802BCA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6107710F766;
	Tue, 13 Oct 2026 11:18:19 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F68710F766
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/rDXWGgQty5ScMOW296sJRbHFZxFnU88AFrI6g/DohWc9J5MJj3VKZS9z1cQo4KSSc/zibJe+36qYdDRo4HJELE9Akrisf0c+UTMdtO0g+/xrpSQBrO3mHUEw6WN7VbVQTC7m/Cui2TLVG4+U+wLxzp3yeW2DDak3kzuqIpe26NmMgAgGGRFoCiF2N8cgQQPpHn/KmTCqILhH47/jrEL1kG0q7bXJWT0tGBCYfEqW+RPU4y2Ciyl1L4flExOaZJUbY7Wv2IBYxNW0muybeQgXCOWsMhvR5O+WRUHF4OxWv+F2ZE6GikUzbQaFllTfCs+5qiRvIukJNkKMATtkGqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryco/g81fnv+D92/tLMZuODqEQi8bVrv/WMgJbplPlE=;
 b=dCMCLv/Avi8rzH9OjZrWzwI1N2C9yTkopBqPOtjgyDX5sKIzQUA2l1QQpEjkCjOTbjqnkgqwR9ChEURwFWkjiUinIZmCKoRiAKnL8ABMEPwsMoyEBz4L2jhsSjGnIZgz6tW000jAxiBZCIxRmVFXuWGy2moHNPgtkUbH/N67qaOr2Rkp6Jdb6AKF6lXZ5HDFnFO7k14dZjYWkxy9okuoj+MVW/KLUuFgVozwRg+Jg6NPtNu/ClVw4CAxIeFJK/uGl6QuP+xQ7g1MY19TIi3Xnb81OmswqZsNE09MCKA+55ZkvsE1h6PYBvU24lOPvtxhfK6e+iAupYX2qGopn5Mp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryco/g81fnv+D92/tLMZuODqEQi8bVrv/WMgJbplPlE=;
 b=IhZMP7E/xA9zgdLEXyHrCrMRp5jRaf9y0GWGEBEI21MMP8J25pML0f63DNEtVrk+FuxpH+23pNVVODckKrz7zb0GkF9FFefgcpgEnnhw+BFIt9xukBHgaF0Cf5VGlMUJ7it3qOYNF41eV/s0htz2tWJfKfB7BHwNPesbQaHmOV8=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:18:08 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::6e) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Tue, 13
 Oct 2026 11:18:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:38 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:17:30 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 12/30] drm/amd/display: Update DMU cmd header
Date: Tue, 13 Oct 2026 19:07:59 +0800
Message-ID: <20261013111616.2267344-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 627a64fa-ce0f-4f42-72fe-08df291ba8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8EDcG8KwwC/T7Q+Aqs/efClSEnuVIT8n/LncTqj4wfsqToXQBWDvh5k6a7Sc1f60QXy+kvh3VsUcf+Wu9My1dIAiw0b3XQ1KuTN/N9/h4ECWZAYitkfcHwMEORB5anezyqC9ORU3tkgKLct629Jh0IzJewvYSTX0w8ZisFC3IjR1ni994Ci2pjiDi7YU5vwjjBawtRgKEybDF22saoFeIOkUBcwusoui/mk5uY2NgLqQIKuawaGTUBMvir5U8IgAFId14k+R0BldPlTs05CRxUd9VY9XFbFUSu7+zoM4q0cVAJ/7glYoF2mqAIekpNiCRhmRptBQO5/wP4WS2Bxv0G/VHIiOcUOf/rknLaa+TT2MKmQAv6ksTImCwOnRNo2gKXe3amvL22LpYncBO/eMJPmtKSeen07iWUmqeVF43cuCvfoRdiRo9KD3F3samMJL/vspRfAK5nPOGzfnIRVi1Fj6SgxeZaL4saf7vP7Sl4JmAVTBwsg+YLYmjE3OFzaRhLQKcPkx8nuLq3hnFr1qUaLuzxkyJu5Q7oSXg7kaAkDDzsuNhsTiPI70glhk5MaGZfA/PLbN68pYTQHLsCpQvS7yg4B/DcPYTbKxwAfSbo2CLft8cXkAYfzmWXiCT7ROQqtiigazmjTMh9j3UmdLMdX88+wPcl/GrDqsEs2d7iE8HmUHppYNmJbCgL4pStpaIQCigWN1JLrb/G0Lhjl2CQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yOboeTqj6/nc3jTJFGhofmUlywLsQeiddiXwPWqLskZcILyk1l0n6LC+wZ2T6CcykQmOqAhlxSZDJInZGsl6y3y3OPyGfnn89+nsYRSgzJaraYCJh5LHf4CkP4VA4+cC6o+TOAibxGgl5qXPBXggQPg467jYUbcSfNwNVTDc8dyU/CMceCmmvleo2CIeL9wjzTE6g6cmhKd46DDXQ6x8KyLeKYaXbOgBKYMmagfajy8yWpXWDMqYMo66/5wIbfrZdOD7UbtCzdUEGb7emTf2YsqKaOJIU2bLr97VkbBcTjYwyyz7Pay9wOVQfpXRMy+X/dhP7434ehOHGXLhAOL3lnJYVDUqnMWp51Lv8F5Nw/QFDkXmQJP4Kt44MGaCzHw+sOCHc+OmqFo9kGh03uVxqkG9CAbzmPJnO3XtHr3iOwZrjZmA4VxegdC3z3j93koW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:08.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627a64fa-ce0f-4f42-72fe-08df291ba8bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Update DMU cmd header for DML submission dependency.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5d534b91bc33..5dbedf09baa9 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2802,8 +2802,11 @@ union dmub_fams2_stream_static_sub_state_v2 {
 
 struct dmub_fams2_stream_static_state {
 	enum fams2_stream_type type;
-	uint32_t otg_vline_time_ns;
-	uint32_t otg_vline_time_ticks;
+	union {
+		uint32_t otg_vline_time_ns; // used by DCN4
+		uint32_t otg_vline_time_ps; // used by DCN6+
+	};
+	uint32_t otg_vline_time_ticks; // U22.10 fixed point, see FAMS2_OTG_VLINE_TIME_TICKS_U22_10_FRAC_BITS
 	uint16_t htotal;
 	uint16_t vtotal; // nominal vtotal
 	uint16_t vblank_start;
@@ -2835,8 +2838,11 @@ struct dmub_fams2_stream_static_state {
 
 struct dmub_fams2_cmd_stream_static_base_state {
 	enum fams2_stream_type type;
-	uint32_t otg_vline_time_ns;
-	uint32_t otg_vline_time_ticks;
+	union {
+		uint32_t otg_vline_time_ns; // used by DCN4
+		uint32_t otg_vline_time_ps; // used by DCN6+
+	};
+	uint32_t otg_vline_time_ticks; // U22.10 fixed point, see FAMS2_OTG_VLINE_TIME_TICKS_U22_10_FRAC_BITS
 	uint16_t htotal;
 	uint16_t vtotal; // nominal vtotal
 	uint16_t vblank_start;
-- 
2.43.0

