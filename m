Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA4C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA8661029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA8661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EC689CA0;
	Tue, 20 Jul 2021 15:25:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CF989CA0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjbRpF47DqlvsRdrigo6GX74CvxaWtyNl6ism/7uMicFoKUSxDZOT334ghn9CDM+s544WMN0B3RwYFgJWerdmhIjekUVZ1sqaW9S4UDjxHQW9Kz62SNJ8/2pXfcLqJJci2+AYpgujAQM451a4BmtDmYv+ADh9TYJLSIz5pGASbCxzo8Qo6bHTk73f7XsoF3zA4otHrOOm6YtMjASIT0OPFCOmi21gsmIfCpGeT6j0ItjOliR0GApJ+o2xP4aKM1HoHA9UKr3LiANfLizHGLISbZwbuSaORJcCcYIzlweC6LLol5NDnP737eabnwv0d5XPWVBeHQeZURHspUFOW7kSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvlZ0CAJlBCFOrYTxgN6zUvZ5D9++8A4fucYn5BX8cE=;
 b=XjGbT4k3DmF5EUBGFZ0sLNUgNGUXu/2fRqbvUhNtr3HEGS3kFanwltQHi+be/Vsnl/cDYJlmhPEXmyl0I4k79/8P+gmE5l+LdVmj+Qo418lzlIBeMnEEZxvo9n8zrjL5op3PIN7F350PLWlRTJud7zIqKxk+mF4+5EwN11qm/6BuWqtpPdP0Tu7Z99mzPYnM5G+0wvdgF3GFtasZ552XKuX8CYVCTRsPQzqSsVK3B430YHb6zYXYcvRaSILDui+YXYCUIgjFlsCaoau/fpP2WOraCHR0GAmtcD4A/GxLkmqsAG3Odzm3LiK7fwlQIDZcst6b9RmUaL9AonOeIdXSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvlZ0CAJlBCFOrYTxgN6zUvZ5D9++8A4fucYn5BX8cE=;
 b=AjVN1mE5wA5e3uNgFTb29Q29eG9tJVvhLzd07JFk3aNSdC4Z6WV3xYn5ONcnodMdTVQGrOKKBlU4gWYZWvk7K9hwp4TnkbvHOTaB7zznVRciy1ZeOgqvA6DcDCS5NCgVR8z1SlF5UFhxWLHti9sPJjGRTHuZELp4/eP1O8aNygQ=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by MWHPR12MB1583.namprd12.prod.outlook.com (2603:10b6:301:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:25:56 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::d2) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 15:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 15:25:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 10:25:55 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 10:25:54 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Update debugfs link_settings output link_rate
 field in hex
