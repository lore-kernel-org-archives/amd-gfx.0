Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB057C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 07:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E646710E713;
	Thu, 29 May 2025 07:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DhiFa6Kf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFE610E718
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 07:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7dCiqbekaz9a6yp6d/X8f5GI56zVS6uRh0zV/01cZY7Sp5ipcrloD78dp0MwGexaCEsbfT2uZenJpiO4Sl5JJMFZknqZzkI2FAN7eQtn46kpXt6up7viusG5BYmQqRIPgZ3qiFvF/6T52GHRy0rZwSHQViLg3KEKiYf3kf69/R23LQtM+CyYkc+gOhXq/zNxNlm+YwKRqO+uyIUPtNMb9VzU4FKhURB979GizsbAqk3749ffvhMjOslGJXmb1pkMgiKT9Rd0GtRwMJPJ+TA/Y7UDNJS6Ifwf2CBKkh0qZq2A9W7fSZabTdnTqnnyd1iJi9M3sLJTLzndcgMfEXRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeLp+A+V+3uYzthvs55fvFr4R+XC1gZnX+NbgqvctzA=;
 b=qSioGz+EFP8Ep83oDGVlV4EBtFVIihqNar6v3jz7/Q3w9hDyFnaflTITxdSqPqsBaOn9NofGkyCQG0iMQamukgFVbKRBQkMt2bXAjSVWfDn4QVQu99fQsVtH9PYbdYsExj+6B4rXsm3egDD2DDsTu/3skXPR3UBWSXdjJ5DO4qWe8WkrjXYqZ9mydI0QMO1EU2WRME/41luB8tYmVsdFRtd8J7ohKeOjQEvprimE2mTIXsPHAbe6paxWD9aR5I1KJbdxVIzUkV5b5J81NSOWXhKd3v/sSHy/6SdCOvnvBAMlzCuRHrUxj42EMW7YyNdgrLF1pLKn0HvCzDiU7AAEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeLp+A+V+3uYzthvs55fvFr4R+XC1gZnX+NbgqvctzA=;
 b=DhiFa6Kfm7o+5XWlCVYBgPfHx6vKYrVUhwVIYL6egz8HWxH6dKvXpIX95wQ/wlISgZJh+cCBpSFuMlnpRMOdHk+9O5TGBU+1ANpAiJgcOq3dovvZX9aQG9ab/bfQSym6bk8GBP/4Q77DjKRvo2Xa/VEKJXt1MMPad4rsVxl78f8=
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 07:27:17 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::19) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 07:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 07:27:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:27:12 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 29 May 2025 02:27:11 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <jonathan.kim@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: add late initialization support for amdkfd device
Date: Thu, 29 May 2025 15:26:16 +0800
Message-ID: <20250529072710.2926122-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc31bdf-93fd-4300-9aef-08dd9e823db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QjsnLPnESRql+LWZ+0Z1ke7peb/NnGhd2w1EW4FUs4i6jq3s/u6IN4sZvCKw?=
 =?us-ascii?Q?hDeT3uP7dXbm7LGWipP8PF7s7bQHN1NQF5CoZO7WNdQPglWngOsmu5f7cQcf?=
 =?us-ascii?Q?EdhyUlb497sOJcvXCZ2rS0l/Okvz4esWi3mlt82Eg2d7qCu7tApRBTd6zbNX?=
 =?us-ascii?Q?3Yz+N8RFi2/CLliOlxLdRhoSZe2DS2A52biuGUsboNzpDN4igtkSVaIxO4rT?=
 =?us-ascii?Q?AYeR6I2k7ao13liqJ/7JHVWqTOdjKrKpBXCQ2ji4peo0NV1z2TLlEAf7sab5?=
 =?us-ascii?Q?LrlKeg1Gcmj4sj35doxWIO9A/lM/s682FkhqY9deTF4QdVhTOzLcumDAj9Hy?=
 =?us-ascii?Q?B3mt1TNwJzy/hh0OYcvREgMddbW1MkFkF28vDHdwYR5IIZTVE7mfGbhAh3wS?=
 =?us-ascii?Q?UcJoJzbxw+nZtqEPDe4l7xDfg2D7efPQt3qEbqO/VFmNSiPVAwDObQNScMuo?=
 =?us-ascii?Q?kcZ71uy3WHCjMkh7AcDCBepFe4/dJfA/VGO8ZSn3OcjabzJVL4b+YPKI6EK5?=
 =?us-ascii?Q?OECKpI6J6Ok5VE8ZhIWDIOnMqUKDyAE2b17RxqldNXLHWbwdzax0l5JzKDKN?=
 =?us-ascii?Q?C3p1HYdTEybp3mhfKoyWlHiAANwxrjyeAGn36ZesvbN30+URZv05m3a8Gl5t?=
 =?us-ascii?Q?l+51ObosQ+eCo+9IHawsYqTkmBpykfHSO7S+VUk6ppmfN1oqjHZ2ew1gyFp3?=
 =?us-ascii?Q?A8ndc8X+uV1j2vCik51R800rAMePSKRI1D+2ciJdlv71WE7in2B3+qRQ/TWc?=
 =?us-ascii?Q?mE/FrBNOsdjufdNWta8rOZqOuhz5b2T4/e1OR31cBDGrnZmZe4sGWd8g73U8?=
 =?us-ascii?Q?Cd4Unq0jYW82HLGZhWbRlzIVUTN3Q8oPGCDf1t/STObTjFq3eVjzFFSA7/Ae?=
 =?us-ascii?Q?IJ8yuEpXtbgvIKEWWuO+Ps7P170m/P51tOzjOZyZHf+7ahJe1y5uDeuzEce7?=
 =?us-ascii?Q?/ZouF980sLpl+/1bkdWwQ6Gkc/XGIsVVwlPo2tSNhhhdwVx96WNwc6Ta7UoR?=
 =?us-ascii?Q?v7TT8Fey9e8agGlpT8WrrXi59nTSNfnXOVhsBLLYortqDOM1mLifBH520Ao1?=
 =?us-ascii?Q?uyGiKSc9H52L7BXQ695SldGgAI+oZOT4xVYCvxJQLjgNnSzjXMYXqhKbPH3s?=
 =?us-ascii?Q?YCECDlI6IuJC+RZxuWvKPhVEz19Evx3KKw1QBi+Pd/YQaz086kb2gOP3DhSb?=
 =?us-ascii?Q?oLN+NmVR6n8NADpiSHBucNEM1HfN7qGYn83RT4E83U1Ep5DxDl4d6HHZwA2m?=
 =?us-ascii?Q?lrddbJ3ERhCT/pvnHVn911TITevGGv9ss3Lljt8Tecc1sH3cHY51Tp0JKYpA?=
 =?us-ascii?Q?/7vvwiJFNT0CmNa8+9Cc7pCcKNkk1GSjKXF2OnIc71lsljqpVLpdP8K72sQb?=
 =?us-ascii?Q?4ZTG0nsF/adakofHtlz7SXNZ/AZ9XWw60STI3vrjyVkJymnZkVdsXeYQhr9Y?=
 =?us-ascii?Q?iXeYnrDNJBUNELeSZhhgEmPp95DfagMvvFhR5fGA+GqFY9c5UB56dNqwfIzR?=
 =?us-ascii?Q?HDF8OI0AeCXHEgTxFuykkVP5tNpZjYcMINDa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:27:17.2828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc31bdf-93fd-4300-9aef-08dd9e823db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

