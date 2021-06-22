Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C75C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1054F613B1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1054F613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5AA89C17;
	Tue, 22 Jun 2021 13:32:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECD989C17
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 13:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYzOuH9TF4YDpQ9q11YhBKpNOfqcXYf+bYJnGoJdQaTYpvDKn6nyxQjxSxmymqk4WtG9F8hdtrtmSHWIIP9lsttkwF+yiLqIbbaGikc+BF5BdAQYLnVO3Aq/YpLMkA0ddH5wbTL1WpydD1tGqFveSN15H4KLQmkIELk2Po98C0fmd9UQ3bJq4GTe7p/4fUiNMW/7YSiFhLXcyLartfnCCXNm/OGt2TiiJcWxk1QdJV7y/cXQyZ3mcH9penIH2NGnWFhLzrF3J1ZxQXBB1H/LNglFeWN60pGVH33hxeJI3mmWN+uXwVYj+KCs2wXkkTKFV/Tl90J7arYgTNoWf6/zPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BERn0WFR8v5ZMGKGruf1MmSNlS8wgob649cRGniEa54=;
 b=SeXkgEZd+MSEokUwmiqGxQYgd1vwANiFOP2YXZP2QCyrv43nhdHqef1TXba9d28Yc8n6HOFZdcUwoHZK6Fl+sQA8tzmWLMSjipV8wjsUv6OuoJJCQItdcnnz9bDNKj93Ty0y2XU/s4eFlqOpd8lk7bp2Ii6Mxzki1RZLVzjY2dPlI3KAveKw/8ayxzTXs6hPey3nCgqzcRDmNSG1DiVD4bmABEfXGLLewrBciKaAXk6YDaSmSgK7v7p+YGIyKUB8sfz+iD/kuYRKBqPAxtg1e1YcI3vUzF/Z6DaydUERKwbWRZub5qaiDjDwXi7WV100IFAIjYqHQ5yi+Sitwi8ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BERn0WFR8v5ZMGKGruf1MmSNlS8wgob649cRGniEa54=;
 b=0rsLnAmYAVBTl9hLDDxpyp/sxTp0WVIjxU1dQp6UCXT77xNft8EV+jZc1DQnCUUaUELW6dcEmFR4VGlgGzXiUkKX6doX8m+NMzk+eCGMGWqOLG1ELlNhBNif9V2KPwwMkxopYoIuW35SD8GguHCzWp2mWtZEBymzDruvOq7JLdQ=
Received: from MWHPR1401CA0008.namprd14.prod.outlook.com
 (2603:10b6:301:4b::18) by MN2PR12MB4254.namprd12.prod.outlook.com
 (2603:10b6:208:1d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 13:32:32 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::43) by MWHPR1401CA0008.outlook.office365.com
 (2603:10b6:301:4b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 22 Jun 2021 13:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 13:32:31 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 08:32:30 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdkfd: add helper function for kfd sysfs create
Date: Tue, 22 Jun 2021 09:32:10 -0400
Message-ID: <20210622133213.21393-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9a172c-d711-407c-8837-08d93582303f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42546DE6E53D05895E0DAFE2E6099@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy53nVyWINkRsacaIz0VqChFIq/tK63cqlFN/smhakDGvgwoCB5oByqCkM9gCWrvZRzlvikWGyXhJPI9HXqcRewWy4WgL0AABvjeXG4HdmT3tzMjCQScYWxGspvUJ05zIWMUx57uuEzAlgkKrVpyju9FhjS4se5poTWId2WAqVl0IK/sEwZJTQRLGKRlVzJIYM3UYBHLCSCkXkdaZtcrlmduuTMlwBHgBOAp+lvIE63XXMU/Qj0VtDbGyNTa6tDKAI2Hdir7dcNnWBsHJ2As6V3NTtuuoFbyQ1Q8ZNMPq4HVj6qYoptu7VwZpIi0lcKXeFbzRyx+iXATfxz7k6u50mS7QH+rDOcja4qBY1qG3Pu/te6CI4wnAp9bA5yb5pQx+8uxuJT6xJRR+JD5Egj8tD/+4Q72yYYBazA2Wxlloz2yHcnA7RH/yDCtjQIKhEZR2CLT4dMr1BK7lI4aZcu6/V3iciXK4qT8UTrv9rZ4Jd+pQ3OyRsbzN9aVScxXUmeR5/uj3FQDVKzMURyr2DEO/gwUZXqnrbYINggDmCdTeWa5hXe7EYY+jPl23Vjg9D8/Wv5BIKZN6aN7MBPa4RlShldRCxTK/VL2QUm8zjZ6UWBXUotOlaMF/nyyb30YI7NtZzc2owNyINWbSbt1u0TEpYK9gXcOVRFjEoFIUrfaTvf1xYFj0xNA4jZqVU21AKes
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(8936002)(70206006)(186003)(83380400001)(26005)(1076003)(2616005)(2906002)(81166007)(86362001)(356005)(36860700001)(478600001)(5660300002)(16526019)(82310400003)(6916009)(316002)(36756003)(7696005)(8676002)(47076005)(70586007)(82740400003)(6666004)(426003)(336012)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 13:32:31.9457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9a172c-d711-407c-8837-08d93582303f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functionality change. Modify kfd_sysfs_create_file to use kobject as
parameter, so it becomes common helper function to remove duplicate code
and will simplify new kfd sysfs file create in future.

Move pr_warn to helper function if sysfs file create failed. Set helper
function as void return because caller doesn't use the helper function
return value.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 119 ++++++++---------------
 1 file changed, 39 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 09b98a83f670..3147dc8bb051 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -484,34 +484,31 @@ int kfd_procfs_add_queue(struct queue *q)
 	return 0;
 }
 
