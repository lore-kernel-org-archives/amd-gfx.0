Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4F2D5B87A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 05:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AD610E596;
	Tue, 29 Oct 2024 05:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wj2VAnCN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1623110E596
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 05:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuMgROHix9rbun1hNNarMGbRrHiTMHHU3HXWQag12F8AdumkYL1gcvhtokEOoq8vbz9WEErInNI0tBFIwnirpoJkdh3ZhA+mrgcnE9+o+N+viKS4CK6yXqaWiURaANNA4uV3cQyFghysuQ51T/TUp+yDUZ9oHpkmFFL0++4Cw5/ppd/HQ1ZRaUzsNquypju3duD5iw/cHmjUJOFY2PyD9wjcH7MePh2cbFxO/E58T64MmKpP1Jd3phCGl7P3ydV+ValVSL6kkSPQ3luvHSLENR+LQOLbhdda1XUghBy88zDojMwb/hm46Dfs7AgpqxxnyPqa9tRqp/BGGJcYbRy57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTWfWzCvdNRrX4KIPDb2eCx+nz75aLksLZW3GwVP0ls=;
 b=BpVY9xS7u73F63dSs8Kv3UeGpoWb7LI4oTYlV4JDVdDJ9xUeUo59JEXWHbbe2K292HQpDZbJI7tSiXvEylklxA8HeynHzJZ/s4/ODDlBmcFx16jvRMS4Aksy1w/TgTstCclGzE06r6W2knTshMiZkoKrCwfi2AA8WV6c5pNrthLgmShs4IF8Zeu55nWSNO1zr35aJ7r3pgeg6JQpUz7YV0xdJbiwhCOvSUSCj7P+sSjqgdWE3dG6bUjoWpxqYaCzGwZyafhszKZR2mHq9Fr7cr91gCZPLY2MphTVhM/yw5YwnyJHzJUhvHMNdYPDwNXo+NCTQ9snChaUZ4R7sFuJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTWfWzCvdNRrX4KIPDb2eCx+nz75aLksLZW3GwVP0ls=;
 b=wj2VAnCNe2WytpSngrv1ZnqtVM+P0lVpBca/HaZ8HMfzDVoNsvin3PzGpsYS6jNyfhuuu3twa+X1O9MXhBLjUwKlfOWOadmgvb2zT917n4eSxFim9BtiehcxdBehcjpBMQWl7Qtmo6S4al9nAZ9VS4ZYBav7Cw7WD6bT++ePvto=
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 05:27:19 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::a) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 05:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 05:27:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 00:27:16 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Group gfx sysfs functions
Date: Tue, 29 Oct 2024 10:57:00 +0530
Message-ID: <20241029052700.3164571-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e31ed16-d739-450c-70a6-08dcf7da5b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?esrFe1zWLMUOqrsb2kjUgu8Snx6XqIzDwLYcpvUcq6Dq+iByNJlQMv7oT0Ro?=
 =?us-ascii?Q?KIrcKrA8JNqPDOc4a08ybRhc4mvi+aDXYHjE1CI+tUL4DbU7fPV4TLw4w6QJ?=
 =?us-ascii?Q?IRd0Qm/lyZgxo/XiBj+ce9Ar9UCa5wrlGig4t969Gmd8qajU1zYpQGXb4PSK?=
 =?us-ascii?Q?EjfnVcurD+lHjzmSSBM6SCTBCcOvEV99md63WEA8+36pGi6+Q+Fx61czsMj4?=
 =?us-ascii?Q?Dr7wi5d+YYpAJbCL9LGsGMKuI1hK23w/vnkxcLKPs23LTHb7Zc/ODroB78L8?=
 =?us-ascii?Q?06UUEyeYUqDCnDgN8FUuRbiYJTA5+9Quv6gmUlOiKq6ErnMLB79tD7lJ277u?=
 =?us-ascii?Q?bGLkUg3VuAKOqbyj46N3aBhaKd3s+5FRaXX8+ifIDgeN/5Lu2Lh0pAjI8otG?=
 =?us-ascii?Q?TAxzOlbAKxhs3ZUnuYYh42PwlMOJgLGC0n08ZqQK08aWXKcGvq/3z1FQHlvZ?=
 =?us-ascii?Q?8uEPHVUEEN+/+913L+S4mmh4KhtUmn4EEYyIH5Q2wUJVTRYGRcgAD4w0wtlH?=
 =?us-ascii?Q?/qQ+tPnohrY+h9OCzV2eh3nJzj+WXvh7VXtvjc/8ak09JTxeggkqXKfmllaJ?=
 =?us-ascii?Q?na5cW5SVyzyIhSx/prkSSYF7Ij127FpySZy4CMYjRG3aPTHaoXs7hNHBfgMo?=
 =?us-ascii?Q?SGkgHw3GZCqrRBZ9BFGgnj5jW9THiqk+QK095jDuFBYjDI+OdUNkhxcYUksy?=
 =?us-ascii?Q?inWTxabEmI1VJbevqWQeMGiHkKdwDqyUls6ypBH2ddvj8M6JSy7FMSjawvSa?=
 =?us-ascii?Q?bpnuzdAaoZ2ZrjJT+ig4nMH/KFlBhq/JhaZxSB1PS6+qgWIr+I9z6ne3JNvE?=
 =?us-ascii?Q?V8qlbSMCSZx6mhej1gigiwlRvYKB0Q9Wl+t4ii/jVryz1Z3HJGimW13Z13fI?=
 =?us-ascii?Q?iTn3hnZ0f8IMsubrR7waPIi9Uwn8QZGKPrylntfEexU/F+Z9tQqPZSJmcaw3?=
 =?us-ascii?Q?BTizuiwa39uv+5/vxKJmenCpw2P2DlkqONII2IM+iKuosQjQwtKyfeYmI354?=
 =?us-ascii?Q?nkKiyrMju9O6eTOLGMSOdtLBacipvHSvuz89qUvsXRLTvjHzMQlWPN2Qjed3?=
 =?us-ascii?Q?RBa/ijyA2xA5sYUOzgbhFGm1QGzRTTgjf3yPNFH9CgYk0dvETsU5ohueHCcH?=
 =?us-ascii?Q?Q03A2u081LRBAa1rFTarn5WuJBMJIU1XDKfI4uthpmyGvmxvWUd1CZL6Z9oi?=
 =?us-ascii?Q?FYE04OvdT1GeNBW/ojN31MYDnQ+hStb4J09izfCvGZXDfmHTcfiwIeU7pFGD?=
 =?us-ascii?Q?h+Y5DCesHAe38/BajCfvrdE0CWFky4z61YCA8GpIlcXPJNrf6T2VOotZ4+iV?=
 =?us-ascii?Q?jOerugzJN8SejaQRYH4E/2ZX5JLZ0CVzKxJOZv+57mp1oaC88JOVOT5w3iRU?=
 =?us-ascii?Q?aC8UAw/WWCsGLRaOm1il3iGZ32pLGqAprMUd48KUv7ScutHMMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 05:27:18.5371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e31ed16-d739-450c-70a6-08dcf7da5b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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

Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
gfx related sysfs nodes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
 7 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..86a6fd3015c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
