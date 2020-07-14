Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D4FC433F4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4480821582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C4AD1MvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4480821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E534789932;
	Tue, 14 Jul 2020 08:07:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8126689932
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftHgRnpRsTleBzsnawbySlLDVPmdF7x4woNzjnr48yHxw6HOr1eF4hbixPTs+FVOCfjnbd9Mcpn9cLyViwA8GFUf86bo1LrzU1oNZp8i8EV4pOMdavf1AvAb4iN1Jj6DwAb7TQ0yXkREYxoCcw3Y4I9X+2I/A3j6b6h6LYhVOcdPi70NEz3I+PiwOBnLyuEVai5Xrz+fF2iGHRtxEFC1myVKGiPcDLmgwGDnwqMkVm6KTnT/9FziYzzKRiRhw/kJgFF1juQyz4xCjaiu733Y7rZ8quWgVK6T8LVBlhhyOU19bF/TImvyEd8zMQ5flj1U/h9NUPfQy83L4aIrpwNc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFZEBtXIF2NPUrgMdltbDdBjGliuivN/1ADbPfXhuss=;
 b=Hi27raB11e9psBG3kdhGKsi4c3iElp13v1K8qRxWvy8jIcNkpPbicjIkbH1OSCpJhHYUU6W/c18PLxflRJTZutplIym+bC9t1L8C428U1fG9SEu2RJK04NON1I3oixjL4N+6laNwdl3WQ2po7ZiD7vacJAcBOpSlocTaafOPf1572XaPuQTDu9w1hA/kacI+jSRV5UwFFfQL2Auced+/XPIvM/IEcMopvaT3qSmAKgM8uGBy1tXQsnMW3jNUv4jmd4QzdsWHgRkw84+alrLGLx4nInUsOQB08uIufFXHGQM37PkM6/m2QdQ9Q9Z6EhpdtioUrb5y6LStdngfYDUKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFZEBtXIF2NPUrgMdltbDdBjGliuivN/1ADbPfXhuss=;
 b=C4AD1MvX+bCpMuQaYqmxCVLYYMRKbhERWCoqjdI6zMw3hj5FKmKdtPg+D/9gXii8ZUKCZYoP2vf9d9BaSYb94CLXZpCon+7pH5HxH2Y/vg4bCN5c3lKZURqVabOtn2lZ4uwsUH4Pqgu6q8ZQ2/jckEuXJ3dq+N1JvKo9hSz3OPc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:07:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:07:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/17] drm/amd/powerplay: update the tables init related
Date: Tue, 14 Jul 2020 16:04:12 +0800
Message-Id: <20200714080416.6506-13-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:07:04 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d21c126-2e1f-46c3-6ece-08d827cce609
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435542FD25928B38CD8AE010E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVx81TOPxQvu1VurVp/t3VMoJXiWCb4YvBcTq4pAPuF2iiZOx2mnjcLdM+aDHnttnAHAKjkKo09jmxWawTrJB991nDtZ76X5l2JycMe5XpO9u0o7IzT41pJBcIYATuUZGGKkZMQb0rXuc1oGpYYfVKzW+xQ1Q/pDx+ZwSIxFc26NOSqtFRPrl2njW8ZUP+c7+UssdlMe1ZL4GiMdr5aglR3ifbqF35U7kuPKUkHtdMELVIlCKdb+bnfzGnKaDa2QpnQMQO3YNKKIUt5O10E+WSmV3C1u+kgt4o/r/GFBLyx1oBNO+Oy/8u+fw/a6cVkyj/SVtIrOy/udk+jlYi9Ogw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(66574015)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9G6mQ1smRjJA0SgdeGeDbl0RZGdCuyeLf8UDA/AZsZKKARQ9gk0ISzrAOUpMBE3Cd4NucMbnKsKkO1C1XEzJxN7c3HIA9tFxfifnCcFERPCnUelHmvXp8tyHT4bCJWfeTHbaIp4sWaq4WuZEkp45Q5TFmdpU5He4CriYZMK6LAUrbhNBq/Y+yeD10dhHcIIp8XeGqA6sGYBM7sOd9gxQw/AM8ZsSlUTws8XfNsUpBGGuCpHi7lU5iyrRtT89W8GIuWfRTtasifUVQFBmGsAhiDKsHUcPNArKST7AJYZbO4QpujtgQwEiJH9LFXIQspPapgOFEvRqdMinFBp1T/+tHFMnKEpPFPfAn4KvsXsiBjw6ilVY2fTJShp60TSB2KRRJPCzSJrIwGEOKauEByyvh22JEvBUm9roUosSkYcHGxKK47i5FcN1jg/rOpUlCvSoS8TgLx1Ii9pSb+qFFqR6sOCh8zPOoTKIq6VTm6ORpKMTFV50mk4e7QWAy+9dBCQ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d21c126-2e1f-46c3-6ece-08d827cce609
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:07:06.2992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVYY5JIjRDAoyWmmFqGppxL1Y7huslTX7Iw0rHr4fgtSTrCOl5JKh9Qf0cPO6Elx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

