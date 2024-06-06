Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB94C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02C310EB0D;
	Thu,  6 Jun 2024 21:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4hKpwIiZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C2010EB08
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PABDOfyn3ImYz0Awkff8H8H8xENhcR4D4muTi1fJCj6cD5sW7/E1N//GWsgMYFkRL/rVxOM/sfzHS/j51Xl4jsY4uM1n0KZ8iMskwweutEcQsNwExvcBoT1FRSKf/aMj1CmGsrjTrrqPPZ2E2l2KK18xjU3FBaEaUJGyXapFAa9VhxffcmoBKReFXun+jZHPgiH/1cKNwBnROxmP/62F8lBQ/5282OO+q5Wr+4ELq8HRKBkRkJft/sMgInvieO2oIOS5Xhc1tpicnj1gdmEceZtFyHEj77ZMTL/svZCPQFEAY59YRT2NoHlLrhHmodohE979sM0ywth/caGVMGKRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbdb9bObn4HvCRn3G5lGUxseFG+Zdh2G/PcVVZfVDiE=;
 b=J9Xs1gf9k5/zQ1SBE83d3+pvAgaEOQQcLCFQnTGIqx8aMu9hBrJCOcTiX9lWHsFC8XH3dq/lj7qm66QFo4Eqx6rhKwZpkKeDtGr//DsaloteZhrDBYAqZ/u+QXJok9lOrsOLNE62YDTWEaY/Dds5Zdhyn9q5WlsYxLaGOaFE0oIv+anbeyT6hAvJBoMa6Tt+slkpmgMfo/+zVH2+A0vnXrUV7glZitkWA3/0YzxiAXw5k8MqOhD64qQsVV3hTFtLuvJr+TrhFDtU/7vLcX6uXwIeyI4q9GJrGdqJbTKj5hRhhu+8ED7L1SpIpuiVocXKoP4yY4ODvX62yvFRCxoMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbdb9bObn4HvCRn3G5lGUxseFG+Zdh2G/PcVVZfVDiE=;
 b=4hKpwIiZDNRkXhxOdK/5IVQzalmUt497tuVgWarIGbIdAoUSZGjDmD7QXannFsB7yMQQmg9RRoHP1WahKk7bfyaH4qUaTd22JqVOP0r0Wv9ZqCs2Du4oZvTnJwwgde7PxfGbvi5C5eNblxwOlJO1/YhK3b7BOpfdnTo7VdL8fvQ=
Received: from MN2PR15CA0042.namprd15.prod.outlook.com (2603:10b6:208:237::11)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 21:59:08 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::c) by MN2PR15CA0042.outlook.office365.com
 (2603:10b6:208:237::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:07 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:06 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 60/67] drm/amd/display: Add null check for phantom pipes in
 prepare mcache
