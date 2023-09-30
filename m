Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2442E77354
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Sep 2023 06:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A69C10E055;
	Sat, 30 Sep 2023 06:32:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EDE10E055
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Sep 2023 06:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hdbqc1k81CwA73t5vm95zOmtE1fZN7lm2Q+RxCZIV+fbV2K4xRfPkEsenmg2b/BzADX5+LUqZ/VsE6IW3SggJYbfC3FUR1bHPIJpRoTS8b51eSZHBRZKFYJbTpe5jmPIo8gsDEeAcwYSCFtp1o8rJ/cDGbQ5wXsb6kRDgRnQxaTSDfy4xPlH0keAkipi94mLhp5giOiOokKTXx0dRziqQ+aqlUVkXVoMiIZRpoF6Q4YsMruB/1OEd2U98YZ2j2ZhyeChtzr3F/QcwpBX2zBqfIcF2J6LObqNrnb+tCmHhH2pY7yObf3wNUpuuMglWAmOH39PZN4f+Bw0RA+fCu2YPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58SpXyEYYI4m7X6xrtOkMPboBvEkH4lRbgR2E7DV41k=;
 b=HAeNz6VOsFkv/H0pxP2xSoTUTvsuZBF73PutVQI1ggWBBiJjxspzTCDdzk1tTF7/YeN8MUQMgua5TJzWlW63ITi4fnfFFFuIOw0ZByAt3NubkBGR6SXP1dp3F2TYyC2lpeGc+YDKYc7xRqEaFVpgt98esRYRL4WGolKzeVP/stKOvNNG/2i4L+yyKo3+a7ExmTxYPwJkgs4NoYp+VOp4pw9onEjsEddcOlcFU4UiGFiMDrG8KQmRieKDBAmjf1PQ3XgmxDmJfsa2SImK/h6P3H2ChQQK6W4jvuPxSBFImZlBJNRB8QFJtiSMjOAxXmhpMQ6YTnpDGAvkkrGys4ff9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58SpXyEYYI4m7X6xrtOkMPboBvEkH4lRbgR2E7DV41k=;
 b=3P8Z0m7HDEcPtPyGX6lhqkew3IrHtb9qg7Fuvvn9KaHSQWaYmqNtWRs0DtLbPYw5MEkV3j7UNEtQRX+Uu/1ECfLDEjDZIMznBlQADb4G3D/mq/68lMsItk1gx4zegM687awvJhwf4gRvdLKcFK32LblIp7Jwz/hn9vPkCgNnr7w=
Received: from SN7PR04CA0100.namprd04.prod.outlook.com (2603:10b6:806:122::15)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Sat, 30 Sep
 2023 06:32:49 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::f5) by SN7PR04CA0100.outlook.office365.com
 (2603:10b6:806:122::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28 via Frontend
 Transport; Sat, 30 Sep 2023 06:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 30 Sep 2023 06:32:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 30 Sep 2023 01:32:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix complex macros error
Date: Sat, 30 Sep 2023 12:02:32 +0530
Message-ID: <20230930063232.1317236-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c63ccab-0256-4f62-b278-08dbc17f10ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgZ1H3ayEvJZOkCdxE++vypMHmsNuPKNFdTnOsck1A8rSq8LbHtPGs8tb1IfqQk1uRBcmUlukTdbAWq8jjAp5ISjiGkRVVX+leWfZmoqqfc/CRCwXcThQfIxKuWK3GEI2GvPuC7DxmAVz6aEJX16w5KpDiFqoDMa1h1v6e3ULs62Px/ifzZflPrl50etdAMx5ws3t+42xRe0bHH7aAN6E/DC5NdK+7/Qhzfu2Yescezf5eGjE2ngBFUEccWbRsZMXMs6g0vMntOyZDnJktrOEMAWXPeEI2F026cSUTvOQb2aJqoVU88RUhFEeorf1cuJKWwZfFcHgsaRQtb8EWAEK7V3Tvl1Swjp+Ne8g7YBXVIQMN2BRlfcYt3MePQSuorV2CylVoU1TibBXi1MuDWgKo2xSSP+QFXbnM+XuxgfcOA5z3kuZ+ZL/ktPje8pHV9f0He3j6xtWnXG8dvQAHqqlpW8Eya+CW2/lMtZ0/BeZmfLelJuVrBYzBNUlh3Plw08y/mEaExf75CJua/xxA5HbT7Zsx+tVwGoPnG6hFhqtkYzFl45BoSiXMoZlanSQ2WSd9EoPZdUBvpLl2GusraTIkAdTOrPCce9VS9seUbwQ/65Gyoxx7WkN5DwBFEL0xPbYFCGxDOh09v2jB1sKqoQunoo4xemOGJ99yHW5nAEQOxf7LlL8AUzGaLVpp0C0As8GPm/vRXD9zAWSejnd7YPfqUxDVzD6xpzu9Eo0XMoRAn3AF5awXkb1goxVnMLetoCTcIO8sPCHCZt+hg7DFHjDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799009)(82310400011)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(6636002)(70206006)(2906002)(4326008)(316002)(41300700001)(70586007)(8676002)(44832011)(54906003)(110136005)(5660300002)(2616005)(83380400001)(36756003)(336012)(36860700001)(16526019)(426003)(66574015)(47076005)(26005)(8936002)(1076003)(86362001)(356005)(81166007)(82740400003)(6666004)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 06:32:49.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c63ccab-0256-4f62-b278-08dbc17f10ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

ERROR: Macros with complex values should be enclosed in parentheses

WARNING: macros should not use a trailing semicolon
+#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h        | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h          | 6 ++++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 73e825d20259..1ff2da1a5565 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1322,7 +1322,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
 #define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
 
-#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
+#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter))
 
 #define BIT_MASK_UPPER(i) ((i) >= BITS_PER_LONG ? 0 : ~0UL << (i))
 #define for_each_inst(i, inst_mask)        \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c60d2f79eeef..65aa218380be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -149,7 +149,7 @@
 				       RAS_TABLE_HEADER_SIZE - \
 				       RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE)
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
+#define to_amdgpu_device(x) ((container_of(x, struct amdgpu_ras, eeprom_control))->adev)
 
 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index a3eed90b6af0..0815c5a97564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -33,7 +33,7 @@
 #define AMDGPU_VCN_MAX_ENC_RINGS	3
 
 #define AMDGPU_MAX_VCN_INSTANCES	4
-#define AMDGPU_MAX_VCN_ENC_RINGS  AMDGPU_VCN_MAX_ENC_RINGS * AMDGPU_MAX_VCN_INSTANCES
+#define AMDGPU_MAX_VCN_ENC_RINGS  (AMDGPU_VCN_MAX_ENC_RINGS * AMDGPU_MAX_VCN_INSTANCES)
 
 #define AMDGPU_VCN_HARVEST_VCN0 (1 << 0)
 #define AMDGPU_VCN_HARVEST_VCN1 (1 << 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index af1a784696bd..c520b2fabfb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -62,7 +62,9 @@ int xgpu_ai_mailbox_add_irq_id(struct amdgpu_device *adev);
 int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev);
 void xgpu_ai_mailbox_put_irq(struct amdgpu_device *adev);
 
-#define AI_MAIBOX_CONTROL_TRN_OFFSET_BYTE SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4
-#define AI_MAIBOX_CONTROL_RCV_OFFSET_BYTE SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4 + 1
+#define AI_MAIBOX_CONTROL_TRN_OFFSET_BYTE \
+	(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4)
+#define AI_MAIBOX_CONTROL_RCV_OFFSET_BYTE \
+	(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4 + 1)
 
 #endif
-- 
2.34.1

