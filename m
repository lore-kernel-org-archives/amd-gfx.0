Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCCFC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF8410E2FF;
	Fri, 12 May 2023 21:44:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B638A10E2C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG2P/2BNedHw69nvPBX3aaEvXiZN6RBnRT113G3jUCNT5N+VQFQqFrwx+7o+qbapcwywdpno10D7BAiwbbocpHskrYmfzN/2OgYyHf7kdY544gSHXD1B7d88sXcUBlGmFJWV9AUwE+8Zxj/5yc5JYXCSWPHET8Q7rCRxDA8rEX2pNxx/ApyfdpvOpvVzeYYZX64nrUwVhoYG4qQEHQyQBQaJecaqi4xt+7o8EVP7053irmuoIkisjzvHn+NIjLS5fvFfvp4cIxNQwrZdX98nYDtjD/AVPIuiRkCwfgHgUOYicWoDAW6ArwJ+Q7q/HUzjDm/+g+GPQRuH/J1B0e0/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oELZCQB2PJsDE+Pma/pkWZaI30/3ksn3F/8fmnpiMog=;
 b=HYj1uCyerfPo4NFsecF80ZQvOIC6QVZRcbR6/36I6zxhY0LI6JZvG2KMn27/dE2y2npbJcNB51VGJEsEGESwtIoK/4HzuMlQbAXKCYi9XdNqizXHhw8xP+BMubTnGomy+ONvkvIOp3OeJkHTg01AlIlk97Phj7oDuFaKGVyVN28o1IqOpZphJyhjYWxm4AgcPOSi8oyIzPJeA5tunHCSNA+dvMXXXq3LtVR1F0ojLxGel7cgr8r8GXKEIYIh8AAFGacjnAkfp9dumCNscvjosJyzaX85yyAlqUhvUw4s+dlpfbukYWujopyu1S7DQBJ0Bq0HTddBilgrVv6VEpqroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oELZCQB2PJsDE+Pma/pkWZaI30/3ksn3F/8fmnpiMog=;
 b=I/HsBesaWrVwDlcQBYUK+DiNn+nOoygj5MH3YUijWZ+b45G9scHI6l4a6H2ZSLZEqXcDsqvDIy0aoSETyDX3vmWcV301bWUL3Nab41RSb/+qz/5dm4R6fbrzpeFXN8isuRAcuKCqL31BezkQieA1QEY1y6vt11OBDvSUfkT8TKo=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 21:44:19 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::36) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amdgpu: add RAS error count query for gfx_v9_4_3
