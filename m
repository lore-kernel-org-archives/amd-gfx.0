Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A9EC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FC710E845;
	Thu, 25 Jul 2024 15:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2kiO1LGi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CF310E841
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpUKn8lz+X/5VZYBaWYptURkegfc+eXGCS7ejO8ARvlS+qxfUn0n99zvHqeRq14HxqzvyaXdzcFR1EG3R7CyV+39Et6c5df8VzIzm3EQ4Sd2FkKWIoAYY6+XaZ/BR+1ZL6Cz1EeAHJ4aRWJtVCnQ371FrIsQTyGs5/24yczGBZvtDvuKKKkEd53ckwiEYiyYgdbmBr3iPFeKmSSGtwJLeZJowb+RcaYWwDRrUv0jEnWgBm2MSoyY97GsbmWfrobjeVSx3KpTVGeRXtGc/dSusofgyijaupkuuc464r6gH5XPCqA1ONqPQnYty9qq8x8sywvHhGOfArZNSlAudZcxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1eK8ps4iXy+NxTlfEirWd+WuS2gP1Li60c1GuspO1o=;
 b=QAm0xbeLO6yrZyDRJiUGsSp+r3Ky3U/oGfDIq5iC9uYUt9t4ybO6p8JbCG4dCy9SLU/h+wXZz7Ms86MEbdHaxhPgVO1f0EZI9a0gFVAhVv5dbMhq9zd5SLRas+s1sKRfzBgSarrxnfjYTN/whCegr9T0suGEmWpqng3TOQz9HClPJW7HiOGBj4KGmiCUk03dOgF1uZG/JMEKf2fxO4cKyUF/jEN72Pe63DahGmsCL0Ub5iq8SWsLcKQu8bweKm0hmKKUmBi4jxmfAO+d5KRTgFVW4yK/LlhLNWXYfNneUl2+1iVzqPzwWUn+37HIY/8loQ7Pd/G4QHICj+Nh/sBVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1eK8ps4iXy+NxTlfEirWd+WuS2gP1Li60c1GuspO1o=;
 b=2kiO1LGiY8b+3JZ34m5R2+5moN1T7m/NfQrrOcqxZ9jQmJDvbzXpF0gvjToPqTf63PZI3Gj2QXoCXQEd2ad4kv2VgiCTP68bnLngDwHdNARYHyrZtn6wo5EbTH9klLLWSSKUGvOea18NFTdph82q0R4yQ3svGhutsG3GW/kD+3Y=
Received: from SJ0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:33b::11)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:14 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::c3) by SJ0PR05CA0006.outlook.office365.com
 (2603:10b6:a03:33b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/53] drm/amdgpu/mes: add API for legacy queue reset
