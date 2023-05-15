Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC98C77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 20:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C800210E26C;
	Mon, 15 May 2023 20:15:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D6B10E269
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 20:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2fWDXdjc+RcebCNTrYbGnXcC73qjyOUV2Y7MM4sOqogPJLgnUm6jzzhI4aIK7LFFob15inZKoZzIuzA0oYPNXCdsUKSh2Tndt9G/qoreAxXzkXGmfWYESd+bqwXI/z2LP5+bNLd6HKCh269LPjeCZPEAc72L7h+E58nEem73/omxySAv92K+cQaUcs6xtk7ESq/9IZjqSIjWiwWmN24SAAIn3AQJysnhTU65JloSr32lHV2Veyp7mwQD4OHj5Dd/gO34P0jz1fZnR8b+5zPWamjVB/EAiB5NIKpJLcyei0S7WDU4LAUm7ck8kmCRafZeaKab6qV1MSDOMgyrTwcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+gBrOgN4AUqqcqtnWpFV33eCySj/jbWbnjlXmrkBHY=;
 b=QBdZx9kM+XkiTQKJI99ZEw5A6wfb5AHOtGpoKFcqscIPjlbBhlo0SIarn/6kLwi/LBSUQr9P88qTvPWKgYc5xC5s2ks6fnGpxZj+DVGKxk1+sv7AydafGiKJ07E6Wr3aV5tsSSSKovDzyaLZlJGv1o6pEm+xpDfRmiSPo0HX7vbUmO5Lg1kryoYdbygfZRGRauNtCOKxr+tEi0Fushpuk+P/Y980VwmrBSq5Ia727vTGZOvKmTqB9EjvIqqpeBTwuuctbPfXVVrBljbMlQXmzAe48vRDGkQ7ZZdQp9tVTWEcVi6On64+6zUCzSvhEhtiaCNqQMGe4/q18D85QQ0NRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+gBrOgN4AUqqcqtnWpFV33eCySj/jbWbnjlXmrkBHY=;
 b=sfLXzicTjeGOgP7btscmZsgs33nr2oGyEDK2PE5//DDXiyl4Rj1jpJ0z+4QNnTf26BVGVFrSCZmY2GDol6c2JJJ/UA9iRQESB1YIkFfYCIgQYOP17Ny+VpknpuEJqwttqn5wf2PvLFKmJDsxhMJTu2Rsr4ESMV2V7MGV+W6zyms=
Received: from BN8PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:70::21)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:15:03 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::9d) by BN8PR04CA0008.outlook.office365.com
 (2603:10b6:408:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 20:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 20:15:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 15:15:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Do not access members of xcp w/o check (v2)
Date: Mon, 15 May 2023 16:14:47 -0400
Message-ID: <20230515201447.2802578-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201447.2802578-1-alexander.deucher@amd.com>
References: <20230515201447.2802578-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|CH0PR12MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9ce440-fa8e-4880-35ec-08db5581115f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1+shj+Hb3NseMOYbQOU0QCxDq0jfF8Knub2RzOMD1oOnDLUJcM7aiBkiIzfA45/gBUzsNHbyrFUmOAldGehoBdvKXJOxn+fNB1H4RbUoJDqIIkAOpOLREdKAuZCKbK/2LJ/lQINEnzHkn3xWCZzWyvzSkvP1cKSrIB571U/n//L7qd1uSQxgbaKFPsjSpFxYzpEdC+lssjY8gfMZnRiopZS8egCDMm+u7EKDhEL96fMxoVWjEZRujI1W2rB+1kZvDnJdeNwONlv9TUhLNNnG5bkqrW4hc6CQ07/96mx4hw6+4nw+DTODK/dF8q72X3BL/Bs4z27GCWuliabEiSozxqmLOdb01nFmA6bVC711EWyVB+GAPhWqlZaNRSPxx136wfTq2+TUpNRjiURdeqTSdXZVsGC1D4dfOC612uVSBKJJFmLx+vdeFtuX8/rqvc5OHhl9X4fZO5+Ta3j15J0qw86E8U72Hnh8+p4GI1uQfzofiek59/J8queONXvNdcz5HjQaxHjfImamFfGHoBLPwsvaJh5/1a+mNbAIcZe1a4eaQXx+uvx82BEpwNLwQ5ftp0/VdCthhGKrpuCxamXTSbKd3r+dMvgdWZI2xMUu+OtC9TgpK3a01YsA0H8tHR95e0G4OP+1hPMrvpKJImWKu5TKxW6az9WSouERtFxrOJMqpD1/M/VEpZWcaCyLbc7o1Pnl05Y/gZFNbrS855sEM57+7jg4GWsVdzgSJKUQw5q3xz6FuI7ZbTbplY+t+EIMQ3kNUmPftQrpueDJVig6riIi5iXlFsAgUnFZ5CaY7ErPsFiRh3mn4CWT9KuhbFW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(70586007)(478600001)(6916009)(70206006)(4326008)(7696005)(86362001)(316002)(54906003)(36756003)(83380400001)(426003)(47076005)(1076003)(186003)(26005)(2616005)(336012)(36860700001)(8936002)(5660300002)(8676002)(6666004)(2906002)(82310400005)(40480700001)(81166007)(82740400003)(16526019)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:15:03.3182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9ce440-fa8e-4880-35ec-08db5581115f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Not all the asic needs xcp. ensure check xcp availabity
before accessing its member.

v2: add missing change in kfd_topology.c

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 85df73f2c85e..739eb7c0d133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -429,17 +429,17 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 
 void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 				      struct kfd_local_mem_info *mem_info,
-				      uint8_t xcp_id)
+				      struct amdgpu_xcp *xcp)
 {
 	memset(mem_info, 0, sizeof(*mem_info));
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+	if (xcp) {
 		if (adev->gmc.real_vram_size == adev->gmc.visible_vram_size)
 			mem_info->local_mem_size_public =
-					KFD_XCP_MEMORY_SIZE(adev, xcp_id);
+					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
 		else
 			mem_info->local_mem_size_private =
-					KFD_XCP_MEMORY_SIZE(adev, xcp_id);
+					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
 	} else {
 		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
 		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 48d12dbff968..be43d71ba7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -233,7 +233,7 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 				      enum kgd_engine_type type);
 void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 				      struct kfd_local_mem_info *mem_info,
-				      uint8_t xcp_id);
+				      struct amdgpu_xcp *xcp);
 uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
 
 uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2cfef3f9456f..986543a000bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -784,7 +784,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		atomic_set(&node->sram_ecc_flag, 0);
 
 		amdgpu_amdkfd_get_local_mem_info(kfd->adev,
-					&node->local_mem_info, node->xcp->id);
+					&node->local_mem_info, node->xcp);
 
 		/* Initialize the KFD node */
 		if (kfd_init_node(node)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index e0bacf017a40..8302d8967158 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1235,7 +1235,7 @@ static void kfd_fill_mem_clk_max_info(struct kfd_topology_device *dev)
 	 *	all the banks will report the same mem_clk_max information
 	 */
 	amdgpu_amdkfd_get_local_mem_info(dev->gpu->adev, &local_mem_info,
-					 dev->gpu->xcp->id);
+					 dev->gpu->xcp);
 
 	list_for_each_entry(mem, &dev->mem_props, list)
 		mem->mem_clk_max = local_mem_info.mem_clk_max;
-- 
2.40.1

