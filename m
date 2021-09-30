Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB9AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 15:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9304861440
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 15:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9304861440
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8CF6EB97;
	Thu, 30 Sep 2021 15:53:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706F46EB97
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 15:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjLc8LmRUpdmDomnxYD3uatijhkGPSVFbkgITrHb6+jhtt+kxlrCw80pZ7Dn4xL9jzDqHsDOYTb9Knar64Nza5WTwt34FyWLvxutUOvtB8f0WdzexfcVLvEnVmV3+yrGugRGG08gymIB5Aga6NKHSpfntHPjy9t3brfD3G0NUYJATZRS8OlkEx7mh5tzGhcDrsgUkQ/JCSNo3gtBLEpwlUrrOPPTs/O2bfHTFI5cFVK4KuOZ0VG131RKun8mLShfr0/JgkUeDyTNem9BrkUeG19DxcYWeYY9n6WkIPdgd/FdfyFofxZD3q3+HJi+1OlogRYGfCiUI4eSuptWLrj4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8OXrnlD2sL6wN1akbihgJgJtk3zwKnkna/HyWE78wPM=;
 b=X/E53sj91uyYWFUvFKyTT+U0NC9AXr9WLFbNZtv8IUngn4PmA7iYgx1fhyyh1PPSH48mPQ3XmQnojL+aU5ROviCxQXJ1tG7dP5SJ1miQRg7ZfEGNAiLsvLjS9rsJ+al555KnpzrWrKi8MWb5XmzoT0P7621rZ6hJqdZ70SvGEZPfi/iIZq5q3oCPQfMp+s2CexZIAWc+aAOXh2ZHj+/H2sLZr6T7DbJedme70nMiijGodo+lSJj3Erp+wZRG8RapbmLpgEfmpfeQHPdlr+foGW+8u/tJTT3p4gEEclozczKn2nhdAHagUSJXLs2iOUcO7xX/VOZQPEFrgofAGGV0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OXrnlD2sL6wN1akbihgJgJtk3zwKnkna/HyWE78wPM=;
 b=HqauTiBv68vw+j8ud5rD36TXioBg1Cmz4nJ0hV+PyR1aB/5a663GzgbIX4VDw5DcT6jBgOl/NoiU1tfPokQr8jQ+Kf67+L0UipzyQyEMRqCZie4hl51YZb0IjJtCrf4Et4n6t0n4uPa1EAfAR2QnUTgA76ZQcCH9JkSGdH2cPqM=
Received: from MW4PR04CA0192.namprd04.prod.outlook.com (2603:10b6:303:86::17)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 15:53:27 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::93) by MW4PR04CA0192.outlook.office365.com
 (2603:10b6:303:86::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 15:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 15:53:26 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 10:53:25 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH] amd/amdkfd: remove svms declaration to avoid werror
Date: Thu, 30 Sep 2021 10:53:09 -0500
Message-ID: <20210930155309.4707-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87cad47a-c396-4520-036a-08d9842a7108
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-Microsoft-Antispam-PRVS: <BY5PR12MB40828B543248C4D211A7A0D8FDAA9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcyR7HXRzG5oxYzPjblB3NHNcnHiu5jSa+uJG9eLKfdjvvLCBjCrBnnI1s9ZB8zTkT7UKmolNklYyjSC5mlBJcMp2fI0js29X5HrK54csAIwbDtER78oSECWbB1DqjAJ+WjZh61OnXLlYkbg1BxHjaAcI4PdVB/PlZWyeJq8KoNfptUoQXtj7GDgM3lukgSPUsX6HRBvmJ/Zs4Cc7AmwHcYFSl6BnwlsVEF/TnNn6S3+pd0NziA4RMvNw6I6oZtUsMUq3DhNRUNBKjvqjIN7KqumZQ1iUiE6i6+EgMp487nd1dLiiRZRyE5/hvDN4ZhkxVWYsojXXJadehDTEgEcuvjLu+kyWc83EOEqnJOCtgmbr6iYft/kO0Gn36PW7rtUPT2d+QqFFWhE/UX8jIPTYQ+6A8AtbEtiSRx6ebWELxRfdwNLIrHyadd50xUAY/5KbryugSHwNLgEkGVV4jG/66dzS5DDT7DqABRxuJ4iH33T4yAAwIHkVCuuQeZMLaBhNd9xgD7kR63Jp/oB5Hm41kwK8+0zAFVO8sj5jTnLEB0eiPK7SKwBmyjTQZ/1C/uA+v5TLhb/oHR800SOnTrk0KbipdQWvkQ5ZcVJis4jpxLyHs9KO9OwSfkbH3vEtsLDlatNraNmRL72dtEO+4spIuqf/6scjX7EfPgu18BsK8z5KA01Z8dV056CoVK2RAzLTSW9vC0mR9PvChWvFKtWQ+OkTBIMpu9r8xG9qTEWJ88=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(44832011)(36860700001)(6916009)(8936002)(4326008)(7696005)(508600001)(186003)(2906002)(6666004)(16526019)(8676002)(36756003)(47076005)(82310400003)(5660300002)(70586007)(86362001)(81166007)(26005)(83380400001)(2616005)(356005)(70206006)(1076003)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 15:53:26.7950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cad47a-c396-4520-036a-08d9842a7108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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

svm_range_list svms declaration removed to avoid werror when
CONFIG_HSA_AMD_SVM is not enabled.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 4de907f3e66a..f1e7edeb4e6b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1251,7 +1251,6 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	struct kfd_process_device *pdd;
 	void *mem;
 	struct kfd_dev *dev;
-	struct svm_range_list *svms = &p->svms;
 	int idr_handle;
 	long err;
 	uint64_t offset = args->mmap_offset;
@@ -1264,18 +1263,18 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
 	 */
-	svm_range_list_lock_and_flush_work(svms, current->mm);
-	mutex_lock(&svms->lock);
+	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
+	mutex_lock(&p->svms.lock);
 	mmap_write_unlock(current->mm);
-	if (interval_tree_iter_first(&svms->objects,
+	if (interval_tree_iter_first(&p->svms.objects,
 				     args->va_addr >> PAGE_SHIFT,
 				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
 		pr_err("Address: 0x%llx already allocated by SVM\n",
 			args->va_addr);
-		mutex_unlock(&svms->lock);
+		mutex_unlock(&p->svms.lock);
 		return -EADDRINUSE;
 	}
-	mutex_unlock(&svms->lock);
+	mutex_unlock(&p->svms.lock);
 #endif
 	dev = kfd_device_by_id(args->gpu_id);
 	if (!dev)
-- 
2.32.0

