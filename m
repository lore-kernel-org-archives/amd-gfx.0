Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDE8CD4F5E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 08:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE4910F236;
	Thu, 21 May 2026 08:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lQQwQfOc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC5510F236
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 08:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsmBLdbsp92clFWbKROvQDR8vN+Kqmn4GSkUBFTl13nZirY7HPbr8mil8SbM8qH7jRx9morx0atq0jOB7OcbJtbfEGVj11Oy3hgWV7pH3/ipcBXpHSJ4AW0H+lJ5pqQX26rKTZbvkbqeKR4hrh7bSxDiGlhG3OI9zb7NcSHCA4tzV+8tSqesC1HJUDVaxg9kUKTlOPLzh9hdMSz4CKxbQn/X164fWpPLmKCv1LPJPE+S10cKGrFzHvhxrb492W4qf6Vu92HFFI5SHDR1j0eICsD1SXIqINIqJTa2xiE7Khf3TPfmi7mavoqzqrqDY69GcqcBe6UjPXiQegyZ3odPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjT09mN89Ob5DqjaPu8jafGuXItbRU/Ooov9kqM6BHk=;
 b=s+XEE+9Gz4+ClynN1spmttbNNfP4A6AxXnQnWVkVyefOosmCOBXQDXXW0NcmpLHaR4wrxofioWU/0hxXju3opaJWz29CfQByDUvf+bIVTwjc2SkwVnC0BXVJp8JZi3xT9+cWeDQUZXCvBlssZG+qzcujuex8y3aDCf3Nga27v4KCCpP/zJ551wcDENMDWNLsjHVLiH74MTiAghTm+BA9amrUKWfdVw9es8at0IDkl1Admf/tKwJsRVhBosrEXdht4hJ7PTk4F2unGZ2Ocif97NjefzBXHd7Wi5W7E5/wi5cvNsk6+1GkTmah8wx8bKOEdDx84j3K5u3CFUzvYQtFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjT09mN89Ob5DqjaPu8jafGuXItbRU/Ooov9kqM6BHk=;
 b=lQQwQfOcHmgHOyfjYuVP4VurTHxlF2Z48i+rCNZiOWaVI8zaAyn7hHQjkXQRWkP7TKA9RCdE3XebtxPxZ+M+VtWg4f8V2kveJScUQQlarJmMMlsbOIklYCLlWwNeT8xL7I6LETxLa3etNlGe635xNu3hxFs2ceBPrqkxStMnkQI=
Received: from DSSP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::11) by
 SA5PPF6407DD448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ce)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 21 May
 2026 08:00:57 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:8:3d3:cafe::8) by DSSP220CA0001.outlook.office365.com
 (2603:10b6:8:3d3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 21 May 2026 08:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 08:00:55 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 21 May 2026 03:00:54 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <jmuthyal@amd.com>
Subject: [PATCH] drm/amdgpu/vcn_v4_0.c: enable secure submission on unified
 ring
Date: Thu, 21 May 2026 13:30:45 +0530
Message-ID: <20260521080045.4055360-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: cccce044-8131-44c9-e2e1-08deb70f164f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: cbDeM47zHMWRLNuIhbONotoTXJ8uNtdU73LngE0L5RDnRLPGRvSzE8Rbvmf3n1O36BLW7k7NnfY5wLHSngPbvpCVgEWaMix/l7Bmlsb1hZrmpLZpve7TtAMczkudyv+OUSrDmHWMlVpj0LyfLiGpA+2SYYW/VlNqNSY7YdRo0jz8ROGpMDqssdcNgHkQLP6MPYOSoj/R/O+PkiDGIP9XXepCpIx0+50nnXgPK4WT7DI+DZpt7M9hNOkVk2zg72p2utLvCxA0y6pTrqhYV85ROJDMqnVhsMvdNB5tQpMHqxZgnKVhvVhzjs/I6z5YKe2cmFQEl0tUTHYAmssmT632syznUMeKamFHFAVAyK/e1GW4eG9Ukl3eMwcQSGSh83LIMCzA0uJoT+uH4iSeDM3hetj2w2PUm3y27h2Kp+tbMtwECY33Zdn1qJN5kOScSyiaTASPevLn6zHzuGn91dCToy5aKr67CRergT0ExIZzfNOdiHE3drX1u2f3I1ZzarbvvQSnuX4gH4vObBwvTPlVhfRooZJcfDaapRZqrlNG8bVZpfo8JnQ6dac93SwtyOYt2t92GvmoWEGAfZ+IpzeyxAqVmLDCoSUZISMNYolxcOrUWxJfjV3OF5cZbSvZXUBYghsRw6jVn2Nuza+st6Ekb55IXQWix1dTH1ZGJiY6172xkQsm30lZnQpzdEmzXdYu8xeMVD/RM16zB4bzAOSllh193xX42c8/R4NfVklcDpk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9rPN7tV9atix71qrd2pzXpwuKliIWlyDz/V1ZzDoYM8c10nBbgx+OXmTS6GHe2aD+yGU6KXOqj1HolWePjBvxX+161tBqwuSyA8VLD1zidiFJ9MlXwRbpJi5q6z9IZ/M6dubF2MWYdwLYYqp6QuR9zjyAIbm+5wpoBaOd3G/5jWiaDrBJX1X/uVDBU+ljPT8YD2LZxmzaxwYJ5MGEGb2uz1qJox1xIyVQq/GVIGc/ffagGA1oyQl39xvrBjurohPqaLxyzycMuKjERjwDpsCv5RvjNoCzwJvdWLF5ltHS9pub9j6O9mQqOZ+2FekL5S/mw9zU7tPIfoK4SHmP7W991+U+PGGNWaH9Jg+sIZIeWuq96W2/GjwtNWrfH9rHh7IEAXbfs17KUW4eVFNkTnO0INHMZNjB7FzyuwVypDKi02Auqpl4L9VgYh0zZS/Hgw8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:00:55.9467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccce044-8131-44c9-e2e1-08deb70f164f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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

Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 43 +++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff7269bafae8..bc623e3eb68d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1992,7 +1992,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
+static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
@@ -2025,6 +2025,40 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.reset = vcn_v4_0_ring_reset,
 };
 
+static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs_secure = {
+	.type = AMDGPU_RING_TYPE_VCN_ENC,
+	.align_mask = 0x3f,
+	.nop = VCN_ENC_CMD_NO_OP,
+	.secure_submission_supported = true,
+	.no_user_fence = true,
+	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
+	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
+	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
+	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
+	.patch_cs_in_place = vcn_v4_0_ring_patch_cs_in_place,
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
+	.reset = vcn_v4_0_ring_reset,
+};
+
 /**
  * vcn_v4_0_set_unified_ring_funcs - set unified ring functions
  *
@@ -2041,10 +2075,9 @@ static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 			continue;
 
 		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
-			vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
-
-		adev->vcn.inst[i].ring_enc[0].funcs =
-		       (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
+		   adev->vcn.inst[i].ring_enc[0].funcs = (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs_secure;
+		else
+		   adev->vcn.inst[i].ring_enc[0].funcs = (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
 	}
 }
-- 
2.43.0

