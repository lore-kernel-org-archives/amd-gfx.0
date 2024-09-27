Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2E0CDD1D1
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1715B10ECF4;
	Fri, 27 Sep 2024 17:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28IAxISC";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145D710ECF2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmJ2n1Tx+F6ZpJN/QAN1YaPvXGLiTDAdUe5VVviAayRCcCj+2NLOcWPRAneItljUxfX7XdaMXZrmo5uH5qi/SiGsUb1op1ON2g4ZwAKnnBU3e/H3CMBxSGzKGLs9Bx5O4wVD85XdExLu5hIZGZ0ozD/lM2/7L5aYsFhFlSpx/aSOAd2BCV7ygbEUbd5nbSP3iauBMp7uNSBQILmFcqeNBC5/7XN37wiboHY/APKkwCc9XmKfXnDXDnzTMJSjCkp7hPI519nPYpqaCqilMW+Yv0qZu7R3YFj3EsNyjqMvBsaxyQ0qPcyCJsANhW1C6dlP0WRXVKYhqAexkJccNjFfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDUMZUDTnMSPUSALZCQh+t0CE8+YElU2DrM3fRKIKxs=;
 b=UbhWW07huc2JEn0rMOpXd7xptv8iAyiHc+Olt3hrY/dfcg8fVQ1RzUAretqC39z0W3/n/sOsY23Xv+oePETtenkk4AGQu2YbJB0h/jkRzNnLkodX5SoCCLakGuQifsyG5gZ+P7dnh22/BSlCs8OHGX50oTypPfVulCHWF343jsXC0JTR8v1XvphVl2KPGHDWOFChUrZ1zbLj8bjHRJF6WuF7+kQ+sqXFW+dXUO0zXBxhfxmgtY4nAdLaky0f4KVhTFIdtDnodSC+bsJFrj0zh+/ueQ0zT/OlH+1t2/JsyfJXTpAhKs1wbqbv+Me470IZajsfixzroW2M4Zft4YmUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDUMZUDTnMSPUSALZCQh+t0CE8+YElU2DrM3fRKIKxs=;
 b=28IAxISCbIW4DwsNuSR2v2e00hVuvLzapmv8J2rd4FMOSHjZ+lEileYfpX7qgUFsC8cgIIAEan0Pf4gJQ9FxrSmgBECEPFytAlpW2pdx9G7T7xslTKfQ7l5CNAVhvhsKWeHLSM8X7pwOZVzE9gTFJiJ2JduZM2EWso00goqt6xw=
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:01:46 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::30) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:43 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:42 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Muyuan Yang <muyuan.yang@amd.com>, Anthony Koo
 <anthony.koo@amd.com>
