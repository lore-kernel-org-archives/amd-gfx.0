Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C226C28D13
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 02:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFC499D58;
	Tue, 23 Aug 2022 02:03:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE0E12B84B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 02:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diulLQ6rGcuRcAuVKaxsYf4iKCHgRyo45rLIKOPhv29OoWTgOjdf/h1isOr8KBEWgRrcYE1Pj9G0CUxRxoGXRJqh3sBWk8+02hvxH9Jg9bQnmzdfvj4rl3cSgSWEv+hkMCiqE/Ie1Y6p7S2xzxMGoGz18TDkQIlC16cNXKuqyCDaMCohsjeGJCMAeQCiXTbB5/wjxSd/BfS2ANqe3WVdnKCie2PzgbDtzGWe28w99heUXbdfocYcf59Vve1E3yRgfdnQl9UzAjUvAwi3D4UcJIcdTwHg+iF0jUmvnLQ8RIzh6sZ1659cgpd+CEo1ppO7OYIBYkwiMhBoOdU+b1SCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuUs8mwbEVfOz2lHhPjrgiHeOegPvSKg27AMoNE36Zg=;
 b=asaI6SwKAzzsJPIHh0HSCu8immYnZL0t2b9cHK96Zle4nCiRBtJxaFy02caEuR/hsGM8ZNdjftNQponWL068rDFXcVEoWb1PusDRLlGJdASwfn9Rkd2DK3ultR3zLt/vafspZY73zHfRZ4I/cS8nWn8a9OLiQa4qmowNxRpBS8q5+Yl4G5xcUJkgm19kCukWbS+/gLSBpMEt3yMobiU/eG3adXi9f8usf9Ypi0XdA0fKBjN6FgC0AalyaAsM7g+xbMmkLqeD1Ur6XGeDn7AD8tEe52dOyQXaIc7FTqPlsWxK8jh1GO2JMXYziIUM+UKBagFRKrluLJwUV0mogIibYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuUs8mwbEVfOz2lHhPjrgiHeOegPvSKg27AMoNE36Zg=;
 b=1HZGut/iLNIUqaWEbn+iYgUxzQZB2jIxwfDtVrmzj01dOF09GO9ETc5hYHB9DOrLxtF3kkiVlX3EgZ5nI1DPeoyCnLN+CDT3e8Acfcz6X4Qxt4E3gg8r50Dz7eYxhsMAtla8v67CTWydqs9Co1jjJtfcpGLF7HscBFgQ9X9JBWs=
