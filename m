Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABF3C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D804210E264;
	Wed,  9 Feb 2022 05:58:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0639810E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3L5u9PsURHdpTKAUFp0l1SsXInh4x9eYSPfAbmDRWNj+4wY1B1sDqyDVU6uJCd/OU7rkIJhEw+leqxnm3bsN7XviZUmwBm+xxnbYOm2XqixJ5WbAfc/YZyEnee/MximCmh4ltiV7Io2oUN7K19MMQ+52bLOzRVI3MaT7c051cShgVfQlqfUgP2SJeGTDIUnPuvgCKpVfUdNsVzHpsGcfuHCMss+ULq6PD4ahK7j5J/PwtDgqwi9HUReFnqz+Ut5crAPqqkN7El1Le506nkIHHXLm34rBimWHCdWIHmLen8IeP/KdxEaKBfSNX7iqFAXIv6vS8TIpeXCm+QelD4JKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3HyZeELYKEz6jeBfMfmtXXir9ycPBjjfEVl7xfMcq4=;
 b=oBRBgswuoVgzSGumphCnB/mokBpTA0JQGe0nnmguxhKt9Dd6yUaXxJf/DyRpv03cD7dJL8n+RRO01FGWFd9dkpIO2tGRwd8XhxrnQy77zPKZFuHKIhdPQXk7/7/1fcmCbrQpTIhebiWg6ty5knaIl5WjK0JarDU8N1r3g1/hgCSTiu9ZKd3d8BDYG+/2jPDKYkq8cOGdw0vEhs7bUzfRGeG2cRwUnwOh8GWx7SoqIbcRnTvuTIvYNdGLvsrMz1c1TP0LWg6HE8Jb7EFiMKMLixoCKAzKOuo00EW7tnnpuhTudYvINpK2qdgwc3TvqdffnCMDkfzQKAgM4LJqUn4DOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3HyZeELYKEz6jeBfMfmtXXir9ycPBjjfEVl7xfMcq4=;
 b=tu5ZIe1q3qmdey+rLZguCLZQr0BuDY04Lo+9wajarzCXppqfugjukrEFLfKOaPIVQmA2U4szTsaUAj9ZmuB4xPGyPWGrjgXqf1Nc3qNdryP9KNV678BPMFPgGnNEMlxuYx4CouTassZiwKtAJGE8TPJn3ud26kcU+LAxVjOfFI0=