To avoid cross calling and maintain clear code layer.

Change-Id: Ieef1ecd38e0873baaedca1c2dabd9bb8af5a0c2a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 23 +++--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 25 ++++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  6 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 25 ++++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 86 ++++---------------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 30 ++-----
 9 files changed, 83 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index fbe2711591ad..78e0917f7840 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -206,9 +206,10 @@ static const struct cmn2asic_mapping arcturus_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
-static int arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)
+static int arcturus_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -257,6 +258,21 @@ static int arcturus_allocate_dpm_context(struct smu_context *smu)
 	return 0;
 }
 
+static int arcturus_init_smc_tables(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = arcturus_tables_init(smu);
+	if (ret)
+		return ret;
+
+	ret = arcturus_allocate_dpm_context(smu);
+	if (ret)
+		return ret;
+
+	return smu_v11_0_init_smc_tables(smu);
+}
+
 static int
 arcturus_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
@@ -2226,9 +2242,6 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
-	/* internal structurs allocations */
-	.tables_init = arcturus_tables_init,
-	.alloc_dpm_context = arcturus_allocate_dpm_context,
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
 	/* btc */
@@ -2256,7 +2269,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
 	.fini_microcode = smu_v11_0_fini_microcode,
-	.init_smc_tables = smu_v11_0_init_smc_tables,
+	.init_smc_tables = arcturus_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 547797e42992..e2fa68fa862e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -259,7 +259,7 @@ struct smu_table_context
 	void				*max_sustainable_clocks;
 	struct smu_bios_boot_up_values	boot_values;
 	void                            *driver_pptable;
