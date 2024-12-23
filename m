Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F091E7718B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 15:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997F710E193;
	Mon, 23 Dec 2024 15:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8tP5ThC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD2410E193
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 15:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1yUORZ5bNQ44cAkUrehOtBVMd8quNkAteA74UODqZTEhw3PWSKqLUl0vkT0hNoPadPTo9+8nC+iFG/PSucTy/Oy7oglxK6RUoDDfOPG0J4nj2yIVZvmdJ+pT1kCHgNo4qGONs0wMNFgBOs/KqmzzZKLKgG5ke4UEiQ2G9oIPZbcQH9kUK1my538jnh7uF6FR83I7h8i5vXN55Jw2gvrY82rLRIOssgYCRIhgs3WxNf6OBb1zZXTjUmtXTciUwH3QCKGyriLr2AS6U+paB/fuLPr00Q/o6OrCV+YLlJ+J+pepGF0evLf694nSJ/tubaRKhz5Rp4w8+TKu5KJv95TSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCw1YQTvy094BlgfgfNKIjw6AzNW2U70Ydbp+ZuXmd8=;
 b=aOJ0SSqxphThWVu9QzSapEt4qigcOZ9QruB4xbNjWC/+k3udvkGwtGn0wjANMeQFvQZk92zEKuPR2u5n3q2d5joD68zWmRmd7GKY5VqLvzencvgU/lte4RfDUk/24JQ+35WExqzfW5joV906cgxlXrfSE+W1pCPtaAiMZ6onQ28d7MogjPZaJDRNi7ss2YWbfBznfp+D2uTbBeCBxbOehhHKwj8V57AzCut4IN5a7w56NgDsvVkiWXt1bhsYyB8WIOYGQ+QhOOC4l7hCQEqjVsRxGBxT62sQmV9/+Joz9t+lDOpl/2x55gA+1mMOkWkfZ0KgT6Y7TqTS7tyq4wRfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCw1YQTvy094BlgfgfNKIjw6AzNW2U70Ydbp+ZuXmd8=;
 b=J8tP5ThCCgTa6rRPWv33rV6Dmk8LCIdXXsKsfK7cSPOokTzsoTHYkDjJvGcaboCN4+mKWen6JseZZ/u7CXp4nAQ9SRPJeR6v/CIyc8FBK1l508iSyxQp4x+UfgwKghYcokNWQInLIpTW+lnWLazN3leUcYRb1nb0vLNPZPlrh7g=
