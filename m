Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B333C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F336C10E8BF;
	Wed, 10 Jul 2024 19:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3xfS5P8M";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A1610E8BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrbsq7uGRqkjGURjh9uY896RYkJUTVfBBDzj5aXwzperSah0bZ9dDOint4P2xB69bndmMqBbdOI4e5ea82vH9LJPEIUn8kgLEDYa+hiZKYRe2OuLsEGpl2FKqV2ympiLDe9gkTQJKVEz/cdmzown+hY2G7ZjQJPjYFt4wOy+qTtN6z/dlOImQ2RV0BKEstIJVrtZYJu4oerhgR1E8QN2JN0ulczpCimqAkxfRn8OcxbowyOIZHoxfj6U9Pehwog1MGOGKtlPsl8eqzyas/dnTKayLL2SLHMT/KOobaflmzIjcFMjlQKY6IOu5A24aJw22a0TbTsq3QxKhDtce5jl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfPkrGt4uV8HCy6D4LkJdpRm8hvm82lonrNfqOdYBCE=;
 b=UD7G4Q0/p7L17+DxCpW7H4XVUQFaYdEZ+7zB3C7tchJhKCs7O29gV4G1plZXfxremYYhKs1wkbM01yR8jesb1Gf7B5qAibLxJ5zRNfIqnpmIQTN84BhwKiD+v8KcFou5FF8ZpxvGFLfFP9sG42PhlOHtWMB1G/o+8yZKXExb8Y8oGYS6NE2/yJzSU8IoCsg3P2sYKU/IkX8yOJkIpu845xuilHtbYaVawEkAwrDzAV1xDJXGRLduDXSRn4xNxRhQJQyCRRdHaesOZM01AQFYqq5p+m9iupj4zXG/aLVm8hMp5FXhIL8XHcJMAQqj3RpLUx3GVmLObs1gWnPFl8OiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfPkrGt4uV8HCy6D4LkJdpRm8hvm82lonrNfqOdYBCE=;
 b=3xfS5P8Mjeuup9xFrTa9l3dML7MTCP+JqRnvx6Atp3MFUUduEP/POACM01tRYN6uYNxtAD78CSvoaN3BngSBrsi5PEulUroYjlqxU+hfkKzA7sMKWsFS/ROZM/LF/JQnxM+zgxLsgLSEKEx12o78uiOFvHArzsh7y12TZqvEmB0=
