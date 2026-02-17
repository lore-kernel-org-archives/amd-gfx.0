Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E798E909D5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBD110E50F;
	Tue, 17 Feb 2026 16:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnWDS3Cj";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3507210E50F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4YL7Z8G0pR688kmN++n736YghPdpXksTdvc0jISPbZfQ0D4AG0RwI/ans9R+qGMXi9TDFEAd7Mpyt9fGoY6cyiCrk/imIADTiDPXP5lJ4he6nGzmwZ3WLuljTGCc+IBXIs7AnJJwjF/Qt/OuLYmic2F3/slk44bDI0TK+ycJoTTTXLa6VHUJMQ31aiReed56+9jnTM58NxNLBxKebTW8nV2dtccRhVmJ9X4q8poeTJ9Mp2GoO74hLiIoIf6HOjau0rPN6BvjiW8fJxNhdyflufvjEkZ3HbPEjbz6Fgxh/1UDqGgaEPOrJcU22q8ZvoCpmz6zVPJfR7co8ckzsLhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkSjy6btj/8X5xxTCiTiBdvGZ8kWSIv18WNc+RP15dU=;
 b=KElaimIYGBQRusI/KwFRFiTjApZ/KWC89e4etIsq1S08NrdzyaV1Q5HdyvmJUWiBYFlaNZt8KWAU5/Z+bdfLPthoEwwBYfeg3PJsU3fCgTe3+SDo3HwkATRWfaPiu3TAxMgjfqt2dvZCz3vBygpdwe/hE5Jtzu0FiX7sHv39YYFtxQOKxf4OrlIiAeYusshkzHHFnyLvLfB2dviNdmoP1cBb3/1Au2jwkYQXh4JBNqYJLqd2jlmRdksolrj/BHnUMUXq5InDR4Y0F3syfWbvuMyXvTH6XD8fVMZ3U3q27aPZHA3ERE4+WbClYWoMY7ekIpwdJtHjAiGqXDrWka2uQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkSjy6btj/8X5xxTCiTiBdvGZ8kWSIv18WNc+RP15dU=;
 b=MnWDS3CjxSctxMC2MhAvNez8+MJ1+aHe78xGqTd2HVfu8HDnclc3A8Ll6l2q0j5zkfJ5qFGBrQe5WMaGli8N3p4Wz4tdK1ZylkWwJKSZDHq/uHdCM19I8PopYwigzCz7y7TXfEfpH6S0VshHdYRBUnrzofTkk92UD3PTHqoTTXk=