-	struct smu_table		*tables;
+	struct smu_table		tables[SMU_TABLE_COUNT];
 	/*
 	 * The driver table is just a staging buffer for
 	 * uploading/downloading content from the SMU.
@@ -451,7 +451,6 @@ struct smu_context
 struct i2c_adapter;
 
 struct pptable_funcs {
-	int (*alloc_dpm_context)(struct smu_context *smu);
 	int (*run_btc)(struct smu_context *smu);
 	int (*get_allowed_feature_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
 	enum amd_pm_state_type (*get_current_power_state)(struct smu_context *smu);
@@ -490,7 +489,6 @@ struct pptable_funcs {
 	int (*notify_smc_display_config)(struct smu_context *smu);
 	int (*set_cpu_power_state)(struct smu_context *smu);
 	bool (*is_dpm_running)(struct smu_context *smu);
-	int (*tables_init)(struct smu_context *smu, struct smu_table *tables);
 	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
 	int (*set_watermarks_table)(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index dd3904e8aef0..e3db0fe1f2c3 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -58,8 +58,6 @@ uint32_t smu_v12_0_get_gfxoff_status(struct smu_context *smu);
 
 int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable);
 
-int smu_v12_0_init_smc_tables(struct smu_context *smu);
-
 int smu_v12_0_fini_smc_tables(struct smu_context *smu);
 
 int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 8fd1dcdfed95..d6edd2a4eb2d 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -447,9 +447,10 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	return ret;
 }
 
-static int navi10_tables_init(struct smu_context *smu, struct smu_table *tables)
+static int navi10_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -578,9 +579,6 @@ static int navi10_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	if (smu_dpm->dpm_context)
-		return -EINVAL;
-
 	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 				       GFP_KERNEL);
 	if (!smu_dpm->dpm_context)
@@ -591,6 +589,21 @@ static int navi10_allocate_dpm_context(struct smu_context *smu)
 	return 0;
 }
 
+static int navi10_init_smc_tables(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = navi10_tables_init(smu);
+	if (ret)
+		return ret;
+
+	ret = navi10_allocate_dpm_context(smu);
+	if (ret)
+		return ret;
+
+	return smu_v11_0_init_smc_tables(smu);
+}
+
 static int navi10_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -2251,8 +2264,6 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 }
 
 static const struct pptable_funcs navi10_ppt_funcs = {
-	.tables_init = navi10_tables_init,
-	.alloc_dpm_context = navi10_allocate_dpm_context,
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
 	.dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
@@ -2280,7 +2291,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
 	.fini_microcode = smu_v11_0_fini_microcode,
-	.init_smc_tables = smu_v11_0_init_smc_tables,
+	.init_smc_tables = navi10_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 9289df9b7d8a..83915adcec76 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -151,9 +151,10 @@ static int renoir_get_metrics_table(struct smu_context *smu,
 	return ret;
 }
 
-static int renoir_tables_init(struct smu_context *smu, struct smu_table *tables)
+static int renoir_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -966,7 +967,6 @@ static bool renoir_is_dpm_running(struct smu_context *smu)
 }
 
 static const struct pptable_funcs renoir_ppt_funcs = {
-	.tables_init = renoir_tables_init,
 	.set_power_state = NULL,
 	.print_clk_levels = renoir_print_clk_levels,
 	.get_current_power_state = renoir_get_current_power_state,
@@ -985,7 +985,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.send_smc_msg_with_param = smu_v12_0_send_msg_with_param,
 	.set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
 	.gfx_off_control = smu_v12_0_gfx_off_control,
-	.init_smc_tables = smu_v12_0_init_smc_tables,
+	.init_smc_tables = renoir_init_smc_tables,
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 6b4faf4c888c..bd9594891d5f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -352,9 +352,10 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
 	return ret;
 }
 
-static int sienna_cichlid_tables_init(struct smu_context *smu, struct smu_table *tables)
+static int sienna_cichlid_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -490,9 +491,6 @@ static int sienna_cichlid_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	if (smu_dpm->dpm_context)
-		return -EINVAL;
-
 	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 				       GFP_KERNEL);
 	if (!smu_dpm->dpm_context)
@@ -503,6 +501,21 @@ static int sienna_cichlid_allocate_dpm_context(struct smu_context *smu)
 	return 0;
 }
 
+static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = sienna_cichlid_tables_init(smu);
+	if (ret)
+		return ret;
+
+	ret = sienna_cichlid_allocate_dpm_context(smu);
+	if (ret)
+		return ret;
+
+	return smu_v11_0_init_smc_tables(smu);
+}
+
 static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -2372,8 +2385,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 }
 
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
-	.tables_init = sienna_cichlid_tables_init,
-	.alloc_dpm_context = sienna_cichlid_allocate_dpm_context,
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
 	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
@@ -2400,7 +2411,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.dump_pptable = sienna_cichlid_dump_pptable,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
-	.init_smc_tables = smu_v11_0_init_smc_tables,
+	.init_smc_tables = sienna_cichlid_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index dd187e0020d5..b38ff35f3625 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -50,7 +50,6 @@
 #define smu_set_default_od_settings(smu)				smu_ppt_funcs(set_default_od_settings, 0, smu)
 #define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
 #define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, 0, read_arg)
-#define smu_alloc_dpm_context(smu)					smu_ppt_funcs(alloc_dpm_context, 0, smu)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
@@ -61,7 +60,6 @@
 #define smu_set_default_dpm_table(smu)					smu_ppt_funcs(set_default_dpm_table, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
 #define smu_set_default_od8_settings(smu)				smu_ppt_funcs(set_default_od8_settings, 0, smu)
-#define smu_tables_init(smu, tab)					smu_ppt_funcs(tables_init, 0, smu, tab)
 #define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
 #define smu_disable_thermal_alert(smu)					smu_ppt_funcs(disable_thermal_alert, 0, smu)
 #define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 4bf07a4ec853..ee8a6ddef8e7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -440,70 +440,24 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 	return 0;
 }
 
-static int smu_v11_0_init_dpm_context(struct smu_context *smu)
-{
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-
-	if (smu_dpm->dpm_context || smu_dpm->dpm_context_size != 0)
-		return -EINVAL;
-
-	return smu_alloc_dpm_context(smu);
-}
-
-static int smu_v11_0_fini_dpm_context(struct smu_context *smu)
-{
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-
-	if (!smu_dpm->dpm_context || smu_dpm->dpm_context_size == 0)
-		return -EINVAL;
-
-	kfree(smu_dpm->dpm_context);
-	kfree(smu_dpm->golden_dpm_context);
-	kfree(smu_dpm->dpm_current_power_state);
-	kfree(smu_dpm->dpm_request_power_state);
-	smu_dpm->dpm_context = NULL;
-	smu_dpm->golden_dpm_context = NULL;
-	smu_dpm->dpm_context_size = 0;
-	smu_dpm->dpm_current_power_state = NULL;
-	smu_dpm->dpm_request_power_state = NULL;
-
-	return 0;
-}
-
 int smu_v11_0_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *tables = NULL;
+	struct smu_table *tables = smu_table->tables;
 	int ret = 0;
 
-	tables = kcalloc(SMU_TABLE_COUNT, sizeof(struct smu_table),
-			 GFP_KERNEL);
-	if (!tables) {
-		ret = -ENOMEM;
-		goto err0_out;
-	}
-	smu_table->tables = tables;
-
-	ret = smu_tables_init(smu, tables);
-	if (ret)
-		goto err1_out;
-
-	ret = smu_v11_0_init_dpm_context(smu);
-	if (ret)
-		goto err1_out;
-
 	smu_table->driver_pptable =
 		kzalloc(tables[SMU_TABLE_PPTABLE].size, GFP_KERNEL);
 	if (!smu_table->driver_pptable) {
 		ret = -ENOMEM;
-		goto err2_out;
+		goto err0_out;
 	}
 
 	smu_table->max_sustainable_clocks =
 		kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks), GFP_KERNEL);
 	if (!smu_table->max_sustainable_clocks) {
 		ret = -ENOMEM;
-		goto err3_out;
+		goto err1_out;
 	}
 
 	/* Arcturus does not support OVERDRIVE */
