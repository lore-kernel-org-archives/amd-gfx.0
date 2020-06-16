Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A6C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD1A2082F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jGryH5+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD1A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618156E7D4;
	Tue, 16 Jun 2020 07:06:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F786E7D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 07:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYC7lZ+tIrVh1fFKZYxEm6iwGQ8RYau6nyryv6VpgZ7xO54MdEBOLVEI0lKgk8N0MajUzkxRAFkQGwvNJNWEwJB1WAIpcFArwNodyjs+5qKoN6p6H05IiKMHkB10vRqiCFzKUbeSv4D6+4N3KkdER9apNM0aa45OJnMnDCHu93lztTQT6MW+ywKWhjPvknUmvOaAtv/8nZV6DKIupfedvGTORqFKgiEmnWrkGz1tXsOsx7FKe2YTqYGAvoUPR+e3sj+MdF5r9bKoCnOsFaKvlBhPUV/f4T88EIHLNw+0q0QrA88WKwB5Tob/cpPqWkfTHlIZjSPEgHLNQdOhjPllcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baXRuz4oY67e2xxGBdQN1IhIFdO4GoRz6S6vvwdC0Mg=;
 b=OfMFNMfOKgWfZbVszFd4PjEAB2swGzA49vb++9wSpABBNBYAFDSpLqFEH11qz59EX73WYMO9At05MeJpgD0K1rlV8Oedd+0L+7BXwbY5PTs/02aieMxcxBte1gGzHyMV1UdJg/K8e48yVPL+EGbxbM/QlFXeMchAbuTn5SBy3METKBdRqA2+mEdV5Qyw/p6ug7bc+8+Cr4Wd4UD5gFK0Tsz6QK66kexzesZBwNAUTnPA1GyHcRWOQGvY1ienrrQwiDowPvCs9HaQ8OdGBJaJcKbDqtRFspuzp6HNiPTmX528Ig2OBzO+0UfNANxBKfQrLArxVENG7oE/uBGaaf+K9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baXRuz4oY67e2xxGBdQN1IhIFdO4GoRz6S6vvwdC0Mg=;
 b=jGryH5+PYPZUGnDs6jt1Oy2nRrbCM1bCvdHz38RrC5iCpld9V+YKBbzW8mOt6EJE0JQdxUyaeXFPFRsFandrv1HNoz8H0Aw2iIpZQycbuecvBML9+Hl65N6VE6jSD0WAmWmQYO6NSGTThRSXScHsymVWXLH/33XR/uojzuajfdY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 07:06:17 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 07:06:17 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/smu: unify pptable_func{} callback interface
Date: Tue, 16 Jun 2020 15:05:45 +0800
Message-Id: <20200616070546.4190-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0207.apcprd02.prod.outlook.com (2603:1096:201:20::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Tue, 16 Jun 2020 07:06:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f7596c5-2770-4c6c-252b-08d811c3c366
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34853650E0A34FD94490EF95A29D0@MN2PR12MB3485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkbaSG7Mu/TqkwH3pxllUp6c4ukrgAhOLZ6Xi6LfFg7h+KHN8uDy3X6TBW2gfDnS6sA/kROa2iOU7QYRn+5OCrsRn+1CMA9n6Qnx5ZA0GUJYZGG4FOjbwRFGdSGOTIYlPgTq5xIm/d26J4k8Jb3jRpj8k+VnEnzl1BoPDFz7hvR2FMnKkMhklJPFpV5yw3GbQ/XpvLENs6HfvTPszltxkqi+ZZwOMr9RdLFoi0rPATO12DT3sy9fEGDfzDNt2wuRZDAnZTQZNBrhsnGrW1k3UHbzYDkDZpQlap0tHxvSzrHlV1oEzYl4830r0jJiDZI8Pp9v5YXmFy2wQVogtbnupRoth9bQQueT5fhDu3uoSAXNyqa7qMWI0r3pfYeBHUhn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(36756003)(66946007)(2616005)(956004)(6666004)(66556008)(66476007)(1076003)(8676002)(6916009)(26005)(86362001)(478600001)(186003)(7696005)(52116002)(5660300002)(16526019)(8936002)(6486002)(4326008)(316002)(2906002)(83380400001)(125773002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: B73Xt0xwZCHxSwp50fApjH94Z3WLGPdkS6c9mYyLqYx+N4yRgbyPr/On9VmAKerPmSem9nCRZtIhFi58UTuP4KshNxn7PENGdZQieT576dhlP1mnqDSzgSvLE0xmoMi1fjyoKA1JC8rlx7yjln7v5j72sV0E3A/iXvEcgmW3lzwv9eXXcbK4sslWf0sab0b7QsStYptDAYvbRGtlXIbDjRtPEHqa3aS6ZUYMpiLH6DFMNxOAzJlHnYJCcI0MvJzr19otOkuoOWG4yZXwasPF23KaDmPe9iEnzeXxhg2mf9ikUWoNpmGn5IC7appsKuwhF1EHjeuIZAkau2dkgm9LXP1GDl/SDgf5N7PZ4W35WlOt6aJpHDE1NkXk+/IrswY7g2X61C3bCzhAPGLuJI7SbqN7vKnQlsJRDxmNcmsG8+OhDHWfvtpg6HjwTT2X3ljI6kbq95CsZzsYpmLlUIVxW/6pnMPMqvTf1NvsKgsK6OMawQ0FatgTlwoZVpRUxslQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7596c5-2770-4c6c-252b-08d811c3c366
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 07:06:17.0489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jgCTJlHbBAV2SfhxoZK//m7sB0ZuRWY3hehHPMbekSyP2I/pxLRMC365CKKEBK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
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
