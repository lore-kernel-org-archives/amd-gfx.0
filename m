Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D3BE936E4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 20:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E4110E1AC;
	Wed,  4 Oct 2023 20:23:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE06510E1AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 20:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNrn9yJtsJhXgni+A5kKvOVSHGMPluuH/Ih9oFnIWO3u/Jc/ZRyIF6KGLWVsmeh4idod/NpRRuSA4H5ytDzEsNvkD37709hRCFn6MsIZ7KwHlnN3kELERnfY5o3K7qNCylDbO9MvFEBaYU0ffEIx9pxZcYJkKUrNwHMKeiDHXx5bCOnCA5zJYXvGNICr1p8P7R478X6CsnX7lgkr0kUrAno4Pby9hLfU206ygdR6G0bJ8oRwTuKHl113SJjgDKzXYEtIi12EMkGp6huvFhuaKBhIQtuqE99j5f7SwDg63LQlpQ2TeYc5LkhAcpTo8X3SBx+PDmnQyqHcPpZ2t6OSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mI2kv6kfCxAe8lNnhPpJ11kE8+Sap6+9UwlOzcw8FM=;
 b=SrAomE8hnOVdeq9Y+B972bzJ1hkAi28mpT/EMVxfx+ZYVGoMBFXJOI7M28aUKywkglKfGzgyodD72OYvr2Sj6tr/X+lXWuvvVKGKTHcptsgN6q+7pSLsxJj4hDrg1VBtA450qB1Yz8/E4tyBa+g2g9pFVulQ2LFtIuI2Jzk7mvC1d3xpCUtRKKq2+/34MdFfNtw5taH7VfXvZhH5621+76OzSrRBx5/mux8lghZcraoO4dn1HmdRe0UX7WwbQVbwKHE5h397j2+onebKf2extHhcka56Nh/bgKgbuHIQeewFmEMtn8P7wFDxXkUhQ3FYuczqLzroHYkyyJwqL4gFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mI2kv6kfCxAe8lNnhPpJ11kE8+Sap6+9UwlOzcw8FM=;
 b=Ra+W54r+FctigKPdD6g+yQk+ehxMAkw9sciabJ+5rvPLvFXtObYKBfZplzNAuDNbINW/vdXvyurgkgZAe4i0OtKqx2abci5Pyo0wvx4yBWaWFroVc+FD5ETtoHrA5au61zbsHHOvZ6rRHAwk1/wKOzhltGLoPKBb64H7d7BB4PQ=
Received: from MN2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:208:134::17)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 20:23:12 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::e3) by MN2PR16CA0004.outlook.office365.com
 (2603:10b6:208:134::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Wed, 4 Oct 2023 20:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 20:23:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 15:23:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
Date: Wed, 4 Oct 2023 15:22:52 -0500
Message-ID: <20231004202253.182540-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b121f2d-e47e-4897-157f-08dbc517bae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqlJYLdYFXQ/O2iQLYSG2h7H9VOJH9tQszefv9MlRJ8zecp/wwJyTGqMH8Rv23RMvjoPfbDtM9g0fLQgDpBzyvraDqg/zLRR3gUJU+H3Oe5cuBzuJPLSn+Vc8jhCoJI3TFVJMLVpQbzd4md+9mbZFvXp5+k00XHFcKLHFdPW6mMbDRq450MJI4Gx0/4La55D9y07OIf/we1nokAah5WChudIePFY7ilnVCd/ZowTe4dA0t6uAvic/TiTg+BS04WhsBbevoSTHJSxIn0s8HChIzOqOhUDKJxZtVj6qZQZXKB0e8QrKyB3eA9hPkZyfzNrF89sJ1egqp+2gQCvlTTrk6X9c8z5OcVDDFTcmh3rrS4/XU4VG/5/kFv46JugeAUoht10KbmnOVCAJ6vVkiW0dbnoPPW7VknVBKOH8t9RWozL7uF7yIUb+cYemGcUDUy1/eoH815bOSV1LN6/sK7HMHuRhYjCrudbbT+vx7iAahC8vyOWRPGlyTz3ALb8Xi+L3Oe3+3gCBYrhv2nh/LxjvWaWhi0LQyO/xBjtTZ1860nmUGOl0L1FD+b8XSJV2Ts8G3EXSHbIN2KZjZxi3An8mmhrRTs9YB5rXluaE3FKN/P166GUFwzcxQWbQtzgPTLN9qbRDXOf+9VcI37xreoF5y8gZvJG7kT3EqnpjdZrTNrE4kTssQQez+nBbg9QwMD2dJgx/Jhot9DE1zHuaZT/Qjz1quyzBB2QIDagOEuy8j7efAH8juOgKcm2f2KhH4VL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(7696005)(2616005)(86362001)(1076003)(478600001)(966005)(6666004)(83380400001)(47076005)(336012)(426003)(5660300002)(26005)(16526019)(2906002)(44832011)(70206006)(54906003)(70586007)(6916009)(8936002)(8676002)(41300700001)(316002)(4326008)(40460700003)(82740400003)(36860700001)(36756003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 20:23:11.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b121f2d-e47e-4897-157f-08dbc517bae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
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
Cc: Felix Held <felix.held@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For pptable structs that use flexible array sizes, use flexible arrays.

Suggested-by: Felix Held <felix.held@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2874
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/pptable.h                 | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 0b6a057e0a4c..5aac8d545bdc 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -78,7 +78,7 @@ typedef struct _ATOM_PPLIB_THERMALCONTROLLER
 typedef struct _ATOM_PPLIB_STATE
 {
     UCHAR ucNonClockStateIndex;
-    UCHAR ucClockStateIndices[1]; // variable-sized
+    UCHAR ucClockStateIndices[]; // variable-sized
 } ATOM_PPLIB_STATE;
 
 
@@ -473,7 +473,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      UCHAR clockInfoIndex[];
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 7a31cfa5e7fb..57bca1e81d3a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -179,7 +179,7 @@ typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
 typedef struct _ATOM_Tonga_MCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MCLK_Dependency_Record entries[1];				/* Dynamically allocate entries. */
+	ATOM_Tonga_MCLK_Dependency_Record entries[];				/* Dynamically allocate entries. */
 } ATOM_Tonga_MCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
@@ -194,7 +194,7 @@ typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
 typedef struct _ATOM_Tonga_SCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_SCLK_Dependency_Record entries[1];				 /* Dynamically allocate entries. */
+	ATOM_Tonga_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
 } ATOM_Tonga_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
-- 
2.34.1

