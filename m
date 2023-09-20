Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B833CE79BE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 10:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F248510E16D;
	Wed, 20 Sep 2023 10:40:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3D910E16D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 10:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0Y5c0l3kIFMZ/ey9OYzD2ofFjjDaHAK4qB4PKNAvA9LNjrJHMrGwCr/D8m+5DI3EvWM3Rlh/uigqtS+ZS3Fb+E+jbdThiPWqE1BYLSap1u/TUp1sMnRytyroBwEOCYX31nBnnOM1fiVc3OJfrOCeKm1Wf94q+oAnVCsHvWXOA1//khkwJdeVrVMpluyucf9MU5ZPudL8EFwUi+vgQRmPSisLAC+eeoYvNa28csD5fG8UpzMvmnMl6wZBAiRoG7nkyHz/iA9v8LqesmfFsVwgza/bKkaU/CDSiBcDtNUsBd7PuZZetSslUfsLXHFyOWOLI82e1oItoUDuZtN72wIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT5lIwNixBdU8NO2ni/Luoo73sCPl75woA2w/ogMov8=;
 b=CbQVvJW0umXc0CEoKfEJj5GKK13ZgC2VdQbliH9LSuDYVmKOukms4vkZrmvOg5qWWl+pcbTvr6dVtB700DZkD6iMJNI0T5ewAsHkGqlYNsRQeYoLG46Q9cZahkFsHJybrlrgL0yP3X33RJ0foIoruRcChHkR98SRuQGNTXa0NkDZRSZXRRz06jKCL3tJF5w1+07KTaOJEaYZfAvvW6ppto8BkR/H9rDSF2eSPJDN0ps1MZvHfOSykglVc+0o8DMsB6kc+kid65OBL8sLEKrtkaNwEn0x160GeESahH25iV9P5QklP484E5MF5Ujy0p1+EIkb4N+ckdvvyR0iKXI2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT5lIwNixBdU8NO2ni/Luoo73sCPl75woA2w/ogMov8=;
 b=VgVawT1BHFbHsMRbuTjgoSoxjkJbRLAUxf6/pw+bP0K+nDzrhwUiyXPS4Dtdr9KYxao36coQDe5Wx4EQsKqV/E2DVGNKNjfkuMpeK3R80tGRm4gtjD4RsYgCkcPHIu5mfSv6iziyvyJNm8wcJTlNPuvMp1PVAtktB2UgFlEIcH4=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 10:40:45 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::ed) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 10:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 10:40:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 05:40:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Add throttle limit for SMU v13.0.6
Date: Wed, 20 Sep 2023 16:10:26 +0530
Message-ID: <20230920104027.1295775-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6e45dc-e5c9-405b-f283-08dbb9c60b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/2Pkj9eSUc9zdcd8qlFCHESR3Wz073IzSm12nwTI6lPH74/DlM4LBNMfQmGI1h2xTNRg+2L49CROaxs89J9plmOs5kIKBhi3zEsk+vkUL4WoQCFOng16DwkMwKu8OJ+80OowfK9/Cv5zPyYZ+pWZz+DxuKoDTe0KVJiXXRp8yQSRexMCaBxoDrapjgPcD7YSLLDtH8Pp4OjwjI/TkkbCO5sDIBYc7ikzmtSDXai+y6nw3vyn3R6EQFqprJecX+I827tWcve2FArbRYo/pageGakDacXY8/gC6JR9rEQEV8vPbN3jCbwz4SWhSeQ5qwKaxVTh47zmQaKyHiCirSaXpLquO8TT5N7UxEWuhqmnt8nj7VRkSxKaPogZwOG9vp1SMu5a6AabZwYRr5BBEhaaNpTgB7LrZWzkTSJGq+C4qPS7LmYIL/ubtWC5a9KYx7Hz2ppJdzczMv5FhaH6qCLFfHryHby+5tYK2ZQL56cOe7gy55drPZUjLtKRpjEKVQuyzb1NY47Wdos6FaarWdM+LwMzO2pdpEwhjitXyLy9dHfvg4dGoYO+IqrdEC+50mvcWDB3GdgHsjiYOY4E3VaLkeMq0JaL+5qFLh03MqujXvHmcvRC5l1shlY7qHCXVcdvmER3c6SKVQpgi7SENRFdN/c5B5MUsgpuvnkfj4eYCcpq/COFGfD9CIXTZkOdg3cN0NzrWfNj7qMjMVxELQWM4qX6CQC2Dr+OLeo57+Cx89KTJv40/RlWPv1LQmkIV+6rLVQ8kxR8dw9TWGsB/1teg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(7696005)(6666004)(41300700001)(40460700003)(86362001)(81166007)(82740400003)(36860700001)(36756003)(40480700001)(356005)(16526019)(4326008)(336012)(47076005)(426003)(2906002)(2616005)(70206006)(478600001)(5660300002)(8936002)(44832011)(8676002)(70586007)(54906003)(26005)(316002)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:40:44.7781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6e45dc-e5c9-405b-f283-08dbb9c60b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CTF limit represents the max operating temperature and thermal limit
gives the limit at which throttling starts. Add support for both limits.
SOC and HBM may have different limit values.*_emergency_max gives  max
operating temperature and *_crit_max value represents throttle limit.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11a6cd96c601..73db595bf6d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -165,6 +165,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
 	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
 	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
+	MSG_MAP(GetThermalLimit,                     PPSMC_MSG_ReadThrottlerLimit,              0),
 	MSG_MAP(ClearMcaOnRead,	                     PPSMC_MSG_ClearMcaOnRead,                  0),
 	MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMcaCount,              0),
 	MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMcaCeCount,            0),
@@ -2110,7 +2111,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 						     struct smu_temperature_range *range)
 {
 	struct amdgpu_device *adev = smu->adev;
-	u32 aid_temp, xcd_temp, mem_temp;
+	u32 aid_temp, xcd_temp, max_temp;
 	uint32_t smu_version;
 	u32 ccd_temp = 0;
 	int ret;
@@ -2126,31 +2127,50 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 	if (smu_version < 0x554500)
 		return 0;
 
+	/* Get SOC Max operating temperature */
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
 					      PPSMC_AID_THM_TYPE, &aid_temp);
 	if (ret)
 		goto failed;
-
 	if (adev->flags & AMD_IS_APU) {
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
 						      PPSMC_CCD_THM_TYPE, &ccd_temp);
 		if (ret)
 			goto failed;
 	}
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
 					      PPSMC_XCD_THM_TYPE, &xcd_temp);
 	if (ret)
 		goto failed;
-
-	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp) *
+	range->hotspot_emergency_max = max3(aid_temp, xcd_temp, ccd_temp) *
 				       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+	/* Get HBM Max operating temperature */
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-					      PPSMC_HBM_THM_TYPE, &mem_temp);
+					      PPSMC_HBM_THM_TYPE, &max_temp);
 	if (ret)
 		goto failed;
+	range->mem_emergency_max =
+		max_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+	/* Get SOC thermal throttle limit */
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetThermalLimit,
+					      PPSMC_THROTTLING_LIMIT_TYPE_SOCKET,
+					      &max_temp);
+	if (ret)
+		goto failed;
+	range->hotspot_crit_max =
+		max_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+	/* Get HBM thermal throttle limit */
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetThermalLimit,
+					      PPSMC_THROTTLING_LIMIT_TYPE_HBM,
+					      &max_temp);
+	if (ret)
+		goto failed;
+
+	range->mem_crit_max = max_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
-	range->mem_crit_max = mem_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 failed:
 	return ret;
 }
-- 
2.25.1

