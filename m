Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1B1ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7CF10F312;
	Mon, 29 Aug 2022 14:31:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC9E10F2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnYpDsbwp1OwNf5E6j49KvKQ4F4qc8WU+SVwLzOaygiTqdpJIweHGYGfUoRG9jplL0NUkci0sAVVS2GVI6CQ6QSVGYKb03Zw+5hMvHIigbecGxOVHwY87z66jmgfCWuV/YXMPg2RYH++b0yZAQimmMV5U8W6aHGzQZWTqIPhiaIEaQ+6+Sa8HY0TN1C/IOhPSNH3b1hi2RMoFo8waNzY4AwiQLzUf/dVoVzKMb+oSiXyntS8CrdaxVAJCQDsHLkj2VTAekU5nDLiSeZUnmTAquYwmpCd0VOyjQZAuxhPX2wOr5lvVA8xhcR4LJfEJMCWYKJSZtZP7/Puw3iA5qSVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO0qO7ZuxJs5v1d3xp+rRmvDkpseOQ0HOYRWeX5wNtA=;
 b=jYlJKyvsEO/Hw61nwFXeQcTD9O0Lu5hyg2N0/7W/dZ/FzXuSVZTpAXe5iY2qfNia/bX6DFyGw2npgGj01+N4/GfAkZXO1a6Ycz7aPL0EDrrS2eWyu3PnipvPHx71mAlu+ztwNWqTmajk9RDBeFIU9NpM0LC5g+8X2LgToiCpfWml1jIFC5ix4qDvueRBaHB1S6ZXHh/m5UJPJAvnm9GLakrw63aCb9Zvevkpprfjh1dzSVvVeMJoaoVZDDtnHF9HXTpysRdozGlRb29B9EPYDMnUSvwPkbRjHBsVYLB0mRBYiyLwoHM+K/u2gXS1XVo8LmXnzwFHpX7thJWGdYJPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO0qO7ZuxJs5v1d3xp+rRmvDkpseOQ0HOYRWeX5wNtA=;
 b=GX4cmeMozXu2a6b30vGiJ1PDQHEDc7iZ5TZqzqDfivnC2bznzqadSMDPL/oK7kdZfzsHP9XzImPFas9A/p9xkK+o1/cpOKvaJ1XG00cvOk0ZpGPWjHQktoTTopLYSCPTbZ7Qp7XQmkUtbKwudVERVIekHrqf590n11eZbP6eMFU=
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by CY4PR1201MB0054.namprd12.prod.outlook.com (2603:10b6:910:1a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 14:31:09 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c2) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:09 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:45 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/29] drm/amdgpu: add configurable grace period for unmap
 queues
Date: Mon, 29 Aug 2022 10:30:07 -0400
Message-ID: <20220829143026.1509027-11-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00dbdb28-7b8b-4532-ba1a-08da89cb1db9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0054:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSPCN8/pTkBlw/M/ndNFCeeK3avMafIsrDOLh3QU/GtF6wJP7x6TUZA1tqXYBuRGRsM5oaIHGkV392eBga7zNfTQp9ayksff/MM1mhf6KDHQ+LOizCOc7vJEu4bSt4X0Bq71NIxMZ/WMu6Qrazth4QGP6u88jX3KjoxjiovnGaJIeQgsxVuY7ZB8tmD6uEXUTdPRZ8HXfvNnu3+cYuFBcJTSUWdgOkxx+iFinVtxEIK6FVHXs/aFVZjmjeZw8CmJw32z0uJcUeefYDRvLP7kvktGGXyvQxZOJA84x+yFrdThdxqsokT53TP8NpU5MhvUeQLl9cjFaa3ZwxsuqKr2bdUmVBIdWSe523Ym22FeCTr+Oa99fBOVKORKCoeTOoxHq4o15UKteAA2B1NmI+Nw6UF7p0dhRVPCUie3jldak3wTZ/6d2UmqPei3WTNp2CyP80/vqaYSJdB4E+T6OEv678V243bJQjQX8ji8U4vXWVMlbLJXwokq+DF17QhvF93nn4PVCttmAUwPZ8O/HFXEpB8dEPwhqNTWV081vq0IezQ4ysy/epjcDO8q/bZjT+DtTocvWrJPb8EG/ohfpjrTSeU4E1Wthwc8FU3iN8xfmN5HDGskDAhcnXl4k5jRP4HH2xmePf/5TOyQIpcnnIY5qpDs/G6GhIgiOqEcLmbdHYFd6Nd5QUvr3QvRcYnkVruP8ARgvTkTvwzbLr3058B97CJAuY0TMY7P2Jp/Bd2DKFb9KtJjIX7ZcUrbR22jx5025XW7C4ab372YLppOtn7bZsOPHSJoZzgG3Jwe/ga1W671Mg3khIMnLH6MV8BoyXQ9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(40470700004)(46966006)(4326008)(70206006)(316002)(70586007)(6916009)(54906003)(82310400005)(8676002)(40460700003)(40480700001)(36860700001)(8936002)(5660300002)(2906002)(81166007)(356005)(82740400003)(44832011)(30864003)(36756003)(6666004)(7696005)(26005)(86362001)(478600001)(41300700001)(1076003)(16526019)(2616005)(186003)(426003)(83380400001)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:09.4549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dbdb28-7b8b-4532-ba1a-08da89cb1db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0054
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The HWS schedule allows a grace period for wave completion prior to
preemption but the debugger requires good performance since it preempts
on every HW debug mode setting transaction request.

