Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0D606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XFZl7CQe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78E910EE52;
	Wed, 11 Nov 2026 15:16:28 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985DE10EE52
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmyBjX1VcWHPWLqjfyGrU/8TktoeE0A7Np5dSartpdftR3m0yjww++QCFEoqFKUY9T/lTigoYi4TCMaWVeGBc6if07RoZ7VYKRCW74h/U0y124jnAcGDEHxQO/JLKJ6Qqpct8Ecirj/feKzQ6Rh0IpiPuH32YQPLYmAyXFtNNebXwWQ9xUcGRrHFDYFVp/xCtu/BNdcV7KfKukvLj45Yby42hpuDklc6BYjQjf8IUAzbitl0hBfKF8qzW4y8PJi5ssj8DhSCHL7xmHIUkrxO2Erk5YQOCF4gu3gAn0hELs0FHlNKIERmFnltEoH1miwhMdxN2nvfTZXEc/0hk2tHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D5PHuAgPZA3/gdS4BjfjzP+0pHLB3yT2TWsJOFDhIA=;
 b=NP9KfsOkrMPTDzb/ohKiLQZP6Fdsisi3eSmaQf4Nd2mRQt9FxGyTWEBF9Snx/87pcrStjCiZHWfOIOJcrHE3p2sDbR1Oq8EmjDb5ysEcm1gSiJZ6+g+90ga3A3wfOOia/ERm+mz/0qAErJqK7OB29w2Tpl8BJwSIc8YLGBNNWIz4NMwaPCk0ZxQu8bjk1QZwPiqXGW1X1iPAl43jQoc4CRsgxiQ0zU/7i5KOSkgQ6xlUrESNosrwR0eZzIMX2Gc85ev4zUCU3lBcZOAe0VxvLZ8HnWvldPLTIdG5iFHyuEGD/I2H4tbtHUskqkPHJlsD+6rVTV3a06vYpMpdpyQQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D5PHuAgPZA3/gdS4BjfjzP+0pHLB3yT2TWsJOFDhIA=;
 b=XFZl7CQe31PkTvMVZoGy7yx1/WzUF7orEl3R6qLroF6nR6oQ9F4B+aSBueqvzwQX89nmbsYFIiwrHRcJRBYF5mtJIImKyxOiqQt9PJIEewQf8XSLVe98VYhx6vModlxbC1sJIaQ1nCV/76NVylTJ2T0UDlDbkFviyxbzG329myc=
