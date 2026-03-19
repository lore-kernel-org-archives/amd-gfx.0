Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7DF1075274
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6598510E8E0;
	Thu, 19 Mar 2026 08:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p+8wpdSQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6274310E8E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMZIpfLHSm0jbtPMWpA5u3qM7DLOJ0GpJ4coZIJ/jhQEs1rQJw95cau8zeVZBmX2aTR5iB+WOiINpzK0tohQhfxZwNhs+OJ8I0OsfviV7YC90CubXqmk01OPgo8mliJ4Crwc69ecyUrM+ZpHa8foyhHV5Ww0YwTDhXF5AiQ3pBlUjcjHkGTgQad4/xqsC7yFfmCwzgqInn9LcCb8hzNbsDo5+EP9giQzsIoT31cTw7qY3ZwMSxI9bjR97I3u8xYfwNkqXp6DcsyuX1m2jVoLKgAr87TQijwBaYZgmi15YcoddBjKKC6XiEYeQfqxDWBJrNWoDUUdfcJ71PWANsb5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vKltWQZdPDtv22DQZoih+Ht5zrPh5FBEibnM9yup3g=;
 b=jSXpPydRRPijMOAFjHWbaPSflYNYpDUvuTxPcI7m6aoVG79pgorKfTSV+Y6VLGoyynqtw5Ed3qyyFmkjxlJaGZ77+5nRl3+y+rWPFZJhxZUcDxHjhf+Hz8Jny3G4rzqrneE2CcOEQzLfFO26EOpD8BHEVdjsAW8S/1mXejMMjMGPMMe+lBw1s4firzgpYkPwr5qTxYYPCz4rAHnEDGFOtwGJSzELjJjkthjbaxBwU0RcjTu8f0P7tUTNgsmoEYvRTBrFMot9n0IQJ2YHe9nEOCxzPbCihHmChFsOjfQbu7JAjN6wilZvi+DLRyxfoR6GjZUOayi6mP2MrkvqyUpAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vKltWQZdPDtv22DQZoih+Ht5zrPh5FBEibnM9yup3g=;
 b=p+8wpdSQ8+R7gU+CQLpcSYHyBpyP6qarr1+u4d8ocQubBjpRv4IZmlTjZTDQNdlUzCHFuv3jNduob6c3qlw1LvaZt5t4PPftHughErDJG5DDKcGUixRsWTe/avI1qy3RzBiBTyTnsEtyRjGko0adfBNUaggu3r3XZuY6i0gkWgE=
Received: from SA9PR10CA0008.namprd10.prod.outlook.com (2603:10b6:806:a7::13)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 08:16:01 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::94) by SA9PR10CA0008.outlook.office365.com
 (2603:10b6:806:a7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 08:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 08:16:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 03:15:58 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid
Date: Thu, 19 Mar 2026 04:15:41 -0400
Message-ID: <20260319081541.70848-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe5813c-3214-49f9-6200-08de858fc187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: inmWSpcKlatkrBkdRYdTD8TsFPzjGsrlZ8okpbgroa6VI/PcyVp9RyVotuGHa+ccdJ7UO7UdVN2FTMABlarYWrXfb+P0pxWrkeCbniQzBPm13yqkElGHfaTuHWte3xJVCkpC6gqmShVOwSqw+/h0Yc9TqSqb6Zi+Nrrir+Jpu8nekGxV7VbB8qDIlBZvSynuv9YRCeqWxt8zeGc84KwMrQJxgAI42+2souyJv3y69tULetBCW5RSsGpRcGvPU5UnpmyV45fuLp/2MX7+C/f2gLsZVlDFGlO0x8RWDfsq4OdK38RppP6AhuqPZGHeVrnahaO7+PpwusVvSeA0P8ffFp2vXyUrvZFFn5eKYHTy1N/9pdfGflt7hjnTrcooRUgSbsWUMgeeBrwBDsgO9kuyOJn1gPSuS20RzD5j7tBUltt2XKr/pocVevZzaPWMnBEDEkA+MSpYy8OFlTK5UGLUdl9D5RILe8/c/YjOjKW1zoCOMaT3FiiP2k44Sn4uEFFWQZ4AhnMtoeNQW3OsdoXHoyZeeh5kU9qkylZFvl9hkQTOgzC1FFll+djRp+ID0l2hFbk8Azpz/pZTF8qBrMTcUubes03gewBwzLFlHOv27VN8V4wLE3J7cy4IpFMCzs+EAlxx3sVA4e0LKmkNymPzy6rkax+PTZkAZ3s27NUaYuFX5lR9Mi7IPNZ+hKFK/7jPnDZLUxL9d7XPw0Tm0X2LfGO4SRxVXqwiHPQES308S4sbGDmEB8C5NXog559EHx2UR+U3ZNzgbTaQI3t/TS0M3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bj4vU0dhh6Fqzi2yWXR+D7l23ql3i76pM/0IXfqlMHykqyqO9YVSAx/wY/wqmvC+Nl2GfE9Vl+5ZSR3yvdRp4Z9OSX3WeFlYvsd459/ffryCPeJVtakqu9AUYcVQZDwpCzONt4AHcqTSCWmMCSNMhpWy1uO7TkIlxBBga1Q1FNTTbacq+BVk/syEOJZRCVbi/bqmtAQAGlyx0CNImxBrLw8h3tcUXaok/iJwlWN602xl/KfVTAB6ieyJQHPY8w07XGZ/MHOYHA0Z6WEqK0KokwXsNWvkqs3hfKPJfgpKAywNDhLqiQNRaSDyK4TnPAv6inRflStSvbZQ/FVpnw23GCiS65V/9aZyBo6p5/RQSFCWHkSUgssMk6t9Aa7Tm1+ozbZ7zWVLGeMxRXyoBviUegaeuxLVrJiawqVoQSvawoHRQtH+7ki7CK3nwYHhEo8F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:16:00.6263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe5813c-3214-49f9-6200-08de858fc187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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
otherwise PMFW will reject this configuration on smu v14.0.2/14.0.3.

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
[  969.761627] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!
[ 1010.897800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0b78e62cd3b0..8ab99a8e2790 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -56,6 +56,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
 		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
@@ -928,8 +932,35 @@ static bool smu_v14_0_2_is_od_feature_supported(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	int32_t min_value, max_value;
+	bool feature_enabled;
 
-	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+	switch (od_feature_bit) {
+	case OD_FAN_CURVE:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		if (feature_enabled) {
+			smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_TEMP,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+
+			smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_PWM,
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
 
 static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
-- 
2.47.3