@@ -512,29 +466,25 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
 			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
 		if (!smu_table->overdrive_table) {
 			ret = -ENOMEM;
-			goto err4_out;
+			goto err2_out;
 		}
 
 		smu_table->boot_overdrive_table =
 			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
 		if (!smu_table->boot_overdrive_table) {
 			ret = -ENOMEM;
-			goto err5_out;
+			goto err3_out;
 		}
 	}
 
 	return 0;
 
-err5_out:
-	kfree(smu_table->overdrive_table);
-err4_out:
-	kfree(smu_table->max_sustainable_clocks);
 err3_out:
-	kfree(smu_table->driver_pptable);
+	kfree(smu_table->overdrive_table);
 err2_out:
-	smu_v11_0_fini_dpm_context(smu);
+	kfree(smu_table->max_sustainable_clocks);
 err1_out:
-	kfree(tables);
+	kfree(smu_table->driver_pptable);
 err0_out:
 	return ret;
 }
@@ -542,10 +492,7 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
 int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	int ret = 0;
-
-	if (!smu_table->tables)
-		return -EINVAL;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
@@ -558,17 +505,22 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->hardcode_pptable);
 	smu_table->hardcode_pptable = NULL;
 
-	kfree(smu_table->tables);
 	kfree(smu_table->metrics_table);
 	kfree(smu_table->watermarks_table);
-	smu_table->tables = NULL;
 	smu_table->metrics_table = NULL;
 	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
 
-	ret = smu_v11_0_fini_dpm_context(smu);
-	if (ret)
-		return ret;
+	kfree(smu_dpm->dpm_context);
+	kfree(smu_dpm->golden_dpm_context);
+	kfree(smu_dpm->dpm_current_power_state);
+	kfree(smu_dpm->dpm_request_power_state);
+	smu_dpm->dpm_context = NULL;
+	smu_dpm->golden_dpm_context = NULL;
+	smu_dpm->dpm_context_size = 0;
+	smu_dpm->dpm_current_power_state = NULL;
+	smu_dpm->dpm_request_power_state = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 364358ad7566..60dc35933376 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -255,36 +255,18 @@ int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-int smu_v12_0_init_smc_tables(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *tables = NULL;
-
-	if (smu_table->tables)
-		return -EINVAL;
-
-	tables = kcalloc(SMU_TABLE_COUNT, sizeof(struct smu_table),
-			 GFP_KERNEL);
-	if (!tables)
-		return -ENOMEM;
-
-	smu_table->tables = tables;
-
-	return smu_tables_init(smu, tables);
-}
-
 int smu_v12_0_fini_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	if (!smu_table->tables)
-		return -EINVAL;
-
 	kfree(smu_table->clocks_table);
-	kfree(smu_table->tables);
-
 	smu_table->clocks_table = NULL;
-	smu_table->tables = NULL;
+
+	kfree(smu_table->metrics_table);
+	smu_table->metrics_table = NULL;
+
+	kfree(smu_table->watermarks_table);
+	smu_table->watermarks_table = NULL;
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
