Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3799C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D906F10E731;
	Wed,  8 Nov 2023 12:58:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19A710E72E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVGufL9KUCUBnicgcmpphMDqO9PArljNvRnzGo+k8EwICoGrpkkOOsU4v2gCUCvROiz0VnUQ+f3wpKYwCSeQbXyweovOTNtvDtN2tqFyHaBrBNNzB7rotWTpsOmjXK6SFLiEyF9nSbT4JamJxp1nO0z3MFq9V9nnyxjNEljMORUdbNLY+Il5WCnD8fnskEyYhBxnxdOK4vqZp2Ly0vmrxc7OzEQg8mjKVLRf8AfWm+PH7B2m24cdQ6/OrJ8PuXFe34HyoKCBLgkHSeFkzxdtssi86fKb+6XS+LyvFLgmUq3jnILthSb+r+XwTDtE9QnvBMmoyB6aKqCO3WaxiPfl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBWQyWR7zLu+nXTkDGX9AaCjujkPKgVlDHptnrU8f4w=;
 b=SxAYnbhK3+ohGfqlQsid5NAS4PQhUxdo1uRbuEKwFtxpY0W2BROhs0n/g7W21cKtwJhPwaSjLCch+mABckgof3NeXx8JpFPDeExo8lIs1Oq4XnhlmM7eukR0X/ZSQpKIYA2aJ5W1xh3UpUHEouoGEUzEfrDUjWuYCEDV7EpQymQbh3pu6ITfrCKv2F7Ij/3Bd/FQRGJmavTcFniG3BkEYWV0CpTTrcOa+n4yrvQCNbAzLyTOKZRJE/7KaqVR1Rn1061EP5DXsuvzyLyhczPW+HSqPBz1dqy46LyTrWG4uuXZvV7vsCIc1K9VeyiqROYgtFNGirurRG63SmzSZnkrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBWQyWR7zLu+nXTkDGX9AaCjujkPKgVlDHptnrU8f4w=;
 b=yaNUNa1C5moW81HXxGDR2EBcTGP5cquQOxSUbKIOxzSrJMB5iGiH3SNCI0yjWel3kwlVaHjKqCkWvWGReJGXKYd/MOJeKM5Q5VNpLIAjNMRzANecQ+7c5RVUyuLaWLKKABtuHU5yUHY9KESE5xQTYPT2IvYPbxvppjJDPaaFhn4=
