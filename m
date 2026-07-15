Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BE9C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 03:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC0D10E113;
	Wed, 15 Jul 2026 03:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHRSDbnY";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25BF810E113
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 03:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHGdu0eiky9Rb9+E3VDT9bS0G42VzXuzim7JCWlLpl8WGLp/yO/OfJ6XB4K7ycu+eQiGsBo41r4kkDC+ZYZSG+QLa3PUbJ58f38ott3sx2Uclds8bKuQkWXnfbbR6oOqkItgmV0LnPiUnRffT6WUPwZmCiJ4Z6PStHha+FyDH7rOOkQvqUsMbA4gYTRx+q0mwj69q9viFbwSdk7BYupAe+Jrw4y/PyoFzymkR5M90Q4w6FyGbZcABeOVeHwh69AuBBJHbWv/2u2mfM0MJR3x+uUTpX75BdZGiqKT2nGc+O744ZAVO5p5auunyAkZushzsPwMDWDiOAOUc4cQ/NpL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXi7e+ElT+uaSxZ/0A4nTMaJy4JUCpgGjF3d/b08rHU=;
 b=kjjeWQrBhOUhIRbu52br76jkgkMWtpjNqfaGDK0OajeODTZ1KxgVxRgDG7vPy8GBLOD9buIYXs0dzYPvZmR1lnqqnM4iq0fNsf95AG44uO+QLLnmbDvbZWq+yVsmAuIZgtW4MGoI6ci4fKfSw2VEytPXUB08wUj4WjyMUJhb5N5UIGJzeNixrFCOBLCWG/VkcqJiyJrjeEPsI8O2UwU6Qo2MAdolxI1WjfZRGdfe4sYGfTMN0YCRSU92cFxIdNvpJLsKUqC9t06arJlIQPZThoducBmnA5oEwyrdxZYEnE1wRmE55RllA0RBuVWh3csSXiEqEvEc3yYUqMhackrfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXi7e+ElT+uaSxZ/0A4nTMaJy4JUCpgGjF3d/b08rHU=;
 b=GHRSDbnYo6jPqBgsDv166qzDb78OPlVcnvkP6HlRcwuJjFYrEEA8kp1PToHLQUji6AOd985U7qEHggDPmdNeIb38RQPXOwa9QNzpfXBsRlsYM7a6Otpq7xwrVL0mld4EfEtOJLhFXI+KaLAgkEDa61JK9kA/fILsOYWWmr2IEjY=
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 03:02:40 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::8) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Wed, 15
 Jul 2026 03:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 03:02:39 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 22:02:37 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Add debug mask to disable CE logs for uniras
Date: Wed, 15 Jul 2026 11:02:29 +0800
Message-ID: <20260715030229.1050986-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: e028307b-0db6-4cc8-2531-08dee21d8813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: dIEh0kK03ctevFt6Hs50aZh4uKAJtSbwNcnCqDWQYpyINXGdbP/zIFB0cK+NGjyKAyA6ZWpAKNycb5f0XAroSlmM4P12Ch9jZ7vDQLWn7gnhhIR37fkU08caJXDLD8d23xRU9WAtXPPG8hGSNLjT1qu1Pp6EQBmsAk+eO8bX4a8tUN0mk3JhdI7b+unn58ogRvhv1liQqWEu8WgkkfF2Pcqh2WoQZuRgI0CAN0q+h0OFqEyTjE3201GL2+L4Y0Heqyh7V87gEpQ5liIeDtxFSl9u1LAMk6D8yEk7Fgz5tfqs2yQK1mHg4GSnMIcN73yldv3yyoYJV2ZDp/jNb0KEIO7+cxXoaDt31auJmvMS9qoDb7T+Z+DVyBw5zID+itCFuFOXH9sFb13awCMMm3/rhPZX0wbZ6OEL6Bnyfbol+6iPqdhYvHtJSTHDYrD79MGCwgy2b0kwBtlt5nxCq1fj0+cqoFNgAh7pvH+Gdk3yWOhPzoluCW/pOny6wVeXAyzG4zOp3whNExRDqo09FIM4/7GYSI6qJ2JQGIau++oIV0srZJz+PHesuDiHQ/XymPvurfRjp3x8CMFrvwnwOy05CeG0bv4kenRgHi48Gvjsdt29r3GxMTx/SL7pNXxC7XYT7yFfP+fAb3BBCyDlHFvt4BQyEprRwrxSzD9sMiVisiocvIOvTSxFEF7cfQ2OL2A8I+m6zA3eK3eEGjaCfhLqiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P4sk9y+CLzVjZzlCh84j/5B17BZng0pyjaGZDkw5BXyKC4ZLIUXoJRtLMkdlKk6Vg4s10IDK5biawCcjBFMDI9EbWCbMsPNUWwQ/eIC3hioBwp0Nv6I2ZZ46CMb5m4imhfpOcFvLqwoZ1h3xkd8x3DyWYv0LpjlEHN8qE4RLB/BDqABPgo8JGbDlAtKoH6ftayfLUJtNi6rSqegcV59D797owUSU3FjK70GgKVDLpiZjpWVP4jhRdhe8wmefctTktG0GPiIY4vgjTpMjn3Dv7DgtAD1DtBPzo0/5fffblsJvOxhRLfadDQuaMd67+zV3pfCGNZl+k2q4jog8agA6DU2qlMyhUU4cB0vAA/XZW761PQHxKvrNM7lY6lqfRSVUyJbJQH1HvpYEMcQyuN/w3gyyCzGg6rxQB0STOXblNiU+QNY28pyy0WjuqkVzsby7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 03:02:39.7678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e028307b-0db6-4cc8-2531-08dee21d8813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
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

