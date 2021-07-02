Return-Path: <SRS0=VIdG=L2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EFC11F6A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 03:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5F3613F2
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 03:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5F3613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5D8898EE;
	Fri,  2 Jul 2021 03:23:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9E289612
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jul 2021 03:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkU5NujTo+dkbB5FQBxg/kNOeo1haZkER42WBytDJBefQ0sznXElkRJVZCW8n4ITAjz/8qRjSu9MeP+6cZksrP9AiCn6Ccxy7sCIKX+JCsjda62eXEz4e2e1QiDoKRsBuUJqyIrL5FkFEzhxFd25FeExM8HBk5TD/Kx7yoxP7MH2HOuVqYyqvsw6WyxA4CAQduNfHD6MPFnPrIHsdpS2N8EPFvntqzlJmZrggSJt9URAGJ79gMAYrQPFsThPKSu068xJfOrGzj01O6XfRBO/g+v3Uip39wDb9rHsggm0BJt3djTV2dD/IWCdSOgCvwJYuDBfGAb1rhiy7CK4Zmas5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUih/CGChUdpNAh+z9Wsx0ufM2CAxf7NPIxBr+E5qbk=;
 b=cS/37cTVpKhGX24i3qxDO8iZUvP/+WF9W+0emSckZ4lo9GgCeqb360wgBBbX2jd9xhkfyNizrdr/aTx3oYfKqxyPPW7DANSNr6xdnAYNEfc90LsXfK+SaTEjoPzFoFuirolBuivTvBxPwhTg3il98hHbkrFk2iNKRdocdDHMXrOVW5QgJ9YQByRtqXL3jJESQShpgOlxGuW+xnp5ADH4FkCxltCpkQAkvMei7x0OXWnGZ7mBGQdGTKfF5ZSbUZrbwqXhfgoOFc4Xj6JP5A5EAV+Y2UHyzHbgdqzFVcbbNmuESEaAzyvEV6yjoeGX4XLTFDibi/w99/PvCxSnzCWB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUih/CGChUdpNAh+z9Wsx0ufM2CAxf7NPIxBr+E5qbk=;
 b=ghryVobF6TBedZbSIU0s1HvILzkm5TmzMIL9yAgemCXxJtR9r3akEkqvng7XOok6RMnTj5ct+W4hxIdnwAqronDdLm9aAmeIycLVQe7Maq9bLf8d2sh5QJrZ+oIcw47nEnpXO3drNgmSTl2YN2JNExapcSUCftiP+nx4zKiLY0k=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Fri, 2 Jul 2021 03:23:29 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::78) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Fri, 2 Jul 2021 03:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 03:23:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 1 Jul 2021
 22:23:28 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 1 Jul 2021 22:23:27 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: Restore msix after FLR
Date: Fri, 2 Jul 2021 11:23:18 +0800
Message-ID: <20210702032318.27215-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d762943-7363-482a-06e6-08d93d08c2ed
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30799EC744A7DDBDD443FF46F81F9@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZkD8XeXQ/1PHu3cLwdf2RDb2f7zrLUwxZ2gHr0U3yk7U5jcs5sfMIUwEDT2Wlpf4BvMoA0MFjRjkasUAtoBtlqCjedlVTrhGmjGYPnSqp6Hf1J1P+iO+yoD1EUCXV7pIitWAyJYSMfCD7gveAAwWAj+4iWKPjesy7Y66qND12n6QQsBe6wN/NXakVstcegrP8xr4TR0Y+pqY5/MCRAmospX4A2VGsytUBYyUwcP2XmPnxJSTk+TTc79dT5OF6bmiNARgFMNFD+pauHTOZvz4+7TNekUeIHO22XofNK3zdQa10piubsmRjMRpuJNVDAaIj/rcfTLbF5U8scrPMkaK0Ud/VJtes172ESwXFerdJmvKrxPtYuUXxy4jY/sC6MoY5lpaK0K/M0pGcv2FwNSehtoBxeLBtuqtMOeXyciG7CZCb7nCsaT413ZGopOs6QUFJaE0HXyMVwFY19vf+2xCULARF/FKzBnF++cgk9eCHlWYUtGGwhDCg9Eno4D9HF6LNGfbFNjq52LvDBDx493Y/zaWP8y0c0yrlaSndFSMEliPCCXAmu7lvQ6Rn8n6+nILF8JB7BSIyBaw9UGwad7iWhVAZE10Ylcga7IliZJOSntDiJzF3AVfnrlElasRNhJD/9sAG9JpDCguGoUUJ+iUjc3Bzix4ubYzCupDDx92zgS8pcfEbEIYuiGTntB2ms15XxOWyrmKd3mcvNCbUzBnR97/XlQDniIDWbM5mpocr8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(36756003)(186003)(5660300002)(26005)(7696005)(6666004)(82310400003)(4326008)(356005)(478600001)(426003)(36860700001)(2906002)(82740400003)(70206006)(70586007)(2616005)(8676002)(81166007)(316002)(6916009)(8936002)(86362001)(47076005)(336012)(83380400001)(54906003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 03:23:28.7972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d762943-7363-482a-06e6-08d93d08c2ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 90f50561b43a..034420c38352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,19 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_restore_msix(struct amdgpu_device *adev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
+		return;
+
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +571,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
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
