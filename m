Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C85CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40A510F0AC;
	Wed, 24 Jun 2026 18:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hYqK1mmD";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F3010F096
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdD8mjD/DB8M+4kcz5BrA4VSRlBsYenAlZdThuwlfyAdAhqCtx5Ecr/JAkh2JvIygYdLlFkUdMcKybko5tmFp1Z3OCqMJ7bTqHCqT4qn/N+u4yybdZkrsmB4WmFupEKf3JAM28TNYzZZ/pEjzMWKdULtKqWpk+HL46JhMT4JTuUjWSkfWmTqCK2TiXcOaGHdUaUJP05q3oYM9JIVbuDMTMrGdM3J+v5ZcgLrwqLGWbq5L9jkVGShPeAN+XbIDRTvXTEc8FREzUmnP1/HGyd+ZrWqB81hlcdkGYvRjr/luzbJtJoskeNSbqmDk44DSy+kbvzkmVukodJxWyFhIeTcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehVSBVdXPwCCOQWzfqaRYZEJ7XlLv+6RbkM57YzahKs=;
 b=FTaCwwG1cWc6lO+Y/HVJJwgr+TdKb59omAA0dcG8iv+CvClgZyceTSHviToMuTHJLpdPBJS3JQ5N+ynDiUrbb5eGaRPhZERLatbd8dPkOzZR3+YOMZzFcYjKpRNdf5gdQl0BUjdziEA/lM8Du8D0ijFu66JhnZ8xl/hiFTSqarfFKMU5oobjjUff9MBHK4v3miCUWW6RB6glBw+JhF0KdTDd5N+komfXYwAm83pWZsbkoNImMhMToaO6FuOGa2B+dw0iLENKgW5R2vyoz738BdvQOtQlj/tSVNAzw0IGAaWlhqrcKeQamC9GhbzlPEL7tmAUU/KF4HqOlkXDCJziIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehVSBVdXPwCCOQWzfqaRYZEJ7XlLv+6RbkM57YzahKs=;
 b=hYqK1mmDaWy7F2r/oWFL8sZie+qAX6djQGko/JLrd/AoSkD5MzHIbPW6TymlhjNdc8z3sqlWf7HFNVPXH9d91SLXHUNs/o8kyt5v/cOOP1ta4FbMRLOwlWm9KMgWzjvy7b4aU4R9L3lTE22++UZFOsvUr7x+u5vt8Azji4I3b8I=
Received: from SJ0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:33a::18)
 by EAYPR12MB999182.namprd12.prod.outlook.com (2603:10b6:303:2c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 18:09:45 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::aa) by SJ0PR03CA0013.outlook.office365.com
 (2603:10b6:a03:33a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 18:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:45 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:38 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Andrew Lichmanov <Andrew.Lichmanov@amd.com>, Leo Chen
 <leo.chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 25/28] drm/amd/display: Disable mem gating for DCHVM on DCHVM
 init
Date: Wed, 24 Jun 2026 14:03:23 -0400
Message-ID: <20260624180829.4775-26-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|EAYPR12MB999182:EE_
X-MS-Office365-Filtering-Correlation-Id: b260d6f7-2fb2-4779-f7b6-08ded21bc5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qFPJD7SadsFyt6XnpzLMEU9CfelxTW6g5HfnhtmiYAdJSXzj8Z8zVZdXsZBxOzAcVSsAzlG2HE/unNX3o4AqvcVHESBF0rVkL5aLIMrzHJRkVmMfRfLmhSIvs2YOnbs+5roB/zxPFDSh5yeDYx1A1eGZSO8BAS70clJmy8kd8pmuWZvBfYvN3S+uVNYaLhTRlb/Twl/ucgqsbF/L3Ji9PXg/0FFMId0lyLmO+iWb/ihzq0TfGienouUySbtaQs70GnomyXq1b+C8hzI4dD5apJhG7I1vGCV5sTE2Lztrm6JHkPrEskm7jsAfAXYfTUhuui3IiPNGKUUIZPuDm5cu1yzkD5lWH7aAfyZOA5rTnUafpDYcBCToCZ28BXeUBKWGZ9x3MIC7REcMvz6HjATp8EnHqqSJzaT8mXtDGoa3yvYg+adpdXemxIF4zt6KZWdnGXZOoYJ7Spakbo3AMZgc6EVLGMuylJ9EPV/BmMDkRJDEZTtS7V/T1RBNQ3Tsv4uzGzZbZeKiJMGyAp1lXtO0MiMa958tditrHhY0B//NyGlizjqapA/AhsYon27t+WWTB6hIODHdIwDRK+UwpkW+LRyG5r5yIdhKTM0gyh3xlfHfgnMtDACDgLKsZRw49CcsCzOVZZ5PzTLRMgwNaGIbNAhYJVnZ5DNMjwe5P5K0lFJY8dxDv2oi4AVslPBvh4GZMNAkvMv4vQZCpM/uZD9oow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aK7FYJsz1LX1aIuLx2OFr/1AuZFISpzvQbY0sgA4n7gGYTcMjuOjG6+gke5FsEGn/0uENIjnurP3/9290U/BUgHyEw4XF7XdRXLb3bB9a6tBWj28ILCIlf8cP7YRRrAyG4/4DGII16WI8/wMzCOoBDVpOMcJ+AUiiAu0aeff9vS1f1XBgdtrykHttf/1cBmCs0dtMniJX/kyBz19mJU6Hoi5O1PSHrC7e8P3+g9uy7wnjr2RstwfYSj3Hn/dR3VBsGJIKq8HhtOujAfQ9ylD2xO7j4e3m5aUYjqO+3A8vaknyRWGZzfYbcmj8H7c+oVvuGVHqhyI1tbXf+9pGX1F0/KtoaCm59l18gBbuuoqOsKc2eW5yS00rKm3Db4DZ98VUzbj+zlDjPBiHsBnZdlyfiC65B2R8cPPtZ0CPxuQkGcj6/MFVuz/EleI2tSX+3LR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:45.4787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b260d6f7-2fb2-4779-f7b6-08ded21bc5ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999182
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

From: Andrew Lichmanov <Andrew.Lichmanov@amd.com>

[Why] Hang occurs with global gating enabled if req=1

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Andrew Lichmanov <Andrew.Lichmanov@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 82d4e3e0e5e8..5e5a7a74346d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -571,7 +571,7 @@ void dcn35_dchvm_init(struct hubbub *hubbub)
 
 	if (riommu_active) {
 		// Disable gating and memory power requests
-		REG_UPDATE(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, 1);
+		REG_UPDATE_2(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, 1, HVM_GPUVMRET_FORCE_REQ, 0);
 		REG_UPDATE_4(DCHVM_CLK_CTRL,
 						HVM_DISPCLK_R_GATE_DIS, 1,
 						HVM_DISPCLK_G_GATE_DIS, 1,
-- 
2.53.0

