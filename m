Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D14C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904E710E9CA;
	Fri,  3 Nov 2023 13:12:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FDD10E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6F8qd1i9fjd6bvJV3G17m4hzpJgGbHyud9ERc1k77B2eQnHR/+IDVfvvvhdhykyY8KoAHBYyw35vdlkPMlapy1dTATOilehFeQAj4oaHqPYWfBuN0j1f9qIxqD7z6CdSHaHg+WLgalkQfWCBbiw1VVBs928vLTphqy8e5k76Il0njH/5FcaHO3VcMBYRTSWsY3Om2V+34vITOGxuFMUNdi3ubqXUzuFQ1uPwFW9bSF9JKk9GwQ9Qu0hFswyn8mLLCqu2+pwV/mSNbZIrXbRMAllGsSCGNB5OvR665+alvDn/GplJ79wE+h/hfeTn3vG14TuhNEs51TLvIR9wflFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBlvMccGZ8oGIMSCzU3MPSBBQuVNvGsMYjkz8nGe2bE=;
 b=kbLj8MZTqD5dFPyl/BcH76RWKaqRhlM0L7e7V1cVtqHhtUQiqffiMbt41fHI98vbqgXWd9utB1hhO5dssMKcCtAMBCSDcYCe2dtwGbvGcVSBj0jUCVVnwQKlgOBOl2riSYnzz2QEVCfu1ey7NSRCufY8vJQBNpVRWARq0WNzSK7AphJjf0lZjXgtW/ovnKt9hj0zDi5nPXxXhtLgNmL1D5GfL+muJUxxRZyklwdAUEx95BYtPq4lAZ2Hx6DoNnCoQSyoqR/GV6ww4cXNrKjnM2lQ6V20FXLwJna6TvTAK64VY0yo7yBGnv+IICcBLxMmwaqH6gH1TAltu0RHanKDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBlvMccGZ8oGIMSCzU3MPSBBQuVNvGsMYjkz8nGe2bE=;
 b=IZTt041UYJ4he1NS1ZJ6jsnJi9YPhHxQkiM+ZW5g38+APAHruj374k6ZiLi89zI7YrZM3rYBtHtBGoWzTQeXs4FePxl9y/dGZm4a9X79tTySuv2WwaclHLQuzb2E0dPOqEmJU8ld+s/v48v6XKOKQ9q1OU1bG768pFg1Jrcto6U=
Received: from DS7PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:3b7::14)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:06 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3e) by DS7PR03CA0099.outlook.office365.com
 (2603:10b6:5:3b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:06 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:02 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/24] drm/amdkfd/gfx9: enable host trap
Date: Fri, 3 Nov 2023 09:11:26 -0400
Message-ID: <20231103131139.766920-12-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c26d6a8-bf85-4391-2147-08dbdc6e7a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDvmazb1o618JfSwyTMLTjyno48e/4ij5PvVxHbu6KiiD7DADJxTZxhKzchc7kq0gcIGlxECgtyjH1P1rcVPS2kMQu7AyNmRSb9NmrhA7jt+1/h09YBTfUILDXwN29x46KjK7Nud8N1iaaLQ/0zoJUEhFjwKc5bkoeyH8PM1W29gvDNDkkgqABzTFrObmpqdxDQSOhE43qT6WYPs1AcUhuYJVYuMmXCrzcOdJQd/VqI5+66+7KJTivTz+eawKU6tal/GSWlKOG5talZ9ag2WbsZ6sCKhNBxNdoqTf2xk4uFSCLvKw5rnuvLCEI71NbC9HnTr9t9P+g/9GGcDHQndYLrabz58VVtY6r6i0hL48jKfunZiuabsuCO7/O0Sh8rZQ8xcvnyDjuZ0rsLvJ3AyEiopiLWCYN6lII8dmHDvfL0QeCq2KN6ZXwsO0PbJKjKtXrBcF57l3Rzx02xGNdiOaqxLqK5joL7OYfGQ+f5qgxMvsNwNmvQrPnZhZtzMgpbTFG5mtrX7X0voXTh/7CJpL9x7d/czEoVQrsSl7/ty9UssbMgc4heqtm9NFQjJy0YddN3eBTxuIRe00OHpXD9p8hqAcAaph/LL+HI+AQTUm2fVJnbHKRJcfcS2Ug79u10ElFAOjbpmXMKheDBYU3jwp+6L1mzMkZNjNKan7myMeoXzO0+rvgM9ZNGM1W/yeohl1TXDseHE2Kk+ILwUfSne+GWmLay3+txk/STi/8v7PXswd2SdMZ8W/XVdF7SiW3GMvkXIrbnEQCSrqznY6jeIlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(6916009)(40460700003)(16526019)(426003)(26005)(47076005)(336012)(356005)(81166007)(54906003)(36860700001)(70586007)(316002)(5660300002)(70206006)(8936002)(4326008)(7696005)(6666004)(41300700001)(478600001)(2616005)(2906002)(82740400003)(8676002)(36756003)(86362001)(83380400001)(1076003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:06.1079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c26d6a8-bf85-4391-2147-08dbdc6e7a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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
index d7cd5fa313ff..c16595680faa 100644
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

