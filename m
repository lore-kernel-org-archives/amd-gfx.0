Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F52CDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E504510F189;
	Thu, 25 Jun 2026 08:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d8iX7498";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6A010F187
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxEI06vugh8Oa8gcQh0ObYkovSTFutLkjvlkwsqyjje4pRHWIAiRyfjWHppml+prOQMbHn32Wu/a2gqd9fmWjRnEG9B4bWQiZ/9d0JMWuZso0XXEHPNbG+3Umltg+jGsuZ3iHj4c9IDOgsXMuM2LJ9fUEiqRmgUxrR9CX2qO0lMRJrg4Rl0TvTPobT9mqhMSE3+UsNp8xaJn70wvGCnWALaAFXKSg2sco0Y81lxpAZBBG8I1Qn9oYtnI+Vd1z0vFJSOnfgAvdmej4x3tQAct6FzmSZTOVa+UNwA0wc3+1HsuKnNSlPsjkRv3Ll53LqC90A77tD0uWADNuPlNYEWPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTw1ztKjpJ3SOn3N+mpJYyivHOwy7qOu1LUNBSJ64G4=;
 b=nXgxvoK+tZv0dWM186b4SCqPhq7V9xbTYTw6cmULQdiKcLMsyT/GUihF3UmUSlkwZiGf+gZgifFfL+1ZSVHiPv4NymXds7nPHKXQT0C6M6FNJqYS8dBNjZlPjhp6QkKxoMfIdIX0e1b/U61OlrofDONpWxyzt40Vj5OLzWuKMmcZlPa7Yv8Ubqqd4RKMYyH6zR0qA7FtMvg431de33kOXRxNhLzTJLji9vAzAuvlNgFYWLQGw6xxM+8MG6tv5qCns9oX6t19raWU5rwynsQxFd8nGbtKzE433w0oQgyovu7HD2bO3pv5NtVpTsF/yiXEhD5G+LqWrteOrlBBrEFEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTw1ztKjpJ3SOn3N+mpJYyivHOwy7qOu1LUNBSJ64G4=;
 b=d8iX74981ZzteWhhJLaFjjiQq4wGKQdT9yZmJswCVu6tync/5rqNUs1tinkc2Nf8+NOV3L2jeqUnrxdiiP2BXaX2HbM8/krP/seCzr0Idi25cjC1E+gPCaEsQojpUKm5Y4QVFmAhIN9zfHDuy32yZG7yhJnnO+eWhPROtCzIKoQ=
Received: from PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::13)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 08:20:38 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::74) by PH8P220CA0029.outlook.office365.com
 (2603:10b6:510:348::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:37 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 14/44] drm/amdgpu: retire funcs for generating legacy cper
 record
Date: Thu, 25 Jun 2026 16:19:07 +0800
Message-ID: <e977d14de67f5430c55f6aae74e6e4feb2cef811.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 248b8a4c-fb97-4552-0666-08ded292a319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: mTiDl2KKLNR31xM1cF8Of/dJ/fMEgQP1ndc8SeitGVhu9WJ/HWx3OZ+lhWB8yEUDziWoMZZqD9Q7Q2Zzx0QDik6+dIOoxK/jIG/kz0txnP4xqHCtW6xq5IC5BD68TuuG4ASmkLvDYa+n2YXsp34L1PxAJ6X1Ia2CV5JKffE+AIl6MOcoO2YOKMAEASi9CcfnTY2Vb9/kgtQcImflH3MOSfVLsfqz2u9+SeIsBaEW8dC2YMfppIS/8xK1LGh/otAuRWrheYdK/H73Q0pje1i2ziB2Bj+W9yHFKL+r4pIenvYgi2I2RK+OBqKVIgk45QidGsP3JFzvZETPIXR7zCJIcEnvWUTLR2QT71ajNL3PLguPTdYVUwQ087gREo1FfxLGOjpQ1j+t7zY+frVJ4h888wrtak1BC5PsOy5QnAD0OW8QBkn23rP/9ZDYeC/74ok7ipn6dY9M3aepZnZ5A186DpHUUB4qsT++fz+ftFxHAuq3ctrEgYGMbDiMowEp7F7Ppet91fR8mz26xGWxB9zH3XhEli6ymIhzaFBxWX6/vX6j4Fk8otNgyjhA6SHXUtHkqSU7kxzZSGX0f+GRqZfuadEgHQlnGEUr/lLWW4BuffZCijfpsnsLmAY8X41BluGqCzL0GYG31JL4iDLpAtQQU69SYU1+Wd4iV3lV1IJBIrfzwH3Rmyiz7yvmQJ/W0r1C7lHmmSIxGjRmNF7KKLFr4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OYKUbcc28nRG0l3QAmzCo2SsZpFlhYVnalJpqbYLGecjFQjmKStnwUtINmS/2ZqEtvOjMPEEQ/aSO82LGzlCNosdvHPlpTZRli6znxFJrm61LX2U5BnIzsSop8KXIs2bMVOstzT3Uyf8PorbPQCzwip1IK29lZiUOtzHs6giaUxSvayA8Gn1Mtj6CWvJ3Z5JgmptAaHdoT5VqvvbZ64wqjOe+NfggbJH57q7JBmtAh7PwTiWpio0o8gautFZWG6konNMJAt3gsiGmDEt33S+ICuAuoWwmiQa6aa2GuUGPlcxkyO56z/3o/vWQ4aYoSw6wiUibpmITomJ9T6ILNoCy2G62eQlZtE0L/7kCzhbEmYqmK72ejJSxcNUHsVBJ+5dkTLP9x4ncR3hDTNtxHHz6IgekjR3GopqSSKqqpHYeY9PkeUYocdZVtS/mKCmXwNT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:37.6171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248b8a4c-fb97-4552-0666-08ded292a319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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

