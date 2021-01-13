Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6096FC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0171D22EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0171D22EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E93689C9A;
	Wed, 13 Jan 2021 03:28:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474A289C52
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHB9Zd8EJ3gtJ10bUoEFeFLmi4rnCMidxxdt3h/hTEW68aklGBOxoMdhORCNEdg7L0zG/dAlXyuTEXH4oQQyVAUFC7KUjMCJqJJZP190W2kLLuGkl6hr+gAB0TnDlQaDlOyYUt7263brLn6GuueccdQhnVfTOJVS7elBsZf7FWxBBqjwFqB3bk6+ri81UBkLRexl2a8Mdt3CJQv8D7kf/2wIgc9nb5hafgyjnWp8+g+u0JolEtnO25BZUCAzDxboMHLqTtzBjJJukfFeO88/jGX3QxXv/Lq6IxyerHohfHAEBi5hVByrbo7TIUbUjp368ehMKIU5VLGYaaf02si5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkiu/kv6wLFEwIe23orOSyo9wRb2EduvT4dSIyMqTnU=;
 b=Igyl3TEVmnY+Kr0Q1OVlOq56VXRSAb5YYRiDCzo1ZfTMfGZix9k4NMEhTwRDT04zPbVlQBK11F6YH+5At7Kg644E8lQtaW00hiwgYoHBSNUYix9Ry6FktFsZcFZlyKTSKFmqTwkb3sLTcEEeQ/Js+M8LLNI+DW601hdvOzeAPDYWK0nJV/jMUC2d2o+3C2YppNrZ/SqBzFi/LTl8+N5c7cwZhQD+l1aVzHXqryoiWUkl+g+UPYCwBGFgTc5S3sxI7nUghw6qdXchMpfixWdQSXkNENEGKM0DSRe/7bXZOhCzEcyT68MDaRpYS86pE52fNobJM4vQnNpyEt1ldCyiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkiu/kv6wLFEwIe23orOSyo9wRb2EduvT4dSIyMqTnU=;
 b=bkoK05NO/l0XhFg+qvSWb5s4gssGkfOtsVieaju/KW205iUCIeB/ogj+CvbwAomzRRDOXq6KDHdMVuYzY1iFlZmMv+D9Mqd91wCLEAfEmEsoB1Ci9oWPnd8WDfZK3GOW0qZld3rX/NuqeXcdowE9a6XU8tdy+1HZije/AbYIA/8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:07 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:07 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] amdgpu/pm: Powerplay API for smu ,
 updates to some pm functions
