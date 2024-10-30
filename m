Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AFED7495A
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 04:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5A110E13C;
	Wed, 30 Oct 2024 04:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hN2afGdV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CEE10E13C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 04:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o91cXGWlZUdGTT98qeECmzXSQmkkc9O3cTkqdCgw0XO7hu9AGXnyyHS35Dd9PuBlHZXfobNgvVxuMn2cPtEttOAjy1BqGX1s1/u86hVyo3nZyYSMLu/TODb9ChCFXy2Pa2yNz/h1NZ2wKyKtT8cP+TMVtT2bGxxDyYB2My/aJan20L7FbOdN4205O5/Z/Pcq6VdG3pMRgU9GNZ5nR9reFvXEPiWSRmbWMtR+N4WuwsIx45luSJ4K6hb5bEs0Rudx8EJYeyj0zPXFK8QVL7pk895rghMLaZbb9StJM0WpwSOTQExOJX569xM3hbSNFbfqduF+SVTNRKmR8Zn5W+4pZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABVdTryOFfosYqBY2P4AOhpUp6VDh7roqD/kpwW0htY=;
 b=RhC1ME/Tunrj6L2O7r9UU/o1y/7x2Irno539BTZwc6K5/SHPSmirI6Io3O6HMJOIQfl/hEizvb3StWfx/3zTiv/FHD2xQmH6wKbGkPoTJqDleUiXOlK9hrxRBHcFjukZIumOHwS/RE/eqIoz33XksMBH2cNmFykHdHWLqSMKvep3OzXqrI6KtKvYOQzmwaX8sq+plbWxh45v+VvhhTox8pqxsZobXRakMKb6HuIUS7aQ9ubWXGwpzPc2OvmCvgVr9dLMPjSinnqnCQi9GL/d6pWRzyrHErPQyz5VPejEk5k12XUElQ4ZbrEnvxAGjwMJteY6jfLh8UgY0VdjqiGblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABVdTryOFfosYqBY2P4AOhpUp6VDh7roqD/kpwW0htY=;
 b=hN2afGdVSDY0QHHgqa255elRcMRPlaWTNJxAeBU9A7Z9OqPCNJJ3PejkPABj/Rh5qWdRbbDk55uKuFgRkEe5gNCFFtCpb2FrB/OHKh009AGjc/RZjtDhlYs23gyQMmF+PZZN0ID5IghURBOJzQ4XFP2AXQ3C6aDlJuGkmDy73Qo=
