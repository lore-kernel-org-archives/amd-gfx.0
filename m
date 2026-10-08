Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A37FCA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9136A10E42F;
	Thu,  8 Oct 2026 07:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oe0omDfL";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4755610E42F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 07:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3pAtBMZ8s0XbdGQjgq6Q7y5ybeKbeaKu8draqAc9j7ciibkl5eRFzSblXZoSF/ftOJEUDtZepjk4rxdeFeHwtHG2XVZWMfWh7TEBiYUpsDVqDGiDecstrNC8vmMidHEof0MxEiTITN9z8tbaetb68uTjZCAeGqxoyQwGjuH0iELyUdNU+MI4Ok66mQGYsyFCEeqTaFeSsFDH7l6PERQxUZma153zbEEBJ7YfJt5UbcAu+C0mf9VtfcZJh8xDHeIDCD+HRootOl3UhcdGzmmKfNWPn62wmgeT7N38E49Rcm9bTbkvK0u6xBnAkxPLtfBQTlA41R35mWDc4PgkK3deQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FHqzrkFrdD70O7TXA0vTkTAQOWz8WpvXeX21wAPMUY=;
 b=Dg+lXY0B7kz37Yy6tXpfA2YJaBEQ0tAmR4Js6ZAewi1CCkRP3XqcNvLF6iet9BABO5FUHYrCIY9+v5qPp0cTx06YTW/cX7fX23Rfv2AivWiWTwxILScEY7I3kg6geN2wEHvSPR88u/1TThLDC5e/We2YBxNAVO15ZQmZtjY71s8OdsnFWBJwwKQwFJ0MFo1CR2vb42lSGBI2RJZY4r9fpV2PS9AF60RLVHrMYzOVwWy3JnyOUDjufUkCC8O58BGGW9ZtzQ9ilt47jYdQaG6BmxJsQ8KHEH+U2/q+V8Q+QEui27KsCygUj/HnLyhBp0YeCgrQdJ0cO2FITknUYkuW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FHqzrkFrdD70O7TXA0vTkTAQOWz8WpvXeX21wAPMUY=;
 b=Oe0omDfLhJscQKybnLf5It5VEBS/8/HQi+6myqX20n4dsoqokSGgTKKemeCTBeiF71cLW7pU0DjaDRKR23JVikT8t6y6kJJZLnAijCMS37rktkADKvcHFGwJ49m/m1dxoyq0GmJgv4s4TdrogIaTM6fdiPaj9DafIpHQf/jHBd0=
Received: from DS1PR04CA0024.namprd04.prod.outlook.com (2603:10b6:8:243::18)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 8 Oct
 2026 07:06:30 +0000
