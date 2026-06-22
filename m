Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995D1CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B23910E46E;
	Mon, 22 Jun 2026 04:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1gGH+Z0l";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863EF10E46E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRALHojkX7rUiJmFu2q9eGUOpUvndpXaoJxam0SQq8KcT4MutwVAbDb8WFpBkV/MZrvd9FwLYtHaUx3BJkCS0Qc3ZjoX8XjOR4rmI6JMN/LPsfrqkN1AgIec0HnXovWB3hB98rKPhIGdyavQINesv6YDPMSYpIGMS1EYt9sBlhCgzRutfwFbecJcBmBunNswqYBJdMpMknfzJWTWkfVHaUDojCBfIql3uudamt5MUcLWXZUDjVOr0YtrZVUqK3MZRRpL991F+nCEOQeVhqS2p8K+wk6xmQ6s+4K2kcFBVpbbnS2TBl6FvR2v3GVTkCc4cNiJyOlc68BzTFlEMxJ8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTw1ztKjpJ3SOn3N+mpJYyivHOwy7qOu1LUNBSJ64G4=;
 b=a49BWa91Ft9aFtKkbjaCwqgQRzgi/y5UBrDoRYZXI5j66h4did2u710K7oP+B7GsEhRZi5vWZxPAPqkoPctfXUbN6gwnuBzEHC5IseA51MJj0vBXhHOj5aAKBOtFqTTE5VCS/k70chaqsMsc18I8t4TPJ2uu9ZduAnchsfaQ2qTsLMhkFpTt7ieGrOdl7Xj5WYDI7B2en9kzFuK5plp8nrnjH7QIrUQR5IkGmsZyPsxduqUNG97SnJNds0FRmqGThkIhkBoedJKHKVR6gPbGtByk2vZ0Bp1+/wMSgVIwDkyKHDSdhIJ4Rei0yrS6PMews/DAVuPB+V6uT+/NcCpcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTw1ztKjpJ3SOn3N+mpJYyivHOwy7qOu1LUNBSJ64G4=;
 b=1gGH+Z0l+Qcg/4898N9w0rGK5xz7MptV5DOU/dYE0SaSj+zeOW1cBEh5ZQraC3O1xwGpHBI2cG08hYg/YNbr4Gs4RhjutF9u/c7JmEwkFLOoYgNdkKJM1UatWXk29+bJuKPR3uTBimhkcirpgjbwNLv+2XQUZfznNO65eEEfEQI=
Received: from BL1PR13CA0405.namprd13.prod.outlook.com (2603:10b6:208:2c2::20)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:29 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::9) by BL1PR13CA0405.outlook.office365.com
 (2603:10b6:208:2c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 04:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:29 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:27 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 14/48] drm/amdgpu: retire funcs for generating legacy cper
 record
Date: Mon, 22 Jun 2026 12:40:03 +0800
Message-ID: <9649ade76eb1848e7378b47847a0f2dc303637a1.1782103073.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: a38509af-36bc-4117-6d8b-08ded018aae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9Pmzgx2665QzgNmVd0bTiN+o3Qk23HLYzOwwwitWGv4J6gcyROaOy3kp4pajYfkIzqWN5av1Oyi57owQq2FTpOjp3T2xDOZoQElzecEqZlT+cvHdfz3COQYHqoD1nRGoxWrabRZ4o65+PMKbll0tRnIZehoQOLiUqJicAbK8IETt0m+XPZlK388pucXqFIYpSgiCtsbmhpNud4TgSjed4wN+VBb9n1XnyjkBjsKYQHlniveRNkQkM9uxhhKi97AqnHG1QRGr7GgJ5DMyTZIzkrF5KhgtOyWSC8vBBSTXOsbrRis/69fhpLTs4vBY3ybN84lfbOEaiTrrd/iJNsfv/rH/Z29gXxNgdLaPADYC/S1BXmaj7vxYtvVg3WwGq7UksS6KLEk/GyPdFX3i+Uxf52gtx1yB5SOTGW2jmLzOnG4FPYGvRXhcVsyBaoejImIetRdhyfMMVsw3fPbvIZ3G90Co/qqyX27R0FL1oyO0G0fSS3ko3xYNtvOeiMCNHE3/1D2NNwjtArJLJmOTH6kHQW+pbDdRzEXsGfL2OsCz4tvc4kS+Ze/caqQCJXpmUcGbRbSAHAb5+2TsHQVqaLV9M2j3cNektNUPlk6my0eP+yI70ThSA8VG7VxiMkL0OsKzWQ0bn/Ygn++s/AaZVFggaJDBi+rplfVh2okpM0KhxWnUzfeSuvyye3U7IN+rBNvJXu0W2uXkO5LNyZPIwSOxpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wlvwXviVv9Nl3SUzuo5y+WksdGi22YvQeSI06E5L7n4CEzCq6sT4xy5J1SLar4+h0UOQYwt9nOggdIgafsZus0j6LBZf7u0Db4oFEm6d1LPRCG1cT+xZ6M2rul5pyF0ozwhhdrMFnV1ykBG/qEW6CNlbchuPsm5Ql0apOoE/7HaQPhNVmTOOb8yHRgRh2A9PH1JzMzVsrgrlH7kjAhFAlFD8RD5rcmc2NuszG7ZYo8b0cijtof662JDV7amhRAEoQcxBHnFPiGgirxArcqno5iEQmZKP2sLwUqjgky2v3RMR3sTi3F6EXkM+uGLILqLtUez4oXq9DelaEQhz+cFqmkkDE81GuXAR9DVcY7NE9ZjxUThPvOBTWSuctgmqqNoEwqEFyE3chU0KDFh0oyGpRtpvQbZ3aPv0oFFUcJt6ZeKINN6ksx9AxCrdMMra37/6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:29.7526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38509af-36bc-4117-6d8b-08ded018aae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905
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

