Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E311FD1CDAC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 07:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9492310E601;
	Tue, 22 Oct 2024 07:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQFevgYQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77AB910E601
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXzBpMo2eNgwLKKDHng3IuwNXxqHk8d4eN7AenIhURD9RMGktzMd4smqGSpZycYNwVXQ6rZO7KUmdYXKQSfj9YzPxHWfPcu8a2r6zUznp6Z/lv7eZLZuQyjLv9dYxrC7yJd6cjk+M/DpWvoVMxsSxmE/zKyHgYPhLaSF29uTzy96pafoB6LyzHO8nVdHfeH2Y0vL1L3u6XFXlMqjKiqc+Hrjp76YWxvC/11qqDp1qz4EZ64zRoMmSoMnUozyyROW1Gvfz3N2NbHLg4rpgHNohJns4aq/NTfHo5DgSBSUkhHuj4fv7AbikRq9P7Rl40u1APgJFHxPrLNcyFYcPEAR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFRudycDfY4e9QEBIAFwa4hulXKVmgyfhFBD98yJSL8=;
 b=lvyc5L7iuOjMR9XpIcUOnDaoQ0P+PeP2yqodN/UVTh/EqjX09EqUAnLWLmZSCTLjfNwY0OshVWvMKYrGXF1jf3aXeNaqHnugYCjPwm7kyPeKv8kJXqJtk0WUXU4a/RQyKnPQwBfL0BAi/Rs4UexvWXwDlT67wSys7ntMRjBskrvA8Ue02JSfiMGOxXCs7OandmnNFy40LZeUefccZfoTtI/dlg2VuIsgxLqAwspBDZM4xutNUK0jexA3gg4YjHNSku0j5yDJL7hbUm0xKv0pjC5cdg2megx43DwW9K+qluIO5MoAoQFZpA2FD108YCdjRe6Qw1gk7NEHGi1aXPhv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFRudycDfY4e9QEBIAFwa4hulXKVmgyfhFBD98yJSL8=;
 b=dQFevgYQM3mSQFvduyfCjzNWCCCnqhiSNm+jtj0Cn0naFqNtetq8Y0bIeU1TERS8nFbOuLo1RPbjREg4eNuucyW/8sKpacpEiu604V22Rovz896H4pyPVnGAfPYh1PjxuLIePonItbKYvR5IHTlJo293l1LMYgELJ5PJVflQq3A=
