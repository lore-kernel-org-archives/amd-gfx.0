Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008DCD3748C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868A410E834;
	Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KtjTj5YG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642C210E828
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIHFQO96qpqKeptIqQK4RX5fHwbCI91W6GiblPekerMdDzE5fUCLlvOtAk2EqEsfVpOwuPC/UYfx2uMa3xlg5lSNZDxJs+gPxEbIRzgt3AIVb9/Wx9Ao3C1mT2BoEUGUc+3BQAZIpjNeew48nFsGQ0Yl+VyNv0r8OsgVlLqjAfDhLhMmLG86NAb/bAeynQX0PbaLdhBPOuTE3XrRy+eZqQ93GPQ3JzkaVKEt/glum0eJAL7LQLjOE/nnbMlPssZ39w3la+Kn+0RMtn+/Wwo4VVr2laqyCVobeItFpexz+zYUJCX4jCYDaMYgZS1vUMxZSLI7ftQwrngIeXZ8+xKNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KCB8gXGK0POItLjW6YAirN1KLwLE/QfGGJT+ffoq1M=;
 b=qxyOJ/YS9duAG3gdqz82/aLKjb4FuE0MEACuAuCUfvB6C1EXsXR/1abEz2s6JHxvpFoybeLd+6CsqbOltX5Fdthgp2FPNKSnWrtJIh5XuM+TLMGt4dhHryrnS6eCn5tNaLt3jTgexrKpuB/9pWokg751RvgYUNejLxwkDcTqMK3D9UC37I11yEiXUngF1szGXje1/QydXIw9A78mqbePxt758BHGvQX5KVtsXMh10Qkys7iUs6vvo2Hksxn5wwd1uIwK//t5rwi/6A9toP2D6ONkU/67LQ125oi0+yj8/q2zRD68KECTuq055cu7zbyvt7yxZeIwJT/vF4kWcHFSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KCB8gXGK0POItLjW6YAirN1KLwLE/QfGGJT+ffoq1M=;
 b=KtjTj5YGPuQBCQN0NiYIrn90PGNcdayDjRlcG721OlYqKAzVTP7lafP9iP5dNhvU+r/5Xwmc6zK3FIQo8APLGBvVdCsXONEPHZ3enMg20tlwt16eh4NdOSbknNXrZjltzemckUwRQkJB/TbhkA9gFtUPaWvez8OT+s/0FqP0Md0=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 13:21:34 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::c6) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:32 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 27/32] drm/amdgpu: set funcs for each vcn instance
