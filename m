Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82456C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F2210E612;
	Tue, 10 Jan 2023 16:58:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B9910E60D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy8HokBZe0ZXm4m1y00Oam91sq9MENaruHHF+Q329IW0SFeXOLBTr3ZXae56/Mabr0o36sc4R7tBrDHe3VfiQARIMXVlLJ3ddkhuC9KrqsYcckd8MdOCRQ3jAvN3D7/1uXQB6Serww2usO7/ejHbRMmr6baTAvUdAwVRJfqj77BFgNYeHAoKpmEnSQ4kJK9Rtd975EUw8AWAhJe8jT9wBO4c0BfBpA15iSaQCf7BHxX5iQAqzEovF/0Sjr1Dw8i4x13V0vyMXYOBiCY71NAQ7DOvssksfjWVt6BYZoZlB08KeGeztJkBfXjlYwPXa/83ntPOqc/piEIZdgCDo7OyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyTVrzhXF9Wlx7b3W8j8QW/F0wwSXSKDl9szYp8vUQs=;
 b=eSHy+WG4asWJYC2rx45XhS7z4uW2w5fmbApE2C5ZQFoudMQWj5AQzSekyA2uiBkojVYFX94mWdvXufj6z+9GegNGUeobO8HVbXK3t0FRsGuUTaeIjQ1Zw9lTGmPZ4cUlft69vSZLfTb+7UQoorGoSoxgMssSwFWtuePpWvXG0n15+/pdRPQio7HDZFgz4vr7Mla+2fxAQsLdWlVxeLSnkkshzqQemev+oKCgeAWvTHyWDfoG9j6kswO5uGVefRBnAGhgmu/shV6DWnVrXSLNQ+2WuaOekwJ2AyddqT4EayOfHZIXqkWoakK+qJwJgXB4Yzih2HT42qscYb1F/Fu1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyTVrzhXF9Wlx7b3W8j8QW/F0wwSXSKDl9szYp8vUQs=;
 b=sl0HtUlppoC8iOxmBXQBWUIHC3TJ9Wtn5ey+5wsgCXvBsY1wYVu02tkHUeG8VS6UFUyLwhHUjB8I/D3RMWyh0TsbxpvYo86rbT2NxWlGnnWI/fbHI1n3QrGpiRMj9FU8mk7AgVXthVq1WZq64rJ6y3svgUrzel/k9BFkz5GgIuk=
Received: from MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::22)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:03 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::79) by MW4P221CA0017.outlook.office365.com
 (2603:10b6:303:8b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:02 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:53 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/37] drm/amd/display: Change i2c speed for hdcp
Date: Tue, 10 Jan 2023 11:55:15 -0500
Message-ID: <20230110165535.3358492-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f295c1-9599-446c-7dfe-08daf32bd652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hptEv+k4MNmkNif8XOkqDnFHpQVnatjsuMya6FTkwutjg/KbtYSw8KQndkZAacNSIjTbWAZvP02vUD+6X865Ld9/4qroSJ/kw5Kd7BxQAlqiRbDyyHpqRYRv69oFOjAj7Ate4LGSL3L3G7S4hpyRqGFVUVgGInJWKR/Kc7VwujFMGVk5HAJ+yxjrukSnXqBVadKONhbWhU7lbneR2QaXWBXj+iT4jSEb1q7XBKrv1+55Oj/QYUBy8Jyudo2RAhWYZ0nbAO2Wd6fa+pnkmBwiJFsXCks4XLicWDA+HzEtwcLEuoRRziQiscgHOZho7b+TdasWmj7YI1c9exQYJsATz5aIuu7xQonPk0NCXX3O8+WymH/NwZh8n7GFLdXGPlfdpRpJz/ieltEYtFtsuTWo+7i41af8NUWB5bhhJZuc6D+KyXB2aNHQJQL+riOoPVdvU/AAUOTDYJOixTHyZW0jYRTHuocuYvQwC3S22fuDQ4dYAdPKPBlFrdsUiqMPWIPM62LRb+NO3v3GJJBfwcQY5xnUnzEvt8O9rLMKkUC9wqKTDT7YeESE6jNhhSNreLPFwoVd1n+VFcoYOt2yolqsJq+NiXnflrKqFpjR6FIHy5NC4ety8Ctn5cjlomViMF647u8L4Zz6ry2FATEV0JeH1Y3VmikcjbgZfmGI1LDuPFa1DQqbP7ruVmtGDJMlg8SY5DLR20/sM3qxWO+4rTVtLarVkcq5IxMtOuJp6lz5guI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(6666004)(81166007)(2906002)(356005)(478600001)(2616005)(1076003)(16526019)(26005)(7696005)(186003)(5660300002)(316002)(40480700001)(83380400001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(47076005)(426003)(41300700001)(8676002)(336012)(54906003)(70586007)(4326008)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:02.9814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f295c1-9599-446c-7dfe-08daf32bd652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[why]
HDCP 1.4 failed on SL8800 SW w/a test driver use.

[how]
slower down the HW i2c speed when used by HW i2c.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index b4d5076e124c..dc0b49506275 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1776,7 +1776,7 @@ static bool dcn316_resource_construct(
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
-	dc->caps.i2c_speed_in_khz_hdcp = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.5 w/a applied by default*/
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-- 
2.39.0

