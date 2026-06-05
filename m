Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C049CD8C84
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3A010E64D;
	Fri,  5 Jun 2026 13:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aq73A5v6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6162B10E642
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWiDM8QG+MYQTLPBFDY0JXJ2QpDCLuCt9DfK52fA6tuPoy/URk2aPnc0Hxz2Nq6FZg6HkQvfPNj3Od9Tgv+G1qCZSj4gtcRzmR+oGNSSR7j8T/etzguBgLRGQHCoFKj+LJ+pxE83ql+qP91mAfgQVEUju9gn4DHIvrOYsoYjMsLJlztFSqhii8uLRxAgJ6vTAhVDGLhRxPM30sf6wSs31Co3U1LlBRTx9ln6rhYiUfutIkG+cgk6v/pd+BEbxXfn39Ff+rO1qOtkJvq84T+lKB770PraGw/rtsSTDlTpn2rz4vXu2nkyocmEsIUpc6jBLqXqkmz/YGajv70wjkiLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59nEwrpE3ED0rMsXEvbAyl8tIWH3hpbRBxeVbDum1pQ=;
 b=ZDZkwlKcFz+dEIJwjRc749LpgMTDADrmrBfXQkbbjC4hPPB1BYSD3yG6p0Ia/iyAIqxN6kVFY6zOUSt7yP5WSWApNUfEyZUeS24hQOT5KQLtQ+VfN2WVoOj/JNB+6g7PX+3YSoVU2Pl3RKsYMOzVl5AbSHnKMqtSx/cvUhbOJoo/7Wc76EjciN2tjVnrYdJbIGw8mZkYi+84sa0mDox0sFvTrBWnmZ5VGlYBA/q4fOlnclh51d0Tp8g9oLXtQ44HzpYhR41HZXuNe/mFUWYSzgHMvm3aweXFgBLPltk3ubf735oLI6sH7/7XHwHkHCPjLp254I3J2SUx5wbpbIYuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59nEwrpE3ED0rMsXEvbAyl8tIWH3hpbRBxeVbDum1pQ=;
 b=Aq73A5v6fGNawic2QJOD9qyex/uO273VfeegojOgATfPszHv9Cu6w2RXOqALxvqOfAcq6EPJUlslx3ZEYX/R/4tthPi0PwOCr1l8N+G584PcyGP+O1fwoI1wvSBu/jw1oZt8Lrm5d2TSkn/skal4qzuH9ViMs9sP5R9NJrwi8uE=
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:44:23 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::8d) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:23 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:16 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 10/11] drm/amdgpu: move amdgpu_asic helpers into new header
Date: Fri, 5 Jun 2026 09:43:22 -0400
Message-ID: <20260605134400.956791-11-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ff25dd-a5c0-499d-88dc-08dec3088d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +1NpiydI6F1dog7Cw/RVAkZ2r2NwwyOOPizhasFEQ56d2WEfgrkqxPI6SliZ6a3wLJR/xljHZLyMs0XQXNJBEVXxCpYEoNbMyhXLrrjQxH+sv09wvZAJnsqZEZdOewDH/nCNF+hYl2Qc1KFz3kAQGV8LeBP7hsS5AcPI+Cf6yD40TqI63E2xlbJpQth9tO1JmSE3bmpVvbQG7KJBY3j8doIYO2cApYOylAf9/jaZJf0pfZJOwmLBDtQfAKKKpUGUeMjbR2ySfWsxCEd/m5gCIHXhMpNotsV+t5reAH4ccqS2B81zLcoDHbibALqi0fdzz7+dHAhsODko2B3+LSEljV/pgzWiqGuQ5WhLBAty6sqd8nCN9+GtYLidLhc8BAy6gL967FFeetkuw3RIILf1uMnyy0Vk2lnb2q6uiwfsBgiDnBvHFufhP459DtfdePbjTkP1xYS46qua6DQu80mJ1xgyAw0FwkPYLI8hnD3W4OjpYq3kDSEP4aw0zcGtSDZkWm6x+59wevE7WE/6eEBT1E2YoK7uFuWulYIaTH1kp8B3ytKfDsBimSD2XrHLskCQaFdvjORaEtALWlAMcD5t0MJMGMcv2FpKjb9VcNBVM0Ag9PtLMKGfad+/Vtf9LtWj1Kh9smqPZ//3QAyaIvul88is9O176g24y8N7m/qJ/I5hbWsTyHhCn0FBuuEJD0K4IFttn8kzYgKvdxb928oMgVSz9RJGF9+OanWdexNoe+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hs0BVsDPi8aRfslRdmpKJPoteamsUQ7u93JWDHdqYjRrsTfaiAPwivD5jAwIo0L8fWD+sxgWTRFXGL0nUyJGWcZyUx0gcmi9wtLUGh5QoeDA441i3B2XwXVfXomL1q9r3NCGJVSa2xilSVSwEkGZT9DngC3w1bv4Tf7VDG/mCTgaQNt1PrBgldCf3Djvi0eElN4rWSUzrH1TgjWSNpWcs2rn2NBX6CjR+DXbvF4mo5/E3CFnPrPMldLNFlxsWOz39ZdQ89/D2PvMXUrDEgy0qWjXIIDjxp6z5x6KcSGoRen3FUCp3+diunyD7iDe8VdIZKJsNGrMeWh8KKGBxxl7jcbxq5RAIcHyuRmYy4A6GY6Wkzn3v3yv88jTedBYCIN7osxu4P05s/J5SeBgWtaHbXqPamqgnLxVre9/Lz2JJjL0DcSPZ20pfRzjCKO1ihE5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:23.2637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ff25dd-a5c0-499d-88dc-08dec3088d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
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

