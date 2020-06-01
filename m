Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE0C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC7C206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qh+t8ZRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC7C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAEC6E192;
	Mon,  1 Jun 2020 07:31:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E39C6E188
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWVhcdFCip+TFJqDc+o72CM9y36kqGDPQDvib/VO1o/2fSa8nxFiAh4kJ2F6qo1qKq4SNk2akqnp8VO+PpFVmJI85rQKkm38h+VHB5aaRyxS9TgAIDXWwI89RMchgpQrQHnDXoKOMzo2+4bGFlXNYh+pN2+JqD2hzHkW+6LczB5abONlOUxbwfITCq6EVQ75gaUuv45IpWUNK30SwTWuzvf7A9tVV1yGe1SDbko4GyO89MFGQTq+4JpsE/Mkpz3WaAbt7hf9bsd1XkXZjJ03Zy6rlBw9LRSKCeov1mmTwdicT956WXN6HinFDqdJclEsSPjv6MLnbnXmmcwOmBIUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ28+9fE9o4vAtTtdGWSFxhKhAC7Ah9wgboC1FYvlx4=;
 b=WHioU8ygOg6LMyBZ57GaaBwOfFf1QEoQJhAdKxWe5URvIPu/Rv6/++5FIkkoZOMw7jLiDnAAiiLz9GpG4JGiKfCyJyoAXHVbqkPHa8T81x/66EaAX7ydpg2QpoWTLBkIWu1WsV7vhiKAb93wcDE1hhqeepQVQoLibfVjiTkfCitPWfvR9BuJLapP/FwMWF6qNQEO6P//3wOv/T+j1zIXQLYjNCsDq1Gh63rcypfrQ+Q6C7YDhr5VEAGCQ0HFcNNGckNx6l/NEkBL1IXnHc1nkrVxJN5h5MaIQgDusAvfp0b1KR4fhtcdRvjTiQY2GQ5Cl8QfrYRLDzf6Rh+6DpYVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ28+9fE9o4vAtTtdGWSFxhKhAC7Ah9wgboC1FYvlx4=;
 b=qh+t8ZRj5Bc6bmwVL+O6QpvIaUGRFk8esa529sBnO26OidXIjwYO8++zvp3lMTmcKnhZz9GqI2Vnih7JA3MSTKNTGclPdtn22aEdcsNtxB+Kspw36doC5hjyrGCu66ZhNHoIT1Y1TeKIRiEcHt3gQfWaVxOll7hZqCvm+vXFI6c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:31:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:31:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amd/powerplay: clean up the overdrive settings
Date: Mon,  1 Jun 2020 15:30:00 +0800
Message-Id: <20200601073003.13044-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:30:59 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9cf06948-675e-4969-f5a0-08d805fdbbb7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803D01AE59469BB22A2852DE48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cN3KuUSbR/10DPMU6S3v3FLxlmrCJIz2NU5Jt/WvL2V8zSE5xCR4G5RQNvZ3maRmtMIqRu5S4xSfSqSTXw9eFexMZ+Aucu4qOW1GONibXEwQpNBW1NY2xpQhlqLSapXxELNWw+vdwAXGE7qt/cM4uOv8gjnHR67H8Dx/VgRaFflBngNcE7I4LAgsDQcmHlsHcHkcwwfHVL1E/0jIr/lI31fxyJA+2/SK+eTsWkGdFb4p2mZ8SPtXIxP9pT8vJB8d424RdI5SH+pL5CeldyIt1ZKwBSjPy8vxK7qqtVApeXYOGxRwOyyO+Eikh0+CsIx12M9AKElzRGkQfNNymH6+mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(6666004)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mGwU3JJRwAP97XEokiDAPKaZtVPO9tE9kl4vtu18ndo0GY4VryEGB5pWXJAQLOFRVQT4Wj4eh4doY6GWCR6q/tHQLHyO1VcccjHwYTICz7uqQ8IeGdbuIlxQUIpmmipVU4SP91BfbvzFhtBleM786F2MUcp/R02Udzy7qU//mmGPH/Yar0ruTQ30/SnKPUbPreJO1LbgiJTlIPhukLSkh06/hqoDhdAMpyhdhP1uLdQIcDcYo/E5qsSZQ6cU5P+NE+sJZCbj90Uo8kuTRwtErr63ndMSrcBomrjtVtMljOz4uYXIz7ObfSEUa2Cd8hfLFrdSRw4z9wG3ljCNgxvQfZJtVTR4MFzM9VKCO+SK/pzaFRhQx/trpxBUdR3o4NOody2C4zf5iC/H97oQKktM0O65vJbpjATt8l6qGbbrlMsgVoX/NfccR8v7m43CjepM7fNXpLKVuiZhto2Aa2Kc1k1zHf6rl1Z7eY836YqbXdmEcpmaIItYDpZIP4aB+qU0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf06948-675e-4969-f5a0-08d805fdbbb7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:31:00.9713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3M+auqsCFKK0ulO6FfmZtgpg6ph+YOT8wPtsvBXzqbarTmDAK85JJpdHh5DscZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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

