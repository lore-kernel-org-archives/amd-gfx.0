Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BADC32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB63910EA04;
	Thu, 22 Sep 2022 00:19:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB7F10E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfHeZrJDJ1nmuBCD8Smr/3I7O10mzZwd1RgYHUkhNeDv4fNu7Wml1qs57qIAEacHsdy4HqUX4U77HBGHg5k92wjk/MTyoWb9CZIAdb/ysKqk7Rz6d20IURLuCUD/7TTgazVIa6RKRl93vkGSOj3cQDlqmaxTu2lzXiQ4PQ0FLEZOUy9QrBJOY2x523C5PQYEam0yu4Wjx9ZjpSfJfFiacjELm2pygrPGfKXSLkpSRt887MytTgWJkQ7SHobfwkqBhyUD9uSa4R4cZ7RwzHIduTNQFuz/1k1F+m7h/ZAYFsni3co7mhVZrmFenWHQP7cHsDDzZUKg/U5nEH8XDCPjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vGuRk/a2ZnBGWiIrU9X+GIHHfArCftuMK1pqZyRkJY=;
 b=ZW/3YG2F5JQI6xLfJeq/Qk0EWfmRMAC/uERbwb7pxfCeM20TdQfILmRXu2VebvyKj/2OguBnq0alsZ5qrfUZlvmKt+iKsM1gg5/LZWu0TB21xvNJFeuujBFJSspgrIecHmqzLCGbIdo4N3Z6mEipPC/QmhWTG1xxOu/9Gjld4q5e8WnlAAUyRQTQmxIURUnOdE02mJVjdm4PU2/W40TStcOQiTCZS8PQ+W16a/R8YLvxsu3mNZBjaCAozMM7/JiaVP9W6JjttwYP0v4GOyenM0XItMfh5a44eMn8VQRC48T2r+lM+7j8e7eI/KdW7bBKTR/p3gHJ41cni9BMZqVBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vGuRk/a2ZnBGWiIrU9X+GIHHfArCftuMK1pqZyRkJY=;
 b=Y51/kZzZrbLq/WPwysYoJoByUlQT36rgJouNu+pVsMACBb7qCq4Znq+QPZopv5aOhaE1kNxpRYlimJFAQOTmGOY/7RzA1zO2XylzkCUtamyUeVMtJVkqJj4KEsk7wr6H46Xn9opN7M8FOEQWLdp+XjcJuPbWOE4EvffV1cTm+w0=
Received: from BN9PR03CA0872.namprd03.prod.outlook.com (2603:10b6:408:13c::7)
 by CH2PR12MB4891.namprd12.prod.outlook.com (2603:10b6:610:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:23 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::47) by BN9PR03CA0872.outlook.office365.com
 (2603:10b6:408:13c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:23 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:20 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/31] drm/amd/display: Cursor Info Update refactor
Date: Wed, 21 Sep 2022 20:18:14 -0400
Message-ID: <20220922001821.320255-25-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|CH2PR12MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: 166b97a3-eb7f-4e2d-d8d4-08da9c3019fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwwFaHia114I8pTfBvG2jWbYP25dDmCUbm2+jD5Tdxx6lz1pK/kGgCJ03dYyWrXdp3T41cBu2gzoUjKx5iQOeFCm57XLQAU/nxXq1wpgcylbx30TTPTvI5w8itSR2Hai+LR7FrnRj9yDJa3Kgs/UPJCEZLvOsBg3tX6gFrZy7+O+CJuI/3eKlOWweGFpTuNB+53PIQcD8JXJ7QH3TtHHDJTDOIcGMmeYkQmsOCNPX4qo34xWyTYkeqIHA58BFlQFENzNTvJQYZILSDzwAHa/kSiYUW8NnqQf02KKODds5RDY1aQfM8Rnegtbc61NFpIb8V6ItHOluIuy2XgK75oqa9VQ6YI45i3IgHvskOxIyeAUgTKe+4c3ioKkYrZKRVslcqww/pVTH94jAY75F5LFuiwpb4PiRBjwFGqlVZl93AdiGs7aYvELSnEd2cymPU37wF5VBt/hpNYsABPFlXUI1Flmp05YiRDB7YFu8hsMSL6WddCWJpJlP2nRjSLz8TFcqfiI0Y8UCu8ysbjWGn1Ck89c6IQUH4Cxplm6OHPB8Bag2QqvUJwWFuLU3cCJaa9oVu42Z46bTLmsezQliMqIgDnTKkwaREeQBHZ1zSrWqgsA60q+56BXvTEgh0Xae94Ig0V+EmC+0tkYSYZzly1+DaAe1XDhoI63Hzd08RkpXCrWyY40Nz+7jAQs03NCzo34QIPehOGkR8tb5sII39hbYojC0NO2Sv4hgS/fn/+fVa2aVC5fMuck3U/6UHrbhoZHoTXSiTuq8kzW4tv0ZJgI5Wicrq/9/KNa9mD+FQWEWDM5cPAOsr2OXdbF24/mT0y8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(54906003)(15650500001)(36756003)(81166007)(8676002)(316002)(2906002)(356005)(6916009)(41300700001)(4326008)(70586007)(70206006)(5660300002)(40460700003)(8936002)(26005)(426003)(83380400001)(1076003)(16526019)(47076005)(336012)(186003)(2616005)(82740400003)(6666004)(478600001)(36860700001)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:23.3954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166b97a3-eb7f-4e2d-d8d4-08da9c3019fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4891
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
Cc: stylon.wang@amd.com, Reza Amini <reza.amini@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Max Tseng <max.tseng@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <max.tseng@amd.com>

Dc: cursor info update: phase 1:

[Why]

Different feature might need to update cursor info, but
With different approaches.
To unify this diversity problem, all features should use
The same interface to update cursor.

Reviewed-by: Reza Amini <reza.amini@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Max Tseng <max.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 0c85ab5933b4..3ca1592ce7ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -30,6 +30,7 @@
 #include "resource.h"
 #include "ipp.h"
 #include "timing_generator.h"
+#include "dc_dmub_srv.h"
 
 #define DC_LOGGER dc->ctx->logger
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6b9a529e9f12..5d1aadade8a5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -760,6 +760,11 @@ enum dmub_cmd_dpia_type {
 	DMUB_CMD__DPIA_MST_ALLOC_SLOTS = 2,
 };
 
+enum dmub_cmd_header_sub_type {
+	DMUB_CMD__SUB_TYPE_GENERAL         = 0,
+	DMUB_CMD__SUB_TYPE_CURSOR_POSITION = 1
+};
+
 #pragma pack(push, 1)
 
 /**
-- 
2.25.1

