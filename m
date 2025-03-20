Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F25C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CE110E298;
	Thu, 20 Mar 2025 16:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xU1K1Yfw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4F310E4DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4SdgYMA56q0x4FOR/a/YEW14ppNQ/C58uO2ohjniIiAVt6vPuA9bf1g33iyUuGIisnvZanT3IHbUZDwo1BFeTwaqQJ0osOoCbFZnKOmipG2+T1FIUGOS2fN284/VznTjpPQmPmaHD5H3IydyI9EvME+GL7ksXz7hxyeReuNrjtYOjSOAiS0SqCYBOM+D2jKacAMsCTdqV0fp4DZwFBVQ2eJWESxKHEaZG/3Ml0bfI849sR7oGf0qQJyJsPi9dXcCg/5EFrNLmoi43wWLCJw7ceheEXgWStp16hc1Ju4RDYWrx6L2AfHAfyTBDAeaBWles6M23TdHMpbMasnRQ0GBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KbDDqGEcxuKNxF+R95wIkodYih1iGJBzfBgImUMhs4=;
 b=GVBxGdXT4BMK28hTNvChC56jB7B/XJfCCsw1aQiGKqrweieotW323+d4ea5BJ451bVlb8R7loCfCLPVi6NDSg7h7qz3OvSYdeMXlRSTyFwox1y3iSJhDhsNka+d8sNHeKM8VTsichH+U/6L3aUU1Dl6t0vXB8VWZo1Ubw8184FxHn3mnvmhpqSYWskN0S+xFAFq21aq1HhkTnb4HBQMyNBvl1qMX+YT4w4geA4KxllEN0MkFjRzkT6sDxELQH5FOKNpgVoK6AhAdMFbBjwR9hzgq1l0Cbck97LbAq98KqxMx0/6V1AKchLftOE40tPeWaKM1jJupSJxZi7NV4kHtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KbDDqGEcxuKNxF+R95wIkodYih1iGJBzfBgImUMhs4=;
 b=xU1K1YfwT2+Lt9snYBWgbMpo4ApXycHcsmanaOVzMCrSk48UoTUFXu5gQeKO6rJ84Xye/dr74IcXaHY+UCjUuaEfbpYmUC3HNTqcZ79K5W+ltkFNL8W+02RIXjY+lEcNKrkfxO0VMNuJyabekuQ9fKX1FEmijxTYXsTuXbhQVKc=
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:53:07 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::fd) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 16:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:53:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 11:53:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Arunpravin.PaneerSelvam@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: prevent runtime pm when userqs are
 active
