Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51068C197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 02:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD2410E711;
	Fri, 17 Nov 2023 02:12:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D9910E715
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 02:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgEdYf4DylNPKkpA0APclWf2s3fNUeXLiZ5tRHfENC6eSObOsaDU9Imy/272AkxIYTrnNQ2I+AGzKulYTZqod5rC2JVTxtcJ0ydL1lvTHu4Cz0FX6TQCjJBKDtfVEvhv8ZdVp3Lm0trWxXWfgDmPYdjMjOwApA0aNK0qozh9NZ2e3+3HcMhT+LAQIdIdxfp1oV/46dE4CsK1E338RSAmZVy/dlqYAwp1vRXbCrtam3yHpz5BLQdKk9HrUemLo06X3pFIvsneZ2RV1tJ6CJ309gZLTlTALS/rtkTExVUP2o4kQT0/H76GdMWJmzVZtIh934ZoUomg+Dl5rIdmMa0fWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiEVM1gkYTlOfdtje4OdJssrwcgG+fsAF8YzY4dtvQU=;
 b=j7vTulk3AlPQ3oNNe6jWZ9RkZFSNI2b7uHwvfaSvTxUkatd65e6JlULClNomDivk27FTY5Q60uKLmXyxSqT0vqtF3WeiPi4+3sXXQcm7kPUlPrbWxfHcIc5OHpwOtQDNoncTsvVkHWk5ez2QKFsxI6SZywEAZQkJASyChhXslyDAEKFmEozGZLpXBaf5sVlUNCYbbXZKds8+F5Zzdt6F4euCHjzq4FVy4prX3e6pfNkxIhT0qyLIpYPT2umQ7M5s5FTbKNyJ8v4R9b/9Of5M11knCG7c81MWvSzDAXlv5XoH3jQRY3pYz/7CsFENtqa/6lZi6qcURN8smknAl3vkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiEVM1gkYTlOfdtje4OdJssrwcgG+fsAF8YzY4dtvQU=;
 b=nBk5EWUduCrXo+T7w7bP29lJvaNVrizUA7wMuM+2u6K98GidFVNR8YnrGV2dQD1RyppxP9qgp+T7XJ4s0Ap6i9rvLv5DqLSMhxmiHaQK6OvqPyNbDdX17Sh6rOUPbjOXUtVBA6QK4Pj5JiFwbF5rI+Lh0vand7iedWW8eB2Dupc=
Received: from CY8PR10CA0007.namprd10.prod.outlook.com (2603:10b6:930:4f::14)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 02:12:02 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::4a) by CY8PR10CA0007.outlook.office365.com
 (2603:10b6:930:4f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 02:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 02:12:01 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 20:11:58 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/6] drm/amdgpu: Default disable LSDMA until proven stable.
Date: Fri, 17 Nov 2023 10:09:46 +0800
Message-ID: <20231117020946.2912865-7-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231117020946.2912865-1-yifan1.zhang@amd.com>
References: <20231117020946.2912865-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e292ae-6d0d-429a-8be4-08dbe712963a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wa2ywKp4E/3lmCAcZihPHK7CfZZx74y71180ozFMhnLcZ1b04Fbz2RgtGEqPeAsHLTcrYljiVFS7he9XWgpaM/RP8sdbPJgWpTxplfs+sfW5QpbVzT9c0nN0mpSS2ZgHaWpjZPHkmNqP8AhowEB0GQfgei0uhkz18iuQDqE/NQ0oea5SZkIhPkfGc3S/UIruNbirRGVd95LC6soXoBa6VO+JcSTlWc0HeG8bwpHrUQSA2v3ksho1wgTHJ0ri6nsCxd7jR3k5jsb5D2q89zs52CupnXVnlBAoEef8SxiDulnpncmJwN+4zKtWYxJLFJwMsp24sUwpEe2dTM3j5B1dmUcAgiz5wquWn0cdso+ymJWJBqnmmY8CvvjKrYykts0c8PHrJdhKLW3O2aaGOJJyHJGBHSi3WrjGt9SSKFBnitHTWZDwazzUwwfiX72fIR84M8z/KZQjEOJpUiUjICPDDw0F3UBK0iCY1CX6sYszLvRX4MfQMoWFQLWzG4Ge34PpO5CQz0yly+aCGAmDYvswFxXFg/9jDvkwFQyfMn/615r6rEB9iY8z9pcR522FI7Sy2XBBGTq3M0hi36KrutKCushKsIFIjAhFzb2w88cqac54QWY5zvwoVYnuuHLm2Yh6jKadzBuQ6Vp65ZFTOcKyEuID2JsrefWX1IcyiIZS7ER8rtHJBE6rysP0pBMEQIsWQQ5WQSwNA/Xo43RYGbiEA8MxbSKVScOfm1QrXR8DVWdhp8HdCs4czYOxdRMet2wO/WiW9qRw6GLxkvsVWExbImIrgm8eQC1vhQrTdwk1bw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(81166007)(2906002)(356005)(5660300002)(86362001)(47076005)(426003)(336012)(16526019)(83380400001)(82740400003)(26005)(2616005)(7696005)(1076003)(41300700001)(36756003)(478600001)(6666004)(8676002)(70206006)(316002)(70586007)(54906003)(6916009)(4326008)(8936002)(15993001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:12:01.7810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e292ae-6d0d-429a-8be4-08dbe712963a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a module parameter for enabling LSDMA, defalt disable it until
proven stable. The module parameter is used to enable LSDMA ring
mode, and switch paging, system buffer management from SDMA to LSDMA.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 10 ++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 625ba88258f2..c489b8af2ee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -216,6 +216,7 @@ extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
+extern int amdgpu_lsdma;
 extern bool enforce_isolation;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3e7ad86d7fa9..fe21fc4f1b00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2715,9 +2715,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = amdgpu_discovery_set_lsdma_ip_blocks(adev);
-	if (r)
-		return r;
+	if (amdgpu_lsdma) {
+		r = amdgpu_discovery_set_lsdma_ip_blocks(adev);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_discovery_set_mes_ip_blocks(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5d009175318e..716c1701458e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -153,6 +153,7 @@ int amdgpu_vm_block_size = -1;
 int amdgpu_vm_fault_stop;
 int amdgpu_vm_update_mode = -1;
 int amdgpu_exp_hw_support;
+int amdgpu_lsdma;
 int amdgpu_dc = -1;
 int amdgpu_sched_jobs = 32;
 int amdgpu_sched_hw_submission = 2;
@@ -427,6 +428,15 @@ module_param_named(vm_fault_stop, amdgpu_vm_fault_stop, int, 0444);
 MODULE_PARM_DESC(vm_update_mode, "VM update using CPU (0 = never (default except for large BAR(LB)), 1 = Graphics only, 2 = Compute only (default for LB), 3 = Both");
 module_param_named(vm_update_mode, amdgpu_vm_update_mode, int, 0444);
 
+/**
+ * DOC: lsdma (int)
+ * Enable lsdma ring mode, setup lsdma ring, utilize lsdma for paging and system buffer management. Do NOT expose it until proven stable
+ */
+/*
+MODULE_PARM_DESC(lsdma, "Enable lsdma ring mode, setup lsdma ring, utilize lsdma for paging and system buffer management (1 = enable, 0 = disable(default))");
+module_param_named(lsdma, amdgpu_lsdma, int, 0444);
+*/
+
 /**
  * DOC: exp_hw_support (int)
  * Enable experimental hw support (1 = enable). The default is 0 (disabled).
-- 
2.37.3

