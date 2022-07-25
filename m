Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B0DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 17:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07748C11E2;
	Mon, 25 Jul 2022 17:20:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA321C11E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 17:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/XsxFVef7kus2T01w3QMNlmUOpbtaiwLvXff0EBkw76GksLvWugvOwy5j7B5K8B3NvCXrA+hzuWHP7TrXt57Od6Yyef8rq5FF6mimVs0hr+C+9BlXGPHTEQgkFGop4iKDTNVDC8dur8INlfpkJNRBQF52qXFL4G+fv4Mv5ekKKbpbyPVVAgn1CsrGUaaHqj8xlBFjRZHUyRWZxRTIdtFYMfWDKrADbqKwLujupo8DdSfkPl/IRmC42MhSjMCxaZB+1zeaW3kZNXe5kyTCC5USnBBcOd0cBvNx2wnklVyaQgwkqu4H7g+Cc4jKNz2PT0DJ6i8vjECtu4kDbNjkW0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wEqo6GtIZUShUpo3yuN9IdotCDv72e5PTEUzWF8t2s=;
 b=Bc7UBv7705qu7OtconE55jBeSUkbCX9H9Mo4cDu8StEbLzHAXJIL2F6aNRcRoO0bwjPujFF7R9oyiDR62Wv42yY9Sf17OWMzC6l3cdHwMQ0V9DMjs15FGMBuhpPtIDe8BPBD49QM+3GFKczpaLcrKoOBvQvQKtBkuwDL31NKdU6KfHiivtIln5aduxItMI5UvVw2/puxBPnY6o0hp6MPkuFn4N2g/LbDkmOBl2/+XH5/gZRn2aGFZRotKuMki9HTB1Y0p9wmyc7GJ5MwoLUW49jg3LMzE2j81UaFz9KfVrrdEC+d4kj4a502HVpWGNMKltMHAdi6OaNgQyfBfShrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wEqo6GtIZUShUpo3yuN9IdotCDv72e5PTEUzWF8t2s=;
 b=OeSMBsOURodQ1ZZgjRS/3k2TBHLxpUtv+ywBb4T1ffiamugLnwMPUwZE32EHmLw/oyGAtay1prtPobeez1nsJhZgqT1hqDnlOJC58ZAxJ46jX+CvyUVvR0wUV94sO8rXj3jLN7Qn/jCF4sX3kGmHylzAND63kX8bSLpoZBMvq34=
Received: from BN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:408:ee::8)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 17:20:13 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::c2) by BN0PR04CA0003.outlook.office365.com
 (2603:10b6:408:ee::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Mon, 25 Jul 2022 17:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 17:20:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 12:20:10 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdkfd: Set svm range max pages
Date: Mon, 25 Jul 2022 13:19:42 -0400
Message-ID: <20220725171943.9155-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725171943.9155-1-Philip.Yang@amd.com>
References: <20220725171943.9155-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11729179-0e5c-47ef-2027-08da6e61ef6d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43Dc0SA/fIPxq+w0Vp64QF1I9X//oymRYZRa7Cu4UVqPjPiITTGFgAiXsFnsFRtBwsOHaP6RrA+Ztacx1tXLXKdvs6sxlh9FLVSr+oUd/YM+X3YhTphFFnC3LHv6OrrwHSylxF+u0ntofB8+vU6NIxin2FxO0v1HbFbybOqBcG3T+3EW30SpZqcK1QIuhC6IvP5pDk/nJ+s/Nu37ywVhTdRdbGHPBNz+zN8HSZl3bcYZ4Ch3bBW1Vu8gzTEtkR4DJLzbt8gSzTOmFvWVtTZYbOgsKLlyHXe68xFBa4d9aJtyhazWE2wdwbAUU7zNHHX6z8LoMDnsfZhehY6IDi4l2rqXVLATnYVloQe03XRq0iWqIX+RbkHXvnDBPVNGFBcaAmIF/b7wLbJjehiZ8EmGt445N+6UwAVDBrxbtxMeqyQt+95vMXlf6Wv6Cx78Fnbf4LkQzMc7nuoSBvWm2iEeXV0ewE5Cl972dWdFolgpfTpdVbB4EEAkMSXYz9s8UMbKDgnnfqn+0p4mjO80rDKvzrxZdZWzHS1B+1w9pKyeQWmOnkwdOtfOAoo/010b9OPIILfdjjnie3NkRuB4NF+CedwLxUwFnfJKH14ivkl4Y7NZUokwNQnjsop+vhZCC7EyP5y10O6Hzqim9ygLNRAx0E4K5VQbIlh6dTiR1GIRvBgTbm01dHf0bD9lwA8zyZWE2wSrJnMr7lg1pIb+B8Ob+2FcEJD2s2wf1NA1sWYnxNfsgR2rqDiw3KGHk9ZkNhMgS1DkeeRfntknXLu4yOkoDnFcozCDdgdVKvoMYPMeLHQNz9OP01tEX+ZQ6ri34bxbj8EdE41ovIkzdJ6TLk+LbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(40470700004)(46966006)(36840700001)(478600001)(41300700001)(6666004)(2616005)(5660300002)(86362001)(2906002)(26005)(83380400001)(8936002)(16526019)(1076003)(186003)(7696005)(40460700003)(336012)(426003)(47076005)(6916009)(54906003)(356005)(36756003)(82310400005)(316002)(70206006)(40480700001)(81166007)(70586007)(82740400003)(4326008)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 17:20:13.3354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11729179-0e5c-47ef-2027-08da6e61ef6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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

This will be used to split giant svm range into smaller ranges, to
support VRAM overcommitment by giant range and improve GPU retry fault
recover on giant range.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 9667015a6cbc..b1f87aa6138b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1019,6 +1019,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
 
+	svm_range_set_max_pages(adev);
+
 	pr_info("HMM registered %ldMB device memory\n", size >> 20);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b592aee6d9d6..098060147de6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -46,6 +46,11 @@
  */
 #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
 
+/* Giant svm range split into smaller ranges based on this, it is decided using
+ * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and align to 2MB.
+ */
+uint64_t max_svm_range_pages;
+
 struct criu_svm_metadata {
 	struct list_head list;
 	struct kfd_criu_svm_range_priv_data data;
@@ -1870,6 +1875,20 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	return new;
 }
 
+void svm_range_set_max_pages(struct amdgpu_device *adev)
+{
+	uint64_t max_pages;
+	uint64_t pages;
+
+	/* 1/32 VRAM size in pages */
+	pages = adev->gmc.real_vram_size >> 17;
+	pages = clamp(pages, 1ULL << 9, 1ULL << 18);
+	max_pages = READ_ONCE(max_svm_range_pages);
+	max_pages = min_not_zero(max_pages, pages);
+	max_pages = ALIGN(max_pages, 1ULL << 9);
+	WRITE_ONCE(max_svm_range_pages, max_pages);
+}
+
 /**
  * svm_range_add - add svm range and handle overlap
  * @p: the range add to this process svms
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index eab7f6d3b13c..9156b041ef17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -204,6 +204,9 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
+
+void svm_range_set_max_pages(struct amdgpu_device *adev);
+
 #else
 
 struct kfd_process;
-- 
2.35.1

