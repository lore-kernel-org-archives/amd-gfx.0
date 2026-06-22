Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CCDCDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEBFC10E54E;
	Mon, 22 Jun 2026 08:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="32dMHjpJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DC710E54E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc4L5oxUH1thRJqSTdoQOViozhnBaaNN72k6/fRh8BljdS46ZqWxPCV4r3bvrLlK9Nq4DH0KMgZDx68cT1cfZm8JimHwuM4kixKLY8ikHdC0Ivx0+ZUOzCLaaivpLlE5aFIsec/OG7r6hSz5zEwtHnurF8PpfmgFrnIswEHqdyBJ6vBIdm/iZz5iZocxdYCUQRSPYxRVk0Oa0mgXE6P2ufSTAzs1Ea6uq+pWGZeBYqAUDlb3GrwOT7LXzrJ7dzlM0V3kWULldQIoiflwi+OdREZs/mE5ga/apZR9DG+bzaOzJOnAbF1t/g7GUpPWo4CnrraZ1r7maO1ELsRg/nmDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0d32WSbPjKrt/6GgkfFxDGqIfuAibukozeMLbrOW7k=;
 b=QDuyqtz/+pNaCiGciTjO0IaGJKt9YbgpV6oEHrv4opKfBvJmT7u1hqoGbc3QScw2Mn0/Ufqjhge+KQL4KwDv1QmQ17/icvi+qZP6gOepsPPO4Oqk8uQ4eqgr6s4Upfrww0Kz4ern5QdvQv5ydghZ1PtmiTUEOmWJgr/v9LHBApZWNg4+U4w1k/mODTkAZRJsX2W5uBMYm/oOAgqUL0CmB0T3tutxW53WA/DuP7PWfiYyKZj6qqevklsveVaUW6PdLrp85yCh2uCxIzMfDkf4OBl+wIrf2JV97ukW/wHYPRfHqZLmLps2D3Mpt8ptvoFcg6yRXsT64JuwkOaevTGkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0d32WSbPjKrt/6GgkfFxDGqIfuAibukozeMLbrOW7k=;
 b=32dMHjpJawUobhqkXcYaxnvNDOGNoyIAMw7nWQngAtpZI8h4m4vwtXXKWlA+AbBJ/QfTOQ4dMxqer7V13U5MOfZbHnCRE9XhlEHb2QBzYBZ1RmQJi5LB2bgYo7uDsJulZ7WvOmGPO1ZXcJIdtbHqTP1qA6ndqWZ1BJ2SM/ED1pE=
Received: from CY8PR19CA0043.namprd19.prod.outlook.com (2603:10b6:930:6::14)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 08:45:20 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::10) by CY8PR19CA0043.outlook.office365.com
 (2603:10b6:930:6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:20 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:15 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 04/48] drm/amdgpu: retire ACA support for vcn v5.0.1
Date: Mon, 22 Jun 2026 16:44:06 +0800
Message-ID: <c6e7a01ce593c48b54b6ed4bc5ec758adbc805ce.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f63457-372f-4cd3-8572-08ded03a977b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JNtN5goBVqWCu8YoioM3Y/bkdw22MsehZggUhr4AZwS9J9Ap05bPCO3uOSgzCUOJCVEbWPh/a8XLp5VdwdvuMkdQcEbsLXDZBhhspXCPbCc4/mSIEz1eJzPv5Z9n+lkuCXLzE/UcbZTODvinT1bzuXa0ze8Htf0LyJsV2lgoHQQEeQFw6jt2u9D9R/5c0hmFUc2/2a9z+gklLNmEAYmSWwOwOMwbGBuySvUQL9FgKGDG+TR6kI4HzgZdkL8n6p/+V/iQpwqxn4Rac92FUtG94DcYLh+xQ+hcNk5dw+e1Cq7ZtBwz4bjdYUZp8vuYSRgJrgu4ka3n6iG8Zcka/ydnK8KqvsxTkgFv4lNSnqm+ZdCrpyFdnS2VLAgZOMatEk9SqZb1PPokdCqf9gF90lriTH2vPaafM3TArJqeboCsdVxHP3SLK0Go1rGa93DIKoRekVOEOXCFPZ04b2SlpP2v/fzm4j5S0a2+vpCgq7V3Ov5iX8lJXxOupfoewV5icbFqzjGfN8L6J4ZK/Uhc7cADc8rXrjLe70yIT4bWWTs1y/pvkiy8nkKlFPQl9i/qo+9SG0anY6d+H38dhCvUSWWT4IU05np6OLDV4w8DB9V4DKUE4ag83DgUuPXRIQ/hNQBj0NwhnxKqIHVGBlfIR+geBUPCAJowF/KzoZ2acEaJSbEkkreC13gyRO2iIFIvDiY2D4nnNfeOtBxWRDn+kbijJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E0+b0hh7o24UsL34dwMfijSy3v0h75rOtJCNcggpqZ4X3+7PnQp1VR3SBwNggfkKMz9gqh+Ont7qmUa1nRwItKb9NJDz4mjJ1oK8FqfLKrlytAFcBJh3+jUg5QwURlO/DdJSk5k0+95H4SEasd3wAUd/YvxFFFP8I/IawOFyCajt3lnappiOrb8yHSSSeOHhPTICaGnGJLXtU2kfuR2XZW3gFQO1PEHqrKTarCjEeExQF9POxnrnVEYYp4ywdA3bquGiAUETjqs/L8EEYbLeWvZNaK3ALAFgBuPJn9xRTYBxBkJIcAOKQLHnVS/aNLnYWz4/M4jg2adJv5+kQ5iLrEUWGQgrGz0yc2F0bsu0rqBpOnbQe0pkD9QIKY9AM014hD03yRmNurd9G72QKMYk2o1J2w4+r7qiXIbO6wXa6sXV+vQIJ0N81uibRwW6t3Bj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:20.0446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f63457-372f-4cd3-8572-08ded03a977b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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

Retire ACA support for vcn v5.0.1

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 94 -------------------------
 1 file changed, 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 9c23055cf5ce..0a3c9c59fb19 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1727,103 +1727,9 @@ static const struct amdgpu_ras_block_hw_ops vcn_v5_0_1_ras_hw_ops = {
 	.query_poison_status = vcn_v5_0_1_query_poison_status,
 };
 
-static int vcn_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int vcn_v5_0_1_err_codes[] = {
-	14, 15, 47, /* VCN [D|V|S] */
-};
-
-static bool vcn_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       vcn_v5_0_1_err_codes,
-				       ARRAY_SIZE(vcn_v5_0_1_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops vcn_v5_0_1_aca_bank_ops = {
-	.aca_bank_parser = vcn_v5_0_1_aca_bank_parser,
-	.aca_bank_is_valid = vcn_v5_0_1_aca_bank_is_valid,
-};
-
-static const struct aca_info vcn_v5_0_1_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &vcn_v5_0_1_aca_bank_ops,
-};
-
-static int vcn_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
-				&vcn_v5_0_1_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
-		adev->vcn.inst->ras_poison_irq.funcs) {
-		r = amdgpu_irq_get(adev, &adev->vcn.inst->ras_poison_irq, 0);
-		if (r)
-			goto late_fini;
-	}
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 static struct amdgpu_vcn_ras vcn_v5_0_1_ras = {
 	.ras_block = {
 		.hw_ops = &vcn_v5_0_1_ras_hw_ops,
-		.ras_late_init = vcn_v5_0_1_ras_late_init,
 	},
 };
 
-- 
2.34.1

