Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB9DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 07:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D49310EA9D;
	Fri, 18 Feb 2022 07:07:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2028E10EA9D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 07:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyJ3lvNzrDOhblZKiZFsM9ZcZAz9EHhGNCs4XIC+yq4GUFLXgXeUVoE7t8QygsOpSp/iWs6viD+TVuzZFODExnzZqQqrVwCnZtj37t2AKAgZbc/kR2hBrozIr1x/2/SC+DisOW1525XKnlzHb2wOsrpvH0PDfS+v//40kg+xWW0bBLvfbF1bMM+juwR/ycb6OORFqBqOiClCrKm7jj6YKQOVecUaNaccCXOUXltGsqANLSKcuHpwVfncbKXPxhaZtHQeOj6/wr6iFh5aRUaBNlRqsaCwrHIGlQJJWWMzLcDjF0t76LWUri20X1cd9jcOIS2kOv8Ijgee11YDxKm2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BSr7N34dtFjfrLUyDcxh5TT3ZsWDtyxH4PYbi4wmWw=;
 b=oGXGswXy0/3peW4Jn6Q7kXWd9Z7wY+0dWlUeEFgcSrbqh3fCU4k7DIQxKHaNH/5PqTIUvg/+NNIM/CiaxyojmXQCSZaFoFKz/tTzCqepGnyJHy2cWEES36TWH44eWy8cAvXi0FtgHqUdz1yvcoXTnaDclZgwVBhTE3PQdkQn8CuN32md+HBWuF5NuZ6/An/sOl4/ne4byHdTMhVppLBKDdoaWR0EMVUHII0E/FKRkTR/hNl04IcDEnZniY1LBzpu4EJSabU0KTIS8zhjJQDhpresAbd99eVOYYMSmx48+5XU9KOHwZkkOZIpLzGPXpXO02vnGzAzCD6PqRWHgcyrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BSr7N34dtFjfrLUyDcxh5TT3ZsWDtyxH4PYbi4wmWw=;
 b=dx83xe19+uWxNTJrb4yrAav17qTBpOwQbcvqwmbDR+HzPmXOCAbiPCkUNXA+8fGdk7RPWVEUKUJ3Eh2WOV7jiPqgPdNU0vIrR8ldxHsZZ+Och3yQRYtjRj8X8/9pVABll3Ei4FbQgYr1l07AVhZJYO772q478EXMpT/o/pkeKIY=
Received: from MWHPR20CA0024.namprd20.prod.outlook.com (2603:10b6:300:13d::34)
 by CH0PR12MB5204.namprd12.prod.outlook.com (2603:10b6:610:bb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 07:07:12 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::75) by MWHPR20CA0024.outlook.office365.com
 (2603:10b6:300:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Fri, 18 Feb 2022 07:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 18 Feb 2022 07:07:12 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 01:07:08 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Date: Fri, 18 Feb 2022 15:04:49 +0800
Message-ID: <1645167889-18759-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed8cb982-b2e8-49ef-002b-08d9f2ad4954
X-MS-TrafficTypeDiagnostic: CH0PR12MB5204:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5204C6C5088CC3858042901EFB379@CH0PR12MB5204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZCFgCekVP8PhnHDc1BiE7xXvhU1Y5JF3xM2BXHWt9EPpUNMM49WTynjVfhVio6BggS5orLZOikMnUGX/KhFlft6re41FrLRw3fw47KFfhu/RU+82P1q+kSCdRNeJxDAsAYewgubw6+W3hMgdLPK+4yqeYRl0IHlcQSfQbDUmoR0ONNVBxxYPESnwBESdUM+l4pI9jy/Be/c/gjT2igecgQQHRRz0XAoCo7lIB+WhfrQWuQyhwY9AA6gqKHFWcegIpAVyV8jn7k8kyOJfs442Guqkq4lkq5TunVJ89d+FFAecK59Z6SfavYvcQZNivM0iAF388iw4G47ONB4lt9rdOzZn5zhvUkxgW5NGCn6WaYF9zVI2MmNfDVPLzY9OSY/TWYxSgAuKlA4HkpWx7mvZAmLxn3fBI/8d2PjwFMa39PeZuKBKNi/Y92fOmJ/upZD6YRKhQ/ORxxPxC72p/Km91kL6vA5vrBvvx2gl1KsBzZhj4PbAwaYSmjGHve67PALRwwIe4+CD5pcY06K1yYM3VlONAAXDB5MxkzxXHgouebipVEvodT6faZhpfcJlWWzBJyKwAY4bpTCYDFKEl7LAa0ufZSJfYXAwVeMDx9hA3yME56e0zEUpu20kItkeLuYRAXR0n3a3OiVQErEwcykwZfK+BfCUUnJodRXqiLWZepoVMHAGPHktYyQqRmG1Pmp2HXHWk2lXiuR1R831okmNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(47076005)(36860700001)(81166007)(70586007)(356005)(36756003)(26005)(186003)(16526019)(2616005)(83380400001)(508600001)(4326008)(8676002)(54906003)(2906002)(70206006)(6916009)(7696005)(8936002)(86362001)(40460700003)(336012)(5660300002)(6666004)(15650500001)(82310400004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 07:07:12.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8cb982-b2e8-49ef-002b-08d9f2ad4954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5204
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Lijo.Lazar@amd.com, ray.huang@amd.com, Evan.Quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's always miss the SMU feature enabled checked in the NPI phase,
so let validate the SMU feature enable message directly rather than
add more and more MP1 version check.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Lijo Lazar <Lijo.Lazar@amd.com>
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 12 ++++-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 12 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 48 ++++++++-----------
 3 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index b3a0f3fb3e65..f1a4a720d426 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -552,6 +552,16 @@ static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
 	return 0;
 }
 
+static int cyan_skillfish_get_enabled_mask(struct smu_context *smu,
+					   uint64_t *feature_mask)
+{
+	if (!feature_mask)
+		return -EINVAL;
+	memset(feature_mask, 0xff, sizeof(*feature_mask));
+
+	return 0;
+}
+
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -562,7 +572,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.read_sensor = cyan_skillfish_read_sensor,
 	.print_clk_levels = cyan_skillfish_print_clk_levels,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = cyan_skillfish_get_enabled_mask,
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
 	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
 	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index e99e7b2bf25b..fd6c44ece168 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1366,6 +1366,16 @@ static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 	return 0;
 }
 
