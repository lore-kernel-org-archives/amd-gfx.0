Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665BBC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 19:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EDA10E52A;
	Tue, 15 Feb 2022 19:24:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC77710E56A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 19:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8xUeVfVzYgg58mXjgkIzuRqKhj9bzgCFZLFtvaVMoeilg7NHLWvjHpo+V/9ojwr1No488l0cT4EeiZXzDSHrNGy1BxKZ03q2U0GIKgCiIYhMu2Wk0HzZWUAetzmH4HgHxNpIKAx2N4wo591PJX0jvsl3XxlFnn/7QHYQ9zsdUSKRFYuZIRj6NCdhSgJO186qjecVWo1pPORDRyGzJF7q9wL6KME1JVsilrf6VkAJpJp8hBDNEG7QsYinQKjAK2NExmkzRpgPzbpPeBCqabY64tPPltV0WDc352NAPUh1rH22fmRw1bnM4v03v30sFGfjpu0nYH0D6VeJEfk9jiWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0raEQVRevYCqmZN89qzaLWpTnRNorpdZzDcQbS2+jKI=;
 b=kgnVMTjuKJdv+6bBTp0xVBhYjQGU8TDBpBkZyi9gk7FnA4iAee7qrA9DuuPxHUOCCYCaYXoiOVz+Hx+xFIvDGpmturKoDQAdtqY+Sh27YElZvIyYt3PKST/647Xd7VcnUGc1X79UVHl9KuyrtjTcMrWCuh+4wKkJOJi6gYYjbzOySpD76kNqTcqujvnZqxJBxke3Q9wyTQdNP2ylAtk2c2F7ePXBGb98GOT9A+3+bat7h+ZAs8tociAwVu/fS1COnktpMEm8ek3s//lnw9LTc2lrDqLswXJBuD3Tt2C5pGvW+xe5c1mcRtSfoaZkpORi/RNUoijYM7Uqx3TNNMbe4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0raEQVRevYCqmZN89qzaLWpTnRNorpdZzDcQbS2+jKI=;
 b=k8EmuSLx6LMqtmYA2SyBA18f9U6nSPRFEZ/j86fSGw0NZc0x16hEfYVfiok9FgPyv2fHL+zp/+kymcvfP6WKBMWe1ESE3MZ7h49+vRR44zglj6b8jgi0ENlKeIrhgFfEc9eCeuGtmxN9Xee0bXMhRoP2y2dzWGQHOOiYT6RBtp4=
