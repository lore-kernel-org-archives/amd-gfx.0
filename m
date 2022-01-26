Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6313DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 22:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4A210EAEC;
	Wed, 26 Jan 2022 22:58:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3943210EAEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 22:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl8rNx8TSZ29ldORNAa+W6dAx3MrxMjDF7gazshJS1VjiwON2YEXHQ0iz/iFi4ZQKGsM3klrQ90GWuw4E6C5Ln1gZ+Yi9RSDrcHHDn+myy4eRHJZKXF5H6LeSC1D8uGPKKKVJHKcx3r+Fr/VMK1OWprWUIT7v13NUH24TRP6TMRj1/d/617cBQOoSWDIETzn1wfyZqu+f8v0pntoqGJD5yB6vMKU3G5h5GmgV8kzLMoc8c6I/kdgqV8X8RBcuiBuwW/X/y5quu6NrXEiqZJczGSwQ1ddW8yVGYOvG5oBV00Ee8/UkBDV4ubq8qo+QWCPGEG9DAYhsu4JO8D+6fgCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fs8aL9XGdHgAq6qZZqw2yEyPWUV4JgISQ3F0c694tzg=;
 b=DBZYHK+6q48tP27wZkXzzfddZIPknh9btIdqGcC4sKggATlcKFAEGTDCKek6xDzvpkofj3BOHJRW9FatxIjLYuDy1DGNooyhaD1hUTsp97O0g/garniNjCORt8/ZBjdYNt5mIhJemKGDwbnDe+8L4KswJUg6U6zEr1rgDEFMB+MKPH1WLnVKkK/VBmolYaxsGEpYlhR304UE1pqA5w5SCvwas1hYqaRA0siZZL1SXVwVSN05QiWWK42OUh41YyAe4eNhR3bynGisYZCrYJBih0LQ3rWxylsbA4l0XYLBzKu7SH9+j50J03zMuVYX5XeZ2J+HEt0pzyIh3B3gEMpXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs8aL9XGdHgAq6qZZqw2yEyPWUV4JgISQ3F0c694tzg=;
 b=GsaxJFUw9Tn4pkQihm3Yo2vdcSRpUbbnxbn42S86Cx+Ocx4PGMyEd/I6eK0AS3VSh8bJTbHBvFx79Dq5rnqwMo7TFa1cYrsD2RcS6YAL/USwXPOpD06h7uy8cGeGnjhVEQG4hv6RqERjPhIlvTtVAj6TpR40R3SqYzJIcyQ1uFw=
Received: from DM5PR19CA0014.namprd19.prod.outlook.com (2603:10b6:3:151::24)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 22:58:21 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::9e) by DM5PR19CA0014.outlook.office365.com
 (2603:10b6:3:151::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Wed, 26 Jan 2022 22:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 22:58:21 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 16:58:20 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 1/4] drm/amd: avoid suspend on dGPUs w/ s2idle support when
 runtime PM enabled
Date: Wed, 26 Jan 2022 16:58:28 -0600
Message-ID: <20220126225831.16732-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1640f86e-e7ed-4e68-6139-08d9e11f59ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046AF434DF89CA5684F208CE2209@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTHCsn1s3Ll47a2wjGwUouo316bCkznXFgfFdDv9/LeDcIYmlDrKXDkMkpy0T8E02cc9jRCEQ5YoefSSJn+cbWWTPvK3G20yDNTDLC3bJEy92vFuq6dyl44IcQfoy+hledekZr3F3g5+Pvh+KZ8PqP5K9+DLteo78lXBkU1YcWfOCxmdS/daDv+47qt/kQTHlPsWZlJVnYmIJnqQouBfWlhHQjQpKjQas62Yusw23Mt/orXDrczsq8NOxJnu9gn+kuqsbnoM3SWREYuljIzcMOteBS02ZScNTgyFzmhCDL6o+I4eaj0d96/kig4e8se59tFnSlf0euW3NyVfaruIL0+8qYQ0g8PxfUQb2pD6wpsXH9UdgJExHCboWtA+y7qTISYNRckRAP4Xc/KdwBJJI+bkawehRitavumUmgDldVX1M4/t/fMz/oaX+w8T5iJPkj9ePLNWux0LlPJMNdMys75asrrzig6W6uydz3FcAhcj+M2DFS1edxp/vOWz6yxLvWM1EfJQOsnoGH6nDH81GtRjlhY7/LEoxbUjSxNyw2yrBY6TdwT+HNTuhg8ajvj4E5rp9gRaHUbNDAFsA6o+8UQcGoPjh++RPK9oXCqC5S4PYO5tlD5Ha5G+wKUka6eKSzmwfvivl6CSzDTAjGEFwHPtg2Rovv5GryRgvXkfpGL/WZFhrp+TBq8UEEuMrxBXIiZ15H5wa2DxXafU15eqoVn03MbPszHJDRAraAOAUmDjti6qHpc2RWqnoeM5Im6UAUsmDAO/guipYrO4PGD5Er1BOe2Rq+L+WLNQsddTxZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(2906002)(426003)(44832011)(508600001)(15650500001)(966005)(7696005)(36860700001)(336012)(16526019)(36756003)(26005)(186003)(2616005)(8676002)(82310400004)(8936002)(6916009)(40460700003)(83380400001)(356005)(316002)(81166007)(54906003)(47076005)(86362001)(4326008)(5660300002)(70586007)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 22:58:21.5475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1640f86e-e7ed-4e68-6139-08d9e11f59ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Prike.Liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dGPUs connected to Intel systems configured for suspend to idle
will not have the power rails cut at suspend and resetting the GPU
may lead to problematic behaviors.

Fixes: e25443d2765f4 ("drm/amdgpu: add a dev_pm_ops prepare callback (v2)")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1879
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Move patch to the start of the series so it can go in even if the rest need
   work
 * Change approach that if dGPU is in BOCO just skip suspend
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b0a620c26ae2..922accdd4246 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2294,8 +2294,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
 	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev) &&
-			pm_suspend_via_firmware();
+		return pm_runtime_suspended(dev);
 
 	return 0;
 }
-- 
2.25.1

