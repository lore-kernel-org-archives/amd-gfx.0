Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26650CD8C81
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F9410E637;
	Fri,  5 Jun 2026 13:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAfHce5X";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5377910E632
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyIFQyTyRn8IUuGjOFts8DfmxOG+bJKbWBR2yrEdFRKeUL2bw2DQ0akz4R6mNXSndqi00p6c8m+Pw3Pjk1JPcEley9dSd/E1AmnHPIvZgGNqjSK54HkeRIVkLkqc7qz8Rj3U/2HHRNOHaW1J6PAbv6Cs2HvHuxyDB5o9hv25230kjWwERlRG97Rasz2orioAEt2UL5goBUG4XDROrfzzDSE82JxzQxok4iKZCU5GbBxUHqaWUj+y0Bf94bZ7SCR9Kdbq7MQpODzw+lswd05gne7+ENP285Kesp2tZAy2x0hntjn1fd5UJeqJMZRvMkSbQf/7RW+ylgWNP5bg1r5x4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/8rYdJyx8Mw73bjF9hxGnsfMPdzwumhC/IB51vYMsc=;
 b=ws1LCU3+d/9gmW0FCW2Ka5qmTTkWXYUCpN8bEatYtH3Qo8Q/fJyXfyUi+t9DlgwApy0sJ0iIAD5bqVcDHzMaSD+eiEtUmYUNwyferftfjNOEtN1Vbyx7hKhAeZrf6kTk3SF57r6MiAaCkkXUYtoGQ6rna43T832MSU1WajedVM72L3aKGF4N55czq9jW7AM7Up09JksgWd5PmWIHvAyGbLeI0nJMp2Kc3anfl5kzZOUGxZ44mvddMrCrRF6Yi7v2JiSkv7X2sqIIg5Ce0/nBnDFnrJSeY81U9Hezqg+8wTwv5Wo9VAxtPY1mHVb2zHWaNWjqUI4z7vYeMupmoifcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/8rYdJyx8Mw73bjF9hxGnsfMPdzwumhC/IB51vYMsc=;
 b=LAfHce5XJGagndegbhiVUYinVmnOJZbBvTKabRgy/aENlgwTUCsf+kBIc8tf7wZmrnfRWSQ7UuYHkAt3c8IDwDoB4iDUTHT2YRNDuikCkwmG7CA5xH3+RzI+K3ay7yjKOkRSwtUBVBOM8iCcPYJDdKqzoNiJNLsXZA5QHmWGPa0=
