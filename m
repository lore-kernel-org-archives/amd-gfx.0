Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5753BC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25177206B5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x6SD2kCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25177206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAB06E91E;
	Thu, 20 Aug 2020 08:40:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA946E914
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 08:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoX1o81bzCar9JIVlS4/0DV2qkgMDGc3QM3Qw7xeLzbLGWk7kjGxwxpvUaxC2RLmauGEPjjUEol0DcOo1LWsoG/F8YOC0KrlJT9/CBStn/+lT43b3HfOI8COcxVB4cXVVM43mAELcT2jhoI32iLGF+9VeP1fUx9lJcQrCLhD7hao7P3sgZ4JJdEGNKpQeh4+CF4uKombeQ7t3bJuRsjY5jith0pwwk2VT0LT7JO9W1XVizU32OE2VrP4ox5W5E+s5MricB/F0/jWsnt2DP7z8BERiKV5DXOuQ/jzbxT3tRpFWbZqch9sjStqPFdUeeH7MHPwJWmrNoZ1mpnB2H2pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSxEKPab9lOFy5LkE1dnUWV+KIlwYkzrX5GVjcUyLM8=;
 b=ALTa94g3/hAEhg3x9l/eDpNcZAuMg4NdHAud5t0DqwPU1Qy6GTPqEoJPdHyPGUnd+VSefY4eV3QCn97UVCC9s9jtkETcL4cORTJiOvFLHjAWoypI0QsvzTbuKaw8+O8jkVEWapmtIUKR6qSLu9I9nlI/zcJcPs00Y7Eu2YV4z1DmCdmtME+Kh9XP/gGb0DIvbJy6M7uFtqcCQRbtpKTbC71PbR9czTTwlJPBTX12r6XGrx6LP/cGwjvXXr9fLpBmQJHyvtK7DhnREEGX9wFZyqdNUOJh6oGxZ39Huv7gJ++GbpcG/M3F27vH14yr2SGPkl8X0s9D9S774IQedJEcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSxEKPab9lOFy5LkE1dnUWV+KIlwYkzrX5GVjcUyLM8=;
 b=x6SD2kCO12av24yp9Dm6mLbkqTsPqThwywpTl5srBFUVklx3tjzixut6zQmPODjxk2OtXND7b//w5lTdKYknvxBtilyXKANecg4N37OShEwPLXLIRo7vWjqyTQD+Gb3kONhpXz1uMBaOziCy94D14tYaqlWvSovbXDVBWLWoAfc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 20 Aug
 2020 08:40:31 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 08:40:31 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 1/2] drm/amdkfd: abstract the iommu device checking with
 ignore_crat (v2)
Date: Thu, 20 Aug 2020 16:40:07 +0800
Message-Id: <20200820084008.293114-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK0PR01CA0070.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 08:40:29 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a1ad000-3d91-48cf-c539-08d844e4b270
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45524A427B7ABC80B55AA40BEC5A0@MN2PR12MB4552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC3ODq6Ej1byL+iE50s7DthxOv3I2uiKR1FwMmzuYUKigBTcgy0jmNENdQDsYB/PJOyQopCYgS33+hSed1+YkoQ+WdhsRprXEN2ViC94KwKBNxKEZVyVamnVnlUlEbAVt8AeJg1Hb0rLnGWcV+yBMa+G7d85OzAiOBDoraBEwzD3ij6pwsFtKJhFqDsyqGpjaHMj7IBgZZ+RsDp92GqeZMj+mgozkhjZio2czndDp0PiU73csZ3PCLCyDo5eg8Th/OB89VaeFCSpU3VfETe7ddEJB/jzgKYdTbUI8Bfrc3ry0AB/aiiHe3pzE/4ZI02na3c+X+hzAwzppU9hhPMNSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(5660300002)(6486002)(4326008)(36756003)(1076003)(6666004)(6916009)(956004)(2616005)(316002)(2906002)(86362001)(478600001)(66476007)(8936002)(7696005)(83380400001)(16526019)(52116002)(66556008)(54906003)(186003)(26005)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5yPKVrPMf7xXhbxlRq8vVX1s54BY5dvAWGmZOtlh/vddYRzMssB0AJGtScoosuDtBvs+Tth7IveZCMXgwe2i2f2CSuUPQcczPJGDb7TbgQ5MU3hvPg+WLs1yAuwMN9q/ePvo6t2NTkRGEPRMWMgOrMGq24OAlPmdMdNFj7OOpBa1a+ydGV6pVyS//PP3eQKgoOnF/tzbf6PTVCZVs7ckuWieadHZTs/0DOJ8ipCGm2NdR/OO9Oi3g7q93EEVvl91d8Ar1LSnjYOsLDlqqtBUOY9tamB3j1hkq2A2uKgwYP0jKegR5LH6/yre5Bp/vlNtEskTo/iyN5Ex0uBkS4IPjE9VDdR2BbvIRyAbpJIF/hOZ2qlT0x+jYbi0T+odVhDfgl6rfJWuc+5Glbfw/8O0Q9+K8rLmZocoMhY1+O6aGRtQVjSeVed7XqZHTa9i2123vabVff1teZie/qjR3/+vf7Tr3kI1ui6oWLHZ9GF3xqy/r4kwJZTHr3p25R448WzL2daUeAARbZf6v9R56GpW2iT3Gft/h6S8++Z4zhxMSk+bE/izZ2d8BCJVldkNKxp1Z5LA6MSyHHYS/ktVMPei8oTBuXoweeEAxGj2J8bWtbLm+cbCDT+c/xr8FJ/T0ofio3CsOSs1xQ6yiQxYoqAB/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1ad000-3d91-48cf-c539-08d844e4b270
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 08:40:31.3310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+2ssG2ZITsdVAJEAjbnwlTItE9358jrrY5yJR1+5vLiM5ph3/Ou9ATAfMATznvharsxpoN3Vn1ppX4wdPHXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's better to use inline function to wrap the iommu checking.

