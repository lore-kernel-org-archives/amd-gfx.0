Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B2DC2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926192071E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wA9ZKkfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926192071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA4B891EB;
	Mon, 30 Dec 2019 10:50:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F95891C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 10:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISVemsSdB2fWEUf3c0VbAD5BkUgVWDi+43LwPj8ZT3TpaPdkqaUuX/as1U+AtWIkpt4Gu6rin4/VoN1uNg2NBUDCOoertnMgBZnsgs2N8ObQ3YeCDQX/dJ+5BRzdAyjopWwr1STjp9N/cJv9PNq094Tu1tM54Sad3kXymy6PPjoD0KIt3sWciKSWbWFXUQKjlOvI3hGvF59XfONPlzQpX8BxYfQrAL76LoWl+D1V/NwuxV93iEgfxNKia7mBmylNfQHnwnIkK8P9fE80DIHJ0fB62JbnOKc30PNsSRNvCxoobzv2P7gl6brZ6HB2lVKjSX480tdfFK8XEvjIw9mPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toWsns39Z6G0O1ZDomsJUnGVX/A3CaweW0v2AogmlIQ=;
 b=BydI9lxKp063d9TbmN9UM5pnV1BBzxjJtz5qd+IAaeNq6kzXeN50CTmOe8sXVNzP/m4sbv1Eo7ZI5WDS2oBNRZ8VOwg9ml1mD4Glc/2TKijfnUkw0/Uch/t2rOAw0ZdeJXA6a1p0M2D/Ahgt5+QJnGqvZDtE3XzZ4PYozLLDhkOhVQv1p/MOu0MZz8Y65n8lDoFRvdkpa6tgxEhYVnbLU8rDF+mtwFHdY9nTxS0cI0hSi9cPHtm05gn/fhu503UP4peDAIqS8KdSqHxrg/fVkm4EOLLbB/2IhARyBLofpYAbZHwBcCdH1xecobfyKqFeTkdwDIa+OBxzmMS/0GHhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toWsns39Z6G0O1ZDomsJUnGVX/A3CaweW0v2AogmlIQ=;
 b=wA9ZKkfuVgiMqjRBJSJeb/HVhZ+eAzX7ZnX3cg/Fsaq8U7IlpiRlnMp+4xArcI0FgM7MqzELOQQ0FyoAS52o7895rvaPYwDnhAVpLajg/em4uhYmeaEuItQ5CVr4R6jGZFRgFbLZe7beCXXyhTyhwmc8eQy+J9KOhjuB5mpbbhQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3997.namprd12.prod.outlook.com (10.255.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 10:50:04 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 10:50:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: allocate one piece of VRAM for all
 tables transferring
Date: Mon, 30 Dec 2019 18:49:31 +0800
Message-Id: <20191230104931.28260-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191230104931.28260-1-evan.quan@amd.com>
References: <20191230104931.28260-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 10:50:02 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4a0d235-a0c7-4677-9956-08d78d160692
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:|MN2PR12MB3997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB399732785535991B8B0D0A85E4270@MN2PR12MB3997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-Forefront-PRVS: 0267E514F9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(8676002)(8936002)(66946007)(81166006)(4326008)(66556008)(52116002)(7696005)(81156014)(66476007)(26005)(2906002)(6486002)(2616005)(6666004)(30864003)(6916009)(86362001)(186003)(478600001)(1076003)(316002)(16526019)(5660300002)(44832011)(36756003)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3997;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmZNUucchUS4bt8nbIX6baHmdMuUqf3nWr7UvfcPgjilHCSAn3C2Ynq2C6DQzalfGae9PpcYx/xQRlqbK9WEZR8egw2VZQekK1sFzQjrp9pnECG7Sp+za1cSRG0Bk3935wMATeAD6+h8fo/5/ibYIWOFpdn1seOhsNttypS28dgfSKWFA7LdQ+Q/9U6M9l2RyaoEEDKkNmyxZy8nS82tXA7WSpACaSP6yWXyK+bVdWa5+knR6oRbAahlAn4FZaj/jPxginB7uIEHLlW75tYsZZuFtvelZQZLIiqbgmpR5iqaGd1l+MzLmiMBFQzONf8E4n/Zi2p5ZjDJqeK+8v4nCLR9e3idsLURYRAv3BKgMIHcyrs61QMOnCMKlxaLf7GklDuFJkCCRCabskNIqfCBJCi2pbHdhoELuwoQXDrfiA0ogTstK8exU8u3Waa6M1Si
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a0d235-a0c7-4677-9956-08d78d160692
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2019 10:50:03.8330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkJXUg6FZSAKuCK+XY1fvbMwwMfCi72LOjHgRtmyxkZwJ82bVIsTy9ydDShhKTiH
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

Simplify the table transferring between driver and SMU and use less
VRAM.

Change-Id: I3f9b54fd9b8c0bcaeb533fc1a07bb06050fefbd8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 101 ++++++++++--------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |   2 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   3 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   4 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |   4 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |   4 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  10 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |   4 +
 8 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index c3cb1b8f43b5..bd3dbd1a0ad3 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -490,7 +490,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
-	struct smu_table *table = smu_table->driver_table;
+	struct smu_table *table = &smu_table->driver_table;
 	int table_id = smu_table_get_index(smu, table_index);
 	uint32_t table_size;
 	int ret = 0;
@@ -941,24 +941,26 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	struct smu_table **driver_table = &(smu_table->driver_table);
+	struct smu_table *driver_table = &(smu_table->driver_table);
 	uint32_t max_table_size = 0;
-	int ret, i, index = 0;
+	int ret, i;
 
-	for (i = 0; i < SMU_TABLE_COUNT; i++) {
-		if (tables[i].size == 0)
-			continue;
+	/* VRAM allocation for tool table */
+	if (tables[SMU_TABLE_PMSTATUSLOG].size) {
 		ret = amdgpu_bo_create_kernel(adev,
-					      tables[i].size,
-					      tables[i].align,
-					      tables[i].domain,
-					      &tables[i].bo,
-					      &tables[i].mc_address,
-					      &tables[i].cpu_addr);
-		if (ret)
-			goto failed;
+					      tables[SMU_TABLE_PMSTATUSLOG].size,
+					      tables[SMU_TABLE_PMSTATUSLOG].align,
+					      tables[SMU_TABLE_PMSTATUSLOG].domain,
+					      &tables[SMU_TABLE_PMSTATUSLOG].bo,
+					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
+					      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
+		if (ret) {
+			pr_err("VRAM allocation for tool table failed!\n");
+			return ret;
+		}
 	}
 
+	/* VRAM allocation for driver table */
 	for (i = 0; i < SMU_TABLE_COUNT; i++) {
 		if (tables[i].size == 0)
 			continue;
@@ -966,24 +968,29 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 		if (i == SMU_TABLE_PMSTATUSLOG)
 			continue;
 
-		if (max_table_size < tables[i].size) {
+		if (max_table_size < tables[i].size)
 			max_table_size = tables[i].size;
-			index = i;
-		}
 	}
 
-	*driver_table = &tables[index];
-
-	return 0;
-failed:
-	while (--i >= 0) {
-		if (tables[i].size == 0)
-			continue;
-		amdgpu_bo_free_kernel(&tables[i].bo,
-				      &tables[i].mc_address,
-				      &tables[i].cpu_addr);
-
+	driver_table->size = max_table_size;
+	driver_table->align = PAGE_SIZE;
+	driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
+
+	ret = amdgpu_bo_create_kernel(adev,
+				      driver_table->size,
+				      driver_table->align,
+				      driver_table->domain,
+				      &driver_table->bo,
+				      &driver_table->mc_address,
+				      &driver_table->cpu_addr);
+	if (ret) {
+		pr_err("VRAM allocation for driver table failed!\n");
+		if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
+			amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
+					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
+					      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
 	}
+
 	return ret;
 }
 
@@ -991,18 +998,19 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	uint32_t i = 0;
+	struct smu_table *driver_table = &(smu_table->driver_table);
 
 	if (!tables)
 		return 0;
 
-	for (i = 0; i < SMU_TABLE_COUNT; i++) {
-		if (tables[i].size == 0)
-			continue;
-		amdgpu_bo_free_kernel(&tables[i].bo,
-				      &tables[i].mc_address,
-				      &tables[i].cpu_addr);
-	}
+	if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
+		amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
+				      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
+				      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
+
+	amdgpu_bo_free_kernel(&driver_table->bo,
+			      &driver_table->mc_address,
+			      &driver_table->cpu_addr);
 
 	return 0;
 }
@@ -1913,26 +1921,25 @@ int smu_set_df_cstate(struct smu_context *smu,
 
 int smu_write_watermarks_table(struct smu_context *smu)
 {
-	int ret = 0;
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *table = NULL;
+	void *watermarks_table = smu->smu_table.watermarks_table;
 
-	table = &smu_table->tables[SMU_TABLE_WATERMARKS];
-
-	if (!table->cpu_addr)
+	if (!watermarks_table)
 		return -EINVAL;
 
-	ret = smu_update_table(smu, SMU_TABLE_WATERMARKS, 0, table->cpu_addr,
+	return smu_update_table(smu,
+				SMU_TABLE_WATERMARKS,
+				0,
+				watermarks_table,
 				true);
-
-	return ret;
 }
 
 int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
-	struct smu_table *watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
-	void *table = watermarks->cpu_addr;
+	void *table = smu->smu_table.watermarks_table;
+
+	if (!table)
+		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index e89965e5fdcb..064b5201a8a7 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2022,7 +2022,7 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
 	SwI2cRequest_t req;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
-	struct smu_table *table = &smu_table->tables[SMU_TABLE_I2C_COMMANDS];
+	struct smu_table *table = &smu_table->driver_table;
 
 	memset(&req, 0, sizeof(req));
 	arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ed193adc881c..121bf81eced5 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -254,12 +254,13 @@ struct smu_table_context
 	unsigned long			metrics_time;
 	void				*metrics_table;
 	void				*clocks_table;
+	void				*watermarks_table;
 
 	void				*max_sustainable_clocks;
 	struct smu_bios_boot_up_values	boot_values;
 	void                            *driver_pptable;
 	struct smu_table		*tables;
-	struct smu_table		*driver_table;
+	struct smu_table		driver_table;
 	struct smu_table		memory_pool;
 	uint8_t                         thermal_controller_type;
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ed147dd51325..aa206bde619b 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -555,6 +555,10 @@ static int navi10_tables_init(struct smu_context *smu, struct smu_table *tables)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index c4b5984c86d9..861e6410363b 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -209,6 +209,10 @@ static int renoir_tables_init(struct smu_context *smu, struct smu_table *tables)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 79a63edcd7ba..962e97860fe8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -450,8 +450,10 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 
 	kfree(smu_table->tables);
 	kfree(smu_table->metrics_table);
+	kfree(smu_table->watermarks_table);
 	smu_table->tables = NULL;
 	smu_table->metrics_table = NULL;
+	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
 
 	ret = smu_v11_0_fini_dpm_context(smu);
@@ -776,7 +778,7 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
 
 int smu_v11_0_set_driver_table_location(struct smu_context *smu)
 {
-	struct smu_table *driver_table = smu->smu_table.driver_table;
+	struct smu_table *driver_table = &smu->smu_table.driver_table;
 	int ret = 0;
 
 	if (driver_table->mc_address) {
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index cd2be9fb2513..2b1ef9eb0db6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -318,14 +318,6 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
 int smu_v12_0_populate_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *table = NULL;
-
-	table = &smu_table->tables[SMU_TABLE_DPMCLOCKS];
-	if (!table)
-		return -EINVAL;
-
-	if (!table->cpu_addr)
-		return -EINVAL;
 
 	return smu_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
 }
@@ -517,7 +509,7 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 int smu_v12_0_set_driver_table_location(struct smu_context *smu)
 {
-	struct smu_table *driver_table = smu->smu_table.driver_table;
+	struct smu_table *driver_table = &smu->smu_table.driver_table;
 	int ret = 0;
 
 	if (driver_table->mc_address) {
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 12f97956058b..38febd5ca4da 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -338,6 +338,10 @@ static int vega20_tables_init(struct smu_context *smu, struct smu_table *tables)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
