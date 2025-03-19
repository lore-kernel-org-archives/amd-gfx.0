Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97908C36002
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7C710E566;
	Wed, 19 Mar 2025 17:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ucD9G+UR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B918E10E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXFkQ2NECMMzX8+CG6xfJyM0rxZbDv12qUey2zmMmdJVk55M4TJGj/k5SjH4/5Ka8JWVcvTwepIDwZSW9eyBM7Rf7NW9NmINoijssn8WQUIGyZU/kdfEnMaL35WsuZuZxZig2w6gTp7friP5SBdFZUeuY5rPBSlfr8yCen/mliKOl9t6FQIMCB6UWCLBi184bwl074porARIYwKfuroFijW8jU9z0iN3HoMC0KOh3eMg9wbyri2ID38dqwZka828iafdTl9egSNOsR8bWkp6L279bVHtDiHERBdwN39RrKLhirORlvhMhcr/5j8lLDZ/wSL/0Y9WJTwUxKgzUe/PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlPu8afZqVPK2ExGObHFlRhJ4vobeUVdNU7+QW6YztE=;
 b=PSi9uP5oKMgXSIVZIk4XwoWZiHYUL5lVr5MtFclgL2pl6yxKu+6vOKDhsZ6Y2SCxIU3BU+PDu0UlbOXNHJL8iMC6S7ZDH+ZHt2upxTcse7pJyneNK+oUFhYM2RXCt5COfIcP/kT+48lGCY9pfHUVTg4fGzCy84nvwNgINfpuaMJ4F7jKVuwwwf7IvhCqqIO2XSRjOsJaEvvLEwR/pnY8voqvQfPBtnQMmfos5FiqU93WU0jel7QBe58jkb7KDgznkKIGu4hwScLQEf00s2E/N7YXRrkMNvm4bBBoaynUH9a7w0eRdGfKysHfFFhF+uY0yrlSyFG2hCFBgSMNrvCg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlPu8afZqVPK2ExGObHFlRhJ4vobeUVdNU7+QW6YztE=;
 b=ucD9G+URXxJCN8CMYv76+eEVvT+GjsTb/eLChxMP8b4ecw61Vw8BDFmTQnuYJKZJi0o/i1BPxnWRnh9qb1eDEUXK5bE6Z8zG9QXwwzKd/zJpIzKUkx6TXNmxJmkrmUNZl0jTJuJ4nqNbWr6cmzPzm0daBXf+4tQFhZ2Ke3fqpEg=
Received: from CH3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::26)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 17:57:30 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::7a) by CH3P220CA0011.outlook.office365.com
 (2603:10b6:610:1e8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 17:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:28 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 14/16] Revert "drm/amd/display: dml2 soc dscclk use DPM table
 clk setting"
