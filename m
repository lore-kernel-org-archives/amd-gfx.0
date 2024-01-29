Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E6C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 14:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51D5112943;
	Mon, 29 Jan 2024 14:35:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8CD112943
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc0IXEgwjThJ9kqNGKsTIMqLntbTXful9ty6kwXZKAVOx+D0OGnKZizBZxklKxehnOuyq9KxsdgZDOHMkyRyCtbKN4ScSbCvg+d1BANEifLwsrCoLuMUOKZFoK5opHVBO7/xgtSSYKieeFddWhw8ERrLjpnjtifJn1F+9H8PTm4mBCK6xwyx58OocRvKOmK4AukBvwFUaHgtCAy3HbzNxVO1Yk9uKYxeMX69CW4YraWyyasdPr4Ta0L25/4QJX5TfoY7l7bMownacsPEaM4Gx3m7ScTe8rE9V+uK/HA2cB819Iiry5Tgk+3q6KKduV09CcODANkDylczLxTWeHmQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFwGRCCYYzmtRCOeiT/Jpx5cEIiJLxMJhT/9R7Fftmo=;
 b=I4buOmVElNBF0RX+GXZlyNo88tvF2qnsZuEQtP/yILxQUdsZ3dbtKmboo3QkEnyA34oi8pvGWGDbS9zt9ZqimTP5krkGnA8UTscZ3OvslCZK9o5BQwh6d9ONHHK0qRH4rB3V8v8yU7M10/ctCSaF4ap2iBzw+Li6UrRZaFxbxlNMdquy77pRGuyXWo/wx0YjaMXyqiw64NknSzQO/+4UzDoyunfbfIgMVyW2xMvG7byqAYjiRC/MD7aVHysG7+QpDw6ivk5lcjJMk82/zAXEKX1zekWCeqvgsByJCswi4DXQr2IiQLMXX+6aPQCXUrdv04g1LsAmEDDdWG89vOR+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFwGRCCYYzmtRCOeiT/Jpx5cEIiJLxMJhT/9R7Fftmo=;
 b=AHm7Ydf/DC1eUg3L/Pfo2ByhAdQBFvTutVPxFM/2guqzDPiWGy8+P2ft+9TraoMfOm21+t+jqDeHe2qe/jhYY4w65hm67EDUNpLWiH0sqJfvl1S+bq/ItulOi70Tx+KnoBQsyMv/gqT6X+UvJgxSHbfkCnHHjKEx2EQ6hLfPOp8=
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:35:16 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::52) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 14:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Mon, 29 Jan 2024 14:35:15 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 08:35:12 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update boot time errors polling sequence
Date: Mon, 29 Jan 2024 22:34:52 +0800
Message-ID: <20240129143452.16596-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 90398ed0-64b2-4e83-a5de-08dc20d7826d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50zDAFknEckl69XEp2PB3uaQqLn0/t8g45saP50Z2MHymUq3oJyETXkWeOyqGhh5q951Z00k1vgx/e+LKyx2/38L/cuTvXTTX8yukaHwReDERXh99pLfJtsEiQUE17Uk4zh9cNK501/vLrQ5M09F6eVIeRaySkOYyUHvhzst9kzVtLvEV8Do5DL5q7ef4wX0EqOxxw7ByMOTfWQ/pSsgrMlj1HRZdpeeI/LNLstMRueIyxp1IgRy/26Wytg//Ljlr/BUgxskYwnFOSGujcBsrGSfYcI+ZoxZxUxsDdCrlHyFbyV7NUbbgAO+ZPpXKKDue8cvL4ySoLy/ZzMfLRJzWdCsJESdYUE3/Wk5lHUsX1beC3NP6UiCWXuyO2HCXaHejDG2EBSGgi5zzhoiL5W8el76u+2snJSulp0DlpsJfzKtrwKcMVwrIh5GX3t1Xos2BIUlYCHV+x8rpOTkdeNwstX0eiv1SoLJxMOQi9v3fLy1dKj7DcGY44G0gudKRhBiLRWpJ8Z3zAFqLIcfym1oGGTzaD2PSrEyeyt+jn9ofAzyqtcSG3C2miXRTdhxO0MD6umtemXC+++hXLBBRsdA2mrBd6wXfP7Kr/penW4J51Nck75/6FBWZTq37Ng5z3vGzikyTSgu752imDw/oJDHYCpRwYamXKhanJaBofdzB1bWNIJzWLtVDQOUmRccCOVTn87nD1nueSTHD2ZHy3bbM32eExdFWOP1nxLHom1i7eXI/F+QSaIinGofFPXZDuI6c55chp9XAqL7oMvjdPyQxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39850400004)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(336012)(4326008)(15650500001)(2906002)(7696005)(5660300002)(16526019)(6666004)(316002)(6916009)(2616005)(26005)(70206006)(426003)(70586007)(1076003)(8676002)(36860700001)(47076005)(81166007)(82740400003)(83380400001)(8936002)(356005)(478600001)(86362001)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:35:15.7580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90398ed0-64b2-4e83-a5de-08dc20d7826d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update boot time errors polling seqeunce to align with
the latest firmware change.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9e67355d4718..9b7a5c1c9af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4122,6 +4122,18 @@ static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
 	u32 reg_data;
 	int retry_loop;
 
+	reg_addr = (mmMP0_SMN_C2PMSG_92 << 2) +
+		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+
+	for (retry_loop = 0; retry_loop < AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
+		reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
+		if ((reg_data & AMDGPU_RAS_BOOT_STATUS_MASK) == AMDGPU_RAS_BOOT_STEADY_STATUS) {
+			*boot_error = AMDGPU_RAS_BOOT_SUCEESS;
+			return 0;
+		}
+		msleep(1);
+	}
+
 	/* The pattern for smn addressing in other SOC could be different from
 	 * the one for aqua_vanjaram. We should revisit the code if the pattern
 	 * is changed. In such case, replace the aqua_vanjaram implementation
@@ -4129,7 +4141,7 @@ static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
 	reg_addr = (mmMP0_SMN_C2PMSG_126 << 2) +
 		   aqua_vanjaram_encode_ext_smn_addressing(instance);
 
-	for (retry_loop = 0; retry_loop < 1000; retry_loop++) {
+	for (retry_loop = 0; retry_loop < AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
 		reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
 		if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
 			*boot_error = reg_data;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 0b6ffae1e8bb..d10e5bb0e52f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -46,6 +46,11 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 13, 13)
 #define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)		AMDGPU_GET_REG_FIELD(x, 31, 31)
 
+#define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	1000
+#define AMDGPU_RAS_BOOT_STEADY_STATUS		0xBA
+#define AMDGPU_RAS_BOOT_STATUS_MASK		0xFF
+#define AMDGPU_RAS_BOOT_SUCEESS			0x80000000
+
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
 /* position of instance value in sub_block_index of
  * ta_ras_trigger_error_input, the sub block uses lower 12 bits
-- 
2.17.1

