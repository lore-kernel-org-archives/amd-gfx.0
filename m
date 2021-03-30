Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CBC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9C861606
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9C861606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAD06E4A5;
	Tue, 30 Mar 2021 04:42:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6ABB6E4A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUzFc/ilQO6Nag5kUD7s2qFRSlBfDXUsoFOdw/iz+cNNL9FeziKdUI5bt7D4C9HBSo+pEN8ytJ8phCe7ObyVekeZLlirRs/WRf8KhFRu00V/7CHG1+ca/m3fGnhI/onVVDBm3SukuzkkxdEH5P4jnNkihCo27gcFlZVjW1Q4uYdROp9uyZmKabHTQXBnMRgLokYQ5y9bb9wQlX/geyK8g3LOT5G1v/U/OnUu6Vy81voahPqK/KKKeDIhq75/zQQWqVzPm13SICJUGu0KzQLDujRUDVztOcn/0eJUg2JKpSSCkZaIrHqQjBy4GJVsJEjO4QRIkCy4vwr+hfUBt9XN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNx+22sw6LohjrRqtXMdVurANP2TtLAh+y2rE490514=;
 b=fMDlCFKyYiy4DsRBQZwK7Cbrg1lXIgJ/pbwLIAc2OrA09GGxQWDOFVDuOfUjt3D+j7CRRbZIqjfkSmcTmatQz/jgkxBiR0ZmxMPS5UDJYdsQRWc+f9G8JorLjb/NIFPUKVJCplUZlpEPu3goSuPnsre/A+RsnA0jKReW9s37EvoS+5r0aO+oXWov8iqgYVikuXeiWoVF4QC75rVProoubocQNy8rwk8VOoTR4TioDpiqvu8fJzWLjjJbFUEcgUcmyVuiQbvzjfQMqOwOuFQl+rsYeDHccHtlsU3D3TmBGM3Y5uxGfgJJH895Gd4mTEcBok24rrNtBI4roMBD8++ZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNx+22sw6LohjrRqtXMdVurANP2TtLAh+y2rE490514=;
 b=US/et/dzbgc4afNQpHcpYcAtc5TNVGXeStEcxONqXLnOb52rVeX1n0hO9Q1uQs6wtLcY5/34fGcIh8sCIwK55VgeOxoipNvdqL0GVLVWyIhtbF+2Zpjv9pgu6iTtRJWl7u76a9Al1Ht79wIbBntWVr33jKrrJdXRR3QMla2HK3E=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by MN2PR12MB3632.namprd12.prod.outlook.com (2603:10b6:208:c1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 04:41:59 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::d) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 04:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:41:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 23:41:58 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 23:41:58 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Restore msix after FLR
Date: Tue, 30 Mar 2021 12:41:44 +0800
Message-ID: <20210330044147.57802-3-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330044147.57802-1-Emily.Deng@amd.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 057cf4f3-33df-4fc4-4df5-08d8f33627cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3632:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3632AC681028E606760A4EC28F7D9@MN2PR12MB3632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfYLqZ8vQBwH8rcdB4lNgnIA+ToWkEcYB6/ZRFQnCHePI0WpnZhIgYMoVHrL+uLPX802FuVRjq5PNP3N7SAKASpoi5IfTs9SnC1mYfFUBY5gKaZd1XaQwaPGwn+WABoYsD49W2Jp2OlueU3JRW9C6vlOiQ+kOQEXTKVqhaFHOogmiQQWQUOKvlU0rgQ7hnI2VJAmpiaQoCM/FSTIlaFNO/nRTZLvMJo2CQEiXLai0Wmsp4xdyna/ouuWHedsJTcv/RdYj9gxq33gC4QoXDnkh39rLkU7D/zUAIZlOSdoe5Pwu+UpmuF9vEQGPHk5sOiAnGcr8xLYycO3NX+vK4uKmiSYpLGEExV9e/P6QSiZiSaaIeo/DyFz52VPQenX+loKrKcw+ZQhNW4STsee4HSh8C/HFRlCW0Tyx45AVlOf2jVPz3ifLV63u1HruKfxpy6qVdytt4b4wYnBQD5164YNZT89ZffwS+7Qhv3Cma/AwG3Zk2WmYVcROOz77yUouhhyfN3MRuZ7hoZ0u+YwM30NplZmTZL/vmVnTi6EDseqzGspWG3lfvlT/jCNhDobn/Qo5zVrBYsk0+KkP0G6cL3TXRAjDOI8b/TorSY0nV+/X/I95q8sVgqC1EkkkTpYpPIgvhU36Xvx9MNB0ZuOHCMR3za5RgiZpb4gNPcISSF2GY0InMz3nSNiFJ7TvTN7qi79
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(316002)(70206006)(2906002)(1076003)(2616005)(70586007)(426003)(186003)(4326008)(6916009)(83380400001)(81166007)(7696005)(478600001)(8676002)(6666004)(36860700001)(26005)(36756003)(5660300002)(336012)(8936002)(82740400003)(86362001)(82310400003)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:41:59.3410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057cf4f3-33df-4fc4-4df5-08d8f33627cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3632
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

v2:
Change name with amdgpu_irq prefix, remove #ifdef.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..8936589bd7f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_irq_restore_msix(struct amdgpu_device *adev)
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
@@ -558,6 +569,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	amdgpu_irq_restore_msix(adev);
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
