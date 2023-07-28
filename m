Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29614C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 19:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA2710E77F;
	Fri, 28 Jul 2023 19:16:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E6110E77F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 19:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKi+QH7fohzOvLQ7Nh2XP00MJluKBiJaNjRBjCMP8TWuJjON2VMki5SwOAG8Js/pP3PndxzpCmgI55ZPpXigN+kISf4xUtcM9dusnR00ZD2x7lCPsNRtWF+cD+bt9ynihUsbFzdqsb3lD+HB0NkVLOq5TNzKZEKJM1g/NLFSKaFLQNkyX1O83LdEyRvnv9pIWmnXs7olkG9MvgaKmAEGal+yvzQbhFOXp/f1M0NGCxYt9UBUQWnk3HD40gEFOm63Ti7/mHUtKt0spsXU4D/TjVjMmfSI2HYqwUxHg6KJ8nnH45HIwuw60dSOfPovqeRV/1RoznIr/LyDptTMFsyxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS+/pYYF7qoCWm+Dzp9UDgkBv14SIac3+hFvvA5gIgQ=;
 b=V0BF8p4gAUb9Zri0Bhq5vl4XfgQ+QWAdTZ/8TKkeqQ1386+LhYAA3CcWNNte8NUqTawkiWeHk5TlLWXfPw16vKDuSKMPGaCd03iB/aP23FhPUO71RyfSk3b4NPf+BCwGY5F6eDfsa8gQq06bkjlVs3P8n/XH7HT/Izc6v7M1BrSzgcKnYRfk0CrIb6qjXDmzFmoXJCzH+GOe0eQAISeXBgyoLnsYaefU58WtD0JDRy9osNRgrD5NSGCoHCZgi0L57g3mUp+aZFw+RO1M8XNnosNPUmF/+60TQzvamOuUphaFunZ+k5BMdcI/hi9NZdlJCat6rTIQZJRQY5hS9idrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS+/pYYF7qoCWm+Dzp9UDgkBv14SIac3+hFvvA5gIgQ=;
 b=1JJaP78Svq+hYgq6O44twicLV504i117sw/ZEKeXyJgvFwRRiesUNtokHwkFu4VYgX6FY49ZOGdOxwJnAJtEizsxnEL19YfSWL/3NQ3tx/ITqViPh3+g4x2r94u9MWDdAoE/E6/7tQvpp8HTL+pjVzeaGt17cftXfcMeLbQsBE8=
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 19:16:14 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::cd) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 19:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 19:16:14 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 14:16:12 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/7] drm/amdgpu/jpeg: sriov support for jpeg_v4_0_3
Date: Fri, 28 Jul 2023 15:15:39 -0400
Message-ID: <20230728191541.1778424-5-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728191541.1778424-1-samir.dhume@amd.com>
References: <20230728191541.1778424-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f28fae-a521-40c1-b676-08db8f9f1c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqLYl3VbNe6vnL4mBbsnAM0H3HlpfhaREgxB1P17OuLA3f6tSBUb94IekFQZJqlmiIsozZEHu3oUztrBIA11Vf6HeNKychch2j1CWwlBZO9IgIDZT3H4vJSNy8qiQEJsZlr3X0YaSWwtpOaL4acj133lB0ihfM2fxrnwGAZAT1w1P5HvyEJ1lILZZbmPAPIuhta4yn+MCayi6QvdiUJPj3KY27D/I65+tKSRcu4Aue9FkFMAuGtERLWubosh02DZPPdX5tb+QU7V9Nw6A4w470pfB4TtQt7ojAoCj+c5H+IZi/tsrIZ+ZFxFmgfnbtBN7jKW8MAsqq/NDcnIX0YZO2VgefK8dmZnsjCRaV1OCRnFGowCCQ55ibiO9XrMR7BuCsDJ1TTjT/jD5fE59jAk9FjcwNtlkMS2kKtlsKspDMzQnzfV8XAPSjV1e8qMhCW3uehcHqyhj4Lv4Yue2v5fa5N6q/1/nK6LiOHWi1eZb9y13q53nGVJCEC1gMHQtG0yKN+CrdMrZJOh0/ybuP5m4PbXGtst0fKVO/FH2B0dUrEw+8/qwX+fj+jOD5XoXrRbzVPecsbEg83PMV9rfmAobZLmnYJmc1S74dEsLPViPh+iAqtJ18qFXE9UIDwe4wI5gVEFvy1u9V1eqrnBnvOgqAtKl5W6ECp9u7DnZnw/SdYXxOOqxEKPCyoDItoYjODoShEbV2IjnD5xzeAzQ86+OdUiPgC3v4HTj9OE5/tFOSkYUMkf4vEcqCDrPEQ/SbVVYopDJhwCnQ3y0S32kkyH7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(82740400003)(356005)(54906003)(186003)(16526019)(336012)(478600001)(81166007)(7696005)(426003)(6666004)(47076005)(4326008)(6916009)(2616005)(36860700001)(70586007)(83380400001)(70206006)(5660300002)(44832011)(41300700001)(40460700003)(316002)(2906002)(8936002)(8676002)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:16:14.0620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f28fae-a521-40c1-b676-08db8f9f1c5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, frank.min@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

initialization table handshake with mmsch

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 174 ++++++++++++++++++++---
 1 file changed, 153 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ce2b22f7e4e4..33f04ea8549f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -26,6 +26,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "jpeg_v4_0_3.h"
