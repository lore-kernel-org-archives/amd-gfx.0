Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BE0EE57D1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 06:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B0210E86B;
	Fri,  8 Sep 2023 06:34:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A205110E039
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 06:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ63XWxxZutsrkzD/XDCpQUvZU5cfT95Z5fMKRESVOd3Ig4nngSRktx22yewD0h7XPCI+RhAMUFbi540dI3HcF8iueW9eFaA/ziVnLUjFbk3AUat095QhmPr0qcek+uYDDPWwVoE1UWXOZ4CVfVKOMLOJuxM2KOpbnEpTTb+eAJzo1HUUddrqfT3gzjztGsBZubsdWjRIU5aWsbiXzu+eAgi75Fhj3HQW+R3OBVRwPPfsiweiJdimeTD27Lb1WkU5/aGx7FfKXQy0TkpwEFZj7g7QC1Erdrh5v9S2FUDj1Tt6AVQ85WqzGAgsiC9kplgqiYZyCEjofeZQfyOgEFP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xaovWheT+OThD3FW8pYlXj2ktTkwm7nN9Us5VjSlWQ=;
 b=R5BCiGiia8h4dyfyXS8VrrOXiRcEVWj84EElvrMWU6gdL9QAhyZ9cXLgQQOhWjGfumwyxA4ObP7A065T7n7hnV6ssOP8o7kWNN9TIosUsp6JD9HANCMEf9xgV1H6s9IqsiS/1dsxwbNiUIHLxU4pVXV1C3Uu1Feqq9Jd9j2pgGC83pZdm7iTxOBbPoeRtQLTIXSpP4A24SN057toGn9Ia3nRSY0Eq7XielVPxWYx0ws5HxiYlGLHA/ddEVlmyrT7uBzIRawv+GVtTzyHgLpcBnEuMtj72uQK9UAJjWE6TlUdgyPO7vQ74AQ2XIiCb0JEqAKbl2aVq5Q8JtoDp4k1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xaovWheT+OThD3FW8pYlXj2ktTkwm7nN9Us5VjSlWQ=;
 b=VKMf7guNUykoQ/RXR03QFzPcLV8TvHuAVSDTc6umTc4muar4Yom43uttyUQEyGX44YdkA2EOFardc3xYsB5xF0YZQvoV415yMWq6yUKegIMTk8eWPm5vAP8Adt0VwY4T1cOOZAn2eYq2Ml4aa8geGE/QJg7C8uT9P+2kgPq+leQ=
Received: from SN1PR12CA0072.namprd12.prod.outlook.com (2603:10b6:802:20::43)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 06:34:11 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::f1) by SN1PR12CA0072.outlook.office365.com
 (2603:10b6:802:20::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Fri, 8 Sep 2023 06:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 06:34:11 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 01:34:10 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode when UMC
 RAS feature is enabled
Date: Fri, 8 Sep 2023 14:33:54 +0800
Message-ID: <20230908063354.2478663-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908063354.2478663-1-kevinyang.wang@amd.com>
References: <20230908063354.2478663-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bc6ec8-575f-4c2e-447f-08dbb0359cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBJPdnUMvMD5vaX+XxzSSuzdidzParwAXAF381nsgxwGBXrwud5gBO7qLMFz0DnyueXwyCJLp79c2xllpO9YEOzei6C9a/wWH1dTQelBOo0VF29QsxPkOm3J+ICkcvA6qnJP9AH2EfrPcJE6bWo0417/uKm75QxRc4B6i4UaAGtrt9VQ2SILEUqkey+Lf4iTCFHOfeiatlTsDGITgQpCUFuHnFylogcdVFkLU3cBxqMBT608hr6p4B2UkJwb9usMqUdAefgZWfmaU4H+uhSTwHhfW9ER/MZ/uKQ1uR4L11qcMuybiybc5S/QBB+x+SyVoCAxLN+77DX6uzKIBgf5Np7aB3zR2UIV1b5e+RBsIbCJu1MAzTtmcS4v7jgR8oxLLuBloIlkLXyFDqy43VBR28hXgNs5WUy6HRhRN41TTZ53twOdC54vEAOFq/HPLXyNvWTwntItnqdq8rDj6SDzGCwclgyzK/1ITxJAht0AwIytsVDW0GiiyCNFPcfyA1PBC6fqGKZZd+4aGWu5Xsqy7jeFpfNhbHhO+5K1jIy7t1SSB/z5EdeZ6G858RfrHqfb+pvlSQ9nKDLyf6L7hF6+Jvp849ZjkxAfDLcIdPL2ugfH8Ii0FzRxKbpi9FDbz9aAWoy74BpjnI5Oy4pztmHq3g2Q/21ALICkSyR/D8GGx2joaJC+E0vFF4DIG/dOA9d9D+o+4xSf5BlcN4B4MwFIyysQlnLo/j/IjP3x8DzWrt68QOthhO5hT79FyLvYDm0ocGfo013usbxnIjBK89KRZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(7696005)(6666004)(478600001)(1076003)(83380400001)(2616005)(26005)(426003)(16526019)(336012)(70586007)(2906002)(6916009)(54906003)(41300700001)(316002)(8936002)(4326008)(5660300002)(8676002)(40460700003)(40480700001)(47076005)(36860700001)(36756003)(86362001)(356005)(81166007)(70206006)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:34:11.5179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bc6ec8-575f-4c2e-447f-08dbb0359cf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable smu_v13_0_6 mca debug mode when UMC RAS feature is enabled.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 26 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index ebc789e7a289..f762c01b98a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -247,7 +247,8 @@
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
 	__SMU_DUMMY_MAP(GetMetricsTable), \
-	__SMU_DUMMY_MAP(DALNotPresent),
+	__SMU_DUMMY_MAP(DALNotPresent), \
+	__SMU_DUMMY_MAP(ClearMcaOnRead),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ff58ee14a68f..5ecc90e6af10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -133,6 +133,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
 	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
 	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
+	MSG_MAP(ClearMcaOnRead,	                     PPSMC_MSG_ClearMcaOnRead,                  0),
 };
 
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
@@ -1393,6 +1394,20 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
+{
+	uint32_t smu_version;
+
+	/* NOTE: this ClearMcaOnRead message is only supported for smu version 85.72.0 or higher */
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version < 0x554800)
+		return 0;
+
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
+					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
+					       NULL);
+}
+
 static int smu_v13_0_6_system_features_control(struct smu_context *smu,
 					       bool enable)
 {
@@ -2182,6 +2197,16 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_6_post_init(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!amdgpu_sriov_vf(adev) && (adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)))
+		return smu_v13_0_6_mca_set_debug_mode(smu, true);
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -2235,6 +2260,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
+	.post_init = smu_v13_0_6_post_init,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

