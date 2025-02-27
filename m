Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D16C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416B810EB23;
	Thu, 27 Feb 2025 15:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+JJH6KS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A01A10EB23
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MegyTQLGuVBAzxRxUuzhS8s0DoLvxG/we7UrSZlAUQAkUfWTMuFc/ga/CMwUYRWFnQAK4t6RnGLvrLOjXIBT76d3VjuUXcoOkaRAd93kJEMzLhKhXD5XvVTS030L+bA+I4F8oU/v2b5eE8DNtqZp+dBtavpF5X2mIoGgS6AESuzwPCNH10VmqqF6M9ZtNlldr/37tuTlOxjSoy7fI8PhivM+m4B7KZ+zsWo5fqEosW0jPjysTeKwV5PjfgmTRuwQmd8g0PRX1i66dWKA4g2/FCZ0yitxUL3fuhacVBKyzryG3ipl87dDw9PUPIYvBXVjQGUkmR579E2Q8UelkICtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou64fIJwocPS2uDNg+yjTXNmukL8H7USnOcIyvYEdUo=;
 b=Q905kpAuOoIxBJvdDYX8KK60865xtUgRcufpx3DPaNDGqL8f0rLVV0ZZVxV6r+t8/AD4WowA4KW0wWFdWl3y13i/YkFVhl+WNQIf4Ap/RQn9/35ECeGSG9eT632frNBSR+3GFpcZ9SYK3JUWhvZ49u1nm8kch2VfWeh285kM3jbHNh0KKR37Hbl4O8DMb8y/4iPDqTppbCZXExGK/4GfyQChJ258vjYByb+4mJNCt4XqC5l/qQpqnfJnpmJSbslvQmuBpyPIif4IiJFwtPpwxzxj2zNMEw3NtJu+Z75m9drJk1kiKUFAd1dWENfm3R+QKwlKh7YX/PXGvF4DyV5omQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou64fIJwocPS2uDNg+yjTXNmukL8H7USnOcIyvYEdUo=;
 b=s+JJH6KSGLHMubfYA3lhULQ8WrI0nDA7F3tr1jCP8ZreLFTEMO+58PQZBkZAwoilp6aEWLsEI2HD84dZad/lb+3mx7vlEPD9ElcC1AgxC+ZXZ5HK96duGZYv/MmfVB1iR5ffEsPwfOjP+rbMvXUt9ZcU13Ku9tVmc+jdzyUkYbk=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 15:13:45 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::e8) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 15:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:13:45 +0000