Received: from MN2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:208:178::18)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 07:59:30 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::e8) by MN2PR19CA0005.outlook.office365.com
 (2603:10b6:208:178::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 07:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 07:59:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:30 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 02:59:23 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Add sysfs interface for vcn reset mask
Date: Tue, 22 Oct 2024 15:59:07 +0800
Message-ID: <20241022075909.2530386-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022075909.2530386-1-jesse.zhang@amd.com>
References: <20241022075909.2530386-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c7824f-1414-4f21-ad50-08dcf26f7591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kz2NfINcj/hHt4PjaSrD0OUB1qIZ0vO8q/rlvPYIs7LfUdXkoIr21C8rtuNf?=
 =?us-ascii?Q?0g6tx38lBlAe5/tyzCKx8rOL6CbtK6tAkTEVnIHtob983Zo3+Z1hOVDfQl5Y?=
 =?us-ascii?Q?gyuwhsrd+djQyl02P1gF3I0riHA4WRulk2SbbJEJfhXjnBkB3scGiGRv0mtM?=
 =?us-ascii?Q?g39EJH+vUY362coKs9UgGo+R2UAHnCFP9SAl7AJCYbyKfxGQpnEQx3HcOVF4?=
 =?us-ascii?Q?n8An2YiA/IZDwFNYqtMjviV/vZQ+yPM59gCM0uDloSxi5lv4W9zGpHdcHwsR?=
 =?us-ascii?Q?gBVpStQSuxx83CeZCKLXuWpFHkzyu34N3MJxFVdhPENp9Qk0rCC6vx1Wici1?=
 =?us-ascii?Q?YqmzF7JDUbygjAcvAPSvJqzkhrXzA6VlK87yy8QFYpBfQng9YyVCWh54qsbi?=
 =?us-ascii?Q?ez4YY/LwqRDSOmXuDlObbks4odXNIMiFA8HBT4E0i6dwCT6lY3Tqf27924cu?=
 =?us-ascii?Q?6tUMIodT/ATZZzuISX3KQDi9qkTIzHIKNo5D2hXwg3GtGBxDYk3duHL0FOrz?=
 =?us-ascii?Q?1dGVxn8ubtVgKlFZRjrNgzjSwN8wc779jRBRGV1iRgtoNtYSw1Bo5JjQY67a?=
 =?us-ascii?Q?+WqBR7vdIgzXYDxLMIiEcDK4lR4XXGopY4UzmpZpL0xd5gK/PENQy8Z+dD/8?=
 =?us-ascii?Q?vWUzi7qLimftaQXZw8aiPr/hrA9V9sY41iaU/JM1IgTweoG/KJlB5i2780pf?=
 =?us-ascii?Q?GkdKuTdYToRv3MF3zxi1KuPetXg4+EC3MBUvOn+hA3SKhZ7ST/YXQtvfQBFa?=
 =?us-ascii?Q?yZVdYpPXNagIqbngPqcjlcshivcOFGOQFgk7Qv6bxYKmTsBKIO+UT4rzJLCZ?=
 =?us-ascii?Q?QgY3a8+RetJeeKRCdcFaITkpMQ8kPcqTCQeY5UASLVgw1V8lwpmOHZukVB6R?=
 =?us-ascii?Q?0HDLcaVMWxml9hWyyIghYUad/MkPL2egUqOAvduFiZrUbTO+OPwxg0XPks0Y?=
 =?us-ascii?Q?3mIJAc4Igd0BR9TB+aoTynns7r8ceoOYKBTQKmMm5/sqKVppC8ajLds4Ojfo?=
 =?us-ascii?Q?BXCrBs0QdwqxeQsGiSs9bW3Z75F/mTB4oiLTmfQ985REGbqvVj9q5gHhKGxV?=
 =?us-ascii?Q?ZSDAbLWsj+20hEelDseuX0hjApIOrzoHAm8DY7OwzYK3wEf5RbLaMlJwUvPR?=
 =?us-ascii?Q?pcsKX2+LHEKntiq3/0NI0oWr7BVVaYo3YG+84S44ZSXeUzncc4dsdv4aN2up?=
 =?us-ascii?Q?FZHAG/l+a9Ko9pl6T6pjlL7jDzY5ViKe7/GTgOfSXNiSNEzZaDWDi+pZis0K?=
 =?us-ascii?Q?8lISxU6H/6LZ8tNTE+/9nyrjfBaJOvBrJjlwsY6ZU8V0GYkJNEZiDAWwwElc?=
 =?us-ascii?Q?B3TtAokpd/aPvNeUiMEy59DjKhUs6fTB6qL5E20vx3gNdcNrZq8ZvElWJg04?=
 =?us-ascii?Q?+pRk+5HaLf+3wnU6dh4vb4gBFNFQxXHAK3iTMY1Ba0CmGFWPmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:59:30.6915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c7824f-1414-4f21-ad50-08dcf26f7591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Add the sysfs interface for vcn:
vcn_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  6 +++
 9 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..409ad6185cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1277,3 +1277,52 @@ int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 
 	return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }
+
+static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->vcn.inst[0].ring_enc[0];
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset)
+		size |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	size = sysfs_emit_at(buf, 0, "%lu\n", size);
+	return size;
+}
+
+static DEVICE_ATTR(vcn_reset_mask, 0444,
+		   amdgpu_get_vcn_reset_mask, NULL);
+
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->vcn.num_vcn_inst) {
+		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->vcn.num_vcn_inst)
+		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..d52c3f752c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -518,5 +518,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 129c759772c2..5d03d4c0a273 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -207,6 +207,11 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -228,6 +233,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_sw_fini(ip_block);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 19bbd49f760e..6a7a55bc96bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -231,6 +231,9 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -258,6 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 13632c22d2f9..7c5838060bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -293,6 +293,10 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -329,6 +333,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index e7b7a8150ea7..b2fd59c55804 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -247,6 +247,10 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -284,6 +288,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6dcae398b2dc..d99787f4dce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -206,6 +206,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -239,6 +242,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index edb9cd8390b6..dc73d3d927e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -214,6 +214,11 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 89bf29fa6f8d..b1d8c31de764 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -181,6 +181,11 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -215,6 +220,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
-- 
2.25.1

