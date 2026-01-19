Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA534D29C2E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A99F10E498;
	Mon, 19 Jan 2026 15:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1tIoA+Ng";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E0710E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbG0p6V0+HIWDvbIjye/HGdLcn2BixHLGj4OSP4ABOR51KdbwDsddTQN6VmnIk6p8npUVvFOa8ttNp+lRb6Jla8zw0GF0GtxyAghRyhjEa+B+ZbU4WlYACKhnSJ8DmYDkrZZqaARmj72a1FKCyw3TK3C7iRTciW+gSMQ1Lsy/fSnUF86TgNHOnr+h+rjeJkWczQVTNEkc5Uc3KLedsph58YFH2kDJXERWCoj/UbGGyb/wsaRfaDsRpPu+fTLP+1AiM6I33lv459ieX5ns7GA4sHEGU8/olLWpGi+d/D6NpyvN1DCeAmeNdlIYJJb3AFc3rf+1HQoRQoJS3pVjwUhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KDKujqfJd1G/kXqE6xxbT2iSe5LOrxo8i+zCIWk0/U=;
 b=R6yz2KrZmzjlTwG1elObpYur/8KH+c8rBHB4aVWoNZK+FJTJvwkNZM25CqIhsUtf0NsQZmDPgWDfPakVNRhgHdapEb0hfpr6yw2yE/nmyD78Q3HycEp6Sxd9pQQQK/0XljLz04afUDrIj0ttzxQy7nXsjA4e8HNcsNKoLOvTIXIKsd6eAkAOOPXBXsEbmW1l44ttwXxL4NYi+Ily4JVYhEWYHfsHynlIITDKrQTlhaiR/d/Q1D+d56W1XiZO0nMjil4bHiqYNJZgwQaw7Sc0jYBTc5fhDAJvBFvPlEKPSZ6ojgBMhkApbk1iKZJ5TUdvJGPYJGe570p4xUiefh7FBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KDKujqfJd1G/kXqE6xxbT2iSe5LOrxo8i+zCIWk0/U=;
 b=1tIoA+NgXwtR/ehKV4CTP3pUTICkCxJiKVUBBlWw2U/CnYrIaIBW/+ClYRnTzwQXTW9tVRWjvJf6ezBSetqpw+PDk2g4gfpWm8LX3BPbgQo8WvlA9yWEve2W720WIAh8/zQSdUri9lKU0fkUkfloCg5r+AR5/GLWc9DAMhCd6GE=
Received: from BL1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:256::7)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 15:33:47 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::2c) by BL1PR13CA0002.outlook.office365.com
 (2603:10b6:208:256::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Mon,
 19 Jan 2026 15:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:33:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:33:45 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 6/7] drm/amd/pm: Change get_enabled_mask signature
