Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B49D3DEA1
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 17:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9CC10E37C;
	Fri, 18 Oct 2024 17:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1bMYFYP";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E411E10E37C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 17:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELrRkXQQbDjVc5OYw5sJRnBncW1OTbymlv4Zf+UiadCy/oElNp2m15UZX7POXl8/68NYkkx/LX3BYu2WGGF0BmjZqTSjCdhjEKRworW8bSG5PwUhA0Euf49iXyYM1uujHYt6IqzNd2P2zhNpQphRA0EJonf5szLrB9d1zemkN26wrWFl792BwlFW2KgDSQf5f0Fyz0tlZoEY04bDRCN1rgHnKx7g2zP+vYbjE8/56soC1OygJvm7kk0i4/Fgn+28JIwyQdduFX+H8wxFxJV/kOQpuA+AFT4X3oS1jkCilbkpK12xfmLEZlqeua+erJsQpEeLKcdWdI4l0qltMsTl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRW6twaXubiMdLBXDTl+OHIJkHU2DP0otvVjAq/dsOc=;
 b=GIqJwbE/JSnAuYS9zyQMH7ehHn0KvpPqzDvuRlMhicjaYwHHgqFFic9BCcvdBLBaNUZTlT7LlzZhhgw8Ue+OYmKYM25Wg+y3SWfy379V7/sA4/Lf0SKP0xfzVVS/+n5J9gLI7t3A47w+doVMsj7256vLI0cDS1PK+rr0JhyihI7HqSWiWp2K72tNCn6OrIHAi7mcxRhlFwNv0jfddNxUiPgxeqCsg8nZMhgY+2H2Uv/xsQwYXdbqCVrh85yrPiwe5xESLsJs0JU0fMMMEVVZqFJXhICkHH1KKo9oa5kdtIA+K0zCYiF+ZrSpRyFHz68SAi1S1FEbDNQbTUW4mU8UEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRW6twaXubiMdLBXDTl+OHIJkHU2DP0otvVjAq/dsOc=;
 b=R1bMYFYP6Tf3+soAUIpYuLSnE7iAL91fHYVv7mG6gmKLFMigGGf2+bi7RVT0bGEbtWSCDkaB9gs0GGv1sbWOBEimmtVabip4osIlqVhvdS1n8rY+HFJCUyUbeoiq2c8R2HR2pgNfDhCQ0x28fsglC9tFL+GfT6sxg95kPyRT0Pk=
