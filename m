Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26AFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4316F5EB;
	Tue, 30 Nov 2021 07:44:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD796F5ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBXcz9DVLNIZO4DQ+einex79+T8NdKSOKogsXAl81lXX6o5mZm8XXFT/aVcW5dlzA162YhX1/L1ifoLAn61lSVEAglDjqgKiesCc/KDrT2pvWGYrDK0pH4LUJK+B9MKHk4lGAfam++gJEwNRfHucjBBMgaSDVFqlcEZ2nKcGy9Kjh9dzvV3rxQ7EFH0w3tMMVj1K466iOLwt02bVip4sIpmf8rh08kAS6v3kqvyiF9yiuBBh3iXthLc0H1AvGGtZlRJTPOcdiJ/h3M5nuDPaIMFrw560b04k22e/ocu91MY/Luu7aqNcUmFam9hJG4bJlsiyopewklTDJmB3jEMDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjm64K6GkSX/pigWHZCjKqa5lPypgUaRsqJRYgSkzis=;
 b=YoHG1mCL95c69dZJVlzsobpvMv4VWtwadVzSC07/1slR7rO0ta0XyrQc5xLjU+trzgETyEXBPJSJIriIHrYNvW1lhmza8viWnC0Rw6y2ZJV6akzc1gn2WiZEoI0gFrvgIPymNA51ehjILX/EQauAV6i8XkzJCTgn6usoT02CIF3fhs/QLPju0bFjrIaD1AAXKovGMnQvGnXFq32KCLeCpTPEaKalZq6PoTE/8w888vQcmgM51TsoRbWNuS2wC5eNgADydu3DoXu4GEmXLUTSu3Kz587lO7CzUvNytfbS6ak9YeWCvPflDlL4Vn+AzxGEXcwyXCT10BO6APlQAi7UOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjm64K6GkSX/pigWHZCjKqa5lPypgUaRsqJRYgSkzis=;
 b=EB2q7BP5gpHx9j9BrqsBMmPHa8aqOFUqU/9HDrVq7KKFfJR0kifONX0kxRqde4KR3IwKejgRmrOtAiA65ZrBHnJxJJXbFZ001BNhMglLzE1C8W+YtHe4iYfygH9s/ZQ5dPeEgT/3UkcgwTtAwCdlF06IGyv1jUaDuSwXDTwDJp0=
Received: from BN6PR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:405:15::30) by DM6PR12MB4879.namprd12.prod.outlook.com
 (2603:10b6:5:1b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 07:43:58 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::d8) by BN6PR1701CA0020.outlook.office365.com
 (2603:10b6:405:15::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:58 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:56 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 17/17] drm/amd/pm: unified lock protections in amdgpu_dpm.c
