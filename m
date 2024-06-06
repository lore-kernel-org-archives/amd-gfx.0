Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A38C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA01910EAD1;
	Thu,  6 Jun 2024 21:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y2JJwVGU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB5510EAD1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCAYCDQTWXlFkwrVj3LB8/15J2VAirPzX8LiG2yWrfvCmJJcPhia2auI+7WJigcaq/e3FzjiWuG8NH5prxRbG4D0bO7LpQ73rT7JRkZ4TpmCQjoroaZUsFeHYikZRbL/38hAlUvgRsOJUX9wnxLY0y2yJ1owAtZ0lp2HyNTsiacbB3EneIJY9tWL39tGv3hMlb4ov/IEwk+McoDlIVb6gwjPKIRnS81BqREeoUUVCmIjIqxA1g4j0zCimSER4bOIm8+hVz8T0g1upFJhCZxfLD4Sj8oGRylzwwiL0WTb6T9LewTTPR55sGGP9MK8GSQCPMJSKcPXfa+MGNEPeysBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zBzZqTZEcOk9wdgx7F3LAipJmJSWuxZu5ADwLxdglY=;
 b=QHL3i6qC+cNaUYp7gegAkA5p/SUWTriTRHOTDqWDxGNdqGqzNLVTZjNKkRXXTd5Rc1NVdbfIKiRCROaYvPoO/u+H+bY/AD341HK7XGiOukxJz9PUY78Cs1WAkLgfkqcY7fn9EcjqKNwVxWfiTBUkYb4ifVcHYgs191nv4pNqFyMiWAe6dpe0YBbLJDUpIpzAIUk4mqa6jkfxOMAuK+Pk3TV4IJCl5IcR32BMNujFKuU8kJESv/1OTgX8OMG4T7tJ/JrZTjwqZ8QsiTwon/MloRAPno96Fvv0JPBT+mDuoHoQAz0PSjdciTkDKrfO/wAxLWkx2bDhSVfIUWpFDHJs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zBzZqTZEcOk9wdgx7F3LAipJmJSWuxZu5ADwLxdglY=;
 b=y2JJwVGUAUEtDy8PrPWl6zsO82ON+RUF7aDc4OYYdMzwahSvzlz/IyNK9AoKHZGve8zL8ZR0GFCkNnWyRLP8Y++mxSszRaXG7ZPdKtWiGSB6ACjn6acQj+QzIP9h22+c+c1Zf8Ko5tyHNGccSnVOzK2e92aPwp3I46vFYAjuhxA=
Received: from MN2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:23a::28)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:57:12 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::d3) by MN2PR03CA0023.outlook.office365.com
 (2603:10b6:208:23a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:12 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:08 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Daniel Sa <daniel.sa@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 14/67] drm/amd/display: Return after Init
