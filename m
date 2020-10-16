Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9CC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C692078A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ji7v+emt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C692078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0645C6EA80;
	Fri, 16 Oct 2020 03:28:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9C86EA80
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeX9UxiCFh+yjjm21LD4E1wWckGRRluHGEoqPLPL//obXxbFwQMtWpCW4b15maMllbJCi2N/uQfbHAcCQvKIDz1GdT5kmXmXfi+1xGMqabFk+WRuI6/kgjleH/GlLKjs1k8eIP4Mh8OjgwCmkOO9xYQam6ZhGvr79uQIRFQAh4ha++qEjmCYg8DUQx74qXod7ykYexfAHLtcDDX3fBDhCFG2rBjrZGsUCkusLYo/umR8u8CV22S2do7drj3gMUijOcBpIPcNHQtLH3BfbQWWYrtiVM/s6aScGbG6ssLjzsfp3gOcQxklEJ/x7loDbTjn/6Nq4jdghjYLNeH5KlWfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH5jsuJaN0xdfJt6O5Lsr1uYdtdAszK7G/k2c8t/w0s=;
 b=ZVGw9D7CherVCFMOSe2bCxDJpb3JV1PPxNB397Bg5XQNI6FblUboSF1yKzZv2F84XjmZgZcg2QUX4vQA85k+0OoxRwePlcAU5gqipEog2+xS8tcGHAOZrb1MQhvMnASi8EjhoNZYeZMnynoP5UNqPcqcuQc7N9cNE7YNGVqW+T8I68TSQJ8et/fmPIx2WbcIt/xaymfkyQGLA6fODtKBgz3ngtle2f2C+d9Xupp6pnrG1x7gd0CV0kQk32zBuwWOGQDHkdyB8MbswDFhtf1eXUSdscHje0ZYwKyz5fIKlCimbjamODDHUILFwy1Q/bY3LDsatpKQqUriPygDWpHnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH5jsuJaN0xdfJt6O5Lsr1uYdtdAszK7G/k2c8t/w0s=;
 b=Ji7v+emtygTaVW29eOdlvu0Bi99phgwveXcO61YwBgca1MB14z/uDWt/w9AW9Zh79NHMkd7Yct2/FD+6fZP3PkKdomXTIfs+S5IWb8MIRMdQXUWNwu7CuPj4AxNpkpptC3aYY+mBbqKKwA5zGm9eVkk9oK+Hkv80o/h0d4kilPc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/40] drm/amd/pm: add mc register table initialization
Date: Fri, 16 Oct 2020 11:26:32 +0800
Message-Id: <20201016032652.507-21-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffb8e322-0d7f-4211-6a85-08d87183802b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13544009CA37DF1F7F268D7DE4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1D9UXDvlP2WwQw+siIdXxl2izsgm7XjHcwGfctXg2C2sLOQ4YIFfyVRyTe9rZ1fyLI2dNzhIFY7pHSk2N6WcDJLSTROi1gBWPKqrN8DxyGUSrHlruWB2Fz0hu0VbQnybVhB+1GFtaRU5n3ZrY6T0SHrELfeVYtWyVqj6sSMDaGvUi+Y5MU7XvmAoXs70k5UCywGpKLW/f5h3aDE6kbFLvoSFtXIvOhdCd1dSwY9U8MUMDt3bI+WXaaO0XifpJLNVGRHokoXSefgdDAbsTwWbBy5YY/R2heCc1MD4JK0tQaTEXIbCKdisdCLnUQBygNdp45Zbi11pxUffm5vmecFKllxZrh5/2NPNMIPqX/SPD+DSfuQKKCkey97U/B67bDX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RDEx0hbI0MjIO3TUhnKCHNuENQ+oIeLcS6XAPz37WWpEQBhAsYct3izQAdRg0OX9HHc3brIJxoHH8hqnA7EcjMeu1Cb6Rf+Ntb5DhYTOwPw2qCEogyHGcqMrC7aS2yvL4aVRMot7wSH1pHdY0LEJiMrtl6i03lzntJj6+dQrIZeX9fxpA7wObjV5HVdviP7E6R6BsKaQTl1/EQ/y8mJ2TbIMAxvzMc+oq5Q5nBALzSC7BKFoABVVRSiWsi+8fp/PrVubGSVfxNgmUy5ywqzKz95c0oOqAuo5yb0cZ/H6MCgq4cXWO9HdFQbHtPuLvQb0TM7z0bxM7xi1FZuz0Zls3xvN69fF9fJZdws8FABUDOe5+mXFjh0q4YwaaM+EfU3LSa6PKqaeQ5glS1KxVDRcAK13JyCb3tPE7p8H3HGxZU3OcBlKFEiqu/QoGe708Mw6YgckF5R/r+OmysQb5y9BImqREjCJ7JxDbQ7PmQhVA6b6EeLtnPIGVImZlMA0e9b4vqKo5+A7naGiWai6z0J2+wfO21SMfR6cdJHa+nrEzJHtQLjCDUQzcQr8rNIAI5jiqBOexgNU52GYbm12ymaqKOTCCKtW/1SRb62hFUcxr3jqcmfm08cHxshILs206f3xWgo+NyWju9/79IwbjqWTaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb8e322-0d7f-4211-6a85-08d87183802b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:07.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XStsISbndmNOhZmP8xUdz+cPPb7iT3dJHdHr75qXHrzivGw7xK8+o1FsPlyXDf+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add mc register table initialization.

