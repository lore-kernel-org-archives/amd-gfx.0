Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F64AC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00FC11392A;
	Wed, 24 Apr 2024 08:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tIBZePAj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4D211392A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhd92B4CgFFi4CXwSge+HcjX6V4+rm7brniv5Rl4kjAkKtFRwgRH8pdI2p435lau68YRhFEvJAXk0Tx6orkqI1U5NcYTbvv175xdnqr8ZlO6QxJ6kEGHiddetHl/YfiuekYlKfQsonc/+uhjVoY62EryMRqLx5/iu/k474vn3MYIGs+WjghjWv2uDGM8nq59ANlbfEGf7TmERFf6hT4EY1oPQSacPSp3EL5fHloqD0a2RuR90hbmJjsYzdkuR/3aQ99D/UVqmil/q6OaI0f/D8va8UT7nx4OztXG7Hfv1PDd3GgalmwSGVv2IqiEqIiKzy1oWsDCekhbwR0k2nQ1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipuzVxtr1BiNvmxGdKiHzJVOPVHG8FQy7BMcRc/nDIE=;
 b=HEoVIJRJk+5ia9OP9ceDzAsMRhhp5Ec99iXKpgOKsuarsEgmXYo8TVU/0VQzg9GVYZgbcC9Nb5OfRAbTK3Zux9uyK7AItqyTYu8l1L0rU4vCjGLVxQlsK77dugh5mA+GHMIFEtplWMS/Wvsf0JbsMJd2OEQpuu410gaA7tZsqBfUkNt93xQKaiWhMBly1ldWlD7FIbK9AuRBlZQK2sz1hTi24KJAfvUm7+xkupugcuikubfo+v1wIxk6DJT+uFb8KvCibz+GWN+o+0rNzlA9LdjQIlak9rSEWujf1TufWsWt+mdke6GRSD1/C7K/9C7JCCbrtLuq6c62JIVUy2rR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipuzVxtr1BiNvmxGdKiHzJVOPVHG8FQy7BMcRc/nDIE=;
 b=tIBZePAj+UfY9umGSLhtKgiskRylzaEd5Cuj0tmUuHMlznpCGepnvAe+Xjl5tp2+0BB+0snvVZYnWsUqO9zrvspdRwNNRrHh6Vtn9Aug2SuzlahylRjF6fmuLwbaNMHsFYd7RhTgKM3tQbHM6KvNcPQuL/+ByrOYylXAX2A1MHU=
Received: from BLAPR03CA0091.namprd03.prod.outlook.com (2603:10b6:208:32a::6)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:41:15 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::98) by BLAPR03CA0091.outlook.office365.com
 (2603:10b6:208:32a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:41:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:41:14 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:41:10 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 11/46] drm/amd/display: Improve registers write
