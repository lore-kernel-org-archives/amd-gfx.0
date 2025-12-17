Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B9AD65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5096010ECCC;
	Wed, 17 Dec 2025 13:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uhgll164";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD74C10ECCC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRrSBhd/OEZD96FApHQY4wW7c1lwOIthGOkKZGWb/1ki0XPSgq+qNMcUPKS4XEpp2GU9Cbf9RQGv6r1m6OLfA3nQxtZSfT+Xu5mjb4GfRaP1RsM9xR5gG7AsphylB41E8tYpHLNeIMfeQF0WXO+cF1lK32Tn2nWLO8CnjGyeWvkOEx9Lyf9Gv7eYqwNcJ7NAlFd3tXK1bIiqKv5pB79/DkLktMh0S0QF0KHoGb+pJSBH7M2HL60/96BhQXKrRyS1Ym28VerqKa+REOSRx0jJZeY0OUlCv4LIP/xZnnrdPxq+qLhMY80K2so9MZJSlf7jIB4/shs2yJw7jx42RPPYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5DsAYE2RK2nOfzkHYL73/VyJl8/0rCrhTnLgILygNU=;
 b=QJNQeVAh62lpNlSYCfr3nb69xZkN5tAiig5LCHR0kJT9dPm3lCDlwrZLkm/HykIiPs+Z1lxkVNcuo8dC3n+UKwjPqerZ0Q1IsgEiklFOOQsQg8IqWpuZH7YIQKsVXYFLx/0iITsvF50yNNA8fyiH0DggzdCRfPFLYToFGKiLwWhYEipwz4wZGgIOJdO2rnHZi/PWkUS8pqpRumLh8iIDZIXaQvLUnGfyND+UQvUPb5fsDgMF1wDXxspfyOgz0dI/d6QRWcv6Muuh82A+lHFTTKfFjoe8IrmkFiKYQNLACyo1KhOngNjHZTMm4XjINslA13SWZOJfrnXiSn30HYPXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5DsAYE2RK2nOfzkHYL73/VyJl8/0rCrhTnLgILygNU=;
 b=uhgll164TAqxBHy1cSt/aBXZ8mrlNBOp/EFTKA3b/sq47d3115txNcEgTfOZMqoME48qL4z7lcTc/8vqJP4DQgyGFghClKkGpsuUQLcdha8dsAsFEfJptRyfpdhqAtyTmldLlX2PMbT4tc9XZ53j6+36rDCvt9rTwmhMfyXKNVU=
Received: from CH2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:52::14)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:54:56 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::8b) by CH2PR04CA0004.outlook.office365.com
 (2603:10b6:610:52::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:54:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:54:54 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 02/21] drm/amd/pm: Add message control for SMUv11