For good performance, allow immediate preemption by setting the grace
period to 0.

Note that setting the preepmtion grace period to 0 will result in an
infinite grace period being set due to a CP FW bug so set it to 1 for now.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 43 ++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  6 ++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 43 ++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  9 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 61 ++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 32 +++++++++
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 39 +++++++++++
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   | 65 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 ++
 13 files changed, 291 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 42491a31f352..c9629fc5460c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -73,5 +73,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
 	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
+	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
+	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 13f02a0aa828..60a204f767ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -397,6 +397,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 				kgd_gfx_v9_set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_arcturus_enable_debug_trap,
 	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
+	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
+	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index c09b45de02d0..2491402afd58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -801,6 +801,47 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
 	return 0;
 }
 
+/* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
+ * The values read are:
+ *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
+ *     atomic_offload_wait_time -- Wait Count for L2 and GDS Atomics Offloads.
+ *     wrm_offload_wait_time    -- Wait Count for WAIT_REG_MEM Offloads.
+ *     gws_wait_time            -- Wait Count for Global Wave Syncs.
+ *     que_sleep_wait_time      -- Wait Count for Dequeue Retry.
+ *     sch_wave_wait_time       -- Wait Count for Scheduling Wave Message.
+ *     sem_rearm_wait_time      -- Wait Count for Semaphore re-arm.
+ *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
+ */
+void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
+					uint32_t *wait_times)
+
+{
+	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
+}
+
+void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
+						uint32_t wait_times,
+						uint32_t grace_period,
+						uint32_t *reg_offset,
+						uint32_t *reg_data)
+{
+	*reg_data = wait_times;
+
+	/*
+	 * The CP cannont handle a 0 grace period input and will result in
+	 * an infinite grace period being set so set to 1 to prevent this.
+	 */
+	if (grace_period == 0)
+		grace_period = 1;
+
+	*reg_data = REG_SET_FIELD(*reg_data,
+			CP_IQ_WAIT_TIME2,
+			SCH_WAVE,
+			grace_period);
+
+	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
+}
+
 static void program_trap_handler_settings(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
 {
@@ -845,5 +886,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
+	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
+	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 370d6c312981..0abc1e805180 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -26,3 +26,9 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
 uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
 					bool keep_trap_enabled,
 					uint32_t vmid);
+void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
+void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
+					       uint32_t wait_times,
+					       uint32_t grace_period,
+					       uint32_t *reg_offset,
+					       uint32_t *reg_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 73e3b9ae1fb0..c57f2a6b6e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -670,6 +670,8 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info = get_atc_vmid_pasid_mapping_info_v10_3,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
 	.program_trap_handler_settings = program_trap_handler_settings_v10_3,
+	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
+	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e1aac6f6d369..673c99c5523d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -724,6 +724,24 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
 	return 0;
 }
 
+/* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
+ * The values read are:
+ *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
+ *     atomic_offload_wait_time -- Wait Count for L2 and GDS Atomics Offloads.
+ *     wrm_offload_wait_time    -- Wait Count for WAIT_REG_MEM Offloads.
+ *     gws_wait_time            -- Wait Count for Global Wave Syncs.
+ *     que_sleep_wait_time      -- Wait Count for Dequeue Retry.
+ *     sch_wave_wait_time       -- Wait Count for Scheduling Wave Message.
+ *     sem_rearm_wait_time      -- Wait Count for Semaphore re-arm.
+ *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
+ */
+void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
+					uint32_t *wait_times)
+
+{
+	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
+}
+
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t page_table_base)
 {
@@ -908,6 +926,29 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 				adev->gfx.cu_info.max_waves_per_simd;
 }
 
