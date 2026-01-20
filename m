Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB039D2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B7E10E4CE;
	Tue, 20 Jan 2026 06:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HbDqENS/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B19D10E256
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8cvrYBJtlMAIH/mOSRLfEc+yFoO3JQ1E90FbOoNBimuekUglSyKL6pOJwukdB1xQqy7z0UjN0veEtIwvdhnhNzNTKg29AvRGSqlQJDm3MhT+Qin/1Zw8cn4OGz3oBb3FJbiF6wJDVIpmHP/59N/XKKj16lmL9Y2YScCVEmQCo3qh4dsD0R1B5uyPIPiUpnejfbz0i3JO0srvXlIoKS49UimKJY96ys/sZ0AuPZAUIqIrLL/QvaI3QtlobAHitLCg+8m1/MKN0ew5R9AKfnUNmDkhUqAOYKiPMN2v7iyMECElVAFKhCvj7F5Ti/VnSTcXM+0usRZtS7CRMbYxY3zFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgzWEXEOWMZxIFjFdLMif+XtxzCc8jgZ4Vd9fX4OTCo=;
 b=H0nu60MsM9iCdblYDxg2BgJ/jQVRuJOi12yqtXV/irNysCs///oJS6szpM4WKpU1LFAQ2Dkwj2lNjKj/HvWmOo2+5d7luL1tbSD8X0j6DlnQaCQujS5Qwrslu8WXF7GuMb5LisOO5tRr48O9pdYHhoak6xnLIN2A9Zd0tGg/vppJPtkAdDfZJO3j7PylBZRIIcrJ4Z1vFecO1dCA3PdF9Gxcg29yj0nOJFVWjhqVCDm+euCvXk/fATpIJ44bI12sWsWJE6iN38ulnzjEOhZQYbT9juN07fg4ekYpy2A/up65/bGWgeCTMao4pYam2cjUUIVYiRLhk24Q2ouMp8bx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgzWEXEOWMZxIFjFdLMif+XtxzCc8jgZ4Vd9fX4OTCo=;
 b=HbDqENS/Q0eDTtlONE5lY6tLXclrFCxB4SBtWNsyD6hQPLA2VOI/bxoG6lbSiCC4GjZ836d/SOcYcmvwxFeK3j7RGn4SNSaso7eZLDuuQwhmhfrzaC7/T6kI5gBl0qC751SvjvuGv/csmht8KQo5IzGRYeL4/YNyF3CtsTnXkoU=
Received: from CY5PR15CA0111.namprd15.prod.outlook.com (2603:10b6:930:7::25)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:14:28 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::98) by CY5PR15CA0111.outlook.office365.com
 (2603:10b6:930:7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 06:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:14:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:14:26 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 2/7] drm/amd/pm: Add smu feature interface functions
