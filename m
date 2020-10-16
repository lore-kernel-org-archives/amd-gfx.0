Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E63C43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A4C206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="32vLx/ZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A4C206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22F26E9BE;
	Fri, 16 Oct 2020 03:28:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F4F6E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL2AJiBeew607RXwcpQE+ZoUhV0X532MjapAnRP3MqgN5me86nRiyXq1XnT110mHlU/K03PqXCrxEnMrobouETOS2cnNP6n1kf/4p2kKiCyuv4C8PMmk+Mi51zQMII42kjRR0VrBhJjR13aXQlhIUd29lLH8yTxtkSv2gJRlr4vkCPq+lcmdjn2fTl+qt0wrfMp9XDZYW0d581eZpO811xy+5JS7zGUAu66+GcMNoRirnKmnHZ2Mptnks6U8gT+lXXa23X6y7dWTX7A+HsNt4pqCwkqAbpPHw6e6+4miOu7r8Lw9t2wZOTwfI6DFGIJ0HA9/QsU7UZvZBbcCvuQnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW3eN59VRxnsE4+6OBJTTw9UTTrZXYmtcXS5SofTLV4=;
 b=Gbec+FW79b5UB5sEWl0gAIdKVl8TRFTgVtFQAxQYxM2F+EpkiGUbCWN8iGcBv/45fANXGxF407j1LzwdGZKs6lmxJwRMPo6TlbSqJTeFoETuj+fvJACJpy3K24Afq0j08jzUECbJGpBpSE3KtkHANI1QNe2yVZ+7P0xKdWN1iZGyaVLSU5dxuZSsDkLosPJeY80tRizzkLf3Bsq+GP/ojh0QJLI7Nw/NHRNAn50J5KcXIVkK0KQ7UzmVHv2v7qiPoxpFV6m00Cw5501BUuLBKT86jSVRQ1ESIU6pJV2x0WavPK5ArBqxhN9xypcR5b5Kmwe/m5KA1zW8wBN+pgqrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW3eN59VRxnsE4+6OBJTTw9UTTrZXYmtcXS5SofTLV4=;
 b=32vLx/ZBJcqbdd4NkIwdyRS6Vpfe0szxicDf7s6BH7YeHlZf+2puQfN+RqIWT16GLb6GVxLYJ/QWZxeWIilamMIQVOXTiqh0p61En7dR4S5wmornrIXzaoUbrCB1mdNltrFc5rk+s9W8kaOvUiC1TpjSdUVWqtH4HCw6DRuzslk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/40] drm/amd/pm: setup zero rpm parameters for polaris10
