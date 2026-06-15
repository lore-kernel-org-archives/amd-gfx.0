Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A042CD98CE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 21:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE6310E724;
	Mon, 15 Jun 2026 21:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qRGJdFK0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D179010E72E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 21:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNnt3HXtdIT/mZtjdZsDnH0JapR2lxWDPXn5q49/sRomcm7csBrBXDbXPoMGEN1DqlfF60SWeGy3e+KLtZIb6MGfKKLg1upcf10jJ7/Vllk/HcPIpcNELzGRN1MUPIdduYjGOK3pYS8xaTSVKcdDgqPy8W0BLK/AIaBS0x8FQP3/Qo6qh9G+1hW7O6v1gaBTH4J6BotD0v5pZWJIbvFQUcTlLZeaNbMws3sr/8+WASM8briCoGC98zDNl5vaGDspqsuwop9NBNZhXD6oUOZK/ZYiMhg3qgcNpOc1/PjIvbuC4rxGWmZVd5VUCvNCx57u2a0cVerHNG91/MJ5c6YQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf54UPeyFJvkIErZ3OBZv+xdael+MxvhoRNjcdU2zeA=;
 b=wQt6gywZQLyzazn83O3B8VDFXp3gfNTNL3Vbh1+9vxLOkDJN1MEgl+fYZKLUKAGPvMrASCb6ssmBIfl+FmA99vYcCNKiwLO/Aun1L7z1JasX1CI5cdcapNTvlqVAIFPB7uhxVu7l4zyIsvEZQS7TTtwgTPBpDXm1RhKBGvgpr502h8yBK/AtnfGEjTXXFWUsZ5UWLGcWPSRdXXGhm6aL1GR2Ux3YhA4mTc3vgaKPIN/CDOEWTIYNJwna71i/06pg+9amjbtRsMVX2Rn7LaIa55n7ihfWFJjhiiwbr+w7INEz0bxPSbRQ/PtgnEcj9P2nfwqPSPuLFZ8lRjXcO3WhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf54UPeyFJvkIErZ3OBZv+xdael+MxvhoRNjcdU2zeA=;
 b=qRGJdFK0BYIyrs1M886m3rBbYBs3djlsvhlDhDQHN1RKUa5W+qdKRjckLODq4pZxuJOv8ZH66Uj2zaJNfhgvu4t3DVeTUlJj8K9yZgBo+JSoaTZm4hT40nZqmImQ0PkgQse0DBDcMSRqczU+u16epXNqxRXWK0Al05bTG8tSgxQ=
Received: from CH0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:610:e5::24)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 21:17:13 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::28) by CH0PR03CA0259.outlook.office365.com
 (2603:10b6:610:e5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 21:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 21:17:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 16:17:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kent.Russell@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/gmc9: make all vmids available to KFD if KQs
 are disabled
Date: Mon, 15 Jun 2026 17:16:54 -0400
Message-ID: <20260615211654.676386-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615211654.676386-1-alexander.deucher@amd.com>
References: <20260615211654.676386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: d39f2bad-4e0b-47a6-bac3-08decb23783a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yadMy1MwN7Ob82NZW8AHG8j0xTpnQ2mqggVu4xMg8N+6+EyFo6rI6Ib6VrJtBsv5cPAasnwu2zkXNU2vQdYS1enhwUcn1VmDGsNgHVj98ppviCHcBo/x1qgNBg81pwgfATr5a1RytJwaPnYwfnew+8w5jV5a6dNnVPXoD7ZoKCIFK/ImP//Iepf08UOsdyLp3rpVit9RZJldKjUlejGjStOPdQ7aWEXsyHokWawWpFlX7fKw8OLTOsfbcv82QY8SmaC99KZPy6RylfxjaMBuvJdNumj5HSNLU2zKjb1jIORKY5Eclwy0tNMt9QMjj02jNY3PNSFzXZcHGFaxpBwDBCKq+qci6aW0R/zH9fEGgqH6bfMdOrMyfGLnAkoZXzl/qoahjB59acuzEDsFtMBlWIeLmPbd5F8BVPnXEaLeX8/zJpGmbB+vgiCv8vajGXFuYetskoFmUBckcb1A36h3fVuL6IMuPcdosz7HHgnxtL57ZXGQx00mUcgRXkfVAgHVPaCk8Ha9dwefTTNjm5qHP+y93hft/Cg/j1ksSeu2KHApvUM9U1uifwq8aXBZGdQF3rFOCLcvKBAj2wIlhBpsUYNVhyfxIo0Jd5a/fz3CZwimJgiF5m6Kk4bgZN/yEo8NU6DLyD6KBanSFYBOQExU0FU5eVOBc/tQqBo4iyLCoeImRn6Tl9sXLutKNWKLVL/fxbV7HrsM6D02Fqy2DiDJF3drFDPFPiSfcB4lD7RqB6M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /QLT+/SppQitpIkK5wuG0t8MTmqJEYuEgz1ODMrLgb92KykARoDYFY3JlA8xE08SFVE7gkpoCOKmYMIQaoIDNqbwf57ic4HJ4Ijt+X5/jgDHxLsHhAeqyv423/x7aTcjWnWiP+HqJB+JlU9GsAqNqtb1YL+qV8IbzynN5WcKmgSxsuT6gNqVbJ4Gmv8aJN9qnGQSJkvMnZCVXtF188WrEMxAGTTCz1JtM9TKU3qvVqT/kI3Mu2dgdWZt+41O5cSd9AqmjC7ZVrBQheRFc6m4gAPVcc48pJbMR4DgjEemdm+jjsuWQCWnk/ndHfv85m7+9H6HJVynZ1ER4PNz87Kv9jiITy0OKU2k5EDJfQG+Kk3clGjrmhSy5tMo38Cm68iJkn7bFYfD1xqZT/1jeVmv6IVK2x2voUm30zvhLc4uL+93Wezu6ITeWX/JqSBYDJa3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 21:17:13.3850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39f2bad-4e0b-47a6-bac3-08decb23783a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

If the user has disabled kernel queues, then make all vmids
available to HWS.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8a5c44810ba1e..5166055c6692c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2025,11 +2025,19 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * The first KFD VMID is 8 for GPUs with graphics, 3 for
 	 * compute-only GPUs. On compute-only GPUs that leaves 2 VMIDs
 	 * for video processing.
+	 *
+	 * If kernel queues are disabled, allow KFD to use all vmids.
 	 */
-	adev->vm_manager.first_kfd_vmid =
-		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
-		 amdgpu_is_multi_aid(adev)) ?
+	if (adev->gfx.disable_kq &&
+	    adev->jpeg.disable_kq &&
+	    adev->vcn.disable_kq &&
+	    adev->sdma.no_user_submission)
+		adev->vm_manager.first_kfd_vmid = 1;
+	else
+		adev->vm_manager.first_kfd_vmid =
+			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
+			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
+			 amdgpu_is_multi_aid(adev)) ?
 			3 :
 			8;
 
-- 
2.54.0

