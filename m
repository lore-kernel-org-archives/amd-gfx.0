Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4A1C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6062F10EF6D;
	Fri, 17 Mar 2023 17:18:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD47810E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgR3HZZq7c7qzaXiEMSq3ThngVAGvfRN7YF/g36B98W0klb2Bp1PyloxwxZPDQ+KGowdhhpUg1NUO9EHHGzALkTnQ9yqupTUJJ3i98ct34U2U77FGE6VXuONr75wyUIcmums8pECWoVgDaySrAIxPSKZ9WukjYVGteY7LBru1zA4tWGJc1FOV6K+Ewgz1E4imStuV4tAgy0qEoSjCNo3M0nPPnrIL7grBd0pwWp+byxaBbw0221VI+AunBsKgXSloe0crSNhdrZ4+FrUfwTjYPyN/52csH3ePU6fFmNuHHK0xbt/zWKDCX2R1KymqJy6+MagUwzALrnJjlGo9fe4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDDslVj8CRidS7Ksp8vMO3EIW0fbCEbzVbk2zJnBTcc=;
 b=Yu2vhWp8NjU49eFkbsUQEV8M3Xx9/S33DY+LF0C7sf+iOYgyyxBMr1d/jXUn9yz4J5tDPvKFNLuEuQFoXatAHcPHD6KCFwLET8uNotkl6Zsxz0xqoNiI6XGjVGxvtf/Tvx1S6mo7OOU0ust3wceeZ0KkaMuJgdSpNYf92S+eBxl7U2oJbjKi+5CDKRVdtXsuYjgaOaXefZSvaD2a5/AOrSteiCbM/koNWgg39BIu6ATu2hAYdBaPpY5cONbmRd+gi9KZEjc03Ov6OexyH0qBvnRNZ7BvWYKAnZoAOeR2LagRr+l8fH8mmDXjf6hiroCyRAI0Jmlgk6Wz6B7Ovc+D1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDDslVj8CRidS7Ksp8vMO3EIW0fbCEbzVbk2zJnBTcc=;
 b=kqTB7YirlrtahNVE+op/18TtQotQeDggvuhDr4aF7G1cRgLAH/wPKOfmbxbXTt74ugZ+4fGL9hGTy71T8j8VHv2h9rICXoCQ3afWfuDrQ4xueJUvLx13krSzTjXVSDxYpLiOefSovKok6TMjtAHPCeXVLJpZ0SamClbnnYQTEA4=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 17:18:07 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f2) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amdgpu: add gfx11 emit shadow callback
Date: Fri, 17 Mar 2023 13:17:42 -0400
Message-ID: <20230317171748.682691-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ed3e3c-3244-4579-99bd-08db270b9350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: an86Ve8sCWmRX63alLU4New8VJvPJwoHULlumsZ/k2/MEmA6H1MHJm5gbYsy00GCM95AnQU40bWEiPvoDZ20NOCMMsmVdmhlCwduoccRDTZSc1oGa+8sajgol2Cr980MktX9sFcAKPvpd8O0b9Hat8FGWsWaXf5S2t+vqKy4tX08bCAlQngg9+ELdcAyDGsFGCbML9ryZBD8Zs65K8hoj9RtKkpdM0vzTwns+raHAtgyZ7sWghs54UV3FYtLhKCVyQZmCl+hcFvozRYKKg0EDfqPYKmBt0PiD1OltngA8DY6mvzpmP9Db2AuN4wO2E4JXw4hyTHO/Y0VD+nHj81/cB3N0tqdOOXTz4RmI15kg0MKEeE4STyU2oJgwbtKck/BcwNKmmbrql01EQJzLGLKvv2pawApK5KEi3aLJZPfDhbLjaT1Xv7yCd+eVlhU/ldbOFoS+WBJsUFGLyVKx7dZInyfg1O8wbk6mPVN6QVicr9CGP+3IIcj2sevUKuTRVq99h4//75VNff0IL4xUbt3jPgWeZZvN8sWElvhCTd+4HmOM6AImq7NfSC55rh20aW3YUkYN2qhNXsdtLZ0HyGPOToP0sBmH59Adms5cbJ36iYcum4RRNqcsJQgNhl6ronnfIjlR/Apvi7IVO28qgrZZKQ7PSlJt2VEzWuvfnG86XF+1lG1bPkgXyTKxlT5gMV77MWsSQ7oz8Ic55qSgiy8Tb/r+mGkGWeZr15mP48J0+zMfIXOWVIr6ST2Ij6IFCJUp3AIqUMp3KFkt+yBTYpImw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(70586007)(8676002)(186003)(6916009)(70206006)(4326008)(26005)(16526019)(336012)(2616005)(81166007)(82740400003)(40480700001)(8936002)(86362001)(36860700001)(5660300002)(82310400005)(1076003)(6666004)(66574015)(7696005)(41300700001)(83380400001)(316002)(426003)(54906003)(47076005)(356005)(478600001)(40460700003)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:07.2088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ed3e3c-3244-4579-99bd-08db270b9350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

