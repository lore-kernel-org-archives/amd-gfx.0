Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E276CE7A89
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 04:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFFE10E1CB;
	Mon, 25 Sep 2023 04:28:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1C810E1D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 04:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L00gUwtFFO/0KcjB2/nWJT1TKD9AXpuAaLpQ9YtrrRqQrNPudfOVpDlIDqb1iKIuoQkrWEM5y5Msu9xj2rin4JeTW+OmTOpvfuYHfe7b1YRr5uL7WnBJr/FjCZpr34moGPkTjYByYBpt5ZBA6i59Y+m3vv/vLVbkceOBPVtnrcD8oq7ypQSV4aVTNs54T0P4t1CHtomtsqQMf8w8xih1k25bIlVz1P7EWrtTZ96L6lf/k4pobMNb+sWtjX3RtHdg1obGsYrfcntle3PIczVm8e1ePSiDEH7zdHL1eWjvk8VwISMATk1kPPm+RE/SnPtLK9gTc96Su4ntpw4Y+BZPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFZpDMInDYFer9CikO4J3rfKmH00V0FW2wjYKlbCQsA=;
 b=kX6KkCVDi6kwWTEm1LjgrFcWSwmX/Bj6DKYdd7n1ff1bkaQIxo2PTefYugYjiJnv5hIymZfSSR26eAJxGJrPCPchkvIujYcPP2Un/M9UQ6R+EZh3im/LxeGtD9WO/RkYQXiGYqjGt069bhThll2kaoE5IQlbmeMH+rcwX6CFSis+/XZN0ZKGXmlhBDgOHBsSbu9NQJ/PFf4G/FeNCCKPiVPUV5MlW4M7R7ONatzCAZ0B9nW32iqFA9MqOar9F14YZiCPokzu3mhFHqNCiVYcXfCrRd2OBwMfgcJoQD0rzXJldjKu4Ot+9I6Vj077+tp4mj2xLYP+zmd/rMy81K0reg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFZpDMInDYFer9CikO4J3rfKmH00V0FW2wjYKlbCQsA=;
 b=cIXajxvD7rrQJSz7w3e340GdukuPRw7QoKMrHZQEv3/ntw/ZsQFglnKrkv3dxioB5bnnCAqi33YCfpXdsNtepdp8AZgC06ZxIZRtp4Et/Q8az8Yrt+rXo+WasIsd7vDh+0HGohIkZ9SY8aPT0clvyuaP+VhLZ6mZx1IiZ16j7aQ=
