Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197FFC25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 20:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DB110E040;
	Fri, 27 Oct 2023 20:42:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EDB10E040
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 20:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOvNVi78Vs5utguqvq+lGIES8Nj7BeZXGj1nvQFdf1fncM1mGgm6SeocXanB8cbkl9rqLeTj10bNPBdTTVlIOeCa2Vm/dFKogQX4uwj0epZm6Tof52SeRBpKhHb37ZqLxz/8OP/SIFEqqCELQqXCwD9Ls76P5x27wTHFJbaQZZvdoTDHM90QFEJ33Ewdn0MeAEG+henjG6lrOV4/KslQSTUoOLu5z8Ai24yMg0lM/3WjBZXqsx25PzLMYJU6KYrU9Equk+ps4LhkYoUHlH9wCcrvpF6NfxV6oaX5zDfULWR2QIrvaGuSUXZmjQqKqYXTukbdBow/ooPsdhBa2s7Ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sknQZ7OisNN7/6sDaPqWSGeNdrYK994Wba0qoUGLiM=;
 b=UmfTksnUzOWfuKSgKQ7DjZFr64nv1BGlOeypH48EY1w7lnv4MDIAgd7FqORWnw0cbEpH96Hg6cus7CGulVuL697VAYQwIQEqjKc+dwmJ55qH+DIcIcQpcAR56PUNU/xAdtbfe6v2pgZy0XueL+5z+6nrF1oZL23xqb4VjEe0LQu53Z+r0o8FM5VdSyfAQCQ+F0yscLo30bVtKb+9u43gYO/PtCfatr6XCSemEG+MCSpd1OSbO36yUdi6MNbQ9iy2WrrLmHaZpbN6rwkcQznIY8BliDvrsmi0aa+eHEllEHVstpU8MV9Q2nPpH1kdwW2LiUcyjPmZEkQ5Zz530clb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sknQZ7OisNN7/6sDaPqWSGeNdrYK994Wba0qoUGLiM=;
 b=JRkSNEH0+7gY9nQfJXOMTj/AZs0iSSqsAKBzq6G8CU29BZ320Fo/qFDg+6wxBIQai0SX0oiZzGd9z83+3ZKZ6+wjGGbQxrwsBcc78lEnBJagjc0rkF+VHVPG9bFz2MC8LOV5lsllksYKwWQEigQuTYQS8ckDZd8d0FXMjXd0z9c=