Eliminate the buffer allocation and drop the unnecessary
overdrive table uploading.

Change-Id: I8ba5383a330e6d5355cea219147500c1b4a43f47
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 74 +++++++++----------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  4 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 -----
 6 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b079ac6325d0..9b81b6519a96 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1215,7 +1215,7 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	ret = smu_set_default_od_settings(smu, initialize);
+	ret = smu_set_default_od_settings(smu);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 14f4a850b553..4aa63dc79124 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -480,7 +480,7 @@ struct pptable_funcs {
 					     uint32_t *value);
 	int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
 	int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
-	int (*set_default_od_settings)(struct smu_context *smu, bool initialize);
+	int (*set_default_od_settings)(struct smu_context *smu);
 	int (*set_performance_level)(struct smu_context *smu, enum amd_dpm_forced_level level);
 	int (*display_disable_memory_clock_switch)(struct smu_context *smu, bool disable_memory_clock_switch);
 	void (*dump_pptable)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 51868dc33238..8d317e05f65b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -258,8 +258,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 int smu_v11_0_override_pcie_parameters(struct smu_context *smu);
 
-int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize, size_t overdrive_table_size);
-
 uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
 
 int smu_v11_0_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index db38fb10524d..caa4355b601e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1969,55 +1969,49 @@ static bool navi10_is_baco_supported(struct smu_context *smu)
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
 }
 
-static int navi10_set_default_od_settings(struct smu_context *smu, bool initialize) {
-	OverDriveTable_t *od_table, *boot_od_table;
+static int navi10_set_default_od_settings(struct smu_context *smu)
+{
+	OverDriveTable_t *od_table =
+		(OverDriveTable_t *)smu->smu_table.overdrive_table;
+	OverDriveTable_t *boot_od_table =
+		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	int ret = 0;
 
-	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
-	if (ret)
+	ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
+	if (ret) {
+		pr_err("Failed to get overdrive table!\n");
 		return ret;
+	}
 
-	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
-	boot_od_table = (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
-	if (initialize) {
-		if (od_table) {
-			if (!od_table->GfxclkVolt1) {
-				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-										&od_table->GfxclkVolt1,
-										od_table->GfxclkFreq1);
-				if (ret)
-					od_table->GfxclkVolt1 = 0;
-				if (boot_od_table)
-					boot_od_table->GfxclkVolt1 = od_table->GfxclkVolt1;
-			}
-
-			if (!od_table->GfxclkVolt2) {
-				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-										&od_table->GfxclkVolt2,
-										od_table->GfxclkFreq2);
-				if (ret)
-					od_table->GfxclkVolt2 = 0;
-				if (boot_od_table)
-					boot_od_table->GfxclkVolt2 = od_table->GfxclkVolt2;
-			}
+	if (!od_table->GfxclkVolt1) {
+		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+								&od_table->GfxclkVolt1,
+								od_table->GfxclkFreq1);
+		if (ret)
+			return ret;
+	}
 
-			if (!od_table->GfxclkVolt3) {
-				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-										&od_table->GfxclkVolt3,
-										od_table->GfxclkFreq3);
-				if (ret)
-					od_table->GfxclkVolt3 = 0;
-				if (boot_od_table)
-					boot_od_table->GfxclkVolt3 = od_table->GfxclkVolt3;
-			}
-		}
+	if (!od_table->GfxclkVolt2) {
+		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+								&od_table->GfxclkVolt2,
+								od_table->GfxclkFreq2);
+		if (ret)
+			return ret;
 	}
 
-	if (od_table) {
-		navi10_dump_od_table(od_table);
+	if (!od_table->GfxclkVolt3) {
+		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+								&od_table->GfxclkVolt3,
+								od_table->GfxclkFreq3);
+		if (ret)
+			return ret;
 	}
 
-	return ret;
+	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
+
+	navi10_dump_od_table(od_table);
+
+	return 0;
 }
 
 static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type, long input[], uint32_t size) {
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 33086f94267a..0c7d5f0b1cd1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -70,8 +70,8 @@
 	((smu)->ppt_funcs->system_features_control ? (smu)->ppt_funcs->system_features_control((smu), (en)) : 0)
 #define smu_init_max_sustainable_clocks(smu) \
 	((smu)->ppt_funcs->init_max_sustainable_clocks ? (smu)->ppt_funcs->init_max_sustainable_clocks((smu)) : 0)
-#define smu_set_default_od_settings(smu, initialize) \
-	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu), (initialize)) : 0)
+#define smu_set_default_od_settings(smu) \
+	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu)) : 0)
 
 #define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
 	((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 7a97a4510c6d..891781a5c0d4 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1898,26 +1898,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 
 }
 
-int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize, size_t overdrive_table_size)
-{
-	struct smu_table_context *table_context = &smu->smu_table;
-	int ret = 0;
-
-	if (initialize) {
-		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
-		if (ret) {
-			pr_err("Failed to export overdrive table!\n");
-			return ret;
-		}
-	}
-	ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, true);
-	if (ret) {
-		pr_err("Failed to import overdrive table!\n");
-		return ret;
-	}
-	return ret;
-}
-
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level)
 {
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
