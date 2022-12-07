Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E676C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 10:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCAD10E385;
	Wed,  7 Dec 2022 10:04:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C9510E381
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 10:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdheSetDiQARgAI8CyZqBVRyQSqEJH2oamFdiv2gQni0Yc/nFvIyKt1DDDaP4PK2KB+k2I20IWbCvZTchXKiqA1B0yO9JvWbWfZMDLrX2EadWo+OWee88NkL8YaNYqNuckhe4C3eJVlZ/t9SLx0iguR9jXUIHFtB9flJqUhHFmBemPupYMYRi4YFUT5xBM1Ye0qPkdPrwbeyu+9P6NlaZmCYK8ggRHULjmdWhr8C5Xjskck/lSWL+Sv9SKjoSCTpxhBB53APN6A4v2FyWAW3CUnLOO7iyoaIzURu87DMTytNeVHzWWolZFdu40ecy+tx35m2vLxgUZKuxQNElxHgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRy18WYWhUiCp8ZVSOeSqBszJSb2gkhMUhfhZUrNUks=;
 b=SQLQHI+NDBuk67OKn0Qif4LuZrFdATHfo0pCVe6zkyJSxhR4G+6BuMxIMcbfQLzbfXNdDXigixaeQFz1k92F3oxv3eZy3XmaPHCJHA0flvbVq2JUgQL2yizHJG8d9TBI/VCHEs9O11JTdgOdVHU9L6MqYd279fHxtCGGvviTtvWu7tkB8EwwWknxPniUTwPiCm6af2rDkjIIHgyDOmOfK/5epyGMiqWXCwriKKoDxnTKnzYMk7RsiU2F8fo3gwoClMc5exGzB/CpeTtTbBo34mMnUyDtLAnMb9GHl9Jbtqku6keuiRa1mYzW6srl5dT5BgqLq4gM1Ott8ZHsxw1FVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRy18WYWhUiCp8ZVSOeSqBszJSb2gkhMUhfhZUrNUks=;
 b=EJHE5a6vmEd7my77Zc949/wYkG4fcha0xTavWJsBZavNuOnrU0lrC2ZUZvYTmU+GYq79z26BOZlz479Y7uQg1bXKTqPWMwenhtVqd2SE8veGCEbjuYT56q3Mlq9+NSYW7Ewdbud2jvY6mRtLulxRiDFZSk5Ypiu21kH/L14RlBA=
Received: from DM6PR17CA0030.namprd17.prod.outlook.com (2603:10b6:5:1b3::43)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 10:04:24 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::4) by DM6PR17CA0030.outlook.office365.com
 (2603:10b6:5:1b3::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Wed, 7 Dec 2022 10:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 10:04:24 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 04:04:01 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: define RAS poison mode query function
Date: Wed, 7 Dec 2022 18:03:41 +0800
Message-ID: <20221207100341.15356-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207100341.15356-1-tao.zhou1@amd.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ecf620-3598-4119-5b06-08dad83a6b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bDJQNBAykm6eWngUVTEVGQ8kVledlvLeHtjwE9JSOg55kllpllHJrEgIn2jyZCKb3fBLATXGduJXQBijWnd7UAMGsN3abqPo/drM002RRQ66YZj7tLZ8sTTXvFkp1a1/roUNFcnsDyQ58q7/WPbS1j3mc7eabkyrUo7fWaKLfafsNwY2QlPEbfQOvhuUDK+q0kCNWwEn4padQVlfhGnoA8FLfXCutKnmyNlTcWhti0LSY8VeE+gg/tCqe3DkagT54/A3Yux/3XxutVpcK1N2+yknyHZidfrAdkxM0iPpog1JMugvpFFKn7H7e6tlCcxRG9RFGXx7gRs2bUfqOII0uQuBoCa0i5qeQX9Nl/P+4jaNZppefwr/wxLhnebgCVxhvg1GX5iy/sD5of3shUTBLcb+6RmxGkHI2JxXdcb8l6LXnPbC/HsfT+R+SjF3G37raPyNmAkY1nDTMZpl8AdCBUK09EcsRE15BHCAyYGq1i+UkwYjPGiFUSb9APsYabjBuGI2d6wt3E5DGsb+jL3W0PSASxXVdDiOHWJ8lxy1fmRkEo5F6s4DfrcM0iZ9CnxD5t/udDcR1ETjEGssqPOTbY9Lbj0VRI298tdC/+PaWOQadhz//cHNngG/a6PS3lzoRhKlirNZWKfXDqrufQJktenIBQoEy/suSOQENGStVwRDOrFi1Spo3zwBZE9cvOslOSifFN8PMmam0JqUK84Hvi/Hh8wGzbsQEve0SEY6ks=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(26005)(7696005)(110136005)(6666004)(478600001)(6636002)(36756003)(86362001)(426003)(40480700001)(47076005)(82740400003)(81166007)(356005)(2616005)(336012)(186003)(1076003)(36860700001)(82310400005)(40460700003)(16526019)(83380400001)(2906002)(70206006)(70586007)(5660300002)(4326008)(8676002)(316002)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:04:24.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ecf620-3598-4119-5b06-08dad83a6b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. no need to query poison mode on SRIOV guest side, host can handle it.
2. define the function to simplify code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54 +++++++++++++++----------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 20474708bc7d..2a5f23316f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2414,11 +2414,42 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
 	pm_runtime_put_autosuspend(dev->dev);
 }
 
+static void amdgpu_ras_poison_mode_query(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	bool df_poison, umc_poison;
+
+	/* poison setting is useless on SRIOV guest */
+	if (amdgpu_sriov_vf(adev) || !con)
+		return;
+
+	/* Init poison supported flag, the default value is false */
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		/* enabled by default when GPU is connected to CPU */
+		con->poison_supported = true;
+	} else if (adev->df.funcs &&
+	    adev->df.funcs->query_ras_poison_mode &&
+	    adev->umc.ras &&
+	    adev->umc.ras->query_ras_poison_mode) {
+		df_poison =
+			adev->df.funcs->query_ras_poison_mode(adev);
+		umc_poison =
+			adev->umc.ras->query_ras_poison_mode(adev);
+
+		/* Only poison is set in both DF and UMC, we can support it */
+		if (df_poison && umc_poison)
+			con->poison_supported = true;
+		else if (df_poison != umc_poison)
+			dev_warn(adev->dev,
+				"Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
+				df_poison, umc_poison);
+	}
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int r;
-	bool df_poison, umc_poison;
 
 	if (con)
 		return 0;
@@ -2493,26 +2524,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
-	/* Init poison supported flag, the default value is false */
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		/* enabled by default when GPU is connected to CPU */
-		con->poison_supported = true;
-	}
-	else if (adev->df.funcs &&
-	    adev->df.funcs->query_ras_poison_mode &&
-	    adev->umc.ras &&
-	    adev->umc.ras->query_ras_poison_mode) {
-		df_poison =
-			adev->df.funcs->query_ras_poison_mode(adev);
-		umc_poison =
-			adev->umc.ras->query_ras_poison_mode(adev);
-		/* Only poison is set in both DF and UMC, we can support it */
-		if (df_poison && umc_poison)
-			con->poison_supported = true;
-		else if (df_poison != umc_poison)
-			dev_warn(adev->dev, "Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
-					df_poison, umc_poison);
-	}
+	amdgpu_ras_poison_mode_query(adev);
 
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
-- 
2.35.1