Received: from SA9PR13CA0180.namprd13.prod.outlook.com (2603:10b6:806:28::35)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 15:35:00 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::b1) by SA9PR13CA0180.outlook.office365.com
 (2603:10b6:806:28::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.10 via Frontend Transport; Mon,
 23 Dec 2024 15:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 15:35:00 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Dec 2024 09:34:56 -0600
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>,
 <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix Illegal opcode in command stream Error
Date: Mon, 23 Dec 2024 21:04:39 +0530
Message-ID: <20241223153439.2208-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: b39f8a57-5db0-454f-fcc4-08dd23675cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YI+s2OcM1wp7vW80Rh2vIUoPEZwG1Tf53jYiY0hBk34hZTtmjx4Aj0WzuWnz?=
 =?us-ascii?Q?lQlbtNExfmBOJ57TU3VRvh15KD0hSdLH3zff/5ZIgcsSE546r+oeW6BxNeuJ?=
 =?us-ascii?Q?XTEGe7DlmNop9dwM9I3movleAv9HgzQB6RNO4wqT9zmPo6Tomjag3fJrT8lr?=
 =?us-ascii?Q?YTSofiQcrgk0vLEZWSuilcSs8T9VY9/pFxqNlLoCadBUQs5kUeNb5DGVmVGl?=
 =?us-ascii?Q?c/zJ8fekj8Vca2mgVvils9NG+UzXyuJzHyqjz3lM4yXmsRzvXl4tmf701D6M?=
 =?us-ascii?Q?yls+eFc/u/4XxqdBs3qylk179oz62RBRYjsvcEei6DI1EmrtyGw/+i01oaK7?=
 =?us-ascii?Q?RjrOdUB1Pk6s5cnOEDWfInnI+dDkSdgAHmiIkj28K8HHt3vEo9RatB1UfNWL?=
 =?us-ascii?Q?Qyh6wo983rS2C9gyntMZxBt+vBdVEZ0Q8MCaM6DhalbHEPu7aGER2TFo9Ns6?=
 =?us-ascii?Q?nOw3cbrJ0gQWRchUVw4y9pG5AcxEoMl8RjRIFMSMwpWcMxpBom3jFOGzkbC1?=
 =?us-ascii?Q?ShtM0sL/kQ0Ji+Bq5uT9yyZS0pPLcV51pVvgK518ZRaXSw8OgTB3+tw4Jayz?=
 =?us-ascii?Q?nQWRQ1rsZgCpe/JcLKhNroIKpyKlCPn2nrS/KnlXGGRUTn91DlxXMU/k4vn3?=
 =?us-ascii?Q?W307Dr9RjnAPtOBXmnmbl7VuVomUBwAqO4wclLgrL6IBq91csnCb6yY001PP?=
 =?us-ascii?Q?2pvhPEVOT7cEN4oLmiaHVoe/7BvhTqZtv5PDlr+ObItKHN/rLtOKaTNR9D+h?=
 =?us-ascii?Q?8Z4yL9fijDOaetxkakfkKOF00ndVuxFW88S6jpH09ycVUdMNak1s8NOAYyVC?=
 =?us-ascii?Q?KMcL4osg6NTThQrYZLOD5D3JXCT0e27qqDIwy1XtB7l3j7KqipfEpiqpf8RL?=
 =?us-ascii?Q?JM6VZeJ7W8dgZky3NG5MblcKjNe2XQMWhQlPPaUuMA78BFYhOq+aZA8AQOk8?=
 =?us-ascii?Q?Taq3tTss0q0HSNGly09oe8jcdlpyXeDhZhAq6SMTaOoqI23bWzxaHa7nnEYF?=
 =?us-ascii?Q?2AxDWDk5XJIjwrCeL9Wr+g+BaIRkYnuMQaUt/9bvFJmw5RZsKu1GlyMHDHEa?=
 =?us-ascii?Q?fQghPXNL6+gfwrCqIhY6ZqPhx8A67wglui6j6+tC0Frnjjk2pj6OkmD0QyW/?=
 =?us-ascii?Q?EzU0/W0H+5BNM+DvwKBwmL/tyxtsh/QtUOiIzzIIkOXr8UR67GQq57SZLmJP?=
 =?us-ascii?Q?y3AZ7hjFnsb+aG3aWva+wFxriAU9WR7l2n66VpT3nsvW9lZJlE8DqIilSP5C?=
 =?us-ascii?Q?1AtbbeJUbyuFHMzxenfFsUum4BH4d+FBrpmRaWV0kzjh6PvDDuheTqn1f/x/?=
 =?us-ascii?Q?C9oyGJuNQ1tPF+CiUECCd/uHOIsVcrsaAPVexQDHTo3TuQwUC/5JcQTvrpoS?=
 =?us-ascii?Q?AnaX2Q3aD14fmk5Wm6FuSS1KWJOqar5RHtJa4oUK6my+JPtCs9wT/6M4txLZ?=
 =?us-ascii?Q?94+XSmmKRY4sc4oi1vqucYI+BqUm2SHrQh9fNpDGRMHhcDyuFIIdPzOV+B43?=
 =?us-ascii?Q?6X4bnR7hnJQZvwk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 15:35:00.0558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39f8a57-5db0-454f-fcc4-08dd23675cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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

When applications closes, it triggers the drm_file_free
function which subsequently releases all allocated buffer
objects. Concurrently, the resume_worker thread will attempt
to map the usermode queue. However, since the wptr buffer
object has already been deallocated, this will result in
an Illegal opcode error being raised in the command stream.

Now replacing drm_release() with a new function
amdgpu_drm_release(). This function will set the flag to
prevent the scheduling of any new queue resume/map, stop
all queues and then call drm_release().

V2:
  - Replace drm_release with amdgpu_drm_release(Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 ----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 62de668e9ff8..acb9dc3705ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2794,6 +2794,20 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	return ret;
 }
 
+static int amdgpu_drm_release(struct inode *inode, struct file *filp)
+{
+	struct drm_file *file_priv = filp->private_data;
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+
+	if (fpriv) {
+		fpriv->evf_mgr.fd_closing = true;
+		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+	}
+
+	return drm_release(inode, filp);
+}
+
 long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
@@ -2845,7 +2859,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_open,
 	.flush = amdgpu_flush,
-	.release = drm_release,
+	.release = amdgpu_drm_release,
 	.unlocked_ioctl = amdgpu_drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2a046736edd..f908355df07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1478,10 +1478,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(pd);
 	}
 
-	fpriv->evf_mgr.fd_closing = true;
-	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
-- 
2.34.1