Received: from CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 16:21:46 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::47) by CH2PR18CA0026.outlook.office365.com
 (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 16:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 16:21:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 10:21:45 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 17 Feb 2026 10:21:45 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdgpu: add an option to allow gpu partition allocate all
 available memory
Date: Tue, 17 Feb 2026 10:24:24 -0600
Message-ID: <20260217162424.991875-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bd5888-1a58-4203-a0b5-08de6e40a504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bAVl9ZE9Lmky+Rp4w2oF0smO+0RIZNR/a/tKY0OC4KxmqJrHbBhs/JXtPB8W?=
 =?us-ascii?Q?a3kckVuNEB7HouFHWSbyHomwSZOhna3VFFLdw3rHdkkzNFjivFdkE699HR1W?=
 =?us-ascii?Q?EFxL0B9WYAkSzi/XwkglYvRsM42lnRiQZjwd+3TSzHJkmBcBK6kU+sEezsSo?=
 =?us-ascii?Q?q6wdL60Z5gTyaN0xnfntEJXyPqhhRANo3RHg4HJ3/tiK8rPzND42qbuafx2a?=
 =?us-ascii?Q?3gMFi4IOfa0YPu2N7XsOlauPqiah1bHikQiy5XgQgrZFA9KHz/gpQtwBbkOZ?=
 =?us-ascii?Q?/Kd+8WXl0kJvslmWQH8HEKgXj8fGLPay6wIrSl62NxtlY831nz6RPBy5YUl9?=
 =?us-ascii?Q?F/+UhKIZUgoQG54twD2QKMa1WdFuAtYzuIgmAuXj+6SjQNp0Iak7fQ0Ncb1h?=
 =?us-ascii?Q?jZju6oL+jF3v9XwzlPQn9b4n4GgX3dETwxZC1Trapoc49y3pm8cwCDwb46wK?=
 =?us-ascii?Q?n02bf7/41sKFyFFyZc3M/qlf2vXU3L5gYe2/T7wW4mMjanavNWZaeeQ8hR/+?=
 =?us-ascii?Q?SaHm4IDH2mXA3pRZO1L0+MwXTr9S6gannVsr94O+NZp1v2kiwEp0/SkoOo/h?=
 =?us-ascii?Q?IMvSHytELicxl9UdCJnyq7HpZKcyiVYNKnXGHVBFoE89BNDbVD1BmJp8v8ed?=
 =?us-ascii?Q?FMeB0wz+HnQ6JDaqB3GFVPlPdawos63TSZtn4TiE23Zar3h6Zeu1Ge3W3Q8Y?=
 =?us-ascii?Q?Jxu8zYxM+EtmLrHCZ+XzGY/ckwh3s7IWAQrlcSefm3PPoJePlf6qkxw4x1SR?=
 =?us-ascii?Q?7myBbFcRbPP5QyIT7XYeUgwkMAXxf9FN7N08cfqVM+WWWeav4SDMZM30H6zm?=
 =?us-ascii?Q?+R+uCpDEoCKaaUCJt9adOsFe0xNFbwZjY5YYXlUmSEq5wT/xcX3+ob+QzUnY?=
 =?us-ascii?Q?GTsngOtk0fYof1doM6cIy1asOQ7yzKmtBG9ghWHAZNNRYJi8gVkv2UQSQCEy?=
 =?us-ascii?Q?xLI1noEEDkLLRELaKyReQ9h61B+1He6rjrXcYf/2qklRTplLlHZijqk9BdzS?=
 =?us-ascii?Q?ZMV5gFvuKQ/qb1rfd3EjWibRen7qtFocOWtnmICMSbB921usST28pA6SX5ed?=
 =?us-ascii?Q?Aks8TPCuFMFNJb+q/zrXfEyYWY3Lws03SlG0PIg2tErflLgXgmK2hb1hK6Tx?=
 =?us-ascii?Q?g46/otuwZknR9ornkfQELDXj3M/9Ph2IIBffHPJNLx2fIzPNoBBQ37yeUTnv?=
 =?us-ascii?Q?2tt09SdYbnEoCDV9fe6+vE4/TAD+1bz5npKQ/xMhf9rWydz3MmgqDN6qGo9l?=
 =?us-ascii?Q?bDU3q6CI9BAc+CJ8U+MaORe5SXhwf7JGd6eY9U2nY6rP1alDFHcUKcVLrSZ1?=
 =?us-ascii?Q?AyR4/eOYxpcMm4J0HjEvLZXi3NjOK5z9cT+RZmCofYyLUhv6Ab18RiYQ1iWJ?=
 =?us-ascii?Q?K+/zkNoJVQxZ7naD4Vk0J9rZ5DdGGo0VdloDzpXw8Hi6bdvofBPYjUlI04h8?=
 =?us-ascii?Q?IM3L4NN1kg6QUVbGiOQzQ4Qr7O8ZkVIDJotVQ6LV6GIIBZ4vK3r66Y0wTosQ?=
 =?us-ascii?Q?NarIxLxpxmupdtobgQMyJQt5N5f1td3EaB9o4tNyTHlJvQKP15pS9eVLx2zm?=
 =?us-ascii?Q?JrOTJwKsx35GdRXC1equeXKLQ4Eo6nZEwMZ9HhpKtKhyHs+Yvaagr5YVS66K?=
 =?us-ascii?Q?xjfsMmoJ7+GtzR/Y8aGQ9Szull1ajFL9AFXtB2b3rckj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mc5osGfh3wQ6eAZ4vZq1HyXcOlB98ezQkQWe5L+isFOfNIGJpJU1IpNmwcNbb9Jgkg0EmQBxq3+TaYuAea65O4xYAue2LfY689w6833ZS2/nxe+NfEJGIZZ7WEwrHOu8tI+j11mSFv7H1DHVran71S7jcMziCUh1n8SRrqVaiW71KN8g9iF2pgscdla5l9/Z0bWTj4K0G2rqffa7jgTHXoLclfOXfCo3X3EkZ0cb1eFo6GnsEDT+3MzUX78jkCj2vUW9M6FF5uelxM72SoQfZ+k3n1uxA1CaCp6lvPyb+6XU1OlcKsLi/jPT+vSeGSEs/Z1VLxhGisQllovSkG2aH0afrqtDscPiVzl8hjnAYdaWrWmNDVvOx3FhauHULGzBl14IJIVMpOBvYTiWMZAZDojYVRvizGkBWEWEomNq230aOfjm68tw0QjYCqVNnqHT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:21:45.8151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bd5888-1a58-4203-a0b5-08de6e40a504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Current driver reports and limits memory allocation for each partition equally
among partitions using same memory partition. Application may not be able to
use all available memory when run on a partitioned gpu though system still has
enough free memory.

Add an option that app can use to have gpu partition allocate all available
memory.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..006883c31342 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		} else {
 			tmp = adev->gmc.mem_partitions[mem_id].size;
 		}
