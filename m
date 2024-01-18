Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DECBC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D91E10E83A;
	Thu, 18 Jan 2024 14:35:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACFC10E82E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkecqGCCgUhnuBWsN460MNX8CJrren/CV8M6s0bUR4hdXtsXpUSWwld2bcu9RdDZNpfHDKPpILCieOocmevGyMwZLb6r2UtPp3iWMIO/y2EkjCwhiv6YYWhBeGQpmdUblHnEAsxVl1Er4msS7d031pX8g8x7LxUN5fLwDtzN3e9v9+Bf56PBq3ZaT9fiIFY2tzIM1vdA5BOiuiiEsApHxuSGLiKyiUCKdbimAnNyU8kFNAJgtIJq7hf5B6w+OOT+/6XODTXc2lBoTLBKKg/HKrsT3cxdhdB3SBIZ+ZDRQmocgxH8VgikRoYORvtzJ+KMOIvixS3F5Z2r1WraGy/8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o32D0YySdsmKIwUuUbuzuuymc4dY8oxoESFNz+qvDo=;
 b=FtxYzkh9cET5bO5KMkfOHQLLb4FqA+5o0S4subhTL9U15So5DQpPtPtsZc5RNulVSmMW3no/FE2+vpiKuJXcgoNRKslatrIMdvudplIzbCkyjHeDCnYK3oXZ+5k3iZyRRWzDPTBbINLdoYhoTRoy1assTEGdp+1XLsiSpuGBuh/pJIXebyzmbcLPCWrkNp/8cmuAFGYqm8LSjSunIXwKH5bnUp/K+vUkxdzANbMHelqPLOSL/2aZ+m53FAz4J8Q6Qi20LHEuXVKD2bldcsI1ioEqvNWtEqvxrjpHuGvyFkY1FUvTqNjGQbE+rKi+Vqt/CTTCOx7pLue/yvD22I0Msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o32D0YySdsmKIwUuUbuzuuymc4dY8oxoESFNz+qvDo=;
 b=nrG6BeE8Zlmo5QDZlkxyLKbdAKkfNNd/i+Vdd9RHZJaNyI0gMa5WhF4+GqESRuQjfZjAV2fnB+z1VfytTk5uE2pA+Njaju64eUI6CA4C4P+2K5YiNcVmTcNwj/k2ZQzYCp+AdWznBOCM7Fph4lRLxpfabrOkaI1uO2zcvg8z1Ec=
