Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1813C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 21:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BCF78F738;
	Mon, 25 Jul 2022 21:18:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB208F738
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 21:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSH9SO9lo3PfaQr2VY/FzqT0gtebpoeJAwxxvQHnP5dordHwbXWtyVJmoQA8dBWcgaY2RW2V8thk+W+8ShucbqZaopLgiokfeQ9oXuKeWHsjxT9iTcoPaH9e6IFF9VS0bRnyTs60iNHTrlVgCZ7Zdn+h6cqTJquERwxNQTWM3UE20HE3DRfc5jGvcPzKJRjd4NTwXapl3mj0UagYrC6c6SIhsBH7olS8wph5Tm6wHuZfthdvxoLBNiLKqRO6xDlAOMwZGK7Y9wCBa/ru2udLD3/sJqOfUiz4ps0GLic8f5rkp0f/ubfij5Co/YwsgXohmKK16XE5ju123/VIGwOVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZMW6U7DUZrg2D9OXa/DJx/jSLXesdZB9ht4KKbcNH0=;
 b=PjE7BTTrQkkZitjgYzRycWEg2dEmJZ/vliFNVXcpQbnXPWkpX5szskAMZsP774iG0vB/VfI5n1G8bLSdywzEuxhAQuKA+RrFRcn19sfWi9XAExNCGJBY80fXIVaecc/F5vtirJRrfbGHdAoWww8ZcBwgsmRCUlzOC+agYsQMod64ui/k2KjQyvhhDTWb/xWh+eeAhJf4FRWwVr+dVHbkmzJifWF07xzpinsk05ZdWRJ5asfeQOfyH7Cr3CQGfPH1ri5wgyL5ESQXkSnzQKKjZRTdFWMWfPYr0YL7X+5bxT5ttGM0fZ14V63g7Z82ePsk5b07OR3LSbO6SILLQhpDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZMW6U7DUZrg2D9OXa/DJx/jSLXesdZB9ht4KKbcNH0=;
 b=QcJ19RXYcvc4y0aWPvt+lQ41ZB87w1hHv2F/MLSQPLkgYUiDYpEgEnQz6s5E2FMNgIh6H+qRnxhUEgmoTZl9Ja+Ss0Mp/lP4CN14N3ABiP7VbmF9z3DCtSEO3luyyi6Om5WLVBnz6f5sshu5xHwFzno8xkdOAePXKanLKguZA/o=
Received: from BN8PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:d4::20)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 21:18:18 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::bb) by BN8PR04CA0046.outlook.office365.com
 (2603:10b6:408:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Mon, 25 Jul 2022 21:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 21:18:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 16:18:16 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amdkfd: Set svm range max pages
Date: Mon, 25 Jul 2022 17:17:42 -0400
Message-ID: <20220725211743.5937-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c565aa0c-028a-45e0-4354-08da6e833186
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAjm5WQDQEQyeO7acGjjVVlGvkU4r4H6ZKOiSItQivcsWNYqFRSL0WQRjwNgN05yYN80h0075MR+DNcRFI6JBChkfVx0RZfVFdVHhNjsAnjgi4PPEk/7fH8iDdMgr09mpSw3Ty4Q2V4uorrR4JLGZy6O4tJRL8Lm0V3Yv/K7/HQIKfJdh4gbxqRIX0qa8NFJN/zUMz5JIbiebrA+h+stsehOE5arVo0G+dLxc+hE1yMYVvOxl485LTLOm9NlvUfgGrTIXi5culROOM8FRCu/epmcidd3NLIkNnmPnEii+VbE3nyfX505xo6e6TTe0hZ6OZMItQxKrcC7BhQHRlwt0WUopWgWyi+rmZO6Vnon9PLRKD1XJzRnlLMJ/cXFlm+lR9NzWJ6dTUSrCNEZE/TQ9siq3KOMy0IoqO4qTSIAQGO366J7ns/H/66vcWxTp7bhMp+2eBLdLGXxLEUsqCqCjahOcC5vcoT7zWW51d7j6qiY9IPp2Yftz2OhNIZh3c9kwRP1iEYx+QmqFBHypRbsLJ3EuNOjbq5Yb3dFim0+KKXYkwUBUCGOo5No6rVtR4ANEGxck8V0IDABDa5aJj97sujCN5DMGj5CCxxkfZKbNdjaKFBgwAHJIsPPK7sdOLk87xYkhWFZCS3RrQoYvExp8OEgcTCDxUb4ky/00PYtegNRnZ3dLdz8Kx8qeP/G0QL512E64KIoEyJ0GX8VXuW/D7AZ2DBez9FfDLWNpTonS20SrSMry/Gj4v6Z7bQypMwhcWhFBYArc3Kz66T0MG+pNk1BPdVkQRkCBVGE7kAjcYDCrIThuB1fpU0Zlm+7FoPdrOy4RHmnqzgoMSpPXGxwWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(54906003)(316002)(478600001)(6916009)(6666004)(41300700001)(40460700003)(2906002)(5660300002)(26005)(4326008)(70206006)(8676002)(40480700001)(70586007)(8936002)(86362001)(36860700001)(82310400005)(356005)(82740400003)(186003)(426003)(47076005)(81166007)(36756003)(336012)(1076003)(7696005)(2616005)(83380400001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 21:18:17.6062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c565aa0c-028a-45e0-4354-08da6e833186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
 3 files changed, 26 insertions(+)

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
index b592aee6d9d6..9d855890658e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -46,6 +46,12 @@
  */
 #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
 
+/* Giant svm range split into smaller ranges based on this, it is decided using
+ * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and alignment to
+ * power of 2MB.
+ */
+uint64_t max_svm_range_pages;
+
 struct criu_svm_metadata {
 	struct list_head list;
 	struct kfd_criu_svm_range_priv_data data;
@@ -1870,6 +1876,21 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	return new;
 }
 
+void svm_range_set_max_pages(struct amdgpu_device *adev)
+{
+	uint64_t max_pages;
+	uint64_t pages, _pages;
+
+	/* 1/32 VRAM size in pages */
+	pages = adev->gmc.real_vram_size >> 17;
+	pages = clamp(pages, 1ULL << 9, 1ULL << 18);
+	pages = rounddown_pow_of_two(pages);
+	do {
+		max_pages = READ_ONCE(max_svm_range_pages);
+		_pages = min_not_zero(max_pages, pages);
+	} while (cmpxchg(&max_svm_range_pages, max_pages, _pages) != max_pages);
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