-		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+
+		if (adev->xcp_mgr->mem_alloc_mode == AMDGPU_PARTITION_MEM_ALLOC_EVEN)
+			do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else if (adev->apu_prefer_gtt) {
 		return (ttm_tt_pages_limit() << PAGE_SHIFT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cab3196a87fb..1da46eeb3f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1580,6 +1580,40 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int mode = adev->xcp_mgr->mem_alloc_mode;
+
+	/* Only minimal precaution taken to reject requests while in reset.*/
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
+	return sysfs_emit(buf, "%s\n",
+			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
+}
+
+
+static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!strncasecmp("EVEN", buf, strlen("EVEN")))
+		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
+	else if (!strncasecmp("ALL", buf, strlen("ALL")))
+		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
 static const char *xcp_desc[] = {
 	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
 	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
@@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
 static DEVICE_ATTR(compute_reset_mask, 0444,
 		   amdgpu_gfx_get_compute_reset_mask, NULL);
 
+static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
+		   amdgpu_gfx_get_compute_partition_mem_alloc_mode,
+		   amdgpu_gfx_set_compute_partition_mem_alloc_mode);
+
 static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
@@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = device_create_file(adev->dev,
+			       &dev_attr_compute_partition_mem_alloc_mode);
+	if (r)
+		return r;
+
 	if (xcp_switch_supported)
 		r = device_create_file(adev->dev,
 				       &dev_attr_available_compute_partition);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 720ed3a2c78c..f5713891f205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
 	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
 };
 
+enum amdgpu_gfx_partition_mem_alloc_mode {
+	AMDGPU_PARTITION_MEM_ALLOC_EVEN = 0,
+	AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
+};
+
 #define NUM_XCC(x) hweight16(x)
 
 enum amdgpu_gfx_ras_mem_id_type {
@@ -676,4 +681,16 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 	}
 }
 
+static inline const char *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
+{
+	switch (mode) {
+	case AMDGPU_PARTITION_MEM_ALLOC_EVEN:
+		return "EVEN";
+	case AMDGPU_PARTITION_MEM_ALLOC_ALL:
+		return "ALL";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 73250ab45f20..a2d50f90a066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	}
 
 	xcp_mgr->num_xcps = num_xcps;
+	xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
 	amdgpu_xcp_update_partition_sched_list(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 8058e8f35d41..878c1c422893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
 	struct amdgpu_xcp_cfg *xcp_cfg;
 	uint32_t supp_xcp_modes;
 	uint32_t avail_xcp_modes;
+	/* used to determin KFD memory alloc mode for each partition */
+	uint32_t mem_alloc_mode;
 };
 
 struct amdgpu_xcp_mgr_funcs {
-- 
2.34.1

