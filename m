Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3757CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 19:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89A910EBA7;
	Mon, 16 May 2022 19:20:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E953810EB6A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 19:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ywu/SNFOcybM4Us1we4tJAeCXCXDmQiDdDq+OIGaiBAyysB+LYTYnI4OWXokUG40WAuA2NgdxhX1H1eL547cnfhPf9Ju+qt/k7zXxwsoO1F3dALZNoSTe3KFfJ2v/1HGqiBpwfwuLaOs3z4n15/asVsFE6pqf33qGk4iMHvWHaHpfqJiYXM0mkwEbqqClOkxSBuJlvjVYpRm+u9ZcNrBXIsqhv5QglXsCLkTopJk1fQeuiiL2i5Zg1Lpg81pq/gpdaiRuevpwlx/GV/xdOJ/ZoD2UzXWe/R10bjJy31cyPNKVvk1bHXe8MwGsFp3SGPRZyiMLrm0xE0vH2wN5Z6jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i85qmBSwnXTmlhtxxgkFY7wGBMS64Rw0mwb4c/RURnQ=;
 b=SR2L4R0nW9WzcllfCdAFToVzCm0X5SCm+VgaUBGxDpNGMzCg8cepT0loqKJH8M6UUTUk3oeUbIjfQcllb30nMSsXQylgbl6fQh0Fr3sPaFizCkhtVV43LmFBLxtN/lW2QVfWYe11VHqgjGA/3iUTMvCeZsd/JkNQsigxC9k35GKOGBo8gvl0JYMHphuHLaq23g0CyXmNmS32Ki0SjBT/xOyl6KAJE3/t9Hefue/D8cvyelMuLtBAZqTdRbQxPM2qvCne15AB2C636M5uH5lZ4uOtEg/WoV+w3S1jhH6PZdTl5rWmPEjocyD+NSTHxlW6Fm/NuZ0xaR3m1R+sWn2ZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i85qmBSwnXTmlhtxxgkFY7wGBMS64Rw0mwb4c/RURnQ=;
 b=CyWtqxnXuta2aDUKuWxs7mPrBtces2YzezA0I2CjPu+1ahU22nsWkI83JEb9L+hGSIuZp8z4vt9JR2CcSN47DjXTwiEZrdq1skrlCkD9oTDvwCJYigtDB2vOHaJDub1HiSwsuodWXkjFNMZ6bUON6IIT2az0xUQhg8DNAZO+nU0=
