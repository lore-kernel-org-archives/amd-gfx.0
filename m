Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2331DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 22:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE85560F56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 22:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE85560F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DFD6E296;
	Mon,  1 Nov 2021 22:04:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC276E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 22:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg12lWnUPKeEbBJf3zVNJyztww9AD/lTNdluy6NvaaHmsF+gNi2JlDH2ptnmhX1MdbyU/fjFwwx/Pp9JSVLDrqrBPV887eKAJi2SicpP/gfzZC6quGeEvxgxhi9peEu/3FPF9uL89ExFcyn4R4kHSXx6SYmBDgzCb+Hf5EKYMYrVXHDf1WIH6sLv5bBH3vQkS2RNFOmzNBHfUAAY8uPaelibrhoH4Zrf9K1yu+lO9avkMq/cTslirNIPqpj5C/zYp9YI4ssEjYW50pEhQmXp1B7tzOG5mlbSACbKl0iuM87NqW+4tsuk4DBb8LUlkUeTC8T56lZF/k+FW46lGuTzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+gBIOK0JQP+ShpC9rH/sglmpmrF0dazbiTM+EJHqbM=;
 b=bqEap5jZ9SvUN4VfhmnCfSLHSBboAHRoG/YjyDV8oJ/q4uBu0O20oUEeExa8UN87bsa/sXYBBjwBJyyL4rMmk2IDmk1dvmtYpSwZZ2TzQExsrkEoUFkks2pSFjFdRH+3U8U9RSRMHaO+uUsvtJ5DXm6cIdI5jDGGUsrAZ7l3P2BnvgDYGTezzJtYg5a3BW3pkm6BrKM2HawfYKd7e0tNCDXBoriFrnhcHuC4H00Ad0ZCRsEtfdLfcRk/LkYqQ5zYQFnRp/aoV4H3rjfox4QuCZYhz2cdYRXSD8DDyiSlcTCzSg/rm7xKbfnkkU6LlhHdUcsHOm+eeLLIkDl4TO0UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+gBIOK0JQP+ShpC9rH/sglmpmrF0dazbiTM+EJHqbM=;
 b=P30/otyiHb55BgGaOFWPiNFnXiI4g2PDp2X4QShYmu1JVBimBGebWbT99BBPY88yHgBb9NXhkVr0bRiQxadELpCOajyLtXpV1oKJHVd7LZONMNs4zPgDPk/w3JvXxwB+aHo4ONtCtTLbwwCqT3RsGqmgxIvZ7kWYQ0UBKusyoYo=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 22:04:50 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::35) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Mon, 1 Nov 2021 22:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 22:04:49 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 17:04:47 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: avoid recursive lock in migrations back to RAM
Date: Mon, 1 Nov 2021 17:04:35 -0500
Message-ID: <20211101220435.9757-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01eeec9b-8d5a-4405-b9e3-08d99d839fac
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42699ECA3592764549F03137FD8A9@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PksizAfz/C8CkigQyWt6n45sQvl0JwmReJp1xuMLaJV9j3TAJrORNV1xmHxGOS1C5Z20reIujG6OIvRwUrTrKVo5p8MEoSl7YzR1udyZi4CmpcHKKsIVoLbOPidrnHlaCw8uLx/HcBkbBv6dw3BEA8XJ3KHunpkFp9imoSAtdetFljqP/Xfi/NNxSDfoYffWKmZwfBZswX2UBLzbzKiNBrT2iHzcDn8X4zWhEWnptBsfnAAirodWtJA+arkAmKVAexrVFJmPXm6RAeTKulxFrAgf/0oExJoazoTCdmTXFfvrjOBTEdyPdtAdBt3PkvZplm2fisd0i16WPEGq39fJM7DNg4T9zW0U9b1zoW0bBLDGiB5NGxcRrFN5B8PcUgekiUnVNyj2hzmL0DGdqapASqgS1/nBglZBI9Tu1zYa+UmXKPLxCQxjlUSi7/nuncKnNVYkcXLAkSik6Jcr+n0mPpheFxv/1AdyRNOYBhU4YaAuKG8Z4BRt9rveBLVXHvTAEnzHEEl09rcrRklBQOEFsIaO+UG/0bQJxxTSwtPraIe8b0NrhXrrkP74OoMAwU3iWc9oo7XJtjQr0+XPaUleNvRUeQBqtYoAgbkYLUifRVqiUypnECcy+87hJosi1Ixm1KINQ+DPOzuTBWCRUB5TDg1Z+y8YHJG/KBatJpIV758+gqMsZ4Kra+B7uWNXz2JKEbOz8n4xY41PxKIZu1Rc6m+eWCCQY5uNfBWpmZGkozk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(86362001)(426003)(6916009)(316002)(82310400003)(7696005)(508600001)(36860700001)(6666004)(8676002)(4326008)(356005)(36756003)(83380400001)(16526019)(44832011)(186003)(26005)(70586007)(5660300002)(2616005)(8936002)(1076003)(70206006)(2906002)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 22:04:49.3250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eeec9b-8d5a-4405-b9e3-08d99d839fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
During hmm_range_fault validation calls on VRAM migrations, there could
be cases where some pages within the range could be marked as Read Only
(COW) triggering a migration back to RAM. In this case, the migration to
RAM will try to grab mutexes that have been held already before the
hmm_range_fault call. Causing a recursive lock.

[How]:
Creating a task reference new member under prange struct. And setting
this with "current" reference, right before the hmm_range_fault is
called. This member is checked against "current" reference at
svm_migrate_to_ram callback function. If equal, the migration will be
ignored.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 3 +++
 3 files changed, 8 insertions(+)

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
index 939c863315ba..e9eeee2e571c 100644
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
@@ -2745,6 +2747,7 @@ int svm_range_list_init(struct kfd_process *p)
 	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&svms->deferred_range_list);
 	spin_lock_init(&svms->deferred_list_lock);
+	svms->faulting_task = NULL;
 
 	for (i = 0; i < p->n_pdds; i++)
 		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev))
-- 
2.32.0

