Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6D7C6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 18:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B7010E073;
	Mon, 12 Sep 2022 18:05:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACA810E073
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 18:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoLe7BT+8yMd7pYLNoU59iS3Vbd2odpHlWhS27kA9X263V3xUc3HUC5D8XcQvxKhhv9gW+G2Z2oLYIgVIN3WL4iBCuOvm/E6iD+Net5fwRkQ6p2eOTUIU8+Nd3KmvuVMOVJ4NnIjIoQReWkSua8Chkfa8MzkCqxnWPY8gTybc0lClg5jTiy3EFn0bV2MnTA7+9EZLuu+arPmKGe5SqdDn4481PRndkmMuAR3OH6BEaHmpKPb990ICWwNZ2VnD49lDiTEDFOWV8vQmHM8jdsv0l78jX62AYs9s99BrrFcGYD9mpjZ/v5aTwO+7wLkkk6+7a6mF0q3+J3Yds/DJ8c+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2nByxulniALPzfCWpaFa7RCKoUsts/l9wZCAM7ZQz8=;
 b=hZKYiEwr4OKVdaW6tsWQGPhf/RkT5XQPO6Zxa1tv9GAuFWu+NqrjjUSvu1PgD306lerTg+IHpgA/b+xhoC+9kaXuN+ZqlVK96ElkMiNLCHA2bQLBE8tnlagi2o90IzS3Ma5rCu8UX0iOaHnzKKYC37rxhW/OfGzgWMTF9qK6sGcXcyV2BwW3nlWq3NactKJMbNK2TQYx7MMl5+Z8OAkbYAttn6t8YjppmkfxO1l1E2znnRVqy0wSmSF90PZWLmfiDtmlenCqLcZ8ArUGnZpc8bzSn0ejMFaFcjh7ectnhWRlunIHewKi6n/rJ70RPpYw4nAdyubM5POiLRtVsEEXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2nByxulniALPzfCWpaFa7RCKoUsts/l9wZCAM7ZQz8=;
 b=b9nJCVhRdoXozf0pf5j9zhSGHKVLryRwpcKbDQzJyFTtg3zoltGO3zCGIn3DSwiG61An7fBtXPIhdqWrpt/I8xFyXztxX4WX2f/Y70uyLITGeJUZjeawUJYp68M39+JuzArXc4wQN20WXYsSeDjtl6Zhy71aw7xpbm/sw18oAGo=
Received: from MW4PR04CA0289.namprd04.prod.outlook.com (2603:10b6:303:89::24)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 18:05:05 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::b1) by MW4PR04CA0289.outlook.office365.com
 (2603:10b6:303:89::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Mon, 12 Sep 2022 18:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 18:05:04 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 13:05:03 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Track unified memory when changing xnack mode
Date: Mon, 12 Sep 2022 14:04:47 -0400
Message-ID: <20220912180447.19622-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ba62cc-ecef-45e9-c6e3-08da94e951fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FA0AOra275CpkiPdsagW6HrgV+BJRDznhRlty0x9Gd9kemq8k1BFsyhUxNaCQMy71xSPQpd5mhuK925qrR2VsA7knJxEpQOvrLun7D+UiGkDD06Scgslk+8hL+2sf+F/UAUo/qRE3zWUaYDZLALsUWc2cwDs3Ps9afpwYMwfBN2mu04qYgGAtBdrW6wxLuASY5BLDFEssXYvuWmZqtXbJECS+WU3hqonfv9ddMCjQkmzfEdNr9Ri68GetonhQPBruvTwXeWMqTf7NXXvqqdXw3fwoG7SLpr0ichzIOZUoGC4noKTqekBBiSZm6VXx6ExDhfbk+/CG1gCidkCrv6wwn+pBpDxfEog2CYCjmlXZhdxDwF++HIKVOtBBLMQIEVyRGHyoK7omO9Q/VRB4y3m3zBMZ6B5Ic7P/CWu3ywja61m9peTsinVyl+gj+Wg1i+fwGj73EKx/N7YlYvAQA4mXOBFenS4K6DeCm7eBdzGM2Jrzdns7gdfuiOkhNsyf1OTp0eFn+3h1bT5NsiTrv/uNbOoPafTYV9BjOT3grci6BjfV+CSUAJCO2uYYzk5YydUt20B8+sfdd19kLbbAZ0fwac2RA2R8PdK0XDUQHv/hTzXm9C8bW5OF0hwtZ0e7Q/ZEAs+tri7xtrZQMyy8595REWMHxaLDENONkRpH4Ddgqi9A9MK66KJeq2imzKiLIrZP1HviBKtgrqC7Ujm7X6aIS0bfWch9XJKksKyzlqvJmRbY8+fd3w7vPVIfB5XiMBdmTLZVmOd9pcala42W2oN7LbPEPvEScqKvl6DYcow1kfAhPMJmcp8g37+j/1HXtv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(86362001)(4326008)(7696005)(2616005)(82310400005)(8676002)(47076005)(26005)(426003)(2906002)(40460700003)(478600001)(40480700001)(1076003)(41300700001)(5660300002)(316002)(6666004)(70586007)(83380400001)(81166007)(54906003)(6916009)(8936002)(36860700001)(82740400003)(36756003)(336012)(70206006)(16526019)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 18:05:04.8282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ba62cc-ecef-45e9-c6e3-08da94e951fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unified memory usage with xnack off is tracked to avoid oversubscribe
system memory. When changing xnack mode from off to on, subsequent
free ranges allocated with xnack off will not unreserve memory because
xnack is changed to on, cause memory accounting unbalanced.

Unreserve memory of the ranges allocated with xnack off when switching
to xnack on.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 56f7307c21d2..1855efeeaaa0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1594,16 +1594,28 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 	if (args->xnack_enabled >= 0) {
 		if (!list_empty(&p->pqm.queues)) {
 			pr_debug("Process has user queues running\n");
-			mutex_unlock(&p->mutex);
-			return -EBUSY;
+			r = -EBUSY;
+			goto out_unlock;
 		}
+
+		if (p->xnack_enabled == args->xnack_enabled)
+			goto out_unlock;
+
 		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
 			r = -EPERM;
 		else
 			p->xnack_enabled = args->xnack_enabled;
+
+		/* Switching to XNACK on, unreserve memory of all ranges
+		 * allocated with XNACK off.
+		 */
+		if (p->xnack_enabled)
+			svm_range_list_unreserve_mem(p);
 	} else {
 		args->xnack_enabled = p->xnack_enabled;
 	}
+
+out_unlock:
 	mutex_unlock(&p->mutex);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf5b4005534c..5c333bacf546 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2956,6 +2956,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	return r;
 }
 
+void svm_range_list_unreserve_mem(struct kfd_process *p)
+{
+	struct svm_range *prange;
+	uint64_t size;
+
+	mutex_lock(&p->svms.lock);
+	list_for_each_entry(prange, &p->svms.list, list) {
+		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+		pr_debug("svms 0x%p size 0x%llx\n", &p->svms, size);
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, size, KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
+	mutex_unlock(&p->svms.lock);
+}
+
 void svm_range_list_fini(struct kfd_process *p)
 {
 	struct svm_range *prange;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 012c53729516..339f706673c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,11 +203,14 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
 void svm_range_set_max_pages(struct amdgpu_device *adev);
+void svm_range_list_unreserve_mem(struct kfd_process *p);
 
 #else
 
 struct kfd_process;
 
+void svm_range_list_unreserve_mem(struct kfd_process *p) { }
+
 static inline int svm_range_list_init(struct kfd_process *p)
 {
 	return 0;
-- 
2.35.1

