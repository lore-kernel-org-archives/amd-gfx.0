Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA16C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 07:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB4810E719;
	Thu, 29 May 2025 07:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t23AuH9H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C209B10E719
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 07:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjixXpgHlEeX1a/eGM1cpYiVnUc2w9lP05JxdhCuyGoVF2RKfpFg2PeT3kyuyJpimYz2FfdO0ACvlAnCEk8XKY3RUSfQJqn8K1xcXSHJoG2cs1b/X1KnQZww3Pc+03xalAGnGqsDLWeJjIC4+a2R1w/P2Tc8B8SZjIrOmKcymNIn7BnXFFJjuIh0xrGv3If2P9M05DBFbHTEuHVL5cd2Nm7Dw0LEUME7nrZQm9hnzyU9ktr7QnLu9o0qnwNMMx3ZHCnLKrSETGVdBJaK15TStCsqleMa/mrlp8PuMY77QCikkpThmKPN4bad4JLlH1zlWRbGfIpYMfJYUaodqMKejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6H/m4ojogyazA/Zz0shkKNVDVzKuY9stKyMOfN92FY=;
 b=WS3tWnce9fJTsI3U6bPJW7M9PYHc6GT39e1i32bnV5ytIu/A7aeyQsKE6uYayFBcdtml3bQgBBd1br2gV6/UfMG3ZnK7yEF7JYYFmkBpYuyXrrr+uQ2IY1DWLuZqtc4yUAQotFbsnEDiMF3+Iyze5rTD7cj5nUjVDoaDCXkK6ywHFQXe1AuLSIpinYmqJalw8WJm/Rb6FCOqGmO2ku58tPt1c8D3my3JmKL6GUW8z4RvOD9gkaRJLh7+CJLH72Q+QNJtUh6tciZZXqBRy3XoYjtC7qTAjNUsx3Umal2HcPqm2jeLz84+aWuR4crb/J8VDDZeNRll4xluR/VrvodvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6H/m4ojogyazA/Zz0shkKNVDVzKuY9stKyMOfN92FY=;
 b=t23AuH9Hytn9jVC7vhBCMIv6vG2rNgywzySr3rnWRGCxhKRNl+ZX5vm/htjdUs1ygVSo9+4JJwj2g0sg+GREe3a2Mh2J9Na3+MOvxs4jGhUzZfryo+98PP8D//AxT/wY1y3rOojg/jAbkNvuBgoWd2LGUWK6B3y0zAKhlV/D43c=