-int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
 	bool xcp_switch_supported;
@@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
 	bool xcp_switch_supported;
@@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 				   &dev_attr_available_compute_partition);
 }
 
-int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
+static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	if (!adev->gfx.enable_cleaner_shader)
+		return 0;
+
 	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
 	if (r)
 		return r;
@@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
+static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
+	if (!adev->gfx.enable_cleaner_shader)
+		return;
+
 	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
 	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
 }
 
+int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_gfx_sysfs_xcp_init(adev);
+	if (r) {
+		dev_err(adev->dev, "failed to create xcp sysfs files");
+		return r;
+	}
+
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		dev_err(adev->dev, "failed to create isolation sysfs files");
+
+	return r;
+}
+
+void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_sysfs_xcp_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+}
+
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
 				      unsigned int cleaner_shader_size)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..b8a2f60688dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 				    unsigned int cleaner_shader_size,
 				    const void *cleaner_shader_ptr);
-int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
-void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..d1a18ca584dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
+
 	return 0;
 }
 
@@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
 
 	gfx_v10_0_free_microcode(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..22811b624532 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..1b99f90cd193 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 66947850d7e4..987e52c47635 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v9_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	}
 	gfx_v9_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..983088805c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v9_4_3_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
-	if (r)
-		return r;
-
 	return 0;
 }
 
@@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
-- 
2.25.1

