Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93058CD343F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3463010E45B;
	Thu, 21 May 2026 07:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nf9+QkV6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8F910E45B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gX7ttS/qGwUM+hQvGB+wLuj8tP9aYaHIYYS+L2fG3nTqjdt96OzRGx4GiZ0GaLlrki+UcMuygoOmOalbJ5SchDDhVcBeSFdAAAzHwigOP5sy/GBNlk1fdzZFlzdFjkbMfqyzbaOiPJrb/dLKasQWRX7Wbumnh0yqKVwa0SBPhZZUYT8/VnwpJ61hSRgITLajauiS3rQGO7pZgB8Q15y75L3Svofb1EXG3D/tK7VBC20je0zXfEkXucnovAC4HYKQw4g549s13cNV+MikLCfIWEkdUnAV/kQuNjqgEFI5aonDesdRgTtN6wuB+ZMEtpXDf2oQvR1pdmARbJMsYAdshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL5z1ggZJg68n4WbOaa1Ux3uIaeeeRI6Rt9ZBg4XSbY=;
 b=Y5tQJYOW6wbIOuA19zNh4jDIf0KkONWkMg++FfcFeDqmb1QBL92bcqQwQAsx1igvJbeoxT7VDb4rP0kF9v4tU/a04JuO0GbFY7lCb7QdK/0lFElMDLs7roPjJnslaT8gbrqM71Es5dYbyHa41uKx4+zye/6H5ARSVbs3Vo9U7SSer57uEW4bQLgY/i/xPWN/JGRieLVSKWo9gpzX+x89VZlX++tQrJ1lsYyLrPZL4TIfiZF/lVRn0r/pyVHU5klZCLzJTqAopctRtqjquMz4/DNV3fdjGaEnyOH39umXVdpOINbO8/k2lmuMPQfR1cb0FNKONdcMAp6wsn/Ff2SVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL5z1ggZJg68n4WbOaa1Ux3uIaeeeRI6Rt9ZBg4XSbY=;
 b=Nf9+QkV6ca9QSYer0odNiUA3LGLo6v5wK9zASsXvlKNaIqli4PFy57sBp8/NVNJ7JMnmycrQfUfRRLudl7btgq5BSJCvOjU2q6cnFmc91k/FoQ5osvsTaIBhVRwCRkzCbixqxI17mgHk8G7bdCJwgPISZK2cS/1kqT6DvXyMCJM=
Received: from BLAPR05CA0035.namprd05.prod.outlook.com (2603:10b6:208:335::16)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 21 May
 2026 07:05:10 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::95) by BLAPR05CA0035.outlook.office365.com
 (2603:10b6:208:335::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Thu, 21
 May 2026 07:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:05:08 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 21 May 2026 02:05:07 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>
Subject: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified ring
Date: Thu, 21 May 2026 12:34:58 +0530
Message-ID: <20260521070458.3365711-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: 79afcb87-4536-423a-70a6-08deb7074b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 2h14LuYCuA4oWspCLFajmhwOIdNJcTcJAzoM5rfkVTU9OkX9ytyyvkzG3TqlCKJaddvl+YOVcDK2sKmoNp38D5rzfS8wOuU/Bv2jvhyhxMS3tuqpwl1uyzO4XRFhjPaHd96W9uxSXlrN4hLze1csL4LMIseFLJdYG9ROG4a13HkS4cqmdQlAk6TZ7iBgPffMIM2rceu0aZ70lfYoucVEpsPn+DeClQGLt2vSupgGWUy7jg8kZToENEjId3uj3Ye90PPWJWsRufHLY2DhO4NTTHSa7tfqyFOENMHDZMozXQDDlXeVa0F0GAE81EK+6bMOKaemuirqx0qCNTJ1WkU4hAnSNRyZ+/wZIPgs0tjznonvlf/Wm5wiLjslEX65ppYHiL6ElZ0BLmt26JhLA000ODv7hPhec5h/zDYu66niK4wcT8EcBKoe6bGd9hkL3mlPRDl4T8HjfC+jKGRIDT3FP6p90gP0+fXLHzVmFTBcqfCGbPKSh6UFt/O9Hs5DveVCXUIZ7eqsmCi3rC6/pnvsRwysFdtr2+2Zr7UoEab0yZEAnxykTvty2HMOyFydbAgL+mqC92wVBJJVz7FvSsGoYo3FW+kVgjUUnv4lz7vfE+vTmnYsSHjS8VZ6gVmDSb9TOimLrUBVJgWiKsza798kcmX0xRkDRg0yzCZxLxLIPedpcxmDTpcQmbvN0PnGdj2JVgnfpZA0bPY9irW4v8o5zwt7JixPELmtdwnff04ESw8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QRU+wIo2ZQJzREjmt0LuHbFzbPIzup8a07bymVXimBugrbyF8tNY1tPbqylMRZaDyMOFu0FQfQzUNrwDIAOm8mkoYMPQY8x8RVEqiai3E1bLs3luILGiiuzl0Yw+aFKK3EQSGFjPbrR8q0TlqZlhVgtynuAMo1mIarQK7u3mH5Dbn9N8NYhNAaQYSZq60WLnzwcmL0Jhg1xzGcPl8osFbWQJTwu20LTna4QBOz489U6FjMisI8QfEbwalXxAkJ/oQ9WOZ/19ZpWsgarr9AoW5sMWTfONOD5rPHbrEzpzZ0T1TvOsgju+XBdozWyABA1w51dTL58QhWI3NiAF7iYx2IT7fGnKPu/7taSLqi0WRpxPn26qJo11dhsp4aAhfQY3Y0KNV9QaIQEOgOWqArhFrRkOzV7QPQCDBq1eevrQrCFSlWED59UNFQjhdbpOjjS4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:05:08.9739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79afcb87-4536-423a-70a6-08deb7074b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047
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

From: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 37 ++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d5f49fa33bee..3bef5ac200ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1234,6 +1234,38 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.reset = vcn_v5_0_0_ring_reset,
 };
 
+static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs_secure = {
+	.type = AMDGPU_RING_TYPE_VCN_ENC,
+	.align_mask = 0x3f,
+	.nop = VCN_ENC_CMD_NO_OP,
+	.secure_submission_supported = true,
+	.no_user_fence = true,
+	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
+	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
+	.set_wptr = vcn_v5_0_0_unified_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+		4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+		5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+		1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
+	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
+	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
+	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.test_ring = amdgpu_vcn_enc_ring_test_ring,
+	.test_ib = amdgpu_vcn_unified_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vcn_v2_0_enc_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vcn_ring_begin_use,
+	.end_use = amdgpu_vcn_ring_end_use,
+	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v5_0_0_ring_reset,
+};
+
 /**
  * vcn_v5_0_0_set_unified_ring_funcs - set unified ring functions
  *
@@ -1249,7 +1281,10 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
+		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(5, 3, 0))
+		   adev->vcn.inst[i].ring_enc[0].funcs = (const struct amdgpu_ring_funcs *)&vcn_v5_0_0_unified_ring_vm_funcs_secure;
+		else
+		   adev->vcn.inst[i].ring_enc[0].funcs = (const struct amdgpu_ring_funcs *)&vcn_v5_0_0_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
 	}
 }
-- 
2.43.0