Date: Thu, 6 Jun 2024 17:56:25 -0400
Message-ID: <20240606215632.4061204-61-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: d2168b59-6bb1-486b-696c-08dc8673e3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W9nrcA0H/bFvaMC/iFWikOvUy2H8Uh/8JLS6TCBjPJi9JDkTUDRC1LI0aYLf?=
 =?us-ascii?Q?NCe3jMO25ZceMRvEVOQqzz1hkzIrO9hNpa0SbH6D6V5iGQOTDP22lqVajz9n?=
 =?us-ascii?Q?eoukgIoFtm36lmsxq3tEzaGEK/l2Nxt6dRI+5VXEtXTHekX1jELXTMD9MTCP?=
 =?us-ascii?Q?yaQdNCuMElLngP6Th/F0V6u6Xf55k9naNAd8ohw/3ZzNNgnse19LURN8rCht?=
 =?us-ascii?Q?WIi0G5AqZDBlyJYclUxz0qaaBWvct1CeIIxN4fdNj8jXwlmDlZGkOqRWtDOx?=
 =?us-ascii?Q?dv5uu0/HtiyOVER4Z7PPHYiKhxUbLh40JBgFwXxdqU8QEAPc4nLNizBBUbG1?=
 =?us-ascii?Q?WyPYBtsHSnGBPsdXN2chkSqPD6ywhcmfr4rTOmGOP2/1MuaxBVXdDEmUI1Hx?=
 =?us-ascii?Q?2CKsGQweT1ypK5A8PZLu1gFFVkSd5LlwJAannSuuTEVK+Yiso7FHYlpt5inH?=
 =?us-ascii?Q?kXGYJCLpcudJrc98PHifT+S1U0fVlfLssNOFYt1XwJOeOfPbonSduVdNfUQy?=
 =?us-ascii?Q?AFUVI/8sswv7gsy1kbG09Tno67ta2MImyann19Dj/gDZrRExf1kZuGtGz2r/?=
 =?us-ascii?Q?dHr0GJKpxGCDDnVidv77fALGLSyr+InNLWD9+faKh/FwFWFmb2Xwegm33GtE?=
 =?us-ascii?Q?KFa0gydOjpDh7TE1zIsoSdjwcW5SGoWQG5Szuk/JzjFyMMYq+bsIwjkUMrMI?=
 =?us-ascii?Q?Yrk/78fTX977JBR07TrCSqu4HunasNnZ7EWhCMOpmVGofHNiuTBmWMhSqlL0?=
 =?us-ascii?Q?yPFqO+ZcFHxMbfzuxxCU7JviGlZvqpDTsgXNlxHlUPdUq0avaszPcY7JpPG9?=
 =?us-ascii?Q?EY1FHu/TQWhRRx5Xg/t0tuipw8pUuS0vXfnZt3OykK7V6tJ+1THCdJ2sXqNr?=
 =?us-ascii?Q?DYDYuM6wVWKV1GI8iB60Zj944YNU6cN9Nn70Zz/NZzls5amHSN3Y3/iSl38n?=
 =?us-ascii?Q?8A+NpRQOzsX5P5xyK72UQbhIOFdY3BVukRD0ZmJ/HqUWTD5Vmm7agBKP+Ox6?=
 =?us-ascii?Q?xV7iePM74Md2NFU/Wjj6pMBdCtXyR/gOdYvm8z+pnyjQ9Sa1T75lRJFonx93?=
 =?us-ascii?Q?UvNFINMwPYrzNXUD1tu4xciqSMQkeeru6WnHQ60UXxfkh1MlGlkGJxNZOI7u?=
 =?us-ascii?Q?f7mjI9vYjO/Sinku9hX1q4zMFcMjVfrpLWDKg2UUZaP3nxRs97/8VyzsA1FY?=
 =?us-ascii?Q?m5Gyx/ewFt5H25FSXChJklTWtIFEzMnevkn/KjzbzJgFICAxOdQlEO/bZmSi?=
 =?us-ascii?Q?PoNgAlLC3QGJfYREUzrPGZ5cJf5YDx39CB1/GwFf88dBp9o3p8nPDhIoH/3c?=
 =?us-ascii?Q?javoi7xoeZiJw9vQe5tKWzkm3U3JdvbZIrGc4TVKlnvGT3bFXXQdsCV9NYHI?=
 =?us-ascii?Q?tO13pkrqt7CB5LlU4Cb+j42hOdh94r8p05yWdok4jUkwwhm0eA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:07.9909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2168b59-6bb1-486b-696c-08dc8673e3c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Sometimes this function is called with a partially deconstructed phantom
stream toplolgy, and should ignore phantoms with no plane state.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index c4542c3dded9..b442e1f9f204 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -325,7 +325,10 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		}
 
 		/* get config for each phantom pipe */
-		if (pln_prog->phantom_plane.valid && dc_phantom_pipes[0]) {
+		if (pln_prog->phantom_plane.valid &&
+				dc_phantom_pipes[0] &&
+				dc_main_pipes[0]->stream &&
+				dc_phantom_pipes[0]->plane_state) {
 			mcache_config = &l->build_mcache_programming_params.mcache_configurations[dml_phantom_prog_idx];
 			memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
 			mcache_config->plane_descriptor = pln_prog->plane_descriptor;
@@ -368,7 +371,10 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		}
 
 		/* get config for each phantom pipe */
-		if (pln_prog->phantom_plane.valid && dc_phantom_pipes[0]) {
+		if (pln_prog->phantom_plane.valid &&
+				dc_phantom_pipes[0] &&
+				dc_main_pipes[0]->stream &&
+				dc_phantom_pipes[0]->plane_state) {
 			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
 				ASSERT(dc_phantom_pipes[dc_pipe_index]);
 				if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_phantom_prog_idx][dc_pipe_index]) {
-- 
2.34.1

