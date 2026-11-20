Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21F60A260F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mkfReV2g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504A510E814;
	Fri, 20 Nov 2026 21:49:54 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E22B10E814
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 21:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaJGJjO3a5CaXKPAqCc31f0etYAUo4jchVkm0mq2Q4R4EZ8WYxW9cjSsSCTPQ/UMFgtIlEBXi0PkG5EVlZSs7vUcGAr6A3v/nJYpDFcmGCbUVbbXTEptLG+JD0iDafh6M3P+Auje+vvS5n051E4JRFQPQ8Yoo5ChVj033snf2U5WaHy8qAteVXJYv3lsduJGHWM9Y8vp4hPV0ZXiyPXxuTNQKDrDBY7HseCgvR/sveXftRfkueesyP1zmlBO2AAcGJkS4SHT0SVLLKYYoCl7tdAdBGT7fXOBNIvwBYTOrTymgFz5LWPP2iyFfZ4H7hLqQhllxqLPuns9xrU/0CB29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3z5eRoJBnjPd56aMtqZQgnU9qAy4vmRKi2hShcSzHQ=;
 b=K/tBELqgfdRrny8+Q4JeFY0hV7KEjKl1ahA9I752/LNIkj8lauEAhwE9zh3vyGHhiN+G/oueOnJSnJPSwF8WSt7uXkz4Yh+fJk4NByOxc+hP81uRw77clv28rEYQcowyWJMwUB09U916+xeUZbZWGUfDMk5DHllRO4IZ7ktxgl5XT0rvcn4pY0R+rqmEniMG4JLkBiu4xh66yQC8VLOfUqjgh8CDDfxJkALG8u3mw0Bx3ZRwdpsuXoeC9rpbl2qgfxGtgFP8opDlzoyJTAiS9XQMNqCU9GN4mD1/EuC98Z/buYkL3lSLpbrXNSMgpuMRJc4/8krX5sTktLAytFjUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3z5eRoJBnjPd56aMtqZQgnU9qAy4vmRKi2hShcSzHQ=;
 b=mkfReV2grXSW2XUUgH5jGkQRsb0MsXNzqvSRZWXlgF7RpdCBW/cPM+C9Y6UAXB90lnS+a+7Urj1K1ZNROPilGgYgSamcocpS7MoztGVZ9gZDxeGundtMbMzbHjTsgL9aTLzNfQ+sFAaFl1zMg+Mhq117WXpNzZgFCc3lC9JIXKU=