Date: Wed, 24 Apr 2024 16:31:27 +0800
Message-ID: <20240424083202.2647227-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: a1639ee7-9824-439c-e4c8-08dc643a4db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lPyIPpuOGRTM0ZUDV5Qg9wmzoXu5F2L516BEP56Zj+h1tO7S6vEE+dCJ7cYs?=
 =?us-ascii?Q?TrnBAH8w8Mr07M8OWTJlU4k8oF3xjDL5Bu0YKbvsaLnmGo4ETVHFABpQzhtm?=
 =?us-ascii?Q?c6aJnTGY/p12n8l/7bmwSkk+x2W2GgJbUEGeVuI66bZ6ZZnW0WhitWuQNMUV?=
 =?us-ascii?Q?VZo6Qxe9eW8nPQJFpKHGd8JMT+ui9jJNCtSy62rQrV+qWJ49VECE141Rfp6E?=
 =?us-ascii?Q?pL2E9DTP/jVPCl5uzRHYUJo+8HC8F6Qy55R9W1E/y+NIOKj1y+PdtAtjz6BD?=
 =?us-ascii?Q?ibSJZljYPDezBZvva3P5d4C1Z7kZkc+FsC8JxIxb15U2LIECI3i5rnzHbq2v?=
 =?us-ascii?Q?+y/zZsQVcOAaeZEBR+S117NwYPkjwQlzbHP3n911cD/Vh7bdWLukW9tCai/H?=
 =?us-ascii?Q?CZaMiV06HGrLzOLAN+kInbV+AT3c+9YtA3eLWk+2zTmE9vdQvwOlHGcfF+4t?=
 =?us-ascii?Q?OELkB3vDD25KtXl/uBYeVL0a9kSrGWQtzpVyV7D/fFi+nFmN2VACzYc9ufwY?=
 =?us-ascii?Q?DAwoJuSFnLUQhG0Z5y+4WD2lg8OJHhyOn4a2opJWjLbyTasL/cP5vRDUCeXJ?=
 =?us-ascii?Q?2e4hD+r2mkjG89NkoeCwKAB1ic3/XWSYdRzmDy+9p1n2qQIcqxewtcJmBdyi?=
 =?us-ascii?Q?u/vTKCdUIVrL1Vr4zwmGliNtLacogyWIHAgAEdVhDxKLo5gSFOKQj412AXVe?=
 =?us-ascii?Q?cVYFPuKjL8mcZcU6mBnl9G73wpXuXAJ+Pznv4ce8vKG3ZfDXj4O5FEUSAMiN?=
 =?us-ascii?Q?Cqydp/ClJpFjLVysUWF7+w3LsLAPiJTvj2ooOaWSmfD2EmZKfz6XhJh4gusl?=
 =?us-ascii?Q?XY6znUXyqUzprOXddqB2aZTK4J/ejZHtd2hOGyHFE8y4UMfppnT7ajtyg9Wv?=
 =?us-ascii?Q?b6TDwMPftiWyqxFJbghSZPjGUO0kRxmcVT9grtohNJ16LoBC2z/YzUOjVW0f?=
 =?us-ascii?Q?+Uzr25626JX9B9rD8i9UT3gz400qRuLn/heCvkXm/mErPdRNd8veSzjM7/1n?=
 =?us-ascii?Q?Gnid0ebNQFHOl0gkI5OTb/hiW7C314pspqQFrs3vs8uTGu7gM6L7eJxO0VP+?=
 =?us-ascii?Q?D2kIBmUVpUH1FdkHrSKW48L1NR47Dn8vmWyIfmBACPOoJYTzUVYxSGWs9Ndw?=
 =?us-ascii?Q?FbF7R0Ma3Cvz+6J6Yv0XVGqwVHy5Br+kt4FVJcZt0hrzdJHyWzgeTx6B8S/X?=
 =?us-ascii?Q?IkOCy3mKyUSpPoR9wGFdNgbKn0Y0C8Lkvt+zs91C4EWk6a4GQpXbQditsK0G?=
 =?us-ascii?Q?by9PzzT3d1A/P2gVF/Iaw0OapxhbCEmJYT2wYdsIrSMZwkXNJT2bjRQkz28c?=
 =?us-ascii?Q?LMnppgmwqgFFUm1xEmIw3+LLbSwGJrDSKO6Rhg2y3ugqy7qhuWTS1aeJPOm/?=
 =?us-ascii?Q?31G+biU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:41:15.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1639ee7-9824-439c-e4c8-08dc643a4db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add REG_SEQ_SUBMIT and REG_SEQ_WAIT_DONE to optimize the burst write for
the regama lut.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 20481b144609..2d5d64276cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -410,9 +410,10 @@ void dpp1_cm_program_regamma_lut(struct dpp *dpp_base,
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_red_reg);
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_green_reg);
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_blue_reg);
-
 	}
 
+	REG_SEQ_SUBMIT();
+	REG_SEQ_WAIT_DONE();
 }
 
 void dpp1_cm_configure_regamma_lut(
-- 
2.37.3

