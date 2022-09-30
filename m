Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC6FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 10:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31C210EC56;
	Fri, 30 Sep 2022 10:27:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A4410EC56
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 10:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMrirkPq54Wk1E5r1bF1wYPRioUGPmoXlDmBr1nc0DYruzTS7O1Y6eAHIusKo6DJcu5gVh1ieJWu++5av5ASBWuJV6MoNFdWdbXdUpleahbeWljVkD/nTrZiRNg0lu4x1ACr9fbSoOzbfvevgvRrbH1jswZC1yLiBR2nfSg2uGijqR22YZXgPJ9EH2Lu5x1mFxozHCU5WbVZQ46tIgRouWSS2ib3Y5bxR+WjlFiTGp+n7Cpn7vf2P3ztfmAmEtrHIAYRQj0eRWQo642VJT6zuQNionIMxbku2NVg+SNbxbFNbhYO1dEYR3kXorZ+Z3rNKMxad043lJmCTWOXxoe/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyLejQXccCoOvpd7gQ6uvwBKQ6BWzvIgHx77y+RQAmc=;
 b=Q+2PQ2+9gQNlIswM3WVPVIax7/lFaDkyxRztrgTFX8vcT2PYQdS/NaPLQXULB/dDMglpM4Yl1lMQh6iuqCsIguVcoItVvoXt1GdwMYiwOOAciswi4h5mvqizU6Q0QT+LMSTG4MDSTbn+puUzlW1+j4YH2/MQ5boyhcGgLRkO1Xr7fWH+6Llr51h6KBSaXzGpTJ0ghc/WeSr/5IrOmVY3UxOtGb/l05M/BhljR+YbCD/KLL94RzE8HpY9ngNOXsVeeckZibcNXbKS6i240HsOdHcbvaAYJ2Ecd4GU9tmY5jvR0cbzwjqvzhzrm01rWIPMeV21NKDhGhrIyH70icbLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyLejQXccCoOvpd7gQ6uvwBKQ6BWzvIgHx77y+RQAmc=;
 b=NMO46BklcbNMSnP4xtqOnnKLtBChPypDYsh3ihHTkgbWn5nsR6HfxPJjy/KGlWP+0ie0rmbptQWxkfPPkh5RdyoiWx9geI+K0m6/dU78M8lcXp+FOARsDu9re6MetXlcZyOomMLGUgLB5GJ4VNnu2L5EyflE2vjmNwi+cr6epdA=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 10:27:22 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::46) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Fri, 30 Sep 2022 10:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.13 via Frontend Transport; Fri, 30 Sep 2022 10:27:21 +0000
Received: from llvm-tr1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 30 Sep
 2022 05:27:19 -0500
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: disable psr whenever applicable
Date: Fri, 30 Sep 2022 15:57:05 +0530
Message-ID: <20220930102705.43367-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 5192a899-0abe-4157-74c0-08daa2ce5c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oSahz77ubML4tDG5IAe6EUX5YZqSbrL2Iehh8SsH0HCgfb1DgdLQ4X6YDXHMgQK6v+2P5UTXpLxOLxDfbzEFAHRldr7sMn/nhHDJILWyHnin6cAlsg8QbNpKNzcJWKR2p5+BYyrc9veNhJVbZhAyX6Heu/htVA6mdkrOaoUZR++/JP8xpx0/zANFnCbCKLzyFVZfjTQjO3t9RAJr/LbHQTjgodSh9iLqyVQx63iLDp8m+/mdMNrkMvUU+gq6f+i2cOMvp1YJQ+b95OnUpN0hZLeB9sL88UUUWFxbhEXhCJ2mDaYAd++wuDpbqhlYOVbUlOtNlo6Wi/05ZOGHYOHv1r5BXmhHdKDBgLnFNur1Kw6EjEfOVjH6KG0FrCE3DmMx8TKO7XGShDc7Bl1CZj9BYfLe+wf6AKYDBM3duU29fPpYaIwNnX2TtPBfXakqmFbupgvqwBo+eZSOxfOxizD+IitvK1QjRHARrpOY6O4RJXBeCcaj9Zpo49WSZ3wVvMnQsxrw0ReuTs/k21lUr3xYUcOTphJtxURpwI4+68Au8xhE9vIwfEW1wNFh+E1J33VxQjMV4HbnDsSMrVM9A0lJwQbha8cGECTRhV8eezbITbeXoy7uX2bUWU3vupU+Rey2gka86SB9EjwFgTuEQ23dTW9BLcQffI3fS9DSaQ7ky+sKOZjXLXExs5tzZTm7Nvmlsz8zd9qWGwM2Gy8bRyjcdq3MDJBmMEOpLtvzOHIo9Rndoc8imCZrML9UychDWzsWkErTRLtjxCyOBCEp0IWnmVrjDTN5ok+UYhkZO/0lnnmorzRSBrY5PlTWp4JBzqt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(7696005)(356005)(82310400005)(5660300002)(81166007)(86362001)(2616005)(8676002)(8936002)(26005)(40460700003)(4326008)(40480700001)(336012)(2906002)(36756003)(426003)(83380400001)(70206006)(70586007)(41300700001)(316002)(54906003)(6666004)(186003)(16526019)(6636002)(1076003)(110136005)(478600001)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 10:27:21.8118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5192a899-0abe-4157-74c0-08daa2ce5c1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
psr feature continues to be enabled for non capable links.

[How]
disable the feature on links that are not capable of the same.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 8ca10ab3dfc1..f73af028f312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link *link)
  */
 void amdgpu_dm_set_psr_caps(struct dc_link *link)
 {
-	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
+		DRM_ERROR("Disabling PSR as connector is not eDP\n")
+		link->psr_settings.psr_feature_enabled = false;
 		return;
+	}
 
-	if (link->type == dc_connection_none)
+	if (link->type == dc_connection_none) {
+		DRM_ERROR("Disabling PSR as eDP connection type is invalid\n")
+		link->psr_settings.psr_feature_enabled = false;
 		return;
+	}
 
 	if (link->dpcd_caps.psr_info.psr_version == 0) {
 		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
-- 
2.17.1

