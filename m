Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44DCC5DF9A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3194010E0E6;
	Fri, 21 Aug 2026 16:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2OPO4yjI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B1D10E629
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOzvvJzzvWAcs0t0h6pe81SWbZeby4qCphDl3nvNKeFL91sGRuWHokafDVoNIUeJaTzCWyRjBpZ5lG3yxzBsicuMeBag0eHmOOVtdLZ70W7CofweKXyrtVE4kLp0xsgBxPmjmDPhnZ22jPc3UNQP4rziJ0Z3N+9CJVjbgU7lJaMGRrhhkmULhPnzRVHOLgfWAoGWdvTIXLsVJHOO9GuPv/itnqagKDpx+tRE/v2H9q3GCXlcqQ7xokhkSPAZymIy0S8fqZ/BYidAJdO24KLJgMRtn3HO+vG3HdCeDr6vB1A9gl0F++PmlVtjNKuZ/b9sbrCBbWmItyUWY3z5mWoaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evXSajEJXP7ABq79MuMW7WuKOhZIjkVtGIno1HUR3Cs=;
 b=J5l7x6hLa/eiSd2reyI5WgKxk6bBmZi4PYbgCQmu7FDrw/FFL5brqMnYO8th4lfzktyUv7GpmHRiwQ8/47+nwaV6RuYvYL5+8yzS8Qy3AOz8Z++6WAWsfqAeNIxwkqi1Yvw0CsshaLq0F+WbdkeqHN+IzaumrUBXSBNNU0fR6NwlLJ9JVDvPU5SNvngO0ly5tXafTO+aRT9eqkn7KQ9E8Btea9wc9dx0ieLvorif0sfgCQgtsjTEJtLikQxftS9jbfm/r6L05KYgjyjW4eQdvEOcIX8EiHfrnNw4OvTZfjJpul9b8ohPstCxvl69PHQ26cmyUrx9YCZvAHH0INqLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evXSajEJXP7ABq79MuMW7WuKOhZIjkVtGIno1HUR3Cs=;
 b=2OPO4yjI2kO9+lj3JGS1h9CtwmviUtoXyEwYFnR5p8SHxuKz8oW0MCfyN4VXRvgdHsclBevDU6jyISippfRuh8aED1N758OAqCw2Ykq8+tKFee+KwUDHvL2Zp5Yyz9hGo2NMnVL/MdgABK16NH/Yr+1R5ljG34Tg10bI/YrDEs4=
Received: from CH0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:610:77::35)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:38:29 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::58) by CH0PR04CA0060.outlook.office365.com
 (2603:10b6:610:77::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:38:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:38:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:38:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:38:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: James Zhu <James.Zhu@amd.com>, Jay Cornwall <jay.cornwall@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: enable trap ID work around
Date: Fri, 21 Aug 2026 12:37:57 -0400
Message-ID: <20260821163758.781397-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821163758.781397-1-alexander.deucher@amd.com>
References: <20260821163758.781397-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a46bbb-db81-4891-1ff2-08deffa2a167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3cQ/i37xox8WJNJxLNiZN8EWK8tbAvfI6NYye8yEhk78LL7PX2kUex4/PjrkHdYxiq1mpeyTkEPHaqLHyLuaxEs4s9nI2lM+2M+rF2ywUpbJ/3w26DlHvyCa2ol4xyBXbvFGdOkxNvJL8rNLiw9slseRl7rYbyaTZxhsAhkRY+kZBxxTtdyLHnpiDi7OuqCw1BwtWLcZ4HbhINXJqRPfZtrByW7FZGP0+/UABxAE1VyL886XTpKv+r/pTv3gYKDfzVKUcFbYzZ4wnBDfyJEvdjIjHaWtI1L4CkEMfHx/GA8GqTpSZCoXRdZ6qIimCPEhcB3TK+sZBgSAwXMyRTwnsB3jLNVUN0ZX9uVWi3PoKJuAB8rTQJndSmJWzSlns+toiNeKWLGA8UM4d2u3UplpcFPf6I7eQHlnmw7Mmo69oZ02YMUsBw+74PENZdOOz4XtgSwOjqd5aNK/ZzICzI2NNSGgcbJSAmmpIJHOLkXoefor642E2nCc5XB43zSKdCvLYMj3GVb8Jrq6JyhdTFU2QrkuE9Kl7scUxyrmPj9NZoCDMKkpjbqjA/5h5MnG3SHe8QC+YRmgEZlp1CZCfQ1kd797PWY0JzJFd3w1YT7oUfz0mAEdN15rhyvpJfPCzefkAtqIj84p10Ss+0A2bFhQlznSKCkHpPev8nZckd9bin15Poh7oUTr0QsO2VTfzduK4RrIwlQSJJuyIjmcj55YYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c8gadGTcB8dprI2x3ZtYszSbVpX9RzNoCc3O6beXOe4KcpQ/BkWk6lOtSTsuPw2Ey9uRbBASEAwiE0wVP4Z7s82QfL8ffzCJ7DddhdXmXqZRwBKkUReBWg8oWTuHY7fNwtRKbhbRDjYNutqF2djbOdBUtx3Ah+g/TJZ/rIct+6Xc1AWJWv3d/Mj2Y9UdmA7ugpvdj8mPpd401TVNQ8xDuZLWNR4SZt0PZ9tW1JepAQdD/INGFIJvswfFtAxy+bPqQwvBo28Pmy9PSXRd4qBS06Ulj5KEL8AEdiGe9E9U8g6dgAIiU4Vd4OgKTQ7pJMETOaBU51U4JCnMXQw03mJiW4KeityOt+PXh8OAY4IEx0yjIkSaIO7pNZ7z0+yn5yNAsHrOk/MIWExDCQx9E1UfdRppAF8SnQ+ZCPYEDwJjb13pqquF3pSBofE6clEVQsB9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:38:28.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a46bbb-db81-4891-1ff2-08deffa2a167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

From: James Zhu <James.Zhu@amd.com>

on gfx12.1 trap handler

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Lancelot Six <lancelot.six@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 6 ++++--
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 6750f73394ace..b28b57f145579 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4601,10 +4601,12 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
-	0xbfa00001, 0xbfa003d6,
+	0xbfa00001, 0xbfa003da,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
-	0xb8fbf811, 0xbf0d857b,
+	0xb8fbf811, 0xbf0c877b,
+	0xbfa20002, 0x916dff6d,
+	0xf0000000, 0xbf0d857b,
 	0xbfa10006, 0x917bff7b,
 	0x00000480, 0xb98001d1,
 	0x00000000, 0xb9800291,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 2d7cfeb491987..07de21918444c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -41,7 +41,7 @@
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
-#define HAVE_HT_TRAP_ID_WA (ASIC_FAMILY == CHIP_GFX12)
+#define HAVE_HT_TRAP_ID_WA (ASIC_FAMILY >= CHIP_GFX12)
 #define WAVE32_ONLY (ASIC_FAMILY == CHIP_GC_12_0_3)
 #define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >= CHIP_GC_12_0_3)
 
-- 
2.55.0

