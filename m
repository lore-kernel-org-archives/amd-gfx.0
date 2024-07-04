Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A443C30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 15:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59FF10E610;
	Thu,  4 Jul 2024 15:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQSlG60+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44ED610E610
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 15:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSwvrA6AjV8iEUCs64B06Hk2XnJrI7l36iJ9ZFZd3iZ807n7YI4lGD2QGEzSUb8LrPI91iZNJaoLSg9ES6SH5c/uCXDzQyqjnIqIUwXIrlyrxGhh61csub0bLbXrMwQ0KfzWfL0hCoNXEV+pbx+MopFx4XOuJOueD9jiWTXNZw5as2PevggwPG7kN2HKWHXd8HZIMdkkHvbkOxHo6Qu0CjdAZZBsZdHaGyzo//XU4cDU7TpwYDiHM+d8E5tOdmjZMTDcAK8WJLjRxe1z/tO5sUVEn/EnMc0+dXkU5cZvI5fP/nTviegE++MsXsuna/7T402T5S/mqZPYldVlYMKz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPnExJUwngCu7x1GCJNJ3c+FZ2le9RRW3bvW0Q5wDJI=;
 b=awQLMCeV5rhbI7LDg/jcFixNAwf/IM2j1gmIZK6TTdcdcmf0GsbJzgNXevVFUYuxSCuOEDaMYrg23q1wSP11SkGuxzzGwInkUD6OZ+MA68UxZySQvVN10+SvBFxIgENtBbm55RHlPArKc2p35uWS0nyBc7K/Nvs6VJOUwBt708yaPL+jgCXUWmu4kKD8BiFPTsgEh8BiPCDfaFYifg9QE1LWk0GZqvD9CibLwtzqxyGv6AUchEufiPqdbdNvrFXIJaQHyymm4T5oXCFnNgOg1cv920dad2CzXLwfgC6n1G/qFlhvLcEvsZcPV/RlEqqiTWWxaKdtmb4D+L3QLY30Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPnExJUwngCu7x1GCJNJ3c+FZ2le9RRW3bvW0Q5wDJI=;
 b=mQSlG60+kJNzQFEF8mvURzUgeUIX1hFSVCLgNwZgOxpuP71nzHXlfuXUmnsVe/VKD5y8/JhHSmLPvDKWssaljfhIL0jFw1lIzlexLeqJKltLdY5IbyGWxVoDGoRPWHh9o+HW7LiYzIvGGhAzSEmz2jAz9CdtdxYb6CnhZUKQfZM=
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 15:40:52 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::5a) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28 via Frontend
 Transport; Thu, 4 Jul 2024 15:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 15:40:52 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 10:40:51 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1
