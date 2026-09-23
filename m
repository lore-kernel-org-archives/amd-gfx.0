Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27AFC98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8E010E961;
	Wed, 23 Sep 2026 19:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t1j0HEkg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C132910E961
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsssRhyn7yCdrKQ/h587XLLMGKINEPxwVdm6uWGiPchO6kVntb0X2xQFQsYF03bxnuon/RGtPShZCsawm7QZOCkhx07tw8si7aYDuQWZ9S2Qn03rXkYWakrM1WwgRBr5q+LsxiarQhR9zSTYkAoKhQbM+MryQj/Xui8BXl4QxlSTclrR+39dm28OmuX6xgP58ajd6iUatrjy2g+/FP5iNoEiiobyGAd9IIWEUfXRykgCT5G4kFeBKpD64Scl09Ab5ZMPOplv6f3+2p98GD2c22BY8OpH9TcR10ABWJ6mE1pO0MO6Sdkah4/5Wf7Luv8m1timqnaS9+mJXjjT3OlbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hcoS5+DVCB4ny4qzL8wu/rgGWUEhaPih1gf3GMeIzY=;
 b=eqzO7/Q9BvGT7d1UPX4TGyBkAfp4Le2y2YU9EQYe9pmPeNTEH5cD+HPgViVNOYvO+QEe24G7C6rvCkVuaIwNDj8oOZDbVl6goJdSotMif2MrIw02GZiJPRIQdg3FPsCgImWiXc+dJlWrp6vZQ5s1UpZCx1XrXNvN8oQ0pLUoV3Oq8Ti7RpRoyG2dbIia0aqS/ZE7PlQAD5sRzIBxJnRv+pZNcnXkwWN6SbEtuNvgL0Fk8oWs1exgnLII7Mo8PQK5XGaUXDY45cdpyryLqVmuATgAI9b3qlea/40uJp4Qz5fiPSJSScNDpWqF7lzFEyQadUUp1NwQISw58Jbusn32JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hcoS5+DVCB4ny4qzL8wu/rgGWUEhaPih1gf3GMeIzY=;
 b=t1j0HEkgi9LgxGMHvJ6X7BcaC8RiTC0kWrPjUaS/y19gpEw+RH4b3qKLcKxZlHic+U+JQm3KRpvZy/1M4WeVTUKFNYHzTIhN99le/jh4yyGPZN6ZvRV2s8aVwD67f19BdY/Tgu6uxb5Kuq1RZuaEtKtHnbAfZ6wfUO0hE9TWQRs=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:19:38 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::3c) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 19:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:19:37 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 14:19:35 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: wire mes_dbgext on gfx11 and gfx12