+#include "mmsch_v4_0_3.h"
 
 #include "vcn/vcn_4_0_3_offset.h"
 #include "vcn/vcn_4_0_3_sh_mask.h"
@@ -41,6 +42,7 @@ static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_3_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
+static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
 static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_4_0__SRCID__JPEG_DECODE,
@@ -160,6 +162,120 @@ static int jpeg_v4_0_3_sw_fini(void *handle)
 	return r;
 }
 
+static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t tmp, timeout;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw, item_offset;
+	uint32_t init_status;
+	int i, j, jpeg_inst;
+
+	struct mmsch_v4_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v4_0_cmd_end end = { {0} };
+	struct mmsch_v4_0_3_init_header header;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	end.cmd_header.command_type =
+		MMSCH_COMMAND__END;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		jpeg_inst = GET_INST(JPEG, i);
+
+		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
+		header.version = MMSCH_VERSION;
+		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
+
+		table_loc = (uint32_t *)table->cpu_addr;
+		table_loc += header.total_size;
+
+		item_offset = header.total_size;
+
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; j++) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			table_size = 0;
+
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW);
+			MMSCH_V4_0_INSERT_DIRECT_WT(tmp, lower_32_bits(ring->gpu_addr));
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH);
+			MMSCH_V4_0_INSERT_DIRECT_WT(tmp, upper_32_bits(ring->gpu_addr));
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE);
+			MMSCH_V4_0_INSERT_DIRECT_WT(tmp, ring->ring_size / 4);
+
+			if (j <= 3) {
+				header.mjpegdec0[j].table_offset = item_offset;
+				header.mjpegdec0[j].init_status = 0;
+				header.mjpegdec0[j].table_size = table_size;
+			} else {
+				header.mjpegdec1[j-4].table_offset = item_offset;
+				header.mjpegdec1[j-4].init_status = 0;
+				header.mjpegdec1[j-4].table_size = table_size;
+			}
+			header.total_size += table_size;
+			item_offset+= table_size;
+		}
+
+		MMSCH_V4_0_INSERT_END();
+
+		/* send init table to MMSCH */
+		size = sizeof(struct mmsch_v4_0_3_init_header);
+		table_loc = (uint32_t *)table->cpu_addr;
+		memcpy((void *)table_loc, &header, size);
+
+		ctx_addr = table->gpu_addr;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		init_status = ((struct mmsch_v4_0_3_init_header *)(table_loc))->mjpegdec0[i].init_status;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_RESP);
+
+			if (resp != 0)
+				break;
+			udelay(10);
+			tmp = tmp + 10;
+			if (tmp >= timeout) {
+				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+					" waiting for regMMSCH_VF_MAILBOX_RESP "\
+					"(expected=0x%08x, readback=0x%08x)\n",
+					tmp, expected, resp);
+				return -EBUSY;
+			}
+		}
+		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE && init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
+			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n", resp, init_status);
+		}
+
+
+	}
+	return 0;
+}
+
+
 /**
  * jpeg_v4_0_3_hw_init - start and test JPEG block
  *
@@ -172,31 +288,47 @@ static int jpeg_v4_0_3_hw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int i, j, r, jpeg_inst;
 
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		jpeg_inst = GET_INST(JPEG, i);
+	if (amdgpu_sriov_vf(adev)) {
+		r = jpeg_v4_0_3_start_sriov(adev);
+		if (r)
+			return r;
 
-		ring = adev->jpeg.inst[i].ring_dec;
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+				ring = &adev->jpeg.inst[i].ring_dec[j];
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				jpeg_v4_0_3_dec_ring_set_wptr(ring);
+				ring->sched.ready = true;
+			}
+		}
+	} else {
+		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+			jpeg_inst = GET_INST(JPEG, i);
 
-		if (ring->use_doorbell)
-			adev->nbio.funcs->vcn_doorbell_range(
-				adev, ring->use_doorbell,
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-					9 * jpeg_inst,
-				adev->jpeg.inst[i].aid_id);
+			ring = adev->jpeg.inst[i].ring_dec;
 
-		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			ring = &adev->jpeg.inst[i].ring_dec[j];
 			if (ring->use_doorbell)
-				WREG32_SOC15_OFFSET(
-					VCN, GET_INST(VCN, i),
-					regVCN_JPEG_DB_CTRL,
-					(ring->pipe ? (ring->pipe - 0x15) : 0),
-					ring->doorbell_index
-							<< VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
-						VCN_JPEG_DB_CTRL__EN_MASK);
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				return r;
+				adev->nbio.funcs->vcn_doorbell_range(
+					adev, ring->use_doorbell,
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						9 * jpeg_inst,
+					adev->jpeg.inst[i].aid_id);
+
+			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+				ring = &adev->jpeg.inst[i].ring_dec[j];
+				if (ring->use_doorbell)
+					WREG32_SOC15_OFFSET(
+						VCN, GET_INST(VCN, i),
+						regVCN_JPEG_DB_CTRL,
+						(ring->pipe ? (ring->pipe - 0x15) : 0),
+						ring->doorbell_index
+								<< VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+							VCN_JPEG_DB_CTRL__EN_MASK);
+				r = amdgpu_ring_test_helper(ring);
+				if (r)
+					return r;
+			}
 		}
 	}
 	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
-- 
2.34.1

