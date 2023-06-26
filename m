Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A844EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 05:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB4A10E050;
	Mon, 26 Jun 2023 05:39:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0026B10E050
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 05:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd2qN5Rrb03bABfQQunP70zkYzbvl0JlDrzqKdGy4NOonA2msuuvNzsnj9QWRrn+dDx1GGhMHYU/ipY0wLtGsHn46V4iUzQ+AdhJfcZEXga+wtMtmYrmNog/FMGBkfi8xUs26bxILHQ7UB2jgRg/Y3FuYAmAz2xPtyReMy+yHvVkL7CxklwiM0DbRard/HTp48EDgnfsVplRZccjNcJZzI6FWJtBdRZAFUeky6zad6IzilpFWfWTLPMqwxHz3+vqv1fhsvXSkBTHECgxdLk/TNxWTVhZhqWNUmszp4xKUisEHFrPyzzc/BZspHIR2EkzY6LxNDEq1MagbhAZUy0GGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RCj0G+YBUx53iHwDHgk4/heOkAEuKjI8AubZgvJYS8=;
 b=nIZmLiKjpJjp1XolsjtAm1rfC9zPSNxc8nhTStjTOmKAa4TSDDaGptGnbYav1TB1XGPgcdVklIATTpAGpf0fwxeSGXARU3Jvpb5JHMQMHMTPoqA7q8p5tKzhp2yU2KNOjwN6btmvGfgod4os38nDoUc8ux2Qcm6klOO3jzDoEGgkFLhi1/HHZ8FlK4X9ViUxRKKaLuq9L2HoN/NboB2WWviJ9wQXV/J7dPkn9aC9s81io8VsJawHWOvBtk3Z+G0W1PnFObJXcD5DJ71Ba7s2rhodbPsce45ggRqOvrxKzXU3+GO25+Yd7eVXzFChTL+kf661A4iRf2dx7SvCKXJh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RCj0G+YBUx53iHwDHgk4/heOkAEuKjI8AubZgvJYS8=;
 b=LUOc2JV6NXEpVou8ZUvQACuwMrzw2+3S+gic/WR4tSWNRFHC568QBvJoSWrqeCMddwUu0vfVYpgllHqgX/SOKTMtD+tucpl2khBC17G/utIPfxmUEPdqEvOjfgsYDXNnCRQ1TVS+l4H8LFVAPhAXPlDOPZuw17oLiW7daI0+S1o=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 CH0PR12MB5313.namprd12.prod.outlook.com (2603:10b6:610:d4::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Mon, 26 Jun 2023 05:39:46 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::d5) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 05:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 05:39:45 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 00:39:43 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: gpu recovers from fatal error in poison mode
Date: Mon, 26 Jun 2023 13:39:12 +0800
Message-ID: <20230626053912.1864767-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|CH0PR12MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 4172e579-cceb-4c91-c75f-08db7607bff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEv/qx92R6cyDLh159tVz7zFpiPAHF4kcP5zcE4jFrPJri1wOb0KC+CregKti5il3kKmh+OSPho8etu1psIPyMGiL0wgRWoj5DEkDL6eHPN8DqFhCw4eD1p9AxRox1dT9apH5coogmw6bcI3/FQRi6sxc7bOUr/sq4vJD0OR04u44nRlhpJdBWcy8flqmB/aVprj0l40idjE4MeP+uO5GsGili/Zjq+OrTkLFUvvFc1BLo0MeZWD5/pZaELx4yx9eo5s9P9sG8smGIFw+DGkW/yVKleRZCIUACwlHh5u3fJdSyGZPiYd95KAa0ANkMV0qsrI2BSS2NFlEtql0OAnnQDS6WjTY2+G+2qb0oGQdGtA7IqhW5CavibXdOHPFL2R/nmDC65lbo5vOLHSnkE1dmG4CDig3hgvE9GwxyYzcGk0ovfd2TmxdljA6Agy6O3Rl5CCrZRCFSi+lkIeduLOmh2FJTm9NEchnlio8o8Lsr5GpvSYwm2ipAiLp0lpa0RyFRXsYOcKlrNgrHxjZKBoPIZM9QLdfX5VBSsxsI9Xw4nT37uTY6HTviW2NBoWjwgzcYsIvTE4hskuxsKC0/WX4whqUyRX8wnPXwQrVGIfln4BGSV0kHS0CPJs2QRkduz23S4xonzi4c01eu4ExBewEzNYZNc1wrmIxkyYfZMQKJzmCkiG2oqNJ1n8yyq95BjSsTf6bwJh82L0Zr8iYebOVVM/paPg5Tg2dOjIAjpbdU+6FxPuMcNsnGaJDbJfklMSGxSWswxcHLkvbKPbFqadSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(7696005)(82310400005)(6666004)(356005)(81166007)(2616005)(82740400003)(83380400001)(336012)(426003)(1076003)(26005)(186003)(47076005)(16526019)(36860700001)(41300700001)(40480700001)(86362001)(54906003)(478600001)(70206006)(316002)(70586007)(6916009)(4326008)(36756003)(8936002)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 05:39:45.9418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4172e579-cceb-4c91-c75f-08db7607bff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5313
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fatal error occurs in ras poison mode, mode1 reset
is used to recover gpu.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 700eb180ea60..c6f8b6b50b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2065,6 +2065,14 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 				reset_context.method = AMD_RESET_METHOD_MODE2;
 			}
+
+			/* Fatal error occurs in poison mode, mode1 reset is used to
+			 * recover gpu.
+			 */
+			if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET) {
+				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+				set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+			}
 		}
 
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
@@ -2956,9 +2964,12 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		return;
 
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
+		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
 		dev_info(adev->dev, "uncorrectable hardware error"
 			"(ERREVENT_ATHUB_INTERRUPT) detected!\n");
 
+		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		amdgpu_ras_reset_gpu(adev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 46bf1889a9d7..ffb49b2d533a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -340,6 +340,7 @@ enum amdgpu_ras_ret {
 #define AMDGPU_RAS_ERR_ADDRESS_VALID	(1 << 2)
 
 #define AMDGPU_RAS_GPU_RESET_MODE2_RESET  (0x1 << 0)
+#define AMDGPU_RAS_GPU_RESET_MODE1_RESET  (0x1 << 1)
 
 struct amdgpu_ras_err_status_reg_entry {
 	uint32_t hwip;
-- 
2.34.1

