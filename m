Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7C4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A614910E1C6;
	Wed,  9 Feb 2022 05:58:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A92A10E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki1MMZmA66gVcO1JCzSBvODyxE+xCHmI7mtgRGaG+b7YIDZLPkzMj57ZJJKy2ayToZOrlntYr+96Au+zIyfU82KHBC+4kfl25mnIxNagMhN/XrriaLsrvawwzozY7D5E9PBvt3R5gjrMdNfY0K/F/iA3lnzXSO6a/+3pH06l0/7BbcIk3//lj3IIXhvBrjmhKpikqWofeyb/bIw/+ZtdSBNkGGg+Y23Xsp2aU62oW6VMIWTb+c3b88TscjNG6aZluED0ot1xLc3OBQAVnK8L13LExzUqiGu0K65KeW/f1RatsqvJ6Vokq1D+4Fe1rZtNjyJoPPKVixazKhVhAUTwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE29RhZSyYRTCDhOlPLKdZVr8Ud9zU0VzHUfgh+w9uI=;
 b=SiggYCEeQ/Upem3QPw3z2GuaCYsOAS/X/xgrVsymzvHy5Whfd8uE319oleMTfajEzYMILg3+W5vFm+m5981VxwqSSXCujLMq+79pDxDLCacFAsDGazuoq9CVKO7muvBSvh+01NuuAy9LN5WH0pN+Eyqth4MbvJSr17Lzk7DRVjhNm50QNDY3778jNXVCrADbSNFBCliMTGiRoA/Eyu6kaudppLI9OgSwAdtMF71xPFoiSG3gsIm6LaWcQ3yLrCH3wuJUiKbSnaxZPo34MTpQfzgjoe6KXjZVAU/koTfY3SO2KHJrefjGmWpCr/mbaEqO0yTTFWEXDPgfXKbVY+5WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE29RhZSyYRTCDhOlPLKdZVr8Ud9zU0VzHUfgh+w9uI=;
 b=ifPEI9a15UBuEBxhMjRNQ7FhqTq4Lr4yZm8WIvK9tPTVsdcaHC6ETHIvhAxrypQwnuTiYwtaiOOvxokIGEuJTdUu7M4H6JCThHIgFHe81QnS4jINDc8ITIdKKFejc+m+OfcXbcI7P4+3KPA5drdE7G7aKRvn69Igug4/VPbdqgg=
