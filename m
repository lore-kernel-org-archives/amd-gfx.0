Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C6FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55602078D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c4w/MsWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55602078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDD16E092;
	Tue,  9 Jun 2020 10:10:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B86A6E092
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 10:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnH9fMgT3MrBwMlEYYxLQVvmQGHchSOLrG7d6eryZBRcrgF/6ds7VmCHKrEy0wxL8SCErXNF8zhOIzQaPFFfTQb0FB9VH1CIhN25cCa5DuoJWoQ7EGySFqlcQ+vaySQldnjpoCUVV+EGJMjJL+tpipWMLfgTM1DklPMH6CWlcEkZWNxGPEU1VAWRl8XrO7u94O9+MVy4pcQdLNKeqWcXCpZu5T6cdK5FX1ms4i7K+s6tq7Hz4hgYxIfpaKqfXjvCAYgukNJaV9+tNt27ZFINjJLnJKMm1d/BpjgQOoumkEYM0c/Jnq6rhaFyB4mh3d/b4DQHmOKJ8zX/4owGT+dUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn5mnhYaLzdfFoVmGIGu0ywLEm/f4rSzc0x159ua4jk=;
 b=J2F9uu2e+T9x23vcHD36ak5iMqx5AT4Jr/8rIL/hysugXHbf1Rb9qYEeEKp4sWPxYOC5xAb5VFyGTu7nbGs5W6D4KCQf31EWaLhr5m0DkXfeYaS6gk5i2eZjQ4m0XwMfre5zuYTBAHt2wf3MgxPM4Vh/gXdFhOz04v8qjW7PGwo37Hr6kzchnBzkmMcj7R0i19ScxmDlAXjCcuOoV8PWCCHa41OM649pHQpSrL/1cTpiK1saQ/korMpHClmT76Be8QmO253Di4qKmoIGo+aq0MqDCZxeRxboY1XjWrSuxlfsRC/Px4APF4yKHuTiRHzlIBkaEhNag/6KHJgjZoabwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn5mnhYaLzdfFoVmGIGu0ywLEm/f4rSzc0x159ua4jk=;
 b=c4w/MsWeExlGUJ/Df4qHmak92DCTv3cGdQcVbdrtqqROwJOkOZca9Up90ww4szqLm7KMsUMJx/AU861rjPrEoBjK+y+r1hX4dVQp11dY0SfahbCL2xYLFXBfQYV0N1obhdqVfjMPHAbe3M0pasAhyozrK6Bo53e/FUFX1CUA1fQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.22; Tue, 9 Jun 2020 10:10:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 10:10:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: drop unnecessary wrapper
 .populate_smc_tables
