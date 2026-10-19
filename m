Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624B4CCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC6C10E87B;
	Mon, 19 Oct 2026 08:34:39 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F06E10E87B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jhpw6tMOhj4RsA51PB3/O/YktfqVM72BbA0WhwF4j0jkUetiYwUnL2A59BAogfHEdfk9+MW6EmDnqBDiT7WI0ufWadaxNXm1tts+J63xnTBMiruoYxYIoieHsM79H7NCuGNTiKMi3JFJ22mczeWeS1w0my0fsdqYh3VIU8WE2WtaWP/VeQUBj7jqtPg+DkawDMBpsDMP09bcC14IdrYhzqgPHvlAIwK1zx4Ip+CwkAn4tp9Ngo41wSeF8bNNq7tzyWR3ttMJGIsBreFR4Xc6EIIK/a6NNxkmYh8Wm6tQZSPfOEMO1mFzNKwvpiHCkAJucmc0W4LMY1QIPqeHadC6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkni3H2vjA0xITrFZjeuK+J/s4lkY2v0WN3FMVVIF74=;
 b=IWcnRKaoJ3vCy8nDRoyN9L0Q5cW050Y1HoAQ2KldqBo4nD8M8/U+jgxfemuCwwocMxUUnULTJ54GodVU+qqN7+NO/lyXmIQsDvHhU/2okJ/yhRydlTon5hscRVupLbfsmR24Bgobd6MC5QXj8lf0hlc/i3tjQ32RJNv1E+MXZgFnhfV4RUoUUSk50lPJyHILHRVVNeJdI61dRD8HnicblKfsQzg+16HRbK5Cr0E4umqKCsE6MMJTLPsEqYI3+4zLCzJgPALw4CUV2ZECx48xM405P13aI4+m62NYrQW4O4Bd/IZKE1DwjtidX95HUoNdUNMy6AuamEjFqTtwnjsjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkni3H2vjA0xITrFZjeuK+J/s4lkY2v0WN3FMVVIF74=;
 b=taYlpBINS5Zz9inqDxJXeVvtkmBLE0aW4ojiKqUUMwIQOjezVCESdmt12wC91Fp/rzbiLA4f5Y18FrWOBWAC6bL94lteqKHPdz4lOhtAPuf7dHMJ+LizDyumKbtaM3uCI9eUZ69aYZeyQTTJwONlWUe0Ry/s8NznU0ZSH406d+Y=
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:29 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::3b) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 08:34:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:16 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:15 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 12/13] drm/amdgpu/gfx12: enable the gfx engine reset
Date: Mon, 19 Oct 2026 16:33:12 +0800
Message-ID: <20261019083402.2033724-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f80ee22-ffd8-4beb-c816-08df2dbbca79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IGY45AmJSns+ye/ucTVL6c7bE8R7rlgcgmGLqc33mgwJsNz7LwbqAl0DZJVFeYGoektPwpf+UZAxrUD+pOhTt7e0Ir/rv9dlGoIYidpktEBPm84sRTc5KxS6sM7j1OE+b+G07ztg/MOo4qJY3PeRKxDG6728Uz8W6wZrfoD8ZI5U+M5MXjmGhM/MdI8xkI4hjt+SFALPmmz7XGGXv/A+9dGoXqTuoQuYD8dYiWCJjrmu6eWq9nXx9Etwh+zx8JV+ajaRvItv2VsHRC8u0YHiidEZEceD4aOcPqHbgKeJtbm2s9X1lc1Fz7zu7AH2og+EMHQH3kPxjVVYvgd6IWHNSgIBTywuIzz9+fwZuvRCIIUlEKHWzwrui4WZ0vUPMJgcQV9h9ct33AaPPWy23Qw/bmXz6oNCpZ6OIAntYjCvkb4LruC589ZTTqVh9oscwyfinysR7QAYXtlvKuSOdur86VLyVI30ttL+wb5W2qXIIaAHDoKMDN6uF6FVJ1I63oSBek4b+H/+J/8NHFyPVcDKouysF7scnyg0C3hx1YR2UWEoawMYWduVRCKgjqGvdETebiHAU8Y18LsU/MareVPIEBX/LBupOiLfQlMu3vA6Tf4NBQ9CdAD+Sea1cRbf1pGF878Z+hJCAEFH0/Zc4A3Rv4M1dnkIM1ijbBn6ymG7VAJ2ihB0hbzaJ/CUwO0Sgpnqd67BFsViEk4RRiiAYkVnXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KypvpzOlP3sT0M+O1GQ7fZlIE8CumZvqUS8w797V1eZ6CDS4bac459VzG2+ydI5Di4KRTg2q4gwrk7q3y5OhJl5dvffNeKGyezXD+bEmU8ldc72b/mly2AOYLHOdZ5L+25RaA4zKGcGI+w2ESla6XpwoIgYuzvHGwY/Hq+huQaDKQfTIXjfDsoOck1a2+HrLKF6i2s4wZKwvgOv7wqhZDQWtW+XAe8g8fHa6HRpUORCja9CBFFRwO4Qgt7axPHh8uPyQKjZqRbYH7qE3Et436S0jREOuEjiio3G28QsMUcBxWIlEDlrBVbon9qvPSxN25nqSJE1chjViZC574gjwROGCdaKT5/JCCPXLo6pUKTrhCm1ofY5aCRkgywjfTrPkmXxBSKEgu43HJ8FblAT4iZTOIyXE5KNqJXKZ+6b+W7mv3dmTw8e6jVH1z6xoOc/9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:28.8012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f80ee22-ffd8-4beb-c816-08df2dbbca79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Report AMDGPU_RESET_TYPE_PER_ENGINE for the graphics engine when the
reset_engine callback can be used: with MES and async gfx rings. The
reset remaps the kernel gfx queue through MES from its MQD, and without
async gfx rings the kernel gfx queue has no MQD. It is programmed
through the CP_RB0 registers, which the reset clears. Not on SR-IOV VFs.

The kernel gfx queue and gfx user queue resets then fall back to a gfx
engine reset before a full reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ee43fdc94ec0..22958fff1113 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -274,6 +274,7 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static bool gfx_v12_0_engine_reset_supported(struct amdgpu_device *adev);
 static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
 				  enum amdgpu_gfx_engine engine);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
@@ -1586,6 +1587,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	if (gfx_v12_0_engine_reset_supported(adev) &&
+	    !adev->debug_disable_engine_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_ENGINE;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
 		if (r) {
@@ -3847,6 +3852,16 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+/*
+ * The gfx engine reset remaps the kernel gfx queue through MES from its MQD.
+ * Without async gfx rings, the kernel gfx queue has no MQD: it is programmed
+ * through the CP_RB0 registers, which the reset clears.
+ */
+static bool gfx_v12_0_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return !amdgpu_sriov_vf(adev) && adev->enable_mes && amdgpu_async_gfx_ring;
+}
+
 /* The CP DMA and the interfaces its memory requests go through */
 #define GFX12_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
 				 CP_STAT__TCIU_BUSY_MASK | \
-- 
2.50.1

