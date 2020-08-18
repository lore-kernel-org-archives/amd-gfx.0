Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A0C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6879207DE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1tkg3YA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6879207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5136889D66;
	Tue, 18 Aug 2020 13:10:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED6389D66
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 13:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7GYJ3iwF1ZCHFiTTZiU3tRcZx2PKQqN/pWYs74g0LFdECiIyXUTwnwWh67rKdaBUA6rDdMdVHqqnvD5q5tSUTVzlJmqLb/IEUTzYbNRXwEShRwZRxmiZTQncxb+u5z+ylXY/by7sgOCvmZubiN6M4uDOG6fyn8SVLC9nDMEDhpp1ar72Mqb5KRXLA7SS2QPK4WD+M1PLxDDt9lC+dI6is2sQUQGMO5i35V4BL9KBFvVnHyvZsYcblqde0LsUArpnTvIYC6SOGFalLyeHiy1ilpuaAAxVWMNQR6v9Z0ziCNcxG1OX5vP4UK1e5uimfFjDE9fxoLNMxF3F6Tjxv+wGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq/ll1Pkn1TRbb2P6pV6M47MmDEl7QaFBdPUrSyW1nA=;
 b=IzUmiSHuiYpjSvCTMMZQZApnaL2NhctQhx0wOOS805y3MvQhvq53ufmY14oLxco+sUPcyYTCBbgGzM9zqWSAPJfThmWHTY3kspAQsu/4QQun32/y0PARZGoe2ztd3cxVl8nPJ8OXsVEk4DQkFkPOrXrritCbmx+Qf9vtaJoUfogrf2rC8RSgxINNasJioVXCbiTtZsTxkyVp6nZ9ghi6GtJavOzfC06ls14I3s/XcXgzgMS97osfN2B+Yko/bZeqbTIThkMw23eKh/tXk3I928+u+R/txsKdWJabwniNyBqDi5Kv33iN7BwfzzvZD7ZRceWx9kufvCoi0SZoo1tjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq/ll1Pkn1TRbb2P6pV6M47MmDEl7QaFBdPUrSyW1nA=;
 b=1tkg3YA1sWQARLmACc5xVgSlBoV/YRyp5BnVcsytSNAaiuR/RusfkIT8L8SmKr6sZi4qv+oBIxW2s3dEUNK9SDAfpsDyLJLJZcah2HLO8wv/Zky2xW0C8ALqAFwdVxn1ko4JtlKFP5Yu24ySBbQHkGpUHc3HWSkS8tk4IfxKEaY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 13:10:02 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 13:10:02 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/amdkfd: abstract the iommu device checking with
 ignore_crat
Date: Tue, 18 Aug 2020 21:09:31 +0800
Message-Id: <20200818130932.180114-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818130932.180114-1-ray.huang@amd.com>
References: <20200818130932.180114-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR02CA0141.apcprd02.prod.outlook.com (2603:1096:202:16::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20 via Frontend Transport; Tue, 18 Aug 2020 13:10:00 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 138500c2-e778-4647-1049-08d84378042d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4408E9B4FA29535B7AF67EACEC5C0@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mX4TH4wAs9tVAy7HPuHBksZPElFfc0vEkyxMOdsADuRg1UaQKCCBmNRfYd4Wb0lAiUx7hyq+XjvbR7X1k/JFl/7/olE7l4E71ngAYl2mcuwsX3ok/PpSYC52TpHz6hHq88QetvpmQjYVWZDkJ62I+UgqY9lxz9EpcT6EBCOg4DUFY4nUbyYBTuqQlxPb7OiSO9WvrOFPCJloQv69ybbvo7Sx+DPqvmKpdNdbPj6f0QbbVrPebZjvR9Ymhkhh94Tzx4MbbKkw0YqyveogpGXCORiKalsBxowumllYP9i+vINiesWMwgA3Xp34vsnOyaKz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(4326008)(1076003)(54906003)(6666004)(66476007)(66556008)(7696005)(52116002)(66946007)(2906002)(86362001)(83380400001)(8936002)(6916009)(6486002)(8676002)(36756003)(5660300002)(316002)(478600001)(16526019)(2616005)(186003)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bfn3JLyEYFVld0OXbmgKpBrJU19o6WAdgPA71nKgpqlie80hzjpySQwGsDp0LeFYX1XC41kqe5eTlhtmypGt6NwvOuXx/VcI0mJkq6FOOl8mWq09EhWFvUoFAYO/D6tz+77h4re4O8YgTk78ctvU4giPiQbo8RsQm5MWNTiUsFRCzTe8qqPFvcxo0cgutPmXzN5iB3Y1/ltuncvE7e0ITw3zxl4xM4vcLJT3UBzAKkzowlEz+rrcJXa8RJElJJllcirJlEDKRgaIQZ//KkVMlCHqjzfpU0mlwu+ELAYf+2vyim4BOuf7wg4HLHwLhJ9xm2CB+s8Vglg91FwYQMHFtxli2MSVtaz2jqcpcMMQiFBsWOluAxjRpj0n7CK1B9BKKtQamSRfvb0+s+RN4o0Vm8xFGszgleEgD3NDw5OftXFFnr6bdoxikZCKqkUEAcS3/xj0ueqt5omcbHx+jihV6dAgUPtwBRa/2kwRTqY8aIHtS5JSUuzXfGDn3x44v2er/SV6R329whpnh8VR2KZRu5RK0lQJT7OJXmfflt5h6JvwDMg8xcM22NJ4ae0lJKQkn8m156T7U7KFhjZM2VYxVMJDQp2ZkwhzVIJnYPBcdz7XI7Vqozagui7eI2r73aeoddpOfJ2+x2gyWOPixw1pGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138500c2-e778-4647-1049-08d84378042d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 13:10:02.1781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWqrxvDJLPQKyiGDYNsdBH4+CpQ5W2v9bdeRk6echzD43lthI6J6x6lJo4RCmsJEjHu3mHiz/UMwOtrQoonfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c                |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c           |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c                 | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  8 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c              |  6 +++---
 7 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 20ef754dc62e..0598a1682854 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 		return true;
 	}
 
