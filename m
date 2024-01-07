Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F50C47079
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4C810E0CD;
	Sun,  7 Jan 2024 15:41:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4904110E0CD
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGLLXI3YuIJS/ezscygTaXO/gbQKWiTwOlbKy6yO/ko9gEzhK/fDtdNc/5jlesH1eggJbIr+yJ66ACNPaQKsOVeXXevAF6uuIexkFG47fpi3dfcDQsAwmM5NfjO4JbmmTkqkX2MYLNwN3XzivRqmIHvhGM3qItMMSK6maVi0K3ExPCaWH1lex62/z7tRoOQ9wEtaXgba561jjDTz0SalIAI11NxL0TzvvNmwfT0IUlOlJlAUdGONWusMttEVW52or+L71OEr68XvPw1X2Umw8T7+Zw8ovXlCl4ixzZOX8YUJU2PP4yt30tBCytix4rIReXSFN2ZwyT/OdzZ6Wce8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkk146pOeELW5RwsTYHNkOgDR4E6vQPsxLiwVhIGegY=;
 b=Uk3wcYfcgwFd7ITcnAt2Vtlw++tNPBnUEdx7YGEcI3OFxW42lM2XXEzKx57t+taPIZWbqJUydVskkAa5TFuoDx9uoVcjVPHcy/QuywaF4mA3UgRWe9tj4/oOhIuQxqwewhWOMlBPthv75m0whH9OF6YgjvHSI3AbV9GZcBj8ENgbjR0UFujvN78pPHU9FhNVAkhi3UprM/LvYftsUOAhSrSABdaIhJ52PwrPVJdAOpvIjRVJ+Jo32oOqe6Nb9Ecvvm8htgt+uy3AdtsA2Tw8XLX0AidaWlTFkqLgO4wnXDICa75ac8w0f72u56MNilyLsgkiO399Pk3AoIzx5t+Mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkk146pOeELW5RwsTYHNkOgDR4E6vQPsxLiwVhIGegY=;
 b=RL6qpV6KRxWAhLeySMLvdVIcaz/yJQsfvoKb5kNV36bMIoaCqobwhpexd69e06A0fJcSqPh3+95agMOJLzOGFM6W2PDqDYrP84hmSPkGW4e3i3JBCGM/P+JxmoiwihgqoEnXP2FkQtaa5r6Y0VR6XzTCmv8MFpIuqi0OW9OYUqA=
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 15:41:01 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::b2) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Sun, 7 Jan 2024 15:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 7 Jan 2024 15:41:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:41:00 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Sun, 7 Jan 2024 09:40:58 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH v2 v2 3/5] drm/amdgpu: Add ras helper to query boot errors v2
Date: Sun, 7 Jan 2024 23:40:09 +0800
Message-ID: <20240107154011.12927-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240107154011.12927-1-Hawking.Zhang@amd.com>
References: <20240107154011.12927-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: a1114237-cde6-4cfb-286c-08dc0f970cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpCkYYdOVsDCbUFS13YPvTzIuZmKWti4JyhX+IU9TS7/rnGTvwDa9d5t8AwYTT7rcF2fVikD7+AuQzl5xkbkjZn/Lazf21gEnC2f7w7of2S4l1J/+9bfDOIHycF5imVGfxdj828zDz3aBFR/a+TydeB2G3I3CWV662/pN3owiI1NsUmEUJ+eEvZFOyfmI1bP31Tdv0jPzZeyJeQMdbIi8Ai3Svi0ce0fZs9o45NjbIKujH7+CeI/ja3z6CM2ohvidk3l+jnxke5M6ixLmOCiVFonldlbd7CfXPc80NA2ZNioBnmAzA0pdabICTyL/sW7Jmcy7yRrk8pPotmshXHqbIwBzt9K4DMniI2KF4UtP0ESOu09ffQfVzMqdpaLYQb7DK/wWJCXYov55LWZw0KDVt0U8v7uxQg9qzOk3IZa7TbnQL9MjlOpPJ44pL+jnF+Lz343+tkxfy2QB6UUTFk70NguaYUKegOVD/VKqd1Q2Qi8DkjArrAcX6AjP+MwJerT03jkYh8hnsHmRNgt5GZb15QuksNurEOAu0iw2jiB9zU2LA9WV/PtPQWhQgsQZY38FwvRqE6s9zkV77KSHbNrY9X1tgSl3a0QE4GCa0Tt99vzO2dl+1PtVwBNiBtSsxKJFl2l5HM022ipPfxztqymKGuwIFN9yPxQfmgOO5FHLeSenoTTljilrWNeGcw0eDteGviKV6m11TizA1BXXpbL6k6vGXikNHjjyZ5aiAIBSMM5/LowPSRMc8/uzvhAlRUqheY/PjIbzyIe8A2496qrrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(36756003)(8676002)(8936002)(5660300002)(4326008)(110136005)(316002)(54906003)(70206006)(6636002)(70586007)(2906002)(36860700001)(82740400003)(86362001)(81166007)(356005)(2616005)(26005)(478600001)(6666004)(1076003)(7696005)(47076005)(426003)(336012)(83380400001)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 15:41:01.0596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1114237-cde6-4cfb-286c-08dc0f970cf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ras helper function to query boot time gpu
errors.
v2: use aqua_vanjaram smn addressing pattern

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 15 +++-
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9da14436a373..df3aa69be425 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1330,6 +1330,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_FIELD_OFFSET(reg, offset, field, val)	\
 	WREG32(mm##reg + offset, (RREG32(mm##reg + offset) & ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
 
+#define AMDGPU_GET_REG_FIELD(x, h, l) (((x) & GENMASK_ULL(h, l)) >> (l))
 /*
  * BIOS helpers.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fc42fb6ee191..a901b00d4949 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3763,3 +3763,98 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 
 	return 0;
 }
+
+#define mmMP0_SMN_C2PMSG_92	0x1609C
+#define mmMP0_SMN_C2PMSG_126	0x160BE
+static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
+						 u32 instance, u32 boot_error)
+{
+	u32 socket_id, aid_id, hbm_id;
+	u32 reg_data;
+	u64 reg_addr;
+
+	socket_id = AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
+	aid_id = AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
+	hbm_id = AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
+
+	/* The pattern for smn addressing in other SOC could be different from
+	 * the one for aqua_vanjaram. We should revisit the code if the pattern
+	 * is changed. In such case, replace the aqua_vanjaram implementation
+	 * with more common helper */
+	reg_addr = (mmMP0_SMN_C2PMSG_92 << 2) +
+		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+
+	reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
+	dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw status is 0x%x\n",
+		socket_id, aid_id, reg_data);
+
+	if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory training failed\n",
+			 socket_id, aid_id, hbm_id);
+
+	if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, firmware load failed at boot time\n",
+			 socket_id, aid_id);
+
+	if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, wafl link training failed\n",
+			 socket_id, aid_id);
+
+	if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, xgmi link training failed\n",
+			 socket_id, aid_id);
+
+	if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, usr cp link training failed\n",
+			 socket_id, aid_id);
+
+	if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, usr dp link training failed\n",
+			 socket_id, aid_id);
+
+	if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm memory test failed\n",
+			 socket_id, aid_id, hbm_id);
+
+	if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
+		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist test failed\n",
+			 socket_id, aid_id, hbm_id);
+}
+
+static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
+					     u32 instance, u32 *boot_error)
+{
+	u32 reg_addr;
+	u32 reg_data;
+	int retry_loop;
+
+	/* The pattern for smn addressing in other SOC could be different from
+	 * the one for aqua_vanjaram. We should revisit the code if the pattern
+	 * is changed. In such case, replace the aqua_vanjaram implementation
+	 * with more common helper */
+	reg_addr = (mmMP0_SMN_C2PMSG_126 << 2) +
+		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+
+	for (retry_loop = 0; retry_loop < 1000; retry_loop++) {
+		reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
+		if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
+			*boot_error = reg_data;
+			return 0;
+		}
+		msleep(1);
+	}
+
+	*boot_error = reg_data;
+	return -ETIME;
+}
+
+void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances)
+{
+	u32 boot_error = 0;
+	u32 i;
+
+	for (i = 0; i < num_instances; i++) {
+		if (amdgpu_ras_wait_for_boot_complete(adev, i, &boot_error))
+			amdgpu_ras_boot_time_error_reporting(adev, i, boot_error);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 76fb85628716..5785b705c692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -32,6 +32,19 @@
 
 struct amdgpu_iv_entry;
 
+#define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)		AMDGPU_GET_REG_FIELD(x, 0, 0)
+#define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)			AMDGPU_GET_REG_FIELD(x, 1, 1)
+#define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)	AMDGPU_GET_REG_FIELD(x, 2, 2)
+#define AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(x)	AMDGPU_GET_REG_FIELD(x, 3, 3)
+#define AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(x)	AMDGPU_GET_REG_FIELD(x, 4, 4)
+#define AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(x)	AMDGPU_GET_REG_FIELD(x, 5, 5)
+#define AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(x)		AMDGPU_GET_REG_FIELD(x, 6, 6)
+#define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)		AMDGPU_GET_REG_FIELD(x, 7, 7)
+#define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)			AMDGPU_GET_REG_FIELD(x, 10, 8)
+#define AMDGPU_RAS_GPU_ERR_AID_ID(x)			AMDGPU_GET_REG_FIELD(x, 12, 11)
+#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 13, 13)
+#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)		AMDGPU_GET_REG_FIELD(x, 31, 31)
+
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
 /* position of instance value in sub_block_index of
  * ta_ras_trigger_error_input, the sub block uses lower 12 bits
@@ -818,5 +831,5 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 		struct amdgpu_smuio_mcm_config_info *mcm_info,
 		struct ras_err_addr *err_addr, u64 count);
-
+void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances);
 #endif
-- 
2.17.1

