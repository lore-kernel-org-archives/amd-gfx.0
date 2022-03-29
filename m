Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FA3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 15:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE2810E8C9;
	Tue, 29 Mar 2022 15:10:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E8910E8C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 15:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvb4eoJS09B1Jj9jNngOyUe6Z+LYc1PKwVkU/skryvPdyuYonOer8xhtYHVzaVCbKNw/DxSR5KivKebdAHpy5+Gb0o7hOcMZ7l2WIO5954jitpKJCnnfegAt6uKUgPiUj14FJ6bK8NdKUUtgQmhB0kLkpQjGkEB3OBsgSbg6h5/ZRStQ3xBKug9vtTKlTuSQfLm9C30ereeZvknZf6L503ftZmEIgzfL7VhsXwp2lrG9pbnMza8C38MOin1ELCL/U6MWpAdf36EkHAhejxD6ZNx5HsDQodOtIMzzGfjGjkdpiqPvOkaHYjya3RVojXOsCMem3OqPycCSSseOKH/KYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to0hEVYKyuw97ijGdyC9RcDBMb45mryDNACoCwy+1Q4=;
 b=gDg8AAVG3wRlGjBL2ryOOjFJZreDPG37e29/BVNrAptTsbFW/lXY6smURs304R3Ax0kO5ZSuBsu89uBpQHU76EWKrCceiF3b7GrmKdxrEYd+30AsAUQBW/M6/MssF69CGdzZnAQoCY9OUX3Zf6AiBfS/l3Dr27HhsKGTlIY4KJS3LWLEZD47m0Epv7YtW/DbIb+9CSGmK7AX1gfoDylgldb21tl2DpHUf247rLz6NkHWjHnUD3QFDxuAbgMk3vZCW57fAv+z2lk6nnZfdt+EhQ0iiRBxlgqRiwKDMnD/9N2l/CYnr58S6mx6KhJXZUrY5H1ooDCDIpQMZTVzgihiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to0hEVYKyuw97ijGdyC9RcDBMb45mryDNACoCwy+1Q4=;
 b=iAFkbChU1OvYwoHvKucSj+lYTGPSrGTx5ClWfisWw3EQ6hcJX8EalOLs3C/Gg/UAzuqQ3hFNvbBbC7FaEHE44obZsDarWFYxGYQZ59LKANG8tYXOo7mAl0/WLQZqq4jC+nqrjb3nehxa26KneYbJxWyP/Keh7XHr6l17mgSt9oc=
Received: from BN8PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:70::19)
 by CH0PR12MB5202.namprd12.prod.outlook.com (2603:10b6:610:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 15:10:09 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::66) by BN8PR04CA0006.outlook.office365.com
 (2603:10b6:408:70::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Tue, 29 Mar 2022 15:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 15:10:08 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 10:10:07 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Add unique_id support for sienna cichlid
Date: Tue, 29 Mar 2022 11:09:51 -0400
Message-ID: <20220329150951.1311452-4-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329150951.1311452-1-kent.russell@amd.com>
References: <20220329150951.1311452-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18fec13b-3b94-4ff4-07bf-08da119636e3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5202:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5202488406BF1D00C143FE33851E9@CH0PR12MB5202.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmCWg+G817c+JmcpNyMGB70BRDIs7iVp7kDdzCW8cp9vCkV7ps0ppVspC5Di+pNQZjfoRHwzpI6VSD4X+m9prExzaVdp2USKhj1Zin9E/rPPpmCFiNIPjBunw+48/zc0hNCTHHQJsZaZr2AA6pC3HtjcRsrnif5VYDjoKNVwendBViE5MYYx9g/0d28iXSnUmkwZLsu2oNGn+hpHmLd3ZzuswRdgtmSc7q6WpwJ+EH8bXyDqGrl+gQ+db118b6KRjLghguBtphWvZcl4ztzOOO97RXi7YBrITmqDvi4KsroVOyeb1+687ZoTJh61fGBBZsISuWEKulZcSDxqVwTtNHm9IqvN3Pek6c2wvcqXAa+P57ZLn//TqzkkjLUNjUltWKkBGmagVzC7GgVtRa9MvpML3MnTgEuctFb+7y1rTreCXT7EZ/VI2e57eAd+hVEGYrRhfkAExwn5V+2eDcxRYMrqPQrb+Sqxe+kBuu01iQ9aer6SOoQjKzZWV/5yad8Ch3QHHNkUGzmqwFlYDCIiNWwxiezDsA+o6mOpbcbuTV3vxSG3oZ8I2gAi2vPl7Ui5sEnCtLMZCoLDe8ARcf4jZGcVwmq7gqS/LOXn2sdL8CetW+AzPHPXtL4P9MNRTfp0x3p0jCK5EizOAF59x1XZRkbN2DlAzURNNYRqEYlVOVR1dhcIXemyhXgjbQJnFW4khz8iW59EpBo1X0Ai14kJcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6916009)(8676002)(4326008)(70206006)(40460700003)(81166007)(356005)(36756003)(508600001)(86362001)(70586007)(316002)(5660300002)(83380400001)(36860700001)(186003)(47076005)(8936002)(44832011)(6666004)(2616005)(26005)(7696005)(1076003)(2906002)(82310400004)(16526019)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 15:10:08.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fec13b-3b94-4ff4-07bf-08da119636e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5202
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
v3: Fix style warning
v4: Add MP1 IP_VERSION check to FW version check

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 13 ++++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 33 +++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

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
index 3e4a314ef925..5831145646e6 100644
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
@@ -1535,6 +1541,9 @@ typedef struct {
   uint8_t  PcieWidth;
   uint16_t AverageGfxclkFrequencyTarget;
 
+  uint32_t PublicSerialNumLower32;
+  uint32_t PublicSerialNumUpper32;
+
 } SmuMetrics_V3_t;
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..b2f3d80e5945 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -715,6 +715,16 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 		*value = use_metrics_v3 ? metrics_v3->CurrFanSpeed :
 			use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
 		break;
+	case METRICS_UNIQUE_ID_UPPER32:
+		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumUpper32 :
+			use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
+			metrics->PublicSerialNumUpper32;
+		break;
+	case METRICS_UNIQUE_ID_LOWER32:
+		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 :
+			use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
+			metrics->PublicSerialNumLower32;
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1773,6 +1783,28 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static void sienna_cichlid_get_unique_id(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t upper32 = 0, lower32 = 0;
+
+	/* Only supported as of version 0.58.83.0 and only on Sienna Cichlid */
+	if (smu->smc_fw_version < 0x3A5300 ||
+	    smu->adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7))
+		return;
+
+	if (sienna_cichlid_get_smu_metrics_data(smu, METRICS_UNIQUE_ID_UPPER32, &upper32))
+		goto out;
+	if (sienna_cichlid_get_smu_metrics_data(smu, METRICS_UNIQUE_ID_LOWER32, &lower32))
+		goto out;
+
+out:
+
+	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
+	if (adev->serial[0] == '\0')
+		sprintf(adev->serial, "%016llx", adev->unique_id);
+}
+
 static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states)
 {
 	uint32_t num_discrete_levels = 0;
@@ -4182,6 +4214,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_ecc_info = sienna_cichlid_get_ecc_info,
 	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
 	.set_config_table = sienna_cichlid_set_config_table,
+	.get_unique_id = sienna_cichlid_get_unique_id,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

