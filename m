Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1055DC47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C10010E109;
	Tue,  2 Jan 2024 03:44:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABABD10E109
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef0qbC67t27LhOFS1YUu+I5JVlcbmgPw1yGuluT133AYD0duii4OXQ6Pb10MzZEqiw+la57Nmh1qVALOuZEgHCu0esjiArxkjSWRdywHdza4uK+/qg0H68FedHRIhJIutG8hLChDl1CqRCbas3GPB7puhfJvIxdMMt98PItD7+bzv8Kq3PLNTsW1GJU+JiBAViiXu9DSiZ54LKwvl6ymb5snQejvWXRrOBTl0UqAyw4C9KQIh4JH6BxhGjgZAH8ATYdFFMTUGxfbZbr8T773hGL8dBsI6tu71USjPmYUHW/YvfBM3MT2XlLbCggVRvjBVS5aX6f9O1GRy2pS8X9yuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxsa3nslIPFlOuBfNK/pp+nzm93yMAWKCedlFKPhk+I=;
 b=Z2Rz5RipRsnEiK5tjBCyLJYrv5+/cGiJEreBwGb1aIdB9GJ3ZsKMiXBT6YOEaTeU4BinVMC4dLKKTpZow9NXPC+XgT8WhB7qIIqh1J35r4yBVcLPrv6IkVASCV9rIyzFuMzAeeWHgGltl3gAT86r7smZFdGlSLCVcKpgUEmW9uhUIMy9LJcxNbIXyiy8J6kJvN3Yu4+FvFWVS/M02FPOZ6hXk1+g8ceg684QUKXBBWNYsj08iqQphzghaXzK30fYf1bWtVhj6l5bqYnvXP5d2InCsAaFfrBKcuxYv7uV+7Rj/Iw680bbr/KNKZTUChj4bPbs1eONNc2d7P0M3psBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxsa3nslIPFlOuBfNK/pp+nzm93yMAWKCedlFKPhk+I=;
 b=gPZe1sxuckwq0XK4+ojVb+DZZo+RctrrHT9OzGviAv6GgM7HdmwutViYsyG/XsXxgzYGi/HjENlba9bda7iOnCwCIcCmbwspiYzgfVRlr2sKM3xe1X9OcFGC1cRhCa9CMVLrREO6uiIS1Hib97qz+E0t/pabA6MJAJL75dGu7bg=
Received: from DS7PR05CA0019.namprd05.prod.outlook.com (2603:10b6:5:3b9::24)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:44:18 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::2d) by DS7PR05CA0019.outlook.office365.com
 (2603:10b6:5:3b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:17 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:44:14 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Date: Tue, 2 Jan 2024 11:43:39 +0800
Message-ID: <20240102034341.16321-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034341.16321-1-Hawking.Zhang@amd.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9627a0-d442-401c-9000-08dc0b45190c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxA5wkoshJu8mYGJh7ojP4ZPifhTtaT9N+znKoS4t0y8C5RHir1jv9XoXn766b8Cpet/jkPa6gdpYD6i9dOckFZtoPBc2fIHd3UNt1QRfHZdZdbTywAI+RpH89Q4dTlwrh6QkNHoZq+lviqUSclleMHl39HcKbkRjKnTFzdkVHHTqBdpQGo1mKjl6H8XZxsop9FKY7fgh1g9Iu9cwQs5AQ2Anez4PglcOidkwjmCnhv6Y3gA40K9bFF9NLghbIkPi6uXoJdTdAddmEmsppwaYKdI8l5Vf04P2pz/gt4uh1CQDNoF1WqIf/AjU5RqDn08v2TaXCbcd2YAnyHIoNnpgLJnp2M2vZjs7BUGxKY3JnO8Vp/Dm22Zt9WD8xsahl2c5RdIGyxOxYBsrEQ9dwzjQO6MO5G7FdpcKXUlmUAsIH9tK/nKPjnFQ9B7SR6GS2DfJK0phjVrWyiX5zfp7al5/R/XnO/h1K7W32c5/vOXQDe5+zNAtiRNERyr4pDpP+J+Dv4jn+WHmZAbA17T/9OPzP3mO1cw22P33Z9FrUNDzVab3T9p/YWw5pXYz6Nyuzuj4V+8KIx+OYt3LD6FVaFDwWkof82MI/povvxvsJao5sLinOp4NMEHAVOB6blRbwDbU/y+OfqjpKEcdvVYnq1s0M+rUNZyXzKRtpra0GlcBH/ABjiDl/7qeoi9ZUIY5a+m3DLsLh8L3QXquRgRyWmrT2JbxAynqa8eBsWufuvzV9CGuAn7K/pWhJji7e2jkeKZTTWpNg5T0mRPYL2Tdhq+vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(426003)(336012)(26005)(1076003)(83380400001)(2616005)(6666004)(7696005)(36860700001)(47076005)(5660300002)(4326008)(41300700001)(478600001)(2906002)(316002)(8676002)(8936002)(54906003)(70586007)(70206006)(6636002)(110136005)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:17.9889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9627a0-d442-401c-9000-08dc0b45190c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 15 +++-
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616b6c911767..db44ec857a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1328,6 +1328,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_FIELD_OFFSET(reg, offset, field, val)	\
 	WREG32(mm##reg + offset, (RREG32(mm##reg + offset) & ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
 
+#define AMDGPU_SMN_TARGET_AID(x) ((u64)(x) << 32)
+#define AMDGPU_SMN_CROSS_AID (1ULL << 34)
+#define AMDGPU_GET_REG_FIELD(x, h, l) (((x) & GENMASK_ULL(h, l)) >> (l))
 /*
  * BIOS helpers.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 39399d0f2ce5..5f302b7693b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3764,3 +3764,98 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 
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
+	if (instance)
+		reg_addr = (mmMP0_SMN_C2PMSG_92 << 2) +
+			   AMDGPU_SMN_TARGET_AID(instance) +
+			   AMDGPU_SMN_CROSS_AID;
+	else
+		reg_addr = (mmMP0_SMN_C2PMSG_92 << 2);
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
+	if (instance)
+		reg_addr = (mmMP0_SMN_C2PMSG_126 << 2) +
+			   AMDGPU_SMN_TARGET_AID(instance) +
+			   AMDGPU_SMN_CROSS_AID;
+	else
+		reg_addr = (mmMP0_SMN_C2PMSG_126 << 2);
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