Date: Tue, 12 Jan 2021 22:27:26 -0500
Message-Id: <20210113032726.2475-9-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
References: <20210113032726.2475-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c6f69bd-0897-4c4b-edd4-08d8b7733ecf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38176342EF8F0C00AA387CAAF0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ho5SwLXSujAZWlviCVRwaNvmagTnKj5mKmCGK/827iOwrzeEaloYdKhLTmjYrLFlbhgUEBKzdRCZFBamnq/E+82fkfUTfVXptUOpNH/c4YsI43VslP7R1GlLq2pl7/qHwZ4ei56JtV4iq0nbE6V7WZ8Fa5mhnrIiAqzdWfHhbocpmFh5zt1jJd6/iMsQOcY90oToL98QaYCZ74ScGKBXLuLtn9XDpAWgM1JCkwJuWb950/OhpcUSyh5x5L6EVaesn464+hkfmH15A0CxJEL5x+IEO+nfrSEg0qmbaknl1A77g7qcpaJyNcVTeg8/IUpfJu9lL4OoXe2a9cq8jD1ut/TWQXZIBI4DPUAK2jY3SOCKZrGtCZV3hkObaeYJuuZMVOs65tGAHj103f1WTHYH89ZGk4PE9c4R2T1/PwBdgTSW+K1a28vBMmxh1wHEsk6s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pdSc5frRahkjPtVnJXKWMwXlZRTNyeqO1Ufradi+Qdrlqu26bUlafguVttBk?=
 =?us-ascii?Q?lTBmFZ/8/shTrOtsIHVRRTTemY49JefcrL4TohguTLpL4PJYThoWX/JNFH7C?=
 =?us-ascii?Q?UJzPPSZhGU570RtFxgzSnrHUVWcjQsYkLeflDZKJdUWiFzYlOQeGGP2vTRP8?=
 =?us-ascii?Q?QZ8GdOoLtjWKtRDQvFlCqioU0o32UiJDxFASt3Gu/20M/naRn7xeLce1OTqZ?=
 =?us-ascii?Q?IFGMpU9t4J2WuGATEdsiH2WveimbilQwaLw5Kp1FfwE5/GJgIgRseGkBZhaC?=
 =?us-ascii?Q?b0NOp3B3e40k1AjFavG58gSoaHx2tPdTUp9KQ+swx8w3SumFRgOdUPfYrlgY?=
 =?us-ascii?Q?NdRC1dJ6iCXJ2crAmZHjRy6w5bgk01iFou4PaLR6DrE9NjTgFb9x2lcltCDc?=
 =?us-ascii?Q?QDX8Bs9P3u6ELZ+EJJ66JhKkPQn3f4NkbbFGcgpg+jh5SpHxm7ZjZ0r/jg3K?=
 =?us-ascii?Q?u/+m2+Jsj36aeBLiE+wUMYpLBaQLgGqzH+6jysOeJxKG6eNNPOie6n8GkKQ2?=
 =?us-ascii?Q?CXQkCc09+wdkSTMHLG7csBB05YeTC5qSo3XWkeVicbYk9BZ/qJMauhx5FpfU?=
 =?us-ascii?Q?vmFEtysgrzV3uKdV8KW8sWnuuV20eiENKLD6ctUzPu9UyS/jgG32iF9ds2zT?=
 =?us-ascii?Q?wSkwJ9R+kWcWoUV/36wnf6WQMsg2ZikH8IbVhjYOwi+rBHG0vUWrRHE+y6Yu?=
 =?us-ascii?Q?vqSXfXOZSGCEuJWNyow+63tma/8+uY0hzUAs/bfiLCdf9HUWQSHWM8GgBjB7?=
 =?us-ascii?Q?msxMzUUnKhBVdLKZHtPkQVIyUVvEZJ6KTXi8Ebq2mg+wXWmSWfy8G8ZnURnT?=
 =?us-ascii?Q?3kwPYaPiORvgFy3uaWFcTw/fE1ABgFXdkCiGPgds3tU5Baqo2+JbpQcOfuCz?=
 =?us-ascii?Q?fek70/sIVeFHeGOhDh3gAr2L6OfxbpmNa3wQE/mS+B4Kap+goXQSmvdsyfo1?=
 =?us-ascii?Q?nCCHDlK+WXFqFgGiMrTJsxlYJnXi7brFijqpiUJSjA0TH/KyVqDldtoaZgix?=
 =?us-ascii?Q?adev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:07.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6f69bd-0897-4c4b-edd4-08d8b7733ecf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me2RStdQrfCUXpIXlRUwS27A8qLPtiJofNCMYAi0zXUrPPaaKKpsMt2vMgw6gnS4ezsJ7mgM3cSnc+J9rhBL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modified Functions
  smu_sys_set_pp_table()        - modifed signature to match Powerplay API set_pp_table
  smu_force_performance_level() - modifed arg0 to match Powerplay API force_performance_level
  smu_od_edit_dpm_table()       - modifed arg0 to match Powerplay API odn_edit_dpm_table

Other Changes
  smu_od_edit_dpm_table()       - removed call to task(READJUST_POWER_STATE) after COMMIT_TABLE,
                                  now handled in calling function
  amdgpu_set_power_dpm_force_performance_level() - now checks thermal for swsmu systems before trying to change level
  amdgpu_set_pp_od_clk_voltage() - now attempts to set fine_grain_clock_vol before swsmu edit dpm table

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 94 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 17 ++--
 3 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e71356e9afe0..4469199e466f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -369,14 +369,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_force_performance_level(&adev->smu, level);
