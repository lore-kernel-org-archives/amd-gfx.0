Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F06C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 17:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D26060EBB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 17:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D26060EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321B46EDB9;
	Fri, 22 Oct 2021 17:06:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F189B6EDB9
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 17:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRX8Xp0VM3Bs5LAIt+QH/7CB8wJnwJLdKoJfqX1hn3036QRTUWMCYL45KoT5/bXRs8vUXCqSe91QQi2d/yIR84+ZNrqRV7DEzIESWSTEuqcHvMtfmFpDfeQfKJNzXgayLwSeVqCCu1Hv4TXwSKfXIvXCyudEFE8AzAaxGLIp9sc7Chq9VPQWFS/kx5chP9qCD2cUDxuVdNWBTA94yItO2wuIP11WGLqI3cfNtfcue92goLeHAPFsHPOmTN1i09i1ptAPNXT1u6n/1HPNQl1W8IORun1KOnqNpGq2mvSYqZfpG7WTvRyF5a5sdhFCQCUavYMu61hqG7003I/uBufU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJrIsLuMHsXcgA1qaJd8XU7Ip3GBnUHs2NEuvcELwZI=;
 b=ToRLdB2QiDQndKZkK1ho4YMP0rjy8v1duXYDHvyO/Czn6l3ie0YJ8M1n4Iqk/zk8+vipBrtzUFyjW9tRSSt2I6U/UgfElTSupAd2x4BPwSIiNmsFdfYGf5qYq5cQEoCQH3uZyVVNJQygsXQGYI6qoNmhpHlC9Lv+ZHhZRBL/OXW/H1zSjPBsFwCEEJSzI4vggfiRubY+wpCcAXYZuYwBNCrW1xb/FSRtjqLFSzykdmtVjmgQolhtsgYsus+28TEw229XUGZQaypzSTw4XSRLp7uTFZI8cX3WYvquxFVDCxAEBnmHMgQpumzbHzwdWb0Fsa9rxwuMCY8/p0DJSglJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJrIsLuMHsXcgA1qaJd8XU7Ip3GBnUHs2NEuvcELwZI=;
 b=ZN1EMuVZIzyuM0/CYxQUS6I2ZdGDP+GXPrntKWONda64M/G5E3Mkv5mFdQ3QSGnwohiDXfBROYiPAi8mPGiMvw0x/IJbgxBgXhEoT2ZslAmsefz845olKlvITuE32ieGwyRpfB5ueR2YrFnFSBTdabghW5vltdwIxORdfQy1L88=
Received: from BN6PR11CA0019.namprd11.prod.outlook.com (2603:10b6:405:2::29)
 by BN8PR12MB3137.namprd12.prod.outlook.com (2603:10b6:408:48::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 17:06:17 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::36) by BN6PR11CA0019.outlook.office365.com
 (2603:10b6:405:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Fri, 22 Oct 2021 17:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 17:06:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 12:06:16 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: restore userptr ignore bad address error
Date: Fri, 22 Oct 2021 13:06:04 -0400
Message-ID: <20211022170604.5556-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2975419f-b754-4c11-f3d4-08d9957e42f4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3137:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3137B5B2D424AEA70F9D7A94E6809@BN8PR12MB3137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGelKHKu3Dw97MV0bJ4mKv43nZkSkr8GLyrGzvCzZxYjHSTm1ZhssS9Mf/33HzoBDv90mADD0kiaJGXmbHRzTMzOPW9BfLeyELgRk6GkXGqXXOUXZw0NZIBXh9sQY/ZSwluMheO0hlya24x350/fp8VlxnJ6tUtjpXrZZFCLHEj+o62xT0+8UBvNIJZ0T5Uurz9cZe+X9iI6P9MAf5S+F0CfuVpemCH9sYm7Cxz1c/mZ64Ult2gTEBPexncAUlYSHJkc5tigXzJdZsIVZiy5Dw6XssJ/Dbbpn/rMgDL9V+VhPaD0qW/orNnDv3aXJro7r7D9wqNzL4IWZCmF2s8tPYmUwCKKPgv9KIciL62LGz81RmVV696KAVyJpMxCwJ3J60Waqdp9Kr8MxZ0J3hRjACpeAa7zVNaDS7uJ/mKWt45DAnnpnExxT8MhpMp778rbW43B1Etj66O4zWLYRS24Zke/d4K4wk7MJOwc0qiQ7SAHVvC/6lJ+RrPxMn0v9Z2NZLALTLmBZDmwx+qnmDf0ytQq+3jSyuW9fGl8ofs8c/+Vps4wHk/QSxEgyURLMXCePu1KqjRegys1kyqyrxog2D3Wta1Qjn32SFk1Bay5BAGr6FPlTd9oacjLmYBPW1CGFdlJhwf7BH3FhWOaxPv+tA9E69pAce0lVTNRuhtQK/t9ptWpSQanFIRWRC6bV4m+yYEhIdf21Rf0dmRz2FuVrWFLLAzYPIL4SNw11D06z4o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(6916009)(83380400001)(8676002)(82310400003)(7696005)(336012)(47076005)(36860700001)(186003)(8936002)(16526019)(5660300002)(508600001)(81166007)(70206006)(36756003)(1076003)(316002)(4326008)(70586007)(426003)(2906002)(2616005)(86362001)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:06:17.0953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2975419f-b754-4c11-f3d4-08d9957e42f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3137
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

The userptr can be unmapped by application and still registered to
driver, restore userptr work return user pages will get -EFAULT bad
address error. Pretend this error as succeed. GPU access this userptr
will have VM fault later, it is better than application soft hangs with
stalled user mode queues.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 27 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cdf46bd0d8d5..6f01c6145a87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2041,19 +2041,26 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 		/* Get updated user pages */
 		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
 		if (ret) {
-			pr_debug("%s: Failed to get user pages: %d\n",
-				__func__, ret);
+			pr_debug("Failed %d to get user pages\n", ret);
+
+			/* Return -EFAULT bad address error as success. It will
+			 * fail later with a VM fault if the GPU tries to access
+			 * it. Better than hanging indefinitely with stalled
+			 * user mode queues.
+			 *
+			 * Return other error -EBUSY or -ENOMEM to retry restore
+			 */
+			if (ret != -EFAULT)
+				return ret;
+		} else {
 
-			/* Return error -EBUSY or -ENOMEM, retry restore */
-			return ret;
+			/*
+			 * FIXME: Cannot ignore the return code, must hold
+			 * notifier_lock
+			 */
+			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
 		}
 
-		/*
-		 * FIXME: Cannot ignore the return code, must hold
-		 * notifier_lock
-		 */
-		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
-
 		/* Mark the BO as valid unless it was invalidated
 		 * again concurrently.
 		 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d784f8d3a834..ae6694f2c73d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -693,6 +693,9 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
 				       ttm->num_pages, &gtt->range, readonly,
 				       false, NULL);
+	if (r)
+		pr_debug("failed %d to get user pages 0x%llx\n", r, start);
+
 out_putmm:
 	mmput(mm);
 
-- 
2.17.1

