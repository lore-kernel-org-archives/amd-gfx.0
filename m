Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90215C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 20:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F1A10FD6E;
	Mon, 11 Mar 2024 20:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xBvUgWxo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FDF10FD6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 20:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLTgDwEUdabElobSglt/oP/BgTcPJUH/obKs+8w9eNcQJjSDaW0Uwnc3HSkF62l2OF7s8FgabrFvJFJahqOwNPCra/ie/5ZqzyfMCyncgGmp3Com0Yn8+DX27FEVAK/9LOaBg6l++mvZ5FzEb8MZfatWLLpK7aSVdZNw+1qr/kPySXSD0JbiEYuj0iihEeG/VcKlbzUGNJcsnHTj6hOZ3nPxjn4o1o6jVDx+lS+ONU2DG/wKA6GSH+R7jpKziied8KOw33IRgv+r+3EVq5cbyfXZSCmSRfk4wlm97Xz0CX5ByRRs0N9c9UZj5yfFZec5O2l76EAA0bamb5iRiDjHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLJWFS4y12SrQZ/oZ9AGKf5vZcDWNsxUFja6fe51I4c=;
 b=Bxg3sz14c3yjwzhlc3S44rybwhnr9t2U6Lq6QDE2fCckHiQ5F9h/1uRMx3n6HILkN/MA6PdQKd7cHxs30JbHGUr4a8oP8tGEx45+JcU/HaEXYKApZRsJaLvBWSAg0IBATth7y/qL39ZOjXXe0w2++8ptihcOkOl+JEMIC3rhNZqjBks1beT9XuGZB0wj92lgzsEZLz5Wh0mg1AqGyrLyx+EaKJmtSRY8brIILxc1s07l1wZLgB7+HVwqtzKtERzWOYSECHRILq90bpiefyARcGJBZkK7hRtE5pFxJZqYXpukj+XE9SBx4OxhUWCVDPKMWQnG1nguWUwFM9wCiaHGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLJWFS4y12SrQZ/oZ9AGKf5vZcDWNsxUFja6fe51I4c=;
 b=xBvUgWxol5tc4stAxxx1YXPBLDdYAzMGRKc7kpuYj6j0447HiHmIstzo5vE8yIFagby/9YljMmwbOSzD9bXm+jo2uwSYYLi0vq9WicbgH+nM2Q4/Up9jTbhK2Ggm/HPM1KoocGEZgZQqBgE6/8mTJj6NhbnjqFYlNGMUPs4Vl6g=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 20:11:09 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::5d) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 20:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 20:11:08 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 15:11:08 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <zhigang.luo@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: Do not skip gfx9.4.3 and sdma4.4.2 fini under
 SRIOV
Date: Mon, 11 Mar 2024 16:10:55 -0400
Message-ID: <20240311201055.16759-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: ba736fff-788a-4bae-96ad-08dc420763ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYhyDMgTzSmuBanJL9CaFyt966G8HT9k/VZ5nNqXl/XY85Ne1JdnWQ48Gx1OqHYIL2jobZXqeL6p2cbZuB2xDOy6cM7kXNlMRKO0eAgQzVzB0OtUKDUbdTdUjYUa7pokwSLj0/zX998tegSMDnasJyCDshSFiYawRZ4QPTgsvNcwheMom9k8grDADIea43wGdB33aAUR9NhmB6cX07f6cRbRbISKxrK4KHDKKCYl4UCKxulEYkVtVNtbrlYhPSOnlxlv7hx/ccxe+mTvREBYjE7FA6PY8wCaO4UsBMtUH5k0lcZG87s28y+9Cn6NcRcCzh686spvC09MvAdPT5CjOrH483kLd/QDIO+I/mZNMrA4sCDMXslzwPNi7GevO30hV5rTXer4d2rqC5r1MmszAqN4M2EbFTKaLu5mA9qu6rbgjthPlPwaD5U6bOEWaRFOYj9X7sem4waMG2iLCV0YGhrsTJXk5H5pAlv+q2c+XonIEnFV7zEZ8zSyGqXrSgVtmi48LCmz+/QGUVxNUrZZJFYt1CbbqFiCNnW06G1bq7NjD149Cpk/bqYsHhdXT+Es9nnsY33qKO1/V0c8RUCwgQR5Lxq/kFeNWqQVeerJ7q6JqtAZePK/qTY1VZJjUMkg87t7ik9MQXOQrbFSS9kwgEz46mqGmIl90GxgNvGewaRsEEvd3oyB87i9wKELMqtK5MadmlKkpIa2zzrrmEX6kXJA7SvmL40WMYQa943mC2/rhOsosi03+b8adaYzxHKu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:11:08.9197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba736fff-788a-4bae-96ad-08dc420763ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
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

GFX and SDMA is not properly deinitialized under SRIOV.

Remove amdgpu_sriov_vf() guards to allow VF to deinitialize correctly.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 9 ++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b53c8fd4e8cf..fbc34f1797a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2049,7 +2049,6 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 		 * hypervisor side.
 		 */
 		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_WPTR_POLL_CNTL, EN, 0);
-		return;
 	}
 
 	/* Use deinitialize sequence from CAIL when unbinding device
@@ -2068,7 +2067,11 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 	}
 
 	gfx_v9_4_3_xcc_kcq_fini_register(adev, xcc_id);
-	gfx_v9_4_3_xcc_cp_enable(adev, false, xcc_id);
+
+	/* SRIOV world switch will fail if MEC is disabled */
+	if (!amdgpu_sriov_vf(adev)) {
+		gfx_v9_4_3_xcc_cp_enable(adev, false, xcc_id);
+	}
 }
 
 static int gfx_v9_4_3_hw_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index eaa4f5f49949..fa0752d81c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1441,17 +1441,16 @@ static int sdma_v4_4_2_hw_fini(void *handle)
 	uint32_t inst_mask;
 	int i;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+	/* SRIOV does not init RAS features */
+	if ((!amdgpu_sriov_vf(adev)) &&
+            amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
 			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
 				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
 		}
 	}
 
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
 	sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 
-- 
2.34.1