retire funcs for generating legacy cper record

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 111 -----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h |   8 --
 2 files changed, 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index d5e59c24d907..34a70e479f60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -289,40 +289,6 @@ struct cper_hdr *amdgpu_cper_alloc_entry(struct amdgpu_device *adev,
 	return hdr;
 }
 
-int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
-				   struct aca_bank *bank)
-{
-	struct cper_hdr *fatal = NULL;
-	struct cper_sec_crashdump_reg_data reg_data = { 0 };
-	struct amdgpu_ring *ring = &adev->cper.ring_buf;
-	int ret;
-
-	fatal = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_FATAL, 1);
-	if (!fatal) {
-		dev_err(adev->dev, "fail to alloc cper entry for ue record\n");
-		return -ENOMEM;
-	}
-
-	reg_data.status_lo = lower_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
-	reg_data.status_hi = upper_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
-	reg_data.addr_lo   = lower_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
-	reg_data.addr_hi   = upper_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
-	reg_data.ipid_lo   = lower_32_bits(bank->regs[ACA_REG_IDX_IPID]);
-	reg_data.ipid_hi   = upper_32_bits(bank->regs[ACA_REG_IDX_IPID]);
-	reg_data.synd_lo   = lower_32_bits(bank->regs[ACA_REG_IDX_SYND]);
-	reg_data.synd_hi   = upper_32_bits(bank->regs[ACA_REG_IDX_SYND]);
-
-	amdgpu_cper_entry_fill_hdr(adev, fatal, AMDGPU_CPER_TYPE_FATAL, CPER_SEV_FATAL_UNCORRECTED);
-	ret = amdgpu_cper_entry_fill_fatal_section(adev, fatal, 0, reg_data);
-	if (ret)
-		return ret;
-
-	amdgpu_cper_ring_write(ring, fatal, fatal->record_length);
-	kfree(fatal);
-
-	return 0;
-}
-
 int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
 {
 	struct cper_hdr *bp_threshold = NULL;
@@ -348,83 +314,6 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
 	return 0;
 }
 
