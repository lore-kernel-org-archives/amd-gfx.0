Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A91C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C1F20BED
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aY5sRjCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C1F20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C471D6E4F4;
	Wed,  2 Sep 2020 18:42:50 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680063.outbound.protection.outlook.com [40.107.68.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B46B6E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIkrceLF6uYZDJHE1pmV2INznDQPdUGl4PfhXUlql7C0ZXVDyOlP1cz0ruxG1ugqHU2nS0mLe4kFQT9uhCq2RD1ThZVWVGPCEz9J727Zlrki1mWID9kbM2oLDQqyDyTQPoFkHuAKqfgBt0C+0mWOBu1I+2RqJ72HboP5t37kqGufL8h6hls2Z1RJaLXPd4msc9nSPp9QKNAOAzAB1955/IcB0ceEu+tS5joPnqmPx/WTBhL5asYDNgn1ZLjfKBy1U5uH7U5A9viY8KmjECFxb4fsVsNGZhYwZal9qJ1zyKtaEhWsk0Bz+9T24+ZogQgyJHcrBO/Q8y+Wi2Fsoj7GIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJV4StwxjrA8+KEYn/IH7f8OM5j02zigaNJpG0c1ah0=;
 b=Gh4MgO77e/pMM/9/+AsghT892T57MXXXs8T+9wGS/KCE4bcQJ+lF3CaNUOdnmBBf5MHZAEIocdu3sQdydc4IX4bDi5pYw0XGjYC6Y+bF+T+Pio2U7JMGDlaAuODpVMONnelzIq3uOKgcx3tw9KQ2zKx1koPSvbnUtPy72jWtNPNnJtojS9PDn33sCr+xS3H0FYi3tRF8acCMdYNFrQxxb3+Evg8Uf1lEcXQ0xloZY1WSHc+2ER2JjHTvy4de+AxJdPuSpWkWuKm+zHVDYnuWgf8LLmVC1CbSkEiLgRzg/RO6oNnxQOwW12Uq84q0x5PkW8qrGPsVqHeDozsQ45tXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJV4StwxjrA8+KEYn/IH7f8OM5j02zigaNJpG0c1ah0=;
 b=aY5sRjCNV+4mUO3FhRkFYSBlun1eCaJzzfCQNoI8p+u+Lc9DzcUgNbyhzUuDmCZnNvvzEAx6U495qbBzBxKnn1DRZ5sWyjPCzZ94tr98z0MfiNC0ZTjcb+TKNjCdLUdoU5hlk3yTMA2c4brZ7I0/bFi2G0EAJu9yIVJL1qGafIw=
Received: from BN0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:e4::34)
 by BN6PR1201MB0049.namprd12.prod.outlook.com (2603:10b6:405:57::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 18:42:47 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::82) by BN0PR02CA0029.outlook.office365.com
 (2603:10b6:408:e4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:47 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:46 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v4 8/8] Revert "PCI/ERR: Update error status after
 reset_link()"
Date: Wed, 2 Sep 2020 14:42:10 -0400
Message-ID: <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a0b4a7-a2d5-46d2-4879-08d84f6ffcf4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0049:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0049E833AF907192519574A0EA2F0@BN6PR1201MB0049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33EFhpCAhjMN3JqhU69Htc8u7UfKvIbSF07C++M+XX1xNAtrz7XrNdDTgP+qCC+GiMbmSjk7buj8qkbyjzApRbS8RX9v0jixY0N77OYAb9m1PMzkc/YUXkeUitCP2DGYRxq2ydosTEPiPrTyEbSRF5t3uE/8KldMwXAImqb8x0zyIehV8S5CY2iBfNK8tFc/3HJCOPXOJ7y/jOQVnnfMHiRGSkFdwX20HwI12ThFfTh4/eF0EhGzW631a334mViz8G5h9k7pJ8zn7XizgmSWg8FRyoxKSeVfOk4ruVTD2eNuACqptyyhEqaOiFgqtYcsFnXS+JmkSEaBWD/wsQ/U1i2P5YXtX4qsosCFNfFP4TzxUZVvRL/V77eGKfcDQFzKBLwEJAR4Hy0IUNw79iMoPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(7696005)(8676002)(70586007)(426003)(86362001)(8936002)(26005)(36756003)(110136005)(82310400003)(82740400003)(15650500001)(2906002)(47076004)(81166007)(356005)(5660300002)(478600001)(2616005)(4326008)(70206006)(316002)(44832011)(336012)(6666004)(54906003)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:47.6337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a0b4a7-a2d5-46d2-4879-08d84f6ffcf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0049
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, nirmodas@amd.com,
 bhelgaas@google.com, luben.tuikov@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 6d2c89441571ea534d6240f7724f518936c44f8d.

In the code bellow

                pci_walk_bus(bus, report_frozen_detected, &status);
-               if (reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
+               status = reset_link(dev, service);

status returned from report_frozen_detected is unconditionally masked
by status returned from reset_link which is wrong.

This breaks error recovery implementation for AMDGPU driver
by masking PCI_ERS_RESULT_NEED_RESET returned from amdgpu_pci_error_detected
and hence skiping slot reset callback which is necessary for proper
ASIC recovery. Effectively no other callback besides resume callback will
be called after link reset the way it is implemented now regardless of what
value error_detected callback returns.

In general step 6.1.4 describing link reset unlike the other steps is not well defined
in what are the  expected return values and the appropriate next steps as
it is for other stpes.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/pci/pcie/err.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f41..81dd719 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,8 +165,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
