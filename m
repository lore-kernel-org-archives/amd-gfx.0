Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0362CA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 09:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110AE10E59A;
	Mon, 12 Oct 2026 09:50:23 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE0710E59A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 09:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6dCqMApyAxEZJoBaduW7d9xaEw9aQsYTeJ0d7vNrcV1BmSHn3YAh8I1+/+Kufid8bcr8KoZuHf/Ouj/dtY9eT4LF9DuCmO620x6jl+CzFFtUIzpyQ1Zxb4rXSBrJ8n9sPp6A67ATYYBZJaoVOjJm5UKMGSCFKz0QUKLvsUgtob7VjT+dO4acTIseGW+b85HcmWHLfP4nRu3eahzmJNlSl8mfk+VWE9WEgviN6qS3doHgWxGZ7m40aFJC44Wv/fIruLHE3xloptzVr/6VZMr++XjY+n0E0zHnuPh9wYinCMECJw5l1IKGIyPAwNphhGDEjM6FcWv7qVCKC02QFv/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wWTET6UgcAmWbbC/0R4K9+3CEPPjA03NZXFZCZ8cxk=;
 b=tfgAiLrGokPrizJTgreE+GfUmUmAFII1vMblg5vSTh5o9bNAIOTTRIgeUQgcbqa+gLAnQ65UrXhHQGFbPxPUOn9KdZRciDPuV3WsXawTbnoJYgnLxIyFqxfzmDZSnHFv0FVBfHj1EXGTtdV3OEBvQSn0mYgw20Jrn59P9FRbAVRwXH4w1yRnTaEmlyRtkniNlR2EkbmTmzVJkbTDh+/a4MAdW7w3aZPjvBtoqmnFhFjbmx749Hs5SCMF3KflwIogW/CwP3kPVez8UJ+ZJ/MpVsbt/Jm1j1KagA8qcZtdGDSb3A3OTl20vnGBNitAnlUcx1MuX5ZlNbNtBCpF0dPmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wWTET6UgcAmWbbC/0R4K9+3CEPPjA03NZXFZCZ8cxk=;
 b=WxazFMWB6ecsEdtBD+a02QVdyxSehEfDVKLYLq5xCyaDQiC6lqhjVe2+egDlD3zXU2D4YR9MOI1oluAryfIZS4KcDomuSTiMGL+c6o+ktXCZpr0kyvvhgzjX9n23KaKdc1bWr+f05ZiV0yxmCl2WsTU9jgYBV+VTVXZZaeejYG4=
