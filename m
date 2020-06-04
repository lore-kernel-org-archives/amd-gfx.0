Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D56C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7E02072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M6qCXsn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7E02072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C733F6E16F;
	Thu,  4 Jun 2020 04:47:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B9E6E16F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3O8cztcB61NLvkymANrsGZJye7bqxpuXxbotWwX4qz6B65Y8FPCOch9Pscjd+OM5az4BpvpAR2TkHzmWnTyH4xVvmq0DGzNd4MM9Di7w63P3fibU464JmIZehYAFIsYecmNGPUBVNZDjv3eXUCa/sExb/akXPx9rOgTM8y2hTOD4sFZphn0MBm4uGXvQ+t/SllWmIGJ3b3Sfu8YdrzO01TJKAChvDl/ynxqEhmOjYhLYUGve2WmagOBVHJKQXe0G4uK9XCDsoLNZdte5zdgU+GRRQ52ZBeI6B9QDvcvowUFTeOA4VoUBDc1tWOr2bPL4Z2dgq1vUyE3ZmzDzR73Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIZPAgyJ7NlC14/WU3MVx3AkxZrrYqR90O7u/xqaMuA=;
 b=Ff1dJvhWkw7vR/y4JdiwupkxTTmXn//6g41sYgni/0XNug1MV/1o9nKgFeROfLjcA9s58FtM0xxEjj6N/Hty+zAkM9lz13Zd/ZhJFsvCFcjhGaz1CHBTlmYjLqVWs7pefC4pJrgLXckW6Kio7ThAY2kaYJV7KN21SNsWXI8VkN6PwOebdSOciCcCZcwXhA8O9EVnKpwmX/r2TCLdJJA8OsJdZKnss3kfvUPWfKfBK6ZQCuibhqVwZC6HjcVExvtl8AK5K7QLW0OzHnuRZ7NVdqqIiLcxQnhUQ64gxi36vYqsBykm+L+9lQsxGI9fcfKr0Em0MvTxhBEOHH/QRgBTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIZPAgyJ7NlC14/WU3MVx3AkxZrrYqR90O7u/xqaMuA=;
 b=M6qCXsn8+WwpcCot/dun001rxKN3YnuJ6lurzxy8EVVn81yrD1X/5ECE5vNKUawDwbKoaSbKcCNMGArXa6xmi9cHTZx0ncCOV2GkajFbpx4ykY8XKP9PBfykvZ7BnjvHIwSW6/779b7tj3RJ4pww0l99GA+XJLn+05gRqJ/C8VA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:47:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:02 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/16] drm/amd/powerplay: clean up the APIs for bootup clocks
Date: Thu,  4 Jun 2020 12:46:08 +0800
Message-Id: <20200604044619.18658-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ab65764-a9c9-4da5-cb15-08d80842529e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3002956CBA35D5C85555F585E4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcJ0WdXaAE5mb/e7eYsLihYj/PUw7MltDWQ2vVOaIMPeg37R5pqncvmuTd8A6tTSYEO2cLt7EsXrIzMisO+lsAjTrIk0wiG1f1GalGucclclSZGLmc/6WJMrkbF+X3ekXHN1Y6eLNQGmfZFx4gT6DsBFKAPGD+5f7NooLdKFfIsxyOpgX0caP2V3AOHoPm4dA+x3aYqGfKwKO3KvINv4/DDaDqTW05wqbPh37tv1hP6xJVvLmn7StLEKq2GtIdUSj2n/cnPL/TR4/UgixfUO5k/RoDWKaA0N4hbK/dTLgdf+MwI7cXfueLRDXDiOIxlW9Lxlxli2CUBNnB5/ppUvPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(2616005)(30864003)(26005)(316002)(16526019)(83380400001)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1Zyb5Ir2J6qyVRMkt7mm/qvm2KWlTtyXC3enMeuavlpFJr6hzU3qFqLsuWQoJQzHbNdt6EIG8gf5V/uXKdbU+vCfdTh/UTaxWhcD9XH8mw3xHfHuhnUa/Tr3aWVQJTF/WjGtcAptXqv5qWffVu4lc8cgrZLyh7wEADOOGj73gktQQOIEasNDds5z6/ZVPmPKuDJvdsmQZE9/foTAQlopBV+luhvZkNrcff/Rl6tFpu67p0iFiZ1j3uUDg1bKo5481gQDMuwLD0QTl7Qdr1DukqLjv57NIaMuQebmrdl6NHwaK30gg7LcF8r1KuT1MI69BjTA66+UUciagf/9ba126IllGgU16l65OR97JaiBF09Jf+duwAa3b5TCJLFadU6TuQfYsUGKAAdfrUs2RjJs2XgIAvNnd703WK5fEaG5Wkfo4ArEoIDCAPDEkk57yvbHpH/e1l/K7RMR9/Z9N8hItWO1GMYzWPjPrXNwVcByXCsusbTBIFZoDspf2ceqMD60
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab65764-a9c9-4da5-cb15-08d80842529e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:02.1456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z03seyc+D9X7zcj7gaTyHGUG0xLFqFFIRcQOINOUWd4ZSduFhNDt6IyvoXp3+HLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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

