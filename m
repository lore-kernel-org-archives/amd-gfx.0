Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EF5C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAB61123E2;
	Fri,  3 Jun 2022 20:12:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A52D1123E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4TGCpLJKRlyuppNt/2Q29vjsza9u7NzoxlKlWFtD5uYGKfy7livP/vRadNV0u3uoVOpznPLfJSKHLQ5UNx22o01ktMaNyR2/T1hABYJE2/If+dS83PKUeAGMxE/ZC7MAwOLJeFcLpt/pxZD7tyRDDj4ldaqQK7hAWoQ9SJyFvXl6a2yAyfbn8Umzs8cKos5Lkf6O87EHSW/nPMI9kRyqGLsvLdobnWO6jqhCidx4CFuZfLDaTmluMxgoNqfunvRT/T7c+FD5SGAJGWYtmnhQAvg8FXveLZcayx92WVd0xNuTZLbDdREdsmgTduWAdX0PKhGllV3jLvotCFCfHk15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S44vxZLw+IIB5/evQHDe5NjFtpFXmflRIEBaXwGMKd8=;
 b=Hy1E2opJPOTuoayc9/gjkOZY+diBYWdS2NuvA4gb9KJIKF1V0VdQanSkgi0kohCXcM3cwuMWc/p6EwWDpnv0PuOaP1DiUbvYvv6cSP0n6p0YDHBr0Te3c33DeWVaj0QESrsWD+bk11tL3bxZIO0DzpcI7R4bXvp8t92O1u4Cpz0/deLZVq/rA/S3HEI2JUbnJw6dn/deT7M+cxxnT/qNBqE49n6XzVFFAHAm+J8+8c/8XayCnPyMwfExklCmp8gSOavJHxbLofuBMd0TN4VmLJLsnUQIIYg3RI1SvhMwBAPMYFqCkYmDxunFnQ2BJRTmgW9//z3qIGSjPEnA8KpwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S44vxZLw+IIB5/evQHDe5NjFtpFXmflRIEBaXwGMKd8=;
 b=W8V15z/NSC5t0lqptj2gVo1TcYUphzLuBZZosurSPOkAi+SvaY8w3dQJEVyohhsHaR1MqQ7pRVFRGnMMhnCEcZfvt+qpj5dvjtkU2AtB5S9ku6ljdmfpJJS4HPJ/IoMk/Xn1SSwb6LwEvG8Ww7ufQa0/0/xwB2kX1j/WJGrKDRo=
Received: from DM6PR17CA0027.namprd17.prod.outlook.com (2603:10b6:5:1b3::40)
 by MWHPR12MB1566.namprd12.prod.outlook.com (2603:10b6:301:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 20:12:38 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::77) by DM6PR17CA0027.outlook.office365.com
 (2603:10b6:5:1b3::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:36 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Enable 3 plane MPO
Date: Fri, 3 Jun 2022 16:11:39 -0400
Message-ID: <20220603201147.121817-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ddd540-ace2-4ffc-6af0-08da459d6820
X-MS-TrafficTypeDiagnostic: MWHPR12MB1566:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1566FA969930875215DA0DF6F4A19@MWHPR12MB1566.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFx1ET0BYcKEuSKXYLqI3sSVYh4JNsomln4bCHWB4xabwyHQzPKYnHQKxH2cew6rIuNddUYnXFjjCBxYzwhqTMUx88FOIl3iyzKVdVrP9TOSgVqjSv0P/vnlzmaHFN3z43TuGIQMXa1dCs0uFB3l36X6dKWmHqKLQXHDJgnQMLKoeYW3wcDJ09BWv05kt17vDwX4CVTkP67r4iSxs0MP5DzA3w97l1YsCEfxgLh6Q+/tiOJEyXStYPFFNqSKn5IeU8Wu2u2ooBBeL9eV7u2e60TOzpmklEBMuRWVl1n9Hn3y9E9mgvK0mvvCeH3H7ghw9LXe8JGA+Tia2j8EMDqYv7ChdQXHcoHcqPS8AU5nF+djGhh09QgpUJEnKdOLzuplY4QpWkh2DNE0RDcrKQ2M1Dzt24PBfg7K65ym9qxtqWqcshgpAnkDwVkKC/pffVa2QWslXrGNjS5Wse0tL8SNFNWpwEho120K3/3RByEiETejSv+ezn4eYJuz6S/ciUjTIkrxggEVNV+hNrIlvJzSXuQlLlucOHDjSxgbdHyxQaxSYLUP3xizNQyGjVG1dgbSS0PvOaEWAkp50Zv74Lmf/jDTZvbyHL7Yack8wNQPRzRaOWrO4M2lYzygSKAZ+6XPrRKng1FKW1Eyl+Um1RYHfoQllR4nNd+Ddg31EXu1DDI94ZbjJ+ZGicMjN/WfMDEHmKA9y6BNgQBSe8+OP2ohQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(26005)(82310400005)(47076005)(36860700001)(426003)(336012)(2906002)(81166007)(16526019)(86362001)(186003)(40460700003)(70586007)(356005)(70206006)(4326008)(8676002)(83380400001)(316002)(5660300002)(36756003)(6916009)(1076003)(54906003)(508600001)(44832011)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:38.3608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ddd540-ace2-4ffc-6af0-08da459d6820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1566
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Hansen Dsouza <Hansen.Dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com, Krunoslav
 Kovac <Krunoslav.Kovac@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[why and how]
3 plane MPO is a new feature missing in a few resource files
Enable 3 plane MPO by setting slave planes to 2

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 6 +++---
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 2b42af030b33..4f45753484fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1762,9 +1762,9 @@ static bool dcn315_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-	dc->caps.max_slave_planes = 1;
-	dc->caps.max_slave_yuv_planes = 1;
-	dc->caps.max_slave_rgb_planes = 1;
+	dc->caps.max_slave_planes = 2;
+	dc->caps.max_slave_yuv_planes = 2;
+	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index ef16260b7f3f..f9cee05aeccc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1764,9 +1764,9 @@ static bool dcn316_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-	dc->caps.max_slave_planes = 1;
-	dc->caps.max_slave_yuv_planes = 1;
-	dc->caps.max_slave_rgb_planes = 1;
+	dc->caps.max_slave_planes = 2;
+	dc->caps.max_slave_yuv_planes = 2;
+	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-- 
2.36.1

