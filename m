Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D11093163
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 01:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA9910E239;
	Fri, 20 Mar 2026 01:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GwB+iTS2";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1B610E239
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 01:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLorEFfAEFLYBccyH6L4g2cCXR5Esr8kEDLZU5BnAmf5d3ebIe0gAC65OaNsRY098y1y0mcAZST1lq6MY5heaQ+ky38o5fzQr8zKWyN1iWAPeXTGDegyPudD2ueBOtWfdlpP+zsaXieP7lLwtfwiO15cqXTBbvgXDzaBbwP4ZNlVWHBJBh9pbHRk2PK/ANnVGpQ3a7qNdu1Vwg4y0n59AsqhKqeJDIi1ZkYQ2uVpDqyWp2yJKGB8HT+xH5EM594C59hPAO0qMwAfK80dogI0THvlyYBz/yK4zHPU915u1uWeCWlN2p1fWV+6ibXR6KVbC6trFsbTIQLYcq9kpr/gRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIfXpgYpwLlNDCzmO2V/mNGgPJzsys/DEspfaiDYYaQ=;
 b=MSTEUuwgXOmgDFKgAMd9nMUazx6IpMvWH9a69bSsR2ABDTNOUrrnZ2n30uS8SllANBBr7K64L0V8d9Ypi5RohiAclB36D6FzV71Xq8zvPR+qMhKDAcR/9AAHMpdoLhlZh93mQK3U5qa854uUgII3o2YRNlDRqRgTQksn5EBROBaqGRq63I3clBUdvr1qE7POjnb1n9CT6ibGC9likjHfBT1naRYOCKrpQkIIICY8YgaSUJXPmrDcxy9YjBUkds3it3hTCnayFWSxLq4dKZcUphIbVuRuGU6HeNpx8fLDJQFNuqskCWtC8TexY+Tel9mntMZ9bPEuqMK0yTO0iiDDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIfXpgYpwLlNDCzmO2V/mNGgPJzsys/DEspfaiDYYaQ=;
 b=GwB+iTS2iRwzDONWW0VRi5zBaxJWGbIVg1r6gm8q+USeGmvJbcQQH72D0RzG+uCHGiFa4I9eF40ZD4AGu7BZARmo4DQiW8t1Mnhww/M01cEp2VTdIj1t8x6aEpiVwG+gC6ev3BxGRH/fywcABT8OXBIkzvSgJRIBLHTlnH5qk08=