Combine and simplify the logics for retrieving bootup
clocks.

Change-Id: Ifca28c454f3769dece0cc705ba054ff34db0ab60
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |   4 -
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |   1 -
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   1 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   1 -
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |   1 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |   2 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 141 +++++++-----------
 8 files changed, 51 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 0e459186a2bf..b2dad4d09d88 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1114,10 +1114,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		ret = smu_get_clk_info_from_vbios(smu);
-		if (ret)
-			return ret;
-
 		/*
 		 * check if the format_revision in vbios is up to pptable header
 		 * version, and the structure size is not 0.
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1de5304d12bf..747fdd315575 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2457,7 +2457,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = smu_v11_0_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.get_clk_info_from_vbios = smu_v11_0_get_clk_info_from_vbios,
 	.check_pptable = smu_v11_0_check_pptable,
 	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 210432187ceb..cab64f896c4b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -506,7 +506,6 @@ struct pptable_funcs {
 	int (*check_fw_status)(struct smu_context *smu);
 	int (*setup_pptable)(struct smu_context *smu);
 	int (*get_vbios_bootup_values)(struct smu_context *smu);
-	int (*get_clk_info_from_vbios)(struct smu_context *smu);
 	int (*check_pptable)(struct smu_context *smu);
 	int (*parse_pptable)(struct smu_context *smu);
 	int (*populate_smc_tables)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 4682a2fd4381..79736b1e3506 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -162,8 +162,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v11_0_get_clk_info_from_vbios(struct smu_context *smu);
-
 int smu_v11_0_check_pptable(struct smu_context *smu);
 
 int smu_v11_0_parse_pptable(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a43c16befffd..85c7cceef9dc 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2319,7 +2319,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = smu_v11_0_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.get_clk_info_from_vbios = smu_v11_0_get_clk_info_from_vbios,
 	.check_pptable = smu_v11_0_check_pptable,
 	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index f83df6adcbce..3405bdcbfbd9 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2457,7 +2457,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = smu_v11_0_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.get_clk_info_from_vbios = smu_v11_0_get_clk_info_from_vbios,
 	.check_pptable = smu_v11_0_check_pptable,
 	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index c9440c978402..496a401615c6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -47,8 +47,6 @@
 
 #define smu_get_vbios_bootup_values(smu) \
 	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
-#define smu_get_clk_info_from_vbios(smu) \
-	((smu)->ppt_funcs->get_clk_info_from_vbios ? (smu)->ppt_funcs->get_clk_info_from_vbios((smu)) : 0)
 #define smu_check_pptable(smu) \
 	((smu)->ppt_funcs->check_pptable ? (smu)->ppt_funcs->check_pptable((smu)) : 0)
 #define smu_parse_pptable(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 45d4fd2526eb..ef825327974c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -565,6 +565,32 @@ int smu_v11_0_fini_power(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v11_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
+					    uint8_t clk_id,
+					    uint8_t syspll_id,
+					    uint32_t *clk_freq)
+{
+	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
+	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
+	int ret, index;
+
+	input.clk_id = clk_id;
+	input.syspll_id = syspll_id;
+	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
+	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
+					    getsmuclockinfo);
+
+	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
+					(uint32_t *)&input);
+	if (ret)
+		return -EINVAL;
+
+	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
+	*clk_freq = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+
+	return 0;
+}
+
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 {
 	int ret, index;
@@ -623,102 +649,37 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 	smu->smu_table.boot_values.format_revision = header->format_revision;
 	smu->smu_table.boot_values.content_revision = header->content_revision;
 
-	return 0;
-}
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_SOCCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.socclk);
 
-int smu_v11_0_get_clk_info_from_vbios(struct smu_context *smu)
-{
-	int ret, index;
-	struct amdgpu_device *adev = smu->adev;
-	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
-	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.dcefclk);
 
-	input.clk_id = SMU11_SYSPLL0_SOCCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_ECLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.eclk);
 
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.socclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_VCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.vclk);
 
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_DCEFCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.dcefclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_ECLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.eclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_VCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.vclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_DCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.dclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_DCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.dclk);
 
 	if ((smu->smu_table.boot_values.format_revision == 3) &&
-	    (smu->smu_table.boot_values.content_revision >= 2)) {
-		memset(&input, 0, sizeof(input));
-		input.clk_id = SMU11_SYSPLL1_0_FCLK_ID;
-		input.syspll_id = SMU11_SYSPLL1_2_ID;
-		input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-		index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-						    getsmuclockinfo);
-
-		ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-						(uint32_t *)&input);
-		if (ret)
-			return -EINVAL;
-
-		output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-		smu->smu_table.boot_values.fclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-	}
+	    (smu->smu_table.boot_values.content_revision >= 2))
+		smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+						 (uint8_t)SMU11_SYSPLL1_0_FCLK_ID,
+						 (uint8_t)SMU11_SYSPLL1_2_ID,
+						 &smu->smu_table.boot_values.fclk);
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
