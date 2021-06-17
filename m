Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E4C48BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C06A613EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C06A613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8356E8C1;
	Thu, 17 Jun 2021 08:39:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D396E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdRc/ikZY2OrWYiu6TVXvy/XGqxOFwzLHxGrnoNWYRflUtJxzLWtJJ7zBuH+hMdgn89GZw5Vodo+64yPw1+7N7v+2hgthwJTxguniWsBp9rc+YdsXjqm6+H2fLOgdJSx1eJiMxoRxGu33U9MHtNTGZF4fW4eUjdFa6K1qPVRmQg9pAlYo4mBfJoVSKNbMfOUabQW26RZzQQuKfWWtoIagNFjGwdjkQsHy26IqI4ZtpTpGXVei7iTChhxZ3dJ/qu1MCebJEg58ELFjaONDENd4MXQQWW522aNNR33E+FZzY95nCZnSq7qNBkFeR5JQ9DbisF5ZXerc35b4m1TIdx7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tV7/9o+QGcLPZaWz4w3AQ6WpBRWaqsKr7qiwEgbkgA=;
 b=J5a/qZIGDwafWB6KuWRx1B9c8SG/8RGJ/EPlqYuGnPPURWjwJehmwo8Tgi0Q3Klb2EdcejjQVpBp++BEIGUnWAtwRBf1/md927J5nxeLXjjQrP3iFWFwjYmTBGT24lG3xH7XH1ilWwbUQapq0QycrxFGnYRHdPFgZFY8JDTkagpjPqpH62eJlyi6ZoPq3gBA7MCBrNkRPK8XhIDlUBlZ7M61Sw1STJDWr8vq11WtK0kmpqZmZDlMA2rVRva8Y2N4rj50dW9vKZqZz+VFRvQU9U8ta/4hW7x0lFio24syKNBgj80amIusbkdeViVSgrTqSYG12n1I4c2u83NNtgUPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tV7/9o+QGcLPZaWz4w3AQ6WpBRWaqsKr7qiwEgbkgA=;
 b=h2F2/ShjbklMElg7bztYqwVhw8VBx01r7AnVd9a22xnLlDwuc/+UTA7O4Z1aSQtSTOqEwFIIta17F3Uyz5sMu8tVrOJUiuLrrqnZaW4eRDFi0JaVfIz4x1Q2YRdUkSAk4UC4C10dHplABJlNgAMx/E87rGKTY/No+s+ju8f3jRQ=
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 08:39:56 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::19) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Thu, 17 Jun 2021 08:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:39:56 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 03:39:54 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/7] drm/amdgpu: fix the hang caused by PCIe link width
 switch
Date: Thu, 17 Jun 2021 16:39:20 +0800
Message-ID: <20210617083923.421052-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210617083923.421052-1-evan.quan@amd.com>
References: <20210617083923.421052-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f206e68f-7e19-4f72-a000-08d9316b7bf9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-Microsoft-Antispam-PRVS: <DM6PR12MB298669AF4CA7BD755BBECB32E40E9@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqDd89rtXhfuFKcoWjtrWzVrEjEbxRJn+/WLmzTx+sDI7DgdOIXKtsVZ2uPk7jsdY8DFI22UEY3hTDzX1u4CBCJ65hwOtDBaEIU6gHJ2aiV1o7lhcynSP8wyqeiTbpHz3ueU5niuyOGY7fR+vwk2m8nhpaqyD3P4nvmVN15QPWdQvz7DipJ1dPn3uLRwnjNwmECl1fM7aVv5A7NBnFqJ0tKXQkb9K4Npz3IBSgRyC0px/gGQQXbkoKIeku2m0X7LxlHdHyy+3dhGeSRcPb+05qHu0MeSdNtOwMT+RwEfqn/lbDpWEZrm+FxVaX/bWn7JjQG62fO+2TqmJkHjlnQYT/IcTJTIa157eAA9HEywmaVtCe37jMQzNfbINEEQt4CIG5azKlZbrIrb7tj/sR0mMOiqBk9GAClTQrWkyY/+IJY5RdmaGazB7b1mRyozbdWMbs4yvnuptRbZ1c++U6xswF89fg5LK0BRZU/dAs1n+SnmlHg47HgYV7DRfIrCKH3M6wrVUdo26PLqCEi3+LijsFbVfk5hcivcK2FiUfzeKr2vATLwPko2GZYRf9zptkygtz5xm9QWgbv/v+MNXUmz1O2PscP8+SvnRvCftU3akjYneNpzsTzyJlEIYKwLDjbJ8J6TiZPrfq/39hb4FKJAao2UaQuXwFnsbWhNk+wbG+p1esKB/qL2j+q88fKmRQt+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(81166007)(186003)(82740400003)(8936002)(16526019)(6666004)(426003)(478600001)(356005)(70586007)(86362001)(2906002)(70206006)(36860700001)(44832011)(6916009)(82310400003)(54906003)(4326008)(83380400001)(7696005)(26005)(316002)(47076005)(5660300002)(336012)(1076003)(2616005)(36756003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:39:56.0414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f206e68f-7e19-4f72-a000-08d9316b7bf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU had set all the necessary fields for a link width switch
but the width switch wasn't occurring because the link was idle
in the L1 state. Setting LC_L1_RECONFIG_EN=0x1 will allow width
switches to also be initiated while in L1 instead of waiting until
the link is back in L0.

Change-Id: I6315681f6fb194036b20991512dd88fa65bc0d56
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - limit the change for Navi10 only
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2e1d12369cec..f31c331a1c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1432,6 +1432,15 @@ static void nv_apply_lc_spc_mode_wa(struct amdgpu_device *adev)
 	}
 }
 
+static void nv_apply_l1_link_width_reconfig_wa(struct amdgpu_device *adev)
+{
+	uint32_t reg_data = 0;
+
+	reg_data = RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL);
+	reg_data |= PCIE_LC_LINK_WIDTH_CNTL__LC_L1_RECONFIG_EN_MASK;
+	WREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL, reg_data);
+}
+
 static int nv_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1440,6 +1449,9 @@ static int nv_common_hw_init(void *handle)
 	     (adev->asic_type <= CHIP_NAVI12))
 		nv_apply_lc_spc_mode_wa(adev);
 
+	if (adev->asic_type == CHIP_NAVI10)
+		nv_apply_l1_link_width_reconfig_wa(adev);
+
 	/* enable pcie gen2/3 link */
 	nv_pcie_gen3_enable(adev);
 	/* enable aspm */
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
