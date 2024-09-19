Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C5ECF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED4910E760;
	Thu, 19 Sep 2024 18:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JKxtdnKq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7C710E75F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVxwhEGGYEu8Dvgc0HLxtC2S7ir8eydHvbk61nQw+jKZLMP5xL+wnBQyB8Kj1nrG+ShOrxv8Mze+5/6Jd0+Oh1sANo6spMEZ3hrDwM8PeqdvsQN+DBus6ypYOzFupmRRVZ1YGuWwDNDFof+tznXDVUUY+Kohy3NrsTFvXZ/kwwi1zhS4MtltQn87iN4NElsqn43tysH9SVrC2AlbCR/S8MSQCq0Jtj5Y60zpdOFXaoBwvxLueGm7be4axnr37qoIjlvoo0pAE2G6y/nph/mBfPIp8NSMaOQgTzCKrpy7cgcmoBfCeDNyCENbuVqfLjgJrHDAPqwsku0RoO9iWCbC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtVaeM4rfzNVHzeT9DQnmy+cPUDyDhCPbM1g0lDmwRU=;
 b=uKcumfLeFZDXziQ1zgaDpQdNibjCNcJ8MUR8kPqD2yf3sQ3R45GZY0hLthXQ2OrM25SGZ4NonMK3AdZac3bECmkLV/a9iBrJO/hEXFk8ll6jhSVIPJt8BNvDFASMKhHGIz+jyodCCZhPPQFCCkwK0bmzQj0EHZ2OKwy4DnsRgWbuEEzZVtYZ/OS8fS42AP0rc/QiDJnAjuxU5ocee/5GNC0Lav+7hJG5QQiXcrnBzsh7Dyi7mo15Rx1OQsggPIhphfZxjqK8j2HyqU8bXBlMwXR/wUdZv+p+NkqqXH9cACKlVAm01TKnXO+Dg9/Fd27JYEWa67n1ir6D6WenT56yjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtVaeM4rfzNVHzeT9DQnmy+cPUDyDhCPbM1g0lDmwRU=;
 b=JKxtdnKqz7fNDP6oCaQoDVDZl4mru9vR2iBPtIseDwFxvcw0HVefWT0qiHtCVAzJmB++hLRInbwsuCB3QIFVekPw22bGI6Zva4KeKKeD2hbHygGtZJZvlf4b+d8X5UOc0yE9CukVD7DUcGiynG0H80Hosr+OR0/CgzhYmQOuMMk=
