Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE37CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 15:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F1B10E87B;
	Thu, 10 Feb 2022 15:16:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7ED10E87B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 15:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmVTQ0wynsO/kFFdB/pqpnkYckupDUUhjippZiZ/32bcZJcDVvh14m7XrDWS5F88LX8jGqnyJzS2cg5FSMIzpWtRD2l3DwHsLEVjz1jcCLzGnDe4MA+3uUhJY+aGk2Bi+nBsDskk+Jj8ivmMYu9jcQtqZnPx7sAECo9WFIhACMv3+2LF7WeVuoniiG8QtGH8fEUCYVQtO5g7gazrqHUrBNZM3EXBSSqRJDmHJwOcL3AMlxs3ldsxbXTQ30Lxr5Itxhks7JC944lLJBOFo4cSOvmfZuPMOCr+xvCVOaRUureEhKczHAio27+4Cj8af0A4V1rWOzUobTMGYh6ZW91gFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DFo4izUyig1E2T6YrhrXAlR4g1u2LY6YHHyxQib57g=;
 b=DXyeupE+em8m6kVfHr449TnUJT6kevfZMv7RCjQM8WrIKs4Gb43Ps7AgEARaK7ImDGJ6n8gxnB1x0HRUwy9xjaZaz8sEGTlstcTl/PXZtqY4xLI/xr8bFGB9IA2pJyH3JQOFlW0S5DXRROWos5hrB+xheaNHi3tET07jpqlDpOnRWR62QYJ1WKd5tQSBA9S5NjsJlsVMLJ/JJAuGa3iGRlF47zRc62Cpg+gxKCTo3HSeayAa5HrjihmwnU+2HMKFFlUulBjEBAG4L3eVDTesGFWiaJXa4cKKoDdwhQLhOBPkGGp8FiLp5sOhZtrWhcuZTkc0O22Z3WhYLeV2KhOxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DFo4izUyig1E2T6YrhrXAlR4g1u2LY6YHHyxQib57g=;
 b=vcIkIb1JvdZiE5DCbgjBHhpM45xtjM6tBDPs0MRlQDM7Y0kKKHp1QQAe7KCStdIIlufElJ3o8q9HlP9lz3F9w9HBG5HxmCQNt6+7uS0cpsTn19XdV2hsYZG80gEth20TgY2OurNyfZoqxJov9ExSbtCMD/kWAQhTx2nf8D3wV4c=
Received: from BN6PR13CA0063.namprd13.prod.outlook.com (2603:10b6:404:11::25)
 by MN2PR12MB2976.namprd12.prod.outlook.com (2603:10b6:208:c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 15:15:56 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::42) by BN6PR13CA0063.outlook.office365.com
 (2603:10b6:404:11::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Thu, 10 Feb 2022 15:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 15:15:56 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 09:15:56 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
Date: Thu, 10 Feb 2022 10:15:43 -0500
Message-ID: <20220210151543.742701-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11373345-4845-4231-f0d0-08d9eca83cc0
X-MS-TrafficTypeDiagnostic: MN2PR12MB2976:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2976DD22605343C5BCA2E205852F9@MN2PR12MB2976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEr4uhYTVI69shp7gci7F82XVaVMRmeEoJ+q2WGQWDL5JKHw858t3yLdXrGhNqveEeRFAdjbL5aAewCggLniqYxFNj57IYnUE/31+3OYlRy758M5M3rLX4Gq4MgIzpb5DuhTKuYEjw3/vY4GfR3Q0gSU/ZUK1IcWRoPGAt2xHmgZyz9XkzoAIicDLN/TCNByOmOahsapd8bvzvrJi946oYzgiXz4BJYaSKGwZHB9iewy3/e0LAamIbYb14d1im3bBjzBRDUFhmHukQNLdehtvSG0rVNZie3DKcIJk0ty/V64SJNlYetxArINc0D3QyUyLOHuS+7ipfZq1sQfR3JO7He8WbXjyhivbVdSu/HeE5zKQvJiOdfuuF5tA4qjKLuW3erFaMkxhwQmk8yXSRF7z9yzXvQr2hQKwTDBkwoSfTkb45tAoYRMoiGP8dZkF4F3sphze6rlXUIVJR39KNC8tHUOlWMLijaF3xnPG31Jo241DmX+/Bl3aTbHuEmX42iXhGFc4hUHp0KN2y/nj55fd4FOsNJo8onklMMN5j8DKJSmkLAlGNU2DuWn9IyWqmE4YIBv/X6RND+GsM7j6QcEYns+n3q4JKgYzwaqraD7n10126KLEgpJcF2JvRL7RkR9tYFwsiW3Dri47o+ctW5Aam8cr+gYJRhfrfP4X1Y+YXiGDYoLKK1lHHpzjtkmqwku/8ZkERCG1TwfJQRJklFmcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(82310400004)(8676002)(86362001)(36860700001)(70586007)(47076005)(8936002)(4326008)(1076003)(186003)(5660300002)(336012)(426003)(26005)(16526019)(36756003)(2616005)(44832011)(2906002)(70206006)(83380400001)(316002)(6916009)(508600001)(81166007)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 15:15:56.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11373345-4845-4231-f0d0-08d9eca83cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2976
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
kernel

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 33 +++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index b253be602cc2..c09dec2c4e1e 100644
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
index 2a7da2bad96a..048014f05b35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -451,6 +451,38 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
 	return ret;
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
+	mutex_lock(&smu->metrics_lock);
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
+	mutex_unlock(&smu->metrics_lock);
+
+	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
+	if (adev->serial[0] == '\0')
+		sprintf(adev->serial, "%016llx", adev->unique_id);
+}
+
 static int sienna_cichlid_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -4012,6 +4044,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_mp1_state = sienna_cichlid_set_mp1_state,
 	.stb_collect_info = sienna_cichlid_stb_get_data_direct,
 	.get_ecc_info = sienna_cichlid_get_ecc_info,
+	.get_unique_id = sienna_cichlid_get_unique_id,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