+static int renoir_get_enabled_mask(struct smu_context *smu,
+				   uint64_t *feature_mask)
+{
+	if (!feature_mask)
+		return -EINVAL;
+	memset(feature_mask, 0xff, sizeof(*feature_mask));
+
+	return 0;
+}
+
 static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_power_state = NULL,
 	.print_clk_levels = renoir_print_clk_levels,
@@ -1390,7 +1400,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.init_smc_tables = renoir_init_smc_tables,
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = renoir_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.get_dpm_ultimate_freq = renoir_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f24111d28290..33151983d9ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -59,6 +59,12 @@ static const char * const __smu_message_names[] = {
 	SMU_MESSAGE_TYPES
 };
 
+#define smu_cmn_call_asic_func(intf, smu, args...)                             \
+	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ?                          \
+				     (smu)->ppt_funcs->intf(smu, ##args) :     \
+				     -ENOTSUPP) :                              \
+			    -EINVAL)
+
 static const char *smu_get_message_name(struct smu_context *smu,
 					enum smu_message_type type)
 {
@@ -493,6 +499,12 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 	return test_bit(feature_id, feature->supported);
 }
 
+int __smu_get_enabled_features(struct smu_context *smu,
+			       uint64_t *enabled_features)
+{
+	return smu_cmn_call_asic_func(get_enabled_mask, smu, enabled_features);
+}
+
 int smu_cmn_feature_is_enabled(struct smu_context *smu,
 			       enum smu_feature_mask mask)
 {
@@ -500,7 +512,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	uint64_t enabled_features;
 	int feature_id;
 
-	if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
+	if (__smu_get_enabled_features(smu, &enabled_features)) {
 		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
 		return 0;
 	}
@@ -552,10 +564,9 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint64_t *feature_mask)
 {
-	struct amdgpu_device *adev = smu->adev;
 	uint32_t *feature_mask_high;
 	uint32_t *feature_mask_low;
-	int ret = 0;
+	int ret = 0, index = 0;
 
 	if (!feature_mask)
 		return -EINVAL;
@@ -563,12 +574,10 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	feature_mask_low = &((uint32_t *)feature_mask)[0];
 	feature_mask_high = &((uint32_t *)feature_mask)[1];
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
-	/* For Vangogh and Yellow Carp */
-	case IP_VERSION(11, 5, 0):
-	case IP_VERSION(13, 0, 1):
-	case IP_VERSION(13, 0, 3):
-	case IP_VERSION(13, 0, 8):
+	index = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_MSG,
+						SMU_MSG_GetEnabledSmuFeatures);
+	if (index > 0) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_GetEnabledSmuFeatures,
 						      0,
@@ -580,19 +589,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 						      SMU_MSG_GetEnabledSmuFeatures,
 						      1,
 						      feature_mask_high);
-		break;
-	/*
-	 * For Cyan Skillfish and Renoir, there is no interface provided by PMFW
-	 * to retrieve the enabled features. So, we assume all features are enabled.
-	 * TODO: add other APU ASICs which suffer from the same issue here
-	 */
-	case IP_VERSION(11, 0, 8):
-	case IP_VERSION(12, 0, 0):
-	case IP_VERSION(12, 0, 1):
-		memset(feature_mask, 0xff, sizeof(*feature_mask));
-		break;
-	/* other dGPU ASICs */
-	default:
+	} else {
 		ret = smu_cmn_send_smc_msg(smu,
 					   SMU_MSG_GetEnabledSmuFeaturesHigh,
 					   feature_mask_high);
@@ -602,7 +599,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 		ret = smu_cmn_send_smc_msg(smu,
 					   SMU_MSG_GetEnabledSmuFeaturesLow,
 					   feature_mask_low);
-		break;
 	}
 
 	return ret;
@@ -696,8 +692,7 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	int ret = 0, i;
 	int feature_id;
 
-	ret = smu_cmn_get_enabled_mask(smu,
-				       &feature_mask);
+	ret = __smu_get_enabled_features(smu, &feature_mask);
 	if (ret)
 		return 0;
 
@@ -749,8 +744,7 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 	uint64_t feature_2_enabled = 0;
 	uint64_t feature_2_disabled = 0;
 
-	ret = smu_cmn_get_enabled_mask(smu,
-				       &feature_mask);
+	ret = __smu_get_enabled_features(smu, &feature_mask);
 	if (ret)
 		return ret;
 
-- 
2.17.1

