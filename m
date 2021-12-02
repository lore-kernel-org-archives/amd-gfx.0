Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA91C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5336E95A;
	Thu,  2 Dec 2021 03:10:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9536E95A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjG2w1/7KUi6YfXH6FpcmlPiE32I+XxlO3726U0OnZOoM9V0EsuFztc+0yD/ygEFzKUt/WZS3S5C7jiaXNK3KTqf9Nwj7HysVVQz0ZnPq2o/bjMWGN1Qf8HCeCAc/Cl8+ipgoXIshwrZgVe2HvxvmSN2Pa8J+Zdrb5rQc2si66+RCEcWciXsEuZzItMmzLU2p/5203yFDC3tAWQVs6mIWGG4ChlkfdDdZYA4lt7X/h4ghAaCsD7abjnf/BBtt7dZTzulO0soa3wrDN+WReaJ61B+QEf0gTQjxxtYJa0IulzPHU+EQkn1dA0RwNxJSya5+ODIo3BOARNAVpNIxeavqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaxbVyMTYGwXnFYlWt78Kx1K9rB+WwdSw/ZmejaQIKw=;
 b=eLDzKy1eMKpvb7UjVGYKgQrXgHA+Sv+vITQUVL8rfv7d5kIQWdmB6MGDyDVzzxO7YZLlaf62WhtWHTR70AAr9rT72UsqDIr7GqneNHOSsqdYq+GFPn6mT7j/siohVe0zM17CqUQuT9lXVvSw6wYAZsHniI9GEmDI7IL4/uc7M3uiUBOn3a7yPrnfIG6ABe9RzpS7OHmbSdryAlfbjoCFya/6HpqE1PR9sVEQYMbzZ+C2ZclY/4imVazj7YWQn8CHymf61TXfxu62aKUZ8htYXCtQ6VIaw7Oyffz7t7HbbVJR6Fm+oZahBESHA2qcxp710W2lupzYNt2z8HOs8rYN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaxbVyMTYGwXnFYlWt78Kx1K9rB+WwdSw/ZmejaQIKw=;
 b=Chps146q9Ivoks4u4tyegHU/X+vr67BIQXEoL2PA7eYMQ/7felhZrfhv4C+iM9CziBD30B8hwGxUUhK/st4+Wer5mf3+HL9IteXPmQ0q0eCbVHthBaf9NK5J+IoWe7Z0eVwJ+w4CwdbKeXIEe2KFx9Isi2ZZLKc78Oo11eZeZ0k=
Received: from DM5PR08CA0048.namprd08.prod.outlook.com (2603:10b6:4:60::37) by
 BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 03:10:30 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::2b) by DM5PR08CA0048.outlook.office365.com
 (2603:10b6:4:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:30 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:24 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 12/17] drm/amd/pm: drop redundant or unused APIs and data
 structures
Date: Thu, 2 Dec 2021 11:09:25 +0800
Message-ID: <20211202030930.1681278-13-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1836657-38e7-4d10-9050-08d9b5414c02
X-MS-TrafficTypeDiagnostic: BN9PR12MB5097:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50976284B96BA05F4DD9690EE4699@BN9PR12MB5097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5Jh14llvzd+TFhNvpxlxOnKIpr/PgpvbHQvedOTtWzVnPLvc9CbNkVlm5HgKNO6eBm0+kX9YeWG6gGxGJa301Dtp+0uiYmNX+5+UGL9dOeFPtznPdqBfWQzV32pwdxCdrP89+X8Wos1VrSiNZop1DoGkSNMFBouCCnSYg1rc9EqYPJQelZ2ip8nnVO0WLAAUD/Wn5V7MT8vY+XiVVPbdaD3lwJxeic+H5hfGbvOnwU7BWSrzK8MJNvQPTCjEjm1hpS9z/Kf+9b2eqVanI6Uq7DZoheDuR6t8iCifhb324pivYuRkXI6Fm+0eT63nPkAkbkXIlq6WeKd/mSK1ZLYQ5VB0KtsZuBjMvR0yqo8KDtKl7/hpvNvTZVzC7YD/ktANAJtum5sHqyghOokcWG+JkilWH5NaFA+NaIXclwICwK05+QdpV6i3ofdOTmRQWxzBfDw72ayt5n6vGohHOmNh6i9n1lo3hS5Ky/RshbOI6ZIMMbyVBgFWrGQD1MZWEcciz1CBncuEYA2j8oYn6FmAXcPOJNy+BbWFODTF/N3JJvQ7z9Z0oNOUoaFbkuiDIlXwXFTFQehFuRHsootFF0juLZFzaOH/piaR6bmJX2hZxI4Nwmw7tHB6pG3sTxOSx52Irc+HZXb5Vg3gha5wSuimXnVa9msPZv15JvZNFS50py2n+sc6Io7157JYajANpqDwpC5vZiJX4kNFa/RdwcMekaefbEc9Kj/Q/v+TM97CVmK+U02ztnCeQ68CW3Cp2yGT69LjAxf8RmnBSUPkPztQzIMzlXqTGaYPSkIXpp5fdOTptjDTsj2m6wh6R8HB/Wd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(508600001)(86362001)(16526019)(186003)(54906003)(83380400001)(36756003)(336012)(81166007)(356005)(2906002)(7696005)(4326008)(8936002)(316002)(5660300002)(36860700001)(70586007)(6916009)(47076005)(8676002)(70206006)(82310400004)(2616005)(26005)(44832011)(1076003)(426003)(40460700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:30.1505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1836657-38e7-4d10-9050-08d9b5414c02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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
index b0791e855ad3..de76636052e6 100644
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
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
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

