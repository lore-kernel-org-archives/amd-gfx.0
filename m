Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCFFD2127B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 07:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FFC10E8C0;
	Fri, 18 Oct 2024 07:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w5bRLSyd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C2E010E8C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 07:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btonsAZtFfHaFoD4b+dvYHMSDoz3mFfx2iUJpaKpMwJAbhdMPJxj2K4WSZJwhB3fy03JvcDrOJ+tZRDbZJGfxvWkkaJrxrH8NwFDVh4viDgDsTMPSlTfE6WXYvOo/3kNF3kvTNXpAiKnTbSbDMChyRpf6vwV8ASvo++g8XLzR/Bg5RUbvDxJ8l33bBSfedbuh/edVVzX7V/qUiUWA61XUFafhggviCVSw8s72vgKuCfN7iWd3S/eck5wkGFfVNcFfiN912plqsC4+JHooUwSeHmwJd1se+v9VxCsZmPGDeFaDfGkrRm1z5rBrOH8TY+pPgRudG8+QwgFsxkFIMQ6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8dAB49B7CuU0p6clLvZe1G7VmdFkC1s+3NVIFMkGKQ=;
 b=j9AVVSUntXKpRhZ8iqfd4hYN60wq9ytglySUx0cC5CaeMWOsOOzPdSD2lFaxY+7g3IWSroY98bhbpUyMt3x9GMu0xOohcqICWy+Ud497jz2DK1p24KiyYCgs6ei8ik+kIoVZaHinvfOaPt34IFIxV020A4YS5KbGx/H3y6ka493nAXqboc9D5iNRF21/TteoyIh6KCgRB9AJQN0F3AfSYf34gTKcQg9n9BL5afRgnFVomsr7l++223/xfA593UGlO+M8rteCdTWMEC80+cnLuY3Nedl7sfQLD+LMAzSUTyTWjY2X1VOYEgbhEmPEwu1Amqn6WL8dBvVL+qKIaWUlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8dAB49B7CuU0p6clLvZe1G7VmdFkC1s+3NVIFMkGKQ=;
 b=w5bRLSydJOKfgCPnTgA4kMM7WWR5F1H6TdAkxgoMUMDvoIfOIjgBFze33bwR6SHa5Jbe7rULPSmyPDRcy0+h5iVKePpZ934pVCTEXr7zxmHJu6ngc7qWFV9HdIPlbmt9hzmr1yeWAdu9i3KKMReU+4bGqxN4/DK1IuK15NLUjIQ=