Received: from sriov-ubuntu-161.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 09:13:21 -0600
From: Tony Yi <Tony.Yi@amd.com>
To: <tony.yi@amd.com>, <victor.skvortsov@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <zhigang.luo@amd.com>
CC: Tony Yi <Tony.Yi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Date: Thu, 27 Feb 2025 10:12:17 -0500
Message-ID: <20250227151217.2620348-2-Tony.Yi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227151217.2620348-1-Tony.Yi@amd.com>
References: <20250227151217.2620348-1-Tony.Yi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ac2e36-f855-49f2-01c6-08dd5741541f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZtC5lGP+E9JZm1fDddO1PBRs+ViI0yO39YgbBd2Vfeh7p/JEWgP4ZjORrF2A?=
 =?us-ascii?Q?pjFP1dwsKJClSuhe8IUWH3o+OeDyvtTMnU4FkW+t6tb/wNnHm2qurPkf5JTs?=
 =?us-ascii?Q?MA68N1T17UW7JdHfut4XxxYfzgzP2PGvIbKl3bw89G35TPu20u/okjDsNvSh?=
 =?us-ascii?Q?nzdklPRwnE0O6jNY6Xb0halrcgtSLnitI/uDkB3bGJkXakDPQ3M4xhy4YWRm?=
 =?us-ascii?Q?WGIMKd/BT5LkUkWIyxyQk2qAbyKe8bu6rlJ9+NPJdLLti8ziiwMvHPqBOq5X?=
 =?us-ascii?Q?y+iYyLkAd4q+7ipaXvzBY6eQw+Fo3hktuWmb26hqcWMSMjLYeFOF9Xdvzpz0?=
 =?us-ascii?Q?wXkKzb2d0LS/c1cyO9u1IOQ16c7FD+fkl7eklrbOl3NOlq8mAwlX99vmsgXA?=
 =?us-ascii?Q?nWgH0fP0d9F4fwG4Utkb+MdOv60IQJ+bIDHaAJiz/j4+5mkkascqDFEDYfrt?=
 =?us-ascii?Q?S2kbXq/VOGiJ9NAdLtskfQQDn7HNwjjgE89K6zZ6EG+a6wytYqwJ/UCgqs8P?=
 =?us-ascii?Q?1Nte63f98YDrX7auebUKENKwPD7aNdMyfS1bb+EKF3P2ITbDHPsF1hD47ha3?=
 =?us-ascii?Q?EpDGy+FvcRNcpzU0B+a9tHym5nTE4lpI65dtDCGZcqFepZ1YcD2lHkgrue/n?=
 =?us-ascii?Q?JBWl/1PxFu4z/rPEtQqb/oUpD/WpWSAcTIc/liBDfKw5Oz1O8coWVYYXcYYn?=
 =?us-ascii?Q?oXrjIIkPAbTvJ3pyRPmrcM+7VfWzwm8sCx02D5N+WM+IF4655fp4eLyN1Oe6?=
 =?us-ascii?Q?2bZK0+cN9dUoV68oGZnuFTNgGYsx0N7Pte8uPFT8WW5SG2F03q7yqKaYkVwA?=
 =?us-ascii?Q?gxI6dN5jqlAYF1+sa5oPClKW7T9P+tSEr8dNC86XpSBn1DRNHmpq+Z/cqOLZ?=
 =?us-ascii?Q?dtZeuF7ZycsLnr22ELWAZxPPZBEIV+ReL7XlO6WleFqhqX2/L92e3vvFRxi8?=
 =?us-ascii?Q?Tr2F4mBTIfLkFLxguIjyQbegSbOkrWV6PbkWEjB671T/tkmBj3FDxZWK62Ea?=
 =?us-ascii?Q?SgajO216+p3jL2/4Mv4jUuerLMudl3bfehIYzMMZzIoyR1V8aUUitKfnLq4w?=
 =?us-ascii?Q?KMM9toCiPwpIUh+SdWJuGM8OQFMhqBA+uIHiNUQHvORzBymlbHeLqBcbl/+I?=
 =?us-ascii?Q?3RC+6Th9Fn2Mwl+olnlC71sY+3b4AMsi6mnNMWbfU49A+8pNLesBRPqqm3rr?=
 =?us-ascii?Q?6Q5zNyKvc5L+DRpgsJDUNzZCa0lEpmerxAVIuehe2V5qfV3NLZ6OWZZHnZcP?=
 =?us-ascii?Q?mrQiP9VWO5DOWog+oB7BJVKZkXqaC9IiyXOIgoc8CKsP6HoPG68MeHDDsljV?=
 =?us-ascii?Q?h4wdy0gn31PiCf38p3oJbG93FMVrFr4lD5K71nBBRmQNogoJvRbO8elUhwul?=
 =?us-ascii?Q?3276I9iCz5nZ6GkstWU1y1eLfhglKKd1sybxdA/S/xKcB12ef9XzlCJNCrVz?=
 =?us-ascii?Q?s/LWGAqowdHXXobWGtzgOMFAZSyFVyTVDQnwIOuqay5mGNIXewjJxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:13:45.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ac2e36-f855-49f2-01c6-08dd5741541f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Add support for CPERs on VFs.

VFs do not receive PMFW messages directly; as such, they need to
query them from the host. To avoid hitting host event guard,
CPER queries need to be rate limited. CPER queries share the same
RAS telemetry buffer as error count query, so a mutex protecting
the shared buffer was added as well.

For readability, the amdgpu_detect_virtualization was refactored
into multiple individual functions.

Signed-off-by: Tony Yi <Tony.Yi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  31 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  18 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  14 +++
 5 files changed, 195 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5e1d8f0039d0..198d29faa754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3099,7 +3099,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	amdgpu_fru_get_product_info(adev);
 
-	r = amdgpu_cper_init(adev);
+	if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
+		r = amdgpu_cper_init(adev);
 
 init_failed:
 
@@ -4335,10 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * for throttling interrupt) = 60 seconds.
 	 */
 	ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1);
-	ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);
 
 	ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON_RELEASE);
-	ratelimit_set_flags(&adev->virt.ras_telemetry_rs, RATELIMIT_MSG_ON_RELEASE);
 
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
@@ -4370,7 +4369,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return -ENOMEM;
 
 	/* detect hw virtualization here */
-	amdgpu_detect_virtualization(adev);
+	amdgpu_virt_init(adev);
 
 	amdgpu_device_get_pcie_info(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 81a7d4faac9c..d55c8b7fdb59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -578,12 +578,32 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 	return result;
 }
 
+static ssize_t amdgpu_debugfs_virt_ring_read(struct file *f, char __user *buf,
+	size_t size, loff_t *pos)
+{
+	struct amdgpu_ring *ring = file_inode(f)->i_private;
+
+	if (*pos & 3 || size & 3)
+		return -EINVAL;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_CPER)
+		amdgpu_virt_req_ras_cper_dump(ring->adev, false);
+
+	return amdgpu_debugfs_ring_read(f, buf, size, pos);
+}
+
 static const struct file_operations amdgpu_debugfs_ring_fops = {
 	.owner = THIS_MODULE,
 	.read = amdgpu_debugfs_ring_read,
 	.llseek = default_llseek
 };
 
