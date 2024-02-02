Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FF5C48291
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 10:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01AD10ED4D;
	Fri,  2 Feb 2024 10:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vwMeHKW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A4010ED4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 10:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODpDtMIu9LdYHQ4Rg/7c0iOtCP7Ro486+++btYyIvE4G+Y7dzSGvqFZWvpDVF/cxXiLVQ+oqvzD8iT8CAA3rDpbPWowMvPIG4tZPmgDFCtKtc2bjKCMWQ8gFmjjGyrwT3tTbvVpLjtbolr/aB02z0m/aCIV+XmbRmry3oCpV6i5aOQSQvkDl3H73RTPdi7XhNzeTE/3IUfGlkzBWvDhpYYwbO2pFkZu1CjezDAci4pSGroJT2AFwip7uoSU2wboRQqJkzPURGEAK8h6sbtUgzdU3Fb1/gmrn0OX11DwpyER1JZMOWr/sYF0ioiSwCaCkIiLOxEmWKf0WHUgC8+ezmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7+nymM8i+bHoT4CMzmYnUaIabt4GObfXQ6AQe8PWcc=;
 b=ZIFMNsNftIjiHYp6tckbBqKCegztz6jAlWJ6YfYYqmr+ecHqsK2e1DimZyJ4q/BQ/64nOlpfM+xzuhFQpEDJjdLbfk5QMU5rCsfCWZEiW/al6lWwCVMyEPvEzKSxo2KtuDgVsQi0lG7IUBWnyRD1bOPSL7NodB2aRtkjVqltTK+l7Ep1tCEbowtfMD1RBkqeTqjRQO5OJ+XWSYA1+jsIz/kC6fHnys9uB8T+oD/L3/DuQSseUaCAG5ymkD8F3Mt076YSeG6YbxxL/TJ4Vmhq+jClYUI8BAg/vdjLHT4WS2So3etWewpTWcaFU2nm4DcdVk4RP6HrXSJWc00ljwBCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7+nymM8i+bHoT4CMzmYnUaIabt4GObfXQ6AQe8PWcc=;
 b=1vwMeHKW62TU89QqElQuARw4wDLOhozwHRby5UUqzgqRUJb4WTCrdbY0Qhycc4zfv2ZYumSL5oQkemh9Nv5KYa74NCyEqX1NDK/m2gQc2u2o5DfAGsc5G2xDTZC6Iwv3FSsM2FLeNV0lLYk6n8WefqYCPifDmP0kXqh1IcBW9Bs=
