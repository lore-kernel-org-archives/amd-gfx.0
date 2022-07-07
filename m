Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1815C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 20:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB2811B499;
	Thu,  7 Jul 2022 20:55:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128D811BA9C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 20:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhn9E1SXtf7bp3niF7HpVN7T4ZYlPvXObUeaJBA/RMKoWR+Xxv0O0fr684llKcE1RG8RcHtqZTqacnCiCS2f/0GFgHc/rjapXHvsQjjIdLNDwMDleZ33UZVrA9qROPRR83iOHR6mrP0YliDdeZ0FtfAGlSvpQ+fOP1KnVDsUMpV9f8fgueb1rWeBDY36QqwO+/3K+QxD6rF6jmuQ/+81IPan6D+2r8kZrariV0T+XKlKpIwjxAVyiHEfBR0dUeM19+OGa87Rl7rnF2890zWzGBP3DsKJNEI7UNhS9vdZCr8oEqFkVe3WStwCfIf0JDyw+138AjQgk75MFvYiO4pFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0gGWZcMX9njJ76zx3Q81d08jMiHK4oxQu5FXU+qp3o=;
 b=YzNtrMyMM0d/smD9uQCmUdBg99R60sRxE4JyqYwbmNjoP15KCqoo93v19BBUCgz98zDBE402ow6bhxDeBOu5Jsiag7dNGPh8CeGVX5TDcmdv0eQHmCOWchZ7BKT+a3+B6H7Qfn1Ud1E+vDC7NCLHHBFyn9Mvu3XyQOslEkXLMhoON80gt1gj6oYBvijfvO5Bz9iqSjr4YvKAk1qw3WCTZgpSXoLYe3GDxycE4HHJoqkXj6jHvu2tfmRFW4fdL9fAjloRkIL4AnayifngWqk4LFdup1mRu/bE4vs/WadxUFYMrhRHVgvIpo/pYjPyl5sCpgH6mVFPuT3aEjFoa4yEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0gGWZcMX9njJ76zx3Q81d08jMiHK4oxQu5FXU+qp3o=;
 b=2R3slYagzTj1RN5E4FYx/ra8Vdy74+ARHvGGv4LBx8P/5H2VrF70xIoGb8SSRzZZh9aPWDuQlW0WN9QivCPpulcCEZd2yl97pOKPUvFszlzdworg2gpQ3lfckuRVhuIfNlpsbYPYTp4paa519HiWQVt4Y7lM+GckBV1MQaiMc3k=
Received: from BN8PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:ac::38)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 20:55:44 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::dd) by BN8PR07CA0025.outlook.office365.com
 (2603:10b6:408:ac::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Thu, 7 Jul 2022 20:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 20:55:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 15:55:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc10: adjust gart size for parts that support S/G
 display
Date: Thu, 7 Jul 2022 16:55:30 -0400
Message-ID: <20220707205530.899499-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a49798b-532b-4996-d034-08da605b0f2e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ge/+7uL22JI+D61A6dQT6iTfkfgCGnR8Wl7KCky/ID508TklsOG25FubgivLnVGbnKcg7UVngiGKcmo5JcUnP/+HP7As9ZYS/p/M2dgZqGHnO46S2p3QxOil+oAHaj7NiH95iCZd8niSX3ZxMAiwp/K+NfmfSUrJSlgHyv3nwnKACepHOKPYBOH10e2ZDVV0QP9jxb7BnYOg15brTltldfJRfE5PMIoQJQCn5QpV8UViPG7uQbvKtvuFg4m4CFMExmqktReDaEaOLqb/4KlulYellBETsBitGC9yvXlh97t+W0MPXRFH5O64PQ5VpDrjLuEySfWmI1noVjLMehNPsJiD0tFxGq600jZ0v3Js6r58EOxqVUWJ5eFxzt+FtoHG2Gqcv4zNjGqIE09y9xkVJtj9JBE5YcQFHHnAq0xzgsKUpi6CYhNYwYoUAW8BfzXL0wamoaF1Txhz4EmFCN1ds1+YWiA8xocrsCaToZfy+7j86cCuGfbP6II7HnG4wZaYmuslVFq1Miybly9DKcfRGv+lYg92hhkBrRwwu96x//orPR7xBZwnukr+iT61TA7qgXy1ky2TGVvGecsHOu/OQDe0PO6i39AaUa88nNjiK41Jz4Mm7IwHW8QcNlIbwNgJgg13ipO09bTOmR8F1wjRyEzAV5NKTaKOjoGvpT/1G/5X3EKaIoq3P66cFKhzSq9qxKgyPZh0agQy0XJ9DQRxbYdVHHb9IbxYp/8ePcA4Ok+9xtzUaeuNNghjo9Wz5aBE8mmds8LTAGAxLmu0nvl7Ksg17XwL6vUU/QihxVn/PtsYXBRq1yCBGFEszg1X/4+dR2A1hH7seHUrAJydk3852U/xhdwWRVyXWowFAMi6YTrqI+m0cXcXnqmFQAV16XEx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(40460700003)(82310400005)(40480700001)(7696005)(2906002)(34020700004)(82740400003)(83380400001)(81166007)(478600001)(36756003)(86362001)(6916009)(70206006)(70586007)(316002)(36860700001)(4326008)(356005)(8676002)(16526019)(186003)(1076003)(2616005)(41300700001)(26005)(426003)(47076005)(6666004)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 20:55:43.8738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a49798b-532b-4996-d034-08da605b0f2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GMC 10 parts which support scatter/gather display (display
from system memory), we should allocate a larger gart size
to better handler larger displays.  This mirrors what we already
do for GMC 9 parts.

v2: fix typo (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 25d5743ae91b..1772f006c61a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -834,10 +834,21 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1)
-		adev->gmc.gart_size = 512ULL << 20;
-	else
+	if (amdgpu_gart_size == -1) {
+		switch (adev->ip_versions[GC_HWIP][0]) {
+		default:
+			adev->gmc.gart_size = 512ULL << 20;
+			break;
+		case IP_VERSION(10, 3, 1):   /* DCE SG support */
+		case IP_VERSION(10, 3, 3):   /* DCE SG support */
+		case IP_VERSION(10, 3, 6):   /* DCE SG support */
+		case IP_VERSION(10, 3, 7):   /* DCE SG support */
+			adev->gmc.gart_size = 1024ULL << 20;
+			break;
+		}
+	} else {
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	}
 
 	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
 
-- 
2.35.3

