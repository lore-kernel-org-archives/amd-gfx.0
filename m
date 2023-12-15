Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C917DC46CC5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D5B89F01;
	Fri, 15 Dec 2023 16:00:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCAC10EA6A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujatcylXHCmGOYHFBq/USAc36TNTCdluPM6ejHtjvXk=;
 b=XLbCA3868HxSoGzymQibAwk1SG0RbcARfUKTqWQ3/47Vc05busAYudIlp3x4XMf8FEHksbZjUgjG3Hzaz1Yr8gm4KOpnxUW4B61mERTV8Wq7gzwTIE00c4SBuCc5CM/a14GYBqrpsloN76E0zsqlwpWw5z0AjjsQw5V+A0xcVHc=
Received: from SN1PR12CA0114.namprd12.prod.outlook.com (2603:10b6:802:21::49)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 16:00:45 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::fe) by SN1PR12CA0114.outlook.office365.com
 (2603:10b6:802:21::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:40 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 11/24] drm/amdkfd/gfx9: enable host trap
Date: Fri, 15 Dec 2023 10:59:38 -0500
Message-ID: <20231215155951.811884-12-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1b7105-3408-4708-d20b-08dbfd86fed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhpUtEumryOYc1USORryfhbTuRxXN8gT63KP5ENhLltD7U0pLuJOym33PTHOr+YL/KJNHjjO4SFU5NucKy81ajKGPOVFFp5+ilmjvfXRHdr7sxg/vW5Rg/6IhzJK/pCO9z+F6tDg7JyadkzcwdfH3qvVKhhNogk8w23axujBLo8Xvt3KKF6dZZDNUHQPlrOA+tF8oWXSwx5Qx327jM0vn/v93ReFa/jFE3cstz6NbFza8dBfaMtxLed7oDgYHn04V8cv5rnn/QvrmUnBw+8q1dL1v2NbAmQBihB8WKo/N4yFLTkHChuMluiZkpXPJks6Ntne/r6pMDnBFiNE+QwGfDy/DEZuk0Ub9kfT1WYpWPc/qPYQY97F+5ErvBgY7vhiqJA4t/igbelVx0dJcktaaBbaD/1SCDlYiqwgNizsDKftF8rscOuYWvbQCUiFtLbYTVUO3e28tNnPR0Jf4uL3PZh8dnXwty5KQiGdWUiGtK/pzEBVZK3PDQMMnWmoZRyiKShn3Ft1BvYjShK5nOKh3X/28sxDvYWSEHk+culrsYsrp9ESDsmJ+wUKT83xS3Sk9PzZBwnTwE5uzgcrQW5DOv/daWySXBQjUI4EH6jkbts6HdxlSiBIyaOSUDrsS2lUoc0P4rbUX0hVHvGDY0Zbaz1alOzjzJji45kN+Ha+jSjB/qEmgUQsB36iTANMMUoNyPsKrYypKGJkPpCX7knwqNpxkPT+UghmXlqxZ4LJo61Pp4ceVfQ5fWEyM5sVaRoQUJ4NeteBcxF82SIxH8To0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4326008)(8936002)(8676002)(316002)(6916009)(54906003)(478600001)(41300700001)(5660300002)(2906002)(86362001)(36756003)(2616005)(1076003)(36860700001)(83380400001)(40480700001)(356005)(426003)(82740400003)(16526019)(26005)(81166007)(47076005)(40460700003)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:44.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1b7105-3408-4708-d20b-08dbfd86fed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable host trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 63 +++++++++++--------
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 24 ++++---
 2 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index df75863393fc..747426bd5181 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -274,14 +274,14 @@ static const uint32_t cwsr_trap_gfx8_hex[] = {
 
 
 static const uint32_t cwsr_trap_gfx9_hex[] = {
-	0xbf820001, 0xbf820258,
+	0xbf820001, 0xbf82025e,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
 	0xbf840009, 0x866eff6d,
 	0x00ff0000, 0xbf85001e,
 	0x866eff7b, 0x00000400,
-	0xbf850055, 0xbf8e0010,
+	0xbf85005b, 0xbf8e0010,
 	0xb8fbf803, 0xbf82fffa,
 	0x866eff7b, 0x03c00900,
 	0xbf850015, 0x866eff7b,
@@ -294,7 +294,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0xbf850007, 0xb8eef801,
 	0x866eff6e, 0x00000800,
 	0xbf850003, 0x866eff7b,
-	0x00000400, 0xbf85003a,
+	0x00000400, 0xbf850040,
 	0xb8faf807, 0x867aff7a,
 	0x001f8000, 0x8e7a8b7a,
 	0x8977ff77, 0xfc000000,
@@ -303,13 +303,16 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0xb8fbf813, 0x8efa887a,
 	0xbf0d8f7b, 0xbf840002,
 	0x877bff7b, 0xffff0000,
-	0xc0031bbd, 0x00000010,
-	0xbf8cc07f, 0x8e6e976e,
-	0x8977ff77, 0x00800000,
-	0x87776e77, 0xc0071bbd,
-	0x00000000, 0xbf8cc07f,
+	0xc0031c3d, 0x00000010,
+	0xc0071bbd, 0x00000000,
 	0xc0071ebd, 0x00000008,
-	0xbf8cc07f, 0x86ee6e6e,
+	0xbf8cc07f, 0x8671ff6d,
+	0x01000000, 0xbf840004,
+	0x92f1ff70, 0x00010001,
+	0xbf840016, 0xbf820005,
+	0x86708170, 0x8e709770,
+	0x8977ff77, 0x00800000,
+	0x87777077, 0x86ee6e6e,
 	0xbf840001, 0xbe801d6e,
 	0x866eff6d, 0x01ff0000,
 	0xbf850005, 0x8778ff78,
@@ -1098,14 +1101,14 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 };
 
 static const uint32_t cwsr_trap_arcturus_hex[] = {
-	0xbf820001, 0xbf8202d4,
+	0xbf820001, 0xbf8202da,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
 	0xbf840009, 0x866eff6d,
 	0x00ff0000, 0xbf85001e,
 	0x866eff7b, 0x00000400,
-	0xbf850055, 0xbf8e0010,
+	0xbf85005b, 0xbf8e0010,
 	0xb8fbf803, 0xbf82fffa,
 	0x866eff7b, 0x03c00900,
 	0xbf850015, 0x866eff7b,
@@ -1118,7 +1121,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0xbf850007, 0xb8eef801,
 	0x866eff6e, 0x00000800,
 	0xbf850003, 0x866eff7b,
-	0x00000400, 0xbf85003a,
+	0x00000400, 0xbf850040,
 	0xb8faf807, 0x867aff7a,
 	0x001f8000, 0x8e7a8b7a,
 	0x8977ff77, 0xfc000000,
@@ -1127,13 +1130,16 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0xb8fbf813, 0x8efa887a,
 	0xbf0d8f7b, 0xbf840002,
 	0x877bff7b, 0xffff0000,
-	0xc0031bbd, 0x00000010,
-	0xbf8cc07f, 0x8e6e976e,
-	0x8977ff77, 0x00800000,
-	0x87776e77, 0xc0071bbd,
-	0x00000000, 0xbf8cc07f,
+	0xc0031c3d, 0x00000010,
+	0xc0071bbd, 0x00000000,
 	0xc0071ebd, 0x00000008,
-	0xbf8cc07f, 0x86ee6e6e,
+	0xbf8cc07f, 0x8671ff6d,
+	0x01000000, 0xbf840004,
+	0x92f1ff70, 0x00010001,
+	0xbf840016, 0xbf820005,
+	0x86708170, 0x8e709770,
+	0x8977ff77, 0x00800000,
+	0x87777077, 0x86ee6e6e,
 	0xbf840001, 0xbe801d6e,
 	0x866eff6d, 0x01ff0000,
 	0xbf850005, 0x8778ff78,
@@ -1578,14 +1584,14 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 };
 
 static const uint32_t cwsr_trap_aldebaran_hex[] = {
-	0xbf820001, 0xbf8202df,
+	0xbf820001, 0xbf8202e5,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
 	0xbf840009, 0x866eff6d,
 	0x00ff0000, 0xbf85001e,
 	0x866eff7b, 0x00000400,
-	0xbf850055, 0xbf8e0010,
+	0xbf85005b, 0xbf8e0010,
 	0xb8fbf803, 0xbf82fffa,
 	0x866eff7b, 0x03c00900,
 	0xbf850015, 0x866eff7b,
@@ -1598,7 +1604,7 @@ static const uint32_t cwsr_trap_aldebaran_hex[] = {
 	0xbf850007, 0xb8eef801,
 	0x866eff6e, 0x00000800,
 	0xbf850003, 0x866eff7b,
-	0x00000400, 0xbf85003a,
+	0x00000400, 0xbf850040,
 	0xb8faf807, 0x867aff7a,
 	0x001f8000, 0x8e7a8b7a,
 	0x8977ff77, 0xfc000000,
@@ -1607,13 +1613,16 @@ static const uint32_t cwsr_trap_aldebaran_hex[] = {
 	0xb8fbf813, 0x8efa887a,
 	0xbf0d8f7b, 0xbf840002,
 	0x877bff7b, 0xffff0000,
-	0xc0031bbd, 0x00000010,
-	0xbf8cc07f, 0x8e6e976e,
-	0x8977ff77, 0x00800000,
-	0x87776e77, 0xc0071bbd,
-	0x00000000, 0xbf8cc07f,
+	0xc0031c3d, 0x00000010,
+	0xc0071bbd, 0x00000000,
 	0xc0071ebd, 0x00000008,
-	0xbf8cc07f, 0x86ee6e6e,
+	0xbf8cc07f, 0x8671ff6d,
+	0x01000000, 0xbf840004,
+	0x92f1ff70, 0x00010001,
+	0xbf840016, 0xbf820005,
+	0x86708170, 0x8e709770,
+	0x8977ff77, 0x00800000,
+	0x87777077, 0x86ee6e6e,
 	0xbf840001, 0xbe801d6e,
 	0x866eff6d, 0x01ff0000,
 	0xbf850005, 0x8778ff78,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index e506411ad28a..6880340c25af 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -104,6 +104,10 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x1F8000
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK		=   0x800
 
+var TMA_HOST_TRAP_EN_SHIFT               =   1
+var TMA_HOST_TRAP_EN_SIZE                =   1
+var TMA_HOST_TRAP_EN_BFE                 =   (TMA_HOST_TRAP_EN_SHIFT | (TMA_HOST_TRAP_EN_SIZE << 16))
+
 var TTMP_SAVE_RCNT_FIRST_REPLAY_SHIFT	=   26			// bits [31:26] unused by SPI debug data
 var TTMP_SAVE_RCNT_FIRST_REPLAY_MASK	=   0xFC000000
 var TTMP_DEBUG_TRAP_ENABLED_SHIFT	=   23
@@ -288,17 +292,21 @@ L_FETCH_2ND_TRAP:
     s_or_b32        ttmp15, ttmp15, 0xFFFF0000
 L_NO_SIGN_EXTEND_TMA:
 
-    s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 glc:1 // debug trap enabled flag
-    s_waitcnt       lgkmcnt(0)
-    s_lshl_b32      ttmp2, ttmp2, TTMP_DEBUG_TRAP_ENABLED_SHIFT
-    s_andn2_b32     s_save_ib_sts, s_save_ib_sts, TTMP_DEBUG_TRAP_ENABLED_MASK
-    s_or_b32        s_save_ib_sts, s_save_ib_sts, ttmp2
-
+    s_load_dword    ttmp4, [ttmp14, ttmp15], 0x10 glc:1 // enable flags from 1st level TMA
     s_load_dwordx2  [ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 glc:1 // second-level TBA
-    s_waitcnt       lgkmcnt(0)
     s_load_dwordx2  [ttmp14, ttmp15], [ttmp14, ttmp15], 0x8 glc:1 // second-level TMA
     s_waitcnt       lgkmcnt(0)
-
+    s_and_b32       ttmp5, s_save_pc_hi, S_SAVE_PC_HI_HT_MASK // host trap request
+    s_cbranch_scc0  L_NOT_HT
+    s_bfe_u32       ttmp5, ttmp4, TMA_HOST_TRAP_EN_BFE // extract host_trap_en to ttmp5[0]
+    s_cbranch_scc0  L_EXIT_TRAP // HT requested, but host traps not enabled
+    s_branch        L_GOTO_2ND_TRAP
+L_NOT_HT:
+    s_and_b32       ttmp4, ttmp4, 0x1 // debug_enable bit left over
+    s_lshl_b32      ttmp4, ttmp4, TTMP_DEBUG_TRAP_ENABLED_SHIFT
+    s_andn2_b32     s_save_ib_sts, s_save_ib_sts, TTMP_DEBUG_TRAP_ENABLED_MASK
+    s_or_b32        s_save_ib_sts, s_save_ib_sts, ttmp4
+L_GOTO_2ND_TRAP:
     s_and_b64       [ttmp2, ttmp3], [ttmp2, ttmp3], [ttmp2, ttmp3]
     s_cbranch_scc0  L_NO_NEXT_TRAP // second-level trap handler not been set
     s_setpc_b64     [ttmp2, ttmp3] // jump to second-level trap handler
-- 
2.25.1

