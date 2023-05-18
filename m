Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE83C77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 15:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4260110E0E4;
	Thu, 18 May 2023 15:07:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C04710E0E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 15:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhTvcFOtX2B4lv64ZqPCncJEddifSqU3pPQYUTf1LKBSU+tgwRLvM3fAOtNoIb4HLBG0Xwh+c+zPE+5lj6MvQFCO2rsyY+D1BaWgIkcjZRSJFnjqeQioyFrVshdkKYBk6lyFVSHp90VqKVdrVwYRcjCWSruEXOgOFRyoKw0dtRuvl82Y/W/iKejrqQB7duUHG1U24db4a/886n7vJDYb7L8GX9ZEVQ9oIM40ZkD+Z5SFm8bhe2li5QLgXbaNSrkEVW+VLe9MRZWfV9uoxONEGXR1k+t3065X7j7J3s9ta+iswtyNFhFEGRCV0jyYSufVx3whFh2Vl+ZBrRyXRcjmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf+Eh3wQhonwR2MvX1kAEKw4b5Uj9PJ3HmZz9ju1sh8=;
 b=SIRgujRbUq4BUjFwSsIJUaM2DdUBDf6ESxqS5c5R5CG4YaK7WwagWN9j1zrDOSZ16DxBAnA5DCvgs+MfCo+G3YJ26kzen58MH5GbqSm7AE0YMwcjv3UBDyQ8uCWD1AIGt++k0IeiVvpDnEZf6JHAD4nl8CwpR7nCIEziMS/t0zvmTLlKocBD1hJTAs1+bN6z7r59/gs/RowKmWWD7IANPJ07ehH5DWo8625oSO+uueKf8WQ4yfEEc8mTGEEKlxnumLxv5x3JZ+175M5FYcr8MEEmUJt5DFBS2RC28SJ0rvm33whjVdiJTPl4vUAODEK4Nx2yK/jI+kgvPi9Kqz78iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf+Eh3wQhonwR2MvX1kAEKw4b5Uj9PJ3HmZz9ju1sh8=;
 b=lqtfTprJGGM1fjX/HH/WXbv21DCkceaIiqKFIzy7bAqsglkH8g/mugeCttdxnAloc/rS4oOmV86uaxc4N5Yy2mG+Vl/sGGcwsSlZc1egQwercXgDZNKScTaEzZBVX52VDRrlc43JmVrCVAjgT5U8odQe95BzRuANih+vB1pzTJw=
Received: from BN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:e6::15)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.38; Thu, 18 May
 2023 15:07:35 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::57) by BN0PR03CA0010.outlook.office365.com
 (2603:10b6:408:e6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 15:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 15:07:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 10:07:33 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd: Update driver-misc.html for Phoenix
Date: Thu, 18 May 2023 10:07:06 -0500
Message-ID: <20230518150708.92286-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c7e8b2-fe2d-44ab-70b5-08db57b19c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFtMoi+pe4ZOG1QMzAOmUuIVZpnQNVIhXN5jxoPkH6Cex1B+7LksXvVrRMoFHSQvn6xj4mSpcEEEI5eC1mMi4FfxQs2z3KfxE/FoOaRitrNiv7n7VEaceDLvDPc5IXvJzsDL5SBIAunDk65WTYrJDVKhp+32ngD3SBmGU/4+T8ySEmdF6my66E6rzoF9Kc0yzWRvuQ6t4U8DyZx88ufDDx5aOEoA+hGGwXYjw1uBhTRC4GEYIdPpWhBciuVw993GpTf+dQ2pP18ojNrkYiH2kmmKDb+4CsgQlLYInVTtpBEQqYVjiMwbNvSefWepuYvdYAmmwlLN9HLfH2t+Q1yZs0rve+1UGOyqXO89t31oldXNnkuv9qDjL3S+SUhvvpJ99b6KAMmqc+11Tnc21m/9q5HKacIykaauZmF9rBxC15false16ffg6TNgtzgSSDquxADmH1Kps5Wfl+Mx8eL9xeOeEHfYZkc60aaLpuQzUiQ0rM3HBpvvzNzj1rYH+Oh4cExb7E/+ZcwN1FJAiJjrLIFxF9JYAH9a096acSgq2P5xdL/GlULBnW91MKsAvbAUYCDK4PLBV+5IMBQswDl+jlHEoZLuGdZb1wEL4gQdIWf0j5e3Ao06zJ8q4/0KZEZlH0OkVXi93iaCJJkLtXDYXL7ecBj2p2nDpBZ8Xov2IeQ48xeL5JIkvvSnglCDkHKCsJv41uEjAwd3vEA1gjfHxge5v+M8pHKIrR77br8zM5tYmKQqyZx78Q9D7RBAtzCPkzQdLeJyITxfMZKS9rnR5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(26005)(186003)(1076003)(16526019)(36756003)(7696005)(6666004)(40480700001)(36860700001)(966005)(426003)(2616005)(336012)(40460700003)(4326008)(47076005)(316002)(2906002)(6916009)(82740400003)(82310400005)(70206006)(70586007)(478600001)(8936002)(8676002)(86362001)(5660300002)(44832011)(15650500001)(41300700001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:07:34.5868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c7e8b2-fe2d-44ab-70b5-08db57b19c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD has added marketing information publicly for Phoenix, so
update the APU table with matching versions.

Link: https://www.amd.com/en/product/13036
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 395a7b7bfaef..9ef623bd684e 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -8,3 +8,4 @@ Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barce
 Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembrandt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
 Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
+Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
\ No newline at end of file
-- 
2.34.1

