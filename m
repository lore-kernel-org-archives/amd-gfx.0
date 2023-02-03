Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E0DC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CD410E893;
	Fri,  3 Feb 2023 19:09:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96C210E894
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH1lbdLaPgeo6Lqhq7o8kPixgoH2VfQIi8Gl6VEoIpqoGCCst1e0XlQVwWZmz1vvLMWcagG4AtcNjLcHoSrGcWiU3lOFlQoocVcXlg5odgQts7fsAJf616zqrdqBGDItCf0s4/fkCVYT6etTcSTf1qkMeYzXTNC8YkZphty1xZnovY0Ajv0Q7XyEXYAaqLFpCF0F2BKFMhf7IIgUh4AzzJdPjkON6bGUwf0wqK7LDFPzr/t0PxGWGwJV04DNdxtZvC2cLGzLfpR8Hd0Bo6xRjPoLb7MVpyqocyp2Oa7iZKaLAC9VaV1rEkhy4G4IagQV/cswIEtUPTH+Gb1wl9Jc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CAIHVento8KLi6Mb9swXrWZDniRsxLM+JOUIzQc/PM=;
 b=MtmQxlFocEvpv7FvnHQBPYDh54KrcswlgWMWeM3q+zBQTBT16h1b+2B3rK78451DXWmy1RGqL8F8kfH/8k2lgfgXd7NJaugs7bAdKlnfdCnLiJlFjLJWQE8cJquqprbQF+34fhdQ082YIucir3BOQCPuhnNXF1GjByTw/XmJwxBUf3lvBEpuKqsAEeB7G1yBGf/TkYdsiRmaqwV3+8B4FcP36uL+GvGYv9ryPmxWhF+nOgA48TUoGamiGCJsFRN8FoguK052sJEWmAdOur/8eVXExxjA1Ru5y1OCOObtggxIc4Fq33N93CgSZUrmxaOFzrNOx2KIeoKJJomfdiJ3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CAIHVento8KLi6Mb9swXrWZDniRsxLM+JOUIzQc/PM=;
 b=HWGUj8o09vLutNhmVaRbrsQLA1H6VUGcp2qix/SmJtXjB5dpwgai76lZyc7WU5vOjjx9X72ReC3iVxlGTiuHwEXlbkuAFAp/wdNQquTGjJfzdctj9OEYb0taEUT/hPNch3C6J14K78dzvOvfRbdMeQKb7JBHanXWSeMUTwUOPeY=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 19:09:17 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::88) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:16 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:15 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amdgpu: rename amdgpu_vram_mgr.c/h to
 amdgpu_bar_mgr.c/h
Date: Fri, 3 Feb 2023 20:08:20 +0100
Message-ID: <20230203190836.1987-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bae92ce-7ded-4a4c-04e5-08db061a2549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DOJ0JXFiWRMg5niQfvzGIZ1oV+4qgT2T9yaMRWEzA+OtM0AxYkUYWEnxZAVug/j+pt9HvQ9+Z+hXTgKhDZMOxtkLnYE5Umy11uq5axiSbyLiZeixRXck1gZeVJ92fHkXfhQ4CUMJzd92a6nv+AZllljYF+H5Bpna4ccNXwGpIxJHCPnK+0N/8HwQrAHmrQcLYXhsxgjmTXy7VbnlTv+hDqqd0kyXMOq6SHfVnx3+cHdNgsJygB9/xVdB/EeVRXtiBV75mc2fmRC732PYVXlLKlqQKpoNgByoydKp9CZTM/68TQliNlTs+FsWKvZSGdpofnSYCFtQlmSIgLpoEbi4+tplyym9Q4CHUhe6QY1R6AgPntTVX8czX3WQZ0RJOB3QFFXlAch+Ju3EzUcgo0ufiEaMZnV5VZye5qGwMnRyV9BEHad81e8Sao3HQdGWcaA2B5N178Ls7llc48+5sH2KvZZR8b61cDT+0XoeiGJvMjIKUagkbKKw7tuCt84LRi5blqxp9mq8srANToXkLJx4AZifAA7+4jUuXFFT87SeBQcgXQfUC496UGp3ZtxV4Sr5YpKOOYo4h2EGb2B7F2CAW12P7nJpWEizt9p18AIHRN5dJeX3bzpTm5MsvKcmBKYX6phU3w/wCdnppuy8G+uHGphEGHasF4g+UDmUHT5kPmaHsEGQ5XI0UuVbv53RcQBLn58Csc7O0u63MQicAA0c6fuxs78Vq/vaT8n4FqzAoQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(44832011)(336012)(41300700001)(54906003)(426003)(47076005)(82310400005)(83380400001)(40460700003)(70206006)(86362001)(36756003)(70586007)(8676002)(356005)(81166007)(40480700001)(4326008)(2906002)(316002)(82740400003)(5660300002)(6666004)(26005)(1076003)(478600001)(6916009)(7696005)(186003)(8936002)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:16.6578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bae92ce-7ded-4a4c-04e5-08db061a2549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Rename the files.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile                             | 2 +-
 .../gpu/drm/amd/amdgpu/{amdgpu_vram_mgr.c => amdgpu_bar_mgr.c}  | 0
 .../gpu/drm/amd/amdgpu/{amdgpu_vram_mgr.h => amdgpu_bar_mgr.h}  | 0
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                         | 2 +-
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_vram_mgr.c => amdgpu_bar_mgr.c} (100%)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_vram_mgr.h => amdgpu_bar_mgr.h} (100%)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 798d0e9a60b7..6a83a24ce900 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -51,7 +51,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
 	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
-	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
+	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_bar_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
 	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
similarity index 100%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.h
similarity index 100%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.h
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index dd2b43acc600..d0a80b36d95c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -30,7 +30,7 @@
 #include <drm/ttm/ttm_resource.h>
 #include <drm/ttm/ttm_range_manager.h>
 
-#include "amdgpu_vram_mgr.h"
+#include "amdgpu_bar_mgr.h"
 
 /* state back for walking over vram_mgr and gtt_mgr allocations */
 struct amdgpu_res_cursor {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a918bbd67004..1061447befc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -26,7 +26,7 @@
 
 #include <linux/dma-direction.h>
 #include <drm/gpu_scheduler.h>
-#include "amdgpu_vram_mgr.h"
+#include "amdgpu_bar_mgr.h"
 #include "amdgpu.h"
 
 #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
-- 
2.34.1

