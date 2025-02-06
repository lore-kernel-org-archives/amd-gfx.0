Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C98C02196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 08:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBB210E7F1;
	Thu,  6 Feb 2025 08:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BH10EVPJ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780CF10E7E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 07:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spTF4upZhybwgV/qsDq/VGUIQ5oQPX6LUixsVfMeo4OBoRWh+z33+Du6NeFMEBgZfp0mjAB0Da+E/wgGxY/3WZ/pzBEyBXvBEXdtjNqFihGaKr/9Tpu422RgdIlhpE3h0ZuNwTy279eMzy65fJzVucJiU6+ZnTPGoGrrHn66BhfUQpyZ6omQdn5roHQQB/+q8OdzunuLI5rIuKfGk2oofKug+KmynE0rTGz43rvD8xg1wAaU5utBca2JkHQq3fhTUu4X01MAOQQyUJyMjkDqBD2c99dps2/cvV++uD4H3Z+wWo+HQbzQc+Gq2UpXmvbc6GiFoTdnTKewCgAryqxH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oesoZOGx4d81Di6hUNzKdvGoQrSs/AumPOeiQ9AKLX8=;
 b=R/YQs4XuLcbN5Av0XuVBXftyRVXVtBMhGUVosWVNLU/TBdiy+2IPJswUgYi77DkG6jvnyX38EsT57MCGW+HtwIIIZuVDb0xulU7jGw8pMUmjAOdEufie0XxxVmfNQfsRrzWaxn5tII7cm0mDIaEUKaybj90mSq5QFTQWWjqTfjEFdmDZV7+eYirGsTeEoqYxE4OQztT87tdU4a8ofKrjTKpJsEmvnAKvNaZAHl2HM8tqm2/18XPSvvLYugySuFxFP4qqCjkV5/VMhc18HZ98i7P845Lwv/g1PVlF7Tc+wRr19x1jBFawDUxeSAP+kiwxRF8pFXG4CXWRDw5KuAzEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oesoZOGx4d81Di6hUNzKdvGoQrSs/AumPOeiQ9AKLX8=;
 b=BH10EVPJc3iKlefnyyWf+ydxS6WcwXM+FQ+m/pT4WaL3r/GEnSrMd6W9FzzpQummsaq31g7kkLo3dXyzYgQgoL5dHy5JqchL/GTeYbKfCoybS5phm4l1ayy62JRzNDEuqosCrt1+2t43oBZ6K7KyXJ3B+mn7vtBG842wzYfHCDA=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 07:57:00 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::f0) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Thu,
 6 Feb 2025 07:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 07:56:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 01:56:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 01:56:57 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 6 Feb 2025 01:56:56 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1
 for sriov multiple vf.
