Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1759C5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A9710E394;
	Tue, 27 Aug 2024 16:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jVbQxs/W";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BE510E392
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQheKRrm+0grE7rxy8Moi2eTa3ieh6qhzMyuvE6vDNgOfCq0QPweG3IZliT0wYzyVg6V93neSihkI/cNsf2k0/m3cFVugMnoaVg51ax+InwCKjQVmvCgSzkmnhl3hAJckP98u80YV2lYOVXvlhnwHRmA+/IZHkver1dcubqgparZ8eOQkz11x/CP0KmjkmSyi2AAXIRCIeeO8AFRSEVeT7rulGwT7PZmPM/tzWzeshvC6s8vw+a0FKwZqRwgg3gYwIXX5IRVusYeJh+tYsNNUBnIolxX4TZzHJYKcMsbpnJiMVryxNRZFrg/2zsBCSBjn9hiyOEgO92s1Im62fQq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONBQ2jdWEO6XtCndysKCCdBuBfN2n8GdCvD5TLO5sco=;
 b=x+dhl2bUTNpO8ZXKNYhhbqFbAGwgef6jcB+Y5mzEmA5J1otA90QSWMkuIUDhGxdHi1F/7dRK1DUolurciDh7MuaXe/P/tJwlazfU13SYjUSREenaab4WDcG7XH3lUofZhlv9kcwWv0odLx2Cb/ukVEVMe4cSI0ylm5UUWuPuWxuUwpXjYzvccA5XN1VcHJUMni6wDTnn11FnWUCsE3V4Z0ZV+nZkjWmsHRcAh6HZ8//VjXxumS9NJ7EhUQ7E3sbtu6bffzr24pmanDQ0WHc431iLShHS5InYse6rqOHFB1Mj+TwQ8e991FFFwBdy6VnxkL1ExYTC+RZNNCqy9QMxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONBQ2jdWEO6XtCndysKCCdBuBfN2n8GdCvD5TLO5sco=;
 b=jVbQxs/WSbleu3ZrTMnxlwaPNbdyYkqJ+NxU5flz1C0zFKUjwN5AOkT7rk7sNyI7Lr6dEbUGly1pJ5mo4f52pCYl803dLdsM1CiEhFTlOwa9qRcKjnq59Exg+8ufGxAmut1e97FEmQvKAyvmCtejr7JqUrVm2yz/3dCDzGO4z+w=
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 16:41:08 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::e4) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:08 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:07 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 05/14] drm/amd/display: Add dpia debug option to control power
 management