Date: Mon, 19 Jan 2026 20:58:23 +0530
Message-ID: <20260119153309.1234663-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119153309.1234663-1-lijo.lazar@amd.com>
References: <20260119153309.1234663-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: e391a833-9dc2-4360-2090-08de57702331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?17dMd9s7IO4XnLq1PQRpqSoG3POXQUxTrxJ0vyda3XTUAdZFNkCHuyybtXuk?=
 =?us-ascii?Q?7/e3YQ8XAyBAz1fcufZnQAlOAklXdtoj28YL6zaFCqXkB8kNY5adTDDTX99U?=
 =?us-ascii?Q?EMVDEf/8xoBA+Qa7ccYMd1GqXrlzRlxughKP72bOKy9QNYljdMC0xy/UA8w+?=
 =?us-ascii?Q?zEhwIcmzbJftBjK92hKPdpIYNUx0iJj52gH/eyWHP2sTHWgLIgCFYI2hJZVm?=
 =?us-ascii?Q?eQaSGU8NSch6WBZybbzh7KFcO3QzX1l8rm1i0cW1WlUqu+Vxo7xUmKRS3TNo?=
 =?us-ascii?Q?G7J7p8vMg8EAlgZEGeuFnOPgUt7eZCQpfPk1UblzmfbHKSzflVE9OTq26NfC?=
 =?us-ascii?Q?wy3p2iu8NCHWcD74MGiB7OleWnmcTpm7P9bqcVT9aryVisTd/HRtkieglWR6?=
 =?us-ascii?Q?dxLb1z12YDpumKnw9tofwBuG/HBscHgqQIGkpkX1Zop32l8q2JplsCw4w+pn?=
 =?us-ascii?Q?R1XcqB0oCem8xurw3f0CgRyVL0m9eevdCvnWUH1lXV02PGaL+duo4oJeUvVB?=
 =?us-ascii?Q?KcjPq/o0iWabN3hPOpORXttmtgGUyMW+8ugMaTgNjrgfPTPuKVBRIFq2yC4C?=
 =?us-ascii?Q?EC5lQA0uHUO1hAe3M//hsMhoMCChOYWht3Weu06AM2fYye/Sc2ukgUlLUefh?=
 =?us-ascii?Q?HsH5Hs+fltSpT8ztXGLaWKg7uyG+0ytzhQJTsnPsFZyfIAwvodAFqtkJcXTE?=
 =?us-ascii?Q?uicC7VhZnAO1SRGl+zocJXjmUBcb821+Qmos4V1kCnM6hoFK315Jta+a3Kuh?=
 =?us-ascii?Q?C9tivVN1M1rxvzBSneJyYvzO9o14Sld21Jh6Wor1zhdvxlmRECAbzFwWX+9P?=
 =?us-ascii?Q?4WpdPLdQKgQIRXCH8j1m8FHjT+/3u0p2syO4XLv6wUB/zoUHIsJ+pMFY8tRd?=
 =?us-ascii?Q?A1EW6BO4ChXw9M5OgDZ4QKG0fh4LmRzDqbG6J70D0Q2qszCLqw8lJkJsmdtz?=
 =?us-ascii?Q?7Pe7iEYN+PGocGt3/pXgjbzINLs0RzMNWcwI9utGcQ0e2imHQ+dEJwmGrh30?=
 =?us-ascii?Q?nsQ7L/4i50Rm64giMrhekkNM/KbJ8TIPyZDAl4J7x6mf6zk1/vlUr93Ycqks?=
 =?us-ascii?Q?2llp9TupyTYFhdPsoKqOlHxu/wxQE5XLVb0igf4NJvdLn3KoaFV9QH5JF3oV?=
 =?us-ascii?Q?ecaW2QCSqcbSAnStttRKKySoMx+Fh7kOYd0av8McRV7rgaVe9vEiYFJxLPZI?=
 =?us-ascii?Q?8+HPpqq4MqCqptmYtp4tr4m2Wjle74fFEdkahHc6h3EHyxxf/7ca/N+qPiva?=
 =?us-ascii?Q?fo6BomtId8B0wd8DvdVdoWfeq866I7W05GOd3yMvMIMg3nEW7ca527Wk11Nz?=
 =?us-ascii?Q?Hr/yddnG+Nd5buBphBBaVDnZaPDWapFzVoLYXMuWHSlZlj0zkGa4WQ3/zC8A?=
 =?us-ascii?Q?mk4ANdxOx67hICl8AqQ6UFb/7GDTG/kYhO2SaDz2I7nXRS/p3sChefzwBTLW?=
 =?us-ascii?Q?Lh/WGE2xEO6xWEeP6FqUOAPnDllvjq0AxkWa11bN9F3jJUgvz9+tzEKjt15l?=
 =?us-ascii?Q?3t2rA2f7nRoJfTqr22/F/IRWgO2hEufTzyWTlWrPt32F8iiXNLkaxNJZW4HK?=
 =?us-ascii?Q?4r5HkTDygGO+EqVqV6cJYYG9N2nwSR6r+FWGChe36FbOQty+qTCh/TyoCgrl?=
 =?us-ascii?Q?fLhStGg+hek9YjGCjquWcDl52DfZ4OSEHXMAwLi5MQXO/FtI2xF3eaBZ/EM0?=
 =?us-ascii?Q?v5z9tA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:33:47.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e391a833-9dc2-4360-2090-08de57702331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

