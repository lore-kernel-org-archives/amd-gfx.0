Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3688C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 22:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8260010E2B6;
	Tue, 20 Sep 2022 22:08:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C8810E2B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 22:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt6NiFCOcgm4DHGAmvbuc6RgOBVX6L9S4bZCW7C7iirtERNdC0qGvU9E/P3B0az9A8g97zhVQjpOPi7WHAliAeauvdASVXXNj+F0sVaxYPvrI2a9sIi38kWkcxHPwX49qmpMncuuh4jChPR05evP+2ofVey+LEnS4rKNKr4LWz8FybwW3ltOXxkv5T2mhF3Qrax1BVCpeOT+A9En0DTiA8jZ9GK/GjEGM0KLC0MobmoW6K8rQgkdPdzNbvZiYH7BKm1N8EsnzwBH+fgTBfMDUv9nr5BP8LfFIpl4YfJKnYZRUsm43FFpLUI1azXNYeZ7ZqwNrNy+i+4I4se2IrhpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etHx/tCvbqEqL/0xyLOHPCG0vVRj7k6tt2H39iAlGpU=;
 b=RWTlBDAjsVskvKtY78z/jgF7OBau/CswQewvakXg9qTC3xm4vHYTSGOPUpXF2YBO5d/WF86wpkIM3AbJrNVvqyXFNZAeEZgJHPgAmaHIGRmn1m0R8W3BeXeWBcQZkQuVSf4b91q0WPx/wTn8SfYtNFUkimYMRnXj6qDpFXd0n1OFfnosGnlX1dXo/0HWu2eXVKNLTMeLPRr7YoALgYy+ZmKIlbxY6ViJ14UqM5futFivCxWjhzIJ8pHzzXwsKEVcgpEwggN9XN2SsgGjefk1VkqLV2k9NPnzi6V9bfxYKDA5DbxvkVikKHkvKLWucYGfqH6L05zh1sBCxy6s8odTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etHx/tCvbqEqL/0xyLOHPCG0vVRj7k6tt2H39iAlGpU=;
 b=iH2eP74H/oG7gOQPjB4f3CH9APAHQMvpEPCBRUeFXONkIEg5XfhiyN1EKdCJ3bTDQkxskk0ky1SWD9WqGGwx9E40v3oK0f193TpbeINUzLWNiURgxoYHQ0bBDDPb6EZQTPpD+Rbd5SisbvC3UyRnz708b52wRJqot1KWKrC5vtQ=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 22:07:59 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c4) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 22:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 22:07:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 17:07:56 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/1] drm/amdkfd: Track unified memory when switching xnack
 mode
Date: Tue, 20 Sep 2022 18:07:38 -0400
Message-ID: <20220920220738.5447-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb4c214-b5b0-41e6-57fc-08da9b5493f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmAQLIK7Kn1Lka64s/U7nPWSP2ANYZZbpJYFI6Xys74+j+GrjN+2CPOAd05anFNZkFq3nAEZxOhqmVtb1S6UyyBcqCUb7x/huaqArcOuNmAgf1SZsvhMGzv+2Eb0AhriUgFXSyaxLNTHlmT0rDKQtA9ukhZSLJZ2kQ733IR5CIPu4micFuPXq0We21PEpveYMvwVzQ0giFYbRvMS+wvLz/patFvF68IF4ezM8tvP3h4kAT/jm7tAgbaDjmSJrcJyQNPEyeOFghqQjxJ+ruot5GhsrgXKkAK9ril7Q4jcGPM8PXdXSkA0+2bIqZ1sqrndwRmTZcTHN2hM+qxIknbEsMFPmVNtC0VXWJWtchgIemQL83entsIjUt/VuyWHEHfEWrIZRgTPLPBAqyyVa6yIEvdTrJKa2W73bbwnUdCnWYsy0SezWBs5y7NjeG5QlmEibly+8hWieJT2FG2aLGWfnR+7NFL/jzgVfNubA3r+3qhbhTPJcQtD6IC+Ssz6YDmeiJhfOo7LrFjDizVeLnvm43hDIjq0V3pD0Ftpxa2J6sCkNpSlU40qOggJQE5toeqdmYMLVC8HMYKDagspNUEENZ0P1fEiqin9Hvzyo5FE2TSr1AFUCMMPwQgdeqITMg3EvUStFWFujHCDuEJU9OrLHCuIpNfTrVdGAU5zKxaGTdrtiKY3Q4qgn+9W+dzGpcZVeGZmFgCzdJ/vPjafjroZf1f9S5za1mBuhVx79ZPkl1MnH/3dp5yG4WJJZ8G7Dh8/DEUlqxRwFx/pM27euqWl4khSQj3RNuiCzkGsLyUqeFGLw1wXx71F4QeLCeT8hXvh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(70586007)(40480700001)(81166007)(70206006)(8676002)(4326008)(316002)(356005)(6916009)(54906003)(5660300002)(2906002)(86362001)(8936002)(186003)(83380400001)(36860700001)(1076003)(16526019)(426003)(36756003)(26005)(2616005)(336012)(47076005)(82740400003)(478600001)(7696005)(40460700003)(82310400005)(41300700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 22:07:58.6621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb4c214-b5b0-41e6-57fc-08da9b5493f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
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
system memory. When switching xnack mode from off to on, subsequent
free ranges allocated with xnack off will not unreserve memory when
xnack is on, cause memory accounting unbalanced.

When switching xnack mode from on to off, need reserve already allocated
svm range memory because subsequent free ranges will unreserve memory
with xnack off.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 23 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 56f7307c21d2..116dec5bb318 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1594,16 +1594,29 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 	if (args->xnack_enabled >= 0) {
 		if (!list_empty(&p->pqm.queues)) {
 			pr_debug("Process has user queues running\n");
-			mutex_unlock(&p->mutex);
-			return -EBUSY;
+			r = -EBUSY;
+			goto out_unlock;
 		}
-		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
+
+		if (p->xnack_enabled == args->xnack_enabled)
+			goto out_unlock;
+
+		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
 			r = -EPERM;
-		else
-			p->xnack_enabled = args->xnack_enabled;
+			goto out_unlock;
+		}
+
+		p->xnack_enabled = args->xnack_enabled;
+
+		/* Switching to XNACK on/off, unreserve/reserve memory of all
+		 * svm ranges.
+		 */
+		svm_range_list_unreserve_mem(p, p->xnack_enabled);
 	} else {
 		args->xnack_enabled = p->xnack_enabled;
 	}
+
+out_unlock:
 	mutex_unlock(&p->mutex);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf5b4005534c..010a9408a127 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2956,6 +2956,26 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	return r;
 }
 
+void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve)
+{
+	struct svm_range *prange;
+	uint64_t size;
+
+	mutex_lock(&p->svms.lock);
+	list_for_each_entry(prange, &p->svms.list, list) {
+		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+		pr_debug("svms 0x%p %s range size 0x%llx\n", &p->svms,
+			 unreserve ? "unreserve" : "reserve", size);
+		if (unreserve)
+			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+		else
+			amdgpu_amdkfd_reserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
+	mutex_unlock(&p->svms.lock);
+}
+
 void svm_range_list_fini(struct kfd_process *p)
 {
 	struct svm_range *prange;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 012c53729516..05a2135cd56e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,10 +203,12 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
 void svm_range_set_max_pages(struct amdgpu_device *adev);
+void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve);
 
 #else
 
 struct kfd_process;
+void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve) { }
 
 static inline int svm_range_list_init(struct kfd_process *p)
 {
-- 
2.35.1

