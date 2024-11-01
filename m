Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465F8E6749A
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 03:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D5310E192;
	Fri,  1 Nov 2024 03:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gwt1OvvP";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C0810E192
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 03:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6cR2moHTt8Do+ROlt6bgOfkknEY9tqS5+xJdAfSSPT8UtmfkcFJIvkyWCgGoUsYUU9MU3QfI9zvxLyM7UIE8nsDsq5RYnwQAjnK60fk8AOZRXXGX/FOvTwPm7oaP66i65IdRw04k1S4pTLY41iRJr27i3aO70XZg8jTKcid1QhN2C5/5zQK5Znn4tZExr+e4QL0MNCW+f4KtZs1oR00pxmvSIB0U3bf5h2AV/j/axnZ5RdTs2i9ffMeXtsBuuNQaiE8we6Q4RzNa/vOMQJ4wiUc6NfG4Bq76pjE+/iAfeu2eiKZ70fcrjolBS2eBesDPEOaGkImiUcy/I4qonjEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRZdaozwkHSkMU8Fb8Vl6e+P7lkMegkiFyBYL/nAEpE=;
 b=J8b2UiyuriaeV+C3fpj42z1RQWanQcoTx+sIxdt5E8B7hipkw9BEVnx9+ZeYFAwA1P1xOJPwu8/fRuwMfUkBXGgvubuXl+SifXaRXmndnTvvjwPkCa1Ov7HwkH0jcd9JwZ+TOde+bgzs7TOxmIwM2m5nojMyx3Oq0x4mCkKSIGnT1Q9ZfaWvJOXOsC4maEeAhUYd/uj/E2HhsIZKMDoGbsPNkTJzR7tVcP2WNjgfu3kyCgKtd5G9QbxfmLT6lRmem1VkGnRJbTmNd5xjJwqJqe6CFrGJFfURgfCgeJ3vH3lHybJgkNVLsGc/XaN87nW4SCKpLKjlHkL0QKpyWziI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRZdaozwkHSkMU8Fb8Vl6e+P7lkMegkiFyBYL/nAEpE=;
 b=Gwt1OvvPeJGReTcyNIPfvSfu+y6qRkj4bq8+vSENgkSlRfPB6RiU9d9Y/tWoSn9vuflox6vWHdzETmYGOpCLhal2eT7Zf0ljRraQ1Hve6auPVqenZ2upvlLLXcjNrSh0W2bmWy/CPB5gwSsn103Ovvf5oauiw6X+t7tLGL18tN4=
