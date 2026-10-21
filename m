Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE7606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P/b87opz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37C310F99D;
	Wed, 21 Oct 2026 11:09:48 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013033.outbound.protection.outlook.com
 [40.93.196.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E746E10FD55
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1un3DMjJMI5IqDpTOi1l1T7TlDTocMDtld7CM6X43kcFMNn9/T7kY87Hb8XEnkcJ9ufgkvbkZTDGls+l5kadlEPUY2kwbCV6wKwLPg3V9YRniUZsFqYJOYc7ahPCDgFPfqQAaQPvsgZ7jaUDcNW0m3a70WYGpbluPWC331dRZfA0z7FGaZoBO0u2M+9IoyRp3NmRTYorr8pP4yfbBLKV/JKNWj7wHklZ/Ztvxfwv2AnmxvTGHUJoFvHyLsK5Dyl6plxm8e+zUgqNBhT2jIswXz+mFKFQYNm9BZt3B6MEZtdoIgQDKA7uSK6Nz33Y48HxtfK3TGtpi2AB1bCesayBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUugFxkQCY+jb5a3EYt09dKYSrBnHkf+cfTHV2UuDgQ=;
 b=RTdFzI5g/fsrTKB8ZtN4SvvsRZ7Fy7HBXpQi4YQMjVn47aV4/uMa0d1bdS0Gf5J2RC2WGmflPLiDhLtbB3MZrXn6DvRhV8pZdVr8L0KBkSfA485u7b18oYMEdp4xeBKsYHu21tbT85/dYXh7tgOSg5qVKn/+ZbGdGndrfjpRln7wGrIu7r732RVK06MKJIMXXSuQShHP99ox7LaZH2+IpHCGzJK0gKBQ5SaL2PHOEacD4UUg63PUnVCMcokstc1VX4Q+R0jcitXNJQ+uqgryoRbxdzEySmrqO2NarqGxPMgLWuNtnlMvlJhRyB01iI0f9tQyOtyOodP4IeOm7vr0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUugFxkQCY+jb5a3EYt09dKYSrBnHkf+cfTHV2UuDgQ=;
 b=P/b87opzoqN33CnzPTVZHrzqWTxfMbezHmB7w/9hXpc33LZysz9BSluIqf3ABQnwXaKdGpGltwYY7GXmAIArxeFmyNCVIaARo6oXfQvryDNfXb8k4gXb7KoDadQ7h8d7R5sZSffwzMlvmhMw4a6lyqGviK4rbYx3IYUTJFzejl8=
Received: from BN9PR03CA0514.namprd03.prod.outlook.com (2603:10b6:408:131::9)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:09:34 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::47) by BN9PR03CA0514.outlook.office365.com
 (2603:10b6:408:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 11:09:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:34 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:32 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 06/12] drm/amdgpu: implement reservation mechanism for PMC
Date: Wed, 21 Oct 2026 19:09:57 +0800
Message-ID: <20261021111003.3371005-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dffab9-e385-462a-3a20-08df2f63ca03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3KhRkG/tVJCjHBuRZ7RcwCnXE3BLQmcQfPCesLb3CfqWbFhI/9bSrLnCRq+um38UFDfr+3VeR/uAf92iTWluC/vPMp0yFx10kO+YboLClG/KUjqakhWWH+8AHTQLMh0dJLk4un8K968T6P5Z2Zo7pJvbpwXwW0LjUQ3NO46Z0dvdZqlgRFZWflNzd8iI7gvk9oS1Ss1AE2Md627crF+N2uEANOlzdgcr/rgrcWqzuA9uD38l8Q14IiAbXYqJDPfg3MeDxHEIHIHz/UJEyvHJ9kyUiB6ELtfwSquEYuRTDfXA/FCtxhxMgaA1DQPZJowy+/2MmHRcyUPzYUzYZ3SeA14Hs1lBSRz9fPSJ5AWSBX3tJINNzVcAQiqiTzdU8V0erBBBn5rSIEGr57qmGdl47iBqfu4HLwU31WDj6JQbAnqFUSh63TKaXUyXcEYWFlvfueASyooMRDGPCK38UAFgDFZJ3KxQXZ2QGhK8VnkzL8ZfspEaxlprxi5Tslxenz5KnZnvHvgWpq/OV0hQxv6FK98odWtj9qL3oMV043DKTDDnAJOhCN6hT4kq5yNDTlR0qLur3eWNZLFNneCMj+dUJ1mcCLbucniMMwNogvGa8ucAXk7/gnLLisFGwKH1BlBcSPANks1gabcecF3y73Xf8LGXDZ3/+/M61AU5oJ/0PS+2J6MRH1AvxYCOs94/Jn2B2dNwz7X7I19hDJEHXQiB6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kmu9NfvTiWhbBexzFXNzQu/ITae+wVtMhF9QJpTXTkhUuw6ppGoyNInIuQVJLZQSyZvYk016hvTe/6JmAtolCuuXd9f2iI02GEsO8HuoPg5kQhXTDDnsC39JRMnknoiINV8wG05S8n2B2LD+XurHHM/tsYrdQIjrdf4Cmydq1e3msse/I22eIFk7fiQuphULuRe5QIuNRAvIMxlts/FQdNo3gHcraozfaEwB9KNTYsx6cq/UM82a51KaezU946dQoNaegy38Dzc8AAUh9+QCmCC/MnK2Q5G0cNmNtG0YHouffH5MiAAzQXDNDfJ5/5/wj6g2xP9c/ROG6k9gtLj9R2/M+wJhA943CYMqXHGUnpLfm+XyXMJw6B8QgxhA9gke39d4MqY/5FBX9vzmHDkuudo3DuhH04RLP624QqS9aatG0rrMo2fh6v0F+8ySVX1K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:34.6941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dffab9-e385-462a-3a20-08df2f63ca03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit implements reserving (take the profiling ownership)
and releasing (release the profiling ownership) of PMC.

