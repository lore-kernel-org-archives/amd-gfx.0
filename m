Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7B606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GYDiRnd0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D2C10F93E;
	Wed, 21 Oct 2026 06:25:59 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BEB10F932
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSXXYv3XfZGJJqAL+BXIn6+i8ExsTt2J/pdJRWB3WKbYYwdmpSjkGgVgO0+PdoSQveR+07T93j6NoMPWgRpjEtlVEcLlK1FmbTL5tKiRb96SVJ83PV7Gj/gimpVqX6mYHw6XVjBDUWcuyMhEm2BGejuWtsW/+fzkkysh7w1Hab34dFHXEBBLiK/uyHuCbnBBzTJMYomowtga9GRKu69a9YEpmcz7o8xE8MRwnwT+yiQAgo6TEZiMISObyuXlcu0D4S0ru052haGPjC/Z/5lStNBS1FiZ4fK21Te3gZcvucEGDDDvi/+FXVC5BYwvKlVr6flv2ayyiS/ZtEVB+PiTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhakdoICa0Ab/3xNokyrBVqtCLHiujMPvUKJqzGN+VU=;
 b=MGgbdufdlsHc2D2IxHmVZbs/00ji6V3WPNEijJe1FUNFCdNcs/rfAwrrBVb84eWESliP05Z6bF8RfaAPtYylAzJCVwx5LJT69lRfKZm0Go+VRjmNnBilT5iP4vGmkSAsZwdmCb1X9aG1yxpjX3Pvr3QwX5fm9ikHPjTI9HMo1ewJ5cAUXZhJgb2FImpfFPH1JkffH3Z1bs3OwzXyXdCZyR8kFJTDOYlk4cqgdMxUzU36bA1Ntko+abtRx4eAgZSNELUb32+Q/znhgbJMFRwiuwNVCPYdzU0VPGie3RXHxsNPmctysSK7iCpza/i93M+3BVgn/5l8OpUzJblrv4eC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhakdoICa0Ab/3xNokyrBVqtCLHiujMPvUKJqzGN+VU=;
 b=GYDiRnd09rdubBiWBe/JInDwfzhW81XYRCsCwMRhIFxi2Gx4zZg6MhLCM2NA0fNvFzFGh1UCzF1lPfdA3BLxrp5aa+WKjWSyCgII3OZtm9Dfpds2JMlB2mz/Bs1H7M/JBbr4oQRPnxR13es/Vi/I8wuCWtntzSDHcox9dd2/dLA=
Received: from BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::32)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:25:47 +0000
Received: from BN1PEPF00018549.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::4d) by BN9P223CA0027.outlook.office365.com
 (2603:10b6:408:10b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:25:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018549.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:46 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 07/49] drm/amd/display: Name the init STOP_FW entry
 DMUB_HALT_FW
Date: Wed, 21 Oct 2026 14:22:13 +0800
Message-ID: <20261021062519.674697-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018549:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 46287e9d-619f-4feb-e04a-08df2f3c2507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: M9uo/7K3Y8VKIeVlq8LzipyL5MfCKhHfZZUluzv3AZRIIYORyMVshFzZBPB05ur/5U9+59R1NL7ZyuUXX6rHoKglPSrDsqgHoEfH6fndO4tQEnJeIvOAW+9uV/BpcoV8ExW57nQxUhyEO9FUbhzdxFGEobLtN0UizudVU0k1O8mtqdi5T1/CWHusM+ToWlaJRM2d4GF5gHPWYfkGRB5xsjidQJAh/CuNZzlAJI+qUYod5RotFPkQTfzl+Osu2gm33nLDtOUQTkiWSOyzMWCMBjoEjLWURrDh+deQTnXqNZ6q+iMhe9RsIgmPlTK0ZnDXDi8/eo4myGdNkm9Ftl9bx/CTqoqeQTjJP92guGW9sTyBJlL2xVJ83FXb0mYCohkyx8XSvsFaUzpfX1KUOt9Bcxj6/ArdRRboakwLx7xh9eWmcAkOwab7v/otqdRA/KnYouvualV7JM218w+VSPh9UFOvXY8kV4nYldmZrjFzGJ5GfhYgDa+myLlxRGUR3lBUCksNTQb18/X3ULoR1mEhD7T9tfak2gwGmFIn3ZaQ+UZ5ur3XVbxHO1tJJ/h2tMw5LJLVxi6yz3utvO1xHVVVCIQnpLdSAwFBg2nKYOOPKDltZmqjEvevR6fwnmmw3WAkHqR2FIPuFRZoeh/XZ3OGMHEdw/dTn9daPXO5PTDe/FnzXTF36FVguujVVMyxPFSnmNXPnZmw3ZJvFwHU8Eix9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DSRlOZvOgfXLqAMHN76exbBEuCYQcSEO3JEJqFcrgkJih/UQHMOUQ/4rg+CeaZKwwaKz8eOfBdKBnlLj4WDZ1SURn/VQ6qTPD7GycoeMnusKxB3HPvCrB9FJtGcBT5AljHc1T7sX79Y2kb1zFsLcWdUkNN/RdwmeSRFhLJJy6OyMoUTqeHrRaa9d8dJK+d8D8tNjMj9DtW0/1+QqSv2j729ao97TrxyTr9YxL8zqB+Aa34OEC/XB3VJ8VgD0AqdhPCTAKQgr4oeqMSrehBIL/AQoOVS8qdxI4MR2sqI4HT9UOHtGGUpUJmKD6b7wDiPOpJEu1jfT2JrxzptkmAoTADAAA5vbmo795rwJBx65ouuD4wpajbdaWpac3edfBDzt5C6jS9jIjkGalXqeHswXbjaLd3JnU/Tpbnl66WBvJVR0fabcYqXTBhWAbfj7i9bM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:47.5279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46287e9d-619f-4feb-e04a-08df2f3c2507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018549.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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

