Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5DCC11F64
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 23:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647F561D00
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 23:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647F561D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66A16E5A0;
	Mon, 28 Jun 2021 23:15:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7787C6E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 23:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBI6Jjk9iaqKRkeXFzb1KWIk0WBQah5JksFQ5m/uEPwionlfUZzCuA/TsNmVUMUcPLp5upgj75IbsNlts9twT8XJZ8bwf7kFfM5CYHtwrJMdCuvMLio3xyJvFmZIkP41oxPHvf3krD4r1EBq4+s8FQYZdAnJiGa0me+yJRwJZo1ICrOQ/UrO0hWPEmuwKGXvYlzbGiaG+1cOceBBT29SeXHbSGQ94uBFg6K+6RJRWvP84O0fXYvAs4Hc8ROpE92RwIlwrFa8Qm+Qs02P94ZXdYfa/LxFRqprM+LqdNVdmpe/GfOBRK0ZL+qBBNrp4gfPfmeGU2b+Qj5bPno3dI7YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuqJxAT7ezzbVkDc4OBKVmdShPaibQhVy7BGFLy6SXs=;
 b=Ch1/Tv4o0Ue1gx6MRasxV3+wrrsrsXvdZ8OXQhFnfZnLRahr9XzSfeAe/Cll83/jKY1aBp5rBmqLL87igfzPS9j3PCvzV2l0hMuvKy+UtzB2IgzyjzTK/byYcqrcDuBqD1POskdkn7YChBqi+Ufy/KkssAHn0NISIq4PpvvCL1k3DCpayV77kOtAaupE0Sa7w40qYja08cSUiurZg+/J4LlSc0RwPLire6szuNDssQUF7M4bv4wGqUOA47Pp75mNFBZzFXzJTSlHlnZlqKF1jwYZen/xCUR5ic7ywqCmAmouJw63rxrUsHKiZG+MnbYak+hvq0JA3jNVGGV6mXuIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuqJxAT7ezzbVkDc4OBKVmdShPaibQhVy7BGFLy6SXs=;
 b=XoPgAoWI/oQdQY3qvslWjCZ2f/pgx89TH6n//hdvARuavYClvleFJc+lZLBdqfXU/Jt70uEdB3q1YBdB25XyvgyWgQJjLx4Vk7floX6Z5mh43dloZteZxsbnKUda+FTTJcnlngHC2jK7CukN/uhZqaTZ5H/LkRqdxG79L71Zlu8=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Mon, 28 Jun 2021 23:15:45 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::69) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Mon, 28 Jun 2021 23:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 23:15:45 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 28 Jun
 2021 18:15:44 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Set ttm caching flags during bo allocation
Date: Mon, 28 Jun 2021 18:15:36 -0500
Message-ID: <1624922136-15220-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e13b04c-f090-4d28-382e-08d93a8aa86d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1578:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1578C429B8FF4E52546860C080039@DM5PR12MB1578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRLSFnj29BkmcfATy3ivu/MYqdqdIewjqLh90vQnAjf6/shG4dH1BFgK3v9gIMSLY4gRFsTSo/7KYeg54L4LVtx88hZR1GuY3OTJrmSXC2PKRY7amzdBLgHYu1IWbDUN838EoFKI51duLdlkYyqh3ZJuDA7e/XTEm/JPuuBm7bwSNUheg+0CB111MRQvNqpSasKWc/BHgFvXK844czYQbtP7ChQAG8CYOFTMp/8dul5L7C7u1h9a8TNxJC9TwD3SqY2PbbN4UIOUXiF+8mYYo8nunV3d538ISkqChuHR24tGoH3wCvPeBCUtInJhbJkXFeoN8nc1ni6JbpptvwXT6LtIqfhUawqY17gAhddXqrv0CKgBff8EUX/oMnCy4BhaOrnfvcJOxrZtcP134AM9CrbN/Pk5ofHPo1E07Wk8QCRbS2VBxOHWqAsCPUK+aYR/gc9L+YrZSXR+STI3EjHyUYsDnn8DDhNBwWMlb3qpQR/9TJYKDGvMAg8t4Oc4GndnysYKC6GTbZuwnCHYqRPawac8Z2eE1bExJm0wlH0TsjsN+srT+nMQJvdWcaK/0Zz4rSZrdmYXpe/MntDCDs4apa3ruXx6DnRY7UDW3PMpkPbFILmRwMDACnGv5xwzYVmkTaaWzmpkMeG+ii9S2tOg/bJwCLcLUEC8/AzEagp8xE+BZPAuJjywdo3fwQFkIgs43ZOz0Df5lI/tqhTQaIPVjcIHzWKDDUMDW0Pri+gm+nU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(4326008)(70586007)(70206006)(16526019)(86362001)(36756003)(2906002)(8936002)(26005)(7696005)(186003)(6666004)(478600001)(2616005)(8676002)(81166007)(82310400003)(47076005)(82740400003)(54906003)(36860700001)(83380400001)(5660300002)(316002)(6916009)(426003)(336012)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 23:15:45.3594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e13b04c-f090-4d28-382e-08d93a8aa86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1578
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
Cc: Felix.Kuehling@amd.com, James.Zhu@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ttm caching flags (ttm_cached, ttm_write_combined etc) are
used to determine a buffer object's mapping attributes in both
CPU page table and GPU page table (when that buffer is also
accessed by GPU). Currently the ttm caching flags are set in
function amdgpu_ttm_io_mem_reserve which is called during
DRM_AMDGPU_GEM_MMAP ioctl. This has a problem since the GPU
mapping of the buffer object (ioctl DRM_AMDGPU_GEM_VA) can
happen earlier than the mmap time, thus the GPU page table
update code can't pick up the right ttm caching flags to
decide the right GPU page table attributes.

This patch moves the ttm caching flags setting to function
amdgpu_vram_mgr_new - this function is called during the
first step of a buffer object create (eg, DRM_AMDGPU_GEM_CREATE)
so the later both CPU and GPU mapping function calls will
pick up this flag for CPU/GPU page table set up.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Christian Koenig <Christian.Koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6297363..93acf6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -607,10 +607,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 
 		mem->bus.offset += adev->gmc.aper_base;
 		mem->bus.is_iomem = true;
-		if (adev->gmc.xgmi.connected_to_cpu)
-			mem->bus.caching = ttm_cached;
-		else
-			mem->bus.caching = ttm_write_combined;
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index a52e17e..6cb66eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -454,6 +454,11 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (i == 1)
 		mem->placement |= TTM_PL_FLAG_CONTIGUOUS;
 
+	if (adev->gmc.xgmi.connected_to_cpu)
+		mem->bus.caching = ttm_cached;
+	else
+		mem->bus.caching = ttm_write_combined;
+
 	atomic64_add(vis_usage, &mgr->vis_usage);
 	mem->mm_node = nodes;
 	return 0;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