Received: from CY4PEPF000392D6.namprd03.prod.outlook.com
 (2603:10b6:8:243:cafe::48) by DS1PR04CA0024.outlook.office365.com
 (2603:10b6:8:243::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 07:06:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D6.mail.protection.outlook.com (10.167.247.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 07:06:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:06:26 -0500
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
Subject: [PATCH 6/7] drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
Date: Thu, 8 Oct 2026 12:35:41 +0530
Message-ID: <20261008070542.1111149-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D6:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: d8678318-22c3-4412-c26d-08df250aadcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|10067099003|11063799006|56012099006|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: fnbXdyFNSKmstND0Lktb5dbEAnBUe9RoUxAvbCBNmmD5kEeRd6ZMNiBZmw/YoA89LxQiVAfT+rNYtNo+qhRvrkxLz5F48DV7pMGzDz/3NcU+cqdNgBy3NL38F8xfSqXfVpPZbc6cKn3uU3j+q2+m7aLz4X13aMBgse+eLZ90SI/6X2uYSmN9N3RGGGKp4rUd/03lUUb0YBuDRWhtrPfsoVDwPY38w/ndZ4FWUELjzvhnt6xMf97A6632/hz7snssd3ToiL8oRQmFadPhcCmOc/Rjrhz0WS5KSHnTT2tPDrZOJJf2GgLobgggn3LDs/1/faBLMHXGCEbyMSsptrZzFBZCFv04Qu07NWTXJ//21IRIh6BDclPhm09f0bAbJwGk5jg+FTdhyAcfP2tL85+pB8zjrpp8JTr1lWCLV3ZPdHfkV5sSVCR/q2p5q/0PkZhtaq4iFKgm1z7aBWcu1GaZ233MyeT/cUTRYW0K2L5AIUv5rZGY7ieNPjjV/6yS9O0vcn1Ox/znrsjRpWcMvIqLbhkFTQ4jec26+OlqlBuplQHBi12wncnNdVjs5p7dqonSIZQGn70pOfhRvAARvV7Odh0EgmAg5OIJ/Hn9gd/5I00CpzN2jJ4mK4StvlvaYXXPtJnmBc6kwV5Aa6jgzC8hZxO5n22qgvD18cW12/Cuhhkk7mu9v35hsr9J1vmB1JqSpVaylzN2boTA/uvB+gvwKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +WXR0Fe+41JDybo7DE/qtt9pQLD3kKcT+kxgXTTkNpbl2dqsD/O1D57erJFkaUSonnC1AVDw1v0OBZ0DmbIDsC0ssk5wQD9fYk4BS6n6XRd4oa9orxnjD4Jh7RWrPBSHR5eIMWEcuNNX7YwRckugq8WMNN3MLD9FMZ2iDlqAXYXvu97KNcA9i0vTTPkVn3Wy7e2niXwBrhqLUBYDm25JbF/mIX8FrIE1pzvfGVBrk1ijDA8bMqylWNtJDQ32yHKE4Ak3v1HWheI795sLapWCUlDPu2pGWc8hxj5u9BQcaO2mRh/jXglz+XktbxAz4/o39ABG61T5pQpxzDPgnGCpnuJS7psftZU/8msBWfXi7wK6GmLy29xu980oUMbMV6UrcgPwRfYb3tlqv+w8Xzpqbqt2MkxH3pN+1UDD3lrDlV/fOD4HeN9ws6oJyk+kHtFw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 07:06:30.4800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8678318-22c3-4412-c26d-08df250aadcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D6.namprd03.prod.outlook.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

User queues get their first-level TBA and TMA from MES/KIQ when the
queue is created. Kernel-managed VMIDs do not use this path, so program
their trap registers from the gfxhub setup path.

Get the reserved first-level TBA and TMA virtual addresses and program
them for each kernel-managed VMID.

The trap registers use the SRBM selector, so keep the programming under
srbm_mutex and restore the VMID selector after the registers are
updated.

Trap enablement differs across GPU generations. On GFX9, enable traps
for kernel-managed VMIDs through the debug trap configuration. On
GFX9.4.3, enable the per-VMID trap control on each XCC. On generations
where trap enable is encoded in SQ_SHADER_TBA_HI, program TRAP_EN
together with the TBA address.

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  9 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  5 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 29 ++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 16 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 38 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 38 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 53 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 41 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 53 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 38 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 42 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 46 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 46 ++++++++++++++++++
 13 files changed, 446 insertions(+), 8 deletions(-)

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
index 1678015ce5a9..07e249500254 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -29,6 +29,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_trap.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "amdgpu_atomfirmware.h"
@@ -2568,21 +2569,26 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid,
-				uint32_t last_vmid)
+					     u32 first_vmid,
+					     uint32_t last_vmid)
 {
 	uint32_t data;
-	uint32_t trap_config_vmid_mask = 0;
+	u32 trap_config_vmid_mask;
 	int i;
 
-	/* Calculate trap config vmid mask */
+	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG));
+	trap_config_vmid_mask =
+		REG_GET_FIELD(data, SPI_GDBG_TRAP_CONFIG, VMID_SEL);
+
+	/* Add the requested VMIDs to the existing trap configuration. */
 	for (i = first_vmid; i < last_vmid; i++)
 		trap_config_vmid_mask |= (1 << i);
 
-	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
-			VMID_SEL, trap_config_vmid_mask);
 	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
-			TRAP_EN, 1);
+			     VMID_SEL, trap_config_vmid_mask);
+	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+			     TRAP_EN, 1);
+
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
 
