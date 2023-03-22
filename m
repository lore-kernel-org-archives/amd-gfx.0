Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0314C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 05:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3254C10E0A2;
	Wed, 22 Mar 2023 05:48:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C23C10E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 05:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eObu17h7h8gxoWUse9LkRc4kwpqjm8On5gnE3+B+9bPUFFMaUKjtzN/BtiBaakW/G9sTx6AMSQl0PohzyF9eYAG5NWQK4s5Z+ivkW+tAofSs4nYOMlgP2Asr+H+jXxT80mcc/InhDUAeKBt8SiVqz9lWKVmkYof0TAUbLJGNgsBXykJ3qekJCtTE0JMCtrUXIIqafWgntsT0IMcUd3DblDEa9s38XC+k7wre3wqvg8a6Yl6qZM/0JwREy6ZbU1Q4cm+ACy2teggV66xrTmOm12jtgdLHYIDLQ9gv2xKHAXG5tZ8tb9KbVcgp2WYvifzUSUsg/CCtb4WakITElT6Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmTiRXTGYuwXQxDQXEl94jM3xJEebqi9Vszh1wLPBjU=;
 b=dfOXlWKgE70u/8QpdUX96716OOyCFafxcJhDsPnxwyb4PvYz0mspZmlwLeAiBHuOjAcvUUcaKKVUw0G57T5nzkUhLtJkQfJ75yJBfLG6XIhXsJzWulPUTaYU4qycYyp6laTP8DF/8J75TkvKA0e+SrCjrppcrZt2v+T5E8rU9ZQ8AsGmQRZMlAPpleFH6HkDH/NJQAVV4HRYEY/ui2hMzPgpapSmco2GZ6Qh6B3DZgxtMzG/88SyrVmXKv2vUFi4lDj7kYRA9go3Ej6t5L9QKR/hsYYtnsOCck8aZrvZhm0Pfl8M8lYhrmO2WTjJtoWI+RsJdgZ8kUsR6oLR/qBw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmTiRXTGYuwXQxDQXEl94jM3xJEebqi9Vszh1wLPBjU=;
 b=Vm0o8SegylDWDypIf0pV4pdPxL7SbKKTrk6WTV7k5A2/JnwZjuSJyGIvU1y5WqFibW/bdL4d/ZKaJBO7lof+0GcjZgIMgGYoHAfRgvqrBIyZqbnq2SUfygqqsw6k/dIxHdE80oCeER42lz+uYua+qWBSge2hwRk1muHhsAc8G5g=
Received: from DS7PR03CA0351.namprd03.prod.outlook.com (2603:10b6:8:55::16) by
 PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 05:48:17 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::f2) by DS7PR03CA0351.outlook.office365.com
 (2603:10b6:8:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 05:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 05:48:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 00:48:16 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 00:48:14 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to pmfw
Date: Wed, 22 Mar 2023 13:48:07 +0800
Message-ID: <20230322054808.1555230-3-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322054808.1555230-1-WenYou.Yang@amd.com>
References: <20230322054808.1555230-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: ae82927e-8ea8-48b5-751e-08db2a9908fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpo41s13UX/opd0Ru60j2l+p/FtLYgWScSWt1qTxZSxVT/ja0P8cSGXMtukd4krC9S2y8fkInTBQs4RtYSwDyUWcTtuLsS8hDDl7JlatEQ3V/H0ugW4CD1lNMpVkE/g2JK1YIzQjjp8uUuqjE0fz8fgSOYtMB5grP9ropc8a8sgPzF/jMjWjY6btW5Asw9LnheqifhXgmfQf1g11JmhxsBMibRPA5dRA/loDT2iFgni6Im+IAETnJ049Uey0hdXpsfSzcq+k2degBGwK8193AHxN+adp931PreIIOB4SXOQ76ksdK1GwPz+ocHSmbTVvpS9hZI64WF2hTQIwMCi09TD8N4loX9xZoBXwdJoxntnXfI34i4iXunusXliuiBqDd/BBYEizT6EVK2pkmi8bZnD0ENNKSxqQwkpBJ5T4K7TogThsMss0MYAZM5D7VSbnRxbQ//NhjQYJMjFMXpz45O/IitPegwBjICejs2YrSzQtcHBir8/+U0hmzU+qIkGu4+2sYDTX/J4SY6yDa83VvDkHya0Q2J38ZM4sr+xh2StHevftlNfSad+djASUnkfBGH5iptR406cmk9XtNzHQK86GqrrxMhY/lIR3syjx4ew3vBJ9inYxDgSjshYsrMghwQBu2a6ES9fvkkceiiRit5/IqUx5COmTqymtR57qUe1EUuW1/+q5p4SqbRewu9OHnOzTKKyYhGQzjjIWKx7CXfnkUI+JvumajU+sbYSt1Ug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(316002)(2616005)(6636002)(47076005)(426003)(83380400001)(336012)(356005)(70206006)(40460700003)(86362001)(40480700001)(70586007)(4326008)(81166007)(36756003)(41300700001)(8676002)(5660300002)(15650500001)(2906002)(82740400003)(8936002)(54906003)(7696005)(1076003)(186003)(110136005)(26005)(36860700001)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:48:17.1270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae82927e-8ea8-48b5-751e-08db2a9908fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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
Cc: Wenyou Yang <WenYou.Yang@amd.com>, ying.li@amd.com, kunliu13@amd.com,
 amd-gfx@lists.freedesktop.org, richardqi.liang@amd.com
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