+void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
+		uint32_t wait_times,
+		uint32_t grace_period,
+		uint32_t *reg_offset,
+		uint32_t *reg_data)
+{
+	*reg_data = wait_times;
+
+	/*
+	 * The CP cannont handle a 0 grace period input and will result in
+	 * an infinite grace period being set so set to 1 to prevent this.
+	 */
+	if (grace_period == 0)
+		grace_period = 1;
+
+	*reg_data = REG_SET_FIELD(*reg_data,
+			CP_IQ_WAIT_TIME2,
+			SCH_WAVE,
+			grace_period);
+
+	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
+}
+
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
                         uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
 {
@@ -951,6 +992,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
 	.enable_debug_trap = kgd_gfx_v9_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
+	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
+	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index d39256162616..c0866497cb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -20,8 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-
-
 void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmid,
 		uint32_t sh_mem_config,
 		uint32_t sh_mem_ape1_base, uint32_t sh_mem_ape1_limit,
@@ -51,7 +49,6 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 					uint32_t sq_cmd);
 bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid);
-
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t page_table_base);
 void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
@@ -67,3 +64,9 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
 uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
 					bool keep_trap_enabled,
 					uint32_t vmid);
+void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
+void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
+					       uint32_t wait_times,
+					       uint32_t grace_period,
+					       uint32_t *reg_offset,
+					       uint32_t *reg_data);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index cfb08db293eb..fc4362506119 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -46,10 +46,13 @@ static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
 
 static int execute_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
-				uint32_t filter_param);
+				uint32_t filter_param,
+				uint32_t grace_period);
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
-				uint32_t filter_param, bool reset);
+				uint32_t filter_param,
+				uint32_t grace_period,
+				bool reset);
 
 static int map_queues_cpsch(struct device_queue_manager *dqm);
 
@@ -837,7 +840,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) {
 		if (!dqm->dev->shared_resources.enable_mes)
 			retval = unmap_queues_cpsch(dqm,
-						    KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false);
+						    KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 		else if (prev_active)
 			retval = remove_queue_mes(dqm, q, &pdd->qpd);
 
@@ -1013,7 +1016,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		retval = execute_queues_cpsch(dqm,
 					      qpd->is_debug ?
 					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
-					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
+					      USE_DEFAULT_GRACE_PERIOD);
 
 out:
 	dqm_unlock(dqm);
@@ -1153,7 +1157,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	}
 	if (!dqm->dev->shared_resources.enable_mes)
 		retval = execute_queues_cpsch(dqm,
-					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 	qpd->evicted = 0;
 	eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
 	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
@@ -1493,6 +1497,9 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 
+	if (dqm->dev->kfd2kgd->get_iq_wait_times)
+		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
+					&dqm->wait_times);
 	return 0;
 }
 
@@ -1532,7 +1539,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	dqm->is_resetting = false;
 	dqm->sched_running = true;
 	if (!dqm->dev->shared_resources.enable_mes)
-		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1557,7 +1564,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 
 	if (!dqm->is_hws_hang) {
 		if (!dqm->dev->shared_resources.enable_mes)
-			unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, false);
+			unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 		else
 			remove_all_queues_mes(dqm);
 	}
@@ -1599,7 +1606,8 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
 	list_add(&kq->list, &qpd->priv_queue_list);
 	increment_queue_count(dqm, qpd, kq->queue);
 	qpd->is_debug = true;
-	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
+			USE_DEFAULT_GRACE_PERIOD);
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1613,7 +1621,8 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 	list_del(&kq->list);
 	decrement_queue_count(dqm, qpd, kq->queue);
 	qpd->is_debug = false;
-	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
+			USE_DEFAULT_GRACE_PERIOD);
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
 	 * type.
@@ -1690,7 +1699,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 
 		if (!dqm->dev->shared_resources.enable_mes)
 			retval = execute_queues_cpsch(dqm,
-					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 		else
 			retval = add_queue_mes(dqm, q, qpd);
 		if (retval)
@@ -1779,7 +1788,9 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 /* dqm->lock mutex has to be locked before calling this function */
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
-				uint32_t filter_param, bool reset)
+				uint32_t filter_param,
+				uint32_t grace_period,
+				bool reset)
 {
 	int retval = 0;
 	struct mqd_manager *mqd_mgr;
@@ -1791,6 +1802,12 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (!dqm->active_runlist)
 		return retval;
 
+	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
+		retval = pm_update_grace_period(&dqm->packet_mgr, grace_period);
+		if (retval)
+			return retval;
+	}
+
 	retval = pm_send_unmap_queue(&dqm->packet_mgr, filter, filter_param, reset);
 	if (retval)
 		return retval;
