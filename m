Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F1DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242C02074D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hRldMw9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242C02074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3C86E082;
	Tue, 16 Jun 2020 10:29:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F246E082
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 10:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVHqqi3CV7UhrxGdfr9iAcmZ0yVYuQG1IZGMsmFXbog2cIPKoVTUhiNrFJd25l0InobfFb4JsDKFEWIDPh16Nk6y93beh2bB0ne431FjXK93S+2jE4E3OWg+PbfZiBvp2rz0ms4dsnTkPdHv9p77US+p0LQD6CuxNqLkM16QbTVQ/YY4gw7nFMbdlmacyRQgF5KmoHfFShAOz6wk+KAffI521JzRUvvZGBXBIw8eUrsbIF4FUOaetC7p1OQIQ3jv8b2DH2Ex7lmvMeAPp+IKB/NzI8HnJtsiQHc73q0fi3zEgJGfOij3svwOc8ZJSDYyGrb1nPIqMOcDT+A9cR/zvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baXRuz4oY67e2xxGBdQN1IhIFdO4GoRz6S6vvwdC0Mg=;
 b=NRcyyc6/aZxJlDCStajt/J8gics16Bat6ZAVD6Nx7szW6OzW+Zqvsiffyieb5ciVTr33A351KqnLhknyqmlibdkdzS8y+YU13O8Q1SSBLimBx3ayrOfLGCaviW86/fw94Qu95ZPQyzWiioQa+x2oQjqmxPCePQpXkVHD/fyZh+Sk80k5rIdKbcAdoWFPF9IAwkDhtPJpZh5dla/P+BGY9XZ+NirUMGZqom5/c47FnDzJmoiUNr6kQVXPeMRWU6VRcGZeJRB+7elUZtDY2XGqDrepcIAUMEu3hpL1QH0At4eIcWNylYG0JbtgAxqIXadoAElftkO8PeguLIbfajcCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baXRuz4oY67e2xxGBdQN1IhIFdO4GoRz6S6vvwdC0Mg=;
 b=hRldMw9jsDRlGYdhWvlr0eMfDCd5MQfJxI6WFqdpbaNNX5y9k2j/+kTH0CdE2zSKNMmyt2ABVoDTxOEdLYP4I9Mh5PLNhvTC0b3AFyCf2TQUIFY0tEybXrIkgKTRX6Ubz/DNA9Uox2P11Dps5szhppH49ILdWLfbmPMDakNkuZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:29:53 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:29:53 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/smu: unify pptable_func{} callback interface
Date: Tue, 16 Jun 2020 18:29:36 +0800
Message-Id: <20200616102937.12417-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:202:2e::33) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR06CA0021.apcprd06.prod.outlook.com (2603:1096:202:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Tue, 16 Jun 2020 10:29:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0a14beb-c97c-4cf7-eace-08d811e0349f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3024AFE9D61EA78EF408E0D2A29D0@MN2PR12MB3024.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yG9OFAHtH5hfZL3BrkDlxr2yt2juoyQqpBXDmOhrK+8Gdo6nAj6WhV30zEmacSbvLcNR7yXBYOQMSJdquZz9J1CGrPsWP2KHm5qtxTDF6cK4Rwwoc4mNO1GL329FxrSHJRtRoORVE9dNFPcutbH27WumFMT5MupaCZs6R5g4/rdBVuvoeP3dS5yOHb9UQt680MaGnHFFS0vJ4nrcmjFk60FpnShDNZsgpGcbcujxqbGA03InEiT/pKYnBHx3qA/RmcRXhSLAe6pAeqTSRDM0lR6U9CNxH8Hi9XRKE/epuO+A8AVoIuV8uBHS3YCipRdy3awOSkd5bw3vJLXIgeB0HA3toHsS0qAeZSzGP9vqe59smRUniKIr5+WmqLl2Hztq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(956004)(2616005)(4326008)(478600001)(83380400001)(1076003)(6916009)(5660300002)(316002)(66946007)(6666004)(66556008)(86362001)(66476007)(16526019)(52116002)(26005)(2906002)(8936002)(186003)(6486002)(36756003)(7696005)(8676002)(125773002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dllAXXtnxx00wsYHyOkvi/k5hvT0uzORvim6dIl9ZT9nYpfE/vHci/aLT7C0ITvu9ASVgLpHLZb0qvgwe6Bdyn+ZaozjAuZ1ciIDZK6jN21byFxBCshKeeCew/4zwBTnumiObsOdL9PhfjWSf4dQqJjFuGHZ4sjS9Rb7ryWycLnPIktLo8YE3SCpMXgOS53qS/dLL6/AQROAgXKyXaH/BqHrtOSUrRTNeNvsYfTOKHSCrOD7ES9f7/Px8htXZCc5j+sFeOFZ/UtEvDzGJpbw0S10NmDeTMGcHhl0SVvi+T+ooBVvpaolhKD8e2A35Sy31syRHzZAAA3698kDD6pwW46XfdiDpeq2YTrZFlfuNyXUSFc53V9yqOJkpVo4HxuUkwN0wlXwk8E0utmM53AKeHxGJaG3kvck+EPHx0qnhQhBjB51FtlIzrEIbWTTfyiiLn/JX+Om0XpLV4YTd4BUqF01qd1hHK3rdYPK577EL0/gVM8tbqnmsOT4kkF9kHBX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a14beb-c97c-4cf7-eace-08d811e0349f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:29:52.8785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfwu1WD+v7wnUDr28PXMbZqBmFRQB91G3YRjEAvNeYBp8Pzk3DuC1i1jkVEYpb+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the pptable_func callback sets should be has unify interface,
so use "smu" as the pptable_func interface first parameter.

fix interfaces:
1. i2c_eeprom_init
2. i2c_eeprom_fini

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   | 4 ++--
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 4 ++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 16a107cd8b2d..b27d0b18eafa 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2338,7 +2338,7 @@ static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)
 	return control->dev.parent == &adev->pdev->dev;
 }
 
-static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
+static int arcturus_i2c_eeprom_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
@@ -2360,7 +2360,7 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 	return res;
 }
 
-static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
+static void arcturus_i2c_eeprom_control_fini(struct smu_context *smu, struct i2c_adapter *control)
 {
 	if (!arcturus_i2c_adapter_is_added(control))
 		return;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 01afc8f07879..7b349e038972 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -491,8 +491,8 @@ struct pptable_funcs {
 	int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
 	int (*allow_xgmi_power_down)(struct smu_context *smu, bool en);
 	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
-	int (*i2c_eeprom_init)(struct i2c_adapter *control);
-	void (*i2c_eeprom_fini)(struct i2c_adapter *control);
+	int (*i2c_eeprom_init)(struct smu_context *smu, struct i2c_adapter *control);
+	void (*i2c_eeprom_fini)(struct smu_context *smu, struct i2c_adapter *control);
 	void (*get_unique_id)(struct smu_context *smu);
 	int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
 	int (*init_microcode)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 149f5e50e619..880ef54884f8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -200,9 +200,9 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
 
 #define smu_i2c_eeprom_init(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : 0)
+		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((smu), (control)) : 0)
 #define smu_i2c_eeprom_fini(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
+		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((smu), (control)) : 0)
 #define smu_get_unique_id(smu) \
 		((smu)->ppt_funcs->get_unique_id ? (smu)->ppt_funcs->get_unique_id((smu)) : 0)
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