Move struct amdgpu_asic_funcs, polaris kickers, and ASICs macro from the monolithic amdgpu.h
file into a new amdgpu_asic.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 128 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h | 160 +++++++++++++++++++++++
 2 files changed, 161 insertions(+), 127 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d2b84c27a6e7..812bd0f6ff0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -119,6 +119,7 @@
 #include "amdgpu_init_level.h"
 #include "amdgpu_uid.h"
 #include "amdgpu_video_codecs.h"
+#include "amdgpu_asic.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -415,61 +416,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
  */
 int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
 
-/*
- * ASIC specific functions.
- */
-struct amdgpu_asic_funcs {
-	bool (*read_disabled_bios)(struct amdgpu_device *adev);
-	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
-				   u8 *bios, u32 length_bytes);
-	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
-			     u32 sh_num, u32 reg_offset, u32 *value);
-	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
-	int (*reset)(struct amdgpu_device *adev);
-	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
-	/* get the reference clock */
-	u32 (*get_xclk)(struct amdgpu_device *adev);
-	/* MM block clocks */
-	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
-	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
-	/* static power management */
-	int (*get_pcie_lanes)(struct amdgpu_device *adev);
-	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
-	/* get config memsize register */
-	u32 (*get_config_memsize)(struct amdgpu_device *adev);
-	/* flush hdp write queue */
-	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
-	/* invalidate hdp read cache */
-	void (*invalidate_hdp)(struct amdgpu_device *adev,
-			       struct amdgpu_ring *ring);
-	/* check if the asic needs a full reset of if soft reset will work */
-	bool (*need_full_reset)(struct amdgpu_device *adev);
-	/* initialize doorbell layout for specific asic*/
-	void (*init_doorbell_index)(struct amdgpu_device *adev);
-	/* PCIe bandwidth usage */
-	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
-			       uint64_t *count1);
-	/* do we need to reset the asic at init time (e.g., kexec) */
-	bool (*need_reset_on_init)(struct amdgpu_device *adev);
-	/* PCIe replay counter */
-	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
-	/* device supports BACO */
-	int (*supports_baco)(struct amdgpu_device *adev);
-	/* pre asic_init quirks */
-	void (*pre_asic_init)(struct amdgpu_device *adev);
-	/* enter/exit umd stable pstate */
-	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
-	/* query video codecs */
-	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
-				  const struct amdgpu_video_codecs **codecs);
-	/* encode "> 32bits" smn addressing */
-	u64 (*encode_ext_smn_addressing)(int ext_id);
-
-	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
-				 enum amdgpu_reg_state reg_state, void *buf,
-				 size_t max_size);
-};
-
 /*
  * IOCTL.
  */
@@ -510,45 +456,6 @@ struct amd_powerplay {
 	const struct amd_pm_funcs *pp_funcs;
 };
 
