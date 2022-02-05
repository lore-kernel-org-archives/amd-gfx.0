Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8005BC433FE
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A1B10EB93;
	Sat,  5 Feb 2022 04:33:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C771F10EA75
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z56L/DuW4rXkKA8Hj/h5D+aaZ7gcRnL0Jl/iHyMibtVOnVv4lLhmu1MvEmFlWGcvup0J7iXP8E8M+v0XVcnrsAi9Dvzujp/iyhG7R9rKnTTziEGlCBeisHGUHLiJPXb3hTRcCxCYj/j+Ci6o0GnI485yu14rBMmBp1TNbqArOj8klTahLJ+XJvlB/dZ13y4uaM9lclGgwPYy/zLdx+DDrbiMKtWqkL23llUgYcbSRRgMQ8qw+DZNHDeMsrxPvSSjjCRWo/Uw4eBSSD3UgFdqid3TBnfQFioip1JUUIDyhyal6D8g5y8wqDU9JjVdIMUS8fOASAn4sS45CTHHznJoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIJ1En4g4buQ0lCRkRyt7He0arc6cYNWZQLwFKqO89M=;
 b=GANrpEOIUkbR98m6R6iXZwMy+kG06N3XJ4pWzt13hah0W62tKh+V9yWGaQPxSI6KUbgdlrG0jWaXYW2FNBM/vjGnljtetogM9axf1fuWvZDcAQxPj+in0Z9BGPSeRQkOIBonJJg70CAkeAO7l68HM8/1KyJflhcOGMcxLpZY/281ja6FDCChPUPMA1otV59VFbgirAdnCJ7PKpde8hPGhk3F04wuEmN6XFJ5HFu1IYaYGKI1DlgnuX2Tc5/tydJRREEdUaI866AaanQLMsmR/qYh2LCDgq1yXcPLGszFhmiRh2Eyecq5o0Gym4tPIMxpwhSSgWZcC4/BEsrfn8tlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIJ1En4g4buQ0lCRkRyt7He0arc6cYNWZQLwFKqO89M=;
 b=IiYBEi2V5heC33iIrwnNttVa/AVjJzki7cwVKFI5hwIQfjJCyKF1E073yNlaAThEiXiUy7fc+L5J1ZARACNvSxfXKBMA+bxrjk8WAu1280zwcxxOIxFfSmdKoqlP7vXjkUUOnGRKBvxiN7ep8N5PilGOfOXJuze5LMlsf2ak1J8=
Received: from MWHPR15CA0046.namprd15.prod.outlook.com (2603:10b6:300:ad::32)
 by BN8PR12MB3265.namprd12.prod.outlook.com (2603:10b6:408:6a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Sat, 5 Feb
 2022 04:33:29 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::5e) by MWHPR15CA0046.outlook.office365.com
 (2603:10b6:300:ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.14 via Frontend Transport; Sat, 5 Feb 2022 04:33:28 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:26 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] dc: do blocked MST topology discovery at resume from
 S3/S4
Date: Fri, 4 Feb 2022 23:33:02 -0500
Message-ID: <20220205043310.165991-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 190da9e4-2305-4dcc-5871-08d9e860a877
X-MS-TrafficTypeDiagnostic: BN8PR12MB3265:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3265C9C86E9A0A8AA7D63B81FB2A9@BN8PR12MB3265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLrqF8P7EpfB63cg/Rz0u8kyWRLFR0hoIgb+Px89/PFszaLgfqZSmgl46vC0ZZuD5HPD11IjT8Gz8RokyeI+tV77Ivm85vKbxTtEyPY7fuRMLOGi5fMMHL9iNOoDJLIAoVqUoWoLksR1BJqvv8a9bxMLt+HnYpM+0j5o4OniIDEhFWH3VX4B9F3ohFPydajwINMr1iPfZEvN1YBeIbHbr9/Mihqk4UpJ1b9skKFcEOU0f8mND38QIlYdcmZo+NNc4Rq9KJJQ5UPectsL/4Yy6RitFVW7ITj5PnWYydCzKROMvNljDfPh3x9r7Rt6WdeGI+sbu/0HbRXxZYGqDGO+15Bh7uPMpZOgrJTt4jksRalvpb1XyqBP5TyG2sZrEyKZ3o/XHcE0TOXbe23wouDrNpSPlU+FIvJo/JJDqu0ansNoTIWgjPBl/4ZZ05Zy4HRvGREFnN+YJ/RKt58MWe9yvcSmoAqeK4vUDLvVN5UZEeqsOgZNk8QZ7GqPNgXLST02WUMXVXgR2rrvZIJq5Mlb4PvoRF8TbdWsVSTDVuD1vvCF3osvCeK/rPMH8ddmZH87WPC30w2Y/GZQCHEy3BocaRC9OvQv+9yoo2SOOCd0HvtlZ/Q1vdnlEk4XRJ9DBXyx6hjIwCup5prsuIWht2lAIHRvSPf2g81oyYoM5oN9WPQlb8un6GvLoJ8HGBQ3j/btYP4eakPAoWqBvtVG1mFbQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(336012)(2906002)(36756003)(356005)(2616005)(6666004)(47076005)(426003)(82310400004)(54906003)(4326008)(8676002)(16526019)(26005)(81166007)(40460700003)(186003)(36860700001)(316002)(6916009)(70206006)(8936002)(70586007)(508600001)(5660300002)(15650500001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:28.8502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190da9e4-2305-4dcc-5871-08d9e860a877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3265
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com, "Guo,
 Bing" <Bing.Guo@amd.com>, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Guo, Bing" <Bing.Guo@amd.com>

Why:
When resume from sleep or hiberation, blocked MST Topology discovery might
need to be used.

How:
Added "DETECT_REASON_RESUMEFROMS3S4" to enum dc_detect_reason; use it to
require blocked MST Topology discovery.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: "Bing Guo" <Bing.Guo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cb6c91cd6e83..ec4b300ec067 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -831,7 +831,7 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 	link->type = dc_connection_mst_branch;
 	dm_helpers_dp_update_branch_info(link->ctx, link);
 	if (dm_helpers_dp_mst_start_top_mgr(link->ctx,
-			link, reason == DETECT_REASON_BOOT)) {
+			link, (reason == DETECT_REASON_BOOT || reason == DETECT_REASON_RESUMEFROMS3S4))) {
 		link_disconnect_sink(link);
 	} else {
 		link->type = dc_connection_sst_branch;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index e7ead9e25318..9ad3ee4079c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -312,6 +312,7 @@ void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init);
  */
 enum dc_detect_reason {
 	DETECT_REASON_BOOT,
+	DETECT_REASON_RESUMEFROMS3S4,
 	DETECT_REASON_HPD,
 	DETECT_REASON_HPDRX,
 	DETECT_REASON_FALLBACK,
-- 
2.25.1

