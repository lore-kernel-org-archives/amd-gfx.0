Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912D4E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4505110F07A;
	Fri, 13 Dec 2024 15:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEY33og8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7727B10F077
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTiskIbap+zt1daSlwl32ZRf0LTaG34wR780gQAxrhLeR/F4i+s6XAdZUvXhk2lvIoDH6+jgTCczNjTlNnfulP6CVNX9IKq3olE2dSBwXhcrRpzkl5KhfmN75rEnEUYLIzTaJ5zNmZfRQtKY8yNSOTu8T44ufOJ3gQnrB83SA5/x+4vSo/pnJdpxtv9z2Y6eSt9J0uC7yA/W3PBvIDFlWZemVUeZ7bzD2U4nxeul1VXz9D1JS5HGNItwXgBsBYDO9c8/KbKOs4vnbjWF9seXJQXvlpaolbSlWGXHuXldp8oCcEnP0yqhEMwalFWHiiHnbBikgMcw4qFRVIdY/0ZxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOlxdUylPeA7w2U8J3FcEM9adbwOtMFbtT8wvXCh5/w=;
 b=YjvWC1R0q5J7deEr/TfolCNikWr/oTx05s2O3IMAF3+thkGFWS8F4tMazYAKu4a5JRLTmxBj07YA0RBB29zjzN2M9O6jDCpxlN1AQvAswTpADu/kiXoWqhtoJwagBMMIWqi492UtFdIlxurSU7oj4Ejd98/TjBo5QbzYPRzrrvOYupgryA1BXuWuGEetLDrvbLAilXjuYrw8fzRGHmFDLNMavDl6qnv9EehDDDN0RMm1k4qa3gI3tHSVx0Uhk1kg6O28hJ5tvwkw8ehwHvV8lVNLsd6wFSZqrgqSp4vSZ3lA2h4LIFNZnXlKu7ORsf4+Mjv3m2UCf7HdKUYnNyDhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOlxdUylPeA7w2U8J3FcEM9adbwOtMFbtT8wvXCh5/w=;
 b=kEY33og8n7fX2iHWFkg1GLtFmGVamlyxEFAp0Go7ygQt2h5LnbCtQZBftbJ32+i4uz4XHDQIfDhqU9+giNoTWvShzc4s8cU7L7hDEOLoHBe2/zVMZ7yOr/25V/Ritj4zVekFwixO4GgSRDn3rPhcLcCvYLSS897vtRnKvxnpKio=
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:55:07 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5a) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Fri,
 13 Dec 2024 15:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:55:02 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 11/17] drm/amd/display: Fix uninitialized variables in
 amdgpu_dm_debugfs