Received: from CH2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:610:38::17)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 17:07:06 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::66) by CH2PR05CA0040.outlook.office365.com
 (2603:10b6:610:38::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.9 via Frontend
 Transport; Fri, 18 Oct 2024 17:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 17:07:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 12:07:05 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Oct 2024 12:06:59 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>,
 <christian.koenig@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>, "Xiaogang
 Chen" <Xiaogang.Chen@amd.com>
Subject: [PATCH v3] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
Date: Fri, 18 Oct 2024 12:10:34 -0500
Message-ID: <20241018171034.16913-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: fa85b123-26a0-4f61-d3c5-08dcef974b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p3eQ6B7M+tx7D6263mO0lfKGFEkv9Qp5RZuQtg3tP77IpkM34uJGvz+KPNyt?=
 =?us-ascii?Q?yrKPZIYScp5gX+IP7hEuWGbFno2zQh+hHeDdDwGJDnd4jG8UjQ8g+73ZRw0e?=
 =?us-ascii?Q?AGyj6DXgC0naGNRR7wxEkDTqeddbv1KeCL6nhTpTd+UD514DEUDPCV3uC5xG?=
 =?us-ascii?Q?oj+smAi/adFapa9UP/DTmAbQsp4C5C4WqB8EhFrsDcYeIQQGBmDa5HDNKL6o?=
 =?us-ascii?Q?c3AU5l/KfL5/pa039mcteuYmi4dKjUOEwFrj3474gV8V2ylUmdE1A46J0BEh?=
 =?us-ascii?Q?z+2LzQjGXzb9yft2zVjUeO29quV/nSo0zv7nIZQrIb5L8qyNIhrXCOYYfDuq?=
 =?us-ascii?Q?KM5uuTRsqt0QE7d3IwrkvwqnKpHaaBvaRj6Zs4AMVKosZZY4xouohbip8Aso?=
 =?us-ascii?Q?vuODfki7MCbgr91I2dRq6BMLS6rkSQmbBxOkS/qsU+yUpaJUubV+xk7NOwjN?=
 =?us-ascii?Q?z069bAZfrwcqTRZ3Om8D+TtQsbkuQoXvuvYJNeMfn1bhmYIFkHACH8R23Mz+?=
 =?us-ascii?Q?Aeag+81kbvMXMwQyot0ARucLhzm/fJxotgGCtQ8ijLXhke3MJciNRLd4wbAN?=
 =?us-ascii?Q?Dy4AypB2LQvDiW6h+bbeAWckfJqHlscFCclrYmIvIpFzDSr4DGnvJ0PmNrPP?=
 =?us-ascii?Q?B6HUUxBxRZ7e/pallS2bxkV3wSFP7QJdWpJdYe3/5mqaCs4MHdb4/UL8/ueh?=
 =?us-ascii?Q?OazubB7MeBKgElVufk6CUU1dubRa5QgkrKUWtlPZP20fI5aBzoulZS0YV/RC?=
 =?us-ascii?Q?7CeFe+RZHtaIJOi0bzWFm+7bWnz583csTO5po27nassz8DqPRMO07IMGRX+H?=
 =?us-ascii?Q?0gZddwgyZs5rlXiccP1/f/Otj50xAq18oCf5vmkAkdbOfNLmLZFoW1f3ia5Y?=
 =?us-ascii?Q?rSfBJNQx/6Ft6jOFoj+1QsJtlXGpKoO/Ggc6iLhnZQ52CDF69+QT+s4EI1Ea?=
 =?us-ascii?Q?E/giD0Y1+aGAtXzhn4R9B5/dBO29sceM8uWORaQk6TS++NzIXZffafDt+gke?=
 =?us-ascii?Q?42tjOutFwiB+GOLQEW+rahlpubIkmkO1bTzPxNzBCUFi6eTmU9uxDRs4VJki?=
 =?us-ascii?Q?00MrUfQK9fFEdNHVywm+idVj1ozaCdmYK8DhACwAep4so9bqf1HN2ISNymqF?=
 =?us-ascii?Q?7Bz9lm1NAKF1bHb8aiTU4X31Sb69HeGFXC0l6AerUTINHslyXYvLde8g7oNz?=
 =?us-ascii?Q?FjaHy1MXLSlQaxAXNwCMIRs2amtttkugIT9qnfvC62TOW3f+BTEg8IQ6KhtU?=
 =?us-ascii?Q?J0v2hCSN5a6s3xBC8LWBO5LaM9r96kvyGg3nFsrpGRei8JU8YnAsdc2/ty22?=
 =?us-ascii?Q?i70e88wrZsP0UiCPhpKwMyrJAZw8T0ncStj8VF5CBFiB2zRUkdRNBGjq0vTg?=
 =?us-ascii?Q?IfF4wCs0RFJ0nUFJNMd0A3C4XZFfMmuBQcpIobHlprX++++IUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:07:05.8962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa85b123-26a0-4f61-d3c5-08dcef974b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
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

The purpose of this patch is having kfd driver function as expected during AMD
gpu device plug/unplug.

When an AMD gpu device got unplug kfd driver stops all queues from this device.
If there are user processes still ref the render node this device is marked as
invalid. kfd driver will return error for following requests to the device from
all existing user processes. Existing user processes can still use remaining
gpu devices during/after unplug event.

After all refs to the device have been closed from user space kfd driver gpu
node topology is updated by removing correspodent kfd nodes.

At same time user space can use remaining gpu devices that are valid. When all
AMD gpu devices got removed kfd driver will not allow open /dev/kfd request.

Unplugged AMD gpu devices can be re-plugged. kfd driver will use added devices
and function as usual.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 59 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 24 +++++++-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 26 ++++++++
 9 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b545940e512b..651ae0775f80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
 }
 
