Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45902C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A991D10EDA0;
	Thu, 16 May 2024 19:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBw1ZZSn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F83C10EDA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMIGc5hmbyAxH74fyyFiwhocztj0QGGhAnRQOaqaz7JUpsMOhwNDzVgY5aka6+k1OiHRcTRnJvMkvlpXvEKnr6mTNEShKwuCqZLfayb2vDNk7uRdYOVXJAlKqJEhllnzVDFdVJzO8quDlYSc8c4NXErX9c96kXobc0hKvISia3oX5hDXni0aQzX3plHb71S1wkRwysW+FPuDRS3dd4bCOJBznOvloeC2nBRpm8TGHWslGsBe/MQ7mR6/D7I4GNgib3zUdn0zs9G6rgZXh3McA4y/hrPVAXCaqTSPJHnpWgK7sxrPTHzLB2Jb6HrWprDJoz2KFnmW1QIHCWFm5Evt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVzrelos+Bj1R9br3hjioG7RQGjxU0OVIuAo9sUWS6Y=;
 b=Eu4FtIqA20F66us0azoIQe/ecUv48Z7uU+zCwBLZ91LZz0SOqjHz0+CFza/NWo0/HL7UfU/AmH3QVhxhopkwzGYCP9FjoZD+6CeO+dMgIkRK8ONIw+mkQYO+7X7i/ZMbpiC9erbIawV/3No/kmuMlnW74oRwCsydw5pIvzB+XRIh8iN1/z2dSqD2DfcssqgGAQm8R0smoMdV+hPupkYQAfhc+FWmIb7TLWh63c2yTmyxXEFe5+ROWbQE+kNDC0ZvwjEEbY4g7WjYj4VZcA+/WQlgXhRPfxpHjA/2qz0/8ewbRoxQt9ohTxlO6cn1EFdI7LtQGZMs1zDyCiRtIeVZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVzrelos+Bj1R9br3hjioG7RQGjxU0OVIuAo9sUWS6Y=;
 b=KBw1ZZSnmpgQO/gKJebY/1ZT5G3GASe5QgE29niYjZEva02Wuvi1UV++VoNUBQHZePp+korYP0QRdhh4e/zgiJzubdy+APCaZKsNHmLJNCFFQ8NjqGaRDRXAKftOfGQDQAY/JzCMWpRHsLI33VJ3SW+hvVCRSSL+BPrfdANihh8=
