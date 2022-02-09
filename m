Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D46C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6636A10E1DF;
	Wed,  9 Feb 2022 05:58:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869CC10E1DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTG2+Pd/3Nef7HocUJ3wQrOGEeqK9AppFEXtZMBiGbevcZRW1RULpH6X946hLUG5c+/60ZKVOu4HIa06YNCTBndwdoy4rTyEjGT8oIZenaHFvWVdZMvhs6YRm/TigM7Sf7Oh0j0CxdjF/ad9f8G8sLaJgc9GDh+fN2OGMi/EiQq9R3SbKsQNBZXh/UGa0SIv91iFL2G5TJvyVWimNojADzBtnkmScXtUdPsBMqWT3/aHcQRQcYbDTUebmSox1x1jA5YB3exxDO+jYS7YVWPnXhejoYlG4zZBi020/LmbisUms3hclcQ2JKjKiMZGSTVPvdQxZIRAauXqvq/FTEjvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtU+Wv+31MLCHViSIeA+oF2sftlTPdtaJ62XkN7HfgA=;
 b=O8Ov9Hx180fEcPDgDNL2FfcPiZpBhS6wRYHmEFPXfbfJbzc3XIa4XO3WZrZChqPhzb5VHzV85WE5eVQctq0xbbCXy7FwiHa5GCuIWT6q6cOqIVTrAi4nhlTMqSc7g+nawZSu9LV6rlvs5PdxBJCMFBbQNYG54l6nVS93ybyrCpQ+UwDkLHCGkhAEylQZVz0BAALGR8/gyI8vDXilYoslrty+rSixw3aKHXRve/qMcBl7jS3ZvXHYQnbzFCu4k0CGR4HF1fmx4VKshPesVflUyvylO4GXBxdbNgIzSDXkJuyKYAgmT5YydtdvvZ8pRnD7j/8EOVIDc1uNbOu6nzL43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtU+Wv+31MLCHViSIeA+oF2sftlTPdtaJ62XkN7HfgA=;
 b=ANxtmHTMxsXZ+UD+L55EPQr59cyB8cRl8suV9Vw9UiYXqkJdZFDp5blWTqbitwo8o8akUu7WpOwF8YaxoY8Je0hTaOIa2lKskO6GfxtvIK9kpGI9vmGf3qdTiXLsNFE+Pwnp+h08NNltMQDQuEhF+ocxpbhIQf2iBgtD+lgZ9wU=
Received: from BN6PR2001CA0026.namprd20.prod.outlook.com
 (2603:10b6:405:16::12) by BN6PR1201MB0211.namprd12.prod.outlook.com
 (2603:10b6:405:55::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 05:58:17 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::4d) by BN6PR2001CA0026.outlook.office365.com
 (2603:10b6:405:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:17 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:04 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amdgpu: Optimize
 amdgpu_mmhub_ras_late_init/amdgpu_mmhub_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:38 +0800
Message-ID: <20220209055644.1873011-5-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d3b7286-dcd9-4c0f-491e-08d9eb912b03
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02113AF0F248648FE918372CFC2E9@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27SoSKymXAYHQy0zWGZW6lBMjwyoJ7YemvLkbsQQPZQJ/hbfsiS2mcmwUqSaUSHLS5IN7+RqGktuZ6ONADXDh3bg4yRZtJEkJ56rb+URi+LQApFowT9N3+sYSl5smO2DKE4p0/mw+Ut9OiWEk5K0EgFtjWELb6cbay4vcquiao3Ujdd5KxCnBcyIUprXq6o0oAdoiROTxyTpRNFvJ8F99BJ8HkXDjvZHA9nlefEgbRCXce0MKpcPSz6Lr0UGlmEsaWwsquFvTT9HMLBQz/iAtD3LJd6wsjlQlLcCqmH7NxhBReL+Qn75CdhFTWOXm6jWJJu6H8i/oIF1khxMGpZTCTLHDbnKMyOTzitLf35PZ76NX5iAsIasMkgFRU926xXkO6iCIM9H0ajkB8fd6OGDnXeuN84thXDchqp2sM5GyNaUplYBIb9IxqDdYgwv2XUsXszYB96RJ3B/Fk7PGXjaKgjw8pvmDbQr3k+pN+Tvp+JdLf7dXwhBRxCkCO08nrMnktTFbk9HrHt+85TDQ/M2hcxLDd94S47TlKNROf4XcG/wyreStyymQ2ygox6uSQ7kwvuN3gpEyx7kE3VdKVORWL1Fwn+ogPZ00s9tMEV606LyDR6LNvQVs5qwzQkTPuVcWz3g+jLIgSQcifgmSFdkiQwn1f+kCPtK/NxF0F6IIHruV1VJkcAvtYWvYE7460+eekmpHY5ubvr5e5SjjJmyI7bv78V8qu759UEerKdfu5s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(36756003)(83380400001)(356005)(1076003)(81166007)(82310400004)(16526019)(36860700001)(426003)(336012)(47076005)(2616005)(186003)(26005)(2906002)(6916009)(54906003)(70586007)(40460700003)(316002)(6666004)(508600001)(70206006)(86362001)(8936002)(4326008)(8676002)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:17.3431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3b7286-dcd9-4c0f-491e-08d9eb912b03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
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

Optimize amdgpu_mmhub_ras_late_init/amdgpu_mmhub_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 37 ++---------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  2 ++
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index f9b5472a75d7..2bdb4d8b7955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -26,43 +26,12 @@
 
 int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
-	int r;
-	struct ras_ih_if ih_info = {
-		.cb = NULL,
-	};
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "mmhub_err_count",
-	};
-
-	if (!adev->mmhub.ras_if) {
-		adev->mmhub.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->mmhub.ras_if)
-			return -ENOMEM;
-		adev->mmhub.ras_if->block = AMDGPU_RAS_BLOCK__MMHUB;
-		adev->mmhub.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->mmhub.ras_if->sub_block_index = 0;
-	}
-	ih_info.head = fs_info.head = *adev->mmhub.ras_if;
-	r = amdgpu_ras_late_init(adev, adev->mmhub.ras_if,
-				 &fs_info, &ih_info);
-	if (r || !amdgpu_ras_is_supported(adev, adev->mmhub.ras_if->block)) {
-		kfree(adev->mmhub.ras_if);
-		adev->mmhub.ras_if = NULL;
-	}
-
-	return r;
+	return amdgpu_ras_block_late_init(adev, adev->mmhub.ras_if);
 }
 
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB) &&
-			adev->mmhub.ras_if) {
-		struct ras_common_if *ras_if = adev->mmhub.ras_if;
-		struct ras_ih_if ih_info = {
-			.cb = NULL,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
+			adev->mmhub.ras_if)
+		amdgpu_ras_block_late_fini(adev, adev->mmhub.ras_if);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b12fe6703f02..15958fd45f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1282,6 +1282,8 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
 		adev->mmhub.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MMHUB;
+		adev->mmhub.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->mmhub.ras_if = &adev->mmhub.ras->ras_block.ras_comm;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->mmhub.ras->ras_block.ras_late_init)
-- 
2.25.1

