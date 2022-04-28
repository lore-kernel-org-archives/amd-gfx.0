Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571AEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAF910EA09;
	Thu, 28 Apr 2022 18:45:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E63010E996
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha8lVRMdKJHo4ijss/6fzLnddX7CsMTXs0jZxs3TiTXLyjH8n4hwjKfj0UOnkOoshWUwmx5x7zCEloTdmmh9uI72QUaihZ4VJLQYSKcTv7adjBPp5126KKtXZyxpaxwMoRErRkRw107cIcfQ++bjPTM734Qfk4t9othd8rWakevhZIbFsRh42HlZk4P5jLlBQnvaHUygWSe+f5jrZsviWE3FBFacnVGhZQJXjj/Qz+PLVf/10rwyKNFdNlVGwuCqCStYMPybeJVJGxPOdm4zKV9kKpWQ7VDI0BS66lmybYrEY3YAYXfCchAyxn3o009jHw36KQVo99Q6+l4eb35tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9za+gCze//F+y2xbE5OslIP1MXdX2FeoYK5OlmZKiE=;
 b=OhL8+0SXySl5Z2ykKiwctIosEqkKjUdtViIwd7H3C0lVpAdu75Lx5qAuaQTKnSLDRJglTYn5d3gpaFI6j+BhGI3O64kJSzv01ayjLKDJO268yjcd+OtN5OmJccC4b0soB3kZ3DJmTvJp5GBehFh0Bw0rzXbVwglUyy6PYq3Vrmu6cED7wgWNeo9dfSYwHB+GfHNyMFFk+uwtju/a/CqiMYSEZBtT2/pCO3aNOTB9DaFfveICxSuUY6EniOi5n+DfqqvGoaGvcFb5vFwVma9p6dXjLqFTQkWUQtSglO0kxFpj37asyCTwOBusUesF+efptSwmhUXflOdO43e3O/Ul8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9za+gCze//F+y2xbE5OslIP1MXdX2FeoYK5OlmZKiE=;
 b=yrHhy2fGr3PuPgUxIOljOcL9Ta3BhjZxfvQ/Lqglvcp3N7WgSGCIrU7V0oz+WMShTEHzV+t5TVJZVyMnT4GsG8rFiud4eCMHgH7rrA6DEXxAN+QmKFgVExC9kkOQXIB9TxGalVoCMb1v2CzhcrvByRBpOVZxp+UKdnA6sfkPYYA=
