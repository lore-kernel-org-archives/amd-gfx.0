Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B926BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3496110EA07;
	Fri, 11 Feb 2022 07:52:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08F910EA06
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWcBwNSg9M+AZlHcNEHa/YYhwaRHegCtWrlYT6j5Og6qdohhoLfWhMxoLkJnClyMlm1lmjshbM+DsAp9NihPocZ8+TzACkKHpGxb33f5s/R7hmIA0fwTOxkT4k5rFdXsa1OwkWsh6X2egT+8eLLF/PnceMTN4MasG53zqPTqwui4fyuBKqhwdaHvpG0weyWOqBXQ4Ly96GO6QM5+LNTdGUuQiZHzj4Yolko3GnrxL5siWvOwzctAJDnZGpsbFlGh9tGrhfXMe+cHaX86gxo6wy9N8hRgcjlYe0ZGqomGo38tLVX27torPD4YPZgppEy1E6mpohUBmC7L2H3GNZUxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+Aj2IoA9GCdY/nFtDOKq5ACVP9nN8k9qmh7XEniqBY=;
 b=BjiF1U+Hi0MEv4slAfYimMmqkOOCL1745dzUNox9ocQSNUcQmpiDqcnx9cP7oVoojq4B3NslmmOHf4GUsJ8+PpT4nFFZj/9h1GcWXvbokEPw4wvi7u838KBxR1uK0JWIY5BQd23Dnp+9rnHyebDOJnPHbmM2DL8s2KoSNLky7ysuzvxRbV2Dhj099kolFx6EUMqQbonmmy9a8Pva3OnD1SLA/b9mReLZ+op7Yhf7sB+e23QAtnZ/o6JMYFiBM2L7z/x6iaoW8FSapFsOaWO5TPBzNB5SsUfhLAwNIVwggHkQZ1WMSxJt5ulElEPzIN+N+4uN78L0qczDETBRlI+vZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+Aj2IoA9GCdY/nFtDOKq5ACVP9nN8k9qmh7XEniqBY=;
 b=NttOAzWptyAaS7WBR1CgJ7V3HYOkdj37gXo0X2e6T4SVwK69ldwdvyp4xCt7q5NN2FG/c0XM8bCnW0PFFEZjNk1/I174F/ivu+F/+6CHddklaS/A7FgFrEtP1IbHgI+SfTQiNC2Nkhc3gZgevEk/p30xG27MwV1vnbFr2gbCNXo=
Received: from DM6PR02CA0142.namprd02.prod.outlook.com (2603:10b6:5:332::9) by
 DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.12; Fri, 11 Feb 2022 07:52:52 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332::4) by DM6PR02CA0142.outlook.office365.com
 (2603:10b6:5:332::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:51 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:49 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/pm: correct the checks for granting gpu reset
 APIs
Date: Fri, 11 Feb 2022 15:52:04 +0800
Message-ID: <20220211075209.894833-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d91b48a-789b-4101-664d-08d9ed338173
X-MS-TrafficTypeDiagnostic: DM6PR12MB3898:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38989BD9D4397F21110D8202E4309@DM6PR12MB3898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWQGxFVYrWLeNmYFi0OcKGKBUlLiYhNIBW67/HSoVhQlN43Q2ofLkwhJ63/WFjbU4rQGR289fxmeeW6dBIh0KVCt/QWMGQ4RS4ZkD/oSypsVcSXHUWRTcPHigeox5A31yi5u/AeQKfm4gXrYKBdobM2BTenqCBXtCW7XSBoh5V7sXRIpfKYYkEvRwqOJ/8zDVkSTKKiqR8jXUMY5UuRgDy3jStq1ylwUvEVojmDSyKOsG1fv1gzZhK23RmN1uNa94G/TEWHx/udQEf8ZBW8PGmU7XFMDykfTu915bl79She6QPBaM21CPRJUg/6RZwJNu5gWeStOzL9WbFB+xnyHjHjfF8Yvy/X6hRXnLTQR4YqyOA/YrF9N0DLeivFBag8SI0iKORSAsDtMxio2c7oxfzNBPJ48R0lTLucltHBNqRgM2dGHVMhA4TyraE8i6X3qAuWg1c1UIMHp7AiYcQHKfXVFmTIn60Rcfgdid9EtCJNOHc+76UuP0qiQihMVYnMZWKcMbComRd1himyjtzpgvuPxizjeA4UU8jfW70nTadBEmbyUghQ79xFwIb5fqZ1/BPD34iyUzuayM206n41ZCwx9oVm5gwLX2qBMHLumoOVSOfvNVP8+u0GXj6AS0c6kRThAWF9Q2eRWjWyPYjQRNPjP3BdgMI86PVsoP4hQsBKe+t66UNgJrOhte9m/plfYx4B4TkNzG6JGRjRsF3khMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(2616005)(6916009)(316002)(4326008)(8676002)(83380400001)(2906002)(44832011)(7696005)(30864003)(36756003)(70586007)(70206006)(508600001)(426003)(336012)(1076003)(26005)(186003)(16526019)(40460700003)(86362001)(36860700001)(356005)(47076005)(8936002)(82310400004)(6666004)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:51.9480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d91b48a-789b-4101-664d-08d9ed338173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3898
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those gpu reset APIs can be granted when:
  - System is up and dpm features are enabled.
  - System is under resuming and dpm features are not yet enabled.
    Under such scenario, the PMFW is already alive and can support
    those gpu reset functionalities.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I8c2f07138921eb53a2bd7fb94f9b3622af0eacf8
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 34 +++++++++++++++
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 42 +++++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  1 +
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 17 ++++++++
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 32 +++++++-------
 7 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a4c267f15959..892648a4a353 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -409,6 +409,7 @@ struct amd_pm_funcs {
 				   struct dpm_clocks *clock_table);
 	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
 	void (*pm_compute_clocks)(void *handle);
+	bool (*is_smc_alive)(void *handle);
 };
 
 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index b46ae0063047..5f1d3342f87b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -120,12 +120,25 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	return ret;
 }
 
