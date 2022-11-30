Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919A3C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E196010E291;
	Wed, 30 Nov 2022 06:39:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49BA10E28F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxSXYAyYGgdAxVrs9vYf3KgUr40HHOlVflZ0pnC4G5EiEU4GrGSQepwzj3l4vcUYo68nDPk2UxtubZyfv7ZJNLE8KD1i9t3TeHN+iic6DvAN+8BE1eiP+66OueBQE3sMwUyuTZ6Wn9agJXgMxZBlM6L0yjtMQQcaMqtO/qn+CtCl+O2mX/P2BsKoEFvxkY0NMYvenk45j3uRXA+bNfyBuJhc3510TQAkUx45AkXsdGnSXFBTkJzcaKgsEeV9IGdL2CbejgXkopuH+1n5BtXYd/nuAubxjlQkmz/TBkLpptIDzJlBanKW09jKM2Aj8+kM0Y1LAT8eR3uiyJOMk0MR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU4ucoz3b+J8ePF53keCxPAZpm3rXwJ4OHrs5LpAx+M=;
 b=DXBfh+dtl30raX1izh3goY+d72IY7l+egi4pJGhZNxEOp2owpcqUjR1bP3sAXCY0q3dvCPB114dfnLT5KlGaYEBBNmkC0FLbMYDdDon8zVXfdHHmh/ASA4dZARac1CPjNsc5IqAByPdai0exp+7ahW14mxZqtPuXuKdoFdrckKG5sDUJW6ZO1wAfugbtYwtPC9scRxaXxelWfC1Qya8690Su9xS6UI1xXHl+/ibw1ZhiAk0gtGkkrhAuxINxNvWjzQdOotuXhr7DJvCfnc1kT99h33IrUcZJkRKczx+psIZcNJnaacAbyTMAn42pWiVEWbITOoJrH0PKStNxQOk8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU4ucoz3b+J8ePF53keCxPAZpm3rXwJ4OHrs5LpAx+M=;
 b=4EN42ki7T1yIpiGr91OksVZUTy/1eA6xLHV+tAWLUlo2Wdi5ZcrIvUOKeIMiASoTkifNTEZAssQT3jb/crynug1fEwXN9JjTSEGboMFUG0hxtLchNaXvuRr5cVf02UfL7kkgdnBSgTVcwUpvj+JxhU1AJ8W0/5yicOJEpuuiESc=
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:36 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::53) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 06:39:35 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:18 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: Enable dp_hdmi21_pcon support
Date: Wed, 30 Nov 2022 14:36:17 +0800
Message-ID: <20221130063627.2398341-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DM4PR12MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: abdadd8f-0649-4bcb-5758-08dad29da5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y725hPk0JV9V9Bl6PL0eVTlK+KjFkxyhpjSF7OzlUdS3udXO9Xr7va19qRzhD6Qhaq1F9qOB+mLUjEdi0chqOWS8MHqZtm7HDTL4s/F92XlCgv4IP2iBXGfc6EE3znUt7MhkPYvKiKewqinn3OF0g7XnmGuXjiyj+HxWXtvZfcy9vTGtAYRS5NZfPF1Er74QJF3N7T49VSydpi+bQnA4/JVrfrt7KsUbNOnh5IQMM/7U0hlnpKjMNV8uLVxlq+2vQyEVUL+ck4BAsL3e5WJ0tIeASNr66wcJ5pHq7aXD84o3O0GX7+IKBLyBw9uvORGREWk/LT1BHoyv9+O9OwFJiQAXjnvPn7/cjSLdoy5oaWg5JuPDnbqczAZj2YyUwAjypxmzo6vkxkkpe6mgN5eyEM0rNj/JQ3JKhTbXuiY5B1y0Q6PvubSheQFzvXaC9JMnt51rXXo+i5KbEQsxosuugTWJ5nSKtCblfMPBT5ZCgxU1GtyHoD8KoMv913A9w59Glv+E2RfhuxkMh6wdorb7MV7ccxm631dMNqRYbgmwiE02kzfWjrkoHgj8Ef0iAsUwjV6Ew5jB3WgJc0jolZpmIDEjYzopN/Uv8JPEqwDNVqqYUikVO72DIhqceh6N5ep0iPT+ZSUS4MbLEPkFLVq7nWvtMGSA9fWKRRcHZ0TBHRUSfijiNY/rYuqKoxGpnzJ3/GdivmhjX7pTAQr9rIfOJogqoQ9tlW8yMMisfGe6DE8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(316002)(478600001)(70586007)(70206006)(2906002)(40460700003)(356005)(6916009)(81166007)(54906003)(36756003)(426003)(82740400003)(47076005)(26005)(82310400005)(40480700001)(36860700001)(16526019)(2616005)(336012)(86362001)(1076003)(7696005)(186003)(44832011)(5660300002)(41300700001)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:35.7827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abdadd8f-0649-4bcb-5758-08dad29da5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
It is not enabled for DCN3.0.1, 3.0.2, 3.0.3.

[How]
Add `dc->caps.dp_hdmi21_pcon_support = true` to these DCN versions.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 480145f09246..8cf10351f271 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1493,6 +1493,8 @@ static bool dcn301_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.dp_hdmi21_pcon_support = true;
+
 	/* read VBIOS LTTPR caps */
 	if (ctx->dc_bios->funcs->get_lttpr_caps) {
 		enum bp_result bp_query_result;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 7d11c2a43cbe..47cffd0e6830 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1281,6 +1281,8 @@ static bool dcn302_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.dp_hdmi21_pcon_support = true;
+
 	/* read VBIOS LTTPR caps */
 	if (ctx->dc_bios->funcs->get_lttpr_caps) {
 		enum bp_result bp_query_result;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 92393b04cc44..c14d35894b2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1212,6 +1212,8 @@ static bool dcn303_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.dp_hdmi21_pcon_support = true;
+
 	/* read VBIOS LTTPR caps */
 	if (ctx->dc_bios->funcs->get_lttpr_caps) {
 		enum bp_result bp_query_result;
-- 
2.25.1

