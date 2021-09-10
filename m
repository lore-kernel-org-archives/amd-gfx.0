Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA215C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6038B61026
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6038B61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7EB6E158;
	Fri, 10 Sep 2021 14:05:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292986E158
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 14:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTaU9efZT4Oxy83l6r4DjRRNyabn4tzWIjIg4RkT6zPE++6ZxPNSZyGx0/IC6b3vqY3lt0XQS9t3a3L/7CbeVUzahJgKc8Ob7/v0+gn1Gp0naNU+2rhn9p+awqbRGY0o/h/dhbBMVy9G4IhvrJi6cdWneF1z1W2d44pOY6KE7vVwNkU3LHmT9cOjlIKvwesX5I3e7l5DwktjiHXUD4j+/wCE9KXCGnn99bPMD8FwaMyu+5fZs8yxI8gpwBcEeyTuXZwM0+YnRZSOQZz3neWccHrN0VIlghkh1T/6ctCbERTFXWWMCiyGVLS2z2xrOGz0bP7E+N5PFSrVAI7XesDdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=N670FVAATljZC0IR+BsRw3827RzCC8jeXvuaOkzpsNk=;
 b=GCvnYx9bp1uA74NLbyhfmuPKHo9MDmRAiTvTz0Xzf7DkeVoSvRPtAmxDquL89LLjkfBWuG/0+BnHPSZp75QOd5prNFMqVECw/TK91p3WTdBKx29dXtBKq6kkatXhQOTJsHBvYWRXASJc9F2N3vyhQH6scvAcIz+PvGmQdGuYrnek1XpgXNK3P9cVVh8Z9SUTIE0w/UA1gVgGCA+z/3XqStwtf1GmTZwDddSG8F+m1vOzw//lNWZas0xU8Xxyu5YEINpS2ha2sv6nTLEnGCkAqqJV8SyGG/AYDvUxwd8Sf03QZPnmfHO1RpHjUzLMznjQL8DNNQ4ozaRrwcW7qtP64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N670FVAATljZC0IR+BsRw3827RzCC8jeXvuaOkzpsNk=;
 b=G3MbrMf/DfBQIdjdFy0gxM85sbPqZpHtzNIsa1dJ9x0phKkPvbcpUiO6NtBczlqNSp5ppMXYnwzNIcu3+HR+sa0RBLBjCFISn75GlwxF6diQQv1wn8ZH+BoVHmAB77eXGc7ia46TJvA/fhYvhPx58ESpVmUBt/q1MF1MF5Tlbsw=
Received: from DM5PR07CA0145.namprd07.prod.outlook.com (2603:10b6:3:ee::11) by
 BYAPR12MB2791.namprd12.prod.outlook.com (2603:10b6:a03:61::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.24; Fri, 10 Sep 2021 14:05:13 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::c2) by DM5PR07CA0145.outlook.office365.com
 (2603:10b6:3:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 14:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 14:05:12 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 09:05:10 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu:  Get atomicOps info from Host for sriov setup
Date: Fri, 10 Sep 2021 10:04:57 -0400
Message-ID: <20210910140457.26887-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d025436f-27be-489d-5579-08d9746401a2
X-MS-TrafficTypeDiagnostic: BYAPR12MB2791:
X-Microsoft-Antispam-PRVS: <BYAPR12MB279184F7376E44A71CF307F7F4D69@BYAPR12MB2791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aPnm/olBx/mbLznBZ+sIp6wSPwoxt1iVL/RibVYWRNAt9TnBfqgCgLKJdUu1lmirTTiEPG5Bo9/gvD18LCY92j2XTGXdwqBFNQnc21cz1XWZt5Z5jtNo1nT2vBaOtVmIeL9dGKesf0VJIcEuDnxBGFtATLVwoErNWuFjUeDR5+6twAMleu5jZOH8PFvguB6nbdUBEXDYfdERg+4IkyrRy/uV08fBZbn2hu3+I6Xh7bU87DRnhOp2pAgdsolWjiESWmcWacmSyIWRVQGHdY6M01FXxZE/xmlQap63op6QWgpXQ5XycamuRMyn7kQQKEp0zGKJqVcJAqU7R2T4nzslBacYQLHt0szl2D9pUg05IGx/Kx68aHSzCx4a+KwQ2BF/dOBnMat7lDqrRAhE1MFFzYQqEKGqn6RR+bPRo4PqHFMSCb0WLz5haOSBPNdnaWvy8wK3d9a3oOehQ6IuxdioOGhMm1Vl5Qwd4jt3iaZrL4y8mXjtjtib2W78ERmH1+QC9tZwW3e9kgVEWda9GQpcmNUt0aTM2opKHHDNGHY/fgDp/fHPQ6AS+fHf9sfIG3Q1/jtoNk605ogBnS8Q4sK/Lyk34RrVvkKJjLesvOnoVDg/d77B9epvkQECt6pylycxhY0nQ1VzFm/miI9SBFtm/HPkfvHABWIznw5ZekEAT9FTrg3d+nVlUMf3B9wUHWRtxiHUjp6HJB46nA2ZXWd2GDNHtMEO3lWboKm4qOTbXr1PXY4FeWJZcSTiKoV9Fp0isJY3uGo8iFFq8MZjBCEXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(336012)(8676002)(426003)(8936002)(70206006)(186003)(16526019)(36756003)(7696005)(2616005)(70586007)(82310400003)(26005)(47076005)(83380400001)(478600001)(86362001)(36860700001)(4326008)(82740400003)(6666004)(81166007)(316002)(5660300002)(6916009)(356005)(2906002)(1076003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 14:05:12.1585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d025436f-27be-489d-5579-08d9746401a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2791
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

The AtomicOp Requester Enable bit is reserved in VFs and the PF value applies to all
associated VFs. so guest driver can not directly enable the atomicOps for VF, it
depends on PF to enable it. In current design, amdgpu driver  will get the enabled
atomicOps bits through private pf2vf data

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ifdbcb4396d64e3f3cbf6bcbf7ab9c7b2cb061052
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 25 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
 2 files changed, 17 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
old mode 100644
new mode 100755
index 653bd8fdaa33..fc6a6491c1b6
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3529,17 +3529,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
 
-	/* enable PCIE atomic ops */
-	r = pci_enable_atomic_ops_to_root(adev->pdev,
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
-	if (r) {
-		adev->have_atomics_support = false;
-		DRM_INFO("PCIE atomic ops is not supported\n");
-	} else {
-		adev->have_atomics_support = true;
-	}
-
 	amdgpu_device_get_pcie_info(adev);
 
 	if (amdgpu_mcbp)
@@ -3562,6 +3551,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* enable PCIE atomic ops */
+	if (amdgpu_sriov_bios(adev))
+		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
+			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
+			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	else
+		adev->have_atomics_support =
+			!pci_enable_atomic_ops_to_root(adev->pdev,
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	if (!adev->have_atomics_support)
+		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
+
+
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
old mode 100644
new mode 100755
index a434c71fde8e..995899191288
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
 	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
+	/* pcie atomic Ops info */
+	uint32_t pcie_atomic_ops_enabled_flags;
 	/* reserved */
-	uint32_t reserved[256 - 47];
+	uint32_t reserved[256 - 48];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
-- 
2.17.1

