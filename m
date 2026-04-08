Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC641073CBE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C254410E66C;
	Wed,  8 Apr 2026 13:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lnt7jrmH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E30A10E66A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0czMuZ9xg4enz0ARZv7jRpZO+R1L+nhhKPcRKFlY2TlfUbD3FIvM/FEQH0O1m/N1Ez6oEXifZCfcgdQqDPAutjqkMNQ9NRtGN9/GIvBXV3XGc4Or07sOfCluKSunV/SuzS9QEtZmpgH6nE1wxuVo5/ZYxd5/F0BB6Fr+h2G2yf2hlJgfWuRF2rhN0bX4FwCfxkPZFu5Ow44ZnHUqIuyK46Z7Cc9hwMd80FrXOivHD3PjR6V+Ci+p1WLfYHWYGRreO0o8qIIUFSHpVSm8hcS0IJ/EghGyKTppuYiR6kFefpRtH1yelc6VflmbJ66z622vaChQOHjCkqnQ7yIWRuDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x17LaWXtky4B7T+xXJGXnELeP8fzhWF+XiXcHjNS088=;
 b=DYqcHsOk5pvz3C/4pLNA+ll0+Fuj8LTBV/jtTPXve0dztZfCIb/PFPVlRa9cgJxIGa97KVq+5bgzsoR7DAVv9V0IHCI1FZrRQ3PKm0teqlB8X4mGZRs2Tn2ZM3Af7YqDWcg3Vx1iqfcgwpzYqEnbBVgcUQTzsz1I4xTy5ublXriBIs5oUJZmxWlAOsSZMEhJNGEBTIVurhaR9DVZHydkKg+guhLOMcBjvfg5u9L+vG9PgarjlCHUjGCIBtpp2JFJym41iCNikKVpK3aCZX4GOtZrvNHlfqLLBp3Ij4i2e119D5BmMgS72NH24GaF6Z2TNsIO5TeXTD4GkfohOs+gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x17LaWXtky4B7T+xXJGXnELeP8fzhWF+XiXcHjNS088=;
 b=Lnt7jrmHtRQVmk8hmmqCSYBvpJxu9HAKAtzwCRBbmQOuVGD9Yz4ydeuNNB5rbockbJ4uIcxOd95FLgGeG+gFk51tilO2Zp7hcT6O3KYfZk+OiyCmHS0HZNP+z/gsuTUIkZFrVa8GjzXepo/qT2PJ7De0yQaHRtwIImoZNLixmh4=