@@ -4051,6 +4057,15 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (amdgpu_trap_is_supported(adev)) {
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
+			gfx_v9_4_2_debug_trap_config_init(adev, 1,
+							  adev->vm_manager.first_kfd_vmid);
+		else
+			gfx_v9_0_debug_trap_config_init(adev, 1,
+							adev->vm_manager.first_kfd_vmid);
+	}
+
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
 	    !amdgpu_sriov_vf(adev))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 01ed1701c781..69a1e64620cd 100644
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
@@ -1173,6 +1174,21 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
+
+	if (amdgpu_trap_is_supported(adev)) {
+		for (i = 1; i < adev->vm_manager.first_kfd_vmid; i++) {
+			soc15_grbm_select(adev, 0, 0, 0, i,
+					  GET_INST(GC, xcc_id));
+
+			data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+					    regSPI_GDBG_PER_VMID_CNTL);
+			data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
+					     TRAP_EN, 1);
+			WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
+					 regSPI_GDBG_PER_VMID_CNTL, data);
+		}
+	}
+
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 8be912d50601..e635d83488af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v11_5_0.h"
 
 #include "gc/gc_11_5_0_offset.h"
@@ -295,6 +296,40 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -342,6 +377,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 4144c1c2ee13..dc7fde6962ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v12_0.h"
 
 #include "gc/gc_12_0_0_offset.h"
@@ -300,6 +301,40 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -347,6 +382,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index b13967a1c8fb..78088e72606c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v12_1.h"
 
@@ -392,6 +393,55 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
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
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for_each_inst(xcc, xcc_mask) {
+		for (vmid = 1;
+		     vmid < adev->vm_manager.first_kfd_vmid;
+		     vmid++) {
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
+						    vmid, xcc);
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_HI,
+				     (upper_32_bits(tba_addr >> 8) &
+				      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
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
@@ -457,6 +507,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 		hub->vm_cntx_cntl = tmp;
 	}
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v12_1_program_kernel_trap_tba_tma(adev, xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index c35856180c3c..dbd993ae1d0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v1_0.h"
 #include "gfxhub_v1_1.h"
 
@@ -252,6 +253,43 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v1_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) &
+			     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
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
@@ -310,6 +348,9 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v1_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e89813590539..76c2b6b74903 100644
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
@@ -328,6 +329,55 @@ gfxhub_v1_2_per_process_xnack_support(struct amdgpu_device *adev)
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
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
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
+		for (vmid = 1;
+		     vmid < adev->vm_manager.first_kfd_vmid;
+		     vmid++) {
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
+						    vmid, xcc);
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_HI,
+				     upper_32_bits(tba_addr >> 8) &
+				     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
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
@@ -398,6 +448,9 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					    upper_32_bits(adev->vm_manager.max_pfn - 1));
 		}
 	}
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v1_2_program_kernel_trap_tba_tma(adev, xcc_mask);
 }
 
 static void gfxhub_v1_2_xcc_program_invalidation(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 04778f9f95bd..da4e1fa34d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_0.h"
 
 #include "gc/gc_10_1_0_offset.h"
@@ -285,6 +286,40 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -332,6 +367,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 6c77c17878f8..c0ff251bcbff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_1.h"
 
 #include "gc/gc_10_3_0_offset.h"
@@ -297,6 +298,44 @@ static void gfxhub_v2_1_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v2_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
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
 static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -344,6 +383,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v2_1_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index e2b9fd0c8af0..1d9d4d41c42c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v3_0.h"
 
 #include "gc/gc_11_0_0_offset.h"
@@ -292,6 +293,48 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	u32 tba_hi;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
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
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI, tba_hi);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
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
@@ -339,6 +382,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index fa8b966b7ea1..7f2a0b21cd4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "gfxhub_v3_0_3.h"
+#include "amdgpu_trap.h"
 
 #include "gc/gc_11_0_3_offset.h"
 #include "gc/gc_11_0_3_sh_mask.h"
@@ -297,6 +298,48 @@ static void gfxhub_v3_0_3_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_3_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	u32 tba_hi;
+	unsigned int vmid;
+
+	if (!amdgpu_trap_is_supported(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
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
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI, tba_hi);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
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
@@ -344,6 +387,9 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_supported(adev))
+		gfxhub_v3_0_3_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)
-- 
2.34.1

