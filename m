Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1B4C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5CB6F49E;
	Tue, 30 Nov 2021 07:43:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2836F3C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT2stZ8p4qgoiyM/y42o8i2m27himWSD/ffemUwyl+YrDB0IxxVqmbGwOHJ+8dDjp4/j0tpjwFsuCMz32VoasmOFpnl5eNgSLqc7B8Ov/pp4maFS272wFMXBz1lsHtIDQBcYIEjdw3QUzouGXI9c1AV6zZhYuB7j4CFTLD4ns/r2HWuMjWU172UpRsLMovAhoA59kojnyzNd3fwJVp1ZC+1bwTq8siVaRl2DN1ePvr/NSyXaESmhDSSbu89NZqggxaszd4YKALsBrd/h+cD5ev+7xT1XVLckH1w571nUFpU4sc1Q98Udm9qumL0i7GpSoQm1fzUor/p+a1MqI8zvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73G919C6QyPFlUsxYunhbLw1Z/reBuzH4a12xCoEV5Y=;
 b=OnGGAFERlC5VJZAsqyoJnsPDwFl55F4ERt+HnzZrpvsxRCiJyUVyMm085hRrPfguW0bzdSH2za91htAc9YnvSgxiuks0eloGu4zuXK71zVo01KVJHTzTsOUgOU2ApJ5u/cdxcysbEwqcrWIPAywThJXPCYdWqYt0G+7AGS5VlWH72JR1AAEEWXu50UIJDw8mWjDh/gkeMou+sl9xCfJEABHnHAnz9VVa58yO8U3RG86/8Es7mYwsPoHmfkgrWny/KYMdebV9lWSPq1Jg9C0CFGeD6LsfQlI6SS1tjgVF3IHFe/qBqIgi9mkRIp7Q97FFrWZT1MCdvsHuepQGgstKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73G919C6QyPFlUsxYunhbLw1Z/reBuzH4a12xCoEV5Y=;
 b=AEvKuNz+lY2/EtVsbWCWAF0UKQQ9udW9tT8ndYw6FdN7QfbR5n2EJ8LMOv7yogI9vhOxgArkxmEvk9bBCJdxh7Hp0QCTswxSjQKesNxzXQrSoi10X7aBSmezs6aywk6qFR8/v2qb2oH/zfWH2HW3eHuzFLWpvLEmWWbb5wnOP4I=
Received: from BN9PR03CA0253.namprd03.prod.outlook.com (2603:10b6:408:ff::18)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Tue, 30 Nov
 2021 07:43:50 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::67) by BN9PR03CA0253.outlook.office365.com
 (2603:10b6:408:ff::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:46 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 12/17] drm/amd/pm: drop redundant or unused APIs and data
 structures
