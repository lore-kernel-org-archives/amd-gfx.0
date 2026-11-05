Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1E606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yyWjanCN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FF210FFC5;
	Thu,  5 Nov 2026 00:05:16 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D26910FFC5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 00:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpg5uNZ1p3Gt6E8/kTauOuOoe4TIUZVJcPhlXQ9x2SPLMDZ9AtTVw4bNn/wW6eeOKTrp6G2ijrkOY+rlOnsZ+7rddC0Pobg4exDY5EOaNDKz4RqO0GQUxjAL9/hWmEWMZ1oy7/c9ZshcSJ1xiHFlIXwm4gWQ6X8n4yiYE0t4mMZhdSb4P9yKeD5xRsjsmbGeRbmCJCds/nJHayV5l2ne7fs6qNOUbGGySPw5ilgE06IVwQyBgt/ljwFFLP9izCkC/gwevW1MxMs7Za/So7ZEnmmweQN9gQhW1vtHvkw4Jyj8kXkvMKLWvk5Bm+3tBAEKWqo2k2VFn4ml3DN75LsI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEuBtw0lWtAE/Armg4tAiNy2wV59b9Xy9/5hKTwqiOQ=;
 b=gpQdL7BuwxOc5C5F3wRxnDQUsORs7U5h/xrmCScrRF6hhX5mR8gToXrXwLBDIf07DymQkjSKZSCvhrZa640T/DQRSnFYjT3j8YV1GHdfP1xWERKX+OQ2nSzfOWy9HSI33N3nnihPeZg9vT6HCrFUeIdrMu/yKXbL5+XiS9C7XfZ3aKzDv45yz2jx3jYUlTuDPX19t7gT3gmd2W9f4f8a2g36Kn4I/HXoQHjV9TrdYvku/9eIrUiu5rkWcc25s2/sftudG3mysWD8XIzn/KrUg6KkpjayUJM7hXO6/Dh44QAeovDzLlVlso+AAx5BsbMpnefUJnAXSAW7LXhzYy1mAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEuBtw0lWtAE/Armg4tAiNy2wV59b9Xy9/5hKTwqiOQ=;
 b=yyWjanCNSp8K5Xhg1CG92icxdczmUF6UEl6b+YSPHxDTkv9w7cDGeiuRbaqsbADWvC6bHjLUApE0uyoACwOl9eL3NBdfhVG1JkloCllyutTSHUGsk/gvQiWrYdVk+VCQRrY8CS00jcSeFERjvLBeyw2bpiCezIaQcmqDRnAlqbA=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 00:04:50 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::47) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 00:04:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 00:04:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 18:04:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <frank.min@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Tong Liu01 <Tong.Liu01@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: use SMN C2PMSG registers for PSP ring control
 on VF
Date: Wed, 4 Nov 2026 19:04:41 -0500
Message-ID: <20261105000441.3850131-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105000441.3850131-1-alexander.deucher@amd.com>
References: <20261105000441.3850131-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f28362-77d2-440a-d3ef-08df3ad06947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: AjjX2NYUIroTu7Owss1Twla1FlU/BME1289+PkCC00Rn/CmLFyGtVI+hdT/WpochhsJbwBy4IO2eMMZnFlgYdm3njEduqAAfYrSgthb806xo8CeNlt9pW999XZaH5LokrzfWuZ39sXCWIGsrvsiyPz8uGZaxrkf2eGdmbVSOeWvyfhVQtc9IcoaDMNXJAPbaprWUkRBFHgY+yjotmbAyjB3Ezh/pV9YE4SsZHegz0wQ8pAeEOQSsBk3br0Ogsc8uHlziCJgfQRYeXegWigYY5faOThBg5UHfzhEBItMAQVGltlT6b4nE77W+Zwct6rZvVtz06PIMq+chvLQVPjV96Op2+uabkdxd6P8lW6LXnL5AGpFzsHjYWsqkD/HP8oTvb3+aeuqvmIUz+PU87oj/7R2/o7ZkbsHvU/13u7ONjeLpi7BJ9OkC1UPQyH+/RyUmA0QfvMbczPxoU0QGpPTsGgzmQEACiEzY0pmkDezw1Y15ZleGzU5kWrUmD7t2uFi0hIGWnAdXca1SQQ4RdM1rNl5JyTBNQl7NVCAsuUpJXhxNh5fmuVa1Or1+IADyT6HGfgOAv/B52lStyJOnXcxGzfJBynFjObXR0X73jl/4pdGH0b9k6jqamUme32yaEX1yG8irlUE/1QuEPsb1I64KtQiUTeCs3S4OjgVccz0A5LyBQPP5frLbrfsg1TYs3RiSVGi1+GQFEKzdaocVIuHJmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /R1TKdQzeEmq1PgvgXvi7LaXmjbHDY4kc4FGs07Tn4R0bjT5dojTm9JFuPG5/lA8OwhnWZBN8d/73aH6Q6cXVLQ8KdEisG8t+hTLfW1QYvKs+ZPHA1KUe43m7mH/Cld4M1/JD9CiVI9HP1HqMoOX0XqU5BZ4dHLWg/i6OaPDchXQlw0UvXoZqi98v7EitEDhjL4sqfmf81XncxbA2teG5l4MsloJQFDeerd8eL+sZsf6WpuQd4iRiaQVvAFhZrHnDQWjDekNn83mp6SBrrdzPyTH+LPb/u5KM+V6ePH3aoACKGWld8ldc+16hr4XCM9wDK9aBuhwD0lfhMujmtJnj/cxZongVjtkxyhItF0AiuD4EHHGxMg2WrV0xwCFeA6tjM4w+2JttFehyi5NiVGiNzuIrjHdiUec6CApyw9f32BftWdIw9Kqx+GVs2yfFXQ0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:04:50.2795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f28362-77d2-440a-d3ef-08df3ad06947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

