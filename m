Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA808C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 04:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABC761352
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 04:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8ABC761352
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A096E372;
	Mon,  8 Nov 2021 04:47:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07536E372
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 04:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRpY2QJ2FEmf1ROjjl4cz8BjkzIa4jYm22kMtuieBcqJtwER3Vm5UfCNlM88smtl7c9RNEMEF9PEwApS+CUJY65HXMu3wlh+TUCbpJkN5gPsBMValyPueWy2JBlJB895FGybONB9SWw9EETgzdz8X/sglssS9XIyRVmBNv9w1awP3I6qUoQLkp0A8hMyvmHsRV7iAoH0SLgW0hJ48MTIT+3jZt8SqYjG19oHUy2a4f9gaa4/C67WlyD4geUDj6kvLWnEhxcQUDNYsmZyzHcZGb4shtqcagjD9jUyrqRU8492ypCLKgZ+eavgM18WhxbuL6EDuDkoV7ERNs2vc3kZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3XtViD6cf2JFktqXXmNGh9o2H4QOWoBnoGehAihf1c=;
 b=YB/CL3ZK9Dq15x58chBTS9rE6eSrhjzqkQP/xZjx44NoCqdv6QjsegIPsfiAh+TJkCUn8cRm0ucnljjFWv635R9L+SM4/cSMTiQhYe6pyq0tXCE2QvSFOdTLH+YvUoMRYiyjJRjEbdmr1eKry2k4dQjjZC9I1RYiA6A4F67wtOHXLIoAQ8MzYJS2RdeGe6lA6MfAcYH6/C43U3z7oiW3dZVAr4AwTHH754MlLj0mtZ8X0hGJw2GU+sA/3OaZCGBW2dQyAPXJAfhfCOP0rJMD+aePUfNOTFapYao1nTc31PUDlRlPhvXYuBenEoEOk1b6HTDdXS8EQVDhLdvEMSQmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3XtViD6cf2JFktqXXmNGh9o2H4QOWoBnoGehAihf1c=;
 b=bYzMIPCKeE3BlB8oTwg9vSdikr2H7nrRyQQzD/NGNsheJfQDWf64OqG7nAZTmW/bl1flNWR/hCwfUDKA84YXIZUoyL9NY7ttyY5MnumrmGp/0uZgmmUoHFYN0qP7xOyNXPZXUTafcHEb+EbXkxKEGvz9VCAJQl4wjJVSZOaHhwU=