Received: from CH2PR19CA0024.namprd19.prod.outlook.com (2603:10b6:610:4d::34)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.11; Fri, 2 Feb 2024 10:01:53 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::e4) by CH2PR19CA0024.outlook.office365.com
 (2603:10b6:610:4d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Fri, 2 Feb 2024 10:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 10:01:53 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 04:01:50 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <leo.liu@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <veerabadhran.gopalakrishnan@amd.com>
CC: <srinath.rao@amd.com>, <himanshu.nayak@amd.com>,
 <sathishkumar.sundararaju@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/jpeg: add support for jpeg DPG mode
Date: Fri, 2 Feb 2024 15:31:26 +0530
Message-ID: <20240202100126.3208200-2-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202100126.3208200-1-saleemkhan.jamadar@amd.com>
References: <20240202100126.3208200-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c85462-10fd-4015-612c-08dc23d5fb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6gEas3So9nVp7dP2Ep+vojADGlDC6+KJ9HYo6M3N9PMQ2tjD/kySTRbwNvlLZKn7TyIoJZCTzafaXwDKdLIhWYzCJmDnq35+ARr5fFQgpSF3xOqXpbX/FDWV9zVRcRSjuVmzAFqB2YuAHb/CQwswKt8/gigSTh2oI//LqOlZWd0lsXNkCHr/aLkPNsccoa8tzw/zePNN6G45z36MXgKaTwSs8wT6fhAKMelLQpG0zef89NY/sCB4WA2mdbaFPEWpsPznzMJQj5XdVEAPRVx3n5j7Om5d56FvCCgNwyrpYbOizHpmjXNrotMYVOX1B1lMHmxPnDtmh8ITseJpEOKdk0rc5BOeqpQIp7PIK/qS9tA8nFGj3bED6n4PGsYlWynZQYqeGw7eRxnvIflSEtsZ7pnyx9dAxbqBN0ySx5Mk5b1yKWE+qRfK+Ng3WVhPrLzcFBju9dELYXPvrvc2qoaaPImqj4QVhWJraAy8mNeHYyCmAMm6iH/NPmT0vGdyhDswniIXtwlhRyrJv4y2/2VVVb2hRsCNUsTZLs/EA4+WrWc2B2SbTFuiya1CoKTFmt8K6zDc4BQ1XxqbLmrojAbcJZGXqAS1WE4AiPkG+60RZoDIfreJSSBZY+kaI1mT8Lr7iPIIt7r4rocoQDgJ//1Wi2+EQqvC+Y8A/OGWR0XPnz8OkbKHsVd+0fA4lrqBc/EJ1Lgv2REflmx7umfxJaSPnB6Xcrifo53si5pV4zb3oWBhPs2PXzDn7AGLTbo3m5LwVOUBdNgalEcWLFgWtfvJVI3gtzJrk/ERE/Um02wdpVaPQxQR73bNJyFu3EKF5BN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(83380400001)(82740400003)(426003)(16526019)(1076003)(336012)(2616005)(26005)(110136005)(36860700001)(8676002)(44832011)(8936002)(4326008)(6666004)(478600001)(70586007)(2906002)(30864003)(7696005)(54906003)(5660300002)(356005)(6636002)(316002)(70206006)(81166007)(47076005)(36756003)(86362001)(41300700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 10:01:53.0760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c85462-10fd-4015-612c-08dc23d5fb54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
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

Jpeg DPG support for GC IP v11_5_0

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c |  44 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  36 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 312 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/soc21.c       |   1 +
 drivers/gpu/drm/amd/include/amd_shared.h |   1 +
 5 files changed, 315 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 2ff2897fd1db..ab70395a0022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -36,10 +36,35 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work);
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
 {
+	int i, r;
+
 	INIT_DELAYED_WORK(&adev->jpeg.idle_work, amdgpu_jpeg_idle_work_handler);
 	mutex_init(&adev->jpeg.jpeg_pg_lock);
 	atomic_set(&adev->jpeg.total_submission_cnt, 0);
 
+	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+	    (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG))
+		adev->jpeg.indirect_sram = true;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		if (adev->jpeg.indirect_sram) {
+			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM |
+					AMDGPU_GEM_DOMAIN_GTT,
+					&adev->jpeg.inst[i].dpg_sram_bo,
+					&adev->jpeg.inst[i].dpg_sram_gpu_addr,
+					&adev->jpeg.inst[i].dpg_sram_cpu_addr);
+			if (r) {
+				dev_err(adev->dev,
+				"JPEG %d (%d) failed to allocate DPG bo\n", i, r);
+				return r;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -51,6 +76,11 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
+		amdgpu_bo_free_kernel(
+			&adev->jpeg.inst[i].dpg_sram_bo,
+			&adev->jpeg.inst[i].dpg_sram_gpu_addr,
+			(void **)&adev->jpeg.inst[i].dpg_sram_cpu_addr);
+
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j)
 			amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec[j]);
 	}
@@ -210,6 +240,7 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	} else {
 		r = 0;
 	}
+
 	if (!amdgpu_sriov_vf(adev)) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			tmp = RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
