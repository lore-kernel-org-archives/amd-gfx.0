Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC3FC021B2
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 03:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D296C10E201;
	Fri, 21 Feb 2025 03:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tFhzVNVJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED90F10E201
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 03:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuxJHoBL7y6YmzBwBk7hbrfujrckUGK0sPstPqNnCsVKQgg3kBXH5iX0Sf0O1OU6kunSSNTGDQtE47Ui6rIDw00DtlZuTrdTTFqcsf3Zoz7AnRRZvkotfz9FF+0F9/DpqGlfx81dZp9rpJc+jDu9obTeKN+brVD8HaP3BX0BrkOeik/dC0WE01bOYYEy8N6RG2d76xo4p+ZXbm/r/HrYeYczPLRjMovSWhr59bsLwOdxxwNSNy75FBCkgLx/Cq3n13HRjKiZ+V20r9omMMYjwcrbAgljFsTMFDsgT2cIhNZPqOwLn9kiq/tmOixOBO6+AyeLpu5zPcFXLaeMePqblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ttkn91H3jpkZU7b07wjfAu7O7Fbld1YppasQt3YWaZ4=;
 b=ub1WHo6r4Vl8DwK4aXPhgVKLmPRgJ7GTdxaB4kxyOrqxq4EEsYckSdq+DWIQnv8WwWN5RcdkEl0OeMsnT/jtQinrBXyNtsAMrYr1PE0ha11MUcnxDBOK3et8f8jh+1pnWpLdGhrBXPjLAfmKJqdC/QL4mQc2jRTydhWpgXTTi9DwsCzD/1HwHMSYOjoSlgqnHxnpC1tlvbNAk5Fu8v1+DuuCxeaLqh54oMriZ9fPi8Zqitd2iuvTSqmSIgJzc33p68AMPzH9VY+Oo2oqRRgAlNc2b7BCD55uTL8TxdxGepYYFh1r60WQaQJPUXGUEejcWl3UCyVqW+PMLnzFOLAsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ttkn91H3jpkZU7b07wjfAu7O7Fbld1YppasQt3YWaZ4=;
 b=tFhzVNVJ00d2sM7c0nGNgVfJLdMWqV9aM9mqk9QvsqVDJAhnHIbsgT4OELvQsKwtRUKRKYquFakLVCHkU15otDenFLiV3rbojA6/hPIrQarre2y2pL46l1VS+1FyAITxCl7EwsIK49I9LNgdyA4EqKSxxF1NSPXTJ7UEFVojTSw=
