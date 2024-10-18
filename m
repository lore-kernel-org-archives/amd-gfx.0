Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB281D3C53F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 02:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584EE10E34C;
	Fri, 18 Oct 2024 02:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCvOheGA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFEA10E34C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 02:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuQlRSlsneIpQ6BR4T1re74/HtmMsP1S7T3LG1BVQzK0OE6LDHz2yg7G92Hu8g+CzF3I5JjmHjU5iblJ6A7QJ2zeHBPdFSMlk2GX6LBaXvv9RjMM3AJEbMc1dmgHrZZ7CTsV/4IZDcAsJl3c+YvjfS5s1j/FfN1yZ280W5Voxhb8IMteEDos4CZzC03P/gTpD4by4fN+9UMry6TAoia2A5GJDSVq5kvorXiN4imau5J9IM13OQwrnjuhBEgbnTuz5FMPdYiIQ7/ZZRAsEMKXZfa2dCEIL5dF5DYvFhtRwMPprkcWztph57zaRoOG1Gte5wYczs7RvoJpoa3JTxaxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7lI0KcK7BI7xVknODCJPigEDx1NELUB6WadJCgmd4g=;
 b=EGkYu7mUSqqgEPwgTZg74ajZekJXVLpxUJ4r9jFKy7RFdSOdXcz5a8XdD5IrNhXYbUTA2wJpBIgOQyry0xiQ8dS0LEITsqgA8o7lTJZo1zTXu3vs7x88thQHa2ChlCoeP8E+40IIgdzJHcXpPCZZ5/fSHxMkj58QiIePmJIIbNbiH86z14K5jxZ0fqVEUnkLSbdvJxIpIIuycUjsqrs6RBUEc96lIV370N5neW0yt1EHnPutD4YRlt+QuW9vbhUksjTQyhZPw87P2EidvvWhzj2sKYQFNTzyB0GeO/UYG9X8DoaJYLf5Hspt2TKP/FoP93bZ9lWYkpV5a2RRNqchAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7lI0KcK7BI7xVknODCJPigEDx1NELUB6WadJCgmd4g=;
 b=cCvOheGAoAA3S7Suc72ZN9tAb9etV9X+aC1qhRtMjhrWnpeLGWW4TvMepK3ix5MqiexVueIrwd7603rj9Zne4Xz9BIKm5rgsOjqN/+BCA+54X1+hAvm9YrVTShtk82ph7tfdjEgFzrBZSTcwaEwnbstN+QwXxLSqT5RuZeB3Q+4=
Received: from CH0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:33::23)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 02:30:58 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::41) by CH0PR08CA0018.outlook.office365.com
 (2603:10b6:610:33::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Fri, 18 Oct 2024 02:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:30:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 21:30:56 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 17 Oct 2024 21:30:55 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
Date: Fri, 18 Oct 2024 10:30:53 +0800
Message-ID: <20241018023054.1601248-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: d36110fe-d8ad-4e44-9fa0-08dcef1ce5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZrrsdZ7DovTi4qnBupxWegbP8okDTo/g8qeqhBMiWDmADS1McXj49DDCrLdp?=
 =?us-ascii?Q?l4qACFqpjL7X58N7TPrBUCRAK6t+S0VkUzfbksYt2aR1uEOvM0VvtEkfE6jV?=
 =?us-ascii?Q?Rpjord4REAeB+EA/f7AV5kbi1A2dSGYG5WL1FpfRF8mOlqsPzlrgdS2WojHX?=
 =?us-ascii?Q?Tk46TYVcF95yfknu6Mum/LLE8gUY91zLW7jdCasAFmw9mnHhYOpG+oDvGDVO?=
 =?us-ascii?Q?1E2FkH7Z4L+F42g2hIbHjDsmClngVKJiUO7AXV4MKzhr8durL71hm4sgMx7s?=
 =?us-ascii?Q?Gh3y6adXI+nfx3xn91B7zkE6r6VvnhQVCpTPElZrJuPWGbm6fSOyHMJ51ItR?=
 =?us-ascii?Q?fRJg3zQjQVxcdK4whpyM4n1LFJ6F8+WnVXaHsx732whjlAqe2LxkQDU6kE2L?=
 =?us-ascii?Q?9l/MbMyAsAWlr+Y169CQ5ZnzulBvBsry5gmsrHTQJa1VuF4VFmei8qMS+RPz?=
 =?us-ascii?Q?AYXnjCojiflooydxxP21jHVs5SgcN7YGQGnz91342ee8D+3ME76Hvnm9t0qu?=
 =?us-ascii?Q?IyyNdUiYvJPGI2ACfqaJURUiRfeXeY4gHBm9Kd3yNYEoqz5BcWm+hMCXHL6+?=
 =?us-ascii?Q?g+xmsIJmBLmC4/j4C6CRYfkru1wVuzJMnMPMHA97Mu2qItKsaZMwUUDu993B?=
 =?us-ascii?Q?Ygh0Mg5VEOG47cqSB70ACfPEf9wbEDNB6N0wHezY/hGdfiZVEH8vuHu+gO1V?=
 =?us-ascii?Q?zP+liZ/2P2r1eQCFYshxpZFdiQUeMDGmVV9F8r4wv6elqA6PNwdAQRWv508g?=
 =?us-ascii?Q?DO4zN/otOjKiaJlM2a+8pzTnfKFNPY7DUf4FZq9bqq+b+4rBkTUZQPZFzRVL?=
 =?us-ascii?Q?BrDd61M4K9XXoVsCpscdR+bjSQ1rhpgwncm9NO+3i7bgl3Kdf0xBzYKZsUOI?=
 =?us-ascii?Q?8YtJc0blbVsQbNxOZGIe0DNE/oImqeljLXxSH5QtljDSWY2v3MmUxgCn6TIJ?=
 =?us-ascii?Q?KdNKQmPdZfXthXPCRV2lHXO035wtWByCNHRPkmf4mhtaBbpTPR2JH3UBu9ol?=
 =?us-ascii?Q?s1tQc3csTMSm+5lJxQnh3Ut1wn5EuZSNNuHZ1mwZRMAhdgh7+EeKaF97Qmvu?=
 =?us-ascii?Q?/AqjjnWDCZkcJP6CHqXW3U6tlL5e3S6xBC2Ow/NGiLUerHnA2IUyvT97w/+A?=
 =?us-ascii?Q?G5T286eQbswZgy9iktSpH74KoECnHhfAmkRlwWOHazzM2Rt2BQ9zZBnlYswt?=
 =?us-ascii?Q?VRAqHdYi35wazkkehuAuSSY9s2audyL4ZvfqNr+w/3r4k824jRSX12ApuO3c?=
 =?us-ascii?Q?jWQ9rbbVsU1yS7oPGeRN7dphObWZ3rErUTpNPkE+q6/y2bds/ysyHkheO+lj?=
 =?us-ascii?Q?Z6gbJ0Kx21FAG9vUcbYYFuC9g3yDgN3PGGjclH76iNaK8U0JpJm2QGYwY4wO?=
 =?us-ascii?Q?SzBDKsB2izhHsXAwC3PqxafSlubJyO/8J3k0P10hWoZskj5yMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:30:57.4336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36110fe-d8ad-4e44-9fa0-08dcef1ce5e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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

compute/gfx may have multiple rings on some hardware.
In some cases, userspace wants to run jobs on a specific ring for validation purposes.
This debugfs entry helps to disable or enable submitting jobs to a specific ring.
This entry is populated only if there are at least two or more cores in the gfx/compute ip.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 142 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     |   2 +
 3 files changed, 146 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 37d8657f0776..6e3f657cab9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2096,6 +2096,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);
 
 	amdgpu_debugfs_jpeg_sched_mask_init(adev);
