Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05844C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 08:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8666138E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 08:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB8666138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3761A6E9F8;
	Wed, 29 Sep 2021 08:22:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC696E9F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 08:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kort6ARcEh4oFKYIY92l1xdhvyApqCChRYWBpSZ9Gny2chJny+Bd8XUiGdIbWWeG9oODvDOZ0dT0cQ/d/kDTVI4l524vo5i3J8HHpWz/UUOhI9n6SJdM0F6MSNb/z/7oCwfOdOlEfV71OHaPWBhXYp30RMNLrAavVTYXSMkUXP2B1sqr2ZZ0rhm/Dx4tyuIr6GQitXSptSy7aAUnakrwMMo9kexaDp9dZi7DnVEptlLl5xLe5zvoNFMACQGc/Fm9QYuUe598liJKZOXjpgL4Oj7GdivQnxscSktV3iqGs9o+V3yrCWYu206iwuZ4S+8CAF/Ki8zoQRX3PKFTwInQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=RgyiHBygE29Nb8cebQG0wHaQRKK5NXg2O6VRkZOG5wQ=;
 b=ChPcffXQuH3ny1jE5LZ0UlWnskxN0nANK8TP9siiFHxp9tPzxRYMYa8LVrQkOw4YaSusfbLBboocqHZLNF4X0hqG+dGoJ/cqxv+hjG3i6zn/gylLbOzFiS5QqKQvV2nMo/AJwBjfn25U2Ps3BFxFk5X/Pxvck7oZQEcIxuTArd1CDWHij0lilEJyApyYBKPzoTJlLPVUX9Z/MJJPkxaXmZ+ve+jutZCaFL/scj64gCI16H/84Rga1GusVnFFmqDLqFoirwdyQNMV02BhNFbR3BtQ8h9HhtC7YxqTk24fjF1zRCUVUcan32rvBy+3zK1i6XUg8JksM32iENEseypEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgyiHBygE29Nb8cebQG0wHaQRKK5NXg2O6VRkZOG5wQ=;
 b=j61gmFr25z05lqqvFmo5vbazy8I8af8Ze35xcmpxeg7/iFQvJjYuluDbm2WMoMXobaPOtqrQjCv3CbrKUpUwLrILtJ5jDA+fiRu8aTq6IS2/2jKyb/gVZhQZ1EFMS33w1nde3JRBmnPJ92w7HXJnV0me18E34kkc0s+NsA1UBxI=
Received: from DM3PR12CA0094.namprd12.prod.outlook.com (2603:10b6:0:55::14) by
 BL0PR12MB2484.namprd12.prod.outlook.com (2603:10b6:207:4e::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13; Wed, 29 Sep 2021 08:22:33 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::88) by DM3PR12CA0094.outlook.office365.com
 (2603:10b6:0:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 08:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 08:22:32 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 03:22:26 -0500
From: Lang Yu <lang.yu@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
Date: Wed, 29 Sep 2021 16:22:12 +0800
Message-ID: <20210929082212.1806312-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 244d5a84-be79-4821-9918-08d983224918
X-MS-TrafficTypeDiagnostic: BL0PR12MB2484:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2484800FC1F7AEB61B69AC1BFBA99@BL0PR12MB2484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESY2NAyovAQK6eVvFVdqlFYFi9pIrX8BHMyxkNNAynIGZG2nJ4DTYaRlFCQHovYlijfaZZQCRctyM/lRK873Yj/+KsBWnNHU92EAO2LMVc/blgNEJwZfvieatmeGAk5Km+b7QzPR+vGhwbvCOUyXH84bWecGlZlOr1MwczbTJfRGBsWNkwaskoCDmhMzAwRp6dSG9HCSQtsNRIz2SqklpVJe6PJmUyMbMInqhlg7UUDpV51jPOcOuPSCH8AqvnBmpZIU7jUyItAgfEvdP2DA2IdmGivRNlMrB8NUs+D0kW/SrkUK8mkAEJFYQ/mOufP3BMGZeaCMPEYz+MEyOUP2GBZlKedlLlAwDQT+7RVj8zObmywil7RbBdcqXtVVmIZ7f8D4Zqfuwm4kCpZj6DGe9vc2HRd77Uo/FtrG/G0xA+f46pfcjpY3izZqo/4woOMBFLBoMxW90Rdg1lVPDz1AnTYdZDyQtX6P4wwEpSF30UWVt1txQDaIfbt9fkjMkmT3m4/WbCoT3lzTOT92LtdqduE955nLTpcrtmeAPc4mtZ2aD+xCDhIJNMyjrxneP5sHmWV0KRcqt8YytEWkdCK7kMMAdL1OwmMNil0FbvTy2EAlW+or/NQSlvqhQSM11oXa08qjuYsqgKKd3MXzpp62+u9T01wFnNYV0go5s5BQWvbMXopczmkNt1D93iEsmB+dv81/yTiGSAy4ZADUP19QV4gnLjKBc6g0sE8Q8f6gh+g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(2906002)(1076003)(5660300002)(7696005)(82310400003)(86362001)(316002)(6666004)(36860700001)(356005)(4326008)(8676002)(336012)(81166007)(83380400001)(70206006)(70586007)(8936002)(110136005)(2616005)(16526019)(26005)(186003)(508600001)(47076005)(54906003)(36756003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 08:22:32.7321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 244d5a84-be79-4821-9918-08d983224918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2484
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

If user doesn't explicitly call kfd_ioctl_destroy_queue
to destroy all created queues, when the kfd process is
destroyed, some queues' cu_mask memory are not freed.

To avoid forgetting to free them in some places,
free them immediately after use.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 4de907f3e66a..5c0e6dcf692a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -451,8 +451,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 	retval = copy_from_user(properties.cu_mask, cu_mask_ptr, cu_mask_size);
 	if (retval) {
 		pr_debug("Could not copy CU mask from userspace");
-		kfree(properties.cu_mask);
-		return -EFAULT;
+		retval = -EFAULT;
+		goto out;
 	}
 
 	mutex_lock(&p->mutex);
@@ -461,8 +461,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 
 	mutex_unlock(&p->mutex);
 
-	if (retval)
-		kfree(properties.cu_mask);
+out:
+	kfree(properties.cu_mask);
 
 	return retval;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 243dd1efcdbf..4c81d690f31a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -394,8 +394,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pdd->qpd.num_gws = 0;
 		}
 
-		kfree(pqn->q->properties.cu_mask);
-		pqn->q->properties.cu_mask = NULL;
 		uninit_queue(pqn->q);
 	}
 
@@ -448,16 +446,16 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
 		return -EFAULT;
 	}
 
-	/* Free the old CU mask memory if it is already allocated, then
-	 * allocate memory for the new CU mask.
-	 */
-	kfree(pqn->q->properties.cu_mask);
+	WARN_ON_ONCE(pqn->q->properties.cu_mask);
 
 	pqn->q->properties.cu_mask_count = p->cu_mask_count;
 	pqn->q->properties.cu_mask = p->cu_mask;
 
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
 							pqn->q);
+
+	pqn->q->properties.cu_mask = NULL;
+
 	if (retval != 0)
 		return retval;
 
-- 
2.25.1

