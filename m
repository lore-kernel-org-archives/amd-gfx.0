Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC2CFD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C4F10E2FF;
	Wed, 11 Mar 2026 04:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="toN10+uD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8210710E2FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1d22AOv8QBu7S5YDjZtd7O3f7e2gNGsMLkhk0QYeoOSmJKsteVLyN/pQDiHMhZX+M3jztczYpDlgEldjLu7SJJJkomaDRlIJWxdx2YZ2i+OypmDT3dmGpDceRr9/umvfMP+Qtgav5RRo/xm6UYD5msl34EiyxtXO65LFkZv0XIyTbnfx1KOHFo8WpPQXsEUBq8zKZcn0UNt2SAjYCa00HFy0+5HDuljm5/h0PJ2B9qXCZamy0tdgAjBLWgca0615Jl3gqltOm7jhlFEB1aafQfmluynr1FnZidMkLJ7RP9Vn2WA2X/t2qaTyioAXSbd6Oxz0z+rj19dhk8Tmu3Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ5V7tz2E865sw9bdWBR6rwKah0WfDYn4oTZMFFgJkA=;
 b=h/UP+rI+eMrnvREYcErDRJ3wUI5Y++kx6v9nGC0k5e2rIVUV06stCrNyXw7SqF05ThscqDXFyP45VeagkTfVW07MJjk6YCBMrIDybglS1IG039WOLzWj/rnoCj6EKhtRABMFeHpzX8RgGI7Hl8VBavaNFKom3H0O4ezEYnag/mEEplc4Q+0u8haArWiPR9lz/SxvKjyhSjXZRYI47OgSXPqFMs5hbaBsCxQSiMzOsQkGhTSQMMVKCmiEiRIVF6nAvzNEe8Q+v9OQ4u1N72ahOsPjgqrJfAkE8hafbobIGQBfP9ZoVsLPqSMHPV1fMbK5OpW0TQIrM1LIU3y/FchTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ5V7tz2E865sw9bdWBR6rwKah0WfDYn4oTZMFFgJkA=;
 b=toN10+uDL2it0/+IuqS9/DGwbwkgApcGlkVIHu71CsrrUup51ecwYgF+PbDRCIy4IU4vwaMQdf3s96P2g6Wv390lyhnw6OMaYbARwdPn1R0QpeF9RNsPTxBZVwwhnKsW/c3CTmO7dK/5x/1TmoWYA6rT+I6MpNLppPcjat3GMU4=
Received: from PH8PR02CA0037.namprd02.prod.outlook.com (2603:10b6:510:2da::35)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 04:03:58 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::59) by PH8PR02CA0037.outlook.office365.com
 (2603:10b6:510:2da::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 04:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:03:58 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:54 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 6/9] drm/amd/display: Add a buffer for boot time crc
