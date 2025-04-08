Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F920C369A5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 16:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2902710E6E9;
	Tue,  8 Apr 2025 16:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ANxqGWdT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FB110E6E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 16:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtZOgDso74155XRkkR7VG/tpwUc7TdEajiUm1/jVdDFy9hPc5zg9PGiaJ83xero7mgHrMsqfLQcV5Bb0Nz4rRu7nvd3gpkZzfjk9c1sVn6X9uFainrv2KO064fQU6YURuayOC/n1fZZdMrA8v4VeVzwRb3u2rw6yS3chgMpR+PBqYy9zSZVp9mdUSbI0TU1v69oUn44MtHDbldezCE+Y9T12PaQbR9gXsgg/rAnwkdw24S9Yq0ygqRrsETnKu2fvhsi5YpjaEpHJycA6jqHkmA0ePMhQ/aKs/NQD70+ER4RR2UyX8Gjd+ce9MXybRfmhusXyyHvca3t0X0CsPz1nbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQqH9vcSA7qCxZDiNjlBKX0bromMIoLDnaYc5Mq8XCA=;
 b=tzZjvt/mbe+J36LIe75FiDXLk48e4n1rq/07mI/NpFIdueVN1HIlKd8eDBJqzDa5NASXMSZxk0ZVatPQrtt8tlaAow9PbWLEJ/ZLZXw/kD4siVNwoeRylXWyooz15IR+i8JLwGPB/qDOD6SKdKCpdM0uU5uXrTfQeMWrs+H8NqFx25Pfqyym6Bag5p9yWJNCslC+OMpqTb8Vh+hSYytQY7Q6guBLD+WCqX8gDAj7wFXqC9kMj/X9V5Bi1tskMYw48cdeJlFw8wakQGmfUeaOdynPTIYsFWkLfbDIHuBKiXw1Bvx3U6zFNCwl+lYRJdsVJGfLMxjcbD+/4POtoVuGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQqH9vcSA7qCxZDiNjlBKX0bromMIoLDnaYc5Mq8XCA=;
 b=ANxqGWdTB//qMP+3UalDrRFXmr31ZMDY2IgmN2MveOBFePjdgY+GnyZFCz0NnW/XYXmbH++U8meyYSOmRQRaPbaq8W/rvEzLU4FAp+6752QJvbmr7lUyb6mwcnyxKrJKbBD5+fJXwnv35nUuR/VP3dZvakW2//FIz0zck1InNeY=
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 16:00:19 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::9f) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Tue,
 8 Apr 2025 16:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 16:00:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 11:00:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: adjust enforce_isolation handling
