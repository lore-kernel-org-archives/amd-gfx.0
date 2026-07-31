Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AA2C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F325710F165;
	Fri, 31 Jul 2026 06:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xp+rnLdk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9903810F165
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 06:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfKrSGYcixk9q3yaWnTitpIBAgKmfXQhRz92ap9hAmJfsYsDIqIzGGY8+JpN7f1dIcRqc7JiPMlpjIPA+wIlVawJD4p4NILNweaWe0vmruGzjloxwSk3z/NuLD0+Jko0GXDbWRm/HFS1yiS/takvWKzXICFOz63KKn3pT4iMUNWvsfAOAJnNa1VgyL7n7cH72luaCbxS6WdYz8eICsCVtdEYJrRtQFQwDxEIAD3Cs53E62VPZfGvXji/XXO1465Vy3ljn8erBUXF4rimwqh7g80zvykGGcKRFgtLk8PhDSYIFoaYKgVcgK5vgiGRG66cMRpZCabL8rXrWlsUqM+/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0haiRe3mdC6fFKoWBZ4BNaqOVb7TTKPWy/fD3QPCOE=;
 b=LwyeXNpYynwTppmjGTJNiPBorSghzZJIeDdrS8A69hVPN5MqtBTUyEkPo48f53hfw52cmfCZP1KOLWIDsmfnIBR/Q5hzUiOEo5EGK4WIZiX5DYVBXKoBzBDQ21pnjNCu8CYfj11F9FuwbCUWdS43SaTsVEPrOTzDXWbVCRK8gbmIUUsFrLmi4Yfe0yXOPkXRaUEswYtDQHx5YuQ3KdG2jzh4990/bugLEQCKdZ8q0AsLrUTCZ3qcHT0zDWkuzHZU4BWgp0mRgAEKOOt5cQ5/I7Ifp/QZel27ZpGo72+aAmWHGYuoUPUT4AmIzFxVhXx548IVWXsD0QaRPhCpOEmbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0haiRe3mdC6fFKoWBZ4BNaqOVb7TTKPWy/fD3QPCOE=;
 b=xp+rnLdkVB/hI2of9+oX91eUK+GPJq9bvFmi/QGWDjviz/+imJNJAmMQvswROhdGCajE4NZvcRaXaDpRFmRoB2PRTtszk670UVwlMQ2dhnpXPOkXa3OztYHV70ECGAGlcMGE708FqwW25qio0oFsj1bzTFnbLg2eqiJepwe1FCo=
