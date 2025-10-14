Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB88CCD192
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 13:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9413610E62D;
	Tue, 14 Oct 2025 13:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLTb7RIt";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2313410E617
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 13:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3HN7iY6NLEnuaT8gplpFCc96L1BeUM6tOsrSNChjHQWrjQpEANdPSR+yclTJVAaWdb5kPpwRP1ju7GUJe56rGx7c7sgQ5pO2kui/j18KtPDuZ6ktR/X/wEW/hTtrxVH6BaoUp8lgqCfoYNKP0fxMuYyN2mdyVLg9wyUYQFSOmkZUX1ptgQBC0TgbPFNUKI+KmxjvusrZF+PQgTAAWAeqxKEifrISPS+5HesZ0C8VUROHft8auORKYe1+lA707ignwBgFw15p1qF0hPWjOU9q+Bs2jWlBdmH2a22BHBCZzNuHz+mIYhXTMZsmHodKhVqOPP/A+eTWhDfXdk7Kz31zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6reHGc+rZl2jhshBcL4lrm8gSJGq0W3HMebxYhFUlo=;
 b=qCL3X65mABGRYeVzJqRlucGXwZjxwzi0ou+1WKSVrakYWZYG8Odpev4ozUwzN602YYqZiT5cS28Le0+vUlQHMKdZfWR49xYTxrsw2HSrvPq+x8TC15cT8WDX+f/HnBN6D//zgRlF1FhxmDXMKI7u6W9bprhCtITgrL+b6lVLDwJIn9ety6iuABEahQISlxGs1MHxmvQtl4fLwjsrb5ef9kKC/Cvikzyqt1vC3izVtSzxPB8ZXjDEC3DFh3PNfNKdJeNQtGe0K5/75wyVWfHJXb04DhjaSTM63WXtmxzHyJzYYuMnus2jYgf5KXF4huIu2HHuASb5xjqxpR56OucOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6reHGc+rZl2jhshBcL4lrm8gSJGq0W3HMebxYhFUlo=;
 b=OLTb7RIt9OZKPjeOf2aVAxzeZ4jTAbcj8jwRBn1J3yGUzpJZUJWP0OzVHyGvgMh8NKgLmkJ4upVRvEEwFntIy//JACPs6RHuwdj5MvY/VqSR0R7Y6OpfssQtPr+vXLBYG+T7otNT8I3tJLgoTcV2yaxYo7FBl1y0wcLWfku8s9s=
