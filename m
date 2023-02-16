Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDDC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AF710E317;
	Thu, 16 Feb 2023 07:17:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F9B10E317
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiY8TC4d2ZNG5NRJRRId6EGKBA1Zs0z4EmqY3zY/64BdvpYGm2D53gtofaqw6tNYla81b1LylOIpxLq0mzGqhI2COMtMaag6jBgwvKvaEEPBCH+UKwQj497jWm/lcrqmtFkkhj5CWFOawpEkCRafBOV56sFTEpyCKYtz84MOdIQHplQn16bI6kOigby+5nCDX90ptni0ieBA2QMSxVSsBPw6GuguXHz8qI2BViVCffboFW4PMNffJkjrhpW17C4vKI1Ns+rjqa7feucKdmaNFA3hPhBj4FJ3m1xE1rkWPyj3KNA2/MqXElu9UF4VvR0TtnW7HthOOA16RHBvxs5alA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paOX+fXXDMFVu7oiV2T6Un4X3MkcE689iWIP9btbDtE=;
 b=GOk6rohgQ1ubfakXQUhN7154bAiPUxq5MaZenMJWCaxL80dQOOJf1NdTp1lWO+3RraEZgA7rwmdHgjk4T8LQcQxWgaLmdW3zCRdGq2vdZZkHWZkIWslpvooj6NBBLKVtkfWVe3YaYLek8muWoC67KPjUt/dtZyyjNjtv9p/EzoU5LiGBntpAuoZkmW8Hv0g9HCBF9rHZWkQc83ToWoug6GAvS05NCjj0N/MMHacHhUCQWCOl+Ag4fv8Vgi1Hcp99GOoZhmaG1b4m5Xq8abGTb50KLMbBxdGdh1N1xFzud1gepbdvaiS/6Y3BapIUGDq9gueqXRJfhM5P9YvIL7Jejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paOX+fXXDMFVu7oiV2T6Un4X3MkcE689iWIP9btbDtE=;
 b=AichEtvGcltyIFysm+aJm+AZj2QZW2HJ+Au7DG43t8yR0AfScxNQC723GoaRK8Hx44Y8yCtQ9zeZxmn11+SaqTYuq3SW0TbBQ4lCyIDlbNntXuKYiq772Hxf1Z6xsZmaIYJU+eS44FDx0eKPTXfVr2jVXHeRelxo9R+cu0i+prk=
Received: from BN8PR15CA0054.namprd15.prod.outlook.com (2603:10b6:408:80::31)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 07:17:55 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::99) by BN8PR15CA0054.outlook.office365.com
 (2603:10b6:408:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 07:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Thu, 16 Feb 2023 07:17:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 01:17:54 -0600
Received: from vads-PC.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 16 Feb 2023 01:17:52 -0600
From: kunliu13 <Kun.Liu2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Evan.Quan@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: added a sysfs interface for thermal throttling
Date: Thu, 16 Feb 2023 15:17:51 +0800
Message-ID: <20230216071751.200749-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 56048724-6917-4281-39cf-08db0fedec72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3ZKFHOcz4QdsRR9Nc/BJ9oxoUVcYKnk3J8LgIipl3GQh0FhCfHTzyWMTll9BdtTj2KMhnHIx1/eI9xq1O6C+DsleH7/4gBsf3i1C7mShSancGoHNG4+z8V28yw5hPhp+FQ1rFE/ShyZe8+zpddscHBmT4NR1eEHh9YOMF4j0Po7XiEimRmwF8hBRN+3w40JT7wAYkzO6I0HnyJ39KJr7yQBBLRsbvmpTLgIYE7W1wC2WEW3Quz6N0dlpf52Cbs5O6hBemATYbdl9r52jJpN2ZAovA5FnTDhjTAHjt0GMgBRIIfxu+yQylVbhbyjGhxo1lMzBc3OTEihRc7J8GvolLc8hVurdWGY8Bye0rty4vNhrl7SXLUVvIQ+I7/mseWJcoZbGt4zw7Y36xr/9ni4Mb1bRdqCxheTTfRtMjxyayaGzhmCZlLwTg/54eGHDcyTHrzEu2eOh0nj0E4Lv17FHXSoeDa/GR95XL2JTL+S/ECS6adAPQUnjSyo6dyXu/0ft32b+KCpUUG7AZzX/Lv76oaC90mVg2UclzF7LLjTM+62LAvQfyCCnfd6odTHzM+GMPnh17V5hQB/j0PH4ubrwxQIypCHWPns5Q5sYPkbiZa8tJkvWGYetS9kedKq56yvwhjbLrQqxg4OjHWgwugFoc8t0jDZOcVeMAOOrYAsIOqi9Ri6DQeLBTGoE3/kCtOdIbxac+obi55GwP3rPs8At+50Qll5YP2T+ZZ6vt3X5e0rYeHPCuZQd4Sp7nCb2R1iJWOlayKGdCmVlXzYjgdXu4QVyRnf7nCK9npLB4wiTLg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(81166007)(36756003)(5660300002)(8936002)(478600001)(41300700001)(2616005)(2906002)(356005)(26005)(186003)(1076003)(40480700001)(40460700003)(83380400001)(86362001)(316002)(70206006)(8676002)(4326008)(54906003)(7696005)(6636002)(110136005)(70586007)(82310400005)(47076005)(336012)(426003)(43062005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:17:55.1163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56048724-6917-4281-39cf-08db0fedec72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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
Cc: Guchun.Chen@amd.com, Xiaojian.Du@amd.com, Perry.Yuan@amd.com,
 Alexander.Deucher@amd.com, Richardqi.Liang@amd.com,
 kunliu13 <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

implement apu_thermal_cap r/w callback for vangogh

Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cb10c7e31..016d5621e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1590,6 +1590,21 @@ static int vangogh_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limit)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_GetThermalLimit,
+					      0, limit);
+}
+
+int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_SetReducedThermalLimit,
+					      limit, NULL);
+}
+
+
 static int vangogh_set_watermarks_table(struct smu_context *smu,
 				       struct pp_smu_wm_range_sets *clock_ranges)
 {
@@ -2425,6 +2440,8 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
 	.is_dpm_running = vangogh_is_dpm_running,
 	.read_sensor = vangogh_read_sensor,
+	.get_apu_thermal_limit = vangogh_get_apu_thermal_limit,
+	.set_apu_thermal_limit = vangogh_set_apu_thermal_limit,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_watermarks_table = vangogh_set_watermarks_table,
-- 
2.25.1

