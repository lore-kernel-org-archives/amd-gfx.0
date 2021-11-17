Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC06C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 10:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B054361002
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 10:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B054361002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4432E6E434;
	Wed, 17 Nov 2021 10:11:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8FE6E434
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 10:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCN263Kz23sqqEfyevEHv2FqeUK144KE4mBzu1TFbAM2JAYfu3IXFGFjy1vgEfodvv2LJNnj0AHu4Ys8oMQx0KSHNJ6pEUV5BIrIN09s+LJWrl0Zwx8WxTigTsZ/Mot/hs5zzpwcj3wA5Q6uhYKZsg9tRDv+uaQ7OIHoT16P0+Agyn2ahCsfCLSqGv3wfH2ce4gYy3VjU2ILdy9OyCBkRQHbi+jP8NeKSgFmmCJ2ns3UpW98huidnH6K0z0fu1rR7uqDRmdzW9KuYDBdyM9VfaEyg4wDdKnO7PnvrFs53DpJd2/94+CYL/B9prX5ZOSLUvDYzd5cxEkAYPQxBxgJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPkwTsFBr6aPDbWIZtloMPKTDOW4mW0z5epAnZWuU80=;
 b=iEFwIa5ApTTdLMZ1ZQPi1n3jCs3zm//xi1awCEdvlK9h10mQQRaxrFkZmJO1YI3ne6qrleABOJaqV71z7suT2SdjmL4LFnUQiVRwe885gFkszzC88v15MYFHWZRCYIRv8pTOyQb7U1h32wtqLrCIAnzRyfhCxZQjcb6pGfONKvF5MSA+IemApqeWpk6xCZC5ohJ7q+ekJjXCwh7ZkcLOaLSNEl2EySk3grQlA3qcQniLsaRIfaAm1dIdOGBfGKnCNte5UD3ltG1g+0i8E+VxTri60N4Jh8ryFBKblaI6cRIQCnPK8VmAGFjsh84kchIHN9c7uqbqfjspWEfv1OF9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPkwTsFBr6aPDbWIZtloMPKTDOW4mW0z5epAnZWuU80=;
 b=x/B2iGMX4lWq1b4X805UWTjxXGJbdI7PeoU2/A0AKL974Ct+vwS+ZvKWX+9WWwKx5cpmrT5RChsZEwygwFJVlZlH1e9/iSe2AN7R69MynFeCQmpsXDi8BE3iRwWrDHEDLPAfznP2QaARW828hgMtRNUvEUQ5fvseQewILP0+xIA=
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Wed, 17 Nov
 2021 10:11:49 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::ad) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 10:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 17 Nov 2021 10:11:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 04:11:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 04:11:48 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 17 Nov 2021 04:11:46 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH Review 4/4] query umc error info from ecc_table
Date: Wed, 17 Nov 2021 18:11:32 +0800
Message-ID: <20211117101132.6568-4-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117101132.6568-1-Stanley.Yang@amd.com>
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa749556-4acd-4791-11b1-08d9a9b2ab75
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4199DE6FA7CD0CC0A4391A1B9A9A9@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:106;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ikIAnUw4zrhkcapDmWeP9rJsLu8KpNM20RyOVFaxyLhc1nAHgcv34wJyzcYsI0XcTSnL2os92MnFaeLoWJHz1DWV12Q5c+Olk9YtYLP2DQBCpSfVciJ/Y2TRY+xBqF4K9WpXst0e7/EWL2cs2YYkxBYpRyacravV0eey+/vDeZFn6B8BUKsaT/gK3uW5u8+f1KDkrRgVbZihEIjoq83JG4eSEhor4sM7K97p9xTg5N234xeCEaUkeA1HzY2JHPEnAZn03Cbdvq0ioVgP68YmrRf+3sTR+VboogZDXoARGHMySRyWfWxesuXXk44Gq3Q66k85eK1w/rENR7opEXpCMmX/oh5c3CAX2vfJ8jDQwvd80rgNN9LY0y+YGT9TWjYOA95qBEfO5rCqsKSVfDDxvzvZXjFdHpj6/Agci0etTxGL987GCOvSaBX14O+3LZhn8kjmbkaN5gJHlmae1cxypKIF4CfFbVNb4l8eGbRyy6qVhgOW2OBme1fQmAT9FNnYAFEA1jOb+qon8IOaAI4ahFNEHXzRPNnEe1IGDtiHv1PFtW+0+esFvCL47trML1akxC2h1jTHZ4nv0nvZd4zB6QIXRDTcx1JQT2itENFfoAVQwEm/vu2g7kGXzceVGqAhJEuTLFCGWsKA5IfHM2rrwM+x/k0HdM10DlwpFszF03NFhWPMjVyUEYHgeRMH9jRHu46gl0dYa981bmTCv9QxaMUs8FaMKxbE26eTk1sSNM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(81166007)(6666004)(316002)(26005)(1076003)(6636002)(336012)(426003)(36860700001)(70586007)(8676002)(110136005)(8936002)(86362001)(2616005)(83380400001)(7696005)(70206006)(356005)(82310400003)(4326008)(5660300002)(47076005)(36756003)(508600001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 10:11:49.3865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa749556-4acd-4791-11b1-08d9a9b2ab75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if smu support ECCTABLE, driver can message smu to get ecc_table
then query umc error info from ECCTABLE
apply pmfw version check to ensure backward compatibility

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 42 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 71 +++++++++++++------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  4 ++
 6 files changed, 107 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 90f0db3b4f65..6b0f2ba1e420 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -888,6 +888,38 @@ void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
 	}
 }
 