Received: from CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::20)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 5 Jun 2026
 13:44:23 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::74) by CH0P221CA0040.outlook.office365.com
 (2603:10b6:610:11d::20) with Microsoft SMTP Server (version=TLS1_3,
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
Subject: [PATCH 11/11] drm/amdgpu: move struct amdgpu_device and helpers into
 new header
Date: Fri, 5 Jun 2026 09:43:23 -0400
Message-ID: <20260605134400.956791-12-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ddaf8f-4f4e-452f-0b60-08dec3088dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099006|3023799007|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: khUYjsHuZdM+Bm+OY6VLT6c42hwNdUP5uPgRQzkC0wMt0OI/XS8wuYVUSlYWE9ch4QKRY7UtAMWtlA/g7o5Yo9fJ3QpCbEGQApk+th+Kw/zO5j/a0WV4tqGY+KFusvkSLfMeE4jbt6etnY06RYo7PofUjZQH/f404jt6cgIzJwwzQfMOvGA3tkTIHlQM6ip6z9ViwEwqL7oS/jZMUSvin2h5BKghPm0KSsnaw3fbHddvTTxjUCcLkusZqnNVVEHWVoEV85kVdvdk5p1EXtd0xwnl5VesZZ7sfUmzHVpOZ2b0t9h6SLg7BDz7kIVs1CxHZETXW3tD6N+MlkOhUrN7Mz27cq2lugwmtoXtJsZQ6PpEbQ94EMzki9Q8KY4iezfDTHjHd52YzOKRPfKLet7vY/PpbyYdr23/QBuvGf4jLjjlFLt0YKqIeMxtrxJUOoS0BjZMk5LUrJQy3Up3qAxsUKRTcHephqj+3LltpFhrm5+B94vs/FSoF1lguF8YZB7aFKP7UHqsS5yz1HNvYQUMyerPuZcRoDYa5u0Q4qvHWSoM0qE5vtFJR55NxuheJRn+Ldr2tBk2PKkSlZtya94L2NGH2UJwtoj1DcwmCm9yJCLjeWf61O6wRWStJ1m47+UfQWn+UkwOIGUj/s4WDp/qTEEzp1pXxtdG9i9hriNb9KOL3d2ovQ94OPdfe1XQeNd7vfvbjfhfu/3JB+/Lm3P1XbBrGPH+kYVFgMi3FakxAT8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(3023799007)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hMimUkIaB1gozEgOx/BmHuzu77RFUzuzNTEVizMnN7aWjihC2tlFsXzqM+75RnLfodX1FZVEJi/A4Gfh5tCNU5F5AoaBdB07/ehCvLE376OKkAkNOKw9RWFwblj53FLPdiDwOYGffrChv8k0DiPa4sGng3IOpxkVG8hEAKF+d36zst35e64RVd62Jwf7Pk2LhlqN5VhjU5dzlz9en4w+TtNzuUjh1VQPQGl539nfpKr91fDUtwyPVnjCRCmPbKkCJi0Px6YJr1UlR8dcVus9NamUZgdS/YcHw1ro/62Nx0QNbd8NLZXP/MmNG/pOb+UK7oQOVRF3UFH8hBJHCmFA+XXsmPSBkocoK4KzgL11jqUYml4Yy1D+hWmhw8oZhfky+fHlHfvr4jEAUqUxwxj5O/tJGRTvZ6RxRNYd4Pn7HcofjN+cMQ2Aj7TDbO/e5NRZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:23.7442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ddaf8f-4f4e-452f-0b60-08dec3088dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

Move struct amdgpu_device, struct amdgpu_mem_scratch, struct amdgpu_mmio_remap,
struct amdgpu_powerplay, struct amdgpu_pcie_reset_ctx, and relevant helpers
from the monolithic amdgpu.h file into a new amdgpu_device.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 484 +----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.h | 586 +++++++++++++++++++++
 2 files changed, 590 insertions(+), 480 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_device.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 812bd0f6ff0d..0ce37fc213cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -120,6 +120,7 @@
 #include "amdgpu_uid.h"
 #include "amdgpu_video_codecs.h"
 #include "amdgpu_asic.h"
+#include "amdgpu_device.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -429,400 +430,15 @@ int amdgpu_cs_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 
-/* VRAM scratch page for HDP bug, default vram page */
-struct amdgpu_mem_scratch {
-	struct amdgpu_bo		*robj;
-	uint32_t			*ptr;
-	u64				gpu_addr;
-};
-
 /*
  * CGS
  */
 struct cgs_device *amdgpu_cgs_create_device(struct amdgpu_device *adev);
 void amdgpu_cgs_destroy_device(struct cgs_device *cgs_device);
 
-/*
- * Core structure, functions and helpers.
- */
-struct amdgpu_mmio_remap {
-	u32 reg_offset;
-	resource_size_t bus_addr;
-	struct amdgpu_bo *bo;
-};
-
-struct amd_powerplay {
-	void *pp_handle;
-	const struct amd_pm_funcs *pp_funcs;
-};
-
-struct amdgpu_pcie_reset_ctx {
-	bool in_link_reset;
-	bool occurs_dpc;
-	bool audio_suspended;
-	struct pci_dev *swus;
-	struct pci_saved_state *swus_pcistate;
-	struct pci_saved_state *swds_pcistate;
-};
-
-#define AMDGPU_RESET_MAGIC_NUM 64
-#define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_reset_domain;
 struct amdgpu_fru_info;
 
-enum amdgpu_enforce_isolation_mode {
-	AMDGPU_ENFORCE_ISOLATION_DISABLE = 0,
-	AMDGPU_ENFORCE_ISOLATION_ENABLE = 1,
-	AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY = 2,
-	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
-};
-
-struct amdgpu_device {
-	struct device			*dev;
-	struct pci_dev			*pdev;
-	struct drm_device		ddev;
-
-#ifdef CONFIG_DRM_AMD_ACP
-	struct amdgpu_acp		acp;
-#endif
-	struct amdgpu_hive_info *hive;
-	struct amdgpu_xcp_mgr *xcp_mgr;
-	/* ASIC */
-	enum amd_asic_type		asic_type;
-	uint32_t			family;
-	uint32_t			rev_id;
-	uint32_t			external_rev_id;
-	unsigned long			flags;
-	unsigned long			apu_flags;
-	int				usec_timeout;
-	const struct amdgpu_asic_funcs	*asic_funcs;
-	bool				shutdown;
-	bool				need_swiotlb;
-	bool				accel_working;
-	struct notifier_block		acpi_nb;
-	struct notifier_block		pm_nb;
-	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
-	struct debugfs_blob_wrapper debugfs_vbios_blob;
-	struct mutex			srbm_mutex;
-	/* GRBM index mutex. Protects concurrent access to GRBM index */
-	struct mutex                    grbm_idx_mutex;
-	struct dev_pm_domain		vga_pm_domain;
-	bool				have_disp_power_ref;
-	bool                            have_atomics_support;
-
-	/* BIOS */
-	bool				is_atom_fw;
-	uint8_t				*bios;
-	uint32_t			bios_size;
-	uint32_t			bios_scratch_reg_offset;
-	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
-
-	/* Register/doorbell mmio */
-	resource_size_t			rmmio_base;
-	resource_size_t			rmmio_size;
-	void __iomem			*rmmio;
-	/* protects concurrent MM_INDEX/DATA based register access */
-	spinlock_t mmio_idx_lock;
-	struct amdgpu_mmio_remap        rmmio_remap;
-	/* Indirect register access blocks */
-	struct amdgpu_reg_access reg;
-	struct amdgpu_doorbell		doorbell;
-
-	/* clock/pll info */
-	struct amdgpu_clock            clock;
-
-	/* MC */
-	struct amdgpu_gmc		gmc;
-	struct amdgpu_gart		gart;
-	dma_addr_t			dummy_page_addr;
-	struct amdgpu_vm_manager	vm_manager;
-	struct amdgpu_vmhub             vmhub[AMDGPU_MAX_VMHUBS];
-	DECLARE_BITMAP(vmhubs_mask, AMDGPU_MAX_VMHUBS);
-
-	/* memory management */
-	struct amdgpu_mman		mman;
-	struct amdgpu_mem_scratch	mem_scratch;
-	struct amdgpu_wb		wb;
-	atomic64_t			num_bytes_moved;
-	atomic64_t			num_evictions;
-	atomic64_t			num_vram_cpu_page_faults;
-	atomic_t			gpu_reset_counter;
-	atomic_t			vram_lost_counter;
-
-	/* data for buffer migration throttling */
-	struct {
-		spinlock_t		lock;
-		s64			last_update_us;
-		s64			accum_us; /* accumulated microseconds */
-		s64			accum_us_vis; /* for visible VRAM */
-		u32			log2_max_MBps;
-	} mm_stats;
-
-	/* discovery*/
-	struct amdgpu_discovery_info discovery;
-
-	/* display */
-	bool				enable_virtual_display;
-	struct amdgpu_vkms_output       *amdgpu_vkms_output;
-	struct amdgpu_mode_info		mode_info;
-	/* For pre-DCE11. DCE11 and later are in "struct amdgpu_device->dm" */
-	struct delayed_work         hotplug_work;
-	struct amdgpu_irq_src		crtc_irq;
-	struct amdgpu_irq_src		vline0_irq;
-	struct amdgpu_irq_src		vupdate_irq;
-	struct amdgpu_irq_src		pageflip_irq;
-	struct amdgpu_irq_src		hpd_irq;
-	struct amdgpu_irq_src		dmub_trace_irq;
-	struct amdgpu_irq_src		dmub_outbox_irq;
-
-	/* rings */
-	u64				fence_context;
-	unsigned			num_rings;
-	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
-	struct dma_fence __rcu		*gang_submit;
-	bool				ib_pool_ready;
-	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
-	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
-
-	/* interrupts */
-	struct amdgpu_irq		irq;
-
-	/* powerplay */
-	struct amd_powerplay		powerplay;
-	struct amdgpu_pm		pm;
-	u64				cg_flags;
-	u32				pg_flags;
-
-	/* nbio */
-	struct amdgpu_nbio		nbio;
-
-	/* hdp */
-	struct amdgpu_hdp		hdp;
-
-	/* smuio */
-	struct amdgpu_smuio		smuio;
-
-	/* mmhub */
-	struct amdgpu_mmhub		mmhub;
-
-	/* gfxhub */
-	struct amdgpu_gfxhub		gfxhub;
-
-	/* gfx */
-	struct amdgpu_gfx		gfx;
-
-	/* sdma */
-	struct amdgpu_sdma		sdma;
-
-	/* lsdma */
-	struct amdgpu_lsdma		lsdma;
-
-	/* uvd */
-	struct amdgpu_uvd		uvd;
-
-	/* vce */
-	struct amdgpu_vce		vce;
-
-	/* vcn */
-	struct amdgpu_vcn		vcn;
-
-	/* jpeg */
-	struct amdgpu_jpeg		jpeg;
-
-	/* vpe */
-	struct amdgpu_vpe		vpe;
-
-	/* umsch */
-	struct amdgpu_umsch_mm		umsch_mm;
-	bool				enable_umsch_mm;
-
-	/* firmwares */
-	struct amdgpu_firmware		firmware;
-
-	/* PSP */
-	struct psp_context		psp;
-
-	/* GDS */
-	struct amdgpu_gds		gds;
-
-	/* for userq and VM fences */
-	struct amdgpu_seq64		seq64;
-
-	/* UMC */
-	struct amdgpu_umc		umc;
-
-	/* display related functionality */
-	struct amdgpu_display_manager dm;
-
-#if defined(CONFIG_DRM_AMD_ISP)
-	/* isp */
-	struct amdgpu_isp		isp;
-#endif
-
-	/* mes */
-	bool                            enable_mes;
-	bool                            enable_mes_kiq;
-	bool                            enable_uni_mes;
-	struct amdgpu_mes               mes;
-	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
-	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
-
-	/**
-	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
-	 * Key: doorbell_index (unique global identifier for the queue)
-	 * Value: struct amdgpu_usermode_queue
-	 */
-	struct xarray userq_doorbell_xa;
-
-	/* df */
-	struct amdgpu_df                df;
-
-	/* MCA */
-	struct amdgpu_mca               mca;
-
-	/* ACA */
-	struct amdgpu_aca		aca;
-
-	/* CPER */
-	struct amdgpu_cper		cper;
-
-	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
-	uint32_t		        harvest_ip_mask;
-	int				num_ip_blocks;
-	struct mutex	mn_lock;
-	DECLARE_HASHTABLE(mn_hash, 7);
-
-	/* tracking pinned memory */
-	atomic64_t vram_pin_size;
-	atomic64_t visible_pin_size;
-	atomic64_t gart_pin_size;
-
-	/* soc15 register offset based on ip, instance and  segment */
-	uint32_t		*reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
-	struct amdgpu_ip_map_info	ip_map;
-
-	/* delayed work_func for deferring clockgating during resume */
-	struct delayed_work     delayed_init_work;
-
-	struct amdgpu_virt	virt;
-
-	/* record hw reset is performed */
-	bool has_hw_reset;
-	u8				reset_magic[AMDGPU_RESET_MAGIC_NUM];
-
-	/* s3/s4 mask */
-	bool                            in_suspend;
-	bool				in_s3;
-	bool				in_s4;
-	bool				in_s0ix;
-	suspend_state_t			last_suspend_state;
-
-	enum pp_mp1_state               mp1_state;
-	struct amdgpu_doorbell_index doorbell_index;
-
-	struct mutex			notifier_lock;
-
-	int asic_reset_res;
-	struct work_struct		xgmi_reset_work;
-	struct list_head		reset_list;
-
-	long				gfx_timeout;
-	long				sdma_timeout;
-	long				video_timeout;
-	long				compute_timeout;
-	long				psp_timeout;
-
-	uint64_t			unique_id;
-	uint8_t				unitid;
-	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
-
-	/* enable runtime pm on the device */
-	bool                            in_runpm;
-	bool                            has_pr3;
-
-	bool                            ucode_sysfs_en;
-
-	struct amdgpu_fru_info		*fru_info;
-	atomic_t			throttling_logging_enabled;
-	struct ratelimit_state		throttling_logging_rs;
-	uint32_t                        ras_hw_enabled;
-	uint32_t                        ras_enabled;
-	bool                            ras_default_ecc_enabled;
-
-	bool                            no_hw_access;
-	struct pci_saved_state          *pci_state;
-	pci_channel_state_t		pci_channel_state;
-
-	struct amdgpu_pcie_reset_ctx	pcie_reset_ctx;
-
-	/* Track auto wait count on s_barrier settings */
-	bool				barrier_has_auto_waitcnt;
-
-	struct amdgpu_reset_control     *reset_cntl;
-	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
-
-	bool				ram_is_direct_mapped;
-
-	struct list_head                ras_list;
-
-	struct amdgpu_reset_domain	*reset_domain;
-
-#ifdef CONFIG_DEV_COREDUMP
-	struct amdgpu_coredump_info	*coredump;
-	struct work_struct		coredump_work;
-#endif
-
-	struct mutex			benchmark_mutex;
-
-	bool                            scpm_enabled;
-	uint32_t                        scpm_status;
-
-	struct work_struct		reset_work;
-
-	bool                            dc_enabled;
-	/* Mask of active clusters */
-	uint32_t			aid_mask;
-
-	/* Debug */
-	bool                            debug_vm;
-	bool                            debug_largebar;
-	bool                            debug_disable_soft_recovery;
-	bool                            debug_use_vram_fw_buf;
-	bool                            debug_enable_ras_aca;
-	bool                            debug_exp_resets;
-	bool                            debug_disable_gpu_ring_reset;
-	bool                            debug_vm_userptr;
-	bool                            debug_disable_ce_logs;
-	bool                            debug_enable_ce_cs;
-
-	/* Protection for the following isolation structure */
-	struct mutex                    enforce_isolation_mutex;
-	enum amdgpu_enforce_isolation_mode	enforce_isolation[MAX_XCP];
-	struct amdgpu_isolation {
-		void			*owner;
-		struct dma_fence	*spearhead;
-		struct amdgpu_sync	active;
-		struct amdgpu_sync	prev;
-	} isolation[MAX_XCP];
-
-	struct amdgpu_init_level *init_lvl;
-
-	/* This flag is used to determine how VRAM allocations are handled for APUs
-	 * in KFD: VRAM or GTT.
-	 */
-	bool                            apu_prefer_gtt;
-
-	bool                            userq_halt_for_enforce_isolation;
-	struct amdgpu_uid *uid_info;
-
-	struct amdgpu_uma_carveout_info uma_info;
-
-	/* KFD
-	 * Must be last --ends in a flexible-array member.
-	 */
-	struct amdgpu_kfd_dev		kfd;
-};
-
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 					 uint8_t ip, uint8_t inst)
 {
@@ -859,35 +475,9 @@ static inline bool amdgpu_is_multi_aid(struct amdgpu_device *adev)
 	return !!adev->aid_mask;
 }
 
