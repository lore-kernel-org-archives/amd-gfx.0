Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF84CCA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 02:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E4B10E1FC;
	Tue, 19 Aug 2025 02:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lU+kqAP6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7149710E1FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 02:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTgmF+CmfOmsasN2GRDyLAbGFt0+BTh6Df/N87nndQUNUOK5vq/nc3RJ3fPQzr9Osw8fdf6lrdCPbsz7L4ZNZWENQEnnoHSaDUaVFZw/AtcuoBV5j/2znjE1jUMn83qslmW3FZJ/oYzZC8ELIG5rRJfCdNnOy6rKkplY2mwiqHE3ZtffXd6+pi2XF/BD5JvupYv1jlpFJy3QOwE47QLPKakAbum9f5zWstaSDX8YvCXKQwPHjfjkER6IHn8xCtHbYPygE4BNrENwixyhpyiCa7MnC7hRZLe2aFfgA1SYBOfOdh0+OxwWESJH/sYW1NV0gxk16MSOTqANKwiY5Ns0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VVK4DRxqzjp10pXnBBfnk6hMz/3zNhA+5hyK9kJQ7o=;
 b=jdqORtD4gAwE6LhGHsXeyZGoemkJv9NYqOXbyIO2nDS+CWzwAN4aRAAYkHbOcNrCKU0Fo++OQJW1aftMhKXcbMAeqfilBa5JxVpr1Vrb9Q41ClIxDbdGpEsaVIK8TLKUwO8i/7V5/fdR4tTLsSH3c+GN1B2WbNzkXGQQ9qmX676BZ9nfOriBkIUwegPpvgGaby0OoPpsjpPI3xSyAW1znBnU7F2Ckkh02oHSGRvQoF+ydb7hUAU2an3K9ZhatUrJ5P6vSVpd3fuBjlRSbm8hpEJU/Sf130l7J+9HTUYDERTONba3aqTg5fR+98d2AR8KpIuuHuqgCSGibzzAkCXs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VVK4DRxqzjp10pXnBBfnk6hMz/3zNhA+5hyK9kJQ7o=;
 b=lU+kqAP6j7JYsKiP75S4y2uh2RRSjrKcjXaAGsGRqKgi/vkyXZgPsw9PapQrf5JXvIOYk8OJ79nCQPfJzsJ3XpvJMgt7216+DrgirDr+PsfscT2khTkhOwLrvfqHWoojJX5LVvbqnpkpG3r/jgYKkN7ACEKS9Su/Tfnde4pasEc=
