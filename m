Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A70C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773212075E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dt+Tj8/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773212075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD776E220;
	Wed, 19 Aug 2020 11:07:13 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29F76E220
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 11:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2v1uBhqFcT2Pl3yAA3dW2u+jO6elPzcyQ9TO8iE9ybRdTF/++ME3v5iMlCpG5vNI3Kcy2R5hmFopS+Ai8XXx4a+WXkwmK3nMuZFz2aL6oSdp538Z6tnE8T6WxgyNNuoClfZgO3g8cT5fH2ndlvFkRDQqMGcRLi92O1+LrU8YCgaVjfmCv8yUjszdm2kK0YNxlTyDJiyshpJ3wQylc7d3HAoxFwWyEreVhAoEunac84CdmHOOn6ldYdsov+R1pcyeN2WwOwn2qS/oOXB8HOo+KncWHIMX2C2F2X/eCknMUA6hywQ4Vh9q2hRG2J8tgtz94xoRhAytSUwe8xO1Q9o+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSxEKPab9lOFy5LkE1dnUWV+KIlwYkzrX5GVjcUyLM8=;
 b=kP80mUyoUDYQ1R565qbSSslErSe253+e3j56gWGJXblYqXGbWX8GNcDRHRsQW/jiNDIq//EzAEkw7QFXkrxI4JY5S+zQ8bUFO3SBlhsfB5cMtlu+lB3guzsLLNSRz4f1w5AABlzNsSL43wvfgxRGsmu8E7QbCeP4mi62WYrJ2WFnrwKlW1+MNVG/RaR3/hiwOLPiM1dimsSky1D0dBv+QpQJ5daIKhZMwHO7/eSXHjvx2+gZTikw6M8yx30rYY74WdTg4hkDerfsKWn3ruiWRa0NMLy74TcCOZm9Hs8BvteG+WYAnPs/U3dgPyoJDDq5foLIcmHvZokZ8RGnXfJ2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSxEKPab9lOFy5LkE1dnUWV+KIlwYkzrX5GVjcUyLM8=;
 b=dt+Tj8/N+OBJXgThRJxCN2xMsRLOoJZfg2kIdwu4AXUGz8KwW9ke2bVcUtzNsYUa9n9KZUNtcKPjJkkmvZdXbAzAdgyFIVMonHQqIiTPLw1vC8rFo0cdQ3P9ikGgBEjBSKf/nAAu2qRuJlS8Xp+5D2EJj3QDxeyOHbWA6oVHF/U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 11:07:07 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 11:07:07 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/3] drm/amdkfd: abstract the iommu device checking with
 ignore_crat (v2)
Date: Wed, 19 Aug 2020 19:06:46 +0800
Message-Id: <20200819110647.212404-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Wed, 19 Aug 2020 11:07:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f354f02c-d035-4e37-5951-08d8443002a8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41260BA7679EE7BC8017D9CAEC5D0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcmbr4JYDKr2NXB8fdMOIMympAQ9Gwng2H6YkuSGLtDexU/smAFQZtfyt6JDXBGKTeRgmLq1Ibco7zU6J582B/U5ruFKSmU25WIu2fGbNOJ/8PaAoJPb6Sk/jy4LH5phfWwaocth8ijn64Rbe/2GkGqf8D0DfF5LwSMGXVjj0mXArooMSZiU3eqIWzmTVry4AW92CFFZCBbrW8kF4YBZ/tYY2Zo2Xl+1AhGBakpvGaZbdgpNblYQAhn2sT8dQtCh6Lf2hdW2AkFaTcY9fP2y1/TXNlHp0UF6tOYVGZiK3MuEq0BqT1idgmmNv6Ghqc4k7wOUIU8CyF8NwFE0VKjdnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(16526019)(6916009)(186003)(83380400001)(2616005)(52116002)(7696005)(956004)(36756003)(4326008)(6486002)(54906003)(26005)(86362001)(6666004)(5660300002)(316002)(66476007)(2906002)(478600001)(8936002)(66556008)(8676002)(1076003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TrPJdB3N7/xdyYNqULSMN76LCJ/q/Vc7GA5o+OK9SWGOWSMCjtKHnk55X2mxdaISs4MO4Wb6qwwDJAd8SZ7jOFX4etCFCXUdF/hfjooQYr1E/qZhAV52+D+54zZNS03yEgR3xBBQMzZLSn/R99XztO1Kl9xVP38lGqWG7qzbaI/gFcMTSypZ2UK09YxDJ+Nr7v/XKItk775rkD/f8MTwiwWoJFYtlIfULuUHFvtNh2ySyvfDP/VxeA4vnCnfwam1OM7OTLxfjPBH+RFWodcLhV+vCnFInDZEHx4DjWsxwNaUjGsokzbxwaspOCIgSSjLVwr78iFTRdCn6I6l24Co5eZBdigEXW73Dg1kgr/R85jxgrdwRxka8RMy96mj5MVbsb6oQltfek96/JYwn+fm9DWjt49n5XfjuYdO9yAt2IDgXurj4Kf8U88G+/k4mSwpIjXmvJ5FfipgJmlWpdL+9YesnwBrgrw+fYYHE9BxvdxeCxYUqbYPF1xh6NV/XEwC8N+76eblmSP6+T3zWWpI5FLqHQq6wibv5oUNe+5InjuiJ/EnZyYedqW0DMs3rTUgnO/faWI97xAp/644w/fqwgMKqfP4CMglIqSeYLUZJW0/sTmQ9Gx7C/MXoVNUZ+/vcYa8TAgwBB0hEZ5BuhKO8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f354f02c-d035-4e37-5951-08d8443002a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 11:07:07.0229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMVdZ9g4KNVyCEIZgWowLFBzYwM/KiWBh8mFpA6haiXat1Si+CfRpdQqcze8qcdncWHcZ7bHe+iNFYMhhROaPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
