Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1B1CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F4510EEBC;
	Thu, 25 Jun 2026 08:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="17TOBoO9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B1110EE13
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmVI8DELOaL426Fjp7BiIzCVE9CAvkYTyX6D1mRTATeNGlHY9NvaDRtqU6VAquWZqkWQ+2r3iDYjS/CWZfTwtFLu1D14CR/Sg724N4bYtD5gwe9RwmcU3eKuoWfHnh2TtxXpRkeO0iR+BhctMVA4BtCjIiGINTodKeB4AHmwOQO4fwU4OzHoJz0cDOlnrqK3Vpz8Crzy9XzhS0RmHpu4Gl50uy2nk0M77in9ki5broAr+UFyDeaIjR4hh9/6gycYkhWwBlamnF0sxfPjOi7ZODoT8GjKycwRnZJrOdx4NDe/y8RimuFmr0wOtef4IXK+PM9ENk++EWMyMXzKO0rZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6migk8y8J0hhhIACQBEDn9LEnfJ6nTNW2QTY4gQf18=;
 b=Zz4Q/wE9UWi1uJJkilmdUJ3vaG59fIoXe9sBKmGmjJ0JTpswEhaB09bUS1tkDeHDOTed3hOb169x5jTbV/312HxQkYZSB6zsB6iGgeJidbyAsTxRrwXk5Y3FjpMCrHEVvzvShuZRZNZHWyTk7qV0GBrsumTlfHjIqmcc9VpwtqgLuz+tHHkilA0u0wVDwPmUfeDNwcApcLKFkG4ZQmzbLmGg0QoW+teQrEDLX3OMlrLlLVqMZPfEfycIMssl75NXx4PyefvtroaLMnak5bpxuJ5flTncciBMc0vMWsi5Hdj4FQn4ASKY0rYFr9d0k8KZvCvPaSIjTdjPahfbrfE7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6migk8y8J0hhhIACQBEDn9LEnfJ6nTNW2QTY4gQf18=;
 b=17TOBoO9ROd/u49dIXGiplg37Ce8Eg5H/WD11K0f5ugS5j/fTQ8YgKiPZOcPNKYOa73grJvFn70brYwFhTz/WwbYFFD5+soSe6QRH4ajHMKa7RW0ysdSMqfoG0884z7VYGxPKQtabiowox+ne32KS75pwQGNc9qDUKgsOeUdK50=
Received: from CYZPR14CA0020.namprd14.prod.outlook.com (2603:10b6:930:8f::25)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 08:20:31 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::18) by CYZPR14CA0020.outlook.office365.com
 (2603:10b6:930:8f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:30 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:28 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 11/44] drm/amdgpu: retire umc v12.0 ACA support