Date: Fri, 16 Oct 2020 11:26:30 +0800
Message-Id: <20201016032652.507-19-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d8d3040-7544-4518-3ce6-08d871837dff
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354A2AFF102A1EAC72CA332E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkpqqjUBdG3SbBRAytOfwIMjHK96j8wyNqweWmnZ+lzTdmWNXog6qe1CEfPL/P+xibOxPUcDbQ1Wk24ICUYAYSdUuFQfr02cQNfDv4gkMUbMQ6x3L+ul8gmenxJsx6m0mQWmwnhtTqRxsjUvqvEAS98TpXdYm7bAJ8+LkcYdyOnk5yshJIr9SvL/BSCrWQ9U/cQNMzeGsR2jSCFhYEm2A9gjG5fv6AOTWsKGmnKlQQjffsLmTVj9JNzjW+4phxIyOHGLz0tXy4/hy/iJ9iuoa974IA3HCPg56SOjfXP3I57RUVu69Ak9AqY5S4nPc8PIczNvz3a62A7TdyYZzRHcIss8zy8Lgoa1b/hPIVwP3uWjIwRODKtE2y8UzNTZmqk4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(19627235002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: T35KlYm3vJtI4l3KwpYwZ8PgqSQuvdB4oWadyzYzlh2bBjRN8VFDTEpCx7Nva5dy6kO8v54ZGYsgnR24CY4bEpeUCx8BU0qHBgKi/3LUMAnI1N4ihQnspcf0DgeHm74OHrCjoi0qmlHs3Rrdsj8Z6qYaM+f/GqlhOAvROlXnkWGHv/MuVCMhsuU2zZm14B1QGtbF0m3E0oXjpk8gHct/K/twREn+qFziL7f3m43iyQ15v/OSPPsdiU218aS0EVy1/GCvKNlRsSXDW2I/1mcboagRolrv0vy/6VYTvoFF4dpkUNZPc8YUvAP+a1SBrl9WQNGbCOPZOnZfO7edZaXh3hMeZW33LZI4eq+jXKmsF7pCoq6Awx3aSTETONnnKetDWlWIByNTRekrDu4RWb+V4wcP9AghzwMQb8ERl87MCYZY/3GlNhKqZTTYtmOs5kOeWjO+ZCX6oTWeqZZuPz8pxePm4H+im5Fw9qXWLju8l9MTCNylqXOsFb+grPPLe/Zk5vHK4Qf7sO4kbPHLj0s4oFP5gZRfWgiikb1vqcMyfHgnw28GGd5S71UD4LWemLaZikrjvs7xZK9DwXxaATmQy4uv/JW6oHyiiCCGqpsmB/XdDtgnb2Rfer8NJNWw/zhxocKRVmQJ6KoNQb2euOdDfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8d3040-7544-4518-3ce6-08d871837dff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:04.4207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgWh5mjGrPm4q+bxRCAgVzSr7cMSFIyD1FuE1/7NmRf3DjQE/NHcZSZkA11KQmcJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only if the ZeroRPM feature is supported.

Change-Id: I68f1960c5c65ff176f4945a4248082f1934d7cac
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h         |  1 +
 .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c   | 11 +++++++++++
 .../amd/pm/powerplay/smumgr/polaris10_smumgr.c  | 17 +++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
index 6e19f4c7cf8f..0454ec990a5e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
@@ -394,6 +394,7 @@ typedef uint16_t PPSMC_Result;
 
 #define PPSMC_MSG_SetGpuPllDfsForSclk         ((uint16_t) 0x300)
 #define PPSMC_MSG_Didt_Block_Function		  ((uint16_t) 0x301)
+#define PPSMC_MSG_EnableZeroRpm               ((uint16_t) 0x302)
 
 #define PPSMC_MSG_SetVBITimeout               ((uint16_t) 0x306)
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index 0b30f73649a8..e3d9d969d86a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -175,6 +175,17 @@ int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 				hwmgr->thermal_controller.
 				advanceFanControlParameters.ucTargetTemperature,
 				NULL);
+
+	if (!result &&
+	    (hwmgr->chip_id == CHIP_POLARIS10 ||
+	    hwmgr->chip_id == CHIP_POLARIS11 ||
+	    hwmgr->chip_id == CHIP_POLARIS12) &&
+	    hwmgr->thermal_controller.advanceFanControlParameters.ucEnableZeroRPM &&
+	    !PP_CAP(PHM_PlatformCaps_customThermalManagement))
+		result = smum_send_msg_to_smc(hwmgr,
+				PPSMC_MSG_EnableZeroRpm,
+				NULL);
+
 	hwmgr->fan_ctrl_enabled = true;
 
 	return result;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 9b7e9ddc5a1e..fad6ffb470ba 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -470,6 +470,21 @@ static int polaris10_populate_bapm_parameters_in_dpm_table(struct pp_hwmgr *hwmg
 	return 0;
 }
 
+static void polaris10_populate_zero_rpm_parameters(struct pp_hwmgr *hwmgr)
+{
+	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
+	SMU74_Discrete_DpmTable  *table = &(smu_data->smc_state_table);
+	uint16_t fan_stop_temp =
+		((uint16_t)hwmgr->thermal_controller.advanceFanControlParameters.ucFanStopTemperature) << 8;
+	uint16_t fan_start_temp =
+		((uint16_t)hwmgr->thermal_controller.advanceFanControlParameters.ucFanStartTemperature) << 8;
+
+	if (hwmgr->thermal_controller.advanceFanControlParameters.ucEnableZeroRPM) {
+		table->FanStartTemperature = PP_HOST_TO_SMC_US(fan_start_temp);
+		table->FanStopTemperature = PP_HOST_TO_SMC_US(fan_stop_temp);
+	}
+}
+
 static int polaris10_populate_svi_load_line(struct pp_hwmgr *hwmgr)
 {
 	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
@@ -1949,6 +1964,8 @@ static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE(0 == result,
 			"Failed to populate BAPM Parameters!", return result);
 
+	polaris10_populate_zero_rpm_parameters(hwmgr);
+
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
 			PHM_PlatformCaps_ClockStretcher)) {
 		result = polaris10_populate_clock_stretcher_data_table(hwmgr);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
