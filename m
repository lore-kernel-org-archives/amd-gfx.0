Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968CFE77180
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4859910F06C;
	Fri, 13 Dec 2024 15:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0cR5xnuZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41EA10F06C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za9W5veekVyBFB9QPzY8NcJGphTdau7VgHK9+GKRu2PB07z799leu2AmKNKUCHyS6bypn3/W7FeIc0t2yoCC7jqoimB2uKiXpplHPvLnM7P0oy6VZrLFZ7tuc8aInNhx6RgEjg9lR1Id13D/CgkrI2l2SZCst4KrLtTLrzgyspq/UD+GYzGh02lZvQyznKDObgTm1H/AO9kkk+zXwDXXkm6Rele0dRUZjBRrZ+XXMNA8Vw1VY9gBURdUTQxNbQ2Uy8sqT/0MkvUAqPxxEaZ5EE61VcHebJ7cJKcXh5OttkSAxb9rCms8bha7KyWUNpk+/4/0Y3QCtI9pmKgcCe/QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kYcxfPfnd1Sv3+Xp4nn1zWfkziaIRGuB4/abuNW4VY=;
 b=gEUy8dLgF5RQmCH+NPg6heSh9bVcLEIwp63iFAF8s73ZppKjviAwh/hVgndAHA8yJyS9qaR0g46LZyRf24Q/1LNXZ1rOeaTulcM5PCNxXSPbSDWjnrjRdhnZl0nlhXZRmgPhSsv+EmZe3Li4k+fiR47xvam8DBLkmYkc/HJGdRUhTB66W4Zq0Cl6KlO3/fvVRMVBch9eGgvMjdxwHVp/s+xDQjG0RNLt0dTwxWknvo+rm9hNq10kvS0fiq9ZiyrvvDy6tU9O1ymkRE0dTSsgLNqgeaLVI9Ba975hbINuI49IBrEdSeOpIfGCpIMnTP7SaGqiR5yK+UfnbFQagwX7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kYcxfPfnd1Sv3+Xp4nn1zWfkziaIRGuB4/abuNW4VY=;
 b=0cR5xnuZL+75nBpHqJqOZ2juewGLm/9lGF3GIqBdPahPu6LlkjqAbhER6eiAWridaz3JyGlDosG1iv8PQHYnGTMcs/gjW+TX5/NF6GUFVoHLx8owIdHyvFbTGBs6SU+F4y1jtautxPkYvPvLzljNmw/IURKwk6pDbcFwS1YLtOs=
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:54:42 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::e0) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:42 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:39 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Meerpate
 Patel" <meera.patel@amd.com>, Ariel Bernstein <eric.bernstein@amd.com>
