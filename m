Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84FECA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7AD10F78A;
	Tue, 13 Oct 2026 11:20:09 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1151610F78A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb0h/J5pADqeHr8ZtEnP603HH7j7QsdFB/98xb3pyE0QU9KJpALexdVnaltxEjHN/uM3U8ujquRnSkkvCekoqcfuqtHcO3fauvOJp2R09vXF2LAe3kk46NNvQDWgJhnRy8bQQqdOcu8mMPXNY4cBaXNzt+Dj1+2Nh58YHFOdCJL/t3ByvBzQjpK/lYQlUXLF8E5pu8QoIf1+IHllMhWpgRyiu6EuD5NcxTKW48NhfByCrVj2eKf/zIi/YDYf+FxFl4VLcgcaPD7k94YCBeaZsdiJVjqAvvme0+uX3lomwiIkaNhdDQKNVQXkZ5EpqSXbLvB2VOB9W4WrEOO5XPgn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KU1zx66/S75j0wGzfsfwriyTyCOmtA6YeFl7PrgOmI=;
 b=oPr9sHbxfYThJ54dxLX9Md3SdU0fKJY2lIVJ4ooCfVFuPkDgxwiN25NRZufypDSO96Om3EWVgnD4SX9SAiQorIQP8PKOXqso1kHadzLknjLjXNdxNa3yFteGo8ksxcZ/vX2l7ziHz6AmAhQL4uye8CwY+HYW2iB5mHQ/OOkU6OkflnCBv5DprF9o94PjjxNN3x6byy7O1SMuiVN/gbBPCnY8+JtsBOMEHKoAOSXgWSA3+G1soQ84rxhKfY/exJgfHjXfqhy1qOZ4cS0VFzb7/Ruo8FoC+ocQZQT7aVwSHjwV+z6G5/kLO2fTBGoegMNB0fm1gu91yrh2T5fTWzDJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KU1zx66/S75j0wGzfsfwriyTyCOmtA6YeFl7PrgOmI=;
 b=OEUrhIA4kti7SQgZrGI0l9Bp7rUrNMzR3313YMvo2IMwzmOZT/Kwp0TptG4PtUlh17fFmrTQpbWjxxJXm2iQaJM1xso8IV6tcgM9kwQrrDLHg5rGGygn6yxIkbnS1HaLxvPFLXa8TjTnnK26NBJZje70cMRz0rDtrd0s46omIwY=
Received: from DS7PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:3b5::32)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 13 Oct
 2026 11:20:00 +0000
Received: from DM3PEPF000265C4.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::2b) by DS7PR03CA0057.outlook.office365.com
 (2603:10b6:5:3b5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:20:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C4.mail.protection.outlook.com (10.167.23.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:20:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:54 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:19:45 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Relja Vojvodic
 <relja.vojvodic@amd.com>, Chris Park <chris.park@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 26/30] drm/amd/display: Adjust HDMI FRL LT timeout
Date: Tue, 13 Oct 2026 19:08:13 +0800
Message-ID: <20261013111616.2267344-27-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C4:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dfbf03-4b37-4f87-3767-08df291bebf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: bnFc5T9pBr43pjGZx8vr3PVpTFoo9gh24ByJQaqZPvzAlBIYLbvUoCF3XDfya57tTj7ApDFUHIY0Ti7PwSQgWT3Hpypp2HanXKC/KXBP8osACeUOzHiLLBT0vd01z32PNe2O1ewkDtWpx3zi+itCtzcNnsPwN+kTcuDPf/GnorUeBuIzNddrJSjoPfy2/Uf6Rz/m5DF83le+SbcwCs1ZJFRMccjP355Y5cBTko5o7TToA6rQ78+f37FGI5fiNzyfabtZKUBFsfb5BdCSXj62lTo4JoaBHwWGPoX6KDl68qiLK0yiaL8gnXdFBQYEiRyvqxkkXvUgPyeuDV1BO5CNy1wnrBFkS6tdy4O9hMoUTIV7BdkQ5az+jCFScQZQI+bPAjUaYl2/by7g9IDMsIDAbLrCPG9M3U6uiiDFEjXhXfj0HBxgTFpRwNYrTcEe5g54jX7Ekmqo8DDgWBUJlBx/dv19zHfYyhian++OZF9SJsc5W+qmiRSMzEPA4yjh6tbvI8wa2p19o6t0DsMIpgC6bo4mI2BX3lWbjJT9sA9OprE5T6kFLsqr6C2FGJmzxmQ9yB9Wgo20KmBKxyP1wwcch1+95EjyAFDed6C6F0PgWiKgtX1nCT8D1/p3IfbRdnYMy0iaBn4pNtkokJggIG2Tv0yhYncQGeRuuTu8qS6P/atFn/f1wj89rYbHOEWIRpJE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(261009223027099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VEIHXgMtZAkNNHzT+x/wMP5DBDynkThhBFKJ7S61jwUyKRgmw1VA6m4wtctDMYfmnknPVgkZMMosEhKzyvVG+Ju5VEBllzT+pzyRib0B0MmPggsBIEMRBL1x+0leL7hlCA9iN0vRndzbi+ThwfXM1Igg9sjpIMJiVJ6d2cSG4oGAkqUIMasHcChFuqCEGB2Pg0Su+FqM6BIAmJuqvNLS9J7LxbpXq0gWAJOUR7+BKX59K3a9djY+Q43XHw9s6Uoa29YOAzg6NdnU0UwevxZWzzrk5SKyLVLBn5ThMoA8p07t1n/XqWf+zol/B9/sd3hI6EluahCv5vSu/u+Lg14ASh5VTb7okKjEhLnG79S5PZa3jkMm9JKWJPvyE0uC6TGGA9WZGREPlIoM79QeLQQgf6c0g9gwTF/ZqIfrJeRoh1MmZoOOAG4sfylvbyqW1zn+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:20:00.8684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dfbf03-4b37-4f87-3767-08df291bebf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why & How]
Extend LT timeout for link rates <16G to avoid intermittent compliance
failures.

Reviewed-by: Relja Vojvodic <relja.vojvodic@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 52a22b3e78af..960f18fe275b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -442,7 +442,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 	union hdmi_scdc_status_flags_data status_data = {0};
 	union hdmi_scdc_source_test_req test_req = {0};
 	union hdmi_scdc_LTP_req_data ltp_req = {0};
-	unsigned long long poll_timeout_ns = 200 * 1000 * 1000;
+	unsigned long long poll_timeout_ns = 220 * 1000 * 1000;
 	unsigned long long wait_time_ns = 2 * 1000 * 1000;
 	unsigned long long num_polls = 0;
 	struct hpo_frl_link_encoder *hpo_frl_link_enc = ddc_service->link->hpo_frl_link_enc;
-- 
2.43.0

