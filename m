Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1848C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 03:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C3110F525;
	Wed, 13 Jul 2022 03:18:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C53110FDC7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 03:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzn6dJeWpDPUGqirdI55GCy0CNY5AMJW7ZbfCqVI7HE1VYZiSXDwnnDZvdEuMxlA49PAfsM+4ym7bD4aNpdm7tCQ+8TUlfuq2wGNJtz7iNfXeuKKs6buauNNuZb+6XknZqzVPU8S2cMLhLHHqG5l83aFqt7PBALFbsbri3+k3/qqJTZ4jJOD/nm+/9cFlRnYjvwy7uOnFhrLJkfCfNYxEkLcRG+S6rCUPwFlu37vbWeFu82YQHmHRGbAOfa13dQsr+ISf8UCKhvMqWP5IIo7QEZujO3GGwiVo5XlM4B22sjaXmKM/vY6QLqPDXopwmnt+KxDCAByh+vg5n2MglX0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rEA0rtDvUat4FuzTx495/+4k5x+xjyG6p5OEfHmBZs=;
 b=dJ80lNlk2u0adG75U83zSnHUiHg+3RatzEPpSWxpd9han7X+BbfdtivVqsMH4jWFjpGa0DD1vhRL6msmpLvOlc1jpwxMiaU13kVXAZtgJls9TE7NlztQDIIj9GPCRyixAIwca4PCnzLaYeg60sAEONYvRb8DmcNQsFZG+4ksjWlqrOGJX8Sb4/AvfqvR7hEGXlzjNfGrcDC9r5iIrDihh3EBBY6HMcENIjGQb8j77W8me+870T8q+ROGYP2Xm35ALwBt7DT3e5YmjfEqpEP5sRqn55RclRTIIwdK6jSicXV9EPXAcwBCPL6JBSv5upSPEfSxoOBMcKknsmNMb94xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rEA0rtDvUat4FuzTx495/+4k5x+xjyG6p5OEfHmBZs=;
 b=lIvhCyyZ6HYPfo+igyDkbr4Us9PteuqNfAucuDmdd47WuTnTYDci/tW9mMKd7ONTschyhA3tSVWPtaoUBGxW/s52say9QLYL+FCpyPmN5SnCndNVAKg2bWgpKYVdDwnK1xm9rJuS/KeeYqdZBbhQdC6/pWt7g/uXb+SmkoGmfBU=
