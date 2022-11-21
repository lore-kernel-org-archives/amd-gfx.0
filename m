Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB85C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 01:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4333410E0D0;
	Mon, 21 Nov 2022 01:45:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39D510E0D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 01:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTESHHGsHcg4MsDIati5xxZL3Yk+YoZ9MQiDqj400Rewmu6tIWdoL+NZuuqSdI/WwHPOfZZVQUw2AqjVTaOYZP+VcJOoZ8PpJQ+8XzvQ3Ppwp9q3rJxilZk+WYWG/phoH4xnci6rjfK5JQvJ6zR7kcm0gHWbV0sX3oX+3ZhkIB1swmi7cLW85t5aZGhGbUql8O7rbl1ReMbmRLzMq27fWMQjP8S24TUotoelsY/zLN0g8F9djf/V3TQbg+EpF215v1IopMMZQysE7JlQE3dd64VLCzilMgJm+yKjn6LV3ErFXMReqwIfGRckMduVcwyeDAayCHV+sZnu7LmH2k9DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnP6fYeLLZ4iJD+HpQOxuXttZum1wlSI9uY/VtfD4ag=;
 b=aDaGCfyCLr8TeOuqFx04X1NvDwcSyjWQ2Hbcob4c+MiZ6OSgOy9S2i20thOjxFyZpsLqoEFghQ5HplnXd+4S/PQzawPmcsYDxKE+LXSDDQd/ufKMnKJXZUhWmNOYDhNbheVh7zYE7rPZhodhD6JvmGBuS1Auy8Ffyi3NEW5t5BKyAbQCkv5Ci8eeETEpHuRzWqAUChohU4i316nkFKt0kjiTrwViYM39LnF0HbHh9TSNYV1Nnx8jXVNvErLB03iRa/YF19N1RAU5boAXBC7V/abset1EXQflW0zzOlLm6/9minzJRirU2AvWvMi/1SlyWW5UrFPOo8fVJZ1IpEIr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnP6fYeLLZ4iJD+HpQOxuXttZum1wlSI9uY/VtfD4ag=;
 b=sRYHZvZEChOviQiFQJJBEK7lAFxKWAyJFtVwDxLCRhTlb9mhrasZ0MAFgyZPB4Isw/TxbfJRqUDwkQk8WQh/y2YQaFMxO/V4tS4k/B7MNk7cnHLgyO3AEgrxJat/QyHS/ExVKInRCrpJO77YLi1Bw9js5ilweXCa8gdKL9pkTPA=
Received: from DS7PR05CA0055.namprd05.prod.outlook.com (2603:10b6:8:2f::15) by
 MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 01:45:14 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::97) by DS7PR05CA0055.outlook.office365.com
 (2603:10b6:8:2f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Mon, 21 Nov 2022 01:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 01:45:13 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 20 Nov
 2022 19:45:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 20 Nov
 2022 17:44:41 -0800
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sun, 20 Nov 2022 19:44:40 -0600
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add the fan abnormal detection feature
Date: Mon, 21 Nov 2022 09:44:39 +0800
Message-ID: <20221121014439.2101162-1-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: bec46f3d-b44b-4a89-65f0-08dacb6208b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJH9sNLWVxc1uze/5CJ7NPt1mw7UBz23aGleBV5VuPp+82a7TyPaYWROTdixvDZaPHYuWd/zExyA9nlcKFiOZt2l7mkWg/V2JHl7mP+K1l/6Bh4LHk0B0UASjAUCmDdXvVnDdgrLs4qTNT4wuiFPxUXOsmix9rDIP9AOq+PKYQbfBhq6MTsFimX2wt65h144gJDKDNmyExHHQqG1p037psHVN5nFvafU93Z9ogbL+sqrx87P6rzWRSrr2T0Oj4Fv/0Blx7wf089YpKLdsUD/xC7X5i/3iIJBNRjo6G3MKsfI2wagidsZW6xWNBBMAQAYmvl4PkxKiNcr2w4l9DL/YqsTuy2A3wSut89Z73fWMiw/jhih3+CUejM5l2d2pBggEQvW0SS9vo7WLqdy2KUGvcePrkvyetwbXu9TUsdT+jggnpyRmpXBc0AcGjtS5qmpZGKtqxgjtve4w5i33fsB428/mv6u3L7cw/YBfsM5WRhkXumhWKK0Y+XNDHhutl7Xz4zdtdqIaF+l159/+EICjw7JfPzRaOVorUdl9WUCyq7O3Sq/RFpOIYjGpwW5wRUzF7ZtM84Id8tjMdzYLk4BaSuffiYdt/4Goy6KdVJIIotK8P4ysnPk08eCs/TG2SCZ/1+0pTVqVYNQKWNxGFsYVfoQahPSIZFsZNI5zdbm0v2R8VgPgJ94n275LhcN1/qdkix5zPOWXbpT/99TphFKHRMbqPNEte9NOBTTkpmrwpwvjxEWd4wpOfyQVgx6YI5mabMN8coRKfI38tr12KWRkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(70586007)(8676002)(4326008)(70206006)(26005)(82740400003)(83380400001)(6916009)(7696005)(86362001)(316002)(336012)(40460700003)(5660300002)(54906003)(478600001)(41300700001)(40480700001)(2616005)(2906002)(186003)(47076005)(8936002)(82310400005)(426003)(1076003)(356005)(81166007)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 01:45:13.8970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec46f3d-b44b-4a89-65f0-08dacb6208b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: feifei.xu@amd.com, enneth.feng@amd.com, evan.quan@amd.com,
 lyndonli <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the SW CTF limit from existing register
when there's a fan failure detected via SMU interrupt.

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 28 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 44bbf17e4bef..3bc4128a22ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -168,6 +168,7 @@ struct smu_temperature_range {
 	int mem_crit_max;
 	int mem_emergency_max;
 	int software_shutdown_temp;
+	int software_shutdown_temp_offset;
 };
 
 struct smu_state_validation_block {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 89f0f6eb19f3..5a905002252d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1376,6 +1376,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 	 */
 	uint32_t ctxid = entry->src_data[0];
 	uint32_t data;
+	uint32_t high;
 
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
@@ -1432,6 +1433,33 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
+			case 0x8:
+				high = smu->thermal_range.software_shutdown_temp +
+					smu->thermal_range.software_shutdown_temp_offset;
+				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, high);
+				dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
+							high,
+							smu->thermal_range.software_shutdown_temp_offset);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
+			case 0x9:
+				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					smu->thermal_range.software_shutdown_temp);
+				dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d74debc584f8..c3c9ef523e59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1223,6 +1223,7 @@ static int smu_v13_0_7_get_thermal_temperature_range(struct smu_context *smu,
 	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->SkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }
-- 
2.25.1

