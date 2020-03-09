Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D345C18E5B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 09:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D9620674
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 09:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pJN0OwoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D9620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA756E3D0;
	Mon,  9 Mar 2020 09:12:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A8889B22
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 09:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9TvwIWMsO4U3MIBezfCFiydMwnV1z36QXrvHW+GE/33/gWJFne5EYGWWE4w/rQOR7dI7hFr36P7GpABQ2NTaf1IpGSK6a/PWX1jEI9Q9q4qp/NzXE0k/c9BXp5I1I8d7zDXc5WYWKbsJ33TYGtuFfBvjd6cjLVX8GxaNB49kmskBfo1eYS/4+AgDzTohbu721Eff3FinmQenZsknSy8NcP/3oLmHVdhgR03YpOuthUUTjHh9nPAOxlKv76WO8t7rnwN8poKC/L3k0R3holsr/jQ7SEPyMa3qPze3OwOvWtWvwi37vr1L56mbSqGXM/5PgBTtODbC/lXyqmIvsc8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3IYMBEo+N7nYSKqiyWjNCJIeSjPAEzxmfjuHe7xts8=;
 b=mXNvRuTclk8DH+73x6vU1akQtYQbkZfeZN/YWfWXji2wTNGDLy4Lzi0RgP0Th+CD1bHGddrHKjJ9heW2G2MqkcFymI4GmNWclaVoYp2ialQiaOAlDmYDDcQhC48Cba+jH1cbzQ+LGVJebkESUR0qBfzZHI9hfAiZxk/+6EWdQ1a3stMb9QJDzY9NIVTeO+rLf4napulQSFqzgilPvziXi5UTSiuIitVXbEwI5LP2sVHKzsduzmsiShx6tLl51q1tYZLjzXI4ZSX7e8Po/Fq9HdBnEs2IOLwstF1on6A4RGaBFKH1/0nUQ9iq2g1VNIP2cP/EmlZ05ujSWcyqX37QlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3IYMBEo+N7nYSKqiyWjNCJIeSjPAEzxmfjuHe7xts8=;
 b=pJN0OwoSlmCoZx9vQIVXB9IDn4AnI9KgToM6VwjG/offgYo5pvh1DAkZDiijIUeZ2Rd8yERM1cc9exhzFczbz3qKKA6C4RtltKSYDKH0dQPaoUzBSaWGtQNUjNM/l0/mvcINFjfzEAHtPMvFHSJSfBxYay2pqxBDNZCKLfQKC2U=
Received: from BN6PR04CA0107.namprd04.prod.outlook.com (2603:10b6:404:c9::33)
 by BN8PR12MB3507.namprd12.prod.outlook.com (2603:10b6:408:6e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 09:12:23 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::a3) by BN6PR04CA0107.outlook.office365.com
 (2603:10b6:404:c9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Mon, 9 Mar 2020 09:12:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 09:12:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 04:12:22 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 04:12:22 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 9 Mar 2020 04:12:20 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in debugfs_init
Date: Mon, 9 Mar 2020 17:12:15 +0800
Message-ID: <20200309091215.26768-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309091215.26768-1-Stanley.Yang@amd.com>
References: <20200309091215.26768-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(199004)(189003)(2616005)(2906002)(6916009)(5660300002)(1076003)(186003)(26005)(7696005)(4326008)(478600001)(356004)(6666004)(54906003)(8936002)(86362001)(81156014)(81166006)(70586007)(316002)(426003)(8676002)(70206006)(336012)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3507; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6557998-68d3-4989-9685-08d7c409fa3f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3507:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3507BFEF9F3A39F814D89D999AFE0@BN8PR12MB3507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:42;
X-Forefront-PRVS: 0337AFFE9A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92zNMZ41Fz4ZFuJjbOu4U4utUyX5MZ2nmSGLqBEODW6VmMcDEggr//03wSJ5+7+6ZDq2QwbEdErpDmqqmVrJbTx/Xv19Fj7MalX9w/CFP9BW9Zjjq7A9xdNo6xDtxzQwPu8jH5HaHY51JQf12ZpOp3XwY/qyaFVwvarP1DFXH6LrwqUZU9/V7DwkzwQZzVmTpz4bm44+8hNGcDuJEIvH80sd/StUnbMkNFMWD5bVhb2eAljHrP2MaiweFp5FJ/sEjBnxRuHFjZWD7QeCuqKqJ4TttaVQheqlvuYJT5qKAeRQnK3m7by+OzaiAeSCajx/P+w3rS0nq5x2AyJ9Magr/LyzwFQ6lhxwaTB3MCngPnXvXekwnr4YJImE0l7429HN6dt6MqdP5ztttf8ycGrll0P46fmKKmaVoFxB+JUesPl0nY9rB3txBc/TW91KGCyG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 09:12:22.8005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6557998-68d3-4989-9685-08d7c409fa3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3507
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
Cc: Guchun.Chen@amd.com, Tao Zhou <tao.zhou1@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>, john.clements@amd.com,
 Dennis.Li@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

and remove each ras IP's own debugfs creation

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: If3d16862afa0d97abad183dd6e60478b34029e95
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    | 1 -
 8 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index deca6343d0cc..1d513e4f9934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1315,6 +1315,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+extern void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -1387,6 +1388,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		}
 	}
 