Received: from DM6PR06CA0020.namprd06.prod.outlook.com (2603:10b6:5:120::33)
 by MN2PR12MB3216.namprd12.prod.outlook.com (2603:10b6:208:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.14; Mon, 8 Nov
 2021 04:47:42 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::1f) by DM6PR06CA0020.outlook.office365.com
 (2603:10b6:5:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 04:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 04:47:42 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 7 Nov 2021
 22:47:40 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Date: Mon, 8 Nov 2021 12:47:23 +0800
Message-ID: <20211108044723.54716-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28182c7e-d426-443a-93e7-08d9a272e635
X-MS-TrafficTypeDiagnostic: MN2PR12MB3216:
X-Microsoft-Antispam-PRVS: <MN2PR12MB321606EEE5DD2276DB3BFC16E4919@MN2PR12MB3216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emPg+1MkaGTqPPw59HehmFfhEhW69IfkcoBHruSr9BHPBecWmHwlr8knezzHD5zWqIeJvl3SktE3nKHwrOtJX91L5i9YDCKgohrsrBSo9goJg1LlpiSIu6eiqitE4eCF1sg3uP6KuQWb9XHyL3I23fzv8/ZAYJoe3r76sbMjlUcdo7guSLq5mM8tmh3cteLOfSZQArdvHSZOJp5SlW4lZA2kZj0mrnWWBm8zZUalMeaFjYRPfjQYXK7f5mAzh4rroVTlk5kAX6IMdpoCnx/sqksToB8B78ECfDtQuLVJg7OG3gckNStqJis5s7Cdi8vpeMohAMf2Ksw+AKo9Ly2Ce69eftVI8tD6DvsAT88bW2pYshW8c09c0K7BA58D7aA5VAncGh8Vktvy96jqRo8ac/laWttj6LbaTow+7XB/IfBa7ZvQtutpkeyWlZNctgP21ZQYQZMS6wWRXzfRv/ZUDAgV9UNSi3BAGcUZRXKGW/HMfkp3pBL+SCbCl29tGekzUoOI3xxEYSisaIcjGFRtcQBxVY+inJk306hnHFcZug/VWuIqxqSPvamMWXXfn7kI5qjM8WY2tb+p4rexuqK2x70dddJpH9LVGr/axU1wd3Iaik7+19SdmUIbnaKK/M9JHrjjQMdLA5UkXxzNnr3LKH1ev0LPUgcYUIVvz9Okxz7mPZEVWJyFtC+QJygLZEQn27C9SQLtto0k1VE0JYCTKhQ27ALoaz+5IFtGgVt8iiihhUFakKRa8CirGxc0xbc7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(356005)(2616005)(8676002)(86362001)(508600001)(83380400001)(316002)(81166007)(70206006)(36860700001)(44832011)(2906002)(36756003)(6916009)(54906003)(8936002)(70586007)(26005)(16526019)(1076003)(82310400003)(426003)(47076005)(186003)(4326008)(7696005)(336012)(6666004)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 04:47:42.1018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28182c7e-d426-443a-93e7-08d9a272e635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3216
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Borislav Petkov <bp@suse.de>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just bail out if the target IP block is already in the desired
powergate/ungate state. This can avoid some duplicate settings
which sometime may cause unexpected issues.

Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Borislav Petkov <bp@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  7 +++++++
 drivers/gpu/drm/amd/include/amd_shared.h         |  3 ++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 13 ++++++++++++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  3 +++
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c        |  3 +++
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c        |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  3 +++
 7 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..19fa21ad8a44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -767,9 +767,16 @@ enum amd_hw_ip_block_type {
 #define HW_ID_MAX		300
 #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
 
+enum amd_ip_powergate_state {
+	POWERGATE_STATE_INITIAL,
+	POWERGATE_STATE_GATE,
+	POWERGATE_STATE_UNGATE,
+};
+
 struct amd_powerplay {
 	void *pp_handle;
 	const struct amd_pm_funcs *pp_funcs;
+	atomic_t pg_state[AMD_IP_BLOCK_TYPE_NUM];
 };
 
 /* polaris10 kickers */
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f1a46d16f7ea..4b9e68a79f06 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -98,7 +98,8 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_ACP,
 	AMD_IP_BLOCK_TYPE_VCN,
 	AMD_IP_BLOCK_TYPE_MES,
-	AMD_IP_BLOCK_TYPE_JPEG
+	AMD_IP_BLOCK_TYPE_JPEG,
+	AMD_IP_BLOCK_TYPE_NUM,
 };
 
 enum amd_clockgating_state {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 03581d5b1836..a6b337b6f4a9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -927,6 +927,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 {
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum amd_ip_powergate_state pg_state =
+		gate ? POWERGATE_STATE_GATE : POWERGATE_STATE_UNGATE;
+
+	if (atomic_read(&adev->powerplay.pg_state[block_type]) == pg_state) {
+		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
+				block_type, gate ? "gate" : "ungate");
+		return 0;
+	}
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
@@ -976,9 +984,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		}
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
+	if (!ret)
+		atomic_set(&adev->powerplay.pg_state[block_type], pg_state);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index bba7479f6265..8d8a7cf615eb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -38,6 +38,7 @@ static const struct amd_pm_funcs pp_dpm_funcs;
 static int amd_powerplay_create(struct amdgpu_device *adev)
 {
 	struct pp_hwmgr *hwmgr;
+	int i;
 
 	if (adev == NULL)
 		return -EINVAL;
@@ -57,6 +58,8 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->display_config = &adev->pm.pm_display_cfg;
 	adev->powerplay.pp_handle = hwmgr;
 	adev->powerplay.pp_funcs = &pp_dpm_funcs;
+	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
+		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index bcae42cef374..f84f56552fd0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -2965,9 +2965,12 @@ static int kv_dpm_get_temp(void *handle)
 static int kv_dpm_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
 
 	adev->powerplay.pp_funcs = &kv_dpm_funcs;
 	adev->powerplay.pp_handle = adev;
+	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
+		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
 	kv_dpm_set_irq_funcs(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 81f82aa05ec2..f1eb22c9bb59 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -7916,9 +7916,12 @@ static int si_dpm_early_init(void *handle)
 {
 
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
 
 	adev->powerplay.pp_funcs = &si_dpm_funcs;
 	adev->powerplay.pp_handle = adev;
+	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
+		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
 	si_dpm_set_irq_funcs(adev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 01168b8955bf..fdc25bae8237 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -627,6 +627,7 @@ static int smu_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
+	int i;
 
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
@@ -639,6 +640,8 @@ static int smu_early_init(void *handle)
 
 	adev->powerplay.pp_handle = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
+	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
+		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
 
 	return smu_set_funcs(adev);
 }
-- 
2.29.0

