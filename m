Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC53CCA47B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 01:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5D48E53B;
	Tue, 12 Jul 2022 01:56:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95658E521
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 01:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSva1QFXjjhl2iydxveHDigk7J8uWpIpgUFPoPjY4InHQdwdqBeZOdOz3fpwW0sIjSwoGIML0vIbQhfWGt9MQvy0fuEC8Ha8wsoMDRoPU3ScKrqzpaeBbV3SIrHkLTkfRbE5UP8Hm1GzADSiYdtpPzqd3Kcy6mYspHKtCyAVDxKWvBaPu6mvAU/aF0R5jL+76rhO+NqRD7B/Si85yy3poHYH9S3lgFLfnRO/Da/4ELy9S74Tn1WyY7+Zh74BJSyOdaZBhDlp5J3vElEszkY8kziHiscfsEEzfXyfnEkGsI4SYZ7xwuUxkAeZYj4289DUCE27bvMAIKfVX2c04oBX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85guG2FwBEWesFz3et/uNPNvMtQWTpqLNenAFfkzCSE=;
 b=LsDKKZHTA4LVWTUEC3bfomjr7ILQe/6hRuLvjmI0NAmf6rH6Olh1/c3wkIgjhguyoHAHB0reShXSkErMCE87OQDHZCa+1tUADykw03wo3/lL7066CC0HX/0hpg0TPmX7/HHYI0hiMuyyERZzRQjMFwZ2DwwCU0H9sOY49+38H7hQHxyyBnTWukp0i9sLXp9lG75Otqa5R1k44JsBCwbcJ9GNBbSFsC0B8cfjBUOdANvXKliEa5cvAOJAxM1QtLnedf+wuD4LDoKG2pECOmnd67r7kUSL7Ur+qZdXaPMajfF+xvl3NSVA8aVr4x9UL3yMLpDbD5BfeNZgKx4rv7NPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85guG2FwBEWesFz3et/uNPNvMtQWTpqLNenAFfkzCSE=;
 b=rrshvBipV+7+Oo92tw74D1CjkNvJRFzvIQfVwn9qoE49gektJO6WpuLnQAVMO4tOoS/9GkzjAb/VqhJrm/XEKcM9+7wMHizgLDztD4mvww149quJkeO4wIeCwHTmhx4gQYpuebbUdgIvDgQ+cNY1nghP5Rd6M6HQtGxSthNxKJo=
Received: from BN8PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:d4::29)
 by BL0PR12MB5524.namprd12.prod.outlook.com (2603:10b6:208:1cd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 01:56:19 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::89) by BN8PR04CA0055.outlook.office365.com
 (2603:10b6:408:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Tue, 12 Jul 2022 01:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 01:56:19 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 20:56:18 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add debugfs for kfd system and ttm mem used
Date: Mon, 11 Jul 2022 20:56:04 -0500
Message-ID: <20220712015604.7697-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220712015604.7697-1-alex.sierra@amd.com>
References: <20220712015604.7697-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e38a21a-2537-45d9-78d3-08da63a9b6da
X-MS-TrafficTypeDiagnostic: BL0PR12MB5524:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0W6dN9F5ps639rW9yjyRL1RnmBxmwakP1CWhBGU/AvnOP4mZT7ZaHoNzKDC6yEgPdnEqoXCHU8ajQa/+Wa93gTJbiSpR7DY0cWPBMdoWgb0tLEKxxedueQPtIVA14yp9dxn7oSczy3ieLUQM0G2amoNYKhrD1A9q89M1Y55OdDvWRisKlfMCeijhuFsvERSppbUShyZqe4OrJUq1SJ3qPfpH7tqxU0/zJfWq+uBZcpiilBZgYmviKyzBhp05AdLK7gtvT7vIYImwk8xacaPWQmwGJNn7zTPgkpIp6/7LfjJGFFPKaiHnfxbTe4fN3oA8lB8zWB9AKozQ83+RHmMtpg2NyYdLn/3nQRLxjLIDGhe0v0Q26HaR00vw48OiOqBGQ0j0itMGC50G+vvxNNmi5yinmd/CG9bSIXH136DOp5A+Bh5ZhiMtsk/eMEqmdkwg+HTnMlNAmNUiK1BO23C0LPDKhSmKLX7LJvd+Soh0ZYXh01N+DeOeHseVcDIjUbSHlhTuVtqgAybbFHNixLAGz1YZNvDrQz5QtEdLwEJjoYkic1mJsK1MOk6mnBpEy1g19oFnuGgqzeZ+ZWGAHtc3yg7Wg6cuimExdrRQfmpRXGxt9yOWMw7yedxZa7BmNanMypQk2wWYasyhn5T7XRoFA5PGeayVg5rof230vxosannTrH+2fNnmicRIkM17yFRY173lbH1b1h4yEXiDIU3JsVk+g8x8dDr32zzcALDWC1oTlZN4406FhzPN5yUNuwKmMaqTeIq2RWnhuJ9ZZhcnHQNHfYQQOhy1FG0DjqoQSV0IQZWUR9kwGdoo0M3Y3VdBGNZgJxwSb3w8gSlp1y8zsRG0KhnYGZe9aVlqPobE6nM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(81166007)(2616005)(36860700001)(40460700003)(8676002)(1076003)(356005)(70586007)(83380400001)(70206006)(336012)(16526019)(4326008)(8936002)(5660300002)(47076005)(44832011)(82740400003)(186003)(86362001)(426003)(36756003)(26005)(2906002)(40480700001)(41300700001)(6666004)(82310400005)(316002)(7696005)(6916009)(54906003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 01:56:19.4115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e38a21a-2537-45d9-78d3-08da63a9b6da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5524
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This keeps track of kfd system mem used and kfd ttm mem used.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 83d955f0c52f..3c09dcc0986e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -172,6 +172,9 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
 				struct svm_range_bo *svm_bo);
+#if defined(CONFIG_DEBUG_FS)
+int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
+#endif
 #if IS_ENABLED(CONFIG_HSA_AMD)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7480e7333e5d..8946e80fecfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2920,3 +2920,22 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 	}
 	return false;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+
+int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data)
+{
+
+	spin_lock(&kfd_mem_limit.mem_limit_lock);
+	seq_printf(m, "System mem used %lldM out of %lluM\n",
+		  (kfd_mem_limit.system_mem_used >> 20),
+		  (kfd_mem_limit.max_system_mem_limit >> 20));
+	seq_printf(m, "TTM mem used %lldM out of %lluM\n",
+		  (kfd_mem_limit.ttm_mem_used >> 20),
+		  (kfd_mem_limit.max_ttm_mem_limit >> 20));
+	spin_unlock(&kfd_mem_limit.mem_limit_lock);
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 581c3a30fee1..ad5a40a685ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -101,6 +101,8 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
 			    kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hws_fops);
+	debugfs_create_file("mem_limit", S_IFREG | 0200, debugfs_root,
+			    kfd_debugfs_kfd_mem_limits, &kfd_debugfs_fops);
 }
 
 void kfd_debugfs_fini(void)
-- 
2.32.0

