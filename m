Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02718D5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AFF10E1FA;
	Fri,  8 Nov 2024 11:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZZikrhfW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1DF510E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFC+gTId4aKgedUEvC2MjHZZRp2HpY+XTqKgj2W8DE1rBPxQ/pSirHLI5CoqQiESA5+W1H/VoPtrd2YuZrzJ1LzBjdBH52SWLihXmVogeVoWsgf3Akbe8k5r7hQzEqPwm109sLdqCrBceEQQ5geCCUYEnUzAcnjZZQZ/Fd7yUqtm2mKockCE7X/a4Yo8Y3mjLrBPyX1I7CLg/XUh9hbJqn2MK9fuLb7Na5wmQhQVmWynfcyJDUWanADPKMbx12CFaJAnEQdeEonzC8hhzf+B1P6fz/Ihlugwqi07wJpWWGr2pWS/xA/u/nV8BYeWhMvODJEkgsByTa1vlbZmL6WvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7anN2EGtIHBLLEssTIxie5gzk/CdWWaBeD8agWhXhtQ=;
 b=sd57LTtpzMAj95di/yWQ6Y+U9+RUqo/xBNdipi/zP6dwBGImO8BIiD1p8/xzS+UtFOzF7oxI/qEmLpKiLSN4bwDPxqBTQTV0NKB7EvPxHQyJMUd9bK+8WmROdt7GYwlcxxZC1lkpixzXiUQmAcsiqmogeMjSccgbx/PZefXoYgycDkInw4GdapakaTl9j0pJFi32SIl9aY4Yyysv3IonTqfkOvrkvieMO2TJjOCA/vOIeSrLssW86xhcMtmo28AmidP0CidZIIOBbbqbGzf7YQlU90QUs7Ia4LjLWY9/Tqk/Xv/vX/DedffbWn2fox1982Rrovih31NHx2D0CwSE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7anN2EGtIHBLLEssTIxie5gzk/CdWWaBeD8agWhXhtQ=;
 b=ZZikrhfWE68WnuyXzgqSkg1cnFsBw5E92u9S4v3NHchLc5WSMrU0KdPcPHkYWtiAkZLVE6w2RYSLKXzFvd96fjvp10APiVFs1Jftzm5quA3ZOny4IhpIj2VRK/ZAY5nicydLv/6wRXg49xxLkrhZfB5e1xS6GCmDWA/pNB8wsRc=
Received: from BL1PR13CA0194.namprd13.prod.outlook.com (2603:10b6:208:2be::19)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 11:14:33 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::40) by BL1PR13CA0194.outlook.office365.com
 (2603:10b6:208:2be::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:33 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:31 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 01/23] drm/amdgpu: add flag to indicate nps mode switch
Date: Fri, 8 Nov 2024 19:14:01 +0800
Message-ID: <20241108111423.60169-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 3192a173-44f8-4d1a-97cc-08dcffe685cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ru4YI47i5yrvCGrVaPeDqce4ARj3Mr+l7wTv5JHGI0untBvBTmUtzhN2VtP?=
 =?us-ascii?Q?Wj4XNhjhCUQfpETS80u6qetxDJJ5tlS19aJokb2vuffpR7bOrHqbcNaB71C8?=
 =?us-ascii?Q?L4vhSyGoIlaNiQPRmSvTq5H0cYIjuwXS8DPCGVzIACd2KJfWVrJzwOT/2kqZ?=
 =?us-ascii?Q?ZPniEA+kcMUc9dUnQiSNDxJmvO5xS5XxZ+vOplqd9NvP1Y+hXXSGTKU72+jX?=
 =?us-ascii?Q?F5Eu7fu7KlGohrgCxvLswqsg4aBbRWZc+UtVeRtWPHsACixCka/RdAhxWW6h?=
 =?us-ascii?Q?Mvi8cOlWJyYZlAmAyPDM6SCwDPYc3A0EL0o+y7cmH5cmXkTdwQjACOEF6laM?=
 =?us-ascii?Q?VgE/BE8V1vhu8F0VSS/q+8t+cTOHBgcUfJd1gGDfdMEMZBdIfdfkvUNIL8kB?=
 =?us-ascii?Q?s9P6mOymbnDKr/+vsdny/THUIU/EObxq4ukHIFurBoONqxcF9yodIXgKCtBs?=
 =?us-ascii?Q?6WmxhvE96CgvN2hE56+24/rmlj8+X36jocsA04R01JknmpRfgz+n5j4jRKPB?=
 =?us-ascii?Q?QmK9D0b9onI2key5bZ4xCxdES5tsZKwqtYCpIYggARpvKl/glWGL60FaCcuj?=
 =?us-ascii?Q?Vwuurx4XQvtO9jY6JRlmyoUkDm9HoJPIzwxF4E0WEFncCrFhPf38HGi/uyDP?=
 =?us-ascii?Q?tMW7sDn9tLEV7MuXDCWR54J6MmSGfLfwxCgerlFDPIFjHsOcbI1I71R3MlLC?=
 =?us-ascii?Q?vFX5KEL816s40l5UsmP6szbvYprh1g95oZNVCMGc3MOT4MXJzZuof/CLrNJM?=
 =?us-ascii?Q?eB4Yovxy1pipQst2vPP9tIQ4VjF0GMP+K6wJwmz3T+2+T5MYLfbXfZFC0FCH?=
 =?us-ascii?Q?43zn3CpuLRswbx4C9IsKpmRyVKQI3YkJcigElM2J9EgPsDokk2PlIrH6HFRU?=
 =?us-ascii?Q?qkZ94FhGelQCbcg7wM12aYNQLspVWxO2utyifuiX6bG7LFACjKldCXjfMUsh?=
 =?us-ascii?Q?WHz+HWnyALAkSU5np8+ybhgLe03JCrKFnhg6Wbq+wjFbuMExpiK+Qdov0FPl?=
 =?us-ascii?Q?IQRarTzQrvx6WOURe6WWoy5/EoeAkVHXUcFFtKwhMU4JdtLmQMOHOM7DasL+?=
 =?us-ascii?Q?QNuPzaMeWaMRkuOUkAb9+SuWbgRxjCld8J0kGCPSFSo30kBp8NPC5dwmpbXm?=
 =?us-ascii?Q?bDP+8loASAmF1skk5v/yezzo2Wa4ApZ8nErq3i40b11IIth2b78rADes7Nof?=
 =?us-ascii?Q?qSN61bJ9pvRt53rNSBG6Vmo30777L6c9efeq97FAdc52vq+b4ZY/LWGRNPvY?=
 =?us-ascii?Q?yvn51YxhxEgGROJKhps0qFqthCnKv7erV0jKA/MZfAULFKDj8UuSS7++RLFU?=
 =?us-ascii?Q?+FEmWireIEfQzb4JdTm6k49FT5WFnwKPa5AbRfJMNILA2Hmxag3bA5OowSI3?=
 =?us-ascii?Q?Ke/KicFI9nMnKbE5wp7eVIROoc+8oyskJitT/ZW31EJJ4z7/Jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:33.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3192a173-44f8-4d1a-97cc-08dcffe685cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
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

