Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4DEC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C9210E3D5;
	Tue, 15 Feb 2022 07:42:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E877E10E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2WpsjXsm7l5giGGA5DtfYVo/78QORyW9ArITtNN8KATmn/r9dwR3beezSDiCumPhqdenq+y/P6YeC/Iekw1qq7Oai8RA72TWN9hYQDQG8JZo3LJqdFb3kJFTiHATbqqMxXKUwhO3dNnyYLR2hoBxgwvAKkYwbFZyyjL1DSMuoGAkiP8dEtSPXYLSsruq4lgWSe2UO81WFbSOICgZ0GswWUDCaZAupbtMtzcKSNYGoGkXZcOIxjNAOQrbiRMkQ4Ta138CzFvyCoIZfjEONQ5oipQ6T4MnQ67N0MhDAOGxKQIvL8iqC94Bu4TmLdBXsVIeoz+zswG4QDqbIramJuVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjUQxXs8QJa7GqdZY7ET15uiZ5nrGjI78ucG9scV1Ig=;
 b=muFut6uO8oJS6eGvku9X+IKKjcBaEp48KpV58G7yFDiScP2QU3Ksp3MJyMg8ohcmxRDzAKx71uovmWWc7Hxvvacm2TSck93lp2ibuKygCTEg5H3WcDNBS7tMAx6CYdDhw0S2Q9x/BZ9hOy/OSIl1yzeiK1e94RGQOCzdxn4BRpW31XwL2VM9b+jWB3G+/AnnIZWViEo1bZTGAJD7BoZPIhWDkDctp8hHq364I5FLW7qr+0eddq0JuNgbR1oAs2gozrXlWz/dI5/8PjVedqYP8Y8ZbCjTje6oy62CkPvDUgUfNajP4XehoZpRYNLnJpgDKuc4sGncyuuGmm5qnITxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjUQxXs8QJa7GqdZY7ET15uiZ5nrGjI78ucG9scV1Ig=;
 b=oqR5czYGQBLw5B8rFACyWj9c9Pe03dHLZZzmCOWKYxD3dDp2updQMRJbqYCZjYljmXoSyiqWKEK4s1opRcsOjUcGPaLTMNJZnJ3ea3OeFCc/CWbSb+dokv5HfNl9eQyKPODRCRTsUz3/Vuzbbl9nQsnrMw0zx3CwABPZrcgSrbo=
