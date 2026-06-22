Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABABDCDB478
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A28E10E55D;
	Mon, 22 Jun 2026 08:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j6Jux8mP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB3210E55E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQKRFFTCPK2QJKFCr1vy28onQi0TkDVYl0nhF7Svr9RH4vHhsvefCRqASlqwm/+Kz2lBikhKLmHaV1M4KKXXGJfaW2dr/8UVrMAY4W/KC9NUXJFkpbsCmdDufB+extxxyqK+RpQmql1Ajfmbgd69ns12S8Gnnh9s1WP6GpA1/NwPk3paS5qXG8NqKILUz/49/uvK2IqMC0HZ5X48l7RpVFSrcwnZ/88whztZjyAUplVoZF+0y5i/4U39uwvUlqWczL3K0ZInJHKkmCZda5KH/ECDeXPGy73J6y3i5xyqOK4C0PaO5DjElJ+5W6OgMFXZyPYJYBVVOb1Mx6FBLjJNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTw1ztKjpJ3SOn3N+mpJYyivHOwy7qOu1LUNBSJ64G4=;
 b=VjLvCY7wOao4oAWxzJWrjbSH93UZTCvmSKdSH3fh3mjN7omt1kUCi5270VqTf04x7Ia58xz95D3EhfSFaWWYTr7TsGA0P2VbBP0WpZhMNcLubA+BcX+3zt4eGgSM+jAe4xoiL3mqalpuoXX7MsFcBBUk6LJiUkhy2zDmdeX5so1Ilx1OsScICGReP/nAtbUzP5NntzZjGDeZvBMNinA+1Bc8GdT+3Gh7qHboFG1cahcKa4gEjc882F2NjFuGi6iqoPnCtTO/8YU8qf0HMIN9CXszFEQRcSoKQ4i62/H9GT8CeMry/XOe1WMOym/Oy0R4uZQ6lIIkenKfLNzemBUZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTw1ztKjpJ3SOn3N+mpJYyivHOwy7qOu1LUNBSJ64G4=;
 b=j6Jux8mP9W99uNJTjgDJRmIDnKk24lkYqLKZFqPGbycouQx+S2Eb4HJBRSqXyI2/fpxXJpmKt5Vpfuc+6vrGff+rt7rah/hORjgH/ja2Jms+9vPl4ix0wl/ZoUVrecsHokfO9J1f22Yh1cN1yrXkhquf3Q1wo0EytgxIaWCRQic=
Received: from DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9) by
 SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:45:37 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::5b) by DS7PR06CA0035.outlook.office365.com
 (2603:10b6:8:54::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:37 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 14/48] drm/amdgpu: retire funcs for generating legacy cper
 record
Date: Mon, 22 Jun 2026 16:44:16 +0800
Message-ID: <fa22cd329b163486afff33c5e42b18546a48eedb.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca66c9c-cfbe-487b-684f-08ded03aa19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|3023799007|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: grY69B8ilDYgFgimqhv7qD8n5Cs7G+AVgWjSEust7lwiT7+yOaebuHdqOhvvNa5maGqhq3c8+XGiVoOX85cSy6zfXZVRIwUT4Hn6r+Gj7SpCeEkIHsytFo0EYluCt0QL7LFA1y+JUbGU8+kq9fCQqCEeZbrynev4peTGkszkE0HepBYk6RB96Uj5B6E0GrOF9P1nKipfz380cVs4pYcQGyUEijAMkJyVRjr/FqHxUSbiS4k+H0YoUDEzktE5jDr3d3lOdPKvbzHZd30A4jUH6ipWHpHIulD1nDd+/c2RmSsy+OMATPWgj29XVZxy2zeg0xAmMzGY/SgV8txL8TP8FQvBOSG9r4g2nKeO+bDLI+jObubKhMHN2Qh0eMXGIWLExjW5OpL6jny5jbWMfRgcsZN1kQExDEGGKICuRjubRMGC7T+5x/gic6WjoHRH1Dv5k/HmuYwLFSrXz/Ybx7evkQ7QV8kbv6nHcL0VZvM7tQ5bOirbC5MXR9iAQjQ7atd6iEmuTHfYFWdIiy7L9japZ9NIOhscSVTsbUTcXkaODyYLLOnx5bHcNTsDIprhJzsy57SWPq0NNP87nJLvRTTwj0QIHkbvGa+iFD0RnL0EyMd0mEha3vgQuNgc+M0vRBIjgt3n1HrK/49e1RF0hiS+Dki7sRZIgh7l6DF57nkuk47LT3QMDjNc57dN+OWOkwNB7WgifkU/W86kDcx/IW7X6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(3023799007)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vdevk/CXpjFD8yi3IwE3W+1ArJR/OCA2BLsB/0bXEWxrzwScC7E1B+rl/LCnD99NMxLeg3o564hEGidzjYs7CAWib68WEkUp9ztMsPFS+ipc7/sBh9qR18F6mdyZV4jypnalXkf+jaDtDwqWw6xvp+EUmQSQPzJH44Bn4Hb2M1Wn5v6sejM+AH8EQFvjV9lwwTQ4cf5OleWZ5ZPnb4xUGoUtSuLGkMHmAQc2WaWPiQhHCQlnvUkBEAHUPl6GokxHk5oYoT2+JDexuAjkLGYXBbZkA9dCft5+Jr/6k1kIfU/Da/sGyY58YANFB04n/bVLf6yUhCaknh61pnT9PpyHWCoSOT/FK5u1kjZQprHrdN+wKiSVL6b5rnxG8rE8gKP5i1PrIyN+VYNDJyz8SkU2LaI/Ntkz+I6VIEHgYPO8yMlwQ7ZezeJ9n/yAIIreDyos
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:37.0454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca66c9c-cfbe-487b-684f-08ded03aa19d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
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

