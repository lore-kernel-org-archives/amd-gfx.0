Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA928C5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA0110F6EC;
	Fri, 14 Aug 2026 21:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L/lBojTD";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DDE10F6DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+9pDtarFHA9xeAp9/dyiP1RwRTNk+l+eSaxb2Zt9BAfirjs1RmQEFfg34XdWpLNw2T78AvbXzDyF/yR7HM5pWRbiY7hWJD9EOpXQkf5nuceeQxEcNTEF7UNaCf44f1nxcO/1LGCBB566xUPwZZnVPMDK7g6eInnkhw7GfUHGuBNA3Lfv46k6YC1pr4kzClw08FxdGBI4DTx5qdJZFoIM3jxY4yGYujV7GCBwnGpl+MdJBi44NBzy76hsB7/LOZbDdZOcFqX8C7cXF7DCoIlzrs0awYXRryoV6BpfNOQswGNI32MWgawcK4qTPSq9BNXlNsM5WBpIG1y5TuDQHYyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efkoit1j4AN8RDGYnKnTtejbXmD+2ZLoILW0ZSfcQFc=;
 b=avXGhZ7KnsrGIgCK/dnEwLSZgoR8HH4jJpynZ58ABplglKuMcmtWmsyn3AVsS+eyQqpiva6NfnNfXxsBQMSmziDActp73Iuzt81wCvw7C2TER9JZ5betv7+/Gz0q2PzSS7Tm7AOIDhjepTqLU9gag+K2FiE9q/4uE1ThNx8kUNKyNs+vsuEg2TYiUPrLC73iTHkH8TLlIDjY1d7949MPm2yokktMkoaoRsaOJcLE5GLot0XktszYYoB1J1LIhBJ6NWDE4tFMD/tBR1Vqj5GbY6MR36N6O1WyTJ2td6Et6fWJUh7ote2d+J3rfQchSkwhod8E/0IHOs2ynWuxkVFuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efkoit1j4AN8RDGYnKnTtejbXmD+2ZLoILW0ZSfcQFc=;
 b=L/lBojTDYQlxKId61uP5SHDT/WWRphiv5nnHy9UeCo/ERIdymM032x9wfu5vs96gePl9uQfkr0op29qG4qHUuQ30aFpCHUPLLoQCy9Yeg+uxTShy5WWaNikCsz2aVoUnigqTLVIFPunFEI1+5nNDaKRSuV+LnPdX3FYm77yMdFY=
Received: from CH2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:610:4c::16)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:11 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::75) by CH2PR10CA0006.outlook.office365.com
 (2603:10b6:610:4c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 022/109] drm/amd/ras: Add ras block id mapping
