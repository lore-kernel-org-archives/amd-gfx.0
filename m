Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AC8C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 13:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9478F251;
	Mon, 22 Aug 2022 13:59:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441768F1E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXX9rzTbE/6a96e4GHMXqs9CFfauAjB16R+CTkmuNA2kQb/LYMQxtJPiUOjJhHpTqGO2eUxgOhWv9weJnYI5PJkiMnon5xo2wdHZFjvjpMVdb6UY2jZLMv+iPQ5qOxZhBVg22xwlbOIEWTeY91fL1rST6zxkwfq8vo6T1Z0FVZpYg8x8BJWoghmJGA2cslolCVlMAs18oz+M69JeqHb/P7E1d5wjWE2gWRcuFcTm2uFy0cLLHWxWY6RfH2oGA9tOySU6+uQqvD4chSKM+9vNViJcePkd9hIDswb6K/pwD9GotCcE3H189N9IJ7AL1kq8z0uqv4D+NFZwaLUTSCZN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLlIOVIwU1Mu5+sUZGbsj/WEwRhNmag6YB7i26/FKvA=;
 b=KF6gUSH75IgwX8r8EsxGZ1tmcZna0YSIb/eOE43jnu/zyxpp7b7JDFtakFIvkUWwSBBqcv6+pvj0Ra+YGxcv5pSxp5qtqgR/rrggvL7GbUlPhgDkEcMxOQrhcVdWOmEcEqHplQaBsUswPJbvdxm1EhWF6FizSuZm59IlWQg8N/mikyxMe6sAKSAhpPfmej2MTF4xZ16Huy+u73qbmZcGPpb27nKXnvitPSzjETk9k1JtxFcMBUNO2QtIpHvLpH+QLchfBEYJvvUOwPOQ+G2ivrGoXb2Q6WXrhbSw4E9zndLAzosoeW9SsrlxqYhVlajncu1xwUBz9kavf3Q4nIM3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLlIOVIwU1Mu5+sUZGbsj/WEwRhNmag6YB7i26/FKvA=;
 b=4tmCw9njLEjAighrzQy120Jd2biCQIAlY6Vs/vuZ/d4hcMnmIEvQ0vbugBFQI/hQmTN3BIB1ZfoKJB2eKEi9r3MLQRbn4Gb6XBDbdo1Riw3RU0cX9r8iU63k5XC86ilFS5C/ISuR97d6Qg1n5bBSsxnuk7WQxN3x8o8KMoP6iZQ=
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 13:59:39 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::b7) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:59:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:31 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:59:27
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Cursor flicker when entering PSRSU
Date: Mon, 22 Aug 2022 17:57:46 +0800
Message-ID: <20220822095752.3750614-9-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f78a1c-1f8a-4ccd-e8d9-08da84468dda
X-MS-TrafficTypeDiagnostic: IA1PR12MB6020:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXAEfhhlEgzZi4p9eMF8ETDilW+Y3PZz+o/kRIdRSGQ8kDtkanqswhlZ1Okmxat9f4isa89Ji/JIKjumNeGWWdo/vKBA9C+5evHnkXFSdd+TRrZfziSfBR0X33ip0SguE1UDq6Yx0l+MYu1YBdTIsJuC9ve74bZNe3bHmDfqfgqljr0j9X5eOLHkBnpBXkZpHLZdMcWBT82wAp/qrvMPq4owelIXzG9JO20cv+ES93emri7YWS3sW8zVH7g2wCL/SMwZrRpZOMcqgl6cLK6ERYzHgIvft7hcYAotvtvAUGzAjdlfB/5ZH6mQt9XAegG+irNMl0B6kKtPnnpyDQQmPfhtbz8pLE2akBGGQuLIIy9k6m1A5GpMUrAKQgzO30sDYwkH70qybUwV1xPP5MuqeOlcJiisORF/vcG45b/FbOxdhGvIsdWVvOXfoKAM4bujPUrkcL7gjZipaZpTtYUBNFJX0owQ5UUyHyC/KyEE5bDQ43fadoZkjfuHrdHxUcH6fXcs5XCvxxxO6h9Wu8nCEMSa7SGYHcsA+IsoFOL60q7qbqvkw7QuTH7LEBOTz/v8B4SNvmkStKkWuJH/atgU5imwZlIlb6nOC0X0ZmCFqu/Jf/ceyZlvmQdHJVPU+EgQEmmhYYW3FwZ6gjZxS4kb6RHevq5108Qsuk8Jgtdl5XLxdFA/1tMDGS9L8qx6IJHl/F5TRpO9Y1dD115DAw+XFtDIjLVpA4Wm8prSRDfvqG72z+XNXDCV94TUOMh9BlWhSfivEo6Dkl7FUajTr5iz+XtK1oDgB/BUnjkw93x5guw5GtGXpi0qwt1svuPfKRVgVyLZ0z/lUNu0vLhWpMDniw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(40470700004)(36840700001)(8676002)(4326008)(86362001)(70586007)(54906003)(6916009)(70206006)(36756003)(356005)(81166007)(82740400003)(36860700001)(2616005)(47076005)(1076003)(336012)(26005)(426003)(6666004)(478600001)(7696005)(186003)(40460700003)(316002)(40480700001)(8936002)(82310400005)(2906002)(41300700001)(83380400001)(5660300002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:59:38.7138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f78a1c-1f8a-4ccd-e8d9-08da84468dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Robin Chen <po-tchen@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <po-tchen@amd.com>

[Why]
The DAL driver may transmit the wrong cursor position to PSRSU
DMUB driver when there are multiple planes.

[How]
Currently the driver apply the HW cursor on the top plane. So we
should only transmit the cursor position on the top plane to
PSRSU DMUB driver.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Robin Chen <po-tchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 5b5d952b2b8c..37246e965457 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3340,6 +3340,9 @@ static bool dcn10_dmub_should_update_cursor_data(
 	if (pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
 		return false;
 
+	if (dcn10_can_pipe_disable_cursor(pipe_ctx))
+		return false;
+
 	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 
-- 
2.25.1

