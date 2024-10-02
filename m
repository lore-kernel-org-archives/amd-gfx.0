Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537D9CF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC9910E689;
	Wed,  2 Oct 2024 04:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D5wHJPWT";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E426310E689
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChiZRjiSSEN6uJJAQuuEvwm/2msXiYi1SSsGargG14fA3SfA1pi6WH81E61y7X1j15bJXTyg8n+JwaG5NQsZzlOvWp6aZScWroyq+9Hm+H2t9UaSRhNxcAud68F/5sG9lsamvsSvITe4ea6/B67H34CJCi4mOYP5PZ8Cmk2WDq4xKpso6kZ7a/kq5nlJutT+0g2D3weLjgXUwXMI6UTz17EkXYMp5j8RZgRbdK7L8TMB9KQ9sx+rkQ8LSO+gvdQ/JMJfJw4NiUDuBPEJUvJDhKkKAht14YkncjCD3VbwzBOZmpfffELA1GuRZx11BMescxzmbaAAPHfbR3+aYWN77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6jqkCHXAwqQjCiz7/mv5ArLa7PARyD+uWpVRGzueLc=;
 b=cbnk2Rnk5FIzzK7SOfJ8kAGAgfeE/2BDF3zbjUfbqLYWOQP/KMtAp2t3ZFZDyxEpyUPQK0KpcymRJ6RdyR2DszLhoaSuRYptfMIJ/Sf5z+J6p53cZbqU8v2NMIgcd84lk7Uk5eKu9r6NKeyIr71eM7SUjYMYnipW4i4wamYy35ZJ3mQG/OSBA88PXhMEkCQaOxbe4YTIArYMah4ysqOLIu5YQYsaI3kdxMu4jWXupuTOSzfuEGc26SGFkuYg/aCq4CYYCoRyy4Kd2oDB5tOwxgS2aOX/dC/qF3bvPrT1xY235yxfkGTxkqGnL4jaUg1zQgEI18XTjA+b96kqZuKAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6jqkCHXAwqQjCiz7/mv5ArLa7PARyD+uWpVRGzueLc=;
 b=D5wHJPWTDPvzaXD5VbICk/zQuo9mkRklmp5Tj9FxzlcIWF2uauiNf0+eZT3xns+HYDYtGwR0sCy4b0UX3uSGHZU/zHIF9W7vF4EkQ9lsCIxvlfc50B7N5lJBbXO8YBwuuHYk3XqvyKjAtTX6XA20xtKaxCCz01EwiplbtK8DZQI=
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Wed, 2 Oct
 2024 04:39:40 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::cc) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:39:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:51 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 14/18] drm/amdgpu: power vcn 4_0 by instance