Date: Tue, 30 Nov 2021 15:42:59 +0800
Message-ID: <20211130074259.1271965-18-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24865713-8dea-49fd-b6fa-08d9b3d52b55
X-MS-TrafficTypeDiagnostic: DM6PR12MB4879:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4879901B0A39AA04CA4F2B7DE4679@DM6PR12MB4879.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHE+tHnKDXbD6BqDfPwq/5Xtpbc1G0gmnAkBMVXZPb9gS9l+nNfRKv+Nw5t/tHk5DjQcqeHteKoN+aZHbtZGy/ADtUNYAvQptWvIwz4BlbQO88U1flrQ2MmSVPUAElLCT5kxpxwIF0gowwNIMdpIyNxdIBCeCVSAqcEUlRAcBhi8/FvjMBzq4OvJomL+r02u0+AuF9KEPS5oStoMorn2/nsnggfmfcbcEeYL51octzsx45o8G32tmtt+igPFeLg7uHNYnuazlMh/79ZUQbKMNcks5PgfRm30tCuepsa1nru55F+PCNuIfkF/iwBZqyYZ6BmNJ7OcuvqO3zQY/Hecg9kz+CfqRf9T+oTyn8OP7WA4QLxOcOMERnCfrMntnDcbNdIPaM0iyo2wmmQ0EHfgwKfePROJmi5omW8/j6p30uy4qEFibHUbaWSrUQqnLUk2M7B2BIKKTrHvkaio6D7qYcc9T0/wJPTkc8V1LRXeZGHeZP84er8c4vIlM+uC1ShYIJ2HyumCAIB6CwG9ffzPNMnEWlH4znDfMPgn9s2Bxqb4RPA7O1BTRDr4xCRIDAWbyAGxKQgW8GO9p3DhLNO8fkLqRykyuaMb/QjSXGSUr2Bj85rugBKvGyBHV6KSV7lczYZkBHxbCYKMZGWTBRBY1K0MqQiqUunwrs50RD7ehjEXRIo8gByZ249GfDO1qscMI/0YWexFLFP8PLPjfSy7PC+DRB6OSvWj1ASTAe/kDe/GkrMTcQLGcfRUOCyVGX0g6Yqk2Cqq/I+gQaGkZ1de2K95jkP+ptTiFEMRupPoRWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(2906002)(186003)(16526019)(7696005)(54906003)(82310400004)(44832011)(426003)(336012)(508600001)(5660300002)(1076003)(4326008)(2616005)(316002)(26005)(81166007)(86362001)(83380400001)(356005)(70206006)(6916009)(70586007)(8936002)(47076005)(36860700001)(36756003)(30864003)(40460700001)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:58.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24865713-8dea-49fd-b6fa-08d9b3d52b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the only entry point, it's now safe and reasonable to
enforce the lock protections in amdgpu_dpm.c. And with
this, we can drop other internal used power locks.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iad228cad0b3d8c41927def08965a52525f3f51d3
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 716 +++++++++++++++------
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c |  16 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c |  16 +-
 3 files changed, 533 insertions(+), 215 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index a5cbbf9367fe..c59a82478fd8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -39,15 +39,33 @@
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->get_sclk)
+		return 0;
 
-	return pp_funcs->get_sclk((adev)->powerplay.pp_handle, (low));
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_sclk((adev)->powerplay.pp_handle,
+				 low);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->get_mclk)
+		return 0;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_mclk((adev)->powerplay.pp_handle,
+				 low);
+	mutex_unlock(&adev->pm.mutex);
 
-	return pp_funcs->get_mclk((adev)->powerplay.pp_handle, (low));
+	return ret;
 }
 
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block_type, bool gate)
@@ -62,52 +80,20 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		return 0;
 	}
 
+	mutex_lock(&adev->pm.mutex);
+
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
-		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
-			/*
-			 * TODO: need a better lock mechanism
-			 *
-			 * Here adev->pm.mutex lock protection is enforced on
-			 * UVD and VCE cases only. Since for other cases, there
-			 * may be already lock protection in amdgpu_pm.c.
-			 * This is a quick fix for the deadlock issue below.
-			 *     NFO: task ocltst:2028 blocked for more than 120 seconds.
-			 *     Tainted: G           OE     5.0.0-37-generic #40~18.04.1-Ubuntu
-			 *     echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
-			 *     cltst          D    0  2028   2026 0x00000000
-			 *     all Trace:
-			 *     __schedule+0x2c0/0x870
-			 *     schedule+0x2c/0x70
-			 *     schedule_preempt_disabled+0xe/0x10
-			 *     __mutex_lock.isra.9+0x26d/0x4e0
-			 *     __mutex_lock_slowpath+0x13/0x20
-			 *     ? __mutex_lock_slowpath+0x13/0x20
-			 *     mutex_lock+0x2f/0x40
-			 *     amdgpu_dpm_set_powergating_by_smu+0x64/0xe0 [amdgpu]
-			 *     gfx_v8_0_enable_gfx_static_mg_power_gating+0x3c/0x70 [amdgpu]
-			 *     gfx_v8_0_set_powergating_state+0x66/0x260 [amdgpu]
-			 *     amdgpu_device_ip_set_powergating_state+0x62/0xb0 [amdgpu]
-			 *     pp_dpm_force_performance_level+0xe7/0x100 [amdgpu]
-			 *     amdgpu_set_dpm_forced_performance_level+0x129/0x330 [amdgpu]
-			 */
-			mutex_lock(&adev->pm.mutex);
-			ret = (pp_funcs->set_powergating_by_smu(
-				(adev)->powerplay.pp_handle, block_type, gate));
-			mutex_unlock(&adev->pm.mutex);
-		}
-		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
 	case AMD_IP_BLOCK_TYPE_JPEG:
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
-		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+		if (pp_funcs && pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
-		}
 		break;
 	default:
 		break;