From: Tong Liu01 <Tong.Liu01@amd.com>

Use SMN C2PMSG registers for PSP ring control instead of CRU0. This
allows VF mailbox access through BAR-mapped registers rather than
indirect SMN access only.

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c       | 18 +++++++++---------
 .../amd/include/asic_reg/mp/mp_15_0_3_offset.h |  6 ++++++
 .../include/asic_reg/mp/mp_15_0_3_sh_mask.h    |  9 +++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index b5202aee40354..ff3a25e270c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -220,11 +220,11 @@ static int psp_v15_0_3_ring_stop(struct psp_context *psp,
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* Write the ring destroy command*/
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101, GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
 				   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	} else {
 		/* Write the ring destroy command*/
@@ -257,19 +257,19 @@ static int psp_v15_0_3_ring_create(struct psp_context *psp,
 
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, psp_ring_reg);
 		/* Write high address of the ring to C2PMSG_103 */
 		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_103, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_103, psp_ring_reg);
 
 		/* Write the ring initialization command to C2PMSG_101 */
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101, GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
 
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
 				   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	} else {
@@ -347,7 +347,7 @@ static uint32_t psp_v15_0_3_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102);
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
 	else
 		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67);
 
@@ -359,8 +359,8 @@ static void psp_v15_0_3_ring_set_wptr(struct psp_context *psp, uint32_t value)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102, value);
-		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101,
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
 			     GFX_CTRL_CMD_ID_CONSUME_CMD);
 	} else
 		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67, value);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
index af10df3395dc3..84ac41f653e6f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
@@ -1088,6 +1088,12 @@
 
 // addressBlock: mp_SmuMpASP_SmnDec
 // base address: 0x0
+#define regMPASP_SMN_C2PMSG_101                                                                         0x00a5
+#define regMPASP_SMN_C2PMSG_101_BASE_IDX                                                                0
+#define regMPASP_SMN_C2PMSG_102                                                                         0x00a6
+#define regMPASP_SMN_C2PMSG_102_BASE_IDX                                                                0
+#define regMPASP_SMN_C2PMSG_103                                                                         0x00a7
+#define regMPASP_SMN_C2PMSG_103_BASE_IDX                                                                0
 #define regMPASP_SMN_IH_CREDIT                                                                          0x0140
 #define regMPASP_SMN_IH_CREDIT_BASE_IDX                                                                 0
 #define regMPASP_SMN_IH_SW_INT                                                                          0x0141
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h
index b76207930514c..95fc3e89ce6f9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h
@@ -1618,6 +1618,15 @@
 
 
 // addressBlock: mp_SmuMpASP_SmnDec
+//MPASP_SMN_C2PMSG_101
+#define MPASP_SMN_C2PMSG_101__CONTENT__SHIFT                                                                  0x0
+#define MPASP_SMN_C2PMSG_101__CONTENT_MASK                                                                    0xFFFFFFFFL
+//MPASP_SMN_C2PMSG_102
+#define MPASP_SMN_C2PMSG_102__CONTENT__SHIFT                                                                  0x0
+#define MPASP_SMN_C2PMSG_102__CONTENT_MASK                                                                    0xFFFFFFFFL
+//MPASP_SMN_C2PMSG_103
+#define MPASP_SMN_C2PMSG_103__CONTENT__SHIFT                                                                  0x0
+#define MPASP_SMN_C2PMSG_103__CONTENT_MASK                                                                    0xFFFFFFFFL
 //MPASP_SMN_IH_CREDIT
 #define MPASP_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                              0x0
 #define MPASP_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                 0x10
-- 
2.56.0