Add ring callback for gfx to update the CP firmware
with the new shadow information before we process the
IB.

v2: add implementation for new packet (Alex)
v3: add current FW version checks (Alex)
v4: only initialize shadow on first use
    Only set IB_VMID when a valid shadow buffer is present
    (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h        |  5 ++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index de9e7a00bb15..4ad9e225d6e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -364,6 +364,8 @@ struct amdgpu_gfx {
 
 	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
+
+	bool				cp_gfx_shadow; /* for gfx11 */
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3bf697a80cf2..166a3f640042 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -463,6 +463,27 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 	return err;
 }
 
+static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+		/* XXX fix me! */
+		if ((adev->gfx.me_fw_version >= 1498) &&
+		    (adev->gfx.me_feature_version >= 29) &&
+		    (adev->gfx.pfp_fw_version >= 1541) &&
+		    (adev->gfx.pfp_feature_version >= 29) &&
+		    (adev->gfx.mec_fw_version >= 507) &&
+		    (adev->gfx.mec_feature_version >= 29))
+			adev->gfx.cp_gfx_shadow = true;
+		break;
+	default:
+		adev->gfx.cp_gfx_shadow = false;
+		break;
+	}
+}
+
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
@@ -539,6 +560,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	/* only one MEC for gfx 11.0.0. */
 	adev->gfx.mec2_fw = NULL;
 
+	gfx_v11_0_check_fw_cp_gfx_shadow(adev);
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
@@ -5563,6 +5585,28 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0);
 }
 
+static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
+					   struct amdgpu_job *job)
+{
+	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	struct amdgpu_device *adev = ring->adev;
+
+	if (!adev->gfx.cp_gfx_shadow)
+		return;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
+	amdgpu_ring_write(ring, lower_32_bits(job->shadow_va));
+	amdgpu_ring_write(ring, upper_32_bits(job->shadow_va));
+	amdgpu_ring_write(ring, lower_32_bits(job->gds_va));
+	amdgpu_ring_write(ring, upper_32_bits(job->gds_va));
+	amdgpu_ring_write(ring, lower_32_bits(job->csa_va));
+	amdgpu_ring_write(ring, upper_32_bits(job->csa_va));
+	amdgpu_ring_write(ring, job->shadow_va ?
+			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0);
+	amdgpu_ring_write(ring, job->init_shadow ?
+			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
+}
+
 static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
 {
 	unsigned ret;
@@ -6183,6 +6227,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v11_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 + /* COND_EXEC */
+		9 + /* SET_Q_PREEMPTION_MODE */
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
@@ -6209,6 +6254,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
+	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
 	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v11_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v11_0_ring_preempt_ib,
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index fd6b58243b03..631dafb92299 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -462,6 +462,9 @@
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
 #define	PACKET3_RUN_LIST				0xA5
 #define	PACKET3_MAP_PROCESS_VM				0xA6
-
+/* GFX11 */
+#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
+#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
+#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
 
 #endif
-- 
2.39.2

