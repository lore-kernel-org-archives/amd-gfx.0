Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CB1C52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694C610E53C;
	Thu, 15 Aug 2024 22:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K5KvE2AF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D540910E53E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGpkWlVK/PsFUN3kjdduVi2i0O3iFFrZZS9otI3azWN/A5KMPfOKqGlDl039D2mC+CKE5hwjS60TXEvRbcsY8MiTmxz0LTOAiMc0Ny212+yaBKdk9cv/HXR2RGlBF+JYIKQdthovQGcKgZEh+ZG8Xi9aLfA68R8ED6VJy0eKTQNB8cXxptmKFsGErEaPrD0k4NebafRp8WINDk6HB4/QpSZ+8XywPk28AaPJLOV+RylSoNasYVlb/UIo7WZ+wyjd5BrMq1iba+Kk+7c6yksoWatvPrdhPTnQONEC9Q6aG3uBaHSiAv8YNJIQEfCQhxaYB8CBezn2BXglxZO47fjG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MbcWLrmcTrsYC8WOQP536XV8FPdPZIhQrrp6YbwmFs=;
 b=o+lwS7zg7z9TGyMKVpTe0F0HphZM72RpNGC0eTkYaCkrwe5bW1MiS7htQShfVMUhnYBRpO26Ja7lyLEFZe3z18dJzuwD+8spwiuG6CjdmLrTwbiJk2oFytYZ3oSvv8pp7ef5X5jYAFbe6rK22L3MHRgrE/hB3hatVa+Uvh9mZxDhWED7ORC1lUbN0l5w1pFcLO1+K0PTwK2y6xg7P5yUzjsQUIwVsGIb02N80090UatGR2EarDHk/hNLDvYndGov5jZF/iWI8vcgoDL70i9pt5QbSC7KDnE+R3v9dx1ZhDW4XqX2MTW1l/U9x3Rler4Uel5HfhHVqnZLUsm9i1sBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MbcWLrmcTrsYC8WOQP536XV8FPdPZIhQrrp6YbwmFs=;
 b=K5KvE2AFp3Ja4acDG73pga3ySOOFnX6Ukegn+ECuIdBSy7ke86P+24l1icwGOS7RdXPg5EPLbimX1YQ8lpkMN/z4R/pGIzjm20qbGNa5ebN1qeeEcmQpRZB1j0yfaG7Yw4TducgnzOyW1mDUEZnOCXNSqC5PiS5RlS18xnNFXfU=
Received: from BL1PR13CA0195.namprd13.prod.outlook.com (2603:10b6:208:2be::20)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 22:45:34 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::74) by BL1PR13CA0195.outlook.office365.com
 (2603:10b6:208:2be::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:33 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:33 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <Hansen.Dsouza@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 01/13] Revert "drm/amd/display: Update to using new dccg
 callbacks"
