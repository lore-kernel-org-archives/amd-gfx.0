Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E1606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jC8JEFxi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEAAC10F96D;
	Wed, 21 Oct 2026 06:28:35 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB45A10F96D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APOPbLaveNi/xZueKrWjGK+i7XzKkhodcnTulmQXfLjCEuMss7XS3yztPkKmc2MSZ3fxVJFJy2cILJyUfUoZLWcLV+bafyLhuIXlTAN3L/UDFtw8Q4UVBvQ1DIdVtr3TJf4Crjw6VfryRjM2bI/2oZDY5HOxkv7rZCMEM4LdjYsG2Pq7aNjxGbk6MraTJChjJCbU3nLa6DvvjCq7779kZifvhlVBW4GyidNMDTPyF7tPpW0DAn+GoPiTnKnaLk/FXSGnaFpZUSqkSnCVs+5NdSNX4kJZtNP/06zEoukJ9XmrlKqToyadFLAOvmodwG+E2QBuu2YOpYek6DpZe37PHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIvGLKRHRFR2ThLnxz/mDni/fitvjxR9rkn6q+0OOuM=;
 b=L4hiNZ0XE+qnsudTdbwPmsyh72S8aFVe3k5j7Oxa1XckBJ0nyXYu8QNUH2qgUTvN5xST90yt38ILiwzXZ4+W7vRGrymi4UxHlWIp4MXlA8+okNLSotAfQnlKXAtwsFZwkGf+UAAyMCpkIWSdwEZPrMi8nQTriXMIu2imEeuYOwby02oYQjsH7Cm1dUETgNmlLN2wcqPkg69dpKtri0pE8EiwjiJOkZ8Yq7EIj3ce5HHrs+f6VBSH1srtx9Z0JKtxcBTD4DkLsVqESmup5vpnmanYSy6ffyoTx8pYyC5MNLlyg//0QFB093t/HlfMUSsvBE9P9c+O49G4QvrXh2rjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIvGLKRHRFR2ThLnxz/mDni/fitvjxR9rkn6q+0OOuM=;
 b=jC8JEFxiS7NEjFYtz20lVXOVrIHoh1SSdwegX3AIWxBkHQcVuk8fbx42Ybg6SozNwJLZWwoHnNis2ZfgyiLM0sDm6T8OtWCmrz90ALEmGhOVfpysBxqSQc4vxhWcaZZYDPjBSz4jZ11MoAct4CldCwxnmg9GVbgfuuA/7V8mLX4=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by DSVPR12MB195923.namprd12.prod.outlook.com (2603:10b6:8:3eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:28:27 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::ac) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 21
 Oct 2026 06:28:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:26 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:28:23 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 49/49] drm/amd/display: Promote DC to 3.2.404
Date: Wed, 21 Oct 2026 14:22:55 +0800
Message-ID: <20261021062519.674697-50-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|DSVPR12MB195923:EE_
X-MS-Office365-Filtering-Correlation-Id: 72532b4f-eaa7-4643-85aa-08df2f3c841c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Gh2U/GN6tnTGz9NPtw3imbBluIO90GBv/5wOSJZgYJGh7b514NLhVlaECLJbMMSoWlCZII7fW8r2lC8Puprfy1CAFts+jmyfaUwh9MSeSVlJ/krnyImBBa7yeAnwOIOSX12xZvYf69OU/XA4BVbh2/tQFsi/miFthrG1BCFVLSMf3b1Q+TI9HIUn/LXPGeH/0UYsQxii7gmveLMvERodbpK+IJsHjc3+hDvOc9F2fVN+8f2XNFEDj7EE+zycjGM6fsYtU4kOf17pz4Z1LkF/jw+kOLh6yo5PNJQOWPY8QtQm1IpVfQYAcYvo8rdOonJuMyN+dckGWJuv7U/huLkPUD8hsGNPBCEPS3DV4Qw03HbGhM1eCYw1v6x8dtvEYeM61j+xdYdghNoCE4irly1yNc8NRnuLDMie69tjUvvZKIDxc7YFFLlQq/8wcDJP80qUraw0lwa7B7neutZYfaSMVcKMqjbftoyZcMH55yFcZqcU3bokO2eH7Gk+StFNRl2FNpGauHDmlW5v5u68I5jIBMkPzYfruYF6vlP8iEXUz7PBZXQmcDU/LccJeGZxJLDpk8c9JxNXsYjp6EDcivREyyCZNJTktZCjXqIXQQIL+Uw6I+xKRpnzUViAb8/DCsVuRA1dnGu5DQUBRzDrYWzBfTK+4jndD1kPrAxJyIUyUcLGahLhHb78nlKvLtxF9ljNUl7oee9E4pGtcsXJZhg7sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fIfnWCX5L82TVhho2IIctJiRS/2EsyJrQeVCsjqXIrbXMJ7p6owwWcm8xfTh46rLHIXLY7sns7wpX6AqVuBdKOy9buABiJ3iPrbFqtuFa/CW5QEjruTsyh/StpwrQeXGf9goxJTWp/nxpxadPOX0Ypa1tw6daKi+qdZ36QB4Qs6E03jkdGmIl4sN8g70oGSYEH3rt/R2UBvpLSOVq619yMbaYWBtFh5QGZo0fv145VcK5GtcZoslDLDMkY9FMOYBBKoDfDiurfLz9IA79O1dDYiLmy5eyh7E7bPie62Y6qggIcgL7fN1Lx+vMAUKZJAedTkjGEvUFFoXXSGjjNRzJQTHYmKir4MudHdvT0JRkUb2TtVYJvZIjTXvDINg/PRY/OUJX1dpXJfCjeJXpQqQVLU13QhYGpcjmHoOD/bmO2BoNRR2vq2SulgliUsLXK9J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:27.0454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72532b4f-eaa7-4643-85aa-08df2f3c841c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB195923
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
 - Add Core 2 BLS initialization scaffolding with builder, executor,
   workaround manager and DMUB dispatch.
 - Run DC2_DC1_Wrapped dcn401 init as staged BLS builds.
 - Split dcn401 init register writes into hwseq funcs.
 - Read MPCC LUT modes, cursor lock and DCN401 PHY state, and add BIOS,
   link and DSC sections to get_hw_state.
 - Fix QoS bandwidth fields copied from DML.
 - Convert update scratch to memory pool.
 - Pre-allocate DC state for atomic-context commits.
 - Preserve planes on DPMS-on during DP test link retrain.
 - Poll passive DVI sinks for EDID readiness.
 - Re-init cursor offload to DMUB after resume.
 - Add fec_status check flow for 8b10b links.
 - Revert DSC programming changes for DCN60.
 - Update alt-ch size calc to handle MPO + ODM correctly.
 - Cap DSC bpp for USB4 DP tunnels.
 - Add debug options for DMCUB FW loading and forcing MPC combine.
 - Fix CRTC init cleanup and pipeline name OOM handling.
 - Various cleanups, coding style and KUnit test fixes.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 569cfe16d73b..d983bab7eea3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -69,7 +69,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.403"
+#define DC_VER "3.2.404"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

