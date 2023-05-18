Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC17EC7EE24
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9913210E50F;
	Thu, 18 May 2023 10:53:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E2910E4ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+yfbg1E7zTHRBPjciaDFRImQbnKKQWbGa8PdkWpxdgIbyYjgJHvM4VC5kc8A8f3AD1kmm2Dq+o3eBgS+MSXK4+ybAYEptWBYc8pHM8WYoNV24XEXHZ5NtH6DDcjvK9WRNTGK/KHomCp4N/+1KsOcv5pwVQ6Ijhcss6FtufahSz6q4/vutbQ9KIFL1fuzbppnpJ7XhprCpB74iGENTHR7vR1+6zGSjY0l1bgZjkCRIVgW/pFOJcbDxxDkUs1l1s2Y0HqnFcQ3KBDC3c6jAA2jKY04HOwCqd0gTTbQJr20v/gFsddxIrWTLKw+GstcNIEcN6APOd2NqapsIETU8HZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78+0ZLVvqVNnx/r/Yw0EUB3kh6t9GJ6ejvBrhJKItaQ=;
 b=aHo2wmphUMioH+cHtCQhLqkMF0CTGE26pn+Bekp33wfnKBPHexhtzjLEbr3u0yqpFRgp7NypT/6EZLdBlvXiH0hIPXpsSysDJ58EOiUGOhmn/FRSZPqGP4pzT9JNI0QBkg9vrU5qGFNrPCGFirXs52OFj5dba0uCYxIrpVqbbDSBPO/XDhaBi6z2S+h1VZOw+K1PlDOiZrxJYtyHOnfTwHXT1OOP3pt3uRtnJGnMcW2LWUZHMA1AiTa4PLdUQ3FYOGv3nn1GRQgasu4JcEbzLm8SeBZ5e9oDijvy1MQpPWBP1TN24YurKizCsbDj/phAhHWC809wyySAaneSfFXH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78+0ZLVvqVNnx/r/Yw0EUB3kh6t9GJ6ejvBrhJKItaQ=;
 b=BLFUxlEyj7gSNuRap8wKzV36ufpVN5Uuq6zhQLw3dTFUpQpN7dpIqQZP0Ypuhdtddi8ATKl8lPkzzpdO0Wgwx40tO7SfB8znXPUEJzuwsP7bYrBc/mVPuM9sMf4MuCL6RIf/Bq7G5wY6rjsjFQVEEGWEUYpnZxLULEziWijc0pk=
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 10:53:45 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::d0) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Thu, 18 May 2023 10:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Thu, 18 May 2023 10:53:45 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:43 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: add the pciid for aqua_vanjaram
Date: Thu, 18 May 2023 18:53:18 +0800
Message-ID: <20230518105325.15609-2-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 110ec7b2-c6d3-4a40-aa24-08db578e26de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FYM3J7CUB8k2hm3M+rv5YrIEeD9fu5xJSWa2508+2wIDQGtf3Lj0y5jDa3Su1c+zzXAhpZ6EKQSKNotkP+BdFzHQKuzzbl56CXwSO9G98MCnKGNMNTga6/AQ+Oiy/T4meSfRmZ7yTeIrbV2cO1fwbNLKsYKtWNaCB3zC9yyJ7NRKCPHdv0kkgmak3ZrCPClc0qDosy8Buxr/fkMoKtJ/Qlt3I56I6fixwPzuwY6gmvsM5UPFPuFhLaFv6DbTGwMrdwOrGOhyzWVLbZ3UHgofUxz4cCVWw4/FpmwGTkh23503iTj9tjO4m77+nRv1oZ/Yi1EBRATKYoSvcghSjeBm7Ev+jx1TageFgM/tJSIJ7wY0ed31sMeSaFBImJH0vgxohDoW5AxOSusOlq7FLzLCS3J57xaWaTXYBLFcMlB+8xvkdsRXtNhxhZHhQoX/LQNU56Xs8k2+8XE79O0+2HwVm8Gah3CSi88viLMkoALT4vT9NANi3uIULj1direk5r/GCtRUKBgK9XiZ93MSoh3LEe2h2KtjQoT05R4g8eatB0IVMf9nJ7FGEb9cFiQwStoe1DfLkdlOmZOB4Q6WYXZreMpk+uGm4bKVIJ9KXtYSdDz6Ui24caYmNnWtiPhjlZGkGFC4OTlq5X+6FGzHnpZ5d/CgsiEakfjnWp7FrAh54e7+a4OshQdoEX60dMn17csvq/FTsKnXoDabrAcjkFl5poRi1gW5SKd0gg+Fs90K/arEnHXkKc+BRCuNHbYIDVJwV5r5Pb69kWWdrYyvSE2FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(40460700003)(36756003)(36860700001)(47076005)(40480700001)(426003)(336012)(2616005)(82310400005)(81166007)(86362001)(356005)(82740400003)(16526019)(186003)(44832011)(478600001)(4744005)(2906002)(8676002)(8936002)(316002)(41300700001)(5660300002)(6916009)(70586007)(70206006)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:45.0594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ec7b2-c6d3-4a40-aa24-08db578e26de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d91e123f9bd..917379b9079f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2032,6 +2032,10 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7424, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x743F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 
+	/* Aqua_Vanjaram */
+	{0x1002, 0x74a0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_AQUA_VANJARAM | AMD_IS_APU},
+	{0x1002, 0x74a1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_AQUA_VANJARAM},
+
 	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
 	  .class = PCI_CLASS_DISPLAY_VGA << 8,
 	  .class_mask = 0xffffff,
-- 
2.17.1

