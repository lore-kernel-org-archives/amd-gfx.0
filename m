Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98CBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 08:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D95A10E908;
	Fri, 21 Jan 2022 08:48:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7306210E908
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 08:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR2kkOnIIqi6tFiStyDilDLc1z5IWpXgY6dNBsORIPaFIsiyvexWUEcrSAWnPEOPneyZqM84d6sqwiCCKXzPP+Zvn3NRvcZMi5C6pluLIXlqvReCkHXgxh3fTFL2LCWMsvugdNPMESJfrkk3f8vd1wOxl58ZWQoB+Qz7cxm5lw3t+RiiJrp9VUtwcAZmAO7jbYKuELGnTfH/NlG95PFFFL64+B3pCW+8b51uqPeRv//ZaExeSw8XUljS2/hE4pFbZYCTNZ68wBZOGtMqo0XgDC812QZXqy3dcMGoEfiFZUzoJMQmqFghC9wtFn5m94R+EqG2QlJIlgt6fejwUoKx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3ov13Xl3wN18ACibl8w6cQLL/6mMEqufmdFkfEK0K4=;
 b=l76XDCNV9f7Syw9ioNdzCYAdHVyTmjUDFtLFI/70hgVBIrm5R+mjtaam2EDciPexO5oBBYK4CqC5hyFMcqlA8Nho6KZADZR1NVvZC4BUW9jCuFAMrYBcEkZrbZ1pvUuwcDz4878BPmvlvb1f9zxv9IbVzXOSxhQCyqt5/0KSPE5+4O7CQ7mKQ9wfz2HDBtlJmx26uxeQCU8gVt4KAIrFihy/iNrVaOml7XDksp+O2YstjMcdlrtAIWoHXHkGAqMGJhioYA2pPP9y18noqoDWcFa/1Y/AVGhSGb8kb/qnLESm624GGMxtxyV6k9PGQyMRkRni3hX9RYXQ4dv9ZqwAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3ov13Xl3wN18ACibl8w6cQLL/6mMEqufmdFkfEK0K4=;
 b=r0ovXa6I+jIPr3gdFCSeE85Sk0M2Upw9sDJbh+f1h9nLlSlvq8GLgQz0luHcLkJ6Gtpe6MrcTQBZ5eDi1ZPf/cz0lGSFK16EB/RWyTe50RVlsrm+wyMRIzPOz1ZAOVxHVdnx0weE8IEjsDcRGrRHZZaCxgDVq2ZTEny3m1JvNA4=
Received: from MWHPR18CA0032.namprd18.prod.outlook.com (2603:10b6:320:31::18)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 08:47:55 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::2f) by MWHPR18CA0032.outlook.office365.com
 (2603:10b6:320:31::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Fri, 21 Jan 2022 08:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 08:47:54 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 02:47:52 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: drop WARN_ON in amdgpu_gart_bind/unbind
Date: Fri, 21 Jan 2022 16:47:38 +0800
Message-ID: <20220121084738.29487-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44e17a28-308b-4885-25f5-08d9dcbab777
X-MS-TrafficTypeDiagnostic: CH2PR12MB3832:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3832ED5344808DDC580F5079F15B9@CH2PR12MB3832.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 704eHck96IsR6AguTmBxicU8QGcDoAyqDoFjTajl87us/IQXlPtzEdMdxAdHDrwaPUj3gZkXFv3dtIO0V5REJa7tbiwhNxIvbMY0aUmaWW7xhXHcwWWeMGzZWAQTA4H8eOqdB6/UgWU/wWcq0OYzQDw4kj27DZhp87ZNSnPBdHigRZ5Er1TwKyhyEKuyYwtqG7zVMCUNMHH6vJe7U0vWlsA/y+qdY274DcwIJ7v1AEkewNogd72mIicHKXNvbePjdrdha3Z//zjEUe1PZCnRPYRTq0PmN4FCDyb9FbsiB9yRarC/IBeDu3fYjn6rNIZ3cqPMW6ze5h+1xmt2cdCBv0qn0B7UX3+DnEHBIyKOuggfXf/hfG+fUaOYHp/Hl4zrKxRWJt1muZIrpCbFPY4IaOv78FR3CUHtMuyngbPL0GJsf89r2tRSirrN4NmNzfqh3EgHZnm4zOCRjRhdTAkKDQbHkQgA3aifkiwxjVbXlVfsojBl2f/6MuP/u/lCvRybziWlQyHyuKA1Vx8ZMnWrZPkBhaxjHpSNBn/zNSpaVeS12CFbQBGujGZa1uUevue+N7bwohZmJI+7QRcPzTcNjpgKMSEzYb6BlvBfJyyY0dxEAuPZLLXmF9RtRlzSUqHbDd/KgmAPEHtBEkqgslP/3rHdJs+wy1PWOH20U7g8n2JKxuBEd9/07GRBQTi5vG112QJjdiIiPZ2ndKBlmveuEElF/4S/lzM5FAqLZATsKbcRcxckokOb1nYnrXiuXUd1R1ctJS4pwJJ9zp35tXOqM6c+9/WpqPAR+8q7As6e9NVH8VkL6vrfQ15Kk7bcCZQl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(70586007)(6666004)(26005)(336012)(86362001)(40460700001)(426003)(2906002)(110136005)(7696005)(8936002)(70206006)(82310400004)(186003)(16526019)(2616005)(508600001)(81166007)(356005)(8676002)(44832011)(4326008)(36860700001)(6636002)(83380400001)(316002)(36756003)(5660300002)(1076003)(47076005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 08:47:54.8140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e17a28-308b-4885-25f5-08d9dcbab777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NULL pointer check has guarded it already.

calltrace:
amdgpu_ttm_gart_bind+0x49/0xa0 [amdgpu]
amdgpu_ttm_alloc_gart+0x13f/0x180 [amdgpu]
amdgpu_bo_create_reserved+0x139/0x2c0 [amdgpu]
? amdgpu_ttm_debugfs_init+0x120/0x120 [amdgpu]
amdgpu_bo_create_kernel+0x17/0x80 [amdgpu]
amdgpu_ttm_init+0x542/0x5e0 [amdgpu]

Fixes: f0239505d6c4("drm/amdgpu: remove gart.ready flag")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 53cc844346f0..91d8207336c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -161,7 +161,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	uint64_t flags = 0;
 	int idx;
 
-	if (WARN_ON(!adev->gart.ptr))
+	if (!adev->gart.ptr)
 		return;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -241,7 +241,7 @@ void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, dma_addr_t *dma_addr,
 		     uint64_t flags)
 {
-	if (WARN_ON(!adev->gart.ptr))
+	if (!adev->gart.ptr)
 		return;
 
 	amdgpu_gart_map(adev, offset, pages, dma_addr, flags, adev->gart.ptr);
-- 
2.17.1

