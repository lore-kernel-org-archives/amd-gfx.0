Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DA4C71148
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113AB10E6FB;
	Wed, 11 Jun 2025 18:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RHkU7V+5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3390510E6DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9AddF9p6iKg6qxtXNEEp/r4/dYoELY2wn9xALG6IBiHXhffJlCSvUfBAoRMvqoiC2kswVJzfUTqqtF2RT2/Vl8UIUUUJBgwflCSm7c/JH/vl1UL3/O/n12rfzC7F5WZAC8mWc0N5iUhhzdTLj5F/JqEgC5hbkYsXu5kl4egXhrQax1LQp76kUq0ONAC9pXuJQBlmhPi2Z317hi57RT4WmQyEnwupx+pvIEwxQrsPad/COk5cTz2WJzBIVuP83m9439Q2HWGQlDWCn4jZIVJVTQSfBVrBcpn5/rb1/XwglMBJO4k7xMYjIZqisjncr5IUykRzfIiKur/BsxkuGToXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jb4z5x4Qdmc2MyBpr1NeTVbtki1jsG6nfqqMdGWM+E=;
 b=J2FWwiA5sbfabjJQkuQk/vag9WXIEV9oDxtSmnD4V1ypWwutuFQ9dc6YxGk73/OrV1QvfSjkxCg7jN9DlaUm6+GAK+vB48L89m/1aLocDZvbmfperKIpRAitE8HRCyn4WB82337xoODMXk5dt7ceEaoOW05TgVq7xMA9QqGN/TQzm29pK6d0SEkxFdXuK9flM8eMvZvATM8U7zMIJGGCsXn7b5eCSEC7zdd8ty18BipaKZa9K17r86LEAXFPtFVHK4SXSiPgBSFtg6Re4Snpop8YDrVLo8cr36yodmOVSnR+wS1KozSi2Ci9eMOELyJptLAFwvFS8TQLZR8WsynMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jb4z5x4Qdmc2MyBpr1NeTVbtki1jsG6nfqqMdGWM+E=;
 b=RHkU7V+5FF3tU3BqZuq/cdv3qzpL9uIbVpd7eTCxJB0xkgGBOcDpgluz+CX0qDNhxNy402NBlZQyGtQlUx10iidQKc7tsRbnMr+KdTl/JjyDkNmm8htT65RZ8TSFGaFdFtpdEVy7jV5qhnrzUS4DSW7fLL3FwQvvj74gc3mRVZY=
Received: from BL1PR13CA0160.namprd13.prod.outlook.com (2603:10b6:208:2bd::15)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 18:41:22 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::c2) by BL1PR13CA0160.outlook.office365.com
 (2603:10b6:208:2bd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 18:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:18 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 10/10] drm/amd/display: Promote DC to 3.2.338