Date: Tue, 8 Apr 2025 12:00:00 -0400
Message-ID: <20250408160000.3149409-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408160000.3149409-1-alexander.deucher@amd.com>
References: <20250408160000.3149409-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1e2921-df8f-4c9c-c66d-08dd76b67611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hiLWqf8A4o8T81b2rrBprToM9JhpafuxIVLtWIdVO/uEnMNU93Gdt/3MJBrt?=
 =?us-ascii?Q?f5oBu6uCVMoHfL2vhCRk+7aiXKKpw9qESyZwn0mN6rdITWf8+J8ElW2ApJqd?=
 =?us-ascii?Q?T+p9CMZQHuiGl9x0E2f++Np/OFjK+eAo5+daEI3YDykG/AGZJ1MW1WQlO9nO?=
 =?us-ascii?Q?o7O0G4hp+Z2a0d46T/NEvFqYijW5VqD6GGC8ALADRR+m3kLrS/YRbICva/y6?=
 =?us-ascii?Q?6vy3JDM+E9zwZ0OLuNG8nKudT2KwPaE0GvvJ32yqH8oGWQK7IZc+w1A99+70?=
 =?us-ascii?Q?XFzYqthZfERbY/4AFEE88D4C8i3xrVr0lLJIxw+3er1G8dJduRRRdEZ/xS/2?=
 =?us-ascii?Q?cy5h/yGhGO1qpDE1oH/9y9smWmF/XhSZw7cp1IDgUuZIYCNJPLz9Nuf9oycB?=
 =?us-ascii?Q?1i3LH8useqsr3xi8xFkK/rpUi70m6hb7aW9JL9Tua5S49JVI69Ar2arDYFJG?=
 =?us-ascii?Q?ItCjuXMkfK/HvGbnB9l4gn2k0rqqh0kmXia+MTKB4P62m24elq8qY8XJZZNN?=
 =?us-ascii?Q?E0izw1LuddHJ4GHYneOC+O1hyXlqWkXrC+jky+JxA1iCLF5hSwZenCJUAYoP?=
 =?us-ascii?Q?gcx6xzlchzzKVFu4865oPNcODPyCoOhyVObC7Exc+63mNW1Q+MgMMUMqMpvo?=
 =?us-ascii?Q?j3grlH8+YPHj1Ha3oKan1zCIg1dDNvujI7O83T0XMPFd2jpqqU73wOcV5v0d?=
 =?us-ascii?Q?hbpb3sm+aeapc4F6oK7/bVYhoGmtl9WKBVI9LcIzMgIr7knrd9jHF7RalM+b?=
 =?us-ascii?Q?b6C4Cfc5Cl0dN5LzH5a6BvawnTYTif7DWdjUxqqSciIh4nBReR2T1Q/3vgyy?=
 =?us-ascii?Q?QhjG5E9OfxbdB4oJ3AlD9gN+sg0rsFs5lXcUjbYMA3ZKU/3Pge+kGKosn4bn?=
 =?us-ascii?Q?TxEH+Y2LYNVi4FadxnJt05x3OlOET4boKR/cTWXQ5keSXtvUuP/395HHMldz?=
 =?us-ascii?Q?OLEyj0MbxoXjvux07f7gsHOpgPvnoAi2pGhkPrxi9+SwrkCk98I3bJCtxVgl?=
 =?us-ascii?Q?pcEIbFY+UFvhTXbDzkH1HisVaJ66fnRIq4WEyHC257/Qkj4GtMjgqbFgaf+Y?=
 =?us-ascii?Q?6crDeN/Sj3jH1ZfjPLJOecXbk23D3IFeHIlb01XIpd+cmrXWsI4UhIha5vMs?=
 =?us-ascii?Q?g2PLFmnhXHFK+di7w/M62I3wg/4pqWTw03Bnkb9bvuFDTKGZL8DMGzrtWzSV?=
 =?us-ascii?Q?5lKtEKRKt7W0QyVYemolXjtagFMjppp6VYXkn/wehib3vX8GF8BiyeHHTcaR?=
 =?us-ascii?Q?CKsX7cHr2KJM36h27s2bQnjNiX/sYTlleUY1Sb0qimM3J7ckzXaA1EIdDG1C?=
 =?us-ascii?Q?4Np8L6Da6xfo6AaOeOU2+t7p03zD+Z6Ebfh9IPc0N64+kxcVbfbUfDSZmgqD?=
 =?us-ascii?Q?0VwBwGe6ywAI50Y+VRZv/w+LGX1ShOdghyBodXSA0X0wNoeuAgrPRSIeARLd?=
 =?us-ascii?Q?1m07fjs8DLStle3b81SGg1lTiBpL4TI5LnljG8I65D+eVBV79ixsUgSoMTGi?=
 =?us-ascii?Q?3G5iXJk6nVkj7/0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:00:19.2074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1e2921-df8f-4c9c-c66d-08dd76b67611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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

Switch from a bool to an enum and allow more options
for enforce isolation.  There are now 3 modes of operation:
- Disabled (0)
- Enabled (serialization and cleaner shader) (1)
- Enabled in legacy mode (no serialization or cleaner shader) (2)
This provides better flexibility for more use cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 16 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 39 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 11 +++---
 12 files changed, 93 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 804d377037095..468c6ce09e3ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -230,7 +230,7 @@ extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
-extern bool enforce_isolation;
+extern int amdgpu_enforce_isolation;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
@@ -873,6 +873,13 @@ struct amdgpu_init_level {
 struct amdgpu_reset_domain;
 struct amdgpu_fru_info;
 
+enum amdgpu_enforce_isolation_mode {
+	AMDGPU_ENFORCE_ISOLATION_DISABLE = 0,
+	AMDGPU_ENFORCE_ISOLATION_ENABLE = 1,
+	AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY = 2,
+};
+
+
 /*
  * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
  */
@@ -1224,7 +1231,7 @@ struct amdgpu_device {
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
-	bool				enforce_isolation[MAX_XCP];
+	enum amdgpu_enforce_isolation_mode	enforce_isolation[MAX_XCP];
 	struct amdgpu_isolation {
 		void			*owner;
 		struct dma_fence	*spearhead;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4a5cd7a111fc4..34a688fc5bf35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -296,7 +296,21 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 				       num_ibs[i], &p->jobs[i]);
 		if (ret)
 			goto free_all_kdata;
-		p->jobs[i]->enforce_isolation = p->adev->enforce_isolation[fpriv->xcp_id];
+		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
+		case AMDGPU_ENFORCE_ISOLATION_DISABLE:
+		default:
+			p->jobs[i]->enforce_isolation = false;
+			p->jobs[i]->run_cleaner_shader = false;
+			break;
+		case AMDGPU_ENFORCE_ISOLATION_ENABLE:
+			p->jobs[i]->enforce_isolation = true;
+			p->jobs[i]->run_cleaner_shader = true;
+			break;
+		case AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY:
+			p->jobs[i]->enforce_isolation = true;
+			p->jobs[i]->run_cleaner_shader = false;
+			break;
+		}
 	}
 	p->gang_leader = p->jobs[p->gang_leader_idx];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8b43f350447a9..700304bbe3982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2115,8 +2115,26 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	adev->firmware.load_type = amdgpu_ucode_get_load_type(adev, amdgpu_fw_load_type);
 
