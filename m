Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D935CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 16:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599C210E718;
	Mon, 28 Mar 2022 16:53:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0D610E6E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 16:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuIn9WwhmxK1125rqGcn3NJ4neVqE0A6LbNAjXgcJ97fM5AJYOw/oqin2s3u5HFjPHHkJ4cMJdxOxyiCIawoYw/g6niEAoLbPyxngQYcYViBUKPkOluqWEh5uUoY9vVGUCV7du14I6pTXbh8Gdo1uHvg0T+smaumQsKMFy1GZUpGUfAgCwhmvYMHzFhtGfH9NdMfjZJ1tpeSIeIyq6dklOgFlMHrGisnhWd/Pe4JOIQecKJ+hOSLhkCMfaUNchbZCmBtOHU8/AHCkJotKyBr3lYfPEBv89i+VYLUUqkSYFxeqDohN/m0Z3Y3sOSBoBuWJx80SzxbPB6YGOPQQ58LTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MacVYPWVpdZGApeetylbf5+pVuW6MVt3D6MrUuT8Flw=;
 b=JB0b8lLsJea5smkfqe1RpuVg/wYHAMk09B7NN+DPoBuJRiNpbBPCjnNIqFUR4Fmh/Geo2a0YoOckyFBCNBZYAfH7gE96Upr11/KOUVMTZu3DVpeG9JFx+kRD12+1kky3FCQ9S72xeSrFQrrZPAERFx4wSpr5xPnGyrrZ0a2nijoS+anoANi337kQFN6BeegF5c+wxEn+sugWPhOv91gQGlhUfO+NM6BtzNmatBa9UfY0g3cWn0oqAw6Gf65J27aZfgHp38SfnSHmpLWFlDKK1irxCsehqsiwQmsHSvjhtrQLX28aw6ZgM1W7t825J85cW/6wdQ86c+cy5nY28iKryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MacVYPWVpdZGApeetylbf5+pVuW6MVt3D6MrUuT8Flw=;
 b=nccqSfsk+dD4cf7qLR9jihW5BJ9F20pYuayN8S1cD3LRq6JhUiFVaCRK+SlBT/0J8yc5kmI7DTJ1HmM2OwErWsRxOQKntqLUgi2vlETZV2Tkqa5ZLNVFpuuGlKTm957hA1rPMBImTdx/wy2BUy8tNUdDSGb9FEEXBrWsGOvrONI=
Received: from DM5PR19CA0042.namprd19.prod.outlook.com (2603:10b6:3:9a::28) by
 DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Mon, 28 Mar 2022 16:53:51 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::68) by DM5PR19CA0042.outlook.office365.com
 (2603:10b6:3:9a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 16:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 16:53:50 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 11:53:50 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Date: Mon, 28 Mar 2022 12:53:40 -0400
Message-ID: <20220328165340.1262277-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328165340.1262277-1-kent.russell@amd.com>
References: <20220328165340.1262277-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ae0c828-21c9-412d-2200-08da10db8901
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487F41F7724223B7D7638B0851D9@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TDhHc1hI7tAIhIIEeXXDjuROFQq3mW6g7mc+M2HN0QbUKD0/Y7JXR+4+3Zh8bepmLTbMYM4M0z3CMvL5DdLonsDBtQy1GNVun7ZF/lEUDYUhPpdN3nxJExPbIQ0njYbu6fnDm9tUjzUCqAizncR1fkUAYFTopV1AJdcPfgg/6GO9WtILuESIk6kwH49L5Jp8AyXkVRJzJPPE8xighpP0owCCySIw5SBfu1d4RVWyzrdv7AvHL9oXXVWXsacI5LFOHbWIMNLYlTA+Hmgif/ORpKOKxiMYeQQCQkVfZDonGan2pCz9S5J/xXGZL0+vS5gpD+zsIVgpPFNKNdGsqCZrHtlGPRNfh6P0aPP0AZJBnOJumAvxkfjGbUOQkNhRFbZePdqYRMZn2kY1gITkXobnGhTI2y2vGiTy+cV/VvXJ+8DkbB0EesHRpcejzUKps+Awk56abU0uW6bM535ofuCttwBkjqJmUGLynxZL+cPjCxByJa59vcWwfBAO0OpvFr8hDrkyPHl2JwgpU02d08n/+FeyO5yvAcd/QuIg8qImZxNtt6f5+B0R5ykihKtIgV+hzl2MbRsZousTe6uNbKT0rs1Bt3ErFSw8lJALHN4MK09cezTcH8xAS+nlrTIF062LGBaE/5zltoSpMi9I07OrMHlv+skfrW2oC344/iF/PwGfw1yzkRRQ2I19e3zEHChAdqg8eKAglZAj5owjgTT6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(40460700003)(26005)(186003)(426003)(336012)(1076003)(47076005)(44832011)(54906003)(8936002)(16526019)(81166007)(356005)(70586007)(8676002)(316002)(6916009)(36860700001)(70206006)(2616005)(86362001)(4326008)(2906002)(5660300002)(7696005)(82310400004)(6666004)(36756003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:53:50.7062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae0c828-21c9-412d-2200-08da10db8901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is being added to SMU Metrics, so add the required tie-ins in the
kernel. Also create the corresponding unique_id sysfs file.

v2: Add FW version check, remove SMU mutex
v3: Fix style warning
v4: Add IP_VERSION check to FW version check

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 10 ++++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 37 +++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4151db2678fb..4a9aabc16fbc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(9, 4, 0):
 		case IP_VERSION(9, 4, 1):
 		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(10, 3, 0):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index 3e4a314ef925..037f38b0fa15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
@@ -1419,8 +1419,11 @@ typedef struct {
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
-  uint16_t Padding16_2;
 
+  uint32_t PublicSerialNumLower32;
+  uint32_t PublicSerialNumUpper32;
+
+  uint16_t Padding16_2;
 } SmuMetrics_t;
 
 typedef struct {
@@ -1476,8 +1479,11 @@ typedef struct {
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
-  uint16_t Padding16_2;
 
+  uint32_t PublicSerialNumLower32;
+  uint32_t PublicSerialNumUpper32;
+
+  uint16_t Padding16_2;
 } SmuMetrics_V2_t;
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..9f0c353f9b42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -481,6 +481,42 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
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
+	bool use_metrics_v2;
+	int ret;
+
+	/* Only supported as of version 0.58.83.0 and only on GC 10.3.0 */
+	if (smu->smc_fw_version < 0x3A5300 ||
+	    smu->adev->ip_versions[GC_HWIP][0] != IP_VERSION(10, 3, 0))
+		return;
+
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	if (ret)
+		goto out_unlock;
+
+	use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
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
@@ -4182,6 +4218,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_ecc_info = sienna_cichlid_get_ecc_info,
 	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
 	.set_config_table = sienna_cichlid_set_config_table,
+	.get_unique_id = sienna_cichlid_get_unique_id,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