-	if (dev->device_info->needs_iommu_device && !ignore_crat)
+	if (kfd_go_iommu_v2(dev->device_info))
 		return false;
 
 	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 0c4161ac4102..04103273f52b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, pdd->qpd.vmid,
-				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
+				kfd_go_iommu_v2(dbgdev->dev->device_info));
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
@@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, vmid,
-				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
+				kfd_go_iommu_v2(dbgdev->dev->device_info));
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 48b86bdbb680..70cede08e555 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 		if (amdgpu_noretry &&
-		    !(dqm->dev->device_info->needs_iommu_device && !ignore_crat))
+		    !(kfd_go_iommu_v2(dqm->dev->device_info)))
 			qpd->sh_mem_config |=
 				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 6044d36bceb6..fe7e31014289 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_VI();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	if (!(pdd->dev->device_info->needs_iommu_device && !ignore_crat)) {
+	if (!kfd_go_iommu_v2(pdd->dev->device_info)) {
 		/* dGPUs: SVM aperture starting at 0
 		 * with small reserved space for kernel.
 		 * Set them to CANONICAL addresses.
@@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
 				return -EINVAL;
 			}
 
-			if (!(dev->device_info->needs_iommu_device && !ignore_crat)) {
+			if (!kfd_go_iommu_v2(dev->device_info)) {
 				/* dGPUs: the reserved space for kernel
 				 * before SVM
 				 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index c767b524bea4..ea05446572e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
 	struct amd_iommu_device_info iommu_info;
 	int err;
 
-	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
+	if (!kfd_go_iommu_v2(kfd->device_info))
 		return -ENODEV;
 
 	iommu_info.flags = 0;
@@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
+	if (!kfd_go_iommu_v2(kfd->device_info))
 		return 0;
 
 	iommu_info.flags = 0;
@@ -109,7 +109,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
 	struct kfd_process *p = pdd->process;
 	int err;
 
-	if (!(dev->device_info->needs_iommu_device && !ignore_crat) || pdd->bound == PDD_BOUND)
+	if (!kfd_go_iommu_v2(dev->device_info) || pdd->bound == PDD_BOUND)
 		return 0;
 
 	if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
@@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct kfd_dev *kfd)
  */
 void kfd_iommu_suspend(struct kfd_dev *kfd)
 {
-	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
+	if (!kfd_go_iommu_v2(kfd->device_info))
 		return;
 
 	kfd_unbind_processes_from_device(kfd);
@@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
+	if (!kfd_go_iommu_v2(kfd->device_info))
 		return 0;
 
 	pasid_limit = kfd_get_pasid_limit();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 60243798cce2..5087b23ccdb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1232,6 +1232,14 @@ static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
 #endif
 }
 
+static inline bool kfd_go_iommu_v2(const struct kfd_device_info *info)
+{
+	if (!info)
+		return false;
+
+	return info->needs_iommu_device && !ignore_crat;
+}
+
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ad8139594b6f..e6f03867e0ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		 * If the ASIC is APU except Kaveri, set local memory size
 		 * to 0 to disable local memory support
 		 */
-		if (!(dev->gpu->device_info->needs_iommu_device && !ignore_crat)
+		if (!kfd_go_iommu_v2(dev->gpu->device_info)
 			|| dev->gpu->device_info->asic_family == CHIP_KAVERI) {
 			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
 				&local_mem_info);
@@ -1198,7 +1198,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 		/* Discrete GPUs need their own topology device list
 		 * entries. Don't assign them to CPU/APU nodes.
 		 */
-		if (!(gpu->device_info->needs_iommu_device && !ignore_crat) &&
+		if (!kfd_go_iommu_v2(gpu->device_info) &&
 		    dev->node_props.cpu_cores_count)
 			continue;
 
@@ -1453,7 +1453,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	* Overwrite ATS capability according to needs_iommu_device to fix
 	* potential missing corresponding bit in CRAT of BIOS.
 	*/
-	if (dev->gpu->device_info->needs_iommu_device && !ignore_crat)
+	if (kfd_go_iommu_v2(dev->gpu->device_info))
 		dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
 	else
 		dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
