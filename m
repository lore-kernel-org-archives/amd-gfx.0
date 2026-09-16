Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79572C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ABC10E634;
	Wed, 16 Sep 2026 17:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aQxah8J9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB6810E521
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2F9KTCnhW/Q7OAKWdL9103Ms5xpxDxriPXrXVOa+gtPkjGHS/zh99vYpwdZ6fuVOCQZg6ZxCaRkKyXY1rjGHJutx/8D0HvcUTDzkz2rCblJkQgLBnYi4u5JPc9c8olUC0GsHtH5d3MPKvS7qMoZb6YttOSgWRiM7T3Y10DHOwYlPA0g7z37sCun9ouHD+bwZWzhz4z/K4lMf7SC+K5hkSywTl21tbTVLSRUnLAIyG603M2tBlo6riUAPtbPBJdgYVbNjIAdJuQuf2Irn1u8OMK8DbdG5lszGJWbEHrny1CHdlbsi7mSBb69KuMGsIkIex/tkR4d93fGtQzsylpPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWa/7r1mTIjcmEgHSLxO63nhXDlVtZAfYD7BPblbgIY=;
 b=ivpztkhG46SQ5g9dX9lnQFv1lpZOaWV3DFV3C8SBf/WQ7temXMMIvrKhue4UrgKH7ImFgs1spBQJecBhtG6emq2bqY/shhA0fmfP79Y7RwVqDhTfxbnW9KUK7GSVfV1T3RtMPgE3t1OpGh21W9zH6bzRZB+9LL+FbE6XpDFnmEy+k4LxlXeFY6Q7Qc/umm1tKdlAMclvwfuaSk3xY0h4ELWvgwG1GKmtFj7ZeyASUTVVyX1gy9Mit353RMQ08vL/4iZYVRN7WCCZY80Ow+NvxVHrUCafmtmD31kaPz5x+hMadSCINx0xnDZGMAqf9/82D+cMOJZOuPCUF4NqWYaSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWa/7r1mTIjcmEgHSLxO63nhXDlVtZAfYD7BPblbgIY=;
 b=aQxah8J9yoOjzB9PqqEDu/jh+yoAOuHgN38+XPKEdXZsfMDhz76iFzAfp+jG8lwi6S7C3K6+CxuvKD2+iKhNTNHqPGjVDJEdDEUFzqmlJMVNn0xdJGEdEJnr6i2pVNryTvct2rXMHeXzcvxRboOiJJktHoHZWPkpQSEqPJRNzIo=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:52:16 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::3a) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:16 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:12 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, "Huang, Leon" <Leon.Huang1@amd.com>, Robin Chen
 <robin.chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 01/64] drm/amd/display: Forward periodic ABM keep-alive
 scenario to DMU
Date: Wed, 16 Sep 2026 13:51:16 -0400
Message-ID: <20260916175301.368306-2-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b891ab-2209-4b60-fe0d-08df141b3f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FylYjtGO46d6X2d87bPH0vYGc1o4HhiOXntD9HLu63qmiYCsrtVXgUXxZ9Gbbmn5P3sNx2V9XDHnx6RV+z8WVexevDL42u5G/Opxs8iqwUWAPrAcE37O23Jp+QnrK1T5x5Pqzu/ODj1bv3Bi0TsAUSehsT/Ub05xKgTHQN3Tp+p088M1X0fpzpIJ6vDO4dt04eQ9nsf/S3x4EuBBVsBWI1ULhvhi4Y0rHfFzjdaZ6PGGyjej1E9pxrd3SgBoz9cGVEoIL3npq+I6TOwRHHOwWHmihaYek4CXiMEKefYSdmm57g+rgNkk8Cbz827zKGNpa+hxqAMbSXVTuyQMmTH/n4QXgSz8JLPTLzaWp9oAJVKC5HRpNY3HREc0UbxgFdEBvXpNmbRqe8T6g99S2g8RGtQ1gGlSI0VU+nJMiLJiYgk3xGvAv/Nqrio14Sqfraxt2Z772XFwQyCZjdRMC57xLsxi8Qsvz+sgA/iKCJ2hEzguKQTmbeq8rd0dU/8GCL+2z+otCDrCO81RK2BN9orqa2Ppf7O3iJeNdyICgU8sbYm/jDALvuqNS2IFawf4R3EZYUqEKsAALqUlv2cttSdSyLwkFzTOn4na/6vosZKe60/WI4h6qpjNOHJs+yOUPzNhp5uuU0BVz+M/tk5ZPTAkLEegPf/5zZtqncxmXiLkSRJ6nIy4lauer9ksuBrBe6fxocj6fPKtjWSJVMsX0IjRBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FrD9j+EnOpRX1GabfIyT1KIqdRw8to7YRoCKX36zTGoXdBdJ+N29Zm7mFoTqcOSQAdqEIyENzIBM1skEiuVwbsOzFSfa5eOXP2UH0jKhGhm57MXdBa5zOkUrBJbTXm20h7pBiBMUDLl55s9DRvRZfo2nD54AHOYcjXOZ40HGnT4rZ1n8+YP3nYDo0uAjyu4LBiDBuVpMCoY434HWT7GhQ0kWDDyUZLhjM63xVPBtFrgIzpfNWq5gbk61kmMySfni2iU5iucL1U6nurPC3JwlA9jjZNAaqvuNbApQzeT57LPQn7aE1xeL5hTJ9Tfy5MWBkWaVJ7idN6+GXj3trQf11e6HdU7BVT965zXOK2JHHvbCfv2FKF/bBilPl/yFfqDPobp8exgPFFNPlYaYcF4KEhxVwex+ZN6oBzAlyAGcUwyIVL7DCkcOU0ZUQPGeAGyU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:16.7903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b891ab-2209-4b60-fe0d-08df141b3f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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

From: "Huang, Leon" <Leon.Huang1@amd.com>

[Why & How]
1. The periodic ABM full-frame update for VESA PR is now owned
   by the DMU timer.
2. In PR_update_state, compute whether the current scenario allows
   the periodic keep-alive (not CTS, not front-buffer rendering,
   not force-full-frame, content actively updating) and forward it
   via the abm_periodic_ffu_allowed runtime flag only when it changes.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 01f7c9addc6c..7ff2152ff233 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1309,6 +1309,8 @@ struct replay_settings {
 	uint16_t frame_skip_number;
 	/* Current Panel Replay events */
 	uint32_t replay_events;
+	/* Last ABM periodic keep-alive FFU allowed bit sent to DMUB (VESA PR) */
+	bool last_abm_periodic_ffu_allowed;
 };
 
 /* To split out "global" and "per-panel" config settings.
-- 
2.55.0