Date: Thu, 25 Jun 2026 16:19:04 +0800
Message-ID: <01b26d3f963fe87e0e71f429982e4dbb88bc8d53.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 519dd12e-aaac-4ba6-55e7-08ded2929f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WSFTPiKr70pRWvE9TCtj3D/S5adoDEwEWpH7rTYsJ2v93SI33tYYEsjCtFTl71e02Q6AUBDHUat4cqVj70UvHIUK0lhS8kz50bTyN/lw4Zylacpa0VfdVyVdBIgxPG9UMQj2+L0VozKd1pqSwkzMjx7cHY8P+KfRwLhANXc8B7vuNLh510lEIz1/GS/XHuFAtpmWr0CSyFriDGDRu9SgjMCUFjg3cJXIXhOpiuK7kjKbI+h41yqUy15B0iD/+XKyQOPZgjK7rvDNlt4BioMihiLbIt+GNRuBwlR6Ndek+3scrTHQ+KbBXJVTn7EHlxMmnb+prm0ADsRISY9F4PCVMFLORUHmZ/425r8kfVdVJM5KmvD4Gs02rLISjgrV3FRbCRq02YKCbWLjwea7rzebyYOZSrYz5zEGSvUPuvfKM/SYpfMT7Kpk4UiPp55qvF2hfDvsoO6x5o2MAcRQ5UDmO6hnzwNxCtWOvy3VoBchvSIBvUQZGkvd9D5mpVw/e6C0S71LawwfsVWk5cKr3KmXCfYEQKxH0wiLMoViEk43klJtpjP3iIZganpMcAmwZ9U3k6Y/CFAa25U4FG8QhZVLT5u5E471VxTd6FdCFPdS8p4g0bdT18Ub93L96ioJM4NxBMUG3iBhipf2x7gVJ+Lwe/U8HF+h1HprZm/7fYnxB0cNPwFSXp9xdcq+Fa8vu8F1JlMwqrDfXWjoC4qBj0ZRdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JgkFYgCqSGA4iciByN4c/Ep4l6L0wFpoB49XYyNNY3je75yTeJ+GUxLNhxLuJDRzJFpBM5vyRxRpEOKuz6puLuNTqpm8/x+96AlOarHNwT8dFIwzt+V4f6AmdBJHCoYy8G19fNQuDNWzXC27R2iapxOmIlSribZElfG7IlEJ6puphTH5A+eYNjjsM2Rfaz5Auu3vVJW+WmK/6o9XBAABFoXVHt8ZrdSoUYg9mt4ERlvG+6P1ee8umHD4twgFkX1AwdL4fSKCRuASxz7Vkqe3wV0ecvqjLCdNp/rnoj4+Ej71RpipQ+C5xm+KhQ4n33Lgt74XFHiDVXMfzomxn/DvstWJdpLQV04gQcu5WM7xc7uMh+oRyFXb+wkiGtBc/+FrAfbKYT/+5Zrik1ymI8GQBxyfYA5/uR6yUT9Q7ggDJ7hUm6UBpZzKSkoSPOVs4WgD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:30.9664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519dd12e-aaac-4ba6-55e7-08ded2929f29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

retire umc v12.0 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 68 --------------------------
 1 file changed, 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 749c1f845ac6..328dd2e8d328 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -502,73 +502,6 @@ const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops = {
 	.query_ras_error_address = umc_v12_0_query_ras_error_address,
 };
 
-static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				     enum aca_smu_type type, void *data)
-{
-	struct amdgpu_device *adev = handle->adev;
-	struct aca_bank_info info;
-	enum aca_error_type err_type;
-	u64 status, count;
-	u32 ext_error_code;
-	int ret;
-
-	status = bank->regs[ACA_REG_IDX_STATUS];
-	if (umc_v12_0_is_deferred_error(adev, status))
-		err_type = ACA_ERROR_TYPE_DEFERRED;
-	else if (umc_v12_0_is_uncorrectable_error(adev, status))
-		err_type = ACA_ERROR_TYPE_UE;
-	else if (umc_v12_0_is_correctable_error(adev, status))
-		err_type = ACA_ERROR_TYPE_CE;
-	else
-		return 0;
-	bank->aca_err_type = err_type;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	amdgpu_umc_update_ecc_status(adev,
-		bank->regs[ACA_REG_IDX_STATUS],
-		bank->regs[ACA_REG_IDX_IPID],
-		bank->regs[ACA_REG_IDX_ADDR]);
-
-	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
-	if (umc_v12_0_is_deferred_error(adev, status))
-		count = ext_error_code == 0 ?
-			adev->umc.err_addr_cnt / adev->umc.retire_unit : 1ULL;
-	else
-		count = ext_error_code == 0 ?
-			ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
-
-	return aca_error_cache_log_bank_error(handle, &info, err_type, count);
-}
-
-static const struct aca_bank_ops umc_v12_0_aca_bank_ops = {
-	.aca_bank_parser = umc_v12_0_aca_bank_parser,
-};
-
-const struct aca_info umc_v12_0_aca_info = {
-	.hwip = ACA_HWIP_TYPE_UMC,
-	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK | ACA_ERROR_DEFERRED_MASK,
-	.bank_ops = &umc_v12_0_aca_bank_ops,
-};
-
-static int umc_v12_0_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int ret;
-
-	ret = amdgpu_umc_ras_late_init(adev, ras_block);
-	if (ret)
-		return ret;
-
-	ret = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__UMC,
-				  &umc_v12_0_aca_info, NULL);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr)
 {
@@ -758,7 +691,6 @@ static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
-		.ras_late_init = umc_v12_0_ras_late_init,
 	},
 	.err_cnt_init = umc_v12_0_err_cnt_init,
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
-- 
2.34.1

