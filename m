Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F3DC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B6810E71E;
	Tue, 22 Jul 2025 22:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymks8rLK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B3310E71E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4PoMu9qpzaLR4Ad9rhApXp070AjyYHZZc+n9J+KTcuxq8H7bMyNPKgSkO98wsl0PLfKyL0DkbHBRsIshKbrfR/07+xIhgxABHByNgPXDtH1+92m7kR3hXLEa1oOAY7j9UsuyVZ6/oULBLUeTeNKKuaF7Tuu469Ch9m0XHaF4CtZ96dPx4DiNPRrXBA87G0D4f8m557Hv5C3oP4MuS5gbimJOAPtnrmIXleoFCOJEQx35FK9Ve43mWrNjA5Z6q/t+MpGtwqahJR32nbLYiY2S23HoTZmEh7idRxyEXPnLsXre/pK3cyOQ8GFacLad+kk4dyZJM0W5Ia1xIBF0Pd7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya8Afdwa0aP3Xqlhjp1zUacx3EzMJmHLsocV4g4QtDE=;
 b=iO3B/8ZZGTtew+cKF9AuTS9uP7Hjl1akOv0CS2oj58G4s33m3B4/+aw+wgi4i6+a3PNc40Xo9V2e0yOFePwKl/IJbwipT/qDkGpVKsr3L0PZVdD8tXE/wAXnewcwVHRCSWf3k6ii1YkJYopC12GC6WkFU/l+1SwGdDIxuabj/tQlCqHVbw2HWvaHmjflhDcBprxfmzdodoIOWpiyEqqHZgV4YKciZdGtOV3/267DsJVDa35vQ9aYuaNG0zy28r1+FtvFjscQICwkvGxH9IkRRRC0vKHjjTCYTFX5fHQATIVI9sijZ67CgA24nGI2nt/REkJgj+v2Q/0DMH/lUTj8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya8Afdwa0aP3Xqlhjp1zUacx3EzMJmHLsocV4g4QtDE=;
 b=ymks8rLKAIVCHmtrFcyGOEP1G0J2RkJAU8XgS162+hrrDy/ym8IKuAmL5/Q2Yw1GS1j6IdKuBFy0oIEnyH9FYOqqFqBMGtwl/UveHm83cstBPnvM8w+C8jzj1uWYlovPlf5I6kFzRNSQolD5qbNRz6KQQQtplLpcbnK8cQyfzd0=
Received: from MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:39:21 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::10) by MN2PR05CA0020.outlook.office365.com
 (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:15 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:14 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Karthi Kandasamy
 <karthi.kandasamy@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 01/25] drm/amd/display: Add DC EDID read policy struct
