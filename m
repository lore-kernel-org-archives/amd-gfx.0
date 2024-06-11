Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A57C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11A510E6D9;
	Tue, 11 Jun 2024 16:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UjedP1qN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E33E10E6D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWHOXR918lpDxeoBcZf9rbxMx02NgnrHHBjCPGKugNM8sCFyd4fd8e5mYnhw8hrOKTyIUuaD4E7XsL9ztl60bn41+81Qh+yqGlXMOs28IYzM+psrHjYznNqhvsENk8tBGzuecyzwI5rw2Jkvaoz4bI9wkX898kmmYSyDOA++Kks8XbWscAdj0s6jtLZiRp81PJWdEumJI6rz6d9Z58UQPgM0iKSR/Sy9eWAaoj35bHK3Sc6CinV3ehvJmeKRtsaAJwsn4u755J4Qi4TFhNDZiNZhAQs28bxkDNEpVcyAAAir9Wz0zpLiGrFDnbqdeaZ7GSKrrLi2aoUl/oKPn9iUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+Lv+WAx1rKTLuQfdJzEA7ODbuTgX74nb1hNxdoWqCE=;
 b=Bw4mLm2RBvevxM+9ToCBMkMpSBhoM9ENNZmcoM4lMnAayhu6BlTPzguoY4jUvJ/8bQHiesSprU0IQCQB6f7Gncm9Xyl4HXUox0NwGH3elg6kjziIp61tvBxOV6+/MrVt0J1R5gmZAowXkyaKLaYnwOuNwGhuGGHmN6j5HhdtzvMgyLDW0oKI6xIsn2Agj4Ttz0culGhSKBFf6lUrHLbRMpeV93Dh0hpy5m6izi/S2lvsl47f8Hc03/KCmDz4cd9AoISBj9rw3PGMLNP9xYxnvb7dmeOZclO8qbDYfcvmjAbXtMkPoP96c8jpLmlEGQZBKlGuBEyjORFKInqbvi37Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+Lv+WAx1rKTLuQfdJzEA7ODbuTgX74nb1hNxdoWqCE=;
 b=UjedP1qNcyCa1qCwldbuN6nu92tpIkzZERV30QZ6eZ3q5S8HfEoch2jTc/Esj8ke5q3E84QiOIqX1HVx17nUZi5t9aOQ1IRBwb/obibrDGlBdBr5WiuXxJzbaK63EVlCYzu9Cqzm3sRdOjh+JFZJ8PbZEn34Uu2RbjlKRHAy7FU=
Received: from BN8PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:ac::37)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:37 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::be) by BN8PR07CA0024.outlook.office365.com
 (2603:10b6:408:ac::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:33 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 16/36] drm/amd/display: Skip wbscl_set_scaler_filter if filter
 is null
