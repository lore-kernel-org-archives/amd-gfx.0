Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA03C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 11:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D3610E05E;
	Tue, 14 Jul 2026 11:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONTazWSi";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D490F10E05E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 11:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIyBdVhpk0jBNDFY8zTkBHWYbtC5xAi7Zj3xNxcmQHvrMkYdDvL4NILlPI7QBk114oe4Z6GTbXQlQ3ApGExN+yBhGd3J58tYXjvxW7bqF4uWN+7EjDH6BUshd88ku5VNboRkxjtGoSygkQmZW+uPaIZVrRwKrept0YtcEtzM2UWVM7MXDpgHGDFz4zpjUmLIla3ozxkGS3Fmo2plpLxi/G6m0Btp3aVYvBNzKL3psT75D7L5E1tYXtmVA5fcZujBBUqa+m3+UbVmGnWhNza6i+UXoJv21F0UH/kWRY1iv74vWbjrzD672WkDqJfJsRs3V1e9uQbMy7w25Gr+N0/ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKraNbbP4UZ/J4QT9iAEvL0EsigbQbPTCkTJg5PfinE=;
 b=uMyn6okJnzVO+AIbvVOwQ4MbYQnOSM5q4IcGJ45KKpZVRc5dkDcUfGPbTEzguNUNGwr6ZtPshpCxc7cRiB4tQe5eMvpgf1p8qzTvtH+bASdV3Gick2TDn0NPiq3x+9FCdqmJ7mdJ6tUV+1O3Q7Nc6giQP49jAbpWicZ2i4wNoMMgjZ9ACtrNw9h01u+rUq0lxrqv0Bu47l2iaTq0XrhMi1AY3ocIETXwk9F5GemPqCd4l4aGfQeD1JCZ3o2iqPoN3QgzAHymQSjxFUg3gCJfPQ9RGSogr/83rJDuqMDFzaJCnWU4tQhYrCbLNJcrG0VYRh86CTC6DfAdWVdYfF/+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKraNbbP4UZ/J4QT9iAEvL0EsigbQbPTCkTJg5PfinE=;
 b=ONTazWSibHaTVaQSXBh0pSZz6eXtpmKETLd6Ue6ppL4yb2Wj65nXOvUfG2KfTUrbzvW1InT740IxLf33IgWwSoqB2X/sJ7KWOl2CSr1/TEPjnUFG1vfPe/47uWs4qRh+sE+8UrRSbBRvMRwF+5EP/tr/q2nLXTiYi12VG9Vm168=
Received: from SJ0PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:33f::23)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 11:57:46 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1d) by SJ0PR05CA0048.outlook.office365.com
 (2603:10b6:a03:33f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.8 via Frontend Transport; Tue, 14
 Jul 2026 11:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 11:57:46 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 06:57:43 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, <Lijo.Lazar@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2] drm/amd/ras: initialize CPER after XGMI reset on init
