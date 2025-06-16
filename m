Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0121AC71159
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 05:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811AF10E297;
	Mon, 16 Jun 2025 05:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7OY57YI";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561AB10E297
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 05:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4tZp4tMYdziPXkra20e0dPhpKGZURuUebvsILLdibGt6UAAHLiwSeoVoULf1TektMOXgXPBg8XKd/1nskof84kSiwSBseNxxj7gfz4qgORA8ryEG+8Tp7H3kzrhnW6NqfyCjHHg4C997PB+sK+i6rc9TMPAB8GTMCF1KUCa5ywu5UBN7DUbSfaepVoLQkPSrEUz8OsbYX65bWK4NQKp9mR971P9Rn4NIB/5igUyPS7t/tdBsGk6xYIJIQfx+V3o7Uqd2yHLlcD5qTlOe92HUBD9G8dD1ZSODavF0G52va2HoBrA83z+e3ohROmJb3H32U868d9k8Oq9XIyZBUJz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZWia+1ddxbLUqBfttV0K6CuhWj259kYhS/WIyy2R80=;
 b=qzcJ1BYDgOxhhNvK1FrbhfXHRr3yVWO0zbhCaIfIQaaSPlS+bsDXjRgESQo1djFg131P3iFCO9hHDWDxc15XylFK4JZbOChcLTTOl6FuBPgMIwzhc0jFcB5abJe4MumXl0PkxbmXTKTBDzR9JSk/H/AN0pZsqReChe5NxqSTto5FAIE/+3CwdI2BICGsr381qcSO+nGmBM9Jnnr7IWPmGPquJ3m69Qyv3mCp1E+7wHfBiZWaPzfyFVghraR1/t8uyvKHRd96PWHo9GfuvOgM6/durEEO7vCwiNhq2GYY8/o7g45HwdihzGTXzvfVZD9yvBeAlXdq9ociGBQAHV9SPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZWia+1ddxbLUqBfttV0K6CuhWj259kYhS/WIyy2R80=;
 b=E7OY57YIiTweI4OFyj8oR4fUeewFl+femybnK14gkhrflE6llvTDaAFMG9CJJyYhurVjix9DrvGRfGgmW2+d6yx2umLyAL6WGZomdVJVRgWIdzTJOOWUY7kZL4RHTjAjwdoAv42BeXRC+5lNBPRgGQckm5lou5EzC5Ie8w9YmGM=