Date: Wed, 19 Mar 2025 13:55:19 -0400
Message-ID: <20250319175718.2578234-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acb26c6-ad7e-4457-2ba7-08dd670f84ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0BEPoriJSjeveTOefLpwYm0Jc/5HJ9nqGe7AyZnKEpCiFpYVyYRtRkcPw88q?=
 =?us-ascii?Q?oCZdjHtq05nt+maZ/dUdAvwk4ybL/OSoKeZXhIseRUD2bPQROThm+ngHxR0D?=
 =?us-ascii?Q?ADTdXg3EUSG+bvb1nvil+LonmE5KlfoBeqbnzY69KzNk/8PnYLBHqanHGN3n?=
 =?us-ascii?Q?QTcaGhRskCQZvtsEvy5s3F9jnDTB+YJ3fxEkU4PPhW0QBhIKSr9CsfeCSUTc?=
 =?us-ascii?Q?o5Q8B/PYD4BTydhQJ5vfAgkNYUo8NKYfetNMAmkVkva/31F0FdBbubsajE6O?=
 =?us-ascii?Q?aN0vWdakBB7bv+CaiTKnufBJUvORCshmePlgsAm4jE9fD48NRyhbGNGWpVfC?=
 =?us-ascii?Q?e5B03s01lDxZ8cH3x5bzbOwdQvSMLSQLYWD269/nLSsBaatbnKSWlcDdoWi6?=
 =?us-ascii?Q?W/uKI/StZf/jUfIxuGaljjcixSUoIpfsSkLLie3njSSyJZMf3sLUaRiMZEf7?=
 =?us-ascii?Q?jWQ9bA/m83G+l4hXW3/eO5HcCa9ZoxD+sXBX79XGvROfN91OBYezUi0k1jnF?=
 =?us-ascii?Q?EPejv1xCrXF08Jpi1iWWY/I9Yxv4nVeCAiqL449cy1KSyBYR7t7agT5603NJ?=
 =?us-ascii?Q?D0VAKl1KqhLhTfDLby5ReyoCNOfjOcj1V1H8ZdSmatTqPs9qc1ZnbhcW6mBL?=
 =?us-ascii?Q?gOpf5bd09rcocQHTq/bEXRApycsMgrmaJAClv9KkffbuaFt7GLdcfnoVQNMY?=
 =?us-ascii?Q?p5lal6LiiVdIfKaO+KL5FGzfe+RIuBHlLo/fmdVzXNRj6DbZPWFeozlN+C1R?=
 =?us-ascii?Q?KNkLMoOmLzzTeNnMAd7WlEUr6IFb5Hf9n5gongfhG1D7+KusHsEfM8L/s799?=
 =?us-ascii?Q?2TCXkDS9IZtknSeHk2YI2vUz5a3+uvognHxKu1zPiNdRhApILwo6Gu597fUU?=
 =?us-ascii?Q?E2lPVEXJbeAPrZC2n7oxe6qAYnNDlTczSuROi99uZ9Fn+b2psQ6c7SubVkV9?=
 =?us-ascii?Q?ekaANLUPg8GyqBO5jCLxyLBE2scKZOtc7EBmGFwCjmLkwtZH10udaCXZ6A+v?=
 =?us-ascii?Q?yYolCNZb5eNCsF22/pLeiRanNCWRet8MFC5/ViqX+pUkm4ygay+MbyuMFt0f?=
 =?us-ascii?Q?6SwaEsU7pWgmYSMffI6Akv485g3dioRwYWjyCeXHEZg3dpxMBn3BDgkwlcGW?=
 =?us-ascii?Q?EviZ79dkKPcZlLd4OQe82q4f1jE1b5SYxiNrama+HmxfXZDMVNetg3fhUNJN?=
 =?us-ascii?Q?lg3nWx/c/Q1bDzhMWr0XtXEUdx/k5PR8dEtkGdLF3nkdFWs9upttZLg26cWi?=
 =?us-ascii?Q?jB/JGpnXTw/G3DgFKBbbpO4VJx1HdZFAdFl+9v4xVuZ7l5pTC+2JypO8XkGT?=
 =?us-ascii?Q?pRW9iN6ei9MGoCrz6z2+na0ilWP49zALla8Ncbhj6bt40dftcbYq1EmFOfnB?=
 =?us-ascii?Q?gpTIuV7NZ5YKcMIr28qqu/eHVI9NkXrLmOfhWDX8XC08/k57RTBghDlDsooO?=
 =?us-ascii?Q?Hlip0c8o2KZ8VJK6exSMNu4I1r2CVnTriiaWGR+VOOVOZnynyi4IXZdyGBjD?=
 =?us-ascii?Q?Dn1VsegxYYQUAS4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:30.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acb26c6-ad7e-4457-2ba7-08dd670f84ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
this dscclk use DCN defined per DPM level will cause a DCFCLK increase.
needs to follow up.

This reverts commit 9932ab57776fa0168b702371ff5e2881c026f353

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 70c39df62533..2061d43b92e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -590,11 +590,11 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
 			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
 
+			p->out_states->state_array[i].dscclk_mhz = max_dispclk_mhz / 3.0;
 			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
 			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
 
 			/* Dependent states. */
-			p->out_states->state_array[i].dscclk_mhz = p->in_states->state_array[i].dscclk_mhz;
 			p->out_states->state_array[i].dram_speed_mts = p->in_states->state_array[i].dram_speed_mts;
 			p->out_states->state_array[i].fabricclk_mhz = p->in_states->state_array[i].fabricclk_mhz;
 			p->out_states->state_array[i].socclk_mhz = p->in_states->state_array[i].socclk_mhz;
-- 
2.49.0

