Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87975D1F9D8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 21:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2211A10E614;
	Tue, 15 Oct 2024 21:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qodZH5ao";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4455410E614
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 21:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNpFVg60dugQmDpgte0nlAOHpqOpX8bwxEheBu6zoLQmS+TmFmMFGDpdgG93RivilMPiEuFTw2YzDmKH0siPKWtQ7YSPa54aMhnzxqB/cWsmuG+kWbsoki5kYog0tsTLuh8WCyNuiJg/EHjAm5FjypPrombunNAuRsSE8AFvje+hPXv/gJyXAUDclQi+Z+kNCR08gB+DK3GR/Hwr4LE5SkQXlJFkHVLyEn1eWB4bwDaU52V0S3LdoVhJ093RmB2ZD3y23WBOaKQjBZMjgsYpj5rXYfAVZj6LfU3XN4AV50HBxtRVnfbrAkET6/eGc1WF017JTPKcSRZYal/a8Vavug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91k6Oa4UEdrtjyO+TDqJ977cjKt9D1ZD51Ed+bhhbko=;
 b=PkbR0gyKzeuBQijvdDhqzVXC0SyRP7u4Mji0tj42ZmQXX5VYxWVGTDCzpiwaN5BcGyOSL11mGfWCF21WWUE0dpx8Nf85rLbU3NXXcoNaroPGI94l2rPPwCxIjzZ3QQ6H3gacS3Z/iHs3D8abB6+onTSRJlzgzKIioMb3xqpPfwaOmDBUI2Yn4HFlzGUgrlBaU0l0aH8ruDQtq2SdQ6XNYldWWtkFK4vwdI74ZHljZuoy12pNND3+1QNQ0aOkXBlD3AYnfEJF/P9aV2ZjQUAuNyZ80pc5MgXuMGA2iqChoMUNcODal1BxvO8dXuPQKb2MWcgDfgkLXdWPjJvbOCl0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91k6Oa4UEdrtjyO+TDqJ977cjKt9D1ZD51Ed+bhhbko=;
 b=qodZH5aodcw0TC2vF4R6ujoWpFdeOpbFC9FU05LvLHxFKy3LKPyIlGkHTbDg6yapc4s4FMKYPMdX8RNuppqR8dnQWbFzbV4MayS2rtXtkJAwmyC6r9NAqdNr8OmR2cV5ztstSClAN8xzZC7NWefDDuFR0ZEQ2qy/xL4j0q/zq08=