Change-Id: I38a17c2f2747e5ef736c5dc55a84ee4e34d114b8
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 37 +++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.h   |  1 +
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 19 ++++++++++
 .../pm/powerplay/smumgr/polaris10_smumgr.h    |  1 +
 4 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 3aaf2d64cd98..0d8a693b77e0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -166,6 +166,43 @@ int atomctrl_initialize_mc_reg_table(
 	return result;
 }
 
+int atomctrl_initialize_mc_reg_table_v2_2(
+		struct pp_hwmgr *hwmgr,
+		uint8_t module_index,
+		pp_atomctrl_mc_reg_table *table)
+{
+	ATOM_VRAM_INFO_HEADER_V2_2 *vram_info;
+	ATOM_INIT_REG_BLOCK *reg_block;
+	int result = 0;
+	u8 frev, crev;
+	u16 size;
+
+	vram_info = (ATOM_VRAM_INFO_HEADER_V2_2 *)
+		smu_atom_get_data_table(hwmgr->adev,
+				GetIndexIntoMasterTable(DATA, VRAM_Info), &size, &frev, &crev);
+
+	if (module_index >= vram_info->ucNumOfVRAMModule) {
+		pr_err("Invalid VramInfo table.");
+		result = -1;
+	} else if (vram_info->sHeader.ucTableFormatRevision < 2) {
+		pr_err("Invalid VramInfo table.");
+		result = -1;
+	}
+
+	if (0 == result) {
+		reg_block = (ATOM_INIT_REG_BLOCK *)
+			((uint8_t *)vram_info + le16_to_cpu(vram_info->usMemClkPatchTblOffset));
+		result = atomctrl_set_mc_reg_address_table(reg_block, table);
+	}
+
+	if (0 == result) {
+		result = atomctrl_retrieve_ac_timing(module_index,
+					reg_block, table);
+	}
+
+	return result;
+}
+
 /**
  * Set DRAM timings based on engine clock and memory clock.
  */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index c6276ab073b7..3ef3ccfa6aa7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -299,6 +299,7 @@ extern uint32_t atomctrl_get_mpll_reference_clock(struct pp_hwmgr *hwmgr);
 extern int atomctrl_get_memory_clock_spread_spectrum(struct pp_hwmgr *hwmgr, const uint32_t memory_clock, pp_atomctrl_internal_ss_info *ssInfo);
 extern int atomctrl_get_engine_clock_spread_spectrum(struct pp_hwmgr *hwmgr, const uint32_t engine_clock, pp_atomctrl_internal_ss_info *ssInfo);
 extern int atomctrl_initialize_mc_reg_table(struct pp_hwmgr *hwmgr, uint8_t module_index, pp_atomctrl_mc_reg_table *table);
+extern int atomctrl_initialize_mc_reg_table_v2_2(struct pp_hwmgr *hwmgr, uint8_t module_index, pp_atomctrl_mc_reg_table *table);
 extern int atomctrl_set_engine_dram_timings_rv770(struct pp_hwmgr *hwmgr, uint32_t engine_clock, uint32_t memory_clock);
 extern uint32_t atomctrl_get_reference_clock(struct pp_hwmgr *hwmgr);
 extern int atomctrl_get_memory_pll_dividers_si(struct pp_hwmgr *hwmgr, uint32_t clock_value, pp_atomctrl_memory_clock_param *mpll_param, bool strobe_mode);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index fad6ffb470ba..c4590a43a4f7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -2522,6 +2522,24 @@ static int polaris10_process_firmware_header(struct pp_hwmgr *hwmgr)
 	return error ? -1 : 0;
 }
 
+static uint8_t polaris10_get_memory_modile_index(struct pp_hwmgr *hwmgr)
+{
+	return (uint8_t) (0xFF & (cgs_read_register(hwmgr->device, mmBIOS_SCRATCH_4) >> 16));
+}
+
+static int polaris10_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
+{
+	int result;
+	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
+	pp_atomctrl_mc_reg_table *mc_reg_table = &smu_data->mc_reg_table;
+	uint8_t module_index = polaris10_get_memory_modile_index(hwmgr);
+
+	memset(mc_reg_table, 0, sizeof(pp_atomctrl_mc_reg_table));
+	result = atomctrl_initialize_mc_reg_table_v2_2(hwmgr, module_index, mc_reg_table);
+
+	return result;
+}
+
 static bool polaris10_is_dpm_running(struct pp_hwmgr *hwmgr)
 {
 	return (1 == PHM_READ_INDIRECT_FIELD(hwmgr->device,
@@ -2648,6 +2666,7 @@ const struct pp_smumgr_func polaris10_smu_funcs = {
 	.populate_all_graphic_levels = polaris10_populate_all_graphic_levels,
 	.populate_all_memory_levels = polaris10_populate_all_memory_levels,
 	.get_mac_definition = polaris10_get_mac_definition,
+	.initialize_mc_reg_table = polaris10_initialize_mc_reg_table,
 	.is_dpm_running = polaris10_is_dpm_running,
 	.is_hw_avfs_present = polaris10_is_hw_avfs_present,
 	.update_dpm_settings = polaris10_update_dpm_settings,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.h
index 1ec425df9eda..6f4c48ac34b8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.h
@@ -60,6 +60,7 @@ struct polaris10_smumgr {
 	struct polaris10_range_table                range_table[NUM_SCLK_RANGE];
 	const struct polaris10_pt_defaults       *power_tune_defaults;
 	uint32_t               bif_sclk_table[SMU74_MAX_LEVELS_LINK];
+	pp_atomctrl_mc_reg_table             mc_reg_table;
 };
 
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
