Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D563C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 06:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD85510E031;
	Thu, 20 Feb 2025 06:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3xob5gcY";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903B810E031
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 06:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/+8bICx1ozxkYRF1HupnaCkwcjR0kGZ+uTF8PSBbUggsYMWHnPYU2TgiwoR7nOl2+49c1f/WOWpmjczqWvX9Root5EwZij77mfZIv6QggQuahTEyChOkGjQ9hh4LEFJc3Cnj5h8qE+EBUmC04kiHo8umEF4g9xot4qEYCQzPJozCpFKMXXjw/fOMqu6kMc072digox/90FKdxlZ8QDahBmd1zUqinxjtoHqsduqSWpltrIhoPKGYcx6XT+Eq//FqVYBCkKaoHmj76H5ubdKfejjLnnUQXfCqIHWfy9jB2a+Ksks+fc7SVjPfK5+ZNmuH9lHATb/GwTkZHTT0Pu0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMNPrLvsBhUjviWKBB3hMoQ8ru6BK9mV0jK7T/EZUx8=;
 b=Y0KWrsjkrBqv7J1v+VIirHlECiU2sskNKElEv3WdbSnKfDiYMK52RXiSmX5RPz74cyD1WuNsAARa3sIFmclJWGIQuAQy9ODISRzBV/9LfFXh4LBeeqhCxv0G8GAZqKM+1Im84V1cYSO3WrAeuG+1AS2pdby9jcnP1wkOm0NVGOCIGzsTi50MklXTwtKd8v68bDUEB5czvYBc/B4WG43T4ke6gIhj3MvhRYq7qX5e/3FO6G3lay+0jr8yv5eDcri/LQbAjL+mvd2+LwdgkhIT00qAhM1TtQ4mnh4uDV+Cq4grAYhTArcI1cIjvfugFC5jAcAlBv++lJiX5K96sLcYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMNPrLvsBhUjviWKBB3hMoQ8ru6BK9mV0jK7T/EZUx8=;
 b=3xob5gcYwdzLft8OSlIqOAktvZ9Wy863a83yQW8Q677jFYeehs9Zw0vNcQTGo1KQ4JXaSIN+JGOCbPc9O5c38FcExY71IsP6zENvq1ACGFdbeNh+bJmGsCAZge7pQ8loCS18ch5Ly+6ylOpJtWJatP4Veg2PfwseJxNVAJjJ6/U=