Received: from BYAPR06CA0052.namprd06.prod.outlook.com (2603:10b6:a03:14b::29)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 14:34:49 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::65) by BYAPR06CA0052.outlook.office365.com
 (2603:10b6:a03:14b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:43 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:42 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Add GART memory support for dmcub
Date: Thu, 18 Jan 2024 09:33:56 -0500
Message-ID: <20240118143400.1001088-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc6a285-dc79-4bf7-9b1d-08dc1832a01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeJy/P6398G0leb2U71ZoXF74lEVeV13hN4QT2+IXJQOZ8EvrDrD820BKH0hmzULfczqkQOSipeJ4lGj0sN+SUZMTRj+VGNpqT2bPfX3yJ5MZZu2U5UHg0Y+7N7BzI51B8KDeX+Yi8G+SfLPvCQLCA+UISRrpMGm4iyCjJBrb64Heh9PksaAihNu+OJDVd2w8Di/CSyXOOyo3Szfi7d2jKds2ez8pEhT8k9bxth5vJeLnRVF8g6Um4jIUBhPv4ijqzdX/OX4FuBlXnNF5fuO/q6kkVBpymBOYD7r+DFnHVf2ZiMNkCZ3Lg0Xbwjjz1egTXRcF/kh9n4/FRoXBwfciuZKF8BnJmShKJZNQCbdRZIcC85r0UOwGd7sGGXuAT64Ju/zr2+MdSBPBw7A5m6mvdGP2CcuUke550CYG0KhK5AzX5IapUbslmxVGUSqgPKZbu4i5mjAIUdTsVXzmRUls2utSACPJIHV3uqPi8zKW8PhbdK7cw7LkwSdt9BQCBhn8EXmWdSIqKOGII1b25qAQrJHN6cekCXrEm3DJtEysZNl1rYVhdUmmoJ52VuFX1HeW5UWQW9dbErzQWd+WFEbzJYczGRyNmz/e8cydDaovZ4w1dudofNf6Qv+XwBNGuqMhX/OAYbm0a9xBLwgCZWEluo3+15/DiBsy+9V7ZZra1o3NHu2il+WuuAa2lvKJaKUL01oX2HLgdJ2P3MCejs2+3JfLA6LN6pKr/WCOyHEtSpHPfayx54EbuJtkRT/OKru/yi5F3THKW6NPqw73rDvRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(6666004)(336012)(1076003)(426003)(7696005)(478600001)(26005)(316002)(36756003)(83380400001)(47076005)(8676002)(2616005)(6916009)(70586007)(356005)(86362001)(36860700001)(54906003)(4326008)(81166007)(70206006)(82740400003)(2906002)(8936002)(5660300002)(2876002)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:49.2153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc6a285-dc79-4bf7-9b1d-08dc1832a01e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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
Cc: Fudongwang <fudong.wang@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fudongwang <fudong.wang@amd.com>

[Why]
In dump file, GART memory can be accessed while frame buffer cannot.

[How]
Add GART memory support for dmcub.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fudongwang <fudong.wang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 ++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  19 +++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 106 ++++++++----------
 3 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a9a57ba2b256..7905f5e2da05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2120,6 +2120,16 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	const struct dmcub_firmware_header_v1_0 *hdr;
 	enum dmub_asic dmub_asic;
 	enum dmub_status status;
+	static enum dmub_window_memory_type window_memory_type[DMUB_WINDOW_TOTAL] = {
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_0_INST_CONST
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_1_STACK
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_2_BSS_DATA
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_3_VBIOS
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_4_MAILBOX
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_5_TRACEBUFF
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_6_FW_STATE
+		DMUB_WINDOW_MEMORY_TYPE_FB		//DMUB_WINDOW_7_SCRATCH_MEM
+	};
 	int r;
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
@@ -2217,7 +2227,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		PSP_HEADER_BYTES;
-	region_params.is_mailbox_in_inbox = false;
+	region_params.window_memory_type = window_memory_type;
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
@@ -2245,6 +2255,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	memory_params.cpu_fb_addr = adev->dm.dmub_bo_cpu_addr;
 	memory_params.gpu_fb_addr = adev->dm.dmub_bo_gpu_addr;
 	memory_params.region_info = &region_info;
+	memory_params.window_memory_type = window_memory_type;
 
 	adev->dm.dmub_fb_info =
 		kzalloc(sizeof(*adev->dm.dmub_fb_info), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index c78c9224ab60..410420683f31 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -78,6 +78,16 @@ struct dmub_srv_dcn31_regs;
 
 struct dmcub_trace_buf_entry;
 
+struct dmcub_inbox1_buf {
+	union dmub_rb_cmd cmd[DMUB_RB_MAX_ENTRY];
+};
+
+/* enum dmub_window_memory_type - memory location type specification for windows */
+enum dmub_window_memory_type {
+	DMUB_WINDOW_MEMORY_TYPE_FB = 0,
+	DMUB_WINDOW_MEMORY_TYPE_GART
+};
+
 /* enum dmub_status - return code for dmcub functions */
 enum dmub_status {
 	DMUB_STATUS_OK = 0,
@@ -203,7 +213,7 @@ struct dmub_srv_region_params {
 	uint32_t vbios_size;
 	const uint8_t *fw_inst_const;
 	const uint8_t *fw_bss_data;
-	bool is_mailbox_in_inbox;
+	const enum dmub_window_memory_type *window_memory_type;
 };
 
 /**
@@ -223,7 +233,7 @@ struct dmub_srv_region_params {
  */
 struct dmub_srv_region_info {
 	uint32_t fb_size;
-	uint32_t inbox_size;
+	uint32_t gart_size;
 	uint8_t num_regions;
 	struct dmub_region regions[DMUB_WINDOW_TOTAL];
 };
@@ -239,9 +249,10 @@ struct dmub_srv_region_info {
 struct dmub_srv_memory_params {
 	const struct dmub_srv_region_info *region_info;
 	void *cpu_fb_addr;
-	void *cpu_inbox_addr;
+	void *cpu_gart_addr;
 	uint64_t gpu_fb_addr;
-	uint64_t gpu_inbox_addr;
+	uint64_t gpu_gart_addr;
+	const enum dmub_window_memory_type *window_memory_type;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9ad738805320..71eee58d86a1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -417,58 +417,44 @@ void dmub_srv_destroy(struct dmub_srv *dmub)
 	dmub_memset(dmub, 0, sizeof(*dmub));
 }
 
+static uint32_t dmub_srv_calc_regions_for_memory_type(const struct dmub_srv_region_params *params,
+	struct dmub_srv_region_info *out,
+	const uint32_t *window_sizes,
+	enum dmub_window_memory_type memory_type)
+{
+	uint32_t i, top = 0;
+
+	for (i = 0; i < DMUB_WINDOW_TOTAL; ++i) {
+		if (params->window_memory_type[i] == memory_type) {
+			struct dmub_region *region = &out->regions[i];
+
+			region->base = dmub_align(top, 256);
+			region->top = region->base + dmub_align(window_sizes[i], 64);
+			top = region->top;
+		}
+	}
+
+	return dmub_align(top, 4096);
+}
+
 enum dmub_status
-dmub_srv_calc_region_info(struct dmub_srv *dmub,
-			  const struct dmub_srv_region_params *params,
-			  struct dmub_srv_region_info *out)
+	dmub_srv_calc_region_info(struct dmub_srv *dmub,
+		const struct dmub_srv_region_params *params,
+		struct dmub_srv_region_info *out)
 {
-	struct dmub_region *inst = &out->regions[DMUB_WINDOW_0_INST_CONST];
-	struct dmub_region *stack = &out->regions[DMUB_WINDOW_1_STACK];
-	struct dmub_region *data = &out->regions[DMUB_WINDOW_2_BSS_DATA];
-	struct dmub_region *bios = &out->regions[DMUB_WINDOW_3_VBIOS];
-	struct dmub_region *mail = &out->regions[DMUB_WINDOW_4_MAILBOX];
-	struct dmub_region *trace_buff = &out->regions[DMUB_WINDOW_5_TRACEBUFF];
-	struct dmub_region *fw_state = &out->regions[DMUB_WINDOW_6_FW_STATE];
-	struct dmub_region *scratch_mem = &out->regions[DMUB_WINDOW_7_SCRATCH_MEM];
 	const struct dmub_fw_meta_info *fw_info;
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
-	uint32_t scratch_mem_size = DMUB_SCRATCH_MEM_SIZE;
-	uint32_t previous_top = 0;
+	uint32_t window_sizes[DMUB_WINDOW_TOTAL] = { 0 };
+
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
 	memset(out, 0, sizeof(*out));
+	memset(window_sizes, 0, sizeof(window_sizes));
 
 	out->num_regions = DMUB_NUM_WINDOWS;
 
-	inst->base = 0x0;
-	inst->top = inst->base + params->inst_const_size;
-
-	data->base = dmub_align(inst->top, 256);
-	data->top = data->base + params->bss_data_size;
-
-	/*
-	 * All cache windows below should be aligned to the size
-	 * of the DMCUB cache line, 64 bytes.
-	 */
-
-	stack->base = dmub_align(data->top, 256);
-	stack->top = stack->base + DMUB_STACK_SIZE + DMUB_CONTEXT_SIZE;
-
-	bios->base = dmub_align(stack->top, 256);
-	bios->top = bios->base + params->vbios_size;
-
-	if (params->is_mailbox_in_inbox) {
-		mail->base = 0;
-		mail->top = mail->base + DMUB_MAILBOX_SIZE;
-		previous_top = bios->top;
-	} else {
-		mail->base = dmub_align(bios->top, 256);
-		mail->top = mail->base + DMUB_MAILBOX_SIZE;
-		previous_top = mail->top;
-	}
-
 	fw_info = dmub_get_fw_meta_info(params);
 
 	if (fw_info) {
@@ -486,19 +472,20 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 			dmub->fw_version = fw_info->fw_version;
 	}
 
-	trace_buff->base = dmub_align(previous_top, 256);
-	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
+	window_sizes[DMUB_WINDOW_0_INST_CONST] = params->inst_const_size;
+	window_sizes[DMUB_WINDOW_1_STACK] = DMUB_STACK_SIZE + DMUB_CONTEXT_SIZE;
+	window_sizes[DMUB_WINDOW_2_BSS_DATA] = params->bss_data_size;
+	window_sizes[DMUB_WINDOW_3_VBIOS] = params->vbios_size;
+	window_sizes[DMUB_WINDOW_4_MAILBOX] = DMUB_MAILBOX_SIZE;
+	window_sizes[DMUB_WINDOW_5_TRACEBUFF] = trace_buffer_size;
+	window_sizes[DMUB_WINDOW_6_FW_STATE] = fw_state_size;
+	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = DMUB_SCRATCH_MEM_SIZE;
 
-	fw_state->base = dmub_align(trace_buff->top, 256);
-	fw_state->top = fw_state->base + dmub_align(fw_state_size, 64);
+	out->fb_size =
+		dmub_srv_calc_regions_for_memory_type(params, out, window_sizes, DMUB_WINDOW_MEMORY_TYPE_FB);
 
-	scratch_mem->base = dmub_align(fw_state->top, 256);
-	scratch_mem->top = scratch_mem->base + dmub_align(scratch_mem_size, 64);
-
-	out->fb_size = dmub_align(scratch_mem->top, 4096);
-
-	if (params->is_mailbox_in_inbox)
-		out->inbox_size = dmub_align(mail->top, 4096);
+	out->gart_size =
+		dmub_srv_calc_regions_for_memory_type(params, out, window_sizes, DMUB_WINDOW_MEMORY_TYPE_GART);
 
 	return DMUB_STATUS_OK;
 }
@@ -507,8 +494,6 @@ enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
 				       const struct dmub_srv_memory_params *params,
 				       struct dmub_srv_fb_info *out)
 {
-	uint8_t *cpu_base;
-	uint64_t gpu_base;
 	uint32_t i;
 
 	if (!dmub->sw_init)
@@ -519,19 +504,16 @@ enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
 	if (params->region_info->num_regions != DMUB_NUM_WINDOWS)
 		return DMUB_STATUS_INVALID;
 
-	cpu_base = (uint8_t *)params->cpu_fb_addr;
-	gpu_base = params->gpu_fb_addr;
-
 	for (i = 0; i < DMUB_NUM_WINDOWS; ++i) {
 		const struct dmub_region *reg =
 			&params->region_info->regions[i];
 
-		out->fb[i].cpu_addr = cpu_base + reg->base;
-		out->fb[i].gpu_addr = gpu_base + reg->base;
-
-		if (i == DMUB_WINDOW_4_MAILBOX && params->cpu_inbox_addr != 0) {
-			out->fb[i].cpu_addr = (uint8_t *)params->cpu_inbox_addr + reg->base;
-			out->fb[i].gpu_addr = params->gpu_inbox_addr + reg->base;
+		if (params->window_memory_type[i] == DMUB_WINDOW_MEMORY_TYPE_GART) {
+			out->fb[i].cpu_addr = (uint8_t *)params->cpu_gart_addr + reg->base;
+			out->fb[i].gpu_addr = params->gpu_gart_addr + reg->base;
+		} else {
+			out->fb[i].cpu_addr = (uint8_t *)params->cpu_fb_addr + reg->base;
+			out->fb[i].gpu_addr = params->gpu_fb_addr + reg->base;
 		}
 
 		out->fb[i].size = reg->top - reg->base;
-- 
2.34.1