Date: Wed, 11 Mar 2026 11:33:01 +0800
Message-ID: <20260311040501.2693643-7-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: a6295c76-8c31-4ffa-c33a-08de7f2338b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u/CpJA+kBteCfWVLS/G9Ie6ZCeaiIQNNe8hIOO5Jhk7E1gj7R6yH2r8UkFqSZ5VvrxAHqlPPlyJDR8Z4+L2XB32T/PX0SO1e6UxZFcxKan3b+CCVP2vjJFwY9jGkSDgq8rWgsbAKasORYpQ2X5ORGuVhbeIfxNTIAjWoXuMjqphL1zfb7vMo5QaSe8dr3iT2llXsp6hCTN9FGSMJ9czH9V+zE0z6ssLC6R6Sm5ZAL8tRK4Z9e4ySzoekH5nBKae7FZPkdJz3yA4KkySGgD+fPqoW7eD+2NxPf4PDvOy3Jh2Ek1E8zFYR2GqZqfvLAFfPqbtzdIV4FObQxwcZPXAMqiT5KptyfUEEsXd9TSwZ7BiwWZ9k0jiynvVHVBZeY5ZYgLwNyOc69o3EveT/pur/zjWHU2t6gzG+NSJZ9yBYnj6Z6QsEQIiOSEQdzIgc55f5ff8Bsw9rU6GwNxj3VU1KMi6UEcldP7ZxaSYR4t6lBM0tX16c6CSRqQZml7T0PK50B4I/ZRgYUv7sREPJ2saS5cLS6JXxhiO+8kvN0/lNuqsRA8+VolC4efSRA4NKXY3idTsKg7bLKTwR5vt6Hg2BogL+iFY/KUizsmgDHTTQgiYCuZb3qXu+5olFfCGTROwY5RsRN0RvMHHReMMOGORPwHpVHJdR8uIvqz84uSCh64mLzYBWioyfVygKo4FqzUVTE2ltsQh+14bZrggLoDSh/qAlKf0oL5eZj59opTR16walOoD1pANgD8oubEy2Z22wF1OGT2OEHPvDBEkARkuihw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QaB/0N/clwRyXNSTBHsODYt/A+bCvQzmEOXeFtUgDG1GkoMP0oGIk1EeeavZuFUyyfBpnF5rM/T/OJAoG8PUPHaryma7pnr7kpl97Pgz2Fn1XGectCv3fQLaU2CY6eRQjm1idGkqzay7EVUCwQ7RCvJIYvQS1Sz26OawHg9lupN8GhYg2CMk80ctrDgYB7/zFwXEItjwgnYoVODgnp9WXo8v/SDmPpM9DMzLXdSRQP91hxa4PvFSRY4yqa8MojhTNzjG2AtqJUfJZroqaiBecW1ey1M9hnwnUp4nu2OZZmj6ZuQIhf+6uTQJJPx9ml6dMPvsg1OOGSxEl9mkK5xG+sxYi1kGcKMUWS75S73N221yUtDU9O68XnQlMYtQ5sbYE11h18FBBh5seBFq370J8nnY9Tm7dPIGn88ha75CBsheODG9r6cf0XafGXKRaaqx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:03:58.4856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6295c76-8c31-4ffa-c33a-08de7f2338b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
We need to reserve a memory buffer for boot time crc test
during resume.

[How]
Create a buffer during boot up and send the buffer info to
DMUB.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 58 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 21 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 27 +++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  9 +++
 4 files changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ff09a5371cb2..b1ac05abca07 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2286,6 +2286,11 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 				      &adev->dm.dmub_bo_gpu_addr,
 				      &adev->dm.dmub_bo_cpu_addr);
 
+	if (adev->dm.boot_time_crc_info.bo_ptr)
+		amdgpu_bo_free_kernel(&adev->dm.boot_time_crc_info.bo_ptr,
+					&adev->dm.boot_time_crc_info.gpu_addr,
+					&adev->dm.boot_time_crc_info.cpu_addr);
+
 	if (adev->dm.hpd_rx_offload_wq && adev->dm.dc) {
 		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
 			if (adev->dm.hpd_rx_offload_wq[i].wq) {
@@ -2735,6 +2740,54 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
 	return ret;
 }
 
+static void amdgpu_dm_boot_time_crc_init(struct amdgpu_device *adev)
+{
+	struct dm_boot_time_crc_info *bootcrc_info = NULL;
+	struct dmub_srv *dmub = NULL;
+	union dmub_fw_boot_options option = {0};
+	int ret = 0;
+	const uint32_t fb_size = 3 * 1024 * 1024;	/* 3MB for DCC pattern */
+
+	if (!adev || !adev->dm.dc || !adev->dm.dc->ctx ||
+		!adev->dm.dc->ctx->dmub_srv) {
+		return;
+	}
+
+	dmub = adev->dm.dc->ctx->dmub_srv->dmub;
+	bootcrc_info = &adev->dm.boot_time_crc_info;
+
+	if (!dmub || !dmub->hw_funcs.get_fw_boot_option) {
+		drm_dbg(adev_to_drm(adev), "failed to init boot time crc buffer\n");
+		return;
+	}
+
+	option = dmub->hw_funcs.get_fw_boot_option(dmub);
+
+	/* Return if boot time CRC is not enabled */
+	if (option.bits.bootcrc_en_at_S0i3 == 0)
+		return;
+
+	/* Create a buffer for boot time CRC */
+	ret = amdgpu_bo_create_kernel(adev, fb_size, PAGE_SIZE,
+		AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
+		&bootcrc_info->bo_ptr,
+		&bootcrc_info->gpu_addr,
+		&bootcrc_info->cpu_addr);
+
+	if (ret) {
+		drm_dbg(adev_to_drm(adev), "failed to create boot time crc buffer\n");
+	} else {
+		bootcrc_info->size = fb_size;
+
+		drm_dbg(adev_to_drm(adev), "boot time crc buffer created addr 0x%llx, size %u\n",
+			bootcrc_info->gpu_addr, bootcrc_info->size);
+
+		/* Send the buffer info to DMUB */
+		dc_dmub_srv_boot_time_crc_init(adev->dm.dc,
+			bootcrc_info->gpu_addr, bootcrc_info->size);
+	}
+}
+
 static int dm_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2746,6 +2799,11 @@ static int dm_late_init(struct amdgpu_ip_block *ip_block)
 
 	dmcu = adev->dm.dc->res_pool->dmcu;
 
+	/* Init the boot time CRC (skip in resume) */
+	if ((adev->in_suspend == 0) &&
+		(amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 6, 0)))
+		amdgpu_dm_boot_time_crc_init(adev);
+
 	for (i = 0; i < 16; i++)
 		linear_lut[i] = 0xFFFF * i / 15;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 800813671748..83fefd902355 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -123,6 +123,20 @@ struct dm_compressor_info {
 	uint64_t gpu_addr;
 };
 