Received: from BL1PR13CA0420.namprd13.prod.outlook.com (2603:10b6:208:2c2::35)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 19:39:39 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::fc) by BL1PR13CA0420.outlook.office365.com
 (2603:10b6:208:2c2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:37 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:36 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>
Subject: [PATCH 32/50] drm/amd/display: Issue with 3 or more mcaches per
 surface
Date: Wed, 10 Jul 2024 15:36:49 -0400
Message-ID: <20240710193707.43754-33-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: d771addf-f4d8-4501-b25d-08dca118093c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BtW6bCNq5idyhab+KAYMbbUlW+N2yx29wrVKiB4Yvs/jNSvrp0nPzJQoBMRc?=
 =?us-ascii?Q?Qtsfjre/qF5CoUHNcOLsZJJJS2QJ/HmSaIcxUDKkFeSv6T1LFZjNJOEZEP8f?=
 =?us-ascii?Q?znRLzcLoGDfNCJ0KN6CIy5Q500ZaBk789xbdD0RgmXBgeqn1CbZery6riPvw?=
 =?us-ascii?Q?NOeLgohv+WAUTEIbxYx6MDn7/i3hXnU9iQN8aP6vwnuGhXaHvr1sQLJNXVz7?=
 =?us-ascii?Q?YW1KW0MHL7hM+n4FOcZ/FGRqDk5qRobk+F6pjxcR/NYBOla4QuLC5dnCei8m?=
 =?us-ascii?Q?thOZMcksbplPtxXRoCkLBEk09BJ8oRPcomDDHsX0V4Ds47736g949GxJc7Yd?=
 =?us-ascii?Q?KIfyv/a0ojkthKESeiYW5IQHmz7H4tTT5UkRwiqzbkWmRQnNbvkYDQc0m8Bh?=
 =?us-ascii?Q?uyGeHivfdRCaCs5tk9iu1feTOjmN3UJCZrUAOAxT1sk5D8KsOPVKIJ2nIEZ2?=
 =?us-ascii?Q?T99UnbTU2YsAYxCj1ILKaySWIy4rNlt1+Hs+NVjbQSUPV+KQDVvdpiLGGx5h?=
 =?us-ascii?Q?KnD4QgMZXUiSA45W3TVjWlxCS7MuBl2Tgay7T6+NK/f4fbB9XvyzNSUrdNOL?=
 =?us-ascii?Q?gxL+HSYuW5zzQG/elpHUAi+02s867Lp3O7lDUxqgD7CHFn7xMKAkyOc0XUNr?=
 =?us-ascii?Q?kqJkiEhskEW+f0tznxkJLJrrNkdEEloO6Z3m+sdtUPERKbwzz61FCrnnudkC?=
 =?us-ascii?Q?ynsnUqJ32bvqBF7H356SgfngHHNHrMGYKn2XedhRQRgsmnwC8ULP+7xhRujB?=
 =?us-ascii?Q?vRwgEitqyXh7CQOvMlxZMhiI8slxx3JrNSIw2Xa+1Fb1tcZc5Asi/mYU2rVZ?=
 =?us-ascii?Q?arU29qB80MryPz1Cc4oGe6o8wkrM7rxsv/qrYtrxbLRhd6Nk0obdlFr6AHjo?=
 =?us-ascii?Q?j1y54dPDPBN4uqKbw+XaQtrF3Av69ddYC0c8RPuRxhLt71nbIauN9Q6Sfo2l?=
 =?us-ascii?Q?n+SEnGwPO0RYCl8z4utEx+s9WjrtivNGItUdCgEnLH7corfsYwxnmRCo5tfS?=
 =?us-ascii?Q?mvnYStwU7TppKAoIdLPsSMOre/0fgywtfU+m2NnOdywX4h1CqUXeTYSrgf32?=
 =?us-ascii?Q?gzX32MSIC/oRs0t+xnq5XKO+6QyEZyHOwz7iXxOPbm+xVuIJ9r3ADadLQjwZ?=
 =?us-ascii?Q?Tr5US4WBXjlydvfGGdHiTSdQfBao4kHBHNqgz7QNxl2OlMhsKxJpUAmgGGBj?=
 =?us-ascii?Q?K5sKVJLIWx/pQNksE3p3iWvuzqIFY4k8EX2NPSVDSArM6l2XtH4/2cQ7h5uC?=
 =?us-ascii?Q?UuImScKOnsNHaewFdIWuNATMcb9KiA8REYOui5oKJ/S8ns1SZavYLZQTbsxM?=
 =?us-ascii?Q?uNfPEVQoSOmYStgCZhrNsqlOhduMhBO0VSCpNb9cQQwZhtpUG+sJhJhZcfx5?=
 =?us-ascii?Q?5rzJnJJujlhJTTSO+BEr4EOPiLRBknSIFbQTTZgxKlojJI21wRNW9qVcs17L?=
 =?us-ascii?Q?iQvY4OIT3ldI2TUdD0PWTVHVYBLFANhv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:38.3840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d771addf-f4d8-4501-b25d-08dca118093c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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

From: Nevenko Stupar <nevenko.stupar@amd.com>

[Why & How]
Current logic in mcache admissibility check has flaw if
calculated number of maches are 3 or more per surface,
so sometimes the check may pass when it should fail,
and sometimes may fail when it should pass, fix the
issue and also adding additional check to make sure that
required number of mcaches per surface cannot be
higher than number of pipes + 1, used on that surface.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 .../dml2/dml21/src/dml2_top/dml_top_mcache.c  | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top_mcache.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top_mcache.c
index e69f8ce97e24..a342ebfbe4e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top_mcache.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top_mcache.c
@@ -142,12 +142,12 @@ static unsigned int count_elements_in_span(int *array, unsigned int array_size,
 
 	while (span_start_index < array_size) {
 		for (i = span_start_index; i < array_size; i++) {
-			if (array[i] - span_start_value > span) {
+			if (array[i] - span_start_value <= span) {
 				if (i - span_start_index + 1 > greatest_element_count) {
 					greatest_element_count = i - span_start_index + 1;
 				}
+			} else
 				break;
-			}
 		}
 
 		span_start_index++;
@@ -207,9 +207,9 @@ bool dml2_top_mcache_validate_admissability(struct top_mcache_validate_admissabi
 	int temp, p0shift, p1shift;
 	unsigned int plane_index = 0;
 	unsigned int i;
-	char odm_combine_factor = 1;
-	char mpc_combine_factor = 1;
-	char num_dpps;
+	unsigned int odm_combine_factor;
+	unsigned int mpc_combine_factor;
+	unsigned int num_dpps;
 	unsigned int num_boundaries;
 	enum dml2_scaling_transform scaling_transform;
 	const struct dml2_plane_parameters *plane;
@@ -226,10 +226,10 @@ bool dml2_top_mcache_validate_admissability(struct top_mcache_validate_admissabi
 		plane = &params->display_cfg->plane_descriptors[plane_index];
 		stream = &params->display_cfg->stream_descriptors[plane->stream_index];
 
-		odm_combine_factor = (char)params->cfg_support_info->stream_support_info[plane->stream_index].odms_used;
+		num_dpps = odm_combine_factor = params->cfg_support_info->stream_support_info[plane->stream_index].odms_used;
 
 		if (odm_combine_factor == 1)
-			mpc_combine_factor = (char)params->cfg_support_info->plane_support_info[plane_index].dpps_used;
+			num_dpps = mpc_combine_factor = (unsigned int)params->cfg_support_info->plane_support_info[plane_index].dpps_used;
 		else
 			mpc_combine_factor = 1;
 
@@ -259,13 +259,13 @@ bool dml2_top_mcache_validate_admissability(struct top_mcache_validate_admissabi
 		// The last element in the unshifted boundary array will always be the first pixel outside the
 		// plane, which means theres no mcache associated with it, so -1
 		num_boundaries = params->mcache_allocations[plane_index].num_mcaches_plane0 == 0 ? 0 : params->mcache_allocations[plane_index].num_mcaches_plane0 - 1;
-		if (count_elements_in_span(params->mcache_allocations[plane_index].mcache_x_offsets_plane0,
-			num_boundaries, max_per_pipe_vp_p0) <= 1) {
+		if ((count_elements_in_span(params->mcache_allocations[plane_index].mcache_x_offsets_plane0,
+			num_boundaries, max_per_pipe_vp_p0) <= 1) && (num_boundaries <= num_dpps)) {
 			p0pass = true;
 		}
 		num_boundaries = params->mcache_allocations[plane_index].num_mcaches_plane1 == 0 ? 0 : params->mcache_allocations[plane_index].num_mcaches_plane1 - 1;
-		if (count_elements_in_span(params->mcache_allocations[plane_index].mcache_x_offsets_plane1,
-			num_boundaries, max_per_pipe_vp_p1) <= 1) {
+		if ((count_elements_in_span(params->mcache_allocations[plane_index].mcache_x_offsets_plane1,
+			num_boundaries, max_per_pipe_vp_p1) <= 1) && (num_boundaries <= num_dpps)) {
 			p1pass = true;
 		}
 
-- 
2.34.1