Date: Thu, 17 Oct 2024 09:20:48 -0400
Message-ID: <20241017132053.53214-28-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 737ac778-caa9-4ac5-a094-08dceeae9ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b/10kyiCTNg2hRq6vQmkUtuOfDYR4TkzaWONSrra/5FIu8p8bCINZo+gislN?=
 =?us-ascii?Q?42U1QIzenDyLx8n6g2+rOONO4Wiy94h2TozrcOoX3Es0h7GXC+2Pmhdc1jQp?=
 =?us-ascii?Q?xqApra5jgxhWVBLIKKL3c/L94salxOgSSdPiQsTV1a6dkL0F1B4Sengs7roK?=
 =?us-ascii?Q?qVhTRE5xygwFo53OUVPMJ0wknwOw0MZqsu4Ab14J3XBhU/NsVoniOHYFyk8N?=
 =?us-ascii?Q?VJOOGb/yOVkrUw/ossebfezE0E7UHyDiZl00kC8dtxs88q6k172tOlvgnzvx?=
 =?us-ascii?Q?yCP5xx3B5qz5nBkmHWHE1ltVFygFakNSv/FyfZZNf9Xv2+vA6fJH0kWtsh2E?=
 =?us-ascii?Q?3pplsjUC6KMsPWLyZHUP6eCUX46D6rtilkiD5B5dZ7k1weAwrl2RXbSO7Gub?=
 =?us-ascii?Q?Zh/UKPt8PB0MnPj5HPRfdyvemqRlcsGKX3/2VrhA2+CN5iDk2DS2mKgXJY1x?=
 =?us-ascii?Q?SGZRlrf8R00wK2S8bK9Lah/xE/MqBO/9PJlYJwLSItTbAcKo4wwTpn0pp1mZ?=
 =?us-ascii?Q?Qeb5rnCidpL7I9Xlyp0DTCdoa9ebPVZlYPWwHXtZmMdNd4oyXgwziiUHe9gH?=
 =?us-ascii?Q?yN68JZ0o4BbGcqck9Ya5VvFLDfMTL5Cm9CAOz08zXV8+Hjgn9Ux/J0IdNf8V?=
 =?us-ascii?Q?YnhQPGYHFRWY5UhKF75nvSZpwTaBRie4Ci504ctuSNmXAgqUTNocD8TJrxHC?=
 =?us-ascii?Q?D1do5efzNzxFDeIAGAMPpq1xH/neaIpW7GlmRxboUHIZBA9AM2RvMNVZ+JNG?=
 =?us-ascii?Q?6tta/hCpr+tidxJk3Gl8wSWA++wdF4YLMMozuSbYW1lsXtPzfw+QsgZOno4o?=
 =?us-ascii?Q?R/yrylwdeQ8ZrtGG9M0HtmUzgmV9/yK3LSDdOtav+NLQIfVAiGowec7sSITq?=
 =?us-ascii?Q?OkOSflMVVXRzUV2jBVgsCiQwYI9Pg2zKtIHNCIL05MV+s44Sw15rvO+Qqs9o?=
 =?us-ascii?Q?AOoOruw9nXAMM5Ky3TCLnFWQcD0giJQqCUyS9kmQWj5+rkox4ZcZZZo4Nr32?=
 =?us-ascii?Q?xss1ubXaBJ/UsFYQuIIPkMjqy7hbUZYeVjc6lAeZwMFGrqoFZC24ID2vhEd1?=
 =?us-ascii?Q?bPn0ypN2hZbiEKWb20IFQ0GD+ZNJV1fiA020rdXYaqekD4++e94QW1BbgyuM?=
 =?us-ascii?Q?/oK2FwKAPVUCFNm/1h9ohZ/3ALlDo7AoO8iNhmYXKBj7d6B0YalM+yRCpg+8?=
 =?us-ascii?Q?gX8Tep7soUW+Z079wZQzxXuNRJUo+qcHIJCBcNowXUyfrssiODR83svLyvPL?=
 =?us-ascii?Q?Gq4QEUPQ296JOw88RECprduTKFFYltXCEm8L4Hwu1Q2qGh3EYULeI97Xe4f6?=
 =?us-ascii?Q?fxkHzNooEvdhXkdIfPsStLftVQOGzBeKaFe1cpOAvWtEkwT+W9w5XfeL95aR?=
 =?us-ascii?Q?9WS2aoZ8qYSoyLbAkrTr6/wbUCcArjSIXaew37nc2xHT0Q2j3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:33.5008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 737ac778-caa9-4ac5-a094-08dceeae9ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to set_dec_ring_funcs(), set_enc_ring_funcs(),
and set_irq_funcs(), and perform function setup ONLY for the given vcn
instance, instead of for all vcn instances. Modify each vcn generation
accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 59 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 62 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 46 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 31 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 36 ++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 36 ++++++--------
 6 files changed, 112 insertions(+), 158 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d90aa2a9f94e..b0d14330722b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -92,9 +92,9 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
 };
 
-static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
@@ -139,9 +139,9 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.num_enc_rings = 2;
 	}
 
-	vcn_v2_5_set_dec_ring_funcs(adev);
-	vcn_v2_5_set_enc_ring_funcs(adev);
-	vcn_v2_5_set_irq_funcs(adev);
+	vcn_v2_5_set_dec_ring_funcs(adev, inst);
+	vcn_v2_5_set_enc_ring_funcs(adev, inst);
+	vcn_v2_5_set_irq_funcs(adev, inst);
 	vcn_v2_5_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1737,29 +1737,25 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
-	}
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_dec.me = inst;
 }
 
-static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
+	int i;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
-			adev->vcn.inst[j].ring_enc[i].me = j;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		adev->vcn.inst[inst].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_enc[i].me = inst;
 	}
 }
 
@@ -1904,19 +1900,16 @@ static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs = {
 	.process = amdgpu_vcn_process_poison_irq,
 };
 
-static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v2_5_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
-	}
+	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
 }
 
 static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3547798ec335..9a9acec4c4ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -102,9 +102,9 @@ static int amdgpu_ih_clientid_vcns[] = {
 };
 
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
-static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -144,9 +144,9 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.num_enc_rings = 2;
 	}
 
