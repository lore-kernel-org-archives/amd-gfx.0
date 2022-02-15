Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CBFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4CB10E3C8;
	Tue, 15 Feb 2022 07:42:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C91810E3BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHtUEtW9cTwWNfA/7vu3gz2qcvxGzLrpZOarowo9ZqB964ay0lrLxLDwFdHgcyAgo/QTZPJf0Afo7FDUsy5YtiIMXAWUiC5mD2/qJu2YG1l0zTTGMUX0UYsh08UKdWGYh4BNBQKY347xfxtfjvGWfD5r2azyGaEkwTBpxRROWtRKw6RrNhen73W7qbMsb7LRLIBJPGN2IfRnML8nwPg6pN5EKFEo/RNzg2K1oQ96+pGiP3IbbbcVLpx6L+mHzBK0SY01+GHrjv5qmR4a/bsHm7j/MJC3p+8S2/FNWrbfSq1XU/ruq8M2waNtULilFl+FKFBrDAeiswQ0ozOU7FSDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzgOHWFQr07/TO+juqwxQYN2zZmtBTSdYMicNFjPhCw=;
 b=ITcxrVSjI3R/NPZY+7sbQo/72HOCXHWpTvdLh4ZH50wwF8XEf1h1DPHI2FfjJhVemEDsnbNmoLgj+sxy6QEO50kAUyWOHZyBcl+kNuAHdXYOmnTnLNASCCbQZ0LzXw1blTj5C27qJokUCFraUttPqaUksv478ssyO+D4ocuzduWi3R1EXASH+M2yVRGi1cIET8ux4JMxg/AKKAo+4sPqV7lsn1zHjbxZQb5WCLlG23e9QM2iDnxknl/onPQOxGQnB/ARKljUjimQ9k9CVz270AyePgDortllujA6uHuX9GAM27Ke3auuDvdI8IS1AkkvIYmKdp7NrePoBS9hdVyZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzgOHWFQr07/TO+juqwxQYN2zZmtBTSdYMicNFjPhCw=;
 b=lsKc36mCoMnTVTOsiajtzK8rxiEFTIRMrHL/htOU6VI/glp95J9NtnupVCrKEhpbRknUTVThinCpE+1XTzL9QodBV/XE4HrlUVLqo90k+fcPVvnQk/r3uiY+alHGit1BeQ6JN2zgPBV2G3oucdLyHpJFNkpImsuORIozEHndVCQ=
Received: from DM5PR15CA0026.namprd15.prod.outlook.com (2603:10b6:4:4b::12) by
 MN2PR12MB3359.namprd12.prod.outlook.com (2603:10b6:208:cc::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Tue, 15 Feb 2022 07:42:11 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::ec) by DM5PR15CA0026.outlook.office365.com
 (2603:10b6:4:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 15 Feb 2022 07:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 07:42:10 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 01:42:08 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: Remove redundant calls of ras_late_init in
 mmhub ras block
Date: Tue, 15 Feb 2022 15:41:20 +0800
Message-ID: <20220215074124.3411761-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870e4464-a378-486e-4dd5-08d9f056acfc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3359:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33591A5059D3238968F9BEA1FC349@MN2PR12MB3359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoPtdcCNYkErE0PYiPqaCbSqeAZ9mQ+M9YIviE67QqcyVTNq/7nX2AqfDsRWvgwjQtvIg8UmkSPQluV7MK3AzsKyoxyyoMZhzzCRopmZd+87tQnHpkd8J7GPwnmE2Vq39+91GVY9fExsKQkuHxLmoHccm0xLhC5cl5Uvhb4qlJrvjk9yZak2zK3dOFZAXMqMsVRY6KchP306Rtku0/e7UyC0YMUmnuWIP1L7SK1H8Dy+aZvcy4X+85OqdhOClMXIoCEBME9HgtVADNLwDyXHl9+oE2FwFpiQLjLAc4PT6MRwroHE7f25+vRVut6p5MWmvcHvIAgeQ5yoxc25ewvJbqD4evoauKduOUiNI+Nh1OwzRZxl/i8O2qp5ZluK3gf0hT7Wi/zt4E9cSeMO6lAXeLDFA3Vz94mdjFXbv7/scm4UzxoclFKKJlYJBFdWx0/DOhohQsdXtg2MT1DLzp5flybRZMNyBCOgNq5um+e+7z0edpfu1Xkvv2JwBFcUr8jw0i9Zxt85L9Oo3vLKvD3st6wgN1pd43SHUYkJRdlidawV3xnBwI6NU5D77TbpShH/yR50bWRCgtEXnaF9+4/RdPwM3tcKMYZqD30RLeV/AWBCulxMunkZ/GBxQML6TeBpyQ7hW83mLJCxyMH8OkcFkyShTSlWoRx+G/RoZaaWI2Kim5DsyqiLA+9Dwls70+dMw/G1bdkBu3biu4fpHOrSTcFXpwr5sXWQ7BnkW7pHLCY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(8676002)(4326008)(36860700001)(26005)(8936002)(36756003)(186003)(426003)(7696005)(6666004)(2616005)(1076003)(16526019)(86362001)(81166007)(356005)(82310400004)(47076005)(83380400001)(316002)(2906002)(508600001)(5660300002)(70586007)(70206006)(6916009)(40460700003)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:42:10.8924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870e4464-a378-486e-4dd5-08d9f056acfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of ras_late_init in mmhub ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 2 +-
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 67a7d1cb89d6..f443d1e359ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -458,7 +458,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_late_init) {
-		r = adev->mmhub.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->mmhub.ras->ras_block.ras_late_init(adev, adev->mmhub.ras_if);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index ede98db8c126..42413813765a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -24,11 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	return amdgpu_ras_block_late_init(adev, adev->mmhub.ras_if);
-}
-
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 75815106f2d5..240b26d9a388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -47,7 +47,6 @@ struct amdgpu_mmhub {
 	struct amdgpu_mmhub_ras  *ras;
 };
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 94095b965e2c..b719d2c3003b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1293,7 +1293,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->mmhub.ras->ras_block.ras_late_init)
-			adev->mmhub.ras->ras_block.ras_late_init = amdgpu_mmhub_ras_late_init;
+			adev->mmhub.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
 
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->mmhub.ras->ras_block.ras_fini)
-- 
2.25.1