Received: from BL1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:256::6)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 03:57:11 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::84) by BL1PR13CA0001.outlook.office365.com
 (2603:10b6:208:256::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.11 via Frontend
 Transport; Fri, 1 Nov 2024 03:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 03:57:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 22:57:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 22:57:09 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 31 Oct 2024 22:57:09 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: always pick the pptable from IFWI
Date: Fri, 1 Nov 2024 11:57:01 +0800
Message-ID: <20241101035701.86175-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 38655bb3-ed9f-4975-ad87-08dcfa294369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gWuEWZyimSiY94zyLvO5sHQpVdcSbEs/cL+JouxnCeFsgWTPa+4pD3kTiTma?=
 =?us-ascii?Q?VvHMWZhZTsf6hLvgyKXjM4Byi2KqaS2//k+/Wyn9HYbtiqUTNVIdktz8JuNj?=
 =?us-ascii?Q?GGCO8E4nEPZTFzvMecRgkNdZTyySO/9b6Cp7OtchANtbGsymcF2iZgT6n0Cd?=
 =?us-ascii?Q?HMOTqiAV/iasac4Ln8U8nKKntHnkqqzf6TWPpcVScxdBrnQHD5nQGjAyRD7h?=
 =?us-ascii?Q?8BTum6XsPKafY7isx4oHibommBFG8hLaKXgRMfV24RH6Fx2DgUcxD4Ln6fhj?=
 =?us-ascii?Q?VF+4Y1BSTEp14ETBnK/PEKTkXoWUSuINa1fZaKiMl6hk9tDMdtLxcKbd+s9b?=
 =?us-ascii?Q?ScGIfvQq1N8AS/b7r+hLgC1qpZtQo4ozDVdHt+anTQkYPfUdmklfNT0sVfyb?=
 =?us-ascii?Q?8pg3c9n17wir0kJRGeZyqVmoD+zbDF+EsaTn3HqA8z6RolD4kChEjt3/nMl8?=
 =?us-ascii?Q?nfqqfRd4OPZpyi22sj/PRGn0kJ8IThKI+5++ABmZBHO3ThT2I+84oxQVKRkH?=
 =?us-ascii?Q?6il7r1OtEKUaC8NjxZCSRz9MQNTtQoNGfhadzI1iGIQlqwb0XALWnlGC6B4T?=
 =?us-ascii?Q?Qgwy395NbOHyh6K0LqB/NK89b1dSUNooSfHwpudNqjeYY0mEJ26yK5N2InWt?=
 =?us-ascii?Q?jMROYFUcR7w54gJBXXT9bxG/bcoLny7kMrvNK6EbKe2Bv6A2UUdtr943gf8+?=
 =?us-ascii?Q?BldyisdboY/4E2c57guHohtXAedl3QJ9c9mOeQ7UIzgjKRdRvsiVj+tVOIJZ?=
 =?us-ascii?Q?SFmXir7ha5ilj4EDJE4hjo78+QGm3CTCEpks648TSlRbxl/YmBFrHHbJncUe?=
 =?us-ascii?Q?J8qGb1F03g1mmSYyxfKXQE1+TG2iriW0q3cKkS1oQEYDJfABV5rKH7ritILG?=
 =?us-ascii?Q?KiRHN3U3EmUvmmrmPE5+S7eFjnaM7lv3S09U32aUTfx1qVn7qxCnaAmQX2lB?=
 =?us-ascii?Q?BES3t73pH28vRzgwCbQUvzODG7pI9sD1zHlnZLCOkdm5K7r6kviyNvaTPVtV?=
 =?us-ascii?Q?KchVGV2rJFVnYtJW/rGs13n8JhziJqLws3J9a9YxBCxwcB+cNWbe0Q7zpaey?=
 =?us-ascii?Q?CzyDOT/QTjAkk2K0tegm8lWEsYUUUv5STzzRuEsHksXUNVBbws2zyB/efE5m?=
 =?us-ascii?Q?S9v77ORznOE3NcOt1pvlQo6sjmsYr+Ek7pwEV2GRzHojxOtJeKG2C6KYQ4yR?=
 =?us-ascii?Q?vUKkdK1UoQQ2PnsbZnBr4wrsIUKxCtpotO/7wcd6OdUupELiCJ44at46gb+7?=
 =?us-ascii?Q?q+PDTtJZjB0IMoSIfb+GsWTZIJPxqEn/ZioJnaWbX2lCFhsyJgPLXubaFDme?=
 =?us-ascii?Q?HvqhBAAY/fSXBzubhXUHwpm1skDFN/BHC9maJzDWhT80EmftGB5EE1eBM3T/?=
 =?us-ascii?Q?wi09syWfGdvQXJ2UytgxL/FQtYlE15PsqSvumfnhRvQhk5JfYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 03:57:11.0745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38655bb3-ed9f-4975-ad87-08dcfa294369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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

always pick the pptable from IFWI on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 65 +------------------
 1 file changed, 1 insertion(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e8ef6aa1d664..59b369eff30f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -367,54 +367,6 @@ static int smu_v14_0_2_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
-#ifndef atom_smc_dpm_info_table_14_0_0
-struct atom_smc_dpm_info_table_14_0_0 {
-	struct atom_common_table_header table_header;
-	BoardTable_t BoardTable;
-};
-#endif
-
-static int smu_v14_0_2_append_powerplay_table(struct smu_context *smu)
-{
-	struct smu_table_context *table_context = &smu->smu_table;
-	PPTable_t *smc_pptable = table_context->driver_pptable;
-	struct atom_smc_dpm_info_table_14_0_0 *smc_dpm_table;
-	BoardTable_t *BoardTable = &smc_pptable->BoardTable;
-	int index, ret;
-
-	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-					    smc_dpm_info);
-
-	ret = amdgpu_atombios_get_data_table(smu->adev, index, NULL, NULL, NULL,
-					     (uint8_t **)&smc_dpm_table);
-	if (ret)
-		return ret;
-
-	memcpy(BoardTable, &smc_dpm_table->BoardTable, sizeof(BoardTable_t));
-
-	return 0;
-}
-
-#if 0
-static int smu_v14_0_2_get_pptable_from_pmfw(struct smu_context *smu,
-					     void **table,
-					     uint32_t *size)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	void *combo_pptable = smu_table->combo_pptable;
-	int ret = 0;
-
-	ret = smu_cmn_get_combo_pptable(smu);
-	if (ret)
-		return ret;
-
-	*table = combo_pptable;
-	*size = sizeof(struct smu_14_0_powerplay_table);
-
-	return 0;
-}
-#endif
-
 static int smu_v14_0_2_get_pptable_from_pmfw(struct smu_context *smu,
 					     void **table,
 					     uint32_t *size)
@@ -436,16 +388,12 @@ static int smu_v14_0_2_get_pptable_from_pmfw(struct smu_context *smu,
 static int smu_v14_0_2_setup_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (amdgpu_sriov_vf(smu->adev))
 		return 0;
 
-	if (!adev->scpm_enabled)
-		ret = smu_v14_0_setup_pptable(smu);
-	else
-		ret = smu_v14_0_2_get_pptable_from_pmfw(smu,
+	ret = smu_v14_0_2_get_pptable_from_pmfw(smu,
 							&smu_table->power_play_table,
 							&smu_table->power_play_table_size);
 	if (ret)
@@ -455,16 +403,6 @@ static int smu_v14_0_2_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	/*
-	 * With SCPM enabled, the operation below will be handled
-	 * by PSP. Driver involvment is unnecessary and useless.
-	 */
-	if (!adev->scpm_enabled) {
-		ret = smu_v14_0_2_append_powerplay_table(smu);
-		if (ret)
-			return ret;
-	}
-
 	ret = smu_v14_0_2_check_powerplay_table(smu);
 	if (ret)
 		return ret;
@@ -2785,7 +2723,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.setup_pptable = smu_v14_0_2_setup_pptable,
 	.check_fw_version = smu_v14_0_check_fw_version,
-	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v14_0_set_driver_table_location,
 	.system_features_control = smu_v14_0_system_features_control,
 	.set_allowed_mask = smu_v14_0_set_allowed_mask,
-- 
2.34.1

