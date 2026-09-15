Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD278C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4C010E08F;
	Tue, 15 Sep 2026 07:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzA0WdoI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFDF10E08F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0Qp2bRH9xlQuJ5XCQZ/2UYnqgCZr5jNIfwveyzKDs0T9bB+VfOwMTRbkudS+kzJvv993bqReLUXNZkCne4YWOMqGducvEyXkvrpe0nlDU/6cfTlwvMBFKqzGM6teKAxw6ugFcaIhRtEe/cXSbB+6RoQgIYR0J3NTulCkhVTHH1J/F9It9G2Z0QopUm3ZUmStPA8XuiauDBmhksb/Oc69cm/Dux2yN+QOWCpHvPChHXUHs6lA+6KpLPo9aWqUapRwuVamZFCLqAz/JRQJ29uR+17ePz94rrdNsaZdmJnAjVuHS2YH++UcIjslv1oXBeQQfVI8O0E/qbQHSKlWlUjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAA7VbnhJzRnXDSpoUJsNIbduRFQK6cQAmdqOBvL0dA=;
 b=CqwvOQn+nGGGeoT0XdiaP3d+YphFYoRBdd+D3WSpaKrIrl93PTsugHrTq3TruHCRgJyI9ktJ78t+s9lD4uc65wcfAww6iUkT3Jj7YrsJKaD4srdB6ROPTJEVrJ50tVgihAIlYIMESd2RH8sCo6aDZhq6svwhsxNFBmlxoVFuhS4b3WPfCInrmYtOqDD5mGF4yneIpKu35hMF31e4YDtV/BuESEyemLpRczvjJthPUkj2LgJOjvST45VFJ8xGCCq+Z42E4RYl3WScPUx1nq5iqk9H3PQ+mPi12V+1O9wwu9RBGQuHNVZQrkxzvcj3fnddunQehozZrd+wC5pMPMV1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAA7VbnhJzRnXDSpoUJsNIbduRFQK6cQAmdqOBvL0dA=;
 b=vzA0WdoIoq2kBfDmI5OCe9Qqw/66VLXcVftspmaVZr1+hWewfMf6f5yOGiUjJ9MI+gfAbSOOVHWWKJdvLfc4wd6O3Y+LR/TkH7RUl0mGpoDhA/AKxFUjbJKHE4mvOcLNO6bwi++GuqVM69jzTXsdrI3X/j1Voa3CoCtE9oWj6zM=
Received: from BYAPR21CA0026.namprd21.prod.outlook.com (2603:10b6:a03:114::36)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 07:13:16 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::4e) by BYAPR21CA0026.outlook.office365.com
 (2603:10b6:a03:114::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.4 via Frontend Transport; Tue, 15
 Sep 2026 07:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:13:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 02:12:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 "Dan Wheeler" <daniel.wheeler@amd.com>, Leo Chen <leo.chen@amd.com>
Subject: [PATCH] drm/amd/display: Fix redundant NULL check on dc->clk_mgr in
 dcn42_prepare_bandwidth
Date: Tue, 15 Sep 2026 12:42:29 +0530
Message-ID: <20260915071229.455801-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 804e00e8-1f3a-40dd-9ff7-08df12f8cf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: FfHKyn6e3aqfBtRvhPCco0+BG/B9gFvsKOzv+M9bp8CXmAtMwJyrM25BWu3M8zVJ2I7Q0aGqsBNVlL//saf5MqkSEzq7a6ZZinMcTvfLgUHxxMfvh/JDGSsGezvAK5n6m6N5xfkF1RLK5FUJFhKc43TyM0/18Ro8ZwhbKVQN8noOFE/jSqozBk2Y3O+HPgtJl0v68b5jsmCn23W9t8YpLNxOfEqoZJMg7o9u3qB/q+ZQMmM5tzrvHvW3KkZwr2w5XE0GwbsEV2mG2HSUZvN1gieUuckBy9aergFCvlcvg/1ClRnaK85y4Q0aIZe+WxcZtLyDXcU8jkrq/7qtTcINULXCqpuZvLhA6yIYUxn3fd6vcFhu6OJ1gUquNk502+SmNOXUUZCR8quBLu9DcnDBscnIMZ4OzLQRXNDITERi8UcxVVMFzcr8lUlqRGyHCuDkeTAzqCtf0mm0Aah9gpRiulqRHbXeJdnxSu2P1H9dSUgC8wClCLxA0dI50nWocNrchct9arTJ6ispLd6q0CzJYLaKj8j8DtBXYjcANlIHq1y/1SIidof5QZTpF0c7bY0gh7McYpksYRRGifqlvZIoEvjjK6aY5i8fXvcu06Gej03LdWidju2kY+cvzscG8lg+BV2m1VHnBvYTE8eP+4Vx4dKB2tZ0GSUy5EdyY+7jOKZ9mJ5HlHSY1ikkiEURLbehk9VJ793nvUN1u5fXAXVtSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vS98o6kQHIIFxNY4PbiCOcfe/SN8Kq8WO9Heq2oxfzB71deGRS4bBPGm0PAkEJszedPI33aZ2pqTgcJvxwMkxXZAGwHtlW+WduNt3aQL/OFfssfcbKO2IWZst+mK7pO0tIUsPKMksZit1Cc97qh36F0MiwL25RKEB+gZ0U2DdfiC4LTMJLyg971y/lsc681GBUPecL4jH+Sxt2c133NpTSix00+vQcMDLMywIDlPvarHxiG5TfGTQDVmCydZUFwvnd9zbCWiQQGulkyvB5r2RTLR84k4R0bD10pkHV8NVtJDJFd9fmWpgd/YcMFaAQ/PfT9lRIlv/2ubWv6XoE5QYoNy1j83Ul8qxFrCw3cQUHTiH3j8btFg/Vj6jWTCeccmts4/QKMDZ04/7B914NmkQq10lM0e/e/fb/B10yDLUvCKIZuzyS2vibYUCHyRky1b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:13:14.9254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804e00e8-1f3a-40dd-9ff7-08df12f8cf5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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
index ee40ee8f62ef..49af05d9e7cb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -783,7 +783,7 @@ void dcn42_prepare_bandwidth(
 	/* valid C-state watermarks have now been committed to HW, so it
 	 * is safe to vote "allow" to PMFW.
 	 */
-	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
+	if (dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
 		dc->clk_mgr->funcs->notify_cstate_disable(dc->clk_mgr, false);
 }
 
-- 
2.34.1

