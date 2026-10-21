Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B0606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oRZCaM6T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196E210E1A5;
	Wed, 21 Oct 2026 06:56:51 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1288210F973
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7C+wUASRErcrZ2JGLOML68xv4iUd4FKcinQLVUQsuTMwnOK8AYR+EA66OVjWG1T8ItEakGoJtEDYAWy48vSg6XgKugm6MaeVy6Xhb+Ez4MLGNdbcMYuI9ZuC0eOcKF+dQicgcStr83RqX63ea3R8BnKOZDN7Pqd+wxo87P5ruRbOIH51Gpx1rhiOLp92sQrXAV2n1p+sukFR6RGTMhOw09yFBQxKDRqBJgPkoHSUTSzZtbPBwwsXkAqasWke4ywkScMz21st4FZZafZgBWn7TRq7nP5xKxxzvV8v8UyDtRpKi95esd1rsgeyxs4wrfxxXv27yKV+UaSDF+xh6S4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCfdGkm1sYqrFcetc8SPxu7g1rNft2GeXG4nXi4xIX8=;
 b=SPbASBWXpuLJK63wjo1W9ieFQSaVzdoJyK8RONAEuu4jSAzFgenYLUNBazP97jrSLRbF6vxOI3ggj5lMCMgNmdNPGfmA1FvvBkHf0ilGKm0AOA6P4jkM40YAfGrcwKwEsRlemZlXhykxTL9tefeaulF1yMMY2Mdv/YqAFBvyIhK7v+0oL6qij8M2d/DRXULkxvn5M/YhPdvkTymFZ6uuH5j1oS60hlBPoQA4jtJcBLfoS9D9XfNIB7hq/e1HqN84ZhsJTY8Qb/ARjyTSfLi1RR806V8mVvNHd4/LVwqnYjGzezD+CSxJ0ezAF+LSZ2JspbIoLlZ1lgqJxNqZmqXRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCfdGkm1sYqrFcetc8SPxu7g1rNft2GeXG4nXi4xIX8=;
 b=oRZCaM6Te+k2fN8JGIQwkm/kRS2j2j6B/wg10ufVYVrV0CffA+W63C90nU9pt4lNwEd7Zj40Nx4RaRFV9cHsEsr/s5CaElTax8IG7UIWu2zSJDR58yEmldT9FuwRW5PHm06ev6s5kpke7FKSh4KLoS0l/Y8XTfT/05pqSBV9WcE=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:56:38 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3b) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:56:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:56:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 01:56:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>,
 "James Zhu" <james.zhu@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2 6/7] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
Date: Wed, 21 Oct 2026 12:26:02 +0530
Message-ID: <20261021065603.1329111-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f9d993-4e10-4578-b2fd-08df2f40740a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|261009223027099003|10067099003|22082099003|56012099006|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: PnF2ZFp2dL75r4A3PQ32wiWGRZ1VjdRiFUTnqb6oolqwaWprODghqOD+H+QdmmNVNbsHle7JcizL8e3qKlIWgQq7xrphPCmwwdEsdOo9nz2/DKt3Z6ecFFzHCbhen424V/Xu6JSGsFjT2+4SsA0Fi7jg2LsH+UQtoo9AZZPAT/1wDy8XT3REU5N1vSYoWaAEMvatam3HN7FhcUsstzkJYq52GpYwd+wznW4vISQb+fX1odfYV18TqPM5kfnQ8Svi/81qz5tr5eBUGHXGIo5VbKJ9rX2UnF8F8JZStR28xxSbeKRn/neWGuYQP0hvn750ac3lEIZaUEs1w5DfZXp6W98kLWytUv1d70zmVShv0/96X/gxJXJP6Kphy+eMU1qy1rfLmKKk8cpfHoHTMFyOrLVa+ZHMFGPQ7I7QK/L8LBrYm2OsCWHycX8x8FBDfA1hwGr3yFm1vkvio1HHOTx8JKEkW8+6XVtQmXQ6miEW0DAfXCRUUrB6cncVfVhiaD2NJNfPPjADzMdAzhXJQ/538azQbWE78O+Oo2cyamN2Js/AWux17H6a5T7gY5ng3otOG9BxaaJlpuTq5a4kQH96r87VAC7F8cfrCO8KyaLb4vp5IIBIj6NOPs9f9wCQXj/S3q3dJENtwNqNqIV/XHBbGKuh2NSSdZAdyn7CbPGHgbVBh3wFxykqKKTZG107AIEB81SG8qBc6KqQ97EVvByRaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(261009223027099003)(10067099003)(22082099003)(56012099006)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: guf8rHZ5Qr4ZKhmKZy6pt+dpFFCdBW9bI8tW1AWWYOKePHmneY2Nd7G2SBxtthd8dqbPAXyE1vaqEa3Ul1lZHOq+v3k/VgX8p9XUiFXbAwnRmvDNbT8sW6k8CNg9avCNlqdYkazNme4HLHWjcaTstE55ghwSsjP9Vuy8lF5Vd+PX//w4YaKeLlzd3P2LSKWkCjyQy9NQ6uP0kewMU1jCSWA4iGP8ps5ALe7VguC8rk8UzYAAwuXBXlSXee3u4+6XIF6U1kbECQ2rXfRQeev+8RNgRu6cq8xQ34bZ7cEcvO2Z8/ShXwT1IbPD5SSrmwozHpkXgBZrRz7Mt+cjyscxSCjmUznke4/Wp7JxOj/+Yw1o6GsjER/YHjKJM24hZ0gE4UdyuSYBQUYY51Ch0hiSK07B26midqUR5f6J6sKjaXaReSd0UHqR6E4JJYKzmQ43
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:56:37.9910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f9d993-4e10-4578-b2fd-08df2f40740a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

