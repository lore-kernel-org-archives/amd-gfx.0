Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E7AC77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 20:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3133010E324;
	Mon,  1 May 2023 20:52:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86EA10E324
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 20:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srx6+neXAAnZO8KBkv1EDtBqsLa7AnsxIaUimBZgZipFR2CPlwQWq/IrOTluaVWXkACaDHZ7ppK/tDe7KTsfRQHQV8Z5zEmSApaHrt0+QPpXScMA1cj+W2DM7m4Eu4NmKFEPXWjkVUipVcutkC7MLBE3TCydPN/O5n1BwYLzw9Kp5pMxTyOVc1p5wZwm2KUPTI5EuLTpBOCASzZfQoEIS491SXNzytEdl0niACbIleJ/yYTTp/bAQsSiZ20TcQDY4m7bXUBjYRTcvgguAW/jBWe28IGlHhCxEAgqYQ3uF/boGUyYmFiQfWpoNWUDL00uWlxnyLVqfqUcGEn/bplKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Pw5RjpkQ3E+nmjne2X9N6omaLZp4uda66QUU2vvrWU=;
 b=dRt3hAv63eOfur133PgYyRYW43/hFdctR3FtfAJHlITkl37gc6+6uNK4n4OWM9cKRKA4MWd0AgT8ELJE1OlRok39z/CB2nlCLZZfthNacGY1kaY42hZYLDe5wVuDTZ3Vn/qjvEgR9PEKB66ezTWYxVY9Q5Hq+snWnB3hVleQmTC3Q8DyAseI4R0Q8fuBRy91wzeX9qSTYt84GxFVpQnVlqYVh4Q8UCIVT8NJ8HIz2nAqvizv4cvXLAvIfw/VJSxeSnWKrcSGgbi/RVxQ/PK2OxH2hSpltrA1iYeNictRkQo/0DWv8stlmMCLH/0Dq9XVU/mpXHaEJ22Ltm7hnx1eTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pw5RjpkQ3E+nmjne2X9N6omaLZp4uda66QUU2vvrWU=;
 b=gLbDwIpaBhTs6rQu/9L7FB5WwdzmtTdaZtORAdLk7vkvP4f+v3sYcqTsodXeKe6LnrwlrjG2sGXs7/6ZIuqNRSlIqQH0fIpomCYD+x5jw6X3yae0UBPdUcZC13GfYlthj23Ioz3vQ0iUbuAphUjV/2ZiU05vVDAFpVdh3mcJz3Y=
Received: from MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::12)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 20:52:47 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::8) by MW4P220CA0007.outlook.office365.com
 (2603:10b6:303:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30 via Frontend
 Transport; Mon, 1 May 2023 20:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Mon, 1 May 2023 20:52:47 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 1 May
 2023 15:52:46 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Don't trigger evictions unmapping dmabuf
 attachments
Date: Mon, 1 May 2023 16:52:27 -0400
Message-ID: <20230501205227.2402326-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: d19c3076-8f40-4b7e-98d6-08db4a8604e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVDkPz4N02juBUNtTV2baoBZ9jJvfvFYeQeUXsH5jfXnhXfCtcxghXwO7eQOG6W2r8/sDya4cgRHfgumYTDjpW326tTwvGLl3ht0SXOHXy8VKMhApE/znNoUCvgQeAjlFffVZiXrgwmWzH7azsOLwLbFOJRmKgUIA7OFmn91qVaboOwaNkUxRObo7OxUgsoU8LkzHaVttOX+llVsxjVhkg0hE9QvNC33+SZQBhxL9Yh14C8o7Ztyvn8Y2LaCfxZI7WVMnIUwsawQm0sYJGlIxWZEuTbLA36WeOiwXUdj8h+X59fth2J6qKppY9/riLOVamSmZfQSCNE4GBsZHJQfMUNXPlXUeLjgJmgBPOg1ODI40Qecx9iLTix6YB9lIO2zrbIPMSQKxGZTSGLno6pJ9KEbh4Ogs8wuK9A/abyorvUJD0K1PPqy6ETI2crCzRLhLE+comMNHEhtWuwchYE2UkKDmo3eOptXiku0m5yDbQ/2d/t2/8ap3GYPnPI6AYG+XvLk4fmHYjxm8sS1g/XAG+rly3aVqWlUwMArt6HZjj8CZcPPhgZwX1FFHA+p+97T8wisNc0XLIbKfVaLEqfLLHj9/tCnr4K6PE6CnpNu/uDowiH4vQwl1tx8hRackrG95tbFG4qRQjjLNHnIvPbbrcVLlQycCipSF6R9MHJUDO8TiTc15+ViN9bH3r5TtHatllBgA61RtwjhOy00DjoJu7FOWtk1DgCQ00Gd6laWFZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(316002)(1076003)(82310400005)(26005)(426003)(336012)(41300700001)(2616005)(47076005)(83380400001)(186003)(16526019)(478600001)(70206006)(36860700001)(70586007)(4326008)(7696005)(6666004)(6916009)(356005)(82740400003)(81166007)(36756003)(2906002)(5660300002)(86362001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 20:52:47.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19c3076-8f40-4b7e-98d6-08db4a8604e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't move DMABuf attachments for PCIe P2P mappings to the SYSTEM domain
when unmapping. This avoids triggering eviction fences unnecessarily.
Instead do the move to SYSTEM and back to GTT when mapping these
attachments to ensure the SG table gets updated after evictions.

This may still trigger unnecessary evictions if user mode unmaps and
remaps the same BO. However, this is unlikely in real applications.

Cc: Eric Huang <jinhuieric.huang@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1002c7834386..bb8e6f6793c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -530,6 +530,12 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
 {
 	struct ttm_operation_ctx ctx = {.interruptible = true};
 	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
+	int ret;
+
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (ret)
+		return ret;
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -662,11 +668,10 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
 static void
 kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment *attachment)
 {
-	struct ttm_operation_ctx ctx = {.interruptible = true};
-	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
-
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	/* This is a no-op. We don't want to trigger eviction fences when
+	 * unmapping DMABufs. Therefore the invalidation (moving to system
+	 * domain) is done in kfd_mem_dmamap_dmabuf.
+	 */
 }
 
 /**
-- 
2.34.1