Date: Tue, 20 Jul 2021 11:25:46 -0400
Message-ID: <20210720152546.654510-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504facd1-9b24-4d6e-fcf9-08d94b92ab38
X-MS-TrafficTypeDiagnostic: MWHPR12MB1583:
X-Microsoft-Antispam-PRVS: <MWHPR12MB158388FDB31EC99484F9C346EBE29@MWHPR12MB1583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8as+/oclLJyLvr/b78chC0HtTVIYFIcWSwxcnD1oSD2r+rkhe5202yAlmeAmbOjbXSZz4S/JdNFn+O8733aE2Nro9KUrDcPntpjqCW4QVnIgSTURRj8torvHF/qANClz9Dvz5SR5Rh6Nzgi+ls+jnySHxgyukPt+O7X4YUc5+Kqcp/71p46FEAtITv2oFq8Bx/42YyVvW9SDSIKEvjoryIahPh0L6/HC9/uAMejVgMKR/VC5KF14elBfLFCQ6v8ce+XJHBQj9S66p+MMWq23FX1QaRoXgEfaVWp4xFnZr0DknU0Dtho0XUA33gQCqSWF2mTQh/2lvhKcIV+758KyG96mdWSLfgUJV2kX7nlshmCQp6/txN2T1w84VaiA9TT/lB0vXxEGkPwyp099jVdDgkPxEILGQuE1ZD+qQGtnz6zkmuvLYFr65ETq606gGFqb3dcT4A8XF3l8thu8gWadNBek07ra6Ik3i/kwmrhUEpu8xpSiwfj+gat9eWSDQEn6Ug0Ld9e1go1jcYqsiR94fHv5Itiqch9dbrKVkuKbzAXkUpfD2OH4N+VXMEwi4l3MGfPKZm8Ml1rI/1Bn/lJqYo66Qwuv7Sjxx4hKFAp9NZ1lJMRCtK7YJvBZ8rhqmfMrEepKxSTOXe5dDYX5LVPqix6lhfQhTIhvl88oWpMEEm1UpvRHdS6OrxMC+1Rup0Zhxod+5yYGI+TyRITxR8qTALa0mmufFcnpbYFH++9eTPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(36840700001)(46966006)(316002)(54906003)(478600001)(2906002)(5660300002)(47076005)(336012)(2616005)(426003)(70206006)(70586007)(6916009)(8936002)(86362001)(26005)(36860700001)(7696005)(82740400003)(81166007)(356005)(8676002)(83380400001)(4326008)(1076003)(82310400003)(36756003)(6666004)(15650500001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:25:55.8573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504facd1-9b24-4d6e-fcf9-08d94b92ab38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1583
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
Cc: stylon.wang@amd.com, sunpeng.li@amd.com, nirmoy.das@amd.com,
 Nicholas.Kazlauskas@amd.com, Anson Jacob <Anson.Jacob@amd.com>,
 aurabindo.pillai@amd.com, hersenxs.wu@amd.com, Wayne.Lin@amd.com,
 mikita.lipski@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

link_rate is updated via debugfs using hex values, set it to output
in hex as well.

eg: Resolution: 1920x1080@144Hz
cat /sys/kernel/debug/dri/0/DP-1/link_settings
Current:  4  0x14  0  Verified:  4  0x1e  0  Reported:  4  0x1e  16  Preferred:  0  0x0  0

echo "4 0x1e" > /sys/kernel/debug/dri/0/DP-1/link_settings

cat /sys/kernel/debug/dri/0/DP-1/link_settings
Current:  4  0x1e  0  Verified:  4  0x1e  0  Reported:  4  0x1e  16  Preferred:  4  0x1e  0

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f1145086a468..1d15a9af9956 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -197,29 +197,29 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
 
 	rd_buf_ptr = rd_buf;
 
-	str_len = strlen("Current:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Current:  %d  %d  %d  ",
+	str_len = strlen("Current:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Current:  %d  0x%x  %d  ",
 			link->cur_link_settings.lane_count,
 			link->cur_link_settings.link_rate,
 			link->cur_link_settings.link_spread);
 	rd_buf_ptr += str_len;
 
-	str_len = strlen("Verified:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Verified:  %d  %d  %d  ",
+	str_len = strlen("Verified:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Verified:  %d  0x%x  %d  ",
 			link->verified_link_cap.lane_count,
 			link->verified_link_cap.link_rate,
 			link->verified_link_cap.link_spread);
 	rd_buf_ptr += str_len;
 
-	str_len = strlen("Reported:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Reported:  %d  %d  %d  ",
+	str_len = strlen("Reported:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Reported:  %d  0x%x  %d  ",
 			link->reported_link_cap.lane_count,
 			link->reported_link_cap.link_rate,
 			link->reported_link_cap.link_spread);
 	rd_buf_ptr += str_len;
 
-	str_len = strlen("Preferred:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  %d  %d\n",
+	str_len = strlen("Preferred:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  0x%x  %d\n",
 			link->preferred_link_setting.lane_count,
 			link->preferred_link_setting.link_rate,
 			link->preferred_link_setting.link_spread);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
