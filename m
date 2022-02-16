Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1BFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E92E010E694;
	Wed, 16 Feb 2022 08:09:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0512010E694
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM1E0jzjjcK/qLai4/PCaWhlSf9iWalQ4ZUgs2d5owV6lr/eelliVlEc/5XWo7+TGw6ql6SbLHsPIN5uSPvhxx0c8LSateX6WqsAmKYi84KzihVFami2+eYwt3nhsG4IHqShqcKM146sXpK5lvvMrEpXn4h1vDh+PfGe2W6X9PlFMpJrzUnJvM+4PaLObqPDrgGj8MrwjsR/5PFmvttByLHYs5wAC5XP77UW5p8TkY5nwoDo60fV+NP00JpZV0mGpvWm8WPtIOj7W5RXhEO7Rn6h94GHBm8asUXs+p+p5X1MIz/+nT6M9OzCVytsgrHqd9lcWytChMbccnN5ZB75iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjUQxXs8QJa7GqdZY7ET15uiZ5nrGjI78ucG9scV1Ig=;
 b=e8ZBXHoYI8ZwMyB7ohVXGlhm1BxH65ZIWa+ltRtLWLVMYuO/B62o6mw0j89O+CVNkPJoBUTdM+6e3Z172vU0CS23ymcvI7jXY537I6DDf9mLDBopk05Floqtw1KnlvQiZBhwWWwj8G3t05oMUXwFKBDfdtf/Z9+lmhyoGaYTdYu95NDpbiNTUaRoBXDd9DzY5/3gefHpB1EilQWOMMiqkgTpPHu15Y2KtrBMsB5jDZcJNazJ0MukVMEf+ndI6tIWdkbR+g2jK2BBnEfz3foOyvMaDi2E8xFsx2M9wzNMwiiSPbw4oQeGro4oVfn6lZMsh1n80rFH6T8+AiBaz7cCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjUQxXs8QJa7GqdZY7ET15uiZ5nrGjI78ucG9scV1Ig=;
 b=q71ohGd/w6ANuwrff/2Z6CvFmk0y+L3fjmzCePay+AUUsB+Jbq+pwyixujTVCq2RYYumf9wkgcWqvLIJfWlj31zbCk0zznkF2ZSq57wYiHKFczxOvDWpLhl47pIRDCUQoeSiT83zzxBlA1kS3p7ZFET7DP29+JuS+JV9tXVm7RY=
Received: from MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31)
 by MN2PR12MB3262.namprd12.prod.outlook.com (2603:10b6:208:102::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 08:09:09 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5a) by MW4PR03CA0296.outlook.office365.com
 (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 08:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 08:09:08 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 02:09:04 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/7] drm/amdgpu: Remove redundant calls of ras_late_init in
 mca ras block
Date: Wed, 16 Feb 2022 16:08:01 +0800
Message-ID: <20220216080804.3560484-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
References: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5163e628-628d-40c8-1cfa-08d9f1239b86
X-MS-TrafficTypeDiagnostic: MN2PR12MB3262:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3262DB5411F21F1FA7A090D1FC359@MN2PR12MB3262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QgtOCwMqep3cQsLllrieNF/qi/fVL7GC3zmreNEHYiEskHGhdY3io4MYKoxUM45DZRi9pZs1lC+A3VlA7dz3OtGQRnoGat0X4m6M1caLJzvrzduzPIrcVzJ39HV+EcUXtp9O7Nu+eYiWsi9QtPLhF3etJEJCVvEK9scQ49MzbDOoPLOA6SBCAZ0zvq8gYzX25Hu0HARjuL6wQwjZPvH3bvRW+gpNLldW0OcDgVneIkru2vEK42rXNhCniaS0S0PhXrH/RXMTh6F1uih++rvw0/eZylBbH3kH1dWGUs3zPsB6FK7NaH5lrAGDc0pHC0+AU5QdAF/NUqMmEPy2w6nR9ElO0ugy1eAHlkZ5ju/4ydCRK6a0IRmdgHSsDRwCX9jzE27ent3gxI91qo0icJudB+EUIDpK9JnEjCRaus+vC8Z/lpoKntc7kOFR+GNv0SUdLH4m5gcCnEjBJjOO1WVkitW1UZovk0Yw8DsN3TdOzxenoK0l4gNTzCnaD+JEKLiK2l9SkMWQlrNzVDNnLcvPP2Rrscjg166gViSUunrKp7AvIvv0JR6DvgTjqDXovNBD1+AijEQJjI38uXmeilN6sz0cfEZv07CcUxkuFXAWQwy9DMd7FMMVSGT74QtNgQB1S+scVHl5jdQjvfDAsUyPUvr9Qr7GX0peJnVjKrEy0L2zr9lTvCjhZzyiKT+1vBHXQPCr5YO0sxLPXaez3hesJE6W9x2vIJVN9WttJD7b51k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(6916009)(8936002)(54906003)(36756003)(4326008)(6666004)(5660300002)(8676002)(356005)(81166007)(70206006)(316002)(83380400001)(2616005)(2906002)(70586007)(36860700001)(47076005)(82310400004)(7696005)(426003)(508600001)(186003)(336012)(16526019)(1076003)(26005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 08:09:08.3324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5163e628-628d-40c8-1cfa-08d9f1239b86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3262
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

