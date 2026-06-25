Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E87CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10FD10F18A;
	Thu, 25 Jun 2026 08:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fxx7vXbo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABBB10F17E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLUO8Af/DoRgj3hsPLZSW/9pMxdkyy/xRLkZ7wZHYNloBE75ZKtyO7Jg8BQc3AjrYaQxjd8lHbpt+LaME3fcREMvLB9STi6enXXO3nBYHHSaGmjkpgpEFeNSuvSEgGq/1LOyDjx88q4Ay9UzIkbnDKe5Pgp2E1c6vbFAUG7xcDbpuG8oN4wcwKw0DgaI11J4vyg92dYZFYGRPIqhVv24Zf4dfyqK0lEAaKR1l76xoiuLEHjdGNjQOjQTtOfBTi0jc0JK6bDFqtk9TVys5wZ1Fil8GbZtMHdZfRSoMqlIaFJE0eX6NvST40uT0LMsglLKjh+aNYTpsIJZmTL/nHnjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUNiDJbn3P/MAmKBxG/NYCMtijjnm/0HTUyi5Pd3C+k=;
 b=DUyuvTU54q2JdudIUcN5M2ZfE2taP8ii66A1+nsfKEZ6sEKaA3RMTldcUsPGrW4Wqb61m95BBrWy3K6qP3gefXDhsVvQF5jqNhr/+FAvTV57RbxYftJNVIwhf8KIZRCqLEeulfufbRvjF3MY+chsayeKUlnpvqAo+9Bmeaw85C9jJ/X6lF9gGFCZ75r5FAQLUESATb3123ixf74/uBGAshXksLxI9eH4fqSzmKSTWF6yeZbWB+Q22pr9AWPz0g+IZSqUWdBhm2kcGqNw5sV96IGCUGST00IofxjSz0YjSCt0aoSOZe7ALaDO1VgaER21IB+SSvUV06v/HlqqcxFkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUNiDJbn3P/MAmKBxG/NYCMtijjnm/0HTUyi5Pd3C+k=;
 b=fxx7vXboDAmTmPy++sfn0Deo4ZARMskDqgz+yFu7QvD7r12Uc897KneMYRsfFPm5l0IoBONNcWx7tgNs3Lvts+vACBtCj5WD1Y9n7FJsK3kPqyshgMyTqOxIl1RV4zAgFiCLKZ9/ZZVQpZqBj+79hbT2vqoAOvioajpIOtV9RsE=
Received: from PH8P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::16)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 08:20:35 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::aa) by PH8P220CA0036.outlook.office365.com
 (2603:10b6:510:348::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:35 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:32 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 13/44] drm/amdgpu: retire pcs xgmi v6.4.0 legacy ras support
Date: Thu, 25 Jun 2026 16:19:06 +0800
Message-ID: <3a6e3840854d3a9d7e634996167d1b1dd7b1c54f.1782373701.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5bd42e-1cf9-4f32-c87d-08ded292a1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xTvwqWb/rYLH2Hl+fhY1qedB+ATI54UC0PUaGVWwyQ/rcT9lqx/SDlPkHOzEtJTl65oUjUmCl1A4ENoYV2lYh4Vx/UujCZjVrspU11Ncjiilma8HLd0Y8Ao+hDb9uhMi7BTwZtOVV2Bq3kCw+94Q9JhlsTMi4SphpDBLCoWjbRy/PQ1eKBjNoweRlmzWhJhMEsRQ8zDeacmOxsUsUuz+mOjhBJinPVfXVf4utawcgDTtvqYXegMAeR4AuG96f+9m2Bx8cWz5qcID/E4WcnZOqRBnT4f0A71MZpssEzHW5ihKE5KplWn6EiaV7EPnSeWdvaWoL5FNyN1tx3rjqdGEuw8skIOfc7N0/56rejC+j4zEpIM9kEk96yVxXO5nyTwkxZO/Rkta6eTlg7SXee6xj8rjLWgrvVU4kX6sfoZy/x5oMlbwv1CXwUkDRjnNGPi+kiZxnckoRvRgwr4cZ2B68U3B4qMTmcpoZ0+F8/09YhZR/KOllTmeOeEUTxRxZRy5hIoUqg7aVfO5Ly6kWtfVrx+vU6VlKoAuS1cu1+9a0rVJvzN7kCYRdU8JW8OL/KujxLLZaNujaKlvD7r6NdsUHR31NnK/ojGV3QlwwOckVN4YlLAw7GAWj9z4ucJINBL7HO/At4ICIKP5oxOeyos6r3dzY3zUl7SdI27PeTFuI4kjvP3ez4kRRBIJdKQ9eOTnCAVurw2srjyvlkrZMXoTcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fh6rEFGg2hWSxSK+9ZtL29Joe6YUQuXeHFpapV/h+SARWCUmZtCQ82WcqJgKtkTrr9CeobKo14jvGf2y0S+yPuN+O0h3VY4alvKJX3i4owmfJUv9KsJ8fP/5YqsXc+rb3RZWf5p81Pu/ukjYZtE/r7/4vNLRP/syR3F346T1MmAdgtDFzvUpA5Wj13ipk4FW9IObEhQa3kh+aNTGNXw4gHx9gOk+uQSCC+V/OcW+7e7ujFRg8S/7gnhsxyYiui0YZiYNUDxCLmPL9O9wzKPiUvkKBoVId+2um2MVabGBbj1pYIuULdKjaRjIhj5vDaiA0v6T4L62d5hdg1u9NefBjudw2fX0mx1uoXv5K0I0pKDy6+mBmSmA/su82iaCT+B/aQxNcU3EM+pDRAY7K0tXchRuxuS+Qp/GlCPd9pEZ9vUfM7nNYULqyulb437hL8dO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:35.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5bd42e-1cf9-4f32-c87d-08ded292a1b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
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

