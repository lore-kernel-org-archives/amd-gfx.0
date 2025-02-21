Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2A3C021B7
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6A010EAD0;
	Fri, 21 Feb 2025 15:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3x0SFH49";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1205110EAD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2KnPKXSxza4h0LKyuL0SkxuXNvJLyPmyvEtsNHZjbG2sKqiE9KBoUIuy0A4ptPA8XtRP62AVVlCb5nYyWvypRP3GUrAgNeoa3kOxIQCOcAxBnfEWUbTiHdIZIrs5HyT4WFOhtbgLnVcNgl7IudsJI3s+jlg+6xGIi6ezU8HvFAfsOcVXpG1SktdxRhq8O/jF9f4CufnQNXJEQix1q1zNuJuf0phbvcwQ+L15xb5+b7BL2rrv2QHC/5EwdCaRnIb96S6IXlHJV68NK3uK2lg1gIyuaFJMYQfQqJdbi6TW5iInMnT7zljrIcHynPPanl4GM0YaEpzx8fL84rzKK+22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjB9yZVEv7VcvpAIR7uRIINFsKrr9P+sYKLwuV8tkEY=;
 b=vE1fiHKk8wKTflUCSBEbjQjxwGgC6kgq5XLzsPb56NsyQXikljqQHSA6FMp80IEHytYNcHDjXaBSPDo5CBu+pGf/3p/wcEeBzo/FDkwkvVL/Gv2wEPaZMis0KdEwb/pmFCtIBwK+NrwAy680Yj0/GcI2yESHJwVIuD3uG1msNs+w8uWjQP/LWQlkc7i95kUYTS/qDGpCcdttK1osvs8HjGbVl6SQ0j5yh4jiULbNxtoB+/cdEwJiDlfQDgGHo8w3NEb3id/RIAmmx7cW6FdUhSc60nxfTehp+BfUJWihVQsrU1bDIxHBRHwTBH+AtjVsIm1LsvcavPMrVhMq91lc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjB9yZVEv7VcvpAIR7uRIINFsKrr9P+sYKLwuV8tkEY=;
 b=3x0SFH49TSCY1ej2dNk8OTcqrqTXpaZmtzEbzn7RiZLuFfqLvABPUMbrTBUOkPBQlRf2bWC2e45PT8I1vnpHlfBsuq+9uNlFvl9S5SmhsY3txvX4BXJk8KF4x0ruVXJYbeLw9/7EJVZLcihNjEe8YqmHUSCcif7K++wNHVvUEqA=
Received: from MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 15:57:57 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::c3) by MN2PR03CA0024.outlook.office365.com
 (2603:10b6:208:23a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:56 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:54 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 08/24] drm/amd/display: fix check for identity ratio