Date: Tue, 11 Jun 2024 12:51:19 -0400
Message-ID: <20240611165204.195093-17-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 977f2cb3-a5d7-4984-6bf6-08dc8a36e513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PZO8Vggs0/oW5b5doUFqhB4vRODb39qp+0o970sNv8SSSyFFqJJlA1VBtdzD?=
 =?us-ascii?Q?fk7hZhm584rjwSXXWEDMdmTX8FSVP4jNu47LQ26FEOW6MKsvu9hsKlTZQJPq?=
 =?us-ascii?Q?aEXmIIhJADclAAxKEnlrbBcPCuLlV2egFOWdDViaMhd2I5DFHpyjiv+D2LEu?=
 =?us-ascii?Q?HHD7q4mwhIIup3UCjPvTtG1Be+JPdCIo2S30ScXi5lBxHuPYLoRHXjwh5OVA?=
 =?us-ascii?Q?DZklk1cuE37+QBJOgW1QHWSsq5/VFE3Kv4uf6drRa1m7aYWRmacTWop73En2?=
 =?us-ascii?Q?xfnbodDHFnc1L/+lWPqgR7uGZXoyoRvPctfG4Ylm2ArL9Ns5oKdiEZo7KJKx?=
 =?us-ascii?Q?0IEpyV5kLNkJWCQWbn4xibx7e4yWtkDJ4if/5XNbRRps1DgcEhgdCb7sWkWg?=
 =?us-ascii?Q?ghcTx9DmYfI3+nz5Xrd/q8/lFUzhhdvr68dD8xEoMlZWUYehlcHYrt9QXfXB?=
 =?us-ascii?Q?JI7ctU71ytUkqE3FdrvrLtvuIbUwr341j4fMqzYkmXSiPme0in3ez/pHM43z?=
 =?us-ascii?Q?85fbdASUXSI80SkxG5Y6IVlzmAZzwOE7mnpBsRFTDqUuBzlr4WAA4c7GQ3rB?=
 =?us-ascii?Q?L32AoJ/bJl0NP2DL88h9Lzm7Cc7ZRu0GbZeCBKdyFQw2s/lxa+/Nc9kJ7jMY?=
 =?us-ascii?Q?3OTfAI5H4Pu7SUjN015+GbZJhQPWV++ECFMpz0b72yp5ZoRWmnoh2iEM5s3D?=
 =?us-ascii?Q?0e0nBsJcFWUKIen7IZ8Qw/xmuwM0e8mGgzt3/xaSAqV/xYnW5pis69ZSeV2G?=
 =?us-ascii?Q?qZHG2YbyI41XIQ3hg2VjHwPkCTgSF0jVaIC4lgChnyDJlbu4w/NQ9pm+/vPc?=
 =?us-ascii?Q?gse2plmyv6fPvkhPpF0dn85tVkBkneaOCiJwFmi5ZGBVr4M9ehyI0EHvnTbB?=
 =?us-ascii?Q?wa4rR5l7Ayw5Q9cqFbu8vSmnG2osUzIfmiPjVVZpm+O9FJ9Vc29enflIqPrS?=
 =?us-ascii?Q?wk/ymH8z9fkPv/QxLvbP4tTC26h/B/uSOD6JdLtkT5ei56GOSNna2yeKuZS1?=
 =?us-ascii?Q?uVj3udQKHvOBTCr2BX6Tg7e0nnhkH9e1AcS84riLuzVieYb7aWY2Z43tE+rq?=
 =?us-ascii?Q?zrMF+VPD37tLIHJ3eiEIiNX1E/yVL6xjbwyNwaFS75XYmALaY+9kQX1L7cKz?=
 =?us-ascii?Q?4hhWJ7PTd0fkc+Mc/DbTtqLIV8XNrIDvnex++CmiAg+hun2bB/8UpXC8PGGl?=
 =?us-ascii?Q?1hsFK610gaeq7GhXFgd+qGntCcxlLfpWJZuS8XIAcihwC1USKFlKS4oOa2Cu?=
 =?us-ascii?Q?GBEKGcI4dE/YwgQJalRSsB3C1XaYh9yVdXdvTPQN6Tx3Wq7BHJd7aRiqVJH/?=
 =?us-ascii?Q?XqS47CfsF8O3lkMIW3v8y6ayuVnN8DJot2qMOYXhbXXv1CeaCBVOuzIeAEIV?=
 =?us-ascii?Q?om70CPAdXNAT4iz1vgyOPjsg5uw6Uc7vEPnSa1B/agTk//NC8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:35.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f2cb3-a5d7-4984-6bf6-08dc8a36e513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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

Callers can pass null in filter (i.e. from returned from the function
wbscl_get_filter_coeffs_16p) and a null check is added to ensure that is
not the case.

This fixes 4 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index 994fb732a7cb..a0d437f0ce2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -690,6 +690,9 @@ static void wbscl_set_scaler_filter(
 	int pair;
 	uint16_t odd_coef, even_coef;
 
+	if (!filter)
+		return;
+
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
-- 
2.45.1

