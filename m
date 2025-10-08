Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F923CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846DA10E887;
	Wed,  8 Oct 2025 18:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VlYXtN3o";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F5310E887
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnYFTtja7LBE+9B0sSc0bDBYo1pBvdCDul9PDPjAzmLtqPBo9jdRjjoV+wKW2c/qtfj2z+PoJ73kj0XaDEBg1PwfRf6J86BQEoy4FnUo1iK1DTWLJ8j9fvNVjEnsAc59SfpB3zPLsBTm16U35yYRCFbXrYAebrh4JAe8SKffpR72FkMMDmPT2Y6pRyEmCRboRU4Q7UgKTX1NrWeNNGCEcolBSw8l2JqC4aHsYfjiynvbPtPE0DkIdpm99Nl+0rk3ktyWUxrdcjUcbh6EuYNWvnI3wV0FqBR7SJePndTiFh7kDqKU5Zom/cdhR4x1Efi5pbUiR2FJaEqiTtHH8sYTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM/Y/HAOFC9p4Vu90GgG7qftPcXvaPGBdcTtg1CrMlo=;
 b=WecLPp7xeK5oqs5tVnx8Eywyrw6xeXtMuTB+9O9pyikWWHFLT+06fG+u8xvuNai57Lw9SoELyB2Tx7jwljAjWEaTNqqZp6C6IrsLrf+0CjwfAJV5knr0LXxLk6BXqYiD0r5ITzx8EEtaVqWRRwaTrXtJDrf8SquQp59D4bRONXXsjRwL0frNWtgfHgXmk0r7TfvWpBimmUBUBEktvxI9Bm+L2i9zfYiyViCJgnYLu1jH/JLEBae9mTCIkYCpoGTL17Gqpc6RU08+7sv0rIXHuEToL8svD0Xk7icuISAjv3PVyL99cnNEY5rQEBj71jXr3SCbr73EjHUoJlFbG7TtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM/Y/HAOFC9p4Vu90GgG7qftPcXvaPGBdcTtg1CrMlo=;
 b=VlYXtN3od11SYPkCE/JwaqkLBqDnJOXhXF0iqFWr/BFUbJamKnfjugh4a7deB/UeBfsqxZmLQMaEbtd0F4S4Pmnnk7l9aiaQ9vG98YjW3y5bCp8VJa0tZXMuMS6MpsXNwWhI2ig1Gr+7CILRWb77+F9fX5Jm2mbZVT/HFZKAEK8=
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:48:44 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::8a) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 8 Oct 2025 18:48:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:41 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:41 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:40 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 02/22] drm/amd/display: Add debug option to override EASF
 scaler taps
Date: Wed, 8 Oct 2025 14:46:56 -0400
Message-ID: <20251008184839.78916-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: cd597cd3-cbba-46fc-18a0-08de069b4ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QZcBv53GDqiC0FtahnlkMOSh32/ZOQSG5B3ULCYSzu6hshwATgX6BSMb+ZtN?=
 =?us-ascii?Q?nHEo/lyV+yWrjK081IqA0H7eSyiJ++JZ0RD6mND1iMzws0iOj7o8rHRh+68K?=
 =?us-ascii?Q?stNhQsQT265XBGOIkhYYCP+Kfcczh/8QU5NrnUYhw1ec6lyxMZI/wBzKHt72?=
 =?us-ascii?Q?f8U0Wz6cT9mwkVQH2BNWzb4OXpVsphlvy01DFeCsecpFuDdtbniPr1y6WuUP?=
 =?us-ascii?Q?7c/TfVkXW2dWCDRnUb6e+VWbsA9Y/A0Z9LwGMANYeSlG+4yNfyM6SLwtO/BU?=
 =?us-ascii?Q?PccV8MlhtjHPpMwvet3nnMRYsQvzrvdA8dFWaSDlrvd0kOdRozYIs8AeTC4y?=
 =?us-ascii?Q?tSF9AeO4lHllAoQbL5fPmSyIU9zvS3fzUULPdA6hJlHFqvHAxYPmzkX/811z?=
 =?us-ascii?Q?V1glUmKGK6L5DpnpFQcabMJIY3ZxMHIU7i65PaWHWosgjfmIIw9m55zUFLNB?=
 =?us-ascii?Q?NpClGg2nt3htjEZ8Uou1a4qCg0c62eXhBgzkXal+JSkbhVe3LZZLdoxZOLCS?=
 =?us-ascii?Q?saZYWLldMc0JCCKLdZEdP8ZG1OtKs8ZdX+prrlyFY6crQBDksuwRmihBDyEV?=
 =?us-ascii?Q?Zbj29pIRNmajQEdde1P7iXVrNl76M2gUsGREwuvMO9E/MWR8uzWBH5LIh2Ea?=
 =?us-ascii?Q?Z4/vKSOwwnruRCcrc8coqufWKdNlueM5HMApNhGIK7UlEZaMrn7s3nj4dwM0?=
 =?us-ascii?Q?o5rH1V5WMMReIj0A2u5z0+HZpdMpB5gZtjd0BP9l1Jp0f3U9bGPQnrzq4eRQ?=
 =?us-ascii?Q?P8amWr9T6uaJDH2VU8grc2urShCTOgEgdKQwCko4UzaHREiPqsbbesiXXWQU?=
 =?us-ascii?Q?16lL1Pl9htkpZC4QIeE4kc802PppSowOmkWJ6Z93rrzEV2Rw0GbCD+EPBrCT?=
 =?us-ascii?Q?8wg7wVXAeqiZ6VjwhcYUAfxxt35vL8QtoAfjYd9iisRIKwzaO+Q3HVXlcRzO?=
 =?us-ascii?Q?ZMx+Pd7VhaE+pcOXsBtdpDYun6KM4WKvBA+/5p8Q7acnUGzD19A3XAYoce69?=
 =?us-ascii?Q?EMP0KImREzxqEBwlpmHaq11anaMfsCW1tdXs4eHSyFk5/USVrf410P474u87?=
 =?us-ascii?Q?TNLZKtW0ujMe0srqKWz1A6rCCwIiptUY00/Hegf5hcO0kK+7kQMAqERkCI38?=
 =?us-ascii?Q?fi1B+oZJLbsF/P48IyUHZQ5qgcPpJfrdP4elFS7jkcRiqxAk5LjMcCvJ18rQ?=
 =?us-ascii?Q?IaM9feZ6cgW8Kv1ALkVkD6bZnIQxo/cQ+IGFJaO21pG88+3R/0jdFKof8Trf?=
 =?us-ascii?Q?ZHWkLqtr2iZFSIX5LNYIaVIKCFQURgqgc06QeHD8YX8J98X/sixFM5gW+PKm?=
 =?us-ascii?Q?3R1GJ86JrAN/GdI+M9upeZzorOV0Mrc4n0Yf4wHvkVWegnr0PICHgA4vKheb?=
 =?us-ascii?Q?B4aiGWyCVHuxbMqb64RTWIoSUo4TiAxHawsK44IfSLFgLThYVPbQLdFnS+YJ?=
 =?us-ascii?Q?P29CCu4N/h1+xb5Wjug6B32qCI/idLF3fPUn5xG1mdXNdu4wrCn96sEJTLTd?=
 =?us-ascii?Q?fpGrlXKttkE6LS4WMfZ+Kck1zrMMW8pPZO8nHH+Fid58ZKG50AEeVtPcqY4M?=
 =?us-ascii?Q?PAnyJW5RazZk+RJehRA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:48:44.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd597cd3-cbba-46fc-18a0-08de069b4ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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