Date: Wed, 2 Oct 2024 00:36:23 -0400
Message-ID: <20241002043627.102414-15-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa8254e-2bbc-4802-b56d-08dce29c3a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3SrAhlEMuusLaLauiwmgqmWprJ+dq27HWHSUSDFWM/fH5G9dOZMo3Cy0YaX8?=
 =?us-ascii?Q?MOhkK5x10rjhV9HkfiQCCY+67y+MAONu1ebhvvb6FJMK4QuLG93AOC+XXFcx?=
 =?us-ascii?Q?IPoJaDQDPEs1hPRDw7Xa+FxXvhlarnMBr2SS2Y7x3o/lO0PyWJ/UvrFju06D?=
 =?us-ascii?Q?LHZoN1zOthiyK4T/VR7OS/FDQ4+VClqcuoKbYDT0G941fZP5PCJKsFiakGtx?=
 =?us-ascii?Q?xuAVdphXPvTxZwGvGx+qXmPH4O+QsTqKrqHv04v9j+IR83RrX5q5EXPN2MIG?=
 =?us-ascii?Q?OiNs3m9BxqwoWtZrurUWQ4wAlx8XApUQF3z+bVPTbyBIaPlGgoZfKav7mUh7?=
 =?us-ascii?Q?owizO9+29pDb9De2xVAcHBZUPn/IyLd5fkyoZCDHk+6ia7sgs+ih3EHWbKdg?=
 =?us-ascii?Q?bMQin2OwPlGM5O/piM8pDdPFVFlohr21nSe2I+XBpMB+P9xAz5TY8PBFnmXY?=
 =?us-ascii?Q?IryPHptYiQ0reGYfsVrdvLf6Re7iv4Xeu0XaEY1GPAJsGw2+eZOj7Hg4YHLU?=
 =?us-ascii?Q?zL+3o+eBBm10bQ7t3rHASsuiNZ9lsYVE1N9j/Lig82kCDi2FbdpDUjfX436b?=
 =?us-ascii?Q?vDDbme8OmsN2RSV9c+VkRV4UVydC/pHqjivjm15j8U0Rd4fMfu/CzfX59zgS?=
 =?us-ascii?Q?KZp5uhEZVfAfRCWsXypV+yOMs7CMg2TU2j5mS4t9NTQeHWZP4owXHqVePIzW?=
 =?us-ascii?Q?fyNxnSsQLcjOk3kbZTjtbjksKT9QloZ0xGDp08O0/JgeAbk2E03gQNEZPnSe?=
 =?us-ascii?Q?UOt2KBo08+/Cp9w69LqcMNIw1yEhPCPlN8dlPd51KSFezpYcdjpQFJ0hCPla?=
 =?us-ascii?Q?uuQTA14o5TDNQDRxnSzilk9+02m45MkiMUqy+MGFoGJ+fkJBpZP+QEpIAwam?=
 =?us-ascii?Q?egCoBhFGdIwYiQWrq6wByu8hH6poAs9yLVOh49mFGoUroyV2TM8h6AjU1/na?=
 =?us-ascii?Q?x0X3X0SoCucP85e2lHUViypgVA4dUbBDak8TDlmn1v3kYrqfNyf639Nu/2m4?=
 =?us-ascii?Q?RclU3WCHD2BShHNvZDjraSKreGiLDMIO8fLNpHRqix+F4+9BFo7uEyKg+WJG?=
 =?us-ascii?Q?PHRf3xOt3L4/vNYCKz0AsrlkkZepV7SRcvEUJ7Krpt3O33CYaqsfM0hrwJsQ?=
 =?us-ascii?Q?0WMiT9iaz0zvLM2nAUGLO3WUxFyeP+Wyr/sSPa1kJr9ZluVxTHtDscSPJHCc?=
 =?us-ascii?Q?fV2js9atFenO5WcfyPATzNk30B245DrQFlHY/iCzf7Gih7fUae1rGJZJQEZC?=
 =?us-ascii?Q?+A4xezs3Syw+Dday1lmfAQteYQbaOGcJBTPkUr1BdKAUlHISeHvXKavepZpm?=
 =?us-ascii?Q?Jn9XNOi6lSXSEmqCxa43GgaG7bZMl4CMjzby8lyMZN6HOqymFogz5rJx3lO0?=
 =?us-ascii?Q?sIUP26Iws+MV9cC1wGGyNkk6b2zC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:39:39.9308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa8254e-2bbc-4802-b56d-08dce29c3a4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For vcn 4_0, add ip_block for each vcn instance during discovery stage.

And only powering on/off one of the vcn instance using the
instance value stored in ip_block, instead of powering on/off all
vcn instances. Modify the existing functions to use the instance value
in ip_block, and remove the original for loop for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 532 +++++++++---------
 2 files changed, 265 insertions(+), 270 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 78b673b3ec6f..8d8107241a5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2346,7 +2346,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 0):
 		case IP_VERSION(4, 0, 2):
 		case IP_VERSION(4, 0, 4):
-			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add_instance(adev, &vcn_v4_0_ip_block, i);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
 			break;
 		case IP_VERSION(4, 0, 3):
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 50198b72e579..4c774255b0fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -172,7 +172,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r;
+	int inst = ip_block->instance, r;
+
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
@@ -186,45 +187,43 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
-		if (i == 0)
-			atomic_set(&adev->vcn.inst[i].sched_score, 1);
-		else
-			atomic_set(&adev->vcn.inst[i].sched_score, 0);
+	/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
+	if (inst == 0)
+		atomic_set(&adev->vcn.inst[inst].sched_score, 1);
+	else
+		atomic_set(&adev->vcn.inst[inst].sched_score, 0);
 
-		/* VCN UNIFIED TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
-		if (r)
-			return r;
+	/* VCN UNIFIED TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
 
-		/* VCN POISON TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].ras_poison_irq);
-		if (r)
-			return r;
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
+	if (r)
+		return r;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		ring->use_doorbell = true;
-		if (amdgpu_sriov_vf(adev))
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
-		else
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
-		ring->vm_hub = AMDGPU_MMHUB0(0);
-		sprintf(ring->name, "vcn_unified_%d", i);
-
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-						AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
-		if (r)
-			return r;
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	ring->use_doorbell = true;
+	if (amdgpu_sriov_vf(adev))
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + inst * (adev->vcn.num_enc_rings + 1) + 1;
+	else
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * inst;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	sprintf(ring->name, "vcn_unified_%d", inst);
 
-		vcn_v4_0_fw_shared_init(adev, i);
-	}
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
+					AMDGPU_RING_PRIO_0, &adev->vcn.inst[inst].sched_score);
+	if (r)
+		return r;
 
+	vcn_v4_0_fw_shared_init(adev, inst);
+done:
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1085,178 +1084,176 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
  *
  * Start VCN block
  */
