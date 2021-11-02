Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76106C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 02:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF1C60E73
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 02:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FF1C60E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0C76F8F4;
	Tue,  2 Nov 2021 02:41:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C2626F8F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 02:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsN0+vrap6xR6aTW0v7aVeIKTp7CmWOQYalEancMosHJTbWOBFLr1J5MSyqBYY8S91eW6+EgbYBhh0F0vPyMu6ZePFUYFCOT9aX8r2+gXdkEMtF4w70fDwxwD+2inMcNrn7V+17PZ4upFdoWBp4hwiHVVRJEPqO3EM4Mq37k0bKs79KRFNmnHpBG+1DVrA4xg/1XvMqRu6WWcePNdMfXjhDj0kIUDgok/DIJakLuZcyKWFn6745izprIIoRGF1JTVrK7/H05FwTzO3S4jfCZDdN9hqFlNVbOOjSu+AbD9jizZlEMCmqkU66iUGGCNzU1v2BNPCakfsBnCmWGqvz5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc4B0Cxtd7QYG1K8r/dHofUP4B7+gla7RzpnOxYiFbI=;
 b=AK3qFpKAepCa+AxFurkKVVTVgChDE3hhdseP+M5lCcWH8PTK6gqAdBa7eQX7S+4ttvlEB6yJAqdgJlkimN1/z/sN/cdKXsb1neAIzxdUjaaJ1c9jvJlkVXwc+pi9/ejKfJigRqou1HGBh0H5EpmgTRpieoEJQ6jDOMGLTmGzcDGz3XcWmVNCJlQTNwL4QqZRsbYIzahgsa8VWB5N1w+2tRQlxyK3vuQ4GRYBchlA5eEDCNMaXUwOYotDM4wW7xYru9HmxK2oAde02wZWLd+4Zmj2aqBf/LDwLQefNmBGXXHKntWdeJfRYknsECxulwQu4S9lvjowBgBcD6Gvqcfnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc4B0Cxtd7QYG1K8r/dHofUP4B7+gla7RzpnOxYiFbI=;
 b=S/THoFs86nPIkpeI26R4+qKm6AeXtjidINK6HRs5MBr+3KgsmjrHRKjK8aF9Gp6fvYuIxASSfexVyZIOa96JmQQ7Ltw7woFCsakjOl84kNRORoOEPIcoe4Jz7i+W5Ihr9NGrujCdiX6J9brIAugOvigsnwS7STJTkKUyBLgHYms=
Received: from DS7PR03CA0143.namprd03.prod.outlook.com (2603:10b6:5:3b4::28)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 02:40:52 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::9a) by DS7PR03CA0143.outlook.office365.com
 (2603:10b6:5:3b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 2 Nov 2021 02:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 02:40:52 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 21:40:51 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: avoid recursive lock in migrations back to RAM
Date: Mon, 1 Nov 2021 21:40:40 -0500
Message-ID: <20211102024040.11666-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f6159cb-46eb-47b6-24a7-08d99daa300e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497B207CC95083CBA2CDCD8FD8B9@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4quF3h9gCRvxB4hdqnH2hTjW7UNU402njVcnDeVV/LBVIpuyigyv8lUTZ5A4dSgiZjfVYidAOcD5ZS0VKilQ+TMhgk1uZFIwfU54ymEZVtYjMmzZAR4+kYgryeQYfpZRZ+/sBZ52IFrWV9EZAlgZKGItjf9Yf83A90tbXEl1PzPN38vCEJPZekDasp6cu4h+zm0vsJoG/jqsjWHzbMZPrj+aNJwgMH61meMiJNU7BQ3qEjKbV8aCFei5rvK7n90xDUY4q8hWJIDnI1+jtlf5tiuIeXBfoERdYaM74ZJGK9xVOfidTVxVScEi58dEEukHs+y4okxP6LgJVt97uuLWKrWtek6J5vA/TwfR6OHUGaiaLSNl+aah0I3y8r9JTkt0O1ZNtjxoZD2oLfkDf7Old0wdlV9r4jEr6TQ43WrfmfFts1gmm59LP0HirXzk9Zq/cIPR8iX/fXMiukkcz55qf7beRDfqa0YGaPpzdNv0GvS1JF+flSZdj9Q5ExtsbGpbMM+oj9Cuo9jDyAHBvR5YyjNaEj48ssJY88PpRveknVlaM2DT21CV28GDzwJFZ2RuGOApVUZKDICJdUI2vZLesBYcGbk2VEn+ZIGzJCYW2rFntsUM7hnX0XkcD1+D16hHHwsikRQlLR7O/Ms3NS8isF5aVL61wpt70AMn8p1kZ63rLJqv4/81PDAmP6mThSOBNt/0K//l6wqbxj4JitVNbsLo9gIzHnq1dGUiIsCVhVI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(1076003)(70586007)(82310400003)(8676002)(2906002)(6916009)(47076005)(6666004)(16526019)(186003)(81166007)(2616005)(5660300002)(83380400001)(508600001)(7696005)(86362001)(36756003)(26005)(36860700001)(356005)(44832011)(8936002)(426003)(316002)(4326008)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 02:40:52.5070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6159cb-46eb-47b6-24a7-08d99daa300e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]:
When we call hmm_range_fault to map memory after a migration, we don't
expect memory to be migrated again as a result of hmm_range_fault. The
driver ensures that all memory is in GPU-accessible locations so that
no migration should be needed. However, there is one corner case where
hmm_range_fault can unexpectedly cause a migration from DEVICE_PRIVATE
back to system memory due to a write-fault when a system memory page in
the same range was mapped read-only (e.g. COW). Ranges with individual
pages in different locations are usually the result of failed page
migrations (e.g. page lock contention). The unexpected migration back
to system memory causes a deadlock from recursive locking in our
driver.

[How]:
Creating a task reference new member under svm_range_list_init struct.
Setting this with "current" reference, right before the hmm_range_fault
is called. This member is checked against "current" reference at
svm_migrate_to_ram callback function. If equal, the migration will be
ignored.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bff40e8bca67..eb19f44ec86d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -936,6 +936,10 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		pr_debug("failed find process at fault address 0x%lx\n", addr);
 		return VM_FAULT_SIGBUS;
 	}
+	if (READ_ONCE(p->svms.faulting_task) == current) {
+		pr_debug("skipping ram migration\n");
+		return 0;
+	}
 	addr >>= PAGE_SHIFT;
 	pr_debug("CPU page fault svms 0x%p address 0x%lx\n", &p->svms, addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f88666bdf57c..7b41a58b1ade 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -858,6 +858,7 @@ struct svm_range_list {
 	atomic_t			evicted_ranges;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
+	struct task_struct 		*faulting_task;
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 939c863315ba..4031c2a67af4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1492,9 +1492,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		next = min(vma->vm_end, end);
 		npages = (next - addr) >> PAGE_SHIFT;
+		WRITE_ONCE(p->svms.faulting_task, current);
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       addr, npages, &hmm_range,
 					       readonly, true, owner);
+		WRITE_ONCE(p->svms.faulting_task, NULL);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
-- 
2.32.0