Received: from DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) by
 BYAPR12MB2872.namprd12.prod.outlook.com (2603:10b6:a03:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 19:20:42 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::de) by DM6PR01CA0002.outlook.office365.com
 (2603:10b6:5:296::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Mon, 16 May 2022 19:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 19:20:41 +0000
Received: from eric-tp68xe.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 14:20:40 -0500
From: Eric Huang <JinhuiEric.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Add gfx11 trap handler
Date: Mon, 16 May 2022 15:20:27 -0400
Message-ID: <20220516192027.87891-2-JinhuiEric.Huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516192027.87891-1-JinhuiEric.Huang@amd.com>
References: <20220516192027.87891-1-JinhuiEric.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecc629cd-9e07-4858-2e99-08da37712b18
X-MS-TrafficTypeDiagnostic: BYAPR12MB2872:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2872A9ABDFABF2E941714CE782CF9@BYAPR12MB2872.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlImhdKmQEOuw8DWoXqatguUsLaqHxSGGQlT+U64F10/SFK367CsBal7dYctw9VKV8WcL04naEakLlRjw8su88O4PpupRdS7PcEpaJjVjKflt9M42rWdlFiMCsTivyM7v8Frm+gxACjKUbbNtRQU7di3RuMCnIkySIGdwWLvNFhBf0ICyMXjDzwv/M+byiFAiVhQvPd+OcASbfYVlS5n0h2Hnb4XvJ7gc7pHixvjBAN0xXqAarqkzpaZw1aYXhaaIL+DnPsJxcLSONV2qLp64VW/zvnFOS0hgXzrHUb+psQNxHJQyjwfaH7inruEKCRq+I6f3/isy0HOilcpnvRipV6Ym6dSXL0EIGVcKRfkW7GOUgj3DP3TDblfUtLtd6EWFfcf7YCOsEgSN5cJIlOcjuQtNGednCeFderXRO+E10FiApk+A5O6hD8/dH5LNcMW0bmtY31ivGebluuu+D577pbSuxNlF+Piv4VZr0Wt8qd2xKSKKqBK8ZZJ5OpsDhkhhMdkMpDd2CIqf39FttLI3aYrAAefHhlSWb5ZMxb1Pv0kUBvMNLv6rK8J0DlCssdmeh9JFoHUVP9G1k074ZuA9Hzw2YDJ7fmqPpLsbfHMyOFXM0lYQBdm3no4/SGXmJK9GzYy/8hb3zSdER7+vLn4XerBy6Kko0G2tIKrDxhaN239PLL7VAtTeSi5XrqRz/EHSTWJGHGm9ghx7e9Ow8ATkumC5x0+76JNWHFZ6XepcBzphgzq0p2C96IDwFLMsq4B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(5660300002)(36756003)(16526019)(36860700001)(4326008)(83380400001)(336012)(8676002)(426003)(2616005)(86362001)(6666004)(2906002)(508600001)(8936002)(47076005)(186003)(30864003)(6916009)(316002)(70206006)(70586007)(81166007)(26005)(82310400005)(356005)(40460700003)(54906003)(1076003)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 19:20:41.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc629cd-9e07-4858-2e99-08da37712b18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2872
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
Cc: Jay Cornwall <jay.cornwall@amd.com>,
 Laurent Morichetti <laurent.morichetti@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jay Cornwall <jay.cornwall@amd.com>

Based on gfx10 with following changes:

- GPR_ALLOC.VGPR_SIZE field moved (and size corrected in gfx10)
- s_sendmsg_rtn_b64 replaces some s_sendmsg/s_getreg
- Buffer instructions no longer have direct-to-LDS modifier

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Laurent Morichetti <laurent.morichetti@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 463 +++++++++++++++++-
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  69 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   6 +-
 3 files changed, 507 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 8cbdc7f519c6..60a81649cf12 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -776,7 +776,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xe0704100, 0x705d0100,
 	0xe0704200, 0x705d0200,
 	0xe0704300, 0x705d0300,
-	0xb9702a05, 0x80708170,
+	0xb9703a05, 0x80708170,
 	0xbf0d9973, 0xbf850002,
 	0x8f708970, 0xbf820001,
 	0x8f708a70, 0xb97a1e06,
@@ -855,7 +855,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x877aff6d, 0x80000000,
 	0xbf840040, 0x8f7b867b,
 	0x8f7b827b, 0xbef6037b,
-	0xb9702a05, 0x80708170,
+	0xb9703a05, 0x80708170,
 	0xbf0d9973, 0xbf850002,
 	0x8f708970, 0xbf820001,
 	0x8f708a70, 0xb97a1e06,
@@ -891,7 +891,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbef003ff, 0x00000200,
 	0xbeff0380, 0xbf820003,
 	0xbef003ff, 0x00000400,
-	0xbeff03c1, 0xb97b2a05,
+	0xbeff03c1, 0xb97b3a05,
 	0x807b817b, 0x8f7b827b,
 	0x907c9973, 0x877c817c,
 	0xbf06817c, 0xbf850017,
@@ -939,7 +939,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xb96f4306, 0x876fc16f,
 	0xbf840029, 0x8f6f866f,
 	0x8f6f826f, 0xbef6036f,
-	0xb9782a05, 0x80788178,
+	0xb9783a05, 0x80788178,
 	0xbf0d9972, 0xbf850002,
 	0x8f788978, 0xbf820001,
 	0x8f788a78, 0xb96e1e06,
@@ -962,7 +962,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x907c9972, 0x877c817c,
 	0xbf06817c, 0xbf850002,
 	0xbeff0380, 0xbf820001,
-	0xbeff03c1, 0xb96f2a05,
+	0xbeff03c1, 0xb96f3a05,
 	0x806f816f, 0x8f6f826f,
 	0x907c9972, 0x877c817c,
 	0xbf06817c, 0xbf850024,
@@ -1010,7 +1010,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x6e5d0100, 0xe0304200,
 	0x6e5d0200, 0xe0304300,
 	0x6e5d0300, 0xbf8c3f70,
-	0xb9782a05, 0x80788178,
+	0xb9783a05, 0x80788178,
 	0xbf0d9972, 0xbf850002,
 	0x8f788978, 0xbf820001,
 	0x8f788a78, 0xb96e1e06,
@@ -1037,7 +1037,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbe8c310c, 0xbe8e310e,
 	0xbf06807c, 0xbf84fff0,
 	0xba80f801, 0x00000000,
-	0xbf8a0000, 0xb9782a05,
+	0xbf8a0000, 0xb9783a05,
 	0x80788178, 0xbf0d9972,
 	0xbf850002, 0x8f788978,
 	0xbf820001, 0x8f788a78,
@@ -2261,7 +2261,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbf8a0000, 0x877aff6d,
 	0x80000000, 0xbf840040,
 	0x8f7b867b, 0x8f7b827b,
-	0xbef6037b, 0xb9702a05,
+	0xbef6037b, 0xb9703a05,
 	0x80708170, 0xbf0d9973,
 	0xbf850002, 0x8f708970,
 	0xbf820001, 0x8f708a70,
@@ -2298,7 +2298,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x00000200, 0xbeff0380,
 	0xbf820003, 0xbef003ff,
 	0x00000400, 0xbeff03c1,
-	0xb97b2a05, 0x807b817b,
+	0xb97b3a05, 0x807b817b,
 	0x8f7b827b, 0x907c9973,
 	0x877c817c, 0xbf06817c,
 	0xbf850017, 0xbef603ff,
@@ -2345,7 +2345,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbeff03c1, 0xb96f4306,
 	0x876fc16f, 0xbf840029,
 	0x8f6f866f, 0x8f6f826f,
-	0xbef6036f, 0xb9782a05,
+	0xbef6036f, 0xb9783a05,
 	0x80788178, 0xbf0d9972,
 	0xbf850002, 0x8f788978,
 	0xbf820001, 0x8f788a78,
@@ -2369,7 +2369,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x877c817c, 0xbf06817c,
 	0xbf850002, 0xbeff0380,
 	0xbf820001, 0xbeff03c1,
-	0xb96f2a05, 0x806f816f,
+	0xb96f3a05, 0x806f816f,
 	0x8f6f826f, 0x907c9972,
 	0x877c817c, 0xbf06817c,
 	0xbf850024, 0xbef603ff,
@@ -2416,7 +2416,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xe0304100, 0x6e5d0100,
 	0xe0304200, 0x6e5d0200,
 	0xe0304300, 0x6e5d0300,
-	0xbf8c3f70, 0xb9782a05,
+	0xbf8c3f70, 0xb9783a05,
 	0x80788178, 0xbf0d9972,
 	0xbf850002, 0x8f788978,
 	0xbf820001, 0x8f788a78,
@@ -2444,7 +2444,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbe8e310e, 0xbf06807c,
 	0xbf84fff0, 0xba80f801,
 	0x00000000, 0xbf8a0000,
-	0xb9782a05, 0x80788178,
+	0xb9783a05, 0x80788178,
 	0xbf0d9972, 0xbf850002,
 	0x8f788978, 0xbf820001,
 	0x8f788a78, 0xb96e1e06,
@@ -2494,3 +2494,440 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
 };
