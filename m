Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86769C47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3AA10E195;
	Tue,  2 Jan 2024 14:08:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4429D10E195
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGurHzg2hCOmQkJ9AncuXq6L7oEFrRmK1WTLGXqvHxVsxoptlGksdjBel81Rr0F+wWW+3kKpi/rGetTqdT8SiUqReAwqeQgd+OIeH1wSt7L8Uffq3liSa0Z77Cod75QZTRS1pVXpHaP1+D5B5Z43onS3ZfgKtEv+SKk06RjR+zsRy3eXUunmLTqm7N4ZI+4Tuw1v2rI9w3CrIrSyNZ66+rrOoeWZnnQ3NE7IvZq16GMJlHN7URZ3aFb8xy5zHeTRJgtUDqnvt2i0DTwrmU1xLZbQtUy0Vyo6KtcrCfX+hXgGUQ7W55FeHgnqJ0fGUaBqU5Dup6kWSU+j4zbjrUE/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=empiam8yS4XXwMxPNsj+IM0kWM/PFu+GirAxXFl8dKM=;
 b=d4QkU3Xp2zLe/C1YGonHptcP89e/6FcWfySZ6cQ55NuPdekizoS5RH0CNNQFIJFUtXPoRL9ZIoiPe4FyZ2SVujaC4ryFHlprGPeaVA3YgiDtnS6KsrpKto6TPUOI/sv5/a6jYJDiwMv45xdxMpoJOblA7sAIa9aZiggzX40bagCd0clxfXWS5rqcnwogt5Y34S5Ms8mxhrM3wunwqLQsDy93CqLz58SiZxuTwjRloCWJ/eF2uxOJFRHfA0wcYcT8M1TD1iuRQ4QS63y0ukp2ikiwJJ5d8w4SUsLP3pH1XzkBo90eWEOSkGnxJSA3G2wlBh87PDg/beGSOrM7uS27iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=empiam8yS4XXwMxPNsj+IM0kWM/PFu+GirAxXFl8dKM=;
 b=fP913SmzK6OGbDcPsV0e1t/F1EDQsvJaXAI4MMBKAxWEJKzoUlNKzWJuoTejhfsbr5RaQPbgSlMexwMgbvpxRWx52aNE2OZr1NDkADZ8pv8KHid+lFJEsRLLjPL+EkMFBrLgeSl8wum3j/xsci7ioCBNBWrICqMpurWp9N1wGZo=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:08:29 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::b7) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Tue, 2 Jan 2024 14:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:08:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:08:28 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:08:25 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors v2
Date: Tue, 2 Jan 2024 22:07:40 +0800
Message-ID: <20240102140742.23917-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102140742.23917-1-Hawking.Zhang@amd.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ddd8ee-0765-433b-014c-08dc0b9c4b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/NAFpRMAtv5lbPhVAbqpSq0eeQJrQUAk/Hy1Ee6KHuehP/MxVOHzv1JLerrANvQZbvQvqDzNUc9l84fdksBUVavE9406uHgDo172FNdst//lHsuY/Zk9Ns9bA8oLKd2zT8MoFoG5U2TYqsdcfKyWTZyEEiEKE5FeZ+wr2iK3kt6GuX+h+ITk22y1vhQuzQ8fgJiCKNYylkI2DfswHjh6P3EcAtaUcQWL81fuz8EVmHiMjWU60NH31NIjwYCIUNilB/ZhXfP5u6KZU9++tCUjrSVHbjavvn1QGJcJ/VY5qdmEbvvYq5m3+zGi2M3/wsSB+w4kZdVzZWQhgD+X4wq3u9Ur+bHgPk5RkRR5+OXMz514s5xvl9vMKSN67wFYXeHbCkHk3Chq4Qcfm+yK1BWXzJuDCeNyYohcJWsC7897ihZzKJKnOl3zpGYX9yaO2xzaJw6cnzR4eRYO985nd5/u6ZO99UyCvcCpvXnCjL5ligUu5dI4tExoqjCZ5rPiMdmrbigLnSob3ug1D7nhS7osUw0EBH2+1d6ryKpYSYtGNt07265wm4ff53w1NhUwpu4r3ln/Jneb3kFsRSKphhvWOUkNfXdXqW9mijOP5wXzD8f7TF2KrTTrVSLK5BJ3wnDoUaVTaubDDXae2FfU0p9y7oZytcPMytrqn3+I46Gw8MSGu1LMvt10K+dU//Vbr1hUxM4iLYMQYweek2Gb5ztjOcgPWs1r0hkJeBibD40t4sPW9641YKMonP9SvofLRSHlJOtG8uDsKdj/KHIfbZdHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(2616005)(47076005)(26005)(1076003)(83380400001)(426003)(82740400003)(356005)(81166007)(336012)(36860700001)(8676002)(8936002)(5660300002)(316002)(54906003)(110136005)(4326008)(2906002)(41300700001)(6636002)(6666004)(7696005)(70586007)(70206006)(478600001)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:08:28.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ddd8ee-0765-433b-014c-08dc0b9c4b87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
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
index 616b6c911767..cd91533d641c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1328,6 +1328,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
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