Subject: [PATCH 05/13] drm/amd/display: Change Brightness Control Priority
Date: Fri, 27 Sep 2024 13:00:55 -0400
Message-ID: <20240927170103.102180-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 57204300-151d-4569-c86d-08dcdf161220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TPg2JM9UlBqQnokxcozgsGScUONcUUye2pRR5xFoyTXlvn1dvv9+Quu3ym1w?=
 =?us-ascii?Q?QQD+yZPM+r2vTg6DCeUDH3Fd4x9FuNQhzVP6ejXGn+uEhwqDxOodLA3JU8VB?=
 =?us-ascii?Q?liyo4AHcJxKI53+g4I6pV2u5yURY0Rz8KH4OpMMSAUPMAUrd7SaFwa56WILN?=
 =?us-ascii?Q?O/NyZKxjoVVaVsN4OMdWjrHbBDoxI9PPIPMxKDMGsAqL4N46mLOcQdqoy3R3?=
 =?us-ascii?Q?V4+20vMc+vbDJZc1+f6uUJ/B33aKBCQD12EAZnNpA6LVjYrZmOqq77seK6tl?=
 =?us-ascii?Q?rjgieUiHZyi1dyP9z55i5X4JogrAf1kiRtXcvaOxrt9kg9/LrDW/Xanv3oUP?=
 =?us-ascii?Q?XK1KqyJhFsZv59VhRdZm3wyGLS1NhNs1cKifmngJ/ulUmYjsqt1xT7Z44K10?=
 =?us-ascii?Q?OiHMzHoJkCcpdQzUcz+VWLcsji1JnJoqUWZtwJ5vOYGzZTRfkfvuhn85oe1Y?=
 =?us-ascii?Q?MysL7fR4BPJmT0Xxdt2eXbrZ+lL+8lbrXXutswLZZ8LeJXm3yRA6py7dg0x6?=
 =?us-ascii?Q?w+Q4N/1a6aHp8JTYImfGsGdnAkAf+3/wojDCi9s6evoRq41kfi+A9fHBkpgP?=
 =?us-ascii?Q?IedXR/7tKc2XlTwc1eOsbi9v36KVPRGC8Pb9Silv10WtjvmqwKE2e3Hx0hJn?=
 =?us-ascii?Q?vSI65LOYy4N7MnWfvGg1anGG5pECgepdPO1vTjr4QnEOXjKEwoCbvxAh6Ykg?=
 =?us-ascii?Q?VyU76oF01/2ZGS8UKIHA0emgUagEB2akG/wC3Lt85joGfo/ojTl64YMq0DvZ?=
 =?us-ascii?Q?AXi+/xA3jsYlWfHisuMgFgYIP6t117Q47xmQ0pYTkb9a8vd1waSZoYDTii/X?=
 =?us-ascii?Q?QlsCSpuQhjRnRCofw+LHJeDaEtkeFSSb889ItPT40PV6PvufL3Hy5EbANnhz?=
 =?us-ascii?Q?VIIp4jYUjQBQZ0u7vIq9qpJiNqhD5Uh1dCLcVOilqn+6C+pajaSDJZCjZIAH?=
 =?us-ascii?Q?YQoiVisj/CxrrczFpyvMI1bALI3xmwi+2r+M8ZXd9/5UIzFD1R+lECszQ29M?=
 =?us-ascii?Q?8vws8ijjNUjZt5f6OLssp7gLKVDxFb//zpAcbnjWap5PoYwZEpekipFjGp/r?=
 =?us-ascii?Q?4vS6tN2dIszL2s+BqBUzfE2C1a2VFsfiYQ652t+WPlbRFEJAp11XRvcPoSuw?=
 =?us-ascii?Q?xDI5k95RLoYH5uFzEcQhqFtDp4jvz+SzdsEONFAm3oz9PFoOvpMdKC9nf09j?=
 =?us-ascii?Q?FUwnhC/OqqbNMKXlRdcF1W5nF6LQy3b0+cbi6ACxtz5Qb4LGe2cfH7M5kZBb?=
 =?us-ascii?Q?vmYX2cTmBSJUZngjP9dOyIgWEjv7RjOSNOdI08ngPNidP+s/9CdKPDC7E8e8?=
 =?us-ascii?Q?06XMtfWDW7ASFrd21ZJYNgSLG59+gB2z3+UaJkNchwhGG5dnLm3G8MKjUO0S?=
 =?us-ascii?Q?7ozRIwEMNW1pm+ApzXB5meFVg3Sf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:46.4305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57204300-151d-4569-c86d-08dcdf161220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
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

From: Muyuan Yang <muyuan.yang@amd.com>

Prioritize Aux-based over PWM-based brightness control
for more types of panels and introduce a new structure
to store and manage the type of brightness control used.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Muyuan Yang <muyuan.yang@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h       | 1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8878a770c376..059e5f4ede49 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1786,6 +1786,7 @@ struct dc_link {
 	// BW ALLOCATON USB4 ONLY
 	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
 	bool skip_implict_edp_power_control;
+	enum backlight_control_type backlight_control_type;
 };
 
 /* Return an enumerated dc_link.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b0b7102fdbc7..3401f4c9fb10 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -923,6 +923,12 @@ struct display_endpoint_id {
 	enum display_endpoint_type ep_type;
 };
 
+enum backlight_control_type {
+	BACKLIGHT_CONTROL_PWM = 0,
+	BACKLIGHT_CONTROL_VESA_AUX = 1,
+	BACKLIGHT_CONTROL_AMD_AUX = 2,
+};
+
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 struct otg_phy_mux {
 	uint8_t phy_output_num;
-- 
2.34.1

