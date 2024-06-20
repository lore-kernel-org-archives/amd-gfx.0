Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63185C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A78B10EAE6;
	Thu, 20 Jun 2024 16:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMOzwGdn";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C16E10EAE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+oGR/KEI9qsjvkCVmDm3wkmm/bHJ03CGbkgLbhud1B3RnsSdo2xuUFe6mN1i7t8aRiwRpUIbWHJ+OD2oBUXV93b2IIv4ViSK+RZGVr0eTfJ+0NuZp1xluC+KasR3klEGpIKYY6vOEfGFAjD5EsA4j0IgdsKQN+CEGRr1APYqF4bgUrfPue3BDus5HM0RFmEsqOQHMlA3FHTLykVIGMlxQ1b/1g4U6DhI67lbjDKCphQPmgW1rbC/kx6Jqm8Oic0pALSa8kJSq33GcIDBNjidSCkdFj5H7TZN9peIp2J0aOI3rRFyePMWBNY6C//zu2yeTs9Wmp1ixeGY1fpkNu+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVz3vTY/9mcLLVaDmWMc3o2Q8nCWD8cD5I/k7hkpQBU=;
 b=MTReAAQeQPGkNCpJNcFaL8IqnRD5SwMGXYbW1mSgx3JHdPQULspk3ys6lK9ntRVWOw7Xus0R8R5PJ3fbtyDNck+1T5Xw4b1RF1eDVpIST2UnnlOeUUFBvJ/VpW0Q0cVrq6a0U9+KkoaXTZ8sKMjB5GmoSrlqutL8X/C4BTkoyMwcmtcVjQX5g0/oSv+T8SFZeTvM3YDIXZA9Gq/BwmwWX6O8RE9udmmphVWMLEa2RrM4++N7lstVXXNyqMpS9iPrZbEZAVmQBGgnA6rTrwitwV29RjSLYLfNl23JRgmvXziYh+P2m3Jj5j6mWHnfFpE4ubvWzvrAxLMEp8s8FOpDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVz3vTY/9mcLLVaDmWMc3o2Q8nCWD8cD5I/k7hkpQBU=;
 b=XMOzwGdnnvlyTyrPf4yLBnzCcYSjb8x5KP8x/jPcLMflhVz+eAC+ndj3Gj47mYgwRb+wh6K7WUOsSm476rvR7VHGymLkMr3sSNqWQdoR94LfMap+nvUFOsNpXyp6nqtDpePOqae6zp+VVYiEsmbmZgT16/uA9ZRfYlFi/xuDjYg=
Received: from CY8PR19CA0006.namprd19.prod.outlook.com (2603:10b6:930:44::27)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:13:57 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::76) by CY8PR19CA0006.outlook.office365.com
 (2603:10b6:930:44::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:13:56 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:13:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/39] drm/amd/display: Run DC_LOG_DC after checking
 link->link_enc
