Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E6C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7D220848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PaKBfgzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7D220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131176E9B9;
	Fri, 16 Oct 2020 09:21:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F076E9B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg0AsUC6ivGjxdMRqNsn+w01imX774gtRUbpnauYRPLtzPhyoLKZIOKaDcrJ98Alt63s5UH0pbO5kymZZw8+wAKBseFtwhxXoy74zXE7bQPxWW55h6KmaUwMs4zFJf6RgeYaETbepHrInITkQOn73PG/1KJ/SRMj6T8FBVWfULnxmutTDSknhYYij+nLHfs/8BFOqL1AKWVGGf0BzzYR+oudIamJGYGC8kmnJdS73O/UHSN5cMtbiNrXmxIVXxD+3SqEYpxQcOFo8Ndt0HjAOVbvGtFPu6WnkbQrGE2N0UQRpH7LurmpZ8HumxYKJf7Pla3eB+wAQuei1XYyhCw+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxAw7eOFIrcScmoVIlzaMWVVq4BEjbsXJeRYwfdhJ0s=;
 b=IGyy69vaSYg8p2xOTLWQWqkX+5owtRwhjDHJ3YmKAHQ0orCTujJjFYbpEfrUfNVSOdQlPFsJU5iWTCLnlYOLAbYymIcz57QE/WQer618cLyhGlzrq5fAc4ZBBh0hpkhW8+cWjeBRATSqwLcFbmLg9P9TRHelVC7hnqHp9+UDx9GnzEEV2Efw177HL46iW5UXF9wVLBSraC2GP7tNJ8s1mthVVFHVRjcVPxlZWX53puYwkIRDM/xCjbHNp7fTVxGIyvaL5cHVmFmxp6E/Tew+14536L8nNBoqYq46TbVngaMIcpmllpE8Jf8s0nyDyoN7GBBAEk0h0GwGZFD0U6d6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxAw7eOFIrcScmoVIlzaMWVVq4BEjbsXJeRYwfdhJ0s=;
 b=PaKBfgzk3I8bq3sYEHDKNbGbHKpZ2zEgxQZ8n+l2QIQJL7IVr/+fndbOE7J8hrGObCCDkfQGTNFsxlmhfsGDbxbsQCEWLCKbvQWad277Ty+4eVCKXOeFxrN9V/qZrQvWMOLzVlZTtx1kOL4cPoBo56aN4HIGutkUIISSFwgVulg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3128.namprd12.prod.outlook.com (2603:10b6:a03:dd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 09:21:56 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219%5]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 09:21:56 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: add amdgpu_gfx_state_change_set() set gfx
 power change entry
Date: Fri, 16 Oct 2020 17:21:41 +0800
Message-Id: <1602840103-21053-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
References: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 09:21:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1afce477-c378-491c-c15d-08d871b4ed38
X-MS-TrafficTypeDiagnostic: BYAPR12MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31285AE56498C870557C44E8FB030@BYAPR12MB3128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKSeH5B1cJJpw4zYGrd96+vC9I63pPWmr1FANGWjfC5PWWxnlfGB83gjsRJ/ACz6lNsevequuSWG3ZaXsLHNmTVsH4KYCE7WTtMOlFAjbvUovKS2jozwY0/iEVzyL4oCB6nRZ07FtZo2AsLgBq1vg68pEx0CvQzMmT+STaGU93qL48Xq9mwygnXJMMaBtAM0JP4/YPw03A8QF7sKZFW4BtZwWyAanW0uZPh1RNz3oolEYifFxbGxfB6pfvlxFdzXwNcx0uq1KvAHDWXmRLLIXxHraqPfWQ9cxcObppPQfoKkI0tqXdHsKpLU9Xta/To9QOoH/DxebOLpPMHmVL637HWAXdTgOBRtO6tTWlHBf1cE9WEUJ5Kfvid34J2NtZth
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(86362001)(478600001)(2616005)(26005)(5660300002)(186003)(16526019)(956004)(52116002)(34490700002)(7696005)(6486002)(4326008)(66556008)(83380400001)(8676002)(8936002)(6916009)(36756003)(66946007)(66476007)(316002)(19627235002)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: n1HjxcuKo2wIVYbt7rhA0Zl8AU1ReLISPKxASJHLFerkE8NbvvS/IpRFhKyVfW0+OjWOJrabymEkl/g14k7ujSCGxXAh4NUylGs11UuB7Rw8GpZ+cshUO43VZjDUhPkgvAmCTR18B2cdUTFU/KhK5W6t484EkcK1tSxAil5Me4nQUD8NYi5Ja/FplSQS6UTnDvXSab7n8xGcDO6hJE2MjAg2nPtyzxBPWbX2WhY8G+XUztNaHS6zwRSv7BfDDShJXRDqymKEsqSPCSpskdctdmPaxuZdC2m39aR0g5B5W29MCOkchqQiT4j13OYFyVREdWXj7Q9X9Sy6OzsxPV6Uaot/hqRmG6lWlLfCWuKrvbIjEWGrTgZH3kl/yRFUTJNCkgpk19QSiOW0nPpRjW3QXRKWs3IaJUlixh9goulf7domPCcNaRRTwvRMoyGVm04L+k+87Ww8Kaw582b9FNBC/sg/UFyvdf7lan1E10Jm2eSw+A+kcgQOobSZxYL8tIcbktbM4GlU2ddmIK/IQlX3RTsFyIocGkABw3d7w47QLZ/aySKzgPaTWE2+Hn97YfrOCe/HRHPhtfWrLvIcMgs+ucS2q2TY3Mr/eKhgdz2LjVy/2glkP2ZaSs0jvslb6exdgvdvBN3MzWOwz2CIUId+WA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afce477-c378-491c-c15d-08d871b4ed38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 09:21:56.7723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjR02MRr2IWnrZtt7ilxXApLY2EgNenGhaMOVNZIfeZugboS6pR1ZOwPVy5tF+2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The new amdgpu_gfx_state_change_set() funtion can support set GFX power
change status to D0/D3.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c           | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h           |  7 +++++++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c     | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  9 +++++++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h         |  1 +
 drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h      |  3 ++-
 7 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d612033..e1d6c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -789,3 +789,23 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 failed_kiq_write:
 	pr_err("failed to write reg:%x\n", reg);
 }