@@ -1823,6 +1840,13 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		return -ETIME;
 	}
 
+	/* We need to reset the grace period value for this device */
+	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
+		if (pm_update_grace_period(&dqm->packet_mgr,
+					USE_DEFAULT_GRACE_PERIOD))
+			pr_err("Failed to reset grace period\n");
+	}
+
 	pm_release_ib(&dqm->packet_mgr);
 	dqm->active_runlist = false;
 
@@ -1838,7 +1862,7 @@ static int reset_queues_cpsch(struct device_queue_manager *dqm,
 	dqm_lock(dqm);
 
 	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
-			pasid, true);
+			pasid, USE_DEFAULT_GRACE_PERIOD, true);
 
 	dqm_unlock(dqm);
 	return retval;
@@ -1847,13 +1871,14 @@ static int reset_queues_cpsch(struct device_queue_manager *dqm,
 /* dqm->lock mutex has to be locked before calling this function */
 static int execute_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
-				uint32_t filter_param)
+				uint32_t filter_param,
+				uint32_t grace_period)
 {
 	int retval;
 
 	if (dqm->is_hws_hang)
 		return -EIO;
-	retval = unmap_queues_cpsch(dqm, filter, filter_param, false);
+	retval = unmap_queues_cpsch(dqm, filter, filter_param, grace_period, false);
 	if (retval)
 		return retval;
 
@@ -1911,7 +1936,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		if (!dqm->dev->shared_resources.enable_mes) {
 			decrement_queue_count(dqm, qpd, q);
 			retval = execute_queues_cpsch(dqm,
-						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
+						      USE_DEFAULT_GRACE_PERIOD);
 			if (retval == -ETIME)
 				qpd->reset_wavefronts = true;
 		} else {
@@ -2196,7 +2222,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	}
 
 	if (!dqm->dev->shared_resources.enable_mes)
-		retval = execute_queues_cpsch(dqm, filter, 0);
+		retval = execute_queues_cpsch(dqm, filter, 0, USE_DEFAULT_GRACE_PERIOD);
 
 	if ((!dqm->is_hws_hang) && (retval || qpd->reset_wavefronts)) {
 		pr_warn("Resetting wave fronts (cpsch) on dev %p\n", dqm->dev);
@@ -2540,7 +2566,8 @@ int dqm_debugfs_hang_hws(struct device_queue_manager *dqm)
 		return r;
 	}
 	dqm->active_runlist = true;
-	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
+				0, USE_DEFAULT_GRACE_PERIOD);
 	dqm_unlock(dqm);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index a537b9ef3e16..fb48b124161f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -37,6 +37,7 @@
 
 #define KFD_MES_PROCESS_QUANTUM		100000
 #define KFD_MES_GANG_QUANTUM		10000
+#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
 
 struct device_process_node {
 	struct qcm_process_device *qpd;
@@ -256,6 +257,7 @@ struct device_queue_manager {
 	struct work_struct	hw_exception_work;
 	struct kfd_mem_obj	hiq_sdma_mqd;
 	bool			sched_running;
+	uint32_t		wait_times;
 };
 
 void device_queue_manager_init_cik(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index ed02b6d8bf63..c57f9a46dfcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -369,6 +369,38 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 	return retval;
 }
 
+int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
+{
+	int retval = 0;
+	uint32_t *buffer, size;
+
+	size = pm->pmf->set_grace_period_size;
+
+	mutex_lock(&pm->lock);
+
+	if (size) {
+		kq_acquire_packet_buffer(pm->priv_queue,
+			size / sizeof(uint32_t),
+			(unsigned int **)&buffer);
+
+		if (!buffer) {
+			pr_err("Failed to allocate buffer on kernel queue\n");
+			retval = -ENOMEM;
+			goto out;
+		}
+
+		retval = pm->pmf->set_grace_period(pm, buffer, grace_period);
+		if (!retval)
+			kq_submit_packet(pm->priv_queue);
+		else
+			kq_rollback_packet(pm->priv_queue);
+	}
+
+out:
+	mutex_unlock(&pm->lock);
+	return retval;
+}
+
 int pm_send_unmap_queue(struct packet_manager *pm,
 			enum kfd_unmap_queues_filter filter,
 			uint32_t filter_param, bool reset)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 18250845a989..f0cdc8695b8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -251,6 +251,41 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 	return 0;
 }
 
