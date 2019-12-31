Return-Path: <SRS0=SXnv=2V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A9AC2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D990206DB
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3UQ5GMdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D990206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FFD6E0C4;
	Tue, 31 Dec 2019 02:49:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B1B6E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2019 02:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKzX+aR6wVUDlw2WFHSdCqrif4DWTgV+cGatGR2Ih5PasZZMIE2kViKOdljbCz0LHB+xuA+GhXnX9kyXcwD7KiJbUu0GtCXZLEuB8XbiOfgnQWPFfb3RyUcTfqo1FABkTSWzQZNOMVdh5FAHChjp4ZjqAEBPUdUm8+FZHf69IUbEqTpWPUaG7ZwbRIwydshZI8ZO94JXPq+SH0jLldw6wh/FhpAkWlyM/Qdh+xkLAW+7UvGtABEgXFgAW6QtO+KJ4zz18qQzry3ytzD5AIktcyWwiDzMrZTMO4Esw4hLJowMcBwhMv3uQuy111TuZVeqX1W6SQ6l8gaJZULGzNnN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD07FrsiPb18FHneLB7jKk0WUhCvAVVACeUYQSpR834=;
 b=TYzPPzRTI0X0uAsXZH2bN8yglupSQbzYmejwc7SG3cZdF/F2G4VLdQWY0R8/37+B447BA0C9DPYFNLOAse9hKEUANPe5biu5tuTJI8BbcLrT8skU5uBcYceMBWJ50Ebajtwmi4YLRdSYfqRAsDb2UHM4oW63XPujm1w5mgvCIjfT2dublPx9z1VUWuaVciRa0QGiElzyfXnccZmEiergd8zSwjCVR7+geUd1ZGhpIiP7KXexEg2zAZB+byws/j/+/oZUSivi34PnK6tIClhxC2iogPVuLXKXMdc4pMB4TrB4TVZHWiluiwImeYm6n0iCg4Sq8WU/V/NTQ85spWqB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD07FrsiPb18FHneLB7jKk0WUhCvAVVACeUYQSpR834=;
 b=3UQ5GMdn9Kn3neHMZUgUiUtgs4R/m33nPNBJqRJ97du+qsWIGARjOP/1KacQ9mErx4ETjdmN9YI7tWlwVc+wilR9TDgERHx/oFeA+A08D41DczEvHikOhDKAUOvcntM4XgdGffl7oj2SWVBcmW8dDm6lXrHMcN2MLDTYTJ8XNl0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Tue, 31 Dec 2019 02:49:24 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 02:49:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: unified VRAM address for driver table
 interaction with SMU
Date: Tue, 31 Dec 2019 10:48:56 +0800
Message-Id: <20191231024856.3557-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191231024856.3557-1-evan.quan@amd.com>
References: <20191231024856.3557-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.8 via Frontend Transport; Tue, 31 Dec 2019 02:49:22 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c75b536-d306-4f69-6d4c-08d78d9c0b27
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:|MN2PR12MB3935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3935192158995ABA74AD105DE4260@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0268246AE7
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(16526019)(8936002)(6666004)(186003)(4326008)(2616005)(7696005)(52116002)(8676002)(81166006)(6486002)(956004)(316002)(81156014)(26005)(478600001)(2906002)(36756003)(19627235002)(1076003)(44832011)(66946007)(66476007)(86362001)(6916009)(66556008)(30864003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3935;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vr56prC6JdRr3C1JDBPm5gI2HDw6Eh/dze+Jh7bFK+sZWCsb5SJKi9S7eHOOo4LohL4AL+d3Lbs9a3+VQXR2QsWUT5dUqrdN3GezZcQrVK1EGw/s9FyfHIWtaX3dSsNLampHxkvbF3hfK8p17BetDCzdXYT9J/kRvh5JZWgJeEkhTg0tnr+lkWxYzzzhRmqj6rTqhoBlVCCsjN5wTo0z1kwwaEHStwWrk8UK4ggrMcfq84aSeSXRBYDLmZV9mOOZ8yE7yfRMjg9JPcST2Ezb+UNY2OKcADdl9ACzJbTJIB3zxcWzvoQ7wyaHibB2yuWPJ976kLogG/uRgMa6AV+5RTsTluB3QXDuPHF4nOU34yY/8bWjXOYkJJZHfJf4mt/g1713xCq+OMcfTPUQWQsTB7lEExt8gSB+pj1+WZPYzwbKLx6qzMnfaZiLMObtQ75r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c75b536-d306-4f69-6d4c-08d78d9c0b27
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2019 02:49:24.2129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spABgYqFzf/9DbTw6BJ6tiJYp0HLLZdCVtxG0sYDUx5U3Fc/y4GRp8GDBbVD2T4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By this, we can avoid to pass in the VRAM address on every table
transferring. That puts extra unnecessary traffics on SMU on
some cases(e.g. polling the amdgpu_pm_info sysfs interface).

Change-Id: Ifb74d9cd89790b301e88d472b29cdb9b0365b65a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 98 ++++++++++++-------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  3 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 26 +++--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
 11 files changed, 109 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 09e16183a769..290976f5f6c2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -490,26 +490,19 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
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
@@ -521,7 +514,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	adev->nbio.funcs->hdp_flush(adev, NULL);
 
 	if (!drv2smu)
-		memcpy(table_data, table->cpu_addr, table->size);
+		memcpy(table_data, table->cpu_addr, table_size);
 
 	return ret;
 }
@@ -948,32 +941,56 @@ static int smu_init_fb_allocations(struct smu_context *smu)
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
 
@@ -981,18 +998,19 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
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
@@ -1063,6 +1081,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 
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
index 30da8328d1bc..121bf81eced5 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -260,6 +260,7 @@ struct smu_table_context
 	struct smu_bios_boot_up_values	boot_values;
 	void                            *driver_pptable;
 	struct smu_table		*tables;
+	struct smu_table		driver_table;
 	struct smu_table		memory_pool;
 	uint8_t                         thermal_controller_type;
 
@@ -498,6 +499,7 @@ struct pptable_funcs {
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
index 3387f3243a01..aa206bde619b 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2120,6 +2120,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
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
index 2ac7f2f231b6..2b1ef9eb0db6 100644
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
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
