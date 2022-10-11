Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498D0C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 03:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3C710E79D;
	Tue, 11 Oct 2022 03:47:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7109C10E79C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 03:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU0sz23b3pqq1qpzSkzlq6FlliX9eB8dFEQBJooCkTJ9utmC8wG5+ed9gpTlgtgBFVR1h1QdTwF0OGh6Io3j3lrDNenMuHm+q1rCMnPtmNtzdRo22UFsTr3USZG5shjsALT8mBpP2T/KafF6KHNx5d6JDFz/UkcNCdggkDjrRX6tF9y8Plrac4frKzOm3pEtHfpj5q5dkc3GAkyTTrbSolE/fVC3cXHiUaSLTYlKNL9h3HtJzWjMa7qIG8VeIKru8v1rxxsVY6ORfNZCyRNKk1zzbd/L3/f2REM1LSbeP05oaRfbHyPF+JGFD0iYIyKIynDv6ZFW5jBXfPmuExHbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6G/HJ4KJ7MjINg1nd9E15ty+plIE1DvD3LR2ayh1Dc=;
 b=kbk8NKU730vlil9LMSDgFPg3X2vkUSy3co7RWtMotslvkoOw7qhVUKd8ttGPyzQIgU12cK4CNM92GFGGSqRoKTjD4h50cFdrNPmkRideuY1NbpvH4ubHagjDTQJ5t+SfrdbajBJiJPNRZ3Sh43bhCkGXyInzPYlBVBTGlHQLxiH+pfpgYtav3Ql0AZt9uny/o6ggvJLV71GirSI7mm07hIGPK0qvoHMIY78ZOMqEhognClz9VyiD1eUJUCYme/4iwpgBVpkb1NGfTV4uz+6DMYbFhKq9/pdsm6CfXI2TMHfY6hJ1wB4Nwr5PQORBY/EfurFCqIfdHccIyn9I/6vIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6G/HJ4KJ7MjINg1nd9E15ty+plIE1DvD3LR2ayh1Dc=;
 b=KQi2cv1loeRszSQPDG27D/uKpiGccYZdEwOQYVLoENWFT1MKodxnZxy+VOWO1M0Eh+8Ot8IF37kv1TppMTEl7CJQLe+q8hmQkxMgFCPs5QGqYQralmzqHTTiTwrioh+CL4OhtOF2hYH34kdZx6r9Cfy6i0A0iis+SYHFFocLMaA=
Received: from BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::16)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 11 Oct
 2022 03:47:03 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::54) by BN9P220CA0011.outlook.office365.com
 (2603:10b6:408:13e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 11 Oct 2022 03:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 03:47:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 22:46:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 22:46:28 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 10 Oct 2022 22:46:26
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary condition check
Date: Tue, 11 Oct 2022 11:46:22 +0800
Message-ID: <20221011034622.6725-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: bc010797-a79d-47a5-0729-08daab3b4259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8b9WWsQlK0B0ak4llFW5TzV+yhjnyndzkyDlm17iJN3P8vwPLOh/xyv0kFKC+eMEQZ59GIWYwCXJ8ROVcTPlLXH0ZeSEGeh1fBE5e3j1DYKUaq3ZG46M3KSopDiWoid3OobyhSWrXq+mJS5BKJQaOd3SIRnvYOLLaEnhFrbv+HfXScwjMBcqRD2+xin+k7lDP107yNpJxJISroTVZW4sgiCvq4YCR7fwJvY5MvROSpDRfrGwvAe1acyUBeOCY+qwiAcbDiPUIMBCix0osY7qwrvjJftKV4adag7haODdnZM5Hbn83V2TfIALqmyNMFBVUv7vpZBOnbVacaRdDVjYkCzojgY+RBsFzaPXC0E7zSb3WLDUjq03FqIviNlxQEijg4V7V4Tml7AfeeV6T14VgKShX211OCcPwLgYqNRLSIWoeNMQ4W10Jhc75N+8h2H1aZ8dlJEljnZ6JbxBOdVLwExmgdXBv+H9Y52ZPpy6cU9IYYeX3YzKb4m37MwGfJB5EbvKbbTbyBAKnZzhb0oKPQgvVLoi4UUEU5rl2mMUlVZx15HSmGymEMN6WmNzKvpy/Mvnzs+N8yEJurL8jPTnnuWQ51X/CSZujhwWaGg8HQHfL/Dc/N5wXQ7SYQySZn+WIpghr3KGCAn1hxyTPIjugwS31RbbQhFw6FfT4dDeiUUu2dAQK91vl94rfzt+5g2InAtZZbtpYqeGwXD40IzkFAEXzVM88i8Y9wWShFZmEAmev5kSWUEabKGM9IuKQ4hQMuYmKdT9SZkmYlGsZTEfR60aNoiGjIb4PdABL1Sxv0s+rSB9iDXeziqKdRWepT2z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(4326008)(83380400001)(2906002)(426003)(47076005)(36756003)(336012)(186003)(2616005)(1076003)(356005)(86362001)(40480700001)(6636002)(81166007)(8676002)(110136005)(36860700001)(316002)(82740400003)(8936002)(40460700003)(5660300002)(70586007)(6666004)(7696005)(41300700001)(82310400005)(478600001)(70206006)(26005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 03:47:03.0428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc010797-a79d-47a5-0729-08daab3b4259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

version_minor>=0 is always true.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 012b72d00e04..128b65f500fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -526,13 +526,12 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 	if (version_major == 2 && version_minor == 1)
 		adev->gfx.rlc.is_rlc_v2_1 = true;
 
-	if (version_minor >= 0) {
-		err = amdgpu_gfx_rlc_init_microcode_v2_0(adev);
-		if (err) {
-			dev_err(adev->dev, "fail to init rlc v2_0 microcode\n");
-			return err;
-		}
+	err = amdgpu_gfx_rlc_init_microcode_v2_0(adev);
+	if (err) {
+		dev_err(adev->dev, "fail to init rlc v2_0 microcode\n");
+		return err;
 	}
+
 	if (version_minor >= 1)
 		amdgpu_gfx_rlc_init_microcode_v2_1(adev);
 	if (version_minor >= 2)
-- 
2.17.1