Received: from PH7P220CA0066.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::21)
 by LV0PR12MB725154.namprd12.prod.outlook.com (2603:10b6:408:60a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 21:49:45 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:32c:cafe::44) by PH7P220CA0066.outlook.office365.com
 (2603:10b6:510:32c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 21:49:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 21:49:44 +0000
Received: from tuf-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 15:49:43 -0600
From: Apurv Mishra <Apurv.Mishra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Bing.Ma@amd.com>, <Benjamin.Welton@amd.com>, <James.Zhu@amd.com>,
 <Jason.Tang@amd.com>, Apurv Mishra <Apurv.Mishra@amd.com>
Subject: [PATCH] drm/amdkfd: Don't require a VM for the profiler PMC lock
Date: Fri, 20 Nov 2026 16:49:25 -0500
Message-ID: <20261120214925.211726-1-Apurv.Mishra@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|LV0PR12MB725154:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2e238e-0e94-4b75-0ac0-08df4750304c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|261009221227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info: gxs9ZO4qhtxC7P0QBQlxJZSVFYZYLjnZySrsB5ayHFr1tuo2gKVNTnkYY5D87qNszvJ2eUqbHD2R5wZSdVMf8teaVlE8MM+GWM+zlUT395EpknHDn1CFGqgk4eMiIm1OSGij43c84Lm+qp+RYG79f8Hjd0ieA8OBfrb4OaoAhKMdM/GZnBGZDplyvyp8YhBWUCVPFjR41YpP2/zCug/QsqTNAGjF75r5dWvhLmWO+V5ubD1AW2KM6X19UhF/hP3Rewle6C4mt2/9IdEtFvXmO/SRU6GsuIk13BQOLiy72+YLogrrTKXc4rfrFcEVwXa+/yE+4MP+XCQKK+QfXFLg5A4OAhD1mCyYFpE7+/ym+7T7KaZFc53GBfBO8pN3OVnBfsx85uzWxQylXlJby4VpBxHXACuO5+9XBS+rUgNnnZ8LuvrVSgfdPH9nUKE3ZmKoT5o/r4Ji/tKRJcABZNr73Qe80j78ddueZppqOLXVj7WvhhkbtZzhyRwLxhrZL660mOoHxGDuL1sZQtALmec06i/M0xZ55tuWUbSY9LPaxMJ9jLgSOF/S+ULAxjUzR/96xZIn4PEFtQbFabq9kl/8/ias68KPRztH7j1574YgagoWjFOAvSwiQJ58bSw4LvZgOQumY5yAFseqZZVkEYDKRhylXCVhLOhTmN0ziZ5SdfeBxgk1qztCftvkITVr9lXs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261009221227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ftz4kSe+lP+iFfKdKZpRpi0GUuh1vpNLrx5jXWt+M0l8ZqbwV2EOqQ7lC0Q0g2PWuNgUq0jVFk0MzvEWpEOW+cldpkcdYy1RdASBxIRoZBZSVTrGvYkJxvtrj7eOnRCYYFumPRWOVEs3UHVb3+SPLF9Sg920+81QLeJWTTbJCA1iQxyeN2BIX/mNdUhs38DXjx+mcRacp+uOiNAhONpceaOP78MQgeq/x1YcC8KlTErznCV4cF+B8NdFwmwg+CPH3f1z3S1C2owka8ehOaBusIa8Upulkr/8SJ6BaMxG1d5Al59ZJb8ToMQK9Anmywk/LG5YUcldWFM9RtW4jTJy3AJCE3mVgw9BDecFWEgZVPq3EbytMZprKDDMRX0Xv/BRNLzZ/zfIKGkvw90uJDQCr3VHtF7B3QUoWPwmWq9rf92WgJOltObFYH6Zn/lCWLf2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 21:49:44.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2e238e-0e94-4b75-0ac0-08df4750304c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB725154
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The profiler PMC requests now go through kfd_bind_process_to_device() for a
runtime PM reference, but that also requires a VM on the GPU. A process
that takes the lock before AMDKFD_IOC_ACQUIRE_VM, as rocprofiler-sdk can,
now gets -ENODEV.

Take only the runtime PM reference, through a new
kfd_process_device_runtime_get() method that kfd_bind_process_to_device()
uses as well.

Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 54 ++++++++++++++++--------
 3 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..b48be5743381 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3396,19 +3396,20 @@ static inline int profile_lock_device(struct kfd_process *p,
 	struct kfd_dev *kfd;
 	int status = -EINVAL;
 	struct amdgpu_ptl *ptl;
+	int r = 0;
 
 	if (!p)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
 	pdd = kfd_process_device_data_by_id(p, gpu_id);
-	/* Bind for the runtime PM reference before programming the perfmon clock */
+	/* Runtime PM reference only: the caller may have no VM on this GPU yet */
 	if (pdd && op == 1)
-		pdd = kfd_bind_process_to_device(pdd->dev, p);
+		r = kfd_process_device_runtime_get(pdd);
 	mutex_unlock(&p->mutex);
 
-	if (IS_ERR(pdd))
-		return PTR_ERR(pdd);
+	if (r)
+		return r;
 	if (!pdd || !pdd->dev || !pdd->dev->kfd)
 		return -EINVAL;
 
@@ -3474,13 +3475,13 @@ static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id,
 
 	mutex_lock(&p->mutex);
 	pdd = kfd_process_device_data_by_id(p, gpu_id);
-	/* Bind for the runtime PM reference before programming the perfmon clock */
+	/* Runtime PM reference only: the caller may have no VM on this GPU yet */
 	if (pdd && enable)
-		pdd = kfd_bind_process_to_device(pdd->dev, p);
+		r = kfd_process_device_runtime_get(pdd);
 	mutex_unlock(&p->mutex);
 
-	if (IS_ERR(pdd))
-		return PTR_ERR(pdd);
+	if (r)
+		return r;
 	if (!pdd || !pdd->dev || !pdd->dev->kfd)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 129363ad4e34..e6291e273599 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1152,6 +1152,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 			       struct file *drm_file);
 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 						struct kfd_process *p);
+int kfd_process_device_runtime_get(struct kfd_process_device *pdd);
 struct kfd_process_device *kfd_get_process_device_data(struct kfd_node *dev,
 							struct kfd_process *p);
 struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f959f19d92d2..eb286279bba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2010,6 +2010,39 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	return ret;
 }
 
+/*
+ * Keep the device out of runtime suspend until the pdd is destroyed. Unlike
+ * kfd_bind_process_to_device(), this doesn't need a VM on the device.
+ *
+ * Assumes that the process lock is held.
+ */
+int kfd_process_device_runtime_get(struct kfd_process_device *pdd)
+{
+	struct device *dev = adev_to_drm(pdd->dev->adev)->dev;
+	int err;
+
+	/*
+	 * make sure that runtime_usage counter is incremented just once
+	 * per pdd
+	 */
+	if (pdd->runtime_inuse)
+		return 0;
+
+	/*
+	 * signal runtime-pm system to auto resume and prevent
+	 * further runtime suspend once device pdd is created until
+	 * pdd is destroyed.
+	 */
+	err = pm_runtime_get_sync(dev);
+	if (err < 0) {
+		pm_runtime_put_autosuspend(dev);
+		return err;
+	}
+	pdd->runtime_inuse = true;
+
+	return 0;
+}
+
 /*
  * Direct the IOMMU to bind the process (specifically the pasid->mm)
  * to the device.
@@ -2032,24 +2065,9 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 	if (!pdd->drm_priv)
 		return ERR_PTR(-ENODEV);
 
-	/*
-	 * signal runtime-pm system to auto resume and prevent
-	 * further runtime suspend once device pdd is created until
-	 * pdd is destroyed.
-	 */
-	if (!pdd->runtime_inuse) {
-		err = pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
-		if (err < 0) {
-			pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
-			return ERR_PTR(err);
-		}
-	}
-
-	/*
-	 * make sure that runtime_usage counter is incremented just once
-	 * per pdd
-	 */
-	pdd->runtime_inuse = true;
+	err = kfd_process_device_runtime_get(pdd);
+	if (err)
+		return ERR_PTR(err);
 
 	return pdd;
 }
-- 
2.43.0

