Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D073AEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9AE10E5FF;
	Thu, 20 Jul 2023 19:20:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5418110E17A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR4HbIOz16mc+gdMxB65Yc7I+HxE2kYJEEcf0l+Nbj7RPHex8ttOe8hssKBPbxenbA+TLYFC3qwHdYixSCiR8OcF7Ma2l+IrD8FYsWzCjwPU2/24DQlsH8omqZ/YPzvd6tmHPeMJYjmyNjnMqEgiLfR1Omrgq7vZTWBqOCjNcYKdh+AIloHATjgKrE1/HxUoJkFvqJUoojrLX6rPemySlB/5Woy/op54wZsdV1mMr9K6oRweEgnd9EU/qDrofFD+aF0meB4Lo+TK98X8j1cyvM12w5AjsZz9vq0idZFPCwbBfdr3FJLuHx+OQIvCIiKmKMnILzRsfi6e9pzTc9IbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUh0u3dWy7QwNtTj9/FnUX1aJGtfnyBXQqO8wQ4Z7hQ=;
 b=HneXggoRY3/UhHj/xLXlxxBUmOYBIy58e8+jcgi/vNiYaU5Y1jb3gnl4kdSaDNSXc97Jet3QEDEGdUU4IVMMqsA0qgDkAfErHovRNwOOJ7Q0TSGjGLI4rl0rPc0vIgJTcYrttCTQnHCDkhIKbS8gJqrdua/Bh4Oza1CpGOH91gCWUrnh7s1loTF3STZ6TAJ41m78I+sOm6j1l8rQzkx/MaRoOh4YYSbrYgXX9IrxaVCOvJT0+q/phpeLSXTKgZfWC3yWAGWXSKdS09QVZSIOgKIGjCRJMKZlQsUeojwuJ/tG76ydWdm0TlpHWZ7EuQNJNdLwzq54Jt5kmK7TvIZiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUh0u3dWy7QwNtTj9/FnUX1aJGtfnyBXQqO8wQ4Z7hQ=;
 b=qviLWZFPQs/BUfSEcNTOSt02nRMhvsAPhj7Ke/0LYIII1iLOd+iwGC6VzvA5U730XZ6XV0wNNdeSpmbzKhjVgUfQxGeTqvj4Qso+sWzLlHC9Q9MR7xvfoJNOKkOsznO8RNLn1niPsCyQUnvPEhStrAiDJY+AvAN3gtcDZ5fTbgY=
Received: from DM6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:5:177::16)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 19:20:27 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f0) by DM6PR02CA0039.outlook.office365.com
 (2603:10b6:5:177::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Thu, 20 Jul 2023 19:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 19:20:26 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Jul 2023 14:20:25 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu/jpeg: sriov support for jpeg_v4_0_3
Date: Thu, 20 Jul 2023 15:19:38 -0400
Message-ID: <20230720191940.780187-5-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720191940.780187-1-samir.dhume@amd.com>
References: <20230720191940.780187-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 866b3a37-f81b-4730-522b-08db89565fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwakvS3RSBVuLjYxmeOhYdYmt/6ugSjIe6CQVRctq2JHOPnhykWhnVYogXJ/mc0s+PAEKWDovn4BXkse5Duwj8VST9yagwYorpYqUPmSuxvxNPmjrycaecr8OsJYmleDDm+m0u0wE8o3UTRuqLfqe7mPFGpoRZWIMfWommpdemCuAWNDGhN3wAviXnrwt5ZkWfL/cF9/K/zfo2ha3tj6R4oGnDXmf9XNhwUm5CnkVUvIPxs6lidHlJdUcMoBXr18QmPIvVR2TmnRV74my6/G/8jNUp1XfB/wNvFu3GYuimSfEy6+oPOifdn4h0061HavvjgDEq9t5mUtxtILIvcLnD03PnWLj+nHqiKkGif1VGBOUTKLP/7Nl1ErfSZBEmNaKYUVRYJZHHrn+L6PS9YPGIOwE5Np8pwD4WwQMg6Oo5Y19ntPhfiyoQsmi/yfskIUQZnzuyz2yGRXpZpg6pZ4zRMCrxXtUgWre/xYduseis1ckGtftz07seYtllkGg6LB2bKOhDiUMOAmwyrr2SBZEe1qfK6iWT/regciyd+/HLdurlxP1NFPuLz4D406CvdwA2WHZSSROJQkslFUsG45TTLZTMTRrhj3tZIA8XdL6hvgkwKcfiYvavmPn3A3iuPPKjfPgnZqC8aBaXZXkrwdHGk6ai/AA6vxO0ZrSbymJn3vypB16wnb+4ZOwBE8xKmLVxZBKrF63foORGdoHRzd5CQqNGg5jtf4xf98GJHxlkMdm16bMEniYQboPH0pwuVd43wwG52084gZ9u37fME1Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(478600001)(83380400001)(336012)(1076003)(40480700001)(186003)(41300700001)(26005)(54906003)(6916009)(8676002)(8936002)(316002)(356005)(2906002)(426003)(40460700003)(4326008)(7696005)(44832011)(36860700001)(70206006)(6666004)(81166007)(2616005)(16526019)(70586007)(47076005)(36756003)(82740400003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:20:26.8096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866b3a37-f81b-4730-522b-08db89565fb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

initialization table handshake with mmsch

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 171 ++++++++++++++++++++---
 1 file changed, 150 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ce2b22f7e4e4..85ee74fdb7e3 100644
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
@@ -160,6 +162,117 @@ static int jpeg_v4_0_3_sw_fini(void *handle)
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
+	int i, j;
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
+		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
+		header.version = MMSCH_VERSION;
+		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
+
+		table_loc = (uint32_t *)table->cpu_addr;
+		table_loc += header.total_size;
+
+		item_offset = header.total_size;
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
+		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, i, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, i, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		init_status = ((struct mmsch_v4_0_3_init_header *)(table_loc))->mjpegdec0[i].init_status;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_RESP);
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
@@ -172,31 +285,47 @@ static int jpeg_v4_0_3_hw_init(void *handle)
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

