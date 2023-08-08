Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F395C04A6A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9904410E3B5;
	Tue,  8 Aug 2023 16:27:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AF710E1F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDhp1Ze9/VxFD2tyvke/sXZyURRprg38H+g3oBHaNlQyHo+zyZA/CARBAWDcs8TasdO5zbMzDqYJRL71T7PzdJlBQdfuD2keHmRCpsNxdG2gOWrurdcSG6uWdEQ5TDjS/whGD4/kgxERhESLmlnCa69+eE0qPgGT/OUQyE6fQT5AkziQnCPIGrKMDMtNP1goqXlHo7TV2DvXJSU5XWQPomQFm4LHIgHRJXZOLRnmXk9SWpid7peUo7pEbooZpUOWc/FSHuUrqWbK+/Yp9A8BhkLsxlWjg48w7vlLYB+EapHgEcZW3XIgjVNFnSD4ihXB4J1mDXD212PSCG2z2rIPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS+/pYYF7qoCWm+Dzp9UDgkBv14SIac3+hFvvA5gIgQ=;
 b=m31h2QB2FvltTaOVphMVPVb8NB1trbescmd7h5jhJaA60yPzMxKDr8VdWWmZYeMKDswO+ZbnWVqBd5+FuSmt1yK3ja3AkCNH/Y0I0kjijQf0FTz50wc/E/IzvzKZLBagPacn4y1FOj6XEVDtEbdt76vdHen6sfHHUmi1ziCqB5IsPYw90EXNEqhnb9o0A91NKbB6+gEfeY593AbFFTfbSOCyuQX3sG13BMrOy9pB1QbsP3v3odidANO8xOtHFu1IRdFR9RGJfLUrQ4GLsqVedvpgxpcgiZtweFJ3LFmA5zGrp/43huqCpNsrJghLIl3tUQYZrcxLsSkGcYU+52omQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS+/pYYF7qoCWm+Dzp9UDgkBv14SIac3+hFvvA5gIgQ=;
 b=Y4CzugvDNDS1wLs6gLv7inAIWchekkO7/P8QlA6It49LfBKMdrtDrGl+1PgL93AAZMOcu+TKFP+S62dG8xQ4LF6wUTmgmouq58V7HjnFWtWbjiG9wQ4eRrK/yTqKq0jicbu33Jt20LgVHNXCr9yW/tcNR03OfVV8K2FC3E8NIqk=
Received: from SA0PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:d3::35)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 16:27:06 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::78) by SA0PR11CA0030.outlook.office365.com
 (2603:10b6:806:d3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Tue, 8 Aug 2023 16:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 16:27:06 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:27:04 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 5/7] drm/amdgpu/jpeg: sriov support for jpeg_v4_0_3
Date: Tue, 8 Aug 2023 12:26:20 -0400
Message-ID: <20230808162622.74937-5-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808162622.74937-1-samir.dhume@amd.com>
References: <20230808162622.74937-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b07665d-529b-4408-09a6-08db982c4e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jxC7iv4i0SbIlgp9G0XO9Y//O2c4eipjySF4qtcC37dYHAT+sx+rlC+lcPCTTG0x/SBi8XTNCXVRntIRKdWndQudLOZNZMiKM92yxcZc6gZvGF3N6uBGepucMF6zm0qzCtt07evP+POly+1jnrqmwUrk/oJycMT3wwhSMXZtZb0LEejyeDn5z4xayZfb+Aj/+/YBaWnREJL56QM6u62/ZYzuH+3k3yw6KO7ky8QED/I8LAFyvDYrm79YC1kr98YPGi687yt62oNfb000qbE4oRXsqLcf2dCQuzdHG9/SnoG7EMm6j0EvBYX8Rdx7436a++rkyJ1/rfmBQesznQKe5/s9/e5k8BUE+Sxvq7V5EpE4n5eLTFu4f7U6zgsUltnFHpgN1WDUMHRq3l/Pzrp4dh5jT3BS4vECTyTOvK9cJP2ZfsJh7wpPvfhHs+KFwRfr80YMV1Nxajm082W8PbKixL6fPBj520CRhjepGJ2n0S5qUe3LI8Ps4F4FsYqYJn1EBWaYWvRav4vPGZgaKWtFIcJt1cNxzaB+8HvbZzCvz3rwodFw8hIMZKEcvIKnztK7IzpDAOC/1kkgUPhGqu8HLALUA9kA5FIjfNZZ+/r/4p1Ofnf73yjkg5WmDUrjRhhv3pJmjk5Atr7cx2QFt59q8pyECKPhbUFZ/RqW3jIVSwXjVEW6cuCPNySD+UidVEii7UsUCMKN6Duo4krBKh2nDoA52l+yYNSTVu2ghQOo7/Q7f3ZAlG6AoiQoE6+pQ5r9qjHbJwLhWUFa8f2iNJAGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(82310400008)(1800799003)(186006)(451199021)(46966006)(36840700001)(40470700004)(426003)(41300700001)(26005)(1076003)(2906002)(5660300002)(44832011)(83380400001)(8676002)(8936002)(36860700001)(47076005)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(6916009)(316002)(356005)(82740400003)(7696005)(70206006)(70586007)(54906003)(478600001)(6666004)(86362001)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:27:06.2822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b07665d-529b-4408-09a6-08db982c4e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
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
 lijo.lazar@amd.com, emily.deng@amd.com, frank.min@amd.com,
 alexander.deucher@amd.com, Samir
 Dhume <samir.dhume@amd.com>, leo.liu@amd.com, monk.liu@amd.com
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

