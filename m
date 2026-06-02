Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D20CD6E4A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 08:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06428113964;
	Tue,  2 Jun 2026 08:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KAkFbp+R";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF76113964
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 08:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQb7bUivX3aQvtXqfW3ma3vC2GqOu7+/wl1OC8YGbnV8CjGOGiT1KZRFWoW7MA1QTJkfpH3CEQeSTfrJ+StAeNCpVEG6U8Sr5hfHc1IxFRU11iKrbkFYrmH45IZLGHICS/8JokzU8lgXXYvscxwphIW+vTyRFVBvKmhFPPuYORI/CBeNESAqsuNrCJPM8JrJ7j8jUxePBdqpwy17uZf4mH665DSvibBAIa4kQTFLg9vPvAEScdfcFsQfwvDI8qP6qMqz0MixDo5Zd72kizJsR0wa0c8hAWby81XFGfPJnGANryFDfDGXZ1RzYOBaulBPlPdouiYvuEAwbLX+h6KhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvtqAdUEgMUuFku1sgt55+9tA9PxcCjOU8Es+3Hj6NI=;
 b=Jgz+g8l+cYyEW6rcrKOYBTxOQHlK0XE954XVXCDiRfDh1zcFKIb6Jpt2r45v9C9yCtsF+mNnQ9Up7wicqcxcJ/cy8uHs78Pt44OHTwWz/SiIJjMwFZG9O2Zsk3ldCx5y+JYX7AmDM0bu8AQfJxBo5PvlqqrgaGUefLQnFTU8yNs07ZUKBso2Hn/dSxr9pr8ee/dPk+2arxtceJQBva5B1WlLeNCQsmzwvt9/6TkRB6QR5RbZCn+5JRtBBFdqcTgOF7GvBEZUX9I6ka0HZ7lQnPWNffxuTWDSPfeYFhmLLso9Yla/i7f9y2uZzZlQcmUp+OE/94Qe074vhEDHHhiXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvtqAdUEgMUuFku1sgt55+9tA9PxcCjOU8Es+3Hj6NI=;
 b=KAkFbp+RyrTqfEUCcl8dW/H9WUf6IIKhIbQi8xYsOGxXaXMRyU1D9EQd4Cva28HGCfu4ExHdvZWu4eHhdNEw4d9WwGmmvoJn56aYQ6hQd3XQkE32NPJhww9r1BNw8CP6xRVEfZicxnxDUA53KrbLChu/8vR8zTwxMegczpHHVKI=
Received: from BN1PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:e0::34)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 08:43:05 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::25) by BN1PR10CA0029.outlook.office365.com
 (2603:10b6:408:e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 08:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 2 Jun 2026 08:43:05 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:43:03 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 2/3] drm/amdgpu/ras: Add IPID filtering for bad page
 recording
Date: Tue, 2 Jun 2026 16:42:54 +0800
Message-ID: <76f8d336fe220b3a4dca7f0bb2da09c61233c802.1780389586.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1780389586.git.cesun102@amd.com>
References: <cover.1780389586.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d30453-af21-4e2a-b81b-08dec082f6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jd9DPmkd5ZjmXIHMyX0r9TRilt/g/oo56XpLt9IUq82z+zIvg4wjnTeRUkbEyUj6dpCPYKonuqU1QSqqjtlaTwdfuAr+xBfTFuuhiamKPgBXMmj3Q0P5sJnb3RV/oQaMfG2Yl9so8BnSyAq1DPiAYYOE2tCKySLSvAW8ORK2sadIF4EN27hOdCdT6GBKOsU3luGeaqfg4ogVYDdFM5eSr48eJ76ZPrGtT0HIfJVfZ8gdXSSQIvpDBHbYnyi/8ENvTf7MNN5jSbAFSoDUAQS2UMTrP3LVgV/9Zy7LmbJ3pmFkOqwXNktASpJtWx8jwMOdvMezRUo3Mj5MnkXB2sWmdYKGt9LFrHw7YKNklKco16LX13LfvSKkU6gmJSfmV+WD8a+olXhQSCFA73de1H3mBcgAaFw3kDF2ty2xKzOJl+Wz3NxTCuHqNOhMAGvhJ/KhJsvlj2M5bFnBPSxF+6h6svY17Rvgv51N+93vgFSCA0Hhof5duYMkvKw3c9hbJnnpuXcouYeTnVnPSHwNH0bEmyuFUU5aDIihqIgU8TaUDxM/uw9BShg3efbcn1WXBMWBcWLWwnve7vcBMvOl7gdT9aFuexuQBzdPo/X3Imn9jSysyvGYnpS0RvZogl9UzRhRheqipB9rlwGKADGepI6g0DpkihdhD0puravvXbUCAeCHuICAaVjE7ynpFMwb4lhzbXtqNR2XnsM+KkFz3TfPbWeBnwM8sHGf/R8b9O7jeKQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6F2H3pt+N+NZsr33QtSyKlsY9eoBA5M9AQe5lzZLV9gb6UAQvo+d3YCTPt1tSfE83WGgTWKoWjjt6HRC8o4fYeJkbnfzatZy6VE7RtT2FTH4Q+XuBYskxVv4bLaf5h0HFxhvZt6te26dXDxXdg5BKlaTQVfHYbVTm++zwxX/QCbLoAv1HdVBA5MORSMlZ+Naz1Bf3xPOhNcOSt4k2otOMwMYAKQNN55h9BykukslaY4hff6FinjYfyNFKrd7UYXR36bJAjbZV7Wz/8l1y8USwmyUBUZ7RujWLRrd7AHX29GrTEaJ77IV31uJ88mh6rjBj99SwGoCbRTO0NrxlkO5BvpRwp7NUYAR+JDtHEpxuy09o25/puwV4oXk/b+Vc+U5MszYcjhy+0magZWQUqFgmq8lH80in0/CXpxb6ZZaz+J2zhBdYPToh94CAfbexShy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:43:05.2057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d30453-af21-4e2a-b81b-08dec082f6d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