retire pcs xgmi v6.4.0 legacy ras support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 162 +---------------------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |   6 -
 2 files changed, 2 insertions(+), 166 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5e9012545102..5fa706915d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -116,43 +116,6 @@ static const int xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[] = {
 	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
 };
 
-static const u64 xgmi_v6_4_0_mca_base_array[] = {
-	0x11a09200,
-	0x11b09200,
-};
-
-static const char *xgmi_v6_4_0_ras_error_code_ext[32] = {
-	[0x00] = "XGMI PCS DataLossErr",
-	[0x01] = "XGMI PCS TrainingErr",
-	[0x02] = "XGMI PCS FlowCtrlAckErr",
-	[0x03] = "XGMI PCS RxFifoUnderflowErr",
-	[0x04] = "XGMI PCS RxFifoOverflowErr",
-	[0x05] = "XGMI PCS CRCErr",
-	[0x06] = "XGMI PCS BERExceededErr",
-	[0x07] = "XGMI PCS TxMetaDataErr",
-	[0x08] = "XGMI PCS ReplayBufParityErr",
-	[0x09] = "XGMI PCS DataParityErr",
-	[0x0a] = "XGMI PCS ReplayFifoOverflowErr",
-	[0x0b] = "XGMI PCS ReplayFifoUnderflowErr",
-	[0x0c] = "XGMI PCS ElasticFifoOverflowErr",
-	[0x0d] = "XGMI PCS DeskewErr",
-	[0x0e] = "XGMI PCS FlowCtrlCRCErr",
-	[0x0f] = "XGMI PCS DataStartupLimitErr",
-	[0x10] = "XGMI PCS FCInitTimeoutErr",
-	[0x11] = "XGMI PCS RecoveryTimeoutErr",
-	[0x12] = "XGMI PCS ReadySerialTimeoutErr",
-	[0x13] = "XGMI PCS ReadySerialAttemptErr",
-	[0x14] = "XGMI PCS RecoveryAttemptErr",
-	[0x15] = "XGMI PCS RecoveryRelockAttemptErr",
-	[0x16] = "XGMI PCS ReplayAttemptErr",
-	[0x17] = "XGMI PCS SyncHdrErr",
-	[0x18] = "XGMI PCS TxReplayTimeoutErr",
-	[0x19] = "XGMI PCS RxReplayTimeoutErr",
-	[0x1a] = "XGMI PCS LinkSubTxTimeoutErr",
-	[0x1b] = "XGMI PCS LinkSubRxTimeoutErr",
-	[0x1c] = "XGMI PCS RxCMDPktErr",
-};
-
 static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
 	{"XGMI PCS DataLossErr",
 	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
@@ -1176,7 +1139,7 @@ static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_status_reg
 	WREG32_PCIE(pcs_status_reg, 0);
 }
 
-static void amdgpu_xgmi_legacy_reset_ras_error_count(struct amdgpu_device *adev)
+static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	uint32_t i;
 
