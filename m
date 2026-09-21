Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3A9C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 14:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6976610E851;
	Mon, 21 Sep 2026 14:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CDQW3QAA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BBFD10E32D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXk9l5DcixkaVkyUMX0E0KBsHbUl9j9P0mBHpfRQL1yjaFRQmxrEELu/VuYLS15uEZJnfiodcqfOrjzec2wO3wbE6e4AcVqEmG+Yi6260hJg5QJbOLQSzS+gZXyfP7C9d07HlcyxAB3Cyd2ewWQqJn2UiJNqIla4XOOtdeh8jVWnX5E7ienk8+EMjDRxk9Ig3qnXX7lrTFfnljVrWIGRvn8f+R1xl0IGXV1PusZES/7YC9qBiuZu3PBe14MbIvX8TpLIPNrMCOnbAFaHYmWHMJiPlOuJeIu/PxTAlSfXWNkXm4GnkcFBKFUCdEKpWIvup5NgQ559rSiUioXnOyew+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONZknGrvAsGKTWsc0e19QN4LE/3cUjfGCw4SAYBeoVk=;
 b=thTRr5ATikAbBFy1cKtjvMJTFULF6swo1ZUPLwtFLOjvwLuRU7NVeRWh1H+pq4DO1rDDYAj73PBepwH4CJHzIcdCc8tN4MKht95COQJa44VgsIkxf1kuEbt8CuMzU4bjtKMRGPHy+N89PiqYr+G21g2BiblHwz8fLwGQY7Ussn8md59GQikGkENIJl8Vg4NIRSJApmSnaSc8KVuFutC3crbs+NARxejPARoiBBMbwOjDYdrcrrhwGK559Ack3XutjPyhYzyqxFrmSwUa4eE7GwboSyljRJokaWYbr5Nun5GoR0SqAS6FNat3ZOOHGtffw+Nc0QBrCUY03uxIOmBYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONZknGrvAsGKTWsc0e19QN4LE/3cUjfGCw4SAYBeoVk=;
 b=CDQW3QAAbNg3PS2qReHk049fy7IkIMOqpCdr9rfa64fqCBnyg7zXVyp+dhSPXfJ6wjdam6BZtOhT9rdXwDhLsvifB4BWHXEU8LEE1nimY28bQ+u5cfb6fW1jmOz+t7A//BgVdjiPOpA8ZWREjyu3yhwS/LPyUfQLJTZhjkT1bkc=
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:38:25 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::a1) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 14:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 14:38:24 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 09:38:23 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: wire mes_dbgext on gfx11 and gfx12
Date: Mon, 21 Sep 2026 10:38:04 -0400
Message-ID: <20260921143804.3698840-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bd1e66-432c-4431-e691-08df17edfdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Rp8ktg/SVzQjSsuElN6CS57Hlwedayn0GntT8Dm5cG+7tG9VcBvUvHCZeCjzBVLFIMWd2yfiCFoul2y0QdqRomIsDtK+l9FmoXbse2JKYCg38OQATFNGYTrg1pwo8TpUogPUzws3TpgiPweZDIr4n36WqS63a/y5Wi741g93nUJ5PmcEeJKUCWEhcBp1K/2zOXNySW/AyuPNOFn/CAppHtQPfVixylIHloiQEq+u8flPvj5dK1uVyddI4Xgny37R2/jbfZWxwiNCc1NL3QZvW5TzJgS70HGpYLJggYq1r/Rk/VtKvNFW4xTy+buw11D5cRtPetWg37Yd/gxf/GEwyse3hhokgBEX4RSz45xAEUSUX27zmscZpe8qoOmoc/TJcqMQqIxTkvtPVVbOVFPhxT8S11rBob7SDphE+iCNrpFxjBDURSLotpCjJaO8nN3UQ8AQOLWdy40rPddhbEWEJPznXWY+kNeC0qLIis3qCzNC4XeFZ94xt3DhXkThQ8SvPKmNvXKTZNj94PaZzfsyP8JfGEz/8fjXEYuUUVYuLWcL0C2tK1PC9rQVDFSuQ54sOuzj9Vxilkj0VNsSxup1IvtsleEJpoJ41bxqNe5+oENSwHEEtOsZWtV3PPQkQ88PyRRoVPlTtoQ7KZ5RL2Gk6TYlr/puI95BkKlIBU7i9j2UuxB8XD7euqnfVTf6ajcCFUGkq63l5fTtaZ137KfhZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YjbhRamRIy7zGABocGifAehZz+OMbI05RP/5VE+Bqz5fi1uTYl8UOu6x/Juv/VPiRTXSMN0Dsd5DM5SMIAbkgwTEgu86AX6sgqU0bC4E4OGwNsdwcHIsmpmXX4k6+QGyiybYJVPfXE3//f6IWqpaue8b0s8wdkx9yLZiCseQzQbpb7FE3Ou4UaTlgR/PrO1QVazE2IH+ZuT0iBNi/obYidWuiszzngw5lxt0D3D2rqzZggrSZLReKimJsWlL+syqvJR2R4B9Wjt3oTUJY3JiwFq+mTVLJ0Om8NuPd+w3EKLbQUfLDyAzA0mRXEgooWeTPpe7LC7dGC/cAPHytt7thKTz3vL3YE0r3hWCAfy5LGoXdHI4x1C5GhOhe2mwxD1sfObMmoFWq2sg96GpqgentH1haC8ChVzJToNJlOMe/gwAYS0dN/dSB4z+glXhShk5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:38:24.4143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bd1e66-432c-4431-e691-08df17edfdeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
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

