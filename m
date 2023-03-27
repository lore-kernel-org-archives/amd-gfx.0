Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046ADC7619A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 07:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5768A10E260;
	Mon, 27 Mar 2023 07:25:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422E010E24C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 07:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8h/EZ046acVtmxfC7ebbSnlp+5yVCZrnqxEE1GHkpqc0S7eGMOVCHqiAcI9ccVP03PjVG9Mz5aHur/Kja3QtKq6yKosJILfXrRDFYeQMvOuYxYvpF711mBDeZ6LAe7q6Pd2u0+/tjf8y3q/DUnj9X0QMOSRe+hKqc5G1iHGan81vYG2f5BUn8ywqCYmnqUveY1dBhhEwc/fsNbmCV29e3HqDr/I3Q7mTOvVRMrYyUthMFo7pC+O02sjMZ7dp8im3El6C8E/7iATTFKzb6eGeluyXZHNVd2OAfKyx3LOYw34xIOAAUhtumgOnZ3PLjfFxJLGV4lMOR+sQ0AVXfmkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idxcYFmdYayWeZvSrTaJl32yDeVcgz7p0TG6qVexiHU=;
 b=IMc4tlESl87FTPxklnBeYzdCQQEoSq8ia8zqolhd6UoxTuISL/MBZjaOf3ZNn34+2gEyRuDHNtYXJjpt3zkxdFHWSmrejCxGvf43i5/ecadpgww2ixwi04YeX6xMcQSwLV5f6+d8hIBVf9h9nrBgXthmrXearKcEbsHgUEU2OljAJXLtS88jQdfkkLK5I56ps3U6cjNrGGtrWDGKQq+r/4K0lLaeTsXt2ydxxaVvGUN8oSwY8gOxTODrAUHjxddfBls4hl4+aEorqHVGMo2BZSUAZTz4V7kyuzd1iJMGTXUVE3fZyz5cw+l72r5MBSwpao/afOTEISJ8uSEoqCNvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idxcYFmdYayWeZvSrTaJl32yDeVcgz7p0TG6qVexiHU=;
 b=AD03XsIQQooK+PiwBPM8AYGO+Fm4U/xDHWAZ6jaYCbZ7v2Lrz//325Nyn4NOmazoC3q1nsH+nYMCP4i7+rbeTSduBP4fQjo14jcUzL8PzHbkfHGHlWkYCSP2OXEUlUOI1NeCvOKvtXvxTsnFNpn6ooA0rd4qeHGlxkmixBYX+rQ=
Received: from DM5PR07CA0082.namprd07.prod.outlook.com (2603:10b6:4:ad::47) by
 PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 07:25:04 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::a1) by DM5PR07CA0082.outlook.office365.com
 (2603:10b6:4:ad::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 07:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Mon, 27 Mar 2023 07:25:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 02:25:02 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 27 Mar 2023 02:25:00 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v2 2/3] drm/amd/pm: send the SMT enable message to pmfw
