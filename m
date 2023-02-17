Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9C3C636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 03:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7BE10E3D9;
	Fri, 17 Feb 2023 03:53:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB0E10E12C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 03:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMY/yCpgfChtzQDPrmjTOHxiKRsyQHyrjOkEflaZF3/jV3dhF32KTLLXmvVxGB907UrCzZyDnPAkqJ4B+cocZds4x8trobyL6+Mz1b+LqmpiD1Mhs9EE7+fqg0MLhhri3l4Ze9hxl8CdwBMblyqG8edhanev7G7H0O8UxMRgMe/hGCBviAFyPtkFUTn6VNK+C1aAA/mARo0nKmKqvmu0VvOQmMTp5QX8lHviTSaaE3XxjE2IXZoczkTxd0k/en63Faqf/q/c4oF3lfoYS9ld1dZ9EvrrVW8jzWdsTjmBvphVKtQdPrWpzGedkCI1/RBTGVQWZkRqNF3AKbZlkcRR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57CjCCi6B4u0Cb9EInfqLDoULPnTs1BV6/zUa5wBNso=;
 b=QIYb039Z0P/vTz6enXiN4qfMarF2sW/1Ao9FBtFYKoDZhYQLuPTqFw1ljWNqPUAmwY1oEL82YyVDhDnXD6AQPV+y3OnOrX44TWRN+mUeJwVCaJ64vJsMx0x1x2Dp7qBw3Sv/KFkhukE+xI+fnRZnU4NJpEQSx5ZGr5oct3pbhC3x06xW7kix0pkj7487IU31vacuXUhyX5iu33OaovPGLpPPHfkZ+wJnF9nKymx9U1CootdpCyUbrm9pVn/SwP3YPfB9Mqd3IsY2r/dO5hd5e8dyx86/OIX/sazeT4/leqTRNa7NIL5pv2SkDage7Okrnjg6fJUzSIaJvp8AaSD75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57CjCCi6B4u0Cb9EInfqLDoULPnTs1BV6/zUa5wBNso=;
 b=PRL62QRhZQufiBfjeteh+Ln2b65ZfP6wL8Ix6sr8MsYdjiL7HPif1AquAI5kpc0BqUOKBtC9j1q1oINIyxUVbOEnA6pRefzaeX+RiVbsBxtxPqm7PX/ufFfxl/8YYVY77Khv0MpkT7Y/B47sj5zav64cLXW5HqpzRBgOJ56dpU0=
Received: from DM5PR07CA0055.namprd07.prod.outlook.com (2603:10b6:4:ad::20) by
 CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Fri, 17 Feb 2023 03:53:26 +0000
Received: from DS1PEPF0000E637.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::e2) by DM5PR07CA0055.outlook.office365.com
 (2603:10b6:4:ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Fri, 17 Feb 2023 03:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E637.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Fri, 17 Feb 2023 03:53:26 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 21:53:22 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add umc retire unit element
Date: Fri, 17 Feb 2023 11:53:12 +0800
Message-ID: <20230217035313.4616-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E637:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf11f5a-76dc-4669-e900-08db109a85f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0B/6uvqQq2bE8tcO56AV7Df7QELS6BakhHAql0bDP9bxTZl+ce3lGrC2SBDw+E/26F2yTpszSHmV9O9os+vlayaFlbUI5VhG9Ppxu8+gP7lPo5MYbMmXILoZqXPnFclHDV2H2H8WO76imZQBKY/zjgPd83c3OaoT89mMewYmmdLQwfpKCUmnWcEGYbJQVPqUPGLP2mKuvL3yWV9OCT8K1/dxasRYn/kneKN5b5li7JCaMhwC6V/f/4Haucm2rMOQ9iIlE12UUjuiqeydqYiJpAbXT4zBgWI8LnMoieTMxK4uDdz//KMmvH/tAMbVsSyPbsz8jCJ8sJFSkAx9OnzUVVoFOdptsgSD/UquMqBeRYdOA9XzpkGK2/2uS/UHOCVtTNyQpv+p6ynmwqiwoEnTxcUbNTWZId84gQzurK6/7OpuJJZOeJ61ZrJLUiIh1A0dSnEMHNndQAuRCl+WNQPk6q2t7enRV13AFygpwzYmHx9CY0fG4JXquwXQd7mX1AYNaviL+BrHf35BTAtmzwdW9uiysHhJH09C6WDPoupuMkNiM0FYXAp050BExTZvFMWqQjqfSIJJTC/lSw27jFHBJ7XsHIKh/A7joeqJVnE3ut7nQ4f1AL9KXWSlXwupBL3fSatvZfMqbqNXPj4rMxRT0hmrex/r+M82RnwoVEfVUItulgbqc0f2xD8EGNjO+ExLg19JJJ6vxOnYAPH4kaAWerU4oXKTZXG6crom1KggV0o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(110136005)(6636002)(336012)(478600001)(426003)(2616005)(1076003)(36756003)(6666004)(47076005)(7696005)(26005)(16526019)(186003)(41300700001)(356005)(5660300002)(86362001)(40460700003)(8936002)(81166007)(40480700001)(316002)(2906002)(36860700001)(70206006)(82310400005)(4326008)(70586007)(82740400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 03:53:26.0704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf11f5a-76dc-4669-e900-08db109a85f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E637.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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

It records how many bad pages are retired in one uncorrectable error.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 3 +++
 4 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index a6951160f13a..f2bf979af588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -74,6 +74,8 @@ struct amdgpu_umc {
 
 	/* UMC regiser per channel offset */
 	uint32_t channel_offs;
+	/* how many pages are retired in one UE */
+	uint32_t retire_unit;
 	/* channel index table of interleaved memory */
 	const uint32_t *channel_idx_tbl;
 	struct ras_common_if *ras_if;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fe2c15f598b8..c59c2332d191 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -696,6 +696,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V8_7_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V8_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V8_7_PER_CHANNEL_OFFSET_SIENNA;
+		adev->umc.retire_unit = 1;
 		adev->umc.channel_idx_tbl = &umc_v8_7_channel_idx_tbl[0][0];
 		adev->umc.ras = &umc_v8_7_ras;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 0a31a341aa43..85e0afc3d4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -570,6 +570,7 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.node_inst_num = adev->gmc.num_umc;
 		adev->umc.max_ras_err_cnt_per_query = UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
 		adev->umc.channel_offs = UMC_V8_10_PER_CHANNEL_OFFSET;
+		adev->umc.retire_unit = UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM;
 		if (adev->umc.node_inst_num == 4)
 			adev->umc.channel_idx_tbl = &umc_v8_10_channel_idx_tbl_ext0[0][0][0];
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d65c6cea3445..b06170c00dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1288,6 +1288,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V6_1_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_VG20;
+		adev->umc.retire_unit = 1;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras = &umc_v6_1_ras;
 		break;
@@ -1296,6 +1297,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V6_1_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_ARCT;
+		adev->umc.retire_unit = 1;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras = &umc_v6_1_ras;
 		break;
@@ -1305,6 +1307,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
+		adev->umc.retire_unit = (UMC_V6_7_NA_MAP_PA_NUM * 2);
 		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->umc.ras = &umc_v6_7_ras;
 		if (1 & adev->smuio.funcs->get_die_id(adev))
-- 
2.35.1

