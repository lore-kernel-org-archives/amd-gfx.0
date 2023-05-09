Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19694C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C44510E407;
	Tue,  9 May 2023 22:18:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6953910E407
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCHmJtPFHdKdY7aLQWn2Nj37Sxp7f3I1BZy0FABVvO+SSryHEzvkdmLVEN8qRP0I7Ma+K+hboeZCq/VXO8mzS8g8xmps5bu7iojIWgjFXkS2I1qzWV+twJgZIQmhXivlAFeiLKojSIOe5yCoB+q0dkgls+AV4cCo6o3VhyUaPZdS3N3IYcKCFLYaWATUwbauwb8Z6DGAzZapFF1RINr8arTOs09uYKn87auYJTqnsInMAp0jPaZfAOOpVCYA3Z1yjFQ+4peePELCKIe5d7m7fUkf02ILy4/Nz40z7DGo5ZablnNnetcmOwHGapSrynDjTFZ3QEHb/2Z1FP1NL/6tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpvv43iY4vCQutW7Sqlz1AH3V/t9F+0dTWd15MU80/o=;
 b=W/4MBdyIvqmO2HSf5Vf+2ehOxNtCFsuKs8nNqN/thTovt+W1w4/JoPNuVf1A9c2C/PzgeiPp3e3AJ49cdGUCi+XoNvSbRE0rXGGQaff2hDu2bVZDYyzqqoVvdrKaYkO1QlaAL4Nnn+Az2dU/DmRhka28YdbOno1FwvCxwNAGM5Nf6uCEGZGoegxr1niNRpWT+8vJpk/J/49PwQ9RveThsuvXFxzMGoKqcD48cDxS+l/CT8Z/V9Iec+k2PIAI6MwzBvfoT2wke4vgcscNHVzX0YFpekv35DoQGQD5uN+zW9EV7VOOrMYS+sworu26RZYlbzLbJvIXRoy8ho6rH+agOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpvv43iY4vCQutW7Sqlz1AH3V/t9F+0dTWd15MU80/o=;
 b=A1hiyOars1BrSYWEHzUnCJAyeOY1IqwTyiYYuGQkvRIeFkszsvxPKHfe/DMTuwysFy/yXEpS7/RTRh3yeq09XyEcgoJORqP4W4eE+GIPkV+0huEa+PYTejLeGu14aqJiH0lYS7y9T4jKJJEL3opWgIgyBbmLdFxs4BguWUnsd7E=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:18:44 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::13) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:18:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:18:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add compute mode descriptor function
Date: Tue, 9 May 2023 18:18:28 -0400
Message-ID: <20230509221830.477324-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: c326ac92-6202-4dad-2168-08db50db5a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGFhkgAt1+VapfFId9QHpCi3KaQbzTYNW7w+Yx8TVFeY7gXkz36xjvZ8Yl0Hi8blbVQHp6Zw8xY/+bnJsXa77E+lR2H9mNRjgbSuSA1n77vMHosN4bIsC3SwvqZkxYiHPEOJkZpSME07r+SMeMPZSfQe/jEaPPz/DVBF4wEuWrOfNtR+HP1j8YxnU1nE4CMj4r1UOCt5yeh/BuGYb3KkmToozbe52WEz60ZWjxHdLIhdP4C9B2snRwHeM6aLg5anFlPTliCoMns7mS6ng0WKNJEsje4OmKeZfiJ1xw5LjiLxQW28/2kRE5rkfuQshkFUD1nnfoW29zMlb176pGbZbza/S0J4weOSzTT10rWt1rOfrWMFvEB/lGfAbSvgZeFb2wL591JI5hOViGbSh/dkezWLIbJveA37MxIBG5rM+o+XYwbZ6VFu9qSVDIqFOh0m+NX9u4CcqweOJGnLaxMDTDb/wBhQBjKMs0BUevN3w9x+T9xBASiMkQRnuBQlZWA2LG3nncp/xlaIrXvmtH2usAW4bJtrtab6LReFgMvtTGHEr2kSjs5APmnOOzM7sXJGPQDtjRDTlV7SARu7rSle2SSyVYJPTGd3+8w8Ikf32TkmDm/GN/iEQbuDbDQj4e8lR7A1JlkfHphEEGm+adAcaYLqt3Izj4zRPAcGdxREgB6SWMyyd+v7lCNF2yklPMlmCWiop/Hva6fhjxygxrzNBv4SYsw2FD1YBpgx5Kdr+JI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(6916009)(478600001)(4326008)(70586007)(7696005)(70206006)(54906003)(316002)(86362001)(36756003)(336012)(83380400001)(1076003)(36860700001)(26005)(2616005)(426003)(8676002)(8936002)(356005)(41300700001)(2906002)(47076005)(40480700001)(82310400005)(5660300002)(82740400003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:18:44.5476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c326ac92-6202-4dad-2168-08db50db5a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Keep a helper function to get description of compute partition mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +-----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 817e7b7d32b7..2ebf5c6f4ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1169,33 +1169,11 @@ static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int mode;
-	char *partition_mode;
 
 	mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 					       AMDGPU_XCP_FL_NONE);
 
-	switch (mode) {
-	case AMDGPU_SPX_PARTITION_MODE:
-		partition_mode = "SPX";
-		break;
-	case AMDGPU_DPX_PARTITION_MODE:
-		partition_mode = "DPX";
-		break;
-	case AMDGPU_TPX_PARTITION_MODE:
-		partition_mode = "TPX";
-		break;
-	case AMDGPU_QPX_PARTITION_MODE:
-		partition_mode = "QPX";
-		break;
-	case AMDGPU_CPX_PARTITION_MODE:
-		partition_mode = "CPX";
-		break;
-	default:
-		partition_mode = "UNKNOWN";
-		break;
-	}
-
-	return sysfs_emit(buf, "%s\n", partition_mode);
+	return sysfs_emit(buf, "%s\n", amdgpu_gfx_compute_mode_desc(mode));
 }
 
 static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e9c93f6e12b8..3d11b7a0bd75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -494,4 +494,25 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
+
+static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
+{
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		return "SPX";
+	case AMDGPU_DPX_PARTITION_MODE:
+		return "DPX";
+	case AMDGPU_TPX_PARTITION_MODE:
+		return "TPX";
+	case AMDGPU_QPX_PARTITION_MODE:
+		return "QPX";
+	case AMDGPU_CPX_PARTITION_MODE:
+		return "CPX";
+	default:
+		return "UNKNOWN";
+	}
+
+	return "UNKNOWN";
+}
+
 #endif
-- 
2.40.1