Date: Tue, 30 Nov 2021 15:42:54 +0800
Message-ID: <20211130074259.1271965-13-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad7bc43a-a0f8-45d9-d14b-08d9b3d5253e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4255:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4255B628DEA4FFA63BF26EC8E4679@MN2PR12MB4255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4B31TyLKkvSyNxwI750OmB2saNTAA3FiCCzBm56BPzxoxwwFxMrIBkRwIO+4lu3HdMmNS+el1axksduZc5xJnvccvw9RzGOx8cwAyyyRTZHioGev/QUobOH51MSe6oxy88a+TygUTsr4yGeCovFoizoO1F3aODLfkYRENIwkkAAcNlYCWgmvnUqB35F+6+RNAO/DN6HcV0Y3IV5Z7GEJDTPQL0/OclkRvbTIDw2oExUDNcX0IUJJ6tqSAkG5ZS9nuc2xBpLjyovhkfT8qbyt1bB4NTbNB68Gjh64T527jajUzl+5DL6sy7gcmjrvjXbt6ynxdBh5eqeHNlla0XZP1ZrdGHonw2mX/jAYZbRcjKy0s8jXuSp5FVxk5Qj0cW4lTdhEbYCfA4914hTY5icZje/DyUc1PhRIKVj6UdyIUOnQAANvMjJCIA/DRB8m/lAPZDf8ahl5AoF4D56ghOwpzAot/gh/+xzWtaA5BBa2Fx1WoVuz8bJD57el7Da41wBhcFDaFaV7AU4O5AhPtTDZFEcy/WeFEiSmlK9uTmV6yiVVTazurQet5LSK/xi13z/6O8coq9mOSo9xLaoDxRRjDMGfaeMXmot/Yl+hzyOYKdmuQEq5NpP4tn0QrCudwprQKEZqM/26PTPnBsimPTNlS2Rd1gANOLv9/pmuRZNKEZ+2fco/HDhpXjCxSYF/vHtO5fhQaDgibXFRLlimM83Ecjta9Ixa4SjWHIKAo8CbEVkr7gxAWafxgByn/Esy4XQMwo8lTUoRioQFrCygCAJan4mwIw3124Cq+hakIbyA7xqAPk2tuL3m7Al0lKbnjKr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(508600001)(336012)(426003)(6666004)(316002)(8676002)(2616005)(16526019)(44832011)(4326008)(5660300002)(186003)(7696005)(6916009)(47076005)(54906003)(70206006)(70586007)(2906002)(8936002)(26005)(356005)(36756003)(36860700001)(81166007)(83380400001)(86362001)(82310400004)(40460700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:48.3486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7bc43a-a0f8-45d9-d14b-08d9b3d5253e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop those unused APIs and data structures.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I57d2a03dcda02d0b5d9c5ffbdd37bffe49945407
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 49 -------------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h  |  4 ++
 2 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 5b68f9fe4fde..5c54aad85635 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -88,19 +88,6 @@ struct amdgpu_dpm_thermal {
 	struct amdgpu_irq_src	irq;
 };
 
-enum amdgpu_clk_action
-{
-	AMDGPU_SCLK_UP = 1,
-	AMDGPU_SCLK_DOWN
-};
-
-struct amdgpu_blacklist_clocks
-{
-	u32 sclk;
-	u32 mclk;
-	enum amdgpu_clk_action action;
-};
-
 struct amdgpu_clock_and_voltage_limits {
 	u32 sclk;
 	u32 mclk;
@@ -239,10 +226,6 @@ struct amdgpu_dpm_fan {
 	bool ucode_fan_control;
 };
 
-#define amdgpu_dpm_reset_power_profile_state(adev, request) \
-		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
-			(adev)->powerplay.pp_handle, request))
-
 struct amdgpu_dpm {
 	struct amdgpu_ps        *ps;
 	/* number of valid power states */
@@ -339,35 +322,6 @@ struct amdgpu_pm {
 	bool			pp_force_state_enabled;
 };
 
-#define R600_SSTU_DFLT                               0
-#define R600_SST_DFLT                                0x00C8
-
-/* XXX are these ok? */
-#define R600_TEMP_RANGE_MIN (90 * 1000)
-#define R600_TEMP_RANGE_MAX (120 * 1000)
-
-#define FDO_PWM_MODE_STATIC  1
-#define FDO_PWM_MODE_STATIC_RPM 5
-
-enum amdgpu_td {
-	AMDGPU_TD_AUTO,
-	AMDGPU_TD_UP,
-	AMDGPU_TD_DOWN,
-};
-
-enum amdgpu_display_watermark {
-	AMDGPU_DISPLAY_WATERMARK_LOW = 0,
-	AMDGPU_DISPLAY_WATERMARK_HIGH = 1,
-};
-
-enum amdgpu_display_gap
-{
-    AMDGPU_PM_DISPLAY_GAP_VBLANK_OR_WM = 0,
-    AMDGPU_PM_DISPLAY_GAP_VBLANK       = 1,
-    AMDGPU_PM_DISPLAY_GAP_WATERMARK    = 2,
-    AMDGPU_PM_DISPLAY_GAP_IGNORE       = 3,
-};
-
 u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
@@ -417,9 +371,6 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
-int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-			   void *data, uint32_t *size);
-
 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index beea03810bca..67a25da79256 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -26,6 +26,10 @@
 #include "amdgpu_smu.h"
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+
+#define FDO_PWM_MODE_STATIC  1
+#define FDO_PWM_MODE_STATIC_RPM 5
+
 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 				     uint16_t msg_index,
 				     uint32_t param);
-- 
2.29.0

