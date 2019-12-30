Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80DC2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E3B2071E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXFN9gnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E3B2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68507892D8;
	Mon, 30 Dec 2019 10:50:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE54892D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 10:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOxjYGpPdQaytiQoDzXEZBqu7sYOvpEsyRLbXFY/MD3/KacnB/7CIYFZwLRsCuzXc5AqDyUwkW6r8lqONY1hrwhzEhDfkO7JVhEa8cJWKn7BE4dX/qkkGViP+v4oNfqQToYTE/RZp+GBaCdFCD0W0TZbpud0nKxzmlcpDJ6ThjXzajrVKE11pjkvF3AYF/isgS/6JZBpRfp/VoRGRv9Axs/QFFDZSrKM8n/IKOCPDBXnxrYPk8xnlQAhWKiMqYaRJiKQIKGtJGwTyE+MUxaVImNJzSSN+xncripQC/Db7kKUgWsf8L6LM31K0qL35Yldv4vVCVonKXkoT/B6xp8qNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fbM11SRuD7sgEU4CbqgPIj9wvMgCuLZYAQQ89epqgY=;
 b=ORZJOysNfAsWA8TmNEnZ/VsowZpyH2VhvTy9z8GWIXvleeNG1XrMbgwE8oPgiNudnclO2ORdHP+OlkqXFW6vroGlI7OyQxdp6jPGTFt3hhtxt01v8yQNqqUcgwtiiXF0KadONMv63W9BKD8vyDWoBq0wgKCTqyTev1blEcJUVj6CMvtoYDCfeMDWGpOAsfoDp/ccHZUs3KSgUk1A2r6FppDt0qC8Fb/yCnRnJWm9vZgEu7qZkRYEiObghBr3uhkwLhY+o98OjRjxKliFYpTM4SlLrWkdCQygtsuJm6pkFZ90F1T6tz2kxEAyolFOYWeP6QfNksdZviioIRR6Rpw8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fbM11SRuD7sgEU4CbqgPIj9wvMgCuLZYAQQ89epqgY=;
 b=KXFN9gnxSS1GK2wrpW11ju1D41Rz8IAk83Ivx/Z9FgXiGW/kt+MvSXrtdS6w6uwJQBnD+BNNgMMh1T14uHc0+xTj8kkS8KW8WUG6PhZzFqRW8/M9xWcrDt7Q1p66wpsSivODhsKRbXr2FybQrZa6C4mYMlReuQoL5agj2WFlCW4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3997.namprd12.prod.outlook.com (10.255.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 10:49:58 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 10:49:58 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: using fixed vram address for table
 transferring
Date: Mon, 30 Dec 2019 18:49:30 +0800
Message-Id: <20191230104931.28260-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 10:49:56 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf81ea29-b514-4fd2-89d4-08d78d160317
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:|MN2PR12MB3997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3997BAB014964C30F90CA98DE4270@MN2PR12MB3997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0267E514F9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(8676002)(8936002)(66946007)(81166006)(4326008)(66556008)(52116002)(7696005)(81156014)(66476007)(26005)(2906002)(6486002)(2616005)(6666004)(19627235002)(30864003)(6916009)(86362001)(186003)(478600001)(1076003)(316002)(16526019)(5660300002)(44832011)(36756003)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3997;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s47S/J24uvmEGg2UUiKdF72ib2wIwOSLSOUaQKQx6hTqwmuBGVAflDFjRymHITr8vWcbM4SVj13PTPcTCt3oncUd52ZYbuCpRzUl1DxSIpcJnxRKCE9FeXm2cDtQnk78Ilrb3alSJAZ2J+DhxulW72Ez5+LlmxLYNjgviXB7HJB8wEd+BGCnWtGu89bxuxtdRQpVBwH+Ao3ecxysbXmNk9pmPzmoUybBYI9EDxD3gBSBJVRm5eM2ROOCsYq6LIYeUJ78tU7SREaoXP0OIm1VtrQlACxCrfHjxTCjXMCUvQLd1+C7G2awzS9EKManbFl1VJx2jCTGBld4PmRrnyDfe/hjq2XzBf0mD87IPyjGSok9UcsnGYFTrYW4neT6zp5/WPEBnrK5HUDtdDSEaSzbm9PTsCosoQm9Yegem4OtlsTOorEBhfDayuZruqelsdek
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf81ea29-b514-4fd2-89d4-08d78d160317
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2019 10:49:57.9963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYPXyg6mq2lV9YFY+gKw9xEy6PotTolFjgVdMPgHsBQFXjGkLQ5bG/Xvf68Dk53+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By this, we can avoid to pass in the vram address on every table
transferring.

Change-Id: Ia8a3dbe923bc562286ab102a5830392a95dcf28c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 42 ++++++++++++-------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++++++
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 18 ++++++++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
 11 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4a7fb6b15635..c3cb1b8f43b5 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -490,26 +490,19 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
-	struct smu_table *table = NULL;
-	int ret = 0;
+	struct smu_table *table = smu_table->driver_table;
 	int table_id = smu_table_get_index(smu, table_index);
+	uint32_t table_size;
+	int ret = 0;
 
 	if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
 		return -EINVAL;
 
-	table = &smu_table->tables[table_index];
+	table_size = smu_table->tables[table_index].size;
 
 	if (drv2smu)
-		memcpy(table->cpu_addr, table_data, table->size);
+		memcpy(table->cpu_addr, table_data, table_size);
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetDriverDramAddrHigh,
-					  upper_32_bits(table->mc_address));
-	if (ret)
-		return ret;
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetDriverDramAddrLow,
-					  lower_32_bits(table->mc_address));
-	if (ret)
-		return ret;
 	ret = smu_send_smc_msg_with_param(smu, drv2smu ?
 					  SMU_MSG_TransferTableDram2Smu :
 					  SMU_MSG_TransferTableSmu2Dram,
@@ -521,7 +514,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	adev->nbio.funcs->hdp_flush(adev, NULL);
 
 	if (!drv2smu)
-		memcpy(table_data, table->cpu_addr, table->size);
+		memcpy(table_data, table->cpu_addr, table_size);
 
 	return ret;
 }
