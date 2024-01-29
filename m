Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03448C47DA9
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 09:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FE6112731;
	Mon, 29 Jan 2024 09:10:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAB71126D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 09:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP0pyAcc2xY6T7whhi7p50maGA0TyVXpjnQAGFwSru0sgqVk/V5vYsN5wiWn/TscdQN50olaglsMYA5oQq+Dex/oasV+bsYeHbeS6c1rniXUO4OTQCKd+i6LVLzDP1GolzjAludyrJOXtnmZkghL7i7SHzNtQMXq6R4a1C6ILOe16yPkCluaTKAcSSg5S7h/a9Re6rao2VAZJiQQPiO2U9pOYblFUB24Mhh6u/RoFjucM+mSTxXXDh4LKeNH/VKYQMk5Dy5lxLiQwhqc/HOWsX6rKXT1YR0mKqM7zscC+fOVaTWXTCGfmLdeVLTzJZXOl6urGfMxNUBCj4ddqjlZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeIG5sJaHqbKEgr9T6uS/sGw22lRJDxZzN5gURd0K5Y=;
 b=hkEC40Gsni/qp1GP23U2de09M0py89jw3AMzGhLCEwNRrD9/5G7WZorhI1DSWMnXdAC43D4wl3tRGP+R/OD2sh1dr2MKZZR8VsrlmF1LC/N9rJ/YL8BzjSZMx8vtsOYYSvLm2LoeDLkQXhBHuZeODfzd4s89Tt/DxY5fr6X6ibveXMbQ6f/4B39DzaoO0fz2/Ib4WFRl2r3VOgIjO4bHRLWvLtl1wECZTfysT2JVtZdqbIXntMjz3GUSLz895CxNkrzBN0acI2pSMwj8MDwgbY6eSHkH9LYO6+a3ZnIVG6SSot9dOinIwr8RCqeFA0ALIqmmfOvTeVxNwSeseHm2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeIG5sJaHqbKEgr9T6uS/sGw22lRJDxZzN5gURd0K5Y=;
 b=CJrN5fIRLfVnLUs+bRq0sVc+5i7ROU7HR9oLdHVRzoMVCv0kcKSIjR1X8qh3FULfrqIr+lo4+27NUMxAH85twJYVlmJiyxRZhM/JHzeRuLyo3sUG7VnFxGRzl8lRDAJ6HG0eX9x3v0JeXxoDL/ZZyv0Urf2ZK6lK39lWGYGzaW8=
Received: from LV3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::17)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 09:10:15 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::bd) by LV3P220CA0012.outlook.office365.com
 (2603:10b6:408:234::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 09:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 09:10:15 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 03:10:12 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use helper macro HW_ERR instead of Hardware error
 string
Date: Mon, 29 Jan 2024 17:10:00 +0800
Message-ID: <20240129091000.2068752-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d8073c-729a-4a54-28c5-08dc20aa1b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aWIglhvqnwFYjSKa6SSSX5bdyRkc5svyamHWFdPe5xrBTszbEv8amKtF2lsA8/gmbMyx6l1eghzH3DsPwnwm+K53fipwsw5DUbzFgag5CNP1NgM1XNl2fzXISOR+eISAED8NNYBibFZP1YkpOsbORgI8/vBSmPIoH89ClQgV6wNNg+mVGjDT3jojKb2FgsQkV8RBDEYXP0O5ZxRU6xrYpbRW/o6A38Iz2P8ckqimPPlKtxbHjtQChxqvdKwbwMVL3mYVraRlCqCxfZp6KMmL/6swo0Q+0kFFfjZtqvEAWIMueecERvYVPonu/VgyJ45ab0F9l8hCKv9pOsOgl2TkQg6US9GXF6wRrrJ4tIVpLSoMpf5RXjlG+UrQsqJJy8IxojJjzG3It0NkmWotOBOY+ZGc4sh5E9KECbZ/7Nmf0wNvsjbyacEaAwQQYBMWv1txxcg+hDF6W7eTeoNkzMAUd8Kk3kzRkTmfk4/ecpS+BA4PPWuG63/LeSw1UdhF0nY7VBoE+fHsDfIGzkgn8xS0EDIgii9hPbgOz9RDgzZl4SQ7y8rFS/HjBW9B3XQ/6Sp3Kt0xq2U4fqRrKThXiXzNhCCBQDlgi5QzKHwExY3AUBLCMu8SjS5iV7JGswNEdJUl4yiPN3Ur9aZ+eMxeqtZtzD+pHMIaGR8iZFz31jv2fz+cLHPPtxrLNDCJUeBM/QRrExV6IoidPmnpNkO57yyzLASajRahFmgcGWoZxVhzF4Jsg+2P74CvUFWBl+B0buT4cYqqLROQv8BvISq4FHmGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(83380400001)(86362001)(356005)(36756003)(81166007)(82740400003)(36860700001)(47076005)(2616005)(1076003)(26005)(426003)(336012)(16526019)(7696005)(2906002)(478600001)(6916009)(6666004)(41300700001)(316002)(70586007)(70206006)(54906003)(8936002)(4326008)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:10:15.1011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d8073c-729a-4a54-28c5-08dc20aa1b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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
Cc: tao.zhou1@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

use helper macro HW_ERR to instead of Hardwareare error string.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d7d2ec3ce399..be525cf3a182 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -120,10 +120,10 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, st
 {
 	int i;
 
-	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture events logged\n");
+	dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events logged\n");
 	/* plus 1 for output format, e.g: ACA[08/08]: xxxx */
 	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
-		dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=0x%016llx\n",
+		dev_info(adev->dev, HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
 			 idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 6452c09f22c6..24ad4b97177b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -212,16 +212,16 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 
 static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry)
 {
-	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture events logged\n");
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].STATUS=0x%016llx\n",
+	dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events logged\n");
+	dev_info(adev->dev, HW_ERR "aca entry[%02d].STATUS=0x%016llx\n",
 		 idx, entry->regs[MCA_REG_IDX_STATUS]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].ADDR=0x%016llx\n",
+	dev_info(adev->dev, HW_ERR "aca entry[%02d].ADDR=0x%016llx\n",
 		 idx, entry->regs[MCA_REG_IDX_ADDR]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].MISC0=0x%016llx\n",
+	dev_info(adev->dev, HW_ERR "aca entry[%02d].MISC0=0x%016llx\n",
 		 idx, entry->regs[MCA_REG_IDX_MISC0]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].IPID=0x%016llx\n",
+	dev_info(adev->dev, HW_ERR "aca entry[%02d].IPID=0x%016llx\n",
 		 idx, entry->regs[MCA_REG_IDX_IPID]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].SYND=0x%016llx\n",
+	dev_info(adev->dev, HW_ERR "aca entry[%02d].SYND=0x%016llx\n",
 		 idx, entry->regs[MCA_REG_IDX_SYND]);
 }
 
-- 
2.34.1

