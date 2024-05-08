Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC9BC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7302010FA79;
	Wed,  8 May 2024 17:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p774qaFb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C138910F43C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfyehCgoXbfDqSoNeTHR+66JVfmRj1s2ByEQwf+EWAFloLXx9wTULU9GlFWLFkBcPVNjh3R53BaXqNUc8zAE+isXCpB3Wft9ddgRxEfgLj5tXQ3brlY9kZPP3aZW060qJWSW8BZ4XU4ZWfCWGJpGm3BPdnlo6O5+OajK+i0Eokb5rFCkAOyDYLax1W7reweZ8QgCrI16PkBh10XPQ8kdiF8PmAVEdhSATEr9f74bAFLJrI9R8nhnGlNd+9X9TS5Cazx+8v16KiLIgMayV3e7nsl3w+bTSTgrSIDgsW7XkJnlPKyNFfgeYqX+xuVWjEaU/CNrWX7mDgC6zFQkHDc0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdsyluMmbCzjAU61iQOx7Hup13T3zTnSBxFcCX3A8G0=;
 b=gjg7o6BB2eBkr3xP7tYxUxUsVeeMMQxIz7Py2/7+ONOFxyDe5Lf+RoSah7XAXbOqa23wItiE52GgYUnRnCXcIZE4dLMkEHJ/HSkHomC239oRggyEzgcj2s5HPdd63vPKyg5gkm0mJjziQ9NY8L09WyXsVr6cBiwMKDpEetGyMfEhjsHCh5rWTdL++uazQHjfAlVwiASpA8uC0ym9poxyHVYymV5E8lHU3pDFffjmDKhwojGFAKhfFzHvsneEXQDnVg2d7Jg7dCBsLE8hto0sAn6SSOwFr54QjhaFMCcKGijmsI623FaVC/8/aLTRHn+Dy24BpZv2z1FKjau4gTJz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdsyluMmbCzjAU61iQOx7Hup13T3zTnSBxFcCX3A8G0=;
 b=p774qaFbj+2Hv0Cryww23hbpC3qpocA2pSWXl7wC5D6XJPag4oZ5IDcg71uo1bg6f5omMuh82rcT48uWVHC4rnvYUrm+PBBKJTlKOwCEFfp90rv4xxCurckQXwLk5yqFYvXNc3GN8hfteXHmOI0OhE2bvQsRe7l+oBpi9I2OT9I=
Received: from BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) by SA0PR12MB4464.namprd12.prod.outlook.com
 (2603:10b6:806:9f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:17:30 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::c3) by BL0PR1501CA0034.outlook.office365.com
 (2603:10b6:207:17::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 17:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:17:30 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:17:27 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 11/20] drm/amd/display: Expand to higher link rates