+static const struct file_operations amdgpu_debugfs_virt_ring_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_virt_ring_read,
+	.llseek = default_llseek
+};
+
 static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
 				       size_t size, loff_t *pos)
 {
@@ -671,9 +691,14 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 	char name[32];
 
 	sprintf(name, "amdgpu_ring_%s", ring->name);
-	debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
-				 &amdgpu_debugfs_ring_fops,
-				 ring->ring_size + 12);
+	if (amdgpu_sriov_vf(adev))
+		debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+					 &amdgpu_debugfs_virt_ring_fops,
+					 ring->ring_size + 12);
+	else
+		debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+					 &amdgpu_debugfs_ring_fops,
+					 ring->ring_size + 12);
 
 	if (ring->mqd_obj) {
 		sprintf(name, "amdgpu_mqd_%s", ring->name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e6f0152e5b08..3832513ec7bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -739,7 +739,7 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 	}
 }
 
-void amdgpu_detect_virtualization(struct amdgpu_device *adev)
+static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
 {
 	uint32_t reg;
 
@@ -775,8 +775,17 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
 
+	return reg;
+}
+
+static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
+{
+	bool is_sriov = false;
+
 	/* we have the ability to check now */
 	if (amdgpu_sriov_vf(adev)) {
+		is_sriov = true;
+
 		switch (adev->asic_type) {
 		case CHIP_TONGA:
 		case CHIP_FIJI:
@@ -805,10 +814,39 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			amdgpu_virt_request_init_data(adev);
 			break;
 		default: /* other chip doesn't support SRIOV */
+			is_sriov = false;
 			DRM_ERROR("Unknown asic type: %d!\n", adev->asic_type);
 			break;
 		}
 	}
+
+	return is_sriov;
+}
+
+static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
+{
+	ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
+	ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
+
+	ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
+			    RATELIMIT_MSG_ON_RELEASE);
+	ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
+			    RATELIMIT_MSG_ON_RELEASE);
+
+	mutex_init(&adev->virt.ras.ras_telemetry_mutex);
+
+	adev->virt.ras.cper_rptr = 0;
+}
+
+void amdgpu_virt_init(struct amdgpu_device *adev)
+{
+	bool is_sriov = false;
+	uint32_t reg = amdgpu_virt_init_detect_asic(adev);
+
+	is_sriov = amdgpu_virt_init_req_data(adev, reg);
+
+	if (is_sriov)
+		amdgpu_virt_init_ras(adev);
 }
 
 static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
@@ -1288,10 +1326,12 @@ static int amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bo
 	 * will ignore incoming guest messages. Ratelimit the guest messages to
 	 * prevent guest self DOS.
 	 */
-	if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
+	if (__ratelimit(&virt->ras.ras_error_cnt_rs) || force_update) {
+		mutex_lock(&virt->ras.ras_telemetry_mutex);
 		if (!virt->ops->req_ras_err_count(adev))
 			amdgpu_virt_cache_host_error_counts(adev,
-				adev->virt.fw_reserve.ras_telemetry);
+				virt->fw_reserve.ras_telemetry);
+		mutex_unlock(&virt->ras.ras_telemetry_mutex);
 	}
 
 	return 0;
@@ -1322,6 +1362,98 @@ int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_bl
 	return 0;
 }
 