+void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd)
+{
+       kgd2kfd_teardown_kfd_device(kfd);
+}
+
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
 {
 	if (adev->kfd.dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 7e0a22072536..bd241f569b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -152,6 +152,7 @@ struct amdkfd_process_info {
 
 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
+void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
@@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
 void kgd2kfd_unlock_kfd(void);
 int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
+void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd);
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 {
 	return 0;
 }
+
+void kgd2kfd_teardown_processes(void)
+{
+}
+
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e47655e02c6..4529d7a88b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3315,7 +3315,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	amdgpu_amdkfd_suspend(adev, false);
+	if (adev->kfd.dev)
+		amdgpu_amdkfd_teardown_kfd_device(adev->kfd.dev);
 
 	/* Workaroud for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index a1f191a5984b..962a3a15a7ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -704,6 +704,9 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		if (!is_kfd_process_device_valid(pdd))
+			continue;
+
 		pAperture =
 			&args->process_apertures[args->num_of_nodes];
 		pAperture->gpu_id = pdd->dev->id;
@@ -779,6 +782,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 	for (i = 0; i < min(p->n_pdds, args->num_of_nodes); i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		if (!is_kfd_process_device_valid(pdd))
+			continue;
+
 		pa[i].gpu_id = pdd->dev->id;
 		pa[i].lds_base = pdd->lds_base;
 		pa[i].lds_limit = pdd->lds_limit;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fad1c8f2bc83..5b786c72db64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -893,6 +893,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	svm_range_set_max_pages(kfd->adev);
 
 	kfd->init_complete = true;
+	kfd->valid = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
 
@@ -919,6 +920,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
+	struct kfd_process *p;
+	unsigned int i, j;
+	unsigned int temp;
+
 	if (kfd->init_complete) {
 		/* Cleanup KFD nodes */
 		kfd_cleanup_nodes(kfd, kfd->num_nodes);
@@ -929,6 +934,20 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 	}
 
+	/* now this kfd_dev has been completely removed from kfd driver
+	 * before kfree kfd iterate all existing kfd processes. if kfd process
+	 * uses any kfd node from this kfd set its ref to NULL
+	 */
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		for (i = 0; i < kfd->num_nodes; i++)
+			for (j = 0; j < p->n_pdds; j++) {
+				if (kfd->nodes[i] == p->pdds[j]->dev) {
+					p->pdds[j]->dev = NULL;
+					break;
+				}
+			}
+	}
+
 	kfree(kfd);
 }
 
@@ -1485,6 +1504,46 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 	return node->dqm->ops.halt(node->dqm);
 }
 
+/* tear down this kfd deve */
+void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd)
+{
+	struct kfd_process *p;
+	struct kfd_node *dev;
+	unsigned int temp;
+	unsigned int i, j;
+	bool found;
+
+	kfd->valid = false;
+	/* stop queues from kfd nodes in this kfd dev */
+	for (i = 0; i < kfd->num_nodes; i++) {
+		dev = kfd->nodes[i];
+		dev->dqm->ops.stop(dev->dqm);
+	}
+
+	/* iterate all existing kfd processes, signal a gpu device is being teared
+	 * down if any kfd process uses kfd node from this kfd dev by
+	 * KFD_EVENT_TYPE_HW_EXCEPTION event
+	 */
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		found = false;
+		for (i = 0; i < kfd->num_nodes; i++) {
+			for (j = 0; j < p->n_pdds; j++)
+				if (kfd->nodes[i] == p->pdds[j]->dev) {
+					found = true;
+					break;
+				}
+
+			if (found)
+				break;
+		}
+
+		if (found)
+			kfd_signal_hw_exception_event(p->pasid);
+	}
+
+	return;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index dbcb60eb54b2..b8dd80ee17be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -378,6 +378,12 @@ int kfd_init_apertures(struct kfd_process *process)
 			continue;
 		}
 