Received: from BN9PR03CA0585.namprd03.prod.outlook.com (2603:10b6:408:10d::20)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 07:58:07 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::40) by BN9PR03CA0585.outlook.office365.com
 (2603:10b6:408:10d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Thu,
 29 May 2025 07:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 07:58:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:58:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:58:04 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 29 May 2025 02:58:03 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <jonathan.kim@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdkfd: add late initialization support for amdkfd
 device
Date: Thu, 29 May 2025 15:57:32 +0800
Message-ID: <20250529075802.2932430-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d0d08a-c412-4cd5-76b1-08dd9e868b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9pmCFKMkynEID/c1U6T0sIwRFMUIfX9a9/ybyTH56ZEUN3JvUvYHSGFbYWw1?=
 =?us-ascii?Q?QTe+QXYd1F/+VfDjj9y8ewus6snIPhpn6VHwe9HoTOBAnYd0dvOAM/hJWOYe?=
 =?us-ascii?Q?qTrjX+Vj+hH7Gmci/LV6LqPtL4mcjlC6ImHpeE4CCVv2afm0UVACFT4RpwFp?=
 =?us-ascii?Q?inQhp61bIF0AehO6hROoPhIF9JvJKaRkbKc79N2OMN/OPCtOdgcDFZ3lv6MJ?=
 =?us-ascii?Q?qQgxcp01qny9HfaTZGBqhjHg0WwdUF/CrGegl7dUyi821JMFwAzx4WgSVse2?=
 =?us-ascii?Q?pALtvmBadFNQGl4gr1V06N501aphrQhNGN/1uYPtgLKtl1z5xit3mXXGzbIq?=
 =?us-ascii?Q?JTUNMijbMk+fd3oH9Vl8oEWWThDuAgKlnzzmI7UeowQK4WMQ8D4rBIpjSCHB?=
 =?us-ascii?Q?ONh+H0a85QXN2oJYmbCqJlHMktuuLtz/mUVoDfBl3SAX6RrgK1jJTjb1U7Je?=
 =?us-ascii?Q?f8Gd/pl+IrAyfC7LR5g8HcvyXbMVtTe0ojsnxv/QiWj5/nl3wyvq1BL4ivBM?=
 =?us-ascii?Q?9df5hky9rOuhkdDAmAFuoe5QLh0Tl42I2s+GKfOU+HhlojOXr64MscBIu9Fp?=
 =?us-ascii?Q?p4y+MMiwZXyKI5QOqlo5uIwRroUP19HPlBB0kQWD3UfwUW0/SKA8aaA7Ma+N?=
 =?us-ascii?Q?D2M4n8vrGn/RhndPBgFs66SVTZ03DLpPnVYjFDz7vR0oS50rKKph9WSOrdih?=
 =?us-ascii?Q?IFhapG0gKKKVdKD/8WcTn00YqHM4OIeiCW14zi2r9Ubr2ZjqB+V0kw3vkjkX?=
 =?us-ascii?Q?4JieEnnuv6Op9xigQJLB6nfkWjT8yFCXFKFlOqTq3EwCIQT1n35eC/zcZp/8?=
 =?us-ascii?Q?jLq5Oj/tW9ZNCDIbbya1br+9F6j+JWusXxChbhqVySMmV0K2IlDgyEfTMguK?=
 =?us-ascii?Q?KRp7EWgBBejm5gdPaEtYacTuQzSwchhE/Qa55rXTFYg7bv+HNRnLsyT5406x?=
 =?us-ascii?Q?SVglq2ngkypBtWv9+QPCVWs8KsiiMiqH9QNEB3y7zRLKfUZVOpz6qgUsyqno?=
 =?us-ascii?Q?OWuEW4/769TIiV0LYQllh5qcnXuy2QbWklkQy5JUARDTi4+H/t4aq6yiGMQR?=
 =?us-ascii?Q?Yn0XsxbGWop2/5XQ74TWyMdnVbG07bIxixjjvu+BZtdIEqWdPxgswbr/uFm8?=
 =?us-ascii?Q?8WxTeCi2wO+RftYI+9AOEczYMsVresuIxCESE6kbbe0fuNk4HoO+qbv7fQ83?=
 =?us-ascii?Q?1s3LrxlfmfXRN/D01AeBvan0wn004kKkE5WWxRbztZhEej+qq0z2CewirD9g?=
 =?us-ascii?Q?QfOhNBU/b+xuCTgmLX0LGE5C5cmUVPiuD4ikp9J0tQMPOamQoClYqveGQu6U?=
 =?us-ascii?Q?5ACItJcndB0Tc9W+9CJj/gInk0rP3WTV1vr/UXTuB7ZI+8+50izrhGL38Waq?=
 =?us-ascii?Q?ryF0w8tOeshdUJ1ov5fpL7Ghoc10GF7JkoxTnaXXPApirn23o4oAkpvqtKqM?=
 =?us-ascii?Q?Txednxfq4Omr0bChlAi8Le82T+ZmAcj1t7u/edYkx4cpZzf/1t5bqlII/3Ek?=
 =?us-ascii?Q?R2GV7Hts4I5zBRoETq4BErjCkEKUmAwjvkM6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:58:05.4583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d0d08a-c412-4cd5-76b1-08dd9e868b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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

v2: remove the include "kfd_priv.h"

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 ++++++++++++++++++++++
 6 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4cec3a873995..d80745f60873 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -232,6 +232,11 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
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