Date: Fri, 12 May 2023 17:43:48 -0400
Message-ID: <20230512214351.1356254-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512214351.1356254-1-alexander.deucher@amd.com>
References: <20230512214351.1356254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 68af4e0b-21c4-402b-b257-08db53320a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMU2lBIYzbGye99K66OcJpBjjEepYBw52crQxFQ1CZtCFxhYZVNzPiZvHQ5/zmg+LV67SI9cAnjgOvJeA2gs4Upws5WjE3Y2r+kp4BuX2oUDrs6zlBmzylojncWzWLvkwMCgUS1vkZfb+aNScz4Nmm/Fcs3A+bHRp7yiXQO40/9ZGuCirCP9Uami8gWXHRYkxILyyumV2azGk7cTbp035sHHX49leirXIreRLVDId0cJ3EwaA8f9Ac95P2O7D6a5xIj9Zaya/jZcKBVTb1+CzuSf4o5g5Iy1+pA6VdTkaGTpQMvqFIoaidnTrKQDSLdHSme5WY54CihlxGqa6U0aNWAfzE5AboBxKjH6Lp0Jlzi5NL1qdRMcdSVZopNxLWyZ+dK1rSiNdfLDaTcqCMWXsGil/JBZ3bRuyTmxW1+Hw+x5GM2mrgcO/cvMhytqIl4bxqBbC0L8XofEiSv1Yke9haXdvQ6VFAgfBkfc5Oa2nfqJCoTQbU6S/oxzRCB0Mwq5l1MC1ds5cLvQnX5VLk2TfxzUjLa/zN8TUH71ARDOuFsuj+hDuF9nZLCWIlakwjOSnVSV9MdChxJvPw+w5jrTXuQx5AWS0EMQioaU/Se4VaQUMAaFKavBL+bm1eS/F4NOYmkHUlxHhDC2pvIVaJlShTiEtOiEP7sbnIsEswkDlrzClge4G5FraqRV6l7juBDeUFl7P444501RiXYlbaNkGbSVTLfYfXwLaCYxOaQn4urubG9TMNvUq170Pbc55FuUhdcY+svj1kNg8H86QlNJFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(4326008)(70586007)(6916009)(70206006)(478600001)(7696005)(54906003)(316002)(86362001)(81166007)(36756003)(83380400001)(336012)(47076005)(186003)(426003)(36860700001)(1076003)(26005)(16526019)(2616005)(6666004)(8936002)(8676002)(5660300002)(2906002)(40480700001)(82310400005)(82740400003)(356005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:19.2809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af4e0b-21c4-402b-b257-08db53320a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Query GFX RAS ce/ue count.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 188b4d9a2cbb..bfd041ba51d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3724,6 +3724,55 @@ static const struct soc15_reg_entry gfx_v9_4_3_ea_err_status_regs = {
 	SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16
 };
 
+static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
+					void *ras_error_status, int xcc_id)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	unsigned long ce_count = 0, ue_count = 0;
+	uint32_t i, j, k;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_3_ce_reg_list); i++) {
+		for (j = 0; j < gfx_v9_4_3_ce_reg_list[i].se_num; j++) {
+			for (k = 0; k < gfx_v9_4_3_ce_reg_list[i].reg_entry.reg_inst; k++) {
+				/* no need to select if instance number is 1 */
+				if (gfx_v9_4_3_ce_reg_list[i].se_num > 1 ||
+				    gfx_v9_4_3_ce_reg_list[i].reg_entry.reg_inst > 1)
+					gfx_v9_4_3_xcc_select_se_sh(adev, j, 0, k, xcc_id);
+
+				amdgpu_ras_inst_query_ras_error_count(adev,
+					&(gfx_v9_4_3_ce_reg_list[i].reg_entry),
+					1,
+					gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ce_reg_list[i].mem_id_type].mem_id_ent,
+					gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ce_reg_list[i].mem_id_type].size,
+					GET_INST(GC, xcc_id),
+					AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE,
+					&ce_count);
+
+				amdgpu_ras_inst_query_ras_error_count(adev,
+					&(gfx_v9_4_3_ue_reg_list[i].reg_entry),
+					1,
+					gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_type].mem_id_ent,
+					gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_type].size,
+					GET_INST(GC, xcc_id),
+					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+					&ue_count);
+			}
+		}
+	}
+
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+			xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	/* the caller should make sure initialize value of
+	 * err_data->ue_count and err_data->ce_count
+	 */
+	err_data->ce_count += ce_count;
+	err_data->ue_count += ue_count;
+}
+
 static void gfx_v9_4_3_inst_query_ea_err_status(struct amdgpu_device *adev,
 					int xcc_id)
 {
@@ -3826,6 +3875,13 @@ static void gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
 	gfx_v9_4_3_inst_reset_ea_err_status(adev, xcc_id);
 }
 
+static void gfx_v9_4_3_query_ras_error_count(struct amdgpu_device *adev,
+					void *ras_error_status)
+{
+	amdgpu_gfx_ras_error_func(adev, ras_error_status,
+			gfx_v9_4_3_inst_query_ras_err_count);
+}
+
 static void gfx_v9_4_3_query_ras_error_status(struct amdgpu_device *adev)
 {
 	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_query_ras_err_status);
-- 
2.40.1

