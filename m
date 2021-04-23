Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31961C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64DC613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64DC613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A39F6EB28;
	Fri, 23 Apr 2021 02:40:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F026EB29
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkG/KtUbpflw4UbRjZvUdo+8Xs/ZxeItXvO+g0N5ji0UlXHyj9X5riOPe7Nrznt3nYkYa0xrFlxybVPltzKTGujcV4FiABW9kLXvzdF2Mo19dBalb3+VZpi3aOvlCxOZfdeAURGecbf47Aqe610YTSfN4wvmdX8RZ8w70Sqk9FvcF6l62fenCIc3Nzr+QmzqNI5Uv8LqALxgEjXH9htGsSBhzx8FCsVNSfV3s7bHAazoQcPnXThrHRIu51FGcTarqBzxVz2IL5FA8d/SfpUpxML0bG7NhSkXDplQ694a/NMvLZIXRb99t0hPDQUfkQZ1C3UETdKAk/4HDLakh+2nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGYimX6Zo+NGYjDIY8pc5/k3U8YWRhnwNixDrRO5qV4=;
 b=nP4AdaGUDxVDQQL5/YKvR6LgVJjQkvjMN/x00iiZD7TEd4uUn78xGKMYaeQmapiYxttQaIfaYzKmrqn2zZpnL1XijIgx2vzbSHdAB5NMn39QVCZKUJlajVP6W/TPL/LIkkzEjPA91EN1eWM42PzkVHpXjgMC+Qp8IwfQaWQ8tgcgDtbjLbwvf3zM2NHabNjlig133XbLzlo7kAe41oB3Q77pb++XsE4njIc4MOO0aODIOZJL7sT/sszldqF+/Cc/vStfYBxUAe9pVvOCfoSDDxb0IqdXNeu4Z5xJel7CBIfxJuvsnMwrde9fnJ9+bnso5cXqtMiAHyXTmvsJXKslhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGYimX6Zo+NGYjDIY8pc5/k3U8YWRhnwNixDrRO5qV4=;
 b=W2p+vNnV+FelczKSlapDW0Guw37v4SaM0VvQ4vQEqgMGlyUwCPNfmrcS+BNKLwXdJepyOZEqKnCSYj1id9F5gl1HkSTEZ6BzNgaTkIOltuNaptksK1H4hOo0m4tP0HdJKW9ZJfnMyi2C5DQHKJjb+G0Zswu5AIpsd220Zoefkao=
Received: from MWHPR22CA0007.namprd22.prod.outlook.com (2603:10b6:300:ef::17)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 02:40:20 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::a7) by MWHPR22CA0007.outlook.office365.com
 (2603:10b6:300:ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:18 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Fix BSOD with NULL check
Date: Fri, 23 Apr 2021 10:37:06 +0800
Message-ID: <20210423023714.22044-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7473ef0-0e6a-4fc6-f068-08d9060122f7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5282:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5282EA0D4F28232409E74BB9FC459@CH0PR12MB5282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6MYmlwn5Hce11C+9m7j8ScLQzgMK2Z6M17aUF86Ysme5IkmGOIYih/oa8bdts99iuMgN+9zpkCCXGW65lrOqlWp4lcSBa3aoQxUcq8nfQJVLZWbkIU7lSm7iFhWHB0YkjBUcnjODUNlLVd2uyWK0yikkBZQ1Ry1lZwinHsUXwvSnuEdFeLtc23N40kpeEQSBKiIL0Ro4ljUuHhhFe4EMpJn0770ZpGFnvrsDJn4Pba5gh5MN4Xe9v3gz3K+rIpKvlqaeUilTcRPswehHFn8WGiJqg5fwzAsL0zkiwK4/GZ8tCG+jIsPA2Rprc2WCHzK+1QCFKhGjfTS1/+RA3XZHjYtPDPcdlYxPy9yppHD1va5mJtKtYtMbpHUHNea2qInS0BMG3tyfgaH4d7TRg3KmgiOyZuBX6xLutfwepM8yr3J9YKM36l4mDRkjuswlZTzsuy+/Hv9G5qaUQ/WWkkrsKKgu+kaWaVF0S20zyUs0QlbVoldTnTnCt5hx5QzV6p1OkqjjxW0/B0rVkAwlbRvyCR5PzfTOcjMxYmYxUUidEXtAyFbHkewaudo/W0WgdREuCW4/Z2kpZAdiYlfopZryHnayVnH78qCPpcbtd3hUFNXphH9hCoXjoXLPEeS1ow4xdiOTibUtbjHsOChhwtQVIsysm1QWkHuHZdFoPulRXdDLG9ZVGTdBnFyezv0+y6j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(70206006)(6666004)(8676002)(478600001)(86362001)(336012)(36860700001)(54906003)(8936002)(7696005)(2616005)(26005)(36756003)(1076003)(70586007)(83380400001)(82740400003)(81166007)(426003)(6916009)(186003)(47076005)(4326008)(2906002)(4744005)(82310400003)(316002)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:19.9474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7473ef0-0e6a-4fc6-f068-08d9060122f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
CLK mgr is null for server settings.

[How]
Guard the function with NULL check.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e57df2f6f824..a869702d77af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3274,7 +3274,7 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
-	if (dc->clk_mgr->funcs->is_smu_present)
+	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->is_smu_present)
 		if (!dc->clk_mgr->funcs->is_smu_present(dc->clk_mgr))
 			return;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
