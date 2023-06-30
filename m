Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89676EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F24B10E49F;
	Fri, 30 Jun 2023 15:56:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9DE10E49F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Qig1bGJeF4JsxfOSOGwgkIFGYu0dLBEDofr+bKIlsWPuEQb32ovw9X6j6hc1/0oU0H2kLvEJN5fDuJWSqZcdbvu3p49dWBoPKqv05QD7bJkDTiQxWdiHzBzt6R5YbigrVi8QPIciPegwq73v3OCfWjObe9OLip0D97UQ2ayvl2aqHhfSR0cfomIiUrG9emwvGJi0n2t67ZymNA3qBoGADixJ8Y/SJqIWTf38o8UIkOBO7IOyZQ1wPUhyyWBbKK1O8cleXvy1V2TXgbUN0PXYBd0qAfdqeTVGNBA46oe/OJje9rcYh5Jeiw6YNdCsUu45GOoNRNR4R9XAgJbtygEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZxpwtzC9hNAHqxnepuLW9deWEx8265IOe7N2/G+Sfg=;
 b=oaaRbfFP+B8klX11xa3w5XBl/EbL18ZnP7hTpnniURCptc657MgVWArcO3d5yhF8lnQhYwVGFFkfzPQ32kjIN7/+fuyBlfXNYhFCUQiYwd4DNjmLumOLPuADiGxMvldtE1dn9Qbw0558yUR1nHyClN/P7QkM5UVxgNQWlUajQWpdXFi3kerCVS9s9t9Z3zrPZ5hTH1X3BrICNcYrmSaKhP2v5Vu2P/tQPihWxs5Or1Nj8Nv+M5F56xpni7CzVFvQ/2udRrco52LzGR0Ufi7dLjdSGdwa8PThFRK9ulcGqIZapIgAyvXDH2IwipusPlviFkNobKyiBIB7cwH9Zl8S9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZxpwtzC9hNAHqxnepuLW9deWEx8265IOe7N2/G+Sfg=;
 b=dTvG9W3NHYj6cTNJZuxgaJ+Lnk04f7bs6qsSafb1eVnitTMZvivz4kt3V3RKrBc6f6DV3x3DAUOGyyqNTUruWo1HdbqKO6OCCvSZEkZp0p7gtQ3XH6N4rLURSLe46ce1LVBDbLdCqE7JQ8djgXhNUFdv/Ic1iwK3Ek1/fvN8ewc=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:56:30 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::a2) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 15:56:29 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:56:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Remove else after return statement in
 'gmc_v8_0_check_soft_reset'
Date: Fri, 30 Jun 2023 21:26:02 +0530
Message-ID: <20230630155603.3388617-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
References: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|MN2PR12MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: fbac0042-aee6-482a-e45b-08db798291a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgi36UuYxrjE+ZEObhz3NSgxTsIDUCGS80FN0W85S7jQtAtmtXFpb1BZoyhBoattEJ/e539N6WmLijjfvmDkPivkedN2KwEXnQPKrpMGXcxOB4EMlzeB9AT7Ehn0GvLVDbdE75rDGPfxzQGlX3elFc8Yp/S57W4WEmkdBIrcRYCUWuEQhnmU7WvRKrVx6OfG6yHQN0o0dPPXLGEAIsUGvJNIebx71lOL9Vu8ivSVTx1UTDo1LyX/yD/5/2Plw00lHP9ILFpgCYlASWFdRLM9uZz3OVGLB/jpFsov2vFyGVv3W2sRaKUZ/lpFp0YsLmcSomaVVHWUqO5vMPgevqvlNRgfPqgMK9JAgPMogeqm0xq04+EzScwZ8BnGZsN1MazmGDWBlzeTK9Huf/4/jWRaRAbm4eUYDmjeEyKmV3rbJ1y4DpWs5ziYsu3N8mw8dQb7snGo3ciBuMRboz6bW2eSgC7o90Zj6eYiNuh+D3dV/7N1c4+yJ8szybav3HR+uutSwvfsqIyTJHgXfFKEn3xbDNGGYeD71LIxgXkFjKn0ChR12qInoUDFEJpX5FcyxfzsstpgEnVWHjfvCXd7FkPkfs4OaUK20XYqM0StXLQMDhk2+pseqlWWPo287FY0d3YW+LeSlLntTfn3PSbZaxwnk6uqu7D5p+K5EhxDmEg8xlmLJOuj8vZ3YM0LuA4OGDcPEAhO5Q0yidv28AQELRl//AQiB2QTJK4YvwYDj3ZwiG7mrMAdDE3YZ4OGZ7YzWrNIP42EqDqJ6JIJpTBI374yJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(26005)(1076003)(44832011)(7696005)(478600001)(6636002)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(16526019)(186003)(2616005)(2906002)(47076005)(40460700003)(83380400001)(336012)(426003)(66574015)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:29.9128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbac0042-aee6-482a-e45b-08db798291a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch warnings:

WARNING: else is not generally useful after a break or return
+               return true;
+       } else {

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9b33a1013df5..23bfadca0fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1311,13 +1311,15 @@ static bool gmc_v8_0_check_soft_reset(void *handle)
 			srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
 							SRBM_SOFT_RESET, SOFT_RESET_MC, 1);
 	}
+
 	if (srbm_soft_reset) {
 		adev->gmc.srbm_soft_reset = srbm_soft_reset;
 		return true;
-	} else {
-		adev->gmc.srbm_soft_reset = 0;
-		return false;
 	}
+
+	adev->gmc.srbm_soft_reset = 0;
+
+	return false;
 }
 
 static int gmc_v8_0_pre_soft_reset(void *handle)
-- 
2.25.1

