Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532ADC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF8510E2D2;
	Tue,  8 Feb 2022 03:20:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9D610E259
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 03:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoAnG3eO7BLkYBEdJtKP9ml249XcJLkeXULcTTILOfjcRyhro65+qYVq9lFpGjTN6sC38bPfuiahJ+ifpWJADcdq+ji+Ga2rySF82PMafQfhczzptlJXYH86be7AM9OVERdyUDaETR2SXxKU1lL1FhbsZi9dQLb1hzG2YA6JQ0adL9APwN36BR8+E+SjFB0mXA9OxWKw26/4Rf7vO7+VZvRa3s4ZvRbT9fZspBHP4gGHls7IjaFOIeLFKmdt2rkzOXtN9PAZm6hp9bKO9VTE906gjXjRrNQdmwwqDM+UWc8azBJ/Kxf3umQ2dQTmPjiTHuGAcU9Y3mh3wqiQ/C4eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbquW0u7F6Hz0TiycveTfpo6aDB5IihUx1Xeb1bqPRY=;
 b=U9ifFBkxncJr1RgYxPxe+NgixnmJgq6AOIQLmCjh0rrzGDBBtOQAVtV1/71IRm+QLZQS9Hk9JN51C6LULoKtauzPkf8Hw/JAd3KvRWms8ZddYErgD3VA6B3yIJJeosdfBZXICRcHgszEneg1sfnQXdgYJy3U6zwwiskB1llfnGY6FvgZhqB4uogix8Qr1VwIl/jZeBAsVvxRpIvagQJbu+DPHC0BUAzeIJmoB7SqboqnkP6es5z/w1Eg5V6uw00bSzwa//DdId9MNSuizWFvniveFR0b0AIEwZnzVo03v9mTWO60d5Z5+7n5l25funmM0ay2SnG0M8bgX8p5E6lHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbquW0u7F6Hz0TiycveTfpo6aDB5IihUx1Xeb1bqPRY=;
 b=tRtG6m0z7hwicmzLVM4rRsT2ua9xPiSPydzmLcfbcjHWIokY4hxWALT8WI5PeIdA5kOtvG43Rye99f4dq0hYecK5wJTsBKIK9kmENjdghrpYnx+5Ezhj4VD8zgICcviHUMz1DifbBoXhU8Xqu2rEcjWpf3t0i61suZxNiYtyIss=
