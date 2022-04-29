Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685AFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E0F10F05A;
	Fri, 29 Apr 2022 17:36:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B6610F04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioS99QgSew7faF9ijrWUmXSF3qKARWanOOVhkvCkjLfIF+RVlaUDb40rCmSiJPzCkSo/oth+XxjSeawB8aw/mA70sPhDUk/yFnodk3foUDUIM0JShJjIfe8pqMdbPS9qTf6rf83t3IpdIzetG//k01e+lgypBXIXjA6vzM/g1V+yv2+7nFDR7TAxdhFaydcPMEylOSjYnXo0y8ve3ds/WZbfqp3Fs16ZcG+cMmYjXZsXhkvhVm1sU7UDDvY/6+5y4gKRwuJhggLo2+06ZnISBLWRjI6snQnU/jolYx6Mtuduudu+RK5MVkmDDhpH/oneN91UeFfqx0xCK5yaakNdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4cr2+jZEvlsYwo4BbzFRjVeKaCTkM2Hc+RYs8ZdnTA=;
 b=mCWveXnW9jm9tzD5ahZ39xONJ5y+X+YT0Qp7zpaKOXx++DWwIqjam4p7yEz4y/DHL0i5XzW8wHSDCI93GrZ5CdiLiUaEYuAIywzR6YkHH4d5tvFluj0qo7+U+5PovTmPtb7DKqJVkzc6QvQTm/A7a1BcqW6riwdrpj3FBbVeNhzv+zkZB0ygrrBMMPhFLR6nKjNynmzJycm74YY2UaxPabZGQ1a4owJjspblTmUVzmTw440tAWi+De1WDG2MxGYhRdekOzIEP9jdJd7H6tLk2wG0r+LY2tQcDDvUjbBTgIYNszdqw3N/WHFK4pBwMHzrVWBRxICRQyH4PWZ91pkC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4cr2+jZEvlsYwo4BbzFRjVeKaCTkM2Hc+RYs8ZdnTA=;
 b=w5pMfD96u/z9KZun4QmuW8A2rtICgxcd7C2HNyN8kTgY4CfKK1D/0kFrq1HupFnl+2kIyhduJ1odqx+VU9XnSy2YaL8ISrcSp1XnG3iXfqB0EGErBZ4cRWDAHOLXhYI5R5EgDtewX80ZgYV+5pcKtTY6lMpNY09aFjKpf0m6slc=
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by MWHPR12MB1806.namprd12.prod.outlook.com (2603:10b6:300:10d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:36:39 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::7b) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:36:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:36:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: add rlc TOC header file for soc21 (v2)
Date: Fri, 29 Apr 2022 13:36:16 -0400
Message-ID: <20220429173617.433334-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173617.433334-1-alexander.deucher@amd.com>
References: <20220429173617.433334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a904d1d6-c1e7-4963-7a04-08da2a06d110
X-MS-TrafficTypeDiagnostic: MWHPR12MB1806:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18062F652C4A1906505ECB14F7FC9@MWHPR12MB1806.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGa6KvxZ65AFQZIwUDXah19bkxRNOmGClb91EJ1oxUylutSQEAZ+0aDxULL56RpBts6BWu3yvEHcfbEOwY0TI//X707f2X3qjHaqLaYMPCTJUrNWwCKMxjGSnBDNB+kUEMsgTzYRlKvCtK7B9+UaJx/jgASbE7QL5DL2ZeAbW3a+7sq3uz1zo/rp5mqZIHbWIeG0rUMAxXR1lJI2fGIMMzCuZq5CZaYPhdf+JqxDhl02GTVeOAUPN1JXH4umZm3l2uOj8l2y1TZ+5BU+z9WsK5eDPyWNmaAGmj/Y4ezLBqnwYaVMjjuQ+Kph3sGr4Qq3USpdJ5V6YMLNJI1sLyOzssT0cj9HYQ49FF7DPoSNSFThkcebWNNep85TLidcutz6RbiDorpc23t7kidGgFaxiBGpjWzuhlJUpAG1fmzMy5cNHPlY3D8sZA9Ph72k5Rg+VYGz31BVvP6c3JOmBJAq0r0nazO+xCCUmDQ24f9pBXgUyoc7NSj8fdIv51QlR7ADz3qL5XdJvXvkH7hJekUGpip63/V9pbP+9HQWnKskB7yD1FWYT1/A6qUSRcWnzfMgl09p13Uqhfqp1K9dFsMFDlkymrOxJ6Zejz/8+yjyGE9eiqDoBEBAQZ/LA9Ca4r3EsyjnYQUwGDrDG0mcxCCQprVpXN65EmuDIiEi0b0JuLGEwXNLs0LdmdMVKyAmf0zcSzTZc7e6zFL0WRi5h2EiBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(316002)(40460700003)(86362001)(82310400005)(26005)(8676002)(36756003)(36860700001)(70206006)(4326008)(70586007)(508600001)(6916009)(356005)(8936002)(2906002)(83380400001)(7696005)(2616005)(6666004)(1076003)(54906003)(186003)(16526019)(336012)(47076005)(426003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:36:39.1409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a904d1d6-c1e7-4963-7a04-08da2a06d110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1806
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add RLC autoload TOC header file for soc21 ASIC.

