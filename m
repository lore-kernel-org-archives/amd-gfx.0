Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB79C27C78
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AAC10E6E4;
	Tue, 11 Jun 2024 16:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSR6oMJQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3606810E6D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4Lf6ssgmKPJspmU9V+X4TsQ3vHpnT4Jqu+EZ8pldauAQ6h5zoplI8Zx4uhkuoqcSmPZv21O6wTF9Ysmodcpq9VOPP+au8zYWOvwVj44g3Mlx30Nultq5fA62LAMTKwYqM6kg7M/cKmc2eiPl1SbSejlvwMDkMD/rEgYLvUGDUftjAhBTlfJRUbjP/j9imJH0ZTlnjQZCkzcxniFmsyWPARR1yA3zynW5Ex3WVF9NU7keVEWv5NskzyiAxa5/XcmM6A2jgCUhNf4IJFLs5+9MyUcnxse0dTogvnIS28kSAdOkWXoIYYmcVD4udDmU6IyxQtLGsQxpe3TmF5mr4HXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQekyC1a+bQW0wqXd5y8NCo4WLlIxpTUmR67BxnbceI=;
 b=R/kZMo5dyM+ijN16kfcsRjbmS2m3C5s7bKxgz5ccw/P1iTKMwwToO7TixlrnOZqbUEOSuKsCIDCK4OqVCm8F4lLQSnhulRVqJulRsdRqWSiphdMR/HNxuKooedWaSF6WWWqy6IFJM6BF9kfe1j77Su45+fSTTfBmEqlVWN+XDvYkMCAnT43iMGcvlNt+vaX8dooSTKXjPhbacYyLnxufqtqbKIou0ywzBTS7lcSbR/0SBwCUXbBnE6EN4tOvfBL0GkqZI3nBCV5mPhIhXnyap2UbfOX4VrSVRVKx6/TcukPd4bOiUIvAokN2kL2Utk7cufHPHwIIoQafc5Mkl/XC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQekyC1a+bQW0wqXd5y8NCo4WLlIxpTUmR67BxnbceI=;
 b=QSR6oMJQ4nqU0REIurTV7sDd6SPhw373GHrfjV/SxUCIa8B+xoL/VJZmxPW/iXjA/utPO3OzBVSernlV56/0UuYMEA4+0vQoEyObfuRYtn+Zm5AAPPo0mCOj4wIx6sDGz00pBNC1J+kwb46Ibi1+3OWtiL+9o1GRnKzXw7c3mng=
Received: from BN8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:408:ac::33)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:48 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::c7) by BN8PR07CA0020.outlook.office365.com
 (2603:10b6:408:ac::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:46 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Ivan Lipski <ivlipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 29/36] drm/amd/display: Remove unused value set from
 'min_hratio_fact' in dml
Date: Tue, 11 Jun 2024 12:51:32 -0400
Message-ID: <20240611165204.195093-30-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: a9953662-9ae7-4736-4af0-08dc8a36ecaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?39vHZqrm4bXcL2Gu4/PPiQUS2KtX9Msa1u6MdSyZCCVRGEWpPDSxnQqazepj?=
 =?us-ascii?Q?roP545P1kLDvpUhhJ30BYoux6gt8F+XE6K47/9X7e+nbcg3BgTFQVdsFnEN1?=
 =?us-ascii?Q?yk5XWq1QTl8TWvXJ9+HzrXpHOvyY4dyCBSSl98p+aHVn+APV2PEBAKRRnZRt?=
 =?us-ascii?Q?/eH/JzdxAOPEniuyAvcNa6Y3zAfC9zIqURuKFOaJzSnQWAKabz26iElhXZ/h?=
 =?us-ascii?Q?6Qnv/M9sO/e+yPdAvK3AliLr060fynsvKvBjjJ4qoJ4xPjEMoPrmslAoQUUb?=
 =?us-ascii?Q?2Rq8V9WC3BEmRZrPmuwCFgdJlW2NYocBh3l6izge2kKRUxWAkB/XU3ePWfSK?=
 =?us-ascii?Q?R91QDUkaTBOdQD5125v2jX9tivqv+rdajgLO0+UpO4lqMDw89BlPVSgua30k?=
 =?us-ascii?Q?kxc9aeHwzhUMv1ww5BEiBETgF34gNX11Srk5EngngSYRttqADTTqNDoEJflw?=
 =?us-ascii?Q?mwPHQ2Ku58wA9Z3g8ZwEurx4w2Cji8sYoEu/+h6MYxWi/hxvWBGiZtzdVbaE?=
 =?us-ascii?Q?ZvlTGA3ops6ouN11cjMgnL8BmBqNy/UT0nJc/UtGNqEkJYyDKsSO4KOZwxRw?=
 =?us-ascii?Q?lgA1DlAZVyBZrevRWkGuUaS/kkLm2mT5P3W82PNYo6GnUD42/qq/CetzaNhh?=
 =?us-ascii?Q?snAvCTG8RIo6mU9Mp4u2EYjAVL/J86utqDDF120gHVWL3fZp51+QIWilnO78?=
 =?us-ascii?Q?S3oocsOuLMe9dZaomtxYEek6aVQ9Om4ctT5vRQHuVK6zCVRMwGRO+iciq4es?=
 =?us-ascii?Q?kVyJCW56Mx64RlheK0s5KmI4Sfsuct3uD+kAXC2A6pGx2dcIMdUNXGAq6qzw?=
 =?us-ascii?Q?4dvukwzcdEsY+IBp3oNxGegi3cVONJjwOksaoYeMct04rLRM/iE16eMC5M10?=
 =?us-ascii?Q?QMHbfnTLGl9AZD1wRv0Smb3QEkNGjA8vlU8A6PDsSdy8FQAmXPnz3EP4kV7w?=
 =?us-ascii?Q?4NVFA6OnO8QrvHv2nS5c/WElesM1p+T04CglAz+ccBFr2WFfwlividE+bDXn?=
 =?us-ascii?Q?pc1kdxKnBegInXgTgI7gI2Vi3fl+4Gfnp/QW0EvdjXXEv7cJx3VwjkVIRf9V?=
 =?us-ascii?Q?Gb/GsTJ5altHg8RGeA6KSWGbq903DVSgGe/Ko0HwaPBbtFBw6X1JpSP5jiw7?=
 =?us-ascii?Q?60tdoA9JxBjWy3e3E+4gc/f8/XfRdYHXrau0/cDcijA9pm2B0zAb4MB/1FKC?=
 =?us-ascii?Q?nvEFLP+bZYkdYSf65mtq9Tt5KetKmFwEbfca+QnqTm3yX8xcNaD2ToVLXL2I?=
 =?us-ascii?Q?Ue1zAFRDptTP4qTNOBdawFv/xujWaaoG1PLU6ouHGSnMo8t3PiGa//SmXeSD?=
 =?us-ascii?Q?W7FxTh9ZRYg9aGd9HCyveqi8/zFmvIzbm8vOpNwv36gm0XVvBzgk+ir4WJ+N?=
 =?us-ascii?Q?gmQUp2dcdYQAhChFqUi0CkyljYgD0DS6Im5nXHdBh8sdVI72hQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:48.1202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9953662-9ae7-4736-4af0-08dc8a36ecaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
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

