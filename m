Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DF0C433F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E94E21582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hChYVzHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E94E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCDC89935;
	Tue, 14 Jul 2020 08:07:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D717089932
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSvYLMZGX3SPymfQw4m6kVXWYT1MIwGAFvxubHnUCNR7Sc53/aQ5iYWv6+aDuAmm7wCBl9Gm23fP0EDtH744inKN0QZp8V1oTEK2L4ZGk0BUpmZ2pun+1fJYj2ctJFNHWOgshnHmKGynuPJWOWjr3g5aBH5ZPrGZ7qc8Kh8AzCCBpQShV4bhJO4Wia0MocuRuMks/ed5sEmc9oWgueaC6QY4JY+3Rebu2z2pFwvFkeoEZK8MMVYfQgZ8qfzbahrp9SYa2gFQ2l44cZbascMCEDWS3QXLHygLiadyE01Rxpj/CGA63Sjc1UShRkJ9pA26GdqyhSOEHPu5cctj6eQVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/AAY/jSJOwVPQUUuecKiIxiXlnBh2CBNBrnoLxYKdY=;
 b=T0lyNjjQXlYnlABbHLadti1SamsanMZg4sOXHR0pdZsPf/vaerBRZXdYjKbiVh6ePGE+VVhHnhPUXEZYgWMW7UoRdduChs6dNQWGKCGqa7KfxVGtSIEfikED/HHfzOZuTlL1f1tR/4ptP/wXL5LpZmKrbJvaLooD02yI5iqjqX79jhtxtGrF+GLmdZ+1QhbWwvq2PD8+NFWlVdZ3hz0H/Xu8WeGar1LXu934Y28rZ282Z4dNjVI72bfI2z0IVGv3oRm+9kYtuyUYAEzsmncPKQwxvaQCuB+aPr9v1X8gQ2LdcbnarJrRT7vBNyCm3OdQsqowGbevGHd0+PFGzUfYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/AAY/jSJOwVPQUUuecKiIxiXlnBh2CBNBrnoLxYKdY=;
 b=hChYVzHLL6+xjwwX6na6lRAWCOfmbPp2YRfBAGnOZr9igCN9W3rRyE2y8ZhTOP/LiBRqXkWWwQmu0u7+HuHFdBKESEjartRgCJLG06uaSjKxvgg03CREfEUkbYVEyfU60S0EXj2Km+UFdeMDKU/f47VX0UCImH81s1cIThP6gAA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.24; Tue, 14 Jul 2020 08:07:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:07:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/17] drm/amd/powerplay: move table setting common code to
 smu_cmn.c
Date: Tue, 14 Jul 2020 16:04:11 +0800
Message-Id: <20200714080416.6506-12-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:07:02 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f6e0ff7-59f1-4e28-98f2-08d827cce465
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121AB3526D719963E81CD1FE4610@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: intw/yK0vagrrh6ortcJPTw7S4zJENIdqr+IZQexdRR57nC3qd0pf1+gjjZkeQOPJnhQIFx6u0eQl5M9xgB/m2jnTGcWCN9X0UK/+IQCe61OSgT+mNuhOZLaP7LoRjI23r0CAS+CQVR/dZpZTZVBgEHWe/ikMPrlnWFHehssmgVyaMIVjYtC7j0xEZXII7Ug/Bm6Xa9qrAlRY4t/pCwTrCr2BfD+CIcB0nSPsEI+Pf9HXPqy4cbKv/74Iix4szm8UrGi13XtJ1EDcTBNG0sbE9LBWu4Q2MnPAHT8zbqxY3zhDXzsh5G15LOzcJtAINWO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(36756003)(19627235002)(6486002)(6916009)(8676002)(8936002)(2906002)(186003)(44832011)(7696005)(4326008)(956004)(16526019)(83380400001)(30864003)(1076003)(86362001)(6666004)(2616005)(66556008)(66476007)(316002)(66946007)(478600001)(52116002)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: c+6xBgOLo2UwAUMFFC2rc9ZEfclA1B9p9RK0dJ7ezNSyYPpiJM53O/nh5iH9y8A5bPhHVU22ShAK4j7dqq252uGHeMM6VEdppcrvQOvnM2HAUc2nZhiZ6/nyJHDSN8H2t0QpiRSQXzKYVrJV9tmb8lEVzjyzCTr2kKcrLDMHeRkNJ0HJRtfg/ppTP9rA12Zr+3hc1Zy8zMY9tSU9YNjgXZIfGO2pgjbeluaiOCyycK1RTM4LztPajct5kQWHqgbCb+7ehF77vhM/kK2ZuhkoFTC9YBHNbkwH2dcBGL6qdJ10222w7C1BEWlZsVk8ZmtzbHDR40Z4XpkxMV3/LWDCVM+nylcDmQVGIRDLKnICu90KOVdGJW9wuFL/E/vxldozaQNLQc1J64ddAmMdTdflkMiKbWWvAxE8WcqZW12Dmt9N7MHkZd8WUa1wNtv6gXPsfhOKtHL4OPHnqSnJJnoTEG85AuTapoL4hGStiHM0vBN++6nN+g2MUE3ijTVc2/bW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6e0ff7-59f1-4e28-98f2-08d827cce465
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:07:03.5418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L1HSVyxVJOfCZQnRekGvy9x8+fsCQvP7YKLbH6WKvQ1t9vM00YQh4/GcVs7yDrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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