+		/* kfd device that this kfd node belogns is not valid */
+		if (!dev->kfd->valid) {
+			id++;
+			continue;
+		}
+
 		pdd = kfd_create_process_device_data(dev, process);
 		if (!pdd) {
 			dev_err(dev->adev->dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6a5bf88cc232..97e7692ce569 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -371,6 +371,9 @@ struct kfd_dev {
 
 	/* bitmap for dynamic doorbell allocation from doorbell object */
 	unsigned long *doorbell_bitmap;
+
+	/* this kfd_dev valid or not */
+	bool valid;
 };
 
 enum kfd_mempool {
@@ -1055,6 +1058,10 @@ int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
 int kfd_resume_all_processes(void);
 
+static inline bool is_kfd_process_device_valid(struct kfd_process_device *pdd) {
+	return (pdd && pdd->dev && pdd->dev->kfd && pdd->dev->kfd->valid);
+}
+
 struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
 							 uint32_t gpu_id);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..2f4aff81dc64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1536,6 +1536,12 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	if (err != 0)
 		goto err_init_apertures;
 
+	/* no any kfd_process_device can be created */
+	if (!process->n_pdds) {
+		err = -ENODEV;
+		goto err_init_apertures;
+	}
+
 	/* Check XNACK support after PDDs are created in kfd_init_apertures */
 	process->xnack_enabled = kfd_process_xnack_mode(process, false);
 
@@ -1595,9 +1601,13 @@ struct kfd_process_device *kfd_get_process_device_data(struct kfd_node *dev,
 {
 	int i;
 
-	for (i = 0; i < p->n_pdds; i++)
+	for (i = 0; i < p->n_pdds; i++) {
+		if (!is_kfd_process_device_valid(p->pdds[i]))
+			continue;
+
 		if (p->pdds[i]->dev == dev)
 			return p->pdds[i];
+	}
 
 	return NULL;
 }
@@ -1863,6 +1873,9 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 		struct kfd_process_device *pdd = p->pdds[i];
 		struct device *dev = pdd->dev->adev->dev;
 
+		if (!is_kfd_process_device_valid(pdd))
+			continue;
+
 		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
 					     trigger);
 
@@ -1893,6 +1906,9 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 		if (n_evicted == 0)
 			break;
 
+		if (!is_kfd_process_device_valid(pdd))
+			continue;
+
 		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
 
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
@@ -1916,6 +1932,9 @@ int kfd_process_restore_queues(struct kfd_process *p)
 		struct kfd_process_device *pdd = p->pdds[i];
 		struct device *dev = pdd->dev->adev->dev;
 
+		if (!is_kfd_process_device_valid(pdd))
+			continue;
+
 		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
 
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
@@ -2255,6 +2274,9 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p,
 		for (i = 0; i < p->n_pdds; i++) {
 			struct kfd_process_device *pdd = p->pdds[i];
 
+			if (!is_kfd_process_device_valid(pdd))
+				continue;
+
 			if (pdd->user_gpu_id == gpu_id)
 				return pdd;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c76db22a1000..d2f95be81216 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -604,7 +604,9 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
 				unsigned int qid, struct mqd_update_info *minfo)
 {
 	int retval;
+	struct kfd_node *dev = NULL;
 	struct process_queue_node *pqn;
+	struct kfd_process_device *pdd;
 
 	pqn = get_queue_by_qid(pqm, qid);
 	if (!pqn) {
@@ -612,6 +614,17 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
 		return -EFAULT;
 	}
 
+	if (pqn->q)
+		dev = pqn->q->device;
+	if (WARN_ON(!dev))
+		return -ENODEV;
+
+	pdd = kfd_get_process_device_data(dev, pqm->process);
+	if (!pdd) {
+		pr_err("Process device data doesn't exist\n");
+		return -EINVAL;
+	}
+
 	/* CUs are masked for debugger requirements so deny user mask  */
 	if (pqn->q->properties.is_dbg_wa && minfo && minfo->cu_mask.ptr)
 		return -EBUSY;
@@ -671,6 +684,8 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 		       u32 *save_area_used_size)
 {
 	struct process_queue_node *pqn;
+	struct kfd_process_device *pdd;
+	struct kfd_node *dev = NULL;
 
 	pqn = get_queue_by_qid(pqm, qid);
 	if (!pqn) {
@@ -679,6 +694,17 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 		return -EFAULT;
 	}
 
+	if (pqn->q)
+		dev = pqn->q->device;
+	if (WARN_ON(!dev))
+		return -ENODEV;
+
+	pdd = kfd_get_process_device_data(dev, pqm->process);
+	if (!pdd) {
+		pr_err("Process device data doesn't exist\n");
+		return -EINVAL;
+	}
+
 	return pqn->q->device->dqm->ops.get_wave_state(pqn->q->device->dqm,
 						       pqn->q,
 						       ctl_stack,
-- 
2.25.1

