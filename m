Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA2C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 09:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4287510E0BB;
	Mon,  5 Dec 2022 09:43:00 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A37B10E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 09:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b11L/pG4tm+4jAeix5PUkmkT/kkcqcPd34l2UGS96fy/fqI63UuABBk6e2J2iwjk4GDTmvM/cX12rLvjymQDjspUhN3TiIPHg76gyBGOCM6EbO6DdC/m82xVZ0Z/sCDleeHKL3X7+Bu6WBULkTMOdFnGg6hHSd6CCtT5f9j0FKsOonZTsuXgzBxY9SSI4Y0zhtzccYRr9xBfrB1Cmm99v4BeUgqZZNAwMJH9xPQpswRui8dLns4BN/1vDJ3fmE3wbb5OZsF4jQZHoJsrgFHPfaocFqwXyEjvVHiL/HVm1fGnxXmIJ1MdV38iuWJbypgd61llYNPP1w4dcHrmkZichw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiYMwOaAcEBUhE79ZGiGSoO+EKC8ldG7D5E1pyA1kK4=;
 b=Vnw6gqSuVRphUl7gjJBqSZ2QQBjn+Sx2RWSW1/dTfKX3MyiT4x8pqlQFqGnWeFo9FrCYwDnWwJGJUAtETFLKdJMzOsm6JxCaiHLxYLXr7KF9UUKdkQFFswx+vCxmULIntnEg96eysbAbis/QENAP0xZ7J6qMEVXnEgmn6THbkN5orCliSfv9xOCfv2XrhMeVkQ+L9Xz8dhza3amm51lHI2b75vPkie/jNWxxZRC9VMV2KWafEEtRvES9SyIGWq1tQdYfd/Pm9+Lc5SmBxJpdD7nr4j/qDQMZeOSKfkbuVXT3ZTEB+bkI/22XztF5IlBpWncZTWNlrcjSzknC7HDoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiYMwOaAcEBUhE79ZGiGSoO+EKC8ldG7D5E1pyA1kK4=;
 b=0/J6Ju315qlUY0uP0Ozre/i2SD8dsf0rB0A2Xlrrjht4x0QyrT6GHqsCvbD8JKRPr9H0iIWFEXYebKXIBvO6E5uIfhae7R1oT+piB28xVWogYtYjA/bEaRjsNwZP2Ule57rJpWQoipWwFfPnvu5xxNgv6oLiYdTZfteTsg8GFxc=
Received: from BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::25)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 09:42:52 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::2a) by BN9P221CA0003.outlook.office365.com
 (2603:10b6:408:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 09:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.13 via Frontend Transport; Mon, 5 Dec 2022 09:42:51 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 03:42:49 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: enable GFX IP v11.0.4 CG support
Date: Mon, 5 Dec 2022 17:41:23 +0800
Message-ID: <20221205094126.2190885-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6c6140-700e-4298-15b0-08dad6a513f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GG8xzX15zi5wzvTuJgjcjyS+BBWUEXTWdl9yeXVKDygDZ5g2ig5RTcgI5w4iIZjK9/BscGA4pqQNiXTg0ZEW/i9SO/XpjiPs5MMX6ZBPTql4nFlblxm3XXR8+nJkaG+4p+BbCeoZSrRqtWwpHzy5UgoP6heaym+BY3X8ftEmc9DLYc4dBiCBTbsXcEvX9XtIWkmad4+Sr4Hfje8TfR2iDTH2xuEXpxeNBAZFCc3oyBZF3fbxYI+Khvz/sWdoPcOLkvqWtGamwvyafbcBRIFK7EauUXH1WkMjPyz54z6Uf7h0UgQ42+FVfoXbS0Pegx7VDT8WuA/v5/VLF7e48bWXAjeainoyl0p+DrLOUvHd95Ae3DZNQOXz1pmare6IRkPzS0foqrVp20kO8jzdraX1KvFfkhNxl0gfQt0Qz7opvcwF2H40AmTd5y5gErnthxqm5RIpQMFEgtqhRS6jz+USPkDBqt/1OfvADs8uf/A6auaAyDymnmc93InlcZbRgaHIg1D4+pzniFuPi7ZPgWgdE3Dod83ulRWAuB8gCBdbcy4RMqWWHhZLbToB0C6AHKX9wGdFwI815ZT/WDRyIXSHDXRJMi4jwG2G2PcE83zRHv08wsjbf/iG2x6R61GWOsRzPoyGpEkQKeTw7Vc1RdhuvJt2WDIa5Y/zfxKbbEOxibqO3pu/MxCMaLcPnqQvoqPDhdikOUtAEnKEYqg8CV1sYpylYphy8n/mMMu24DAN3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(40480700001)(36756003)(336012)(47076005)(186003)(316002)(83380400001)(1076003)(7696005)(6666004)(26005)(6916009)(54906003)(426003)(2906002)(86362001)(70206006)(16526019)(36860700001)(4326008)(8676002)(70586007)(356005)(82740400003)(81166007)(41300700001)(40460700003)(2616005)(478600001)(5660300002)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 09:42:51.8523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6c6140-700e-4298-15b0-08dad6a513f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add CG support for GFX/MC/HDP/ATHUB/IH/BIF.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 41b94c824717..7d5fdf450d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -647,7 +647,23 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x20;
 		break;
 	case IP_VERSION(11, 0, 4):
-		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_GFX_PG |
-- 
2.25.1