Date: Fri, 21 Feb 2025 10:57:05 -0500
Message-ID: <20250221155721.1727682-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: a000e4d3-25f7-43cc-e22b-08dd529081f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i0ymxNXy5bnSmavrdbgKIVofoicADjBDpx6QdRMtN5S8+BoAcYI5iB+MYWcd?=
 =?us-ascii?Q?hoGrp0pBM/Ex+ccU7uXrXBI7AtShtGc9Ak6TN+yPobgw4ZfCfWqY1ZMXBNeH?=
 =?us-ascii?Q?3+oBEEeTrcuyq74X5wYmgCXllvaDpAR4PT7O4ZC2F7Wm0eIoQP/KJipzLbjT?=
 =?us-ascii?Q?nUFFfFlpwhcj3m/nCdUD62z+rWEPaHZQXWkrPpGCYZzYR+6AkCxurregaRvj?=
 =?us-ascii?Q?KqlKEkaEo3n/OFwFD/dE68L1N7URJJyXgVpJn9QY8+jaSPQmfOaregPTzfGI?=
 =?us-ascii?Q?SE7xA5OZmNQB7k3pLqiDHmkhNXUJ2WHYJkmVmAvcLUKi0nR0hpfUFFgJ3crZ?=
 =?us-ascii?Q?NgF+f5jdbeBjyyPPKw3GTGIizgLiB8wutSpjNafb7//PD/5SZAYC3hQFQPqs?=
 =?us-ascii?Q?fBww39zVjByR6acNM0lF/JRyEzC3Ee8sJXQTU8VsJadBGoTNnl1wbmhuEPPF?=
 =?us-ascii?Q?3QBY1jMhRv/EHu+kBIP/DwxQzZdiadOqm75h8IQwIi32fc1J5jD5kyR5hI+L?=
 =?us-ascii?Q?5zNzJ3oeJEBH4TOLhVeWxJPVTNNjoFkpVOhwHQi7dTtww0zUsYtk8hAmdFy+?=
 =?us-ascii?Q?Yi+n3pVuOOJMUpHB4ptMoxsjMT9bLdU+2qt3f8rKF2A+I6gWkF20tN7bjnMa?=
 =?us-ascii?Q?sQ3MAcYiwop1pTlPJfkEPIK2bfC7jxsk1UVWm0SLcJvThzCB/VXbDOvnuCjo?=
 =?us-ascii?Q?Eutbx9e9llhCeb0SvEZsC2hrlHbtXynLMT9BkL27eATsdc/viSZMEut7oTEC?=
 =?us-ascii?Q?tm1GgIeWvFLddTmDewIlizcAThsHawAsAPlUscMd48pqs0xc3oCTfBV6Kx47?=
 =?us-ascii?Q?OIqnhjrGM2wB65Ru1rHAYDX5wv+Xkcy4tXpnNdblQYym2AXW6tbvojDrrLl/?=
 =?us-ascii?Q?hzi/eaO5pMG8iJOeBv4mh2xRogE2HHc8wXa10qGe2retMLZTNytnCVuBE4Oz?=
 =?us-ascii?Q?58HnzJiBT/EeRIS8h8t5yaiyoWQ+lccMMdizAVASk2UK/hfDsixxhAApeNUu?=
 =?us-ascii?Q?xsucesQCrtAla2uKBnEYVGOlC4d0J/sYn98+nwrLROMNZU1SsoAHC0Cv1rgA?=
 =?us-ascii?Q?7ahux+aAR5XlGOnJPeh0uq1I/In9r2ml+qtn0j1h5xkuUW11urkOjUi9zrED?=
 =?us-ascii?Q?F4S8ISUNxkUUdHo6xJBpopTj2vElE9hPa07DWsql4UcfYdnVwdndRs2c9s6/?=
 =?us-ascii?Q?QTm9q0TtCrIwtPIdXhp4YsbwzGwIBkuM2FEGN8jlIbXH4FBnzeLAeq/bR0TL?=
 =?us-ascii?Q?pEjzqU4ULCXGWZyY6QJAgDfRB09fzicOdGWk5gaPiQThIv4jU382F+jDMt17?=
 =?us-ascii?Q?7S67XPO9juIT1BbTr6C8tXXEq9cGlpKhBT2HHXtf+RQ/80lJDZ8ywQCkkoAA?=
 =?us-ascii?Q?Xuy4IKSDO+3lZ4g/bVd1QSiDGxXoxnI5/53TbrgJQQd7EuysgibXLv1istqJ?=
 =?us-ascii?Q?Ze6ATl6YskTuHt1lt46jYKlPGu2CYjqAYUk0ukd0WHp4s1uG5FHT6O7aBrHd?=
 =?us-ascii?Q?RKEfz7suWULNCkk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:56.4643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a000e4d3-25f7-43cc-e22b-08dd529081f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
IDENTITY_RATIO check uses 2 bits for integer, which only allows
 checking downscale ratios up to 3.  But we support up to 6x
 downscale

[How]
Update IDENTITY_RATIO to check 3 bits for integer
Add ASSERT to catch if we downscale more than 6x

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 21 +++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 3d85732cc0f5..047f05ab0181 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -8,7 +8,7 @@
 #include "dc_spl_isharp_filters.h"
 #include "spl_debug.h"
 
-#define IDENTITY_RATIO(ratio) (spl_fixpt_u2d19(ratio) == (1 << 19))
+#define IDENTITY_RATIO(ratio) (spl_fixpt_u3d19(ratio) == (1 << 19))
 #define MIN_VIEWPORT_SIZE 12
 
 static bool spl_is_yuv420(enum spl_pixel_format format)
@@ -887,6 +887,8 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 static void spl_get_taps_non_adaptive_scaler(
 	  struct spl_scratch *spl_scratch, const struct spl_taps *in_taps)
 {
+	bool check_max_downscale = false;
+
 	if (in_taps->h_taps == 0) {
 		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz) > 1)
 			spl_scratch->scl_data.taps.h_taps = spl_min(2 * spl_fixpt_ceil(
@@ -926,6 +928,23 @@ static void spl_get_taps_non_adaptive_scaler(
 	else
 		spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c;
 
+
+	/*
+	 * Max downscale supported is 6.0x.  Add ASSERT to catch if go beyond that
+	 */
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz_c,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert_c,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+
 	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz))
 		spl_scratch->scl_data.taps.h_taps = 1;
 	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))
-- 
2.34.1

