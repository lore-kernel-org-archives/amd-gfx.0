Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619C5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BD210E93F;
	Thu, 28 Apr 2022 21:30:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E8B10E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enLkGUZsHj8SqtExYhmRY1JsKxRPqiI/6yMhW1VPHH3gey7m8zAujpZZe2v3ywgP5FnKcgNSlNWOWEmu+q/8er4i6D7XxKvpnsZNz4aNJPgw29KnOu6bdeJB8ewQwkYpQ9jHXp/GQc3ZXRT6B5KxdkVlmckVMXVJREFJ0n+QqSS8imxr/WHFm85QN0/ex2wJ7U7cyD71DmhIEx5CCnzCiBmeBeAPQDIVBDnO2iT3qnPomclrqhJBdlY3wy1+PjBDP3gK7bJ5uqVb2kOUAgufQJhtBDidnQoZGFSRwEqu7wF+m1sitp3ZoPW0rmD/bq/mc3ifa+rANLqMWjvMX47HeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGOUkk7Ptuk36JWoelnXeNnmOdpiUEhoS/gbaBVAWts=;
 b=GZ2q+RF/G2IRWFTuXWDHnzWnyNjMO94qlICfs+dS3mOsN6bHSDPeIWO2irpyIKCRZqdihgPpnkiySviJmA4kl0VzPJA/IvL1ZABfruPy6cRdWG8j4emkw335FvpwppskVZ7d5NUuKY7YU0My20QnRjqeN1440o+Z8/3yZv5o3/KgBYyGAqI1P3RfsTRIPW4jYBtfSVf8/KWFlK7beH8ZXcTAJ6z1nUxiocCoqBnM50cobBCJM2i+lAFo+gKn1aIxdj/NrpMuxq1Kpj1mLeT/GVlt+a9kPMzTjhZJi5PWC4wrgLDPvK0x3HsenQWfaEyQbxe2ypj2uKToHIzlKA6bmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGOUkk7Ptuk36JWoelnXeNnmOdpiUEhoS/gbaBVAWts=;
 b=BuAvRtj/zWAGIB3ADQF4rYzpZU3EsVIwOkwQdS+gp9ZJPyAVy+/o3xGtzY3lTKWJwmHY3sxeBpS0kSmWKJ549sDRI3bnnF2cc9BqgH5i1Bu59xDx8md31CXACKXltuDrQlLWqAsd3VIhNIuOmByGYa8NAWr87gZnjBS4x04GI1s=
Received: from MW4PR03CA0037.namprd03.prod.outlook.com (2603:10b6:303:8e::12)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 21:30:07 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::17) by MW4PR03CA0037.outlook.office365.com
 (2603:10b6:303:8e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:30:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct SMU OverridePcieParameters related
 settings
Date: Thu, 28 Apr 2022 17:29:45 -0400
Message-ID: <20220428212946.700296-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57e8820-871d-4b02-1d52-08da295e440b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5987:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB59872663D45059D3BBDB6A4FF7FD9@DM4PR12MB5987.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtTy6+HbtEL/848m/08zeHULFc5p9Css5DZYNdguQY7F/Z+fsoSkOW4zHkWzPnetQOsvvBHZZlgIaZStfgBqTj5m5y1oDP5jeigmSrtCw6yv3KmsSpMddgaDsLie5GFGwM7CFMpzD88aZT7gY5V4KFQwsgc/pJ9qE7jM2YAvN43BLZMufKOnmMNMOLMJby+d82tzynSljOXZyLrgF0q2CKvIGrvl3DbDzeDQ8lBm1/MCD0xWCshvX0exXeS7+Eojbl8b1vd973E3G9htHxyPM6wDe//mNIU8DkPuQSY2hPGvHFCvj8AbwRvxcpWWqCnNi1ACvvsJCs7QM4eOFiTMj6zSO94H9y3xwd8BuVB7dh94xoOOk/M6J4ABrzLuGLMchEzYK/XZ8mIGsBO1BKz2jrw2J+lGeISaO0QH6+CQCMf0AJaEiXR3aSl+DSG7UBYOe6p/ssfwYE+qCGP8m6eEZssJhxID/eBznRApXjXKxQsX+KkIlPM94OQD+qkz0DzYjglbLPanpdiczZllAdjj/ECT2Mo9NdRxb2yzZLNyAcdujw6u9y0zYOndCTfwJHDjgq/VEoaTyiGqO5PSEfAZ4a+yC9nkt4Dn74uUZubSoiCqVi44Lnk3XZ5AKTxwajH2E1rnOh52uR+BDG+S27MEX4Lp7vEQpOAkGGpDdyeXeiXAcwHIbNqfiUTjIaZY9WuCVWdVQVyy8gynJebt6f8BCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(70586007)(40460700003)(47076005)(426003)(336012)(1076003)(4326008)(8676002)(86362001)(82310400005)(16526019)(5660300002)(2906002)(36756003)(36860700001)(83380400001)(70206006)(8936002)(2616005)(508600001)(186003)(6916009)(54906003)(356005)(7696005)(6666004)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:06.9715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57e8820-871d-4b02-1d52-08da295e440b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Correct the hw initialization sequence.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 85fbb18a9e4b..612d07762306 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1218,6 +1218,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
 
+	/*
+	 * Set initialized values (get from vbios) to dpm tables context such as
+	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
+	 * type of clks.
+	 */
+	ret = smu_set_default_dpm_table(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
+		return ret;
+	}
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
@@ -1261,17 +1272,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	/*
-	 * Set initialized values (get from vbios) to dpm tables context such as
-	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
-	 * type of clks.
-	 */
-	ret = smu_set_default_dpm_table(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
-		return ret;
-	}
-
 	ret = smu_notify_display_change(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to notify display change!\n");
-- 
2.35.1

