Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60F5C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 18:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C001135A2;
	Tue, 23 Apr 2024 18:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XP+pv63V";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391EC1135A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 18:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA2pfzirygnJwRzXV8qMqLCtP3nZ8rr/t4lWnZP1uaHlpRPkDp5X6eLDydXE8DWVHwb1Y8V2hD/lLUXc0EkrCyuNo+rkUo6t1U1WwCN9s0oLfZA9ZLpcOE09/zMc/BZENBognSQSjs28pUt2VPj/gAT9I7pHkC5szoF3wQxWynEYPQxZ1HcJ9VhjiSwaqBolvweWD6iQTb+1N2vW9y49ChM8gJ/bzaB3iIyb++0r5h29fixx0Mh2+DsWsGobHdKNWYHDXjM0+frN0xA3n2W3xOKHFpMcQtw5uXl/CLYjWouXF9qdMTgmpZ25nQOJgeIsbHsxx7z/xtKwZY7saqm4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO/2sRI3VjX6aqukILeFJD4Qh7LC1e9mFZA/yPqTLJE=;
 b=ksKpjiX67SLQbBR5Iky9FTtbd27D7p4iXkilWmU74lAtD6vtGDVY4mqX6PAhuD/t7epTnZfrFTMQRAGGVehbysm6GXUouzc57KIG9GDV9kIryHdHkmZq3jzyAjdqdn26BcvIVHwqz/Oobp1OPsBk+TB9WlxVIcwQFqIvOC4Xtw60EIxwcwuvKA0SX1mSnXlBPcESW68Kdziqv437pe3AwLhuMg3aEbjg8lrpWCmBg9P4hWb+idgMcgVr9CmgLixkVThCdTSJNFBr42O7bUEhruoA/fS1q1/OVbAkhJLJFDajcJQdGnvwLDt6z3T9oNdyIoOOsFOTqrrKaCS/NjdQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO/2sRI3VjX6aqukILeFJD4Qh7LC1e9mFZA/yPqTLJE=;
 b=XP+pv63VYnyZx/cw2+xGdnVVNJqQ0LtqLKHbm14410WMSTqdz/8MRltlwreKfjY7esIMTPb5qE2KT30JO9OhCmpyOtXxtY6NNbCQ4g70aqKh/CGi/A2RbygKFXhnwpK7XNfXPaWGTvAPgSkTxlzFY9xxQAI4fBrC6K0c1SFGYJ0=
