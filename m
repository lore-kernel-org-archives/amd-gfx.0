Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B340C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F3A60724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02F3A60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B436E1D2;
	Wed,  8 Sep 2021 14:55:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBFA6E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR/b69BA4xvlC0t3uDFfydFnA+E3P1QTvteztMoaADdDBhHBd0w4fg2ZYvSG5lt7cYpFq8EX+4oQNuk4W2vEdDHqJORzra7K+DkR4TjibhQR1PwlbDTmopw5czhvzoe5BP/xbjAM99sFfiMUtpqTxaIKnC1Evzz9bLuaLUMtnx8NRLRcr5BbjR201G+6hN4tZUULcQrHVRblwt2+dXQeboBTIO0BQb2F7MPSiC+vlmgZsJ5hRP6jgrzFz029b0Qx40DiN8AmA809NiXVSyWMTYZ9nB28ICEiFuz3ChPw38SPDOgTq2Q/iyOpcSDZZNLXnNjT0B6KU4ozNwjhInFJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dNrmBi3asF9DSXAEsXEiovSpCqf2c2kRI7iAjiaclqk=;
 b=YFJ6nW7tbs40ZLD8kWytSscwQGpA7Yl8wqP5wpFHySQGP1ERQl3pjYFWRGYzaOOaQFPFgmR0xOtAP8RP4tu+Jh3zf+L6oQjxNoOohD16RycgaPmMe4nmQEwV4HG52gtI8cHl8gwGwEXozw+LVZi9TGcMCGzxRBJLWIIoZelk5jE9iNufqP/QrZF17GcRjvUhN+bVN3BQ4nYHs5Q/RZIo5dmgghLjIyu+e/b9t59BE2dJHXDyFbO7fEU4Mk1GRTfcBDlVmRdncxMMluyuKD19z0I1p1OlTSC7b/znz+oHRkPMjD9FnUowFJN1jOMJrOaaxrYJPfP6cfDhCyjsMJVcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNrmBi3asF9DSXAEsXEiovSpCqf2c2kRI7iAjiaclqk=;
 b=rwNHwlLj/zA1Jqmw2HFAvYjHgSvoZ8E7T+tXmBF0LuEgmNxJGP1J+qjRETTP7MorpvwaCjDTT0T7olzV1eMs3d0LUSEelvXIfnLip8zQZZGkac7jTJlzG3HRHyCU6VXSSEVEkcSQXeo06/oH4hYaDIgV2jQ/BD8mjPxRE1QJIi8=
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 14:55:11 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::c8) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:11 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:09 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>
Subject: [PATCH 29/33] drm/amd/display: Link training retry fix for abort case
Date: Wed, 8 Sep 2021 10:54:20 -0400
Message-ID: <20210908145424.3311-30-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 576ca5f7-e3b6-4b20-d084-08d972d8a891
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34031C8B6126F5C250DDFC68E4D49@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:37;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gm5IscU1srR7ntd6bcKxGgPZhIifgF7GFzoKqMSTdAfsPfwHIr3lQVIxYjKgWyjC5NpNYOC+Ynv9cHSuUxnbEc81ACpup6E2SgNks6H0lRm8Gc3oEzjDLtiyFRPnorEZJjQ69fR67Dy5Ie8a4bIO0zOKMrG/4JfTSGRMrX5vo/vsGPKySTW2icRSyRASEQ9Lr0szbkpwaS2ZQW5VTh5jKHUcgZoDx2f5nUPMUg/zH9lMVvxhB+T3jOHOx9RIAtwXSCz4AbxqWqO5HXeBlKW1gH44EpiVLxmwn9x+khW/cpP3aQwSO8GIPd9pTH1ctfyMg1s1BBKhgexMDJdtUSwKAiwx5jNGtwHOoHS6JExnOT8tZkv7hGE/c3ySIBfm/TN4WQGCd/Orm+i0OQky4xSy5MV7GGFEpHbbEZim4YvFoA2tS74AzocASTSeX6c/EPmXSj66T83CwefKLFc2Wx7tW5KNOP5JL8nGRikrBowKQHelPM6PKIpR6nH1caIU1tWaHb6IbfG0nUKgrJ2/Ma0SNU9t1dMr0hmUDnYOgIO2hzRKLcAdsGY8t3qPsq+2dACFVyGLU1/ac0dXVQVnJ6pzZfb8Pyi8e978V8PoD8zI/jLkWp0VNKjmapM7cvP4efIUX5+vvopRb7t96rCMJo72u6Jl9puLVQRI2M5sVpb9sI4f9b384tR6LzPMcSyvE+u4M19aBAmp78LQAh8SXk7j4c0s5ZS6EUSim2qRKmaRtrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(2616005)(44832011)(16526019)(70206006)(82740400003)(36860700001)(426003)(186003)(8936002)(81166007)(70586007)(316002)(356005)(1076003)(6666004)(478600001)(82310400003)(36756003)(83380400001)(86362001)(5660300002)(54906003)(6916009)(2906002)(26005)(336012)(47076005)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:11.5826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576ca5f7-e3b6-4b20-d084-08d972d8a891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
If link training is aborted, it shall be retried if sink is present.

[How]
Check hpd status to find out whether sink is present or not. If sink is
present, then link training shall be tried again with same settings.
Otherwise, link training shall be aborted.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6fc0e12a715a..ac4896ff912c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2434,9 +2434,13 @@ bool perform_link_training_with_retries(
 		dp_disable_link_phy(link, signal);
 
 		/* Abort link training if failure due to sink being unplugged. */
-		if (status == LINK_TRAINING_ABORT)
-			break;
-		else if (do_fallback) {
+		if (status == LINK_TRAINING_ABORT) {
+			enum dc_connection_type type = dc_connection_none;
+
+			dc_link_detect_sink(link, &type);
+			if (type == dc_connection_none)
+				break;
+		} else if (do_fallback) {
 			decide_fallback_link_setting(*link_setting, &current_setting, status);
 			/* Fail link training if reduced link bandwidth no longer meets
 			 * stream requirements.
-- 
2.25.1

