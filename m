Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4764E74ADF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B4610EB78;
	Tue,  3 Dec 2024 21:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VWTPn9gL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A6DD10EB71
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni/ZWh9tZ537CJMGOVRSmSQlFaxlB/tDMSuZhkymLQ5IoCMdjCaQJ838sEfKeFRbL97PWlloctrGGP+oWugxIGQoFd4GhYEpFBx0WXDUG8jJmzfSeVQpFqQEIitRsQOki3K37Qq2uvvldtCJPAjRBM9t6Pd6Jm1LO6H24E78ILYl5i6VkswXVnrI8AKf7c3wcKfjE9QCK3G4pagznaWQAuEfzmRKyIj2IJDs+t/QBHXP+d9LI7qJ9pnCrgOEutOghQUMX8uG641w5EpdwRxvY10vmxnnYxDWf4BPtc9wJLJ4hAWT36Uz7BpTy3KoQSxEDtGm9rU/FOttJhqXAh24CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsCs3achck0vSK2a1nrHCCocgp7BNOzz0uOwhNpiQAw=;
 b=oY8Q2/LK9KffG6TIIYVBaSBo0K/FIQK64B2MPzXB0k78/4awDXUCP6RHw+7u5OYL7qARy/qcxETuQBNhrdz7rg5DbvUg9RS1yQoY94SYlcn3UgQpYcQOJuzQhFVBfcpgZCtRQ+IBUmB7DseqP9oUHvQTwdcH2ARRA62fynGDSwPqD/BM62o4A2ETbGMaHAOaFdh7XXTvOMZXlUhc/A9jOKn6qzXPPcAiG2l5hR7cu/qpcaVdqB6O9+BLpWsylesuQajDYGWJIU2Y8D4haape6VPjjD6KOUtPMPGS0u+Jnhwr7JhQQrOP/ZuNhOysLOfqqMi/Oe+NEvnJAaEUbRd+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsCs3achck0vSK2a1nrHCCocgp7BNOzz0uOwhNpiQAw=;
 b=VWTPn9gLNWWxng9pgt/chcaHAe00n+9hhl+kJeTlfNyx4H23OISNqaOXgxrQtyZeX0hN0r73w31Q7U1Xcm/8rO3wYYceW9xfru8abbk1P8wjQ2SQhNunrjplLwvNUsxd1nkV4VEoTRPIVgaVddP4hfIZxLVyMRXN3smtQb5TII4=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 21:41:47 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::d2) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:44 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:44 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Chris Park
 <chris.park@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 12/19] drm/amd/display: Update color space,
 bias and scale programming sequence