Date: Fri, 13 Dec 2024 08:52:43 -0700
Message-ID: <20241213155405.393252-12-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f99559-ffae-4e12-c5a4-08dd1b8e8351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W2JYALJ/uYHdMFtbG2rZ6pV0Yy6n4EqpAIMnN52RIMewg900G8fHo6UXdfQo?=
 =?us-ascii?Q?zxLN3FpK2sDYmMITdE/HDI9j9ebkJz04rhih2mvlsVhjuSD0yJnCWorXvZRK?=
 =?us-ascii?Q?Aj1CAoa/J0JeqoW6OqHKTDzqKS0DQ1RaK2/8Blz89phHahPlwNfYFKmbR2tl?=
 =?us-ascii?Q?34OfHiu21uJK4oXQO7MOem+xDWf46wNwOf9c7g1YdB04h4Xhky0ihES7i1Si?=
 =?us-ascii?Q?+PKcv/nQKrZZmzb6LtTacVxgOaXpsqF2dF/xYKYFsoRpVohN3py0i/T9HjdF?=
 =?us-ascii?Q?OiqL+YEkawhkgr5vy66tPlB25RD9iyOK3mJU34TykvsfjWVwaKoFfFasc3kg?=
 =?us-ascii?Q?MzSdGUum3CzwMaHhuxHj6vzzgOOkLIX+d//KvnKEwlGLKMFZkEcgd0U7f76x?=
 =?us-ascii?Q?96MS524AqOPc9FrtmF/pdNvpP1LxK7qQNY1S695VrWYJC6MpAx6yMBvqqVBt?=
 =?us-ascii?Q?aXbcjSV9FLqNEBK6Ri2ZqExP8ydt3U8zh+5op2ARuBrNq2UWRSaDqLAYs4HC?=
 =?us-ascii?Q?kvvnA6ZS2ouuw3XfGchQr5qrVjGsjdJr8t1fSs+qa20Y7su3UCF4eTJotc1X?=
 =?us-ascii?Q?wzJJ1yJArFVvqXo6gmi2A0pu0Te8F9C8MygswSlFkfb8J18+Uweb6WyjZ+Nt?=
 =?us-ascii?Q?SbmCA61hTxsHRV/aT9nSfTK2b1gWf4ZNWHA+KkaaNqDw6csDAK49ywKdEMG6?=
 =?us-ascii?Q?cC/VlBUp0FPQitLPYKnmEZIQku15L6g0sT7x4OdA8JXznG3fGEGOD+/QO0jn?=
 =?us-ascii?Q?VvH/gjLjrpo1nyCjSrCxPJpMNBxN319YMz1+cueEJZvCgp95nbnuL8pR10Al?=
 =?us-ascii?Q?rGJYN94kFN3qb9L0z+2mFP6FYRnBzwAAZgBkVaVZxQX6NUl6ZDUtOOFI6YNJ?=
 =?us-ascii?Q?02r8321XHDDD+3sfae5QOOJ/buDUx7W6h+jWJtnGTI3wMFXbfDfmle8km/Sz?=
 =?us-ascii?Q?Bs6PABWg7Ehs8f4B5ojbFlqU+NTWcnmDL0+lC42W52Lj0JLu7ndhnGrFknRz?=
 =?us-ascii?Q?llBLECUsin1OO2aELgl/1v50djtLGTbZ5tyztROZOOGLjOC7I5xa0BLZTD8R?=
 =?us-ascii?Q?sh3uDCtkKyEskMR6yM7RQELG+rFleBaFZd4piBUgcBulS2f8rpztJASKQ6bd?=
 =?us-ascii?Q?qE9kQiDxg4krYBmvg+s0qiOlznXd2D19yGMmTPggw88mNhE6UfVhH3kU3Ndi?=
 =?us-ascii?Q?E9tvIKmiAT7s+KPqYxp2oY+rwk1CfsN2xJSvOnmDqx/8zZ7x6HTtgowj6Qsp?=
 =?us-ascii?Q?dFJMHy0ckT1lrYyCFqQQNV03Hd6ypwE+B46sJSMlVVOSN8h/W+LNTb16SxWq?=
 =?us-ascii?Q?dtcRaKgmjXZLjKsXdaFFzo4jcTbjkxvY/jFvNNoZ+UYgkAgfOuZtFqOPtnbi?=
 =?us-ascii?Q?4Q+zx1WRLXqFCdxIBb6B8br7NzkTzIFkR9ky4Mq6jRlb+GM2cxaSYdjPofJP?=
 =?us-ascii?Q?Mg12I2fjF7TyENo0p4vY2OoR2BJkk8mV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:05.8333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f99559-ffae-4e12-c5a4-08dd1b8e8351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Some fields in struct dc_link_settings and link_training_settings are
not initialized and using them can cause unexpected results.

[HOW]
Initialize struct dc_link_settings and link_training_settings to zero.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 11a7ac54f91c..2a3c4ac065de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -258,7 +258,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	struct dc_link *link = connector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
 	struct dc *dc = (struct dc *)link->dc;
-	struct dc_link_settings prefer_link_settings;
+	struct dc_link_settings prefer_link_settings = {0};
 	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
@@ -389,7 +389,7 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	struct dc_link *link = aconnector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
 	struct dc *dc = (struct dc *)link->dc;
-	struct dc_link_settings prefer_link_settings;
+	struct dc_link_settings prefer_link_settings = {0};
 	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
@@ -613,7 +613,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	uint32_t wr_buf_size = 40;
 	long param[3];
 	bool use_prefer_link_setting;
-	struct link_training_settings link_lane_settings;
+	struct link_training_settings link_lane_settings = {0};
 	int max_param_num = 3;
 	uint8_t param_nums = 0;
 	int r = 0;
@@ -768,7 +768,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 			LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
 	struct dc_link_settings cur_link_settings = {LANE_COUNT_UNKNOWN,
 			LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
-	struct link_training_settings link_training_settings;
+	struct link_training_settings link_training_settings = {0};
 	int i;
 
 	if (size == 0)
-- 
2.45.2