User queues get their first-level TBA and TMA from MES/KIQ when the
queue is created. Kernel-managed VMIDs do not use this path, so program
their trap registers from the gfxhub setup path.

Get the reserved first-level TBA and TMA virtual addresses and program
them for kernel-managed VMIDs. User-queue VMIDs continue to receive
their trap state through the existing MES/KIQ programming path.

The trap registers use the SRBM selector, so keep the programming under
srbm_mutex and restore the VMID selector after the registers are
updated.

Trap enablement differs across GPU generations. On GFX9, enable traps
for user-queue VMIDs through the debug trap configuration and program
kernel-managed VMIDs through the gfxhub path. On GFX9.4.3, enable the
per-VMID trap control on each XCC. On generations where trap enable is
encoded in SQ_SHADER_TBA_HI, program TRAP_EN together with the TBA
address.

Mask the TBA and TMA address fields before writing the registers. Keep
TRAP_EN disabled on the affected GFX11 ASICs to preserve the existing
trap workaround.

On multi-XCC hardware, program the requested XCCs and restore the VMID
selector on each XCC afterwards.

Keep the first-level trap VA layout inside amdgpu_trap. The gfxhub code
only needs the final TBA and TMA addresses.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Change-Id: Ib123b53f00c7c82f5c736183273e97ef21474508
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  5 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 28 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 75 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 50 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 50 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 61 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 47 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 59 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 50 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 50 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 55 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 55 +++++++++++++++
 13 files changed, 576 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 89968b5b7ecb..6e7dfceeee10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -63,7 +63,14 @@ static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
 	return addr;
 }
 
-static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
+void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
+			     u64 *tba_addr, u64 *tma_addr)
+{
+	*tba_addr = amdgpu_trap_tba_vaddr(adev);
+	*tma_addr = *tba_addr + AMDGPU_TRAP_TMA_OFFSET;
+}
+
+bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index c78c60e3d18d..523f65cb3d3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -76,6 +76,11 @@ struct amdgpu_trap_usr_addr {
 int amdgpu_trap_init(struct amdgpu_device *adev);
 void amdgpu_trap_fini(struct amdgpu_device *adev);
 
+bool amdgpu_trap_is_supported(struct amdgpu_device *adev);
+
+void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
+			     u64 *tba_addr, u64 *tma_addr);
+
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 75d1bbdb421f..a84991104b43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -29,6 +29,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_trap.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "amdgpu_atomfirmware.h"
@@ -2568,14 +2569,25 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t vmid_mask)
+					    uint32_t vmid_mask)
 {
 	uint32_t data;
+	uint32_t trap_config_vmid_mask;
+
+	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG));
+
+	trap_config_vmid_mask =
+		REG_GET_FIELD(data, SPI_GDBG_TRAP_CONFIG, VMID_SEL);
+
+	/* Add the requested VMIDs to the existing trap configuration. */
+	trap_config_vmid_mask |= vmid_mask;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+			     VMID_SEL, trap_config_vmid_mask);
 