Date: Fri, 14 Aug 2026 17:01:19 -0400
Message-ID: <20260814210246.3067612-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: db11bdec-b79b-4656-c152-08defa477315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: fKf08kWXrRhHqvJdunhn0PtpYFWLyDNhBObEZtKXbFJCYh1jXU5SKJZEU9UaEps7GS5Hvufxm7YTq6DdFX3vvCIyVBCcAFk6lR6lrRzgA15o5rBrN/DhQoyquaA5sk2mN5J324LA5TijNr+I4HiCBIvs4JScqTzQ1JTSziAOtOX92fbcjGtaMoLnnvoZymT0CX3sdSTCPjg4sJZE/EvsHZ4tUHT/r3zxcMXQbCxQEXCRe6zyXA0CKF+Mm7oc2GlGYciPOLvSRMrn2mnMg4621PtPB0ByEZ+/ogQQe01PmQFtYweXVU00HZkoq4dUUMpcxTSlO1Ix7R1xuW70nE18xttT5MU5WQb3mMU9zgj9zCgNo8xPZOiCttzqGR6AV9nHIC4Lr9jJTgHi8O0NNsQYPeon7NCew3654zfEf081di3qTdFwdyP01yta4Fo48HL/OXZBmPDIuvL9zlFNormA72FywDkGEvZhk+8zb88Qdsvks7WpTPlO5etAwWjv9dfs/hby5lZYi2G0PbH1KKjN70TImMrF1hhntfmbw0oSTR3J3CxcKhSwHwfGD158M4qdecOkoL7dH5PfdG7H4rXjFoEQLa+mZci60n/XSWYNxpscDQbuOqjDNbUFd5LxiTyIkbSYOWQfe+P7qPDMa6IUzeM0I+iCA36dGFq3rYPDHJ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qEv8MdeBNP5UekY/gIMPuKaotTeyH50oAr3QMGJEFzCJPbO13uv6WJPL5aiO2LFv2wssKQ5ymAh+VKTUqq2MqxtaKT9zE4BkUKCAXxF1WvBNILQi1OCMDmCeq/pbrnsBwn4ZWlBRONJrm6saNmzbferwOcNV6znmPiXN6CCyoaIUl0r9b3nqpAV4mhyv+TfJW7tch4mQCAl26VXyMwMor0N4lMbiOFwrykSTIKolAPc/fNVkCk3ZeNd0zgPFLrFBNJNqvegeSyAa30Ih9kv4BinVYYUriX45wVFPX7sHHfzyOGpUEahmTCm/3rs8JSghiwERrGr5co/+SJw0l42m8aTVPFC/blP/Z42Dcv/43qMvJfhEkd8JQHzJO39qfOl6ifgagPaik0aOsWCEYx5+C/iHYsekt9fP+c3NTFCEJJxBah/RPJp9NSMIHwctKC+1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:11.3232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db11bdec-b79b-4656-c152-08defa477315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Some ASICs have different hw ras block IDs.
In order to be compatible with these ASICs,
it is necessary to map these hw RAS block IDs
to unified RAS block IDs.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c           |  5 ++
 drivers/gpu/drm/amd/ras/core/aca.h           |  3 +-
 drivers/gpu/drm/amd/ras/core/cmd.c           | 49 +++-----------------
 drivers/gpu/drm/amd/ras/core/cmd.h           |  1 +
 drivers/gpu/drm/amd/ras/core/ras.h           | 20 ++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.c       | 27 +++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.h       | 10 ++++
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c | 34 ++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c | 46 ++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ta_if.h         | 34 ++++++++++++++
 10 files changed, 184 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 898742e578347..8bb93ca61b18a 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -619,6 +619,10 @@ int ras_aca_sw_init(struct ras_core_context *ras_core)
 
 	memset(ras_aca, 0, sizeof(*ras_aca));
 
