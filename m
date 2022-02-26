Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1C8C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FCC10E2C3;
	Sat, 26 Feb 2022 15:42:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F079310E2C3
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONlQYNsPZkA7GrUiz0Qb7XvmsE9h6KFmMtZg1LYFsedbj9X8YxQTgNZ1NOvNIURmWp09JZYPjHCl2WpMKK15fTiWXwPdRQH/XGCY0Dr0Ov2m1TTwpqB57QixWEf2pWWdm9LSWUu4zaxHJWcjl/MwnMkNWKsbORAOwUDP+5R3B1dbpTzT7qTUYjlKfqzfqb1bry1tD6AXNClc4qqmQFBDtTds+c/SjY1S3QcR4aMwIYnFcTlmdegIF6CUXMSkGg/uXS3w/CQnODdWpmOv7CyXFDdCY1FOi9cr+vabYywT6klY62k4h8gSRG9qSZkVwFQKxerNJeYU30E4JhJBcPNGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMaJ8qbc7O/TOxPs88yqeUEK+il4lAu86gAuwubxilw=;
 b=bT8m9IigRboIlBJxawegF1UvV1A4bO9crW68fRi+/FoHNEQ0w6+zSgFzB3QWTpaKnu93dJWhe+XlqFsS2ZC+PyKOUzCk8dF0ZNT4aNcMuurVNgJpF1+pC8a/TgVproBQJNkgYerKrvLYXNr5sKjgKInqqwWx54PX3mg34pBL/AwTG1cGjXJo39Dysxnqp5kIhptEyAS0cnpNm8hgSA+ZglE3XHaeXIQ52e894vqc6CYx29OJdFrNE2d+NqTW0YGBuvvzOBlabqwElEabPAMUfUVrdLkkNogGczEH3nrQpcxVwGAckGT2rskg9KGuJjJQlHYmvIUNyLqsH+uY3JYUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMaJ8qbc7O/TOxPs88yqeUEK+il4lAu86gAuwubxilw=;
 b=IYpq7KyOl3IR7xarOnl7VEkooz0SvmP7wSqhhn22ivsmfK1KkzLIj6dpkud492+MvRi8rFMCl7WNjJnjLCjuQOaADoNHXA8c6wHTQv/61RSasuxW92RUnY25gHhDH80gHbrh4iGxJZWx7e9YfQigfdtfbvPL0m+ZFfZUm+LdoPY=
Received: from DM6PR01CA0001.prod.exchangelabs.com (2603:10b6:5:296::6) by
 SN6PR12MB2653.namprd12.prod.outlook.com (2603:10b6:805:6f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.23; Sat, 26 Feb 2022 15:42:37 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::69) by DM6PR01CA0001.outlook.office365.com
 (2603:10b6:5:296::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 07:42:35 -0800
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:32 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: add verify_link_cap back for hdmi
Date: Sun, 27 Feb 2022 07:41:16 +0800
Message-ID: <20220226234117.3328151-14-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b408fc-fe71-40b2-faee-08d9f93e9d39
X-MS-TrafficTypeDiagnostic: SN6PR12MB2653:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2653C4D39BC13DD93FAAD481F53F9@SN6PR12MB2653.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWY2w1l29uLm2r9+mBijqKc8TkuQB7S57VHJE0FTB4/d7UkBN2VRrO42UZQ+NsMmTkvVgr2m9v9Uyzo5bxv6nfrzw4Fwob/3CNEA9S7eSgGm6Ic7Y46xBpyV345jQ/TJk6LqqXtJOpZIHv83i9yrBIPPD+luOAOpWRBKbICO5xJd8SS8+a04YqgiuBgGT1c8+xr8VUax5oN6WCtkE8NfCZDICUxtC2g9yT6bzPD4yZ+B6ikzX/mITcv7t7HSpgxSeMXzaw+D6qHDinMy8HmhtM60FCRr8AUpJKGGCGCXkwqH/E7GPB9NWXg2j+J5muFvCtvHWrCJicT8hYQXqWNK9RncvyvLeWgZNJ+VqcJEjpCNBOOXMKGNP73tpIWsW6yiqPVdLtGOhPedALZUa1sQQT2ybUsZgMhFQhJtL3iBsiplnRoPux6g1n7Zmhu0EPdkIYHprIN/VHJK3P8JjKIbRDpL3HwIJL3PYVbxEQ5ym1W38X8cLTI9z8k42yRMQo/mSsDHF1skwLWPB1nJZ0m+CZWptoKN6OS/liXMml5Z8IElu19Atgk0HiMrRaMkqlwdJ9v7lUdbbijBhxGuHq6Ozsnm44Ye0KJFn+PhbCEjQGcgGMbqeP2+XmzcUp20RFD/OEhrn0gWuBX/no3hfEu7xZ6eYV8b5cvBE+FHoECFSBvcJZsPAUG8v/TBb2jwdtD8oNk77v1dN7NOx1xC1EhIww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(36756003)(70206006)(81166007)(8676002)(70586007)(82310400004)(2906002)(4326008)(356005)(54906003)(6916009)(316002)(5660300002)(426003)(8936002)(336012)(1076003)(86362001)(83380400001)(4744005)(26005)(15650500001)(2616005)(186003)(508600001)(6666004)(7696005)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:36.9653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b408fc-fe71-40b2-faee-08d9f93e9d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
hdmi specific: add verify link cap after retrive link cap.

Change-Id: Ifd7b72e4f1f4ba4501e1ca30785ce4abf3b857dc

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 045d33375133..b2ed2b683ba5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -981,7 +981,8 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 				destrictive = false;
 			}
 		}
-	}
+	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal))
+		destrictive = true;
 
 	return destrictive;
 }
-- 
2.25.1

