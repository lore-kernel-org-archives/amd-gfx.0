Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C297FF6E7A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E0010E154;
	Tue, 17 Mar 2026 20:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2K3zMmaA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFF610E154
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaAwA8UkpA5qwmAASSOXUoNC+oBmEqMpQsL5UTg1jtKyiSRTdYYNIIoOhSCwGre7uMGBBfaoOAfZP2ZkiWQitCRNUVG92J4eMgApcXcZhcIPuPhrI25wBMeRvVPQaobLTBLsyIE6Q3c3d6+TlYioSOvqG5UAsOeqve+xFhPFtm3HS2BaixMnBobgV5pqG6HWw6/H7AIAOlxhWWe9AzldEEN7cnZAZjhuJi00UKnJkNJ3jPiQexLCsQ6+v3EPM+h5QCDi2Juoqf3oQYGJ3YpO95xg3GSAQ5fI6mCW3P6YtIluAQY89HWyWCCnX9Yeno6Y8/NW8T8s1zdAC+gCyHJLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBLhIlyO99jTnsQ0ET8Uc4KbosRsbtkZ0jQayEkgvIQ=;
 b=Qbm0pFCFXS9TB3j59YOH6di60AwYPc0WMF8maAUlGv6OTFLQZWAoHAGWWZ8DY2XnadiuseDXoGs07ieQMMVSPe3AQOUaTx2Skt3WPm2RO6zCB64nGOFWgjauebOPZlDcpojNdNZa2hZFdRiTa2GoQ5fEJBL7fly8CRxhJkgRB/PiI+IN01E3xlTlY/uaePwfIpI07hiHIQ1Bcw3t53lZvGYHWyiqV2kxYtXRYpFrXQN1kcQW36oBMECaZ7gDD7HZGCNzBt8OBCfhNABmq1l+4ZaQ2FL5Y3B+s3PCMiRbYui9+duCQLlyeVaI2bRyyM9417pWe8CfI7Qbc5hpuSpTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBLhIlyO99jTnsQ0ET8Uc4KbosRsbtkZ0jQayEkgvIQ=;
 b=2K3zMmaASuB3Pnmk5jhtRQqOYfbUxm23rVGgRPwHh7pIEERiOO++JUsPHikKQC509nNrXa5+F3b4vjdtEzysrEOnEmsNU2qJ8h2iCLe81wjzQgVR5NfR88vSt8/5uzrarRdmZYbvWkf7IY6EIpADUEvShc8Mu2gLlB5FBQiBs+c=
Received: from BL1P223CA0037.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::14)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:41:18 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::b3) by BL1P223CA0037.outlook.office365.com
 (2603:10b6:208:5b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:41:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:41:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:41:17 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:41:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu/pm: drop SMU driver if version not matched messages
Date: Tue, 17 Mar 2026 16:41:10 -0400
Message-ID: <20260317204110.3833021-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf94a09-b748-43b2-2732-08de84658a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2jQ/esDuQRhP0ni7kkZhznXDqPTN9W/8AwzSeiz1KzM1QMM6BcSAfIXuyX0H9TIoay1pTd7ITl9yOezKK+iTZfQo0d4HUH8ACUEy56HD4eCnAbgzuq9nBpbNUWKdRnlBreq0z1z6PHREMeE2YF7vSTn1cTlWl2DPRw8dedoftKSHrH+hd/GNyT0QH/zwx8n2ZV4Ytre45PWYufzxlDH/MWy4znPHWW7SgwUWsWt2OTuBaVLZm69SdOzC6rQ2AkpNQge1rHGkvPCsqR9Ve2If9rfIdXEyw72MhAXHRph4rdm1ZqgCJuPNzxnE/AsYs+FVOkQOFPnCNoXvFGZePvNCr6LRDhU8qmZOyHo8GdVcBM75coqrjRNZAsZZ5mDj7hyNYJsbw6VDKSNS072H64SJ+/+7dOW6h8eYSr53QzK6SHKCYEMv4Axl71AFtXElbR+8zM+uGR2uQDDy8ittZv8hFrxfS6FgDNhsv1OSh4UL590PtQCnmVwOrDmAHPtrNJ3cxLVnvjogA/dSYdobyYkR0I8t/LXyjt+VskySeHjL7udCRxd2f0dRsuGRBTXM3SCYe58HRamv7t7Fn+R/kcL+cjdWoul7olEg9ZncqHmkKDbG8LYgdVzAOkYLXwW66Lwr7q164x3cZKjHhmdY8y6Q3Nx3xBU1Ru2kDF0XfUjxsZpyzEogXXuGEXsfllz4Q1KqToJow0IAbjGxlxITji4mP+a63rIaIbHYhHRYVJFtHbwLY7j940HrB4rNJep/r9vjjOG31xYg93Qh5tOrlV7v2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kGm8s/Jz1zwGQhBwq82rD9ID7ip8ZzopEQq2WdQKq94246h5nHHf6562sjGiCc17U5wSaSbkgskmZNsBFkwCGvuVKOD7uKIuMWwK9rrza9dVwSv/WTINFF84SwO2V3CJj6a2FZlizCFmO+EwXfhb31BOog8nWd6MzWS/HAmIEJxwLfzMIEKY/gjsNwFzMF3o4suIsMT2s8s+ZS45Q/cPeCf3CGQ11LXJuRs6OccjobtMyrfASX2Nj8gDPuYwYYdaqcMxym9m67AxRXaHpvceulv5c613yul4wJG8cB7mmjbyA0afxa9Fm7qmMmoFJIGQkFpOX22/oHSAwGxYMUnfj5w05gCQ6AzVgAqLyRlobtEGIYJG2tyBmaHhEvVSpE+q4z2HZ/4TyUdVPZSAuFxCCf22CzH32J9QFqOKO55Z5MCYVbIGW2WlZ4XrBxE8mkOh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:41:17.8187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf94a09-b748-43b2-2732-08de84658a37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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

It just leads to user confusion.

Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 56efcfa327dfd..1eec1a88e05f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -262,7 +262,6 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 2c20624caca45..ac5e44dff6c97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -101,7 +101,6 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 			"smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7dc6687c3693b..9f01bed3970ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -284,7 +284,6 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a644579903f40..5ec2b4e6f3f35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1057,10 +1057,6 @@ int smu_cmn_check_fw_version(struct smu_context *smu)
 		      smu->smc_driver_if_version, if_version,
 		      smu_program, smu_version, smu_major, smu_minor, smu_debug);
 
-	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
-	    if_version != smu->smc_driver_if_version)
-		dev_info(adev->dev, "SMU driver if version not matched\n");
-
 	return 0;
 }
 
-- 
2.53.0