Add IPID decoding macros and filter out SMU decoded IP blocks

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     |  5 ++++-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 20 ++++++++++++++++++-
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.h   |  9 +++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index e5971c3dd7da..cff6245d8add 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -270,7 +270,10 @@ int ras_umc_log_bad_bank(struct ras_core_context *ras_core, struct ras_bank_ecc
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_umc_record umc_rec;
 	struct eeprom_umc_record *err_rec;
-	int ret;
+	int ret = 0;
+
+	if (!ras_umc->ip_func->mca_ipid_check(bank))
+		return ret;
 
 	memset(&umc_rec, 0, sizeof(umc_rec));
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 237525b46b9b..4a693865a9be 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -110,6 +110,7 @@ struct ras_umc_ip_func {
 			uint64_t soc_pa, struct umc_bank_addr *bank_addr);
 	void (*mca_ipid_parse)(struct ras_core_context *ras_core, uint64_t ipid,
 			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
+	bool (*mca_ipid_check)(struct ras_bank_ecc *bank);
 };
 
 struct eeprom_store_record {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..a272e0d80cdb 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -356,11 +356,28 @@ static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
 	return ret;
 }
 
+static bool umc_v12_0_mca_ipid_check(struct ras_bank_ecc *bank)
+{
+	uint16_t hwid, mcatype;
+
+	hwid = ACA_IPID_2_HWID(bank->ipid);
+	mcatype = ACA_IPID_2_MCATYPE(bank->ipid);
+
+	/* The IP block decode of consumption is SMU */
+	if (hwid != UMC_HWID_V12_0 || mcatype != UMC_MCATYPE_V12_0)
+		return false;
+	else
+		return true;
+}
+
 static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 		struct ras_bank_ecc *bank, struct eeprom_umc_record *record)
 {
 	struct umc_phy_addr nps_addr;
-	int ret;
+	int ret = 0;
+
+	if (!umc_v12_0_mca_ipid_check(bank))
+		return ret;
 
 	memset(&nps_addr, 0, sizeof(nps_addr));
 
@@ -524,5 +541,6 @@ const struct ras_umc_ip_func ras_umc_func_v12_0 = {
 	.bank_to_soc_pa = umc_12_0_bank_to_soc_pa,
 	.soc_pa_to_bank = umc_12_0_soc_pa_to_bank,
 	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
+	.mca_ipid_check = umc_v12_0_mca_ipid_check,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
index 8a35ad856165..51459b5ec06e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
@@ -287,6 +287,12 @@
 #define ACA_ADDR_2_ERR_ADDR(addr) \
 	REG_GET_FIELD(addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr)
 
+#define ACA_IPID_2_HWID(ipid) \
+	REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID)
+
+#define ACA_IPID_2_MCATYPE(ipid) \
+	REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType)
+
 /* R13 bit shift should be considered, double the number */
 #define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
 
@@ -306,6 +312,9 @@
 /* one device has 192GB HBM */
 #define SOCKET_LFB_SIZE   0x3000000000ULL
 
+#define UMC_HWID_V12_0     0x96
+#define UMC_MCATYPE_V12_0  0x0
+
 extern const struct ras_umc_ip_func ras_umc_func_v12_0;
 
 int ras_umc_get_badpage_count(struct ras_core_context *ras_core);
-- 
2.34.1

