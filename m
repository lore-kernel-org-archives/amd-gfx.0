Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE38C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361BA61106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 361BA61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41CB73620;
	Thu,  4 Nov 2021 20:52:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA1A736AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL36KpPvikX31syh824ISfUVZ/1DXL0E9//6iUzfom+1iVN51xd+DmnnDuBQaKBSiP1QSzVje/Tn88C6bE64fatzOOnttQQjdCZn/AJwQaJMYD0x5+rM6E8DmI1U9MaZTrptolnt7wyXTK2Z7zHALHe795WnUqwK14I8tyiEm52fckg3JgqKqGdD3Ow2xWEsJsEJ0lwDYVDBz0WUmrLgSJfHWZr7bjDoGWel2EWQe/Fx77o/blVKWIbM7RfJFhbMSGaVo1LF378gAFnCLFX+Jelw69tDqSWth2pKNv2jtVtCVxyTHF4s5ElJlQkBxfeELkf48MZeIHi2c7pvHYIQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsCWRI8aPDDkWK6ZXggdDUof7y1O2qznk4D1pqkyHIc=;
 b=kfUajbqtNcnxYWNpm2jn/cTcXd0odP/w0QmGCxuOWU1QkouXmqmXzjihzEknFrRK4uF6R6d2Lkqsw6PtFDYrfvopc8NNQobMD0YBpKA3fAHvrAdW9icmxLmcuXrnxI2sqcSsDEk3qY9VTV7WYKxJihTRlaC4gKsDUiyE32vATaO8fjrdfG7gdbl6ocUZDMTPIz88FFqVhu1ttaIAUEE2tTSfxiW9hQb1x1vNmQ2P9TFdEY7lW/bEc0WOWqSlXl3IiQncpg/nmoqth4Y3lrwputaB3MW/pcV0qtlRHgWRw5V1urfGvH+aPYglCWq+H1wAJ71oeZKK9qQsaCbC/p8f7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsCWRI8aPDDkWK6ZXggdDUof7y1O2qznk4D1pqkyHIc=;
 b=QY3MgpNNkR5SobPev0tCZzrtehJ91ycKwu6EUAeX2+Uivp3DroslmmHS/oUYtxS04p+X7Xlmfrz5MMbEQuHLKqomJErSwn1Px66AQWkduFb4GTm92ag6+CdlCQC2LhwDfQLNAetlMtV1y1WQMp301yW5LVAZW3zp8krYWiGpliA=
Received: from DS7PR03CA0293.namprd03.prod.outlook.com (2603:10b6:5:3ad::28)
 by PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Thu, 4 Nov
 2021 20:52:29 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::c7) by DS7PR03CA0293.outlook.office365.com
 (2603:10b6:5:3ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:23 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:22 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: remove dmcub_support cap dependency
Date: Thu, 4 Nov 2021 16:51:56 -0400
Message-ID: <20211104205215.1125899-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c044d89f-a49c-400b-55af-08d99fd50388
X-MS-TrafficTypeDiagnostic: PH0PR12MB5452:
X-Microsoft-Antispam-PRVS: <PH0PR12MB54522BB755D5F6B8270BA7FCEB8D9@PH0PR12MB5452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U21K29NcxtfbPlwy9UeIwDdl681Crq9dbdcs7GXLWcI4brzkKQO6SW587O1ROjiOLeJ8YfUpT2pcZUjk50caCAPGO1qT1MxusG7DvVxITsqk7lCeAFQSJ9EyFsBmeFAvEblbPYMJx7tJoLnI8cZ+tDM1CB9lO4CQgllGvaYmz3CdxoK2kjqjC2L+S9ZVmewj4k6JsdT/6DxywqMnMnNpp7/23miM3FhP6CCCwzdIg98snPWH0TdLF7vjPXxvYnIFSlHeKCVEgku6HOIwl7fwis0DLklNJVd6EjwdHkFs7KGJdTR3/uLikp339+rOUhWehigsKdqmu1Kpzih+5AVrlVV53AuE68e20VKnkKwMs5oMzIge/53L/mOK5z8Islxcf8rvn5ghuQ8mpyD/hIRiFyybfGZ39NyKXPRhJ6DcrOGxQRPyCsjSrG1uwS+5ZL6olzJDr5KSXu80kFnuLm3s1DFlsT8W2FXuSFK2n2byAgUSe+vcxhcY9//SzNa8GDD4fpm7LqxNoEbdqBngf5S8IU2Y5HOTlfrxPoIJiFEHPKYZTY49DJ2Ed/icMKb0Dcp8Qob2l4qX6PdMgXnhgp+sS014Zf4/EcGNE8W+cAJug6RCmIiiYzaQAwXaEing1HrwEeSOCLcujbtOb925vvAwSE9KhygTPZnB43qRg5pJBzjFkl4OmcgN+40qJd03n1DjrQWAP5fOrw4QFLHeitLC8Hfg6JY7D/5xYwSlfTdR380=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(1076003)(6666004)(186003)(2906002)(7696005)(47076005)(86362001)(36756003)(426003)(26005)(8676002)(6916009)(336012)(70586007)(4326008)(70206006)(8936002)(54906003)(82310400003)(5660300002)(316002)(356005)(2616005)(83380400001)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:28.4903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c044d89f-a49c-400b-55af-08d99fd50388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5452
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Sung joon
 Kim <Sungjoon.Kim@amd.com>, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
matching the dmcub_support with all other dcn version.

Reviewed-by: Sung joon Kim <Sungjoon.Kim@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index fbaa03f26d8b..2650d3bd50ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1449,9 +1449,7 @@ static bool dcn301_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
-#ifdef CONFIG_DRM_AMD_DC_DMUB
 	dc->caps.dmcub_support = true;
-#endif
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
-- 
2.25.1