Received: from BN9PR03CA0428.namprd03.prod.outlook.com (2603:10b6:408:113::13)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 19:26:58 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::e3) by BN9PR03CA0428.outlook.office365.com
 (2603:10b6:408:113::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:26:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:56 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:56 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Fix incorrect DCN401 comparison
Date: Thu, 16 May 2024 15:26:27 -0400
Message-ID: <20240516192647.1522729-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cecd61-8f84-45f8-ec41-08dc75de26e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qawgZk6gbsIpBS6kOmi0/nx7sn+YkPMMchdESMEk0IPVgLF/qDnuPHtNIQra?=
 =?us-ascii?Q?s3H3DixVkOlFMhu6UX4LDwneCHwJyCj1Ya2XhrhIZ4I5iWVQeuHzQX9kivI8?=
 =?us-ascii?Q?bGbf7Ei4AuVP+uvZUc4P/IV9xcZXEIfQw6OKnOpzYf/Jr2XTepdWanwfBMWR?=
 =?us-ascii?Q?rGlp5EXBgCnlqoWkCNpD6CCirbok+Kchg2RZTMNcAL7Cdu3q0ruEHqDLyode?=
 =?us-ascii?Q?OrsWHyD5En5j1+vVkP0tgusk6WOWHVn1YNVG4QS1GLEDUK6YNEC3hSDl4YDO?=
 =?us-ascii?Q?nDdhbZrkMMf4JjzeqBT8TJqnMrlEYNkavV/N7E3QXcrX+Y+gPD3IzpGIi/xZ?=
 =?us-ascii?Q?BJyKBxsLGX+ZBxorJXUZC+AXQWcFCFpL+Cp/V5WZh2HKDtyqoH72shHMqb3v?=
 =?us-ascii?Q?kDqolu8/ki1vLl15yC+5OEH8RCcEv45z4cdCaD5njx4vsaWAY1qgm8Ix7JD8?=
 =?us-ascii?Q?Y9TiOl4ENMCqwocmYTj5Glv2N4nPnjPNbHadLlKVL3Ca+P9A8WscALSdKgOf?=
 =?us-ascii?Q?r+EwhFuuls9DZVaGbaAg481Tilvom/Phgk92MeDIK7tjgZz+sECmSU0oSdD/?=
 =?us-ascii?Q?HXh+8lV95wl8lEICkNRnNmJ4GB6mNcTXXUBUJv6qTl3SwtcJHgmDskjEDe2Y?=
 =?us-ascii?Q?k6uQi/e6bK4HQd2CoJxyjYFeAIQSKQn/l2jIlFgZa38j8SwpBWJSXotTWQ0I?=
 =?us-ascii?Q?7ftUTIzpMEu23DoGl1ioChPn/wOTBIIVHx0mTFYWkgXavVUeE1uH9jZvwcaJ?=
 =?us-ascii?Q?RILlY3V5uxKxDyzxMFlv0zB84prpbVQ+DuKL7zh4ZbYGXmuQhhKYs8HAIL/2?=
 =?us-ascii?Q?//9gDF0LM6dkdNv/i1SN7u+i5D7T448YJSNfVGELg6j8LF87DOHur7xdQW/M?=
 =?us-ascii?Q?wHwmNywAOiEJBWysXV/3j5HrIaLBMRLzi5SqE19VKrIgIwfy5aqqrp6elbju?=
 =?us-ascii?Q?uTJDGnPJoQUlpr8cRIhHmCcJ7s4YgRJ6l1pCcXAAw0R4HUgtkWOckKRWA6tC?=
 =?us-ascii?Q?97csJlGTxFrxNAyoFzmuL0zdgXJzBm3fHyBnisx0ySJ8RFuywkGzg0PKp9Ve?=
 =?us-ascii?Q?AkmpVUS1LSR2uSz4ioYlKh+LREZVmSts/h/IESfmQGbLQszYVSVcunkWhe9l?=
 =?us-ascii?Q?zAk1swl81ioJ9b9+iorQP0onBkK3LXt0PJKznxt9dQsJf1gcohv+G5MYfoZp?=
 =?us-ascii?Q?MKiqcO2a+xHySO9T3v7SPZTeDObeL5PPMojS207wo++hYIvWvryNuZRf7/oo?=
 =?us-ascii?Q?UM6eRPlt14S9Ds5Fu7roLBINLC0+VJwrLflB7WWuVVH8fhw/YvioXUy76XYs?=
 =?us-ascii?Q?O3ymaCRJ9xGZVoGSZTybuaV4jSBZjD4flCnT4v8OpcOKpPDqrXklP9V0P4rv?=
 =?us-ascii?Q?n6w6lYWseswZW5Ok0OFGhizOFHKZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:26:57.5312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cecd61-8f84-45f8-ec41-08dc75de26e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
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

The comparisons intend to be DCN401 inclusive, and fix it by adding
equal signs.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ae04937e60b0..518164dd9c3c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5104,7 +5104,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	 * specially handle compatibility problems with transitions among those
 	 * features as they are now transparent to the new sequence.
 	 */
-	if (dc->ctx->dce_version > DCN_VERSION_4_01)
+	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
 		return update_planes_and_stream_v3(dc, srf_updates,
 				surface_count, stream, stream_update);
 	return update_planes_and_stream_v2(dc, srf_updates,
@@ -5124,7 +5124,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	 * we get more confident about this change we'll need to enable
 	 * the new sequence for all ASICs.
 	 */
-	if (dc->ctx->dce_version > DCN_VERSION_4_01) {
+	if (dc->ctx->dce_version >= DCN_VERSION_4_01) {
 		update_planes_and_stream_v3(dc, srf_updates, surface_count,
 				stream, stream_update);
 		return;
-- 
2.34.1

