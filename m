Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F69FCDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA3410F08F;
	Wed, 24 Jun 2026 18:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TkONSKaC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652BD10F087
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxeeG5IvP/IZ4bwQ9wkVB4nWFqFCSezNutPp8ushCDc3pTvkWYV6Dzj/Ex+p9LFE89HwE44daCM4nTNLx43jfjKmmLmky9656xBCq2w9JDjyfUHeY12gI1u1pz6Rf5kbatqjLLB6+TV68xxwpKdEu0fIJSsQtTBmr6sZBSDGmwqsgK+3pJsAI/XeTJXXwvtaRj4saE2FD2zhJ4qs8NeBpNyc67X8+t/Eaj9WtWUx8ckJSTLvfF6eqVXzHMhSnY1M5WQfATQ0rqtGvdMduCd1AilBnCYiRUaFxVIH2jpWTWpZcIHburF4DfnsKfZ+sR6ldzKELkcOfdsvHMc6pPY1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfQfe4XKrHW0gX+Jd+9njMtZz7K+5p72O0Lt3qeYfR4=;
 b=Dyoe0JaZGEaTafbhbQhTnXZdGC8fXXyA9uUZIX2nOjUSIEjDC7xAZsBqUuZcgD9sgvIL4vRUaw7Uq9k5s2IjO3UVZo0vv8oXnu9RKUjCfTbRAWREcJOJvneAJduz6Bb/rW23MIQVJu7Sg26jZYSw/1XyLlwJsOwBHUlkcQOhPYwl1AbOmujAflsS3BMH4TqcPRI+ZEBUD0admkhPeqRqgrw18rrH6EFvGFlFHuMfYxenefoI1hg6R5wnA+m2ntMqrfaWfxQfojMnG2ezOFYwbddt8GEF7edArmTdx8ytNIj6yfrAj6DHTrVqroBrHJlGjcAIORoJ0lvuf9c10AccMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfQfe4XKrHW0gX+Jd+9njMtZz7K+5p72O0Lt3qeYfR4=;
 b=TkONSKaC1or48kG6/vuC4nEy5XxnbZO3MrqRQUywr780TyFyw0lPocH3j28PLMXG/SB7g6INCjXrVExwwUtDkYuqHOmsRwhEbnRqlfYATC4ros2CLzXQPQXimsN9nZ0FD1EOylAuESlF7DdWfVhFoqOOKbAvkEDN3aEAqjxntWM=
Received: from SJ0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:33a::18)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:16 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::36) by SJ0PR03CA0013.outlook.office365.com
 (2603:10b6:a03:33a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 18:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:15 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:12 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chen-Yu Chen <chen-yu.chen@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 07/28] drm/amd/display: Simplify DMUB notify registration
Date: Wed, 24 Jun 2026 14:03:05 -0400
Message-ID: <20260624180829.4775-8-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: b31a4a21-c556-46f5-ac9d-08ded21bb38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: apxK6i7Yh4hPKyb8rWeQylhZ8c8ILI2D0DuVNcoo4/CPJ4UZN+38W7KDtYX4vI2sRqe52KguKZ2cGlkEQbYyRHHJAUwSZ7ddnyzbM/MYoBaDwKtQXel4ZWN/JIzqBvJnkKk2dSY0oocnoekYCaqhtrzBs7hUbQTk1a26KRQk9/2cc75Di4h7l7u+WFjiR6g0rlN+XLFZscrYoShb7C7KY0EFuHyU/Sy1jyoaxR2XQXYHH4sSnQVQ6bcVOpCCOtV6SLhO08QL/hNuac8DvhOQKdmB3GUfL0+XTI49Y9Ca30/kK1UR4Z+83iuzJ46UEYkaqsjD2MPe9NVcMJ0p7yz2tLUga2sxUY2MI3uKDb/qUxni5PPNT6On1oSFTLsf0DOVC536MbyFyCMkxZkw0Sm/0u4GnFefe6tZN7u5Hfn9gyCPGNywMzgVvZpuFDBuCOOSK8DuPXW2uymMzd70Xj0i4o8fa+iVNVteopJZvu21cNN8sfbA/ngHFyQLPkfVXmOLWM7tur/jaJ3cMkBbXSPCW+WIMcNn5yAICTdXa9gurtx9ICoxxzDfhtwPdkya3Z6s5a5YRI/7DE7wzf7hbI+MlJpCvnQm6EtNaBujFe1aWJvcwDkdBNjD1oZBQ4tRVW7k7z088SX3W/FvRVJg0Y7NTlF+u9C4WFruYXW/gTjUSuSY3DxWoXztRo7NEExnurlnrKc1K1bNRLLWW6NgvGJ5GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g1BFAVJY27WuI39j/s0KiK5PokzivxFbv9mlJ6VsMXr3C6JnnN1TT7n4ez2ygLvtgRzYGgWCBFXFcGhEmxNGHLInFCnGNx7DKJJ04FYQmVoNjzMqEFXCnvrDoTZDLxXbShhTUjnO9KDvzTVsOkesOZaobuYoLIBeAYaIt2eDtoAdwjLLM4B/M19Sv2MMJuyH3TIFnT4bbGsC2Ra7zd8qd2xIE7kMq6kcVfsIZZVMKXKmMnb7MbWj+rd2IO5yp4QkuwLPS5Arp56y5EYYb0UfQARkliTvYMcfAVQGYOVhn7Kyej0NJdmUXT4wT5PhMkeuggGrzT8t+w3nmAr1YoD2zbZL/KoV7znUajXNrjXfBIgVOdfB5vY7dl3OASvFgKibqm0neyUEtD9GuoF5lQ5RmskZVHtla7Hxnnr8ixkqaYJQ9cXSaT2gDedT0R996qWH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:15.0063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31a4a21-c556-46f5-ac9d-08ded21bb38b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Use an early guard for invalid DMUB notify callback registration inputs.
This keeps the same accepted and rejected cases while removing the
redundant else block.

Assisted-by: Copilot:GPT-5
Reviewed-by: Chen-Yu Chen <chen-yu.chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 4f5dd2158417..97cb2a09153d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -124,12 +124,12 @@ bool dm_register_dmub_notify_callback(struct amdgpu_device *adev,
 				      dmub_notify_interrupt_callback_t callback,
 				      bool dmub_int_thread_offload)
 {
-	if (callback != NULL && type < ARRAY_SIZE(adev->dm.dmub_thread_offload)) {
-		adev->dm.dmub_callback[type] = callback;
-		adev->dm.dmub_thread_offload[type] = dmub_int_thread_offload;
-	} else
+	if (!callback || type >= ARRAY_SIZE(adev->dm.dmub_thread_offload))
 		return false;
 
+	adev->dm.dmub_callback[type] = callback;
+	adev->dm.dmub_thread_offload[type] = dmub_int_thread_offload;
+
 	return true;
 }
 EXPORT_IF_KUNIT(dm_register_dmub_notify_callback);
-- 
2.53.0