+static bool amdgpu_dpm_is_smc_alive(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (!pp_funcs || !pp_funcs->is_smc_alive)
+		return false;
+
+	return pp_funcs->is_smc_alive;
+}
+
 int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
 	int ret = 0;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
@@ -145,6 +158,9 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
 	void *pp_handle = adev->powerplay.pp_handle;
 	int ret = 0;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
@@ -164,6 +180,9 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return -EOPNOTSUPP;
+
 	if (pp_funcs && pp_funcs->set_mp1_state) {
 		mutex_lock(&adev->pm.mutex);
 
@@ -184,6 +203,9 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 	bool baco_cap;
 	int ret = 0;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return false;
+
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
 		return false;
 
@@ -203,6 +225,9 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 	void *pp_handle = adev->powerplay.pp_handle;
 	int ret = 0;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
 		return -ENOENT;
 
@@ -221,6 +246,9 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 	void *pp_handle = adev->powerplay.pp_handle;
 	int ret = 0;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return -EOPNOTSUPP;
+
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
@@ -244,6 +272,9 @@ bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	bool support_mode1_reset = false;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return false;
+
 	if (is_support_sw_smu(adev)) {
 		mutex_lock(&adev->pm.mutex);
 		support_mode1_reset = smu_mode1_reset_is_support(smu);
@@ -258,6 +289,9 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = -EOPNOTSUPP;
 
+	if (!amdgpu_dpm_is_smc_alive(adev))
+		return -EOPNOTSUPP;
+
 	if (is_support_sw_smu(adev)) {
 		mutex_lock(&adev->pm.mutex);
 		ret = smu_mode1_reset(smu);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index bba923cfe08c..4c709f7bcd51 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -844,9 +844,6 @@ static int pp_dpm_set_mp1_state(void *handle, enum pp_mp1_state mp1_state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en)
-		return 0;
-
 	if (hwmgr->hwmgr_func->set_mp1_state)
 		return hwmgr->hwmgr_func->set_mp1_state(hwmgr, mp1_state);
 
@@ -1305,8 +1302,7 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
 	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
@@ -1321,7 +1317,7 @@ static int pp_get_asic_baco_state(void *handle, int *state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
+	if (!hwmgr->hwmgr_func->get_asic_baco_state)
 		return 0;
 
 	hwmgr->hwmgr_func->get_asic_baco_state(hwmgr, (enum BACO_STATE *)state);
@@ -1336,8 +1332,7 @@ static int pp_set_asic_baco_state(void *handle, int state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->set_asic_baco_state)
+	if (!hwmgr->hwmgr_func->set_asic_baco_state)
 		return 0;
 
 	hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum BACO_STATE)state);
@@ -1379,7 +1374,7 @@ static int pp_asic_reset_mode_2(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->asic_reset == NULL) {
@@ -1517,6 +1512,34 @@ static void pp_pm_compute_clocks(void *handle)
 			      NULL);
 }
 
+/* MP Apertures */
+#define MP1_Public					0x03b00000
+#define smnMP1_FIRMWARE_FLAGS				0x3010028
+#define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK	0x00000001L
+
+static bool pp_is_smc_alive(void *handle)
+{
+	struct pp_hwmgr *hwmgr = handle;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t mp1_fw_flags;
+
+	/*
+	 * If some ASIC(e.g. smu7/smu8) needs special handling for
+	 * checking smc alive, it should have its own implementation
+	 * for ->is_smc_alive.
+	 */
+	if (hwmgr->hwmgr_func->is_smc_alive)
+		return hwmgr->hwmgr_func->is_smc_alive(hwmgr);
+
+	mp1_fw_flags = RREG32_PCIE(MP1_Public |
+				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+	if (mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)
+		return true;
+
+	return false;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
@@ -1582,4 +1605,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.gfx_state_change_set = pp_gfx_state_change_set,
 	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
 	.pm_compute_clocks = pp_pm_compute_clocks,
+	.is_smc_alive = pp_is_smc_alive,
 };
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index a1e11037831a..118039b96524 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5735,6 +5735,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.get_asic_baco_state = smu7_baco_get_state,
 	.set_asic_baco_state = smu7_baco_set_state,
 	.power_off_asic = smu7_power_off_asic,
+	.is_smc_alive = smu7_is_smc_ram_running,
 };
 
 uint8_t smu7_get_sleep_divider_id_from_clock(uint32_t clock,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b50fd4a4a3d1..fc4d58329f6d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -2015,6 +2015,22 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	}
 }
 
