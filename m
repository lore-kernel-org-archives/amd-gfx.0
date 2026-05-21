Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BC2CD343F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D25A10F224;
	Thu, 21 May 2026 07:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJpgfO3G";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836AE10F224
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jILb6q5F1pIlUz3B+H2dzAq8YqqxUwMW+UYVhitOpvY0R0VYQFpt60A9MiHY/QOwVS2hFAw7wKJMaTxSfWzn8ZNZGiFDVeg2JP3baNwppQPc2Wrv6YgI4N1DbvzG4VQjxjBQ0kXBNWu7C/oxZ8fQReH1uPUu3PolbmxbmzexJ06dfIQ2nxSOhT1AbiitzPirFSCgxjmWh3DjyDa2CHMVgcBrd+GeMsbKDKoWSuXonsA1sAdA/HOHRswn7tJgMD1gIOxXUsJt7hV6BAAJAt7j5lhY9oJcKCZhz2pFtHheFWq+0WR5cmr+OXYZZCEcAxgB3lIoUdj4+nrBCmWZ7x4cBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzAFaX/srD4KlhkPscnMZs+Ht5XYujI0jZvwXcr9X/s=;
 b=XyXz0cUr53Y+cdr6Kx+VXNSMbdMwb2nl4iLKdrHYTv29BURpLCkAQA7hkI/U/idfnxu81Byz4lhSLDSjZm7VjQhO7AETS6+zOWoqMCSFt1q2OHQpn6xqYDMvokN2h7/IzqAAoH3NXiBp6WQHSK3Plf26nHyGqfLRv84k4Ws2jklLf2GHv2hTMLIxPBYFwHCVnW0Hzajw4JoXUKnvZojN3qbnW72M9SZh859uC3cZDNZfV+a+q4U3DIVuYjPqzwXYlw310atVXsdHoBI6MAAXMLyP/jEhCSpe57L6VDQSO2mkq7t9H35Lc7rG4x/mkGPxXymNSV3zDYeu3n3IZpSivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzAFaX/srD4KlhkPscnMZs+Ht5XYujI0jZvwXcr9X/s=;
 b=wJpgfO3GMmxDgmcRrXScuGNCTFkkjPDQvC/hXRcqJmeeFopdaqjmTPcLC3E4h7zLjq0G1jn4l6/1GsW8Y65J7QDEW057Tqw9fMZZe1TIYnFecfwfI0p/7z9zDHjCGBpt3gspK481NJbxFsiARoXKYKIo6l2c9jPkgq7rYJhMh5o=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:06:25 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::68) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Thu, 21
 May 2026 07:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:06:25 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 21 May 2026 02:06:23 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>, Jeevana Muthyala
 <jmuthyal@amd.com>
Subject: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified ring
Date: Thu, 21 May 2026 12:36:13 +0530
Message-ID: <20260521070613.3365993-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ba209b-cb3a-4e07-6817-08deb70778bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 1PJMv/dFRwlM4KSF1VcC0McNFixMJvyehSZw5V2ibH5guFY/0D9nK4iNbNXa4xEP/Z2WT1E/k4qUYzsPnd8bT/VbUEjoqKlfr1R+axV0BjSSDGj+Pbv5oPf8O4EpbxfDYKYB4UR1VBZFQxi6YQ4vQ/bfj/5id0wElW9IOhZHc3d+a++CkiL9k9EqgBM26vWO5a5NL4Ab9S5m/1Ix7VqTBGJgv0H4Cdt+bXl2nTzzkUTq/usHHsj9S2Irq92rXQurbmCjBLZU51QFdWLC7cMax6qmY3I640qhnDVt0LvyAowdWe566IxcqNofsmylmfXfW4WDLEOIeGetPgxdAeGS8gMs4s6lJn6R7AMl5Hkr/3rxUKQV9vOwYxe1ZHdOt+6GhII+jvHwpxwSFo0H0m4V+1c0zzZ2qvdqMjIPnFH48+r+cbXYfshyX2OX4vz/xWu3vWWKw2BLWs4wluG01MxCVNtR16lauSwBFhuS4kkJjkQG2E+1MJPF3ijZRkbkqKTXvlNEnobpv9cFovMeykRXqAHP/FtnK1PPd9ptBq9Ow1oSx0P5sRzlzBy4BB8liyErBmOLBxkU7GsKnnzWo2YLIqF0swiDxVKf6rGIroSfn102sPOGqLY2vJTWcKk+LychxLtdlYBG75EK4avDiZIKhIbjmoEtOV4eT5QD5SV0rPBy8xFw6Ev1Ty36iT1Yya5/9nIdf9KapIX726qg0JG8GxxzkwYYuKjaa3OE8Ai3DO8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f683QJhlT3K8XG34nVlze3PrudOMQqhWWFmJi+yNP88VaS6skHGOh0OMpR2ayTyebApb0ySeAgHsgvJ3xqRvHFRckPGgyiT8yG6nmtuyhbf/nvJTzwu+xoorSzaUNpqA5B/RYYoAhjQMeLetMTW247L5eVeto8MZSNvQTiglQH3086iadoE9uP+2V4EEZYzNHEaFjMoWg8Y8LeX/t9T7qW+vhvKHUs0vQFTZVXoCOE1q/Q54C8rO3aBCX2HY+DbxHnizspCXyd2wAt7q05kyOn834mAqd9y60Q1WyzvhZj9r1jwyp1lHT/gUyqKNwrZJn+3yJW1+JNmK8TDv7/FIu9SQBUFjZh8hDJi8mYsGtyFAH/x3fnyMWnPKrexfDLQ8yJa44u/jBMM8Iv8i6eY3Jm9MMGgCVQpDgm35Ph19qJVrQ+gLzGIUyMpqcKBbGwBH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:06:25.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ba209b-cb3a-4e07-6817-08deb70778bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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

Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
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

