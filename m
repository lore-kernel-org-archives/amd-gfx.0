Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C6C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 16:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A0FA10EB63;
	Thu, 22 Aug 2024 16:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1zC0VlDH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E916510EB63
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 16:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atWh6eA9fwo1e5WlWc1IhqSlBdmv/1SDfY/M9IURkEmLaJaUSMB8jsYjSr3pjjJh3VOzfmz6tItd7e/RImjagWT7/6xoH/LAdEgRHPef2dhniJvFh4jQUjZfgxuOvxMWeii/tG0xEB05gDVXJXPnOchl2JZbzGaOR21KuOt/sjXBYVNq00gjj1nUm6apocBjySbEghxWELo1tQ/7o+sP0tHnJZN4iqDabGLhqDEQ3POKFkrBK5rbKvUdvE8UdiKD1E7L76vcMEBd7uTlkgBcFyq1bs7WuH8fCJEvamJsxz/fE63Fuep6Q6ehVE74gqp7d83KGC3JAkJMl9ngqdtf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TicXoaR+oY728vH/UVdp1AbyMLKYrlBHPmFwC5HWpY=;
 b=ddvg0bIWCnvPuCkvyDWVenED0A/6UP/7VNg92JDYzqQMSq+ua/x7zIEcH3XGFwsZjPUbYtds59hVLS7gKdXs3gyDiAz6pSZqtICbuo7FBiu2L/KxdhiglFt6nRgZvYOQkyrukowgjlJGIvpFTzDqF/75Jf6JF/ByP5dn2V3UybZlmP842QFiBhUZ5m7NYBNnX4JTkx/1hoLPIKw6iIkmmt03OrBxO1pW2y1YWhYjuuUBaDJONmSQNAW38+CFxd0kVQE9ZnpQ2d11cLO46SeMTePxIyHBs4evPmsy4R0vd1gVAtaQGbYEw8gklO1bdvxB0Xt5zvzljMdlazllzQHwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TicXoaR+oY728vH/UVdp1AbyMLKYrlBHPmFwC5HWpY=;
 b=1zC0VlDHkabhC+F0JVVVgg8PXFSkm+xEdYg6iDFlkaQSlD7g5vMTeL1tdtTAAvpAkYrET+yORF5u/slgVPwgyidfPVk6zCaZOk3Kpa8wHvkDCysqxIMt4A4BRGav4urmNduENFC9LrCOenEEg1qolYiGra+ibCwDFdK507hPaR4=
Received: from BY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:1d0::31)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 16:19:18 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2f) by BY5PR04CA0021.outlook.office365.com
 (2603:10b6:a03:1d0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 16:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 16:19:17 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 11:19:16 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v4 0/3] faster vblank disable