+#define ixMP1_FIRMWARE_FLAGS					0x3008210
+#define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK		0x00000001L
+
+static bool smu8_is_smc_running(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t mp1_fw_flags;
+
+	mp1_fw_flags = RREG32_SMC(ixMP1_FIRMWARE_FLAGS);
+
+	if (mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)
+		return true;
+
+	return false;
+}
+
 static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.backend_init = smu8_hwmgr_backend_init,
 	.backend_fini = smu8_hwmgr_backend_fini,
@@ -2047,6 +2063,7 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.dynamic_state_management_disable = smu8_disable_dpm_tasks,
 	.notify_cac_buffer_info = smu8_notify_cac_buffer_info,
 	.get_thermal_temperature_range = smu8_get_thermal_temperature_range,
+	.is_smc_alive = smu8_is_smc_running,
 };
 
 int smu8_init_function_pointers(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 4f7f2f455301..790fc387752c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -364,6 +364,7 @@ struct pp_hwmgr_func {
 					bool disable);
 	ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
 	int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
+	bool (*is_smc_alive)(struct pp_hwmgr *hwmgr);
 };
 
 struct pp_table_func {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8b8feaf7aa0e..27a453fb4db7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1845,9 +1845,6 @@ static int smu_set_mp1_state(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs &&
 	    smu->ppt_funcs->set_mp1_state)
 		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
@@ -2513,9 +2510,6 @@ static int smu_get_baco_capability(void *handle, bool *cap)
 
 	*cap = false;
 
-	if (!smu->pm_enabled)
-		return 0;
-
 	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
 		*cap = smu->ppt_funcs->baco_is_support(smu);
 
@@ -2527,9 +2521,6 @@ static int smu_baco_set_state(void *handle, int state)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
 	if (state == 0) {
 		if (smu->ppt_funcs->baco_exit)
 			ret = smu->ppt_funcs->baco_exit(smu);
@@ -2551,9 +2542,6 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 {
 	bool ret = false;
 
-	if (!smu->pm_enabled)
-		return false;
-
 	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
 		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
 
@@ -2564,9 +2552,6 @@ int smu_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->mode1_reset)
 		ret = smu->ppt_funcs->mode1_reset(smu);
 
@@ -2578,9 +2563,6 @@ static int smu_mode2_reset(void *handle)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
 	if (smu->ppt_funcs->mode2_reset)
 		ret = smu->ppt_funcs->mode2_reset(smu);
 
@@ -2712,6 +2694,19 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 	return 0;
 }
 
+static bool smu_is_smc_alive(void *handle)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->ppt_funcs->check_fw_status)
+		return false;
+
+	if (!smu->ppt_funcs->check_fw_status(smu))
+		return true;
+
+	return false;
+}
+
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
 	.set_fan_control_mode    = smu_set_fan_control_mode,
@@ -2765,6 +2760,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_uclk_dpm_states              = smu_get_uclk_dpm_states,
 	.get_dpm_clock_table              = smu_get_dpm_clock_table,
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
+	.is_smc_alive = smu_is_smc_alive,
 };
 
 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
-- 
2.29.0