Received: from BL1PR13CA0254.namprd13.prod.outlook.com (2603:10b6:208:2ba::19)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 21:20:52 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::34) by BL1PR13CA0254.outlook.office365.com
 (2603:10b6:208:2ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 21:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Tue, 15 Oct 2024 21:20:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:20:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:20:51 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 16:20:46 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>,
 <christian.koenig@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>, "Xiaogang
 Chen" <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
Date: Tue, 15 Oct 2024 16:21:39 -0500
Message-ID: <20241015212139.63500-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d879894-ba49-4dcc-aa41-08dced5f3fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WmqJBv+ya4zC7R1hU8x9/ql9K/hfAbSOrxdwxg4XgymsM+dl2vAX1FZw7tlC?=
 =?us-ascii?Q?IZkhWZkSCFl6xJyofTTCJ++gNSpk7jOM18fxRWwpNatUwJThrOp9t9zAu/8u?=
 =?us-ascii?Q?BhMQmG6eXVrtrPTvb09F/2w5cbAOTFPUD0f7AEYHyQrJooLj5g+UE6GTWy9P?=
 =?us-ascii?Q?xv6Dyfqrqg1fVZsG18o0gg+ZXIYHPiniRZa0h9PeEKknEiJWL5H/wimRXmsU?=
 =?us-ascii?Q?fDxhAsx0ukEK2PPnW2RaW1BTjIiiI4eDJFAF5c6KG7DHhMYEUMSMlqlQNbO2?=
 =?us-ascii?Q?mC+BRxlsL+AuDQApWPijVp+u0TMi2EFo7SJ/vCHbeYXmAz5KtcTjN0DoHYYH?=
 =?us-ascii?Q?fVGnhLKB0dYLxc91L708NYy+9XyIhTIXvgiDOrZuzZOmHXnf/Ikdc6EzFLsH?=
 =?us-ascii?Q?Z5tGrRms0gCepmv5eWenOiTE63bfqPnm4UsewVidJvEMXZ9eTKF1pmT5ctRU?=
 =?us-ascii?Q?B4R9z1Fz+8dFlpwZ+AphRhp7rgSiniMpa3FmQQmI8deTPEnK5I0USd0r3WXp?=
 =?us-ascii?Q?TW+cvJIGcdb9q4esLqbRb25/yRAQLEEEwrN1cAWXHKmfmw7Ub/8N6ttj/Za5?=
 =?us-ascii?Q?e7B8/UVSyxJnUB42q2CqDfszvgJVB3FF7O7YUfAB9vHnXpUuafuVCvIHyPwQ?=
 =?us-ascii?Q?bjCejW9H9JukX19Oc8J2ZaRPG2Jdd9l6x8rVKyC5+ykLQRUZ5Q7B0nDzKQm/?=
 =?us-ascii?Q?fxV4BAPwe0KMoZjcFjI56Dqwhj3YFpCQc0kowSK52G0NXDR0VMm+Ddq0UURu?=
 =?us-ascii?Q?rg02Gvrqc6uawgZwM67z/asfCF65dSH75/0SDiOE5Nqa3p4pDkpixVzIEkD+?=
 =?us-ascii?Q?I4NwISpt24ZVSzF1H10K5IjTZVa1hcJ0iNxBJed0tOCv+Rnmac2eXhnA/+js?=
 =?us-ascii?Q?HCw7drCvxYHfVzf5cGs8arSQV7HtcipYurXjtAffMusnTyHHJAAsIxPz6a3M?=
 =?us-ascii?Q?8O6E/EBtMvn9t+c/vsQQqZ2xnak891hWjLzC/cw4hr3DM/hyoeCtoxjzu3//?=
 =?us-ascii?Q?WijvOVkzMTNAhl7DAuEFFclcOhmyb/tjixjlwBYOpdxof8iL6OIESlvGOe8I?=
 =?us-ascii?Q?MZyAzgq05RXtcAJ85Y9iGhCCrjmwPvlESfcTOwAJQcq8z8GNB6Eh642eoxpu?=
 =?us-ascii?Q?8dr0cs7J5EmT1f8gGowqHbw2jWqp/+T/ppasKGpAsYn/hYKygaaR6Rv27QMa?=
 =?us-ascii?Q?qv8leXNatFVUcCUdCBxIBoUMe6oRW015+dks1pua3OgIBqQg/SIc66qFmmBO?=
 =?us-ascii?Q?9/hrno8J99Xo0Wdc9PrrJ/NFtRVkCPRgcDM2tLOrNWoVKKmt8kjEY7X/cXQH?=
 =?us-ascii?Q?GZAXDTAyHoaHBdtIjPXRGBo8kkbQVyWGSYMCcyChVeUb5JYwPFsRuMEqzXHc?=
 =?us-ascii?Q?bYz2CF8qwCLZsU22k0XeAJrkzTAx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:20:52.4353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d879894-ba49-4dcc-aa41-08dced5f3fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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
invalid. kfd driver will return error to following requests to the device from
all existing user processes. Existing user processes can still use remaining
gpu devices during/after unplug event.

After all refs to the device have been closed from user space kfd driver
topology got updated by removing correspodent kfd nodes.

User space can use remaining gpu devices that are valid at same time. When all
AMD gpu devices got removed kfd driver will not allow open /dev/kfd request.

Unplugged AMD gpu devices can be re-plugged. kfd driver will use added devices
and function as usual.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 78 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 24 ++++++
 9 files changed, 183 insertions(+), 3 deletions(-)

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
index a1f191a5984b..d246f72ae0e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -327,6 +327,13 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		err = -EINVAL;
 		goto err_pdd;
 	}