Received: from DS7PR03CA0193.namprd03.prod.outlook.com (2603:10b6:5:3b6::18)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 28 Apr
 2022 18:45:40 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::23) by DS7PR03CA0193.outlook.office365.com
 (2603:10b6:5:3b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 28 Apr 2022 18:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:45:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:45:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: add tracking for the enablement of SCPM
Date: Thu, 28 Apr 2022 14:45:19 -0400
Message-ID: <20220428184520.651971-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428184520.651971-1-alexander.deucher@amd.com>
References: <20220428184520.651971-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c3b84aa-3a81-4d39-696e-08da29474ac0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4151A52F86811DC5B492F01CF7FD9@CH2PR12MB4151.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2usUrWrf3RFowKHyERizEJMZYeH+85U1ultW+XRRwb5FqCvc+Umrn4Swm+hOf4lfDuoHttMQMhLKindTtbTMkjeW10kcAJy1bivtoowKOPdMDTUsxrkbPKo7H/pybeJ3Pg9n2nObQRgmTLpj5Pkoh96AMqp1AfEBM5k41CJI82RgQszOMVOMYhmpizdn5iST0Nbfz4YFH6Ulvg9JDUHjgrE2hl+Ske3iOtcFHrFQ8uU2Kka3F0Cg+DGganXppLaU9LOO6r2CNXcrUZ2w1wvTK9oyIc0NxrlckuMpaaguaPCyc4uv4NEoFQwM8ApAKNI8cAq1VmGKxnumka4/fSQpWTOJb47g6OBW8p0AV2vvtksmL8NVOGvSgeBC8LkK0felrkI7YrifsUsXNYrOkqvInQ5JBJIVKImwwTpHs9hBcLMbLBHYKC7JLgwZNYK8llCOKi9j/pO2lG2J+ZOOMBt2E0aE7QdnAV045p5jPS3ly0IHgJLHdOi4q55EVFXPtNZsVJFalnEvCLJVzcVLrJUkruPML1yCl3Tz5j4X668ZSTGAo10PylHPbXtsVpZPqucndZofUWS7GnrhsuL8HrOfjuU23q1BO2fngRFZ5RZC8dxdvR0u0+EI+USDrcWOsXD3RJPB1f8tticyZKxGjfLokVFc/igV1Z8H5mjElqHT9OEzzure1TxNeYESTNdc4V62KWdDiEbxpcWrQKL+jinKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(8676002)(4326008)(86362001)(54906003)(6916009)(316002)(2906002)(6666004)(36756003)(5660300002)(70586007)(70206006)(8936002)(7696005)(508600001)(47076005)(81166007)(83380400001)(1076003)(336012)(26005)(426003)(2616005)(16526019)(186003)(356005)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:45:39.8949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3b84aa-3a81-4d39-696e-08da29474ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add parmeter to shows whether SCPM feature is enabled or not, and
whether is valid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 28 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 13 ++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 05358c587783..1a598e3247ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1016,6 +1016,9 @@ struct amdgpu_device {
 	int                             num_regs;
 
 	struct amdgpu_reset_domain	*reset_domain;
+
+	bool                            scpm_enabled;
+	uint32_t                        scpm_status;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 867ca5be27aa..890259d4414a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -246,7 +246,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 			case PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG:
 				if (db_dir.entry_list[i].size < sizeof(struct psp_runtime_boot_cfg_entry)) {
 					/* invalid db entry size */
-					dev_warn(adev->dev, "Invalid PSP runtime database entry size\n");
+					dev_warn(adev->dev, "Invalid PSP runtime database boot cfg entry size\n");
 					return false;
 				}
 				/* read runtime database entry */
@@ -254,6 +254,17 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 							  (uint32_t *)db_entry, sizeof(struct psp_runtime_boot_cfg_entry), false);
 				ret = true;
 				break;
+			case PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS:
+				if (db_dir.entry_list[i].size < sizeof(struct psp_runtime_scpm_entry)) {
+					/* invalid db entry size */
+					dev_warn(adev->dev, "Invalid PSP runtime database scpm entry size\n");
+					return false;
+				}
+				/* read runtime database entry */
+				amdgpu_device_vram_access(adev, db_header_pos + db_dir.entry_list[i].offset,
+							  (uint32_t *)db_entry, sizeof(struct psp_runtime_scpm_entry), false);
+				ret = true;
+				break;
 			default:
 				ret = false;
 				break;
@@ -298,6 +309,7 @@ static int psp_sw_init(void *handle)
 	int ret;
 	struct psp_runtime_boot_cfg_entry boot_cfg_entry;
 	struct psp_memory_training_context *mem_training_ctx = &psp->mem_train_ctx;
+	struct psp_runtime_scpm_entry scpm_entry;
 
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
@@ -318,6 +330,20 @@ static int psp_sw_init(void *handle)
 		!adev->gmc.xgmi.connected_to_cpu &&
 			adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 2);
 
+	memset(&scpm_entry, 0, sizeof(scpm_entry));
+	if ((psp_get_runtime_db_entry(adev,
+				PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS,
+				&scpm_entry)) &&
+	    (SCPM_DISABLE != scpm_entry.scpm_status)) {
+		adev->scpm_enabled = true;
+		adev->scpm_status = scpm_entry.scpm_status;
+	} else {
+		adev->scpm_enabled = false;
+		adev->scpm_status = SCPM_DISABLE;
+	}
+
+	/* TODO: stop gpu driver services and print alarm if scpm is enabled with error status */
+
 	memset(&boot_cfg_entry, 0, sizeof(boot_cfg_entry));
 	if (psp_get_runtime_db_entry(adev,
 				PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index cf8d3199b35b..a9fe05c38715 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -244,6 +244,7 @@ enum psp_runtime_entry_type {
 	PSP_RUNTIME_ENTRY_TYPE_MGPU_WAFL	= 0x3,  /* WAFL runtime data */
 	PSP_RUNTIME_ENTRY_TYPE_MGPU_XGMI	= 0x4,  /* XGMI runtime data */
 	PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG	= 0x5,  /* Boot Config runtime data */
+	PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS = 0x6, /* SCPM validation data */
 };
 
 /* PSP runtime DB header */
@@ -278,12 +279,24 @@ enum psp_runtime_boot_cfg_feature {
 	BOOT_CFG_FEATURE_TWO_STAGE_DRAM_TRAINING    = 0x2,
 };
 
+/* PSP run time DB SCPM authentication defines */
+enum psp_runtime_scpm_authentication {
+	SCPM_DISABLE                     = 0x0,
+	SCPM_ENABLE                      = 0x1,
+	SCPM_ENABLE_WITH_SCPM_ERR        = 0x2,
+};
+
 /* PSP runtime DB boot config entry */
 struct psp_runtime_boot_cfg_entry {
 	uint32_t boot_cfg_bitmask;
 	uint32_t reserved;
 };
 
+/* PSP runtime DB SCPM entry */
+struct psp_runtime_scpm_entry {
+	enum psp_runtime_scpm_authentication scpm_status;
+};
+
 struct psp_context
 {
 	struct amdgpu_device            *adev;
-- 
2.35.1

