Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BEFC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E359C10E23E;
	Tue, 15 Sep 2026 07:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uHaJGhHJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A704B10E23E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmmfPP4jjzBSdPj+NxQDZVf8MlNqnTIgHEknEY6ZqpnOJdH6ePojBc0ftRppaLyHSCc2hX2bTMDJxyDJTfu+rHrbhXk9vdIb9U9/2qCSqFMqSNX41QMd7NVHa+d3rHTQpm7xaFB7j8hhbmEEgCURanidYYfdZUgC5tw9mK7ZMG08zi7nOrP+6QYA9kXv8ORclml0t5rZGFAeWAWmwk6CjZ0UqGY3ESb+A+f7LZonVzlC2Dlln7cHZaNPfJpZpmBXNOho/c15OwxWY/OmO0M/R2MxJSICpWjB91M5qaE9yNfvPeXeocaKFKnUhDii+HbMNNj91VTL5va1kNKQtiFDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxFgQ8FHz8Yea5SQiJCgIW9u3PrQVZPYDL+4hhDcUqk=;
 b=PJ3sug4437jeow+VjRRRqFLJ/x1XJBHfPWs1GpOjx/WXFnwkK8w+07F08ZGyxeIFU7ZDzi3k9OjE0w/Ac0Yl2Ihziwgxklh9l/s/KWAbP3nO0LslbuZRf92GHdx0vIIrYJPL3eVvSwbK/JHOt16mRS0fH12SbNUGxuxJKUMB6JpY4KkBjKSZczB+jwVs2FB9pRh/wnsSk0513fEYN9qpn6X92DGr4lBYMw42/xnq0pcFfaVPbh5d3zpZ3M665YOO79jfuCJOwszZtpQ3qTd5HK1GhZ+tSrdOWADZ7DYKvH2rsWrtqi9yEzHWEtQuZoHid75yAI27nVPL+8u4oHhvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxFgQ8FHz8Yea5SQiJCgIW9u3PrQVZPYDL+4hhDcUqk=;
 b=uHaJGhHJ5fkb9Ra9++LhzDrjcbYzCLMMzQPRm8fKPWYx9yvkB3yZlvJtvEGmraGFuEc+PxLz+VJf0gChRvx4txVolWkGE6sn8BUOE32wegC/WJQORe/v8IsNwX5gQWK1YJqWG/4EgjF5fQQRSCkQ30mJIT2cCAbE9vXH9PYfHY0=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:16:22 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::1b) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 07:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:16:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 02:16:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 "Dan Wheeler" <daniel.wheeler@amd.com>, Leo Chen <leo.chen@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix redundant NULL check on dc->clk_mgr
 in dcn42_prepare_bandwidth
Date: Tue, 15 Sep 2026 12:46:05 +0530
Message-ID: <20260915071605.456039-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f7143e-c6bc-479a-62cc-08df12f93f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: KQhVqWmD0R+WJrSojeM/+sOWfXeYvsbqWRIRGHA9ynJ9mXmhrZ+DCJEIOsxlJBNvTWaqAwNobKNyanWDtnZNopYvPAnY6I7z1/3SClN2EVQrUln9byFzRYbMv2qZOJUVOGUX3gDT1YzDJn9ovTYH+lFe3EDWP3OtbXKitHozfcr//aBs0WLudAWsXpHEKv6px+q+Ob1qLFPNcjo1urjasYIOqF45JkEa1zYl7H9ZLnuuV4L2k016UVC5kxlxLRJsUmVS/TcelL1KCDyfcpFE+iGJFDRVQBzJLLsUvTWCqa3617v+rkJfVwSjVIM+vLTlgwM9IrRXfWoklWihBEqV5+vqxIwQ7t7ugt5+wl7weX6J7FpbmzWP3V51Sb/M75yN5pbt6domgKa2i0fLtllPF27anwIphnjKXViw+7QPTwZPH6Y/tl0Gq+WhOd6aRMZtSlZiY028I7v+BJG4qybF1yJSvVyY3A/9QFbNHeR3TvhQ/wNt8iYsSfsbIg8djbhch2bZDH4iuWPniOrpWlG59+Tmq88JPpP4mi6N5RTOxbIgG5VIXB8tL1yVeuD5jMToN5XGHjW9AqM9Ch2nmmPBHSfWhSkKQKHJjZ/R/5VuEgpUiXoXNxNNloZzdocwUmfoI9AMkJzRcfOIYTEmdHEf9i4iy1abZxb+Zh5T8etUR7JnhZIU9TSrSYXuIZBGIMYNu6r8L3vFEXF3pv6G0CWweg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gKKGN08IRJBig0jWXTfJZPDHtZDI7+wW9ScSbErumoSOJ0W03+jKOP7bgRnDZVRuTn0Fjug07sLOfnLQMxi7HTTNxKnYHZ2XExxfVVb9yI12gMRxFEqm6yoB7a8UkWZrWoB2vWuArvbqesjtjnHAZepoBpPgu4BMw2U/I482JSPnWy8QhZOMq2CSsH9zWudfI7F49YgfDEA9j5yFEJCX4IzIpr5qhKbHrk2/hWiI6G2h8xXu97zYy4mR+a+e9Czzy3GUoQdzaRp+WRAnx/51J6CI4+7fd5mcw1L0/WDlqwQNUgmdNUz1H8h87bX5NWU2teOp+UlPlhQlL9LDQ7A8incV6dcwBgKsfbDMZXp9UrteefWmBSw5QwiMNkZlW675hP5Lnp7wpcp3IrdV0JowmYGateSo93uhgti8elziAIbBAs/giOK9XrxX5e/usmDH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:16:22.4923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f7143e-c6bc-479a-62cc-08df12f93f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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

dc->clk_mgr is already dereferenced inside dcn401_prepare_bandwidth(),
so the dc->clk_mgr NULL check that follows is redundant and misleading.
Drop it.

v2: Drop redundant dc->clk_mgr->funcs NULL check as well, since
    dcn401_prepare_bandwidth() already dereferences it. (Dan)

Fixes: 080f9655cf2b ("drm/amd/display: Register DCN as a PMFW DF C-state client on DCN42")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Wayne Lin <wayne.lin@amd.com>
Cc: Dan Wheeler <daniel.wheeler@amd.com>
Cc: Leo Chen <leo.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index ee40ee8f62ef..21c3d108abe9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -783,7 +783,7 @@ void dcn42_prepare_bandwidth(
 	/* valid C-state watermarks have now been committed to HW, so it
 	 * is safe to vote "allow" to PMFW.
 	 */
-	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
+	if (dc->clk_mgr->funcs->notify_cstate_disable)
 		dc->clk_mgr->funcs->notify_cstate_disable(dc->clk_mgr, false);
 }
 
-- 
2.34.1