Date: Thu, 6 Feb 2025 15:56:52 +0800
Message-ID: <20250206075652.1561999-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e79e32-e6af-42f5-8e45-08dd4683d5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bvdn10LgAAcDsuOj0UEKZAfdct3E8eBoYzmJvvtsQ4ogsnLECO6350DYw6WT?=
 =?us-ascii?Q?VVC3YWLX99QP8T3Rdno/2Hi40VLb4wdyfD/2akEloGhtmudt3PVoVypyEH1m?=
 =?us-ascii?Q?qnUhSb/m6B6kr0dikYlTNcLLAI//02S1TfxePklpBpAFBvbqe3pwwZKjfwuv?=
 =?us-ascii?Q?eh60r/W54tivUx872LPnzibS/q11yLWzOqzSfigVPE9pz+AupIZh0l+uTu3W?=
 =?us-ascii?Q?5/gLIpsm0/wtcqqhppNGDeWD/O7k4qMwgwevwChBTas/eh1us5/Y0m+12jSO?=
 =?us-ascii?Q?t+xLe9EPqCU4Q4hmGH0cPwziYAl5g4+A5x69GQHtHaKCmdtjWqY5LftlR/3J?=
 =?us-ascii?Q?Iiaeg3LrVkBvV/5glLcTTTBqVvF6fcMN9x5RUZzCRFamvkhBAdtakTJRqP2o?=
 =?us-ascii?Q?4wSB+8TwfE3Z04IkVYiWRIV33acLhrLq1/u0rk8IhISIa77iG3s10cc7qs9t?=
 =?us-ascii?Q?KjRjEhDVCi2fEMpzlw49qP4v/G7e4kTWRjzb4cK5ijG/Sx1Xx+Kh/hLwfX/Z?=
 =?us-ascii?Q?rfQmwl9ntXxMutBFfASrCLaMdUln2OtHWA7fIBQwv6hRYMjhiG2kLPVj5EnG?=
 =?us-ascii?Q?kkeqkaPUJK0BgoLow+L50hBLMEHvpWPRt3qTTgAtYzCL6DeL1x0lhkoFJqRx?=
 =?us-ascii?Q?F4hjLupkaV/MLoMag0KyOAjwxYJXZegTU6e/8aOfGtPHfHR2ZZpjm5qhHuLc?=
 =?us-ascii?Q?o9Ni0frX/Xqv5UkeEHOJcBFjcPOzM+bjYA89fllbIbwhiV5NQYmlNNnSZHVh?=
 =?us-ascii?Q?pG78MlMCaWnC0U0gfR4soMRoQht+pNOHN9wIKuQiT3o1dTj/bmWQe/cUqUb1?=
 =?us-ascii?Q?bL3NvCQitdD+cjPkxPl2jyZ3PO968lxXBGBvvClQKOnNppcx+c0JGkQXy6RJ?=
 =?us-ascii?Q?6FUb1euKmWPK1zWfdWGvkPI+iffW/dFUi4Q17q/031iamQj9wAXDbrgao4lo?=
 =?us-ascii?Q?bQ50NAkqxDbI7UnDHFzOg5kLHeqijNApoWVgH1lKiWToHcjdy0ODoE0IBhpy?=
 =?us-ascii?Q?PGZWnXrA39k1BFyDcHTUvshcXHeIjWaKbICPVCOtHYZZBgZ7jaHRJci70VRl?=
 =?us-ascii?Q?hV3GsQNmQeX5CSJ/C1cxd1VLOu34GyRCvuQjt8KOYiaHg3eW4VU8tNFPbzCS?=
 =?us-ascii?Q?sNir88LR3q/ebwi4XT/8gJyzXCxBhnL2wikdJmtLTkVAQAsvX5Ya2I7r5Vjd?=
 =?us-ascii?Q?qhV3ssaqK61Unu76NTfxpejNDqHJ+gQ02s6E/fa3PdzqA84zPO0/NCXz0rTO?=
 =?us-ascii?Q?d640BZU0chluCLuQWwz4JCu7pxyda4yAehM9XnL8ZNxMjm+L5d/z/7Ci3kP/?=
 =?us-ascii?Q?lcqXHNXZYN9etFtXVIkp8KtkzlTVObgDsrkMj5y5h3KztalJAoLdgRPPQFPV?=
 =?us-ascii?Q?1Ucb7IJr+5KGClMpoMahL0Q7oxfQpQJac3f9XZBwQ6uMcA3Bp6SItiKJsMnj?=
 =?us-ascii?Q?/kV+D9sTMP8WOcpfwHaOsbGfubipw/ZvKoapmcJfTB+MvZxRz0tDvoYe4sfw?=
 =?us-ascii?Q?QUzCHQgLFX4L2oY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 07:56:59.4557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e79e32-e6af-42f5-8e45-08dd4683d5a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

In sriov multiple vf, Set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 25 +++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2ba185875baa..479b790d0633 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1857,7 +1857,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 					    DOORBELL_MODE, 1);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ff417d5361c4..c8b2d7a8bd0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -551,7 +551,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
 					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
-		if (amdgpu_sriov_vf(mm->dev->adev))
+		if (amdgpu_sriov_vf(mm->dev->adev) && !amdgpu_sriov_is_pp_one_vf(mm->dev->adev))
 			m->cp_hqd_pq_doorbell_control |= 1 <<
 				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
@@ -724,6 +724,10 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		m = get_mqd(mqd + size * xcc);
 		update_mqd(mm, m, q, minfo);
 
+		if (amdgpu_sriov_vf(mm->dev->adev) &&
+			!amdgpu_sriov_is_pp_one_vf(mm->dev->adev))
+				m->cp_hqd_pq_doorbell_control |= 1 <<
+					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		update_cu_mask(mm, m, minfo, xcc);
 
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
@@ -746,6 +750,22 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	}
 }
 
+static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src,
+			const void *ctl_stack_src, u32 ctl_stack_size)
+{
+	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
+	if (amdgpu_sriov_vf(mm->dev->adev) &&
+		!amdgpu_sriov_is_pp_one_vf(mm->dev->adev)) {
+		struct v9_mqd *m;
+
+		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
+		m->cp_hqd_pq_doorbell_control |= 1 <<
+				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
+	}
+}
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   enum kfd_preempt_type type, unsigned int timeout,
 		   uint32_t pipe_id, uint32_t queue_id)
@@ -880,7 +900,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->get_checkpoint_info = get_checkpoint_info;
 		mqd->checkpoint_mqd = checkpoint_mqd;
-		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
 		mqd->mqd_stride = mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
@@ -892,12 +911,14 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 			mqd->init_mqd = init_mqd_v9_4_3;
 			mqd->load_mqd = load_mqd_v9_4_3;
 			mqd->update_mqd = update_mqd_v9_4_3;
+			mqd->restore_mqd = restore_mqd_v9_4_3;
 			mqd->destroy_mqd = destroy_mqd_v9_4_3;
 			mqd->get_wave_state = get_wave_state_v9_4_3;
 		} else {
 			mqd->init_mqd = init_mqd;
 			mqd->load_mqd = load_mqd;
 			mqd->update_mqd = update_mqd;
+			mqd->restore_mqd = restore_mqd;
 			mqd->destroy_mqd = kfd_destroy_mqd_cp;
 			mqd->get_wave_state = get_wave_state;
 		}
-- 
2.34.1

