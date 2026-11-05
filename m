Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C3606A32D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KkdGTDQ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B3B10FF58;
	Thu,  5 Nov 2026 03:06:55 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B30E310FF58
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I16G4hsYX7kDFS5VQKHpgWvZxsPkNOZKU9C1z84E7/qqKxA4Y5c6kCgDB0h8TmX52ORJnYK5vjI2IjqfgobF777XqjErBJEVmmNNxfqH6iFXcArP2gamiF+xpMEvwm4eFEfH3y2jvQmGCSOvHWO0szrsJsXU3V8L+Vlloqde0aN5Z+2uXGs6BZIauI3XcZ1yzbkGRFfvXuhhZWEDD1HNAZ05Ag8qo5WGLdaWg5uVoV7zoKIWms0WTP3KSlbp+qFplow1Us9OTAzH/L4Y/Zyk3kB8lDVKvGq87eh0O1krXIB4Hf2F4u+ptS63IpDhBDxv0+UET3bLst6oNsJ8GxrwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckMqKrbhNkUz0jCOmdGf2od3SSYQ+0lVgYkZx2Nb8ag=;
 b=Hb9DovMi3KhYHIELVh/3bLI6Mu/xqfqhUOn5OW4IOLug/wS1IJRug6nlOaJpCkhsMUk9VloyxogR2NHOR4lrQdD8AElxuAyeCii1tvSy/0y5KJbYQz11vS6rU0wdo0B4NjUEVDHJRlJUCu3IfroDeVqcHhj1YTdeDJy+akiJJMF8DmrZInsm3rXcIunVQ3149o+nUwLH2Qr+rgbCggEEPA2uRQcaBHJ4QIqaPz72yBg+Lq3+JyH2t8UiXMgK0xxZaYt+Imo7Uz4Nb5yDJcWTvpAtWVZFvKUYEV/gsBWEfgl6m9no6ArkmW+H84HfiEfR2fNG4JHp9rjQnpiKBvR1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckMqKrbhNkUz0jCOmdGf2od3SSYQ+0lVgYkZx2Nb8ag=;
 b=KkdGTDQ6rHLqP1YN4IZ8GOq+FnLwvqjp3jTL5UT/NyS3wYDnjSB2udnSk0sp/Cghr4OS9R42DZEUFvTMxBFYR2jkPuvbGiiVJDiHBNzIpUE5UfqGaf2ID6fArKhZCVXJ6irBR/Ci+3ErszBgaqxjMPz9bFzxC/Zj/PCLNAteBLU=
Received: from CH2PR14CA0050.namprd14.prod.outlook.com (2603:10b6:610:56::30)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 03:06:43 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::62) by CH2PR14CA0050.outlook.office365.com
 (2603:10b6:610:56::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:39 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:38 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:36 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 10/13] drm/amdgpu/gfx11: add a gfx engine soft reset
Date: Thu, 5 Nov 2026 11:05:52 +0800
Message-ID: <20261105030612.726542-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f5b1f7-8ef7-4aaa-cea7-08df3ae9d215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|261021121427099003|261021123027099003|261009223027099003|56012099006|261022075727099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Ccu/yEX1d0SemwhnZP0qr8/qI+J30Z7K6Ho7tkufj3V+SDKmoaJulRHRkaMGFmCqOqt7+sLcYhwBg/pcLwRexVSYJc9HXGBKja+pg9W8vDPTA8bbqsI64hxfCQ5ZPNOlnYUUpVwE2/xI5ZsFp2Q4lXQynyLbcBfr2iJQzKI7htKrM9Gh8K3U6RGDjm6TVV3NAAl67OtQJaJvZdkSdlnMipebEZ03Q/N1iwPGG/+AgC6ulzXZA+fG1SbNRPVazkBV0snzS46S48IlBhEBdLbO6x4MEI6nzlWvl62cChJViplGq3Q0d3OE9ueMHYxGO/Pz20T/hDKWuxZ3T2s6P+2cuGxikgERuBAbwTuvEVeM/FPCeqDCqc65+pvAK2k0zDowjNbSVaYLxNGFU6AVperGnu8oGLM+57C40/fvzJkO89BSniiBtuDiQitoEVAU6K/ADLl38O8vaZyjYMxjuVR8FN8FqRZxN2dpOLlRWC11hpqnM0diwGmFmLSlUVjfK0LAWSwZIpXzVOfKfTpOkMoo3MDTg7kKDJWmhNRbZhdp6gHsosL4OVoVLav+dF29+2OiSyAwHSRrNviubaXeMeJg1Xa5R2J5eMU3sjGiJRNahkd6bkyHXMHWYd3ibXE0RvKTx1wxOuYea61ybsjVP5BE/8vjqNyuUfEmvOQIRBuUlzuIb+l+jmMT5FasxJcvgmgA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(56012099006)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uq8q7pDfB0L2xOkpGywTJBtEBuZG6IKTuA5bn5+cJ1Oz5jxpgf3ROHoqk2sp1xxmFPHlzE2sQK9k/79E3NZLhJnIqBxZiMiy2XZBF/OR9UD0fsJkf02g4BBJV9WtxV2PAYCn8RzvsGZ3urddDN/L+xkqW2W4VMdmjQeLFYTIz6Jr+FWhd5+IAxxTKG5mTr0yolvpm+nmOu5Yvdz7wac1k8wSl+2/Mj5bFPayaO4k0Fu9SpEPzp17+xJmz0AUcK1ZK8mGYFv5304k3QkpvspT6Pn8zzPR8QG/xXDHy9dhA+U2tfZfZmT0cereb8I1Tq99NXkKbEDWuhEwS1JS7m8ZnDbZgUqduyySGmGm2Q3UNpcUxGzW5zv+6gzSLeaoNTOXZnYxVWb5oBZkNuDkzlFjFsHLN+kha7ouOJn73eNbvrt2STxWAM/EFbuoSutqPGL0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:43.5899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f5b1f7-8ef7-4aaa-cea7-08df3ae9d215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement soft_reset_engine() for the graphics engine of gfx11, as for
gfx12, with two differences:
- clear CP_VMID_RESET: a VMID reset the hung PFP didn't handle survives
  the CPF/CPG reset;