Date: Tue, 27 Aug 2024 12:37:25 -0400
Message-ID: <20240827164045.167557-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: d408a499-4776-46a7-4f62-08dcc6b70d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?97tl9fj4HzEalpftQ0L/O7cHvBpWDtaTBnCxoLN85UnCXyjzLP06XQV9Pu4g?=
 =?us-ascii?Q?FEmGmxLeb7JmSb+xD+bKvy2vTzSVQLAUlVVB0cFGxsDZd3lrOFvVagQ2jVWR?=
 =?us-ascii?Q?m0mizf5yAoeuJbZrZBcRA0lZViYVVL0/kifLOgdbUHbvH+GNk6tsHnazhed7?=
 =?us-ascii?Q?LUGE5bKjjxAYFc/JoztAqV/wV5IjjxpQ06tWX5yHFW8C4I8YiXPLqBjFs59h?=
 =?us-ascii?Q?9o3ws+7uutW7EZUZNa9RwcO+18et2dWrKesFsg/Z7rbF1DzydYLGzcrLssir?=
 =?us-ascii?Q?C5qiemoEb0qvkR+AWNjvE+gcFrBvKrXSK15sWK0iLiDBt0Pn0L5Wvn3v29Fs?=
 =?us-ascii?Q?68i4nfC29gFI5H6bWmQqlarsFZxU+j8Qt/+Omre0VPSoFluzPUivGiPzVvpT?=
 =?us-ascii?Q?QR2IHyJqEeCNzKUKNZ1lH2sL4lMarFI/VUMF0nr/vvP38JahFREPuDkaEODK?=
 =?us-ascii?Q?zfCOkjUbwP+JHxDtc2LozZeFuDClx7xYuZibmSC4zvxHWtzBlcMBv8mprmI3?=
 =?us-ascii?Q?jgOmzb8xtXne5195kCRnxLECLQuEZIk9fcd899U++8eJn3iUElRSiH7Dl5q/?=
 =?us-ascii?Q?yVaHC4E8H/CO8bYaMXml6p45sD5hIQwgshZOR9PZJVXc/7mkHB+pnjtJf7BF?=
 =?us-ascii?Q?EUxgAHNdwDpNNgeK4oyuayYCBKXODK1PlQCe6D7lFtRLbnNgM42XDo9VeGXf?=
 =?us-ascii?Q?J9Srq5UkC52vm7iCa9cdzQK7tbarYQk8gPe4f65Kwz4Lm/p7gJWbIBz/kQZd?=
 =?us-ascii?Q?73wxBgNreKRfKIPtdPwqhxnrhF5BrNhwdVjcfCtPoeojxEv632UDjNblw3we?=
 =?us-ascii?Q?k3MdovqU/9LI1KsD1UXhQ9GHzncoIHwGHKOFnrA9YPg/8RB5+VclMS06V76v?=
 =?us-ascii?Q?YrQS6A48UytMvqXpIgUCISwvsumKI/E9adf1LztpishOiSC1G/q2jwZguTvx?=
 =?us-ascii?Q?BSYLM5AfelaymDiFAkKaugWDMszwumSHBktZZB56+I85MZw+t5hQJsKbeswN?=
 =?us-ascii?Q?mSPVHYtuaSZ6fZ++NaEC/ByFazPzKZrrGX2IYAiKPiCOYFPnZK2Am8LIOLS9?=
 =?us-ascii?Q?jDugu1mHrDX2jcEEU75TWhkX0xnHcqz2+bLYnlji2mrq85hpBBxGGl0/qZUH?=
 =?us-ascii?Q?8282x3g8bteOlGYQGbIwLgTt+bc6ab/xloN9XEY2cLvC8LJVZtUkVr7pjN0L?=
 =?us-ascii?Q?06S1ygteoyr1wfTX8kxT3/8SI8c/fVdRELkwrVY/ktDJdfM0INcB12nuwfpu?=
 =?us-ascii?Q?gP7SG/lXkkZAKYPGkDnWc+locz40npLusus9+jT2TRTVmi5xdaekAK95u/qm?=
 =?us-ascii?Q?iw3W0WLPQyQtB8SpQs5YXSVEX5oGFdR3BmUgkqhgCxs5yxcMmNSQd8Wk1REE?=
 =?us-ascii?Q?fyPv6IIL8qA4rfdEXcGzNq2oLwAd7A3jnf3iwZndssjcmOb7EPcAnADCGAoC?=
 =?us-ascii?Q?kcsHd7XB81aUH3DXNthjQsBX5eccL4uN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:08.8412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d408a499-4776-46a7-4f62-08dcc6b70d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
To provide option to dpia control power management

[How]
By adding disable_usb4_pm_support bit field in dpia_debug option to
control dpia power management

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 663aa565fc8a..aaf1d7fdb73d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -761,7 +761,8 @@ union dpia_debug_options {
 		uint32_t extend_aux_rd_interval:1; /* bit 2 */
 		uint32_t disable_mst_dsc_work_around:1; /* bit 3 */
 		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
-		uint32_t reserved:27;
+		uint32_t disable_usb4_pm_support:1; /* bit 5 */
+		uint32_t reserved:26;
 	} bits;
 	uint32_t raw;
 };
-- 
2.46.0