Date: Tue, 22 Jul 2025 18:36:07 -0400
Message-ID: <20250722223911.2655505-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4184a8eb-17e2-4d47-e774-08ddc97099d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imnbIm4yDObShBPH7IvCyYMsH1HDO2RVE09RZnTp/vdvVNTcH2EVQpPQSiad?=
 =?us-ascii?Q?BDZTxTao4pZ9F4U/qTUVgE/Srs4neqRJNfWfJ89mduc8TeSeO1L4BmOVkyeG?=
 =?us-ascii?Q?WzI7gx8hW2BmlKCE7sAGDQopAueENhaWQqa0g9JzE1SSdwf86RpWCLNLRuvC?=
 =?us-ascii?Q?x1oJU9J3ZjDRssW3Syl/Yfn/SpA4QiBH80VUDje2ECA2ZRgt9c3+wunAuTg5?=
 =?us-ascii?Q?QrADirB9GxOXm+U5imOeZP6hdPx6PkIVwqhuwM9d0mpWIkjWzu586sCWWW+i?=
 =?us-ascii?Q?UrF9TrnfwMZH53vUzqRD2oaStFk7pmB2StDWOlRCVc+NqjgBmZZoQYLrz33n?=
 =?us-ascii?Q?2RoOcFR0lc0/I7Yi+niJdRgmtcE/g3fVC5oHJ3Cq+7mK/fkiPcsAD1ZBY8iT?=
 =?us-ascii?Q?wGfoem0FIlqhGQdjz11V+pHuwBPfQ7nKjs+1nfL2siLfRycQM1e7/9GhVWpc?=
 =?us-ascii?Q?0ZJY90MZ4H4yN65g8pU0Cq1QoR2wUe5Stx2xPm52UYCb7NA6uuI8Abug/dnG?=
 =?us-ascii?Q?B7sLEpUASMBM1PkGpxjdtsjNKh2rrN8CAMjxKQ3owkAHaVZwo5lNzDpyoVkB?=
 =?us-ascii?Q?7FsU3nwQIweAiUG7ez0hPpLltmC4LUtJmkt2kvXLh+QmMxer6j2iRMi9n0VF?=
 =?us-ascii?Q?XMNviXSLDdkBzVzSezwa+iuj9jbIunVMVdZXSLbiJeZUM5J9j62hc3cFQWcE?=
 =?us-ascii?Q?tMvNpIcj5y4g5UBpRJ1dcDu6OLHPSGcuygbd9Uyr4u7SAGndm4PbrqjNQS84?=
 =?us-ascii?Q?uaKF3EAKEoEFMsFXFVRbo0afVJv5UhMpElRn91Kab36z4c6WaaQgsx9aJfuY?=
 =?us-ascii?Q?wIkavyZ9UCeFJBmhD3L6fdPhsSPLCwvkreBfY+gNaEMiuOTB1mnqmYkegdhn?=
 =?us-ascii?Q?oRUS4us4VvcD1f7M3pEEAk7+x56v2tQU33fqawHZHC2chmnuRBMHsmm9rXwL?=
 =?us-ascii?Q?p3PFN9CDnhgmesxFcz9QoRpUxz3aN3Mu622DpEm0Ho3rtbatUcG6P43AJSp0?=
 =?us-ascii?Q?yzgRdPCgMheqnNuuVHxyxr4VxyaBwl95UkwQRyw9g6I1oEtu/Pw//W4Ch+zz?=
 =?us-ascii?Q?DBCKdw3JtHKlHDXY/eJfR8q1vXqEOUFou5jGblks5X70g2dsn96FI9JRnVL1?=
 =?us-ascii?Q?2zsUz6rlV3xte8XaAMAN9WYg7owiX9hm+UMg3wgBUqO33qABcBATcjO3TCZ1?=
 =?us-ascii?Q?sXlNulDvWfI2CTaDPqK4CpoZ/ktlfCqdQmoGfvee3F9olI3uQBz/b7zKyYB0?=
 =?us-ascii?Q?hKyJxgXZXOYsZd7Smki6easacL8CCaxOz8xqWOxhylhzQYGEz+3BZnMgd3Se?=
 =?us-ascii?Q?FXIcDApcItBBWSlQ4pWL3BN8O3xaoz00xNKz/d099hisQe+gd3raB3v+Ftbb?=
 =?us-ascii?Q?CeaoaUOawraVMCjPQbniBmW6t2Av7g2T6b7BifSPlwP5qaY464f07HUUxw7r?=
 =?us-ascii?Q?GKVky8o6EVYDIls0PWvJ556pMT1J6kY2mIl1sIBDAOglQFKzg8hCq84DZDvb?=
 =?us-ascii?Q?JCz80mYc4x+9s5uK/Ur9E87i5ZFyHdRdxC6L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:21.0426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4184a8eb-17e2-4d47-e774-08ddc97099d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why & How]
Add a struct to allow DMs that utilize the EDID parser in DC to modify the
default settings.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 375ca2f13b7a..2a86058c3bfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -563,6 +563,12 @@ struct dc_info_packet_128 {
 	uint8_t sb[128];
 };
 
+struct dc_edid_read_policy {
+	uint32_t max_retry_count;
+	uint32_t delay_time_ms;
+	uint32_t ignore_checksum;
+};
+
 #define DC_PLANE_UPDATE_TIMES_MAX 10
 
 struct dc_plane_flip_time {
-- 
2.43.0