+
+static const uint32_t cwsr_trap_gfx11_hex[] = {
+	0xbfa00001, 0xbfa0021b,
+	0xb0804006, 0xb8f8f802,
+	0x91788678, 0xb8fbf803,
+	0x8b6eff78, 0x00002000,
+	0xbfa10009, 0x8b6eff6d,
+	0x00ff0000, 0xbfa2001e,
+	0x8b6eff7b, 0x00000400,
+	0xbfa20041, 0xbf830010,
+	0xb8fbf803, 0xbfa0fffa,
+	0x8b6eff7b, 0x00000900,
+	0xbfa20015, 0x8b6eff7b,
+	0x000071ff, 0xbfa10008,
+	0x8b6fff7b, 0x00007080,
+	0xbfa10001, 0xbeee1287,
+	0xb8eff801, 0x846e8c6e,
+	0x8b6e6f6e, 0xbfa2000a,
+	0x8b6eff6d, 0x00ff0000,
+	0xbfa20007, 0xb8eef801,
+	0x8b6eff6e, 0x00000800,
+	0xbfa20003, 0x8b6eff7b,
+	0x00000400, 0xbfa20026,
+	0xbefa4d82, 0xbf89fc07,
+	0x84fa887a, 0xf4005bbd,
+	0xf8000010, 0xbf89fc07,
+	0x846e976e, 0x9177ff77,
+	0x00800000, 0x8c776e77,
+	0xf4045bbd, 0xf8000000,
+	0xbf89fc07, 0xf4045ebd,
+	0xf8000008, 0xbf89fc07,
+	0x8bee6e6e, 0xbfa10001,
+	0xbe80486e, 0x8b6eff6d,
+	0x01ff0000, 0xbfa20005,
+	0x8c78ff78, 0x00002000,
+	0x80ec886c, 0x82ed806d,
+	0xbfa00005, 0x8b6eff6d,
+	0x01000000, 0xbfa20002,
+	0x806c846c, 0x826d806d,
+	0x8b6dff6d, 0x0000ffff,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0xb978f802, 0xbe804a6c,
+	0x8b6dff6d, 0x0000ffff,
+	0xbefa0080, 0xb97a0283,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbefe4d84,
+	0xbf89fc07, 0x8b7aff7f,
+	0x04000000, 0x847a857a,
+	0x8c6d7a6d, 0xbefa007e,
+	0x8b7bff7f, 0x0000ffff,
+	0xbefe00c1, 0xbeff00c1,
+	0xdca6c000, 0x007a0000,
+	0x7e000280, 0xbefe007a,
+	0xbeff007b, 0xb8fb02dc,
+	0x847b997b, 0xb8fa3b05,
+	0x807a817a, 0xbf0d997b,
+	0xbfa20002, 0x847a897a,
+	0xbfa00001, 0x847a8a7a,
+	0xb8fb1e06, 0x847b8a7b,
+	0x807a7b7a, 0x8b7bff7f,
+	0x0000ffff, 0x807aff7a,
+	0x00000200, 0x807a7e7a,
+	0x827b807b, 0xd7610000,
+	0x00010870, 0xd7610000,
+	0x00010a71, 0xd7610000,
+	0x00010c72, 0xd7610000,
+	0x00010e73, 0xd7610000,
+	0x00011074, 0xd7610000,
+	0x00011275, 0xd7610000,
+	0x00011476, 0xd7610000,
+	0x00011677, 0xd7610000,
+	0x00011a79, 0xd7610000,
+	0x00011c7e, 0xd7610000,
+	0x00011e7f, 0xbefe00ff,
+	0x00003fff, 0xbeff0080,
+	0xdca6c040, 0x007a0000,
+	0xd760007a, 0x00011d00,
+	0xd760007b, 0x00011f00,
+	0xbefe007a, 0xbeff007b,
+	0xbef4007e, 0x8b75ff7f,
+	0x0000ffff, 0x8c75ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x10807fac,
+	0xbef1007d, 0xbef00080,
+	0xb8f302dc, 0x84739973,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00002, 0xbeff00c1,
+	0xbfa00009, 0xbef600ff,
+	0x01000000, 0xe0685080,
+	0x701d0100, 0xe0685100,
+	0x701d0200, 0xe0685180,
+	0x701d0300, 0xbfa00008,
+	0xbef600ff, 0x01000000,
+	0xe0685100, 0x701d0100,
+	0xe0685200, 0x701d0200,
+	0xe0685300, 0x701d0300,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xb8fa1e06,
+	0x847a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
+	0xbef600ff, 0x01000000,
+	0x7e000280, 0x7e020280,
+	0x7e040280, 0xbefd0080,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xd7610002,
+	0x0000fa6c, 0x807d817d,
+	0x917aff6d, 0x80000000,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa6e, 0x807d817d,
+	0xd7610002, 0x0000fa6f,
+	0x807d817d, 0xd7610002,
+	0x0000fa78, 0x807d817d,
+	0xb8faf803, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xd7610002, 0x0000fa7b,
+	0x807d817d, 0xb8f1f801,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f814,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f815,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xbefe00ff,
+	0x0000ffff, 0xbeff0080,
+	0xe0685000, 0x701d0200,
+	0xbefe00c1, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0xbef600ff,
+	0x01000000, 0xbef90080,
+	0xbefd0080, 0xbf800000,
+	0xbe804100, 0xbe824102,
+	0xbe844104, 0xbe864106,
+	0xbe884108, 0xbe8a410a,
+	0xbe8c410c, 0xbe8e410e,
+	0xd7610002, 0x0000f200,
+	0x80798179, 0xd7610002,
+	0x0000f201, 0x80798179,
+	0xd7610002, 0x0000f202,
+	0x80798179, 0xd7610002,
+	0x0000f203, 0x80798179,
+	0xd7610002, 0x0000f204,
+	0x80798179, 0xd7610002,
+	0x0000f205, 0x80798179,
+	0xd7610002, 0x0000f206,
+	0x80798179, 0xd7610002,
+	0x0000f207, 0x80798179,
+	0xd7610002, 0x0000f208,
+	0x80798179, 0xd7610002,
+	0x0000f209, 0x80798179,
+	0xd7610002, 0x0000f20a,
+	0x80798179, 0xd7610002,
+	0x0000f20b, 0x80798179,
+	0xd7610002, 0x0000f20c,
+	0x80798179, 0xd7610002,
+	0x0000f20d, 0x80798179,
+	0xd7610002, 0x0000f20e,
+	0x80798179, 0xd7610002,
+	0x0000f20f, 0x80798179,
+	0xbf06a079, 0xbfa10006,
+	0xe0685000, 0x701d0200,
+	0x8070ff70, 0x00000080,
+	0xbef90080, 0x7e040280,
+	0x807d907d, 0xbf0aff7d,
+	0x00000060, 0xbfa2ffbc,
+	0xbe804100, 0xbe824102,
+	0xbe844104, 0xbe864106,
+	0xbe884108, 0xbe8a410a,
+	0xd7610002, 0x0000f200,
+	0x80798179, 0xd7610002,
+	0x0000f201, 0x80798179,
+	0xd7610002, 0x0000f202,
+	0x80798179, 0xd7610002,
+	0x0000f203, 0x80798179,
+	0xd7610002, 0x0000f204,
+	0x80798179, 0xd7610002,
+	0x0000f205, 0x80798179,
+	0xd7610002, 0x0000f206,
+	0x80798179, 0xd7610002,
+	0x0000f207, 0x80798179,
+	0xd7610002, 0x0000f208,
+	0x80798179, 0xd7610002,
+	0x0000f209, 0x80798179,
+	0xd7610002, 0x0000f20a,
+	0x80798179, 0xd7610002,
+	0x0000f20b, 0x80798179,
+	0xe0685000, 0x701d0200,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8fb4306, 0x8b7bc17b,
+	0xbfa10044, 0xbfbd0000,
+	0x8b7aff6d, 0x80000000,
+	0xbfa10040, 0x847b867b,
+	0x847b827b, 0xbef6007b,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xb8fa1e06,
+	0x847a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
+	0x8070ff70, 0x00000080,
+	0xbef600ff, 0x01000000,
+	0xd71f0000, 0x000100c1,
+	0xd7200000, 0x000200c1,
+	0x16000084, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa20012,
+	0xbe8300ff, 0x00000080,
+	0xbf800000, 0xbf800000,
+	0xbf800000, 0xd8d80000,
+	0x01000000, 0xbf890000,
+	0xe0685000, 0x701d0100,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff4, 0xbfa00011,
+	0xbe8300ff, 0x00000100,
+	0xbf800000, 0xbf800000,
+	0xbf800000, 0xd8d80000,
+	0x01000000, 0xbf890000,
+	0xe0685000, 0x701d0100,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000100, 0xbf0a7b7d,
+	0xbfa2fff4, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20004,
+	0xbef000ff, 0x00000200,
+	0xbeff0080, 0xbfa00003,
+	0xbef000ff, 0x00000400,
+	0xbeff00c1, 0xb8fb3b05,
+	0x807b817b, 0x847b827b,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20017,
+	0xbef600ff, 0x01000000,
+	0xbefd0084, 0xbf0a7b7d,
+	0xbfa10037, 0x7e008700,
+	0x7e028701, 0x7e048702,
+	0x7e068703, 0xe0685000,
+	0x701d0000, 0xe0685080,
+	0x701d0100, 0xe0685100,
+	0x701d0200, 0xe0685180,
+	0x701d0300, 0x807d847d,
+	0x8070ff70, 0x00000200,
+	0xbf0a7b7d, 0xbfa2ffef,
+	0xbfa00025, 0xbef600ff,
+	0x01000000, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10011,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0xe0685000, 0x701d0000,
+	0xe0685100, 0x701d0100,
+	0xe0685200, 0x701d0200,
+	0xe0685300, 0x701d0300,
+	0x807d847d, 0x8070ff70,
+	0x00000400, 0xbf0a7b7d,
+	0xbfa2ffef, 0xb8fb1e06,
+	0x8b7bc17b, 0xbfa1000c,
+	0x847b837b, 0x807b7d7b,
+	0xbefe00c1, 0xbeff0080,
+	0x7e008700, 0xe0685000,
+	0x701d0000, 0x807d817d,
+	0x8070ff70, 0x00000080,
+	0xbf0a7b7d, 0xbfa2fff8,
+	0xbfa00141, 0xbef4007e,
+	0x8b75ff7f, 0x0000ffff,
+	0x8c75ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x10807fac, 0xb8f202dc,
+	0x84729972, 0x8b6eff7f,
+	0x04000000, 0xbfa1003a,
+	0xbefe00c1, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8ef4306, 0x8b6fc16f,
+	0xbfa1002f, 0x846f866f,
+	0x846f826f, 0xbef6006f,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0xb8ee1e06,
+	0x846e8a6e, 0x80786e78,
+	0x8078ff78, 0x00000200,
+	0x8078ff78, 0x00000080,
+	0xbef600ff, 0x01000000,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xbfa2000c, 0xe0500000,
+	0x781d0000, 0xbf8903f7,
+	0xdac00000, 0x00000000,
+	0x807dff7d, 0x00000080,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7d, 0xbfa2fff5,
+	0xbfa0000b, 0xe0500000,
+	0x781d0000, 0xbf8903f7,
+	0xdac00000, 0x00000000,
+	0x807dff7d, 0x00000100,
+	0x8078ff78, 0x00000100,
+	0xbf0a6f7d, 0xbfa2fff5,
+	0xbef80080, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef3b05,
+	0x806f816f, 0x846f826f,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20024,
+	0xbef600ff, 0x01000000,
+	0xbeee0078, 0x8078ff78,
+	0x00000200, 0xbefd0084,
+	0xbf0a6f7d, 0xbfa10050,
+	0xe0505000, 0x781d0000,
+	0xe0505080, 0x781d0100,
+	0xe0505100, 0x781d0200,
+	0xe0505180, 0x781d0300,
+	0xbf8903f7, 0x7e008500,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807d847d,
+	0x8078ff78, 0x00000200,
+	0xbf0a6f7d, 0xbfa2ffee,
+	0xe0505000, 0x6e1d0000,
+	0xe0505080, 0x6e1d0100,
+	0xe0505100, 0x6e1d0200,
+	0xe0505180, 0x6e1d0300,
+	0xbf8903f7, 0xbfa00034,
+	0xbef600ff, 0x01000000,
+	0xbeee0078, 0x8078ff78,
+	0x00000400, 0xbefd0084,
+	0xbf0a6f7d, 0xbfa10012,
+	0xe0505000, 0x781d0000,
+	0xe0505100, 0x781d0100,
+	0xe0505200, 0x781d0200,
+	0xe0505300, 0x781d0300,
+	0xbf8903f7, 0x7e008500,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807d847d,
+	0x8078ff78, 0x00000400,
+	0xbf0a6f7d, 0xbfa2ffee,
+	0xb8ef1e06, 0x8b6fc16f,
+	0xbfa1000e, 0x846f836f,
+	0x806f7d6f, 0xbefe00c1,
+	0xbeff0080, 0xe0505000,
+	0x781d0000, 0xbf8903f7,
+	0x7e008500, 0x807d817d,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7d, 0xbfa2fff7,
+	0xbeff00c1, 0xe0505000,
+	0x6e1d0000, 0xe0505100,
+	0x6e1d0100, 0xe0505200,
+	0x6e1d0200, 0xe0505300,
+	0x6e1d0300, 0xbf8903f7,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0xb8ee1e06,
+	0x846e8a6e, 0x80786e78,
+	0x8078ff78, 0x00000200,
+	0x80f8ff78, 0x00000050,
+	0xbef600ff, 0x01000000,
+	0xbefd00ff, 0x0000006c,
+	0x80f89078, 0xf428403a,
+	0xf0000000, 0xbf89fc07,
+	0x80fd847d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0x80f8a078, 0xf42c403a,
+	0xf0000000, 0xbf89fc07,
+	0x80fd887d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0x80f8c078, 0xf430403a,
+	0xf0000000, 0xbf89fc07,
+	0x80fd907d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0xbe884308, 0xbe8a430a,
+	0xbe8c430c, 0xbe8e430e,
+	0xbf06807d, 0xbfa1fff0,
+	0xb980f801, 0x00000000,
+	0xbfbd0000, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0xbef600ff,
+	0x01000000, 0xf4205bfa,
+	0xf0000000, 0x80788478,
+	0xf4205b3a, 0xf0000000,
+	0x80788478, 0xf4205b7a,
+	0xf0000000, 0x80788478,
+	0xf4205c3a, 0xf0000000,
+	0x80788478, 0xf4205c7a,
+	0xf0000000, 0x80788478,
+	0xf4205eba, 0xf0000000,
+	0x80788478, 0xf4205efa,
+	0xf0000000, 0x80788478,
+	0xf4205e7a, 0xf0000000,
+	0x80788478, 0xf4205cfa,
+	0xf0000000, 0x80788478,
+	0xf4205bba, 0xf0000000,
+	0x80788478, 0xbf89fc07,
+	0xb96ef814, 0xf4205bba,
+	0xf0000000, 0x80788478,
+	0xbf89fc07, 0xb96ef815,
+	0xbefd006f, 0xbefe0070,
+	0xbeff0071, 0x8b6f7bff,
+	0x000003ff, 0xb96f4803,
+	0x8b6f7bff, 0xfffff800,
+	0x856f8b6f, 0xb96fa2c3,
+	0xb973f801, 0xb8ee3b05,
+	0x806e816e, 0xbf0d9972,
+	0xbfa20002, 0x846e896e,
+	0xbfa00001, 0x846e8a6e,
+	0xb8ef1e06, 0x846f8a6f,
+	0x806e6f6e, 0x806eff6e,
+	0x00000200, 0x806e746e,
+	0x826f8075, 0x8b6fff6f,
+	0x0000ffff, 0xf4085c37,
+	0xf8000050, 0xf4085d37,
+	0xf8000060, 0xf4005e77,
+	0xf8000074, 0xbf89fc07,
+	0x8b6dff6d, 0x0000ffff,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0xb97af802, 0xbe804a6c,
+	0xbfb00000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 0348191e8592..250ab007399b 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -23,15 +23,26 @@
 /* To compile this assembly code:
  *
  * Navi1x:
- *   cpp -DASIC_TARGET_NAVI1X=1 cwsr_trap_handler_gfx10.asm -P -o nv1x.sp3
- *   sp3-nv1x nv1x.sp3 -hex nv1x.hex
+ *   cpp -DASIC_FAMILY=CHIP_NAVI10 cwsr_trap_handler_gfx10.asm -P -o nv1x.sp3
+ *   sp3 nv1x.sp3 -hex nv1x.hex
  *
- * Others:
- *   cpp -DASIC_TARGET_NAVI1X=0 cwsr_trap_handler_gfx10.asm -P -o gfx10.sp3
- *   sp3-gfx10 gfx10.sp3 -hex gfx10.hex
+ * gfx10:
+ *   cpp -DASIC_FAMILY=CHIP_SIENNA_CICHLID cwsr_trap_handler_gfx10.asm -P -o gfx10.sp3
+ *   sp3 gfx10.sp3 -hex gfx10.hex
+ *
+ * gfx11:
+ *   cpp -DASIC_FAMILY=CHIP_PLUM_BONITO cwsr_trap_handler_gfx10.asm -P -o gfx11.sp3
+ *   sp3 gfx11.sp3 -hex gfx11.hex
  */
 
-#define NO_SQC_STORE !ASIC_TARGET_NAVI1X
+#define CHIP_NAVI10 26
+#define CHIP_SIENNA_CICHLID 30
+#define CHIP_PLUM_BONITO 36
+
+#define NO_SQC_STORE (ASIC_FAMILY >= CHIP_SIENNA_CICHLID)
+#define HAVE_XNACK (ASIC_FAMILY < CHIP_SIENNA_CICHLID)
+#define HAVE_SENDMSG_RTN (ASIC_FAMILY >= CHIP_PLUM_BONITO)
+#define HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
 
 var SINGLE_STEP_MISSED_WORKAROUND		= 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
@@ -41,15 +52,18 @@ var SQ_WAVE_STATUS_ECC_ERR_MASK			= 0x20000
 
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
-var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 8
-var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 6
-var SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SHIFT		= 24
-var SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SIZE		= 4
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
 var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT	= 24
 var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE	= 4
 var SQ_WAVE_IB_STS2_WAVE64_SHIFT		= 11
 var SQ_WAVE_IB_STS2_WAVE64_SIZE			= 1
 
+#if ASIC_FAMILY < CHIP_PLUM_BONITO
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 8
+#else
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
+#endif
+
 var SQ_WAVE_TRAPSTS_SAVECTX_MASK		= 0x400
 var SQ_WAVE_TRAPSTS_EXCP_MASK			= 0x1FF
 var SQ_WAVE_TRAPSTS_SAVECTX_SHIFT		= 10
@@ -231,15 +245,20 @@ end
 	s_cbranch_scc1	L_SAVE
 
 L_FETCH_2ND_TRAP:
-#if ASIC_TARGET_NAVI1X
+#if HAVE_XNACK
 	save_and_clear_ib_sts(ttmp14, ttmp15)
 #endif
 
 	// Read second-level TBA/TMA from first-level TMA and jump if available.
 	// ttmp[2:5] and ttmp12 can be used (others hold SPI-initialized debug data)
 	// ttmp12 holds SQ_WAVE_STATUS
+#if HAVE_SENDMSG_RTN
+	s_sendmsg_rtn_b64       [ttmp14, ttmp15], sendmsg(MSG_RTN_GET_TMA)
+	s_waitcnt       lgkmcnt(0)
+#else
 	s_getreg_b32	ttmp14, hwreg(HW_REG_SHADER_TMA_LO)
 	s_getreg_b32	ttmp15, hwreg(HW_REG_SHADER_TMA_HI)
+#endif
 	s_lshl_b64	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
 
 	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 glc:1			// debug trap enabled flag
@@ -282,7 +301,7 @@ L_TRAP_CASE:
 L_EXIT_TRAP:
 	s_and_b32	ttmp1, ttmp1, 0xFFFF
 
-#if ASIC_TARGET_NAVI1X
+#if HAVE_XNACK
 	restore_ib_sts(ttmp14, ttmp15)
 #endif
 
@@ -298,7 +317,7 @@ L_SAVE:
 	s_mov_b32	s_save_tmp, 0
 	s_setreg_b32	hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_SAVECTX_SHIFT, 1), s_save_tmp	//clear saveCtx bit
 