Received: from MWHPR18CA0057.namprd18.prod.outlook.com (2603:10b6:300:39::19)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 19:24:29 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::44) by MWHPR18CA0057.outlook.office365.com
 (2603:10b6:300:39::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Tue, 15 Feb 2022 19:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 19:24:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 13:24:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: Add GC 10.3.7 Support
Date: Tue, 15 Feb 2022 14:24:15 -0500
Message-ID: <20220215192415.2232401-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 323d0fb4-04a9-4b88-f45b-08d9f0b8c949
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5946531F883F0391C91676E8F7349@BL1PR12MB5946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZfUhPBiZ/fyMxKRkv24fhLDHqJnONNDoZQoi8QTErIhSzRz7OQSPx2DmjGenIw2uuvDH8CmG9OLLNo97+tHY9Q/SckqrlFRCJbDYtlLPe8DSfFtq5ZdZ5MhhrB8CdbPpkYi8dk2UFHl9lYhlw7OeYgx3/7cpgebKxydprFlzv1FrlpS1P146DMEPJ72AwhKYfsBVKuGxRrM6ReY/u8TPdbmjkezbVUrqkRzJs5mIfJ30PCHydByUM1IQd8kYNfZVLPPofMDN4MNE0P+bDfzF2N1Vy7ah2DihIOx/5lvXFAComLMGkD1qXe9rl0cvyKCshA0FIKyqsnBsN+R1GOg1+g/wx+z+DwuPPJz7PJYsNdzK6iDNCliYBCNozhbrNVze4LkJ+LKDZbA656iC56TNiSKk/968FHbG3g9DSLJo1udre7Pm7XSKWSq/mK6OMOiC8eskRhATvIOl9evQfJjQFmOiqojMJ3CjmdDBmFNCKeo/srdRQrUDvjWB2q1sMgYppnYwB84IdDICh5QsC903UVk6rCK+VcXP1DPaCmPDaOr9KJL0OIZE7j/2/wZ5O2DkQfqlX6QUEAH2Xq+nBJVITksvPVbAz7F4moEKC0ERiOv2HqMWf37vbtBRWBIEkfs4zuEyLYJ22mFAsdDok6aUU6mfdK7qDxFO9YuyXHKClAEcE9a9ljxfXlDK3SXgrIpmgtaREt3ZkjwMd2t8tXv8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(4326008)(86362001)(8936002)(8676002)(508600001)(7696005)(40460700003)(6666004)(26005)(36756003)(186003)(2616005)(336012)(16526019)(83380400001)(426003)(1076003)(82310400004)(47076005)(2906002)(356005)(5660300002)(316002)(70586007)(6916009)(54906003)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 19:24:28.9633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323d0fb4-04a9-4b88-f45b-08d9f0b8c949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Needed to properly initialize GC 10.3.7.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 53 ++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h                 |  1 +
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d8a5f892fd60..babc0ab3208e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1416,6 +1416,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	default:
@@ -1757,6 +1758,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 		adev->family = AMDGPU_FAMILY_YC;
 		break;
+	case IP_VERSION(10, 3, 7):
+		adev->family = AMDGPU_FAMILY_GC_10_3_7;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dfbe65c1ae0b..95b8f76d0e7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -258,6 +258,13 @@ MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec2.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/gc_10_3_7_ce.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_7_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_7_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
+MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -3408,6 +3415,31 @@ static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000)
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_3_7[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x000000e4),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000041),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffff),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffff),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x00f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG, 0x000001ff, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf000003f, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0xffffff7f, 0x00010020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -3646,6 +3678,11 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_10_0_cyan_skillfish,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));
 		break;
+	case IP_VERSION(10, 3, 7):
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_3_7,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_7));
+		break;
 	default:
 		break;
 	}
@@ -3835,6 +3872,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		adev->gfx.cp_fw_write_wait = true;
 		break;
 	default:
@@ -3962,6 +4000,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		else
 			chip_name = "cyan_skillfish";
 		break;
+	case IP_VERSION(10, 3, 7):
+		chip_name = "gc_10_3_7";
+		break;
 	default:
 		BUG();
 	}
@@ -4558,6 +4599,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -4695,6 +4737,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -6207,6 +6250,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
 				    DOORBELL_RANGE_LOWER_Sienna_Cichlid, ring->doorbell_index);
 		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
@@ -6344,6 +6388,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(10, 3, 4):
 		case IP_VERSION(10, 3, 5):
 		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 3, 7):
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid, 0);
 			break;
 		default:
@@ -6358,6 +6403,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(10, 3, 4):
 		case IP_VERSION(10, 3, 5):
 		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 3, 7):
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid,
 				     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
@@ -7185,6 +7231,7 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		return true;
 	default:
 		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE);
@@ -7220,6 +7267,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
@@ -7672,6 +7720,7 @@ static int gfx_v10_0_early_init(void *handle)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_Sienna_Cichlid;
 		break;
 	default:
@@ -9430,6 +9479,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case IP_VERSION(10, 1, 2):
@@ -9522,7 +9572,8 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			bitmap = i * adev->gfx.config.max_sh_per_se + j;
 			if (((adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0)) ||
-				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3))) &&
+				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3)) ||
+				(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 7))) &&
 			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
 				continue;
 			mask = 1;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 76b580d10a52..55fa660e35f4 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1151,6 +1151,7 @@ struct drm_amdgpu_info_video_caps {
 #define AMDGPU_FAMILY_NV			143 /* Navi10 */
 #define AMDGPU_FAMILY_VGH			144 /* Van Gogh */
 #define AMDGPU_FAMILY_YC			146 /* Yellow Carp */
+#define AMDGPU_FAMILY_GC_10_3_7			151 /* GC 10.3.7 */
 
 #if defined(__cplusplus)
 }
-- 
2.34.1