Date: Wed, 11 Jun 2025 14:40:00 -0400
Message-ID: <20250611184111.517494-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8c9191-ea36-4754-dfef-08dda917901d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EwoTYjjVIc9THbgf4hgWjfYLiDT1cOUsNjRSvuuPJ6Sv6wJzBhWm4Den7mFl?=
 =?us-ascii?Q?p0uSARB4hx6aLyM8cV90wMWR9ygBVrkfTFTh8o0YUnMzwaWglTcMEpeZNwHJ?=
 =?us-ascii?Q?AEvYHgTzqazKvoEVuWct7o3kEuOA9WTTQvPNw/baDrtVhhI2OWLyZMWYGQ9N?=
 =?us-ascii?Q?rgFrklNfIvrRlp1hawOYIdmaz1Iga3bFweg0lxkpFAPkj/vYHuaoftXaSOla?=
 =?us-ascii?Q?uZfVHe413Bb68H1ciIyqr9qNFohozpaJSUlXzdwhmNZFtNN1Z/3sKvucJVgt?=
 =?us-ascii?Q?rF9b8oCjxacMVu2NyCJCpCgCX+qzacWEx6DAKEcW0m4yiyo+/DfpsQbbGqAu?=
 =?us-ascii?Q?rAQJVcZT49fStIel5y/i2lzi0vMiZCDKzONHH0aup9IhZIMA2JEBEAaH7eAQ?=
 =?us-ascii?Q?CWJjtRjcicyXDvMbT+n7VAYtftEseYL/LQwS6ssfDsXbGPKbmt659ip9sLM5?=
 =?us-ascii?Q?yZC07xS9ArpnYY5u5o/hp310KS6LR7Qy9SCok4GEaUNfrMOoWNs/XaWzk6/4?=
 =?us-ascii?Q?1qZaoGlcU5nZOHZtLhWBM/wo8hfClbgYMAi7l2U5iWb0v0gbm8u/1tywkSsV?=
 =?us-ascii?Q?bXm2FdqUafCXl4w41uMqgxGrqgHgCJz7cK+DLPET1RoON67ltAwkGlJ01qRF?=
 =?us-ascii?Q?ObIm+LDHc7vCmxSPiaY/9eKXE5WaD081VAzsxIaPFtRztFLIv3sbcce3ZFhj?=
 =?us-ascii?Q?IBu3IObslpnIIgpL2g2kP+DDC3y3PZ/a9Ie/Jgbdy4nLbC2stgCoylC06R6g?=
 =?us-ascii?Q?yTi8U2X/fzolriHjj/IQLCs0XakE3jvVx4P3+dbN4gZpbm1lKTANZ1lKyBU0?=
 =?us-ascii?Q?80ncHiOLokqWKaJhUooqa4dWfhBmihybnWhXftTd2tsoVX+mJWe0Oen1uIbj?=
 =?us-ascii?Q?bVuahLGlYDMp5emOzjsLZwVwZhyqjYTL0BcAXGd44VqJf4wqFkRyllkwwE4z?=
 =?us-ascii?Q?p2XusT0cbDAJGCp/mRM4ouAHJeITJVhqrq6zwsVen1Rt+ubYot6cKzV+O0VA?=
 =?us-ascii?Q?f2kGi9CKclfYCeQRdUTIm7Fc2myAbm0uKydcV2AlcmWhFBwaleTl4s3xlm5h?=
 =?us-ascii?Q?iyFgkwDTvnE+gm7UV35p50oLSl1rGPvpUdoKR48BbEhYM7bagCJJVsU9y4zm?=
 =?us-ascii?Q?paG3IjKIeiVTvp1aoy0rZAVIdHIRgJM0k402vMjdOI/Znrj62/BjJtQV4XSi?=
 =?us-ascii?Q?j9RJY0bKVqXFYMvVzNS35fHRRoAu1h/nJQzShZgsohv/Dk7jA2ajUfcxk3ez?=
 =?us-ascii?Q?m1G6HH3ZA/5UoIuvdhynQrD2tPHLAr1xaqhDyn/hs7XXLaZxgeOONRaIR6it?=
 =?us-ascii?Q?SeavwZNHItp0hJtiaPjgW1660BDdlCu1yLT6Enf2FhIehFdPfcwz0GilD+0q?=
 =?us-ascii?Q?qXWFCiSF8WjyR65bZFDX5Hig5SO09FcTnmUCPLCeL0afYbv8qDY3KikMOe6G?=
 =?us-ascii?Q?GUtU/gw6ksYMs9rHWOKTIE3p6S5PH9FfeZRX0nXIfzczip+vX9B1Omg66sio?=
 =?us-ascii?Q?0tO6anmHr28y3+uqGWcKxVxGiaXRGo/nMRES?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:22.3257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8c9191-ea36-4754-dfef-08dda917901d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

From: Taimur Hassan <Syed.Hassan@amd.com>

DC v3.2.338 summary:

* DML bug fixes
* Add pwait to DMCUB hang reporting
* New definitions / changes to prep for new platforms.
* Misc cleanups

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index da024b0d0eba..44aed03c37f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.337"
+#define DC_VER "3.2.338"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.49.0