+
+	if (!is_kfd_process_device_valid(pdd)) {
+		pr_debug("gpu 0x%x is not available\n", args->gpu_id);
+		err = -EINVAL;
+		goto err_pdd;
+	}
+
 	dev = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(dev, p);
@@ -578,6 +585,12 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 		goto err_pdd;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		pr_debug("gpu 0x%x is not available\n", args->gpu_id);
+		err = -EINVAL;
+		goto err_pdd;
+	}
+
 	pdd = kfd_bind_process_to_device(pdd->dev, p);
 	if (IS_ERR(pdd)) {
 		err = -ESRCH;
@@ -621,6 +634,11 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
 		goto err_pdd;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		err = -EINVAL;
+		goto err_pdd;
+	}
+
 	pdd = kfd_bind_process_to_device(pdd->dev, p);
 	if (IS_ERR(pdd)) {
 		err = -ESRCH;
@@ -704,6 +722,9 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		if (!is_kfd_process_device_valid(pdd))
+			continue;
+
 		pAperture =
 			&args->process_apertures[args->num_of_nodes];
 		pAperture->gpu_id = pdd->dev->id;
@@ -779,6 +800,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 	for (i = 0; i < min(p->n_pdds, args->num_of_nodes); i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
+		if (!is_kfd_process_device_valid(pdd))
+			continue;
+
 		pa[i].gpu_id = pdd->dev->id;
 		pa[i].lds_base = pdd->lds_base;
 		pa[i].lds_limit = pdd->lds_limit;
@@ -901,6 +925,11 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
 		goto bind_process_to_device_fail;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		err = PTR_ERR(pdd);
+		goto bind_process_to_device_fail;
+	}
+
 	pdd->qpd.sh_hidden_private_base = args->va_addr;
 
 	mutex_unlock(&p->mutex);
@@ -981,6 +1010,11 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 		goto err_pdd;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		ret = -EINVAL;
+		goto err_pdd;
+	}
+
 	if (pdd->drm_file) {
 		ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
 		goto err_drm_file;
@@ -1031,6 +1065,10 @@ static int kfd_ioctl_get_available_memory(struct file *filep,
 
 	if (!pdd)
 		return -EINVAL;
+
+	if (!is_kfd_process_device_valid(pdd))
+		return -EINVAL;
+
 	args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
 							pdd->dev->node_id);
 	kfd_unlock_pdd(pdd);
@@ -1090,6 +1128,11 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		goto err_pdd;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		err = -EINVAL;
+		goto err_pdd;
+	}
+
 	dev = pdd->dev;
 
 	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) &&
@@ -1202,6 +1245,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		goto err_pdd;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		pr_err("Process device is not valid\n");
+		ret = -EINVAL;
+		goto err_pdd;
+	}
+
 	mem = kfd_process_device_translate_handle(
 		pdd, GET_IDR_HANDLE(args->handle));
 	if (!mem) {
@@ -1266,6 +1315,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		err = -EINVAL;
 		goto get_process_device_data_failed;
 	}
+
+	if (!is_kfd_process_device_valid(pdd)) {
+		err = -EINVAL;
+		goto get_process_device_data_failed;
+	}
+
 	dev = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(dev, p);
@@ -1384,6 +1439,11 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		goto bind_process_to_device_failed;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		err = -EINVAL;
+		goto bind_process_to_device_failed;
+	}
+
 	mem = kfd_process_device_translate_handle(pdd,
 						GET_IDR_HANDLE(args->handle));
 	if (!mem) {
@@ -1567,6 +1627,11 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 		goto err_unlock;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		r = PTR_ERR(pdd);
+		goto err_unlock;
+	}
+
 	r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, args->dmabuf_fd,
 						 args->va_addr, pdd->drm_priv,
 						 (struct kgd_mem **)&mem, &size,
