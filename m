Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B96C10F09
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEB810E151;
	Thu,  7 Dec 2023 22:54:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA88210E151
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrrCdeO8duSuWbOWuys0QmTGdlf8nZawvshAvIrU4A14wURabvs8qQofrhx6WpCpz184eLQBCwHskoNEH99CWpxvFTyxjOrwKRmm0FXDUIT30Wi90VJ8d9unKPWeFHKXXesFlPim9Uej7u0OB2GwPl0w+8WliGOoF1dGAaECC7cJTD60iGWZtsZKRWI1ocAHes38E1mnf+sUr0NLY8wB/z3J0yoTAKGJYh9v2AXSZJBTiOhB9rJvOzYoMko3BbpmxzsLDgIx+nJW8WGTJeHARthtZs3LbJVXye5WzJCs5fqwo/G+Ktqa27BzYbN5nKUPQCtKrS51Sz5mcD1tdMV1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujatcylXHCmGOYHFBq/USAc36TNTCdluPM6ejHtjvXk=;
 b=JvCSWblcwkxMEIAxuZncl5GtNjEo01uUrxKMnehgaX0cWGAGjmeVr+bw97z8Wc20ziXRKuxjONK0d176mcXuRJT8D5cWiLSowjs4mOdaBAD0IdzjDfRE2AReVF/lVw433glqSJXiaokSKNtF9yk5v8+td5Z5JRKSSIpE80zom03XE1s7KSa5s9l8OAKocdAsurpo+PgtZMoaEQ+wjBsvrc2+Yt6kqpyw1CFZr+t05MoBcXPbuv3FvZBLsd9zz5CHNVxui2nhDQDDgUXYNcMPDcSZh5S9Teg7fZqDqd/2XMy3H8gxm0l/ZQ8GJo9idOtaDmqcd5mOdlPktyWwmsn55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujatcylXHCmGOYHFBq/USAc36TNTCdluPM6ejHtjvXk=;
 b=O8hFc7tS11W4DE35+zCC6LqE3bd6eCBBkn60IhDEItkTlhxgY7qbaarbl7xiGVsiXyOMEzfVAcye535rgMl5fRVwEqt8jcMwrKuZ05TdHPdL2mTnISGlCuGQWe/UUuYDhVLvACPvUZjoBSy0UQbqICxcpHk3C3B2egUeVBogt8c=
Received: from CH2PR20CA0006.namprd20.prod.outlook.com (2603:10b6:610:58::16)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:42 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::87) by CH2PR20CA0006.outlook.office365.com
 (2603:10b6:610:58::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:42 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:40 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/23] drm/amdkfd/gfx9: enable host trap
Date: Thu, 7 Dec 2023 17:54:10 -0500
Message-ID: <20231207225422.4057292-12-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a82275-c9da-498a-145b-08dbf777800a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUwjIPFge5ZsBpnQqcJHvN9wsSd/YA34qn7RSAgmhq3Hur65JK1ddVqg/5uwB9xI+ioqjraBcJjqjcpTBq+MpWtF7H/L52g45R5ZosTjaJ20niVm6m8VpOtveKnZRT0Webv7smx5b77ODZvYXpcFrEhE2+hdp7HVOS0P/qVgt25DEc4ykzHqUgeyua2AqjAIG7sQnLFdYLIKhi8LOUENvyEQK1sQUSOHQZam28rpswrZmUIgLP/YcuMvSdMnmFEGnJgX+9EONdFJobONArNKhsnE3AdTKIe6RZeXO3Eny6T92x7dEIYAjBGiLh1ovEwozgjdlsURgTNGx/zMc7gfedvnx4N6g+WkmhFGCo0bVMqhcwuN5dWq8IY+Fk7EyS7Roc6jIUuwEVGB/1eJIjX7N29ngjwYUz7CpsazaWRAOkywTxXd4ObZ6/WnJSV/Sb8zg3VFvHKY/NO98hS6GuFqWAj6FA+Oo3D1JQ95WfAAwZ8wG6n6/9WSyCQXchR0t0jMNVthiXEDb9tZYLTXJj90v0oFR5C6TaC7lSgP6Rw2DrddlmEvydOm8Ih3dqv2F74gdIYWK4yGO0+bAukvY/8Szx5vhddjQpVnx1EJgtUcMCJgtKvV7rT8KaXYOeL2gAqgWAw9bU1uqYnOyM1hOcyf/uMMSBV2wZ5qUIzBf9GtcLOddPybf5p28KyaaHFpv9nqF+25rVNqBIcT4d9zNsjLKRdfdQpxHAmGYaPQ8e5Wk1TjDbSUYWXRr4EAtX4S5ODPekBt+AA2Ztj3xOApOi0cuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(8936002)(8676002)(4326008)(5660300002)(316002)(54906003)(70206006)(70586007)(40460700003)(47076005)(36860700001)(6916009)(2616005)(1076003)(7696005)(36756003)(26005)(336012)(41300700001)(16526019)(6666004)(478600001)(82740400003)(83380400001)(356005)(81166007)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:42.3432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a82275-c9da-498a-145b-08dbf777800a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
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