Received: from SA9P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::18)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 01:48:13 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::f2) by SA9P221CA0013.outlook.office365.com
 (2603:10b6:806:25::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Fri,
 20 Mar 2026 01:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 01:48:12 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 20:48:10 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range
 invalid for smu v13
Date: Thu, 19 Mar 2026 21:47:59 -0400
Message-ID: <20260320014800.228582-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6b5e58-f392-4e0c-3a73-08de8622bef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: bz3J3MAaxYV8mwAxcZcqOzqmcMOU66SkmKCN4IGJnGc6GUUA71fwzXCVldszu7JUMej3XPFLp3FO2b+tX6yudNAxH13y2vCYUj1OVXBLIv0Z33vjsCEkBhzgKjL3iuVqdWl7tvHzmfZZLhpJy3GbbVjxVfxnXRsCDY1iPL9xtNerU573KIyCg1gg7TiCu0WjurccS7pH7ooAH0chhnFnSCwXPzTfy+OJYSEcQUT4vnVnZKftVD8LiJmdsourcmSqP11KeI9NG76bU/HRIl0vC0sBw5R8MSxwXIeUgNt1kWpnKHMCX6zgyJToBD92yMgtywn6hLk6+CX/T6iH48qlxUL9PQX8vTOYa2hcFkJr6eNz0gU77t4z+xq1rH6jd2ZXbmoJgkrvSbNpWsdDl0XCeAnxHB4eykOZPy3T6X628aAxYaMs9F8Ou56BrCjzDBCu+9nZp1KRN44fIYqS1gp4StzTGAjmYtRNw5H+WJ6mLa1zs6S/ydUxp/EIxDgCYJMYouwq2Wlx3BMzoe3bSlXJMNn6UZJy43jGWQ6k8inxp1hdgRubcbAp2Q383H2IT5Z1jjHFg4Ju/sz7CR6kJHTYMbKyN4yYsyNZd+CIzrSGFhHcqa72r8Soy9K7KjnoonggOFim64ObdzGiseWU67tU5BgWeTwfzaAJlpwnf5RU83CG+8pSWxuHMTVOwUl8XdtjlDIjYkttQPt//HRcKcHqY1ct/WOdO8Jy83yzIEM4CNs77VixvePf3OZUIk83CaAXz3mwlt1Rq3WSxG9PbMorAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nj8Jkk5tvX1cyygs5l7hAetatiw0ylofYC7FZU74U6Qek9pOFultxzhcWLTMUNYkIAIq7xwZ/eEGCnnV5g2eAghC1UqFYlxj0HBu9l//76+lKlex1Wl0ZkOM7ogOLnNGfph6XdMuNwWWdf6agUYiwd/ZkQZQ01laLtnaxRfBw7UfM5m6UZSSBNMFaSWTPSFIXhsm4Eb0GuFYVFO9i56TnNmx55p5wPNqvU8SCU5q+6yqaAZ4Vw9cUW2KcizS+4Dtnr7jySoCfyIjI7hVO+ydZxyIgO8ZjkzOrIlOd5DpTpk1/4fcqLGc99gB2M/dA4LBk7NFvhjAkJPkq/XIBje/ybrF/z95ANDsqa2yDl8qZC91JFaXIbVBOeW4ACBCfqu2p09ono0zUVETrgINbh/VyGBADexdAyQtmK+/vLgJ2oEs3aImmU7NQvkvHkhLx1Jl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 01:48:12.3139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6b5e58-f392-4e0c-3a73-08de8622bef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Forcibly disable the OD_FAN_CURVE feature when temperature or PWM range is invalid,
otherwise PMFW will reject this configuration on smu v13.0.x

example:
$ sudo cat /sys/bus/pci/devices/<BDF>/gpu_od/fan_ctrl/fan_curve

OD_FAN_CURVE:
0: 0C 0%
1: 0C 0%
2: 0C 0%
3: 0C 0%
4: 0C 0%
OD_RANGE:
FAN_CURVE(hotspot temp): 0C 0C
FAN_CURVE(fan speed): 0% 0%

$ echo "0 50 40" | sudo tee fan_curve

kernel log:
[  756.442527] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!
[  777.345800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index cd077151f3e4..9be7a2af560d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -59,6 +59,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v13_0_0_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1044,8 +1048,35 @@ static bool smu_v13_0_0_is_od_feature_supported(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	int32_t min_value, max_value;
+	bool feature_enabled;
 
-	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+	switch (od_feature_bit) {
+	case PP_OD_FEATURE_FAN_CURVE_BIT:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		if (feature_enabled) {
+			smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_TEMP,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+
+			smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_PWM,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+		}
+		break;
+	default:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		break;
+	}
+
+out:
+	return feature_enabled;
 }
 
 static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a1d50654db72..5cc15545da6e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -59,6 +59,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v13_0_7_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1054,8 +1058,35 @@ static bool smu_v13_0_7_is_od_feature_supported(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	int32_t min_value, max_value;
+	bool feature_enabled;
 
-	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+	switch (od_feature_bit) {
+	case PP_OD_FEATURE_FAN_CURVE_BIT:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		if (feature_enabled) {
+			smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_TEMP,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+
+			smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_PWM,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+		}
+		break;
+	default:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		break;
+	}
+
+out:
+	return feature_enabled;
 }
 
 static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
-- 
2.47.3

