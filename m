Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80648C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 20:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A80E10E00B;
	Fri, 11 Aug 2023 20:24:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03BF10E00B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 20:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix8AQ22BxjovKGnO0S4Von3mu7vW7IPagrT3fjdq4YLkQI2EzrONOfTE9qQJX+pBaLTQAdG6Y7pNAstUA0q7KywjRyjQFGxhhlbjon++HfGM4WZu0O+rq/FEsDgG2piv1sJgbrJBP9fgj/Bf8d/pmRv+mLEu2OeF2xWt5HF4a6T3PoMoUAxnxdnmZIuUy18qGOi9EtjPpdPmtKdwi29QyRiaYq/j3xwdGvkLCq2zppVl15hGVcLJEXxMAI6MZaywG5c4UCXbRLplvek1Mj0D0nXkee/olPDqzAztxUk4sL8nRikwr5twePKgMykhDv8z3PggXsFcrR/wlrq6KFNxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW64ALzL+GNZfMqhBirhKtvsR0yt/smRGkGYVWxko9Q=;
 b=ZTEMsb4pqXiXLih/pKCuX12iozwUk/3JQeblneS00wYSkHc7GyNRcZKuIjywR6a4L/Gyff1ojNc6wOx4ZuS2vMiW3sJeVgikunmyvvYpwQxmxuOeM/EL1cOgtdh2Eg9s1fp1B8qpCE3EHCcKHRPNn1ywNP+jkySEuXY0Mh0yLp0vMlHUFpdvari0OY1BE52tdxTbESjE5QxHWw+H7RAveWSP0kt0kZIyVuZJmAHtjEbH3jnFloiVA01h96P+tZTYmoKh3ldTICSJ659LKHVdp5Vo4nYVhFW0yXKwOexKlYTR7J2eLOGlgrY0KSBXwZ6K5n81dy4XQCx9yMHXCM7Zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW64ALzL+GNZfMqhBirhKtvsR0yt/smRGkGYVWxko9Q=;
 b=yKf+FXTFvvesVOI2c8tT9Vm7U4Ny58lxGQHoLCHyTuyaIrQL2EIzeHwxPn9veC++IBcWdfyQ/6TgUBt1y19eh0rPVsZJJQXxzm8Hpt0maXO8j0D20z0cVkyDOkZIp73KqQs1iBWnaGfYuWvdIlZ+/HfRtMr9oHIJ7WTcLKLQ72g=
Received: from SN7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::28)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 20:24:00 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::c3) by SN7P222CA0001.outlook.office365.com
 (2603:10b6:806:124::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 20:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:24:00 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:23:57 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: skip xcp drm device allocation when out of drm
 resource
Date: Fri, 11 Aug 2023 16:23:37 -0400
Message-ID: <20230811202337.1867891-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: b12cacc1-e34b-4ca8-ef9c-08db9aa8e5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcWL4Yt1BRWi36rQq1qP4aqNrHDDBv0VgPtQcA7kDXggquIjxiqHkBvTkhsfqgZ8XwisGKrvt4mt+d5Yh4moImhJx8WvCSOc91YbCA8RS+/wYRhSNv7tjlGbHeZ9p44DSjsd8eTtPHh6kYm5fIGPBroL75E/j6/X8mbflRJu0LKIGYUpNVxgTTH0bMbBRpr4/Ha6fhHGJ1vueBxCOQONSN4FFQGGOE5F6mZf6bPomzfZcztRCtWlci1v1njqjTaWV55h5DGgQ3DSPCkk16xLIk1McLXataSVIDbA3QQBTyXKALuWQYaoCtMn4R/cfF4pAecARrFnqZt/7rab+Sv8u0hCb9zr+G+f8CNhq+CZeHSOgAv/bvLenjOV3E4dAZcyAuyeOKgzHlELrV0xW/rJiokNicbhx3aRKF75r+1NBJt0xEARBUwN3oYtQ8M5ETRhZlacIJw4N41UeMMixGEWOBrOT+PZH9IToansucRSwbnqKwfwaoBiXYt3NF17PW/KkY2TGSLElud9uUjEVcQH8r4yfUxpZD1N1wkTvTIfq+32snDxEPSrdEdMNiCrq/OA5MC+BQhAK1lC9A11pAgD0Tyauc5waoW5AKbe4lZYydnV5djbl2kUitcmWfhzd2mdIRJO7RUO9Qh102MR1MnJedjjTZqzRg3oZPVoS/UvOti25QQJP+fPGQMIYxCGou9sTWR5lNVYJ8uD+Av3xFBwnU0lwwUEhkPVIgXf490sRgCE70vUo/5VQneQA7455cf9AIjzudi/hxsksoi+Oi9cSO0/EjbgcROGu5NUP9+SdP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(1800799006)(451199021)(186006)(82310400008)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(70586007)(70206006)(54906003)(6916009)(316002)(8676002)(40460700003)(4326008)(8936002)(41300700001)(966005)(6666004)(36756003)(7696005)(40480700001)(478600001)(16526019)(26005)(2616005)(1076003)(66574015)(47076005)(86362001)(83380400001)(36860700001)(336012)(82740400003)(426003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:24:00.3487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12cacc1-e34b-4ca8-ef9c-08db9aa8e5d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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
Cc: Amber.Lin@amd.com, jamesz@amd.com, Harish.Kasiviswanathan@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return 0 when drm device alloc failed with -ENOSPC in
order to  allow amdgpu drive loading. But the xcp without
drm device node assigned won't be visiable in user space.
This helps amdgpu driver loading on system which has more
than 64 nodes, the current limitation.

The proposal to add more drm nodes is discussed in public,
which will support up to 2^20 nodes totally.
kernel drm:
https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/
libdrm:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>

-v2: added warning message
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 9c9cca129498..f0754d70da5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 
 	for (i = 1; i < MAX_XCP; i++) {
 		ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
-		if (ret)
+		if (ret == -ENOSPC) {
+			dev_WARN(adev->dev,
+			"Skip xcp node #%d when out of drm node resource.", i);
+			return 0;
+		} else if (ret) {
 			return ret;
+		}
 
 		/* Redirect all IOCTLs to the primary device */
 		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
@@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 		return 0;
 
 	for (i = 1; i < MAX_XCP; i++) {
+		if (!adev->xcp_mgr->xcp[i].ddev)
+			break;
+
 		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
 		if (ret)
 			return ret;
@@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		return;
 
 	for (i = 1; i < MAX_XCP; i++) {
+		if (!adev->xcp_mgr->xcp[i].ddev)
+			break;
+
 		p_ddev = adev->xcp_mgr->xcp[i].ddev;
 		drm_dev_unplug(p_ddev);
 		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3b0749390388..0f844151caaf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	int i;
 	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
 
+
 	gpu_id = kfd_generate_gpu_id(gpu);
-	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
+	if (!gpu->xcp->ddev) {
+		dev_WARN(gpu->adev->dev,
+		"Won't add GPU (ID: 0x%x) to topology since it has no drm node assigned.",
+		gpu_id);
+		return 0;
+	} else {
+		pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
+	}
 
 	/* Check to see if this gpu device exists in the topology_device_list.
 	 * If so, assign the gpu to that device,
-- 
2.34.1