Received: from MW4PR03CA0322.namprd03.prod.outlook.com (2603:10b6:303:dd::27)
 by MWHPR1201MB0191.namprd12.prod.outlook.com (2603:10b6:301:56::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 02:02:52 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e6) by MW4PR03CA0322.outlook.office365.com
 (2603:10b6:303:dd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Tue, 23 Aug 2022 02:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 02:02:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 21:02:50 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Mon, 22 Aug 2022 21:02:50 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: improve BAMACO code for smu_v13_0
Date: Tue, 23 Aug 2022 10:02:47 +0800
Message-ID: <20220823020247.2545671-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2f073f2-935a-4aef-b03e-08da84ab964a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0191:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYHeoydQ7kNm/Oec1yym73Yxy5NrQtgX0l2H3b9j/1O4rWW3B6n7Pm0ywc5W1A07H6ZnrbxrDotMsPT+tIz49tY5nERCCJ7Ub7vWKxYZ8H/+1lFDZVNQf9BaLj7fW4uY8wZBP5Pz9x+LplxRyhWPjCkQsVXprE0Hff4Q+1BBK0ZbbHLs9rSA2i4u4oGz1ZLoBkJ/aipQBwpNAEbxemYVxEc2N0lURnaYUW+ZeTkOAah6kJ5FGApc5F00AywpMhZUTf/KCT5M+Bbsg67NZFajK4NJt5xLeI7UPz68A4XusM175JuVArwYfZxehai0YaXcdK9CDHf74ti5qE/1QVE3rsCVU6BTyp8uCEzx4VxocX3qgN0n5x+o8iWMvWTrr6MapTD9Q/D0lm6yhcE3T0bygmG5O5+eyZG9FpvOTjwHlaQI6ovjsMR9tgNcMz8hiTlVbWKjT6Yn+fqwrtOUkI28lc1Bx4RA5tnaFjeFQuDf//GFqnnpsBPmake4rCcPFwMLYAGsRN0Zio4MQFFelK4+TXraTGjLX5U/L6J69y+iirkk7vsvZZXR5o0Kcy01yJXrteoU5SkLA08h2TMOg5A/mL+HLRhinzQNrxQxxyxFpu7Weui3K1amZOYJP2TdcO347Eq41+4s+6EK5Prs4DaTSQMlcGYD/TmZ9HNprHId4P4jo+Mxl3b+TXnkNT/dCr7r7nyW+HVhCMXYuh8bNUKMIKwgW3L3C2bAZJldjUgcHWtRMrWFq5usrY7P3wznpd/X/1RlRpCoJngQa4gIj17ZOnPc6tgwkh8p0J9J16IzXHs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(6916009)(2906002)(83380400001)(30864003)(44832011)(40460700003)(8936002)(82310400005)(47076005)(86362001)(40480700001)(1076003)(2616005)(336012)(426003)(186003)(36860700001)(5660300002)(36756003)(316002)(478600001)(26005)(41300700001)(7696005)(82740400003)(81166007)(70206006)(8676002)(4326008)(70586007)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 02:02:52.0066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f073f2-935a-4aef-b03e-08da84ab964a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0191
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For runtime pm case:
1. prompt in dmesg for BAMACO feature test
2. set BACO by defatul and the user can select BAMACO

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 17 +++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
 14 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1372e2b47541..104bb62db830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -598,6 +598,7 @@ struct amdgpu_asic_funcs {
 	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	/* device supports BACO */
 	bool (*supports_baco)(struct amdgpu_device *adev);
+	bool (*supports_maco)(struct amdgpu_device *adev);
 	/* pre asic_init quirks */
 	void (*pre_asic_init)(struct amdgpu_device *adev);
 	/* enter/exit umd stable pstate */
@@ -1289,6 +1290,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
+#define amdgpu_asic_supports_maco(adev) (adev)->asic_funcs->supports_maco((adev))
 #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
@@ -1329,6 +1331,7 @@ bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
 bool amdgpu_device_supports_baco(struct drm_device *dev);
+bool amdgpu_device_supports_maco(struct drm_device *dev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
 int amdgpu_device_baco_enter(struct drm_device *dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ebb722811dcf..a034295fae71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -272,6 +272,13 @@ bool amdgpu_device_supports_baco(struct drm_device *dev)
 	return amdgpu_asic_supports_baco(adev);
 }
 
+bool amdgpu_device_supports_maco(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	return amdgpu_asic_supports_maco(adev);
+}
+
 /**
  * amdgpu_device_supports_smart_shift - Is the device dGPU with
  * smart shift support
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 95bce47943bb..4c022785ded1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -171,13 +171,19 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			break;
 		default:
-			/* enable BACO as runpm mode on CI+ */
-			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+			/* enable BACO/BAMACO as runpm mode on CI+ */
+			if (amdgpu_runtime_pm == 2 && amdgpu_device_supports_maco(dev))
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+			else
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			break;
 		}
 
 		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
+
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
+			dev_info(adev->dev, "Using BAMACO for runtime pm\n");
 	}
 
 	/* Call ACPI methods: require modeset init
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b067ce45d226..b363c729b9b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2374,7 +2374,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	 * Skip SMU FW reloading in case of using BACO for runpm only,
 	 * as SMU is always alive.
 	 */
-	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
+	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
+						   adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO))
 		return 0;
 
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1ff7fc7bb340..f21653fbe69c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -511,6 +511,7 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs =
 	.need_reset_on_init = &soc21_need_reset_on_init,
 	.get_pcie_replay_count = &soc21_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
