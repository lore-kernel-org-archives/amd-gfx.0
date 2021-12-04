Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79A3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DDB73F07;
	Mon,  6 Dec 2021 10:19:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491806EA47
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 11:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJo7XVnVi/oyiWvSkz/rQrNhNtEhWeaqb4BSv7qa4SmFTd8hiQcY1FoZvRIRtJiT6Old66vkT/K9Gz30nG+zrKDMYoECRoQmbr5X7aha0NBby9Fj/c2F6sfeKWVMOOQ4TaAVWCUsioDMSWhYkbmwRlJws9luPYRaaF4dqJpuzpwdawzCPhO/1rVS7Pk8VOXzl1wnygdhzgXSyCM53Du6iL4/MwilBGtzYIjC6FQxxSCrcaS8gGYBpOgvNlpAvPgH7qwbXycqLsJF9q0yr758BJDZEr/+x6/2coaJRMygk0bsE3nLgDZDONENMtuiAXJPGJJQSY95NrCMRSG14yD7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UexLW/o4Cajy0V5AjRCs+HXn6AnTtNlFWDp9pxAVa1M=;
 b=SQByrm7AHKLO1MTshcMBkz1A4NHOMPfeB0Qjb8BJrMzicZq7UMC5KMPxQUz85kMQDDixjznbZ8OCdcrogybhI08b9WY3MrZnyDBnmOfAbDClIAF/yd9mfznmIwLk0wUOLYqm317KflndunO7HhQls4f6oZWsuc0kzmIv7UMgC7az2UEqY+U3tnNr3V9sW4OzXDAyuo8eVCkZTRQdB3KQXMTBS6ajnREyE1lnppDIogOA4X5S3ftONOqr+zRyhmEfhEUwFG9MnHlCbkABGc45f3uf0LXyODW23jhHW6oIMLCpvns/Z+bZMFGoscJprWgQ50ZZdCLlkX8bq5TPQgVSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UexLW/o4Cajy0V5AjRCs+HXn6AnTtNlFWDp9pxAVa1M=;
 b=pvbm6cbzdgm08Ym9PjywyG9QTZ6/Rq3nptwloiN8CXiFdjz0maNe/bRgceLoYsMgGuazh7cuI+HmAUjWXbyBPij8OgZQ9WHsvQFH8Y+EB/JNbfdf89fpKxmah0Zl3yQxMfJ/NLVSydKBKPhpMevsF7U6GDgI54pnxJQtDI4fjck=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Sat, 4 Dec 2021 11:24:06 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::cc) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Sat, 4 Dec 2021 11:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 11:24:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 4 Dec
 2021 05:24:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 4 Dec
 2021 05:24:05 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.17 via Frontend Transport; Sat, 4 Dec 2021 05:24:04 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: don't override default ECO_BITs setting
Date: Sat, 4 Dec 2021 19:24:02 +0800
Message-ID: <20211204112402.16229-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6eebbf-264a-4a6c-3e91-08d9b7189562
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44986479811A9481B1103453FC6B9@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0DhQGMH/OYsMPJ+ergJ8sMh+eu5TtEbb8Hxjqg06AaH+5dZD1LbS+z4bBgH9xp+UHK7MoLF+4WT1ZgaoH51+BOH3RCEfv7WRDXobJhQwxZLA3cChEpUp5+pLGIyjWgKIVoI7rOBfQqYzw3DwKvU+4sLiPw2FNCvYP6K2kipM6wnJPGb7iaYhOWqfVn/Cu60nQnDtqhZ6qjU2/G2Ul42OFolZA945pm+nB3scUMvh8Wz80jUcPMv+nkA049mVVp47N0pOKQURUPAIgzSeLwGARB1k2yVPj3ZIOzpJtzsoZUexdDhj/GgYgLjR+xBDnc51J+EQ52ynS1nyfJHnhlUBjGXnuQaEsNLIyeREyQsdXU3F0AXRMiQpbyEZIy39cjM+14CSB7O5MpyTGLJ58ElMNuEO6Zt8LYCj7+P678Ew9cORkk9wjS1AnVlDFL6kFcwF3o82C75PBu7SFBd8rYXUsNHrWGFrqB+gNTZZnugVa0zsUSo4wSe0pGB0WpyOy2kV687zYxsDOOtimiKd3RIuthGGpxLYz9zlBMoGwZ2DfR6m6QScCXlzH14Hd/j8uR7lgRBXcxsLMygjAtN1BQ15IVzimUROZ4ZaPDQe7bRGEE59yb98cVXZjz50Cwf9gIF+oR+y3FHUAQvKgz9s6Nnovywp5O8b/bm65Q38APWY6Fd4HkQAOgVoGLiGP4FjbljaNiH1QwhaiU8khzORvdnBv1ogwHyuXGpb+ARfLvxvCkkc+Svp5aOzQv66PR3rw5l5J8W4LKseu+udsvPFSZtIyshW7/R5OEJh82QXPU49zMI401c8WSqM0dZJm11xvycdrZTUdE4YMelVS4+zVXDgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(2616005)(36860700001)(336012)(356005)(47076005)(36756003)(5660300002)(426003)(86362001)(508600001)(186003)(81166007)(316002)(2906002)(40460700001)(26005)(8676002)(82310400004)(8936002)(1076003)(83380400001)(4326008)(70206006)(6916009)(70586007)(7696005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 11:24:06.2074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6eebbf-264a-4a6c-3e91-08d9b7189562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leave this bit as hardware default setting

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 2 --
 8 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 480e41847d7c..ec4d5e15b766 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -162,7 +162,6 @@ static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 14c1c1a297dd..6e0ace2fbfab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -196,7 +196,6 @@ static void gfxhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC); /* UC, uncached */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index e80d1dc43079..b4eddf6e98a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -197,7 +197,6 @@ static void gfxhub_v2_1_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC); /* UC, uncached */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index a99953833820..b3bede1dc41d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -145,7 +145,6 @@ static void mmhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index f80a14a1b82d..f5f7181f9af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -165,7 +165,6 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 25f8e93e5ec3..3718ff610ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -267,7 +267,6 @@ static void mmhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC); /* UC, uncached */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index a11d60ec6321..9e16da28505a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -194,7 +194,6 @@ static void mmhub_v2_3_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC); /* UC, uncached */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index c4ef822bbe8c..ff49eeaf7882 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -189,8 +189,6 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
-			    ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
-- 
2.17.1

