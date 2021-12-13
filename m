Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6DBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4E310ED0E;
	Mon, 13 Dec 2021 03:53:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824FE10ED0E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0uDcsSbESoi9YUXSBkdXJl87diC+/ioK3HAWR9uYcurI6JoO2oMs4jjXb72956fdDN70daUiAG60MUPc9Q+UrTeeeGekEbTzmy/EBQWha6pZxnPqDTs/M8hFo4NM00r2+o6wpBBVgjspilBCHFFC5TdHF7JbKOcTa/SPrI8xH2XH474k53ak5Xjx55kqcDBpuXW3UOs8OXmJN2iRTAD6LNzn6LS/EFkeVuOV5Xno6eOmnNhR36c0KgvS1M6+WQeLWpflB1RMuCq4FfGb2wv/Vx7Fw3ltMuSJZY6wEgqgf1BYR8H16jJ0k47Tka/ctTSkqOdgIOrpSz21hP12xIaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaxbVyMTYGwXnFYlWt78Kx1K9rB+WwdSw/ZmejaQIKw=;
 b=i2VYJCAY4AZDUnUAfczyO8WOZIO0SDwP9e3nty/s4BsJs2Ht0JnRMk8sAm4oFi8180e+c0jC87/vAxZoDbSC6x+E/ZN41O2I8f9chgY9zkU1ED2R7bBaa6pbozA3Sk3MioHz7lWUMGGt2upcReyDneAK3rdRf19OacZwNhadnZ2ewF7oskGCnBn6gjw9DjEEnP7nMgPLUGBrUYbAXIluB69EMCOmiga6kcIrx8zejJKQDbINARPTZlGIy5npAULDwI1dZypCPD4XFLgarJvvAN+lWrKa4JxH7gr9WkdbPBicVIIYPqHpX4pkICANJ4BlYeLzPxTRtclBjvfw0QDYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaxbVyMTYGwXnFYlWt78Kx1K9rB+WwdSw/ZmejaQIKw=;
 b=KwDU5yKSHQtlIOPYBF28jeRyuztAv9ngdNiZf0IqL9Yso5B9bn1E8ImKPoiO1Mp+89UWXW9Fg1hZ5qAJl42sqW+sDf8+uufiSOtgjl6VIsKZG/G2iWhIPPX/nbBtdcd0P5dgaiBzc39rOZ7tepzpj59dnHjel8Lr9h+EUvCeM3U=
Received: from DM5PR06CA0074.namprd06.prod.outlook.com (2603:10b6:3:4::12) by
 BN6PR12MB1587.namprd12.prod.outlook.com (2603:10b6:405:5::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Mon, 13 Dec 2021 03:53:01 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::d9) by DM5PR06CA0074.outlook.office365.com
 (2603:10b6:3:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Mon, 13 Dec 2021 03:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Mon, 13 Dec 2021 03:53:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:59 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 11/16] drm/amd/pm: drop redundant or unused APIs and data
 structures
Date: Mon, 13 Dec 2021 11:52:18 +0800
Message-ID: <20211213035223.772700-12-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2bfafb6-c0a9-4830-0e28-08d9bdec0ef7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1587:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1587FFEF84F6F8E38BC44DDFE4749@BN6PR12MB1587.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpHdVC1YXe5isASswuJOAiUd0G75EDcfjOqvSe1VEuBmQbrMxhsUfGP/NIWkw8l9g/IRi6UI5AxS5uFXowApF7mH/OnfCrCiObB4lSf+qrndpzWx01ahlD/u+GFPZU1O32FndwaEFLCmYzIGR5W5TnCY4YCmT1lpHAT7Rr0n65M8T+FNGIHG763aa+t29G2lwTi5xvAhKaEUk+8YzlqxWUo93c4erKGML+MFn/cOuRvGm9CqX14G5uiW1hquuVC0NstQ/KYVbK9qqdplPvdIV68uRHhfXtEf8mTwSeukWxW5O4FLx90Pn+uhNb5+Usytt5aXjQbet8AsZFwrxgnSp6T/tTItPEolGremVF/dyxoV36PVPiHf4FBq5ik1404RncLkWGh6ABZM0sSPVXf34sMy7B9rQ7TrY1dqeFTy6FxmBDVc7/ERdMeiugBcd2J2kFb9mThMoZymwIbLAf8bEIwojM1Ycym9vcRTlQDPkvOKVeHWt5Dwkww3QP1csIjNsV8WnMjjuTkqHUJ5qkI22my/ldqTeUjJRf9GKPpc44YsNCSfpkoiTsr66HAosf3vCYjj01FVdzrFLAbYOogwTAktn5pT3LZWSB9Z2d0IAmIo+iPQ8Mm2Eio1lT5QJLKyEwQD3WT+cfWCsv7S43ZkotbBFBse5xzTdj09F6FfMMf2WTX1uV41U8RWVNSOCyalLn6kYLCSVtWopm9BHkGZwDcU6YStlhyrE6i7tMRBopnY3C8iotvfhr7JaxtylO5BEXpKAxyrMsyMKMW2VHsGF3+yGfto9r9eqHR34qyOjZg75VTNfSFfKgKXQor/tkrQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(4326008)(508600001)(356005)(44832011)(16526019)(426003)(8936002)(5660300002)(81166007)(83380400001)(336012)(86362001)(2906002)(54906003)(1076003)(70586007)(6916009)(36756003)(36860700001)(316002)(186003)(2616005)(6666004)(47076005)(82310400004)(70206006)(26005)(40460700001)(8676002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:53:00.9701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bfafb6-c0a9-4830-0e28-08d9bdec0ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1587
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
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