Received: from PH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:510:5::22)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 04:18:51 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::d3) by PH0PR07CA0017.outlook.office365.com
 (2603:10b6:510:5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 04:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 04:18:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 23:18:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Group gfx sysfs functions
Date: Wed, 30 Oct 2024 09:48:32 +0530
Message-ID: <20241030041832.3179034-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0c3e7b-f250-434c-d0b3-08dcf899f596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q5lFHkFGW0WCrgMc67q6ynR/u0A1z4ZAMArX9jSEE5LF+mRoeVWZoHuE+pxu?=
 =?us-ascii?Q?ci0ixc8kkw6l5BnZ4tUu1B7mbIZpQtQ/M6SY0Xk5AVg6VlM4V3EoP4n178e3?=
 =?us-ascii?Q?IIiNhoNmfxfukq3vBQ77omHoraU7gvVsjzZHNb3ehzBfnfAIN0r9AtLTsGYn?=
 =?us-ascii?Q?DxbWxZ1hCBe2y+F+K2FocjZYAynpVToT0Xxg+PYZQmARvaWN5UlIrkmOA+xm?=
 =?us-ascii?Q?0xnnPF7OrI8tJzQ+4QunYUej9OuE89M2F7RsqgraP5dIiP/eofSusDoWDk7n?=
 =?us-ascii?Q?69j+OW3t27Urt1Sq3kbOqeli/WsbxwaIIr7oY2HjO7Zsjyw27que3T5XvKhN?=
 =?us-ascii?Q?ZwekysZojsgQgY6cY8qmXPyf1L+Me0X/XyORyRkYLfvxvYa+9srOhov054hD?=
 =?us-ascii?Q?9za7eYyRj3NLkVbL55pARmnf9dxB4lJuAMfoBPTP8camNlyUTrO89VhZet/Z?=
 =?us-ascii?Q?6EKzj+wvLZJ0Bq+vFBWfEa/2iLJAx9KfuN2kFy3xUF2JrK3qRtOxYK8O/dXv?=
 =?us-ascii?Q?NyvVEMEini2ri/JkAxCYn+F+7N7arocd8a8ZDORooNkSNmusQqDP8CiUBnXi?=
 =?us-ascii?Q?5o/Q+yZdSy+ihugHgmUkSWQoUx6y9IkCdNHCqhefHe4sdMuE7Uh/HigzNHwQ?=
 =?us-ascii?Q?r1nXA4/nwT8Q5oYYkKw7MaGRvIke8iLsBGFCvolE1HV6uomdQBi/25e6LlE+?=
 =?us-ascii?Q?ALWduVfekq5Rjep3JNi6b2gJrHORvIfF6zUUiTT3UBood7Xg8vT2ts+9PvvF?=
 =?us-ascii?Q?zryTqNF/nBntOz1fkMHAapF7jvoq3PDMOCTD/YAJB0j4YtXVePqCZTuwV0rg?=
 =?us-ascii?Q?br/6ihIIJgf0gHxHbmpbJtM8/AFCjzBmLLJBtI113GTFso+JVzhOC64UgRuk?=
 =?us-ascii?Q?0I4V2y7hmukNfo8H7isZPI2XbVDxYh6BULRUSmVpjfI87uTbeCUdaVpXZq91?=
 =?us-ascii?Q?ZBiVLZTm0eWda76/1qwRCy4ihsBxYM/Yl4P2ReCDEjLSamxdp1fegdLR9PaS?=
 =?us-ascii?Q?jnxr6mU8vWuYAp9MXUYlTOW8snJjZWhXA2Ihfg0AZPJZqshdJtVdN1zfD5jb?=
 =?us-ascii?Q?GohR/4RODW9MWDjLcKWNaonyVIosY2sCCFmPXPlCb+4hu//uRDY9b3zyOPjK?=
 =?us-ascii?Q?QWEu2+Uh5SINzpaQJIiRcOUit1XdjB3Mv3a/NGI9xBRfgE2VuA5/+sUo4Sfg?=
 =?us-ascii?Q?S51vLV+dxpqgThKR+D7f0fp0RWp86V44cVdm/H0bZ3om43EoSRgDHT9osgoK?=
 =?us-ascii?Q?N4g07AQJKTM1KGv1MlGEg1RFAljH1O/iRvztDbpp1Me99EvAWEFx4q9XsPeN?=
 =?us-ascii?Q?10ItZ4soGyDZ8baCRrEkDosaerip+m447IYC0+HG+Nb5bO2iu6HmI/25Wr5S?=
 =?us-ascii?Q?HqTyaT8V8yQ33OomB6fJcxJ7hgCBRZQ+6JAQH3bhhQCIU5SJ9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:18:51.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0c3e7b-f250-434c-d0b3-08dcf899f596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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
v2: Check cleaner shader capability only for creation of run_cleaner_shader
attribute.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 36 ++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
 7 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..9ede3fbba54d 100644
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
@@ -1646,14 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 				   &dev_attr_available_compute_partition);
 }
 
-int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
+static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 {
 	int r;
 
 	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
-	if (r)
+	if (r || !adev->gfx.enable_cleaner_shader)
 		return r;
-
 	r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
 	if (r)
 		return r;
@@ -1661,12 +1660,37 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
+static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
 	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
+	if (!adev->gfx.enable_cleaner_shader)
+		return;
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
index e9248a855ba7..a880dce16ae2 100644
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

