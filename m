Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606D1EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40B810E3AC;
	Thu, 29 Jun 2023 04:47:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3277910E103
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGYjreeGpVV1gdDcKbs9bCOU6jaROilsA6auQ58E0U9Pz0kw7amePFtNF8r4zxbPBT5SyzpzR2ynozPbp3vfbXvPUjALU3nHkMuaNMOZLiHNY3ROanP6EiTtuwZ+YT3imdO337dGCQjPuyRdK1GpZ2OKR5iAXKKeJ9JqvWnrs7JECMjO9YYIPk4vT7ihWrjp3O7JT/RiRrYyQEMpxpVj4uUtKMmhOSS/0+vP762NPOaNm3/fvRn5jGPEnEtnxCJssZ1EdLEt8izQZwJNmJIIBHS4cI8750bTW2RwWA164UosKSAFix1YkH+W9rGtKtZ96OnGTMYgJd4xX31TuhiILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkxaDT1KfcQQ5o2I9inqHs3Yx57LxvD48IxFc8ixobY=;
 b=AIqyC59rzm4jg0h6YKJJukAp/fQRpvaTsO8/W3ErbzuRr1KAJBhiZWytnPPrePuthfhQ0FTLbuPpaxLbN2Hd/71fM0FXWy+3A4+NwMYskMxWTGT22fetGKGFQ2SJaOY5+JMzsqsKOv3JqVA+d7FBVNCxl9jbit98DvEkT8VFPnt9uslpgcVrdL2pEsneZpTmNpmTjgInVeYLYb1HczVWnNcmhV8EoRtdwoA0ODRH6VP4mzq78jOqRiTDv+5iIxL0KG9G226SbD31GxYHume+7tHSh+szKiTNjSFLg5vk3d0pERWSVfqDACUkID8IkTJzLoYogD0jZbnS3bKxZSSGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkxaDT1KfcQQ5o2I9inqHs3Yx57LxvD48IxFc8ixobY=;
 b=SYF/ngCWauTFMm+oCwA8YVOGy/Bz1DwzDFzmLcEPJKnJUtMZOI0DAy0HWJlM6tO7lrEut++fIXJyMeo21SmQA/xUeROCaWDGMhuxqI5BoNF3Bjo1An7lF4fACmzT2jiInS4Vx04X5U5ijbIYumu/KolXtP6ei4nRMywiKnzqpwo=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 04:46:58 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::b0) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 04:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 04:46:58 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:46:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 1/6] drm/amd/display: Remove unnecessary casts in
 amdgpu_dm_helpers.c
Date: Thu, 29 Jun 2023 10:16:30 +0530
Message-ID: <20230629044635.2266729-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: fa99fa64-7dab-473c-9f0e-08db785bdf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZCjN4lbmgLdvYucZZcdBZgM00BnEiFoiGTl35RE0W/Wi7wXjKcY2arWJ1JtAYiZgVmobeqXMYSKqlVh3fcRwWuylCaKQSeKj598OTNoC2xQuoChY60mTue1uD3cbUNnar3YK/8cgrKKALVFsjTZzzJE1oQTDvCmBekuMNftOjxXYeP0aK+p4Ef47Bx2iqfu/ZaN/V3LcrRZCf0kfqWLuIbBKcqn+agduQZmieQky/MP/bmYPM0KUNoiLdp4iMahthVeggWMcV2MWNEA6oHxBnHLSrjf5YxgC1gsbOdNV2Nsmo9dPCSUWL9oXhXRKD+ldiuQkvUruCF7gNGDwxdEUHDmqZc1004Z7sRaf3/ahV0EFwxst4oxfQ2XzA2L9rNJhh3GJRIAi/m03j/TWEoXCCqZAnPnEhx87bxBi3DGWP08nXxrZ09QanCVEPrhwxxWe2vlbVl+oJdREH3eYzbD4Lj2Fn4QJsuKO3qBL72Qvy1UPhJmeeW97zBtOrEUnJTJ5bEjjwoiqkkKHdtZEAdkpFtzp2JNt+nQZL5hfXksfWUYiPSVUlJkIxFelReWIMRnc+Wcjqw923v9m0F8eBjQGbTab4oHzyuW16Jh0cO5H5CEyeLIl5FSFr00wffAF2CPDbX3QuWuMIqMzBEObHaAYvOjBjR5sxz+/QBxo9nGl9K1chd0LYCHYAR28CXiFa+N2Y/2sv7dGUqYdbrowYxzbkOr9H3d62My54HviBnATwOMlzFp5fC9gf9r3tA/PCLKkFXtcygc5oT3eUavPxPKKcAdBqgQ1URu13Pt7WMbzU262DoS7Ffu+YSdhZCJQPZP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(36860700001)(82740400003)(81166007)(70206006)(40460700003)(44832011)(356005)(86362001)(5660300002)(316002)(4326008)(41300700001)(8936002)(40480700001)(19273905006)(6636002)(8676002)(70586007)(966005)(47076005)(66574015)(2906002)(7696005)(478600001)(1076003)(186003)(16526019)(426003)(26005)(336012)(83380400001)(110136005)(54906003)(6666004)(2616005)(36900700001)(562404015)(563064011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:46:58.7375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa99fa64-7dab-473c-9f0e-08db785bdf5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following category of checkpatch complaints:

WARNING: unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallocnocast.html
+               char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d9a482908380..c13b70629be6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -426,7 +426,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	total = log_ctx->pos + n + 1;
 
 	if (total > log_ctx->size) {
-		char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);
+		char *buf = kvcalloc(total, sizeof(char), GFP_KERNEL);
 
 		if (buf) {
 			memcpy(buf, log_ctx->buf, log_ctx->pos);
-- 
2.25.1

