Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618F3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 15:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A9C60C40
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 15:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16A9C60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B7F6EA14;
	Fri, 10 Sep 2021 15:15:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB7C6EA14
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 15:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddQQTOFK/+vdfYjXj2XgCBjAn6wiR+bxa8lmmXu3hnNCUSL8kFb5zWIzyAXPIxQ2t9AUdlRaZSSx2Ci/eTtI5UdqJ3AA0NWc6ubGjJvYCVuGfzndsP2+yrF1+h9FPxF1IdN/w8rcqvLrlX29NXr0wWwYMJyQOA7mMlHCeXSqeD/9sLEc1LMSf2aI2sGikCt3XDfydFdKEtCEJQ/PAr7cIBkQBEvxdICV9YypJOGJqMkgzXwS193Ogr9mYJuSMxr7o6xwydWqRgQxlX45xkZosVGQ/7gcn+O6ZB6p8WAw/HXlUt8u/6WkrAa4fCEjAxjpWFCMim7SUPHsDviMbCqsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6tpPj7Jd5xznROvjXm400ZFiR8DnYW9Xy3PnSB5Dsaw=;
 b=BHNvyxdqONMXgLD85bIL+B/A5Qlkjh/n3B597CZK3Rtd6VfDVuf8pfHDtgSycuEGKUWzF4QsEFSlnD2JG58pqZC1dScdoSBalaM+omD9ce9Jw9liWmIcl5z7aGBJxmnVzHGYNlXVv/V11evD/mpNZGbdezBz6XxOOqffDY4t7Fh6GNUfAPFbnGGnxtdE+Zzu5lj7DqXSfAqN09YAwx9xa3cwK+wpQSXhhPdGEV6YDhAbKI8oL+80qsQxVD9ggDLcgkY+sORM9kIr7tXJoq8j2KWoiPUD+ACuC4S6qhRXK6wyQoaVAvz7clNAqvAvN4zYQpxFSjmkJAKAwHSo4baH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tpPj7Jd5xznROvjXm400ZFiR8DnYW9Xy3PnSB5Dsaw=;
 b=gFiFa2+qDGvSgytVRJp4RI+r74vyCRcBg638nqU4USaG76HnFYsCZKhzepiTkEema5Tz9R/Scoa+ylt1mEnYaogAtthAOhVwb7Fyd9Va9bhMxXMC7k557ejyhg+RcKSI1ZlD52zB3t+SEpIIG191xCjIANoONRJfpnixGfU+0ng=
Received: from MWHPR13CA0027.namprd13.prod.outlook.com (2603:10b6:300:95::13)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 15:15:30 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::44) by MWHPR13CA0027.outlook.office365.com
 (2603:10b6:300:95::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Fri, 10 Sep 2021 15:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 15:15:29 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 10:15:24 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu:  Get atomicOps info from Host for sriov setup
Date: Fri, 10 Sep 2021 11:15:13 -0400
Message-ID: <20210910151513.3490-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adb72fe5-eb1c-4caf-a0bc-08d9746dd388
X-MS-TrafficTypeDiagnostic: BYAPR12MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR12MB328825BCC0BC42CF0C0DFD14F4D69@BYAPR12MB3288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3fDJ7GwHnzKgu3M1fyZt6Gvhsu8YYaN6flkzdAswuTMpbOXs9yvxU6XeXoCbBEBjDxaLnUxrJJREleCZaaKA419iHad9Hjh841wQxS/UxgFdxDknYALH8LM+rdQnJXk1UZeVC37M2aZweN8gnwmJeRPnGIkSIZs3SNL/Jkq++oE8ydO5WBtc9kZmJRuPkfEgxJYnvWGQYi3KO6A5E6sQs2o5PDTio+eFlBMMRHrxjj5ItCKMznobr12f7z606A+KoM9gqw3U2jDYDkqc0Hwe6ScMLpxKICKKkZkcj5s81zs4oYfQxNQQbV8pcgdrwoXRAlIHHfwhK9S8tVJbIVY9YiSknrzdKpbl27i5iDEUULvBg86pbbRw4wFqHaOzxoghs8nKTxziTkx1vb67zoko9He4SdhBTSdwF4dOu0whq5lYyO24jmeZR04jxJgusrpUtskzFhWFGeoYwfJ5/6TrGbU0gaxil5Awq1REFliAG0QNF7hgHEl2+Ok8f1WKivG/mPI71zvN2Dqw7l8yRd/fYZ9BoTKKsaGpkm23kRJNO9qhdErNr3cW1xlDbOuPJdvw4W0V5jCEZjdRkJQtRKOvhmU3aN3OGzbZZU1gHiNfozqwzXK1GYHzUGkQyFOqefuA+jOxHuZ3Ey9LztzG783xl/9ZtG5wyNQQhPJ0u3VBhWMJotdotNEK0dgfaYcdFrRhp63fCafgkB4NFlOkBoEEf/vL/2j3BHPTs6ZfTu3mq3BfRiwmhw9hqb5dRZdJRig7WwD51lnldsTCM80GoYk3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(26005)(478600001)(8936002)(2906002)(4326008)(16526019)(70586007)(8676002)(47076005)(70206006)(82740400003)(186003)(5660300002)(6916009)(83380400001)(1076003)(81166007)(356005)(36860700001)(2616005)(7696005)(36756003)(6666004)(82310400003)(86362001)(316002)(426003)(336012)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 15:15:29.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb72fe5-eb1c-4caf-a0bc-08d9746dd388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 653bd8fdaa33..3ae1721ca859 100644
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
@@ -3562,6 +3551,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* enable PCIE atomic ops */
+	if (amdgpu_sriov_vf(adev))
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
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index a434c71fde8e..995899191288 100644
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

