Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA16CA1008
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 19:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E2D10E4BD;
	Tue,  5 Sep 2023 19:36:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4028310E492
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 19:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK2n+ThA38nL+HTEQXKkiorMuvkf/I7q2S9xLDIp6q+37PKMhkfLd3VLWB/YSIMlui4o906pXdcP8Qj5vlFFN/Ch+44pMLJ5/+QztbjiCITiMCPikXBUVLyGC/ucCGx+30zeHQ17J8KvRiap3Upt3GoEq2QWtJOvf+GYjPaH/rzBAExYdmvYaA4KQdZxemsTTCo4uRz2Yx/cXL8ktiYTOSmZAj2II18izwqBN1xxj6dvRVGnVStAsFPVvKt/R1gNFAZH8/EJsFScsucREpRDoPr1MPOsm9aq6johZnPaMzmY0dXVZRBTJIFH+HDCOPQpZIp1bXDssxT0e4UtCKcSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcjF1LhFEebkY6OqaXCBprLuCx1g1jhdYcaTs4QI9N4=;
 b=K2dh/sKyBHdRe8LvqkP74hgK+px2MQblAz8HaZvBfJg9qt55QGS9AcLBiZ7SSZXDa+wXguxIRiZL5pA0gstQCWV6HZx3NBIgypC5v2ddPEI3UU29/R67KSpbpBUgmc9btGG5RKWebBTIRCu8SVJzbJa96Fy6tG8Hjli86j3WF7mCtGy0LleRcqT1prCwbXN4mDkj7HMRQNh7ZXnyomg1wD62nNTMFTMZDrj7RKvwhIBTc1+J5bmQn52PibTy8vb2XgOCOZKexfDLnqKTWWHJMywGXD8jJHrVeKdfuJVlhXFd0Pne+XEYn6uqTR4kNCq9mFmBaXdaj1PvNMyf+G+QOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcjF1LhFEebkY6OqaXCBprLuCx1g1jhdYcaTs4QI9N4=;
 b=e4GKhkaDWDAt4R8tx209H0OHzMnlAWnlSRvOluH7MC6KGTOQ6pUgrDfEJ0Fxgzb4HeQCNJPdFBDBSkDOh0NYB21vUNisl5/5KYAep2kMgtpi8TKO7w+67GMue1RRbAAUEza9xqGupFUbmurWfvSPQ50y6H1aLf+hlQ3zcx/p0Rc=
Received: from SN6PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:805:106::17) by DS0PR12MB7534.namprd12.prod.outlook.com
 (2603:10b6:8:139::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 19:36:40 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::a4) by SN6PR2101CA0007.outlook.office365.com
 (2603:10b6:805:106::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.5 via Frontend
 Transport; Tue, 5 Sep 2023 19:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 19:36:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 14:36:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer APUs
Date: Tue, 5 Sep 2023 14:26:00 -0500
Message-ID: <20230905192600.32449-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905192600.32449-1-mario.limonciello@amd.com>
References: <20230905192600.32449-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 549176df-a322-4a5a-6a95-08dbae476d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTDw9bUmxDnNjnhIViVf6nqraqmq+iG5Vom23HLwYA74j7xHCM9wntv1H9N24URMu8sP67sTzO8PdZKU0eF6zRrWyNlDZuVGVqGivqJWPU/2zmvRKgtaQ1DyMCSyvJP31fEBxi9eBrdd1KqSA1ZpNXTvHEkg5LsQcVR7HehBeaZbGPlCcJNgMXFwLTVW+Ml6we9uh34lQCW/j7mp9TuSAKymV8O3k+05A13bziak2/NRx6k/ESHj4WRPC+LDap9yujecU7GdGYsNIna7C499OqHJyHKafVgh8zSKqnBxcXD7s381qV8gOLqS8gHQZnluMreiG/bD4R9zom0PP1mNGFcV6Isvtanx+z/I7qonwsdI4ICf6W8DkMpLSRdHfYf+Pj5jKCrK8rhdnF5jVgje1MSI0qF/J+XWoDT3+QfE3OxTgDbqIXwMJrjwt6h5O7a0SHOzpv0UQLseVoGyeLs756AJqMY4jAD2GLfAdAGxP3WaQSl0ua8eeR9VGE9UQTEtOb8BKtCQCw+WqEYPBbGy3aR9UK2MdfMia7jxxuEmV8TSIQh8jJ8XNeW2fFVnUo/X2hbXsxULKsEEbE0zzxvJKoAt6fGOh2a8v7ugWG9OZYbAhH9unm5ukLthOIRpmnkX6swrR3wdQLey94UCgCaZQteele3XO9UG+hb0BYOZV7JtV9I5dnrVctEOE1NQY+cCSQNOsRhqLqMGEAc39IMEJq5lgxi67DQsoE/MMiWx+TzIlXypy2y2pmG2a5nLrcQx1PofxCPYF+kjxIkYv5QIVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(40460700003)(426003)(356005)(82740400003)(6666004)(81166007)(86362001)(478600001)(83380400001)(2616005)(16526019)(26005)(47076005)(36860700001)(7696005)(336012)(40480700001)(1076003)(70586007)(70206006)(6916009)(316002)(2906002)(4744005)(36756003)(8936002)(8676002)(5660300002)(44832011)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:36:40.1019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549176df-a322-4a5a-6a95-08dbae476d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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

IP discovery is a good line in the sand to expand seamless boot
to more ASICs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9159a7b993ab..19265dbe592e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1296,14 +1296,10 @@ bool amdgpu_seamless_boot_supported(struct amdgpu_device *adev)
 	if (adev->mman.keep_stolen_vga_memory)
 		return false;
 
-	switch (adev->ip_versions[DCE_HWIP][0]) {
-	case IP_VERSION(3, 0, 1):
-		return true;
-	default:
-		break;
-	}
+	if (adev->asic_type != CHIP_IP_DISCOVERY)
+		return false;
 
-	return false;
+	return adev->flags & AMD_IS_APU;
 }
 
 /*
-- 
2.34.1