Received: from DM5PR18CA0096.namprd18.prod.outlook.com (2603:10b6:3:3::34) by
 MWHPR1201MB2542.namprd12.prod.outlook.com (2603:10b6:300:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 03:20:36 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::23) by DM5PR18CA0096.outlook.office365.com
 (2603:10b6:3:3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 03:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 03:20:35 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 21:20:33 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/pm: correct the default DriverSmuConfig table
 settings
Date: Tue, 8 Feb 2022 11:20:05 +0800
Message-ID: <20220208032009.763982-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220208032009.763982-1-evan.quan@amd.com>
References: <20220208032009.763982-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f682ae-cc3a-4831-d5aa-08d9eab1f8f6
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2542:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2542A6BEEAB8006FD68108ACE42D9@MWHPR1201MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBnbgYEzZKiMKTD2esZ40HGDs3bubwVeZd7V6LhHOw1EZQiZGnTlpmVL+xXy5Od/a4j3QZq19b4+6I52DAeE5h82gomyal40hyljOFX9AHXc71lBzFkdVQjMH4rmryOQXK0XV4AnY2cvdmOLrIrewsoO8Va4Qn2LkZM3GNqXtFoK4nUTmqQHDQYe/L2EjBTfb+wwwjFdbtsL+ofIe1OUYd+JCpioT1JjkFf03tUrtaYkOFUYBP+SSHDdXTxFkPZUqSJlYGhzNKr/Eg5Y+yEIwvHGKKX5OILZuvCa9UDKTajaNTC+TBPN0CE2A1ViWjbTO7SQYFAaXy/VWUpmx1qIkM+5EwMxRUBlL6zm5T2Q9Gz1qr/fy5TYt+6v6D3T+yn4spYuPjJ8Cb9Tbgk0CN3iTmMr1rm/WYnM9CjrulT+8lu9oq1n3L3V834JePvsyhDGXO2uqU9ucogSRtdf6JHXlkCy5+5qdlGFvetJirSrfGGQgZwEs75tFdZrIE2gh3/ATHh+fpJfGRc+N+SZ9lEAjfeO4uKzusUSe++A5B24acniyujVIEv0+ADU7jkd//e7kgryptbTkSOf4fTz+Llkx2VjRojaQgv0grr9dI4jr43iFx4T3faAzc5VCKMeSvmR5ZGsGziGwjmRtZuwiJBU9hi1cArMTamzRmTlgQByR9NgxL0hTo7zKbB0SB8piP4JMdpCLGAskrUcHavZFkbt8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(4326008)(8676002)(81166007)(8936002)(356005)(5660300002)(70206006)(70586007)(2906002)(6916009)(316002)(44832011)(86362001)(54906003)(336012)(47076005)(26005)(36756003)(2616005)(426003)(1076003)(82310400004)(6666004)(7696005)(36860700001)(83380400001)(16526019)(186003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:20:35.5579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f682ae-cc3a-4831-d5aa-08d9eab1f8f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Some ASICs, with the PMFW default settings, we may see the
power consumption reported via metrics table is "Very Erratic".
With the socket power alpha filter set as 10/100ms, we can correct
that issue.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia352579e1cc7a531cb1de5c835fe5bf132d5dd20
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 14 ++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 ++
 4 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ef44c8c3d616..d3424cc586aa 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -293,6 +293,18 @@ struct amdgpu_smu_i2c_bus {
 	struct mutex mutex;
 };
 
+struct config_table_setting
+{
+	uint16_t gfxclk_average_tau;
+	uint16_t socclk_average_tau;
+	uint16_t uclk_average_tau;
+	uint16_t gfx_activity_average_tau;
+	uint16_t mem_activity_average_tau;
+	uint16_t socket_power_average_tau;
+	uint16_t apu_socket_power_average_tau;
+	uint16_t fclk_average_tau;
+};
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -341,6 +353,8 @@ struct amdgpu_pm {
 
 	struct mutex            stable_pstate_ctx_lock;
 	struct amdgpu_ctx       *stable_pstate_ctx;
+
+	struct config_table_setting config_table;
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c6a42ac8ba78..9e1ea9d54f50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -601,6 +601,18 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_apply_default_config_table_settings(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	ret = smu_get_default_config_table_settings(smu,
+						    &adev->pm.config_table);
+	if (ret)
+		return ret;
+
+	return smu_set_config_table(smu, &adev->pm.config_table);
+}
 
 static int smu_late_init(void *handle)
 {
@@ -655,6 +667,12 @@ static int smu_late_init(void *handle)
 			smu->smu_dpm.dpm_level,
 			AMD_PP_TASK_COMPLETE_INIT);
 
+	ret = smu_apply_default_config_table_settings(smu);
+	if (ret && (ret != -EOPNOTSUPP)) {
+		dev_err(adev->dev, "Failed to apply default DriverSmuConfig settings!\n");
+		return ret;
+	}
+
 	smu_restore_dpm_user_profile(smu);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 51a32ac39990..f0894676b20e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1275,6 +1275,16 @@ struct pptable_funcs {
 	 * @stb_collect_info: Collects Smart Trace Buffers data.
 	 */
 	int (*stb_collect_info)(struct smu_context *smu, void *buf, uint32_t size);
+
+	/**
+	 * @get_default_config_table_settings: Get the ASIC default DriverSmuConfig table settings.
+	 */
+	int (*get_default_config_table_settings)(struct smu_context *smu, struct config_table_setting *table);
+
+	/**
+	 * @set_config_table: Apply the input DriverSmuConfig table settings.
+	 */
+	int (*set_config_table)(struct smu_context *smu, struct config_table_setting *table);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 48e80ec9b258..2d18b39d7c2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -92,6 +92,8 @@
 #define smu_gpo_control(smu, enablement)				smu_ppt_funcs(gpo_control, 0, smu, enablement)
 #define smu_set_fine_grain_gfx_freq_parameters(smu)					smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)
 #define smu_bump_power_profile_mode(smu, param, param_size)		smu_ppt_funcs(set_power_profile_mode, -EOPNOTSUPP, smu, param, param_size)
+#define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
+#define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
 
 #endif
 #endif
-- 
2.29.0