Received: from BN6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:404:8e::30)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Wed, 9 Feb
 2022 05:58:00 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::9c) by BN6PR21CA0020.outlook.office365.com
 (2603:10b6:404:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.4 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:00 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:57:57 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amdgpu: Optimize
 amdgpu_gfx_ras_late_init/amdgpu_gfx_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:35 +0800
Message-ID: <20220209055644.1873011-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d971c89e-7d71-4447-ec45-08d9eb9120e5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2830:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB283086D6CD7A9FAE5FCCF456FC2E9@SN6PR12MB2830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +n4uXvMuNbrLrN6lz7REfKbhHzrnHzO9z530wslGoHVzXmTUqPRX7SSEF9S6K7rcnAWAg7ByG6jfNxIVIkz41PRjN64tviF4PgvuKhwyKhm43l0un+Hd13XarLSUI6yGVCVIQqhHu8U6lPntUKTERoxNtetjgLfqY8ZVkjFGr3mVU0n0CO2URQtDq8Y6nAimMhu6WxRzDqzNULVwhhuji9fg7zJ174EL97Hfa5xiTsM0BI2HGZ68nmhIrZf8MpTFNvAhSITY5E09W5WNcrmFygV6NrmKi5i0GJcr0da4znqbXCoe2nTAHL8He83tcImBhaSS3y9G0p8Gz4UqLtCbWcHsPtKQTNaC2AEoRfDubN0S+VKHX6c0HDKv7L3QqnyebDJ4rjMUMlEllJnWwUWKOhreJfPfmMXkLJTWaLFReztmNypgV1kNsAEsEb5ca7/i5cXR/ZBovezWI8xNX+KaST60MyeVkPgCDY2O2oQoWa0CG03ka3eBvtU0o/JkB94gbKzmA3On9g6RiV1TfbpLIBPuRZkmhXZVCfadjaSfNhJRrkbN/aKCJ1WvkSvRme/3lLwE7dAqHRT1Hz+xI32IUnOSuE8iINK3oL72eqqksHzL/suYQotsf5hMU84YTZ86LoKJlp68JzRgmY32JhvatvS9ClepxPdgoaHW/DopsAXMC8ogaTnpICNhs722gcSb7IqHmgeRovgrX6WJ3sogW8Wp7OB1xYwZal7C4/zZ4Pc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(2616005)(316002)(7696005)(2906002)(356005)(336012)(508600001)(81166007)(83380400001)(82310400004)(16526019)(8936002)(26005)(40460700003)(54906003)(36860700001)(86362001)(6666004)(6916009)(36756003)(70586007)(8676002)(70206006)(4326008)(1076003)(186003)(426003)(47076005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:00.3735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d971c89e-7d71-4447-ec45-08d9eb9120e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimize amdgpu_gfx_ras_late_init/amdgpu_gfx_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 42 +++----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  6 ++++
 2 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 43004822ec6f..fe392108b5c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -625,26 +625,9 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "gfx_err_count",
-	};
-	struct ras_ih_if ih_info = {
-		.cb = amdgpu_gfx_process_ras_data_cb,
-	};
-
-	if (!adev->gfx.ras_if) {
-		adev->gfx.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->gfx.ras_if)
-			return -ENOMEM;
-		adev->gfx.ras_if->block = AMDGPU_RAS_BLOCK__GFX;
-		adev->gfx.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->gfx.ras_if->sub_block_index = 0;
-	}
-	fs_info.head = ih_info.head = *adev->gfx.ras_if;
-	r = amdgpu_ras_late_init(adev, adev->gfx.ras_if,
-				 &fs_info, &ih_info);
+	r = amdgpu_ras_block_late_init(adev, adev->gfx.ras_if);
 	if (r)
-		goto free;
+		return r;
 
 	if (amdgpu_ras_is_supported(adev, adev->gfx.ras_if->block)) {
 		if (!amdgpu_persistent_edc_harvesting_supported(adev))
@@ -653,34 +636,19 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 		if (r)
 			goto late_fini;
-	} else {
-		/* free gfx ras_if if ras is not supported */
-		r = 0;
-		goto free;
 	}
 
 	return 0;
 late_fini:
-	amdgpu_ras_late_fini(adev, adev->gfx.ras_if, &ih_info);
-free:
-	kfree(adev->gfx.ras_if);
-	adev->gfx.ras_if = NULL;
+	amdgpu_ras_block_late_fini(adev, adev->gfx.ras_if);
 	return r;
 }
 
 void amdgpu_gfx_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX) &&
-			adev->gfx.ras_if) {
-		struct ras_common_if *ras_if = adev->gfx.ras_if;
-		struct ras_ih_if ih_info = {
-			.head = *ras_if,
-			.cb = amdgpu_gfx_process_ras_data_cb,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
+			adev->gfx.ras_if)
+		amdgpu_ras_block_late_fini(adev, adev->gfx.ras_if);
 }
 
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0a291d2e5f91..0c3b3972c04e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2200,6 +2200,8 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 
 		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
 		adev->gfx.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
+		adev->gfx.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->gfx.ras_if = &adev->gfx.ras->ras_block.ras_comm;
 
 		/* If not define special ras_late_init function, use gfx default ras_late_init */
 		if (!adev->gfx.ras->ras_block.ras_late_init)
@@ -2208,6 +2210,10 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		/* If not define special ras_fini function, use gfx default ras_fini */
 		if (!adev->gfx.ras->ras_block.ras_fini)
 			adev->gfx.ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->gfx.ras->ras_block.ras_cb)
+			adev->gfx.ras->ras_block.ras_cb = amdgpu_gfx_process_ras_data_cb;
 	}
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
-- 
2.25.1