-#if ASIC_TARGET_NAVI1X
+#if HAVE_XNACK
 	save_and_clear_ib_sts(s_save_tmp, s_save_trapsts)
 #endif
 
@@ -307,9 +326,13 @@ L_SAVE:
 	s_mov_b32	s_save_exec_hi, exec_hi
 	s_mov_b64	exec, 0x0						//clear EXEC to get ready to receive
 
+#if HAVE_SENDMSG_RTN
+	s_sendmsg_rtn_b64       [exec_lo, exec_hi], sendmsg(MSG_RTN_SAVE_WAVE)
+#else
 	s_sendmsg	sendmsg(MSG_SAVEWAVE)					//send SPI a message and wait for SPI's write to EXEC
+#endif
 
-#if ASIC_TARGET_NAVI1X
+#if ASIC_FAMILY < CHIP_SIENNA_CICHLID
 L_SLEEP:
 	// sleep 1 (64clk) is not enough for 8 waves per SIMD, which will cause
 	// SQ hang, since the 7,8th wave could not get arbit to exec inst, while
@@ -389,7 +412,7 @@ L_SLEEP:
 	s_mov_b32	s_save_mem_offset, 0x0
 	get_wave_size(s_wave_size)
 
-#if ASIC_TARGET_NAVI1X
+#if HAVE_XNACK
 	// Save and clear vector XNACK state late to free up SGPRs.
 	s_getreg_b32	s_save_xnack_mask, hwreg(HW_REG_SHADER_XNACK_MASK)
 	s_setreg_imm32_b32	hwreg(HW_REG_SHADER_XNACK_MASK), 0x0