@@ -116,6 +102,8 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	if (!ret)
 		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
 
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -128,9 +116,13 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
+	mutex_lock(&adev->pm.mutex);
+
 	/* enter BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
 
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -143,9 +135,13 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
+	mutex_lock(&adev->pm.mutex);
+
 	/* exit BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
 
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -156,9 +152,13 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	if (pp_funcs && pp_funcs->set_mp1_state) {
+		mutex_lock(&adev->pm.mutex);
+
 		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
 				mp1_state);
+
+		mutex_unlock(&adev->pm.mutex);
 	}
 
 	return ret;
@@ -169,25 +169,37 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
 	bool baco_cap;
+	int ret = 0;
 
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
 		return false;
 
-	if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
-		return false;
+	mutex_lock(&adev->pm.mutex);
+
+	ret = pp_funcs->get_asic_baco_capability(pp_handle,
+						 &baco_cap);
 
-	return baco_cap;
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret ? false : baco_cap;
 }
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
+	int ret = 0;
 
 	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
 		return -ENOENT;
 
-	return pp_funcs->asic_reset_mode_2(pp_handle);
+	mutex_lock(&adev->pm.mutex);
+
+	ret = pp_funcs->asic_reset_mode_2(pp_handle);
+
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
@@ -199,37 +211,47 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
 		return -ENOENT;
 
+	mutex_lock(&adev->pm.mutex);
+
 	/* enter BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* exit BACO state */
 	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-	if (ret)
-		return ret;
 
-	return 0;
+out:
+	mutex_unlock(&adev->pm.mutex);
+	return ret;
 }
 
 bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	bool support_mode1_reset = false;
 
-	if (is_support_sw_smu(adev))
-		return smu_mode1_reset_is_support(smu);
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		support_mode1_reset = smu_mode1_reset_is_support(smu);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
-	return false;
+	return support_mode1_reset;
 }
 
 int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
 
-	if (is_support_sw_smu(adev))
-		return smu_mode1_reset(smu);
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_mode1_reset(smu);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
-	return -EOPNOTSUPP;
+	return ret;
 }
 
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
@@ -242,9 +264,12 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (pp_funcs && pp_funcs->switch_power_profile)
+	if (pp_funcs && pp_funcs->switch_power_profile) {
+		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->switch_power_profile(
 			adev->powerplay.pp_handle, type, en);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -255,9 +280,12 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (pp_funcs && pp_funcs->set_xgmi_pstate)
+	if (pp_funcs && pp_funcs->set_xgmi_pstate) {
+		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
 								pstate);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -269,8 +297,11 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
 
-	if (pp_funcs && pp_funcs->set_df_cstate)
+	if (pp_funcs && pp_funcs->set_df_cstate) {
+		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -278,11 +309,15 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
 
-	if (is_support_sw_smu(adev))
-		return smu_allow_xgmi_power_down(smu, en);
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_allow_xgmi_power_down(smu, en);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
-	return 0;
+	return ret;
 }
 
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
@@ -292,8 +327,11 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 			adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
+	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost) {
+		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -306,9 +344,12 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
 			adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (pp_funcs && pp_funcs->set_clockgating_by_smu)
+	if (pp_funcs && pp_funcs->set_clockgating_by_smu) {
+		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->set_clockgating_by_smu(pp_handle,
 						       msg_id);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -321,9 +362,12 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 			adev->powerplay.pp_funcs;
 	int ret = -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->smu_i2c_bus_access)
+	if (pp_funcs && pp_funcs->smu_i2c_bus_access) {
+		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->smu_i2c_bus_access(pp_handle,
 						   acquire);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -336,13 +380,15 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
+
 		if (adev->powerplay.pp_funcs &&
 		    adev->powerplay.pp_funcs->enable_bapm)
 			amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
-		mutex_unlock(&adev->pm.mutex);
 
 		if (is_support_sw_smu(adev))
 			smu_set_ac_dc(adev->powerplay.pp_handle);
+
+		mutex_unlock(&adev->pm.mutex);
 	}
 }
 
