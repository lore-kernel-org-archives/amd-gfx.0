Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F10E743C8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 22:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BA410E6AA;
	Thu, 28 Sep 2023 22:22:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37B510E6AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 22:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTImoiCYeYzMfx3rGtPIiCclkhoBje+P/ml3bx1k/Yi358KvmTOWd6vsRFwUPs58Xis4oU4bQ5JfSdorNi4G5FvOMd2nFOhLuopqQYsKnd75QQgahh3XLv/R34uGLA142ZE/irKfMLTF9MlNsfA7wTT2FNXdJ20naE0Lw0+jg+uvIacIELm31Szfcs1rjYwXrdX98mRAePKZYb/mS7lkq9Izr3lZJLimZKtTtI4aIg2sqw0sssBiL4UpLgZomSoSp6tsAvFJNSq+VqVyfBCSpp95wnv/504DV34osn/aGRoU6jNoygDb3TnA7bW14QW8fkRGCebZAo7ysLqVflMPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xudn5cHfT8e33ci7JN2hrI0nlqI9D+U4WqV2U9/NRlA=;
 b=Z/eGwWADUFPuGfIZWey+sKefoysn9wE9E0NmuA7XU3Zlh57btfP0/35Stw1mmHfDwwxW0IbkCiLcbR9yVQYkVtiS1f63TU6moEvSzV3gxJoq6GLxgDZdO+OzWPOaOx7aR4CLFdc1ft40J8g1hdSkr3YTyUmDYdRQbLH/OMek/HXbYzwqqck6DveJhPX710PoB5LWGZaVZcHjYHpGGsj9+tIQPzw1wLM/biiqx+ii6UA2hR7M+QSEx6ixYtqdTVHsnWCtVRBQVzLue4QxO0WI5p7Zx2uR8IyBqRK4FHK940V8SHHjF5wW+WVhkr8F9UkwVjwpoMhmP8+4tw5XpjeUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xudn5cHfT8e33ci7JN2hrI0nlqI9D+U4WqV2U9/NRlA=;
 b=QVWszL/1d1MDAeYPVG9mZ79ZE2QggJJUd7VZ14J9W/1P9HEYd6VfKrxoyHgD8DrBTFQdOnuUKMb9vjX/W/L9sekhqc7yQWLiiLA+GTQqgNCUp+U0MvzN8Oqd/hG5wm/UGGY745cD6zsuv/SfLNMIYgP+RGaRaQ1PqG/vhoW4KFE=
Received: from BL1P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::35)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 22:22:52 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::1d) by BL1P221CA0017.outlook.office365.com
 (2603:10b6:208:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 22:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 22:22:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 17:22:51 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: ratelimited override pte flags messages
Date: Thu, 28 Sep 2023 18:22:12 -0400
Message-ID: <20230928222212.17006-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d82d13-588b-4b8a-2ad4-08dbc0717466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRGzIdYVhQNZj2biAjHfxywMiQ+S0+UNgWjR3LXRfYXc/20cK4OP4vfKH0Bp9a52Ad0O0W0zpzQO0bGfxFT1ee8cE0adkyFdTPQTijeCy+bITqu7ORvHXq0Eh2JBqNh1j1/kfEG9PQ5J08tSejwkzKY2VSxtWCVgnjZGmh4m6Z9PUAOWJIHSuaqcVscPrTq8qENo8xkwWzRSglR9ezE590t0D7W7Oc1b6Gvk3XDY2rQu7pDW2TnVr+VyC80cEFBEIHCzdjbZq+W22POIufaCIrr2lEsy+l8Kz9a85YGhtYSZLr4rM0B2ORhmd9fs88APjCuRPyeWmFTCUOs9lO+b5o93TeYSg1U5lsFHznKvbdcpXLG0RcI/7kbr0fbkpObC6KtbkVl2lmibupCZwrMSh+H1Y1YHYuRadGiez23ffuc/Hi/mmJyM49ylPCFYRiEBw6zXeQK1iHpp/9oPODE4PYto3gn15Ak2+IQjMgFqJyJXIhPRvs7f7H1fJKkqcfP/Essd3zeK61CoFQcocnRFC51isDtiEYXJCvYCrVl+1FHBxMpp3psNo/HazvSxqAXixe5Rd9MZ17W0c78nkE2UwL467rv4wvukPzMuwVDiaPAkEwEczaNmeEjHNTJ+08XwRsra5QFV5T/xitaL7p+SV4tGCTyQAL1P7z5oXAmftFwp2TJg3bl5J01C7jt+iUM0Isj8v98agNa5vocawCLFBKQzpAmWqPc5sS0CDssBNR/y/CyQVjM49p/zEwS0NL6isAWp8DHCp6QqONWZsh0ikg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(46966006)(36840700001)(40470700004)(70206006)(15650500001)(40460700003)(2906002)(41300700001)(6916009)(316002)(40480700001)(36756003)(54906003)(8936002)(4326008)(5660300002)(7696005)(86362001)(70586007)(2616005)(6666004)(1076003)(8676002)(36860700001)(478600001)(356005)(16526019)(81166007)(426003)(336012)(83380400001)(82740400003)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 22:22:51.9278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d82d13-588b-4b8a-2ad4-08dbc0717466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ratelimited version of dev_dbg to avoid flooding dmesg log. No
functional change.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 96d601e209b8..6d2878684287 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -848,7 +848,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
 							 addr, &flags);
 		else
-			dev_dbg(adev->dev,
+			dev_dbg_ratelimited(adev->dev,
 				"override_vm_pte_flags skipped: non-contiguous\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6b15677c0314..ad0d63472e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1244,7 +1244,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	 * the DMA address.
 	 */
 	if (!adev->ram_is_direct_mapped) {
-		dev_dbg(adev->dev, "RAM is not direct mapped\n");
+		dev_dbg_ratelimited(adev->dev, "RAM is not direct mapped\n");
 		return;
 	}
 
@@ -1253,7 +1253,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	 */
 	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
 	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
-		dev_dbg(adev->dev, "MTYPE is not NC\n");
+		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC\n");
 		return;
 	}
 
@@ -1264,7 +1264,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
 		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
 	} else {
-		dev_dbg(adev->dev, "Only native mode APU is supported.\n");
+		dev_dbg_ratelimited(adev->dev, "Only native mode APU is supported.\n");
 		return;
 	}
 
@@ -1272,12 +1272,12 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	 * page or NUMA nodes.
 	 */
 	if (!page_is_ram(addr >> PAGE_SHIFT)) {
-		dev_dbg(adev->dev, "Page is not RAM.\n");
+		dev_dbg_ratelimited(adev->dev, "Page is not RAM.\n");
 		return;
 	}
 	nid = pfn_to_nid(addr >> PAGE_SHIFT);
-	dev_dbg(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
-		vm->mem_id, local_node, nid);
+	dev_dbg_ratelimited(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
+			    vm->mem_id, local_node, nid);
 	if (nid == local_node) {
 		uint64_t old_flags = *flags;
 		unsigned int mtype_local = MTYPE_RW;
@@ -1289,8 +1289,8 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
-		dev_dbg(adev->dev, "flags updated from %llx to %llx\n",
-			old_flags, *flags);
+		dev_dbg_ratelimited(adev->dev, "flags updated from %llx to %llx\n",
+				    old_flags, *flags);
 	}
 }
 
-- 
2.35.1