Subject: [PATCH 03/17] drm/amd/display: initialize uninitialized variable
Date: Fri, 13 Dec 2024 08:52:35 -0700
Message-ID: <20241213155405.393252-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4903e676-e138-443a-4e17-08dd1b8e757f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?62sJk8zcVcX4tmVVcSDAeVAJ6lSP5dme/uJQQ+M7gC730d6Lv1Azatg0k5Vb?=
 =?us-ascii?Q?5G+UwlKkFkeeA/ki8X9Nh+Q7qtAGgAJoW/dxQbyLh2lZcKZ2hqCIOVQK9g3C?=
 =?us-ascii?Q?dS+6AHdOzj+2n+pFpIUILdc6JubLgha88U5vnjXM4RTtP6Vv9Mgx299d5T+B?=
 =?us-ascii?Q?YqJC4IdtChydURw3AAotxDCJQ4tOYzzNa/Ka9ssr9VQAHE9fPsq+6f4EBwvK?=
 =?us-ascii?Q?SO1Cj1E9HXpE0a89bVKXwaZXnLmSfzOrP4Rfia+Kf83VFLW6vCb4fXCpq95l?=
 =?us-ascii?Q?UMC7VQms0g+F6iilfhXf/YKvYeqFfD1zp0nyK3+J7JrmUaMXG0WGeGQKEINB?=
 =?us-ascii?Q?rULxEHnRq4bYkf91O9/U10ePLrUkhljugB9rwjx4XtoE056VU28FpFn4ms68?=
 =?us-ascii?Q?h7ADYNPX/+HrEWSBqbRciiXASxLxBIvSjFMrLYSF2PBETIM99W4DG3UtIWpc?=
 =?us-ascii?Q?3WZleIShoVTwzmlBhrL287Jzqbp1Dc+xnkKp/oNujHmpIHZ3mSh+s7N7rLXj?=
 =?us-ascii?Q?XVE+KJtf9lhcCUp7Ux9f/9B9KfuI1Xe2LV/klmX5pXHRglN1evdsQQVqdA0Z?=
 =?us-ascii?Q?jJTZeR5E1UQJ033HRx9oKC2iTK6IvqzyVYjPkeHltN7R+OUMxCjK5ZDOTQXi?=
 =?us-ascii?Q?hN5PIRhlm6fmOGcAnUxkaj1iad8IowHJH0Ma7ivLhdIecIGBWJsykZzrF5o4?=
 =?us-ascii?Q?VoKn80g/Xq6P53X2KzYGyqi24uOINGTv1MwusJa57gyREgKwZr1KTUya8vDx?=
 =?us-ascii?Q?Yb7nCn6yBplVxa6hm5P0H+DRD3YYDgm1RLs88KKGXtsEiwBZVOlI806B7DHf?=
 =?us-ascii?Q?ug/q+XlqFUdbdh2Ocu3B09IHKT+eLR0DRxohon6EQf+OB3/ezxV2hkm4EoHZ?=
 =?us-ascii?Q?jMp8PScvO7gsKbV6vclwJ7YqCP3lqEepCidyPB8+A2ctrB6FNryVNAor3Ilt?=
 =?us-ascii?Q?PMWfFiuM/viKDxaoKtNvHE0Cq6HjlnwRaZg+YTlD+g4FhkiyQgSkTMeaRS3c?=
 =?us-ascii?Q?mne6MuV3oe+rUTuG8vwedMwiij60wUVzw/0E1G8vNelTcLI0EYT1M2n4zUg4?=
 =?us-ascii?Q?bROIJrSFTl8+UKN1oD2hikdu/P+YKEUWLGo9bbdO6bEQ8MsklXtQwTX5+ob8?=
 =?us-ascii?Q?o/6iV+8/vdORVTcOZZ2K88P3RA8wC9DumQYBna8u0nw/zKSchHYB6iGLvdI3?=
 =?us-ascii?Q?aJJxtXTo9u1CdIYr1qMUlmLQKGSTCpaTOq4uKYTgv6azz6DLqWbXoeCRcnzd?=
 =?us-ascii?Q?jDrXtgZCo2KUwC8xf28xTDdPNBCUcLHQDPWbXjt5XRPNXKz0rhJ+fxIdIfaQ?=
 =?us-ascii?Q?A9Cp0FJ1bXyAoTRXqZr+e0ZmIAHC4NdrviyoBSICdKdFtQgF43MTpFoum3/b?=
 =?us-ascii?Q?HhhcLs8aJZUPA6CYoZfpbPPxUZWCPts7cnofIiJjvZiZ67+oGbSo4N9ANh+q?=
 =?us-ascii?Q?lH48zq7wsGgjNsVQJ/QtC4E7e6bAGl/5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:42.5968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4903e676-e138-443a-4e17-08dd1b8e757f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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

From: Meerpate Patel <meera.patel@amd.com>

[WHY]
There is one uninitialized variable in file
dc/hwss/dcn401/dcn401_hwseq.c, which trigger com compile warnings.

[HOW]
Initialize the unininitialized variable.

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Signed-off-by: Meerpate Patel <meera.patel@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 3f27d8ae7f5d..8cb0fbd301d8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -822,7 +822,7 @@ enum dc_status dcn401_enable_stream_timing(
 	int opp_inst[MAX_PIPES] = {0};
 	struct pipe_ctx *opp_heads[MAX_PIPES] = {0};
 	struct dc_crtc_timing patched_crtc_timing = stream->timing;
-	bool manual_mode;
+	bool manual_mode = false;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
 	int odm_slice_width;
-- 
2.45.2