Date: Thu, 4 Jul 2024 11:40:38 -0400
Message-ID: <20240704154038.4599-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 93df3a02-8d97-457b-6e31-08dc9c3faf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IceMQyzXVX4sqdX9aK5MBuOadox3ctRQnNmzf/YCqUgVqy2ckk9yKKp2/3mL?=
 =?us-ascii?Q?Eb0wkBUBsOohi72lYyY+5f34x5q4366s9i24zodAcleBrpXhnXBUZVBYU+ip?=
 =?us-ascii?Q?mMfiQasNLe2QRUZjuQ26uz4RTORFhWSsiu5xj13HezsEAo0LzwHU9pRPU3Pu?=
 =?us-ascii?Q?tDDrs4KQhq1+ZgCZ+KchoJB2b/1xQ+CXr9NfShj2wP2as5eciQpuXPHDIGSx?=
 =?us-ascii?Q?zgB9W9p6kB0jJVefoW4WzPrzMaxgl4ccfKWpcqBp+SVwvOJRMF/onxkMu6qX?=
 =?us-ascii?Q?qElLg+WeqtqWxJ7NoIExTOpJ24u/fALZ3GlBiSv+Sp7iAhv5PoEoe1odpwV6?=
 =?us-ascii?Q?CGvUP5k85Nb8kOqWLCDckg6v7U19YPY0a4i+1GXzuUs9NbZw7j69IJcdTsfu?=
 =?us-ascii?Q?oIRG6gwXsd2OHy8aHIVJMQT8XMpayChscqtPc197WG12aEWD2db3GKmev+Qe?=
 =?us-ascii?Q?zOz5pvtQeYiQ5HOYwbQNjJ2yLLc0jyzzfU5Wu0oZqNojvwUWo1gGtPmRriI6?=
 =?us-ascii?Q?hQ8FdzBiPlM6HP2Ltfx1Yi4a6xw0YUx+mVpKFwV76704frsUR4HdaLQjuWKD?=
 =?us-ascii?Q?PfTpx5RsQhna1Ic0CujSZk83SDxVYFERBjLvhNwazyP2XCdFfQjgrDrsDqcj?=
 =?us-ascii?Q?l3pQymQwusNGEGFjgp4w/BoLOvR94wsesz9IT69S+rAsPDLazCIkq70YCQUX?=
 =?us-ascii?Q?M3ZIM1Noo56Y7jeHkJvro3dyelbPLQcTe0hFSJtc60k+l+RKRt6hRZQOd1KR?=
 =?us-ascii?Q?PnZAv8g14JllqPUDKU9RjQ/F0Yo31PLBiXWp+3sREx9/hwZloG4b3Wod84TU?=
 =?us-ascii?Q?hqqfyww8kmWWP0bjovZvP/F5ntDZ1r2pN+tzwTTDITMpdL6y495wGZSIav2W?=
 =?us-ascii?Q?EaohlClYjpTgcPztqMqxmsq/VSxWF1kmcDgei/Ggulu5lfP+KpPjT7VXj0gX?=
 =?us-ascii?Q?Mydt153ZPh8B17J1CQgwddeeLzE6zB7Z+8QjZkpQlcxnPYaUIj9/nZ0Cya26?=
 =?us-ascii?Q?75qfsTZKcr220ff6ee3AbN/dB2jwC88wFlUlci/o4Xzffo13//TKA6JGoqLB?=
 =?us-ascii?Q?cUx1M5c1wsfskvZQycMbZfPjhpcK7Of4JunvO5AD164ZNKYp4YCsfYIK2784?=
 =?us-ascii?Q?toHlk6tnrVuKwot9AmcFNf+5igZdPLcaNwlS/4K/LjlSN+JumWUXsnYylcQL?=
 =?us-ascii?Q?q04tYIRnLNbTbnWwQO9p9UZYyISn2MOfbwTDc+Byckogb78RjC6sDU2AlIYV?=
 =?us-ascii?Q?BqEdrclgkFupx/t/k3fhg/qCjGwQx+lBjFo0gYrrI1c1fNOEc6PaQN4ccmVP?=
 =?us-ascii?Q?RmTAFPYrh+dz2DUFLS+sHCk3j30LKR3aPrrhTyoHNC1Dn6mzdxjTO0zsKD06?=
 =?us-ascii?Q?74Kg1fE9E37VM2ysK+tLh9dGBXvTaiO0/Cy8BrluEAV2YKiy5yn5iqRe+KRG?=
 =?us-ascii?Q?6Hqgjpw4pvn1OSmHWn/kk6GZKLud1/GE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:40:52.1115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93df3a02-8d97-457b-6e31-08dc9c3faf8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

to avoid reading wrong WPTR from doorbell in sriov vf, set
CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c         | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8d8763ebe027..4556a1be5f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1584,6 +1584,9 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
+		if (amdgpu_sriov_vf(adev))
+			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+					    DOORBELL_MODE, 1);
 	} else {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 					 DOORBELL_EN, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 399fa2106631..66c73825c0a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -546,6 +546,9 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
 					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
+		if (amdgpu_sriov_vf(mm->dev->adev))
+			m->cp_hqd_pq_doorbell_control |= 1 <<
+				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
 		if (xcc == 0) {
 			/* Set no_update_rptr = 0 in Master XCC */
-- 
2.25.1

