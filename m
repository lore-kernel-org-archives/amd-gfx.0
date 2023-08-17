Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5312CC3DA58
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6218C10E54D;
	Thu, 17 Aug 2023 18:11:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED5610E09D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHC7AQj8sLMR+hvytdNVTAweXQLYbwD4j2/Y4QYF0hVdcMLEd54Jq5ZqHAu3Ou1lkPEdiwcuco/UAoqza9osMzQeqtB9oQRNvhG9ZDaWVa5GsFjyT87QX3cHy9RSxhJwpoMDRQrcEM9BEXhnzIlWAlGiHsGgI6ksWE/cWt/++AvwDIFIny2I3vOWel0Mw6DFq1CiAljQH2Fto68NfxowGQNBnIfsKYkadFoMdcgBy0xMcuS//5dsdFrebYVj0pfwrjgwmGTTLdeGMcWCe/UPXs046JKa/L+kdzjpcq1JSs3ZdipQAEaNHzQ0OrI9+F+X/zTg3roz4ZCNkmsCxRisqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhNAbF9yTiv+jwSEVsDo+rkjgLSTcE8WnQv9XYkyuEI=;
 b=mNonaH7SkHSoBgNh0alC9/Nrc5fahgR+f5HKXqYlJVpoqc0fNdixJC9WIIsJxvNcZnlNtdtoL/1Fe07fTfpu4wumOHfCDynBnhO7gN31gLKCZ27+XTTAdohUgbz4PvJzkS1DOWHTYpTQwpx/8lrjEQgGIp8vpIPKgHBIElaPal6g49ggUwIS5ZUMd/6sFZzdyq1nM0NpFFiPQTvrwxNFqusXicWxUUINc290ti5eAyiE23ZPSBpZmZDE958JWy0hj4866tKJPcxjMV3VJ0Q/3oZLjMVjINOTm69QShtpbOHITyEpYwuXH7rV5Fy7k32qWesY2AgEL2M+47IqWvXPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhNAbF9yTiv+jwSEVsDo+rkjgLSTcE8WnQv9XYkyuEI=;
 b=uzrz9s4d9YRzHNG6iv8KwJLJyQbIAYAFpv1cCZxGnVuz2WE51InOjfJ6gfXVVDQ0w12uQgZYv3Wd5N5grgmRVuWwoHXoCSgsDEP9eFxN/2zQ5WxJ6BOBDikM8cljNBTwdhbnCdZTKFWK/I31zaM15MeYcwRgZqkQcHc7nIqfjwY=
Received: from SN1PR12CA0104.namprd12.prod.outlook.com (2603:10b6:802:21::39)
 by CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:11:43 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::94) by SN1PR12CA0104.outlook.office365.com
 (2603:10b6:802:21::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 18:11:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amdgpu: add golden setting for gc_11_5_0
Date: Thu, 17 Aug 2023 14:11:16 -0400
Message-ID: <20230817181122.1543473-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH0PR12MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 608e4253-4cc5-4c95-9310-08db9f4d695f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvI6Iokh8oH8RVPwTtVnmm3oTuUAG3MxNQ542lAGwkQfHtxtKVE/OGmac70qNAXf/dNHET0L/asXy6lHoRaruTeS9p4gQz67ov6cHcGv7xEN2sxkDCA6FYiuEnflVgXvLXHRK8R3zrKbQ0dRrdbAuPjxQutNxusburgAAtyCm863kG3+OkpCNLzep2xPSW68/vTXoQ4fHIqAgVx7ZDdANZp1Ozpx4C08+3Sxt98qUXrmYe38QPVJSGcbzt4zIe0ZQUopvr77iploy1AwFQCeg9coeLjpUJM+rGZ0tS9Weisujgi5qCjLtDYTK61H0B5IjfurxHwtWEBElJG/eCyNCthXVCKqOUQIQw1lBTudmKP2w9Fs/VgEVqasy5xncuTFHCrsLGTbAThO32k1jjKTw1yjzFohhcf5zXno3FcDDPctby9ENp/TD/k+i8H9DEM+dpQd7Mbq8XbNg2aV7JUMaOBACyrlX0110HCM4rlV/a5PIOf4LmsAZo/cqJzELu+uG9ZJ4/fr1rt1fZPIas1P5BFPE5Na83M7ADLrNh472F9Fy3E/P6Rvo9wxmkpvcw2VIPt2psqpw+G1kgqDYvyGiKZ1DQEIcf0DuwfDqDr0HCV9vhwEo3uBS/W6hAFIW4fwuByGvX8aMsCyUArdOuVof6CuMiwriKEitMPX3s+e4psHAcPUS/P/nRYuyb0CWEeHNBUxHUFO1yje7F8/IS2jQWHDu6dHUG2CPYPjX6zqJEwoRt44FKOLIBqYzBd6ufiwNuqwK5ufPm41PV+g08Fraw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(86362001)(83380400001)(40460700003)(40480700001)(8936002)(5660300002)(8676002)(4326008)(2906002)(41300700001)(1076003)(26005)(336012)(16526019)(7696005)(6666004)(2616005)(47076005)(36860700001)(426003)(19627235002)(478600001)(356005)(81166007)(82740400003)(316002)(6916009)(70206006)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:43.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608e4253-4cc5-4c95-9310-08db9f4d695f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Initialize golden setting for gc_11_5_0.

v2: squash in latest golden updates (Alex)

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 25e93f6a8891..725b47027519 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -60,6 +60,8 @@
 #define regCGTT_WD_CLK_CTRL_BASE_IDX	1
 #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1	0x4e7e
 #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX	1
+#define regPC_CONFIG_CNTL_1		0x194d
+#define regPC_CONFIG_CNTL_1_BASE_IDX	1
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
@@ -100,6 +102,24 @@ static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff, 0x0000000a)
 };
 
+static const struct soc15_reg_golden golden_settings_gc_11_5_0[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_DEBUG5, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x0c1807ff, 0x00000242),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb, 0x00f40188),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x8000b007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff, 0x00880007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff, 0x00010000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL2, 0x007f0000, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xffcfffff, 0x0000200a),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL1_CTRL_2, 0xffffffff, 0x0000048f)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -276,6 +296,11 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_11_0_1,
 						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
 		break;
+	case IP_VERSION(11, 5, 0):
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_11_5_0,
+						(const u32)ARRAY_SIZE(golden_settings_gc_11_5_0));
+		break;
 	default:
 		break;
 	}
-- 
2.41.0

