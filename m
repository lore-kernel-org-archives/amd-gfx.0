Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A596CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BEB10E47F;
	Mon, 22 Jun 2026 04:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrHwf+g1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A7410E47F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTqSNU+ug9jnRY81jLkRp1K8CxzUcw4xkLTPhQccKRyy1MuyI7os3NLD+7b1J9lE9DYPTE0RSE+KbwyHv2/QlcZb9rKS3ad2lKUMW8mas9u8T/SWVexU9FpIMwv34neyAvVBtcBW72uNCmjjysQ6TN9+RgQQIhmD9OWZmByVNJO9D1SzW0pp1Psu6HcfyZs2HgVEysQj/EIw3ZYIp9Kdrp7FpQvZxc5/Srs+6MP3rn+wPLij+WgegMXQD9BxVsxFS9AbfDVL3/FEyrDYaLsl5mF7YjaeVbgLN0n7jNPa9WVYytxIv5Uu5qT0NQbqycOxE4By2V1X2/9RzXDBhGubZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72/Mm7RbrkPFDQeEnIiW/3QFl7ZOnvm849Iyf93CkBQ=;
 b=aijPrJdzk7Xt/T/k0qQC1iN9tqHn9NJ5c+JzVpax4kPFNs8tonyLVayKs1iuvRAIw7Z9DSn5aJ5zvb2zQREyk2vrS2GHDkwffQ7KnRCRs4XZdqhv+Xt6vMAZDd9v3qnVgjIqsNcCKxZWZZgmqFqnUd/FUQbOZt3skgWqreBnuZj4O2/85PKNX1YHRr2cqaM5iPWxw0TWiv/YYV56ejDdVbSj0Lw3uyEGUB6k72W6ZqS2NT0z1eKJE6xQ4iW2g5qQummHeOaW7tPfEuj8o9EJqiA00MduM4yyFUrZBKmnEw3izrXLtouOm50JlF8FkJS03hWnf+rYucri6fUwvi5RlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72/Mm7RbrkPFDQeEnIiW/3QFl7ZOnvm849Iyf93CkBQ=;
 b=WrHwf+g1ayDr1S349jwnghPqOAQBhcToM95fuct2fh4N/4oqvZG/YKLvEixqkc18Wfy/IkY3AxQ+9iBe9Yz4iNea/FpchSuCUWjfszvXsV4gT7hO1Sh/sRjuJDUTUhEIQhb0r5VmtMei+ndbDeMVzYK2pQdPGgYPYovUrZ8Uq40=
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:43:11 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::9c) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 22 Jun 2026 04:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:10 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:08 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 37/48] drm/amdgpu: retire legacy pmfw eeprom init
Date: Mon, 22 Jun 2026 12:40:26 +0800
Message-ID: <77b1d125e585455feb42d7c9c70183af2eac5b7a.1782103074.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 730455d9-3966-4582-4820-08ded018c335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pA2ECpyG3jddpemadXzjbk10wJX89QXX91QYW0pQ3ncr96LLn+iOJiYypIqzdyDpt5I6O80qeQpxFVGVL9VyvFASEtsAzOREVQWkds1Hjw2saIetH9XuoM+yq06lydBs7Ew8Hp3ET4aCW7oqvu1nGeern6S7/Sqw+VAUCLsu+afVUW4CMUqI5rm+8/T7tjeQIqhEUqBk0wMp1RV2bxH5qznsfFB7peEkZS3yGYcXZRqjrJ7ibi8J2fVP0c3rQyzjoMkVAvoQPanxFokcCViiInX7UpJsUffj+rmR4Ie9CSmw4sXk8NOk9fhUpmzMBx924M7UMjZ13XSVuK/YZhQixVoC6r/PSGngXGdXCIAX2r/ZoNJqUpVzibEOS/55xM8HyDIgvl1zZnWclCtxtNZTQ5fwEAkISJ7npQid8Ua7S/RVwuq60+BW7y/du1xg4YHVkwwcujjNAddPh63kxhiOKae6CRz0ir4ylYneha60VT6qX28vJ6/GTiOUlcD17U0Vu1Y+8sSPTGgRwz7yFOb6xJOpGd9m2tLir0T8dItgVfsU0w+94Hp8fCQerfrLLj+I3I1DyAqE3g/Dqzi1gg0JDJZ/msMdSINnd9DkM3raLuOTpPYvrJyUhxWwBy9tAnxDfqde8ZbFu6YuQj8uGnB1v3pHpjIUaJ3kCTE+xNDsBVYiu2/kg867tbw35Tdh4b1gmahd6qESko+aILeM+AQZTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UDhXr+LS73ceHk5RNIiMKSdZjNDlc28XZLvccdhTU0NZ7YXZPs+9cYulwxBuvoUaljIwSKS9RG+TLi4phaHUAM9SGiuz5b9lLziruZ6ubVB0Sffz73TZIW/P/IbtKkNvoscyTuBLJeKV7yoc2gYlwKOh+qSM4NXtYUy7RSFxZWeBpQhkKSFfxbJK4erJxyiGYkBRYwc2DjKhDPbnjKbAGy9hcSqCDQiRUH2U2oLmwCLLQqDdcgywHKT75biL1yB7bssgGL7/ektRXRm6+YMo8m5WgOLkPMY6QYABPeaqetQ79VbjR3PmlHrnezKtPQjeaqSOC53OLW0HCNriprBwLXMuQJ6G29U/A2BuAiulnbBiNJ3AHfpGUlwjpSucVFjI6Kl29ybseJhwSie4Bl2oE2fFExUdbZBLXpJUDl/Nn7UTBeZqBIZgaim3zXq0fibi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:10.5603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730455d9-3966-4582-4820-08ded018c335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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

Remove the legacy pmfw eeprom initialization function,
as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f5d1bc1142a8..09aa5655e3c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1485,42 +1485,6 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
 }
 
-static int amdgpu_ras_smu_eeprom_init(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint64_t local_time;
-	int res;
-
-	ras->is_rma = false;
-
-	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-	mutex_init(&control->ras_tbl_mutex);
-
-	res = amdgpu_ras_smu_get_table_version(adev, &(hdr->version));
-	if (res)
-		return res;
-
-	res = amdgpu_ras_smu_get_badpage_count(adev,
-								&(control->ras_num_recs), 100);
-	if (res)
-		return res;
-
-	local_time = (uint64_t)ktime_get_real_seconds();
-	res = amdgpu_ras_smu_set_timestamp(adev, local_time);
-	if (res)
-		return res;
-
-	control->ras_max_record_count = 4000;
-
-	control->ras_num_mca_recs = 0;
-	control->ras_num_pa_recs = 0;
-
-	return 0;
-}
-
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1531,9 +1495,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	uint32_t vram_type = adev->gmc.vram_type;
 	int res;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_init(control);
-
 	ras->is_rma = false;
 
 	if (!__is_ras_eeprom_supported(adev))
-- 
2.34.1