Received: from BN6PR2001CA0030.namprd20.prod.outlook.com
 (2603:10b6:405:16::16) by CH0PR12MB5236.namprd12.prod.outlook.com
 (2603:10b6:610:d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 05:58:21 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::bf) by BN6PR2001CA0030.outlook.office365.com
 (2603:10b6:405:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:20 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:14 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amdgpu: Optimize
 amdgpu_xgmi_ras_late_init/amdgpu_xgmi_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:42 +0800
Message-ID: <20220209055644.1873011-9-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 789ef71b-19ba-4c2c-054f-08d9eb912d2a
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5236EB5D59122FD2259F36C8FC2E9@CH0PR12MB5236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:193;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NipNP8i3vPt2u8oJOX81XOHvYUcqxRB4nVtF4j9v4vQLN3FMPN+G68n/PyLKbLHFQA0KtuXWJlyyHEz0m0krpm7gBhT6jQLyChynKkI2IBz0Ykw47DjHwaU1G7XmrKrdk6Umzt8Y1CSnBQZvGnc0u/mVo2M+M/H+QhUjMZa4Vx4Em8TEoZ3cBBi04DTy/pSXMm9pRdohd4ntDoAig0KwVr+W8/82rJ2vmpK4cNxybqXwCC8VS6f1YSucfWS5efxiHpzfU10p3T25fw32o2M0UqsnnzrLPQGxRrtx/3R8+MQUkf/gKwryKpwsZnDMaH6IpAhZWh0WnVPv/so1Lp01ywjaSys8Cwe5BjpHEtBJ1IkarZjPIpyEDAMrRXC+LSVLwk7M+LalGuM1sIszvxoKQzGevlZOO17Ggktj0ZR89XkxX95tAa8NIdG/0MtpydRoyCtA9X/3TqfBq2xWjXWiPNglXDHCHI2UiE+IOvR0w4znzTFB6dse9mhlL3T7+70aAJfoE8uGv1+cJa5wl/IyZ3pl3A0eoNsXLC7XPt2AMsSTkauBF/OlPqYWaPvHLabi3t8AGt44tP12WrYCLKTHUCyfOCJ0p8l3AxMTHCH79ES2cSUIQJNVYwQzk80BvU8YGkzdbmDHLbs/MKDzK2OieGtrPfBxAE6UjQXK7Vmvtz3sGAK/IEfbxeaAc4832PAdZLUlweKGlBJWitksDZSL7+qd+10m1JIMvPgAo+EGrEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(336012)(82310400004)(2616005)(186003)(426003)(1076003)(26005)(7696005)(2906002)(36860700001)(36756003)(47076005)(81166007)(83380400001)(40460700003)(86362001)(356005)(4326008)(508600001)(8936002)(6666004)(316002)(70206006)(5660300002)(6916009)(8676002)(70586007)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:20.9368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789ef71b-19ba-4c2c-054f-08d9eb912d2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
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

Optimize amdgpu_xgmi_ras_late_init/amdgpu_xgmi_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 40 +++---------------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d426de48d299..956cc994ca7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -441,6 +441,7 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
 		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+		adev->gmc.xgmi.ras_if = &adev->gmc.xgmi.ras->ras_block.ras_comm;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 15707af89212..a785b1e088cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -734,51 +734,20 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 
 static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
-	int r;
-	struct ras_ih_if ih_info = {
-		.cb = NULL,
-	};
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "xgmi_wafl_err_count",
-	};
-
 	if (!adev->gmc.xgmi.supported ||
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
 	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 
-	if (!adev->gmc.xgmi.ras_if) {
-		adev->gmc.xgmi.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->gmc.xgmi.ras_if)
-			return -ENOMEM;
-		adev->gmc.xgmi.ras_if->block = AMDGPU_RAS_BLOCK__XGMI_WAFL;
-		adev->gmc.xgmi.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->gmc.xgmi.ras_if->sub_block_index = 0;
-	}
-	ih_info.head = fs_info.head = *adev->gmc.xgmi.ras_if;
-	r = amdgpu_ras_late_init(adev, adev->gmc.xgmi.ras_if,
-				 &fs_info, &ih_info);
-	if (r || !amdgpu_ras_is_supported(adev, adev->gmc.xgmi.ras_if->block)) {
-		kfree(adev->gmc.xgmi.ras_if);
-		adev->gmc.xgmi.ras_if = NULL;
-	}
-
-	return r;
+	return amdgpu_ras_block_late_init(adev, adev->gmc.xgmi.ras_if);
 }
 
 static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL) &&
-			adev->gmc.xgmi.ras_if) {
-		struct ras_common_if *ras_if = adev->gmc.xgmi.ras_if;
-		struct ras_ih_if ih_info = {
-			.cb = NULL,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
+			adev->gmc.xgmi.ras_if)
+		amdgpu_ras_block_late_fini(adev, adev->gmc.xgmi.ras_if);
 }
 
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
@@ -982,8 +951,9 @@ struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops = {
 struct amdgpu_xgmi_ras xgmi_ras = {
 	.ras_block = {
 		.ras_comm = {
-			.name = "xgmi",
+			.name = "xgmi_wafl",
 			.block = AMDGPU_RAS_BLOCK__XGMI_WAFL,
+			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &xgmi_ras_hw_ops,
 		.ras_late_init = amdgpu_xgmi_ras_late_init,
-- 
2.25.1