@@ -296,3 +327,16 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
+			       enum AMDGPU_UCODE_ID ucode_id)
+{
+	struct amdgpu_firmware_info ucode = {
+		.ucode_id = AMDGPU_UCODE_ID_JPEG_RAM,
+		.mc_addr = adev->jpeg.inst[inst_idx].dpg_sram_gpu_addr,
+		.ucode_size = ((uintptr_t)adev->jpeg.inst[inst_idx].dpg_sram_curr_addr -
+			      (uintptr_t)adev->jpeg.inst[inst_idx].dpg_sram_cpu_addr),
+	};
+
+	return psp_execute_ip_fw_load(&adev->psp, &ucode);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index ffe47e9f5bf2..aea31d61d991 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -32,6 +32,34 @@
 #define AMDGPU_JPEG_HARVEST_JPEG0 (1 << 0)
 #define AMDGPU_JPEG_HARVEST_JPEG1 (1 << 1)
 
+#define WREG32_SOC15_JPEG_DPG_MODE(inst_idx, offset, value, indirect)			\
+	do {										\
+		if (!indirect) {							\
+			WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
+				     mmUVD_DPG_LMA_DATA, value);			\
+			WREG32_SOC15(							\
+				JPEG, GET_INST(JPEG, inst_idx),				\
+				mmUVD_DPG_LMA_CTL,					\
+				(UVD_DPG_LMA_CTL__READ_WRITE_MASK |			\
+				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT |	\
+				 indirect << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT));	\
+		} else {								\
+			*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ =		\
+				offset;							\
+			*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ =		\
+				value;							\
+		}									\
+	} while (0)
+
+#define RREG32_SOC15_JPEG_DPG_MODE(inst_idx, offset, mask_en)					\
+	({											\
+		WREG32_SOC15(JPEG, inst_idx, mmUVD_DPG_LMA_CTL,					\
+			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
+			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
+			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
+		RREG32_SOC15(JPEG, inst_idx, mmUVD_DPG_LMA_DATA);				\
+	})
+
 struct amdgpu_jpeg_reg{
 	unsigned jpeg_pitch[AMDGPU_MAX_JPEG_RINGS];
 };
@@ -41,6 +69,11 @@ struct amdgpu_jpeg_inst {
 	struct amdgpu_irq_src irq;
 	struct amdgpu_irq_src ras_poison_irq;
 	struct amdgpu_jpeg_reg external;
+	struct amdgpu_bo	*dpg_sram_bo;
+	struct dpg_pause_state	pause_state;
+	void			*dpg_sram_cpu_addr;
+	uint64_t		dpg_sram_gpu_addr;
+	uint32_t		*dpg_sram_curr_addr;
 	uint8_t aid_id;
 };
 
@@ -63,6 +96,7 @@ struct amdgpu_jpeg {
 
 	uint16_t inst_mask;
 	uint8_t num_inst_per_aid;
+	bool	indirect_sram;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
@@ -82,5 +116,7 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev,
 				struct ras_common_if *ras_block);
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
+			       enum AMDGPU_UCODE_ID ucode_id);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 6ede85b28cc8..9797bb313518 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -34,7 +34,17 @@
 #include "vcn/vcn_4_0_5_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
 
-#define regUVD_JPEG_PITCH_INTERNAL_OFFSET                  0x401f
+#define mmUVD_DPG_LMA_CTL						regUVD_DPG_LMA_CTL
+#define mmUVD_DPG_LMA_CTL_BASE_IDX					regUVD_DPG_LMA_CTL_BASE_IDX
+#define mmUVD_DPG_LMA_DATA						regUVD_DPG_LMA_DATA
+#define mmUVD_DPG_LMA_DATA_BASE_IDX					regUVD_DPG_LMA_DATA_BASE_IDX
+
+#define regUVD_JPEG_PITCH_INTERNAL_OFFSET		0x401f
+#define regJPEG_DEC_GFX10_ADDR_CONFIG_INTERNAL_OFFSET	0x4026
+#define regJPEG_SYS_INT_EN_INTERNAL_OFFSET		0x4141
+#define regJPEG_CGC_CTRL_INTERNAL_OFFSET		0x4161
+#define regJPEG_CGC_GATE_INTERNAL_OFFSET		0x4160
+#define regUVD_NO_OP_INTERNAL_OFFSET			0x0029
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
@@ -155,11 +165,18 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
+	// TODO: Enable ring test with DPG support
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
+		DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully under DPG Mode");
+		return 0;
+	}
+
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
 
-	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
+	if (!r)
+		DRM_INFO("JPEG decode initialized successfully under SPG Mode\n");
 
 	return 0;
 }
@@ -228,11 +245,11 @@ static int jpeg_v4_0_5_resume(void *handle)
 	return r;
 }
 
