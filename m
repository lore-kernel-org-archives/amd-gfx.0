Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D7C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E356710F3E3;
	Fri, 17 Jun 2022 19:35:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A18010F328
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMz8HNEsAQkTtbTEJcMgoRUwhO4NAw2QZ2MuFTpyqa0v4Y09+F5j/QVo0OG+q6XpFS+c2a4pq3kgc2QgY/Stb22jkRTnbqmqJ9EYVVDHT38cDCsNzPc/wg/h0QzSBXII8e4/ENapvVpaY+Jcqe+xJrNMk4HssFyGqD9CnLiEi8fKGbNXmSRqioFJuwvL6xt9qwHisIZE/d+k71bE3UbsF8JggHceKaYM3WuzncxjdzS5Fb+MJeHV3QAUyFLHplWWm/zSPIpbA01JBBVZ5U8o2u8sCvRZzBP2aZtk/LTwzMpQIq/V2FJ+Xwu9jMQ69oiORnzPfipB6LtRo9BRttwqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7aSODqcBfTTNaWpNBruxEYoCLttQGk0ckJw1kfb0i8=;
 b=BqbqM5CyLRkNfuP6wJzPOid/+4ynbx2E2Q332f2H2rKc3OhkyTVIG0KT9GUpzoQh3IwBFvu6vG5ZdXMoh3erl9dpkGZ/myP02ltMWkslHJELvlDTcgmNjpCfVf82zIRsrGYOSqAWD7c1atFYIj8VAol6ZXah2qvueUGBhA9I/wwuq1gotypVfkGY85g+k1Elr7apyJAqKt8ZfXZAUy4//wssPRuew5wsnEzMHPDtr4qRl4uz/B/SpSP9bPUz1su3D+AfFWdxFOxAgmUIdAOSHuZP+L50qj3pn07eL7PHEcAEFQHoFZ+jvRvpYtGKsrjRNSrFZzR8g6hvWqbTyk652Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7aSODqcBfTTNaWpNBruxEYoCLttQGk0ckJw1kfb0i8=;
 b=hyNulFBJSNY88PvcZ61KCbYzUmGgbkmPe/EeT3ifazFmH1wOufgQkU6tJJxBmme3A9K8xQw8rn6QVocifhaga+F074VyG/JmnVjqu2GDUxQ8A77VRFrHRGb6u7q1pBDMutk1137RWANwzy1I5PH6yNZsw7tR7rjh+3KYx/RD0RI=
Received: from BN9PR03CA0131.namprd03.prod.outlook.com (2603:10b6:408:fe::16)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 19:35:49 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::20) by BN9PR03CA0131.outlook.office365.com
 (2603:10b6:408:fe::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:49 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:47 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/31] drm/amd/display: Change HDMI judgement condition.
Date: Fri, 17 Jun 2022 15:34:53 -0400
Message-ID: <20220617193512.3471076-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b409ef2-8bfd-42ae-309b-08da5098954b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4248:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42480BD3E132A94D27FF5FD298AF9@CH2PR12MB4248.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSD+Q5KDeYbHVLzrXWOWYNjukrON/4HC9tvdWFdIrakbNV1rly6fQaLcwE37b9kljckS+fcf/sjRrZ7hKkNqp+VffQf4FMo7VFCX1vDICRoWyXR1YgTlv3PpVCdQLrGh1OVEsduLfHJq1qEBZmkwThF3CGVGLkybqhNHKLKgmufEClXqNQCzLEs5Hy8ym8dDxp85Th/alC7jWpbb+dTIMQXme5O1eJTe9zxgs5QXuOkgDCti2HUoyp1NtqoBJ2HFeEtoZuDDS2EdcAghPDtyNWEVzV230CeFikJUNnnWk1lwIkATJ7sdManRsR2NBGfgWK4LcbXbhKOdV1wVbuZsMMglsN75uu6fKwE1yRA3dwZMNkMGKxZ2M8mWBNnWu6hQVOrrLn7B4L0++Ny9IG56pQ0k66iUYFpJCk+/oI5k8g4vpwv72pGlyk2evLhoIdUK9jQz1rxGEjgGNlPS6+Q0/ThYWMV8SAQSUNmhsdq/MyqZ8C1ozyFXsIv4T4ROJ293l9RVB6+HbhYAiASBYBVBJGgMhW/tMgis5FnY4+n8O71QLXcAadKvC8RqkVgEZfAjy3GTxabSxuJU2uZdx/JXgMSm929dZkpHRrl5d120DSTKE1VcwegOEZUYHgN09bsU8uRa49nh74E7XWD6S6IqnQftt64J8A1u7tHkKFuZtfOSdoEBwZcFJVAtsnQU4UiziZCK564XCPs8tMD8dohjpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(8936002)(54906003)(316002)(356005)(2616005)(82310400005)(40460700003)(2906002)(86362001)(83380400001)(6666004)(6916009)(36860700001)(4326008)(70206006)(81166007)(498600001)(70586007)(1076003)(8676002)(4744005)(26005)(36756003)(426003)(16526019)(336012)(7696005)(186003)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:49.5236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b409ef2-8bfd-42ae-309b-08da5098954b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, "JinZe.Xu" <JinZe.Xu@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "JinZe.Xu" <JinZe.Xu@amd.com>

[Why & How]
Use dc_is_hdmi_signal to determine signal type.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 82b74ee5f0c3..fb6ffcb0bc6b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4374,7 +4374,7 @@ void core_link_enable_stream(
 			dp_set_dsc_enable(pipe_ctx, true);
 	}
 
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		core_link_set_avmute(pipe_ctx, false);
 	}
 }
-- 
2.25.1

