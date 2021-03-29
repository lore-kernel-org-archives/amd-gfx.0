Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CA8C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7662C61936
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7662C61936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020686E296;
	Mon, 29 Mar 2021 07:49:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE536E209
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 07:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn5PnSWglRkXMzbdB+f8frUEct1jSlBkIIAodlIYMUqxMk0a5BHhbB+ixwSvi7XZvHpK/Kqivo3HvgE21xWdwYpgI/BaPYhtsIbXGf7G+sQ2wtrRtEoiCuSc8slmkHPRsoSgHqCHwRa4C3yTJIPfq9GPn/9u6B3ob5jCPDfpw21ray12ni3xOA3AxWBx91isxHlq/Q5Yut0E5VDnyptL+kMMx1kQCxc1QtK0ObuIyzfUPFaR2/wfoFKgsuQqfltkKcNy56ZEuLQBcmAFKe//AXWyu02E0n/zEDPlkSPZW5UWQ/m8SvleQFJwClN3uiAuXlJ6hecIy+z/FGVm61vf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th9eqEWR7rmejIIo2h9QoCQCUuplwfNS0/YvbpJnBbM=;
 b=iMP9u5kXc+KqC/ZyJmboxeVi7S37mpCfuqD6+JngkXjA6svOFyaVHxt9AuSUbWKEp1zx+MNC0o1nI/yQoMTq8PnBn9mLFInKuuCV58VIGchqC6Q1j1sxJCUM/BlrfYFo3McpmdNQNrnZXIMG3aG3B1bzAG+ieL2/RUJksdJtHIFXx8jkPBHsmLfMBpSpsdobD7qPUewbpg15VZGmFc2S9pAtsVqKmK861DK4SW/Jekzkf8flQWKZbXExWrfvXpvkKCudWkIMNRLyK7a6zPU2qCkCkVhC4tjql2yhU8iT2+zVgsd6A9vvGTz6QdxFjBd4DFsCiClqax8vbCPCCjkSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th9eqEWR7rmejIIo2h9QoCQCUuplwfNS0/YvbpJnBbM=;
 b=pgsy40umh4YAdYXL9HTDO3X1fadNm7nDqaE4XE1G0v2WFvIe2Esblws+ggVwm7gOE6uUVRtCRoeCfgzCO6lUJUTBIDiTbzrR/0NxP1lsHUe4fTgg1FVU+rNHaSg+wV38G2fpbviPjbDOIFprf5UGMpxdHiAzuIcMor8MFC/rZvM=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 07:49:51 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::3c) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Mon, 29 Mar 2021 07:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 07:49:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:49 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 02:49:48 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Date: Mon, 29 Mar 2021 15:49:32 +0800
Message-ID: <20210329074935.10822-3-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329074935.10822-1-Emily.Deng@amd.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd8ffc6-adef-43e7-84a7-08d8f2873bca
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5478B2D3E2DF17CC4775F2638F7E9@DM8PR12MB5478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjRJHrTL129YuEMs1/78Mnt0XWpaiw3eygHu4ZI6HC8RMvjbU6FXqLIayGA7FV8AigNNVdGSGKGoVhy8HWrRZ3dNmrActpMJwikQz4jBjHX2TUQ13qAvf9yQdqlWsJldocWsATjbobzva4NviW4h/U9OJJD3dIJk6AAr7d7WvgditbWyyHsNlGuisJkLR38nrIO8sLfqiMmAkfDFE5OwGFMQqYlPV++RlT+nsd3vBV98zIvg9R7+QXfQbFOK9nJkKLQH6479CmJJTsauCS41Vy0eMP2iEEgXnZueHxThX5hOopl2OjzrLk/pWNWJBkwgoQzQabEVPGoSQM4/KZU1+Q6eV9CoBzDHDW/VFK78U1tKRhzwvU+u64lrqA8Jl3q9UUnZqqxsYT0NRlPGs8Yo4ryH3w06ElhvgKYTupZskECtO8W7+cAm9Yx8+3bKGpI6C3mr8elbXFzh6U2FvrIHtwWEgnjXIS4boBvhVnRjknCq7JK/QTQGtudREb4idH9y3rzoAV+NLzt2ZowU5uL0syRP4WA5jUpmLoQLKj6vDEtLetx7/mM6uyq8qxq3vOFnWLTNAGiZEFv0bwtKhAbZhSaxAEb2TIgpNPY0r6UJy9p9X/nclPuwNw3ehGekR6XET4S+hd7tvjOzyMX9u2zte/cnJkwek366yfJk6o5fgbq8PMoNHTWziEnxJX+xyXx4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(356005)(81166007)(86362001)(426003)(6666004)(186003)(1076003)(82740400003)(5660300002)(8676002)(478600001)(336012)(83380400001)(70206006)(36756003)(82310400003)(70586007)(2616005)(6916009)(47076005)(36860700001)(2906002)(4326008)(26005)(316002)(7696005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 07:49:50.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd8ffc6-adef-43e7-84a7-08d8f2873bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..f24263120f3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,18 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_restore_msix(struct amdgpu_device *adev)
+{
+#ifdef PCI_IRQ_MSIX
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+#endif
+}
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	amdgpu_restore_msix(adev);
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
