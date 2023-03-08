Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D81C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 07:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDD110E04D;
	Wed,  8 Mar 2023 07:11:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6720710E04D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 07:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grFADKIMTOLPJ2KVRZruAot9hy2B17lONNKLYy3aF4NzYJBv5XOG+UISZvoLNF6nKAohsN+P4Udzw7HL6P9+MV1OoF6RXQnZYryNBTgoYD1OH+GYPYuhxeCe+n+JZqnbHJdjkTm7cboJJwvEmL8CyCJNj6/NDowmWojVhUSWpYBFFZLarRahaHO/iwBmiaoNPgAbnS8u88Ky1X7do45MFppmxpKocRfq6XtPvvRzH2FHenrPblZOvULLIFq7MnG/Gv5tEe97TufJ18PGZimCAh8WSDZzCxdG+1bSGGN9cOeYl2OV5QxDVKz6G19YBVJMdJKuQT04N50tg2lzxFI6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoYSQc5gpEd914dqjiLiQqz+gTq+M1bTkIHBqLtQRgw=;
 b=ZSeR9VPj69JSRaFiMT6MYciD+C2sKlku3okxdQvHFNlDoBz/EnaY0HqesG7dsFBWp+/+1hg4gc5E+AuomNA/H3j5oevWVbTtpeqxfXbKuIKbpxLrKAIe8SV0miT0xTJ/Ghnyy7MWLjoY0dtiUPQ4pHdyXjTNTMd+6YbsHsMvVu64bKGvp5tvDplPFNwQ3VDUOiISwfyw58LblJVuu6G/tHnjvL5/jt1c6eQmTB+mVdTFxGnoxLxAhW0su1qu2qIAJwvmySU7+nNfZAs/L1Vwd9ZhFglaa39mUPa27n0+ppmYEGkPjUa4NCctWr177cLrVzYljZhvBP3+T/8NRjshCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoYSQc5gpEd914dqjiLiQqz+gTq+M1bTkIHBqLtQRgw=;
 b=M2JAo1B0kg2pIOBja3y2zscqc61FH8Hdbb0/fPj03vF7cpuFZT3srAHup5+rW2v+kva7UBQPobjoIziVzvffWmU+GxMzPsfGrspVqNn7RFo23LmkzHXnYPt/vmVRPvobGjwxYaCSxSXeDN3Q1kb0B8XP3zv/CLH+wLb8nASzKZ4=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 07:10:57 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::a3) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 07:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 07:10:57 +0000
Received: from llvm-tr1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 01:10:49 -0600
From: Shirish S <shirish.s@amd.com>
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] amd/display/debugfs: add sysfs entry to read PSR residency
 from firmware
Date: Wed, 8 Mar 2023 12:40:35 +0530
Message-ID: <20230308071035.98892-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: ac27cfb0-a325-467f-8b15-08db1fa443a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q88JkHJD5HIKgi17bIUC09f4+1Zhwg6QAOfs431MX5eQF8LRummjt9kcjuVg78cHHtUcVzwOipZyYbLO0xsps7ASdZBhAIx1tEO0ro6vhgrTuZ3RRK4+9tEwq9Vbw6XVhOO00oBjar4opmS5rTxbZfABWrcefBGzIZP/PAyhk+cbHc+l51ZXOmW84h9id4shUfQFo/WuMSkI4HkhoWfrJLyuGDASDsRzAP5sLAboYc7ZhgJSeI7UTko9flFT8ykQNOG++uaQZq6YslB/2T8DMmcxtFjkhMdZxOfvm7RwwhTsIpogg9XMiuI69bMw7AIRLyz2nubGE3/yPhvTFBufJH90o+kqjpUBCJKAzaT8PnkRuv+meRkH44ImxxW4gT6XeBC4937Ym7FMb6sp3hJvpPUt/04ewgl3uFYnM4kqhAr03xwmoMqXLqj0FxWCCJ+LM24E1XS8kkJOK9zenKc21bsOumW9lx1QyYefhPgFRVfQzdzfk2y14MX+ptrhlgDA02GCrWA79Hlwt6xpLRq7O/zqLBPg69iHto8FM80QWOOKp1dYGJZsepxiceHyZOrvadE0d/hqBa7GpeV7UsM25lkcnhmgTmO2ag5rWsPZihW49Xatre2HL53/KVstsfsmMigpDZvNgbzwlHMGJahFdNJw769PCh0SO4UYXUK9Xd/XSr14KvzKH5eIapTbqZ8IhF55G14AkSkg/iVPIZhpCVgFO/daYL+edM7ewfJ8Zg0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(40470700004)(36840700001)(46966006)(336012)(47076005)(426003)(6636002)(54906003)(110136005)(36756003)(40460700003)(40480700001)(356005)(86362001)(82740400003)(36860700001)(81166007)(1076003)(26005)(82310400005)(83380400001)(16526019)(186003)(6666004)(2616005)(316002)(7696005)(5660300002)(478600001)(8936002)(4326008)(41300700001)(2906002)(70206006)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 07:10:57.2870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac27cfb0-a325-467f-8b15-08db1fa443a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently there aren't any methods to determine PSR state residency.

[How]
create a sysfs entry for reading residency and internally hook it up
to existing functionality of reading PSR residency from firmware.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index abf7895d1608..8ff2802db5b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 
 #include "dc.h"
+#include "dc_link.h"
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_debugfs.h"
@@ -2793,6 +2794,22 @@ static int psr_get(void *data, u64 *val)
 	return 0;
 }
 
+/*
+ *  Read PSR state residency
+ */
+static int psr_read_residency(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *connector = data;
+	struct dc_link *link = connector->dc_link;
+	u32 residency;
+
+	dc_link_get_psr_residency(link, &residency);
+
+	*val = (u64)residency;
+
+	return 0;
+}
+
 /*
  * Set dmcub trace event IRQ enable or disable.
  * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
@@ -2828,6 +2845,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_g
 			 dmcub_trace_event_state_set, "%llu\n");
 
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL, "%llu\n");
 
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
@@ -2991,6 +3009,7 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
 		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
+		debugfs_create_file_unsafe("psr_residency", 0444, dir, connector, &psr_residency_fops);
 		debugfs_create_file("amdgpu_current_backlight_pwm", 0444, dir, connector,
 				    &current_backlight_fops);
 		debugfs_create_file("amdgpu_target_backlight_pwm", 0444, dir, connector,
-- 
2.17.1