-int amdgpu_device_init(struct amdgpu_device *adev,
-		       uint32_t flags);
-void amdgpu_device_fini_hw(struct amdgpu_device *adev);
-void amdgpu_device_fini_sw(struct amdgpu_device *adev);
 
 int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
 
-void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
-			     void *buf, size_t size, bool write);
-size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
-				 void *buf, size_t size, bool write);
-
-void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
-			       void *buf, size_t size, bool write);
-u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
-bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
-				       enum amd_asic_type asic_type);
-bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
-
-void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev);
-
-int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
-				 struct amdgpu_reset_context *reset_context);
-
-int amdgpu_do_asic_reset(struct list_head *device_list_handle,
-			 struct amdgpu_reset_context *reset_context);
-
-int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context);
-
 int emu_soc_asic_init(struct amdgpu_device *adev);
 
 /*
@@ -995,54 +585,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define for_each_inst(i, inst_mask)        \
 	for (i = ffs(inst_mask); i-- != 0; \
 	     i = ffs(inst_mask & BIT_MASK_UPPER(i + 1)))
-
-/* Common functions */
-bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
-bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
-int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
-			      struct amdgpu_job *job,
-			      struct amdgpu_reset_context *reset_context);
-void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
-int amdgpu_device_pci_reset(struct amdgpu_device *adev);
-bool amdgpu_device_need_post(struct amdgpu_device *adev);
-bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev);
-bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
-
+/* Common function */
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
-				  u64 num_vis_bytes);
-int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev);
-void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
-					     const u32 *registers,
-					     const u32 array_size);
-
-int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
-int amdgpu_device_link_reset(struct amdgpu_device *adev);
-bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
-bool amdgpu_device_supports_px(struct amdgpu_device *adev);
-bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
-bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
-int amdgpu_device_supports_baco(struct amdgpu_device *adev);
-void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
-bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
-				      struct amdgpu_device *peer_adev);
-int amdgpu_device_baco_enter(struct amdgpu_device *adev);
-int amdgpu_device_baco_exit(struct amdgpu_device *adev);
-
-void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
-		struct amdgpu_ring *ring);
-void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
-		struct amdgpu_ring *ring);
-
-void amdgpu_device_halt(struct amdgpu_device *adev);
-struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
-struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
-					    struct dma_fence *gang);
-struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
-						  struct amdgpu_ring *ring,
-						  struct amdgpu_job *job);
-bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
-ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
-ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
+		u64 num_vis_bytes);
+
 void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
 				   const struct amdgpu_vm_pte_funcs *vm_pte_funcs);
 void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