Received: from BY3PR10CA0015.namprd10.prod.outlook.com (2603:10b6:a03:255::20)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:48:04 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::51) by BY3PR10CA0015.outlook.office365.com
 (2603:10b6:a03:255::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 09:48:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 09:48:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 04:47:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 04:47:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: undo the halted activities when the HW reset
 is skipped
Date: Mon, 12 Oct 2026 17:47:19 +0800
Message-ID: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcd82ea-f892-462e-3af6-08df2845e912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Jz46xwZBcZyghKo8ldkDBm+/sL5QvbtIy5fadbkFIkjgNMnGNib5W4JlMUByZyy99TgyHDBE5ElsHdwmeCyGupA5a34XUUUWvp2wJiqGkXNtHeuk7i5cIixDnzslcEs5nfsw7WD84W+JVFtE2CcWAiie/QfAp2WSa0k4qk9pQDrE4QduK6LRTbz37zHVdxr0V5lZJKjiRJimQ9X4N3HdNLm/dVXftH7XRUbuUtKYxDz88M9s+4WMEModbOTCnh+z04mQjv5vPSIjU1XlqMqj6Wiik7eF7U5Z4Lnj/etGXjfwuWmGhCZhJZFY844mOUOZgEk1d0ForeKm1DxoCAtszReUDhxQrNZBt7oEnq4x07qKToXYeHbKUNYnSIHpzIukzlg0e4EqYrSLYH/9xJld8BGZ5e4HvExmKdcw8wlqdN4oEjl9vb8MeFa2swZ2IXJascGoOaSlTzxbGp1IKbiwrycZhQKDWkrAvn+L3A5RxvxAw7InqjDgQh5He77AljkcCh4RZyM+N4tUHWaw7pASyFwcmAAu+iTo+ZJgaRf4a3LsYClGtRMhnlPb2/hJzECN6b+IekLsoWB+FFISv84JV/UWSQfhS/gtg5M78AgU/cKR2HnUJMO2FBkubzL9bULcCnAVQndW1XLbuL//xDrET27PWbJr14lMGX+wBlXKZ1wIOTGq3hqbTV/qXuDdLHH/DROKbPJ0I8NOaQMe2plILA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QsshTpFeatqk5A8nFQcZbBmQA8N+1u78yLqLQHkpUausSAg7+cBuCY5P3xIfSmUkU9NrQ1E52PHsRGUv6BE9sdf1Pq0uBWtEL20XT2P1Eog0QDjfP/XBSRZOYNdYyiTy1JqIhwhH9O/+wSGJt1uVyAcdmgCoySwegrgWnDDyGROkOoVritDgCWlvGsNyRrdeXoX/2LGBJv0JTszDveXetfpWsmlWsasPGZ6UBQ05M0mhrMxZFCoU4XjHkU37rciqQY2Lbv7jCZBb/hDq1xmwgK3puGDfv+sQIg75UtTVD6I4Vxg68rOxanGHVfE+TPueFUzAE+2Gtev5uRI+PO6Pcbt8sXdbhB4E4CroZ6oDfM9llbEBcJZhZU3Lyc5iXJ8JDGFwmToqTk5/zNHCC/v4xZ9gTY4N3WYiPCS4RXclsIBpTY7jw9nQVchGbGn9M/9Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:48:03.6739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcd82ea-f892-462e-3af6-08df2845e912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA
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

When the guilty job has already signaled, amdgpu_device_gpu_recover()
jumps to skip_hw_reset after amdgpu_device_halt_activities(). The
following parts of the halt are only undone in
amdgpu_device_reinit_after_reset(), so they stay in effect after this
"successful" recovery:

- amdgpu_userq_pre_reset() unmapped all user queues and marked them
  HUNG; they are never mapped again.
- drm_client_dev_suspend() suspended fbdev; the console stops updating.
- amdgpu_ras_suspend() disabled RAS on all IPs.
- amdgpu_unregister_gpu_instance() dropped the device from mgpu_info.

Seen on navi31 with ring and soft reset disabled and a GFX job that
completes right after its timeout:

  amdgpu: ring gfx_0.0.0 timeout, signaled seq=3, emitted seq=4
  amdgpu: GPU reset begin!. Source:  1
  amdgpu: Guilty job already signaled, skipping HW reset

where tracing shows userq_pre_reset, drm_client_dev_suspend,
ras_suspend and unregister_gpu_instance without their counterparts.

Undo them on the skip path the same way the reinit path does.

Fixes: fdafb3597a2c ("drm/amdgpu: fix MGPU fan boost enablement for XGMI reset")
Fixes: f1c1314be429 ("drm/amdgpu: Disable ras features on all IPs before gpu reset")
Fixes: 565d19415577 ("drm/amdgpu: add fbdev suspend/resume on gpu reset")
Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0014611f039..753df841be15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5565,6 +5565,25 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 	}
 }
 
+/*
+ * Undo the parts of amdgpu_device_halt_activities() that are otherwise only
+ * undone by amdgpu_device_reinit_after_reset(), for a recovery that skips
+ * the HW reset.
+ */
+static void amdgpu_device_resume_activities(struct amdgpu_device *adev,
+					    struct list_head *device_list)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		amdgpu_register_gpu_instance(tmp_adev);
+		amdgpu_userq_post_reset(tmp_adev, false);
+		drm_client_dev_resume(adev_to_drm(tmp_adev));
+		if (!amdgpu_reset_in_dpc(adev))
+			amdgpu_ras_resume(tmp_adev);
+	}
+}
+
 static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 			      struct list_head *device_list,
 			      struct amdgpu_reset_context *reset_context)
@@ -5806,6 +5825,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		amdgpu_device_resume_activities(adev, &device_list);
 		goto skip_hw_reset;
 	}
 
-- 
2.50.1

