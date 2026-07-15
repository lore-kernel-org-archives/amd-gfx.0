Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BEEC44511
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A0F10F07C;
	Wed, 15 Jul 2026 13:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lrHdArol";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649E810F07C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5rVM+NzuEsiaSowrw+k6yBqv30WVyFbxz29WMQ5YPvHBxIwRwk/bSCtRvgTSQ5eXAXn3CtfxYyXF3f045i+CfN3xJpwpSlpRH8/DByIGvK52hEetol8d8m8yjU6ZU6AAfHThT17rVMEh2jZ50YOAUuVFxMK1cg2ptJ/l8MEHPwUey/b/ViPuquqI9/4OHrEFpL/cEFw23Y4uOBfhg2Cl5qlYyq3QChh0uwKgYyeyxPlKxgZ4YhxYWDWYDRtJVuMfzCqfOJH60+vqoWvP/u7akibba1oZBCg/7Wt9QVawD+uxVffncvtU+T9WrWHFzoRfkf297lqnM7nmY82CP88kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB9qYA7weHCwobv6gep5b9uRI13Svvuw9RBgA9zGAvQ=;
 b=bs+QVngMIVxq1g1H+Sj5v6w0uCu9PZN5/eZ8MrfEplsFNyWgk9t0oMjtdiQrHOxgMwIZIhcLHigb6OIUv4EEdwNQRWNjyIBvfQrA02Lx/+aeUyPb/NhvNpAy4TZmtO30varJmBeCimyVqAPfP81DAOhk1X4pOVNcxgMNm7EfeJs7ZhbTdFOhH+KuaTD4M/ULP4LVrYjY52qO/mygES7dLvikjFdea0zxXrvuZQ7fz83xhsMQhEksJwSKwjXGgHZBmhx2pUZDen9ubqw1Dyw8KnMxWVRIO5RWZwbnan1mFrIcRdEWlWQwUJAPvtnGArkCuvCwodg+HJqKhzwkusLkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB9qYA7weHCwobv6gep5b9uRI13Svvuw9RBgA9zGAvQ=;
 b=lrHdArolrcfKXNRUbKIGa80f12cpBUATfFlhFQxpClTe9Oj9qixRdU1JZeHi15o55Df1EM9v6B5eXupFc+aKohox7cadA9oQfNY+7LJkLRpjTfFng1wGsc1JKy4v3XlXqvML53ENDeQAw/XWGmWcTk3jr7lkzCbxaSFQ2BK4OaE=
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:02 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:46 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 14/70] drm/amd/display: Add updated MCIF ARB register
 definitions
Date: Wed, 15 Jul 2026 21:37:24 +0800
Message-ID: <20260715134432.1975118-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6ec439-12e8-407b-472d-08dee2776940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RbCHWCA2qy8Cg1fUYdHMnDC53PI1Vah/qSaxoaPstixjGvTpZCyDZKqWMqGxxFUv1XFviRe4mfz9lobcyh2Kg1UNakXJ4PNxDVHrbNu2iG9uTVE+t1dAJvcNyGVW7AMoqI1aAMRjyF+rbC4T2dIS6pgJc4q1jpuNDUmpw8bx2oncFp0aT5UMqZtfZ1w83mTSU1kldbio1D/uE551E3PQVUxW//1/jS9+frp6DurXGd8sIEakh0zFUb5lU5gHLlutxuAoeRKqRtKSbyEVLT1AdypRxcFjzHTFJFJ8k2Qjd9ptlK2UsvfuYpI0PoMUqLOiGwkMVZxkUuzfewqD8/A0zcLggl26ebjSE3F1Fs1Q3zA/5lze4FOCkjs4Qrk2uKTI8oMlDKuYXrPKpXSErzEWbSU5O5SXAAGRFitu6+qSD+xCcXusVkKTSv17qEja9g20mbH6or1eoKdjss06fDYi9x0jm8WS/O20SEd/vJ4JjYV3iMM0TCctB4PnfIDObj1mQYH8g9TwwmqO14Vs3Raw6rys91xXGXgHuwIwlPVYXGTxRbgHI0usQ1UAog12q9RfHRwRhs5yHo9HpsmTylc+42cy/LSXmEq8/BjZTuCt7f5HTSl43/DCyO2NCQvO/N/0wTpMaA83O40/ZwbLjNbJMD4en73Xy5qBMQb9so6A7j/SPal3YBNSkCxeZj7hvQ+mpT1+Bpm6BHepasCBphCEVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YUp8BO94lOZY1M6yAN5+ni7RYwcpfsjQ1i6dQjnhNYRp6BmZcawbWtLqnzQZkJtmbVEkIj2jEE0R4+wmRXM4+6xeZs1a3+Dcj7tUQj+naANO1LiBnnQXGd114tHmiPoM6qbpaP7YCQxTmTbmd1yvFqmTiUvBBiQLUR+ehSsRtFIXyYTxNj01KEwL97DlL1CWfwxLKM3LBLBVv79XoOOPmRfUQsqXXAwNJ73Di/2AwJ4OroF/t9OOeQSSxFBHyDqBNheTRikdatDDOKe2egyjqJDFgoiyL5IYegjyED+xljqRzCchbWGhMUsMnLCDYzpODyzKYRxA0vRO87xICtS3uWzqyQ/F6gpdPqiCZClmp6n547aEezRw3q57V3WHJbN/+I3/pzZ9EUcaktonf7i/LwPpBSYmH2h4O7avb9qebrNJk8CWAUfN/3ECvpl5qIdH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:02.6704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6ec439-12e8-407b-472d-08dee2776940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
DCN4+ use a new structure for MCIF arbiter registers.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/hw/mcif_wb.h   | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h
index 15cb782f129b..aae0ad7ae835 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h
@@ -27,6 +27,7 @@
 
 #include "dc_hw_types.h"
 
+#include "dml2_0/dml21/inc/dml_top_dchub_registers.h"
 
 enum mmhubbub_wbif_mode {
 	PACKED_444 = 0,
@@ -36,14 +37,21 @@ enum mmhubbub_wbif_mode {
 };
 
 struct mcif_arb_params {
-
-	unsigned int		time_per_pixel;
-	unsigned int		cli_watermark[4];
-	unsigned int		pstate_watermark[4];
-	unsigned int		arbitration_slice;
-	unsigned int		slice_lines;
-	unsigned int		max_scaled_time;
-	unsigned int		dram_speed_change_duration;
+	union {
+		struct {
+			unsigned int		time_per_pixel;
+			unsigned int		cli_watermark[4];
+			unsigned int		pstate_watermark[4];
+			unsigned int		arbitration_slice;
+			unsigned int		slice_lines;
+			unsigned int		max_scaled_time;
+			unsigned int		dram_speed_change_duration;
+		};
+		struct {
+			struct dml2_mcif_global_register_set global_regs;
+			struct dml2_mcif_per_pipe_register_set inst_regs;
+		} dcn4x; //dcn4+
+	};
 };
 
 struct mcif_irq_params {
-- 
2.43.0

