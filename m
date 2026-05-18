Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC11BCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 10:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F66810E293;
	Mon, 18 May 2026 10:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lt06PUOj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CFD10E293
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 10:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV0qf9l1rdJo0sic7ACdAARrBZv5kRFpBFxZfJLXjltldIPwO6+dXShFTu7GZqA06UGiOmdQn2p2q2Eh1wx2Lw/7fDu/EDa0CITBrSwD71FvUvn7oPKH9cpLtAMwbbhHAtK9s9TSg1egvvH0LstRFSQOb+HKnxIIVRhbc/vwgvSNELkgPJTrcKwhOLT8jCQQsC9EIguK3/FQQu0cbasxp793DhYD309jzCBnYBmOSlICfS3FykUeUytNAFxH/80b+uurVRKQfmW32sUqlHZiFNAfPvcVAxUbSrvbJswDyT2nohxKDWRlPeNBRbirQBChDCBGNcU2d1PVpeuq9wduOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/kXUhFzzLjEZelohXSG+SwRwymIHPwCoKXz/JdYgoU=;
 b=I2gzjK1gLIqbPp7FwqfehTmY4xeom4ScdyaiueByleCm5uCjA3JUzkA6sx3l0DSMelFAa/iBE4C33cLZ3gbD5NsIyHC+xvDk0MgqwknyXGW1tQumc0JWbPtsGlCuN53HZBJE0PgsG7QwDMGYuidKtdN8ZoUGmeslWYdp3y+l/Pnd21dlyZDbNUBR98QBiZIUv8OQUI1mBKMWdE+R6TgzXwxJ3KL/jKbnqbIpOfs7SJNf6KrisWuFBzdMUQ8RCLoMZuADBgw+PNgDN837R88yfzcr2woTZ9VAhcVpRdk1sS1O+M3+AF2TqS3LDEYLd/E/1TsmdpgSq30Q60r87g/tlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/kXUhFzzLjEZelohXSG+SwRwymIHPwCoKXz/JdYgoU=;
 b=Lt06PUOjk75vRnBWczGZLwrfcxXgGhIW0SpcYdHRPqCRFW3b4S8mil0tHMgnj2IlwXsf0pArAuW5Enj3TZNNCQ1xVSSbF9qlPdyV9EyfxxiUGMa0laplGRlgfnImkOblLVT/RSGdE/FxndX/AbxdGdtQoVNoTio3EdYFhn/6Ctc=
Received: from CY8PR10CA0013.namprd10.prod.outlook.com (2603:10b6:930:4f::11)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 10:15:21 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:930:4f:cafe::49) by CY8PR10CA0013.outlook.office365.com
 (2603:10b6:930:4f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 10:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 10:15:20 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 18 May 2026 05:15:18 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>, Jeevana Muthyala
 <jmuthyal@amd.com>
Subject: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified ring
Date: Mon, 18 May 2026 15:45:09 +0530
Message-ID: <20260518101509.387193-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: a34eac36-c621-4b19-c64f-08deb4c65dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BjxiiyKeuIvxJlvI58B2JsHXdcivyOrkM0oYRG9ZdTUQrGrTWD727Z4rCsy3iobLidU+oNDcuIMh0rghYXniOvH7RIH+FrMaxq1Ryc6TYV6eQ/6y8LEKG3XnOHYh8+Zpi5DE0DZyQqf1Il4xzGxH5d4pGm5xIccsxM3joMmEh8xq6Df0G2TaEAjc+Jk/qEUHSgY396/y4j1GLkZt8zRKHG16b36KvLCbkSfquQGlM8HFkI9Ukz2jYTiwPI+tufipZF8MRBMauQfsyBK75ZhuNT/0eGrpw6QMrfSq1CcZWVPA+5O572eXu5/58jX2wDILTijAPWDmYiUT6iYDA4VsKa+IW+Epi42NRYBLklnTegYy0I1ynSxMxUs8Hg4fUsO4eWNSzKbiM6gnE6icOXcs330gBy+P3G3I3gQ70u3pRsHrGSc6+TNwqtq55eWoWKY/8PXSUVywHgUlBPFak6wjx1LnX/P+5VoTajmr0See2Z+3+oHNOs+pp8UXMxBXCHvsfkeLKbttARRAMuoXTz4VcXcVpdCo12acGDusPxB8dyqjKTxTpkgmwi6yuOlaZ1dzkX614os64KXqSWYqqGblLxS5y/IrlbkzLUroDiKP4JTeZEMKL0EZ2OatUYJoNALkQAujYtExMWLd/BLdlxt0M7vIrVtfkpsHIFlEZpUbTtdHIN8lOuGpsfSLkEI82SAoDnjhb+l2zwZdmsR3Mol9SLWIshyHDIwKhOjGsr+HIf4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nitXHQQ/F7SXSosElaxf5xWvNnVQvOhH4YW9nhGXRNBUHBM2q1nE7XMvdMHVoJCdp70PhdUweVEarehXhd+YfUqVNP4mynUjbtsBLTbOhpPhuBEBaEbmSN8FrLehCY7Qx1VVtuzQrWxwL7ySi/RL5Yg/tU7zZUSAv8H0PKK+SMEZzCHfvETfSvBE05lh3QZKxttxI4l4iX6SSSQW2yCxe4aumEePz9pja7GWmPWMRqoXwBVLcQzoyNCnYcxxnMr0kHmkKc38/kcFlOcS/ASuQGSZ8mm9ukVrB+1K7aPwzIfgYPPX2I6I/b1J5DeeHgdCefgUcHwJF5101m4QsGEuwq6FxatIJZxU1tuO8cSQSwNDNMTpJktEPOoClL1XQYca3aaDjoVzOTVEuXtuKW0mirtEz53ORHmV+i8xcHq2GOYKiR9Qd0IJn8+V4rQXQfsV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:15:20.2101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a34eac36-c621-4b19-c64f-08deb4c65dbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d5f49fa33bee..9b09a79565ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1203,7 +1203,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
+static struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
@@ -1244,12 +1244,15 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
+    
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) >= IP_VERSION(5, 0, 0))
+		vcn_v5_0_0_unified_ring_vm_funcs.secure_submission_supported = true;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
+		adev->vcn.inst[i].ring_enc[0].funcs = (const struct amdgpu_ring_funcs *)&vcn_v5_0_0_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
 	}
 }
-- 
2.43.0

