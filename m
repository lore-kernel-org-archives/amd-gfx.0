Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F048C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73DA61490
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73DA61490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DAE6E874;
	Tue, 30 Mar 2021 08:14:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD1F6E874
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK9MEpdgwhTya776AR7IFd8NHG2NEws/CVH5E3apuoNxclDjAj+U+U2VfpUUZO0PGjlSBXlxuImQ0B9iy5idx+iDDIBVLHkECKozNgYlK6vk8xAaFylhGFIIc82OFpZn8uXqSsm8ullMC/3XhjzLiCI9aGo53Gk03H+Z2TK1tPYYKmZyfH4HUNoYJE4h7fDiJBAcW5s+mMtzwpad1rET70Aw4VkZJQnB1eEkSAoGxK/pxU4DsXUQbQ5COMlPdWpuOn4PunMrrPcmA3hmaHW1W/dJ0dIBrvCBB9OavPsGNJVmQiGyFacN5GOhwCbdKXqthMmtnLJA1ti8CG0or+jhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdk+DzRyv2aYxrk8Bw7odc1VnArDI5gTFjFsq2fNQLk=;
 b=Q9PHb/dZFfUthXr+CPt1d8vS7SnPevK5CB1uWdS2JV88+4BMpHnJew+36ygi9tyQCpKwOe+y1FcQZ/aExMKDZWJBJ7bb/rgHjIAE9lD/nWZZ9CgF/2aXNu1ZM5suR5/0/tvAVWXgz+LhET0jN89nD5tnQ3Iq4ify5MGBknPELDP9ISJ8o1c5H+rjdgJyAPmuw/19qpueISauhvd0XFFBBGaAnwhVcV89aV/eZRMrJD5ht80pBjMuzzAy5fLEZBpN35icEbL2ZE6HL/gqanSTCQut+mn5RxbFiS+dmwbz1+s78jaH6LvURxJxT4vRtUuTgFRFvUsZC/BAiRh7LXXKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdk+DzRyv2aYxrk8Bw7odc1VnArDI5gTFjFsq2fNQLk=;
 b=FBdSfm44cJbzLxY0PBhE+/+p0dxGeSADxoQIOKX8bwL1BG+4sSVWpifzgfMSb5/f4+BKuErObLAakjlzJ//IUU9WoU7utVdCACsMdw1SocoLRbxXha7594Ru0xnxqGSpDjC4SjcxkTPmEpQUYhfBT8+fRrGlLbyHsZMtThQpqEo=
Received: from DM6PR14CA0055.namprd14.prod.outlook.com (2603:10b6:5:18f::32)
 by CH2PR12MB3909.namprd12.prod.outlook.com (2603:10b6:610:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 08:14:46 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::f8) by DM6PR14CA0055.outlook.office365.com
 (2603:10b6:5:18f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Tue, 30 Mar 2021 08:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 08:14:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 30 Mar
 2021 03:14:45 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 30 Mar 2021 03:14:44 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Date: Tue, 30 Mar 2021 16:14:41 +0800
Message-ID: <20210330081441.61418-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6678914c-f8b7-4e9e-74cf-08d8f353e158
X-MS-TrafficTypeDiagnostic: CH2PR12MB3909:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39099B83FD255933C1A71B6B8F7D9@CH2PR12MB3909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 207nnorb7M2AJI1YIuoU5MfJfsOqoLreFiPaX0XcwlFLiZ/sb9SeorLhKV19qfQcYf/XULRgqeW8vLbCHFCKkdC0wbdQeTIQE+mLKZqoW9mfnHpLoUdcroqOSz3Thb7xyYpMnEZhMhKajJCL2+99VEunjC3n7KMcknoHCIS63T6ram8a4QrknScq+cIGqS8keSFEgePgaTBpIToaU7X/umNeNrOcm8+fd6ZRhRxkzX4uH+eBeNDW2lkW3VdPtajc7LOb0DfFOpGnEV+gbhysHn1oiqPTmLAuHcCKLaLmWwWZdYrTVa0kq4u4ulJ8Ot4IIhgOewXuXqFEb+DBF6t07l59R1Qa8Ws7Gvzrsjm1rAngQwwliyHX419xtHXn7O7onQdkZyLB8qbzlr84Z13Hh+llTPJb98gyKOWLxaOUN0x1aY4/q//YuPrPZAoJZje0zfS6EEgoN84RUUURMs57ShydJEl1uL1B6YCGnSn5m92qfHFDUodsMeWdjZ4G2+XiFzO4obdHrVj3DAgMmbMvswMrZsg4y5VB0TmG7ZSrhLwuxbZadncCGF7QwEgegN/VmkFhb760FZRGvGPaijwKh7PD2RJV5wv2LU8yrkuYEuRP4HXdAdaZrWjXgR7ROUP4p9oenGq0fje/VMuK4WjzOyx4VhfYAqPBQAKUcqeAXei5pDQB92k3ltP7wc4ObBy6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(356005)(36756003)(478600001)(1076003)(82740400003)(81166007)(86362001)(83380400001)(70206006)(82310400003)(2906002)(6916009)(26005)(47076005)(316002)(6666004)(36860700001)(8676002)(2616005)(8936002)(186003)(426003)(7696005)(5660300002)(336012)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 08:14:46.0411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6678914c-f8b7-4e9e-74cf-08d8f353e158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3909
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

After FLR, the msix will be cleared, so need to toggle it for sriov.

v2:
Change name with amdgpu_irq prefix, remove #ifdef.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..3045f52e613d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+static void amdgpu_irq_restore_msix(struct amdgpu_device *adev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_irq_restore_msix(adev);
+
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