Received: from MN0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:52c::25)
 by DS4PR12MB999078.namprd12.prod.outlook.com (2603:10b6:8:2fd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 13:51:14 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::89) by MN0PR05CA0014.outlook.office365.com
 (2603:10b6:208:52c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 13:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 13:51:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 08:51:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 06:51:13 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 08:51:12 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v4 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h
Date: Wed, 8 Apr 2026 09:50:55 -0400
Message-ID: <20260408135057.2133928-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DS4PR12MB999078:EE_
X-MS-Office365-Filtering-Correlation-Id: 87817de1-063b-4c8c-a5eb-08de9575e654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Q0m6Y/D5jPluCIWXjhSXPYd+qsHtfqUN/GYpYpwDoMvPCTJXpFnGTqsZ1xm+P+lVwEkbISiEqbYFtYzCIfVOWu+dqe1jRUBpeFlP6o62NO+26jh9aTsuXb+Rjo6d4OXRjkIlepr93atw1gGK5182EKUuI9y61g5XZUxTOTl3dxYjqxv63UT0NYcV8x9uUabLrZKnmdTuBErhHQrJfdaDdjBMffy+C/n4KqVPk3nr5ShlO4jwZqMrB6fmXq1gLPTd69a4LHkH0HqlnKP4FrgYqT0CeI8CDL3OB3FVBSV11zY+jYRQP1JMCnO4+/05obbHRyZbXryxcdla/WDgFU5OHjFu9PTYetFRQucQmB7K8FfwzNizofwC1aoxFBg7fsGgzri3Lsr11NDRK/cl9v/cprQ0uAPUO5zvxWLRdIY6eWnGxIpg/IaIbhQcPhBqmHddZw7CLMQiNu5moObQp6ruUK+g1iX20WUQLnLRz1dZ9MIHzrwO2kTZ+JwxAj7jGg4qRCv9hTLhLBnDs0sKRpFkSmVEytY9P6Vk0grhs0M68yn8MXmmst28IeSfRYOCCYtagoQnFoges+1xlcDjtpCIDV/7gT9odh1Dpk5xOHTdngL+jlwnK9LH95TyUs+1kWJV4qtUnN0eI8tAl/JfAfHgNUEmVugyHYfJJzd45Nf2pQOh9xxtJCbvVivxRsU81KiPjMT19T+qEuXmBVhuYvCBVAy6CVvC2DQyS70nuejO+qKLmTwVGtwoAOkq0vHARDNvY/UFv1JCsC184Yxx2033XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kA9T8+C1yjBSB4Wd/yHoFxOi6E9N3Qg/EQjqFvGOeVHk4qJKkN83zr7k4O2YW5fRPOWFDUeuS1y2gAgKNh6/gE2EJt2X4mUSMHH1JJvlmUJrzMcIuiD3Hf2L5dxNeU1Alf3vmd7/AO2XbOWUsgbWCUen4WMhaRp9JxbmDJHQ8r1ym0XYHq39ftcs2PqMMXKtcgWoY/HDqwjE+7Bb3d8tSoSt2KycWvJyg+/0Hb3eUxLxNvdFwvMzFzIg9tCuZfNCF5jJZePaa2Z9UkbbaT2lckH7BcsxTguWrppDwfS7vSt0zLbDRYsnq/dnlik+HXXrNPI2OMBqtQnezoCqfEEhFYcKpnEde0ia5VQWXeoNhFh+XFgPb/6DPmXh0BHrtvjOcT6/Uh7oGTGUahnfBTw+8taCEOSlVerHyHZL5jwpkDATJiaMbvYuJ/lz5Y5Ojeaw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:51:14.0787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87817de1-063b-4c8c-a5eb-08de9575e654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999078
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

These defines can be shared. Move them and prefix with VCN_DEC_ instead.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
v4: Document where {MSG,MESSAGE}_CREATE are used.

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ---
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 82624b44e661..71a098d1eb8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -57,6 +57,9 @@
 #define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
 #define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
 
+#define VCN_DEC_MSG_CREATE		0x00000000	/* msg_type (in message header) */
+#define VCN_DEC_MESSAGE_CREATE		0x00000001	/* message_id (in message index) */
+
 #define VCN_ENC_CMD_NO_OP		0x00000000
 #define VCN_ENC_CMD_END 		0x00000001
 #define VCN_ENC_CMD_IB			0x00000002
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6fb4fcdbba4f..64531ad56c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -58,9 +58,6 @@
 #define VCN_INSTANCES_SIENNA_CICHLID				2
 #define DEC_SW_RING_ENABLED					FALSE
 
-#define RDECODE_MSG_CREATE					0x00000000
-#define RDECODE_MESSAGE_CREATE					0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
@@ -1957,7 +1954,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		goto out;
 	}
 
-	if (msg[3] != RDECODE_MSG_CREATE)
+	if (msg[3] != VCN_DEC_MSG_CREATE)
 		goto out;
 
 	len_dw = msg[1] / 4;
@@ -1973,7 +1970,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
+		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
 			continue;
 
 		offset = msg[1];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5dec92691f73..a89e316a4add 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -50,9 +50,6 @@
 
 #define VCN_HARVEST_MMSCH								0
 
-#define RDECODE_MSG_CREATE							0x00000000
-#define RDECODE_MESSAGE_CREATE							0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
@@ -1874,7 +1871,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		goto out;
 	}
 
-	if (msg[3] != RDECODE_MSG_CREATE)
+	if (msg[3] != VCN_DEC_MSG_CREATE)
 		goto out;
 
 	len_dw = msg[1] / 4;
@@ -1890,7 +1887,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
+		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
 			continue;
 
 		offset = msg[1];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1f6a22983c0d..cbbc02d68695 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -50,9 +50,6 @@
 
 #define VCN_HARVEST_MMSCH							0
 
-#define RDECODE_MSG_CREATE							0x00000000
-#define RDECODE_MESSAGE_CREATE						0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
-- 
2.53.0