As they are shared by all ASICs.

Change-Id: Ib5bda9adc519496904104225af9bfb6ece322186
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 41 -----------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 14 ++--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 16 ++---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  4 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 12 ++--
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 69 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       | 10 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 11 ---
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  2 +-
 11 files changed, 103 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5f13b97d0229..bc085e2302d4 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -208,47 +208,6 @@ int smu_get_power_num_states(struct smu_context *smu,
 	return 0;
 }
 
-int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
-		     void *table_data, bool drv2smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct amdgpu_device *adev = smu->adev;
-	struct smu_table *table = &smu_table->driver_table;
-	int table_id = smu_cmn_to_asic_specific_index(smu,
-						      CMN2ASIC_MAPPING_TABLE,
-						      table_index);
-	uint32_t table_size;
-	int ret = 0;
-	if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
-		return -EINVAL;
-
-	table_size = smu_table->tables[table_index].size;
-
-	if (drv2smu) {
-		memcpy(table->cpu_addr, table_data, table_size);
-		/*
-		 * Flush hdp cache: to guard the content seen by
-		 * GPU is consitent with CPU.
-		 */
-		amdgpu_asic_flush_hdp(adev, NULL);
-	}
-
-	ret = smu_send_smc_msg_with_param(smu, drv2smu ?
-					  SMU_MSG_TransferTableDram2Smu :
-					  SMU_MSG_TransferTableSmu2Dram,
-					  table_id | ((argument & 0xFFFF) << 16),
-					  NULL);
-	if (ret)
-		return ret;
-
-	if (!drv2smu) {
-		amdgpu_asic_flush_hdp(adev, NULL);
-		memcpy(table_data, table->cpu_addr, table_size);
-	}
-
-	return ret;
-}
-
 bool is_support_sw_smu(struct amdgpu_device *adev)
 {
 	if (adev->asic_type >= CHIP_ARCTURUS)
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 9b1b9bcf42fc..fbe2711591ad 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -526,7 +526,7 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 
 	if (!smu_table->metrics_time ||
 	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
 				       smu_table->metrics_table,
@@ -1214,7 +1214,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 			continue;
 
 		if (smu_version >= 0x360d00) {
-			result = smu_update_table(smu,
+			result = smu_cmn_update_table(smu,
 						  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 						  workload_type,
 						  (void *)(&activity_monitor),
@@ -1283,7 +1283,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu_version >=0x360d00)) {
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 				       WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor),
@@ -1318,7 +1318,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 			break;
 		}
 
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 				       WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor),
@@ -1908,7 +1908,7 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
 
 	mutex_lock(&adev->smu.mutex);
 	/* Now read data starting with that address */
-	ret = smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req,
+	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req,
 					true);
 	mutex_unlock(&adev->smu.mutex);
 