Date: Tue,  9 Jun 2020 18:09:53 +0800
Message-Id: <20200609100953.11866-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609100953.11866-1-evan.quan@amd.com>
References: <20200609100953.11866-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:d0::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0005.apcprd04.prod.outlook.com (2603:1096:203:d0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:10:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b5b4c55-215d-4c93-14a0-08d80c5d562a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595639F6FC6D98705D69BA4E4820@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:309;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRD0cpee+pSD5lu0hBDIJoe/46bajJ/gR1T8vJ/Dtb134RMoiaixnNF1oEYOvF1mD12Gc/sFDfNIhqnI5cm02phbRlu5R6NvkkUQ3xlExbh+82ZpAT5u/34TWKO/tEWGUW2yk0HhFjP1b770uGnsolOUNfaQ2erfzF/T3J/A0R315fKYncjFTMpR06JX3Y2WyYvVg6pX1vZ+v2ZQ1i211lHvn7A52joCjNfruXkf5kDQ2JY4gdptifbce5GTJGsO/sKLTO/+l6N+uexqiOIoAIZR9SF1TOaX+KV4O0esTIm796t+r01jlxRQHd5lIDpCH1p/gJ/TL3ONRj0pJkYEg0ZMqROvZHqgQKPhlaJnwvA+kfbEpXhIbt4zAnk1VOZv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(83380400001)(1076003)(6666004)(2906002)(5660300002)(478600001)(52116002)(316002)(7696005)(8676002)(36756003)(66556008)(86362001)(2616005)(4326008)(6486002)(66476007)(6916009)(956004)(8936002)(66946007)(16526019)(186003)(44832011)(26005)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +xnG7CYBjcMXvx1Af4k7U+q1s4RbBBI6IMMOtQL0UKwY764pQ+tCJ1UdNundVy6auEdZCz3URg53voqQo5Fkln6nEAvwDXkVyA4ussLNns2uzKofEZ2y2G5G8kE8xhPB+SzSkgnWM225VRmIHhNWj0GyeQDw+upEotu8jYgMEb/t4tCB+ATtPNc4ULJ/r5QhzyIzRo5WGa5TgzLS6fl0qUVWU0bUUaLSVEbO/XVKpMJOnt9x5EhuzJ72pzysQF5UpQW9zcau8RibSFzmU4bUfsJwBwVyXfIpsXnRNUN9PJCjCbcucIeWs99oCFo9AJ/cldQ7Dcb7XtwZLzRrFl+IYpaVxN+qggOGchdZAJ3tTiHopN78dkTclPn4oNOSwsdiHg5U7DGWGlEwMwJtdE8K7YRYpJz4wfeqHfJ7fOmpU+r5/2r3Rt5kgBVd5pZsocAMy44ZVT7ZuhP9LEl0/ummDSi/zA3ppt0izW0F7GC78oCOHXZkfsK/4Qkt1c3xgmGc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5b4c55-215d-4c93-14a0-08d80c5d562a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:10:29.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXAAggKC56X2IhDCd8KV6kBdqsGO//sYo0aQLX5TOm2tR3cpZ4o69SOpdfMr85+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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

Since .populate_smc_tables is just a wrapper of .set_default_dpm_table.

Change-Id: I80e89146359d6cf5d80f1887878d371b41b41cb0
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 2 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 1 -
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     | 1 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      | 2 --
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      | 2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 1 -
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 2 +-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h       | 2 --
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 9 ---------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          | 2 +-
 11 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 89dd12536d58..78263de02678 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -813,7 +813,7 @@ static int smu_late_init(void *handle)
 	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
 	 * type of clks.
 	 */
-	ret = smu_populate_smc_tables(smu);
+	ret = smu_set_default_dpm_table(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 96c9a348f8b3..ee492fc77414 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2587,7 +2587,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* pptable related */
 	.setup_pptable = arcturus_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 3420a58fad03..0d1429fc791b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -505,7 +505,6 @@ struct pptable_funcs {
 	int (*check_fw_status)(struct smu_context *smu);
 	int (*setup_pptable)(struct smu_context *smu);
 	int (*get_vbios_bootup_values)(struct smu_context *smu);
-	int (*populate_smc_tables)(struct smu_context *smu);
 	int (*check_fw_version)(struct smu_context *smu);
 	int (*powergate_sdma)(struct smu_context *smu, bool gate);
 	int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 9ccf62e99dcb..d6cd3d74dcfa 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -164,8 +164,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v11_0_populate_smc_pptable(struct smu_context *smu);
-
 int smu_v11_0_check_fw_version(struct smu_context *smu);
 
 int smu_v11_0_write_pptable(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 7fbebc1979cf..d29f75223987 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -72,7 +72,7 @@ int smu_v12_0_init_smc_tables(struct smu_context *smu);
 
 int smu_v12_0_fini_smc_tables(struct smu_context *smu);
 
-int smu_v12_0_populate_smc_tables(struct smu_context *smu);
+int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
 
 int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 				      uint32_t *feature_mask, uint32_t num);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index abbfcce6d9ad..ef04ab1eba94 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2423,7 +2423,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = navi10_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 6b5e60b4c039..f286c1e1934f 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -951,7 +951,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.gfx_off_control = smu_v12_0_gfx_off_control,
 	.init_smc_tables = smu_v12_0_init_smc_tables,
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
-	.populate_smc_tables = smu_v12_0_populate_smc_tables,
+	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
 	.get_enabled_mask = smu_v12_0_get_enabled_mask,
 	.get_current_clk_freq = smu_v12_0_get_current_clk_freq,
 	.get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 6a9d04cac240..9a05fda05355 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2593,7 +2593,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = sienna_cichlid_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 86c09098963a..03679eb21e0d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -45,8 +45,6 @@
 
 #define smu_get_vbios_bootup_values(smu) \
 	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
-#define smu_populate_smc_tables(smu) \
-	((smu)->ppt_funcs->populate_smc_tables ? (smu)->ppt_funcs->populate_smc_tables((smu)) : 0)
 #define smu_check_fw_version(smu) \
 	((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_version((smu)) : 0)
 #define smu_write_pptable(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 5590dab46e8c..9e3fee9e4aca 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -750,15 +750,6 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v11_0_populate_smc_pptable(struct smu_context *smu)
-{
-	int ret;
-
-	ret = smu_set_default_dpm_table(smu);
-
-	return ret;
-}
-
 int smu_v11_0_write_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index f10113fc4571..5b56e7579ff4 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -319,7 +319,7 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
 	return 0;
 }
 
-int smu_v12_0_populate_smc_tables(struct smu_context *smu)
+int smu_v12_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