@@ -350,16 +396,19 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 			   void *data, uint32_t *size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
+	int ret = -EINVAL;
 
 	if (!data || !size)
 		return -EINVAL;
 
-	if (pp_funcs && pp_funcs->read_sensor)
-		ret = pp_funcs->read_sensor((adev)->powerplay.pp_handle,
-								    sensor, data, size);
-	else
-		ret = -EINVAL;
+	if (pp_funcs && pp_funcs->read_sensor) {
+		mutex_lock(&adev->pm.mutex);
+		ret = pp_funcs->read_sensor(adev->powerplay.pp_handle,
+					    sensor,
+					    data,
+					    size);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -371,7 +420,9 @@ void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
 	if (!pp_funcs->pm_compute_clocks)
 		return;
 
+	mutex_lock(&adev->pm.mutex);
 	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
 
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
@@ -406,25 +457,39 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
 {
-	int r;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int r = 0;
 
-	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->load_firmware) {
-		r = adev->powerplay.pp_funcs->load_firmware(adev->powerplay.pp_handle);
-		if (r) {
-			pr_err("smu firmware loading failed\n");
-			return r;
-		}
+	if (!pp_funcs->load_firmware)
+		return 0;
 
-		if (smu_version)
-			*smu_version = adev->pm.fw_version;
+	mutex_lock(&adev->pm.mutex);
+	r = pp_funcs->load_firmware(adev->powerplay.pp_handle);
+	if (r) {
+		pr_err("smu firmware loading failed\n");
+		goto out;
 	}
 
-	return 0;
+	if (smu_version)
+		*smu_version = adev->pm.fw_version;
+
+out:
+	mutex_unlock(&adev->pm.mutex);
+	return r;
 }
 
 int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable)
 {
-	return smu_set_light_sbr(adev->powerplay.pp_handle, enable);
+	int ret = 0;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_set_light_sbr(adev->powerplay.pp_handle,
+					enable);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
 }
 
 int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
@@ -432,8 +497,11 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev))
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
 		ret = smu_send_hbm_bad_pages_num(smu, size);
+		mutex_unlock(&adev->pm.mutex);
+	}
 
 	return ret;
 }
@@ -443,15 +511,22 @@ int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  uint32_t *min,
 				  uint32_t *max)
 {
+	int ret = 0;
+
+	if (type != PP_SCLK)
+		return -EINVAL;
+
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	switch (type) {
-	case PP_SCLK:
-		return smu_get_dpm_freq_range(adev->powerplay.pp_handle, SMU_SCLK, min, max);
-	default:
-		return -EINVAL;
-	}
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_get_dpm_freq_range(adev->powerplay.pp_handle,
+				     SMU_SCLK,
+				     min,
+				     max);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
@@ -460,26 +535,37 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
 				   uint32_t max)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
+
+	if (type != PP_SCLK)
+		return -EINVAL;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	switch (type) {
-	case PP_SCLK:
-		return smu_set_soft_freq_range(smu, SMU_SCLK, min, max);
-	default:
-		return -EINVAL;
-	}
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_set_soft_freq_range(smu,
+				      SMU_SCLK,
+				      min,
+				      max);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return 0;
 
