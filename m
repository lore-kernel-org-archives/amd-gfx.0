Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F6BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 17:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D454D10E24A;
	Mon, 28 Mar 2022 17:08:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E224410E24A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 17:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1dXAdcgYDQFEy6TtQz3kwWx5LY49vvA5JVy3jJgG4YWwTS/vYsk6G3t/GBi/YorG5ahpdeQGSfoSKqAGFILm932G+d0HtG5ZwsqddAD4U0fb4P9Uj6+nbbKkwO0Yr5KKJtxf8zDE/O6GWYdvOaX5EAYk5ZPAPSCRgFmZmnVZvUBe4aKJc/zHSfPsSalsiEOjnQLR+1pY9zBNlO7dqGup7e5CJifxyF+qVbPtsCb2+DfCdUStHsWgKhldxF/hYexSg0KlDjayliXV9lMWbn4tLKvH7E2DqjioIlsetOXM4/6D90qFbCh5sSjKa+l4NdGaTZBxH+m6eOneI+hHPXvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdmYQbQ1cdHa3rVl7hf9q76coGhV4Mm3Szlk97eba3U=;
 b=EdnoGJuSbsZ21K9h8Klpkz7RufyDIzHDK4T9oO1eZ5OHXUJ6ENN6s6Z0b6p5WY/Rv9MiaU6f0fPwAfFa4Hj1n61F5jYHmLLYSBchIV6l6/1PyW5pgMJA6HktJ+X4l+oyVEADaODDnx/9BXvWG/OOurXvjFxPIW7HDJPOOVVoF0n/egoWnnsE0Alj0C5fMqoAOgtrOCRafVPPwpaRxOk4E3QtpCBHMVcvrow9qjpYFYbGoxjQma+3lL0O9X6TXZDUM7VIh7knbUvdyng4nCwuptVLxU0WZSfoCCoNXnGMBYh/Jq0++mV1F5pIvLV21ypBeVV4+HF4acDh8CvQ+8f2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdmYQbQ1cdHa3rVl7hf9q76coGhV4Mm3Szlk97eba3U=;
 b=JmRiZJQCIcyEV3DQHY98di+AFFcxtI12e35ZMdUJNBT1jY+gjDIrDrFvZ917kN8k1qJfSIdxxGhoBZMP6xIWPTL2iYeej7gQar9kvA3NWMAmKQk246VXrX/CAPbV9Yp0wMxFlE141sRn3P5aMh/2jdYX2dvd13WLgZXzwKSdzKE=
Received: from BN9PR03CA0427.namprd03.prod.outlook.com (2603:10b6:408:113::12)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 17:08:15 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::b7) by BN9PR03CA0427.outlook.office365.com
 (2603:10b6:408:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 17:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 17:08:14 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:08:14 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Date: Mon, 28 Mar 2022 13:07:59 -0400
Message-ID: <20220328170759.1267968-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328170759.1267968-1-kent.russell@amd.com>
References: <20220328170759.1267968-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3990de4-c50d-4fa3-4853-08da10dd8c14
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50610FAF3540C4C370CD57DE851D9@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BjLk2PwUBI2Ki0UUz74wsOLvlIbaBGi3vgGcETV77AOBTLkOZXKZroaXch8/2DjYJfEeyXyvC235OTixHrN6SXoQRFeFIzDxBxz1UdAeNb4SOjA07bLSaorzElcLnetETVeulCr+TGPC9aYTs0hR8Gzm5NtOwDl1mweOPj8dv9HqxVO6J2XzWWRvIZZO3DeOBHenTZPjBT4fR5jNKQeZB+jyy3+r5zy9Kl65C1ozilVf2JpBEIl+A41mYAFGa5BCO18oO5A0/Fb7SWL8NWhnTOPZUby42IQXDidUlaB1hIVCbTMLTuh5MCzxiVzSlvFG9ayq8cSNflrzYDdv4IMtItY9XLvbrQyw2iVAmLCdkj3W8L9xt8Nc9ypmJoQJsl754PRFjZXGIQZFVb7tBY5yzirYbIW2VRXIwbQtVFaDc6o/kLuNglt8N2e7BhanZgJFDfplvwmh4UhMRWm2pch1Grhs3xHLkTX4uTzqExjg2DylMj/t/c8D1kEVqBs+TOwGJkvFWkDYrMQ7lTmfdhuq0/T4ivWerh26eK1T0/SiZ++LHzi1FupQkGNMEGefsGFDEwr2xVq5Ls22P5HRVmeW1WLvVzBXsdKio0jkFaslQFaJqFzFMDgcteoxEl+Mtdgi7Ou2pYhSnVSebwgBgx2Gw/Z543s3Z57XVyHsh/3aD07aTaNU+UsEWwKyqSbIpA6NMejIH0xE6NbEVFUivpS4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(40460700003)(4326008)(70586007)(70206006)(44832011)(8936002)(508600001)(36860700001)(81166007)(356005)(36756003)(47076005)(1076003)(2616005)(6666004)(2906002)(5660300002)(83380400001)(82310400004)(6916009)(54906003)(7696005)(26005)(336012)(86362001)(186003)(16526019)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:08:14.9677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3990de4-c50d-4fa3-4853-08da10dd8c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is being added to SMU Metrics, so add the required tie-ins in the
kernel. Also create the corresponding unique_id sysfs file.

v2: Add FW version check, remove SMU mutex
v3: Fix style warning
v4: Add MP1 IP_VERSION check to FW version check

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 10 ++++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 37 +++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4151db2678fb..4a9aabc16fbc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(9, 4, 0):
 		case IP_VERSION(9, 4, 1):
 		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(10, 3, 0):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index 3e4a314ef925..037f38b0fa15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
@@ -1419,8 +1419,11 @@ typedef struct {
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
-  uint16_t Padding16_2;
 
+  uint32_t PublicSerialNumLower32;
+  uint32_t PublicSerialNumUpper32;
+
+  uint16_t Padding16_2;
 } SmuMetrics_t;
 
 typedef struct {
@@ -1476,8 +1479,11 @@ typedef struct {
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
-  uint16_t Padding16_2;
 
+  uint32_t PublicSerialNumLower32;
+  uint32_t PublicSerialNumUpper32;
+
+  uint16_t Padding16_2;
 } SmuMetrics_V2_t;
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..140005bf6d9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -481,6 +481,42 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
 	return sienna_cichlid_patch_pptable_quirk(smu);
 }
 
+static void sienna_cichlid_get_unique_id(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	SmuMetrics_t *metrics =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
+	SmuMetrics_V2_t *metrics_v2 =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
+	uint32_t upper32 = 0, lower32 = 0;
+	bool use_metrics_v2;
+	int ret;
+
+	/* Only supported as of version 0.58.83.0 and only on Sienna Cichlid */
+	if (smu->smc_fw_version < 0x3A5300 ||
+	    smu->adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7))
+		return;
+
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	if (ret)
+		goto out_unlock;
+
+	use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
+		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
+
+	upper32 = use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
+				   metrics->PublicSerialNumUpper32;
+	lower32 = use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
+				   metrics->PublicSerialNumLower32;
+
+out_unlock:
+
+	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
+	if (adev->serial[0] == '\0')
+		sprintf(adev->serial, "%016llx", adev->unique_id);
+}
+
 static int sienna_cichlid_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -4182,6 +4218,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_ecc_info = sienna_cichlid_get_ecc_info,
 	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
 	.set_config_table = sienna_cichlid_set_config_table,
+	.get_unique_id = sienna_cichlid_get_unique_id,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