Received: from BN9P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::13)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 07:55:13 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::37) by BN9P222CA0008.outlook.office365.com
 (2603:10b6:408:10c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Fri, 18 Oct 2024 07:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 07:55:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 02:55:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 02:55:12 -0500
Received: from sam-builder.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Oct 2024 02:55:11 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Workaround fix the multi-VF doorbell corruption
 issue
Date: Fri, 18 Oct 2024 15:54:50 +0800
Message-ID: <20241018075450.3343451-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 8329e6e1-8d2d-481c-bbe6-08dcef4a3282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4NroxvBfgb6qWIZufnjjLwH74niEButTOpE9GRAjSFAR9o7NFNFDbKFx76Yr?=
 =?us-ascii?Q?ZpiqvzaztFnNq6E8V/0O12hbAW+4rd+iPc+S9OQu5NNg1TIYWzFhuh2zSgmL?=
 =?us-ascii?Q?+ldBIDrpcM957RLjWfq0i7j2IK9qrYNL6cRdPg1VXgYlwdm2ugWda5NlLRrW?=
 =?us-ascii?Q?jvrpHyGaj7Wkr4r4qBrLD6miwkN2kVfi2qyAhuItKiq5O58BbM4Yi9ttklI3?=
 =?us-ascii?Q?uYrmQ2jd/eZWbnZBfWbrCYwsKf68UXpVcFMD3kt6or4yre8FUVL862gWg61h?=
 =?us-ascii?Q?CSScZ+ew+URKoVK9z/9WpxYhmnhYtNzqsz/5OxDXHeBnD46bxg9qu4UpHxhe?=
 =?us-ascii?Q?DbxUAi+U9pohFdbfa6apApvJGRz/HoEo1gvBKd+ya1SFPhIQfEnUWdrw5f0T?=
 =?us-ascii?Q?QHKZVQdZ0gQueRX84MXtdsuIBbeOXoJCwUoOeRnSP+/YVgFeguTjlrw1CXv1?=
 =?us-ascii?Q?zHeQMx4qAccFlFnH7xcKdIs4cWhkbUFXxDwQUrZo+vZQGPnwr0fs4n7abG7M?=
 =?us-ascii?Q?yKc0gpNC+z5S+m0ap8VFSzz+/oIF/ED2Cqj/txTzEgCOVaUcLWP6zMB1RXaL?=
 =?us-ascii?Q?eAsyF8T3+pf+BbEQEcipgQZsGBMg2iSYEcfvQDIObLVsBDJTaFnjCUvw7Gm+?=
 =?us-ascii?Q?i+l9kA4ApdpSU+Lx0Br+IwFzVmf8G2L2Z+HWoUrLp+KwNpxUft1CA9Q3oSnC?=
 =?us-ascii?Q?yEbm8h94DOA3Wfs56R5glQhxzdaGigl6Len2LTDukTglchXOGMpi8R9VD9+O?=
 =?us-ascii?Q?DGq6H7zZvB3sNmPZd6254Vs3TY6ApYZcGsW1am0dofZvaRCUesKtTjGL1Z6v?=
 =?us-ascii?Q?7dpNv9lunWYbHr6DYNCy3w8KoRSwU8hu04J/+Xq+WSCgYTkUQaminfjqiN/Q?=
 =?us-ascii?Q?zK2bGZadE2YRW3SRunQv9Dvw5BuKcszScGkipnLYtXIZn7PWLzSgdHRzd6LK?=
 =?us-ascii?Q?CYKYgPPG92nM8deWA53J1DKqvBU/hydcX4zdIbtnKmoiI2XdHMxe19r1DjnY?=
 =?us-ascii?Q?TDmA5jYNpc5Zw8k5VjASu9bovFIm8c+qNsQblDgxNW5u7RHdYmwpwyQYSewm?=
 =?us-ascii?Q?G0sd7JZ8okHg3/Qxpi5gfU77P5U+Zq4kcFwrSnoQv60jfR1WerJfcl4nlESw?=
 =?us-ascii?Q?C+3rBJdoB4Zf44GqU+m6mXf8WO1h8CmQ85JcAC6cu9upg4cQjIarny3QszTO?=
 =?us-ascii?Q?phsA0HN9zhuBbbeazij4AMvwFT9jOOJJLgO24XBLdooYkhRUXha7nyjW0a3g?=
 =?us-ascii?Q?rbNOM4EJi5anbQzVyIX6qGK65Q2mZtKsUJtzJks5esonDgz5cNmQT1rfTRnO?=
 =?us-ascii?Q?lj7eCDaHxQ9yQMWQixp2NQrtyuewKArrKQLQF8eMBTS4SVEiJcyhlMJCr3l6?=
 =?us-ascii?Q?SvwMDRZWl8Uv7DPR3n+RKiGrTSffB7fcIhVsR8wmwv1cKZoSdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 07:55:13.3189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8329e6e1-8d2d-481c-bbe6-08dcef4a3282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

In MI300 series, doorbell will get corrupted in mutil-VF scenario. This
is a HW bug, see DEGGIGX90-5071 and SWDEV-480706 for details.

The fix is set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 in multi-VF
mode.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c         | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..7dd24b16d9bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1834,7 +1834,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_virt_get_sriov_vf_mode(adev) == SRIOV_VF_MODE_MULTI_VF)
 			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 					    DOORBELL_MODE, 1);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 84e8ea3a8a0c..bc2dcae9e823 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -549,7 +549,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
 					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
-		if (amdgpu_sriov_vf(mm->dev->adev))
+		if (amdgpu_virt_get_sriov_vf_mode(mm->dev->adev) == SRIOV_VF_MODE_MULTI_VF)
 			m->cp_hqd_pq_doorbell_control |= 1 <<
 				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
 		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
@@ -703,6 +703,10 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 			m->pm4_target_xcc_in_xcp = q->pm4_target_xcc;
 		}
 
+		if (amdgpu_virt_get_sriov_vf_mode(mm->dev->adev) == SRIOV_VF_MODE_MULTI_VF)
+			m->cp_hqd_pq_doorbell_control |= 1 <<
+				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
+
 		if (xcc == 0) {
 			/* Set the MQD pointer and gart address to XCC0 MQD */
 			*mqd = m;
-- 
2.25.1