Date: Thu, 6 Jun 2024 17:55:39 -0400
Message-ID: <20240606215632.4061204-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbfcf03-95e1-471b-5854-08dc86739eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/TDt+O+9H/sq7ZutfS5mAlcE8x3D2usnnjyMa5It/dArUMGmQAzQzw3ewgB?=
 =?us-ascii?Q?u3FkjNUc8XFRC9yJFIh3OBlEFM1DFE7r7F9dencA7xqtQgTdUkJHaMPpZ3Q+?=
 =?us-ascii?Q?fho6YthWhKDlDM00k7j4EoP80OqAdD3gN1tqvqETeAoZZQoEp2QTioRhwbQ3?=
 =?us-ascii?Q?gwEdzCiT3lna2e1zNUDin0LG4HMObwUr9GNYVXzKX0coxfOoInnGVLeagqUM?=
 =?us-ascii?Q?Egz26+PhFm9ETdrg8P9uhB56MmxK5ZGM/3UipNjOpQP+yFosDMIy2sEfphxv?=
 =?us-ascii?Q?yBlY3X99ZxAmtOBzACNLt1wDT1ZsKmQxy9Xp8W0qEbTKNJlQQb8xyIQ5oDee?=
 =?us-ascii?Q?T9fkzAAEviiSOFkB4F/OKCZQPTYLdi0IWGd9se56Aj0+ExQvlnnP6zTW214l?=
 =?us-ascii?Q?zh6il6kSEyLomr4fiZeYSYfV7luEUnrV9QfsNW5D/aW76WZgbdNqpxikpaA+?=
 =?us-ascii?Q?6M0XEj22ggIaOc5Hxuf72811ya/VyMbxyoaGK1+3CGa2KU3WS5NVGuzBk4Ce?=
 =?us-ascii?Q?PP7MKm8j5z1KTL9PK3cNVg6f2W9KCrUd9pbvwo5MDBMTm0v+z9Is29IbnbQF?=
 =?us-ascii?Q?e70y6dLYFrkxYBh5DEumz89PaoKMOtwj8yrJcGd1vooWjImviZXSkKCDcrOt?=
 =?us-ascii?Q?D2J5L5LcQu7NCsmnlQJ7r/EE59OZCZAkTvyi6g+o/wN6U6aCvHcu2odzxu9r?=
 =?us-ascii?Q?4b5VgK6SXmpRwZD9v/D8prOyqTEvBeivMCTRIRvycnRQ8iAyv+Rbvq0mONuo?=
 =?us-ascii?Q?W3jh4wl8JPIkZ+G08PckRpWgSGZpa07DycZ0iIL6cer07fSvWM81vdi+gEoP?=
 =?us-ascii?Q?KblwvYWvHajMMZ5GhA6PipYAR4u+cpZuybzovR17L5cC/bMzGtKIEu6YuZKx?=
 =?us-ascii?Q?AW8KBrv39aV+mDNqfh0rzoyXxf0pg6mO9mCEeqUq985i3W9K9k854u7Io/eU?=
 =?us-ascii?Q?ghG8BkNOz6zILB0c+QYu/63rifzi2e/+FsGR/R9sMX8FBH0fu2w9EwghV8LC?=
 =?us-ascii?Q?TGIx62UnS1TxMTxou1VbYrheNU6ETmkRciLIZNqRnelDMChhkBv1eoYtQ+8Y?=
 =?us-ascii?Q?PJnzF7E2OkQhUp14CWvK0+PU8VgGJcQqG38zoPplelcV7NaIbFyjcSfGxxJI?=
 =?us-ascii?Q?pamYzI4em9Sl0ZbxQlGWpJ2Fy5IDht6WP1TnkcOOPgvy5fXTCEnXuSN/BmWl?=
 =?us-ascii?Q?+t0Y203gXcIZTJfLKxFO9Y3oJpA53SZw/f/5EW+N/gafCdfnDBddaUc1DXAd?=
 =?us-ascii?Q?HpD+wa70SZD6jUQVloCPZfmEKBDw6i7jPDVQ+N7UrHgiq5zDxe0HDvv1MEyL?=
 =?us-ascii?Q?M+mhPLto5o7gGE5DcguzgcULJgkBILn3fvhzcbamh2aqvzAuXw/UedfqLYVF?=
 =?us-ascii?Q?Sxnz7imEPRKAadGROCp1fGL0vJPPNZ2UuiEb3mxqDoNtSxTPNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:12.4662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbfcf03-95e1-471b-5854-08dc86739eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
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

From: Daniel Sa <daniel.sa@amd.com>

why:
DML21 being overwritten after init.

how:
After initializing, early return.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Daniel Sa <daniel.sa@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 17cc2fdd7d34..f5c2ab0c0d58 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -740,6 +740,7 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
         if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version == DCN_VERSION_4_01 || in_dc->ctx->dce_version == DCN_VERSION_3_2)) {
                 dml21_reinit(in_dc, dml2, config);
+		return;
         }
 
 	// Store config options
-- 
2.34.1

