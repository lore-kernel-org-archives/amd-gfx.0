Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F23C2B9F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 06:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC0F6140E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 06:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC0F6140E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620C46ECC8;
	Fri, 25 Jun 2021 06:44:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1006F6ECC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jun 2021 06:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnoKfOy9fd0SJ/1Gnl8lG0lgJm4XL5x+ypKtt4am7exeDSVnJp3h4u5IsQ17APV1mcW1AITahF+vjfR9WdNbyKtPvTce/Ngqk8p0uCsMytDzesVtHrXplSFFjGcA0E9hg2Ija5mFv8hG4zpxrwndozljwUcvX3LqxYF9dXOsWl5Gj7haqYiNwynB1UxVNS+nLJh4zsz9T3SnhRXgMl92rujqeS9j2zWas0gUupie8SUqc46X3YtAYETdy01ENRthAzF4/Wu6+D0tNRDQMkceKksL6yXT6gsfipjokFvRdNtulBheAwb0aMw6asXO5QrpRgip594Dmnf7cjLQYx9x7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghCgtUQOPH4z/yyBNsPK8ekeOcZMXg35muDiQrLNiHg=;
 b=h4acEhTQhtiR7PYHUNA31qtxDJPOGGP4kC2+CRuVfZGhwZHBiNN6lg5lV+rqCpZaXZvHqF+TsRyPYx3ftQTisOLzNx9GqXPu/zQ5s2VGAewKPtzBFJbKyfs+9J/fMwMre/FAotAAeXDVlc2em+nGBG3McPy/raloDzdUszXFCJM7UWR7VRG1DHxdU9VoZEUOl0allIwXWRW8CTB26tZnovHwx++NljiPu1z3UTuHoYxUeyChUlbn+rlOy0Wk5fbYqUs4o92Bm1uIR4UpIaPz0Fd3a+Hqr1lTNUSSdAuz18MyUKg+Naw3yjKx1k2WEGH7rL9AvNSO9tkvjgrYnhoWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghCgtUQOPH4z/yyBNsPK8ekeOcZMXg35muDiQrLNiHg=;
 b=tRmULsc7mHxq4falRzRPtukaiXlXS/fJq2o3pUdbhHPjkZ3oA/TOYxeORIjum/UpOMY03S7fw2JhNKQCQ9fVFdD0Lwzpl4dLiIKZd/Sh1M/OJCfHtWd26WmauZik7N7QksoUqgbAeyjad23OxK3heno+soiouMvzoWwVWI1iUIo=
Received: from DM5PR21CA0018.namprd21.prod.outlook.com (2603:10b6:3:ac::28) by
 BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.23; Fri, 25 Jun 2021 06:44:33 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::6f) by DM5PR21CA0018.outlook.office365.com
 (2603:10b6:3:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.4 via Frontend
 Transport; Fri, 25 Jun 2021 06:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 06:44:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 25 Jun
 2021 01:44:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 25 Jun
 2021 01:44:30 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 25 Jun 2021 01:44:29 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Restore msix after FLR
Date: Fri, 25 Jun 2021 14:44:22 +0800
Message-ID: <20210625064422.30590-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 847f2f99-c711-4a00-ec9c-08d937a4b07e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5292:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5292309087935695C55300ABF8069@BN9PR12MB5292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: op96XsA7V/PoFxBSkBiEdBfc/I6xUh3EYoeUNzsV8MuhDQw09E+WKanF0oZxFrG56+SH7uJ0Nqv/vPilaN7RhZhfTYN7TbPzC10hx5SGh88bLH6QXLYY8RoUub+zpyBY3RSKwYF8t9odS1W0fy1ihlCa7CDLW6wq6L3GtN2A6vOqiZrt618pU9/f16AFKXxJzBlm2HdeLwI76oZjAcLiQrBhTNsiLIj/oSefQqWh2nF97yYiDMh87We/XnjwF3t+vzbkf5o9wDlV9kifAEZrphP2yJ2znV7TyKnBg8Ig3FS1o+acm886AqKHmmXCY9Li4J7PHJoztpHhNfEDbcj8MYoVGeFofOIi6u3JVElO8ynD3Mb3KazLdHT2EJ/nN7YJKmvEX4115wkMhNri2VopgN+mfXaNzYh4fTAA2IFVW9jIko4D7tCn01AaKdaTX+PD9wRMYT6urjjQMwfd80jxQI8pQga4CF2ZKYSfZlqFNKLVizndPIkIJYWeWpHTBGCQkgBOi70sG1e4IewB+/nIc7y6X/Ex+Cvg27WS4hCviOxyU/g4WulQc/RZwR2TVrrB4M2JhhDb1LCpZGAThPuOc66g03RyINgJ7B0RvpuiTLfB1ji9YtSjqy2OQ7h1a6ytqqnB+3gUxO+0zqGOwUSP85Yz59/tNnTLa100Yec7QURJOi7W6I51Z9NUbLz2aDjQC22xaksCCqCHSs5vGjvzl0Jpx/bjw/0171OwPDFfB98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(8676002)(6666004)(7696005)(54906003)(426003)(8936002)(5660300002)(316002)(2906002)(478600001)(70586007)(70206006)(2616005)(336012)(4326008)(1076003)(186003)(47076005)(86362001)(26005)(36756003)(6916009)(82310400003)(81166007)(82740400003)(356005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 06:44:32.3768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 847f2f99-c711-4a00-ec9c-08d937a4b07e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Emily.Deng" <Emily.Deng@amd.com>

After FLR, the msix will be cleared, so need to re-enable it.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 90f50561b43a..26e63cb5d8d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,16 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_restore_msix(struct amdgpu_device *adev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +568,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	amdgpu_restore_msix(adev);
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
