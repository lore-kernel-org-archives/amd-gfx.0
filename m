Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA11FFC616B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 18:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C77310E1CD;
	Fri, 13 Sep 2024 18:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vtJVRtTv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F80910E1CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 18:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stHDtLDz2UgMccAPauCHBCd2TOl+N+8lw98KEFPMYs6ln25b5akonsssSn4gmbGyshgiXwDnZNChQ02wTGQ+WuHEhJtAi+0Idz47mYz8W9eT7RganWgPiSPIBwb6bc+hV6G08kV/Fri4FihCvCp8keUjtwhk2u9zQpzngw7ffUECkoIfmFVwy0G5S3+2l0WARf2hkiqbVxXtntAz2MHdpVkEWpYTeWC32wTQ6klhi3HVrKybvY3/V1QI8eeyMhRbyVei/nq+MDe4XFQXlkPKt/u7AXy4IsVzX9wICI6n/LfT9J5o/9wAyhZBh8qxdewBZ0G7BcDFr9cNi+NenfoY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZPJiZBzWNW9QBAYZppBs3btOjTnT9KueDlrI8ARVRc=;
 b=JDp4xGj/0HGybYS+DLe16EMmhtM+a+YC25+ZODv8Wty4SoUnoSif3KjArPCpHgHIs1v/OBbE95j2DKouWk4uupYKkr+55mSovrL3dVXd/FKErn4gpmRMGmQ1dZEXeDtNVm+N5OO94z80gTcRsbv+3fANAO57RoKSnPL2d60M9RZ9WynDmjhAUtzTdB3Mz7mVE/ZRY/mB1T9PR0t9vCf0rV58nZiEUl3UzwOnMSrLcdLpsm7d0niEQ8kFwou28IzMSybQrAhRQN8H2SMx8SUxUo0faaKvlEBJQUChjnswTPKWAONdY3r8NZkTI8iKBibMY6B8qBcZ+nLqW87SpYDsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZPJiZBzWNW9QBAYZppBs3btOjTnT9KueDlrI8ARVRc=;
 b=vtJVRtTvgYTA89CEvI3naz0OAyxzYGjV1E4uyF1d2bhNhIp0WI5F57lqn0PK1TVOOl8C2WKL1UO97VHKL+n7iJD9gy+BzH0PMFZYhA6KpTeJbyXVReQ4dI4ZByrqpH/31pb2it4F/ksUwHGmIlabMnDD/pksMfPmAUq3Z9E1bKA=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19; Fri, 13 Sep
 2024 18:00:53 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::8e) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 13 Sep 2024 18:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 18:00:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 13:00:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Harry.Wentland@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Validate backlight caps are sane
