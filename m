Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF159C52D1F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD1910E84E;
	Thu, 25 Jul 2024 15:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V/X3ZG0b";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5526910E853
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY7bOFTwBVvTQ7qUJlxvcubL+EPK+xRGa8/MmJPgPycYWf5odjKqqUWKBySlIyZX6/rXBx+CAIhzNhdbxDCSeJRFtVCWKnUV7vdhKystkp0qNCGrVFsn2bmYI+0afJqBpoNE183sqHoAVsQk0IypE8pJzZKMNVnE/WaLVkMrvxQ17bHXntTr0CtslRIQaHCIxJR3zG0pzIGzOCn07BDwyXS101orJiNaru2lh0lviz2QsyjHumTlytQfoZAG5LTVc6rSZlxif1tGAXcp81k0A7fa8jlRt76+imsSS+cfCt+yLSURlWAVyAwcGFd4leS4qt/QyuOipov+juoUCNCDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OxtzGvkEJUGQGn+Fts5CNy81mkAOo/qty04SElX7hc=;
 b=PdlcIYiRUJLO8QYb6TvgwVuqc7d+cqXdiuV1rGo/trMvpfJ3hxDgnmMrXC7Zsp9csMF2jBzYpCx3xbyrLr9VbsJydyNdjk67Jla8IA0Vu71jhPFVWaaoPNid9tmfSovxunWFBkxKAPbtgC3ORFIcV0vQ7MfppGFJcLou9ZQXF2WbKnd0xZTzb1JcbLZVou2tlYUaLvHNQRLXH0DAI15YapBdgYLk4J7NpuqENQqHCRWcXs4S7xlAnea2kvneyRSR0UwbaarthYf/N5gIZvn7V3t7uw9HH+L2xYfCvxXBWrjOddMHJDktT9yAZhht0dsVay3sBzVNzhdW8F5rs5dJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OxtzGvkEJUGQGn+Fts5CNy81mkAOo/qty04SElX7hc=;
 b=V/X3ZG0bSp2pX3oFckgOl2O5upahejya6r27azsbnhtyO/hB1WeFioJiZ4QC5X9lmdxldhJyy4vFNgq/pxslzQhv/AUFunxo9OhueBzCo5ZsybVxCVmnH+AwhzZ7cVKh0y/48435OSEePXc4UdezDmEkYanaB/RIYCxldDUb0Xw=
Received: from PH7P220CA0106.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::7)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:28 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::ee) by PH7P220CA0106.outlook.office365.com
 (2603:10b6:510:32d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/53] drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
