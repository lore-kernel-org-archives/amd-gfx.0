Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22424C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FA410F527;
	Tue,  3 May 2022 20:51:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A3D10F522
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoBSFrZK7r56qqizeAVNaIz7AUwtuqK2YdqKf7oBScSgAfv7ZAqeHMoLjy7nRpJCsdIWj9wXsHgLanvg5Qd1Z2C/YZWLXa4116YLpXnj9Ezg/iB5PRneaNPkaICA3ovxTp9Iff7/lD6EVvKMx/msMwMSDFgyDoSW4JoFiPeRyAIra4pXgOFtBEWS2LV0NyDX7n5nRXKfRtZjNbiN295EY9Iv/EyP7liU/PXRg9m8w6ISOfBb3xEis/DWgG0sbrlUJgG+0/5Pc5mkWQ74oyyOkQcsdTPWyGuLaJ1VRnxJurHL+zjd3KpuBBBdhqNNmcH701TNX1xktShIC5nKL1S84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owBivk3dZaM7ax5NzAMiSxlHlhKf+0SRF0v+WpGnbfU=;
 b=hU2sbezLCodKjhU2lH0o+QCyslkjB+islX81xu7CLBCLmg9xOCUxJonOrVg8XCzkCA3lkuP/8r2DEaMD2iJHwhLz5bjuiOWzVgEDgMY2Jv9dguyo3OY0MsugXjiPmFD77d3zjwwqGyzRcvyYyHdIHx0Kr5olA2/O9q3mydBthGaRHYCYES7cghySOLpmlH4CS/ebAq64iLplpXrhD7+1KZ6fZtgoW7xsXr8gj4G/Y4mcGdL4My8K7VuTjCsZYlN3Z3Gx6IRaNI7dxUnSaiKDtxy9PGLSURyA78Ia0MvJNdYWNYJ/0FlgBVvfetDcGj8T7l6/Oh5lEU1WwjlLu3OpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owBivk3dZaM7ax5NzAMiSxlHlhKf+0SRF0v+WpGnbfU=;
 b=dbFcJ1c9FaZ8TqvhgY7jaoG80+riwcMNn7UYDZuAX/7c8gRGrQVL1l/bjBTpUqctpgEk6X7ADELnmuoW5kYytgIHIf6bsEs4ok0DDBTrj+o1dnaY3VYjH1AhMJCWI23KbOF8PMn+UI9k55WXYmGhoZ+hvFLLpR8irgbtvqMAUDU=
Received: from DM6PR08CA0048.namprd08.prod.outlook.com (2603:10b6:5:1e0::22)
 by BY5PR12MB4802.namprd12.prod.outlook.com (2603:10b6:a03:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:51:31 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c0) by DM6PR08CA0048.outlook.office365.com
 (2603:10b6:5:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add gfx support for GC 11.0.1
Date: Tue, 3 May 2022 16:51:07 -0400
Message-ID: <20220503205112.1285958-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c29736b-e6b2-42ea-0719-08da2d46b399
X-MS-TrafficTypeDiagnostic: BY5PR12MB4802:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4802D37562A64D6DF49053ECF7C09@BY5PR12MB4802.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUhBVHdL38sjQQv/hoRi4E2QRiBZ6bw8GalRLDpxXRTkLLO2l88XNsXnU2ZwDUzQSP6ySM6rKoLytoj7RyrmNgXRxmP+aHbkVne6WrKGOLOYczlCPiOo8/+YBmabRH9yLZE/SzS3N+qdy6fiZWLmjffcrx9BMk+bSewVlElrtQzKo8pHIo6jPOTYQtUnixzcBdMfR0QR83jpaEEqhlDZ0C7e/j1FeEeh1FvkLx9CWd/un/zqq01Jeiaq/mZttSsVBrREfFG9qaROX4NVxJ954/1LEEg+lfrRCmBmAxIZffnjmVWk+ViuZOdI3xAMpY9G9Fezkxia7qx3TWQRZhkV+yaV5Zdueb2ntlJJ0EsUfMEnIOkLJgJe/aodtCKIfb49f5Fm7UbVHp3DYPIBfJgG8IqQ8yojcKxyUf7q0COU0vXX33ibi5FElexPOEKabm950/qfPAe3TQk2yGm80XZv6pn+gn28sK3W/ycNTUOOzyOdR1TMHp1jHeUox/oCtdsdOkaW3aZNBuxTXMG1TI56LzjQn2Y29EYMl4Ammjx3XWqJQ3VUAoKY6jy2CM9NaLB2b1vVT6sirYfADfET8rkJUvuLVujDL09dCmqcrHn80O+QOPHDrpMsYyFapxEyy7/ij+jRll3VzoicaSVN49/HFCRPkYFL2EIDypW45wA2c+GB6icxwrjBlj1jsLyOuBh+3qdj64qaU9azfbSPI8jTJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(4326008)(6916009)(356005)(316002)(7696005)(86362001)(6666004)(2616005)(508600001)(36860700001)(26005)(81166007)(47076005)(40460700003)(426003)(336012)(186003)(54906003)(1076003)(70206006)(16526019)(36756003)(8936002)(5660300002)(2906002)(70586007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:30.9520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c29736b-e6b2-42ea-0719-08da2d46b399
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4802
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add GC 11.0.1 gfx support to gfx11 implementation.

v2: squash in golden regs

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 85fddec0d4ba..fc3df3630c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -54,11 +54,18 @@
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
+#define regCGTT_WD_CLK_CTRL		0x5086
+#define regCGTT_WD_CLK_CTRL_BASE_IDX	1
+
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_toc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mec.bin");
@@ -79,6 +86,19 @@ static const struct soc15_reg_golden golden_settings_gc_rlc_spm_11_0[] =
 	/* Pending on emulation bring up */
 };
 
+static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_WD_CLK_CTRL, 0xffff8fff, 0x00000010),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regCPF_GCR_CNTL, 0x0007ffff, 0x0000c200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xffff001b, 0x00f01988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf0ffffff, 0x00880007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_ENHANCE_3, 0xfffffffd, 0x00000008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_VRS_SURFACE_CNTL_1, 0xfff891ff, 0x55480100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff, 0x0000000a)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -263,6 +283,14 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_11_0_0,
 						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_0));
 		break;
+	case IP_VERSION(11, 0, 1):
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_11_0,
+						(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_11_0_1,
+						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
+		break;
 	default:
 		break;
 	}
@@ -1133,6 +1161,13 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_hiz_tile_fifo_size = 0;
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		break;
+	case IP_VERSION(11, 0, 1):
+		adev->gfx.config.max_hw_contexts = 8;
+		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
+		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
+		adev->gfx.config.sc_hiz_tile_fifo_size = 0x80;
+		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x300;
+		break;
 	default:
 		BUG();
 		break;
@@ -1553,6 +1588,7 @@ static int gfx_v11_0_sw_init(void *handle)
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-- 
2.35.1