Date: Thu, 22 Aug 2024 11:58:19 -0400
Message-ID: <20240822161856.174600-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 786aa38e-4076-469b-7b27-08dcc2c62c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?knQgj0eecmcHpUD30GNuMiPBOLb2f/9Yam8I8dlvlwlC9LXAzbIukk3J27Vo?=
 =?us-ascii?Q?+YFoD1pXRnp4tSWYbFTfIX3akuWVhDhAZxDvYB2OymQi9jHjHARWV3daJD7O?=
 =?us-ascii?Q?mhH1c8gbJmU0ZAZqXnHnY2n7rufB9GFfjSZzib9xqXynJpIT40EeQhmJxnXi?=
 =?us-ascii?Q?WAKhtGCGwcRsCnqMTZHY8mBhbh0CRd9fIL9jeDEeFPpH0ti83GhOrhVldvSa?=
 =?us-ascii?Q?yhoUoam7GQjNA5o1HsSVOG8BBRQ4dwIxT9E2FuB2NJAyNTdU7JgfutxFCrWi?=
 =?us-ascii?Q?cBsJGrf6bZFdg6yd78t11h0Ew6iQH74fc14ifFSSZ26lKgNFHTnFE4LMctT8?=
 =?us-ascii?Q?a8rfRcHw0j4io311KYoCC1RJdaNujG134QuvZHBJAUeK3yXvxX5iZDwxdFca?=
 =?us-ascii?Q?nGGP9CCtGUT7moJ5EpzsxaTP0EZyHIVQzeuBa5GEaKlDY4CjEy6l9Fe1OBzk?=
 =?us-ascii?Q?L42C1zCRXP8BREOgldyjUn7+zOMqMTgTNK3vVSBeWv7kvocJJHVK/bd0Y3q4?=
 =?us-ascii?Q?ulGqZx/eZV9hQDFcipqOodbu4XKf/qDQXX/FCc/mpwmsIlGwJi9/gQY6ZsQM?=
 =?us-ascii?Q?IM2/QhJKMNQtC0IAoGTbD15BorBQVBBSesRUz0zlzGQw1AKxJLXB2Em2BPMH?=
 =?us-ascii?Q?2J2Wi8v53zEpERIcsvgVfBJJjNnAJMy1CPL5SdY1+JA/LxKC2bgbls2lv0m2?=
 =?us-ascii?Q?MrZ5UmHTk6XM2b5EFw2amofiORz3OHwEwk5hSLb3V/D3CXlZbytzr3ghReQl?=
 =?us-ascii?Q?k1smz21mmF6qavFwuwi86woeAjd5JqnAzEEehakVRkP0DKKVI2+pd/Q5DUmL?=
 =?us-ascii?Q?aspBugZiSFX8joK8wAZ4E/DVyCstvF9VjYfhazeZO6hDjbuyksvEkOCVLinG?=
 =?us-ascii?Q?2uAfnY5u5YqCGsFP/DyfPto0ESJwNHf4lRsQx8bg10uNXrJBVkc7sGQ0zcKt?=
 =?us-ascii?Q?EB4np89ZIVs7wIeol0JeWDqgMMwzDj+eotlyOQHGn+pBTbk/xbZgKjxLztVr?=
 =?us-ascii?Q?MCS8IQXAn6/d2G9+dlI0STCSlqvdLma9yIzV8Vks8iBxIKPa8Oh1K8W75MX+?=
 =?us-ascii?Q?+X24oeUEYJwRC+6TSC1bNyrEsHkscwrAz4XemfIxijXBKgusDTlyC8xBo6Z7?=
 =?us-ascii?Q?DrYcUchEZ3MYjja80YdrP9aS2OyQW287vtXltkzPWdY3hgk5omfx/9Qr9GBl?=
 =?us-ascii?Q?3xl7J5azGcFmTAs7a8gf6KKl7elrs8uFvUz0WDTNAEEyup1CNprBropeSIsL?=
 =?us-ascii?Q?tm+y9cFx60rTcaJrpzDBm6f3LJA3/49Yw9GUDJ8ok0zd+HZNzQxjO+lIOlVM?=
 =?us-ascii?Q?dxJTVwR3dYZHjs+um2Ndc0C1KG5Epvw29os16VnDS2IOQR8kLhWTPjOZIfgq?=
 =?us-ascii?Q?SLDrZc6/ASPJ3xyj8yNLKrzgJK2Fu6DFNI6WpmSGgxW0KYp9qkOYNlCti6js?=
 =?us-ascii?Q?lnKvej1d2SjkUXPzqrFBLMmqPfIz+7Ee?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:19:17.6065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786aa38e-4076-469b-7b27-08dcc2c62c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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

Since, drm_crtc_vblank_on_config() was recently introduced, we want to
apply laxer vblanking policies across the board, since:

1. It will allow us to shut down interrupts faster for better power
   savings.

2. As a payment towards tech debt, since drm_vblank_offdelay (which
   defaults to 5s) isn't necessary on AMD hardware.

Also, patches 2-3 in this series provide even laxer policies and they
are intentionally separated from patch #1. This way, if issues with them
are encountered in the wild, it should be easy to bisect the issue to
those patches.


Hamza Mahfooz (3):
  drm/amd/display: use drm_crtc_vblank_on_config()
  drm/amd/display: use a more lax vblank enable policy for DCN35+
  drm/amd/display: use a more lax vblank enable policy for older ASICs

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 +++++++++++++------
 1 file changed, 28 insertions(+), 11 deletions(-)

-- 
2.46.0

