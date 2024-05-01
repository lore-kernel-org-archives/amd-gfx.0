Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B1C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8241130C4;
	Wed,  1 May 2024 07:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g0tU4KTl";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E691130C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cACpHt0IclqcWs9iE3P3y4G57myxGTtaauM/2x5LxtkWeVP5KbAo9e1di62kxnJur1B+zUnTlpcKuxtfNmf3CEeVg1PERI8dqeRC15hSeMfdzjOuhMnJTsP7W+UCg4EdetLxPJPfxGpmS4hji/y9MOXLXlm32vRHQfT3dADp204+Wc6zaiR8leHLFcFblN8ce0iyklHvC29L0ahjHSz15XPmucsZSHQjhnnby1zErxy+Q7/EKCTovjDsRAolJnul1QJcyI7V7E9Al2aF+yH0OSUJX0Vj71dbB74lbWtJQRDRX2tH1ZW5wt8TX+N5p/U0M3ctfZ6q9+NoYJ5Pp0j2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkjNjBPDTcMRGHoV9KJxhrjDvHeCSmol+IoMZivf5RU=;
 b=lxOF/zY2p5g8UOsWmZBTJY70So2wtbNn6jZQM5sGyCYeBW9AnrQwMAdaV96PuPgh6HThwJw+fzU5O8bmqIO8tVdU5al1SNMmOK1p8W3if42vB1JY3XK4mjvivbCZC/ToXxJA4AnX41JTKaHIpOm+Xeho6Ie+5UiMQSBTGoxoKitFP9X87nKINUDkU/DHLN7STOBQ7kTbhtZcx9U9vvdb9bY6/zHE4CVCn/uNAz+bMzxesgZRmsM39rKBCBdV2MRBpdBti3GsAvzEowYJ2Oa6zmgPPLPdwHmnIn/mithqDDA7uPHrTuM8OR/qp9I+L6rmD8bLfetddN7jXyPxGWfIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkjNjBPDTcMRGHoV9KJxhrjDvHeCSmol+IoMZivf5RU=;
 b=g0tU4KTlIdCujtdQZZoJ7WqobptYEsjWeONGV25b9GM4O8uWlgvG1ud2SlZrhLM0Re58PVqTgaiZtG5361kOczHnykE7sTTL+E0RWljk463rehrS++BQsyLp6liz4ofxJL1Z5FbVxr31bj20NPIcgwtKt14tZQKjzdsNerJBd5E=
Received: from DS7PR03CA0265.namprd03.prod.outlook.com (2603:10b6:5:3b3::30)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:19:16 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::e9) by DS7PR03CA0265.outlook.office365.com
 (2603:10b6:5:3b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 1 May 2024 07:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:19:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:15 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 23/45] drm/amd/display: Skip updating link encoder for unknown
 eng_id