-static int vcn_v4_0_start(struct amdgpu_device *adev)
+static int vcn_v4_0_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r;
+	int j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, 1);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v4_0_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
+	}
+
+	/* disable VCN power gating */
+	vcn_v4_0_disable_static_power_gating(adev, inst);
+
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
+
+	/*SW clock gating */
+	vcn_v4_0_disable_clock_gating(adev, inst);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
+			~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
+			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
+			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, inst, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXA0,
+			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+			 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+			 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXB0,
+			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+			 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+			 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUX,
+			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+			 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_mc_resume(adev, inst);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, inst, regUVD_STATUS);
+			if (status & 2)
+				break;
+			mdelay(10);
+			if (amdgpu_emu_mode == 1)
+				msleep(1);
 		}
 
-		/* disable VCN power gating */
-		vcn_v4_0_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
-				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
-				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
-				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
-				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
-				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
-				adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-				if (amdgpu_emu_mode == 1)
-					msleep(1);
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status & 2) {
+				r = 0;
+				break;
 			}
+		} else {
+			r = 0;
+			if (status & 2)
+				break;
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status & 2) {
-					r = 0;
-					break;
-				}
-			} else {
-				r = 0;
-				if (status & 2)
-					break;
-
-				dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+			dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", inst);
+			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+						UVD_VCPU_CNTL__BLK_RST_MASK,
 						~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+					~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-				mdelay(10);
-				r = -1;
-			}
-		}
-
-		if (r) {
-			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
-			return r;
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
-				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
-
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
-				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB1_DB_CTRL__EN_MASK);
-
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
-		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+	if (r) {
+		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", inst);
+		return r;
 	}
 
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
+			UVD_MASTINT_EN__VCPU_EN_MASK,
+			~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
+			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
+			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+			VCN_RB1_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, regUVD_RB_SIZE, ring->ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, inst, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
 	return 0;
 }
 
@@ -1545,81 +1542,79 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  *
  * Stop VCN block
  */
-static int vcn_v4_0_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_stop_dpg_mode(adev, i);
-			continue;
-		}
-
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
-
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
-
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
-
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
-				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~(UVD_VCPU_CNTL__CLK_EN_MASK));
-
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_stop_dpg_mode(adev, inst);
+		goto done;
+	}
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		/* apply HW clock gating */
-		vcn_v4_0_enable_clock_gating(adev, i);
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* enable VCN power gating */
-		vcn_v4_0_enable_static_power_gating(adev, i);
-	}
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
+			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+
+	/* clear status */
+	WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
+
+	/* apply HW clock gating */
+	vcn_v4_0_enable_clock_gating(adev, inst);
+
+	/* enable VCN power gating */
+	vcn_v4_0_enable_static_power_gating(adev, inst);
+done:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, inst);
 
 	return 0;
 }
@@ -2041,29 +2036,28 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i = ip_block->instance;
 	int ret;
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		/* for SRIOV, guest should not control VCN Power-gating
-		* MMSCH FW should control Power-gating and clock-gating
-		* guest should avoid touching CGC and PG
-		*/
-		if (amdgpu_sriov_vf(adev)) {
-			adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
-			return 0;
-		}
+	/* for SRIOV, guest should not control VCN Power-gating
+	* MMSCH FW should control Power-gating and clock-gating
+	* guest should avoid touching CGC and PG
+	*/
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
 
-		if (state == adev->vcn.cur_state[i])
-			return 0;
+	if (state == adev->vcn.cur_state[i])
+		return 0;
 
-		if (state == AMD_PG_STATE_GATE)
-			ret = vcn_v4_0_stop(adev);
-		else
-			ret = vcn_v4_0_start(adev);
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_stop(adev, i);
+	else
+		ret = vcn_v4_0_start(adev, i);
 
-		if (!ret)
-			adev->vcn.cur_state[i] = state;
-	}
+	if (!ret)
+		adev->vcn.cur_state[i] = state;
 
 	return ret;
 }
-- 
2.34.1