Date: Tue, 20 Jan 2026 11:42:19 +0530
Message-ID: <20260120061402.1287680-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120061402.1287680-1-lijo.lazar@amd.com>
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cab599-ebee-4258-8b85-08de57eb2b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GVAo3btsfqQojP3Sw5+Vro0aXjbP2jrcv9QIHGPyx0Wcjt0aeoVucT+cGx+h?=
 =?us-ascii?Q?oyRD7NYiFb9bCiuVmSPjqoMBlszVDZSlO37jV8yte7rd3SDIwmSugfUhcQeA?=
 =?us-ascii?Q?M3uLoq6m8II4bZHhkkXU7Z9U19uIX+GFpavuNAkoI7FQpRFkJaQ5xS2yZYTL?=
 =?us-ascii?Q?Qz+nacrmt7W1uFTh/Eq/Y3Sges67jK00knZSwnvU+h4vHUsvNpai8ImYnGh3?=
 =?us-ascii?Q?YuMBWBxM9qEravgoGndTdBsx/HXOfcauswlY2ISouVSRfoeKZGz9T97o0EJJ?=
 =?us-ascii?Q?XhK84CjeL7jV80gq9tbjHsO1RvgwDXc+68b4EkN8spzhtme4EmYX9syHWmB6?=
 =?us-ascii?Q?1WqWXU7Ko58IpomSzSSLfBm2W1NpjafsKMtoy/3dUmYjqFqEiJjk0P9IOAle?=
 =?us-ascii?Q?k0oyioEmRLQlZnaCOji5ZdcwJyVgKd9CXsxTNvRSJiB9VLI86yjz9VGgCYM0?=
 =?us-ascii?Q?eTTWVYY7O8+3ntGZpL2OFRhHlPpkAXJjWk2GXdaXlztSIP5S0ajnY4isvUUl?=
 =?us-ascii?Q?MTz19Is1mXM25DdCm5lzibrcDsLYBk0huzmv27rWfImvrrCmMeeECclY922K?=
 =?us-ascii?Q?YjYBf42AbSj+VDax7QGMqJlmREUOUfKKa7an4p0Gab1HwnXPI3pbXA6vjgob?=
 =?us-ascii?Q?IRp/2SG2QMHmntCUX8t9UUd/OiI0RZbXV4O1Kcm+FcStqx2B+UTZusI94w4g?=
 =?us-ascii?Q?pOsT8FYJ69plfLYaFmLXxOH8x2fIwU4GBiaL0Be9w5oDHquH89yZMYWn1HBD?=
 =?us-ascii?Q?WlgO+Y7GOkTKegVMjXpj0xQSqdBYVZWvjAox5fxmflCPZaUrywc/Q4Ul3Ygn?=
 =?us-ascii?Q?rOV2Pfcs0ot6E09mSuiPswqd1GHSpRJTHR89KrK22iqxzyKQWuQSekpG+343?=
 =?us-ascii?Q?ZhjW3YIi1gfZ1Zt0LbdAlqZezzP4Da/WgE2ycQfETrlW34mVHCdilNf4nDF1?=
 =?us-ascii?Q?t3OewE9Uz4i1gMI9FWuiO7Sn8qugHYo7rb/E9vsLiI54tB5ZpCAzNHq+5knw?=
 =?us-ascii?Q?AhvTU/6m0DIh2mL/RIVFKIzbnvQmOXsRyOVhWcVyCMQWovZsiIZY/RvSAR3C?=
 =?us-ascii?Q?khiCjXSsmdiquHj2pU2HmC3+MmGZvXEFUOSvDgdJ+PGnKs7Oukb9HjEKf+cv?=
 =?us-ascii?Q?SvrlA1MVCWAl8jTGv59nES6P2R+v29x8iY42EoUChDUvdfRRo3hh5UiT4z0j?=
 =?us-ascii?Q?BVoZwoOKmHKRlD5eh4h5xOx533bFUZy6cCJ14Z0cIIVuYfkqclydAZ4WCiKE?=
 =?us-ascii?Q?W19ZuwX1PVulbeUGPOYZp1dKHN8ofcRda5NOVV7+oSpSeJYKNkvyINz2Wf5I?=
 =?us-ascii?Q?Qx92thKrx/EUsRPiDbXizA933L1whTClT/kcWD5za8dVj7BI+imFj9hsSctc?=
 =?us-ascii?Q?Hy84ejiiDForAccQwx4DxHTmUQPIkV79ty4sPW+Xz8w2nQHjanE1Q/W2K91c?=
 =?us-ascii?Q?7MciQfNqvoaRHjdUVIq/fwsevELBOoZyF1icOTGB5y6sylaJzkBmDQhxi6fd?=
 =?us-ascii?Q?etV9z6BuXuIzF6YH6qsYqLDAVkJIiO9t61NJ/FsIcpqX4unfmRE96N48fhkG?=
 =?us-ascii?Q?laSvGF/r2pqwa5GGs+vvdMRGxYGrsPpXps5Hao4gxBYwlAyitUnNJQgivh7t?=
 =?us-ascii?Q?+gu39mJFnwmrEwjCCVZUk5A4wNsYJDKglmm8EMkTZ/tY843Bhl2t7fgHP4z1?=
 =?us-ascii?Q?ynJx8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:14:28.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cab599-ebee-4258-8b85-08de57eb2b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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

Instead of using bitmap operations, add wrapper interface functions to
operate on smu features.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  20 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 104 +++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   6 +-
 7 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6b6b05e8f736..ccb771dacde1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -690,7 +690,6 @@ static int smu_sys_set_pp_table(void *handle,
 
 static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
 	int ret = 0;
 
@@ -702,20 +701,19 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	 * such scenario.
 	 */
 	if (smu->adev->scpm_enabled) {
-		bitmap_fill(feature->allowed, SMU_FEATURE_MAX);
+		smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
 		return 0;
 	}
 
-	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
 	ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
 					     SMU_FEATURE_MAX/32);
 	if (ret)
 		return ret;
 
-	bitmap_or(feature->allowed, feature->allowed,
-		      (unsigned long *)allowed_feature_mask,
-		      feature->feature_num);
+	smu_feature_list_add_bits(smu, SMU_FEATURE_LIST_ALLOWED,
+				  (unsigned long *)allowed_feature_mask);
 
 	return ret;
 }
@@ -1365,9 +1363,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, ret;
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
-	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
-	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
-	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
+	smu_feature_init(smu, SMU_FEATURE_MAX);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
@@ -1656,7 +1652,6 @@ static void smu_wbrf_fini(struct smu_context *smu)
 
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	uint8_t pcie_gen = 0, pcie_width = 0;
 	uint64_t features_supported;
@@ -1819,9 +1814,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
 		return ret;
 	}
-	bitmap_copy(feature->supported,
-		    (unsigned long *)&features_supported,
-		    feature->feature_num);
+	smu_feature_list_set_bits(smu, SMU_FEATURE_LIST_SUPPORTED,
+				  (unsigned long *)&features_supported);
 
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 017df903a7bd..2290298579e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -477,10 +477,15 @@ struct smu_feature_bits {
 	DECLARE_BITMAP(bits, SMU_FEATURE_MAX);
 };
 
