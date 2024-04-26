Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6F9C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 07:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557B410FA85;
	Fri, 26 Apr 2024 07:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3npQnBgs";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B766310FA85
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 07:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwToeunsfzuQpEB2KAntsuGhfnh8y/mPxyc/EaRt9rAp20adH0tGUs/Vt4seTrkasTWFpZaHxliPPiY+G6UyadcSzaAjIJO/npt3YVMLWvB8drdSdl+wOADW6CrYbohp4e+JMNn5rvApH0keTbwFWCWUOr6QHzruvi2espXwtF3Fb3gq0He+oQW5ObHm2rjDlpIT5HNGocfAgBgH3pesxLNeuI5Wk/9ri0L4lzmo07r3TClX6gUrTYcR3LD4/NZYVYgM0U8I8heK3bt9/wiH5lWUa848vE8Rb3uw8NwohdpZIAMfZo0BMNTIhe8zlWdVmDszDg+oyUP2vKF30rFeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4coR2iHXCBYBLL5mbvlYynF1QCIcZlCdEoZQn6iS2CQ=;
 b=mOPI/6XEmbzm/HvxZsNzjF7HttbX3Rdl8QuoQTsuZiWs8g6s2OoA9a5NCJuNwKDPBikMrr6+WDtrqz7Cirm94+SvPd8NS6qxAAlBf0QI0BXBL3zfHkfpKR+e9OHGmXyweIpyh3e4IY2GKuwmvH/xXEVcrSDoY0z3SVxpIjc84nzc23XeO8Y1sbJq8gz8sxjT3Z3FLGlzfUEY4cqU7ztfMj4Ue0dHyq7gT9FnRFSvzCGBxcv+7qMS2d+LAf2qRvcKS0gHP+nl6m/aC4dFN6YdrEVb4BB5Xt/R1K4mfhVO+XUR2JT6nHE4F3Xwh1gUwvcvTAm3PF5cXrkQXTWrgBn3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4coR2iHXCBYBLL5mbvlYynF1QCIcZlCdEoZQn6iS2CQ=;
 b=3npQnBgsGxwRkHouYu2fut7gA9WGSU9LOUT6siipoLnTvqF4IPLGE8m1m329QxFuv0W2vGZ4sis7xgs6or8YANR+uxpfhakrCyIEVw2b5VsRLm58rLTcLHjbYIxcW3iyW8FQ+9Xz5NxGcntKkd0ntDaslHvE44WcZKfYUi8AkC4=