+	amdgpu_debugfs_gfx_sched_mask_init(adev);
+	amdgpu_debugfs_compute_sched_mask_init(adev);
 
 	amdgpu_ras_debugfs_create_all(adev);
 	amdgpu_rap_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b6acbe923b6b..29997c9f68b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1868,3 +1868,145 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
+
+/*
+ * debugfs for to enable/disable gfx job submission to specific core.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_gfx_sched_mask_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+
+	mask = (1 << adev->gfx.num_gfx_rings) - 1;
+	if ((val & mask) == 0)
+		return -EINVAL;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; ++i) {
+		ring = &adev->gfx.gfx_ring[i];
+		if (val & (1 << i))
+			ring->sched.ready = true;
+		else
+			ring->sched.ready = false;
+	}
+	/* publish sched.ready flag update effective immediately across smp */
+	smp_rmb();
+	return 0;
+}
+
+static int amdgpu_debugfs_gfx_sched_mask_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+	for (i = 0; i < adev->gfx.num_gfx_rings; ++i) {
+		ring = &adev->gfx.gfx_ring[i];
+		if (ring->sched.ready)
+			mask |= 1 << i;
+	}
+
+	*val = mask;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gfx_sched_mask_fops,
+			 amdgpu_debugfs_gfx_sched_mask_get,
+			 amdgpu_debugfs_gfx_sched_mask_set, "%llx\n");
+
+#endif
+
+void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+	char name[32];
+
+	if (!(adev->gfx.num_gfx_rings > 1))
+		return;
+	sprintf(name, "amdgpu_gfx_sched_mask");
+	debugfs_create_file(name, 0600, root, adev,
+			    &amdgpu_debugfs_gfx_sched_mask_fops);
+#endif
+}
+
+/*
+ * debugfs for to enable/disable compute job submission to specific core.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_compute_sched_mask_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+
+	mask = (1 << adev->gfx.num_compute_rings) - 1;
+	if ((val & mask) == 0)
+		return -EINVAL;
+
+	for (i = 0; i < adev->gfx.num_compute_rings; ++i) {
+		ring = &adev->gfx.compute_ring[i];
+		if (val & (1 << i))
+			ring->sched.ready = true;
+		else
+			ring->sched.ready = false;
+	}
+
+	/* publish sched.ready flag update effective immediately across smp */
+	smp_rmb();
+	return 0;
+}
+
+static int amdgpu_debugfs_compute_sched_mask_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+	for (i = 0; i < adev->gfx.num_compute_rings; ++i) {
+		ring = &adev->gfx.compute_ring[i];
+		if (ring->sched.ready)
+			mask |= 1 << i;
+	}
+
+	*val = mask;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_compute_sched_mask_fops,
+			 amdgpu_debugfs_compute_sched_mask_get,
+			 amdgpu_debugfs_compute_sched_mask_set, "%llx\n");
+
+#endif
+
+void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+	char name[32];
+
+	if (!(adev->gfx.num_compute_rings > 1))
+		return;
+	sprintf(name, "amdgpu_compute_sched_mask");
+	debugfs_create_file(name, 0600, root, adev,
+			    &amdgpu_debugfs_compute_sched_mask_fops);
+#endif
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..9275c02c94c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
+void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.25.1