+static int
+amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
+				struct amdsriov_ras_telemetry *host_telemetry,
+				u32 *more)
+{
+	struct amd_sriov_ras_cper_dump *cper_dump = NULL;
+	struct cper_hdr *entry = NULL;
+	struct amdgpu_ring *ring = &adev->cper.ring_buf;
+	uint32_t checksum, used_size, i, j;
+	int ret = 0;
+
+	checksum = host_telemetry->header.checksum;
+	used_size = host_telemetry->header.used_size;
+
+	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+		return 0;
+
+	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
+	if (!cper_dump)
+		return -ENOMEM;
+
+	if (checksum != amd_sriov_msg_checksum(cper_dump, used_size, 0, 0))
+		goto out;
+
+	*more = cper_dump->more;
+
+	if (cper_dump->wptr < adev->virt.ras.cper_rptr) {
+		dev_warn(
+			adev->dev,
+			"guest specified rptr that was too high! guest rptr: 0x%llx, host rptr: 0x%llx\n",
+			adev->virt.ras.cper_rptr, cper_dump->wptr);
+
+		adev->virt.ras.cper_rptr = cper_dump->wptr;
+		goto out;
+	}
+
+	entry = (struct cper_hdr *)&cper_dump->buf[0];
+
+	for (i = 0; i < cper_dump->count; i++) {
+		amdgpu_cper_ring_write(ring, entry, entry->record_length);
+		entry = (struct cper_hdr *)((char *)entry +
+					    entry->record_length);
+	}
+
+	if (cper_dump->overflow_count)
+		dev_warn(adev->dev,
+			 "host reported CPER overflow of 0x%llx entries!\n",
+			 cper_dump->overflow_count);
+
+	adev->virt.ras.cper_rptr = cper_dump->wptr;
+out:
+	kfree(cper_dump);
+
+	return ret;
+}
+
+static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	int ret = 0;
+	uint32_t more = 0;
+
+	if (!amdgpu_sriov_ras_cper_en(adev))
+		return -EOPNOTSUPP;
+
+	do {
+		if (!virt->ops->req_ras_cper_dump(adev, virt->ras.cper_rptr))
+			ret = amdgpu_virt_write_cpers_to_ring(
+				adev, virt->fw_reserve.ras_telemetry, &more);
+		else
+			ret = 0;
+	} while (more);
+
+	return ret;
+}
+
+int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool force_update)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	int ret = 0;
+
+	if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
+	    down_read_trylock(&adev->reset_domain->sem)) {
+		mutex_lock(&virt->ras.ras_telemetry_mutex);
+		ret = amdgpu_virt_req_ras_cper_dump_internal(adev);
+		mutex_unlock(&virt->ras.ras_telemetry_mutex);
+		up_read(&adev->reset_domain->sem);
+	}
+
+	return ret;
+}
+
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)
 {
 	unsigned long ue_count, ce_count;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 0f3ccae5c1ab..9f65487e60f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -96,6 +96,7 @@ struct amdgpu_virt_ops {
 					enum amdgpu_ras_block block);
 	bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
 	int (*req_ras_err_count)(struct amdgpu_device *adev);
+	int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
 };
 
 /*
@@ -140,6 +141,7 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_MES_INFO_ENABLE = (1 << 8),
 	AMDGIM_FEATURE_RAS_CAPS = (1 << 9),
 	AMDGIM_FEATURE_RAS_TELEMETRY = (1 << 10),
+	AMDGIM_FEATURE_RAS_CPER = (1 << 11),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -242,6 +244,13 @@ struct amdgpu_virt_ras_err_handler_data {
 	int last_reserved;
 };
 
+struct amdgpu_virt_ras {
+	struct ratelimit_state ras_error_cnt_rs;
+	struct ratelimit_state ras_cper_dump_rs;
+	struct mutex ras_telemetry_mutex;
+	uint64_t cper_rptr;
+};
+
 /* GPU virtualization */
 struct amdgpu_virt {
 	uint32_t			caps;
@@ -284,8 +293,7 @@ struct amdgpu_virt {
 
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
-
-	struct ratelimit_state ras_telemetry_rs;
+	struct amdgpu_virt_ras ras;
 	struct amd_sriov_ras_telemetry_error_count count_cache;
 };
 
@@ -340,6 +348,9 @@ struct amdgpu_video_codec_info;
 #define amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
 (amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_caps.all & BIT(sriov_blk))
 
+#define amdgpu_sriov_ras_cper_en(adev) \
+((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_CPER)
+
 static inline bool is_virtual_machine(void)
 {
 #if defined(CONFIG_X86)
@@ -378,7 +389,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
-void amdgpu_detect_virtualization(struct amdgpu_device *adev);
+void amdgpu_virt_init(struct amdgpu_device *adev);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
@@ -406,6 +417,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
 int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
 				  struct ras_err_data *err_data);
+int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool force_update);
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
 bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 4dcb72d1bdda..5aadf24cb202 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -184,6 +184,9 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	case IDH_REQ_RAS_ERROR_COUNT:
 		event = IDH_RAS_ERROR_COUNT_READY;
 		break;
+	case IDH_REQ_RAS_CPER_DUMP:
+		event = IDH_RAS_CPER_DUMP_READY;
+		break;
 	default:
 		break;
 	}
@@ -467,6 +470,16 @@ static int xgpu_nv_req_ras_err_count(struct amdgpu_device *adev)
 	return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_ERROR_COUNT);
 }
 
+static int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64 vf_rptr)
+{
+	uint32_t vf_rptr_hi, vf_rptr_lo;
+
+	vf_rptr_hi = (uint32_t)(vf_rptr >> 32);
+	vf_rptr_lo = (uint32_t)(vf_rptr & 0xFFFFFFFF);
+	return xgpu_nv_send_access_requests_with_param(
+		adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -478,4 +491,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 	.rcvd_ras_intr = xgpu_nv_rcvd_ras_intr,
 	.req_ras_err_count = xgpu_nv_req_ras_err_count,
+	.req_ras_cper_dump = xgpu_nv_req_ras_cper_dump,
 };
-- 
2.34.1