@@ -1076,10 +622,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 				 struct drm_file *file_priv);
 void amdgpu_driver_release_kms(struct drm_device *dev);
 
-int amdgpu_device_prepare(struct drm_device *dev);
-void amdgpu_device_complete(struct drm_device *dev);
-int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
-int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
 int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
@@ -1108,22 +650,6 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock);
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
 
-pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
-					   pci_channel_state_t state);
-pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
-pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
-void amdgpu_pci_resume(struct pci_dev *pdev);
-
-bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
-bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
-
-bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev);
-
-int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
-			       enum amd_clockgating_state state);
-int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
-			       enum amd_powergating_state state);
-
 static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
 {
 	return amdgpu_gpu_recovery != 0 &&
@@ -1140,8 +666,6 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
        return adev->gmc.tmz_enabled;
 }
 
-int amdgpu_in_reset(struct amdgpu_device *adev);
-
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_flash_attr_group;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.h
new file mode 100644
index 000000000000..92bc7916ed43
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.h
@@ -0,0 +1,586 @@
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
+#ifndef __AMDGPU_DEVICE_H__
+#define __AMDGPU_DEVICE_H__
+
+#include "kgd_pp_interface.h"
+#include <linux/ratelimit_types.h>
+#include <linux/suspend.h>
+#include <linux/workqueue_types.h>
+#include <linux/types.h>
+#include <linux/notifier.h>
+#include <linux/debugfs.h>
+#include <drm/drm_device.h>
+#include <drm/amd_asic_type.h>
+#include "amdgpu_mode.h"
+#include <linux/mutex_types.h>
+#include <linux/pm.h>
+#include <linux/workqueue.h>
+
+#include "amdgpu_sa.h"
+
+#include "amdgpu_ras.h"
+#include "amdgpu_wb.h"
+#include "amdgpu_reg_access.h"
+#include "amdgpu_gmc.h"
+#include "amdgpu_gart.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_ttm.h"
+#include "amdgpu_discovery.h"
+#include "amdgpu_irq.h"
+#include "amdgpu_doorbell.h"
+#include "amdgpu_sched.h"
+#include "amdgpu_dpm.h"
+#include "amdgpu_nbio.h"
+#include "amdgpu_hdp.h"
+#include "amdgpu_smuio.h"
+#include "amdgpu_mmhub.h"
+#include "amdgpu_gfxhub.h"
+#include "amdgpu_gfx.h"
+#include "amdgpu_sdma.h"
+#include "amdgpu_lsdma.h"
+#include "amdgpu_uvd.h"
+#include "amdgpu_vce.h"
+#include "amdgpu_ucode.h"
+#include "amdgpu_vcn.h"
+#include "amdgpu_jpeg.h"
+#include "amdgpu_vpe.h"
+#include "amdgpu_umsch_mm.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_gds.h"
+#include "amdgpu_seq64.h"
+#include "amdgpu_umc.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_mes.h"
+#include "amdgpu_mqd.h"
+#include <linux/xarray.h>
+#include "amdgpu_df.h"
+#include "amdgpu_mca.h"
+#include "amdgpu_aca.h"
+#include "amdgpu_cper.h"
+#include "amdgpu_ip.h"
+#include "amdgpu_virt.h"
+#include "amdgpu_sync.h"
+#include "amdgpu_init_level.h"
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_uid.h"
+#include "amdgpu_userq.h"
+#include "amdgpu_vkms.h"
+
+#include "amdgpu_asic.h"
+
+#if defined(CONFIG_DRM_AMD_ISP)
+#include "amdgpu_isp.h"
+#endif
+
+#define AMDGPU_BIOS_NUM_SCRATCH		16
+#define AMDGPU_RESET_MAGIC_NUM		64
+#define AMDGPU_MAX_DF_PERFMONS		4
+
+struct amdgpu_hive_info;
+struct amdgpu_xcp_mgr;
+struct amdgpu_asic_funcs;
+struct dma_fence;
+struct amdgpu_fru_info;
+struct amdgpu_reset_domain;
+struct amdgpu_coredump_info;
+
+/* VRAM scratch page for HDP bug, default vram page */
+struct amdgpu_mem_scratch {
+	struct amdgpu_bo		*robj;
+	uint32_t			*ptr;
+	u64				gpu_addr;
+};
+
+/*
+ * Core structure, functions and helpers.
+ */
+struct amdgpu_mmio_remap {
+	u32 reg_offset;
+	resource_size_t bus_addr;
+	struct amdgpu_bo *bo;
+};
+
+struct amd_powerplay {
+	void *pp_handle;
+	const struct amd_pm_funcs *pp_funcs;
+};
+
+struct amdgpu_pcie_reset_ctx {
+	bool in_link_reset;
+	bool occurs_dpc;
+	bool audio_suspended;
+	struct pci_dev *swus;
+	struct pci_saved_state *swus_pcistate;
+	struct pci_saved_state *swds_pcistate;
+};
+
+enum amdgpu_enforce_isolation_mode {
+	AMDGPU_ENFORCE_ISOLATION_DISABLE = 0,
+	AMDGPU_ENFORCE_ISOLATION_ENABLE = 1,
+	AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY = 2,
+	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
+};
+
+struct amdgpu_device {
+	struct device			*dev;
+	struct pci_dev			*pdev;
+	struct drm_device		ddev;
+
+#ifdef CONFIG_DRM_AMD_ACP
+	struct amdgpu_acp		acp;
+#endif
+	struct amdgpu_hive_info		*hive;
+	struct amdgpu_xcp_mgr		*xcp_mgr;
+	/* ASIC */
+	enum amd_asic_type		asic_type;
+	uint32_t			family;
+	uint32_t			rev_id;
+	uint32_t			external_rev_id;
+	unsigned long			flags;
+	unsigned long			apu_flags;
+	int				usec_timeout;
+	const struct amdgpu_asic_funcs	*asic_funcs;
+	bool				shutdown;
+	bool				need_swiotlb;
+	bool				accel_working;
+	struct notifier_block		acpi_nb;
+	struct notifier_block		pm_nb;
+	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
+	struct debugfs_blob_wrapper	debugfs_vbios_blob;
+	struct mutex			srbm_mutex;
+	/* GRBM index mutex. Protects concurrent access to GRBM index */
+	struct mutex			grbm_idx_mutex;
+	struct dev_pm_domain		vga_pm_domain;
+	bool				have_disp_power_ref;
+	bool				have_atomics_support;
+
+	/* BIOS */
+	bool				is_atom_fw;
+	uint8_t				*bios;
+	uint32_t			bios_size;
+	uint32_t			bios_scratch_reg_offset;
+	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
+
+	/* Register/doorbell mmio */
+	resource_size_t			rmmio_base;
+	resource_size_t			rmmio_size;
+	void __iomem			*rmmio;
+	/* protects concurrent MM_INDEX/DATA based register access */
+	spinlock_t mmio_idx_lock;
+	struct amdgpu_mmio_remap	rmmio_remap;
+	/* Indirect register access blocks */
+	struct amdgpu_reg_access	reg;
+	struct amdgpu_doorbell		doorbell;
+
+	/* clock/pll info */
+	struct amdgpu_clock		clock;
+
+	/* MC */
+	struct amdgpu_gmc		gmc;
+	struct amdgpu_gart		gart;
+	dma_addr_t			dummy_page_addr;
+	struct amdgpu_vm_manager	vm_manager;
+	struct amdgpu_vmhub		vmhub[AMDGPU_MAX_VMHUBS];
+	DECLARE_BITMAP(vmhubs_mask, AMDGPU_MAX_VMHUBS);
+
+	/* memory management */
+	struct amdgpu_mman		mman;
+	struct amdgpu_mem_scratch	mem_scratch;
+	struct amdgpu_wb		wb;
+	atomic64_t			num_bytes_moved;
+	atomic64_t			num_evictions;
+	atomic64_t			num_vram_cpu_page_faults;
+	atomic_t			gpu_reset_counter;
+	atomic_t			vram_lost_counter;
+
+	/* data for buffer migration throttling */
+	struct {
+		spinlock_t		lock;
+		s64			last_update_us;
+		s64			accum_us; /* accumulated microseconds */
+		s64			accum_us_vis; /* for visible VRAM */
+		u32			log2_max_MBps;
+	} mm_stats;
+
+	/* discovery*/
+	struct amdgpu_discovery_info discovery;
+
+	/* display */
+	bool				enable_virtual_display;
+	struct amdgpu_vkms_output	*amdgpu_vkms_output;
+	struct amdgpu_mode_info		mode_info;
+	/* For pre-DCE11. DCE11 and later are in "struct amdgpu_device->dm" */
+	struct delayed_work		hotplug_work;
+	struct amdgpu_irq_src		crtc_irq;
+	struct amdgpu_irq_src		vline0_irq;
+	struct amdgpu_irq_src		vupdate_irq;
+	struct amdgpu_irq_src		pageflip_irq;
+	struct amdgpu_irq_src		hpd_irq;
+	struct amdgpu_irq_src		dmub_trace_irq;
+	struct amdgpu_irq_src		dmub_outbox_irq;
+
+	/* rings */
+	u64				fence_context;
+	unsigned int num_rings;
+	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
+	struct dma_fence __rcu		*gang_submit;
+	bool				ib_pool_ready;
+	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
+	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
+
+	/* interrupts */
+	struct amdgpu_irq		irq;
+
+	/* powerplay */
+	struct amd_powerplay		powerplay;
+	struct amdgpu_pm		pm;
+	u64				cg_flags;
+	u32				pg_flags;
+
+	/* nbio */
+	struct amdgpu_nbio		nbio;
+
+	/* hdp */
+	struct amdgpu_hdp		hdp;
+
+	/* smuio */
+	struct amdgpu_smuio		smuio;
+
+	/* mmhub */
+	struct amdgpu_mmhub		mmhub;
+
+	/* gfxhub */
+	struct amdgpu_gfxhub		gfxhub;
+
+	/* gfx */
+	struct amdgpu_gfx		gfx;
+
+	/* sdma */
+	struct amdgpu_sdma		sdma;
+
+	/* lsdma */
+	struct amdgpu_lsdma		lsdma;
+
+	/* uvd */
+	struct amdgpu_uvd		uvd;
+
+	/* vce */
+	struct amdgpu_vce		vce;
+
+	/* vcn */
+	struct amdgpu_vcn		vcn;
+
+	/* jpeg */
+	struct amdgpu_jpeg		jpeg;
+
+	/* vpe */
+	struct amdgpu_vpe		vpe;
+
+	/* umsch */
+	struct amdgpu_umsch_mm		umsch_mm;
+	bool				enable_umsch_mm;
+
+	/* firmwares */
+	struct amdgpu_firmware		firmware;
+
+	/* PSP */
+	struct psp_context		psp;
+
+	/* GDS */
+	struct amdgpu_gds		gds;
+
+	/* for userq and VM fences */
+	struct amdgpu_seq64		seq64;
+
+	/* UMC */
+	struct amdgpu_umc		umc;
+
+	/* display related functionality */
+	struct amdgpu_display_manager	dm;
+
+#if defined(CONFIG_DRM_AMD_ISP)
+	/* isp */
+	struct amdgpu_isp		isp;
+#endif
+
+	/* mes */
+	bool				enable_mes;
+	bool				enable_mes_kiq;
+	bool				enable_uni_mes;
+	struct amdgpu_mes		mes;
+	struct amdgpu_mqd		mqds[AMDGPU_HW_IP_NUM];
+	const struct amdgpu_userq_funcs	*userq_funcs[AMDGPU_HW_IP_NUM];
+
+	/**
+	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue) Key: doorbell_index (unique global identifier for the queue)
+	 * Value: struct amdgpu_usermode_queue
+	 */
+	struct xarray userq_doorbell_xa;
+
+	/* df */
+	struct amdgpu_df		df;
+
+	/* MCA */
+	struct amdgpu_mca		mca;
+
+	/* ACA */
+	struct amdgpu_aca		aca;
+
+	/* CPER */
+	struct amdgpu_cper		cper;
+
+	struct amdgpu_ip_block		ip_blocks[AMDGPU_MAX_IP_NUM];
+	uint32_t			harvest_ip_mask;
+	int				num_ip_blocks;
+	struct mutex	mn_lock;
+	DECLARE_HASHTABLE(mn_hash, 7);
+
+	/* tracking pinned memory */
+	atomic64_t vram_pin_size;
+	atomic64_t visible_pin_size;
+	atomic64_t gart_pin_size;
+
+	/* soc15 register offset based on ip, instance and  segment */
+	uint32_t		*reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
+	struct amdgpu_ip_map_info	ip_map;
+
+	/* delayed work_func for deferring clockgating during resume */
+	struct delayed_work	delayed_init_work;
+
+	struct amdgpu_virt	virt;
+
+	/* record hw reset is performed */
+	bool has_hw_reset;
+	u8				reset_magic[AMDGPU_RESET_MAGIC_NUM];
+
+	/* s3/s4 mask */
+	bool				in_suspend;
+	bool				in_s3;
+	bool				in_s4;
+	bool				in_s0ix;
+	suspend_state_t			last_suspend_state;
+
+	enum pp_mp1_state		mp1_state;
+	struct amdgpu_doorbell_index	doorbell_index;
+
+	struct mutex			notifier_lock;
+
+	int asic_reset_res;
+	struct work_struct		xgmi_reset_work;
+	struct list_head		reset_list;
+
+	long				gfx_timeout;
+	long				sdma_timeout;
+	long				video_timeout;
+	long				compute_timeout;
+	long				psp_timeout;
+
+	uint64_t			unique_id;
+	uint8_t				unitid;
+	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
+
+	/* enable runtime pm on the device */
+	bool				in_runpm;
+	bool				has_pr3;
+
+	bool				ucode_sysfs_en;
+
+	struct amdgpu_fru_info		*fru_info;
+	atomic_t			throttling_logging_enabled;
+	struct ratelimit_state		throttling_logging_rs;
+	uint32_t			ras_hw_enabled;
+	uint32_t			ras_enabled;
+	bool				ras_default_ecc_enabled;
+
+	bool				no_hw_access;
+	struct pci_saved_state		*pci_state;
+	pci_channel_state_t		pci_channel_state;
+
+	struct amdgpu_pcie_reset_ctx	pcie_reset_ctx;
+
+	/* Track auto wait count on s_barrier settings */
+	bool				barrier_has_auto_waitcnt;
+
+	struct amdgpu_reset_control	*reset_cntl;
+	uint32_t			ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
+
+	bool				ram_is_direct_mapped;
+
+	struct list_head		ras_list;
+
+	struct amdgpu_reset_domain	*reset_domain;
+
+#ifdef CONFIG_DEV_COREDUMP
+	struct amdgpu_coredump_info	*coredump;
+	struct work_struct		coredump_work;
+#endif
+
+	struct mutex			benchmark_mutex;
+
+	bool				scpm_enabled;
+	uint32_t			scpm_status;
+
+	struct work_struct		reset_work;
+
+	bool				dc_enabled;
+	/* Mask of active clusters */
+	uint32_t			aid_mask;
+
+	/* Debug */
+	bool				debug_vm;
+	bool				debug_largebar;
+	bool				debug_disable_soft_recovery;
+	bool				debug_use_vram_fw_buf;
+	bool				debug_enable_ras_aca;
+	bool				debug_exp_resets;
+	bool				debug_disable_gpu_ring_reset;
+	bool				debug_vm_userptr;
+	bool				debug_disable_ce_logs;
+	bool				debug_enable_ce_cs;
+
+	/* Protection for the following isolation structure */
+	struct mutex			enforce_isolation_mutex;
+	enum amdgpu_enforce_isolation_mode	enforce_isolation[MAX_XCP];
+	struct amdgpu_isolation {
+		void			*owner;
+		struct dma_fence	*spearhead;
+		struct amdgpu_sync	active;
+		struct amdgpu_sync	prev;
+	} isolation[MAX_XCP];
+
+	struct amdgpu_init_level *init_lvl;
+
+	/* This flag is used to determine how VRAM allocations are handled for APUs
+	 * in KFD: VRAM or GTT.
+	 */
+	bool				apu_prefer_gtt;
+
+	bool				userq_halt_for_enforce_isolation;
+	struct amdgpu_uid		*uid_info;
+
+	struct amdgpu_uma_carveout_info	uma_info;
+
+	/* KFD
+	 * Must be last --ends in a flexible-array member.
+	 */
+	struct amdgpu_kfd_dev		kfd;
+};
+int amdgpu_device_init(struct amdgpu_device *adev,
+		uint32_t flags);
+void amdgpu_device_fini_hw(struct amdgpu_device *adev);
+void amdgpu_device_fini_sw(struct amdgpu_device *adev);
+
+void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
+		void *buf, size_t size, bool write);
+size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
+		void *buf, size_t size, bool write);
+
+void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
+		void *buf, size_t size, bool write);
+u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
+bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
+		enum amd_asic_type asic_type);
+bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
+
+void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev);
+
+int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
+		struct amdgpu_reset_context *reset_context);
+
+int amdgpu_do_asic_reset(struct list_head *device_list_handle,
+		struct amdgpu_reset_context *reset_context);
+
+int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context);
+
+#include "amdgpu_reset.h"
+
+/* Common functions */
+bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
+bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
+int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
+		struct amdgpu_job *job,
+		struct amdgpu_reset_context *reset_context);
+void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
+int amdgpu_device_pci_reset(struct amdgpu_device *adev);
+bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev);
+bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
+
+int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev);
+void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
+		const u32 *registers,
+		const u32 array_size);
+
+int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
+int amdgpu_device_link_reset(struct amdgpu_device *adev);
+bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
+bool amdgpu_device_supports_px(struct amdgpu_device *adev);
+bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
+bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
+int amdgpu_device_supports_baco(struct amdgpu_device *adev);
+void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
+bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
+		struct amdgpu_device *peer_adev);
+int amdgpu_device_baco_enter(struct amdgpu_device *adev);
+int amdgpu_device_baco_exit(struct amdgpu_device *adev);
+
+void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring);
+void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring);
+
+void amdgpu_device_halt(struct amdgpu_device *adev);
+struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
+struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
+		struct dma_fence *gang);
+struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
+		struct amdgpu_ring *ring,
+		struct amdgpu_job *job);
+bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
+ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
+ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
+
+int amdgpu_device_prepare(struct drm_device *dev);
+void amdgpu_device_complete(struct drm_device *dev);
+int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
+int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
+
+pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
+		pci_channel_state_t state);
+pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
+pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
+void amdgpu_pci_resume(struct pci_dev *pdev);
+
+bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
+bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
+
+bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev);
+
+int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
+		enum amd_clockgating_state state);
+int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
+		enum amd_powergating_state state);
+int amdgpu_in_reset(struct amdgpu_device *adev);
+#endif
-- 
2.54.0

