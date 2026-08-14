Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEB0C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1138110F74E;
	Fri, 14 Aug 2026 21:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="APpVUv3n";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29CD10F73E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnFb8itVjxpDGg6OJfF3fyzSg+It69xEwSlGwEVB2UorX8qMNYzFrSAWTC7UFjanlYPb6H92aucqux9yLNfP0ncvWb7xDUHqKtygeLYitXLvQI7XZNflEAt3j2ZIDLyydPazUlw9ID2Y/PQfTb6KWW/ea5FON5ss8j2cMCUzHBc4vtH96bD0alaYJY/9T30CbE4YC6HO64RxdstYnaqw3cVip25EEHtszNfxtwPtnADmZ+k3XdMx6oiFZm4z1hZHRuct07+IH/se70oSlH35xOn6nM1GJQnziOp4t8BqBK789szOvqHRNB4FUS9qzvclQMxs5CBc7TRP6joQl1fJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ubruVVfUXEt4nspVFURaFHWFXOSUfsi9Ex3wt5BXY8=;
 b=U3LS57hPL7g7rHEtz9fZHYg8GJ+B7YMQw2xqqYIm1+/Tzt8Zs90e3n15sqCTi2BwLmnOWlj5j9VzkF4Uv9D0IV49lB5otvKzZY/W/koUVeCNivYgoxlktIiF8/FTTGj8JoWgZA7hVoHxptleZwSoQEL5TGehhXN+zlihMKQc5NKvJ78MY/S/FJdBulEZtXWjYi44GI2kL2mRq8nk/UsuD0prowc08EIRcvh8tV9dZOE3+Z5x7jefBhBwhrR8LT/Ns8AYKfhk3L1QksbZHkd8XHnLnryTXCAIIReNKOU/L6+QpFREplruJeLdy2WWVdo3zkcsc2ZdXAvICTJlghZj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ubruVVfUXEt4nspVFURaFHWFXOSUfsi9Ex3wt5BXY8=;
 b=APpVUv3nXrZUqhU4L1FBNftEaxGQWoqZLP7A6UJhy9kf9x5FKQ0P/viuQkcHoaPZLP0t1ioFJhDe+cI/Wm6i4NqJYXunKpWaGTPjrWx6o04eQRwNQm7seLIyqXYBQmVaipPMlbF4E+CsWc46D2cetYtdu9+M7Ce4tvg+H7f4NwY=
Received: from BN9PR03CA0588.namprd03.prod.outlook.com (2603:10b6:408:10d::23)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 21:04:01 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::2c) by BN9PR03CA0588.outlook.office365.com
 (2603:10b6:408:10d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:04:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 101/109] drm/amd/ras: preserve CPU MCE context in the log ring
Date: Fri, 14 Aug 2026 17:02:38 -0400
Message-ID: <20260814210246.3067612-102-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: c57f187b-2e5f-4a0a-2e2b-08defa4790f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: OyFEW8uWFzeR2OyrKPefrablLmEEZnZvz/qMkrih3blQ6LTsC9Rf8UdaPUhO1bH1S7WDpZKrKZXM+Fctj9mUi2qOJN3BjlfgY/mNY4ML0ek7bEDOZ9E50+eXysJ+T/1NJN5RnyqVNc1HTwU+h3yzthQkKhrSKYYoBzTlLjvX+VHSYf1NGPWkJ/Q4vZvy/KcePJmLz16f8ZbK/abzkWlkjdAOYTUB6RfwonbxoQlBh7XZ2qq3CTOKr46DOJhjYpnip+2QixXnEJrJyOB1XDkVIcA6AsDNZzdJ5koDUh4blDQzkPLzjMIVutJ9k0edOfRt81kxX1HGp5WVVvESJZpP6Wa03iv5xzFiYYyT+iDVSMiLA3Natkfx+xnv0vz+Edb2YvVJuNFi/wkJpPZoeaan4w2Y/fscbL3KaQNTs/1DLWdhb/ZTZLTGEBaOp9F9V43je/rdAExLwGN8T+NPv9YlVJ5lrucw1nmjcMzG+bi2bGfzuoJ9GvUxZLeLVzEinXWH94mDZ9yHvA5gWmxihhrRyn5wJji56FQUjLDMTKITNPfA4v6AUOagEL0DRd5tuiRnp/TervIbcfAmU6FKbQiusutpJ+XlfqdnRE2s+GrJ5Nsc9mjz25HfCYYH8EDYv1x5nlRIbD3xa4MCBnCmoO2G90EUtif3vrdAxRlKGGY0buDqqBltYu0mLxiEIEPffdtq4zEjawlZcKdfiWw5NA1iHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HTiIDPLquAvils7otNho50ExOPZVfVtsQj8Pgg3smhx8MZaXC84iVgY1mJJ0h/sGkCSa1rsEj1INmRS7K9AD9YzZteeZg5omXLds92iyd1BZMVO1deZOTuxcZTXDzdefykbs5iZX7S63z45apBfr2dNjdADh3ymBJKsai9A8QFc5eEQu5uQeuFmlPJs5SujvbZjn6+IQ6jW3KbiJ4P00k4j7AIZI/ZmqrW3SmRCm3HWHRVi+L40Bctrksy9YHakrvV57ARIDCqXd+zdguWYyM2UfB6unADiYUswOsfwMYdIdmhwsiDyzpr/9+4nHvqYoEV72xetitBITZJHlJWqOSo21Fmxbo6AAhHay4CA+UVoZoIBctqmqKn2eQakuh3GlloPzLxEyUcZx7KjGCgWofCFKjjIBnUNMgfWueY6Nbr7LxxCdjRuxI51sRstSb8hH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:01.4383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57f187b-2e5f-4a0a-2e2b-08defa4790f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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