Received: from SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) by PH7PR12MB6858.namprd12.prod.outlook.com
 (2603:10b6:510:1b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 12:58:05 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::bc) by SN4PR0501CA0112.outlook.office365.com
 (2603:10b6:803:42::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 12:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 12:58:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 06:58:04 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: add pcs xgmi v6.4.0 ras support
Date: Wed, 8 Nov 2023 20:57:33 +0800
Message-ID: <20231108125735.2497856-5-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108125735.2497856-1-kevinyang.wang@amd.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4711ee-a59f-47bf-c7f1-08dbe05a5989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFo3Levw0aq3q9GxKkJRoWZ0vsrFZkVYYFyZvsgHwjdaCLGp+22H+yVIaYaAoLE437ECZQuLlzWIdenLv8kqXMZ65z+iWcS4oWcnGcbSeY46bfsNNHGJFshdoCuWVEVuj47+QbnuKIqfD7GuIalADDaFiPnOGU/57RmCm2q5JuBcZ0e+m5YuZr1Pu9cB8ZVF6zQPE2O5yBBKdOmxFlQG05S836KNq1/4pBWZ5O331/KiC1sCVpL2BZdI9bJSRPhJ++xyy83hjiChI+FkhZ+QlB2jdkQLNLrql5besQmHJsJJsqEqc6SlwkgunYLaStEXTiEcPBa/qemmqeAyLwigD7xxAg8Uf0EPawTSlejJ2kAsCRldHdAf7UHoWeNifyoSqOqOtgZ0KAt49eqT3oSqwgWV6yjuh2iMfsIEc+4b00eOhe5F/4oJIa2nVyKgCFFK/c9e36aoP/AIMp234zwLliE0zhhnl9wDv+uFMXxi6x9aSXRzu9wbTiRrDvWkug/1DPZFmWZcYd5zoMqKAf66ETrk2fRz4Yr4rI2rW5DnfNFYAZ1ditqwDC1b/wnwUMKSqw2LtHlsh3eTH3dTvTd2JCn2yCVnu8UKcsInNs00sUylMYOZgpeNzrqykm5Pg9I5vhCc4vHsNB193Jo8WV5cw7hcIHzn5CZwvPz/uv3+mQF4JtTX0ZlCDmzRDHS0+fDccqG04M4jZ63yph/ISSfz5P/5zRPoBvw33IcUMspdNuSHmMH6nlYTZeoRaP+3FHdf8OomfRqZ/Rrn71lXRodi9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(2906002)(40480700001)(356005)(8676002)(4326008)(41300700001)(81166007)(83380400001)(36860700001)(86362001)(47076005)(5660300002)(40460700003)(336012)(70586007)(426003)(82740400003)(70206006)(8936002)(1076003)(2616005)(6916009)(7696005)(6666004)(54906003)(316002)(478600001)(26005)(16526019)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:58:05.6312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4711ee-a59f-47bf-c7f1-08dbe05a5989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add pcs xgmi v6.4.0 ras support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 158 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |   6 +
 2 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 1eeb0a517d80..bd20cb3b9819 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -113,6 +113,43 @@ static const int xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[] = {
 	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
 };
 
+static const u64 xgmi_v6_4_0_mca_base_array[] = {
+	0x11a09200,
+	0x11b09200,
+};
+
+static const char *xgmi_v6_4_0_ras_error_code_ext[32] = {
+	[0x00] = "XGMI PCS DataLossErr",
+	[0x01] = "XGMI PCS TrainingErr",
+	[0x02] = "XGMI PCS FlowCtrlAckErr",
+	[0x03] = "XGMI PCS RxFifoUnderflowErr",
+	[0x04] = "XGMI PCS RxFifoOverflowErr",
+	[0x05] = "XGMI PCS CRCErr",
+	[0x06] = "XGMI PCS BERExceededErr",
+	[0x07] = "XGMI PCS TxMetaDataErr",
+	[0x08] = "XGMI PCS ReplayBufParityErr",
+	[0x09] = "XGMI PCS DataParityErr",
+	[0x0a] = "XGMI PCS ReplayFifoOverflowErr",
+	[0x0b] = "XGMI PCS ReplayFifoUnderflowErr",
+	[0x0c] = "XGMI PCS ElasticFifoOverflowErr",
+	[0x0d] = "XGMI PCS DeskewErr",
+	[0x0e] = "XGMI PCS FlowCtrlCRCErr",
+	[0x0f] = "XGMI PCS DataStartupLimitErr",
+	[0x10] = "XGMI PCS FCInitTimeoutErr",
+	[0x11] = "XGMI PCS RecoveryTimeoutErr",
+	[0x12] = "XGMI PCS ReadySerialTimeoutErr",
+	[0x13] = "XGMI PCS ReadySerialAttemptErr",
+	[0x14] = "XGMI PCS RecoveryAttemptErr",
+	[0x15] = "XGMI PCS RecoveryRelockAttemptErr",
+	[0x16] = "XGMI PCS ReplayAttemptErr",
+	[0x17] = "XGMI PCS SyncHdrErr",
+	[0x18] = "XGMI PCS TxReplayTimeoutErr",
+	[0x19] = "XGMI PCS RxReplayTimeoutErr",
+	[0x1a] = "XGMI PCS LinkSubTxTimeoutErr",
+	[0x1b] = "XGMI PCS LinkSubRxTimeoutErr",
+	[0x1c] = "XGMI PCS RxCMDPktErr",
+};
+
 static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
 	{"XGMI PCS DataLossErr",
 	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
@@ -936,7 +973,7 @@ static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_status_reg
 	WREG32_PCIE(pcs_status_reg, 0);
 }
 
-static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
+static void amdgpu_xgmi_legacy_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	uint32_t i;
 
@@ -974,6 +1011,39 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
+static void __xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst, u64 mca_base)
+{
+	WREG64_MCA(xgmi_inst, mca_base, MCA_REG_IDX_STATUS, 0ULL);
+}
+
+static void xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xgmi_v6_4_0_mca_base_array); i++)
+		__xgmi_v6_4_0_reset_error_count(adev, xgmi_inst, xgmi_v6_4_0_mca_base_array[i]);
+}
+
+static void xgmi_v6_4_0_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	int i;
+
+	for_each_inst(i, adev->aid_mask)
+		xgmi_v6_4_0_reset_error_count(adev, i);
+}
+
+static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+		xgmi_v6_4_0_reset_ras_error_count(adev);
+		break;
+	default:
+		amdgpu_xgmi_legacy_reset_ras_error_count(adev);
+		break;
+	}
+}
+
 static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 					      uint32_t value,
 						  uint32_t mask_value,