-static void jpeg_v4_0_5_disable_clock_gating(struct amdgpu_device *adev)
+static void jpeg_v4_0_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data = 0;
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+	data = RREG32_SOC15(JPEG, inst, regJPEG_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG) {
 		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
 		data &= (~JPEG_CGC_CTRL__JPEG_DEC_MODE_MASK);
@@ -242,21 +259,21 @@ static void jpeg_v4_0_5_disable_clock_gating(struct amdgpu_device *adev)
 
 	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+	WREG32_SOC15(JPEG, inst, regJPEG_CGC_CTRL, data);
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data = RREG32_SOC15(JPEG, inst, regJPEG_CGC_GATE);
 	data &= ~(JPEG_CGC_GATE__JPEG_DEC_MASK
 		| JPEG_CGC_GATE__JPEG2_DEC_MASK
 		| JPEG_CGC_GATE__JMCIF_MASK
 		| JPEG_CGC_GATE__JRBBM_MASK);
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+	WREG32_SOC15(JPEG, inst, regJPEG_CGC_GATE, data);
 }
 
-static void jpeg_v4_0_5_enable_clock_gating(struct amdgpu_device *adev)
+static void jpeg_v4_0_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data = 0;
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+	data = RREG32_SOC15(JPEG, inst, regJPEG_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG) {
 		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
 		data |= JPEG_CGC_CTRL__JPEG_DEC_MODE_MASK;
@@ -266,47 +283,66 @@ static void jpeg_v4_0_5_enable_clock_gating(struct amdgpu_device *adev)
 
 	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+	WREG32_SOC15(JPEG, inst, regJPEG_CGC_CTRL, data);
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data = RREG32_SOC15(JPEG, inst, regJPEG_CGC_GATE);
 	data |= (JPEG_CGC_GATE__JPEG_DEC_MASK
 		|JPEG_CGC_GATE__JPEG2_DEC_MASK
 		|JPEG_CGC_GATE__JMCIF_MASK
 		|JPEG_CGC_GATE__JRBBM_MASK);
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+	WREG32_SOC15(JPEG, inst, regJPEG_CGC_GATE, data);
 }
 
-static int jpeg_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev)
+static void jpeg_engine_4_0_5_dpg_clock_gating_mode(struct amdgpu_device *adev,
+			int inst_idx, uint8_t indirect)
+{
+	uint32_t data = 0;
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data |= 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15_JPEG_DPG_MODE(inst_idx, regJPEG_CGC_CTRL_INTERNAL_OFFSET, data, indirect);
+
+	data = 0;
+	WREG32_SOC15_JPEG_DPG_MODE(inst_idx, regJPEG_CGC_GATE_INTERNAL_OFFSET,
+				data, indirect);
+}
+
+static int jpeg_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev, int inst)
 {
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
-		WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG),
+		WREG32(SOC15_REG_OFFSET(JPEG, inst, regUVD_IPX_DLDO_CONFIG),
 			1 << UVD_IPX_DLDO_CONFIG__ONO1_PWR_CONFIG__SHIFT);
-		SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
+		SOC15_WAIT_ON_RREG(JPEG, inst, regUVD_IPX_DLDO_STATUS,
 			0, UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
 	}
 
 	/* disable anti hang mechanism */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+	WREG32_P(SOC15_REG_OFFSET(JPEG, inst, regUVD_JPEG_POWER_STATUS), 0,
 		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
 
 	/* keep the JPEG in static PG mode */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+	WREG32_P(SOC15_REG_OFFSET(JPEG, inst, regUVD_JPEG_POWER_STATUS), 0,
 		~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
 
 	return 0;
 }
 
-static int jpeg_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev)
+static int jpeg_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, int inst)
 {
 	/* enable anti hang mechanism */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	WREG32_P(SOC15_REG_OFFSET(JPEG, inst, regUVD_JPEG_POWER_STATUS),
 		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
 		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
-		WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG),
+		WREG32(SOC15_REG_OFFSET(JPEG, inst, regUVD_IPX_DLDO_CONFIG),
 			2 << UVD_IPX_DLDO_CONFIG__ONO1_PWR_CONFIG__SHIFT);
-		SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
+		SOC15_WAIT_ON_RREG(JPEG, inst, regUVD_IPX_DLDO_STATUS,
 			1 << UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS__SHIFT,
 			UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
 	}
@@ -315,61 +351,151 @@ static int jpeg_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev)
 }
 
 /**
- * jpeg_v4_0_5_start - start JPEG block
+ * jpeg_v4_0_5_start_dpg_mode - Jpeg start with dpg mode
  *
  * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ * @indirect: indirectly write sram
  *
- * Setup and start the JPEG block
+ * Start JPEG block with dpg mode
  */