Received: from MN2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:208:120::40)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 20:42:08 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::29) by MN2PR10CA0027.outlook.office365.com
 (2603:10b6:208:120::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 20:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 20:42:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 15:42:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix UBSAN array-index-out-of-bounds for Powerplay
 headers
Date: Fri, 27 Oct 2023 16:41:48 -0400
Message-ID: <20231027204148.63090-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3aa818-f76e-4799-7104-08dbd72d3023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGSbkLbnexWelnNWW7D9chA6TmABWkgkvI+v8M5S/+84gGmW5OGbJW4Z2Yp+GvxTuGxJjOo/e1crX+dVgqsiJ6Ga4pfndUGAsfB/hlnEsRtmam+zcWFl22u0xcmkbfXBm3r2ELPG03i3tRTNZDjZYKK2BXhUdYRcrEYfXdMro/vBudCSDEndyoXS07iHibHFMy+PoBb55xSC2xeD3qJQ04OpDckh1A1Q8Ac7SuFdu34mQQpdvGtaWyrpmcjW3zwpyDIaSU9YIjMQ7rv0yLNwyKHZamWp/if8VxEJ4U935UsLPlW6zDCRtPSks/D5aO1q05pyMX9eAqKOLvbYGW4IB87RZPVHlk2AqZruJTCUD6XplAAQptxYtXRUe3QyzNqvddaegnmLwD19ZE8KRowNlfo+t3Re1RBLy+U6/iVP0L58PKC6tLiv14oRTzCGk7irGcAmus9QHD2BPZKyRLtJXCU6Ufy3oR+IwJkWZkGW4dKbmLBsxPOtPh3Qn2nriRomTFuXCoTU24GihrsDjKEarmLnaA36yUrzZyW0tV5n+j2PFWVC9LnO/1Ajor5sVc65luKZXi+LMTaNMZOK11+2m//jo/GKEn18IzCwTKKXFuTwezsJGlzOoTTC5dlyOkKTlFuFn+Ul+EUPCuYRjs8YTPJBO/Rv734cYOTnCYdG9NDA+YuFqV5w1RlgZExXXdi10waIQDC1NUifX7aaofWl4K67pJwuMexFHiVniUZikKg8arZ/nAA03F2Wk9sSw1CAcvlAoYQ55s0F86YP1Oj6MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(82740400003)(2616005)(41300700001)(336012)(426003)(81166007)(40480700001)(5660300002)(356005)(1076003)(16526019)(26005)(8676002)(966005)(8936002)(4326008)(478600001)(70206006)(19627235002)(70586007)(6916009)(316002)(36756003)(7696005)(6666004)(40460700003)(86362001)(2906002)(36860700001)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:42:08.3872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3aa818-f76e-4799-7104-08dbd72d3023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For pptable structs that use flexible array sizes, use flexible arrays.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h |  4 ++--
 .../amd/pm/powerplay/hwmgr/vega10_pptable.h   | 24 +++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 9fcad69a9f34..2cf2a7b12623 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -367,7 +367,7 @@ typedef struct _ATOM_Tonga_VCE_State_Record {
 typedef struct _ATOM_Tonga_VCE_State_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;
-	ATOM_Tonga_VCE_State_Record entries[1];
+	ATOM_Tonga_VCE_State_Record entries[];
 } ATOM_Tonga_VCE_State_Table;
 
 typedef struct _ATOM_Tonga_PowerTune_Table {
@@ -481,7 +481,7 @@ typedef struct _ATOM_Tonga_Hard_Limit_Record {
 typedef struct _ATOM_Tonga_Hard_Limit_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;
-	ATOM_Tonga_Hard_Limit_Record entries[1];
+	ATOM_Tonga_Hard_Limit_Record entries[];
 } ATOM_Tonga_Hard_Limit_Table;
 
 typedef struct _ATOM_Tonga_GPIO_Table {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
index 8b0590b834cc..de2926df5ed7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
@@ -129,7 +129,7 @@ typedef struct _ATOM_Vega10_State {
 typedef struct _ATOM_Vega10_State_Array {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Vega10_State states[1];                             /* Dynamically allocate entries. */
+	ATOM_Vega10_State states[];                             /* Dynamically allocate entries. */
 } ATOM_Vega10_State_Array;
 
 typedef struct _ATOM_Vega10_CLK_Dependency_Record {
@@ -169,37 +169,37 @@ typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
 typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_MCLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+    ATOM_Vega10_MCLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_MCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_SOCCLK_Dependency_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_SOCCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_DCEFCLK_Dependency_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;                                         /* Number of entries. */
-    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_DCEFCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_PIXCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_PIXCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_DISPCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries.*/
-	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_DISPCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_PHYCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
+	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
 } ATOM_Vega10_PHYCLK_Dependency_Table;
 
 typedef struct _ATOM_Vega10_MM_Dependency_Record {
@@ -213,7 +213,7 @@ typedef struct _ATOM_Vega10_MM_Dependency_Record {
 typedef struct _ATOM_Vega10_MM_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries */
-	ATOM_Vega10_MM_Dependency_Record entries[1];             /* Dynamically allocate entries */
+	ATOM_Vega10_MM_Dependency_Record entries[];             /* Dynamically allocate entries */
 } ATOM_Vega10_MM_Dependency_Table;
 
 typedef struct _ATOM_Vega10_PCIE_Record {
@@ -225,7 +225,7 @@ typedef struct _ATOM_Vega10_PCIE_Record {
 typedef struct _ATOM_Vega10_PCIE_Table {
 	UCHAR  ucRevId;
 	UCHAR  ucNumEntries;                                        /* Number of entries */
-	ATOM_Vega10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
+	ATOM_Vega10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
 } ATOM_Vega10_PCIE_Table;
 
 typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
@@ -235,7 +235,7 @@ typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
 typedef struct _ATOM_Vega10_Voltage_Lookup_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                          /* Number of entries */
-	ATOM_Vega10_Voltage_Lookup_Record entries[1];             /* Dynamically allocate entries */
+	ATOM_Vega10_Voltage_Lookup_Record entries[];             /* Dynamically allocate entries */
 } ATOM_Vega10_Voltage_Lookup_Table;
 
 typedef struct _ATOM_Vega10_Fan_Table {
@@ -327,7 +327,7 @@ typedef struct _ATOM_Vega10_VCE_State_Record {
 typedef struct _ATOM_Vega10_VCE_State_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
-    ATOM_Vega10_VCE_State_Record entries[1];
+    ATOM_Vega10_VCE_State_Record entries[];
 } ATOM_Vega10_VCE_State_Table;
 
 typedef struct _ATOM_Vega10_PowerTune_Table {
@@ -427,7 +427,7 @@ typedef struct _ATOM_Vega10_Hard_Limit_Record {
 typedef struct _ATOM_Vega10_Hard_Limit_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
-    ATOM_Vega10_Hard_Limit_Record entries[1];
+    ATOM_Vega10_Hard_Limit_Record entries[];
 } ATOM_Vega10_Hard_Limit_Table;
 
 typedef struct _Vega10_PPTable_Generic_SubTable_Header {
-- 
2.41.0

