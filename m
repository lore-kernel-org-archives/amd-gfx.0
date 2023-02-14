Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD8C05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 08:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F8D10E801;
	Tue, 14 Feb 2023 08:03:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC5B10E807
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 08:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMlzIB8KNhZ0nB6uOBqDgkVPFy2oTVHRS1Y8QiqkKYAr4sDY7wC5LdSe1XLISzttZJS7lebIptXBYUCusdP/9Fo7foyf+td+0WWsM7q0zGxu5EsEK3yKmtLUQSgq3M36A71qCIM38iWwkT1wZI7+pB2E35Q9BY4aPb1GUftpF67hXCqLdHCnVgR5ZkjtmEWdjtKXvN3Nbc5f1yIlFxWAeY+zimU77wTOr1bSGqwtRw9JTMGK2pQ/teXaP6EaU9uYN0gJiMdM5zvQnqY12ytYjWFNUfCLTlXthR1EsjR/zqcEV6WM4WbtFZ5Y0ddTb72HFXtLP/zGrz3dkFvYC20Qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPiI40cKNOkdjuG1vvFEBtHDgtpL3xhKjX3Mwo5U/rk=;
 b=KuzFMI/AEYsaIp0FJ3MgCZXthvvMpCTRsqjmwNl6xs202eu+jKMvQuUAyykS/zcqfN4Ql/wNOcLv0krNaZ+sJq3+mL4eFaI3XYwzeofA0CSlxdzP8o8EF/hyJTAiWkPNBurB+2xXtRva7brbJ5YN9snmAwyHGEqWodMnL55OqtAJNl4ATRgDWGCT4WC/kOkCG/l9PsqOHcmh/pGTf2gC39hYE3jxbXbOjc6vwD4i5fGg6ojW/1uw8nY+6Ih8tDWvbT4v6I0fbZlQIBn5ssz7iw/xcY3nkzWWi0Caxyy1WwjY2slgj6lcCXFOopyheqC5DFdTCTbZlfyd16vshWLRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPiI40cKNOkdjuG1vvFEBtHDgtpL3xhKjX3Mwo5U/rk=;
 b=vK+ud2lHNj1fRyb3OjNuWZ7gxbiBF0TEaej3VChfoknliKFXrk+QkHSbOcpcvxxakDM9ZWThSx4gRSSjKXMtJ7H5ZAFcywvujsocDhwgl+s8NMmX4iZoMqUP+sCTA09x6V8gJ85Qz1acxA5fbfR0+Y2Yq7xA84bxEF4WSlS2XE8=
Received: from BN0PR04CA0125.namprd04.prod.outlook.com (2603:10b6:408:ed::10)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 08:02:58 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::63) by BN0PR04CA0125.outlook.office365.com
 (2603:10b6:408:ed::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 08:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.26 via Frontend Transport; Tue, 14 Feb 2023 08:02:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 02:02:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 02:02:58 -0600
Received: from vads-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 14 Feb 2023 02:02:56 -0600
From: kunliu13 <Kun.Liu2@amd.com>
To: <Mario.Limonciello@amd.com>, <Richardqi.Liang@amd.com>,
 <Perry.Yuan@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: added a sysfs interface for thermal throttling
Date: Tue, 14 Feb 2023 16:02:55 +0800
Message-ID: <20230214080255.31493-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BL0PR12MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: c3662d3a-821b-4b82-a9c8-08db0e61e325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEqoSNwtQShu2wVCCPO8KuiQosaJLatsdnFbhOPiHbWMKhFVVPkwRJ/tZ1uORduLpRKXjro1+XGnpCG5XKnDzjylAdTMel9S4AYSTVRqNrSXpfGxn8seZTeIi0yPtGz9/YMriqq5nzaXN0VxphZ2BxMhw0pTlRpB+k42YPEL8hDUSx0hgXTlG8mLc/sBXYDuwd10M/b1k3a58+rJNutDbT3PIbUF22SaHbXpOP3TMfDZ0WZfIasrev6m07l8SDp5In2XGgzxMCTm6RRAXh1NFLrLJyrlWsQCF+q5MDYBqfhupREkCzCcGW/vivQjchofSdbyNnUrqHif4o6ybLEF9s/+/nklh1Tj1D0ZBYL7sEsPb0GS5LJpIW8NxKPkN4khYh5C9YxjF4A13BD1ZCuXmCJpgPhLNUbXYD6A/Ydf5DvQvue9mwrKNdfUpMyJHNkojRWOl7sqSqAT3XU6iCHuJZbRypdZtYmuIj7ZR26I9M0B2mQ7cfjFed+uQ8XyUXK0jGrpSYxP8O4ymgTrr1i7dVHXe88aq10kHUrD4omv++MSrS+GfLhizePs8SJ2PktN0DnpveX2Fei/KurpUqdX8vxFycYI4D8pikjkcTwOV2aIRuL1aGtbf4N1pEkqh4RPZoSBbkm0RpOGLrdBWHjoJ8enYrTwh9rjNRfoperrX7b8TiWXszCUPW1x9P2WxCVB9IqRvLYvMdwp3BbT2GMFz0ivVd9GfBdAz44FgKG0xAw0Pa/PmCByLULt6zYB4YHPylRRiH7FTl18y24aA4qc/rtZDQtRn2LECO4nshDKCSQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(83380400001)(47076005)(26005)(186003)(426003)(36756003)(2906002)(1076003)(110136005)(86362001)(82310400005)(478600001)(41300700001)(7696005)(82740400003)(81166007)(336012)(356005)(36860700001)(40480700001)(2616005)(8936002)(54906003)(316002)(8676002)(4326008)(70586007)(70206006)(43062005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 08:02:58.8257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3662d3a-821b-4b82-a9c8-08db0e61e325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, Xiaojian.Du@amd.com,
 kunliu13 <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

implement apu_thermal_cap r/w callback for vangogh

Jira ID: SWDEV-354511
Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cb10c7e31..d211b1dfe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1590,6 +1590,27 @@ static int vangogh_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limit)
+{
+	int ret = -EINVAL;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_GetThermalLimit,
+					      0, limit);
+	return ret;
+}
+
+int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
+{
+	int ret = -EINVAL;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_SetReducedThermalLimit,
+					      limit, NULL);
+	return ret;
+}
+
+
 static int vangogh_set_watermarks_table(struct smu_context *smu,
 				       struct pp_smu_wm_range_sets *clock_ranges)
 {
@@ -2425,6 +2446,8 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
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