There are two types of gpu reset, nps mode switch and normal
gpu reset, add a flag to distigush them.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  2 +-
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9365b43c0055..ba9b0d322b33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1681,6 +1681,7 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
 }
 
 int amdgpu_in_reset(struct amdgpu_device *adev);
+int amdgpu_in_nps_switch(struct amdgpu_device *adev);
 
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 286f0fdfcb50..d69fcbb28b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5862,7 +5862,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
-	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+	amdgpu_device_lock_reset_domain(tmp_adev);
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
@@ -6343,7 +6343,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		 * Locking adev->reset_domain->sem will prevent any external access
 		 * to GPU during PCI error recovery
 		 */
-		amdgpu_device_lock_reset_domain(adev->reset_domain);
+		amdgpu_device_lock_reset_domain(adev);
 		amdgpu_device_set_mp1_state(adev);
 
 		/*
@@ -6579,6 +6579,11 @@ int amdgpu_in_reset(struct amdgpu_device *adev)
 	return atomic_read(&adev->reset_domain->in_gpu_reset);
 }
 
+int amdgpu_in_nps_switch(struct amdgpu_device *adev)
+{
+	return atomic_read(&adev->reset_domain->in_nps_switch);
+}
+
 /**
  * amdgpu_device_halt() - bring hardware to some kind of halt state
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index f4c08fa83756..1becf8fbbc71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -301,15 +301,25 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
 
 	INIT_WORK(&reset_domain->clear, amdgpu_reset_domain_cancel_all_work);
 	atomic_set(&reset_domain->in_gpu_reset, 0);
+	atomic_set(&reset_domain->in_nps_switch, 0);
 	atomic_set(&reset_domain->reset_res, 0);
 	init_rwsem(&reset_domain->sem);
 
 	return reset_domain;
 }
 
-void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain)
+void amdgpu_device_lock_reset_domain(struct amdgpu_device *adev)
 {
+	struct amdgpu_reset_domain *reset_domain = adev->reset_domain;
+
 	atomic_set(&reset_domain->in_gpu_reset, 1);
+	/* The life time of in_nps_switch is longer than
+	 * amdgpu_device_nps_switch_needed
+	 */
+	if (adev->nbio.funcs && adev->nbio.funcs->is_nps_switch_requested &&
+	    adev->nbio.funcs->is_nps_switch_requested(adev))
+		atomic_set(&reset_domain->in_nps_switch, 1);
+
 	down_write(&reset_domain->sem);
 }
 
@@ -317,6 +327,7 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 {
 	atomic_set(&reset_domain->in_gpu_reset, 0);
+	atomic_set(&reset_domain->in_nps_switch, 0);
 	up_write(&reset_domain->sem);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 977b2dd2205a..c74a1f88f0ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -97,6 +97,7 @@ struct amdgpu_reset_domain {
 	enum amdgpu_reset_domain_type type;
 	struct rw_semaphore sem;
 	atomic_t in_gpu_reset;
+	atomic_t in_nps_switch;
 	atomic_t reset_res;
 	struct work_struct clear;
 	bool drain;
@@ -158,7 +159,7 @@ static inline bool amdgpu_reset_pending(struct amdgpu_reset_domain *domain)
 	return rwsem_is_contended(&domain->sem);
 }
 
-void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
+void amdgpu_device_lock_reset_domain(struct amdgpu_device *adev);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index daa69dfb4dca..8387e075c385 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1540,7 +1540,7 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 
 	tmp_adev = list_first_entry(&device_list, struct amdgpu_device,
 				    reset_list);
-	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+	amdgpu_device_lock_reset_domain(tmp_adev);
 
 	reset_context.method = AMD_RESET_METHOD_ON_INIT;
 	reset_context.reset_req_dev = tmp_adev;
-- 
2.34.1