+	ras_aca->aca_blk = kcalloc(RAS_BLOCK_ID__LAST, sizeof(struct aca_block), GFP_KERNEL);
+	if (!ras_aca->aca_blk)
+		return -ENOMEM;
+
 	for (blk = 0; blk < RAS_BLOCK_ID__LAST; blk++) {
 		aca_blk = &ras_aca->aca_blk[blk];
 		aca_blk->ecc.socket_num_per_node = socket_num_per_node;
@@ -642,6 +646,7 @@ int ras_aca_sw_fini(struct ras_core_context *ras_core)
 {
 	struct ras_aca *ras_aca = &ras_core->ras_aca;
 
+	kfree(ras_aca->aca_blk);
 	mutex_destroy(&ras_aca->aca_lock);
 	mutex_destroy(&ras_aca->bank_op_lock);
 
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index d81a9d0ccc6d2..a9538e64d7d53 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -29,7 +29,6 @@
 #define MAX_SOCKET_NUM_PER_NODE 8
 #define MAX_AID_NUM_PER_SOCKET 4
 #define MAX_XCD_NUM_PER_AID 4
-#define MAX_ACA_RAS_BLOCK  20
 
 #define ACA_ERROR__UE_MASK			(0x1 << RAS_ERR_TYPE__UE)
 #define ACA_ERROR__CE_MASK			(0x1 << RAS_ERR_TYPE__CE)
@@ -153,7 +152,7 @@ struct ras_aca {
 	const struct ras_aca_ip_func *ip_func;
 	struct mutex  aca_lock;
 	struct mutex  bank_op_lock;
-	struct aca_block aca_blk[MAX_ACA_RAS_BLOCK];
+	struct aca_block *aca_blk;
 	uint32_t ue_updated_mark;
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 98767a94d267b..a0e61826c292a 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -357,48 +357,6 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 	return RAS_CMD__SUCCESS;
 }
 
-static enum ras_ta_block __get_ras_ta_block(enum ras_block_id block)
-{
-	switch (block) {
-	case RAS_BLOCK_ID__UMC:
-		return RAS_TA_BLOCK__UMC;
-	case RAS_BLOCK_ID__SDMA:
-		return RAS_TA_BLOCK__SDMA;
-	case RAS_BLOCK_ID__GFX:
-		return RAS_TA_BLOCK__GFX;
-	case RAS_BLOCK_ID__MMHUB:
-		return RAS_TA_BLOCK__MMHUB;
-	case RAS_BLOCK_ID__ATHUB:
-		return RAS_TA_BLOCK__ATHUB;
-	case RAS_BLOCK_ID__PCIE_BIF:
-		return RAS_TA_BLOCK__PCIE_BIF;
-	case RAS_BLOCK_ID__HDP:
-		return RAS_TA_BLOCK__HDP;
-	case RAS_BLOCK_ID__XGMI_WAFL:
-		return RAS_TA_BLOCK__XGMI_WAFL;
-	case RAS_BLOCK_ID__DF:
-		return RAS_TA_BLOCK__DF;
-	case RAS_BLOCK_ID__SMN:
-		return RAS_TA_BLOCK__SMN;
-	case RAS_BLOCK_ID__SEM:
-		return RAS_TA_BLOCK__SEM;
-	case RAS_BLOCK_ID__MP0:
-		return RAS_TA_BLOCK__MP0;
-	case RAS_BLOCK_ID__MP1:
-		return RAS_TA_BLOCK__MP1;
-	case RAS_BLOCK_ID__FUSE:
-		return RAS_TA_BLOCK__FUSE;
-	case RAS_BLOCK_ID__MCA:
-		return RAS_TA_BLOCK__MCA;
-	case RAS_BLOCK_ID__VCN:
-		return RAS_TA_BLOCK__VCN;
-	case RAS_BLOCK_ID__JPEG:
-		return RAS_TA_BLOCK__JPEG;
-	default:
-		return RAS_TA_BLOCK__UMC;
-	}
-}
-
 static enum ras_ta_error_type __get_ras_ta_err_type(enum ras_ecc_err_type error)
 {
 	switch (error) {
@@ -426,7 +384,6 @@ static int ras_cmd_inject_error(struct ras_core_context *ras_core,
 		(struct ras_cmd_inject_error_rsp *)cmd->output_buff_raw;
 	int ret = 0;
 	struct ras_ta_trigger_error_input block_info = {
-		.block_id = __get_ras_ta_block(req->block_id),
 		.sub_block_index = req->subblock_id,
 		.inject_error_type = __get_ras_ta_err_type(req->error_type),
 		.address = req->address,
@@ -437,6 +394,12 @@ static int ras_cmd_inject_error(struct ras_core_context *ras_core,
 		(cmd->output_buf_size < sizeof(*output_data)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
+	ret = ras_psp_get_block_ta_id(ras_core, req->block_id, &block_info.block_id);
+	if (ret == -RAS_CORE_NOT_SUPPORTED)
+		return RAS_CMD__ERROR_UNSUPPORT;
+	else if (ret)
+		return ret;
+
 	ret = ras_psp_trigger_error(ras_core, &block_info, req->instance_mask);
 	if (!ret) {
 		output_data->version = 0;
diff --git a/drivers/gpu/drm/amd/ras/core/cmd.h b/drivers/gpu/drm/amd/ras/core/cmd.h
index e3b39866455d8..4950d0561b30d 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.h
+++ b/drivers/gpu/drm/amd/ras/core/cmd.h
@@ -92,6 +92,7 @@ enum ras_cmd_response {
 	RAS_CMD__ERROR_ACCESS_DENIED,
 	RAS_CMD__ERROR_GENERIC,
 	RAS_CMD__ERROR_TIMEOUT,
+	RAS_CMD__ERROR_UNSUPPORT,
 };
 
 enum ras_error_type {
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 9bab956bbf385..dc590867d82a3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -82,6 +82,26 @@ enum ras_block_id {
 	RAS_BLOCK_ID__JPEG,
 	RAS_BLOCK_ID__IH,
 	RAS_BLOCK_ID__MPIO,
+	RAS_BLOCK_ID__MMSCH,
+	RAS_BLOCK_ID__MP5,
+	RAS_BLOCK_ID__ATU,
+	RAS_BLOCK_ID__DACC_BE,
+	RAS_BLOCK_ID__ECLR,
+	RAS_BLOCK_ID__KPX_SERDES,
+	RAS_BLOCK_ID__LSDMA,
+	RAS_BLOCK_ID__MPART,
+	RAS_BLOCK_ID__MPIFOE,
+	RAS_BLOCK_ID__MPRAS,
+	RAS_BLOCK_ID__NBIF,
+	RAS_BLOCK_ID__NBIO,
+	RAS_BLOCK_ID__OXRP,
+	RAS_BLOCK_ID__PCIE_PL,
+	RAS_BLOCK_ID__PCS_XGMI,
+	RAS_BLOCK_ID__PIE,
+	RAS_BLOCK_ID__CS,
+	RAS_BLOCK_ID__SHUB,
+	RAS_BLOCK_ID__SSBDCI,
+	RAS_BLOCK_ID__UCIE_PCS,
 
 	RAS_BLOCK_ID__LAST
 };
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 0f4ced7ddfbec..5628b384a7333 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -716,6 +716,10 @@ int ras_psp_hw_init(struct ras_core_context *ras_core)
 	if (!psp->ip_func)
 		return -EINVAL;
 
+	if (psp->ip_func->get_ras_block_maps &&
+		psp->ip_func->get_ras_block_maps(ras_core,
+			&psp->blk_maps, &psp->maps_size))
+		return -EINVAL;
 	/* After GPU reset, the system RAS PSP status may change.
 	 * therefore, it is necessary to synchronize the system status again.
 	 */
@@ -756,3 +760,26 @@ bool ras_psp_check_supported_cmd(struct ras_core_context *ras_core,
 
 	return ret;
 }
+
+int ras_psp_get_block_ta_id(struct ras_core_context *ras_core,
+		uint32_t ras_id, uint32_t *ta_id)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+	int i;
+
+	if (!ta_id || !psp->blk_maps || !psp->maps_size) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid ras block parameter\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < psp->maps_size; i++) {
+		if (psp->blk_maps[i].ras_id == ras_id) {
+			*ta_id = psp->blk_maps[i].ta_id;
+			return 0;
+		}
+	}
+
+	RAS_DEV_WARN(ras_core->dev, "Ras block %u is not supported\n", ras_id);
+
+	return -RAS_CORE_NOT_SUPPORTED;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index c899d0ac74cce..5265408ddafea 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -64,9 +64,15 @@ struct gpu_mem_block {
 	void *private;
 };
 
+struct ras_block_map {
+	uint32_t ras_id;
+	uint32_t ta_id;
+};
 struct ras_psp_ip_func {
 	uint32_t (*psp_ras_ring_wptr_get)(struct ras_core_context *ras_core);
 	int (*psp_ras_ring_wptr_set)(struct ras_core_context *ras_core, uint32_t wptr);
+	int (*get_ras_block_maps)(struct ras_core_context *ras_core,
+			struct ras_block_map **blk_maps, uint32_t *maps_size);
 };
 
 struct ras_psp_ring {
@@ -108,6 +114,8 @@ struct ras_ta_ctx {
 
 struct ras_psp {
 	uint32_t psp_ip_version;
+	struct ras_block_map *blk_maps;
+	uint32_t maps_size;
 	struct ras_psp_ring psp_ring;
 	struct ras_psp_ctx  psp_ctx;
 	struct ras_ta_ctx   ta_ctx;
@@ -143,4 +151,6 @@ int ras_psp_query_address(struct ras_core_context *ras_core,
 		struct ras_ta_query_address_output *addr_out);
 bool ras_psp_check_supported_cmd(struct ras_core_context *ras_core,
 		enum ras_ta_cmd_id cmd_id);
+int ras_psp_get_block_ta_id(struct ras_core_context *ras_core,
+		uint32_t ras_id, uint32_t *ta_id);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
index 626cf39b75acf..92e617eca8791 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
@@ -27,6 +27,28 @@
 
 #define regMP0_SMN_C2PMSG_67                           0x0083
 #define regMP0_SMN_C2PMSG_67_BASE_IDX                  0
+static struct ras_block_map   ras_block_maps_v13_0[] = {
+	{RAS_BLOCK_ID__UMC,       RAS_TA_BLOCK__UMC},
+	{RAS_BLOCK_ID__SDMA,      RAS_TA_BLOCK__SDMA},
+	{RAS_BLOCK_ID__GFX,       RAS_TA_BLOCK__GFX},
+	{RAS_BLOCK_ID__MMHUB,     RAS_TA_BLOCK__MMHUB},
+	{RAS_BLOCK_ID__ATHUB,     RAS_TA_BLOCK__ATHUB},
+	{RAS_BLOCK_ID__PCIE_BIF,  RAS_TA_BLOCK__PCIE_BIF},
+	{RAS_BLOCK_ID__HDP,       RAS_TA_BLOCK__HDP},
+	{RAS_BLOCK_ID__XGMI_WAFL, RAS_TA_BLOCK__XGMI_WAFL},
+	{RAS_BLOCK_ID__DF,        RAS_TA_BLOCK__DF},
+	{RAS_BLOCK_ID__SMN,       RAS_TA_BLOCK__SMN},
+	{RAS_BLOCK_ID__SEM,       RAS_TA_BLOCK__SEM},
+	{RAS_BLOCK_ID__MP0,       RAS_TA_BLOCK__MP0},
+	{RAS_BLOCK_ID__MP1,       RAS_TA_BLOCK__MP1},
+	{RAS_BLOCK_ID__FUSE,      RAS_TA_BLOCK__FUSE},
+	{RAS_BLOCK_ID__MCA,       RAS_TA_BLOCK__MCA},
+	{RAS_BLOCK_ID__VCN,       RAS_TA_BLOCK__VCN},
+	{RAS_BLOCK_ID__JPEG,      RAS_TA_BLOCK__JPEG},
+	{RAS_BLOCK_ID__IH,        RAS_TA_BLOCK__IH},
+	{RAS_BLOCK_ID__MPIO,      RAS_TA_BLOCK__MPIO},
+	{RAS_BLOCK_ID__MMSCH,     RAS_TA_BLOCK__MMSCH},
+};
 
 static uint32_t ras_psp_v13_0_ring_wptr_get(struct ras_core_context *ras_core)
 {
@@ -40,7 +62,19 @@ static int ras_psp_v13_0_ring_wptr_set(struct ras_core_context *ras_core, uint32
 	return 0;
 }
 
+static int ras_psp_v13_0_get_ras_block_maps(struct ras_core_context *ras_core,
+			struct ras_block_map **blk_maps, uint32_t *maps_size)
+{
+	if (!blk_maps || !maps_size)
+		return -EINVAL;
+
+	*blk_maps = ras_block_maps_v13_0;
+	*maps_size = ARRAY_SIZE(ras_block_maps_v13_0);
+
+	return 0;
+}
 const struct ras_psp_ip_func ras_psp_v13_0 = {
 	.psp_ras_ring_wptr_get = ras_psp_v13_0_ring_wptr_get,
 	.psp_ras_ring_wptr_set = ras_psp_v13_0_ring_wptr_set,
+	.get_ras_block_maps = ras_psp_v13_0_get_ras_block_maps,
 };
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
index 4f4b323c7032b..74f00eec40782 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
@@ -23,11 +23,45 @@
  */
 
 #include "ras.h"
+#include "ta_if.h"
 #include "ras_psp_v15_0.h"
 
 #define regMPASP_SMN_C2PMSG_67                           0x0083
 #define regMPASP_SMN_C2PMSG_67_BASE_IDX                  1
 
+static struct ras_block_map   ras_block_maps_v15_0[] = {
+	{RAS_BLOCK_ID__UMC,         RAS_TA_MPASP_BLOCK__UMC},
+	{RAS_BLOCK_ID__SDMA,        RAS_TA_MPASP_BLOCK__SDMA},
+	{RAS_BLOCK_ID__GFX,         RAS_TA_MPASP_BLOCK__GFX},
+	{RAS_BLOCK_ID__MMHUB,       RAS_TA_MPASP_BLOCK__MMHUB},
+	{RAS_BLOCK_ID__ATHUB,       RAS_TA_MPASP_BLOCK__ATHUB},
+	{RAS_BLOCK_ID__PCIE_BIF,    RAS_TA_MPASP_BLOCK__PCIE},
+	{RAS_BLOCK_ID__SMN,         RAS_TA_MPASP_BLOCK__SMN},
+	{RAS_BLOCK_ID__MP0,         RAS_TA_MPASP_BLOCK__MP0},
+	{RAS_BLOCK_ID__MP1,         RAS_TA_MPASP_BLOCK__MP1},
+	{RAS_BLOCK_ID__VCN,         RAS_TA_MPASP_BLOCK__VCN},
+	{RAS_BLOCK_ID__IH,          RAS_TA_MPASP_BLOCK__IH},
+	{RAS_BLOCK_ID__MP5,         RAS_TA_MPASP_BLOCK__MP5},
+	{RAS_BLOCK_ID__ATU,         RAS_TA_MPASP_BLOCK__ATU},
+	{RAS_BLOCK_ID__DACC_BE,     RAS_TA_MPASP_BLOCK__DACC_BE},
+	{RAS_BLOCK_ID__ECLR,        RAS_TA_MPASP_BLOCK__ECLR},
+	{RAS_BLOCK_ID__KPX_SERDES,  RAS_TA_MPASP_BLOCK__KPX_SERDES},
+	{RAS_BLOCK_ID__LSDMA,       RAS_TA_MPASP_BLOCK__LSDMA},
+	{RAS_BLOCK_ID__MPART,       RAS_TA_MPASP_BLOCK__MPART},
+	{RAS_BLOCK_ID__MPIFOE,      RAS_TA_MPASP_BLOCK__MPIFOE},
+	{RAS_BLOCK_ID__MPRAS,       RAS_TA_MPASP_BLOCK__MPRAS},
+	{RAS_BLOCK_ID__NBIF,        RAS_TA_MPASP_BLOCK__NBIF},
+	{RAS_BLOCK_ID__NBIO,        RAS_TA_MPASP_BLOCK__NBIO},
+	{RAS_BLOCK_ID__OXRP,        RAS_TA_MPASP_BLOCK__OXRP},
+	{RAS_BLOCK_ID__PCIE_PL,     RAS_TA_MPASP_BLOCK__PCIE_PL},
+	{RAS_BLOCK_ID__PCS_XGMI,    RAS_TA_MPASP_BLOCK__PCS_XGMI},
+	{RAS_BLOCK_ID__PIE,         RAS_TA_MPASP_BLOCK__PIE},
+	{RAS_BLOCK_ID__CS,          RAS_TA_MPASP_BLOCK__CS},
+	{RAS_BLOCK_ID__SHUB,        RAS_TA_MPASP_BLOCK__SHUB},
+	{RAS_BLOCK_ID__SSBDCI,      RAS_TA_MPASP_BLOCK__SSBDCI},
+	{RAS_BLOCK_ID__UCIE_PCS,    RAS_TA_MPASP_BLOCK__UCIE_PCS},
+};
+
 static uint32_t ras_psp_v15_0_ring_wptr_get(struct ras_core_context *ras_core)
 {
 	return RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMPASP_SMN_C2PMSG_67);
@@ -40,7 +74,19 @@ static int ras_psp_v15_0_ring_wptr_set(struct ras_core_context *ras_core, uint32
 	return 0;
 }
 
+static int ras_psp_v15_0_get_ras_block_maps(struct ras_core_context *ras_core,
+			struct ras_block_map **blk_maps, uint32_t *maps_size)
+{
+	if (!blk_maps || !maps_size)
+		return -EINVAL;
+
+	*blk_maps = ras_block_maps_v15_0;
+	*maps_size = ARRAY_SIZE(ras_block_maps_v15_0);
+
+	return 0;
+}
 const struct ras_psp_ip_func ras_psp_v15_0 = {
 	.psp_ras_ring_wptr_get = ras_psp_v15_0_ring_wptr_get,
 	.psp_ras_ring_wptr_set = ras_psp_v15_0_ring_wptr_set,
+	.get_ras_block_maps = ras_psp_v15_0_get_ras_block_maps,
 };
diff --git a/drivers/gpu/drm/amd/ras/core/ta_if.h b/drivers/gpu/drm/amd/ras/core/ta_if.h
index 6b05c82679c02..5d4cea459954d 100644
--- a/drivers/gpu/drm/amd/ras/core/ta_if.h
+++ b/drivers/gpu/drm/amd/ras/core/ta_if.h
@@ -101,6 +101,40 @@ enum ras_ta_block {
 	RAS_TA_NUM_BLOCK_MAX
 };
 
+enum ras_ta_mpasp_block {
+	RAS_TA_MPASP_BLOCK__UMC = 0,
+	RAS_TA_MPASP_BLOCK__GFX,
+	RAS_TA_MPASP_BLOCK__SDMA,
+	RAS_TA_MPASP_BLOCK__MMHUB,
+	RAS_TA_MPASP_BLOCK__ATHUB,
+	RAS_TA_MPASP_BLOCK__PCIE,
+	RAS_TA_MPASP_BLOCK__SMN,
+	RAS_TA_MPASP_BLOCK__MP0,
+	RAS_TA_MPASP_BLOCK__MP1,
+	RAS_TA_MPASP_BLOCK__VCN,
+	RAS_TA_MPASP_BLOCK__IH,
+	RAS_TA_MPASP_BLOCK__MP5,
+	RAS_TA_MPASP_BLOCK__ATU,
+	RAS_TA_MPASP_BLOCK__DACC_BE,
+	RAS_TA_MPASP_BLOCK__ECLR,
+	RAS_TA_MPASP_BLOCK__KPX_SERDES,
+	RAS_TA_MPASP_BLOCK__LSDMA,
+	RAS_TA_MPASP_BLOCK__MPART,
+	RAS_TA_MPASP_BLOCK__MPIFOE,
+	RAS_TA_MPASP_BLOCK__MPRAS,
+	RAS_TA_MPASP_BLOCK__NBIF,
+	RAS_TA_MPASP_BLOCK__NBIO,
+	RAS_TA_MPASP_BLOCK__OXRP,
+	RAS_TA_MPASP_BLOCK__PCIE_PL,
+	RAS_TA_MPASP_BLOCK__PCS_XGMI,
+	RAS_TA_MPASP_BLOCK__PIE,
+	RAS_TA_MPASP_BLOCK__CS,
+	RAS_TA_MPASP_BLOCK__SHUB,
+	RAS_TA_MPASP_BLOCK__SSBDCI,
+	RAS_TA_MPASP_BLOCK__UCIE_PCS,
+	RAS_TA_MPASP_NUM_BLOCK_MAX
+};
+
 enum ras_ta_mca_block {
 	RAS_TA_MCA_BLOCK__MP0   = 0,
 	RAS_TA_MCA_BLOCK__MP1   = 1,
-- 
2.55.0