Date: Mon, 27 Mar 2023 15:24:36 +0800
Message-ID: <20230327072437.580766-3-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327072437.580766-1-WenYou.Yang@amd.com>
References: <20230327072437.580766-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 4823c2cf-12d3-482a-313e-08db2e946267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iw076rd9Vot5Kd71EN2BUcqIq1MO8z1fPcdu6MoErxjx62nieiyk5+5rmjdAHDvCSHH0xcIhdplb06GAM2vdNR5zR0nmVeKjI5lkFljbAczW1smkj7VWT/FuYJcmndIuEp+6G1s5dZuR8g0ADlx4k6BSlBvJxivtqToMDrvSsxG/l9qNAHVeU/zumZHLymA8St9EeiknNLLQuIyCh6jauhaFtcn7aVq4l1bAIalrKVpcR87IPuRXa6u8t1osGBKkL4pCauJGkLxdKQo7cPbI0+C0gSfFKXx+voE0oM5PLMLD4R6W01o1mP0vEYS1uN7RDRk8nM/GmkzAHRi0riN2vfytf+Z4EXa0l9vbVmN3+Z6KejSuFJbvncwUetIO68XJOsUeTwt0SyUKerWZAZnbiRhmtZ97eEDGwHGabtRZfHesK/q6wCLwMUwIj+x3HeFBRVRrKxk+owEC8kWfeko9aXtCF3wWy+BlnlC3Pcv1zJ0C+Ae5bqFZ/sBMmxtki6nzPJ+zeF/uSp1vVB5FzONqNT2Rx2J7oKk+/sYEke2fAn2UTg8uzQGZvQIo8yiV8zWHy3sxDhaKG1+vBgJJFx18DMKHTxFUd/b3hZFLl19QPa2IAy+0lZOOemqqmv35ou9HIcn08JAbDge42RRn5t0qwtO+agv0+u3KdA8fTNUhMGgvFq655GMqak/yO37GPwibkNveGM0sMNjSDqdcPxfqKqURHx0ktHx0su1LtcHI8jQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(336012)(81166007)(26005)(1076003)(478600001)(186003)(40460700003)(426003)(7696005)(36756003)(316002)(83380400001)(110136005)(47076005)(8936002)(86362001)(356005)(82740400003)(36860700001)(4326008)(40480700001)(2906002)(54906003)(5660300002)(15650500001)(41300700001)(70206006)(2616005)(6666004)(6636002)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:25:04.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4823c2cf-12d3-482a-313e-08db2e946267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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
 Wenyou Yang <WenYou.Yang@amd.com>, gpiccoli@igalia.com, kunliu13@amd.com,
 richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU SMT status is changed in the fly, sent the SMT enable
message to pmfw to notify it that the SMT status changed.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b5d64749990e..eb4c49f38292 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -22,6 +22,7 @@
 
 #define SWSMU_CODE_LAYER_L1
 
+#include <linux/cpu.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
 
@@ -54,6 +55,8 @@
 #undef pr_info
 #undef pr_debug
 
+extern struct raw_notifier_head smt_notifier_head;
+
 static const struct amd_pm_funcs swsmu_pm_funcs;
 static int smu_force_smuclk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
@@ -69,6 +72,9 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
 
+static int smt_notifier_callback(struct notifier_block *nb,
+				 unsigned long action, void *data);
+
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
 {
@@ -647,6 +653,8 @@ static int smu_early_init(void *handle)
 	adev->powerplay.pp_handle = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
 
+	smu->nb.notifier_call = smt_notifier_callback;
+
 	r = smu_set_funcs(adev);
 	if (r)
 		return r;
@@ -1105,6 +1113,8 @@ static int smu_sw_init(void *handle)
 	if (!smu->ppt_funcs->get_fan_control_mode)
 		smu->adev->pm.no_fan = true;
 
+	raw_notifier_chain_register(&smt_notifier_head, &smu->nb);
+
 	return 0;
 }
 
@@ -1122,6 +1132,9 @@ static int smu_sw_fini(void *handle)
 
 	smu_fini_microcode(smu);
 
+	if (smu->nb.notifier_call != NULL)
+		raw_notifier_chain_unregister(&smt_notifier_head, &smu->nb);
+
 	return 0;
 }
 
@@ -3241,3 +3254,29 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
 
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
+	struct smu_context *smu = container_of(nb, struct smu_context, nb);
+	int ret;
+
+	smu = container_of(nb, struct smu_context, nb);
+
+	ret = smu_set_cpu_smt_enable(smu, action == SMT_ENABLED);
+
+	dev_dbg(smu->adev->dev, "failed to set cclk_pd_limit for SMT %sabled: %d\n",
+		action == SMT_ENABLED ?	"en" : "dis", ret);
+
+	return ret ? NOTIFY_BAD : NOTIFY_OK;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 09469c750a96..4d51ac5ec8ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -566,6 +566,8 @@ struct smu_context
 
 	struct firmware pptable_firmware;
 
+	struct notifier_block nb;
+
 	u32 param_reg;
 	u32 msg_reg;
 	u32 resp_reg;
@@ -1354,6 +1356,11 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @set_cpu_smt_enable: Set the CPU SMT status.
+	 */
+	int (*set_cpu_smt_enable)(struct smu_context *smu, bool smt_enable);
 };
 
 typedef enum {
-- 
2.39.2