v2: squash in updates

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 6232a89f02dd..f6fd9e1a7dac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -69,6 +69,47 @@ typedef enum _FIRMWARE_ID_ {
 	FIRMWARE_ID_MAX                                         = 38,
 } FIRMWARE_ID;
 
+typedef enum _SOC21_FIRMWARE_ID_ {
+    SOC21_FIRMWARE_ID_INVALID                     = 0,
+    SOC21_FIRMWARE_ID_RLC_G_UCODE                 = 1,
+    SOC21_FIRMWARE_ID_RLC_TOC                     = 2,
+    SOC21_FIRMWARE_ID_RLCG_SCRATCH                = 3,
+    SOC21_FIRMWARE_ID_RLC_SRM_ARAM                = 4,
+    SOC21_FIRMWARE_ID_RLC_P_UCODE                 = 5,
+    SOC21_FIRMWARE_ID_RLC_V_UCODE                 = 6,
+    SOC21_FIRMWARE_ID_RLX6_UCODE                  = 7,
+    SOC21_FIRMWARE_ID_RLX6_UCODE_CORE1            = 8,
+    SOC21_FIRMWARE_ID_RLX6_DRAM_BOOT              = 9,
+    SOC21_FIRMWARE_ID_RLX6_DRAM_BOOT_CORE1        = 10,
+    SOC21_FIRMWARE_ID_SDMA_UCODE_TH0              = 11,
+    SOC21_FIRMWARE_ID_SDMA_UCODE_TH1              = 12,
+    SOC21_FIRMWARE_ID_CP_PFP                      = 13,
+    SOC21_FIRMWARE_ID_CP_ME                       = 14,
+    SOC21_FIRMWARE_ID_CP_MEC                      = 15,
+    SOC21_FIRMWARE_ID_RS64_MES_P0                 = 16,
+    SOC21_FIRMWARE_ID_RS64_MES_P1                 = 17,
+    SOC21_FIRMWARE_ID_RS64_PFP                    = 18,
+    SOC21_FIRMWARE_ID_RS64_ME                     = 19,
+    SOC21_FIRMWARE_ID_RS64_MEC                    = 20,
+    SOC21_FIRMWARE_ID_RS64_MES_P0_STACK           = 21,
+    SOC21_FIRMWARE_ID_RS64_MES_P1_STACK           = 22,
+    SOC21_FIRMWARE_ID_RS64_PFP_P0_STACK           = 23,
+    SOC21_FIRMWARE_ID_RS64_PFP_P1_STACK           = 24,
+    SOC21_FIRMWARE_ID_RS64_ME_P0_STACK            = 25,
+    SOC21_FIRMWARE_ID_RS64_ME_P1_STACK            = 26,
+    SOC21_FIRMWARE_ID_RS64_MEC_P0_STACK           = 27,
+    SOC21_FIRMWARE_ID_RS64_MEC_P1_STACK           = 28,
+    SOC21_FIRMWARE_ID_RS64_MEC_P2_STACK           = 29,
+    SOC21_FIRMWARE_ID_RS64_MEC_P3_STACK           = 30,
+    SOC21_FIRMWARE_ID_RLC_SRM_DRAM_SR             = 31,
+    SOC21_FIRMWARE_ID_RLCG_SCRATCH_SR             = 32,
+    SOC21_FIRMWARE_ID_RLCP_SCRATCH_SR             = 33,
+    SOC21_FIRMWARE_ID_RLCV_SCRATCH_SR             = 34,
+    SOC21_FIRMWARE_ID_RLX6_DRAM_SR                = 35,
+    SOC21_FIRMWARE_ID_RLX6_DRAM_SR_CORE1          = 36,
+    SOC21_FIRMWARE_ID_MAX                         = 37
+} SOC21_FIRMWARE_ID;
+
 typedef struct _RLC_TABLE_OF_CONTENT {
 	union {
 		unsigned int	DW0;
-- 
2.35.1

