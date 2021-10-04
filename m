Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2335C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888CC610A5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 888CC610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAAF6E9FD;
	Mon,  4 Oct 2021 14:42:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0042B6E9FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmCMSzoBEmdsgrx7P82DLzXNC3784GV21Alx5ZFMw0rFAGUkUARdbFLKGDyXkna3aP02N0jFiHAPwxhnrt3zaLXmwev6i98OmCToJozwCxWfRCWKRJ07rx7n0PftdRbkUlyCL7Frmb3ZtmlJP3hK6J/MRpNfMRoPKveLjwgTimbjNyV2CdMY3kbZEWL3lxvRM1nCsYA18Bs6rgr+sH1qPtpDBMKHkM2XxmCE2xEvjjw3YR9B4ZQ4bAn3HBguJe5nUVlDRmPLahJInQRvZ1nWUqxMb3HGhDzrFv+6IMuA5td5C/hLBRlJLW1EmSn5wvE/G6Xal5x/XaKgxcaw78sTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1svnd2+ZSEzyKrJiUueTfGWsZQhTcP3g26WMMBK+6PM=;
 b=Bf4+Sq9Tp8GYlJsw4Ktmq0UNP80Rv1IX5rdqgITo/3Ma/HWvELHo9PexVZs2mNKk7df0F14pPSoviapHB+v2ZLCOhNvwqp8HlmEzC5iIdzZC9rxMAsIC/ipoyCr7UQ1Xj8EEmajPexK+8OFxuZGe1GXczexE4l1pnLqNtJaHt7lfMrO+ds1w9tUtjOx6e1wdVXI9WM4J5SIZItNzETBIG289ZDev+ax/8GW0IA80SLpc4BF00S0HGO/tWZHZkQU0u/f/m6/Kd1UK49APkxZmZ7hXu8qVByqc2+4e8vlpnYYq7wSyigSEJA3ury3oVHZlO0nM6yNBfidYz3rAN6l+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1svnd2+ZSEzyKrJiUueTfGWsZQhTcP3g26WMMBK+6PM=;
 b=Y9ggAtthq5BnlK9Z0hQ7nYNQvfkjDOqNI59XE3FHXm+za41u/LlfFvgtLglReTYSDY0wqRBPHcDE/1Cxyt1PRIZwU2ZaNb3R99p6T3RiEiQZzBfPzYpKJJw9NZX9z69fif2zkcg5+3KjSpdSxuZ597DnEwIxhj3BMlWZkSmu9eQ=
Received: from BN9PR03CA0330.namprd03.prod.outlook.com (2603:10b6:408:112::35)
 by BY5PR12MB3650.namprd12.prod.outlook.com (2603:10b6:a03:1a3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 14:42:00 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::9a) by BN9PR03CA0330.outlook.office365.com
 (2603:10b6:408:112::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Mon, 4 Oct 2021 14:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:41:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:41:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:41:58 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:41:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 04/23] drm/amd/display: Support USB4 dynamic link encoder
 selection.
Date: Mon, 4 Oct 2021 22:40:31 +0800
Message-ID: <20211004144050.3425351-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a112958-9cda-45f0-9b0a-08d987451f05
X-MS-TrafficTypeDiagnostic: BY5PR12MB3650:
X-Microsoft-Antispam-PRVS: <BY5PR12MB365089B8F2C8FB9797099636FCAE9@BY5PR12MB3650.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:179;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jS11r2R1Xx9Y991gjOgIC3nOcqzvj0ChWgrqcLtwi7sW1m4kk3bve0LQtHtvY3JUBpfk6E04mO5+y3P0UeK6PDsH6isQIqdPYu/LFvOOQHZ3eBxkXrltx3NpBFLxRgDm5ut5VX2gR3NS/JMefhhojVEmCEQ/F8qx3IPpCqbja1Jy7HJxie9ByAsqO7lZJDNoYOiLOgjKYM3pLiV9uFwIYx4jbRo8xy9hIRaaVLiZL/GeIPCZM2QrUVo8RzbPMjWuehSGP5YGiwFw14ix3n4dRh7RPVNfdw3faEsFpLbCPZOe7badv7PXzXui/Y1NcmQ4QowmzSDnnV3IFWemnjB2vZmQa8Hpb8D4NVlXzamWC1kKfaTK58CPkwhRNq0i7Y6UzVWDJwaCRZro5EC/jSV5SBh3hZx/HGJvoobRpMxDWkgn505ELx700nO4gPigYW9OFH9rP+3od4iGUanHY6IKU8CvK53y8NXAXS98nfe04ZkK9G2SWWGv3MRN8+8xHG4JvgW7zRzGc0+YYWSMiTinTmIiZ0SD20ekxvyIHbnQPuPwMopx2P2ma1neFfPtrW3I636GU8REoP5Ya8Liko1t2OjiGVo3iQCK9SNaXnjjyGVOqXV64uORF+0YEABtvxje1++qgRw5ix5iS+3HTxZDYKeMwpOYF1QAQwzIPmC0wg/Dm1UDvM4FLVLQWJkuHJx0QO4EK44szDuYvXKfMA44urt1GaSZ2xpfgdbZoCBc+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(7696005)(47076005)(1076003)(54906003)(316002)(4326008)(86362001)(8936002)(2906002)(26005)(336012)(70586007)(2616005)(5660300002)(356005)(70206006)(508600001)(36756003)(6666004)(36860700001)(6916009)(82310400003)(426003)(81166007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:41:59.2160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a112958-9cda-45f0-9b0a-08d987451f05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3650
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[why & how]
Add codes for commit "f42ef862fb1f drm/amd/display: Add dynamic
link encoder selection" to support USB4 DP tunneling feature.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 20b4819b73e4..66182b8c217b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1732,6 +1732,8 @@ static bool dc_link_construct_dpia(struct dc_link *link,
 		  init_params->connector_index,
 		  link->connector_signal);
 
+	link->ep_type = DISPLAY_ENDPOINT_USB4_DPIA;
+
 	/* TODO: Initialize link : funcs->link_init */
 
 	ddc_service_init_data.ctx = link->ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 3c109c805447..15c353c389d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -955,6 +955,7 @@ enum dc_psr_version {
 /* Possible values of display_endpoint_id.endpoint */
 enum display_endpoint_type {
 	DISPLAY_ENDPOINT_PHY = 0, /* Physical connector. */
+	DISPLAY_ENDPOINT_USB4_DPIA, /* USB4 DisplayPort tunnel. */
 	DISPLAY_ENDPOINT_UNKNOWN = -1
 };
 
-- 
2.25.1

