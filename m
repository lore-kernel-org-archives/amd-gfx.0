Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65701E936E2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 20:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A7810E133;
	Wed,  4 Oct 2023 20:47:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCAC88668
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 20:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqXDADmT/UWRRbF+g6nhtQvtsQP/aJDm2Z83TfPvYEyJ/7m4Mq3JUmeyEHgsDJ2uyH+ZtAaQswrVWWrHxhw7+kO3FDSbjELjh8MVSwbc8c23CxR1jZyzkW/VmRUJVssjuEXJouqPs+aDc/tbmGdXOKpox1WFSyVB7eTvOWrbjSnC6bXSCFCXUgQVKMOYrCn9E9wvPBs6wVxyEB829iQkU1PWVlDfYHdKJSsIHU0x8SvqqfKm+86EB8SzDrSCyMr8mEXCht0XpY9BqcIdf1Ps1TRfxF+ApMSOMbsLKzgZcpn3rcoQ4S/og5YFvIuw3wNvUx4hQFpDdhkIThQjRQ6oEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR2FmoOac716NyOd4TCSWzcaX3wECrrd2SCSzyvJCxI=;
 b=QmWWtP2T4GPuf6zJEhwrBo9g5qFEpyGSddFzcDEN1wgtLnF4i1vX0VFJk2e+9fg1c6rj6NMDKL0UGZaNpirjMM8qna7Q85/fuRFvHm0sVlN+wb83J6yTLxClgs8Hxm0r85eXD4eJSPiAktmkYUjHeSoJ6kiTNLTHYmxFLjKWnGe7lm9yoabYpkrxvEI13GYdUgJgkWrDmtEfgy34MeNqylfq9bg/ojxEMogS+YwqTSOOLyhSXlpfvSVN89vLko8TdPan6A0nnfDjsFoKhPHHTvIXvsCe6q1Eoy7MMPWXzE65mwx2N9xbx3oDNyOwG0CVqXMyZc0JXhxWkxNkfkvRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR2FmoOac716NyOd4TCSWzcaX3wECrrd2SCSzyvJCxI=;
 b=ORB+W8yT4Bx3Sg4sphdLaB6knUZrzOVGkVc5Khi/7PxIp+HLwYdfw/iU3vMmQNx91VDzWUXdeLfdZVAcXuI8IjnJcjboe+FmndBWmC09zeDrrte2OZhF8II8PoVVs8sNJ1IypNj8A424NRzWRRq+M5VEcUnJwcvzlnCzbcEs1wo=
