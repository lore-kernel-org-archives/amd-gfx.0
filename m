Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF2CC2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A7821734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bsWxjbqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DCD89B18;
	Fri,  3 Jan 2020 09:47:47 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6658789B18
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr23rIVgCBKH455GFUUYGIoP6HxujWUGQEf3fdC0M5YA1BwkM7df5LeS05YhbIKVBth73kxUUnfvZYvW7LBC+qN8onQ8dmXpbrdsJ3SK8/r9WqWBnr9YBAdm8M3DG+AUt1kwiYXd1yd/yI6fHcYTKxgS77MQeksz466Mv+hWijJraij5V0j43lTQXih1R2YVcCEkmy+jxfESMhMJypKAC50nVWNwfnilb/PaYr1BS7SUx/0UXSJusgBx3/2ziNLzjIah3P/0JDIkD9vjyVta9pxnUW5WuM4ZUi7Mr3IqcJauKin97rXVrcnTP7jmuAAn7iW6EkWzrf8BiN177mMtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RiQLFLqyJc5fOqDjcbwKX9rBPZBYLevi45izKLXRP0=;
 b=AgbXniNF58bWvyqPf2M7j/nbKxuxIoox7KhYSa8fOZ6z6vBCy7fW7jyE9QmEoueAxCZWEey/H9RO06WEBM6fs+X0z1pePNtTqWnp4VAWI3nlS6KcCLtN54VmAgbHGmb6YfuaWgnw7meMv75QpPBFIYTMJc8BWAAhqR6c6gwY4IGbSGKaHoGzfXDcGB5NMk0YjAyDijCjq37ARYk+INjc+yW4xHyrZntEfVqAGDeonH/g74gnLObYyTxSlh6nHwehUR1o0qVadbdj9qmC7c/mGW7bXq4TRdOSihMucPT4dwqxCw5F9NsphHVqIBZVu//Pop7ornt3SczfIjHi0X+a6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RiQLFLqyJc5fOqDjcbwKX9rBPZBYLevi45izKLXRP0=;
 b=bsWxjbqtgwEHs0FUf0GyTQQOfvNHe+wjMQPRP8cDS9QxnROK5S3kb7XZaEyjcAwXSctRQvj6lzjczEnkU9OLrpoiC6dzpVQSn+hhO2ahkEAHmNBo5V2gISgEWzFUZpgmEdZ3yVUj+PzwuKNw4C91B+nJ+6K5EMf1lGnTsywYALQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3182.namprd12.prod.outlook.com (20.179.83.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 09:47:44 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 09:47:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: issue proper hdp flush for table
 transferring
Date: Fri,  3 Jan 2020 17:47:26 +0800
Message-Id: <20200103094726.32428-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR02CA0216.apcprd02.prod.outlook.com
 (2603:1096:201:20::28) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0216.apcprd02.prod.outlook.com (2603:1096:201:20::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 09:47:42 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b14544e6-eaba-4ad3-0cd5-08d79031fb4a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3182:|MN2PR12MB3182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31823DFE312812B29F7A1D4BE4230@MN2PR12MB3182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(478600001)(6486002)(956004)(8936002)(36756003)(6916009)(26005)(186003)(16526019)(52116002)(7696005)(2906002)(2616005)(4326008)(5660300002)(19627235002)(44832011)(66946007)(86362001)(1076003)(6666004)(66476007)(66556008)(81156014)(316002)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3182;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWwkTt9GTEGxq03R9JN05OVxoBkweDxSwqqpPtZVwWw1a6Ug4DCatyL7i2YWm8GaXlMuf6Zlbu64fWITuGnSk3ltFq4j0sq69PB4+e/X0MZUOcqJaBIGxsnULy+GnKKrIJwmkeqeFhEwnHMs7q5V+DLCAMAQOiHg+eTAP4IUSPNcw6viJ8d5N5Wi8QTqHV2hvTEao8DvDJW0ubWxVNw8qbH2G7eWSnWcNAego7NsXqSKar01BsLw3tMh5meDWbbxnVTOtgyX1+a0VDMVKKvQzpOJJBkb1vD+wO1kyZ66CoLxNBOHNW3TObukDDMHgQu+LI8+CRKCMXfKUf7Y0zcm6gKl2oiLfVJGt4RbMe+lorOXjEEZ4w4cFPFMlUF7JRmWHRDQwdFvYxVrbArFBV9p13ldEVK/18JOrg5ydW8ijoeki09wX415Kdcc8A49dFN3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14544e6-eaba-4ad3-0cd5-08d79031fb4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:47:44.3184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FU4P5mO419syTe5a3fEgwCGXh4g1C9TJz+TU4Z8Ii1FtjpmVjAmu4KEywPtKyTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
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

Guard the content consistence between the view of GPU and CPU
during the table transferring.

Change-Id: Ib3cebb97a1c8fb302eb040483bbaf089ae00c6a9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c        | 15 ++++++++++-----
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c   |  5 ++++-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c  |  5 ++++-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c  |  5 ++++-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c  | 10 ++++++++--
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index a56ebcc4e3c7..e1b64134bbd8 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -529,8 +529,14 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 
 	table_size = smu_table->tables[table_index].size;
 
-	if (drv2smu)
+	if (drv2smu) {
 		memcpy(table->cpu_addr, table_data, table_size);
+		/*
+		 * Flush hdp cache: to guard the content seen by
+		 * GPU is consitent with CPU.
+		 */
+		amdgpu_asic_flush_hdp(adev, NULL);
+	}
 
 	ret = smu_send_smc_msg_with_param(smu, drv2smu ?
 					  SMU_MSG_TransferTableDram2Smu :
@@ -539,11 +545,10 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	if (ret)
 		return ret;
 
-	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
-
-	if (!drv2smu)
+	if (!drv2smu) {
+		amdgpu_asic_flush_hdp(adev, NULL);
 		memcpy(table_data, table->cpu_addr, table_size);
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
index aa0ee2b46135..2319400a3fcb 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
@@ -137,7 +137,7 @@ static int smu10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			priv->smu_tables.entry[table_id].table_id);
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	amdgpu_asic_flush_hdp(adev, NULL);
 
 	memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -150,6 +150,7 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 {
 	struct smu10_smumgr *priv =
 			(struct smu10_smumgr *)(hwmgr->smu_backend);
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	PP_ASSERT_WITH_CODE(table_id < MAX_SMU_TABLE,
 			"Invalid SMU Table ID!", return -EINVAL;);
@@ -161,6 +162,8 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
+	amdgpu_asic_flush_hdp(adev, NULL);
+
 	smu10_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr));
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
index 39427ca32a15..715564009089 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
@@ -58,7 +58,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			priv->smu_tables.entry[table_id].table_id);
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	amdgpu_asic_flush_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -70,6 +70,7 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 		uint8_t *table, int16_t table_id)
 {
 	struct vega10_smumgr *priv = hwmgr->smu_backend;
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	/* under sriov, vbios or hypervisor driver
 	 * has already copy table to smc so here only skip it
@@ -87,6 +88,8 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
+	amdgpu_asic_flush_hdp(adev, NULL);
+
 	smu9_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr));
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
index 90c782c132d2..a3915bfcce81 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
@@ -66,7 +66,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			return -EINVAL);
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	amdgpu_asic_flush_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -84,6 +84,7 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 {
 	struct vega12_smumgr *priv =
 			(struct vega12_smumgr *)(hwmgr->smu_backend);
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	PP_ASSERT_WITH_CODE(table_id < TABLE_COUNT,
 			"Invalid SMU Table ID!", return -EINVAL);
@@ -95,6 +96,8 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
+	amdgpu_asic_flush_hdp(adev, NULL);
+
 	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr)) == 0,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index f604612f411f..0db57fb83d30 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -189,7 +189,7 @@ static int vega20_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			return ret);
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	amdgpu_asic_flush_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -207,6 +207,7 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 {
 	struct vega20_smumgr *priv =
 			(struct vega20_smumgr *)(hwmgr->smu_backend);
+	struct amdgpu_device *adev = hwmgr->adev;
 	int ret = 0;
 
 	PP_ASSERT_WITH_CODE(table_id < TABLE_COUNT,
@@ -219,6 +220,8 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
+	amdgpu_asic_flush_hdp(adev, NULL);
+
 	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr))) == 0,
@@ -242,11 +245,14 @@ int vega20_set_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
 {
 	struct vega20_smumgr *priv =
 			(struct vega20_smumgr *)(hwmgr->smu_backend);
+	struct amdgpu_device *adev = hwmgr->adev;
 	int ret = 0;
 
 	memcpy(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table, table,
 			priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
 
+	amdgpu_asic_flush_hdp(adev, NULL);
+
 	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].mc_addr))) == 0,
@@ -290,7 +296,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
 			return ret);
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	amdgpu_asic_flush_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
 			priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
