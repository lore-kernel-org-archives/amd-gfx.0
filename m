Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4408FC76195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7310E10E3F1;
	Fri, 17 Mar 2023 17:18:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF9D10E116
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeUqLXUPpL3Rjzz2VOwY28OEQ+GbFYWwzsg76Hm/ZfEIJ7/bz/6W7sYtEOCPKd5N0bVQc9IQjdCkl8IjTC6ZsUbPRMYIIBlPIgb6qHFLHUqj2mrfoUCKCKcgreAMcdtNtTK5Zz994fEMvJk1XWtMi9vnhXhgqOBblUvPb25SyDth7BYFYj2DxwKFHfgSZAjQ1lqt5bHrbvBdUcTg7B3paU6umGdAZVZ3WHuqxOFxWV4GAtHhQaDryypbG4G3ABx6IlmImpE2fCvFdCx3BzaP0Zbco0KmS+nxq6qfzdK8QtlwyV1HOV1yQY5QbiZSmZmddwv/ADUrgBA+PLIWUFK+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj6nFlq6aTuhs3/v3dL9oJy+rRNbZEXazvXMMA6xeUI=;
 b=DtjFhXgv2ZROmA74uNwo8Z1JbbLUoK9v5fGVO1FXAi77M5nOWs1Wdr+Y7bxRflHe/FzFp9Ypfb3fge+dUnOzaQo2cU4kAzagYr6xDkVI4g6cjaHi3qptKKQmYnPCuqd/ivgOHZg2yIyHtQMLBVYjv3/cf/SC5RA/3fRqW7z9THfhHZ7gcVOoZ1yGIa+J0am29n/nzIl6UwG6f67BPslkHCDboz9R06hcxn6YPfF+oJ+fuGz89n3HK6oYCegD+Bb1L0h4FzOBlXknEwDoWro4uKeDHhJ3OjQDH1+RenIcHSTO+a9JMyic11kiMIYeLGlEU77s2ZW46gzaRaOvazID9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj6nFlq6aTuhs3/v3dL9oJy+rRNbZEXazvXMMA6xeUI=;
 b=5aW7/v7MK/gq09yGi8AL+8/EbiCSFLF7afbJvKCVIn0e3q0OoXucKFJH0Toa7VsGm+bakRbJdpqYa+TJ1IQ6U65fBDbMCo+6E9NIZ8ey2ig6smYkxF62CcDb/yZfOPePu1sb55dBWI5pW94/VPg+81iMNHIG4BOzQosf721Cp8U=
Received: from DM6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:5:80::46) by
 BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 17:18:11 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::c5) by DM6PR08CA0033.outlook.office365.com
 (2603:10b6:5:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amdgpu: add get_gfx_shadow_info callback for gfx11
Date: Fri, 17 Mar 2023 13:17:46 -0400
Message-ID: <20230317171748.682691-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|BL0PR12MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: a544f505-944b-4d4e-3b19-08db270b9583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxF5Epjl2doiqAv9+9jNgLcLOTEKnXAP2S9NsG4XgiFrdScKKdW4nQoc4gR4FcmfNAKqZw6MUXtRnJqIzG15++W0PTNIIqYZ5SN/JaWpSWUrHOnaYJf1besUDLbhDO9NFFhvOIcJBQIHfBuD4qDzEBKsGUkgq8PLMWM8Z/Pb5jL1qiJvkjngSpi5oBRrI2mpaVAyuoeSymlpvBng1wPVp6cZyX78zCXf1EDR2VP8zt8UlSszQvcnaZTWaA9hzAhLro7gEoACW/5165uYwVFmDva6duFmZRx4JOLYhgp2RbSl2K1E6MK0solHMXeMPx3JKrePTOC+p/Ghr8Mq96V52FGOnw0zP5JwegiZ0DrFRxQV9xZOLPZNYJ9tgT1uWU+1rI6oNMwnpBKtBP5r6AGcyB5yo/8aA+XrfmAGnTygtOAj8flTmnVhDK48T6iFcppW8Nj9gaxrl2cNNiAGYjCLKjtQ6/tBsDR6yEiZq/0X+rrXotYRrdpCdxpgINb8jnHGxA2ssttVLTr0RAX5ctzdMcG668T7oBSS5wihjsIa8L2QSo3sEjsrsFgWXGeq5lX9WD9gKF+43yUGbvU1axvJuKVMmqlr5/m7yyh5GyH/JS1uUUqRPi1iN1LcDGbtuWXswidCYZXCJg5rEloHprZudkpb3MQsIR9MBShgHPCsmtelPpy6qpc2P3r3TTuxx24R2WUh71DiS0x3cM/FzNImZ2sj8YzfMk9gwFIkJg8xEUNT4UXrr7jEvY0OBrrtYrPMSMyR8sPYbVZiwpXFZA+fag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(4326008)(6916009)(5660300002)(41300700001)(8936002)(2906002)(81166007)(86362001)(82740400003)(356005)(36860700001)(36756003)(70206006)(70586007)(6666004)(7696005)(47076005)(8676002)(336012)(40480700001)(82310400005)(478600001)(316002)(426003)(16526019)(2616005)(186003)(26005)(1076003)(83380400001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:10.8961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a544f505-944b-4d4e-3b19-08db270b9583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XXX: don't apply this until we get the final FW versions

Used to get the size and alignment requirements for
the gfx shadow buffer for preemption.

v2: use FW version check to determine whether to
    return a valid size here
    return an error if not supported (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0a507b7939f4..87b3d777e9ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -822,6 +822,32 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc21_grbm_select(adev, me, pipe, q, vm);
 }
 
+/* all sizes are in bytes */
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_SHADOW_BASE_ALIGNMENT 256
+#define MQD_FWWORKAREA_SIZE       484
+#define MQD_FWWORKAREA_ALIGNMENT  256
+
+static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info)
+{
+	if (shadow_info) {
+		if (adev->gfx.cp_gfx_shadow) {
+			shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+			shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+			shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+			shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+			shadow_info->gds_size = 0x1000;
+			shadow_info->gds_alignment = 256;
+			return 0;
+		} else {
+			memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+			return -ENOTSUPP;
+		}
+	}
+	return -EINVAL;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -830,6 +856,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
+	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.39.2