Received: from BN8PR12CA0009.namprd12.prod.outlook.com (2603:10b6:408:60::22)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.49; Fri, 26 Apr
 2024 07:28:19 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::76) by BN8PR12CA0009.outlook.office365.com
 (2603:10b6:408:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Fri, 26 Apr 2024 07:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 07:28:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 02:28:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 02:28:17 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 02:28:11 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Fix negative array index read warning for
 pptable->DpmDescriptor
Date: Fri, 26 Apr 2024 15:28:05 +0800
Message-ID: <20240426072805.1041943-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fedccb5-7d8a-4ab6-6ded-08dc65c271ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MStiOFROQ0prSFNFcUNXa2ZmUmlBRk9uUVRxTzdmOXZyd3NBUjJ4OXh3YktC?=
 =?utf-8?B?Z2JGeVlIVklOMEJkN2NwY0x0Z2VpTU4wbmJValc0RHA5S1pQOGJUK3VuVnZC?=
 =?utf-8?B?R3BQTjQ2U05LeHhGS2NVcW5iOXFYZ2FyZmVCWjF0YnhROGVCRkZqc0FoZ3hF?=
 =?utf-8?B?YnFxNDBHdW9SZmpWTktGajFkVXVUYUpBU1M3TjBCbDgrc0Q1bWJNajNWZUdQ?=
 =?utf-8?B?OEVqQ0Rud0ZsS3ZCWHorTnIwUk1pcndJQnFwY1VQdUE2NTlSOC9RcU44a0pV?=
 =?utf-8?B?VnhYZkdWQnhFY2VDcjQ2b0xFQWdkL1VjOGI1czlBV1RqNHFvK3c4OFdGeTdG?=
 =?utf-8?B?WHBFd1hFMS80T2pWSXpncm56R3g5N0pCV0poTGlRQ1dxZWFwK1BqM3hNbFlR?=
 =?utf-8?B?SU1FQUVkVm8xUHRrUGVXdWRHdnRIaUpJL3l1anF0UmdjNWoxZzI3QzhPTDB5?=
 =?utf-8?B?RVhnazdwUXhpcloxdjFmLzM2a1RSa25UQjhOV2hFV1RFYzZ0REIxMmNlelU4?=
 =?utf-8?B?ZlVtbjBUWi90eGJ4bGk4SzhFL21ick5lMjI5S1pqMXJvOUdkT29PVHU2S2Jk?=
 =?utf-8?B?SFVBcFlCSUFrMG1adlErUVpwZHYvMGRZRXNHR2xGK21CaURaVjFUNFRnb2VJ?=
 =?utf-8?B?b3pyVXhVcFBKVjdQbVgwUXVna2tqbGN3Z3U2aDFxVnd0R241MjhiSSt2c1Fn?=
 =?utf-8?B?d21qSDJTSnh0WDc1VFMxV3ZBdU4xa0RwbTdSWVBaQlArbFcwSzRtckVZYVVQ?=
 =?utf-8?B?NWhTZjFkSDZtakRzUEhjS2YrWWpNajJLMUdBRFlZOG8rU0duYm1ia1BvZHAy?=
 =?utf-8?B?Sk05UkxlSnI2MElpelltY2tEMEx4MXRqYmNDRFY2c05teFdQRzJwL2ZERzZw?=
 =?utf-8?B?MG44ejRORkdPeGFCMllPbFhzcWFNY2Z3cUdJc2VEUXBjVHNjV2c2UDBBZENx?=
 =?utf-8?B?K1IxakxDN0drTVZiRG9JcHZaNitFNG9Sb0YrS3Qyb0pZVHd2dHhGVEtjVHJT?=
 =?utf-8?B?Y0hQaWUvZ2UwRHpsTVlwVDdJMFpIeGszL0p3Z3JvQ2xhOTFhd2dQcHhvaVFD?=
 =?utf-8?B?ZUlXc1ZCT3Z0blh0UFhEOVgvOUh3Z1JHRTVobzZtdFFCcy9lcHFKZUlCaG1z?=
 =?utf-8?B?T1Z2bzJTTFRrWDYwdndsMXR6M1JnZFdJYkU4SUVGZnVZdWZJUERsY0FuOTdU?=
 =?utf-8?B?djRlam8zbFRHWHRsbFB2SG5aa29wZzhXOW9FN1ZzUlNSU0VpV0dYRC9QY1FD?=
 =?utf-8?B?M21QdWY1U3BNMjl3dDdUaHMvZERHT3FkSjRhN3pMcDQyVkxXckNtRWpFclhm?=
 =?utf-8?B?RGw1bVdibTRpYTNlbDhIWGhDZjNJYTFLOGpmeWZZNHJVdkFmckFkM3htRTRS?=
 =?utf-8?B?YUtCWVpGN1ByeldINS96OTZSc2ZNd2R3VGg4eFV4NXJreXA2YnFBRWtsVlNs?=
 =?utf-8?B?c3JGZnFmdHZFZTZRd0VrSWF0cFl3c2JKOFVoVjNzRnZTQXUwOXJnMi9SUWQ2?=
 =?utf-8?B?VmNvVlVpZFZLRkZBb1RrR1p3RERvVk1lS00zanJ0Q2lTWmpWZEY5eUphSDl1?=
 =?utf-8?B?TTRTRmU3aExOSEdHeHdYQ2dMaEo3WW54RHE0ZEoyb25sZGR6SGJ5Z3ZubmpY?=
 =?utf-8?B?YnNyMVl5MENaNG9seG90c2oxWGFib1FtdkJOcEZudEtiMGRSMlBZeWRjSmky?=
 =?utf-8?B?U3c2OGFQNDl5OXJkc1JmWWJ2ekpYWWtVU1dLRFZ1QlRiMEVZWVFHTXplUzdi?=
 =?utf-8?B?M2xXTmJvdGZKSkNTTnEyYkErdHJRbEVrZWgrTVQyaWNTL0J2d25tMUd6ZTlR?=
 =?utf-8?Q?RRm7jiUuY6Mj8hKdROYY4UQCytXMev3otUXx0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:28:18.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fedccb5-7d8a-4ab6-6ded-08dc65c271ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
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

Avoid using the negative values 
for clk_idex as an index into an array pptable->DpmDescriptor.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5a68d365967f..cd88d2c3841a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1219,15 +1219,18 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static int navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
-	uint32_t clk_index = 0;
+	int clk_index = 0;
 
 	clk_index = smu_cmn_to_asic_specific_index(smu,
 						   CMN2ASIC_MAPPING_CLK,
 						   clk_type);
+	if(clk_index)
+		return clk_index;
+
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
@@ -1287,7 +1290,11 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu,
 								      clk_type, i, &value);
@@ -1496,7 +1503,11 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1665,7 +1676,11 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (ret) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
-- 
2.25.1

