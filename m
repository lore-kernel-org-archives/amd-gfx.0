Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C01606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vsDuYRx1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B5D010FF5A;
	Thu,  5 Nov 2026 03:06:51 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF3310F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhkpJlYSl3PHs2z8y4rcHeZqf7/v0yLTvK3oYz8kaV1zlbTICc6qilStGllXAQ71KpscN+OvuN2W7C2u0Qj+8WRdSGMyBH49qhKGMxezqWIbIJJ6NQ7jjM5jLvnN2ONKnhFC1Zv7GYTwSPxTCQwedqi4wG2L93S0hrpNBM5Hfse1UoxpE1B732oJX/2ilhRdiE3bvmiN6fAGw1AlsraDYdF7NdnQHwQPE9uf8RGV3FnT8xCF9DWIEzNKwMzn7yeVKo8eD25jwdopSn56Wm1hcnqRPxoTZ5jAU/V12OOJEorPMLJdykYzAiy8Gv4Y26Q4AlL/35LguFZ9GzUAO06OiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eadGjxpwahZAF/FAEmEeOzrMF1dfONqQKav47j27eT8=;
 b=fCtIetBd2iw2OjvM1UeSgJDUSo6XNspXKMcwWjcnbAerahPVP48W/h0WNoKPG9j1oOuJloU/IP4OAwHAEFFTQgCvijzsXd594XelJcMzfdX7iZhBHn0Vj6nQq9TaQWVOJ0HqF86/HG4n8a8Axb7WFclfIi2f6OnX0vxYQvnV9J/t5bTAwlA+YVyRHx8JTzrbr9WKBBT4DTh5yA7BFqQ2po7aNjApXjddqeGWMn5o3BLqcjTSBBrdrwtBGv79wRZSKbmRnxYCYrs/TOC8f+7ocryAUgUtWiknUcaCpGH1xcEttMPx4PMW6V7q+WACqIwMNf+2coUngvCl8bd6zeRMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eadGjxpwahZAF/FAEmEeOzrMF1dfONqQKav47j27eT8=;
 b=vsDuYRx1cC8xWxxetz4ocxU5WivWGwVFN6az4nkij/N6ID0I5f0ZpsQK1/rNJMQk0KLS1CU8sU+ZqH6vfI8WsedIgx3uLcbG+LevIUJxKGF6gpEet0//gWUBhWOsbo3GtuPmIVwZxAEdjWfQKHpqKIZ76IktyxE+SuI1z2dShhs=
Received: from BN9PR03CA0443.namprd03.prod.outlook.com (2603:10b6:408:113::28)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 03:06:41 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::47) by BN9PR03CA0443.outlook.office365.com
 (2603:10b6:408:113::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:35 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:33 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 09/13] drm/amdgpu/gfx12: add a gfx engine soft reset
