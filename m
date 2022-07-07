Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17736C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 03:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943A1112FC9;
	Thu,  7 Jul 2022 03:39:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72822112F9E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 03:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6eNZPojOzGzRm1DZHWJAzOrRa+A+raZJlRMNrs4pPx+rU1oIll++Zp6FE7/3GRUCIejRBvK3xOocblg2GoRCSsCDjLHPM11eSg7EJW7rIuXYj9X4y7haFiWdCcfV01XTo+FEcbzHCmauElKE5HOLuImdIcqU66YfNfKbDREaBfFqx/9fXa/UarYY1ADvBSeVCqyZhWrOMY0EKS09GGoEoXyvs4vM7lArCFz/7jpUX820RQLdRaX4/TFNKqjiV5tQ0Q+/yt07JhQE1ygHqnbb5PjFjbDBtTc+ZJAgC4OIChQhbtfraCtRGviGXOqMHANB3XCH4J2LRkxOEApWIdYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQDdgYdz2jP5i3rBNr8rAWhN1NhdBlgtzioiGf+MjJg=;
 b=YhWEfYE35TjPcirIHoZXYfrGLJ6BBek7NdwopCWT4frPhvmbd/kOMI8ZNUDhuji0qY/4PhqrHEOWWAxcCiZk2B3GNACaEbYESZGCH30vzE7epVQHEusvEFjc9S612Z58vBdTOAQny6navL69BsH/WVHKA8nIpCnfE5kz/imJ/zivJNwWQ5vKKf3y0Eryegy2/pQzj4mhucIoxh4TXBpMGdRqVnNGvSD42sHZzaeWmZXTre/VvgnJRmtg8TofK7Pzgloqrt85RGztxksPeKjzZk/iOcFA/ub1ThGEf1KX/ib4tHMHCHMHj2obsissIRBjaHHsnYiDtAV0CU4nHCd7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQDdgYdz2jP5i3rBNr8rAWhN1NhdBlgtzioiGf+MjJg=;
 b=jKihxbVsiJv5deZQ2PCmq4S6Kdz22LuD318tE2hkjEFQTX+FgrP/YEneqNgN0N81rOpzh9rT/Kg1iNf6K1zdGFRiooZtWex4aaKZRE2992QzWpJWABqnpVAEJbI9fWcU4uRnllKmq7TYnpsNBDd7BtzHcicP4rG34tTMOW6cyOg=
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by BL0PR12MB2417.namprd12.prod.outlook.com (2603:10b6:207:45::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 03:39:14 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::62) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 03:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 03:39:13 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 22:39:11 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amd/display: correct idle_power_optimizations
 disablement return value
Date: Thu, 7 Jul 2022 11:38:50 +0800
Message-ID: <20220707033850.92368-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c18a044-656a-40f0-80bf-08da5fca431c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2417:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVxgrFdc6+RvuTKq9KBNQvZp/kVpF5WW6UjA9Jve5LdebYbsahjscHnzCOgFtpx8gPTXYsjaF82J98yjYzffxmPkhKvHylWTEs/E++FPsUFLecbaayMyd5p9aHOIKXFPQ7JQ0VRX7K2zmJCBeOarw0fMfASeiVAJkxiGva9dz+p+Wa9uRej7rQd/SG34huJhMCshPOW/d6gP6q7NwbzLCKy9gYzneZSECguN0+LK+oGeiz/iPz0FKBKJYEW0dyLV3VRiThU4r1B61f29JkZJaHvcA1tqLanTNm29NSpTdbZELA1zuUI6Kk52q1HPH/5y/zAn+BZXu/u6C9iwbqkLpzvgosOLi4ELLN3Q2ZIv0qLEUi62l+pso/6m1OPI3aNz3gBBdd5n57oojNMO0e7dZZvmqLXok97WhyHy6Lz8t+qlcqkPFqQY9fm3mVuttKKNN+dkRVly6X0nf5O6LBwhnmZalFN+5N1lr9GoaDHTRWtkMoGuvUtYVa71wEbEXpUmxpKuw5lETv2t+PFEXNN9MT0z2qmfL4R58CJ4bSAWzh9sfmarpBD+KwjaEjC3rtEupRzg9S/0laSKLNWd++LpI5KjetkURo5Mh+hRP5wi7ANpY+EyVQKvhZVtUcxBl5/2pYgLirOUer5XHV6rytv51b1ZiO2S1q+k6NBp3lObRgv8RXOlvLZ+7sosscHy9/L/orbdnWOiZDvwu6JL7i/uBYkDkpHSjNJ5x28CzkWswDOz9JAIurN2diphdlVsPhD1bVApzgZLoeDGQ8sjzWMkgRdCYkch+Kis5DcSddf2Qx4rWy3yfMZ/bY9ss+WJFZUeSXXpkBNG2ymG6RREMvnP9ldtdbjviBqvF43Rf+yWx3FDMe3hcwiwI+AKh97oZloi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(40470700004)(26005)(44832011)(186003)(47076005)(40460700003)(54906003)(426003)(336012)(6916009)(86362001)(36756003)(16526019)(83380400001)(82310400005)(1076003)(316002)(2616005)(8936002)(70586007)(81166007)(2906002)(40480700001)(7696005)(36860700001)(34020700004)(478600001)(5660300002)(8676002)(6666004)(4326008)(70206006)(356005)(41300700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 03:39:13.8445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c18a044-656a-40f0-80bf-08da5fca431c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2417
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aurabindo.Pillai@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The return value indicates whether the operation(disable/enable) succeeded
or not. The existing logic reports wrong result even if the disablement was
performed successfully. That will make succeeding reenablement abandoned
as dc->idle_optimizations_allowed is always true.

[How]
Correct the return value to reflect the real result of disablement.

Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for Display Core")
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: If87d4cf76f6cfb36d607f051ff32f9c7870b4d6d
--
v1->v2:
  - correct the hash tag and drop the CC to stable (Alex)
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index d53cbfef3558..1acd74fa4e55 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -373,7 +373,7 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 
-	return false;
+	return true;
 }
 
 /* Send DMCUB message with SubVP pipe info
-- 
2.29.0

