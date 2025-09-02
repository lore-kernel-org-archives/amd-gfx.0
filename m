Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EB5CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65E310E548;
	Tue,  2 Sep 2025 00:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VQANJDae";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D888610E548
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfnTFZ8VoEl+WamdKHC3UuUubLh27iIey2TOuP4oxXDUZwvXrVEG8CaMUbPTuXU6uuJ1rQGuLBX7XKwZfa+KZ5GOQaqIQ7ypmamcCDSwVGa16MRfPVvbQF8Ia+P89cn4igdb29SQW3b66eaNyKbmYnrKJy44dFv6Xjed7rOOlyjMsEj8o1wG1WJqst+hJamyQch4u/cUVO/TGZQw7HGSfg3/VzT7gCKqzDmufTCUekfmaafFIFSUz8GnWs1ZiBspR8wLWeApV1y8ak7STJ64m9Oc2r4izhCkzg2u6OEcKww/lXAgel8tFPVrS1XSvUg78ueet9QFjUeRGsg7uff8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQty0voyuyqUWYApd3Zfkzv2u88+aXTHhtPGsRIACmg=;
 b=oF5SJJOJL6PWgVP0P+xO5UeO/9CaI/okdUM8NCP0+p+L3WP5BofhflktW/Mt2wwdSP6XiOG7B2uE7p5Q/UHUl2kn0XZG47b01DHz1FuInZk3CZhvR4qQDZ7YJmjSA7JlTvolJP99Gnr/gKqTKwRiXJHTsTi2AMSj+ysKszLQaGTTwoJkGbED2s8MOjG9zvCLcpr0BZpJdlZzKgFxu73O4Mxj7TZajB2Wf/LKP6PsgRt7C0gevVu8jwtSpWPhAuu3DfU9tRfIPbP/ZvgQR370yvHDQtXEDS+WC/Zgm+CaCTtOepau3nl9RHH4zUewrES2qiq55EGcOtLv+ZPTc6YPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQty0voyuyqUWYApd3Zfkzv2u88+aXTHhtPGsRIACmg=;
 b=VQANJDaeYktE9UrwCWVzw5jQeZYDl3JC7Gf9O5Upwv8JW5Nvk1JjRFDcJN9NJRgqcFWYM0mIE+MIDxZATQSv8aaOsR0BJu5M86GpPzAieZm/199Ci3XHsB22bZWwx3yI3keArNSGxdHmqEMqibz7MvP2+vjwn4XrO4Izw5QQXyI=
Received: from CH0PR03CA0416.namprd03.prod.outlook.com (2603:10b6:610:11b::7)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 00:46:22 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::98) by CH0PR03CA0416.outlook.office365.com
 (2603:10b6:610:11b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 00:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 00:46:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:46:16 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 04/11] drm/amd/display: Indicate when custom brightness curves
 are in use