@@ -777,7 +800,13 @@ L_RESTORE_LDS_NORMAL:
 	s_cbranch_scc1	L_RESTORE_LDS_LOOP_W64
 
 L_RESTORE_LDS_LOOP_W32:
+#if HAVE_BUFFER_LDS_LOAD
 	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1	// first 64DW
+#else
+	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
+	s_waitcnt	vmcnt(0)
+	ds_store_addtid_b32     v0
+#endif
 	s_add_u32	m0, m0, 128						// 128 DW
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128		//mem offset increased by 128DW
 	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc=(m0 < s_restore_alloc_size) ? 1 : 0
@@ -785,7 +814,13 @@ L_RESTORE_LDS_LOOP_W32:
 	s_branch	L_RESTORE_VGPR
 
 L_RESTORE_LDS_LOOP_W64:
+#if HAVE_BUFFER_LDS_LOAD
 	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1	// first 64DW
+#else
+	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
+	s_waitcnt	vmcnt(0)
+	ds_store_addtid_b32     v0
+#endif
 	s_add_u32	m0, m0, 256						// 256 DW
 	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 256		//mem offset increased by 256DW
 	s_cmp_lt_u32	m0, s_restore_alloc_size				//scc=(m0 < s_restore_alloc_size) ? 1 : 0
@@ -996,7 +1031,7 @@ L_RESTORE_HWREG:
 	s_and_b32	s_restore_m0, SQ_WAVE_TRAPSTS_PRE_SAVECTX_MASK, s_restore_trapsts
 	s_setreg_b32	hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_PRE_SAVECTX_SHIFT, SQ_WAVE_TRAPSTS_PRE_SAVECTX_SIZE), s_restore_m0
 
-#if ASIC_TARGET_NAVI1X
+#if HAVE_XNACK
 	s_setreg_b32	hwreg(HW_REG_SHADER_XNACK_MASK), s_restore_xnack_mask
 #endif
 
@@ -1019,7 +1054,7 @@ L_RESTORE_HWREG:
 	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 glc:1
 	s_waitcnt	lgkmcnt(0)
 
-#if ASIC_TARGET_NAVI1X
+#if HAVE_XNACK
 	restore_ib_sts(s_restore_tmp, s_restore_m0)
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f1a225a20719..8667e3df2d0b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -441,10 +441,14 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
-		} else {
+		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(11, 0, 0)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx10_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx10_hex);
+		} else {
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
+			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
 		}
 
 		kfd->cwsr_enabled = true;
-- 
2.25.1

