Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9764EEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 10:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1026410E4BF;
	Thu,  6 Jul 2023 10:00:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD8010E4C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 10:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHDbaFIKLN7G47GWkAqr1NultcwOIm2ExoPSTohWG6n96Os9oyUUkNit0XLuLyKnj0tKkchxpa7k5TKsEN0Ua4nvOU3qnWl/i/c/dqo4xeFGW+tGxqydI9qUpqnB7WHlaNr8wau0p2PmenjNFunmn7H6bNV1OFX79kmIAKYp2Ob9WNovOXGPoCLTM92tMHED+fiSog4EvoNYC4xRb5flZDfj/YzAlRy4IcnAcJJpVgzQFaUgfKlzIxc3gMYJL5I4xf1JmONiPtolqwxE3qBRHD/NRn51o1bfj2pFFRap3DgNF3d1lrwGdjhSOqjLNdZZyh+PPTGVt0BLATyeDVsmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxXhlnSJFhW/LwunLSDokp6pGUgbStlvXaDGGg8SmLo=;
 b=klDVctJ9U22kYcgxXP634rfoQYNsSPSnX5ykMCqRv/PvjWUpoRy045crsSZ2DjqfiYSbizccLEIFP7Bn2jZwziyXFWbi0/cN2ZuAWWPG/gJZz7tI7aJ8vU6Xzbg2euu5nIWhb5Bn1r2HNeQtfMHVyhc1v8atEBbmwOHlnLZ8EEDXzCqu+v7TzShixpdtkaUuA+MuOJ1HATOutNtMr7hR/F48gN16A5xupHHyQEBhyH8kFkVfa8BbqrkK9i7c8SeIjzj6zLsaKq4xcTduepj/fheosb9ysDWu4MMXmr6sIULlRPc+re35st+BT67P5OMx8NL3uRanHl7zDuog7+ACDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxXhlnSJFhW/LwunLSDokp6pGUgbStlvXaDGGg8SmLo=;
 b=tOaPuDdRZWhcPNRXuhqb6D5N6HlvulMGAseRGlsrdLYX9/HOT4l7pRXHU7TaFJCDkWR95D+AwjUlD6zI/V/ePTvGHn1xxzjxBVcL4BL6Wfo6sWD6QpTgyRr20naSdhfaHYUD30WcBnNAvlBtHFCvCpHZXAk+KWwu9ltdu6CWI7Q=
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:00:36 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f8) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 10:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 10:00:36 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 05:00:34 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add watchdog timer enablement for gfx_v9_4_3
Date: Thu, 6 Jul 2023 18:00:24 +0800
Message-ID: <20230706100024.24911-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|CH0PR12MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e897d02-22ad-4c49-c38d-08db7e07d850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY/NDYO+KXj+ReAes4u1P+LA68eeqOpeiF2LZ2yB7BRF3Ihzc2BI6S5kHy0XavM/zhHGzkvVMoWDavLlVQ6wfXfdn0hOoBSO++fJTosjhjHcp/lmPRxbCwCKvPHG4Wih6OEc9b/Mlx0aA1dHgYjGFM295BTmsgzME2DAm2uMPeNSC8gw1FDNhCu5CPR+p1N/ikUFYw1to2UTRK5W35xUXY5ccXLpxe4ye1WBf30q1UKX9fdt+LmzDcyvso9xKVRGzlQA0jP7j6dfseDlSFQCKsBseeeWfrEWGOMcZ+iR+VydWIt/PuK0eddGwgDaqm+mfQe6APP6Hxz4G88ODo1HBL/szXFOfI/WFx7Qynaz9cGG1JKEpjF2xrwZI8WV4mVfWzCIEV+hWjHB0w9WOuESRweTrbwiZ8byy9Z6OJnARpA2z5g1KceZPmfpJwNMc+MNhO5oqGHVc+5Y8TOjKBLGQIaU+GheYdFOESO4LGisVRwE+aNowsimDiUi7I1saGVkLmMVsSczPlJZhN526aUkXdlR1imDknsvw8l/ARiduHAMBocjz21O9+L6Mcw6nes13V/4uNMCVCd71ad1ZPJdz9i7+cR63ep2JRECM0KwEtmUhYWFnhYc/HjvYRY0dCSi39TE35eFraqhZsWyGO/QH6r1LtCFvDssDU5MgR6G3N1NTVF9lMUTgnOj3ldlmbN1CSNTOr+XOCGKjL2bJ1kce3ycElXahfqygrdovk35CJjYfzi4k1P5N5BlKGENxwvv6BfyPlUUccQeAfd+6f99ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(478600001)(6666004)(70586007)(186003)(16526019)(1076003)(26005)(70206006)(2906002)(82310400005)(4326008)(81166007)(41300700001)(8936002)(316002)(40460700003)(8676002)(5660300002)(6916009)(356005)(82740400003)(36756003)(86362001)(2616005)(83380400001)(336012)(36860700001)(47076005)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:00:36.1318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e897d02-22ad-4c49-c38d-08db7e07d850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Configure SQ watchdog timer setting.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9e3b835bdbb2..590b0fa62ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2197,6 +2197,10 @@ static int gfx_v9_4_3_late_init(void *handle)
 	if (r)
 		return r;
 
+	if (adev->gfx.ras &&
+	    adev->gfx.ras->enable_watchdog_timer)
+		adev->gfx.ras->enable_watchdog_timer(adev);
+
 	return 0;
 }
 
@@ -4043,6 +4047,34 @@ static void gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
 	gfx_v9_4_3_inst_reset_sq_timeout_status(adev, xcc_id);
 }
 
+static void gfx_v9_4_3_inst_enable_watchdog_timer(struct amdgpu_device *adev,
+					void *ras_error_status, int xcc_id)
+{
+	uint32_t i;
+	uint32_t data;
+
+	data = REG_SET_FIELD(0, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,
+			     amdgpu_watchdog_timer.timeout_fatal_disable ? 1 : 0);
+
+	if (amdgpu_watchdog_timer.timeout_fatal_disable &&
+	    (amdgpu_watchdog_timer.period < 1 ||
+	     amdgpu_watchdog_timer.period > 0x23)) {
+		dev_warn(adev->dev, "Watchdog period range is 1 to 0x23\n");
+		amdgpu_watchdog_timer.period = 0x23;
+	}
+	data = REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, PERIOD_SEL,
+			     amdgpu_watchdog_timer.period);
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
+		gfx_v9_4_3_xcc_select_se_sh(adev, i, 0xffffffff, 0xffffffff, xcc_id);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSQ_TIMEOUT_CONFIG, data);
+	}
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+			xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
 static void gfx_v9_4_3_query_ras_error_count(struct amdgpu_device *adev,
 					void *ras_error_status)
 {
@@ -4065,6 +4097,11 @@ static void gfx_v9_4_3_reset_ras_error_status(struct amdgpu_device *adev)
 	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_reset_ras_err_status);
 }
 
+static void gfx_v9_4_3_enable_watchdog_timer(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_enable_watchdog_timer);
+}
+
 static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.name = "gfx_v9_4_3",
 	.early_init = gfx_v9_4_3_early_init,
@@ -4393,4 +4430,5 @@ struct amdgpu_gfx_ras gfx_v9_4_3_ras = {
 	.ras_block = {
 		.hw_ops = &gfx_v9_4_3_ras_ops,
 	},
+	.enable_watchdog_timer = &gfx_v9_4_3_enable_watchdog_timer,
 };
-- 
2.35.1