-	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
-			VMID_SEL, vmid_mask);
 	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
-			TRAP_EN, 1);
+			     TRAP_EN, 1);
+
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
 
@@ -4044,6 +4056,14 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (amdgpu_trap_is_supported(adev)) {
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
+			gfx_v9_4_2_debug_trap_config_init(adev);
+		else
+			gfx_v9_0_debug_trap_config_init(adev,
+						   adev->vm_manager.vmid_uq_mask_gfxhub);
+	}
+
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
 	    !amdgpu_sriov_vf(adev))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d66c7901783e..98a54e53232f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ip.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_trap.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_common.h"
@@ -1167,25 +1168,66 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * Scratch:     0x60000001'00000000 - 0x60000002'00000000 (4GB)
 	 * GPUVM:       0x60010000'00000000 - 0x60020000'00000000 (1TB)
 	 */
-	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
+	sh_mem_bases = DEFAULT_SH_MEM_BASES |
+		       (DEFAULT_SH_MEM_BASES << 16);
 
 	sh_mem_config = SH_MEM_ADDRESS_MODE_64 |
 			SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
+
+	/*
+	 * Enable traps for kernel-managed VMIDs.
+	 */
+	if (amdgpu_trap_is_supported(adev)) {
+		for (i = 1; i < AMDGPU_NUM_VMID; i++) {
+			if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(i))
+				continue;
+
+			soc15_grbm_select(adev, 0, 0, 0, i,
+					  GET_INST(GC, xcc_id));
+
+			data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+					    regSPI_GDBG_PER_VMID_CNTL);
+
+			data = REG_SET_FIELD(data,
+					     SPI_GDBG_PER_VMID_CNTL,
+					     TRAP_EN, 1);
+
+			WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
+					 regSPI_GDBG_PER_VMID_CNTL,
+					 data);
+		}
+	}
+
 	for_each_uq_gfx_vmid(i, adev) {
-		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
+		soc15_grbm_select(adev, 0, 0, 0, i,
+				  GET_INST(GC, xcc_id));
+
 		/* CP and shaders */
-		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
-		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_BASES, sh_mem_bases);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
+				 regSH_MEM_CONFIG, sh_mem_config);
+
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
+				 regSH_MEM_BASES, sh_mem_bases);
 
-		/* Enable trap for each kfd vmid. */
-		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL);
-		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
-		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL, data);
+		/* Enable trap for each user queue VMID. */
+		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+				    regSPI_GDBG_PER_VMID_CNTL);
+
+		data = REG_SET_FIELD(data,
+				     SPI_GDBG_PER_VMID_CNTL,
+				     TRAP_EN, 1);
+
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
+				 regSPI_GDBG_PER_VMID_CNTL,
+				 data);
 	}
-	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+
+	soc15_grbm_select(adev, 0, 0, 0, 0,
+			  GET_INST(GC, xcc_id));
+
 	mutex_unlock(&adev->srbm_mutex);
 
 	/*
@@ -1193,10 +1235,17 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
 	for_each_uq_gfx_vmid(i, adev) {
-		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
-		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_OA_VMID0, i, 0);
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
+				    regGDS_VMID0_BASE, 2 * i, 0);
+
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
+				    regGDS_VMID0_SIZE, 2 * i, 0);
+
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
+				    regGDS_GWS_VMID0, i, 0);
+
+		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
+				    regGDS_OA_VMID0, i, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 8be912d50601..5b9efd09493a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v11_5_0.h"
 
 #include "gc/gc_11_5_0_offset.h"
@@ -295,6 +296,52 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+		/* Program only kernel-managed VMIDs. */
+		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+			continue;
+
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -342,6 +389,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 4144c1c2ee13..f0ca90f8b50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v12_0.h"
 
 #include "gc/gc_12_0_0_offset.h"
@@ -300,6 +301,52 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+		/* Program only kernel-managed VMIDs. */
+		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+			continue;
+
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -347,6 +394,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index b13967a1c8fb..a35ca7fcb198 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v12_1.h"
 
