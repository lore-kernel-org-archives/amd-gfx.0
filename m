Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC0EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 05:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B614610E598;
	Fri, 16 Jun 2023 05:07:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F417410E598
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 05:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haXrHCTKqnZAeY+NaK1H5FJxeLY4usd1BuZm44fQ3x2/TQSX2gKGkzVemOsBFz/QIr+CP20qPbKEXrlpTCJEVE+KW8L1zlcitpTRJJg/oN+hsiYYi2VfV+P39SUAj8oWZtNQPCYQQFWX1/SMoGqdZCNypzu4xSkQ9a/Hq6WiI1VVQ+FG1R63ljLTyB9vDs8+w2qOnYTdR3mcJb512F0xptLXES/KvJsc27E1pia33WbfZDaEQ+25rYFOSGCYpw9osPoVdNeqOrvAj+w3UauEjSTGVOXpMi41hbgSsDTGL7YhEccC0fHKxj5+tY0fHuZxfu6ALnHiBI0PsCYl6qjEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wHUBBXMCOKy+JJODIGuroteB7WLJeCBRGd2xPBLFyE=;
 b=ScklqozLXzC0Fzvk4WxZs/u70QYrL0Ve2fI/XzriPOrQqK2Hua/MnaC88EPjhtLD61W+sTfrsA+6ssx5sqUaaGGsWX3e5gPpvim45nLlBbVS4aP/IizFYB/gNSq2iDITdpms2wSs82OTxmgYh//g/6W6b2RRbQXKXUvX3P2J16stLa53nOlGDVukPCCaerW1nePdfe1OfbbCy3Dx2d1tKtg/qntt9DhCWDh8rWi3LGK4MwYn2uZJ2OFOFwiXyAG996bOg2a25ToftPeDr/z2vJ4rNB8cq8Cm0/HJTMdtB1E0Dk81hSJEfoKiyjtASJ/Qvn8kpohoY3YsaVAA/dgG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wHUBBXMCOKy+JJODIGuroteB7WLJeCBRGd2xPBLFyE=;
 b=SIAg6FJJx168fu5TV5bjsTJLkCw0/DVymQ8wLlhGit0YREeBj7V1pvaDSzZMXlRS8OftbhOlfrZL6ZkU8voWOaGbccRpShg37SfRRHJg2p/pwHVOfkldM/qZmrT8kGozFlTqxGbMnikLlCsJfP2IDQsr75wrhRF3POfP2f/2r9k=
Received: from DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) by
 BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27; Fri, 16 Jun 2023 05:07:43 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::8) by DM6PR01CA0011.outlook.office365.com
 (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Fri, 16 Jun 2023 05:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 05:07:43 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 00:07:41 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable mcbp by default on gfx9 chips
Date: Fri, 16 Jun 2023 13:07:25 +0800
Message-ID: <20230616050725.1464277-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: f92de47c-808d-4b4c-3aa9-08db6e279de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMsaY4Mbyvr7LNZq0oRwoqZgHRePd3fuP3+Xm1IJfyznHCMmkin2lcjy/LXfOBgXDMyT4L/x4KGaoGfeNNknjl72MmY++5FpWMzgJCamCR4YQjO2QEQX6n0/5XsAkSvuRbvrezYA2fNiAAqdQizT1ZPSPiBom0MXzKkMUnpzVoVxr89Vwo6Y4Hk/gvrcLiZYqoUWBUjxhpwUyoVnspb9dIRq2wUG6CixE0TduuUTBTqjW6wqj0jEFbcBwf8FwyzSpt3VVuPpViEc2H+r6shzs7HbEpkJ73flPyM7Xb8xgjC0avXsmBS94NE/BLFbqBKt5uqJIiM2XOBBedaeQp+SODT/DRalFBEVlj7HSOcvvoQbfpNF/mPcEPxRZID73NpxgC+30PcSyg5nnlhfoM1mdO8DhETpNp3U2eWA6HGZH0sjeu0HtbFa4qrGBAewMJHjcHDh5LI7frGZNYSL6qfR8kSS5KHSFWFQ45ObiRXQ5omAaxCgPfPIsSTQB8ZpLAVeHQVOOOyzPeOqAvqbg4h80bclEsZc2lFds39Vzp/jFJpCeg8nkgiKxwnK7udX/paJqL9Okf36JDKVbUkjLvf5M4jC0A87cm302Y1BMoY3jrvSQjjG30IOIXr5u1ocbXiwb3mHLTqON+rdoE36ggIsnQMD1IEjUJH4UhbY/aDCZ8tN+CpWiHn26YyklT/J1Tq5Z/VETjNKhVIPptxkD/2yYUDm4YEc/SNuPZwH+gEqPYyQGQAjPoravka9QEgtpTocrn2rW9xpS7mRENRhSdQkQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(478600001)(36756003)(41300700001)(81166007)(82740400003)(356005)(82310400005)(7696005)(316002)(8936002)(8676002)(5660300002)(1076003)(26005)(36860700001)(4744005)(2906002)(186003)(16526019)(40460700003)(2876002)(4326008)(6666004)(6916009)(336012)(426003)(70206006)(70586007)(47076005)(40480700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 05:07:43.3657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92de47c-808d-4b4c-3aa9-08db6e279de3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Gfx9 is using software rings which would trigger mcbp in some cases.
Thus the parameter amdgpu_mcbp shall be enabled by default.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 65577eca58f1..1b3cfda946f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4527,6 +4527,7 @@ static int gfx_v9_0_early_init(void *handle)
 	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
+	amdgpu_mcbp = 1;
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
-- 
2.25.1

