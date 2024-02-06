Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34270C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6DC112CA2;
	Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yb4ZY0o+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A1B10FC5E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byCxWLZgvO+M8YNf2073W2xhsyoyZkkgSWDrqM6tpNeAey5UuQJQnnk74jlez7hS/4D5r3TfZyZ3ZBupSI4/ig8+UefKv5g3w/Wr8a0Qqjurqkm0p0BW4XqwWwwJPdFsJ/Ym/LS63ZE6yQze51CHIFG/bo16hbUSB8m6TDQS+lMrGJLDOcDkCjSjypZwyJPLrL+2nCeZtvjydU54/blcMEOKpZIhlWq9Qtx71mDNraG1tiOpGVJJdEZqK6uE8dFttMspMH4ReLsw1Agu11qjV2aQ/KeAXbLV1UAIMb9s5Kml5aLmgXZCm/lninJya+ydyD0IXZMd+rV+xOvNKeJxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTzMepu8jz+eiVca2kuBk5pbf/hJMfv3FYv1PDjgm8o=;
 b=Vkrfd4xiFF7qGzohHU98+MxYW0HCwp0szZl5sz+PACS29I28PM6G987L7p5dS9ghIY48TlB5uxIDgqeRPyBVX+DtzalZ6PwFEVUMPlaRN2CFSf41O4iKA+WT/Jkx4Qv7d8PN9wBvK+JiPY3I+ZV0COe5Hk4q8FSnTrZJ+9FbM2aOC8FDNzcmcZrpxJt9I6/60IigUxs6Fm7yJDsV5pmA5M3RNaG6mrJ+kydEq8ndnDksFTA1XU8qNvCRfHjZMpo7CPxYNwGkAQzkQ9ytDcp6WpmUodqXeWg0pNoLnUn4YjtH8KZiK64LrZdoUhNEuLec295AaW7VrPBG+bhpNnkrug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTzMepu8jz+eiVca2kuBk5pbf/hJMfv3FYv1PDjgm8o=;
 b=Yb4ZY0o+ULKlMZfkoNnhwLkAr1gFGlZy5bHm/2/KZhs8uF3SHkJ+1ehyNWA3axs5HvsCvbZjmEfbuw3k4Wj2JNT/c8zSA2kYFNyLKzuR66F7Oy2jKfPFy9rpFRRyQOuN63Bh+oygYIU7KcZ84+rxNouCjmGrw+yga0Geyhb95NU=
Received: from BY3PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:217::13)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 15:59:41 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::5) by BY3PR04CA0008.outlook.office365.com
 (2603:10b6:a03:217::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:41 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:36 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 11/24] drm/amdkfd/gfx9: enable host trap
Date: Tue, 6 Feb 2024 10:59:07 -0500
Message-ID: <20240206155920.3171418-12-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 7721a8b3-52bf-4b43-d5fe-08dc272ca106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBQPV99zNu5uDYOY0pp5DuKnhxY7BBBl5nwU5bN9JXSbd9MvXKTl20zrmbBZbVE1uJqU1WXGRsBQntHPFo/pQzYv0jX7pPpu2uk0uTwQIC7qLzV+yGzDy5KRBAHIQvWewfooW/wx/GhNDEwLUAsYVY10o7UK4wSzZM/SWP41VoLJmBIgnEdnoGc2dXksx9OQPOHd13qEBM56BXP40qOSQ8nDwSiL8iaayX0DYueFDTUwvpu0A3A2EtqyOiprv3nsv2ULM4TO/9pBHQn+EGu9MTgwK4JazIGmPVbFL3XBKiVu0FSCDvmkcvUN8vwfdXWpnXaG2hWaRNWxVUHXw1BDvuEcNdh/ccKHXzaH/u0rQddjwc0quZOlLuusVMRCAz57NP3f0IFXE08S+V1FMm30tZQOwDbVGVwIkShXdt8xeKr8M1SJghVluWK/XFy0bDUp8BRpSPFr7l/UoqOp3k6AeeG2DAmIEjuge1DYsqBXN4v80PwAlI3fwp8hYGSmuifesn1iD86UKELOaMJ/FdOMxWvCKkY4gde13yh5GkZAOG45G+aKMKlYckpvmtcElSVUNyLERr74OBs3fiQHvvKhjAuaG28ZDb4bYKGuhSk2JsbhaAj5Va/2P0QA/ENK9DGl9fOhZj193nQwc5mhpQeudWe4wnx3z8mx8gCMPaC97JUATSm6YKxhXqNk5vq+PMhmWF274tpVwxPhTf1/o+JAAwIT8evUpaDJFVqwUw/ngTZQBhIsrCOabpDF/cB+xJcXxhcx5QSJARi8APf6dU0/Kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(26005)(426003)(1076003)(2616005)(16526019)(36756003)(41300700001)(6916009)(6666004)(478600001)(7696005)(83380400001)(336012)(47076005)(82740400003)(81166007)(356005)(316002)(36860700001)(5660300002)(8676002)(70206006)(4326008)(54906003)(86362001)(2906002)(70586007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:41.2141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7721a8b3-52bf-4b43-d5fe-08dc272ca106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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

Enable host trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 63 +++++++++++--------
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 24 ++++---
 2 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index d1caaf0e6a7c..af1f678790e7 100644
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
index bb26338204f4..991fe6bb1726 100644
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