- boot PFP/ME with CP_PFP_IB_CONTROL cleared and restore it afterwards:
  set, it makes the F32 PFP of the APUs resume from power gating and wait
  for a clear state that never comes.

The CPF/CPG reset already puts PFP/ME back at their firmware start
address, so unhalting them restarts the RS64 and F32 firmware alike.

v4: Implement soft_reset_engine() directly instead of a reset_engine gfx
    callback, drop gfx_v11_0_restart_gfx_rs64(), and boot with
    CP_PFP_IB_CONTROL cleared for the F32 firmware (Timur).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 134 +++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 798015689f0c..80b91459f5b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6777,6 +6777,139 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+/* The CP DMA and the interfaces its memory requests go through */
+#define GFX11_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
+				 CP_STAT__TCIU_BUSY_MASK | \
+				 CP_STAT__RCIU_BUSY_MASK | \
+				 CP_STAT__UTCL2IU_BUSY_MASK)
+
+/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again. */
+static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
+{
+	u32 tmp, cntl, me_cntl, ib_control;
+	int i;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	/* MES fetches its queues through CPF: keep it out of the reset. */
+	amdgpu_mes_lock(&adev->mes);
+
+	me_cntl = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	ib_control = RREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL);	/* cleared by the reset */
+
+	tmp = REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	udelay(50);
+
+	/* A CP DMA in flight during the reset leaves the ME busy after it. */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+
+	/* GFX_ONLY keeps compute and MES out; CPF alone leaves the stream stuck. */
+	cntl = RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
+	tmp = REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL, GFX_ONLY_SOFT_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL, GFX_HQD_REG_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
+	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	udelay(50);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 0);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 0);
+	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+
+	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
+
+	/* The halted PFP stays busy: only wait for the memory requests. */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+	/* A VMID reset the hung PFP didn't handle survives the reset. */
+	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);
+	amdgpu_mes_unlock(&adev->mes);
+
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
+			    REG_GET_FIELD(me_cntl, CP_ME_CNTL, CE_HALT));
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	/*
+	 * Boot with CP_PFP_IB_CONTROL cleared: set, it makes the F32 PFP resume
+	 * from power gating and wait for a clear state that never comes.
+	 */
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!RREG32_SOC15(GC, 0, regCP_STAT))
+			break;
+		udelay(1);
+	}
+	WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
+
+	return i < adev->usec_timeout ? 0 : -ETIMEDOUT;
+}
+
+static int gfx_v11_0_soft_reset_engine(struct amdgpu_ip_block *ip_block,
+				       enum amdgpu_ring_type ring_type,
+				       struct amdgpu_usermode_queue *guilty_queue)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, r;
+
+	if (ring_type != AMDGPU_RING_TYPE_GFX)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->gfx.mec.reset_mutex);
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	/* A hung gfx stream can keep MES from suspending: reset anyway. */
+	amdgpu_mes_suspend(adev, 0);
+	amdgpu_userq_save_hqds(adev, AMDGPU_HW_IP_GFX);
+
+	r = gfx_v11_0_soft_reset_gfx_cp(adev);
+	if (r) {
+		dev_err(adev->dev, "gfx CP still busy after reset, CP_STAT 0x%08x\n",
+			RREG32_SOC15(GC, 0, regCP_STAT));
+		goto fail;
+	}
+
+	/* The reset cleared the HQD of the kernel gfx queue: map it again. */
+	r = amdgpu_gfx_disable_kgq(adev, 0);
+	if (r)
+		goto fail;
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+		amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
+	r = amdgpu_gfx_enable_kgq(adev, 0);
+	if (!r)
+		r = gfx_v11_0_cp_gfx_start(adev);
+	if (r)
+		goto fail;
+
+	amdgpu_userq_restore_hqds(adev, AMDGPU_HW_IP_GFX, guilty_queue);
+	r = amdgpu_mes_resume(adev, 0);
+	goto out;
+
+fail:
+	amdgpu_userq_clear_hqds(adev, AMDGPU_HW_IP_GFX);
+	amdgpu_mes_resume(adev, 0);
+out:
+	amdgpu_gfx_off_ctrl(adev, true);
+	mutex_unlock(&adev->gfx.mec.reset_mutex);
+	return r;
+}
+
 #define GFX11_HPD_QUEUE_STATE_CONNECTED_MIN	3
 #define GFX11_HPD_QUEUE_STATE_CONNECTED_MAX	15
 
@@ -7045,6 +7178,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.suspend = gfx_v11_0_suspend,
 	.resume = gfx_v11_0_resume,
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
+	.soft_reset_engine = gfx_v11_0_soft_reset_engine,
 	.soft_reset = gfx_v11_0_soft_reset,
 	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
 	.set_powergating_state = gfx_v11_0_set_powergating_state,
-- 
2.50.1