Date: Thu, 20 Mar 2025 12:52:49 -0400
Message-ID: <20250320165249.1238463-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320165249.1238463-1-alexander.deucher@amd.com>
References: <20250320165249.1238463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 4789648a-8fe5-4490-115d-08dd67cfaf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ta+ht0mcG94oq/3dRaJLlm//5xXseht44otGD5sZ6zk5HVi6dzPdACycVPlt?=
 =?us-ascii?Q?Uj36YIA79ZXKgubF3CG7NR3yorzmHbWcR37e2Lig0DMM7ED+29I+traSgb0z?=
 =?us-ascii?Q?r1BGSS4FtnxrRpJTD0sszctr1OEt+WzGGoXIhSVgcAF7ZUaTgrHNMYoqe4rA?=
 =?us-ascii?Q?Aop+Sxw57kGapeWwbidHl2KzfnFAB7S4I/6VVK6ZJ9nVIyPRot0sCpN6Emxu?=
 =?us-ascii?Q?9jHljb9erNjp3RNsSa39jQUAIqrHjHg/Xn33C/wT4DX5a5+N1MAbcDDnmDYt?=
 =?us-ascii?Q?Yov19wyr7toANtEUMcKE6Cjky/eIBpwLucX1O9/Sm1lfdBhrS1Zyos+Pxjsu?=
 =?us-ascii?Q?WHDMmRYul6qv345xzQ3E4rv4EtXlZwosy1DUe7B/AG0nK4hs3gkTPClKRKPm?=
 =?us-ascii?Q?MN0bKj/lQjNQehttF6VK3QxTkfto0ayA4TtMqxCYASxCxs2fgB45Ia1jJDKT?=
 =?us-ascii?Q?+xuO6z6G47a5nJw0FxBNyXx1w+r3F+5uEYKw7WbWyET3sJVompQtYWPWiXKu?=
 =?us-ascii?Q?Y4xMElbm52MoXL7/qs+G2c0L2iSm0edIQAianJngT6mZtkCButsYkrddNFXU?=
 =?us-ascii?Q?c69/q06uVyeiTKzDxTMa2520ngAPxWD3Idu6SG/3ilWx71ae5qqixq0hCpWk?=
 =?us-ascii?Q?WZf4Q9+K7OyebHwiguX6N25oc1kVtEKL9Sg6w+SgpuBhqp7nBAxoQnLHPpfg?=
 =?us-ascii?Q?aNLvX0DcDn0QObK/UzO2bxiD4jhUb3uFdP/PYBM6MZ8pr8bmc69irg/4kbVl?=
 =?us-ascii?Q?DJTaBackmWd+Ccrk4hd95i70C3ZGvhMwglhiFAcMpgt94pR9Z73mW/Izn5cw?=
 =?us-ascii?Q?D9sV9sL7BWhURceq2IFT562tVJV5tLlgZqRq5rs6iakiy9xLRI+Weduzol/U?=
 =?us-ascii?Q?Oj6JpyWZNSLeTdOpEqF0KKPYVrDeXaVb1BmlJZqMdbBUWkCYVMYgjRXh1CMF?=
 =?us-ascii?Q?RfzwCDOoncivtTqbnzc+n0jo6aWiXi/0kYtXF6+oIvBIVswB8xiiPV+ir7OF?=
 =?us-ascii?Q?t5DnKiQAqRk3I37CIMUx9cGK8EbXsDCVRQifw+PQDapQuXtrBm2b79quu4BJ?=
 =?us-ascii?Q?QxIx6odbTB1i8VOLj0IQVbwlORCVNbKS4bS2eoYHgfTh1jZTiMatmIQkcYTY?=
 =?us-ascii?Q?vraxQoegqAthAvPJxcK57Dvp0JEdo/IU2Kh1Jpe3ehWx2TTQ8wEGTX6/GFkg?=
 =?us-ascii?Q?b2v4zNzdN3wg6IQYkpxSzylYza0iCmLkCm7JuaOJJzL5y4dLGE2h2vC6Q6wO?=
 =?us-ascii?Q?UmlmeEkH7So/CXqtPRqns6ykc11g92z57KGHcQiI0qWEgmckhSp6NbVr3xXP?=
 =?us-ascii?Q?Rfma0dQai1lO+MHlESgxqmAiaAytdH5GVEo4HWtQLeeuNkdpn1D1W+YCAsog?=
 =?us-ascii?Q?hoXpnWrXta+lDIizF1FAZZqUXykTF/gX6nhHc7o7mdA6J83lr6bKfnf/lhRV?=
 =?us-ascii?Q?7+3qv452Jm0NnV/dWuNA5+bKd9btpfpRHc1MEbvBGhRg3CmYH65YDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:53:05.8141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4789648a-8fe5-4490-115d-08dd67cfaf9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

Similar to KFD, prevent runtime pm while user queues are active.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7d49a0bede1e2..4ff2e423c50cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2705,6 +2705,29 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
 	return 0;
 }
 
+static int amdgpu_runtime_idle_check_userq(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			ret = -EBUSY;
+			goto done;
+		}
+	}
+done:
+	mutex_unlock(&adev->userq_mutex);
+
+	return ret;
+}
+
 static int amdgpu_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2718,6 +2741,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		return ret;
+	ret = amdgpu_runtime_idle_check_userq(dev);
 	if (ret)
 		return ret;
 
@@ -2841,7 +2867,11 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	}
 
 	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		goto done;
 
+	ret = amdgpu_runtime_idle_check_userq(dev);
+done:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
 	return ret;
-- 
2.49.0

