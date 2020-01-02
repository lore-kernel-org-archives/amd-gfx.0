Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66EFC2D0DE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 02:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3D220848
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 02:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NTIXdFov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3D220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A98A89A60;
	Thu,  2 Jan 2020 02:40:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C7F89A60
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 02:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzvLMX+JdUcdb6qlWZuJCt32/7Db/4q5MAoiWvKx50DU60Xqcj+aKWADumXQuIheoG3Rtn1FddxmvZasC30B6MByCFVnA3vPlGcgRQuUda5hFOJyBx8Xwonu2nMeZTxJV3Zg7nF2vgwDMk6ltkoAyS7lQFqnhvZFrBZoKp6/Y6WW6e2jTeYaABMs9aWdnuLMPBYwSXvApjdjo1J5EtJbxe4O3Sc+YbwuaBACBBvEeRykYEHCH9i7GUkfAlNS9lW3+Lswf9anKzr+dmKL8GqDF+J0RiM8SPr8t5U9erOW+dUM1JzUjc9M/WDgczijOCVXcDQpLje/39aZ9UrqrDOXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6HLiFI7FuLDzVDxqqs3FaIBhlpo2hiwAJiSxg7UjOg=;
 b=d/ZQws15PL5XTS5HTt29EaD5vLSRC3YGdmzXS+EyDI0K3Ra+GTFLOoA2H4pSebe5fbDclEDBPjDMUL4+D5yScw/dIZoOk5oW+9NPQEVwMQFypXDaEG0FCyM+tTQFpH9mSfkOzvjHPW58WA06TUnywmjZ4IyovnzXv6vNw7SYEc3OXMdEAU+7mY3TAOuL6ogovM3cYnPTlftGvcy82NCZwGviU7czgpyh0NuTTNmswYs9wY0Pe+1XXakPLa3FToUGD3SNjXAI3z28mr5I+cO3VA8pSXJIPZSlbWpzop8Uhsq4I+iQwzUgDQOmO4yXsfNO5ufwn7S24JqdCKQiEVtzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6HLiFI7FuLDzVDxqqs3FaIBhlpo2hiwAJiSxg7UjOg=;
 b=NTIXdFovfrTziVVHE8XJ92WbZ0xgkP5Ermv5Cd3IwP9kvxKqwggku+lJm1v4NyJSdtwrqD1Ul/Qum3PYIHpnndlJkUHGJpmULLZuIkG4bbfVkIbZBhQG/sUu/nnGpKlQuCKPBboC+/GJW34IxifHtinWWaqLpUjlMIbDeGPVh18=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3198.namprd12.prod.outlook.com (20.179.82.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 2 Jan 2020 02:40:05 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 02:40:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: unified VRAM address for driver table
 interaction with SMU V2
Date: Thu,  2 Jan 2020 10:39:43 +0800
Message-Id: <20200102023943.11555-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0179.apcprd02.prod.outlook.com (2603:1096:201:21::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Thu, 2 Jan 2020 02:40:04 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb6d6fbf-4384-49cc-1945-08d78f2d1329
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:|MN2PR12MB3198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3198A62AAC83A544B8DE2BD2E4200@MN2PR12MB3198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0270ED2845
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39850400004)(376002)(396003)(346002)(136003)(189003)(199004)(7696005)(19627235002)(316002)(2906002)(26005)(478600001)(6666004)(16526019)(52116002)(36756003)(186003)(956004)(5660300002)(44832011)(66556008)(66946007)(66476007)(8676002)(8936002)(30864003)(81166006)(6916009)(2616005)(4326008)(81156014)(86362001)(1076003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3198;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBldLxeIon4+vZQucPtSQVLQH8j0ssNJmhDOyMo18hzOyF5u8hvSD5THc1iT+WuBPdx1qlesbcVYxPcvbH8Qjrr8fqMFkHRSF9BjyShy5ktQINWR+Iw8RBBb51v0A5YkrksVD9h5f0cmtvuG5i03GsJKY49NBOBNAH2pa5w3MrXB5fa8KuDZk1hPjgIRqtTutHqp6Q3s1MiDwoLSBNebpKSVLCFSDnBPYzb5hW0W1zPEOwqtXv1b0zc/SruaiS9lBfRjyY1HHxILH3mv9yqqbn6+ragMrDDjmc28eVzBJd6/Zr52OtQ9NaQQcqLX/RgKdRooWRjg3tB3sxWsjWK0xlOk06NvcIU+XpW10Z+Y3s6UMwaveomXF5a44xVP1xNEqPw7vrzXIzMoz6fagfhWjRY8DdENrbYsOMtG9I96O89wwS9MExhHcAd2He4+s9Wb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6d6fbf-4384-49cc-1945-08d78f2d1329
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 02:40:05.8142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBSS40IiodOgHzJr6CNw4Lqq9ehCjgvOetkvdmoYVoWTETPujdoZ2cyvGP72WtCS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By this, we can avoid to pass in the VRAM address on every table
transferring. That puts extra unnecessary traffics on SMU on
some cases(e.g. polling the amdgpu_pm_info sysfs interface).

V2: document what the driver table is for and how it works

Change-Id: Ifb74d9cd89790b301e88d472b29cdb9b0365b65a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 98 ++++++++++++-------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  3 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    | 10 ++
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 26 +++--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
 11 files changed, 117 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 95238ad38de8..beea4d9e82d4 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -519,26 +519,19 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
-	struct smu_table *table = NULL;
-	int ret = 0;
+	struct smu_table *table = &smu_table->driver_table;
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
@@ -550,7 +543,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	adev->nbio.funcs->hdp_flush(adev, NULL);
 
 	if (!drv2smu)
-		memcpy(table_data, table->cpu_addr, table->size);
+		memcpy(table_data, table->cpu_addr, table_size);
 
 	return ret;
 }
@@ -976,32 +969,56 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	struct smu_table *driver_table = &(smu_table->driver_table);
+	uint32_t max_table_size = 0;
 	int ret, i;
 
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
 
-	return 0;
-failed:
-	while (--i >= 0) {
+	/* VRAM allocation for driver table */
+	for (i = 0; i < SMU_TABLE_COUNT; i++) {
 		if (tables[i].size == 0)
 			continue;
-		amdgpu_bo_free_kernel(&tables[i].bo,
-				      &tables[i].mc_address,
-				      &tables[i].cpu_addr);
 
+		if (i == SMU_TABLE_PMSTATUSLOG)
+			continue;
+
+		if (max_table_size < tables[i].size)
+			max_table_size = tables[i].size;
+	}
+
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
 
@@ -1009,18 +1026,19 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
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
@@ -1091,6 +1109,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 
 	/* smu_dump_pptable(smu); */
 
+	ret = smu_set_driver_table_location(smu);
+	if (ret)
+		return ret;
+
 	/*
 	 * Copy pptable bo in the vram to smc with SMU MSGs such as
 	 * SetDriverDramAddr and TransferTableDram2Smu.
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 50b317f4b1e6..064b5201a8a7 100644
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
@@ -2261,6 +2261,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 02d33b50e735..b0591a8dda41 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -260,6 +260,15 @@ struct smu_table_context
 	struct smu_bios_boot_up_values	boot_values;
 	void                            *driver_pptable;
 	struct smu_table		*tables;
+	/*
+	 * The driver table is just a staging buffer for
+	 * uploading/downloading content from the SMU.
+	 *
+	 * And the table_id for SMU_MSG_TransferTableSmu2Dram/
+	 * SMU_MSG_TransferTableDram2Smu instructs SMU
+	 * which content driver is interested.
+	 */
+	struct smu_table		driver_table;
 	struct smu_table		memory_pool;
 	uint8_t                         thermal_controller_type;
 
@@ -498,6 +507,7 @@ struct pptable_funcs {
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
index bb0915a6388e..a16af3a3843c 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2112,6 +2112,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 506cc6bf4bc0..861e6410363b 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -920,6 +920,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
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
index 6fb93eb6ab39..e804f9854027 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -776,6 +776,24 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
 	return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context->boot_values.dcefclk / 100);
 }
 
+int smu_v11_0_set_driver_table_location(struct smu_context *smu)
+{
+	struct smu_table *driver_table = &smu->smu_table.driver_table;
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
index 9e27462d0f4e..870e6db2907e 100644
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
@@ -514,3 +506,21 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 	return ret;
 }
+
+int smu_v12_0_set_driver_table_location(struct smu_context *smu)
+{
+	struct smu_table *driver_table = &smu->smu_table.driver_table;
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
index 27bdcdeb08d9..38febd5ca4da 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3236,6 +3236,7 @@ static const struct pptable_funcs vega20_ppt_funcs = {
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