+
+/* amdgpu_gfx_state_change_set - Handle gfx power state change set
+ * @adev: amdgpu_device pointer
+ * @state: gfx power state(1 -eGpuChangeState_D0Entry and 2 -eGpuChangeState_D3Entry)
+ *
+ */
+
+void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
+{
+
+	mutex_lock(&adev->pm.mutex);
+
+	if (adev->powerplay.pp_funcs &&
+	    adev->powerplay.pp_funcs->gfx_state_change_set)
+			((adev)->powerplay.pp_funcs->gfx_state_change_set(
+					(adev)->powerplay.pp_handle, state));
+
+	mutex_unlock(&adev->pm.mutex);
+
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d43c116..73942b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -47,6 +47,12 @@ enum gfx_pipe_priority {
 	AMDGPU_GFX_PIPE_PRIO_MAX
 };
 
+/* Argument for PPSMC_MSG_GpuChangeState */
+enum gfx_change_state {
+	GpuChangeState_D0Entry = 1,
+	GpuChangeState_D3Entry,
+};
+
 #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
 #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
 
@@ -387,4 +393,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state);
 #endif
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a7f92d0..e7b69dd 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -284,6 +284,7 @@ struct amd_pm_funcs {
 	int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input, uint32_t size);
 	int (*set_mp1_state)(void *handle, enum pp_mp1_state mp1_state);
 	int (*smu_i2c_bus_access)(void *handle, bool acquire);
+	int (*gfx_state_change_set)(void *handle, uint32_t state);
 /* export to DC */
 	u32 (*get_sclk)(void *handle, bool low);
 	u32 (*get_mclk)(void *handle, bool low);
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 7e6dcdf..4f319be 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1321,6 +1321,25 @@ static int pp_set_powergating_by_smu(void *handle,
 	return ret;
 }
 
+static int pp_gfx_state_change_set(void *handle, uint32_t state)
+{
+	struct pp_hwmgr *hwmgr = handle;
+
+	if (!hwmgr || !hwmgr->pm_en)
+		return -EINVAL;
+
+	if (hwmgr->hwmgr_func->gfx_state_change == NULL) {
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&hwmgr->smu_lock);
+	hwmgr->hwmgr_func->gfx_state_change(hwmgr, state);
+	mutex_unlock(&hwmgr->smu_lock);
+
+	return 0;
+}
+
 static int pp_notify_smu_enable_pwe(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
@@ -1625,6 +1644,7 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.switch_power_profile = pp_dpm_switch_power_profile,
 	.set_clockgating_by_smu = pp_set_clockgating_by_smu,
 	.set_powergating_by_smu = pp_set_powergating_by_smu,
+	.gfx_state_change_set = pp_gfx_state_change_set,
 	.get_power_profile_mode = pp_get_power_profile_mode,
 	.set_power_profile_mode = pp_set_power_profile_mode,
 	.odn_edit_dpm_table = pp_odn_edit_dpm_table,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index c9cfe90..3f354da 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -319,6 +319,14 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)
 	return false;
 }
 
+static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GpuChangeState, state, NULL);
+
+	return 0;
+}
+
 static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -1394,6 +1402,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.get_power_profile_mode = smu10_get_power_profile_mode,
 	.set_power_profile_mode = smu10_set_power_profile_mode,
 	.asic_reset = smu10_asic_reset,
+	.gfx_state_change = smu10_gfx_state_change,
 };
 
 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index 15ed6cb..2c9580b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -359,6 +359,7 @@ struct pp_hwmgr_func {
 	int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
 	int (*disable_power_features_for_compute_performance)(struct pp_hwmgr *hwmgr,
 					bool disable);
+	int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
 };
 
 struct pp_table_func {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
index df4677d..4c7e08b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
@@ -83,7 +83,8 @@
 #define PPSMC_MSG_SetSoftMaxVcn                 0x34
 #define PPSMC_MSG_PowerGateMmHub                0x35
 #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
-#define PPSMC_Message_Count                     0x37
+#define PPSMC_MSG_GpuChangeState                0x37
+#define PPSMC_Message_Count                     0x42
 
 typedef uint16_t PPSMC_Result;
 typedef int      PPSMC_Msg;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