@@ -1943,7 +1943,7 @@ static int arcturus_i2c_eeprom_write_data(struct i2c_adapter *control,
 	arcturus_fill_eeprom_i2c_req(&req, true, address, numbytes, data);
 
 	mutex_lock(&adev->smu.mutex);
-	ret = smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	ret = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
 	mutex_unlock(&adev->smu.mutex);
 
 	if (!ret) {
@@ -2265,7 +2265,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.setup_pptable = arcturus_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
 	.check_fw_version = smu_v11_0_check_fw_version,
-	.write_pptable = smu_v11_0_write_pptable,
+	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 366ab73ee83a..547797e42992 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -727,9 +727,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 
-int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
-		     void *table_data, bool drv2smu);
-
 bool is_support_sw_smu(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_sys_get_pp_table(struct smu_context *smu, void **table);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 70274552e3af..6f1377282ce3 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -159,8 +159,6 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
 
 int smu_v11_0_check_fw_version(struct smu_context *smu);
 
-int smu_v11_0_write_pptable(struct smu_context *smu);
-
 int smu_v11_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v11_0_set_tool_table_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 9f036971e4cd..8fd1dcdfed95 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -488,7 +488,7 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time ||
 	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
 				       smu_table->metrics_table,
@@ -1397,7 +1397,7 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 		if (workload_type < 0)
 			return -EINVAL;
 
-		result = smu_update_table(smu,
+		result = smu_cmn_update_table(smu,
 					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
 					  (void *)(&activity_monitor), false);
 		if (result) {
@@ -1468,7 +1468,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor), false);
 		if (ret) {
@@ -1512,7 +1512,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 			break;
 		}
 
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor), true);
 		if (ret) {
@@ -1635,7 +1635,7 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 	/* pass data to smu controller */
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-		ret = smu_write_watermarks_table(smu);
+		ret = smu_cmn_write_watermarks_table(smu);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
 			return ret;
@@ -1956,7 +1956,7 @@ static int navi10_set_default_od_settings(struct smu_context *smu)
 		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	int ret = 0;
 
-	ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
+	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
 		return ret;
@@ -2090,7 +2090,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
 		navi10_dump_od_table(smu, od_table);
-		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
+		ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
 			return ret;
@@ -2288,7 +2288,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.setup_pptable = navi10_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
 	.check_fw_version = smu_v11_0_check_fw_version,
-	.write_pptable = smu_v11_0_write_pptable,
+	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 33990a107117..9289df9b7d8a 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -135,7 +135,7 @@ static int renoir_get_metrics_table(struct smu_context *smu,
 
 	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
-		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
+		ret = smu_cmn_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
 		if (ret) {
 			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
@@ -865,7 +865,7 @@ static int renoir_set_watermarks_table(
 	/* pass data to smu controller */
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-		ret = smu_write_watermarks_table(smu);
+		ret = smu_cmn_write_watermarks_table(smu);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
 			return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index fc9ed1c50cf7..6b4faf4c888c 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -393,7 +393,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time ||
 	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
 				       smu_table->metrics_table,
@@ -1190,7 +1190,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 		if (workload_type < 0)
 			return -EINVAL;
 
-		result = smu_update_table(smu,
+		result = smu_cmn_update_table(smu,
 					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
 					  (void *)(&activity_monitor), false);
 		if (result) {
@@ -1261,7 +1261,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor), false);
 		if (ret) {
@@ -1305,7 +1305,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 			break;
 		}
 
-		ret = smu_update_table(smu,
+		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor), true);
 		if (ret) {
@@ -1428,7 +1428,7 @@ static int sienna_cichlid_set_watermarks_table(struct smu_context *smu,
 
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-		ret = smu_write_watermarks_table(smu);
+		ret = smu_cmn_write_watermarks_table(smu);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to update WMTABLE!");
 			return ret;
@@ -2408,7 +2408,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.setup_pptable = sienna_cichlid_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
 	.check_fw_version = smu_v11_0_check_fw_version,
-	.write_pptable = smu_v11_0_write_pptable,
+	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 814c21ca2edc..7f5439c649bc 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -440,3 +440,72 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_cmn_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument,
+			 void *table_data,
+			 bool drv2smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table *table = &smu_table->driver_table;
+	int table_id = smu_cmn_to_asic_specific_index(smu,
+						      CMN2ASIC_MAPPING_TABLE,
+						      table_index);
+	uint32_t table_size;
+	int ret = 0;
+	if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
+		return -EINVAL;
+
+	table_size = smu_table->tables[table_index].size;
+
+	if (drv2smu) {
+		memcpy(table->cpu_addr, table_data, table_size);
+		/*
+		 * Flush hdp cache: to guard the content seen by
+		 * GPU is consitent with CPU.
+		 */
+		amdgpu_asic_flush_hdp(adev, NULL);
+	}
+
+	ret = smu_send_smc_msg_with_param(smu, drv2smu ?
+					  SMU_MSG_TransferTableDram2Smu :
+					  SMU_MSG_TransferTableSmu2Dram,
+					  table_id | ((argument & 0xFFFF) << 16),
+					  NULL);
+	if (ret)
+		return ret;
+
+	if (!drv2smu) {
+		amdgpu_asic_flush_hdp(adev, NULL);
+		memcpy(table_data, table->cpu_addr, table_size);
+	}
+
+	return ret;
+}
+
+int smu_cmn_write_watermarks_table(struct smu_context *smu)
+{
+	void *watermarks_table = smu->smu_table.watermarks_table;
+
+	if (!watermarks_table)
+		return -EINVAL;
+
+	return smu_cmn_update_table(smu,
+				    SMU_TABLE_WATERMARKS,
+				    0,
+				    watermarks_table,
+				    true);
+}
+
+int smu_cmn_write_pptable(struct smu_context *smu)
+{
+	void *pptable = smu->smu_table.driver_pptable;
+
+	return smu_cmn_update_table(smu,
+				    SMU_TABLE_PPTABLE,
+				    0,
+				    pptable,
+				    true);
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index 9b1d2e9c1799..214e7787559a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -59,4 +59,14 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 			    uint32_t *if_version,
 			    uint32_t *smu_version);
 
+int smu_cmn_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument,
+			 void *table_data,
+			 bool drv2smu);
+
+int smu_cmn_write_watermarks_table(struct smu_context *smu);
+
+int smu_cmn_write_pptable(struct smu_context *smu);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 323eb8a09c1f..4bf07a4ec853 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -769,17 +769,6 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v11_0_write_pptable(struct smu_context *smu)
-{
-	struct smu_table_context *table_context = &smu->smu_table;
-	int ret = 0;
-
-	ret = smu_update_table(smu, SMU_TABLE_PPTABLE, 0,
-			       table_context->driver_pptable, true);
-
-	return ret;
-}
-
 int smu_v11_0_set_min_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 7964f14536bd..364358ad7566 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -293,7 +293,7 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
 }
 
 int smu_v12_0_mode2_reset(struct smu_context *smu){
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