-/* polaris10 kickers */
-#define ASICID_IS_P20(did, rid)		(((did == 0x67DF) && \
-					 ((rid == 0xE3) || \
-					  (rid == 0xE4) || \
-					  (rid == 0xE5) || \
-					  (rid == 0xE7) || \
-					  (rid == 0xEF))) || \
-					 ((did == 0x6FDF) && \
-					 ((rid == 0xE7) || \
-					  (rid == 0xEF) || \
-					  (rid == 0xFF))))
-
-#define ASICID_IS_P30(did, rid)		((did == 0x67DF) && \
-					((rid == 0xE1) || \
-					 (rid == 0xF7)))
-
-/* polaris11 kickers */
-#define ASICID_IS_P21(did, rid)		(((did == 0x67EF) && \
-					 ((rid == 0xE0) || \
-					  (rid == 0xE5))) || \
-					 ((did == 0x67FF) && \
-					 ((rid == 0xCF) || \
-					  (rid == 0xEF) || \
-					  (rid == 0xFF))))
-
-#define ASICID_IS_P31(did, rid)		((did == 0x67EF) && \
-					((rid == 0xE2)))
-
-/* polaris12 kickers */
-#define ASICID_IS_P23(did, rid)		(((did == 0x6987) && \
-					 ((rid == 0xC0) || \
-					  (rid == 0xC1) || \
-					  (rid == 0xC3) || \
-					  (rid == 0xC7))) || \
-					 ((did == 0x6981) && \
-					 ((rid == 0x00) || \
-					  (rid == 0x01) || \
-					  (rid == 0x10))))
-
 struct amdgpu_pcie_reset_ctx {
 	bool in_link_reset;
 	bool occurs_dpc;
@@ -1082,39 +989,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #include "amdgpu_reset.h"
 
-/*
- * ASICs macro.
- */
-#define amdgpu_asic_set_vga_state(adev, state) \
-    ((adev)->asic_funcs->set_vga_state ? (adev)->asic_funcs->set_vga_state((adev), (state)) : 0)
-#define amdgpu_asic_reset(adev) (adev)->asic_funcs->reset((adev))
-#define amdgpu_asic_reset_method(adev) (adev)->asic_funcs->reset_method((adev))
-#define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev))
-#define amdgpu_asic_set_uvd_clocks(adev, v, d) (adev)->asic_funcs->set_uvd_clocks((adev), (v), (d))
-#define amdgpu_asic_set_vce_clocks(adev, ev, ec) (adev)->asic_funcs->set_vce_clocks((adev), (ev), (ec))
-#define amdgpu_get_pcie_lanes(adev) (adev)->asic_funcs->get_pcie_lanes((adev))
-#define amdgpu_set_pcie_lanes(adev, l) (adev)->asic_funcs->set_pcie_lanes((adev), (l))
-#define amdgpu_asic_get_gpu_clock_counter(adev) (adev)->asic_funcs->get_gpu_clock_counter((adev))
-#define amdgpu_asic_read_disabled_bios(adev) (adev)->asic_funcs->read_disabled_bios((adev))
-#define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
-#define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
-#define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
-#define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
-#define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
-#define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
-#define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
-#define amdgpu_asic_supports_baco(adev) \
-    ((adev)->asic_funcs->supports_baco ? (adev)->asic_funcs->supports_baco((adev)) : 0)
-#define amdgpu_asic_pre_asic_init(adev)                                      \
-	{                                                                    \
-		if ((adev)->asic_funcs && (adev)->asic_funcs->pre_asic_init) \
-			(adev)->asic_funcs->pre_asic_init((adev));           \
-	}
-#define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
-	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
-#define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
-
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter))
 
 #define BIT_MASK_UPPER(i) ((i) >= BITS_PER_LONG ? 0 : ~0UL << (i))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h