Date: Thu, 25 Jul 2024 11:00:34 -0400
Message-ID: <20240725150055.1991893-33-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: a19ac4dc-7ade-4759-4813-08dcacbaa8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XUNAH8M+iU43WZf+xnyF5o2nWbQPC27QeKeY3U7M+diV/37ej5ZY9vQQLro5?=
 =?us-ascii?Q?0Epr4UBvbxsGvIKRtpcpkNB6QomuvTNeoIGPrAk17PcQXM4oOeC/lpqFM7ho?=
 =?us-ascii?Q?WuGZsqjLKBLL51BUJwah+U9jmpGIKjonUg3tXE8wOJxSxA7taGV6+fasSu80?=
 =?us-ascii?Q?pJlzZdZrNYny/EyyKEezYIPRPZTbTqOEGellwVUGZcii4UEvdTORB9iP2H+P?=
 =?us-ascii?Q?mlmAwqT82v4FQZpjRS9Bhx96DIN4bH96K3T3JGDmdNPT92PGnninKxu+Kist?=
 =?us-ascii?Q?qJw4g9T/kY8sCk/aCwkJUckgtWCDVeWlEYU+eGgzIsQYd6t2TNk2tS1j5lzQ?=
 =?us-ascii?Q?YYI4UDD6a1KsSrj/Sj8dcvQrb6hpVdit2YuWHxEgtuyH3NoLnDGYS5dkS6Jj?=
 =?us-ascii?Q?UpgnNnCroyM1jsnUDxNnB4/YeaZGS/6SOk4aC3qxekoUAf9BoTmWoLfRfMoK?=
 =?us-ascii?Q?EY2GtY6+T67Ko7jdE3cgU4aVci2vHcpgL4gw1TX72sFRI4WrgwkKQVusGWdk?=
 =?us-ascii?Q?6sAp+hdKBNivwFInmh1lBIwNTDSoTSmvO2s57XhVeVXeRzQddJEUe8EjS/r0?=
 =?us-ascii?Q?UH6AIKp/+GxY8hnrfCMZjIHCwnexgI5LBskbNP1cz+2NeExKqzh2pIfkM4Jx?=
 =?us-ascii?Q?cdWW95DqnyifIDg7HIvOxX7MlDwEjQYqJRhSqKEiCNV9URYnI+KveOkspDH4?=
 =?us-ascii?Q?DmqAmbmL04BBpW1S1QeQy00Vcn9pEL3iG8iZFJzpUh+N1XE1GTViWXalrLL4?=
 =?us-ascii?Q?VHx5voX94XsfEpkPuLs5QwJ6rOgHZ4qU42VaInzumjFibReOJgqI5Ld49RVl?=
 =?us-ascii?Q?+RDQ4PgISAYA1ny+X4mUPR5Jln1kfVgICVKZcj2mgr6ZjgCXSeBySC849dcI?=
 =?us-ascii?Q?yvY0so35wNtdKCad32I7IlYZNwPD77tQlaHonTzsvoY8NUkL2FMpmMNgMhoa?=
 =?us-ascii?Q?Z42kUgKweejnsp3gZ6j0tixSHCFj4EPIJsI6kNELUOmhnGuUoycw5pSbJcVX?=
 =?us-ascii?Q?WMJ4cXOYr3cifHFbJIiJ9JkV1SFD9fXASVQVlzcPw/ksl0xKFZLHuGCN6Wwz?=
 =?us-ascii?Q?UCFUrVYM3oBjYiW48qGdA02kltS8xL30cZsAwElS3eZjg4Dspg5J661h/oUc?=
 =?us-ascii?Q?E0VcqC0yHC3EYoMjqo69y5zmgmpvC9tUm7zKRP+CVaFgDzdRz0ey5NRIi2ht?=
 =?us-ascii?Q?kcJb4c2FBwhVs8XKU8VUJGhOHrZpYJ1EJB+NKl89/4Ui0XenFlS92y4QVR2l?=
 =?us-ascii?Q?CGLAwv8ei+znKF4wSjs1K4MB9cSqMEDsdhOcgDTl4/fLE24KnyzmMsw1mGvf?=
 =?us-ascii?Q?pDrMy8V/0h2M7Y9TpIQvOzP9GtrNs/u04k06w82QF44ITLDccrjHjZwHAwXl?=
 =?us-ascii?Q?P1r12M2epDqymIBH9hwhspp0mbhq99noXE+x9e5OYHjt7HhsbMGUifYBvSde?=
 =?us-ascii?Q?6couzTOx84DJbE3duCzRZFp+s38IfK4P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:27.4059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19ac4dc-7ade-4759-4813-08dcacbaa8cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

The reset_queue api could be used from kfd or kgd.

v2: add use_mmio parameter for mes_reset_legacy_queue.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 950c26ee3fb8..0bc6ce26ce45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -817,6 +817,24 @@ int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
 	return 0;
 }
 
+int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
+				   int me_id, int pipe_id, int queue_id, int vmid)
+{
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	queue_input.use_mmio = true;
+	queue_input.me_id = me_id;
+	queue_input.pipe_id = pipe_id;
+	queue_input.queue_id = queue_id;
+	queue_input.vmid = vmid;
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to reset hardware queue by mmio, queue id = %d\n",
+			  queue_id);
+	return r;
+}
+
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
@@ -874,11 +892,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 
 	queue_input.queue_type = ring->funcs->type;
 	queue_input.doorbell_offset = ring->doorbell_index;
+	queue_input.me_id = ring->me;
 	queue_input.pipe_id = ring->pipe;
 	queue_input.queue_id = ring->queue;
 	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 	queue_input.vmid = vmid;
+	queue_input.use_mmio = use_mmio;
 
 	r = adev->mes.funcs->reset_legacy_queue(&adev->mes, &queue_input);
 	if (r)
-- 
2.45.2

