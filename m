Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165ACFF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA35F10E398;
	Wed, 29 Apr 2026 01:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jUn4rBje";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D3910E398
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRgyfV2kSd3oo8Skx31zpTvm2QFMJw1zRF4Bpu/pquvqYKI6favkZO6fFMFGhmmMvkGvGlZ3PXXesYt2HrZPpT9Vh3XYvQO+IQi7VMmdblHlLL8fOAVIWQ7qi5mAcTMftKHyxY15G3A6KUdbMGqSlLFjjV6CdF8jLksDZbBWcXHgPLX6uqwsfK30/T1BtXIOTd08UcQVduHO4DoyhW+dYgWZ2scwMGCgCSqMRcTscpiiKTfWyrxMMVpSjfMsL4Gz781i8bJ88KsrnNAnAzIudf/AP7gGnsYjRczl3/s5y4RKL3HWHrtgu6zWM/PZVXUGL8kdUYKI55h4SsnnWPd7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eWYoOlRDYu0jEoddC/U5gxtC1n0sihnLPlBguXkbsw=;
 b=YN86R0CjoVmA3FEKJOfvDfgjcbQNXh/A45mS/NLat275b6sdCGmQh/nvUmQxRCg0efWrCd19l30wg0oA7kXDlWL992BjEW6vejScpm/4WtjXdi5oIUVwVSGLtFeYChuYgOuPJsZMq7LYqGk7WHlv6IXJ+qkZXhbjkORxa42vUsOzvYOsgISNN6ZNHtA0aeMq+ijOLN11wEjApgFC9Fy29Rq/82AvMfk7lPCWPWDCSJTIpPJk32dSbaOt0yUACp0svJruX1j7ffGQ5sLfZ4cmN0+dxce6loOYIrF0pKOlYxoARUXNelUMPKvsvaq+Xcxus6MwtDxdOBkJreth1+RsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eWYoOlRDYu0jEoddC/U5gxtC1n0sihnLPlBguXkbsw=;
 b=jUn4rBjeZMgrCN2g5yHX0EpS7ApPAGIHvAwAbeyRSFB7tvchpagJMtaT1F7P5/6LjAvqCjw9Rm7RdKvsM9LeONLN2bIGqSH+qOKQx49sw4qO1JrWWIlwsN1AJjZ/Uu5iTa5iz/ftK8G7YhIolXhd+0zVM15vPiNrUKPyvyou2bE=
Received: from BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 01:52:12 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::49) by BYAPR02CA0044.outlook.office365.com
 (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 01:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:52:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 20:52:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 20:52:08 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:52:00 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 02/17] drm/amd/display: Remove unused state param from
 enable_link_analog
Date: Wed, 29 Apr 2026 09:19:11 +0800
Message-ID: <20260429012055.2065869-3-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7cb40b-75a2-471a-bd69-08dea591ee17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DYFXLxOXxwQPRsMJLWjt+5++9oI7hHgsFQuo54ntH9Z9JmwKUiNLBk7SMXMmGUaQ4uAe4RCW8ppkfHC4SDdo3T8Q6jjW1qw0FBibWElurNLDx3x2spmG5VrSA5HvqJ3pVtU9+bBPEhAIDNQ3Ekv+KjeltVf/nxUDAUtx/8H2akKjgfwonAEmL73vmcptl1IskOSYjUPJ7ABEblnM/kOTuYU9aHFmo+ZcyaYSFqN+Z+GqrefpT3yEVhbGu5lbey3rsoXyRHF4Q1yP00oWK7YGX8XU3QGfwM30P7qXLAxjAn/faEQZUZerbOCVwWO3L3TnkAiESVv/PGdl/r44m1lpk2Za7n3UxqSb5iPf0ddyIP4HP3rOUOLwmQpSQ1PzUid+tvLzlbp1Cxmx9gBBij/HV+f45ivejZ1kBaKhUPzMYGzZIE1rCBGgmj2cJ7c28lVd7m+qHaIC/KEYczLYA4M1hzStfOKa4NuPfiGtElHfpAzcpQWJwANMQoNbtNFSJ2sos4mJ+IQUMumLihmEN1hyVm3Jbp6tsUx8Bjfcq3JwcMUq6iCg1kcoynSvmeZucHjL6ub7nkIbZX6SmnHZJ/jR9bIJOj7f70D6OrPUNTQkadmk5wGq2nzNyvcelKINl6CsUWAvsVvNcyTu2/13BscO1GhkAUadtzHjXcB2qthy6keLJyGC4oOQlOOYwOe762LYwkaRcTIYV3W4rHe8GORGki/Z4c+lVJbIn94ZTKfAupC/ks9Bzl2H/vaMJnjhvBOxntCWMkrxmO/JBV3ruKvqoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sr+h+ZbAaOQi4aN7G4iOonxhCq2fbO9F+3aHm31094HfFMPYdzysnS6MRS+Fqz1mXy9MZu8oTdPYh0E9aTedMqrsLtEABCn09UySQIgKvDZIMG/NDKKETX35mQP3TpGhrsCzxWWK5qADQLf7ULJHxxtzbzldJ4K2vQKGcqbXOrZmTYNBdFKMUxN6N9TuevIP1WqUQ6++sq0TDEXoQ91idFQtJs3vW1mnGv0OE0YSAXSCfm8mk3lqG94CMR13y/l+TIk+Ithbm5eaX3Gt3iXgbtzuQCkXbdJT7a0IvjTN4VRmiBRmlnbpZhxEaTJOhfpHhHySV5Hl3EBuc0L1n8DmT3jF/3gvt7P+AX+H+/BjVKtTgGKeBej1WDzC1V2MG9ScUHNIZ5x31ehR+So0F8BzMFTuvSj3JOsjq8vAV7gYnX8jskxrD5Fu/cNCoDv4yc4h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:52:11.5475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7cb40b-75a2-471a-bd69-08dea591ee17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
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

[WHY & HOW]
The 'state' parameter in enable_link_analog() is never used
within the function body. Remove it from the function.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index e7d3f9bd8aa5..72fbcd31e32a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2016,9 +2016,7 @@ static enum dc_status enable_link_dp_mst(
 	return enable_link_dp(state, pipe_ctx);
 }
 
-static enum dc_status enable_link_analog(
-		struct dc_state *state,
-		struct pipe_ctx *pipe_ctx)
+static enum dc_status enable_link_analog(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
 
@@ -2083,7 +2081,7 @@ static enum dc_status enable_link(
 		status = DC_OK;
 		break;
 	case SIGNAL_TYPE_RGB:
-		status = enable_link_analog(state, pipe_ctx);
+		status = enable_link_analog(pipe_ctx);
 		break;
 	case SIGNAL_TYPE_VIRTUAL:
 		status = enable_link_virtual(pipe_ctx);
-- 
2.43.0