@@ -1215,43 +1178,6 @@ static void amdgpu_xgmi_legacy_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-static void __xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst, u64 mca_base)
-{
-	uint64_t smn_base =
-		amdgpu_reg_get_smn_base64(adev, XGMI_HWIP, xgmi_inst);
-
-	WREG64_MCA(smn_base, mca_base, ACA_REG_IDX_STATUS, 0ULL);
-}
-
-static void xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(xgmi_v6_4_0_mca_base_array); i++)
-		__xgmi_v6_4_0_reset_error_count(adev, xgmi_inst, xgmi_v6_4_0_mca_base_array[i]);
-}
-
-static void xgmi_v6_4_0_reset_ras_error_count(struct amdgpu_device *adev)
-{
-	int i;
-
-	for_each_inst(i, adev->aid_mask)
-		xgmi_v6_4_0_reset_error_count(adev, i);
-}
-
-static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
-{
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		xgmi_v6_4_0_reset_ras_error_count(adev);
-		break;
-	default:
-		amdgpu_xgmi_legacy_reset_ras_error_count(adev);
-		break;
-	}
-}
-
 static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 					      uint32_t value,
 						  uint32_t mask_value,
@@ -1305,7 +1231,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void amdgpu_xgmi_legacy_query_ras_error_count(struct amdgpu_device *adev,
+static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 						     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -1402,90 +1328,6 @@ static void amdgpu_xgmi_legacy_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += ce_cnt;
 }
 
-static enum aca_error_type xgmi_v6_4_0_pcs_mca_get_error_type(struct amdgpu_device *adev, u64 status)
-{
-	const char *error_str;
-	int ext_error_code;
-
-	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
-
-	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
-		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
-	if (error_str)
-		dev_info(adev->dev, "%s detected\n", error_str);
-
-	switch (ext_error_code) {
-	case 0:
-		return ACA_ERROR_TYPE_UE;
-	case 6:
-		return ACA_ERROR_TYPE_CE;
-	default:
-		return -EINVAL;
-	}
-
-	return -EINVAL;
-}
-
-static void __xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, struct amdgpu_smuio_mcm_config_info *mcm_info,
-					    u64 mca_base, struct ras_err_data *err_data)
-{
-	int xgmi_inst = mcm_info->die_id;
-	uint64_t smn_base;
-	u64 status = 0;
-
-	status = RREG64_MCA(xgmi_inst, mca_base, ACA_REG_IDX_STATUS);
-	if (!ACA_REG__STATUS__VAL(status))
-		return;
-
-	switch (xgmi_v6_4_0_pcs_mca_get_error_type(adev, status)) {
-	case ACA_ERROR_TYPE_UE:
-		amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, 1ULL);
-		break;
-	case ACA_ERROR_TYPE_CE:
-		amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, 1ULL);
-		break;
-	default:
-		break;
-	}
-	smn_base = amdgpu_reg_get_smn_base64(adev, XGMI_HWIP, xgmi_inst);
-	WREG64_MCA(smn_base, mca_base, ACA_REG_IDX_STATUS, 0ULL);
-}
-
-static void xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, int xgmi_inst, struct ras_err_data *err_data)
-{
-	struct amdgpu_smuio_mcm_config_info mcm_info = {
-		.socket_id = adev->smuio.funcs->get_socket_id(adev),
-		.die_id = xgmi_inst,
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(xgmi_v6_4_0_mca_base_array); i++)
-		__xgmi_v6_4_0_query_error_count(adev, &mcm_info, xgmi_v6_4_0_mca_base_array[i], err_data);
-}
-
-static void xgmi_v6_4_0_query_ras_error_count(struct amdgpu_device *adev, void *ras_error_status)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	int i;
-
-	for_each_inst(i, adev->aid_mask)
-		xgmi_v6_4_0_query_error_count(adev, i, err_data);
-}
-
-static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
-					      void *ras_error_status)
-{
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		xgmi_v6_4_0_query_ras_error_count(adev, ras_error_status);
-		break;
-	default:
-		amdgpu_xgmi_legacy_query_ras_error_count(adev, ras_error_status);
-		break;
-	}
-}
-
 /* Trigger XGMI/WAFL error */
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 			void *inject_if, uint32_t instance_mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index e8c1d0f207e7..47e0329b6f3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,10 +210,4 @@ do { \
 			amdgpu_reg_get_smn_base64(adev, ip##_HWIP, inst),   \
 		value)
 
-#define RREG64_MCA(smn_base, mca_base, idx) \
-	RREG64_PCIE_EXT(smn_base + mca_base + (idx * 8))
-
-#define WREG64_MCA(smn_base, mca_base, idx, val) \
-	WREG64_PCIE_EXT(smn_base + mca_base + (idx * 8), val)
-
 #endif
-- 
2.34.1