-static int kfd_sysfs_create_file(struct kfd_process *p, struct attribute *attr,
+static void kfd_sysfs_create_file(struct kobject *kobj, struct attribute *attr,
 				 char *name)
 {
-	int ret = 0;
+	int ret;
 
-	if (!p || !attr || !name)
-		return -EINVAL;
+	if (!kobj || !attr || !name)
+		return;
 
 	attr->name = name;
 	attr->mode = KFD_SYSFS_FILE_MODE;
 	sysfs_attr_init(attr);
 
-	ret = sysfs_create_file(p->kobj, attr);
-
-	return ret;
+	ret = sysfs_create_file(kobj, attr);
+	if (ret)
+		pr_warn("Create sysfs %s/%s failed %d", kobj->name, name, ret);
 }
 
-static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
+static void kfd_procfs_add_sysfs_stats(struct kfd_process *p)
 {
-	int ret = 0;
+	int ret;
 	int i;
 	char stats_dir_filename[MAX_SYSFS_FILENAME_LEN];
 
-	if (!p)
-		return -EINVAL;
-
-	if (!p->kobj)
-		return -EFAULT;
+	if (!p || !p->kobj)
+		return;
 
 	/*
 	 * Create sysfs files for each GPU:
@@ -521,63 +518,43 @@ static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
 	 */
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
-		struct kobject *kobj_stats;
 
 		snprintf(stats_dir_filename, MAX_SYSFS_FILENAME_LEN,
 				"stats_%u", pdd->dev->id);
-		kobj_stats = kfd_alloc_struct(kobj_stats);
-		if (!kobj_stats)
-			return -ENOMEM;
+		pdd->kobj_stats = kfd_alloc_struct(pdd->kobj_stats);
+		if (!pdd->kobj_stats)
+			return;
 
-		ret = kobject_init_and_add(kobj_stats,
-						&procfs_stats_type,
-						p->kobj,
-						stats_dir_filename);
+		ret = kobject_init_and_add(pdd->kobj_stats,
+					   &procfs_stats_type,
+					   p->kobj,
+					   stats_dir_filename);
 
 		if (ret) {
 			pr_warn("Creating KFD proc/stats_%s folder failed",
-					stats_dir_filename);
-			kobject_put(kobj_stats);
-			goto err;
+				stats_dir_filename);
+			kobject_put(pdd->kobj_stats);
+			pdd->kobj_stats = NULL;
+			return;
 		}
 
-		pdd->kobj_stats = kobj_stats;
-		pdd->attr_evict.name = "evicted_ms";
-		pdd->attr_evict.mode = KFD_SYSFS_FILE_MODE;
-		sysfs_attr_init(&pdd->attr_evict);
-		ret = sysfs_create_file(kobj_stats, &pdd->attr_evict);
-		if (ret)
-			pr_warn("Creating eviction stats for gpuid %d failed",
-					(int)pdd->dev->id);
-
+		kfd_sysfs_create_file(pdd->kobj_stats, &pdd->attr_evict,
+				      "evicted_ms");
 		/* Add sysfs file to report compute unit occupancy */
-		if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL) {
-			pdd->attr_cu_occupancy.name = "cu_occupancy";
-			pdd->attr_cu_occupancy.mode = KFD_SYSFS_FILE_MODE;
-			sysfs_attr_init(&pdd->attr_cu_occupancy);
-			ret = sysfs_create_file(kobj_stats,
-						&pdd->attr_cu_occupancy);
-			if (ret)
-				pr_warn("Creating %s failed for gpuid: %d",
-					pdd->attr_cu_occupancy.name,
-					(int)pdd->dev->id);
-		}
+		if (pdd->dev->kfd2kgd->get_cu_occupancy)
+			kfd_sysfs_create_file(pdd->kobj_stats,
+					      &pdd->attr_cu_occupancy,
+					      "cu_occupancy");
 	}