-static int jpeg_v4_0_5_start(struct amdgpu_device *adev)
+static int jpeg_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
-	int r;
+	struct amdgpu_ring *ring = adev->jpeg.inst[inst_idx].ring_dec;
+	uint32_t reg_data = 0;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_jpeg(adev, true);
+	/* enable anti hang mechanism */
+	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+	reg_data &= ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK;
+	reg_data |=  0x1;
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
 
-	/* doorbell programming is done for every playback */
-	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		WREG32(SOC15_REG_OFFSET(JPEG, inst_idx, regUVD_IPX_DLDO_CONFIG),
+			2 << UVD_IPX_DLDO_CONFIG__ONO1_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(JPEG, inst_idx, regUVD_IPX_DLDO_STATUS,
+			1 << UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS__SHIFT,
+			UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
+	}
 
-	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
-		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
-		VCN_JPEG_DB_CTRL__EN_MASK);
+	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+	reg_data |= UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
 
-	/* disable power gating */
-	r = jpeg_v4_0_5_disable_static_power_gating(adev);
-	if (r)
-		return r;
+	if (indirect)
+		adev->jpeg.inst[inst_idx].dpg_sram_curr_addr =
+					(uint32_t *)adev->jpeg.inst[inst_idx].dpg_sram_cpu_addr;
 
-	/* JPEG disable CGC */
-	jpeg_v4_0_5_disable_clock_gating(adev);
+	jpeg_engine_4_0_5_dpg_clock_gating_mode(adev, inst_idx, indirect);
 
 	/* MJPEG global tiling registers */
-	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
-		adev->gfx.config.gb_addr_config);
-
+	WREG32_SOC15_JPEG_DPG_MODE(inst_idx, regJPEG_DEC_GFX10_ADDR_CONFIG_INTERNAL_OFFSET,
+	adev->gfx.config.gb_addr_config, indirect);
+	/* enable System Interrupt for JRBC */
+	WREG32_SOC15_JPEG_DPG_MODE(inst_idx, regJPEG_SYS_INT_EN_INTERNAL_OFFSET,
+	JPEG_SYS_INT_EN__DJRBC_MASK, indirect);
 
-	/* enable JMI channel */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
-		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+	/* add nop to workaround PSP size check */
+	WREG32_SOC15_JPEG_DPG_MODE(inst_idx, regUVD_NO_OP_INTERNAL_OFFSET, 0, indirect);
 
-	/* enable System Interrupt for JRBC */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
-		JPEG_SYS_INT_EN__DJRBC_MASK,
-		~JPEG_SYS_INT_EN__DJRBC_MASK);
+	if (indirect)
+		amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
 
-	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
-	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
 		lower_32_bits(ring->gpu_addr));
