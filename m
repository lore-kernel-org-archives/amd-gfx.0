Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BEAC48260
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 08:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C44D10E197;
	Mon, 19 Feb 2024 08:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dSMfHm/I";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C6B610E193
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 08:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWrrhriC7sRW8JTI0TRa6SaJb6+u7J+ba3sGYBeZJJmB/fdNn4ACP+H0JtZK0Wsij/rsAzT/YJmKQkbqqgtV7P3hYciKqEEOeQXsNqZ48Lefjqk7DghwGvcAlYAd+tuvCyOCwI77BZQianuXqPnIjgT/77Cep4j3AxFqiYeGUtWdONaNEEZy8Qks2Zhos/dXTBnjoPwgM4cmuyjh4ET11Hlr6D8xQWOV5zacIQ8WDuoitWGczFfJL7cT/ySyS059vOrptsOLzpEAyGQX4xU0nEqjSYSvjhx70pFV6yXUzTBwlHEOO4QrzT7WRjLUInWFfGgWBj/guJ4Coz3KxrChZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxhaeNb3sFMD5myXBdc2/GM+LdyvLZnWEre04OyYzuE=;
 b=oHrg6Qgq/GrD5FtxVsjWrWRMmR9lvBGSgV2iTTbCtbkhgdPBG4/gqsCymRef6XK18zn06XQCNYObXs0OxWownxyK9g67oTXgc4RK70WCf+3w7r4a/P4h7PHvf1wVGN+GtgGES6uj39IngXZxOqi3FezHviVtRTDYcWWI5TNAE4Lw+e+g4rFwo9j0lQry5nTZGC/YrMsW0/HXcobPhoAXNKz3lWBotx/K9WFCN8Tol98DSqNGjM6+qaUI7nyXYXecQXJUBGySRZ7m8OJJjjST9GlHkWmJ/7theAVRb3pN4HAGaolAotU+Xv1My5FM47aiupuhrCOlc2bWV2FRtXS8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxhaeNb3sFMD5myXBdc2/GM+LdyvLZnWEre04OyYzuE=;
 b=dSMfHm/IQvb1x7hGDabF/SEIVUwwNe6mvgJTLQB2qv5x6bovFZ+6aIyvwGG95HalRDTXoPEoZ/oDmxSFzrd4Biu4epyif/0iy7E++RfcRYSk/h3IglRfA4VJ1IT+W7bq525dPN/U3FV6JdRwNmhCJYRgAQlpWtttY+rDl2/NVdg=
Received: from CYZPR14CA0012.namprd14.prod.outlook.com (2603:10b6:930:8f::7)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 08:15:34 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::9b) by CYZPR14CA0012.outlook.office365.com
 (2603:10b6:930:8f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 08:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 19 Feb 2024 08:15:34 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 02:15:33 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: retire gfx ras query_utcl2_poison_status
Date: Mon, 19 Feb 2024 16:15:18 +0800
Message-ID: <20240219081520.316064-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219081520.316064-1-tao.zhou1@amd.com>
References: <20240219081520.316064-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c9d895-19d9-4b36-46fc-08dc3122f28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gi/+DtjaL8a6VSawZjS7H9miObuijkr2to0cnHREzImYWoKTXyUEjNuMZCnykxtNju0sOFGcoqgHhrh6fgsgDPyNECnT2VVh13wi2sZOop9wjDcwCRJ2TO+f0f55bJ+JkzG5oEYBA8zO3JjPqyGibiuYXuLZcnQJxSnDvwxlQcRG21DaIBqAzV0gESJiz/ZjFk7xWDclno7JJeAuMTSncxVDGA61HPGIR3bDWXsJXlUFZHv4dprpsQ0tCUaH+7NfaouTtpxUfzZif8+nqVW2XKLejDYYRKSrXqnPe6g6GL16XPSBdQec+csXoDMAn0WJ/MHzsk+UeIvp4+Ge4PHz/ETbQ5UhQQb+ASiubzgPjU6d7lL7SIBA02e3xAyD8tNFg27Zms6Y1VX/kCPFvnOUPS3FxADPi1xw+GNtUSd0SfRR5hb6H5Jwa7O+niahIffTUnf7J/yxjVsIHPq+ODEUjG+o/LT4RgYezMDLFn0UKJKimToFW65IqBPjsqllRRhrMEJkpY8eQIFFlp8keIKgliIaiiaW5oBOTKI8CkwzUhVnrJF7+eqz1vUnj3J6daLPVgKuVEd9qVGFMeV24b7l2lyOY/SB4Xj8saQoT1FZ2kkbmLYC/6s9sMbnWPnkFGDo/WL8eTu/FjmAag0/aIeTvjTjEry4JQfpep1MGVUHHk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(36860700004)(186009)(40470700004)(46966006)(86362001)(41300700001)(16526019)(1076003)(6916009)(316002)(6666004)(26005)(36756003)(7696005)(2616005)(478600001)(5660300002)(83380400001)(2906002)(426003)(8676002)(4326008)(70586007)(70206006)(336012)(8936002)(82740400003)(81166007)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:15:34.6471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c9d895-19d9-4b36-46fc-08dc3122f28a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

Replace it with related interface in gfxhub functions.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    | 12 ------------
 4 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f759a42def59..bb509b26112d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -776,10 +776,11 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
+			uint32_t node_id)
 {
-	if (adev->gfx.ras && adev->gfx.ras->query_utcl2_poison_status)
-		return adev->gfx.ras->query_utcl2_poison_status(adev);
+	if (adev->gfxhub.funcs->query_utcl2_poison_status)
+		return adev->gfxhub.funcs->query_utcl2_poison_status(adev, node_id);
 	else
 		return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b2990470d1c6..ae1e449e5479 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -404,7 +404,8 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
-bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
+			uint32_t node_id);
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 2af2e28952db..d91f83bd7267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -268,7 +268,6 @@ struct amdgpu_cu_info {
 struct amdgpu_gfx_ras {
 	struct amdgpu_ras_block_object  ras_block;
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
-	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev);
 	int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 0d5b4133fdf7..e3ed568eaacc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1909,18 +1909,7 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-static bool gfx_v9_4_2_query_uctl2_poison_status(struct amdgpu_device *adev)
-{
-	u32 status = 0;
-	struct amdgpu_vmhub *hub;
-
-	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	status = RREG32(hub->vm_l2_pro_fault_status);
-	/* reset page fault status */
-	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-}
 
 struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops = {
 		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
@@ -1934,5 +1923,4 @@ struct amdgpu_gfx_ras gfx_v9_4_2_ras = {
 		.hw_ops = &gfx_v9_4_2_ras_ops,
 	},
 	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
-	.query_utcl2_poison_status = gfx_v9_4_2_query_uctl2_poison_status,
 };
-- 
2.34.1