Received: from SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::10)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 20:47:11 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::92) by SA1P222CA0035.outlook.office365.com
 (2603:10b6:806:2d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 20:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 20:47:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 15:47:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and
 Tonga
Date: Wed, 4 Oct 2023 15:46:44 -0500
Message-ID: <20231004204644.182618-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 17db993f-fe0a-4ba1-ccc3-08dbc51b14fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEhq8IVszKE8hE5VKmAIGbVE83s1injiRNhNBT1hxu6PZWa1QWhnPBf7JNKVsjSR0YID0pYKo+HvO5l6m08r940pyqGBtEWDmQnVM/r7zFuqPK4bRDp/IWdKM4PBA3ytJ441k7LSoK+wfPvRhuUaLooc0oDmfecv6EilsAVneCIOti25GnL5NUHiDRp/MZ8PaDbyofMjStkwQZkOwjDYuuOZBWkBvudxOkdQSakSXxJYurIY0lfRW/Vn4JdLxlw9RGDTO6mKJjG7rCoSUqGLiCvcN5QpOBtfDM/qZncQeP1HRAkIN7sGm1Qz00a8hL4y1kycmRd6L1ig9Dytk0/sriQdLPDrafYo5Nu/hZo+RPEtGzjCfqRW0PH4aM7jONHKykYwu/2Zcq81pRpkOAGN6HCk2JLC/7c9hqVUMvrMZjGPFFcx1PEAdm4nxLqDTS+/aLU8HLRd++4s2KC+1iprSl3dbKT5nOuq504qv+5uKRwnJyukq30/O7YlzLm8NXb28NiwBrxGQiq+MZpir5CzetgYIQaOimR7ltCEsGLeZKXgchtWMJCfY5axE54jV7D2RzC4TzXwJu85SvqB4nEz7Hkk/DX/qx/FqHJ3piCIrrf/sZbQ+iVa1vAtYud1kXwlUOD9j34mBgLV96eN9lRVt6rj5yBze/if2vMOPFGl3wHxoLDSmm3ku+eBoRW5RwCcP0QnGwJTaTd0Jvjt2VzFd8dzUJxKITS6KJneJ5w+UKKVOEKOf5pFdYDfx271ocFIMd1jGiNgJrnWFzyjyH9CHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(426003)(2616005)(1076003)(336012)(26005)(16526019)(40460700003)(40480700001)(36756003)(82740400003)(86362001)(356005)(81166007)(83380400001)(70206006)(36860700001)(2906002)(478600001)(47076005)(7696005)(6666004)(4326008)(5660300002)(44832011)(966005)(316002)(41300700001)(8936002)(8676002)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 20:47:10.9463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17db993f-fe0a-4ba1-ccc3-08dbc51b14fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For pptable structs that use flexible array sizes, use flexible arrays.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
From this bug report there are more to fix
 .../gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 57bca1e81d3a..9fcad69a9f34 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -164,7 +164,7 @@ typedef struct _ATOM_Tonga_State {
 typedef struct _ATOM_Tonga_State_Array {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;		/* Number of entries. */
-	ATOM_Tonga_State entries[1];	/* Dynamically allocate entries. */
+	ATOM_Tonga_State entries[];	/* Dynamically allocate entries. */
 } ATOM_Tonga_State_Array;
 
 typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
@@ -210,7 +210,7 @@ typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
 typedef struct _ATOM_Polaris_SCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;							/* Number of entries. */
-	ATOM_Polaris_SCLK_Dependency_Record entries[1];				 /* Dynamically allocate entries. */
+	ATOM_Polaris_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
 } ATOM_Polaris_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_PCIE_Record {
@@ -222,7 +222,7 @@ typedef struct _ATOM_Tonga_PCIE_Record {
 typedef struct _ATOM_Tonga_PCIE_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_PCIE_Record entries[1];							/* Dynamically allocate entries. */
+	ATOM_Tonga_PCIE_Record entries[];							/* Dynamically allocate entries. */
 } ATOM_Tonga_PCIE_Table;
 
 typedef struct _ATOM_Polaris10_PCIE_Record {
@@ -235,7 +235,7 @@ typedef struct _ATOM_Polaris10_PCIE_Record {
 typedef struct _ATOM_Polaris10_PCIE_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Polaris10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
+	ATOM_Polaris10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
 } ATOM_Polaris10_PCIE_Table;
 
 
@@ -252,7 +252,7 @@ typedef struct _ATOM_Tonga_MM_Dependency_Record {
 typedef struct _ATOM_Tonga_MM_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MM_Dependency_Record entries[1]; 			   /* Dynamically allocate entries. */
+	ATOM_Tonga_MM_Dependency_Record entries[]; 			   /* Dynamically allocate entries. */
 } ATOM_Tonga_MM_Dependency_Table;
 
 typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
@@ -265,7 +265,7 @@ typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
 typedef struct _ATOM_Tonga_Voltage_Lookup_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_Voltage_Lookup_Record entries[1];				/* Dynamically allocate entries. */
+	ATOM_Tonga_Voltage_Lookup_Record entries[];				/* Dynamically allocate entries. */
 } ATOM_Tonga_Voltage_Lookup_Table;
 
 typedef struct _ATOM_Tonga_Fan_Table {
-- 
2.34.1

