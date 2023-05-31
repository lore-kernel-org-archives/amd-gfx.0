Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56A3C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3134610E474;
	Wed, 31 May 2023 04:49:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970C310E474
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMk0qRnejPtpDi8zN+qJS1/kVvXLSkgmPkhRBsYGrQi3YTjj7ThFEdHKBkf52Ix3OktLNWPgoL+ef4p/oTc0j7fSGlNlu9+KUKHkBZ3aOyfLtG5Caz3ppZKMMbMsOQJVPG4QDpcyC+miIoG//uMxa78J0RLQdj0pspg3bVfSx+1v3XASd6td3A6zlYRJVnrYPls4GwdGdystWRWZIES1S7hA2VvVx09zdx11YLppUbdl/jbkmvp/6Kr4C6TgukWiOw9sowegAYTLhWYF6tTI5FKDVaK+7nDOE0+EQdrGbgaCYycAOAnwpYH3N4VkFgfoMNdyVTm8jtlr7Yx8NXvrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW5c8gCbMwnkCFssdNyhhsFdF8J8oa9n+Yl7Vy8D8uI=;
 b=WcaXGH3mctm/ERKdcc+iobggGb93+3rzkojGm4F3XIAE1j0bIA8xJEwifwda3MbFyZCqOXyvQDzFkPeM+nzVOyPGRET1dxfpbNw3OLYIYbDa6VXx3JCmMDXheOCdvePNtxwxP04LSbdRu5qspN2gGxKcSCE9N4hci+Gha/p5HZRQ7KDrhiggrBiIF7kg/3tGGlRuVqtIoKFr4KXWZdG+zcKlSfPhB1GJRVmiql2BUR/7MIOynQGhmh79lOA+5/BSRRdEi6Ayo7mAJcUMZd3O+0dGe+MMphOwmjy9RcWI1RDzgKxXcIrx/liZ2JF7tCohbSMngYF3gGFBnhAzsEZ9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW5c8gCbMwnkCFssdNyhhsFdF8J8oa9n+Yl7Vy8D8uI=;
 b=ytgsznZ1gCQZHGchfV9R1xUogmqZphwqOsndEfH2d3/OnJwjuwCKytsTNxPOnbjRNXwRSHwYhxQDfIezUxjRYcr8/XKqAtXF6kImIYGQR1jgksQNoeSuJWsXQF1eCDx+bN12ubYERrChb7S9mIi9OTHvIA6CCIujvEhkgt1IpPM=
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 04:49:32 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::7c) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:31 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:27 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: add NULL pointer check
Date: Wed, 31 May 2023 12:48:08 +0800
Message-ID: <20230531044813.145361-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b9da79-9df2-4abb-6314-08db61926cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbxdzRE6aqA/eGOZ9FigWVkt/VpTVs8aTTiEvJHcsYsD8OO0CLn/7ne3yKhXd0f7GJZxWFqPMXiMcej6wh+SXkKJ7938Y8+5bH65Ny7F2lbOXT1PUbwPhTVLTBgxCBZGQidG8lcXJ93V6vLU8y6nj+v0E/2lzJtF9f6L5Rl4sz2ME6qcPDLuU1KuBUF0h4pdPSiTSiaWu3c+G3bhXOjGdPzw+KE968ESbg2H/z1PequV6I8JKH6Q3Fnta+xdeZ58rwB4AaWSDi6QJoDzXvm58ryFREE7i0vemlIuMXh2rMZgT8tTRAbja+xxK2d1fOvq+QVbGNv/xzSyiW94SnlOBKV0A3Xw0ZPVoHZ6fCHMLV2DyUd5ClIBz3YLJlEZY6pnarq1WXCBbKcOc8OWDMy4PhIf5QG8Tn5y/h6B1txRUw6cORGZgIe5ZAtZQO1Gk9bBkvR6EsXNtqvhgVtUArRzSNDXplK0og7lGzYhwGaTCi03I2hgq3dyQAz+yDgwRWOcVI5kL7uv50OZmlVbnZqLzMDWuI675GVRdPZI6mJvPe96JWRBOh5dQuW7fOQzxc55SwmzmZiuj8FQvzpeDna/NhLV2q3ONDnP+f3g4tnIzzsVuRFFyZaIoX4pL6qZYxNdRwJXjHH4elMii8T5aYhf00XYBALPQRp76YuAVwSJwzea337Op5qJL3EFULJJg5ncTB7RnU2AeZK0GxYUshKu9qzVJUi88hzbvalv5UUzUF05iHwJqHMAusiXMkBkgRnKeFCShSsw0hlAFOurTdqrHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(8936002)(5660300002)(8676002)(2906002)(70206006)(70586007)(4326008)(6916009)(41300700001)(316002)(44832011)(478600001)(40460700003)(7696005)(6666004)(82740400003)(81166007)(1076003)(40480700001)(186003)(16526019)(26005)(47076005)(36756003)(83380400001)(336012)(426003)(36860700001)(82310400005)(356005)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:31.9403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b9da79-9df2-4abb-6314-08db61926cb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
check dmub_Srv exist or not before accessing dmub.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 0d3ec50b1385..41b4c360c5b2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -276,7 +276,7 @@ static void program_cursor_attributes(
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
-
+		if (dc->ctx->dmub_srv)
 		dc_send_update_cursor_info_to_dmu(pipe_ctx, i);
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
@@ -396,7 +396,7 @@ static void program_cursor_position(
 		}
 
 		dc->hwss.set_cursor_position(pipe_ctx);
-
+		if (dc->ctx->dmub_srv)
 		dc_send_update_cursor_info_to_dmu(pipe_ctx, i);
 	}
 
-- 
2.40.1

