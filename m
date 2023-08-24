Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF8C7EE43
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CF610E5D6;
	Thu, 24 Aug 2023 21:32:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBA410E5BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKL0K/NBZ9Hjar/o4L8HSAx4JL28SefObJSIpdQTAxA+/XEoqcndLbZV2ScGfNPrOZaQ4tToo3hDKaSRDJTVuU23+gWPVVHvepTUeW9LJohWw4UWBK/3ruHxHk/FPna6PasWT8G7k/rWyfFeIev+nnH5ZPL6PLx/ZVWxAggT/1vHrKy81b3h9d2JiMfp7IbLaff/mZ3dIFtEChYJGffSD01Tj9IJU/Vdsyl3vG6Dvg0osnywRqsy3ngqY50Wr85X7Z9+hbRj/oSCkdt7Z5kumLNsbVs/lrwc5cUjMOk/4fLIpdtltyPBHpMu/uHL4qQeOUYXmHTlWk5aolnBUCs15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p81tm89yXU5EN+9a4tTBB886dpxjP2HxYptWHPD6A5s=;
 b=KQR72SetmVn54pqp4rUCdSOVMvBCbaBow9VJGi7klnlrleCLGrnPhBwWfw9JoBRVRp3cHeZtNDguOAUM52Uqs0bF58YsubEQUhHTvXohwzROM7nrfqiSE3tEHF5ZcA8nDCszKl8qpgNySidzsdzXg8fX9A94XlgEHaE5WZ0qsj2HpbFXhaA0qke3ZA8TvdCvZLfsjTvGifyFaDGm4HlxDCmcoXSyza2w/r4tRq3085H4m/WzhYBIWSMT8JhFgv/jZL2hx7jCLQ6IYiPM7zDgT7jJadY64K82sg3FyeedcuoC18oQ+qBfpK4bDC443+9gEcwBXX0+aasJ5C8pxePmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p81tm89yXU5EN+9a4tTBB886dpxjP2HxYptWHPD6A5s=;
 b=wJ04mt2q9gH/lHM4nFVddxPMmMCD3DC/tYzBkalqEFgCrhICrsTw83Mgt4+vl/36CZYzqwyjAguGOXab9FThZ/T7eMY/R8YP5LCOdcIHvVkn3TrK4O6aJrkY6C85PC0XmDdUut8TSzCsJ1YHhsRzll7c/O+YYG/wK502R1yagbI=
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:53 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::4a) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/21] drm/amdgpu: add PSP FW TYPE for VPE
Date: Thu, 24 Aug 2023 17:31:20 -0400
Message-ID: <20230824213127.2725850-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cca09a6-157a-403e-6c4f-08dba4e988a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7VGZv124dASfs2GL4jzkwTx7YJ+cRqW5RZ83i/sGxZ8JVODtq+8jbxNXmjU2PqMaU+5AaKK32qjT/HYkqxcS88c/dZW4D8CLvkII5Y5bhhsxD1+cqQaXRL4zdGHJcCB41QNQR102ZPa6AyWYkKAI/5hGFAnFuj93y0EGsEQo3rBw3dF9siSlAnRC7NA2x281rKjiivMdW15KYNvPPY0dTh+DleQef1wWiuvhqU95RdfkDfk0QChQvGSQHz6o3tyd3zEGCt+p9FO1p9k0N/jtCuGTWPtH5rICbI16zIb8ld/0hKKpnKFGbqTZorbumCh6c8EA5ZgU0Y9R6Ajwg7FDAzTAdjaT6Fiyb0YEaTUdo1N2LpK0S8pcwyfvPJ3TlMbuHQy4lJsI3ZATg38vol710x8h/D7SYF4jI2A2f/K94NTzBLr7MfAfNQnAuHmV8MbmG3gMN9m5gBfHVAfUpprLDJe2LPXkL4/3CUvDrYUTCrk56cGUSiLq4NPYjF7pdf4j32AzcJ+jjqT1jeZmY2pkmjUmkOGl5E8uKt+HT1NGmAxCmgYvjjDPY4AXo+qSHa9HgAKTJtih2124OTWKBx1d4hud7jqKToCGOZu5om+wQcmfgajfiy/lXdJVPIVn50HyXurhqWr1AlLPbEqBYZ5+qjlm6Prpa7JD4K6BRpNH+Bd7VGf2RW+e/ThD3mSYlHSO+zjm6H4U5FVtKHUwYCDVduRycIa6peh494SnNd3zOR7mUBPKWx6wF3FmE6k0b6EYTGU/G0HavuEHIybVhAdlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(86362001)(356005)(82740400003)(81166007)(36756003)(40460700003)(7696005)(6666004)(478600001)(5660300002)(70586007)(54906003)(70206006)(316002)(6916009)(2906002)(4326008)(8676002)(8936002)(40480700001)(26005)(16526019)(426003)(336012)(36860700001)(47076005)(41300700001)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:52.8306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cca09a6-157a-403e-6c4f-08dba4e988a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add PSP FW TYPE for Video Processing Engine.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9acccd76fbd..0eef555e3ef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2390,6 +2390,12 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
 		*type = GFX_FW_TYPE_RS64_MEC_P3_STACK;
 		break;
+	case AMDGPU_UCODE_ID_VPE_CTX:
+		*type = GFX_FW_TYPE_VPEC_FW1;
+		break;
+	case AMDGPU_UCODE_ID_VPE_CTL:
+		*type = GFX_FW_TYPE_VPEC_FW2;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 18917df785ec..fd11115429c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -293,6 +293,8 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_RS64_MEC_P1_STACK               = 95,   /* RS64 MEC stack P1        SOC21   */
 	GFX_FW_TYPE_RS64_MEC_P2_STACK               = 96,   /* RS64 MEC stack P2        SOC21   */
 	GFX_FW_TYPE_RS64_MEC_P3_STACK               = 97,   /* RS64 MEC stack P3        SOC21   */
+	GFX_FW_TYPE_VPEC_FW1                        = 100,  /* VPEC FW1 To Save         VPE     */
+	GFX_FW_TYPE_VPEC_FW2                        = 101,  /* VPEC FW2 To Save         VPE     */
 	GFX_FW_TYPE_MAX
 };
 
-- 
2.41.0

