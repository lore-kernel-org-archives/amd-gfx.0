Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9821C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 02:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4434A10E7D6;
	Fri, 12 Apr 2024 02:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MadKg4uw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6279110E7D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 02:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM+Xn9NyVHJXs2xh0XCBIdwXcyARs51KGmThR/qLKpCVGnvThwW0kqJ6DdEWj3YP5YSS/7zW3LS7f9j7Jf077yChDrcIbCZ2noHGax2lFJD2KItPa9RkUFWPRQXRImPWaifu/0+PnJuGV/G0/G/9ArdOT3M/+qwS+8RDz6dGLVu0Qx7O07RtCG8s987dZuauHyOH7WvalXg21MGozjstNC8qj0XrKISBaZHIv1vUC4L3f0yXTOd/aaDpG/1GGxYd8UzEI8s9yeXh8vH2Lgd/wIvuMnH8NLuuuJ7rZxDj+sufjecF0BfHXq1eQY6UyyYuKXkeBWUMnBXzGdPV+xh6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcQz0Qlos6/w/NcdSMU66xuurEa+wKZhRf/mpS8wKSw=;
 b=hinzXhDai2P8fAX+sE+dkXoRW7fQ6lapArVgE9uygaO8i+rnwyaT4zM5b5pXgLAl0jkh+Zhz+8gnbC9bTApd5R8CCUgYinLyj+UmM+gpBuR2N3VQZn5mDVEFNgwW5ix/pgHjzcDFLPgq+w/zjtkK7+WGIBPZsupUXcSNs4ndOiXAgsGV7oBdxvVCbTHWtD3Iv2PU3PrlxyMuFAglJU7FBoxEh0z6/3Jz2OrjbKThPTf7DZZs1LlgeI92mBZoPbrkp/Htb2AxfyRO9pBNqo6hlhmyaOk1+RBWc45Lms6O/bDyKdt0ZKe9lCcboi1I7nMwS7kZ91OwjykC0aVjCMdNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcQz0Qlos6/w/NcdSMU66xuurEa+wKZhRf/mpS8wKSw=;
 b=MadKg4uwv3NZWB2xPX87eVxtl34bi1iBFQzFxRLbRMZt0v88PzgT0zqVrHVr3jIC1L1RGJtfu9lJGw6r524EPxHcHni5NjB8hkyf7NhdK/lE5qSvcgnZtvi192uJVGfeXQttilAiaEdQkJQ6dHmmNqGLA7BOzOJLmKIhvK34jWw=
Received: from MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35) by
 DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 02:58:55 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::c1) by MW2PR16CA0022.outlook.office365.com
 (2603:10b6:907::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 02:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 02:58:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 21:58:47 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: add new aca smu callback func parse_error_code{}
Date: Fri, 12 Apr 2024 10:54:13 +0800
Message-ID: <20240412025413.2957312-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DM6PR12MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: f50e3441-3ca4-49fe-9488-08dc5a9c7e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmPEWadKN07guz8LWPCnZ3WvZ7te4D5/vY+zyjZmiFuT0FIvAsma8k75zXWhUVhJCaSf6wBwP7HJqP+wvhBwHgV/12P64AtL7ndxjJJ41Ex9jz9EL/Vy71QVEuvPumkKMzhaOuIrxNQKJRz0sBdZGaYsB51tfo6WDANa9opU5nyCFxDIAS5yXt4UL95BlBjxtFBxE0OKSj+stOxRD6tH8RfrTnoZ5fxblVNLHD9PYqVz+qZSeOvLGs4DI8g9V/sJNUE7/8szgGNL/WeZ6H3aDSBmmrpuzs9T4IlYAiLZ4q+B8sn7ZoKfbUxdJldU6t14oR+Xi4RRNZ7VhQi8k/zzjH0lbZwJLgYRouFxg/Dxl9WJIoKkSmzUDy0Q5mmEBruJtBFb35BtLTqx7wXS98wJC2MwNFgIeNpDIMIl0Ww7KKsPn9ihlaxY6L/yomLHWKCd2Sy5eQPAyWP8rPgIdVd0kmsJ9tV8mM8dbRnM+eP5uGw8kdgRUkvAPKRroB63maME38pPF7MKSMkJkgdjW4w3pduVBXmVUBmIjbKDmVaMCLmxbE6oqfxqRL+vyeywVHQ5wPRXqyVjBWT7X1Wlz9zao05lhCVhrUFqgNEUK9VXgnGWTWx3df0sdlUSuY6149xerg0xUsXEaqwEuMP/AnEOHsdcl2T8ZtpX8XEUftSjalnDlIiW3loFty/SAosXIS50njvGjNeI2mF7B2Yerg4Wd/lPKKFmbhc+Uas+dKKtAtMup+hyiA2M3bCsQv5x0Heg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 02:58:55.5249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f50e3441-3ca4-49fe-9488-08dc5a9c7e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add new aca smu callback parse_error_code{} to avoid specific asic check
in amdgpu_aca.c file

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       | 23 +++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h       |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 13 +++++++++++
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index cb6a40a042e1..d1059e4d54d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -753,23 +753,13 @@ int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info *info)
 
 static int aca_bank_get_error_code(struct amdgpu_device *adev, struct aca_bank *bank)
 {
-	int error_code;
-
-	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-	case IP_VERSION(13, 0, 6):
-		if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >= 0x00555600) {
-			error_code = ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
-			return error_code & 0xff;
-		}
-		break;
-	default:
-		break;
-	}
+	struct amdgpu_aca *aca = &adev->aca;
+	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
 
-	/* NOTE: the true error code is encoded in status.errorcode[0:7] */
-	error_code = ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
+	if (!smu_funcs || !smu_funcs->parse_error_code)
+		return -EOPNOTSUPP;
 
-	return error_code & 0xff;
+	return smu_funcs->parse_error_code(adev, bank);
 }
 
 int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank, int *err_codes, int size)
@@ -780,6 +770,9 @@ int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank
 		return -EINVAL;
 
 	error_code = aca_bank_get_error_code(adev, bank);
+	if (error_code < 0)
+		return error_code;
+
 	for (i = 0; i < size; i++) {
 		if (err_codes[i] == error_code)
 			return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 3765843ea648..5ef6b745f222 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -173,6 +173,7 @@ struct aca_smu_funcs {
 	int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
 	int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_smu_type type, u32 *count);
 	int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum aca_smu_type type, int idx, struct aca_bank *bank);
+	int (*parse_error_code)(struct amdgpu_device *adev, struct aca_bank *bank);
 };
 
 struct amdgpu_aca {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d6d5be26e222..59e5c6256ea2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3119,12 +3119,25 @@ static int aca_smu_get_valid_aca_bank(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct aca_bank *bank)
+{
+	int error_code;
+
+	if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >= 0x00555600)
+		error_code = ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
+	else
+		error_code = ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
+
+	return error_code & 0xff;
+}
+
 static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs = {
 	.max_ue_bank_count = 12,
 	.max_ce_bank_count = 12,
 	.set_debug_mode = aca_smu_set_debug_mode,
 	.get_valid_aca_count = aca_smu_get_valid_aca_count,
 	.get_valid_aca_bank = aca_smu_get_valid_aca_bank,
+	.parse_error_code = aca_smu_parse_error_code,
 };
 
 static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
-- 
2.34.1