Add support for late initialization of KFD device capabilities that
depend on information only available after IP blocks are fully initialized.
This is particularly needed for SDMA queue reset capabilities which require
sdma.supported_reset to be populated during AMDGPU IP late init.

Key changes:
1. Added amdgpu_amdkfd_device_late_init() interface
2. Implemented kgd2kfd_device_late_init() in KFD
3. Added kfd_topology_update_capabilities() to update node properties
4. Integrated into amdgpu_device_ip_late_init() sequence

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 ++++++++++++++++++++++
 6 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4cec3a873995..b9a8f86efac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -36,6 +36,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_reset.h"
+#include "kfd_priv.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -232,6 +233,11 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 	}
 }
 
+int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev)
+{
+	return kgd2kfd_device_late_init(adev->kfd.dev);
+}
+
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev)
 {
 	if (adev->kfd.dev) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b6ca41859b53..6c8bbcc7f177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -160,6 +160,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
+int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);
 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
 void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);
@@ -410,6 +411,7 @@ void kgd2kfd_exit(void);
 struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
+int kgd2kfd_device_late_init(struct kfd_dev *kfd);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
@@ -433,6 +435,11 @@ static inline int kgd2kfd_init(void)
 	return -ENOENT;
 }
 
+static inline int kgd2kfd_device_late_init(struct kfd_dev *kfd)
+{
+	return -ENOENT;
+}
+
 static inline void kgd2kfd_exit(void)
 {
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d9d8cd063829..b7c0281cb6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3395,6 +3395,12 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	amdgpu_amdkfd_device_late_init(adev);
+	if (r) {
+		DRM_ERROR("amdkfd late init failed %d", r);
+		return r;
+	}
+
 	if (!amdgpu_reset_in_recovery(adev))
 		amdgpu_ras_set_error_query_ready(adev, true);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b9c82be6ce13..3aece03ad092 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -947,6 +947,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	return kfd->init_complete;
 }
 
+int kgd2kfd_device_late_init(struct kfd_dev *kfd)
+{
+	kfd_topology_update_capabilities(kfd);
+	return 0;
+}
+
 void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 	if (kfd->init_complete) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d221c58dccc3..1eee4d625ba2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1134,6 +1134,7 @@ int kfd_topology_init(void);
 void kfd_topology_shutdown(void);
 int kfd_topology_add_device(struct kfd_node *gpu);
 int kfd_topology_remove_device(struct kfd_node *gpu);
+void kfd_topology_update_capabilities(struct kfd_dev *kfd);
 struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 						uint32_t proximity_domain);
 struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 09011d78f700..052215faff76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2026,6 +2026,28 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	kfd_topology_set_dbg_firmware_support(dev);
 }
 
+void kfd_topology_update_capabilities(struct kfd_dev *kfd)
+{
+	struct amdgpu_device *adev = kfd->adev;
+	struct kfd_topology_device *kdev;
+	struct amdgpu_device *node_adev;
+
+	list_for_each_entry(kdev, &topology_device_list, list) {
+
+		if (!kdev->gpu || !kdev->gpu->adev)
+			continue;
+
+		/* Compare the underlying adev pointers, not the top-level structs directly */
+		if (kdev->gpu->adev != adev)
+			continue;
+
+		node_adev = kdev->gpu->adev;
+		if (KFD_GC_VERSION(kdev->gpu) < IP_VERSION(10, 0, 0) &&
+			(node_adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+			kdev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
+	}
+}
+
 int kfd_topology_add_device(struct kfd_node *gpu)
 {
 	uint32_t gpu_id;
-- 
2.49.0