Received: from PH8PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:2d0::23)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 15:16:18 +0000
Received: from BY1PEPF00026967.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::6a) by PH8PR02CA0006.outlook.office365.com
 (2603:10b6:510:2d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 15:16:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF00026967.mail.protection.outlook.com (10.167.244.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 15:16:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:16:03 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 09:16:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <tzimmermann@suse.de>,
 <timur.kristof@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: remove atombios i2c support
Date: Wed, 11 Nov 2026 10:15:44 -0500
Message-ID: <20261111151546.3105062-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111151546.3105062-1-alexander.deucher@amd.com>
References: <20261111151546.3105062-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026967:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c143f76-3491-4efd-0833-08df4006bc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|18002099003|22082099003|6133799003|3023799007|10067099003|261028144727099003|5023799004|11063799006|261021135927099003|261026121527099003|261022113327099003|261022075727099003|261026135527099003|261022115727099003|261021130227099003|261021121427099003|261009221727099003|261021133027099003|261009221227099003|261009220027099003|261009223027099003|261021123027099003|56012099006|261022105027099003|261026130827099003|261009223327099003|261026140227099003|260925021311599003|260925022911599003|261102123227099003|260925021911599003;
X-Microsoft-Antispam-Message-Info: UBzhq/JbdoxwIDUqRqG+CLLtil58yALE07iTXUFoD9wxscnLSJQlXlW3IzITNgMbMLMzQgtCX4oQkLj3JPpLqHJbIj7dip+OW5QKEjDmJYsTiwOlKTJTVT2MNHGBa//+oZyq94C0dRnGFGx9eZzbRnl4zsIIXd5C+eHLkmG63Z9DZoyLIrRekH4VrtsVauOyuCcfHMFyxqdhsAnIBaTD3nYNCB0XCiEbr8sFY2pm10wXkhi6M4vjLa4MP3mU8ezxSQNb8LP6qxMvhrnX3VmtkIe3ZkxS9odPqpiF/Z3VN3ks6BbBoXsI4QCxOl9OQJ0X9ZlU3TcG72PVafFCkvZ6NjTSKoug/2tIe1ZWQxAgcSZYjlJ2D9hiXewtGW8qp9a5cvYDDBOezzQIultX1Pf4jQ61yArNf6kOYnapZlq5UmolOOMVO7RLnVpR5osCjHwhcoCHSvYwVy6oHA8QYrVafJRgKDeli1CDnlmxIU1yA4zNqGkAEkCTpld0lL3GIHzZtDtqzDS9jrF/caGWCmBpGej4qBXt5vCLe/eKQRU2Sd8177WCFLoAU6etS3XcIWPsntFSYKTnhWzDHypxuD8U0GKTDv9UyPZ/19SOJ+pzU8Y4PiRnz4LltB3/ONEBuoDHmNr+8OoDRQLbdp2HmP36lBANBffBldJuRgEg3Qyy9QI1Il72xalXESDDqyOSYIvJP1LbLUHisdHQ023aPz0hyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(261028144727099003)(5023799004)(11063799006)(261021135927099003)(261026121527099003)(261022113327099003)(261022075727099003)(261026135527099003)(261022115727099003)(261021130227099003)(261021121427099003)(261009221727099003)(261021133027099003)(261009221227099003)(261009220027099003)(261009223027099003)(261021123027099003)(56012099006)(261022105027099003)(261026130827099003)(261009223327099003)(261026140227099003)(260925021311599003)(260925022911599003)(261102123227099003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8p9Zgu4rx1Rk8eVnUCG9lQIDvMk1YkRTMWt/Je9hnXuyDvmBoYj7kBaSLqOhNjflDf+j2K9vYAavE5TOHIp87se0hTxruWDjCzANX1geeZkXCETgeliJN1/23TOxxUpjey6P8E/8FzIoKYVfsB+JCNN4/eWKyi6DphwghtZtN/AMBTbgU+6gkZ5pWqt/cLAmQJp6/S/gpHM0Gi4jYGciMlnR2solLtolx7RTVQDrOgZ1yv5dZm5x5MwCsMRA4q1szvbX8Lao2bmJnVu3MgMjJs7mjpGWYYVanhFGqjuhMrfNgEg/8bsxuLRuceNwxslCsAp1tCOEa3n7+trcyoizLiKeLD63t2uO8Yy4/6CgP5URYrnSA08Y2WePnlsb5zJVtZWHAQ1jq+2TnGqIB87MNOIbVrnkm75ZyMo3Xto3kSp7VR+zg+WZb2sdOxQFxGiU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:16:18.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c143f76-3491-4efd-0833-08df4006bc65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026967.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This was optional behavior controlled by separate module
parameter.  The option allowed for the use the atombios
command tables for i2c transactions rather than direct
bit banging.  It was off by default and now that the legacy
non-DC display code is gone, there is not much point in
keeping it around.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  18 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   8 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c      |  53 ++----
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c    | 176 -------------------
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.h    |  33 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c        |   1 -
 9 files changed, 40 insertions(+), 255 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index e363b012bb4b7..a2c35ea112ac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_gem.o amdgpu_ring.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	amdgpu_trace_points.o \
-	amdgpu_sa.o atombios_i2c.o \
+	amdgpu_sa.o \
 	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
 	amdgpu_ib.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fc8c53c61ee26..f02e9660a9eb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -163,7 +163,6 @@ extern int amdgpu_gart_size;
 extern int amdgpu_gtt_size;
 extern int amdgpu_moverate;
 extern int amdgpu_audio;
-extern int amdgpu_hw_i2c;
 extern int amdgpu_pcie_gen2;
 extern int amdgpu_msi;
 extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index f17d6da396b06..4e436fb5405b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -187,6 +187,24 @@ void amdgpu_atombios_oem_i2c_init(struct amdgpu_device *adev, u8 i2c_id)
 	}
 }
 