Received: from BLAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:208:335::23)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 05:39:11 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::99) by BLAPR05CA0043.outlook.office365.com
 (2603:10b6:208:335::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 05:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:39:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 00:39:08 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: Report pldm version and board voltage
Date: Mon, 16 Jun 2025 11:08:51 +0530
Message-ID: <20250616053851.868243-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616053851.868243-1-lijo.lazar@amd.com>
References: <20250616053851.868243-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: c958fbab-6ed9-476f-8b24-08ddac981eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ZkrR6gpNtc4oZeG7x3EIQfOtx3+a/c0UAUAEs9ezLf685G/LAAbofJv3s5b?=
 =?us-ascii?Q?f+xeNp8frpH/J9wwOzLJJNhsYaO3UY0BfF7zndnv3uGiITG5sARgF3L+9IuN?=
 =?us-ascii?Q?EE7spUVl9EzmCgUYHHzZE++iZ/BtHJApOxEWtTXz57SGkG0ebuT5yYjvQa7/?=
 =?us-ascii?Q?pq3UwoFFcNVzujKpEOBp36XONQnpM7amupUTItkFzO6CzNDrwUAVonVkZCtE?=
 =?us-ascii?Q?QZJvkSb8dP93F4v0Bi72zwHDgdFCZkcEvn9Rr0VkmWxwciddbyn/WPCsz7mq?=
 =?us-ascii?Q?p6LgHAEvMtf5b7fenTHyJQ+QWYEuES49+GsLC3/wf/vVrmgNbWDJGiSonDPE?=
 =?us-ascii?Q?1Ype4MHzxli8Wc6rTFUUpR+wac60T8s6LLcsuhezsX6tXD3HYNTu2FvUYFq8?=
 =?us-ascii?Q?V+LEgYThLQzNhKOCd21eeldIRbo5XslRFz9kxPJ7Txzen9le/7LUuff2CblM?=
 =?us-ascii?Q?N44b6I6tKZyGnQ1AhsrjSWA7fkERinI3p97YqB5+QGBKnQwUgwOmdLM+53Pf?=
 =?us-ascii?Q?qU7USjihk3ZbQ68KHRAejGjhvRapn9ls2R3NvuxTdyJG5mvZxa/DxlV51s/b?=
 =?us-ascii?Q?WNtKeXyXpbfbNY30SF39GtU5hVte+EaG4N1vhUHsL/hzmr80EY3MzyNfHaj2?=
 =?us-ascii?Q?1VkEmF3o10UeNOsHxTtW5JtFJWiw57O+IhlCXTsKkfe/BjfIOdtJvN1oAH+D?=
 =?us-ascii?Q?OEYPez4au4rFO49TB2sgSPOHv3jMFapGDMUWJ6Azp4Chl8TaK5Ez9kax5EGh?=
 =?us-ascii?Q?3a0LNhT1W6zCZBLkM+Vy5XoPtpmRExpzMAwqfGAz+Mm3/Kv7LlQL8+/TEtu8?=
 =?us-ascii?Q?ck7POTFpykwZeC5r1Okg7vMPrHYsNJ7fKfgrJBw36o4o4ZIuEgbFUq82Y3y7?=
 =?us-ascii?Q?OTnTUefuD+Z1QbeDnDk1qvxodtvN6SHrf86+WldgVd2FipJnHCBLoh+lrtXh?=
 =?us-ascii?Q?mZHCaj9OxoftW7N9gtF8NBbGRqObcnWoe1AcrEWfvZ0AT8EHrNZFHveiPmFw?=
 =?us-ascii?Q?5KNLCre8FQOp/s5DawDwn+0W/W78FrLNIzhoZ+F3KcFTTdgOwe4KOKmKD9EP?=
 =?us-ascii?Q?yfOuqZPGR6xgWnEzCyMfOX/ZBzRJwd9Zv0BE/uONlDpWq3q8PrbCHiPmXA7a?=
 =?us-ascii?Q?l80fAFB8J4SSoRQJ+XAAbyIo8RM6iB0OC+OWl695uBQEiTCdJHxwj1/KhLgu?=
 =?us-ascii?Q?pDXad7WWN8/yFjvLFY1qhP8BvfEHL8PeRpcUA6KrEnCPz/UWi0/9DP2mf7z2?=
 =?us-ascii?Q?vc9rEwqbDmgfQEZokQeZxZs+9IBQHzd2QzNe8su733VwPOFGGz3Kz7YMZTzZ?=
 =?us-ascii?Q?DP10GHWU5hyWrc7RbPGy3z9GdWojGrHpYnQI7N2psRFbiMeomJvjJ75vUb/w?=
 =?us-ascii?Q?uxs7LMgjcSMK4VqOVNRDrFf8767De2UEaCCiYRYXa5uSMs+p9/cl9F3oChce?=
 =?us-ascii?Q?eeKCozds/Ltp2OQAA136su1RJRydpo8u3BLl2/9O73//ZR+B9Bz/pOGV87uq?=
 =?us-ascii?Q?CNKsEJrzpKZ3hR2xCCzY42Qr/zWq3EI+zUqE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:39:10.5555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c958fbab-6ed9-476f-8b24-08ddac981eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

Add support to report PLDM firmware version and board voltage on SMU
v13.0.12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:  Use caps to fill in values instead of table version (Asad)

 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index e0d356f93ab0..99663165363e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -189,6 +189,7 @@ int smu_v13_0_12_get_max_metrics_size(void)
 
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 {
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
@@ -237,6 +238,17 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 		if (ret)
 			return ret;
 
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(BOARD_VOLTAGE))) {
+			if (!static_metrics->InputTelemetryVoltageInmV) {
+				dev_warn(smu->adev->dev, "Invalid board voltage %d\n",
+						static_metrics->InputTelemetryVoltageInmV);
+			}
+			dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
+		}
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PLDM_VERSION)) &&
+			static_metrics->pldmVersion[0] != 0xFFFFFFFF)
+			smu->adev->firmware.pldm_version =
+				static_metrics->pldmVersion[0];
 		pptable->Init = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 36f210698bea..44daea9a07fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -345,6 +345,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 
 	if (fw_ver >= 0x00562500)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
+
+	if (fw_ver >= 0x04560100) {
+		smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+		smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
+	}
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
-- 
2.25.1

