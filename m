Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF467C54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D2610E1C8;
	Fri, 31 Jul 2026 06:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ib6pRE28";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C2410E1C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 06:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywCvSZCtklHw35OZmHNsxjja2TevlEXZiEsPc1nux3mz+6vemTEd0Mt5DtRqa2+Y5mvnGO5nVjidADZmhOEHZ6tVB/2fvk7g7OagZRznBAfTkTio5so99AiQOmRJsibuyFwJWJjV1wtQe2ZmWiEEW55OsqLBYHR2qDuU+WjYIDQQ7idUK1l15bRg6AYTHBIaDqUFhSZOiujBz2osFiXtmHADlLaBS3PfCbhsAV7HfdIFcWiD+qgNArxcwfflwFzg2oGtFOt8GwHK8oey7gjZWVkLjfhOM/DejQcmObHnRrwlhmWMsZI4AIrwzA71K701xWZ/iaUwOKqB8EZyr5CRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTZQp/mxsJFN+r1RNc5hdxL/zg7dy9oaI/tA84RHsII=;
 b=ky7kU3KclLoGU9BqxW80RSgk1qPxT4PyPesHWh582kSzMpgAfm4XeWOFVVRMLUL96gUvnh8u53XF13eTgivIO2J2F3Xs/6mstRXhkgRiDDenLz9ZwQvpp+l/njsRSciE76hXasK5xD2E15lDgl3m7JtJhAanh71lnKo2kaAq09cRBBtL6pwfnt3v72tfPmp6QY1B1f+hLXirxCjIahnCRi9UXy5nP0ZOXD0nuFWesy7YF0vEBFIRLPeFtBGny/RcSvME4RwDcsW/CYE66yGceBTrCKaBjuaIoBXg0noz1GHKIWQnGTkAcNl9MLb0cOtRr1gnJz5wfbB2f6dF1UlBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTZQp/mxsJFN+r1RNc5hdxL/zg7dy9oaI/tA84RHsII=;
 b=ib6pRE28GVk/zJG3vONV4rQ/lnSeKodd5LL2qFuAni6yK1WPz85l8Huoguk9b93NtnD3Ox7+QLQy6a1rDiAjz24kiXV7KVM/DrWmxbfrJ/QyO7k4eaKamEW/sa/YtO5Lc+v7j88TXT6UdD8pkBplsTo9moxrE1KXGbBBKTBiuwU=
Received: from SA1P222CA0086.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::27)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:31:43 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::a7) by SA1P222CA0086.outlook.office365.com
 (2603:10b6:806:35e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 06:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 06:31:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:31:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:31:42 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 01:31:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Mario Sopena-Novales <Mario.Novales@amd.com>
Subject: [PATCH v4 2/5] drm/amdgpu/gfx11: add priv-fault user-queue recovery
 worker
Date: Fri, 31 Jul 2026 14:29:54 +0800
Message-ID: <20260731063128.3026783-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
References: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be369f0-a8b6-4152-64e6-08deeecd6356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Eo9AUZrQUP/nqm5zeOJZDkH7mACsvg1+8/6OhJKZygm+XHTfx7u2jGoDC2q2ceBwSCJb9kFM/vg2TDL6kKA9fNtUnahFeLgEbmJ0CdRdoe9JFn6El2N2P+S3DTWnR2PGZ2z4pAi9dEhEJJ93iTaA2/G1SuiX66amyWgB5jj8r1JgCIcSYKfIePqUqOwG1vpPjobWzPYuuZtL8HEbI2dSlavg985IfKeXA6V13OhVt8tP0YATwv5zFxKBtpZzenkGvMXz1u01XVCWLwVGPOXYLoiP8eutXfk5+PwpUlFtZe03NU0Fa8dhdnij19glFszNA5sHwqdr3ATE69v3P2+uSOKXvb+wdbkYMkiNfPsIqwXQbJafQGEikVf3ml4a8t0Gax8QZvl5JKQ+heF4cdT0nAARtAWGtXOal25o+5bSdPJ0keNbdk4BtcfHG8vaN5rX6CJRMJTI6C14h7aCZduU2VqL5VKP/1NgAOTISXqxzhHMNYD/h37XNjSeb7ZPI9wOm+fabvyNQ9YMeuWJ1occStJjuHv+WE0Ie3Uty8dK8Ihukr/7F0Aiu6WFn1Ov++S4duK6iekMDIOY7IrFj4j/my3pDMrreo6mo8p2VJhgpSugC5iMCO2BRLZTPisKrlHc0F8AXTZPczPrvjZEJgqfmnOpw0Xf2Md5jMxlStCNhgR0jynRtheLiUea1yhoV4PrpV1sHXrlrPgl+42u4bLGcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lOsMnM5NGxLq7cGtuveox8DdbP6XCTzE9UFhOtd6lgLUKib5+eOwRrZHkkEnoRaH/hHKfF2QOprSWt1b/5rVw48PdJAAAGPCryMUYZ9EjPm+Dgsk7fMmZpMd8iVXzdsaoMeiCHuha/JWWZZKXqaTZSjAE2ZOmRSZyhgTmaXdLPaIZjlAe4YQY08vykB5RX5o/LI+tbP1SmJvtpZYgKvpuR1gu/39HlFY4UtezS5DoHpu+T4UR6t5d3nlYgbaiscS7u1u14msrxUQRM92JXO2pPgs9X8fdze8SRN8lDd2rJBlmeh4dSICt8hTMXy2wYJHJsrWV+XacglQW1sxTe4VYe5M3d5VNBKjJDnJVUCIzc3A8c72A9e2clvPTzXZ7clL+6Ig9KT5IcG29vfs5+3s6CGFpy4nhdI0gxKVYwsWjtIn5KkoAccMg4eeGAxG+iHj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:31:43.4844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be369f0-a8b6-4152-64e6-08deeecd6356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

A gfx user-queue priv/bad-op fault is raised by the ME and carries only
the HW slot, not the faulting queue's doorbell. Add a per-IP worker that
drains adev->gfx.userq_priv_fault_slots, reads the doorbell back from each
HQD via soc21_grbm_select (regCP_RB_DOORBELL_CONTROL), looks up the user
queue and kicks its per-queue reset.

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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9faf31421a15..69776dbe188d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -362,6 +362,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   bool all_hub, uint8_t dst_sel);
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1932,6 +1933,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
+	INIT_WORK(&adev->gfx.userq_priv_fault_work, gfx_v11_0_userq_priv_fault_work);
+
 	return 0;
 }
 
@@ -1969,6 +1972,8 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->gfx.userq_priv_fault_work);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -6711,6 +6716,40 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * A gfx exception IV carries no doorbell. For each faulted slot, read the
+ * doorbell back from the HQD (left in place by the fatal fault), look up the
+ * user queue and kick its per-queue reset.
+ */
+static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
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
+		soc21_grbm_select(adev, 0, pipe, queue, 0);
+		db_ctrl = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+		soc21_grbm_select(adev, 0, 0, 0, 0);
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
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-- 
2.49.0