Received: from DM6PR02CA0137.namprd02.prod.outlook.com (2603:10b6:5:1b4::39)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 06:25:24 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::e9) by DM6PR02CA0137.outlook.office365.com
 (2603:10b6:5:1b4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 06:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 06:25:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 00:25:23 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 00:25:23 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Feb 2025 00:25:22 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE
 to 1 for sriov multiple vf.
Date: Thu, 20 Feb 2025 14:25:14 +0800
Message-ID: <20250220062515.2050499-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20250220062515.2050499-1-Emily.Deng@amd.com>
References: <20250220062515.2050499-1-Emily.Deng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3154f0-3e89-4ed6-4558-08dd51775bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dc9r2qJ2jXwp1HElYd00QwyGEsxeo2l8thQWOBcWjwxb5h36+SiId7gQmT4N?=
 =?us-ascii?Q?lg74vB0kWk5RH9nmj4eE6RI8MoNFUv4nchYdEHXgYZ2xX6p0fvwSgdutacP4?=
 =?us-ascii?Q?M+KQFBc0uLWg69k9iuNbgRrePTXpWRYOVJqOfkRAfkoTwYY5tuiQgibK3Dhp?=
 =?us-ascii?Q?fAH1aEf18qg2LLqR3W83eeMEJqOZjobbaFutZbHfDmt64TAZLZ6PUozbK6Wx?=
 =?us-ascii?Q?zu+FfHtn7arjPefcvFJVfhpvVu6+wqlAt5A+WwExa4/Mj4x2MSGrJdJKUAlp?=
 =?us-ascii?Q?4Feq59+AycCgxnLIb0eVU7/8VJf/GxrDdUwJTnRFhJoReA6fZddd2cP0ajPL?=
 =?us-ascii?Q?eCBHMp8eIEZUEU1PDMS29BMM/krHpUa4nnUMyR4VErasVEG5fW+FbYwduON2?=
 =?us-ascii?Q?K+AkpOL0dCW9IC7z/ZJ+T6K8mS16OKm+y5qmf/DeyfloMRqq+p5m5t0zDtwe?=
 =?us-ascii?Q?1KAeCCpKTLNkujUvKLDg+hIBRnDq85/qN0hLDyQLagRcCjwEmGsAVtHOsfup?=
 =?us-ascii?Q?TV5kNnGQ6Sv7MNcltRJyBk4sJ1P9Hj+Y5LMZjCgnqGqlz+FFEt9oFZ06L5Y3?=
 =?us-ascii?Q?WJSfUvluFkYg7e4mpkPG2g952eK02VEBZYc3md7xSYdIK5/byItMLS0TgRTh?=
 =?us-ascii?Q?WkXklaym2cBgojw9V7+E/aYqXm1OFT5xZbLOOFGOs7XmR2ECB+E/0gKNtNTf?=
 =?us-ascii?Q?5EAZVi8Nei14AMwPfCPtKceSMaxz44t7j0Vf00rKUKDC4CoZ+vodOCkM3rle?=
 =?us-ascii?Q?qIgq1kBhE6ZCesXiCTK1iv3MbwL+FxNGQUakMa3zrgT8Pk0CRdUi+hKYPDug?=
 =?us-ascii?Q?dRoUzJKsjE3jN4Vrlb1LUoorSsVoZaiIHaZzhNnpUQ2km9iGCXyKdnQ7TZhx?=
 =?us-ascii?Q?+OAUtKvrCFhBWpLd9rwbHuQhfBsEW8nrGTd9Y+GLWhOsZPLO+V8aCVATYtiU?=
 =?us-ascii?Q?bJ49cRIXJRaQXKc4dGNyrO8mM16o6kwg3NJu/XMneNQGLQbv7U8Qc70X+Oe5?=
 =?us-ascii?Q?K2GRSoj9jtOYSHg0dcxmi7o0bM5/aCGVykyHOWhSbKBaMKA91MYfY6wsY/BB?=
 =?us-ascii?Q?np3FfQdbGgiYwz7JVVmeBk2kxdk5nR4WzbAkUeJjZs2RcZ4sqL8d26lD/G7G?=
 =?us-ascii?Q?q41dMHbfulkG2m6iOBGKN7VHSBqqO4TXdQc0Z7TPp9XBnHkXp4iBLu8LE9N0?=
 =?us-ascii?Q?SwpoyFJdpuS52/YZaqTCMH2i3SmbKwJHrc1E77Bh7xhLvi/HtHOeIgMzuaKj?=
 =?us-ascii?Q?NVRe2A6SSrVueQJJqycUkDO6M4WkIFxw3HmEbPwueU8BVjLwi1g5+QCIt3nx?=
 =?us-ascii?Q?iux1yGwVXedGXU/gMpU0dCGKpMTAoJRM2WeYH4zJR+0r56RqrzJ/qk7dHa9u?=
 =?us-ascii?Q?nZhY8czaL2J0X7hB798VdYGyblEfLdv2USIVPk2QHKRWbtZGjgS2ibbarOnA?=
 =?us-ascii?Q?S//QSmkzt5Vn+6tMvF5BxogQlcraRlGOn5q5/bp9AadkIT8DqvM/+SYN/pV5?=
 =?us-ascii?Q?Uf2KAe8w0o4zLPk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:25:24.1521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3154f0-3e89-4ed6-4558-08dd51775bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 27 ++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f4635fc8a7ca..c6961e8d5e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1848,7 +1848,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_sriov_multi_vf_mode(adev))
 			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 					    DOORBELL_MODE, 1);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ff417d5361c4..6b38967d5631 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -551,7 +551,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
 					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
-		if (amdgpu_sriov_vf(mm->dev->adev))
+		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
 			m->cp_hqd_pq_doorbell_control |= 1 <<
 				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
@@ -664,7 +664,9 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset*xcc);
 
 		init_mqd(mm, (void **)&m, &xcc_mqd_mem_obj, &xcc_gart_addr, q);
-
+		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
+				m->cp_hqd_pq_doorbell_control |= 1 <<
+					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		m->cp_mqd_stride_size = offset;
 
 		/*
@@ -724,6 +726,9 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		m = get_mqd(mqd + size * xcc);
 		update_mqd(mm, m, q, minfo);
 
+		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
+				m->cp_hqd_pq_doorbell_control |= 1 <<
+					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		update_cu_mask(mm, m, minfo, xcc);
 
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
@@ -746,6 +751,21 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	}
 }
 
+static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src,
+			const void *ctl_stack_src, u32 ctl_stack_size)
+{
+	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
+	if (amdgpu_sriov_multi_vf_mode(mm->dev->adev)) {
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
2.36.1