+static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_data *err_data)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	/*
+	 * choosing right query method according to
+	 * whether smu support query error information
+	 */
+	if ((ras->smu_version >= SUPPORT_ECCTABLE_SMU_VERSION) &&
+			!smu_get_ecc_info(&adev->smu, (void *)&(ras->umc_ecc))) {
+
+		if (adev->umc.ras_funcs &&
+			adev->umc.ras_funcs->message_smu_query_ras_error_count)
+			adev->umc.ras_funcs->message_smu_query_ras_error_count(adev, err_data);
+
+		if (adev->umc.ras_funcs &&
+			adev->umc.ras_funcs->message_smu_query_ras_error_address)
+			adev->umc.ras_funcs->message_smu_query_ras_error_address(adev, err_data);
+	} else {
+		if (adev->umc.ras_funcs &&
+			adev->umc.ras_funcs->query_ras_error_count)
+			adev->umc.ras_funcs->query_ras_error_count(adev, err_data);
+
+		/* umc query_ras_error_address is also responsible for clearing
+		 * error status
+		 */
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_address)
+			adev->umc.ras_funcs->query_ras_error_address(adev, err_data);
+	}
+}
+
 /* query/inject/cure begin */
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
@@ -901,15 +933,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_count)
-			adev->umc.ras_funcs->query_ras_error_count(adev, &err_data);
-		/* umc query_ras_error_address is also responsible for clearing
-		 * error status
-		 */
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_address)
-			adev->umc.ras_funcs->query_ras_error_address(adev, &err_data);
+		amdgpu_ras_get_ecc_info(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->query_ras_error_count) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bcbf3264d92f..3f0de0cc8403 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -322,6 +322,12 @@ struct ras_common_if {
 
 #define MAX_UMC_CHANNEL_NUM 32
 
+/*
+ * SMU support ECCTABLE since version 68.42.0,
+ * use this to decide query umc error info method
+ */
+#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
+
 struct ecc_info_per_ch {
 	uint16_t ce_count_lo_chip;
 	uint16_t ce_count_hi_chip;
@@ -375,6 +381,7 @@ struct amdgpu_ras {
 
 	/* record umc error info queried from smu */
 	struct umc_ecc_info umc_ecc;
+	uint32_t smu_version;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0c7c56a91b25..2c3e97c9410b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -97,28 +97,57 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_count)
-	    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
 
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_address &&
-	    adev->umc.max_ras_err_cnt_per_query) {
-		err_data->err_addr =
-			kcalloc(adev->umc.max_ras_err_cnt_per_query,
-				sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-		/* still call query_ras_error_address to clear error status
-		 * even NOMEM error is encountered
-		 */
-		if(!err_data->err_addr)
-			dev_warn(adev->dev, "Failed to alloc memory for "
-					"umc error address record!\n");
-
-		/* umc query_ras_error_address is also responsible for clearing
-		 * error status
-		 */
-		adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
+	if ((con->smu_version >= SUPPORT_ECCTABLE_SMU_VERSION) &&
+			!smu_get_ecc_info(&adev->smu, (void *)&(con->umc_ecc))) {
+
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->message_smu_query_ras_error_count)
+		    adev->umc.ras_funcs->message_smu_query_ras_error_count(adev, ras_error_status);
+
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->message_smu_query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if(!err_data->err_addr)
+				dev_warn(adev->dev, "Failed to alloc memory for "
+						"umc error address record!\n");
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras_funcs->message_smu_query_ras_error_address(adev, ras_error_status);
+		}
+	} else {
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_count)
+		    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
+
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if(!err_data->err_addr)
+				dev_warn(adev->dev, "Failed to alloc memory for "
+						"umc error address record!\n");
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
+		}
 	}
 
 	/* only uncorrectable error needs gpu reset */
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index ea65de0160c3..7a06021a58f0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1404,6 +1404,7 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
+int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 01168b8955bf..6340c079f35e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3072,6 +3072,18 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable)
 	return ret;
 }
 
+int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
+{
+	int ret = -1;
+
+	if (smu->ppt_funcs &&
+		smu->ppt_funcs->get_ecc_info)
+		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
+
+	return ret;
+
+}
+
 static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 55421ea622fb..55ef10ca684a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -200,11 +200,15 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	uint16_t smu_major;
 	uint8_t smu_minor, smu_debug;
 	int ret = 0;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(smu->adev);
 
 	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret)
 		return ret;
 
+	/* record smu interface version, help umc query error method */
+	ras->smu_version = smu_version;
+
 	smu_major = (smu_version >> 16) & 0xffff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
-- 
2.17.1

