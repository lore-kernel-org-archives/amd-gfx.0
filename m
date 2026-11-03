Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A2606A334
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uxKdaAVd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D180510E751;
	Tue,  3 Nov 2026 02:30:07 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A88910E751
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clUlINXSRdZM/Lh94yBzI2Z5aDrDVtSQZol5Rf73roEFPOkmd2Elkgk4UkR8l6/xEv8s7/ujyV+NguTmR0DLcp/Q/utT0u7MQeODwTDf/tSAjhJP2YMuuagWizR6aAIqRHGmopT6Vmq6FvbzBRyxLAJVrQa7U/IO3EnpruOb2zhdCnA1pAVo+HsYtb+54esNfZ4PAIRtag9F53pfJg783zrO3PdQO5qDdt0IGx33a9Vr6ck3hCQeE8l8bf0hAyXoH/Wvw/0bSYE9IYxP7QE7L1tAMr5vxE5h3+LI8qVNmXSADl9tJ7FmicY60LM1LXjJv3iLBR1f07V7Hk3eidhZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoFN1YzEuSX7ztDy3o7vGRuKWLL/aGWqn0cE4C/1FG0=;
 b=nEjLct3+YbBE89GjqNgsoIeqkWUZm628Q7ppos8SjrekOMfK/D/LJ/ezTYhHd8MPrY1dLM2aC9NRfch4nrqDfjwBJgVIzElEDeVKTn/EHbc9C6A1SYJUyb/Px1kzFMh21SVhuwXR8xEXJYsenT0qkM9UYr4l2BcoiVXXtqr3XezldjR4rRagTovY33JH0hGcp6h083MEsyK7dpDiqDQsgM4XB8CPXmqFp7WKhvE//E83d4OFmG1nv5ChuPgUnUnPyvVEvbiObW0ldP7fLrtPGg14/BaIcnBbe8KDaZEBGC0DEp3oDaTeZGjlgSlM2Of4W24/RqVcFp9mvQYyFP472g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoFN1YzEuSX7ztDy3o7vGRuKWLL/aGWqn0cE4C/1FG0=;
 b=uxKdaAVdEyTFYrfJydnxveeuk/GpbYWGe9FcGYRIS02OfmqlSoSB/oqqPsaImQE9K61b5IUMFIAxTNAtQ9atc83xt49tMusVgh4GCS1rfn58O3cLv49wmeXoIp0AFoxEDF+dyXk7d9e05fLzG2BrB7/rmQV4gcnxV5EhZHlhSyA=
Received: from CH0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:610:11a::17)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:29:56 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::81) by CH0PR03CA0354.outlook.office365.com
 (2603:10b6:610:11a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 02:29:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 02:29:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 20:29:52 -0600
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
Subject: [PATCH v3 6/7] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
Date: Tue, 3 Nov 2026 07:59:23 +0530
Message-ID: <20261103022924.1495748-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103022924.1495748-1-srinivasan.shanmugam@amd.com>
References: <20261103022924.1495748-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: fe83601d-6b14-42d0-f59c-08df39525998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|10067099003|56012099006|261102123227099003|3023799007|261009223027099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|11063799006|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: iupQry8XMqOu19HGCcmYkzhtQQ2IgO+buWCBoorRqQZ+VefpSU2Oviu0Kuu5lKb6yEqnemt2dqWgRcidaRFaB6yN5zyCZazuN3sisJefpkXO0XqodBY8Z7zLAipK3S8UJJTepm56ydq7rY8jObqctIX22a0AEyf2DYusu9YX+sF5oGiRNjxJR8joqdu6+ll1q0FrdsV2bhRKTw6w/bH9JRdsTKUaYhHWzBI8vTU6O965Pi940k0GfcfG7xmvnHwv6U5dFbmkblrnOiz14dyy4dxr8OlJqI98Opuy1LskHRDdjswLXNieKphs1UEiiGfSm9KozKKeymzmjWQB9nf/a0Cu4NY7rBzGphMTDMDQavU/7i2BbUySNvxLiPeONrKu/Vd2HVW42SKdhGkmPJEVrqmF8OLOsRejpUFnNmWghee/fMsWysZqBmMbXXefbIghY0X4Hay7KWv6s+tehKVRWSDrcxGpbRBXIgnDemRAq6x3yOgpDNE5VgYmmOi/R09s5FLYGd6T+W5BWqEg7a9zPNx5F6xpri22EZOwADeqHLBoPcdvdoE5NKmluqz/dGzQDOiWNL8k6nfgFqWOWzuEtrdr1DLgqLDqjKKWl4HcfbFmZAqtX+7iRE76TAe3OzpmCa9dr5DzMHJmCzczYc6mqtSAmU1Gus1fHFM5jVwx5PExg/5jwsTs/uZzyGTHtOGe72z4s0Fa+D5Xck1K03ecEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(3023799007)(261009223027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7NZ7I2tCM1GhR2T2QucMsdkvuAxRTFALBuXswzFxzadFhOYVHXOb9wbS7aewiureXx+Zt50LU6w7yyHDQ1hRmXYGqYdXj3aGql3E1ERuZ+sbX8r//p0dBV58Qv1/bw7YKqRBl0lnTJLmBc5a2qlY7gyd7fMEVonkoHyYXw9we5NowwxXFyblCFBhNYd2swvtxp6ImU1JmUV7w4IMUR5PVvdqNCTP7E+HNXN+OE8dhlME8coKuAEEbFwxqFz+rD78o7mq6/D3uZSTibWmRMDjeEqma3MLdA94gW59IhTs+qwaQusbYVoYkP7HxzcjQnxg/PXRE69Ke1z2xvnePUSizS4VUmE+5iwY6iwYNDhck/nd4osYGKEXitTg3pZ5Ayy0uKu0c2eYD1xENRDGBi4c16z0Hmyfs6qnGsBX1WE/iCBEfedTRHU/NZOqbrwS4bIO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:29:56.2644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe83601d-6b14-42d0-f59c-08df39525998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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
index 3d3f5c9abf3a..80c8c431493d 100644
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
index 2e2673a6dbbf..7490f366ac49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -29,6 +29,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_trap.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "amdgpu_atomfirmware.h"
@@ -2570,14 +2571,25 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t vmid_mask)
+					    uint32_t vmid_mask)
 {
 	uint32_t data;
+	u32 trap_config_vmid_mask;
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
 
@@ -4046,6 +4058,14 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (amdgpu_trap_is_supported(adev)) {
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
+			gfx_v9_4_2_debug_trap_config_init(adev);
+		else
+			gfx_v9_0_debug_trap_config_init(adev,
+							adev->vm_manager.vmid_uq_mask_gfxhub);
+	}
+
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
 	    !amdgpu_sriov_vf(adev))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index da031caa4e9e..06d7f73c58ad 100644
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
@@ -1168,25 +1169,66 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
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
@@ -1194,10 +1236,17 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
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