Received: from MN0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::32)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 18:34:57 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::d) by MN0P220CA0003.outlook.office365.com
 (2603:10b6:208:52e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:55 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:54 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Shunlu Zhang <Shunlu.Zhang@amd.com>, Tao Huang
 <tao.huang@amd.com>, Ariel Bernstein <eric.bernstein@amd.com>
Subject: [PATCH 09/21] drm/amd/display: Change dc_surface_update cm2_params to
 const
Date: Thu, 19 Sep 2024 14:33:27 -0400
Message-ID: <20240919183435.1896209-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: a66319b2-62c3-4acf-05ec-08dcd8d9c35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c+fn9h2t98OFkeKoVmXhbSsstgqz1HkCGLv+ZsJ/KfWxtKVlt4QTLLIE1Xgd?=
 =?us-ascii?Q?24O6q+M+OBKSanfJtCr0KsroUXQKrGK5lDoFmI2+B9BccRuIDlaxwwKGIur2?=
 =?us-ascii?Q?QG2dz3liCAvOWGW9U4/PNYM0Nj/36X3vQh4NgNnv0XpxtRxWmadwr2D0ZZL6?=
 =?us-ascii?Q?6ZNeGH6kLxO14Qgcx3uiQJDAVp/j4BkBpHC1wkL57IaxYIp7Wwwzd4y8Di49?=
 =?us-ascii?Q?laquMNhz7vq5goMIMdwZ1O0eCgiEf4Q9LJ+X7EYEorzvQHGRfxBXAOVWq/rU?=
 =?us-ascii?Q?FvTG6Niped4XsV+59+c/6IbVfMJnDUv0qGJlazmbshlNdwNyB6rS8vPKocGx?=
 =?us-ascii?Q?hsU7yMn7U39iAfPU6jEiMBbuxOznAV6giy7Ve45lMbpHYh8d4oHRPDf4C6JL?=
 =?us-ascii?Q?EvZNtVQdhlKFEAGb6TLGrzjt3POCFBLmq/MWmq7W7tWbbDcpiEx1Vdqknko6?=
 =?us-ascii?Q?DcOwykX3wo7nWuJ5pd/+pt0LPK95mPVZHHcGyLNzVDcrX3SYKEbbLHXsSDVc?=
 =?us-ascii?Q?YS0RAoSeHKiwfpSSBMKlibXbxINC9q5uIRW4uRir4FTeY3xt+idiEqHObNmR?=
 =?us-ascii?Q?EsGl5qwEmKNdGKyiJM5Hl1yDFFgbRNUBIhEFosZsxqA3IwU+7PxReu3PtAN8?=
 =?us-ascii?Q?8g6jKIv2+ktbk8snfMQoxVVLzAMTL5D/rCsO06FrIyAUNWaLNFHUTmBWLapb?=
 =?us-ascii?Q?5jUhUYOq8yZWbCTuCbudMTBS5+aVBAKdzsWeAhVRTL83OZDnOOmXMCHXX11q?=
 =?us-ascii?Q?IwTEcRMcx76Dlj5y8r2SMhhzaswnnjZfiyK1q6+MJX4MzlNFcse0FOV9YcHo?=
 =?us-ascii?Q?teEi1kZirU/i734xBKAFwnJgiM/qCaTEx736uO006i8ABiUKc+i0CmCg2jpI?=
 =?us-ascii?Q?k0NWQrATUTYEiNuVkWyJgRQKX+NgwJ62noLRWE3cibnVNL69rTEYgcqR+dho?=
 =?us-ascii?Q?+qf1A5Qz5ZXNYiu0IO1aHjkxNc+QxnlReo63LMxB6Gnic5HEYq1OdBNs7Cru?=
 =?us-ascii?Q?DojpSy+i0J0bnbBc3GejApmaSDN+iSa4Uf+6CvxNP908d4M2zPE25VcQFO4Z?=
 =?us-ascii?Q?Y14vRlMWDTh7JR56T70nz0fzWIHK/Be1nsnv1zE3D5cHtuvLIwi5cRAtys4T?=
 =?us-ascii?Q?fryPGzxShu/w34dhNEOyVEP7Cr2pJTTC7DnDxQNCYdZnQ6R2jipV9Fv568bp?=
 =?us-ascii?Q?RvDm4t6fKYXaWwsvP8t6S+wamBCP9KtJnj+ZoUUEZn4Ez8R+ezIqhNc4zBJw?=
 =?us-ascii?Q?IZnbhbUBZmUYEJ2Bjj3DRSCrqG6UUYldfO21ndLHo/8fzTApA2ZgBIwSB6dJ?=
 =?us-ascii?Q?ZvEDWHpfdssKdP5yoLJRyu5D+/1+Ykv9Nbh6NNvc/u8ULOtN1y31+cIvf6+A?=
 =?us-ascii?Q?a+bApsvL8NkUssTgMvY6uMh3kABqyKBur6UlkmtFvmwpcjrc9yvC/JBnZW3A?=
 =?us-ascii?Q?xbIh9JkknMracdED9AE0uN6F3GAtZUI9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:57.6102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66319b2-62c3-4acf-05ec-08dcd8d9c35a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

From: Shunlu Zhang <Shunlu.Zhang@amd.com>

[WHY]
cm2_params is used to set update_flags.
It's value is not intended to be modified.

[WHAT]
Change the declaration of cm2_params to be a constant variable

Reviewed-by: Tao Huang <tao.huang@amd.com>
Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Signed-off-by: Shunlu Zhang <Shunlu.Zhang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3992ad73165b..7b164e8fa104 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1513,7 +1513,7 @@ struct dc_surface_update {
 	 * change cm2_params.component_settings: Full update
 	 * change cm2_params.cm2_luts: Fast update
 	 */
-	struct dc_cm2_parameters *cm2_params;
+	const struct dc_cm2_parameters *cm2_params;
 	const struct dc_csc_transform *cursor_csc_color_matrix;
 	unsigned int sdr_white_level_nits;
 };
-- 
2.46.0