-	return smu_write_watermarks_table(smu);
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_write_watermarks_table(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
@@ -487,27 +573,40 @@ int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
 			      uint64_t event_arg)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	return smu_wait_for_event(smu, event, event_arg);
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_wait_for_event(smu, event, event_arg);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	return smu_get_status_gfxoff(smu, value);
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_get_status_gfxoff(smu, value);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
+	if (!is_support_sw_smu(adev))
+		return 0;
+
 	return atomic64_read(&smu->throttle_int_counter);
 }
 
@@ -542,12 +641,17 @@ struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
 						     uint32_t idx)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	struct amd_vce_state *vstate = NULL;
 
 	if (!pp_funcs->get_vce_clock_state)
 		return NULL;
 
-	return pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
-					     idx);
+	mutex_lock(&adev->pm.mutex);
+	vstate = pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
+					       idx);
+	mutex_unlock(&adev->pm.mutex);
+
+	return vstate;
 }
 
 void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
@@ -555,9 +659,11 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
+	mutex_lock(&adev->pm.mutex);
+
 	if (!pp_funcs->get_current_power_state) {
 		*state = adev->pm.dpm.user_state;
-		return;
+		goto out;
 	}
 
 	*state = pp_funcs->get_current_power_state(adev->powerplay.pp_handle);
@@ -565,13 +671,17 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
 	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
 		*state = adev->pm.dpm.user_state;
 
+out:
+	mutex_unlock(&adev->pm.mutex);
 	return;
 }
 
 void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 				enum amd_pm_state_type state)
 {
+	mutex_lock(&adev->pm.mutex);
 	adev->pm.dpm.user_state = state;
+	mutex_unlock(&adev->pm.mutex);
 }
 
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
@@ -579,10 +689,12 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
 
+	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->get_performance_level)
 		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
 	else
 		level = adev->pm.dpm.forced_level;
+	mutex_unlock(&adev->pm.mutex);
 
 	return level;
 }
@@ -591,30 +703,46 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	mutex_lock(&adev->pm.mutex);
 
-	if (pp_funcs->force_performance_level) {
-		if (adev->pm.dpm.thermal_active)
-			return -EINVAL;
+	if (!pp_funcs->force_performance_level)
+		goto out;
 
-		if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
-						      level))
-			return -EINVAL;
+	if (adev->pm.dpm.thermal_active) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	adev->pm.dpm.forced_level = level;
+	if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
+					      level))
+		ret = -EINVAL;
 
-	return 0;
+out:
+	if (!ret)
+		adev->pm.dpm.forced_level = level;
+
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 				 struct pp_states_info *states)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_pp_num_states)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->get_pp_num_states(adev->powerplay.pp_handle, states);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
+					  states);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
@@ -622,21 +750,34 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 			      enum amd_pm_state_type *user_state)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->dispatch_tasks)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->dispatch_tasks(adev->powerplay.pp_handle, task_id, user_state);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
+				       task_id,
+				       user_state);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_pp_table)
 		return 0;
 
-	return pp_funcs->get_pp_table(adev->powerplay.pp_handle, table);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
+				     table);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
@@ -645,14 +786,19 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
 				      uint32_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_fine_grain_clk_vol)
 		return 0;
 
-	return pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
-						type,
-						input,
-						size);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
+					       type,
+					       input,
+					       size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
@@ -661,14 +807,19 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 				  uint32_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->odn_edit_dpm_table)
 		return 0;
 
-	return pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
-					    type,
-					    input,
-					    size);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
+					   type,
+					   input,
+					   size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
@@ -676,36 +827,51 @@ int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
 				  char *buf)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->print_clock_levels)
 		return 0;
 
-	return pp_funcs->print_clock_levels(adev->powerplay.pp_handle,
-					    type,
-					    buf);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->print_clock_levels(adev->powerplay.pp_handle,
+					   type,
+					   buf);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 				    uint64_t ppfeature_masks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_ppfeature_status)
 		return 0;
 
-	return pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
-					      ppfeature_masks);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
+					     ppfeature_masks);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_ppfeature_status)
 		return 0;
 
