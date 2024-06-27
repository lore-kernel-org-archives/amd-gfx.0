Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC57EC3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5A710EB4A;
	Thu, 27 Jun 2024 21:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hPXyhRmm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCC410EB59
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmcXmld0tPNOB0OTyA+FGLAQL87HdfNOPxS6S75SPFB/cwCMpopdZr1s5GvDn7mJ9hyxVqk8OSRpYJBxN8sgGH4lp5Nn8oOy7PgDHwdJmDK4AMAr0AJLzuh04D4v3EBwO4vB68S3q9Uaeo0mIVOe9yZtWR9YJutBak7eKWRV0zjfeFVBaXixYLTS+c6tujopiw4q3BdnUBN0EvVzDvi0jkPZ2wTZb8M6qspXbmEXpASdZo4+7MjlVB23zxKTRcG1DgGwUu7ujS4cdNmv0eLCWowRM57kjFtXmL+/eHW1yI2sU/JxiSfWlIYFMh5yoEcYiyJPDtAvo3B+7l3apRDd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wIxKcU3hCvZnSu+ZQuA5ZqQQVVB6jg0q/iw5aPDcXM=;
 b=B79TimgIOeqcXu8H9NuucE4WRrNw0H+TZM9dsz4sn95UgJ0nfP3XenLVIadTPNIaHkm04W8AJ4p48SwzDSQes1GHtJW/4a5xuRZDnhJUuy0x/oQL6BH5i+x2GGsHXAT0jfx6N88PzEq866IvqCLBu0V7y2ncf09QrzpyPO84ULDaOwbo3KlJer8LC70p9pl+Dyy/MXF+3B2Y7cXuuGBClShzHWGeucodmFRREFlfCn443lTFsUr2jz/pm6hCcYqkMb5Q8RIRVUjH5IvgCjIIX4oAKztxVIKOrJ+TZD3kD0CvdEbVCrVKLv+T1d9cdFRZLqPVRDeLiCJZT9lk1jSkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wIxKcU3hCvZnSu+ZQuA5ZqQQVVB6jg0q/iw5aPDcXM=;
 b=hPXyhRmmkQ4L2FhWbJGDBhrccR3o3ANbyo2gRzcUUMsimJpPpvyViFlRwz4qNvW8cVtxH/oDTgrQ/xPd7I0CMphajGxM9NRSqvBkD/7hSxY8Zy6lInvNff1+KhzKgK/xp82WpPco/6kIgAHf5xMBVtDKOsb8r+dOh1tl5sINLy4=
Received: from PH7P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::18)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 27 Jun
 2024 21:13:49 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::59) by PH7P221CA0010.outlook.office365.com
 (2603:10b6:510:32a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:13:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:47 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:46 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, George Shen <george.shen@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/26] drm/amd/display: Fix divide by zero in
 CURSOR_DST_X_OFFSET calculation