Date: Wed, 17 Dec 2025 19:17:55 +0530
Message-ID: <20251217135431.2943441-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 220b1935-890a-4043-99fd-08de3d73dc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3dULVDmubzO8G0gt4QmzwaYVFLKm181ORwBNCSB4LYX7MxdM2UgIIisiciDH?=
 =?us-ascii?Q?pUv8iI4p+6AgBSgpqu0sWmosYt5q8nvCXHzNxrQHaSNLk5VCJQJIn0XYtXxe?=
 =?us-ascii?Q?uEwDNq+U4MHLVjp1f1s2lqxstDGzFqhku+LJerxykTO48aSup2JwzPMNL0id?=
 =?us-ascii?Q?bYe1Hk7fOMCVKwop/7FBbxoIp0jgfATtANwnYVcoO5Fn2f1AKvfNnQcoJwyb?=
 =?us-ascii?Q?yGBHXV+mUJEWxAYRH5CaiZVu94VqVafMRj3ZeYPY1mbVrzeKLxgUpdI+nT6s?=
 =?us-ascii?Q?iyFfl3hNNi07e6S1wS9mW2djLrLKwM+w0v5rmPopkquuM6yXHEjHw9E/wUTS?=
 =?us-ascii?Q?ek1ICcl/z0ofFQ45i5fs4PIMRrWp0qoiCbjG0ZvNL5YnWCNwn+O3aZvfcR7O?=
 =?us-ascii?Q?pJsH5k76N0nte2nbGGQPjZCOMotVgPgui8EiPbUgN6Twm10YIpkZe4v4aQai?=
 =?us-ascii?Q?7LYytXq91rflN15oXNy72O1+lvaGI0g1vPuJ8cf5zRlOo0NDT/AkjoWi/rjO?=
 =?us-ascii?Q?5GxcRfVc8Fug6H7Gc2w38myKFyWM7QjF0HqyNNCKfWCV+ysZeJmc9G0+YiPb?=
 =?us-ascii?Q?YUVC4EtsZ/pdRJq9hRyXYh292zISW0uOCjfxsGv2DZHTSbqIFfAMKzXq6uxU?=
 =?us-ascii?Q?c1UZqFyMfUIW/vxOqzxe4ibpL39SV0wKupVQBEiC7wp+dQquQQmPnb3+OOcK?=
 =?us-ascii?Q?Tj/8GBRHA/DDsZTwa3C5K9XyVu1Cga+Ni3rlKduobnZdeGN3Hm4VdlGRv07X?=
 =?us-ascii?Q?3Rpd71zjvCUchsb66P2X9//SlG7312AWUy3k0I2AOeGFXUrO6ULyAHbzHlki?=
 =?us-ascii?Q?aXv3ohEA2hRvHu7QE4IfQlgH2ZJBpiaCXxybH512LKVD+j4pTyE4i1RsiP00?=
 =?us-ascii?Q?HrXCe1CEkb5mT4xvIwuI/ozFEHXnjS2sZoRudsKG17gsYtHVP+33dJ6RkiIi?=
 =?us-ascii?Q?IohiAXRKn0qi3EtioFaj8MvJaos3pt8v6PEs4f1AP4CsxQ8Y3URTwPo2PyNe?=
 =?us-ascii?Q?MKqCHW4y9+/zphENmn6vVPDE5xdEq74Vp78dkR9KJoyQghcqbyYn/JYFOYCL?=
 =?us-ascii?Q?T53OphTSOoJi1LEqJ1Zvb/p0R4G980/k7MuDb0UbeMTVT2Hwma3T2JNe+LG8?=
 =?us-ascii?Q?Wl0GBfYtZjwQz/LkFiKozw4sh6ORKLCNq7eTHF8v1cdLpCVIvJumCG+31WMN?=
 =?us-ascii?Q?VHi0GtJk23vMYNg5KEP+2O7RDD2o2wTpraXQlPm1ocIO94OiXMN20UF4LVG/?=
 =?us-ascii?Q?KksP1zhKHaM4oZUhp7nSBdE3HNLATyiZxTf4CptL+b2XboQh1V7D6V0ExOaK?=
 =?us-ascii?Q?BBg5lmFswGTBpAJ83pP8PrMpPY7Nq6+7C5hQtu6GpZ/GF1kufdqL0ceVq59B?=
 =?us-ascii?Q?oGDs+0WMIP4uZ59s7KvTZQtAlXi1cAo0OzWlUb8c+V0WG3I5VZKspKjlBs2x?=
 =?us-ascii?Q?F/1BDeY1FV4G97ycWFJeeHe3zxXAzY0PzIJQlET6hUHQVuJzR9majPmNi/HP?=
 =?us-ascii?Q?7iurOlPBAR0PPp/gUO9+mDsy94F6sSNTq8q41Dvwg8Ai7l17bdKqrR1y1Ajz?=
 =?us-ascii?Q?oEIQczLKnjjao5x8ezc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:54:56.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220b1935-890a-4043-99fd-08de3d73dc68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838
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

Initialize smu message control in SMUv11 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h    |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c   |  1 +
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c |  1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c  | 17 +++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    |  1 +
 7 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index d18934c6fbd5..97c19005952c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -283,6 +283,8 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
 void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
+void smu_v11_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 81241976b53c..eadd81e413aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1966,4 +1966,5 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = arcturus_pwr_src_map;
 	smu->workload_map = arcturus_workload_map;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, arcturus_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 51f0e299b840..5ae6ee87de04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -605,4 +605,5 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f4c390432b0c..fe43aada7b8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3379,4 +3379,5 @@ void navi10_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = navi10_pwr_src_map;
 	smu->workload_map = navi10_workload_map;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, navi10_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3f3947dc52a9..9ea6b0d1954b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3189,4 +3189,5 @@ void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
 	smu->workload_map = sienna_cichlid_workload_map;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 3d03010abcc1..579b1dbd36ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2176,3 +2176,20 @@ void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
+
+void smu_v11_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = message_map;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 65a0302ce875..a645094b029b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2569,4 +2569,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, vangogh_message_map);
 }
-- 
2.49.0