+	.supports_maco = &amdgpu_dpm_is_maco_supported,
 	.pre_asic_init = &soc21_pre_asic_init,
 	.query_video_codecs = &soc21_query_video_codecs,
 };
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 7e3231c2191c..43635d238451 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -389,6 +389,7 @@ struct amd_pm_funcs {
 	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
 	int (*get_asic_baco_capability)(void *handle, bool *cap);
+	int (*get_asic_maco_capability)(void *handle, bool *cap);
 	int (*get_asic_baco_state)(void *handle, int *state);
 	int (*set_asic_baco_state)(void *handle, int state);
 	int (*get_ppfeature_status)(void *handle, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 956b6ce81c84..b3e373046928 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -209,6 +209,29 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 	return ret ? false : baco_cap;
 }
 
+bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	bool maco_cap;
+	int ret = 0;
+
+	if (!pp_funcs || !pp_funcs->get_asic_maco_capability)
+		return false;
+
+	if (adev->in_s3)
+		return false;
+
+	mutex_lock(&adev->pm.mutex);
+
+	ret = pp_funcs->get_asic_maco_capability(pp_handle,
+						 &maco_cap);
+
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret ? false : maco_cap;
+}
+
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 65624d091ed2..911a293d95b2 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -50,6 +50,7 @@ enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_PX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
+	AMDGPU_RUNPM_BAMACO,
 };
 
 struct amdgpu_ps {
@@ -388,6 +389,7 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
 
 bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
+bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev);
 
 bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7510d470b864..11e611edb874 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2723,6 +2723,21 @@ static int smu_get_baco_capability(void *handle, bool *cap)
 	return 0;
 }
 
+static int smu_get_maco_capability(void *handle, bool *cap)
+{
+	struct smu_context *smu = handle;
+
+	*cap = false;
+
+	if (!smu->pm_enabled)
+		return 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->maco_is_support)
+		*cap = smu->ppt_funcs->maco_is_support(smu);
+
+	return 0;
+}
+
 static int smu_baco_set_state(void *handle, int state)
 {
 	struct smu_context *smu = handle;
@@ -2984,6 +2999,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_active_display_count         = smu_set_display_count,
 	.set_min_deep_sleep_dcefclk       = smu_set_deep_sleep_dcefclk,
 	.get_asic_baco_capability         = smu_get_baco_capability,
+	.get_asic_maco_capability         = smu_get_maco_capability,
 	.set_asic_baco_state              = smu_baco_set_state,
 	.get_ppfeature_status             = smu_sys_get_pp_feature_mask,
 	.set_ppfeature_status             = smu_sys_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b81c657c7386..6bd5777b8780 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1134,6 +1134,7 @@ struct pptable_funcs {
 	 * @baco_is_support: Check if GPU supports BACO (Bus Active, Chip Off).
 	 */
 	bool (*baco_is_support)(struct smu_context *smu);
+	bool (*maco_is_support)(struct smu_context *smu);
 
 	/**
 	 * @baco_get_state: Get the current BACO state.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 6fe2fe92ebd7..f2f76fac28ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -218,6 +218,7 @@ int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
 
 bool smu_v13_0_baco_is_support(struct smu_context *smu);
+bool smu_v13_0_maco_is_support(struct smu_context *smu);
 
 enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3651f6f75068..6db051eb6aa5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2278,6 +2278,21 @@ bool smu_v13_0_baco_is_support(struct smu_context *smu)
 	return true;
 }
 
+bool smu_v13_0_maco_is_support(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+
+	if (amdgpu_sriov_vf(smu->adev) ||
+	    !smu_baco->maco_support)
+		return false;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
+	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
+		return false;
+
+	return true;
+}
+
 enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
@@ -2298,7 +2313,7 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      smu_baco->maco_support ?
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index df4a47acd724..28d54e671a1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1845,6 +1845,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.deep_sleep_control = smu_v13_0_deep_sleep_control,
 	.gfx_ulv_control = smu_v13_0_gfx_ulv_control,
 	.baco_is_support = smu_v13_0_baco_is_support,
+	.maco_is_support = smu_v13_0_maco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
 	.baco_enter = smu_v13_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 1016d1c216d8..459a6096e552 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1632,6 +1632,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.baco_is_support = smu_v13_0_baco_is_support,
+	.maco_is_support = smu_v13_0_maco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
 	.baco_enter = smu_v13_0_baco_enter,
-- 
2.25.1