Date: Wed, 23 Sep 2026 15:19:21 -0400
Message-ID: <20260923191921.977163-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: cfadd118-b799-43ee-3a76-08df19a79bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: oK1Xv+T8mwfihVKXGJOIEVvSlnuq9u5NTqwW4Ugip3BG9j+0dyBYboFV7PPkHOQSZA62JfyRkrHPjQsQ3RGGUneXft1eTE13TKkKoePtwYXBM+3QFg5O+b+AMArfY832DQEc/qoJ1pdhHBFCJ7oEAOUarJxBqHRzLC+qcnr6q06d4iNf7G0clrMq/VbTMw8V2dnLBPzZz7qRCiLHm/ScjGFJkepl8sab2RKBr0QyWOxTdGm2PeeA6CMJ0dsEzgBupJkK+HIrLuzIA5uarnJ5Dmo6nPe9tKt69XPSSPPIWGKPKqW6FXYrUX1ab2mlAoFI5WdFMDkEmlpnnh+C+tY5F5nuFsmsCMFVUg6yJXWFxrF2dsUc+tUWtjJtr1HnygxZ728N6XGBHXex706uJHO5IRosnrsXc4JQ2LetZD8G1FXyUP+GQ2RHUZtsP/GAe4vUhWpgj4SEccSXbCaKrfto+aSJXd6MbjtaUEWeGUo564XKZyovQ+uHXVMpX8leB0Num92gGczUV/18U648w6uxzlSZ5S4qp8GkSAXjqfhH3EL/SJcKk5y+D3bts31KCtGk/Ds4ZCAPVC9SKpdKZB10uwDQNJb3EmBVfvhCjIdPwbRYe23meVSNZ2QK6I9jwVjNuYI0FmGsOtriSIvvqHuPyA7cMM/IS0M/8FeR0BPhh0e8rkaq18k205izqmk5m+FlglswPzMlD6Epd21/0cJ/XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vncTP+G2K/Kb8lSsgf9WwRwMmSr5yhESDRjBPXOdWsOvSJwhlejLkVzJytedny3yxv1TWClZa4eIJAqV9/kxnEUMqQTB2ZOML7MjQkRaJ2IzCtohFQ1uQvd5KlLvprbho2NeLFzS94Fj0OEPMco9UB0urvIoCGOlMJyRW1I5u6DAYxpwkd1LmS/TT6NjNYBDdH84qlHpfEop4qW40ktkZaKaOMTqYrbNILo9Ad42v72AjFFyhKDlLhHoRgENgyLpsk9OVv5efuwr2rSB0Ae3HnnKiVj5l9/UXlgnOMPEVtrjsGTcnqu4ec+rEZ1+EjzMiPAyNwLiq3Ceb0DJNVX1dnki9biRF/EAtjiSKVfUG+y/bnV5uDDS0QWSeY+AfwxETpauyN3npBSTQeJdwB+zBIm6Fk/fpTzbMb/yS2AsiO5l5ah8Jz0nYqtwxdVIGaZE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:19:37.1096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfadd118-b799-43ee-3a76-08df19a79bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 23 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 23 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 40 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 52 ++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a7ed4923857b..8bef32528372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6534,6 +6534,29 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: CP EOP\n");
 
+	if (((entry->ring_id & 0x0c) >> 2) == 3) {
+		u32 type = amdgpu_mes_ih_int_type(doorbell_offset);
+
+		switch (type) {
+		case AMDGPU_MES_IH_INT_TYPE_DBGMSG:
+			/*
+			 * MES firmware debug-extension ("mes_dbgext")
+			 * messages are delivered as an EOP interrupt from
+			 * the MES pipe (me 3), carrying MES_DBGMSG (type 7)
+			 * in context dword bits 31:26.  Route them to the
+			 * mes_dbgext drain instead of the (gfx/compute) EOP
+			 * fence handling below.
+			 */
+			if (adev->mes.dbgext_active)
+				amdgpu_mes_dbgext_notify(adev, doorbell_offset);
+			break;
+		default:
+			/* other MES host interrupt types are not handled */
+			break;
+		}
+		return 0;
+	}
+
 	if (!adev->gfx.disable_kq) {
 		u8 me_id = (entry->ring_id & 0x0c) >> 2;
 		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ec1e142549c5..c53c3263ff00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4871,6 +4871,29 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: CP EOP\n");
 
+	if (((entry->ring_id & 0x0c) >> 2) == 3) {
+		u32 type = amdgpu_mes_ih_int_type(doorbell_offset);
+
+		switch (type) {
+		case AMDGPU_MES_IH_INT_TYPE_DBGMSG:
+			/*
+			 * MES firmware debug-extension ("mes_dbgext")
+			 * messages are delivered as an EOP interrupt from
+			 * the MES pipe (me 3), carrying MES_DBGMSG (type 7)
+			 * in context dword bits 31:26.  Route them to the
+			 * mes_dbgext drain instead of the (gfx/compute) EOP
+			 * fence handling below.
+			 */
+			if (adev->mes.dbgext_active)
+				amdgpu_mes_dbgext_notify(adev, doorbell_offset);
+			break;
+		default:
+			/* other MES host interrupt types are not handled */
+			break;
+		}
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