Add the per-IP hardware wiring that drives the mes_dbgext core on gfx11
(mes_v11_0 / gfx_v11_0) and gfx12 (mes_v12_0 / gfx_v12_0): handle
MES_MISC_OP_SETUP_MES_DBGEXT in the misc-op path, unmask the MES debug
interrupt, select the flat (gfx11) or zoned (gfx12) buffer format in
sw_init(), start/stop the feature from hw_init()/hw_fini(), and drain
the log from the EOP interrupt handler while the feature is active.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 18 +++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 40 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 52 ++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a7ed4923857b..c14e2e0890ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6534,6 +6534,18 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: CP EOP\n");
 
+	/*
+	 * MES firmware debug-extension ("mes_dbgext") messages are delivered as
+	 * an EOP interrupt from the MES pipe (me 3), carrying MES_DBGMSG (type 7)
+	 * in the top 6 bits of the context word.  Route them to the mes_dbgext
+	 * drain instead of the (gfx/compute) EOP fence handling below.
+	 */
+	if (((entry->ring_id & 0x0c) >> 2) == 3 &&
+	    (entry->src_data[0] >> 26) == 7) {
+		amdgpu_mes_dbgext_notify(adev, entry->src_data[0]);
+		return 0;
+	}
+
 	if (!adev->gfx.disable_kq) {
 		u8 me_id = (entry->ring_id & 0x0c) >> 2;
 		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ec1e142549c5..9ba2846e48fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4871,6 +4871,24 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: CP EOP\n");
 
+	/*
+	 * MES firmware host interrupts - including the mes_dbgext debug-message
+	 * notification - are raised via the RS64 host-interrupt path (the
+	 * firmware triggers the CPC TIME_STAMP assertion).  Although the firmware
+	 * tags the cookie with src_id CP_GENERIC_INT (177), the CP actually
+	 * delivers this to the host IH as a CP EOP (src_id 181) on the MES
+	 * scheduler pipe (me 3) - so it arrives through the normal CP_EOP
+	 * registration, not a CP_GENERIC_INT one.  The gfx12 IH cookie does not
+	 * preserve the MES interrupt type, so when dbgext is active, drain on any
+	 * me3 EOP; draining is a no-op when the log buffer has no new data, and
+	 * returning early keeps it out of the (gfx/compute/userq) fence paths.
+	 */
+	if (adev->mes.dbgext_active &&
+	    ((entry->ring_id & 0x0c) >> 2) == 3) {
+		amdgpu_mes_dbgext_notify(adev, entry->src_data[0]);
+		return 0;
+	}
+
 	if (!adev->gfx.disable_kq) {
 		u8 me_id = (entry->ring_id & 0x0c) >> 2;
 		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 51bfb672bed7..4a5ed502cedc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -969,6 +969,13 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
 		misc_pkt.queue_sch_level = AMD_PRIORITY_LEVEL_NORMAL;
 		break;
+	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
+		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
+				input->setup_mes_dbgext.log_buffer_mc_addr;
+		misc_pkt.dbgext_init_data.u64_all =
+				input->setup_mes_dbgext.log_options;
+		break;
 	default:
 		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
 		return -EINVAL;
@@ -1144,6 +1151,32 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+/*
+ * Enable/disable delivery of the MES firmware host interrupts at the CP.  The
+ * MES firmware debug-message interrupt is delivered as a CP EOP from the MES
+ * pipe (me 3) and handled in gfx_v11_0_eop_irq(); it is gated by CPC_INT_CNTL
+ * in that ME/pipe context, selected via GRBM_GFX_CNTL.  Mirrors the Windows KMD
+ * MES interrupt-enable path.  Must run in process context (takes srbm_mutex).
+ */
+static int mes_v11_0_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	u32 cp_int_cntl;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+	cp_int_cntl = RREG32_SOC15(GC, 0, regCPC_INT_CNTL);
+	cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CPC_INT_CNTL,
+					TIME_STAMP_INT_ENABLE, enable ? 1 : 0);
+	WREG32_SOC15(GC, 0, regCPC_INT_CNTL, cp_int_cntl);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -1152,6 +1185,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.suspend_gang = mes_v11_0_suspend_gang,
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
+	.enable_dbgext_irq = mes_v11_0_enable_dbgext_irq,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
@@ -2049,6 +2083,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring[0].sched.ready = true;
 
+	amdgpu_mes_dbgext_start(adev);
+
 	return 0;
 
 failure:
@@ -2058,6 +2094,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	amdgpu_mes_dbgext_stop(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 9d220bff0f6f..363e1d6d3c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -910,6 +910,13 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
+		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
+				input->setup_mes_dbgext.log_buffer_mc_addr;
+		misc_pkt.dbgext_init_data.u64_all =
+				input->setup_mes_dbgext.log_options;
+		break;
 
 	default:
 		DRM_ERROR("unsupported misc op (%d)\n", input->op);
@@ -1213,6 +1220,45 @@ static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
 
 }
 
+/*
+ * Enable/disable delivery of the MES firmware host interrupts at the CP.  The
+ * MES firmware debug-message ("mes_dbgext") interrupt is delivered to the IH
+ * as a CP EOP (src_id 181) on the MES scheduler pipe (me 3) and handled in
+ * gfx_v12_0_eop_irq(); it is gated by CPC_INT_CNTL in the me3/MES pipe context,
+ * selected via GRBM_GFX_CNTL.  Must run in process context (takes srbm_mutex).
+ *
+ * Although the firmware C code passes Rs64HostIntrGeneric1IntEnable, the RS64
+ * library routine that actually raises the interrupt (AsmRs64SetHostIntr)
+ * hardcodes the TIME_STAMP assertion bit (CP_INT_STAT_DEBUG bit 26).  So
+ * TIME_STAMP_INT_ENABLE - not GENERIC1_INT_ENABLE - is the CPC_INT_CNTL bit
+ * that lets the CP forward the assertion to the host IH.  CPC_INT_CNTL is
+ * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1), matching
+ * the Windows/SR-IOV KMD path - setting it only on the scheduler pipe is not
+ * sufficient.
+ */
+static int mes_v12_0_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	u32 cp_int_cntl;
+	int pipe;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (pipe = 0; pipe < 2; pipe++) {
+		soc24_grbm_select(adev, 3, pipe, 0, 0);
+
+		cp_int_cntl = RREG32_SOC15(GC, 0, regCPC_INT_CNTL);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CPC_INT_CNTL,
+					    TIME_STAMP_INT_ENABLE, enable ? 1 : 0);
+		WREG32_SOC15(GC, 0, regCPC_INT_CNTL, cp_int_cntl);
+	}
+
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -1224,6 +1270,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
 	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
+	.enable_dbgext_irq = mes_v12_0_enable_dbgext_irq,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -2114,6 +2161,8 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring[0].sched.ready = true;
 
+	amdgpu_mes_dbgext_start(adev);
+
 	return 0;
 
 failure:
@@ -2123,6 +2172,9 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	amdgpu_mes_dbgext_stop(adev);
 	return 0;
 }
 
-- 
2.43.0