@@ -1025,8 +1095,8 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
-					     void *ras_error_status)
+static void amdgpu_xgmi_legacy_query_ras_error_count(struct amdgpu_device *adev,
+						     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	int i, supported = 1;
@@ -1121,6 +1191,88 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += ce_cnt;
 }
 
+static enum amdgpu_mca_error_type xgmi_v6_4_0_pcs_mca_get_error_type(struct amdgpu_device *adev, u64 status)
+{
+	const char *error_str;
+	int ext_error_code;
+
+	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(status);
+
+	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
+		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
+	if (error_str)
+		dev_info(adev->dev, "%s detected\n", error_str);
+
+	switch (ext_error_code) {
+	case 0:
+		return AMDGPU_MCA_ERROR_TYPE_UE;
+	case 6:
+		return AMDGPU_MCA_ERROR_TYPE_CE;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static void __xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, struct amdgpu_smuio_mcm_config_info *mcm_info,
+					    u64 mca_base, struct ras_err_data *err_data)
+{
+	int xgmi_inst = mcm_info->die_id;
+	u64 status = 0;
+
+	status = RREG64_MCA(xgmi_inst, mca_base, MCA_REG_IDX_STATUS);
+	if (!MCA_REG__STATUS__VAL(status))
+		return;
+
+	switch (xgmi_v6_4_0_pcs_mca_get_error_type(adev, status)) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+		amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, 1ULL);
+		break;
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, 1ULL);
+		break;
+	default:
+		break;
+	}
+
+	WREG64_MCA(xgmi_inst, mca_base, MCA_REG_IDX_STATUS, 0ULL);
+}
+
+static void xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, int xgmi_inst, struct ras_err_data *err_data)
+{
+	struct amdgpu_smuio_mcm_config_info mcm_info = {
+		.socket_id = adev->smuio.funcs->get_socket_id(adev),
+		.die_id = xgmi_inst,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xgmi_v6_4_0_mca_base_array); i++)
+		__xgmi_v6_4_0_query_error_count(adev, &mcm_info, xgmi_v6_4_0_mca_base_array[i], err_data);
+}
+
+static void xgmi_v6_4_0_query_ras_error_count(struct amdgpu_device *adev, void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	int i;
+
+	for_each_inst(i, adev->aid_mask)
+		xgmi_v6_4_0_query_error_count(adev, i, err_data);
+}
+
+static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
+					      void *ras_error_status)
+{
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+		xgmi_v6_4_0_query_ras_error_count(adev, ras_error_status);
+		break;
+	default:
+		amdgpu_xgmi_legacy_query_ras_error_count(adev, ras_error_status);
+		break;
+	}
+}
+
 /* Trigger XGMI/WAFL error */
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 			void *inject_if, uint32_t instance_mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index da683afa0222..311210f6b6c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -204,4 +204,10 @@
 			+ adev->asic_funcs->encode_ext_smn_addressing(ext), \
 			value) \
 
+#define RREG64_MCA(ext, mca_base, idx) \
+	RREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8))
+
+#define WREG64_MCA(ext, mca_base, idx, val) \
+	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
+
 #endif
-- 
2.34.1