Received: from DS7P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::9) by
 CH1PPF2EB7CF87B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 02:15:18 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::4d) by DS7P220CA0012.outlook.office365.com
 (2603:10b6:8:1ca::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 02:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 02:15:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 21:15:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 19:15:16 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 18 Aug 2025 21:15:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add ring reset support for VCN v5.0.1
Date: Tue, 19 Aug 2025 10:12:21 +0800
Message-ID: <20250819021511.4002952-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819021511.4002952-1-Jesse.Zhang@amd.com>
References: <20250819021511.4002952-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 238b60e0-40eb-4e73-4b72-08dddec63d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E4fvQAMIIdMORRnxYRkRwbOSZGqYt+OnAUesNwMa5ONApVU5LxsfKGAce64A?=
 =?us-ascii?Q?hJqUFoj7H7rdq7P9JCoxbfFG/c9xNWNF/zEybSUDoQh+yTSOncW9nAE2mwVz?=
 =?us-ascii?Q?i1ZqddnS1pWckOA6iOSIUQXUltACxKoOvznkhFaARUi65EpQVhnTLV/4yG1Y?=
 =?us-ascii?Q?CgHWfpNBC1yIYLkeTmmVmdslTDMM3pxPUP6hhhYJfcM7f4Cxxl8HVPOx3NNX?=
 =?us-ascii?Q?qyuRmhN12hIdNQ17x3Mt/728yzyYOmQ9FrxNQ5lQtqYmB6qKsmCvcPjhKmRO?=
 =?us-ascii?Q?+keJCoC7NFLnW9Cem7t/RaLPY7YJXc7QewZGqZLFGZP0v4XELpjmdZW/QBLC?=
 =?us-ascii?Q?6e7V8RGvIH44HZngBzPP3Fi6XS17/t4N/Fh81t5jkIZUM22lKKXWiwTop+u2?=
 =?us-ascii?Q?mkOOOd5J1Bbs+azoWRlyfb+18oljXfYIAiEqk0DPGJohAWChIGc47L1jBc2L?=
 =?us-ascii?Q?ANV3ENVwpH60knuUqqWbvQVTtNexq9ILQbETfU6uIboP12ctUNbdqGS+x9Vp?=
 =?us-ascii?Q?5yRcOh8Mar0oOEGF8ubmD4DSVkzl182OYTJytxbCJKYHXfpSG8roC4Dc6i2F?=
 =?us-ascii?Q?z98KIA42HGbFLGfw22q5mQre/wZGyspbM4yOPfYnWTIAMwmN9TlavyoBOR/p?=
 =?us-ascii?Q?kSAeGeZuoDfXI80uDt7tp+FJHwS/glGFSMGdoadk63hfiscRf1SUMsbZ92IK?=
 =?us-ascii?Q?EiTBVaz6ey0GmmbIbkQg3FMHdzR7p/vQyLG2VdxTXq9R5Op3xDTw3Eut79UE?=
 =?us-ascii?Q?FzM3t3E2mff+7moASuThWngT0mMWx0LDMNcTcsecIv8nTm7S2uO9SiX6TZ3b?=
 =?us-ascii?Q?fN92I0peBKvKZMSxz3i+T5KP86ankIk9+fmsFeR9R4Eov5fqZ3wTNdCpDaDs?=
 =?us-ascii?Q?GSTgx97Alo5xC6H/1EK+5HPM3aH1oO4ZZ8tIbk5D7tGvRb/kPKlEe5HrKsuz?=
 =?us-ascii?Q?1lI9BIWbwGRXaQN+8FLaTBszXGC8+4KK/oN6V0+VJS0teNjgUx2ZYSfRm5cQ?=
 =?us-ascii?Q?EqfVIyX2oRiE0L/oQ4gSZOIZMLovk8cDApV7KoD/gfmSzEw38OeLCI21Otyo?=
 =?us-ascii?Q?m5tYYzRpEJorV3LUU0AJ7qBqeTdbXi5uKYZPViTuVAYJlJJqrd0AkLsanz4N?=
 =?us-ascii?Q?yZo8FIvqaRsqu3hS9SRO3FC93m9BEpDaEPv5rEtZQUMbLts/5H95sLqIcrnO?=
 =?us-ascii?Q?xgAsi2nV5kNSKJSnc7vuh5wtby1afHuspRJyUd3kXXh2kFzPa5xSNMRowj6P?=
 =?us-ascii?Q?/67nd8PRV13wTaXTSKk3+YV80/snJanwHHH/RA8KbwqXNcEcD6uxQv0AXACS?=
 =?us-ascii?Q?FM7zAMdksR3HszGh0d7EereAnwLVD9Wbavqt8vPxrKD+oynLObbODZoDjESs?=
 =?us-ascii?Q?R65vmznRXl6SO+3Xm9Ctt2azA01YRy8QKtKA/p9TBCoo1U9XzldwxodHq9Ip?=
 =?us-ascii?Q?gP1O/cSozlmYtPVXWfNdO4QACUKDEWFI+CPPIOA8hxsewJFpcHoiY2pAOkWZ?=
 =?us-ascii?Q?bZsND7knZU1NJPnAIAQaskxaT1QQkS6QTTYf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 02:15:17.3241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238b60e0-40eb-4e73-4b72-08dddec63d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

Implement the ring reset callback for VCN v5.0.1 to properly handle
hardware recovery when encountering GPU hangs. The new functionality:

1. Adds vcn_v5_0_1_ring_reset() function that:
   - Prepares for reset using amdgpu_ring_reset_helper_begin()
   - Performs VCN instance reset via amdgpu_dpm_reset_vcn()
   - Re-initializes hardware through vcn_v5_0_1_hw_init_inst()
   - Restarts DPG mode with vcn_v5_0_1_start_dpg_mode()
   - Completes reset with amdgpu_ring_reset_helper_end()

2. Hooks the reset function into the unified ring functions via:
   - Adding .reset = vcn_v5_0_1_ring_reset to vcn_v5_0_1_unified_ring_vm_funcs

3. Maintains existing behavior for SR-IOV VF cases by checking RRMT status


Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 21e48df537bd..3b6c5bd8abdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1289,6 +1289,34 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
+{
+	int r = 0;
+	int vcn_inst;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	vcn_inst = GET_INST(VCN, ring->me);
+	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
+
+	if (r) {
+		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		return r;
+	}
+
+	/* This flag is not set for VF, assumed to be disabled always */
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+	vcn_v5_0_1_hw_init_inst(adev, ring->me);
+	vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1317,6 +1345,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v5_0_1_ring_reset,
 };
 
 /**
-- 
2.49.0

