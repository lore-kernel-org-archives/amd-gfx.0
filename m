Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FCAEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 10:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BC710E548;
	Fri,  7 Jul 2023 10:17:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3E710E548
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 10:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU3SVq/yf5H1yLwmtsOJCpWW+ucx8bBGYSqHO/qnAWnfzsdRqgMrKflUYwaNRlKxzEUa0qzCOUX9JP7nuIwSV4TB+hWaJDoNAy7ewFo4cgjg/RxRxnlhMfoMkJwDtBREe/gdEgXs38nmQVNnNGXQuBBaI7kNvmXQVlqehstBORSjKhJBKADr14/OPJAE4hScsO8QwaQah5P+3S9BCcDftbg2iXN3ZrZ9+OyZV/C05e+g2Qmy1bfppL1SF34pGI3G3f+Mo8GGkJtJ0YS8tYx3t1qfpCezdNA+J+qA5Wu8x8DBftSftr3WyU0r4jZZzY5IVcO2pvgSuOHFMkuAthkxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln1Y2SQDWCsSErsDg9MH+9Q1Q4Lc4WnInkNJvmVtcag=;
 b=b1zkgOzCkzlugXJoxMwOU3AdfJhd0iLForoGRc0Z6LnlugHRHY0jUfVDozExjVoVxliGWKIMibOKkH2urLfej/r7FR+7F3f37ga9lKRi88j5/JeKYWT5Ss+R2xeiDHuj+341D9mmK3jW26Xkmhxc0zBNGaKxZcifu8AeV9ZfYDp4YPrkPsW0fLbOcw+8D/57LKfC6UFE9ZWwRQF5Ekev0JcF3VsiZ6Ji9tV2eioHAofH97IZeY6Ye5XUclQotLx5eRcfFzumq2FuZbiw9ySGiC3dOhbg8eGk5n036dC7mKctuy/jfUkJmHYuFeR94H+ut6LUby/5t4nfFqLHyFOMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln1Y2SQDWCsSErsDg9MH+9Q1Q4Lc4WnInkNJvmVtcag=;
 b=OZkpwLlvf+0YNx7ocA9RZZqOUn3bp20DPD4KI8qoIMcllI6P1HqbwWZO1iBJ/fm3Psc0DCBrrYbVmb8XgtCD2VY8283gYWEm26HdObGDTsqgMZ94jh/yS5JUEjpmrg7xhcOHCzuiV8w1BJ8PN8paXvY0UjzgKUZ7l9QHt6aArN0=
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 10:17:46 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::56) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 10:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 10:17:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 05:17:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 03:17:45 -0700
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 7 Jul 2023 05:17:43 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: check whether smu is idle in sriov case
Date: Fri, 7 Jul 2023 12:17:29 +0200
Message-ID: <20230707101729.2180508-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: cc75c1ef-107c-4999-ccc6-08db7ed3689e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfU5RuDZ2dNPiVhfOX/CLf5nfK5hjYbO7a9+E14Mbrd8s5OY7l8E5VLSbc50UrH4d9k65ZRhEjcWtigc/bkwze/q9LMDHgZsLEEca+v8fG+/JIByOOx71iM3LXafrvq97yluOyoNnUOdh14Cgrnd3a4X5PKAOX+bDh0OjQJ+/dkbA4vVVOnmSYjr4O/fPpf94grDOcuMCuU4TTgag0Ygx92XgD25bo5e1ij30Uv4ilA22PdzuMjFA5iK8t4qyUVyyo1okWViMZxxfQ0M1Morvfp2fE782uOgXyICvdltHGttrXzMkzAGsSAAyBVod95BxxLPmLmOhWtCF3yCVpGvdHj+lwmjs4GPysor9p2tTNCUhQtHtUHG+m6PjCgcrOteqfy2pagdmVenLLBp1Wixqy8iLMUS5ICow76pKIvrYsRHZvFQBrizkk6UpZCJrJvnTBvPvmcb8vIi05rp0sVNz6Q2Afdbv1x5UKIJugeGkafCjfOWM/pIE92L2u6Z9GjiUXqTidtKmtqPLr3FbAKIqrq70suw2vHahDOeSx6LUBk1NjA0oqz/zaPCDQY60G1o9CpYQktMHwG9O1ooFkXrQ8fEhrEPDIPvFvfMK7gMYAcDhJLJjHTNQCbZlTzXFVhJndeCk59EHF5+9IKc17F4d7e2xHc9mcjgfHKoqXHX2nlQda9mXdEuf7JRK2iOyvJqUXU84BzToxpVr/N5HhFOo9Sed9KFRnxCI2xpFDlaMBSw7l7kUOTqohX0jQV8gxyNzbUnvc5+pcffoWBQGMFpNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(7696005)(6666004)(54906003)(1076003)(26005)(40460700003)(186003)(70206006)(70586007)(2906002)(82310400005)(41300700001)(316002)(6916009)(4326008)(44832011)(5660300002)(8936002)(8676002)(356005)(81166007)(82740400003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(2616005)(336012)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 10:17:46.1181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc75c1ef-107c-4999-ccc6-08db7ed3689e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
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
Cc: Danijel Slivka <danijel.slivka@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Nikola Prica <nikola.prica@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being programed to 0x0 before
guest initialization, then modprobe amdgpu will fail at smu hw_init.
(the default mmMP1_SMN_C2PMSG_90 at a clean guest environment is 0x1).

How to fix:
this patch is to check whether smu is idle by sending a test
message to smu. If smu is idle, it will respond.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
Signed-off-by: Nikola Prica <nikola.prica@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 40 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 5 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ce41a8309582..63ea4cd32ece 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1443,6 +1443,14 @@ static int smu_start_smc_engine(struct smu_context *smu)
 		}
 	}
 
