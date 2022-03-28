Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2197C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D7110E104;
	Mon, 28 Mar 2022 13:07:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEF110E104
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y57PbAeBb3rqFjkNadyPrJaiogW6wS6n3O3HeUSfWRUAZwqpQ9xT0SPkSKE+DfefdbVfmlVURei4b/x67RSf6X/azsK9T4kf4n6c50CW8WsxCAm1UyYm/J1jLpL2N2I3SssXBqEV7q/Mypn5JgkhKX+HWDisllfGRM/9KgirL+4i1X5SsTCg4uiKe5iZQCITveV9rBSk3gaS92DedQKV9GQW7X+h/fU5kUjokkUntnfZIMVYUEMdGDGQ8dSMD21a3vP7GvBobMX+YwAg6NHnYUyXc1th0CKp7BAE4oIkTf9E2r7f/i+F0a8Jdj6lH6So/SCUbIuIol+l323Dq3uT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLO0PITZsp+4apsCtNi6ObHraltItgW2VASQyrpVUUo=;
 b=g9fWHx+/t8XntEvcr8tZhOnRYRVTAB3zzvAk78JZlTaD0GnTElDv6iF+LGBVTJKyD9GmS5+/31l3sJifcUwFXmts8oykrn7iPGf/3Asq9Kjh5JECs+fW/dULbp3woRd2M2WoZQ+rx3z7/sqXRSEMJIbnajw7utuVT2QwVgkqmLYT9FCdnyJTM7vNCf99NjUVrY8qK1yROUijgLdaxyl5eDg74CtKwPsmgIpzAILv4NSHXIlm4JvYkOmd1r9G61l61cT5/uTCJ9bdyxpJYR+SviqYhIUg2w3Fs/JONAYa0EiMIt7gODAd9D09ZZ4/XVWT+IwcUNNYYFxXe8J7RuJRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLO0PITZsp+4apsCtNi6ObHraltItgW2VASQyrpVUUo=;
 b=O61T26CQwxqEsplxCyRVteuYKzNzvu9nDJbm96Qq7a/l3R12ThCxVYlDLnTfFGU00w+eQiq3fx2AGZNRH2oV89jo7R401Iz4B8Giryc1eyYYfzIKxqj11kfAC26RIwUf61VF6ZbkvnbAtgFQqS4Gn86mBKZO7e6qCg5e4ihV25g=
Received: from BN9PR03CA0671.namprd03.prod.outlook.com (2603:10b6:408:10e::16)
 by CY4PR12MB1701.namprd12.prod.outlook.com (2603:10b6:903:121::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 13:07:05 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::ab) by BN9PR03CA0671.outlook.office365.com
 (2603:10b6:408:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 13:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 13:07:05 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 08:07:04 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Date: Mon, 28 Mar 2022 09:06:46 -0400
Message-ID: <20220328130646.1226563-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328130646.1226563-1-kent.russell@amd.com>
References: <20220328130646.1226563-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 772ecb24-e710-49b6-37f7-08da10bbdb6e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1701:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB170198B68864DD9A292605A6851D9@CY4PR12MB1701.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmzxhOX+YfUNM82vAyqzYxvXtVOPqh+bi0i52HTqfTxEhnnA1hCkIxoYDrVpyfItgAfO0VblDTeKny8v/wbQIiUWVNwuDL7OLUKXp+YdtOqg3UFnG0OBGC+ivSdXlh/pz3x+gbx54HDJXVvaXNej4Lesy1MmWV9VEi02u6gv1xv4ZRRFjN5g6PoJ4S8KAcadrGEGUr42nWzla8xkFJhK35Q4Rx0wQTZjfbbvAB+RFx3jP/Zevtuadr2DYD31JEqqkZa9NFeejYFQ98Sy1cfq6oPDkXGOjTRCZ/HOttt9nWrDM94/MEoRZfQjBkfCWX9Tw7xGINRelOArDNDtswC/EqpmFoL3X6ZTQRowUhH3rFHCDsAdmyISR8lN4youerLKTbq+sAmaD86OcYNxVQ6eaKidROjjKfy28Fo8uHKLNRuywLEzX7GxaM5RxubhHh+Ko8kGOhaXkgiHoBzLSBgei3lWlkJ3nlL7PKmPMyi8Vyn/dI+l/cJ/XKTzChtJ/g87eVfNof4FHOJZitbZRO9qDyjj8vj33C7eh1bZFX51zmwSL55D881n/RJ+NGuo6/IBLmAEYaRbyefjqQaAdUCCG7/Yus3Z8RkPhNyvrEg3xHXLUUg5YzfPo1G6hpJ+hNma4rgsbnMIa4LeLUlqUaJbVOMIWztqna0rGJq+HYgrScqEtPKngjUYqQF/RzH/HTn/5kiFJkKDKALxoexd7GohwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(4326008)(81166007)(70586007)(316002)(8676002)(70206006)(36756003)(6916009)(5660300002)(36860700001)(26005)(82310400004)(186003)(83380400001)(8936002)(508600001)(16526019)(1076003)(47076005)(2906002)(426003)(44832011)(2616005)(86362001)(6666004)(336012)(7696005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:07:05.1927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772ecb24-e710-49b6-37f7-08da10bbdb6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1701
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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 35 +++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a5216c0f5c2b..62b73ca0aa74 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1992,6 +1992,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(9, 4, 0):
 		case IP_VERSION(9, 4, 1):
 		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(10, 3, 0):
 			*states = ATTR_STATE_SUPPORTED;
 		default:
 			*states = ATTR_STATE_UNSUPPORTED;
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
index 38f04836c82f..1016d8646e1e 100644
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
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
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