-	return pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
-					      buf);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
+					     buf);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
@@ -713,88 +879,131 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
 				 uint32_t mask)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->force_clock_level)
 		return 0;
 
-	return pp_funcs->force_clock_level(adev->powerplay.pp_handle,
-					   type,
-					   mask);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->force_clock_level(adev->powerplay.pp_handle,
+					  type,
+					  mask);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_sclk_od)
 		return 0;
 
-	return pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_sclk_od)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_sclk_od(adev->powerplay.pp_handle,
+				    value);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_mclk_od)
 		return 0;
 
-	return pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_mclk_od)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_mclk_od(adev->powerplay.pp_handle,
+				    value);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 				      char *buf)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
-						buf);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
+					       buf);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_power_profile_mode)
 		return 0;
 
-	return pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
-						input,
-						size);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
+					       input,
+					       size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
 
-	return pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle, table);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
+					table);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
@@ -805,7 +1014,9 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
 
+	mutex_lock(&adev->pm.mutex);
 	*fan_mode = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 
 	return 0;
 }
@@ -814,44 +1025,68 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
 				 uint32_t speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_pwm)
 		return -EINVAL;
 
-	return pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle, speed);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
+					  speed);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
 				 uint32_t *speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_pwm)
 		return -EINVAL;
 
-	return pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle, speed);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
+					  speed);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
 				 uint32_t *speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_rpm)
 		return -EINVAL;
 
-	return pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle, speed);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
+					  speed);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
 				 uint32_t speed)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_rpm)
 		return -EINVAL;
 
-	return pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle, speed);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
+					  speed);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
@@ -862,7 +1097,10 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
 
-	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle, mode);
+	mutex_lock(&adev->pm.mutex);
+	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
+				       mode);
+	mutex_unlock(&adev->pm.mutex);
 
 	return 0;
 }
@@ -873,33 +1111,50 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 			       enum pp_power_type power_type)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_power_limit)
 		return -ENODATA;
 
-	return pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-					 limit,
-					 pp_limit_level,
-					 power_type);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+					limit,
+					pp_limit_level,
+					power_type);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
 			       uint32_t limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_power_limit)
 		return -EINVAL;
 
-	return pp_funcs->set_power_limit(adev->powerplay.pp_handle, limit);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
+					limit);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
 {
+	bool cclk_dpm_supported = false;
+
 	if (!is_support_sw_smu(adev))
 		return false;
 
-	return is_support_cclk_dpm(adev);
+	mutex_lock(&adev->pm.mutex);
+	cclk_dpm_supported = is_support_cclk_dpm(adev);
+	mutex_unlock(&adev->pm.mutex);
+
+	return (int)cclk_dpm_supported;
 }
 
 int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *adev,
@@ -910,8 +1165,10 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
 	if (!pp_funcs->debugfs_print_current_performance_level)
 		return -EOPNOTSUPP;
 
+	mutex_lock(&adev->pm.mutex);
 	pp_funcs->debugfs_print_current_performance_level(adev->powerplay.pp_handle,
 							  m);
+	mutex_unlock(&adev->pm.mutex);
 
 	return 0;
 }
@@ -921,13 +1178,18 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 				       size_t *size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_smu_prv_buf_details)
 		return -ENOSYS;
 
-	return pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
-						 addr,
-						 size);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
+						addr,
+						size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
@@ -948,19 +1210,27 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 			    size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_pp_table)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->set_pp_table(adev->powerplay.pp_handle,
-				      buf,
-				      size);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_pp_table(adev->powerplay.pp_handle,
+				     buf,
+				     size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
+	if (!is_support_sw_smu(adev))
+		return INT_MAX;
+
 	return smu->cpu_core_num;
 }
 
@@ -976,12 +1246,17 @@ int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
 					    const struct amd_pp_display_configuration *input)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->display_configuration_change)
 		return 0;
 
-	return pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
-						      input);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
+						     input);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
@@ -989,25 +1264,35 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
 				 struct amd_pp_clocks *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_clock_by_type)
 		return 0;
 
