Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17542E8B391
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9450C10E238;
	Wed,  4 Feb 2026 03:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwtJ5yla";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010048.outbound.protection.outlook.com
 [40.93.198.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8084710E238
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovnWEMe5Pbws8G/L3EbHOzOh93BbXuYHs68zRBA2KdPx0e34lzu1nz3wXEis9/bAqEr5WV9M5Ej75DaBCqvmdfFzxnd8ul8xM/qwYWjRS4/UiK5RZG1TLKe/RW44v/Vtm8zymB77xf9NoVt0EgG6gIWKDcyifs0UdpmxN4i3WTNcFZbyxPV1Osd4N6urXWjCvXtWBMJOQr1z8lqe16aj5UM/yFo81J9Hy2/gao1cTtn+FLJLCQksCmGd+qNpObRvDD+pnvWe2CxH56mjuCWec2QL60XD78dc7KFPf6ZyKNRA7FYGylBfbpnKS0zf9MBxZ78O2FkpesRyYHkoby+yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbtGD3QTR5JNMaLfDFoe2Dp/H094AP5urnppFGGtD6M=;
 b=geiSSxE8O5n1BqIe5NoJXzeH7I9MfZKgCRh4496Y2KJm568fmLNiob4kfg2Xv+xrPoIN9rerdmnLBBMdWSLvcehwkLvnzOKxU1VnwY8TVyZZKCRn93GEDy0CjtJgvXj0TAuEQiqbxAGmBKam5lSlOFMbG2NyLFwvHKUUPRILi9PhVf355CvXyFtBJdzoDxjtyIZ0c5fA4jos+WeOEbOGr+ddtqPcBz397Q/OKBIiW+l2rufa0a6TYMHSUzkWKo62Kxp41aPRkmMECdmSpycBumSWDd+YClmZjPlYTqVtCjs7VKf4cIa50uPLaOkDIWRzi3x8i4Wxm3/ObRb21pn20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbtGD3QTR5JNMaLfDFoe2Dp/H094AP5urnppFGGtD6M=;
 b=bwtJ5ylasc4arscbbD1oKjF7mS1JD28chaBoDCFFOCpRzz+uo1qH4yyNAqg1YjF/Nq5j2QdIgperr2+UPBR8j2AebxpMwSpB8C9pFmjStUb7IXRNB3qE+WCHyhBfiz3SEg4SqKEjPFZ9MOoWc/DAIJd6V3w+cDp/mMolSk+sHes=
Received: from CH5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:1f1::7)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 03:47:49 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::51) by CH5PR03CA0006.outlook.office365.com
 (2603:10b6:610:1f1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:47:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:47:46 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
Date: Tue, 3 Feb 2026 22:47:32 -0500
Message-ID: <20260204034732.187325-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: d45108e9-e38c-4a3d-2439-08de63a029eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xHklYmhktiX8gxgXL+ItZaBuGUX8bRaSG7+jGRkR8dNrxViC8b19kaQPqQsV?=
 =?us-ascii?Q?1pAaGTSIeKwvERGEhuxInlbLObvUJroOjJYkpL+sISmufKKCJNHMF+wUYnh7?=
 =?us-ascii?Q?i8fkywQAJj77sMWT1vH+2zwiEDqhKFUooOGVkariSZUsmyHav4550K8e34y/?=
 =?us-ascii?Q?2sAw1ajqsTiu7Hnbj5yqo5Td83IeJiFe+AGDFjVG1vLk1mFXJFhNvBRzW9Pu?=
 =?us-ascii?Q?MQsw43aGdpwgMtfVM5AZ3wbh5KeXZUKzwVtjVEGYIxOqQ18QDV5n1UiJeR1j?=
 =?us-ascii?Q?5wDyDkq40hTuNRv5MFuP79nsdSHKuMDTSX2gkjzofDYhuKHIk40CWgxfSTJU?=
 =?us-ascii?Q?N5JEbJFQhDZ8xHhPelbkUfDhNi4drM9qCSHrkKlATCKV3nxRldGHc7MjKTmy?=
 =?us-ascii?Q?YLnCeTxTlNt6nhrGesJXpk8xeeaosZExeZkUD0YSaPVLm8b5hYGuAgg/d3Wz?=
 =?us-ascii?Q?lsyL4Ai1Uzkcp5qmIzPj3mLG2hi7WLF4UMrCjGlYKs94EPMZUGlBBiIO8Hww?=
 =?us-ascii?Q?mvpNLAWBfHEKxIUjH8NzwkG/xFWApsbnxJ23uyJyvT5iMLvjZoHk2xu+X3gT?=
 =?us-ascii?Q?KeMMTEeINmV5kEOkV3rN6ISMD0bHxiAU4zWRMtv7yuNpdzU9j0Qp6Q3whcAZ?=
 =?us-ascii?Q?nIV7gmdKfKDFn/Fs+LcJOceaQ7VTHE1nXHBdnScwLrHib6YmEAHmWrxrAbNz?=
 =?us-ascii?Q?wBaxxPfpBSP5EyQxzk8HZ4ltK/n0zouUHVEh3jMcvyrhrcYzGi4ZbCkvwyRu?=
 =?us-ascii?Q?78fVfpg66HQ6HqlkJ3kjH5453yYXVcymqeJuXM+/f6n9IF9NiOFSIhl9exkC?=
 =?us-ascii?Q?D7Mxf0MtjS1eqZ8OV4dipM0vrbEMakL8VAQR90BJKqPoqZewXgXuaSb6zZCw?=
 =?us-ascii?Q?4trN8rqX3GQxBTFPxBkMOk6sj8sJdb+Vgpug3YLxM0TJot4Oit5h/N9jx7JS?=
 =?us-ascii?Q?fnMY7SkfvJ3OABxG7MS5elR9y3RPL2WutCEQDbd+5rMxHy//kB5lApqexoUw?=
 =?us-ascii?Q?N6JBS81BXYY67T20RNyUZ0Y7+B1xqZHzGXuZUN19rC7fwVBPH1j6+DzgnaYj?=
 =?us-ascii?Q?mZCMaVd0fMF9bLR4RhWUAVA/svA4RCjplGKBWwUbLiCeAx5I5KaA+tnCBEo0?=
 =?us-ascii?Q?TlMxUmGxbGNQV+rIMq0vxLTCRvyhCQx0+EZuweoRUzNySLDmdlxLHajBCvoZ?=
 =?us-ascii?Q?38dwqyRDLz0xOJVXROKMZskt36IwL4UChI/bkvvEYCSYkfxPql+yEkpC91yE?=
 =?us-ascii?Q?cNv2pYSBD1Ve2Z8GhnW2GrvF3vds5ZCKHOuR2YRXW6ABtwktisozLDupxFq4?=
 =?us-ascii?Q?e7hO/RVCYxvPcZootght4QAs8KkX5AYSGkYLzZWIUP61NiLCSuLz/44xh41H?=
 =?us-ascii?Q?0Lg4D15/aGU5Fyw/T3d2oOpr4n4RCu899DyGP7JAj2hkpxMxAq1Jr6WWfKTB?=
 =?us-ascii?Q?bCczfDaMkMkiBhYLdLhaAPQSMbh7wzD8BpLr28oVIM19QmIvqYWgKzDObkwT?=
 =?us-ascii?Q?GDiHBT5arhSY5SK51nPg4zHTPpwA9dTSTAL8AsawKFZ2kHdXicXc0mqSlNKu?=
 =?us-ascii?Q?t+vjK+Eqxqdc1ggWWApvYnKd88+lv6HNRuSBNIBWoOi8PJP8V3PKBZmtUNr/?=
 =?us-ascii?Q?kvRMTggXG9F1HL1LeinSa43bHM1YrWDZ8Ps+RAu4CSE3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OS2XFRLsK06sdzttegHzW1SdH5DlGYrvvurCUDS+oSjb6H0ZXDxq75GMhph802LmhKG5LqXuzBTIAW8pXLZ8qJdBgFO1Vc66bDwygKF3Qj1VsGtDnxiFUNzW0idxxJYEskCW0urx8CT0lPwJBt1i/O5kyZmoEFpc1MpFtVSBZCTBOTsPstxK1Ya9BFJ7M80h+HPZsW1KrQMoAfFntko0ID5RO4232rnXE1ljns4Am+gbH+Bxcvva9kPH30pQNVyLdS6EzcyhGZ4k96VWiBF2Y+lUUu5G0Ih/rAjy0TU1NZX6GtWUwy7rNuHSPagLmFvwJ46/PKGdQTVvhvyUKf3sO+vZnp/gBpKTctWwf1MUuSg5GOAHmloZEbIe3IIjrtrWbgURkxGSJ3M99R1PpaaGYygPms7OeWWj21kIOYiK4rsMmiSH2tDlwF/sdIjuuyTU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:47:48.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45108e9-e38c-4a3d-2439-08de63a029eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B
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

add missing performance level AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM in smu13,14,15.

kernel dmesg log:
[1217924.810528] amdgpu 0000:44:00.0: amdgpu: Invalid performance level 512
[1217924.810537] amdgpu 0000:44:00.0: amdgpu: Failed to set performance level 512

Fixes: 6be6424684cb ("drm/amd/pm: Enable performance determinism on aldebaran")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 63a65ea802fd..d17d6cd71028 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1659,6 +1659,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
 		return 0;
 	default:
 		dev_err(adev->dev, "Invalid performance level %d\n", level);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7dc6687c3693..68ecba0d5e0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1321,6 +1321,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
 		return 0;
 	default:
 		dev_err(adev->dev, "Invalid performance level %d\n", level);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index a2854d528bab..1860bd0f1091 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1210,6 +1210,7 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
 		return 0;
 	default:
 		dev_err(adev->dev, "Invalid performance level %d\n", level);
-- 
2.47.3