Received: from MW4PR02CA0023.namprd02.prod.outlook.com (2603:10b6:303:16d::16)
 by MN2PR12MB4640.namprd12.prod.outlook.com (2603:10b6:208:38::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 03:18:18 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::bf) by MW4PR02CA0023.outlook.office365.com
 (2603:10b6:303:16d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22 via Frontend
 Transport; Wed, 13 Jul 2022 03:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 03:18:17 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 22:17:55 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use cached baco flag as the check in runpm
 (v3)
Date: Wed, 13 Jul 2022 11:17:39 +0800
Message-ID: <20220713031739.2263-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d0be29-6822-442c-df84-08da647e54b8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4640:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ijcx8BBDRMx6xIcgGohT46VeKAXLFcVC0qCs/wUed38EvEdwqnLUGHl9YY4OlEG+1UIi2tWIdHpwrKbpPcIXwMRn5MIxJR9YDVexatxLj3K3F0KVHqQopIlN9x8hbruvuywNE0Oq+7p24c2HWp5UJptrgl6nqIEpvHhsp4nn7aXli3zMm5da3rKsOLJeg/gdZyp2p2gisE0g3P2XxunoweVmFcrJQpjTNyiCjKsFbJssKu2AGNmv5YsE0KUFE3aPXqrFVaORLL4NJ/2EsZcOQgO8UZDqHKb+DhPnbDLVcKfDruWd9FcYzn/yk4hkqHKNov4Z5alW+wuRin+3O1lImdzKpArSFg+wRDqGQNXhL4vxgF9uk6qAyTVRdMSVWV/xLNzmrJ1TdD8uOdk4Ez0xhn0A/5eQQ4Ey+tZYjgMikbd4lwBp98zOHeLFPTdMmog81jmjqAOAuWQXC1KKNlbuwRV1xklmoQFtM6eZNPGYQRLKCvaJBLoHyWsr5UsNV7SayEaeRebSH0Mslnw6y0jHat2PVRdKpBgqe/mlOfi3YcKEj3hoaYG3Mvs0Gu30rsY2boKkPQP+/fbcFJ7fPIcBIkotloxbpTeuTKiRB5bbHJWvZ/5Oxxsr05BXRYzOOby95fn+cQUtZN+NssMkNEonXT8T5EGLgVquhE3ylRHdW7Wev+c3o2aQZM9fsxUnKTLzOQCMl2GOvsn6XorFh77xx4/DccX0DynRGaWOzCRzfJoYK5ax/FOnDzgc2l2vKhTFcilmk+JLzucjA499JrvNtOG6PmIKx0h1/Sj7w5GpvgK7PNU+S7+V/Mt3bxXyUekslpsuaeV1oomE6QZM2AJHRKv4eZLqcj9VemHsbhLRPtvRkDmrBZuhOzyFxs5mgVb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(40470700004)(46966006)(110136005)(1076003)(40460700003)(6636002)(36756003)(2616005)(2906002)(316002)(82740400003)(44832011)(478600001)(81166007)(16526019)(5660300002)(36860700001)(356005)(82310400005)(186003)(41300700001)(6666004)(40480700001)(47076005)(426003)(336012)(70586007)(70206006)(26005)(4326008)(86362001)(7696005)(83380400001)(8936002)(8676002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 03:18:17.4218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d0be29-6822-442c-df84-08da647e54b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4640
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU will perform dpm disablement when entering BACO,
and enable them later on, so talking to SMU to get
enabled features mask in runpm cycle as BACO support
check is not reliable. Hence, use a cached baco flag
to fix it.

v2: cache this flag in load sequence to simplify code (from Evan)
v3: introduce runpm mode as the check (from Lijo)

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 8 ++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4b663866d33a..ceecb74842de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -161,10 +161,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	if (amdgpu_device_supports_px(dev) &&
 	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 		adev->runpm = true;
+		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
 		dev_info(adev->dev, "Using ATPX for runtime pm\n");
 	} else if (amdgpu_device_supports_boco(dev) &&
 		   (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 		adev->runpm = true;
+		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
 		dev_info(adev->dev, "Using BOCO for runtime pm\n");
 	} else if (amdgpu_device_supports_baco(dev) &&
 		   (amdgpu_runtime_pm != 0)) {
@@ -188,8 +190,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 
 		amdgpu_runtime_pm_quirk(adev);
 
-		if (adev->runpm)
+		if (adev->runpm) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
+		}
 	}
 
 	/* Call ACPI methods: require modeset init
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index de59dc051340..0d31ab5fa1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2348,12 +2348,12 @@ static int psp_load_smu_fw(struct psp_context *psp)
 			&adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 	struct amdgpu_ras *ras = psp->ras_context.ras;
 
-	/* Skip SMU FW reloading in case of using BACO for runpm only,
+	/*
+	 * Skip SMU FW reloading in case of using BACO for runpm only,
 	 * as SMU is always alive.
 	 */
 	if (adev->in_runpm &&
-	    !amdgpu_device_supports_boco(adev_to_drm(adev)) &&
-	    amdgpu_device_supports_baco(adev_to_drm(adev)))
+	    (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
 		return 0;
 
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 524fb09437e5..efeb3a8d20e2 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -45,6 +45,13 @@ enum amdgpu_int_thermal_type {
 	THERMAL_TYPE_KV,
 };
 
+enum amdgpu_runpm_mode {
+	AMDGPU_RUNPM_NONE,
+	AMDGPU_RUNPM_PX,
+	AMDGPU_RUNPM_BOCO,
+	AMDGPU_RUNPM_BACO,
+};
+
 struct amdgpu_ps {
 	u32 caps; /* vbios flags */
 	u32 class; /* vbios flags */
@@ -355,6 +362,7 @@ struct amdgpu_pm {
 	struct amdgpu_ctx       *stable_pstate_ctx;
 
 	struct config_table_setting config_table;
+	enum amdgpu_runpm_mode rpm_mode;
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-- 
2.17.1