+static int pm_set_grace_period_v9(struct packet_manager *pm,
+		uint32_t *buffer,
+		uint32_t grace_period)
+{
+	struct pm4_mec_write_data_mmio *packet;
+	uint32_t reg_offset = 0;
+	uint32_t reg_data = 0;
+
+	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
+			pm->dqm->dev->adev,
+			pm->dqm->wait_times,
+			grace_period,
+			&reg_offset,
+			&reg_data);
+
+	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
+		reg_data = pm->dqm->wait_times;
+
+	packet = (struct pm4_mec_write_data_mmio *)buffer;
+	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
+
+	packet->header.u32All = pm_build_pm4_header(IT_WRITE_DATA,
+					sizeof(struct pm4_mec_write_data_mmio));
+
+	packet->bitfields2.dst_sel  = dst_sel___write_data__mem_mapped_register;
+	packet->bitfields2.addr_incr =
+			addr_incr___write_data__do_not_increment_address;
+
+	packet->bitfields3.dst_mmreg_addr = reg_offset;
+
+	packet->data = reg_data;
+
+	return 0;
+}
+
 static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			enum kfd_unmap_queues_filter filter,
 			uint32_t filter_param, bool reset)
@@ -333,6 +368,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
+	.set_grace_period       = pm_set_grace_period_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process),
@@ -340,6 +376,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
+	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
@@ -350,6 +387,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
+	.set_grace_period       = pm_set_grace_period_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process_aldebaran),
@@ -357,6 +395,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
+	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index a666710ed403..795001c947e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -583,6 +583,71 @@ struct pm4_mec_release_mem {
 
 #endif
 
+#ifndef PM4_MEC_WRITE_DATA_DEFINED
+#define PM4_MEC_WRITE_DATA_DEFINED
+
+enum WRITE_DATA_dst_sel_enum {
+	dst_sel___write_data__mem_mapped_register = 0,
+	dst_sel___write_data__tc_l2 = 2,
+	dst_sel___write_data__gds = 3,
+	dst_sel___write_data__memory = 5,
+	dst_sel___write_data__memory_mapped_adc_persistent_state = 6,
+};
+
+enum WRITE_DATA_addr_incr_enum {
+	addr_incr___write_data__increment_address = 0,
+	addr_incr___write_data__do_not_increment_address = 1
+};
+
+enum WRITE_DATA_wr_confirm_enum {
+	wr_confirm___write_data__do_not_wait_for_write_confirmation = 0,
+	wr_confirm___write_data__wait_for_write_confirmation = 1
+};
+
+enum WRITE_DATA_cache_policy_enum {
+	cache_policy___write_data__lru = 0,
+	cache_policy___write_data__stream = 1
+};
+
+
+struct pm4_mec_write_data_mmio {
+	union {
+		union PM4_MES_TYPE_3_HEADER header;     /*header */
+		unsigned int ordinal1;
+	};
+
+	union {
+		struct {
+			unsigned int reserved1:8;
+			unsigned int dst_sel:4;
+			unsigned int reserved2:4;
+			unsigned int addr_incr:1;
+			unsigned int reserved3:2;
+			unsigned int resume_vf:1;
+			unsigned int wr_confirm:1;
+			unsigned int reserved4:4;
+			unsigned int cache_policy:2;
+			unsigned int reserved5:5;
+		} bitfields2;
+		unsigned int ordinal2;
+	};
+
+	union {
+		struct {
+			unsigned int dst_mmreg_addr:18;
+			unsigned int reserved6:14;
+		} bitfields3;
+		unsigned int ordinal3;
+	};
+
+	uint32_t reserved7;
+
+	uint32_t data;
+
+};
+
+#endif
+
 enum {
 	CACHE_FLUSH_AND_INV_TS_EVENT = 0x00000014
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3ea61fa1db52..a851f814bc9d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1300,6 +1300,8 @@ struct packet_manager_funcs {
 	int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
 			enum kfd_unmap_queues_filter mode,
 			uint32_t filter_param, bool reset);
+	int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
+			uint32_t grace_period);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
 			uint64_t fence_address,	uint64_t fence_value);
 	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
@@ -1310,6 +1312,7 @@ struct packet_manager_funcs {
 	int set_resources_size;
 	int map_queues_size;
 	int unmap_queues_size;
+	int set_grace_period_size;
 	int query_status_size;
 	int release_mem_size;
 };
@@ -1332,6 +1335,8 @@ int pm_send_unmap_queue(struct packet_manager *pm,
 
 void pm_release_ib(struct packet_manager *pm);
 
+int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period);
+
 /* Following PM funcs can be shared among VI and AI */
 unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size);
 
-- 
2.25.1