Received: from PH8PR05CA0020.namprd05.prod.outlook.com (2603:10b6:510:2cc::27)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 03:18:30 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::b4) by PH8PR05CA0020.outlook.office365.com
 (2603:10b6:510:2cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 03:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 03:18:29 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 21:18:26 -0600
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Save nps to eeprom
Date: Fri, 21 Feb 2025 11:17:55 +0800
Message-ID: <20250221031755.1105767-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2224288e-36f9-4a74-edbf-08dd522669bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vM6e1yfIFrAYgzyLddzEsWAV1zmO1Qa3xiPhz5NdpXLSZbPSiOlSBSG2Z6sL?=
 =?us-ascii?Q?kBuyNPFVMuoAkPsxkbzHHcZq3lm0ipemLYD/qZJMFwmGLAWmudnfvSgtyhsy?=
 =?us-ascii?Q?KY/9niV/rR3vX3ncc0oQSTbSGYHRNSVhO+/WZ2A6UuUGaiSRV2NGPiALk+sA?=
 =?us-ascii?Q?AWkgJCCfK2YJbq0SiHHHK4K/56SSoVIJChQ2ftLe11/oAStvfo9477pZx2sM?=
 =?us-ascii?Q?IK8FxnzBoBbYXQwl10VTyUbdDZbyxgQZB1yQ27WdRaAQzdBhXv8RE7IWQ7fa?=
 =?us-ascii?Q?MwcRJLdrgH6yWCimOQmsegC1M24J1Sz0unMnSExcDV6xHodxlmLSXnDtOHah?=
 =?us-ascii?Q?HP9MmFKX33dPzAf5wc185Xzcdwbx5y4Ias0lJT0nymT73PJ7IwwUwVOzSTYp?=
 =?us-ascii?Q?1E0PpXzgkAv+mZXsML0X91fwQ4fWWHCCVJsEu2fIsM5x01zLLJy0ACbj1tTU?=
 =?us-ascii?Q?9MRiuo/HTrkW08A94xKWsf8Kt09cBxU3wv4rywKZSPYzq8ulpalzpAvVtwX6?=
 =?us-ascii?Q?z7r+q1vfy40zra7vz2pMTEC3QKQCm6t5DVpnuWdBg5wRzC80kav6ihKvC3VG?=
 =?us-ascii?Q?xGfIR+H4+kmcdgXrmxefi2XpbsMbFaXczRMF5/xq0LAILh6QqiTW2PUX3ywV?=
 =?us-ascii?Q?F8qru0b/xPy8K/XNDG5XMr8H4/nzUGa390GsAEjZ+vjz+RPvQN0JiqdnNRlF?=
 =?us-ascii?Q?6W6kNcjkyKpOa9DR4eEagGWk4LqWZsm36lrRSBG/p4K94nxW1CljTAQLm/IU?=
 =?us-ascii?Q?97+EjFAOCSQfg/cwSwqgsrZrD435sAzrxeaHf5QTZwKvE7UV8POK9Itdj08i?=
 =?us-ascii?Q?HliPh0EoXXSVPpLqTL5kETnS4PK8fiIDNKy+SLf5Cls5kArmjtXv3HSNDBtK?=
 =?us-ascii?Q?kFBdjQTsOmjh5GgrF9FjJ+O28ITnnvKWe6wyTrVB2kAvVco2xbdNdjf7lGZT?=
 =?us-ascii?Q?HtrwozL7FIGp/H3C1zSMv8qFTgLw87v6cii2tDPpPV17Uzf7t5zkxdrzuCkr?=
 =?us-ascii?Q?852/9SVmuH97jvOpXC5/jzPz812pAyuxtAehyLkNcKPwQDHhBA6m1BJJFyWM?=
 =?us-ascii?Q?9+8ICWbUUo/mrEtOap//gis0iguJJ8mzk4746qs5e3DDxwjwBqdBlcNeuAqv?=
 =?us-ascii?Q?BeS9Qt45iR4u+jVJV1zHzeKpwzZySRkVsjjcpNbFz9Swm1oqwZC4l7+He5D2?=
 =?us-ascii?Q?YpWGfEr/VheYU3PXVjSREUScTFii36Twc7IsTcDx9WBDS/j9Dl8B74BIGdRm?=
 =?us-ascii?Q?xYbnaT9FTJVf1rQkBwVvt0uA+q5bIt2qKf8Owk690cNGaTBKjObErab5k1xd?=
 =?us-ascii?Q?VHE4VRFtkUo2joENI4jNBQA6lCSOXe8BkaOfrCsLURMAmCHRnRUt3wS8wshW?=
 =?us-ascii?Q?+HPn1HPFEtxZtQXDDJ5dD+wF0CAYQEWUJzzBiWr0149Z6TykneLUzV9GVy1/?=
 =?us-ascii?Q?1rjkGTmWoVwxJdyt+7uUT66lYLEERONc8xpwN/jIiN3Syscb43/8N5nool/V?=
 =?us-ascii?Q?LPGZEbE24VR//8o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 03:18:29.1180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2224288e-36f9-4a74-edbf-08dd522669bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
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

nps info saved together with bad page makes bad page parsing more efficient

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h        | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 83b54efcaa87..87fcdda3ec61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -852,6 +852,7 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res, i;
+	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
@@ -865,9 +866,12 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 		return -EINVAL;
 	}
 
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+
 	/* set the new channel index flag */
 	for (i = 0; i < num; i++)
-		record[i].retired_page |= UMC_CHANNEL_IDX_V2;
+		record[i].retired_page |= (nps << UMC_NPS_SHIFT);
 
 	mutex_lock(&control->ras_tbl_mutex);
 
@@ -881,7 +885,7 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 
 	/* clear channel index flag, the flag is only saved on eeprom */
 	for (i = 0; i < num; i++)
-		record[i].retired_page &= ~UMC_CHANNEL_IDX_V2;
+		record[i].retired_page &= ~(nps << UMC_NPS_SHIFT);
 
 	return res;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index a4a7e61817aa..857693bcd8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -71,6 +71,13 @@
  */
 #define UMC_CHANNEL_IDX_V2	BIT_ULL(47)
 
+/*
+ * save nps value to eeprom_table_record.retired_page[47:40],
+ * the channel index flag above will be retired.
+ */
+#define UMC_NPS_SHIFT 40
+#define UMC_NPS_MASK 0xffULL
+
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
 
-- 
2.34.1