From: Xiang Liu <xiang.liu@amd.com>

Processor CPER generation needs the APIC ID and machine-check bank
number in addition to the ACA register values. Logging the full internal
ACA bank also exceeds the stable fixed-size log body representation.

Carry the APIC ID and bank number with incoming ACA banks and store CPU
MCE events in a compact 128-byte log context for later CPER encoding.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.h      |  2 ++
 drivers/gpu/drm/amd/ras/core/log_ring.h | 21 ++++++++++++++++++++-
 drivers/gpu/drm/amd/ras/core/ras_mce.c  |  9 +++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 52acf19fac11a..759119bed870c 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -54,6 +54,8 @@ struct aca_bank_reg {
 	uint64_t timestamp;
 	u32 bank_type;
 	u32 ecc_type;
+	u32 apic_id;
+	u32 bank;
 	u64 seq_no;
 	u64 regs[ACA_REG_MAX_COUNT];
 };
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.h b/drivers/gpu/drm/amd/ras/core/log_ring.h
index ed68664bf3c68..2d8e40c971062 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.h
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.h
@@ -48,16 +48,35 @@ struct ras_aca_reg {
 	uint64_t regs[ACA_REG_MAX_COUNT];
 };
 
+struct ras_cpu_mce {
+	u64 regs[ACA_REG_MAX_COUNT - 1];
+	u32 apic_id;
+	u16 bank;
+	u16 reserved;
+};
+
+#define RAS_CPER_BOOT_RAW_DATA_SIZE	80
+#define RAS_BOOT_CTX_VALID_APIC_ID	BIT(0)
+
 struct ras_boot_err_ctx {
 	u8 section_type[16];
 	u32 error_severity;
 	u16 reg_ctx_type;
 	u16 reg_arr_size;
-	u64 regs[CPER_OAM_MAX_COUNT];
+	u32 msr_addr;
+	u16 raw_data_size;
+	u16 flags;
+	u64 apic_id;
+	u64 mm_reg_addr;
+	union {
+		u64 regs[CPER_OAM_MAX_COUNT];
+		u8 raw_data[RAS_CPER_BOOT_RAW_DATA_SIZE];
+	};
 };
 
 union ras_log_body {
 	struct ras_aca_reg aca_reg;
+	struct ras_cpu_mce cpu_mce;
 	struct ras_boot_err_ctx boot_err_ctx;
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mce.c b/drivers/gpu/drm/amd/ras/core/ras_mce.c
index 018429e397979..71281917b132a 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mce.c
@@ -70,7 +70,7 @@ static int ras_mce_add_gpu_bank(struct ras_core_context *ras_core,
 	ret = kfifo_in_spinlocked(&mce->mce_fifo,
 			aca_bank, sizeof(*aca_bank), &mce->mce_fifo_lock);
 	if (ret)
-		ras_process_add_interrupt_req(ras_core, NULL, true);
+		ras_process_add_interrupt_req(ras_core, NULL, false);
 
 	return ret ? 0 : -ENOSPC;
 }
@@ -78,9 +78,14 @@ static int ras_mce_add_gpu_bank(struct ras_core_context *ras_core,
 static int ras_mce_log_cpu_bank(struct ras_core_context *ras_core,
 			struct aca_bank_reg *aca_bank)
 {
+	struct ras_cpu_mce cpu_mce = {
+		.apic_id = aca_bank->apic_id,
+		.bank = aca_bank->bank,
+	};
 
+	memcpy(cpu_mce.regs, aca_bank->regs, sizeof(cpu_mce.regs));
 	ras_log_ring_add_log_event(ras_core,
-		RAS_LOG_EVENT_CPU_RAS, aca_bank, sizeof(*aca_bank), NULL);
+		RAS_LOG_EVENT_CPU_RAS, &cpu_mce, sizeof(cpu_mce), NULL);
 
 	return 0;
 }
-- 
2.55.0