Date: Thu, 25 Jul 2024 11:00:05 -0400
Message-ID: <20240725150055.1991893-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bd0dc9-f1bf-4a44-5563-08dcacbaa0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TtCpGjW1kOA8STrzRCW1uG2enaQuiRgez+BK/CdzhIoMwg6skWibifUisE/t?=
 =?us-ascii?Q?S4g17shagJKt1Xp5e1vE+ny51uTVNMPLH4SXwHPGD3G0/+pVPH/qqOewB3vA?=
 =?us-ascii?Q?aYVD9tI6Myxv7JYk9MncFraT11kOeD8nqKYAlu9+Lw/bXj7a54z6L020XsMj?=
 =?us-ascii?Q?7a3k6fCvbJ7AWShBeOIIB3NReITpr+z+jRdkUNQnjbRhcIk1WvGrXtk3NN2C?=
 =?us-ascii?Q?gCgnX/lG+MjKFlD8uqHxrPJXlahUSYAxS5k3QCw8oJz7+qRRRheR2Suy9VWx?=
 =?us-ascii?Q?oiphJpCrvhwzHQOad2gK65zc2V5lW3zkV1QVKyapog63dq82Xq/UHM6W0dP7?=
 =?us-ascii?Q?ZMNOIM46FlQ3S1GbzsCS32j+2U5/c+xuxAHM24uUKehS46wvRbpCo10kKxIG?=
 =?us-ascii?Q?QlB//H6SLvM+lr6uz1t34tohmOOY0dNHJt3HlqwXLyQSQ2JkUMXj97Csjyvh?=
 =?us-ascii?Q?92p29P129dAv56YjXYnZaqrGMuDLR4yDH6soZk0p/tgdLf25qupCv0ZP+iuX?=
 =?us-ascii?Q?o42L2bcD7rlsbyzWVwBSKxpMJXoaN4zIAhddaUlYEAl7x3T1gQJOxTRLd4vQ?=
 =?us-ascii?Q?1vuYoK+VYwwke7DytN5lTAnWU5jlZfFnhVkvamCCW3SE6WHzYxMQoA08iL48?=
 =?us-ascii?Q?OFkTRlzGfAezDD88jPEktWL5/qfM6wxDDf0ZQRTcIKLzOW2k/P0+lDl6wm64?=
 =?us-ascii?Q?XUxrHBtazjWj/X0hzlg4j0UJRwqA3D94RjAuXD92utS7e6bW42DL1KaiskQg?=
 =?us-ascii?Q?mA328Wup3D/pXF3IH2TT8Pe4LerAy1Z3FJzVYTEenoIZa19Q5ztajLcDJahs?=
 =?us-ascii?Q?yVxFjXI/EWPtdfePBfLG09g/TelG85uZgJDL5jyAxYc86Fr4B2nvvJoecx2w?=
 =?us-ascii?Q?v2JEUnhR9c9JJ6GMntQ7wV6AnYvp2u+RROh4eUFf9NJnga0Y42cjhWpo+23n?=
 =?us-ascii?Q?gwJ0xOabKq8OLz1jfmwzbyP/d+AILpny8VTG1+PCTnQ1EnHy66WY4XD2H48X?=
 =?us-ascii?Q?0yC7q+wSF7P2XzM0o8vg9+ftwHbTjsXDW0NVvAsQswOoGWDzhdN8khsY+UKb?=
 =?us-ascii?Q?BIDCj5dnkmZHhzg6cU3X9zsExkNSHXjsE487nYyV/c9bUNNHJZ7olDsFglxp?=
 =?us-ascii?Q?/H1aH+WeM8AL/wnKHTw7uaQ1YlnqiCo4vg00MLkumN301ohj1fynRTiX8/Eb?=
 =?us-ascii?Q?UwsMFSY35qzDmT9cm7lGfCT5KG6Ct4GkiwjwL2M/z+tpmAv6oYWFe2IYbAic?=
 =?us-ascii?Q?eHSNR+nqby+b5sklbujQFq/mt+zIqP9tBACzXLLWUq/zmZJknAMnPUWu7esZ?=
 =?us-ascii?Q?nUHA3OtIk/2B2MgtGtMXpdoLySaeTaC7/FjwFGd3WfvMaODXlSu67zIF1DHl?=
 =?us-ascii?Q?D2K9dcajhd60ogNaWl4ywVlR1qxxhuh5wohTvpUOYkn3Aqmun/OPmHUgWuD4?=
 =?us-ascii?Q?q5Yz8Aw3mYDoe0rtc7PWTkD7KrQWZ9gt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:13.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bd0dc9-f1bf-4a44-5563-08dcacbaa0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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

Add API for resetting kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e499d6ba306b..1739aa11cbd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -819,6 +819,30 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
+				  struct amdgpu_ring *ring,
+				  unsigned int vmid)
+{
+	struct mes_reset_legacy_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.queue_type = ring->funcs->type;
+	queue_input.doorbell_offset = ring->doorbell_index;
+	queue_input.pipe_id = ring->pipe;
+	queue_input.queue_id = ring->queue;
+	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	queue_input.wptr_addr = ring->wptr_gpu_addr;
+	queue_input.vmid = vmid;
+
+	r = adev->mes.funcs->reset_legacy_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to reset legacy queue\n");
+
+	return r;
+}
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e11051271f71..4456956c325b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -279,6 +279,16 @@ struct mes_resume_gang_input {
 	uint64_t	gang_context_addr;
 };
 
+struct mes_reset_legacy_queue_input {
+	uint32_t                           queue_type;
+	uint32_t                           doorbell_offset;
+	uint32_t                           pipe_id;
+	uint32_t                           queue_id;
+	uint64_t                           mqd_addr;
+	uint64_t                           wptr_addr;
+	uint32_t                           vmid;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -347,6 +357,9 @@ struct amdgpu_mes_funcs {
 
 	int (*misc_op)(struct amdgpu_mes *mes,
 		       struct mes_misc_op_input *input);
+
+	int (*reset_legacy_queue)(struct amdgpu_mes *mes,
+				  struct mes_reset_legacy_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -381,6 +394,9 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  enum amdgpu_unmap_queues_action action,
 				  u64 gpu_addr, u64 seq);
+int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
+				  struct amdgpu_ring *ring,
+				  unsigned int vmid);
 
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
-- 
2.45.2

