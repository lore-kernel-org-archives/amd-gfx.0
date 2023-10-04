Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A6FE936E8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE59110E3C2;
	Wed,  4 Oct 2023 21:22:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65AEA10E3C2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDQcI/1g/iKHYwT0d2okg4/UsLxmqAk9rGnHVOhC6ieC8w8E1Ctq1ei3hBCS2khWVx6RlBHVaKc7PQGAWNdj9gJ3XmHAFXi+m2IyJPJyj5LBup233p0tUZ2AXctGgEkX3B3AvbMoM0Rxt3kWf1M5oioYUmWMWPUwCKJuT/sbLUY444d25+btjX2Zva5Euu0zStPpRh84XrEA6BcG3i0wNYQcKeYIaIIUdQBJt7dn0LVreDPNsvOQnOyGp8MZo4XZc3ix28zrvzEsHGCR3b2xX66uSGSOdoTQ7KT+lOdzOnV3y0N+P4qefgvLAKN4HZHwnNCzlsl4vJ4gOn7xJwt1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ToBQzgbGxLsF0n6FYqZ/mCS7mpPY54oAtc/3Ex/k6Y=;
 b=gSiaYjeGj3hyDzslB4+P/Bfb9lAc5aV2O7RXpkjw/8Ug0Vzm6SO8lHd6rJhSJZjEQaSq8Cxps8RJANSOOjqTlVLO86lLnPRaiS9p3St20rf83bMExSSFptjZ0TKX21MbBsdfiBIOCth9+z7Qm0qFgn/UbRP0cnUSBlG2C6XGVZXKxEu+mZh4qSHAMV1xMt/eXZyT7YbawCgvVdrRu1L2PId1k9fTRbbjlCp7lIf6246uYda8JNHi9d5XU/EOkiEnokRyKyTL4qXhwH8pNP28S/usOZYZeppw2zFKYiqwZyi0awJPHrisbcDZgDEHm0NEIYXwQt/lxQs3aKHxV8NeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ToBQzgbGxLsF0n6FYqZ/mCS7mpPY54oAtc/3Ex/k6Y=;
 b=gy8a6RpbwNxhbfZM+WWhGIf5zGoIW8Oj/YGEIUTA8JElhZgdtKUilCCRaCHioZ+CZ5CRZSLgdk+Y12CEg7jx10o9qnoJ6WverC5ETI8jrE8mJdfZ+j1mVElcdaxnHSAPfcK9tXyiL0fYdW5CHzm9A1HLC5++X6DBE3jwArAE7tI=
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 21:22:09 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::44) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 12/16] drm/amd/display: Fix Chroma Surface height/width
 initialization
Date: Wed, 4 Oct 2023 15:21:06 -0600
Message-ID: <20231004212110.3753955-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dc4ce0-fdc5-4a34-c0fa-08dbc51ff7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7tmYX+Y/Z0MQfkKDzWjXe4JGBMFN17Jpng1A9tEsMcT6nzj/m/S2BD9KmE1ibgCJiCWKWG7w/Gg2mJILiOXgqYmJVj1HOXE7zXdjyA0bcl/9sKiRGk3eBWIkgksCV5IX7hBmLqH/afQPj6PGcYDcPDGG2ThA70GHF8TCjBciH9KUWi6HrfCjKMu8o+7xCnszne46yRnarrWTjNTS1QXIIUy8SzpzkIjZ6YKGX0/HkCvEMyeik79LMhBWiE75W9eBnFnVkDREj5sMm1lW+fvTbh8BcVaqNlR2ZsjangZL6kAiSH2qH0+JElWIra18Br9ICtZ8xyBfekGtZ6xU1GN4d0aipqFsQKidRUe2kOFu8ww3loeIfnQybhD6foAcNfQQkxJhRkGM0e0+8PvHJb3M84OX/eIJ6HFaRxpbl1yiUcRZ86c4xQ7MWm5Oiy8nhVMC9tUJKX4AcAAWqBPe2Puxyw0hpsAx0tUZE7o4xTZvgSlH72ESpXgg5KkgnBsn/NIcMzp+bkT0L/6LOSaW0m8m6shX1TluYy+mXfBbqmYVmCCjPigGwVS6g3I38PBh6Nsl1FcF75vvp+4Vb5g+tcMadXbd/dMnOeX+klSu/od760UEO8IZo3SqueQISUQA0yWwujN1NGjB/3px7bv0PA21KC/m5XxVost2aEQ1SgoMhNnb9miakjbH2yn81IY2/ZcArERhlffohq8qkXMAhx8vDs6fudTmKTnEIGtT229EZ5IR7pBbR2qdb7ZdpomVAOz+iQxeZYpI73eTfuBHe9QMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(47076005)(16526019)(26005)(6666004)(82740400003)(36756003)(426003)(1076003)(2616005)(336012)(81166007)(356005)(86362001)(54906003)(478600001)(70586007)(70206006)(4326008)(5660300002)(6916009)(8936002)(8676002)(2906002)(40480700001)(41300700001)(316002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:09.0947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc4ce0-fdc5-4a34-c0fa-08dbc51ff7a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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
Cc: Charlene Liu <charlene.liu@amd.com>, Sunpeng.Li@amd.com,
 richard.gong@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com, Sung
 Joon Kim <sungkim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Surface height/width for Chroma has another variable that it should be
intialized to, chroma_size. Fixing this will help pass DML2.0 validation
for YCbCr420 tests, DCHB006.109,129, DCHB014.011,012.

[how]
Assign SurfaceHeight/WidthC to chroma_size.height/width

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 2dd8eedfc17d..e5ccd2887c94 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -721,8 +721,8 @@ static void populate_dml_surface_cfg_from_plane_state(enum dml_project_id dml2_p
 	out->PitchY[location] = in->plane_size.surface_pitch;
 	out->SurfaceHeightY[location] = in->plane_size.surface_size.height;
 	out->SurfaceWidthY[location] = in->plane_size.surface_size.width;
-	out->SurfaceHeightC[location] = in->plane_size.surface_size.height;
-	out->SurfaceWidthC[location] = in->plane_size.surface_size.width;
+	out->SurfaceHeightC[location] = in->plane_size.chroma_size.height;
+	out->SurfaceWidthC[location] = in->plane_size.chroma_size.width;
 	out->PitchC[location] = in->plane_size.chroma_pitch;
 	out->DCCEnable[location] = in->dcc.enable;
 	out->DCCMetaPitchY[location] = in->dcc.meta_pitch;
-- 
2.40.1