-	vcn_v3_0_set_dec_ring_funcs(adev);
-	vcn_v3_0_set_enc_ring_funcs(adev);
-	vcn_v3_0_set_irq_funcs(adev);
+	vcn_v3_0_set_dec_ring_funcs(adev, inst);
+	vcn_v3_0_set_enc_ring_funcs(adev, inst);
+	vcn_v3_0_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -2062,34 +2062,28 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		if (!DEC_SW_RING_ENABLED)
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
-		else
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
-	}
+	if (!DEC_SW_RING_ENABLED)
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
+	else
+		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_dec.me = inst;
 }
 
-static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
-			adev->vcn.inst[i].ring_enc[j].me = i;
-		}
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		adev->vcn.inst[inst].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
+		adev->vcn.inst[inst].ring_enc[j].me = inst;
 	}
 }
 
@@ -2231,17 +2225,13 @@ static const struct amdgpu_irq_src_funcs vcn_v3_0_irq_funcs = {
 	.process = vcn_v3_0_process_interrupt,
 };
 
-static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v3_0_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v3_0_irq_funcs;
 }
 
 static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9d4a0a0b9..ff256fb4d054 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -94,8 +94,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 };
 
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
-static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
         enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -127,8 +127,8 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v4_0_set_unified_ring_funcs(adev);
-	vcn_v4_0_set_irq_funcs(adev);
+	vcn_v4_0_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_set_irq_funcs(adev, inst);
 	vcn_v4_0_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1923,21 +1923,17 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
-			vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
+		vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
 
-		adev->vcn.inst[i].ring_enc[0].funcs =
-		       (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs =
+		   (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -2135,20 +2131,16 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
-	}
+	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
 }
 
 static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index f78c006aec27..544c96e082b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -85,8 +85,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 		(offset & 0x1FFFF)
 
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
-static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
@@ -110,8 +110,8 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v4_0_3_set_unified_ring_funcs(adev);
-	vcn_v4_0_3_set_irq_funcs(adev);
+	vcn_v4_0_3_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_3_set_irq_funcs(adev, inst);
 	vcn_v4_0_3_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev, inst);
@@ -1525,17 +1525,15 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i, vcn_inst;
+	int vcn_inst;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-		vcn_inst = GET_INST(VCN, i);
-		adev->vcn.inst[i].aid_id =
-			vcn_inst / adev->vcn.num_inst_per_aid;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
+	vcn_inst = GET_INST(VCN, inst);
+	adev->vcn.inst[inst].aid_id =
+		vcn_inst / adev->vcn.num_inst_per_aid;
 }
 
 /**
@@ -1718,13 +1716,10 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
+	adev->vcn.inst->irq.num_types++;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		adev->vcn.inst->irq.num_types++;
-	}
 	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 31f05f377ffe..880353f75296 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -93,8 +93,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
@@ -116,8 +116,8 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
-	vcn_v4_0_5_set_unified_ring_funcs(adev);
-	vcn_v4_0_5_set_irq_funcs(adev);
+	vcn_v4_0_5_set_unified_ring_funcs(adev, inst);
+	vcn_v4_0_5_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -1424,17 +1424,13 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -1599,17 +1595,13 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_5_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_5_irq_funcs;
 }
 
 static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c0746684eea4..a4d1b9a086b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -76,8 +76,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
@@ -100,8 +100,8 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
-	vcn_v5_0_0_set_unified_ring_funcs(adev);
-	vcn_v5_0_0_set_irq_funcs(adev);
+	vcn_v5_0_0_set_unified_ring_funcs(adev, inst);
+	vcn_v5_0_0_set_irq_funcs(adev, inst);
 
 	return amdgpu_vcn_early_init(adev, inst);
 }
@@ -1151,17 +1151,13 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
  *
  * Set unified ring functions
  */
-static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
-		adev->vcn.inst[i].ring_enc[0].me = i;
-	}
+	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
+	adev->vcn.inst[inst].ring_enc[0].me = inst;
 }
 
 /**
@@ -1326,17 +1322,13 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
  *
  * Set VCN block interrupt irq functions
  */
-static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	int i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
-		adev->vcn.inst[i].irq.funcs = &vcn_v5_0_0_irq_funcs;
-	}
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v5_0_0_irq_funcs;
 }
 
 static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.34.1

