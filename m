Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF936CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFC810E4BF;
	Tue, 26 May 2026 07:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PseLQKok";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D59510E4BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qsc9ePROgl3K4dGRJ8Om9X6ET8WGHJGhVvNBNlp+xK8C/QAvd00ZI5nvpoTXOqjbjUjbB8V3s0f/cCXrYdJkZfpXXcpBlnAfcLxncQVFAb4NurV8CMh4Nbsr5x61+iT1/ToKUq32dVimaAUzvKejhsoGzZ36WMKJ45YPbLynU4xI/wEjKAJpgwpJnv4esI2bKMTGwg6w05taApOFKuOmUdR04VLGYeQjOOsn0SHgMX4XX33A4hWsaKZbwrN9HzFMSoTw1+Q7WRQpkXTdAxyVa9xF542f5U2RuAOzC//bnHzHNCTkIA3U98i95T3woF0Iz2lMizaKnKsPGCQgb1iNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfaN0513qvW2lDsb7WQQdOFEBJqZs88EWN5PI3ORv8A=;
 b=ertJNvQbT5ZO7cFVmtc1cRmkKP8xlXoLJjqe+n7NU+gmqrYxIF0puYFQLhKETD9tek4pBTC+UvnGnIqTL3WWn7hRxecZxxOhuI5Wf3Scr9UhtkQwP0rlSH4Sx3l3dkp8YBVSfMfQta84R2f4d2SDwprNaooZdbLeLg+VU5Nrpzoc+jhaSQyvwxq4MBQOoYGSzyU23qwUCtjBxDEP9Ku5vKRsHlIi3fPGf7nFdvl7H1lg2xxrg3jT0iqs9EFL60eYXx4J2/UKYmbIKHNCLHMOf/rucdXYJ+huIBuK60kuYwEF/eNceBwrXo0rQl3KO4XZeAg0921x/MjqY3jBh89mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfaN0513qvW2lDsb7WQQdOFEBJqZs88EWN5PI3ORv8A=;
 b=PseLQKok0+VpNKYyL1YlFUu/LWzDUUQPkWgh9MXerzbnxWlDeugXyhkqzrVikW5uH4u8WK7taKLlAh7R5p94B262SixNcP2F7DaJ2n31/+yP8HTiAidiSYe+JYM3DmmI1XgBv6qjnxOcz6Y9C4B2kzg5vEYCVUX5M3uX952AFVo=
Received: from PH8P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::32)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:15:10 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d9:cafe::c8) by PH8P220CA0058.outlook.office365.com
 (2603:10b6:510:2d9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:15:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:15:01 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:14:52 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/41] drm/amd/display: Enable gcov coverage for amdgpu_dm
 KUnit builds
Date: Tue, 26 May 2026 15:01:28 +0800
Message-ID: <20260526071413.2181251-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: fee37fed-b155-4e2e-5742-08debaf68579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: uL+Yxb+erKTWRqZItmGUt3mEziOhp1xUKr1hc98ilkF0tkrre51Lc0DsUgzdFCarThPfV4XfnuvBMYkvMjvDTC3ptnBklUU9mX36rCT/hy5n9T7dtRKSbxd4/vGDCbzM8pEPeJm9kpLN1VfhwlN7bVHtJOtwDJSOigRfEUBG2u+vS8R7qNXG0HJPmDO8eQVqe+7d70IWf7/KDjpVXzO3UBcqF29L56slI4bZV2sTnMVnFyqIlohlJ69KqdRGFfVfj9YXjw126FnfXQeKpXu1v68qE889WYrNzq0Fy+TsG0AWiiP8snbC2bS4mmHOYDJZxqejGyf5lQx8prRxR5w4nC9BbsPPy+d/sMKOp/Tp0vsF310GbYDtNmai9a43/nUNVB7PZ2Lw/GiM6RgfY7QaOaWzWtk2tFZgiKNj5tjwtfVIW/vK26FvHF4y1b2+iKjLdo75ILG3y64YgbvHbFPPLQrg4gj9VGHhjpqfgh1z1dr5N04Efb9j8ds0JvA2EGogcuW52v5lQoF+A9Maz7mRDWpDjngVEbTCfX7xBJcYv2U49mnxVg7bWxDORYY7QKOpuvs+Tj2W6s5QIcq8Wr1nNIRKf41Hv/hnJnRMsZoXC+YpAPfeY2neevbpmbn/bmG2/Wva4YhNoZEW08Slau4kLhyxzHCAhc4eKS2nNp8wKKV/McVXHRx0Urfm6spQsDnBVMc2IACYXfdUGgVL8LwPTJqU/8MKxYNdoFK11lxWSIo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lheaDoCrkSldwxnMGWr3Phhw1mqXx2g7s5d0THRxCkixLQbh7Ryqjag/QJusj+nhu3Ze4X94buanH/eckM8IVI79drBY3rD5qSkw5pCyK9ZX+zzi0CnkkSPmFsKoDWRGIqmLhMIw98oimqh5h1EcZZJfCIMd85yTw1PoLbaXz5ZtXDDryS1x3S6A97+4riymFghZvH6diNf8zPxyMeMS4P0WcQQlU4giJH4J6V9qO3Ry82z/qZYJmPC26Y/UBToJJw8nCDutloV5Ov8P8ys+h7nfv/l2H/UsHkjrI3/JGkQ+pypHpDL5DOYn8UKByYqmu/yCoCK8r1t1V4b21PvwTNrSv7Ny0vfbQWt8elWOnMx6fo8Z3/kxmJFyavwdDdZMTNiOTkqFlpETUsMcpgQUIWFG6SMl1Sw2NNc8TH1oX51XTwE5vc/5JduDk6oNfFHN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:15:09.6332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee37fed-b155-4e2e-5742-08debaf68579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741
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

[Why & How]
Add GCOV_PROFILE := y to amdgpu_dm/Makefile under the
CONFIG_DRM_AMD_DC_KUNIT_TEST guard so coverage instrumentation
is only applied during KUnit builds, not all amdgpu_dm builds.

Add coverage config options (CONFIG_GCOV, CONFIG_DEBUG_INFO,
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, CONFIG_DEBUG_KERNEL)
to tests/.kunitconfig so the kunit.py runner enables the kernel
coverage configuration automatically.

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile           | 3 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 914f89af047c..54a93e4255b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -63,4 +63,7 @@ endif
 # KUnit tests as separate module
 ifneq ($(CONFIG_DRM_AMD_DC_KUNIT_TEST),)
 obj-y += $(AMDDALPATH)/amdgpu_dm/tests/
+
+# Enable gcov for amdgpu_dm KUnit builds
+GCOV_PROFILE := y
 endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
index 36676326ade4..a0949d3c4e6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
@@ -12,3 +12,9 @@ CONFIG_HWMON=y
 CONFIG_I2C=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_CRC16=y
+
+# GCOV Coverage - see tools/testing/kunit/configs/coverage_uml.config
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_GCOV=y
-- 
2.43.0