Use smu_feature_bits instead of uint64_t pointer and operate on
feature bits.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 +++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  9 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  7 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 14 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  7 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  7 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  7 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  4 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  7 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  7 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 20 +++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  7 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  7 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 11 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  7 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  7 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  7 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  7 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 72 +++++++++----------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +-
 21 files changed, 123 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e75dd0152ea7..62d34f69149c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1643,7 +1643,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint8_t pcie_gen = 0, pcie_width = 0;
-	uint64_t features_supported;
+	struct smu_feature_bits features_supported;
 	int ret = 0;
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
@@ -1804,7 +1804,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 	smu_feature_list_set_bits(smu, SMU_FEATURE_LIST_SUPPORTED,
-				  (unsigned long *)&features_supported);
+			     features_supported.bits);
 
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
@@ -3149,10 +3149,19 @@ static int smu_read_sensor(void *handle,
 		*((uint32_t *)data) = pstate_table->uclk_pstate.peak * 100;
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
-		ret = smu_feature_get_enabled_mask(smu, (uint64_t *)data);
+	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK: {
+		struct smu_feature_bits feature_mask;
+		uint32_t features[2];
+
+		/* TBD: need to handle for > 64 bits */
+		ret = smu_feature_get_enabled_mask(smu, &feature_mask);
+		if (!ret) {
+			smu_feature_bits_to_arr32(&feature_mask, features, 64);
+			*(uint64_t *)data = *(uint64_t *)features;
+		}
 		*size = 8;
 		break;
+	}
 	case AMDGPU_PP_SENSOR_UVD_POWER:
 		*(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UVD_BIT) ? 1 : 0;
 		*size = 4;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index c58290686f0d..4019ef859504 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1229,7 +1229,8 @@ struct pptable_funcs {
 	 *                    on the SMU.
 	 * &feature_mask: Enabled feature mask.
 	 */
-	int (*get_enabled_mask)(struct smu_context *smu, uint64_t *feature_mask);
+	int (*get_enabled_mask)(struct smu_context *smu,
+				struct smu_feature_bits *feature_mask);
 
 	/**
 	 * @feature_is_enabled: Test if a feature is enabled.
@@ -2061,6 +2062,12 @@ static inline bool smu_feature_bits_empty(const struct smu_feature_bits *bits,
 	return bitmap_empty(bits->bits, nbits);
 }
 
+static inline bool smu_feature_bits_full(const struct smu_feature_bits *bits,
+					 unsigned int nbits)
+{
+	return bitmap_full(bits->bits, nbits);
+}
+
 static inline void smu_feature_bits_copy(struct smu_feature_bits *dst,
 					 const unsigned long *src,
 					 unsigned int nbits)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 814f24b7ccc4..0c4afd1e1aab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1527,15 +1527,14 @@ static int arcturus_set_performance_level(struct smu_context *smu,
 static bool arcturus_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&arcturus_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  arcturus_dpm_features.bits);
 }
 
 static int arcturus_dpm_set_vcn_enable(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 406acfbbbc63..87953a4d0a43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -363,8 +363,7 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
@@ -381,8 +380,8 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 		cyan_skillfish_get_smu_metrics_data(smu, METRICS_CURR_GFXCLK,
 			&cyan_skillfish_sclk_default);
 
-	smu_feature_bits_to_arr32(&cyan_skillfish_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  cyan_skillfish_dpm_features.bits);
 }
 
 static ssize_t cyan_skillfish_get_gpu_metrics(struct smu_context *smu,
@@ -569,12 +568,13 @@ static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
 	return 0;
 }
 
-static int cyan_skillfish_get_enabled_mask(struct smu_context *smu,
-					   uint64_t *feature_mask)
+static int
+cyan_skillfish_get_enabled_mask(struct smu_context *smu,
+				struct smu_feature_bits *feature_mask)
 {
 	if (!feature_mask)
 		return -EINVAL;
-	memset(feature_mask, 0xff, sizeof(*feature_mask));
+	smu_feature_bits_fill(feature_mask);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f5be64395108..737bfdfb814c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1621,15 +1621,14 @@ static int navi10_display_config_changed(struct smu_context *smu)
 static bool navi10_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&navi10_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  navi10_dpm_features.bits);
 }
 
 static int navi10_get_fan_speed_rpm(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 7d23b6c8c538..6268bc5ed3e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1536,15 +1536,14 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&sienna_cichlid_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  sienna_cichlid_dpm_features.bits);
 }
 
 static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f8b76577d008..08179840697e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -506,8 +506,7 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
@@ -518,8 +517,8 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&vangogh_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  vangogh_dpm_features.bits);
 }
 
 static int vangogh_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 5346b60b09b9..31e21ff8859a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1434,11 +1434,11 @@ static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 }
 
 static int renoir_get_enabled_mask(struct smu_context *smu,
-				   uint64_t *feature_mask)
+				   struct smu_feature_bits *feature_mask)
 {
 	if (!feature_mask)
 		return -EINVAL;
-	memset(feature_mask, 0xff, sizeof(*feature_mask));
+	smu_feature_bits_fill(feature_mask);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 4185c7282a11..ad23682217ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1398,14 +1398,13 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 static bool aldebaran_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
-	smu_feature_bits_to_arr32(&aldebaran_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  aldebaran_dpm_features.bits);
 }
 
 static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 0856c1c34d7a..de770c10da3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -691,15 +691,14 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 static bool smu_v13_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v13_0_0_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v13_0_0_dpm_features.bits);
 }
 
 static int smu_v13_0_0_system_features_control(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 9a34e5460b35..3d60d3c1e585 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -52,10 +52,13 @@
 #define SMU_13_0_12_FEA_MAP(smu_feature, smu_13_0_12_feature)                    \
 	[smu_feature] = { 1, (smu_13_0_12_feature) }
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE                                                        \
-	(FEATURE_MASK(FEATURE_DATA_CALCULATION) |                              \
-	 FEATURE_MASK(FEATURE_DPM_GFXCLK) | FEATURE_MASK(FEATURE_DPM_FCLK))
+static const struct smu_feature_bits smu_v13_0_12_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_DATA_CALCULATION),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK)
+	}
+};
 
 #define NUM_JPEG_RINGS_FW	10
 #define NUM_JPEG_RINGS_GPU_METRICS(gpu_metrics) \
@@ -199,14 +202,14 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu)
 }
 
 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
-					 uint64_t *feature_mask)
+					 struct smu_feature_bits *feature_mask)
 {
 	int ret;
 
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
 
 	if (ret == -EIO) {
-		*feature_mask = 0;
+		smu_feature_bits_clearall(feature_mask);
 		ret = 0;
 	}
 
@@ -372,14 +375,15 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
-	uint64_t feature_enabled;
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_v13_0_12_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v13_0_12_dpm_features.bits);
 }
 
 int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 741762f4bd2c..75b90ac0c29c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -213,16 +213,15 @@ static int smu_v13_0_4_fini_smc_tables(struct smu_context *smu)
 static bool smu_v13_0_4_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v13_0_4_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v13_0_4_dpm_features.bits);
 }
 
 static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 7311162e50f0..8ee5002e3d6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -232,16 +232,15 @@ static int smu_v13_0_5_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 static bool smu_v13_0_5_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v13_0_5_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v13_0_5_dpm_features.bits);
 }
 
 static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 97866e570192..be7d77eee2b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2272,14 +2272,14 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 }
 
 static int smu_v13_0_6_get_enabled_mask(struct smu_context *smu,
-					uint64_t *feature_mask)
+					struct smu_feature_bits *feature_mask)
 {
 	int ret;
 
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
 
 	if (ret == -EIO && !smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
-		*feature_mask = 0;
+		smu_feature_bits_clearall(feature_mask);
 		ret = 0;
 	}
 
@@ -2289,8 +2289,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_context *smu,
 static bool smu_v13_0_6_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
 		return smu_v13_0_12_is_dpm_running(smu);
@@ -2300,8 +2299,8 @@ static bool smu_v13_0_6_is_dpm_running(struct smu_context *smu)
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v13_0_6_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v13_0_6_dpm_features.bits);
 }
 
 static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index eeff6c874635..fe3d6bfe6812 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -699,15 +699,14 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 static bool smu_v13_0_7_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v13_0_7_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v13_0_7_dpm_features.bits);
 }
 
 static uint32_t smu_v13_0_7_get_throttler_status(SmuMetrics_t *metrics)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 2331dbb9181a..f9789b1fcbf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -259,16 +259,15 @@ static int yellow_carp_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&yellow_carp_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  yellow_carp_dpm_features.bits);
 }
 
 static int yellow_carp_post_smu_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 019e43fdecd6..dbdf7653cc53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -472,16 +472,15 @@ static int smu_v14_0_0_read_sensor(struct smu_context *smu,
 static bool smu_v14_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v14_0_0_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v14_0_0_dpm_features.bits);
 }
 
 static int smu_v14_0_0_set_watermarks_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index eb8bad2de1cc..becfd356b4e7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -589,15 +589,14 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 static bool smu_v14_0_2_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v14_0_2_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v14_0_2_dpm_features.bits);
 }
 
 static uint32_t smu_v14_0_2_get_throttler_status(SmuMetrics_t *metrics)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index d66e9a1a0ef8..c3f22844ba2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -446,16 +446,15 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
-	uint64_t feature_enabled;
-	uint32_t feature_mask[2];
+	struct smu_feature_bits feature_enabled;
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	smu_feature_bits_to_arr32(&smu_v15_0_0_dpm_features, feature_mask, 64);
-	return !!(feature_enabled & *(uint64_t *)feature_mask);
+	return smu_feature_bits_test_mask(&feature_enabled,
+					  smu_v15_0_0_dpm_features.bits);
 }
 
 static int smu_v15_0_0_set_watermarks_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 9bb7e3760c0f..da35d54a6e4e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -690,7 +690,7 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 }
 
 static int __smu_get_enabled_features(struct smu_context *smu,
-			       uint64_t *enabled_features)
+				      struct smu_feature_bits *enabled_features)
 {
 	return smu_cmn_call_asic_func(get_enabled_mask, smu, enabled_features);
 }
@@ -699,7 +699,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint64_t enabled_features;
+	struct smu_feature_bits enabled_features;
 	int feature_id;
 
 	if (__smu_get_enabled_features(smu, &enabled_features)) {
@@ -712,7 +712,8 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	 * enabled. Also considering they have no feature_map available, the
 	 * check here can avoid unwanted feature_map check below.
 	 */
-	if (enabled_features == ULLONG_MAX)
+	if (smu_feature_bits_full(&enabled_features,
+				  smu->smu_feature.feature_num))
 		return 1;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
@@ -721,7 +722,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	if (feature_id < 0)
 		return 0;
 
-	return test_bit(feature_id, (unsigned long *)&enabled_features);
+	return smu_feature_bits_is_set(&enabled_features, feature_id);
 }
 
 bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
@@ -763,45 +764,38 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 }
 
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
-			     uint64_t *feature_mask)
+			     struct smu_feature_bits *feature_mask)
 {
-	uint32_t *feature_mask_high;
-	uint32_t *feature_mask_low;
+	uint32_t features[2];
 	int ret = 0, index = 0;
 
 	if (!feature_mask)
 		return -EINVAL;
 
-	feature_mask_low = &((uint32_t *)feature_mask)[0];
-	feature_mask_high = &((uint32_t *)feature_mask)[1];
-
 	index = smu_cmn_to_asic_specific_index(smu,
 						CMN2ASIC_MAPPING_MSG,
 						SMU_MSG_GetEnabledSmuFeatures);
 	if (index > 0) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_GetEnabledSmuFeatures,
-						      0,
-						      feature_mask_low);
+		ret = smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GetEnabledSmuFeatures, 0, &features[0]);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_GetEnabledSmuFeatures,
-						      1,
-						      feature_mask_high);
+		ret = smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GetEnabledSmuFeatures, 1, &features[1]);
 	} else {
-		ret = smu_cmn_send_smc_msg(smu,
-					   SMU_MSG_GetEnabledSmuFeaturesHigh,
-					   feature_mask_high);
+		ret = smu_cmn_send_smc_msg(
+			smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &features[1]);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg(smu,
-					   SMU_MSG_GetEnabledSmuFeaturesLow,
-					   feature_mask_low);
+		ret = smu_cmn_send_smc_msg(
+			smu, SMU_MSG_GetEnabledSmuFeaturesLow, &features[0]);
 	}
 