@@ -948,7 +941,9 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	int ret, i;
+	struct smu_table **driver_table = &(smu_table->driver_table);
+	uint32_t max_table_size = 0;
+	int ret, i, index = 0;
 
 	for (i = 0; i < SMU_TABLE_COUNT; i++) {
 		if (tables[i].size == 0)
@@ -964,6 +959,21 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 			goto failed;
 	}
 
+	for (i = 0; i < SMU_TABLE_COUNT; i++) {
+		if (tables[i].size == 0)
+			continue;
+
+		if (i == SMU_TABLE_PMSTATUSLOG)
+			continue;
+
+		if (max_table_size < tables[i].size) {
+			max_table_size = tables[i].size;
+			index = i;
+		}
+	}
+
+	*driver_table = &tables[index];
+
 	return 0;
 failed:
 	while (--i >= 0) {
@@ -1063,6 +1073,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 
 	/* smu_dump_pptable(smu); */
 
+	ret = smu_set_driver_table_location(smu);
+	if (ret)
+		return ret;
+
 	/*
 	 * Copy pptable bo in the vram to smc with SMU MSGs such as
 	 * SetDriverDramAddr and TransferTableDram2Smu.
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 50b317f4b1e6..e89965e5fdcb 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2261,6 +2261,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 541cfde289ea..ed193adc881c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -259,6 +259,7 @@ struct smu_table_context
 	struct smu_bios_boot_up_values	boot_values;
 	void                            *driver_pptable;
 	struct smu_table		*tables;
+	struct smu_table		*driver_table;
 	struct smu_table		memory_pool;
 	uint8_t                         thermal_controller_type;
 
@@ -497,6 +498,7 @@ struct pptable_funcs {
 	int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
 	int (*write_pptable)(struct smu_context *smu);
 	int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
+	int (*set_driver_table_location)(struct smu_context *smu);
 	int (*set_tool_table_location)(struct smu_context *smu);
 	int (*notify_memory_pool_location)(struct smu_context *smu);
 	int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index db3f78676aeb..662989296174 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -170,6 +170,8 @@ int smu_v11_0_write_pptable(struct smu_context *smu);
 
 int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu);
 
+int smu_v11_0_set_driver_table_location(struct smu_context *smu);
+
 int smu_v11_0_set_tool_table_location(struct smu_context *smu);
 
 int smu_v11_0_notify_memory_pool_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 3f1cd06e273c..d79e54b5ebf6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -90,4 +90,6 @@ int smu_v12_0_mode2_reset(struct smu_context *smu);
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 
+int smu_v12_0_set_driver_table_location(struct smu_context *smu);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index e7ab8caee222..ed147dd51325 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2116,6 +2116,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index e73644beffd9..c4b5984c86d9 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -916,6 +916,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
 	.mode2_reset = smu_v12_0_mode2_reset,
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
+	.set_driver_table_location = smu_v12_0_set_driver_table_location,
 };
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 77864e4236c4..783319ec8bf9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -61,6 +61,8 @@
 	((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable((smu)) : 0)
 #define smu_set_min_dcef_deep_sleep(smu) \
 	((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_min_dcef_deep_sleep((smu)) : 0)
+#define smu_set_driver_table_location(smu) \
+	((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->set_driver_table_location((smu)) : 0)
 #define smu_set_tool_table_location(smu) \
 	((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs->set_tool_table_location((smu)) : 0)
 #define smu_notify_memory_pool_location(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 73935cf7ff39..79a63edcd7ba 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -774,6 +774,24 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
 	return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context->boot_values.dcefclk / 100);
 }
 
+int smu_v11_0_set_driver_table_location(struct smu_context *smu)
+{
+	struct smu_table *driver_table = smu->smu_table.driver_table;
+	int ret = 0;
+
+	if (driver_table->mc_address) {
+		ret = smu_send_smc_msg_with_param(smu,
+				SMU_MSG_SetDriverDramAddrHigh,
+				upper_32_bits(driver_table->mc_address));
+		if (!ret)
+			ret = smu_send_smc_msg_with_param(smu,
+				SMU_MSG_SetDriverDramAddrLow,
+				lower_32_bits(driver_table->mc_address));
+	}
+
+	return ret;
+}
+
 int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 2ac7f2f231b6..cd2be9fb2513 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -514,3 +514,21 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 	return ret;
 }
+
+int smu_v12_0_set_driver_table_location(struct smu_context *smu)
+{
+	struct smu_table *driver_table = smu->smu_table.driver_table;
+	int ret = 0;
+
+	if (driver_table->mc_address) {
+		ret = smu_send_smc_msg_with_param(smu,
+				SMU_MSG_SetDriverDramAddrHigh,
+				upper_32_bits(driver_table->mc_address));
+		if (!ret)
+			ret = smu_send_smc_msg_with_param(smu,
+				SMU_MSG_SetDriverDramAddrLow,
+				lower_32_bits(driver_table->mc_address));
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 534c46bc0146..12f97956058b 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3232,6 +3232,7 @@ static const struct pptable_funcs vega20_ppt_funcs = {
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