-	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
 		upper_32_bits(ring->gpu_addr));
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_RPTR, 0);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, 0);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, 0x00000002L);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
-	ring->wptr = RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_stop_dpg_mode - Jpeg stop with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ *
+ * Stop JPEG block with dpg mode
+ */
+static void jpeg_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+{
+	uint32_t reg_data = 0;
+
+	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+	reg_data &= ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
+
+}
+
+/**
+ * jpeg_v4_0_5_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v4_0_5_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r, i;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, true);
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		/* doorbell programming is done for every playback */
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i, i);
+
+		WREG32_SOC15(VCN, i, regVCN_JPEG_DB_CTRL,
+			ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+			VCN_JPEG_DB_CTRL__EN_MASK);
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
+			r = jpeg_v4_0_5_start_dpg_mode(adev, i, adev->jpeg.indirect_sram);
+			continue;
+		}
+
+		/* disable power gating */
+		r = jpeg_v4_0_5_disable_static_power_gating(adev, i);
+		if (r)
+			return r;
+
+		/* JPEG disable CGC */
+		jpeg_v4_0_5_disable_clock_gating(adev, i);
+
+		/* MJPEG global tiling registers */
+		WREG32_SOC15(JPEG, i, regJPEG_DEC_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config);
+
+		/* enable JMI channel */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regUVD_JMI_CNTL), 0,
+			~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+		/* enable System Interrupt for JRBC */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regJPEG_SYS_INT_EN),
+			JPEG_SYS_INT_EN__DJRBC_MASK,
+			~JPEG_SYS_INT_EN__DJRBC_MASK);
+
+		WREG32_SOC15(JPEG, i, regUVD_LMI_JRBC_RB_VMID, 0);
+		WREG32_SOC15(JPEG, i, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+		WREG32_SOC15(JPEG, i, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+			lower_32_bits(ring->gpu_addr));
+		WREG32_SOC15(JPEG, i, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+			upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(JPEG, i, regUVD_JRBC_RB_RPTR, 0);
+		WREG32_SOC15(JPEG, i, regUVD_JRBC_RB_WPTR, 0);
+		WREG32_SOC15(JPEG, i, regUVD_JRBC_RB_CNTL, 0x00000002L);
+		WREG32_SOC15(JPEG, i, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+		ring->wptr = RREG32_SOC15(JPEG, i, regUVD_JRBC_RB_WPTR);
+	}
 
 	return 0;
 }
@@ -383,19 +509,26 @@ static int jpeg_v4_0_5_start(struct amdgpu_device *adev)
  */
 static int jpeg_v4_0_5_stop(struct amdgpu_device *adev)
 {
-	int r;
+	int r, i;
 
-	/* reset JMI */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
-		UVD_JMI_CNTL__SOFT_RESET_MASK,
-		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
 
-	jpeg_v4_0_5_enable_clock_gating(adev);
+			jpeg_v4_0_5_stop_dpg_mode(adev, i);
+			continue;
+		}
+		/* reset JMI */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regUVD_JMI_CNTL),
+			UVD_JMI_CNTL__SOFT_RESET_MASK,
+			~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
-	/* enable power gating */
-	r = jpeg_v4_0_5_enable_static_power_gating(adev);
-	if (r)
-		return r;
+		jpeg_v4_0_5_enable_clock_gating(adev, i);
+
+		/* enable power gating */
+		r = jpeg_v4_0_5_enable_static_power_gating(adev, i);
+		if (r)
+			return r;
+	}
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, false);
@@ -479,13 +612,20 @@ static int jpeg_v4_0_5_set_clockgating_state(void *handle,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	int i;
 
-	if (enable) {
-		if (!jpeg_v4_0_5_is_idle(handle))
-			return -EBUSY;
-		jpeg_v4_0_5_enable_clock_gating(adev);
-	} else {
-		jpeg_v4_0_5_disable_clock_gating(adev);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		if (enable) {
+			if (!jpeg_v4_0_5_is_idle(handle))
+				return -EBUSY;
+
+			jpeg_v4_0_5_enable_clock_gating(adev, i);
+		} else {
+			jpeg_v4_0_5_disable_clock_gating(adev, i);
+		}
 	}
 
 	return 0;
@@ -598,8 +738,15 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->ring_dec->funcs = &jpeg_v4_0_5_dec_ring_vm_funcs;
-	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		adev->jpeg.inst[i].ring_dec->funcs = &jpeg_v4_0_5_dec_ring_vm_funcs;
+		DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled in VM mode\n", i);
+	}
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v4_0_5_irq_funcs = {
@@ -609,8 +756,15 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_5_irq_funcs = {
 
 static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->irq.num_types = 1;
-	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_5_irq_funcs;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		adev->jpeg.inst[i].irq.num_types = 1;
+		adev->jpeg.inst[i].irq.funcs = &jpeg_v4_0_5_irq_funcs;
+	}
 }
 
 const struct amdgpu_ip_block_version jpeg_v4_0_5_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 48c6efcdeac9..990f4669723d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -711,6 +711,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_BIF_MGCG |
 			AMD_CG_SUPPORT_BIF_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG_DPG |
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_GFX_PG;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index da9b670fec86..42ed7f1b6b72 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -174,6 +174,7 @@ enum amd_powergating_state {
 #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
 #define AMD_PG_SUPPORT_JPEG			(1 << 17)
 #define AMD_PG_SUPPORT_IH_SRAM_PG		(1 << 18)
+#define AMD_PG_SUPPORT_JPEG_DPG		(1 << 19)
 
 /**
  * enum PP_FEATURE_MASK - Used to mask power play features.
-- 
2.25.1