-	return pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
-					   type,
-					   clocks);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
+					  type,
+					  clocks);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
 						struct amd_pp_simple_clock_info *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_display_mode_validation_clocks)
 		return 0;
 
-	return pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
-							    clocks);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
+							   clocks);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
@@ -1015,13 +1300,18 @@ int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
 					      struct pp_clock_levels_with_latency *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_clock_by_type_with_latency)
 		return 0;
 
-	return pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
-							type,
-							clocks);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
+						       type,
+						       clocks);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
@@ -1029,49 +1319,69 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
 					      struct pp_clock_levels_with_voltage *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_clock_by_type_with_voltage)
 		return 0;
 
-	return pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
-							type,
-							clocks);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
+						       type,
+						       clocks);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
 					       void *clock_ranges)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_watermarks_for_clocks_ranges)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
-							  clock_ranges);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
+							 clock_ranges);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
 					     struct pp_display_clock_request *clock)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->display_clock_voltage_request)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
-						       clock);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
+						      clock);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
 				  struct amd_pp_clock_info *clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_current_clocks)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
-					    clocks);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
+					   clocks);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
@@ -1081,31 +1391,43 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
 	if (!pp_funcs->notify_smu_enable_pwe)
 		return;
 
+	mutex_lock(&adev->pm.mutex);
 	pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
 
 int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
 					uint32_t count)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_active_display_count)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
-						  count);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
+						 count);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
 					  uint32_t clock)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_min_deep_sleep_dcefclk)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
-						    clock);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
+						   clock);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
@@ -1116,8 +1438,10 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
 		return;
 
+	mutex_lock(&adev->pm.mutex);
 	pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
 					       clock);
+	mutex_unlock(&adev->pm.mutex);
 }
 
 void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
@@ -1128,32 +1452,44 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_fclk_by_freq)
 		return;
 
+	mutex_lock(&adev->pm.mutex);
 	pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
 					    clock);
+	mutex_unlock(&adev->pm.mutex);
 }
 
 int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
 						   bool disable_memory_clock_switch)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->display_disable_memory_clock_switch)
 		return 0;
 
-	return pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
-							     disable_memory_clock_switch);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
+							    disable_memory_clock_switch);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
 						struct pp_smu_nv_clock_table *max_clocks)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
-							  max_clocks);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
+							 max_clocks);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
@@ -1161,23 +1497,33 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_uclk_dpm_states)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
-					     clock_values_in_khz,
-					     num_states);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
+					    clock_values_in_khz,
+					    num_states);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
 
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_dpm_clock_table)
 		return -EOPNOTSUPP;
 
-	return pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
-					     clock_table);
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
+					    clock_table);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 72824ef61edd..b37662c4a413 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3040,21 +3040,18 @@ static int kv_dpm_sw_init(void *handle)
 		return 0;
 
 	INIT_WORK(&adev->pm.dpm.thermal.work, amdgpu_dpm_thermal_work_handler);
-	mutex_lock(&adev->pm.mutex);
 	ret = kv_dpm_init(adev);
 	if (ret)
 		goto dpm_failed;
 	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
-	mutex_unlock(&adev->pm.mutex);
 	DRM_INFO("amdgpu: dpm initialized\n");
 
 	return 0;
 
 dpm_failed:
 	kv_dpm_fini(adev);
-	mutex_unlock(&adev->pm.mutex);
 	DRM_ERROR("amdgpu: dpm initialization failed\n");
 	return ret;
 }
@@ -3065,9 +3062,7 @@ static int kv_dpm_sw_fini(void *handle)
 
 	flush_work(&adev->pm.dpm.thermal.work);
 
-	mutex_lock(&adev->pm.mutex);
 	kv_dpm_fini(adev);
-	mutex_unlock(&adev->pm.mutex);
 
 	return 0;
 }
@@ -3080,14 +3075,12 @@ static int kv_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
 	kv_dpm_setup_asic(adev);
 	ret = kv_dpm_enable(adev);
 	if (ret)
 		adev->pm.dpm_enabled = false;
 	else
 		adev->pm.dpm_enabled = true;
