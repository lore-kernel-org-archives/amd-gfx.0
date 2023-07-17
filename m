Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554ADEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29AC10E281;
	Mon, 17 Jul 2023 15:59:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B656310E280
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI5oUWwpZCpCYKR+9kh8QlEIMoWA5ev9DRDQm87uI3+9EBhV7GQvsRN80PWqKvSZgUCWud4Wz/at56UXlNkCK2bSH1wN1FDMe2ceSBGQq07bom9eQyitBPVwgJmDcdEZziu8CnQrrrJF8p/DxT3Qb7tPa9u3hAvbj//1tURedWoYE/napiqDLY86rSmu1SodZGxHBwHiH8/zuxDXTmghIU+5qBvu23HUJJ8vuNcgmQu0TwauItlwdjg2C2ZOG7FZuGr5Ml4F4TbIgqlCeh2vAmAE9pDCHWd1J6F+yCrb6n8MUprRJWCp03o9ThqqLUqdxv2WYDGHlV8PBsOsmZNXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUh0u3dWy7QwNtTj9/FnUX1aJGtfnyBXQqO8wQ4Z7hQ=;
 b=jex5NDQ68IUVeoztVa0XFNzpSvgVL4aMbX8BBuvySEKVVYVc907O6g0lnYUvFSk4PBgG9ziHiu27Xa4U9ZEEO9saCqx4CIA4yQ+q0Iu64p9eBqFSrN0q9pa1no2KY68hCf2NKOdCjiv55lmFXGs/tO+mdR1uwSa0tl3pFXHrhf3iPTL+Jh3Mlb7lsfjqDunuNl1CpObuRrbyaY0B8CkzHiLao8S4fEuu1DAioOgI1hhCpcMxRIEaI899kTqDgBVaiEw+Y8uIxzEgxMkPjcwHf+ohXTrKVMubel3LbPZ80WxMd7FhmWdtSOo3Kno+prf304VPjxxOe27VC70oaej+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUh0u3dWy7QwNtTj9/FnUX1aJGtfnyBXQqO8wQ4Z7hQ=;
 b=qaNgOYrBQmwagjIbA6J76aWttothYZQ6WVyCxBVyX326ZWtblxrG5hfdOI4XEpRcpBW2/6gZpt0zmfpmsy0PTJGinOfUAaRC+ve1yenROFmY9OmKUlaYT7V3htZyF0JgTt8ZCAlZe376vYmFY0/d+fsB14HsAz2JENHVyOeuGCk=
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:59:17 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::6f) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Mon, 17 Jul 2023 15:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:59:16 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 10:59:15 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu/jpeg: sriov support for jpeg_v4_0_3
Date: Mon, 17 Jul 2023 11:58:39 -0400
Message-ID: <20230717155841.758516-5-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717155841.758516-1-samir.dhume@amd.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ccac16-0584-4b07-f2aa-08db86dec64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJMye6vPrbjWTfELnmjrbOnkyLt+EM6OSGCUOqKTfAEIJnoRsSOcaT+kge+7R4i2I3qi19bqhPHKVNFPNENN5zD/rgo0meUh+dKSoNPxkRq4zJkMJ1xbtRydya74SpBZtFkwZUpidYOvXhLXCuoxt5YgnPeHf3ILpXUMKRWHKpqfWQB36A2h+T5WYj3mVx+M/Q8d1kNHja+iOcArZUPg2tG8bzp8E83BcJS9/aD+lOGkJuhLrQDkZR5yZTge0gf5DZvXnAXnWEo8fl2IDHPtpDbMtlW+vlCH1gSFYgOLHXWKnllyHxPwYTbcXwILkL3LcFxTJ/5edAcpDXGb/4lPWBZfoViaegcIO/LHMdReH0yEJFbtX9QZBcJo0WV/l06E5Sz8BcW3dSo3GMPbHoJJljRp+PscQDOaSDt7rZfQoYAg+52Tu66w3F26yz9D060iu/F91kb+ChKl2a48TjzFJm4Iy9zQWwBDKOQLEkhAEdAmXAsLKPgXtpyA0jJi0pszaZAbvSQ1oOEkiYgsRVcqD8sd7w8/3nUeZ/dj2wIK9ImcfSLD9x3mx5VV98jNDi2JQMcCqI3OaAFhcu9Fm/P9sMVIGOGjT1pCqSCb79OLQgjV6utbFFTV1Qxov+d03L10MFPGk1KtQ6TnfrzZgeGllqtQt+ranY9px5NTzONte4eCmvQqI/BoeECkkiE91nlzw/qp86SlBXCwqsiOjZ8f5KIWkm12OoS/405ZtzMONddwj34uH8EseSXdFfJR/e1MGNGTftgL0pTPLTOCvJebuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(478600001)(7696005)(6666004)(8936002)(36756003)(8676002)(44832011)(41300700001)(70206006)(316002)(4326008)(70586007)(6916009)(82740400003)(83380400001)(81166007)(426003)(336012)(47076005)(86362001)(356005)(40460700003)(5660300002)(26005)(2616005)(16526019)(186003)(1076003)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:59:16.9172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ccac16-0584-4b07-f2aa-08db86dec64f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: Samir Dhume <samir.dhume@amd.com>
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

