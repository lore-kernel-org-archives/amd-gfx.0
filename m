Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB97C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 07:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D463860FC4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 07:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D463860FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9C688EB5;
	Fri, 29 Oct 2021 07:17:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7AB6E9F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 07:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN9ArnLZzHM2wYzkB6lz34zVqStxsPWaqEcz6D4JDlmmh8YOShLTez3MSQvDPGvrz9S54Ni+1883GZjXPeELcfucC1AkUTBulZyAZfFxaQPYdwfM0Wdua5OHG/grE6O8BAlEEwLhOU4/R443XhU30wNhfex/0bH3SUnxRGFVHjwRazTKOYpfn6JwokrOJ+UMgpQruk/a9BmbtVEEhFqmB45ooeOvFS6nPS5FaKC5PWBaXBDF2W0Mqf4BI/CDrX74yc9ohxylUujWXIX8rDbzf1CkFLa6K8ELrTsdYERgHxEuVsxgsv3bDiGppXUtUor0sfly7NtDJE5G2/lqu8XFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3kxexK1Fq6Tamp0w2gJwTHcp6YpYlFNo/sTVpzoClU=;
 b=g1gEXEM5c+JM4G8vqQKK9wkhjrVaEknI6hYIpJTLlZNbxNb8J7CT/SNitwrpSdrceXfRas8tYdN88zdkcl2MKH7RsmwgdnyPDohNL0BvNtSZ2fiPUZTYazJ8huElgaUZlbv5+xk3syeNl0wkvoob9VNin3zR0/LekqG423cfywGhuqbwvwGosX8vTj/aRKONx/gArQUFySSOgcxj1Ay3yOokhstO6myGar1legBvSxGEUAQLqSrvIWclJj9fAAh1mXAN3VXcY2K0OClUN+RQkFJS35o/53ltKMxNGCAR1f6fShEF5g1U4ipBlETDZ1t0TFxOu7VP9JxOeHJbj84O8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3kxexK1Fq6Tamp0w2gJwTHcp6YpYlFNo/sTVpzoClU=;
 b=LtG+p/bHjvChBiATc3N8fUgecNlBlLpJPQ0ifOWQ33nHbHi4uofHAiRHnFPChQCqzYR4Kl0iXdK390uPlpcPgoyxQ2xIH8KdXT0IdIoQvqWIiJqfTswuDW0y98iao7rQ/QF17ccSpB8+lrlfBls0sKBXupqbkf7VF3G7fqQsUY8=
Received: from BN6PR20CA0062.namprd20.prod.outlook.com (2603:10b6:404:151::24)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 07:17:20 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::6d) by BN6PR20CA0062.outlook.office365.com
 (2603:10b6:404:151::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Fri, 29 Oct 2021 07:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 07:17:20 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 02:17:17 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <frank.min@amd.com>, <lijo.lazar@amd.com>, "Oak
 Zeng" <Oak.Zeng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: use correct register mask to extract field
Date: Fri, 29 Oct 2021 15:16:57 +0800
Message-ID: <20211029071657.2013815-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fee4e9-e168-4ff1-ac71-08d99aac25c0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2509BFBB1F95D878F8E9239E82879@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kvxo/UwOVEkL+yhXbwkvyC1qhZrHPHuvFeLvBfJ20yE2bsXTLa76vjiJlnxB/bvcKZgZviyiIXjjuOfzLg8wf96PU7+L4enzlPQShFr4fuMUEigEg0eP7+Ho3i+cXknWPLqpPvWZ/53lH30/XtdE+QbqqJzAKomjWwmb3WQ8UXxn09enUE0GpGvpzW6oaAwkxAlpCPUpKO0d3eWKZRdy4h1igfBjtUxxaFDvjamyz4VRFIgmNS30DEsSSIlHkIuvtzpJzKL4an12bMgeGQmV2ZX59r9G5oEFbQIDVjC7OVk4jkcUJCm/lzpwhbfO9T4x6B6pM6tih7SrgH7i4Vc3cDtPNPkVb0jpQH0sXQpiV8MeZhU6kBpqUYPCMRFPrNsnjrfIz5FIpxcQOBbLV29Pn8/7EbHL1Y1EyRd9ffUckPwbJrvT2fVvJJPKdxI9EEaunhdQnwfy7LfGgj/VXypt2p732oG1UObD8zZNP1hZ25M4x7GjaMT2eY/PPKY0rVesanL7BGf67tlryT0rhB5MMzHJSFw2IQneHyn5P+aWXNXAC1qn1z2ux6eWbPkaJ6j0X1nemNnYUfj5HA5+0F15P3EQrbVChCjGcTHStV/owV07/5pOCZlJaaGaQldHEpBWohNRdGoKGxdPE0MJ5r7LnUP9i6bl0I5mEvI192nCRrtpc6fgo+nU6O4aMeZpY/D1fHTkUD2TbI1Vpd+oy6NoYg0nO8W6UZzr6+pmdv58kvY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(26005)(508600001)(70586007)(186003)(6916009)(316002)(336012)(356005)(2906002)(5660300002)(47076005)(82310400003)(4326008)(16526019)(81166007)(54906003)(426003)(7696005)(36756003)(36860700001)(70206006)(1076003)(2616005)(8676002)(83380400001)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 07:17:20.7622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fee4e9-e168-4ff1-ac71-08d99aac25c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
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

From: Oak Zeng <Oak.Zeng@amd.com>

Aldebaran has different register mask definitions for
regiter MC_VM_XGMI_LFB_CNTL. Use the correct masks
to interpret fields of this register.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
index 497b86c376c6..90f0aefbdb39 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
@@ -54,15 +54,17 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 		seg_size = REG_GET_FIELD(
 			RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_SIZE_ALDE),
 			MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+		max_region =
+			REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL_ALDE, PF_MAX_REGION);
 	} else {
 		xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL);
 		seg_size = REG_GET_FIELD(
 			RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_SIZE),
 			MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+		max_region =
+			REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
 	}
 
-	max_region =
-		REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
 
 
 	switch (adev->asic_type) {
@@ -89,9 +91,15 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 		if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
 			return -EINVAL;
 
-		adev->gmc.xgmi.physical_node_id =
-		REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL,
-			      PF_LFB_REGION);
+		if (adev->asic_type == CHIP_ALDEBARAN) {
+			adev->gmc.xgmi.physical_node_id =
+				REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL_ALDE,
+						PF_LFB_REGION);
+		} else {
+			adev->gmc.xgmi.physical_node_id =
+				REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL,
+						PF_LFB_REGION);
+		}
 
 		if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
 			return -EINVAL;
-- 
2.25.1

