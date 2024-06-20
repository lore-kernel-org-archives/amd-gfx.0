Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6570AC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD87910EB1C;
	Thu, 20 Jun 2024 16:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ser2aQ3H";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4673010EB00
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAAoiCboHfeqyy5HD9jAqjC4FR2Ab7SCA6fzFuBqw3OZI3xeZ0Y8Lbx8HI0HZ0LW87rTcu8cbj25hUwSnnUp/qsdc+D1cTN9PwGORP4lKgttKj7mQ/UEXbxMqB4DSLW3/kiXJ1ev80+8aSVQWdBjdB2Np2BW3VFEera9EWXlHtZah8aGlKxJ2wWMRxrzQL7mkCdSnhhSBsKPCQ6ZVP2JgqT7KLUMpAYE27DsCtdVqk1cqCAFDfA+py5rD8sZqIDs0dsqjQQyte2lHXXFmdW4+Ka2qImx8Nzp5NHKwJWP/8LW5jGvSVTGO01phCaVGEeVTtFUShj3DnjgIiQema5Crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v73KCZF2ALSys1+j/V7N6tj8EpElIfnHLnKUQsmOzFs=;
 b=GJdbypV0ohbcLWJiYuegMooKzKE361SHmfJMrb59wpiOgKinN0D4NbH2L0KBjnqptbuLyF9x5usawaVzBkayxhsyebfKMeDVSXcaBpbPhX4jO8zP/xzh/a/+LmdljFqeMvWHv5j1rOblpgfJz3MLXQzubUyVxmZ89wBEQKv+RML57ROcV4fXboEHjA2qY0R/7MxqrupmDerl1N19/eqoyv2nn41bpXogfsiVpIwxiB7uig2Cb9kSBuTbQaWPUi7NnylPkq8vAQvWcuvxm3KgzKZRGzZdJQSXx8YledOcLj20BOetgzlgO4wJRXg+sYotXQsgIANv+DJH3gNAn6oe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v73KCZF2ALSys1+j/V7N6tj8EpElIfnHLnKUQsmOzFs=;
 b=Ser2aQ3HEqJHNHp/XgI4U395nHFKrOuYPh4qp6Y/rkprIRtLDlsBC+aavQ6g76kWVgGep8yZlCZ7HKQ7qBzSaT0aPK4PdEjLpmcLo8u8sUPwUYqcvRNXuPBMXFzjBcuC11Am4EMyegOvEVIx2SPgjPeJk2oePN1gy6rG9U5kvMU=
Received: from PH0PR07CA0057.namprd07.prod.outlook.com (2603:10b6:510:e::32)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:14:59 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::8c) by PH0PR07CA0057.outlook.office365.com
 (2603:10b6:510:e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 16:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:14:58 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:14:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 12/39] drm/amd/display: Check and log for function error codes
