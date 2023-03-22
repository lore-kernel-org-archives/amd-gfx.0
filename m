Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92762C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 09:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2F010E8CE;
	Wed, 22 Mar 2023 09:16:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2111A10E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 09:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVpKufnuvgO9fXnVHZsd5y4Ne5dS0AoaFYW9f67fHrrC5T2dNVfwV/dtjhO2KLj7YukVhOD4561Z5zoxgrWkT1Qu3y4zqmXTPvtNUatGMRlDV17Ic2D40oXlwzQ1rOhKt4dL0TiQYuW0q+PGIxJz+n3mUGeEftLFMperD7+gLwQDkpoJD/MLoeMXRUtWnIj4mOzBMbxgIGHF20iYYkgBpvYl3f3LS3ZvxmxPk/Axp6ZJLZ0uWzhxo2R5VXlbEsgEGiPAPxIGk/2vIG1fn1nempmR1DDBA3eRwN5cQ44DG1VRbSffcaPMH+JFu5DyIeeqtFsQyi6hI/HhZQkRrcLuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmTiRXTGYuwXQxDQXEl94jM3xJEebqi9Vszh1wLPBjU=;
 b=E1eD7jKPZlHP/azNqNnJvdI6OEJZDmdfo2gLeLAB41D3TvUZa4r05f9AgtsLnmi+qpSlmeSeJfjnmeDPVZEhcK9F2pC0xdXXI21Cn28ATO42yIcqKGa0qX5CNi7O/HSuNgkbnjmeSqtaWiqhBWPzB0RvmkRvqHIR4/JstOnBgz8e8rxUJOsOKF0M9Yhvh6guApEYgj2knxxF7659RIRDPJ5cjWM9q12iq/5KDbpBtf3KmDpkBc0hbBgMYUaMJ91YnAM8f2dzD+4bNiNaKKAc3eMfrENO+L4MSZN5poN50KPdPVv/7kVT44Ssfhq4rBFUMPiF0LByA4Hg7oPKviABtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmTiRXTGYuwXQxDQXEl94jM3xJEebqi9Vszh1wLPBjU=;
 b=X4c/uXJapf/1cNJBOqS4XvWLeb9m+KFaI64A4ZVU+fdNUa38Guu5uYVUdJCuEvR7W+xa/UpY6PMl4Ymdn55KHRwGSjeEqY5oCO74rbWrYXbWvKcZVmSzdzoBt3GKbxDFbe77nKvktlKn3fLafnBXNpgmO+azInCosMUowtUEqsA=
Received: from MW4PR03CA0107.namprd03.prod.outlook.com (2603:10b6:303:b7::22)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 09:16:23 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::da) by MW4PR03CA0107.outlook.office365.com
 (2603:10b6:303:b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 09:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 09:16:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 04:16:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 02:16:21 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 04:16:19 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to pmfw
Date: Wed, 22 Mar 2023 17:16:06 +0800
Message-ID: <20230322091607.1609145-3-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322091607.1609145-1-WenYou.Yang@amd.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f19e68-e8b0-4734-f12e-08db2ab61b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7b437QXxnN9zbJ8rRglzZp2mKpX4nbX2TNOIR4iKsqe4Mk9/5H3XdIqxV4WqRTbxYUP91x1cIiebTa9sNIOgaBP49CW7tHiaJzRxEYc17ZOmQWKKdUI0BKhFIhMX82ApkRON2akIQaqPJTPKfE0l/md5zp6ypTUJnYi7Wa2yAGjqNviziGNcxzdHhS9EYj2ODf0ODc9sisIk2H5j4PVWscbq5iHK0XVuv+SKoaJcnI4ycIt1/+GHTSQympSePgp2ySKELmfpnsMqPwXXHynmce2AwOBdba87QYA2MHIamKKOFR2Qnjwv7gl2oiSPEkPUPvYcGP8qfAPU8nszG03pOeEN/AnYyIuGaIZ0p8/QViochGkv1htn8JK3avzaPcRrZUv52igFm5AC3WPcMAmss2FOQ0tpmNzLFHcfwGxg1XgY+QGWdMTPHbeEtLCgb4RF01ryaukdLl9P150cLeppcy/oFfsH77DYb7QyhW2N/sFoEOENzz+ra3F/oRBC2TshHp1x6w6fDVm8yNWYh2m2b2TEHi2KAKqi6NSULnRD0r5d80ocvP7BWw0tilQdHab1vFKHhowuIrtKhSiZOFF7e4r1tIz1nE2MO0mUfjlisacvBx5xK5nWGKnx8M6Nf83zT4gKGWup9h34zBfSK6Zc7Hdp3wWQArS0sKpjGTk7MGowCVPzBa/ad7zwx+e42q1LGtVRe26NDTTdHfq4PJZVcJez2+UZm3mAm9fWTWGvcoE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(7696005)(86362001)(40460700003)(36756003)(82310400005)(40480700001)(70586007)(4326008)(478600001)(6636002)(8676002)(5660300002)(83380400001)(110136005)(2616005)(186003)(1076003)(26005)(70206006)(426003)(6666004)(47076005)(316002)(336012)(54906003)(356005)(36860700001)(2906002)(8936002)(81166007)(82740400003)(41300700001)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:16:22.8004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f19e68-e8b0-4734-f12e-08db2ab61b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU SMT status change in the fly, sent the SMT-enable
message to pmfw to notify it that the SMT status changed.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b5d64749990e..5cd85a9d149d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -22,6 +22,7 @@
 
 #define SWSMU_CODE_LAYER_L1
 
+#include <linux/cpu.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
 
@@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
 
+static int smt_notifier_callback(struct notifier_block *nb, unsigned long action, void *data);
+
+extern struct raw_notifier_head smt_notifier_head;
+
+static struct notifier_block smt_notifier = {
+	.notifier_call = smt_notifier_callback,
+};
+
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
 {
@@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	return 0;
 }
 
+static struct smu_context *current_smu;
+
 static int smu_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -645,6 +656,7 @@ static int smu_early_init(void *handle)
 	mutex_init(&smu->message_lock);
 
 	adev->powerplay.pp_handle = smu;
+	current_smu = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
 
 	r = smu_set_funcs(adev);
@@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
 	if (!smu->ppt_funcs->get_fan_control_mode)
 		smu->adev->pm.no_fan = true;
 
+	raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
+
 	return 0;
 }
 
@@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
 
 	smu_fini_microcode(smu);
 
+	raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier);
+
 	return 0;
 }
 
@@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
 
 	return ret;
 }
+
+static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	int ret = -EINVAL;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
+		ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
+
+	return ret;
+}
+
+static int smt_notifier_callback(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct smu_context *smu = current_smu;
+	int ret = NOTIFY_OK;
+
+	ret = (action == SMT_ENABLED) ?
+				smu_set_cpu_smt_enable(smu, true) :
+				smu_set_cpu_smt_enable(smu, false);
+	if (ret)
+		ret = NOTIFY_BAD;
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 09469c750a96..7c6594bba796 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1354,6 +1354,11 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @set_cpu_smt_enable: Set the CPU SMT status
+	 */
+	int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
 };
 
 typedef enum {
-- 
2.39.2

