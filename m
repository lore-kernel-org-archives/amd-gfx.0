Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598CB61283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 598CB61283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C908B6E4CD;
	Fri, 19 Nov 2021 19:44:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093BD6E4CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxrVd/GlFzK3s6C7ulkcGlw05nElr++QGkTdkuV73Gve4QONXuVsBwq6g4tUKtF0MCennnzTV+esKHnqj2aPA6Arb70xVSx3u9O1VzLTylLgeOcNAmZNpT5/3YfTN2v2X/GhyWyOTyA93Ro3wW9RdpiTCSfvPtaPF5/J8wEXprpUT6K1nPekFmVxwr9Tu/0EDerP5UzA0CPAjeGFiEXkFRPpjvqADOZzTEHbdD3AmBZw/Zf/1OkQwF/wjSN+D3iXZ9i5whXgA1ENmoW7zJ9Dg1bdShWh7sDRZTk4DPcwj2AMSHgRCUJ6BJjcNBn/0njIkYTjffWc2wrkHPPgdY5dMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMVm9RgGq7Jc0ISb7qJKnOIsoESfNtsTelvLvrbWM3A=;
 b=NKV06zVfpuegCga0zbsAernREONyYt5DUNGWMjmRK6D4ckYal3pebUZ8ckVarEjstWcSkMXEWAkMq+0APaQFo4pS9T4PahkGVVeWRg45pjxOW01PnnWT7RadDbeER/PEYAtjyBKR8giYPLhAkDtJ3mvnOHeiFH7crmjR+Sbas+MIyyvjEFzCzmn0nlNZ1+mZQVfuMEYteBk10BtTTMGw2gRFMPktU82lQ/UeX2WRobe+x6SodJg9uLoxOTkjc1/L6WGm+0MCBJ82HK/bl9EKFd7kESnjiWMPmqK4Lhu1d9zH63FDlbSNgCBMEz36BSoMXnID5Y/bzTmwuyjqj6Um/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMVm9RgGq7Jc0ISb7qJKnOIsoESfNtsTelvLvrbWM3A=;
 b=n6iOTH3lHT4mx6T7unFQOcY0+ZfOJTyCUmNp8Pmh3HrMuzathkTVZlZrbPhIvjq1mPqPbAxD9RI8MX0wwXSuk6WlZYZj6HzRvcQhpKCRoYE8/wNMCQcewZ1P4rLw+/RFUabth3JltXoxrxbPolXcEWA1Ol7wrHGu9DWjNxUwRsM=
Received: from MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28)
 by DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Fri, 19 Nov
 2021 19:44:08 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::91) by MW4PR03CA0113.outlook.office365.com
 (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:44:02 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Fix ODM combine issue with fast boot
Date: Fri, 19 Nov 2021 14:43:36 -0500
Message-ID: <20211119194339.97573-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6820b2ef-e848-4812-c9ae-08d9ab94f3c5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2357:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2357201A2CA909ED5DD5CFDAFB9C9@DM5PR12MB2357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZ9BUzH93gR9b5oAM3UAsT0Pe98nvf0z8oydSU/OrpDzuuihq7YnejU0J/3Dahf9JTr9Z3jrImh5jhkcFkaWqLrsTV9qeILhafhuF7jhgeddaN9CiDD4kmi3DZ7PAb5CRmDU4Jk7l3qzGvurTvlyM/26Q2XqUU+wYHWpRaere1McG2QV73BjLMNvZvdPQHZ5SuMG4f2I5wG5fZucqBRQZX7N+VDLOcuObd8Y3NFoFtDVPzs3wVc8pC0QwTd+k0MBclBTt1pVQa+yYsdgnUuKhd/hCxc0ETOnsBqYTmzcrXQNWcvTzMl9/NCdiIIJWygi49JoffpwD/eiJbi7pw1fCH0Us5e3DDHKM4+YmuCPbBRW45r48ixMZavwwA0rySMOsY+QHnj3jafMPQiEtr6h1KbVavicWXoGrKru8n/2Sq2o03XE0OK6axDzo6sXQcHyw1Xpurmor9o4RwBZ1IcPRLCBISqF6LUHLqqsK/pW9hxGgcfZ7I6hIPLFeBIO7VL24ZY1b9DqYqYKfqy1cdGO3cHMSXX7pSPoNYhD8vIa9XW/u9YePk8lNHkW5/6mrG4RSZ4E1fQ6SrntxekNt8FMDQQTJ6kfnslJxUMoqshE7psUFs2kwbKt/vHDM6QVLObwNVMdPXeRUWsFVzAQZg5j4v4y1pIFuwxOrWRaPKBoKDNJQC5y6M2YPbKDO1uZVfkHR3vxDUenPbxzpTfI69gCu50f8IgJV/ExpiD1gc9AZ94=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(81166007)(54906003)(70586007)(26005)(426003)(82310400003)(83380400001)(70206006)(1076003)(316002)(16526019)(8936002)(4326008)(5660300002)(2616005)(186003)(6916009)(36756003)(2906002)(356005)(36860700001)(86362001)(6666004)(8676002)(336012)(508600001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:08.1312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6820b2ef-e848-4812-c9ae-08d9ab94f3c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Cc: stylon.wang@amd.com, Dmytro
 Laktyushkin <Dmytro.Laktyushkin@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 sungwang <danny.wang@amd.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: sungwang <danny.wang@amd.com>

[Why]
When systme power up and eDP lit up by VBIOS,
in the core_link_enable_stream(),
the function will early return due to apply
apply_edp_fast_boot_optimization,
resulting the DP_PIXEL_COMBINE cannot get set
in enc3_dp_set_odm_combine.

[How]
Check ODM PIPE to avoid early return.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Danny Wang <danny.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8f23c160f291..3d08f8eba402 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4285,7 +4285,8 @@ void core_link_enable_stream(
 		/* eDP lit up by bios already, no need to enable again. */
 		if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
 					apply_edp_fast_boot_optimization &&
-					!pipe_ctx->stream->timing.flags.DSC) {
+					!pipe_ctx->stream->timing.flags.DSC &&
+					!pipe_ctx->next_odm_pipe) {
 			pipe_ctx->stream->dpms_off = false;
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 			update_psp_stream_config(pipe_ctx, false);
-- 
2.25.1