Date: Tue, 3 Dec 2024 16:39:50 -0500
Message-ID: <20241203214120.1161810-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: c701b194-178a-4538-646d-08dd13e34a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XsrD2EfCNeVnaNK5RURcIG89QMXNvtjCthaaISsW/v2I+GUQonTf2lMWxgth?=
 =?us-ascii?Q?k0tLtG9vVteqFOgZp7c29ABzXL5WR9iPjBhlVvEmorqwrHFbjqxtvNV8fAel?=
 =?us-ascii?Q?+lxAwhm18KxDJZQMQtURBYN3t8r8ReLOVGjIGCdZzYNPmd1uFktKu3uetxri?=
 =?us-ascii?Q?xrSf1zYnpwJe/oV/Oe9iL0AUslArsgiEcgbLbRMoYtNFInPONA1sHM/65ol2?=
 =?us-ascii?Q?0lmDIqJQ+GdVo6ZWEccta+OAoFaXTARdzO2V17rtLEGCGc6d0d35OvQImuf6?=
 =?us-ascii?Q?5TQLkFWrb/3WLpIpZutHpQhGVkGBEbiPpFp4LNhE/ZTBsuMHEgz4H+tUI2lf?=
 =?us-ascii?Q?9TLXhbxMqopiNL11b1nFZVZdcsxyRP43ywCy3DuCk1ZE6sRoGnyjBCovvhgc?=
 =?us-ascii?Q?he7M9dkxISD4dx5igGVcoDWLRf0vZNELsim20WMi7pSrNrXMvxp6Pehl/uxE?=
 =?us-ascii?Q?Gje0VwxKCiey85id/blxaw6NA5xkMTD4W+3s7LEIi3Z8uvQVmqOW1AxzMlgR?=
 =?us-ascii?Q?aVz5LdvGTYzOmjeB1Qdj5CVEXHyAA4GFc05CCvM4+R5m86JP6e5UU7uWamVy?=
 =?us-ascii?Q?bsM0UTTMF3koT32KoGxhnrh3ayjJrLd1+1s6IonhYRKgtvFORCiOXqwYakHD?=
 =?us-ascii?Q?3OSXZ0U91WY29eoRiO+25BuIPAgBsv2LCkozBvrlRrLnoSbNkg+O+mtOFirB?=
 =?us-ascii?Q?1bM31RrhO2sV3V8zOvTqEEjiOjfA3QQ27ibgO/hs9LvCFh/xLaCWbo/yAnNu?=
 =?us-ascii?Q?rUCp2m8KRsoUTDKlZ5yFegumW1FxMtZroukVwD7U9J+5LFPjA9bngBvw9rAd?=
 =?us-ascii?Q?qTSL4w+myZgPdyLnKvB8vXGizD2FsppxYbKIzPKoKbPA+QI1WNpbUMkAE1uF?=
 =?us-ascii?Q?KBDbZf2qxzHdB5MfwpOrFngl17+qF6M3Gt+INfdByDr21UtK0W99jCYxXItZ?=
 =?us-ascii?Q?JYlYDPCZrZXP7fqsxSCKxQ3dt4OahcxBg6MaPWXxiyJq4Hns8HzGW5ZIb22s?=
 =?us-ascii?Q?Og7r8fsIFLyCOuY4IMwvwuYqGQ5BNZTXoTK+7P6CKx8otOFjUIu3teBYi4Lq?=
 =?us-ascii?Q?Ly65Hc55/mIzyWUTUtyIHQWwc8yObTscm/9eTOM9NerSr1/fxmWJWq4U8R+f?=
 =?us-ascii?Q?42t3f4J5F5Z9s3cczvI8Ma9oO3zWmECEWmmmBY7SbTuPReO5CYxtd7dbGZgz?=
 =?us-ascii?Q?ZkUOu/HES1zUo+Wo2eb7G7Bdf3Cyw+LyUNzm+Ppa+17Lr5KLSxHkg7mfDVRu?=
 =?us-ascii?Q?UHUw6yShAWOP4PWeMUxgj/pxQE0P8rXmgShhNjH1cNMc/uYb4+Q4SByygD+e?=
 =?us-ascii?Q?J0CtQ7+ycZETkVXNzMBq5FUbzR5srHNtV7IHu69OAp6AiGZyUSTxUzR+I+n4?=
 =?us-ascii?Q?rJYYj4iPo8+naOmFl8yMZ9YXsAjUgjYkc1JE9RH851kIckIhdMuVcIro5wY6?=
 =?us-ascii?Q?Dph0HLAHhQdx/PW0SfxJFwH6n/BqZh54?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:47.6552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c701b194-178a-4538-646d-08dd13e34a0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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

From: Chris Park <chris.park@amd.com>

[Why]
DMColor inaccurately updates color space, bias and scale
destructively in dc_plane_state.  This can be resolved by
accurately populating the infos on dc_plane_info where then
translation to plane state can happen as a whole surface update sequence.

[How]
Remove dc_plane_state update in DMColor and update color space,
bias and scale on dc_plane_info.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d3bcb646545c..4afab745b044 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2982,6 +2982,10 @@ static void copy_surface_update_to_plane(
 	if (srf_update->cursor_csc_color_matrix)
 		surface->cursor_csc_color_matrix =
 			*srf_update->cursor_csc_color_matrix;
+
+	if (srf_update->bias_and_scale.bias_and_scale_valid)
+			surface->bias_and_scale =
+					srf_update->bias_and_scale;
 }
 
 static void copy_stream_update_to_stream(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1f9b6147c826..5cdb28a8191d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1527,6 +1527,7 @@ struct dc_surface_update {
 	const struct dc_cm2_parameters *cm2_params;
 	const struct dc_csc_transform *cursor_csc_color_matrix;
 	unsigned int sdr_white_level_nits;
+	struct dc_bias_and_scale bias_and_scale;
 };
 
 /*
-- 
2.47.1