+	if (!ret)
+		smu_feature_bits_from_arr32(feature_mask, features, 64);
+
 	return ret;
 }
 
@@ -886,7 +880,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 				   char *buf)
 {
 	int8_t sort_feature[MAX(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
-	uint64_t feature_mask;
+	struct smu_feature_bits feature_mask;
+	uint32_t *feature_mask_u32;
 	int i, feature_index;
 	uint32_t count = 0;
 	size_t size = 0;
@@ -894,8 +889,10 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	if (__smu_get_enabled_features(smu, &feature_mask))
 		return 0;
 
-	size =  sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
-			upper_32_bits(feature_mask), lower_32_bits(feature_mask));
+	/* TBD: Need to handle for > 64 bits */
+	feature_mask_u32 = (uint32_t *)feature_mask.bits;
+	size = sysfs_emit_at(buf, size, "features high: 0x%08x low: 0x%08x\n",
+			     feature_mask_u32[1], feature_mask_u32[0]);
 
 	memset(sort_feature, -1, sizeof(sort_feature));
 
@@ -916,12 +913,13 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 		if (sort_feature[feature_index] < 0)
 			continue;
 
-		size += sysfs_emit_at(buf, size, "%02d. %-20s (%2d) : %s\n",
-				count++,
-				smu_get_feature_name(smu, sort_feature[feature_index]),
-				feature_index,
-				!!test_bit(feature_index, (unsigned long *)&feature_mask) ?
-				"enabled" : "disabled");
+		size += sysfs_emit_at(
+			buf, size, "%02d. %-20s (%2d) : %s\n", count++,
+			smu_get_feature_name(smu, sort_feature[feature_index]),
+			feature_index,
+			smu_feature_bits_is_set(&feature_mask, feature_index) ?
+				"enabled" :
+				"disabled");
 	}
 
 	return size;
@@ -931,7 +929,8 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 				uint64_t new_mask)
 {
 	int ret = 0;
-	uint64_t feature_mask;
+	struct smu_feature_bits feature_mask;
+	uint64_t feature_mask_u64;
 	uint64_t feature_2_enabled = 0;
 	uint64_t feature_2_disabled = 0;
 
@@ -939,8 +938,9 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	feature_2_enabled  = ~feature_mask & new_mask;
-	feature_2_disabled = feature_mask & ~new_mask;
+	feature_mask_u64 = *(uint64_t *)feature_mask.bits;
+	feature_2_enabled = ~feature_mask_u64 & new_mask;
+	feature_2_disabled = feature_mask_u64 & ~new_mask;
 
 	if (feature_2_enabled) {
 		ret = smu_cmn_feature_update_enable_state(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 92ad2ece7a36..b7bfddc65fb2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -141,7 +141,7 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 				enum smu_clk_type clk_type);
 
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
-			     uint64_t *feature_mask);
+			     struct smu_feature_bits *feature_mask);
 
 uint64_t smu_cmn_get_indep_throttler_status(
 					const unsigned long dep_status,
-- 
2.49.0

