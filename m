Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897CCC27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A902310E6E9;
	Tue, 11 Jun 2024 16:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nsUM1bSo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A4110E6D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEADdwNZowFxC667Quy5w8UyRlZy/fjVJNVTcDbUvJkrrJ8lyBll+6+EMorf403shf+Pj9xKIF0dlf2lbZtEqNnrlMePR4Wk5bryfCuwV7hlTqfJJNB7/QEK3kJo3YUGeOR0Pz+VD9E8wRh7FFEn++AAQp742vOSsusvVvb7/0LRlMSRhBZALL3x2tXZhpZGIAbpnaD4icVgwp32oGD5L5B9kgSF3KdTn7H0yefrc+xS+ZyzjlpoaAhE1u5oJi42g27VOrsqqa5vBeW2YXLRMnOdOeSP4leYMDDjd1xdFPqsEb+6WSp4crPuYLuTQ+EBE9uDkIRv9m7hRPXbd0kpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSElOZYfwZnU86la7IHENvj0mV4P7N/QpZSbmmVfsOk=;
 b=dX1JgQBGRrRwLs3AvV4i9WhI+qTWPMZZdo4zW3h9T3FgOLZ65r+NwWc+WujVuPdClRe6iLVlMGq8hUozbPYb5fu+61+EgL6FqG1tQ6vPE/yLPrnbAONA/PnEbxg0NOsCL54x4c5dlyN58A/Lb9JNag/sZus5vLqVh43TSvRl3vQGqdDwR867Qn9vwiHoC+A5PNlfav1vzX7szJv55jaVYPxJV03RWbZadVdKn7RDtmY3tXWCiLV4jt4QwfM3sZ1N15Yj0C3fBFBNSHDEdmzny3P7MxZ5fALlV+dOHJjFzRY9+4NTlxxsTL8uCgDLVPSawTrLoWkqk/jYtHWiFvDy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSElOZYfwZnU86la7IHENvj0mV4P7N/QpZSbmmVfsOk=;
 b=nsUM1bSoiFqrHl+zzmBniq8D6nZi6WDJ86d/2kQtl27aq5H6mb9k45XFPxgBgROZdsDO74XLQ0YUvDM7GlhooSjX8UEC3PLQvaG78MM7hxtOQlAkBehtUGRb/UGLb+owM2p4ihAE334SF4uD6NHM4/e8MSVNQNT9Kn0/luxPVcI=
Received: from BL1PR13CA0444.namprd13.prod.outlook.com (2603:10b6:208:2c3::29)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:56 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::e9) by BL1PR13CA0444.outlook.office365.com
 (2603:10b6:208:2c3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:55 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:53 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 36/36] drm/amd/display: 3.2.289
Date: Tue, 11 Jun 2024 12:51:39 -0400
Message-ID: <20240611165204.195093-37-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 248a619d-1907-4405-3565-08dc8a36f142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hC9jFdCeZn/LE5rrZuLQvp5umN12FJ+s2iK86gWAAj7pvky5R2pZ8YMUgLgD?=
 =?us-ascii?Q?ieHX52nDg+hFYvs+5heor0mSI9zZAOowgCOFg71W9r2NKlYd9KdXvuZM3dNg?=
 =?us-ascii?Q?DcKC0MYSvERKtI+6quibGbI9gvj/pP9pNFGFbsLtHbRLt4Ay99MLd7J0rzSL?=
 =?us-ascii?Q?18R7Wd1vCjgzrI0syGwoNZ9C+HTLD2pV4Oyq3nyO5L3VBG+Mj8DA2nDfjZfF?=
 =?us-ascii?Q?g7Ymz0oOawvjvLTPmXfD4oV+JhV7a3/mRDjPVI5mFdaL0uFGZ3qwb1qBIB3t?=
 =?us-ascii?Q?0JJL7B9WyKbV/Wex1bx4ukdAALPfPpELt+/r5RrS1WP34UT4ro+BmB+PY/2o?=
 =?us-ascii?Q?DF66il32BixXv39koOXq36+yheukQxfXxGwdjhWFMJYgBlTR+I1vbNE5WAVI?=
 =?us-ascii?Q?U+RWZca7uY56BAqObvNsaK7LIiPwfW80T62Hh5tiXKY9xNCxsk7tQ9No9CUX?=
 =?us-ascii?Q?/3IAopiYJwqGrT1UATQg3omBdowW5HtDsaRIcbuq3jlBKUhhJhW+JF3v0UFo?=
 =?us-ascii?Q?8Bfy0emSFQHnq1WqpB0Iw5Pb+452c/2Ly7ogPWTEbMMgr0yZhi6Ghu0D5Oq3?=
 =?us-ascii?Q?pNIh8MdEHFnXN+f3sApak3XnOToTq5/H22qrmyJTk1MubAejIr5zAxgDgPba?=
 =?us-ascii?Q?CPBul9olpNDTMGDyffor6RTCCMB+FwIoe2RR3DV/jj0/8v+qTetiZubFdmnj?=
 =?us-ascii?Q?if+iZ+sW+Q2vjk7gTDpSsQWMFiuqrWIzuGVim53+YPJhtIduntDl6VzrfUiE?=
 =?us-ascii?Q?SLK8hiIjvhE481Vjpt7pmIzYT00CJ4z6BmgmIHSMuTq8nsdOQrzoXzqhUW3f?=
 =?us-ascii?Q?Nj4BpPnCtEQhpfOlugLC0YIWUHDVILjc/83RKeKRgBzfC58EuayHYKblBGbP?=
 =?us-ascii?Q?t2O5m6JYzYc6XKjTwd2pHPq1MEdhoQeYd6gNgW5UKWn8BFRO6dPHFGXSU0qH?=
 =?us-ascii?Q?xPur5QAZYwTWqGT+YqV70aZiAs6lfzhVjNHyE5z+xff/UYeJv86td2yGFEko?=
 =?us-ascii?Q?sOcfFMRs7GW+le3DDrH3r/Ev11PrGSvIZWUMLZS4i8O8GOr3ra4pBLW5k/es?=
 =?us-ascii?Q?MbKov31TFJCVwHLYVs31VMbwDNWGBg98nvd068oquinpqmDNLXytSHdWzm4Q?=
 =?us-ascii?Q?WyLQof6wMo20RPaBiUse8tPsgasgKO+t5ZG+W9WpC4YOfwQ19yRZRFk8Fb9W?=
 =?us-ascii?Q?EVX19p5lzmhhTR2NQGKdtSx7ETCUiGfXi08PCbGS4bUH5rKLwrvzpodGCCZH?=
 =?us-ascii?Q?IXpQgJNjWrkl7xKwK+ZGywDT/lJ2+PtCnfcyDrW8oAkXMvCAVk+uzf82ta71?=
 =?us-ascii?Q?Ak70TT6xRnmW00W+iGILyAtoPS8iEJY0y/eaDAw4JYgCS43NYFe2SvQnXyZK?=
 =?us-ascii?Q?XuV1i4yOGahcKErjseyocGF088p89lyzSItQrvaAlUfcF7EQKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:55.9657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248a619d-1907-4405-3565-08dc8a36f142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- DCN401 fixes
- DPIA fixes
- DML21 fixes
- Misc Coverity fixes

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fa4e6b09409e..d0d1af451b64 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.288"
+#define DC_VER "3.2.289"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.45.1