Received: from CH0PR03CA0391.namprd03.prod.outlook.com (2603:10b6:610:11b::10)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:31:51 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::31) by CH0PR03CA0391.outlook.office365.com
 (2603:10b6:610:11b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 06:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 06:31:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:31:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 01:31:43 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Mario Sopena-Novales <Mario.Novales@amd.com>
Subject: [PATCH v4 3/5] drm/amdgpu/gfx12: add priv-fault user-queue recovery
 worker
Date: Fri, 31 Jul 2026 14:29:55 +0800
Message-ID: <20260731063128.3026783-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
References: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 99de9864-5b41-4ee2-d726-08deeecd6759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4GRzskptXi4CRIBBS/Bl1CSWp2M5TDm2KGyv78dlfDlke0KRY9sf2SlJMbMN7J0hfvZyH8Q0CVgPNo8Ecnd/8I3QqsZquV2zmvm/uyaKrMZMtvOdQ14FJ8KkJenhKjYMOuU3QSppWwFM/DEXF3yqBIQzeV35Tz6gl0EhguPWRiYC4zdoHgOfjc0mm85EpG8B1SkEe/RvWnCvYip8TbTFmxUetw21F3FHOL44aQT6A72dFehzK2nDbcaxMYivObW6NqsF4Djwp46y+IejdOYjhnDZ+BgatVevNj4aHlbnQxDYCnvtor+S8J8X2OLzcuqfKLx/JGMF4mPZenFHNXwnjdUFoDDR2P2kaWIoEHy7NU4gzwayW3xzIz/QKqoDtmeDcNwDZ++p3U3Nno8TWQdkzy01jvCR02lBU9r/IfpJL1u6T5ciiuaQutqija1ESXyP8RHfMd5HbowtG/wcbDB3c9UVHE84fXwHJ9egBaksd/RsOXaAF7z/wMpQcv2lAVtsXxHfebkdg048P74GdJSwV3EHIN63lcLqWQFs/5JNykpWcsziLKON+PHccSKR2gZ1UG1/II3FEUFQA75OQyBecJ7u13sxoyLHQ6k9Zi227CRgkGuHUig/X3ZGb14zvPE27l4GF1c7WElqL6ov1d7Io1G2hAaBcIHgPIpbFJ9hBBFKJ0fnZYynKl+IfRlQSU2XNeO+0C9isXaTSUzd5m2zuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GqKWAmskxPxLOPpbyUx8hC05CTbINrwElKe8vB11hZHtFDw2qnwUE3oGw0MwJ2YU9TG/OQk+Zl9TlLteu7uh5wcHc+ZleqSL2hHxqCITReG9odVG7dlURzHwhoTsjGRXxNW4MSQDdZA8Ko3jstT6pGx7r8XPlhLCyzJzOne1xxpf8NLp6HzjPxXyW7opowlntYuGDRyGCMjblCBxAyNhto22zRmAzpQ2Le8sN48AQrIr3WBOKKWOSVTGyr3e3TxgvXROY7umFwwYk0688S/LbAD0KHymwDtzLDRq6yR4DRqFyg4iZjQdLzU71ofucQGlsuz0onAlVWU+lJWQqruv0BDbsRtvTaNpZahki8oal3paFBDGeXapnX7MNguQsai/YaGY7jyS9i9BzqCbA6lto+GYd3d/f0DGKDYxQerEJbQ7uWy1XoiqBjzRfWLK6Tu/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:31:50.2558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99de9864-5b41-4ee2-d726-08deeecd6759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
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

Mirror the gfx11 priv-fault user-queue recovery worker for GFX12, reading
the doorbell back from the HQD via soc24_grbm_select.

The shared amdgpu_gfx_handle_priv_fault() helper schedules this worker for
a gfx user-queue fault; wiring the helper up is done in a later patch.

v2:
 - gate on adev->gfx.disable_uq instead of !adev->enable_mes (Alex)
 - document why both the doorbell (compute) and HW-slot (gfx) reset
   paths are needed (Alex)

v3:
 - rebase amd-staging-drm-next. adapt to the deduplicated amdgpu_gfx_handle_priv_fault() helper
   (commit d8ab7636160e); no functional change

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Mario Sopena-Novales <Mario.Novales@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 719441dbcc6b..1e5fd1ef8f1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -286,6 +286,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   bool all_hub, uint8_t dst_sel);
 static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1609,6 +1610,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
+	INIT_WORK(&adev->gfx.userq_priv_fault_work, gfx_v12_0_userq_priv_fault_work);
+
 	return 0;
 }
 
@@ -1646,6 +1649,8 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->gfx.userq_priv_fault_work);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -5048,6 +5053,40 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * A gfx exception IV carries no doorbell. For each faulted slot, read the
+ * doorbell back from the HQD (left in place by the fatal fault), look up the
+ * user queue and kick its per-queue reset.
+ */
+static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, gfx.userq_priv_fault_work);
+	unsigned long slots = xchg(&adev->gfx.userq_priv_fault_slots, 0);
+	unsigned int id;
+
+	for_each_set_bit(id, &slots, BITS_PER_LONG) {
+		u8 pipe = id & 0x3;
+		u8 queue = (id >> 2) & 0x7;
+		struct amdgpu_usermode_queue *q;
+		u32 db_ctrl, doorbell;
+
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->srbm_mutex);
+		soc24_grbm_select(adev, 0, pipe, queue, 0);
+		db_ctrl = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
+
+		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+		q = xa_load(&adev->userq_doorbell_xa, doorbell);
+		if (q)
+			amdgpu_userq_start_hang_detect_work(q);
+	}
+}
+
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-- 
2.49.0

