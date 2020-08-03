Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27713C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 04:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AB620719
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 04:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Aq4S8mzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A276E10B;
	Mon,  3 Aug 2020 04:47:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612896E10B
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 04:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da7rQzhQlPgzYGe+T8hNNv40of0Y7YmqrTashCEHI80LtplCeVM9s5CTjKQyDe1XHSOWahZTXt01b4Bwr4VWSWAioz1lEdstfhgTPembTGX9iEryWZY3WmzKNPTfoGByvARbdaOENPCI/4EwJHFIuOxb1UoFPpzhcT6xMg+b1UlqoP5U3TIaXKL95LbHz1+2Y6bzGKGFAp5aCikWTDX5XUn1yMW5ABJ/0QJBdg7ZIILS93FXN3uqqFpIbImYxhCUgUmX5uF6dE7Q2WndTqMvQtCetlbLc5au/nxFJVXjjHZR1wFcYapxLYaO9SJa4s4N3j9W0q4dR7wXBxpPXaY1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruH/Azm2ILvCPd4X9vdQdAvy4M7ZvYmq4yM/mt53Y+w=;
 b=bIePcy2PgVBCCS1+COycE+szzEeMj+fxfzbX3fpx9IzMD2WcOQCH6eeeX1HVGP5EkbLT8DOYLQjrpC4qusw8Jp13GMIFg4Puo5O6w4mbjwXLcOgJgT+uY9JyKFSkCDgVkNlNptjG5irFT8nQq4BP/sd4pB4W74VEG/pD7oc0toIL/uKaB7zqg/oRFCkX+Epr9bv4oD/DWUkyPYaatJ2cKNxzFQC6/yYSobOWbmqpCzP9TTO2123HNy6unobLRlkX2fxnh350unuusYzJR9oDPfvZfvB4gyvwXzMXiSfra8YRCaxwZ0jXeV1pBavYbaYGSKzmzn4FU/Uclv+IeYlPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruH/Azm2ILvCPd4X9vdQdAvy4M7ZvYmq4yM/mt53Y+w=;
 b=Aq4S8mzbLtPuhxtJdwWIqoLIFqJG3Cz3AgP1XnIdc4tmuRwIEA2kvqGrNtyw6DDjgN2lhX/0WRyV/NphzyfDprswXPnNU0MBaA1YXF3rn9xt/NPT6BGoNoO7DvwrcvOi7paodhJvn9xcvLilwQFzT6V+dI0jRjN/Z2UNA87XMkk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Mon, 3 Aug 2020 04:47:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 04:47:16 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: update swSMU VCN/JPEG PG logics
