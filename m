Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351AFC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 05:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F2161CA8
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 05:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F2161CA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738BC6E80B;
	Wed,  7 Jul 2021 05:16:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A346E80B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 05:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY22x434OuM1UDwalA0Q3jrVTOuMw35Iig4y1dPEz8q758pEiLKz96RHN68qmAejp0l8F+HpGArrE6QB7/r9nEfLPq408WOPJ9W4jJbxvHZc4nPsA6b6N+rIZ0HHnlU7NyRGnXe6zv+z3wUbTnhU0taSoVUWpMgFgoPkiqu3S+sEWtDwuPNQ9ZHXNXv6irRNLNoLzDTLy7flJdlzTKXfnF8JNbI5yANmwgrhMffjV3FqbALszch3AlqrROD9hRtJ/E4xAYITtKrTtwKROGEh1xyo0QCkdFYCSjpwba6pUb+lv9Oo5rTbkxC4bIIGjTZaocrF9BOp4Xy3kvhfzdkEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J9IW5ylWRHFL2bBOopge6Lacmvmj0b0y6n9MIeZ+MI=;
 b=NdycT/Xb6A0i+QtwKvs2r8Yev9nq/uZPikbcSPH5Fw6ytaosPnWHFNoK37UHHqePiSFjQdj8OSVaEKkbfXWohzbeInwgtrN9HWqFNusTF8XoMnjyUa+YuMPZude12MTZpxMuVdAVe/Wazx/VnDjR2rvv2ZwXdbf4PukoF/BzbtW4o1h07JLb0oDIEmVgTxruzvd3wIRSe2kEYgFpYXDwlsqd8ElZfdx3lAVL9hdvccJgIGsBFcaCjMVN6tNcKbolTorSTUT2um47OPw1G4IVgph0oyaIRDeK42BdKs922EtNoV7Sl91Ydwdvwuo5Bne3vKi8XK9wfk2XIgMaR9S9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J9IW5ylWRHFL2bBOopge6Lacmvmj0b0y6n9MIeZ+MI=;
 b=C3tcYWWv7L7V+d4T2KYD8zg8Jbsfeha2BctytFwGcK0O0KKt1S8ZZhjn7JJwjOMMHOhL7ol9Ee2Mq9KIymhGPsH5oBSj7UbWHWtb99Z2EUfSN2Kws+OEGf+vVQXAy9s7+Gtf8QhyeDAjhMiT/ECnhyPAKGgv6DLHTCxaBLO4ByY=
Received: from BN6PR14CA0017.namprd14.prod.outlook.com (2603:10b6:404:79::27)
 by BYAPR12MB2742.namprd12.prod.outlook.com (2603:10b6:a03:6a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 05:16:53 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::6a) by BN6PR14CA0017.outlook.office365.com
 (2603:10b6:404:79::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 05:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 05:16:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 00:16:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 22:16:52 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Wed, 7 Jul 2021 00:16:51 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5] drm/amdgpu: Restore msix after FLR
Date: Wed, 7 Jul 2021 13:16:42 +0800
Message-ID: <20210707051642.26704-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fc07d9-edf3-4458-b3db-08d941066e7b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2742:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2742AAB7732A7AFF0413FB63F81A9@BYAPR12MB2742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hb2cdTp4RrQAL2vbld3TXsM2VMD6n4fHQzNYmfrna9J5QMrC94W0hsYp7sWlX107UXT7vPmifcrZFaicfUIUHqwXC8Iz70PoKzb+JieU0C9DxXJfrP2fwHBMYatdzEq56aePuXyL01rEaSYrHi0w9RcxBQKINyaJqBUdyJ2zO8EkBqEGLyPm/jNW+foxOmwcY/MABXG563gnrjYAOp92M+HPplEAI8yyw7aUuayWTGhMYmW1crNyvZaPA3YRgecSwycVAx4xYINTesGha4bxj2KCnlJfZD7o0+2cnQIgYeL96BtXAGFfamgTWstNcfFFbYpo7qB3TkVZIZfAuaepGDMyefR6eUorOdo5cFW8EXlsyxE+ARvaMC/QNc2NkUx4IMoyCRzSnRrhHCaHFwqjfTZKPoEEkWUnbwbgyGdHlQeu3ve2afb7/tqEGReiN0MwvS846U5hKMMX9d2G/yr9oM28VV1jUidwFEsQzZ8VIL0V4PkzRImUxrY562X1jL01PnK41r4GbFRFVPRNfyMBD21U6Q/fSmY5mpqTGPhopRIJpCovaVxmIki6nZRoct1aGu6NJboGWQzj7nUeeZ1DyVPqLVlCp08hvnxjYBWl56+sp//uBs06Cx0jl2PpPhzVoTIVlaoRNlnlVfsPHkdHE7UmfuEDcXVNWWkQi8YJB3GyB682X0Y/S8iMfOGOnoeyGY9oldMIRxj9LLSIieCu0Ks+z7G/7zKslXUTFumVEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(426003)(8936002)(83380400001)(54906003)(356005)(81166007)(47076005)(36860700001)(70206006)(316002)(36756003)(5660300002)(7696005)(4326008)(336012)(70586007)(6666004)(26005)(6916009)(2616005)(82310400003)(82740400003)(86362001)(1076003)(478600001)(186003)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 05:16:52.8326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fc07d9-edf3-4458-b3db-08d941066e7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2742
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 90f50561b43a..dbc0e5bb203d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,21 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+static void amdgpu_restore_msix(struct amdgpu_device *adev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
+		return;
+
+	// re-set MSIX when VF FLR if VF MSIX enabled.
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +573,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_restore_msix(adev);
+
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