Add debug mask to disable kernel logs of RAS correctable errors,
including both ACA and CE error counter kernel messages.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 12 ++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c        |  7 +++++++
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h   |  4 ++++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 10 ++++++++++
 6 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..2be008a9da6a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -437,6 +437,7 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 	ras_mgr->ras_is_ready = true;
 
 	amdgpu_enable_uniras(adev, true);
+	amdgpu_set_ce_log_state(adev);
 
 	RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
 	return 0;
@@ -510,6 +511,17 @@ const struct amdgpu_ip_block_version ras_v1_0_ip_block = {
 	.funcs = &ras_v1_0_ip_funcs,
 };
 
+void amdgpu_set_ce_log_state(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	bool disable_ce_log = !!adev->debug_disable_ce_logs;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return;
+
+	ras_core_set_ce_log_status(ras_mgr->ras_core, disable_ce_log);
+}
+
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index a20bb8fdce87..efbdb25241a3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -63,6 +63,7 @@ extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
 			struct amdgpu_device *adev);
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
+void amdgpu_set_ce_log_state(struct amdgpu_device *adev);
 bool amdgpu_uniras_enabled(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *data);
 int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *data);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 878dfdfcb18a..5911ce63f889 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -346,6 +346,7 @@ struct ras_core_context {
 	spinlock_t seqno_lock;
 
 	bool ras_core_enabled;
+	bool ras_core_ce_log_disabled;
 
 	u64 ras_fw_features;
 };
@@ -403,4 +404,6 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t addr);
 
 int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable);
+void ras_core_set_ce_log_status(struct ras_core_context *ras_core, bool disable);
+bool ras_core_get_ce_log_status(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index 67a35409ff0e..5a46a265e26d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -99,6 +99,8 @@ static void aca_report_ecc_info(struct ras_core_context *ras_core,
 	}
 
 	if (ecc_count.new_ce_count) {
+		if (ras_core_get_ce_log_status(ras_core))
+			return;
 		RAS_DEV_INFO(ras_core->dev,
 		"{%llu} socket: %d, die: %d, %u new correctable hardware errors detected in %s block\n",
 			seq_no, skt, aid, ecc_count.new_ce_count, blk_name(blk));
@@ -114,6 +116,11 @@ static void aca_bank_log(struct ras_core_context *ras_core,
 {
 	int i;
 
+	if(ras_core_get_ce_log_status(ras_core) &&
+	   bank->ecc_type == RAS_ERR_TYPE__CE &&
+	   !ACA_BANK_ERR_IS_DEFFERED(bank))
+		return;
+
 	RAS_DEV_INFO(ras_core->dev,
 		"{%llu}" RAS_HW_ERR "Accelerator Check Architecture events logged\n",
 		bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
index 40e5d94b037f..c42a47492d4a 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
@@ -67,5 +67,9 @@
 #define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
 #define mmSMNAID_AID0_MCA_SMU 0x03b30400	/* SMN AID AID0 */
 
+#define ACA_BANK_ERR_IS_DEFFERED(bank)                                \
+	(ACA_REG_STATUS_POISON((bank)->regs[ACA_REG_IDX__STATUS]) || \
+	 ACA_REG_STATUS_DEFERRED((bank)->regs[ACA_REG_IDX__STATUS]))
+
 extern const struct ras_aca_ip_func ras_aca_func_v1_0;
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 08e17a83ad5b..80974b8d6297 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -545,6 +545,16 @@ bool ras_core_is_enabled(struct ras_core_context *ras_core)
 	return ras_core->ras_core_enabled;
 }
 
+void ras_core_set_ce_log_status(struct ras_core_context *ras_core, bool disable)
+{
+	ras_core->ras_core_ce_log_disabled = disable;
+}
+
+bool ras_core_get_ce_log_status(struct ras_core_context *ras_core)
+{
+	return ras_core->ras_core_ce_log_disabled;
+}
+
 uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core)
 {
 	if (!ras_core)
-- 
2.34.1