v2: rename the function and use another input.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c                |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c           |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c                 | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c              |  6 +++---
 7 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1b60e0ed6b5c..ae3e3e7e3b75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 		return true;
 	}
 
-	if (dev->device_info->needs_iommu_device)
+	if (kfd_device_use_iommu_v2(dev))
 		return false;
 
 	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 3e5904f8876a..78830835162e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, pdd->qpd.vmid,
-				dbgdev->dev->device_info->needs_iommu_device);
+				kfd_device_use_iommu_v2(dbgdev->dev));
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
@@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, vmid,
-				dbgdev->dev->device_info->needs_iommu_device);
+				kfd_device_use_iommu_v2(dbgdev->dev));
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 95a82ac455f2..02a3e9888092 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 		if (amdgpu_noretry &&
-		    !dqm->dev->device_info->needs_iommu_device)
+		    !(kfd_device_use_iommu_v2(dqm->dev)))
 			qpd->sh_mem_config |=
 				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 78714f9a8b11..11c2bb7ba5ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_VI();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	if (!pdd->dev->device_info->needs_iommu_device) {
+	if (!kfd_device_use_iommu_v2(pdd->dev)) {
 		/* dGPUs: SVM aperture starting at 0
 		 * with small reserved space for kernel.
 		 * Set them to CANONICAL addresses.
@@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
 				return -EINVAL;
 			}
 
-			if (!dev->device_info->needs_iommu_device) {
+			if (!kfd_device_use_iommu_v2(dev)) {
 				/* dGPUs: the reserved space for kernel
 				 * before SVM
 				 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 4d3b4188b9a1..94e8354a857d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
 	struct amd_iommu_device_info iommu_info;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd_device_use_iommu_v2(kfd))
 		return -ENODEV;
 
 	iommu_info.flags = 0;
@@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd_device_use_iommu_v2(kfd))
 		return 0;
 
 	iommu_info.flags = 0;
@@ -109,7 +109,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
 	struct kfd_process *p = pdd->process;
 	int err;
 
-	if (!dev->device_info->needs_iommu_device || pdd->bound == PDD_BOUND)
+	if (!kfd_device_use_iommu_v2(dev) || pdd->bound == PDD_BOUND)
 		return 0;
 
 	if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
@@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct kfd_dev *kfd)
  */
 void kfd_iommu_suspend(struct kfd_dev *kfd)
 {
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd_device_use_iommu_v2(kfd))
 		return;
 
 	kfd_unbind_processes_from_device(kfd);
@@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd_device_use_iommu_v2(kfd))
 		return 0;
 
 	pasid_limit = kfd_get_pasid_limit();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 60243798cce2..82f955750e75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1232,6 +1232,11 @@ static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
 #endif
 }
 
+static inline bool kfd_device_use_iommu_v2(const struct kfd_dev *dev)
+{
+	return dev && dev->device_info->needs_iommu_device;
+}
+
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index cbb8535abf0c..4b29815e9205 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		 * If the ASIC is APU except Kaveri, set local memory size
 		 * to 0 to disable local memory support
 		 */
-		if (!dev->gpu->device_info->needs_iommu_device
+		if (!kfd_device_use_iommu_v2(dev->gpu)
 			|| dev->gpu->device_info->asic_family == CHIP_KAVERI) {
 			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
 				&local_mem_info);
@@ -1197,7 +1197,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 		/* Discrete GPUs need their own topology device list
 		 * entries. Don't assign them to CPU/APU nodes.
 		 */
-		if (!gpu->device_info->needs_iommu_device &&
+		if (!kfd_device_use_iommu_v2(gpu) &&
 		    dev->node_props.cpu_cores_count)
 			continue;
 
@@ -1452,7 +1452,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	* Overwrite ATS capability according to needs_iommu_device to fix
 	* potential missing corresponding bit in CRAT of BIOS.
 	*/
-	if (dev->gpu->device_info->needs_iommu_device)
+	if (kfd_device_use_iommu_v2(dev->gpu))
 		dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
 	else
 		dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
