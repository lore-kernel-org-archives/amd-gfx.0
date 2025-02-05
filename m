Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A709AC02198
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 20:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553A610E3DD;
	Wed,  5 Feb 2025 20:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w3GvD9El";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE42B10E3DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 20:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ongXiQZjopOg7ZgHCf0myw8Tx78AaSQ+6BNkqo4MjlWNbmACN7K8JrbLRh+BMFYNB3HqZKBFXTOqCOZYBOWfKgkWUdggHj9nYQaj0PEQyu7LuVp34QGFoch5FXU0U17qiJTWGdYnea9i/MYfnA77UXognYBr4ujy4GZ17OnvNXXUWej+lG6rAiExplc2e1YZvbIdPG02TCHYCfCjifQXxyo8091aWSMnQQfqJgcxB7x/16ARc3lJPuMLJQ2FGlMvbEQhrK3gMME2JkLaL9MTy5GBdJw5mm0+sHr2U+xHOlPPiRoBHjnfMBzbNilxFVhM79ox0IlCy/Fx4TLQnBtdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXLhK8WsrPDSjW7+bP/GPX1R8J1d+RUKPSbuLWuSkJc=;
 b=xH/2ft4WC4JslIsbK+hGMirA6wbwcTZspyWb7apr6s29GzpSpMJ8Fv5t/5QK+oNEIySkLCh2HsLae/hTnO7M7FcGYKCU/6oA49pgcE59xY8rNsZdsoiTbRTc7hdtXpV9LBZq8wlw5Hr4l+DthYGStwGD0mbnMjUy8vyxqbnL7AxrpM570nXOL06Qc7hWkLldgXAZV7wApSyrBXo+o3UlKrFRNxkWpixzM4B16UDCCQv3I4BGB1s9XvPB3yFv3Hr+ebE0ww6rUOzw+hny9Y/EEHcupMajtkiTrb1x76jPjr22hQ0akapqweWB8Qf/225pTU1bDm7FimOhS+pSvLWVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXLhK8WsrPDSjW7+bP/GPX1R8J1d+RUKPSbuLWuSkJc=;
 b=w3GvD9ElrC6tzw1GFlIDfOyFieL9ChQ5maxkY6y7f2rRCq7fuDVrjbVtQzjUmgEW+FO/KtNgiXxLurGc8whHKBZgoOnTpxzuVnGgIOouidaYkQtbkWX1SOiewoeSu6nIlnGLG5cvlS4es+kDzX4CfPfGoMGzvdrMH+AIgT50Ats=
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 20:14:04 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::8a) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 20:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 20:14:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 14:14:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add flags to distinguish vf/pf/pt mode
Date: Wed, 5 Feb 2025 15:13:27 -0500
Message-ID: <20250205201327.3628094-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dea820-ab41-4888-7a71-08dd4621a331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LkFadYkzjpUw2uLS29RTcR9b0qPrcDEVDJLLCpFnmmpWc2QEnua84xKCxKAP?=
 =?us-ascii?Q?OW5fKgHRJhrPZ0lBSJ+aOrjQP46MTa0KbGNdlIybet0NX/rMPzBZDFKCcBME?=
 =?us-ascii?Q?rJAgjhBPMMWCB6b+UE9QCON0Cq11DCkXWCr6JA1PRZAstVZ8KP8B76E5r3bA?=
 =?us-ascii?Q?1Fai2ZJN2c0WV4R9I5dXpwUv0NkCiTSOIc+zZO/VS5hOoFzIrsFc1zaUutLu?=
 =?us-ascii?Q?0CsPe4MO0hykHfWLgkHA4Jb5ubZO1IFfWS8r4YL9YgVW95upkNuygfOwJUAK?=
 =?us-ascii?Q?en9ClIvrs+IZooAUBgxhpaNgtM45zeyobz+vNHV/ILChDj48SdEqB0KKkGBJ?=
 =?us-ascii?Q?FlP6UaLgO/9prvPAURhyx/Yo6244897VDYfBrN+KjWvoGiX85ASIN3/r/brZ?=
 =?us-ascii?Q?af01jtlFjvy2S+TQDTiIYiwjoLtEWNsn4RC627fG5M6KpaA9XeIIs1SI+5Fg?=
 =?us-ascii?Q?AZzKFmLIM9FD/zVxtmCqpDH1ZB0tBuSjXcbGlGY95i4d85gwmUo3WiCQ53Me?=
 =?us-ascii?Q?Pi+95lMORw0NfXXcTlserlFUmnfqNZ9KrFpE6cDt1/Fm4kgPMV/mIz85BKq5?=
 =?us-ascii?Q?7k3pN8vWYa7nhpFkxrl0gMVJzjBEFgIYOI9rSRPaEh1hJ5RN/D49EWO8AaYN?=
 =?us-ascii?Q?o8t374+PEnBrH6WLbeZQsSFkejX97AEhFJ7oCraBNuwZMeGbrcjZQulC3WLz?=
 =?us-ascii?Q?Ca4/eI1QA1eo4EeAli0gYA4fvgr9OS7tGxGc4DY/s49zviuNxza3wN3RRRBg?=
 =?us-ascii?Q?ZyLRvP88BJOd3+QtWU+UaV0r5GtnKoZ3hH1xCQqTp1jt+RH8AmwxtmRpIqJX?=
 =?us-ascii?Q?PaJID9NUTZayWIVteBjG/9gJ0601+nd0c0c6LvECMaqup83VHoPbf45IDQtz?=
 =?us-ascii?Q?hypWAndCt2OAAUK6Pq4t7tcpPgztLVxRCLZzSnioUBxOpb20/AStKOsRA9pd?=
 =?us-ascii?Q?l992WT05sRNQdUAc+KvhD8ZKh4uCrIna+N/QXZUrZ5Dm4WPAhQPDl5oUC7K+?=
 =?us-ascii?Q?vr5RObthaXzQxT3faFyqmPS9MeTkkodaOlFmQhBklBgeUs06NIY9BvoQauWF?=
 =?us-ascii?Q?yvamGW6chmwZHqDeDw3QD9D/8C2FPP9c7rp/t8iGYtjYxUaXY9eqjB/LJJ7i?=
 =?us-ascii?Q?f6mlJ8eDlhv70iZbJnVfb5XRP4sxr2TO1Jr7m4MLOLFl0yH3IRxVGkaRYNjz?=
 =?us-ascii?Q?IGyrjxnIw9gL5rYWdYZqhKPs2taG0FdO/Y1RbAt1k9VGBLC02ixO4crTj1ju?=
 =?us-ascii?Q?qJkWTGhQz0WQ1JvzoyGHmCnHozKOqiBW0p6/N3tmhXx09X5KI0hZwsrx6ZrQ?=
 =?us-ascii?Q?xaR4bfk2jr0twRIHWMtUpCjgP1jLNfGuNkNxp/SncRaGLeDwF7DeWh0sQFWs?=
 =?us-ascii?Q?TEfccwdkfsTpN8deq46dbnruOnh59ziK1UesOP92KkSlvtPL17ttcThM92WW?=
 =?us-ascii?Q?Hjpe3P0ei+s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 20:14:04.0709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dea820-ab41-4888-7a71-08dd4621a331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

