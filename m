Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D20C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 06:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2FA10E95E;
	Fri, 10 Mar 2023 06:43:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4163010E95E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 06:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK+hEMkCYB+N8bXLG0aDYmrXK8xanyWNBHXPoybV0oj0gHOMFcs3NMVzRSUOPrdy+w0PbsDiWDUYeFUQ+7VTvguJVZqfAeh53os307BbjxuyWp2LalHUbI1qchSn7T36pKwX6hR0aBqln/cQYzu2Dw6EZa2A1u71ONuULP/N51+mHSrJuOBDduMZXsdNy6rgUUN6a21rmLX6kcYzmCnT7jZrSg+GEk7OmjIawbbcPjgpbg6blWGqJbTOIHdveX3I51YImM98Fd8/F4RVmAQkFZBiS5XMF1dSEnL5g5ZsBzPYJ0+MGbhWIif1W3EnyEQjGBJuSLNpeIcE6rgH3XhHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SGO72IDm+H22xYyYzyb0M0qlyVY9+5fTfh35DT6khs=;
 b=mjN/xkHlV5vMboFBXY5RtJTNn6u8SM8FlniueJZmKqHfFk77KS2ABRd67YBaRZ7XWMONp/c1E8L/TK3HuoPHeDNEZA7wt59MADbg57NLVefcemb+hkCV5CatczKjS2UWGkDKuOwkyeW64EdtDc9fNrjyjpXwStbstBolWHPp6IYjkMfqnf1D9RMsHgZBpiDAS4NGKTF7Aqp9GWef46PMRuoYZW+qgAJ80YnrmPiFHzRbrwZC0itdp1l/83KAQobZPfyPCjOE6tv2Ce7wzEyGEFU4ZM4k4nyMs+62rkmOnu6aWIoVuq7a9X3C2cfb+y20H92GTARJDmsIHFJwCc0mSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SGO72IDm+H22xYyYzyb0M0qlyVY9+5fTfh35DT6khs=;
 b=Anls5xhDBRjdZjWGF2FVqLW6AWhTVNT461SoSLAnjFE22arTNQ5ul+LgU3/8aWTfOQj51xC7bFFKnAJEoUZjj6AlS1jWheiowfNsT2PDB+iIuuNG7mVqpKd6+VxzGOlMF8CblEL077i9Jc/OLZinjiK41FS6hMjIPfOzmtfbfQg=
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 06:43:50 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::38) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 06:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 06:43:50 +0000
Received: from llvm-tr1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 00:43:48 -0600
From: Shirish S <shirish.s@amd.com>
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] amd/display/debugfs: add sysfs entry to read PSR residency
 from firmware
Date: Fri, 10 Mar 2023 12:13:12 +0530
Message-ID: <20230310064312.17127-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4853f9-c0cb-41b1-f83e-08db2132ceb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcBsGaNYf6nLH9eF1ju1JdiDdmJNPi49x2mmHll3H+cBq20vLk8MhQ2f7rctt7/73vqs4EpONWPMRhAbSC5Hqvj9hKLxF7cWH2KT8npvHthkiHpq1S2rje/RwwXq1fBJqCom/IqAb5EKPw+ceqCDNiOk+Jx7SKwFDxvbyS9OQ03JPs8ICzvo0ByTVzb50hqaV6Pp20m7FMm0ERn7sOrqNfzosM+5TYskKbheRTtYTu3zdtrienk9qKvr9oGiT0UsPI8gXf2MnEPTj1L1LcwfKOxkQgBWx5hrjxLK1Aym6LxhSlbFhtQKi5KNNgaxnrjXPlqIBQt1Sr4L5FXDAwfeto3b3rZor5phDhARAile4gSpotrL/LdHDNh8xqGUFw9Sh7iaQYTVr1mAcQCSsuoX5tzdrcP1f3+6DCTNNISwAPMMdoAQONvm0UJ697gtVv7Dqw5QZtU4adGePGrRowu2w1SH+Wm5kHS0DthqGR0whdXYoz6a4W8gPSqUObf9vw9i7Hs4AtEaQ8cL5wP44CZ3GpAElUAgQwFNvy9RIAePer2xxzRB5WTLvbhTS/yudj7Lm/oUmNIhFwy+7XyXI2zuGNP7O4hTJAU/bE1yCUjTgFpDfNwdiAdw12OeWnlj9cwAd7wl3/vbdNXXxW2XHvPBYQx2b0jA0rgtZX2uMRkzFetBCEd8ys4rrWTN8AX3iWhkAupSDtz9AWH+0N9W6eL+duzNmzwdcxKOJ/eUnJi2dfM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(336012)(47076005)(426003)(6636002)(54906003)(316002)(110136005)(36756003)(40460700003)(40480700001)(356005)(86362001)(81166007)(82740400003)(36860700001)(26005)(1076003)(6666004)(82310400005)(16526019)(186003)(2616005)(7696005)(5660300002)(478600001)(8936002)(41300700001)(2906002)(8676002)(70206006)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:43:50.2832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4853f9-c0cb-41b1-f83e-08db2132ceb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently there aren't any methods to determine PSR state residency.

[How]
create a sysfs entry for reading residency and internally hook it up
to existing functionality of reading PSR residency from firmware.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index abf7895d1608..d8a5cde2b06f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -35,6 +35,7 @@
 #include "resource.h"
 #include "dsc.h"
 #include "link_hwss.h"
+#include "link.h"
 #include "dc/dc_dmub_srv.h"
 #include "link/protocols/link_dp_capability.h"
 
@@ -2793,6 +2794,22 @@ static int psr_get(void *data, u64 *val)
 	return 0;
 }
 
+/*
+ *  Read PSR state residency
+ */
+static int psr_read_residency(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *connector = data;
+	struct dc_link *link = connector->dc_link;
+	u32 residency;
+
+	link_get_psr_residency(link, &residency);
+
+	*val = (u64)residency;
+
+	return 0;
+}
+
 /*
  * Set dmcub trace event IRQ enable or disable.
  * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
@@ -2828,6 +2845,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_g
 			 dmcub_trace_event_state_set, "%llu\n");
 
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL, "%llu\n");
 
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
@@ -2991,6 +3009,7 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
 		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
+		debugfs_create_file_unsafe("psr_residency", 0444, dir, connector, &psr_residency_fops);
 		debugfs_create_file("amdgpu_current_backlight_pwm", 0444, dir, connector,
 				    &current_backlight_fops);
 		debugfs_create_file("amdgpu_target_backlight_pwm", 0444, dir, connector,
-- 
2.17.1

