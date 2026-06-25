Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C2DCDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4688A10E1F1;
	Thu, 25 Jun 2026 08:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6tHclMs";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD8510E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9Rk4tK/iKdviAmPninawTY/4dK3WVh4iI+g+Y46axSJbiDw7fWwZRATM0XH7GgEa6caYYgpQQIrta2nagL8DSGIPOiF7sdHfvCaR4fiArmB0eUKELJ0As0dwDWLEg03a99iQAasMFxLltLgB1FYrqRDIxjBvmDu3MTlCB05JajnglESV47yyVql6AmebxyQd+9hX4gznQla/pVWVRtrVhHhVa6YXER1aIMmpVQbXGHezoPslZL3BwZEfgT1o1o9IVNdmzKYIk99PaJeuYDXFRQYhf/F+iYdJ5WCHhk3B7iw70v0I9cFBBh5k14RiBQcmIoWtD9iH4YDqBMWrTEiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHNDHEHFvxG1SJSEejOjLwOJiP5lWV4bE5JB2/K+k5w=;
 b=Yc0Ne8NpE1MzTnfQHMK0X6E6KUb1pdJmVvHwIT95Y9lBXPSHAIRdlAqOlax5rGAu4TXJkfAROhGKiyoa+TCi1IVFoKj0ZNNrZ2rxazeslmBj4Q32KRSHm0aPj/mWn+mx9zRYklpvs0h8AwgQLgneTDgIq6fEKZKZX1JkRIgK2rxGXSMR3pyNqcYViOe5zM/TQ4LoFJ3Hx5MNgrhH5cwiUBOXQrTnACxn7q7hKdQtJqUM+YZSkM1AwbB7Qvr7Pka7MlVA9vs3nd1a8zYGkjxCbwlWiTb+HghKuE5TxDI8RUC6p8un4PKBRUZCkUQLa7zMcqmKee8XlmcM/1kSNtsJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHNDHEHFvxG1SJSEejOjLwOJiP5lWV4bE5JB2/K+k5w=;
 b=e6tHclMspzFw+2XiN9IP0659gT73+T87NSqkmCLQby0xsk2v7QzEikqHEoEgWTaxzSLg1JfLrApBRbb2BwAbnzvv2J3BTgaiGr4gQpC23SbC69yjq7iYUNOvSdbwxjlmxPhW1MGl8Ww8Ja9WVei9WqMMMRTzoOCOux6pTZh7k7w=
Received: from CYZPR14CA0007.namprd14.prod.outlook.com (2603:10b6:930:8f::13)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 08:20:22 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::20) by CYZPR14CA0007.outlook.office365.com
 (2603:10b6:930:8f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:22 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:20 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 07/44] drm/amdgpu: retire xgmi v6.4.0 ACA support
Date: Thu, 25 Jun 2026 16:19:00 +0800
Message-ID: <a269bf36bef3871e555787d381345aac4f056738.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa4613a-6c17-498b-c5eb-08ded2929a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: anNM6Ab/vawT+aldkY6bnd4ruWAXHTPAJHL57jG3QMxlw7vy9C1TxMGsU4/MHSl007H6mxA/XtuRkgtJY9WnI4nRJSaGalbHTHm8FX7Wr+FFYcNabRf0ZQosQ0slX6MqLsC31I0yTXePv0LEmGc72NlULqwE2m+kUEyoy934IO3cIw3b3Xu/LfRLPbRo19TWPGEBqv+VlmXio24JsqNLhJ7gGCI3RzgsJyAY1ZCBXUmz8Yk9rDfgODJ3R7V5MJnqZFoXKYMGPz5643t4KJJ3Yn23OjG5Ktf6njo4Kd0vM99/XwRtuFBY7I74nkw9m+oZ6S4rW1KTpNVwecZpxQrnTa1VhDvyU05ETpmMio5N7uHySAwsXZ5ljvUJ5sbxRxVLzHGucjS+0nGfqSeM4rC5vOGS5l1dkxy4+VGEktdzTpIInfsnm2JpV+yPeAIyssqrLeIC6iAGvkJ0uhe8Dq81zAl+Y+bs1/LJ41njvroIaurQkK8Eg3uzfTEWyaO3BHiYQMtVxMNarFS/mplZxAlRfqjFe/5g+bfRMyNErHOoGDqfa7WvfxSVV4wY5ghZ1MAQ0KZzHzTVFtXoR6fnz+6RoqftcJLeum3j1tOuP19PTIDiZrQkhurd0uvIsNon6+IbbyGO8KAUwkqqI33z6nZdN9Gr+fPkd8xfJckPSKKMWZ1/RFR7osS0c3u0G/CNkAc19DpU7OKrP+/rQGTcuWtIHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oh6TDItCa/AfleYLtwcbaQAxwQlm47A5+YwBHfGctlOPvTMlCeRY7Z1ZFb+fmEwDHRfBSr7fpw/r4dxz3h/QShRX6yZk7ZXzu5PsDApinfZk7vIrYnlgtJxpsjJXwhzslkdJXiXLpoRjBFOsI5CxlAPzUmds3Ef7csTD8FzpvyIDZXAfnGjaJk0tGj7nXm+yPEWufd9+kgk0qCpCTtfNoWlNGHUltdYTpc5MunYkihqS4AfDBzYLpcWezI/XxePsg1enwTn5x5b4JA45VrpDorUeXb7qS2984pMz8hnNfAsJesEvYJJodi8p91hv9oiqnoHFJNQbIheH+XBE/h7LnJiOD8PFcC7mspSLw1Bhd0FB3wtQdQqCNZUl0s+6wjRuORc/C4qqfSq2uB/Ex6g+56rcnwtPWo6yHzPgoUp9CDQD8Ue00CPRkDcLBF3qT7XT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:22.6982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa4613a-6c17-498b-c5eb-08ded2929a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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

retire xgmi v6.4.0 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 78 +-----------------------
 1 file changed, 1 insertion(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index faac80a8a6eb..5e9012545102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1152,91 +1152,15 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				       enum aca_smu_type type, void *data)
-{
-	struct amdgpu_device *adev = handle->adev;
-	struct aca_bank_info info;
-	const char *error_str;
-	u64 status, count;
-	int ret, ext_error_code;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	status = bank->regs[ACA_REG_IDX_STATUS];
-	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
-
-	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
-		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
-	if (error_str)
-		dev_info(adev->dev, "%s detected\n", error_str);
-
-	count = ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]);
-
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		if (ext_error_code != 0 && ext_error_code != 1 && ext_error_code != 9)
-			count = 0ULL;
-
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE, count);
-		break;
-	case ACA_SMU_TYPE_CE:
-		count = ext_error_code == 6 ? count : 0ULL;
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, count);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-static const struct aca_bank_ops xgmi_v6_4_0_aca_bank_ops = {
-	.aca_bank_parser = xgmi_v6_4_0_aca_bank_parser,
-};
-
-static const struct aca_info xgmi_v6_4_0_aca_info = {
-	.hwip = ACA_HWIP_TYPE_PCS_XGMI,
-	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
-	.bank_ops = &xgmi_v6_4_0_aca_bank_ops,
-};
-
 static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
-	int r;
-
 	if (!adev->gmc.xgmi.supported ||
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
 	amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);
 
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL,
-					&xgmi_v6_4_0_aca_info, NULL);
-		if (r)
-			goto late_fini;
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
+	return amdgpu_ras_block_late_init(adev, ras_block);
 }
 
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
-- 
2.34.1

