Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25927C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 10:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A767B207C4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 10:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jvn5ZpKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A767B207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7359889C3B;
	Wed, 20 May 2020 10:40:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE8D89C3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 10:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsZmR/gHq3w0J7egYlES8U5vOp+gJW/T1Erp9rFyVnrN/Jb90HyqSR8pvA1GyFf0Fs7ONG2NSyvsjXsdNQegthOtXfKG+JGrARuj/ox4HwBdO37huw0uQf2/lAphF080thROgPPTrSmfQwmCG/2lYjODvTWmgndBVXtsDe3wH/pucVVBiGMMJ3IWRy1EPUw2SDeCAcUpXWuCTDkxTVp2Q8Q/mVwR6uXlLEKLGaQvDatRzdkUl0WK4UJeqsBzVeK09OxnLqqe/ketCF+eXJuOtb4tOoVK/WVR7Ro8lpzjFidHR6FLEtPDGuIKIvmlxWzaR58o+tHWW85RCc94JEciJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu91L68wl++sQ2B94VfCc0iizsmcL+C4rpylhsIb3/w=;
 b=jKoPATY6uiPnf+lQVPkv8WZpPcDT1Pr7FTHamSi6InCcgt+3Lp2McxqWLRjjJmS518puMY0R6tZHDZw3KFLe0blOTYmAxO+Wa+blx8Wpv/U7ZU/3dan0RKqbnZV0PB3x/FjPG7hIv7Kubiu7B0MLveKBBbMhYsUtzdS7LNMhrq+EG0EM4b8p7qEnD6G+16VJEYjq+wGoNjrQB0PLMgpPEjVVhQk5f6veFpGKUMTHOuU/c8Jkk61XbL0KOA462vk7/5g9rieAJVy7qCqpmdNnPUJTN/ZCctmcuzNUFQzTH7TGmY1ySqpdaFvbWxcMi4EZ5XCA7UVjUdeR6xXjZojj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu91L68wl++sQ2B94VfCc0iizsmcL+C4rpylhsIb3/w=;
 b=Jvn5ZpKX9NcTUPrVZlwXB4drtMW0ZMHIlPrAfaFa65sHfgCG1SU8t9bVe03Mpo6fnxmite3XMkPp/zaw7PvtNKSg6hjeHFD1jJx5CwOqrg7phC6eoFKyijuyAQUBRYM2xFJ/HmmrlY5rAKPG+yCFb7J8PfAXJs6+4UeU1CigUVs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3625.namprd12.prod.outlook.com (2603:10b6:5:116::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Wed, 20 May 2020 10:40:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Wed, 20 May 2020
 10:40:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: unify the prompts on thermal interrupts
Date: Wed, 20 May 2020 18:39:48 +0800
Message-Id: <20200520103948.30993-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0086.apcprd04.prod.outlook.com (2603:1096:202:15::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 10:40:05 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad8fa7d1-515f-4167-fce4-08d7fcaa2973
X-MS-TrafficTypeDiagnostic: DM6PR12MB3625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3625AAA344578852AC4BFF78E4B60@DM6PR12MB3625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FuDqO6T2MGeKy6Csn8FQX1W4ibMwjonRYG8tj/7AsuUuk9wIgBoy2EhrtZGOSZDAs0EYWrkZqYtVSC4X4AmmDIUtt/38/A/33ZQCARtGG6e/Fxx1ADGhYm8XYcrRUcOzQv/iJUjf5bGShy45UxginouLGD5sG2sf4qSj27O6ZeBH/znYwotaOfzaEaRb6NDOt9phbTWb2J5JLdlWHk+iQv8sUBm16v/l/0WgAnbwcBYjfhSOjTozCJb7G1TZNKxmAV/jvL4RQMvnhHFhdwQ0zqwvuuYGAp7ge5DpP14+lBVsW2meDwqqZ2brZGiylfm9rYJfLzklLoqSYJwgJlrxXbw9h3xHN9e5q075D0nleJ1nO5c5Z8/TjyJXPHjwQGUjfyod2Cn6NUWA8Jj6FIRVI+8Y090J7k7xFoMBrrSBOBX8cqRnqUOEt48F8aA2J9b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(2616005)(86362001)(26005)(316002)(44832011)(2906002)(956004)(4326008)(7696005)(6916009)(6486002)(16526019)(186003)(36756003)(478600001)(66556008)(5660300002)(8936002)(66946007)(8676002)(1076003)(52116002)(6666004)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZvyBWK07rAE7nODg75QJ2KzlCZhkOXsn70It3e4F3b0WMA0pkUbFFd8KGqPe+SooKoMxyR1oZrGFVEN+CYu8w3/sX+xcOr5vslzZHREEyGTAJ7W9KQAmt+a60Ep8PoUz3fBxjugtVby0SeZhkrf55tjWVbN1X80fvo5q3UFy97H09M3ufJNEXHoPv+MDm42IGZEvu5udB4VhzYiueU9QuR9rtmJFzSY2XlBUqRKGMl88ot9IFf8k5iiULBQCIL1OLZhn7JsEjweSJrpQgFbGo3Tb//E6jV8zPUSJ64lbBJQRIVbSeFojY4POjDSyDbbSXCmQl+fRdiFld5zmvsCyKP+zZxQtdaeIPPpEo/9ObJSK9hAocfqXzcA6/Eze3pMypN3U3Gkb1uOZ+N7xkEQDTEi/LurksHvw2PRd9QeAi3JSx9+XOP8y9XXPlX4NtL6hihhlRkVjwWtNlYFojJdvtCQ9oeerpxAPaSv6MpV86h5dR9Tn2f7kzNYAs7VOt3Hc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8fa7d1-515f-4167-fce4-08d7fcaa2973
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 10:40:06.8100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hTQ/hpcbOlBR0XU2lmIG8AKx8xZkjqwfEhqvxBLaXZLXk1YnaziTgK2B8hWm5sV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3625
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

The prompts will contain pci address(segment/bus/port/function),
severity(warn or error) and some keywords(GPU, amdgpu). Also this
address the issue that pci bus retrieved by PCI_BUS_NUM(adev->pdev->devfn)
is wrong.

Change-Id: I714d1dffb30a6cf76dcede087cf5d9302f683ed8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/hwmgr/smu_helper.c  | 38 +++++--------------
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 26 ++++---------
 2 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
index 4279f95ba779..60b5ca974356 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
@@ -597,58 +597,40 @@ int phm_irq_process(struct amdgpu_device *adev,
 
 	if (client_id == AMDGPU_IRQ_CLIENTID_LEGACY) {
 		if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH) {
-			pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
-						PCI_BUS_NUM(adev->pdev->devfn),
-						PCI_SLOT(adev->pdev->devfn),
-						PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
 			/*
 			 * SW CTF just occurred.
 			 * Try to do a graceful shutdown to prevent further damage.
 			 */
-			dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
+			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
 			orderly_poweroff(true);
 		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
-			pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
-					PCI_BUS_NUM(adev->pdev->devfn),
-					PCI_SLOT(adev->pdev->devfn),
-					PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
 		else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
-			pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
-					PCI_BUS_NUM(adev->pdev->devfn),
-					PCI_SLOT(adev->pdev->devfn),
-					PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
 			/*
 			 * HW CTF just occurred. Shutdown to prevent further damage.
 			 */
-			dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
+			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 			orderly_poweroff(true);
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_THM) {
 		if (src_id == 0) {
-			pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
-						PCI_BUS_NUM(adev->pdev->devfn),
-						PCI_SLOT(adev->pdev->devfn),
-						PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
 			/*
 			 * SW CTF just occurred.
 			 * Try to do a graceful shutdown to prevent further damage.
 			 */
-			dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
+			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
 			orderly_poweroff(true);
 		} else
-			pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
-					PCI_BUS_NUM(adev->pdev->devfn),
-					PCI_SLOT(adev->pdev->devfn),
-					PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
 	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
-		pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
-				PCI_BUS_NUM(adev->pdev->devfn),
-				PCI_SLOT(adev->pdev->devfn),
-				PCI_FUNC(adev->pdev->devfn));
+		dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
 		/*
 		 * HW CTF just occurred. Shutdown to prevent further damage.
 		 */
-		dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
+		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c1ba77344107..f56789f8ec11 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1540,40 +1540,28 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
 		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
-			pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
-				PCI_BUS_NUM(adev->pdev->devfn),
-				PCI_SLOT(adev->pdev->devfn),
-				PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
 			/*
 			 * SW CTF just occurred.
 			 * Try to do a graceful shutdown to prevent further damage.
 			 */
-			dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
+			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
 			orderly_poweroff(true);
 		break;
 		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
-			pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
-				PCI_BUS_NUM(adev->pdev->devfn),
-				PCI_SLOT(adev->pdev->devfn),
-				PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
 		break;
 		default:
-			pr_warn("GPU under temperature range unknown src id (%d), detected on PCIe %d:%d.%d!\n",
-				src_id,
-				PCI_BUS_NUM(adev->pdev->devfn),
-				PCI_SLOT(adev->pdev->devfn),
-				PCI_FUNC(adev->pdev->devfn));
+			dev_emerg(adev->dev, "ERROR: GPU under temperature range unknown src id (%d)\n",
+				src_id);
 		break;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
-		pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
-				PCI_BUS_NUM(adev->pdev->devfn),
-				PCI_SLOT(adev->pdev->devfn),
-				PCI_FUNC(adev->pdev->devfn));
+		dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
 		/*
 		 * HW CTF just occurred. Shutdown to prevent further damage.
 		 */
-		dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
+		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
 		if (src_id == 0xfe) {
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