From: Tony Cheng <tony.cheng@amd.com>

Why:
The init head still emits a raw GPINT transport verb for firmware halt.
The initialization flow asks for a dedicated DMUB_HALT_FW mnemonic.

How:
Add DMUB_HALT_FW, emit it from the DCN401 init sequence with STOP_FW
params, and dispatch it through the existing GPINT helper without
checking the ack. The walk still returns UNSUPPORTED.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/bls_builder/dcn401_init_builder.c | 12 ++++++------
 .../drm/amd/display/dc/bls_executor/bls_executor.c   |  2 ++
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h   |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 99c34e2996ae..e8f518d17af6 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -16,7 +16,7 @@ static const enum block_sequence_func dcn401_dc1_init_sequence[] = {
 	LEGACY_CLK_MGR_INIT_CLOCKS,
 	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 	DCCG_INITIALIZE_CLOCKS,
-	DMUB_GPINT_SEND_AND_WAIT,
+	DMUB_HALT_FW,
 };
 
 static bool bls_append(struct block_sequence_state *sequence,
@@ -88,7 +88,7 @@ static enum bls_builder_result dcn401_validate_initialization_step(
 		if (!dccg->funcs || !dccg->funcs->dccg_init)
 			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
 		return BLS_BUILD_SUCCESS;
-	case DMUB_GPINT_SEND_AND_WAIT: {
+	case DMUB_HALT_FW: {
 		struct dc_context *ctx = params->dc->ctx;
 		struct dmub_srv *dmub;
 
@@ -154,7 +154,7 @@ static inline enum bls_builder_result dcn401_build_dccg_init(
 	return BLS_BUILD_SUCCESS;
 }
 
-static inline enum bls_builder_result dcn401_build_dmub_stop_fw(
+static inline enum bls_builder_result dcn401_build_dmub_halt_fw(
 		struct bls_builder_declarative_params *params,
 		struct block_sequence_state *sequence)
 {
@@ -166,7 +166,7 @@ static inline enum bls_builder_result dcn401_build_dmub_stop_fw(
 	bls_params.dmub_gpint_params.param = 0;
 	bls_params.dmub_gpint_params.response =
 			&out_init->dmub_stop_fw_response;
-	if (!bls_append(sequence, DMUB_GPINT_SEND_AND_WAIT, &bls_params))
+	if (!bls_append(sequence, DMUB_HALT_FW, &bls_params))
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
 	return BLS_BUILD_SUCCESS;
@@ -184,8 +184,8 @@ static enum bls_builder_result dcn401_build_initialization_step(
 		return dcn401_build_dc_mode_read(params, sequence);
 	case DCCG_INITIALIZE_CLOCKS:
 		return dcn401_build_dccg_init(params, sequence);
-	case DMUB_GPINT_SEND_AND_WAIT:
-		return dcn401_build_dmub_stop_fw(params, sequence);
+	case DMUB_HALT_FW:
+		return dcn401_build_dmub_halt_fw(params, sequence);
 	default:
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 93f80cf63142..510943a12724 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -46,6 +46,7 @@ static bool dc2_bls_step_supported(const struct dc2 *dc2,
 			return false;
 		return true;
 	case DMUB_GPINT_SEND_AND_WAIT:
+	case DMUB_HALT_FW:
 		if (!dc || !dc->ctx || !dc->ctx->dmub_srv ||
 				!dc->ctx->dmub_srv->dmub ||
 				(dc->ctx->dmub_srv->idle_allowed &&
@@ -147,6 +148,7 @@ enum dc2_bls_exec_result dc2_bls_execute(
 				return DC2_BLS_EXEC_ERROR;
 			break;
 		case DMUB_GPINT_SEND_AND_WAIT:
+		case DMUB_HALT_FW:
 			if (dc2_bls_exec_dmub_gpint(dc2, entry) != DC2_BLS_EXEC_OK)
 				return DC2_BLS_EXEC_ERROR;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 06496f78d856..2393174bc282 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1397,6 +1397,7 @@ enum block_sequence_func {
 	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 	DCCG_INITIALIZE_CLOCKS,
 	DMUB_GPINT_SEND_AND_WAIT,
+	DMUB_HALT_FW,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
-- 
2.43.0