+enum smu_feature_list {
+	SMU_FEATURE_LIST_SUPPORTED,
+	SMU_FEATURE_LIST_ALLOWED,
+	SMU_FEATURE_LIST_MAX,
+};
+
 struct smu_feature {
 	uint32_t feature_num;
-	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
-	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
+	struct smu_feature_bits bits[SMU_FEATURE_LIST_MAX];
 };
 
 struct smu_clocks {
@@ -2055,4 +2060,99 @@ static inline void smu_feature_bits_or(struct smu_feature_bits *dst,
 	bitmap_or(dst->bits, src1->bits, src2, nbits);
 }
 
+static inline struct smu_feature_bits *
+__smu_feature_get_list(struct smu_context *smu, enum smu_feature_list list)
+{
+	if (unlikely(list >= SMU_FEATURE_LIST_MAX)) {
+		dev_warn(smu->adev->dev, "Invalid feature list: %d\n", list);
+		return &smu->smu_feature.bits[SMU_FEATURE_LIST_SUPPORTED];
+	}
+
+	return &smu->smu_feature.bits[list];
+}
+
+static inline bool smu_feature_list_is_set(struct smu_context *smu,
+					   enum smu_feature_list list,
+					   unsigned int bit)
+{
+	if (bit >= smu->smu_feature.feature_num)
+		return false;
+
+	return smu_feature_bits_is_set(__smu_feature_get_list(smu, list), bit);
+}
+
+static inline void smu_feature_list_set_bit(struct smu_context *smu,
+					    enum smu_feature_list list,
+					    unsigned int bit)
+{
+	if (bit >= smu->smu_feature.feature_num)
+		return;
+
+	smu_feature_bits_set_bit(__smu_feature_get_list(smu, list), bit);
+}
+
+static inline void smu_feature_list_clear_bit(struct smu_context *smu,
+					      enum smu_feature_list list,
+					      unsigned int bit)
+{
+	if (bit >= smu->smu_feature.feature_num)
+		return;
+
+	smu_feature_bits_clear_bit(__smu_feature_get_list(smu, list), bit);
+}
+
+static inline void smu_feature_list_set_all(struct smu_context *smu,
+					    enum smu_feature_list list)
+{
+	smu_feature_bits_fill(__smu_feature_get_list(smu, list));
+}
+
+static inline void smu_feature_list_clear_all(struct smu_context *smu,
+					      enum smu_feature_list list)
+{
+	smu_feature_bits_clearall(__smu_feature_get_list(smu, list));
+}
+
+static inline bool smu_feature_list_is_empty(struct smu_context *smu,
+					     enum smu_feature_list list)
+{
+	return smu_feature_bits_empty(__smu_feature_get_list(smu, list),
+				      smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_list_set_bits(struct smu_context *smu,
+					     enum smu_feature_list dst_list,
+					     const unsigned long *src)
+{
+	smu_feature_bits_copy(__smu_feature_get_list(smu, dst_list), src,
+			      smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_list_add_bits(struct smu_context *smu,
+					     enum smu_feature_list list,
+					     const unsigned long *src)
+{
+	struct smu_feature_bits *bits = __smu_feature_get_list(smu, list);
+
+	smu_feature_bits_or(bits, bits, src, smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_list_to_arr32(struct smu_context *smu,
+					     enum smu_feature_list list,
+					     uint32_t *arr)
+{
+	smu_feature_bits_to_arr32(__smu_feature_get_list(smu, list), arr,
+				  smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_init(struct smu_context *smu, int feature_num)
+{
+	if (!feature_num || smu->smu_feature.feature_num != 0)
+		return;
+
+	smu->smu_feature.feature_num = feature_num;
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_SUPPORTED);
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index eb1b9faf8e5c..1d0f9f8ddf9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -750,12 +750,13 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64) {
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
+	    feature->feature_num < 64) {
 		ret = -EINVAL;
 		goto failed;
 	}
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					  feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 51f96fdcec24..d9b1725c3afc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -761,11 +761,11 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
 	    feature->feature_num < 64)
 		return -EINVAL;
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					      feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f85ba23f9d99..5c991e2e15ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -746,11 +746,11 @@ int smu_v14_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
 	    feature->feature_num < 64)
 		return -EINVAL;
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					      feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 6557085a7c72..d77eaac556d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -715,11 +715,11 @@ int smu_v15_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
 	    feature->feature_num < 64)
 		return -EINVAL;
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					      feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 24835600c1cd..9bb7e3760c0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -677,7 +677,6 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 int smu_cmn_feature_is_supported(struct smu_context *smu,
 				 enum smu_feature_mask mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
@@ -686,9 +685,8 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 	if (feature_id < 0)
 		return 0;
 
-	WARN_ON(feature_id > feature->feature_num);
-
-	return test_bit(feature_id, feature->supported);
+	return smu_feature_list_is_set(smu, SMU_FEATURE_LIST_SUPPORTED,
+				       feature_id);
 }
 
 static int __smu_get_enabled_features(struct smu_context *smu,
-- 
2.49.0

