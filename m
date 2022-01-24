Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45713C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 09:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC0810E83D;
	Mon, 24 Jan 2022 09:12:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4FA10E83D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 09:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVDUo3EBuEu09Gkl3yTWgrKEtFLd8as7wBLIATe4TkSmX/wsU4xZsjvYqza934RD8kT0idZkXKh2JS3c1Md2avH1F0o+6HSOc6QJV0bTQ+1EeujS/70HKPPs93YBYC5meiLmDhAoIQ5xvpjxDJA44ZFkqQIR+jVQR9lSWT66v4YcevYZ2B93D3yItL0XO7Bu+LpJZ71Sh2ZaGOdDASRH10YqN8XIyBBtBaSpUWz95lfktFfn2t4D2Qf83GsY44Y8DN3F2lWGNNSGSpJgNCFhJZxqPjcGWqltXFWvUJ2QfxQXdB0qiOcO1yW9ANKq76tIpfm9o3+DKQ5CrY2stRDjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUL49vOepeZg/FIC16gRxlBscxDaFXacte5SNxXqWFs=;
 b=XzAkmCDDJpcuxCjoPZavrDxHJ6uFQmrza19KNlMYozP90LBCWpSiPsTQJi+tiKZaetRboD/uFj1HVyxVE0/iy1LpiqEX9Zo79YNLErUsZ1lshjX4VZBNCc6ojFa9dRAB02X5/BGsQUG9w6f5ELPmClT+2LaQRFtmmc3IK3wxkAvoY/7fZcka9vtJw3dc8s6AMUDh2VCl/QpJ4LPGe45Fh7wucXGLg03D+50r+odIitpPHAMXm2TElarh209wTB6S4vbajVRgBuGF1TtOBL7WH2/KU8NI/kctWG36SLEGB98wsQVLIQ5iyxUhTddFbRd6CkNLpcJ6yTahqJOyNn97rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUL49vOepeZg/FIC16gRxlBscxDaFXacte5SNxXqWFs=;
 b=0CmmjRDjI0t2edQzvxlSNja35FlDsWbI0Vl5jx2ooBng6x0KYJUMmYNSkyas6rhnsj2j0ca91lhv38LFpXn1GDKvRX0m/PbBQ6cvBP6hFhHy7tcQlKtYH74eF7AKq0tBLG/rEIhV3YnZdkbVYjD3yPLdbfD0Km763PW64N1eafo=
Received: from BN6PR20CA0051.namprd20.prod.outlook.com (2603:10b6:404:151::13)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 09:12:34 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::18) by BN6PR20CA0051.outlook.office365.com
 (2603:10b6:404:151::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Mon, 24 Jan 2022 09:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:12:33 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 03:12:31 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: add get_dpm_ultimate_freq function for cyan
 skillfish
Date: Mon, 24 Jan 2022 17:12:15 +0800
Message-ID: <20220124091215.335613-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f44ff9-227c-4bfe-4ae6-08d9df19a7f1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4950:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4950535F95A544CB2209D4A6FB5E9@BY5PR12MB4950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svqDahQEWVdtyztpfs5pj0AF3ToNOQ3fB6tpuLbkKbxhflq/MbAYQpH5yn94MwVOEjKYuloUN1BpaaaLZALips12CksArllctBMXya2GRQnnURt38DDPNfUpXCYn2AuMc9AlOR+KjlTC6MlrZUe3U8w69CEE8xMW9ec3PM9+qq3luMZ8mTWT3og4187cezCBqSwEd3LlYBdh3CirAXaI6XltrbAVyemJkLWwqAur33yq/yYdWnikLXst7xPvolcGqNxWRDIPj2fTKEfP9Fp5L2oy9JBPWz+SWeit5aMDJmxiBdBMqeAJhd3VCNdj1gCZEwu4FxisOm1K2Q5ANQtWUYFTtq69NJzn2RjCq+mitBuuPT3z4sBnXeXbQnQbN3PlhKTvwrlZSybDN/40V+XVeYujoXLxpCRkGLjauH/F/DdvfudTPhulfr3pIB/CaFjOARcBWlC2iUd+LWDrwAcRGbbxdUvucWUet4O/bU8AEmNOibhU6MRogB2/Yw+BTq33LYot175O2pqoRinoKTuLbScW6AcA0IqeRa1aVRQ9QJulwSts9cxKHN2hzE7hulHLR9EODbygBPKOzvifvVVezybHxv7v1TbFzxKYXOTCO3D5DnalDapJwdUmJPOV4k0rLNPUv+oQ7A8797hvksk0a2hfqx5Vb1JYlmqaEdzjqtL1pW7VDaSZSxM9KpwIGqKlTDCf5x447p9LGYl2k7SOaAqbm4ySn0FWa+y//ufH8PmHTbqR1xUTwMu0aJEV4BO9UNP3LvrCG+aHLM8YH6y1f/l/gZ9YpZfeZoV5yTcq2EY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(8936002)(1076003)(2906002)(4326008)(83380400001)(16526019)(36860700001)(356005)(8676002)(2616005)(316002)(70586007)(336012)(426003)(40460700003)(70206006)(54906003)(36756003)(508600001)(7696005)(81166007)(6666004)(86362001)(47076005)(82310400004)(5660300002)(26005)(6916009)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:12:33.4108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f44ff9-227c-4bfe-4ae6-08d9df19a7f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some clients(e.g., kfd) query sclk/mclk through this function.
Because cyan skillfish don't support dpm. For sclk, set min/max
to CYAN_SKILLFISH_SCLK_MIN/CYAN_SKILLFISH_SCLK_MAX(to maintain the
existing logic).For others, set both min and max to current value.

Before this patch:
 # /opt/rocm/opencl/bin/clinfo

 Max clock frequency:                           0Mhz

After this patch:
 # /opt/rocm/opencl/bin/clinfo

 Max clock frequency:                           2000Mhz

v2:
 - Maintain the existing min/max sclk logic.(Lijo)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2238ee19c222..1b58fea47181 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -552,6 +552,40 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
+static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *min,
+						uint32_t *max)
+{
+	int ret = 0;
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*min = CYAN_SKILLFISH_SCLK_MIN;
+			break;
+		default:
+			ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, min);
+			break;
+		}
+	}
+
+	if (max) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*max = CYAN_SKILLFISH_SCLK_MAX;
+			break;
+		default:
+			ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, max);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -565,6 +599,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
 	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
 	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
+	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-- 
2.25.1

