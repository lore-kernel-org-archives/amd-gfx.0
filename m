Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC73C47254
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 07:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D2624953
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4e8ho8bT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D2624953
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BAFD6E2E2;
	Sat,  9 May 2020 07:47:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D326E0D1
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 07:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrrduowCRo7qL5Seqxnw6sYcfrO4rveS9GG4BDg9wv2/T20/iz/ALYgycN/jCh4+EjktOPzsL0LTRYnDG/6BRMRsdzOBPG+3dw20IQN72Hk8uKGbhFaHSO7q6IAtYBL7M3pU4yfD7VDq+jM9uNGFaTBn7v7koNBU1qmZB8Y27W1o36f+qTRURP07IbPerC+zn3v1LxfoynaDTAHc+nBWBHyCad4vtGrU9m7xYM6EVFhAIy79jg8xczLZgHWDz4nuBx2TELalZXK4AjNUGmkziwcEhQyteedHyVqjRlrLPvlN2Mxp8RO9lln/2A5MohZ66q95V+k3wzCnK1B/0HPRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXuxsihcDEssL6YAHbVn6cIlBs1KBpGiiHV4wscGMm0=;
 b=kGCE4WsV37lc39Vrh8DC0NUf66T6CZu0SSXYPaIkypxj2ktJp0Pl07zkGda3gkJOhYqP7fCL7KOgJQWGysCXWl4ljMVQUr0tg3VeX92Dm05tfC3dJE9YeV6PxTzKEtDvRTqIn+Rrfv40xAQN5ekiwsqvsd7frB8e3+/UUUvyPtvr2zeeE9H0Qy6TsoWBYgjlq5xLiLPnfGMhHEqlPhXdoqkYeXjErxXBysKkyUgXSbxWZjg/Jegp0m9hXXQBaVUoaN5dRR/PIMa7uNedc8t/FKLq73i55HELzAjNmi9YvWBJSYlboXEgZ7xAT7n8KyjAVf3vlOi19QAMl8et1rhFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXuxsihcDEssL6YAHbVn6cIlBs1KBpGiiHV4wscGMm0=;
 b=4e8ho8bTwJ5x0/B6BZh57TvLIad9fNFBUYia6MnDLb3Td8b7VO5wazaK11kFbhS1aW24BP0CrcpGQ6NI4Lstk8WUkn8ZHKyjt+VicKgOMyw9XPQvRxjZr5kvZCbZJHJjKBpBvaY9UJkaUklgDpeIUrtpXyoI/x3OWzhcxPMf+co=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3499.namprd12.prod.outlook.com (2603:10b6:5:11e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Sat, 9 May 2020 07:47:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.035; Sat, 9 May 2020
 07:47:48 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: try to do a graceful shutdown on SW CTF
Date: Sat,  9 May 2020 15:47:25 +0800
Message-Id: <20200509074726.11573-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.13 via Frontend Transport; Sat, 9 May 2020 07:47:46 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc545b3a-4099-44c0-bd24-08d7f3ed448b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3499:|DM6PR12MB3499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34997D728CCBCEBC0A4A05EEE4A30@DM6PR12MB3499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03982FDC1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hpu3CqAqWoNPNo9mf/KWa4l4jrNc2Zvau2BzB6x0JmwkzssOmUnfMZLglnHmFkpHpb2EjWKzXIa0EOu6/a0sbtOtS77syKFVlQjFIwr6relmjQ1d3X6DiyIu406RzexJG/FB+Sc55Vahe04GQMxYtWJuJiAfPoLVnLhXucED/C4XNvBliq7fSPtAKLICtnAxx1VIz55ys1zMeu4z43B1cAHEl+0QFZ+9dmCUi85Rz0d/NgyZK5eiJbeSX8fMR0GiHSlJ+jJL4t7xZ7uBbnhsBf5T3jKeiRVzx70Bffi7TZkuxqRkqnr3O3pnrbSQj99ml3vz+c9b8MYS9cRE//i6MwgbYqYo2mi/6vedg4wKb8TbHYNPHUn//uT4rxtzLJA5n979xKHc4bqeCB7LvviQU5bXrtm7PGH8+cEDxijTf1EQqV6kXGpAsR3Y3TfIj284qzxvowvQoVT6IX6qUaMLNafywzLwWyWhtZa3pV92AVnhwm6uEp3YfwttcVcbMW/QztSb5a7YX4XGPOlcXCK+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(33430700001)(33440700001)(956004)(8936002)(52116002)(8676002)(86362001)(7696005)(6666004)(66556008)(6916009)(2616005)(66476007)(4326008)(16526019)(1076003)(36756003)(316002)(2906002)(66946007)(44832011)(26005)(5660300002)(478600001)(186003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EpYD0L01yMTQeOOa+nEIsSlGUj5IYbx1hAd02nqZF/e8twf8bq2qb63A/iobaP29KgvtG8ehPMe4VbTR8WF10yG8aDj+V1bd2F6vL7OHGgEF8hIvpibzo2Z4NItk/8+WTPg2Dp3eH0tyoMB3wBvJ0Y1yBBONvX7VEaqlDv/5DUbhoL0peeKqvQbCz1hvqYvKOlKJF77L6Jrwc35kB3HbghA5MO9Ryv68IF350q2TUFUcy6RskV2P/XsPMu3xt+FuL2AmutdqJOh4IIjKnjB3ve6aktUkp7UTuAEhL4QyOzXmTjVRVBJNGjJaHQIcXh0dTbLAMKerSHvLmCVHCrm18gbPV9EPMVPZVApwF2cHz1zdET0wWpX3I82/Q/gxoBUI3Yb7MM4yBxuiXpRBxE2cisMRV38zQEJmcqeDrQ9y4rR+XCBOwuNdixMdCXYFr/HBLhtyWpjA6C+56yMyg0SW+yeN5863JecdHYSWiEIvBqCCMD0JUnl/rHHUGNLyRw1b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc545b3a-4099-44c0-bd24-08d7f3ed448b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 07:47:48.2290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VC+CkmWAG34P2g1YSD/QITSW/XXz4RWxVkOH9EZWT1EpFkP0f70DbyBZNgz7ZJa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Normally this(SW CTF) should not happen. And by doing graceful
shutdown we can prevent further damage.

Change-Id: I84f0c0643f78dcb5251089fe83305c460b815b62
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/hwmgr/smu_helper.c  | 21 +++++++++++++++----
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  7 +++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
index 91b5d96db674..782f6d295202 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/reboot.h>
 
 #include "hwmgr.h"
 #include "pp_debug.h"
@@ -595,12 +596,18 @@ int phm_irq_process(struct amdgpu_device *adev,
 	uint32_t src_id = entry->src_id;
 
 	if (client_id == AMDGPU_IRQ_CLIENTID_LEGACY) {
-		if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH)
+		if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH) {
 			pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
 						PCI_BUS_NUM(adev->pdev->devfn),
 						PCI_SLOT(adev->pdev->devfn),
 						PCI_FUNC(adev->pdev->devfn));
-		else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
+			/*
+			 * SW CTF just occurred.
+			 * Try to do a graceful shutdown to prevent further damage.
+			 */
+			dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
+			orderly_poweroff(true);
+		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
 			pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
 					PCI_BUS_NUM(adev->pdev->devfn),
 					PCI_SLOT(adev->pdev->devfn),
@@ -611,12 +618,18 @@ int phm_irq_process(struct amdgpu_device *adev,
 					PCI_SLOT(adev->pdev->devfn),
 					PCI_FUNC(adev->pdev->devfn));
 	} else if (client_id == SOC15_IH_CLIENTID_THM) {
-		if (src_id == 0)
+		if (src_id == 0) {
 			pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
 						PCI_BUS_NUM(adev->pdev->devfn),
 						PCI_SLOT(adev->pdev->devfn),
 						PCI_FUNC(adev->pdev->devfn));
-		else
+			/*
+			 * SW CTF just occurred.
+			 * Try to do a graceful shutdown to prevent further damage.
+			 */
+			dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
+			orderly_poweroff(true);
+		} else
 			pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
 					PCI_BUS_NUM(adev->pdev->devfn),
 					PCI_SLOT(adev->pdev->devfn),
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 5792b224b0c3..5b493f140dda 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -23,6 +23,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/reboot.h>
 
 #define SMU_11_0_PARTIAL_PPTABLE
 
@@ -1535,6 +1536,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 				PCI_BUS_NUM(adev->pdev->devfn),
 				PCI_SLOT(adev->pdev->devfn),
 				PCI_FUNC(adev->pdev->devfn));
+			/*
+			 * SW CTF just occurred.
+			 * Try to do a graceful shutdown to prevent further damage.
+			 */
+			dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
+			orderly_poweroff(true);
 		break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
 			pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