Date: Thu, 5 Nov 2026 11:05:51 +0800
Message-ID: <20261105030612.726542-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: c485cdc2-171a-4cf7-443f-08df3ae9d034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 7BjpA6k6O1et/dPeI9G1iVzn6UwlNc9AIRdXpb/eN7/yAp9sHChBwiquRJ6HdINe8J81p1EeJQRtTqc2VCRzmWnz5ud+lud/BL6jrycqou89Y3pwBDh1IvSnF2sgUNwPGRGKchEr25iNK6zUMa5tfEiqJfZEBeHieYV/bzd1y+QbNgsSKnQRT4UTjyruuOeuNSKp/FK91YmlmtkMD2UIPBDxIrJL4CFIdNttVsLUnl4OjR547KqZO0ZEz4Yn58BwLH2HghJj4E6gNPuA8XxqVaJY/Y5xK+uBhumJYW9gNhwmuINY3YhAqPONXOZw09ENcH7McW0y/blcVgo1ehsp9lxASqwyagWYYYqwFz0FPadWSZc01/mWiXi4K+3uNSS2Bu8r5FGwXxgGFDl+RYC2K+O96IFMZH/Ydk1Op9/2VrLyjmajPjVdSAIULBpt+QoFByFVz0dRzy+7tFOH01WBHy2zKrZ4Q1GhpCByc55I7f6auvnBk3LYvsA0IWh1g0ubLnF7tNS62ZP06DqPCWxFZpWi1P9pSb+0R5CiPf8vH5jILOVqiMrFQ4WHAuOtQ1gY/dJ2r5n1nPskCTQISdg3INzJKwX4Gyq0LvNl3JurgHwR7ElOiDnATqgfxxU888iM4foH+tNYgpuw/yX40pk5HjyQot1BCi4gqLZY9noKNI2jkUVYFHiWOfrmkaQqacEY4Ib2QMlVILy93ZBHIYGJLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NaJf9TlWTQrKzzyvm0FGyCDRv21Bs4l5H793CZfXfzezpj6nC74nQt/W68bwgeCHmhdixVy4rxVxtVGUb1ZpftJrHNVsnkr3ClgWEKbtb4S8c8sb8ArXCRjLh9fWwt42D6BmWkRn1cvUYG7KQUj5gFMyesVJ9Ww0TYdgyAXRL8UazUEEgIEcb9GGmih75H7wuHqao/BIJdALGvPmGFOH+slZMpDVPqp28m/ncP3rQj0kZJBG/PMTYYHQ7bkX5Ar+bCf9tXMoWbfDjKOcTbaWD6BHxKkUN066KL9IQlzq3eecsxAuwmeBDK4BW2e9ZqzltSU9Gj0G+WbKM51mnLmkl8regOf/4YZpRcnYneA29ivd4UHg7hCI83EVI9FGHEeW0zYOHDtcc7RNeUSj78gHADxQNBAJLIVBcPeaJONE9D66K3DYi/B2CSAzoXa3PydY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:40.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c485cdc2-171a-4cf7-443f-08df3ae9d034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

Some hangs leave the gfx streaming engine of the CP front-end stuck, eg.
waiting for packet data that never arrives. Neither a queue nor a pipe
reset can stop it, so they end in a full GPU reset.

Implement soft_reset_engine() for the graphics engine: halt PFP/ME,
pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG with
CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET, restart
PFP/ME and map the kernel gfx queue again.
MEC, MES and the compute queues keep running. The MES lock is held across
the pulse, as MES fetches its queues through CPF, and the CP DMA is
drained around it, as a request in flight leaves the ME busy.

MES is suspended meanwhile, and the gfx user queues the reset clears are
saved and restored around it. If the CP doesn't go idle, the reset fails
and a full reset follows.

v4: Implement soft_reset_engine() directly instead of a reset_engine gfx
    callback (Timur).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 129 +++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 484e876fe235..8b96f2a29b1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3860,6 +3860,134 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+/* The CP DMA and the interfaces its memory requests go through */
+#define GFX12_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
+				 CP_STAT__TCIU_BUSY_MASK | \
+				 CP_STAT__RCIU_BUSY_MASK | \
+				 CP_STAT__UTCL2IU_BUSY_MASK)
+
+/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again. */
+static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
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
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX12_CP_STAT_MEM_BUSY))
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
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX12_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+	amdgpu_mes_unlock(&adev->mes);
+
+	gfx_v12_0_set_pfp_ucode_start_addr(adev);
+	gfx_v12_0_set_me_ucode_start_addr(adev);
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
+			    REG_GET_FIELD(me_cntl, CP_ME_CNTL, CE_HALT));
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!RREG32_SOC15(GC, 0, regCP_STAT))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static int gfx_v12_0_soft_reset_engine(struct amdgpu_ip_block *ip_block,
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
+	r = gfx_v12_0_soft_reset_gfx_cp(adev);
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
+		r = gfx_v12_0_cp_gfx_start(adev);
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
 #define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN	3
 #define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX	15
 
@@ -5375,6 +5503,7 @@ static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.suspend = gfx_v12_0_suspend,
 	.resume = gfx_v12_0_resume,
 	.wait_for_idle = gfx_v12_0_wait_for_idle,
+	.soft_reset_engine = gfx_v12_0_soft_reset_engine,
 	.set_clockgating_state = gfx_v12_0_set_clockgating_state,
 	.set_powergating_state = gfx_v12_0_set_powergating_state,
 	.get_clockgating_state = gfx_v12_0_get_clockgating_state,
-- 
2.50.1

