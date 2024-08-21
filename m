Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF25C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389B210E70D;
	Wed, 21 Aug 2024 22:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cITRGZP7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC3E10E70D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbWLPbwhHfg6KNFqYykVnlt42aHqan0blAx++xvZ2Rs4ZzfsBNhwi7qnkb7ZWEuaKlu4m8quyyTfRBdYsTZ10LC8zP4OhXpOCsMNZcErJkrI7AoIJBJlOGSCLLemUPdJungIleU0L/Zpx+FigPPBc1TGYq5BtpEkta2ozveAL/YA+t5mk2/P5zvrKaFkgVQ3eD/vceIBkjdb2T4wRPfnPYsZAr2fWl2B7XE69yrQLs0IAjp2xTZCfskVR10ScmJFMIRX93HyemiSVgIjw4u6nM7zOR7j758gBDwAGrg0wwKSkEJSqGXdFnFdB/R1sNEDioYJHdPaRXHc0aS8fB8abA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+0i3jy2MACe2sW3NFtXdmTrggMru2gy1wUr65WXjqI=;
 b=T0ijF2w2KTWSVVEl5oSRpdaXoQa08RigH9nlHmZuSb5zAHGBGlSyaYNMq5wyU5IwzqAnVEHgHbpVSYQTiG7TnnsCVwcz0Ut6sXenSv5wUzmVUqVbEnwbwof/ARMuqfeCMy7XG95K7taN4pODJQY7kKNdwii3dowZnILbkyXMfiIZ8MDPkCFNM7RABR9+JI8DM8fzn9srfz+0bHtU1J1a4yDFBRNDy+U6OK3t69mHryqMvr7FinUUOlL7nBFllUgYx3xu7VU0j0a0TqCeBT/MiBUMGsJUkFEiIGitL23S9Q08dJPm0ZU+6KNhwzGMxAaDAAeETf6bY8qDnebIlg2hPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+0i3jy2MACe2sW3NFtXdmTrggMru2gy1wUr65WXjqI=;
 b=cITRGZP7s5iCGBYSFhKzadtKxpJ+7NODYIf7Pm7TNKl1PUEHz088De1PogELrROe1yd4zOHJz4Jdo/v86ZQflBTqQWxmpEIkdGUzeM1awk49loUy7eZRqXM6MDuyX+RESeSNK/HfcUIblWnYzD0UW2oXbnis1w06KqM6R8leE7A=
