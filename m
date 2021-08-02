Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B9C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 14:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B855C60F58
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 14:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B855C60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715806E156;
	Mon,  2 Aug 2021 14:56:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C486E156
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 14:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ahd8NkdT4o+BY+tYUTU9VQnrEB9IpwDUMV9kCCeOKyQaJrGGS81N+VOUla0rEQ7UM1M/3SIv+3PNuI/2pZ1RMf+ka0y5ZG57iYHgZbyaQEvXE6fiSQA7W20P065Hm3atp+5ZCzNkxOS5HLYGhrBhh3Jx1xKwyZoiRG36D6/xDnVeyK6ZNjIOaSwjTQVfBK8vD5/tcLBmKFMH4/OF7aQ3MCZimYEQZCCbrkcxn3ye6VmIvmR5VsaVYGLYjrkx3RxiA+R7D60U2jcBDKg2HnuiPBHld6yCgeWshknGaImWwDn7D971ZIwX23I2fvxfy0daMGiH7kJpZSDd2OlsarpwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3qf6pfVpS/1d55eu8eGuZ/Gkvhk8LYs+TTLrL01ZoQ=;
 b=jHtJ31Pw1X4qtsC5K4gskWfcq2uHaU01Opgou6NE/WlfsGEvXyL6AcBYm21q+tBHCycz2ku9UU6gqe5w/339QnHhFZnJKsqm2qk8a/ejU95Y1ABLqeC9GFsshEwwSo6KkfSKiCV19cFBkEBkX5RFTRCOsh4HTN2f2js0b5BPWiPuwrn8Bl0sYBu0PXD6Uhfy4if0fYYv8MuNBatq66nm5gYR4jiifhoruS83ymRSpYh2F1FzE82PxcELRzT7zJ5w4eviDYW5mx9Pmkr4qV0IoIXFx42pni1joUGIwscjKEi6NVL6AteVckm2NFT/ygTaZG64qZhaut68JZduUHJRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3qf6pfVpS/1d55eu8eGuZ/Gkvhk8LYs+TTLrL01ZoQ=;
 b=GxKQLpK95Fq6cA+iMCVqX14L0FXGhBI/rS/aoDmMpbOxW02qP5yJgsvDIM9/NXCqcPHNTDKqHMgEGJyKkjGuyxrCWUFUV7tT5MU5lLDiPzWWUtBJQR3obz+1XUWAhRlFE8smyeIuRigemR1fVJ1M3ICv3MSMXvD0MptT4d0/07w=
Received: from BN6PR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:405:4b::15) by DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 14:56:19 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::fb) by BN6PR1401CA0005.outlook.office365.com
 (2603:10b6:405:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Mon, 2 Aug 2021 14:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 14:56:19 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 09:56:18 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: support file backed SVM range
Date: Mon, 2 Aug 2021 10:56:06 -0400
Message-ID: <20210802145606.11888-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b688f6da-6ff3-48b7-df27-08d955c5af9e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5070F9373FE30DA82DCC045AE6EF9@DM4PR12MB5070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojc+2u9FdPVkGnIyfhuNrbGNV0owNsz2b+cf/rZgr+suQTSxvag6TLEVpj/MviEwF+3Ptmb/S0Arv2OYazh3aOzSl1IQhE46yrtljclxJqkuckI+7IZUuWSUVISbHDbFkYDhi63o9pPSWeOQaUqD17pNZji5ddtyave9eYyy6y3+yBcVHUCEXLrQGllR81s8LGpx998/ZrBiYvu5gfQRxmoK6d0M+G7TC8ExZ0rQy/bc3mw8gGMaTBQGDAJx/Op2SCtAsa2VMJ2QraMXzNdAfXgeeTpGOAoQWXJWJQe/33xu4NccA1xGHOXiN6QxUH9QCEd3HiQoWn1GWr2Zqv8WsVM9ZfG8IclEDrpJBW4ERbHqBQr/0SbFAZRtnHD7fSnoeln9kzXyPuPzH7R7GDacskRdTFI0m/GUgHIIWieqRhOm8CjkoOAjqb3jEmIGncg9twy9kHoTh+6V9YBKbBnwydBQSTz77T6xWcq4HZ0ezeRdhMxwxbERhkzZXMZXVRIYkwOBQf7yRxzyVOm9gs2SppcjzzGIom4KVHu+usZolxTh2d2z25S7nMuXE9pVXwie9693pVCizlTQa6uwsByA/pjgESicPB1Ui1sUQanT4fBiJN1ZwtZVkzGlQxASEvzb29oneMgnruWDPIQMWWYeNCGE94oeKMnhV86iLIEHbxvvS4Y8KbtWH7oTiNwMEWxOiq13s8dx5jGYE5csr4EmPPJodznVbaHg8fQ/jaVfRis=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(81166007)(86362001)(7696005)(26005)(2616005)(83380400001)(16526019)(186003)(36860700001)(8936002)(316002)(5660300002)(2906002)(8676002)(82740400003)(478600001)(336012)(356005)(82310400003)(4326008)(426003)(36756003)(70206006)(6916009)(70586007)(6666004)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 14:56:19.2538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b688f6da-6ff3-48b7-df27-08d955c5af9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
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

HMM migrate helper migrate_vma_pages do not migrate file backed pages to
replace it with device pages because the pages are used by file cache.
We can not migrate the file backed range to VRAM, otherwise CPU access
range will not trigger page fault to migrate updated data from VRAM back
to system memory.

For file backed range, don't prefetch migrate range to VRAM, always map
system pages to GPU and also use system pages to recover GPU retry
fault.

Add helper to check if range is file backed or anonymous mapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f811a3a24cd2..69237d2ab2ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2400,6 +2400,36 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 		WRITE_ONCE(pdd->faults, pdd->faults + 1);
 }
 
+/**
+ * svm_range_is_file_backed - decide if prange is file backed mmap
+ * @mm: the mm structure
+ * @prange: svm range structure
+ *
+ * Context: caller must hold mmap_read_lock
+ *
+ * Return:
+ * false if entire range is anonymous mapping
+ * true if entire or partial range is file backed, or invalid mapping address
+ */
+static bool
+svm_range_is_file_backed(struct mm_struct *mm, struct svm_range *prange)
+{
+	struct vm_area_struct *vma;
+	unsigned long start, end;
+
+	start = prange->start << PAGE_SHIFT;
+	end = (prange->last + 1) << PAGE_SHIFT;
+
+	do {
+		vma = find_vma(mm, start);
+		if (!vma || !vma_is_anonymous(vma))
+			return true;
+		start = min(end, vma->vm_end);
+	} while (start < end);
+
+	return false;
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint64_t addr)
@@ -2496,6 +2526,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		 svms, prange->start, prange->last, best_loc,
 		 prange->actual_loc);
 
+	/* for file backed range, use system memory pages for GPU mapping */
+	if (svm_range_is_file_backed(mm, prange))
+		goto out_validate_and_map;
+
 	if (prange->actual_loc != best_loc) {
 		if (best_loc) {
 			r = svm_migrate_to_vram(prange, best_loc, mm);
@@ -2520,6 +2554,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
+out_validate_and_map:
 	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
@@ -2850,6 +2885,11 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	int r = 0;
 
 	*migrated = false;
+
+	/* Don't migrate file backed range to VRAM */
+	if (svm_range_is_file_backed(mm, prange))
+		return 0;
+
 	best_loc = svm_range_best_prefetch_location(prange);
 
 	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
-- 
2.17.1