Date: Fri, 13 Sep 2024 13:00:39 -0500
Message-ID: <20240913180039.38146-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: f287f7c0-a4a5-44f6-efaa-08dcd41e020b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0GJzpnYsk38iYH5izKCQHMoJ+kV5Tj163ouQMkUgnYK83BszT0daJiTv1TKg?=
 =?us-ascii?Q?4m4wGrFM79zs3OxckQRq1us9a6BMFD6k7Ov0kh7/NQb9GO4CLdzHA4uM4qbk?=
 =?us-ascii?Q?QlQdR1r/IIHr0nkBNxqBjTUtE333GnmtLTe7sOS2pUv/XiFzWnu7hoWb3aVe?=
 =?us-ascii?Q?gLyPG1HDBUmTsoX9J1Eww4C3LoTxHHn2JZO/AWl16JscSnKO29d/Y8nHOOi8?=
 =?us-ascii?Q?5lZOblaeghTzfvukDzHngwWidxi9x9xYPq4hI8UloFatBIon+m8YmXcWRVUR?=
 =?us-ascii?Q?pNIYP7EMpZOUVJUk6FBFnjEwJ6CgHtLB498CfBo3HJ9oE6iJypGu///jl4KR?=
 =?us-ascii?Q?YePgd5wRtgFVjka/HZ2WYBfQohj4LnAObidzctQ4WA7JJrf3ZZcNxKZLu6gi?=
 =?us-ascii?Q?ZtWpf9LAj02GAuBtmiJHZfotInUrFrTzCcpgyJNz6o6inBxo5l8pCeztUDg5?=
 =?us-ascii?Q?t9oBvI32AIQ5JDO0nDB8TZKj+KA3CoajRFq0x9dh3MXNP+kt21wBrnBjW6gg?=
 =?us-ascii?Q?d+HYhU5sQT9WUdKFPG+WABoD0UaE22+yoUjEy2uXtIZVN+PjI31RkCyO7Hzm?=
 =?us-ascii?Q?Om/HrdunI5aO3ggZVXj8k+eI/yvTKIQOUjjDs5ArPfJg/vl0XbfJfWAPJ+JS?=
 =?us-ascii?Q?TQiOultcndIIQT4IkBe6MQ24A5Sn+rmahEIKsLuecRMGX38NjALA4p5CyLgC?=
 =?us-ascii?Q?wvG0MvZstxo1JOVoehHq9GRmfNsy/PFfg4syV4sMPMtxs0x0Z9RyOcjysTr8?=
 =?us-ascii?Q?YGYNhwm8cttVgbgw/PsL0OMqyP8dJELmHUPyAl5fuJlwnS9+/sRDanbxsHDw?=
 =?us-ascii?Q?soWQ8DT+6N76yD8g9wdA7YPo8BVO1DcpIJUM4tWHLQWwTkKdT7VmoEIvB2w+?=
 =?us-ascii?Q?4ps3G2SuouLVyjVaM8IUd6OMzcyAin8bkPniLqCJxOM6fDPvKd3dtg9kMY1B?=
 =?us-ascii?Q?qZRyYwgjPGqW5ZUWKZq4g5LPf9djSxdGNuNLrZVIx3ZRLtYpicjPgSBadYJk?=
 =?us-ascii?Q?u74D2/ZV7sTK/iBOoOYaK08tbxL+BNCUCWWjv5Brd60KDWy+sdNWtHbTk17z?=
 =?us-ascii?Q?pcDiHdFcfVZBhwIoyFJufUKYUH0lvlcuD3mGC4n3NzC3xQ1PX9Rt4fU6+Vkf?=
 =?us-ascii?Q?Rz83uCoxHN8U4DkdDdu4mqlbh84dsHdKd5gzzQL3Qx0C9gv2q2bGx5WC6chH?=
 =?us-ascii?Q?YGZXbRj+Q28jLvSciy0mTwODDhnUljmHN8Xg5/u+8wea6XiFsk2EjoFSLVBs?=
 =?us-ascii?Q?SA2N5wNxtfWLiUS+k9no8VKwUTyPECEYVy0q47/NPEDJoIidcGaMeVLL1hgw?=
 =?us-ascii?Q?EfavXrj7wsIGIDXZy/+NdveftUeeVBIMsUHYDdGMM4tnvnIihEKMibDIrgcq?=
 =?us-ascii?Q?HvqcAjRQ2r/iK7CrFjKTrCS5A/L2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 18:00:52.7118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f287f7c0-a4a5-44f6-efaa-08dcd41e020b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

Currently amdgpu takes backlight caps provided by the ACPI tables
on systems as is.  If the firmware sets maximums that are too low
this means that users don't get a good experience.

To avoid having to maintain a quirk list of such systems, do a sanity
check on the values.  Check that the spread is at least half of the
values that amdgpu would use if no ACPI table was found and if not
use the amdgpu defaults.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3020
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5942fc4e1c86..ad66f09cd0bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4428,6 +4428,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
 #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
+#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
 #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
 
 static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
@@ -4442,6 +4443,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 		return;
 
 	amdgpu_acpi_get_backlight_caps(&caps);
+
+	/* validate the firmware value is sane */
+	if (caps.caps_valid) {
+		int spread = caps.max_input_signal - caps.min_input_signal;
+
+		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
+		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    spread < AMDGPU_DM_MIN_SPREAD) {
+			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
+				      caps.min_input_signal, caps.max_input_signal);
+			caps.caps_valid = false;
+		}
+	}
+
 	if (caps.caps_valid) {
 		dm->backlight_caps[bl_idx].caps_valid = true;
 		if (caps.aux_support)
-- 
2.43.0

