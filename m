Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C2CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B05010E4F7;
	Thu,  6 Jul 2023 12:01:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AE310E4F7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ1G/GkjBJxMpkRFH5fHPSI3F+PKiPP6YN4+3tIXzb08p3QfLKDl+cly+f19pN7WjyLwYuQGajAQ0hTjgZef60tSDldrr/BajJu3/ZhwzKrCVk68KUhODByAEi3fFwaiCunAFcEo3YbR04UAVmD8ADQpbckQnmuJHfpCLC9c4dKBfZTLHUF2+akjnw2NuZ5TvG1Y5OhWVuPQ5yTPGEPR6JwrBBR2GNr9ksXxBF1RfkfGQiZlUDOQgMqVna18XBZ0UWi7nmjs26hfsNeW2FK3tbX4WheYm1+e98RYBEcCsmcgmnRUU96IAMi1PqKyskfHq23lxesLygfWxL4QIi4yRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MasuCVZlpe9Yx6mngdQxUwcyRJTkHBkMKoZ64nB1hE=;
 b=S0SiNBH1aUvkIPkHrX7xjUBaCJ+T8H0UA3eQTmANdgAhZzpOh21sK3RY0AK/DAKgQF+LnvMbfFNJGvMAJrwdGcSCXijLbRhb3cKrS4xGGQwj+ng+N4s0a5QTOwQWNrIHcIqovUkLc41fKuSBKzkeiprcAFd/oONNYNT+xW7re/k22ZFyzqOMAnbXy9+Yk7zgJj98u9WguqDmIWvBEkrWYw5jchUiUXhGrI4wJBkhxwM6Vth6GzqrFySyNBh5GtmUos9p6wKgcFiLuB4ylIXEfnPooRz0wQhQcKfBx2WFIcGEQsbCsPsRm6dekD0pR6FSDzvNYJjeNnQVi0tF5Rc45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MasuCVZlpe9Yx6mngdQxUwcyRJTkHBkMKoZ64nB1hE=;
 b=R38vBbs61JJBsVg/IylzND8g7PBBVnmHXk2JpTWL3qqAGAqdcPP9Xy84p/oXNbU1vvt3nUL8mv1r0LqVm5gDk0po8OPI6IB1b7xsvwggg4z1GN8ZocGooHze0QoKSw3vtbm83Ty3mWLu/PUyI7Qlk+Ax0kXTo8S5S975wVuv8nE=
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:01:11 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::ef) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:01:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:01:09 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 6 Jul 2023 07:01:08 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: check whether smu is idle in sriov case
Date: Thu, 6 Jul 2023 14:01:02 +0200
Message-ID: <20230706120102.2174734-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 7048d4be-38ff-4c02-5aa4-08db7e18b080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 290DZvkH1qKa1O28VBAGH6CRvY+Edqea4U4BJpNKmQrAiCG8/SFowWlo5Vr7bHFJDF3b3UsiLMmlFfo/S9f1xDqsoW7f6J1W/AH8EauvM3PevUQK1GshFFafuISRhCkbgfBfv2YIX+USxSD5f7jGwsSRtWwxLd/os1RF+FQdLnSvMYHDtx8OfEolThud1LTwJfzCOWT7gsorC6fteUeA9fgjijpEpOX0E4p3P6dEpfWydW0j0J/BN+5EdynCzUkamfIEEWRWVlGQxh3tZV5UEGWi0uFmkjKIvS71dskhlPrS1Fp6Bs/Co47+Jl0o19sv6RhX8c0tnaiy4EniYfPjI6l3MLuYgf9wkfueSQlGBRUIWNwCBFJRchsamZbfXc2DxP6htEuPzyZGxKyOv/Hvnu0dtAVWkaiekLEs4Rf8JDefpONoKghZk8RE/fbSZwa7X+HB6bPmVavt2ctL6UCvG4HTqRKZdqha51CDSq4hOXfET99SnYbDVV1OkUzLqHP8ga10iynnvChoBA6DQ9vdjaUapyt+Cq5g7zbDsMt1kQZGCnLOmyv0hlEYWUtk/6HlxDTQfrSikoFPKyQOTq1muoNuCjM37gq5sO/31zGkzhHYW5CQ52D4tCE4C3WLB70tOxd2H7+SYHLcClIaTHNjUCqvgYM/riu7ncz+JiT37AX+KZS/HN3hERtivpxrnJCTs01JwbBaoyijyb7sEQgexRRGrCS0Y1rIledSToI5+51iEotma9tDCXixzyqVQKlWgY8hxFmRxm3mIo5bVZ4cXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(426003)(356005)(44832011)(54906003)(47076005)(70586007)(70206006)(26005)(1076003)(83380400001)(478600001)(36860700001)(2616005)(86362001)(82740400003)(81166007)(6916009)(4326008)(2906002)(5660300002)(7696005)(8676002)(316002)(8936002)(40460700003)(6666004)(82310400005)(40480700001)(186003)(336012)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:01:10.8261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7048d4be-38ff-4c02-5aa4-08db7e18b080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  2 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  5 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 40 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 7 files changed, 65 insertions(+)

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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index d466db6f0ad4..f3293ddd1a1b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -165,6 +165,8 @@ int smu_v11_0_fini_power(struct smu_context *smu);
 
 int smu_v11_0_check_fw_status(struct smu_context *smu);
 
+int smu_v11_0_wait_smu_idle(struct smu_context *smu);
+
 int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c94d825a871b..f4e7596dcdcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3503,6 +3503,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.check_fw_status = smu_v11_0_check_fw_status,
+	.wait_smu_idle = smu_v11_0_wait_smu_idle,
 	.setup_pptable = navi10_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
 	.check_fw_version = smu_v11_0_check_fw_version,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index aa4a5498a12f..059dc2243c06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -195,6 +195,11 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
+int smu_v11_0_wait_smu_idle(struct smu_context *smu)
+{
+	return smu_wait_smu_idle(smu);
+}
+
 int smu_v11_0_check_fw_version(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3ecb900e6ecd..5dc81d7b04da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -313,6 +313,46 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	return res;
 }
 
+/**
+ * smu_wait_smu_idle -- wait for smu to become idle
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
+int smu_wait_smu_idle(struct smu_context *smu)
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
index d7cd358a53bd..abe875513d77 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -50,6 +50,8 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
 
 int smu_cmn_wait_for_response(struct smu_context *smu);
 
+int smu_wait_smu_idle(struct smu_context *smu);
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index);
-- 
2.25.1