[Why & How]
Add new option override_easf to use in_taps instead of internal
 taps policy for debugging

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c |  2 ++
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c      | 15 +++++++++++++++
 .../gpu/drm/amd/display/dc/sspl/dc_spl_types.h    |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 55704d4457ef..37d1a79e8241 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -147,6 +147,8 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 		spl_in->prefer_easf = false;
 	else if (pipe_ctx->stream->ctx->dc->debug.force_easf == 2)
 		spl_in->disable_easf = true;
+	else if (pipe_ctx->stream->ctx->dc->debug.force_easf == 3)
+		spl_in->override_easf = true;
 	/* Translate adaptive sharpening preference */
 	unsigned int sharpness_setting = pipe_ctx->stream->ctx->dc->debug.force_sharpness;
 	unsigned int force_sharpness_level = pipe_ctx->stream->ctx->dc->debug.force_sharpness_level;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index b1fb0f8a253a..7a839984dbc0 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1018,6 +1018,21 @@ static bool spl_get_optimal_number_of_taps(
 			spl_scratch->scl_data.taps.h_taps_c = 6;
 			spl_scratch->scl_data.taps.v_taps_c = 6;
 		}
+
+		/* Override mode: keep EASF enabled but use input taps if valid */
+		if (spl_in->override_easf) {
+			spl_scratch->scl_data.taps.h_taps = (in_taps->h_taps != 0) ? in_taps->h_taps : spl_scratch->scl_data.taps.h_taps;
+			spl_scratch->scl_data.taps.v_taps = (in_taps->v_taps != 0) ? in_taps->v_taps : spl_scratch->scl_data.taps.v_taps;
+			spl_scratch->scl_data.taps.h_taps_c = (in_taps->h_taps_c != 0) ? in_taps->h_taps_c : spl_scratch->scl_data.taps.h_taps_c;
+			spl_scratch->scl_data.taps.v_taps_c = (in_taps->v_taps_c != 0) ? in_taps->v_taps_c : spl_scratch->scl_data.taps.v_taps_c;
+
+			if ((spl_scratch->scl_data.taps.h_taps > 6) || (spl_scratch->scl_data.taps.v_taps > 6))
+				skip_easf = true;
+			if ((spl_scratch->scl_data.taps.h_taps > 1) && (spl_scratch->scl_data.taps.h_taps % 2))
+				spl_scratch->scl_data.taps.h_taps--;
+			if ((spl_scratch->scl_data.taps.h_taps_c > 1) && (spl_scratch->scl_data.taps.h_taps_c % 2))
+				spl_scratch->scl_data.taps.h_taps_c--;
+		}
 	}
 
 	/*Ensure we can support the requested number of vtaps*/
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 23d254dea18f..20e4e52a77ac 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -545,6 +545,7 @@ struct spl_in	{
 	enum linear_light_scaling lls_pref;	//	Linear Light Scaling
 	bool prefer_easf;
 	bool disable_easf;
+	bool override_easf; /* If true, keep EASF enabled but use provided in_taps */
 	struct spl_debug debug;
 	bool is_fullscreen;
 	bool is_hdr_on;
-- 
2.51.0