Date: Tue, 2 Sep 2025 08:42:49 +0800
Message-ID: <20250902004532.1833436-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9394d379-e39e-4a6f-f4ac-08dde9ba231a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AP8SoDo9KddKR7Adxwg/oa+ZmYMfwgDg9XmytTY2jfDajRd47fIBzZ0+QNlU?=
 =?us-ascii?Q?CVRkh3tyrkFx5v0sYBAhG+EYWxtTZKmDRjpkkiMOm3b1fGM2Gq/C3A8DCKA+?=
 =?us-ascii?Q?BekxHHlSyTW3doqaj9t2CX+GHh9hrOqPHQJlrf3UQnWW5r0KNju6EYC1Oldg?=
 =?us-ascii?Q?kgr8f8e39oroYqQ/6b2aqCcp6YnIrshXgM71Mv94X1yRtCo4dPamwkkGmwnd?=
 =?us-ascii?Q?9IOVF9VIRGaQJD7pC0QC3UkAD1TZcP9pmASd90J45kcp/Cq1ciI1+KuJFgGg?=
 =?us-ascii?Q?Tgxlct9QL5LLiaYgJKC4rx/lL+F9EVb//6eyOjHlRbGO8czC0yPWJ7cpJIjz?=
 =?us-ascii?Q?og/pYwEeoRQ8ziOJIHy0uaY3GvjRm3zL9OjLE55qhM8n+AzVaKugqG0l70x3?=
 =?us-ascii?Q?ee8caYjIekKmHNdTW+nLKNtenMrG/C0mJPaH3yp1EOoQaB8EXnFL51E4xl4t?=
 =?us-ascii?Q?iLSCc4X5ds/0Hjgd2lcbkcVApHSPgZFtp9RBlQHQivdVFj4tc40hod32lZKO?=
 =?us-ascii?Q?gbE/nahkQQ+UdQUGjxtSdeFVxTrYyecMMtCmi2iMm6aSGyA3IJ4dzrmnn9jw?=
 =?us-ascii?Q?I2WDTeAYCIDY+MpUaOvMCR0EhakZvEeSCY08xBIP635NnDfpDsFoBAi/WCbV?=
 =?us-ascii?Q?5qQHn9fTSkHi9EAcsAAyIkKZvCatTcr62jL3daCEtBise9yp3r7kWTvuRzAv?=
 =?us-ascii?Q?iWDV6QXNaD4OFHH/X82Jc3O5sHfy8xVPROh0XFMn4/7yXOSMxhmqD8JKE9sF?=
 =?us-ascii?Q?BWHvvSyMMl0qO9V91ewFIX4/vsCBrGhTfI5+AU6OlACzqfGlwAPy8H3Kh8um?=
 =?us-ascii?Q?mW3bY3wE3qAbAuxg30fcme16crbnC6q80BQr9f+iAbPWl7GvQd25IlXltUP1?=
 =?us-ascii?Q?t01qoihtyFoqDK6Ozb2f68iRo9mpuawcvmW84jGtsT+aVh6quW9at7Rg0e/J?=
 =?us-ascii?Q?Sbd5Zj8yK1+h6i5ei0Rk41S9+KchwmQY7ZpEXAxWf7l7Wfd7Eo74RcxluyTL?=
 =?us-ascii?Q?JcqnEzLt0XvxU2ZwsGTlFVG2yyKec6Vg8NlUQsEUYqBXCr0H7W1PBbNqlr1+?=
 =?us-ascii?Q?c++J6Vo06ikkmn6bShztchJ89T7E9GgcOYVW8jIWTm5rWT0FlVuYMwq0RM9n?=
 =?us-ascii?Q?GDL3VdcVG0STU1WMfM1Gs3gLp8L7ArL+TNv/zGrJfxDEKyc7B1nIhTwHFh/y?=
 =?us-ascii?Q?7v9/dwGdU1dyKoAASjUaW7wWEYZmETSiNUvUB3RxqE7/ZQFf1yoaJEI6yRN9?=
 =?us-ascii?Q?K/HBJ29zcR9ftkjYKUsEJW8Ca7DievmDYIlxg3WJp+A9kF0Ff/Fe8Zz8TmqA?=
 =?us-ascii?Q?OHw/HJbEHGKnBKFk7amTYxwXPIl18CZZnLdrzbA1caDHIMJVSwsU+WRviN7A?=
 =?us-ascii?Q?QDj4Q9eVXjxMjpHUXSyJydxoDvwNH7DJ+v8DCp9RGUIDNPoYuIL7GMdJgOZP?=
 =?us-ascii?Q?/flV3/auJxktXQOaAWZ982Z43a6QBGQUJk6Ddlj4T8QlW6IVsYZOu/YPva8D?=
 =?us-ascii?Q?jD9vmWqpxhOo58zZvGAERJFihsYoG4ftcALC0xoYDmrmmfOaTawZb9jb2A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:46:21.7836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394d379-e39e-4a6f-f4ac-08dde9ba231a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
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

From: Mario Limonciello <superm1@kernel.org>

[Why]
There is a `scale` sysfs attribute that can be used to indicate when
non-linear brightness scaling is in use.  As Custom brightness curves
work by linear interpolation of points the scale is no longer linear.

[How]
Indicate non-linear scaling when custom brightness curves in use and
linear scaling otherwise.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 242f98564261..7470e1a21279 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5049,8 +5049,11 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	} else
 		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
 
-	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
+	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)) {
 		drm_info(drm, "Using custom brightness curve\n");
+		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
+	} else
+		props.scale = BACKLIGHT_SCALE_LINEAR;
 	props.type = BACKLIGHT_RAW;
 
 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
-- 
2.43.0