Received: from BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::20)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 13:43:44 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::13) by BN9P221CA0015.outlook.office365.com
 (2603:10b6:408:10a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 13:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 13:43:44 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 06:43:43 -0700
From: "Alysa.Liu@amd.com" <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix vram_usage underflow
Date: Tue, 14 Oct 2025 09:43:17 -0400
Message-ID: <20251014134317.5081-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 402bf562-a500-4c51-b336-08de0b27b18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+/cjeMBxOLsLdS88M3MBgi8JXxr6R2UWhS4TVCKarOGGz/94fSINcD+iY1Bc?=
 =?us-ascii?Q?46QLek23Mobp0t9zFPQQgzypVk1SJzkQkK212B4SF/Bt3Va8C+4esQk5TC37?=
 =?us-ascii?Q?AZRjmsVm0JLrWoGzEifm3omI19pLdgps2OyxVcvl5jehMmU9C+OlcoZtoVUe?=
 =?us-ascii?Q?yIPizB4jOxoNgmDuU2LzTxDxex2jb75dsZzGAjSxa3kxehCjRs3Ce76zuEMp?=
 =?us-ascii?Q?+pH5gl2xGK/k6TTERoHvgNaWOXx1oKMobpKHkoFbdnyLw2olefTB3jYsY+hv?=
 =?us-ascii?Q?rAa0qHqTpYZyXRH0Ab7dUnFa7lXAFTIPCb3Tt+Chu1XPkzf6nRzX9niZPFLd?=
 =?us-ascii?Q?guOya5fDs0NDlo7MmsdhibC9R1jIFaLBj280ZBZvQTQ66CSSoqw4i3eqE+S4?=
 =?us-ascii?Q?HR4lZFsaaPVOEUooN9m2Suz4/gSCXqlva2AoVXn3ZBPKnzFyLk5ienhJuMGo?=
 =?us-ascii?Q?EDftZWj86AwGMLvdbRyXEQtwmdDxizbYaX7ya+agJLCttQ9t1Oyzdevt6pat?=
 =?us-ascii?Q?xfTkeSGTNbzTEaODSH3AYfBDv1Ri5uDBOJNHYJ5D7IsLMWt2Y0yzxk3r3ryS?=
 =?us-ascii?Q?d8Dg12olZlcsbfoEmaUMLIB0MsGY6BFdEbBW9thiBeCFsqRu6qiKiQMimJet?=
 =?us-ascii?Q?k16FbjVS44wuDt3YOFu3RDCOq/nfDBEvUgchf7+Qe4VDjgJhVIiRIaolzIQR?=
 =?us-ascii?Q?+kSs47eos+RC+Qn7G+FdJgduAGo+0ti+zn07EGgTAXoEZD9BfQB8deD+dHf+?=
 =?us-ascii?Q?gHfvAI4sDUCmXFgYqg6xnRN9TXNkfqRC+S7h5+/z401borI0Hy7SWeDQ0Z58?=
 =?us-ascii?Q?TTbVa+MtYd7MODJJQzPy5FsRMxC9pwkpnBb5O3hGrFrtG/DnO3wnfBcIYS+G?=
 =?us-ascii?Q?GauIXwx4vOMPotTIXherEsdD7V2dfbArqXSzo97OE9U8HExXUxDJq/P734aN?=
 =?us-ascii?Q?uwjvu3l8jeDDivAq6HbOVnQe1ryJoY7GoexrcnRA74oljEu7tSxKAsRH3lSN?=
 =?us-ascii?Q?1Bf7ohFkUn3MlOGH5xgdSB+yMt7OJlKaygGbwkSjhnRqEJ8L4dj2xSE3lhzR?=
 =?us-ascii?Q?x0iMgDtEbXaLTmW/4amamRXUSBql2tg9rrxm2BGGlsiG9b9Ak4LInHlEwvF9?=
 =?us-ascii?Q?D8Sny6I2vb72H+OlaG3EGRt/R2z8ylI7cpl9VwLWfkwpWkAJfzwb4ip+JxXj?=
 =?us-ascii?Q?HI9SKRGx6ld3Qry13wG3h2AKvJN20AxlHqdslltNUAIRpBJ89YfXfNHgZ5Bo?=
 =?us-ascii?Q?4H03Jo4yk+lJ1r+S9lyfwv9MrNcIeJ0JKOwN7htuGujfY+1qaFKmKIkbyrfO?=
 =?us-ascii?Q?ndXIfK0DtbwPH9dTqMTm9XmDT09CZbBGVMo8uvixEmAJlCuI3xudlJJcem2e?=
 =?us-ascii?Q?RTrQlP9rcrFoNgmfdZH11rGQUITdL9prXHeQYhlTATm0DN/dOU/TsCnhfEAW?=
 =?us-ascii?Q?HnIYyOMbu7ASqyKM0B9Knzv8aIQ44P3h28fgOQjVj0aH3FlmAVgjp10Ij08/?=
 =?us-ascii?Q?LnriEQfNsB4t8PB2YMM8//gu+ALZus1sxSmrYVukrxXS/avao16Hb5PsPWGL?=
 =?us-ascii?Q?xnj70j7oJWf/4s4XnFY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:43:44.3367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402bf562-a500-4c51-b336-08de0b27b18f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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

From: Alysa Liu <Alysa.Liu@amd.com>

vram_usage was subtracting non-vram memory size,
which caused it to become negative.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 22c1bdc53d2e..c2fa330ff78b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1961,9 +1961,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	 */
 	if (size) {
 		if (!is_imported &&
-		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   (adev->apu_prefer_gtt &&
-		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
+		   mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
 			*size = bo_size;
 		else
 			*size = 0;
-- 
2.34.1