-static enum cper_error_severity amdgpu_aca_err_type_to_cper_sev(struct amdgpu_device *adev,
-								enum aca_error_type aca_err_type)
-{
-	switch (aca_err_type) {
-	case ACA_ERROR_TYPE_UE:
-		return CPER_SEV_FATAL_UNCORRECTED;
-	case ACA_ERROR_TYPE_CE:
-		return CPER_SEV_NON_FATAL_CORRECTED;
-	case ACA_ERROR_TYPE_DEFERRED:
-		return CPER_SEV_NON_FATAL_UNCORRECTED;
-	default:
-		dev_err(adev->dev, "Unknown ACA error type!\n");
-		return CPER_SEV_FATAL_UNCORRECTED;
-	}
-}
-
-int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
-				    struct aca_banks *banks,
-				    uint16_t bank_count)
-{
-	struct cper_hdr *corrected = NULL;
-	enum cper_error_severity sev = CPER_SEV_NON_FATAL_CORRECTED;
-	struct amdgpu_ring *ring = &adev->cper.ring_buf;
-	uint32_t reg_data[CPER_ACA_REG_COUNT] = { 0 };
-	struct aca_bank_node *node;
-	struct aca_bank *bank;
-	uint32_t i = 0;
-	int ret;
-
-	corrected = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_RUNTIME, bank_count);
-	if (!corrected) {
-		dev_err(adev->dev, "fail to allocate cper entry for ce records\n");
-		return -ENOMEM;
-	}
-
-	/* Raise severity if any DE is detected in the ACA bank list */
-	list_for_each_entry(node, &banks->list, node) {
-		bank = &node->bank;
-		if (bank->aca_err_type == ACA_ERROR_TYPE_DEFERRED) {
-			sev = CPER_SEV_NON_FATAL_UNCORRECTED;
-			break;
-		}
-	}
-
-	amdgpu_cper_entry_fill_hdr(adev, corrected, AMDGPU_CPER_TYPE_RUNTIME, sev);
-
-	/* Combine CE and DE in cper record */
-	list_for_each_entry(node, &banks->list, node) {
-		bank = &node->bank;
-		reg_data[CPER_ACA_REG_CTL_LO]    = lower_32_bits(bank->regs[ACA_REG_IDX_CTL]);
-		reg_data[CPER_ACA_REG_CTL_HI]    = upper_32_bits(bank->regs[ACA_REG_IDX_CTL]);
-		reg_data[CPER_ACA_REG_STATUS_LO] = lower_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
-		reg_data[CPER_ACA_REG_STATUS_HI] = upper_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
-		reg_data[CPER_ACA_REG_ADDR_LO]   = lower_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
-		reg_data[CPER_ACA_REG_ADDR_HI]   = upper_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
-		reg_data[CPER_ACA_REG_MISC0_LO]  = lower_32_bits(bank->regs[ACA_REG_IDX_MISC0]);
-		reg_data[CPER_ACA_REG_MISC0_HI]  = upper_32_bits(bank->regs[ACA_REG_IDX_MISC0]);
-		reg_data[CPER_ACA_REG_CONFIG_LO] = lower_32_bits(bank->regs[ACA_REG_IDX_CONFIG]);
-		reg_data[CPER_ACA_REG_CONFIG_HI] = upper_32_bits(bank->regs[ACA_REG_IDX_CONFIG]);
-		reg_data[CPER_ACA_REG_IPID_LO]   = lower_32_bits(bank->regs[ACA_REG_IDX_IPID]);
-		reg_data[CPER_ACA_REG_IPID_HI]   = upper_32_bits(bank->regs[ACA_REG_IDX_IPID]);
-		reg_data[CPER_ACA_REG_SYND_LO]   = lower_32_bits(bank->regs[ACA_REG_IDX_SYND]);
-		reg_data[CPER_ACA_REG_SYND_HI]   = upper_32_bits(bank->regs[ACA_REG_IDX_SYND]);
-
-		ret = amdgpu_cper_entry_fill_runtime_section(adev, corrected, i++,
-				amdgpu_aca_err_type_to_cper_sev(adev, bank->aca_err_type),
-				reg_data, CPER_ACA_REG_COUNT);
-		if (ret)
-			return ret;
-	}
-
-	amdgpu_cper_ring_write(ring, corrected, corrected->record_length);
-	kfree(corrected);
-
-	return 0;
-}
-
 static bool amdgpu_cper_is_hdr(struct amdgpu_ring *ring, u64 pos)
 {
 	char signature[CPER_SIGNATURE_SZ];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index 353421807387..d12c98077d9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -26,7 +26,6 @@
 #define __AMDGPU_CPER_H__
 
 #include "amd_cper.h"
-#include "amdgpu_aca.h"
 
 #define CPER_MAX_ALLOWED_COUNT		0x1000
 #define CPER_MAX_RING_SIZE		0X100000
@@ -88,13 +87,6 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 struct cper_hdr *amdgpu_cper_alloc_entry(struct amdgpu_device *adev,
 					 enum amdgpu_cper_type type,
 					 uint16_t section_count);
-/* UE must be encoded into separated cper entries, 1 UE 1 cper */
-int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
-				   struct aca_bank *bank);
-/* CEs and DEs are combined into 1 cper entry */
-int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
-				    struct aca_banks *banks,
-				    uint16_t bank_count);
 /* Bad page threshold is encoded into separated cper entry */
 int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev);
 void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
-- 
2.34.1

