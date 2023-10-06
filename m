Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67E7E81E1F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C2110E55C;
	Fri,  6 Oct 2023 18:51:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8509B10E559
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMZeu7Ae/n3KCswsTKB4DEH2uI2i3omRKOufKNpv0ldW3K4hQhUFCGq6yTCgcPkWv+fxrgsq6F4uRagG1vGY7tEDPR+fb1lQUtMfYdcK6W5y+POXYxs7I5Vyesq4n5VoaaMTsEg6z1MSWLADJSt/t3g9xhkUFcfNEmt9AO+tLdKbWs1/5bcNETRZZikvpvMxqy3h2CJQzH2Eo4lGevEUCdq1kwAGHbeLjkcQka00/CDsbMgwcITrNldeZ73bMUtUH4f5F2s19gJ4VtCF5Bwn3d5tN5aWzFKT9/8XF+G+FDPGi2r7QnnnRcu0ngFmUcH/aRi64SkRHUx/0hA9Jhfc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY9krHmORRK0DaSE1YS8G3EO5JZVOu/OLw8LSkgIqMs=;
 b=Y0ZRMBj55lrH+iVxo/3thxzqdvdNhpTn9LSGIHOf6lvowXplkZGuZnCHc9eBQbi0kvBPQYbQuPbIb4XAgCVRwVmjKl7aA7E3iSjjcZktvLoKj+yuO0napx8RRg+DMmQ5X6gA4q6718rrkxjQ1UBA4kaKTrhAzqGeOsQ1jhNPXkSicULqDOQ3nYuxzJbNjjEZV3cGS4N9wseIvdJK93vowJnmEGdA/5qwWKE78w8rjCbQoAQXiZRGPj4jABBYvin/LmOuuKScs8Eofg8y8d23he1pfBI2S3XfgolU0ourrnXzEfO+amnZDETgSMzNUUyCQyPJ5pog9el7Oz5Yjqs7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY9krHmORRK0DaSE1YS8G3EO5JZVOu/OLw8LSkgIqMs=;
 b=3LpLc+5cfomUjTgoCm/UeImv83HIqKbq5DaoDT/s1ahh/R4SGsoGryZrOqFl5kMccFKTKTtp35quoxRM6FndIg+LsZAtHDhqUmlkCV4AHSOZK970/jvi6Mu51dkLb65ejUDo+XxhsKBU98mXhxMxpH98Ep2k3pxZd7F/mNcBgl4=
Received: from BL1PR13CA0263.namprd13.prod.outlook.com (2603:10b6:208:2ba::28)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 18:50:55 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::cc) by BL1PR13CA0263.outlook.office365.com
 (2603:10b6:208:2ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 18:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:50:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:50:54 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 4/7] drm/amd: Capture errors in
 amdgpu_switcheroo_set_state()
Date: Fri, 6 Oct 2023 13:50:23 -0500
Message-ID: <20231006185026.5536-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006185026.5536-1-mario.limonciello@amd.com>
References: <20231006185026.5536-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: cf019353-a39b-4f0c-538a-08dbc69d2be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0m2MzwGhB4wn4mVk719UGsEeb7pjxzVTx2ZjDI3acJyRiIB1cpUE3P9zgo9zRyumlQcnJE7YTSJUX652rhEelg2GueOGTG5ZO/XDWY0MrhvXmQOdj+SPzh1r5HVCN21INxY+WUPtI31poGTJ1sFjNvydFc3TsigTO8zGq4VxJpnzPmL7TxXi0PVLws7PV06LOlT88OYlQsY5U2p2IpeZAssSoteMvWez+9Dz9BBWB0mnFWebyRJ4YcIXb8FGaf1ZTkdRtfUxEn9w80lNvlCfcA6B8NiprDAgXKY/FRaKSuXMmPKJHdH7X+NMnzcyge8IobLTZsKdJGAncjAmXFW+fAZmiCtAZU2wV26iv038BQCTqXxFnPl1fs/0irSiLFoQBxQKdN+Hm1wroyDqTUhSSrh9BRivtvf2Olvc4sM/KIMdWq6E1MJUycgWmFb/rl5IGq2Ws99iKusFthvhbehYDu3C9uPajzydM116qmKpr0sH7cfZcWUkfKe6kmLRvpOdCwkHz3PIA9zNEgmzuyV2ItjUAxl3ifoYIsTxkzc5kwIkwsis77OhdNeF6GA+tYBKlB42vpTD90xhpZTivdohVqMpx7ojG4vXlZRyVW7YwHcmTV9RDjHgq+q0mdKR5UCIrM/tk0eNxX/aMnKuDUaJwkBV/hBCO8qXZ5zeENywoR6H+6qXzFVaaE4PSb+eKa5nM0FManwOozekkHy2RwyC9+ZFqD7TW1CZLxm7kUfW7x7aZnqvfnZe3X6CyEazA20nGHxez+PrsFGr+FBjC6Y3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(26005)(1076003)(70206006)(2616005)(82740400003)(426003)(356005)(54906003)(8936002)(336012)(70586007)(6916009)(16526019)(316002)(81166007)(478600001)(4326008)(6666004)(41300700001)(8676002)(36860700001)(47076005)(83380400001)(36756003)(7696005)(86362001)(2906002)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:50:55.0940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf019353-a39b-4f0c-538a-08dbc69d2be1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_switcheroo_set_state() calls lots of functions that could
fail under memory pressure or for other reasons.  Don't assume
everything can successfully run sequentially, and check return codes
for everything that returns one.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 +++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a362152cd0da..8dfcff783dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1749,23 +1749,45 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		/* don't suspend or resume card normally */
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
-		pci_set_power_state(pdev, PCI_D0);
-		amdgpu_device_load_pci_state(pdev);
+		r = pci_set_power_state(pdev, PCI_D0);
+		if (r) {
+			DRM_WARN("pci_set_power_state failed (%d)\n", r);
+			return;
+		}
+		if (!amdgpu_device_load_pci_state(pdev))
+			return;
 		r = pci_enable_device(pdev);
 		if (r)
 			DRM_WARN("pci_enable_device failed (%d)\n", r);
-		amdgpu_device_resume(dev, true);
+		r = amdgpu_device_resume(dev, true);
+		if (r) {
+			DRM_WARN("amdgpu_device_resume failed (%d)\n", r);
+			return;
+		}
 
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	} else {
 		pr_info("switched off\n");
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
-		amdgpu_device_prepare(dev);
-		amdgpu_device_suspend(dev, true);
-		amdgpu_device_cache_pci_state(pdev);
+		r = amdgpu_device_prepare(dev);
+		if (r) {
+			DRM_WARN("amdgpu_device_prepare failed (%d)\n", r);
+			return;
+		}
+		r = amdgpu_device_suspend(dev, true);
+		if (r) {
+			DRM_WARN("amdgpu_device_suspend failed (%d)\n", r);
+			return;
+		}
+		if (!amdgpu_device_cache_pci_state(pdev))
+			return;
 		/* Shut down the device */
 		pci_disable_device(pdev);
-		pci_set_power_state(pdev, PCI_D3cold);
+		r = pci_set_power_state(pdev, PCI_D3cold);
+		if (r) {
+			DRM_WARN("pci_set_power_state failed (%d)\n", r);
+			return;
+		}
 		dev->switch_power_state = DRM_SWITCH_POWER_OFF;
 	}
 }
-- 
2.34.1