From: Asad Kamal <asad.kamal@amd.com>

Add extra flag definition for ids_flag field to distinguish
between vf/pf/pt modes

v2: Updated kms driver minor version & removed pf check as default is 0
v3: Fix up version (Alex)
v4: rebase (Alex)

Proposed userspace:
https://github.com/ROCm/amdsmi/commit/e663bed7d6b3df79f5959e73981749b1f22ec698

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  9 +++++++++
 include/uapi/drm/amdgpu_drm.h           | 10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95dd2fbc26c54..0b058f4c8fff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -123,9 +123,10 @@
  * - 3.59.0 - Cleared VRAM
  * - 3.60.0 - Add AMDGPU_TILING_GFX12_DCC_WRITE_COMPRESS_DISABLE (Vulkan requirement)
  * - 3.61.0 - Contains fix for RV/PCO compute queues
+ * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	61
+#define KMS_DRIVER_MINOR	62
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 2c76bc5e25d92..bfdee93d0446f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -909,6 +909,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
 
+		if (amdgpu_passthrough(adev))
+			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_PT <<
+						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
+						AMDGPU_IDS_FLAGS_MODE_MASK;
+		else if (amdgpu_sriov_vf(adev))
+			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_VF <<
+						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
+						AMDGPU_IDS_FLAGS_MODE_MASK;
+
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_TOP;
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ed4ee109cd222..9fcf81ab39a94 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1025,6 +1025,16 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_IDS_FLAGS_TMZ            0x4
 #define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8
 
+/*
+ *  Query h/w info: Flag identifying VF/PF/PT mode
+ *
+ */
+#define AMDGPU_IDS_FLAGS_MODE_MASK      0x300
+#define AMDGPU_IDS_FLAGS_MODE_SHIFT     0x8
+#define AMDGPU_IDS_FLAGS_MODE_PF        0x0
+#define AMDGPU_IDS_FLAGS_MODE_VF        0x1
+#define AMDGPU_IDS_FLAGS_MODE_PT        0x2
+
 /* indicate if acceleration can be working */
 #define AMDGPU_INFO_ACCEL_WORKING		0x00
 /* get the crtc_id from the mode object id? */
-- 
2.48.1

