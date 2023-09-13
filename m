Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71906EE01F0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73EA10E4CA;
	Wed, 13 Sep 2023 17:15:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C6910E0F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/POa2BCJRcpOMFaphGw8Vyc+PKxrWhrVPnRDRl/Ai6psvpbLhm/MciaTtTZ6EEOKDNXtkXvr7zhRkG/2K5WKztryqZUEZYsJH42k33n+HxRzaFXi/0uRdygqRZ4Ls4BOTlJZYTioWhszpm6+Xi27pJGEqw5GJGxC8LUBJuMd1+8PC4m36TL6QKRb9yzychw6R0xADUp3V4D3dxn2clkHqsnQoRi8QdKNv3GRwTDO8Jx0wM8cBmxM/FwgXFYkYMb6engi1Q0dZzTK9jYM2v825mO9WJ4fgH4hrBk3KCf5L3nLFj+vrMC5KoFt/sIxvbxkWT+Zqp24x0o+S0/aF+FIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngZemiZ6G5EdLkUaNmf6zs4DL/5ggtA5YQjLNM89ZRo=;
 b=ApLO/3UEZRRMMd6CTFVNa7yP5MXT+zQB33wLvJpIi2PNjSPD4eI23VLTzdUJqj/KlWHvwlob7V0hcMaya7XQ2AuoUhL54zjHqjVriyW/A+LSDPGABVPyg8YqN8hRyX14MdVrX4kd2RdF829WpQqIbXrRgzKimsHF7TwyOXJKbqvDf7jhSLi0JOLIR0/zugPFKQiUysPanD7aFWg7xiP9n4S3X7oDdeI73pQTxC1tmOT6bsGyKcV+OQR9SAfs+ZjHzhTNFkh7WHnm4yFie0vIbUc3779kIEmg1rli8P5hSvSjR/SMnrAcV4nDmFV2bWS19LMZilzgxpQ7VxdAUFEc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngZemiZ6G5EdLkUaNmf6zs4DL/5ggtA5YQjLNM89ZRo=;
 b=TCAplgzPrkzxeHibaL0YC1VSjfVLi7JrEoo5axI/NvN4NhVsvIlSTDNtNkb/3nLA/dC6/XcfnMVKg4/KmLwe/J6vq6qB0K3M3k05UJpKzWSXz4h3shHiPfq7c0vcEwl/xBsEUfbdr0AIkOER/DmpW++5Nv7gZwGLVVVd0Y1Wup8=
Received: from DM6PR13CA0069.namprd13.prod.outlook.com (2603:10b6:5:134::46)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 17:15:28 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::d0) by DM6PR13CA0069.outlook.office365.com
 (2603:10b6:5:134::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 17:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 17:15:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 12:15:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/4] drm/amd: Add a module parameter for seamless boot
Date: Wed, 13 Sep 2023 12:14:54 -0500
Message-ID: <20230913171455.153412-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913171455.153412-1-mario.limonciello@amd.com>
References: <20230913171455.153412-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: dd09609d-d599-44d1-e06c-08dbb47d06bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KH6JqqKgt9exKlZJmF8QQL4G51sCW1r3t04D9JO2AQr7H1BT1MiZQFkuiuVrdGHGiBKphQqhMOeecdPvl4KUbzVO0cflg16Yefb0wFmTSoaBSWMmzdfFGDIcJV/QM7aLRitzKKE6sB2+ZD4GMKT/PrO3rUwYgJ49RUztWORxJBVOg6wLFkhH2cv85qwm3NLA1VeQBPlMguAfOsGoiEuAzvP+gysOk4cbYUvtDjAf4Ai2YDEpr8ZktfdcUG3RzWETLzw3PoTpZBJpanZd9UrDwHTR+ST/n3m130ZoZuRYaz4t5wcwixgbZAXUPwQe/+L09WTnj9fAYW6MpL0p1iD3v6yOAk5KmiYXStWK8CsnIg0JaM6U+7ULR6EXSmnh4XjeSWzNNB5URGCtxtQIR2clB50K3y5Xazdch9U6oEx0a7tc9STGaDwLkN/HacSYztAqqNDQtOJYoWxslqeikkaxAIWSE2297drgcOHP5pspT4je6/Q/mqWCt33I2c1r6Ohao5gjz18O+lU2cGIz16lNhAb9S7UKri//CW0Fa6g0T0eylbtfNEt7jaTktMHM5UEaFKUOMWh42yWEBdnqDBB7bGtX03dRROMlDwVgbjv1WASTsCo9AEfeQJxY8+kN6n/06rAMsupXcLRwcYoWXOCPxwxxJRbEYjovt/JcEukZK6rRmQtl6wo32BK9ysUQfcs8FiVkxtJZf04+JlIuuO5tXVNgD6Lg5wM/aF73UOV/R3q2+fgcVIx+f6lpI//rQWdaGTkxaddGYQ1icSUvrSNwoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(70206006)(81166007)(356005)(7696005)(6666004)(47076005)(40460700003)(36756003)(82740400003)(86362001)(36860700001)(40480700001)(16526019)(426003)(336012)(26005)(6916009)(5660300002)(83380400001)(2906002)(478600001)(2616005)(41300700001)(4326008)(70586007)(8936002)(1076003)(8676002)(316002)(54906003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:15:27.9269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd09609d-d599-44d1-e06c-08dbb47d06bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The module parameter can be used to test more easily enabling seamless
boot support on additional ASICs.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  8 ++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 38a10d6be921..875448c44afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -246,6 +246,7 @@ extern int amdgpu_num_kcq;
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
 extern int amdgpu_umsch_mm;
+extern int amdgpu_seamless;
 
 extern int amdgpu_user_partt_mode;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7187eeb8ffa6..2116e016178a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1367,11 +1367,25 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
  */
 bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 {
+	switch (amdgpu_seamless) {
+	case -1:
+		break;
+	case 1:
+		return true;
+	case 0:
+		return false;
+	default:
+		DRM_ERROR("Invalid value for amdgpu.seamless: %d\n",
+			  amdgpu_seamless);
+		return false;
+	}
+
+	if (adev->mman.keep_stolen_vga_memory)
+		return false;
+
 	switch (adev->ip_versions[DCE_HWIP][0]) {
 	case IP_VERSION(3, 0, 1):
-		if (!adev->mman.keep_stolen_vga_memory)
-			return true;
-		break;
+		return true;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 90d6c5e5d66d..e3471293846f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -203,6 +203,7 @@ int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
 int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
 int amdgpu_umsch_mm;
+int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
@@ -938,6 +939,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 module_param(enforce_isolation, bool, 0444);
 MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
 
+/**
+ * DOC: seamless (int)
+ * Seamless boot will keep the image on the screen during the boot process.
+ */
+MODULE_PARM_DESC(seamless, "Seamless boot (-1 = auto (default), 0 = disable, 1 = enable)");
+module_param_named(seamless, amdgpu_seamless, int, 0444);
+
 /**
  * DOC: debug_mask (uint)
  * Debug options for amdgpu, work as a binary mask with the following options:
-- 
2.34.1

