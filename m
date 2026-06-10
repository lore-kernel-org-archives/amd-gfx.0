Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1290ACD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A320B10E867;
	Wed, 10 Jun 2026 09:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7PiPTyk";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C567610E867
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv1ul3VQbJbIXxnBgTe9hjoNwR1xWhv6ZVWtyVmX9GWrwjgrT414yT9D4nqqc68VySakHbCVsXN3Z4CgNPd3rhzGTOGFOqF2p+dx6PHVweWYuC4VpOc7cJnQJGLr1K7vHmIFZaL35IOFWHdEFVuvz7XCDQBPExpI5qpTPkYS5FHCaE1pOfR+0B0Pc26obV75V5JMaO5uzWvqo8EbOdlCRmJC/+BlfPGMrbwQyLK2yDpW03en5kgorrSj+o/PL+ZjVZcKiSZ5eL8CyHDQR/WF12Yd2cWyuFGQ7JlkKG2jxTGxc+hkb7qKFP/PEjgK7A8EMa7oUaK4EPwDdAnyhPm58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP+RF0ofGhZqmmUpU7d9B/qXw2woImznIMUyjX483lI=;
 b=gBGQhBspnXhKgWDwhp3aVBwTdjP6DO6aONKUpnILjnQyjCUtPmHk0xLHCTjoyM7M0RSqVA7HB+eAn3LR837G5rCzB3oZxk56c/bQW8tMUrxdMJquDAkPYwKPkWyjETEWcRgNnlPg+hmq5SIICvE2PGy88d7RTt1qJWK8BldlD80tWSA4jJM+fRktQt+VDi03Ige8o4AErKqlCivh5H3hX8SIj5tqJRwdmd22GvutvSZNg3jMjNlKbJ7sj+3nAizEBOaMjUqhsT5sYSYbsVJOVrkaG6KGtblMT6O7GrJ8ovLfmxdeQOI7SpUcdDecBtj6ttJbfMy7Ufsj6oMdzIbKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP+RF0ofGhZqmmUpU7d9B/qXw2woImznIMUyjX483lI=;
 b=R7PiPTykoMzI35qw2bHZJ8krWawdGJxaKS4nT4QvNrZw6U8WSK3dUWMvQhBCvpkyJLn5b82yd84SAC35M5RC/lVJ1zLraWh50c7AOm1bh5d4GybS4hI1wEHkakXb6/rJENk3FrxpnjQVl4kv0pdziIHMx9gXAu8ce+CsTgeQ+4Q=
Received: from BY3PR10CA0001.namprd10.prod.outlook.com (2603:10b6:a03:255::6)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 09:48:17 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::1d) by BY3PR10CA0001.outlook.office365.com
 (2603:10b6:a03:255::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:48:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:48:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:48:14 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:48:06 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 02/32] drm/amd/display: Add a new interface to set idle opts
 in clock manager
Date: Wed, 10 Jun 2026 17:44:46 +0800
Message-ID: <20260610094639.1965367-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce62c8a-5e85-40c3-dd95-08dec6d56634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MHSoOFXqM+eBshMMgA2iIwdQJoRWBOiNWAS8VZxlYJqB8A4QSZHAi4vTkKW9ezjxClz4v2SVBYAF1p5rPGlNYkhu/vFCRdrXBfQQGgvaAWXrODvg4IorjJPvbaR+/7Kt//MuG7SIukMSjMNfgQk6KkTEtP6VHrl5CDtSF1BNZ32aYJUvk/vVkyFhhXC+XdygpNw0G+NHF1fPQaPqd6MgDar3uGrAGthFLdYLyXiwSNgNRUzQKYPSg4cgPEtlpU+0Dq0lbESLq5A7Kp9CfmswJu1B/V2aElz6hZQqnxx7dboMcoVtxqO5yElDECv+0l4DFFYRRmEe8XpAOrRdN2E17hFiMGda9GE1cY0lIl6KFD775N6Rk/+wCu9AQlP8MOAEyObtVKsU/LpsmbQ+CvLUvHCvMogM/lbryAw7pR/3ljxcW1fGA2N9HGkF7IOeR9Iz7EWgqre17vX5BWHimEbDxD1ja0IXZfK6MdHL/Uak6qT63bC/lLxC0MkPRKV5+N0lNvoFsXPK9x7R4HwX/PyUjgxYLL40bQ83KPoMBg5Fj579MgjJ1LSyHXFLCpv7hHv2FLslcN9+s59VTphlA85k6XMAtFyB4UygaNi7hjHXl0i8rNv/ii9l5g5niu8X8N90Vk29HBdkajjqCqUvhbNBgOQ67L4pAqzfChyjstZxNrEXIoKe7533LMuvTpqy5HkZBlRkqpseQtRgaXL3AuzbMYuz1RjisOYS+O0263rw8uA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZZpslDbG+XGhebv9g4QGRcLcV5oMsAtwoOiKpqzU1yTlvmN9LRl9gdum/e2uVliGXhQOZMt76mzE7POOSxF2tSI3RKCaOqkOIS10rvXr6QpUjzfi4evgldyRuto/4JQKnw0v5yaT1VdiESHlqiLgjKGHQXyofsJsH+3kO/35KqcxehfR7cOR+DTX+l6NxRWVlOwzdgpuuMhT0QLZuZdqxTXHU462kUVqiE2WeNJVv4+/cUA1OOWn1oX/8FTVniUquP/VojRiAlucRLspe8NfGb5Mw7d86yeQckljtv+bLLPtdUMlbjZP7NkP04kkrKQBQ5OVEcMTrB0+j1jjC1+tqYyud6oLoyOE6KbwpoMx/HvhWM+pbgovr6sHhCUryF8FvlS8qtMpdrMiP23XU2JMs74meOI7obltSQYjw/vJ8KvOV/dKLBKDoJj/eS4SeYxD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:48:17.7243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce62c8a-5e85-40c3-dd95-08dec6d56634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
For future use in migrating the idle optimizations message to PMFW to
DC core.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index f829ce3f70e5..9b5bdcddfa7a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -337,6 +337,8 @@ struct clk_mgr_funcs {
 	void (*exit_low_power_state)(struct clk_mgr *clk_mgr);
 	bool (*is_ips_supported)(struct clk_mgr *clk_mgr);
 
+	void (*set_idle_power_optimizations)(struct clk_mgr *clk_mgr, bool enable);
+
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
 	void (*dump_clk_registers)(struct clk_state_registers_and_bypass *regs_and_bypass,
-- 
2.43.0

