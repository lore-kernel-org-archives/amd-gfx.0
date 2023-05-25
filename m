Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B12C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 07:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4FA10E7C6;
	Thu, 25 May 2023 07:46:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748C310E12A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 07:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW90UApcYORO6KtJWxEwCFAuBjc0RzZQ0nJYDCdOErK7p7AMqrt9mxDubUBUnQnzqLRqExZqJwE6QHeH1Dbh8yVkxADcPxBOwbOjyxWOWQRgeC9dTdWUX54I6cKHfA0ULmx7YpP7DxsenlI/SWRm8Sn2QaYeKivKCx1vSSt5pXvPrIYTdOl6ec1FS0Fad/hq8OsriTYeJ2O7wCOAd+BZbcobH9kaS8fIohUPRIj9lnFLSl98C3KxPDy0uURZHxVtqXYbalQUSxmUVixZjPfzhZp2VTdYDxilpXskj4S3NXW+oQSgQ+xNswwevkzRl1d/nz9GNokUXOg6wJpc3yQAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH97Vk5XwLPJcbRlIw+s9GUxCzMchgUvjnWgvBimMCI=;
 b=mckdUmh0+u6HIkhDcY6Syc95lz3FkV39TJCBDdu9pm2wJ2zoYV+R24W6Br4dmstBx0qzcbwXfG+fe5GAUfywc4XPYsHoS+ho9f0Q+oOcqFAvxC+aSYhDV4tIkP0XLRFyAg3CLg4bTJrYVWS3CQ61wusj5K4J9a8oVuC0F0rXXglPYgPsUJAPvJFcO+zx+ZcY68agrMAGlO12RcCWNtJDhxK1o8SJyQPeSSsEt8Qh0D8Z6rPc3Hkn8JOdyyfjk6LquvqWm2RcS9wcJKwqOeWbRC72Cr8dNclG0i0EPx9LYS5Ff8yQLNNta5KA01AwaxQ/35jYtBcrwgbJPG0/gflrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH97Vk5XwLPJcbRlIw+s9GUxCzMchgUvjnWgvBimMCI=;
 b=hwsoPt2dc0FkBZoCIYy2S/fSwMjsXTCj0fGqYeps8AyjN8VszqRF1odUFuMHR3RTagLer6L9APyhQpz+al1R4NP3n9gigZQI+g5AMx1zHbMeGhtWN34usWpUNDWlfMWgfbnXESAc6Io7tzwPvFW6jwU+Xq4tY38C9BuUPDakHuQ=
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 07:46:39 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39e:cafe::70) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Thu, 25 May 2023 07:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Thu, 25 May 2023 07:46:38 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 02:46:03 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: golden settings for ASIC rev_id 0
Date: Thu, 25 May 2023 15:45:43 +0800
Message-ID: <20230525074545.24166-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efa9188-6da9-4cce-de47-08db5cf42c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCKo5R7ohjSlhhRnXUJLedpL0ci2CqTfB+SgGy1h+SGEVtdYD+PgOsbbUPg98z+KViLesQCzpYy3Pf5Ppj1Imunt1r1kJGKw11DqvWNbOjGTUlnsEohc/u2FMa+pNaAaLUn9BqdXwXwiL4XeaU30+VUmM02sJTAJJ2e4u7BRnacWsMlapwqgy8K/Q7VmctoM49HtGRvGpXgBWfCToq5mJVnQHyewcjh+a0DqZ2EXZLhgwXmGd23sd0MMLQsIk0xrhyhB9SHbo+9oWki3VDt5gaDN/uCuGyKhOIegoeh0q9TXa38enxotq2jyAY8a/NUUTb+0xjp1WtAyFc1p+5dCif6UQ4ss1VxIYm9RljMuFADyaBH0l6O3ojlpLsU7MhV6ET8VZZDVj1KSQW3ew5pddbS5UtkxauEZGWqsrocY1NXyuYgOl6dvCDoHEj4zjiiii0Hdo/mra5JW4I6Wd2TWNmbhJ9HxLnJk263+0hdaOTCvqH6jfZCjfr2DCllOtnINCG6LscijiqLMtAZbVM0sDkJORQxZ2EoMDAnhpBJMv8q/UH7xkCY+Z43gUeTPSetyzRIeytApQg87NjJ1MCCY5uQ85m89n1znGeDyJt+0Hnnmg1yzOE95sbyGCawdshodMJv8pN8ft+4W97CKugtuRKjEM3JyG0vHmWt9xUpjgfabjEJZLR/Xtkddiw0eFHGe9RhBs7DW8pA9t+fYm0SmHmx0OUhEc+14x1xU9klCb1eiGc4WElZCAsJKhwunw5kqC1aVTH2vybglcCVggH/Rew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(36860700001)(86362001)(16526019)(186003)(47076005)(2616005)(356005)(336012)(40480700001)(82740400003)(426003)(81166007)(5660300002)(36756003)(8936002)(316002)(8676002)(44832011)(7696005)(41300700001)(40460700003)(26005)(6666004)(1076003)(70206006)(70586007)(478600001)(6916009)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 07:46:38.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efa9188-6da9-4cce-de47-08db5cf42c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suggested by FW team that GB_ADDR_CONFIG is handled by golden
settings in driver to get the expected value

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 97f6f854d077..4f39c9be36e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -47,6 +47,8 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 
+#define GOLDEN_GB_ADDR_CONFIG 0x2a114042
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
@@ -197,6 +199,15 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 		dev_inst = GET_INST(GC, i);
 		if (dev_inst >= 2)
 			WREG32_SOC15(GC, dev_inst, regGRBM_MCM_ADDR, 0x4);
+
+		/* Golden settings applied by driver for ASIC with rev_id 0 */
+		if (adev->rev_id == 0) {
+			WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
+				     GOLDEN_GB_ADDR_CONFIG);
+
+			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1,
+					      REDUCE_FIFO_DEPTH_BY_2, 2);
+		}
 	}
 }
 
-- 
2.17.1