Received: from DS7PR03CA0152.namprd03.prod.outlook.com (2603:10b6:5:3b2::7) by
 PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 15 Feb
 2022 07:42:14 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::13) by DS7PR03CA0152.outlook.office365.com
 (2603:10b6:5:3b2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 07:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 07:42:13 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 01:42:10 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: Remove redundant calls of ras_late_init in
 mca ras block
Date: Tue, 15 Feb 2022 15:41:21 +0800
Message-ID: <20220215074124.3411761-4-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f93fef7e-45cc-4297-9804-08d9f056ae61
X-MS-TrafficTypeDiagnostic: PH7PR12MB5806:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5806B3B0FD8E1629FD514256FC349@PH7PR12MB5806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3nAwuzH0aVcPfvDulPLPfdFGf6HK44vsf4++h/bt8e2bxrVC0FgA9fRR8YSbg/fiSg5vgm+rGXHNwy+Jrf5pD2vz7DL1bc1TE4WSUFjMvqzeZ8cURtXeqLFuUdTifE+Kv4JM0NZEY9Pjp7KwMAqxXqibih8iG31Gm21geSLz5w/12vX/9Z55Wl4hvJEVcz/mVrZhPDcv8Y33sFGxxz5u6+N5DfNfk6J06NEQHfM9DAd39pNjCYzi2I1/TKyDbuZdN4nRXRXnt7mOtCmrdeAUPBPPsS1LU4Gl0DDxFOYhratW2u/kN726GR5HXU3h4geYWRRZyuuuDapSNks6YBxxH1szztqsAYGTGCIFV/+TD422nxH0LNWw3IDbgleXiK3vq/2Eg+7INMf6QLq/GiYa+MJXjI8vVqfqrD1+6BymLHD9Ztd3AtQ//5dszgIyDJwTSS+Z/sPndoaJk1RlYDN80G0B8rirqcTfAJXevLq9zHUj2HC13BIvxAiWWiFfQHk4d1mpuNrJzSr1KUoS+rc3j0q+tVfkXq+QnpyTDNMGYCLnUGsynCwC3AhOt41+4Tti8a+t/zI1tgnKKg4CSRFXGsYPRmRKxWF8CYh1HbVVDdnlEcb9KMCSKUE2dcDAu8iW+TiKhs99nmu+adcOweyOVhYu9Dc5FqBtCMqwRSJlO5pw1LtbDNOYNobQB+Skjt/7hqK2tRN4nhO4kP+eEd5OurOwJBYsVSd0/UExJrZ6z8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(186003)(356005)(1076003)(2616005)(86362001)(336012)(36860700001)(83380400001)(26005)(16526019)(47076005)(5660300002)(426003)(316002)(70586007)(82310400004)(8676002)(508600001)(8936002)(7696005)(4326008)(70206006)(54906003)(81166007)(2906002)(6916009)(6666004)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:42:13.2183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93fef7e-45cc-4297-9804-08d9f056ae61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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

Remove redundant calls of ras_late_init in mca ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 21 +++------------------
 4 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f443d1e359ce..d42e05572db5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -476,19 +476,19 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->mca.mp0.ras && adev->mca.mp0.ras->ras_block.ras_late_init) {
-		r = adev->mca.mp0.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->mca.mp0.ras->ras_block.ras_late_init(adev, adev->mca.mp0.ras_if);
 		if (r)
 			return r;
 	}
 
 	if (adev->mca.mp1.ras && adev->mca.mp1.ras->ras_block.ras_late_init) {
-		r = adev->mca.mp1.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->mca.mp1.ras->ras_block.ras_late_init(adev, adev->mca.mp1.ras_if);
 		if (r)
 			return r;
 	}
 
 	if (adev->mca.mpio.ras && adev->mca.mpio.ras->ras_block.ras_late_init) {
-		r = adev->mca.mpio.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->mca.mpio.ras->ras_block.ras_late_init(adev, adev->mca.mpio.ras_if);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 1c77fe7e9e68..e2607d9f5cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -71,12 +71,6 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 	amdgpu_mca_reset_error_count(adev, mc_status_addr);
 }
 
-int amdgpu_mca_ras_late_init(struct amdgpu_device *adev,
-			     struct amdgpu_mca_ras *mca_dev)
-{
-	return amdgpu_ras_block_late_init(adev, mca_dev->ras_if);
-}
-
 void amdgpu_mca_ras_fini(struct amdgpu_device *adev,
 			 struct amdgpu_mca_ras *mca_dev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index be030c4031d2..15e1a1efeb4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -56,9 +56,6 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 				      uint64_t mc_status_addr,
 				      void *ras_error_status);
 
-int amdgpu_mca_ras_late_init(struct amdgpu_device *adev,
-			     struct amdgpu_mca_ras *mca_dev);
-
 void amdgpu_mca_ras_fini(struct amdgpu_device *adev,
 			 struct amdgpu_mca_ras *mca_dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 72ce19acb8bb..12d09a58b644 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -37,11 +37,6 @@ static void mca_v3_0_mp0_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp0_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp0);
-}
-
 static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
 {
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);
@@ -76,7 +71,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp0_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_late_init = mca_v3_0_mp0_ras_late_init,
+		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = mca_v3_0_mp0_ras_fini,
 	},
 };
@@ -89,11 +84,6 @@ static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp1);
-}
-
 static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev)
 {
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp1);
@@ -114,7 +104,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp1_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_late_init = mca_v3_0_mp1_ras_late_init,
+		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = mca_v3_0_mp1_ras_fini,
 	},
 };
@@ -127,11 +117,6 @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mpio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	return amdgpu_mca_ras_late_init(adev, &adev->mca.mpio);
-}
-
 static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev)
 {
 	amdgpu_mca_ras_fini(adev, &adev->mca.mpio);
@@ -152,7 +137,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
 		},
 		.hw_ops = &mca_v3_0_mpio_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_late_init = mca_v3_0_mpio_ras_late_init,
+		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = mca_v3_0_mpio_ras_fini,
 	},
 };
-- 
2.25.1

