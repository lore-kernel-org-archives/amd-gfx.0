Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B1CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 13:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8ED10E6FE;
	Fri, 25 Mar 2022 13:05:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37DA10E5F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 13:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr1x6hW2MWwRCrp4Df+0RgciCQPBzDAM7zlFK1Dgg1GgrIETPVplulLp+1YvZVDT7cAFqND1kkzqNJvqnoCp/1QyM0wbsbmycMbPNWN42vEPrQ2f3G6hxoyGMAWCOc/tI+PejFItpVDNLhyFYpt85gOqZCThsGByolDbCZ6pnXb9jlfDEvw9N0wxkarZQulJNVL7dzzaiIdYP1pDoHPchyl3zzHqWtz5J1J9fhQ3TDSWB8M99+MvHhR2gy96ji8Ug+wosY7ruWIClfP2NSY65t43LqMrOF/OWMYffG/ylQN7Tmy3cjI5bTbz2yXHavWYyjSZBfWQvovAU1yJlK0NvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSfiRRtq0OQrmC2xLajk/ST3PJ7lDCwCjVntWXI4uPI=;
 b=C3Vjjy9JpsYjUqpNEQz41rJxNB/xXvnGPV7t0LvGOlC+EImAJDnV83/2iDmBFfiSwPRIAUA3euGccaJJ5fpJQbFNo9QIVTtHsJ+Ta7bEPDm7BFdpaSp85w/Lz0gNTI22fVyLhacefimqb82r3YK2TS9c1i87Ds4/4GgcLakqStIk3ymc84mh8QI95KiMNh2XBT+2SRS2Vz4JQ7Dg+0xGadVHZ9FfjQycyTQCr+++rm5b8CpiP2DigF0qxNg8Jd5L8X9YbAlvU9dT9LsflAuGTWDF3XVFyGKwih6qnCPEvrtu0mmPzJM7w/j+i5NV37IfwlBz3m4OSWWQjwnQgDUh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSfiRRtq0OQrmC2xLajk/ST3PJ7lDCwCjVntWXI4uPI=;
 b=mAXVKpmh0+la81vtiaQw0UytfMq7xcjFrR7HFhHYvsjYO7WTcvRI7AjOhbzJB7oH+XZiXf8mAz4VghILcJpYZwWmMossxC/Wx4xddeWLosz3xIL9bC0FjtkeJ5gfKDsyIpYpKrlhzdEPUUkTx1eTjGrUO6ys7nL1ooglM8hJ6MY=
Received: from BN0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:408:142::7)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 13:05:25 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::da) by BN0PR08CA0022.outlook.office365.com
 (2603:10b6:408:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Fri, 25 Mar 2022 13:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 13:05:25 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 08:05:20 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
Date: Fri, 25 Mar 2022 09:05:10 -0400
Message-ID: <20220325130510.1122010-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb80dea3-2600-4c8e-227b-08da0e6020cb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5876:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5876D8CED026442661CA6C4B851A9@BL1PR12MB5876.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SC7xa3yyBz8wGRIJQbfMkVzF+uCaDx8InKquJ1XgnG8l8XFLipZPMSwPRKCVPTyVIbyxgYsjKalsUKV7p+6hTvRWeDQitlkGF5o31k1UrJrmDSnoxgdUxMg99GnDEcrKFTfJNtDdbinZG340Pur2tHhDJ1gkOlX4YxhqF4qdYa88C2DWYtg6QsTyy9sSrShRk/L0ecbbA3YbW6Xw45FsTMk+jdyw4Z5PggSVel71WbA0T9vxrsdqUE2EvpS0SA4Xs347RaWl3XD+qSGktQlcT8QcqZaSP9XPNtHq2owjh9tD//siIk7SJ9ljDV0rIn3d+QKMerBkbhoaWJiEHptlpRiAqECr+nBC6ThDbiBZKAroa4y4K1ymnOHH77lBSNm0qnJbyayIpg972gfWBw2/bA/4F78V4xwDN0Xy23yInn9cNkJYpZg1zQ/e1wkTCfrBXYoyzBCC94EJsrW5MQeFu2+kRggqS98vHRWYC26541ikXk4nGEKG5vHmR6HBPLYBcm96E6Tqva9VPTR4e9OcR42IKXswcsylmISJ6om291+5CROvk94JUFQWGzNzXV6ajeWw26Eh+BtHXvSTeJlG8nGxOS/cvxeelsRC+y2n/TjVafYOqHrNtKYIugh14hUUkrppd5cU0WLMLSe75QjAPywfoyu5yRp6ktFR3vvYNOOEvKj2NJcfgvNi0l/GIETwLjlzMtcNTPuZ3h39QNOVkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(336012)(1076003)(2616005)(186003)(16526019)(316002)(83380400001)(426003)(47076005)(82310400004)(36860700001)(7696005)(44832011)(40460700003)(2906002)(8936002)(5660300002)(6666004)(6916009)(508600001)(70206006)(70586007)(4326008)(8676002)(356005)(81166007)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 13:05:25.5398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb80dea3-2600-4c8e-227b-08da0e6020cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is being added to SMU Metrics, so add the required tie-ins in the
kernel. Also create the corresponding unique_id sysfs file.

v2: Add FW version check, remove SMU mutex

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 35 +++++++++++++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5cd67ddf8495..1ed13bf77cbc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1990,7 +1990,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (asic_type != CHIP_VEGA10 &&
 		    asic_type != CHIP_VEGA20 &&
 		    asic_type != CHIP_ARCTURUS &&
-		    asic_type != CHIP_ALDEBARAN)
+		    asic_type != CHIP_ALDEBARAN &&
+		    asic_type != CHIP_SIENNA_CICHLID)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index 3e4a314ef925..58f977320d06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
@@ -1419,8 +1419,12 @@ typedef struct {
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
-  uint16_t Padding16_2;
 
+  //PMFW-8711
+  uint32_t PublicSerialNumLower32;
+  uint32_t PublicSerialNumUpper32;
+
+  uint16_t Padding16_2;
 } SmuMetrics_t;
 
 typedef struct {
@@ -1476,8 +1480,12 @@ typedef struct {
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
-  uint16_t Padding16_2;
 
+  //PMFW-8711
+  uint32_t PublicSerialNumLower32;
+  uint32_t PublicSerialNumUpper32;
+
+  uint16_t Padding16_2;
 } SmuMetrics_V2_t;
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..39d12bc6daaa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -481,6 +481,40 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
 	return sienna_cichlid_patch_pptable_quirk(smu);
 }
 
+static void sienna_cichlid_get_unique_id(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	SmuMetrics_t *metrics =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
+	SmuMetrics_V2_t *metrics_v2 =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
+	uint32_t upper32 = 0, lower32 = 0;
+	int ret;
+
+	/* Only supported as of version 0.58.83.0 */
+	if (smu->smc_fw_version < 0x3A5300)
+		return;
+
+	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
+	if (ret)
+		goto out_unlock;
+
+	bool use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
+		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
+
+	upper32 = use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
+				   metrics->PublicSerialNumUpper32;
+	lower32 = use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
+				   metrics->PublicSerialNumLower32;
+
+out_unlock:
+
+	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
+	if (adev->serial[0] == '\0')
+		sprintf(adev->serial, "%016llx", adev->unique_id);
+}
+
 static int sienna_cichlid_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -4182,6 +4216,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_ecc_info = sienna_cichlid_get_ecc_info,
 	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
 	.set_config_table = sienna_cichlid_set_config_table,
+	.get_unique_id = sienna_cichlid_get_unique_id,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