Date: Mon,  3 Aug 2020 12:46:47 +0800
Message-Id: <20200803044648.28805-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:d0::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0007.apcprd04.prod.outlook.com (2603:1096:203:d0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Mon, 3 Aug 2020 04:47:15 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fada5a9-9a16-422b-8178-08d837684c11
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02187F908FE62EE9C5F706E1E44D0@DM5PR1201MB0218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gA9vvfVlZpP/qgi4q1THmIDL3KdkoZGoC9i9FH6774v4bYDQBHwOToeAQbX9ff8DA+F2ZU29+Yt0Rbo80xJwP3arlW9FaUnkUAW6zhoqhKWEAnoUKuMRskdA2fPdFTAhNPY381J1n6qTC4wNrNZBWi5TLlOkYWPDi+ocUgZ5RyPgRY2W/1AgGOBt4nxuepIbQ1OG5Q90gaD/2AxXkIESgE1RM3fYKsDpDD0DLbUQrfvje7uCw6PoXj+fg0zb9mFQXXMtk7Ct+gzXbYrp5eC9WBCKZXUOR/hSdEBZqijWpf2cm+1ikNhDokFPCIHDXGVd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(44832011)(86362001)(2616005)(1076003)(6666004)(956004)(2906002)(83380400001)(8676002)(26005)(6916009)(6486002)(8936002)(36756003)(7696005)(66476007)(5660300002)(186003)(316002)(52116002)(66946007)(66556008)(4326008)(16526019)(478600001)(30864003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LcGXATA1UzYVxdj2jjKbnkZt8mG+7DwmzI4uLYK6q5pukVcrrCNxrNatUTeTmptHlQfSykpLs93Zdzf4goBlauNDn2vIjUdDpRxXiCoSaEKSR1wSccL4cHf8OUvbQ4C5Jp6EgUd/CgK/6EcCpinkAsSwLbYb0iXLefUARYQmKPnosmD4sDoIHi563JjMeV1M8BGD7jdIdDtDm0gU/5REnQ+C17aQa9NoUIngVaLlR0BYgCHx+lJNMRpxSLHgy5zTM36u+Zh9S3DVWATaHAtCmFUHUldkMY0ZBo+NAo/ZsK6ZZRGRzZHE/DPfRpGMXrpJ5jKW7ncME1YSykyR26qgkcjsev163H+Ca+V9+LDPRd6beGd4Ptwv1CsGxlfRFQC8fo099YNBsoYEzMZhzuGa/0DsM13vwYuI6C6TFlC3OuHNAz58kO2omYSgt8HYn/IjQPjRfkIjcBJ7e5CcTW+/o71PunlcnYN8Cqsvmpiq28DWesvxiqln40xHZNt/NeH2xX+q8/pZV3VNA2MoCxokadgajICQqH3YYyNi4vYg7jU8NJk67PhcUkdfUuHCAPUX99eJpl7hIV2HlGXYyRoaV4tbkOnsSlhaTN/3AJikYzbewRqe1Q9Tf3mVjSmGKjUhYuHbkrU8NvB63by1Y3VYTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fada5a9-9a16-422b-8178-08d837684c11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 04:47:16.7446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALpNomAFROnFxxcYYYT0OgP/r80va4wkaJizut9hKo20E7cCtuUKyClk7gnne149
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Cc: alexander.deucher@amd.com, mcoffin13@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add lock protections and avoid unnecessary actions
if the PG state is already the same as required.

Change-Id: I01400b84151d3ac6e3c8b0d7e264f9a68a9c2092
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 57 ++++++++++++++++++-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  4 --
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  6 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  8 ---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  8 ---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  9 ---
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 -
 7 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index cf9c5205ef08..85b04c48bd09 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -133,6 +133,56 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_dpm_set_vcn_enable(struct smu_context *smu,
+				  bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (!smu->ppt_funcs->dpm_set_vcn_enable)
+		return 0;
+
+	mutex_lock(&power_gate->vcn_gate_lock);
+
+	if (atomic_read(&power_gate->vcn_gated) ^ enable)
+		goto out;
+
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->vcn_gated, !enable);
+
+out:
+	mutex_unlock(&power_gate->vcn_gate_lock);
+
+	return ret;
+}
+
+static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
+				   bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (!smu->ppt_funcs->dpm_set_jpeg_enable)
+		return 0;
+
+	mutex_lock(&power_gate->jpeg_gate_lock);
+
+	if (atomic_read(&power_gate->jpeg_gated) ^ enable)
+		goto out;
+
+	ret = smu->ppt_funcs->dpm_set_jpeg_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->jpeg_gated, !enable);
+
+out:
+	mutex_unlock(&power_gate->jpeg_gate_lock);
+
+	return ret;
+}
+
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -644,6 +694,11 @@ static int smu_sw_init(void *handle)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
+	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
+	mutex_init(&smu->smu_power.power_gate.vcn_gate_lock);
+	mutex_init(&smu->smu_power.power_gate.jpeg_gate_lock);
+
 	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
@@ -1974,7 +2029,7 @@ int smu_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = smu->smu_power.power_gate.vcn_gated ? 0 : 1;
+		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0: 1;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d678534ddc69..a2ba6633fc21 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1894,8 +1894,6 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 
 static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -1906,7 +1904,6 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 				return ret;
 			}
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 0);
@@ -1915,7 +1912,6 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 				return ret;
 			}
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ec2d2aa7f4ec..23c2279bd500 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -295,8 +295,10 @@ struct smu_dpm_context {
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
-	bool vcn_gated;
-	bool jpeg_gated;
+	atomic_t vcn_gated;
+	atomic_t jpeg_gated;
+	struct mutex vcn_gate_lock;
+	struct mutex jpeg_gate_lock;
 };
 
 struct smu_power_context {
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ee8d938ea3bd..9dfa27de7ef3 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -831,8 +831,6 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -842,14 +840,12 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
@@ -857,8 +853,6 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -867,14 +861,12 @@ static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownJpeg, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 4c1a506c3c17..8a8e6033f71f 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -479,8 +479,6 @@ static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context
 
 static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -490,14 +488,12 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
@@ -505,8 +501,6 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -515,14 +509,12 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index a95c82a709d8..2c0ebb86f109 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -815,10 +815,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	struct amdgpu_device *adev = smu->adev;
-
 	int ret = 0;
 
 	if (enable) {
@@ -834,7 +831,6 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 					return ret;
 			}
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
@@ -847,7 +843,6 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 					return ret;
 			}
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
@@ -855,8 +850,6 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 
 static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -865,14 +858,12 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index d0deaefd3feb..f1d8f247e589 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -77,8 +77,6 @@
 #define smu_get_dal_power_level(smu, clocks)				smu_ppt_funcs(get_dal_power_level, 0, smu, clocks)
 #define smu_get_perf_level(smu, designation, level)			smu_ppt_funcs(get_perf_level, 0, smu, designation, level)
 #define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_funcs(get_current_shallow_sleep_clocks, 0, smu, clocks)
-#define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_funcs(dpm_set_vcn_enable, 0, smu, enable)
-#define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
 #define smu_set_watermarks_table(smu, clock_ranges)			smu_ppt_funcs(set_watermarks_table, 0, smu, clock_ranges)
 #define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
 #define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