+/**
+ * struct dm_boot_time_crc_info - Buffer info used by boot time CRC
+ * @cpu_addr: MMIO cpu addr
+ * @bo_ptr: Pointer to the buffer object
+ * @gpu_addr: MMIO gpu addr
+ * @size: Size of the buffer
+ */
+struct dm_boot_time_crc_info {
+	void *cpu_addr;
+	struct amdgpu_bo *bo_ptr;
+	uint64_t gpu_addr;
+	uint32_t size;
+};
+
 typedef void (*dmub_notify_interrupt_callback_t)(struct amdgpu_device *adev, struct dmub_notification *notify);
 
 /**
@@ -698,6 +712,13 @@ struct amdgpu_display_manager {
 		struct completion replied;
 		char reply_data[0x40];  // Cannot include dmub_cmd here
 	} fused_io[8];
+
+	/**
+	 * @dm_boot_time_crc_info:
+	 *
+	 * Buffer info for the boot time crc.
+	 */
+	struct dm_boot_time_crc_info boot_time_crc_info;
 };
 
 enum dsc_clock_force_state {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index e4dd5ca70987..d6a08064456b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2349,6 +2349,33 @@ bool dc_dmub_srv_is_cursor_offload_enabled(const struct dc *dc)
 	return dc->ctx->dmub_srv && dc->ctx->dmub_srv->cursor_offload_enabled;
 }
 
+void dc_dmub_srv_boot_time_crc_init(const struct dc *dc, uint64_t gpu_addr, uint32_t size)
+{
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct dc_context *dc_ctx;
+	union dmub_rb_cmd cmd = {0};
+	bool result = false;
+
+	if (!dc || !dc->ctx || !dc->ctx->dmub_srv || size == 0)
+		return;
+
+	dc_dmub_srv = dc->ctx->dmub_srv;
+	dc_ctx = dc_dmub_srv->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.boot_time_crc_init.header.type = DMUB_CMD__BOOT_TIME_CRC;
+	cmd.boot_time_crc_init.header.sub_type = DMUB_CMD__BOOT_TIME_CRC_INIT_MEM;
+	cmd.boot_time_crc_init.header.payload_bytes =
+		sizeof(struct dmub_rb_cmd_boot_time_crc_init);
+	cmd.boot_time_crc_init.data.buffer_addr.quad_part = gpu_addr;
+	cmd.boot_time_crc_init.data.buffer_size = size;
+
+	result = dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+
+	if (!result)
+		DC_ERROR("Boot time crc init failed in DMUB");
+}
+
 void dc_dmub_srv_release_hw(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 72e0a41f39f0..6579cf9cce3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -361,6 +361,15 @@ void dc_dmub_srv_program_cursor_now(struct dc *dc, const struct pipe_ctx *pipe);
  */
 bool dc_dmub_srv_is_cursor_offload_enabled(const struct dc *dc);
 
+/**
+ * dc_dmub_srv_boot_time_crc_init() - Initializes DMUB boot time CRC.
+ *
+ * @dc - pointer to DC object
+ * @gpu_addr - address for the boot time CRC buffer
+ * @size - size of the boot time CRC buffer
+ */
+void dc_dmub_srv_boot_time_crc_init(const struct dc *dc, uint64_t gpu_addr, uint32_t size);
+
 /**
  * dc_dmub_srv_release_hw() - Notifies DMUB service that HW access is no longer required.
  *
-- 
2.43.0