-	for (i = 0; i < MAX_XCP; i++)
-		adev->enforce_isolation[i] = !!enforce_isolation;
+	for (i = 0; i < MAX_XCP; i++) {
+		switch (amdgpu_enforce_isolation) {
+		case -1:
+		case 0:
+		default:
+			/* disable */
+			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
+			break;
+		case 1:
+			/* enable */
+			adev->enforce_isolation[i] =
+				AMDGPU_ENFORCE_ISOLATION_ENABLE;
+			break;
+		case 2:
+			/* enable legacy mode */
+			adev->enforce_isolation[i] =
+				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+			break;
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d7b27b7a0d519..5132003d85a29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -179,7 +179,7 @@ uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
-bool enforce_isolation;
+int amdgpu_enforce_isolation = -1;
 int amdgpu_modeset = -1;
 
 /* Specifies the default granularity for SVM, used in buffer
@@ -1038,11 +1038,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 
 
 /**
- * DOC: enforce_isolation (bool)
- * enforce process isolation between graphics and compute via using the same reserved vmid.
+ * DOC: enforce_isolation (int)
+ * enforce process isolation between graphics and compute.
+ * (-1 = auto, 0 = disable, 1 = enable, 2 = enable legacy mode)
  */
-module_param(enforce_isolation, bool, 0444);
-MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
+module_param_named(enforce_isolation, amdgpu_enforce_isolation, int, 0444);
+MODULE_PARM_DESC(enforce_isolation,
+"enforce process isolation between graphics and compute. (-1 = auto, 0 = disable, 1 = enable, 2 = enable legacy mode)");
 
 /**
  * DOC: modeset (int)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ff53401aae5a4..9b4272fbc470c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1460,6 +1460,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		goto err;
 
 	job->enforce_isolation = true;
+	/* always run the cleaner shader */
+	job->run_cleaner_shader = true;
 
 	ib = &job->ibs[0];
 	for (i = 0; i <= ring->funcs->align_mask; ++i)
@@ -1591,7 +1593,7 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
  * Provides the sysfs read interface to get the current settings of the 'enforce_isolation'
  * feature for each GPU partition. Reading from the 'enforce_isolation'
  * sysfs file returns the isolation settings for all partitions, where '0'
- * indicates disabled and '1' indicates enabled.
+ * indicates disabled, '1' indicates enabled, and '2' indicates enabled in legacy mode.
  *
  * Return: The number of bytes read from the sysfs file.
  */
@@ -1626,9 +1628,10 @@ static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
  * @count: The size of the input data
  *
  * This function allows control over the 'enforce_isolation' feature, which
- * serializes access to the graphics engine. Writing '1' or '0' to the
- * 'enforce_isolation' sysfs file enables or disables process isolation for
- * each partition. The input should specify the setting for all partitions.
+ * serializes access to the graphics engine. Writing '1', '2', or '0' to the
+ * 'enforce_isolation' sysfs file enables (full or legacy) or disables process
+ * isolation for each partition. The input should specify the setting for all
+ * partitions.
  *
  * Return: The number of bytes written to the sysfs file.
  */
@@ -1665,13 +1668,29 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 		return -EINVAL;
 
 	for (i = 0; i < num_partitions; i++) {
-		if (partition_values[i] != 0 && partition_values[i] != 1)
+		if (partition_values[i] != 0 &&
+		    partition_values[i] != 1 &&
+		    partition_values[i] != 2)
 			return -EINVAL;
 	}
 
 	mutex_lock(&adev->enforce_isolation_mutex);
-	for (i = 0; i < num_partitions; i++)
-		adev->enforce_isolation[i] = partition_values[i];
+	for (i = 0; i < num_partitions; i++) {
+		switch (partition_values[i]) {
+		case 0:
+		default:
+			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
+			break;
+		case 1:
+			adev->enforce_isolation[i] =
+				AMDGPU_ENFORCE_ISOLATION_ENABLE;
+			break;
+		case 2:
+			adev->enforce_isolation[i] =
+				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+			break;
+		}
+	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
 
 	amdgpu_mes_update_enforce_isolation(adev);
@@ -2026,7 +2045,7 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
 	bool wait = false;
 
 	mutex_lock(&adev->enforce_isolation_mutex);
-	if (adev->enforce_isolation[idx]) {
+	if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
 		/* set the initial values if nothing is set */
 		if (!adev->gfx.enforce_isolation_jiffies[idx]) {
 			adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
@@ -2093,7 +2112,7 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 	amdgpu_gfx_enforce_isolation_wait_for_kfd(adev, idx);
 
 	mutex_lock(&adev->enforce_isolation_mutex);
-	if (adev->enforce_isolation[idx]) {
+	if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
 		if (adev->kfd.init_complete)
 			sched_work = true;
 	}
@@ -2130,7 +2149,7 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 		return;
 
 	mutex_lock(&adev->enforce_isolation_mutex);
-	if (adev->enforce_isolation[idx]) {
+	if (adev->enforce_isolation[idx] == AMDGPU_ENFORCE_ISOLATION_ENABLE) {
 		if (adev->kfd.init_complete)
 			sched_work = true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 4c4e087230ac5..359c19de9a5b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -588,7 +588,7 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 	}
 	/* alloc a default reserved vmid to enforce isolation */
 	for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
-		if (adev->enforce_isolation[i])
+		if (adev->enforce_isolation[i] != AMDGPU_ENFORCE_ISOLATION_DISABLE)
 			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index ce6b9ba967fff..f2c049129661f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -78,6 +78,7 @@ struct amdgpu_job {
 
 	/* enforce isolation */
 	bool			enforce_isolation;
+	bool			run_cleaner_shader;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 36f2e87161264..38ea64d87a0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -768,7 +768,7 @@ int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
 	if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
 		mutex_lock(&adev->enforce_isolation_mutex);
 		for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
-			if (adev->enforce_isolation[i])
+			if (adev->enforce_isolation[i] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
 				r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
 			else
 				r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b5ddfcbbc9fc9..dadf6715b98be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -676,7 +676,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
-	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
+	cleaner_shader_needed = job->run_cleaner_shader &&
+		adev->gfx.enable_cleaner_shader &&
 		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 344d32268c3cd..f7aa45775eadb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -724,7 +724,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 					mes->event_log_gpu_addr;
 	}
 
-	if (adev->enforce_isolation[0])
+	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
 		mes_set_hw_res_pkt.limit_single_process = 1;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index be43e19b7b7fa..b0e042a4cea19 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -762,7 +762,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 				pipe * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
 	}
 
-	if (adev->enforce_isolation[0])
+	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
 		mes_set_hw_res_pkt.limit_single_process = 1;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 2893fd5e5d003..fa28c57692b86 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -43,7 +43,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
 	memset(buffer, 0, sizeof(struct pm4_mes_map_process));
 	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
 					sizeof(struct pm4_mes_map_process));
-	if (adev->enforce_isolation[kfd->node_id])
+	if (adev->enforce_isolation[kfd->node_id] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
 		packet->bitfields2.exec_cleaner_shader = 1;
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
 	packet->bitfields2.process_quantum = 10;
@@ -102,7 +102,8 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
 	memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
 	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
 			sizeof(struct pm4_mes_map_process_aldebaran));
-	if (adev->enforce_isolation[knode->node_id])
+	if (adev->enforce_isolation[knode->node_id] ==
+	    AMDGPU_ENFORCE_ISOLATION_ENABLE)
 		packet->bitfields2.exec_cleaner_shader = 1;
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
 	packet->bitfields2.process_quantum = 10;
@@ -165,9 +166,9 @@ static int pm_runlist_v9(struct packet_manager *pm, uint32_t *buffer,
 	 * hws_max_conc_proc has been done in
 	 * kgd2kfd_device_init().
 	 */
-	concurrent_proc_cnt = adev->enforce_isolation[kfd->node_id] ?
-			1 : min(pm->dqm->processes_count,
-			kfd->max_proc_per_quantum);
+	concurrent_proc_cnt = (adev->enforce_isolation[kfd->node_id] ==
+			       AMDGPU_ENFORCE_ISOLATION_ENABLE) ?
+		1 : min(pm->dqm->processes_count, kfd->max_proc_per_quantum);
 
 	packet = (struct pm4_mes_runlist *)buffer;
 
-- 
2.49.0