Date: Thu, 20 Jun 2024 10:11:18 -0600
Message-ID: <20240620161145.2489774-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9a6165-b41f-49d5-f244-08dc914421a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|36860700010|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FHRaJ8ootRxUoJODOGBWDy+TtNWCpUUVIaSXbI4RlZnjHeul5/AEg8NHC8Z2?=
 =?us-ascii?Q?gYRkp6bpzkZ2/qrhsLTRqxkvOnRoxPz4vAyFZNNclvCHwoBSSdIxENDhrS9I?=
 =?us-ascii?Q?3KcR7mBV47ugzUXEeESAyuRcHJKtlpu6Wdehb75mJxMWR6VQKEAf6elbTqAk?=
 =?us-ascii?Q?RE/T4OrHApqLcyVfg1dUB5R/YdoDnHMAkt92Edf1HdypaxfME18Fyn4jYW9e?=
 =?us-ascii?Q?VDKMi1GZsGsF4RX2TxqtNKystoZ/r4DR5iWE6pNVexME9GIeaP2p7jYb+jmn?=
 =?us-ascii?Q?C1RzvfI4/AIPTpWC1LTu69QiwsV8XCx3LVozBYX2INJmO0OiG4Qa5mFN/25o?=
 =?us-ascii?Q?/VskV8MIMVhrqT7MIiczt8VQQ5hPyCGyW4dJ4pbqK3+R9mxTTtvC234cOTSg?=
 =?us-ascii?Q?OriMrxXB5BBeyIJ/5ILd5mExGf0EkiL4DsHneORiVcryPcpGVFV1UZMdErf2?=
 =?us-ascii?Q?PsMmDrybHKXtQNqNz+negYws5/RczSJxKGHABTCBoMMexkqlZScCCadXQc/A?=
 =?us-ascii?Q?hJqzQpdFMI0sYDEHjLsBNz1cSiONwAAPs10UXgQ0p8vjjTaTP34ZI44ug8VT?=
 =?us-ascii?Q?qtmVWb3De9FCk2JRUGTv4Y1mJmRqe/zSqmGdv/W/lP50q4GKT1ChJtZf/MzH?=
 =?us-ascii?Q?BOhbIxBkDaDA92LEq6gFBkSiEZwTV8KBZuqoePEiAjkD4OOjkuAamZJCrTRM?=
 =?us-ascii?Q?ETwW9YLMjKtqDE5qfDDFYLcs2YorVkhmDt3gOX50arlxSLM7biYsivPvUEf/?=
 =?us-ascii?Q?yLAmPhjSwoDzK+Gcwl+yMInhjVfLY+9JCeIdSzVJ6iWlWKIqifpAX0VYC1We?=
 =?us-ascii?Q?p6KZq0s3XmEj9ISuJ6yEs/z4InLaOxoA23i7A0pkhVGYL3qR3dw6XLVdImCI?=
 =?us-ascii?Q?x3VsVjw3izQ0uQMi5PYU1+IBHWd85wbGt2vemuKhWpzPKPeE1AgLHBboJWRa?=
 =?us-ascii?Q?O9GXgAvaF9SaeIyEsJDQUZJBVj6qRZ/Wkj9PrhLRGkoPwVLcVtk4VO0Y43nt?=
 =?us-ascii?Q?ohpP7roU2ekhmZfwqXT/ZViZrltmBzEjNCscty49Zw38X1Np/wZ/I7FbDXKz?=
 =?us-ascii?Q?6wVwezgjUpog+H1txbuPmRPFvzlj7ATmvI+E/AMCuB0nRkK5Bpc00/Nkhc0f?=
 =?us-ascii?Q?drzBDDz7O0UoqkHhqyOrOpkJ4p3ntsOkXDcCnif3Qwr3MgEGzDlYW07dvSwT?=
 =?us-ascii?Q?vb/SFO4X1NJxBOLsip5A3nxlrooG3M/uFqIBg6BYqTY6ix6jg0T895eV6pDX?=
 =?us-ascii?Q?wYU9nGIFwdGMZnnGOlEIAV5gR97F6T6CIwb7cQfchSk/Ttnl+37xteXQO7H7?=
 =?us-ascii?Q?vvnOla1rH5WAh/68eAgO9oMggMO7H89JOap5MdYOmTjSf+lGYXxTZwxgTs+I?=
 =?us-ascii?Q?DVZCYM5YBVXvwUW23DlB9Ve/FBVNLGZzNwdme9bNvlTaWsx0+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:14:58.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9a6165-b41f-49d5-f244-08dc914421a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

[WHAT & HOW]
BIOS_CMD_TABLE_REVISION and link_transmitter_control can return error
codes and errors should be reported.

This fixes 3 CHECKED_RETURN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c      | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c     | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 8 +++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index cc000833d300..4254bdfefe38 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -227,7 +227,8 @@ static void init_transmitter_control(struct bios_parser *bp)
 	uint8_t frev;
 	uint8_t crev = 0;
 
-	BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
+	if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
+		BREAK_TO_DEBUGGER();
 
 	switch (crev) {
 	case 6:
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 136bd93c3b65..4a9d07c31bc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1361,7 +1361,10 @@ void dce110_link_encoder_dp_set_lane_settings(
 		cntl.lane_settings = training_lane_set.raw;
 
 		/* call VBIOS table to set voltage swing and pre-emphasis */
-		link_transmitter_control(enc110, &cntl);
+		if (link_transmitter_control(enc110, &cntl) != BP_RESULT_OK) {
+			DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n", __func__);
+			BREAK_TO_DEBUGGER();
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 4d0eed7598b2..e0558a78b11c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1104,6 +1104,7 @@ void dcn10_link_encoder_dp_set_lane_settings(
 	union dpcd_training_lane_set training_lane_set = { { 0 } };
 	int32_t lane = 0;
 	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result result;
 
 	if (!link_settings) {
 		BREAK_TO_DEBUGGER();
@@ -1138,7 +1139,12 @@ void dcn10_link_encoder_dp_set_lane_settings(
 		cntl.lane_settings = training_lane_set.raw;
 
 		/* call VBIOS table to set voltage swing and pre-emphasis */
-		link_transmitter_control(enc10, &cntl);
+		result = link_transmitter_control(enc10, &cntl);
+
+		if (result != BP_RESULT_OK) {
+			DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n", __func__);
+			BREAK_TO_DEBUGGER();
+		}
 	}
 }
 
-- 
2.34.1