Date: Wed, 1 May 2024 15:16:29 +0800
Message-ID: <20240501071651.3541919-24-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cb566d-46dd-44b0-b6f5-08dc69af0277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80WzCNceoWnLCt6AlDDSArRq+qa9dQkCWlMOXkLIXoxH1zKFqCsh4OnVcqZM?=
 =?us-ascii?Q?V0Hqyy6FVLC+YKjiEDh2azdEgN3ifavH2k+dQ3sVKakB+GR0JRtq71OekTjg?=
 =?us-ascii?Q?IvIyJsZJoCMIlnkPSbvQtVNFzQky/cHjBxWffP+Q/5Nlck5NGYEvvY0LGuI2?=
 =?us-ascii?Q?KY7LJmbY+yEKuFX6UIXSfv3lB59BG+ih3twLmeM2kOXF/uyfakAQ8iXN7eSC?=
 =?us-ascii?Q?eVIOHBr6l4K5m2kQBhjzPBm7W1kcDWKsCOGB/Thyqc9hDQUt7gCP+yliJKQr?=
 =?us-ascii?Q?AjXnJ9RQELBKMeio0ukBNR4tWVkCKhT8aAXKQCCdIxQ+KxShOebDcY7c1n3V?=
 =?us-ascii?Q?pD6ertHjmrKWF76uWa0SRK9yzp6k5+s7LcfjByMW4jhCFc5XX2SVsWlduN8X?=
 =?us-ascii?Q?Z++/k4Dm6LG1SxQSjHZk8I3cdomPohn2sS2xJ6mAuNDJigntZwfmmyemM/j3?=
 =?us-ascii?Q?tLhpWoHjojVRJyYby0z2giIisEntqIZgE/hkUDQ1M/W7DDypk76KoKZuzblZ?=
 =?us-ascii?Q?u5imMLMley5hs/DnR6lNoEp9aSCxBhqU6bbBL25BqK19KkdUnmKXIhKAFf1o?=
 =?us-ascii?Q?eJKqMBMwLs2Vpfg7FNfrfeAlr8AayqWYXhxl3koK9l/QJVq/YKjPpVRpJtD7?=
 =?us-ascii?Q?NXzItswnqPDwRPwMdA/QWhKzp72o020taE/UWLR/Zm5aKXKvJ3OIzHLeV/t1?=
 =?us-ascii?Q?fhECuvEfvcV6o0NaiRQuXuWKh09YRRNuJLpKHIPOe6JVLwHQF3Ry4p3zhhYl?=
 =?us-ascii?Q?jxZkTO68tdOjzjqnAc1od4PjCfyLSOk9q2ZW5D9Ob+RUENDG3ry+XCO13rPK?=
 =?us-ascii?Q?O2r98jTIvcHYa67wuaHMGuoXGZXbTZm3h3xQSXH/j5/xPMA+U1hYhArwCtTZ?=
 =?us-ascii?Q?Nh7yi8gg2+czPACA1YCtPkVqA77y1mRmLU8GE+H9dpa/lKej1ZQNdReuAO/9?=
 =?us-ascii?Q?KokNmUfR6tmxbtALZfaL2fP+7kts6/Ur8PFB8MAw+57lCEuAzMc2AnkUkLax?=
 =?us-ascii?Q?nHf+Iy9i1KX6vmpAigCoEOmxU9YXGIM0js0maITUCvk50ZlttRTIxfO8995u?=
 =?us-ascii?Q?7jP4tKR+mMgxSrk0gRLiFeoHci3ZIyKJmh0ktdLPvOMF6KyTuUMKFMDmDezJ?=
 =?us-ascii?Q?x3tfdAdd2emOU+p0wiKrzSelZpORZZjp1nzrV84sqMbcc1WLxC5IkrMSJ43j?=
 =?us-ascii?Q?NueACRS294m/F1Jhy1Inum94qjr5Nb/F/WVFxTlOZg+L2ieXxAPZald9Y3QW?=
 =?us-ascii?Q?a7UTR20nHojJLlNNeUkLFvNnkIlecqPiF5CSthv+lvisYQNeBRx+FtJ0FbgB?=
 =?us-ascii?Q?07UqxTQKabvz/+zcwAEciAQ7tZPWKrP1ZaMM1ssxUebadcNbJvPB0RsGCjtK?=
 =?us-ascii?Q?IkJjwO6peFw1ImEQZsHD6kSQ45SB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:16.0736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cb566d-46dd-44b0-b6f5-08dc69af0277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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

This prevents accessing to negative index of link_encoders array.

This fixes an OVERRUN issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index cf22b8f28ba6..2c3f5d662285 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -390,7 +390,7 @@ static void link_destruct(struct dc_link *link)
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
 		 */
-		if (link->link_id.id != CONNECTOR_ID_VIRTUAL) {
+		if (link->link_id.id != CONNECTOR_ID_VIRTUAL && link->eng_id != ENGINE_ID_UNKNOWN) {
 			link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = NULL;
 			link->dc->res_pool->dig_link_enc_count--;
 		}
-- 
2.34.1

