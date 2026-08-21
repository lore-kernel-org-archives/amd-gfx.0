Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD411C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A51F10F365;
	Fri, 21 Aug 2026 16:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bu/r9YQi";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7191F10F364
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvJFU6+LQF3V3XmGGDskk6poSFGNB01PIWpo1+8vuTeX/kuVePcm155ZSexNX7OwMuxe4rB2Jl/1jadfb3oV1dnPn6fwYV2kMQNu7DjSkGQa1tsJJVMniW6n5Sp3J8MTocLWqi1Zz7xhUYY9YqAhDCxbUC1dN20aDhjIM99FBuCkEBhEG34uU5m8hBs+gv3rfnOpBtW/ZCW2NRoa+sh7oV/PCD44cfFjZMbbA+z7Snoi+hz2aGMmIu130wUyLLkG5cMmjz2opNBnvNjtV6N+t4J0hCekFPycwyQp9VnMVS5Cnu0GuGTmr9tEbt9cCZZ9Q99ysYsu3DjEP996+5ALlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/pyjgePbsVNriLUDitWCPi6y+hsMw6YeZwRh5eR91E=;
 b=ES5CEnxIQ1ROpohUS4Y1jMU6P28wF+kUW2vwPQMxqVUIFOyyvmTyp9ry7k/WKP7nXAziR5cByuA39u+xMqoaJTpPfgo6ejTWNDehpX5f3eI//bXNvRNY3E6S4H6rukPYzUqnAjPxl9wEBsx2mTo/mKcC6OPnKMswwfHzVWUzOQnl6W0/wGxoVd41D6v4i2EzxsZmGe8N1hc956F2cjOW7QtSlWcGgV9e/i3hmzChpfjvLkdTaEj4F8P3Hx0U8tP6la7CMTfQRDcCTEpoiamPa+vPPV+fAJK5H4vx9YvzmMhHO2ieFDsFiRgXEKEIlTIyruuFgRp2rJIxEX4vMkDP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/pyjgePbsVNriLUDitWCPi6y+hsMw6YeZwRh5eR91E=;
 b=bu/r9YQiuoOb1pObJORqxoZkKLyfejRUjbHwBOyLhT9Usl1jZtmf00iDS7G8VyfTBd7LE5UGjsTXJxXvlmvWCg/fXxJEZFhccL8wWautPQD0ZHAJCF7MUZ1dcz6vFPBa7nnir18RrAqdyumpwNH24IwBTLiVDOlk7LMW9tES/bM=
Received: from CYXPR02CA0075.namprd02.prod.outlook.com (2603:10b6:930:ce::28)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:10:12 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::41) by CYXPR02CA0075.outlook.office365.com
 (2603:10b6:930:ce::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/13] drm/amdkfd: Skip pairwise CU mask check for GFX12.1
Date: Fri, 21 Aug 2026 12:09:46 -0400
Message-ID: <20260821160958.753063-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d264b4-49a5-4359-aee0-08deff9ead9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XSoMean3Oa69hYtckT5aaxCTg85yzUHV8OXkGtbN4v7NXuajJKC/yQtoHEnGHPkOQhtpnx1T3Uav7FbO9Ybsi4SrWBeimppVSiUFPMbwfeAqJKKrqrow0ur/lYwHdy3tRCXtjwPmp+Cn5A2hhG1eofCClzI5yPR9Z+srk52j1bSpiYlRZ1WYTA0QbQh48gZ9hAyjiVnScWZx/MU1Vz27XDwvTdIEoYu58Nt+KUsS0N0+RpUevXYXJMT3OqBvCBN2kePKs+e9kfiW21r7Bzfg8Pib/ndL/trmZTk8It64uRv6i8UEaedpLKFWu3B8OMz8Ag3eKYnBT2pparJEZoDBTCpP6AkW6tjWEi70nTO77sFyMn59XuwfnL7YTAQt5WKYtP5Oqsa2IG+kQV1wpqHaZInclc4iYj6tf2laqpT6jB1rrHPgj1rb7w0mW75RrVWgWKC7EDrE9yNDbyMdNN6RDw+Lwh9fOqrQCosMnIYwHqqQV+TjpX1YrXPs1u0yVTiI66wa67/HBZoW4mKnUeys1MQ/KVblKNI9iWJMvXSGsVN3rEeDOzYkOROzBsuIdjLxJhU6Znya3l/b2Z9y4ZBayhBgJJhMzzmh/Ve/RLwQYRgIZ+xALhWGjm7xRIk9e+EGHtaph63+L0+2JehAWNaddZvom+K+/xkaYQUzrHLRyHTw/u1OUJf20lwr8ki0JX2/KxjgyVNqu/s9NcyWbQGRqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1RnG/GbNbsnw46CeFBB7NowI7bw7k9JkwBc4pgw7qMu7LCT4o3pLnDKQO2mKrXuAg7Jq9J2SVWnChfn5Gi7RW6C+5kG/wEZK8r+vWxCyNFiJJNTYjOZAMn0v92aKJikUOElwbKM7lkNXyKkx48ALeIsl/wyWn48qQt1vQyLcAKGwLm2tosE69lf8TkKIUg3P/AFkJd83WgsTe0ogA2KqIvfHj0/BdzsU3ORCk6XgHqBKms3ugjEYPHE+7wDGZ9rdzqPIuE+hQWiLOmSmBV48MJYhshBPI2OIp1ZB6Q424vwjBh1MpNzH/8wK5f8CsJ6knD9otxD3hOLU4jEun1V1Q27c+nZKOSP/zguWeiPZvEJceOuNx/ndoRPi8K00dn8aws5VQsIrUN7Zs6XEOWBmwD3HF7U8TmNbXs7bphOfblfM5GxA/TBdnV+uqadhmdcd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:10.9822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d264b4-49a5-4359-aee0-08deff9ead9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

From: Mukul Joshi <mukul.joshi@amd.com>

GFX12.1 doesn't follow the pair-wise CU mask requirement as
is the case for GFX 10,GFX 11 and GFX 12.
Currently, the ioctl call is returning error because of this
incorrect condition of checking for a pair of CUs to be enabled
in the CU mask.
Fix the issue by removing this check for GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ef1d1cb46152d..9e607098c3a09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -663,7 +663,8 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
 
 	/* ASICs that have WGPs must enforce pairwise enabled mask checks. */
 	if (minfo && minfo->cu_mask.ptr &&
-			KFD_GC_VERSION(pqn->q->device) >= IP_VERSION(10, 0, 0)) {
+			KFD_GC_VERSION(pqn->q->device) >= IP_VERSION(10, 0, 0) &&
+			KFD_GC_VERSION(pqn->q->device) < IP_VERSION(12, 1, 0)) {
 		int i;
 
 		for (i = 0; i < minfo->cu_mask.count; i += 2) {
-- 
2.55.0