+	if (amdgpu_sriov_vf(adev) && smu->ppt_funcs->wait_smu_idle) {
+		ret = smu->ppt_funcs->wait_smu_idle(smu);
+		if (ret) {
+			dev_err(adev->dev, "SMU is not idle\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * Send msg GetDriverIfVersion to check if the return value is equal
 	 * with DRIVER_IF_VERSION of smc header.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6e2069dcb6b9..1bf87ad30d93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -926,6 +926,13 @@ struct pptable_funcs {
 	 */
 	int (*check_fw_status)(struct smu_context *smu);
 
+	/**
+	 * @wait_smu_idle: wait for SMU idle status.
+	 *
+	 * Return: Zero if check passes, negative errno on failure.
+	 */
+	int (*wait_smu_idle)(struct smu_context *smu);
+
 	/**
 	 * @set_mp1_state: put SMU into a correct state for comming
 	 *                 resume from runpm or gpu reset.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c94d825a871b..3745e4f96433 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3503,6 +3503,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.check_fw_status = smu_v11_0_check_fw_status,
+	.wait_smu_idle = smu_cmn_wait_smu_idle,
 	.setup_pptable = navi10_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
 	.check_fw_version = smu_v11_0_check_fw_version,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3ecb900e6ecd..e3c972984b2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -313,6 +313,46 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	return res;
 }
 
+/**
+ * smu_cmn_wait_smu_idle -- wait for smu to become idle
+ * @smu: pointer to an SMU context
+ *
+ * Send SMU_MSG_TestMessage to check whether SMU is idle.
+ * If SMU is idle, it will respond.
+ * The returned parameter will be the param you pass + 1.
+ *
+ * Return 0 on success, -errno on error, indicating the execution
+ * status and result of the message being waited for. See
+ * __smu_cmn_reg2errno() for details of the -errno.
+ */
+int smu_cmn_wait_smu_idle(struct smu_context *smu)
+{
+	u32 reg;
+	u32 param = 0xff00011;
+	uint32_t read_arg;
+	int res, index;
+
+	index = smu_cmn_to_asic_specific_index(smu,
+					       CMN2ASIC_MAPPING_MSG,
+					       SMU_MSG_TestMessage);
+
+	__smu_cmn_send_msg(smu, index, param);
+	reg = __smu_cmn_poll_stat(smu);
+	res = __smu_cmn_reg2errno(smu, reg);
+
+	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	    res && (res != -ETIME)) {
+		amdgpu_device_halt(smu->adev);
+		WARN_ON(1);
+	}
+
+	smu_cmn_read_arg(smu, &read_arg);
+	if (read_arg == param + 1)
+		return 0;
+	return res;
+}
+
+
 /**
  * smu_cmn_send_smc_msg_with_param -- send a message with parameter
  * @smu: pointer to an SMU context
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d7cd358a53bd..65da886d6a8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -50,6 +50,8 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
 
 int smu_cmn_wait_for_response(struct smu_context *smu);
 
+int smu_cmn_wait_smu_idle(struct smu_context *smu);
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index);
-- 
2.25.1

