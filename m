Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691B4C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 06:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E0A10E377;
	Wed, 12 Oct 2022 06:35:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479B710E377
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 06:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWsHGZ7AKn0P/R6UGOQlA79HenB3Ha1uDRjr/n1Jv3iv88tSM04ucJXfdI4X7UQpg6NBsLZmfIe54rZQkedhiwfyRtgQL+uks0p+ZdxCCJbSVikLVjhQq6EHk1CktidtWQTEENoA2wgUQr8ZFLu4qixiwT8umImGdKqaJUVcrOUxeEybDriWNhGdXaMB+cbr/DraYQoQBBmc1IcccnZZB/bIqwhxgufJCY2Jui+JNxA4e/QKZ7phO27mKPCP59S1Pw/LiH+MuCOcwwfSdT9UOmu5zIiHuhkjifzRmSuo+Yf6lFmOqHuVoTY9UIiCsmmrd9EIhxsyZ6IA4ITimW1cZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7FOpm/qz8ebfnzjoS9dM/YF6rSEDPTrFw0b2zF8fqo=;
 b=cnMpSMJkfhVheJ3Nw2VYul+r1iXV47+XllhLzaexTzPl2G5gP3aMc6mx2kBndS5ZbiIvuzg8xpaGH8v9FJgjL4RO5DLBVRang6XuQXyo2vYFalmvQzn5TJqjs3nMbDBJjuSKUWTvtyubcuEhz9TErR4Gx2iynWwTbveB6dd8D/1tOjOw382rpS7mRIKPtKoA7eBy9riaZyJJTzMM3WAJeWys0W28frJxs/KviB+/m3H5Q6ReZSZjzPafd1eYEj+4dHh3tbKHzOd0pATsK4vagbWxtmHgEbch0gyc0PVrQtzM68a8CiTD4b6ULTfiGXqRKvEItHXzWhtNYCtfUay12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7FOpm/qz8ebfnzjoS9dM/YF6rSEDPTrFw0b2zF8fqo=;
 b=KcEUznT255pJJbLpTEwUhVpq5wsjVP2hZYXjyhCT12q8WYCSk8zrStaQZbFuKlP3EYDz5OuYLiL/6Z9JaJZtCSVJV1Ek85cIUH2/BJZQ7t1qHXvCvpU0gUHC//MatIs/xUI0mC3cGlA8Q6WnHeZzoGdxEbnYyLlsB5TrhkV8RNA=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 06:35:20 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::f8) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.16 via Frontend
 Transport; Wed, 12 Oct 2022 06:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 06:35:20 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 01:34:27 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/3] drm/amd/pm: disable cstate feature during smu cleanup
Date: Wed, 12 Oct 2022 14:32:55 +0800
Message-ID: <20221012063255.67878-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012063255.67878-1-evan.quan@amd.com>
References: <20221012063255.67878-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bb49ed-8c98-4bd6-2714-08daac1bef3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /69m6S0P7eWqIf+zaFA3gyO53iCLT6c+ZZp1uTqog4rwkZnb4YX71dGNECDolFe2nW3P7rTETL5xucCmyRQQoxmPVN+vmiYwGN9s3+qxhvyKz3i+J3hBwOI7bW44Y68vGuES2tdhJ2cMY+o/9Zo8gos/tcOtXsIyKN0urzxBwNtKzC97eAmOxnZhNi7Le5U0/Q3tl+coo3OgWtFCL3GV78QtqGfw4zmoabZ8Cg6dMTIdj5PToSN2D2AWnCmZAq4ywDsIFJkwtOyusPlbCOkrwrd6D/gdUlFIj/8+cVIDBzfgA32aKaMA0IqkXsI4JgQYMxLLs/otk4VDlvDmK+PJOFCQu9/mfTGGO8lne5ktoyiuqzgDvvpLE6dGeT0kHPjzV07IwjhtC7vRskOacxhUlrzjO5OcgrT+tac8tKTG5lxp10LkWfxVZm5PXhyzeV4C9kYpcwqkC07NCwipZQUZeNMqphonS6rr+TqSHXvQR/PDL74Qjij7RWJ2Ccb4nGZXMretbFyCvbHMCgVZq7/6P14KKWhAMoaYas3mTlC4YFnFySMJ/x5zfVGKd+xoAOBE9XMZb6QSl13cR8rCFe8st+HdjOtjy19rUOAdQKqOU/IeNvu957q6aAIQwkUOUaqwxUg7FJCqcENAU8MA6cOc/5qSsUfDwcVDQ3B7UHduRc6zy+zpAVHVoqmeq0Nz0yyugjVDEFr7EFHPOTkrW4G3CiIWzB/Bu9OcvNqLWddZvraW5p7Pzvo6pN9CbsO0/9QVedYdFxQhxe/5wdyzB9dvUPiMOJzOGepFd86XBhineLA2ke5I9dXgfJDdnXPDGj07
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(70586007)(8936002)(36756003)(83380400001)(44832011)(336012)(426003)(5660300002)(4326008)(2906002)(1076003)(40460700003)(16526019)(2616005)(86362001)(41300700001)(70206006)(186003)(8676002)(316002)(356005)(81166007)(6666004)(6916009)(54906003)(26005)(7696005)(82740400003)(40480700001)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 06:35:20.3643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bb49ed-8c98-4bd6-2714-08daac1bef3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can address some reset failures observed on SMU13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ieb4e204c49abd405b1dce559c2ff75bb3887b6f9
--
v1->v2:
 - revise the code comments(Alex)
 - limit this to SMU13.0.0 and 13.0.7
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 13c5c7f1ecb9..b0310b2e24f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1443,13 +1443,20 @@ static int smu_disable_dpms(struct smu_context *smu)
 		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
 
 	/*
-	 * For SMU 13.0.0 and 13.0.7, PMFW will handle the DPM features(disablement or others)
-	 * properly on suspend/reset/unload. Driver involvement may cause some unexpected issues.
+	 * For SMU 13.0.0 and 13.0.7, per PMFW team's suggestion,
+	 * driver needs to disable gfxoff and df cstate features(this
+	 * can address some mode1 reset failures). For other features,
+	 * PMFW will handle them properly.
 	 */
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
-		return 0;
+		if (smu->ppt_funcs->set_df_cstate) {
+			ret = smu->ppt_funcs->set_df_cstate(smu, DF_CSTATE_DISALLOW);
+			if (ret)
+				dev_err(smu->adev->dev, "[SetDfCstate] failed!\n");
+		}
+		return ret;
 	default:
 		break;
 	}
-- 
2.34.1

