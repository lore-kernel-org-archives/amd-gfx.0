Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A0210E49D;
	Thu, 10 Mar 2022 22:21:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FA410E49D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvElfOzV2hG9TL5UfFm7xeIYJdZiwVRswZOJYJKCwPjusakxdXcom506y0sKnKVKr+0EZQiYy+MMA/aRszFjgz9koWiJn1ypYWspVmto3F8k2qamEdNvKJAXBADIrPrA2W5gdMYYxlI3Pl8/QtEmX34ju1p+WxT88FfKA8V5zOXwtRwb1xXe/CEfTSMQHGZxNCa09Ls0+GXtjlv/o5JxWyOEeWHZNRKTZYDWN7PyTqpafVKVZUnW8+n84Try53sXqMbSyTdVg1KseYGj4NzL4bSFBzFqxTKohazcaV26xhb26MWGyrEZPdZGs2AsPi6YzVOMcNwNc+/UtCU911ZrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkwpplxPEcOE/dnONtJheOwZygw/xA6OMijQA/iHvLU=;
 b=XCmNOPdWUhlX54TWBO5H9IoNvAV/M2kf/KsxvdeyfLbaUQeA/0l4Dix32+qcoIiQbJdvclLCwEEx8YJL/Q1pt09JVy6AqEg+9erc02HVaTMA2Eg5R5nhW2Zbc2aUQRFGAqYk58E+5qH5L/do1nmdJMmxCOZPlKY6WJHmbQYSpGHFA8v8t6ezCn9xjFmt3qPVWDZNIcla7g5X7EJo9+B/0eKH3iNem5vH9pwhOmX6wbJAjEklayoW0xdi7LCPdjjAE0cx82p2/3oFOIhYxXc7TvqI6sEt2DaojElBAp5H/jwPqvhnfUlM87ULbdYUCIZfxDTedQ/J1KaAUoVOwij8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkwpplxPEcOE/dnONtJheOwZygw/xA6OMijQA/iHvLU=;
 b=BT53ojGJ1SQbUqkNUMApApVzFeZ8cnfKFbjY6mnQlEwwv7CCZghMJwhMId97XJ5Qx+7URjoejOfAabPHl3QOz/jmbvVep1pO6hY0l5A1yGWtPOPeJJna8laZB+sl5p3zEdyJdnOUJnUCwZKM1gaMTbYuWImgHyKlcbw1raEUQx4=
Received: from DM6PR08CA0062.namprd08.prod.outlook.com (2603:10b6:5:1e0::36)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 22:21:41 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c2) by DM6PR08CA0062.outlook.office365.com
 (2603:10b6:5:1e0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:40 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:36 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Add new enum for EDID status
Date: Thu, 10 Mar 2022 17:20:39 -0500
Message-ID: <20220310222045.664867-7-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c07ec6b4-d37e-4e3d-bfea-08da02e459b0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15499A4ED372F974FEF4B94CF50B9@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGXFtcLzHLbPqitp2pOXG73/g+u1IGGhb/YC6CCVc+Z/K2nUD+YDyP2KbRraYPxHHPr9FoStIZODcfwBuSSHMnczAvdc+J+meTuCZwMi3neSNX6e4IKvyePIswC89Gnnl/BzuBmqEJZ/qZmHrXK+OyUeWrWUWiRk2zhGYLlp6ZqHssJEaYHQsl9BLdSVHhU905Hf8QdVCst1jfwJP34nbY1IClo2MeoBOdrtIoViLcmY8aVNZVE00O/e4iG4adE/6PUOx/tttlezxHVDVVCbGYcLn5ugOnZLfprIDDx/Yge9Y8Y6JY3YJr/PX8oZVQgjzPEof+cY6PWr/dh3QvuppuVMS2CX9/OQSyDIoFmECbg0rcy+ALha1XJQOCpe7j6Ub4VBSoN0zuz8smUL8CHdnbC+TbEaFLYW00cpvNL4y+Wbj8eVGmncqgMDH7P/oYYPqak+fNdj4SqwSOFJBl8irbE7vI/IjDe/HmsBipF01bFPh9UR8tQw9J5xWzvM1fkMVo1mRQTOISmtIis+eqJpmujVioe1lMxOdqY1JB1GYBeN5+w0vSsfC1xPBaInuqsUPEKmhAVW9VcwtU9Kc1i8mOMVSAWg0JwJY4eBSky70Qz4irtfCJvm/dNkOtMTGrbbWboPh7p58LWwCnHJAKJ38fQdhAk0yk9yrZqdSN6P8yzQsRdnD3K9de3cF9p0Sh8w0Zv73ZgXcs90iK3swBCaSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(508600001)(70586007)(70206006)(82310400004)(8676002)(83380400001)(36860700001)(316002)(6916009)(40460700003)(54906003)(47076005)(356005)(81166007)(36756003)(26005)(186003)(1076003)(336012)(426003)(7696005)(44832011)(86362001)(2906002)(16526019)(8936002)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:40.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07ec6b4-d37e-4e3d-bfea-08da02e459b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Dale Zhao <dale.zhao@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
We must support a new type of partial edid return in the future

[How]
Add interface and case hander for partial edid

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b3ca3307d39d..cb87dd643180 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1183,6 +1183,9 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		case EDID_BAD_CHECKSUM:
 			DC_LOG_ERROR("EDID checksum invalid.\n");
 			break;
+		case EDID_PARTIAL_VALID:
+			DC_LOG_ERROR("Partial EDID valid, abandon invalid blocks.\n");
+			break;
 		case EDID_NO_RESPONSE:
 			DC_LOG_ERROR("No EDID read.\n");
 			/*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 48859d5fc172..2ba9f528c0fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -138,6 +138,7 @@ enum dc_edid_status {
 	EDID_BAD_CHECKSUM,
 	EDID_THE_SAME,
 	EDID_FALL_BACK,
+	EDID_PARTIAL_VALID,
 };
 
 enum act_return_status {
-- 
2.35.1