+#define TARGET_HW_I2C_CLOCK 50
+
+void amdgpu_atombios_i2c_channel_trans(struct amdgpu_device *adev, u8 slave_addr, u8 line_number, u8 offset, u8 data)
+{
+	PROCESS_I2C_CHANNEL_TRANSACTION_PS_ALLOCATION args;
+	int index = GetIndexIntoMasterTable(COMMAND, ProcessI2cChannelTransaction);
+
+	args.ucRegIndex = offset;
+	args.lpI2CDataOut = data;
+	args.ucFlag = 1;
+	args.ucI2CSpeed = TARGET_HW_I2C_CLOCK;
+	args.ucTransBytes = 1;
+	args.ucSlaveAddr = slave_addr;
+	args.ucLineNumber = line_number;
+
+	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
+}
+
 union firmware_info {
 	ATOM_FIRMWARE_INFO info;
 	ATOM_FIRMWARE_INFO_V1_2 info_12;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index b840707b3c40b..27f02d8e26197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -134,6 +134,9 @@ struct amdgpu_i2c_bus_rec amdgpu_atombios_lookup_i2c_gpio(struct amdgpu_device *
 void amdgpu_atombios_i2c_init(struct amdgpu_device *adev);
 void amdgpu_atombios_oem_i2c_init(struct amdgpu_device *adev, u8 i2c_id);
 
+void amdgpu_atombios_i2c_channel_trans(struct amdgpu_device* adev,
+		u8 slave_addr, u8 line_number, u8 offset, u8 data);
+
 int amdgpu_atombios_get_clock_info(struct amdgpu_device *adev);
 
 int amdgpu_atombios_get_gfx_info(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a8b1eb4e8ddfe..812b7ce7d40b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -160,7 +160,6 @@ int amdgpu_gart_size = -1; /* auto */
 int amdgpu_gtt_size = -1; /* auto */
 int amdgpu_moverate = -1; /* auto */
 int amdgpu_audio = -1;
-int amdgpu_hw_i2c;
 int amdgpu_pcie_gen2 = -1;
 int amdgpu_msi = -1;
 char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
@@ -321,13 +320,6 @@ module_param_named(moverate, amdgpu_moverate, int, 0600);
 MODULE_PARM_DESC(audio, "HDMI/DP Audio enable for displays (-1 = auto, 0 = disable, 1 = enable)");
 module_param_named(audio, amdgpu_audio, int, 0444);
 
-/**
- * DOC: hw_i2c (int)
- * To enable hw i2c engine. Only affects non-DC display handling. The default is 0 (Disabled).
- */
-MODULE_PARM_DESC(hw_i2c, "hw i2c engine enable (0 = disable)");
-module_param_named(hw_i2c, amdgpu_hw_i2c, int, 0444);
-
 /**
  * DOC: pcie_gen2 (int)
  * To disable PCIE Gen2/3 mode (0 = disable, 1 = enable). The default is -1 (auto, enabled).
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index bcf1007011bf4..0e82a041330ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -32,7 +32,6 @@
 #include "amdgpu_i2c.h"
 #include "amdgpu_atombios.h"
 #include "atom.h"
-#include "atombios_i2c.h"
 
 /* bit banging i2c */
 static int amdgpu_i2c_pre_xfer(struct i2c_adapter *i2c_adap)
@@ -151,11 +150,6 @@ static void amdgpu_i2c_set_data(void *i2c_priv, int data)
 	WREG32(rec->en_data_reg, val);
 }
 
-static const struct i2c_algorithm amdgpu_atombios_i2c_algo = {
-	.master_xfer = amdgpu_atombios_i2c_xfer,
-	.functionality = amdgpu_atombios_i2c_func,
-};
-
 struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 					  const struct amdgpu_i2c_bus_rec *rec,
 					  const char *name)
@@ -164,7 +158,7 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 	int ret;
 
 	/* don't add the mm_i2c bus unless hw_i2c is enabled */
-	if (rec->mm_i2c && (amdgpu_hw_i2c == 0))
+	if (rec->mm_i2c)
 		return NULL;
 
 	i2c = kzalloc_obj(struct amdgpu_i2c_chan);
@@ -177,34 +171,23 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 	i2c->dev = dev;
 	i2c_set_adapdata(&i2c->adapter, i2c);
 	mutex_init(&i2c->mutex);
-	if (rec->hw_capable &&
-	    amdgpu_hw_i2c) {
-		/* hw i2c using atom */
-		snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
-			 "AMDGPU i2c hw bus %s", name);
-		i2c->adapter.algo = &amdgpu_atombios_i2c_algo;
-		ret = devm_i2c_add_adapter(dev->dev, &i2c->adapter);
-		if (ret)
-			goto out_free;
-	} else {
-		/* set the amdgpu bit adapter */
-		snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
-			 "AMDGPU i2c bit bus %s", name);
-		i2c->adapter.algo_data = &i2c->bit;
-		i2c->bit.pre_xfer = amdgpu_i2c_pre_xfer;
-		i2c->bit.post_xfer = amdgpu_i2c_post_xfer;
-		i2c->bit.setsda = amdgpu_i2c_set_data;
-		i2c->bit.setscl = amdgpu_i2c_set_clock;
-		i2c->bit.getsda = amdgpu_i2c_get_data;
-		i2c->bit.getscl = amdgpu_i2c_get_clock;
-		i2c->bit.udelay = 10;
-		i2c->bit.timeout = usecs_to_jiffies(2200);	/* from VESA */
-		i2c->bit.data = i2c;
-		ret = i2c_bit_add_bus(&i2c->adapter);
-		if (ret) {
-			DRM_ERROR("Failed to register bit i2c %s\n", name);
-			goto out_free;
-		}
+	/* set the amdgpu bit adapter */
+	snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
+		 "AMDGPU i2c bit bus %s", name);
+	i2c->adapter.algo_data = &i2c->bit;
+	i2c->bit.pre_xfer = amdgpu_i2c_pre_xfer;
+	i2c->bit.post_xfer = amdgpu_i2c_post_xfer;
+	i2c->bit.setsda = amdgpu_i2c_set_data;
+	i2c->bit.setscl = amdgpu_i2c_set_clock;
+	i2c->bit.getsda = amdgpu_i2c_get_data;
+	i2c->bit.getscl = amdgpu_i2c_get_clock;
+	i2c->bit.udelay = 10;
+	i2c->bit.timeout = usecs_to_jiffies(2200);	/* from VESA */
+	i2c->bit.data = i2c;
+	ret = i2c_bit_add_bus(&i2c->adapter);
+	if (ret) {
+		DRM_ERROR("Failed to register bit i2c %s\n", name);
+		goto out_free;
 	}
 
 	return i2c;
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
deleted file mode 100644
index a6501114322fd..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * Copyright 2011 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: Alex Deucher
- *
- */
-
-#include <drm/amdgpu_drm.h>
-#include "amdgpu.h"
-#include "atom.h"
-#include "amdgpu_atombios.h"
-#include "atombios_i2c.h"
-
-#define TARGET_HW_I2C_CLOCK 50
-
-/* these are a limitation of ProcessI2cChannelTransaction not the hw */
-#define ATOM_MAX_HW_I2C_WRITE 3
-#define ATOM_MAX_HW_I2C_READ  255
-
-static int amdgpu_atombios_i2c_process_i2c_ch(struct amdgpu_i2c_chan *chan,
-				       u8 slave_addr, u8 flags,
-				       u8 *buf, u8 num)
-{
-	struct drm_device *dev = chan->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	PROCESS_I2C_CHANNEL_TRANSACTION_PS_ALLOCATION args;
-	int index = GetIndexIntoMasterTable(COMMAND, ProcessI2cChannelTransaction);
-	unsigned char *base;
-	u16 out = cpu_to_le16(0);
-	int r = 0;
-
-	memset(&args, 0, sizeof(args));
-
-	mutex_lock(&chan->mutex);
-
-	base = (unsigned char *)adev->mode_info.atom_context->scratch;
-
-	if (flags & HW_I2C_WRITE) {
-		if (num > ATOM_MAX_HW_I2C_WRITE) {
-			DRM_ERROR("hw i2c: tried to write too many bytes (%d vs 3)\n", num);
-			r = -EINVAL;
-			goto done;
-		}
-		if (buf == NULL)
-			args.ucRegIndex = 0;
-		else
-			args.ucRegIndex = buf[0];
-		if (num)
-			num--;
-		if (num) {
-			if (buf) {
-				memcpy(&out, &buf[1], num);
-			} else {
-				DRM_ERROR("hw i2c: missing buf with num > 1\n");
-				r = -EINVAL;
-				goto done;
-			}
-		}
-		args.lpI2CDataOut = cpu_to_le16(out);
-	} else {
-		args.ucRegIndex = 0;
-		args.lpI2CDataOut = 0;
-	}
-
-	args.ucFlag = flags;
-	args.ucI2CSpeed = TARGET_HW_I2C_CLOCK;
-	args.ucTransBytes = num;
-	args.ucSlaveAddr = slave_addr << 1;
-	args.ucLineNumber = chan->rec.i2c_id;
-
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
-
-	/* error */
-	if (args.ucStatus != HW_ASSISTED_I2C_STATUS_SUCCESS) {
-		DRM_DEBUG_KMS("hw_i2c error\n");
-		r = -EIO;
-		goto done;
-	}
-
-	if (!(flags & HW_I2C_WRITE))
-		amdgpu_atombios_copy_swap(buf, base, num, false);
-
-done:
-	mutex_unlock(&chan->mutex);
-
-	return r;
-}
-
-int amdgpu_atombios_i2c_xfer(struct i2c_adapter *i2c_adap,
-		      struct i2c_msg *msgs, int num)
-{
-	struct amdgpu_i2c_chan *i2c = i2c_get_adapdata(i2c_adap);
-	struct i2c_msg *p;
-	int i, remaining, current_count, buffer_offset, max_bytes, ret;
-	u8 flags;
-
-	/* check for bus probe */
-	p = &msgs[0];
-	if ((num == 1) && (p->len == 0)) {
-		ret = amdgpu_atombios_i2c_process_i2c_ch(i2c,
-						  p->addr, HW_I2C_WRITE,
-						  NULL, 0);
-		if (ret)
-			return ret;
-		else
-			return num;
-	}
-
-	for (i = 0; i < num; i++) {
-		p = &msgs[i];
-		remaining = p->len;
-		buffer_offset = 0;
-		/* max_bytes are a limitation of ProcessI2cChannelTransaction not the hw */
-		if (p->flags & I2C_M_RD) {
-			max_bytes = ATOM_MAX_HW_I2C_READ;
-			flags = HW_I2C_READ;
-		} else {
-			max_bytes = ATOM_MAX_HW_I2C_WRITE;
-			flags = HW_I2C_WRITE;
-		}
-		while (remaining) {
-			if (remaining > max_bytes)
-				current_count = max_bytes;
-			else
-				current_count = remaining;
-			ret = amdgpu_atombios_i2c_process_i2c_ch(i2c,
-							  p->addr, flags,
-							  &p->buf[buffer_offset], current_count);
-			if (ret)
-				return ret;
-			remaining -= current_count;
-			buffer_offset += current_count;
-		}
-	}
-
-	return num;
-}
-
-u32 amdgpu_atombios_i2c_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
-}
-
-void amdgpu_atombios_i2c_channel_trans(struct amdgpu_device *adev, u8 slave_addr, u8 line_number, u8 offset, u8 data)
-{
-	PROCESS_I2C_CHANNEL_TRANSACTION_PS_ALLOCATION args;
-	int index = GetIndexIntoMasterTable(COMMAND, ProcessI2cChannelTransaction);
-
-	args.ucRegIndex = offset;
-	args.lpI2CDataOut = data;
-	args.ucFlag = 1;
-	args.ucI2CSpeed = TARGET_HW_I2C_CLOCK;
-	args.ucTransBytes = 1;
-	args.ucSlaveAddr = slave_addr;
-	args.ucLineNumber = line_number;
-
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args, sizeof(args));
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.h b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.h
deleted file mode 100644
index 251aaf41f65d5..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Copyright 2014 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#ifndef __ATOMBIOS_I2C_H__
-#define __ATOMBIOS_I2C_H__
-
-int amdgpu_atombios_i2c_xfer(struct i2c_adapter *i2c_adap,
-		      struct i2c_msg *msgs, int num);
-u32 amdgpu_atombios_i2c_func(struct i2c_adapter *adap);
-void amdgpu_atombios_i2c_channel_trans(struct amdgpu_device* adev,
-		u8 slave_addr, u8 line_number, u8 offset, u8 data);
-
-#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 4666aa5b38c75..654b313b0de01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -35,7 +35,6 @@
 #include "vid.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_atombios.h"
-#include "atombios_i2c.h"
 #include "clearstate_vi.h"
 
 #include "gmc/gmc_8_2_d.h"
-- 
2.56.0

