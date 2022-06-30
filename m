Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE37ECCA473
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C784512A911;
	Thu, 30 Jun 2022 19:14:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5612312A8F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sor3Xw+I3CGZ+FTElDuVEnXRaaaTucx6XbYMMKAL5BMF4iDWM/TsiKw2Uo9j5QTaicCwq13D2k3kTAAb6cm47WdVBf2+YOYDEHeQzYOLRPve1QSRo2imfjwSaMNPyCZ2UT2YP0v7kL9Rk+aFHO4BX0A3WQ02qAciY41j46Jh6+EKOhgdPAEwnj/9ZfectsaQ+WUXHoQC0cmjl95sJngVSf+9z3XT3Qf4iyzktqTQc3fSYkH1geTdVAPLroPi9psqwNQ0QWfjzVj5DFdWYckjxQFCfnw1d14BfVBcxLri0CNUyOMimCSNvDpYyXQd4AkdvMChLpCMksVecvacMvbHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D4Ql3g21uy5B7qK8SK3G2SXlSfGuH4EwBGwN9HRES4=;
 b=lpsDqjnkV54JIQhLULBlZJ5r+H2HSccKko9aZpuuViLY4ZLAs0XkjZDN6zMX77Ji+6AO9j89bwqcrUqvZWI7oooTFwF0BH4hdM+zsL6jlOzIO6Vu0RRfND1geYpfNlqZD3yQvUEr32i4zblBgWU72wKVB78qXbEHnwTOpxh3BLWGB5bbVbB2/wFGTlUdtI27J3Vasme3Rxuhe9423Ktzs2tEH3ihrb5ERQHwj+05iUuAFgf8v9QpkSQsKOF9hceti+FSJRN4sHgT0ywnOmOxKxpm71ZOnQFy5OJsdaiDvHXCOqDlIC8IQqZgRKngfqrOq2cQj80zdAJ2FVc1Tpgy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D4Ql3g21uy5B7qK8SK3G2SXlSfGuH4EwBGwN9HRES4=;
 b=dCNoTacn3qMPzP0lSxBqZtGclNlJKBJiCMzUt0g7Zl7V3qZyxjYWZniK4pc9tlhOaIywE2cC1IrJf6IL2D0MOgCZySjmRQDxWO5R/fPaFkszf7DwjLzFJbSmO9r+ZDVpLUXVpKC8h+dmwLh7ApS1JQh2oH1j/QJWkXJ19eJoaZg=
Received: from BN6PR19CA0077.namprd19.prod.outlook.com (2603:10b6:404:133::15)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:14:25 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::69) by BN6PR19CA0077.outlook.office365.com
 (2603:10b6:404:133::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:24 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:23 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/40] drm/amd/display: Initialize lt_settings on instantiation
Date: Thu, 30 Jun 2022 15:13:17 -0400
Message-ID: <20220630191322.909650-36-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 433fe26a-68e0-49df-a75b-08da5accbefb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXbTV/f0U75QcpyHLPg8SHErmvkMnvomY8U9pbBCID+9A92Z/nTCO8JvixBTwDvKjLSF6CsCPPJnJiN3KDI2NMGF5wByEwmI/qznnJV64glJ3U5UV2PYJM6972ur4FL8LsoYKKKXZ8CSBcACQ+qvE0hqGzFldef1l5MUNo1s/lA3Dj63JiFZ/dMGnWjc8LuQ9lp0+TKeINg9Mo6bMoGZa5VGty2cT7Ail3Hq40RMHj8pA3YMBbFJz7NzKCSRuRM4x1J7v2RS6D7OpWpu3vXZNTVBdFFNlBznjYW9sHUigHpWE2taZkeKDI/OF/pbyI/4WQYCUtZZqWJQ9AiAemT/22IVgkhUBLuqJQKSCRC4SX3UXtM7GhCzx6F7mTfg7bs8VjFyYsQPG/nsYTO8t16cfvgCPYMD/TjP9Zupyf5++j4uM3nnKWhJuZCobETTSzwZQoT4E6YjKKzkR68GS8gJ0mIoQW0S9J/srw3t2ehtaoyhACdXq6IaNHMn96HdYYxJY0vRJN0XxHJGSL6DC5EAJ006zK/2RJzGxnbFsXGJCD8G3NIkjtnr8g70Y8Atq31hTa7fBcNBmzL+OqXPrFfZn3Zvm8cYYmf2I00bfk95MjXjiV3JKAPjGP5/jEyHc5xCrdKfNLk8Q6z345C2nwoHi2iyr1YSOYZamnccGBn6WGMzOOd60Dy0vYn6cJBlUByXTX7yvYxETMGI+FnC7otzY/DMDoXBirN5Ky6bG8sd61qSbPZqG0A7x9/NWkvDjwMERj/WLuvJVYNSUnrONnyr6WKJKNop+fC4Nwac12UKFT5sqYvBE5wCJxQEvlF3auiuVAXLVqMMYLnXSp9ByUwuDrbcOLVVmrYmO4asEVxnRL4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(40470700004)(426003)(36860700001)(8936002)(5660300002)(316002)(6916009)(40480700001)(336012)(16526019)(4326008)(83380400001)(47076005)(70586007)(356005)(8676002)(40460700003)(86362001)(6666004)(82740400003)(70206006)(81166007)(41300700001)(478600001)(7696005)(2616005)(186003)(26005)(54906003)(2906002)(1076003)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:24.9713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433fe26a-68e0-49df-a75b-08da5accbefb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
lt_settings' pointers remain uninitialized but nonzero if display fails
to light up with no DPCD/EDID info populated, leading to a hang on access

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 3b8acda50701..468e39589ed8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -960,7 +960,7 @@ enum link_training_result dc_link_dpia_perform_link_training(
 	bool skip_video_pattern)
 {
 	enum link_training_result result;
-	struct link_training_settings lt_settings;
+	struct link_training_settings lt_settings = {0};
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
 	int8_t repeater_id; /* Current hop. */
 
-- 
2.25.1