+	amdgpu_ras_debugfs_create_all(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7403588684b3..d12bb4a35780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -565,7 +565,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev)
 	int r;
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "gfx_err_count",
-		.debugfs_name = "gfx_err_inject",
 	};
 	struct ras_ih_if ih_info = {
 		.cb = amdgpu_gfx_process_ras_data_cb,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 676c48c02d77..ead3dc572ec5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -32,7 +32,6 @@ int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev)
 	};
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "mmhub_err_count",
-		.debugfs_name = "mmhub_err_inject",
 	};
 
 	if (!adev->mmhub.ras_if) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 7d5c3a9de9ea..6201a5f4b4fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -30,7 +30,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev)
 	};
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "pcie_bif_err_count",
-		.debugfs_name = "pcie_bif_err_inject",
 	};
 
 	if (!adev->nbio.ras_if) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 422cdd1ce3ad..57af4ea8fb58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1178,7 +1178,6 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 {
 	amdgpu_ras_sysfs_create_feature_node(adev);
-	amdgpu_ras_debugfs_create_ctrl_node(adev);
 
 	return 0;
 }
@@ -1882,8 +1881,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 			goto interrupt;
 	}
 
-	amdgpu_ras_debugfs_create(adev, fs_info);
-
 	r = amdgpu_ras_sysfs_create(adev, fs_info);
 	if (r)
 		goto sysfs;
@@ -1892,7 +1889,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 cleanup:
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 sysfs:
-	amdgpu_ras_debugfs_remove(adev, ras_block);
 	if (ih_info->cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
 interrupt:
@@ -1909,7 +1905,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_ras_sysfs_remove(adev, ras_block);
-	amdgpu_ras_debugfs_remove(adev, ras_block);
 	if (ih_info->cb)
                 amdgpu_ras_interrupt_remove_handler(adev, ih_info);
 	amdgpu_ras_feature_enable(adev, ras_block, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 7854c053e85d..250a309e4dee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -93,7 +93,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 	struct ras_ih_if *ih_info = (struct ras_ih_if *)ras_ih_info;
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "sdma_err_count",
-		.debugfs_name = "sdma_err_inject",
 	};
 
 	if (!ih_info)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f4d40855147b..9dd51f0d2c11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -28,7 +28,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
 	int r;
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "umc_err_count",
-		.debugfs_name = "umc_err_inject",
 	};
 	struct ras_ih_if ih_info = {
 		.cb = amdgpu_umc_process_ras_data_cb,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a54ce398ed77..0837f872741b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -598,7 +598,6 @@ int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 	};
 	struct ras_fs_if fs_info = {
 		.sysfs_name = "xgmi_wafl_err_count",
-		.debugfs_name = "xgmi_wafl_err_inject",
 	};
 
 	if (!adev->gmc.xgmi.supported ||
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