Date: Thu, 27 Jun 2024 17:13:06 -0400
Message-ID: <20240627211329.26386-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: f336a8b3-bd6d-45c4-b9c5-08dc96ee09a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+M3qgppkzhExlrGdmJ9Oz0q+LIcDzGxxxu5P7d/DRA2sK3GfIRAfDr+QXFjX?=
 =?us-ascii?Q?xqUKrGgpWJThbB9eN665fQAi6qMVgJzvnuEnTstFUgMT2aXQzHOCrYSkBxq6?=
 =?us-ascii?Q?jxnCKKgHkRbjK1EFPq35zvKJ98YGKMZr6vr3KO5yMctAlCztrjQvwX+xbYaD?=
 =?us-ascii?Q?36iycPqZU5p5fq0eoRvhOgeoBiBpsgOGeGu1SAAm/R+a7cNBNQZpzFDwsMMr?=
 =?us-ascii?Q?D8Hn3g3aklL733MsfgjfJyVIOalSzE+wg50PrpkF2MLZ9T3MdrmPhVF3nx7H?=
 =?us-ascii?Q?xJu9lc5FZ+rvoEqUa0BWwlKRDC2dKPlUsLyEd7k2irMiYR/LnGHeipmB99ws?=
 =?us-ascii?Q?ZBVockQ2AOKv8XySl779QrAa8Dz07o/J8lwrjAEd+0kVSFw0XWE1tRHWrJG3?=
 =?us-ascii?Q?D4Mrn6ay8qTlWlqbfUB6Zl31ibLUZnuvtNAqIflOyfkI3LGocIMql/8a6PFm?=
 =?us-ascii?Q?ajQodq+Azaq2zL7r2LpHV0Bwyk/r9qrnzTLmAIk1S/Ce3JN/T9p8juyd02jt?=
 =?us-ascii?Q?k0oGTCHQ3+FMI6oe/el4ksGYfNC9jQlVR7Tj1KE1VhpulvV6+RWMUojJhCZu?=
 =?us-ascii?Q?yEMzHdJjqnJ1CMk68cPQ0cKT6GS79Bn66PMVKfjoiBHg6acq8dFELkjf5qED?=
 =?us-ascii?Q?nuA4Gtbivn5esgYoAqtAxCl6CNmfr94HCxbtvSF1F1A4JhG3sitY6kU4BGQz?=
 =?us-ascii?Q?SwRI2YEFQtGJroVF2qAqJoJFwRlE5Ak0PVJHym/CMFUtZr3hOjN0QghSA6Fd?=
 =?us-ascii?Q?Mf58kfWQbSGM0M17iqoQp1dEXYEZukYbmOW0lHLBEHAQyrLEa3W7csr9D+PL?=
 =?us-ascii?Q?CcCJ/y8wcocE5DbTBAgYO5BXHDjc0v4Vl4/dr2UILPnPKuK1jzzet9BCrYx2?=
 =?us-ascii?Q?pUbUn3haK9GioRafhPdyjm6NqOXpg/L5C+E2rVaNXdO0HsLISG/kRK983Asa?=
 =?us-ascii?Q?osM2FzFhFfL/KhtrAaqQD9srUeuOhksGuPBIF2agrchrEmXPIv+dg0Ox465X?=
 =?us-ascii?Q?nw5kLUcoqKG0bbC8PLTYKs5LaLXf+TigMT6fCKKRMvSTCBUt3LeOvCQHyiQq?=
 =?us-ascii?Q?jbp3OGDqL0hahj2Q3eSLXrWe8a2+o/0yfhMtkITN68TbZ+UpHuyfRCs5Cu3P?=
 =?us-ascii?Q?wN1OYdaKX1uXUHWIlrBRbE9lkKo1crfykvRP3Xeh+dQIPC8+WbREX1v4Y/GM?=
 =?us-ascii?Q?Lq/s+9UWjbTt5JZF9thHGAXFFkincbGEtxWZc4JgVXMBTy64R4qIOiDof85m?=
 =?us-ascii?Q?XA02zN15mnL0ELF6w03aUNZp89fK0B/3t1dmzy3rwJqvhMUqzn6rvcKl1XVu?=
 =?us-ascii?Q?u3wGJFnE+nEUpTfDUw9wrmVpQsfvs1fyxSNdU/Zgg2iMGfTqmNEXutiHurKn?=
 =?us-ascii?Q?uSFMwNQ18ZZXEoFCcgf0aGFsUJtvFbYmBbEK2L3uspfBinbUFnNklpbrRggn?=
 =?us-ascii?Q?HjcpDN599Cz3beodLOtTmZxg8HJ09Wxx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:13:48.5556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f336a8b3-bd6d-45c4-b9c5-08dc96ee09a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
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

From: George Shen <george.shen@amd.com>

[Why]
Certain situations cause pipes to have a recout of 0, such as when the
dst_rect lies completely outside of a given ODM slice.

[How]
Skip calculation that transforms cursor coordinates to viewport space.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index f0c45a74c2e5..eb0da6c6b87c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -677,12 +677,23 @@ void hubp401_cursor_set_position(
 	int rec_x_offset = x_pos - pos->x_hotspot;
 	int rec_y_offset = y_pos - pos->y_hotspot;
 	int dst_x_offset;
-	int x_pos_viewport = x_pos * param->viewport.width / param->recout.width;
-	int x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
+	int x_pos_viewport = 0;
+	int x_hot_viewport = 0;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
 	hubp->curs_pos = *pos;
 
+	/* Recout is zero for pipes if the entire dst_rect is contained
+	 * within preceeding ODM slices.
+	 */
+	if (param->recout.width) {
+		x_pos_viewport = x_pos * param->viewport.width / param->recout.width;
+		x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
+	} else {
+		ASSERT(!cur_en || x_pos == 0);
+		ASSERT(!cur_en || pos->x_hotspot == 0);
+	}
+
 	/*
 	 * Guard aganst cursor_set_position() from being called with invalid
 	 * attributes
-- 
2.34.1