From: Ivan Lipski <ivlipski@amd.com>

These portions of code are flagged as 'UNUSED_VALUE' by the
Coverity analysis since the assigned values of these vars
are never used in the code.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c    | 5 -----
 .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c  | 5 -----
 .../drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c    | 5 -----
 .../drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c    | 5 -----
 .../drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c    | 5 -----
 .../drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c  | 5 -----
 .../gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c    | 5 -----
 7 files changed, 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 548cdef8a8ad..07146569e335 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -1156,11 +1156,6 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 		swath_width_pixels_ub_c = swath_width_ub_c * 1;
 	}
 
-	hscale_pixel_rate_l = 0.;
-	hscale_pixel_rate_c = 0.;
-	min_hratio_fact_l = 1.0;
-	min_hratio_fact_c = 1.0;
-
 	if (htaps_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 0fc9f3e3ffae..f4bba1f2aeb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -1157,11 +1157,6 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 		swath_width_pixels_ub_c = swath_width_ub_c * 1;
 	}
 
-	hscale_pixel_rate_l = 0.;
-	hscale_pixel_rate_c = 0.;
-	min_hratio_fact_l = 1.0;
-	min_hratio_fact_c = 1.0;
-
 	if (htaps_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 708e1632170d..c229a9edf82a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -1205,11 +1205,6 @@ static void dml_rq_dlg_get_dlg_params(
 		swath_width_pixels_ub_c = swath_width_ub_c * 1;
 	}
 
-	hscale_pixel_rate_l = 0.;
-	hscale_pixel_rate_c = 0.;
-	min_hratio_fact_l = 1.0;
-	min_hratio_fact_c = 1.0;
-
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 0497a5d74a62..f3ee7baac786 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -1309,11 +1309,6 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 		swath_width_pixels_ub_c = swath_width_ub_c * 1;
 	}
 
-	hscale_pixel_rate_l = 0.;
-	hscale_pixel_rate_c = 0.;
-	min_hratio_fact_l = 1.0;
-	min_hratio_fact_c = 1.0;
-
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 4113ce79c4af..b6d954d9aa00 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -1150,11 +1150,6 @@ static void dml_rq_dlg_get_dlg_params(
 		swath_width_pixels_ub_c = swath_width_ub_c * 1;
 	}
 
-	hscale_pixel_rate_l = 0.;
-	hscale_pixel_rate_c = 0.;
-	min_hratio_fact_l = 1.0;
-	min_hratio_fact_c = 1.0;
-
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index b3e8dc08030c..94975b0fa398 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -1238,11 +1238,6 @@ static void dml_rq_dlg_get_dlg_params(
 		swath_width_pixels_ub_c = swath_width_ub_c * 1;
 	}
 
-	hscale_pixel_rate_l = 0.;
-	hscale_pixel_rate_c = 0.;
-	min_hratio_fact_l = 1.0;
-	min_hratio_fact_c = 1.0;
-
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 3df559c591f8..dae13f202220 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -1596,11 +1596,6 @@ void dml1_rq_dlg_get_dlg_params(
 		swath_width_pixels_ub_c = swath_width_ub_c * 1;
 	}
 
-	hscale_pixel_rate_l = 0.;
-	hscale_pixel_rate_c = 0.;
-	min_hratio_fact_l = 1.0;
-	min_hratio_fact_c = 1.0;
-
 	if (htaps_l <= 1)
 		min_hratio_fact_l = 2.0;
 	else if (htaps_l <= 6) {
-- 
2.45.1