Date: Thu, 15 Aug 2024 18:45:13 -0400
Message-ID: <20240815224525.3077505-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: e980ef2b-3932-4815-80e9-08dcbd7bf950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A3IycLUmGcsMiymWBidcyIyShQQjzGk2JpHq9p+CLsz49byvDwJ5gdpv+7J+?=
 =?us-ascii?Q?DU9ZghD6urlSRevGovk99e7h/BJO4z6SWpnDwnmEJJRLVxBkZT2LBvV6OzDN?=
 =?us-ascii?Q?2bg3RZgIxs4PeW9L019Hwu25LNcDyhQmz00aL6uqRd0rip3Ahng9QVkGLZxi?=
 =?us-ascii?Q?ioTA5kmDwP1NT4syLAUMBkBhRytCmxf2TDQKBJJDgI9rJI7WTmATFKP+56rg?=
 =?us-ascii?Q?nWG/wg4bPQLZ3dL7EQtG0iiYpZwmWhHQSYxGFthmM0+pbURtj6oJMDp4fpk0?=
 =?us-ascii?Q?qRLL9JEtdQl8dWmWjjfNvoKhoVf4mQBpbMKjYcuK51bqOlWmOewEgy/KQIb/?=
 =?us-ascii?Q?VdPIM78bXCx+pJzLLZMxDQD3bw5U46LjTk8QnYqg14FeWLghoQ2gIy+PoaEp?=
 =?us-ascii?Q?2cqFdrExYFgisuCO0NJa55pBqobdapOCfXUptSTKKzvcsi/722aifMSX7mVZ?=
 =?us-ascii?Q?NSvBrmKZD1pvZHrKU7lXz9pOjPhh2Lyw3pvGzmdsFBZtwtkg0SMEKB37aqlY?=
 =?us-ascii?Q?P51wkV/uTD9IjTkGFdixOkzujapenCTXKY6dgTeqxaSyTyBppz7YW60hw7t9?=
 =?us-ascii?Q?BQLXWhMxvcDdDQpQxKLdA3F8qhCFUq/xvnkLmwuwxhAVKBHSsIyl6+TRk8jl?=
 =?us-ascii?Q?kIKpefuxhnc6RAs3BtEEskXkHVYBsVADYvwLzXIAsSOqV6j0t7m6+1WhhzG8?=
 =?us-ascii?Q?BBj9cKQi1s01un2SGKTNQaD9k0k1zi4KFaJyVn2STBBykcGk17KF7yJd33e7?=
 =?us-ascii?Q?LeWvlMXEVIVW8dgWi1sxy1y9ebGDdP26iDJbzPlRTw4Z/rQbRKCl5AWQ/90H?=
 =?us-ascii?Q?VV/ol6R00xMMOgHtvVgt/7sd5AuwzhUJchTNuXhiodQifeZ0r8z+6EgQIyF1?=
 =?us-ascii?Q?d5nFBA1vLnePild4FVC3MJ6C0HnFWXcxuA8dT4yhXmejzVWgDLCqsDKRdOVg?=
 =?us-ascii?Q?MU8Opg5AvfSp9cD/+tcNsP/rjexckScyBQAbACE+WI6gnGxJQRzzPu50YfgA?=
 =?us-ascii?Q?VlFuDVPPduBxdfTPD333FnmMoGC2iPwRIZ+gwittHOLUP9waVeWhq/cG+7Bf?=
 =?us-ascii?Q?t8SytfDxkE7MTm/jHaOXtbeGWGmV3ay+s5gPlToblfseWJLGY/KlSj6sbFEZ?=
 =?us-ascii?Q?6YWH7D7BWUu+dOwEArDgrAJE9FAHRpE0j3uGzlO5d/p0Y8h2Q6wRSs7neFHy?=
 =?us-ascii?Q?okyCRkUUw+7nG49m6ZNPn5V+c4cvsoShlXVuxBBCR7ZOjgb8wjsrtHvmVDil?=
 =?us-ascii?Q?BkM6WR6Tvwnq1rAYPvwnyN6NeLF8tSxPNhEz8ieGxsgFM94y2z08UB/n5bGA?=
 =?us-ascii?Q?CptInqXlVpVnpWITjzkthHyuM0b0iJomkhHbv+/oC4jPqmDaY7uhVddQ/j0D?=
 =?us-ascii?Q?f4/PLieuQ4Vb3/+gGQBPONGwTxX7qoC+IX+buteO0lyvIc4lXe/x3hmAJQgj?=
 =?us-ascii?Q?L6ycsOFB7rjvcti+9ow7pwwCaq+JbFBf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:34.0572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e980ef2b-3932-4815-80e9-08dcbd7bf950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[Why]
Revert updated DCCG wrappers due to regression

[How]
This reverts commit 28b190df7a8f43b39e13886d744742a74a2c162d.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 004c4fe3ddfc..7f91e48902e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -2396,11 +2396,11 @@ struct dccg *dccg35_create(
 	(void)&dccg35_disable_symclk_be_new;
 	(void)&dccg35_set_symclk32_le_root_clock_gating;
 	(void)&dccg35_set_smclk32_se_rcg;
-	(void)&dccg35_funcs;
+	(void)&dccg35_funcs_new;
 
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
-	base->funcs = &dccg35_funcs_new;
+	base->funcs = &dccg35_funcs;
 
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
-- 
2.34.1