Received: from BN9PR03CA0443.namprd03.prod.outlook.com (2603:10b6:408:113::28)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 22:04:52 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::59) by BN9PR03CA0443.outlook.office365.com
 (2603:10b6:408:113::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:51 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:50 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dennis Chan
 <dennis.chan@amd.com>, Robin Chen <robin.chen@amd.com>
Subject: [PATCH 12/16] drm/amd/display: Add Replay Low Refresh Rate parameters
 in dc type.
Date: Wed, 21 Aug 2024 18:01:54 -0400
Message-ID: <20240821220156.1498549-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 688c5e20-ca5f-40da-d0b2-08dcc22d47f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3p3vXyzNBafElydqUdykQN9BTeRaxVmgIGPjUAKcBPbMv3LJZr70QI7XHxRN?=
 =?us-ascii?Q?/sgwlx7o2FVTcWAwRjgKc2pmg/NCSuHZVamJKEyAhxK+anRON8xYmxm5dgqO?=
 =?us-ascii?Q?GAuzMojR4SO9wUq9253evIjH5rD1Mo7FjthDkA3XgueYBzUxr3hm5VmRfg8V?=
 =?us-ascii?Q?jvC7VBcnQ5SRORvlaJxhcUB9Jbma9RqG8MobYphMcPb5cOEMG7lc7sjZj5ik?=
 =?us-ascii?Q?MetIUnwewjsS41dhuDnbTcknOQBcMn/wDEkPGhx7rUaJCBj2PNNiW83qi4TU?=
 =?us-ascii?Q?z1zxTdRXXtIL8oHbc/h9r1TpY39SZNLDnJn5lH5wYhzikjO+sRXm2Rx5dFVu?=
 =?us-ascii?Q?88511DJ1gwOzVInR6R60LYmYueE3XYXQdo2fm1kUW1fVk5RVUqOM3iqY3xLH?=
 =?us-ascii?Q?qzi1Zf0QxxcNLjwh6GdX5a62Y6C9/oe3dweECHPGPd25IBXjY8lK3Xqz8+cP?=
 =?us-ascii?Q?uTayPNWIMB0CQlxRxlJlj/cL2Rk+eHyuT815Z02TKNOJONrbc/a3FV6JQ/iR?=
 =?us-ascii?Q?1tiQNLDtiYvSg6IyDCZRDAxt434gjPpFcTZQibVSA8QI1FqX+4DOzgM6+zXL?=
 =?us-ascii?Q?aKA2iEsGvhW95TnOjaz6xaieCI3oUeySJFOnpjCcmd2GnXtCngw1CWQhlzlV?=
 =?us-ascii?Q?K/tr0QWbSUMt0NvIhGXuvLeEIs+WeA6u0xsngsAx1nl8aEdog0aLxHkN9MtL?=
 =?us-ascii?Q?CZRJAhUA1LZsbzM/ASICp1zMWps3c7pRWGpVNm4l93IMzczW3V7v1JxbAZuV?=
 =?us-ascii?Q?2EUgD1n8l7SAbdjXyft4sGggKnt6FqcCEI0fu9A8W0+2xqU1npB14z8Ydrwb?=
 =?us-ascii?Q?kDQvZxulxOBoXGFWZne5kpUve39YVBW3ZOtsC1HDL+1eCrNBfZVfr6Cf4EOl?=
 =?us-ascii?Q?RwzEZGptXoVetKeuXDrgZbdYyAa3wzVrnzq+uzoZQvi7867bENXRS42U9y+2?=
 =?us-ascii?Q?amNt66DL2H6phuovq3ql5gJ13UMbLecl8HCHFMXsxI4+3ofietwMjoUYUECY?=
 =?us-ascii?Q?kwCqkbxOefmVpvAwRs8svzToz9CNf6lPo/wTuB8rp2lfHg7+/dbcnHrupxuq?=
 =?us-ascii?Q?S9i3fytrk9ZyDdUn/Ov2GTheCaib74OPatP65R5lXZgr0YRzK8N2VnugfYh/?=
 =?us-ascii?Q?kFfJN8PMTF+zcwdrSji3/2KT42Q8Neg0/zHs/own/NMxq5nXAR9OCJtUNNS3?=
 =?us-ascii?Q?OjcWCWu5IDixRy37g3Nc4GA7WtJuZ6tAspooCvg4ryyT6oSU3/Tod9y4ubvN?=
 =?us-ascii?Q?iILKCQnAoCAKAwUX+uhQejrfNCmikTqMGh0Ks35huHwlN4ldBPq3ejXnHBx4?=
 =?us-ascii?Q?+S7qGQSX1iT4amnxrfJ1/wgrHaOp2ttmHx8C5ihOpDAMgYZ87942lAe+kVSB?=
 =?us-ascii?Q?meXrj9IkU9sGYqs6p4nLY67hXh8q+Z1zSeFlt+QSDO9TqWjGtLKLG6GEpRPu?=
 =?us-ascii?Q?coKsNW4YUVvWgcdNNbdwgCWhroJdX+xa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:51.5686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c5e20-ca5f-40da-d0b2-08dcc22d47f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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

From: Dennis Chan <dennis.chan@amd.com>

Why:
To supported Low Refresh Rate panel for Replay Feature,
Adding some parameters to record Low Refresh Rate information.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 97279b080f3e..fd6dca735714 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1050,6 +1050,23 @@ union replay_error_status {
 	unsigned char raw;
 };
 
+union replay_low_refresh_rate_enable_options {
+	struct {
+	//BIT[0-3]: Replay Low Hz Support control
+		unsigned int ENABLE_LOW_RR_SUPPORT          :1;
+		unsigned int RESERVED_1_3                   :3;
+	//BIT[4-15]: Replay Low Hz Enable Scenarios
+		unsigned int ENABLE_STATIC_SCREEN           :1;
+		unsigned int ENABLE_FULL_SCREEN_VIDEO       :1;
+		unsigned int ENABLE_GENERAL_UI              :1;
+		unsigned int RESERVED_7_15                  :9;
+	//BIT[16-31]: Replay Low Hz Enable Check
+		unsigned int ENABLE_STATIC_FLICKER_CHECK    :1;
+		unsigned int RESERVED_17_31                 :15;
+	} bits;
+	unsigned int raw;
+};
+
 struct replay_config {
 	/* Replay feature is supported */
 	bool replay_supported;
@@ -1073,6 +1090,8 @@ struct replay_config {
 	bool replay_support_fast_resync_in_ultra_sleep_mode;
 	/* Replay error status */
 	union replay_error_status replay_error_status;
+	/* Replay Low Hz enable Options */
+	union replay_low_refresh_rate_enable_options low_rr_enable_options;
 };
 
 /* Replay feature flags*/
-- 
2.34.1