@@ -392,6 +393,63 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 	}
 }
 
+static void
+gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev,
+					 uint32_t xcc_mask)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+	int xcc;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for_each_inst(xcc, xcc_mask) {
+		for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+			/* Program only kernel-managed VMIDs. */
+			if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+				continue;
+
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
+						    vmid, xcc);
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_HI,
+				     (upper_32_bits(tba_addr >> 8) &
+				      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_HI,
+				     upper_32_bits(tma_addr >> 8) &
+				     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+		}
+	}
+
+	/* Reset the VMID selector on every XCC instance. */
+	for_each_inst(xcc, xcc_mask)
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					       uint32_t xcc_mask)
 {
@@ -457,6 +515,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 		hub->vm_cntx_cntl = tmp;
 	}
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v12_1_program_kernel_trap_tba_tma(adev, xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index c35856180c3c..6cb7bae80f3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v1_0.h"
 #include "gfxhub_v1_1.h"
 
@@ -252,6 +253,49 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v1_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+		/* Skip user-queue VMIDs. Program only kernel-managed VMIDs. */
+		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+			continue;
+
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) &
+			     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -310,6 +354,9 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v1_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e89813590539..b06edea271af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v1_2.h"
 #include "gfxhub_v1_1.h"
@@ -328,6 +329,61 @@ gfxhub_v1_2_per_process_xnack_support(struct amdgpu_device *adev)
 	return !!adev->aid_mask;
 }
 
+static void
+gfxhub_v1_2_program_kernel_trap_tba_tma(struct amdgpu_device *adev,
+					uint32_t xcc_mask)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+	int xcc;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for_each_inst(xcc, xcc_mask) {
+		for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+			/* Program only kernel-managed VMIDs. */
+			if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+				continue;
+
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
+						    vmid, xcc);
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_HI,
+				     upper_32_bits(tba_addr >> 8) &
+				     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_HI,
+				     upper_32_bits(tma_addr >> 8) &
+				     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+		}
+	}
+
+	for_each_inst(xcc, xcc_mask)
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					      uint32_t xcc_mask)
 {
@@ -398,6 +454,9 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					    upper_32_bits(adev->vm_manager.max_pfn - 1));
 		}
 	}
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v1_2_program_kernel_trap_tba_tma(adev, xcc_mask);
 }
 
 static void gfxhub_v1_2_xcc_program_invalidation(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 04778f9f95bd..b7364d1b52c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_0.h"
 
 #include "gc/gc_10_1_0_offset.h"
@@ -285,6 +286,52 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+		/* Program only kernel-managed VMIDs. */
+		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+			continue;
+
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -332,6 +379,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 6c77c17878f8..c00c7b23e6e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_1.h"
 
 #include "gc/gc_10_3_0_offset.h"
@@ -297,6 +298,52 @@ static void gfxhub_v2_1_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v2_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+		/* Program only kernel-managed VMIDs. */
+		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+			continue;
+
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -344,6 +391,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v2_1_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index e2b9fd0c8af0..fd7a0f1f369b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v3_0.h"
 
 #include "gc/gc_11_0_0_offset.h"
@@ -292,6 +293,57 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	u32 tba_hi;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	tba_hi = upper_32_bits(tba_addr >> 8) &
+		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
+
+	if (!amdgpu_trap_has_dbg_wa(adev))
+		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+		/* Program only kernel-managed VMIDs. */
+		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+			continue;
+
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     tba_hi);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -339,6 +391,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index fa8b966b7ea1..6c4b110f8048 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "gfxhub_v3_0_3.h"
+#include "amdgpu_trap.h"
 
 #include "gc/gc_11_0_3_offset.h"
 #include "gc/gc_11_0_3_sh_mask.h"
@@ -297,6 +298,57 @@ static void gfxhub_v3_0_3_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_3_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	u32 tba_hi;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs ||
+	    !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	tba_hi = upper_32_bits(tba_addr >> 8) &
+		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
+
+	if (!amdgpu_trap_has_dbg_wa(adev))
+		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
+		/* Program only kernel-managed VMIDs. */
+		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
+			continue;
+
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     tba_hi);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -344,6 +396,9 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v3_0_3_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)
-- 
2.34.1

