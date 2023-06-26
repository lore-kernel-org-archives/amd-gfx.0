Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB4EEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 12:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563E010E04B;
	Mon, 26 Jun 2023 12:43:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93B810E04B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 12:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF4V2hJLeDzJOkysRk28bmFW3pMYdzY0nCak3FrlfR4O/pg/jW+nj/1BUphc9di18MZIaTjdqJzh4z138NflIvqW1Hz5eY/ojnP50Tcq6no5xb4Yb1nYvbI2R70ubFIiNqv7lifkRfQgMzT4huOnJPkoKradX4bZDIBdYePsHgbsMWy4CXPLHOnZhdPNoP55F/NBswGV+nQWGK67hE7+1VoYpCrf8r8BhMh+bdeXDBI2RWUkOUv3MnYYEpoB6y7W8oouaNXFCUDD3fI+SeidVR0Pgbd2z3cV9rq8nBGLMq0nu8tab4uGQRg9rzExzpXrMrpc0w12BbChPt+b2yfc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcawY2/qi0A3QGSpOUyBMgUBQaZm0d1sEddxbIW1qxE=;
 b=i0KRmu8tOrQUQ1h2hoAEeNWj/zgU8oxeGPSOk8FvVMP2PlVBm7OUYQUmGWFbnh+1MUkzWGYtjHZbL82tUyr1ekSvaWLmMVkRzG/iHD++Qm4NYaKyZLXm5d6P7vpNFxlQiXnSHZzVfjPT0OfliJT/nGlKkXK2ShpJ4R1hKbIp5CNDwXXJnIwWSfURSLjDYjZT+j+0tmUQ+pliK6RXip1akjjz6g1xiycgPVql/Qd07QQ7ohlU/G8Zk9adEvhroHaD0IHd6KBCLwE/alAJqsAFuAWnDy+e+DxwABaG3d+hNtnn/X1zqEHdauWXtwHNo79AvnxEbagTlaQCTbiE+/a7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcawY2/qi0A3QGSpOUyBMgUBQaZm0d1sEddxbIW1qxE=;
 b=lb6tgWBF7YRtYDJSVlmy0NuQJycGsSisrJg65rPDcEb8NzndTPfhH6pd3OqXnm4BMmiaUoVhpB7gioBA7LDGOOmpWjCWYhV2CwgVOFzIIkF6I7VXlbCVtO8a9OzPvh4hanas7zwNFHamed0ri/1e9BvvYVFAB3qsxNvA7pkMubU=
Received: from DM6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:5:80::46) by
 CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Mon, 26 Jun 2023 12:43:33 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::29) by DM6PR08CA0033.outlook.office365.com
 (2603:10b6:5:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 12:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 12:43:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 07:43:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v3] drm/amd/display: Remove unnecessary casts in
 amdgpu_dm_helpers.c
Date: Mon, 26 Jun 2023 18:13:17 +0530
Message-ID: <20230626124317.1384122-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 546c0faa-271f-4287-7d38-08db7642f3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HddRoK7JR5pe8+4hkO22h8RIOXRm1f1O/s9wo3xRYhtZAr12Ke0iA7pK1Zp3Q20miplbVBta4mwyloO6mQWu2NMXpxTmMn/atySommE22qe0Sof2a2bai+BpBLDguRnBcDS8Xij65J29J5jT790qOE7H6fbEa72NnvIGZ94zIv4yOmDFvreBEHr7FFUT2opCVD5fXllPs3XXyaiO4mCL7ZHcmADiymTR0g6peAPU3RpKpfN5abvlWaGAq5l/qGZnh4Db2k5hdM1ypVK8s6Jp/aKZBe7N6N9x1H12wkvviKHPMfQ4gK9zGiitNyorhtHPHCwTxcW6h8V0Ydji1WggVxPs1g5zMkLarE57uozaOxNgAQOBAE7CIB9TmH73UhkiO91P91ik69zhs5tjLZJgqD66NXEDyw/pZ2zN2QfYLiJOPSXvo5LqfiIZDzGFqaHrSaiM9aCKBT89FG7j8LtORdJfolDThJLgND5o0wf4vBi1mCLSyiT+cvjcfaLurYRvv++pM9q/02HtAftPgQNdjGNgrWG8uNpXrkzgsDEruNva829fSJJEZ3g1RwQKnyE944THE5xQqm8cEBEurTP3wIJl5LuHenIbkhSklRi++TGy3a9F+BGLqlfyUW9G9yWfviH+rhOCR+Jry7/koa5dSeD1mA+J8UWzK2137EuFWmqcJxIhIDC8UPhGJu03ri3k49uEz5z3WgzMjUk7UtReLLdbEoKLAHtzQRwHtuGetMuS9rli4XPJlXl3EJz5pjT7nsZLNlw+rSH8hggQJ32S/qHysWi5vv70Nl6KHylu1HPj06B6ynBA9ubiBF1/BhcK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(44832011)(5660300002)(8676002)(8936002)(41300700001)(316002)(70206006)(70586007)(2906002)(6636002)(54906003)(110136005)(6666004)(36860700001)(82310400005)(478600001)(4326008)(7696005)(1076003)(966005)(26005)(40460700003)(81166007)(186003)(86362001)(336012)(2616005)(47076005)(83380400001)(19273905006)(36756003)(16526019)(356005)(426003)(40480700001)(562404015)(36900700001)(563064011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:43:32.8896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 546c0faa-271f-4287-7d38-08db7642f3b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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

Fixes the following category of checkpatch complaints:

WARNING: unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallocnocast.html
+               char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v3:
 - Keeping same as v1 - so that variable "buf" remains to local to the block,
   whereever it is declared, by having just removed the casting.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cd20cfc04996..4590deca25f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -400,7 +400,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	total = log_ctx->pos + n + 1;
 
 	if (total > log_ctx->size) {
-		char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);
+		char *buf = kvcalloc(total, sizeof(char), GFP_KERNEL);
 
 		if (buf) {
 			memcpy(buf, log_ctx->buf, log_ctx->pos);
-- 
2.25.1