new file mode 100644
index 000000000000..413f9a98181f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef __AMDGPU_ASIC_H__
+#define __AMDGPU_ASIC_H__
+
+#include <linux/types.h>
+#include "amdgpu_reg_state.h"
+
+struct amdgpu_ring;
+struct amdgpu_video_codecs;
+struct amdgpu_device;
+enum amd_reset_method;
+
+/*
+ * ASIC specific functions.
+ */
+struct amdgpu_asic_funcs {
+	bool (*read_disabled_bios)(struct amdgpu_device *adev);
+	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
+				   u8 *bios, u32 length_bytes);
+	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
+			     u32 sh_num, u32 reg_offset, u32 *value);
+	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
+	int (*reset)(struct amdgpu_device *adev);
+	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
+	/* get the reference clock */
+	u32 (*get_xclk)(struct amdgpu_device *adev);
+	/* MM block clocks */
+	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
+	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
+	/* static power management */
+	int (*get_pcie_lanes)(struct amdgpu_device *adev);
+	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
+	/* get config memsize register */
+	u32 (*get_config_memsize)(struct amdgpu_device *adev);
+	/* flush hdp write queue */
+	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+	/* invalidate hdp read cache */
+	void (*invalidate_hdp)(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring);
+	/* check if the asic needs a full reset of if soft reset will work */
+	bool (*need_full_reset)(struct amdgpu_device *adev);
+	/* initialize doorbell layout for specific asic*/
+	void (*init_doorbell_index)(struct amdgpu_device *adev);
+	/* PCIe bandwidth usage */
+	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
+			       uint64_t *count1);
+	/* do we need to reset the asic at init time (e.g., kexec) */
+	bool (*need_reset_on_init)(struct amdgpu_device *adev);
+	/* PCIe replay counter */
+	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
+	/* device supports BACO */
+	int (*supports_baco)(struct amdgpu_device *adev);
+	/* pre asic_init quirks */
+	void (*pre_asic_init)(struct amdgpu_device *adev);
+	/* enter/exit umd stable pstate */
+	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
+	/* query video codecs */
+	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs);
+	/* encode "> 32bits" smn addressing */
+	u64 (*encode_ext_smn_addressing)(int ext_id);
+
+	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
+				 enum amdgpu_reg_state reg_state, void *buf,
+				 size_t max_size);
+};
+
+/* polaris10 kickers */
+#define ASICID_IS_P20(did, rid)		(((did == 0x67DF) && \
+					 ((rid == 0xE3) || \
+					  (rid == 0xE4) || \
+					  (rid == 0xE5) || \
+					  (rid == 0xE7) || \
+					  (rid == 0xEF))) || \
+					 ((did == 0x6FDF) && \
+					 ((rid == 0xE7) || \
+					  (rid == 0xEF) || \
+					  (rid == 0xFF))))
+
+#define ASICID_IS_P30(did, rid)		((did == 0x67DF) && \
+					((rid == 0xE1) || \
+					 (rid == 0xF7)))
+
+/* polaris11 kickers */
+#define ASICID_IS_P21(did, rid)		(((did == 0x67EF) && \
+					 ((rid == 0xE0) || \
+					  (rid == 0xE5))) || \
+					 ((did == 0x67FF) && \
+					 ((rid == 0xCF) || \
+					  (rid == 0xEF) || \
+					  (rid == 0xFF))))
+
+#define ASICID_IS_P31(did, rid)		((did == 0x67EF) && \
+					((rid == 0xE2)))
+
+/* polaris12 kickers */
+#define ASICID_IS_P23(did, rid)		(((did == 0x6987) && \
+					 ((rid == 0xC0) || \
+					  (rid == 0xC1) || \
+					  (rid == 0xC3) || \
+					  (rid == 0xC7))) || \
+					 ((did == 0x6981) && \
+					 ((rid == 0x00) || \
+					  (rid == 0x01) || \
+					  (rid == 0x10))))
+
+/*
+ * ASICs macro.
+ */
+#define amdgpu_asic_set_vga_state(adev, state) \
+    ((adev)->asic_funcs->set_vga_state ? (adev)->asic_funcs->set_vga_state((adev), (state)) : 0)
+#define amdgpu_asic_reset(adev) (adev)->asic_funcs->reset((adev))
+#define amdgpu_asic_reset_method(adev) (adev)->asic_funcs->reset_method((adev))
+#define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev))
+#define amdgpu_asic_set_uvd_clocks(adev, v, d) (adev)->asic_funcs->set_uvd_clocks((adev), (v), (d))
+#define amdgpu_asic_set_vce_clocks(adev, ev, ec) (adev)->asic_funcs->set_vce_clocks((adev), (ev), (ec))
+#define amdgpu_get_pcie_lanes(adev) (adev)->asic_funcs->get_pcie_lanes((adev))
+#define amdgpu_set_pcie_lanes(adev, l) (adev)->asic_funcs->set_pcie_lanes((adev), (l))
+#define amdgpu_asic_get_gpu_clock_counter(adev) (adev)->asic_funcs->get_gpu_clock_counter((adev))
+#define amdgpu_asic_read_disabled_bios(adev) (adev)->asic_funcs->read_disabled_bios((adev))
+#define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
+#define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
+#define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
+#define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
+#define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
+#define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
+#define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
+#define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
+#define amdgpu_asic_supports_baco(adev) \
+    ((adev)->asic_funcs->supports_baco ? (adev)->asic_funcs->supports_baco((adev)) : 0)
+#define amdgpu_asic_pre_asic_init(adev)                                      \
+	{                                                                    \
+		if ((adev)->asic_funcs && (adev)->asic_funcs->pre_asic_init) \
+			(adev)->asic_funcs->pre_asic_init((adev));           \
+	}
+#define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
+	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
+#define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
+#endif
-- 
2.54.0