Received: from BN9PR03CA0607.namprd03.prod.outlook.com (2603:10b6:408:106::12)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 18:41:18 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::b8) by BN9PR03CA0607.outlook.office365.com
 (2603:10b6:408:106::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 18:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 18:41:17 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 13:41:14 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu: update fw_share for VCN5
Date: Tue, 23 Apr 2024 14:41:01 -0400
Message-ID: <20240423184101.2594284-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: b15427fe-f80b-478a-e0b5-08dc63c4f64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UtBZjRwIbClO5bGLWIideT02JxM5L5ex9999LxmT/7hcjAyKJbmufzn/fR7G?=
 =?us-ascii?Q?+qSxAcBYSPLu+FOf9IrsROkiv+Y9LwxDARFF8sSC6VPkzPAqtBXb9jwbWn//?=
 =?us-ascii?Q?jf04nAO0B2je5C8CVO+KMhv6cZqwYGAb1MhbnMcc9GeYf0kXffLc7EoV2CyO?=
 =?us-ascii?Q?pE9ziBPz8qlUcC8FRRonbBoLSNSo5RNTeZu0+dddU3tKwiMCqYnYWf8LLZzf?=
 =?us-ascii?Q?az+1EUD9rVTX9BHJHJFph4iZsQdyXTKzpTT1Qr9H3mKOSRFhXgI6wg5K2DW7?=
 =?us-ascii?Q?imkhXfrxe2O8TpKXRel5FN6w+lvylx/AygtzCufHGTc1xztxAt2toDexZHM8?=
 =?us-ascii?Q?NvYUE8ji9yaqHa1tdWA+QMwzUOVjfuWdC3gX5p1tIot1iSbqa4PRWSIJSZy0?=
 =?us-ascii?Q?VaIv+uf0+E1x3Wun/2QuTYd0DRUol+RvOAayJrFv3aLcPjYgWuKXFB4KdyyK?=
 =?us-ascii?Q?9luJSfbkPbFY8GvHkEtm/gnqSsJrPBTkrI4y8ZAYgCtt8PEJHLJh143y/Xea?=
 =?us-ascii?Q?jYPwtCd9kE6TKBE24pawiFapba2fFaiei+GuH2fLy5cNgpjtCH48X1T+JsAd?=
 =?us-ascii?Q?lxmkz/ggYuZMMfGDd95op4K1CHmtsvbSajBMsBWSjcuG9Y1etiQq4QR4hM6K?=
 =?us-ascii?Q?OljgiYgxz5unfJ3AUYdADH0OWuoinAiI5jv80uZl8VyVx7VWzlA+0imtDLay?=
 =?us-ascii?Q?hWZ45eYdq5h2ol9cm3pVkHJkfFDWBiw7jTCP2Zfkq3gEO+eykxTg4e+1gEwb?=
 =?us-ascii?Q?RTJtcKJmGgbT82ESQ/HcA9VPOpC6B6xtk3nLbwZdUASaX7aKm5PEncp09aNd?=
 =?us-ascii?Q?S9htD9JePvaqpHBqT2qMPZXFskd0lO9P1Jig2h89FngAbNPsxtkkTW8G4iZs?=
 =?us-ascii?Q?srn/s+suSHQKUEMKE20eIHc74WFcZDC46VJfo4vz5gXlm5oFLR7qfvPypVYW?=
 =?us-ascii?Q?jma0prGtCfJnIJfgJ2dvbTKuAyGFplp8wwmWwypykR02Y9jEJKkfs4f6561x?=
 =?us-ascii?Q?sL2rYRZW/CpgEug6Ck40GLBKq8bqwK4AVgVsDOhr1eZdAVSO6pFYXROjV291?=
 =?us-ascii?Q?ZFGe88hgGQzKYXyqdRaUFfe+3Kb/h0fXDEVyGkq65W7R/JhqKvWlvrAiJiVx?=
 =?us-ascii?Q?6RmIUq2dNWuWIoDFayAmt/NsoCAxsdh8HEgN3wZbtP6C3LrKyv5zs9/3A3tv?=
 =?us-ascii?Q?viBhiFmDUUdj2UiofVwRCyUoI2HTTMB33BpoJDsnrZx5lDiCtAnhP+kZ9uhU?=
 =?us-ascii?Q?Kx18u733kCW2u/dPUs9FfZXrttte0fl9gil2RGsNPA45fkge0auYhgKJivse?=
 =?us-ascii?Q?hUW8ColuzUHar4NU7m0I1u/r4GEYJ15lezOG6xPfhDazLY/SNknV3fWElRna?=
 =?us-ascii?Q?LUQcmqA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:41:17.6625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15427fe-f80b-478a-e0b5-08dc63c4f64f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

kmd_fw_shared changed in VCN5

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 14 +++++++-------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2bebdaaff533..9ea341b76165 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -185,7 +185,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
-	if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(5, 0, 0)) {
+		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
+		log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
+	} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
 		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
 		log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index a418393d89ec..9f06def236fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -454,6 +454,16 @@ struct amdgpu_vcn_rb_metadata {
 	uint8_t pad[26];
 };
 
+struct amdgpu_vcn5_fw_shared {
+	uint32_t present_flag_0;
+	uint8_t pad[12];
+	struct amdgpu_fw_shared_unified_queue_struct sq;
+	uint8_t pad1[8];
+	struct amdgpu_fw_shared_fw_logging fw_log;
+	struct amdgpu_fw_shared_rb_setup rb_setup;
+	uint8_t pad2[4];
+};
+
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
 #define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
 #define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b9455b6efa17..851975b5ce29 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -95,7 +95,7 @@ static int vcn_v5_0_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -154,7 +154,7 @@ static int vcn_v5_0_0_sw_fini(void *handle)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
@@ -335,7 +335,7 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
 		upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
 	WREG32_SOC15(VCN, inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
 	WREG32_SOC15(VCN, inst, regUVD_VCPU_NONCACHE_SIZE0,
-		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)));
 }
 
 /**
@@ -439,7 +439,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 		VCN, inst_idx, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_VCPU_NONCACHE_SIZE0),
-		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)), 0, indirect);
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
@@ -616,7 +616,7 @@ static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
  */
 static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 
@@ -713,7 +713,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  */
 static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 {
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int i, j, k, r;
@@ -894,7 +894,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  */
 static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 {
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
 	int i, r = 0;
 
-- 
2.43.2