-	mutex_unlock(&adev->pm.mutex);
 	amdgpu_legacy_dpm_compute_clocks(adev);
 	return ret;
 }
@@ -3096,11 +3089,8 @@ static int kv_dpm_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
-		mutex_lock(&adev->pm.mutex);
+	if (adev->pm.dpm_enabled)
 		kv_dpm_disable(adev);
-		mutex_unlock(&adev->pm.mutex);
-	}
 
 	return 0;
 }
@@ -3110,12 +3100,10 @@ static int kv_dpm_suspend(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->pm.dpm_enabled) {
-		mutex_lock(&adev->pm.mutex);
 		/* disable dpm */
 		kv_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
-		mutex_unlock(&adev->pm.mutex);
 	}
 	return 0;
 }
@@ -3127,14 +3115,12 @@ static int kv_dpm_resume(void *handle)
 
 	if (adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
-		mutex_lock(&adev->pm.mutex);
 		kv_dpm_setup_asic(adev);
 		ret = kv_dpm_enable(adev);
 		if (ret)
 			adev->pm.dpm_enabled = false;
 		else
 			adev->pm.dpm_enabled = true;
-		mutex_unlock(&adev->pm.mutex);
 		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
 	}
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index b8dbddefb74e..51ab78f2aae2 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7786,21 +7786,18 @@ static int si_dpm_sw_init(void *handle)
 		return ret;
 
 	INIT_WORK(&adev->pm.dpm.thermal.work, amdgpu_dpm_thermal_work_handler);
-	mutex_lock(&adev->pm.mutex);
 	ret = si_dpm_init(adev);
 	if (ret)
 		goto dpm_failed;
 	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
-	mutex_unlock(&adev->pm.mutex);
 	DRM_INFO("amdgpu: dpm initialized\n");
 
 	return 0;
 
 dpm_failed:
 	si_dpm_fini(adev);
-	mutex_unlock(&adev->pm.mutex);
 	DRM_ERROR("amdgpu: dpm initialization failed\n");
 	return ret;
 }
@@ -7811,9 +7808,7 @@ static int si_dpm_sw_fini(void *handle)
 
 	flush_work(&adev->pm.dpm.thermal.work);
 
-	mutex_lock(&adev->pm.mutex);
 	si_dpm_fini(adev);
-	mutex_unlock(&adev->pm.mutex);
 
 	return 0;
 }
@@ -7827,14 +7822,12 @@ static int si_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
 	si_dpm_setup_asic(adev);
 	ret = si_dpm_enable(adev);
 	if (ret)
 		adev->pm.dpm_enabled = false;
 	else
 		adev->pm.dpm_enabled = true;
-	mutex_unlock(&adev->pm.mutex);
 	amdgpu_legacy_dpm_compute_clocks(adev);
 	return ret;
 }
@@ -7843,11 +7836,8 @@ static int si_dpm_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
-		mutex_lock(&adev->pm.mutex);
+	if (adev->pm.dpm_enabled)
 		si_dpm_disable(adev);
-		mutex_unlock(&adev->pm.mutex);
-	}
 
 	return 0;
 }
@@ -7857,12 +7847,10 @@ static int si_dpm_suspend(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->pm.dpm_enabled) {
-		mutex_lock(&adev->pm.mutex);
 		/* disable dpm */
 		si_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
-		mutex_unlock(&adev->pm.mutex);
 	}
 	return 0;
 }
@@ -7874,14 +7862,12 @@ static int si_dpm_resume(void *handle)
 
 	if (adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
-		mutex_lock(&adev->pm.mutex);
 		si_dpm_setup_asic(adev);
 		ret = si_dpm_enable(adev);
 		if (ret)
 			adev->pm.dpm_enabled = false;
 		else
 			adev->pm.dpm_enabled = true;
-		mutex_unlock(&adev->pm.mutex);
 		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
 	}
-- 
2.29.0

