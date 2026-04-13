Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47424F34C65
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 16:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C725910E4CF;
	Mon, 13 Apr 2026 16:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ve9Hnb3l";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228EB10E4CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 16:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKrSpsLIElDgyLiB7dsg3gwWfbuzk+aZSFfSb0/vRoFnZLPjJ23lDyq7g+LlBQtKTQ9bNfM5EBFGlI/lY7xuaznxlLVbJ0iBbB+OBbTsuugcrO4EXsF32kW/6u++bhdA36WHpzlxhNGl07aFz5jSrkZhm8p5CAlZd3HLd16FpfTuX0tc4LgolWv64AKakHcSB77owyxAhZnHf6QrTH2iOJnjeSAR/DpJhusr0gQxYWTvh4byhFZzcTz8lmVvVAT3kxQY8HNoNbdt41fGMqJHu5qQxfSIO+qsBX2r9s5a8SpUokiK64XoMm0KOAE4BJpj1Xq33hFhRdVp9ikrTLd9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFBijd7xdG9ya3+8O2sUkkAaLK5qdyCwrex/uu8KwnA=;
 b=xy6Nd4x/lRwn2pl/Lv6DsL/R+ILDc+9hLzsJ5Gn01d1GcKBmctJkWQMCMpk2/a1+mEdLdZwOfGVxjfHfjNLvLwMyGXPETtnib2aw49ejh4kDbVcxIN7hFdfSNVUNgI5TXP/n/3srRJX34u8An0GJ1Hdr2aYsXpyi/8pDOnWM+Vld27ULsttnbUdTeVoPoMG3jPLlwfEMKdtfLDGA9utQcexxMX3k3YEz/6uX1Oh7dg9QGucxIGwJcs3I/Jahd9d4sQKg4SniQxWqGsHT+O6ZmlyDmWp+hHNmuZ7d31UOvDoVew0AQsIOpI7Y1bBJaMsBYVi7CQiiqrp5fVbBBGKUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFBijd7xdG9ya3+8O2sUkkAaLK5qdyCwrex/uu8KwnA=;
 b=ve9Hnb3lmjh5lkCOt+hNo+yoK2kTa54a6EeL9Vd9H2mF5MfSqPbtrDCT6FzbyoYvEYkltCdlOGl4TAVK7g/yieZA2UwsVblMvt73MYEQD0m8EaLiLHsOU6GTLWhpnhKhTnD6SH9ikcgjGGAp89x96qRN7h8g0Mqz0pgDTv4mkOY=
Received: from MN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:52f::10)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 16:16:22 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::3c) by MN0PR03CA0004.outlook.office365.com
 (2603:10b6:208:52f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 16:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 16:16:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:16:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:16:21 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 11:16:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: check if dml21_add_phantom_plane() is
 successful
Date: Mon, 13 Apr 2026 12:16:10 -0400
Message-ID: <20260413161612.455669-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e7b65e-4d59-465d-d623-08de99780109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hLI0cLtv4bfAjPaLI6tO0vEEJozeuQtIPWu+dG7/RSUgyeuTQ5gjDJP9C434pU71Ar0h//ftpRtQZaKp5Vlkx3nnzEHhf2yI9tw9tZkrM2bGAYnw9DeZtyOOoGbJufmfZq0IEl4aOcvIQixv31PPc68CZKKtCes/4nxcKKmHgcy8lwy8dr5LMOTO2lcqaQq6MR8wa8h1R2nKReu0oi2wv7ab7iNTbgf+zBb5rEmr67S0QESXMKS3s3xvKdi25vmcnJKBlnVdH5siB4lTAcQcFraesTs7N3irMAj6NeViBZZesg79mE1nb/XNUQxCLOQVSWXDyh03irsdngtSrplDaAmGRA6QWwjw9xidDg2mR1sbD9cBTLzoGX87O7XRIg78t1EfdvYd3gc0NBKQPWw7ra19Z567NEH5e7OX1IvBq0h9AHxI1ZC6lx0wB8ztlsRDscPpV90dVVLeCqbZlHuSBza18U6Pe92v1CJOqGPZDMgavSbHntaicZ9kgJY8kmZHVeHcv9YVk1iiF8wRzXp3lfJlmXF6sIvOyYd0dNXpIA/D95pPAkhuC4bdJKMsA/puL9acBBCpRWnCmTW58Ptsp6ACdbRt/S6i0hcihdj/KOZF6pS8Ke5YCIYW5VYpd32wdB4mAfehe/oXhrrW2CuAxrZX+yarP1d4cqWdi4XDrPdCEkhOdKSuLpr9lNeuRYbPED2iIq4W7cJOmHl8Jcv8F9+6Lwwt3S5O9xZVQTYeJOo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cuWYUEGlQRbQCAi8pvx5z1+LNYlpmDN297k5paQ3tTBhVmrftI6JESCwOgePSNnIxqTfd3apRlHbJfquE16Gx+Sbiw1mwZO9GZa8/dOwaHa1Fm3nDrMhnCIpXjcNMCYJUtNEskJNj51kxVsIQq7a2Vo50+XNF1GaZkGaRxy/TJt9gCNqn6HSGmY2jh0JlGwVeTSWl4HVXgzZ1lru1Z82JT3Tqq2f/Fv6h2tTIqvIlme2vKLX9aSyLlmNZ0bD4Lfo1fOmWdZoSZhqaLBK3jCa7VvLvkVK2uD/CMeRNunOjIPVKVuSt7Tr6xnxFEDekd3n9LaKquy5w2PRNiMoEX2aZGKf/zoVNFYMu5HAjojytEN15NnaV/MMs66kOnLDf9cA5d+5m1VPZHjWx393ZJvUoR17GnMKAqKK9Q8oM/D22EOUiDNtfQ809dM+We4X3X91
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 16:16:22.5300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e7b65e-4d59-465d-d623-08de99780109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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

Verify that the phantom plane was allocated to avoid a later
segfault.

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4970
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 4724b08c77e1c..d52c3a064b160 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -357,14 +357,13 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 					main_plane = main_stream_status->plane_states[dc_plane_index];
 
 					/* create phantom planes for subvp enabled plane */
-					dml21_add_phantom_plane(dml_ctx,
-							dc,
-							context,
-							phantom_stream,
-							main_plane,
-							&dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]);
-
-					phantoms_added = true;
+					if (dml21_add_phantom_plane(dml_ctx,
+								    dc,
+								    context,
+								    phantom_stream,
+								    main_plane,
+								    &dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]))
+						phantoms_added = true;
 				}
 			}
 		}
-- 
2.53.0