-err:
-	return ret;
 }
 
 
-static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
+static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 {
-	int ret = 0;
 	int i;
 
-	if (!p)
-		return -EINVAL;
-
-	if (!p->kobj)
-		return -EFAULT;
+	if (!p || !p->kobj)
+		return;
 
 	/*
 	 * Create sysfs files for each GPU:
@@ -589,20 +566,14 @@ static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 		snprintf(pdd->vram_filename, MAX_SYSFS_FILENAME_LEN, "vram_%u",
 			 pdd->dev->id);
-		ret = kfd_sysfs_create_file(p, &pdd->attr_vram, pdd->vram_filename);
-		if (ret)
-			pr_warn("Creating vram usage for gpu id %d failed",
-				(int)pdd->dev->id);
+		kfd_sysfs_create_file(p->kobj, &pdd->attr_vram,
+				      pdd->vram_filename);
 
 		snprintf(pdd->sdma_filename, MAX_SYSFS_FILENAME_LEN, "sdma_%u",
 			 pdd->dev->id);
-		ret = kfd_sysfs_create_file(p, &pdd->attr_sdma, pdd->sdma_filename);
-		if (ret)
-			pr_warn("Creating sdma usage for gpu id %d failed",
-				(int)pdd->dev->id);
+		kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
+					    pdd->sdma_filename);
 	}
-
-	return ret;
 }
 
 void kfd_procfs_del_queue(struct queue *q)
@@ -800,28 +771,16 @@ struct kfd_process *kfd_create_process(struct file *filep)
 			goto out;
 		}
 
-		process->attr_pasid.name = "pasid";
-		process->attr_pasid.mode = KFD_SYSFS_FILE_MODE;
-		sysfs_attr_init(&process->attr_pasid);
-		ret = sysfs_create_file(process->kobj, &process->attr_pasid);
-		if (ret)
-			pr_warn("Creating pasid for pid %d failed",
-					(int)process->lead_thread->pid);
+		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
+				      "pasid");
 
 		process->kobj_queues = kobject_create_and_add("queues",
 							process->kobj);
 		if (!process->kobj_queues)
 			pr_warn("Creating KFD proc/queues folder failed");
 
-		ret = kfd_procfs_add_sysfs_stats(process);
-		if (ret)
-			pr_warn("Creating sysfs stats dir for pid %d failed",
-				(int)process->lead_thread->pid);
-
-		ret = kfd_procfs_add_sysfs_files(process);
-		if (ret)
-			pr_warn("Creating sysfs usage file for pid %d failed",
-				(int)process->lead_thread->pid);
+		kfd_procfs_add_sysfs_stats(process);
+		kfd_procfs_add_sysfs_files(process);
 	}
 out:
 	if (!IS_ERR(process))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