A reservation can also be cleared by AMDGPU_PROFILER_CLEAR_RESERVATION
in case the owner can no longer release it, e.g., it crashes.

Releasing is separated from reserving path by design,
because the ownership needs to be kept during set_perfcount
to avoid racings.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 73 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  3 +
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 61ce43dcad68..e441eb171c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2988,6 +2988,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
+		amdgpu_profiler_release_device(drm_to_adev(dev), file_priv);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index feff37279575..6464af0d1b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -29,6 +29,54 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_profiler.h"
 
+static int amdgpu_profiler_reserve_device(struct amdgpu_device *adev,
+					  struct drm_file *filp)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (!adev->pmc_profiler.owner) {
+		adev->pmc_profiler.owner = filp;
+		ret = 0;
+	} else if (adev->pmc_profiler.owner == filp)
+		ret = -EALREADY;
+	else
+		ret = -EPERM;
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
+int amdgpu_profiler_release_device(struct amdgpu_device *adev,
+				   struct drm_file *filp)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.owner == filp) {
+		adev->pmc_profiler.owner = NULL;
+		ret = 0;
+	} else
+		ret = -EPERM;
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
+/* Clear the reservation in case the owner that can no longer release
+ * the device, this function does not take the reserveion, nor touch the PMC state.
+ */
+static void amdgpu_profiler_clear_reservation(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->pmc_profiler.lock);
+	adev->pmc_profiler.owner = NULL;
+	mutex_unlock(&adev->pmc_profiler.lock);
+}
+
 static int amdgpu_profiler_check_access(struct drm_device *dev)
 {
 	if (!perfmon_capable())
@@ -40,6 +88,29 @@ static int amdgpu_profiler_check_access(struct drm_device *dev)
 	return 0;
 }
 
+static int amdgpu_profiler_reserve(struct drm_device *dev, struct drm_file *filp,
+				   u8 reserve)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int ret;
+
+	ret = amdgpu_profiler_check_access(dev);
+	if (ret)
+		return ret;
+
+	switch (reserve) {
+	case AMDGPU_PROFILER_RELEASE:
+		return amdgpu_profiler_release_device(adev, filp);
+	case AMDGPU_PROFILER_RESERVE:
+		return amdgpu_profiler_reserve_device(adev, filp);
+	case AMDGPU_PROFILER_CLEAR_RESERVATION:
+		amdgpu_profiler_clear_reservation(adev);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
 			       bool enable)
 {
@@ -61,7 +132,7 @@ int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 		args->version = AMDGPU_PROFILER_VERSION_NUM;
 		return 0;
 	case AMDGPU_PROFILER_OP_RESERVE:
-		return -EOPNOTSUPP;
+		return amdgpu_profiler_reserve(dev, filp, args->reserve);
 	case AMDGPU_PROFILER_OP_PMC:
 		return amdgpu_profiler_pmc(dev, filp, args->perfcount_enable);
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index c27b5f9b3ff0..048ce84f0ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -28,6 +28,9 @@
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 
+struct amdgpu_device;
+
+int amdgpu_profiler_release_device(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 #endif /* __AMDGPU_PROFILER_H__ */
-- 
2.53.0

