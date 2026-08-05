Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A90C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506BA10ED14;
	Wed,  5 Aug 2026 06:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fd2DKOsC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C32810ED14
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulToIb2miDg5RgbOFgLQv6ZAw0Get+kvfceDL3I22oIal6Gif3QNpytjqGAJ+EHTS/uaadtqiZcnGf2vQXCtEwXLHjOyIfkGjmsgaixRUPkJW8JrbvbREdj9cNgSIB8c+tysTIIFoVwLQ0U6GpF8oLuM9uRjuhOceR0d5WqOQm3LZUZLWosNhodNlTsWAW4Djr+IeNzNc8gSu8joVWxgUwgNysbaETtW1zoGNh5sJcjt7T0KI+kQv1Hck/JH2LFm7HzgSKsDjfrGjxc7uEJGUEDu0ZPRPhfNXvIcWaVzIEDX63DyLn/faAzpRqLhNsLKS0y/jszJuZMw7f0j+WtksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJckbmgC+jbZ/korxS8BMcj6wW2r79H4O8PEmYeEyOE=;
 b=jta3o5NjsLE5fOIMNZ2crVEbFee3kGo890sEJzE2yo3DMfP373uHd4duVKMAXz38o7r1S6eoY3JZTndpF1nMOgDOz2ViHIDc2LAQ4c09tFrSFOswg0flHei4p/ARR63ZUXJqlvpIKXSu0nIlXrzfX+DLFdSprILRaJSsid7jizZZitGFAx0xfc6y7X/cK9t8O/55+FpivDjoNzRb05BZLtfQ/VFaSS9ttdwAGNrywCTK5MkHdRIvcKyvFw0NKzdPIylN5WhGqNLqSfuMmDIYV565QfxiSDGKYMLtAVH9Pz7lEBo0xERCU0rFKIAxERAeZ/mxAIGST/XcJLAR076OEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJckbmgC+jbZ/korxS8BMcj6wW2r79H4O8PEmYeEyOE=;
 b=Fd2DKOsCw3PrqQm5tffXg89o/PxrNAn3zDnRUZlevfEDfQ/cs5GN+HqX2D7mYXRJYlfoDRG1HO64uCx1vVD38mvLra0NaT0MuNFgudtrhvaT5AgqncslfykyXEu6o7nbopevOlUH9qexu1mZqCaj9PtItluyRfQy3aNVFyii4dQ=
Received: from MW4PR04CA0321.namprd04.prod.outlook.com (2603:10b6:303:82::26)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 06:41:49 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::9e) by MW4PR04CA0321.outlook.office365.com
 (2603:10b6:303:82::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:48 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:40 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 28/34] drm/amd/display: Align KUnit tests Makefile license
 header
Date: Wed, 5 Aug 2026 14:36:40 +0800
Message-ID: <20260805063937.2145774-29-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a40414d-a829-4731-873e-08def2bca09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xuxicM7DgbnM9KKem6Rtf/VArvHj0xnX9CcLvdsSB20hfowNRRQjM2j1RTO47RhVsLfHhewapfJvz2zuONEfmjcMNPDMZXH3CJiCKJwc9EIrfoyY/w/LpKJNMUTqjaSwWgty2rwkPIE5k/RSsG1DoTXxoQbsO+Rrv4bbOKN+owMOhrWJNhRCNPGJjiIm6kXiOZb2iPo5e0qE8nplfYClxr2+L7BKiQGgiL5uv/Q9ATTbV4C0V+KW1w8TsEU5hCt3oNFJs7FWSfvznpksymZ2nCmj2aD2qSuw4sWasysHhIEFfVJdm+YmnS/Rjl0g/euWWVWq+VQoxpdOyBTBHdmX8A+g7Qd++v/g1BnquCux0tT1qzmMlwgw0Dqq8QNKBk/RHBl48+8WeoA5qmNPmLjtu+88X77taA3ZV2BR14Gi43vTGJWHIOfhIGOKr3l8zWxAJQScZ3LYJjJr9PEG+VyVoOCsFl7vfHkSKLuHx/lgmUK5V+JK3EEcDNx6+4LWIRkdt/c6HK4A8HebSPXFu0DUBzFgdiP9lk5+HJEIPFjimIGixb8You49Ux2G8F4OO1Eihw87bOXTJ2SZFzGECddPqBI92+Nl7D0OnKDqjarknNHt+3x+nCOmCMceizgvbLFFkVyXWLdTM76EaUFfWBRTEMVzaHImVCnZa3M+fGYeeMzOzOEOPZjvhDnA51Uy0Ju4RQXC05OXmaMvvy2kZt66hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3c9hfrdPptdlROPtw5IzGJbgERbzNSNZBF5W9m/3ftmww77eoN6a5sdUK8C5ewfNArkYoQIpFzeTE/mgo+VZaqWUslbBk/Dl+LJY9puqDtUQlusMsRu9zPVdRC7HdOZOYNbqvZwKtcVEX2/sY2Y5ArLGdEzZZo3BF4dvTp0pLNXOYMLvDlF7Gp5F7RjHbaCokMK+Q6XIugMOSFeEHFqN+udl0VWrE/MnHCbxvejUpF5QYh0hCQCyWkwdA7rbNJYjBL4tPg6ODkH6UBHu4NN9tFZX431NxNi1UGQyCiiUC+B4Oc2YMdPZYEH19lvJ/8VWnXq9IM46lxaxaXafBK5/o10oP68HUIkmwY1qQqR9tpaNDC8ZNI/MgHxgKHJyH6wgcZ+grqT4JF7N23LWyZMnN6Tt/IH+y/K8cI7Np5wXNOpV/BIJE1tcEfms+wHqFHKI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:49.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a40414d-a829-4731-873e-08def2bca09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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

From: Ray Wu <ray.wu@amd.com>

[Why & How]
Use GPL-2.0 OR MIT and Copyright 2026 to match other KUnit test files.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 616881fcb9af..e0549c04c62e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -1,6 +1,8 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0 OR MIT
 #
 # Makefile for amdgpu_dm KUnit tests.
+#
+# Copyright 2026 Advanced Micro Devices, Inc.
 
 ccflags-y += -I$(src)/..
 ccflags-y += -I$(src)/../..
-- 
2.43.0

