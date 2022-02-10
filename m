Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F110FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 15:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2C910E893;
	Thu, 10 Feb 2022 15:43:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2737910E893
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 15:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4oH0MiTT2YRxVJiF4mjF1QxnBIRKC3Iv5WplpUqLWxU5I/BnqHv4/LqTy5JfO4KNif7K6w34cRMf340jxAsaaMdmmr14AuJEL5Jtv4QVUl6WDZWhsRblLvrOfadaUFAj/qWD2u6EqS6LeVpcDlhEv56IZFHC/jXYKnhEJ+a+Y6Z6ZfErUgRNZee5zG0qQMjeFc3t5PmILvl7nBrXE5XJ1U92akNsnNwzvvzvF0YFSJWLhDHa8EHy8TZqYOZrJDXJiJSP79wZMoWl7Ta+mfAoBudee95u7W8MlGMN05v1pK9jQHNlqYrNKscKDrx/fra+lYnXT3uXCchnDNQLMLcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8Ri0BtsgiR8gCf2dC6RcOkPrCfVCk7aAc/dAt/8LUw=;
 b=C4Sv8gwEVh5Y5QLIKiBxNzFtHKQfcAP0NmAUPvEL/08XcsBk0xPNcl8BM9OGqVfOuVxAQjKJ7qw2LN8buIen3UbAKRfLoz1XpQgoHect+OMaijbHgbCX8qeuOTIKIF5uspy4VsByIo6xAfQRc9atUvXT1G44cxdV8rbBpghIZK7qWE4yjoyd6qgWDISc5NkXUmAFWYj5VbCOYcV8acGJ6b5dumN4UiyDR9bR886nRDqD5WnR7QG9Wij6OKsRM1BVWk3RK3HBtuOD+TE/YHu122zzqAPVaK/yHNxdHQ1EQTvh9mGZ3HiWKm1spC7u8jzR8bzeAxQmrd3jkxD8ZdhQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8Ri0BtsgiR8gCf2dC6RcOkPrCfVCk7aAc/dAt/8LUw=;
 b=lk6bHUET89xvpruFac6/GnFQPMItj1gYLYb7E5zj1fgPjcFl5HrxMxWEmkC+S+luEXM3NgHADf5oliB8XE3iSlxm4cLewUCl/o61iUuk5j82hXNiNjNS2sSmSbPVm9oL9fInQHRrm8QV2/P9QYpLFcU3lAn6sS11tNYhoFope2E=
Received: from DM5PR07CA0162.namprd07.prod.outlook.com (2603:10b6:3:ee::28) by
 CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Thu, 10 Feb 2022 15:43:00 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::a6) by DM5PR07CA0162.outlook.office365.com
 (2603:10b6:3:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 15:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 15:42:59 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 09:42:57 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
Date: Thu, 10 Feb 2022 10:42:47 -0500
Message-ID: <20220210154247.742942-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c734e7b5-18cb-47d9-17db-08d9ecac0456
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB53938554E3ABC98EC974718F852F9@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9o+/MjeMAfEN/K1tytcSkAwU7lYg6dFQ0lCDPbhpuJqXBCO5+lFDVyC6cgiJpZA0i0vp2tAfcKgWBT9fB/ni6I70xq7ExOh935T76UFuKS3ureHdFQ38zTYUa9aXh9bWxTlYZp5X20ZcRNDIVju6Kfddt+MdTHR6s2723UrON4mrKscepTJo7qZkWOyAkvZa6iA6org0PqjB1GS70PoMM94augKxDDS2iLyg/c2dz+xt+6xGmERkeadtE8akYj5NV/ObrHsfUZ+RxsMHqGgdaHB0sKcA2yywuNITBd2FfJ0QN6BSfdw/NBzYPRmo46VncoaLE2Hd7Acwv/2KSvPohCFqStrcm7Kx6Vm7GRi6cA3wMdHs9esL/PGZBJ0WS063+CRVDhXMakU0gITV+C96ae4J+jhf9tKO8nWOiz9GnAmscUMmahu+/no3B7ma1tx37+ELBD34WAIUbq66GafvqnloJ0IH/y3peVZKh4MVWPLsZ/DAP9vJy/9i+SbgYXAi3Tz0n8cHePTZqhoT7Js4BmX0KM4lJZnoZ9D4g/s7hzo7QJN+IRnClyExl+UIcmdqftsiWXEKv3uHN0APDQPjS12xbeOxVvzs/q64CGlX65uGdijdgEeZUQpGZBb47+/phoQ08r4LVovrc3/QESIWsjrWxv+psnqpPwYZ1aDJOnCbulC06cm+m7HSIPISYeosd9gTu9Zc9H5YiyABkWP+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(36860700001)(2906002)(1076003)(426003)(16526019)(26005)(186003)(5660300002)(44832011)(2616005)(316002)(356005)(508600001)(81166007)(6916009)(83380400001)(8676002)(70206006)(8936002)(82310400004)(70586007)(36756003)(6666004)(40460700003)(47076005)(7696005)(4326008)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 15:42:59.9823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c734e7b5-18cb-47d9-17db-08d9ecac0456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 33 +++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ad5da252228b..f638bcfc3faa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1969,7 +1969,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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