Date: Wed, 8 May 2024 11:13:11 -0600
Message-ID: <20240508171320.3292065-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 96deffc9-e4c7-493f-43ce-08dc6f82bdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GpOGmBAgoMSM6wj868wD5cPCgozAiBotcOJY2lh6MW1UCaqq4KxqKRgIl0gs?=
 =?us-ascii?Q?0coMgG2xocBEcoyK+Jekt5iRzOaUF+S5owI8+m+BbPC0jcvYFsCo95bA+HBR?=
 =?us-ascii?Q?KLT4uOlzT4RwDjHxXL4L/9EY1oQPKxhRk/q3/nJv9O38ICVIVFAe/8Zhbk8k?=
 =?us-ascii?Q?cr7FzBCehLCqxdGZsPdoYRAMXcEblp/fb/nH6TfcTVinQiJGCmcM1eEoBMf7?=
 =?us-ascii?Q?wJ8nBmgOSJX35nRNaGpoKIKV4k/f1NXNXRjPPh6D9fkKw6DXrQNqemqLW5iz?=
 =?us-ascii?Q?1fd4dYGGkOY6m2LOsONocnrBmrppO/oFMlYYdff0IDwRKCl/6m1weQhZahqK?=
 =?us-ascii?Q?Z/XaR11sOd4Sph/dyMU3bsywwjIqpQWbDivO6VT6RvYbyfHg9Wz2DJRPqICp?=
 =?us-ascii?Q?10oP1VqVxCIxbwlRx4qSaHxXSRJKtbdBv+qA24RZpDt4BDEShuqRY9duOFEO?=
 =?us-ascii?Q?O8PDuGqReCBaVojqIcuyl6wHdhS0jMyEc1nZuAgOMtZZet8IHua46PXjijDE?=
 =?us-ascii?Q?O8zyLPcNW3E3EnjAKk5OFd0Z37EhaBzPPYL0m85iFDkp0q15WffS+ijT4oGA?=
 =?us-ascii?Q?P1TrsWO5CVmSXfDvaeeyiuKr8/ZY6Njjymr3rXQVgl/XomhP6yImoTBLVKru?=
 =?us-ascii?Q?OIC2nW0+mynT+d01MbYFcZHpqr/hAxfcGmP20lrdSfG2auQpTQiCsaNMHamn?=
 =?us-ascii?Q?8+snMx57dEm9+JXxn0X00LfGbpACJWzMD4dNYMd4h6aPnap0xdpAgTBB5YTC?=
 =?us-ascii?Q?oHOELlpIJL+ufXW+ao4NLnnNfYxV2ZPCcnHphiSUrojuHlP+eEg6MwxjacMW?=
 =?us-ascii?Q?P7zQMz3PPVCJI7isWM+zi+lzgjMlBrKdK16sP1r1PzakDw2djkRZu3Z/34oD?=
 =?us-ascii?Q?eb1v6rX3ldqqwCTrP+0mXOpG6+Wy2xN46YELDLfmXl5cMvFsvsbL/MpMc44J?=
 =?us-ascii?Q?tzystPwVuA4ME4v3cv8LSAH1ZeltGBfAOk4UxZJOuBIfEc0leewe6QzDQ0GR?=
 =?us-ascii?Q?byHP1Gt1EMLZEUajWK1PZTks/mvhGQiEW7bgnRl5VXBYazKFCgZDjJDUY5mr?=
 =?us-ascii?Q?/MctsYT2DZxONnuVmWGVppz+poa3X/tWqMF1tnmoJ6J/Bboo72xLjJgystV/?=
 =?us-ascii?Q?TbV6fMDAkdYWHod/iIDRKQHwjghM+6eyhDSDiUjxlIMk628TzNWEAKbS+5N1?=
 =?us-ascii?Q?VJPpkpKXGGsN42hXpx8YFrCt4RvqJIjcqhY8Zf/IBOISJMJhkdHVQkBSOGI9?=
 =?us-ascii?Q?E4cTdyiI66G3rTZz0tiFIvutpcpxRIid64XIjnkPECgZOf8wSrB/FdwcI6y9?=
 =?us-ascii?Q?duFdNiwheN3E08JLNrLjH3woum6DX4S7jHvQ4JWrEtS7rINkaQX0I96ocH5a?=
 =?us-ascii?Q?klbEVPEOCzh426EavR7mOzNG6Ddb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:17:30.0338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96deffc9-e4c7-493f-43ce-08dc6f82bdd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[WHY & HOW]
To support higher link rates that sink allows, we need to make
sure driver is ready and perform correct link-training sequence.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 107b2cec572d..8f57b344f09e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -209,6 +209,9 @@ static enum dc_link_rate linkRateInKHzToLinkRateMultiplier(uint32_t link_rate_in
 	case 8100000:
 		link_rate = LINK_RATE_HIGH3;	// Rate_9 (HBR3)- 8.10 Gbps/Lane
 		break;
+	case 10000000:
+		link_rate = LINK_RATE_UHBR10;	// UHBR10 - 10.0 Gbps/Lane
+		break;
 	default:
 		link_rate = LINK_RATE_UNKNOWN;
 		break;
-- 
2.34.1

