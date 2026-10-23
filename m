Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F49606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xwyQphyL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED9710E5D5;
	Fri, 23 Oct 2026 09:09:04 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B80C10E604
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1/ZVQ1jVANyxQvWW3PCw8bgzoHF6ZPzyWyXpMexeVBqJ/FA7tIuWHxZ/TqZRTPHpAyy/ialNd/LLZQk1ldO7R3cqYMc7l5nc6k8jW3WLIQk6DSmyGNSxXazljvJdDfgMQWlw5zrPPv++egEZd43IfAB+gbqXwEobEpUgrQrn1GvshXRwl+ss6dIHW1E3+07x7AnCdp7Z9SCnMTED+N0cNu47rytHRoGD4ZpFjJC4aiJTHUAw+nJlEJA/scNROdxdeWEVu/vhxy6VZcvGAin+R4MzGvUDgXD2WlXgWMj1c/QC0JCL4ApP3TX/5YvuA7CEOq4r396ZYONNCZDJdx0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK8WOimBMGos+ocIgI9xoH8vh5RzbwumIJIoEh/SoYo=;
 b=xA9acJB+pQH7P02Jc7NpfYJfCq6cGQMnLwiE5zlOl6QJJLEDcEsnVhmtOPSh67FsYAgSIEvUHd/BEhh78P2ssO8QmEcwqTQBcL+wRbOeEXW553NbYtDTlxwTfcSJc33zjNsF6PZx1QBzXpK+ng5GcHQJorI7ZZZLWzU7NWzjrjfUBiUZbu9SO1EmGTgG9M78f0MQbG8GoC55pLp3ZCZ83La1Th+H4GO7M/4Mf8i2weGOM5vxvyRlraMx2Scq18Zxg41yqi+pvE69Ea6ADXlJHF1eX2SWJ/+v0DcrXfzgLm78JSuBti3n7VNyiguzfd7YjqN+DN5DDpu0Y25opRS6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK8WOimBMGos+ocIgI9xoH8vh5RzbwumIJIoEh/SoYo=;
 b=xwyQphyLNZDrWFvdDGVRJx3AdJxJ3fzA6JPR+lcJXwSxz4PLe9okXd90UD9M/N83Fb/c0Am6DJLXisRcNS5ZfJArG+JJNhKv0KKD+2tiAzsSEhjepteR0u6SopyYee7ZeG8MuAXxTDA2ZlZCdrup35+2ZOMHe8oYiVGBYJUCRNI=
Received: from MN0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::21)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.18; Fri, 23 Oct 2026 09:08:48 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::36) by MN0P223CA0008.outlook.office365.com
 (2603:10b6:208:52b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:08:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:48 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:44 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 04/13] drm/amdgpu: implement reservation mechanism for PMC
Date: Fri, 23 Oct 2026 17:08:36 +0800
Message-ID: <20261023090845.670581-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c843d7-c9a5-46a3-c390-08df30e53f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|261021123027099003|261022075727099003|56012099006|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: l0UT+6E5GBFVfJqvsl02lIwPQgvDtJ7+1YbXpg0/J7e1D/4VYrVDUz9xxtb43hqX+v2xtbcmaudIz9y81c8TWJDaiaUFV1Hcc56RxIld7sEva+NBJDh2YicmOC8iZeeuGv+bImNbC5hppb4kgYgbadSYEAPDrqN02XEa4GxgTkeQG8JzIIG0FtJU5bael4OQkLXpZkXdQRkf0Cr1O54gdbY32HIcDwQoHYEUO9coT5BRT5cCbHAzsbfxrwrYJmPFgCASIipEcAauHG8Bu/KLEFBuj4XicPBaJbwoZol1TxuPWlFRtem9oRUP/AlkZqlkFVB88UxCgLvGig3ZsJcGu7D1wVmNJZpewvX8RCBgR/oPjjSyaz4uNDJCLdiiQSZh9bCWDbBEylm8dWZ5D5+adfoz60Uyxc5TEINfg2+GapnAqhPyei2iEEqslk5dWhI4uMZEZ3Os5ePYJBp7Fds073dbN9S6mWow5ETsFzFIQkHFfY8V5siVKCrTezlS9EVK2Y8KUBo8YNwJh4s9V8BnHzDyIgo8+9AynpKfaKXMDAxpkT9NL7G21BEYPjVmrq2U8M0f0XT9nddQ9Um0KFl2VpKEwojTegwl4i1hgN4UYOqqwH/MD5nW16r+WFqiULHR1R+Sp3JOH49fAUTK7RZ1tSv3hz7aToNOL5IgrFSnPdjV6XEShxgtDKuRpQPeThlntMuZdcENlObRx0Pbugn26w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261021123027099003)(261022075727099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b0CCZAFtpED+wR4GgtQLsmR7BkVuGFC0e0mPx2ANuYaBpd5XjUDNP0YjEBLcpJlJb73MskopCxIUwhIgiS0NDNyKyIgOVURUYezOkZrxkk2yNEYrMEQUYky8vUsRAofArATV7V6FBXw5b1pqEEiCbC732rzAD53VW08PThDwDbSg3yOdp2qo4tHyEYFTrghaxsBH+2Zisnf1KSfBdF/XIC3yOC5agAH3pb0cpTFlHwD5W4Ac8FNeQ/MfolO0AJ4FyBsnzgwcsziWPDGNcmsWj9CkoLm/ptIU9506U8no5ujNF3rMLnIwIuJYuJ/BcxaUXe4Hid2dqz8dALP4GlegQm3qbul0eX0kfmSOqI6CYK1a130ZeqVo2LkptmDOqpYyb1Cxdmx1LjerTde7urpRT0LgC1PMmvcOoEapAnwxkHY6HPqELO/DCRnyvQ9a/+wb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:48.1134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c843d7-c9a5-46a3-c390-08df30e53f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 75 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  3 +
 3 files changed, 78 insertions(+), 1 deletion(-)

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
index 134660a4a4d3..a15149720d52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -29,6 +29,56 @@
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
+	} else if (adev->pmc_profiler.owner == filp) {
+		ret = -EALREADY;
+	} else {
+		ret = -EPERM;
+	}
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
+	} else {
+		ret = -EPERM;
+	}
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
+/* Clear the reservation in case the owner that can no longer release
+ * the device, this function does not take the reservation, nor touch the PMC state.
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
@@ -40,6 +90,29 @@ static int amdgpu_profiler_check_access(struct drm_device *dev)
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
@@ -66,7 +139,7 @@ int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 		args->version = AMDGPU_PROFILER_VERSION_NUM;
 		return 0;
 	case AMDGPU_PROFILER_OP_RESERVE:
-		return -EOPNOTSUPP;
+		return amdgpu_profiler_reserve(dev, filp, args->reserve);
 	case AMDGPU_PROFILER_OP_PMC:
 		if (args->perfcount_enable > 1)
 			return -EINVAL;
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

