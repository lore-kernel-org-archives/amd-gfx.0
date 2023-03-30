Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D487AC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C77E10F006;
	Thu, 30 Mar 2023 19:49:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2E610F006
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViGokRR5HWi6UitlH5SMNEOb/U/pwUpje1c9QQKKFO1GT7BCOfVftbpc68EA1RZr+akWFijnSW0Cvhz4zXb2JipUOANlLF22+JHasjFsdpY91kSZv7VU/ChElCfI8DPnl0vT9LUrk33aOWFDqQHcIvA6LNB/5GUA9Z/x0X3+CgYL10zix7LqDQ9mJxYSNA1PTi9ucZ40LEHBookbDOpdURDfUtvvmRGCycY2UPdeQIwoy6dZY5K23nOtly9PWixakaeam7yWuVKv2bMKeJZATv5/wAHuy7+7MJDWSsHe+Xc04LcGV059XKDymP0LNAJRAaOA62F+nUayIPBngkq/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRXShgbalLjeEJ7i0FHc+TC0JXgtKP0tGnSZ1qJPBQo=;
 b=helLY0KMJb3mrO6mJmT3yzW1GmE0KHN8hg0NqR+hVn2S2i/95VMtBVR7FPbUrdMtt1XJZGXWO4y0hJoMbCekRjp/u8SxqO847IaiwJJ425gJjQJULMBhTiS3Jko/NqcfGPMCLwifJij6k3DEWfAoftXH7oHjC4XYjmtkTbr+GrbIpB1G3M/ya6WNa6osj3dFxd+OkLu1OIgz+klODe5bimhISKjF9Xx+7rFXbn9DEm++tXcEsaAqX48kug9rFB5t12Tz6UaAKZ9Ash5S/U566xf8DnzxZoocOjqfxLqraKuXkrN8DkkfLjn4OEyy2WW7vTRd6/Wu3re1a4JMMtRfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRXShgbalLjeEJ7i0FHc+TC0JXgtKP0tGnSZ1qJPBQo=;
 b=eXO0OdN8bn1Uf9OkWraHJZfNHOd44OEvDC2p3yfaKu1E5MGhLYsTFdEpoP2jtQAIY0M6ZhMlRYypw+DA457nzZbFDM/qainkLetEoqFQvMvEeetcxZugr792uCEcYa4L+sk7cXWm4o3WhPbkVKpjXs3LsGk77JpUlAYivaMqGE0=
Received: from CY5PR15CA0142.namprd15.prod.outlook.com (2603:10b6:930:67::8)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:48:57 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::e5) by CY5PR15CA0142.outlook.office365.com
 (2603:10b6:930:67::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 19:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:48:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdkfd: Report XGMI IOLINKs for GFXIP9.4.3
Date: Thu, 30 Mar 2023 15:48:38 -0400
Message-ID: <20230330194843.1136162-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: eb40f17c-ecb2-4a46-3973-08db3157cd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArTb7vOrCSw4GsNLjSKFFruoFGmDskha0lTRZKz4ZCvfE79Jz+b8bVWFQYFUv8iXkmpL+yCvpTXwrccfBham0WbxIT2Vazhw/ZgEWGb6vxWiM9Knnu0tp5qaroA0tQLvHa99emrzCa3ipFRrQsB2nG4kx5GVV3ZGTKOlkiiC2JdwmJiDi2babQ21lMlP9PXHnmjV7AGkZSPywbHd3LGf6kK4sSV/qN4JL5omfUiIQVgVyggglLtHURqYavg7UXo9BO1dRWrMDrb6RRvDpzx9gQfg5sMPvPilF3BM/1qsuO75rmvtCt9QWUMRVasCHO2aXlN76llUg+P+GCM20LzXdT+9kJx5zPgCFI7iFICyLt8RBF+lFGv7g2ZEGJRTnd2gXfWSi5fP3Rnm2LplFjrsVVin2B9WLGEVmWKqFcFSKAjLjYnttyEu4NTrkPrEGojIZD316fyPHmgpIoaJyj6LN+A5ljUuf0h+cQQI+eV+9JLMtkR67LfDSwD8EMmje5YS9kIqt1sCUb4sR8+NfqRg21PTNL1knSON4g/rEylrKDW6ninAUPNcV+FXbMZnYR8LbRx/2OwRgGzRKI+OoqOQPzbv3yfvn/J3/+Yioinn0vmJg/c9hL/w29DnrkUiNhOBjuqD8nGPvxjjTxcPLidzWL2V141ZN3q+rnFickTLYw5o9pjliWOkQPN9sFYPpPi7cMHQR5KmvCXd0X960ATS0ttJQ4grs0WBb/NMfcW48NM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(2906002)(316002)(40480700001)(6916009)(70206006)(41300700001)(186003)(40460700003)(86362001)(26005)(70586007)(7696005)(8676002)(36756003)(4326008)(54906003)(478600001)(356005)(82740400003)(2616005)(16526019)(1076003)(81166007)(83380400001)(82310400005)(336012)(6666004)(47076005)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:48:57.4755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb40f17c-ecb2-4a46-3973-08db3157cd15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

GFXIP 9.4.3 could be in APU or carveout mode but we cannot use the
xgmi.connected_to_cpu flag to identify the iolinks type. Use appropriate
APU or Carveout mode based condition to report xgmi connection in kfd
topology.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index dc93a67257e1..16475921587b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2005,7 +2005,10 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	/* Fill in IOLINK subtype.
 	 * TODO: Fill-in other fields of iolink subtype
 	 */
-	if (kdev->adev->gmc.xgmi.connected_to_cpu) {
+	if (kdev->adev->gmc.xgmi.connected_to_cpu ||
+	    (KFD_GC_VERSION(kdev) == IP_VERSION(9, 4, 3) &&
+	     kdev->adev->smuio.funcs->get_pkg_type(kdev->adev) ==
+	     AMDGPU_PKG_TYPE_APU)) {
 		bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
 		int mem_bw = 819200, weight = ext_cpu ? KFD_CRAT_XGMI_WEIGHT :
 							KFD_CRAT_INTRA_SOCKET_WEIGHT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index d3e70341dfad..5373a79ac6a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1327,9 +1327,8 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 			continue;
 
 		/* Include the CPU peer in GPU hive if connected over xGMI. */
-		if (!peer_dev->gpu && !peer_dev->node_props.hive_id &&
-				dev->node_props.hive_id &&
-				dev->gpu->adev->gmc.xgmi.connected_to_cpu)
+		if (!peer_dev->gpu &&
+		    link->iolink_type == CRAT_IOLINK_TYPE_XGMI)
 			peer_dev->node_props.hive_id = dev->node_props.hive_id;
 
 		list_for_each_entry(inbound_link, &peer_dev->io_link_props,
-- 
2.39.2