Date: Tue, 14 Jul 2026 19:57:14 +0800
Message-ID: <20260714115714.84800-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f41bb2-848b-461a-e1bf-08dee19f1ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gYwxOzPwPjEWC2Vrc8b0gniWl+JYdzrc9VUyPDqGZpByAlUZ43c7id0Ba7PEFy/NuuOWpvNfPqb+dskTdO9npW59q9ZmEIQYBPj9VIabVddAjKDB6yg45N1PPczS+jROvS2UHnN5WqOfS4Y8bTZpanWqhZTfmq3z3JM+PyWIDueUO/QsD+LnuXv3Rbp4nYWqCyQDWEeicFFLaKJdzpGgoYnTqqvVQO0zye2Y29RBcUxyzpT3/iiFg9OgTlRu9W8RndCUiFk03wWIgz0iJ+dW1CQYPfZPlhtvuo8pGUu2YOifKtQkfgJqmUIhun29nMKzj5PJGXyY+VOKAfAwMxR+UcxACUl6wy1pmyfA4aOCgX1jJEpPDgFzTEHlY/VkpwDTLD4GamGN5y1DSWvWq4+e6L3Ss4laPlEPyQ+mjgmcJKbnGvKuU3vz2h8Je1c/uyd1fRjILWvf9KHLlW3x50CUC4OjOMJKXjXv3LcZSwVoHULe2DkevCrebuEqpEMREBWfg66elhFMNfJ6N1D4mriSiVA0WDmTaLFBheE3V+9bxYqqlQJG3m/FmKnF5ASAHdC61yWX9Poi7AryYkaWRsnGdfcCv+I1vYBaAsZkUl23Fx7WDsB4+aSkumbbOG0nTxp9YzDuykU2nPwolMggC0Ymc9eBqYStYQAawMxyAIy1YbhQHTq7HMzU6hr6JqfkyO2ceCc7RBbyQw6D2X8W9ezdBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4QRGCTXia5iuCmBaLbfcihPLfUkUt/yDNlZr8HaKVgzDVf5r3VSCe84ScaMNJZ01aWJKoa+MQlBjjBnReAes5Wd2XhwPd1rcGbcgklVDnbckwHkpks3gL5ohbPrfj4Ivkj5XamcnM4qSPRWUxI49YCvouVe/6k5OYR87hG5vW4rmhq/o9jrXcH1PJYgkOgWP9UY3fYu6Y1pRJbB8Su47RfreW6kHxpI6xIxxq5ufmMBfh1ACJzuaGBvvKD5kSQlE189K4PdH8iJEPZxyQPPIQIs1c3kgeEkTMBSAnKS7T7wVTBTY2Fw6tncUUDBtKbH9CujSI1grgmAW3C3Dm+GS1M17WzzZqIJALtD8Q3462uHh54m7WD4AXdGreO0elphpnPCqWKhtHkHBsD7j6Pbe9b2oviDHuQhrfbbmsv4GXOB4fn/2H7YthofS0v1IxWAU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:57:46.1894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f41bb2-848b-461a-e1bf-08dee19f1ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730
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

The XGMI reset-on-init path can run while the device is still at the
minimal init level, such as during an NPS memory partition switch. In
that flow the normal RAS IP block hw_init is skipped, so unified RAS
is not enabled when the early CPER initialization is attempted, leaving
CPER disabled for the rest of the device's lifetime.

Resume RAS after the XGMI reset-on-init completes and use deferred CPER
initialization for devices that still do not have CPER enabled. This
lets the CPER ring come up once RAS is ready while keeping the path a
no-op for devices where CPER was already initialized.

Keep the deferred CPER retry and its debugfs registration together in a
CPER helper. The normal debugfs ring walk skips the CPER ring until CPER
is enabled, so the ring debugfs entry is created either by the deferred
helper when debugfs is already available or by the normal debugfs walk.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c    | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    |  5 +++++
 4 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 6fb129025761..0af8b7be326e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -498,6 +498,25 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_cper_deferred_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (adev->cper.enabled)
+		return 0;
+
+	r = amdgpu_cper_init(adev);
+	if (r || !adev->cper.enabled)
+		return r;
+
+#if defined(CONFIG_DEBUG_FS)
+	if (adev_to_drm(adev)->primary->debugfs_root)
+		amdgpu_debugfs_ring_init(adev, &adev->cper.ring_buf);
+#endif
+
+	return 0;
+}
+
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index d12c98077d9d..eea30be91b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -92,6 +92,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev);
 void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
 			void *src, int count);
 int amdgpu_cper_init(struct amdgpu_device *adev);
+int amdgpu_cper_deferred_init(struct amdgpu_device *adev);
 int amdgpu_cper_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3d1ede5f8de2..fd349eed820f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2184,6 +2184,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 		if (!ring)
 			continue;
+		if (ring == &adev->cper.ring_buf && !adev->cper.enabled)
+			continue;
 
 		amdgpu_debugfs_ring_init(adev, ring);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index b265b68e0f37..ab7d2b5b3b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1400,6 +1400,11 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 		 * initialized, and for non-uniras devices.
 		 */
 		amdgpu_ras_resume_after_reset(tmp_adev);
+
+		r = amdgpu_cper_deferred_init(tmp_adev);
+		if (r)
+			dev_err(tmp_adev->dev,
+				"failed to initialize CPER after XGMI reset-on-init\n");
 	}
 }
 
-- 
2.34.1