Received: from BYAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:a02:a8::31)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 04:28:52 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::fc) by BYAPR03CA0018.outlook.office365.com
 (2603:10b6:a02:a8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 04:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 04:28:51 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:28:49 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amd/pm: integrate plpd allow/disallow into
 select_xgmi_plpd_policy in ppt level
Date: Mon, 25 Sep 2023 12:27:51 +0800
Message-ID: <20230925042752.3847-6-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230925042752.3847-1-le.ma@amd.com>
References: <20230925042752.3847-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: be5f861d-3cf8-478b-0234-08dbbd7fec08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jst7D3Wpt1OIeKxrlcNdkfmBjCuXymdqxzTKAZV4NjH4Hy1nppcgMncWJHwoR4S3RW+0wvl8r8gXvdowmFVHkwApTCVsx20TVmitXN+prZv8B+SuHYqSzsdVsdscA3GW3h6BhL1tmv0nDTFKItGAgBpQ3ACyviRX3qBuBhu7qqyGZ6+refuNEsusEtohmCOtI+xNZ6gJhoyrHYrVB627Bq79ApRSbfcEVekTXh3WV8Vo8Ed99hSsDJIVcHmjaUgEXnpnZSffIFAvKrdeQOTo0sD66wg4qUWghaUaDLhBfLSDc5B8nHa6ENmoX8dY9lrmw2UDNaV1C7MxACfKgnARJ9RfsyXK3eHg/GbwTHBFDTI4o/5HJVNqUzXtKHFNKxXBmW4q2W1863Jf1Fv7CFosmEPFYheR+nQxLJFAlAGIEqWNtCQpYv29iPVuUxhAPUE+TIHBled9D954Ee0lxeSoUq/V+5kllnwAM8RCkjm4GZY8PQUPRqfl0MlRsrPynK/90TDgkkAfMe1Nsx1F3K3tXVzR4IiSEPnwhe39e4aW1gRi70J7wgb9C4jBTRZ8ExSo2ALhPnZyZWMgokUDIvFfabcLLHPlQadFaQzBVlYF5nveK8fYaRsmOepwjlG2AqfgrRrk0M2m7vcO1QktxzQLE/ut6GqSZVhtUXne0/9A9Wi3DvmsuYWy+pcnh0GPk6R1Jem3jRzY9YgdFxDb0MuGoGchfHSi6DtrATD2CmAKVt4zeXcxSiJ8mk8cotFggS8TqfTcYy9cVKz28cfXmSI/5J6nKrmwKEETksYyBHwT5AE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(54906003)(316002)(41300700001)(8936002)(70586007)(70206006)(6916009)(40480700001)(8676002)(4326008)(2906002)(44832011)(478600001)(40460700003)(26005)(6666004)(36860700001)(5660300002)(47076005)(7696005)(83380400001)(16526019)(36756003)(336012)(426003)(1076003)(2616005)(86362001)(82740400003)(81166007)(356005)(20673002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:28:51.9782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5f861d-3cf8-478b-0234-08dbbd7fec08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The allow_xgmi_power_down(true/false) will be generally replaced by:
  - allow: select_xgmi_plpd_policy(XGMI_PLPD_DEFAULT)
  - disallow: select_xgmi_plpd_policy(XGMI_PLPD_DISALLOW)

Signed-off-by: Le Ma <le.ma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 21 +++++++++--------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 23 ++++++++++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 22 ++++++++++--------
 3 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 080140a0f673..6e2e665ad383 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2227,7 +2227,8 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
-static int arcturus_allow_xgmi_power_down(struct smu_context *smu, bool en)
+static int arcturus_select_xgmi_plpd_policy(struct smu_context *smu,
+					    enum pp_xgmi_plpd_mode mode)
 {
 	uint32_t smu_version;
 	int ret;
@@ -2244,16 +2245,16 @@ static int arcturus_allow_xgmi_power_down(struct smu_context *smu, bool en)
 		return -EINVAL;
 	}
 
-	if (en)
+	if (mode == XGMI_PLPD_DEFAULT)
 		return smu_cmn_send_smc_msg_with_param(smu,
 						   SMU_MSG_GmiPwrDnControl,
-						   1,
-						   NULL);
-
-	return smu_cmn_send_smc_msg_with_param(smu,
-					   SMU_MSG_GmiPwrDnControl,
-					   0,
-					   NULL);
+						   1, NULL);
+	else if (mode == XGMI_PLPD_DISALLOW)
+		return smu_cmn_send_smc_msg_with_param(smu,
+						   SMU_MSG_GmiPwrDnControl,
+						   0, NULL);
+	else
+		return -EINVAL;
 }
 
 static const struct throttling_logging_label {
@@ -2455,7 +2456,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_df_cstate = arcturus_set_df_cstate,
-	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
+	.select_xgmi_plpd_policy = arcturus_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 23820204efd7..b57184a3e24f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1604,20 +1604,27 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
-static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
+static int aldebaran_select_xgmi_plpd_policy(struct smu_context *smu,
+					     enum pp_xgmi_plpd_mode mode)
 {
 	struct amdgpu_device *adev = smu->adev;
 
 	/* The message only works on master die and NACK will be sent
 	   back for other dies, only send it on master die */
-	if (!adev->smuio.funcs->get_socket_id(adev) &&
-	    !adev->smuio.funcs->get_die_id(adev))
+	if (adev->smuio.funcs->get_socket_id(adev) ||
+	    adev->smuio.funcs->get_die_id(adev))
+		return 0;
+
+	if (mode == XGMI_PLPD_DEFAULT)
+		return smu_cmn_send_smc_msg_with_param(smu,
+						       SMU_MSG_GmiPwrDnControl,
+						       0, NULL);
+	else if (mode == XGMI_PLPD_DISALLOW)
 		return smu_cmn_send_smc_msg_with_param(smu,
-				   SMU_MSG_GmiPwrDnControl,
-				   en ? 0 : 1,
-				   NULL);
+						       SMU_MSG_GmiPwrDnControl,
+						       1, NULL);
 	else
-		return 0;
+		return -EINVAL;
 }
 
 static const struct throttling_logging_label {
@@ -2072,7 +2079,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
 	.set_df_cstate = aldebaran_set_df_cstate,
-	.allow_xgmi_power_down = aldebaran_allow_xgmi_power_down,
+	.select_xgmi_plpd_policy = aldebaran_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = aldebaran_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b137c37903fc..c20537fb9df0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1897,12 +1897,6 @@ static int smu_v13_0_6_set_df_cstate(struct smu_context *smu,
 					       state, NULL);
 }
 
-static int smu_v13_0_6_allow_xgmi_power_down(struct smu_context *smu, bool en)
-{
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GmiPwrDnControl,
-					       en ? 0 : 1, NULL);
-}
-
 static const char *const throttling_logging_label[] = {
 	[THROTTLER_PROCHOT_BIT] = "Prochot",
 	[THROTTLER_PPT_BIT] = "PPT",
@@ -2730,13 +2724,22 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
 	case XGMI_PLPD_OPTIMIZED:
 		param = PPSMC_PLPD_MODE_OPTIMIZED;
 		break;
+	case XGMI_PLPD_DISALLOW:
+		param = 0;
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	/* change xgmi per-link power down policy */
-	ret = smu_cmn_send_smc_msg_with_param(
-		smu, SMU_MSG_SelectPLPDMode, param, NULL);
+	if (mode == XGMI_PLPD_DISALLOW)
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_GmiPwrDnControl,
+						      param, NULL);
+	else
+		/* change xgmi per-link power down policy */
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SelectPLPDMode,
+						      param, NULL);
 
 	if (ret)
 		dev_err(adev->dev,
@@ -2785,7 +2788,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v13_0_6_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v13_0_6_usr_edit_dpm_table,
 	.set_df_cstate = smu_v13_0_6_set_df_cstate,
-	.allow_xgmi_power_down = smu_v13_0_6_allow_xgmi_power_down,
 	.select_xgmi_plpd_policy = smu_v13_0_6_select_xgmi_plpd_policy,
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.38.1