-		if (ret) {
-			pm_runtime_mark_last_busy(ddev->dev);
-			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
-		}
-	} else if (pp_funcs->force_performance_level) {
+	if (pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
 			mutex_unlock(&adev->pm.mutex);
@@ -614,15 +607,12 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_sys_set_pp_table(&adev->smu, (void *)buf, count);
-		if (ret) {
-			pm_runtime_mark_last_busy(ddev->dev);
-			pm_runtime_put_autosuspend(ddev->dev);
-			return ret;
-		}
-	} else if (adev->powerplay.pp_funcs->set_pp_table)
-		amdgpu_dpm_set_pp_table(adev, buf, count);
+	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
+	if (ret) {
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -802,53 +792,42 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_od_edit_dpm_table(&adev->smu, type,
-					    parameter, parameter_size);
-
+	if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
+		ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
+							parameter,
+							parameter_size);
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
 			return -EINVAL;
 		}
-	} else {
-
-		if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
-			ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
-								parameter,
-								parameter_size);
-			if (ret) {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
-		}
+	}
 
-		if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
-			ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
-						parameter, parameter_size);
-			if (ret) {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
+	if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
+		ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
+						    parameter, parameter_size);
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
 		}
+	}
 
-		if (type == PP_OD_COMMIT_DPM_TABLE) {
-			if (adev->powerplay.pp_funcs->dispatch_tasks) {
-				amdgpu_dpm_dispatch_task(adev,
-						AMD_PP_TASK_READJUST_POWER_STATE,
-						NULL);
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return count;
-			} else {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
+	if (type == PP_OD_COMMIT_DPM_TABLE) {
+		if (adev->powerplay.pp_funcs->dispatch_tasks) {
+			amdgpu_dpm_dispatch_task(adev,
+						 AMD_PP_TASK_READJUST_POWER_STATE,
+						 NULL);
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return count;
+		} else {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
 		}
 	}
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -873,12 +852,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		size = smu_print_ppclk_levels(&adev->smu, OD_SCLK, buf);
-		size += smu_print_ppclk_levels(&adev->smu, OD_MCLK, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_VDDC_CURVE, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_RANGE, buf+size);
-	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
+	if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index edd911ac8e5a..f5a6246bb6c4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -664,7 +664,7 @@ int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting);
 int smu_set_power_limit(void *handle, uint32_t limit);
 int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
 
-int smu_od_edit_dpm_table(struct smu_context *smu,
+int smu_od_edit_dpm_table(void *handle,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
@@ -715,7 +715,7 @@ extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 bool is_support_sw_smu(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_sys_get_pp_table(void *handle, char **table);
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);
 int smu_get_power_num_states(void *handle, struct pp_states_info *state_info);
 enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
@@ -745,7 +745,7 @@ u32 smu_get_sclk(void *handle, bool low);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 int smu_sys_get_pp_feature_mask(void *handle, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e846a9c6617f..27f725c9d2fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -347,8 +347,9 @@ int smu_sys_get_pp_table(void *handle, char **table)
 	return powerplay_table_size;
 }
 
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size)
 {
+	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret = 0;
@@ -1650,8 +1651,9 @@ enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 	return level;
 }
 
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int ret = 0;
 
@@ -2097,10 +2099,11 @@ int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
 	return smu_print_smuclk_levels(smu, clk_type, buf);
 }
 
-int smu_od_edit_dpm_table(struct smu_context *smu,
+int smu_od_edit_dpm_table(void *handle,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2110,11 +2113,6 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 
 	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
-		if (!ret && (type == PP_OD_COMMIT_DPM_TABLE))
-			ret = smu_handle_task(smu,
-					      smu->smu_dpm.dpm_level,
-					      AMD_PP_TASK_READJUST_POWER_STATE,
-					      false);
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2753,6 +2751,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
@@ -2760,12 +2759,14 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_fan_speed_rpm       = smu_set_fan_speed_rpm,
 	.get_pp_num_states       = smu_get_power_num_states,
 	.get_pp_table            = smu_sys_get_pp_table,
+	.set_pp_table            = smu_sys_set_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
 	.dispatch_tasks          = smu_handle_dpm_task,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
 	.get_power_limit         = smu_get_power_limit,
+	.odn_edit_dpm_table      = smu_od_edit_dpm_table,
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
 	.get_sclk                = smu_get_sclk,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
