Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B7BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873B661165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 873B661165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266A66E134;
	Fri, 29 Oct 2021 15:15:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A796E134
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiEeVh9DWcn0KbQQPHUdboNZ71IU5gp17rRJn68W0N0iJXuVk0xkqfG/iOV4WQzF5QofVGHkU0+KOeC9VKlHPVahe6eSRNf6mJ57oDw671Oto0HzaV8BHM4yEt5AhZR2GWa/gmu+a5o1gHYMmftsu1a7sR1LUx+mw1uMQWtKXi6NQPzVoaB5xFnWN18aZ6HlmSC0yBaaY+Ce5fiY3rTx9nX8sqDLRPZZNRyN4tP21zDz1r/8wGNoDzHJZLUA1A2rTB+q3KLRdj1o/+9+PRL+RhSUzL5c901oopbBN4QqGisSXELLO4NS8LoeVG1Nf9lxGfX7H/x6urnuiqV8B/IFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyFskr+zxOnD4xsgzYDEz2nkx7QopXpp92pAXzkCk4c=;
 b=f6pdpBKTfZmJ1OjQoP4zOYBj4Lt1balO4Ru3Yeqzauqac5M9zySqbtXu1J9Nuaym7ltwt0Kut/LseiGDrLZSoVkaQwp0oz0/EC9k3wTJXrRmtwzqRTzsRU8HJ+y+mrkWY+htLS47Ts4iBZ1AJcPithYczBBoptUbNeeqINr00Cs+SsO8OHJXqML1tCstVjWLqWjjCoW6GoIS1ozLO+RW+I4gAdaKV7iWPnl7Z0Pd7sV5bkgnozJdtbPPY+ax6bvjJMT5+pqDnzM1TbLQdu7lNdsnqvsvWiN6T54ZvASrfOi9PLDwbKA8f8LpxURRRVT97Hn01T6IE37BhWljm+PaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyFskr+zxOnD4xsgzYDEz2nkx7QopXpp92pAXzkCk4c=;
 b=AUr+oEMdSuVmVdevwA8BeA1X58kW3BnZ+oxdo4O6EaOSV8iCh7DVUKdout9wMqvWL87VjrjUJZjnqpS5vdf38S8ViLqQ00Io77a77p3EOe4NKcsW9JEgcneHEU01wvKfOWt2iTFY7C4wGtMVsUHXgaiFrC/NH33bfIwB4gtoYac=
Received: from BN6PR22CA0025.namprd22.prod.outlook.com (2603:10b6:404:37::11)
 by BN8PR12MB4980.namprd12.prod.outlook.com (2603:10b6:408:a8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:15:08 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::a6) by BN6PR22CA0025.outlook.office365.com
 (2603:10b6:404:37::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:08 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:15:07 -0700
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Yu-ting Shen <yu-tshen@amd.com>, Wenjing Liu
 <Wenjing.Liu@amd.com>
Subject: [PATCH 04/14] drm/amd/display: avoid link loss short pulse stuck the
 system
Date: Fri, 29 Oct 2021 11:14:46 -0400
Message-ID: <20211029151456.955294-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc33e48a-a77b-4c99-d89d-08d99aeee4dd
X-MS-TrafficTypeDiagnostic: BN8PR12MB4980:
X-Microsoft-Antispam-PRVS: <BN8PR12MB49809BC1A34D09BD41A3DC458B879@BN8PR12MB4980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pyqyArVcV9OBaW7a4DmGDlYXFOQd3wVyjN0DbqAILlKhguFEXvlSaEv8Vm3+ugU5RNzvS8DSOi8TKzbdnlTi4qbc+tUO7Dde4LH4FtPvotJ8iwUxSBVbsfSQnJbK6JJl12YfFU2O9GamJd27YSXPjRABoQUSDVORcLYkwA/0CsC4kHz8a9ugeLF5f2rYe3XeViT+kQLj4oEnpORaIC+pK15P77V3sC45ZLqSaozJlf+eS3m8bwGKQMs2b7Y2mGZ5I4MCCcSnHs331qebbxV/AhLsmCX8KkoHuTy5auW5ctO04M4/GEvoxf3/uvy4zaMdEY6UabV9lwzWbJpWIOZfcCzT8SfS77THm6D+ALN827K82FGkjJgd228WskqK8pEDM6QzZ4ApTIq/btew264UUH0yZ702KOIeP2uFVYLT5vIjA9uoj2SRlcRRm0ffqsvjgr0+gk2fEP1XmDAi6nw4M6CXzECd8NoOZP8I2s8g8ES7slrBocR/YCDJ6t5skG7WgbyxqAjINW3kjkenLZk6wW/oUmyUDB6ohRnuRT6J3JgPHNxttwLUrOurplBYhfXngfbfOJof9Uig1uMMCxVQ3nERidWeqE3Raux/PAlpKgDfPJVXTF5zkNwXEBIGoBcegyZkEb16MjWij2Q/OLr9DkYz2Q8R8HPS4l6dvqJVK+YzFODus2ow73CFO1E/LU/w99EAxEKoKJ5zdTLST0DmvxyE4JKaWlEnHVIrji5oIkmSnDouz6zQlLQI0ADLCttR3aSmi3uRoxw/TutTs+WJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(316002)(8676002)(1076003)(36756003)(86362001)(4744005)(26005)(70206006)(44832011)(508600001)(5660300002)(6666004)(336012)(356005)(47076005)(81166007)(426003)(186003)(2906002)(36860700001)(54906003)(2616005)(4326008)(8936002)(82310400003)(6916009)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:08.1814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc33e48a-a77b-4c99-d89d-08d99aeee4dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4980
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

From: Yu-ting Shen <yu-tshen@amd.com>

[Why]
MST monitor sends link loss short pulse continuous but sink is
occupy by HDMI input to lead link training fail.

[How]
disable link once retraining fail.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Yu-ting Shen <yu-tshen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2796bdd17de1..f14f71dd1aa9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4279,6 +4279,8 @@ void core_link_enable_stream(
 			 */
 			if (status != DC_FAIL_DP_LINK_TRAINING ||
 					pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+				if (false == stream->link->link_status.link_active)
+					disable_link(stream->link, pipe_ctx->stream->signal);
 				BREAK_TO_DEBUGGER();
 				return;
 			}
-- 
2.30.2