Date: Thu, 20 Jun 2024 10:11:14 -0600
Message-ID: <20240620161145.2489774-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: cb580583-264e-40e0-bf91-08dc9143fccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ZuH88QWjgq9bBff1ry2ei3g0LYTqq7c+tmO2uC+lygY6g86ZNriJK8mfP4B?=
 =?us-ascii?Q?Wwnk2O0hxHNoHKTFB1wpPzMbLcdLnky1dsvIOWwhYX/9hsPuWqE83MsKIgab?=
 =?us-ascii?Q?JRG4P8UZbA0xzIWtA1vSCceEkk+CxTDs8KE4xT/DV5kh4h/T404mxuhtJg28?=
 =?us-ascii?Q?cqV182OLb0JSfhEEJgGKSG92+aZYzxHQ6sJ+k6IGVAtT+a0MyGrY3Bliwvxx?=
 =?us-ascii?Q?sDbCMhUNF+NDWXF1tRYdcxaVk29HfhOaWLYlm1fQ5oIhBu4iqQ4+8MQaLeXV?=
 =?us-ascii?Q?lvPJYWLA6Qghyoxk6eazkXfWPVenBojLbZ8TK1fQ+506l25J+40Gb4TUi6aA?=
 =?us-ascii?Q?9cWJJXrVqnypoOvC2y5CDv9aixC6xqsZhotxH5QHeIf+DB1R3TK2+cxbVuyz?=
 =?us-ascii?Q?hFCPaaGqAFCTfs1qaE8PCywPWUaoFMo+ChiPrAryHAfnrBfkJT2winRxje6N?=
 =?us-ascii?Q?6Que67N2EF9X0bTrMEdyL+ZKPto0f3BdDNLWMBUH4zzQaq1AsIVJoidRJBdW?=
 =?us-ascii?Q?gqNLMr5KygdxZSUeAgc/EIvajB39G0YwFODTfGoTLusiqaFE6Nor7D4IJ9SM?=
 =?us-ascii?Q?VmhHxzdJiyRdxEaLaVPZ+Th9wE0pefpiHBh3kF/LS9cwef0v3hKiv2XYLVfr?=
 =?us-ascii?Q?PpoPsHbw/IrEWn52lPEbOELQbFG3EhXoHvk3sP+vCDjWZcJckEwwPbr+XxcZ?=
 =?us-ascii?Q?00fDiypXJLvJJk3AwFCgrKdF9KKUXHSRf6A1qlzjRf981/8KJSie635GaW0o?=
 =?us-ascii?Q?rySvTmRtHF3Ft1uJu8OiKqL5b5wDMMcoqF2mK02HV/7YcuGchdOSxjaiAOsT?=
 =?us-ascii?Q?z2w17HEf+m50AmZyIR4CHbIJjdvTYW05/wumm0DmonAPpxoeGxHfGZvrax/h?=
 =?us-ascii?Q?fE2MPUkco9vKtAyfXEkc7S6lMvNRIIhaFqYAd2SNUwZUYrUx7GQjcv2nhIzg?=
 =?us-ascii?Q?CWSUoFT0vyg5smAFVJVEZa00Q6aqcXFKEhUlyxXUPajJGogRoCRE25djSegX?=
 =?us-ascii?Q?qnhQ87GGCQbhoA4BPzfe/YV02NXYYLcS9L1H3ddpIiTk7j1axXW4lZiib5fE?=
 =?us-ascii?Q?bx72QFMH7+ZprDrrZLkVDZy5EA9YmotCw41g5GOsHR5lBnBhUY7StpCnwBdQ?=
 =?us-ascii?Q?RCWzXDg2vdW2Tqkn9f3g/p+qEGApLi104SiBuVtrtX3Eem4txRxRa+xNI1LK?=
 =?us-ascii?Q?mLSq4C4aBf3kUUKYNSGXVDQZQrX/NUnR+vPirKou4IXmR66sixWKpWxzPRkV?=
 =?us-ascii?Q?0TY0P/ucBwhG04PBQPtZfkR7w+d46jji4UvjTt6qcfsTvsBbFDlhAWin+Kf0?=
 =?us-ascii?Q?h2ZcQaZEw6togP2y9bESuVmp6lPbuQ03p56hz3ulV/WSPqE6f2kbBKukPcds?=
 =?us-ascii?Q?ZtyOxs9GCKjKPzzSQkR10ByJTm/OJLmnLq9Pa59ai600abJlZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:13:56.8409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb580583-264e-40e0-bf91-08dc9143fccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

[WHAT]
The DC_LOG_DC should be run after link->link_enc is checked, not before.

This fixes 1 REVERSE_INULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 8073fdae9cb1..8246006857b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -610,14 +610,14 @@ static bool construct_phy(struct dc_link *link,
 	link->link_enc =
 		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
 
-	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
-	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
-
 	if (!link->link_enc) {
 		DC_ERROR("Failed to create link encoder!\n");
 		goto link_enc_create_fail;
 	}
 
+	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
+	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
+
 	/* Update link encoder tracking variables. These are used for the dynamic
 	 * assignment of link encoders to streams.
 	 */
-- 
2.34.1