@@ -1616,6 +1681,11 @@ static int kfd_ioctl_export_dmabuf(struct file *filep,
 		goto err_unlock;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	mem = kfd_process_device_translate_handle(pdd,
 						GET_IDR_HANDLE(args->handle));
 	if (!mem) {
@@ -1660,6 +1730,9 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	if (!pdd)
 		return -EINVAL;
 
+	if (!is_kfd_process_device_valid(pdd))
+		return -EINVAL;
+
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
@@ -2990,6 +3063,11 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 			r = -ENODEV;
 			goto unlock_out;
 		}
+
+		if (!is_kfd_process_device_valid(pdd)) {
+			r = -ENODEV;
+			goto unlock_out;
+		}
 	}
 
 	switch (args->op) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fad1c8f2bc83..019567249110 100644
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
+	 * before kfree kfd iterate all existing kfd processes, if kfd process
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
 
@@ -1485,6 +1504,30 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 	return node->dqm->ops.halt(node->dqm);
 }
 
+/* tear down this kfd deve */
+void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd)
+{
+	struct kfd_process *p;
+	struct kfd_node *dev;
+	unsigned int i;
+	unsigned int temp;
+
+	kfd->valid = false;
+	/* stop queues from kfd nodes in this kfd dev */
+	for (i = 0; i < kfd->num_nodes; i++) {
+		dev = kfd->nodes[i];
+		dev->dqm->ops.stop(dev->dqm);
+	}
+
+	/* signal a gpu device is being teared down to user spalce processes by
+	 * KFD_EVENT_TYPE_HW_EXCEPTION event
+	 */
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
+		kfd_signal_hw_exception_event(p->pasid);
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
index d07acf1b2f93..c06eb9d8008e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1157,8 +1157,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 	ef = rcu_access_pointer(p->ef);
 	dma_fence_signal(ef);
 
-	kfd_process_remove_sysfs(p);
-
 	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
@@ -1173,6 +1171,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 
 	put_task_struct(p->lead_thread);
 
+	/* the last step is removing process entries under /sys
+	 * to indicate the process has been terminated.
+	 */
+	kfd_process_remove_sysfs(p);
+
 	kfree(p);
 }
 
@@ -1536,6 +1539,12 @@ static struct kfd_process *create_process(const struct task_struct *thread)
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
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c76db22a1000..eaf4ba65466c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -124,6 +124,11 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 		return -EINVAL;
 	}
 
+	if (!is_kfd_process_device_valid(pdd)) {
+		pr_debug("device 0x%x is not available\n",dev->node_id);
+		return -EINVAL;
+	}
+
 	/* Only allow one queue per process can have GWS assigned */
 	if (gws && pdd->qpd.num_gws)
 		return -EBUSY;
@@ -498,6 +503,11 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	if (WARN_ON(!dev))
 		return -ENODEV;
 
+	if (!dev->kfd || !dev->kfd->valid) {
+		pr_err("Process device is not valid\n");
+		return -1;
+	}
+
 	pdd = kfd_get_process_device_data(dev, pqm->process);
 	if (!pdd) {
 		pr_err("Process device data doesn't exist\n");
@@ -567,6 +577,10 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 		pdd = kfd_get_process_device_data(q->device, q->process);
 		if (!pdd)
 			return -ENODEV;
+
+		if (!is_kfd_process_device_valid(pdd))
+			return -ENODEV;
+
 		vm = drm_priv_to_vm(pdd->drm_priv);
 		err = amdgpu_bo_reserve(vm->root.bo, false);
 		if (err)
@@ -612,6 +626,11 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
 		return -EFAULT;
 	}
 
+	if (!pqn->q->device->kfd->valid) {
+		pr_debug("device where queue %d exists is not valid\n", qid);
+		return -EFAULT;
+	}
+
 	/* CUs are masked for debugger requirements so deny user mask  */
 	if (pqn->q->properties.is_dbg_wa && minfo && minfo->cu_mask.ptr)
 		return -EBUSY;
@@ -679,6 +698,11 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 		return -EFAULT;
 	}
 
+	if (!pqn->q->device->kfd->valid) {
+		pr_debug("device where queue %d exists is not valid\n", qid);
+		return -EFAULT;
+	}
+
 	return pqn->q->device->dqm->ops.get_wave_state(pqn->q->device->dqm,
 						       pqn->q,
 						       ctl_stack,
-- 
2.25.1

