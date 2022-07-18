Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF0BC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 22:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8470110FE69;
	Mon, 18 Jul 2022 22:52:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DC510FF13
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 22:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUJO1MuyEJdj3M5c/0DD3V7CON1B0+zWd3zOWmyE3iBODvlLVx7UAvlokFMgm5PwghqAwn9hZ+cMcfQVvuMVV8jglv4PgDfnaI63kTwZD6s69w5Eeqk4twx4Yg1TRp/VXgkbdBdQKtRA3PtsOD5wT+A1RaxqgbNy16wv7ZhSQRXyfmh5MmZfBbUj/i9VKoOfTxcNVYUwcMngYVLh4gymQ9b8HD/lTgCWfSyK7agDoyX8kLi7YonJMv+El81o8fq7KzbzRWcmTXGUjfnM7Tenqw3AtZEmfbQt/kHTo4eFWYDAT1Rlx2BcF6RDwUOWLzMVQwxaR0Fduhn8cJHc/zowSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WykDuaohwenmYAYLR6R4GwMi22TDJcc3li8UFcaySUs=;
 b=OWHtVJo+C7XKUJF02hBUy1Az3SIgrOGRSAWduYE/2QuwfrfUaEJibqcoNyJzxw+gYsTDfm4xvCahv+61CguaTaY59BbDxryidGqgADpNv3rnsXUM5Z/dF+OVXIfGTAqWi8ytPWASDszhSbz3aj7xndOf93R49f75jPbe/3B355IypmbKvjoMJ3Ny2RAVdpOU+y6Ce6re4M9Tzg4j5e3me9RSXttQ6WprEhLydTaP9UX2gmh0smwIuCC9z6neEN2bEx2AV7zS37XhGP7C+/D97DlblW8ODFJDVcAXnEoZ8he8pCh4zqYJEZsNxaQ1fg4D07xO49v9o4QlpFRblC0gUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WykDuaohwenmYAYLR6R4GwMi22TDJcc3li8UFcaySUs=;
 b=0JCtkdWa5FSnAQDvtCgHjKWhevun8/kbXt50ao4CJIudGarLRn4aL6PXFNUlMMUjE4XyUYQ+z/KNCdJJc80njI4YfhLJKSEZ0/4ycY43J+ZPdx2cw3OdaRJsrkwv2SVkJ8akbDDnzW8CXKWO8kdPza9N0ZlHsUYI+JLeL/v0Bh4=
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Mon, 18 Jul
 2022 22:52:44 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::40) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Mon, 18 Jul 2022 22:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 22:52:43 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 18 Jul
 2022 17:52:42 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Refactor code to handle non coherent and uncached
Date: Mon, 18 Jul 2022 18:52:27 -0400
Message-ID: <20220718225227.17382-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c65c65c1-23ba-4e98-7daf-08da691039d3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2qiZ+pVdVqO60TvhXm1Tqz9fV2iRJCiWFQOGvp00ZhZ8a7Rr4/BwtXKjW8iuwwoNEoOEFml5wOlOmmvBWULE8hveBNBkhHKjBGMuG8+jS2cUgfCI/KfF9ZrlDiHp0tKoOl/Uk5/gMQxyVO+om/2Q1H9GDpXdrbTuVUhHd1wjSmucvx+wx72BiyUV7k/Z/Zxo7aD24QbDUOU/c6wODVkoRSpdZX+RuXFH303X7UmQaVAH0d/ZRBiqCkYNSx1XmFZ6x2m6F/GEC1F8i9FZmVOSa2yahxwkAdUckk7dem1o2XWMhkIBBTmOVHz2b9pQb3v38YV85usFnXNOUqAvHdfWAdQ1qI9j90jz52zYoyALKV2FmnGjUvIOrEwbtqNYopF5YzhEb00UVI353Y+51cSBSvaSlIxFB2gHCzKBm+PDJXm+Lej4oJGvkqljmCyVND/zf87SYWOqhO6ifb0/va5jhgz97j200q5CBoWob87B3vvODVbQ2S/160+Tx7qN83Ww5k3H/9dWAlCzxmIhIfPCN+GgIIKlEwFbnr6ZrZlR6n+gzojCVJIFYPPzXqM48a8qRhe8SUOzUvfJT3Goj1qhpjSXrF4LDdxWAhqEka7MKEpIgBeNeXIO5ls0QYTjApWfQUnxs7fTFpovoDHsyzLd9Hyu+Y8mXCe7JJ4ynxmxEWT2VXnKygJaHq0ZamZT1bM1naVbLhD1EjGF9qkVQlmVv/6kV4TLJUdO825Cqyr9vucIzTSslIssi8hGeQ6FGlCwhvmlT6xxj74bNDcVouEVJ5zIDQiKU+tHbU6SKjOumqAkoVlkuzJzrpyQDP8lSjbl5zeKByhRnOXVQ7jFwqoeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(478600001)(8936002)(4326008)(86362001)(8676002)(6916009)(36860700001)(316002)(54906003)(40460700003)(70586007)(36756003)(70206006)(44832011)(6666004)(7696005)(81166007)(5660300002)(2906002)(26005)(41300700001)(356005)(82310400005)(82740400003)(426003)(83380400001)(40480700001)(1076003)(186003)(47076005)(16526019)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 22:52:43.5026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65c65c1-23ba-4e98-7daf-08da691039d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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
Cc: Amber.Lin@amd.com, Alex Deucher <Alexander.Deucher@amd.com>,
 Felix.Kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Joseph Greathouse <joseph.greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This simplifies existing coherence handling for Arcturus and Aldabaran
to account for !coherent && uncached scenarios.

Cc: Joseph Greathouse <joseph.greathouse@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 53 +++++++++----------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d1657de5f875..0fdfd79f69ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -471,45 +471,44 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
-		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-			if (bo_adev == adev)
-				mapping_flags |= coherent ?
-					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
-			else
-				mapping_flags |= coherent ?
-					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-		} else {
-			mapping_flags |= coherent ?
-				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-		}
-		break;
 	case CHIP_ALDEBARAN:
-		if (coherent && uncached) {
-			if (adev->gmc.xgmi.connected_to_cpu ||
-				!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
-				snoop = true;
-			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-		} else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 			if (bo_adev == adev) {
-				mapping_flags |= coherent ?
-					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
-				if (adev->gmc.xgmi.connected_to_cpu)
+				if (uncached)
+					mapping_flags |= AMDGPU_VM_MTYPE_UC;
+				else if (coherent)
+					mapping_flags |= AMDGPU_VM_MTYPE_CC;
+				else
+					mapping_flags |= AMDGPU_VM_MTYPE_RW;
+				if (adev->asic_type == CHIP_ALDEBARAN &&
+				    adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
-				mapping_flags |= coherent ?
-					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+				if (uncached || coherent)
+					mapping_flags |= AMDGPU_VM_MTYPE_UC;
+				else
+					mapping_flags |= AMDGPU_VM_MTYPE_NC;
 				if (amdgpu_xgmi_same_hive(adev, bo_adev))
 					snoop = true;
 			}
 		} else {
+			if (uncached || coherent)
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
 			snoop = true;
-			mapping_flags |= coherent ?
-				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		}
 		break;
 	default:
-		mapping_flags |= coherent ?
-			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		if (uncached || coherent)
+			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		else
+			mapping_flags |= AMDGPU_VM_MTYPE_NC;
+
+		if (!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
+			snoop = true;
+
+
 	}
 
 	pte_flags = amdgpu_gem_va_map_flags(adev, mapping_flags);
-- 
2.17.1

