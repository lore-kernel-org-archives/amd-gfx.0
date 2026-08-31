Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8671C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3D310EA7A;
	Mon, 31 Aug 2026 18:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dyt6WLsb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CDD10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmJ5AJzBv3ob6yZKeObH0PsnjTdINxeuyAgjtTpdDh5FSET2dlDYhHSHjlOsuGRMJp6ZUCKrbDZHxx1nNtkzw4XZUSPrejQbWhTLuhM5L2UP0GDyNp4dllany/3HeXGI18RhJGl23R40wfKzq6FzIVD1MgSAX74hTP6VBtAHMcTRYyA9C2d2XKurhjxtYEaU2TvNqtk27KA2rbEyEDex2dd7AaRMrzDrwh4lYLUzP6lVB/sU4HO3RYVkqOJlDM0UymfFC3pPX0VjRTRegot3g0WsHKV63o03Set3oY+l4xa4KbYKe7kxI8SkHZ/hE7SRsvsfOR7L1ULzJK/vYhDbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc6yDNGTaft36Htq4Ga7tj91VsNSkjV8l8YF20FQ9h8=;
 b=DH3TCe2KKQ2z0y0tAi9Hwjz9r8laHfnLlEeDXSny4BF3JY3LyVdkYfKQe04a5J4mhdmi9XOHXf3wA7HOrFXnuNFgMsPykATcb4D7wF+nz9oWHUH84Wj4bOs7tYYT5LD+pwx9ncOT68jl2RawkDVC5rmMs3Whv/VV/vzJRYP/AWhEXJMaUS7az7hXpoGp/e2R9tPy0RpeY4JIUgEgiEDfF9K0CKloQFHfn6sRk30fK+M+OEda9d5w8j9aR2sQ3oOikMGncUMUv9qJOPkBHzsPBT+3LNIxZ+OCI4gAcolgSEvyNKOT8JALsUsFzAoYZEndfH44jPm6TbQx4iBo39/GJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc6yDNGTaft36Htq4Ga7tj91VsNSkjV8l8YF20FQ9h8=;
 b=Dyt6WLsb4KXHpaQOpaDLKnbKWMhjQ54Jko8rm/YvlwhaRCyIMx5cOZmQUbpedaCQr22Oo5MuLTzTvtypRv9/m3F57phEOmy18BO9zDbyGnQ2JAFsCGmMiiosnhIezd1eZMT3xPB7eiqJQ7iRPPOju3qwd4nyQZge50j//BhiEvM=
Received: from CH0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:610:75::7)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:05 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::86) by CH0PR04CA0092.outlook.office365.com
 (2603:10b6:610:75::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 60/95] drm/amdgpu: Temporarily disable sending remote TLB
 shootdowns
Date: Mon, 31 Aug 2026 14:27:19 -0400
Message-ID: <20260831182754.1089811-61-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: e642594c-f490-4c1f-c1e3-08df078dba74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: qSXmKNrL2gBmOUTDAtfe3GFm/RkX/cB+PRwVLq+R9cQ9QKpcJ+ryductrsgY8Ro8i2+s+AozcLeT2kLKhgpPPNRSjz0Ggk6/CnF/47smFzV6h5uMYwqLp6hwEiouofcTTuaoZ+wt2Rb1LYJv2w2Ho3yVaDs7TTgzE8gqX1uubmhllf1bdaoBaUfxUOnzzcIS0taPLR2XZy9unaud6HR+5zUPGUh1BtnQNCPIjjXizsNnrqQFVF67LrcGVT2kgIsOIp2suOea5iUALaGWVLIs6mcopjWKjLT78ya43OQGflyFFsHxX+tQZRiszCHdupW2UCHrQrzqxlSxFuL2HRkQvzIEKJDg2Xnodl27MJh+WLi7Ip/mdRLa211TbwnYtb8WSLk1n7TMlPsGzBPffJjseKuDfutEHAt5MJ0QssDHdppT/wQzF0HeyTAWfm68fnvlonS8qkY0oy7Pk2aAHX3JlI++asRrq8tpbfOUSHju1R2iE242aU8ZhcOBLnYLq5BeVKa68IGdHyiI29ZjglS8E8SK4kg8fJm/xTUTbaZi8OIXsMzGSJbPl8hEMEMLxoGpdf6sM7NeDXonAItjiSVD5gKDrocVIDFJGGSZ5jm7uPnQ7n6xfVY31jYqkUlGuumHTeLKzGi7nT7UDaUF4wkhamdWD7UQ23kMMGEnHFz5FW90J1kfRTrCVH7zo6XBXz7IEaZxSlpSL9q7/qlmpH0q+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SPweoTXcEaAB30Ho94/nBY6rPH8sUMKPWOOjG30Mpwpt4AsHLj9zf6uqj2fLduT9LA7I9GorxWMrMlYzeTGzsptzR7OvX7JtQaSy6oNB0EoEic9QvgUuBNUXdZEhg3ikD22sXOMOD2EbG4ZEbUhuuWj0zFope78iDSfLiPEpKNw8aO1LyhM555IpLx1Ou+pf+tzxNFkr917tRrSmjoxsZ+tTJ4G3aEHOmQt07AAChIvaVVIkeItJWkUQv0HZpthwBQ4ILFaDXWlmXmZfthwD0bWmZt1QR9/3zP4xZxnv+XH3+2GComALmBubk1lXsKfBwA3AFoYGX4EX7+WWuFXKYY+dIKrvm92R9MbaAd+W/LixPluMctrBi9y5L29Lia3ipV9G8sJSq0t4KZJbBfIymVfPTwgB7A8OWZJUemEPEE8Tyr95KsC57QjjsT77TIWS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:00.9447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e642594c-f490-4c1f-c1e3-08df078dba74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
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

From: Mukul Joshi <mukul.joshi@amd.com>

Remote TLB shootdown is not working currently and hangs the driver.
As a result, temporarily prevent sending the Remote TLB shootdown
messages to remote GPUs for now.
Additionally, also temporarily set PTE.X = 0 for imported memory.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 4e49ff0be6e35..8d767a91172ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5032,6 +5032,10 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 	struct amdgpu_ualink_ring *ring;
 	int r;
 
+	dev_dbg(adev->dev, "skip remote shootdown to remote_accel_id %u\n",
+		remote_accel_id);
+	return 0;
+
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->shootdown;
 	if (!ring->ready) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 1468047687652..34d5767287d78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -613,6 +613,7 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
 		   AMDGPU_PTE_BUS_ATOMICS;
 	*flags &= ~AMDGPU_PTE_VALID;
+	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 }
 
 static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
-- 
2.55.0

